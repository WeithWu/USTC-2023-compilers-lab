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
    Type * Int32Type = module->get_int32_type();
    std::vector<Type *> IntPtrs(1,Int32Type);
    auto calleeFuncType = FunctionType::get(Int32Type,IntPtrs);
    auto calleeFunc = Function::create(calleeFuncType,"callee",module);
    auto bb = BasicBlock::create(module,"entry",calleeFunc);
    builder->set_insert_point(bb);
    auto aAlloca = builder->create_alloca(Int32Type);
    auto retAlloca = builder->create_alloca(Int32Type);
    std::vector<Value *> args1;
    for (auto &arg: calleeFunc->get_args()) {
        args1.push_back(&arg);
    }
    builder->create_store(args1[0],aAlloca);
    auto aLoad = builder->create_load(aAlloca);
    auto mul = builder->create_imul(CONST_INT(2),aLoad);
    builder->create_store(mul,retAlloca);
    auto retLoad = builder->create_load(retAlloca);
    builder->create_ret(retLoad);
    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    bb = BasicBlock::create(module,"entry",mainFun);
    builder->set_insert_point(bb);
    auto call = builder->create_call(calleeFunc,{CONST_INT(110)});
    builder->create_ret(call);
    std::cout << module->print();
    delete module;
    return 0;
}