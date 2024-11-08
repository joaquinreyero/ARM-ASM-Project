.global _draw_rectangle

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
    sub x9, x5, x3      // X = Xf - Xi
    sub x10, x6, x4     // Y = Yf - Yi
    mov x12, 0          // AuxY
    lsl x4, x4, 9       // Yi * 512
loop0:
    cmp x12, x10        // AuxY == Y
    beq end
    mov x11, 0          // AuxX
loop1:
    cmp x11, x9         // AuxX != X
    bne loop2
    add x12, x12, 1     // AuxY ++
    b loop0
loop2:
    add x13, x3, x11    // Aux1 = Xi + AuxX
    lsl x14, x12, 9     // Aux2 = AuxY * 512
    add x14, x14, x13   // + (AuxY * 512) 
    add x14, x14, x4    // + (Yi * 512)
    lsl x14, x14, 1     // * 2
    add x14, x14, x0    // + FB
    sturh w1, [x14]	   	
    add x11, x11, 1     // AuxX ++
    b loop1
end:
    ret
    