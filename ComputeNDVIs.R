library(raster)
library(sp)

#Create pattern to get desired bands
list2 <-list.files(path='D:/Lesson5/data/', pattern=glob2rx('*.tif'), full.names=TRUE) 
#period1_bands <- list.files(path='D:/Lesson5/data/', pattern=glob2rx('^[0-9]{1990}.*\\.tif'), full.names=TRUE)
#period2_bands <- list.files(path='D:/Lesson5/data/', pattern=glob2rx('2014'), full.names=TRUE)
list2
#Stack the rasters
wageStack1 <- stack(list2[2:8])
wageStack2 <- stack(list2[13:18])
plot(wageStack2)
names(wageStack1)
names(wageStack2)

#Masking clouds
clouds1 <- stack(list2[1]) #revise after stacking
clouds2 <- stack(list2[10])
clouds1 [clouds1==0] <- NA #2 and 4  or only 0?
clouds2 [clouds2==0] <- NA
plot(clouds1)
plot(clouds2)

#Inputs needed - function to drop clouds, cloud band-less layer
cloud2NA <- function(x, y){
  x[y != 0] <- NA
  return(x)
}
wageCloudFree1 <- overlay(x = wageStack1, y = clouds1, fun = cloud2NA)
wageCloudFree2 <- overlay(x = wageStack2, y = clouds2, fun = cloud2NA)
plotRGB (wageCloudFree1, 5,4,3)
plot(wageCloudFree2,1)

#wageStack1_2 <- dropLayer(wageStack, 8)#drop cloud bands
#wageStack2_2 <- dropLayer(wageStack, 7)#drop cloud bands

#Calculate NDVI, 
ndvCalc1 <- function(x) {
  ndvi <- (x[[4]] - x[[3]]) / (x[[4]] + x[[3]]) #Landsat8
  return(ndvi)
}
ndvCalc2 <- function(x) {
  ndvi <- (x[[5]] - x[[4]]) / (x[[5]] + x[[4]]) #Landsat5
  return(ndvi)
}

ndvi1 <- overlay(x=wageCloudFree1, fun=ndvCalc1)
ndvi2 <- overlay(x=wageCloudFree2, fun=ndvCalc2) 
plot(ndvi1)
plot(ndvi2)

#check all.equal
all.equal(ndvi1, ndvi2)


#Intersect and overlay
NDVIDiff <- intersect(ndvi1, ndvi2)
plot(NDVIDiff)
