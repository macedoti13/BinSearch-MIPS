.text
.globl main

main:
	la	$a0, a			# coloca em $a0 a posi��o de mem�ria do vetor a 
	la	$a1, prim		# coloca em $a1 a posi��o de mem�ria da vari�vel prim
	la	$a2, ult		# coloca em $a2 a posi��o de mem�ria da vari�vel ult
	la	$a3, valor		# coloca em $a3 a posi��o de mem�ria da vari�vel valor
	addiu	$sp, $sp, -12		# abre espa�o de 12 bytes na pilha
	sw	$a0, 0($sp)		# armazena (push) o valor de $a0 na primeira posi��o da pilha
	sw 	$a1, 4($sp)		# armazena (push) o valor de $a1 na segunda posi��o da pilha
	sw	$a2, 8($sp)		# armazena (push) o valor de $a2 na terceira posi��o da pilha
	sw	$a3, 12($sp)		# armazena (push) o valor de $a3 na quarta posi��o da pilha
	jal	binSearch		# chama a fun��o binSearch

binSearch:
	addiu 	$sp, $sp, -4		# abre mais 4 bytes na pilha
	sw	$ra, 0($sp)		# guarda o valor de $ra na primeira posi��o da pilha
	lw	$a0, 4($sp)		# recupera (pop) o valor de $a0 da segunda posi��o da pilha
	lw	$a1, 8($sp)		# recupera (pop) o valor de $a1 da terceira posi��o da pilha
	lw	$a2, 12($sp)		# recupera (pop) o valor de $a2 da quarta posi��o da pilha
	lw	$a3, 16($sp)		# recupera (pop) o valor de $a3 da quinta posi��o da pilha
	lw	$a1, 0($a1)    		# carrega o valor da vari�vel prim
	lw	$a2, 0($a2)		# carrega o valor da vari�vel ult
	lw	$a3, 0($a3)		# carrega o valor da vari�vel valor
	blt	$a2, $a1, inexistente	# se o valor de ult for menot que o de prim: pula para inexistente
	addu	$t0, $a1, $a2		# somamos em $t0 o valor das vari�veis prim e ult
	divu	$t0, $t0, 2		# dividimos $t0 por 2 para pegar o index do meio do vetor
	mulu	$t1, $t0, 4		# deslocamento de mem�ria
	addu	$t1, $a0, $t1		# soma do deslocamento + local do vetor
	lw	$t1, 0($t1)		# adcionamos em $t1 o valor do meio do vetor
	addu	$a0, $zero, $t0		# $a0 recebe o index do meio
	beq	$t1, $a3, fim		# se o valor do meio do vetor for igual o valor em que procuramos, pula para o fim		
	blt	$t1, $a3, maior		# se o valor do meio for maior que o valor que procuramos, pula para maior
	#volta valor do $ra
	bgt	$t1, $a3, menor		# se o valor do meio for menor que o valor que procuramos, pula para menor
	#volta valor do $ra
menor:
	#abre espa�o na pilha
	#salvar novo valor do $ra
	#novas intru��es
	#chama a fun��o binSearch
	#recupera o valor de $ra 
	#acerta o ponteiro da pilha
	#volta pro $ra
	
maior:

inexistente:
	addiu	$sp, $sp, 16		# Limpa a pilha
	addiu	$a0, $zero, -1		# $a0 recebe -1
	j	fim			# pula para fim
	
fim:
	li	$v0, 1			# define $v0 para imprimir um inteiro
	syscall	

	.data
a:	.word	-5 -1 5 9 12 15 21 29 31 250 325	# vetor a
prim:	.word	0					# index do primeiro parametro do vetor a
ult:	.word	11					# index do ultimo parametro do vetor a
valor:	.word	21					# valor a ser encontrado no vetor
