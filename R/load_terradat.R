## Load data functions

query_db<-function(conn, tbl_name){
  x<-sqlQuery(conn, paste0('SELECT * FROM ilmocAIMPub.ilmocAimPubDBO.', tbl_name, ';'))%>%
    as_tibble()

  return(x)
}

query_db2<-function(conn, tbl_name, remove_shape=TRUE){
  x<-sqlQuery(
      conn, 
      paste0('SELECT * FROM ilmocAIMTerrestrialPub.ILMOCAIMPUBDBO.', tbl_name, ';'),
      rows_at_time = 1
  )

  if(remove_shape){
    x<-select(x,-GDB_GEOMATTR_DATA, -Shape)
  }

  x<-as_tibble(x)

  return(x)
}

load_terradat<-function(connection, extra=FALSE){
  conn<-odbcConnect(connection)

  tdat<-query_db2(conn, 'TerrADat_evw')%>%
    st_as_sf(coords=c("Longitude_NAD83","Latitude_NAD83"), crs=4617)

  sp_ind<-query_db2(conn, 'TerrADatSpeciesIndicators_evw')

  lmf<-query_db2(conn, 'LMF_evw')%>%
    st_as_sf(coords=c("Longitude_NAD83","Latitude_NAD83"), crs=4617)

  x<-list()

  x$sp_ind<-sp_ind
  x$tdat<-tdat
  x$lmf<-lmf

  if(extra){
    horizons<-query_db2(conn, "TBLSOILPITHORIZONS_evw", remove_shape=FALSE)
    sp_rich_detail<-query_db2(conn, "TBLSPECRICHDETAIL_evw", remove_shape=FALSE)
    st_sp_list<-query_db2(conn, "TBLSTATESPECIES_evw", remove_shape=FALSE)
    pt_weight<-query_db2(conn, "POINTWEIGHT_evw", remove_shape=FALSE)
    
    x$s_horizons<-horizons
    x$sp_rich_detail<-sp_rich_detail
    x$st_sp_list<-st_sp_list
    x$pt_weight<-pt_weight
  }

  odbcClose(conn)

  return(x)
}
