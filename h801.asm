INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	reminder1 BYTE "Enter temperature in celsius: ", 0
	reminder2 BYTE "Fahrenheit: ", 0
	nineFifths REAL8 1.8
	thirtyTwo REAL8 32.0
	fahrenheit REAL8 ?

.code
main PROC
	mov edx, OFFSET reminder1
	call WriteString
	finit
	fld nineFifths
	mov edx, OFFSET reminder1
	call ReadFloat
	fmul ST(0), ST(1)
	fld thirtyTwo
	fadd ST(0), ST(1)
	mov edx, OFFSET reminder2
	call WriteString
	call WriteFloat
	call crlf
	INVOKE ExitProcess, 0

main ENDP
END main