.data
.align 2

.text

main: 	
	addi $a0, $0, 1
	addi $a1, $0, 0
	addi $v0, $0, 1
loop:	beq $a0, $a1, done
	
	
	
	add $a2, $a1, $0
	add $a3, $v0, $0
loop2:	beq $a2, $0, done1
	add $v0, $v0, $a3
	addi $a2, $a2, -1
	beq $0, $0, loop2
	
done1:	
	addi $a1, $a1, 1
	
	
	
	beq $0, $0, loop
done: 
stop: beq $0, $0,stop