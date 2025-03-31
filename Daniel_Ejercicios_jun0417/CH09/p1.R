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

file = paste(pat, 'EXA_C09_S03_01.csv', sep='')
datos = read.csv(file, header=T)

print(datos)

attach(datos)

plot(X,Y, pch=16)

res = ajuste(X,Y)
print(res)

resl = lm(Y~ X)

print(summary(resl))

abline(resl, lwd=3, col='red')

residuos = Y - (res[1] + res[2]*X)

cat(' \n', 'Algunos resultados',  '\n')
print(summary(residuos))

cat('\n', ' coeficiente de determinacion= r2 = ', res[3], '\n')

cat1 <- function(tit='', val=0){
	cat(tit, ' = ', val, '\n')
}

ssr = res[4]
sst = res[5]

cat1('SSR', ssr)
cat1('SSE', sst-ssr)
cat1('SST', sst)

n = length(X)
msr = ssr/1
mse = (sst-ssr)/(n-2)
cat1('MSR', msr)
cat1('MSE', mse)
cat1('V.R.', msr/mse)

cdp = res[6]
cat1('coeficiente de determinacion poblacional', cdp)

es2 = mse

cat1('error estandar ', es2 )

xm = mean(X)
esb1 = sqrt(es2 /sum((X-xm)^2))
cat1('error estandar de b1 ', esb1 )
