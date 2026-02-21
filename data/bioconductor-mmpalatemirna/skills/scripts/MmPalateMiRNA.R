# Code example from 'MmPalateMiRNA' vignette. See references/ for full tutorial.

### R code from vignette source 'MmPalateMiRNA.Rnw'

###################################################
### code chunk number 1: Roptions
###################################################
options(prompt="R> ", width=70, continue=" ")
## usually, width=60 ...


###################################################
### code chunk number 2: LoadPackageData
###################################################
library("MmPalateMiRNA")
data(PalateData)


###################################################
### code chunk number 3: DensityPlotsControlChannel
###################################################

####################################################################
## Densities of log2 intensities in reference (green) channel
## organize according to different types of probes
## different lines correspond to different arrays
####################################################################

## separate into mouse, non-mouse, blank, control probes
## panels = probe type AND normalization type
## groups = arrays
## y = density
## x = log2 values

## Use ~ x1 + x2 | y fomula for multiple x's ..
## Done within the S4 method for class 'RGList' for densityplot
## Code so that each day is different color, but each replicate is different line type

#library("lattice")

res <- densityplot(PalateData, channel="G", group="probe.type",
                   subset = c("Other miRNAs",   "MMU miRNAs", "Control"),
                   col=rep(1:3, each=3), lty=rep(1:3, 3),
                   key = list(lines=list(col=rep(1:3, each=3), lty=rep(1:3, 3)),
                     text=list(colnames(PalateData)), columns=3))
print(res)

## looks like 3 outlying arrays (021, 033, 029)
## 12-1, 14-3, 13-2 ...
## 12-1, 12-2, 12-3, 13-1, 13-2, 13-3, 14-1, 14-2, 14-3
## 021,  022,  023,  024,  033,  034,  035,  036,  029



###################################################
### code chunk number 4: RedoFigure1OmitOutliers (eval = FALSE)
###################################################
## ## Redo, omiting 021, 033, and 029 (keep two replicates for each day)
## res <- densityplot(PalateData[, -c(1, 5, 9)], channel="G", group="probe.type",
##                    subset = c("Other miRNAs",   "MMU miRNAs", "Control"),
##                    col=rep(1:3, each=2), lty=rep(1:3, 2),
##                    key = list(lines=list(col=rep(1:3, each=2), lty=rep(1:3, 2)),
##                      text=list(colnames(PalateData[, -c(1, 5, 9)])), columns=3))
## plot(res)
## 


###################################################
### code chunk number 5: DistancePlotControlChannel
###################################################
####################################################################
## Plot of pairwise "distance" between arrays
## distance defined as median absolute difference between arrays for MMU miRNAs
## use log2 of green channel
####################################################################

## levelplot using S4 method for class 'RGList'
## reorder so that outlying arrays are grouped together
res <- levelplot(PalateData[, c(1,5,9,2:4,6:8)],
                 channel="G", group="probe.type",
                 subset=c("MMU miRNAs", "Other miRNAs", "Control", "Empty"),
                 scales = list(rot=c(45, 45)))
print(res)



###################################################
### code chunk number 6: OutlierAssessment
###################################################
outliers <- checkOutliers(PalateData)


###################################################
### code chunk number 7: BoxplotOutliers (eval = FALSE)
###################################################
## boxplot(as.data.frame(t(PalateData$R[outliers$Rout,])))


###################################################
### code chunk number 8: FixOutliers
###################################################

PalateData$R <- fixOutliers(PalateData$R, outliers$Rout, PalateData$genes$Gene)
PalateData$G <- fixOutliers(PalateData$G, outliers$Gout, PalateData$genes$Gene)



###################################################
### code chunk number 9: CheckAndFixMissingValues
###################################################

mvs <- checkMVs(PalateData)
PalateData$Rb <- fixMVs(PalateData$Rb, mvs$Rb.na, PalateData$genes$Gene)
PalateData$Gb <- fixMVs(PalateData$Gb, mvs$Gb.na, PalateData$genes$Gene)
## Three spots with missing backgrounds
## 39875 (1 Rb and 1 Gb)
## 38232 (2 Rb and 2 Gb)
## 40139 (3 Rb and 3 Gb)



