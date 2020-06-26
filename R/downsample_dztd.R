#' Resample Di-ZTD to phase cell resolution and match raster extents.
#' @author  Subhadip Datta
#' @param unw_pha Un-wrapped InSAR tile/raster.
#' @param dztd Di-ZTD.
#' @param method Raster resampleing method "ngb" for nearest neighbor or "bilinear" for bilinear interpolation
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
#' dztd<-d.ztd(GACOS_ZTD_T1,GACOS_ZTD_T2)
#' unw_pha<-raster(system.file("td","Unw_Phase_ifg_17Mar2017_10Apr2017_VV.img",package = "GInSARCorW"))
#' crs(unw_pha)<-CRS("+proj=longlat +datum=WGS84 +no_defs")
#' d.ztd.resample(unw_pha,dztd)
#' @export


d.ztd.resample<-function(unw_pha,dztd,method="bilinear"){
  re_ztd<-resample(dztd,unw_pha,method)
  return(re_ztd)
}
