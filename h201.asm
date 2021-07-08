INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	 Reminder      BYTE      "Please enter 5 integers for addition and subtraction:", 0
	 ReminderAdd   BYTE      "a + b + c + d + e = ", 0
	 ReminderSub   BYTE      "a - b - c - d - e = ", 0
	 row           BYTE      12
	 col           BYTE      35
	 intValAdd     SDWORD    0
	 intValSub     SDWORD    0
	 

.code
main PROC

	call Clrscr
	mov dh, row
	mov dl, col
	call Gotoxy

	mov edx, OFFSET Reminder
	call WriteString

	inc row
	mov dh, row
	mov dl, col
	call Gotoxy
	
	call ReadInt
	mov intValAdd, eax
	mov intValSub, eax

	mov cx, 2
	INPUT:
		inc row
		mov dh, row
		mov dl, col
		call Gotoxy

		call ReadInt
		add intValAdd, eax
		sub intValSub, eax
		inc cx
		cmp cx, 5
	jle INPUT
	
	inc row
	mov dh, row
	mov dl, col
	call Gotoxy
	mov edx, OFFSET ReminderAdd
	call WriteString
	mov eax, intValAdd
	call WriteInt
	call crlf

	inc row
	mov dh, row
	mov dl, col
	call Gotoxy
	mov edx, OFFSET ReminderSub
	call WriteString
	mov eax, intValSub
	call WriteInt
	call crlf

	INVOKE ExitProcess , 0
main ENDP
END main
