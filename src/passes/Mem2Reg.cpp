#include "Mem2Reg.hpp"
#include "IRBuilder.hpp"
#include "Value.hpp"

#include <memory>

void Mem2Reg::run() {
    // 创建支配树分析 Pass 的实例
    dominators_ = std::make_unique<Dominators>(m_);
    // 建立支配树
    dominators_->run();
    // 以函数为单元遍历实现 Mem2Reg 算法
    for (auto &f : m_->get_functions()) {
        if (f.is_declaration())
            continue;
        func_ = &f;
        if (func_->get_basic_blocks().size() >= 1) {
            // 对应伪代码中 phi 指令插入的阶段
            generate_phi();
            // 对应伪代码中重命名阶段
            rename(func_->get_entry_block());
        }
        // 后续 DeadCode 将移除冗余的局部变量的分配空间
    }
}

void Mem2Reg::generate_phi() {
    // TODO
    // 步骤一：找到活跃在多个 block 的全局名字集合，以及它们所属的 bb 块
    // 步骤二：从支配树获取支配边界信息，并在对应位置插入 phi 指令
    std::set<BasicBlock*> F;
    std::set<BasicBlock*> W;
    BasicBlock* X=nullptr;
    for(auto &BB:func_->get_basic_blocks()){
        for(auto &instr:BB.get_instructions()){
           /*if(is_valid_ptr(&instr))*/{
                 if(instr.is_alloca()&&!dynamic_cast<AllocaInst*>(&instr)->get_alloca_type()->is_array_type()){
                    variables_count[&instr].push_back(&BB);
                 }
                if(instr.is_store()){
                    if(variables_count[dynamic_cast<StoreInst*>(&instr)->get_lval()].size()!=0&&variables_count[dynamic_cast<StoreInst*>(&instr)->get_lval()].at(variables_count[dynamic_cast<StoreInst*>(&instr)->get_lval()].size()-1)!=&BB){
                        variables_count[dynamic_cast<StoreInst*>(&instr)->get_lval()].push_back(&BB);
                    }
                }
                if(instr.is_load()){
                        if(variables_count[dynamic_cast<LoadInst*>(&instr)->get_lval()].size()!=0&&variables_count[dynamic_cast<LoadInst*>(&instr)->get_lval()].at(variables_count[dynamic_cast<LoadInst*>(&instr)->get_lval()].size()-1)!=&BB){
                        variables_count[dynamic_cast<LoadInst*>(&instr)->get_lval()].push_back(&BB);
                    }
                }
           }
        }
    }
    for(auto &BB:func_->get_basic_blocks()){
        for(auto &instr:BB.get_instructions()){
           /*if(is_valid_ptr(&instr))*/{
                if(instr.is_store()&&variables_count[dynamic_cast<StoreInst*>(&instr)->get_lval()].size()>1){
                    if(crossBB_variable[dynamic_cast<StoreInst*>(&instr)->get_lval()].size()==0||crossBB_variable[dynamic_cast<StoreInst*>(&instr)->get_lval()].at(crossBB_variable[dynamic_cast<StoreInst*>(&instr)->get_lval()].size()-1)!=&BB){
                        crossBB_variable[dynamic_cast<StoreInst*>(&instr)->get_lval()].push_back(&BB);
                    }
                }
           }
        }
    }
    for(auto v:variables_count){
        if(v.second.size()>1){
        F.clear();
        W.clear();
        for(auto BB:crossBB_variable[v.first]){
            W.insert(BB);
        }
        while(!W.empty()){
            X = *W.begin();
            W.erase(W.begin());
            for(auto Y:dominators_->get_dominance_frontier(X)){
                if(F.find(Y)==F.end()){
                    //FIXME:is all bb needed in phi?
                    Instruction* temp =PhiInst::create_phi(v.first->get_type()->get_pointer_element_type(),Y);
                    Y->add_instr_begin(temp);
                    phi_to_variable[temp] = v.first;
                    F.insert(Y);
                    bool if_in = false;
                    for (auto k:crossBB_variable[v.first]){
                        if(k == Y) {if_in =true;break;}
                    }
                    if(!if_in){
                        W.insert(Y);
                    }
                }
            }
        }}
    }
}

void Mem2Reg::rename(BasicBlock *bb) {
    // TODO
    // 步骤三：将 phi 指令作为 lval 的最新定值，lval 即是为局部变量 alloca 出的地址空间
    // 步骤四：用 lval 最新的定值替代对应的load指令
    // 步骤五：将 store 指令的 rval，也即被存入内存的值，作为 lval 的最新定值
    // 步骤六：为 lval 对应的 phi 指令参数补充完整
    // 步骤七：对 bb 在支配树上的所有后继节点，递归执行 re_name 操作
    // 步骤八：pop出 lval 的最新定值
    // 步骤九：清除冗余的指令
    
    //FIXME:stacks only have one item
    for(auto &instr:bb->get_instructions()){
        /*if(is_valid_ptr(&instr))*/{
        if(instr.is_phi()){
            variable_stacks[phi_to_variable[&instr]].push_back(&instr);

        }
        if(instr.is_store()&&variables_count[dynamic_cast<StoreInst*>(&instr)->get_lval()].size()!=0){
            variable_stacks[dynamic_cast<StoreInst*>(&instr)->get_lval()].push_back(dynamic_cast<StoreInst*>(&instr)->get_rval());
        }
        if(instr.is_load()&&variables_count[dynamic_cast<LoadInst*>(&instr)->get_lval()].size()!=0&&variable_stacks[dynamic_cast<LoadInst*>(&instr)->get_lval()].size()!=0){
            instr.replace_all_use_with(variable_stacks[dynamic_cast<LoadInst*>(&instr)->get_lval()].at(variable_stacks[dynamic_cast<LoadInst*>(&instr)->get_lval()].size()-1));

        }}
    }
    for(auto S:bb->get_succ_basic_blocks()){
        for(auto &instr:S->get_instructions()){
            if(instr.is_phi()&&variable_stacks[phi_to_variable[&instr]].size()!=0){
                dynamic_cast<PhiInst*>(&instr)->add_phi_pair_operand(variable_stacks[phi_to_variable[&instr]].at(variable_stacks[phi_to_variable[&instr]].size()-1),bb);
            }
        }
    }
    for(auto S:dominators_->get_dom_tree_succ_blocks(bb)){
        rename(S);
    }
    std::set<Instruction*>instr_to_rm;
    for(auto &instr:bb->get_instructions()){
        if(instr.is_store()&&variables_count[dynamic_cast<StoreInst*>(&instr)->get_lval()].size()!=0){
            variable_stacks[dynamic_cast<StoreInst*>(&instr)->get_lval()].pop_back();
           instr_to_rm.insert(&instr);
        }
        else if(instr.is_phi()){
            variable_stacks[phi_to_variable[&instr]].pop_back();
        }
    }
     for(auto instr:instr_to_rm){
         bb->get_instructions().erase(instr);
     }
}
