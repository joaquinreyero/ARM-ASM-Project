	.globl app
	.global evento
app:
	//---------------- Inicialización GPIO --------------------

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.		
	
	// Configurar GPIO 17 como input:
	mov X21,#0
	str w21,[x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)   	
	
	mov X21,#576
	str w21,[x20,0] 		// Coloco 1 para los GPIO 2 y 3 en Function Select 0 (base)   	
	
	//---------------- Main code --------------------
	// X0 contiene la dirección base del framebuffer (NO MODIFICAR)
	
	mov w3, 0xFFFF    	// 0xFFFF = Blanco
	mov w11, 0x001F    //0x001F = azul
	add x10, x0, 0		// X10 contiene la dirección base del framebuffer
	mov w22, 0x4
	str w22, [x20, GPIO_GPSET0] 	// leo X22 y lo guardo en el registro GPIO Pin Output set 0
	//fondo de laberinto
	mov x2,512         	// Tamaño en Y
	setupfondo1:
	mov x1,512         	// Tamaño en X	
	setupfondo0:
	sturh w3,[x10]	   	// Setear el color del pixel N
	add x10,x10,2	   	// Siguiente pixel
	sub x1,x1,1	   		// Decrementar el contador X
	cbnz x1,setupfondo0	// Si no terminó la fila, volver a pintar
	sub x2,x2,1	   		// Decrementar el contador Y
	cbnz x2,setupfondo1	// Si no es la última fila, saltar

figures:
	//paredes externas
	//73,146,219,292,365,438,511
	mov x4,0		//se inicializa x
	mov x5,0		//se inicializa y
	mov x6,10		//se finaliza y
	mov x7,146		//se finaliza x
	mov w8,0xF000	//color rectangulo azul
	bl rectangle	//llama la funcion que deibuja la figura

	mov x4,220		
	mov x5,0		
	mov x6,10		
	mov x7,512		
	bl rectangle

	mov x4,502
	mov x5,0
	mov x6,219
	mov x7,512
	bl rectangle

	mov x4,502
	mov x5,293
	mov x6,512
	mov x7,512
	bl rectangle

	mov x4,0		
	mov x5,502	
	mov x6,512	
	mov x7,512		
	bl rectangle

	mov x4,0
	mov x5,0
	mov x6,512
	mov x7,10
	bl rectangle

	//paredes internas
	//primera fila
	mov x4,0
	mov x5,73
	mov x6,83
	mov x7,73
	bl rectangle

	mov x4,146
	mov x5,0
	mov x6,73
	mov x7,156
	bl rectangle
	
	mov x4,146
	mov x5,73
	mov x6,83
	mov x7,219
	bl rectangle

	mov x4,292
	mov x5,0
	mov x6,73
	mov x7,302
	bl rectangle
	
	mov x4,292
	mov x5,73
	mov x6,83
	mov x7,438
	bl rectangle
	
	//segunda fila
	mov x4,73
	mov x5,73
	mov x6,146
	mov x7,86
	bl rectangle
	
	mov x4,146
	mov x5,146
	mov x6,156
	mov x7,438
	bl rectangle

	//tercera fila
	mov x4,73
	mov x5,146
	mov x6,219
	mov x7,86
	bl rectangle
	
	mov x4,146
	mov x5,146
	mov x6,219
	mov x7,156
	bl rectangle
	
	mov x4,219
	mov x5,219
	mov x6,229
	mov x7,292
	bl rectangle

	mov x4,365
	mov x5,219
	mov x6,229
	mov x7,512
	bl rectangle

	//cuarta fila
	mov x4,73
	mov x5,219
	mov x6,292
	mov x7,86
	bl rectangle
	
	mov x4,146
	mov x5,219
	mov x6,292
	mov x7,156
	bl rectangle
	
	mov x4,146
	mov x5,292
	mov x6,302
	mov x7,219
	bl rectangle
	
	mov x4,292
	mov x5,219
	mov x6,292
	mov x7,302
	bl rectangle

	mov x4,292
	mov x5,292
	mov x6,302
	mov x7,365
	bl rectangle

	mov x4,438
	mov x5,219
	mov x6,292
	mov x7,448
	bl rectangle

	//quinta fila
	mov x4,0
	mov x5,365
	mov x6,375
	mov x7,73
	bl rectangle
	
	mov x4,146
	mov x5,365
	mov x6,375
	mov x7,219
	bl rectangle

	mov x4,365
	mov x5,292
	mov x6,365
	mov x7,375
	bl rectangle

	mov x4,365
	mov x5,365
	mov x6,375
	mov x7,448
	bl rectangle
	
	mov x4,438
	mov x5,292
	mov x6,365
	mov x7,448
	bl rectangle

	//sexta fila
	mov x4,73
	mov x5,365
	mov x6,438
	mov x7,86
	bl rectangle
	
	mov x4,146
	mov x5,365
	mov x6,438
	mov x7,156
	bl rectangle
	
	mov x4,146
	mov x5,438
	mov x6,448
	mov x7,292
	bl rectangle
	
	mov x4,292
	mov x5,365
	mov x6,438
	mov x7,302
	bl rectangle
	
	mov x4,365
	mov x5,438
	mov x6,448
	mov x7,512
	bl rectangle
	
	//septima fila
	mov x4,292
	mov x5,438
	mov x6,512
	mov x7,302
	bl rectangle

	//registros para el fondo
	mov x5, 1		// switch para el fondo
	mov x6, 31		// contador para cambio de color