###################################################
### code chunk number 10: Filtering
###################################################
reducedSet <- filterArray(PalateData, keep=c("MIR", "LET", "POSCON", "CALIB"),
                          frac=1.1, number=3, reps=4)



###################################################
### code chunk number 11: FilterCheck (eval = FALSE)
###################################################
## ## check
## dim(reducedSet)/4
## ##  239.00   2.25
## ## how many control probes left?
## length(grep("POSCON", reducedSet$genes$Name))
## ## 16
## length(grep("CALI", reducedSet$genes$Name))
## ## 72


###################################################
### code chunk number 12: Normalization
###################################################

####################################################################
## Evaluate different normalization procedures
## 1. none
## 2. median
## 3. loess
## 4. quantile
## 5. VSN
## 6. spike-in VSN
####################################################################

## should just require this??
library("vsn")
## 1. None
ndata.none <- normalizeWithinArrays(reducedSet, method="none")
## 2. Median
ndata.median <- normalizeWithinArrays(reducedSet, method="median")
## 3. Loess
ndata.loess <- normalizeWithinArrays(reducedSet, method="loess")
## 4. Quantile
ndata.quantile <- normalizeBetweenArrays(reducedSet, method="quantile")
## 5. VSN
ndata.vsn.limma <- normalizeVSN(reducedSet)
## NOTE: can also get the above with the following code:
## ndata.vsn <- justvsn(reducedSet, backgroundsubtract=TRUE)
## However, 'ndata.vsn' is an NChannelSet while
##   'ndata.vsn.limma' is an MAList

## 6. Spike-in VSN
idx.control <- which(reducedSet$genes$probe.type=="Control")
spikein.fit <- vsn2(reducedSet[idx.control,], lts.quantile=1, backgroundsubtract=TRUE)
ndata.spikein.vsn <- predict(spikein.fit, newdata=reducedSet)



###################################################
### code chunk number 13: SarkarIntensityPlots
###################################################
####################################################################
## 1. Evaluation using Sarkar et al. 2009 density plots
##    Use RG.MA to convert back to RG values for MALists
##    Use density plot - S4 method for class 'list'
####################################################################

ndata.all <- list(ndata.none, ndata.median, ndata.loess,
                  ndata.quantile, ndata.vsn.limma,
                  ndata.spikein.vsn)
names(ndata.all) <- c("None", "Median", "Loess", "Quantile", "VSN", "Spike-in VSN")

dplot <- densityplot(ndata.all, channel="G", group="probe.type",
                     subset = c("Other miRNAs",   "MMU miRNAs", "Control"),
                     col=rep(1:3, each=3), lty=rep(1:3, 3),
                     par.strip.text=list(cex=0.75),
                     key = list(lines=list(col=rep(1:3, each=3), lty=rep(1:3, 3)),
                       text=list(colnames(ndata.none)), columns=3))
if (require("latticeExtra")) {
  dplot <- useOuterStrips(dplot)
}
plot(dplot)


###################################################
### code chunk number 14: SarkarDistPlots
###################################################

####################################################################
## 2. Sarkar 'Distance' Plot
##    Green channel, all probes
####################################################################

## levelplot using S4 method for class 'list'
res <- levelplot(ndata.all, channel="G", order=c(1,5,9,2:4,6:8),
                 scales = list(rot=c(45, 45)))
print(res)




###################################################
### code chunk number 15: MADvsMedianPlotsRed
###################################################

####################################################################
## 3. Spread (MAD) vs. location (median) of all probes,
##     highlight spike-ins
####################################################################

## Previously did MAD vs median of expression-ratios (M values) across all arrays
## Now doing MAD vs median for RED channel ...
## Either plot may be interesting ...

