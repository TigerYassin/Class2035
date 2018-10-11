#     Minesweeper
#
#  Your Name:	Yassin Alsahlani 
#  Date: 10/12/2018
.data

# your data allocation/initialization goes here

location: .alloc 256

.text
MineSweep: swi   567	   	   # Bury mines (returns # buried in $1)
  


test:      addi  $2, $0, 13     # This is the cell that would be opened (input is the cell you want opened)      
           addi  $3, $0, -1     # (the input is for the command you want, -1 is Guess, 0 is to open)
           swi   568            # returns result in $4 (-1: mine; 0-8: count)
           beq $4, $0, OpenAr
           j GuessAr
           j END


###The PROBLEM : 

###OUR SOLUTION: 
            
            
GuessAr:    j RightCen
            addi $9, $0, 4

RightCen:   addi $8, $0, 2
            addi $2, $2, 1
            mult $9, $2          #get the proper index 
            mflo $10
            lw $4, location($10) # check if box opened previously
            beq $4, $0, OpenCell #open box if not opened already  
            beq $4, $0, OpenAr #This is a zero, open all around


        #this is called when the cell being called to isn't open 
OpenCell: addi $4, $4, 0 
          sw $4, location($10) # store box value   
          swi 568
          beq $4, $0, OpenAr  #count the number of bombs around first then call this function 




LeftCen:    sub $2, $2, $8
            swi 568
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            beq $4, $0, OpenCe1 #open box if not opened already  
            swi 568
            beq $4, $0, OpenAr #This is a zero, open all around


        #this is called when the cell being called to isn't open 
OpenCe1:  addi $4, $4, 0 
          sw $4, location($10) # store box value   



            #upper bound      
LeftTop:    addi $8, $0, 8    #add 8 to each index to get the next row       
            sub $2, $2, $8
            swi 568
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            beq $4, $0, OpenCe2 #open box if not opened already  
            swi 568
            beq $4, $0, OpenAr #This is a zero, open all around


        #this is called when the cell being called to isn't open 
OpenCe2:  addi $4, $4, 0 
          sw $4, location($10) # store box value   
          


CenterTop:  addi $2,$2,1
            swi 568
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            beq $4, $0, OpenCe3 #open box if not opened already  
            swi 568
            beq $4, $0, OpenAr #This is a zero, open all around


        #this is called when the cell being called to isn't open 
OpenCe3:  addi $4, $4, 0 
          sw $4, location($10) # store box value   
          


RightTop:   addi $2,$2, 1
            swi 568
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            beq $4, $0, OpenCe4 #open box if not opened already  
            swi 568
            beq $4, $0, OpenAr #This is a zero, open all around


        #this is called when the cell being called to isn't open 
OpenCe4:  addi $4, $4, 0 
          sw $4, location($10) # store box value   
          

            #get lower bound
BottomLeft: addi $8, $8, 6   #starts from the first column in the window
            add $2,$2, $8
            swi 568
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            beq $4, $0, OpenCe5 #open box if not opened already  
            swi 568
            beq $4, $0, OpenAr #This is a zero, open all around


        #this is called when the cell being called to isn't open 
OpenCe5:  addi $4, $4, 0 
          sw $4, location($10) # store box value   
          


BottomCen:  addi $2,$2,1
            swi 568
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            beq $4, $0, OpenCe6 #open box if not opened already  
            swi 568
            beq $4, $0, OpenAr #This is a zero, open all around


        #this is called when the cell being called to isn't open 
OpenCe6:  addi $4, $4, 0 
          sw $4, location($10) # store box value   
          



BottomRig:  addi $2, $2, 1
            swi 568
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            beq $4, $0, OpenCe7 #open box if not opened already  
            swi 568
            beq $4, $0, OpenAr #This is a zero, open all around


        #this is called when the cell being called to isn't open 
OpenCe7:  addi $4, $4, 0 
          sw $4, location($10) # store box value   
          

            j END



            #check if open already 

#Open:       ##responsible for opening the cell, but checking if it has been open first. If it has been open already, then check 
            ##if it is a flag/bomb. If it hasn't been open, then open(call method) it and store the value to $10, if it already ##open, then store its value to $10
Store:      addi $9, $0, 4
            mult $2, $9
            mflo $9
            sw $2, location($9)

check:      lw $4, location($10) #start check 

OpenAr:     addi $3, $0, 0
            j GuessAr





END:  jr $31