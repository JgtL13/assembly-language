INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	buffer BYTE 999 DUP(?)
	str1 BYTE 999 DUP(?)
	str2 BYTE 999 DUP(?)
	s1 BYTE "¦r¦ês1 = ", 0
	s2 BYTE "¤p¼Æ¦r¦ês2 = ", 0
	quote BYTE 34, 0
	elementCount DWORD 0 
	change DWORD 0
	;counter DWORD 0
.code
main PROC
	mov edx, OFFSET buffer
	mov ecx, SIZEOF buffer
	call ReadString
	mov elementCount, eax
	mov ebx, elementCount

	
	LOOP1:
		dec ebx
		movzx eax, buffer[ebx]
		push eax
		cmp ebx, 0
		je INIT
		jg LOOP1

	INIT:
		mov ebx, 0
		mov ecx, 0
		mov ebp, elementCount
		jmp ChangeString

	SetString:
		mov change, 1
		jmp ChangeString

	ChangeString:
		dec ebp
		cmp ebp, 0
		jl Finish
		pop eax
		cmp eax, '.'
		je SetString
		cmp change, 0
		je String1
		cmp change, 1
		je String2
		

	String1:
		mov str1[ebx], al
		inc ebx
		jmp ChangeString

	String2:
		mov str2[ecx], al
		inc ecx
		jmp ChangeString
		
	Finish:
		lea edx, s1
		call WriteString
		lea edx, quote
		call WriteString
		lea edx, str1
		call WriteString
		lea edx, quote
		call WriteString
		call crlf

		lea edx, s2
		call WriteString
		lea edx, quote
		call WriteString
		lea edx, str2
		call WriteString
		lea edx, quote
		call WriteString
		call crlf
		INVOKE ExitProcess , 0
		

main ENDP
END main