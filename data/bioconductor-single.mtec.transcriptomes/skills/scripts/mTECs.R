# Code example from 'mTECs' vignette. See references/ for full tutorial.

## ----knitr, echo=FALSE, results="hide"----------------------------------------
library("knitr")

knit_hooks$set(fig.bg = function(before, options, envir) {
  if (before) par(bg = options$fig.bg)
})

opts_chunk$set(tidy=FALSE,dev="png",fig.show="hide",
               fig.width=4,fig.height=4.5,
               message=FALSE, fig.bg='white')

## ----style, eval=TRUE, echo=FALSE, results="asis"--------------------------
BiocStyle::latex()

## ----loadLibraries, echo=FALSE---------------------------------------------
library("DESeq2")
library(GenomicRanges)
library(GenomicFeatures)
library(genefilter)
library(statmod)
library(gdata)
library(RColorBrewer)
library(genefilter)
library(ggplot2)
library(gplots)
library(cluster)
library(clue)
library(grid)
library(gridExtra)
library(Single.mTEC.Transcriptomes)
library(BiocParallel)

## ----Figure_plot1_MappingStats, echo=TRUE, fig.width=8, fig.height=12, dev="pdf"----
  
data("percentsGG")
ggplot( percentsGG, aes(index, percent, fill=type) ) + 
    geom_bar(stat="identity") + facet_grid( batch ~ . ) +
   theme(axis.title = element_text(size = 18), 
         axis.text = element_text(size=12), 
         legend.text = element_text(size = 12), 
         axis.text.x=element_text(angle=90), 
         legend.position="top")


## ----loadingDxd------------------------------------------------------------
data("mTECdxd")
numCores=1

## ----variableFunction, echo=FALSE, eval=TRUE-------------------------------

testForVar <- function( countTable, FDR=0.1, minVar=.5, main=""){
  normalizedCountTable <- t( t(countTable)/estimateSizeFactorsForMatrix(countTable) )
  splitCounts <- split(as.data.frame(countTable), grepl("ERCC", rownames(countTable)))
  mouseCounts <- splitCounts[["FALSE"]]
  spikeCounts <- splitCounts[["TRUE"]]
  mouseNF <- estimateSizeFactorsForMatrix( mouseCounts )
  spikeNF <- estimateSizeFactorsForMatrix( spikeCounts )
  mouseCounts <-  t( t( mouseCounts ) / mouseNF )
  spikeCounts <- t( t( spikeCounts ) / spikeNF )        
  meansSpike <- rowMeans( spikeCounts )
  varsSpike <- rowVars( spikeCounts )
  cv2Spike <- varsSpike / meansSpike^2
  minMeanForFit <- unname( quantile( meansSpike[ which( cv2Spike > .3 ) ], .9 ) )
  useForFit <- meansSpike >= minMeanForFit
  fit <- glmgam.fit( cbind( a0 = 1, a1tilde = 1/meansSpike[useForFit] ), cv2Spike[useForFit] )
  xi <- mean( 1 / spikeNF )
  a0 <- unname( fit$coefficients["a0"] )
  a1 <- unname( fit$coefficients["a1tilde"] - xi )  
  meansMouse <- rowMeans( mouseCounts )
  varsMouse <- rowVars( mouseCounts )
  cv2Mouse <- varsMouse / meansMouse^2
  psia1theta <- mean( 1 / mouseNF ) + a1 * mean( spikeNF / mouseNF )
  minBiolDisp <- minVar^2
  m <- ncol( mouseCounts )
  cv2th <- a0 + minBiolDisp + a0 * minBiolDisp
  testDenom <- ( meansMouse * psia1theta + meansMouse^2 * cv2th ) / ( 1 + cv2th/m )
  p <- 1 - pchisq( varsMouse * (m-1) / testDenom, m-1 )
  padj <- p.adjust(p, method="BH")
  sig <-  padj < FDR
  deGenes <- names( which( sig ) )
  suppressWarnings( plot( NULL, xaxt="n", yaxt="n", bty = 'l',
  log="xy", xlim = c( 1e-2, 3e5 ), ylim = c( .005, ncol(mouseCounts) ),
  xlab = "Average normalized read count", ylab = "Squared coefficient of variation (SCV)", cex.lab=1.3, main=main))
  axis( 1, 10^(-1:5), c( "0.1", "1", "10", "100", "1000",
  expression(10^4), expression(10^5) ), cex.axis=1.25)
  axis( 2, 10^(-2:2), c( "0.01", "0.1", "1", "10", "100"), las=2, cex.axis=1.25)
#  abline( h=10^(-2:1), v=10^(-1:5), col="#D0D0D0" )
  points( meansMouse, cv2Mouse, pch=20, cex=.2, col = ifelse( padj < .1, "#b2182b", "#878787" ) )
  points( meansSpike, cv2Spike, pch=20, cex=.8, col="black" )
    xg <- 10^seq( -2, 6, length.out=1000 )
    lines( xg, (xi+a1)/xg + a0, col="black", lwd=3)#, lty="dashed")
    lines( xg, psia1theta/xg + a0 + minBiolDisp, col="#67001f", lwd=3 )  
  return( deGenes )
}

## ----Figure_1C_variableNoMarker, dev="png", fig.height=4.4, fig.width=4.8, dpi=300, dev.args = list(bg = 'white')----

deGenesNone = testForVar( 
    countTable=counts(dxd)[,colData(dxd)$SurfaceMarker == "None"] )
#save(deGenesNone, file="../data/deGenesNone.RData")
length(deGenesNone)

nrow(dxd)
ncol(dxd)
table( grepl("ERCC", rownames(dxd)) )


