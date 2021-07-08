INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	prompt1 BYTE "sin ", 0
	prompt2 BYTE " = ", 0
	straightAngle DWORD 180
	angle DWORD 5
	pi REAL8 3.14159265359
	straightAngleDivAngle DWORD ?
	round DWORD 1000000

.code
main PROC
	L1:
		finit
		fld pi
		fild straightAngle
		fdiv
		fild angle
		fmul
		fsin
		fimul round
		frndint
		fidiv round

		mov edx, OFFSET prompt1
		call WriteString
		mov eax, angle
		call WriteDec
		mov edx, OFFSET prompt2
		call WriteString
		mov eax, angle
		call WriteFloat
		call crlf
		add angle, 5
		cmp angle, 90
		jle L1
		INVOKE ExitProcess, 0

main ENDP
END main