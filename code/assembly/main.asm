.text 
main:
	lui  $11, 0xffff 		# Mem Address that detects if a key is pressed
	addi $15, $0, 0			# Credits not yet displayed (Must display only once)

	jal intro_bg_top		# Dynamic part, will be reprinted after each message
	jal intro_bg_bot		# Static part, will stay until the last msg
	

	jal story00
	jal press_key_to_continue

	jal intro_bg_top
	jal story01
	jal press_key_to_continue

	jal intro_bg_top
	jal story02
	jal press_key_to_continue

	jal intro_bg_top
	jal story03
	jal press_key_to_continue


	jal intro_bg_top
	jal story04
	jal press_key_to_continue

	jal intro_bg_top
	jal story05
	jal press_key_to_continue

	jal intro_bg_top
	jal story06
	jal press_key_to_continue

	jal intro_bg_top
	jal story07
	jal press_key_to_continue


	jal intro_bg_top
	jal instructions00
	jal press_key_to_continue

	jal intro_bg_top
	jal instructions01
	jal press_key_to_continue

	jal intro_bg_top
	jal instructions02
	jal press_key_to_continue

	jal intro_bg_top
	jal instructions03
	jal press_key_to_continue


game_start:
	jal scenario00 			# Display first frame

	# Prepare to Shoot
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

	j game_start
	

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
	j game_start


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

	# Makes sure credits are displayed only once
	beq $15, $0, credits
	j game_start

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
	j game_start


credits:
	addi $15, $0, 1			# Credits already displayed (Must display only once)

	jal credits_bg_top		# Dynamic part, will be reprinted after each message
	jal credits_bg_bot		# Static part, will stay until the last msg

	jal credits00 
	jal press_key_to_continue

	jal credits_bg_top
	jal credits01 
	jal press_key_to_continue

	jal credits_bg_top
	jal credits02 
	jal press_key_to_continue


	jal credits_bg_top
	jal credits03 
	jal press_key_to_continue


	jal credits_bg_top
	jal credits04 
	jal press_key_to_continue


	jal credits_bg_top
	jal credits05 
	jal press_key_to_continue


	jal credits_bg_top
	jal credits06 
	jal press_key_to_continue

	j game_start


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
