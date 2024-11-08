.global _draw_bg

_draw_bg:
	mov x3, x0
	mov x4, #SCREEN_Y
	mov w1, 0x001F
reset_x:
    mov x5, #SCREEN_X
paint: 
    sturh w1, [x3]	   	
	add x3, x3, 2	   	// Next pixel 
	sub x5, x5, 1	   	// -- X
	cbnz x5, paint	   	
	sub x4, x4, 1	   	// -- Y 
	cbnz x4, reset_x
	ret	
