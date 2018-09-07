# HW1-3
# Student Name:Yassin Alsahlani
# Date: 9/6/2018
#
# This program computes the index at which the maximum value occurs in a
# set of 10 confidence values and stores it at the memory location labeled ClassID.
# If there are two or more indices that have equal maximum values, the LARGER 
# index is chosen.
	

.data
# DO NOT change the following three labels (you may change the initial values):
ConfidenceValues:     .word 1, 70, 0, 0, 21, 2, 3, 0, 3, 0
ClassID: .alloc 1
	
.text
                # write your code here...

	addi $1, $0,ConfidenceValues	#getting the memory location of the array
	addi $3, $0, 0		#initializing the counter
	addi $4, $0, 0		#index with highest val
	addi $5, $0, 10		#terminate program when 10 is reached 
	addi $7, $0, 0		#stores the value of the largest number

Loop:   lw $2, 0($1)		#Val at current index
	addi $8, $2, 1		#temp value 
	slt $6, $7, $8		#checks if $7 < $8, where $8 = $2 + 1
	beq $6, $0, JumpO	#if the value is greater, then jump to JumpO
	addi $4, $3, 0		#$4 nex index of largest number
	add $7, $2, $0		#$7 new largest number

JumpO:	addi $1, $1, 4		#moving to next index address
	addi $3, $3, 1		#interate
	beq $3, $5, Skip
        j Loop                  #loop
Skip:   sw $4, ClassID($0)
	jr    $31               # return to caller


