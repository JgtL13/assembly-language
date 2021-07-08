INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	ArraySizeString DB "Enter an integer for the size of the array: ", 0
	NumberRangeString DB "Enter an integer for the range of the numbers to be generated: ", 0
	array SDWORD 10000 DUP(0)
	ArraySize SDWORD ?
	NumberRange DWORD ?
	RandVal SDWORD ?
	NegativeFlag DWORD ?
	MinusOne BYTE -1
	counter SDWORD 1
	BaseAddressofArray DWORD ?

.code
main PROC
	mov edx, OFFSET ArraySizeString
	;user input array size
	call WriteString
	call ReadInt  
	mov ArraySize, eax 
	mov eax, 0
	mov edx, 0
	;user input number range
	mov edx, OFFSET NumberRangeString
	call WriteString
	call ReadInt
	mov NumberRange, eax
	inc NumberRange  ;RandomRange generates random numbers from 0 to (n-1)
	mov esi, OFFSET array
	mov BaseAddressofArray, esi  ;remember base address of array
	jmp loop1
	
	loop1:
		jmp Generate
		loop2:
			;store random number into array
			mov ecx, randVal
			mov [esi], ecx
			mov eax, [esi]
			mov eax, 0
			add esi, 4
			inc counter
			mov eax, 0
			mov eax, counter
			;detect whether array size has reaches
			cmp eax, ArraySize
			jle loop1  ;keep generating numbers until elements have reached array size
			mov counter, 0
			mov esi, 0
			mov esi, 0
			mov esi, BaseAddressofArray  ;recall array base address
			jmp Print

	;generate random numbers
	Generate:
		mov eax, 0
		mov eax, NumberRange
		call RandomRange  ;call generate function
		mov randVal, eax
		mov eax, 0
		mov eax, 2
		call RandomRange
		mov NegativeFlag, eax ;eax will equal to 0 or 1
		mov eax, 0
		cmp NegativeFlag, 1  ;if eax is 1, set random number to negative
		je Negative
		jne loop2

	Negative:
		neg randVal
		jmp loop2

	Print:
		mov eax, 0
		mov eax, [esi]  ;get element in array
		call WriteInt
		mov eax, 0
		mov eax, ' '  ;write a space
		call WriteChar
		add esi, 4
		inc counter
		mov eax, 0
		mov eax, counter
		cmp eax, ArraySize
		jl Print
		
	INVOKE ExitProcess , 0
main ENDP
END main
