	.file	"gcd.c"
	.text
	.section	.rodata
.LC0:
	.string	"Bad Number.\n"
	.text
	.globl	getInt
	.type	getInt, @function
getInt:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	$1, -24(%rbp)
	movl	$0, -20(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, -16(%rbp)
	jmp	.L2
.L3:
	addq	$1, -16(%rbp)
.L2:
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$10, %al
	jne	.L3
	subq	$1, -16(%rbp)
	jmp	.L4
.L9:
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L11
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$47, %al
	jle	.L7
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$57, %al
	jle	.L8
.L7:
	leaq	.LC0(%rip), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	$12, %edx
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	movl	$0, %edi
	call	exit@PLT
.L8:
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	subl	$48, %eax
	imull	-24(%rbp), %eax
	addl	%eax, -20(%rbp)
	movl	-24(%rbp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	movl	%eax, -24(%rbp)
	subq	$1, -16(%rbp)
.L4:
	movq	-16(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jnb	.L9
	jmp	.L6
.L11:
	nop
.L6:
	movl	-20(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	getInt, .-getInt
	.globl	makeDecimal
	.type	makeDecimal, @function
makeDecimal:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-36(%rbp), %ecx
	movl	$-858993459, %edx
	movl	%ecx, %eax
	mull	%edx
	shrl	$3, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, -16(%rbp)
	movl	-36(%rbp), %eax
	movl	$-858993459, %edx
	mull	%edx
	movl	%edx, %eax
	shrl	$3, %eax
	movl	%eax, -12(%rbp)
	cmpl	$0, -12(%rbp)
	je	.L13
	movl	-12(%rbp), %eax
	movl	%eax, %edi
	call	makeDecimal
.L13:
	movl	-16(%rbp), %eax
	addl	$48, %eax
	movb	%al, -17(%rbp)
	leaq	-17(%rbp), %rax
	movl	$1, %edx
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L14
	call	__stack_chk_fail@PLT
.L14:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	makeDecimal, .-makeDecimal
	.section	.rodata
.LC1:
	.string	"Enter a positive integer: "
	.text
	.globl	readNumber
	.type	readNumber, @function
readNumber:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	.LC1(%rip), %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movl	$26, %edx
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	leaq	-32(%rbp), %rax
	movl	$20, %edx
	movq	%rax, %rsi
	movl	$0, %edi
	call	read@PLT
	leaq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	getInt
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L17
	call	__stack_chk_fail@PLT
.L17:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	readNumber, .-readNumber
	.globl	gcd
	.type	gcd, @function
gcd:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jbe	.L19
	movl	-4(%rbp), %eax
	subl	-8(%rbp), %eax
	movl	-8(%rbp), %edx
	movl	%edx, %esi
	movl	%eax, %edi
	call	gcd
	jmp	.L20
.L19:
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jnb	.L21
	movl	-8(%rbp), %eax
	subl	-4(%rbp), %eax
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	gcd
	jmp	.L20
.L21:
	movl	-4(%rbp), %eax
.L20:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	gcd, .-gcd
	.section	.rodata
.LC2:
	.string	"%d\n"
.LC3:
	.string	"Greatest common divisor = "
	.text
	.globl	main
	.type	main, @function
main:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movb	$10, -29(%rbp)
	movl	$0, %eax
	call	readNumber
	movl	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	call	readNumber
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %edx
	movl	-28(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	gcd
	movl	%eax, -20(%rbp)
	leaq	.LC3(%rip), %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movl	$26, %edx
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	movl	-20(%rbp), %eax
	movl	%eax, %edi
	call	makeDecimal
	leaq	-29(%rbp), %rax
	movl	$1, %edx
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	movl	$0, %edi
	call	exit@PLT
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
