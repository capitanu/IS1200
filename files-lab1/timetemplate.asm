  # timetemplate.asm
  # Written 2015 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

.macro	PUSH (%reg)
	addi	$sp,$sp,-4
	sw	%reg,0($sp)
.end_macro

.macro	POP (%reg)
	lw	%reg,0($sp)
	addi	$sp,$sp,4
.end_macro

	.data
	.align 2
mytime:	.word 0x5957

timstr:	.space 6

.ascii "text more text lots of text\0"
	
	
.text

main:
	# print timstr
	la	$a0,timstr
	li	$v0,4
	syscall
	nop
	# wait a little
	li	$a0,2
	jal	delay
	nop
	# call tick
	la	$a0,mytime
	jal	tick
	nop
	# call your function time2string
	la	$a0,timstr
	la	$t0,mytime
	lw	$a1,0($t0)
	jal	time2string
	nop
	# print a newline
	li	$a0,10
	li	$v0,11
	syscall
	nop
	# go back and do it all again
	j	main
	nop
# tick: update time pointed to by $a0
tick:	lw	$t0,0($a0)	# get time
	addiu	$t0,$t0,1	# increase
	andi	$t1,$t0,0xf	# check lowest digit
	sltiu	$t2,$t1,0xa	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x6	# adjust lowest digit
	andi	$t1,$t0,0xf0	# check next digit
	sltiu	$t2,$t1,0x60	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa0	# adjust digit
	andi	$t1,$t0,0xf00	# check minute digit
	sltiu	$t2,$t1,0xa00	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x600	# adjust digit
	andi	$t1,$t0,0xf000	# check last digit
	sltiu	$t2,$t1,0x6000	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa000	# adjust last digit
tiend:	sw	$t0,0($a0)	# save updated result
	jr	$ra		# return
	nop

  # you can write your code for subroutine "hexasc" below this line
  #
 delay:
	jr $ra
	nop
	
	 	 
time2string:
	add $t5, $0, $ra		
	add $t3, $0, $a1
	srl $a1, $a1, 4
	andi $a1, $a1, 0xf
	jal hexasc
	nop
	add $t4, $0, $v0
	sll $t4, $t4, 8
	addi $t4, $t4, 0x3a
	sll $t4, $t4, 8
	move $a1, $t3
	srl $a1, $a1, 8
	andi $a1, $a1, 0xf
	jal hexasc
	nop
	add $t4, $t4, $v0
	sll $t4, $t4, 8
	move $a1, $t3
	srl $a1 $a1, 12
	andi $a1, $a1, 0xf
	jal hexasc
	nop
	add $t4, $t4, $v0
	sw $t4, 0($a0)
	move $a1, $t3
	andi $a1, $a1, 0xf
	jal hexasc
	nop
	add $t4, $0, $v0
	sw $t4, 4($a0)	
	move $ra, $t5
	jr $ra
	nop
	
	
	
		
	
	
	
	
	
	
	
 hexasc:
	addi $t0, $0, 0x30
	and $a1, $a1, 0xf
	slti $t1, $a1, 10
	beq $t1, 1, digit
	nop
	addi $t0, $0, 0x37
	add $t0, $t0, $a1
	move $v0, $t0
	jr $ra
	nop
	
	
digit:	
	add $t0, $t0, $a1
	move $v0, $t0
	jr $ra
	nop


