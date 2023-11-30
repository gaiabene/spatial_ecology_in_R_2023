#R as a calculator 
5+4

#assign to an object
zima <- 2+3
zima

duccio <- 1 + 6
duccio

#computations 
duccio * zima
final <- duccio * zima
final



####Array
sophi <- c(10, 20, 30, 50, 70)  #microplastics 

#numbers are called arguments
#functions have parentheses and inside them there are arguments

paula <- c(100, 500, 600, 1000, 2000)  #people

#we can plot them together 
plot(paula, sophi)
plot(paula, sophi, xlab="number of people", ylab="microplastics")

#we can also do like that
people <- paula 
microplastics <- sophi

plot(people, microplastics, pch=19, cex=2, col = "blue")
#pch gives the shape of the symbols
#cex gives the size of the symbols
#col for the colour 

#http://www.sthda.com/english/
