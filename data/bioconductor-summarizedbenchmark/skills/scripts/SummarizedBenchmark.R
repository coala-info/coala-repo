# Code example from 'SummarizedBenchmark' vignette. See references/ for full tutorial.

## ----echo=FALSE, include=FALSE---------------------------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      cache = TRUE,
                      dev = "png",
                      message = FALSE,
                      error = FALSE,
                      warning = TRUE)

## --------------------------------------------------------------------------
library("SummarizedBenchmark")
library("magrittr")

## --------------------------------------------------------------------------
data(tdat)

## --------------------------------------------------------------------------
head(tdat)

## --------------------------------------------------------------------------
adj_bonf <- p.adjust(p = tdat$pval, method = "bonferroni")

adj_bh <- p.adjust(p = tdat$pval, method = "BH")

qv <- qvalue::qvalue(p = tdat$pval)
adj_qv <- qv$qvalues

## --------------------------------------------------------------------------
adj <- cbind.data.frame(adj_bonf, adj_bh, adj_qv)
head(adj)

## --------------------------------------------------------------------------
b <- BenchDesign(data = tdat)

## --------------------------------------------------------------------------
b <- addMethod(bd = b, label = "bonf", func = p.adjust,
               params = rlang::quos(p = pval, method = "bonferroni"))

## --------------------------------------------------------------------------
b <- b %>% 
    addMethod(label = "BH",
              func = p.adjust,
              params = rlang::quos(p = pval, method = "BH")) %>%
    addMethod(label = "qv",
              func = qvalue::qvalue,
              params = rlang::quos(p = pval),
              post = function(x) { x$qvalues })

## --------------------------------------------------------------------------
b

## --------------------------------------------------------------------------
printMethods(b)

## --------------------------------------------------------------------------
sb <- buildBench(b, truthCols = "H")

## --------------------------------------------------------------------------
head(assay(sb))

## --------------------------------------------------------------------------
colData(sb)

## --------------------------------------------------------------------------
rowData(sb)

## ----addPerformanceMetric--------------------------------------------------
sb <- addPerformanceMetric(
  object = sb,
  assay = "H",
  evalMetric = "TPR",
  evalFunction = function(query, truth, alpha = 0.1) {
    goodHits <- sum((query < alpha) & truth == 1)
    goodHits / sum(truth == 1)
    }
)

performanceMetrics(sb)[["H"]]

## --------------------------------------------------------------------------
resWide <- estimatePerformanceMetrics(sb, alpha = c(0.05, 0.1, 0.2))
resWide

## ----elWide----------------------------------------------------------------
elementMetadata(resWide)

## --------------------------------------------------------------------------
sb <- estimatePerformanceMetrics(sb, 
                                 alpha = c(0.05, 0.1, 0.2), 
                                 addColData = TRUE)
colData(sb)
elementMetadata(colData(sb))

## --------------------------------------------------------------------------
estimatePerformanceMetrics(sb, 
                           alpha = c(0.05, 0.1, 0.2), 
                           tidy = TRUE)

## --------------------------------------------------------------------------
head(tidyUpMetrics(sb))

## --------------------------------------------------------------------------
tidyUpMetrics(sb) %>%
  dplyr:::filter(label == "bonf", alpha == 0.1, performanceMetric == "TPR") %>%
  dplyr:::select(value)

## --------------------------------------------------------------------------
BDMethodList(b)
BDData(b)

## --------------------------------------------------------------------------
BDMethodList(b)[["bonf"]]

## --------------------------------------------------------------------------
BDMethodList(b)[["bonf2"]] <- BDMethodList(b)[["bonf"]]
b

## --------------------------------------------------------------------------
BDMethodList(b)[["bonf"]] <- NULL
b

## --------------------------------------------------------------------------
bdm_bonf <- BDMethod(x = p.adjust, 
                     params = rlang::quos(p = pval, 
                                          method = "bonferroni"))
