rm(list=ls())

datos = read.csv("EXA_C08_S04_01.csv" , header=T)

print(names(datos))

attach(datos)

par(mfrow=c(2,2))
boxplot(FUNC ~ as.factor(TIME))
boxplot(FUNC ~ as.factor(SUBJ))

res = aov(FUNC ~ as.factor(TIME) + as.factor(SUBJ))

print(summary(res))