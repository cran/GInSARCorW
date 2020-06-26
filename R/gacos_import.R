#' Import GACOS product in R
#' @author  Subhadip Datta
#' @param rscFile.path Path of the GACOS .ztd.rsc file
#' @param noDataAsNA If true it convert 0 values to NA
#' @import raster
#' @import rgeos
#' @import rgdal
#' @importFrom utils read.table
#' @examples
#' library(raster)
#' library(GInSARCorW)
#' library(circular)
#' rscFile.path<-system.file("td","20170317.ztd.rsc",package = "GInSARCorW")
#' noDataAsNA<-FALSE
#' GACOS.Import(rscFile.path,noDataAsNA)
#' @export

GACOS.Import<-function(rscFile.path,noDataAsNA=FALSE){
  meta<-read.table(rscFile.path)
  img_open<-file(gsub(".rsc","",rscFile.path),"rb")
  width<-as.numeric(as.character(meta$V2[1]))
  len<-as.numeric(as.character(meta$V2[2]))
  img<-readBin(img_open,double(),n=width*len,size=4,endian = "little")
  output <- matrix(unlist(img), ncol = width, byrow= TRUE)
  img<-raster(output)
  extent(img)<-extent(as.numeric(as.character(meta$V2[7])),
                      as.numeric(as.character(meta$V2[7]))+(width*as.numeric(as.character(meta$V2[9]))),
                      as.numeric(as.character(meta$V2[8]))+(len*as.numeric(as.character(meta$V2[10]))),
                      as.numeric(as.character(meta$V2[8])))
  crs(img)<-crs("+proj=longlat +datum=WGS84 +no_defs")
  if (noDataAsNA==FALSE){
    return(img)
  }
  else{
    img[img==0]<-NA
    return(img)
  }
  close(img_open)
}
