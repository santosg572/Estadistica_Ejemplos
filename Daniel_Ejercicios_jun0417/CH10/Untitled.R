rm(list=ls())

pat = './ch10_all/'

file = paste(pat, 'EXA_C10_S03_01.csv', sep='')
datos = read.csv(file, header=T)

print(datos)
