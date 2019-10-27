.data
.align 2

.text

main: 	
	addi $a0, $0, 5	#input
	addi $a1, $0, 0	
	addi $v0, $0, 1	#OUTPUT
	
	
loop:	
	beq $a0, $a1, done
	addi $a1, $a1, 1	
	mul $v0, $v0, $a1	
		
	beq $0, $0, loop
done: 
stop: beq $0, $0,stop
