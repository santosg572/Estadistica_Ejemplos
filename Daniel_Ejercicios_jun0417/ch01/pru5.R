m = matrix(10*runif(30), ncol=3)
med = apply(m,2, mean)
des = apply(m,2,sd)

print(med);print(des) 

h = barplot(med, names= c("tra1", "tra2", "tra3"), col=c("red", "green", "blue"), ylim=c(0,10))
text(0,0, "datos de TANIA")

print(h)

for (i in 1:3){
points(c(h[i],h[i]), c(med[i]-des[i], med[i]+des[i]), type="l")
}