;寫一能在3次方陣列{1, 4, 9, 16, 25…}內計算前n個奇數總和程式，直到發生溢位為止。將每個無號十進位整數顯示為單獨一行，請使用8位元整數

INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	string1 DB "The total of the above is: ", 0
	reminder DB "Please enter a number n to calculate: ", 0


	numArray WORD 40 DUP(0)
	seed BYTE 1
	counter BYTE 0
	sum BYTE 0
	lastSum BYTE 0
	n BYTE ?

.code
main PROC
	mov edx, OFFSET reminder
	call WriteString
	call ReadInt
	mov n, al

	lea esi, numArray
	Generate:
		movzx ax, seed
		movzx bx, seed
		mul bx
		mov [esi], ax
		mov ax, 0
		add esi, 2
		inc counter
		inc seed
		cmp counter, 40
		jl Generate
		jge Addition

	Addition:
		lea esi, numArray
		mov counter, 0
		jmp Loop1
		Loop1:
			
			mov ax, 0
			mov ax, [esi]
			mov bx, 2
			div bx
			movzx eax, dx
			cmp dx, 0
			je Increment

			inc counter

			mov cl, sum
			mov lastSum, cl

			mov ax, 0
			mov al, n
			cmp counter, al
			jg Finish

			mov ax, 0
			mov bx, 0
			mov bl, [esi]
			mov eax, 0
			movzx eax, bx
			call WriteDec
			call crlf

			add sum, bl
			mov bx, 0
			add esi, 2
			mov cx, 0
			mov cl, sum
			cmp cl, lastSum
			jl Finish
			jge Loop1
			

	Increment:
		add esi, 2
		jmp Loop1

	Finish:
		mov edx, 0
		mov edx, OFFSET string1
		movzx eax, lastSum
		call WriteString
		call WriteDec
		call crlf
	
	INVOKE ExitProcess , 0
	
main ENDP
END main
