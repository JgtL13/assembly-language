INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	 array WORD 102 DUP(0)
	 Reminder BYTE "Enter an integer K that is smaller than 98 to list out all the multiples of K that are smaller than 98:"
	 ;TestString BYTE "This is a test"
	 counter WORD 1
	 counter2 WORD 0
	 K BYTE ?
	 sum BYTE ?
	 rem BYTE ?
	 
	 

.code
main PROC

	mov esi, OFFSET array
	mov edx, OFFSET Reminder
	call WriteString
	call ReadInt
	mov K, al
	cmp K, 1
	je SetAllToOne
	jne FindMultiples

	SetAllToOne:
		inc counter2
		mov ax, counter2
		call WriteInt
		call crlf
		cmp counter2, 98
		je ExitProcess	
		jle SetAllToOne

	FindMultiples:
		mov ax, 0
		mov ax, counter
		mov bl, K
		div bl ;counter / K
		mov sum, al
		mov rem, ah
		cmp rem, 0 ;if counter / K remains 0, jump to SetBit
		je SetBit
		jmp Continue
		SetBit: 	
			mov cx, 1
			mov [esi], cx
		Continue: 
			inc esi
			inc counter
			cmp counter, 98 ;do until counter is greater or equal to 99
			jle FindMultiples
			jg Finish

	Finish: ;print out the answers
		mov eax, 0 ;reset eax
		mov counter, 1 ;reset counter
		mov ebx, 0
		mov esi, OFFSET array ;reset array address

		Validate:
			mov bx, [esi]
			cmp bx, 1 ;if value in array is 1
			je Print
			jmp Next
			Print:
				mov ax, counter ;print out counter value
				call WriteInt
				call crlf
			Next:
				inc counter
				inc esi
				cmp counter, 99
				jle Validate
				
				
	INVOKE ExitProcess , 0
main ENDP
END main
