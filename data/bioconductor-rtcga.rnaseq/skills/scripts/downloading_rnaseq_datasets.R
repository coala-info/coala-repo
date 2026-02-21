# Code example from 'downloading_rnaseq_datasets' vignette. See references/ for full tutorial.

## ----echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------
library(knitr)
opts_chunk$set(comment="", message=FALSE, warning = FALSE, tidy.opts=list(keep.blank.line=TRUE, width.cutoff=150), options(width=150), eval = FALSE)

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# source("http://bioconductor.org/biocLite.R")
# biocLite("RTCGA")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# if (!require(devtools)) {
#     install.packages("devtools")
#     require(devtools)
# }
# biocLite("RTCGA/RTCGA")

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
#               dataSet = "rnaseqv2__illuminahiseq_rnaseqv2__unc_edu__Level_3__RSEM_genes_normalized__data.Level",
#               destDir = "data2",
#               date = releaseDate )},
# error = function(cond){
#    cat("Error: Maybe there weren't rnaseq data for ", element, " cancer.\n")
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
#                          ".rnaseq.path"),
#               envir = .GlobalEnv)
#    })

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# ls() %>%
#    grep("rnaseq\\.path", x = ., value = TRUE) %>%
#    sapply(function(element){
#       tryCatch({
#          readTCGA(get(element, envir = .GlobalEnv),
#                dataType = "rnaseq") %>%
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
# grep( "rnaseq", ls(), value = TRUE) %>%
#    grep("path", x=., value = TRUE, invert = TRUE) %>%
#    cat( sep="," ) #can one to it better? as from use_data documentation:
#    # ...	Unquoted names of existing objects to save
#    devtools::use_data(ACC.rnaseq,BLCA.rnaseq,BRCA.rnaseq,
#    									 CESC.rnaseq,CHOL.rnaseq,COADREAD.rnaseq,
#    									 COAD.rnaseq,DLBC.rnaseq,ESCA.rnaseq,
#    									 GBMLGG.rnaseq,GBM.rnaseq,HNSC.rnaseq,
#    									 KICH.rnaseq,KIPAN.rnaseq,KIRC.rnaseq,
#    									 KIRP.rnaseq,LAML.rnaseq,LGG.rnaseq,
#    									 LIHC.rnaseq,LUAD.rnaseq,LUSC.rnaseq,
#    									 OV.rnaseq,PAAD.rnaseq,PCPG.rnaseq,
#    									 PRAD.rnaseq,READ.rnaseq,SARC.rnaseq,
#    									 SKCM.rnaseq,STAD.rnaseq,STES.rnaseq,
#    									 TGCT.rnaseq,THCA.rnaseq,THYM.rnaseq,
#    									 UCEC.rnaseq,UCS.rnaseq,UVM.rnaseq,
#                      # overwrite = TRUE,
#                       compress="xz")

