	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	foo
	.type	foo, @function
foo:
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -8[rbp], xmm0 # по смещению -8 на стеке храним переменную a
	movsd	QWORD PTR -16[rbp], xmm1 # # по смещению -16 на стеке храним переменную b
	movsd	QWORD PTR -24[rbp], xmm2 # # по смещению -24 на стеке храним переменную x
	movsd	xmm0, QWORD PTR -16[rbp]
	mulsd	xmm0, QWORD PTR -24[rbp]
	mulsd	xmm0, QWORD PTR -24[rbp]
	mulsd	xmm0, QWORD PTR -24[rbp]
	addsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax # кладем возвращаемое значение в регистр xmm0
	pop	rbp
	ret
	.size	foo, .-foo
	.globl	getD
	.type	getD, @function
getD:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	movsd	QWORD PTR -40[rbp], xmm0 # по смещению -40 на стеке храним переменную a
	movsd	QWORD PTR -48[rbp], xmm1 # по смещению -48 на стеке храним переменную b
	movsd	QWORD PTR -56[rbp], xmm2 # по смещению -56 на стеке храним переменную right
	movsd	QWORD PTR -64[rbp], xmm3 # по смещению -64 на стеке храним переменную left
	pxor	xmm0, xmm0
	comisd	xmm0, QWORD PTR -48[rbp]
	jbe	.L4
	movsd	xmm0, QWORD PTR -48[rbp]
	movq	xmm1, QWORD PTR .LC1[rip]
	xorpd	xmm0, xmm1
	movsd	QWORD PTR -48[rbp], xmm0
.L4:
	pxor	xmm0, xmm0
	ucomisd	xmm0, QWORD PTR -48[rbp]
	jp	.L6
	pxor	xmm0, xmm0
	ucomisd	xmm0, QWORD PTR -48[rbp]
	jne	.L6
	movsd	xmm0, QWORD PTR -56[rbp]
	subsd	xmm0, QWORD PTR -64[rbp]
	movsd	xmm1, QWORD PTR .LC2[rip]
	divsd	xmm0, xmm1
	jmp	.L8
.L6:
	movsd	xmm1, QWORD PTR -56[rbp]
	movsd	xmm0, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movapd	xmm2, xmm1 # загрузили параметр x (right)
	movapd	xmm1, xmm0 # загрузили параметр b
	movq	xmm0, rax # загрузили параметр a
	call	foo
	movq	rax, xmm0 # выгрузили полученное значение
	mov	QWORD PTR -24[rbp], rax # по смещению -24 на стеке храним переменную right_res
	movsd	xmm0, QWORD PTR -56[rbp]
	subsd	xmm0, QWORD PTR -64[rbp]
	movsd	QWORD PTR -16[rbp], xmm0 # по смещению -16 на стеке храним переменную len
	movsd	xmm0, QWORD PTR .LC3[rip]
	movsd	QWORD PTR -32[rbp], xmm0 # по смещению -32 на стеке храним переменную d
	jmp	.L9