## Now using S4 method MADvsMedianPlot ...
res <- MADvsMedianPlot(ndata.all, channel="R", group="probe.type",
                 subset=c("MMU miRNAs", "Other miRNAs", "Control"))
print(res)
## Here, maybe quantile looks a little suspect??
## VSN, quantile, and loess are close
## spike-in VSN very little variation and is suspect



###################################################
### code chunk number 16: MADvsMedianPlotsGreen (eval = FALSE)
###################################################
## 
## ####################################################################
## ## Repeat above for control channel
## ####################################################################
## 
## res <- MADvsMedianPlot(ndata.all, channel="G", group="probe.type",
##                        subset=c("MMU miRNAs", "Other miRNAs", "Control"))
## print(res)
## 
## 


###################################################
### code chunk number 17: MAplotsQuantile
###################################################

####################################################################
## MA Plots for
## 1. quantile normalization
## 2. VSN
## 3. unnormalized data
## 4. spike-in VSN
####################################################################

## Quantile
res <- MAplot(ndata.quantile)
print(res)



###################################################
### code chunk number 18: MAplotsVSN (eval = FALSE)
###################################################
## ## VSN from limma
## res <- MAplot(ndata.vsn.limma)
## print(res)
## 


###################################################
### code chunk number 19: MAplotsVSN2 (eval = FALSE)
###################################################
## ## VSN (same as above)
## ## sampleNames(ndata.vsn) <- paste(rep(12:14, each=3), rep(1:3, 3), sep="-")
## res <- MAplot(ndata.vsn)
## print(res)
## 


###################################################
### code chunk number 20: MAplotsNone (eval = FALSE)
###################################################
## ## None
## res <- MAplot(ndata.none)
## print(res)
## 


###################################################
### code chunk number 21: MAplotsSpikeInVSN (eval = FALSE)
###################################################
## ## spike-in VSN from limma
## res <- MAplot(ndata.spikein.vsn)
## print(res)
## 


###################################################
### code chunk number 22: HeatMaps
###################################################

####################################################################
## Heatmaps
####################################################################
## Clusters both rows and columns
heatmap(ndata.quantile$M, col=cm.colors(256), labRow=FALSE)



###################################################
### code chunk number 23: Correlations
###################################################
library("xtable")
xtable(round(cor(ndata.quantile$M, use="complete"), 3),
       caption = "Correlation between arrays after quantile normalization",
       label = "tab:correlations")



###################################################
### code chunk number 24: RedoNormalization
###################################################

########################################################################
## Redo, omiting 021, 033, and 029 (12-1, 13-2, 14-3)
## keep two replicates for each day
## Removal before normalization
########################################################################

## Need to take out "MIRCONTROL" samples now as well
## NOTE: Keeping these in improves correlation between samples on same day
##       Remove prior to calculating whether gene is expressed and DE

####################################################################
## 1. Quantile between, no within
## 2. VSN
####################################################################

## Background correction = 'subtract' by default (all methods)
omit <- which(colnames(reducedSet)%in%c("12-1", "13-2", "14-3"))
ndata <- normalizeBetweenArrays(reducedSet[,-omit], method="quantile")


###################################################
### code chunk number 25: CorrelationsRedData (eval = FALSE)
###################################################
## round(cor(ndata$M, use="complete"), 3)


###################################################
### code chunk number 26: HeatmapsRedData (eval = FALSE)
###################################################
## heatmap(ndata$M, col=cm.colors(256))


###################################################
### code chunk number 27: MVCheck (eval = FALSE)
###################################################
## sum(is.na(ndata$A)) # only 16
## sum(is.na(ndata$M)) # same


###################################################
### code chunk number 28: ImputeMissingValues
###################################################
ndata$M <- imputeKNN(as.matrix(ndata$M), dist="cor")
ndata$A <- imputeKNN(as.matrix(ndata$A), dist="cor")


