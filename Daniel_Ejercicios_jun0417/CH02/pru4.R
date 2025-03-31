x1 = 10*runif(10)
x2 = 10*runif(10)
x3 = 10*runif(10)

m = matrix(c(x1,x2,x3), ncol=3)

print(m)

sapply(m,mean)

