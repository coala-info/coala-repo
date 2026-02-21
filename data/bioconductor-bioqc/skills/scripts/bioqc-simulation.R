# Code example from 'bioqc-simulation' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
options(fig_caption=TRUE)
library(knitr)
opts_chunk$set(out.extra='style="display:block; margin: auto"', fig.align="center")

## ----lib, warning=FALSE, message=FALSE, results="hide"------------------------
library(BioQC)
library(hgu133plus2.db) ## to simulate an microarray expression dataset
library(lattice)
library(latticeExtra)
library(gridExtra)
library(gplots)

pdf.options(family="ArialMT", useDingbats=FALSE)

set.seed(1887)

## list human genes
humanGenes <- unique(na.omit(unlist(as.list(hgu133plus2SYMBOL))))

## read tissue-specific gene signatures
gmtFile <- system.file("extdata/exp.tissuemark.affy.roche.symbols.gmt",
                       package="BioQC")
gmt <- readGmt(gmtFile)
tissueInds <- sapply(gmt, function(x) match(x$genes, humanGenes))

## ----sensitivity_benchmark_fig, echo=FALSE, fig.width=8, fig.height=4.5, dev='png', fig.cap=sprintf("**Figure 1:** Sensitivity benchmark. Expression levels of genes in the ovary signature are dedicately sampled randomly from normal distributions with different mean values. Left panel: enrichment scores reported by *BioQC* for the ovary signature, plotted against the differences in mean expression values; Right panel: rank of ovary enrichment scores in all %s signatures plotted against the difference in mean expression values.", length(gmt))----

tissueInds <- sapply(gmt, function(x) match(x$genes, humanGenes))

randomMatrixButOneSignature <- function(rows=humanGenes, signatureGenes,
                                        amplitudes=seq(0, 3, by=0.5)) {
  nrow <- length(rows)
  ncol <- length(amplitudes)
  mat <- matrix(rnorm(nrow*ncol),
                nrow=nrow, byrow=FALSE)
  rownames(mat) <- rows
  sigInd <- na.omit(match(signatureGenes, humanGenes))
  
  colClass <- factor(amplitudes)
  
  for(colInd in unique(colClass)) {
    isCurrCol <- colInd==colClass
    replaceMatrix <- matrix(rnorm(length(sigInd)*sum(isCurrCol),
                                  mean=amplitudes[isCurrCol][1]),
                            nrow=length(sigInd), byrow=FALSE)
    mat[sigInd, isCurrCol] <-  replaceMatrix
    }
  return(mat)
}

selGeneSet <- "Ovary_NGS_RNASEQATLAS_0.6_3"
selSignature <- gmt[[selGeneSet]]$genes
senseAmplitudes <- rep(c(seq(0, 1, by=0.25),
                         seq(1.5, 3, 0.5)), each=10)
senseMat <- randomMatrixButOneSignature(rows=humanGenes,
                                        signatureGenes=selSignature,
                                        amplitudes=senseAmplitudes)
senseBioQC <- wmwTest(senseMat, tissueInds, valType="p.greater", simplify=TRUE)
senseRank <- apply(senseBioQC, 2, function(x) rank(x)[selGeneSet])
mydot <- function(x,y,abline=1,...) {panel.abline(h=abline, col="darkgray");panel.dotplot(x,y,...)}
senseBW <- bwplot(-log10(senseBioQC[selGeneSet,])~senseAmplitudes, horizontal=FALSE,
                  pch="|", do.out=FALSE,
                  par.settings=list(box.rectangle=list(col="black", fill="#ccddee")),
                  scales=list(tck=c(1,0), alternating=1L,
                              x=list(at=seq(along=unique(senseAmplitudes)), labels=unique(senseAmplitudes))),
                  ylab="Enrichment score", xlab="Mean expression difference")
senseDot <- dotplot(-log10(senseBioQC[selGeneSet,])~senseAmplitudes, horizontal=FALSE,
                    cex=0.9,
                    panel=mydot, abline=0,
                    scales=list(tck=c(1,0), alternating=1L,
                                x=list(at=seq(along=unique(senseAmplitudes)), labels=unique(senseAmplitudes))))