###################################################
### code chunk number 29: DesignMatrix
###################################################
## Construct the design matrix
design <- data.frame(grp=c(1,1,2,2,3,3),rep=c(1,2,1,2,1,2))
design$grp <- factor(design$grp, labels=c("Day12", "Day13", "Day14"))
mmat <- model.matrix( ~ 0 + design$grp)
colnames(mmat) <- c("Day12", "Day13", "Day14")


###################################################
### code chunk number 30: Contrasts
###################################################
contrast.matrix <- makeContrasts(Day13-Day12, Day14-Day12, Day14-Day13,
                                 levels=mmat)


###################################################
### code chunk number 31: DuplicateProbes
###################################################

## Order data by probes
idx <- order(ndata$genes$Gene)
ndata <- ndata[idx,]
idx.rm <- which(ndata$genes$probe.type=="Control")
ndata <- ndata[-idx.rm,]
## compute correlations between same probes on each chip
corfit <- duplicateCorrelation(ndata, mmat, ndups=4,
                               weights=ndata$weights)



###################################################
### code chunk number 32: Estimates
###################################################
fit <- lmFit(ndata, mmat, ndups=4,
               correlation=corfit$consensus)
fitc <- contrasts.fit(fit, contrast.matrix)
fitc <- eBayes(fitc)


###################################################
### code chunk number 33: ContrastsEstimates
###################################################
## First contrast
top13v12 <- topTable(fitc, coef=1, number=nrow(ndata)/4, adjust="fdr",
                     sort.by="P")
top13v12$FC <- 2^(top13v12$logFC)

sig13v12 <- top13v12[top13v12$adj.P.Val<.05,]
colNames <- c("Name.stem", "probe.type", "FC", "t", "adj.P.Val")
res <- xtable(sig13v12[,colNames],
              digits=c(0,0,0,2,2,3),
              caption="Significantly differentially expressed miRNAs
                       for GD 13 versus 12",
              label="tab:contrast13v12", caption.placement = "top")
print(res, include.rownames=FALSE)


###################################################
### code chunk number 34: OtherContrasts
###################################################
# second contrast
top14v12 <- topTable(fitc, coef=2, number=nrow(ndata)/4, adjust="fdr")
top14v12$FC <- 2^(top14v12$logFC)
sig14v12 <- top14v12[top14v12$adj.P.Val<.05,]

# third contrast
top14v13 <- topTable(fitc, coef=3, number=nrow(ndata)/4, adjust="fdr")
top14v13$FC <- 2^(top14v13$logFC)
sig14v13 <- top14v13[top14v13$adj.P.Val<.05,]


###################################################
### code chunk number 35: VennDiagram
###################################################
res <- decideTests(fitc)
vennDiagram(res, include=c("up","down"),
            counts.col=c("red","green"), cex=1.25)


###################################################
### code chunk number 36: Fstats
###################################################
if (require("multtest")) {
  rawp <- fitc$F.p.value
  BH <-  mt.rawp2adjp(rawp, proc = "BH")
  sum(BH$adjp[,"BH"] < 0.05)
}


###################################################
### code chunk number 37: FstatsHelmert
###################################################
## Helmert contrasts, from contr.helmert ...
contr.helmert(3)
contrast.helmert <- makeContrasts(Day13-Day12, Day14-0.5*Day12-0.5*Day13,
                                 levels=mmat)
fitc.helmert <- contrasts.fit(fit, contrast.helmert)
fitc.helmert <- eBayes(fitc.helmert)
Fstats <- topTable(fitc.helmert, coef=c(1, 2), number=nrow(ndata)/4, adjust="fdr",
                   sort.by="F")
sum(Fstats$adj.P.Val < 0.05)


###################################################
### code chunk number 38: AverageData
###################################################
## average probes for plotting
avedata <- avedups(ndata, ndups=4, spacing=1)
sigFgenes <- Fstats$Gene.ID[which(Fstats$adj.P.Val < 0.05)]
## ssgenes <- unique(c(sig13v12$Gene, sig14v12$Gene, sig14v13$Gene))
## sum(sigFgenes%in%ssgenes) ## all 79 show up in individual lists
mat <- as.matrix(avedata[match(sigFgenes, avedata$genes$Gene), ])
colnames(mat) <- c("GD-12-1", "GD-12-2","GD-13-1", "GD-13-2",
                   "GD-14-1", "GD-14-2")
