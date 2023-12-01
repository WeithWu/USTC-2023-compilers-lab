; ModuleID = 'cminus'
source_filename = "/home/weith/gits/USTC-2023-compilers-lab/tests/4-mem2reg/functional-cases/10-float.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry0:
  %op0 = alloca float
  %op1 = alloca float
  %op2 = alloca float
  store float 0x3ff19999a0000000, float* %op0
  store float 0x3ff8000000000000, float* %op1
  store float 0x3ff3333340000000, float* %op2
  %op3 = fmul float 0x3ff19999a0000000, 0x3ff8000000000000
  %op4 = fadd float %op3, 0x3ff3333340000000
  call void @outputFloat(float %op4)
  ret i32 0
}
