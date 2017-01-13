#Function to download raster image

file.source <- function(url, method) {
  if (method == "auto")
    {
    download.file (url=url, destfile="LC81970242014109-SC20141230042441.tar.gz?dl=1", method="auto", mode="wb")
    } else 
      {
      download.file (url=url, destfile="LC81970242014109-SC20141230042441.tar.gz?dl=1", method="wget", mode="wb")
      }
}

source ('https://www.dropbox.com/s/i1ylsft80ox6a32/LC81970242014109-SC20141230042441.tar.gz?dl=1', "auto")
source ('https://www.dropbox.com/s/akb9oyye3ee92h3/LT51980241990098-SC20150107121947.tar.gz?dl=1', 'auto')


#Create a list of files for unpacking
list <-list.files(path='D:/Lesson5/data/', pattern=glob2rx('*.tar'), full.names=TRUE)

#Unpack files
untar (list[1], exdir = 'data') #assign to variable?
untar (list[2], exdir = 'data')


