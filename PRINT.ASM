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

				mov bx, 0	  	; BX = 0
				mov dx, 0 		; i = 0

				__next:

				mov si, 81h		; SI = 81h , start cmd line char address 
				add si, dx

				mov cx, [si]	; cx = currCmdLineChar

				cmp ch, 13d 	; strcmp( currCmdLineChar, '\r' )
				je __end_loop

				cmp ch, 0d	 	; strcmp( currCmdLineChar, ' ' )
				je __end_loop

					mov bx, dx
					add bx, dx
					add bx, 1990d ; 1920 = 12*2*80 -> 13 line

					mov	byte ptr es:[bx],    ch 	; cmd line char 
					mov byte ptr es:[bx+1],  0b0h	; yellow on red (blink)

					inc dx 	; i++

					loop __next
		
				__end_loop:

				ret
				endp

;------------------------------------------------
;	GET CMD LINE SIZE
;------------------------------------------------
;
;------------------------------------------------



;------------------------------------------------

end			 	Start   