#     Minesweeper
#
#  Your Name:	Yassin Alsahlani 
#  Date: 10/12/2018
.data

# your data allocation/initialization goes here

location: .alloc 256

.text
MineSweep: swi   567	   	   # Bury mines (returns # buried in $1)
  
    #If you find a zero, then go around it and open everything
    #If you find a box with a number on it equal to the same number of closed boxes it touches, then flag them all
 
#Variables: $2 - Current Cell(0-63)     $3 - Command Type       $4 - mine, flag, or number of bombs around cell 


	   # TEMP: guess square 0 ($2: position, $3: command to GUESS)
           addi  $2, $0, 0	# Mine field position 0
           addi  $3, $0, -1     # Guess
           swi   568            # returns result in $4 (-1: mine; 0-8: count)

	   # TEMP: open square 9 ($2: position, $3: command to OPEN)
           addi  $2, $0, 9	# Mine field position 9
           addi  $3, $0, 0      # Open
           swi   568            # returns result in $4 (-1: mine; 0-8: count)

	   # TEMP: flag square 25 ($2: position, $3: command to FLAG)
           addi  $2, $0, 25	# Mine field position 25
           addi  $3, $0, 1      # Flag
           swi   568            # returns result in $4 (9)



           # your code goes here


     #Count the number of open boxes around a cell
     #A good way to find all the open ones is to store their corresponding box value to the memory, everytime you try to open a new #box, just check if it already exists in memory, the number in memory should correspond with the appropriate number of #unflagged/unopened mines around it, If the number on the box is zero, and there is an unopened box around it, then you must #open that box, if the number on the box is equivalent to the number of unopened boxes around it, then you can go ahead and #flag them all and subtract 1 from all border boxes and try to find any border boxes who's value just went to zero after #subtracting 1
     #Set a counter outside the method
     #everytime you find a box that is unopened, iterate the counter by a scale factor of 1


     #To store register 2 into memory with corresponding number, do this:
     addi $2, $0, 300
     sb $4, location($2)

     #To find if the box has already been open, register 6 holds the current box you are iterating over, if you find a box who's #value comes to zero, then store it in register 7,8,9,10 and come back to it after you finished using register 6.  





    #OPEN A BOX
    #Open box, check to see if there is a mine or flag around it. 
        # If there isn't a mine around it, then go ahead and store that #number into memory
        # If there are mines that have been flagged or opened, then go ahead and subtract the corresponding count from the actual #number of the box, and store the updated number into memory 

test:      addi  $2, $0, 41      #This is the cell that would be opened (input is the cell you want opened)      
           addi  $3, $0, -1     # (the input is for the command you want, -1 is Guess)
           swi   568            # returns result in $4 (-1: mine; 0-8: count)

      #Open the boxes around the first box
OpenAround: add $5, $0, $0  #$5 = counter 
            addi $2, $2, 1
            swi 568
            addi $2, $0, 40
            swi 568

            addi $8, $0, 8    #add 8 to each index to get the next row        ####TODO: THIS CAN BE FIXED BY JUST SUBTRACTING CONST 
            #upper bound
            sub $2, $2, $8
            swi 568
            addi $2,$2,1
            swi 568
            addi $2,$2, 1
            swi 568
            
            #get lower boud
            addi $8, $8, 6   #starts from the first column in the window
            add $2,$2, $8
            swi 568
            addi $2,$2,1
            swi 568
            addi $2, $2, 1
            swi 568




     #Count the number of closed boxes around a cell


           jr  $31  	  	   # return to OS
