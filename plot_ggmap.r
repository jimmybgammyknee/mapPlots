library(ggmap)
library(ggplot2)
library(RColorBrewer)

df <- read.csv('mathieson_cov.csv', header = TRUE)

points <- data.frame("pop" = df$pop, "lat" = df$lat, "lon" = df$lon)

al1 = get_googlemap(center = c(lon = 40, lat = 55), zoom = 3, color="bw", maptype = "terrain")
map = ggmap(al1)

p <- map + geom_point(data=points, aes(x=lon, y=lat, group=pop, color=pop))

p + scale_color_brewer(palette="Dark2")