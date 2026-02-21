# Code example from 'xcore_vignette' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(warning = FALSE, message = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("xcore")

## -----------------------------------------------------------------------------
library("xcore")

## -----------------------------------------------------------------------------
data("rinderpest_mini")
head(rinderpest_mini)

## -----------------------------------------------------------------------------
design <- matrix(
  data = c(1, 0, 0,
           1, 0, 0,
           1, 0, 0,
           0, 1, 0,
           0, 1, 0,
           0, 1, 0,
           0, 0, 1,
           0, 0, 1,
           0, 0, 1),
  ncol = 3,
  nrow = 9,
  byrow = TRUE,
  dimnames = list(
    c(
      "00hr_rep1",
      "00hr_rep2",
      "00hr_rep3",
      "12hr_rep1",
      "12hr_rep2",
      "12hr_rep3",
      "24hr_rep1",
      "24hr_rep2",
      "24hr_rep3"
    ),
    c("00hr", "12hr", "24hr")
  )
)

print(design)

## -----------------------------------------------------------------------------
mae <- prepareCountsForRegression(counts = rinderpest_mini,
                                  design = design,
                                  base_lvl = "00hr")

## -----------------------------------------------------------------------------
library("ExperimentHub")

eh <- ExperimentHub()
query(eh, "xcoredata")

remap_promoters_f5 <- eh[["EH7301"]]

## -----------------------------------------------------------------------------
print(remap_promoters_f5[3:6, 3:6])

## -----------------------------------------------------------------------------
# here we subset ReMap2020 molecular signatures matrix for the purpose of the
# vignette only! In a normal setting the whole molecular signatures matrix should
# be used!
set.seed(432123)
i <- sample(x = seq_len(ncol(remap_promoters_f5)), size = 100, replace = FALSE)
remap_promoters_f5 <- remap_promoters_f5[, i]

## -----------------------------------------------------------------------------
mae <- addSignatures(mae, remap = remap_promoters_f5)

## -----------------------------------------------------------------------------
summary(colSums(mae[["remap"]]))

## -----------------------------------------------------------------------------
mae <- filterSignatures(mae, min = 0.05, max = 0.95)

## -----------------------------------------------------------------------------
print(mae)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("BiocParallel")
# install.packages("doParallel")

## -----------------------------------------------------------------------------
# register parallel backend
doParallel::registerDoParallel(2L)
BiocParallel::register(BiocParallel::DoparParam(), default = TRUE)

# set seed
set.seed(314159265)

res <- modelGeneExpression(
  mae = mae,
  xnames = "remap",
  nfolds = 5)

## -----------------------------------------------------------------------------
head(res$results$remap)

## ----fig.cap = "Predicted activities for the top-scoring molecular signatures"----
top_signatures <- head(res$results$remap, 10)
library(pheatmap)
pheatmap::pheatmap(
  mat = top_signatures[, c("12hr", "24hr")],
  scale = "none",
  labels_row = top_signatures$name,
  cluster_cols = FALSE,
  color = colorRampPalette(c("blue", "white", "red"))(15),
  breaks = seq(from = -0.1, to = 0.1, length.out = 16),
  main = "SLAM293 molecular signatures activities"
)

## -----------------------------------------------------------------------------
# obtain promoters annotation; *promoter name must be stored under column 'name'
promoters_f5 <- eh[["EH7303"]]
head(promoters_f5)

## -----------------------------------------------------------------------------
# obtain predicted CTCF binding for hg38;
# *TF/motif name must be stored under column 'name'
library("AnnotationHub")
ah <- AnnotationHub()
CTCF_hg38 <- ah[["AH104724"]]
CTCF_hg38$name <- "CTCF"
head(CTCF_hg38)

## -----------------------------------------------------------------------------
# construct molecular signatures matrix
molecular_signature <- getInteractionMatrix(
  a = promoters_f5,
  b = CTCF_hg38,
  ext = 500
)
head(molecular_signature)

## -----------------------------------------------------------------------------
sessionInfo()

