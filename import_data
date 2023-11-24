# time series analysis 

library(imageRy)
library(terra)

im.list()
#import the data
EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png") 

par(mfrow=c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

#using the first element (band) og images
dif = EN01[[1]] - EN13 [[1]] #we see the difference between the two images


cldif <- colorRampPalette(c("blue", "white", "red"))(100)
plot(dif, col=cldif)
#la pianura padana continua ad essere inquinata anche a marzo, perchè ricca di industrie in Italia
#le zone rosse sono quelle che hanno forte cambiamento positivo (città in cui si è smesso di usare macchine)


#analysis on ice melting in greenland 

g2000 <- im.import("greenland.2000.tif")
plot(g2000, col=cldif)
#in Greenland there are inner areas with perennal ice, in the middle very low temperature in blue and on the sides higher temperatures

g2005 <- im.import ("greenland.2005.tif")
g2010 <- im.import ("greenland.2010.tif")
g2015 <- im.import ("greenland.2015.tif")

plot(g2015, col=cldif) #guarda le differenze, il rosso si sta espandendo verso l'interno ciò significa temp più alte

clg <- colorRampPalette(c("black", "blue", "white", "red"))(100)
plot(g2015,col=clg)

par(mfrow=c(2,1))
plot(g2000, col=clg)
plot(g2015, col=clg)

#stacking the data
stackg <- c(g2000, g2005, g2010, g2015)
plot(stackg, col=clg)

#exercise: make the difference between the first and the final elements of the stack
dif = g2015[[1]] - g2000[[1]]
dev.off()
plot(dif, col=clg)

#another method 
difg <- stackg[[1]] - stackg[[4]]
plot(difg, col=clg)
