define i32 @main() {
label_entry:
  %0 = alloca float
  store float 0x40163851e0000000, float* %0
  %1 = load float, float* %0
  %2 = fcmp ugt float %1, 0x3ff0000000000000
  br i1 %2, label %label_trueBB, label %label_retBB
label_trueBB:                                               
  %3 = alloca i32
  store i32 233, i32* %3
  %4 = load i32, i32* %3
  ret i32 %4
label_retBB:                                                
  %5 = alloca i32
  store i32 0, i32* %5
  %6 = load i32, i32* %5
  ret i32 %6
}