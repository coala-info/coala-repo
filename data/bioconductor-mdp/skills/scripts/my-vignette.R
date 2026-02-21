# Code example from 'my-vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(mdp)
data(example_data) # expression data has gene names in the rows
data(example_pheno) # pheno data needs a Sample and Class column
mdp.results <- mdp(data=example_data, pdata=example_pheno, control_lab = "baseline")

## -----------------------------------------------------------------------------
sample_scores_list <- mdp.results$sample_scores
# select sample scores calculated using the perturbed genes
sample_scores <- sample_scores_list[["perturbedgenes"]]
head(sample_scores)
sample_plot(sample_scores,control_lab = "baseline", title="perturbed")

## -----------------------------------------------------------------------------
zscore <- mdp.results$zscore

## -----------------------------------------------------------------------------
gene_scores <- mdp.results$gene_scores
gene_freq <- mdp.results$gene_freq
head(gene_scores)

## -----------------------------------------------------------------------------
perturbed_genes <- mdp.results$perturbed_genes

## ----results='hide',fig.show = 'hide'-----------------------------------------
file_address <- system.file("extdata", "ReactomePathways.gmt", package = "mdp")
pathways <- fgsea::gmtPathways(file_address)
mdp.results <- mdp(data=example_data, pdata=example_pheno, control_lab = "baseline",pathways=pathways)

## -----------------------------------------------------------------------------
head(mdp.results$pathways)
sample_scores <- mdp.results$sample_scores[["Interferon alpha/beta signaling"]]
sample_plot(sample_scores,control_lab = "baseline", title="Interferon a/b")


## ----results='hide',fig.show = 'hide'-----------------------------------------
mdp.results <- mdp(data=example_data, pdata=example_pheno, control_lab = "baseline", measure = "mean")

## -----------------------------------------------------------------------------
control_samples <- example_pheno[example_pheno$Class == "baseline","Sample"] 
zscore <- compute_zscore(data = example_data,control_samples = control_samples,measure = "mean",std = 2)

