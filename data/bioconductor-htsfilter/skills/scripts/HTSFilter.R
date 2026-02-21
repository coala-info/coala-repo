# Code example from 'HTSFilter' vignette. See references/ for full tutorial.

## ----fig.align = "center", echo=FALSE-----------------------------------------
options(rmarkdown.html_vignette.check_title = FALSE)

## ----loadingPackages, message=FALSE, fig.cap="Histogram of log transformed counts from the Sultan data. This illustrates the large number of genes with very small counts as well as the large heterogeneity in counts observed."----
library(HTSFilter)
library(edgeR)
library(DESeq2)
data("sultan")
hist(log(exprs(sultan)+1), col="grey", breaks=25, main="", 
  xlab="Log(counts+1)")
pData(sultan)
dim(sultan)

## ----matrix, fig.cap="Global Jaccard index for the Sultan data. The index is calculated for a variety of threshold values after TMM normalization, with a loess curve (blue line) superposed and data-based threshold values (red cross and red dotted line) equal to 11.764."----
mat <- exprs(sultan)
conds <- as.character(pData(sultan)$cell.line)

## Only 25 tested thresholds to reduce computation time
filter <- HTSFilter(mat, conds, s.min=1, s.max=200, s.len=25)
mat <- filter$filteredData
dim(mat)
dim(filter$removedData)

## ----refilter, fig.cap="HTSFilter on pre-filtered Sultan data. (left) The global Jaccard index on the pre-filtered data is calculated for a variety of threshold values after TMM normalization, with a loess curve (blue line) superposed and data-based threshold values (red cross and red dotted line) equal to 1.64. (right) Histogram of the re-filtered data after applying HTSFilter."----
par(mfrow = c(1,2), mar = c(4,4,2,2))
filter.2 <- HTSFilter(mat, conds, s.len=25)
dim(filter.2$removedData)
hist(log(filter.2$filteredData+1), col="grey", breaks=25, main="", 
  xlab="Log(counts+1)")

## ----dge----------------------------------------------------------------------
dge <- DGEList(counts=exprs(sultan), group=conds)
dge <- calcNormFactors(dge)
dge <- estimateDisp(dge)
et <- exactTest(dge)
et <- HTSFilter(et, DGEList=dge, s.len=25, plot=FALSE)$filteredData
dim(et)
class(et)
topTags(et)

## ----dgetoptags---------------------------------------------------------------
topTags(et)

## ----dge2---------------------------------------------------------------------
design <- model.matrix(~conds)
dge <- DGEList(counts=exprs(sultan), group=conds)
dge <- calcNormFactors(dge)
dge <- estimateDisp(dge, design)
fit <- glmFit(dge,design)
lrt <- glmLRT(fit,coef=2)
lrt <- HTSFilter(lrt, DGEGLM=fit, s.len=25, plot=FALSE)$filteredData
dim(lrt)
class(lrt)

## ----dge2toptags--------------------------------------------------------------
topTags(lrt)

## ----cds2---------------------------------------------------------------------
conds <- gsub(" ", ".", conds)
dds <- DESeqDataSetFromMatrix(countData = exprs(sultan),
                              colData = data.frame(cell.line = factor(conds)),
                              design = ~ cell.line)
dds <- DESeq(dds)
filter <- HTSFilter(dds, s.len=25, plot=FALSE)$filteredData
class(filter)
dim(filter)
res <- results(filter, independentFiltering=FALSE)
head(res)

## ----ses2, eval=FALSE---------------------------------------------------------
# library(EDASeq)
# ses <- newSeqExpressionSet(exprs(sultan),
#        phenoData=pData(sultan))
# ses.norm <- betweenLaneNormalization(ses, which="full")

## ----ses3, eval=FALSE---------------------------------------------------------
# filter <- HTSFilter(counts(ses.norm), conds, s.len=25, norm="none",
#           plot=FALSE)
# head(filter$on)
# table(filter$on)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

