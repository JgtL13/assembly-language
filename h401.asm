
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	reminder BYTE "Enter an integer to calculate it's factorial: ", 0
	answer1 BYTE "The factorial of ", 0
	answer2 BYTE " is: ", 0 
	seed DWORD 1
	factorial DWORD ?
	sum DWORD 1
.code
main PROC
	mov edx, OFFSET reminder
	call WriteString
	call ReadDec
	mov factorial, eax

	Loop1:
		mov eax, sum
		mov ebx, seed
		mul ebx
		mov sum, eax
		inc seed
		mov ecx, seed
		cmp ecx, factorial
		jg Finish
		jle Loop1

	Finish:
		mov edx, OFFSET answer1
		call WriteString
		mov eax, factorial
		call WriteDec
		mov edx, OFFSET answer2
		call WriteString
		mov eax, sum
		call WriteDec
		call crlf

	INVOKE ExitProcess , 0
		
main ENDP
END main
