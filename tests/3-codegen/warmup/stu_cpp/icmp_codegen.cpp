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
    // 为栈帧分配空间. 思考: 为什么是 48 字节?
    codegen->append_inst("addi.d $sp, $sp, -48");

    /* main 函数的 label_entry */
    codegen->append_inst(".main_label_entry", ASMInstruction::Label);

    /* %op0 = icmp sgt i32 5, 1 */
    // 在汇编中写入注释, 方便 debug
    codegen->append_inst(
        "%op0 = fcmp ugt float 0x4016000000000000, 0x3ff0000000000000",
        ASMInstruction::Comment);
    // 将比较结果写入 %op0 对应的内存空间中
    offset_map["%op0"] = -20; // TODO: 请填空
    codegen->append_inst("addi.w $t0, $zero, 5");
    codegen->append_inst("addi.w $t1, $zero, 1");
    // TODO: 使用 slt 指令比较, 并将结果写入 %op0 对应的内存空间中
    codegen->append_inst("slt $t0, $t1, $t0");
    codegen->append_inst("st.w",{"$t0","$fp",std::to_string(offset_map["%op0"])});

    /* %op1 = zext i1 %op0 to i32 */
    codegen->append_inst("%op1 = zext i1 %op0 to i32", ASMInstruction::Comment);
    // 将 %op0 的值从 i1 类型转换为 i32 类型, 并将结果写入到 %op1 对应的内存空
    // 间中
    offset_map["%op1"] = -24; // TODO: 请填空
    // TODO: 获得 %op0 的值, 然后进行转换, 最后将结果写入 %op1
    // 思考: 怎么转换? 需不需要显式地使用某些指令转换?
    codegen->append_inst("ld.w",{"$t0","$fp",std::to_string(offset_map["%op0"])});
    codegen->append_inst("bstrpick.w $t1, $t0, 0, 0");
    codegen->append_inst("st.w",{"$t1","$fp",std::to_string(offset_map["%op1"])});

    /* %op2 = icmp ne i32 %op1, 0 */
    codegen->append_inst("%op2 = icmp ne i32 %op1, 0", ASMInstruction::Comment);
    // 比较 %op1 和 0, 并将结果写入 %op2 对应的内存空间中
    offset_map["%op2"] = -28; // TODO: 请填空
    // TODO: 获得 %op1 的值, 然后进行比较, 最后将结果写入 %op2
    // 思考: 如何比较? 能否不使用跳转指令计算结果?
    // 提示: 尝试使用 xor/xori 和 slt/sltu/slti/sltui 计算比较结果
    codegen->append_inst("ld.w",{"$t0","$fp",std::to_string(offset_map["%op1"])});
    codegen->append_inst("bstrpick.d $t2, $t0, 0, 0");
    codegen->append_inst("xori $t1, $t2,0");
    codegen->append_inst("slt $t0,$zero,$t1");
    codegen->append_inst("st.w",{"$t0","$fp",std::to_string(offset_map["%op2"])});

    /* br i1 %op2, label %label3, label %label4 */
    codegen->append_inst("br i1 %op2, label %label3, label %label4",
                         ASMInstruction::Comment);
    // TODO: 获得 %op2 的值, 并根据 %op2 的值跳转到 label3 或者 label4
    // 提示: 汇编中对应的标签分别为 .main_label3 和 .main_label4
    codegen->append_inst("ld.w",{"$t0","$fp",std::to_string(offset_map["%op2"])});
    codegen->append_inst("bstrpick.d $t1, $t0, 0, 0");
    codegen->append_inst("beqz $t1,.main_label4");
    codegen->append_inst("b .main_label3");
    /* label3: */
    codegen->append_inst(".main_label3", ASMInstruction::Label);

    /* ret i32 233 */
    codegen->append_inst("ret i32 233", ASMInstruction::Comment);
    // 将 233 写入 $a0 中
    codegen->append_inst("addi.w $a0, $zero, 233");
    codegen->append_inst("b main_exit");

    /* label4: */
    codegen->append_inst(".main_label4", ASMInstruction::Label);

    /* ret i32 0 */
    codegen->append_inst("ret i32 0", ASMInstruction::Comment);
    // 将 0 写入 $a0 中
    codegen->append_inst("addi.w $a0, $zero, 0");
    codegen->append_inst("b main_exit");

    /* main 函数的 Epilogue (收尾) */
    codegen->append_inst("main_exit", ASMInstruction::Label);
    // 释放栈帧空间
    codegen->append_inst("addi.d $sp, $sp, 48");
    // 恢复 ra
    codegen->append_inst("ld.d $ra, $sp, -8");
    // 恢复 fp
    codegen->append_inst("ld.d $fp, $sp, -16");
    // 返回
    codegen->append_inst("jr $ra");
}
