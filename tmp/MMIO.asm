 
.text
main: lui $9, 0xffff  	# aonde o mapeamento de teclas pressionadas ocorre (aí e nele +4)
      addi $20, $0, 70  # define escape key
leu:  lw $10, 0($9)	# controla se algo está sendo pressionado
      beq $10, $0, nada # se nada estiver pressionado, repete a operacao
      lw $11, 4($9) 	# poe o que tiver no 11 no slot de ler a tecla pressionada
      beq $11, $20, fim # se 11 for escape key, sai
      add $4, $0, $11 	# 11 vai com argumento p printar (4)
      addi $2, $0, 11 	# print on screen
      syscall    
nada: j leu 
fim:  addi $2, $0, 10
      syscall         
