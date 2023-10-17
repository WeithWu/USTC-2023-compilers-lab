#include "ASMInstruction.hpp"
#include "CodeGen.hpp"
#include "Module.hpp"

#include <iostream>
#include <memory>
#include <unordered_map>

void declare_global(CodeGen *codegen); // 声明全局变量 a
void translate_main(CodeGen *codegen); // 将 main 函数翻译为汇编代码

int main() {
    auto *module = new Module();
    auto *codegen = new CodeGen(module);

    // 告诉汇编器将汇编放到代码段
    codegen->append_inst(".text", ASMInstruction::Atrribute);

    declare_global(codegen);

    codegen->append_inst(".text", ASMInstruction::Atrribute);
    translate_main(codegen);

    std::cout << codegen->print();
    delete codegen;
    delete module;
    return 0;
}

void declare_global(CodeGen *codegen) {
    // 声明全局变量 a
    // 将 a 放到 .bss 段中
    codegen->append_inst(".section .bss, \"aw\", @nobits",
                         ASMInstruction::Atrribute);
    // 标记 a 为全局变量
    codegen->append_inst(".globl a", ASMInstruction::Atrribute);
    // 标记 a 为数据对象 (变量)
    codegen->append_inst(".type a, @object", ASMInstruction::Atrribute);
    // 标记 a 的大小为 4 字节
    codegen->append_inst(".size a, 4", ASMInstruction::Atrribute);
    // a 的标签
    codegen->append_inst("a", ASMInstruction::Label);
    // 为 a 分配空间
    codegen->append_inst(".space 4");
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
    // 为栈帧分配空间. 思考: 为什么是 32 字节?
    codegen->append_inst("addi.d $sp, $sp, -32");

    /* main 函数的 label_entry */
    codegen->append_inst(".main_label_entry", ASMInstruction::Label);

    /* store i32 10, i32* @a */
    // 在汇编中写入注释, 方便 debug
    codegen->append_inst("store i32 10, i32* @a", ASMInstruction::Comment);
    // 将 10 写入 a 对应的内存空间中
    // TODO: 获得 a 的地址
    codegen->append_inst("");
    // TODO: 将 10 写入 a 对应的内存空间中
    codegen->append_inst("");

    /* %op0 = load i32, i32* @a */
    codegen->append_inst("%op0 = load i32, i32* @a", ASMInstruction::Comment);
    // 将 a 的值写入 %op0 对应的内存空间中
    offset_map["%op0"] = ; // TODO: 请填空
    // TODO: 获得 a 的地址, 并存储在 $t0 中
    codegen->append_inst("");
    // 将 a 的值写入 %op0 对应的内存空间中
    codegen->append_inst("ld.w $t1, $t0, 0");
    codegen->append_inst("st.w",
                         {"$t1", "$fp", std::to_string(offset_map["%op0"])});

    /* ret i32 %op0 */
    codegen->append_inst("ret i32 %op0", ASMInstruction::Comment);
    // 将 %op0 的值写入 $a0
    codegen->append_inst("ld.w",
                         {"$a0", "$fp", std::to_string(offset_map["%op0"])});
    codegen->append_inst("b main_exit");

    /* main 函数的 Epilogue (收尾) */
    codegen->append_inst("main_exit", ASMInstruction::Label);
    // 释放栈帧空间
    codegen->append_inst("addi.d $sp, $sp, 32");
    // 恢复 ra
    codegen->append_inst("ld.d $ra, $sp, -8");
    // 恢复 fp
    codegen->append_inst("ld.d $fp, $sp, -16");
    // 返回
    codegen->append_inst("jr $ra");
}
