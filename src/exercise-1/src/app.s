.global _app

_app:
    bl _draw_bg
    bl _draw_robot
    
// --- Infinite loop ---
InfLoop:
    b InfLoop
