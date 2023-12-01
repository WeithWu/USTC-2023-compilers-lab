; ModuleID = 'cminus'
source_filename = "/home/weith/gits/USTC-2023-compilers-lab/tests/4-mem2reg/functional-cases/5-while.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry0:
  %op0 = alloca i32
  %op1 = alloca i32
  store i32 10, i32* %op0
  store i32 0, i32* %op1
  br label %label_cmpBB2
label_nextBB1:                                                ; preds = %label_cmpBB2
  ret i32 0
label_cmpBB2:                                                ; preds = %label_entry0, %label_whileBB3
  %op2 = phi i32 [ 0, %label_entry0 ], [ %op6, %label_whileBB3 ]
  %op3 = icmp slt i32 %op2, 10
  %op4 = zext i1 %op3 to i32
  %op5 = icmp sgt i32 %op4, 0
  br i1 %op5, label %label_whileBB3, label %label_nextBB1
label_whileBB3:                                                ; preds = %label_cmpBB2
  call void @output(i32 %op2)
  %op6 = add i32 %op2, 1
  store i32 %op6, i32* %op1
  br label %label_cmpBB2
}
