m1 = 183
s1 = 37.2

m2 = 189
s2 = 34.7

n1 = 50
n2 = 50

# P(x1-x2 > 8)

z = ((m1-m2)-8)/sqrt(s1^2/n1 + s2^2/n2)
z

print(1-pnorm(z))


