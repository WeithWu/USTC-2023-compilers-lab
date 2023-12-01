	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -96
.main_label_entry0:
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
# %op3 = icmp sgt i32 11, 22
	addi.w $t0, $zero, 11
	addi.w $t1, $zero, 22
	slt $t0, $t1, $t0
	st.b $t0, $fp, -61
# %op4 = zext i1 %op3 to i32
	ld.b $t0, $fp, -61
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -68
# %op5 = icmp sgt i32 %op4, 0
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -69
# br i1 %op5, label %label_trueBB2, label %label_falseBB3
	ld.b $t0, $fp, -69
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_trueBB2
	b .main_label_falseBB3
.main_label_nextBB1:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.main_label_trueBB2:
# %op6 = icmp sgt i32 11, 33
	addi.w $t0, $zero, 11
	addi.w $t1, $zero, 33
	slt $t0, $t1, $t0
	st.b $t0, $fp, -70
# %op7 = zext i1 %op6 to i32
	ld.b $t0, $fp, -70
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -76
# %op8 = icmp sgt i32 %op7, 0
	ld.w $t0, $fp, -76
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -77
# br i1 %op8, label %label_trueBB5, label %label_falseBB6
	ld.b $t0, $fp, -77
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_trueBB5
	b .main_label_falseBB6
.main_label_falseBB3:
# %op9 = icmp slt i32 33, 22
	addi.w $t0, $zero, 33
	addi.w $t1, $zero, 22
	slt $t0, $t0, $t1
	st.b $t0, $fp, -78
# %op10 = zext i1 %op9 to i32
	ld.b $t0, $fp, -78
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -84
# %op11 = icmp sgt i32 %op10, 0
	ld.w $t0, $fp, -84
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -85
# br i1 %op11, label %label_trueBB8, label %label_falseBB9
	ld.b $t0, $fp, -85
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_trueBB8
	b .main_label_falseBB9
.main_label_nextBB4:
# br label %label_nextBB1
	b .main_label_nextBB1
.main_label_trueBB5:
# call void @output(i32 11)
	addi.w $a0, $zero, 11
	bl output
# br label %label_nextBB4
	b .main_label_nextBB4
.main_label_falseBB6:
# call void @output(i32 33)
	addi.w $a0, $zero, 33
	bl output
# br label %label_nextBB4
	b .main_label_nextBB4
.main_label_nextBB7:
# br label %label_nextBB1
	b .main_label_nextBB1
.main_label_trueBB8:
# call void @output(i32 22)
	addi.w $a0, $zero, 22
	bl output
# br label %label_nextBB7
	b .main_label_nextBB7
.main_label_falseBB9:
# call void @output(i32 33)
	addi.w $a0, $zero, 33
	bl output
# br label %label_nextBB7
	b .main_label_nextBB7
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
