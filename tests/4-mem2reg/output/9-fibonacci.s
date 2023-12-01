	.text
	.globl fibonacci
	.type fibonacci, @function
fibonacci:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
	st.w $a0, $fp, -20
.fibonacci_label_entry0:
# %op1 = alloca i32
	addi.d $t1, $fp, -36
	st.d $t1, $fp, -32
# store i32 %arg0, i32* %op1
	ld.d $t0, $fp, -32
	ld.w $t1, $fp, -20
	st.w $t1, $t0, 0
# %op2 = icmp eq i32 %arg0, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	slt $t3, $t1, $t0
	nor $t0, $t2, $t3
	st.b $t0, $fp, -37
# %op3 = zext i1 %op2 to i32
	ld.b $t0, $fp, -37
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -44
# %op4 = icmp sgt i32 %op3, 0
	ld.w $t0, $fp, -44
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -45
# br i1 %op4, label %label_trueBB2, label %label_falseBB3
	ld.b $t0, $fp, -45
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .fibonacci_label_trueBB2
	b .fibonacci_label_falseBB3
.fibonacci_label_nextBB1:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.fibonacci_label_trueBB2:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.fibonacci_label_falseBB3:
# %op5 = icmp eq i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	slt $t2, $t0, $t1
	slt $t3, $t1, $t0
	nor $t0, $t2, $t3
	st.b $t0, $fp, -46
# %op6 = zext i1 %op5 to i32
	ld.b $t0, $fp, -46
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -52
# %op7 = icmp sgt i32 %op6, 0
	ld.w $t0, $fp, -52
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -53
# br i1 %op7, label %label_trueBB5, label %label_falseBB6
	ld.b $t0, $fp, -53
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .fibonacci_label_trueBB5
	b .fibonacci_label_falseBB6
.fibonacci_label_nextBB4:
# br label %label_nextBB1
	b .fibonacci_label_nextBB1
.fibonacci_label_trueBB5:
# ret i32 1
	addi.w $a0, $zero, 1
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.fibonacci_label_falseBB6:
# %op8 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -60
# %op9 = call i32 @fibonacci(i32 %op8)
	ld.w $a0, $fp, -60
	bl fibonacci
	st.w $a0, $fp, -64
# %op10 = sub i32 %arg0, 2
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 2
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -68
# %op11 = call i32 @fibonacci(i32 %op10)
	ld.w $a0, $fp, -68
	bl fibonacci
	st.w $a0, $fp, -72
# %op12 = add i32 %op9, %op11
	ld.w $t0, $fp, -64
	ld.w $t1, $fp, -72
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -76
# ret i32 %op12
	ld.w $a0, $fp, -76
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
.main_label_entry7:
# %op0 = alloca i32
	addi.d $t1, $fp, -28
	st.d $t1, $fp, -24
# %op1 = alloca i32
	addi.d $t1, $fp, -44
	st.d $t1, $fp, -40
# store i32 10, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 10
	st.w $t1, $t0, 0
# store i32 0, i32* %op1
	ld.d $t0, $fp, -40
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label_cmpBB9
	addi.w $t8, $zero, 0
	st.w $t8, $fp, -48
	b .main_label_cmpBB9
.main_label_nextBB8:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.main_label_cmpBB9:
# %op2 = phi i32 [ 0, %label_entry7 ], [ %op7, %label_whileBB10 ]
# %op3 = icmp slt i32 %op2, 10
	ld.w $t0, $fp, -48
	addi.w $t1, $zero, 10
	slt $t0, $t0, $t1
	st.b $t0, $fp, -49
# %op4 = zext i1 %op3 to i32
	ld.b $t0, $fp, -49
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -56
# %op5 = icmp sgt i32 %op4, 0
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -57
# br i1 %op5, label %label_whileBB10, label %label_nextBB8
	ld.b $t0, $fp, -57
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_whileBB10
	b .main_label_nextBB8
.main_label_whileBB10:
# %op6 = call i32 @fibonacci(i32 %op2)
	ld.w $a0, $fp, -48
	bl fibonacci
	st.w $a0, $fp, -64
# call void @output(i32 %op6)
	ld.w $a0, $fp, -64
	bl output
# %op7 = add i32 %op2, 1
	ld.w $t0, $fp, -48
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -68
# store i32 %op7, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $fp, -68
	st.w $t1, $t0, 0
# br label %label_cmpBB9
	ld.w $t8, $fp, -68
	st.w $t8, $fp, -48
	b .main_label_cmpBB9
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
