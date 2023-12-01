# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl n
	.type n, @object
	.size n, 4
n:
	.space 4
	.globl m
	.type m, @object
	.size m, 4
m:
	.space 4
	.globl w
	.type w, @object
	.size w, 20
w:
	.space 20
	.globl v
	.type v, @object
	.size v, 20
v:
	.space 20
	.globl dp
	.type dp, @object
	.size dp, 264
dp:
	.space 264
	.text
	.globl max
	.type max, @function
max:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.max_label_entry0:
# %op2 = alloca i32
	addi.d $t1, $fp, -36
	st.d $t1, $fp, -32
# store i32 %arg0, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t1, $fp, -20
	st.w $t1, $t0, 0
# %op3 = alloca i32
	addi.d $t1, $fp, -52
	st.d $t1, $fp, -48
# store i32 %arg1, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t1, $fp, -24
	st.w $t1, $t0, 0
# %op4 = icmp sgt i32 %arg0, %arg1
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -24
	slt $t0, $t1, $t0
	st.b $t0, $fp, -53
# %op5 = zext i1 %op4 to i32
	ld.b $t0, $fp, -53
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -60
# %op6 = icmp sgt i32 %op5, 0
	ld.w $t0, $fp, -60
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -61
# br i1 %op6, label %label_trueBB2, label %label_falseBB3
	ld.b $t0, $fp, -61
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .max_label_trueBB2
	b .max_label_falseBB3
.max_label_nextBB1:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.max_label_trueBB2:
# ret i32 %arg0
	ld.w $a0, $fp, -20
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.max_label_falseBB3:
# ret i32 %arg1
	ld.w $a0, $fp, -24
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl knapsack
	.type knapsack, @function
knapsack:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -304
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.knapsack_label_entry4:
# %op2 = alloca i32
	addi.d $t1, $fp, -36
	st.d $t1, $fp, -32
# store i32 %arg0, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t1, $fp, -20
	st.w $t1, $t0, 0
# %op3 = alloca i32
	addi.d $t1, $fp, -52
	st.d $t1, $fp, -48
# store i32 %arg1, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t1, $fp, -24
	st.w $t1, $t0, 0
# %op4 = alloca i32
	addi.d $t1, $fp, -68
	st.d $t1, $fp, -64
# %op5 = icmp sle i32 %arg1, 0
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 0
	addi.w $t1, $t1, 1
	slt $t0, $t0, $t1
	st.b $t0, $fp, -69
# %op6 = zext i1 %op5 to i32
	ld.b $t0, $fp, -69
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -76
# %op7 = icmp sgt i32 %op6, 0
	ld.w $t0, $fp, -76
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -77
# br i1 %op7, label %label_trueBB6, label %label_nextBB5
	ld.b $t0, $fp, -77
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .knapsack_label_trueBB6
	b .knapsack_label_nextBB5
.knapsack_label_nextBB5:
# %op8 = icmp eq i32 %arg0, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	slt $t3, $t1, $t0
	nor $t0, $t2, $t3
	st.b $t0, $fp, -78
# %op9 = zext i1 %op8 to i32
	ld.b $t0, $fp, -78
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -84
# %op10 = icmp sgt i32 %op9, 0
	ld.w $t0, $fp, -84
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -85
# br i1 %op10, label %label_trueBB8, label %label_nextBB7
	ld.b $t0, $fp, -85
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .knapsack_label_trueBB8
	b .knapsack_label_nextBB7
.knapsack_label_trueBB6:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 304
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.knapsack_label_nextBB7:
# %op11 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -92
# %op12 = add i32 %op11, %arg1
	ld.w $t0, $fp, -92
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -96
# %op13 = icmp sge i32 %op12, 0
	ld.w $t0, $fp, -96
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -97
# br i1 %op13, label %label_nextBB10, label %label_negBB11
	ld.b $t0, $fp, -97
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .knapsack_label_nextBB10
	b .knapsack_label_negBB11
