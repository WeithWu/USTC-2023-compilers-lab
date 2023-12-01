; ModuleID = 'cminus'
source_filename = "/home/weith/gits/USTC-2023-compilers-lab/tests/4-mem2reg/functional-cases/8-store.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @store(i32* %arg0, i32 %arg1, i32 %arg2) {
label_entry0:
  %op3 = alloca i32*
  store i32* %arg0, i32** %op3
  %op4 = alloca i32
  store i32 %arg1, i32* %op4
  %op5 = alloca i32
  store i32 %arg2, i32* %op5
  %op6 = icmp sge i32 %arg1, 0
  br i1 %op6, label %label_nextBB1, label %label_negBB2
label_nextBB1:                                                ; preds = %label_entry0, %label_negBB2
  %op7 = getelementptr i32, i32* %arg0, i32 %arg1
  store i32 %arg2, i32* %op7
  ret i32 %arg2
label_negBB2:                                                ; preds = %label_entry0
  call void @neg_idx_except()
  br label %label_nextBB1
}
define i32 @main() {
label_entry3:
  %op0 = alloca [10 x i32]
  %op1 = alloca i32
  %op2 = alloca i32
  store i32 0, i32* %op1
  br label %label_cmpBB5
label_nextBB4:                                                ; preds = %label_cmpBB5
  store i32 0, i32* %op2
  store i32 0, i32* %op1
  br label %label_cmpBB8
label_cmpBB5:                                                ; preds = %label_entry3, %label_whileBB6
  %op3 = phi i32 [ 0, %label_entry3 ], [ %op10, %label_whileBB6 ]
  %op4 = icmp slt i32 %op3, 10
  %op5 = zext i1 %op4 to i32
  %op6 = icmp sgt i32 %op5, 0
  br i1 %op6, label %label_whileBB6, label %label_nextBB4
label_whileBB6:                                                ; preds = %label_cmpBB5
  %op7 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  %op8 = mul i32 %op3, 2
  %op9 = call i32 @store(i32* %op7, i32 %op3, i32 %op8)
  %op10 = add i32 %op3, 1
  store i32 %op10, i32* %op1
  br label %label_cmpBB5
label_nextBB7:                                                ; preds = %label_cmpBB8
  call void @output(i32 %op12)
  ret i32 0
label_cmpBB8:                                                ; preds = %label_nextBB4, %label_nextBB10
  %op11 = phi i32 [ 0, %label_nextBB4 ], [ %op20, %label_nextBB10 ]
  %op12 = phi i32 [ 0, %label_nextBB4 ], [ %op19, %label_nextBB10 ]
  %op13 = icmp slt i32 %op11, 10
  %op14 = zext i1 %op13 to i32
  %op15 = icmp sgt i32 %op14, 0
  br i1 %op15, label %label_whileBB9, label %label_nextBB7
label_whileBB9:                                                ; preds = %label_cmpBB8
  %op16 = icmp sge i32 %op11, 0
  br i1 %op16, label %label_nextBB10, label %label_negBB11
label_nextBB10:                                                ; preds = %label_whileBB9, %label_negBB11
  %op17 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 %op11
  %op18 = load i32, i32* %op17
  %op19 = add i32 %op12, %op18
  store i32 %op19, i32* %op2
  %op20 = add i32 %op11, 1
  store i32 %op20, i32* %op1
  br label %label_cmpBB8
label_negBB11:                                                ; preds = %label_whileBB9
  call void @neg_idx_except()
  br label %label_nextBB10
}
