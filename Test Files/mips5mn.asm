#Jonathan Young
#MIPS Assignment #5
#Section #1

##################################################################################################
#This program generates a game board, using the pre-programmed arrays below.
#It then proceeds asking the user from which position they would like to start from.
#The idea is to get to the zero on the far right side of the array. If a position
#gets you to the zero on the game board, it is a winning position and the program
#will display the results win or lose to the user and allow them to try a different
#position to start from. Should the user fail to enter a valid number 3 times,
#the program will display a sorry too many errors message and terminate.

#Note: The program will check both the left and right side, of each position to
#determine which path will win. It does not however, print the winning path as
#a game board could have many winning paths.

#The program uses the following functions:
#	* showGame - This function displays a nicely formatted game board with
#	  dashes, spaces, and bars. The numbers are also displayed in between the bars.

#	* getStartPosition - This asks the user for a starting position on the game board
#	  and verifies that the number is valid, between 0 and length of board - 1. If the
#	  value is valid, then it is returned. Otherwise, the user is given 3 attempts to
#	  get a correct starting position, otherwise a "too many errors" message is displayed.

#	* canWin - Takes the user entered starting position and progresses through the game
#	  board left and right from the number +/- the board[position]. It returns true if
#	  the user entered starting position reaches the 0 on the right most end of the game board.
#	  This function is done recursively and also places a -1 inside each position read to prevent
#	  a miss read. The original array numbers are restored, after each solution is determined.
#	  Note: The two values from the left and right movement are or-ed together, thus showing if 1 
#     solution wins.

#	* displayResult - Displays the user's result from their starting position. That is, if they
#	  won or lost and it also displays the game board back to the user.

#	* doAnother - Asks the user if they would like do have another try at the same game board,
#	  otherwise the program continues onto the next game board.

##################################################################################################
#  data segment

.data

# -----
#  Constants

TRUE = 1
FALSE = 0
ERROR_LIMIT = 3

# -----
#  Variables for main

hdr:		.ascii	"\nMIPS Assignment #5\n"
		.asciiz	"Row Puzzle Solution Program\n\n"

# y n y y n

game1:		.word	3, 6, 4, 1, 3, 4, 2, 5, 3, 0
game1Len:	.word	10
game1Start:	.word	0

game2:		.word	3, 1, 2, 3, 0
game2Len:	.word	5
game2Start:	.word	0

game3:		.word	3, 7, 2, 4, 3, 4, 3, 2, 7, 3, 3, 5, 2, 0
game3Len:	.word	14
game3Start:	.word	0

game4:		.word	3, 7, 2, 4, 3, 4, 3, 2, 4, 3, 2, 5, 2, 1, 1, 0
game4Len:	.word	16
game4Start:	.word	0

game5:		.word	3, 6, 2, 4, 3, 4, 3, 2, 4, 3, 2, 5, 3, 4, 5, 0
game5Len:	.word	16
game5Start:	.word	0

endMsg:		.ascii	"\nYou have reached recursive nirvana.\n"
		.asciiz	"Program Terminated.\n"

# -----
#  Local variables for prtNewline function.

newLine:	.asciiz	"\n"

# -----
#  Local variables for showGame() function.

stars:		.ascii	"\n**********************************************"
		.asciiz	"****************************\n"
gameBrd:	.asciiz	"Game Board: "
dashs:		.asciiz	"----"
xtra:		.asciiz	"-"
bar:		.asciiz	" | "
offset0:	.asciiz	"   "
offset1:	.asciiz	"  "

# -----
#  Local variables for getStartPosition() function.

strtMsg1:	.asciiz	"Enter a start position (0-"
strtMsg2:	.asciiz	"): "

errValue:	.ascii	"\nError, invalid start position. "
		.asciiz	"Please re-enter.\n"
errLimit:	.asciiz	"\nSorry, too many errors.\n\n"

# -----
#  Local variables for displayResult() function.

frmMsg:		.asciiz	"Starting from position "
yesMsg:		.asciiz	" you can win!  :-)\n"
noMsg:		.asciiz	" you can not win.  :-(\n"

# -----
#  Local variables for doAnother() function.