rownames(mat) <- sigFgenes


###################################################
### code chunk number 39: Clustering
###################################################

if (require("clValid")) {
  ## This creates averages over replicates for each day
  aveExpr <- t(apply(mat, 1, function(x) tapply(x, c(1,1,2,2,3,3), mean)))
  clRes <- clValid(aveExpr, 6, clMethod=c("hierarchical", "diana", "sota","kmeans"),
                   validation=c("internal"), metric="correlation")
  summary(clRes)
}



###################################################
### code chunk number 40: ClustPlot
###################################################
if (exists("clRes")) {
  clusters <- cutree(clRes@clusterObjs$hierarchical, 6)
  ## Scales the average expression values
  aveExpr <- t(scale(t(aveExpr)))
  colnames(aveExpr) <- c("GD-12", "GD-13", "GD-14")
  clustPlot(clusters, aveExpr, 3, 2)
}


###################################################
### code chunk number 41: miRNamesFunc
###################################################
## Function to convert Miltenyi Biotech IDs to standard miR Names
## Specifically extracts MMU (mouse) miRs
miRNames <- function(ids, geneNames, geneIDs) {
    ids.names <- geneNames[which(geneIDs%in%ids)]
    ids.mmu.names <- lapply(strsplit(ids.names, " "), function(x) grep("MMU", x, value=TRUE))
    ids.mmu.names <- unlist(lapply(ids.mmu.names, function(x) gsub("\\;", "", x)))
    ## Convert to standard nomenclature ...
    miRs <- tolower(ids.mmu.names)
    miRs <- gsub("mir", "miR", miRs)
}



###################################################
### code chunk number 42: miRNAsClusterOne
###################################################
## Pull out the MMU specific names
if (exists("clusters")) {
  ids1 <- names(clusters[which(clusters==1)])
} else {
  ids1 <- c("35816", "35861", "35886", "35817", "39256", "38722", "39370",
            "38559", "40185", "35849", "35884", "40069", "39153", "39157",
            "39361", "39299", "35863", "39294", "38316", "39211", "40190",
            "38319", "38995", "35855", "38796", "35899", "39212", "38508",
            "39178", "35889", "38849", "39209")
}
miRs1 <- miRNames(ids1, avedata$genes$Name, avedata$genes$'Gene ID')



###################################################
### code chunk number 43: TargetScanTargets
###################################################

if (require("targetscan.Mm.eg.db")) {

  ## These are 'miRNAAnnDbBimap' - Bi-mappings
  res01 <- miRs1%in%ls(targetscan.Mm.egMIRNA) ## only two false
  miRs1[!res01] ## "mmu-miR-126" "mmu-let-7b*"
  miRs1[!res01] <- c("mmu-miR-126-3p", "mmu-let-7b")
  miRs1 <- unique(miRs1) ## have "mmu-let-7b" twice

  miRs1.list <- mget(miRs1, targetscan.Mm.egMIRNA)
  miRs1.fams <- mget(miRs1, targetscan.Mm.egMIRBASE2FAMILY)
  miRs1.targets <- mget(as.character(miRs1.fams), revmap(targetscan.Mm.egTARGETS))
  targets.tscan <- unique(unlist(miRs1.targets))
  length(targets.tscan)
}



###################################################
### code chunk number 44: miRNATargets
###################################################

####################################################################
## microRNA package
####################################################################

if (require("microRNA")) {
  ## Try identifying targets for miRNAs in cluster one ...
  data(mmTargets)
  targets.miRB <- mmTargets$target[which(mmTargets$name%in%miRs1)]
  targets.miRB <- unique(targets.miRB)
  length(targets.miRB)
  ## target ensembl IDs

  ## head(targets.miRB)  ## Ensembl IDs
  ## head(targets.tscan) ## Entrez gene idenifiers
  ## Convert to common naming for use with GSEA, use Entrez Gene IDs
}



