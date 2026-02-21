# Code example from 'GSVA' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
options(width=80)
knitr::opts_chunk$set(collapse=TRUE,
                      message=FALSE,
                      comment="")

## ----library_install, message=FALSE, cache=FALSE, eval=FALSE------------------
# install.packages("BiocManager")
# BiocManager::install("GSVA")

## ----load_library, message=FALSE, warning=FALSE, cache=FALSE------------------
library(GSVA)

## -----------------------------------------------------------------------------
p <- 10000 ## number of genes
n <- 30    ## number of samples
## simulate expression values from a standard Gaussian distribution
X <- matrix(rnorm(p*n), nrow=p,
            dimnames=list(paste0("g", 1:p), paste0("s", 1:n)))
X[1:5, 1:5]

## -----------------------------------------------------------------------------
## sample gene set sizes
gs <- as.list(sample(10:100, size=100, replace=TRUE))
## sample gene sets
gs <- lapply(gs, function(n, p)
                   paste0("g", sample(1:p, size=n, replace=FALSE)), p)
names(gs) <- paste0("gs", 1:length(gs))

## -----------------------------------------------------------------------------
gsvaPar <- gsvaParam(X, gs)
gsvaPar

## -----------------------------------------------------------------------------
gsva.es <- gsva(gsvaPar, verbose=FALSE)
dim(gsva.es)
gsva.es[1:5, 1:5]

## -----------------------------------------------------------------------------
class(gs)
length(gs)
head(lapply(gs, head))

## ----message=FALSE------------------------------------------------------------
library(org.Hs.eg.db)

goannot <- select(org.Hs.eg.db, keys=keys(org.Hs.eg.db), columns="GO")
head(goannot)
genesbygo <- split(goannot$ENTREZID, goannot$GO)
length(genesbygo)
head(genesbygo)

## ----message=FALSE------------------------------------------------------------
library(GSEABase)
library(GSVAdata)

data(c2BroadSets)
class(c2BroadSets)
c2BroadSets

## ----eval=FALSE---------------------------------------------------------------
# library(GSEABase)
# library(GSVA)
# 
# URL <- "https://data.broadinstitute.org/gsea-msigdb/msigdb/release/2024.1.Hs/c7.immunesigdb.v2024.1.Hs.symbols.gmt"
# c7.genesets <- readGMT(URL)

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
library(GSEABase)
library(GSVA)

gmtfname <- system.file("extdata", "c7.immunesigdb.v2024.1.Hs.symbols.gmt.gz",
                        package="GSVAdata")
c7.genesets <- readGMT(gmtfname)
c7.genesets

## ----eval=FALSE---------------------------------------------------------------
# gsvaAnnotation(c7.genesets) <- SymbolIdentifier("org.Hs.eg.db")

## ----message=FALSE, error=TRUE------------------------------------------------
try({
fname <- system.file("extdata", "c2.subsetdups.v7.5.symbols.gmt.gz",
                     package="GSVAdata")
c2.dupgenesets <- getGmt(fname, geneIdType=SymbolIdentifier())
c2.dupgenesets
})

## -----------------------------------------------------------------------------
c2.dupgenesets <- readGMT(fname, geneIdType=SymbolIdentifier())
c2.dupgenesets
any(duplicated(names(c2.dupgenesets)))

## ----message=FALSE------------------------------------------------------------
library(Biobase)

data(commonPickrellHuang)

stopifnot(identical(featureNames(huangArrayRMAnoBatchCommon_eset),
                    featureNames(pickrellCountsArgonneCQNcommon_eset)))
stopifnot(identical(sampleNames(huangArrayRMAnoBatchCommon_eset),
                    sampleNames(pickrellCountsArgonneCQNcommon_eset)))

