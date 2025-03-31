datos = read.csv("EXR_C02_S03_01.csv", header = TRUE)
p = datos$pindex
p

h = hist(p, breaks=11, freq=TRUE, xlim=c(-1,4))

#r = cumsum(p)
#r = r/r[length(r)]

#plot(r)

x = h$mids
y = h$counts

n = length(x)

points(x,y,type="l", col="red")

x0 = h$breaks[1]-(x[1]-h$breaks[1])

points(c(x0,x[1]), c(0, y[1]), type="l", col="red")

x0 = h$breaks[length(h$breaks)]+(h$breaks[length(h$breaks)]-x[n])

points(c(x[n],x0), c(y[n], 0), type="l", col="red")

f = p < 2
s = sum(f)/length(p)
s


#bbbbbbbbbbbbbbbbbbbbbbb

x = c(TRUE, TRUE, FALSE)

