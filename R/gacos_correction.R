#' GACOS Atmospheric Phase delay correction
#' @author  Subhadip Datta
#' @param unw_pha Un-wrapped InSAR tile/raster.
#' @param re_dztd Resampled Di-ZTD.
#' @param wavelength SAR wavelength in meter.
#' @param inc_ang SAR incident angle (to get output in LOS direction, don't use if not needed).
#' @param ref_lat A reference point for correction, If NA, It use the tile center latitude.
#' @param ref_lon A reference point for correction, If NA, It use the tile center longitude.
#' @import sp
#' @import raster
#' @import rgeos
#' @import rgdal
#' @import circular
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
#' re_dztd<-d.ztd.resample(unw_pha,dztd)
#' GACOS.PhCor(unw_pha,re_dztd,0.055463,inc_ang=39.16362,ref_lat=NA,ref_lon=NA)
#' @export

GACOS.PhCor<-function(unw_pha,re_dztd,wavelength="in meter",inc_ang=90,ref_lat=NA,ref_lon=NA){
  phase<-(unw_pha*wavelength)/(4*pi)
  if(is.na(ref_lat) && is.na(ref_lon)){
    ref_lat<-(ymax(unw_pha)+ymin(unw_pha))/2
    ref_lon<-(xmax(unw_pha)+xmin(unw_pha))/2
    xy<-cbind(ref_lon,ref_lat)
  } else {
    xy<-cbind(ref_lon,ref_lat)
  }
  re_dztd<-re_dztd-extract(re_dztd,SpatialPoints(xy,proj4string=crs(unw_pha)))
  phase<-phase-extract(phase,SpatialPoints(xy,proj4string=crs(unw_pha)))
  phase<-phase/(wavelength/(4*pi))
  re_dztd<-re_dztd/(wavelength/(4*pi))
  re_dztd<-re_dztd/sin(rad(inc_ang))
  corec<-phase-re_dztd
  return(corec)
}
