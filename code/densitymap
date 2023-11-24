install.packages("sdm")
installed.packages("terra")
install.packages("rgdal")

# Code related to population ecology

# A package is needed for point pattern analysis
install.packages("spatstat")
> library(spatstat) #just to check if the package is correctly installed

#Lets use the bei data
bei

#Now we plot the data
plot(bei)

#Resize the plot
plot(bei, pch=19, cex=.5)

#Additional database
bei.extra
plot(bei.extra)

#Plot only one part of the dataset: elev
plot(bei.extra$elev)

elev <- bei.extra$elev

#If you don't know the name of the variable, better use numbers (the number of the element)
plot(bei.extra[[1]])

library(spatstat)
?bei

densitymap <- density(bei)
densitymap
plot(densitymap) #this is the density of the trees of the tropical area 
#small density in blue, high density in yellow 
plot(bei)
plot(densitymap)
points(bei, cex=0.5)ù
points(bei, cex=.2)

cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
plot(densitymap, col=cl)

lr <- colorRampPalette(c("blue4", "lightsteelblue", "firebrick2", "red4"))(100)
plot(densitymap, col=lr)
cl
plot(bei.extra) #two variables inside: elevation and gradient 
elev <- bei.extra[[1]]
plot(elev)
bei.extra$elev

#multiframe, used to plot several things all together, specifing the columns and the rows
par(mfrow=c(1,2))

plot(densitymap)
plot(elev)

par(mfrow=c(2,1)) #to invert, in this case I have 1 column and 2 rows
plot(densitymap)
plot(elev)

par(mfrow=c(1,3))
plot(bei)
plot(densitymap, col=lr)
plot(elev, col=lr)
