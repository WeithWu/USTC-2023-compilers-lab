; ModuleID = 'cminus'
source_filename = "/home/weith/gits/USTC-2023-compilers-lab/tests/4-mem2reg/functional-cases/9-fibonacci.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @fibonacci(i32 %arg0) {
label_entry0:
  %op1 = alloca i32
  store i32 %arg0, i32* %op1
  %op2 = icmp eq i32 %arg0, 0
  %op3 = zext i1 %op2 to i32
  %op4 = icmp sgt i32 %op3, 0
  br i1 %op4, label %label_trueBB2, label %label_falseBB3
label_nextBB1:                                                ; preds = %label_nextBB4
  ret i32 0
label_trueBB2:                                                ; preds = %label_entry0
  ret i32 0
label_falseBB3:                                                ; preds = %label_entry0
  %op5 = icmp eq i32 %arg0, 1
  %op6 = zext i1 %op5 to i32
  %op7 = icmp sgt i32 %op6, 0
  br i1 %op7, label %label_trueBB5, label %label_falseBB6
label_nextBB4:
  br label %label_nextBB1
label_trueBB5:                                                ; preds = %label_falseBB3
  ret i32 1
label_falseBB6:                                                ; preds = %label_falseBB3
  %op8 = sub i32 %arg0, 1
  %op9 = call i32 @fibonacci(i32 %op8)
  %op10 = sub i32 %arg0, 2
  %op11 = call i32 @fibonacci(i32 %op10)
  %op12 = add i32 %op9, %op11
  ret i32 %op12
}
define i32 @main() {
label_entry7:
  %op0 = alloca i32
  %op1 = alloca i32
  store i32 10, i32* %op0
  store i32 0, i32* %op1
  br label %label_cmpBB9
label_nextBB8:                                                ; preds = %label_cmpBB9
  ret i32 0
label_cmpBB9:                                                ; preds = %label_entry7, %label_whileBB10
  %op2 = phi i32 [ 0, %label_entry7 ], [ %op7, %label_whileBB10 ]
  %op3 = icmp slt i32 %op2, 10
  %op4 = zext i1 %op3 to i32
  %op5 = icmp sgt i32 %op4, 0
  br i1 %op5, label %label_whileBB10, label %label_nextBB8
label_whileBB10:                                                ; preds = %label_cmpBB9
  %op6 = call i32 @fibonacci(i32 %op2)
  call void @output(i32 %op6)
  %op7 = add i32 %op2, 1
  store i32 %op7, i32* %op1
  br label %label_cmpBB9
}
