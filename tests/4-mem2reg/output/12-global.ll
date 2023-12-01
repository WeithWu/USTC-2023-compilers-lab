; ModuleID = 'cminus'
source_filename = "/home/weith/gits/USTC-2023-compilers-lab/tests/4-mem2reg/functional-cases/12-global.cminus"

@seed = global i32 zeroinitializer
declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @randomLCG() {
label_entry0:
  %op0 = load i32, i32* @seed
  %op1 = mul i32 %op0, 1103515245
  %op2 = add i32 %op1, 12345
  store i32 %op2, i32* @seed
  ret i32 %op2
}
define i32 @randBin() {
label_entry1:
  %op0 = call i32 @randomLCG()
  %op1 = icmp sgt i32 %op0, 0
  %op2 = zext i1 %op1 to i32
  %op3 = icmp sgt i32 %op2, 0
  br i1 %op3, label %label_trueBB3, label %label_falseBB4
label_nextBB2:
  ret i32 0
label_trueBB3:                                                ; preds = %label_entry1
  ret i32 1
label_falseBB4:                                                ; preds = %label_entry1
  ret i32 0
}
define i32 @returnToZeroSteps() {
label_entry5:
  %op0 = alloca i32
  %op1 = alloca i32
  store i32 0, i32* %op0
  store i32 0, i32* %op1
  br label %label_cmpBB7
label_nextBB6:                                                ; preds = %label_cmpBB7
  ret i32 20
label_cmpBB7:                                                ; preds = %label_entry5, %label_nextBB12
  %op2 = phi i32 [ 0, %label_entry5 ], [ %op9, %label_nextBB12 ]
  %op3 = phi i32 [ 0, %label_entry5 ], [ %op10, %label_nextBB12 ]
  %op4 = icmp slt i32 %op3, 20
  %op5 = zext i1 %op4 to i32
  %op6 = icmp sgt i32 %op5, 0
  br i1 %op6, label %label_whileBB8, label %label_nextBB6
label_whileBB8:                                                ; preds = %label_cmpBB7
  %op7 = call i32 @randBin()
  %op8 = icmp sgt i32 %op7, 0
  br i1 %op8, label %label_trueBB10, label %label_falseBB11
label_nextBB9:                                                ; preds = %label_trueBB10, %label_falseBB11
  %op9 = phi i32 [ %op14, %label_trueBB10 ], [ %op15, %label_falseBB11 ]
  %op10 = add i32 %op3, 1
  store i32 %op10, i32* %op1
  %op11 = icmp eq i32 %op9, 0
  %op12 = zext i1 %op11 to i32
  %op13 = icmp sgt i32 %op12, 0
  br i1 %op13, label %label_trueBB13, label %label_nextBB12
label_trueBB10:                                                ; preds = %label_whileBB8
  %op14 = add i32 %op2, 1
  store i32 %op14, i32* %op0
  br label %label_nextBB9
label_falseBB11:                                                ; preds = %label_whileBB8
  %op15 = sub i32 %op2, 1
  store i32 %op15, i32* %op0
  br label %label_nextBB9
label_nextBB12:                                                ; preds = %label_nextBB9
  br label %label_cmpBB7
label_trueBB13:                                                ; preds = %label_nextBB9
  ret i32 %op10
}
define i32 @main() {
label_entry14:
  %op0 = alloca i32
  store i32 0, i32* %op0
  store i32 3407, i32* @seed
  br label %label_cmpBB16
label_nextBB15:                                                ; preds = %label_cmpBB16
  ret i32 0
label_cmpBB16:                                                ; preds = %label_entry14, %label_whileBB17
  %op1 = phi i32 [ 0, %label_entry14 ], [ %op6, %label_whileBB17 ]
  %op2 = icmp slt i32 %op1, 20
  %op3 = zext i1 %op2 to i32
  %op4 = icmp sgt i32 %op3, 0
  br i1 %op4, label %label_whileBB17, label %label_nextBB15
label_whileBB17:                                                ; preds = %label_cmpBB16
  %op5 = call i32 @returnToZeroSteps()
  call void @output(i32 %op5)
  %op6 = add i32 %op1, 1
  store i32 %op6, i32* %op0
  br label %label_cmpBB16
}
