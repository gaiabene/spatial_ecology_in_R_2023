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
#let's give a name to the function decoarana(dune)

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





##### MULTIVARIATE ANALISYS of how species are related in TIME 
install.packages("overlap")
library(overlap)

data(kerinci) #data from Kerinci-Seblat National Park in Sumatra, Indonesia
kerinci
head(kerinci)
summary(kerinci)

#Selecting the first species
tiger <- kerinci[kerinci$Sps=="tiger",] #Sps=species

#Selecting the tigers time
timetig <- kerinci$Time*2*pi 
#we multiply the the linear time to 2 pi greek to have a time in radiants

densityPlot(timetig, rug=TRUE)

#Selecting the macaque
macaque <- kerinci[kerinci$Sps=="macaque",] #Sps=species

#Selecting the macaque time
timemac <- macaque$Time*2*pi 

densityPlot(timemac, rug=TRUE)

overlapPlot(timetig,timemac)


