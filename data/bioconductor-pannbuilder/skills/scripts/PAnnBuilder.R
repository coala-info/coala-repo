# Code example from 'PAnnBuilder' vignette. See references/ for full tutorial.

### R code from vignette source 'PAnnBuilder.Rnw'

###################################################
### code chunk number 1: tempdir
###################################################
tempdir() 


###################################################
### code chunk number 2: install (eval = FALSE)
###################################################
## source("http://bioconductor.org/biocLite.R")
## biocLite("PAnnBuilder")


###################################################
### code chunk number 3: load
###################################################
library(PAnnBuilder)


###################################################
### code chunk number 4: urls (eval = FALSE)
###################################################
## library(PAnnBuilder)         ## Load package 
## getALLUrl("Homo sapiens")    ## Get urls 
## getALLBuilt("Homo sapiens")  ## Get version/release


###################################################
### code chunk number 5: exampleInstall1 (eval = FALSE)
###################################################
## biocLite("org.Hs.ipi.db")


###################################################
### code chunk number 6: exampleLoad1
###################################################
library(org.Hs.ipi.db) # Load annotation package


###################################################
### code chunk number 7: help
###################################################
?org.Hs.ipiGENEID


###################################################
### code chunk number 8: data1
###################################################
xx <- as.list(org.Hs.ipiGENEID)
xx[!is.na(xx)][1:3]
xx[["IPI00792103.1"]]


###################################################
### code chunk number 9: data2
###################################################
## Access the data in table (data.frame) format via function "toTable".
toTable(org.Hs.ipiPATH[1:3])
## reverse the role of protein and pathway via 
## function "revmap" or "reverseSplit".
tmp1 <- revmap(org.Hs.ipiPATH)  ## return a AnnDbBimap Object
class(tmp1)
as.list(tmp1)[1]
tmp2 <- reverseSplit(as.list(org.Hs.ipiPATH)) ## return a list Object
class(tmp2)
tmp2[1]

## The left and right keys of the Bimap can be extracted 
## using "Lkeys" and "Rkeys".
Lkeys(org.Hs.ipiPATH)[1:3]
Rkeys(org.Hs.ipiPATH)[1:3]

## Get the create table statements.
org.Hs.ipi_dbschema()

## Use "SELECT" SQL query.
selectSQL<-paste("SELECT ipi_id, de",
           "FROM basic",
           "WHERE de like '%histone%'")
tmp3 <- dbGetQuery(org.Hs.ipi_dbconn(), selectSQL)
tmp3[1:3,]


###################################################
### code chunk number 10: parameter
###################################################
# Set path, version and author for the package.
library(PAnnBuilder)
pkgPath <- tempdir()
version <- "1.0.0"
author <- list()
author[["authors"]] <- "Hong Li"
author[["maintainer"]] <- "Hong Li <sysptm@gmail.com>"


###################################################
### code chunk number 11: pBaseBuilder (eval = FALSE)
###################################################
##  ## Build SQLite based annotation package "org.Mm.ipi.db" 
##  ## for Mouse IPI database.
##  ## Note: Perl is needed for parsing data file. 
##  ##       Rtools is needed for Windows user.
##  pBaseBuilder_DB(baseMapType = "ipi", organism = "Mus musculus",  
##                  prefix = "org.Mm.ipi", pkgPath = pkgPath, version = version, 
##                  author = author)              


###################################################
### code chunk number 12: subcellBaseBuilder
###################################################
 ## Build subcellular location annotation package "sc.bacello.db" 
 ## from BaCelLo database.
 subcellBuilder_DB(src="BaCelLo", prefix="sc.bacello", 
                pkgPath, version, author)
  ## List all files in created directory "sc.bacello.db".
  dir(file.path(pkgPath,"sc.bacello.db"))


###################################################
### code chunk number 13: pSeqBuilder (eval = FALSE)
###################################################
## ## Read query sequence.
## tmp = system.file("extdata", "query.example", package="PAnnBuilder")
## tmp = readLines(tmp)
## tag = grep("^>",tmp)
## query <- sapply(1:(length(tag)-1), function(x){ 
##      paste(tmp[(tag[x]+1):(tag[x+1]-1)], collapse="") })
## query <- c(query, paste(tmp[(tag[length(tag)]+1):length(tmp)], collapse="") )
## names(query) = sub(">","",tmp[tag])
## ## Set parameters for sequence similarity.
## blast <- c("blastp", "10.0", "BLOSUM62", "0", "-1", "-1", "T", "F")
## names(blast) <- c("p","e","M","W","G","E","U","F")
## match <- c(0.00001, 0.9, 0.9)
## names(match) <- c("e","c","i")
## 
## ## Install ackages "org.Hs.sp", "org.Hs.ipi".
## if( !require("org.Hs.sp.db") ){
##   biocLite("org.Hs.sp.db")
## }
## if( !require("org.Hs.ipi.db") ){
##   biocLite("org.Hs.ipi.db")
## }
## 
## ## Use packages "org.Hs.sp.db", "org.Hs.ipi.db" to produce annotation  
## ## R package for query sequence.
##   annPkgs = c("org.Hs.sp.db","org.Hs.ipi.db")  
##   seqName = c("org.Hs.spSEQ","org.Hs.ipiSEQ")  
##   pSeqBuilder_DB(query, annPkgs, seqName, blast, match, 
##   prefix="test1", pkgPath, version, author)  


###################################################
### code chunk number 14: PAnnBuilder.Rnw:590-591
###################################################
sessionInfo()


