#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "IRBuilder.hpp"
#include "Module.hpp"
#include "Type.hpp"

#include <iostream>
#include <memory>

#define CONST_INT(num) ConstantInt::get(num,module)
#define CONST_FP(num) ConstantFP::get(num,module)

int main() {
    auto module = new Module();
    auto builder = new IRBuilder(nullptr,module);
    auto Int32Type = module->get_int32_type();
    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    auto bb = BasicBlock::create(module,"entry",mainFun);
    builder->set_insert_point(bb);
    auto aAlloca = builder->create_alloca(Int32Type);
    auto iAlloca = builder->create_alloca(Int32Type);
    builder->create_store(CONST_INT(10),aAlloca);
    builder->create_store(CONST_INT(0),iAlloca);
    bb = BasicBlock::create(module,"whilBB",mainFun);
    auto retBB = BasicBlock::create(module,"retBB",mainFun);
    auto cmpBB = BasicBlock::create(module,"cmpBB",mainFun);
    builder->create_br(cmpBB);
    builder->set_insert_point(cmpBB);
    auto iLoad = builder->create_load(iAlloca);
    auto icmp = builder->create_icmp_lt(iLoad,CONST_INT(10));
    builder->create_cond_br(icmp,bb,retBB);
    builder->set_insert_point(bb);
    iLoad = builder->create_load(iAlloca);
    auto aLoad = builder->create_load(aAlloca);
    auto addi = builder->create_iadd(CONST_INT(1),iLoad);
    auto adda = builder->create_iadd(iLoad,aLoad);
    builder->create_store(addi,iAlloca);
    builder->create_store(adda,aAlloca);
    builder->create_br(cmpBB);
    builder->set_insert_point(retBB);
    aLoad = builder->create_load(aAlloca);
    builder->create_ret(aLoad);
    std::cout << module->print();
    delete module;
    return 0;
}