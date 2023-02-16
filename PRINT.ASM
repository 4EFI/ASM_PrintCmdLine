.186
.model tiny
.code 
org 100h

locals __

Start:		mov bx, 0b800h	; ES = VideoSegment
			mov es, bx 		

			call PrintCmdLiine               	

			mov ax, 4c00h ; exit( 0 )
			int 21h 

;------------------------------------------------
;	PRINT CMD LINE
;------------------------------------------------
; ENTRY: 	NONE
; EXIT:		NONE
; EXPECTS:	ES = 0b800h (VIDEO SEGMENT)
; DESTROYS:	BX CX DX Si  
;------------------------------------------------

PrintCmdLiine	proc
				
				call GetCmdLineSize

				shl bx, 1		; start str centering ( 160 - 2 * bx ) / 2 + ( 12 * 2 * 80 )
				neg bx 			
				add bx, 160
				shr bx, 1		
				add bx, 12 * 2 * 80

				mov cx, bx		; cx = bx

				and cx, 1		; cx % 2 ?= 0
				or  cx, 0
				cmp cx, 0	
				je	__even
					sub bx, 1
				__even:

				mov dx, 0 		; i = 0

				__next:

				mov si, 81h		; SI = 81h , start cmd line char address 
				add si, dx

				mov cx, [si]	; cx = currSym

				cmp ch, 13d 	; strcmp( currSym, '\r' )
				je __end_loop

				cmp ch, 0d	 	; strcmp( currSym, 0 )
				je __end_loop

					mov	byte ptr es:[bx],   ch 		; cmd line char 
					mov byte ptr es:[bx+1], 0b0h	; yellow on red (blink)

					add bx, 2	; bx += 2

					inc dx 		; i++

					loop __next
		
				__end_loop:

				ret
				endp

;------------------------------------------------
;	GET CMD LINE SIZE
;------------------------------------------------
; ENTRY:	NONE
; EXIT:		BX = CMD LINE SIZE
; ENTRY:	NONE
; DESTROYS:	BX CX SI
;------------------------------------------------

GetCmdLineSize	proc

				mov bx, 0 		; i = 0

				__next:

				mov si, 81h		; SI = 81h , start cmd line char address 
				add si, bx

				mov cx, [si]	; cx = currSym

				cmp ch, 13d 	; strcmp( currSym, '\r' )
				je __end_loop

				cmp ch, 0d	 	; strcmp( currSym, 0 )
				je __end_loop

					inc bx 		; i++

					loop __next
		
				__end_loop:

				ret
				endp

;------------------------------------------------

end			 	Start   