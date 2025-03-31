data = read.csv("EXR_C07_S03_03.csv")

g1 = data$Length[data$Group == 1]
g2 = data$Length[data$Group == 2]

alfa = .01

ng1 = length(g1)
ng2 = length(g2)
print(ng1)
print(ng2)

s1 =  var(g1)
print(s1)

s2 = var(g2)
print(s2)

w1 = s1*s1/ng1
w2 = s2*s2/ng2

t1 = qt(alfa/2, ng1-1)
t2 = qt(alfa/2, ng2-1)

tp = (w1*t1 + w2*t2)/(w1+w2) # limite

te = (mean(g1)-mean(g2))/sqrt(s1*s1/ng1 + s2*s2/ng2)

print(tp)
print(te)

#conclusion: NO se rechaza la hipotesis nula







