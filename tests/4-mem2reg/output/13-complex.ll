; ModuleID = 'cminus'
source_filename = "/home/weith/gits/USTC-2023-compilers-lab/tests/4-mem2reg/functional-cases/13-complex.cminus"

@n = global i32 zeroinitializer
@m = global i32 zeroinitializer
@w = global [5 x i32] zeroinitializer
@v = global [5 x i32] zeroinitializer
@dp = global [66 x i32] zeroinitializer
declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @max(i32 %arg0, i32 %arg1) {
label_entry0:
  %op2 = alloca i32
  store i32 %arg0, i32* %op2
  %op3 = alloca i32
  store i32 %arg1, i32* %op3
  %op4 = icmp sgt i32 %arg0, %arg1
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
define i32 @knapsack(i32 %arg0, i32 %arg1) {
label_entry4:
  %op2 = alloca i32
  store i32 %arg0, i32* %op2
  %op3 = alloca i32
  store i32 %arg1, i32* %op3
  %op4 = alloca i32
  %op5 = icmp sle i32 %arg1, 0
  %op6 = zext i1 %op5 to i32
  %op7 = icmp sgt i32 %op6, 0
  br i1 %op7, label %label_trueBB6, label %label_nextBB5
label_nextBB5:                                                ; preds = %label_entry4
  %op8 = icmp eq i32 %arg0, 0
  %op9 = zext i1 %op8 to i32
  %op10 = icmp sgt i32 %op9, 0
  br i1 %op10, label %label_trueBB8, label %label_nextBB7
label_trueBB6:                                                ; preds = %label_entry4
  ret i32 0
label_nextBB7:                                                ; preds = %label_nextBB5
  %op11 = mul i32 %arg0, 11
  %op12 = add i32 %op11, %arg1
  %op13 = icmp sge i32 %op12, 0
  br i1 %op13, label %label_nextBB10, label %label_negBB11
label_trueBB8:                                                ; preds = %label_nextBB5
  ret i32 0
label_nextBB9:                                                ; preds = %label_nextBB10
  %op14 = sub i32 %arg0, 1
  %op15 = icmp sge i32 %op14, 0
  br i1 %op15, label %label_nextBB16, label %label_negBB17
label_nextBB10:                                                ; preds = %label_nextBB7, %label_negBB11
  %op16 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op12
  %op17 = load i32, i32* %op16
  %op18 = icmp sge i32 %op17, 0
  %op19 = zext i1 %op18 to i32
  %op20 = icmp sgt i32 %op19, 0
  br i1 %op20, label %label_trueBB12, label %label_nextBB9
label_negBB11:                                                ; preds = %label_nextBB7
  call void @neg_idx_except()
  br label %label_nextBB10
label_trueBB12:                                                ; preds = %label_nextBB10
  %op21 = mul i32 %arg0, 11
  %op22 = add i32 %op21, %arg1
  %op23 = icmp sge i32 %op22, 0
  br i1 %op23, label %label_nextBB13, label %label_negBB14
label_nextBB13:                                                ; preds = %label_trueBB12, %label_negBB14
  %op24 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op22
  %op25 = load i32, i32* %op24
  ret i32 %op25
label_negBB14:                                                ; preds = %label_trueBB12
  call void @neg_idx_except()
  br label %label_nextBB13
label_nextBB15:                                                ; preds = %label_trueBB18, %label_nextBB22
  %op26 = phi i32 [ %op36, %label_trueBB18 ], [ %op51, %label_nextBB22 ]
  %op27 = mul i32 %arg0, 11
  %op28 = add i32 %op27, %arg1
  %op29 = icmp sge i32 %op28, 0
  br i1 %op29, label %label_nextBB24, label %label_negBB25
label_nextBB16:                                                ; preds = %label_nextBB9, %label_negBB17
  %op30 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op14
  %op31 = load i32, i32* %op30
  %op32 = icmp slt i32 %arg1, %op31
  %op33 = zext i1 %op32 to i32
  %op34 = icmp sgt i32 %op33, 0
  br i1 %op34, label %label_trueBB18, label %label_falseBB19
label_negBB17:                                                ; preds = %label_nextBB9
  call void @neg_idx_except()
  br label %label_nextBB16
label_trueBB18:                                                ; preds = %label_nextBB16
  %op35 = sub i32 %arg0, 1
  %op36 = call i32 @knapsack(i32 %op35, i32 %arg1)
  store i32 %op36, i32* %op4
  br label %label_nextBB15
label_falseBB19:                                                ; preds = %label_nextBB16
  %op37 = sub i32 %arg0, 1
  %op38 = call i32 @knapsack(i32 %op37, i32 %arg1)
  %op39 = sub i32 %arg0, 1
  %op40 = sub i32 %arg0, 1
  %op41 = icmp sge i32 %op40, 0
  br i1 %op41, label %label_nextBB20, label %label_negBB21
label_nextBB20:                                                ; preds = %label_falseBB19, %label_negBB21
  %op42 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op40
  %op43 = load i32, i32* %op42
  %op44 = sub i32 %arg1, %op43
  %op45 = call i32 @knapsack(i32 %op39, i32 %op44)
  %op46 = sub i32 %arg0, 1
  %op47 = icmp sge i32 %op46, 0
  br i1 %op47, label %label_nextBB22, label %label_negBB23
label_negBB21:                                                ; preds = %label_falseBB19
  call void @neg_idx_except()
  br label %label_nextBB20
label_nextBB22:                                                ; preds = %label_nextBB20, %label_negBB23
  %op48 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 %op46
  %op49 = load i32, i32* %op48
  %op50 = add i32 %op45, %op49
  %op51 = call i32 @max(i32 %op38, i32 %op50)
  store i32 %op51, i32* %op4
  br label %label_nextBB15
label_negBB23:                                                ; preds = %label_nextBB20
  call void @neg_idx_except()
  br label %label_nextBB22
label_nextBB24:                                                ; preds = %label_nextBB15, %label_negBB25
  %op52 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op28
  store i32 %op26, i32* %op52
  ret i32 %op26
label_negBB25:                                                ; preds = %label_nextBB15
  call void @neg_idx_except()
  br label %label_nextBB24
}
define i32 @main() {
label_entry26:
  %op0 = alloca i32
  store i32 0, i32* %op0
  store i32 5, i32* @n
  store i32 10, i32* @m
  %op1 = icmp sge i32 0, 0
  br i1 %op1, label %label_nextBB27, label %label_negBB28
label_nextBB27:                                                ; preds = %label_entry26, %label_negBB28
  %op2 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 0
  store i32 2, i32* %op2
  %op3 = icmp sge i32 1, 0
  br i1 %op3, label %label_nextBB29, label %label_negBB30
label_negBB28:                                                ; preds = %label_entry26
  call void @neg_idx_except()
  br label %label_nextBB27
label_nextBB29:                                                ; preds = %label_nextBB27, %label_negBB30
  %op4 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 1
  store i32 2, i32* %op4
  %op5 = icmp sge i32 2, 0
  br i1 %op5, label %label_nextBB31, label %label_negBB32
label_negBB30:                                                ; preds = %label_nextBB27
  call void @neg_idx_except()
  br label %label_nextBB29
label_nextBB31:                                                ; preds = %label_nextBB29, %label_negBB32
  %op6 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 2
  store i32 6, i32* %op6
  %op7 = icmp sge i32 3, 0
  br i1 %op7, label %label_nextBB33, label %label_negBB34
label_negBB32:                                                ; preds = %label_nextBB29
  call void @neg_idx_except()
  br label %label_nextBB31
label_nextBB33:                                                ; preds = %label_nextBB31, %label_negBB34
  %op8 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 3
  store i32 5, i32* %op8
  %op9 = icmp sge i32 4, 0
  br i1 %op9, label %label_nextBB35, label %label_negBB36
label_negBB34:                                                ; preds = %label_nextBB31
  call void @neg_idx_except()
  br label %label_nextBB33
label_nextBB35:                                                ; preds = %label_nextBB33, %label_negBB36
  %op10 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 4
  store i32 4, i32* %op10
  %op11 = icmp sge i32 0, 0
  br i1 %op11, label %label_nextBB37, label %label_negBB38
label_negBB36:                                                ; preds = %label_nextBB33
  call void @neg_idx_except()
  br label %label_nextBB35
label_nextBB37:                                                ; preds = %label_nextBB35, %label_negBB38
  %op12 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 0
  store i32 6, i32* %op12
  %op13 = icmp sge i32 1, 0
  br i1 %op13, label %label_nextBB39, label %label_negBB40
label_negBB38:                                                ; preds = %label_nextBB35
  call void @neg_idx_except()
  br label %label_nextBB37
label_nextBB39:                                                ; preds = %label_nextBB37, %label_negBB40
  %op14 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 1
  store i32 3, i32* %op14
  %op15 = icmp sge i32 2, 0
  br i1 %op15, label %label_nextBB41, label %label_negBB42
label_negBB40:                                                ; preds = %label_nextBB37
  call void @neg_idx_except()
  br label %label_nextBB39
label_nextBB41:                                                ; preds = %label_nextBB39, %label_negBB42
  %op16 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 2
  store i32 5, i32* %op16
  %op17 = icmp sge i32 3, 0
  br i1 %op17, label %label_nextBB43, label %label_negBB44
label_negBB42:                                                ; preds = %label_nextBB39
  call void @neg_idx_except()
  br label %label_nextBB41
label_nextBB43:                                                ; preds = %label_nextBB41, %label_negBB44
  %op18 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 3
  store i32 4, i32* %op18
  %op19 = icmp sge i32 4, 0
  br i1 %op19, label %label_nextBB45, label %label_negBB46
label_negBB44:                                                ; preds = %label_nextBB41
  call void @neg_idx_except()
  br label %label_nextBB43
label_nextBB45:                                                ; preds = %label_nextBB43, %label_negBB46
  %op20 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 4
  store i32 6, i32* %op20
  br label %label_cmpBB48
label_negBB46:                                                ; preds = %label_nextBB43
  call void @neg_idx_except()
  br label %label_nextBB45
label_nextBB47:                                                ; preds = %label_cmpBB48
  %op21 = call i32 @knapsack(i32 5, i32 10)
  call void @output(i32 %op21)
  ret i32 0
label_cmpBB48:                                                ; preds = %label_nextBB45, %label_nextBB50
  %op22 = phi i32 [ 0, %label_nextBB45 ], [ %op29, %label_nextBB50 ]
  %op23 = icmp slt i32 %op22, 66
  %op24 = zext i1 %op23 to i32
  %op25 = icmp sgt i32 %op24, 0
  br i1 %op25, label %label_whileBB49, label %label_nextBB47
label_whileBB49:                                                ; preds = %label_cmpBB48
  %op26 = icmp sge i32 %op22, 0
  br i1 %op26, label %label_nextBB50, label %label_negBB51
label_nextBB50:                                                ; preds = %label_whileBB49, %label_negBB51
  %op27 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op22
  %op28 = sub i32 0, 1
  store i32 %op28, i32* %op27
  %op29 = add i32 %op22, 1
  store i32 %op29, i32* %op0
  br label %label_cmpBB48
label_negBB51:                                                ; preds = %label_whileBB49
  call void @neg_idx_except()
  br label %label_nextBB50
}
