
distancia <- function(p1, p2){
# calcula la distanciua entre dos puntos
# p1 es un vector de coordenadas (x1, y1)
# 	p2 es un vector de coordenadas (x2, y2)

 dis <- sqrt((p2[1]-p1[1])^2 + (p2[2]-p1[2])^2)
	
}

#ejemplos

d1 <- distancia(c(0,0), c(2,2))

x <- c(0,0)
y <- c(3, 4)

print(d1)
print(distancia(x, y))