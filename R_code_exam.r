# PROJECT ABOUT DIFFERENCES IN SNOW COVERAGE IN GRAN PARADISO NATIONAL PARK
# DATA FROM 2016 AND 2023


library(terra)
library(imageRy)
library(ncdf4)
library(ggplot2)


setwd("/Users/gaiabenevenga/Desktop/R_code_exam/images")
getwd()


b2_16 <- rast("gp_2016_b2.jpg")
plot(b2_16)

b3_16 <- rast("gp_2016_b3.jpg")
plot(b3_16)

b4_16 <- rast("gp_2016_b4.jpg")
plot(b4_16)

b8_16 <- rast("gp_2016_b8.jpg")
plot(b8_16)

b11_16 <- rast("granparadiso16_b11.jpg")
plot(b11_16)



# Stacking the bands b2, b3, b4 to create a true color image
VIS_image16 <- c(b2_16, b3_16, b4_16)




c1 <- colorRampPalette(c("black", "grey", "white")) (100)
c2 <- colorRampPalette(c("purple", "pink", "white")) (100)
c3 <- colorRampPalette(c("darkgreen", "lightgreen", "white")) (100)
c4 <- colorRampPalette(c("blue", "lightblue", "white")) (100)

par(mfrow=c(2,2))
plot(b2_16,col=c1)
plot(b3_16,col=c2)
plot(b4_16,col=c3)
plot(b8_16, col=c4) 

dev.off()

stack_sent_16 <- c(b2_16,b3_16,b4_16,b8_16)
plot(stack_sent_16)



VIS16 <- im.plotRGB(stack_sent_16, r = 3, g = 2, b = 1) # our view


im.plotRGB(stack_sent_16, 4, 3, 2) #with infrared

# CHANGE THE POSITION OF THE NIR
im.plotRGB(stack_sent_16, r=3, g=4, b=2)
im.plotRGB(stack_sent_16, r=3, g=2, b=4)



### Gran paradiso 2023

b2_23 <- rast("gp_2023_b2.jpg")
plot(b2_23)

b3_23 <- rast("gp_2023_b3.jpg")
plot(b3_23)

b4_23 <- rast("gp_2023_b4.jpg")
plot(b4_23)

b8_23 <- rast("gp_2023_b8.jpg")
plot(b8_23)

b11_23 <- rast("granparadiso23_b11.jpg")
plot(b11_23)


b11_23
b11_16

ext(b11_23) == ext(b11_16)


### change in resolution and dimension of b8 image
b8_23_scaled <- disagg(b8_23, 2)
plot(b8_23_scaled)


### change in resolution and dimension of b11 images
b11_16_scaled <- disagg(b11_16, 2)
plot(b11_16_scaled)

b11_23_scaled <- disagg(b11_23, 2)
plot(b11_23_scaled)


SWIR16 <- b11_16_scaled
SWIR23 <- b11_23_scaled




ext(b2_16) == ext(b8_23_scaled)

c5 <- colorRampPalette(c("magenta4", "maroon2", "white"))(100)
c6 <- colorRampPalette(c("tomato4", "chocolate", "cornsilk"))(100)
c7 <- colorRampPalette(c("darkslategray", "darkseagreen3", "ghostwhite"))(100)
c8 <- colorRampPalette(c("darkblue", "lightsteelblue3", "white"))(100)


par(mfrow=c(2,2))
plot(b2_23,col=c5)
plot(b3_23,col=c6)
plot(b4_23,col=c7)
plot(b8_23_scaled, col=c8) 


dev.off()

stack_sent_23 <- c(b2_23, b3_23, b4_23, b8_23_scaled)
plot(stack_sent_23)


r2 <- rast(b2_23)
r3 <- rast(b3_23)
r4 <- rast(b4_23)
r8 <- rast(b8_23_scaled)
compareGeom(r2, r3, r8)


VIS23 <- im.plotRGB(stack_sent_23, r = 3, g = 2, b = 1)



gp_16_truecolor <- rast("granparadiso16.jpg")
plot(gp_16_truecolor)

gp_23_truecolor <- rast("granparadiso23.jpg")
plot(gp_23_truecolor)

dev.off()

# Create classes 

gp_16_c1 <- im.classify(b8_16,num_clusters = 3)
plot(gp_16_c1)


#calculate the NDSI (NORMALIZED DIFFERENCE SNOW INDEX)

# Load your raster data with bands representing the visible and shortwave infrared
visible_band <- rast("path/to/visible_band.tif")
swir_band <- rast("path/to/swir_band.tif")
# VIS band: b2, b3, b4
# SWIR band: b8 or b12?
# NDSI: VIS - SWIR / VIS + SWIR 


# Calculate NDSI
NDSI16 <- ((b3_16- SWIR16) / (b3_16 + SWIR16))
NDSI16
plot(NDSI16)

col_new <- colorRampPalette(c("darkorchid4", "chocolate1","cornsilk3", "darkolivegreen"))(100)
plot(NDSI16, col=col_new, main = "Normalized Difference Snow Index (NDSI) 2016" )

NDSI23 <- ((b3_23 - SWIR23) / (b3_23 + SWIR23))
NDSI23
plot(NDSI23, col=col_new, main= "Normalized Difference Snow Index (NDSI) 2023")



