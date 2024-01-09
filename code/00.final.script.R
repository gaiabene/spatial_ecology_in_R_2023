# Final script including all the different scripts during the lectures

# ----------------------

# Summary: 
# 01 Beginning 
# 02.1 Population density
# 02.2 Population distribution
# 03 Comunities distribution
# 04 Remote sensing data visualization 
# 05 Spectral index
# 06 Time series analysis
# 07 External data import
# 08 Copernicus
# 09 Classification time
# 10 Variability
# 11 PCA: Principal Component Analysis

# ----------------------



# 01 Beginning

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


# -------------------------
# 02.1

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

# --------------------------

# 02.2

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


# ----------------------

# 03

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

# ----------------------

# 04

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


####### STACK IMAGES
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

# --------------------------

# 05

# VEGETATION INDEX in 1992 and 2006 to see the evolution of the area
install.packages("ggplot2")
install.packages("viridis")
library(ggplot2)
library(viridis)
library(terra)
library(imageRy)
im.list()

m1992<- im.import("matogrosso_l5_1992219_lrg.jpg") #image from satellite LANDSAT (1962)
#it's a processed image, where bands 1=NIR, 2=RED, 3=GREEN
im.plotRGB(m1992, r=1, g=2, b=3) 
#in this way, the NIR bands will be depicted in red: they're typical of an healthy vegetation
#the RED ones will be represented in green: they're typical of unhealthy or absent vegetation
#and the GREEN one will be painted in blue
im.plotRGB(m1992, r=2, g=1, b=3)
im.plotRGB(m1992, r=2, g=3, b=1)

m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006,r=2, g=3, b=1)

# import the 2006 image
m2006 <- im.import("matogrosso_ast_2006209_lrg")
#Again, it's a processed image, where bands 1=NIR, 2=RED, 3=GREEN
im.plotRGB(m2006, r=2, g=3, b=1)
im.plotRGB(m2006, r=2, g=1, b=3) #we see the result of deforestation

#build a multiframe with 1992 and 2006 images

par(mfrow = c(1, 2)) 
im.plotRGB(m1992, r=2, g=3, b=1)
im.plotRGB(m2006, r=2, g=3, b=1)
dev.off()

plot(m1992[[1]])
#In this picture, the range of reflectance goes from 0 to 255 (pink-green colors)
#Reflectance is the ratio between reflected and incident radiant flux 
#One bit of info can be 0 or 1 (BINARY CODE)
#The formula to calculate the amount of information every bit gives is:
#2 raise to the power of n, where n is the number of bits.
#Ex: 4 bits will have 16 bits of information. 
#In this picture we have up to 8 bits, hence, up to 255 bits of reflectance (2 raised to power 8).

# The difference between the two bands give us the DVI.
# DVI = NIR - RED, where bands: 1=NIR, 2=RED, 3=GREEN
dvi1992 = m1992 [[1]] - m1992 [[2]] #dvi of 1992 is the difference between band 1 and 2
plot(dvi1992)

#now changing the palette
cl <- colorRampPalette (c("dark blue", "yellow", "red", "black"))(100)
plot(dvi1992, col=cl)
#everything that's dark red is healthy, yellow and blue is bad from the vegetation point of view as it represents bare soil.

#exercise DVI of 2006
dvi2006 = m2006[[1]] - m2006[[2]]
plot(dvi2006)
cl <- colorRampPalette (c("dark blue", "yellow", "red", "black"))(100)
plot(dvi2006, col=cl) #plotting the DVI of 2006 with the same coloring palette.

# NDVI = NIR - RED/ NIR + RED

ndvi1992 = ( m1992 [[1]] - m1992 [[2]] )/ (m1992[[1]] + m1992[[2]])
#also
ndvi1992 =  dvi1992/ (m1992[[1]] + m1992[[2]])
plot(ndvi1992, col=cl)

#NDVI for 2006

ndvi2006 = ( m2006 [[1]] - m2006 [[2]] )/ (m2006[[1]] + m2006[[2]])
ndvi2006 =  dvi2006/ (m2006[[1]] + m2006[[2]])
plot(ndvi2006, col=cl)

#plot them together 1992 and 2006, both ranging from -1 to 1. forest on right and cultivated on left

