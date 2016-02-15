library(ggmap)
library(ggplot2)
library(RColorBrewer)
library(rworldmap)
library(rworldxtra)

# most if not all
df <- read.csv('20160215_allSamples_jb.csv', header = TRUE)

# remove oldest samples to adjust scale
#df <- read.csv('20160215_allSamples_jb_notOld.csv', header = TRUE)

points <- data.frame("age" = df$Age, "lat" = df$Lat, "lon" = df$Lon)

al1 = get_googlemap(center = c(lon = 40, lat = 55), scale = 2, size = c(640, 540), zoom = 3, extent='device', color="color", maptype = "hybrid")
map = ggmap(al1)

map + geom_point(data=points, aes(x=lon, y=lat, colour=age)) + scale_colour_gradientn(colours=c("yellow", "black")) + geom_jitter(width = 0.2, height = 0.2) + xlab("Longitude") + ylab("Latitude") + ggtitle("Sample Distribution in Eurasia")
