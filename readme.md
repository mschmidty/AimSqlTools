# AimSqlTools

Is an R package to access the Terrestrial SDE MySQL database with a single function. 

## Installation

```r
devtools::install_github("mschmidty/AimSqlTools");
```

## Prerequisites 
### BLM Access
To use this package you must be on A BLM computer and logged into a BLM network either directly or through VPN. 

### Rtools
You need Rtools installed in order to install this package from source.  It is approved in the BLM Software Catalog found [here](https://doimspp.sharepoint.com/sites/blm-oc-dirm/beeio/ncm/SitePages/Search-for-Software.aspx) and requires a helpdesk ticket to install. 

### RODBC Connection
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

Defaults loads:
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
```

### Load additional Tables
You can load additional tables with: 
```r
test<-query_db2(conn, tbl_name)
```
* `conn` - is the SQL query connection. If you set up your connection using the directions above this would be "AIMPub". 
* `tbl_name` - is the sde table name "TBLSPECRICHDETAIL_evw" for example. 




