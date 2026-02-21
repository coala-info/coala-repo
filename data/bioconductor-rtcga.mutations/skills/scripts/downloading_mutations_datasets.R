# Code example from 'downloading_mutations_datasets' vignette. See references/ for full tutorial.

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
#               dataSet = "Mutation_Packager_Calls.Level",
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
# cohorts %>%
# 	sapply(function(element){
# 		grep(paste0("_", element, "\\."),
# 				 x = list.files("data2") %>%
# 				 	file.path("data2", .),
# 				 value = TRUE)
# 		}) -> potential_datasets
# 
# for(i in seq_along(potential_datasets)){
# 	if(length(potential_datasets[[i]]) > 0){
# 		assign(value =  potential_datasets[[i]],
# 					 x = paste0(names(potential_datasets)[i], ".mutations.path"),
# 					 envir = .GlobalEnv)
# 	}
# }
# 

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# ls() %>%
#    grep("mutations\\.path", x = ., value = TRUE) %>%
#    sapply(function(element){
#       tryCatch({
#          readTCGA(get(element, envir = .GlobalEnv),
#                dataType = "mutations") -> mutations_file
#          	for( i in 1:ncol(mutations_file)){
# 						mutations_file[, i] <- iconv(mutations_file[, i],
# 																				 "UTF-8", "ASCII", sub="")
# 					}
#          	
#          assign(value = mutations_file,
#                 x = sub("\\.path", "", x = element),
#                 envir = .GlobalEnv )
#       }, error = function(cond){
#          cat(element)
#       })
#      invisible(NULL)
#     }
# )

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# grep( "mutations", ls(), value = TRUE) %>%
#    grep("path", x=., value = TRUE, invert = TRUE) %>%
#    cat( sep="," ) #can one to it better? as from use_data documentation:
#    # ...	Unquoted names of existing objects to save
#    devtools::use_data(ACC.mutations,BLCA.mutations,BRCA.mutations,
#    									 CESC.mutations,CHOL.mutations,COAD.mutations,
#    									 COADREAD.mutations,DLBC.mutations,ESCA.mutations,
#    									 GBMLGG.mutations,GBM.mutations,HNSC.mutations,
#    									 KICH.mutations,KIPAN.mutations,KIRC.mutations,
#    									 KIRP.mutations,LAML.mutations,LGG.mutations,
#    									 LIHC.mutations,LUAD.mutations,LUSC.mutations,
#    									 OV.mutations,PAAD.mutations,PCPG.mutations,
#    									 PRAD.mutations,READ.mutations,SARC.mutations,
#    									 SKCM.mutations,STAD.mutations,STES.mutations,
#    									 TGCT.mutations,THCA.mutations,UCEC.mutations,
#    									 UCS.mutations,UVM.mutations,
#                      # overwrite = TRUE,
#                       compress="xz")

