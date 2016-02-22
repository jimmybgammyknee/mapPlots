  library(ggmap)
  library(ggplot2)
  library(RColorBrewer)
  library(rworldmap)
  library(rworldxtra)
  library(grid)
  library(gridExtra)
  library(scales)
  
  df1 <- read.csv('20160217_SAm_samples_noPeru_numbers.csv', header = TRUE)
  df2 <- read.csv('20160217_SAm_samples_numbers.csv', header = TRUE)
  
  points1 <- data.frame("number"=df1$Number, "age"=df1$Age, "lat"=df1$Lat, "lon"=df1$Lon)
  
#  al1 <- get_googlemap(center=c(lon=-92, lat=-15), scale=2, size=c(640, 640), zoom=3, extent='device', color="color", maptype="hybrid")
  al1 <- get_googlemap(center=c(lon=-130, lat=20), scale=2, size=c(640, 640), zoom=2, extent='device', color="color", maptype="hybrid")
  map1 <- ggmap(al1)
  
  sc1 <- scale_fill_gradientn(colours=c("black","blue","cyan","green4","green","yellow","red"),
                                values=c(0,500,1200,1600,2000,4000,12700),
                                rescaler=function(age,...) age,
                                oob=identity,
                                limits=c(0,max(df2$Age)))
  
  ss1 <- scale_size_area(breaks=c(1,2,5,10),
                    max_size=10)
  
  a <- map1 + 
    geom_point(data=points1, shape=21, stroke=0.75, aes(x=lon, y=lat, fill=age, size=number)) + 
    sc1 +
    ss1 +
    xlab("Longitude") + 
    ylab("Latitude") + 
    ggtitle("Sample Distribution in the Americas") +
#    theme(plot.title = element_text(hjust = 0.8)) +
    annotate("rect", xmin=-80,xmax=-72,ymin=-16,ymax=-6, colour="white", size=1.5, fill=NA)
  
  points2 <- data.frame("number"=df2$Number, "age"=df2$Age, "lat"=df2$Lat, "lon"=df2$Lon)
  
  al2 <- get_googlemap(center=c(lon=-75.7, lat=-11), scale=2, size=c(440, 500), zoom=6, extent='device', color="color", maptype="satellite")
  map2 <- ggmap(al2)
  
  sc2 <- scale_fill_gradientn(colours=c("black","blue","cyan","green4","green","yellow","red"),
                                values=c(0,500,1200,1600,2000,4000,12700),
                                rescaler=function(age,...) age,
                                oob=identity,
                                limits=c(0,max(df2$Age)),
                                guide="none")
  
  ss2 <- scale_size_area(breaks=c(1,2,5,10),
                         max_size=10,
                         guide="none")
  
  b <- map2 + 
    geom_point(data=points2, shape=21, stroke=0.75, aes(x=lon, y=lat, fill=age, size=number)) + 
    sc2 + 
    ss2 +
    xlab("Longitude") + 
    ylab("Latitude")
  
#  al3 <- get_googlemap(center=c(lon=-140, lat=60), scale=2, size=c(440, 440), zoom=3, extent='device', color="color", maptype="hybrid")
#  map3 <- ggmap(al3)
  
#  sc3 <- scale_fill_gradientn(colours=c("black","blue","cyan","green4","green","yellow","red"),
#                              values=c(0,500,1200,1600,2000,4000,12700),
#                              rescaler=function(age,...) age,
#                              oob=identity,
#                              limits=c(0,max(df2$Age)),
#                              guide="none")
  
#  ss3 <- scale_size_area(breaks=c(1,2,5,10),
#                         max_size=10,
#                         guide="none")
  
#  c <- map3 + 
#    geom_point(data=points1, shape=21, stroke=0.75, aes(x=lon, y=lat, fill=age, size=number)) + 
#    sc3 + 
#    ss3 +
#    xlab("Longitude") + 
#    ylab("Latitude")

  grid.newpage()
  vp1 <- viewport(width = 1, height = 1, x = 0.5, y = 0.5)
  vp2 <- viewport(width = 0.35, height = 0.5, x = 0.1, y = 0.1, just = c("left","bottom"))
#  vp3 <- viewport(width = 0.25, height = 0.5, x = 0.08, y = 0.56, just = c("left","bottom"))
  pdf(file="Rplot_SouthAmerica_numbers.pdf")
  print(a, vp = vp1)
  print(b, vp = vp2)
#  print(c, vp = vp3)
  dev.off() 