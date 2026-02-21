# Code example from 'STATegRa' vignette. See references/ for full tutorial.

## ----echo=F, message=F, results="asis"----------------------------------------
# this block is invisible
BiocStyle::markdown()
require(STATegRa)
require(Biobase)
require(gridExtra)
require(ggplot2)
g_legend<-function(a.gplot){
    tmp <- ggplot_gtable(ggplot_build(a.gplot))
    leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
    legend <- tmp$grobs[[leg]]
    return(legend)}

## ----eval=F-------------------------------------------------------------------
# library(STATegRa) # Load STATegRa package

## ----eval=F-------------------------------------------------------------------
# help(package="STATegRa") ## Package help
# ?omicsCompAnalysis ## Specific function help

## -----------------------------------------------------------------------------
data("STATegRa_S3")
ls()

## -----------------------------------------------------------------------------
# Block1 - gene expression data
B1 <- createOmicsExpressionSet(Data=Block1.PCA, pData=ed.PCA,
                               pDataDescr=c("classname"))

# Block2 - miRNA expression data
B2 <- createOmicsExpressionSet(Data=Block2.PCA, pData=ed.PCA, 
                               pDataDescr=c("classname"))

## -----------------------------------------------------------------------------
ms <- modelSelection(Input=list(B1, B2), Rmax=3, fac.sel="single%",
                     varthreshold=0.03, center=TRUE, scale=TRUE, 
                     weight=TRUE, plot_common=FALSE, plot_dist=FALSE)

grid.arrange(ms$common$pssq, ms$common$pratios, ncol=2) #switching plot_common=TRUE gives automaticaly these plots

## -----------------------------------------------------------------------------
discoRes <- omicsCompAnalysis(Input=list(B1, B2), Names=c("expr", "mirna"),
                              method="DISCOSCA", Rcommon=2, Rspecific=c(2, 2),
                              center=TRUE, scale=TRUE, weight=TRUE)
jiveRes <- omicsCompAnalysis(Input=list(B1, B2), Names=c("expr", "mirna"),
                             method="JIVE", Rcommon=2, Rspecific=c(2, 2),
                             center=TRUE, scale=TRUE, weight=TRUE)
o2plsRes <- omicsCompAnalysis(Input=list(B1, B2),Names=c("expr", "mirna"),
                              method="O2PLS", Rcommon=2, Rspecific=c(2, 2),
                              center=TRUE, scale=TRUE, weight=TRUE)

## -----------------------------------------------------------------------------
slotNames(discoRes)

## ----results="hide"-----------------------------------------------------------
# Exploring DISCO-SCA (or JIVE) score structure
getScores(discoRes, part="common")
getScores(discoRes, part="distinctive", block="1")
getScores(discoRes, part="distinctive", block="2")

# Exploring O2PLS score structure
getScores(o2plsRes, part="common", block="expr")
getScores(o2plsRes, part="common", block="mirna")
getScores(o2plsRes, part="distinctive", block="1")
getScores(o2plsRes, part="distinctive", block="2")

## -----------------------------------------------------------------------------
# DISCO-SCA plotVAF
getVAF(discoRes)
plotVAF(discoRes)

# JIVE plotVAF
getVAF(jiveRes)
plotVAF(jiveRes)

## -----------------------------------------------------------------------------
# Scatterplot of scores variables associated to common components

# DISCO-SCA
plotRes(object=discoRes, comps=c(1, 2), what="scores", type="common",
        combined=FALSE, block=NULL, color="classname", shape=NULL, labels=NULL,
        background=TRUE, palette=NULL, pointSize=4, labelSize=NULL,
        axisSize=NULL, titleSize=NULL) 

# JIVE
plotRes(object=jiveRes, comps=c(1, 2), what="scores", type="common",
        combined=FALSE, block=NULL, color="classname", shape=NULL, labels=NULL,
        background=TRUE, palette=NULL, pointSize=4, labelSize=NULL,
        axisSize=NULL, titleSize=NULL) 

## -----------------------------------------------------------------------------
# O2PLS 
# Scatterplot of scores variables associated to common components

