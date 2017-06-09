.text

main:   lui $9, 0x1001
        addi $12, $0, 64
     addi $10, $0, 0xffff0000 # $10=0x000000ff
        addi $13, $0, 32
test0:  beq $13, $0, fim
test:   beq $12, $0, sai
        
        sw $10, 0($9)
        addi $10, $10, -4 # $10=0x000000ff
        addi $9, $9, 4
        addi $12, $12, -1
        j test
sai:    addi $10, $0, 0xff # $10=0x000000ff
        addi $12, $0, 64
        addi $13, $13, -1        
        j test0
fim:    nop
