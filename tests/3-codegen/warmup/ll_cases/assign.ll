define i32 @main() {
label_entry:
  %op0 = alloca [10 x i32]
  %op1 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  store i32 10, i32* %op1
  %op2 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 1
  %op3 = load i32, i32* %op1
  %op4 = mul i32 %op3, 3
  store i32 %op4, i32* %op2
  %op5 = load i32, i32* %op2
  ret i32 %op5
}
