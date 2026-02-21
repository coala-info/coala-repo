# Code example from 'GreyList-demo' vignette. See references/ for full tutorial.

### R code from vignette source 'GreyList-demo.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: create
###################################################
library(GreyListChIP)
path <- system.file("extra", package="GreyListChIP")
fn <- file.path(path,"karyotype_chr21.txt")
gl <- new("GreyList",karyoFile=fn)


###################################################
### code chunk number 3: count (eval = FALSE)
###################################################
## gl <- countReads(gl,"myBamFile.bam")


###################################################
### code chunk number 4: fake
###################################################
gl@counts <- rnbinom(length(gl@tiles),size=1.08,mu=11.54)


###################################################
### code chunk number 5: threshold
###################################################
gl <- calcThreshold(gl,reps=10,sampleSize=1000,p=0.99,cores=1)


###################################################
### code chunk number 6: makeGrey
###################################################
gl <- makeGreyList(gl,maxGap=16384)
gl


###################################################
### code chunk number 7: export (eval = FALSE)
###################################################
## export(gl,con="myGreyList.bed")


###################################################
### code chunk number 8: onestep (eval = FALSE)
###################################################
## library(BSgenome.Hsapiens.UCSC.hg19)
## gl <- greyListBS(BSgenome.Hsapiens.UCSC.hg19,"myBamFile.bam")
## export(gl,con="myGreyList.bed")


###################################################
### code chunk number 9: sampleData
###################################################
# Load a pre-built GreyList object named "gl"
data(greyList)
print(gl)


###################################################
### code chunk number 10: sessionInfo
###################################################
toLatex(sessionInfo())