.knapsack_label_trueBB8:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 304
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.knapsack_label_nextBB9:
# %op14 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -104
# %op15 = icmp sge i32 %op14, 0
	ld.w $t0, $fp, -104
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -105
# br i1 %op15, label %label_nextBB16, label %label_negBB17
	ld.b $t0, $fp, -105
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .knapsack_label_nextBB16
	b .knapsack_label_negBB17
.knapsack_label_nextBB10:
# %op16 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op12
	la.local $t0, dp
	addi.w $t1, $zero, 0
	ld.w $t2, $fp, -96
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 264
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -120
# %op17 = load i32, i32* %op16
	ld.d $t0, $fp, -120
	ld.d $t0, $t0, 0
	st.w $t0, $fp, -124
# %op18 = icmp sge i32 %op17, 0
	ld.w $t0, $fp, -124
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -125
# %op19 = zext i1 %op18 to i32
	ld.b $t0, $fp, -125
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -132
# %op20 = icmp sgt i32 %op19, 0
	ld.w $t0, $fp, -132
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -133
# br i1 %op20, label %label_trueBB12, label %label_nextBB9
	ld.b $t0, $fp, -133
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .knapsack_label_trueBB12
	b .knapsack_label_nextBB9
.knapsack_label_negBB11:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB10
	b .knapsack_label_nextBB10
.knapsack_label_trueBB12:
# %op21 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -140
# %op22 = add i32 %op21, %arg1
	ld.w $t0, $fp, -140
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -144
# %op23 = icmp sge i32 %op22, 0
	ld.w $t0, $fp, -144
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -145
# br i1 %op23, label %label_nextBB13, label %label_negBB14
	ld.b $t0, $fp, -145
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .knapsack_label_nextBB13
	b .knapsack_label_negBB14
.knapsack_label_nextBB13:
# %op24 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op22
	la.local $t0, dp
	addi.w $t1, $zero, 0
	ld.w $t2, $fp, -144
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 264
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -160
# %op25 = load i32, i32* %op24
	ld.d $t0, $fp, -160
	ld.d $t0, $t0, 0
	st.w $t0, $fp, -164
# ret i32 %op25
	ld.w $a0, $fp, -164
	addi.d $sp, $sp, 304
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.knapsack_label_negBB14:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB13
	b .knapsack_label_nextBB13
.knapsack_label_nextBB15:
# %op26 = phi i32 [ %op36, %label_trueBB18 ], [ %op51, %label_nextBB22 ]
# %op27 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -172
# %op28 = add i32 %op27, %arg1
	ld.w $t0, $fp, -172
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -176
# %op29 = icmp sge i32 %op28, 0
	ld.w $t0, $fp, -176
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -177
# br i1 %op29, label %label_nextBB24, label %label_negBB25
	ld.b $t0, $fp, -177
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .knapsack_label_nextBB24
	b .knapsack_label_negBB25
.knapsack_label_nextBB16:
# %op30 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op14
	la.local $t0, w
	addi.w $t1, $zero, 0
	ld.w $t2, $fp, -104
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 20
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -192
# %op31 = load i32, i32* %op30
	ld.d $t0, $fp, -192
	ld.d $t0, $t0, 0
	st.w $t0, $fp, -196
# %op32 = icmp slt i32 %arg1, %op31
	ld.w $t0, $fp, -24
	ld.w $t1, $fp, -196
	slt $t0, $t0, $t1
	st.b $t0, $fp, -197
# %op33 = zext i1 %op32 to i32
	ld.b $t0, $fp, -197
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -204
# %op34 = icmp sgt i32 %op33, 0
	ld.w $t0, $fp, -204
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -205
# br i1 %op34, label %label_trueBB18, label %label_falseBB19
	ld.b $t0, $fp, -205
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .knapsack_label_trueBB18
	b .knapsack_label_falseBB19
.knapsack_label_negBB17:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB16
	b .knapsack_label_nextBB16
.knapsack_label_trueBB18:
# %op35 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -212
# %op36 = call i32 @knapsack(i32 %op35, i32 %arg1)
	ld.w $a0, $fp, -212
	ld.w $a1, $fp, -24
	bl knapsack
	st.w $a0, $fp, -216
# store i32 %op36, i32* %op4
	ld.d $t0, $fp, -64
	ld.w $t1, $fp, -216
	st.w $t1, $t0, 0
# br label %label_nextBB15
	ld.w $t8, $fp, -216
	st.w $t8, $fp, -168
	b .knapsack_label_nextBB15
.knapsack_label_falseBB19:
# %op37 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -220
# %op38 = call i32 @knapsack(i32 %op37, i32 %arg1)
	ld.w $a0, $fp, -220
	ld.w $a1, $fp, -24
	bl knapsack
	st.w $a0, $fp, -224
# %op39 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -228
# %op40 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -232
# %op41 = icmp sge i32 %op40, 0
	ld.w $t0, $fp, -232
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -233
# br i1 %op41, label %label_nextBB20, label %label_negBB21
	ld.b $t0, $fp, -233
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .knapsack_label_nextBB20
	b .knapsack_label_negBB21
.knapsack_label_nextBB20:
# %op42 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op40
	la.local $t0, w
	addi.w $t1, $zero, 0
	ld.w $t2, $fp, -232
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 20
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -248
# %op43 = load i32, i32* %op42
	ld.d $t0, $fp, -248
	ld.d $t0, $t0, 0
	st.w $t0, $fp, -252
# %op44 = sub i32 %arg1, %op43
	ld.w $t0, $fp, -24
	ld.w $t1, $fp, -252
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -256
# %op45 = call i32 @knapsack(i32 %op39, i32 %op44)
	ld.w $a0, $fp, -228
	ld.w $a1, $fp, -256
	bl knapsack
	st.w $a0, $fp, -260
# %op46 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -264
# %op47 = icmp sge i32 %op46, 0
	ld.w $t0, $fp, -264
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -265
# br i1 %op47, label %label_nextBB22, label %label_negBB23
	ld.b $t0, $fp, -265
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .knapsack_label_nextBB22
	b .knapsack_label_negBB23
.knapsack_label_negBB21:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB20
	b .knapsack_label_nextBB20
.knapsack_label_nextBB22:
# %op48 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 %op46
	la.local $t0, v
	addi.w $t1, $zero, 0
	ld.w $t2, $fp, -264
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 20
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -280
# %op49 = load i32, i32* %op48
	ld.d $t0, $fp, -280
	ld.d $t0, $t0, 0
	st.w $t0, $fp, -284
# %op50 = add i32 %op45, %op49
	ld.w $t0, $fp, -260
	ld.w $t1, $fp, -284
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -288
# %op51 = call i32 @max(i32 %op38, i32 %op50)
	ld.w $a0, $fp, -224
	ld.w $a1, $fp, -288
	bl max
	st.w $a0, $fp, -292
# store i32 %op51, i32* %op4
	ld.d $t0, $fp, -64
	ld.w $t1, $fp, -292
	st.w $t1, $t0, 0
# br label %label_nextBB15
	ld.w $t8, $fp, -292
	st.w $t8, $fp, -168
	b .knapsack_label_nextBB15
.knapsack_label_negBB23:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB22
	b .knapsack_label_nextBB22
.knapsack_label_nextBB24:
# %op52 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op28
	la.local $t0, dp
	addi.w $t1, $zero, 0
	ld.w $t2, $fp, -176
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 264
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -304
# store i32 %op26, i32* %op52
	ld.d $t0, $fp, -304
	ld.w $t1, $fp, -168
	st.w $t1, $t0, 0
# ret i32 %op26
	ld.w $a0, $fp, -168
	addi.d $sp, $sp, 304
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.knapsack_label_negBB25:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB24
	b .knapsack_label_nextBB24
	addi.d $sp, $sp, 304
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -224
.main_label_entry26:
# %op0 = alloca i32
	addi.d $t1, $fp, -28
	st.d $t1, $fp, -24
