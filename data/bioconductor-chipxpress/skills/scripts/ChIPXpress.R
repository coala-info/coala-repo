# Code example from 'ChIPXpress' vignette. See references/ for full tutorial.

### R code from vignette source 'ChIPXpress.Rnw'

###################################################
### code chunk number 1: ChIPXpress.Rnw:51-54
###################################################
library(ChIPXpress)
data(Oct4ESC_ChIPgenes)
head(Oct4ESC_ChIPgenes)


###################################################
### code chunk number 2: ChIPXpress.Rnw:58-62
###################################################
library(ChIPXpressData)
library(bigmemory)
path <- system.file("extdata",  package="ChIPXpressData")
DB_GPL1261 <- attach.big.matrix("DB_GPL1261.bigmemory.desc", path=path)


###################################################
### code chunk number 3: ChIPXpress.Rnw:68-71
###################################################
Output <- ChIPXpress(TFID="18999",ChIP=Oct4ESC_ChIPgenes$EntrezID,DB=DB_GPL1261)
head(Output[[1]])
head(Output[[2]])


###################################################
### code chunk number 4: ChIPXpress.Rnw:77-82
###################################################
GeneNames <- Oct4ESC_ChIPgenes$Annotation[match(names(Output[[1]]),
                                          Oct4ESC_ChIPgenes$EntrezID)]
Result <- data.frame(1:length(Output[[1]]),GeneNames,names(Output[[1]]),Output[[1]])
colnames(Result) <- c("Rank","GeneNames","EntrezID","ChIPXpressScore")
head(Result)


###################################################
### code chunk number 5: ChIPXpress.Rnw:107-117 (eval = FALSE)
###################################################
## library(bigmemory)
## library(biganalytics)
## library(ChIPXrpess)
## library(GEOquery)
## library(affy)
## library(frma)
## library(mouse4302frmavecs)
##  
## DB <- buildDatabase(GPL_id='GPL1261',SaveDir=tempdir())
## ## Make sure the save directory is already created and empty!


###################################################
### code chunk number 6: ChIPXpress.Rnw:122-125 (eval = FALSE)
###################################################
## GSM_ids <- c("GSM24056","GSM24058","GSM24060","GSM24061",
##              "GSM94856","GSM94857","GSM94858","GSM94859")
## DB <- buildDatabase(GSMfiles=GSM_ids,SaveDir=tempdir())


###################################################
### code chunk number 7: ChIPXpress.Rnw:132-135 (eval = FALSE)
###################################################
## library(mouse4302.db)
## EntrezID <- mget(as.character(rownames(DB)),mouse4302ENTREZID)
## rownames(DB) <- as.character(EntrezID)


###################################################
### code chunk number 8: ChIPXpress.Rnw:141-146 (eval = FALSE)
###################################################
## cleanDB <- cleanDatabase(DB,SaveFile="newDB_GPL1261.bigmemory",
##                          SavePath=tempdir())
## head(cleanDB)
## ### cleanDB contains the finished database ready to be 
## ### inputted into ChIPXpress.


###################################################
### code chunk number 9: ChIPXpress.Rnw:150-153 (eval = FALSE)
###################################################
## out <- ChIPXpress(TFID="18999",ChIP=Oct4ESC_ChIPgenes,DB=cleanDB)
## head(out[[1]])
## head(out[[2]])


###################################################
### code chunk number 10: ChIPXpress.Rnw:158-160 (eval = FALSE)
###################################################
## cleanDB <- attach.big.matrix("newDB_GPL1261.bigmemory.desc",path=tempdir())
## head(cleanDB)


