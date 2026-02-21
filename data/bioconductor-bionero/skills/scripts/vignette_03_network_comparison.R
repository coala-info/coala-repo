# Code example from 'vignette_03_network_comparison' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  message = TRUE,
  warning = FALSE,
  cache = FALSE,
  fig.align = 'center',
  fig.width = 5,
  fig.height = 4,
  crop = NULL
)

## ----installation, eval=FALSE-------------------------------------------------
# if(!requireNamespace('BiocManager', quietly = TRUE))
#   install.packages('BiocManager')
# 
# BiocManager::install("BioNERO")

## ----load_package-------------------------------------------------------------
# Load package after installation
library(BioNERO)
set.seed(12) # for reproducibility

## ----inspect_data-------------------------------------------------------------
data(zma.se)
zma.se

data(osa.se)
osa.se

## ----create_list_consensus----------------------------------------------------
# Preprocess data and keep top 2000 genes with highest variances
filt_zma <- exp_preprocess(zma.se, variance_filter = TRUE, n = 2000)

# Create different subsets by resampling data
zma_set1 <- filt_zma[, sample(colnames(filt_zma), size=22, replace=FALSE)]
zma_set2 <- filt_zma[, sample(colnames(filt_zma), size=22, replace=FALSE)]
colnames(zma_set1)
colnames(zma_set2)

# Create list
zma_list <- list(set1 = zma_set1, set2 = zma_set2)
length(zma_list)

## ----consensus_sft, message=FALSE---------------------------------------------
cons_sft <- consensus_SFT_fit(zma_list, setLabels = c("Maize 1", "Maize 2"),
                              cor_method = "pearson")

## ----sft_results, fig.width=8-------------------------------------------------
powers <- cons_sft$power
powers
cons_sft$plot

## ----consensus_modules_identification-----------------------------------------
consensus <- consensus_modules(zma_list, power = powers, cor_method = "pearson")
names(consensus)
head(consensus$genes_cmodules)

## ----consensus_trait_cor, fig.width=5, fig.height=5---------------------------
consensus_trait <- consensus_trait_cor(consensus, cor_method = "pearson")
head(consensus_trait)

## ----plot-consensus-trait-cor, fig.width = 5, fig.height = 6------------------
plot_module_trait_cor(consensus_trait)

## ----load_orthogroups---------------------------------------------------------
data(og.zma.osa)
head(og.zma.osa)

## ----genes2orthogorups--------------------------------------------------------
# Store SummarizedExperiment objects in a list
zma_osa_list <- list(osa = osa.se, zma = zma.se)

# Collapse gene-level expression to orthogroup-level
ortho_exp <- exp_genes2orthogroups(zma_osa_list, og.zma.osa, summarize = "mean")

# Inspect new expression data
ortho_exp$osa[1:5, 1:5]
ortho_exp$zma[1:5, 1:5]

## ----create_list_preservation-------------------------------------------------
# Preprocess data and keep top 1000 genes with highest variances
ortho_exp <- lapply(ortho_exp, exp_preprocess, variance_filter=TRUE, n=1000)

# Check orthogroup number
sapply(ortho_exp, nrow)

## ----gcn_inference------------------------------------------------------------
# Calculate SFT power
power_ortho <- lapply(ortho_exp, SFT_fit, cor_method="pearson")

# Infer GCNs
gcns <- lapply(seq_along(power_ortho), function(n) 
  exp2gcn(ortho_exp[[n]], SFTpower = power_ortho[[n]]$power, 
          cor_method = "pearson")
  )

length(gcns)

## ----preservation-------------------------------------------------------------
# Using rice as reference and maize as test
pres <- module_preservation(ortho_exp, 
                            ref_net = gcns[[1]], 
                            test_net = gcns[[2]], 
                            algorithm = "netrep")

## ----singleton----------------------------------------------------------------
# Sample 50 random genes
genes <- sample(rownames(zma.se), size = 50)
is_singleton(genes, og.zma.osa)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

