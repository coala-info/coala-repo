# Code example from 'IVAS' vignette. See references/ for full tutorial.

### R code from vignette source 'IVAS.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex(use.unsrturl=FALSE)


###################################################
### code chunk number 2: loading IVAS package
###################################################
library(IVAS)


###################################################
### code chunk number 3: loading the expression data
###################################################
data(sampleexp)


###################################################
### code chunk number 4: loading the SNP data
###################################################
data(samplesnp)


###################################################
### code chunk number 5: loading the SNP position data
###################################################
data(samplesnplocus)


###################################################
### code chunk number 6: loading the txdb data
###################################################
sampleDB <- system.file("extdata","sampleDB", package="IVAS")
sample.Txdb <- loadDb(sampleDB)


###################################################
### code chunk number 7: Splicingfinder function
###################################################
ASdb <- Splicingfinder(GTFdb=sample.Txdb,calGene=NULL,Ncor=1,out.dir=NULL)
ASdb
head(slot(ASdb,"SplicingModel")$"ASS")


###################################################
### code chunk number 8: RatioFromFPKM function
###################################################
ASdb <- RatioFromFPKM(GTFdb=sample.Txdb,ASdb=ASdb,Total.expdata=sampleexp,
    CalIndex="ASS7",Ncor=1,out.dir=NULL)
ASdb
head(slot(ASdb,"Ratio")$"ASS")


###################################################
### code chunk number 9: sQTLsFinder function
###################################################
ASdb <- sQTLsFinder(ASdb=ASdb,Total.snpdata=samplesnp,
    Total.snplocus=samplesnplocus,method="lm",Ncor=1)
ASdb
head(slot(ASdb,"sQTLs")$"ASS")


###################################################
### code chunk number 10: Multi-threds function (eval = FALSE)
###################################################
## ASdb <- Splicingfinder(GTFdb=sample.Txdb,calGene=NULL,Ncor=4)
## ASdb <- RatioFromFPKM(GTFdb=sample.Txdb,ASdb=ASdb,Total.expdata=sampleexp,Ncor=4)
## ASdb <- sQTLsFinder(ASdb=ASdb,Total.snpdata=samplesnp,
##     Total.snplocus=samplesnplocus,method="lm",Ncor = 4)
## ASdb


###################################################
### code chunk number 11: saveBplot function
###################################################
saveBplot(ASdb=ASdb,Total.snpdata=samplesnp,Total.snplocus=samplesnplocus,
    CalIndex="ASS7",out.dir="./result")


###################################################
### code chunk number 12: sessionInfo
###################################################
sessionInfo()


