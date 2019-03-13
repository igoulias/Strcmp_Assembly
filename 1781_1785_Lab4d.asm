# Lab4
# Username: igoulias		AEM: 1785
# Username: skaraiskos		AEM: 1781

# Esto pos oi h val5 ine ston $s0 kai h val6 ston $s1
if:	lw $t0, ptr1($zero)
	bnez $t0, else
	lw $t1, ptr3($zero)
	sw $t1, ptr2($zero)	# *ptr2 = *ptr3
	bne $t1, 1, else
	lw $t2, ptr4($zero)
	ble $t2, 2, else
	
	addi $s0, $s0, 1	# val5++
	j exit
else:
	addi $s1, $s1, 1	# val6++
exit: