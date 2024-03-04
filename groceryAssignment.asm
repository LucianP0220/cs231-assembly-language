.data
	arr1: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	arr2: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	line0: .asciiz "\n=============================================================================\n"
	line1: .asciiz "Program Description: \t\t"
	line2: .asciiz "Write a program for a grocery store to calculate the total charge for customers \n"
	line3: .asciiz "Author:\t\t\t"
	line4: .asciiz "Lucian Pate\n"
	line5: .asciiz "Creation Date:\t\t\t"
	line6: .asciiz "03/17/2022\n" 
	itemPrompt: .asciiz "Please enter the number of item you are purchasing: "
	pricePrompt: .asciiz "Please enter the price of item "
	couponPrompt: .asciiz "Please enter the number of coupons that you want to use: "
	couponAmount: .asciiz "Please enter the amount of coupon "
	total: .asciiz "Your total charge is: $"
	endPrompt: .asciiz "\nThank you for shopping with us."
	
	itemErr: .asciiz "Sorry, too many items to purchase!!\n"
	couponErr: .asciiz "Too many Coupons!!\n" 
	invalidErr: .asciiz "This coupon is not acceptable\n"
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
	li $s0, 0 #counter
	li $s1, 20 #max Items
	
	la $a0, itemPrompt
	syscall
	li $v0, 5
	syscall
	
	bge $v0, $s1, err1
	
	add $a0, $0, $v0
	add $t9, $0, $v0
	
	jal FillPriceArray
	li $v0, 4
	la $a0, line0
	syscall
main2:
	li $v0, 4
	la $a0, couponPrompt
	syscall
	li $v0, 5
	syscall
	
	bgt $v0, $t9, err2
	add $a0, $0, $v0
	
	jal FillCouponArray
	
	j sum
	
printSum:
	li $v0, 4
	la $a0, line0
	syscall
	la $a0, total		
	syscall

	add $a0, $s6, $0	
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, endPrompt		
	syscall

	li $v0, 10
	syscall
	
FillPriceArray:
	add $t2, $a0, $0
	li $t0, 1		#counter
	la $s2, arr1		

	li $v0, 4
	la $a0, line0
	syscall

loop1:
	beq $t2, $0, return
	li $v0, 4
	la $a0, pricePrompt	
	syscall
		
	add $a0, $t0, $0
	li $v0, 1		
	syscall
	
	li $v0, 11
	la $a0, ':'
	syscall
	
	#user input 
	li $v0, 5
	syscall
	
	add $t1, $v0, $0	#setting a temporary value for the user input for price
	sw $t1, 0($s2)		#set the array $s2 with the elements the user entered with from $t1
	
	
	add $s2, $s2, 4		#increment the array 
	add $t0, $t0, 1		#increment the counter 
	addi $t2, $t2, -1	#decrement the amount of items 
	
	j loop1
return:
	jr $ra
	
FillCouponArray:
	add $t4, $a0, $0	 
	li $t0, 1 #counter
	li $t3, 10 #the range for the coupon
	
	la $s5, arr2 #coupon array
	la $s2, arr1 #item array
	
loop2:
	beq $t4, $0, return2
	
	li $v0, 4
	la $a0, couponAmount		#output the statement for the user's coupon to be entered
	syscall
	
	add $a0, $t0, $0
	li $v0, 1		 
	syscall
	
	li $v0, 11
	la $a0, ':'
	syscall
	
	li $v0, 5
	syscall
	
	add $t1, $v0, $0	
	lw $t2, 0($s2)		
	
	bge $t1, $t2, err3	
	bge $t1, $t3, err3	#user's input to be greater than or equal to 10
	
	sw $t1, 0($s5)		#used to store the coupons into an array
	
	addi $s5, $s5, 4	#increment the CouponArray
	addi $s2, $s2, 4	#increment the ItemArray
	add $t0, $t0, 1		#used to increment the counter
	addi $t4, $t4, -1	#decrement once that coupon is checked
	
	j loop2
	
invalidCoupon:
	sw $0, 0($s5)		#set register 0 as the value inside of the CouponArray if the user enters a number greater or equal to 10
	addi $s5, $s5, 4	#increment the CouponArray
	addi $s2, $s2, 4	#increment the ItemArray
	addi $t0, $t0, 1	#used to increment the counter
	addi $t4, $t4, -1	#decrement once that coupon is checked
	
	j loop2
	
return2:
	jr $ra
	
sum:	
	la $s2, arr1
	la $s5, arr2
	
sumLoop:
	beq $t9, $0, printSum
	lw $t0, 0($s2)		#load the array for the items
	lw $t1, 0($s5)		#load the array for the coupons
	
	sub $t2, $t0, $t1	#subtracts coupons to the price of items
	add $s6, $t2, $s6	#get the sum of the items
	
	addi $t9, $t9, -1	#decrement the items from user's input
	add $s2, $s2, 4		#increment the item array
	add $s5, $s5, 4		#increment the coupon array
	
	j sumLoop
	
#errors	
err1:
	li $v0, 4
	la $a0, itemErr
	syscall
	
	j main
	
err2: 
	li $v0, 4
	la $a0,couponErr 
	syscall
	
	j main2
	
err3:
	li $v0, 4
	la $a0, invalidErr
	syscall
	
	j invalidCoupon