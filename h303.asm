INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	Reminder DB "Enter the last 5 digits of your student ID: ", 0
	ID DWORD ?
	Number DWORD 0
	devisor DWORD 10000
	multiply DWORD ?
	sum DWORD 0
	ten DWORD 10

.code
main PROC
	mov edx, OFFSET Reminder
	call WriteString
	call ReadInt
	mov ID, eax
	mov eax, 0
	mov edx, 0

	;number * 2 + 6
	mov eax, ID
	mov ebx, devisor
	div ebx
	mov Number, eax
	mov ID, edx
	mov eax, 0
	mov edx, 0
	mov ebx, 0
	mov eax, Number
	mov multiply, 2
	mul multiply
	add eax, 6
	add sum, eax
	mov eax, 0
	mov edx, 0
	mov eax, devisor
	mov ebx, ten
	div ten
	mov devisor, eax
	mov eax, 0
	mov ebx, 0

	;number x 2 + 5
	mov eax, ID
	mov ebx, devisor
	div ebx
	mov Number, eax
	mov ID, edx
	mov eax, 0
	mov edx, 0
	mov ebx, 0
	mov eax, Number
	mov multiply, 2
	mul multiply
	add eax, 5
	add sum, eax
	mov eax, 0
	mov edx, 0
	mov eax, devisor
	mov ebx, ten
	div ten
	mov devisor, eax
	mov eax, 0
	mov ebx, 0

	;number x 5 + 6
	mov eax, ID
	mov ebx, devisor
	div ebx
	mov Number, eax
	mov ID, edx
	mov eax, 0
	mov edx, 0
	mov ebx, 0
	mov eax, Number
	mov multiply, 5
	mul multiply
	add eax, 6
	add sum, eax
	mov eax, 0
	mov edx, 0
	mov eax, devisor
	mov ebx, ten
	div ten
	mov devisor, eax
	mov eax, 0
	mov ebx, 0

	;number x 3 - 1
	mov eax, ID
	mov ebx, devisor
	div ebx
	mov Number, eax
	mov ID, edx
	mov eax, 0
	mov edx, 0
	mov ebx, 0
	mov eax, Number
	mov multiply, 3
	mul multiply
	sub eax, 1
	add sum, eax
	mov eax, 0
	mov edx, 0
	mov eax, devisor
	mov ebx, ten
	div ten
	mov devisor, eax
	mov eax, 0
	mov ebx, 0

	;number x 2 + 5
	mov eax, ID
	mov ebx, devisor
	div ebx
	mov Number, eax
	mov ID, edx
	mov eax, 0
	mov edx, 0
	mov ebx, 0
	mov eax, Number
	mov multiply, 2
	mul multiply
	add eax, 5
	add sum, eax
	mov eax, 0
	mov edx, 0
	mov eax, devisor
	mov ebx, ten
	div ten
	mov devisor, eax
	mov eax, 0
	mov ebx, 0

	mov eax, sum
	call WriteInt
	call crlf
	
	INVOKE ExitProcess , 0
main ENDP
END main
