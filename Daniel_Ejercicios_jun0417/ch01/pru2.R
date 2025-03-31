edad = read.csv("EXA_C01_S04_01.csv")
e = edad$AGE

mean(e)
var(e)

m = c()

for (i in 1:10){
   y = mean(sample(e,10))
   m = c(m, y)
}

mean(m)
var(m)


