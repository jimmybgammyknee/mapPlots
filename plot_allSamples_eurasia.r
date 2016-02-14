library(ggmap)
library(ggplot2)
library(RColorBrewer)

# most if not all
df <- read.csv('all_mostSamples.csv', header = TRUE)

# remove oldest samples to adjust scale
#df <- read.csv('all_mostSamples_notOld.csv', header = TRUE)

points <- data.frame("age" = df$Age, "lat" = df$Lat, "lon" = df$Lon)

al1 = get_googlemap(center = c(lon = 40, lat = 55), zoom = 3, color="bw", maptype = "terrain")
map = ggmap(al1)

map + geom_point(data=points, aes(x=lon, y=lat, colour=age)) + scale_colour_gradientn(colours=c("darkred", "green")) + geom_jitter(width = 0.2, height = 0.2) + xlab("Longitude") + ylab("Latitude") + ggtitle("Ancient Sample Distribution in Eurasia")
