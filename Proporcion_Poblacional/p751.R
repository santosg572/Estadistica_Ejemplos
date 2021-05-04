nw = 301
p = 24/nw

p0 = .063

# Ho: p <= .063

s = sqrt(p0*(1-p0)/nw)
z = (p - p0) / s

print(z)

p = pnorm(z)
print(p)