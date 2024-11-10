.global _draw_robot

_draw_robot:
    mov x29, x30

    bl draw_head
    bl draw_body

    br x29

draw_head:
    mov x28, x30

    // Body Projection B
    mov x3, 280         // Xi
    mov x4, 277         // Yi
    mov x5, 293         // Xf
    mov x6, 182         // Yf
    mov w1, COLOR_DARK_BROWN
    bl _draw_rhomboid_b

    // Body Projection B Inside
    mov x3, 281         // Xi
    mov x4, 275         // Yi
    mov x5, 292         // Xf
    mov x6, 183         // Yf
    mov w1, COLOR_MID_BROWN
    bl _draw_rhomboid_b

    // Left Leg Projection B
    mov x3, 250         // Xi
    mov x4, 277         // Yi
    mov x5, 263         // Xf
    mov x6, 203         // Yf
    mov w1, COLOR_DARK_BROWN
    bl _draw_rhomboid_b

    // Body Projection B 
    mov x3, 251         // Xi
    mov x4, 275         // Yi
    mov x5, 262         // Xf
    mov x6, 204         // Yf
    mov w1, COLOR_BROWN
    bl _draw_rhomboid_b

    // Body Projection B Inside
    mov x3, 252         // Xi
    mov x4, 273         // Yi
    mov x5, 261         // Xf
    mov x6, 205         // Yf
    mov w1, COLOR_MID_BROWN
    bl _draw_rhomboid_b

    // Head Outline
    mov x3, 205         // Xi
    mov x4, 145         // Yi
    mov x5, 305         // Xf
    mov x6, 207         // Yf
    mov w1, COLOR_DARK_BROWN
    bl _draw_rectangle

    // Head Projection B
    mov x3, 305         // Xi
    mov x4, 206         // Yi
    mov x5, 318         // Xf
    mov x6, 131         // Yf
    bl _draw_rhomboid_b

    // Head Projection B Inside
    mov x3, 306         // Xi
    mov x4, 204         // Yi
    mov x5, 317         // Xf
    mov x6, 132         // Yf
    mov w1, COLOR_MID_BROWN
    bl _draw_rhomboid_b

    // Head Inside
    mov x3, 206         // Xi
    mov x4, 146         // Yi
    mov x5, 304         // Xf
    mov x6, 206         // Yf
    mov w1, COLOR_BROWN
    bl _draw_rectangle

    // Head Projection Outline
    mov x3, 204         // Xi
    mov x4, 145         // Yi
    mov x5, 318         // Xf
    mov x6, 131         // Yf
    mov w1, COLOR_DARK_BROWN
    bl _draw_rhomboid_A

    // Head Projection Inside
    mov x3, 206         // Xi
    mov x4, 144         // Yi
    mov x5, 316         // Xf
    mov x6, 132         // Yf
    mov w1, COLOR_MID_BROWN
    bl _draw_rhomboid_A

    // Right Eye
    mov x3, 280         // Xc
    mov x4, 170         // Yc
    mov x5, 12          // R
    mov w1, COLOR_WHITE
    bl _draw_circle
    mov x3, 277         // Xc
    mov x4, 170         // Yc
    mov x5, 5           // R
    mov w1, COLOR_BLACK
    bl _draw_circle
    mov x3, 276         // Xc
    mov x4, 168         // Yc
    mov x5, 1           // R
    mov w1, COLOR_WHITE
    bl _draw_circle

    // Left Eye
    mov x3, 230         // Xc
    mov x4, 170         // Yc
    mov x5, 12          // R
    mov w1, COLOR_WHITE
    bl _draw_circle
    mov x3, 227         // Xc
    mov x4, 170         // Yc
    mov x5, 5           // R
    mov w1, COLOR_BLACK
    bl _draw_circle
    mov x3, 226         // Xc
    mov x4, 168         // Yc
    mov x5, 1           // R
    mov w1, COLOR_WHITE
    bl _draw_circle

    // Smile
    mov x3, 255         // Xc
    mov x4, 185         // Yc
    mov x5, 15          // R
    mov w1, COLOR_BLACK
    bl _draw_semi_circle

    // Tongue
    mov x3, 258         // Xc
    mov x4, 185         // Yc
    mov x5, 7           // R
    mov w1, COLOR_RED
    bl _draw_semi_circle

    br x28

