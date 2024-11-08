.global _draw_robot

_draw_robot:
    mov x29, x30
    bl draw_face
    br x29

draw_face:
    mov x3, 128         // Xi
    mov x4, 128         // Yi
    mov x5, 384         // Xf
    mov x6, 384         // Yf
    mov w1, 0xF800      // Red
    b _draw_rectangle 
    