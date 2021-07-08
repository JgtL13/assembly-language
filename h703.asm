INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	buffer BYTE 99 DUP(?)
	inputLength DWORD 0
	num1 SDWORD 0
	num2 SDWORD 0
	index DWORD 0
	changeNum DWORD 0
	totalBytes DWORD 0
	counter DWORD 0
	sum DWORD 0

InputConversion macro 
	mov edi, 0
	mov edx, OFFSET buffer
	mov ecx, SIZEOF buffer
	call ReadString
	mov inputLength, eax
	mov esi, 0
	L1:
		cmp buffer[esi], ':'
		je L2a
		cmp buffer[esi], 161
		je L2b
		inc esi
		jmp L1

	L2a:
		inc esi
		jmp L3

	L2b:
		inc esi
		inc esi
		jmp L3
	
	L3:
		cmp buffer[esi], '='
		je L4
		cmp buffer[esi], ' '
		je L4
		movzx eax, buffer[esi]
		push eax
		inc totalBytes
		mov eax, totalBytes
		inc esi
		jmp L3

	Init:
		mov index, 0
		mov edi, 0
		jmp L4

	L4:
		inc counter
		mov eax, 0
		pop eax
		cmp eax, '+'
		je isPositive
		cmp eax, '-'
		je isNegative
		mov ebx, counter
		cmp ebx, totalBytes
		jg isPositive
		mov edx, 0
		mov ecx, 1
		sub eax, 48
		inc index
		jmp L5

	L5:
		cmp ecx, index
		je L6
		mov ebx, 10
		mul ebx
		inc ecx
		jmp L5

	L6:
		add edi, eax
		jmp L4

	isPositive:
		cmp changeNum, 0
		je storeNum2
		jne storeNum1

	isNegative:
		mov edx, 0
		mov eax, edi
		mov ecx, edi
		mov ebx, 2
		mul ebx
		sub ecx, eax
		mov edi, ecx
		mov eax, edi
		cmp changeNum, 0
		je storeNum2
		jne storeNum1

	storeNum2:
		mov num2, edi
		mov eax, num2
		mov changeNum, 1
		jmp Init

	storeNum1:
		mov num1, edi
		mov eax, num1
ENDM

.code
main PROC
	InputConversion
	mov eax, num1
	add eax, num2
	mov sum, eax
	lea edx, buffer
	call WriteString
	mov eax, sum
	call WriteInt
	call crlf
	INVOKE ExitProcess , 0	

main ENDP
END main