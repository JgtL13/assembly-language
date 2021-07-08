INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
	buffer1 BYTE 999 DUP(?)
	buffer2 BYTE 999 DUP(?)
	buffer3 BYTE 999 DUP(?)
	reminder1 BYTE "請輸入第一個字串: ", 0
	reminder2 BYTE "請輸入第二個字串: ", 0
	reminder3 BYTE "請輸入大三個字串: ", 0
	string1 BYTE "嘉義大學資訊工程學系 NCYU CSIE", 0
	string2 BYTE "NCYU", 0
	string3 BYTE "嘉義大學", 0
	string4 BYTE "OK", 0
	string5 BYTE "NCU", 0
	string6 BYTE "中央大學", 0
	string7 BYTE "NO found", 0
	string8 BYTE "is a top department of CSIE", 0
	error BYTE "你的輸入不在題目要求內", 0
	space BYTE " ", 0

.code
main PROC
	mov edx, OFFSET reminder1
	call WriteString
	mov edx, OFFSET buffer1
	mov ecx, SIZEOF buffer1
	call ReadString

	mov esi, OFFSET string1
	mov edi, OFFSET buffer1
	mov ecx, SIZEOF string1
	repz cmpsb
	cmp ecx, 0
	jnz Break
	
	mov edx, OFFSET reminder2
	call WriteString
	mov edx, OFFSET buffer2
	mov ecx, SIZEOF buffer2
	call ReadString

	mov esi, OFFSET string2
	mov edi, OFFSET buffer2
	mov ecx, SIZEOF string2
	repz cmpsb
	cmp ecx, 0
	jnz try1
	lea edx, string4
	call WriteString
	call crlf
	jmp Continue

	try1:
		mov esi, OFFSET string3
		mov edi, OFFSET buffer2
		mov ecx, SIZEOF string3
		repz cmpsb
		cmp ecx, 0
		jnz try2
		lea edx, string4
		call WriteString
		call crlf
		jmp Continue

	try2:
		mov esi, OFFSET string5
		mov edi, OFFSET buffer2
		mov ecx, SIZEOF string5
		repz cmpsb
		cmp ecx, 0
		jnz try3
		lea edx, string7
		call WriteString
		call crlf
		jmp Continue

	try3:
		mov esi, OFFSET string6
		mov edi, OFFSET buffer2
		mov ecx, SIZEOF string6
		repz cmpsb
		cmp ecx, 0
		jnz Break
		lea edx, string7
		call WriteString
		call crlf
		jmp Continue

	Continue:
		mov edx, OFFSET reminder3
		call WriteString
		mov edx, OFFSET buffer3
		mov ecx, SIZEOF buffer3
		call ReadString

		mov esi, OFFSET string8
		mov edi, OFFSET buffer3
		mov ecx, SIZEOF string8
		repz cmpsb
		cmp ecx, 0
		jnz Break
		lea edx, string1
		call WriteString
		lea edx, space
		call WriteString
		lea edx, string8
		call WriteString
		call crlf
		jmp Finish

	Break:
		lea edx, error
		call WriteString
		call crlf
		jmp Finish

	Finish:
		INVOKE ExitProcess , 0	


main ENDP
END main

