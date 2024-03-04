.data
	line0: .asciiz "\n=============================================================================\n"
	line1: .asciiz "Program Description: \t\t"
	line2: .asciiz "Calculate M to the power of N\n"
	line3: .asciiz "Author:\t\t\t"
	line4: .asciiz "Lucian Pate\n"
	line5: .asciiz "Creation Date:\t\t\t"
	line6: .asciiz "02/17/2022\n"
	prompt1: .asciiz "Enter a value for m! "
	prompt2: .asciiz "Enter a value for n! "
	ans: .asciiz "m to the power of n = "
	error1: .asciiz "m is invalid! "
	error2: .asciiz "n is invalid! "
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
	
	li $s0, 0 #input for m
	li $s1, 0 #input for n
	li $s2, 0 #counter
	li $s3, 12
	li $t0, 1 #total

input1:	
	#prompt for user input for m
	li $v0, 4
	la $a0, prompt1
	syscall

	#taking the user input
	li $v0, 5
	syscall
	add $s0, $v0,$0
	blt $s0, $0, err1 #error if less than zero
	bgt $s0, $s3, err1 #error if more than 12
	
input2: 
	#prompt for user input for n
	li $v0, 4
	la $a0, prompt2
	syscall

	#taking the user input
	li $v0, 5
	syscall
	add $s1, $v0,$0
	blt $s1, $0, err2 #error if less than zero
	bgt $s1, $s3, err2 #error if more than 12
	beq $s1, $0, zero #zero case
	
loop: 
	beq $s1, $s2, done
	
	mult $t0, $s0
	mflo $t0
	addi $s2, $s2, 1
	j loop
		
err1:
	#error for input m
	li $v0, 4
	la $a0, error1
	syscall
	j input1 #take another input for m
	

err2:
	#error for input n
	li $v0, 4
	la $a0, error2
	syscall
	j input2 #take another input for n	
	
zero:
	#zero case for m to the zero power 
	li $t0, 1
	j done	


done:
	#result
	li $v0,4
	la $a0, ans
	syscall
	li $v0,1
	la $a0,($t0)
	syscall
	
	#exit 
	li $v0, 10 
	syscall