define i32 @main() {
label_entry:
  %op0 = icmp sgt i32 5, 1
  %op1 = zext i1 %op0 to i32
  %op2 = icmp ne i32 %op1, 0
  br i1 %op2, label %label3, label %label4
label3:                                                ; preds = %label_entry
  ret i32 233
label4:                                                ; preds = %label_entry
  ret i32 0
}