senseRankBW <- bwplot(senseRank~senseAmplitudes, horizontal=FALSE,
                      pch="|", do.out=FALSE, col="black", ylim=c(155, -5),
                      par.settings=list(box.rectangle=list(col="black", fill="#d9dddd")),
                      scales=list(tck=c(1,0), alternating=1L,
                                  y=list(at=c(1,50,100,150)),
                                  x=list(at=seq(along=unique(senseAmplitudes)), labels=unique(senseAmplitudes))),
                      ylab="Enrichment score rank", xlab="Mean expression difference")
senseRankDot <- dotplot(senseRank~senseAmplitudes, horizontal=FALSE,
                        panel=mydot, abline=1,
                        cex=0.9, col="black",ylim=c(155, -5),
                        scales=list(tck=c(1,0), alternating=1L,
                                    x=list(at=seq(along=unique(senseAmplitudes)), labels=unique(senseAmplitudes))))

sensePlot <- senseBW + senseDot
senseRankPlot <- senseRankBW + senseRankDot

grid.arrange(sensePlot, senseRankPlot, ncol=2)

## ----mixing_benchmark, echo=FALSE---------------------------------------------
dogfile <- system.file("extdata/GSE20113.rda", package = "BioQC")
# if(!file.exists(dogfile)) {
#   rawdog <- getGEO("GSE20113")[[1]]
#   filterFeatures <- function(eset) {
#     rawGeneSymbol <- fData(eset)[, "Gene Symbol"]
#     eset <- eset[!rawGeneSymbol %in% "" & !is.na(rawGeneSymbol),]
#     gs <- fData(eset)[, "Gene Symbol"]
#     
#     gsSplit <- split(1:nrow(eset), gs)
#     rmeans <- rowMeans(exprs(eset), na.rm=TRUE)
#     maxMean <- sapply(gsSplit, function(x) x[which.max(rmeans[x])])
#     maxMean <- unlist(maxMean)
#     res <- eset[maxMean,]
#     fData(res)$GeneSymbol <- fData(res)[, "Gene Symbol"]
#     return(res)
#     }
#   dog <- filterFeatures(rawdog)
#   dog$Label <- gsub("[0-9]$", "", as.character(dog$description))
#   save(dog, file=dogfile)
# } else {
# }
load(dogfile)
dogInds <- sapply(gmt, function(x) match(x$genes, fData(dog)$GeneSymbol))
dogBioQC <- wmwTest(dog, gmt, valType="p.greater", simplify=TRUE)
dogEnrich <- absLog10p(dogBioQC)
dogEnrich.best <- apply(dogEnrich,2, which.max)
dogEnrich.second <- apply(dogEnrich,2, function(x) which(rank(-x)==2))
shortLabel <- function(x) gsub("_NR_0\\.7_3|_NGS_RNASEQATLAS_0\\.6_3", "", x)
dogEnrich.bestLabels <- shortLabel(rownames(dogEnrich)[dogEnrich.best])
dogEnrich.secondLabels <- shortLabel(rownames(dogEnrich)[dogEnrich.second])
dogTable <- data.frame(Label=dog$Label,
                       BioQC.best=dogEnrich.bestLabels,
                       BioQC.second=dogEnrich.secondLabels,
                       row.names=sampleNames(dog))

## ----dog_table, echo=FALSE----------------------------------------------------
kable(dogTable, caption="Quality control of the mixing benchmark input data with *BioQC*. Four columns (f.l.t.r.): sample index; tissue         reported by the authors; the tissue signature with the highest enrichment score reported by *BioQC*; the tissue signature with the second-   highest enrichment score.")