# Associated to first block
p1 <- plotRes(object=o2plsRes, comps=c(1, 2), what="scores", type="common",
              combined=FALSE, block="expr", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
# Associated to second block
p2 <- plotRes(object=o2plsRes, comps=c(1, 2), what="scores", type="common",
              combined=FALSE, block="mirna", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
# Combine both plots
# g_legend function from
# https://github.com/hadley/ggplot2/wiki/Share-a-legend-between-two-ggplot2-graphs
legend <- g_legend(p1)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             legend, heights=c(6/7, 1/7))

# Combined plot of scores variables assocaited to common components
plotRes(object=o2plsRes, comps=c(1, 1), what="scores", type="common",
        combined=TRUE, block=NULL, color="classname", shape=NULL,
        labels=NULL, background=TRUE, palette=NULL, pointSize=4,
        labelSize=NULL, axisSize=NULL, titleSize=NULL) 

## -----------------------------------------------------------------------------
# DISCO-SCA scores scatterplot associated to individual components

# Associated to first block
p1 <- plotRes(object=discoRes, comps=c(1, 2), what="scores", type="individual",
              combined=FALSE, block="expr", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
# Associated to second block
p2 <- plotRes(object=discoRes, comps=c(1, 2), what="scores", type="individual",
              combined=FALSE, block="mirna", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
# Combine plots
legend <- g_legend(p1)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             legend, heights=c(6/7, 1/7))

# DISCO-SCA scores combined plot for individual components
plotRes(object=discoRes, comps=c(1, 1), what="scores", type="individual",
        combined=TRUE, block=NULL, color="classname", shape=NULL,
        labels=NULL, background=TRUE, palette=NULL, pointSize=4,
        labelSize=NULL, axisSize=NULL, titleSize=NULL)

## -----------------------------------------------------------------------------
# DISCO-SCA plot of scores for common and individual components
p1 <- plotRes(object=discoRes, comps=c(1, 1), what="scores", type="both",
              combined=FALSE, block="expr", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
p2 <- plotRes(object=discoRes, comps=c(1, 1), what="scores", type="both",
              combined=FALSE, block="mirna", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
legend <- g_legend(p1)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             legend, heights=c(6/7, 1/7))

# O2PLS plot of scores for common and individual components
p1 <- plotRes(object=o2plsRes, comps=c(1, 1), what="scores", type="both",
              combined=FALSE, block="expr", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
p2 <- plotRes(object=o2plsRes, comps=c(1, 1), what="scores", type="both",
              combined=FALSE, block="mirna", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
legend <- g_legend(p1)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             legend, heights=c(6/7, 1/7))

## -----------------------------------------------------------------------------
# Loadings plot for common components

# Separately for each block
p1 <- plotRes(object=discoRes, comps=c(1, 2), what="loadings", type="common",
              combined=FALSE, block="expr", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
p2 <- plotRes(object=discoRes, comps=c(1, 2), what="loadings", type="common",
              combined=FALSE, block="mirna", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1), 
             heights=c(6/7, 1/7))

## -----------------------------------------------------------------------------
# Loadings plot for individual components

# Separately for each block
p1 <- plotRes(object=discoRes, comps=c(1, 2), what="loadings", type="individual",
              combined=FALSE, block="expr", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
p2 <- plotRes(object=discoRes, comps=c(1, 2), what="loadings", type="individual",
              combined=FALSE, block="mirna", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1), 
             heights=c(6/7, 1/7))

## -----------------------------------------------------------------------------
p1 <- plotRes(object=discoRes, comps=c(1, 1), what="loadings", type="both",
              combined=FALSE, block="expr", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
p2 <- plotRes(object=discoRes, comps=c(1, 1), what="loadings", type="both",
              combined=FALSE, block="mirna", color="classname", shape=NULL,
              labels=NULL, background=TRUE, palette=NULL, pointSize=4,
              labelSize=NULL, axisSize=NULL, titleSize=NULL)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1), 
             heights=c(6/7, 1/7)) 

## ----warning=FALSE------------------------------------------------------------
# Scores and loading plot for common part. DISCO-SCA
p1 <- plotRes(object=discoRes, comps=c(1, 2), what="both", type="common", 
          combined=FALSE, block="expr", color="classname", shape=NULL,
          labels=NULL, background=TRUE, palette=NULL, pointSize=4,
          labelSize=NULL, axisSize=NULL, titleSize=NULL,
          sizeValues=c(2, 2), shapeValues=c(17, 0))
p2 <- plotRes(object=discoRes, comps=c(1, 2), what="both", type="common", 
          combined=FALSE, block="mirna", color="classname", shape=NULL,
          labels=NULL, background=TRUE, palette=NULL, pointSize=4,
          labelSize=NULL, axisSize=NULL, titleSize=NULL,
          sizeValues=c(2, 2), shapeValues=c(17, 0))
legend <- g_legend(p1)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             legend, heights=c(6/7, 1/7))

# Scores and loadings plot for common part. O2PLS 
p1 <- plotRes(object=o2plsRes, comps=c(1, 2), what="both", type="common", 
          combined=FALSE, block="expr", color="classname", shape=NULL,
          labels=NULL, background=TRUE, palette=NULL, pointSize=4,
          labelSize=NULL, axisSize=NULL, titleSize=NULL,
          sizeValues=c(2, 2), shapeValues=c(17, 0))
p2 <- plotRes(object=o2plsRes, comps=c(1, 2), what="both", type="common", 
          combined=FALSE, block="mirna", color="classname", shape=NULL,
          labels=NULL, background=TRUE, palette=NULL, pointSize=4,
          labelSize=NULL, axisSize=NULL, titleSize=NULL,
          sizeValues=c(2, 2), shapeValues=c(17, 0))
legend <- g_legend(p1)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             legend, heights=c(6/7, 1/7))

# Scores and loadings plot for distinctive part. O2PLS 
p1 <- plotRes(object=o2plsRes, comps=c(1, 2), what="both", type="individual", 
          combined=FALSE, block="expr", color="classname", shape=NULL,
          labels=NULL, background=TRUE, palette=NULL, pointSize=4,
          labelSize=NULL, axisSize=NULL, titleSize=NULL,
          sizeValues=c(2, 2), shapeValues=c(17, 0))
p2 <- plotRes(object=o2plsRes, comps=c(1, 2), what="both", type="individual", 
          combined=FALSE, block="mirna", color="classname", shape=NULL,
          labels=NULL, background=TRUE, palette=NULL, pointSize=4,
          labelSize=NULL, axisSize=NULL, titleSize=NULL,
          sizeValues=c(2, 2), shapeValues=c(17, 0))
legend <- g_legend(p1)
grid.arrange(arrangeGrob(p1+theme(legend.position="none"),
                         p2+theme(legend.position="none"), nrow=1),
             legend, heights=c(6/7, 1/7))

## ----echo=F, message=F--------------------------------------------------------
# clear the environment before starting the omicsClustering example
rm(list=ls())

## -----------------------------------------------------------------------------
data("STATegRa_S1")
ls()

## -----------------------------------------------------------------------------
# Block1 - Expression data
mRNA.ds <- createOmicsExpressionSet(Data=Block1, pData=ed, pDataDescr=c("classname"))
# Block2 - miRNA expression data
miRNA.ds <- createOmicsExpressionSet(Data=Block2, pData=ed, pDataDescr=c("classname"))

## -----------------------------------------------------------------------------
# Create Gene-gene distance computed through mRNA data
bioDistmRNA <- bioDistclass(name="mRNAbymRNA",
                            distance=cor(t(exprs(mRNA.ds)),
                                         method="spearman"),
                            map.name="id",
                            map.metadata=list(),
                            params=list())

## -----------------------------------------------------------------------------
data(STATegRa_S2)
ls()

## -----------------------------------------------------------------------------
MAP.SYMBOL <- bioMap(name = "Symbol-miRNA",
                     metadata = list(type_v1="Gene", type_v2="miRNA",
                                     source_database="targetscan.Hs.eg.db",
                                     data_extraction="July2014"),
                     map=mapdata)

## -----------------------------------------------------------------------------
bioDistmiRNA <- bioDist(referenceFeatures=rownames(Block1),     
                        reference="Var1",
                        mapping=MAP.SYMBOL,
                        surrogateData=miRNA.ds, 
                        referenceData=mRNA.ds, 
                        maxitems=2,
                        selectionRule="sd",
                        expfac=NULL,
                        aggregation="sum",
                        distance="spearman",
                        noMappingDist=0,
                        filtering=NULL,
                        name="mRNAbymiRNA")

## -----------------------------------------------------------------------------
bioDistList <- list(bioDistmRNA, bioDistmiRNA)

## -----------------------------------------------------------------------------
sample.weights <- matrix(0, 4, 2)
sample.weights[, 1] <- c(0, 0.33, 0.67, 1)
sample.weights[, 2] <- c(1, 0.67, 0.33, 0)
sample.weights

## -----------------------------------------------------------------------------
bioDistWList <- bioDistW(referenceFeatures=rownames(Block1),
                         bioDistList=bioDistList,
                         weights=sample.weights)
length(bioDistWList)

## ----warning=F----------------------------------------------------------------
bioDistWPlot(referenceFeatures=rownames(Block1),
             listDistW=bioDistWList,
             method.cor="spearman")

## -----------------------------------------------------------------------------
IDH1.F <- bioDistFeature(Feature="IDH1",
                         listDistW=bioDistWList,
                         threshold.cor=0.7)

## ----message=F----------------------------------------------------------------
bioDistFeaturePlot(data=IDH1.F)

## ----echo=F, message=F--------------------------------------------------------
# clear the environment before starting the omicsNPC example
rm(list=ls())

## -----------------------------------------------------------------------------
data("TCGA_BRCA_Batch_93")
ls()

## ----results='hide'-----------------------------------------------------------
exprs(TCGA_BRCA_Data$RNAseq) # displays the RNAseq data
exprs(TCGA_BRCA_Data$RNAseqV2) # displays the RNAseqV2 data
exprs(TCGA_BRCA_Data$Microarray) # displays the Exp-Gene data

## ----results='hide'-----------------------------------------------------------
pData(TCGA_BRCA_Data$RNAseq) # class of RNAseq samples
pData(TCGA_BRCA_Data$RNAseqV2) # class of RNAseqV2 samples
pData(TCGA_BRCA_Data$Microarray) # class of Exp-Gene samples

## -----------------------------------------------------------------------------
dataTypes <- c("count", "count", "continuous")

## -----------------------------------------------------------------------------
combMethods <- c("Fisher", "Liptak", "Tippett")

## -----------------------------------------------------------------------------
numPerms <- 1000

## -----------------------------------------------------------------------------
numCores <- 1

## -----------------------------------------------------------------------------
verbose <- TRUE

## -----------------------------------------------------------------------------
results <- omicsNPC(dataInput=TCGA_BRCA_Data, dataTypes=dataTypes,
                    combMethods=combMethods, numPerms=numPerms,
                    numCores=numCores, verbose=verbose)

