.global _draw_rectangle
.global _draw_rhomboid_A
.global _draw_rhomboid_b
.global _draw_circle
.global _draw_semi_circle
.global _draw_triangle_a
.global _draw_triangle_b

//  --- draw_rectangle ---
//  Draw a rectangle from a left up Position(Xi,Yi) and a right down Position(Xf,Yf).
//  All positions are in pixels.
//  Params:
//  x3: Xi 
//  x4: Yi
//  x5: Xf
//  x6: Yf
//  w1: Color
_draw_rectangle:
    sub x9, x5, x3              // X = Xf - Xi
    sub x10, x6, x4             // Y = Yf - Yi
    mov x12, 0                  // AuxY
    lsl x4, x4, 9               // Yi * 512
    loop0:
        cmp x12, x10            // AuxY == Y
        beq end
        mov x11, 0              // AuxX
    loop1:
        cmp x11, x9             // AuxX != X
        bne loop2
        add x12, x12, 1         // AuxY ++
        b loop0
    loop2:
        add x13, x3, x11        // Aux1 = Xi + AuxX
        lsl x14, x12, 9         // Aux2 = AuxY * 512
        add x14, x14, x13       // + (AuxY * 512) 
        add x14, x14, x4        // + (Yi * 512)
        lsl x14, x14, 1         // * 2
        add x14, x14, x0        // + FB
        sturh w1, [x14]	   	
        add x11, x11, 1         // AuxX ++
        b loop1


///  --- _draw_rhomboid_A ---
//  Draw a rhomboid from a left down Position(Xi,Yi) and a right up Position(Xf,Yf).
//  All positions are in pixels.
//  Params:
//  x3: Xi 
//  x4: Yi
//  x5: Xf
//  x6: Yf
//  w1: Color
_draw_rhomboid_A:
    sub x9, x5, x3              // X9 = Lenght(X) Total
    sub x10, x4, x6             // X10 = Height(Y)
    sub x9, x9, x10             // X9
    lsl x4, x4, 9               // Yi * 512
    mov x11, 0                  // Yc 
    loop_y_in_a:
        cmp x11, x10            // Yc == Y
        beq end
        mov x12, 0              // Xc
    loop_x_out_a:
        cmp x12, x9             // Xc != (X)
        bne loop_x_in_a
        add x11, x11, 1         // Yc ++
        b loop_y_in_a
    loop_x_in_a:    
        add x13, x3, x12        // + (Xi + Xc)
        add x13, x13, x4        // + (Yi * 512)
        lsl x14, x11, 9         // Aux2 = Yc * 512
        sub x14, x13, x14       // (Yi + (Xi + Xc) - Yc * 512)
        add x14, x14, x11       // + Yc
        lsl x14, x14, 1         // * 2
        add x14, x14, x0        // + FB
        sturh w1, [x14] 
        add x12, x12, 1         // Xc ++
        b loop_x_out_a


///  --- _draw_rhomboid_b ---
//  Draw a rhomboid from a left down Position(Xi,Yi) and a right up Position(Xf,Yf).
//  All positions are in pixels.
//  Params:
//  x3: Xi 
//  x4: Yi
//  x5: Xf
//  x6: Yf
//  w1: Color 
_draw_rhomboid_b:
    mov x27, x30

    mov x26, x6                     // x26 = Yf 
    mov x24, x4                     // x24 = x4            
    sub x22, x5, x3                 // dx
    sub x6, x4, x22                 // Yf = Yi + dx          
    bl _draw_triangle_b
    add x4, x26, x22                // Yi = Yf + dx
    add x6, x6, 1                   // Adjust Yf
    mov x24, x4
    bl _draw_rectangle
    mov x4, x24                          
    mov x6, x26                     // Yi = Yi + dx
    bl _draw_triangle_a
    
    br x27


