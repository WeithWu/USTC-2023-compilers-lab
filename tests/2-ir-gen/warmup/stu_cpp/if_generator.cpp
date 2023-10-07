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
    auto *FPType = module->get_float_type();
    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    auto bb = BasicBlock::create(module,"entry",mainFun);
    builder->set_insert_point(bb);
    auto aAlloca = builder->create_alloca(FPType);
    builder->create_store(CONST_FP(5.555),aAlloca);
    auto aLoad = builder->create_load(aAlloca);
    auto fcmp = builder->create_fcmp_gt(aLoad,CONST_FP(1));
    auto trueBB = BasicBlock::create(module,"trueBB",mainFun);
    auto retBB = BasicBlock::create(module,"retBB",mainFun);
    builder->create_cond_br(fcmp,trueBB,retBB);
    builder->set_insert_point(trueBB);
    auto retAlloca = builder->create_alloca(Int32Type);
    builder->create_store(CONST_INT(233),retAlloca);
    auto retLoad = builder->create_load(retAlloca);
    builder->create_ret(retLoad);
    builder->set_insert_point(retBB);
    retAlloca = builder->create_alloca(Int32Type);
    builder->create_store(CONST_INT(0),retAlloca);
    retLoad = builder->create_load(retAlloca);
    builder->create_ret(retLoad);
    std::cout << module->print();
    delete module;
    return 0;
}