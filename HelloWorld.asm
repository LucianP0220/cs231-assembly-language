.data
	line0: .asciiz "Hello World"
.text
	li $v0, 4
	la $a0, line0
	syscall

	li $v0, 10
	syscall