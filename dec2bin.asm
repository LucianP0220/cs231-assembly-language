.data
	line0: .asciiz "=============================================================================\n"
	line1: .asciiz "Program Description: \t\t"
	line2: .asciiz "convert decimal to binary\n"
	line3: .asciiz "Author:\t\t\t"
	line4: .asciiz "Lucian Pate\n"
	line5: .asciiz "Creation Date:\t\t\t"
	line6: .asciiz "03/10/2022\n"
	prompt: .asciiz "Input an integer in decimal form: "
	num: .asciiz "The number "
	ans: .asciiz " in binary is: "
.text
	#header
	li $v0, 4
	la $a0, line0
	syscall
	
	li $v0, 4
	la $a0, line1
	syscall
	
	li $v0, 4
	la $a0, line2
	syscall
	
	li $v0, 4
	la $a0, line3
	syscall
	
	li $v0, 4
	la $a0, line4
	syscall
	
	li $v0, 4
	la $a0, line5
	syscall
	
	li $v0, 4
	la $a0, line6
	syscall

	li $v0, 4
	la $a0, line0
	syscall
main:
	li $s0, 0 #user input
	li $s1, 32 #32 bits
	li $s2, 2 #divisor
	li $s3, 0 #Zero counter
	li $s4, 0 #stack counter
	
	# take user input
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	
	add $s0, $v0, $0
	#passing variable
	add $a0, $v0, $0
	jal BaseChange
	
	#exit
	li $v0, 10
	syscall
	
BaseChange:
	add $t0, $a0, $0
	#print
	li $v0, 4
	la $a0, line0
	syscall
	
	li $v0, 4
	la $a0, num		
	syscall
	
	add $a0, $0, $s0
	li $v0, 1		
	syscall
	
	li $v0, 4
	la $a0, ans		
	syscall
	
loop1: #dividing
	beq $t0, $0, loop2
	div $t0, $s2
	mfhi $t1 #remainder
	mflo $t0 #quotient
	#push
	addi $sp, $sp, -4
	sw $t1, 0($sp)
	
	addi $s3, $s3, 1 #Zero counter 
	addi $s4, $s4, 1 #counter
	j loop1
	
loop2: #loop to output zeros
	beq $s1, $s3, loop3 
	
	li $a0, 0
	li $v0, 1
	syscall
	addi $s3, $s3, 1
	j loop2
	
loop3:
	beq $s4, $0, done
	lw $a0, 0($sp) #load stack
	li $v0,1 
	syscall
	
	addi $sp, $sp, 4 #pop
	sub $s4, $s4, 1 #subtract counter
	j loop3
done:
	jr $ra