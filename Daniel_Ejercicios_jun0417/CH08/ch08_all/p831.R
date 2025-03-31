A <- c(7,8,9,10,11)
B <- c(9,9,9,9,12)
C <- c(10,10,12,12,14)

y = c(A, B, C)
me = rep(c('A', 'B', 'C'), c(5,5,5))
grupo = rep(1:5, 3)

res = aov(y ~ as.factor(me) + as.factor(grupo))

print(summary(res))

par(mfrow=c(2,2))

boxplot(y ~ as.factor(me) )

boxplot(y ~ as.factor(grupo) )