par(mfrow = c (1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

#speeding up the calculation of the NDVI, the function is: im.ndvi()

ndvi2006a <- im.ndvi (m2006, 1, 2) 
plot(ndvi2006a, col=cl) 

# --------------------------

# 06

# TIME SERIES are series of data (images) scattered in time 
library(terra)
library(imageRy)
im.list()

#### CHANGES IN NITROGEN CONCENTRATION due to COVID, from January to March 2020
EN01 <- im.import("EN_01.png") #European Nitrogen in January
EN13 <- im.import("EN_13.png") #European Nitrogen in March
EN01
EN13

par(mfrow=c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

#Let's make the difference between the red bands of the first two images
dev.off()
diff=EN01[[1]]-EN13[[1]]
plot(diff)

# Reminder: blue and red or green and red aren't good for daltonic people
# So, let's change the colors

cl <- colorRampPalette(c('red','orange','yellow'))(100)  
plot(diff,col=cl) 
# red is higher in march, yellow is higher in january
# so we have a huge decrease in march (there's more yellow than red)
# we see that in many cities people stopped to use cars

##### CHANGES IN TEMPERATURE of Greenland ice sheet

dev.off()
im.list()
G2000 <- im.import("greenland.2000.tif") #16 bits image
plot(G2000,col=cl) # temperature on the surface of the land
# red=almost perennial ice cap

G2005 <- im.import("greenland.2005.tif")
G2010 <- im.import("greenland.2010.tif")
G2015 <- im.import("greenland.2015.tif")

par(mfrow=c(2,2))
plot(G2000,col=cl)
plot(G2005,col=cl)
plot(G2010,col=cl)
plot(G2015,col=cl)

# to make it more effective
cl1 <- colorRampPalette(c('black', 'blue','white','red'))(100) 
par(mfrow=c(2,2))
plot(G2000,col=cl1)
plot(G2005,col=cl1)
plot(G2010,col=cl1)
plot(G2015,col=cl1)

# it's the same as

dev.off()
stackG4 <- c(G2000,G2005,G2010,G2015)  #around 2005 there was the worst period
plot(stackG4, col=cl1)
# we see that the surface temperature in Greenland have increased and then decreased back, while that in the Nunavut has gradually increased
# also Island's temperature has decreased a little bit

# or only the first and the last
dev.off()
stackG2<-c(G2000,G2015)
plot(stackG2, col=cl1)

# Make the difference between the first and the last element
diffg <- stackG4[[1]]-stackG4[[4]]
# it's the same as
difg <- G2000-G2015
plot(diffg, col=cl1) 
# blue=temperature was lower in the past 
# so there's a lot of increase in temperatures, therefore so decrease in ice sheet
# red= temperature was higher in the past

# Make a RGB plot using different years
dev.off()
im.plotRGB(stackG4, r=1,g=2,b=3)
# red = temperature was lower in the past (external part)
# green = temperature similar to the past
# blue = temperature was higher in the past (central part)


# ------------------------

# 07


library(terra)

setwd("/Users/gaiabenevenga/Desktop/download images")
getwd()

#rast function from terra to upload our data 

naja <- rast("najafiraq_etm_2003140_lrg.jpeg")
plotRGB(naja, r=1, g=2, b=3)

#exercise: download the second image 

najaaug <- rast("najafiraq_oli_2023219_lrg.jpeg")
plotRGB(najaaug, r=1, g=2, b=3)

par(mfrow=c(2,1))
plotRGB(naja, r=1, g=2, b=3)
plotRGB(najaaug, r=1, g=2, b=3)

najadif=naja[[1]] - najaaug[[1]]
dev.off()
cl <- colorRampPalette(c("brown", "grey", "orange"))(100)
plot(najadif, col=cl)


aca <- rast("acapulco_otis_oli_2023264_lrg.jpeg")
plotRGB(aca, r=1, g=2, b=3)

aca2 <- rast("acapulco_otis_oli2_2023304_lrg.jpeg")
plotRGB(aca2, r=1, g=2, b=3)

acadif = aca[[1]] - aca2[[1]]
plot(acadif)
plot(acadif, col=cl)




#per vedere quali file ci sono all'interno della cartella selezionata
list.files()


# ------------------------

# 08

# https://land.copernicus.vgt.vito.be/PDF/portal/Application

install.packages("ncdf4")

library(ncdf4)
library(terra)

setwd("/Users/gaiabenevenga/Desktop/download images")
iceland2023 <- rast("c_gls_LST_202311281500_GLOBE_GEO_V2.1.2.nc")
iceland2023

plot(iceland2023)

plot(iceland2023[[1]])

cl <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(iceland2023, col=cl)

ext <- c(-180, 180, -90, 90)
extension <- crop(s, ext)

ext <- c(22, 26, 55, 57) #ho scelto longitudine e latitudine da visualizzare 
#minloong, maxlong, minlat, maxlat
#use the function crop to take the image and crope it

iceland2023c <- crop(iceland2023, ext)
iceland2023c
plot(iceland2023c)


# --------------------

# 09

#Getting an idea of pixels and areas changing in time 
#pixels are called trained area 
#classes called clusters 


library(terra)
library(imageRy)
library(ggplot2)
library(patchwork) # allows to put several graphs all together

im.list()

# we use number 29: Solar_Orbiter to classify the solar energy based on gasses 
# https://www.esa.int/ESA_Multimedia/Images/2020/07/Solar_Orbiter_s_first_views_of_the_Sun6

sun <- im.import ("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# we have to explain to the software the clusters 
# here we have 3 clusters 

sunc <- im.classify(sun, num_clusters=3)
plot(sunc)
# in this case the part with the higher energy is the green one 

im.list()

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")   
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")


plotRGB(m1992)
#here water should be black but there are several deposits so soil 
#we use 2 clusters: one for forest and one for soil, agriculture  etc..

m1992c <- im.classify(m1992, num_clusters = 2)
plot(m1992c)
#classes: forest=1, human=2

plotRGB(m2006)
m2006c <- im.classify(m2006, num_clusters = 2)
plot(m2006c)
#classes: forest=1, human=2

par(mfrow=c(1,2))
plot(m1992c[[1]])
plot(m2006c[[1]])

f1992 <- freq(m1992c)

f1992

# let's extract the total number of pixels 
tot1992 <- ncell(m1992c)
tot1992

# let's calculate the percentage by dividing by the total number of pixels 
p1992 <- f1992 * 100 / tot1992
p1992

#forest:83%; human: 17%


#percentage of 2006
f2006 <- freq(m2006c)
f2006

tot2006 <- ncell(m2006c)
tot2006

p2006 <- f2006 * 100 / tot2006
p2006

# forest: 45%; human: 55%

# bulding the final table
# first of all we build the colums 

class <- c("forest", "human")
y1992 <- c(83, 17)
y2006 <- c(45, 55)

# with data.frame we create the final table 
tabout <- data.frame(class, y1992, y2006)

p1 <- ggplot(tabout, aes(x=class, y=y1992, color=cover)) + geom_bar(stat="identity", fill="white")
#aestetic: x is the class, y the image and color related to the class then we add the geometry we want to use

p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
plot(p2)

p1+p2  # we can make graphs comparing situations of 1992 and 2006


# ---------------------

# 10

# measuring of RS based variability

library(terra)
library(imageRy)
library(viridis)

im.list()

sent <- im.import("sentinel.png")

# band 1 = NIR
# band 2 = red
# band 3 = green 

im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)

# let's calculate the variability, in this case we have 3 variables available
# the 3 variables are the 3 reflectans of different colours 
# multivariate analysis

nir <- sent[[1]]
plot(nir)

# calculate variability in space using "MOVING WINDOW" -> tecnique for the computation of diversity indecies 
# calculate the standard devation of tot pixels, then the moving window will move in another part
# repeat the calculation of another part, we will pass the moving window from one place to the other ad calculate the standard deviation of all the image

# function focal to calculate standard deviation    
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

viridisc <- colorRampPalette(viridis(7))(255)
plot(sd3, col=viridisc)
# variability in space 
# local standard deviation in all the images, calculated 3 by 3 

# Exercise: calculate variability in a 7x7 pixels moving window
sd7 <- focal(nir, matrix(1/49, 7, 7) fun=sd)
plot(sd7, col=viridisc)

par(mfrow=c(1,2))
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)

# original image plus the 7x7 image
par(mfrow=c(1,2))
im.plotRGB(sent, r=2, g=1, b=3)
plot(sd7, col=viridisc)


# ---------------------

# 11

library(imageRy)
library(terra)
library(viridis)

im.list()

im.import("sentinel.png")

# we are going to see how much the bands of pairs are related 
pairs(sent)

# perform PCA on sent 
sentpc <- im.pca(sent)
pairs(sent)

sentpc <- im.pca2(sent)

# the first component is PC1: it corresponds to sentpc
# we use that to make the calculation

pc1 <- sentpc$PC1

viridisc <- colorRampPalette(viridis(7))(255)
plot(pc1, col=viridisc)

# calculating standard deviation on top of pc1
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd3, col=viridisc)

# translate to a moving window of 3x3 to a moving window of 7x7

pc7sd3 <- focal(pc1, matrix(1/49, 7,7), fun=sd)
plot(pc7sd3, col=viridisc)

par(mfrow=c(2,3))
im.plotRGB(sent, 2, 1, 3)

# sd from variability script: 
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
plot(pc1, col=viridisc)
plot(pc1sd3, col=viridisc)
plot(pc1sd7, col=viridisc)

# to see al the images without mfrow, stack all the standard deviation layers 
# the foggy effect is due to including several pixels so variability is high
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
plot(sdstack, col=viridisc)













