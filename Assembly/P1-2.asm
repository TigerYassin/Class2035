#Minesweeper

# Student Name: Yassin Alsahlani 
# Date: 10/15/2018



#Hard coding our data into program 


#Used 10x10 for ease of simplicity and I would have to write less code if I dont have to keep on checking if it is within our #bonds or not


.data


Mem:		.word 	1,1
#extra memory to store the local neighbors 
MineArray:	.word	185273099, 185273099, 168495883, 168430090 , 185207306, 168430091 , 168430090, 168495882, 168430090, 185207306, 168430091, 168430090, 168495882, 168430090, 185207306,   168430091 , 168430090 ,   168495882, 168430090, 185207306, 168430091, 168430090 , 185273098 , 185273099, 185273099		#10x10 array 
###The PROBLEM : Add the number on the box to the memory 
.text




# I want to be able to guess open a box, 
    #If that guess gives me a zero, then open around it 

    #If that guess gives anything else, then I want to guess open another box


          #After I open that surrounding box, I want to see if it is bordering a bomb/flag, so check the memory for any -1
        #Must create methods for :
        	##Detecting whether its a mine when we open it
        			###If it is a mine, then Flag it and move on
        			###If not, then just continue()




#1 - Returns the number of bombs in our map
#2 - Current Index
#3 - Method of operation 
	#Guess = -1
	#Open = 0
	#Flag = 1
MineSweep: 		swi		567	 


				addi	$16,$0,9	#CREATING OUR VALUES 		
				addi	$17,$0,-1			
				addi	$18,$0,10			
				addi	$19,$0,11			
		   		addi	$20, $1, 0			

		   		
		   		#Count == 16
Solve:			addi	$20,$1,0			#Register 1 will give us the count 
				addi 	$21,$0,1	

				addi 	$7,$0,1			
				beq 	$20,$0,END	 #STOP WHEN WE REACH 0		 
				add 	$11,$0,$17		

				add 	$12,$0,$17			
				addi 	$23 ,$0,0			
				addi 	$8,$0,0			
				j 		MineDetector		



#I want to be able to register a bomb 
    #If I open a cell, I want to add that to my memory -- GOOD ---
    #then I want to check the surrounding cells around it, if they are open and non-bomb/flags, then go ahead and subtract 1 from them and re-enter them into the memory 
        #If the newly entered value($4) is equal to zero, then run the OpenAr method


Solve1:		bne 	$23 ,$0,Solve		#TODO  MAKE SURE THIS IS WORKING PROPERLY 
				  addi 	$21 ,$0 ,1			
				addi 	$7 , $0, 1			
				addi 	$11, $17, 0			
				addi 	$12,$17, 0			
				addi 	$8 ,$0, 1	


			#This method must take in the current index 
			#Will give us the value of whether or not it is a bomb and how t o do with it
MineDetector:   beq 	$20,$0, END	
				addi 	$9,$0,0			
				addi 	$10,$0,0			
				addi 	$11,$17,0

				#Multiplying Row and constant 
				mult 	$21,$18				
				mflo 	$13
				add 	$5,$13,$7			
				lb 		$13,MineArray($5) #Store the number into our array of map	

				#Call specific methods based on number opened

				bne 	$8,$0, Guess		
				beq		$13,$19, NextSquare	#Moves to next square 
				beq 	$13,$17, Flag1		
				beq 	$13,$16 ,Flag1	

				beq 	$13,$18, NextSquare	
			

#I want to be able to get a cell with a value of zero, and open all the cells around it and store there values in memory along 

#after subtracting the number of mines and flags around them. After opening the cells around them, I want to set the value of that index in memory to -5 to not get confused with null vals

			
Nearby:	mult	$11,$18
				mflo	$2  #Multiplying Our column $11 by hte multiplier 
				add 	$2,$2,$12
				add 	$15,$2,$5
				beq 	$11,$0, Check
			
Nearby2:	lb 		$2,MineArray($15)	  
				beq 	$2, $19, Next
				beq 	$2 ,$18, Unopened		  
				beq 	$2,$17, Flag2		  
				beq 	$2,$16, Flag2		  
			
Next:	addi 	$12,$12,1
				addi 	$2,$0,2
				beq		$12,$2,SquareNext1
				j 		Nearby
			
			#Move to next 
SquareNext1:	addi	$12,$17, 0			#Called by Next, must move the local index down one to the next cell

				addi 	$11 ,$11,1

				beq 	$11 ,$2, Try
				j 		Nearby
					
Try:		beq		$10,$0,NextSquare 	#CHecking for the neighbors 
				beq		$13 , $0,Try1	


				 beq	 	$13 ,$9 ,Try1

				add 	$2, $9,$10
				beq 	$13,$2,Try2
			
NextSquare:		addi 	$7,$7,1				
				beq 	$7,$16,NextRow			
				j	 	MineDetector			
			
NextRow:		addi 	$7,$0,1 		#check if working properly
				addi 	$21,$21,1
				beq 	$21,$16,Solve1
				j 		MineDetector
			

		##Would check if our counter is set to 0
				###If it is 0, then we will change its neighbor
 Check:		beq 	$12,$0,Next
				j 		Nearby2
				
Flag1:		addi 	$20,$20,-1				
				j	 	NextSquare
					

					#Unopened method that must 
						#sotre the value into our memory
Unopened:		sb 		$15,Mem($10)
				addi 	$10, $10, 1				
				j 		Next
			
			#To be called once falgging
Flag2:      	addi 	$9,$9,1				
				j 		Next



Guess:   	bne 	$13,$18,NextSquare
				div 	$5,$18



 
Calc:  	mflo 	$4				#Would give us our Offset		
				mfhi 	$6
				addi 	$4,$4,-1
				addi 	$6,$6,-1
				addi 	$14,$0,8

				mult 	$4,$14	#Multiplying the 2 values 
				mflo 	$2 				#Storing our new value in the second register
				add 	$2,$2,$6					#We will use that register to open
				bne 	$8,$0,Guess1
				j 		FirstBox


#Reseting our methods 
		#Open
Try1: 		addi 	$3,$0,0
				j 		StatCalc



		#When called, this mehtod must change $3 to begin flagging anything it is called onto
Try2: 		addi	$3,$0,1	

StatCalc: 		addi 	$10,$10,-1
				lb 		$9,Mem($10)
				div 	$9, $18
				j		Calc
				

				#This will only be called from the our Calc method
				#WIll open the first box then store the value in our memory 


FirstBox:		swi 	568							#TODO MAKE SURE WORKING PROPERLY
				sb 		$4, MineArray($9)
				sb 		$19, MineArray($5)

				bne		$10,$0,StatCalc		#branching if not equal to 0
				addi 	$23 ,$0,1
				j 		NextSquare		#Jump to the next cell
			

			
Guess1:			addi 	$3,$0,-1			#Guess on the value 	
				swi 	568						
				sb 		$4, MineArray($5)		
				addi 	$23 ,$0,1                
				j 		Solve

END:	jr  	$31						