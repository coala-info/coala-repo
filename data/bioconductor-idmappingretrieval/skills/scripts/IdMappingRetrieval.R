# Code example from 'IdMappingRetrieval' vignette. See references/ for full tutorial.

### R code from vignette source 'IdMappingRetrieval.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: chunk1 (eval = FALSE)
###################################################
## library(IdMappingRetrieval)
## # setup verbosity level,array type and DB keys
## arrayType <- "HG-U133_Plus_2";
## primaryKey <- "Uniprot";
## secondaryKey <- "Affy";
## #initialize caching directory structure
## Annotation$init(directory="./annotationData",verbose=TRUE);
## #set Affymetrix credentials
## AnnotationAffx$setCredentials(
##    user="alex.lisovich@gmail.com",password="125438",verbose=TRUE);


###################################################
### code chunk number 2: chunk2 (eval = FALSE)
###################################################
## #create Affymetrix service object
## annAffx_Q <- tryCatch(
##   AnnotationAffx(cacheFolderName="Affymetrix",
##                  primaryColumn="Probe.Set.ID",
##                  secondaryColumn="SwissProt",
##                  swap=TRUE) );
## #create Ensembl file-based service object
## annEnsemblCsv <- tryCatch(
##   AnnotationEnsemblCsv(
##     cacheFolderName="EnsemblCsv",
##     primaryColumn=c("UniProt.SwissProt.Accession",
##                     "UniProt.TrEMBL.Accession"),
##     secondaryColumn=NA,
##     swap=FALSE, full.merge=TRUE,
##     df_filename="ENSEMBL_biomart_export.txt") );
## #create Envision service object
## annEnvision <- tryCatch(
##   AnnotationEnvision(
##     cacheFolderName="EnVision",
##     primaryColumn=c("UniProt.SwissProt.Accession",
##                     "UniProt.TrEMBL.Accession"),
##     secondaryColumn=NA,
##     swap=TRUE, species="Homo sapiens", full.merge=TRUE) );
## errorSummary = sapply(c('annAffx_Q', 'annEnsemblCsv', ''), function(service) 
##   inherits(service, "error") )
## errorMesg = ifelse(any(errorSummary), 
##       paste("(In this vignette build, the service(s) ",
##         names(which(errorSummary)), "timed out.)"),
##       errorMesg = "(All services were successfully retrieved.)"
##   )


###################################################
### code chunk number 3: chunk3a (eval = FALSE)
###################################################
## # create service objects
## services <- list();
## services$NetAffx_F <- AnnotationAffx("Affymetrix");
## 
## #collect Id Map data 
## idMapList <- lapply(services, getIdMap,
##               arrayType=arrayType,
##               primaryKey=primaryKey,
##               secondaryKey=secondaryKey,
##               force=FALSE, verbose=TRUE);
## 


###################################################
### code chunk number 4: chunk3b (eval = FALSE)
###################################################
## 
## idMapList <- lapply(services, getIdMap,
##                  arrayType=arrayType,
##                  primaryKey=primaryKey,
##                  secondaryKey=secondaryKey,
##                  force=FALSE, verbose=TRUE);
## names(idMapList);
## idMapList$NetAffx_F[100:110,];


###################################################
### code chunk number 5: chunk3c (eval = FALSE)
###################################################
## #collect complete data frames
## dfList <- lapply(services, getDataFrame,
##                  arrayType=arrayType,
##                  force=FALSE, verbose=TRUE);
## names(dfList);
## names(dfList$NetAffx_F);


###################################################
### code chunk number 6: chunk4 (eval = FALSE)
###################################################
## #create service manager object containing set of default services
## svm <- ServiceManager(ServiceManager$getDefaultServices());
## names(getServices(svm));
## idMapList <- getIdMapList(svm,
##                         arrayType=arrayType,
##                         selection=c("NetAffx_Q"),
##                         primaryKey=primaryKey,
##                         secondaryKey=secondaryKey, verbose=TRUE);
## #collect complete data frames
## dfList <- getDataFrameList(svm,
##                         arrayType=arrayType,
##                         selection=c("NetAffx_Q"), verbose=TRUE);


###################################################
### code chunk number 7: chunk5 (eval = FALSE)
###################################################
## #collect complete IdMap data interactively 
## #selecting array type and services to collect data from
## idMapList <- ServiceManager$getIdMapList(
##                    primaryKey= primaryKey,
##                    secondaryKey=secondaryKey,verbose=TRUE);
## #collect complete data frames interactively 
## #selecting array type and services to collect data from 
## dfList <- ServiceManager$getDataFrameList(
##                    arrayType="menu",
##                    selection="menu", verbose=TRUE);


###################################################
### code chunk number 8: chunk6 (eval = FALSE)
###################################################
## #remove caching directory to prevent including it into tar.gz during build
## unlink("./annotationData",recursive=TRUE);


###################################################
### code chunk number 9: sessionInfo
###################################################
toLatex(sessionInfo())


