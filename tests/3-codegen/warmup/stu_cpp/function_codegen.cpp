#include "ASMInstruction.hpp"
#include "CodeGen.hpp"
#include "Module.hpp"

#include <iostream>
#include <memory>
#include <unordered_map>

void translate_main(CodeGen *codegen);   // 将 main 函数翻译为汇编代码
void translate_callee(CodeGen *codegen); // 将 callee 函数翻译为汇编代码

int main() {
    auto *module = new Module();
    auto *codegen = new CodeGen(module);

    // 告诉汇编器将汇编放到代码段
    codegen->append_inst(".text", ASMInstruction::Atrribute);

    translate_callee(codegen);
    translate_main(codegen);

    std::cout << codegen->print();
    delete codegen;
    delete module;
    return 0;
}

// TODO: 按照提示补全
void translate_callee(CodeGen *codegen) {
    std::unordered_map<std::string, int> offset_map;

    /* 声明 callee 函数 */
    codegen->append_inst(".globl callee", ASMInstruction::Atrribute);
    codegen->append_inst(".type callee, @function", ASMInstruction::Atrribute);

    /* callee 函数开始 */
    codegen->append_inst("callee", ASMInstruction::Label); // main 函数标签

    /* callee 函数的 Prologue (序言) */
    // 保存返回地址
    codegen->append_inst("st.d $ra, $sp, -8");
    // 保存老的 fp
    codegen->append_inst("st.d $fp, $sp, -16");
    // 设置新的 fp
    codegen->append_inst("addi.d $fp, $sp, 0");
    // 为栈帧分配空间. 思考: 为什么是 48 字节?
    codegen->append_inst("addi.d $sp, $sp, -48");

    // 为参数分配空间
    offset_map["%arg0"] = ; // TODO: 请填空
    codegen->append_inst("st.w",
                         {"$a0", "$fp", std::to_string(offset_map["%arg0"])});

    /* callee 函数的 label_entry */
    codegen->append_inst(".callee_label_entry", ASMInstruction::Label);

    /* %op1 = alloca i32 */
    // 在汇编中写入注释, 方便 debug
    codegen->append_inst("%op1 = alloca i32", ASMInstruction::Comment);
    // 将 alloca 的地址写入 %op1 对应的内存空间中
    offset_map["%op1"] = ;  // TODO: 请填空
    offset_map["*%op1"] = ; // TODO: 请填空
    codegen->append_inst("addi.d",
                         {"$t0", "$fp", std::to_string(offset_map["*%op1"])});
    codegen->append_inst("st.d",
                         {"$t0", "$fp", std::to_string(offset_map["%op1"])});

    /* store i32 %arg0, i32* %op1 */
    codegen->append_inst("store i32 %arg0, i32* %op1", ASMInstruction::Comment);
    // 将 %arg0 的值写入 %op1 对应的内存空间中
    codegen->append_inst("ld.d",
                         {"$t0", "$fp", std::to_string(offset_map["%op1"])});
    codegen->append_inst("ld.w",
                         {"$t1", "$fp", std::to_string(offset_map["%arg0"])});
    codegen->append_inst("st.w $t1, $t0, 0");

    /* %op2 = load i32, i32* %op1 */
    codegen->append_inst("%op2 = load i32, i32* %op1", ASMInstruction::Comment);
    // 将 %op1 对应的内存空间的值写入 %op2 对应的内存空间中
    offset_map["%op2"] = ; // TODO: 请填空
    codegen->append_inst("ld.d",
                         {"$t0", "$fp", std::to_string(offset_map["%op1"])});
    codegen->append_inst("ld.w $t1, $t0, 0");
    codegen->append_inst("st.w",
                         {"$t1", "$fp", std::to_string(offset_map["%op2"])});

    /* %op3 = mul i32 3, %op2 */
    codegen->append_inst("%op3 = mul i32 3, %op2", ASMInstruction::Comment);
    // 将 %op2 的值乘以 3, 并将结果写入 %op3 对应的内存空间中
    offset_map["%op3"] = ; // TODO: 请填空
    codegen->append_inst("ld.w",
                         {"$t0", "$fp", std::to_string(offset_map["%op2"])});
    codegen->append_inst("addi.w $t1, $zero, 3");
    codegen->append_inst("mul.w $t0, $t0, $t1");
    codegen->append_inst("st.w",
                         {"$t0", "$fp", std::to_string(offset_map["%op3"])});

    /* ret i32 %op3 */
    codegen->append_inst("ret i32 %op3", ASMInstruction::Comment);
    // 将 %op3 的值写入 $a0 中
    codegen->append_inst("ld.w",
                         {"$a0", "$fp", std::to_string(offset_map["%op3"])});
    codegen->append_inst("b callee_exit");

    /* callee 函数的 Epilogue (收尾) */
    codegen->append_inst("callee_exit", ASMInstruction::Label);
    // 释放栈帧空间
    codegen->append_inst("addi.d $sp, $sp, 48");
    // 恢复 ra
    codegen->append_inst("ld.d $ra, $sp, -8");
    // 恢复 fp
    codegen->append_inst("ld.d $fp, $sp, -16");
    // 返回
    codegen->append_inst("jr $ra");
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

    /* %op0 = call i32 @callee(i32 110) */
    // 在汇编中写入注释, 方便 debug
    codegen->append_inst("%op0 = call i32 @callee(i32 110)",
                         ASMInstruction::Comment);
    offset_map["%op0"] = ; // TODO: 请填空
    // TODO: 将参数写入参数寄存器
    codegen->append_inst("");
    // TODO: 调用 callee 函数
    codegen->append_inst("");
    // 将返回值写入 %op0 对应的内存空间中
    codegen->append_inst("st.w",
                         {"$a0", "$fp", std::to_string(offset_map["%op0"])});

    /* ret i32 %op0 */
    codegen->append_inst("ret i32 %op0", ASMInstruction::Comment);
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
