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
            j CheckIf


            #This method is a for loop, it starts from the Global Start Index and interates through it until it reaches the Global Index, in which it stops 
            #Throws each index to CheckIf to see if it able to be Opened of Flagged
            #If anything is opened or flagged, then you must start again from the Global Start Index 
StartFromBeginning:  addi $20, $2, $0   #stores our Global Index temporarily
                     addi $2, $12, 0      #start global index off from the beginning and CheckIf




                    #END METHOD BY REASSIGNING $2 BACK TO GLOBAL INDEX AND $12 BACK TO START INDEX


  

                      #this method takes in Temp Index and returns the number of UnopenedCells and FlaggedCells 
            div $2, $8 #Returns Mod and divide
Neighbor:   mflo $7    #returns the Row number
            mfhi $9    #returns the Column number
            #Check if it is an edge and give different commands depending on the edge. Use $7 and $9 for edge dedection 

            #Loop around it and pull out values from the memory accordingly and keep count of UnopenedCells and FlaggedCells 
            addi $10, $2, 0
            addi $11, $0, 0



      #REGULAR CELLS NON-EDGE
            #I want this to loop around the cell we give it. We give it $13, it must go around $13 starting from the top and ending at the bottom
            addi $14, $0, 0  #counter for Loops
LoopMemTop:      addi $10, $10, -9 #starts from the top Left
                 mult $5, $10
                 mflo $6
                 lw $11, location($6)

                #Check $11 is storing any Mines/Flags or Unopened and increase UnopenedCells and FlaggedCells accordingly 
                #(row * x ) + (col * y) = Index  ; x starts from $7 -1 and ends at $7+1, and y starts from $8 -1 and ends $8+1, and the col should be called inside of row

                 addi $10, $10, 1 #Top center
                 mult $5, $10
                 mflo $6
                 lw $11, location($6)



                 addi $10, $10,1 #Top Right
                 mult $5, $10
                 mflo $6
                 lw $11, location($6)




            #Calls another function Neighbor, that would get an Index, and return the number of UnopenedCells and FlaggedCells
            #This method takes those results along with the NumOnBox and returns a value if it possible to open or flag any cell
CheckIf: 


            




GuessEnable:  addi $3, $0, -1  


              