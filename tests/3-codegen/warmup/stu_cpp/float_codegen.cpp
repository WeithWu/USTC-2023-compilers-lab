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

    /* %op0 = alloca float */
    // 在汇编中写入注释, 方便 debug
    codegen->append_inst("%op0 = alloca float", ASMInstruction::Comment);
    // 将浮点数的地址写入 %op0 对应的内存空间中
    offset_map["%op0"] = ;  // TODO: 请填空
    offset_map["*%op0"] = ; // TODO: 请填空
    codegen->append_inst("addi.d",
                         {"$t0", "$fp", std::to_string(offset_map["*%op0"])});
    codegen->append_inst("st.d",
                         {"$t0", "$fp", std::to_string(offset_map["%op0"])});

    /* store float 0x40091eb860000000, float* %op0 */
    codegen->append_inst("store float 0x40091eb860000000, float* %op0",
                         ASMInstruction::Comment);
    // 将 3.14 (0x4048f5c3) 写入 %op0 指向的内存空间中
    // 获得 %op0 的值
    codegen->append_inst("ld.d",
                         {"$t0", "$fp", std::to_string(offset_map["%op0"])});
    // TODO: 将 0x4048f5c3 加载到通用寄存器或者浮点寄存器中
    codegen->append_inst("");
    // TODO: 将通用寄存器或者浮点寄存器中的值写入 %op0 对应的内存空间中
    codegen->append_inst("");

    /* %op1 = load float, float* %op0 */
    codegen->append_inst("%op1 = load float, float* %op0",
                         ASMInstruction::Comment);
    // TODO: 先获得 %op0 的值, 然后获得 %op0 指向的空间的值, 最后将这个值写入
    // %op1 对应的内存空间中
    offset_map["%op1"] = ; // TODO: 请填空
    codegen->append_inst("");

    /* %op2 = fptosi float %op1 to i32 */
    codegen->append_inst("%op2 = fptosi float %op1 to i32",
                         ASMInstruction::Comment);
    // TODO: 使用 ftintrz.w.s 指令进行转换, 并将结果写入 %op2 对应的内存空间中
    offset_map["%op2"] = ; // TODO: 请填空
    codegen->append_inst("");

    /* ret i32 %op2 */
    codegen->append_inst("ret i32 %op2", ASMInstruction::Comment);
    // TODO: 将 %op2 的值写入 $a0 中
    codegen->append_inst("");
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
