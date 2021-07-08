INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
GCD PROTO, a:PTR DWORD, b:PTR DWORD
.data

.code
main PROC
	INVOKE GCD, 5, 20
	INVOKE GCD, 24, 18
	INVOKE GCD, 11, 7
	INVOKE GCD, 432, 226
	INVOKE GCD, 26, 13
	INVOKE ExitProcess , 0
main ENDP



GCD PROC USES eax ebx edx,
	 a:PTR DWORD, 
	 b:PTR DWORD

	InnerLoop:
		cmp a, 0
		je printB
		cmp b, 0
		je printA
		mov eax, a
		cmp eax, b
		jge updateA
		jl updateB

	updateA:
		mov edx, 0
		mov eax, a
		mov ebx, b
		div ebx
		mov a, edx
		jmp InnerLoop

	updateB:
		mov edx, 0
		mov eax, b
		mov ebx, a
		div ebx
		mov b, edx
		jmp InnerLoop

	printA:
		mov eax, a
		call WriteDec
		call crlf
		ret

	printB:
		mov eax, b
		call WriteDec
		call crlf
		ret

GCD ENDP
END main
	
		
