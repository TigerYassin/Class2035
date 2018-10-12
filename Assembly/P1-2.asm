#     Minesweeper
#
#  Your Name:	Yassin Alsahlani 
#  Date: 10/12/2018
.data

# your data allocation/initialization goes here

location: .alloc 256

.text
MineSweep: swi   567	   	   # Bury mines (returns # buried in $1)
  


test:      addi  $2, $0, 27     # This is the cell that would be opened (input is the cell you want opened)   

           addi $9, $0, 4        #mulitplier for index    
           addi $3, $0, -1
           addi $8, $0, -1
           swi   568            # returns result in $4 (-1: mine; 0-8: count)
           beq $4, $0, OpenAr
           mult $9, $2
           mflo $10
           sw $4, location($10)
           j GuessAr
           j END


###The PROBLEM : Add the number on the box to the memory 

###OUR SOLUTION: 

# I want to be able to guess open a box, 
    #If that guess gives me a zero, then call OpenAr
    #If that guess gives anything else, then I want to guess open another box
          #After I open that surrounding box, I want to see if it is bordering a bomb/flag, so check the memory for any -1



#I want to be able to register a bomb 
    #If I open a cell, I want to add that to my memory -- GOOD ---
    #then I want to check the surrounding cells around it, if they are open and non-bomb/flags, then go ahead and subtract 1 from them and re-enter them into the memory 
        #If the newly entered value($4) is equal to zero, then run the OpenAr method


#I want to be able to open a cell and count the number of closed cells around it and the number of flags/mines
    #Then I want to subtract the number on it from the number of mines/flags around it and store it to a register  --TODO--- 
        #If the difference is equal to 0, then run the OpenAr method

#I want to be able to get a cell with a value of zero, and open all the cells around it and store there values in memory along after subtracting the number of mines and flags around them. After opening the cells around them, I want to set the value of that index in memory to -5 to not get confused with null vals
            
            
GuessAr:    addi  $3, $0, -1     # (the input is for the command you want, -1 is Guess, 0 is to open)
            j RightCen


            #Used to open all the cells around a 0 
            #Must restore zero values as -5 after they have ran through OpenAr
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
          beq $4, $8, Flag

          #Checks for unvocered bombs/mines around it, $4 contains the number on that box, $20 is the new $2, $10 gets the appropriate index in mem by multiplication. $11 keeps count of the bombs/flags checks for -1 in mem and subtracts the count from the box number $4

        
#CheckBomb checks border cells to see if bomb has already been open/flagged
SkipCount: addi $20, $2, 1
           mult $20, $9
           mflo $10 
           lw $14, location($10)
           bne $14, $8, SkipCount1
           addi $4, $4, -1
           beq $4, $0, OpenAr


SkipCount1:  addi $20, $20, -2
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount2
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount2:  addi $20, $20, -8
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount3
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount3:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount4
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount4:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount5
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount5:  addi $20, $20, 14
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount6
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount6:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount7
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount7:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             mult $2, $9              ####COME BACK FROM THE MULT
             mflo $10
             bne $14, $8, LeftCen
             addi $4, $4, -1
             beq $4, $0, OpenAr



LeftCen:    sw $4, location($10)
            addi $2, $2, -2
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, LeftTop #open box if not opened already 


        #this is called when the cell being called to isn't open 
OpenCe1:  swi 568
          sw $4, location($10) # store box value
          beq $4, $0, OpenAr          
          beq $4, $8, Flag


#CheckBomb checks border cells to see if bomb has already been open/flagged
SkipCount10: addi $20, $2, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount11
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount11:  addi $20, $20, -2
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount12
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount12: addi $20, $20, -8
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount13
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount13:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount14
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount14:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount15
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount15:  addi $20, $20, 14
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount16
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount16:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount17
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount17:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             mult $2, $9   
             mflo $10
             bne $14, $8, LeftTop
             addi $4, $4, -1
             beq $4, $0, OpenAr




            #upper bound      
LeftTop:    sw $4, location($10)
            addi $2, $2, -8
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, CenterTop #open box if not opened already  


        #this is called when the cell being called to isn't open 
OpenCe2:  swi 568
          sw $4, location($10) # store box value   
          beq $4, $0, OpenAr
          beq $4, $8, Flag


#CheckBomb checks border cells to see if bomb has already been open/flagged
SkipCount20: addi $20, $2, 1
           mult $20, $9
           mflo $10 
           lw $14, location($10)
           bne $14, $8, SkipCount21
           addi $4, $4, -1
           beq $4, $0, OpenAr


SkipCount21:  addi $20, $20, -2
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount22
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount22:  addi $20, $20, -8
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount23
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount23:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount24
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount24:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount25
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount25:  addi $20, $20, 14
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount26
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount26:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount27
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount27:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             mult $2, $9   
             mflo $10
             bne $14, $8, CenterTop
             addi $4, $4, -1
             beq $4, $0, OpenAr

          


CenterTop:  sw $4, location($10)
            addi $2,$2,1
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, RightTop #open box if not opened already  


        #this is called when the cell being called to isn't open 
OpenCe3:  swi 568
          sw $4, location($10) # store box value   
          beq $4, $0, OpenAr 
          beq $4, $8, Flag

