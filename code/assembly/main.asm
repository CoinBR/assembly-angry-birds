.text 



main:
	jal scenario00 			# Display first frame

	# Prepare to Shoot
	lui  $11, 0xffff 		# Mem Address that detects if a key is pressed
	lw   $10, 4($11)		# Reset Mem $11 (Key Press Checker) to 0
	addi $8, $0, 100		# BASE time unit (in ms)	
	addi $12, $0, 0			# interactions/power counter
	addi $13, $0, 7			# Exact interations # required to hit a shot

try_and_shoot:
	lw $10, 0($11)			# Copy Mem $11 (key press checker) to register $10
	beq $10, $0, try_and_shoot 	# while no input is given, keep checking

	lw $10, 4($11)			# Reset Mem $11 (Key Press Checker) to 0
measure_power:
	jal interval
	addi $12, $12, 1		# increment strength
	lw $10, 0($11)			# Copy Mem $11 (key press checker) to register $10
	beq $10, $0, measure_power 	# player hasn't yet pressed a key for a second time


	# play animation according to shot power	
	addi $8, $0, 737		# Time to display each animation frame
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

	jal loosemsg 
	jal press_key_to_continue
	j main


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

	jal winmsg
	jal press_key_to_continue
	j main

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

	jal loosemsg 
	jal press_key_to_continue
	j main


interval:
	addi $v0, $0, 32 # Sleep Code
	add $a0, $0, $8  # ms 
	syscall
	jr $ra


press_key_to_continue:
	lw   $10, 4($11)		# Reset Mem $11 (Key Press Checker) to 0
pktc_loop:
	lw $10, 0($11)			# Copy Mem $11 (key press checker) to register $10
	beq $10, $0, pktc_loop 		# player hasn't pressed a key yet
	lw   $10, 4($11)		# Reset Mem $11 (Key Press Checker) to 0
	jr $ra
