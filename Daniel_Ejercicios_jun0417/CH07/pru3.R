rm(list = ls())

dat1 = read.csv("EXR_C07_S04_03.csv")

m1 = dat1$Meth
m2=dat1$Plac

print(m1)
print(m2)

d = m1-m2

print(d)

md = mean(d)
sdd = sd(d)

print(md)
print(sdd)

t = md /(sdd/sqrt(length(m1)))

print(t)