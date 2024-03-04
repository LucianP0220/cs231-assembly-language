.data
	line0: .asciiz "\n=============================================================================\n"
	line1: .asciiz "Program Description: \t\t"
	line2: .asciiz "Encrypt and decrypt a string\n"
	line3: .asciiz "Author:\t\t\t"
	line4: .asciiz "Lucian Pate\n"
	line5: .asciiz "Creation Date:\t\t\t"
	line6: .asciiz "03/30/2021\n"
	msg:   .asciiz "Please enter message to be sent:\n"
	enstr: .asciiz "\nYour encrypted message is:\n "
	destr: .asciiz "\nYour decrypted message is:\n "
	input: .byte   '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'
	s1:     .asciiz "\n\r"
	encrpt: .byte   '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'
	s2:    .asciiz "\n\r"
	decrpt: .byte   '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'
	s3:     .asciiz "\n\r"
.text
	
	li $v0, 4        #header
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
	li $s0, 10          #KEY

    	li  $v0, 4
    	la  $a0, msg        #display input screen
    	syscall
    
    
    	la  $a0, input      #load the input char array
    	li  $v0, 8          #read string
    	li  $a1, 10         #Read 9 characters MAX
    	syscall
    
    	li  $t0, 10         #counter for character arrays
    	la  $s1, encrpt     #Load the addr for encrypt array
    	la  $s2, input      #Load the addr for input array
    
encloop:
    	beq $t0, $0, encprint    #When finished, go to print the encrypted message
    	lb  $t1, 0($s2)     #Load the character into $t1
    
    	xor $t2, $t1, $s0   #XOR to encrypt the message
    
    	sb $t2, 0($s1)      #store the encrypted character
    	li  $t2, 0          #Clear the register
    	li  $t1, 0          #Clear the register
    
  	add $s2, $s2, 1     #Move the pointer to the next character
    	add $s1, $s1, 1     #Move the pointer to the next open byte
    
    	sub $t0, $t0, 1     #Subtract 1 from the counter until 0
    
    	j   encloop
    
encprint:
    	li  $v0, 4
    	la  $a0, enstr      #output the message "This is your msg"
    	syscall
    
    	li  $v0, 4
    	la  $a0, encrpt     #Output the encrypted message
    	syscall
    
    	li  $t0, 10         #counter for character arrays
    	la  $s2, encrpt     #Load the addr for encrypt array
    	la  $s1, decrpt      #Load the addr for input array
    
decloop:
    	beq $t0, $0, decprint    #When finished, go to print the encrypted message
    	lb  $t1, 0($s2)     #Load the character into $t1
    
    	xor $t2, $t1, $s0   #XOR to decrypt the message
    
    	sb $t2, 0($s1)      #store the encrypted character
    	li  $t2, 0          #Clear the register
    	li  $t1, 0          #Clear the register
    
    	add $s2, $s2, 1     #Move the pointer to the next character
    	add $s1, $s1, 1     #Move the pointer to the next open byte
    
    	sub $t0, $t0, 1     #Subtract 1 from the counter until 0
    
    	j   decloop
    
decprint:
    	li  $v0, 4
    	la  $a0, destr      #output the message 
    	syscall
    
    	li  $v0, 4
    	la  $a0, decrpt     #Output the encrypted message
    	syscall
    
    	li  $v0, 10         #end
    	syscall