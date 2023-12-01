	.text
	.globl store
	.type store, @function
store:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -96
	st.d $a0, $fp, -24
	st.w $a1, $fp, -28
	st.w $a2, $fp, -32
.store_label_entry0:
# %op3 = alloca i32*
	addi.d $t1, $fp, -48
	st.d $t1, $fp, -40
# store i32* %arg0, i32** %op3
	ld.d $t0, $fp, -40
	ld.d $t1, $fp, -24
	st.d $t1, $t0, 0
# %op4 = alloca i32
	addi.d $t1, $fp, -60
	st.d $t1, $fp, -56
# store i32 %arg1, i32* %op4
	ld.d $t0, $fp, -56
	ld.w $t1, $fp, -28
	st.w $t1, $t0, 0
# %op5 = alloca i32
	addi.d $t1, $fp, -76
	st.d $t1, $fp, -72
# store i32 %arg2, i32* %op5
	ld.d $t0, $fp, -72
	ld.w $t1, $fp, -32
	st.w $t1, $t0, 0
# %op6 = icmp sge i32 %arg1, 0
	ld.w $t0, $fp, -28
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -77
# br i1 %op6, label %label_nextBB1, label %label_negBB2
	ld.b $t0, $fp, -77
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .store_label_nextBB1
	b .store_label_negBB2
.store_label_nextBB1:
# %op7 = getelementptr i32, i32* %arg0, i32 %arg1
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -28
	lu12i.w $t3, 0
	ori $t3, $t3, 4
	mul.w $t1, $t1, $t3
	bstrpick.d $t1, $t1, 31, 0
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -88
# store i32 %arg2, i32* %op7
	ld.d $t0, $fp, -88
	ld.w $t1, $fp, -32
	st.w $t1, $t0, 0
# ret i32 %arg2
	ld.w $a0, $fp, -32
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.store_label_negBB2:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB1
	b .store_label_nextBB1
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -176
.main_label_entry3:
# %op0 = alloca [10 x i32]
	addi.d $t1, $fp, -64
	st.d $t1, $fp, -24
# %op1 = alloca i32
	addi.d $t1, $fp, -76
	st.d $t1, $fp, -72
# %op2 = alloca i32
	addi.d $t1, $fp, -92
	st.d $t1, $fp, -88
# store i32 0, i32* %op1
	ld.d $t0, $fp, -72
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label_cmpBB5
	addi.w $t8, $zero, 0
	st.w $t8, $fp, -96
	b .main_label_cmpBB5
.main_label_nextBB4:
# store i32 0, i32* %op2
	ld.d $t0, $fp, -88
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# store i32 0, i32* %op1
	ld.d $t0, $fp, -72
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label_cmpBB8
	addi.w $t8, $zero, 0
	st.w $t8, $fp, -136
	addi.w $t8, $zero, 0
	st.w $t8, $fp, -140
	b .main_label_cmpBB8
.main_label_cmpBB5:
# %op3 = phi i32 [ 0, %label_entry3 ], [ %op10, %label_whileBB6 ]
# %op4 = icmp slt i32 %op3, 10
	ld.w $t0, $fp, -96
	addi.w $t1, $zero, 10
	slt $t0, $t0, $t1
	st.b $t0, $fp, -97
# %op5 = zext i1 %op4 to i32
	ld.b $t0, $fp, -97
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -104
# %op6 = icmp sgt i32 %op5, 0
	ld.w $t0, $fp, -104
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -105
# br i1 %op6, label %label_whileBB6, label %label_nextBB4
	ld.b $t0, $fp, -105
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_whileBB6
	b .main_label_nextBB4
.main_label_whileBB6:
# %op7 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
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
	st.d $t0, $fp, -120
# %op8 = mul i32 %op3, 2
	ld.w $t0, $fp, -96
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -124
# %op9 = call i32 @store(i32* %op7, i32 %op3, i32 %op8)
	ld.d $a0, $fp, -120
	ld.w $a1, $fp, -96
	ld.w $a2, $fp, -124
	bl store
	st.w $a0, $fp, -128
# %op10 = add i32 %op3, 1
	ld.w $t0, $fp, -96
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -132
# store i32 %op10, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t1, $fp, -132
	st.w $t1, $t0, 0
# br label %label_cmpBB5
	ld.w $t8, $fp, -132
	st.w $t8, $fp, -96
	b .main_label_cmpBB5
.main_label_nextBB7:
# call void @output(i32 %op12)
	ld.w $a0, $fp, -140
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 176
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.main_label_cmpBB8:
# %op11 = phi i32 [ 0, %label_nextBB4 ], [ %op20, %label_nextBB10 ]
# %op12 = phi i32 [ 0, %label_nextBB4 ], [ %op19, %label_nextBB10 ]
# %op13 = icmp slt i32 %op11, 10
	ld.w $t0, $fp, -136
	addi.w $t1, $zero, 10
	slt $t0, $t0, $t1
	st.b $t0, $fp, -141
# %op14 = zext i1 %op13 to i32
	ld.b $t0, $fp, -141
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -148
# %op15 = icmp sgt i32 %op14, 0
	ld.w $t0, $fp, -148
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -149
# br i1 %op15, label %label_whileBB9, label %label_nextBB7
	ld.b $t0, $fp, -149
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_whileBB9
	b .main_label_nextBB7
.main_label_whileBB9:
# %op16 = icmp sge i32 %op11, 0
	ld.w $t0, $fp, -136
	addi.w $t1, $zero, 0
	addi.w $t0, $t0, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -150
# br i1 %op16, label %label_nextBB10, label %label_negBB11
	ld.b $t0, $fp, -150
	bstrpick.d $t1, $t0, 0, 0
	bnez $t1, .main_label_nextBB10
	b .main_label_negBB11
.main_label_nextBB10:
# %op17 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 %op11
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	ld.w $t2, $fp, -136
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
	st.d $t0, $fp, -160
# %op18 = load i32, i32* %op17
	ld.d $t0, $fp, -160
	ld.d $t0, $t0, 0
	st.w $t0, $fp, -164
# %op19 = add i32 %op12, %op18
	ld.w $t0, $fp, -140
	ld.w $t1, $fp, -164
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -168
# store i32 %op19, i32* %op2
	ld.d $t0, $fp, -88
	ld.w $t1, $fp, -168
	st.w $t1, $t0, 0
# %op20 = add i32 %op11, 1
	ld.w $t0, $fp, -136
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -172
# store i32 %op20, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t1, $fp, -172
	st.w $t1, $t0, 0
# br label %label_cmpBB8
	ld.w $t8, $fp, -172
	st.w $t8, $fp, -136
	ld.w $t8, $fp, -168
	st.w $t8, $fp, -140
	b .main_label_cmpBB8
.main_label_negBB11:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_nextBB10
	b .main_label_nextBB10
	addi.d $sp, $sp, 176
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