sPmt:		.asciiz	"Try another start position (y/n)? "
ansErr:		.asciiz	"Error, must answer with (y/n).\n"

ans:		.space	3

###########################################################################
#  text/code segment

.text
.globl main
.ent main
main:

# -----
#  Display program header.

	la	$a0, hdr
	li	$v0, 4
	syscall					# print header

# -----
#  Basic process:
#	show game board
#	request starting position
#		if too many errors, exit
#	determine if winnable
#	show results

# -----
#  Do game1

	li	$s0, 1				# game counter

	la	$a0, game1
	lw	$a1, game1Len
	move	$a2, $s0
	jal	showGame

tryGame1Again:
	la	$a0, game1Start
	lw	$a1, game1Len
	jal	getStartPosition
	beq	$v0, FALSE, gameOver

	lw	$a0, game1Start
	la	$a1, game1
	lw	$a2, game1Len
	jal	canWin

	lw	$a0, game1Start
	move	$a1, $v0
	la	$a2, game1
	lw	$a3, game1Len
	sub	$sp, $sp, 4
	sw	$s0, ($sp)
	jal	displayResult
	add	$sp, $sp, 4

	jal	doAnother
	beq	$v0, TRUE, tryGame1Again

# -----
#  Do game2

	add	$s0, $s0, 1

	la	$a0, game2
	lw	$a1, game2Len
	move	$a2, $s0
	jal	showGame

tryGame2Again:
	la	$a0, game2Start
	lw	$a1, game2Len
	jal	getStartPosition
	beq	$v0, FALSE, gameOver

	lw	$a0, game2Start
	la	$a1, game2
	lw	$a2, game2Len
	jal	canWin

	lw	$a0, game2Start
	move	$a1, $v0
	la	$a2, game2
	lw	$a3, game2Len
	sub	$sp, $sp, 4
	sw	$s0, ($sp)
	jal	displayResult
	add	$sp, $sp, 4

	jal	doAnother
	beq	$v0, TRUE, tryGame2Again

# -----
#  Do game3

	add	$s0, $s0, 1

	la	$a0, game3
	lw	$a1, game3Len
	move	$a2, $s0
	jal	showGame

tryGame3Again:
	la	$a0, game3Start
	lw	$a1, game3Len
	jal	getStartPosition
	beq	$v0, FALSE, gameOver

	lw	$a0, game3Start
	la	$a1, game3
	lw	$a2, game3Len
	jal	canWin

	lw	$a0, game3Start
	move	$a1, $v0
	la	$a2, game3
	lw	$a3, game3Len
	sub	$sp, $sp, 4
	sw	$s0, ($sp)
	jal	displayResult
	add	$sp, $sp, 4

	jal	doAnother
	beq	$v0, TRUE, tryGame3Again

# -----
#  Do game4

	add	$s0, $s0, 1

	la	$a0, game4
	lw	$a1, game4Len
	move	$a2, $s0
	jal	showGame

tryGame4Again:
	la	$a0, game4Start
	lw	$a1, game4Len
	jal	getStartPosition
	beq	$v0, FALSE, gameOver

	lw	$a0, game4Start
	la	$a1, game4
	lw	$a2, game4Len
	jal	canWin

	lw	$a0, game4Start
	move	$a1, $v0
	la	$a2, game4
	lw	$a3, game4Len
	sub	$sp, $sp, 4
	sw	$s0, ($sp)
	jal	displayResult
	add	$sp, $sp, 4

	jal	doAnother
	beq	$v0, TRUE, tryGame4Again

# -----
#  Do game5

	add	$s0, $s0, 1

	la	$a0, game5
	lw	$a1, game5Len
	move	$a2, $s0
	jal	showGame

tryGame5Again:
	la	$a0, game5Start
	lw	$a1, game5Len
	jal	getStartPosition
	beq	$v0, FALSE, gameOver

	lw	$a0, game5Start
	la	$a1, game5
	lw	$a2, game5Len
	jal	canWin

	lw	$a0, game5Start
	move	$a1, $v0
	la	$a2, game5
	lw	$a3, game5Len
	sub	$sp, $sp, 4
	sw	$s0, ($sp)
	jal	displayResult
	add	$sp, $sp, 4

	jal	doAnother
	beq	$v0, TRUE, tryGame5Again

