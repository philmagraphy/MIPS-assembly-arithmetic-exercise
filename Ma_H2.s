# Program by Phillip Ma
# Last modified: 6/23/18
#
# Program Name: MIPS HW Program 2
# This program stores 10 elements of an array from the user, calculates the average value, and then displays every 2nd element starting from the last inputted value.
#
# Pseudocode:
# int array[10] = {};
# int sum = 0;
# int count = 0;
# cout << "Enter 10 integers:";
# for (int i = 0; i < 10; i++) cin >> array[i];
# for( ; count<10; count++) sum += int[count];
# sum /= 10.0;
# cout << "The integer average is: " << sum << endl;
# for( ; count>0; count-=2) cout << int[count] << endl;
# return 0;

	.data
array: 	.space 40 # 10 element integer array
prompt1: .asciiz "Please enter an integer: "
prompt2: .asciiz "\nThe integer average is: "
newLine: .asciiz "\n"

	.text
	# Load prompt and initialize variables.
main:	la $a0, prompt1 # load integer prompt
	la $s0, array # s0 = array address
	li $t0, 0 # t0 = count = 0
	li $t1, 0 # t1 = sum = 0
	
	# Ask and read integers from user and add to sum, loop 10 times.
inloop: beq $t0, 40, avg # once looped 10 times, jump to avg
	li $v0, 4 # print integer prompt
	syscall
	li $v0, 5 # read user input
	syscall
	move $t4, $v0 # move input value to $t4
	sw $t4, 0($s0) # store input integer to array[count]
	addi $s0, $s0, 4 # update array[count]
	addi $t0, $t0, 4 # update count
	add $t1, $t1, $t4 # add input value to sum
	j inloop

	# Calculate and display average.
avg:	la $a0, prompt2 # load average message
	li $v0, 4 # print average message
	syscall
	li $t2, 10 # $t2 = 10 for calculating average
	div $t1, $t2 # sum / 10
	mflo $t3 # $t3 = sum / 10 = average
	move $a0, $t3
	li $v0, 1 # print average
	syscall
	la $a0, newLine # start a new line to list elements
	li $v0, 4
	syscall
	
	# Display every 2nd element starting from last inputted value.
oloop:	beq $t0, 0, done # count down to 0 from 40
	lw $a0, -4($s0) # load last element address
	li $v0, 1 # print element value
	syscall
	la $a0, newLine # start a new line
	li $v0, 4
	syscall
	addi $s0, $s0, -8 # skip to address of 3rd element from last
	addi $t0, $t0, -8 # count two instances down to 0
	j oloop

	# End program
done:	li $v0, 10
	syscall
