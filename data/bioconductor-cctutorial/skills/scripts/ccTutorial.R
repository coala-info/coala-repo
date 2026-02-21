# Code example from 'ccTutorial' vignette. See references/ for full tutorial.

### R code from vignette source 'ccTutorial.Rnw'

###################################################
### code chunk number 1: prepare (eval = FALSE)
###################################################
## options(length=55, digits=3)
## options(SweaveHooks=list(
##    along=function() par(mar=c(2.5,4.2,4,1.5), font.lab=2),
##    boxplot=function() par(mar=c(5,5,1,1), font.lab=2)))
## set.seed(1)


###################################################
### code chunk number 2: loadpackage (eval = FALSE)
###################################################
## library("Ringo")
## library("biomaRt")
## library("topGO")
## library("xtable")
## library("ccTutorial")
## library("lattice")


###################################################
### code chunk number 3: locateData (eval = FALSE)
###################################################
## pairDir <- system.file("PairData",package="ccTutorial") 
## list.files(pairDir, pattern="pair$")


###################################################
### code chunk number 4: remark1 (eval = FALSE)
###################################################
## # the following chunk 'readNimblegen' requires at least 1GB of RAM
## # and takes about 10 minutes. If time and memory are issues, you can
## # skip this step, see chunk 'remark2' below.


###################################################
### code chunk number 5: readNimblegen (eval = FALSE)
###################################################
## RGs <- lapply(sprintf("files_array%d.txt",1:4),
##   readNimblegen, "spottypes.txt", path=pairDir)


###################################################
### code chunk number 6: loadProbeAnno (eval = FALSE)
###################################################
## data("probeAnno")
## allChrs <- chromosomeNames(probeAnno)


###################################################
### code chunk number 7: showmm9genes (eval = FALSE)
###################################################
## data("mm9genes")
## mm9genes[sample(nrow(mm9genes), 4), 
##    c("name", "chr", "strand", "start", "end", "symbol")]


###################################################
### code chunk number 8: loadMm9.gene2GO (eval = FALSE)
###################################################
## data("mm9.gene2GO")


###################################################
### code chunk number 9: loadGenesGOAnnotation (eval = FALSE)
###################################################
## data("mm9.g2p")


###################################################
### code chunk number 10: arrayGenes (eval = FALSE)
###################################################
## arrayGenes <- names(mm9.g2p)[listLen(mm9.g2p)>=5]
## arrayGenesWithGO <- intersect(arrayGenes, names(mm9.gene2GO))


###################################################
### code chunk number 11: remark2 (eval = FALSE)
###################################################
## # the following chunk 'preprocess' requires at least 1GB of RAM
## # and takes about 5 minutes. If time and memory are issues, 
## # instead of running that chunk, you can load the result 'X', the
## # ExpressionSet holding the fold changes after preprocessing, by
## data("X")


###################################################
### code chunk number 12: preprocess (eval = FALSE)
###################################################
## MAs <- lapply(RGs, function(thisRG)
##   preprocess(thisRG[thisRG$genes$Status=="Probe",], 
##              method="nimblegen", returnMAList=TRUE))
## MA <- do.call(rbind, MAs)
## X  <- asExprSet(MA)
## sampleNames(X) <- paste(X$Cy5, X$Tissue, sep=".")


###################################################
### code chunk number 13: chipAlongChromActc1 (eval = FALSE)
###################################################
## plot(X, probeAnno, chrom="2", xlim=c(113.8725e6,113.8835e6), 
##      ylim=c(-3,5), gff=mm9genes, paletteName='Set2')


###################################################
### code chunk number 14: smoothing (eval = FALSE)
###################################################
## smoothX <- computeRunningMedians(X, probeAnno=probeAnno, 
##   modColumn="Tissue", allChr=allChrs, winHalfSize=450, min.probes=5)
## sampleNames(smoothX) <- paste(sampleNames(X),"smoothed",sep=".")
## combX <- cbind2(X, smoothX)


