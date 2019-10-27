  # labwork.S
  # Written 2015-2017 by F Lundevall
  # Skeleton file for IS1200/IS1500 lab 1.
  # The macros PUSH and POP are in the public domain.
  # Please add your own code at the end of the file.

  #
  # Please keep the two macros PUSH and POP unchanged
  #
.macro	PUSH reg
	addi	$sp,$sp,-4
	sw	\reg,0($sp)
.endm

.macro	POP reg
	lw	\reg,0($sp)
	addi	$sp,$sp,4
.endm
  #
  # Please add your own code below this line
  #
	.data
	.global time2string
	.global delay
	.text

	
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
	srl $a1, $a1, 12
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
	andi $t4, $t4, 1
	beq $t4, $0, even
	nop
	addi $t4, $0, 0x44
	sb $t4, 5($a0)
	move $ra, $t5
	jr $ra
	nop

even:	
	addi $t4, $0, 0x45
	sb $t4, 5($a0)
	move $ra, $t5
	jr $ra
	nop
	
	
delay:
	addi $t3, $0, 4711
	
loop:	addi $t2, $0, 0
	slt $t1, $0, $a0
	beq $t1, $0, noloop
	nop
	addi $a0, $a0, -1
forloop:	slt $t4, $t2, $t3
	beq $t4, $0, noforloop
	nop
	addi $t2, $t2, 1
	j forloop
	nop
noforloop:	j loop
	nop
noloop: 	jr $ra
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


