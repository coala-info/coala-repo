# Code example from 'downloading_miRNASeq_datasets' vignette. See references/ for full tutorial.

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
# #dir.create( "data2" )
# releaseDate <- "2015-11-01"
# 
# # data produced with Illumina Genome Analyzer machine
# sapply( cohorts, function(element){
# tryCatch({
# downloadTCGA( cancerTypes = element,
#               dataSet = "Merge_mirnaseq__illuminaga_mirnaseq__bcgsc_ca__Level_3__miR_gene_expression__data.Level_3",
#               destDir = "data2",
#               date = releaseDate )},
# error = function(cond){
#    cat("Error: Maybe there weren't mutations data for ", element, " cancer.\n")
# }
# )
# })
# 
# # data produced with Illumina HiSeq 2000 machine
# sapply( cohorts, function(element){
# tryCatch({
# downloadTCGA( cancerTypes = element,
#               dataSet = "Merge_mirnaseq__illuminahiseq_mirnaseq__bcgsc_ca__Level_3__miR_gene_expression__data.Level_3",
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
#    file.rename( to = substr(.,start=1,stop=70))

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
# data2_files <- list.files("data2")
# 
# # Paths to data produced with Illumina Genome Analyzer machine
# illuminaga <- which(grepl("illuminaga", x = data2_files))
# data2_files[illuminaga] %>%
#    file.path("data2", .) %>%
#    sapply(function(y){
#       file.path(y, list.files(y)) %>%
#          assign( value = .,
#                  x = paste0(list.files(y) %>%
#                             gsub(x = .,pattern = "\\..*",replacement = "") %>%
#                             gsub(x=., pattern="-", replacement = "_"),
#                             ".miRNASeq_illuminaga.path"),
#                  envir = .GlobalEnv)
#       })
# # Paths to data produced with Illumina HiSeq 2000 machine
# data2_files[-illuminaga] %>%
#    file.path("data2", .) %>%
#    sapply(function(y){
#       file.path(y, list.files(y)) %>%
#          assign( value = .,
#                  x = paste0(list.files(y) %>%
#                             gsub(x = .,pattern = "\\..*",replacement = "") %>%
#                             gsub(x=., pattern="-", replacement = "_"),
#                          ".miRNASeq_illuminahiseq.path"),
#                  envir = .GlobalEnv)
#       })

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# path_vector <- ls() %>%
#    grep("miRNASeq.*path", x = ., value = TRUE)
# # First we will read miRNASeq data produced by both Illumina Genome Analyzer and
# # Illumina HiSeq 2000 machines
# path_vector %>%
#    sapply(function(element){
#       tryCatch({
#          readTCGA(get(element, envir = .GlobalEnv),
#                dataType = "miRNASeq") %>%
#          assign(value = .,
#                 x = sub("\\.path", "", x = element),
#                 envir = .GlobalEnv )
#       }, error = function(cond){
#          cat(element)
#       })
#      invisible(NULL)
#     }
# )
# 
# # Now we will add special column `machine` to miRNASeq data depending on
# # kind of machine which produced data
# sapply(cohorts, function(element){
#    w <- grep(paste0("^",element, "\\."), x = path_vector, value = TRUE)
#    if (length(w) == 0) {
#       invisible(NULL)
#    } else if ((length(w) == 1) && grepl("illuminaga", x = w)){
#       data <- get(paste0(element,".miRNASeq_illuminaga"), envir = .GlobalEnv)
#       data <- cbind(machine = "Illumina Genome Analyzer", data)
#    } else if ((length(w) == 1) && grepl("illuminahiseq", x = w)){
#       data <- get(paste0(element,".miRNASeq_illuminahiseq"), envir = .GlobalEnv)
#       data <- cbind(machine = "Illumina HiSeq 2000", data)
#    } else if ((length(w) == 2) && grepl("illuminaga|illuminahiseq", x=w[1]) && grepl("illuminaga|illuminahiseq", x=w[2])){
#       data_illuminaga <- get(paste0(element,".miRNASeq_illuminaga"), envir = .GlobalEnv)
#       data_illuminaga <- cbind(machine = "Illumina Genome Analyzer", data_illuminaga)
#       data_illuminahiseq <- get(paste0(element,".miRNASeq_illuminahiseq"), envir = .GlobalEnv)
#       data_illuminahiseq <- cbind(machine = "Illumina HiSeq 2000", data_illuminahiseq)
#       data <- rbind(data_illuminaga, data_illuminahiseq)
#    }
#    assign(value = data, x = paste0(element, ".miRNASeq"), envir = .GlobalEnv )
#    invisible(NULL)
# })
# 

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# grep( "miRNASeq", x=ls(), value = TRUE) %>%
#    grep("illuminahiseq|illuminaga", x = ., value = TRUE, invert = TRUE) %>%
#    cat( sep="," ) #can one to id better? as from use_data documentation:
#    # ...	Unquoted names of existing objects to save
#    devtools::use_data(ACC.miRNASeq,BLCA.miRNASeq,BRCA.miRNASeq,CESC.miRNASeq,
#                       CHOL.miRNASeq,COAD.miRNASeq,COADREAD.miRNASeq,DLBC.miRNASeq,
#                       ESCA.miRNASeq,FPPP.miRNASeq,GBM.miRNASeq,GBMLGG.miRNASeq,
#                       HNSC.miRNASeq,KICH.miRNASeq,KIPAN.miRNASeq,KIRC.miRNASeq,
#                       KIRP.miRNASeq,LAML.miRNASeq,LGG.miRNASeq,LIHC.miRNASeq,
#                       LUAD.miRNASeq,LUSC.miRNASeq,MESO.miRNASeq,OV.miRNASeq,
#                       PAAD.miRNASeq,PCPG.miRNASeq,PRAD.miRNASeq,READ.miRNASeq,
#                       SARC.miRNASeq,SKCM.miRNASeq,STAD.miRNASeq,STES.miRNASeq,
#                       TGCT.miRNASeq,THCA.miRNASeq,THYM.miRNASeq,UCEC.miRNASeq,
#                       UCS.miRNASeq,UVM.miRNASeq,
#                       overwrite = TRUE,
#                       compress="xz")

