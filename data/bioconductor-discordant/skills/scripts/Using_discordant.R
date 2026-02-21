# Code example from 'Using_discordant' vignette. See references/ for full tutorial.

## ----include=FALSE, echo=FALSE------------------------------------------------
# date: "`r doc_date()`"
# "`r pkg_ver('BiocStyle')`"
# <style>
#     pre {
#     white-space: pre !important;
#     overflow-y: scroll !important;
#     height: 50vh !important;
#     }
# </style>

## ----echo=FALSE---------------------------------------------------------------
library(discordant)

## -----------------------------------------------------------------------------
# Load data
data(TCGA_GBM_miRNA_microarray)
data(TCGA_GBM_transcript_microarray)


## ----echo=FALSE---------------------------------------------------------------
# Modify column names
# rownames(TCGA_GBM_miRNA_microarray) <- 
#   substr(rownames(TCGA_GBM_miRNA_microarray), 9,
#          nchar(rownames(TCGA_GBM_miRNA_microarray)))

## -----------------------------------------------------------------------------
data(TCGA_Breast_miRNASeq)
mat.filtered <- splitMADOutlier(TCGA_Breast_miRNASeq,
                                filter0 = TRUE, 
                                threshold = 4)

## -----------------------------------------------------------------------------
groups <- c(rep(1,10), rep(2,20))

# Within -omics
wthn_vectors <- createVectors(x = TCGA_GBM_transcript_microarray, 
                              groups = groups)
# Between -omics
btwn_vectors <- createVectors(x = TCGA_GBM_miRNA_microarray, 
                              y = TCGA_GBM_transcript_microarray, 
                              groups = groups)

## -----------------------------------------------------------------------------
# Within -omics
head(wthn_vectors$v1)
head(wthn_vectors$v2)

## -----------------------------------------------------------------------------
# Between -omics
head(btwn_vectors$v1)
head(btwn_vectors$v2)

## -----------------------------------------------------------------------------
# Within -omics
wthn_result <- discordantRun(v1 = wthn_vectors$v1, 
                             v2 = wthn_vectors$v2, 
                             x = TCGA_GBM_transcript_microarray)

# Between -omics
btwn_result <- discordantRun(v1 = btwn_vectors$v1, 
                             v2 = btwn_vectors$v2, 
                             x = TCGA_GBM_miRNA_microarray, 
                             y = TCGA_GBM_transcript_microarray)


## -----------------------------------------------------------------------------
# Within -omics
wthn_result$discordPPMatrix[1:5, 1:4]

# Between -omics
btwn_result$discordPPMatrix[1:5, 1:4]

## -----------------------------------------------------------------------------
# Within -omics
head(wthn_result$discordPPVector)

# Between -omics
head(btwn_result$discordPPVector)

## -----------------------------------------------------------------------------
# Within -omics
wthn_result$classMatrix[1:5,1:4]

# Between -omics
btwn_result$classMatrix[1:5,1:4]

## -----------------------------------------------------------------------------
# Within -omics
head(wthn_result$classVector)

# Between -omics
head(btwn_result$classVector)

## -----------------------------------------------------------------------------
# Within -omics
round(head(wthn_result$probMatrix), 2)

# Between -omics
round(head(btwn_result$probMatrix), 2)

## -----------------------------------------------------------------------------
# Within -omics
wthn_result$loglik

# Between -omics
btwn_result$loglik

## ----error = TRUE-------------------------------------------------------------
try({
# Between -omics
btwn_result <- discordantRun(v1 = btwn_vectors$v1, 
                             v2 = btwn_vectors$v2, 
                             x = TCGA_GBM_miRNA_microarray, 
                             y = TCGA_GBM_transcript_microarray,
                             components = 3,
                             subsampling = TRUE)
})

## -----------------------------------------------------------------------------
# Load Data
data(TCGA_Breast_miRNASeq_voom)
data(TCGA_Breast_RNASeq_voom)

# Prepare groups
groups <- c(rep(1, 15), rep(2, 42))

# Create correlation vectors
sub_vectors <- createVectors(x = TCGA_Breast_miRNASeq_voom, 
                             y = TCGA_Breast_RNASeq_voom,
                             groups = groups)

# Run analysis with subsampling
set.seed(126)
sub_result <- discordantRun(sub_vectors$v1, sub_vectors$v2,
                            x = TCGA_Breast_miRNASeq_voom,
                            y = TCGA_Breast_RNASeq_voom,
                            components = 3, subsampling = TRUE)

# Results
round(head(sub_result$probMatrix), 2)

## ----error = TRUE-------------------------------------------------------------
try({
# Within -omics
wthn_result <- discordantRun(v1 = wthn_vectors$v1, 
                             v2 = wthn_vectors$v2, 
                             x = TCGA_GBM_transcript_microarray,
                             components = 5)
})

## -----------------------------------------------------------------------------
# Between -omics
btwn_result <- discordantRun(v1 = btwn_vectors$v1, 
                             v2 = btwn_vectors$v2, 
                             x = TCGA_GBM_miRNA_microarray, 
                             y = TCGA_GBM_transcript_microarray,
                             components = 5)

# Between -omics
round(head(btwn_result$probMatrix), 2)

## -----------------------------------------------------------------------------
sessionInfo()

