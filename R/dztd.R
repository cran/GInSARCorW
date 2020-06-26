#' Calculate ZTD difference between times
#' @author  Subhadip Datta
#' @param GACOS_ZTD_T1 ZTD time 1
#' @param GACOS_ZTD_T2 ZTD time 2
#' @import raster
#' @import rgeos
#' @import rgdal
#' @examples
#' library(raster)
#' library(GInSARCorW)
#' library(circular)
#' noDataAsNA<-FALSE
#' i1m<-system.file("td","20170317.ztd.rsc",package = "GInSARCorW")
#' i2m<-system.file("td","20170410.ztd.rsc",package = "GInSARCorW")
#' GACOS_ZTD_T1<-GACOS.Import(i1m,noDataAsNA)
#' GACOS_ZTD_T2<-GACOS.Import(i2m,noDataAsNA)
#' d.ztd(GACOS_ZTD_T1,GACOS_ZTD_T2)
#' @export

d.ztd<-function(GACOS_ZTD_T1,GACOS_ZTD_T2){
  dztd<-GACOS_ZTD_T1-GACOS_ZTD_T2
  return(dztd)
}
