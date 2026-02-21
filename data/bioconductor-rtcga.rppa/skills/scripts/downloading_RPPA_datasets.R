# Code example from 'downloading_RPPA_datasets' vignette. See references/ for full tutorial.

## ----echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------
library(knitr)
opts_chunk$set(comment="", message=FALSE, warning = FALSE, tidy.opts=list(keep.blank.line=TRUE, width.cutoff=150), options(width=150), eval = FALSE)

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("RTCGA")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# if (!require(devtools)) {
#     install.packages("devtools")
#     require(devtools)
# }
# install_github("RTCGA/RTCGA")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# browseVignettes("RTCGA")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# library(RTCGA)
# checkTCGA('Dates')

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# (cohorts <- infoTCGA() %>%
#    rownames() %>%
#    sub("-counts", "", x=.))

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# # dir.create( "data2" ) # name of a directory in which data will be stored
# releaseDate <- "2015-11-01"
# sapply( cohorts, function(element){
# tryCatch({
# downloadTCGA( cancerTypes = element,
#               dataSet = "protein_normalization__data.Level_3",
#               destDir = "data2",
#               date = releaseDate )},
# error = function(cond){
#    cat("Error: Maybe there weren't mutations data for ", element, " cancer.\n")
# }
# )
# })

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# list.files( "data2") %>%
#    file.path( "data2", .) %>%
#    file.rename( to = substr(.,start=1,stop=50))

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# list.files( "data2") %>%
#    file.path( "data2", .) %>%
#    sapply(function(x){
#       if (x == "data2/NA")
#          file.remove(x)
#    })

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# list.files( "data2") %>%
#    file.path( "data2", .) %>%
#    sapply(function(x){
#       file.path(x, list.files(x)) %>%
#          grep(pattern = "MANIFEST.txt", x = ., value=TRUE) %>%
#          file.remove()
#       })

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# list.files("data2") %>%
#    file.path("data2", .) %>%
#    sapply(function(y){
#       file.path(y, list.files(y)) %>%
#       assign( value = .,
#               x = paste0(list.files(y) %>%
#                                        gsub(x = .,
#                                             pattern = "\\..*",
#                                             replacement = "") %>%
#                             gsub(x=., pattern="-", replacement = "_"),
#                          ".RPPA.path"),
#               envir = .GlobalEnv)
#    })

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# ls() %>%
#    grep("RPPA\\.path", x = ., value = TRUE) %>%
#    sapply(function(element){
#       tryCatch({
#          readTCGA(get(element, envir = .GlobalEnv),
#                dataType = "RPPA") %>%
#          assign(value = .,
#                 x = sub("\\.path", "", x = element),
#                 envir = .GlobalEnv )
#       }, error = function(cond){
#          cat(element)
#       })
#      invisible(NULL)
#     }
# )

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# grep( "RPPA", ls(), value = TRUE) %>%
#    grep("path", x=., value = TRUE, invert = TRUE) %>%
#    cat( sep="," ) #can one to it better? as from use_data documentation:
#    # ...	Unquoted names of existing objects to save
#    devtools::use_data(ACC.RPPA,BLCA.RPPA,BRCA.RPPA,CESC.RPPA,
#                       CHOL.RPPA,COAD.RPPA,COADREAD.RPPA,DLBC.RPPA,
#                       ESCA.RPPA,GBM.RPPA,GBMLGG.RPPA,HNSC.RPPA,
#                       KICH.RPPA,KIPAN.RPPA,KIRC.RPPA,KIRP.RPPA,
#                       LGG.RPPA,LIHC.RPPA,LUAD.RPPA,LUSC.RPPA,
#                       MESO.RPPA,OV.RPPA,PAAD.RPPA,PCPG.RPPA,
#                       PRAD.RPPA,READ.RPPA,SARC.RPPA,SKCM.RPPA,
#                       STAD.RPPA,STES.RPPA,TGCT.RPPA,THCA.RPPA,
#                       THYM.RPPA,UCEC.RPPA,UCS.RPPA,UVM.RPPA,
#                       overwrite = TRUE,
#                       compress="xz")

