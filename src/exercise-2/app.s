	.globl app
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
	//x4: inicio x, x5: inicio y, x6: final y: x7, final x
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
	//mov w8,0x001E
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
	mov x7,83
	bl rectangle
	
	mov x4,146
	mov x5,146
	mov x6,156
	mov x7,438

	//tercera fila
	mov x4,73
	mov x5,146
	mov x6,219
	mov x7,83
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
	mov x7,83
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
	mov x6,365
	mov x7,302
	bl rectangle

	mov x4,292
	mov x5,365
	mov x6,375
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
	mov x7,438
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
	mov x7,83
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
	mov x7,412
	bl rectangle
	
	//septima fila
	mov x4,292
	mov x5,438
	mov x6,512
	mov x7,302
	bl rectangle
	//x4, inicio x, x5: inicio y, x6: final y: x7, final x
	//73,146,219,292,365,438,511
	
	mov x5, 1		// switch para rainbowparty
	mov x6, 31		// contador para color para rainbowparty
	mov x7, 1       // para funciones cortas, hace que el color dure más (para rainbowparty)

	coleccionables:
	mov w3, 0xffdf00   	// 0xffdf00 = amarillo
	mov x8,24			// eje x del jugador estatico
	mov x9,103          // eje y del jugador estatico
	add x12,x8,25       // final del eje x del jugador determina el TAMANIO
	bl playerdraw
	
	mov x8,316			// eje x del jugador estatico
	mov x9,30           // eje y del jugador estatico
	add x12,x8,25       // final del eje x del jugador determina el TAMANIO
	bl playerdraw

	mov x8,389			// eje x del jugador estatico
	mov x9,322          // eje y del jugador estatico
	add x12,x8,25       // final del eje x del jugador determina el TAMANIO
	bl playerdraw

	player1:
	mov w3, 0x0001   	// 0x0001 = Negro con lo justo para distinguirlo de 0
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
	bl playerdraw      		//Si ninguno esta presionado no hay movimiento, a esperar
	b evento

	movab:
	add x18,x0,0	    // x18 contiene la dirección base del framebuffer
	mov x14,1024       	// registro usado solo para almacenar este número
	mov x15,2          	// registro usado solo para almacenar este número
	add x19,x25,0	    // guardando en x19 la direccion a la que se quiere ir... porque no se puede aplicar el offset normalmente
	mul x17,x19,x14     // ajustando offset de pixeles en y para dibujar
	mul x24,x8,x15    	// ajustando offset de pixeles en x para dibujar
	add x17,x17,x24		// sumar ambos offset
	add x18,x18,x17    	// ajusta el offset a X18
	mov x23,14        	// contador (segun el tamanio del triangulo)
	mov w24,#0xF000  	// guardar el valor de las paredes en w24 (deshaciendose del valor anterior)
	abcheck1:
	mov x13,x8  	//contador para barrer en el eje x
	abcheck:
	ldurh w19,[x18]  	// toma el valor del color en la direccion a la que se va a mover (deshaciendose del valor anterior)
	cmp w24,w19      	// comparar si el camino esta libre
	b.eq redlight    	// si hay una pared de por medio, no moverse
	//cmp w19,0x001E   	// compara con bordes
	//b.eq redlight    	// si hay una pared de por medio, no moverse
	add x18,x18,2    	// avanza por el eje x
	add x13,x13,1  		// aumenta el contador para avanzar por el eje x
	cmp x13,x12
	b.lt abcheck    	// si no termino de barrer todo, vuelve
	add x18,x18,1024 	// aumenta un eje y
	sub x13,x12,x8 		// diferencia entre x
	mul x13,x13,x15   	// offset calculado
	sub x18,x18,x13   	// offset disminuido
	sub x23,x23,1   	// disminuye el contador
	cbnz x23, abcheck1  // si no termino de revisar colisiones, vuelve a revisar
	add x9,x9,15  		// mueve el eje y del jugador abajo (la mitad del eje x)
	add x25,x25,15  	// mueve el eje y del jugador arriba  (la mitad del eje x)
	bl playerdraw
	b evento
	
	movarr:
	add x18,x0,0	    // x18 contiene la dirección base del framebuffer
	mov x14,1024       	// registro usado solo para almacenar este número
	mov x15,2          	// registro usado solo para almacenar este número
	sub x19,x9,0    	// guardando en x19 la direccion a la que se quiere ir... porque no se puede aplicar el offset normalmente
	mul x17,x19,x14     // ajustando offset de pixeles en y para dibujar
	mul x24,x8,x15     	// ajustando offset de pixeles en x para dibujar
	add x17,x17,x24		// sumar ambos offset
	add x18,x18,x17    	// ajusta el offset a X18
	mov x23,14         	// contador  (segun el tamanio del triangulo)
	mov w24,#0xF000  	// guardar el valor de las paredes en w24 (deshaciendose del valor anterior)
	arrcheck1:
	mov x13,x8  	// contador para barrer en el eje x
	arrcheck:
	ldurh w19,[x18]  	// toma el valor del color en la direccion a la que se va a mover (deshaciendose del valor anterior)
	cmp w24,w19      	// comparar si el camino esta libre
	b.eq redlight    	// si hay una pared de por medio, no moverse
	cmp w19,0x001E   	// compara con bordes
	b.eq redlight    	// si hay una pared de por medio, no moverse
	add x18,x18,2    	// avanza por el eje x
	add x13,x13,1  		// aumenta el contador para avanzar por el eje x
	cmp x13,x12
	b.lt arrcheck    	// si no termino de barrer todo, vuelve
	sub x18,x18,1024 	// aumenta un eje y
	sub x13,x12,x8 		// diferencia entre x
	mul x13,x13,x15   	// offset calculado
	sub x18,x18,x13   	// offset disminuido
	sub x23,x23,1   	// disminuye el contador
	cbnz x23, arrcheck1 // si no termino de revisar colisiones, vuelve a revisar
	sub x9,x9,15  		// mueve el eje y del jugador arriba  (la mitad del eje x)
	sub x25,x25,15  	// mueve el eje y del jugador arriba  (la mitad del eje x)
	bl playerdraw
	b evento
	
	movder:
	add x18,x0,0	    // x18 contiene la dirección base del framebuffer
	mov x14,1024       	// registro usado solo para almacenar este número
	mov x15,2          	// registro usado solo para almacenar este número
	sub x19,x9,0    	// guardando en x19 la direccion a la que se quiere ir... porque no se puede aplicar el offset normalmente
	mul x17,x19,x14     // ajustando offset de pixeles en y para dibujar
	mul x24,x12,x15     // ajustando offset de pixeles en x para dibujar
	add x17,x17,x24		// sumar ambos offset
	add x18,x18,x17    	// ajusta el offset a X18
	mov x23,28         	// contador  (segun el tamanio del triangulo)
	mov w24,#0xF000  	// guardar el valor de las paredes en w24 (deshaciendose del valor anterior)
	dercheck1:
	mov x13,x9  	// contador para barrer en el eje y
	dercheck:
	ldurh w19,[x18]  	// toma el valor del color en la direccion a la que se va a mover (deshaciendose del valor anterior)
	cmp w24,w19      	// comparar si el camino esta libre
	b.eq redlight    	// si hay una pared de por medio, no moverse
	cmp w19,0x001E   	// compara con bordes
	b.eq redlight    	// si hay una pared de por medio, no moverse
	add x18,x18,1024    // avanza por el eje y
	add x13,x13,1  		// aumenta el contador para avanzar por el eje y
	cmp x13,x25
	b.lt dercheck    	// si no termino de barrer todo, vuelve
	add x18,x18,2 		// aumenta un eje x
	sub x13,x25,x9 		// diferencia entre y
	mul x13,x13,x14   	// offset calculado
	sub x18,x18,x13   	// offset disminuido
	sub x23,x23,1   	// disminuye el contador
	cbnz x23, dercheck1 // si no termino de revisar colisiones, vuelve a revisar
	add x8,x8,30  		// mueve el eje x del jugador a la derecha
	add x12,x12,30 		// mueve el eje x final del jugador a la izquierda
	bl playerdraw
	b evento

	movizq:
	add x18,x0,0	    // x18 contiene la dirección base del framebuffer
	mov x14,1024       	// registro usado solo para almacenar este número
	mov x15,2          	// registro usado solo para almacenar este número
	sub x19,x9,0    	// guardando en x19 la direccion a la que se quiere ir... porque no se puede aplicar el offset normalmente
	mul x17,x19,x14    	// ajustando offset de pixeles en y para dibujar
	mul x24,x8,x15     	// ajustando offset de pixeles en x para dibujar
	add x17,x17,x24		// sumar ambos offset
	add x18,x18,x17    	// ajusta el offset a X18
	mov x23,28         	// contador  (segun el tamanio del triangulo)
	mov w24,#0xF000  	// guardar el valor de las paredes en w24 (deshaciendose del valor anterior)
	izqcheck1:
	mov x13,x9  	//contador para barrer en el eje y
	izqcheck:
	ldurh w19,[x18]  	// toma el valor del color en la direccion a la que se va a mover (deshaciendose del valor anterior)
	cmp w24,w19      	// comparar si el camino esta libre
	b.eq redlight    	// si hay una pared de por medio, no moverse
	cmp w19,0x001E  	// compara con bordes
	b.eq redlight    	//s i hay una pared de por medio, no moverse
	add x18,x18,1024    // avanza por el eje y
	add x13,x13,1  		// aumenta el contador para avanzar por el eje y
	cmp x13,x25
	b.lt izqcheck    	// si no termino de barrer todo, vuelve
	sub x18,x18,2 		// aumenta un eje x
	sub x13,x25,x9 		// diferencia entre y
	mul x13,x13,x14   	// offset calculado
	sub x18,x18,x13   	// offset disminuido
	sub x23,x23,1   	// disminuye el contador
	cbnz x23, izqcheck1 // si no termino de revisar colisiones, vuelve a revisar
	sub x8,x8,30  		// mueve el eje x del jugador a la izquierda
	sub x12,x12,30 		// mueve el eje x final del jugador a la izquierda
	bl playerdraw	
	b evento
	
	redlight:
	mov w22, 0x8
	str w22, [x20, GPIO_GPCLR0] 	// leo X22 y lo guardo en el registro GPIO Pin clear 0
	
	evento:
	//cmp x8,219		//verifica si esta en la porcion correcta del laberinto
	//b.lt verdeoff	// apaga el led verde si esta en el eje x inapropiado
	//cmp x8,292		//verifica si esta en la porcion correcta eje x del laberinto
	//b.gt verdeoff	// apaga el led verde si esta en el eje x inapropiado
	//cmp x25,438		//verifica si esta en la porcion correcta del eje y del laberinto
	//b.lt verdeoff	// apaga el led verde si esta en el eje y inapropiado
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
	refondo2:
	mov x1,0         	// Condator en X, debe llegar a 512
	refondo1:
	ldurh w16,[x10]		// tomar el color del pixel n
	//cmp w16, 0x001E	// comparar si el pixel es parte del fondo
	//b.eq refondo		// si lo es, avanzar a otro píxel
	cmp w16, 0xF000		// comparar si el pixel es parte del fondo
	b.eq refondo		// si lo es, avanzar a otro píxel
	cmp w16, 0xffdf00	// compara si el pixwl es parte del coleccionable
	b.eq refondo		// si lo es, avanza al otro pixel
	cmp w16, 0x0001		// comparar si el pixel es parte del rastro dejado por el jugador
	b.ne refondo0		// si no lo es, avanzar a otro píxel
	refondocheck:     
	cmp x1,x8			// verifica si esta en el mismo eje x que el jugador
	b.lt refondo0		// va al pintado de pixeles si esta antes que el jugador
	cmp x1,x12			// verifica si esta en el mismo eje x que el jugador
	b.gt refondo0		// va al pintado de pixeles si esta despues que el jugador
	cmp x2,x9 			// verifica si esta en el mismo eje y que el jugador
	b.lt refondo0		// va al pintado de pixeles si esta antes que el jugador
	cmp x2,x25 			// verifica si esta en el mismo eje y que el jugador
	b.lt refondo		// Saltea el pintado de pixeles si esta, finalmente, dentro del jugador. El jugador es un cuadrado al final
	refondo0:
	sturh w11,[x10]	   	// Setear el color del pixel N para volverlo fondo
	refondo:
	add x10,x10,2	   	// Siguiente pixel
	add x1,x1,1	   		// Aumentar el contador X
	cmp x1,512
	b.ne refondo1	 	// Si no terminó la fila, volver a comprobar
	add x2,x2,1	   		// Aumentar el contador Y
	cmp x2,512
	b.ne refondo2	 	// Si no es la última fila, saltar
	bl rainbowParty
	// ------------------
				
	mov w22, 0x8
	str w22, [x20, GPIO_GPSET0] 	// leo X22 y lo guardo en el registro GPIO Pin set 0
	
	b player    //vuelve a dibujar el jugador solamente
		
		
	infloop:
	b infloop