## ----echo=FALSE---------------------------------------------------------------
## until the updated GSVAdata goes through the build system
## remove duplicated rows
fnames <- featureNames(huangArrayRMAnoBatchCommon_eset)
mask <- duplicated(fnames)
huangArrayRMAnoBatchCommon_eset <- huangArrayRMAnoBatchCommon_eset[!mask, ]
pickrellCountsArgonneCQNcommon_eset <- pickrellCountsArgonneCQNcommon_eset[!mask, ]

## -----------------------------------------------------------------------------
canonicalC2BroadSets <- c2BroadSets[c(grep("^KEGG", names(c2BroadSets)),
                                      grep("^REACTOME", names(c2BroadSets)),
                                      grep("^BIOCARTA", names(c2BroadSets)))]
canonicalC2BroadSets

## -----------------------------------------------------------------------------
data(genderGenesEntrez)

MSY <- GeneSet(msYgenesEntrez, geneIdType=EntrezIdentifier(),
               collectionType=BroadCollection(category="c2"),
               setName="MSY")
MSY
XiE <- GeneSet(XiEgenesEntrez, geneIdType=EntrezIdentifier(),
               collectionType=BroadCollection(category="c2"),
               setName="XiE")
XiE

canonicalC2BroadSets <- GeneSetCollection(c(canonicalC2BroadSets, MSY, XiE))
canonicalC2BroadSets

## ----results="hide"-----------------------------------------------------------
huangPar <- gsvaParam(huangArrayRMAnoBatchCommon_eset, canonicalC2BroadSets,
                      minSize=5, maxSize=500)
esmicro <- gsva(huangPar)
pickrellPar <- gsvaParam(pickrellCountsArgonneCQNcommon_eset,
                         canonicalC2BroadSets, minSize=5, maxSize=500,
                         kcdf="Poisson")
esrnaseq <- gsva(pickrellPar)

## -----------------------------------------------------------------------------
library(edgeR)

lcpms <- cpm(exprs(pickrellCountsArgonneCQNcommon_eset), log=TRUE)

## -----------------------------------------------------------------------------
genecorrs <- sapply(1:nrow(lcpms),
                    function(i, expmicro, exprnaseq)
                      cor(expmicro[i, ], exprnaseq[i, ], method="spearman"),
                    exprs(huangArrayRMAnoBatchCommon_eset), lcpms)
names(genecorrs) <- rownames(lcpms)

## -----------------------------------------------------------------------------
pwycorrs <- sapply(1:nrow(esmicro),
                   function(i, esmicro, esrnaseq)
                     cor(esmicro[i, ], esrnaseq[i, ], method="spearman"),
                   exprs(esmicro), exprs(esrnaseq))
names(pwycorrs) <- rownames(esmicro)

## ----compcorrs, echo=FALSE, height=500, width=1000, fig.cap="Comparison of correlation values of gene and pathway expression profiles derived from microarray and RNA-seq data."----
par(mfrow=c(1, 2), mar=c(4, 5, 3, 2))
hist(genecorrs, xlab="Spearman correlation",
     main="Gene level\n(RNA-seq log-CPMs vs microarray RMA)",
     xlim=c(-1, 1), col="grey", las=1)
hist(pwycorrs, xlab="Spearman correlation",
     main="Pathway level\n(GSVA enrichment scores)",
     xlim=c(-1, 1), col="grey", las=1)

## ----compsexgenesets, echo=FALSE, height=500, width=1000, fig.cap="Comparison of GSVA enrichment scores obtained from microarray and RNA-seq data for two gene sets formed by genes with sex-specific expression."----
par(mfrow=c(1, 2))
rmsy <- cor(exprs(esrnaseq)["MSY", ], exprs(esmicro)["MSY", ])
plot(exprs(esrnaseq)["MSY", ], exprs(esmicro)["MSY", ],
     xlab="GSVA scores RNA-seq", ylab="GSVA scores microarray",
     main=sprintf("MSY R=%.2f", rmsy), las=1, type="n")
