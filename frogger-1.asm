# CSC258H5S Winter 2022 Assembly Final Project
# University of Toronto, St. George
#
# Student: Zijia(Sonny) Chen, Student Number 1005983349
#
# Bitmap Display Configuration:
# - Unit width in pixels: 4
# - Unit height in pixels: 4
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#s
# - Milestone 5
# - Additional features
# - EASY(5)
# - Display the number of lives remaining
# - After final player death, display game over/retry screen. Restart the game if the¡°retry¡± option is chosen
# - Have objects in different rows move at different speeds
# - Add a third row in each of the water and road sections
# - Make the frog point in the direction that it¡¯s traveling
# - HARD(1)
# - Display the player¡¯s score at the top of the screen.

.data
	buffer: .space 262144 # avoid static data corruption
	
	#COLOUR
	displayAddress: .word 0x10008000
	white: .word  0xffffff
	black: .word 0
	yellow: .word  0x99ff33
	purple: .word  0x3333ff
	blue: .word  0x000066
	green: .word 0x009900
	deep_green: .word 0x006600
	red: .word 0xff0000
	checker_black: .word 0x010000
	
	#POSITION
	frog_x: .word 64
	frog_y: .word 117
	frog_dir: .word 0 #0 up, 1 down, 2 left, 3 right
	mark_1: .word 0
	mark_2: .word 0
	mark_3: .word 0
	mark1_x: .word 0
	mark1_y: .word 0
	mark2_x: .word 0
	mark2_y: .word 0
	mark3_x: .word 0
	mark3_y: .word 0
	
	car1_x: .word 0
	car1_y: .word 73
	car2_x: .word 60
	car2_y: .word 84
	car3_x: .word 40
	car3_y: .word 95
	log1_x: .word 0
	log1_y: .word 29
	log2_x: .word 60
	log2_y: .word 40
	log3_x: .word 40
	log3_y: .word 51
	
	#STAT
	num_lives: .word 3
	game_flag: .word 1 # 0 game at starting screen, 1 game is running
	max_y: .word 117
	score: .word 0
	
.text
main:
	lw $t0, displayAddress # $t0 stores the base address for display
	
refresh:
	
	jal check_key # check keyboard input
	
	lw $t1, game_flag
	beq $t1, 0 print_home
	j continue
	
		
		
	continue:
	lw $t1, mark_1
	bne $t1, 1, markcheck_linkto
	lw $t1, mark_2
	bne $t1, 1, markcheck_linkto
	lw $t1, mark_3
	bne $t1, 1, markcheck_linkto
	la $a0, game_flag
	li $a1, 0
	sw $a1, 0($a0)
	la $a0, mark_1
	li $a1, 0
	sw $a1, 0($a0)
	la $a0, mark_2
	li $a1, 0
	sw $a1, 0($a0)
	la $a0, mark_3
	li $a1, 0
	sw $a1, 0($a0)
	
	markcheck_linkto:
	jal check_status 
	lw $t1, blue # print water
	jal print_water 
	lw $t1 black # print road
	jal print_road
	lw $t1, purple # print safe zone
	jal print_safe 
	lw $t1, green # print grass
	jal print_grass  
	
	# print lives
	lw $t1, num_lives
	beq $t1, 3, draw3lives
	beq $t1, 2, draw2lives
	beq $t1, 1, draw1lives
	j continue2
	# draw hearts
	draw3lives:
	lw $a0, red
	lw $t7, displayAddress # start = base address
sw $a0, 60944($t7)
sw $a0, 60948($t7)
sw $a0, 60960($t7)
sw $a0, 60964($t7)
sw $a0, 61452($t7)
sw $a0, 61456($t7)
sw $a0, 61460($t7)
sw $a0, 61464($t7)
sw $a0, 61468($t7)
sw $a0, 61472($t7)
sw $a0, 61476($t7)
sw $a0, 61480($t7)
sw $a0, 61964($t7)
sw $a0, 61968($t7)
sw $a0, 61972($t7)
sw $a0, 61976($t7)
sw $a0, 61980($t7)
sw $a0, 61984($t7)
sw $a0, 61988($t7)
sw $a0, 61992($t7)
sw $a0, 62476($t7)
sw $a0, 62480($t7)
sw $a0, 62484($t7)
sw $a0, 62488($t7)
sw $a0, 62492($t7)
sw $a0, 62496($t7)
sw $a0, 62500($t7)
sw $a0, 62504($t7)
sw $a0, 62992($t7)
sw $a0, 62996($t7)
sw $a0, 63000($t7)
sw $a0, 63004($t7)
sw $a0, 63008($t7)
sw $a0, 63012($t7)
sw $a0, 63508($t7)
sw $a0, 63512($t7)
sw $a0, 63516($t7)
sw $a0, 63520($t7)
sw $a0, 64024($t7)
sw $a0, 64028($t7)

sw $a0, 60984($t7)
sw $a0, 60988($t7)
sw $a0, 61000($t7)
sw $a0, 61004($t7)
sw $a0, 61492($t7)
sw $a0, 61496($t7)
sw $a0, 61500($t7)
sw $a0, 61504($t7)
sw $a0, 61508($t7)
sw $a0, 61512($t7)
sw $a0, 61516($t7)
sw $a0, 61520($t7)
sw $a0, 62004($t7)
sw $a0, 62008($t7)
sw $a0, 62012($t7)
sw $a0, 62016($t7)
sw $a0, 62020($t7)
sw $a0, 62024($t7)
sw $a0, 62028($t7)
sw $a0, 62032($t7)
sw $a0, 62516($t7)
sw $a0, 62520($t7)
sw $a0, 62524($t7)
sw $a0, 62528($t7)
sw $a0, 62532($t7)
sw $a0, 62536($t7)
sw $a0, 62540($t7)
sw $a0, 62544($t7)
sw $a0, 63032($t7)
sw $a0, 63036($t7)
sw $a0, 63040($t7)
sw $a0, 63044($t7)
sw $a0, 63048($t7)
sw $a0, 63052($t7)
sw $a0, 63548($t7)
sw $a0, 63552($t7)
sw $a0, 63556($t7)
sw $a0, 63560($t7)
sw $a0, 64064($t7)
sw $a0, 64068($t7)

sw $a0, 61024($t7)
sw $a0, 61028($t7)
sw $a0, 61040($t7)
sw $a0, 61044($t7)
sw $a0, 61532($t7)
sw $a0, 61536($t7)
sw $a0, 61540($t7)
sw $a0, 61544($t7)
sw $a0, 61548($t7)
sw $a0, 61552($t7)
sw $a0, 61556($t7)
sw $a0, 61560($t7)
sw $a0, 62044($t7)
sw $a0, 62048($t7)
sw $a0, 62052($t7)
sw $a0, 62056($t7)
sw $a0, 62060($t7)
sw $a0, 62064($t7)
sw $a0, 62068($t7)
sw $a0, 62072($t7)
sw $a0, 62556($t7)
sw $a0, 62560($t7)
sw $a0, 62564($t7)
sw $a0, 62568($t7)
sw $a0, 62572($t7)
sw $a0, 62576($t7)
sw $a0, 62580($t7)
sw $a0, 62584($t7)
sw $a0, 63072($t7)
sw $a0, 63076($t7)
sw $a0, 63080($t7)
sw $a0, 63084($t7)
sw $a0, 63088($t7)
sw $a0, 63092($t7)
sw $a0, 63588($t7)
sw $a0, 63592($t7)
sw $a0, 63596($t7)
sw $a0, 63600($t7)
sw $a0, 64104($t7)
sw $a0, 64108($t7)
j continue2
draw2lives:
	lw $a0, red
	lw $t7, displayAddress # start = base address
sw $a0, 60944($t7)
sw $a0, 60948($t7)
sw $a0, 60960($t7)
sw $a0, 60964($t7)
sw $a0, 61452($t7)
sw $a0, 61456($t7)
sw $a0, 61460($t7)
sw $a0, 61464($t7)
sw $a0, 61468($t7)
sw $a0, 61472($t7)
sw $a0, 61476($t7)
sw $a0, 61480($t7)
sw $a0, 61964($t7)
sw $a0, 61968($t7)
sw $a0, 61972($t7)
sw $a0, 61976($t7)
sw $a0, 61980($t7)
sw $a0, 61984($t7)
sw $a0, 61988($t7)
sw $a0, 61992($t7)
sw $a0, 62476($t7)
sw $a0, 62480($t7)
sw $a0, 62484($t7)
sw $a0, 62488($t7)
sw $a0, 62492($t7)
sw $a0, 62496($t7)
sw $a0, 62500($t7)
sw $a0, 62504($t7)
sw $a0, 62992($t7)
sw $a0, 62996($t7)
sw $a0, 63000($t7)
sw $a0, 63004($t7)
sw $a0, 63008($t7)
sw $a0, 63012($t7)
sw $a0, 63508($t7)
sw $a0, 63512($t7)
sw $a0, 63516($t7)
sw $a0, 63520($t7)
sw $a0, 64024($t7)
sw $a0, 64028($t7)

