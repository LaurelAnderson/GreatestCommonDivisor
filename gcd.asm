;Final Program for CS 261 - Laurel Anderson
SECTION .data

prompt: db		"Enter a positive integer: "
plen: equ		$-prompt

error: db 		"Input not valid ", 10
errlen: equ		$-prompt

output: db 		"Greatest common divisor = "; output
outputlen: equ		$-output

newline: db 10
linelen: equ 		$-newline

SECTION .bss

retNum: equ		32		; store upto 32 bits
inbuf: resb 		retNum	+ 2	; store in the input buffer

retVal: resb		retNum		; reserve space for return value

SECTION	.text
		
		global _start
		global readNumber
		global gcd
		global makeDecimal
		
_start: 
		call 		readNumber		; call readNumber
		mov		ebx, eax		; save returned value
		call 		readNumber		; call readNumber
		
	; push arguments
		push		eax			; second variable
		push		ebx			; first variable
		call		gcd			; send to gcd
		add		esp, 8
		push		eax
		
	; print output
		mov		eax, 4
		mov		ebx, 1
		mov		ecx, output
		mov		edx, outputlen		
		int 	80H
		
	; turn back into string 
		call 		makeDecimal		
		pop eax
		
	; print newline
		mov		eax, 4
		mov		ebx, 1
		mov		ecx, newline
		mov		edx, linelen
		int 	80H		
		
		jmp 	end

; End of main method
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

readNumber: 
	
	; call conventions go here
		push		ebp			; save callers stack frame
		mov 		ebp, esp		; start our own stack frame
		sub		esp, 8			; add space to the stack
				
	; push each register that is used
		push 		ebx			
		push 		ecx
		push 		edx
		push 		edi 
		push		esi
	
	; prompt
		nop
		mov		eax, 4			; write
		mov		ebx, 1			; to standard output
		mov		ecx, prompt		; the prompt string
		mov		edx, plen		; of length plen
		int 	80H				; interrupt with the syscall	
		
	; user input
		mov		eax, 3			; read
		mov		ebx, 0			; from standard input
		mov		ecx, inbuf		; into the input buffer
		mov		edx, retNum+2		; upto retNum + 2 bytes
		int 	80H				; interrupt with the syscall
	
	; setup for nextdigit method
		mov		ecx, 10			; set ecx to highest number of digits
		mov		esi, inbuf		; move string to esi
		xor 		ebx, ebx    		; clear ebx

nextDigit:
		
 		movzx		eax, byte[esi]		; get byte from esi
   		inc 		esi			; increment esi
   		
   	; compare to see if you are at a newline
   		cmp		eax, 10			; if eax == newline
   		je		nextEnd			; end loop and get value
   						
 	; check for space
 		cmp		eax, 32			; if eax == space
 		je		checkSpace		; check space
 		
 	; check for bad digit
 		cmp		eax, '9'		; if greater then 9
 		jg		errorMsg		; print error msg
 		cmp		eax, '0'		; if less then 0
 		jl		errorMsg		; print error msg
 	
 	; continue with conversion	

  		sub		al, '0'    		; convert from ASCII to number
  		imul 		ebx, 10			; multi ebx times 10
 		add		ebx, eax 		; ebx = ebx*10 + eax
  		loop		nextDigit  		; while (--ecx)
  		
nextEnd: 
  		mov 		eax, ebx		; eax = value

	;prepare for return		
		pop		esi
		pop		edi
		pop		edx
		pop		ecx
		pop		ebx
		
	;restore stack frame
		add 		esp, 8
		mov		esp, ebp
		pop 		ebp
		
		ret					; return to main
		
checkSpace: 	
		loop		nextDigit		; go back to loop - increments ecx
		
; End of readNumber method	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gcd:

	; set up stack frame
		push 		ebp	
		mov		ebp, esp
		push		edi
		push 		esi
	
	; set up variables
		mov		esi, [ebp+8]		; esi = 1st var (n)
		mov		edi, [ebp+12]		; edi = 2nd var (m)
		
gcdJump: 
		cmp		esi, edi		; compare n and m
		jg		gcd1			; n > m
		jl		gcd2			; n < m
		jmp		gcdEnd			; n == m
		
gcd1: 
		sub		esi, edi		; n = n - m
		jmp		gcdJump			; recurse

gcd2: 	
		sub		edi, esi		; m = m - n
		jmp		gcdJump			; recurse

gcdEnd: 
		mov		eax, esi		; return n in eax
		pop		esi
		pop		edi
		mov		esp, ebp
		pop		ebp
		ret		

; End of gcd method
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

makeDecimal: 

	; set up stack frame
		push 		ebp	
		mov		ebp, esp
		push 		edx
		push 		ecx
		push 		ebx
	
	; set up variables
		mov		eax, [ebp+8]		; eax = 1st var
		 
		mov		edx, dword 0		; 0 out edx for remainder
		mov		ebx, dword 10		; set ebx to 10
		div		ebx			; ax = quotient dx = remainder
		cmp		ax, 0			; is the quotient 0? 
		je		print			; if so, print
		push 		eax			; push eax for return
		call		makeDecimal 		; recurse
		pop 		eax	
print: 
		add		dx, '0'			; turn int into a char
		mov		[retVal], dx		; move into space to print	
		mov		eax, 4			; write
		mov		ebx, 1			; to standard output
		mov		ecx, retVal		; the string in the buffer
		mov		edx, 1			; of length
		int 	80H
		
		pop		ebx
		pop		ecx
		pop		edx	
		mov		esp, ebp
		pop		ebp
		
		ret
		
; End of makeDecimal method
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

errorMsg: 
		mov		eax, 4			; write
		mov		ebx, 1			; to standard output
		mov		ecx, error		; the string in the buffer
		mov		edx, errlen		; of string length
		int 	80H
		jmp		end			; return value

end: 
		mov 		eax, 1			; set up process exit
		mov 		ebx, 0			; and
		int	80H				; terminate
		