###################################################
### code chunk number 15: smoothAlongChromActc1 (eval = FALSE)
###################################################
## plot(combX, probeAnno, chrom="2", xlim=c(113.8725e6,113.8835e6),
##      ylim=c(-3,5), gff=mm9genes, 
##      colPal=c(brewer.pal(8,"Set2")[1:2],brewer.pal(8,"Dark2")[1:2]))


###################################################
### code chunk number 16: computeY0 (eval = FALSE)
###################################################
## y0 <- apply(exprs(smoothX), 2, upperBoundNull, prob=0.99)


###################################################
### code chunk number 17: histogramsSmoothed (eval = FALSE)
###################################################
## myPanelHistogram <- function(x, ...){
##   panel.histogram(x, col=brewer.pal(8,"Dark2")[panel.number()], ...)
##   panel.abline(v=y0[panel.number()], col="red")
## }
## 
## h = histogram( ~ y | z, 
##       data = data.frame(
##         y = as.vector(exprs(smoothX)), 
##         z = rep(X$Tissue, each = nrow(smoothX))), 
##       layout = c(1,2), nint = 50, 
##       xlab = "smoothed reporter level [log2]",
##       panel = myPanelHistogram)
## 
## print(h)


###################################################
### code chunk number 18: computeY0Echo (eval = FALSE)
###################################################
## y0 <- apply(exprs(smoothX), 2, upperBoundNull, prob=0.99)


###################################################
### code chunk number 19: cherFinding (eval = FALSE)
###################################################
## chersX <- findChersOnSmoothed(smoothX, 
##    probeAnno = probeAnno, 
##    thresholds = y0, 
##    allChr = allChrs, 
##    distCutOff = 450, 
##    minProbesInRow = 5, 
##    cellType = X$Tissue)


###################################################
### code chunk number 20: relateChers (eval = FALSE)
###################################################
## chersX <- relateChers(chersX, mm9genes, upstream=5000)


###################################################
### code chunk number 21: loadCherFinding (eval = FALSE)
###################################################
## # since especially the call to relateChers takes some time, we load the
## ## pre-saved image here:
## data("chersX")


###################################################
### code chunk number 22: showChers (eval = FALSE)
###################################################
## chersXD <- as.data.frame(chersX)
## head(chersXD[
##   order(chersXD$maxLevel, decreasing=TRUE), 
##   c("chr", "start", "end", "cellType", "features", "maxLevel", "score")])


###################################################
### code chunk number 23: plotCher1 (eval = FALSE)
###################################################
## plot(chersX[[which.max(chersXD$maxLevel)]], smoothX, probeAnno=probeAnno, 
##      gff=mm9genes, paletteName="Dark2", ylim=c(-1,6))


###################################################
### code chunk number 24: showCellType (eval = FALSE)
###################################################
## table(chersXD$cellType)


###################################################
### code chunk number 25: getGenesEnrichedPerTissue (eval = FALSE)
###################################################
## brainGenes <- getFeats(chersX[sapply(chersX, cellType)=="brain"])
## heartGenes <- getFeats(chersX[sapply(chersX, cellType)=="heart"])
## brainOnlyGenes <- setdiff(brainGenes, heartGenes)
## heartOnlyGenes <- setdiff(heartGenes, brainGenes)


###################################################
### code chunk number 26: useTopGO (eval = FALSE)
###################################################
## brainRes <- sigGOTable(brainOnlyGenes, gene2GO=mm9.gene2GO,
##                        universeGenes=arrayGenesWithGO)
## print(brainRes)


###################################################
### code chunk number 27: useTopGOHeart (eval = FALSE)
###################################################
## heartRes <- sigGOTable(heartOnlyGenes,  gene2GO=mm9.gene2GO,
##                        universeGenes=arrayGenesWithGO)
## print(heartRes)


###################################################
### code chunk number 28: loadExpressionData (eval = FALSE)
###################################################
## data("barreraExpressionX")


###################################################
### code chunk number 29: loadArrayGenesToProbeSets (eval = FALSE)
###################################################
## data("arrayGenesToProbeSets")


