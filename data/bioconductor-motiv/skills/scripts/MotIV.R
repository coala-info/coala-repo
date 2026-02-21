# Code example from 'MotIV' vignette. See references/ for full tutorial.

### R code from vignette source 'MotIV.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(prompt = " ", continue = " ", width = 85)


###################################################
### code chunk number 2: loading MotIV
###################################################
library(MotIV)
path <- system.file(package="MotIV")


###################################################
### code chunk number 3: Load the database
###################################################
jaspar <- readPWMfile(paste(path,"/extdata/jaspar2010.txt",sep=""))


###################################################
### code chunk number 4: Load database scores
###################################################
jaspar.scores <- readDBScores(paste(path,"/extdata/jaspar2010_PCC_SWU.scores",sep=""))


###################################################
### code chunk number 5: Read input PWM
###################################################
example.motifs <- readPWMfile(paste(path,"/extdata/example_motifs.txt",sep=""))


###################################################
### code chunk number 6: start the analysis
###################################################
example.jaspar <- motifMatch(inputPWM=example.motifs,align="SWU",cc="PCC",database=jaspar,DBscores=jaspar.scores,top=5)


###################################################
### code chunk number 7: Viewresults
###################################################
summary(example.jaspar)
viewAlignments(example.jaspar)[[1]]
plot(example.jaspar[1:4],ncol=2,top=5, cex=0.8)


###################################################
### code chunk number 8: Viewresults
###################################################
foxa1.filter <- setFilter(tfname="FOXA")
ap1.filter <- setFilter(tfname="AP1")
foxa1.ap1.filter <- foxa1.filter | ap1.filter
example.filter <- filter(example.jaspar,foxa1.ap1.filter, exact=F)
summary(example.filter)
plot(example.filter,ncol=2,top=5)


###################################################
### code chunk number 9: loading MotIV package (eval = FALSE)
###################################################
## library(MotIV) 


###################################################
### code chunk number 10: load DB
###################################################
 jaspar <- readPWMfile(paste(path,"/extdata/jaspar2010.txt",sep=""))


###################################################
### code chunk number 11: generate scores (eval = FALSE)
###################################################
## jaspar.scores <- generateDBScores(inputDB=jaspar,cc="PCC",align="SWU",nRand=1000)


###################################################
### code chunk number 12: write scores (eval = FALSE)
###################################################
## writeDBScores(jaspar.scores,paste(path,"/extdata/jaspar_PCC_SWU.scores",sep=""))


###################################################
### code chunk number 13: read scores
###################################################
jaspar.scores <- readDBScores(paste(path,"/extdata/jaspar2010_PCC_SWU.scores",sep=""))


###################################################
### code chunk number 14: load gadem object
###################################################
load(paste(path, "/data/FOXA1_rGADEM.rda", sep = ""))
motifs <- getPWM(gadem)


###################################################
### code chunk number 15: load gadem file
###################################################
motifs.gadem <- readGademPWMFile(paste(path,"/extdata/observedPWMs.txt",sep=""))


###################################################
### code chunk number 16: load transfac file
###################################################
motifs.example <- readPWMfile(paste(path,"/extdata/example_motifs.txt",sep=""))


###################################################
### code chunk number 17: trim input
###################################################
motifs.trimed <- lapply(motifs,trimPWMedge, threshold=1)


###################################################
### code chunk number 18: motiv analysis
###################################################
foxa1.analysis.jaspar <- motifMatch(inputPWM=motifs,align="SWU",cc="PCC",database=jaspar,DBscores=jaspar.scores,top=5)


###################################################
### code chunk number 19: motiv analysis shot
###################################################
foxa1.analysis.jaspar <- motifMatch(motifs)


###################################################
### code chunk number 20: motiv summary
###################################################
summary(foxa1.analysis.jaspar )


###################################################
### code chunk number 21: setFilter
###################################################
f.foxa1<- setFilter( tfname="FOXA1", top=3, evalueMax=10^-5)
f.ap1 <- setFilter (tfname="AP1", top=3)


###################################################
### code chunk number 22: operators
###################################################
f.foxa1.ap1 <- f.foxa1 | f.ap1 


###################################################
### code chunk number 23: filter
###################################################
foxa1.filter <- filter(foxa1.analysis.jaspar, f.foxa1.ap1, exact=FALSE, verbose=TRUE)


###################################################
### code chunk number 24: split
###################################################
foxa1.split <- split(foxa1.analysis.jaspar, c(f.foxa1, f.ap1) , drop=FALSE, exact=FALSE, verbose=TRUE)


###################################################
### code chunk number 25: combine
###################################################
foxa1.filter.combine <- combineMotifs(foxa1.filter, c(f.foxa1, f.ap1), exact=FALSE, name=c("FOXA1", "AP1"), verbose=TRUE)


###################################################
### code chunk number 26: motiv_plotMotiv
###################################################
plot(foxa1.filter.combine ,ncol=2,top=5, rev=FALSE, main="Logo", bysim=TRUE)


###################################################
### code chunk number 27: motiv alignment
###################################################
foxa1.alignment <- viewAlignments(foxa1.filter.combine )
print(foxa1.alignment[[1]] )


###################################################
### code chunk number 28: motiv_plotDistribution
###################################################
plot(foxa1.filter.combine ,gadem,ncol=2, type="distribution", correction=TRUE, group=FALSE, bysim=TRUE, strand=FALSE, sort=TRUE, main="Distribution of FOXA")


###################################################
### code chunk number 29: motiv_plotDistance
###################################################
plot(foxa1.filter.combine ,gadem,type="distance", correction=TRUE, group=TRUE, bysim=TRUE, main="Distance between FOXA and AP-1", strand=FALSE, xlim=c(-100,100), bw=8)


###################################################
### code chunk number 30: rangedData
###################################################
foxa1.gr <- exportAsGRanges(foxa1.filter.combine["FOXA1"], gadem)
ap1.gr <- exportAsGRanges(foxa1.filter.combine["AP1"], gadem)


###################################################
### code chunk number 31: motiv save
###################################################
save(foxa1.filter.combine, file="foxa1_analysis.rda")


###################################################
### code chunk number 32: motiv exportAsTransfacFile (eval = FALSE)
###################################################
## exportAsTransfacFile(foxa1.filter.combine, file="foxa1_analysis")


###################################################
### code chunk number 33: bedfile (eval = FALSE)
###################################################
## library(rtracklayer)
## export(foxa1.gr, file="FOXA.bed")


###################################################
### code chunk number 34: viewMotifs
###################################################
viewMotifs(foxa1.filter.combine, n=5)


###################################################
### code chunk number 35: names
###################################################
names(foxa1.filter.combine)


###################################################
### code chunk number 36: similar
###################################################
similarity(foxa1.filter.combine)


###################################################
### code chunk number 37: select
###################################################
foxa1.selected <- foxa1.filter.combine["FOXA1"]
other.selected <- foxa1.filter.combine["FOXA1", drop=T]


###################################################
### code chunk number 38: select number
###################################################
foxa1.names <- names(foxa1.filter.combine["FOXA1"])
sum(length(gadem[foxa1.names]))


###################################################
### code chunk number 39: as_data_frame
###################################################
head(as.data.frame(foxa1.analysis.jaspar))