sw $a0, 60984($t7)
sw $a0, 60988($t7)
sw $a0, 61000($t7)
sw $a0, 61004($t7)
sw $a0, 61492($t7)
sw $a0, 61496($t7)
sw $a0, 61500($t7)
sw $a0, 61504($t7)
sw $a0, 61508($t7)
sw $a0, 61512($t7)
sw $a0, 61516($t7)
sw $a0, 61520($t7)
sw $a0, 62004($t7)
sw $a0, 62008($t7)
sw $a0, 62012($t7)
sw $a0, 62016($t7)
sw $a0, 62020($t7)
sw $a0, 62024($t7)
sw $a0, 62028($t7)
sw $a0, 62032($t7)
sw $a0, 62516($t7)
sw $a0, 62520($t7)
sw $a0, 62524($t7)
sw $a0, 62528($t7)
sw $a0, 62532($t7)
sw $a0, 62536($t7)
sw $a0, 62540($t7)
sw $a0, 62544($t7)
sw $a0, 63032($t7)
sw $a0, 63036($t7)
sw $a0, 63040($t7)
sw $a0, 63044($t7)
sw $a0, 63048($t7)
sw $a0, 63052($t7)
sw $a0, 63548($t7)
sw $a0, 63552($t7)
sw $a0, 63556($t7)
sw $a0, 63560($t7)
sw $a0, 64064($t7)
sw $a0, 64068($t7)
j continue2
draw1lives:
	lw $a0, red
	lw $t7, displayAddress # start = base address
sw $a0, 60944($t7)
sw $a0, 60948($t7)
sw $a0, 60960($t7)
sw $a0, 60964($t7)
sw $a0, 61452($t7)
sw $a0, 61456($t7)
sw $a0, 61460($t7)
sw $a0, 61464($t7)
sw $a0, 61468($t7)
sw $a0, 61472($t7)
sw $a0, 61476($t7)
sw $a0, 61480($t7)
sw $a0, 61964($t7)
sw $a0, 61968($t7)
sw $a0, 61972($t7)
sw $a0, 61976($t7)
sw $a0, 61980($t7)
sw $a0, 61984($t7)
sw $a0, 61988($t7)
sw $a0, 61992($t7)
sw $a0, 62476($t7)
sw $a0, 62480($t7)
sw $a0, 62484($t7)
sw $a0, 62488($t7)
sw $a0, 62492($t7)
sw $a0, 62496($t7)
sw $a0, 62500($t7)
sw $a0, 62504($t7)
sw $a0, 62992($t7)
sw $a0, 62996($t7)
sw $a0, 63000($t7)
sw $a0, 63004($t7)
sw $a0, 63008($t7)
sw $a0, 63012($t7)
sw $a0, 63508($t7)
sw $a0, 63512($t7)
sw $a0, 63516($t7)
sw $a0, 63520($t7)
sw $a0, 64024($t7)
sw $a0, 64028($t7)
	continue2:
	# print frogs
	lw $t1, white
	lw $t2, frog_x
	lw $t3, frog_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	add $a1, $t0, $a1 
	add $a1, $t2, $a1 
	lw $t2, frog_dir
	beq $t2, 0, print_up_frog
	beq $t2, 1, print_down_frog
	beq $t2, 2, print_left_frog
	beq $t2, 3, print_right_frog
	j dir_end
print_up_frog:
	jal print_frog
	j dir_end
print_left_frog:
	jal print_frog_left
	j dir_end
print_down_frog:
	jal print_frog_down
	j dir_end
print_right_frog:
	jal print_frog_right
	j dir_end
	dir_end:
	lw $t1, mark_1
	beq $t1, 1, draw_mark1
	check_mark2:
	lw $t2, mark_2
	beq $t2, 1, draw_mark2
	check_mark3:
	lw $t3, mark_3
	beq $t3, 1, draw_mark3
	j end_marking
	draw_mark1:
	lw $t1, red
	lw $t2, mark1_x
	lw $t3, mark1_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	add $a1, $t0, $a1 
	add $a1, $t2, $a1 
	jal print_frog
	j check_mark2
	draw_mark2:
		lw $t1, red
	lw $t2, mark2_x
	lw $t3, mark2_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	add $a1, $t0, $a1 
	add $a1, $t2, $a1 
	jal print_frog
	j check_mark3
	draw_mark3:
		lw $t1, red
	lw $t2, mark3_x
	lw $t3, mark3_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	add $a1, $t0, $a1 
	add $a1, $t2, $a1 
	jal print_frog
	j end_marking
	end_marking:
	# print car1 
	lw $t1, yellow
	lw $t2, car1_x
	lw $t3, car1_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	add $a1, $t0, $a1 
	add $a1, $t2, $a1 
	jal print_car
	
	la $t2, car1_x # move car
	lw $t3, car1_x
	li $t4, 110
	subi $t3, $t3, 3
	blt $t3, 1, round_car1
	sw $t3 0($t2)
	j end_car1
	round_car1:
	sub $t4, $t4, 3
	sw $t4 0($t2) # reset x

	end_car1:
	# print car2 
	lw $t1, yellow
	lw $t2, car2_x
	lw $t3, car2_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	lw $t2, car2_x
	lw $t3, car2_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	add $a1, $t0, $a1 
	add $a1, $t2, $a1 
	jal print_car
	
	la $t2, car2_x # move car
	lw $t3, car2_x
	li $t4, 119
	subi $t3, $t3, 2  # speed of car
	blt $t3, 1, round_car2
	sw $t3 0($t2)
	j end_car2
	round_car2:
	sub $t4, $t4, 11
	sw $t4 0($t2) # reset x
	
	end_car2:
	#print car3
	lw $t1, yellow
	lw $t2, car3_x
	lw $t3, car3_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	lw $t2, car3_x
	lw $t3, car3_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	add $a1, $t0, $a1 
	add $a1, $t2, $a1 
	jal print_car
	
	la $t2, car3_x # move car
	lw $t3, car3_x
	li $t4, 113
	subi $t3, $t3, 5 # speed of car
	blt $t3, 1, round_car3
	sw $t3 0($t2)
	j end_car3
	round_car3:
	sub $t4, $t4, 5
	sw $t4 0($t2) # reset x
	end_car3:

	# print log
	lw $t1, deep_green
	lw $t2, log1_x
	lw $t3, log1_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	lw $t2, log1_x
	lw $t3, log1_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	add $a1, $t0, $a1 
	add $a1, $t2, $a1 
	jal print_log
	
	la $t2, log1_x # move log
	lw $t3, log1_x
	li $t4, -40
	addi $t3, $t3, 1
	bgt $t3, 88, round_log1
	sw $t3 0($t2)
	j end_log1
	round_log1:
	addi $t4, $t4, 1
	sw $t4 0($t2) # reset x
	
	end_log1:
	
	lw $t2, log2_x
	lw $t3, log2_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	lw $t2, log2_x
	lw $t3, log2_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	add $a1, $t0, $a1 
	add $a1, $t2, $a1 
	jal print_log
	
	la $t2, log2_x # move car
	lw $t3, log2_x
	li $t4, -40
	addi $t3, $t3, 3
	bgt $t3, 88, round_log2
	sw $t3 0($t2)
	j end_log2
	round_log2:
	addi $t4, $t4, 0
	sw $t4 0($t2) # reset x
	
	end_log2:
	
	lw $t2, log2_x
	lw $t3, log2_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	lw $t2, log3_x
	lw $t3, log3_y
	li $t4, 512
	li $t5, 4
	li $a1, 0
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	
	add $a1, $t0, $a1 
	add $a1, $t2, $a1 
	jal print_log
	
	la $t2, log3_x # move car
	lw $t3, log3_x
	li $t4, -40
	addi $t3, $t3, 2
	bgt $t3, 88, round_log3
	sw $t3 0($t2)
	j end_log3
	round_log3:
	addi $t4, $t4, 2
	sw $t4 0($t2) # reset x
	
	end_log3:
	
	lw $t1, white # load white 
	jal print_score
	# score
	jal update_max
	jal display_score
	lw $t1, yellow # load yellow
	jal print_time
	
	li $v0, 32 # refresh 60 times per second
 	li $a0, 17
 	
 	
 	syscall	
 		