## ----hj_mix, echo=FALSE-------------------------------------------------------
heart <- rowMeans(exprs(dog)[, dog$Label=="Heart"])
 jejunum <- rowMeans(exprs(dog)[, dog$Label=="Jejunum"])
 linearMix <- function(vec1, vec2, prop2=0) {
     stopifnot(prop2>=0 && prop2<=1)
     return(vec1*(1-prop2)+vec2*prop2)
 }
 mixProps <- seq(0, 1, 0.05)
 mixPropsLabels <- sprintf("%f%%", mixProps*100)
 hjMix <- sapply(mixProps, function(x) linearMix(jejunum, heart, x))
 hjMixBioQC <- wmwTest(hjMix, dogInds, valType="p.greater", simplify=TRUE)
 hjMixSub <- hjMixBioQC[c("Intestine_small_NR_0.7_3","Muscle_cardiac_NR_0.7_3"),]
 hjMixSubEnrich <- absLog10p(hjMixSub)
 hjMixBioQCrank <- apply(hjMixBioQC, 2, function(x) rank(x))
 hjMixSubRank <- hjMixBioQCrank[c("Intestine_small_NR_0.7_3","Muscle_cardiac_NR_0.7_3"),]
 colnames(hjMixSubEnrich) <- colnames(hjMixSubRank) <- mixPropsLabels

## ----hjMixVis, echo=FALSE, fig.width=8, fig.height=4, dev='png', fig.cap="**Figure 2:** Results of a mixing case study. Left panel: *BioQC* enrichment scores of small intestine and cardiac muscle varying upon different proportions of jejunum; Right panel: ranks of enrichment scores varying upon different proportions of jejunum."----
mixPropsShow <- seq(0, 1, 0.25)
mixPropsShowLabels <- sprintf("%d%%", mixPropsShow*100)
hjCols <- c("orange", "lightblue")
hjTissues <- c("Small intenstine","Cardiac muscle")
hjMixData <- data.frame(Tissue=rep(hjTissues, ncol(hjMixSubEnrich)),
                        Prop=rep(mixProps, each=nrow(hjMixSubEnrich)),
                        EnrichScore=as.vector(hjMixSubEnrich))
hjMixDataRank <- data.frame(Tissue=rep(hjTissues, ncol(hjMixSubEnrich)),
                            Prop=rep(mixProps, each=nrow(hjMixSubEnrich)),
                            EnrichScore=as.vector(hjMixSubRank))
hjMixXY <- xyplot(EnrichScore ~ Prop, group=Tissue, data=hjMixData, type="b",
                  xlab="Proportion of heart", ylab="Enrichment score",
                  par.settings=list(superpose.symbol=list(cex=1.25, pch=16, col=hjCols),
                                    superpose.line=list(col=hjCols)),
                  auto.key=list(columns=1L), abline=list(h=3, col="lightgray", lty=2, lwd=2),
                  scales=list(tck=c(1,0), alternating=1L,
                              x=list(at=mixPropsShow, labels=mixPropsShowLabels)))
hjMixRankXY <- xyplot(EnrichScore ~ Prop, group=Tissue, data=hjMixDataRank, type="b",
                      xlab="Proportion of heart", ylab="Enrichment score rank", ylim=c(155, 0.8),
                      auto.key=list(columns=1L),
                      par.settings=list(superpose.symbol=list(cex=1.25, pch=16, col=hjCols),
                                        superpose.line=list(col=hjCols)),
                      abline=list(h=log2(10), col="lightgray", lty=2, lwd=2),
                      scales=list(tck=c(1,0), alternating=1L,
                                  x=list(at=mixPropsShow, labels=mixPropsShowLabels),
                                  y=list(log=2, at=c(1,2,3,4,6,10,25,50,100,150))))

grid.arrange(hjMixXY, hjMixRankXY, ncol=2)

## ----dog_mix, echo=FALSE------------------------------------------------------
dogFilter <- dog[,-c(1,22,24)]
dogAvg <- tapply(1:ncol(dogFilter), dogFilter$Label, function(x) rowMeans(exprs(dogFilter)[,x]))
dogAvgMat <- do.call(cbind, dogAvg)
dogLabels <- c("Brain_Cortex_prefrontal_NR_0.7_3",
               "Muscle_cardiac_NR_0.7_3",
               "Intestine_small_NR_0.7_3",
               "Kidney_NR_0.7_3",
               "Liver_NR_0.7_3",
               "Lung_NR_0.7_3",
               "Lymphocyte_B_FOLL_NR_0.7_3",
               "Pancreas_Islets_NR_0.7_3",
               "Muscle_skeletal_NR_0.7_3",
               "Monocytes_NR_0.7_3")
