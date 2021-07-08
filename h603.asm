INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
Factorial PROTO, pValX:PTR DWORD

.data
sum DWORD 1
input DWORD ?
reminder BYTE "Enter an interger to calculate the factorial: ", 0
result BYTE "The result is: ", 0
err BYTE "Overflow occurred.", 0

.code
main PROC
	lea edx, reminder
	call WriteString
	call ReadInt
	mov input, eax
	INVOKE Factorial, input
	lea edx, result
	call WriteString
	mov eax, sum
	call WriteDec
	call crlf
	INVOKE ExitProcess , 0	
main ENDP


Factorial PROC USES eax ebx edx,
	fac:PTR DWORD

	mov ebx, 1
	jmp FINISH

	FINISH:
		cmp ebx, fac
		jle CALCULATE
		ret
	
	CALCULATE:
		mov eax, 0
		mov edx, 0
		mov eax, sum
		mul ebx
		cmp eax, sum
		jl ERROR
		mov sum, eax
		inc ebx
		jmp FINISH

	ERROR:
		lea edx, err
		call WriteString
		call crlf
		INVOKE ExitProcess , 0	


Factorial ENDP
END main
	

