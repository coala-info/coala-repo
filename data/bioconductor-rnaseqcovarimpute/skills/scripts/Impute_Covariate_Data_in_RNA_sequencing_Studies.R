# Code example from 'Impute_Covariate_Data_in_RNA_sequencing_Studies' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# # Install from github
# library(devtools)
# install_github("brennanhilton/RNAseqCovarImpute")
# 
# # Install from Bioconductor (not yet on Bioconductor)
# 
# if (!require("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("RNAseqCovarImpute")

## -----------------------------------------------------------------------------
library(RNAseqCovarImpute)
library(dplyr)
library(BiocParallel)
library(PCAtools)
library(limma)
library(mice)
data(example_data)
data(example_DGE)

## -----------------------------------------------------------------------------
# We use voom to convert counts to logCPM values, adding 0.5 to all the counts to avoid taking the logarithm of zero, and normalized for library size.
start.pca = Sys.time() # To calculate runtime
pca_data = limma::voom(example_DGE)$E
# Conduct pca
p = PCAtools::pca(pca_data)
# Determine the number of PCs that account for >80% explained variation
which(cumsum(p$variance) > 80)[1]
# Extract the PCs and append to our data
pcs = p$rotated[,1:78]
example_data = cbind(example_data, pcs)

## -----------------------------------------------------------------------------
# Conduct mice. In practice, m should be much larger (e.g., 10-100)
imp = mice::mice(example_data, m=3)

## -----------------------------------------------------------------------------
mi_pca_res = RNAseqCovarImpute::limmavoom_imputed_data_pca(imp = imp,
                                                           DGE = example_DGE,
                                                           voom_formula = "~x + y + z + a + b",
                                                           BPPARAM = SerialParam())

# Display the results for the first 5 genes for the x variable in the model.
mi_pca_res[1:5, grep("^x", colnames(mi_pca_res))]

## -----------------------------------------------------------------------------
mi_pca_res_x = mi_pca_res %>% 
  arrange(x_p) %>% 
  mutate(x_p_adj = p.adjust(x_p, method = "fdr")) %>% 
  dplyr::select(probe, x_coef, x_p, x_p_adj)

end.pca = Sys.time() # To calculate runtime
time.pca = end.pca - start.pca # To calculate runtime
# Display the results for the first 5 genes
mi_pca_res_x[1:5,]

## -----------------------------------------------------------------------------
# Get back the original example_data without the PCs appended
data(example_data)
start.old.method = Sys.time() # To calculate runtime
intervals <- get_gene_bin_intervals(example_DGE, example_data, n = 10)

## ----message=FALSE, warning=FALSE, echo=FALSE---------------------------------
intervals %>%
    head(10) %>%
    knitr::kable(digits = 3, caption = "The first 10 gene bins. Start and end columns indicate row numbers for the beginning and end of each bin. Number indicates the number of genes in each bin.")

## -----------------------------------------------------------------------------
# Randomize the order of gene identifiers
annot <- example_DGE$genes
annot <- annot[sample(seq_len(nrow(annot))), ]
# Match order of the genes in the DGE to the randomized order of genes in the annotation
example_DGE <- example_DGE[annot, ]

## -----------------------------------------------------------------------------
gene_bin_impute <- impute_by_gene_bin(example_data,
    intervals,
    example_DGE,
    m = 3
)

## -----------------------------------------------------------------------------
gene_bin_impute <- impute_by_gene_bin(example_data,
    intervals,
    example_DGE,
    m = 3,
    BPPARAM = SerialParam()
)

## -----------------------------------------------------------------------------
coef_se <- limmavoom_imputed_data_list(
    gene_intervals = intervals,
    DGE = example_DGE,
    imputed_data_list = gene_bin_impute,
    m = 3,
    voom_formula = "~x + y + z + a + b"
)

## -----------------------------------------------------------------------------
final_res <- combine_rubins(
    DGE = example_DGE,
    model_results = coef_se,
    predictor = "x"
)

end.old.method = Sys.time() # To calculate runtime
time.old.method = end.old.method - start.old.method

## ----message=FALSE, warning=FALSE, echo=FALSE---------------------------------
final_res %>%
    dplyr::select(probe, coef_combined, combined_p_bayes, combined_p_adj_bayes) %>%
    head(10) %>%
    knitr::kable(digits = 3, caption = "The top 10 genes associated with predictor x sorted by lowest P-value")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

