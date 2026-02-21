# Code example from 'introduction_to_phenopath' vignette. See references/ for full tutorial.

## ----load-packages, include=FALSE---------------------------------------------
knitr::opts_chunk$set(fig.width = 5, fig.height = 3)

suppressPackageStartupMessages({
  library(dplyr)
  library(dplyr)
  library(ggplot2)
  library(tidyr)
  library(forcats)
  library(phenopath)
})

## ----simulate-data------------------------------------------------------------
set.seed(123L)
sim <- simulate_phenopath()

## ----sim-structure------------------------------------------------------------
print(str(sim))

## ----some-genes, fig.width = 7------------------------------------------------
genes_to_extract <- c(1,3,11,13,21,23,31,33)
expression_df <- as.data.frame(sim$y[,genes_to_extract])
names(expression_df) <- paste0("gene_", genes_to_extract)

df_gex <- as_tibble(expression_df) %>% 
  mutate(x = factor(sim[['x']]), z = sim[['z']]) %>% 
  gather(gene, expression, -x, -z)

ggplot(df_gex, aes(x = z, y = expression, color = x)) +
  geom_point() +
  facet_wrap(~ gene, nrow = 2) +
  scale_color_brewer(palette = "Set1")

## ----pcaing, fig.show = 'hold'------------------------------------------------
pca_df <- as_tibble(as.data.frame(prcomp(sim$y)$x[,1:2])) %>% 
  mutate(x = factor(sim[['x']]), z = sim[['z']])

ggplot(pca_df, aes(x = PC1, y = PC2, color = x)) +
  geom_point() + scale_colour_brewer(palette = "Set1")

ggplot(pca_df, aes(x = PC1, y = PC2, color = z)) +
  geom_point()

## ----see-results, cache=TRUE--------------------------------------------------
fit <- phenopath(sim$y, sim$x, elbo_tol = 1e-6, thin = 40)
print(fit)

## ----plot-elbo----------------------------------------------------------------
plot_elbo(fit)

## ----plot-results, fig.show = 'hold', fig.width = 2.5, fig.height = 2.5-------
qplot(sim$z, trajectory(fit)) +
  xlab("True z") + ylab("Phenopath z")
qplot(sim$z, pca_df$PC1) +
  xlab("True z") + ylab("PC1")

## ----print-correlation--------------------------------------------------------
cor(sim$z, trajectory(fit))

## ----beta-df, fig.width = 6, fig.height = 3-----------------------------------
gene_names <- paste0("gene", seq_len(ncol(fit$m_beta)))
df_beta <- data_frame(beta = interaction_effects(fit),
                      beta_sd = interaction_sds(fit),
                      is_sig = significant_interactions(fit),
                      gene = gene_names)

df_beta$gene <- fct_relevel(df_beta$gene, gene_names)

ggplot(df_beta, aes(x = gene, y = beta, color = is_sig)) + 
  geom_point() +
  geom_errorbar(aes(ymin = beta - 2 * beta_sd, ymax = beta + 2 * beta_sd)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        axis.title.x = element_blank()) +
  ylab(expression(beta)) +
  scale_color_brewer(palette = "Set2", name = "Significant")

## ----graph-largest-effect-size------------------------------------------------
which_largest <- which.max(df_beta$beta)

df_large <- data_frame(
  y = sim[['y']][, which_largest],
  x = factor(sim[['x']]),
  z = sim[['z']]
)

ggplot(df_large, aes(x = z, y = y, color = x)) +
  geom_point() +
  scale_color_brewer(palette = "Set1") +
  stat_smooth()

## ----construct-sceset, warning = FALSE----------------------------------------
suppressPackageStartupMessages(library(SummarizedExperiment))
exprs_mat <- t(sim$y)
pdata <- data.frame(x = sim$x)
sce <- SummarizedExperiment(assays = list(exprs = exprs_mat), 
                            colData = pdata)
sce

## ----example-using-expressionset, eval = FALSE--------------------------------
# fit <- phenopath(sce, sim$x) # 1
# fit <- phenopath(sce, "x") # 2
# fit <- phenopath(sce, ~ x) # 3

## ----initialisation-examples, eval = FALSE------------------------------------
# fit <- phenopath(sim$y, sim$x, z_init = 1) # 1, initialise to first principal component
# fit <- phenopath(sim$y, sim$x, z_init = sim$z) # 2, initialise to true values
# fit <- phenopath(sim$y, sim$x, z_init = "random") # 3, random initialisation

## ----cavi-tuning, eval = FALSE------------------------------------------------
# fit <- phenopath(sim$y, sim$x,
#                  maxiter = 1000, # 1000 iterations max
#                  elbo_tol = 1e-2, # consider model converged when change in ELBO < 0.02%
#                  thin = 20 # calculate ELBO every 20 iterations
#                  )

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