# -----
#  Done, show message and terminate program.

gameOver:
	li	$v0, 4
	la	$a0, endMsg
	syscall

	li	$v0, 10
	syscall					# all done...
.end main

# =========================================================================
#  Very simple procedure to print a new line.
#	Note, this routine is optional.

.globl	prtNewline
.ent	prtNewline
prtNewline:
	la	$a0, newLine
	li	$v0, 4
	syscall

	jr	$ra
.end	prtNewline

# =========================================================================
#  Procedure to print game board (formatted).

# -----
#    Arguments:
#	$a0 - game board, address
#	$a1 - length, value
#	$a2 - game number, value

#    Returns:
#	n/a

.globl	showGame
.ent	showGame
showGame:
	subu $sp, $sp, 12	 	#Preserve Registers.
	sw $s0, ($sp)
	sw $fp, 4($sp)
	sw $ra, 8($sp)
	add $fp, $sp, 12 		#Set frame pointer.

	move $s0,$a0
#	----
#	Prints header information per game.
	la	$a0, stars
	li	$v0, 4
	syscall					#Prints the "***"" message.
	la	$a0, gameBrd
	li	$v0, 4
	syscall					#Prints the "Game Board: " message.
	move	$a0, $a2
	li	$v0, 1
	syscall					#Prints the game board value.
	la	$a0, newLine
	li	$v0, 4
	syscall					#Prints a new line.
	la $a0,newLine
	li $v0,4
	syscall
	la	$a0, offset0
	li	$v0, 4
	syscall					#Prints an offset for formatting.

	move $t0,$a1 			#Prints dashes.
	li $t7,1 				#A flag to see if first set has been printed to print last set.

Print_Dashs:
	la	$a0, dashs
	li	$v0, 4
	syscall					#Print 4 dashes.
	sub $t0,$t0,1 			#Decrement counter.
	bnez $t0, Print_Dashs
	la $a0,xtra 			#Insert extra dash to cover the bar.
	li	$v0, 4
	syscall
	bnez $t7, Read_Board 	#Prints the game board, provided it isn't the end of the array.
	j Fini

Read_Board:
	la	$a0, newLine
	li	$v0, 4
	syscall					#Prints a new line.
	la	$a0, offset1
	li	$v0, 4
	syscall					#Prints an offset for formatting.
	la	$a0, bar
	li	$v0, 4
	syscall					#Prints a bar message " | ".

	li $t0,0 				#Counter for the # of arguments to print.
	move $t1,$s0

Print_Array:
	lw $a0,($t1)
	li	$v0, 1
	syscall					#Prints a number from the game board.
	la	$a0, bar
	li	$v0, 4
	syscall					#Prints a bar message " | ".
	addu $t1,$t1,4			#Increments the address to the next spot in the array.
	add	$t0,$t0,1 			#Decrements the counter, to keep track of characters printed.
	blt $t0,$a1,Print_Array
	la	$a0, newLine
	li	$v0, 4
	syscall					#Prints a new line.
	la	$a0, offset0
	li	$v0, 4
	syscall					#Prints an offset for formatting.
	li $t7,0 				#Update flag to print second set of dashes.
	move $t0,$a1
	j Print_Dashs

Fini:
	la	$a0, newLine
	li	$v0, 4
	syscall					#Prints a new line.

	lw $s0, ($sp)
	lw $fp, 4($sp)
	lw $ra, 8($sp)
	add $sp, $sp, 12 		#Set frame pointer.

	jr	$ra
.end	showGame

# =========================================================================
#  Prompt for, read, and check starting position.
#	must be >= 0 and < length

# -----
#    Arguments:
#	$a0 - startPosition, address
#	$a1 - length, value

#    Returns:
#	startPosition via reference
#	$v0, status (TRUE or FALSE)