## ----testForVarNames-------------------------------------------------------
cat( sprintf("The number of genes with coefficient of variation larger 
than 50 percent at FDR of 0.1 is: %s\n", length(deGenesNone)) )

## ----Figure_a2_variableAll, dev="png", fig.height=4.4, fig.width=4.8, dpi=300, echo=FALSE, dev.args = list(bg = 'white'), eval=FALSE, echo=FALSE----
# deGenes = testForVar( countTable=counts(dxd) )

## ----Figure_a3_variableSubGroups, dev="png", fig.height=4.4, fig.width=9, dpi=300, dev.args = list(bg = 'white'), eval=FALSE, echo=FALSE----
# par(mfrow=c(1, 2))
# deGenesCeacam1 <- testForVar( counts(dxd)[,colData(dxd)$SurfaceMarker == "Ceacam1"],
#                              main=expression(Ceacam^+ cells~FACS) )
# 
# deGenesTspan8 <-  testForVar( counts(dxd)[,colData(dxd)$SurfaceMarker == "Tspan8"],
#                              main=expression(Tspan^+ cells~FACS))

## ----echo=FALSE, eval=FALSE------------------------------------------------
# length(deGenesCeacam1)
# length(deGenesTspan8)

## ----Figure_1A_trasvsgenes, dev="png", fig.height=4, fig.width=4, units="in", dpi=300,  dev.args = list(bg = 'white')----

data("tras")
tras <- unique( tras$`gene.ids` )
data("geneNames")
data("biotypes")
proteinCoding <- names( which( biotype == "protein_coding" ) )
isTRA <- rownames( dxd ) %in% tras & rownames(dxd) %in% proteinCoding

isProteinCoding <- rownames(dxd) %in% proteinCoding
sum(isProteinCoding)
par(mar=c(5, 5, 1, 1))
unselectedCells <- colData(dxd)$SurfaceMarker=="None"
sum(unselectedCells)

plot( colSums(counts(dxd)[isProteinCoding,unselectedCells] > 0),
     colSums(counts(dxd)[isTRA,unselectedCells] > 0),
     pch=19, cex=.7, col="#00000080",
#     col=lscol,
     cex.lab=1.3, cex.axis=1.3,
     xlab="Number of genes detected",
     ylab="Number of TRA genes detected")


## ----Figure_Supp1_percentageTRAs, dev="png", fig.height=3.5, fig.width=4, dpi=300,  dev.args = list(bg = 'white')----

par(mar=c(5, 5, 1, 1))
hist( colSums(counts(dxd)[isTRA,unselectedCells] > 0)/
     colSums(counts(dxd)[isProteinCoding,unselectedCells] > 0), 
        col="white", cex.axis=1.4, 
        xlab="", cex.lab=1.4,
        pch=19, cex=.5, main="", xlim=c(0, .5))
title(xlab="Fraction of detected genes\n classified as TRA", 
      line=4, cex.lab=1.4)


## ----expressingTRANumbers--------------------------------------------------

rng <- range(  colSums(counts(dxd)[isTRA,unselectedCells] > 0)/
      colSums(counts(dxd)[isProteinCoding,unselectedCells] > 0) )
rng <- round(rng*100, 2)

summary(rng)
sd(rng)

cat(sprintf("The proportion of TRAs expressed per cell with respect to the
number of protein coding genes ranges from %s to %s percent\n", 
            rng[1], rng[2] ) )


## ----Figure_1B_saturation, dev="png", fig.height=4, fig.width=4, dpi=300,  dev.args = list(bg = 'white')----

detectedTRAs <- 0+( counts(dxd)[isTRA,unselectedCells] > 0 )
cellOrder <- order( colSums(counts(dxd)[isProteinCoding,unselectedCells] > 0) )
cumFreqTRAs <- sapply( seq_along(cellOrder), function(x){
    sum(!rowSums( detectedTRAs[,cellOrder[seq_len(x)], drop=FALSE] ) == 0)
})

detectedGenes <- 0+( counts(dxd)[isProteinCoding,unselectedCells] > 0 )
cumFreqGenes <- sapply( seq_along(cellOrder), function(x){
    sum(!rowSums( detectedGenes[,cellOrder[seq_len(x)], drop=FALSE] ) == 0)
})

par(mar=c(5, 6, 2, 1))
plot(cumFreqTRAs/nrow(detectedTRAs), type="l", lwd=4, 
     col="#1b7837", cex.axis=1.4, cex.lab=1.4, 
     ylab="Cumulative fraction\nof genes detected", ylim=c(0, 1),
     xlab="Number of mature mTECs")
lines(cumFreqGenes/nrow(detectedGenes), type="l", 
      lwd=4, col="#762a83")
legend(x=10, y=.3, 
       legend=c("TRA-encoding genes", "Protein coding genes"), 
       fill=c("#1b7837", "#762a83"),
       cex=1.2, bty="n")


## ----tranumbers------------------------------------------------------------
cat(sprintf("Total fraction of TRA genes detected: %s", 
            round( max(cumFreqTRAs/nrow(detectedTRAs)),2) ) )
cat(sprintf("Total number of TRA genes: %s", 
            nrow(detectedTRAs) ) )
cat(sprintf("Total fraction of protein coding genes detected: %s\n", 
            round( max(cumFreqGenes/nrow(detectedGenes)), 2) ) )
cat(sprintf("Total number of detected protein coding genes: %s", 
            max(cumFreqGenes)))
cat(sprintf("Total number of protein coding genes: %s", 
            nrow(detectedGenes) ) )


## ----Figure_Supp2_traenrichment, dev="png", fig.height=4, fig.width=4, dpi=300,dev.args=list(bg = 'white')----

background <- rownames(dxd)[!rownames(dxd) %in% deGenesNone]
background <- names( which( rowSums( counts(dxd)[background,] > 0 ) != 0 ) )
background <- intersect(background, proteinCoding)
foreground <- intersect(deGenesNone, proteinCoding )
allTras <- intersect( tras, proteinCoding )
  
mat <- rbind(
    `variable genes`=table( !foreground %in% allTras ),
    `background`=table( !background %in% allTras ) )

colnames( mat ) <- c("is TRA", "is not TRA")

mat[,1]/rowSums(mat)

par(mar=c(4, 6, 1, 1))
barplot( 
    mat[,1]/rowSums(mat), 
    names.arg=c("variable", "not-variable"), 
    las=1, col="black",
    cex.axis=1.2, cex.lab=1.3, cex=1.3,
    ylab="Fraction of\nTRA-encoding genes")


## ----fishertra-------------------------------------------------------------

fisher.test(mat)


## ----prepareFANTOM---------------------------------------------------------

data("fantom")
data("aireDependentSansom")
aireDependent <- aireDependentSansom

countTable <- counts(dxd)[,colData(dxd)$SurfaceMarker == "None"]
meansFANTOM <- sapply( split(seq_len(ncol(dxdFANTOM)), 
                  colData( dxdFANTOM )$tissue), function(x){
                  rowMeans( 
                    counts(dxdFANTOM, normalized=TRUE)[,x, drop=FALSE] )
})
meansFANTOM <- sapply(
  split( seq_len( 
      nrow(meansFANTOM) ), 
        sapply( strsplit( rownames( meansFANTOM ), "," ), "[[", 1 )),
    function(x){
      colMeans( meansFANTOM[x,,drop=FALSE] )
    })

meansFANTOM <- t( meansFANTOM )

cat( sprintf("The total number of tissues used from the FANTOM dataset was:%s\n",
             length( unique( colnames(meansFANTOM) ) ) ) )

matchedIndexes <- match( geneNames, rownames(meansFANTOM))
stopifnot( 
    rownames(meansFANTOM)[matchedIndexes[!is.na(matchedIndexes)]] == 
    geneNames[!is.na(matchedIndexes)] )
rownames(meansFANTOM)[matchedIndexes[!is.na(matchedIndexes)]] <- 
    names( geneNames[!is.na(matchedIndexes)] )
meansFANTOM <- meansFANTOM[grep("ENS", rownames(meansFANTOM)),]

numbersOfTissues <- rowSums( meansFANTOM > 5 )
numbersOfTissues <- numbersOfTissues[names(numbersOfTissues) %in% deGenesNone]
aireDependent <- aireDependent[aireDependent %in% deGenesNone]
numbersOfCells <- rowSums( countTable[names(numbersOfTissues),] > 0 )

table( numbersOfTissues < 10 )
FifteenPercent <- round( sum(colData(dxd)$SurfaceMarker == "None") * .15 )

tableResults <- table( lessThan10Cells=numbersOfCells < FifteenPercent, 
      isAireDependent=names(numbersOfTissues) %in% aireDependent, 
      isLessThan10Tissues=numbersOfTissues < 10)

cat( sprintf("Total number of genes detected in less than 10 tissues: %s\n", 
             sum( tableResults[,,"TRUE"]) ) )
cat(sprintf("From which %s are Aire dependent and %s are Aire-independent\n",
            colSums( tableResults[,,"TRUE"] )["TRUE"], 
            colSums( tableResults[,,"TRUE"] )["FALSE"] ) )


tableResults["TRUE",,"TRUE"]

percentsLessThan15 <- 
    round( tableResults["TRUE",,"TRUE"]/colSums( tableResults[,,"TRUE"] ), 2)


cat(sprintf("And %s and %s were detected in 
less than 15 percent of the cells, respectively\n", 
            percentsLessThan15[2], percentsLessThan15[1]))


## ----prepareFigures, warnings=FALSE----------------------------------------

df <- data.frame(
  numberOfCells=numbersOfCells,
  numberOfTissues=numbersOfTissues,
  aireDependent=ifelse( names(numbersOfCells) %in% aireDependent, 
      "Aire-dependent genes", "Aire-independent genes"),
  TRAs=ifelse( names(numbersOfCells) %in% tras, "TRA", "not TRA" ) )
  
histogramList <- lapply(c("Aire-independent genes", "Aire-dependent genes"), 
                        function(x){
    dfAD <- df[df$aireDependent == x,]
    m <- ggplot( dfAD, aes( x=numberOfCells ) )
    m <- m + geom_histogram(colour = "black", fill = "white", binwidth = 5)
    m <- m + facet_grid( ~ aireDependent )
    m <- m + xlab("Mature mTECs with\ngene detection") + ylab("Number of genes") +
        scale_x_continuous(limits=c(0, ncol(countTable)+0), expand=c(.01,0) ) + 
            ylim(0, 600)
    m <- m + theme(axis.text.x = element_text(size=14, colour="black"), 
        panel.border = element_rect(colour = "white", fill=NA),
        panel.background = element_rect(colour="white", fill="white"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.line=element_line(colour="black"),
        axis.text.y = element_text(size=14, colour="black"),
        axis.title=element_text(size=14, vjust=.2),
        strip.text.x = element_text(size = 14), 
        axis.ticks=element_line(colour="black"),
        strip.background = element_rect(colour="white", fill="white"))
    m
})
names(histogramList) <- c("Aire-independent genes", "Aire-dependent genes")


scatterList <- lapply(c("Aire-independent genes", "Aire-dependent genes"), 
                      function(x){
    dfAD <- df[df$aireDependent == x,]
        m2 <- ggplot(dfAD, aes(x=numberOfCells,y=numberOfTissues)) +
        geom_point(colour="#15151540", size=1.2) +
        facet_grid( ~ aireDependent ) +
        xlab("Mature mTECs with\n gene detection") +
        ylab("Tissues with gene detection") +
        geom_hline(yintercept=10, size=1.1, colour="darkred") + #linetype="dashed") +
        scale_y_continuous(limits=c(0, max(df$numberOfTissues)+3), 
                        expand=c(0,0) ) +
        scale_x_continuous(limits=c(0, ncol(countTable)+0), 
                        expand=c(0.01,0) )
        m2 <- m2 + theme(
            strip.background = element_rect(colour="white", fill="white"), 
                      strip.text.x =element_text(size = 14),
        panel.border = element_rect(colour = "white", fill=NA),
        axis.line=element_line(colour="black"),
        axis.text = element_text(size=14, colour="black"),
        axis.title=element_text(size=14, vjust=.2),
        legend.position="none",
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank())
   m2})
names(scatterList) <- c("Aire-independent genes", "Aire-dependent genes")


## ----Figure_1D1_histogramAire, dev="png", fig.height=3.2, fig.width=3.7, dpi=600, dev.args = list(bg = 'white')----
print( histogramList[["Aire-independent genes"]])

## ----Figure_1D2_histogramAire, dev="png", fig.height=3.2, fig.width=3.2, dpi=600, dev.args = list(bg = 'white')----
print( histogramList[["Aire-dependent genes"]])

## ----Figure_1D3_histogramAire, dev="png", fig.height=3.2, fig.width=3.2, dpi=600, dev.args = list(bg = 'white')----

print( scatterList[["Aire-dependent genes"]])


## ----Figure_1D4_histogramAire, dev="png", fig.height=3.2, fig.width=3.2, dpi=600, dev.args = list(bg = 'white')----

print( scatterList[["Aire-independent genes"]])


## ----permuts, eval=FALSE---------------------------------------------------
# 
# library(clue)
# library(cluster)
# data("scLVM_output")
# 
# defineGeneConsensusClustering <-
#     function( expressionMatrix=Ycorr,
#              selectGenes="", nClusters=12, B=40,
#              prob=0.8, nCores=20, ...){
#      mat <- expressionMatrix[rownames(expressionMatrix) %in% selectGenes,]
#      ce <- cl_ensemble( list=bplapply(  seq_len(B), function(dummy){
#         subSamples <- sample(colnames(mat), round( ncol(mat) * prob ) )
#         pamSub <- pam( mat[,subSamples], nClusters )
#         pred <- cl_predict( pamSub, mat[,subSamples], "memberships" )
#         as.cl_partition(pred)
#      }, BPPARAM=MulticoreParam(nCores) ))
#      cons <- cl_consensus( ce )
#      ag <- sapply( ce, cl_agreement, y=cons )
#      return(list(consensus=cons, aggrementProbabilities=ag))
#  }
# 
# nomarkerCellsClustering <-
#     defineGeneConsensusClustering(
#         expressionMatrix=Ycorr[,colData(dxd)$SurfaceMarker == "None"],
#         selectGenes=intersect( deGenesNone, aireDependent ),
#         nClusters=12, B=1000,
#         prob=0.8, nCores=10 )
# 
# save( nomarkerCellsClustering,
#      file="../data/nomarkerCellsClustering.RData")
# 

## ----echo=FALSE------------------------------------------------------------
### definition of heatmap3 function
heatmap.3 <- function(x,
                      Rowv = TRUE, Colv = if (symm) "Rowv" else TRUE,
                      distfun = dist,
                      hclustfun = hclust,
                      dendrogram = c("both","row", "column", "none"),
                      symm = FALSE,
                      scale = c("none","row", "column"),
                      na.rm = TRUE,
                      revC = identical(Colv,"Rowv"),
                      add.expr,
                      breaks,
                      symbreaks = max(x < 0, na.rm = TRUE) || scale != "none",
                      col = "heat.colors",
                      colsep,
                      rowsep,
                      sepcolor = "white",
                      sepwidth = c(0.05, 0.05),
                      cellnote,
                      notecex = 1,
                      notecol = "cyan",
                      na.color = par("bg"),
                      trace = c("none", "column","row", "both"),
                      tracecol = "cyan",
                      hline = median(breaks),
                      vline = median(breaks),
                      linecol = tracecol,
                      margins = c(5,5),
                      ColSideColors,
                      RowSideColors,
                      side.height.fraction=0.3,
                      cexRow = 0.2 + 1/log10(nr),
                      cexCol = 0.2 + 1/log10(nc),
                      labRow = NULL,
                      labCol = NULL,
                      key = TRUE,
                      keysize = 1.5,
                      density.info = c("none", "histogram", "density"),
                      denscol = tracecol,
                      symkey = max(x < 0, na.rm = TRUE) || symbreaks,
                      densadj = 0.25,
                      main = NULL,
                      xlab = NULL,
                      ylab = NULL,
                      lmat = NULL,
                      lhei = NULL,
                      lwid = NULL,
                      NumColSideColors = 1,
                      NumRowSideColors = 1,
                      KeyValueName="Value",...){

    invalid <- function (x) {
      if (missing(x) || is.null(x) || length(x) == 0)
          return(TRUE)
      if (is.list(x))
          return(all(sapply(x, invalid)))
      else if (is.vector(x))
          return(all(is.na(x)))
      else return(FALSE)
    }

    x <- as.matrix(x)
    scale01 <- function(x, low = min(x), high = max(x)) {
        x <- (x - low)/(high - low)
        x
    }
    retval <- list()
    scale <- if (symm && missing(scale))
        "none"
    else match.arg(scale)
    dendrogram <- match.arg(dendrogram)
    trace <- match.arg(trace)
    density.info <- match.arg(density.info)
    if (length(col) == 1 && is.character(col))
        col <- get(col, mode = "function")
    if (!missing(breaks) && (scale != "none"))
        warning("Using scale=\"row\" or scale=\"column\" when breaks are",
            "specified can produce unpredictable results.", "Please consider using only one or the other.")
    if (is.null(Rowv) || is.na(Rowv))
        Rowv <- FALSE
    if (is.null(Colv) || is.na(Colv))
        Colv <- FALSE
    else if (Colv == "Rowv" && !isTRUE(Rowv))
        Colv <- FALSE
    if (length(di <- dim(x)) != 2 || !is.numeric(x))
        stop("`x' must be a numeric matrix")
    nr <- di[1]
    nc <- di[2]
    if (nr <= 1 || nc <= 1)
        stop("`x' must have at least 2 rows and 2 columns")
    if (!is.numeric(margins) || length(margins) != 2)
        stop("`margins' must be a numeric vector of length 2")
    if (missing(cellnote))
        cellnote <- matrix("", ncol = ncol(x), nrow = nrow(x))
    if (!inherits(Rowv, "dendrogram")) {
        if (((!isTRUE(Rowv)) || (is.null(Rowv))) && (dendrogram %in%
            c("both", "row"))) {
            if (is.logical(Colv) && (Colv))
                dendrogram <- "column"
            else dedrogram <- "none"
            warning("Discrepancy: Rowv is FALSE, while dendrogram is `",
                dendrogram, "'. Omitting row dendogram.")
        }
    }
    if (!inherits(Colv, "dendrogram")) {
        if (((!isTRUE(Colv)) || (is.null(Colv))) && (dendrogram %in%
            c("both", "column"))) {
            if (is.logical(Rowv) && (Rowv))
                dendrogram <- "row"
            else dendrogram <- "none"
            warning("Discrepancy: Colv is FALSE, while dendrogram is `",
                dendrogram, "'. Omitting column dendogram.")
        }
    }
    if (inherits(Rowv, "dendrogram")) {
        ddr <- Rowv
        rowInd <- order.dendrogram(ddr)
    }
    else if (is.integer(Rowv)) {
        hcr <- hclustfun(distfun(x))
        ddr <- as.dendrogram(hcr)
        ddr <- reorder(ddr, Rowv)
        rowInd <- order.dendrogram(ddr)
        if (nr != length(rowInd))
            stop("row dendrogram ordering gave index of wrong length")
    }
    else if (isTRUE(Rowv)) {
        Rowv <- rowMeans(x, na.rm = na.rm)
        hcr <- hclustfun(distfun(x))
        ddr <- as.dendrogram(hcr)
        ddr <- reorder(ddr, Rowv)
        rowInd <- order.dendrogram(ddr)
        if (nr != length(rowInd))
            stop("row dendrogram ordering gave index of wrong length")
    }
    else {
        rowInd <- nr:1
    }
    if (inherits(Colv, "dendrogram")) {
        ddc <- Colv
        colInd <- order.dendrogram(ddc)
    }
    else if (identical(Colv, "Rowv")) {
        if (nr != nc)
            stop("Colv = \"Rowv\" but nrow(x) != ncol(x)")
        if (exists("ddr")) {
            ddc <- ddr
            colInd <- order.dendrogram(ddc)
        }
        else colInd <- rowInd
    }
    else if (is.integer(Colv)) {
        hcc <- hclustfun(distfun(if (symm)
            x
        else t(x)))
        ddc <- as.dendrogram(hcc)
        ddc <- reorder(ddc, Colv)
        colInd <- order.dendrogram(ddc)
        if (nc != length(colInd))
            stop("column dendrogram ordering gave index of wrong length")
    }
    else if (isTRUE(Colv)) {
        Colv <- colMeans(x, na.rm = na.rm)
        hcc <- hclustfun(distfun(if (symm)
            x
        else t(x)))
        ddc <- as.dendrogram(hcc)
        ddc <- reorder(ddc, Colv)
        colInd <- order.dendrogram(ddc)
        if (nc != length(colInd))
            stop("column dendrogram ordering gave index of wrong length")
    }
    else {
        colInd <- 1:nc
    }
    retval$rowInd <- rowInd
    retval$colInd <- colInd
    retval$call <- match.call()
    x <- x[rowInd, colInd]
    x.unscaled <- x
    cellnote <- cellnote[rowInd, colInd]
    if (is.null(labRow))
        labRow <- if (is.null(rownames(x)))
            (1:nr)[rowInd]
        else rownames(x)
    else labRow <- labRow[rowInd]
    if (is.null(labCol))
        labCol <- if (is.null(colnames(x)))
            (1:nc)[colInd]
        else colnames(x)
    else labCol <- labCol[colInd]
    if (scale == "row") {
        retval$rowMeans <- rm <- rowMeans(x, na.rm = na.rm)
        x <- sweep(x, 1, rm)
        retval$rowSDs <- sx <- apply(x, 1, sd, na.rm = na.rm)
        x <- sweep(x, 1, sx, "/")
    }
    else if (scale == "column") {
        retval$colMeans <- rm <- colMeans(x, na.rm = na.rm)
        x <- sweep(x, 2, rm)
        retval$colSDs <- sx <- apply(x, 2, sd, na.rm = na.rm)
        x <- sweep(x, 2, sx, "/")
    }
    if (missing(breaks) || is.null(breaks) || length(breaks) < 1) {
        if (missing(col) || is.function(col))
            breaks <- 16
        else breaks <- length(col) + 1
    }
    if (length(breaks) == 1) {
        if (!symbreaks)
            breaks <- seq(min(x, na.rm = na.rm), max(x, na.rm = na.rm),
                length = breaks)
        else {
            extreme <- max(abs(x), na.rm = TRUE)
            breaks <- seq(-extreme, extreme, length = breaks)
        }
    }
    nbr <- length(breaks)
    ncol <- length(breaks) - 1
    if (class(col) == "function")
        col <- col(ncol)
    min.breaks <- min(breaks)
    max.breaks <- max(breaks)
    x[x < min.breaks] <- min.breaks
    x[x > max.breaks] <- max.breaks
    if (missing(lhei) || is.null(lhei))
        lhei <- c(keysize, 4)
    if (missing(lwid) || is.null(lwid))
        lwid <- c(keysize, 4)
    if (missing(lmat) || is.null(lmat)) {
        lmat <- rbind(4:3, 2:1)

        if (!( missing(ColSideColors) | is.null(ColSideColors) )) {
           #if (!is.matrix(ColSideColors))
           #stop("'ColSideColors' must be a matrix")
            if (!is.character(ColSideColors) || nrow(ColSideColors) != nc)
                stop("'ColSideColors' must be a matrix of nrow(x) rows")
            lmat <- rbind(lmat[1, ] + 1, c(NA, 1), lmat[2, ] + 1)
            #lhei <- c(lhei[1], 0.2, lhei[2])
             lhei=c(lhei[1], side.height.fraction*NumColSideColors, lhei[2])
        }

        if (!missing(RowSideColors)) {
            #if (!is.matrix(RowSideColors))
            #stop("'RowSideColors' must be a matrix")
            if (!is.character(RowSideColors) || ncol(RowSideColors) != nr)
                stop("'RowSideColors' must be a matrix of ncol(x) columns")
            lmat <- cbind(lmat[, 1] + 1, c(rep(NA, nrow(lmat) - 1), 1), lmat[,2] + 1)
            #lwid <- c(lwid[1], 0.2, lwid[2])
            lwid <- c(lwid[1], side.height.fraction*NumRowSideColors, lwid[2])
        }
        lmat[is.na(lmat)] <- 0
    }

    if (length(lhei) != nrow(lmat))
        stop("lhei must have length = nrow(lmat) = ", nrow(lmat))
    if (length(lwid) != ncol(lmat))
        stop("lwid must have length = ncol(lmat) =", ncol(lmat))
    op <- par(no.readonly = TRUE)
    on.exit(par(op))

    layout(lmat, widths = lwid, heights = lhei, respect = FALSE)

    if (!missing(RowSideColors)) {
        if (!is.matrix(RowSideColors)){
                par(mar = c(margins[1], 0, 0, 0.5))
                image(rbind(1:nr), col = RowSideColors[rowInd], axes = FALSE )
        } else {
            par(mar = c(margins[1], 0, 0, 0.5))
            rsc = t(RowSideColors[,rowInd, drop=FALSE])
            rsc.colors = matrix()
            rsc.names = names(table(rsc))
            rsc.i = 1
            for (rsc.name in rsc.names) {
                rsc.colors[rsc.i] = rsc.name
                rsc[rsc == rsc.name] = rsc.i
                rsc.i = rsc.i + 1
            }
            rsc = matrix(as.numeric(rsc), nrow = dim(rsc)[1])
            image(t(rsc), col = as.vector(rsc.colors), axes = FALSE)
            if (length(colnames(RowSideColors)) > 0) {
                axis(1, 0:(dim(rsc)[2] - 1)/(dim(rsc)[2] - 1), colnames(RowSideColors), las = 2, tick = FALSE)
            }
        }
    }

    if (!( missing(ColSideColors) | is.null(ColSideColors))) {

        if (!is.matrix(ColSideColors)){
            par(mar = c(0.5, 0, 0, margins[2]))
            image(cbind(1:nc), col = ColSideColors[colInd], axes = FALSE, cex.lab=1.5)
        } else {
            par(mar = c(0.5, 0, 0, margins[2]))
            csc = ColSideColors[colInd, , drop=FALSE]
            csc.colors = matrix()
            csc.names = names(table(csc))
            csc.i = 1
            for (csc.name in csc.names) {
                csc.colors[csc.i] = csc.name
                csc[csc == csc.name] = csc.i
                csc.i = csc.i + 1
            }
            csc = matrix(as.numeric(csc), nrow = dim(csc)[1])
            image(csc, col = as.vector(csc.colors), axes = FALSE)
            if (length(colnames(ColSideColors)) > 0) {
                axis(2, 0:(dim(csc)[2] - 1)/max(1,(dim(csc)[2] - 1)), colnames(ColSideColors), las = 2, tick = FALSE, cex=1.5, cex.axis=1.5)
            }
        }
    }

    par(mar = c(margins[1], 0, 0, margins[2]))
    x <- t(x)
    cellnote <- t(cellnote)
    if (revC) {
        iy <- nr:1
        if (exists("ddr"))
            ddr <- rev(ddr)
        x <- x[, iy]
        cellnote <- cellnote[, iy]
    }
    else iy <- 1:nr
    image(1:nc, 1:nr, x, xlim = 0.5 + c(0, nc), ylim = 0.5 + c(0, nr), axes = FALSE, xlab = "", ylab = "", col = col, breaks = breaks, ...)
    retval$carpet <- x
    if (exists("ddr"))
        retval$rowDendrogram <- ddr
    if (exists("ddc"))
        retval$colDendrogram <- ddc
    retval$breaks <- breaks
    retval$col <- col
    if (!invalid(na.color) & any(is.na(x))) { # load library(gplots)
        mmat <- ifelse(is.na(x), 1, NA)
        image(1:nc, 1:nr, mmat, axes = FALSE, xlab = "", ylab = "",
            col = na.color, add = TRUE)
    }
    axis(1, 1:nc, labels = labCol, las = 2, line = -0.5, tick = 0,
        cex.axis = cexCol)
    if (!is.null(xlab))
        mtext(xlab, side = 1, line = margins[1] - 1, cex=1.2, padj=-.1)
    axis(4, iy, labels = labRow, las = 2, line = -0.5, tick = 0,
        cex.axis = cexRow)
    if (!is.null(ylab))
        mtext(ylab, side = 4, line = margins[2] - 1.2, cex=1.2, adj=-.1)
    if (!missing(add.expr))
        eval(substitute(add.expr))
    if (!missing(colsep))
        for (csep in colsep) rect(xleft = csep + 0.5, ybottom = rep(0, length(csep)), xright = csep + 0.5 + sepwidth[1], ytop = rep(ncol(x) + 1, csep), lty = 1, lwd = 1, col = sepcolor, border = sepcolor)
    if (!missing(rowsep))
        for (rsep in rowsep) rect(xleft = 0, ybottom = (ncol(x) + 1 - rsep) - 0.5, xright = nrow(x) + 1, ytop = (ncol(x) + 1 - rsep) - 0.5 - sepwidth[2], lty = 1, lwd = 1, col = sepcolor, border = sepcolor)
    min.scale <- min(breaks)
    max.scale <- max(breaks)
    x.scaled <- scale01(t(x), min.scale, max.scale)
    if (trace %in% c("both", "column")) {
        retval$vline <- vline
        vline.vals <- scale01(vline, min.scale, max.scale)
        for (i in colInd) {
            if (!is.null(vline)) {
                abline(v = i - 0.5 + vline.vals, col = linecol,
                  lty = 2)
            }
            xv <- rep(i, nrow(x.scaled)) + x.scaled[, i] - 0.5
            xv <- c(xv[1], xv)
            yv <- 1:length(xv) - 0.5
            lines(x = xv, y = yv, lwd = 1, col = tracecol, type = "s")
        }
    }
    if (trace %in% c("both", "row")) {
        retval$hline <- hline
        hline.vals <- scale01(hline, min.scale, max.scale)
        for (i in rowInd) {
            if (!is.null(hline)) {
                abline(h = i + hline, col = linecol, lty = 2)
            }
            yv <- rep(i, ncol(x.scaled)) + x.scaled[i, ] - 0.5
            yv <- rev(c(yv[1], yv))
            xv <- length(yv):1 - 0.5
            lines(x = xv, y = yv, lwd = 1, col = tracecol, type = "s")
        }
    }
    if (!missing(cellnote))
        text(x = c(row(cellnote)), y = c(col(cellnote)), labels = c(cellnote),
            col = notecol, cex = notecex)
    par(mar = c(margins[1], 0, 0, 0))
    if (dendrogram %in% c("both", "row")) {
        plot(ddr, horiz = TRUE, axes = FALSE, yaxs = "i", leaflab = "none")
    }
    else plot.new()
    par(mar = c(0, 0, if (!is.null(main)) 5 else 0, margins[2]))
    if (dendrogram %in% c("both", "column")) {
        plot(ddc, axes = FALSE, xaxs = "i", leaflab = "none")
    }
    else plot.new()
    if (!is.null(main))
        title(main, cex.main = 1.5 * op[["cex.main"]])
    if (key) {
        par(mar = c(5, 4, 2, 1), cex = 0.75)
        tmpbreaks <- breaks
        if (symkey) {
            max.raw <- max(abs(c(x, breaks)), na.rm = TRUE)
            min.raw <- -max.raw
            tmpbreaks[1] <- -max(abs(x), na.rm = TRUE)
            tmpbreaks[length(tmpbreaks)] <- max(abs(x), na.rm = TRUE)
        }
        else {
            min.raw <- min(x, na.rm = TRUE)
            max.raw <- max(x, na.rm = TRUE)
        }

        z <- seq(min.raw, max.raw, length = length(col))
        image(z = matrix(z, ncol = 1), col = col, breaks = tmpbreaks,
            xaxt = "n", yaxt = "n")
        par(usr = c(0, 1, 0, 1))
        lv <- pretty(breaks)
        xv <- scale01(as.numeric(lv), min.raw, max.raw)
        axis(3, at = xv, labels = lv, cex.axis=1.5, padj=.4)
        if (scale == "row")
            mtext(side = 1, "Row Z-Score", line = 2)
        else if (scale == "column")
            mtext(side = 1, "Column Z-Score", line = 2)
        else mtext(side = 1, KeyValueName, line = 2, cex=1.2)
        if (density.info == "density") {
            dens <- density(x, adjust = densadj, na.rm = TRUE)
            omit <- dens$x < min(breaks) | dens$x > max(breaks)
            dens$x <- dens$x[-omit]
            dens$y <- dens$y[-omit]
            dens$x <- scale01(dens$x, min.raw, max.raw)
            lines(dens$x, dens$y/max(dens$y) * 0.95, col = denscol,
                lwd = 1)
            axis(2, at = pretty(dens$y)/max(dens$y) * 0.95, pretty(dens$y))
            title("Color Key\nand Density Plot")
            par(cex = 0.5)
            mtext(side = 2, "Density", line = 2)
        }
        else if (density.info == "histogram") {
            h <- hist(x, plot = FALSE, breaks = breaks)
            hx <- scale01(breaks, min.raw, max.raw)
            hy <- c(h$counts, h$counts[length(h$counts)])
            lines(hx, hy/max(hy) * 0.95, lwd = 1, type = "s",
                col = denscol)
            axis(2, at = pretty(hy)/max(hy) * 0.95, pretty(hy))
            title("Color Key\nand Histogram")
            par(cex = 0.5)
            mtext(side = 2, "Count", line = 2)
        }
        else title("")
    }
    else plot.new()
    retval$colorTable <- data.frame(low = retval$breaks[-length(retval$breaks)],
        high = retval$breaks[-1], color = retval$col)
    invisible(retval)
}


## ----Figure_2A_geneGeneCor_NoMarkCells, dev="png", fig.height=6, fig.width=6, dpi=600, dev.args = list(bg = 'white')----

library(clue)
library(cluster)

data("nomarkerCellsClustering")
data("scLVM_output")
data("corMatsNoMarker")

#source( file.path( 
#    system.file(package="Single.mTec.Transcriptomes"),
#    "extfunction", "heatmap3.R" ) )

nClusters <- 12
colClusters <- brewer.pal(9, "Set1")
colClusters[9] <- colClusters[3]
colClusters[3] <- "black"
colClusters[10] <- "darkgray"
colClusters[11] <- "#000078"
colClusters[12] <- "#AA0078"

nonAssignedCluster <- 10
specialSort <- function(cons=nomarkerCellsClustering[["consensus"]], sendLast=10){
    rt <- sort( cl_class_ids(cons) )
    wLast <- rt == sendLast
    c( rt[!wLast], rt[wLast])
}
specialOrder <- function(cons=nomarkerCellsClustering[["consensus"]], sendLast=10){
    or <- order(cl_class_ids(cons))
    rt <- sort( cl_class_ids(cons) )
    wLast <- rt == sendLast
    c( or[!wLast], or[wLast])
}

geneGeneCorHeatmap <- function( cons=allCellsClustering[["consensus"]],
                               corMat=corMatSp,
                               expressionMatrix=Ycorr,
                               selectGenes=intersect(deGenes, aireDependent), 
                               colorClusters=""){
  mat <- expressionMatrix[rownames(expressionMatrix) %in% selectGenes,]
  or <- rownames(mat)[specialOrder( cl_class_ids(cons), nonAssignedCluster)]
  orderRows <- specialSort( cl_class_ids(cons), nonAssignedCluster)
  corMat <- 
      corMat[rownames(corMat) %in% rownames(mat),
             colnames(corMat) %in% rownames(mat)]
  rowCols <- matrix( colClusters[orderRows], nrow=1 )
  br <- seq(-1, 1, length.out=101) ** 3
  cols <- 
      colorRampPalette( 
          brewer.pal(9, "RdBu"), interpolate="spline", space="Lab")(100)  
  heatmap.3( corMat[or,or], symm=TRUE, Colv=FALSE,
          Rowv=FALSE, dendrogram="none", trace="none", breaks=br,
          col=cols, RowSideColors=rowCols,
          ColSideColors=NULL,
          labCol=rep("", nrow(corMat) ),
          labRow=rep("", nrow(corMat) ),
          margins = c(4,4), KeyValueName="Spearman\nCorrelation",
          keysize=1.5, xlab="Aire dependent genes", 
          ylab="\t\tAire dependent genes",
          NumColSideColors=1.8, NumRowSideColors=1.2)
}
par(xpd=TRUE)
geneGeneCorHeatmap(cons=nomarkerCellsClustering[["consensus"]],
                   corMat=corMatSpNoMarker,
                   expressionMatrix=Ycorr[,colData(dxd)$SurfaceMarker == "None"],
                   selectGenes=intersect( deGenesNone, aireDependent ), 
                   colorClusters=colClusters)
freqs <- rle( specialSort( cl_class_ids(nomarkerCellsClustering[["consensus"]]), 
                          nonAssignedCluster) )$lengths
freqs <- c(0, freqs)
freqs <- cumsum( freqs ) / max(cumsum(freqs))
freqs <- 1-freqs
freqs <- sapply( seq_len(length(freqs)-1), function(x){
    (freqs[x] + freqs[x+1])/2
})
freqs <- ( freqs-.125 ) / 1.085
text(LETTERS[seq_len(nClusters)], x=.12, y=(freqs), cex=1.5)

length(intersect( deGenesNone, aireDependent ) )


## ----Figure_2B_geneExpr_NoMarkCells, dev="png", fig.height=6, fig.width=6, dpi=300, dev.args = list(bg = 'white')----

colTspanRNA <- "#b2df8a"
geneExprHeatmap <- function(cons=allCellsClustering[["consensus"]],
                           corMat=corMatSp,
                           expressionMatrix=Ycorr,
                           selectGenes=intersect(deGenes, aireDependent), 
                           colorClusters="", ylab="\t\tAire dependent genes"){
mat <- expressionMatrix[rownames(expressionMatrix) %in% selectGenes,]
or <- rownames(mat)[specialOrder( cl_class_ids(cons), nonAssignedCluster)]
orderRows <- specialSort( cl_class_ids(cons), nonAssignedCluster)
cols2 <- 
    colorRampPalette( 
        brewer.pal(9,  name="Blues"), 
        interpolate="spline", space="Lab")(100)
br2 <- seq(0.01, 5, length.out=101)
mat <- expressionMatrix[rownames(expressionMatrix) %in% selectGenes,]
rowCols <- matrix( colClusters[orderRows], nrow=1 )
colCols1 <- matrix(
    ifelse( colData(dxd)[colnames(mat),]$SurfaceMarker == "Tspan8", 
           "#c51b7d", "white"),
    ncol=1)
colCols2 <- matrix(
    ifelse( colData(dxd)[colnames(mat),]$SurfaceMarker == "Ceacam1", 
           "#6a3d9a", "white"),
    ncol=1)
colCols= cbind(colCols1, colCols2)
colnames(colCols) <- c("Tspan8 +", "Ceacam1 +")
if(all(colCols == "white")){
  colCols=NULL
  ranks <- rank(
          counts(dxd, 
                 normalized=TRUE)[
                     names( geneNames[geneNames %in% "Tspan8"] ),
                     colnames(mat)],
          ties.method="min")
  cols <- colorRampPalette(c("white", colTspanRNA))(length(unique(ranks)))
  names(cols) <- as.character( sort(unique( ranks ) ))
  colCols <- matrix( cols[as.character(ranks)], ncol=1)
  mat <- mat[,order( ranks )]
  colCols <- colCols[order(ranks),, drop=FALSE]
}                          
heatmap.3( mat[or,], symm=FALSE, Colv=FALSE,
          Rowv=FALSE, dendrogram="none", trace="none", breaks=br2,
          col=cols2, RowSideColors=rowCols,
          ColSideColors=colCols,
          labCol=rep("", nrow(mat) ),
          labRow=rep("", nrow(mat) ),
          margins=c(4,4),
          keysize=1.45,
          NumColSideColors=1.2,
          NumRowSideColors=1.2,
          KeyValueName="Expression level\n(log10)",
          xlab="Cells ordered by Tspan8 expression",
          ylab=ylab)
}
  
genesForClustering <- intersect( deGenesNone, aireDependent )
genesForClustering <- rownames(Ycorr)[rownames(Ycorr) %in% genesForClustering ]

geneClusters <- 
    split(genesForClustering, 
          cl_class_ids( nomarkerCellsClustering[["consensus"]] ))

geneClusters <- c( geneClusters[-nonAssignedCluster], 
                  geneClusters[nonAssignedCluster])

grep(names( geneNames[geneNames %in% "Tspan8"] ),geneClusters)

par(xpd=TRUE)
geneExprHeatmap(cons=nomarkerCellsClustering[["consensus"]],
                corMat=corMatSpNoMarker,
                expressionMatrix=Ycorr[,colData(dxd)$SurfaceMarker == "None"],
                selectGenes=intersect(deGenesNone, aireDependent) )
legend( x=.3, y=1.01, 
       legend="Tspan8 mRNA detected",
       fill=colTspanRNA, cex=1.3, bty="n")
freqs <- rle( specialSort( 
    cl_class_ids(nomarkerCellsClustering[["consensus"]]) ) )$lengths
freqs <- c(0, freqs)
freqs <- cumsum( freqs ) / max(cumsum(freqs))
freqs <- 1-freqs
freqs <- sapply( seq_len(length(freqs)-1), function(x){
    (freqs[x] + freqs[x+1])/2
})
freqs <- ( freqs-.135 ) / 1.155
text(LETTERS[seq_len(nClusters)], x=.12, y=(freqs), cex=1.5)


## ----Figure_R3_sansomcor, dev="png", fig.height=5, fig.width=12, dpi=300, dev.args = list(bg = 'white'), warning=FALSE----

data("corMatsSansom")
data("deGenesSansom")

geneClustersDESansom <- lapply( geneClusters, function(x){
    intersect( x, rownames(corMatSp) )
})

matToUse <- corMatSp

densities <- lapply( seq_along(geneClusters), function(x){
  inClust <- rownames(matToUse) %in% geneClustersDESansom[[x]]
  as.numeric(matToUse[inClust,inClust][upper.tri(matToUse[inClust,inClust])])
})
    
backgroundDensity <- sample( unlist(geneClustersDESansom), 500 )
inBack <- rownames(matToUse) %in% backgroundDensity
backgroundDensity <- 
    as.numeric(matToUse[inBack,inBack][upper.tri(matToUse[inBack,inBack])])

densitiesComp <- list()
for(i in seq_along(densities)){
    densities[[i]] <- densities[[i]][!is.na(densities[[i]])]
    densitiesComp[[i]] <- backgroundDensity
}

t.test(unlist(densities[1:11]), backgroundDensity)

pvals <- sapply( seq_along(geneClusters), function(i){
  t.test( densities[[i]], densitiesComp[[i]], alternative="greater")$p.value
})

significant <- which( p.adjust( pvals, method="BH") < 0.05 )
LETTERS[significant]
significant

significant <- 1:12

library(geneplotter)

dfDensities <- 
    do.call(rbind, 
        lapply(significant, function(i){
  dfDensities <- 
      data.frame( 
      correlations=c( densities[[i]], densitiesComp[[i]] ),
      between=rep( c("within cluster", "background"), 
          time=c(length(densities[[i]]), length(densitiesComp[[i]]) ) ))
  dfDensities <- dfDensities[!is.nan(dfDensities$correlations),]
  dfDensities$cluster <- LETTERS[i]
  dfDensities
}) )


ggplot( dfDensities, aes(correlations, colour=between)) + 
    stat_ecdf(lwd=1.2) + 
    facet_wrap(~cluster) + coord_cartesian(xlim = c(0, .49), ylim=c(.5, 1.01))
      

## ----correlatedWith--------------------------------------------------------

expressionMat <- as.matrix(Ycorr[,colData(dxd)$SurfaceMarker=="None"])
whichCluster <- grep( names( geneNames[geneNames %in% "Tspan8"] ), geneClusters )

cat(sprintf("Tspan8 belonged to cluster %s\n", whichCluster))

maxCorTspan8 <- which.max( sapply(seq_len(nClusters), function(i){
    cor( 
      expressionMat[names( geneNames[geneNames %in% "Tspan8"] ),], 
      colMeans( expressionMat[geneClusters[[i]],])
    , method="spearman")
}) )

maxCorTspan8

cat(sprintf("Tspan8 displayed the highest correlation with Cluster %s\n", 
            maxCorTspan8))


## ----Tspan8EX--------------------------------------------------------------

expressingTspan8 <- 
    counts(dxd)[names(geneNames[geneNames %in% "Tspan8"]),
                colData(dxd)$SurfaceMarker == "None"] > 0

sum( expressingTspan8 )
table( expressingTspan8 )[["TRUE"]]/sum(table(expressingTspan8))


expressingCeacam1 <- 
    counts(dxd)[names(geneNames[geneNames %in% "Ceacam1"]),
                colData(dxd)$SurfaceMarker == "None"] > 0

sum( expressingCeacam1 )
table( expressingCeacam1 )[["TRUE"]]/sum(table(expressingCeacam1))



## ----Tspan8CoexpressionDef-------------------------------------------------

dxdUnselected <- dxd[,colData( dxd )$SurfaceMarker == "None"]
  
rowwilcoxtests <- function(x, fac){
    sp <- split( seq_len(ncol(x)), fac )
    true <- sp[["TRUE"]]
    false <- sp[["FALSE"]]
    rs <- ( bplapply( seq_len(nrow(x)), function(i){
      wt <- wilcox.test( x[i,true], x[i,false] )
      c(meanA=mean(x[i,true]), meanB=mean(x[i,false]), pval=wt$p.value)
    }, BPPARAM=MulticoreParam(numCores) ) )
    as.data.frame( do.call(rbind, rs) )
} 

deGenesNoneCorrected <- deGenesNone[deGenesNone %in% rownames(Ycorr)]

getCoexpressionGroup <- function(gene){
  cellGroups <- counts(dxdUnselected, normalized=TRUE)[gene,] > 0
  res <- rowwilcoxtests( 
    x= as.matrix(Ycorr[deGenesNoneCorrected,
        colData(dxd)$SurfaceMarker=="None"] ),
    fac=cellGroups )
  indFilter <- apply( 
      counts(dxdUnselected, normalized=TRUE)[deGenesNoneCorrected,], 1, 
      function(x){ mean(x[x != 0]) }) > 150 & 
          rowSums(counts(dxdUnselected)[deGenesNoneCorrected,] > 0) > 5
  res$pval[!indFilter] <- NA
  coexpressionGroup <- 
      deGenesNoneCorrected[which(p.adjust( res$pval, method="BH" ) < 0.1 & 
                         res$meanA - res$meanB > 0)]
  return(coexpressionGroup)
}


gene <- names( geneNames[geneNames %in% "Tspan8"] )  
names(gene) <- "Tspan8"
tspan8CoexpressionGroup <- getCoexpressionGroup(gene)

cat( sprintf("Number of differentially expressed genes at a FDR of .05: %s\n",
        length(tspan8CoexpressionGroup)-1) )

coexpressedAndAireDependent <- 
    tspan8CoexpressionGroup[tspan8CoexpressionGroup %in% aireDependent]

mat <- rbind( 
    table( geneClusters[[whichCluster]] %in% coexpressedAndAireDependent ),
    table( unlist(geneClusters[!seq_len(nClusters) %in% whichCluster] ) 
      %in% coexpressedAndAireDependent ))[,2:1]

fisher.test(mat)

dfPrint <- data.frame(
    `ensembl_gene_name`=tspan8CoexpressionGroup,
    `gene_name`=geneNames[tspan8CoexpressionGroup],
    `aire_dependent`=as.numeric(tspan8CoexpressionGroup %in% aireDependent),
    `cluster_2`=as.numeric( tspan8CoexpressionGroup %in% geneClusters[[whichCluster]]) )


write.table(dfPrint, quote=FALSE, sep="\t", row.names=FALSE, file="figure/tspan8CoexpressionGroup.txt")


## ----Figure_Supp3_tspan8enrichment, dev="png", fig.height=4, fig.width=4, dpi=300,dev.args=list(bg = 'white')----

par(mar=c(4, 6, 1, 1))
barplot( 
    mat[,1]/rowSums(mat), 
    names.arg=c("Cluster B", "All others"), 
    las=1, col="black",
    cex.axis=1.2, cex.lab=1.3, cex=1.3,
    ylab="Fraction of genes")


## ----tspan8Consistency-----------------------------------------------------

getFoldChangesForViolin <- function(gene, coexpressedGenes){
   cellGroups <- counts(dxdUnselected, normalized=TRUE)[gene,] > 0
   cellGroups <- split( names(cellGroups), cellGroups)
   outGroup <- rowMeans( Ycorr[deGenesNoneCorrected,
                               cellGroups[["FALSE"]]] )
   inGroupSelected <- 
    rowMeans( Ycorr[deGenesNoneCorrected,
                    colData(dxd)$SurfaceMarker==names(gene)] )
   names(outGroup) <- deGenesNoneCorrected
   names(inGroupSelected) <- deGenesNoneCorrected
   geneIndexes <- deGenesNoneCorrected %in% coexpressedGenes
   l2fc <- (inGroupSelected - outGroup)/log10(2)
   toRet <- list()
   toRet[["coexpressed"]] <- l2fc[geneIndexes]
   toRet[["background"]] <- l2fc[!geneIndexes]
   toRet
}

foldChangesTRApos <- list()
foldChangesTRApos[["Tspan8"]] <- 
    getFoldChangesForViolin( gene, tspan8CoexpressionGroup)

getFoldChangesForScatter <- function(gene, coexpressedGenes){
   cellGroups <- counts(dxdUnselected, normalized=TRUE)[gene,] > 0
   cellGroups <- split( names(cellGroups), cellGroups)
   outGroup <- rowMeans( Ycorr[deGenesNoneCorrected,
                               cellGroups[["FALSE"]]] )
   inGroup <- rowMeans( Ycorr[deGenesNoneCorrected,
                               cellGroups[["TRUE"]]] )
   inGroupSelected <- 
    rowMeans( Ycorr[deGenesNoneCorrected,
                    colData(dxd)$SurfaceMarker==names(gene)] )
   names(outGroup) <- deGenesNoneCorrected
   names(inGroupSelected) <- deGenesNoneCorrected
   names(inGroup) <- deGenesNoneCorrected
   toRet <- list()
   toRet[["preenriched"]] <- 
       (inGroupSelected - outGroup)/log10(2)
   toRet[["unselected"]] <- 
       (inGroup - outGroup)/log10(2)
   toRet
}

foldChangesAll <- list()
foldChangesAll[["Tspan8"]] <- 
    getFoldChangesForScatter(gene, tspan8CoexpressionGroup)

havePosFoldChange <- table( foldChangesTRApos[["Tspan8"]][["coexpressed"]] > 0 )

cat(sprintf("%s percent (%s out of %s) of the up-regulated 
genes based on the unselected mTECs have a consistent fold 
change in the Tspan8+ cells\n", 
   round( havePosFoldChange["TRUE"] / sum( havePosFoldChange ), 2 ) * 100,
   havePosFoldChange["TRUE"], sum(havePosFoldChange)))


## ----Figure_3B_tspan8Heatmap, dev="png", fig.height=4.6, fig.width=4.5, dpi=300, dev.args = list(bg = 'white')----

library(matrixStats)

colTspanPos <- "#33a02c"

makeHeatmapForGene <- function(gene, coexpressionGroup, 
                               colPos, colRNA, enrichMethod, legendLabs){
   cellsToUse <- colData(dxd)$SurfaceMarker %in% c("None", names(gene))
   goodOrder <- order( counts(dxd, normalized=TRUE)[gene,cellsToUse] )
   colPca <- 
       ifelse( colData(dxd)[cellsToUse,"SurfaceMarker"] == names(gene), 
              colPos, "white")
   nonZero <- counts(dxd, normalized=TRUE)[gene,cellsToUse] > 0
   colPca2 <- rep("white", sum(cellsToUse))
   colPca2[nonZero] <- colRNA
   cols <- 
       colorRampPalette( brewer.pal(11,  name="RdBu"), 
                     interpolate="spline", space="Lab")(100)
   expr <- as.matrix(Ycorr[coexpressionGroup,cellsToUse] / log10(2))
   rowCols <- ifelse( rownames(expr) %in% aireDependent, "black", "white" )
   br <- seq( min(expr), 4, length.out=101 )
   rowCols <- matrix(rowCols, nrow=1)
   colCols <- matrix(colPca[goodOrder], ncol=1)
   colCols <- as.matrix(cbind(colPca, colPca2))[goodOrder,]
   colnames(colCols) <- NULL
   heatmapMatrix <- (expr[,goodOrder] - rowMedians(expr[,goodOrder])) / 
      rowSds(expr[,goodOrder])
   br <- seq(-4, 4, length.out=101)
   par(xpd=TRUE)
   heatmap.3( heatmapMatrix,
         trace="none", ColSideColors=colCols,
         Colv=FALSE, col=cols, dendrogram="none",
         labCol=rep("", ncol(expr)), labRow=rep("", nrow(expr) ),
         RowSideColor=rowCols, 
         margins = c(4,4),
         KeyValueName="Expression\n(Z-score)",
         keysize=1.9,
         NumColSideColors=2, NumRowSideColors=1.2,
         breaks=br,
         xlab=sprintf("Cells ordered by\n%s expression", names(gene)),
         ylab=sprintf("Genes co-expressed with \n%s in single mature mTECs", 
             names(gene)) )
   legend( x=.15, y=1.01,
      legend=legendLabs,
      fill=c(colRNA, colPos), cex=1.1,
      bty="n")
   legend( x=-.3, y=.6,
      legend="Aire\ndependent\ngenes",
      fill="black", cex=1.2,
      bty="n")
}

makeHeatmapForGene(gene, tspan8CoexpressionGroup, 
                   colTspanPos, colTspanRNA, 
                   legendLabs=c("Tspan8 mRNA detected",
                       expression(Tspan8^"pos"~(FACS))))


## ----Ceacam1Cor------------------------------------------------------------

nonZeros=!counts(dxd)[names( geneNames[geneNames %in% "Ceacam1"] ),
                      colData(dxd)$SurfaceMarker == "None"] == 0

nonZeros <- colData(dxd)$SurfaceMarker == "None" & 
    counts(dxd)[names( geneNames[geneNames %in% "Ceacam1"]),] != 0

cor.test( 
   as.numeric(Ycorr[names(geneNames[geneNames %in% "Ceacam1"]),nonZeros][1,]),
   colMeans( Ycorr[geneClusters[[whichCluster]],nonZeros]), method="spearman" )


## ----ceacam1CoexpressionDef------------------------------------------------

gene <- names( geneNames[geneNames %in% "Ceacam1"] )
names(gene) <- "Ceacam1"

ceacam1CoexpressionGroup <-  getCoexpressionGroup(gene)

table( ceacam1CoexpressionGroup %in% aireDependent )

cat( sprintf("Number of differentially expressed genes at a FDR of .1: %s\n",
        length(ceacam1CoexpressionGroup) -1) )

cat(sprintf("The number of genes overlapping between co-expression
groups is %s\n", 
         table( ceacam1CoexpressionGroup %in% tspan8CoexpressionGroup )["TRUE"]))

percentageOverlap <- 
   table( ceacam1CoexpressionGroup %in% tspan8CoexpressionGroup )[["TRUE"]] /
   length( ceacam1CoexpressionGroup )

cat(sprintf("In percentage of Ceacam1 genes %s\n", 
            round( percentageOverlap * 100, 2)))

mat <- rbind( 
    table(ceacam1CoexpressionGroup %in% tspan8CoexpressionGroup),
    table( deGenesNone[!deGenesNone %in% ceacam1CoexpressionGroup] %in% 
          tspan8CoexpressionGroup ) )[,2:1]

rownames( mat ) <- c("coexpressed", "not coexpressed")
colnames( mat ) <- c("overlaps with Tspan8", "does not overlap")

fisher.test( mat )

mat[1,] /sum(mat[1,])

table( ceacam1CoexpressionGroup %in% tspan8CoexpressionGroup )

table( ceacam1CoexpressionGroup %in% tspan8CoexpressionGroup )[["FALSE"]] /
   length( ceacam1CoexpressionGroup )

table( tspan8CoexpressionGroup %in% ceacam1CoexpressionGroup )

table( tspan8CoexpressionGroup %in% ceacam1CoexpressionGroup )[["FALSE"]] / 
    length(tspan8CoexpressionGroup)

length( union( tspan8CoexpressionGroup, ceacam1CoexpressionGroup ) )

ceacam1Aire <- 
    ceacam1CoexpressionGroup[ceacam1CoexpressionGroup %in% aireDependent]

mat <- rbind( 
    table( geneClusters[[whichCluster]] %in% ceacam1Aire ),
    table( unlist(geneClusters[!seq_len(nClusters) %in% whichCluster] ) 
      %in% ceacam1Aire ))[,2:1]
fisher.test(mat, alternative="greater")

dfPrint <- data.frame(
    `ensembl_gene_name`=ceacam1CoexpressionGroup,
    `gene_name`=geneNames[ceacam1CoexpressionGroup],
    `aire_dependent`=as.numeric(ceacam1CoexpressionGroup %in% aireDependent),
    `cluster_2`=as.numeric( ceacam1CoexpressionGroup %in% geneClusters[[whichCluster]]) )


write.table(dfPrint, quote=FALSE, sep="\t", row.names=FALSE, file="figure/ceacam1CoexpressionGroup.txt")


## ----Figure_3C_ceacam1Density, dev="pdf", fig.height=4, fig.width=4.2, dev.args = list(bg = 'white')----


foldChangesTRApos[["Ceacam1"]] <- 
    getFoldChangesForViolin( gene, ceacam1CoexpressionGroup)


foldChangesAll[["Ceacam1"]] <- 
    getFoldChangesForScatter(gene, ceacam1CoexpressionGroup)


havePosFoldChange <- table( foldChangesTRApos[["Ceacam1"]][["coexpressed"]] > 0 )

cat(sprintf("%s percent (%s out of %s) of the up-regulated 
genes based on the unselected mTECs have a consistent fold 
change in the Ceacam1+ cells\n", 
   round( havePosFoldChange["TRUE"] / 
         (sum(havePosFoldChange)), 2 ) * 100,
   havePosFoldChange["TRUE"], (sum(havePosFoldChange))))


## ----Figure_3C_ceacam1Heatmap,  dev="png", fig.height=4.6, fig.width=4.5, dpi=300, dev.args = list(bg = 'white')----

colCeacamPos <- "#c51b7d"
colCeacamRNA <- "#edbad8"

makeHeatmapForGene(gene, ceacam1CoexpressionGroup, 
                   colCeacamPos, colCeacamRNA, 
                   legendLabs=c("Ceacam1 mRNA detected",
                       expression(Ceacam1^"pos"~(FACS))))



## ----Figure_3D_klk5Heatmap,  dev="png", fig.height=4.6, fig.width=4.5, dpi=300, dev.args = list(bg = 'white')----

gene <- names( geneNames[geneNames %in% "Klk5"] )
names(gene) <- "Klk5"
cellGroups <- counts(dxdUnselected, normalized=TRUE)[gene,] > 0
#dxdUnselected2 <- estimateSizeFactors(dxdUnselected[deGenesNone,])

cat( sprintf("The number of unselected mTECs detecting the expression
of Klk5 is %s\n", table(cellGroups)["TRUE"] ))

klk5CoexpressionGroup <- getCoexpressionGroup(gene)

wCluster <- grep( names( geneNames[geneNames %in% "Klk5"] ), geneClusters)
wCluster

matKlk <- rbind( 
  table( geneClusters[[wCluster]] %in% klk5CoexpressionGroup ),
  table( unlist(geneClusters[-wCluster]) %in% klk5CoexpressionGroup ) )[,2:1]


matKlk
fisher.test( matKlk )

foldChangesTRApos[["Klk5"]] <- 
    getFoldChangesForViolin( gene, klk5CoexpressionGroup)


foldChangesAll[["Klk5"]] <- 
    getFoldChangesForScatter(gene, klk5CoexpressionGroup)


havePosFoldChange <- table( foldChangesTRApos[["Klk5"]][["coexpressed"]] > 0 )

table( klk5CoexpressionGroup %in% aireDependent )

cat(sprintf("%s percent (%s out of %s) of the up-regulated 
genes based on the unselected mTECs have a consistent fold 
change in the Klk5+ cells\n", 
   round( havePosFoldChange["TRUE"] / 
         (sum(havePosFoldChange)), 2 ) * 100,
   havePosFoldChange["TRUE"], (sum(havePosFoldChange))))

colKlkRNA <- "#cab2d6"
colKlkPos <- "#6a3d9a"

makeHeatmapForGene(gene, klk5CoexpressionGroup, 
                   colKlkPos, colKlkRNA, 
                   legendLabs=c("Klk5 mRNA detected",
                       expression(Klk5^"pos"~(qPCR))))


dfPrint <- data.frame(
    `ensembl_gene_name`=klk5CoexpressionGroup,
    `gene_name`=geneNames[klk5CoexpressionGroup],
    `aire_dependent`=as.numeric(klk5CoexpressionGroup %in% aireDependent),
    `cluster_4`=as.numeric( klk5CoexpressionGroup %in% geneClusters[[whichCluster]]) )

write.table(dfPrint, quote=FALSE, sep="\t", row.names=FALSE, file="figure/klk5CoexpressionGroup.txt")


## ----Figure_Supp5_klk4, dev="png", fig.height=4, fig.width=4, dpi=300,dev.args=list(bg = 'white')----

par(mar=c(4, 6, 1, 1))
barplot( 
    mat[,1]/rowSums(mat), 
    names.arg=c("Cluster D", "All others"), 
    las=1, col="black",
    cex.axis=1.2, cex.lab=1.3, cex=1.3,
    ylab="Fraction of genes")


## ----defineViolinFunction--------------------------------------------------

dfValidations <- 
    data.frame(
    marker= rep( names(foldChangesTRApos), 
        sapply(foldChangesTRApos, function(x) length(unlist(x)))),
    gene = 
        unlist( lapply(foldChangesTRApos, function(x){
            rep(names(x), listLen(x))
        }) ),
    foldChange=unlist(foldChangesTRApos)
)


dfValidations$gene <- relevel(factor(dfValidations$gene), 2)

dfValidations$marker <- relevel(factor(dfValidations$marker), 3)

levels( dfValidations$gene ) <- c("Co-expressed", "All others")

#print( ggplot( dfValidations, aes(x=gene, y=foldChange, fill=gene)) +
#    geom_violin() +
#    geom_boxplot(width=0.15, outlier.shape=NA, notch=.2) +
#    facet_grid(~marker) + scale_y_continuous(limits = c(-3, 5)) +
#    geom_abline(intercept = 0, slope = 0, col="#ff00ff60", lwd=1.3) +    
#    theme(legend.position="top", legend.title=element_blank(),
#          strip.text.x = element_text(size = 12, face="bold"),
#          axis.ticks.x = element_blank(), axis.text.x = element_blank(),
#          axis.ticks.y = element_line(colour="black"),
#          legend.text=element_text(size=13),
#          axis.line = element_blank(),
#          legend.key = element_blank(),
#          axis.text.y = element_text(size=12, colour="black"),
#          axis.title=element_text(size=14),
#          panel.background =  element_rect(fill='white', colour='white'),
#          panel.border = element_rect(colour = "black", fill=NA),
#          axis.line = element_line(colour = "black")) + 
#ylab("Log fold change (base 2) between 
#TRA enriched cells (FACS or qPCR) 
#and TRA negative cells (unselected)") + xlab("") +
#    scale_fill_manual( values = c("#fc8d62", "#b3b3b3") ) )

plotViolin <- function(geneName="Tspan8", 
           ylab="Tspan8 expression (log2 fold)\nflow cytometry TRA+ vs\nunselected TRA-"){
    dfOp <- dfValidations[dfValidations$marker == geneName,]
    print( ggplot( dfOp, aes(x=gene, y=foldChange, fill=gene)) +
        geom_violin() +
        geom_boxplot(width=0.15, outlier.shape=NA, notch=.2) +
        scale_y_continuous(limits = c(-3, 5)) +
        geom_abline(intercept = 0, slope = 0, col="#ff00ff60", lwd=1.3) +    
        theme(legend.position="none", 
            legend.title=element_blank(),
            strip.text.x = element_text(size = 12, face="bold"),
            axis.ticks.x = element_line(colour="black"), 
            axis.text.x = element_text(size=14, colour="black", angle=25, hjust=1),
            axis.ticks.y = element_line(colour="black"),
            legend.text=element_text(size=13),
            legend.key = element_blank(),
            axis.text.y = element_text(size=13, colour="black"),
            axis.title=element_text(size=14),
            panel.background =  element_blank(),
            panel.grid.major = element_blank(), 
            panel.grid.minor = element_blank(),
            panel.border = element_rect(colour = "white", fill=NA),
            axis.line = element_line(colour = "black")) + 
  ylab(ylab) + xlab("") +
      scale_fill_manual( values = c("#fc8d62", "#b3b3b3") ) )
}


## ----Figure_3A1_violinPlotValidation, fig.height=3.5, fig.width=3, dev="pdf", dev.args = list(bg = 'white'), warning=FALSE----
plotViolin()

## ----Figure_3A2_violinPlotValidation, fig.height=3.5, fig.width=3, dev="pdf", dev.args = list(bg = 'white'), warning=FALSE----
plotViolin(geneName="Ceacam1", 
           ylab="Ceacam1 expression (log2 fold)\nflow cytometry TRA+ vs\nunselected TRA-")

## ----Figure_3A3_violinPlotValidation, fig.height=3.5, fig.width=3, dev="pdf", dev.args = list(bg = 'white'), warning=FALSE----
plotViolin(geneName="Klk5", ylab="Klk5 expression (log2 fold)\nqPCR TRA+ vs\nunselected TRA-")

## ----violinPvals-----------------------------------------------------------

sapply(names(foldChangesTRApos), function(x){
    t.test( foldChangesTRApos[[x]][["coexpressed"]], 
           foldChangesTRApos[["background"]])
})


## ----Figure_Supp4_violinPlotValidation, fig.height=9, fig.width=9, dpi=300, dev="png", dev.args = list(bg = 'white'), warning=FALSE----

coexpressionGroupList <- list( 
    tspan8=tspan8CoexpressionGroup, 
    ceacam1=ceacam1CoexpressionGroup, 
    klk5=klk5CoexpressionGroup )

save(coexpressionGroupList, file="../data/coexpressionGroupList.RData")

foldChangesDf <- 
    lapply( foldChangesAll, function(x){ as.data.frame(do.call(cbind, x)) } )
names(foldChangesDf) <- names(foldChangesAll)
for(x in seq_along( foldChangesDf )){
  foldChangesDf[[x]]$marker <- names(foldChangesDf)[x]  
}
stopifnot( all( names(coexpressionGroupList) == tolower(names( foldChangesDf))))
for(x in seq_along( foldChangesDf )){
  foldChangesDf[[x]]$marker <- names(foldChangesDf)[x]  
  foldChangesDf[[x]]$coexpressed <-
      rownames(foldChangesDf[[x]]) %in% coexpressionGroupList[[x]]
}
foldChangesDf <-do.call(rbind, foldChangesDf)
foldChangesDf$marker <- relevel(factor( foldChangesDf$marker ), 3)
foldChangesDf$coexpressed <- factor( foldChangesDf$coexpressed )
levels( foldChangesDf$coexpressed ) <- c("rest of the genes", "co-expressed")

#png("prueba.png", res=300, width=9, height=9, units="in")
print( ggplot( foldChangesDf, 
       aes(x=preenriched, y=unselected)) + 
    geom_point(shape=19, size=1, colour="#00000070") + 
#    stat_density2d(geom="tile", aes(fill = ..density..), contour = FALSE) +
    facet_grid(coexpressed~marker) +
    theme(legend.position="none", legend.title=element_blank(),
          strip.text = element_text(size = 14, face="bold"),
          axis.ticks.x =  element_line(colour="black"), 
          axis.text.x = element_text(size=16, colour="black"),
          axis.ticks.y = element_line(colour="black"),
          legend.text=element_blank(),
#          legend.key = element_blank(),
          axis.text.y = element_text(size=16, colour="black"),
          axis.title=element_text(size=16),# panel.background = element_blank(),
          panel.background =  element_rect(fill='white', colour='black'),
          panel.border = element_rect(colour = "black", fill=NA),
          axis.line = element_line(colour = "black")) + 
    ylim(c(-5, 5)) + xlim(c(-4.9,4.9)) +
xlab("Log fold change (base 2) between
TRA enriched cells (TRA or qPCR) and 
TRA negative cells (unselected)") +
ylab("Log fold change (base 2) between
TRA positive cells (unselected) and 
TRA negative cells (unselected)") +
    geom_abline(intercept=0, slope=0, col="red") +
    geom_vline(xintercept=0, col="red") +  coord_fixed() )
#dev.off()


## ----coexpressedTRAornot---------------------------------------------------

back <- table(isTRA)
lapply(coexpressionGroupList, function(x){
    fore <- table( x %in% rownames(dxd)[isTRA] )
    fisher.test(
        rbind( fore, back - fore)[,2:1])
})
  

## ----Figure_4A_PCA, dev="png", fig.height=5.8, fig.width=5.8, dpi=300, dev.args = list(bg = 'white')----

tspan8 <- names( geneNames[geneNames %in% "Tspan8"] )
ceacam1 <- names( geneNames[geneNames %in% "Ceacam1"] )

genesForPca <- union( tspan8CoexpressionGroup, ceacam1CoexpressionGroup )

cellsForPca <- names( which( colSums( counts( dxd, 
                       normalized=TRUE )[c(tspan8, ceacam1),] ) >= 0 ) )
length( cellsForPca )

dataForPca <- Ycorr[rownames(Ycorr) %in% genesForPca,cellsForPca]
  
pr <- prcomp(t(dataForPca))

colUnselected <- "#b1592850"
colors <- c(colUnselected, colCeacamPos, colTspanPos, colKlkPos)
names(colors) <- c("None", "Ceacam1", "Tspan8", "Klk5")
colsForPca <- 
    colors[as.character(colData(dxd)[rownames(pr$x),"SurfaceMarker"])]

spCellNames <- 
    split( colnames(dataForPca), 
          colData(dxd)[cellsForPca,"SurfaceMarker"])

par(mar=c(5, 4.8, 7, 1), xpd=FALSE)
plot( pr$x[spCellNames[["None"]],"PC1"], pr$x[spCellNames[["None"]],"PC2"],
     col=colors["None"],
     pch=19, cex=1.2, ylim=c(-10, 10), asp=1,
     cex.axis=1.45, cex.lab=1.5,
     xlab="Principal component 1",
     ylab="Principal component 2")
points( pr$x[spCellNames[["Tspan8"]],"PC1"], 
       pr$x[spCellNames[["Tspan8"]],"PC2"],
       col=colors["Tspan8"], pch=19, cex=1.2)
points( pr$x[spCellNames[["Ceacam1"]],"PC1"], 
       pr$x[spCellNames[["Ceacam1"]],"PC2"],
       col=colors["Ceacam1"], pch=19, cex=1.2)
points( pr$x[spCellNames[["Klk5"]],"PC1"], 
       pr$x[spCellNames[["Klk5"]],"PC2"],
       col=colors["Klk5"], pch=19, cex=1.2)
abline(v=10, lwd=3, col="#1a1a1a", lty="dashed")
legend( x=-10, y=28,
    legend=c(expression(Tspan8^"pos"~cells~(FACS)), 
        expression(Ceacam1^"pos"~cells~(FACS)),
        expression(Klk5^"pos"~cells~(qPCR)),
        "Unselected cells"),
    fill=c(colTspanPos, colCeacamPos, colKlkPos, colUnselected), 
       xpd=TRUE, cex=1.3, 
       horiz=FALSE, bty="n")


## ----tspanExpr-------------------------------------------------------------

cor( as.vector(as.matrix(dataForPca[tspan8,cellsForPca])), 
    pr$x[,"PC1"], method="spearman")
cor( as.vector(as.matrix(dataForPca[ceacam1,cellsForPca])), 
    pr$x[,"PC1"], method="spearman")
klk5 <- names( geneNames[geneNames %in% "Klk5"] )
    

## ----moreThanPC------------------------------------------------------------

more10InPC1 <- sapply( 
    split( pr$x[,"PC1"] > 10,
    as.character(colData(dxd)[rownames(pr$x),"SurfaceMarker"] )), 
    table)
if(is.na(more10InPC1[["Klk5"]]["TRUE"])){
    more10InPC1[["Klk5"]]["TRUE"] <- 0
}

more10InPC1 <- do.call(cbind, more10InPC1)

round( more10InPC1["TRUE",] / colSums(more10InPC1), 2)


## ----Figure_Supp6_coexpressionHeatmapAll, dev="png", fig.height=5.2, fig.width=6.2, dpi=300, dev.args = list(bg = 'white')----

plotPCAHeatmap <- function(whichCells=colData(dxd)$SurfaceMarker!="None", 
                           showMarkers=FALSE){
  pr <- prcomp(t(dataForPca))
  expr <- asinh( counts(dxd, normalized=TRUE)  )
  expr <- ( expr - rowMedians(expr) )/ rowSds(expr)
  expr <- expr[rownames(dataForPca),whichCells]
  colors["None"] <- "white"
  colors["Tspan8"] <- colTspanRNA
  colors["Ceacam1"] <- colCeacamRNA
  colMiddle <- "#fdbf6f"
  colRows <- 
      ifelse( rownames(expr) %in% tspan8CoexpressionGroup, 
             colors["Tspan8"], "black" )
  colRows <- 
      ifelse( rownames(expr) %in% ceacam1CoexpressionGroup, 
             colors["Ceacam1"], colRows )
  colRows <- 
      ifelse( rownames(expr) %in% 
             intersect( tspan8CoexpressionGroup, ceacam1CoexpressionGroup ), 
             colMiddle, colRows)
  colRows <- matrix(colRows, nrow=1)
  colors["None"] <- "white"
  colors["Tspan8"] <- colTspanPos
  colors["Ceacam1"] <- colCeacamPos
  br <- seq(-4, 4, length.out=101)
  cols <- 
      colorRampPalette( brewer.pal(9, "RdBu"), 
                       interpolate="spline", space="Lab")(100)  
  colCols1 <-
      colors[as.character(colData(dxd)[colnames(expr),"SurfaceMarker"])]
  colCols2 <- rep("white", ncol(expr))
  nonZeros <- 
      counts(dxd)[ names( geneNames[geneNames %in% "Tspan8"] ),
                  colnames(expr)] > 0
  rankOrder <-
      order( expr[names( geneNames[geneNames %in% "Tspan8"] ),
                  nonZeros] )
  colCols2[nonZeros][rankOrder] <- 
    colorRampPalette( c("white", colors["Tspan8"]))(sum(nonZeros))
  colCols3 <- rep("white", ncol(expr))
  nonZeros <- 
      counts(dxd)[ names( geneNames[geneNames %in% "Ceacam1"] ),
                  colnames(expr)] > 0
  rankOrder <- order( expr[names( geneNames[geneNames %in% "Ceacam1"] ),
                           nonZeros] )
  colCols3[nonZeros][rankOrder] <- 
    colorRampPalette( c("white", colors["Ceacam1"]))(sum(nonZeros))
  if( showMarkers ){
     colCols <- cbind( colCols1, colCols2, colCols3)
     colnames(colCols) <- 
      c("Surface Marker", "Tspan8 expression", "Ceacam1 expression")
  }else{
     colCols <- cbind( colCols2, colCols3)
     colnames(colCols) <- 
      c("Tspan8 expression", "Ceacam1 expression")
  }
  pr$x <- pr$x[colnames(expr),]
  par(xpd=TRUE)
  heatmap.3( 
          expr[rev(order(colRows[1,])),order( pr$x[,"PC1"] )],
          trace="none", col=cols, 
          dendrogram="none",
          labCol=rep("", ncol(expr)), 
          labRow=rep("", nrow(expr) ),
          ColSideColors=colCols[order(pr$x[,"PC1"]),],
          RowSideColors=colRows[,rev(order( colRows[1,]) ), 
              drop=FALSE],
          Rowv=FALSE,
          Colv=FALSE,
          NumColSideColors=2.5,
          breaks=br,
          margins = c(4,4), 
          KeyValueName="Expression\n(Z-scores)",
          keysize=1.7,
          NumRowSideColors=1.1,
          xlab="Cells ordered by\nprincipal component 1",
          ylab="Co-expressed genes in mature mTECs\n")
  if( showMarkers ){
     legend( x=.45, y=1.1,
          legend=c(expression(Tspan8^"pos"~(FACS)), 
              expression(Ceacam1^"pos"~(FACS)),
              expression(Klk5^"pos"~(qPCR))),
          fill=c(colTspanPos, colCeacamPos, colKlkPos), cex=1.2,
          bty="n")
  }
  legend( x=-.1, y=.4,
       title="co-expressed\nwith:",
       legend=c("Tspan8", "Ceacam1", "both"),
       fill=c(colTspanRNA, colCeacamRNA, colMiddle), cex=1.2,
       bty="n")
}




## ----onlyMarkedCells-------------------------------------------------------

expr <- asinh( counts(dxd, normalized=TRUE)  )
expr <- ( expr - rowMedians(expr) )/ rowSds(expr)
expr <- 
    expr[rownames(dataForPca),
         !colData(dxd)$SurfaceMarker %in% c( "None", "Klk5")]

factorForSplit <- rep("", nrow(expr) )
factorForSplit[rownames(expr) %in% tspan8CoexpressionGroup] <- 
    "Tspan8"
factorForSplit[rownames(expr) %in% ceacam1CoexpressionGroup] <- 
    "Ceacam1"
factorForSplit[rownames(expr) %in% 
               intersect( tspan8CoexpressionGroup, 
                         ceacam1CoexpressionGroup)] <- 
    "Both"

meanExpressionPerGroup <- lapply( 
    split( as.data.frame(expr), factorForSplit),
       function(x){
           colMeans(x)
       })


sapply( c(`ceacam1`=ceacam1, tspan8=`tspan8`), function(y){
  sapply( meanExpressionPerGroup, function(x){
      nonZeros <- rep(TRUE, ncol(expr))
#      nonZeros <- expr[y,] != 0
      cor( expr[y,nonZeros], x[nonZeros], method="spearman")
  })
})

sapply( c( `ceacam1`=ceacam1, `tspan8`=tspan8), function(y){
      nonZeros <- rep(TRUE, ncol(expr))
#      nonZeros <- expr[y,] != 0
      cor( colMeans(expr)[nonZeros], expr[y,nonZeros], method="spearman")
})


## ----Ceacam1NoCor----------------------------------------------------------

expr <- asinh( counts(dxd, normalized=TRUE)  )
expr <- ( expr - rowMedians(expr) )/ rowSds(expr)

expr <- expr[rownames(dataForPca),colData(dxd)$SurfaceMarker=="Ceacam1"]

factorForSplit <- rep("", nrow(expr) )
factorForSplit[rownames(expr) %in% tspan8CoexpressionGroup] <- 
    "Tspan8"
factorForSplit[rownames(expr) %in% ceacam1CoexpressionGroup] <- 
    "Ceacam1"
factorForSplit[rownames(expr) %in% 
               intersect( ceacam1CoexpressionGroup, 
                         tspan8CoexpressionGroup)] <- 
    "Both"
meanExpressionPerGroup <- lapply( 
    split( as.data.frame(expr), factorForSplit),
       function(x){
           colMeans(x)
       })

sapply( c(`ceacam1`=ceacam1, tspan8=`tspan8`), function(y){
  sapply( meanExpressionPerGroup, function(x){
      nonZeros <- rep(TRUE, ncol(expr))
#      nonZeros <- expr[y,] != 0
      cor( expr[y,nonZeros], x[nonZeros], method="spearman")
  })
}) 

sapply( c( `ceacam1`=ceacam1, `tspan8`=tspan8), function(y){
      nonZeros <- rep(TRUE, ncol(expr))
#      nonZeros <- expr[tspan8,] != 0
      cor( colMeans(expr)[nonZeros], expr[y,nonZeros], method="spearman")
})



## ----Figure_4B_coexpressionHeatmapCeacam1, dev="png", fig.height=5.2, fig.width=6.2, dpi=300, dev.args = list(bg = 'white')----
plotPCAHeatmap(colData(dxd)$SurfaceMarker=="Ceacam1")

## ----eval=FALSE, echo=FALSE------------------------------------------------
# 
# data("gseaReactome")
# deGenesTspan8Coding <- deGenesTspan8[deGenesTspan8 %in% proteinCoding]
# deGenesCeacam1Coding <- deGenesTspan8[deGenesCeacam1 %in% proteinCoding]
# 
# testTspan8 <- testForReactome(
#     foreground=deGenesTspan8Coding,
#     background=proteinCoding[!proteinCoding %in% deGenesTspan8Coding],
#     processesDF=processesDF,
#     uniprots=uniprots,
#     geneName=geneNames,
#     cores=numCores
#     )
# 
# testTspan8 <- testTspan8[which(testTspan8$padj < 0.05),]
# testTspan8$geneNames
# 
# 
# testCeacam1 <- testForReactome(
#     foreground=deGenesCeacam1Coding,
#     background=proteinCoding[!proteinCoding %in% deGenesCeacam1Coding],
#     processesDF=processesDF,
#     uniprots=uniprots,
#     geneName=geneNames,
#     cores=numCores
#     )
# 
# testCeacam1 <- testCeacam1[which(testCeacam1$padj < 0.05),]
# testCeacam1$geneNames
# 

## ----whichKLK--------------------------------------------------------------

geneClusterNames <- sapply( geneClusters, function(x){
  geneNames[names( geneNames ) %in% x]
})
 

## ----loadMouseAnnotation---------------------------------------------------

#library(GenomicFeatures)
#transcriptDb <- loadDb( system.file("extdata", 
#            "Mus_musculus.GRCm38.75.primary_assembly.sqlite",
#            package="Single.mTec.Transcriptomes") )
#exonsByGene <- exonsBy( transcriptDb, "gene" )
#save(geneRanges, file="../data/geneRanges.RData")
#geneRanges <- unlist( range( exonsByGene ) )
#seqlevels(geneRanges) <- c(1:19, "X")

data("geneRanges")
dn <- 
    geneRanges[names(geneRanges) %in% 
               names( which( biotype == "protein_coding" ) ),]


## ----eval=FALSE------------------------------------------------------------
# 
# dnAire <- dn[names(dn) %in% aireDependentSansom]
# dnTested <- dn[names(dn) %in% deGenesNone]
# 
# permutationsForCluster <- function( groupSize, numPerm=1000){
#    distancePermuted <- bplapply( seq_len(numPerm), function(x){
#        sampleGenes <- sample(seq_len(length(dn)), groupSize )
#        median(
#          distanceToNearest( dn[sampleGenes] )@elementMetadata$distance,
#          na.rm=TRUE)
#    }, BPPARAM=MulticoreParam(10))
#    unlist( distancePermuted )
# }
# 
# numberOfPermutations <- 1000
# 
# permsAllClusters <- lapply( seq_len(length(geneClusters)), function(i){
#   permutationsForCluster( length(geneClusters[[i]]), numberOfPermutations )
# })
# 
# realAllClusters <- sapply(seq_len(length(geneClusters)), function(i){
#    median( distanceToNearest(
#        dn[names(dn) %in% geneClusters[[i]],])@elementMetadata$distance,
#           na.rm=TRUE )
# })
# 
# names( permsAllClusters ) <- LETTERS[seq_len(length(permsAllClusters))]
# names( realAllClusters ) <- LETTERS[seq_len(length(permsAllClusters))]
# 
# permsAllClusters <- permsAllClusters[!names(permsAllClusters) %in% "L"]
# realAllClusters <- realAllClusters[!names(realAllClusters) %in% "L"]
# 
# save(permsAllClusters, realAllClusters,
#      file="../data/permutationResults.RData")
# 

## ----loadPerm--------------------------------------------------------------

names(colClusters) <- LETTERS[1:12]

data("permutationResults")
numberOfPermutations <- 1000

pvals <- sapply( names(permsAllClusters), function(x){
    sum( realAllClusters[x] > permsAllClusters[[x]] )
}) / numberOfPermutations

p.adjust(pvals, method="BH")
sum( p.adjust( pvals, method="BH") < 0.1 )

adjusted <- p.adjust( pvals, method="BH" ) < 0.1
names(permsAllClusters)[adjusted]


## ----Figure_Supp6_clusterPval, dev="png", fig.height=9, fig.width=11, dpi=300, dev.args = list(bg = 'white')----


par(mfrow=c(3, 4), mar=c(5, 5, 2, 2))
for( i in names(permsAllClusters) ){
  coexpressedCoordinates <- 
      dn[names(dn) %in% geneClusters[[i]]]
  distancePermuted <- permsAllClusters[[i]]
  xmin <- min(distancePermuted, realAllClusters[i])
  xmax <- max(distancePermuted, realAllClusters[i])
  hist( distancePermuted, 15, 
  xlab="Expected genomic distance (Mb)", 
       cex.lab=1.4, #main="",
       cex.axis=1.8, xaxt="n",
       xlim=c(xmin, xmax),
       main=paste("Group", i ), cex.main=1.8)
  sq <- seq(0, 20000000, 1000000)
  axis(1, at=sq, label=sq/1000000, cex.axis=1.7)
  md <- realAllClusters[i]
  abline( v=md, col=colClusters[i], lwd=4)
}


## ----Figure_Supp7_karyograms, fig.height=5.5, fig.width=4.3, dev="pdf", dev.args = list(bg = 'white', onefile=TRUE), warning=FALSE----

names( geneClusters ) <- LETTERS[1:12]

library(ggbio)
for(x in names(permsAllClusters)){
   coexpressedCoordinates <- dn[names(dn) %in% geneClusters[[x]]]
   kr <- 
       autoplot(coexpressedCoordinates, layout="karyogram",
              col=colClusters[x], fill=colClusters[x]) + 
                  theme(
                      panel.background = element_blank(),
                      strip.text.y = element_text(size = 16),
                      axis.text.x = element_text(size=14, colour="black") ) 
   print(kr)
}


## ----Figure_5A_karyogram, fig.height=5.5, fig.width=4.3, dev.args=list(bg='white'), dev="pdf", warning=FALSE----


clusterNumber <- LETTERS[wCluster]
 coexpressedCoordinates <- 
      geneRanges[names(geneRanges) %in% geneClusters[[clusterNumber]]]
dn2 <- GRanges("7", IRanges(start=18474583, end=18656725))
dn4 <- GRanges("9", IRanges(start=14860210, end=14903949))
library(ggbio)

print( autoplot(coexpressedCoordinates, layout="karyogram", 
                col=colClusters[clusterNumber], 
                fill=colClusters[clusterNumber]) +
    theme(
        panel.background = element_blank(),
        strip.text.y = element_text(size = 16),
        axis.text.x = element_text(size=14, colour="black")
        ) )


## ----Figure_5B_expectedGenomicDistance, dev="pdf", fig.height=4, fig.width=4.3, dev.args = list(bg = 'white')----

i <- clusterNumber
distancePermuted <- permsAllClusters[[i]]
xmin <- min(distancePermuted, realAllClusters[i])
xmax <- max(distancePermuted, realAllClusters[i])
par(mar=c(4.2, 4.5, 1, 1))
hist( distancePermuted, 30, 
xlab="Expected genomic distance (Mb)", 
     cex.lab=1.4, #main="",
     cex.axis=1.8, xaxt="n",
     xlim=c(xmin, xmax),
     main="", cex.main=1.8)
sq <- seq(0, 20000000, 1000000)
axis(1, at=sq, label=sq/1000000, cex.axis=1.7)
md <- realAllClusters[i]
abline( v=md, col=colClusters[i], lwd=4)


## ----Figure_Supp10_unrelated, fig.height=4, fig.width=6.5, dev="pdf", dev.args = list(bg = 'white')----

library(Gviz)

colVector <- rep(colClusters, sapply(geneClusters, length) )
names(colVector) <- unlist(geneClusters)
range <- dn2
data("geneNames")

length(unlist(geneClusters[1:11])) / length(unlist(geneClusters))

sum( unlist(geneClusters[1:11]) %in% tras )/
    sum( unlist(geneClusters) %in% tras )

makePlotForRegion <- function(range, left=100000, 
                              right=100000, colClusterNumber=NULL){
   start(range) <- start( range ) - left
   end(range) <- end( range ) + right
   geneRanges <- geneRanges[names( geneRanges ) %in% proteinCoding]
   overlap <- findOverlaps( range, geneRanges, ignore.strand=TRUE )
   toPlot <- geneRanges[names(geneRanges[subjectHits(overlap)])]
   seqlevels(toPlot) <- as.character(1:19)
   ch <- unique( as.character(seqnames(toPlot)) )
   if( !is.null(colClusterNumber)){
       cols <- ifelse( names(toPlot) %in% geneClusters[[colClusterNumber]], 
          colClusters[[colClusterNumber]], "white")
   }else{
     cols <- colVector[names( toPlot )]
     cols[is.na(cols)] <- "white"
   }
   labels <- sprintf( "%s (%s)", geneNames[names(toPlot)], 
                     as.character(strand(toPlot)))
   plotTracks( list(
     GeneRegionTrack( toPlot, symbol=labels, name=paste("chr", ch)),
     GenomeAxisTrack()),
            showId=TRUE, geneSymbol=TRUE,
            fill=cols, fontsize=20, 
            fontcolor="black", detailsBorder.col="black", 
            col.line="black", col="black",
            sizes=c(5, 1))
}

dn2 <- GRanges("6", IRanges(start=122447296,end=122714633))
makePlotForRegion(dn2, left=1000, right=1500, colClusterNumber=clusterNumber)


## ----Figure_Supp9_related, fig.height=4, fig.width=6.5, dev="pdf", dev.args = list(bg = 'white')----

dn2 <- GRanges("3", IRanges(start=107923453,end=107999678))
makePlotForRegion(dn2, left=1000, right=1500, colClusterNumber=clusterNumber)


## ----Figure_Supp8_related, fig.height=4, fig.width=6.5, dev="pdf", dev.args = list(bg = 'white')----

dn2 <- GRanges("2", IRanges(start=154049564,end=154479003))
makePlotForRegion(dn2, left=100, right=100, colClusterNumber=clusterNumber)


## ----Figure_5C_Klkloci, fig.height=5, fig.width=7, dev="pdf", dev.args = list(bg = 'white')----

dn5 <- GRanges("7", IRanges(start=43690418,end=44229617))
makePlotForRegion(dn5, left=20000, right=3500, colClusterNumber=clusterNumber)


## ----Figure_5D_KlkExpression, dev="png", fig.height=5.5, fig.width=5.8, dpi=300, dev.args = list(bg = 'white')----

range <- dn5
start(range) <- start( range ) - 20000
end(range) <- end( range ) + 3500
overlap <- findOverlaps( range, geneRanges, ignore.strand=TRUE )
toPlot <- geneRanges[names(geneRanges[subjectHits(overlap)])]
toPlot <- toPlot[names( toPlot ) %in% proteinCoding,]

coexpressedCoordinates <- geneRanges[names( toPlot ),]
coexpressedCoordinates <- sort( coexpressedCoordinates, ignore.strand=TRUE )
klkGenes <- names(coexpressedCoordinates)

library(pheatmap)

cellOrder <- 
    names( sort(counts(dxd,normalized=TRUE)[gene,
       colData(dxd)$SurfaceMarker %in% c("Klk5", "None")], decreasing=TRUE) )

annotationGenes <- 
    data.frame( 
       kmeans=1*klkGenes %in% geneClusters[[clusterNumber]],
       wilcox=1*klkGenes %in% klk5CoexpressionGroup,
       aireDependent= 1*(klkGenes %in% aireDependent),
       row.names=klkGenes)


klkMat <- asinh( counts(dxd, normalized=TRUE)[klkGenes,cellOrder])
klkMat <- ( klkMat - rowMedians(klkMat) ) / rowSds(klkMat)
klkMat <- pmin(klkMat, 3)

colsKlk <- colorRampPalette(brewer.pal(9, "Blues"))(50)
colsKlk <- colorRampPalette(brewer.pal(9, "RdBu"))(50)

annotationCells <- 
    data.frame(
        droplevels(colData(dxd)[colnames(klkMat),"SurfaceMarker"]))
rownames(annotationCells) <- colnames(klkMat)
colnames(annotationCells) <- "cell"

ann_colors <-     
    list(cell=c(
             Klk5=colClusters[[clusterNumber]],
             None="lightgray") )

pheatmap(( t(klkMat) )*1, 
         col=colsKlk, 
         cluster_rows=FALSE, cluster_cols=FALSE,
         labels_row="", labels_col=geneNames[klkGenes],
         annotation_row=annotationCells,
         annotation_colors=ann_colors,
         breaks = seq(-3, 3, length.out=51), 
         legend=TRUE,
         fontsize = 12)


## ----Figure_Supp11_KlkExpression, dev="pdf", fig.height=5.5, fig.width=9, dev.args = list(bg = 'white')----

cellGroups <- split( names(cellGroups), cellGroups)
klkMat <- klkMat[,!colnames(klkMat) %in% cellGroups[["TRUE"]]]

cellSplit <- 
    split(colnames(klkMat),
      droplevels(colData(dxd)[colnames(klkMat),"SurfaceMarker"]))

klkPercentages <- 
 apply( klkMat, 1, function(x){
    c(None=sum( x[cellSplit[["None"]]] > 0 ),
      Klk5=sum( x[cellSplit[["Klk5"]]] > 0 ))
})

klkPercentages["None",] <- klkPercentages["None",] / length(cellSplit[["None"]])
klkPercentages["Klk5",] <- klkPercentages["Klk5",] / length(cellSplit[["Klk5"]])


dfKlkFractions <-
    data.frame(
        fraction=as.vector(klkPercentages),
        cell=rep(rownames(klkPercentages), ncol(klkPercentages)),
        gene=factor( rep(geneNames[colnames(klkPercentages)], 
            each=nrow(klkPercentages)),
            levels=geneNames[colnames(klkPercentages)]))

levels(dfKlkFractions$cell) <- c("Klk5 pos (qPCR)", "Klk5 neg (ad hoc)")

print(ggplot( dfKlkFractions, aes( x=gene, y=fraction, fill=cell )) + 
    ggplot2::geom_bar(stat="identity") +
    facet_grid(cell~.) + 
    ylab("fraction of cells") + xlab("") +
    theme( axis.text.x=element_text(size=12, 
               color="black", angle=90, hjust = 1, vjust=0 ) ) )


## ----KlkRange--------------------------------------------------------------

dfKlk <- 
    as.data.frame( geneRanges[names( geneNames[grepl("Klk", geneNames )] ),] )
dfKlk <- dfKlk[dfKlk$seqnames == 7,]
nms <- sapply( geneClusterNames, function(x){
    sum(grepl("Klk", x))
})
names(nms) <- LETTERS[as.numeric(names(nms))]
nms


## ----printTable------------------------------------------------------------

clusterInfo <- data.frame(
    `ensemblID`=unlist( geneClusters ),
    `geneNames`=geneNames[unlist( geneClusters )],
    `clusterNumber`=rep(names(geneClusters), sapply(geneClusters, length) ),
    `clusterColor`=rep(colClusters, sapply(geneClusters, length) ) )
rownames( clusterInfo ) <- NULL
write.table( clusterInfo, sep="\t", 
            quote=FALSE, row.names=FALSE, col.names=TRUE, 
            file="figure/Table_Supp1_CoexpressionGroupsTable.txt" )


## ----atacStart-------------------------------------------------------------

data("geneNamesHuman")
data("biotypesHuman")   
data(muc1Coexpression)
data(cea1Coexpression)
data(dxdATAC)

dxdCEACAM5 <- dxdATAC[,colData(dxdATAC)$TRA == "CEACAM5"]
colData(dxdCEACAM5) <- droplevels(colData(dxdCEACAM5))
dxdCEACAM5 <- estimateSizeFactors(dxdCEACAM5)
dxdCEACAM5 <- estimateDispersions(dxdCEACAM5)
dxdCEACAM5 <- nbinomWaldTest(dxdCEACAM5)

CEACAM5Group <- 
    as.character( 
        cea1Coexpression$SYMBOL[
           cea1Coexpression$`adj.P.Val` < 0.1 & 
                                cea1Coexpression$logFC > 2] )
CEACAM5Group <- names( geneNames[geneNames %in% CEACAM5Group] )

dxdMUC1 <- dxdATAC[,colData(dxdATAC)$TRA == "MUC1"]
colData(dxdMUC1) <- droplevels(colData(dxdMUC1))
dxdMUC1 <- estimateSizeFactors(dxdMUC1)
dxdMUC1 <- estimateDispersions(dxdMUC1)
dxdMUC1 <- nbinomWaldTest(dxdMUC1)

MUC1Group <- 
    as.character( 
        muc1Coexpression$SYMBOL[
           muc1Coexpression$`adj.P.Val` < 0.1 & muc1Coexpression$logFC > 2] )
MUC1Group <- names( geneNames[geneNames %in% MUC1Group] )

length(CEACAM5Group)
length(MUC1Group)


## ----humanGroups-----------------------------------------------------------

t.test(
    results(dxdCEACAM5)$log2FoldChange[rownames(dxdCEACAM5) %in% CEACAM5Group],
    results(dxdCEACAM5)$log2FoldChange, alternative="greater")

t.test(
    results(dxdMUC1)$log2FoldChange[rownames(dxdMUC1) %in% MUC1Group],
    results(dxdMUC1)$log2FoldChange, alternative="greater")


## ----defineAtacViolin------------------------------------------------------
  

dim(results(dxdCEACAM5))
dim(results(dxdMUC1))

df <- data.frame(
    signal = c( results(dxdCEACAM5)$log2FoldChange, 
        results(dxdMUC1)$log2FoldChange),
    group = rep(c("CEACAM5", "MUC1"), each=dim(results(dxdMUC1))[1]),
    genes = c(
        ifelse( rownames(dxdCEACAM5) %in% CEACAM5Group, 
               "Co-expressed", "All others"),
        ifelse( rownames(dxdMUC1) %in% MUC1Group, 
               "Co-expressed", "All others") ))

df$genes <- relevel( factor(df$genes), 2 )

atacViolin <- function(gene, ylab="", ylim=c(-2, 2)){
     dfOp <- df[df$group == gene,]
     p <- ggplot(dfOp, aes(factor(genes), signal, fill=genes))
     p <- p + geom_violin() + 
         geom_boxplot(width=.4, notch=.2, outlier.shape=NA) +
#   facet_grid(~group) + 
         scale_y_continuous(limits = ylim) +
         geom_abline(intercept = 0, slope = 0, col="#ff00ff60", lwd=1.3) +
         theme(legend.position="none", legend.title=element_blank(),
              strip.text.x = element_text(size = 12, face="bold"),
              axis.ticks.x = element_blank(), 
              axis.text.x = element_text(size=14, colour="black", angle=25, hjust=1),
              axis.ticks.y = element_line(colour="black"),
              legend.text=element_text(size=13),
              legend.key = element_blank(),
              axis.text.y = element_text(size=14, colour="black"),
              axis.title=element_text(size=14),
              axis.line=element_line(colour="black"),
              panel.background = element_rect(colour="white", fill="white"),
              panel.border = element_rect(colour = "white", fill=NA),
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank()) +
        xlab("") +
        ylab(ylab) +
        scale_fill_manual( values = c("#af8dc3", "#7fbf7b") )
     p
 }


## ----Figure_6A1_Atacseq, fig.height=3.3, fig.width=2.8, dev="pdf", dev.args = list(bg = 'white'), warning=FALSE----

#pdf("prueba.pdf", height=3.3, width=2.8)
atacViolin("CEACAM5", "Promoter accesibility\n(log2 fold)\nCEACAM5+ vs CEACAM5-")
#dev.off()


## ----Figure_6A2_Atacseq, fig.height=3.3, fig.width=2.8, dev="pdf", dev.args = list(bg = 'white'), warning=FALSE----
atacViolin("MUC1", 
           "Promoter accesibility\n(log2 fold)\nMUC+ vs MUC-", 
           c(-1.1, 1.1))

## ----sessioninfo-----------------------------------------------------------
sessionInfo()

