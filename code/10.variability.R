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







