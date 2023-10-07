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
    Type *Int32Type = module->get_int32_type();
    //auto *Int32PtrType = module->get_int32_ptr_type();
    auto *arryType = ArrayType::get(Int32Type,10);
    auto mainFun = Function::create(FunctionType::get(Int32Type,{}),"main",module);
    auto bb = BasicBlock::create(module,"entry",mainFun);
    builder->set_insert_point(bb);
    auto retAlloca = builder->create_alloca(Int32Type);
    auto arryAlloca = builder->create_alloca(arryType);
    auto arr0_gep = builder->create_gep(arryAlloca,{CONST_INT(0),CONST_INT(0)});
    builder->create_store(CONST_INT(10),arr0_gep);
    arr0_gep = builder->create_gep(arryAlloca,{CONST_INT(0),CONST_INT(0)});
    auto arr0 = builder->create_load(arr0_gep);
    auto mul = builder->create_imul(CONST_INT(2),arr0);
    auto arr1_gep = builder->create_gep(arryAlloca,{CONST_INT(0),CONST_INT(1)});
    builder->create_store(mul,arr1_gep);
    auto arr1 = builder->create_load(arr1_gep);
    builder->create_store(arr1,retAlloca);
    
    auto retLoad = builder->create_load(retAlloca);
    builder->create_ret(retLoad);
    std::cout << module->print();
    delete module;
    return 0;
}