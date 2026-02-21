# Code example from 'pipeComp_dea' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(BiocStyle)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
  library(pipeComp)
  library(S4Vectors)
})

evaluateDEA <- function(dea, truth=NULL, th=c(0.01,0.05,0.1)){
  ## we make sure that the column names of `dea` are standard:
  dea <- pipeComp:::.homogenizeDEA(dea)
  ## within Pipecomp, the truth should be passed along with the `dea` object, so
  ## we retrieve it here:
  if(is.null(truth)) truth <- metadata(dea)$truth
  dea <- cbind(dea, truth[row.names(dea),])
  ## we get rid of genes for which the truth is unknown:
  dea <- dea[!is.na(dea$expected.beta),]
  ## comparison of estimated and expected log2 folchanges:
  res <- c(logFC.pearson=cor(dea$logFC, dea$expected.beta, use = "pairwise"),
           logFC.spearman=cor(dea$logFC, dea$expected.beta, 
                              use = "pairwise", method="spearman"),
           logFC.mad=median(abs(dea$logFC-dea$expected.beta),na.rm=TRUE),
           ntested=sum(!is.na(dea$PValue) & !is.na(dea$FDR)))
  ## evaluation of singificance calls
  names(th) <- th
  res2 <- t(vapply( th, FUN.VALUE=vector(mode="numeric", length=6), 
                    FUN=function(x){
    ## for each significance threshold, calculate the various metrics
    called=sum(dea$FDR<x,na.rm=TRUE)
    P <- sum(dea$isDE)
    TP <- sum(dea$FDR<x & dea$isDE, na.rm=TRUE)
    c( TP=TP, FP=called-TP, TPR=TP/P, PPV=TP/called, FDR=1-TP/called, 
       FPR=(P-TP)/sum(!dea$isDE) )
  }))
  res2 <- cbind(threshold=as.numeric(row.names(res2)), as.data.frame(res2))
  row.names(res2) <- NULL
  list(logFC=res, significance=res2)
}

## -----------------------------------------------------------------------------
# we build a random DEA dataframe and truth:
dea <- data.frame( row.names=paste0("gene",1:10), logFC=rnorm(10) )
dea$PValue <- dea$FDR <- c(2:8/100, 0.2, 0.5, 1)
truth <- data.frame( row.names=paste0("gene",1:10), expected.beta=rnorm(10),
                    isDE=rep(c(TRUE,FALSE,TRUE,FALSE), c(3,1,2,4)) )
evaluateDEA(dea, truth)

## -----------------------------------------------------------------------------
step.filtering <- function(x, filt, minCount=10){
  # we apply the function `filt` to `x` with the parameter `minCount`
  get(filt)(x, minCount=minCount)
}

## -----------------------------------------------------------------------------
step.sva <- function(x, sva.method, k=1){
  # we create the model.matrix:
  mm <- stats::model.matrix(~condition, data=as.data.frame(colData(x)))
  # we apply the function `sva.method` to `x` with the parameter `k`
  get(sva.method)(x, k=k, mm=mm)
}

## -----------------------------------------------------------------------------
step.dea <- function(x, dea.method){
  # run the DEA method, and transform the results into a DataFrame:
  x2 <- DataFrame(get(dea.method)(x,mm))
  # attach the truth to the results:
  metadata(x2)$truth <- metadata(x)$truth
  x2
}

## -----------------------------------------------------------------------------
pip <- PipelineDefinition( list( filtering=step.filtering,
                                          sva=step.sva,
                                          dea=step.dea )
                                    )
pip

## -----------------------------------------------------------------------------
stepFn(pip, step="dea", type="evaluation") <- evaluateDEA
pip

## -----------------------------------------------------------------------------
def.filter <- function(x, minCounts=10){
  library(edgeR)
  minCounts <- as.numeric(minCounts)
  x[filterByExpr(assay(x), model.matrix(~x$condition), min.count=minCounts),]
}

sva.svaseq <- function(x, k, mm){
  k <- as.integer(k)
  if(k==0) return(x)
  library(sva)
  # run SVA
  sv <- svaseq(assay(x), mod=mm, n.sv=k)
  if(sv$n.sv==0) return(x)
  # rename the SVs and add them to the colData of `x`:
  colnames(sv$sv) <- paste0("SV", seq_len(ncol(sv$sv)))
  colData(x) <- cbind(colData(x), sv$sv)
  x
}

dea.edgeR <- function(x, mm){
  library(edgeR)
  dds <- calcNormFactors(DGEList(assay(x)))
  dds <- estimateDisp(dds, mm)
  fit <- glmFit(dds, mm)
  as.data.frame(topTags(glmLRT(fit, "condition"), Inf))
}

# we also define a function not doing anything:
none <- function(x, ...) x

## -----------------------------------------------------------------------------
alternatives <- list(
  filt=c("none","def.filter"),
  minCount=10,
  sva.method=c("none","sva.svaseq"),
  k=1:2,
  dea.method="dea.edgeR"
)

## ----eval=FALSE---------------------------------------------------------------
# datasets <- list.files("path/to/datasets", pattern="rds$", full.names=TRUE)
# names(datasets) <- paste0("dataset",1:2)
# datasets <- lapply(datasets, readRDS)

## ----eval=FALSE---------------------------------------------------------------
# # not run
# stepFn(pip, type="initiation") <- function(x){
#   if(is.character(x) && length(x)==1) x <- readRDS(x)
#   x
# }

## ----eval=FALSE---------------------------------------------------------------
# res <- runPipeline( datasets, alternatives, pipelineDef=pip, nthreads=4 )
# 
# lapply(res$evaluation$dea, head)

## -----------------------------------------------------------------------------
data("exampleDEAresults", package = "pipeComp")
res <- exampleDEAresults

## -----------------------------------------------------------------------------
plotElapsed(res, agg.by="sva.method")
evalHeatmap( res, what=c("TPR","FDR","logFC.pearson"), 
             agg.by=c("sva.method", "dea.method"), row_split = "sva.method" )

## -----------------------------------------------------------------------------
evalHeatmap( res, what=c("TPR","FDR"), agg.by=c("sva.method", "dea.method"), 
             row_split="sva.method", filterExpr=threshold==0.05 )

## ----fig.width=9, fig.height=4------------------------------------------------
library(ggplot2)
dea_evalPlot_curve(res, agg.by=c("sva.method","dea.method"), 
                   colourBy="sva.method", shapeBy="dea.method")
dea_evalPlot_curve(res, agg.by=c("sva.method")) + 
  ggtitle("SVA methods, averaging across DEA methods")

## ----fig.height=7, fig.width=5------------------------------------------------
evalHeatmap(res, what=c("TPR","FDR"), agg.by=c("sva.method","k"), 
                 show_column_names=TRUE, anno_legend = FALSE, 
                 row_split="sva.method", filterExpr=threshold==0.05 )

