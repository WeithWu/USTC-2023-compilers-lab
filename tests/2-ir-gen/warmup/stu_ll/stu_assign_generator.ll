define i32 @main() {
label_entry:
  %op0 = alloca i32
  %op1 = alloca [10 x i32]
  %op2 = getelementptr [10 x i32], [10 x i32]* %op1, i32 0, i32 0
  store i32 10, i32* %op2
  %op3 = getelementptr [10 x i32], [10 x i32]* %op1, i32 0, i32 0
  %op4 = load i32, i32* %op3
  %op5 = mul i32 2, %op4
  %op6 = getelementptr [10 x i32], [10 x i32]* %op1, i32 0, i32 1
  store i32 %op5, i32* %op6
  %op7 = load i32, i32* %op6
  store i32 %op7, i32* %op0
  %op8 = load i32, i32* %op0
  ret i32 %op8
}
