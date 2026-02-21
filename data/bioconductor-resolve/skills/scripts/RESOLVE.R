# Code example from 'RESOLVE' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("RESOLVE")

## ----message=FALSE------------------------------------------------------------
library("RESOLVE")
data(ssm560_reduced)

## ----message=FALSE------------------------------------------------------------
library("BSgenome.Hsapiens.1000genomes.hs37d5")
imported_data = getSBSCounts(data = ssm560_reduced, reference = BSgenome.Hsapiens.1000genomes.hs37d5)

## ----fig.width=7, fig.height=7, fig.cap="Visualization of the counts for patient PD10010a from the dataset published in Nik-Zainal, Serena, et al."----
patientsSBSPlot(trinucleotides_counts=imported_data,samples="PD10010a")

## ----eval=FALSE---------------------------------------------------------------
# data(background)
# data(patients)
# set.seed(12345)
# res_denovo = signaturesDecomposition(x = patients,
#                                      K = 1:15,
#                                      background_signature = background,
#                                      nmf_runs = 100,
#                                      num_processes = 50)

## ----eval=FALSE---------------------------------------------------------------
# set.seed(12345)
# res_cv = signaturesCV(x = patients,
#                       beta = res_denovo$beta,
#                       cross_validation_repetitions = 100,
#                       num_processes = 50)

## ----eval=FALSE---------------------------------------------------------------
# data(sbs_assignments)
# set.seed(12345)
# norm_alpha = (sbs_assignments$alpha / rowSums(sbs_assignments$alpha))
# sbs_clustering = signaturesClustering(alpha = norm_alpha, num_clusters = 1:3, num_processes = 1, verbose = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# data(association_mutations)
# set.seed(12345)
# alterations = association_mutations$alterations
# normalized_alpha = association_mutations$normalized_alpha
# association_alterations = associationAlterations(alterations = alterations, signatures = normalized_alpha)

## ----eval=FALSE---------------------------------------------------------------
# data(association_mutations)
# set.seed(12345)
# alterations = association_mutations$alterations
# normalized_alpha = association_mutations$normalized_alpha
# association_signatures = associationSignatures(alterations = alterations, signatures = normalized_alpha)

## ----eval=FALSE---------------------------------------------------------------
# data(association_survival)
# set.seed(12345)
# clinical_data = association_survival$clinical_data
# normalized_alpha = association_survival$normalized_alpha
# prognosis_associations = associationPrognosis(clinical_data = clinical_data, signatures = normalized_alpha)

## -----------------------------------------------------------------------------
sessionInfo()