draw_body:
    mov x28, x30

    // Left Arm Projection Outline
    mov x3, 214         // Xi
    mov x4, 217         // Yi
    mov x5, 236         // Xf
    mov x6, 213         // Yf
    mov w1, COLOR_DARK_BROWN
    bl _draw_rhomboid_A

    // Left Arm Projection Inside
    mov x3, 216         // Xi
    mov x4, 216         // Yi
    mov x5, 234         // Xf
    mov x6, 214         // Yf
    mov w1, COLOR_MID_BROWN
    bl _draw_rhomboid_A

    // Body Outline
    mov x3, 230         // Xi
    mov x4, 207         // Yi
    mov x5, 280         // Xf
    mov x6, 258         // Yf
    mov w1, COLOR_DARK_BROWN
    bl _draw_rectangle

    // Body Inside
    mov x3, 231         // Xi
    mov x4, 208         // Yi
    mov x5, 279         // Xf
    mov x6, 257         // Yf
    mov w1, COLOR_BROWN
    bl _draw_rectangle

    // Left Arm Outline
    mov x3, 214         // Xi
    mov x4, 217         // Yi
    mov x5, 230         // Xf
    mov x6, 246         // Yf
    mov w1, COLOR_DARK_BROWN
    bl _draw_rectangle

    // Left Arm Inside
    mov x3, 215         // Xi
    mov x4, 218         // Yi
    mov x5, 229         // Xf
    mov x6, 245         // Yf
    mov w1, COLOR_BROWN
    bl _draw_rectangle

    // Right Arm Outline
    mov x3, 280         // Xi
    mov x4, 217         // Yi
    mov x5, 296         // Xf
    mov x6, 246         // Yf
    mov w1, COLOR_DARK_BROWN
    bl _draw_rectangle

    // Right Arm Projection B
    mov x3, 296         // Xi
    mov x4, 244         // Yi
    mov x5, 302         // Xf
    mov x6, 212         // Yf
    bl _draw_rhomboid_b

    // Right Arm Projection B Inside
    mov x3, 297         // Xi
    mov x4, 242         // Yi
    mov x5, 301         // Xf
    mov x6, 213         // Yf
    mov w1, COLOR_MID_BROWN
    bl _draw_rhomboid_b

    // Right Arm Inside
    mov x3, 281         // Xi
    mov x4, 218         // Yi
    mov x5, 295         // Xf
    mov x6, 245         // Yf
    mov w1, COLOR_BROWN
    bl _draw_rectangle

    // Right Arm Projection Outline
    mov x3, 280         // Xi
    mov x4, 217         // Yi
    mov x5, 302         // Xf
    mov x6, 212         // Yf
    mov w1, COLOR_DARK_BROWN
    bl _draw_rhomboid_A

    // Right Arm Projection Inside
    mov x3, 282         // Xi
    mov x4, 216         // Yi
    mov x5, 300         // Xf
    mov x6, 213         // Yf
    mov w1, COLOR_MID_BROWN
    bl _draw_rhomboid_A

    // Left Leg Outline
    mov x3, 230         // Xi
    mov x4, 258         // Yi
    mov x5, 250         // Xf
    mov x6, 278         // Yf
    mov w1, COLOR_DARK_BROWN
    bl _draw_rectangle

    // Left Leg Inside
    mov x3, 231         // Xi
    mov x4, 259         // Yi
    mov x5, 249         // Xf
    mov x6, 277         // Yf
    mov w1, COLOR_BROWN
    bl _draw_rectangle

    // Right Leg Outline
    mov x3, 260         // Xi
    mov x4, 258         // Yi
    mov x5, 280         // Xf
    mov x6, 278         // Yf
    mov w1, COLOR_DARK_BROWN
    bl _draw_rectangle

    // Right Leg Inside
    mov x3, 261         // Xi
    mov x4, 259         // Yi
    mov x5, 279         // Xf
    mov x6, 277         // Yf
    mov w1, COLOR_BROWN
    bl _draw_rectangle

    br x28
