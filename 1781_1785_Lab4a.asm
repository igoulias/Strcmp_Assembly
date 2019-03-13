# Lab4
# Username: igoulias		AEM: 1785
# Username: skaraiskos		AEM: 1781

.data
str_msg1:
	.asciiz "Insert str1: "

str_msg2:
	.asciiz "Insert str2: "

str_msg3:
	.asciiz "\n\strcmp result: "

str1:
	.space 32

str2:
	.space 32

.text
# Push regs a0, a1 and ra to stack
.macro stack_push()
	addi $sp, $sp, -12
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
.end_macro
# Pop regs a0, a1 and ra from stack
.macro stack_pop()
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
.end_macro

.globl main
main:
	li $v0, 4 		# Print str_msg1
	la $a0, str_msg1
	syscall
	
	li $v0, 8 		# Read str1...
	la $a0, str1
	li $a1, 32		# Num of bytes we can read + one for '\0'
	syscall
	
	li $v0, 4 		# Print str_msg2
	la $a0, str_msg2
	syscall
	
	li $v0, 8 		# Read str2...
	la $a0, str2
	li $a1, 32		# Num of bytes we can read + one for '\0'
	syscall
	
	la $a0, str1		# set arguments
	la $a1, str2
	jal rec_strcmp		# func
	
	move $s0, $v0		# Save result
	li $v0, 4 		# Print str_msg3
	la $a0, str_msg3
	syscall
	
	move $a0, $s0		# Print result
	li $v0, 1
	syscall
# Exit
	li $v0, 10
	syscall
#----------------------------------------------------------------
rec_strcmp:
	lb $t0, 0($a0)		# load char of str1
	lb $t1, 0($a1)		# load char of str2
	sub $v0, $t0, $t1	
	bnez $v0, return	
	beqz $t0, return	# if $t0 is 0x00 ('\0') then $t1 is 0x00 cause $t0 - $t1 = 0
	stack_push()	# store args and $ra to stack..
	addi $a0, $a0, 1	# reassign arguments..
	addi $a1, $a1, 1
	jal rec_strcmp		# rec call
	stack_pop()	# load args and $ra from stack..
return:
	jr $ra
