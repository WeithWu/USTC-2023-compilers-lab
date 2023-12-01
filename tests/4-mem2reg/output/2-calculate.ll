; ModuleID = 'cminus'
source_filename = "/home/weith/gits/USTC-2023-compilers-lab/tests/4-mem2reg/functional-cases/2-calculate.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry0:
  %op0 = alloca i32
  %op1 = alloca i32
  %op2 = alloca i32
  store i32 23, i32* %op0
  store i32 25, i32* %op1
  store i32 4, i32* %op2
  %op3 = mul i32 25, 4
  %op4 = add i32 23, %op3
  ret i32 %op4
}
