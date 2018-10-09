#     Minesweeper
#
#  Your Name:	
#  Date:
.data

# your data allocation/initialization goes here

.text
MineSweep: swi   567	   	   # Bury mines (returns # buried in $1)

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

           jr  $31  	  	   # return to OS
