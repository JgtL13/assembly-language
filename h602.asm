INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
Swap PROTO, pValX:PTR DWORD, pValY:PTR DWORD

.data
Array DWORD 10 DUP(?)
counter1 DWORD 0
counter2 DWORD 0
originalArray BYTE "This is the original array: ", 0
sortedArray BYTE "This is the sorted array: ", 0

.code
main PROC
	mov esi, 0
	call Randomize
	Generate:
		inc counter1
		mov eax, 99999
		call RandomRange
		mov Array[esi] ,eax
		add esi, 4
		cmp counter1, 10
		jl Generate

	mov edx, OFFSET originalArray
	call WriteString
	call crlf
	mov esi, 0
	mov eax, Array[esi]
	call WriteInt
	mov eax, Array[esi+4]
	call WriteInt
	mov eax, Array[esi+8]
	call WriteInt
	mov eax, Array[esi+12]
	call WriteInt
	mov eax, Array[esi+16]
	call WriteInt
	mov eax, Array[esi+20]
	call WriteInt
	mov eax, Array[esi+24]
	call WriteInt
	mov eax, Array[esi+28]
	call WriteInt
	mov eax, Array[esi+32]
	call WriteInt
	mov eax, Array[esi+36]
	call WriteInt
	call crlf
	mov counter1, 0

	OuterLoop:
		mov esi, 0
		mov counter2, 0
		inc counter1
		cmp counter1, 9
		jg Finish
		jle InnerLoop

	InnerLoop:
		inc counter2
		cmp counter2, 9
		jg	OuterLoop
		mov eax, Array[esi+4]
		cmp Array[esi], eax
		jg JumpSwap
		add esi, 4
		jmp InnerLoop

	JumpSwap:
		INVOKE Swap, ADDR Array[esi], ADDR Array[esi+4]
		add esi, 4
		jmp InnerLoop

	Finish:
		mov edx, OFFSET SortedArray
		call WriteString
		call crlf
		mov esi, 0
		mov eax, Array[esi]
		call WriteInt
		mov eax, Array[esi+4]
		call WriteInt
		mov eax, Array[esi+8]
		call WriteInt
		mov eax, Array[esi+12]
		call WriteInt
		mov eax, Array[esi+16]
		call WriteInt
		mov eax, Array[esi+20]
		call WriteInt
		mov eax, Array[esi+24]
		call WriteInt
		mov eax, Array[esi+28]
		call WriteInt
		mov eax, Array[esi+32]
		call WriteInt
		mov eax, Array[esi+36]
		call WriteInt
		call crlf
		exit

main ENDP

;-----------------------------------------------
Swap PROC USES eax esi edi,
	pValX:PTR DWORD,			; pointer to first integer
	pValY:PTR DWORD				; pointer to second integer
;
; Exchange the values of two 32-bit integers
; Returns: nothing
;----------------------------------------------
	mov esi, pValX				; get pointers
	mov edi, pValY
	mov eax, [esi]				; get first integer
	xchg eax, [edi]				; exchange with second
	mov [esi], eax				; replace first integer
	ret							; PROC generates RET 8 here
Swap ENDP
END main
	
;INVOKE ExitProcess , 0	
