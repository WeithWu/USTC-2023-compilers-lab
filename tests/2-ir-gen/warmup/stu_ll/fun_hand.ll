define i32 @callee(i32 %arg0) {
  %1 = alloca i32
  %2 = alloca i32
  store i32 %arg0, i32* %1
  %3 = load i32, i32* %1
  %4 = mul i32 2, %3
  store i32 %4, i32* %2
  %5 = load i32, i32* %2
  ret i32 %5
}
define i32 @main() {
  %0 = call i32 @callee(i32 110)
  ret i32 %0
}
