# Code example from 'Contrast_Comparisons' vignette. See references/ for full tutorial.

## ----setup--------------------------------------------------------------------
library(Biobase)
library(gCrisprTools)
knitr::opts_chunk$set(message = FALSE, fig.width = 8, fig.height = 8)

data(resultsDF)

head(resultsDF)


## -----------------------------------------------------------------------------
res <- ct.simpleResult(resultsDF, collapse = 'geneSymbol')
head(res)

## -----------------------------------------------------------------------------
# Make "another" result
res2 <- res
res2$best.p <- res2$best.p * runif(nrow(res2)) 
res2$direction[sample(1:nrow(res), 500)] <- res2$direction[sample(1:nrow(res), 500)]


regularized <- ct.regularizeContrasts(dflist = list('Experiment1' = res[1:1500,], 
                                                    'Experiment2' = res2[1:1900,]), 
                                      collapse = 'geneSymbol')

str(regularized)


## -----------------------------------------------------------------------------
comparison <- ct.compareContrasts(dflist = regularized,
                                  statistics = c('best.q', 'best.p'), 
                                  cutoffs = c(0.5,0.05), 
                                  same.dir = rep(TRUE, length(regularized)))

head(comparison, 30)


## -----------------------------------------------------------------------------
ct.compareContrasts(dflist = regularized,
                    statistics = c('best.q', 'best.p'),
                    cutoffs = c(0.5,0.05), 
                    same.dir = rep(TRUE, length(regularized)),
                    return.stats = TRUE)

## ----contrastbarchart, fig.width=6, fig.height = 5----------------------------
ct.contrastBarchart(regularized, background = FALSE, statistic = 'best.p')

## ----fig.width = 5, fig.height = 5--------------------------------------------
scat <- ct.scatter(regularized, 
                   targets = 'geneSymbol', 
                   statistic = 'best.p', 
                   cutoff = 0.05)

## -----------------------------------------------------------------------------
head(scat)

## ----contrast interaction, message = FALSE, warning=FALSE, fig.width = 6, fig.height = 12----
library(Biobase)
library(limma)
library(gCrisprTools)

#Create a complex model design; removing the replicate term for clarity
data("es", package = "gCrisprTools")
data("ann", package = "gCrisprTools")

design <- model.matrix(~ 0 + TREATMENT_NAME, pData(es))
colnames(design) <- gsub('TREATMENT_NAME', '', colnames(design))
contrasts <-makeContrasts(ControlTime = ControlExpansion - ControlReference,
                          DeathOverTime = DeathExpansion - ControlReference,
                          Interaction = DeathExpansion - ControlExpansion, 
                          levels = design)

es <- ct.normalizeGuides(es, method = "scale") #See man page for other options
vm <- voom(exprs(es), design)

fit <- lmFit(vm, design)
fit <- contrasts.fit(fit, contrasts)
fit <- eBayes(fit)

allResults <- sapply(colnames(fit$coefficients), 
                     function(x){
                         ct.generateResults(fit,
                                            annotation = ann,
                                            RRAalphaCutoff = 0.1,
                                            permutations = 1000,
                                            scoring = "combined",
                                            permutation.seed = 2, 
                                            contrast.term = x)
                       }, simplify = FALSE)

allSimple <- ct.regularizeContrasts(allResults)

## -----------------------------------------------------------------------------

time.effect <- ct.compareContrasts(list("con" = allSimple$ControlTime,
                                        "tx" = allSimple$DeathOverTime))
summary(time.effect$replicated)

## -----------------------------------------------------------------------------
mod.control <- ct.compareContrasts(list("con" = allSimple$ControlTime,
                                        "Interaction" = allSimple$Interaction),
                                 same.dir = c(TRUE, FALSE))
summary(mod.control$replicated)

## ----fig.height= 6, fig.width = 8---------------------------------------------
upset <- ct.upSet(allSimple)

## -----------------------------------------------------------------------------
show(upset)

## ----fig.width=6, fig.height=6, warnings= FALSE-------------------------------
genesetdb <- sparrow::getMSigGeneSetDb(collection = 'h', species = 'human', id.type = 'entrez')

sparrowList <- ct.seas(allSimple, gdb = genesetdb)

show(sparrowList)

#Can use returned matrices to facilitate downstream comparisons: 

plot(-log10(sparrow::results(sparrowList$DeathOverTime, 'fgsea')$padj), 
     -log10(sparrow::results(sparrowList$Interaction, 'fgsea')$padj), 
     pch = 19, col = rgb(0,0,0.8,0.5), 
     ylab = "Pathway -log10(P), Treatment Over Time",
     xlab = "Pathway -log10(P), Marginal Time Effect, Treatment Arm",
     main = 'Evidence for Pathway Enrichment')
abline(0,1,lty = 2)


## -----------------------------------------------------------------------------
sessionInfo()

