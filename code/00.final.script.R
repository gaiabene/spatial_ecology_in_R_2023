# Final script including all the different scripts during the lectures

# ----------------------

# Summary: 
# 01 Beginning 
# 02.1 Population density
# 02.2 Population distribution
# 03 Comunities distribution
# 04 Remote sensing visualization 

# ----------------------



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




#Codes related to POPULATION GROWTH

#Let's install spatstat, which allows us to make a SPATIAL POINT PATTERN ANALISYS

install.packages("spatstat") # QUOTES are needed to protect the package we want to install which is outside R

#the function library(spatstat) is used to check if the package has already been installed
library(spatstat)

#we are using data in Markdown, which is outside R, in order to previously understand how they work

#DATA DESCRIPTION
#Let's use some datasets provided by spatstat, like BEI DATA 
#(The dataset bei gives the positions of 3605 trees of the species Beilschmiedia pendula (Lauraceae) in a 1000 by 500 metre rectangular sampling region in the tropical rainforest of Barro Colorado Island. )

#PLOTTING  DATA FROM SPATSTAT (see what it represents)
plot(bei) 
# as the points are too big for this area, we'll change their shame

#CHANGING DATA DIMENSION - cex
plot(bei,cex=.5)

#why are the trees clumbed in some area?

#CHANGING THE SYMBOL  - pch
plot(bei,cex=.2,pch=19) #search the number of R symbols on the internet

#ADDITIONAL DATASETS
bei.extra # it has two variables: elevation (elev) and gradient (grad). They allow to understand the distribution of bei datas

plot(bei.extra) #here we have the raster file =! vector file

#Let's use only part of the dataset: elev
bei.extra$elev  #$ sign links elevation to the dataset
plot(bei.extra$elev) 
elevation <- plot(bei.extra$elev)  #elevation has been assignet to an homonimous object, simple to find

#second method to select elements
bei.extra[1] #take the fist element, so it's another way to isolate elevation
elevation2 <- bei.extra[[1]]
plot(elevation2)

# INTERPOLATION: passing from points to a continuous surface 
densitymap<-density(bei) #the densitymap gives us info about the distribution of pixel
plot(densitymap)

#Let's overlap  bei points to the densitymap
points(bei, cex=.2)

#Avoid pictures with a combination of blue, green and red colors as daltonic people can't see them

#Let's change the colors
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100) #R is capital letters sensitive!!!
#100 represents the different colors that can be present between the colors chosen
plot(densitymap, col=cl)

#Use yellow colour in a proper way, cause it's the most impacting one

#the quality is much worse if we put a smaller number, like
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(4)

plot(densitymap, col=cl)

# MULTIFRAME (shows different plots at the same time)
par(mfrow=c(1,2)) #1 row and 2 columns, and they're part of an array
# and then the two plots 
plot(densitymap)
plot(elev)

par(mfrow=c(2,1)) #2 rows and 1 column, and they're part of an array
# and then the two plots 
plot(densitymap)
plot(elev)





# How populations disperse over the landscape in a certain manner?

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






#In communities, species are overlapping in space and time
# MULTIVARIATE ANALISYS of how species are related in SPACE 

#Vegetation Analisys
install.packages("vegan")
library(vegan)
data(dune) 
# Dune is a data frame of observations of 30 species at 20 sites. 
# The species names are abbreviated to 4+4 letters.

install.packages("lattice")
library(lattice)

install.packages("permute")
library(permute)

data(dune)
dune #to see the dataset
#or
head(dune) #just the first 6 rows
tail(dune) #just the last 6 rows
#we see a matrix of amout of individuals present in every plot

decorana(dune)
#let's give a name to the function decorana(dune)

ord<-decorana(dune) #decorana function from the package vegan gives the Detrended Correspoondace Analysis
# DCA is a multivariate statistical technique used by ecologists to find the main factor or gradient in species-rich but sparse data matrices that tipify ecological community data. 
# we have to know the length of the new axes

summary(ord)
ord #it gives back information about the lengths of axis 
# if we make a sum of the all axis we can see a percentage (percentuale di quanto ricoprono gli assi)
ldc1 = 3.7004
ldc2 = 3.1166
ldc3 = 1.30055
ldc4 = 1.47888

total = ldc1 + ldc2 + ldc3 + ldc4

pldc1 = ldc1 * 100/ total
pldc2 = ldc2 * 100/ total
pldc3 = ldc3 * 100/ total
pldc4 = ldc4 * 100/ total

pldc1
pldc2
pldc3
pldc4

# how much cumulative percentage represent the first two axes?
pldc1 + pldc2  
# as pldc1 + pldc2 represent the 70% of the total, we can also keep them only

plot(ord) #I see the ultimate variate multianalysis space 




# SATELLITE DATA VISUALIZING
# Where to store additional packages, not present in R? 
# GitHub (not connected to R: it's not controlled) or CRAN (directly conencted to R: it's controlled)

# to install them from CRAN (Coomprehensive R Archive Network), the function is: install.packages()
install.packages("devtools")

# to open the packages (also called libraries in R), the function is always: library()
library (devtools) 

# to install them from GitHub, the function is: install_github()
install_github("ducciorocchini/imageRy")  
library (imageRy)

# to see all the possible images from the imageRy package, the function is: im.list()

# to import one image, the function is: im.import()
b2 <- im.import("sentinel.dolomites.b2.tif")

#Information provided from the image (called Reference System): 
# Word Geodetic System, Universal Transverse Mercator, Coordination of the point + the emisphere (N or S)
# to know more, you can go to Sentinel-2 in Wikipedia

clb <- colorRampPalette(c("dark grey", "grey", "light grey")) (100)
plot(b2,col=clb)

c1 <- colorRampPalette(c("black", "grey", "white")) (100)
c2 <- colorRampPalette(c("purple", "pink", "white")) (100)
c3 <- colorRampPalette(c("dark green", "light green", "white")) (100)
c4 <- colorRampPalette(c("blue", "light blue", "white")) (100)

par(mfrow=c(2,2))
plot(b2,col=c1)
plot(b3,col=c2)
plot(b4,col=c3)
plot(b8, col=c4) 


###### # STACK IMAGES
# they're a function that plots all the selected images together, one over the other (in this case, four bands all together)
# RGB SPACE = Red, Green and Blue components that build other colours by overlapping
# 1.BLUE
b2 <- im.import("sentinel.dolomites.b2.tif") 

# 2.GREEN
b3<-im.import("sentinel.dolomites.b3.tif") 

# 3.RED
b4 <- im.import("sentinel.dolomites.b4.tif") 

# 4.NIR
b8<-im.import("sentinel.dolomites.b8.tif") 

stack_sent <- c(b2,b3,b4,b8)

im.plotRGB(stack_sent, r = 3, g = 2, b = 1) # our view

im.plotRGB(stack_sent, 4, 3, 2) #with infrared: vegetation becomes red, we get more information

# CHANGE THE POSITION OF THE NIR
im.plotRGB(stack_sent, r=3, g=4, b=2)
im.plotRGB(stack_sent, r=3, g=2, b=4)


# CORRELATIONS BETWEEN THE BANDS
pairs(stack_sent)








