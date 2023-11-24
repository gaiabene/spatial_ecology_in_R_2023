
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
