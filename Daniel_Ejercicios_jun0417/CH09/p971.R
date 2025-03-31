rm(list=ls())

pat = './ch09_all/'

ajuste <- function(x=0, y=0){
	xm = mean(x)
	ym = mean(y)
	num = sum((x-xm)*(y-ym))
	den = sum((x-xm)^2)
	b1 = num/den
	b0 = ym - b1*xm
	r2 = sum((b0 + b1*x - ym)^2)/sum((y - ym)^2)
	SSR = sum((b0 + b1*x - ym)^2)
	SST = sum((y - ym)^2)
	n = length(x)
	cdp = 1 - (sum((y - (b0 + b1*x))^2)/(n-2)) / (sum((y - ym)^2)/(n-1))
	res = round(c(b0, b1, r2, SSR, SST, cdp),3)
}

file = paste(pat, 'EXA_C09_S07_01.csv', sep='')
datos = read.csv(file, header=T)

print(datos)

attach(datos)

X = HEIGHT
Y = CV

plot(X,Y, pch=16)

res = cor.test(X, Y)
print(res)