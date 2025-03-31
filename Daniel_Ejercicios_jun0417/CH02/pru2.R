mu = 10
si = 2
x = seq(5, 15, .2)

ex = (x-mu)^2/(2*si^2)

f = exp(-ex) / sqrt(2*pi*si)

plot(x,f, type="l")

