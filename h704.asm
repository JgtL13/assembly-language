INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
PrintString PROTO, start:PTR DWORD, read:PTR DWORD
.data
	buffer BYTE 999 DUP(?)
	startFrom DWORD ?
	readByte DWORD ?
	counter DWORD 0
	reminder1 BYTE "�п�J�@�Ӧr��G", 0
	reminder2 BYTE "�п�J�n�q�ĴX�Ӧr���}�l�G", 0
	reminder3 BYTE "�п�J�nŪ�X�Ӧr���G", 0

.code
PrintString PROC USES eax ebx ecx,
	start:PTR DWORD,
	read:PTR DWORD
	
	mov ebx, startFrom
	dec ebx
	L1:
		movzx eax, buffer[ebx]
		call WriteChar
		inc ebx
		inc counter
		mov ecx, counter
		cmp ecx, read
		jl L1
		ret
PrintString ENDP

main PROC
	mov edx, OFFSET reminder1
	call WriteString
	mov edx, OFFSET buffer
	mov ecx, SIZEOF buffer
	call ReadString
	mov edx, OFFSET reminder2
	call WriteString
	call ReadInt
	mov startFrom, eax
	mov edx, OFFSET reminder3
	call WriteString
	call ReadInt
	mov readByte, eax
	INVOKE PrintString, startFrom, readByte
	INVOKE ExitProcess , 0
	
main ENDP
END main
