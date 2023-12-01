	.text
	.globl min
	.type min, @function
min:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.min_label_entry0:
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
# %op4 = icmp sle i32 %arg0, %arg1
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -24
	addi.w $t1, $t1, 1
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
# br i1 %op6, label %label_trueBB2, label %label_falseBB3
	ld.b $t0, $fp, -61
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .min_label_trueBB2
	b .min_label_falseBB3
.min_label_nextBB1:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.min_label_trueBB2:
# ret i32 %arg0
	ld.w $a0, $fp, -20
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.min_label_falseBB3:
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
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
.main_label_entry4:
# %op0 = alloca i32
	addi.d $t1, $fp, -28
	st.d $t1, $fp, -24
# %op1 = alloca i32
	addi.d $t1, $fp, -44
	st.d $t1, $fp, -40
# %op2 = alloca i32
	addi.d $t1, $fp, -60
	st.d $t1, $fp, -56
# store i32 11, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 11
	st.w $t1, $t0, 0
# store i32 22, i32* %op1
	ld.d $t0, $fp, -40
	addi.w $t1, $zero, 22
	st.w $t1, $t0, 0
# store i32 33, i32* %op2
	ld.d $t0, $fp, -56
	addi.w $t1, $zero, 33
	st.w $t1, $t0, 0
# %op3 = call i32 @min(i32 11, i32 22)
	addi.w $a0, $zero, 11
	addi.w $a1, $zero, 22
	bl min
	st.w $a0, $fp, -64
# call void @output(i32 %op3)
	ld.w $a0, $fp, -64
	bl output
# %op4 = call i32 @min(i32 22, i32 33)
	addi.w $a0, $zero, 22
	addi.w $a1, $zero, 33
	bl min
	st.w $a0, $fp, -68
# call void @output(i32 %op4)
	ld.w $a0, $fp, -68
	bl output
# %op5 = call i32 @min(i32 33, i32 11)
	addi.w $a0, $zero, 33
	addi.w $a1, $zero, 11
	bl min
	st.w $a0, $fp, -72
# call void @output(i32 %op5)
	ld.w $a0, $fp, -72
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
