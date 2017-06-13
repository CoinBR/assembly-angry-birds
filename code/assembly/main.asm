.text 



main:
	jal scenario00 			# Display first frame

	# Prepare to Shoot
	lui  $11, 0xffff 		# Mem Address that detects if a key is pressed
	addi $8, $0, 100		# BASE time unit (in ms)	
	addi $12, $0, 0			# interactions/power counter
	addi $13, $0, 7			# Exact interations # required to hit a shot

try_and_shoot:
	lw $10, 0($11)			# Copy Mem $11 (key press checker) to register $10
	beq $10, $0, try_and_shoot 	# while no input is given, keep checking

measure_power:
	addi $12, $0, 1			# increment strength
	jal interval
	lw $10, 0($11)			# Copy Mem $11 (key press checker) to register $10
	bgtz $10, measure_power 	# player is yet pressing a key

	# play animation according to shot power	
	addi $8, $0, 900		# Time to display each animation frame
	addi $14, $0, 0			# power_already_tested = false
	jal do_measure_power

	j main
	

do_measure_power:
	slt $9, $13, $12      		# $12 (power) above $13 (threshold)?
	beq $9, 1, strongshot 		# $12 > $13    power >  threshold 
	beq $12, $13, hitshot  		# $12 == $13   power == threshold
	beq $13, $0, weakshot 		# $12 < $ 13   power <  threshold
		

weakshot:
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

	jr $ra 

hitshot:
	jal scenario01
	jal char01
	jal interval

	jal scenario02
	jal charm02
	jal interval

	jal scenario03
	jal charm03
	jal interval

	jal scenario04
	jal charm04
	jal interval

	jal scenario05
	jal charm05
	jal interval

	jal scenario06
	jal charm06
	jal interval

	jal scenario07
	jal charm07
	jal interval

	jal scenario08
	jal charm08
	jal interval

	jal scenario09
	jal charm09
	jal interval

	jal scenario10
	jal charm10
	jal interval


	jal scenario11
	jal charm11
	jal interval

	jr $ra 

strongshot:
	jal scenario01
	jal char01
	jal interval

	jal scenario02
	jal chars02
	jal interval

	jal scenario03
	jal chars03
	jal interval

	jal scenario04
	jal chars04
	jal interval

	jal scenario05
	jal chars05
	jal interval

	jal scenario06
	jal chars06
	jal interval

	jal scenario07
	jal chars07
	jal interval

	jal scenario08
	jal chars08
	jal interval

	jal scenario09
	jal chars09
	jal interval

	jal scenario10
	jal chars10
	jal interval


	jal scenario11
	jal chars11
	jal interval

	jr $ra 


interval:
	addi $v0, $0, 32 # Sleep Code
	add $a0, $0, $8  # ms 
	syscall
	jr $ra