fit <- lm(exprs(esmicro)["MSY", ] ~ exprs(esrnaseq)["MSY", ])
abline(fit, lwd=2, lty=2, col="grey")
maskPickrellFemale <- pickrellCountsArgonneCQNcommon_eset$Gender == "Female"
maskHuangFemale <- huangArrayRMAnoBatchCommon_eset$Gender == "Female"
points(exprs(esrnaseq["MSY", maskPickrellFemale]),
       exprs(esmicro)["MSY", maskHuangFemale],
       col="red", pch=21, bg="red", cex=1)
maskPickrellMale <- pickrellCountsArgonneCQNcommon_eset$Gender == "Male"
maskHuangMale <- huangArrayRMAnoBatchCommon_eset$Gender == "Male"
points(exprs(esrnaseq)["MSY", maskPickrellMale],
       exprs(esmicro)["MSY", maskHuangMale],
       col="blue", pch=21, bg="blue", cex=1)
legend("topleft", c("female", "male"), pch=21, col=c("red", "blue"),
       pt.bg=c("red", "blue"), inset=0.01)
rxie <- cor(exprs(esrnaseq)["XiE", ], exprs(esmicro)["XiE", ])
plot(exprs(esrnaseq)["XiE", ], exprs(esmicro)["XiE", ],
     xlab="GSVA scores RNA-seq", ylab="GSVA scores microarray",
     main=sprintf("XiE R=%.2f", rxie), las=1, type="n")
fit <- lm(exprs(esmicro)["XiE", ] ~ exprs(esrnaseq)["XiE", ])
abline(fit, lwd=2, lty=2, col="grey")
points(exprs(esrnaseq["XiE", maskPickrellFemale]),
       exprs(esmicro)["XiE", maskHuangFemale],
       col="red", pch=21, bg="red", cex=1)
points(exprs(esrnaseq)["XiE", maskPickrellMale],
       exprs(esmicro)["XiE", maskHuangMale],
       col="blue", pch=21, bg="blue", cex=1)
legend("topleft", c("female", "male"), pch=21, col=c("red", "blue"),
       pt.bg=c("red", "blue"), inset=0.01)

## -----------------------------------------------------------------------------
data(gbm_VerhaakEtAl)
gbm_eset
head(featureNames(gbm_eset))
table(gbm_eset$subtype)
data(brainTxDbSets)
lengths(brainTxDbSets)
lapply(brainTxDbSets, head)

## ----results="hide"-----------------------------------------------------------
gbmPar <- gsvaParam(gbm_eset, brainTxDbSets, maxDiff=FALSE)
gbm_es <- gsva(gbmPar)

## ----gbmSignature, height=500, width=700, fig.cap="Heatmap of GSVA scores for cell-type brain signatures from murine models (y-axis) across GBM samples grouped by GBM subtype."----
library(RColorBrewer)
subtypeOrder <- c("Proneural", "Neural", "Classical", "Mesenchymal")
sampleOrderBySubtype <- sort(match(gbm_es$subtype, subtypeOrder),
                             index.return=TRUE)$ix
subtypeXtable <- table(gbm_es$subtype)
subtypeColorLegend <- c(Proneural="red", Neural="green",
                        Classical="blue", Mesenchymal="orange")
geneSetOrder <- c("astroglia_up", "astrocytic_up", "neuronal_up",
                  "oligodendrocytic_up")
geneSetLabels <- gsub("_", " ", geneSetOrder)
hmcol <- colorRampPalette(brewer.pal(10, "RdBu"))(256)
hmcol <- hmcol[length(hmcol):1]

heatmap(exprs(gbm_es)[geneSetOrder, sampleOrderBySubtype], Rowv=NA,
        Colv=NA, scale="row", margins=c(3,5), col=hmcol,
        ColSideColors=rep(subtypeColorLegend[subtypeOrder],
                          times=subtypeXtable[subtypeOrder]),
        labCol="", gbm_es$subtype[sampleOrderBySubtype],
        labRow=paste(toupper(substring(geneSetLabels, 1,1)),
                     substring(geneSetLabels, 2), sep=""),
        cexRow=2, main=" \n ")