bdm_bonf

## --------------------------------------------------------------------------
BDMethodList(b)[["bonf"]] <- bdm_bonf
b

## --------------------------------------------------------------------------
BDData(b) <- NULL
b

## --------------------------------------------------------------------------
bdd <- BDData(data = tdat)
BDData(b) <- bdd
b

## --------------------------------------------------------------------------
b <- hashBDData(b)
b

## --------------------------------------------------------------------------
BDMethodList(b)[["bonf2"]] <- NULL

## --------------------------------------------------------------------------
sbSub <- sb[, 1:2]
colData(sbSub)

## --------------------------------------------------------------------------
BenchDesign(sb)

## --------------------------------------------------------------------------
compareBDData(BDData(tdat), BenchDesign(sb))

## --------------------------------------------------------------------------
metadata(sb)$sessions[[1]]

## --------------------------------------------------------------------------
mymethod <- function(x) {
    mysubmethod(x)
}
mybd <- BenchDesign(data = list(vals = 1:5))
mybd <- addMethod(mybd, "method1", mymethod,
                  params = rlang::quos(x = vals))

## --------------------------------------------------------------------------
BDMethod(mybd, "method1")@f

## ---- message = TRUE-------------------------------------------------------
tryCatch({ buildBench(mybd) }, error = function(e) print(e))

## --------------------------------------------------------------------------
m <- 5
mymult <- function(x) {
    m * x
}
m <- 2

mybd <- BenchDesign(data = list(vals = 1:5, m = 10))
mybd <- addMethod(mybd, "methodr", mymult,
                  params = rlang::quos(x = vals))

## --------------------------------------------------------------------------
assay(buildBench(mybd))

## --------------------------------------------------------------------------
library("limma")
library("edgeR")
library("DESeq2")
library("tximport")

## ----loadingSoneson--------------------------------------------------------
data("soneson2016")
head(txi$counts)
head(truthdat)

## --------------------------------------------------------------------------
mycounts <- round(txi$counts)

## --------------------------------------------------------------------------
mycoldat <- data.frame(condition = factor(rep(c(1, 2), each = 3)))
rownames(mycoldat) <- colnames(mycounts)

## --------------------------------------------------------------------------
mydat <- list(coldat = mycoldat,
              cntdat = mycounts,
              status = truthdat$status,
              lfc = truthdat$logFC)

## --------------------------------------------------------------------------
bd <- BenchDesign(data = mydat)

## --------------------------------------------------------------------------
deseq2_pvals <- function(countData, colData, design, contrast) {
    dds <- DESeqDataSetFromMatrix(countData,
                                  colData = colData,
                                  design = design)
    dds <- DESeq(dds)
    res <- results(dds, contrast = contrast)
    res$pvalue
}

edgeR_pvals <- function(countData, group, design) {
    y <- DGEList(countData, group = group)
    y <- calcNormFactors(y)
    des <- model.matrix(design)
    y <- estimateDisp(y, des)
    fit <- glmFit(y, des)
    lrt <- glmLRT(fit, coef=2)
    lrt$table$PValue
}

voom_pvals <- function(countData, group, design) {
    y <- DGEList(countData, group = group)
    y <- calcNormFactors(y)
    des <- model.matrix(design)
    y <- voom(y, des)
    eb <- eBayes(lmFit(y, des))
    eb$p.value[, 2]
}

## --------------------------------------------------------------------------
bd <- bd %>%
    addMethod(label = "deseq2",
              func = deseq2_pvals,
              params = rlang::quos(countData = cntdat,
                                   colData = coldat, 
                                   design = ~condition,
                                   contrast = c("condition", "2", "1"))
              ) %>%
    addMethod(label = "edgeR",
              func = edgeR_pvals,
              params = rlang::quos(countData = cntdat,
                                   group = coldat$condition,
                                   design = ~coldat$condition)
              ) %>%
    addMethod(label = "voom",
              func = voom_pvals,
              params = rlang::quos(countData = cntdat,
                                   group = coldat$condition,
                                   design = ~coldat$condition)
              )

