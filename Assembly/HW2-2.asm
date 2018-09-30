# HW2-2
# Student Name: Yassin Alsahlani 
# Date: 9/14/2018
#
# This program detects edges in a 32X32 image array by comparing the
# intensity of each pixel and its 4 immediate neighbors (North, South,
# East, and West), computing the difference of the Max and Min intensity
# values, and setting the corresponding output pixel to the computed
# Max-Min difference in intensity. The program handles pixels on the
# boundaries of the image specially to prevent trying to access
# neighboring pixels that do not exist (i.e., no image wraparound is
# allowed).

.data
Array:  .alloc	1024				# allocate image data space
Edges:  .alloc	1024				# allocate output data space
Extra: 	.alloc  20		#for the NWSE values of the index 
.text
Detect:	addi	$1, $0, Array		# set memory base
		swi	596			# create and display image pair
		addi    $1, $0, 0
		addi	$6, $0, 4096		# set limit

	# your code goes here
	
	#1. Load in the Array image and allocate memory for the new image
	#2. Loop through the array and check to see if the current index is an edge
	#3.0 If the current index is corner edge, then pass it to a helper function that takes three input
	#3.1 If the current index is an edge, then pass it to a helper function that handles four input
	#3.2 If the current index is not an edge, then pass it to a helper function that handles five inputs 
	#4 the helper functions must find the highest value amoungst the values given and return the MAX - MIN
	#5 Append the returned value to the Edges array

	lw $26, Edges($0)

loop:   lw   $2, Array($1) #currentIndex - $2

		#Checking for corner edge

		#if statement (If currentIndex == 0)				#TODO must fix the special cases 
															#must complete Parts 13.1 and 13.2
			beq $1, $0, CornerF #First corner

		#if statement (If currentIndex == 32)
			addi $20, $0, 128
			beq $1, $20, CornerS #Second corner

		#if statement (if currentIndex == 992)
			addi $20, $0, 128
			beq $1, $20, CornerT #Third corner 

		#if statement (If currentIndex == 1023)
			addi $20, $0, 128
			beq $1, $20, CornerL #Last Corner


		# Checking for regular edges

		#if statement (if currentIndex < 32)
			addi $4, $0, 128 
			slt $5, $4, $1
			beq $5, $0, Three1

		#if statement (if currentIndex > 992)
			addi $4, $0, 3968
			slt $5, $1, $4
			beq $5, $0, Three2

		#if statement (if currentIndex % 32 == 0)
			add $23, $1, $0 
			addi $4, $0, 32
			addi $22, $0, 1
Mod:		slt $7, $23, $4 #(if curr < 32) set bool == True
			beq $7, $22, Modulus #if boolval == 1 then goto Modulus and $23 is the new modulus value 
			sub $23, $23, $4  #decreasing $5 by $4
			j Mod

Modulus:    beq $23, $0, Three3

		#if statement (if currentIndex % 32 == 31)
			addi $4, $0, 31
			beq $23, $4, Three4

		#general case 
		beq $0, $0, GenCase



# GENERAL CASE - WILL ALWAYS EXECUTE IF NONE OF THE ABOVE CONDITIONS ARE MET 

#general case 
GenCase:	addi $4, $0, 128			##getting the proper index 
			addi $8, $0, 4
			sub $5, $1, $4			#North index
		 	add $4, $1, $4			#South index
			add $7, $1, $8			#East index
			sub $9, $1, $8			#West index

			##Plugging in the indexes to get the values 
			lw $10, Array($4)		#South Value
			lw $11, Array($5)		#North Value
			lw $12, Array($7)		#East Value
			lw $13, Array($9)		#West Value


			#Storing the values back in memory so we can loop through it later
			addi $14, $0, 0
			sw $10, Extra($14)
			addi $14, $14, 4
			sw $11, Extra($14)
			addi $14, $14, 4
			sw $12, Extra($14)
			addi $14, $14, 4
			sw $13, Extra($14)
			addi $14, $14, 4
			sw $2, Extra($14)


			#loop through the memory and set $15 to MAX and $16 to MIN
			addi $15, $0, 0 #MAX
			addi $16, $0, 400 #MIN

			addi $4, $0, 0 #setting our counter
			addi $17, $0, 20 #setting our limit

			#if value at current mem is greater than $15, then set $15 to current mem
					#but first calling from memory
miniLoop: 	beq $4, $17, Done
			lw $5, Extra($4)
			slt $7, $5, $15		#setting $7 to 1 if $5 < $15
			slt $8, $16, $5		#setting $8 to 1 if $16 < $5
			addi $4, $4, 4 		#iterating our counter 

			beq $7, $0, ResetMax
complete5:	beq $8, $0, ResetMin
			j miniLoop
