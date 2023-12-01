; ModuleID = 'cminus'
source_filename = "/home/weith/gits/USTC-2023-compilers-lab/tests/4-mem2reg/functional-cases/3-output.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry0:
  call void @output(i32 11)
  call void @output(i32 22222)
  ret i32 0
}
