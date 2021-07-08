INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	prompt1 BYTE "Enter coefficient a: ", 0
	prompt2 BYTE "Enter coefficient b: ", 0
	prompt3 BYTE "Enter coefficient c: ", 0
	prompt4 BYTE "Solution not found.", 0
	prompt5 BYTE "Root is: ", 0
	prompt6 BYTE "Roots are: ", 0
	prompt7 BYTE " and ", 0
	aa SDWORD ? 
	bb SDWORD ?
	cc SDWORD ?
	bSqrt SDWORD ?
	fourAC SDWORD ?
	bSqrtMin4ac SDWORD ?
	negB SDWORD ?
	twoA SDWORD ?
	root1 REAL8 ?
	root2 REAL8 ?

.code
main PROC
	mov edx, OFFSET prompt1
	call WriteString
	call ReadInt
	mov aa, eax
	mov edx, OFFSET prompt2
	call WriteString
	call ReadInt
	mov bb, eax
	mov edx, OFFSET prompt3
	call WriteString
	call ReadInt
	mov cc, eax

	mov edx, 0
	mov eax, bb
	mul eax
	mov bSqrt, eax
	mov bSqrtMin4ac, eax

	mov edx, 0
	mov eax, aa
	mov ebx, 4
	mul ebx
	mov ebx, cc
	mul ebx
	mov fourAC, eax

	mov eax, bSqrtMin4ac
	sub eax, fourAC
	mov bSqrtMin4ac, eax
	cmp bSqrtMin4ac, 0
	jl Error
	je DoubleRoot
	jg SingleRoot

	Error:
		mov edx, OFFSET prompt4
		call WriteString
		call crlf
		jmp Finish

	DoubleRoot:
		mov edx, 0
		mov eax, bb
		mov negB, eax
		mov ebx, 2
		mul ebx
		sub negB, eax

		mov eax, aa
		mul ebx
		mov twoA, eax

		fild negB
		fild twoA
		fdiv
		mov edx, OFFSET prompt5
		call WriteString
		call WriteFloat
		call crlf

		jmp Finish


	SingleRoot:
		mov edx, 0
		mov eax, bb
		mov negB, eax
		mov ebx, 2
		mul ebx
		sub negB, eax

		mov eax, aa
		mul ebx
		mov twoA, eax

		fild bSqrtMin4ac
		fsqrt
		fild negB
		fadd
		fild twoA
		fdiv
		mov edx, OFFSET prompt6
		call WriteString
		call WriteFloat
		
		finit
		fild bSqrtMin4ac
		fsqrt
		fild negB
		fsub
		fild twoA
		fdiv
		mov edx, OFFSET prompt7
		call WriteString
		call WriteFloat
		call crlf

		jmp Finish

	Finish:
		INVOKE ExitProcess, 0

main ENDP
END main