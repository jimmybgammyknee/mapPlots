library(ggmap)
library(ggplot2)
library(RColorBrewer)
library(rworldmap)
library(rworldxtra)

df <- read.csv('20160215_allSamples_jb_numbers.csv', header = TRUE)

points <- data.frame("number"=df$Number, "age" = df$Age, "lat" = df$Lat, "lon" = df$Lon)

al1 = get_googlemap(center = c(lon = 40, lat = 55), scale = 2, size = c(640, 540), zoom = 3, extent='device', color="color", maptype = "hybrid")
map = ggmap(al1)

sc <- scale_fill_gradientn(colours=c("black","navy","blue","deepskyblue","cyan","lightseagreen","green4","green","greenyellow","yellow","gold","red"),
                           values=c(0,1300,2000,3100,4000,5000,6500,7000,8200,9500,12500,50000),
                           rescaler=function(age,...) age,
                           oob=identity,
                           limits=c(0,max(df$Age)))

ss <- scale_size_area(breaks=c(1,2,5,10), 
                      max_size=10)

map + 
  geom_point(data=points, shape=21, stroke=0.75, aes(x=lon, y=lat, fill=age, size=number)) + 
  sc +
  ss +
  xlab("Longitude") + 
  ylab("Latitude") + 
  ggtitle("Sample Distribution in Eurasia")
