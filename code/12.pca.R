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

