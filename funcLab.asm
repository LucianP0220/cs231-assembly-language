.data
	line0: .asciiz "\n=============================================================================\n"
	line1: .asciiz "Program Description: \t\t"
	line2: .asciiz "func lab\n"
	line3: .asciiz "Author:\t\t\t"
	line4: .asciiz "Lucian Pate\n"
	line5: .asciiz "Creation Date:\t\t\t"
	line6: .asciiz "03/09/2020\n"
	prompt: .asciiz "Enter a number: "
	sum: .asciiz "The sum is: "
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
	jal getNum
	add $a1,$v1,0
	
	jal getNum
	add $a2, $v1, 0
	
	jal getSum
	add $a3, $t3, $0
	
	jal printNum
	
	li $v0, 10
	syscall
	
getNum:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0 5
	syscall
	add $v1, $v0, $0
	
	jr $ra
getSum: 
	add $t1, $a1, $0
	add $t2, $a2, $0
	add $t3, $t1, $t2
	
	jr $ra

printNum:
	li $v0, 4
	la $a0, sum
	syscall
	
	add $a0, $a3, $0
	li $v0, 1
	syscall
	jr $ra