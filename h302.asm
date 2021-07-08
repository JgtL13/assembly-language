INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	ReminderStart DB "Enter an integer to start: ", 0
	ReminderEnd DB "Enter an integer to end; ", 0
	StartingNum SDWORD ?
	EndingNum SDWORD ?
	CurrentNum SDWORD ?
	Sum SDWORD 0

.code
main PROC
	;read staring number
	mov edx, OFFSET ReminderStart
	call WriteString
	call ReadInt
	mov StartingNum, eax
	mov CurrentNum, eax
	mov edx, 0
	mov eax, 0
	;read ending number
	mov edx, OFFSET ReminderEnd
	call WriteString
	call ReadInt
	mov EndingNum, eax
	sub EndingNum, 1
	mov eax, 0
	jmp Calculate
	
	;calculate sum
	Calculate:
		mov eax, 0
		mov ebx, 0
		mov ebx, CurrentNum
		add ebx, 1  ;add current number by 1
		mov eax, 0
		mov eax, CurrentNum 
		mul ebx  ;mulltiply current number by current number+1
		add sum, eax  ;add sum to total
		mov eax, 0
		mov ebx, 0
		inc CurrentNum  ;increment surrent number
		mov eax, CurrentNum
		cmp eax, EndingNum  ;keep calculating until current number reaches ending number-1
		jle Calculate
		jg Continue

	Continue:
		mov eax, 0
		mov eax, sum
		call WriteInt  ;print total
		call crlf
		
	INVOKE ExitProcess , 0
main ENDP
END main
