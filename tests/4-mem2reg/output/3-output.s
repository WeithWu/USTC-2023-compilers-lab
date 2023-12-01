	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -16
.main_label_entry0:
# call void @output(i32 11)
	addi.w $a0, $zero, 11
	bl output
# call void @output(i32 22222)
	lu12i.w $a0, 5
	ori $a0, $a0, 1742
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 16
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 16
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