coleccionables:
	mov w3, 0x07E0   	// 0x07E0 = verde
	mov x8,20			// eje x del jugador estatico
	mov x9,120          // eje y del jugador estatico
	add x12,x8,25       // final del eje x del jugador determina el TAMANIO
	bl triangle
	
	mov x8,320			// eje x del jugador estatico
	mov x9,30           // eje y del jugador estatico
	add x12,x8,25       // final del eje x del jugador determina el TAMANIO
	bl triangle

player1:
	mov w3, 0x0001   	// 0x0001 = Negro
	mov x8,170			// eje x del jugador estatico
	mov x9,30           // eje y del jugador estatico
	add x12,x8,25       // final del eje x del jugador determina el TAMANIO
	add x25,x9,13		// final eje y del jugador

player:
	bl inputRead
	and w23,w22,#0x20000  	// filtrar solamente este valor de w22 y almacenarlo en w23 (descartando posibles bits activados)
	cmp w23,#0x20000   		// ¿Esta el boton de abajo (GPIO17) siendo presionado?
	b.eq movder	  			// si es asi, procede a mover derecha
	and w23,w22,#0x4000  	// iltrar solamente este valor de w22 y almacenarlo en w23 (descartando posibles bits activados)
	cmp w23,#0x4000   		// ¿Esta el boton de arriba (GPIO14) siendo presionado?
	b.eq movarr	  			// si es asi, procede a mover abajo
	and w23,w22,#0x40000  	// filtrar solamente este valor de w22 y almacenarlo en w23 (descartando posibles bits activados)
	cmp w23,#0x40000   		// ¿Esta el boton de izquierda (GPIO18) siendo presionado?
	b.eq movab	   			// si es asi, procede a mover arriba
	and w23,w22,#0x8000  	// filtrar solamente este valor de w22 y almacenarlo en w23 (descartando posibles bits activados)
	cmp w23,#0x8000   		// Esta el boton de derecha (GPIO15) siendo presionado?
	b.eq movizq
	bl triangle      		//Si ninguno esta presionado no hay movimiento, a esperar
	b evento

movab:
	mov x19,x25			// se guarda en un auxiliar el final del eje y del jugador
	mov x26,x8			// se guarda en un auxiliar el eje x del jugador
	mov x23,14			// se guarda en un auxiliar contador (segun el tamanio del triangulo)
	bl gral
abcollision:
	mov x13,x8			// se guarda en un auxiliar el eje x del jugador
	mov x27,2			// se guarda en un auxiliar para posteriarmente moverse en el eje x
	mov x28,x12			// se guarda en un auxiliar el final del eje x del jugador
	bl collision

	add x18,x18,1024 	// aumenta un eje y
	sub x13,x12,x8 		// diferencia entre x
	mul x13,x13,x15   	// offset calculado
	sub x18,x18,x13   	// offset disminuido
	sub x23,x23,1   	// disminuye el contador
	cbnz x23, abcollision  // si no termino de revisar colisiones, vuelve a revisar
	add x9,x9,15  		// mueve el eje y del jugador abajo (la mitad del eje x)
	add x25,x25,15  	// mueve el eje y del jugador arriba  (la mitad del eje x)
	bl triangle
	b evento

movarr:
	mov x19,x9			// se guarda en un auxiliar el eje y del jugador
	mov x26,x8			// se guarda en un auxiliar el eje x del jugador
	mov x23,14			// se guarda en un auxiliar contador (segun el tamanio del triangulo)
	bl gral
arrcollision:
	mov x13,x8			// se guarda en un auxiliar el eje x del jugador
	mov x27,2			// se guarda en un auxiliar para posteriarmente moverse en el eje x
	mov x28,x12			// se guarda en un auxiliar el final del eje x del jugador
	bl collision

	sub x18,x18,1024 	// aumenta un eje y
	sub x13,x12,x8 		// diferencia entre x
	mul x13,x13,x15   	// offset calculado
	sub x18,x18,x13   	// offset disminuido
	sub x23,x23,1   	// disminuye el contador
	cbnz x23, arrcollision // si no termino de revisar colisiones, vuelve a revisar
	sub x9,x9,15  		// mueve el eje y del jugador arriba  (la mitad del eje x)
	sub x25,x25,15  	// mueve el eje y del jugador arriba  (la mitad del eje x)
	bl triangle
	b evento

