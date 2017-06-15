# Brian Lee
# CS201 - Hw3

# This version doesn't work properly :(
# The table values are just the signed values
# of a byte...




	.file "crca1.S"
	.text
	.global crcInit
	.type crcInit, @function

crcInit:
	movq $0, %r9		#int dividend

dividendLoop:
	cmpl $255, %r9d		#dividend:255
	jle .L2			#dividend <= 255
	rep ret	

.L2:
	movq %r9, %r8		#char remainder = dividend
	movq $8, %rcx		#char bit = 8

bitLoop:
	cmpl $0, %ecx			#bit:0
	jg checkRemainder		#bit > 0
	movb %r8b, crcTable(%r9d)	#crcTable[dividend] = remainder
	incq %r9			#++dividend
	jmp dividendLoop

checkRemainder:
	movq %r8, %rdx		#temp remainder = remainder
	salq $1, %rdx		#temp remainder << 1
	testb $0x80, %r8b	#remainder & 0x80
	jne POLY		#remainder & 0x80 != 0
	movq %rdx, %r8		#remainder == 0x80, move temp remainder
	decq %rcx		#--bit
	jmp bitLoop

POLY:
	xorq $0xd5, %rdx	#temp remainder ^ 0xd5
	movq %rdx, %r8		#remainder = temp remainder
	decq %rcx		#--bit	
	jmp bitLoop
	
	


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
