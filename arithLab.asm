.data
	line0: .asciiz "\n=============================================================================\n"
	line1: .asciiz "Program Description: \t\t"
	line2: .asciiz "A simple program to mimic a basic calculator\n"
	line3: .asciiz "Author:\t\t\t"
	line4: .asciiz "Lucian Pate\n"
	line5: .asciiz "Creation Date:\t\t\t"
	line6: .asciiz "02/08/2022\n"
	numMsg: .asciiz "Please enter two numbers\n"
	plusMsg: .asciiz "Sum is: "
	difMsg: .asciiz "\nDifference is: "
	mulMsg: .asciiz "\nProduct is: "
	quoMsg: .asciiz "\nQuotient is: "
	remMsg: .asciiz "\nRemainder is: "

.text
main:
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
	
	#prompt for user input
	li $v0, 4
	la $a0, numMsg
	syscall
	
	#taking the user input
	li $v0, 5
	syscall
	move $s0, $v0
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	#addition
	li $v0,4
	la $a0,plusMsg
	syscall
	li $v0, 1
	add $a0, $s0, $s1
	syscall
	
	#subtration
	li $v0,4
	la $a0,difMsg
	syscall
	li $v0, 1
	sub $a0, $s0, $s1
	syscall	
	
	#multiplication
	li $v0,4
	la $a0,mulMsg
	syscall
	li $v0, 1
	mult $s0, $s1
	mflo $s2
	mfhi $s3
	add $a0, $0 $s2
	syscall	
	
	#division
	li $v0,4
	la $a0,quoMsg
	syscall
	div $s0, $s1
	mflo $s2
	mfhi $s3	
	li $v0, 1
	add $a0, $0, $s2
	syscall
	
	#remainder
	li $v0,4
	la $a0,remMsg
	syscall
	div $s0, $s1
	mflo $s2
	mfhi $s3
	li $v0, 1
	add $a0, $zero, $s3
	syscall


	li $v0, 10 #exit
	syscall