//  --- _draw_triangle_a ---
//  Draw a triangle from a left down Position(Xi,Yi) and a right up Position(Xf,Yf).
//  All positions are in pixels.
//  Params:
//  x3: Xi 
//  x4: Yi
//  x5: Xf
//  x6: Yf
//  w1: Color
_draw_triangle_a:
    sub x9, x5, x3                      // dx
    sub x10, x4, x6                     // dy
    lsl x4, x4, 9                       // * 512
    mov x11, 0                          // i
    loop_y_out_triangle_a:    
        cmp x11, x10                    // i == dy
        beq end
        mov x12, 0                      // j
    loop_y_in_triangle_a:    
        cmp x12, x9                     // j == dx
        bne loop_x_in_triangle_a
        add x11, x11, 1                 // i ++
        sub x9, x9, 1                   // dx --
        b loop_y_out_triangle_a
    loop_x_in_triangle_a:
        add x13, x3, x12                // x13 = Xi + j
        add x13, x13, x11               // + i
        add x13, x13, x4                // + Yi
        lsl x14, x11, 9                 // x14 = i * 512
        sub x13, x13, x14               // - i * 512
        lsl x13, x13, 1                 // * 2
        add x13, x13, x0                // + FB
        sturh w1, [x13]
        add x12, x12, 1                 // j ++
        b loop_y_in_triangle_a 


//  --- _draw_triangle_b ---
//  Draw a triangle from a left down Position(Xi,Yi) and a right up Position(Xf,Yf).
//  All positions are in pixels.
//  Params:
//  x3: Xi 
//  x4: Yi
//  x5: Xf
//  x6: Yf
//  w1: Color
_draw_triangle_b:
    sub x9, x5, x3                      // dx
    sub x10, x4, x6                     // dy
    lsl x4, x4, 9                       // * 512
    mov x11, 0                          // i
    mov x15, 1
    loop_y_out_triangle_b:    
        cmp x11, x10                    // i == dy
        beq end
        mov x12, 0                      // j
    loop_y_in_triangle_b:    
        cmp x12, x15                    // j == x15
        bne loop_x_in_triangle_b
        add x11, x11, 1                 // i ++
        add x15, x11, 1                 // x15 = i
        b loop_y_out_triangle_b 
    loop_x_in_triangle_b:
        add x13, x3, x12                // x13 = Xi + j
        add x13, x13, x4                // + Yi
        lsl x14, x11, 9                 // x14 = i * 512
        sub x13, x13, x14               // - i * 512
        lsl x13, x13, 1                 // * 2
        add x13, x13, x0                // + FB
        sturh w1, [x13]
        add x12, x12, 1                 // j ++
        b loop_y_in_triangle_b


///  --- _draw_circle ---
//  Draw a circle from a given radius and the middle point.
//  All positions are in pixels.
//  Params:
//  x3: Xc
//  x4: Yc
//  x5: R
//  w1: Color
_draw_circle:
    mov x2, #SCREEN_Y 
    mul x6, x5, x5              // r ^ 2
    sub x7, x4, x5              // y_start
    add x8, x4, x5              // y_end
    loop_y:
        cmp x7, x8              // ¿Y > y_end?
        bgt end   
        sub x9, x3, x5          // x9 = x_start
        add x10, x3, x5         // x10 = x_end
        mov x11, x9             // x11 = X actual
    loop_x:
        cmp x11, x10            // ¿X > x_end?
        bgt next_y              
        sub x12, x11, x3        // dx
        sub x13, x7, x4         // dy
        mul x14, x12, x12       // dx^2
        mul x15, x13, x13       // dy^2
        add x14, x14, x15       // dx^2 + dy^2
        cmp x14, x6
        bls draw_pixel          // If (dx^2 + dy^2) <= radius_squared 
    skip_pixel:
        add x11, x11, 1
        b loop_x
    draw_pixel:
        cmp x11, 0
        blt increment_x         // If X < 0
        cmp x11, x2
        bge increment_x         // If X >= SCREEN_WIDTH
        cmp x7, 0
        blt increment_x         // If Y < 0
        mov x16, #SCREEN_X
        cmp x7, x16
        bge increment_x         // If Y >= SCREEN_HEIGHT
        mul x17, x7, x2         // Y * SCREEN_WIDTH
        add x17, x17, x11       // Y * SCREEN_WIDTH + X
        lsl x17, x17, #1        // * 2
        add x17, x0, x17        // + FB 
        sturh w1, [x17]
    increment_x:
        add x11, x11, #1
        b loop_x
    next_y:
        add x7, x7, #1
        b loop_y


///  --- _draw_semi_circle ---
//  Draw a semi circle from a given radius and the middle point.
//  All positions are in pixels.
//  Params:
//  x3: Xc
//  x4: Yc
//  x5: R
//  w1: Color
_draw_semi_circle:
    mov x2, #SCREEN_X         
    mul x6, x5, x5              // r * r
    add x7, x4, 1               // y_start 
    add x8, x4, x5              // y_end
    b loop_y


end:
    ret
