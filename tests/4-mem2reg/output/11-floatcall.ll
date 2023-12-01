; ModuleID = 'cminus'
source_filename = "/home/weith/gits/USTC-2023-compilers-lab/tests/4-mem2reg/functional-cases/11-floatcall.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define float @mod(float %arg0, float %arg1) {
label_entry0:
  %op2 = alloca float
  store float %arg0, float* %op2
  %op3 = alloca float
  store float %arg1, float* %op3
  %op4 = alloca i32
  %op5 = fdiv float %arg0, %arg1
  %op6 = fptosi float %op5 to i32
  store i32 %op6, i32* %op4
  %op7 = sitofp i32 %op6 to float
  %op8 = fmul float %op7, %arg1
  %op9 = fsub float %arg0, %op8
  ret float %op9
}
define i32 @main() {
label_entry1:
  %op0 = alloca float
  %op1 = alloca float
  store float 0x4026666660000000, float* %op0
  store float 0x40019999a0000000, float* %op1
  %op2 = call float @mod(float 0x4026666660000000, float 0x40019999a0000000)
  call void @outputFloat(float %op2)
  ret i32 0
}
