# Code example from 'BUMHMM' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## --------------------------------------------------------------------------
suppressPackageStartupMessages({
    library(BUMHMM)
    library(Biostrings)
    library(SummarizedExperiment)
})
se

## --------------------------------------------------------------------------
controls <- se[, se$replicate == "control"]
head(assay(controls, 'coverage'))

## --------------------------------------------------------------------------
rowData(controls)[1:4,]

## --------------------------------------------------------------------------
colData(controls)

## --------------------------------------------------------------------------
pos <- 300
assay(controls, 'coverage')[pos, 1]
assay(controls, 'dropoff_count')[pos, 1]
assay(controls, 'dropoff_rate')[pos, 1]

## --------------------------------------------------------------------------
treatments <- se[, se$replicate == "treatment"]
assay(treatments, 'coverage')[pos, 1]
assay(treatments, 'dropoff_count')[pos, 1]
assay(treatments, 'dropoff_rate')[pos, 1]

## --------------------------------------------------------------------------
Nc <- Nt <- 3
t <- 1
nuclSelection <- selectNuclPos(se, Nc, Nt, t)
List(nuclSelection)

## --------------------------------------------------------------------------
t(combn(Nc, 2))

## --------------------------------------------------------------------------
length(nuclSelection$analysedC[[1]])
length(nuclSelection$analysedCT[[1]])

## --------------------------------------------------------------------------
## Medians of original drop-off rates in each replicate
apply(assay(se, 'dropoff_rate'), 2, median)

## Scale drop-off rates
assay(se, "dropoff_rate") <- scaleDOR(se, nuclSelection, Nc, Nt)

## Medians of scaled drop-off rates in each replicate
apply(assay(se, 'dropoff_rate'), 2, median)

## --------------------------------------------------------------------------
stretches <- computeStretches(se, t)

## --------------------------------------------------------------------------
head(stretches)
assay(se, 'dropoff_count')[1748,]

## --------------------------------------------------------------------------
varStab <- stabiliseVariance(se, nuclSelection, Nc, Nt)
LDR_C <- varStab$LDR_C
LDR_CT <- varStab$LDR_CT

hist(LDR_C, breaks = 30, main = 'Null distribution of LDRs')

## --------------------------------------------------------------------------
nuclNum <- 3
patterns <- nuclPerm(nuclNum)
patterns

## --------------------------------------------------------------------------
## Extract the DNA sequence
sequence <- subject(rowData(se)$nucl)
sequence
nuclPosition <- findPatternPos(patterns, sequence, '+')
patterns[[1]]
head(nuclPosition[[1]])

## --------------------------------------------------------------------------
nuclPosition <- list()
nuclPosition[[1]] <- 1:nchar(sequence)

## Start of the stretch
nuclPosition[[1]][1]
## End of the stretch
nuclPosition[[1]][length(nuclPosition[[1]])]

## --------------------------------------------------------------------------
posteriors <- computeProbs(LDR_C, LDR_CT, Nc, Nt, '+', nuclPosition,
                             nuclSelection$analysedC, nuclSelection$analysedCT,
                             stretches)

## --------------------------------------------------------------------------
head(posteriors)

## --------------------------------------------------------------------------
shifted_posteriors <- matrix(, nrow=dim(posteriors)[1], ncol=1)
shifted_posteriors[1:(length(shifted_posteriors) - 1)] <-
  posteriors[2:dim(posteriors)[1], 2]

## --------------------------------------------------------------------------
plot(shifted_posteriors, xlab = 'Nucleotide position',
     ylab = 'Probability of modification',
     main = 'BUMHMM output for 18S DMS data set')

## ----eval=FALSE------------------------------------------------------------
# ## Call the function with the additonal tolerance parameter
# posteriors <- computeProbs(LDR_C, LDR_CT, Nc, Nt, '+', nuclPosition,
#                            nuclSelection$analysedC, nuclSelection$analysedCT,
#                            stretches, 0.001)

## --------------------------------------------------------------------------
sessionInfo()