//----definicion de registros----//
//x0: direccion base de framebuffer (no borrar)
//x1: tamanio en y de la pantalla
//x2: tamanio en x de la pantalla
//w3: donde va el color que se envia al framebuffer
//x4: En rectangulo, inicio x de la figura. Inusado fuera de eso 
//x5: En rectangulo, inicio y de la figura. en rainbowparty luego
//x6: En rectangulo, final y de la figura. en rainbowparty luego
//x7: En rectangulo, final x de la figura. en rainbowparty luego
//x8: auxiliar para rectangulo, eje x del jugador despues
//x9: auxiliar para rectangulo, eje y del jugador despues
//x10: direccion base del framebuffer MAS el offset en pixeles
//x11: auxiliar color rainbowparty
//x12: auxiliar para rectangulo y despues final x del jugador
//x13: auxiliar para rectangulo y despues para jugador
//x14: auxiliar para rectangulo y despues para jugador (almacena un numero)
//x15: auxiliar para rectangulo y despues para jugador (almacena un numero)
//w16: usado para el refondo, donde se carga el valor del color en un pixel (auxiliar de lo contrario)
//x17: auxiliar para jugador y de color
//x18: auxiliar de color y jugador
//x19: auxiliar de color y jugador
//w20: direccion de GPIO, no borrar
//x21: para GPIO al inicio, auxiliar despues
//x22: para GPIO exclusivamente
//x23: auxiliar para GPIO y colisiones
//x24: auxiliar
//x25: auxiilar eje Y final del jugador (cuantos son...)
//x26:
//x27:
//x28:
//x29:
//x30: para link, no borrar

//GPIO14=arriba, GPIO17=abajo, GPIO18=izquierda, GPIO15=derecha
//led rojo=GPIO3, led verde=GPIO2
//-----//

