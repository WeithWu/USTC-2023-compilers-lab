	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry0:
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
# br label %label_cmpBB2
	addi.w $t8, $zero, 0
	st.w $t8, $fp, -48
	b .main_label_cmpBB2
.main_label_nextBB1:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.main_label_cmpBB2:
# %op2 = phi i32 [ 0, %label_entry0 ], [ %op6, %label_whileBB3 ]
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
# br i1 %op5, label %label_whileBB3, label %label_nextBB1
	ld.b $t0, $fp, -57
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_whileBB3
	b .main_label_nextBB1
.main_label_whileBB3:
# call void @output(i32 %op2)
	ld.w $a0, $fp, -48
	bl output
# %op6 = add i32 %op2, 1
	ld.w $t0, $fp, -48
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -64
# store i32 %op6, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $fp, -64
	st.w $t1, $t0, 0
# br label %label_cmpBB2
	ld.w $t8, $fp, -64
	st.w $t8, $fp, -48
	b .main_label_cmpBB2
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
