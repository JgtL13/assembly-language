INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	numArray DD 100 DUP(0)

.code
main PROC
	mov ecx, 0
	mov ebx, 0
	mov eax, 2
	lea esi, numArray
	
	Init:
		mov [esi], eax
		add esi, 4
		inc eax
		cmp eax, 102
		jle Init
		mov ecx, 0
		jg OuterLoop1

	OuterLoop1:
		mov ebx, ecx ;ebx紀錄InnerLoop的Index ecx紀錄OuterLoop的Index
		inc ebx ;Innerloop從下一個倍數開始
		cmp [numArray + 4 * ecx], -1
		jne InnerLoop1

	OuterLoop2:
		inc ecx
		cmp ecx, 100
		jl OuterLoop1
		mov edx, 0
		jge Print1

	InnerLoop1:
		cmp [numArray + 4 * ebx], -1
		jne NotPrime
		je InnerLoop2

	InnerLoop2:
		inc ebx
		cmp ebx, 100
		jb InnerLoop1
		jmp OuterLoop2

	NotPrime:
		mov edx, 0
		mov eax, 0
		mov eax, [numArray + 4 * ebx]
		div [numArray + 4 * ecx] ;去檢查ebx之後的每一個可不可以被ecx整除，如果可以就不是prime
		cmp edx, 0
		jne InnerLoop2
		jmp NotPrime2

	NotPrime2:
		mov [numArray + 4 * ebx], -1
		jmp InnerLoop2

	Print1:
		mov ecx, 0
		jmp Print2

	Print2:
		cmp ecx, 100
		je Finish
		cmp [numArray + 4 * ecx], -1
		jne Print3
		inc ecx
		jmp Print2

	Print3:
		mov eax, [numArray + 4 * ecx]
		cmp eax, 100
		jge Finish
		call WriteDec
		call crlf
		inc ecx
		jmp Print2

	Finish:
		INVOKE ExitProcess , 0
	
main ENDP
END main
