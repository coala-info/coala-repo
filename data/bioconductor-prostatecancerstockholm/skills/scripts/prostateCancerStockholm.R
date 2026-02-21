# Code example from 'prostateCancerStockholm' vignette. See references/ for full tutorial.

### R code from vignette source 'prostateCancerStockholm.Rnw'

###################################################
### code chunk number 1: prostateCancerStockholm.Rnw:15-16 (eval = FALSE)
###################################################
## library(GEOquery)


###################################################
### code chunk number 2: prostateCancerStockholm.Rnw:22-30 (eval = FALSE)
###################################################
##   url <- "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE70nnn/GSE70769/matrix/"
##   destfile <-"GSE70769_series_matrix.txt.gz"
##   
##   if(!file.exists(destfile)){
##   download.file(paste(url,destfile,sep=""),destfile=destfile)
##   }
##   
## geoData <- getGEO(filename=destfile)


###################################################
### code chunk number 3: prostateCancerStockholm.Rnw:37-82 (eval = FALSE)
###################################################
## 
## pd <- pData(geoData)
## 
## 
## pd2 <- data.frame("geo_accession" = pd$geo_accession, 
##     Sample = gsub("tumour tissue_robotic radical prostatetctomy_","",pd$title),
##   Gleason=gsub("tumour gleason: ","",pd$characteristics_ch1), 
##   ECE=gsub("extra capsular extension (ece): ","",pd$characteristics_ch1.2,fixed=TRUE),
##   PSM = gsub("positive surgical margins (psm): ","",pd$characteristics_ch1.3,fixed=TRUE),
##   BCR = gsub("biochemical relapse (bcr): ","",pd$characteristics_ch1.4,fixed=TRUE), 
##   Time = gsub("time to bcr (months): ","",pd$characteristics_ch1.5,fixed=TRUE), 
##   iCluster = gsub("derived data (iclusterplus group): ","",pd$characteristics_ch1.6,fixed=TRUE),
##   PSA=gsub("psa at diag: ", "",pd$characteristics_ch1.7,fixed=TRUE), 
##   ClinicalStage = gsub("clinical stage: ","", pd$characteristics_ch1.8,fixed=TRUE),
##   PathStage = gsub("pathology stage: ","",pd$characteristics_ch1.9,fixed=TRUE),
##   FollowUpTime = gsub("total follow up (months): ","",pd$characteristics_ch1.10,fixed=TRUE))
## 
## pd2$iCluster <- gsub("NA",NA,pd2$iCluster)
## 
## pd2$Gleason <- gsub("N/A", NA, pd2$Gleason)
## pd2$Gleason <- gsub("unknown",NA,pd2$Gleason)
## 
## pd2$ECE <- gsub("UNKNOWN",NA,pd2$ECE)
## pd2$ECE[which(pd2$ECE == "")] <- NA
## 
## pd2$PSM <- gsub("UNKNOWN",NA,pd2$PSM)
## pd2$PSM[which(pd2$PSM == "")] <- NA
## 
## pd2$BCR <- gsub("N/A", NA, pd2$BCR)
## pd2$BCR[which(pd2$BCR == "")] <- NA
## 
## pd2$Time <- gsub("N/A", NA, pd2$Time)
## pd2$Time <- gsub("UNKNOWN",NA,pd2$Time)
## pd2$Time[which(pd2$Time == "")] <- NA
## 
## pd2$FollowUpTime <- gsub("N/A", NA, pd2$FollowUpTime)
## pd2$FollowUpTime <- gsub("UNKNOWN",NA,pd2$FollowUpTime)
## pd2$FollowUpTime[which(pd2$FollowUpTime == "")] <- NA
## 
## 
## 
## rownames(pd2) <- pd2$geo_accession
## pData(geoData) <- pd2
## stockholm <- geoData
## save(stockholm, file="data/stockholm.rda",compress="xz")


