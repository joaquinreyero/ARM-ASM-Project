.global _draw_bg

//  --- _draw_bg ---
//  Draw the background in gradient and then draw bubbles.
_draw_bg:
    mov x3, x0
    mov x4, #SCREEN_Y      // Yc
    mov x7, 16             // Ri (16)
    mov x8, 59             // Gi (59)
    mov x9, 30             // Bi (30)
    mov x10, 10            // Rf (10)
    mov x11, 37            // Gf (37)
    mov x12, 29            // Bf(29)
    sub x13, x10, x7        // dr
    lsl x13, x13, 16        
    sdiv x13, x13, x4       // Increment in R
    sub x14, x11, x8        // dg
    lsl x14, x14, 16        
    sdiv x14, x14, x4       // Increment in G
    sub x15, x12, x9        // db 
    lsl x15, x15, 16        
    sdiv x15, x15, x4       // Increment in B
    lsl x7, x7, 16         // ra
    lsl x8, x8, 16         // ga
    lsl x9, x9, 16         // ba
bg_loop_y:
    mov x5, #SCREEN_X       // Xc
    mov x16, x7             // R_line
    mov x17, x8             // G_line
    mov x18, x9             // B_line
bg_loop_x:
    lsr x19, x16, 16       // R 
    lsr x20, x17, 16       // G 
    lsr x21, x18, 16       // B 
    and x19, x19, 0x1F     // R[4:0]
    and x20, x20, 0x3F     // G[5:0]
    and x21, x21, 0x1F     // B[4:0]
    lsl x19, x19, 11       // x19 = R << 11
    lsl x20, x20, 5        // x20 = G << 5
    orr x19, x19, x20      // x19 = (R << 11) | (G << 5)
    orr x19, x19, x21      // x19 = (R << 11) | (G << 5) | B
    mov w1, w19            // w1 = x19[15:0]
    strh w1, [x3], #2       
    subs x5, x5, #1         // x5--
    bne bg_loop_x           // If x5 != 0
    add x7, x7, x13         // Ra += Increment in R
    add x8, x8, x14         // Ga += Increment in G
    add x9, x9, x15         // Ba += Increment in B
    subs x4, x4, #1         // x4--
    bne bg_loop_y           // If x4 != 0
    
draw_bubbles:
    mov x29, x30

    // - Bubbles - //

    mov x3, 0               // Xcenter
    mov x4, 0               // Ycenter
    mov x5, 42              // Radius
    mov w1, 0x62C8       // Color
    bl _draw_circle

    mov x3, 200               // Xcenter
    mov x4, 20               // Ycenter
    mov x5, 33              // Radius
    mov w1, 0x5599       // Color
    bl _draw_circle

    mov x3, 480               // Xcenter
    mov x4, 260               // Ycenter
    mov x5, 34              // Radius
    mov w1, 0x3AA0       // Color
    bl _draw_circle

    mov x3, 30               // Xcenter
    mov x4, 100               // Ycenter
    mov x5, 30              // Radius
    mov w1, 0x42A8       // Color
    bl _draw_circle

    mov x3, 380               // Xcenter
    mov x4, 60               // Ycenter
    mov x5, 50              // Radius
    mov w1, 0x4BB0       // Color
    bl _draw_circle

    mov x3, 480               // Xcenter
    mov x4, 104               // Ycenter
    mov x5, 40              // Radius
    mov w1, 0x53B8       // Color
    bl _draw_circle

    mov x3, 400             // Xcenter
    mov x4, 460             // Ycenter
    mov x5, 27              // Radius
    mov w1, 0x5BC0       // Color
    bl _draw_circle  

    mov x3, 100             // Xcenter
    mov x4, 320             // Ycenter
    mov x5, 20              // Radius
    mov w1, 0x3AA0       // Color
    bl _draw_circle  

    mov x3, 20             // Xcenter
    mov x4, 257             // Ycenter
    mov x5, 25              // Radius
    mov w1, 0x62C8       // Color
    bl _draw_circle  

    mov x3, 430             // Xcenter
    mov x4, 380             // Ycenter
    mov x5, 40              // Radius
    mov w1, 0x6AD0       // Color
    bl _draw_circle    

    mov x3, 100             // Xcenter
    mov x4, 460             // Ycenter
    mov x5, 60              // Radius
    mov w1, 0x7ADF       // Color
    bl _draw_circle  

    mov x3, 40             // Xcenter
    mov x4, 420             // Ycenter
    mov x5, 49              // Radius
    mov w1, 0x83E7       // Color
    bl _draw_circle  

    
    mov x3, 256             // Xcenter
    mov x4, 440             // Ycenter
    mov x5, 27              // Radius
    mov w1, 0x8BEF       // Color
    bl _draw_circle      

    // ... //

    // - End Bubbles - //

    br x29


