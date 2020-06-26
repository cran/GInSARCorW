#' InSAR Unw-Phase to displacement
#' @author  Subhadip Datta
#' @param unw_phase Un-wrapped InSAR tile/raster.After/before correction.
#' @param wavelength SAR wavelength in meter.
#' @param unit output unit meter , centimeter or milimeter ("m", "cm" or "mm").
#' @param inc_ang SAR incident angle (to get output in LOS direction, don't use if not needed).
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
#' unw_phase<-GACOS.PhCor(unw_pha,re_dztd,0.055463,inc_ang=39.16362,ref_lat=NA,ref_lon=NA)
#' Phase.to.disp(unw_phase,0.055463,unit="m",39.16362)
#' @export

Phase.to.disp<-function(unw_phase,wavelength="in meter",unit="m",inc_ang=0){
  if (wavelength=="in meter"){
    warning("Please add wavelength in meter")
  } else {
    if (unit=="m"){
      ptod<-(unw_phase*wavelength)/(-4*pi*cos(rad(inc_ang)))
      return(ptod)
    }
    if (unit=="cm"){
      wavelength<-wavelength*100.00
      ptod<-(unw_phase*wavelength)/(-4*pi*cos(rad(inc_ang)))
      return(ptod)
    }
    if (unit=="mm"){
      wavelength<-wavelength*1000.00
      ptod<-(unw_phase*wavelength)/(-4*pi*cos(rad(inc_ang)))
      return(ptod)
    }
  }
}
