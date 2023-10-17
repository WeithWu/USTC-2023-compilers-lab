#include "ASMInstruction.hpp"
#include "CodeGen.hpp"
#include "Module.hpp"

#include <iostream>
#include <memory>
#include <unordered_map>

void translate_main(CodeGen *codegen); // 将 main 函数翻译为汇编代码

int main() {
    auto *module = new Module();
    auto *codegen = new CodeGen(module);

    // 告诉汇编器将汇编放到代码段
    codegen->append_inst(".text", ASMInstruction::Atrribute);

    translate_main(codegen);

    std::cout << codegen->print();
    delete codegen;
    delete module;
    return 0;
}

// TODO: 按照提示补全
void translate_main(CodeGen *codegen) {
    std::unordered_map<std::string, int> offset_map;

    /* 声明 main 函数 */
    codegen->append_inst(".globl main", ASMInstruction::Atrribute);
    codegen->append_inst(".type main, @function", ASMInstruction::Atrribute);

    /* main 函数开始 */
    codegen->append_inst("main", ASMInstruction::Label); // main 函数标签

    /* main 函数的 Prologue (序言) */
    // 保存返回地址
    codegen->append_inst("st.d $ra, $sp, -8");
    // 保存老的 fp
    codegen->append_inst("st.d $fp, $sp, -16");
    // 设置新的 fp
    codegen->append_inst("addi.d $fp, $sp, 0");
    // 为栈帧分配空间. 思考: 为什么是 96 字节?
    codegen->append_inst("addi.d $sp, $sp, -96");

    /* main 函数的 label_entry */
    codegen->append_inst(".main_label_entry", ASMInstruction::Label);

    /* %op0 = alloca [10 x i32] */
    // 在汇编中写入注释, 方便 debug
    codegen->append_inst("%op0 = alloca [10 x i32]", ASMInstruction::Comment);
    // 将数组的地址写入 %op0 对应的内存空间中
    // 首先计算数组的地址对应的偏移量, 按照我们在栈式分配中介绍的规则, 数组的空
    // 间紧挨着 %op0 的空间, 数组的地址为这段空间的最小值.
    // 然后将数组的地址写入 %op0 对应的内存空间中.
    // 你需要思考:
    // - %op0 的大小是多少字节?
    // - %op0 的偏移量是多少字节?
    // - 数组的大小是多少字节?
    // - 数组的偏移量是多少字节?
    offset_map["%op0"] = ;  // TODO: 请填空
    offset_map["array"] = ; // TODO: 请填空
    codegen->append_inst("addi.d",
                         {"$t0", "$fp", std::to_string(offset_map["array"])});
    codegen->append_inst("st.d",
                         {"$t0", "$fp", std::to_string(offset_map["%op0"])});

    /* %op1 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0 */
    codegen->append_inst(
        "%op1 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0",
        ASMInstruction::Comment);
    // 将 gep 的值写入 %op1 对应的内存空间中
    // 你可以手动计算 gep 的值, 或者使用指令计算 gep 的值
    // 你需要思考 %op1 的偏移量是多少字节
    offset_map["%op1"] = ; // TODO: 请填空
    // 获得数组的地址, 将其写入 $t0 中
    codegen->append_inst("ld.d",
                         {"$t0", "$fp", std::to_string(offset_map["%op0"])});
    // TODO: 计算 %op1 的值, 并将其写入 %op1 对应的内存空间中
    codegen->append_inst("");

    /* store i32 10, i32* %op1 */
    codegen->append_inst("store i32 10, i32* %op1", ASMInstruction::Comment);
    // 将 10 写入数组 (%op1 指向的空间) 中, 需要先获得 %op1 的值
    codegen->append_inst("ld.d",
                         {"$t0", "$fp", std::to_string(offset_map["%op1"])});
    codegen->append_inst("addi.w $t1, $zero, 10");
    codegen->append_inst("st.w $t1, $t0, 0");

    /* %op2 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 1 */
    codegen->append_inst(
        "%op2 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 1",
        ASMInstruction::Comment);
    // 将 gep 的值写入 %op2 对应的内存空间中
    // 你可以手动计算 gep 的值, 或者使用指令计算 gep 的值
    // 你需要思考 %op2 的偏移量是多少字节
    offset_map["%op2"] = ; // TODO: 请填空
    // 获得数组的地址, 将其写入 $t0 中
    codegen->append_inst("ld.d",
                         {"$t0", "$fp", std::to_string(offset_map["%op0"])});
    // TODO: 计算 gep 的值, 并将其写入 %op2 对应的内存空间中
    codegen->append_inst("");

    /* %op3 = load i32, i32* %op1 */
    codegen->append_inst("%op3 = load i32, i32* %op1", ASMInstruction::Comment);
    // 将 %op1 指向的空间中存储的值写入 %op3 对应的内存空间中
    offset_map["%op3"] = ; // TODO: 请填空
    // TODO: 先获得 %op1 的值, 然后获得 %op1 指向的空间的值, 最后将这个值写入
    // %op3 对应的内存空间中
    codegen->append_inst("");

    /* %op4 = mul i32 %op3, 3 */
    codegen->append_inst("%op4 = mul i32 %op3, 3", ASMInstruction::Comment);
    offset_map["%op4"] = ; // TODO: 请填空
    // TODO: 先获得 %op3 的值, 然后将其乘以 3, 最后将结果写入 %op4 对应的内存空
    // 间中
    codegen->append_inst("");

    /* store i32 %op4, i32* %op2 */
    codegen->append_inst("store i32 %op4, i32* %op2", ASMInstruction::Comment);
    // 将 %op4 的值写入 %op2 指向的空间中
    // TODO: 先获得 %op4 的值, 然后将其写入 %op2 指向的空间中
    codegen->append_inst("");

    /* %op5 = load i32, i32* %op2 */
    // 将 %op2 指向的空间中存储的值写入 %op5 对应的内存空间中
    offset_map["%op5"] = ; // TODO: 请填空
    // TODO: 先获得 %op2 的值, 然后获得 %op2 指向的空间的值, 最后将这个值写入
    // %op5 对应的内存空间中
    codegen->append_inst("");

    /* ret i32 %op5 */
    codegen->append_inst("ret i32 %op5", ASMInstruction::Comment);
    // TODO: 将 %op5 的值写入 $a0 中
    codegen->append_inst("");
    // 思考: 为什么不在这里 jr $ra, 而是跳转到 main_exit?
    codegen->append_inst("b main_exit");

    /* main 函数的 Epilogue (收尾) */
    codegen->append_inst("main_exit", ASMInstruction::Label);
    // 释放栈帧空间
    codegen->append_inst("addi.d $sp, $sp, 96");
    // 恢复 ra
    codegen->append_inst("ld.d $ra, $sp, -8");
    // 恢复 fp
    codegen->append_inst("ld.d $fp, $sp, -16");
    // 返回
    codegen->append_inst("jr $ra");
}
