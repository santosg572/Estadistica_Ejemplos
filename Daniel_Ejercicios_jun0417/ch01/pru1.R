edad = read.csv("EXA_C01_S04_01.csv")
sample(edad$AGE, 10)
s = sort(edad$AGE)
k = 1+ 3.322*log10(189)
k
e = edad$AGE
w = (max(e)-min(e))/k
w
h = hist(s, breaks=5)
h
typeof(h)
h

xm = h$mids
x = h$breaks
nx = length(x)

xx = c(x[1] - (xm[1]-x[1]), xm, x[nx] + (x[nx]-xm[nx])
yy = c(0, h$counts, 0)

for (i in 1:(nx+1)){
points(c(xx[i], xx[i+1]), c(yy[i], yy[i+1]), type='l')
}