par(xpd=TRUE)
text(0.23,1.21, "Proneural", col="red", cex=1.2)
text(0.36,1.21, "Neural", col="green", cex=1.2)
text(0.47,1.21, "Classical", col="blue", cex=1.2)
text(0.62,1.21, "Mesenchymal", col="orange", cex=1.2)
mtext("Gene sets", side=4, line=0, cex=1.5)
mtext("Samples          ", side=1, line=4, cex=1.5)

## -----------------------------------------------------------------------------
data(geneprotExpCostaEtAl2021)
se <- geneExpCostaEtAl2021
se

## -----------------------------------------------------------------------------
gsvaAnnotation(se) <- EntrezIdentifier("org.Hs.eg.db")

## -----------------------------------------------------------------------------
colData(se)
table(colData(se))

## ----genelevelmds, message=FALSE, warning=FALSE, echo=TRUE, small.mar=TRUE, fig.height=4, fig.width=4, dpi=100, fig.cap="Gene-level exploration. Multidimensional scaling (MDS) plot at gene level. Red corresponds to `FIR=yes` and blue to `FIR=no`, while circles and squares correspond, respectively, to female and male neonates."----
library(limma)

fircolor <- c(no="skyblue", yes="darkred")
sexpch <- c(female=19, male=15)
plotMDS(assay(se), col=fircolor[se$FIR], pch=sexpch[se$Sex])

## -----------------------------------------------------------------------------
innatepat <- c("NKCELL_VS_.+_UP", "MAST_CELL_VS_.+_UP",
               "EOSINOPHIL_VS_.+_UP", "BASOPHIL_VS_.+_UP",
               "MACROPHAGE_VS_.+_UP", "NEUTROPHIL_VS_.+_UP")
innatepat <- paste(innatepat, collapse="|")
innategsets <- names(c7.genesets)[grep(innatepat, names(c7.genesets))]
length(innategsets)

adaptivepat <- c("CD4_TCELL_VS_.+_UP", "CD8_TCELL_VS_.+_UP", "BCELL_VS_.+_UP")
adaptivepat <- paste(adaptivepat, collapse="|")
adaptivegsets <- names(c7.genesets)[grep(adaptivepat, names(c7.genesets))]
excludepat <- c("NAIVE", "LUPUS", "MYELOID")
excludepat <- paste(excludepat, collapse="|")
adaptivegsets <- adaptivegsets[-grep(excludepat, adaptivegsets)]
length(adaptivegsets)

c7.genesets.filt <- c7.genesets[c(innategsets, adaptivegsets)]
length(c7.genesets.filt)

## -----------------------------------------------------------------------------
gsvapar <- gsvaParam(se, c7.genesets.filt, assay="logCPM", minSize=5,
                     maxSize=300)

## -----------------------------------------------------------------------------
es <- gsva(gsvapar)
es

## -----------------------------------------------------------------------------
assayNames(se)
assayNames(es)
assay(es)[1:3, 1:3]

## -----------------------------------------------------------------------------
head(lapply(geneSets(es), head))

## -----------------------------------------------------------------------------
head(geneSetSizes(es))

## ----pathwaylevelmds, message=FALSE, warning=FALSE, echo=TRUE, small.mar=TRUE, fig.height=4, fig.width=4, dpi=100, fig.cap="Pathway-level exploration. Multidimensional scaling (MDS) plot at pathway level. Red corresponds to `FIR=yes` and blue to `FIR=no`, while circles and squares correspond, respectively, to female and male neonates."----
plotMDS(assay(es), col=fircolor[es$FIR], pch=sexpch[es$Sex])

## ----message=FALSE, warning=FALSE---------------------------------------------
library(sva)
library(limma)