## --------------------------------------------------------------------------
sb <- buildBench(bd, truthCols = "status")

## --------------------------------------------------------------------------
sb

## ----availableMetrics------------------------------------------------------
availableMetrics()

## --------------------------------------------------------------------------
sb <- addPerformanceMetric( sb, 
                            evalMetric=c("rejections", "TPR", "TNR", "FDR", "FNR"),
                            assay="status" )
names(performanceMetrics(sb)[["status"]])

## ----echo=FALSE------------------------------------------------------------
assay(sb)[,"deseq2"][is.na(assay(sb)[, "deseq2"])] <- 1

## --------------------------------------------------------------------------
estimatePerformanceMetrics(
  sb, 
  alpha = c(0.01, 0.05, 0.1, 0.2), 
  tidy = TRUE) %>%
  dplyr:::select(label, value, performanceMetric, alpha) %>%
  tail()

## ---- fig.width=4.5, fig.height=4------------------------------------------
plotMethodsOverlap( sb, assay="status", alpha=0.1, order.by="freq")

## ---- fig.width=5, fig.height=4--------------------------------------------
SummarizedBenchmark::plotROC(sb, assay="status")

## --------------------------------------------------------------------------
bdnull <- BenchDesign()
bdnull

## --------------------------------------------------------------------------
bdnull <- bdnull %>%
    addMethod(label = "bonf",
              func = p.adjust,
              params = rlang::quos(p = pval,
                                   method = "bonferroni")) %>%
    addMethod(label = "BH",
              func = p.adjust,
              params = rlang::quos(p = pval,
                                   method = "BH"))

## --------------------------------------------------------------------------
buildBench(bdnull, data = tdat)

## --------------------------------------------------------------------------
deseq2_run <- function(countData, colData, design, contrast) {
    dds <- DESeqDataSetFromMatrix(countData,
                                  colData = colData,
                                  design = design)
    dds <- DESeq(dds)
    results(dds, contrast = contrast)
}
deseq2_pv <- function(x) {
    x$pvalue
}
deseq2_lfc <- function(x) {
    x$log2FoldChange
}

edgeR_run <- function(countData, group, design) {
    y <- DGEList(countData, group = group)
    y <- calcNormFactors(y)
    des <- model.matrix(design)
    y <- estimateDisp(y, des)
    fit <- glmFit(y, des)
    glmLRT(fit, coef=2)
}
edgeR_pv <- function(x) {
    x$table$PValue
}
edgeR_lfc <- function(x) {
    x$table$logFC
}

voom_run <- function(countData, group, design) {
    y <- DGEList(countData, group = group)
    y <- calcNormFactors(y)
    des <- model.matrix(design)
    y <- voom(y, des)
    eBayes(lmFit(y, des))
}
voom_pv <- function(x) {
    x$p.value[, 2]
}
voom_lfc <- function(x) {
    x$coefficients[, 2]
}

## --------------------------------------------------------------------------
bd <- BenchDesign(data = mydat) %>%
    addMethod(label = "deseq2",
              func = deseq2_run,
              post = list(pv = deseq2_pv,
                          lfc = deseq2_lfc),
              params = rlang::quos(countData = cntdat,
                                   colData = coldat, 
                                   design = ~condition,
                                   contrast = c("condition", "2", "1"))
              ) %>%
    addMethod(label = "edgeR",
              func = edgeR_run,
              post = list(pv = edgeR_pv,
                          lfc = edgeR_lfc),
              params = rlang::quos(countData = cntdat,
                                   group = coldat$condition,
                                   design = ~coldat$condition)
              ) %>%
    addMethod(label = "voom",
              func = voom_run,
              post = list(pv = voom_pv,
                          lfc = voom_lfc),
              params = rlang::quos(countData = cntdat,
                                   group = coldat$condition,
                                   design = ~coldat$condition)
              )

