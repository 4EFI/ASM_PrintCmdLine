.model tiny
.code 
org 100h

Start:		mov bx, 0b800h	; ES = VideoSegment
			mov es, bx 		               	

			xor bx, bx  	; BX = 0
			
			mov dx, 0 		; i = 0

			for_01:

			xor si, si		; SI = 0 , set char address
			add si, 81h
			add si, dx

			mov cx, [si]	; cx = currCmdLineChar

			cmp ch, 13d 	; strcmp( currCmdLineChar, 0 )
			je end_for_01

				mov bx, dx
				add bx, dx
				add bx, 1990d ; 1920 = 12*160 -> 13 line

				mov	byte ptr es:[bx],    ch 	; cmd line char 
				mov byte ptr es:[bx+1],  0b0h	; yellow on red (blink)

				inc dx 	; i++

				jmp for_01
	
			end_for_01:

			mov ax, 4c00h ; exit( 0 )
			int 21h 

end			Start          
