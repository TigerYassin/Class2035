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

           addi $9, $0, 4        #mulitplier for index    
           addi $3, $0, -1
           swi   568            # returns result in $4 (-1: mine; 0-8: count)
           beq $4, $0, OpenAr
           j GuessAr
           j END


###The PROBLEM : Add the number on the box to the memory 

###OUR SOLUTION: 

# I want to be able to guess open a box, 
    #If that guess gives me a zero, then call OpenAr
    #If that guess gives anything else, then I want to guess open another box
          #After I open that surrounding box, I want to see if it is bordering a bomb/flag, so check the memory for any -1
            
            
GuessAr:    addi  $3, $0, -1     # (the input is for the command you want, -1 is Guess, 0 is to open)
            j RightCen


OpenAr:     addi $3, $0, 0  #0 for open



RightCen:   addi $2, $2, 1
            mult $9, $2          #get the proper index 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, LeftCen #open box if not opened already
                    #If it has already been open, then you leave it alone   


        #this is called when the cell being called to isn't open 
OpenCell: swi 568
          sw $4, location($10) # store box value   
          beq $4, $0, OpenAr  #count the number of bombs around first then call this function




LeftCen:    addi $2, $2, -2
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, LeftTop #open box if not opened already 


        #this is called when the cell being called to isn't open 
OpenCe1:  swi 568
          sw $4, location($10) # store box value
          beq $4, $0, OpenAr   



            #upper bound      
LeftTop:    addi $2, $2, -8
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, CenterTop #open box if not opened already  


        #this is called when the cell being called to isn't open 
OpenCe2:  swi 568
          sw $4, location($10) # store box value   
          beq $4, $0, OpenAr
          


CenterTop:  addi $2,$2,1
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, RightTop #open box if not opened already  


        #this is called when the cell being called to isn't open 
OpenCe3:  swi 568
          sw $4, location($10) # store box value   
          beq $4, $0, OpenAr 
          


RightTop:   addi $2,$2, 1
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, BottomLeft #open box if not opened already  


        #this is called when the cell being called to isn't open 
OpenCe4:  swi 568
          sw $4, location($10) # store box value   
          beq $4, $0, OpenAr
          

            #get lower bound
BottomLeft: addi $2,$2, 14
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, BottomCen #open box if not opened already 


        #this is called when the cell being called to isn't open 
OpenCe5:  swi 568
          sw $4, location($10) # store box value   
          beq $4, $0, OpenAr 
          


BottomCen:  addi $2,$2,1
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, BottomRig #open box if not opened already  


        #this is called when the cell being called to isn't open 
OpenCe6:  swi 568
          sw $4, location($10) # store box value   
          beq $4, $0, OpenAr 
          



BottomRig:  addi $2, $2, 1
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, END #open box if not opened already  


        #this is called when the cell being called to isn't open 
OpenCe7:  swi 568
          sw $4, location($10) # store box value   
          beq $4, $0, OpenAr 
          

            j END

END:  jr $31