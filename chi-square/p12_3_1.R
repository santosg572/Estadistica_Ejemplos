f = c(1,3,8,18,6,4,4,3)
x = seq(25/2,200,25) + 100
alfa = .05

s1 = sum(f)

me = sum(x*f)/s1

print(me)

s2 = sum((x-me)^2*f) /(s1-1)
s = sqrt(s2)

print(s)

z = qnorm(1-alfa/2)

o = round(s1*pnorm(c(x-12.5,300), mean= me, sd = s ), 1)

print(o)

oo = o[2:9] - o[1:8]

print(oo)

X2 = sum((oo-f)^2/f)

q = qchisq(1-alfa, 8-3)

cat('gi = ', q, '\n')


cat('X2 = ', X2, '\n')

p = pchisq(X2, 8-3)

cat('p = ', p, '\n')
