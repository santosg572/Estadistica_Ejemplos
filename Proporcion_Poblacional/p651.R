p = .18

n = 1220

alfa = .05

z = qnorm(1-alfa/2)

ls = p + z*sqrt(p*(1-p)/n)
li = p - z*sqrt(p*(1-p)/n)

cat('intevalo de confianza = [', li, ' , ', ls, ']')


