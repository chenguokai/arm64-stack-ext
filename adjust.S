.global _mvstk

_mvstk:
	sub sp, sp, #64 /* backup up to 8 regs */
	/* save x19 */
	str x19, [sp, #56]
	str x20, [sp, #48]
	str lr,  [sp, #40]

	mov x0, sp /* x0: temp register and first parameter */
	bl _alignUp /* x0 is updated to 4KB aligned stack bottom */
	mov x19, x0     /* x19: old stack bottom, callee saved */
	mov x4, sp
	sub x0, x0, x4 /* x0 is offset between current stack top and bottom */
	mov x20, x0 /* move offset to x20 in order to save our result */
	mov x0, #0x8000000 /* 128MB */
	bl _malloc         /* call malloc, x0 contains alloced space */
	/* start copying from old stack to new stack */
	mov x1, #0 /* x0: new stack bottom */
                   /* x1: copied count */
                   /* x19: old stack bottom */
                   /* x20: stack offset (count to be copied) */
	sub x19, x19, #8
	sub x0, x0, #8
loop:
	subs x3, x1, x20
	beq 1f
	ldr x5, [x19]
	str x5, [x0]
	sub x19, x19, #8
	sub x0, x0, #8
	add x1, x1, #8
	b loop
1:
	add x0, x0, #8
	mov sp, x0
	ldr x19, [sp, #56]
	ldr x20, [sp, #48]
	ldr lr,  [sp, #40]
	add sp, sp, #64
	ret
	
.global _getsp
_getsp:
	mov x0, sp
	ret