ResetMax: 	addi $15, $5, 0
			j complete5

ResetMin:   addi $16, $5, 0 
			j miniLoop

Done: 		sub $18, $15, $16
			sw $18, Edges($1)

			beq $1, $6, End
			addi $1, $1, 4  #iterating our overall counter


			j loop  #going back to the daddy loop



#get the edges for the first corner 

CornerF:    addi $4, $0, 128  #stores the South Index 
			addi $5, $0, 4    #stores the East Index
			lw $4, Array($4)#south value - $4
			lw $5, Array($5)#east value - $5

			#store the number in the Extra array so we can loop through it later
Sminiloop:  addi $7, $0, 0   
			sw $4, Extra($7)
			addi $7, $7, 4
			sw $5, Extra($7)
			addi $7, $7, 4
			sw $2, Extra($7)

			addi $15, $0, 500 
		    sub $15, $0, $15   #MAX
			addi $16, $0, 600  #MIN	
			addi $17, $0, 12 #setting our limit
			addi $4, $0, 0   #Creating the counter

miniloopS:  beq $4, $17, Done
			lw $5, Extra($4)
			addi $22, $0, 1
			slt $7, $15, $5		#setting $7 to 1 if $5 > $15
			slt $8, $5, $16		#setting $8 to 1 if $16 > $5
			addi $4, $4, 4 		#iterating our counter 

			beq $7, $22, ResetMax2
complete3:	beq $8, $22, ResetMin2

			j miniloopS

ResetMax2:  addi $15, $5, 0
			j complete3 
ResetMin2:  addi $16, $5, 0 
			j miniloopS


####The rest of the Special Edge corners 

CornerS:    addi $4, $1,128 #stores the South Index 
			addi $5, $0, 4  
			sub $5, $1, $5  #stores the West Index
			lw $4, Array($4)#south value - $4
			lw $5, Array($5)#west value - $5  
			j Sminiloop 


CornerT:    addi $4, $1, 4   #stores the East Index 
			addi $5, $0, 128
			sub $5, $1, $5   #stores the North Index 
			lw $4, Array($4) #East Value 
			lw $5, Array($5) #North Val
			j Sminiloop


CornerL:    addi $4, $0, 4  
			sub $4, $1, $4   #Stores the West Index 
			addi $5, $0, 128
			sub $5, $1, $5   #Stores the North Index
			lw $4, Array($4) #West Value
			lw $5, Array($5) #North Value 
			j Sminiloop





			###THE REGULAR EDGES 

Three1:     addi $4, $1, 128    #index of South
			addi $5, $1, 4		#index for East
			addi $7, $0, 4		
			sub $7, $1, $7		#index for West

			#loading out the number from the array
Meth:		lw $4, Array($4)
			lw $5, Array($5)
			lw $7, Array($7)


			#storing the numbers in memory for later use
			addi $8, $0, 0
			sw $4, Extra($8)
			addi $8, $8, 4
			sw $5, Extra($8)
			addi $8, $8, 4
			sw $7, Extra($8)
			addi $8, $8, 4
			sw $2, Extra($8)


			addi $15, $0, 600		
			sub $15, $0, $15	#MAX
			addi $16, $0, 500 	#MIN

			addi $4, $0, 0 #setting our counter
			addi $17, $0, 16 #setting our limit
miniloopT:  beq $4, $17, Done
			lw $5, Extra($4)


			slt $7, $15, $5	#if $5 > $15, set $7 to 1
			beq $7, $22, ResetMax3
complete1:	slt $8, $5, $16 #if (Min > C) set $8 to 1				#MIGHT HAVE TO COME BACK AND FIX THIS BECAUSE IT DOESNT  
			beq $8, $22, ResetMin3										#REACH THE LESS THAN $16 IN TIME 		
complete2:	addi $4, $4, 4  #iterating our counter 
			j miniloopT

ResetMax3:  addi $15, $5, 0 #updating MAX value
			j complete1
ResetMin3:  addi $16, $5, 0 #updating MIN value 
			j complete2


Three2: 	addi $4, $1, 4 		#East
			addi $5, $0, 128
			sub $5, $1, $5		#North
			addi $7, $0, 4
			sub $7, $1, $7		#West
			j Meth

Three3: 	addi $4, $1, 4 		#East
			addi $5, $0, 128	
			sub $5, $1, $5		#North
			addi $7, $1, 128	#South
			j Meth

Three4: 	addi $4, $1, 128	#South
			addi $5, $0, 128
			sub $5, $1, $5		#North
			addi $7, $0, 4
			sub $7, $1, $7		#West
			j Meth
			

End:	addi $1, $0, Edges		# set memory base
		swi	533					# display new output image
		jr $31