## --------------------------------------------------------------------------
sb <- buildBench(bd = bd, truthCols = c(pv = "status", lfc = "lfc"))
sb

## --------------------------------------------------------------------------
head(assay(sb, "pv"))
head(assay(sb, "lfc"))

## --------------------------------------------------------------------------
bpparam()
sbp <- buildBench(bd, parallel = TRUE,
                  BPPARAM = BiocParallel::SerialParam())
sbp

## --------------------------------------------------------------------------
all(assay(sbp) == assay(sb), na.rm = TRUE)

## --------------------------------------------------------------------------
#mydat <- as.list( bd@data@data )
ndat <- length(mydat$status)
spIndexes <- split( seq_len( ndat ), rep( 1:3, length.out=ndat ) )

datasetList <- lapply( spIndexes, function(x){
  list( coldat=mydat$coldat, 
        cntdat=mydat$cntdat[x,], 
        status=mydat$status[x], 
        lfc=mydat$lfc[x] )
} )
names( datasetList ) <- 
  c("dataset1", "dataset2", "dataset3")

## --------------------------------------------------------------------------
sbL <- bplapply( datasetList, function( x ){
  buildBench( bd, data=x )
}, BPPARAM = MulticoreParam( 3 ) )
sbL

## --------------------------------------------------------------------------
updateBench(sb = sb)

## --------------------------------------------------------------------------
BDData(BenchDesign(sb))

## --------------------------------------------------------------------------
bd2 <- modifyMethod(bd, "deseq2", rlang::quos(bd.meta = list(note = "minor update")))

## --------------------------------------------------------------------------
updateBench(sb = sb, bd = bd2)

## --------------------------------------------------------------------------
deseq2_ashr <- function(countData, colData, design, contrast) {
    dds <- DESeqDataSetFromMatrix(countData,
                                  colData = colData,
                                  design = design)
    dds <- DESeq(dds)
    lfcShrink(dds, contrast = contrast, type = "ashr")
}

bd2 <- addMethod(bd2, "deseq2_ashr", 
                 deseq2_ashr,
                 post = list(pv = deseq2_pv,
                             lfc = deseq2_lfc),
                 params = rlang::quos(countData = cntdat,
                                      colData = coldat, 
                                      design = ~condition,
                                      contrast = c("condition", "2", "1")))

## --------------------------------------------------------------------------
updateBench(sb = sb, bd = bd2)

## --------------------------------------------------------------------------
sb2 <- updateBench(sb = sb, bd = bd2, dryrun = FALSE)
sb2

## --------------------------------------------------------------------------
head(assay(sb2, "lfc"))

## --------------------------------------------------------------------------
colData(sb2)[, "session.idx", drop = FALSE]

## --------------------------------------------------------------------------
lapply(metadata(sb2)$sessions, `[[`, "methods")

## --------------------------------------------------------------------------
updateBench(sb2, bd, keepAll = FALSE)

## ----simpleMetric----------------------------------------------------------
sb <- addPerformanceMetric( sb, 
                      assay="pv", 
                      evalMetric="rejections", 
                      evalFunction=function( query, truth  ){ 
                        sum( p.adjust( query, method="BH" ) < 0.1, na.rm=TRUE) 
                        } )
sb <- estimatePerformanceMetrics(sb, addColData=TRUE)

## ----modifyBench-----------------------------------------------------------
sb2 <- updateBench( sb, bd2, dryrun=FALSE )
estimatePerformanceMetrics( sb2, rerun=FALSE, addColData=TRUE )