movder:
	mov x19,x9			// se guarda en un auxiliar el eje y del jugador
	mov x26,x12			// se guarda en un auxiliar el final del eje x del jugador
	mov x23,28			// se guarda en un auxiliar contador (segun el tamanio del triangulo)
	bl gral
dercollision:
	mov x13,x9			// se guarda en un auxiliar el eje y del jugador
	mov x27,1024		// se guarda en un auxiliar para posteriarmente moverse en el eje y
	mov x28,x25			// se guarda en un auxiliar el final del eje y del jugador
	bl collision

	add x18,x18,2 		// aumenta un eje x
	sub x13,x25,x9 		// diferencia entre y
	mul x13,x13,x14   	// offset calculado
	sub x18,x18,x13   	// offset disminuido
	sub x23,x23,1   	// disminuye el contador
	cbnz x23, dercollision // si no termino de revisar colisiones, vuelve a revisar
	add x8,x8,30  		// mueve el eje x del jugador a la derecha
	add x12,x12,30 		// mueve el eje x final del jugador a la izquierda
	bl triangle
	b evento

movizq:
	mov x19,x9			// se guarda en un auxiliar el eje y del jugador
	mov x26,x8			// se guarda en un auxiliar el eje x del jugador
	mov x23,28			// se guarda en un auxiliar contador (segun el tamanio del triangulo)
	bl gral
izqcollision:
	mov x13,x9			// se guarda en un auxiliar el eje y del jugador
	mov x27,1024		// se guarda en un auxiliar para posteriarmente moverse en el eje y
	mov x28,x25			// se guarda en un auxiliar el final del eje y del jugador
	bl collision

	sub x18,x18,2 		// aumenta un eje x
	sub x13,x25,x9 		// diferencia entre y
	mul x13,x13,x14   	// offset calculado
	sub x18,x18,x13   	// offset disminuido
	sub x23,x23,1   	// disminuye el contador
	cbnz x23, izqcollision // si no termino de revisar colisiones, vuelve a revisar
	sub x8,x8,30  		// mueve el eje x del jugador a la izquierda
	sub x12,x12,30 		// mueve el eje x final del jugador a la izquierda
	bl triangle	
	
evento:
	cmp x8, 438
	b.lt verdeoff
	cmp x25, 219
	b.lt verdeoff
	cmp x25, 292
	b.gt verdeoff
	mov w22, 0x4
	str w22, [x20, GPIO_GPCLR0] 	// leo X22 y lo guardo en el registro GPIO Pin output clear 0, prendiendo el led verde
	b delay1
	verdeoff:
	mov w22, 0x4
	str w22, [x20, GPIO_GPSET0] 	// leo X22 y lo guardo en el registro GPIO Pin output set 0, apagando el led verde

delay1: 
	mov x2,0         	// Contador en Y, debe llegar a 512
	add x10,x0,0	    // x10 contiene la dirección base del framebuffer
	fondo2:
	mov x1,0         	// Condator en X, debe llegar a 512
fondo1:
	ldurh w16,[x10]		// tomar el color del pixel n
	cmp w16, 0xF000		// comparar si el pixel es parte del fondo
	b.eq fondo			// si lo es, avanzar a otro píxel
	cmp w16, 0x07E0		// compara si el pixel es parte del coleccionable
	b.eq fondo			// si lo es, avanza al otro pixel
	cmp w16, 0x0001		// comparar si el pixel es parte del rastro dejado por el jugador
	b.ne fondo0			// si no lo es, avanzar a otro píxel
	fondocheck:     
	cmp x1,x8			// verifica si esta en el mismo eje x que el jugador
	b.lt fondo0			// va al pintado de pixeles si esta antes que el jugador
	cmp x1,x12			// verifica si esta en el mismo eje x que el jugador
	b.gt fondo0			// va al pintado de pixeles si esta despues que el jugador
	cmp x2,x9 			// verifica si esta en el mismo eje y que el jugador
	b.lt fondo0			// va al pintado de pixeles si esta antes que el jugador
	cmp x2,x25 			// verifica si esta en el mismo eje y que el jugador
	b.lt fondo			// Saltea el pintado de pixeles si esta
fondo0:
	sturh w11,[x10]	   	// Setear el color del pixel N para volverlo fondo
fondo:
	add x10,x10,2	   	// Siguiente pixel
	add x1,x1,1	   		// Aumentar el contador X
	cmp x1,512
	b.ne fondo1	 		// Si no terminó la fila, volver a comprobar
	add x2,x2,1	   		// Aumentar el contador Y
	cmp x2,512
	b.ne fondo2	 		// Si no es la última fila, saltar
	bl doscolores
	// ------------------
				
	mov w22, 0x8
	str w22, [x20, GPIO_GPSET0] 	// leo X22 y lo guardo en el registro GPIO Pin set 0
	
	b player    //vuelve a dibujar el jugador solamente
		
infloop:
	b infloop
