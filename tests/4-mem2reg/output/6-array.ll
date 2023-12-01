; ModuleID = 'cminus'
source_filename = "/home/weith/gits/USTC-2023-compilers-lab/tests/4-mem2reg/functional-cases/6-array.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry0:
  %op0 = alloca [10 x i32]
  %op1 = alloca i32
  store i32 0, i32* %op1
  %op2 = icmp sge i32 0, 0
  br i1 %op2, label %label_nextBB1, label %label_negBB2
label_nextBB1:                                                ; preds = %label_entry0, %label_negBB2
  %op3 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  store i32 11, i32* %op3
  %op4 = icmp sge i32 4, 0
  br i1 %op4, label %label_nextBB3, label %label_negBB4
label_negBB2:                                                ; preds = %label_entry0
  call void @neg_idx_except()
  br label %label_nextBB1
label_nextBB3:                                                ; preds = %label_nextBB1, %label_negBB4
  %op5 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
  store i32 22, i32* %op5
  %op6 = icmp sge i32 9, 0
  br i1 %op6, label %label_nextBB5, label %label_negBB6
label_negBB4:                                                ; preds = %label_nextBB1
  call void @neg_idx_except()
  br label %label_nextBB3
label_nextBB5:                                                ; preds = %label_nextBB3, %label_negBB6
  %op7 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
  store i32 33, i32* %op7
  %op8 = icmp sge i32 0, 0
  br i1 %op8, label %label_nextBB7, label %label_negBB8
label_negBB6:                                                ; preds = %label_nextBB3
  call void @neg_idx_except()
  br label %label_nextBB5
label_nextBB7:                                                ; preds = %label_nextBB5, %label_negBB8
  %op9 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  %op10 = load i32, i32* %op9
  call void @output(i32 %op10)
  %op11 = icmp sge i32 4, 0
  br i1 %op11, label %label_nextBB9, label %label_negBB10
label_negBB8:                                                ; preds = %label_nextBB5
  call void @neg_idx_except()
  br label %label_nextBB7
label_nextBB9:                                                ; preds = %label_nextBB7, %label_negBB10
  %op12 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
  %op13 = load i32, i32* %op12
  call void @output(i32 %op13)
  %op14 = icmp sge i32 9, 0
  br i1 %op14, label %label_nextBB11, label %label_negBB12
label_negBB10:                                                ; preds = %label_nextBB7
  call void @neg_idx_except()
  br label %label_nextBB9
label_nextBB11:                                                ; preds = %label_nextBB9, %label_negBB12
  %op15 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
  %op16 = load i32, i32* %op15
  call void @output(i32 %op16)
  ret i32 0
label_negBB12:                                                ; preds = %label_nextBB9
  call void @neg_idx_except()
  br label %label_nextBB11
}
