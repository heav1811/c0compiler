li $v0, 5
syscall
addi $sp, $sp, -4
la $t0, ($sp)
sw $v0, ($t0)
lw $t2, 0($sp)
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
li $t2, 0
la $t1, 4($sp)
sw $t2, ($t1)
lw $t2, 4($sp)
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
L0:
lw $t2, 0($sp)
lw $t3, 4($sp)
la $t1, 8($sp)
slt $t0, $t2, $t3
sw $t0, ($t1)
lw $t0, 8($sp)
beqz $t0, L1
li $t2, 0
la $t1, 8($sp)
sw $t2, ($t1)
lw $t2, 8($sp)
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
L2:
lw $t2, 8($sp)
lw $t3, 4($sp)
addi $sp, $sp, -4
la $t1, ($sp)
sub $t0, $t2, $t3
sw $t0, ($t1)
li $t2, 1
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
lw $t2, 4($sp)
lw $t3, 0($sp)
addi $sp, $sp, -4
la $t1, ($sp)
sub $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 12($sp)
lw $t3, 0($sp)
la $t1, 24($sp)
slt $t0, $t2, $t3
sw $t0, ($t1)
lw $t0, 24($sp)
beqz $t0, L3
li $t2, 1
la $t1, 24($sp)
sw $t2, ($t1)
lw $t0, 24($sp)
li $v0, 1
move $a0, $t0
syscall
li $t2, 1
la $t1, 0($sp)
sw $t2, ($t1)
lw $t2, 12($sp)
lw $t3, 0($sp)
la $t1, 24($sp)
add $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 24($sp)
la $t1, 12($sp)
sw $t2, ($t1)
addi $sp, $sp, 12
j L2
L3:
addi $sp, $sp, 12
li $t2, 0
la $t1, 12($sp)
sw $t2, ($t1)
lw $t2, 12($sp)
la $t1, 0($sp)
sw $t2, ($t1)
L5:
li $t2, 2
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
lw $t2, 8($sp)
lw $t3, 0($sp)
addi $sp, $sp, -4
la $t1, ($sp)
mul $t0, $t2, $t3
sw $t0, ($t1)
li $t2, 1
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
lw $t2, 4($sp)
lw $t3, 0($sp)
addi $sp, $sp, -4
la $t1, ($sp)
add $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 16($sp)
lw $t3, 0($sp)
la $t1, 28($sp)
slt $t0, $t2, $t3
sw $t0, ($t1)
lw $t0, 28($sp)
beqz $t0, L6
li $t2, 0
la $t1, 28($sp)
sw $t2, ($t1)
lw $t0, 28($sp)
li $v0, 1
move $a0, $t0
syscall
li $t2, 1
la $t1, 0($sp)
sw $t2, ($t1)
lw $t2, 16($sp)
lw $t3, 0($sp)
la $t1, 28($sp)
add $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 28($sp)
la $t1, 16($sp)
sw $t2, ($t1)
addi $sp, $sp, 16
j L5
L6:
addi $sp, $sp, 16
li $t2, 0
la $t1, 12($sp)
sw $t2, ($t1)
lw $t2, 12($sp)
la $t1, 0($sp)
sw $t2, ($t1)
L8:
lw $t2, 8($sp)
lw $t3, 4($sp)
addi $sp, $sp, -4
la $t1, ($sp)
sub $t0, $t2, $t3
sw $t0, ($t1)
li $t2, 1
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
lw $t2, 4($sp)
lw $t3, 0($sp)
addi $sp, $sp, -4
la $t1, ($sp)
sub $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 12($sp)
lw $t3, 0($sp)
la $t1, 24($sp)
slt $t0, $t2, $t3
sw $t0, ($t1)
lw $t0, 24($sp)
beqz $t0, L9
li $t2, 1
la $t1, 24($sp)
sw $t2, ($t1)
lw $t0, 24($sp)
li $v0, 1
move $a0, $t0
syscall
li $t2, 1
la $t1, 0($sp)
sw $t2, ($t1)
lw $t2, 12($sp)
lw $t3, 0($sp)
la $t1, 24($sp)
add $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 24($sp)
la $t1, 12($sp)
sw $t2, ($t1)
addi $sp, $sp, 12
j L8
L9:
addi $sp, $sp, 12
la $a0, lc
li $v0, 4
syscall
li $t2, 1
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
lw $t2, 8($sp)
lw $t3, 0($sp)
la $t1, 16($sp)
add $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 16($sp)
la $t1, 8($sp)
sw $t2, ($t1)
addi $sp, $sp, 8
j L0
L1:
addi $sp, $sp, 0
li $t2, 1
la $t1, 8($sp)
sw $t2, ($t1)
lw $t2, 8($sp)
la $t1, 0($sp)
sw $t2, ($t1)
li $t2, 0
la $t1, 8($sp)
sw $t2, ($t1)
lw $t2, 8($sp)
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
L12:
lw $t2, 8($sp)
lw $t3, 4($sp)
addi $sp, $sp, -4
la $t1, ($sp)
sub $t0, $t2, $t3
sw $t0, ($t1)
li $t2, 1
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
lw $t2, 4($sp)
lw $t3, 0($sp)
addi $sp, $sp, -4
la $t1, ($sp)
sub $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 12($sp)
lw $t3, 0($sp)
la $t1, 24($sp)
slt $t0, $t2, $t3
sw $t0, ($t1)
lw $t0, 24($sp)
beqz $t0, L13
li $t2, 1
la $t1, 24($sp)
sw $t2, ($t1)
lw $t0, 24($sp)
li $v0, 1
move $a0, $t0
syscall
li $t2, 1
la $t1, 0($sp)
sw $t2, ($t1)
lw $t2, 12($sp)
lw $t3, 0($sp)
la $t1, 24($sp)
add $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 24($sp)
la $t1, 12($sp)
sw $t2, ($t1)
addi $sp, $sp, 12
j L12
L13:
addi $sp, $sp, 12
li $t2, 0
la $t1, 12($sp)
sw $t2, ($t1)
lw $t2, 12($sp)
la $t1, 0($sp)
sw $t2, ($t1)
L15:
li $t2, 2
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
lw $t2, 8($sp)
lw $t3, 0($sp)
addi $sp, $sp, -4
la $t1, ($sp)
mul $t0, $t2, $t3
sw $t0, ($t1)
li $t2, 1
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
lw $t2, 4($sp)
lw $t3, 0($sp)
addi $sp, $sp, -4
la $t1, ($sp)
add $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 16($sp)
lw $t3, 0($sp)
la $t1, 28($sp)
slt $t0, $t2, $t3
sw $t0, ($t1)
lw $t0, 28($sp)
beqz $t0, L16
li $t2, 0
la $t1, 28($sp)
sw $t2, ($t1)
lw $t0, 28($sp)
li $v0, 1
move $a0, $t0
syscall
li $t2, 1
la $t1, 0($sp)
sw $t2, ($t1)
lw $t2, 16($sp)
lw $t3, 0($sp)
la $t1, 28($sp)
add $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 28($sp)
la $t1, 16($sp)
sw $t2, ($t1)
addi $sp, $sp, 16
j L15
L16:
addi $sp, $sp, 16
li $t2, 0
la $t1, 12($sp)
sw $t2, ($t1)
lw $t2, 12($sp)
la $t1, 0($sp)
sw $t2, ($t1)
L18:
lw $t2, 8($sp)
lw $t3, 4($sp)
addi $sp, $sp, -4
la $t1, ($sp)
sub $t0, $t2, $t3
sw $t0, ($t1)
li $t2, 1
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
lw $t2, 4($sp)
lw $t3, 0($sp)
addi $sp, $sp, -4
la $t1, ($sp)
sub $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 12($sp)
lw $t3, 0($sp)
la $t1, 24($sp)
slt $t0, $t2, $t3
sw $t0, ($t1)
lw $t0, 24($sp)
beqz $t0, L19
li $t2, 1
la $t1, 24($sp)
sw $t2, ($t1)
lw $t0, 24($sp)
li $v0, 1
move $a0, $t0
syscall
li $t2, 1
la $t1, 0($sp)
sw $t2, ($t1)
lw $t2, 12($sp)
lw $t3, 0($sp)
la $t1, 24($sp)
add $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 24($sp)
la $t1, 12($sp)
sw $t2, ($t1)
addi $sp, $sp, 12
j L18
L19:
addi $sp, $sp, 12
la $a0, lc
li $v0, 4
syscall
li $t2, 1
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
lw $t2, 12($sp)
lw $t3, 0($sp)
la $t1, 16($sp)
sub $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 16($sp)
la $t1, 8($sp)
sw $t2, ($t1)
li $t2, 0
la $t1, 16($sp)
sw $t2, ($t1)
lw $t2, 16($sp)
la $t1, 4($sp)
sw $t2, ($t1)
L21:
lw $t2, 12($sp)
lw $t3, 8($sp)
addi $sp, $sp, -4
la $t1, ($sp)
sub $t0, $t2, $t3
sw $t0, ($t1)
li $t2, 1
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
lw $t2, 4($sp)
lw $t3, 0($sp)
la $t1, 8($sp)
sub $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 12($sp)
lw $t3, 8($sp)
la $t1, 24($sp)
slt $t0, $t2, $t3
sw $t0, ($t1)
lw $t0, 24($sp)
beqz $t0, L22
li $t2, 1
la $t1, 24($sp)
sw $t2, ($t1)
lw $t0, 24($sp)
li $v0, 1
move $a0, $t0
syscall
li $t2, 1
la $t1, 8($sp)
sw $t2, ($t1)
lw $t2, 12($sp)
lw $t3, 8($sp)
la $t1, 24($sp)
add $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 24($sp)
la $t1, 12($sp)
sw $t2, ($t1)
addi $sp, $sp, 8
j L21
L22:
addi $sp, $sp, 8
li $t2, 0
la $t1, 16($sp)
sw $t2, ($t1)
lw $t2, 16($sp)
la $t1, 4($sp)
sw $t2, ($t1)
L24:
li $t2, 2
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
lw $t2, 12($sp)
lw $t3, 0($sp)
addi $sp, $sp, -4
la $t1, ($sp)
mul $t0, $t2, $t3
sw $t0, ($t1)
li $t2, 1
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
lw $t2, 4($sp)
lw $t3, 0($sp)
la $t1, 12($sp)
add $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 16($sp)
lw $t3, 12($sp)
la $t1, 28($sp)
slt $t0, $t2, $t3
sw $t0, ($t1)
lw $t0, 28($sp)
beqz $t0, L25
li $t2, 0
la $t1, 28($sp)
sw $t2, ($t1)
lw $t0, 28($sp)
li $v0, 1
move $a0, $t0
syscall
li $t2, 1
la $t1, 12($sp)
sw $t2, ($t1)
lw $t2, 16($sp)
lw $t3, 12($sp)
la $t1, 28($sp)
add $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 28($sp)
la $t1, 16($sp)
sw $t2, ($t1)
addi $sp, $sp, 12
j L24
L25:
addi $sp, $sp, 12
li $t2, 0
la $t1, 16($sp)
sw $t2, ($t1)
lw $t2, 16($sp)
la $t1, 4($sp)
sw $t2, ($t1)
L27:
lw $t2, 12($sp)
lw $t3, 8($sp)
addi $sp, $sp, -4
la $t1, ($sp)
sub $t0, $t2, $t3
sw $t0, ($t1)
li $t2, 1
addi $sp, $sp, -4
la $t1, ($sp)
sw $t2, ($t1)
lw $t2, 4($sp)
lw $t3, 0($sp)
la $t1, 8($sp)
sub $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 12($sp)
lw $t3, 8($sp)
la $t1, 24($sp)
slt $t0, $t2, $t3
sw $t0, ($t1)
lw $t0, 24($sp)
beqz $t0, L28
li $t2, 1
la $t1, 24($sp)
sw $t2, ($t1)
lw $t0, 24($sp)
li $v0, 1
move $a0, $t0
syscall
li $t2, 1
la $t1, 8($sp)
sw $t2, ($t1)
lw $t2, 12($sp)
lw $t3, 8($sp)
la $t1, 24($sp)
add $t0, $t2, $t3
sw $t0, ($t1)
lw $t2, 24($sp)
la $t1, 12($sp)
sw $t2, ($t1)
addi $sp, $sp, 8
j L27
L28:
addi $sp, $sp, 8
la $a0, lc
li $v0, 4
syscall
.data
lc:.asciiz "\n"