# store i32 0, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# store i32 5, i32* @n
	la.local $t0, n
	addi.w $t1, $zero, 5
	st.w $t1, $t0, 0
# store i32 10, i32* @m
	la.local $t0, m
	addi.w $t1, $zero, 10
	st.w $t1, $t0, 0
# %op1 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -29
# br i1 %op1, label %label_nextBB27, label %label_negBB28
	ld.b $t0, $fp, -29
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB27
	b .main_label_negBB28
.main_label_nextBB27:
# %op2 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 0
	la.local $t0, w
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 0
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 20
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -40
# store i32 2, i32* %op2
	ld.d $t0, $fp, -40
	addi.w $t1, $zero, 2
	st.w $t1, $t0, 0
# %op3 = icmp sge i32 1, 0
	addi.w $t0, $zero, 1
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -41
# br i1 %op3, label %label_nextBB29, label %label_negBB30
	ld.b $t0, $fp, -41
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB29
	b .main_label_negBB30
.main_label_negBB28:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB27
	b .main_label_nextBB27
.main_label_nextBB29:
# %op4 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 1
	la.local $t0, w
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 1
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 20
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -56
# store i32 2, i32* %op4
	ld.d $t0, $fp, -56
	addi.w $t1, $zero, 2
	st.w $t1, $t0, 0
# %op5 = icmp sge i32 2, 0
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -57
# br i1 %op5, label %label_nextBB31, label %label_negBB32
	ld.b $t0, $fp, -57
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB31
	b .main_label_negBB32
.main_label_negBB30:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB29
	b .main_label_nextBB29
.main_label_nextBB31:
# %op6 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 2
	la.local $t0, w
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 2
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 20
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -72
# store i32 6, i32* %op6
	ld.d $t0, $fp, -72
	addi.w $t1, $zero, 6
	st.w $t1, $t0, 0
# %op7 = icmp sge i32 3, 0
	addi.w $t0, $zero, 3
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -73
# br i1 %op7, label %label_nextBB33, label %label_negBB34
	ld.b $t0, $fp, -73
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB33
	b .main_label_negBB34
.main_label_negBB32:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB31
	b .main_label_nextBB31
.main_label_nextBB33:
# %op8 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 3
	la.local $t0, w
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 3
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 20
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -88
# store i32 5, i32* %op8
	ld.d $t0, $fp, -88
	addi.w $t1, $zero, 5
	st.w $t1, $t0, 0
# %op9 = icmp sge i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -89
# br i1 %op9, label %label_nextBB35, label %label_negBB36
	ld.b $t0, $fp, -89
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB35
	b .main_label_negBB36
.main_label_negBB34:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB33
	b .main_label_nextBB33
.main_label_nextBB35:
# %op10 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 4
	la.local $t0, w
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 4
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 20
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -104
# store i32 4, i32* %op10
	ld.d $t0, $fp, -104
	addi.w $t1, $zero, 4
	st.w $t1, $t0, 0
# %op11 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -105
# br i1 %op11, label %label_nextBB37, label %label_negBB38
	ld.b $t0, $fp, -105
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB37
	b .main_label_negBB38
.main_label_negBB36:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB35
	b .main_label_nextBB35
.main_label_nextBB37:
# %op12 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 0
	la.local $t0, v
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 0
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 20
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -120
# store i32 6, i32* %op12
	ld.d $t0, $fp, -120
	addi.w $t1, $zero, 6
	st.w $t1, $t0, 0
# %op13 = icmp sge i32 1, 0
	addi.w $t0, $zero, 1
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -121
# br i1 %op13, label %label_nextBB39, label %label_negBB40
	ld.b $t0, $fp, -121
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB39
	b .main_label_negBB40
.main_label_negBB38:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB37
	b .main_label_nextBB37
.main_label_nextBB39:
# %op14 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 1
	la.local $t0, v
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 1
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 20
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -136
# store i32 3, i32* %op14
	ld.d $t0, $fp, -136
	addi.w $t1, $zero, 3
	st.w $t1, $t0, 0
