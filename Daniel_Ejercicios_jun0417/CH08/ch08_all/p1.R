rm(list=ls())

datos = read.csv("EXA_C08_S02_01.csv", header=T)

Graf <- function(y1=0, del1=0){
	n1 = length(y1)
	x1 = (1:n1)+del1
	m1 = mean(y1)
	points(x1, y1, pch=16)
	points(c(0,n1)+del1, c(m1,m1), type='l', lwd=3)
}

cat1 <- function(let='', var){
	cat(let, ' = ', round(var,2), '\n')
}

print(names(datos))

attach(datos)

y1 = NRB[!is.na(NRB)]
y2 = RRB[!is.na(RRB)]
y3 = SQU[!is.na(SQU)]
y4 = VEN[!is.na(VEN)]

ylista = list(y1, y2, y3, y4)
y = c(y1, y2, y3, y4)

ylabt = c('NRB', 'RRB', 'SQU', 'VEN')

np = sapply(ylista, length)
media = sapply(ylista, mean)

plot(1:np[1], y1, xlim=c(0, 200), ylim=c(-20, 160), pch=16)
points(c(0,np[1]), c(media[1], media[1]), type='l', lwd=3)

Graf(y2, 40)
Graf(y3, 80)
Graf(y4, 150)
text(0, -10, ylabt[1], pos=4)
text(40, -10, ylabt[2], pos=4)
text(90, -10, ylabt[3], pos=4)
text(160, -10, ylabt[4], pos=4)

ym = mean(y)

points(c(0,200), c(ym, ym), type='l', lwd=3, col='red')

SSA = sum(np*(media - ym)^2)
cat1('SSA', SSA)

SSW = sum((ylista[[1]]-media[1])^2) + sum((ylista[[2]]-media[2])^2) + sum((ylista[[3]]-media[3])^2)
 
cat1('SSW', SSW)

SST = sum((y-ym)^2)

cat1('SST', SST)

ff = rep(ylabt, np)

res = aov(y ~ as.factor(ff))

print(summary(res))

boxplot(y ~ as.factor(ff),) 

print(TukeyHSD(res))



