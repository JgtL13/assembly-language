INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
Get_frequencies PROTO, targetStr:PTR BYTE, frequencyTable:PTR DWORD
.data
    testString BYTE "AAEBDCFBBC",0 
    freqTable DWORD 256 DUP(0)
    colon BYTE ": ", 0
	tmp DWORD 0

.code
main PROC
    INVOKE Get_frequencies, ADDR testString, ADDR freqTable
    mov ecx, 256
    mov ebx, 0
    mov edi, OFFSET freqTable
    mov eax, 0

    L1:
        call WriteHex
        mov  edx, OFFSET colon
        call WriteString
        mov ebx, [edi + eax * 4]
		mov tmp, eax
		mov eax, ebx
		mov ebx, tmp
        call WriteDec
		mov tmp, eax
		mov eax, ebx
		mov ebx, tmp
		call crlf
        inc eax
        Loop L1
        ret
main ENDP

Get_frequencies PROC USES eax ecx edx edi,
	targetStr:PTR BYTE, 
	frequencyTable:PTR DWORD

	mov eax, 0
	mov edi, frequencyTable
	mov edx, targetStr
	mov ecx, 10
    L1:
		mov al, [edx]
		call WriteChar
		inc edx
		inc dword ptr[edi + eax * 4]
		Loop L1
		ret
Get_frequencies ENDP

END main