j refresh	
	
Exit:
	li $v0, 10 # terminate the program gracefully
	syscall
	
			
update_max:
	lw $a0, frog_y
	lw $a1, max_y
	blt $a0, $a1, update_max_in
	j update_max_end
	update_max_in:
	la $a2, max_y
	sw $a0, ($a2)
	lw $a0, max_y # max y reached
	li $a1, 128
	sub $a0, $a1, $a0

	la $a2, score # address of score
	lw $a3, score # score value
	add $a3, $a3, $a0
	sw $a3, 0($a2)
	update_max_end:
	
	jr $ra	
		
display_score:
	lw $a0, score
	beq $a0, 0, score_0
	beq $a0, 22, score_10
	beq $a0, 55, score_20
	beq $a0, 99, score_30
	beq $a0, 154, score_40
	beq $a0, 220, score_50
	beq $a0, 297, score_60
	beq $a0, 385, score_70
	beq $a0, 484, score_80
	
	beq $a0, 584, score_180
	beq $a0, 606, score_190
	beq $a0, 639, score_200
	beq $a0, 683, score_210
	beq $a0, 738, score_220
	beq $a0, 804, score_230
	beq $a0, 881, score_240
	beq $a0, 969, score_250
	beq $a0, 1068, score_260
	
	beq $a0, 1268, score_360
	beq $a0, 1290, score_370
	beq $a0, 1323, score_380
	beq $a0, 1367, score_390
	beq $a0, 1422, score_400
	beq $a0, 1488, score_410
	beq $a0, 1565, score_420
	beq $a0, 1653, score_430
	beq $a0, 1752, score_440
	j end_display
	score_0:
	lw $a0, white
	lw $t7, displayAddress # start = base address
	#bit 3 0
	sw $a0, 112($t7)
sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

	#bit 2 0
sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1152($t7)
sw $a0, 1164($t7)
sw $a0, 1664($t7)
sw $a0, 1676($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)
	#bit 1 0
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 672($t7)
sw $a0, 1172($t7)
sw $a0, 1184($t7)
sw $a0, 1684($t7)
sw $a0, 1696($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)
	#bit 0 0	
sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)
j end_display
	score_10:
	lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1152($t7)
sw $a0, 1164($t7)
sw $a0, 1664($t7)
sw $a0, 1676($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)

sw $a0, 152($t7)
sw $a0, 660($t7)
sw $a0, 664($t7)
sw $a0, 1176($t7)
sw $a0, 1688($t7)
sw $a0, 2196($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)
j end_display

score_20:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1152($t7)
sw $a0, 1164($t7)
sw $a0, 1664($t7)
sw $a0, 1676($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)

