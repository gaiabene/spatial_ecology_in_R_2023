#Getting an idea of pixels and areas changing in time 
#pixels are called trained area 
#classes called clusters 


library(terra)
library(imageRy)
library(ggplot2)
library(patchwork) 
# the package patchwork allows to put several graphs all together 

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