#CheckBomb checks border cells to see if bomb has already been open/flagged
SkipCount30: addi $20, $2, 1
           mult $20, $9
           mflo $10 
           lw $14, location($10)
           bne $14, $8, SkipCount31
           addi $4, $4, -1
           beq $4, $0, OpenAr


SkipCount31:  addi $20, $20, -2
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount32
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount32:  addi $20, $20, -8
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount33
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount33:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount34
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount34:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount35
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount35:  addi $20, $20, 14
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount36
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount36:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount37
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount37:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             mult $2, $9   
             mflo $10
             bne $14, $8, RightTop
             addi $4, $4, -1
             beq $4, $0, OpenAr
          


RightTop:   sw $4, location($10)
            addi $2,$2, 1
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, BottomLeft #open box if not opened already  


        #this is called when the cell being called to isn't open 
OpenCe4:  swi 568
          sw $4, location($10) # store box value   
          beq $4, $0, OpenAr
          beq $4, $8, Flag

#CheckBomb checks border cells to see if bomb has already been open/flagged
SkipCount40: addi $20, $2, 1
           mult $20, $9
           mflo $10 
           lw $14, location($10)
           bne $14, $8, SkipCount41
           addi $4, $4, -1
           beq $4, $0, OpenAr


SkipCount41:  addi $20, $20, -2
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount42
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount42:  addi $20, $20, -8
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount43
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount43:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount44
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount44:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount45
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount45:  addi $20, $20, 14
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount46
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount46:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount47
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount47:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             mult $2, $9   
             mflo $10
             bne $14, $8, BottomLeft
             addi $4, $4, -1
             beq $4, $0, OpenAr

          


            #get lower bound
BottomLeft: sw $4, location($10)
            addi $2,$2, 14
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, BottomCen #open box if not opened already 


        #this is called when the cell being called to isn't open 
OpenCe5:  swi 568
          sw $4, location($10) # store box value   
          beq $4, $0, OpenAr 
          beq $4, $8, Flag


#CheckBomb checks border cells to see if bomb has already been open/flagged
SkipCount50: addi $20, $2, 1
           mult $20, $9
           mflo $10 
           lw $14, location($10)
           bne $14, $8, SkipCount51
           addi $4, $4, -1
           beq $4, $0, OpenAr


SkipCount51:  addi $20, $20, -2
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount52
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount52:  addi $20, $20, -8
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount53
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount53:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount54
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount54:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount55
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount55:  addi $20, $20, 14
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount56
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount56:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount57
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount57:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             mult $2, $9   
             mflo $10
             bne $14, $8, BottomCen
             addi $4, $4, -1
             beq $4, $0, OpenAr


BottomCen:  sw $4, location($10)
            addi $2,$2,1
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, BottomRig #open box if not opened already  


        #this is called when the cell being called to isn't open 
OpenCe6:  swi 568
          sw $4, location($10) # store box value   
          beq $4, $0, OpenAr 
          beq $4, $8, Flag
          

#CheckBomb checks border cells to see if bomb has already been open/flagged
SkipCount60: addi $20, $2, 1
           mult $20, $9
           mflo $10 
           lw $14, location($10)
           bne $14, $8, SkipCount61
           addi $4, $4, -1
           beq $4, $0, OpenAr


SkipCount61: addi $20, $20, -2
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount62
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount62:  addi $20, $20, -8
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount63
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount63:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount64
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount64:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount65
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount65:  addi $20, $20, 14
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount66
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount66:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount67
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount67:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             mult $2, $9   
             mflo $10
             bne $14, $8, BottomRig
             addi $4, $4, -1
             beq $4, $0, OpenAr



BottomRig:  sw $4, location($10)
            addi $2, $2, 1
            mult $9, $2         #start open 
            mflo $10
            lw $4, location($10) # check if box opened previously
            bne $4, $0, END #open box if not opened already  


        #this is called when the cell being called to isn't open 
OpenCe7:  swi 568
          sw $4, location($10) # store box value   
          beq $4, $0, OpenAr 
          beq $4, $8, Flag
          
#CheckBomb checks border cells to see if bomb has already been open/flagged
SkipCount70: addi $20, $2, 1
           mult $20, $9
           mflo $10 
           lw $14, location($10)
           bne $14, $8, SkipCount71
           addi $4, $4, -1
           beq $4, $0, OpenAr


SkipCount71:  addi $20, $20, -2
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount72
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount72:  addi $20, $20, -8
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount73
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount73:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount74
             addi $4, $4, -1
             beq $4, $0, OpenAr


SkipCount74:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount75
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount75:  addi $20, $20, 14
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount76
             addi $4, $4, -1
             beq $4, $0, OpenAr



SkipCount76:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             bne $14, $8, SkipCount77
             addi $4, $4, -1
             beq $4, $0, OpenAr

SkipCount77:  addi $20, $20, 1
             mult $20, $9
             mflo $10 
             lw $14, location($10)
             mult $2, $9   
             mflo $10
             sw $4, location($10)
             bne $14, $8, END
             addi $4, $4, -1
             beq $4, $0, OpenAr

            j END


          ##THIS MUST LOOP AROUND THE INDEX AND SUBTRACT 1 FROM ALL OPEN BOXES 

Flag:   addi $20, $2, 0 #is the bomb equivalent of $2
        


END:  jr $31