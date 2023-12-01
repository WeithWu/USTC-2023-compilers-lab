# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl seed
	.type seed, @object
	.size seed, 4
seed:
	.space 4
	.text
	.globl randomLCG
	.type randomLCG, @function
randomLCG:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.randomLCG_label_entry0:
# %op0 = load i32, i32* @seed
	la.local $t0, seed
	ld.d $t0, $t0, 0
	st.w $t0, $fp, -20
# %op1 = mul i32 %op0, 1103515245
	ld.w $t0, $fp, -20
	lu12i.w $t1, 269412
	ori $t1, $t1, 3693
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -24
# %op2 = add i32 %op1, 12345
	ld.w $t0, $fp, -24
	lu12i.w $t1, 3
	ori $t1, $t1, 57
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -28
# store i32 %op2, i32* @seed
	la.local $t0, seed
	ld.w $t1, $fp, -28
	st.w $t1, $t0, 0
# ret i32 %op2
	ld.w $a0, $fp, -28
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl randBin
	.type randBin, @function
randBin:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.randBin_label_entry1:
# %op0 = call i32 @randomLCG()
	bl randomLCG
	st.w $a0, $fp, -20
# %op1 = icmp sgt i32 %op0, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -21
# %op2 = zext i1 %op1 to i32
	ld.b $t0, $fp, -21
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -28
# %op3 = icmp sgt i32 %op2, 0
	ld.w $t0, $fp, -28
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -29
# br i1 %op3, label %label_trueBB3, label %label_falseBB4
	ld.b $t0, $fp, -29
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .randBin_label_trueBB3
	b .randBin_label_falseBB4
.randBin_label_nextBB2:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.randBin_label_trueBB3:
# ret i32 1
	addi.w $a0, $zero, 1
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.randBin_label_falseBB4:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl returnToZeroSteps
	.type returnToZeroSteps, @function
returnToZeroSteps:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
.returnToZeroSteps_label_entry5:
# %op0 = alloca i32
	addi.d $t1, $fp, -28
	st.d $t1, $fp, -24
# %op1 = alloca i32
	addi.d $t1, $fp, -44
	st.d $t1, $fp, -40
# store i32 0, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# store i32 0, i32* %op1
	ld.d $t0, $fp, -40
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label_cmpBB7
	addi.w $t8, $zero, 0
	st.w $t8, $fp, -48
	addi.w $t8, $zero, 0
	st.w $t8, $fp, -52
	b .returnToZeroSteps_label_cmpBB7
.returnToZeroSteps_label_nextBB6:
# ret i32 20
	addi.w $a0, $zero, 20
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.returnToZeroSteps_label_cmpBB7:
# %op2 = phi i32 [ 0, %label_entry5 ], [ %op9, %label_nextBB12 ]
# %op3 = phi i32 [ 0, %label_entry5 ], [ %op10, %label_nextBB12 ]
# %op4 = icmp slt i32 %op3, 20
	ld.w $t0, $fp, -52
	addi.w $t1, $zero, 20
	slt $t0, $t0, $t1
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
# br i1 %op6, label %label_whileBB8, label %label_nextBB6
	ld.b $t0, $fp, -61
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .returnToZeroSteps_label_whileBB8
	b .returnToZeroSteps_label_nextBB6
.returnToZeroSteps_label_whileBB8:
# %op7 = call i32 @randBin()
	bl randBin
	st.w $a0, $fp, -68
# %op8 = icmp sgt i32 %op7, 0
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -69
# br i1 %op8, label %label_trueBB10, label %label_falseBB11
	ld.b $t0, $fp, -69
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .returnToZeroSteps_label_trueBB10
	b .returnToZeroSteps_label_falseBB11
.returnToZeroSteps_label_nextBB9:
# %op9 = phi i32 [ %op14, %label_trueBB10 ], [ %op15, %label_falseBB11 ]
# %op10 = add i32 %op3, 1
	ld.w $t0, $fp, -52
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -80
# store i32 %op10, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $fp, -80
	st.w $t1, $t0, 0
# %op11 = icmp eq i32 %op9, 0
	ld.w $t0, $fp, -76
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	slt $t3, $t1, $t0
	nor $t0, $t2, $t3
	st.b $t0, $fp, -81
# %op12 = zext i1 %op11 to i32
	ld.b $t0, $fp, -81
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -88
# %op13 = icmp sgt i32 %op12, 0
	ld.w $t0, $fp, -88
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -89
# br i1 %op13, label %label_trueBB13, label %label_nextBB12
	ld.b $t0, $fp, -89
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .returnToZeroSteps_label_trueBB13
	b .returnToZeroSteps_label_nextBB12
.returnToZeroSteps_label_trueBB10:
# %op14 = add i32 %op2, 1
	ld.w $t0, $fp, -48
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -96
# store i32 %op14, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -96
	st.w $t1, $t0, 0
# br label %label_nextBB9
	ld.w $t8, $fp, -96
	st.w $t8, $fp, -76
	b .returnToZeroSteps_label_nextBB9
.returnToZeroSteps_label_falseBB11:
# %op15 = sub i32 %op2, 1
	ld.w $t0, $fp, -48
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -100
# store i32 %op15, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -100
	st.w $t1, $t0, 0
# br label %label_nextBB9
	ld.w $t8, $fp, -100
	st.w $t8, $fp, -76
	b .returnToZeroSteps_label_nextBB9
.returnToZeroSteps_label_nextBB12:
# br label %label_cmpBB7
	ld.w $t8, $fp, -76
	st.w $t8, $fp, -48
	ld.w $t8, $fp, -80
	st.w $t8, $fp, -52
	b .returnToZeroSteps_label_cmpBB7
.returnToZeroSteps_label_trueBB13:
# ret i32 %op10
	ld.w $a0, $fp, -80
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry14:
# %op0 = alloca i32
	addi.d $t1, $fp, -28
	st.d $t1, $fp, -24
# store i32 0, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# store i32 3407, i32* @seed
	la.local $t0, seed
	lu12i.w $t1, 0
	ori $t1, $t1, 3407
	st.w $t1, $t0, 0
# br label %label_cmpBB16
	addi.w $t8, $zero, 0
	st.w $t8, $fp, -32
	b .main_label_cmpBB16
.main_label_nextBB15:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.main_label_cmpBB16:
# %op1 = phi i32 [ 0, %label_entry14 ], [ %op6, %label_whileBB17 ]
# %op2 = icmp slt i32 %op1, 20
	ld.w $t0, $fp, -32
	addi.w $t1, $zero, 20
	slt $t0, $t0, $t1
	st.b $t0, $fp, -33
# %op3 = zext i1 %op2 to i32
	ld.b $t0, $fp, -33
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -40
# %op4 = icmp sgt i32 %op3, 0
	ld.w $t0, $fp, -40
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -41
# br i1 %op4, label %label_whileBB17, label %label_nextBB15
	ld.b $t0, $fp, -41
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_whileBB17
	b .main_label_nextBB15
.main_label_whileBB17:
# %op5 = call i32 @returnToZeroSteps()
	bl returnToZeroSteps
	st.w $a0, $fp, -48
# call void @output(i32 %op5)
	ld.w $a0, $fp, -48
	bl output
# %op6 = add i32 %op1, 1
	ld.w $t0, $fp, -32
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -52
# store i32 %op6, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -52
	st.w $t1, $t0, 0
# br label %label_cmpBB16
	ld.w $t8, $fp, -52
	st.w $t8, $fp, -32
	b .main_label_cmpBB16
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
