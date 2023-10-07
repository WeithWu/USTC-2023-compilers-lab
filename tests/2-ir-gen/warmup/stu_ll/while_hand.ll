define i32 @main() {
label_entry:
  %0 = alloca i32
  %1 = alloca i32
  store i32 10, i32* %0
  store i32 0, i32* %1
  br label %label_cmpBB
label_whilBB:                                               
  %2 = load i32, i32* %1
  %3 = load i32, i32* %0
  %4 = add i32 1, %2
  store i32 %4, i32* %1
  %5 = load i32, i32* %1
  %6 = add i32 %5, %3
  store i32 %6, i32* %0
  br label %label_cmpBB
label_retBB:                                                
  %7 = load i32, i32* %0
  ret i32 %7
label_cmpBB:                                                
  %8 = load i32, i32* %1
  %9 = icmp slt i32 %8, 10
  br i1 %9, label %label_whilBB, label %label_retBB
}