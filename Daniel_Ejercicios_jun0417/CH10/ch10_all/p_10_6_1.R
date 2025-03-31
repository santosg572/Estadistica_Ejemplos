tabla <- read.csv('EXA_C10_S06_01.csv', header=T)

print(tabla)

attach(tabla)

y = W
x1 = P
x2 = S
l1 = lm(y ~ x1 + x2)

print(summary(l1))

print(names(l1))

betas = as.vector(l1$coefficients)
print(betas)

ym = mean(CDA)
SSR = sum((betas[1]+betas[2]*AGE+betas[3]*EDLEVEL-ym)^2)
print(SSR)

SSE = sum((CDA - betas[1]-betas[2]*AGE-betas[3]*EDLEVEL)^2)
print(SSE)

SST = sum((CDA - ym)^2)
print(SST)

MS_R = SSR/2
cat('MS_R: ', MS_R, '\n')
MS_E = SSE/(np-2)
cat('MS_E: ', MS_E, '\n')

F_est= MS_R / MS_E
cat('F_est: ', F_est, '\n')
#================================
print(cor(tabla))

print(cor.test(y ~ x1 + x2))





