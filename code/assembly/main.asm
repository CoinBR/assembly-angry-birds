.text 



main:

iloop:
	jal scenario00
	jal interval

	jal scenario01
	jal interval
#
#	jal scenario02
#	jal interval
#
#	jal scenario03
#	jal interval
#
#	jal scenario04
#	jal interval
#
#	jal scenario05
#	jal interval
#
#	jal scenario06
#	jal interval
#
#	jal scenario07
#	jal interval
#
#	jal scenario08
#	jal interval
#
#	jal scenario09
#	jal interval
#
#	jal scenario10
#	jal interval
#
	j iloop 


interval:
	addi $v0, $0, 32 # Sleep Code
	addi $a0, $0, 3000  # ms 
	syscall
	jr $ra
