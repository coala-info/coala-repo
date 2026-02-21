# Code example from 'v2_using_the_package' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("SparseSignature")

## -----------------------------------------------------------------------------
library("SparseSignatures")
data(ssm560_reduced)
head(ssm560_reduced)

## -----------------------------------------------------------------------------
library("BSgenome.Hsapiens.1000genomes.hs37d5")
bsg = BSgenome.Hsapiens.1000genomes.hs37d5
data(mutation_categories)
head(mutation_categories)

## -----------------------------------------------------------------------------
imported_data = import.trinucleotides.counts(data=ssm560_reduced,reference=bsg)
head(imported_data)

## ----fig.width=7, fig.height=7, fig.cap="Visualization of the counts from patient PD10010a from the dataset published in Nik-Zainal, Serena, et al."----
patients.plot(trinucleotides_counts=imported_data,samples="PD10010a")

## -----------------------------------------------------------------------------
data(patients)
head(patients)

## ----eval=FALSE---------------------------------------------------------------
# starting_betas = startingBetaEstimation(x=patients,K=3:12,background_signature=background)

## ----eval=FALSE---------------------------------------------------------------
# lambda_range = lambdaRangeBetaEvaluation(x=patients,K=10,beta=starting_betas[[8,1]],
#                                          lambda_values=c(0.05,0.10))

## -----------------------------------------------------------------------------
data(starting_betas_example)
data(lambda_range_example)

## ----eval=FALSE---------------------------------------------------------------
# cv = nmfLassoCV(x=patients,K=3:10)

## -----------------------------------------------------------------------------
data(cv_example)

## -----------------------------------------------------------------------------
beta = starting_betas_example[["5_signatures","Value"]]
res = nmfLasso(x = patients, K = 5, beta = beta, background_signature = background, seed = 12345)

## ----fig.width=7, fig.height=7, fig.cap="Visualization of the discovered signatures."----
data(nmf_LassoK_example)
signatures = nmf_LassoK_example$beta
signatures.plot(beta=signatures, xlabels=FALSE)

