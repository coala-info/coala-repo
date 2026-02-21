# Code example from 'downloading_clinical_datasets' vignette. See references/ for full tutorial.

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
#               destDir = "data2",
#               date = releaseDate )},
# error = function(cond){
#    cat("Error: Maybe there weren't clinical data for ", element, " cancer.\n")
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
# cohorts %>%
# 	sapply(function(z){
# 		list.files("data2") %>%
# 			file.path("data2", .) %>%
# 			grep(paste0("_",z,"\\."), x = ., value = TRUE) %>%
# 			file.path(., list.files(.)) %>%
# 			grep("clin.merged.txt", x = ., value = TRUE) %>%
# 			assign(value = .,
# 						 x = paste0(z, ".clinical.path"),
# 						 envir = .GlobalEnv)
# 	})

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# ls() %>%
#    grep("clinical\\.path", x = ., value = TRUE) %>%
#    sapply(function(element){
#       tryCatch({
#          readTCGA(get(element, envir = .GlobalEnv),
#                dataType = "clinical") -> clinical_file
#          	
# 		     ## remove non-ASCII strings:
# 		     for( i in 1:ncol(clinical_file)){
# 		       clinical_file[, i] <- iconv(clinical_file[, i],
# 		                                    "UTF-8", "ASCII", sub="")
# 		     }
#          	
#          assign(value = clinical_file,
#                 x = sub("\\.path", "", x = element),
#                 envir = .GlobalEnv )
#       }, error = function(cond){
#          cat(element)
#       })
#      invisible(NULL)
#     }
# )

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# grep( "clinical", ls(), value = TRUE) %>%
#    grep("path", x=., value = TRUE, invert = TRUE) %>%
#    cat( sep="," ) #can one to it better? as from use_data documentation:
#    # ...	Unquoted names of existing objects to save
#    devtools::use_data(ACC.clinical,BLCA.clinical,BRCA.clinical,
#    									 CESC.clinical,CHOL.clinical,COAD.clinical,
#    									 COADREAD.clinical,DLBC.clinical,ESCA.clinical,
#    									 FPPP.clinical,GBM.clinical,GBMLGG.clinical,
#    									 HNSC.clinical,KICH.clinical,KIPAN.clinical,
#    									 KIRC.clinical,KIRP.clinical,LAML.clinical,
#    									 LGG.clinical,LIHC.clinical,LUAD.clinical,
#    									 LUSC.clinical,MESO.clinical,OV.clinical,
#    									 PAAD.clinical,PCPG.clinical,PRAD.clinical,
#    									 READ.clinical,SARC.clinical,SKCM.clinical,
#    									 STAD.clinical,STES.clinical,TGCT.clinical,
#    									 THCA.clinical,THYM.clinical,UCEC.clinical,
#    									 UCS.clinical,UVM.clinical,
#                       compress="xz")

