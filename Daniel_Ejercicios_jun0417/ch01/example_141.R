rm(list=ls())

datos <- read.csv("EXA_C01_S04_01.csv")

print(datos)

attach(datos)

plot(AGE)

me <- mean(AGE)

points(c(0, 200), c(me, me), type='l', col='red', lwd=4)

text(0, 80, ' poblacion de edades', pos=4, cex=.7, col='blue')