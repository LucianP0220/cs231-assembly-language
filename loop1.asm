.data
	line0: .asciiz "\n=============================================================================\n"
	line1: .asciiz "Program Description: \t\t"
	line2: .asciiz "Print Output\n"
	line3: .asciiz "Author:\t\t\t"
	line4: .asciiz "Lucian Pate\n"
	line5: .asciiz "Creation Date:\t\t\t"
	line6: .asciiz "02/24/2022\n"
	prompt: .asciiz "How many numbers would you like to add? "
	ans: .asciiz "The sum of the even numbers is "
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
	
	#prompt for user input
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $s0, 0 #input
	li $s2, 2
	
	#taking the user input
	li $v0, 5
	syscall
	add $s0, $v0,$0
	
loop:
	beq $t1, $s0, end
	
	li $v0, 5
	syscall
	
	add $t2, $v0, $0
	add $t1, $t1, 1
	
	div $t2, $s2
	mfhi $t0
	bgt $t0, $0, loop
	
	add $t3, $t3, $v0
	j loop
	
end:
	li $v0, 4
	la $a0, ans
	syscall
	li $v0, 1
	add $a0, $t3, $0
	syscall
	
	#exit 
	li $v0, 10 
	syscall
