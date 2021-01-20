.data
str0:     .asciiz "Welcome to BobCat Candy, home to the famous BobCat Bars!\n"
 # Declare any necessary data here
str1:     .asciiz "Please enter the price of a Bobcat Bar: \n"
str2:     .asciiz "Please enter the number of wrappers needed to exchange for a new bar: \n"
str3:     .asciiz "How, how much do you have? \n"
str4:     .asciiz "Good! Let me run the number ... "
str5:     .asciiz "\nYou first buy "
str6:     .asciiz " bars."
str7:     .asciiz "\nThen, you will get another "
str8:     .asciiz "\nWith $"
str9:     .asciiz ", you will recieve a maximum of "
str10:    .asciiz " Bobcat Bars!"




.text

main:
        #This is the main program.
        #It first asks user to enter the price of each BobCat Bar.
        #It then asks user to enter the number of bar wrappers needed to exchange for a new bar.
        #It then asks user to enter how much money he/she has.
        #It then calls maxBars function to perform calculation of the maximum BobCat Bars the user will receive based on the information entered.
        #It then prints out a statement about the maximum BobCat Bars the user will receive.
        
        addi $sp, $sp -4    # Feel free to change the increment if you need for space.
        sw $ra, 0($sp)
        sw $s0, 8($sp)
        # Implement your main here
        
        
        li    $v0, 4
        la    $a0, str0		#print "Welcome to BobCat Candy"
        syscall
       
        li     $v0, 4		#print "enter the price of a Bobcat Bar"
        la    $a0, str1		
        syscall
        li    $v0, 5
        syscall
        add   $t0, $v0, $0	#copy and store data to $a0
       
        li     $v0, 4		#print "enter the number of wrappers needed"
        la    $a0, str2
        syscall
        li    $v0, 5
        syscall
        add   $t1, $v0, $0	#copy and store data to $a1
       
        li     $v0, 4		#print "how much money do you have"
        la    $a0, str3
        syscall
        li    $v0, 5
        syscall
        add   $t2, $v0, $0	#copy and store data to $a2
        
        
        li    $v0, 4		#print "Good! Let me run the number"
        la    $a0, str4
        syscall
        
        jal maxBars     	# Call maxBars to calculate the maximum number of BobCat Bars

        # Print out final statement here
        la   $a0, str8      	#print "With $"
    	li   $v0, 4         	# specify Print String service
        syscall
        
       	li $v0,1
	add $a0, $zero, $t2
       	syscall
        
        la   $a0, str9   	#print "you will recieve a maximum of"
        li   $v0, 4             # specify Print String service
        syscall
        
        li $v0,1
        add $a0, $zero, $s0
        syscall
        
        la   $a0, str10       # print  "Bobcat Bars!"
        li   $v0, 4           # specify Print String service
        syscall    
        


        j end            # Jump to end of program



maxBars:
        # This function calculates the maximum number of BobCat Bars.
        # It takes in 3 arguments ($a0, $a1, $a2) as n, price, and money. It returns the maximum number of bars
	
	
	div $t2,$t0
	mflo $s0	#quotinet
	mfhi $s1 	#remainder
	
            
	li    $v0, 4		# print "You first buy "
	la    $a0, str5	
        syscall
              
               
	li $v0,1
	add $a0, $zero, $s0
       	syscall
       	add $t3,$zero,$s0
               
	la   $a0, str6      # print " bars."
	li   $v0, 4           
	syscall

        jal newBars     # Call a helper function to keep track of the number of bars.
        
        jr $ra
        # End of maxBars

newBars:  sw $s0, 8($sp)
        # This function calculates the number of BobCat Bars a user will receive based on n.
        # It takes in 2 arguments ($a0, $a1) as number of wrappers left so far and n.
        div $s0, $t1
	mflo $s2
	mfhi $s3
	ble $s2,0,end
	
	
	li   $v0, 4  
	la   $a0, str7		#print "Then, you will get another"
        syscall
        
        li $v0,1
        add $a0,$zero,$s2
        syscall
        
        li   $v0, 4 
        la   $a0, str6		# print "bars"
        syscall		
        
       
        move $s0, $s2
       
            
        j newBars
        
         lw $s0, 8($sp)
        add $t3,$t3,$s0
        add $s0,$s0,$s2
            
        
        jr $ra
        # End of newBars
        
 #next: lw $ra, 0($sp)
 	#addi $sp, $sp, 8
 	#addi, $v0, $zero, 1
 	#jr $ra
 	
 next:
 	lw $ra, 0($sp)
 	addi $sp, $sp, 4
 	#addi, $v0, $zero, 1
 	jr $ra
 	

               
end:
        # Terminating the program
        lw $ra, 0($sp)
        addi $sp,$sp,4
       	li $v0, 10
      	syscall
