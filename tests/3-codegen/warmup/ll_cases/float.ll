define i32 @main() {
label_entry:
  %op0 = alloca float
  store float 0x40091eb860000000, float* %op0 ; 3.14, FP32 0x4048f5c3
  %op1 = load float, float* %op0
  %op2 = fptosi float %op1 to i32
  ret i32 %op2
}