# %op15 = icmp sge i32 2, 0
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -137
# br i1 %op15, label %label_nextBB41, label %label_negBB42
	ld.b $t0, $fp, -137
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB41
	b .main_label_negBB42
.main_label_negBB40:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB39
	b .main_label_nextBB39
.main_label_nextBB41:
# %op16 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 2
	la.local $t0, v
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 2
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 20
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -152
# store i32 5, i32* %op16
	ld.d $t0, $fp, -152
	addi.w $t1, $zero, 5
	st.w $t1, $t0, 0
# %op17 = icmp sge i32 3, 0
	addi.w $t0, $zero, 3
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -153
# br i1 %op17, label %label_nextBB43, label %label_negBB44
	ld.b $t0, $fp, -153
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB43
	b .main_label_negBB44
.main_label_negBB42:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB41
	b .main_label_nextBB41
.main_label_nextBB43:
# %op18 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 3
	la.local $t0, v
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 3
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 20
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -168
# store i32 4, i32* %op18
	ld.d $t0, $fp, -168
	addi.w $t1, $zero, 4
	st.w $t1, $t0, 0
# %op19 = icmp sge i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -169
# br i1 %op19, label %label_nextBB45, label %label_negBB46
	ld.b $t0, $fp, -169
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB45
	b .main_label_negBB46
.main_label_negBB44:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB43
	b .main_label_nextBB43
.main_label_nextBB45:
# %op20 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 4
	la.local $t0, v
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 4
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 20
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -184
# store i32 6, i32* %op20
	ld.d $t0, $fp, -184
	addi.w $t1, $zero, 6
	st.w $t1, $t0, 0
# br label %label_cmpBB48
	addi.w $t8, $zero, 0
	st.w $t8, $fp, -192
	b .main_label_cmpBB48
.main_label_negBB46:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB45
	b .main_label_nextBB45
.main_label_nextBB47:
# %op21 = call i32 @knapsack(i32 5, i32 10)
	addi.w $a0, $zero, 5
	addi.w $a1, $zero, 10
	bl knapsack
	st.w $a0, $fp, -188
# call void @output(i32 %op21)
	ld.w $a0, $fp, -188
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 224
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.main_label_cmpBB48:
# %op22 = phi i32 [ 0, %label_nextBB45 ], [ %op29, %label_nextBB50 ]
# %op23 = icmp slt i32 %op22, 66
	ld.w $t0, $fp, -192
	addi.w $t1, $zero, 66
	slt $t0, $t0, $t1
	st.b $t0, $fp, -193
# %op24 = zext i1 %op23 to i32
	ld.b $t0, $fp, -193
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -200
# %op25 = icmp sgt i32 %op24, 0
	ld.w $t0, $fp, -200
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -201
# br i1 %op25, label %label_whileBB49, label %label_nextBB47
	ld.b $t0, $fp, -201
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_whileBB49
	b .main_label_nextBB47
.main_label_whileBB49:
# %op26 = icmp sge i32 %op22, 0
	ld.w $t0, $fp, -192
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -202
# br i1 %op26, label %label_nextBB50, label %label_negBB51
	ld.b $t0, $fp, -202
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB50
	b .main_label_negBB51
.main_label_nextBB50:
# %op27 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op22
	la.local $t0, dp
	addi.w $t1, $zero, 0
	ld.w $t2, $fp, -192
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 264
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -216
# %op28 = sub i32 0, 1
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -220
# store i32 %op28, i32* %op27
	ld.d $t0, $fp, -216
	ld.w $t1, $fp, -220
	st.w $t1, $t0, 0
# %op29 = add i32 %op22, 1
	ld.w $t0, $fp, -192
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -224
# store i32 %op29, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -224
	st.w $t1, $t0, 0
# br label %label_cmpBB48
	ld.w $t8, $fp, -224
	st.w $t8, $fp, -192
	b .main_label_cmpBB48
.main_label_negBB51:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB50
	b .main_label_nextBB50
	addi.d $sp, $sp, 224
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
