# This is the optimized version of the program
# that uses a conditional move...to help with pipelining?
# This version also actually works, unlike that crca1.S version...what a dick.	



	.file "crca2.S"
	.text
	.global	crcInit
	.type crcInit, @function

crcInit:
	movq $0, %r8	# dividend = 0
	
divLoop:
	cmpl $255, %r8d	# dividend:255
	jg finish		# dividend > 256
	movq %r8, %rdx		# remainder = dividend
	movq $8, %rcx		# bit = 8
	
bitLoop:
	cmpl $0, %ecx		# bit:0
	jle setTableValue
	movq %rdx, %r9		# temp remainder = remainder
	salq $1, %rdx		# remainder = remainder << 1
	movq %rdx, %rax		# move shifted remainder to temp reg
	xorq $0xd5, %rax	# shifted temp ^ 0xD5
	testb $0x80, %r9b	# (unmodified remainder):0x80
	cmovnz %rax, %rdx	#
	decq %rcx		# -- bit
	jmp bitLoop  


setTableValue:
	movb %dl, crcTable(%r8d)	# crcTable[dividend] = remainder
	incq %r8			# ++ dividend
	jmp divLoop


finish:
	rep ret




	.global crcFast
	.type crcFast, @function
crcFast:
        movq $0, %rdx	#long byte
        movq $0, %rax	#char remainder
	#movq $0, %rcx	#unsigned char data
        jmp startLoop      
.L3:
        xorb    (%rdi,%rdx), %al	# remainder = message[byte] ^ remainder 
        movzbl  %al, %ecx		# data = remainder 
        movb  crcTable(%ecx), %al	# remainder = crcTable[data]
        incq    %rdx

startLoop:
        cmpq    %rsi, %rdx	# byte < nBytes
        jl      .L3		# if true
        ret			# return remainder 
        
	
	.data	
	.global crcTable
	crcTable:
		.zero 256