## build design matrix of the model to which we fit the data
mod <- model.matrix(~ FIR, colData(es))
## build design matrix of the corresponding null model
mod0 <- model.matrix(~ 1, colData(es))
## estimate surrogate variables (SVs) with SVA
sv <- sva(assay(es), mod, mod0)
## add SVs to the design matrix of the model of interest
mod <- cbind(mod, sv$sv)
## fit linear models
fit <- lmFit(assay(es), mod)
## calculate moderated t-statistics using the robust regime
fit.eb <- eBayes(fit, robust=TRUE)
## summarize the extent of differential expression at 5% FDR
res <- decideTests(fit.eb)
summary(res)

## ----esstdevxgssize, message=FALSE, warning=FALSE, echo=TRUE, small.mar=TRUE, fig.height=4, fig.width=4, dpi=100, fig.cap="Pathway-level differential expression analysis. Residual standard deviation of GSVA scores as a function of gene set size. Larger gene sets tend to have higher precision."----
gssizes <- geneSetSizes(es)
plot(sqrt(gssizes), sqrt(fit.eb$sigma), xlab="Sqrt(gene sets sizes)",
          ylab="Sqrt(standard deviation)", las=1, pch=".", cex=4)
lines(lowess(sqrt(gssizes), sqrt(fit.eb$sigma)), col="red", lwd=2)

## -----------------------------------------------------------------------------
fit.eb.trend <- eBayes(fit, robust=TRUE, trend=gssizes)
res <- decideTests(fit.eb.trend)
summary(res)

## -----------------------------------------------------------------------------
tt <- topTable(fit.eb.trend, coef=2, n=Inf)
DEpwys <- rownames(tt)[tt$adj.P.Val <= 0.05]
length(DEpwys)
head(DEpwys)

## ----heatmapdepwys, message=FALSE, warning=FALSE, echo=TRUE, fig.height=8, fig.width=10, dpi=100, fig.cap="Pathway-level signature of FIR. Heatmap of GSVA enrichment scores from pathways being called DE with 5% FDR between FIR-affected and unaffected neonates."----
## get DE pathway GSVA enrichment scores, removing the covariates effect
DEpwys_es <- removeBatchEffect(assay(es[DEpwys, ]),
                               covariates=mod[, 2:ncol(mod)],
                               design=mod[, 1:2])
## cluster samples
sam_col_map <- fircolor[es$FIR]
names(sam_col_map) <- colnames(DEpwys_es)
sampleClust <- hclust(as.dist(1-cor(DEpwys_es, method="spearman")),
                      method="complete")

## cluster pathways
gsetClust <- hclust(as.dist(1-cor(t(DEpwys_es), method="pearson")),
                    method="complete")

## annotate pathways whether they are involved in the innate or in
## the adaptive immune response
labrow <- rownames(DEpwys_es)
mask <- rownames(DEpwys_es) %in% innategsets
labrow[mask] <- paste("(INNATE)", labrow[mask], sep="_")
mask <- rownames(DEpwys_es) %in% adaptivegsets
labrow[mask] <- paste("(ADAPTIVE)", labrow[mask], sep="_")
labrow <- gsub("_", " ", gsub("GSE[0-9]+_", "", labrow))

## pathway expression color scale from blue (low) to red (high)
library(RColorBrewer)
pwyexpcol <- colorRampPalette(brewer.pal(10, "RdBu"))(256)
pwyexpcol <- pwyexpcol[length(pwyexpcol):1]

## generate heatmap
heatmap(DEpwys_es, ColSideColors=fircolor[es$FIR], xlab="Samples",
        ylab="Pathways", margins=c(2, 20), labCol="", labRow=labrow,
        col=pwyexpcol, scale="row", Colv=as.dendrogram(sampleClust),
        Rowv=as.dendrogram(gsetClust))

## ----eval=FALSE---------------------------------------------------------------
# res <- igsva()

## ----session_info, cache=FALSE------------------------------------------------
sessionInfo()