.globl	getStartPosition
.ent	getStartPosition
getStartPosition:

	subu $sp,$sp,12 		#Preserve Registers.
	sw $s0, ($sp)
	sw $fp, 4($sp)
	sw $ra, 8($sp)
	add $fp, $sp, 12 		#Set frame pointer.

	move $s0,$a0 			#Save the address of startPosition.
	li $t0,0 				#Error Counter.

Get_Pos:
	la $a0,newLine
	li $v0,4
	syscall 				#Prints a new line.
	la $a0,strtMsg1 		#Prints the "Enter a start position (0-" message.
	li $v0,4
	syscall
	sub $t1,$a1,2
	move $a0,$t1
	li $v0,1
	syscall 				#Prints the length-2 number.
	la $a0,strtMsg2
	la $v0,4
	syscall  				#Prints the "): " message.
	li $v0,5 				#Grabs integer value from the command line.
	syscall

	bge $v0,$zero,IS_Valid
	j Error_Pos

IS_Valid:
	move $t1,$a1
	sub $t1,$t1,1
	bge $v0,$t1,Error_Pos  	#Checks if the number is >= length-1, if so error.
	sw $v0, ($s0)
	li $v0,TRUE 			#Returns true if the number is valid.
	j Pos_Done

Error_Pos:
	la $a0,newLine
	li $v0,4
	syscall 				#Prints a new line.
	la $a0,errValue
	li $v0,4
	syscall 				#Prints the "\nError, invalid start position. Please re-enter.\n" message.
	add $t0,$t0,1 			#Increments the error counter.
	bne $t0,ERROR_LIMIT,Get_Pos

Error_Max:
	la $a0,newLine
	li $v0,4
	syscall 				#Prints a new line.
	la $a0,errLimit
	li $v0,4
	syscall 				#Prints the "\nSorry, too many errors.\n\n" message.
	li $v0,FALSE 			#Returns false, if number entered isn't valid.

Pos_Done:

	lw $s0, ($sp)
	lw $fp, 4($sp)
	lw $ra, 8($sp)
	add $sp, $sp, 12 		#Set frame pointer.

	jr	$ra
.end	getStartPosition

#####################################################################
#  Procedure to recursively determine if the row board game
#  is winnable.

# -----
#  Arguments:
#	$a0 - startPosition, value
#	$a1 - game board, address
#	$a2 - length, value

#  Returns:
#	$v0 - TRUE/FALSE

.globl	canWin
.ent	canWin
canWin:

	subu $sp,$sp,20 		#Preserve Registers.
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3,	16($sp)

	blt $a0,$zero,Win_False	#Check if the position is less than 0, if so error.
	bge $a0,$a2,Win_False	#Check if board position is greater than or equal to the length.

	move $t1,$a1
	mul $t0,$a0,4
	add $t1,$t1,$t0
	lw $t2,($t1)
	move $s1, $t2 			#Saves the original value of the array # being replaced.

	beq $s1,$zero,Win_True	#Checks if the number from the array is equal to 0, if so then return True.
	blt $s1,$zero,Win_False #Checks if the number from the array is less than 0, means we already read that value thus must be false.

	li $t2,-1
	sw $t2, ($t1) 			#Place a -1 into the array, replacing the original number to show we read this already.

#This area of the code does the canWin(pos+brd[pos])∨ canWin(pos−brd[pos]).
#The v is the logical or operation. Each of these calls is done recursively.
#A negative one is placed into the array, as it is accessed to show that value has been read.

	move $s3,$a0			 #Stores the current position from the user, plus from board calls.
	move $a0,$s3
	add $a0,$a0,$s1 		 #Does the position+board[position] step and calls the function again.
	jal canWin

	sub $a0,$a0,$s1 		 #This portion of code restores the original array, 1 number at a time as it goes backwards.
	move $t1,$a1 			 #This allows the function to check if going left will result in a win.
	mul $t0,$a0,4
	add $t1,$t1,$t0
	sw $s1,($t1)			 #Returns the original value into the array.

	move $a0,$s3 			 #Restores the value of $s3 into $a0, which was the original user entered position.
	sub $a0,$a0,$s1 		 #Dooes the position-board[position] step and calls the function again.
	move $s3,$v0 			 #Save the canwin(pos+board[pos]) value.
	jal canWin

	add $a0,$a0,$s1 		 #This portion of code restores the original array, 1 number at a time.
	move $t1,$a1 			 
	mul $t0,$a0,4
	add $t1,$t1,$t0
	sw $s1,($t1)		     #Returns the original value into the array.

	or $v0,$s3,$v0 			 #Performs the logical or of the two values.
	j canWin_Done 			 #Once the function finishes the or operation, it returns the correct value to main.
							 #That is true, if 1, or false if 0. This performs a jump, to prevent the correct value from being overwritten.
