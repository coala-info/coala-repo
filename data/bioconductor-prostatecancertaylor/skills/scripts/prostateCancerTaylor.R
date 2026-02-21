# Code example from 'prostateCancerTaylor' vignette. See references/ for full tutorial.

### R code from vignette source 'prostateCancerTaylor.Rnw'

###################################################
### code chunk number 1: prostateCancerTaylor.Rnw:21-23 (eval = FALSE)
###################################################
## library(GEOquery)
## library(org.Hs.eg.db)


###################################################
### code chunk number 2: prostateCancerTaylor.Rnw:29-38 (eval = FALSE)
###################################################
## 
##   url <- "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE21nnn/GSE21034/matrix/"
##   destfile <-"GSE21034-GPL10264_series_matrix.txt.gz"
##   
##   if(!file.exists(destfile)){
##   download.file(paste(url,destfile,sep=""),destfile=destfile)
##   }
##   
## geoData <- getGEO(filename=destfile)


###################################################
### code chunk number 3: prostateCancerTaylor.Rnw:44-53 (eval = FALSE)
###################################################
## library(org.Hs.eg.db)
## entrezid <- unlist(mget(as.character(fData(geoData)[,2]), 
##           revmap(org.Hs.egREFSEQ),ifnotfound = NA))
## 
## anno <- data.frame(fData(geoData), Entrez = entrezid)
## anno <- anno[!is.na(anno$Entrez),]
## fData(geoData) <- data.frame(anno, 
##         Gene=unlist(mget(as.character(anno$Entrez), 
##                          org.Hs.egSYMBOL,ifnotfound=NA)))


###################################################
### code chunk number 4: prostateCancerTaylor.Rnw:58-68 (eval = FALSE)
###################################################
## pd <- pData(geoData)
## 
## pd2 <- data.frame("geo_accession" = pd$geo_accession, 
##   Sample = gsub("sample id: ", "", pd$characteristics_ch1), 
##   Sample_Group = gsub("disease status: ","", pd$characteristics_ch1.2), 
##   Gleason=gsub("biopsy_gleason_grade: ", "", pd$characteristics_ch1.4),
##   Stage = gsub("clint_stage: ", "", pd$characteristics_ch1.5),
##   Path_Stage = gsub("pathological_stage: ","",pd$characteristics_ch1.6))
## 
## rownames(pd2) <- pd2$geo_accession


###################################################
### code chunk number 5: prostateCancerTaylor.Rnw:73-86 (eval = FALSE)
###################################################
## fpath <- system.file("extdata", "STable1.csv",package="prostateCancerTaylor")
## extraClin <- read.csv(fpath)
## 
## pd2 <- merge(pd2, extraClin, by.x=2,by.y=1,all.x=TRUE,sort=FALSE)
## pd2$Time <- pd2$BCR_FreeTime
## pd2$Event <- pd2$BCR_Event == "BCR_Algorithm"
## pd2$Gleason <- paste(pd2$PathGG1,pd2$PathGG2,sep="+")
## pd2$Gleason[is.na(pd2$PathGG1) | is.na(pd2$PathGG2)] <- NA
## pData(geoData) <- pd2[,c("Sample","geo_accession",
## "Sample_Group","Gleason","Stage","Path_Stage",
## "Type","Copy.number.Cluster","Time","Event")]
## taylor <- geoData
## save(taylor, file="data/taylor.rda",compress = "xz")


