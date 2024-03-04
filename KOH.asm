.data
	array: .word 0,0,0,0,0,0,0,0,0,0
	line0: .asciiz "\n=============================================================================\n"
	line1: .asciiz "Program Description: \t\t"
	line2: .asciiz "Write a program to find largest Element of array\n"
	line3: .asciiz "Author:\t\t\t"
	line4: .asciiz "Lucian Pate\n"
	line5: .asciiz "Creation Date:\t\t\t"
	line6: .asciiz "03/03/2022\n" 
	prompt: .asciiz "How many elements: "
	err1: .asciiz "Too many elements!!!\n"
	err2: .asciiz "Not enought elements!!!\n"
	ans: .asciiz "The largest element is: "
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
	la $s0, array
	li $s1, 0 
	li $s2, 1 
	li $t0, 0 
	li $t1, 0
	li $t2, 0 
	li $t4, 0 
	
	#user input
	li $v0, 4
	la  $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	addi $s1, $v0, 0 #taking amount of elements into s1
	
	addi $t5, $s1, 0
	
	ble $s1,$0,error2 #negative error 
	bgt $s1,10,error1 # num of elements > 10 error
	
loop1:
	beq $t0, $s1, done #when t0 = s1 is done
	mul $t2, $t0, 4
	
	#counter display for elements
	li $v0, 1
	add $a0, $s2, $0
	syscall
	
	li $v0, 11
	la $a0, ':'
	syscall
	
	#user input for elements 
	li $v0, 5
	syscall
	addi $t4,$v0,0
	
	add $t3, $s0, $t2 
	sw $t4, 0($t3)
	addi $t0, $t0, 1 #increment loop counter
	add $s2, $s2, 1	 #increment elem counter
	
	j loop1
done:
	li $t0,0 #reset loop counter
	lw $t1, 0($t3)
	 	
loop2:
	beq $t0,$t5,printLargest
	mul $t3,$t0,4 
	add $t3,$t3,$s0 
	lw $t2,0($t3)
	 
  
  	#compare register t2 to t1 if smaller then skip
	blt $t2,$t1,skip 
		
  	#if not smaller set as largest
	addi $t1,$t2,0 
	 	
skip:
	addi $t0,$t0,1 
	j loop2
	
printLargest:
	la $a0,ans 
	li $v0,4
	syscall
  
	addi $a0,$t1,0 
	li $v0,1 
	syscall
	
	li $v0,10 #syscall 10 to terminate program
	syscall	
	
error1:#too many err
	li $v0, 4
	la $a0, err1
	syscall
	j main
error2:#negative elem err
	li $v0, 4
	la $a0, err2
	syscall
	j main


	
	
	
	