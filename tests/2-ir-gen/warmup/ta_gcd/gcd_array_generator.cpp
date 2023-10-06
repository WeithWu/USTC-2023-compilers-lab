#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "IRBuilder.hpp"
#include "Module.hpp"
#include "Type.hpp"

#include <iostream>
#include <memory>

// 定义一个从常数值获取/创建 ConstantInt 类实例化的宏，方便多次调用
#define CONST_INT(num) \
    ConstantInt::get(num, module)

// 定义一个从常数值获取/创建 ConstantFP 类实例化的宏，方便多次调用
#define CONST_FP(num) \
    ConstantFP::get(num, module)

int main() {
    // 创建一个 Module 实例
    auto module = new Module();
    // 创建一个 IRBuilder 实例（后续创建指令均使用此实例操作）
    auto builder = new IRBuilder(nullptr, module);
    // 从 Module 处取出 32 位整形 type 的实例
    Type *Int32Type = module->get_int32_type();
    // 使用取出的 32 位整形与数组长度 1，创建数组类型 [1 x i32]
    auto *arrayType = ArrayType::get(Int32Type, 1);
    // 创建 0 常数类实例化，用于全局变量的初始化（目前全局变量仅支持初始化为 0）
    auto initializer = ConstantZero::get(Int32Type, module);
    // 为全局数组变量分配空间。参数解释：名字 name，所属 module，待分配空间类型 type，标志全局变量是否有 const 限定（cminus 中全是 false），初始化值
    auto x = GlobalVariable::create("x", module, arrayType, false, initializer);
    // 为另一个全局数组分配空间
    auto y = GlobalVariable::create("y", module, arrayType, false, initializer);
    // 接下来创建 gcd 函数
    // 声明函数参数类型的 vector，此处的 vector 数组含有两个元素，每个均为 Int32Type，表明待创建函数有两个参数，类型均为 Int32Type 实例代表的类型
    std::vector<Type *> Ints(2, Int32Type);
    // 创建函数类型，FunctionType::get 的第一个参数是函数返回值类型，第二个是函数参数类型列表
    auto gcdFunTy = FunctionType::get(Int32Type, Ints);
    // 通过函数类型创建函数 gcd，输入参数解释：函数类型，函数名 name，函数所属 module
    auto gcdFun = Function::create(gcdFunTy, "gcd", module);
    // 为函数 gcd 创建起始 BasicBlock，参数解释：所属 module，名称 name，所属函数
    auto bb = BasicBlock::create(module, "entry", gcdFun);
    // 将辅助类实例化 builder 插入指令的起始位置设置在 bb 对应的 BasicBlock
    builder->set_insert_point(bb);
    // 使用辅助类实例化 builder 创建了一条 alloca 指令，在栈上分配返回值的空间
    auto retAlloca = builder->create_alloca(Int32Type);
    // 使用辅助类实例化 builder 创建了一条 alloca 指令，在栈上分配参数 u 的空间
    auto uAlloca = builder->create_alloca(Int32Type);
    // 使用辅助类实例化 builder 创建了一条 alloca 指令，在栈上分配参数 u 的空间
    auto vAlloca = builder->create_alloca(Int32Type);
    // 获取 gcd 函数的形参，通过 Function 中的 iterator
    std::vector<Value *> args;
    for (auto &arg: gcdFun->get_args()) {
        args.push_back(&arg);
    }
    // 使用辅助类实例化 builder 创建了一条 store 指令，将参数 u store 下来
    builder->create_store(args[0], uAlloca);
    // 使用辅助类实例化 builder 创建了一条 store 指令，将参数 v store 下来
    builder->create_store(args[1], vAlloca);
    // 使用辅助类实例化 builder 创建了一条 load 指令，将参数 v load 出来
    auto vLoad = builder->create_load(vAlloca);
    // 使用辅助类实例化 builder 创建了一条 cmp eq 指令，将 v load 出来的值与 0 比较
    auto icmp = builder->create_icmp_eq(vLoad, CONST_INT(0));
    // 为函数 gcd 创建 BasicBlock 作为 true 分支
    auto trueBB = BasicBlock::create(module, "trueBB", gcdFun);
    // 为函数 gcd 创建 BasicBlock 作为 false 分支
    auto falseBB = BasicBlock::create(module, "falseBB", gcdFun);
    // 为函数 gcd 创建 BasicBlock 作为 return 分支，提前创建，以便在 true 分支中可以创建跳转到 return 分支的 br 指令
    auto retBB = BasicBlock::create(module, "", gcdFun);  // return 分支，
    // 为 entrybb 创建终结指令，条件跳转指令，使用 icmp 指令的返回值作为条件，trueBB 与 falseBB 作为条件跳转的两个目的 basicblock
    auto br = builder->create_cond_br(icmp, trueBB, falseBB);
    // 将辅助类实例化 builder 插入指令的位置调整至 trueBB 上
    builder->set_insert_point(trueBB);
    // 使用辅助类实例化 builder 创建了一条 load 指令，将参数 u load 出来
    auto uLoad = builder->create_load(uAlloca);
    // 使用辅助类实例化 builder 创建了一条 store 指令，将参数 u store 至为返回值分配的空间
    builder->create_store(uLoad, retAlloca);
    // 使用 builder 创建一条强制跳转指令，跳转到 retBB 处
    builder->create_br(retBB);  // br retBB
    // 将辅助类实例化 builder 插入指令的位置调整至 falseBB 上
    builder->set_insert_point(falseBB);
    // 使用 builder 创建了一条 load 指令，将参数 u load 出来
    uLoad = builder->create_load(uAlloca);
    // 使用 builder 创建了一条 load 指令，将参数 v load 出来
    vLoad = builder->create_load(vAlloca);
    // 使用 builder 创建了一条 sdiv 指令，计算 u/v 的值
    auto div = builder->create_isdiv(uLoad, vLoad);
    // 使用 builder 创建了一条 imul 指令，计算 v*u/v 的值
    auto mul = builder->create_imul(div, vLoad);
    // 使用 builder 创建了一条 isub 指令，计算 u-v*u/v 的值
    auto sub = builder->create_isub(uLoad, mul);
    // 创建 call 指令，调用 gcd 函数，传入的实参为 v load 指令的结果与 sub 指令计算的结果
    auto call = builder->create_call(gcdFun, {vLoad, sub});
    // 创建 store 指令，将 call 指令的结果存至为 gcd 函数返回值分配的空间
    builder->create_store(call, retAlloca);
    // 创建强制跳转指令，跳转至 retBB
    builder->create_br(retBB);  // br retBB
    // 将 builder 插入指令的位置调整至 retBB 上
    builder->set_insert_point(retBB);  // ret 分支
    // 使用 builder 创建了一条 load 指令，将 gcd 函数返回值 load 出来
    auto retLoad = builder->create_load(retAlloca);
    // 使用 builder 创建了一条 ret 指令，将 gcd 返回值 load 出来的结果作为 gcd 函数的返回值返回
    builder->create_ret(retLoad);
    // 接下来创建 funArray 函数
    // 获得 32 位整形的指针类型，
    auto Int32PtrType = module->get_int32_ptr_type();
    // 初始化 funArray 函数的参数类型列表，第一个参数与第二个参数类型均为 Int32PtrType，及 32 位整形的指针类型
    std::vector<Type *> IntPtrs(2, Int32PtrType);
    // 通过返回值类型与参数类型列表创建函数类型
    auto funArrayFunType = FunctionType::get(Int32Type, IntPtrs);
    // 通过函数类型创建函数
    auto funArrayFun = Function::create(funArrayFunType, "funArray", module);
    // 创建 funArray 函数的第一个 BasicBlock
    bb = BasicBlock::create(module, "entry", funArrayFun);
    // 将 builder 插入指令的位置调整至 funArray 的 entryBB 上
    builder->set_insert_point(bb);
    // 用 builder 创建 alloca 指令，用于 u 的存放，此处开始 u，v 指的是源代码中 funArray 函数内的参数
    auto upAlloca = builder->create_alloca(Int32PtrType);
    // 用 builder 创建 alloca 指令，用于 v 的存放
    auto vpAlloca = builder->create_alloca(Int32PtrType);
    // 用 builder 创建 alloca 指令，用于 a 的存放
    auto aAlloca = builder->create_alloca(Int32Type);
    // 用 builder 创建 alloca 指令，用于 b 的存放
    auto bAlloca = builder->create_alloca(Int32Type);
    // 用 builder 创建 alloca 指令，用于 temp 的存放
    auto tempAlloca = builder->create_alloca(Int32Type);
    // 获取 funArrayFun 函数的形参，通过 Function 中的 iterator
    std::vector<Value *> args1;
    for (auto &arg: funArrayFun->get_args()) {
        args1.push_back(&arg);
    }
    // 用 builder 创建 store 指令将参数 u store 下来
    builder->create_store(args1[0], upAlloca);
    // 用 builder 创建 store 指令将参数 v store 下来
    builder->create_store(args1[1], vpAlloca);
    // 用 builder 创建 load 指令将参数 u 的值 load 出来
    auto u0pLoad = builder->create_load(upAlloca);
    // 用 builder 创建 getelementptr 指令，参数解释：第一个参数传入 getelementptr 的指针参数，第二个参数传入取偏移的数组。在此条语句中，u0pLoad 为 i32*类型的指针，且只取一次偏移，偏移值为 0，因此返回的即为 u[0] 的地址
    auto u0GEP = builder->create_gep(u0pLoad, {CONST_INT(0)});
    // 用 builder 创建 load 指令，将 u[0] 的数据 load 出来
    auto u0Load = builder->create_load(u0GEP);
    // 用 builder 创建 store 指令，将 u[0] 的数据写入 a
    builder->create_store(u0Load, aAlloca);
    // 接下来几条指令含义同上
    auto v0pLoad = builder->create_load(vpAlloca);
    auto v0GEP = builder->create_gep(v0pLoad, {CONST_INT(0)});
    auto v0Load = builder->create_load(v0GEP);
    builder->create_store(v0Load, bAlloca);
    // 用 builder 创建两条 load 指令吗，将 a，b 的值 load 出来
    auto aLoad = builder->create_load(aAlloca);
    auto bLoad = builder->create_load(bAlloca);
    // 用 builder 创建 icmp lt 指令，指令操作数为 a，b load 出来的值
    icmp = builder->create_icmp_lt(aLoad, bLoad);
    // 为 if else 分支创建两个 BasicBlock
    trueBB = BasicBlock::create(module, "trueBB", funArrayFun);
    falseBB = BasicBlock::create(module, "falseBB", funArrayFun);
    // 用 builder 创建一条条件跳转指令，使用 icmp 指令的返回值作为条件，trueBB 与 falseBB 作为条件跳转的两个目的 basicblock
    builder->create_cond_br(icmp, trueBB, falseBB);
    // 将 builder 插入指令的位置调整至 trueBB 上
    builder->set_insert_point(trueBB);
    // 用 builder 创建 store 指令，将 a 的值存到 temp 处，将 b 存到 a 处，将 temp 重新 load 后存到 b 处，对应源代码 temp=a，a=b，b=temp
    builder->create_store(aLoad, tempAlloca);
    builder->create_store(bLoad, aAlloca);
    auto tempLoad = builder->create_load(tempAlloca);
    builder->create_store(tempLoad, bAlloca);
    // 创建强制跳转指令，跳转至 falseBB，注意每个 BasicBlock 都需要有终结指令
    builder->create_br(falseBB);
    // 将 builder 插入指令的位置调整至 falseBB 上
    builder->set_insert_point(falseBB);
    // 用 builder 创建两条 load 指令将 a 与 b 的值 load 出来
    aLoad = builder->create_load(aAlloca);
    bLoad = builder->create_load(bAlloca);
    // 用 builder 创建 call 指令，调用 gcd 函数，并将 ab load 的结果作为实参传入
    call = builder->create_call(gcdFun, {aLoad, bLoad});
    // 使用 builder 创建了一条 ret 指令，将 gcd 返回值 load 出来的结果作为 gcd 函数的返回值返回
    builder->create_ret(call);
    // 接下来创建 main 函数
    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    // 创建 main 函数的起始 bb
    bb = BasicBlock::create(module, "entry", mainFun);
    // 将 builder 插入指令的位置调整至 main 函数起始 bb 上
    builder->set_insert_point(bb);
    // 用 builder 创建 alloca 指令，为函数返回值分配空间
    retAlloca = builder->create_alloca(Int32Type);
    // main 函数默认 ret 0
    builder->create_store(CONST_INT(0), retAlloca);
    // 用 builder 创建 getelementptr 指令，参数解释：第一个参数传入 getelementptr 的指针参数，第二个参数传入取偏移的数组。在此条语句中，x 为 [1 x i32]*类型的指针，取两次偏移，两次偏移值都为 0，因此返回的即为 x[0] 的地址。
    auto x0GEP = builder->create_gep(x, {CONST_INT(0), CONST_INT(0)});
    // 用 builder 创建 store 指令，将 90 常数值存至上条语句取出的 x[0] 的地址
    builder->create_store(CONST_INT(90), x0GEP);
    // 此处同上创建 getelementptr 指令，返回 y[0] 的地址
    auto y0GEP = builder->create_gep(y, {CONST_INT(0), CONST_INT(0)});
    // 用 builder 创建 store 指令，将 18 常数值存至上条语句取出的 y[0] 的地址
    builder->create_store(CONST_INT(18), y0GEP);
    // 此处同上创建 getelementptr 指令，返回 x[0] 的地址
    x0GEP = builder->create_gep(x, {CONST_INT(0), CONST_INT(0)});
    // 此处同上创建 getelementptr 指令，返回 y[0] 的地址
    y0GEP = builder->create_gep(y, {CONST_INT(0), CONST_INT(0)});
    // 此处创建 call 指令，调用 funArray 函数，将上两条语句返回的 x[0]，y[0] 的地址作为实参
    call = builder->create_call(funArrayFun, {x0GEP, y0GEP});
    // 使用 builder 创建了一条 ret 指令，将 funArray 返回值 load 出来的结果作为 main 函数的返回值返回
    builder->create_ret(call);
    // 输出 module 中的所有 IR 指令
    std::cout << module->print();
    delete module;
    return 0;
}
