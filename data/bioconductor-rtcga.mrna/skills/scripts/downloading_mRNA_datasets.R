# Code example from 'downloading_mRNA_datasets' vignette. See references/ for full tutorial.

## ----echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------
library(knitr)
opts_chunk$set(comment="", message=FALSE, warning = FALSE, tidy.opts=list(keep.blank.line=TRUE, width.cutoff=150),options(width=150), eval = FALSE)

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
# # dir.create( "data2" )
# releaseDate <- "2015-11-01"
# sapply( cohorts, function(element){
# tryCatch({
# downloadTCGA( cancerTypes = element,
#               dataSet = "Merge_transcriptome__agilentg4502a_07_3__unc_edu__Level_3__unc_lowess_normalization_gene_level__data.Level_3",
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
# 
# list.files("data2") %>%
#    file.path("data2", .) %>%
#    sapply(function(y){
#       file.path(y, list.files(y)) %>%
#       assign( value = .,
#               x = paste0(list.files(y) %>%
#                             gsub(x = .,
#                                  pattern = "\\..*",
#                                  replacement = "") %>%
#                             gsub(x=., pattern="-", replacement = "_"),
#                          ".mRNA.path"),
#               envir = .GlobalEnv)
#    })

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# ls() %>%
#    grep("mRNA\\.path", x = ., value = TRUE) %>%
#    sapply(function(element){
#       tryCatch({
#          readTCGA(get(element, envir = .GlobalEnv),
#                dataType = "mRNA") %>%
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
# grep( "mRNA", ls(), value = TRUE) %>%
#    grep("path", x=., value = TRUE, invert = TRUE) %>%
#    cat( sep="," ) #can one to id better? as from use_data documentation:
#    # ...	Unquoted names of existing objects to save
#    devtools::use_data(BRCA.mRNA,COAD.mRNA,COADREAD.mRNA,GBMLGG.mRNA,
#                       KIPAN.mRNA,KIRC.mRNA,KIRP.mRNA,LGG.mRNA,LUAD.mRNA,
#                       LUSC.mRNA,OV.mRNA,READ.mRNA,UCEC.mRNA,
#                       overwrite = TRUE,
#                       compress="xz")

