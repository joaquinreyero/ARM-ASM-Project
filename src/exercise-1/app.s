.globl app

app:
    mov x10, x0 // X10 contains the framebuffer base address
    mov w3, 0x0000, // Black 

clear_screen_y:
    mov x2, #SCREEN_Y 
clear_screen_x:
    mov x1, #SCREEN_X
clear: 
    sturh w3,[x10]	   	// Set color of pixel N
	add x10,x10,2	   	// Next pixel
	sub x1,x1,1	   		// Decrement X counter
	cbnz x1,clear	   	// If not end of row, jump
	sub x2,x2,1	   		// Decrement Y counter
	cbnz x2,clear_screen_x	  	// If not end of screen, jump

    
    // --- Infinite loop ---
InfLoop:
    b InfLoop