.L10:
	movsd	xmm0, QWORD PTR -32[rbp]
	movsd	xmm1, QWORD PTR .LC4[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -32[rbp], xmm0
.L9:
	movsd	xmm0, QWORD PTR -56[rbp]
	movapd	xmm1, xmm0
	subsd	xmm1, QWORD PTR -32[rbp]
	movsd	xmm0, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movapd	xmm2, xmm1 # загрузили параметр x (right - d)
	movapd	xmm1, xmm0 # загрузили параметр b
	movq	xmm0, rax # загрузили параметр а
	call	foo
	movapd	xmm1, xmm0 # выгрузили полученное значение
	movsd	xmm0, QWORD PTR -24[rbp]
	subsd	xmm0, xmm1
	mulsd	xmm0, QWORD PTR -16[rbp]
	comisd	xmm0, QWORD PTR .LC5[rip]
	ja	.L10
	movsd	xmm1, QWORD PTR -64[rbp]
	movsd	xmm0, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movapd	xmm2, xmm1 # загрузили параметр x (left)
	movapd	xmm1, xmm0 # загрузили параметр b
	movq	xmm0, rax # загрузили параметр a
	call	foo
	movq	rax, xmm0 # выгрузили полученное значение
	mov	QWORD PTR -8[rbp], rax # по смещению -8 на стеке храним переменную left_res
	jmp	.L11
.L12:
	movsd	xmm0, QWORD PTR -32[rbp]
	movsd	xmm1, QWORD PTR .LC4[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -32[rbp], xmm0
.L11:
	movsd	xmm0, QWORD PTR -64[rbp]
	movapd	xmm1, xmm0
	addsd	xmm1, QWORD PTR -32[rbp]
	movsd	xmm0, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movapd	xmm2, xmm1 # загрузили параметр x (left + d)
	movapd	xmm1, xmm0 # загрузили параметр b
	movq	xmm0, rax # загрузили параметр a
	call	foo
	movq	rax, xmm0 #  выгрузили полученное значение
	movq	xmm0, rax # компилятор почему-то вдруг начинает сомневаться, откуда ему придет выходное значение. В действительности оно дублируется в xmm0 и rax
	subsd	xmm0, QWORD PTR -8[rbp]
	mulsd	xmm0, QWORD PTR -16[rbp]
	comisd	xmm0, QWORD PTR .LC5[rip]
	ja	.L12
	movsd	xmm0, QWORD PTR -32[rbp]
.L8:
	movq	rax, xmm0
	movq	xmm0, rax # возвращаемое значение кладем в регистр xmm0
	leave
	ret
	.size	getD, .-getD
	.section	.rodata
.LC6:
	.string	"%lf %lf"
.LC7:
	.string	"0"
.LC8:
	.string	"%lf\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	lea	rdx, -56[rbp] # храним по смещению -56 на стеке переменную b
	lea	rax, -64[rbp] # храним по смещению -64 на стеке переменную a
	mov	rsi, rax
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	lea	rdx, -40[rbp] # храним по смещению -40 на стеке переменную right
	lea	rax, -48[rbp] # храним по смещению -48 на стеке переменную left
	mov	rsi, rax
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	pxor	xmm0, xmm0
	movsd	QWORD PTR -32[rbp], xmm0 # храни по смещению -32 на стеке переменную result
	mov	DWORD PTR -68[rbp], 1 # храним по смещению -68 на стеке переменную minus
	movsd	xmm0, QWORD PTR -48[rbp]
	movsd	xmm1, QWORD PTR -40[rbp]
	ucomisd	xmm0, xmm1
	jp	.L16
	ucomisd	xmm0, xmm1
	jne	.L16
	lea	rax, .LC7[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L23
.L16:
	movsd	xmm0, QWORD PTR -48[rbp]
	movsd	xmm1, QWORD PTR -40[rbp]
	comisd	xmm0, xmm1
	jbe	.L19
	movsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -24[rbp], xmm0 # храним по смещению -24 на стеке переменную temp
	movsd	xmm0, QWORD PTR -48[rbp]
	movsd	QWORD PTR -40[rbp], xmm0
	movsd	xmm0, QWORD PTR -24[rbp]
	movsd	QWORD PTR -48[rbp], xmm0
	mov	DWORD PTR -68[rbp], -1
.L19:
	movsd	xmm2, QWORD PTR -48[rbp]
	movsd	xmm1, QWORD PTR -40[rbp]
	movsd	xmm0, QWORD PTR -56[rbp]
	mov	rax, QWORD PTR -64[rbp]
	movapd	xmm3, xmm2 # загружаем в регистр переменную left для передачи в функцию
	movapd	xmm2, xmm1 # загружаем в регистр переменную right для передачи в функцию
	movapd	xmm1, xmm0 # загружаем в регистр переменную b для передачи в функцию
	movq	xmm0, rax # загружаем в регистр переменную a для передачи в функцию
	call	getD
	movq	rax, xmm0 # выгружаем полученное значение
	mov	QWORD PTR -16[rbp], rax # храним переменную d по смещению -16 на стеке
	jmp	.L21
.L22:
	movsd	xmm1, QWORD PTR -48[rbp]
	movsd	xmm0, QWORD PTR -56[rbp]
	mov	rax, QWORD PTR -64[rbp]
	movapd	xmm2, xmm1 # загружаем в регистр переменную left для передачи в функцию
	movapd	xmm1, xmm0 # загружаем в регистр переменную b для передачи в функцию
	movq	xmm0, rax # загружаем в регистр переменную a для передачи в функцию
	call	foo
	movq	rax, xmm0 # выгружаем полученное значение
	movq	xmm0, rax
	mulsd	xmm0, QWORD PTR -16[rbp]
	movsd	xmm1, QWORD PTR -32[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -32[rbp], xmm0
	movsd	xmm0, QWORD PTR -48[rbp]
	addsd	xmm0, QWORD PTR -16[rbp]
	movsd	QWORD PTR -48[rbp], xmm0
.L21:
	movsd	xmm1, QWORD PTR -48[rbp]
	movsd	xmm0, QWORD PTR -40[rbp]
	comisd	xmm0, xmm1
	ja	.L22
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -68[rbp]
	movsd	xmm1, QWORD PTR -32[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -32[rbp], xmm0
	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rax
	lea	rax, .LC8[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0 # загружаем возвращаемое значение
.L23:
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L24
	call	__stack_chk_fail@PLT
.L24:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 16
.LC1:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC2:
	.long	0
	.long	1087604736
	.align 8
.LC3:
	.long	1202590843
	.long	1065646817
	.align 8
.LC4:
	.long	0
	.long	1073741824
	.align 8
.LC5:
	.long	-350469331
	.long	1058682594
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
