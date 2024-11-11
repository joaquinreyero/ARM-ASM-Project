//--------DEFINICIÓN DE FUNCIONES-----------//
    .global inputRead    
	//DESCRIPCION: Lee botones en el GPIO. 
	
    .global rectangle
	//descripcion: dibujar un rectangulo en la pantalla dadas las coordenadas en x4,x5,x6 y x7.
	
	.global triangle
	//descripcion: dibuja un triangulo en la pantalla dadas cordenadas en x8,x9 y x12
	
	.global gral
	//descripcion: determina el calculo de la direccion del framebuffer
	
	.global collision
	//descripcion: determina si el jugador se puede mover
	
	.global doscolores
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

	 
triangle:
	add x10, x0, 0		//X10 contiene la dirección base del framebuffer
	mov x14,1024       	//registro usado solo para almacenar este número
	mov x15,2          	//registro usado solo para almacenar este número
	mul x17,x9,x14      //ajustando offset de pixeles en y para dibujar
	mul x24,x8,x15     	//ajustando offset de pixeles en x para dibujar
	add x17,x17,x24		//sumar ambos offset
	add x10,x10,x17    	//ajusta el offset a X10
	add x18,x8,0     	//contador inicio x
	add x21,x8,0   		//contador secundario inicio x (cuenta como inicio para... x18)
	add x19,x12,0   	//contador final x
loopp0:  
	sturh w3,[x10]	   	// Setear el color del pixel N
	add x10,x10,2	   	// Siguiente pixel
	add x18,x18,1	   	// Aumentar el contador X
	cmp x18,x19 
	b.ne loopp0			//Si no terminó la fila del jugador, volver a pintar
	add x21,x21,1		//aumenta el inicio de x, para simular el triángulo
	add x18,x21,0		//reinicia el contador x18
	sub x16,x19,x21		//resta la diferencia entre el final x actual y el inicio x actual, guardándolo en x16 como temporal
	sub x19,x19,1	 	// Disminuye el final de x, para simular el triángulo
	mul x16,x16,x15		//multiplica por 2 para ajustar por pixeles
	sub x16,x14,x16		//calcula la distancia al inicio de la próxima fila de la figura (en contador para pixeles)
	add x10,x10,x16     //suma la distancia para dibujar correctamente
	cmp x21,x19	  		//compara los contadores de x	
	b.lt loopp0			//Si no es la última fila de triángulo, saltar

	br x30	 


gral:
	add x18,x0,0	    // x18 contiene la dirección base del framebuffer
	mov x14,1024       	// registro usado solo para almacenar este número
	mov x15,2          	// registro usado solo para almacenar este número

	mul x17,x19,x14     // ajustando offset de pixeles en y para dibujar
	mul x24,x26,x15    	// ajustando offset de pixeles en x para dibujar
	add x17,x17,x24		// sumar ambos offset
	add x18,x18,x17    	// ajusta el offset a X18
	mov w24,#0xF000  	// guardar el valor de las paredes en w24 (deshaciendose del valor anterior)
	
	br x30


collision:
	ldurh w19,[x18]  	// toma el valor del color en la direccion a la que se va a mover (deshaciendose del valor anterior)
	cmp w24,w19      	// comparar si el camino esta libre
	b.eq redlight    	// si hay una pared de por medio, no moverse
	add x18,x18,x27    	// avanza por el eje x
	add x13,x13,1  		// aumenta el contador para avanzar por el eje x
	cmp x13,x28
	b.lt collision    	// si no termino de barrer todo, vuelve
	
	br x30

redlight:
	mov w22, 0x8
	str w22, [x20, GPIO_GPCLR0] 	// leo X22 y lo guardo en el registro GPIO Pin clear 0
	bl evento


doscolores:		
	cmp x5, 1		
	beq bluemagenta
	cmp x5, 2
	beq magentablue
	b loop0

bluemagenta:
	add w11,w11,0x0800     // pasar de azul a magenta sumando bits de rojo
	sub x6,x6,1        // resta segun va avanzando en el valor de rojo
	cmp x6,xzr	      // para banderas de cero
	bne loop0	      // Si no terminó con el color pasa directamente a loop0
	mov x5,2        //cambiamos de funcion
	mov x6,31       // restauramos el contador
	b loop0

magentablue:
    sub w11,w11,0x0800     // pasar de magenta a azul restando bits de rojo
    sub x6,x6,1            // incrementa según va avanzando en el valor de rojo
    cmp x6,xzr              // para banderas de cero
    bne loop0                // Si no terminó con el color pasa directamente a loop0
    mov x5,1                // cambiamos de funcion
    mov x6,31               // restauramos el contador
    b loop0

loop0:
	br x30 		//Vuelvo a la instruccion link
