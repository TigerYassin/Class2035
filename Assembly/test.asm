#     Minesweeper
#
#  Your Name:	Yassin Alsahlani 
#  Date: 10/12/2018
.data

# your data allocation/initialization goes here

location: .word 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8

.text
MineSweep: swi   567	   	   # Bury mines (returns # buried in $1)
  
#REGISTERS USED:
#1 - Number of bombs on Grid
#2 - Global Index
#12 - Temp index in CheckIf/Start Index
#22 - Local Index 
#3 - Guess/Open/Flag Options
#4 - NumOnBox -1 for mine
#5 - Index mulitplier to get proper index ( REMOVE SOON ) (4)
#6 - Proper Index after Multiplication ( REMOVE SOON ) / Also used for Local calculations 
#7 - Row number
#8 - Dividing factor of 8 (8)
#9 - Column number
#10 - LowerBoundry for Neighbor loop (-1)
#11 - Counts Row iters 
#13 - Counts Column iters 
#14 - terminating point in loop (2)


#17 - $11 and 0001
#18 - $13 and 0001

#13 - UnopenedCells -Returns count
#14 - FlaggedCells -Returns count


#20 - Stores the Global Index temporarily 


          #GLOBAL VARIABLES 

            addi $2, $0, -1   #must reassign Global Index inorder to Open and Flag
            addi $3, $0, -1    #Operation Guess/Open/Flag
            addi $12, $0, 0    #Start Index, We have to be revalued everytime a new row is completed 
            addi $5, $0, 4    #set multiplier for memory access
            addi $8, $0, 8    #set multiplier/divider for graph access
            addi $21, $0, 8   #Value for unopened cell in memory 
            addi $26, $0, 2   #Checks if we are on Row 2 Col 2

main:       addi $2, $2, 1      #GLOBAL INDEX 
            addi $3, $0, -1    
            swi 568
            #Put num into mem
            mult $2, $5
            mflo $6
            sw $4, location($6)


            #This method is a for loop, it starts from the Global Start Index and interates through it until it reaches the Global Index, in which it stops 
            #Throws each index to CheckIf to see if it able to be Opened of Flagged
            #If anything is opened or flagged, then you must start again from the Global Start Index 


            addi $20, $2, 0   #stores our Global Index temporarily
            addi $2, $12, 0      #start global index off from the beginning
            addi $22, $0, 0

StartBegin:  addi $23, $0, 0
             addi $24, $0, 0






                    #END METHOD BY REASSIGNING $2 BACK TO GLOBAL INDEX AND $12 BACK TO START INDEX


  

                      #this method takes in Temp Index and returns the number of UnopenedCells and FlaggedCells 
            
Neighbor:   div $2, $8 #Returns Mod and divide
            mflo $7    #returns the Row number
            mfhi $9    #returns the Column number
            addi $9, $9, 1

            #Check if it is an edge and give different commands depending on the edge. Use $7 and $9 for edge dedection 



                addi $10, $0, -1 #Gets our low boundry condition (-1)

                #Instantiation
                addi $7, $7, -2
                addi $11, $0, -1  #counts row iters
                addi $14, $0, 2   #ending point, stops when 3 iters are reached

RowLoop:        addi $7, $7, 1
                beq $11, $14, DoneRowLoop  #check if row in bound
                addi $11, $11, 1
                beq $7, $10, RowLoop
                beq $7, $8, DoneRowLoop

                

                addi $13, $0, -1 #counts Col iters 
                addi $9, $9, -3

                #check if column in bound 
ColLoop:        beq $13, $14, RowLoop
                addi $13, $13, 1
                addi $9, $9, 1 
                beq $9, $10, ColLoop
                beq $9, $8, RowLoop

                #Check if we are on the index of the global box 
                #I want it to continue if $13 == 1 and $11 == 1

                andi $17, $13, 1
                andi $18, $11, 1
                and $18, $18, $17
                bne $18, $0, ColLoop

                ##DO LOGIC FOR LOADING WORD ROW $7  AND COLUMN $9    TO GET INDEX: ($7*8 + $9) 
                mult $7, $8
                mflo $2
                add $2, $2, $9
                mult $5, $2
                mflo $6

                ####DO LOGIC FOR OPENING/FLAGGING
                slt $25, $3, $0
                beq $25, $0, Open



                lw $6, location($6)
                beq $6, $21, IncreaseUnopen
                beq $6, $10, IncreaseFlag
                j ColLoop

Open:           swi 568
                sw $4, location($6)
                ###CHECK IF $11 == 2 AND $13 == 2
                    ##IF TRUE: 
                j ColLoop


IncreaseUnopen: addi $23, $23, 1
                ###CHECK IF $11 == 2 AND $13 == 2 
                and $17, $13, $11
                andi $18, $17, 10
                beq $26, $18, Check
                j ColLoop


IncreaseFlag:   addi $24, $24, 1
                and $17, $13, $11
                andi $18, $17, 10
                beq $26, $18, Check
                j ColLoop


Check:          sub $6, $23, $24    #NumOfUnopened - NumOfFlagged = $6
                beq $6, $4, FlagAll
                beq $4, $24, CheckUnopened 
                j DoneRowLoop


CheckUnopened:  beq $23, $0, ColLoop
                j OpenAll



                #These methods must 
OpenAll:        addi $3, $0, 0
                j ACT

FlagAll:        addi $3, $0, 1
                j ACT



                #This method must Go around the neighbors and swi them all and store their values into memory
                #Must end with setting $2 to the Global Start $12 : add $2, $12, $0
ACT:            addi $2, $12, 0
                j Neighbor




      #Must increase the local index by one and call the Neighbor method all over again
      #But if the local index == the Global Index + 1, then go back to guessing from Global Index 
DoneRowLoop:  beq $22, $20, Guess
              addi $22, $22, 1
              addi $2, $22, 0
              jr $31


Guess:          addi $25, $0, 0     #TODO




GuessEnable:  addi $3, $0, -1  


              jr $31
              