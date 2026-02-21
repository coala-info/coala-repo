# Code example from 'Crispr_example_workflow' vignette. See references/ for full tutorial.

## ----setup, eval = TRUE-------------------------------------------------------
suppressPackageStartupMessages(library(Biobase))
suppressPackageStartupMessages(library(limma))
suppressPackageStartupMessages(library(gCrisprTools))

data("es", package = "gCrisprTools")
data("ann", package = "gCrisprTools")
data("aln", package = "gCrisprTools")
knitr::opts_chunk$set(message = FALSE, fig.width = 8, fig.height = 8, warning = FALSE)

## ----eval = TRUE--------------------------------------------------------------
sk <- relevel(as.factor(pData(es)$TREATMENT_NAME), "ControlReference")
names(sk) <- row.names(pData(es))

## ----eval = TRUE--------------------------------------------------------------
design <- model.matrix(~ 0 + REPLICATE_POOL + TREATMENT_NAME, pData(es))
colnames(design) <- gsub('TREATMENT_NAME', '', colnames(design))
contrasts <-makeContrasts(DeathExpansion - ControlExpansion, levels = design)

## ----eval = TRUE, fig.width = 8, fig.height = 10------------------------------
es <- ct.filterReads(es, trim = 1000, sampleKey = sk)

## ----eval = TRUE, fig.width = 6, fig.height = 12------------------------------
es <- ct.normalizeGuides(es, method = "scale", plot.it = TRUE) #See man page for other options
vm <- voom(exprs(es), design)

fit <- lmFit(vm, design)
fit <- contrasts.fit(fit, contrasts)
fit <- eBayes(fit)

## ----eval = TRUE--------------------------------------------------------------
ann <- ct.prepareAnnotation(ann, fit, controls = "NoTarget")

## ----eval = TRUE--------------------------------------------------------------
resultsDF <-
  ct.generateResults(
    fit,
    annotation = ann,
    RRAalphaCutoff = 0.1,
    permutations = 1000,
    scoring = "combined", 
    permutation.seed = 2
  )

## ----eval = TRUE--------------------------------------------------------------

# Create random alternative target associations 

altann <- sapply(ann$ID, 
                 function(x){
                   out <- as.character(ann$geneSymbol)[ann$ID %in% x]
                   if(runif(1) < 0.01){out <- c(out, sample(as.character(ann$geneSymbol), size = 1))}
                   return(out)
                 }, simplify = FALSE)

resultsDF <-
  ct.generateResults(
    fit,
    annotation = ann,
    RRAalphaCutoff = 0.1,
    permutations = 1000,
    scoring = "combined", 
    alt.annotation = altann,
    permutation.seed = 2
  )

## ----eval = TRUE--------------------------------------------------------------
data("fit", package = "gCrisprTools")
data("resultsDF", package = "gCrisprTools")

fit <- fit[(row.names(fit) %in% row.names(ann)),]
resultsDF <- resultsDF[(row.names(resultsDF) %in% row.names(ann)),]

targetResultDF <- ct.simpleResult(resultsDF) #For a simpler target-level result object

## ----eval = TRUE--------------------------------------------------------------
ct.alignmentChart(aln, sk)
ct.rawCountDensities(es, sk)

## ----eval = TRUE--------------------------------------------------------------
ct.gRNARankByReplicate(es, sk) 
ct.gRNARankByReplicate(es, sk, annotation = ann, geneSymb = "NoTarget")  #Show locations of NTC gRNAs

## ----eval = TRUE--------------------------------------------------------------
ct.viewControls(es, ann, sk, normalize = FALSE)
ct.viewControls(es, ann, sk, normalize = TRUE)

## ----eval = TRUE, fig.width = 8, fig.height = 12------------------------------
ct.GCbias(es, ann, sk)
ct.GCbias(fit, ann, sk)

## ----eval = TRUE--------------------------------------------------------------
ct.stackGuides(es,
               sk,
               plotType = "gRNA",
               annotation = ann,
               nguides = 40)

## ----eval = TRUE--------------------------------------------------------------
ct.stackGuides(es, 
               sk, 
               plotType = "Target", 
               annotation = ann)

## ----eval = TRUE--------------------------------------------------------------
ct.stackGuides(es,
               sk,
               plotType = "Target",
               annotation = ann,
               subset = names(sk)[grep('Expansion', sk)])

## ----eval = TRUE--------------------------------------------------------------
ct.guideCDF(es, sk, plotType = "gRNA")
ct.guideCDF(es, sk, plotType = "Target", annotation = ann)

## ----eval = TRUE--------------------------------------------------------------
ct.contrastBarchart(resultsDF)

## ----eval = TRUE--------------------------------------------------------------
ct.topTargets(fit,
              resultsDF,
              ann,
              targets = 10,
              enrich = TRUE)
ct.topTargets(fit,
              resultsDF,
              ann,
              targets = 10,
              enrich = FALSE)

## ----eval = TRUE, fig.width = 8, fig.height = 10------------------------------
ct.viewGuides("Target1633", fit, ann)
ct.gRNARankByReplicate(es, sk, annotation = ann, geneSymb = "Target1633")

## ----eval = TRUE--------------------------------------------------------------
ct.signalSummary(resultsDF,
                 targets = list('TargetSetA' = c(sample(unique(resultsDF$geneSymbol), 3)),
                                'TargetSetB' = c(sample(unique(resultsDF$geneSymbol), 2))))

## ----eval = TRUE--------------------------------------------------------------
data("essential.genes", package = "gCrisprTools")
ct.targetSetEnrichment(resultsDF, essential.genes)

## ----rocprc, eval = TRUE------------------------------------------------------
ROC <- ct.ROC(resultsDF, essential.genes, direction = "deplete")
PRC <- ct.PRC(resultsDF, essential.genes, direction = "deplete")
show(ROC) # show(PRC) is equivalent for the PRC analysis

## ----eval = TRUE, warning=FALSE, message = FALSE------------------------------
#Create a geneset database using one of the many helper functions
genesetdb <- sparrow::getMSigGeneSetDb(collection = 'h', species = 'human', id.type = 'entrez')

ct.seas(resultsDF, gdb = genesetdb)

# If you have a library that targets elements unevenly (e.g., variable numbers of 
# elements/promoters per genes), you can conform it via `sparrow::convertIdentifiers()`

genesetdb.GREAT <- sparrow::convertIdentifiers(genesetdb, 
                                               from = 'geneID', 
                                               to = 'geneSymbol', 
                                               xref = ann)
ct.seas(resultsDF, gdb = genesetdb.GREAT)

## ----eval = FALSE-------------------------------------------------------------
# path2report <-      #Make a report of the whole experiment
#   ct.makeReport(fit = fit,
#                 eset = es,
#                 sampleKey = sk,
#                 annotation = ann,
#                 results = resultsDF,
#                 aln = aln,
#                 outdir = ".")
# 
# path2QC <-          #Or one focusing only on experiment QC
#   ct.makeQCReport(es,
#                   trim = 1000,
#                   log2.ratio = 0.05,
#                   sampleKey = sk,
#                   annotation = ann,
#                   aln = aln,
#                   identifier = 'Crispr_QC_Report',
#                   lib.size = NULL
#                   )
# 
# path2Contrast <-    #Or Contrast-specific one
#   ct.makeContrastReport(eset = es,
#                         fit = fit,
#                         sampleKey = sk,
#                         results = resultsDF,
#                         annotation = ann,
#                         comparison.id = NULL,
#                         identifier = 'Crispr_Contrast_Report')

## -----------------------------------------------------------------------------
sessionInfo()

