# AimSqlTools

Is an R package to access the Terrestrial SDE MySQL database with a single function. 

## Installation

```r
devtools::install_github(mschmidty/AimSqlTools);
```

## Prerequisites 

In order to use this package you must be on a BLM computer and have created an ODBC connection using your user credentials to access the database.  

To create an ODBC connection, on a Windows computer connected to a BLM network or VPN network search "ODBC Data Sources (32-bit)" in the windows search bar. 


When the window opens: 
* Click "Add". 
* Select "SQL Server" and click "Finish".
* Enter a name (this can be whatever you want) "AIMpub"
* Enter a description "AIMpub"
* In the Database field add "egdbAIMPub.blm.doi.net\SdeSqlAim".
* Click Next
* Leave the next screen as default and click next.
* Select "Change the default database to:"
* Then from the dropdown that should currently say "master" select "ilmocAIMTerrestrialPub"
* click "Next"
* then click "Finish"
* A new dialogue should pop up, Click "Test Data Source"
* If the next data dialogue says: "TESTS COMPLETED SUCCESSFULLY!" you are good to go. 
* Click "Ok" and "Ok" on both open dialogues and close the ODBC Data Source dialogue.

Now you can use the `AimSqlPackage`.


## Description and Usage

Returns a named list:

Default loadds:
* Terradat (`$tdat`) sf object.
* Terradat species indicators (`$sp_ind`) as a tibble.
* LMF points (`$lmf`) as sf object.

If `extra=TRUE` returns tables:
* Soil Pit Horizons (`$s_horizons`)
* Species Rich Detail (`$sp_rich_detail`)
* State Species List (`$st_sp_list`)
* Point Weight (`$pt_weight`)

```r
load_terradat(x, extra=FALSE)
```

* `x` - the name of your ODBC connection created in the prerequisites section. 
* `extra` - if `TRUE` returns "TBLSOILPITHORIZONS", "TBLSPECRICHDETAIL", "TBLSTATESPECIES", and "POINTWEIGHT" tables in addition to the default tables.  

An example using the ODBC connection we created above:

```r
library(AimSqlTools)
data<-load_terradat("AIMpub", extra=FALSE)

data$tdat
Simple feature collection with 24829 features and 154 fields
Geometry type: POINT
Dimension:     XY
Bounding box:  xmin: -166.6331 ymin: 31.33709 xmax: -99.25646 ymax: 71.14098
Geodetic CRS:  NAD83(CSRS)
# A tibble: 24,829 x 155
   OBJECTID PrimaryKey   PlotKey  PlotID  State SpeciesState County  ProjectName  PhotoLink     EcologicalSiteId EcolSiteName DateEstablished DateVisited
 *    <int> <chr>        <chr>    <chr>   <chr> <chr>        <chr>   <chr>        <chr>         <chr>            <lgl>        <chr>           <chr>      
 1    31304 16080215540~ 1608021~ LA_UPS~ OR    OR           Lake    Oregon Lake~ https://gis.~ "R024XY015OR"    NA           2016-08-02 00:~ 2016-08-02~
 2    36877 17090912234~ 1709091~ RE-LSM~ CO    CO           Garfie~ Colorado Wh~ https://gis.~ " UNKNOWN"       NA           2017-09-09 00:~ 2017-09-09~
 3    39794 17070313051~ 1707031~ PHMA-0~ WY    WY           Natrona Wyoming  Ca~ https://gis.~ "R034AY318WY"    NA           2017-07-03 00:~ 2017-07-03~ 
 4    42711 17091108242~ 1709110~ Wysage~ CO    CO           Gunnis~ Colorado Gu~ https://gis.~ " UNKNOWN"       NA           2017-09-11 00:~ 2017-09-11~ 
 5    48284 19070911441~ 1907091~ HAF VM~ NV    NV           Washoe  Nevada Cars~ https://gis.~ "R023XY039NV"    NA           2016-08-12 06:~ 2019-07-09~ 
 6    51201 MTC00000_20~ MTC0000~ Shrub-~ SD    MT           MTC000~ MTC00000_20~ https://gis.~  NA              NA           2019-06-18 12:~ 2019-06-18~ 
 7    56774 19050915185~ 1905091~ SST-24  WY    WY           Weston  Wyoming New~ https://gis.~ "R058BY122WY"    NA           2019-05-09 00:~ 2019-06-02~
 8    32655 12080511495~ 1208051~ Stag M~ NV    NV           Elko    Nevada EKDO~ https://gis.~ " UNKNOWN"       NA           2012-08-05 00:~ 2012-08-05~ 
 9    35526 12072516540~ 1207251~ MC-1    NV    NV           Humbol~ Nevada Winn~ https://gis.~ "R025XY019NV"    NA           2012-07-23 00:~ 2013-06-21~ 
10    41145 18060409523~ 1806040~ 048     OR    OR           Malheur Oregon Hard~ https://gis.~ "UNKNOWN"        NA           2018-06-04 00:~ 2018-06-04~ 
# ... with 24,819 more rows, and 142 more variables: BareSoilCover <dbl>, TotalFoliarCover <dbl>, GapCover_25_50 <dbl>, GapCover_51_100 <dbl>,
#   GapCover_101_200 <dbl>, GapCover_200_plus <dbl>, GapCover_25_plus <dbl>, SoilStability_All <dbl>, SoilStability_Protected <dbl>,
#   SoilStability_Unprotected <dbl>, AH_NonNoxPerenForbCover <dbl>, AH_NonNoxAnnForbCover <dbl>, AH_NonNoxPerenGrassCover <dbl>,
#   AH_NonNoxAnnGrassCover <dbl>, AH_NonNoxPerenForbGrassCover <dbl>, AH_NonNoxAnnForbGrassCover <dbl>, AH_NonNoxShrubCover <dbl>,
#   AH_NonNoxSubShrubCover <dbl>, AH_NonNoxSucculentCover <dbl>, AH_NonNoxTreeCover <dbl>, AH_NonNoxCover <dbl>, AH_NoxPerenForbCover <dbl>,
#   AH_NoxAnnForbCover <dbl>, AH_NoxPerenGrassCover <dbl>, AH_NoxAnnGrassCover <dbl>, AH_NoxPerenForbGrassCover <dbl>, AH_NoxAnnForbGrassCover <dbl>,     
#   AH_NoxShrubCover <dbl>, AH_NoxSubShrubCover <dbl>, AH_NoxSucculentCover <dbl>, AH_NoxTreeCover <dbl>, AH_NoxCover <dbl>, AH_ForbCover <dbl>, ... 
```




