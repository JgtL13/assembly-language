;嘗試寫出產出如下的9x9乘法表
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	reminder BYTE "Please enter the three sides of your triangle: ", 0
	strTriangle BYTE "This is a triangle.", 0
	strNotTriangle BYTE "This is not a triangle.", 0
	strRightTriangle BYTE "This is a right triangle", 0
	sides BYTE 3 dup(0)
	loopCounter BYTE 0
	outerLoopCounter BYTE 0
	innerLoopCounter BYTE 0
	a BYTE ?
	b BYTE ?
	aa BYTE ?
	bb BYTE ?
	cc BYTE ?

.code
main PROC
	lea edx, reminder
	call WriteString
	call crlf
	lea esi, sides
	call ReadDec
	mov [esi], eax
	inc esi
	call ReadDec
	mov [esi], eax
	inc esi
	call ReadDec
	mov [esi], eax
	jmp SortOuter

	SortOuter:
		inc outerLoopCounter
		mov innerLoopCounter, 0
		lea esi, sides
		cmp outerLoopCounter, 3
		je Verify
		jl SortInner

	SortInner:
		mov bl, 0
		inc innerLoopCounter
		mov bl, [esi+1]
		cmp [esi], bl
		jg Swap
		inc esi
		cmp innerLoopCounter, 2
		je SortOuter
		jl SortInner
	
	Swap:
		mov cl, 0
		mov cl, [esi]
		mov [esi+1], cl
		mov [esi], bl
		inc esi
		cmp innerLoopCounter, 2
		je SortOuter
		jl SortInner

	Verify:
		lea esi, sides
		mov al, 0
		mov bl, 0
		mov cl, 0
		mov al, [esi]
		mov bl, [esi+1]
		mov cl, [esi+2]
		add al, bl
		cmp al, cl
		jg IsTriangle
		jle NotTriangle

	IsTriangle:
		lea edx, strTriangle
		call WriteString
		call crlf
		mov al, 0
		mov bl, 0
		mov cl, 0
		mov al, [esi]
		mul al
		mov aa, al

		mov al, 0
		mov al, [esi+1]
		mul al
		mov bb, al

		mov al, 0
		mov al, [esi+2]
		mul al
		mov cc, al

		mov al, 0
		mov al, aa
		add al, bb
		cmp al, cc
		je IsRightTriangle
		jne Finish

	NotTriangle:
		lea edx, strNotTriangle
		call WriteString
		call crlf
		jmp Finish

	IsRightTriangle:
		lea edx, strRightTriangle
		call WriteString
		call crlf
		jmp Finish

	Finish:
		INVOKE ExitProcess , 0
		
main ENDP
END main
