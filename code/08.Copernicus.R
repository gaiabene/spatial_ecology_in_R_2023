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
