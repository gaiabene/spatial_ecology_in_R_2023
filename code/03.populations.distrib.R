# why populations disperse over the landscape in a certain manner?

install.packages("sdm")
install.packages("terra")

library (sdm)
library (terra) 

#select the file inside the package
file <- system.file("external/species.shp", package="sdm")

#let's import a vector of this file
rana <- vect(file) 
rana$Occurrence

plot(rana) #to see the datas

#selecting presences 
rana 

rana[rana$Occurrence == 1]
pres <- rana[rana$Occurrence ==1]
plot(pres)
pres #we selected only 1
 
#select absence and call them abse 
abse <- rana[rana$Occurrence == 0,]
abse
plot(abse)
 
?vect(file)
 
par(mfrow=c(1,2))
plot(pres)
plot(abse)

dev.off()  #it closes all the graphics

#excercise: plot pres and abse together with two different colours
cl <- colorRampPalette(c("lightblue4"))
ci <- colorRampPalette(c("red4"))

plot(pres, col=cl)
plot(abse, col=ci)
points(abse, col=ci)

#predictors: enviromental variables
#we are going to deal with imagines
elev <- system.file("external/elevation.asc", package="sdm")
elevmap <- rast(elev)  #from terra
elevmap
plot(elevmap) #it shows the elevation in pixels
points(pres, cex=0.5)  #so rana tempraria prefers low elevation, it is living majoring in sites where there's madium temperature 

#temperature predictor
temp <- system.file("external/temperature.asc", package = "sdm")
tempmap <- rast(temp)
plot(tempmap)
points(pres, cex=0.5)

# exercise: do the same with vegetation
vege <- system.file("external/vegetation.asc", package = "sdm")
vegemap <- rast(vege)
plot(vegemap)
points(pres, cex=0.5) #rana temporaria prefers places with high vegetation cover

prec <- system.file("external/precipitation.asc", package = "sdm")
precmap <- rast(prec)
plot(precmap)
points(pres, cex=.5)

#final multiframe
par(mfrow=c(2,2))
plot(elevmap)
plot(tempmap)
plot(precmap)
plot(vegemap)
