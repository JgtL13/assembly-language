INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	inputX BYTE "Enter first number: ", 0
	inputY BYTE "Enter second number: ", 0
	x DWORD ?
	y DWORD ?
	n DWORD ?

.code
main PROC

	LOOP1:
		mov x, 0
		mov y, 0
		mov n, 0
		mov eax, 0
		mov ebx, 0
		mov ecx, 0
		mov edx, 0

		lea edx, inputX
		call WriteString
		call ReadInt
		mov x, eax

		lea edx, inputY
		call WriteString
		call ReadInt
		mov y, eax
		jmp GCD

	GCD:
		mov edx, 0
		mov eax, x
		mov ebx, y
		div ebx
		mov n, edx
		mov ecx, y
		mov x, ecx
		mov ecx, n
		mov y, ecx
		cmp y, 0
		jg GCD
		mov eax, x
		call WriteInt
		call crlf
		jmp LOOP1
	
	
	INVOKE ExitProcess , 0
		
main ENDP
END main