###################################################
### code chunk number 30: compareChIPAndExpression (eval = FALSE)
###################################################
## bX <- exprs(barreraExpressionX)
## allH3K4me3Genes  <- union(brainGenes, heartGenes)
## allH3K4ProbeSets <- unlist(arrayGenesToProbeSets[allH3K4me3Genes])
## noH3K4ProbeSets  <- setdiff(rownames(bX), allH3K4ProbeSets)
## brainH3K4ExclProbeSets <- unlist(arrayGenesToProbeSets[brainOnlyGenes])
## heartH3K4ExclProbeSets <- unlist(arrayGenesToProbeSets[heartOnlyGenes])
## 
## brainIdx <- barreraExpressionX$Tissue=="Brain"
## 
## brainExpression <- list(
##   H3K4me3BrainNoHeartNo  = bX[noH3K4ProbeSets, brainIdx],
##   H3K4me3BrainYes        = bX[allH3K4ProbeSets, brainIdx],
##   H3K4me3BrainYesHeartNo = bX[brainH3K4ExclProbeSets, brainIdx],
##   H3K4me3BrainNoHeartYes = bX[heartH3K4ExclProbeSets, brainIdx]
## )


###################################################
### code chunk number 31: H3K4me3VsExpression (eval = FALSE)
###################################################
## boxplot(brainExpression, col=c("#666666","#999966","#669966","#996666"), 
##         names=NA, varwidth=TRUE, log="y", 
##         ylab='gene expression level in brain cells')
## mtext(side=1, at=1:length(brainExpression), padj=1, font=2, 
##       text=rep("H3K4me3",4), line=1)
## mtext(side=1, at=c(0.2, 1:length(brainExpression)), padj=1, font=2, 
##       text=c("brain/heart","-/-","+/+","+/-","-/+"), line=2)


###################################################
### code chunk number 32: testExpressionGreater (eval = FALSE)
###################################################
## with(brainExpression, 
##      wilcox.test(H3K4me3BrainYesHeartNo, H3K4me3BrainNoHeartNo, 
##                  alternative="greater"))


###################################################
### code chunk number 33: sessionInfo (eval = FALSE)
###################################################
## toLatex(sessionInfo())


###################################################
### code chunk number 34: remarkTables (eval = FALSE)
###################################################
## # the purpose of the following chunks is merely to provide pretty
## # latex-formated output of the tables generated in the tutorial


###################################################
### code chunk number 35: printMm9Genes (eval = FALSE)
###################################################
## print(xtable(mm9genes[sample(nrow(mm9genes), 4), 
##    c("name", "chr", "strand", "start", "end", "symbol")],
##    label="tab-mm9genes",
##    caption="\\sl An excerpt of the object 'mm9genes'."),
##    type="latex", table.placement="h!t", size="scriptsize",
##    include.rownames=FALSE)


###################################################
### code chunk number 36: printChersXD (eval = FALSE)
###################################################
## print(xtable(head(chersXD[order(chersXD$maxLevel, decreasing=TRUE), 
##   c("chr", "start", "end", "cellType", "features", "maxLevel", "score")]),
##   label="tab-chersXD",
##   caption="\\sl The first six lines of object 'chersXD'."),
##   type="latex", table.placement="h!t", size="scriptsize",
##   include.rownames=FALSE)


###################################################
### code chunk number 37: printBrainRes (eval = FALSE)
###################################################
## ## for having prettier tables in the PDF, we use 'xtable' here:
## print(xtable(brainRes, label="tab-brainResGO", 
##    caption="\\sl GO terms that are significantly over-represented among genes showing H3K4me3 enrichment specifically in brain cells"),
##    type="latex", table.placement="h!t", size="scriptsize",
##    include.rownames=FALSE)


###################################################
### code chunk number 38: printHeartRes (eval = FALSE)
###################################################
## print(xtable(heartRes, label="tab-heartResGO",
##    caption="\\sl GO terms that are significantly over-represented among genes showing H3K4me3 enrichment specifically in heart cells"),
##    type="latex", table.placement="h!b", size="scriptsize",
##    include.rownames=FALSE)


