#' Mask image with coherence threshold
#' @author  Subhadip Datta
#' @param img Any image (i.e Phase,Displacement,GACOS imported image)
#' @param coh_band coherence band
#' @param threshold A value from coherence band above which the mask will be process.(within 0-1)
#' @param noData_as_NA If TRUE, it convert noData to NA or 0
#' @import raster
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
#' disp<-Phase.to.disp(unw_phase,0.055463,unit="m",39.16362)
#' coh_band<-raster(system.file("td","coh_IW2_VV_17Mar2017_10Apr2017.img",package = "GInSARCorW"))
#' crs(coh_band)<-CRS("+proj=longlat +datum=WGS84 +no_defs")
#' coh.mask(disp,coh_band,threshold=0.4)
#' @export

coh.mask<-function(img,coh_band,threshold=0.2,noData_as_NA=TRUE){
  maski<-coh_band
  maski<-maski>=threshold
  if(noData_as_NA==TRUE){
    maski[maski==0]<-NA
    im<-img*maski
  } else {
    im<-img*maski
  }
  return(im)
}
