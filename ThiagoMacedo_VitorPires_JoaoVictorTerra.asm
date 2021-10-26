.text
.globl main

main:
	# Pega os valores iniciais
	la	$a0, a			# coloca em $a0 a posi��o de mem�ria do vetor a 
	la	$a1, prim		# coloca em $a1 a posi��o de mem�ria da vari�vel prim
	la	$a2, ult		# coloca em $a2 a posi��o de mem�ria da vari�vel ult
	la	$a3, valor		# coloca em $a3 a posi��o de mem�ria da vari�vel valor
	
	# Pega o valor das vari�veis  
	lw	$a1, 0($a1)    		# carrega o valor da vari�vel prim
	lw	$a2, 0($a2)		# carrega o valor da vari�vel ult
	lw	$a3, 0($a3)		# carrega o valor da vari�vel valor
	
	# Abre a pilha e salva os valores
	addiu	$sp, $sp, -12		# abre espa�o de 12 bytes na pilha
	sw	$a0, 0($sp)		# armazena (push) o valor de $a0 na primeira posi��o da pilha
	sw 	$a1, 4($sp)		# armazena (push) o valor de $a1 na segunda posi��o da pilha
	sw	$a2, 8($sp)		# armazena (push) o valor de $a2 na terceira posi��o da pilha
	sw	$a3, 12($sp)		# armazena (push) o valor de $a3 na quarta posi��o da pilha
	
	# Chama a fun��o
	jal	binSearch		# chama a fun��o binSearch



binSearch:
	# Pega os valores e limpa a pilha
	lw	$a0, 0($sp)		# recupera (pop) o valor de $a0 da segunda posi��o da pilha
	lw	$a1, 4($sp)		# recupera (pop) o valor de $a1 da terceira posi��o da pilha
	lw	$a2, 8($sp)		# recupera (pop) o valor de $a2 da quarta posi��o da pilha
	lw	$a3, 12($sp)		# recupera (pop) o valor de $a3 da quinta posi��o da pilha
	addiu	$sp, $sp, 12		# limpa a pilha

	# Salva o endere�o de retorno na pilha
	addiu 	$sp, $sp, -4		# abre mais 4 bytes na pilha
	sw	$ra, 0($sp)		# guarda o valor de $ra na primeira posi��o da pilha
	
	# Verifica se o valor do fim � menor que o valor do come�o
	blt	$a2, $a1, inexistente	# se o valor de ult for menot que o de prim: pula para inexistente
	
	# Calcula o valor do meio
	addu	$t0, $a1, $a2		# somamos em $t0 o valor das vari�veis prim e ult
	divu	$t0, $t0, 2		# dividimos $t0 por 2 para pegar o index do meio do vetor
	mulu	$t1, $t0, 4		# deslocamento de mem�ria
	addu	$t1, $a0, $t1		# soma do deslocamento + local do vetor
	lw	$t1, 0($t1)		# adcionamos em $t1 o valor do meio do vetor
	
	# Verifica se o valor do meio � igual o valor que estamos procurando
	beq	$t1, $a3, achou		# se o valor do meio do vetor for igual o valor em que procuramos, pula para o fim	
	
	# Verifica se o valor do meio � maior do que o valor que procuramos
	blt	$t1, $a3, maior		# se o valor do meio for maior que o valor que procuramos, pula para maior

	# Verifica se o valor do meio � menor do que o valor que procuramos
	bgt	$t1, $a3, menor		# se o valor do meio for menor que o valor que procuramos, pula para menor
	
	# Volta para o endere�o de retorno 
	lw	$ra, 0($sp)		# recupera o endere�o de retorno
	addiu	$sp, $sp, 4		# limpa a pilha
	jr	$ra			# volta para o endere�o de retorno
	
maior:
	addiu	$a1, $t0, 1		# muda o valor da vari�vel prim
	addiu	$sp, $sp, -12		# abre 12 bytes na pilha
	sw	$a0, 0($sp)		# armazena (push) o valor de $a0 na primeira posi��o da pilha
	sw	$a1, 4($sp)		# armazena (push) o valor de $a1 na segunda posi��o da pilha
	sw	$a2, 8($sp)		# armazena (push) o valor de $a2 na terceira posi��o da pilha
	sw	$a3, 12($sp)		# armazena (push) o valor de $a3 na quarta posi��o da pilha
	jal	binSearch		# chama a fun��o
	
menor:
	addiu	$a2, $t0, -1		# muda o valor da vari�vel ult
	addiu	$sp, $sp, -12		# abre 12 bytes na pilha
	sw	$a0, 0($sp)		# armazena (push) o valor de $a0 na primeira posi��o da pilha
	sw	$a1, 4($sp)		# armazena (push) o valor de $a1 na segunda posi��o da pilha
	sw	$a2, 8($sp)		# armazena (push) o valor de $a2 na terceira posi��o da pilha
	sw	$a3, 12($sp)		# armazena (push) o valor de $a3 na quarta posi��o da pilha
	jal	binSearch		# chama a fun��o
	
inexistente:
	addiu	$sp, $sp, 4		# Limpa a pilha
	addiu	$a0, $zero, -1		# $a0 recebe -1
	j	fim			# pula para fim
	
achou:
	addiu	$sp, $sp, 4
	addu	$a0, $zero, $t0 	# zeramos o $a0 e adicionamos o index do meio
	j	fim			# pula para o fim
	
fim:
	li	$v0, 1			# define $v0 para imprimir um inteiro
	syscall	

	.data
a:	.word	-5 -1 5 9 12 15 21 29 31 58 250 325	# vetor a
prim:	.word	0					# index do primeiro parametro do vetor a
ult:	.word	11					# index do ultimo parametro do vetor a
valor:	.word	17					# valor que queremos encontrar