Win_True:
	li $v0,TRUE
	j canWin_Done

Win_False:
	li $v0,FALSE

canWin_Done:

	lw $ra, ($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16 ($sp)
	add $sp, $sp, 20 		 #Set frame pointer.
	jr	$ra
.end canWin

# =========================================================================
#  Function to display formatted final result.

# -----
#    Arguments:
#	$a0 - startPosition, address
#	$a1 - game winnable (TRUE/FALSE)
#	$a2 - game board, address
#	$a3 - length, value
#	($fp) - game number

#    Returns:
#	n/a

.globl	displayResult
.ent	displayResult
displayResult:

	subu $sp,$sp,20 		#Preserve Registers.
	sw $s0, ($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $fp, 12($sp)
	sw $ra, 16($sp)
	add $fp, $sp, 20 		#Set frame pointer.

	move $s0,$a0 			#Save the address of the startPosition.
	move $s1,$a1 			#Saves game is winnable value.
	move $s2,$a2 			#Saves the game board address.

	move $a0, $s2 			#Passes the game board address.
	move $a1, $a3 			#Passes the length of the game board.
	lw	$a2, ($fp) 			#Passes the game number we are on.
	jal	showGame

	la $a0,newLine
	li $v0,4
	syscall 				#Prints a new line.
	la $a0,frmMsg 			#Prints the "Starting from position " message.
	li $v0,4
	syscall
	move $a0, $s0 			#Addresss of the start position, # to be printed.
	li $v0,1
	syscall
	beq $s1,FALSE, LoseMsg  #Calls the lose function, if the game wasn't winnable.

WinMsg:
	la $a0,yesMsg
	li $v0,4
	syscall 				#Prints the " you can win!  :-)\n" message.
	j Result_Fini

LoseMsg:
	la $a0, noMsg
	li $v0,4
	syscall 				#Prints the " you can not win.  :-(\n" message.

Result_Fini:

	lw $s0, ($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $fp, 12($sp)
	lw $ra, 16($sp)
	add $sp, $sp, 20 		#Set frame pointer.

	jr	$ra
.end	displayResult

# =========================================================================
#  Function to ask user if they want to do another start position.
#  Basic flow:
#	prompt user
#	read user answer (as character)
#		if y/Y -> return TRUE
#		if n/N -> return FALSE
#	otherwise, display error and re-prompt
#  Note, uses read string syscall.
# -----
#  Arguments:
#	none
#  Returns:
#	$v0 - TRUE/FALSE

.globl	doAnother
.ent	doAnother
doAnother:

Read:
	li $v0,4 				#Prints a new line.
	la $a0, newLine
	syscall

	la	$a0, sPmt
	li	$v0, 4
	syscall					#Prints the "Try another start position (y/n)?" message.

	la $a0 ans
	la $a1, 3
	li $v0, 8
	syscall 				#Stores the user input from the command line.

	la $t0,ans
	lb $t1,($t0)
	beq $t1,0x6e, False 	#Checks for "n" on the command line.
	beq	$t1,0x4e, False		#Checks for "N" on the command line.
	beq $t1,0x79, True 		#Checks for "y" on the command line.
	beq $t1,0x59, True 		#Checks for "Y" on the command line.
	j Other

True:
	li $v0,4 				#Prints a new line.
	la $a0, newLine
	syscall
	li $v0, TRUE
	j Done

False:
	li $v0, FALSE
	j Done

Other:
	la $a0, ansErr 			#Prints the "Error, must answer with (y/n)." message.
	li $v0,4
	syscall
	j Read

Done:

	jr	$ra
.end	doAnother

#####################################################################