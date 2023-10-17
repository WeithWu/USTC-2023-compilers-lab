define i32 @main() {
label_entry:
  ; 5.5 (0x40b00000) > 1.0 (0x3f800000)
  %op0 = fcmp ugt float 0x4016000000000000, 0x3ff0000000000000
  %op1 = zext i1 %op0 to i32
  %op2 = icmp ne i32 %op1, 0
  br i1 %op2, label %label3, label %label4
label3:                                                ; preds = %label_entry
  ret i32 233
label4:                                                ; preds = %label_entry
  ret i32 0
}
