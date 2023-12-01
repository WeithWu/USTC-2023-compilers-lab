	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -176
.main_label_entry0:
# %op0 = alloca [10 x i32]
	addi.d $t1, $fp, -64
	st.d $t1, $fp, -24
# %op1 = alloca i32
	addi.d $t1, $fp, -76
	st.d $t1, $fp, -72
# store i32 0, i32* %op1
	ld.d $t0, $fp, -72
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# %op2 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -77
# br i1 %op2, label %label_nextBB1, label %label_negBB2
	ld.b $t0, $fp, -77
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB1
	b .main_label_negBB2
.main_label_nextBB1:
# %op3 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 0
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 40
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -88
# store i32 11, i32* %op3
	ld.d $t0, $fp, -88
	addi.w $t1, $zero, 11
	st.w $t1, $t0, 0
# %op4 = icmp sge i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -89
# br i1 %op4, label %label_nextBB3, label %label_negBB4
	ld.b $t0, $fp, -89
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB3
	b .main_label_negBB4
.main_label_negBB2:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB1
	b .main_label_nextBB1
.main_label_nextBB3:
# %op5 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 4
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 40
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -104
# store i32 22, i32* %op5
	ld.d $t0, $fp, -104
	addi.w $t1, $zero, 22
	st.w $t1, $t0, 0
# %op6 = icmp sge i32 9, 0
	addi.w $t0, $zero, 9
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -105
# br i1 %op6, label %label_nextBB5, label %label_negBB6
	ld.b $t0, $fp, -105
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB5
	b .main_label_negBB6
.main_label_negBB4:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB3
	b .main_label_nextBB3
.main_label_nextBB5:
# %op7 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 9
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 40
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -120
# store i32 33, i32* %op7
	ld.d $t0, $fp, -120
	addi.w $t1, $zero, 33
	st.w $t1, $t0, 0
# %op8 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -121
# br i1 %op8, label %label_nextBB7, label %label_negBB8
	ld.b $t0, $fp, -121
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB7
	b .main_label_negBB8
.main_label_negBB6:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB5
	b .main_label_nextBB5
.main_label_nextBB7:
# %op9 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 0
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 40
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -136
# %op10 = load i32, i32* %op9
	ld.d $t0, $fp, -136
	ld.d $t0, $t0, 0
	st.w $t0, $fp, -140
# call void @output(i32 %op10)
	ld.w $a0, $fp, -140
	bl output
# %op11 = icmp sge i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -141
# br i1 %op11, label %label_nextBB9, label %label_negBB10
	ld.b $t0, $fp, -141
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB9
	b .main_label_negBB10
.main_label_negBB8:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB7
	b .main_label_nextBB7
.main_label_nextBB9:
# %op12 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 4
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 40
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -152
# %op13 = load i32, i32* %op12
	ld.d $t0, $fp, -152
	ld.d $t0, $t0, 0
	st.w $t0, $fp, -156
# call void @output(i32 %op13)
	ld.w $a0, $fp, -156
	bl output
# %op14 = icmp sge i32 9, 0
	addi.w $t0, $zero, 9
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -157
# br i1 %op14, label %label_nextBB11, label %label_negBB12
	ld.b $t0, $fp, -157
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB11
	b .main_label_negBB12
.main_label_negBB10:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB9
	b .main_label_nextBB9
.main_label_nextBB11:
# %op15 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 9
	lu12i.w $t4, 0
	ori $t4, $t4, 4
	lu12i.w $t3, 0
	ori $t3, $t3, 40
	mul.w $t1, $t1, $t3
	mul.w $t2, $t2, $t4
	bstrpick.d $t1, $t1, 31, 0
	bstrpick.d $t2, $t2, 31, 0
	add.d $t0, $t0, $t1
	add.d $t0, $t0, $t2
	st.d $t0, $fp, -168
# %op16 = load i32, i32* %op15
	ld.d $t0, $fp, -168
	ld.d $t0, $t0, 0
	st.w $t0, $fp, -172
# call void @output(i32 %op16)
	ld.w $a0, $fp, -172
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 176
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.main_label_negBB12:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB11
	b .main_label_nextBB11
	addi.d $sp, $sp, 176
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
