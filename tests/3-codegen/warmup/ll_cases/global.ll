@a = global i32 zeroinitializer

define i32 @main() {
label_entry:
  store i32 10, i32* @a
  %op0 = load i32, i32* @a
  ret i32 %op0
}