## --------------------------------------------------------------------------
bdslow <- BenchDesign(data = tdat) %>%
    addMethod("slowMethod", function() { Sys.sleep(5); rnorm(5) },
              post = list(keepSlow = identity,
                          makeSlower = function(x) { Sys.sleep(5); x })) %>%
    addMethod("fastMethod", function() { rnorm(5) },
              post = list(keepFast = identity,
                          makeSlower = function(x) { Sys.sleep(5); x }))

## ---- message = TRUE-------------------------------------------------------
bpp <- SerialParam()
bptimeout(bpp) <- 1

sbep <- buildBench(bdslow, parallel = TRUE, BPPARAM = bpp)

## --------------------------------------------------------------------------
sbep

## --------------------------------------------------------------------------
sapply(assayNames(sbep), assay, x = sbep, simplify = FALSE)

## --------------------------------------------------------------------------
names(metadata(sbep)$sessions[[1]])

## --------------------------------------------------------------------------
sess1res <- metadata(sbep)$sessions[[1]]$results
simplify2array(sess1res)

## --------------------------------------------------------------------------
sess1res$slowMethod$keepSlow

## --------------------------------------------------------------------------
tempbd <- BenchDesign(data = mydat) %>%
    addMethod(label = "deseq2",
              func = deseq2_pvals,
              meta = list(reason = "recommended by friend X"),
              params = rlang::quos(countData = cntdat,
                                   colData = coldat, 
                                   design = ~condition,
                                   contrast = c("condition", "2", "1"))
              ) %>%
    addMethod(label = "edgeR",
              func = edgeR_pvals,
              meta = list(reason = "recommended by friend Y"), 
              params = rlang::quos(countData = cntdat,
                                   group = coldat$condition,
                                   design = ~coldat$condition)
              )
buildBench(tempbd) %>%
    colData()

## --------------------------------------------------------------------------
tempbd <- BenchDesign(data = mydat) %>%
    addMethod(label = "deseq2",
              func = deseq2_pvals,
              meta = list(pkg_func = rlang::quo(DESeq2::DESeq)),
              params = rlang::quos(countData = cntdat,
                                   colData = coldat, 
                                   design = ~condition,
                                   contrast = c("condition", "2", "1"))
              ) %>%
    addMethod(label = "edgeR",
              func = edgeR_pvals,
              meta = list(pkg_name = "edgeR",
                          pkg_vers = as.character(packageVersion("edgeR"))), 
              params = rlang::quos(countData = cntdat,
                                   group = coldat$condition,
                                   design = ~coldat$condition)
              )
buildBench(tempbd) %>%
    colData()

## --------------------------------------------------------------------------
printMethod(bd, "deseq2")

## --------------------------------------------------------------------------
modifyMethod(bd, label = "deseq2", 
             params = rlang::quos(contrast = c("condition", "1", "2"),
                                  bd.meta = list(note = "modified post hoc"))
             ) %>%
    printMethod("deseq2")

## --------------------------------------------------------------------------
modifyMethod(bd, label = "deseq2", 
             params = rlang::quos(contrast = c("condition", "1", "2"),
                                  bd.meta = list(note = "modified post hoc")),
             .overwrite = TRUE) %>%
    printMethod("deseq2")

## --------------------------------------------------------------------------
bde <- expandMethod(bd, label = "deseq2", 
                    onlyone = "contrast",
                    params = rlang::quos(deseq2_v1 = c("condition", "1", "2"),
                                         deseq2_v2 = c("condition", "2", "2"))
                    )
printMethod(bde, "deseq2_v1")
printMethod(bde, "deseq2_v2")

## --------------------------------------------------------------------------
bde <- expandMethod(bd, label = "deseq2", 
                    params = list(deseq2_v1 = rlang::quos(contrast = c("condition", "1", "2"),
                                                          meta = list(note = "filp order")),
                                  deseq2_v2 = rlang::quos(contrast = c("condition", "2", "2"),
                                                          meta = list(note = "nonsensical order"))
                                  )
                    )
printMethod(bde, "deseq2_v1")
printMethod(bde, "deseq2_v2")

