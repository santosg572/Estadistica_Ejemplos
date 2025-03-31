rm(list=ls())

pat = './ch10_all/'

file = paste(pat, 'EXA_C10_S03_01.csv', sep='')
datos = read.csv(file, header=T)

print(datos)
attach(datos)

np = length(CDA)
s = rep(1, np)

X = cbind(s, AGE, EDLEVEL)

dd = solve(t(X) %*% X)

beta = dd %*% (t(X) %*% CDA)

k = 2

s = sqrt(sum((CDA - (beta[1] + beta[2]* AGE + beta[3]* EDLEVEL))^2)/(np-k-1))

print(s)

errb1 = s * sqrt(dd[2,2])

cati <- function(let='', x = 0){
	cat(let, ' = ', x, '\n')
}

cati('error estandard de AGE', round(errb1,3) )

errb2 = s * sqrt(dd[3,3])

cati('error estandard de EDLEVEL', round(errb2,3) )

tvalueb1 = -.18/errb1

cati('valor t de AGE', round(tvalueb1,3) )

tvalueb2 = .61/errb2

cati('valor t de EDLEVEL', round(tvalueb2,3) )

p_valueb1 = 2*pt(tvalueb1, np-k-1)

cati('p-value AGE', round(p_valueb1,6) )

res = lm(CDA ~ AGE + EDLEVEL)

print(summary(res))
