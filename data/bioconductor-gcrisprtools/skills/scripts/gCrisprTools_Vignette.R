# Code example from 'gCrisprTools_Vignette' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("gCrisprTools")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(Biobase)
library(limma)
library(gCrisprTools)

## -----------------------------------------------------------------------------
data("es", package = "gCrisprTools")
es
head(exprs(es))

## -----------------------------------------------------------------------------
data("ann", package = "gCrisprTools")
head(ann)

## -----------------------------------------------------------------------------
sk <- relevel(as.factor(pData(es)$TREATMENT_NAME), "ControlReference")
names(sk) <- row.names(pData(es))
sk

## ----fig.width = 7, fig.height = 5--------------------------------------------
data("aln", package = "gCrisprTools")
head(aln)
ct.alignmentChart(aln, sk)

## ----fig.width=6, fig.height = 8----------------------------------------------
es.floor <- ct.filterReads(es, read.floor = 30, sampleKey = sk)
es <- ct.filterReads(es, trim = 1000, log2.ratio = 4, sampleKey = sk)

##Convenience function for conforming the annotation object to exclude the trimmed gRNAs
ann <- ct.prepareAnnotation(ann, es, controls = "NoTarget")

## ----fig.width=6, fig.height = 8----------------------------------------------

es <- ct.normalizeGuides(es, 'scale', annotation = ann, sampleKey = sk, plot.it = TRUE)

timepoints <- gsub('^(Control|Death)', '', pData(es)$TREATMENT_NAME)
names(timepoints) <- colnames(es)
es.norm <- ct.normalizeGuides(es, 'FQ', annotation = ann, sampleKey = timepoints, plot.it = TRUE)

es.norm <- ct.normalizeGuides(es, 'slope', annotation = ann, sampleKey = sk, plot.it = TRUE)
es.norm <- ct.normalizeGuides(es, 'controlScale', annotation = ann, sampleKey = sk, plot.it = TRUE, geneSymb = 'NoTarget')
es.norm <- ct.normalizeGuides(es, 'controlSpline', annotation = ann, sampleKey = sk, plot.it = TRUE, geneSymb = 'NoTarget')

## ----eval= FALSE--------------------------------------------------------------
# #Not run:
# path2QC <- ct.makeQCReport(es,
#                  trim = 1000,
#                  log2.ratio = 0.05,
#                  sampleKey = sk,
#                  annotation = ann,
#                  aln = aln,
#                  identifier = 'Crispr_QC_report',
#                  lib.size = NULL
#                  )

## ----fig.width=6, fig.height=6------------------------------------------------
ct.rawCountDensities(es, sk)

## ----fig.width=6, fig.height = 6----------------------------------------------
ct.gRNARankByReplicate(es, sk)  #Visualization of gRNA abundance distribution

## ----fig.width=6, fig.height = 6----------------------------------------------
ct.gRNARankByReplicate(es, sk, annotation = ann, geneSymb = "Target1633")

## ----fig.width=6, fig.height = 6----------------------------------------------
ct.viewControls(es, ann, sk, normalize = FALSE, geneSymb = 'NoTarget')

## ----fig.width=6, fig.height = 4----------------------------------------------
ct.guideCDF(es, sk, plotType = "gRNA")

## -----------------------------------------------------------------------------
design <- model.matrix(~ 0 + REPLICATE_POOL + TREATMENT_NAME, pData(es))
colnames(design) <- gsub('TREATMENT_NAME', '', colnames(design))
contrasts <-makeContrasts(DeathExpansion - ControlExpansion, levels = design)

vm <- voom(exprs(es), design)

fit <- lmFit(vm, design)
fit <- contrasts.fit(fit, contrasts)
fit <- eBayes(fit)

## ----message=FALSE, warning=FALSE---------------------------------------------
resultsDF <-
  ct.generateResults(
    fit,
    annotation = ann,
    RRAalphaCutoff = 0.1,
    permutations = 1000,
    scoring = "combined"
  )

## ----fig.width=6, fig.height = 6----------------------------------------------
ct.topTargets(fit,
              resultsDF,
              ann,
              targets = 10,
              enrich = TRUE)

## ----fig.width=6, fig.height = 8----------------------------------------------
ct.stackGuides(
  es,
  sk,
  plotType = "Target",
  annotation = ann,
  subset = names(sk)[grep('Expansion', sk)]
)

## ----fig.width=6, fig.height = 4----------------------------------------------
ct.viewGuides("Target1633", fit, ann)

## ----fig.width=6, fig.height = 4----------------------------------------------
ct.signalSummary(resultsDF,
                 targets = list('TargetSetA' = c(sample(unique(resultsDF$geneSymbol), 3)),
                                'TargetSetB' = c(sample(unique(resultsDF$geneSymbol), 2))))


## ----eval= FALSE--------------------------------------------------------------
# #Not run:
# path2Contrast <-
#   ct.makeContrastReport(eset = es,
#                         fit = fit,
#                         sampleKey = sk,
#                         results = resultsDF,
#                         annotation = ann,
#                         comparison.id = NULL,
#                         identifier = 'Crispr_Contrast_Report')

## ----eval=FALSE---------------------------------------------------------------
# #Not run:
# path2report <-
#   ct.makeReport(fit = fit,
#                 eset = es,
#                 sampleKey = sk,
#                 annotation = ann,
#                 results = resultsDF,
#                 aln = aln,
#                 outdir = ".")

## ----eval= FALSE--------------------------------------------------------------
# #Not run:
# genesetdb <- sparrow::getMSigGeneSetDb(collection = 'h', species = 'human', id.type = 'entrez')
# 
# # If you have a library that targets elements unevenly (e.g., variable numbers of
# # elements/promoters per genes), you can conform it via GREAT
# genesetdb.GREAT <- ct.GREATdb(ann, gsdb = genesetdb)
# 
# ct.seas(resultsDF, gdb = genesetdb)
# #ct.seas(resultsDF, gdb = genesetdb.GREAT)

## ----fig.width=6, fig.height = 6, warning=FALSE-------------------------------
data("essential.genes", package = "gCrisprTools")  #Artificial list created for demonstration
data("resultsDF", package = "gCrisprTools")
ROC <- ct.ROC(resultsDF, essential.genes, 'enrich')
str(ROC)

## ----fig.width=6, fig.height = 6, warning=FALSE-------------------------------
PRC <- ct.PRC(resultsDF, essential.genes, 'enrich')
str(PRC)

## ----fig.width=6, fig.height = 6, warning=FALSE-------------------------------
##' tar <-  sample(unique(resultsDF$geneSymbol), 20)
##' res <- ct.targetSetEnrichment(resultsDF, tar)

targetsTest <- ct.targetSetEnrichment(resultsDF, essential.genes, enrich = FALSE)
str(targetsTest)

## -----------------------------------------------------------------------------
sessionInfo()

