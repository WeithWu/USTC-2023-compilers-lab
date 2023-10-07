define i32 @main() {
label_entry:
  %op0 = alloca i32
  %op1 = alloca i32
  store i32 10, i32* %op0
  store i32 0, i32* %op1
  br label %label_cmpBB
label_whilBB:                                                ; preds = %label_cmpBB
  %op2 = load i32, i32* %op1
  %op3 = load i32, i32* %op0
  %op4 = add i32 1, %op2
  store i32 %op4, i32* %op1
  %op5 = load i32, i32* %op1
  %op6 = add i32 %op5, %op3
  store i32 %op6, i32* %op0
  br label %label_cmpBB
label_retBB:                                                ; preds = %label_cmpBB
  %op7 = load i32, i32* %op0
  ret i32 %op7
label_cmpBB:                                                ; preds = %label_entry, %label_whilBB
  %op8 = load i32, i32* %op1
  %op9 = icmp slt i32 %op8, 10
  br i1 %op9, label %label_whilBB, label %label_retBB
}
