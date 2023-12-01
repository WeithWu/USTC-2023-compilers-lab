	.text
	.globl mod
	.type mod, @function
mod:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -96
	fst.s $fa0, $fp, -20
	fst.s $fa1, $fp, -24
.mod_label_entry0:
# %op2 = alloca float
	addi.d $t1, $fp, -36
	st.d $t1, $fp, -32
# store float %arg0, float* %op2
	ld.d $t0, $fp, -32
	fld.s $ft0, $fp, -20
	fst.s $ft0, $t0, 0
# %op3 = alloca float
	addi.d $t1, $fp, -52
	st.d $t1, $fp, -48
# store float %arg1, float* %op3
	ld.d $t0, $fp, -48
	fld.s $ft0, $fp, -24
	fst.s $ft0, $t0, 0
# %op4 = alloca i32
	addi.d $t1, $fp, -68
	st.d $t1, $fp, -64
# %op5 = fdiv float %arg0, %arg1
	fld.s $ft0, $fp, -20
	fld.s $ft1, $fp, -24
	fdiv.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -72
# %op6 = fptosi float %op5 to i32
	fld.s $ft0, $fp, -72
	ftintrz.w.s $ft1, $ft0
	fst.s $ft1, $fp, -76
# store i32 %op6, i32* %op4
	ld.d $t0, $fp, -64
	ld.w $t1, $fp, -76
	st.w $t1, $t0, 0
# %op7 = sitofp i32 %op6 to float
	ld.w $t0, $fp, -76
	movgr2fr.w $ft0, $t0
	ffint.s.w $ft1, $ft0
	fst.s $ft1, $fp, -80
# %op8 = fmul float %op7, %arg1
	fld.s $ft0, $fp, -80
	fld.s $ft1, $fp, -24
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -84
# %op9 = fsub float %arg0, %op8
	fld.s $ft0, $fp, -20
	fld.s $ft1, $fp, -84
	fsub.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -88
# ret float %op9
	fld.s $fa0, $fp, -88
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
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
	addi.d $sp, $sp, -48
.main_label_entry1:
# %op0 = alloca float
	addi.d $t1, $fp, -28
	st.d $t1, $fp, -24
# %op1 = alloca float
	addi.d $t1, $fp, -44
	st.d $t1, $fp, -40
# store float 0x4026666660000000, float* %op0
	ld.d $t0, $fp, -24
	lu12i.w $t8, 267059
	ori $t8, $t8, 819
	movgr2fr.w $ft0, $t8
	fst.s $ft0, $t0, 0
# store float 0x40019999a0000000, float* %op1
	ld.d $t0, $fp, -40
	lu12i.w $t8, 262348
	ori $t8, $t8, 3277
	movgr2fr.w $ft0, $t8
	fst.s $ft0, $t0, 0
# %op2 = call float @mod(float 0x4026666660000000, float 0x40019999a0000000)
	lu12i.w $t8, 267059
	ori $t8, $t8, 819
	movgr2fr.w $fa0, $t8
	lu12i.w $t8, 262348
	ori $t8, $t8, 3277
	movgr2fr.w $fa1, $t8
	bl mod
	fst.s $fa0, $fp, -48
# call void @outputFloat(float %op2)
	fld.s $fa0, $fp, -48
	bl outputFloat
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