# bit 1 2
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 672($t7)
sw $a0, 1180($t7)
sw $a0, 1688($t7)
sw $a0, 2196($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)
sw $a0, 2208($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_30:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1152($t7)
sw $a0, 1164($t7)
sw $a0, 1664($t7)
sw $a0, 1676($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)

# bit 1 3
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 672($t7)
sw $a0, 1180($t7)
sw $a0, 1684($t7)
sw $a0, 1696($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_40:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1152($t7)
sw $a0, 1164($t7)
sw $a0, 1664($t7)
sw $a0, 1676($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)

# bit 1 4
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 668($t7)
sw $a0, 1172($t7)
sw $a0, 1176($t7)
sw $a0, 1180($t7)
sw $a0, 1184($t7)
sw $a0, 1692($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_50:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1152($t7)
sw $a0, 1164($t7)
sw $a0, 1664($t7)
sw $a0, 1676($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)

# bit 1 5
sw $a0, 148($t7)
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 160($t7)
sw $a0, 660($t7)
sw $a0, 1172($t7)
sw $a0, 1176($t7)
sw $a0, 1180($t7)
sw $a0, 1696($t7)
sw $a0, 2196($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_60:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1152($t7)
sw $a0, 1164($t7)
sw $a0, 1664($t7)
sw $a0, 1676($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)

# bit 1 6
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 1172($t7)
sw $a0, 1176($t7)
sw $a0, 1180($t7)
sw $a0, 1684($t7)
sw $a0, 1696($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_70:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1152($t7)
sw $a0, 1164($t7)
sw $a0, 1664($t7)
sw $a0, 1676($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)

# bit 1 7
sw $a0, 148($t7)
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 160($t7)
sw $a0, 672($t7)
sw $a0, 1180($t7)
sw $a0, 1688($t7)
sw $a0, 2200($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_80:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1152($t7)
sw $a0, 1164($t7)
sw $a0, 1664($t7)
sw $a0, 1676($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)

# bit 1 8
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 672($t7)
sw $a0, 1176($t7)
sw $a0, 1180($t7)
sw $a0, 1684($t7)
sw $a0, 1696($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_180:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 640($t7)
sw $a0, 644($t7)
sw $a0, 1156($t7)
sw $a0, 1668($t7)
sw $a0, 2176($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)

# bit 1 8
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 672($t7)
sw $a0, 1176($t7)
sw $a0, 1180($t7)
sw $a0, 1684($t7)
sw $a0, 1696($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_190:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 640($t7)
sw $a0, 644($t7)
sw $a0, 1156($t7)
sw $a0, 1668($t7)
sw $a0, 2176($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)

# bit 1 9
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 672($t7)
sw $a0, 1176($t7)
sw $a0, 1180($t7)
sw $a0, 1184($t7)
sw $a0, 1696($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display


score_200:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1160($t7)
sw $a0, 1668($t7)
sw $a0, 2176($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)
sw $a0, 2188($t7)

sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 672($t7)
sw $a0, 1172($t7)
sw $a0, 1184($t7)
sw $a0, 1684($t7)
sw $a0, 1696($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_210:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1160($t7)
sw $a0, 1668($t7)
sw $a0, 2176($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)
sw $a0, 2188($t7)

sw $a0, 152($t7)
sw $a0, 660($t7)
sw $a0, 664($t7)
sw $a0, 1176($t7)
sw $a0, 1688($t7)
sw $a0, 2196($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_220:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1160($t7)
sw $a0, 1668($t7)
sw $a0, 2176($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)
sw $a0, 2188($t7)

sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 672($t7)
sw $a0, 1180($t7)
sw $a0, 1688($t7)
sw $a0, 2196($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)
sw $a0, 2208($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_230:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1160($t7)
sw $a0, 1668($t7)
sw $a0, 2176($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)
sw $a0, 2188($t7)

#
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 672($t7)
sw $a0, 1180($t7)
sw $a0, 1684($t7)
sw $a0, 1696($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_240:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1160($t7)
sw $a0, 1668($t7)
sw $a0, 2176($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)
sw $a0, 2188($t7)

#
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 668($t7)
sw $a0, 1172($t7)
sw $a0, 1176($t7)
sw $a0, 1180($t7)
sw $a0, 1184($t7)
sw $a0, 1692($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_250:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1160($t7)
sw $a0, 1668($t7)
sw $a0, 2176($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)
sw $a0, 2188($t7)

#
sw $a0, 148($t7)
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 160($t7)
sw $a0, 660($t7)
sw $a0, 1172($t7)
sw $a0, 1176($t7)
sw $a0, 1180($t7)
sw $a0, 1696($t7)
sw $a0, 2196($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_260:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1160($t7)
sw $a0, 1668($t7)
sw $a0, 2176($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)
sw $a0, 2188($t7)

#
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 1172($t7)
sw $a0, 1176($t7)
sw $a0, 1180($t7)
sw $a0, 1684($t7)
sw $a0, 1696($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display
score_360:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1160($t7)
sw $a0, 1664($t7)
sw $a0, 1676($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)

#
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 1172($t7)
sw $a0, 1176($t7)
sw $a0, 1180($t7)
sw $a0, 1684($t7)
sw $a0, 1696($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_370:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1160($t7)
sw $a0, 1664($t7)
sw $a0, 1676($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)

#
sw $a0, 148($t7)
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 160($t7)
sw $a0, 672($t7)
sw $a0, 1180($t7)
sw $a0, 1688($t7)
sw $a0, 2200($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_380:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1160($t7)
sw $a0, 1664($t7)
sw $a0, 1676($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)

#
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 672($t7)
sw $a0, 1176($t7)
sw $a0, 1180($t7)
sw $a0, 1684($t7)
sw $a0, 1696($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_390:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 652($t7)
sw $a0, 1160($t7)
sw $a0, 1664($t7)
sw $a0, 1676($t7)
sw $a0, 2180($t7)
sw $a0, 2184($t7)

#
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 672($t7)
sw $a0, 1176($t7)
sw $a0, 1180($t7)
sw $a0, 1184($t7)
sw $a0, 1696($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)

sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_400:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 648($t7)
sw $a0, 1152($t7)
sw $a0, 1156($t7)
sw $a0, 1160($t7)
sw $a0, 1164($t7)
sw $a0, 1672($t7)
sw $a0, 2184($t7)

#
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 672($t7)
sw $a0, 1172($t7)
sw $a0, 1184($t7)
sw $a0, 1684($t7)
sw $a0, 1696($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)


sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_410:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 648($t7)
sw $a0, 1152($t7)
sw $a0, 1156($t7)
sw $a0, 1160($t7)
sw $a0, 1164($t7)
sw $a0, 1672($t7)
sw $a0, 2184($t7)

#
sw $a0, 152($t7)
sw $a0, 660($t7)
sw $a0, 664($t7)
sw $a0, 1176($t7)
sw $a0, 1688($t7)
sw $a0, 2196($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)


sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_420:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 648($t7)
sw $a0, 1152($t7)
sw $a0, 1156($t7)
sw $a0, 1160($t7)
sw $a0, 1164($t7)
sw $a0, 1672($t7)
sw $a0, 2184($t7)

#
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 672($t7)
sw $a0, 1180($t7)
sw $a0, 1688($t7)
sw $a0, 2196($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)
sw $a0, 2208($t7)


sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display

score_430:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 648($t7)
sw $a0, 1152($t7)
sw $a0, 1156($t7)
sw $a0, 1160($t7)
sw $a0, 1164($t7)
sw $a0, 1672($t7)
sw $a0, 2184($t7)

#
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 672($t7)
sw $a0, 1180($t7)
sw $a0, 1684($t7)
sw $a0, 1696($t7)
sw $a0, 2200($t7)
sw $a0, 2204($t7)


sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display


score_440:
lw $a0, white
	lw $t7, displayAddress # start = base address
	sw $a0, 112($t7)
	sw $a0, 116($t7)
sw $a0, 620($t7)
sw $a0, 632($t7)
sw $a0, 1132($t7)
sw $a0, 1144($t7)
sw $a0, 1644($t7)
sw $a0, 1656($t7)
sw $a0, 2160($t7)
sw $a0, 2164($t7)

sw $a0, 132($t7)
sw $a0, 136($t7)
sw $a0, 640($t7)
sw $a0, 648($t7)
sw $a0, 1152($t7)
sw $a0, 1156($t7)
sw $a0, 1160($t7)
sw $a0, 1164($t7)
sw $a0, 1672($t7)
sw $a0, 2184($t7)

#
sw $a0, 152($t7)
sw $a0, 156($t7)
sw $a0, 660($t7)
sw $a0, 668($t7)
sw $a0, 1172($t7)
sw $a0, 1176($t7)
sw $a0, 1180($t7)
sw $a0, 1184($t7)
sw $a0, 1692($t7)
sw $a0, 2204($t7)


sw $a0, 172($t7)
sw $a0, 176($t7)
sw $a0, 680($t7)
sw $a0, 692($t7)
sw $a0, 1192($t7)
sw $a0, 1204($t7)
sw $a0, 1704($t7)
sw $a0, 1716($t7)
sw $a0, 2220($t7)
sw $a0, 2224($t7)

j end_display
	end_display:
	jr $ra
				
								
																
check_key:
	lw $t1, 0xffff0000	
	beq $t1, 1, keyboardInput
		jr $ra
	keyboardInput:  
		lw $t1, 0xffff0004
		beq $t1, 0x77, respond_to_W				
		beq $t1, 0x61, respond_to_A
		beq $t1, 0x73, respond_to_S
		beq $t1, 0x64, respond_to_D
		beq $t1, 0x72, repsond_to_R
		beq $t1, 0x71, repsond_to_Q
	jr $ra
	
respond_to_W:	
	la $a0, frog_y #get address
	lw $a1 frog_y
  	subi $a1, $a1, 11 #new value
  	blt $a1, 0, respond_to_W_end 
   		sw $a1 0($a0) #save new value
   		# change frog direction
		la $a0, frog_dir #get address
		li $a1 0
		sw $a1 0($a0)
   		jr $ra	
	respond_to_W_end:
		jr $ra		

respond_to_A:	
	la $a0, frog_x #get address
	lw $a1 frog_x
  	subi $a1, $a1, 11 #new value
  	blt $a1, 0, respond_to_A_end 
   		sw $a1 0($a0) #save new value
   		# change frog direction
		la $a0, frog_dir #get address
		li $a1 2
		sw $a1 0($a0)
   		jr $ra	
	respond_to_A_end:
		jr $ra		
respond_to_S:	
	la $a0, frog_y #get address
	lw $a1 frog_y
  	addi $a1, $a1, 11 #new value
  	bgt $a1, 117, respond_to_S_end 
   		sw $a1 0($a0) #save new value
   		# change frog direction
		la $a0, frog_dir #get address
		li $a1 1
		sw $a1 0($a0)
   		jr $ra	
	respond_to_S_end:
		jr $ra	
			
respond_to_D:	
	la $a0, frog_x #get address
	lw $a1 frog_x
  	addi $a1, $a1, 11 #new value
  	bgt $a1, 117, respond_to_D_end 
   		sw $a1 0($a0) #save new value
   		# change frog direction
		la $a0, frog_dir #get address
		li $a1 3
		sw $a1 0($a0)
   		jr $ra	
	respond_to_D_end:
		jr $ra	
		
repsond_to_R:	
	la $a0, game_flag #get address
	lw $a1, game_flag
  	addi $a1, $a1, 1 #new value
	sw $a1 0($a0) #save new value
	la $a0, num_lives #get address
	li $a1, 3
	sw $a1 0($a0) #save new value
	la $a0, max_y #get address
	li $a1, 117
	sw $a1 0($a0) #save new value
	la $a0, score #get address
	li $a1, 0
	sw $a1 0($a0) #save new value
	la $a0, mark_1
	li $a1, 0
	sw $a1, 0($a0)
	la $a0, mark_2
	li $a1, 0
	sw $a1, 0($a0)
	la $a0, mark_3
	li $a1, 0
	sw $a1, 0($a0)
	jr $ra
	
repsond_to_Q:	
	lw $a1, game_flag
	bne $a1, 0, Q_end
	j Exit
	Q_end: 
	jr $ra			
			

print_home: 
	lw $a0, black
	lw $t7, displayAddress # start = base address
	addi $t6, $t7, 65536
	addi $t7, $t7, 0
LOOP_home: beq $t7, $t6, END_home
	sw $a0,($t7) 
	addi $t7, $t7, 4 # start = start + 4
	j LOOP_home
	END_home: 
	# draw "GAME OVER! press r to restart or o to end the game!"
	
	
	lw $a0, white
	lw $t7, displayAddress # start = base address
sw $a0, 22188($t7)
sw $a0, 22192($t7)
sw $a0, 22196($t7)
sw $a0, 22208($t7)
sw $a0, 22212($t7)
sw $a0, 22224($t7)
sw $a0, 22240($t7)
sw $a0, 22248($t7)
sw $a0, 22252($t7)
sw $a0, 22256($t7)
sw $a0, 22260($t7)
sw $a0, 22284($t7)
sw $a0, 22288($t7)
sw $a0, 22300($t7)
sw $a0, 22308($t7)
sw $a0, 22316($t7)
sw $a0, 22320($t7)
sw $a0, 22324($t7)
sw $a0, 22328($t7)
sw $a0, 22336($t7)
sw $a0, 22340($t7)
sw $a0, 22344($t7)
sw $a0, 22356($t7)

sw $a0, 22696($t7)
sw $a0, 22716($t7)
sw $a0, 22728($t7)
sw $a0, 22736($t7)
sw $a0, 22740($t7)
sw $a0, 22748($t7)
sw $a0, 22752($t7)
sw $a0, 22760($t7)
sw $a0, 22792($t7)
sw $a0, 22804($t7)
sw $a0, 22812($t7)
sw $a0, 22820($t7)
sw $a0, 22828($t7)
sw $a0, 22848($t7)
sw $a0, 22860($t7)
sw $a0, 22868($t7)

sw $a0, 23208($t7)
sw $a0, 23216($t7)
sw $a0, 23220($t7)
sw $a0, 23228($t7)
sw $a0, 23232($t7)
sw $a0, 23236($t7)
sw $a0, 23240($t7)
sw $a0, 23248($t7)
sw $a0, 23256($t7)
sw $a0, 23264($t7)
sw $a0, 23272($t7)
sw $a0, 23276($t7)
sw $a0, 23280($t7)
sw $a0, 23304($t7)
sw $a0, 23316($t7)
sw $a0, 23324($t7)
sw $a0, 23332($t7)
sw $a0, 23340($t7)
sw $a0, 23344($t7)
sw $a0, 23348($t7)
sw $a0, 23360($t7)
sw $a0, 23364($t7)
sw $a0, 23368($t7)
sw $a0, 23380($t7)

sw $a0, 23720($t7)
sw $a0, 23732($t7)
sw $a0, 23740($t7)
sw $a0, 23752($t7)
sw $a0, 23760($t7)
sw $a0, 23776($t7)
sw $a0, 23784($t7)
sw $a0, 23816($t7)
sw $a0, 23828($t7)
sw $a0, 23836($t7)
sw $a0, 23844($t7)
sw $a0, 23852($t7)
sw $a0, 23872($t7)
sw $a0, 23880($t7)

sw $a0, 24236($t7)
sw $a0, 24240($t7)
sw $a0, 24244($t7)
sw $a0, 24252($t7)
sw $a0, 24264($t7)
sw $a0, 24272($t7)
sw $a0, 24288($t7)
sw $a0, 24296($t7)
sw $a0, 24300($t7)
sw $a0, 24304($t7)
sw $a0, 24308($t7)
sw $a0, 24332($t7)
sw $a0, 24336($t7)
sw $a0, 24352($t7)
sw $a0, 24364($t7)
sw $a0, 24368($t7)
sw $a0, 24372($t7)
sw $a0, 24376($t7)
sw $a0, 24384($t7)
sw $a0, 24396($t7)
sw $a0, 24404($t7)

lw $a0, yellow
####
sw $a0, 25236($t7)
sw $a0, 25240($t7)
sw $a0, 25244($t7)
sw $a0, 25268($t7)
sw $a0, 25272($t7)
sw $a0, 25276($t7)
sw $a0, 25288($t7)
sw $a0, 25292($t7)
sw $a0, 25296($t7)
sw $a0, 25300($t7)
sw $a0, 25304($t7)
sw $a0, 25312($t7)
sw $a0, 25316($t7)
sw $a0, 25320($t7)
sw $a0, 25328($t7)
sw $a0, 25332($t7)
sw $a0, 25336($t7)
sw $a0, 25348($t7)
sw $a0, 25352($t7)
sw $a0, 25364($t7)
sw $a0, 25368($t7)
sw $a0, 25372($t7)
sw $a0, 25384($t7)
sw $a0, 25388($t7)
sw $a0, 25392($t7)

sw $a0, 25748($t7)
sw $a0, 25760($t7)
sw $a0, 25780($t7)
sw $a0, 25792($t7)
sw $a0, 25800($t7)
sw $a0, 25820($t7)
sw $a0, 25844($t7)
sw $a0, 25856($t7)
sw $a0, 25868($t7)
sw $a0, 25876($t7)
sw $a0, 25888($t7)
sw $a0, 25900($t7)

sw $a0, 26260($t7)
sw $a0, 26264($t7)
sw $a0, 26268($t7)
sw $a0, 26292($t7)
sw $a0, 26296($t7)
sw $a0, 26300($t7)
sw $a0, 26312($t7)
sw $a0, 26316($t7)
sw $a0, 26320($t7)
sw $a0, 26336($t7)
sw $a0, 26340($t7)
sw $a0, 26356($t7)
sw $a0, 26368($t7)
sw $a0, 26372($t7)
sw $a0, 26376($t7)
sw $a0, 26380($t7)
sw $a0, 26388($t7)
sw $a0, 26392($t7)
sw $a0, 26396($t7)
sw $a0, 26412($t7)

sw $a0, 26772($t7)
sw $a0, 26780($t7)
sw $a0, 26804($t7)
sw $a0, 26812($t7)
sw $a0, 26824($t7)
sw $a0, 26856($t7)
sw $a0, 26868($t7)
sw $a0, 26880($t7)
sw $a0, 26892($t7)
sw $a0, 26900($t7)
sw $a0, 26908($t7)
sw $a0, 26924($t7)

sw $a0, 27284($t7)
sw $a0, 27296($t7)
sw $a0, 27316($t7)
sw $a0, 27328($t7)
sw $a0, 27336($t7)
sw $a0, 27340($t7)
sw $a0, 27344($t7)
sw $a0, 27348($t7)
sw $a0, 27356($t7)
sw $a0, 27360($t7)
sw $a0, 27364($t7)
sw $a0, 27380($t7)
sw $a0, 27392($t7)
sw $a0, 27404($t7)
sw $a0, 27412($t7)
sw $a0, 27424($t7)
sw $a0, 27436($t7)

lw $a0, red
sw $a0, 28312($t7)
sw $a0, 28316($t7)
sw $a0, 28344($t7)
sw $a0, 28348($t7)
sw $a0, 28360($t7)
sw $a0, 28372($t7)
sw $a0, 28380($t7)
sw $a0, 28388($t7)
sw $a0, 28392($t7)
sw $a0, 28396($t7)

sw $a0, 28820($t7)
sw $a0, 28832($t7)
sw $a0, 28852($t7)
sw $a0, 28864($t7)
sw $a0, 28872($t7)
sw $a0, 28884($t7)
sw $a0, 28892($t7)
sw $a0, 28904($t7)

sw $a0, 29332($t7)
sw $a0, 29344($t7)
sw $a0, 29364($t7)
sw $a0, 29376($t7)
sw $a0, 29384($t7)
sw $a0, 29396($t7)
sw $a0, 29404($t7)
sw $a0, 29416($t7)	

sw $a0, 29332($t7)
sw $a0, 29344($t7)
sw $a0, 29364($t7)
sw $a0, 29376($t7)
sw $a0, 29384($t7)
sw $a0, 29396($t7)
sw $a0, 29404($t7)
sw $a0, 29416($t7)

sw $a0, 29844($t7)
sw $a0, 29852($t7)
sw $a0, 29856($t7)
sw $a0, 29876($t7)
sw $a0, 29884($t7)
sw $a0, 29888($t7)
sw $a0, 29896($t7)
sw $a0, 29908($t7)
sw $a0, 29916($t7)
sw $a0, 29928($t7)

sw $a0, 30360($t7)
sw $a0, 30364($t7)
sw $a0, 30368($t7)
sw $a0, 30392($t7)
sw $a0, 30396($t7)
sw $a0, 30400($t7)
sw $a0, 30408($t7)
sw $a0, 30412($t7)
sw $a0, 30416($t7)
sw $a0, 30420($t7)
sw $a0, 30428($t7)
sw $a0, 30440($t7)

	
	
	
	j refresh
	
	
check_status:
	lw $t2, frog_x #t2 =frog_x
	lw $t3, frog_y #t3 =frog_y
	addi $t3, $t3, 3 # we will check the body of the frog
	li $t4, 512
	li $t5, 4
	li $a1, 0 # address of starting of frog
	multu $t3, $t4
	mflo $a1
	multu $t2, $t5
	mflo $t2
	add $a1, $t0, $a1 
	add $a1, $t2, $a1 
	
	lw $a2, ($a1) # load the color
	lw $a3, yellow
	lw $a0, deep_green
	lw $t3, blue
	lw $t4, green
	lw $t5, checker_black
	lw $t6, red
	addi $t2, $a1, 44
	LOOP_check: beq $a1, $t2, END_check
		beq $a2, $a3, frog_dead # if frog hits car
		beq $a2, $t3, frog_dead # if frog hits water
		beq $a2, $t4, frog_dead # if frog hits grass
		beq $a2, $t6, frog_dead # if frog hits grass
		beq $a2, $t5, frog_win # if frog hits goal
		beq $a2, $a0, frog_rider # if frog on the tree
		addi $a1, $a1, 4 # start = start + 4
		lw $a2, ($a1) # load the color
	j LOOP_check
	END_check: 
		jr $ra
	frog_dead:
	
	# check how many lives remaining
	la $a0, num_lives 
	lw $a1, num_lives
	beq $a1, 0, game_over
	subi $a1, $a1, 1
	sw $a1, 0($a0)
	j game_overlinkto
	game_over: 
		la $a0, game_flag
		li $a1, 0
		sw $a1, 0($a0)
		la $a0, mark_1
		li $a1, 0
		sw $a1, 0($a0)
		la $a0, mark_2
		li $a1, 0
		sw $a1, 0($a0)
		la $a0, mark_3
		li $a1, 0
		sw $a1, 0($a0)

	game_overlinkto:
	#reset
	la $a0, frog_x #get address
	li $a1, 64
	sw $a1 0($a0) #save new value
	la $a0, frog_y #get address
	li $a1, 117
	sw $a1 0($a0) #save new value
	jr $ra
	frog_rider:
	#move along with log
	lw $a0, frog_y
	beq $a0, 29, log1_move
	beq $a0, 40, log2_move
	beq $a0, 51, log3_move
	jr $ra
	log1_move: 
		la $a0, frog_x #get address
		lw $a1, frog_x
		bge $a1, 115, move_end
		addi $a1, $a1, 1
		sw $a1 0($a0) #save new value
		jr $ra
	log2_move: 
		la $a0, frog_x #get address
		lw $a1, frog_x
		bge $a1, 115, move_end
		addi $a1, $a1, 3
		sw $a1 0($a0) #save new value
		jr $ra
	log3_move: 
		la $a0, frog_x #get address
		lw $a1, frog_x
		bge $a1, 115, move_end
		addi $a1, $a1, 2
		sw $a1 0($a0) #save new value
		jr $ra
	move_end:
		jr $ra
	
	frog_win: 
	
	# save mark info
	lw $t2, frog_x
	lw $t3, frog_y
	
	
	blt $t2, 37, set_mark_1
	blt $t2, 73, set_mark_2
	blt $t2, 128, set_mark_3
	set_mark_1:

	
	la $a0, mark_1
	li $a1, 1
	sw $a1, 0($a0)
	la $a0, mark1_x
	la $a1, mark1_y
	sw $t2, 0($a0)
	sw $t3, 0($a1)
	j end_win
	set_mark_2:
	la $a0, mark_2
	li $a1, 1
	sw $a1, 0($a0)
	la $a0, mark2_x
	la $a1, mark2_y
	sw $t2, 0($a0)
	sw $t3, 0($a1)
	j end_win
	set_mark_3:
	la $a0, mark_3
	li $a1, 1
	sw $a1, 0($a0)
	la $a0, mark3_x
	la $a1, mark3_y
	sw $t2, 0($a0)
	sw $t3, 0($a1)
	j end_win
	end_win:
	
	la $a0, frog_x #get address
	li $a1, 64
	sw $a1 0($a0) #save new value
	la $a0, frog_y #get address
	li $a1, 117
	sw $a1 0($a0) #save new value
	
	la $a0, max_y #get address
	li $a1, 117
	sw $a1 0($a0) #save new value
	la $a2, score # address of score
	lw $a3, score # score value
	lw $a1, mark_1 # mark_1 score
	beq $a1, 1 add_mark1
	j cont_mark2
	add_mark1:
	addi $a3, $a3, 100

	
	cont_mark2:
	lw $a1, mark_2 # mark_2 score
	beq $a1, 1 add_mark2
	j cont_mark3
	add_mark2:
	addi $a3, $a3, 100
	
	cont_mark3:
	lw $a1, mark_3 # mark_3 score
	beq $a1, 1 add_mark3	
	j calculate_end
	add_mark3:
	addi $a3, $a3, 100
	
	calculate_end:
	sw $a3, 0($a2)
	j refresh
	
																													
print_water:
	lw $t7, displayAddress # start = base address
	addi $t6, $t7, 31744
	addi $t7, $t7, 14848
LOOP_water: beq $t7, $t6, END_water
	sw $t1,($t7) 
	addi $t7, $t7, 4 # start = start + 4
	j LOOP_water
	END_water: 
	jr $ra

print_road:
	lw $t7, displayAddress # start = base address
	addi $t6, $t7, 65532  # print from 52732 to 60412
	addi $t7, $t7, 37376
LOOP_road: beq $t7, $t6, END_road
	sw $t1,($t7) 
	addi $t7, $t7, 4 # start = start + 4
	j LOOP_road
	END_road: 
	lw $t7, displayAddress # start = base address
	addi $t6, $t7, 2560  # print from 52732 to 60412
	addi $t7, $t7, 0
LOOP_road2: beq $t7, $t6, END_road2
	sw $t1,($t7) 
	addi $t7, $t7, 4 # start = start + 4
	j LOOP_road2
	END_road2: 
	jr $ra
	
print_safe:
    	lw $t7, displayAddress # start = base address
    	addi $t6, $t7, 59904  # print from 52732 to 60412
    	addi $t7, $t7, 54272
    	LOOP_safe: beq $t7, $t6, END_safe1
   	sw $t1,($t7)
   	addi $t7, $t7, 4 # start = start + 4
    	j LOOP_safe	
END_safe1:
    	lw $t7, displayAddress # start = base address
    	addi $t6, $t7, 37376 
    	addi $t7, $t7, 31744
LOOP_safe2: beq $t7, $t6, END_safe2
    	sw $t1,($t7)
	addi $t7, $t7, 4 # start = start + 4
    	j LOOP_safe2
END_safe2:
    	jr $ra
 
print_grass:
    	lw $t7, displayAddress # start = base address
    	addi $t6, $t7, 9216  # print from 52732 to 60412
    	addi $t7, $t7, 5120
	LOOP_grass1: beq $t7, $t6, END_grass1
   		sw $t1,($t7)
    		addi $t7, $t7, 4 # start = start + 4
    	j LOOP_grass1 
END_grass1:
	lw $t7, displayAddress # start = base address
	addi $t5, $t7, 14396
    	addi $t6, $t7, 9276
    	addi $t7, $t7, 9216
OUT_LOOP_grass2: ble $t5, $t7, OUT_END_grass2
    	LOOP_grass2: ble $t6, $t7, END_grass2
   		sw $t1,($t7)
    		addi $t7, $t7, 4 # start = start + 4
    	j LOOP_grass2 
END_grass2:
    	addi $t7, $t7, 432 # start = start + 436
    	addi $t6, $t6, 512 
	j OUT_LOOP_grass2 
OUT_END_grass2:    	
	lw $t7, displayAddress # start = base address
	addi $t5, $t7, 14850
    	addi $t6, $t7, 9416 
    	addi $t7, $t7, 9356
OUT_LOOP_grass3: ble $t5, $t7, OUT_END_grass3
    	LOOP_grass3: ble $t6, $t7, END_grass3
   		sw $t1,($t7)
    		addi $t7, $t7, 4 # start = start + 4
    	j LOOP_grass3 
END_grass3:
    	addi $t7, $t7, 452 # start = start + 436
    	addi $t6, $t6, 512  # print from 52732 to 60412
	j OUT_LOOP_grass3 	
OUT_END_grass3:      
	lw $t7, displayAddress # start = base address
	addi $t5, $t7, 14702
    	addi $t6, $t7, 9576  
    	addi $t7, $t7, 9496
OUT_LOOP_grass4: ble $t5, $t7, OUT_END_grass4
    	LOOP_grass4: ble $t6, $t7, END_grass4
   		sw $t1,($t7)
    		addi $t7, $t7, 4 # start = start + 4
    	j LOOP_grass4
END_grass4:
    	addi $t7, $t7, 432 # start = start + 436
    	addi $t6, $t6, 512
	j OUT_LOOP_grass4	
OUT_END_grass4:      
	lw $t7, displayAddress # start = base address
	addi $t5, $t7, 14848
    	addi $t6, $t7, 9728  
    	addi $t7, $t7, 9660
OUT_LOOP_grass5: ble $t5, $t7, OUT_END_grass5
    	LOOP_grass5: ble $t6, $t7, END_grass5
   		sw $t1,($t7)
    		addi $t7, $t7, 4 # start = start + 4
    	j LOOP_grass5
END_grass5:
    	addi $t7, $t7, 444 # start = start + 436
    	addi $t6, $t6, 512 
	j OUT_LOOP_grass5	
OUT_END_grass5:
# goal region      
	lw $t7, displayAddress # start = base address
	addi $t5, $t7, 14476
    	addi $t6, $t7, 9356  
    	addi $t7, $t7, 9276
    	lw $t1, checker_black
OUT_LOOP_grass6: ble $t5, $t7, OUT_END_grass6
    	LOOP_grass6: ble $t6, $t7, END_grass6
   		sw $t1,($t7)
    		addi $t7, $t7, 4 # start = start + 4
    	j LOOP_grass6
END_grass6:
    	addi $t7, $t7, 432 # start = start + 436
    	addi $t6, $t6, 512 
	j OUT_LOOP_grass6	
OUT_END_grass6:      
	lw $t7, displayAddress # start = base address
	addi $t5, $t7, 14780
    	addi $t6, $t7, 9660  
    	addi $t7, $t7, 9576
    	lw $t1, checker_black
OUT_LOOP_grass7: ble $t5, $t7, OUT_END_grass7
    	LOOP_grass7: ble $t6, $t7, END_grass7
   		sw $t1,($t7)
    		addi $t7, $t7, 4 # start = start + 4
    	j LOOP_grass7
END_grass7:
    	addi $t7, $t7, 428 # start = start + 436
    	addi $t6, $t6, 512 
	j OUT_LOOP_grass7	
OUT_END_grass7:      
	lw $t7, displayAddress # start = base address
	addi $t5, $t7, 14616
    	addi $t6, $t7, 9496  
    	addi $t7, $t7, 9416
    	lw $t1, checker_black
OUT_LOOP_grass8: ble $t5, $t7, OUT_END_grass8
    	LOOP_grass8: ble $t6, $t7, END_grass8
   		sw $t1,($t7)
    		addi $t7, $t7, 4 # start = start + 4
    	j LOOP_grass8
END_grass8:
    	addi $t7, $t7, 432 # start = start + 436
    	addi $t6, $t6, 512 
	j OUT_LOOP_grass8	
OUT_END_grass8:      
	jr $ra
	
# Print frog a0: memory address 
print_frog:
	sw $t1, 0($a1)
	sw $t1, 4($a1)
	sw $t1, 36($a1)
	sw $t1, 40($a1)
	sw $t1, 512($a1)
	sw $t1, 516($a1)
	sw $t1, 548($a1)
	sw $t1, 552($a1)
	sw $t1, 1024($a1)
	sw $t1, 1028($a1)
	sw $t1, 1060($a1)
	sw $t1, 1064($a1)
	sw $t1, 1536($a1)
	sw $t1, 1540($a1)
	sw $t1, 1572($a1)
	sw $t1, 1576($a1)
	
	addi $t7, $a1, 1544 # start square
    	addi $t6, $a1, 1572	
    	addi $t5, $a1, 4132			   	
	Frog_loop1: ble $t5, $t7, OUT_END_frog
    		Frog_loop2: ble $t6, $t7, END_frog
   			sw $t1,($t7)
    			addi $t7, $t7, 4 # start = start + 4
    		j Frog_loop2				
	END_frog:
		addi $t7, $t7, 484
    		addi $t6, $t6, 512 
		j Frog_loop1	
	OUT_END_frog:     
	sw $t1, 3072($a1)						
	sw $t1, 3076($a1)	
	sw $t1, 3108($a1)							
	sw $t1, 3112($a1)
	sw $t1, 3584($a1)						
	sw $t1, 3588($a1)	
	sw $t1, 3620($a1)							
	sw $t1, 3624($a1)	
	sw $t1, 4096($a1)						
	sw $t1, 4100($a1)	
	sw $t1, 4132($a1)							
	sw $t1, 4136($a1)
	sw $t1, 4608($a1)						
	sw $t1, 4612($a1)	
	sw $t1, 4644($a1)							
	sw $t1, 4648($a1)	
	jr $ra

print_frog_left:
	
sw $t1, 0($a1)
sw $t1, 4($a1)
sw $t1, 8($a1)
sw $t1, 12($a1)
sw $t1, 28($a1)
sw $t1, 32($a1)
sw $t1, 36($a1)
sw $t1, 40($a1)

sw $t1, 512($a1)
sw $t1, 516($a1)
sw $t1, 520($a1)
sw $t1, 524($a1)
sw $t1, 540($a1)
sw $t1, 544($a1)
sw $t1, 548($a1)
sw $t1, 552($a1)

sw $t1, 1036($a1)
sw $t1, 1040($a1)
sw $t1, 1044($a1)
sw $t1, 1048($a1)
sw $t1, 1052($a1)
sw $t1, 1056($a1)
sw $t1, 1060($a1)

sw $t1, 1548($a1)
sw $t1, 1552($a1)
sw $t1, 1556($a1)
sw $t1, 1560($a1)
sw $t1, 1564($a1)
sw $t1, 1568($a1)
sw $t1, 1572($a1)

sw $t1, 2060($a1)
sw $t1, 2064($a1)
sw $t1, 2068($a1)
sw $t1, 2072($a1)
sw $t1, 2076($a1)
sw $t1, 2080($a1)
sw $t1, 2084($a1)

sw $t1, 2572($a1)
sw $t1, 2576($a1)
sw $t1, 2580($a1)
sw $t1, 2584($a1)
sw $t1, 2588($a1)
sw $t1, 2592($a1)
sw $t1, 2596($a1)

sw $t1, 3084($a1)
sw $t1, 3088($a1)
sw $t1, 3092($a1)
sw $t1, 3096($a1)
sw $t1, 3100($a1)
sw $t1, 3104($a1)
sw $t1, 3108($a1)

sw $t1, 3596($a1)
sw $t1, 3600($a1)
sw $t1, 3604($a1)
sw $t1, 3608($a1)
sw $t1, 3612($a1)
sw $t1, 3616($a1)
sw $t1, 3620($a1)

sw $t1, 4108($a1)
sw $t1, 4112($a1)
sw $t1, 4116($a1)
sw $t1, 4120($a1)
sw $t1, 4124($a1)
sw $t1, 4128($a1)
sw $t1, 4132($a1)

sw $t1, 4608($a1)
sw $t1, 4612($a1)
sw $t1, 4616($a1)
sw $t1, 4620($a1)
sw $t1, 4636($a1)
sw $t1, 4640($a1)
sw $t1, 4644($a1)
sw $t1, 4648($a1)

sw $t1, 5120($a1)
sw $t1, 5124($a1)
sw $t1, 5128($a1)
sw $t1, 5132($a1)
sw $t1, 5148($a1)
sw $t1, 5152($a1)
sw $t1, 5156($a1)
sw $t1, 5160($a1)
	jr $ra
	
print_frog_right:	
sw $t1, 0($a1)
sw $t1, 4($a1)
sw $t1, 8($a1)
sw $t1, 12($a1)
sw $t1, 28($a1)
sw $t1, 32($a1)
sw $t1, 36($a1)
sw $t1, 40($a1)

sw $t1, 512($a1)
sw $t1, 516($a1)
sw $t1, 520($a1)
sw $t1, 524($a1)
sw $t1, 540($a1)
sw $t1, 544($a1)
sw $t1, 548($a1)
sw $t1, 552($a1)

sw $t1, 4608($a1)
sw $t1, 4612($a1)
sw $t1, 4616($a1)
sw $t1, 4620($a1)
sw $t1, 4636($a1)
sw $t1, 4640($a1)
sw $t1, 4644($a1)
sw $t1, 4648($a1)

sw $t1, 5120($a1)
sw $t1, 5124($a1)
sw $t1, 5128($a1)
sw $t1, 5132($a1)
sw $t1, 5148($a1)
sw $t1, 5152($a1)
sw $t1, 5156($a1)
sw $t1, 5160($a1)
# body
sw $t1, 1028($a1)
sw $t1, 1032($a1)
sw $t1, 1036($a1)
sw $t1, 1040($a1)
sw $t1, 1044($a1)
sw $t1, 1048($a1)
sw $t1, 1052($a1)

sw $t1, 1540($a1)
sw $t1, 1544($a1)
sw $t1, 1548($a1)
sw $t1, 1552($a1)
sw $t1, 1556($a1)
sw $t1, 1560($a1)
sw $t1, 1564($a1)

sw $t1, 2052($a1)
sw $t1, 2056($a1)
sw $t1, 2060($a1)
sw $t1, 2064($a1)
sw $t1, 2068($a1)
sw $t1, 2072($a1)
sw $t1, 2076($a1)

sw $t1, 2564($a1)
sw $t1, 2568($a1)
sw $t1, 2572($a1)
sw $t1, 2576($a1)
sw $t1, 2580($a1)
sw $t1, 2584($a1)
sw $t1, 2588($a1)

sw $t1, 3076($a1)
sw $t1, 3080($a1)
sw $t1, 3084($a1)
sw $t1, 3088($a1)
sw $t1, 3092($a1)
sw $t1, 3096($a1)
sw $t1, 3100($a1)

sw $t1, 3588($a1)
sw $t1, 3592($a1)
sw $t1, 3596($a1)
sw $t1, 3600($a1)
sw $t1, 3604($a1)
sw $t1, 3608($a1)
sw $t1, 3612($a1)

sw $t1, 4100($a1)
sw $t1, 4104($a1)
sw $t1, 4108($a1)
sw $t1, 4112($a1)
sw $t1, 4116($a1)
sw $t1, 4120($a1)
sw $t1, 4124($a1)
jr $ra

print_frog_down:
sw $t1, 0($a1)
	sw $t1, 4($a1)
	sw $t1, 36($a1)
	sw $t1, 40($a1)
	sw $t1, 512($a1)
	sw $t1, 516($a1)
	sw $t1, 548($a1)
	sw $t1, 552($a1)
	sw $t1, 1024($a1)
	sw $t1, 1028($a1)
	sw $t1, 1060($a1)
	sw $t1, 1064($a1)
	sw $t1, 1536($a1)
	sw $t1, 1540($a1)
	sw $t1, 1572($a1)
	sw $t1, 1576($a1)
	
	addi $t7, $a1, 520 # start square
    	addi $t6, $a1, 548	
    	addi $t5, $a1, 3108			   	
	Frog_loopdown1: ble $t5, $t7, OUT_END_frogdown
    		Frog_loopdown2: ble $t6, $t7, END_frogdown
   			sw $t1,($t7)
    			addi $t7, $t7, 4 # start = start + 4
    		j Frog_loopdown2				
	END_frogdown:
		addi $t7, $t7, 484
    		addi $t6, $t6, 512 
		j Frog_loopdown1	
	OUT_END_frogdown:     
	sw $t1, 3072($a1)						
	sw $t1, 3076($a1)	
	sw $t1, 3108($a1)							
	sw $t1, 3112($a1)
	sw $t1, 3584($a1)						
	sw $t1, 3588($a1)	
	sw $t1, 3620($a1)							
	sw $t1, 3624($a1)	
	sw $t1, 4096($a1)						
	sw $t1, 4100($a1)	
	sw $t1, 4132($a1)							
	sw $t1, 4136($a1)
	sw $t1, 4608($a1)						
	sw $t1, 4612($a1)	
	sw $t1, 4644($a1)							
	sw $t1, 4648($a1)	
	jr $ra

# a1: car position	
print_car:
	addi $t7, $a1, 0 # start square
    	addi $t6, $a1, 88	
    	addi $t5, $a1, 5208			   	
	Car_loop1: ble $t5, $t7, OUT_END_Car
    		Car_loop2: ble $t6, $t7, END_Car
   			sw $t1,($t7)
    			addi $t7, $t7, 4 # start = start + 4
    		j Car_loop2				
	END_Car:
		addi $t7, $t7, 424
    		addi $t6, $t6, 512 
		j Car_loop1	
	OUT_END_Car:
	jr $ra
	     
# a1: log position	
print_log:
	addi $t7, $a1, 0 # start square
    	addi $t6, $a1, 240	
    	addi $t5, $a1, 5360		   	
	Log_loop1: ble $t5, $t7, OUT_END_Log
    		Log_loop2: ble $t6, $t7, END_Log
   			sw $t1,($t7)
    			addi $t7, $t7, 4 # start = start + 4
    		j Log_loop2				
	END_Log:
		addi $t7, $t7, 272
    		addi $t6, $t6, 512 
		j Log_loop1	
	OUT_END_Log:
	jr $ra

							
																	
																																	
print_score:
    sw  $t1, 4($t0) # letter S
    sw  $t1, 8($t0)
    sw  $t1, 12($t0)
    sw  $t1, 512($t0)
    sw  $t1, 1028($t0)
    sw  $t1, 1032($t0)
    sw  $t1, 1548($t0)
    sw  $t1, 2056($t0)
    sw  $t1, 2052($t0)
    sw  $t1, 2048($t0)
    sw  $t1, 24($t0) # letter C
    sw  $t1, 28($t0)
    sw  $t1, 32($t0)
    sw  $t1, 532($t0)
    sw  $t1, 1044($t0)
    sw  $t1, 1556($t0)
    sw  $t1, 2072($t0)
    sw  $t1, 2076($t0)
    sw  $t1, 2080($t0)
    sw  $t1, 44($t0) # letter O
    sw  $t1, 48($t0)
    sw  $t1, 552($t0)
    sw  $t1, 564($t0)
    sw  $t1, 1064($t0)
    sw  $t1, 1076($t0)
    sw  $t1, 1576($t0)
    sw  $t1, 1588($t0)
    sw  $t1, 2092($t0)
    sw  $t1, 2096($t0)
    sw  $t1, 60($t0) # letter R
    sw  $t1, 64($t0)
    sw  $t1, 68($t0)
    sw  $t1, 572($t0)
    sw  $t1, 584($t0)
    sw  $t1, 1084($t0)
    sw  $t1, 1088($t0)
    sw  $t1, 1092($t0)
    sw  $t1, 1596($t0)
    sw  $t1, 1604($t0)
    sw  $t1, 2108($t0)
    sw  $t1, 2120($t0)
    sw  $t1, 80($t0) # letter E
    sw  $t1, 84($t0)
    sw  $t1, 88($t0)
    sw  $t1, 92($t0)
    sw  $t1, 592($t0)
    sw  $t1, 1104($t0)
    sw  $t1, 1108($t0)
    sw  $t1, 1112($t0)
    sw  $t1, 1616($t0)
    sw  $t1, 2128($t0)
    sw  $t1, 2132($t0)
    sw  $t1, 2136($t0)
    sw  $t1, 2140($t0)
    
    jr $ra

print_time:
    sw  $t1, 63424($t0) #letter T
    sw  $t1, 63420($t0)
    sw  $t1, 63932($t0)
    sw  $t1, 64444($t0)
    sw  $t1, 64956($t0)
    sw  $t1, 65468($t0)
    sw  $t1, 63416($t0)
    sw  $t1, 65488($t0) # letter I
    sw  $t1, 65484($t0)
    sw  $t1, 64972($t0)
    sw  $t1, 64460($t0)
    sw  $t1, 63948($t0)
    sw  $t1, 63436($t0)
    sw  $t1, 63440($t0)
    sw  $t1, 63432($t0)
    sw  $t1, 65480($t0)
    sw  $t1, 65512($t0) # letter M
    sw  $t1, 65000($t0)
    sw  $t1, 64488($t0)
    sw  $t1, 64480($t0)
    sw  $t1, 63976($t0)
    sw  $t1, 63972($t0)
    sw  $t1, 63964($t0)
    sw  $t1, 63960($t0)
    sw  $t1, 63448($t0)
    sw  $t1, 64472($t0)
    sw  $t1, 64984($t0)
    sw  $t1, 65496($t0)
    sw  $t1, 63464($t0)
    sw  $t1, 65532($t0) #letter E
    sw  $t1, 65528($t0)
    sw  $t1, 65524($t0)
    sw  $t1, 65520($t0)
    sw  $t1, 65008($t0)
    sw  $t1, 64496($t0)
    sw  $t1, 64500($t0)
    sw  $t1, 64504($t0)
    sw  $t1, 63984($t0)
    sw  $t1, 63472($t0)
    sw  $t1, 63476($t0)
    sw  $t1, 63480($t0)
    sw  $t1, 63484($t0)
    jr $ra