dogComb <- subset(expand.grid(1:ncol(dogAvgMat),1:ncol(dogAvgMat)), Var2>Var1)
dogPairwise <- apply(dogComb, 1, function(x) {
                      vec1 <- dogAvgMat[,x[1]]
                      vec2 <- dogAvgMat[,x[2]]
                      label1 <- dogLabels[x[1]]
                      label2 <- dogLabels[x[2]]
                      mix <- sapply(mixProps, function(x) linearMix(vec1, vec2, x))
                      bioqc <- wmwTest(mix, dogInds, valType="p.greater", simplify=TRUE)
                      ranks <- apply(bioqc, 2, rank)
                      enrich <- absLog10p(bioqc)
                      colnames(enrich) <- colnames(ranks) <- mixPropsLabels
                      res <- list(EnrichScore=enrich[c(label1, label2),],
                                  Rank=ranks[c(label1, label2),])
                      return(res)
                   })
contamInd <- sapply(dogPairwise, function(x) {
                      successScore <- x$EnrichScore[2,]>=3
                      successRank <- x$Rank[2,]<=10
                      if(all(successScore) & all(successRank)) {
                        return(NA)
                        }
                      pmin(min(which(successScore)), min(which(successRank)))
                  })
revContamInd <- sapply(dogPairwise, function(x) {
                        successScore <- x$EnrichScore[1,]>=3
                        successRank <- x$Rank[1,]<=10
                        if(all(successScore) & all(successRank)) {
                          return(NA)
                          }
                        pmax(max(which(successScore)), max(which(successRank)))
                      })

fromMinProp <- mixProps[contamInd]
toMaxProp <- 1-mixProps[revContamInd]
comProp <- matrix(NA, nrow=ncol(dogAvgMat), ncol=ncol(dogAvgMat))
colnames(comProp) <- rownames(comProp) <- colnames(dogAvgMat)
for(i in 1:nrow(dogComb)) {
  comProp[dogComb[i,1], dogComb[i,2]] <- fromMinProp[i]
  comProp[dogComb[i,2], dogComb[i,1]] <- toMaxProp[i]
}


## ----dog_mix_vis, echo=FALSE, fig.width=8, fig.height=5, dev='png', fig.cap="**Figure 3:** Results of the pairwise mixing experiment. Each cell represents the minimal percentage of tissue of the column as contamination in the tissue of the row that can be detected by *BioQC*. No values are available for cells on the diagonal because self-mixing was excluded. Heart  and skeletal muscle are very close to each other and therefore their detection limit is not considered."----

dogMixCol <- colorRampPalette(c("#67A9CF", "black", "#EF8A62"))(100)
heatmap.2(x=comProp, Rowv=NULL,Colv=NULL, 
          col = dogMixCol, 
          scale="none",
          margins=c(9,9), # ("margin.Y", "margin.X")
          trace='none', 
          symkey=FALSE, 
          symbreaks=FALSE, 
          breaks=seq(0,1,0.01),
          dendrogram='none',
          density.info='none', 
          denscol="black",
          na.col="gray",
          offsetRow=0, offsetCol=0,
          keysize=1, key.title="Enrichment score", key.xlab="Detection limit", 
          xlab="Contamination tissue", ylab="Originating tissue",
          #( "bottom.margin", "left.margin", "top.margin", "right.margin" )
          key.par=list(mar=c(5,0,1,8)),
          # lmat -- added 2 lattice sections (5 and 6) for padding
          lmat=rbind(c(5, 4, 2), c(6, 1, 3)), lhei=c(1.6, 5), lwid=c(1, 4, 1))


## ----dog_mix_vis_example, echo=FALSE------------------------------------------
cell12 <- comProp[1,2]
cell21 <- comProp[2,1]
cell12Per <- as.integer(cell12*100)
cell21Per <- as.integer(cell21*100)

## ----table_detect_limit, echo=FALSE, tab.cap="Median lower detection limites of tissues as contamination sources."----
meanThr <- colMeans(comProp, na.rm=TRUE)
meanThrShow <- data.frame(Tissue=names(meanThr), MedianDetectionLimit=sprintf("%1.2f%%", meanThr*100))
kable(meanThrShow, caption="Median lower detection limites of tissues as contamination sources.")