###################################################
### code chunk number 45: IntersectionOfTargets
###################################################

if (require("org.Mm.eg.db")) {
  ## org.Mm.egENSEMBLTRANS   Map Ensembl transcript acession numbers with
  ##                         Entrez Gene identifiers
  idx.miRB <- as.character(targets.miRB)%in%ls(revmap(org.Mm.egENSEMBLTRANS))
  targets.miRB.list <- as.character(targets.miRB)[idx.miRB]
  targets.miRB.entrez <- unlist(mget(targets.miRB.list, revmap(org.Mm.egENSEMBLTRANS)))
  targets.intsect <- intersect(targets.tscan, targets.miRB.entrez)
  length(targets.intsect)
}



###################################################
### code chunk number 46: GSEAClustOne
###################################################

## Steps:
## 1. Define gene universe (a vector of Entrez Gene IDs).
## 2. Select a list of interesting genes (a vector of Entrez Gene ID).
## 3. Create a GOHyperGParams object.
## 4. Outputs and summary.

if (require("GOstats")) {
  selectedEntrezIds <- targets.intsect
  ## Universe =  all entrez gene ids
  entrezUniverse <- unlist(ls(org.Mm.egENSEMBLTRANS))

  hgCutoff <- 0.001
  GOparams <- new("GOHyperGParams",
                  geneIds=selectedEntrezIds,
                  universeGeneIds=entrezUniverse,
                  annotation="org.Mm.eg", ## may need to install org.Mm.eg.db ...
                  ontology="BP",
                  pvalueCutoff=0.001,
                  conditional=TRUE,
                  testDirection="over")
}



###################################################
### code chunk number 47: GSEAReport (eval = FALSE)
###################################################
## if (exists("GOparams")) {
##   hgOver <- hyperGTest(GOparams)
##   class(hgOver)
##   summary(hgOver)
##   ## HTML report of results
##   htmlReport(hgOver, file="hgResult.html")
## }


###################################################
### code chunk number 48: BetaReceptorGenes
###################################################
## Look at GO:0007179 (transforming growth factor beta receptor signaling pathway)
## 1. Find genes
if (require("org.Mm.eg.db")) {
  egIdsAll <- get("GO:0007179", org.Mm.egGO2ALLEGS)
  egIds <- intersect(egIdsAll, selectedEntrezIds)
  length(egIds)
  ## eliminates redundancies (genes w/multiple evidence codes)
}



###################################################
### code chunk number 49: BetaReceptorTargetMiRNAs
###################################################
if (require("targetscan.Mm.eg.db")) {
  ## 2. Find miRNAs which target these genes
  miRs.BetaR.TS <- mget(egIds, targetscan.Mm.egTARGETS)
  miRs.BetaR.fams <- intersect(miRs1.fams, unlist(miRs.BetaR.TS))
  miRs.BetaR.list <- mget(miRs.BetaR.fams, revmap(targetscan.Mm.egMIRBASE2FAMILY))
  miRs.BetaR.mmu <- grep("mmu", unlist(miRs.BetaR.list), value=TRUE)
  ## Now restrict these to just miRs of interest
  miRs.BetaR.clust1 <- intersect(miRs1, miRs.BetaR.mmu)
  length(miRs.BetaR.clust1)

}



###################################################
### code chunk number 50: BRTargetMiRNASeqs
###################################################
## 3. Now look at sequences and seed regions ...
if (require("microRNA")) {
  data(mmSeqs)
  idx.betaR <- which(names(mmSeqs)%in%miRs.BetaR.clust1)
  mmSeqs[idx.betaR]
  table(seedRegions(mmSeqs[idx.betaR]))
}


###################################################
### code chunk number 51: SessionInfo
###################################################
sessionInfo()


