; ModuleID = 'cminus'
source_filename = "/home/weith/gits/USTC-2023-compilers-lab/tests/4-mem2reg/functional-cases/7-function.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @min(i32 %arg0, i32 %arg1) {
label_entry0:
  %op2 = alloca i32
  store i32 %arg0, i32* %op2
  %op3 = alloca i32
  store i32 %arg1, i32* %op3
  %op4 = icmp sle i32 %arg0, %arg1
  %op5 = zext i1 %op4 to i32
  %op6 = icmp sgt i32 %op5, 0
  br i1 %op6, label %label_trueBB2, label %label_falseBB3
label_nextBB1:
  ret i32 0
label_trueBB2:                                                ; preds = %label_entry0
  ret i32 %arg0
label_falseBB3:                                                ; preds = %label_entry0
  ret i32 %arg1
}
define i32 @main() {
label_entry4:
  %op0 = alloca i32
  %op1 = alloca i32
  %op2 = alloca i32
  store i32 11, i32* %op0
  store i32 22, i32* %op1
  store i32 33, i32* %op2
  %op3 = call i32 @min(i32 11, i32 22)
  call void @output(i32 %op3)
  %op4 = call i32 @min(i32 22, i32 33)
  call void @output(i32 %op4)
  %op5 = call i32 @min(i32 33, i32 11)
  call void @output(i32 %op5)
  ret i32 0
}
