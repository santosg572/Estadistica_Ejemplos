rm(list=ls())

library(ggplot2)

#p = ggplot(mpg, aes(x=1:length(displ))) + geom_point(aes(y= displ, color= manufacturer))

#p = ggplot(mpg) + geom_boxplot(aes(x=manufacturer, y=displ))

#p = ggplot(mpg) + geom_histogram(aes(displ, ymin=-5, ymax=5))

p = ggplot(mpg) + geom_errorbar(aes(displ))

print(p)