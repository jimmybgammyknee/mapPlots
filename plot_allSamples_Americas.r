library(ggmap)
library(ggplot2)
library(RColorBrewer)
library(rworldmap)
library(rworldxtra)
library(grid)
library(gridExtra)
library(scales)

# most if not all
df1 <- read.csv('20160217_SAm_samples_noPeru.csv', header = TRUE)
df2 <- read.csv('20160217_SAm_samples.csv', header = TRUE)

myPalette <- colorRampPalette(rev(brewer.pal(11, "Spectral")))

points1 <- data.frame("age"=df1$Age, "lat"=df1$Lat, "lon"=df1$Lon)
al1 <- get_googlemap(center=c(lon=-87, lat=0), scale=2, size=c(640, 640), zoom=3, extent='device', color="color", maptype="hybrid")
map1 <- ggmap(al1)
sc1 <- scale_colour_gradientn(colours = myPalette(100), limits=c(0,max(df2$Age)))
a <- map1 + 
  geom_point(data=points1, size = 4, aes(x=lon, y=lat, colour=age)) + 
  geom_point(data=points1, size = 4, shape=21, stroke=0.5, colour="black") + 
  sc1 +
  xlab("Longitude") + 
  ylab("Latitude") + 
  ggtitle("Sample Distribution in the Americas") +
  annotate("rect", xmin=-80,xmax=-71.5,ymin=-17.5,ymax=-4.5, colour="white", size=2, fill=NA)

points2 <- data.frame("age"=df2$Age, "lat"=df2$Lat, "lon"=df2$Lon)
al2 <- get_googlemap(center=c(lon=-75.5, lat=-11), scale=2, size=c(440, 640), zoom=6, extent='device', color="color", maptype="hybrid")
map2 <- ggmap(al2)
sc2 <- scale_colour_gradientn(colours = myPalette(100), limits=c(0,max(df2$Age)), guide="none")
b <- map2 + 
  geom_point(data=points2, size = 4, aes(x=lon, y=lat, colour=age)) + 
  geom_point(data=points2, size = 4, shape=21, stroke=0.5, colour="black") + 
  sc2 + 
  xlab("Longitude") + 
  ylab("Latitude")

grid.newpage()
vp1 <- viewport(width = 1, height = 1, x = 0.5, y = 0.5)
vp2 <- viewport(width = 0.35, height = 0.7, x = 0.08, y = 0, just = c("left","bottom"))
print(a, vp = vp1)
print(b, vp = vp2)
