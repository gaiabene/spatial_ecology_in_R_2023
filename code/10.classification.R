#Getting an idea of pixels and areas changing in time 
#pixels are called trained area 
#classes called clusters 


library(terra)
library(imageRy)

im.list()

# we use number 29: Solar_Orbiter to classify the solar energy based on gasses 
# https://www.esa.int/ESA_Multimedia/Images/2020/07/Solar_Orbiter_s_first_views_of_the_Sun6

sun <- im.import ("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# we have to explain to the software the clusters 
# here we have 3 clusters 

sunc <- im.classify(sun, num_clusters=3)
plot(sunc)
# in this case the part with the higher energy is the green one 

