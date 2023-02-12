.model tiny
.code 
org 100h

Start:		mov bx, 0b800h	; ES = VideoSegment
			mov es, bx 		               	

			xor bx, bx  	; BX = 0
			
			mov dx, 0 		; i = 0

			for_01:

			push '$'
			push [80]	; push current char from cmd line
			je end_for_01

				mov byte ptr es:[bx],   [80h] 	; cmd line char 
				mov byte ptr es:[bx+1],  0ceh	  	; yellow on red (blink)

				push cx + 2 ; i += 2
				pop  cx

				; jmp for_01
	
			end_for_01:

				
			mov ax, 4c00h ; exit( 0 )
			int 21h 

end			Start          
