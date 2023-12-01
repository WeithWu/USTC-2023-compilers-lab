; ModuleID = 'cminus'
source_filename = "/home/weith/gits/USTC-2023-compilers-lab/tests/4-mem2reg/functional-cases/4-if.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry0:
  %op0 = alloca i32
  %op1 = alloca i32
  %op2 = alloca i32
  store i32 11, i32* %op0
  store i32 22, i32* %op1
  store i32 33, i32* %op2
  %op3 = icmp sgt i32 11, 22
  %op4 = zext i1 %op3 to i32
  %op5 = icmp sgt i32 %op4, 0
  br i1 %op5, label %label_trueBB2, label %label_falseBB3
label_nextBB1:                                                ; preds = %label_nextBB4, %label_nextBB7
  ret i32 0
label_trueBB2:                                                ; preds = %label_entry0
  %op6 = icmp sgt i32 11, 33
  %op7 = zext i1 %op6 to i32
  %op8 = icmp sgt i32 %op7, 0
  br i1 %op8, label %label_trueBB5, label %label_falseBB6
label_falseBB3:                                                ; preds = %label_entry0
  %op9 = icmp slt i32 33, 22
  %op10 = zext i1 %op9 to i32
  %op11 = icmp sgt i32 %op10, 0
  br i1 %op11, label %label_trueBB8, label %label_falseBB9
label_nextBB4:                                                ; preds = %label_trueBB5, %label_falseBB6
  br label %label_nextBB1
label_trueBB5:                                                ; preds = %label_trueBB2
  call void @output(i32 11)
  br label %label_nextBB4
label_falseBB6:                                                ; preds = %label_trueBB2
  call void @output(i32 33)
  br label %label_nextBB4
label_nextBB7:                                                ; preds = %label_trueBB8, %label_falseBB9
  br label %label_nextBB1
label_trueBB8:                                                ; preds = %label_falseBB3
  call void @output(i32 22)
  br label %label_nextBB7
label_falseBB9:                                                ; preds = %label_falseBB3
  call void @output(i32 33)
  br label %label_nextBB7
}
