  # hexmain.asm
  # Written 2015-09-04 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

	.text

	
	
main:
	li	$a0, 17		# change this to test different values

	jal	hexasc		# call hexasc
	nop			# delay slot filler (just in case)	

	move	$a0,$v0		# copy return value to argument register

	li	$v0,11		# syscall with v0 = 11 will print out
	syscall			# one byte from a0 to the Run I/O window
	
stop:	j	stop		# stop after one run
	nop			# delay slot filler (just in case)

  # You can write your own code for hexasc here
  #
 hexasc:
	addi $t0, $0, 0x30
	and $a0, $a0, 0x0000000F
	slti $t1, $a0, 10
	beq $t1, 1, digit
	nop
	addi $t0, $0, 0x37
	add $t0, $t0, $a0
	move $v0, $t0
	jr $ra
	nop
	
digit:	
	add $t0, $t0, $a0
	move $v0, $t0
	jr $ra
	nop

