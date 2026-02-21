# Code example from 'RNAinteract' vignette. See references/ for full tutorial.

### R code from vignette source 'RNAinteract.Rnw'

###################################################
### code chunk number 1: installation (eval = FALSE)
###################################################
## source("http://bioconductor.org/biocLite.R")
## biocLite("RNAinteract")


###################################################
### code chunk number 2: sourecode (eval = FALSE)
###################################################
## Stangle(system.file("doc", "RNAinteract.Rnw", package="RNAinteract"))


###################################################
### code chunk number 3: library
###################################################
library("RNAinteract")


###################################################
### code chunk number 4: inputpath
###################################################
inputpath = system.file("RNAinteractExample",package="RNAinteract")
inputpath


###################################################
### code chunk number 5: File: Targets
###################################################
inputfile <- system.file("RNAinteractExample/Targets.txt",package="RNAinteract")
T <- read.table(inputfile, sep="\t", stringsAsFactors=FALSE, header=TRUE)
head(T)


###################################################
### code chunk number 6: File: Reagents
###################################################
inputfile <- system.file("RNAinteractExample/Reagents.txt",package="RNAinteract")
T <- read.table(inputfile, sep="\t", stringsAsFactors=FALSE, header=TRUE)
head(T[,c("RID", "TID", "PrimerSeqFor","PrimerSeqRev","Length")])


###################################################
### code chunk number 7: File: TemplateDesign
###################################################
inputfile <- system.file("RNAinteractExample/TemplateDesign.txt",package="RNAinteract")
T <- read.table(inputfile, sep="\t", stringsAsFactors=FALSE, header=TRUE)
head(T)


###################################################
### code chunk number 8: File: QueryDesign
###################################################
inputfile <- system.file("RNAinteractExample/QueryDesign.txt",package="RNAinteract")
T <- read.table(inputfile, sep="\t", stringsAsFactors=FALSE, header=TRUE)
head(T)


###################################################
### code chunk number 9: File: Platelist
###################################################
inputfile <- system.file("RNAinteractExample/Platelist.txt",package="RNAinteract")
T <- read.table(inputfile, sep="\t", stringsAsFactors=FALSE, header=TRUE)
head(T)


###################################################
### code chunk number 10: File: DataRNAinteractExample_1
###################################################
inputfile <- system.file("RNAinteractExample/DataRNAinteractExample_1.txt",package="RNAinteract")
T <- read.table(inputfile, sep="\t", stringsAsFactors=FALSE, header=TRUE)


###################################################
### code chunk number 11: create RNAinteract
###################################################
sgi = createRNAinteractFromFiles(name="RNAi interaction screen", path = inputpath)
sgi


###################################################
### code chunk number 12: channelnames
###################################################
getChannelNames(sgi)


###################################################
### code chunk number 13: main effects
###################################################
sgi <- estimateMainEffect(sgi, use.query="Ctrl_Fluc")


###################################################
### code chunk number 14: pairwise interaction term
###################################################
sgi <- computePI(sgi)


###################################################
### code chunk number 15: summarize and combine screens
###################################################
sgim <- summarizeScreens(sgi, screens=c("1","2"))
sgi3 <- bindscreens(sgi, sgim)


###################################################
### code chunk number 16: compute p-values
###################################################
sgi3 <- computePValues(sgi3)
sgi3limma <- computePValues(sgi3, method="limma")
sgi3T2 <- computePValues(sgi3, method="HotellingT2")


###################################################
### code chunk number 17: data-access-raw-data
###################################################
data("sgi")

D <- getData(sgi, type="data", do.inv.trafo = TRUE)
Dplatelayout <- getData(sgi, type="data", 
	     format="platelist", do.inv.trafo = TRUE)
splots::plotScreen(Dplatelayout[["1"]][["nrCells"]],
	     nx=sgi@pdim[2], ny=sgi@pdim[1], ncol=3)
Dmatrix <- getData(sgi, type="data", 
	     format="targetMatrix", do.inv.trafo = TRUE)


###################################################
### code chunk number 18: data-access raw data of a single screen
###################################################
data("sgi")
D <- getData(sgi, screen="2", channel="nrCells", 
             type="data", do.inv.trafo = TRUE, format="targetMatrix")


###################################################
### code chunk number 19: data-access-main-effects
###################################################
Mplatelayout <- getData(sgi, type="main", design="template", 
	     screen="1", channel="nrCells", format="platelist")
splots::plotScreen(Mplatelayout, nx=sgi@pdim[2], ny=sgi@pdim[1],
	     ncol=3)


###################################################
### code chunk number 20: data-access-pi
###################################################
NImatrix <- getData(sgi, type="ni.model", format="targetMatrix")
PImatrix <- getData(sgi, type="pi", format="targetMatrix")
PIplatelayout <- getData(sgi, type="main", design="query",
	     screen="1", channel="nrCells", format="platelist")
splots::plotScreen(PIplatelayout, nx=sgi@pdim[2], ny=sgi@pdim[1],
             ncol=3)

p.value <- getData(sgi, type="p.value", format="targetMatrix")
q.value <- getData(sgi, type="q.value", format="targetMatrix")


###################################################
### code chunk number 21: heatmaps
###################################################
plotHeatmap(sgi, screen="1", channel="nrCells")


###################################################
### code chunk number 22: doubleRNAi
###################################################
plotDoublePerturbation(sgi, screen="1", channel="nrCells", target="Ras85D")


###################################################
### code chunk number 23: simple report
###################################################
outputpath = "RNAinteractHTML"
report = startReport(outputpath)
reportAnnotation(sgi3, path = outputpath, report = report)
reportStatistics(sgi3, path = outputpath, report = report)
reportGeneLists(sgi3, path = outputpath, report = report)
reportGeneLists(sgi3limma, path = outputpath, dir="hitlistlimma",
                prefix = "hitlistlimma", report = report)


###################################################
### code chunk number 24: screen plots
###################################################
reportMainEffects(sgi3, path = outputpath, report = report)
reportScreenData(sgi3, plotScreen.args=list(ncol=3L, do.legend=TRUE,
                                               fill = c("red","white","blue")),
                 path = outputpath, report = report)


###################################################
### code chunk number 25: double perturbation plot
###################################################
reportDoublePerturbation(sgi3, path = outputpath, report = report,show.labels="p.value")


###################################################
### code chunk number 26: heatmaps
###################################################
reportHeatmap(sgi, path=outputpath, report=report)


###################################################
### code chunk number 27: endReport
###################################################
save(sgi, file=file.path(outputpath, "RNAinteractExample.rda"))
endReport(report)


###################################################
### code chunk number 28: browseURL (eval = FALSE)
###################################################
## browseURL(file.path(outputpath, "index.html"))


###################################################
### code chunk number 29: sessioninfo
###################################################
sessionInfo()


