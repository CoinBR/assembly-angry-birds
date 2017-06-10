.text 



main:

iloop:
	jal scenario00
	jal interval

	jal scenario01
	jal char01
	jal interval

	jal scenario02
	jal charw02
	jal interval

	jal scenario03
	jal charw03
	jal interval

	jal scenario04
	jal charw04
	jal interval

	jal scenario05
	jal charw05
	jal interval

	jal scenario06
	jal charw06
	jal interval

	jal scenario07
	jal charw07
	jal interval

	jal scenario08
	jal charw08
	jal interval

	jal scenario09
	jal charw09
	jal interval

	jal scenario10
	jal charw10
	jal interval


	jal scenario11
	jal charw11
	jal interval

	j main 


interval:
	addi $v0, $0, 32 # Sleep Code
	addi $a0, $0, 1200  # ms 
	syscall
	jr $ra
