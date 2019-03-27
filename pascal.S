main:
    addi    $a0, $zero, 10          # n = 10
    addi    $a1, $zero, 5           # m = 5
    addi    $s0, $zero, 1
    jal     pascal                  # call pascal(10, 5)

    j       exit

pascal:
    addi    $sp, $sp, -4
    sw      $ra, 0x0($sp)           # Save $ra register into stack
	beq		$a0, $a1, return1
	beq		$a1, $zero, return1
	
    addi    $sp, $sp, -4            # Make two Space for LU(0x0) and RU(0x4)

    # Save the LU space value
    addi    $a0, $a0, -1
    addi    $a1, $a1, -1
    jal     pascal
    sw      $v0, 0x0($sp)
    addi    $a0, $a0, 1
    addi    $a1, $a1, 1
    # Calc. the RU space value
    addi    $a0, $a0, -1
    jal     pascal
    addi    $a0, $a0, 1

    lw      $t0, 0x0($sp)
    add     $v0, $v0, $t0
    addi    $sp, $sp, 4             # Pop out the LURU space

	skip:
    lw      $ra, 0x0($sp)           # Load $ra register from stack
    addi    $sp, $sp, 4
    jr      $ra

return1:
	addi	$v0, $zero, 1
	j 		skip

exit:
