define i32 @main() {
label_entry:
  %op0 = alloca float
  store float 0x40163851e0000000, float* %op0
  %op1 = load float, float* %op0
  %op2 = fcmp ugt float %op1, 0x3ff0000000000000
  br i1 %op2, label %label_trueBB, label %label_retBB
label_trueBB:                                                ; preds = %label_entry
  %op3 = alloca i32
  store i32 233, i32* %op3
  %op4 = load i32, i32* %op3
  ret i32 %op4
label_retBB:                                                ; preds = %label_entry
  %op5 = alloca i32
  store i32 0, i32* %op5
  %op6 = load i32, i32* %op5
  ret i32 %op6
}