## ----brain_low_exp, echo=FALSE, fig.width=6, fig.height=3, dev='png', fig.cap="**Figure 4:** Average expression of tissue-preferential genes in respective tissues. For each tissue (*e.g.* brain), we calculate the median ratio of gene expression level of specific genes over the median expression level of background genes. The value reflects the specificity of tissue-specific genes in respective tissues. Likely due to the sampling of different brain regions, the score of brain ranks the lowest."----
dogAvgGs <- c("Brain_Cortex_prefrontal_NR_0.7_3",
              "Muscle_cardiac_NR_0.7_3",
              "Intestine_small_NR_0.7_3",
              "Kidney_NR_0.7_3",
              "Liver_NR_0.7_3",
              "Lung_NR_0.7_3",
              "Lymphocyte_B_FOLL_NR_0.7_3",
              "Pancreas_Islets_NR_0.7_3",
              "Muscle_skeletal_NR_0.7_3",
              "Monocytes_NR_0.7_3")
dogAvgGsGenes <- sapply(gmt[dogAvgGs], function(x) x$genes)
dogAvgGsGeneInds <- lapply(dogAvgGsGenes, function(x) {
  inds <- match(x, fData(dog)$GeneSymbol)
  inds[!is.na(inds)]
  })

## boxplot of tissue-specific genes
dogAvgGsRel <- sapply(seq(along=dogAvgGsGeneInds), function(i) {
  ind <- dogAvgGsGeneInds[[i]]
  bgInd <- setdiff(1:nrow(dog), ind)
  apply(dogAvgMat, 2, function(x) median(x[ind]/median(x[bgInd])))
  })
colnames(dogAvgGsRel) <- colnames(dogAvgMat)
##heatmap.2(log2(dogAvgGsRel),zlim=c(-1,1),
##          cellnote=round(dogAvgGsRel,1),
##          Rowv=NA, Colv=NA, dendrogram="none",  col=greenred,
##          lwid=c(1,3), lhei=c(1,3),
##          key.title="Enrichment score", key.xlab="Detection limit",
##          xlab="Tissue signature", ylab="Tissue profiles",
##          key.par=list(cex.lab=1.25, mar=c(4,2,1,0), mgp=c(1.5,0.5,0)),
##          cexRow=1.25, margins=c(8,8), trace="none", offsetRow=0, offsetCol=0,
##          density.info="none",na.col="gray", breaks=seq(-1,1,0.01), symbreaks=TRUE)

op <- par(mar=c(8,4,1,1))
barplot(sort(diag(dogAvgGsRel)), las=3, ylab="Median ratio of expression (signature/background)")
abline(h=1.25)
## op <- par(mar=c(8,4,1,1))
## dogAvgES <- absLog10p(diag(wmwTest(dogAvgMat, dogAvgGsGeneInds, alternative="greater")))
## names(dogAvgES) <- colnames(dogAvgMat)
## barplot(sort(dogAvgES, decreasing=TRUE), las=3, ylab="ES in respective average tissue profile")
## par(op)
## plot(meanThr, dogAvgES, type="n", xlab="Average lower detection limit", ylab="BioQC ES score")
## text(meanThr, dogAvgES, colnames(dogAvgMat))


## ----pca, echo=FALSE, fig.width=6, fig.height=6, dev='png', fig.cap="Sample separation revealed by principal component analysis (PCA) of the dog transcriptome dataset."----
par(mar=c(4,4,2,2))
dogEXP <- exprs(dog); colnames(dogEXP) <- dog$Label
dogPCA <- prcomp(t(dogEXP))
expVar <- function(pcaRes, n) {vars <- pcaRes$sdev^2; (vars/sum(vars))[n]}
biplot(dogPCA, col=c("#335555dd", "transparent"), cex=1.15,
       xlab=sprintf("Principal component 1 (%1.2f%%)", expVar(dogPCA,1)*100),
       ylab=sprintf("Principal component 1 (%1.2f%%)", expVar(dogPCA,2)*100))


## ----session_info-------------------------------------------------------------
sessionInfo()

