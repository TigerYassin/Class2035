#     Minesweeper
#
#  Your Name:	Yassin Alsahlani 
#  Date: 10/12/2018
.data

# your data allocation/initialization goes here

location: .word 9,9,9,9,9,9,9,9,9,9,9,9,9,,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9

.text
MineSweep: swi   567	   	   # Bury mines (returns # buried in $1)
  
#REGISTERS USED:
#1 - Number of bombs on Grid
#2 - Global Index
#12 - Temp index in CheckIf/Start Index
#3 - Guess/Open/Flag Options
#4 - NumOnBox -1 for mine
#5 - Index mulitplier to get proper index ( REMOVE SOON )
#6 - Proper Index after Multiplication ( REMOVE SOON )
#7 - Row number
#8 - Dividing factor of 8
#9 - Column number

#13 - UnopenedCells -Returns count
#14 - FlaggedCells -Returns count


#20 - Stores the Global Index temporarily 



            addi $2, $0, -1   #must reassign Global Index inorder to Open and Flag
            addi $3, $0, -1    
            addi $12, $0, 0
            addi $5, $0, 4
            addi $8, $0, 8

main:       addi $2, $2, 1 
            addi $3, $0, -1    
            swi 568
            #Put num into mem
            mult $2, $5
            mflo $6
            sw $4, location($6)
            j StartFromBeginning 


            #This method is a for loop, it starts from the Global Start Index and interates through it until it reaches the Global Index, in which it stops 
            #Throws each index to CheckIf to see if it able to be Opened of Flagged
            #If anything is opened or flagged, then you must start again from the Global Start Index 
StartFromBeginning:  addi $20, $2, 0   #stores our Global Index temporarily
                     addi $2, $12, 0      #start global index off from the beginning and CheckIf




                    #END METHOD BY REASSIGNING $2 BACK TO GLOBAL INDEX AND $12 BACK TO START INDEX


  

                      #this method takes in Temp Index and returns the number of UnopenedCells and FlaggedCells 
            div $2, $8 #Returns Mod and divide
Neighbor:   mflo $7    #returns the Row number
            mfhi $9    #returns the Column number
            addi $9, $9, 1

            #Check if it is an edge and give different commands depending on the edge. Use $7 and $9 for edge dedection 



                addi $10, $0, -1 #Gets our low boundry condition (-1)
                addi $15, $0, 8 #Gets our upper boundry condition (8)

                #Instantiation
                addi $7, $7, -2
                addi $11, $0, -1  #counts row iters
                addi $14, $0, 2   #ending point, stops when 3 iters are reached

RowLoop:        addi $7, $7, 1
                beq $11, $14, DoneRowLoop  #check if row in bound
                addi $11, $11, 1
                beq $7, $10, RowLoop
                beq $7, $15, DoneRowLoop

                

                addi $13, $0, -1 #counts Col iters 
                addi $9, $9, -3

                #check if column in bound 
ColLoop:        beq $13, $14, RowLoop
                addi $13, $13, 1
                addi $9, $9, 1 
                beq $9, $10, ColLoop
                beq $9, $15, RowLoop

                #Check if we are on the index of the global box 
                #I want it to continue if $13 == 1 and $11 == 1

                andi $17, $13, 1
                andi $18, $11, 1
                and $18, $18, $17
                bne $18, $0, ColLoop

                ##DO LOGIC FOR LOADING WORD ROW $7  AND COLUMN $9    TO GET INDEX: ($7*8 + $9) 
                mult $7, $8
                mflo $6
                add $2, $6, $9
                mult $8, $2
                mflo $6
                lw $21, location($6)
                swi 568
                j ColLoop



DoneRowLoop: jr $31


            #Calls another function Neighbor, that would get an Index, and return the number of UnopenedCells and FlaggedCells
            #This method takes those results along with the NumOnBox and returns a value if it possible to open or flag any cell
#CheckIf:    


            




GuessEnable:  addi $3, $0, -1  


              