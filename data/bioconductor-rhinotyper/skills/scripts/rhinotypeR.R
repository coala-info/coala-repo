# Code example from 'rhinotypeR' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
options(repos = c(CRAN = "https://cran.rstudio.com/"))

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("rhinotypeR")

## -----------------------------------------------------------------------------
# Load package
library(rhinotypeR)

# Load example data
data(rhinovirusVP4, package = "rhinotypeR")

## ----eval=FALSE---------------------------------------------------------------
# getPrototypeSeqs("~/Desktop")
# 
# # You will get "~/Desktop/RVRefs.fasta"
# # 2) Combine RVRefs.fasta with your new sequences and align in your tool (e.g., MAFFT).
# # 3) Manually curate (trim to VP4/2 span, resolve poor columns), then save as FASTA.

## -----------------------------------------------------------------------------
aln_curated <- Biostrings::readDNAStringSet(
  system.file("extdata", "input_aln.fasta", package = "rhinotypeR")
)

## ----eval=FALSE---------------------------------------------------------------
# # Use package dataset: rhinovirusVP4
# # Align user sequences + prototypes in R (choose method)
# aln <- alignToRefs(
#   seqData   = rhinovirusVP4,
#   method    = "ClustalW",           # or "ClustalOmega", "Muscle"
#   trimToRef = TRUE,                 # crop to reference non-gap span
#   refName   = "JN855971.1_A107"     # default anchor; change if desired
# )
# 
# aln
# 

## -----------------------------------------------------------------------------
# Input A
res <- assignTypes(aln_curated, model = "IUPAC", deleteGapsGlobally = FALSE, threshold = 0.105)
head(res)

## ----eval=FALSE---------------------------------------------------------------
# # OR similarly for input B
# res <- assignTypes(aln, model = "IUPAC", deleteGapsGlobally = FALSE, threshold = 0.105)
# head(res)

## -----------------------------------------------------------------------------
plotFrequency(res)

## -----------------------------------------------------------------------------
# Distances among all sequences
d <- pairwiseDistances(
  fastaData = rhinovirusVP4,
  model = "IUPAC",
  deleteGapsGlobally = FALSE   # set TRUE to apply global deletion inside the function
)

## ----echo=FALSE---------------------------------------------------------------
d[1:5, 1:7]

## -----------------------------------------------------------------------------
# Mean distance (overall diversity)
overallMeanDistance(rhinovirusVP4, model = "IUPAC")

# Visual summaries
## Heatmap
plotDistances(d)  

## Simple tree (from distances)
sampled_distances <- d[1:30, 1:30]
plotTree(sampled_distances, hang = -1, cex = 0.6, 
         main = "A simple tree", xlab = "", ylab = "Genetic distance")

## -----------------------------------------------------------------------------
# SNP view (nucleotide)
SNPeek(rhinovirusVP4)

# AA view (requires an AAStringSet)

## Option 1 -- read an aligned amino acid sequence
aa_seq <- Biostrings::readAAStringSet(system.file("extdata", "test_translated.fasta", package = "rhinotypeR"))
plotAA(aa_seq)

## ----eval=FALSE---------------------------------------------------------------
# ## Option 2 -- translating DNA
# # Remove gaps before translate()
# aln_no_gaps <- Biostrings::DNAStringSet(
#   gsub("-", "", as.character(rhinovirusVP4))
# )
# #translate
# aa <- Biostrings::translate(aln_no_gaps)
# aa_aln <- msa::msa(aa)  # align as plotAA expects equal width
# aa_aln <- as(aa_aln, "AAStringSet") # transform to AAStringSet
# plotAA(aa_aln)

## -----------------------------------------------------------------------------
sessionInfo()

