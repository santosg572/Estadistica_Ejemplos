edad = read.csv("EXA_C01_S04_01.csv")

e = edad$AGE

mean(e)
sd(e)

M = c()

for (i in 1:100){
	x = sample(e, 10, replace = TRUE)
	M = c(M, mean(x))
}

mean(M)
sd(M)

var(e)/sqrt(n)


