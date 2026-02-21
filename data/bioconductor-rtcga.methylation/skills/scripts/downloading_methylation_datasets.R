# Code example from 'downloading_methylation_datasets' vignette. See references/ for full tutorial.

## ----echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------
library(knitr)
opts_chunk$set(comment="", message=FALSE, warning = FALSE, tidy.opts=list(keep.blank.line=TRUE, width.cutoff=150),options(width=150), eval = FALSE)

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("RTCGA")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# BiocManager::install("RTCGA/RTCGA")

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
# #dir.create( "data2" )
# releaseDate <- "2015-11-01"
# sapply(cohorts,
# 			 function(element){
# 			 	try({
# downloadTCGA( cancerTypes = element,
#               dataSet = "Merge_methylation__humanmethylation27",
#               destDir = "data2",
#               date = releaseDate )
# 				})
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
# 
# list.files("data2") %>%
#    file.path("data2", .) %>%
#    sapply(function(y){
#       file.path(y, list.files(y)) %>%
#       assign(value = .,
#               x = paste0(list.files(y) %>%
#                            gsub(x = .,
#                                 pattern = "\\..*",
#                                 replacement = "") %>%
#                             gsub(x=.,
#                             		 pattern="-",
#                             		 replacement = "_"),
#                          ".methylation.path"),
#               envir = .GlobalEnv)
#    })

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# ls() %>%
#    grep("methylation\\.path", x = ., value = TRUE) %>%
#    sapply(function(element){
#       try({
#          readTCGA(get(element, envir = .GlobalEnv),
#                dataType = "methylation") %>%
#          assign(value = .,
#                 x = sub("\\.path", "", x = element),
#                 envir = .GlobalEnv )
#       })
#      invisible(NULL)
#     })

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# OV.methylation[1:300,] -> OV.methylation1
# OV.methylation[301:612,] -> OV.methylation2
# rm(OV.methylation)
# grep( "methylation", ls(), value = TRUE) %>%
#    grep("path", x=., value = TRUE, invert = TRUE) %>%
#    cat( sep="," ) #can one to id better? as from use_data documentation:
#    # ...	Unquoted names of existing objects to save
#    devtools::use_data(BRCA.methylation,COAD.methylation,
#    									 COADREAD.methylation,GBMLGG.methylation,
#    									 GBM.methylation,KIPAN.methylation,
#    									 KIRC.methylation,KIRP.methylation,
#    									 LAML.methylation,LUAD.methylation,
#    									 LUSC.methylation,OV.methylation1,OV.methylation2,
#    									 READ.methylation,STAD.methylation,
#    									 STES.methylation,UCEC.methylation,
#                      # overwrite = TRUE,
#                       compress="xz")

