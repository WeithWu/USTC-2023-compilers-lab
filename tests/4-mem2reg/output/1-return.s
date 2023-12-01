	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -16
.main_label_entry0:
# call void @output(i32 111)
	addi.w $a0, $zero, 111
	bl output
# ret i32 111
	addi.w $a0, $zero, 111
	addi.d $sp, $sp, 16
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 16
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
