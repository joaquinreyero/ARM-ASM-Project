//--------DEFINICIÓN DE FUNCIONES-----------//
    .global inputRead    
	//DESCRIPCION: Lee botones en el GPIO. 
	
    .global rectangle
	//descripcion: dibujar un rectangulo en la pantalla dadas las coordenadas en x4,x5,x6 y x7.
	
	.global rainbowParty
	//descripcion: en una idea similar al ejercicio 1, configura el color que el fondo obtendra.
//------FIN DEFINICION DE FUNCIONES-------//

inputRead: 	
	ldr w22, [x20, GPIO_GPLEV0] 	// Leo el registro GPIO Pin Level 0 y lo guardo en X22
		
    br x30 		//Vuelvo a la instruccion link
    
    
rectangle:
	//x4, inicio x, x5: inicio y, x6: final y, x7, final x
	add x10,x0,0	    // X10 contiene la dirección base del framebuffer, restaurando
	mov x14,1024       //registro usado solo para almacenar este número
	mov x15,2          //registro usado solo para almacenar este número
	mul x9,x5,x14      // ajustando offset de pixeles en y
	mul x12,x4,x15     // ajustando offset de pixeles en x
	add x9,x9,x12	   // sumar offset
	add x10,x10,x9    // offset ajustado
	add x12,x5,0      //contador y
loopr1:
	add x9,x4,0    //contador x
loopr0:
	sturh w8,[x10]	   	// Setear el color del pixel N
	add x10,x10,2	   	// Siguiente pixel
	add x9,x9,1	   	// Aumentar el contador X
	cmp x9,x7 
	b.ne loopr0		// Si no terminó la fila de la figura, volver a pintar
	add x12,x12,1	   	// Aumentar el contador Y
	sub x13,x7,x4		
	mul x13,x13,x15	//multiplica por 2 para ajustar por pixeles
	sub x13,x14,x13	//calcula la distancia al inicio de la próxima fila de la figura (en contador para pixeles)
	add x10,x10,x13     //suma la distancia para dibujar correctamente
	cmp x12,x6
	b.ne loopr1	  	// Si no es la última fila, saltar
	
	 br x30 		//Vuelvo a la instruccion link
	 
	 
rainbowParty:		
	cmp x5, 1		//Pasa por las 6 funciones de color
	beq bluemagenta
	cmp x5, 2
	beq magentared
	cmp x5, 3
	beq redyellow
	cmp x5, 4
	beq yellowgreen
	cmp x5, 5
	beq greenturquoise
	cmp x5, 6
	beq turquoiseblue
	b loop0
bluemagenta:
	add w11,w11,0x0800     // pasar de azul a magenta sumando bits de rojo
	sub x6,x6,1        // resta segun va avanzando en el valor de rojo
	cmp x6,xzr	      // para banderas de cero
	bne loop0	      // Si no terminó con el color pasa directamente a loop0
	mov x5,2        //cambiamos de funcion
	mov x6,31       // restauramos el contador
	b loop0
magentared:
	sub w11,w11,0x0001    // pasar de magenta a rojo restando bits de azul
	sub x6,x6,1	// resta segun va avanzando en el valor de azul
	cmp x6,xzr	      // para banderas de cero
	bne loop0	      // 
	mov x5,3        //cambiamos de funcion
	mov x6,63       // restauramos el contador
	b loop0
redyellow:
	add w11,w11,0x0020    // pasar de rojo a amarillo sumando bits de verde
	sub x6,x6,1
	cmp x6,xzr	      // para banderas de cero
	bne loop0	      // 
	mov x5,4        //cambiamos de funcion
	mov x6,31       // restauramos el contador
	b loop0
yellowgreen:
	sub w11,w11,0x0800    // pasar de amarillo a verde restando bits de rojo
	sub x6,x6,1	// resta segun va avanzando en el valor de rojo
	cmp x6,xzr	      // para banderas de cero
	bne loop0	      // 
	mov x5,5        //cambiamos de funcion
	mov x6,31       // restauramos el contador
	b loop0
greenturquoise:
	add w11,w11,0x0001    // pasar de verde a celeste sumando bits de azul
	sub x6,x6,1		// resta segun va avanzando en el valor de azul
	cmp x6,xzr	      // para banderas de cero
	bne loop0	      // 
	mov x5,6        //cambiamos de funcion
	mov x6,63       // restauramos el contador
	b loop0
turquoiseblue:
	sub w11,w11,0x0020    // pasar de celeste a azul restando bits de verde
	sub x6,x6,1
	cmp x6,xzr	      // para banderas de cero
	bne loop0	      // 
	mov x5,1        //cambiamos de funcion
	mov x6,31       // restauramos el contador	
	b loop0
loop0:
	br x30 		//Vuelvo a la instruccion link
