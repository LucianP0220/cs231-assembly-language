.data
	line0: .asciiz "\n=============================================================================\n"
	line1: .asciiz "Program Description: \t\t"
	line2: .asciiz "find the factorial\n"
	line3: .asciiz "Author:\t\t\t"
	line4: .asciiz "Lucian Pate\n"
	line5: .asciiz "Creation Date:\t\t\t"
	line6: .asciiz "02/09/2020\n"
	prompt: .asciiz "Enter an integer between 0-10\n"
	err1: .asciiz "Invalid number\n"
	bracket1: .asciiz "("
	bracket2: .asciiz "!)="
	
	
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
	
	
input:
	li $t0, 0
	#user input
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	
	add $t0, $v0, $0
	add $t5, $v0, $0
	
	li $s1, 1
	li $s2, 10
	#input error check	
	blt $t0, $0, error
	bgt $t0, $s2, error
	
	add $a1, $0, $t0
	jal copy
	add $t3,$v1,$0
	
	#print
	li $v0, 4
	la $a0, bracket1
	syscall

	li $v0, 1
	add $a0, $t5, $0
	syscall


	li $v0, 4
	la $a0, bracket2
	syscall

	li $v0, 1
	add $a0, $t3, $0
	syscall
	
	li $v0, 10
	syscall
	
	
error:
	li $v0, 4
	la $a0, err1
	syscall
	
	j input	
	
copy:
	add $t0, $0, $a1
	add $t4, $t0, $0
loop:
	ble $t4, $s1, done
	subi $t4, $t4, 1 
	
	mult $t0, $t4
	mflo $t0

	j loop
done:
	add $v1, $t0, $0
	jr $ra

	
	

