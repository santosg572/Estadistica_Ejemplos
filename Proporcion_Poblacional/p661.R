# EXAMPLE 6.6.1 

nf = 68
nm = 255

pf = 31/nf
pm = 53/nm

c1 = pf * (1-pf) / nf

c2 = pm * (1-pm) / nm

s = sqrt(c1 + c2)
print(s)

alfa = .01

z = qnorm(1-alfa/2)

li = pf - pm - z * sqrt(c1 + c2)
ls = pf - pm + z * sqrt(c1 + c2)


cat ('intervalo [', li, ' , ', ls, ']')