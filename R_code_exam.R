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


# TRUE COLOR VIEW OF 2016
VIS16 <- im.plotRGB(stack_sent_16, r = 3, g = 2, b = 1) 

# INFRARED VIEW
im.plotRGB(stack_sent_16, 4, 3, 2) 

# CHANGE THE POSITION OF THE NIR
im.plotRGB(stack_sent_16, r=3, g=4, b=2)
im.plotRGB(stack_sent_16, r=3, g=2, b=4)



### Gran Paradiso 2023

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



# TRUE COLOR VIEW OF 2023 
VIS23 <- im.plotRGB(stack_sent_23, r = 3, g = 2, b = 1)




# VIS band: b2, b3, b4
# SWIR band: b8 or b11
# NDSI: green(b3) - SWIR / green(b3) + SWIR 




# Calculate NDSI
NDSI16 <- ((b3_16- SWIR16) / (b3_16 + SWIR16))
NDSI16
plot(NDSI16)


col_new <- colorRampPalette(c("darkorchid4", "chocolate1","cornsilk3", "darkolivegreen"))(100)
plot(NDSI16, col=col_new, main = "Normalized Difference Snow Index (NDSI) 2016" )

NDSI23 <- ((b3_23 - SWIR23) / (b3_23 + SWIR23))
NDSI23
plot(NDSI23)
plot(NDSI23, col=col_new, main= "Normalized Difference Snow Index (NDSI) 2023")




# Compute the difference between the two years
diff <- NDSI16 - NDSI23
plot(diff)

col_new2 <- colorRampPalette(c("darkorchid4", "cornsilk", "darkgreen"))(100)
plot(diff, col=col_new2, main = "NDSI Difference (2016 - 2023) ")

#the green areas indicate a positive difference: this means there was more snow in 2016
#the white areas indicate no significance variations 
#the purple ones indicate negative difference: there was less snow in those areas 


hist(NDSI16, col= c("orchid4"), main= "Snow frequency in 2016", xlab = "NDSI")
hist(NDSI23, col= c("orchid4"), main= "Snow frequency in 2023", xlab = "NDSI")
hist(diff, main = "Differences in Snow coverage", col="darkgreen",  xlab = "NDSI Difference")




### Create a binary mask for snow-covered areas

# Define the 3 thresholds
snow_covered <- 0.4
mixture_covered <- 0
no_snow <- (-1:0)

# Create binary masks based on the thresholds
snow_mask <- NDSI16 > snow_covered
mixture_mask <- NDSI16 > mixture_covered

# Combine the masks to create clusters
clusters16 <- snow_mask + 2 * mixture_mask

# Visualize the clusters for the image of 2016
plot(clusters16, col= col_clusters, main = "Clusters (Snow, Mixture, Vegetation)")



col_clusters <- colorRampPalette(c("white","yellow2", "darkgreen"))(100)

ccc <- im.classify(NDSI16, num_clusters = 3)
plot(ccc)


ccc2 <- im.classify(NDSI23, num_clusters = 3)
plot(ccc2)


# Same work for 2023
snow_mask23 <- NDSI23 > snow_covered
mixture_mask23 <- NDSI23 > mixture_covered

# Combine the masks to create clusters
clusters23 <- snow_mask23 + 2 * mixture_mask23

# Visualize the clusters for the image of 2023
plot(clusters23, col= col_clusters, main = "Clusters (Snow, Mixture, Vegetation)" )


par(mfrow=c(1,2))
plot(clusters16[[1]])
plot(clusters23[[1]])

dev.off()



### Calculate the frequency and the number of pixels
f2016 <- freq(clusters16)

f2016

# let's extract the total number of pixels 
tot2016 <- ncell(clusters16)
tot2016

# let's calculate the percentage by dividing by the total number of pixels 
p2016 <- f2016 * 100 / tot2016
p2016

#snow:65.5% ; mixture: 8.5% ; no-snow: 26%



### Percentage of 2023
f2023 <- freq(clusters23)
f2023

tot2023 <- ncell(clusters23)
tot2023

p2023 <- f2023 * 100 / tot2023
p2023

# snow: 46.5% ; mixture: 31% ; no-snow: 22.5%


# Bulding tables with the percentages 

class <- c("SNOW", "MIXTURE", "VEGETATION")
y2016 <- c(65.5, 8.5, 26)
y2023 <- c(46.5, 31, 22.5)

# with data.frame we create the final table 
tabout <- data.frame(class, y2016, y2023)


p1 <- ggplot(tabout, aes(x=class, y=y2016, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2023, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
plot(p1)
plot(p2)


dev.off()


# Calculate standard deviation 
# Variability in space
sd16_3 <- focal(NDSI16, matrix(1/9, 3, 3), fun=sd)
plot(sd16_3)

sd23_3 <- focal(NDSI23, matrix(1/9, 3, 3), fun=sd)
plot(sd23_3)

sd16_7 <- focal(NDSI16, matrix(1/49, 7, 7), fun=sd)
plot(sd16_7)

sd23_7 <- focal(NDSI23, matrix(1/49, 7, 7), fun=sd)
plot(sd23_7)


