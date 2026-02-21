# Code example from 'scpca_intro' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, message=FALSE, warning=FALSE--------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----install_bioc, eval=FALSE-------------------------------------------------
# BiocManager::install("scPCA")

## ----install_github, eval=FALSE-----------------------------------------------
# remotes::install_github("PhilBoileau/scPCA")

## ----load_libs, message=FALSE, warning=FALSE----------------------------------
library(dplyr)
library(ggplot2)
library(ggpubr)
library(elasticnet)
library(scPCA)
library(microbenchmark)

## ----PCA_sim------------------------------------------------------------------
# set seed for reproducibility
set.seed(1742)

# load data
data(toy_df)

# perform PCA
pca_sim <- prcomp(toy_df[, 1:30])

# plot the 2D rep using first 2 components
df <- as_tibble(list("PC1" = pca_sim$x[, 1],
                     "PC2" = pca_sim$x[, 2],
                     "label" = as.character(toy_df[, 31])))
p_pca <- ggplot(df, aes(x = PC1, y = PC2, colour = label)) +
  ggtitle("PCA on Simulated Data") +
  geom_point(alpha = 0.5) +
  theme_minimal()
p_pca

## ----sPCA_sim-----------------------------------------------------------------
# perform sPCA on toy_df for a range of L1 penalty terms
penalties <- exp(seq(log(10), log(1000), length.out = 6))
df_ls <- lapply(penalties, function(penalty) {
  spca_sim_p <- elasticnet::spca(toy_df[, 1:30], K = 2, para = rep(penalty, 2),
                     type = "predictor", sparse = "penalty")$loadings
  spca_sim_p <- as.matrix(toy_df[, 1:30]) %*% spca_sim_p
  spca_out <- list("SPC1" = spca_sim_p[, 1],
                   "SPC2" = spca_sim_p[, 2],
                   "penalty" = round(rep(penalty, nrow(toy_df))),
                   "label"  = as.character(toy_df[, 31])) %>%
    as_tibble()
  return(spca_out)
})
df <- dplyr::bind_rows(df_ls)

# plot the results of sPCA
p_spca <- ggplot(df, aes(x = SPC1, y = SPC2, colour = label)) +
  geom_point(alpha = 0.5) +
  ggtitle("SPCA on Simulated Data for Varying L1 Penalty Terms") +
  facet_wrap(~ penalty, nrow = 2) +
  theme_minimal()
p_spca

## ----cPCA_sim-----------------------------------------------------------------
cpca_sim <- scPCA(target = toy_df[, 1:30],
                  background = background_df,
                  penalties = 0,
                  n_centers = 4)

# create a dataframe to be plotted
cpca_df <- cpca_sim$x %>%
  as_tibble() %>%
  mutate(label = toy_df[, 31] %>% as.character)
colnames(cpca_df) <- c("cPC1", "cPC2", "label")

# plot the results
p_cpca <- ggplot(cpca_df, aes(x = cPC1, y = cPC2, colour = label)) +
  geom_point(alpha = 0.5) +
  ggtitle("cPCA of Simulated Data") +
  theme_minimal()
p_cpca

## ----scPCA_sim, warning=FALSE-------------------------------------------------
# run scPCA for using 40 logarithmically seperated contrastive parameter values
# and possible 20 L1 penalty terms
scpca_sim <- scPCA(target = toy_df[, 1:30],
                   background = background_df,
                   n_centers = 4,
                   penalties = exp(seq(log(0.01), log(0.5), length.out = 10)),
                   alg = "var_proj")

# create a dataframe to be plotted
scpca_df <- scpca_sim$x %>%
  as_tibble() %>%
  mutate(label = toy_df[, 31] %>% as.character)
colnames(scpca_df) <- c("scPC1", "scPC2", "label")

# plot the results
p_scpca <- ggplot(scpca_df, aes(x = scPC1, y = scPC2, colour = label)) +
  geom_point(alpha = 0.5) +
  ggtitle("scPCA of Simulated Data") +
  theme_minimal()
p_scpca


# create the loadings comparison plot
scpca_sim$rotation[, 1] <- -scpca_sim$rotation[, 1]
load_diff_df <- bind_rows(
  cpca_sim$rotation %>% as.data.frame,
  scpca_sim$rotation %>% as.data.frame
  ) %>%
  mutate(
    sparse = c(rep("0", 30), rep("1", 30)),
    coef = rep(1:30, 2)
  )
colnames(load_diff_df) <- c("comp1", "comp2", "sparse", "coef")

p1 <- load_diff_df %>%
  ggplot(aes(y = comp1, x = coef, fill = sparse)) +
  geom_bar(stat = "identity") +
  xlab("") +
  ylab("") +
  ylim(-1.4, 1.4) +
  ggtitle("First Component") +
  scale_fill_discrete(name = "Method", labels = c("cPCA", "scPCA")) +
  theme_minimal()

p2 <- load_diff_df %>%
  ggplot(aes(y = comp2, x = coef, fill = sparse)) +
  geom_bar(stat = "identity") +
  xlab("") +
  ylab("") +
  ylim(-1.4, 1.4) +
  ggtitle("Second Component") +
  scale_fill_discrete(name = "Method", labels = c("cPCA", "scPCA")) +
  theme_minimal()

# build full plot via ggpubr
annotate_figure(
  ggarrange(p1, p2, nrow = 1, ncol = 2,
            common.legend = TRUE, legend = "right"),
  top = "Leading Loadings Vectors Comparison",
  left = "Loading Weights",
  bottom = "Variable Index"
)

## ----cPCA_sim_cv--------------------------------------------------------------
cpca_cv_sim <- scPCA(target = toy_df[, 1:30],
                     background = background_df,
                     penalties = 0,
                     n_centers = 4,
                     cv = 3)

# create a dataframe to be plotted
cpca_cv_df <- cpca_cv_sim$x %>%
  as_tibble() %>%
  dplyr::mutate(label = toy_df[, 31] %>% as.character)
colnames(cpca_cv_df) <- c("cPC1", "cPC2", "label")

# plot the results
p_cpca_cv <- ggplot(cpca_cv_df, aes(x = cPC1, y = cPC2, colour = label)) +
  geom_point(alpha = 0.5) +
  ggtitle("cPCA of Simulated Data") +
  theme_minimal()

## ----scPCA_sim_cv-------------------------------------------------------------
scpca_cv_sim <- scPCA(target = toy_df[, 1:30],
                      background = background_df,
                      n_centers = 4,
                      cv = 3,
                      penalties = exp(seq(log(0.01), log(0.5), length.out = 10)),
                      alg = "var_proj")

# create a dataframe to be plotted
scpca_cv_df <- scpca_cv_sim$x %>%
  as_tibble() %>%
  mutate(label = toy_df[, 31] %>% as.character)
colnames(scpca_cv_df) <- c("scPC1", "scPC2", "label")

# plot the results
p_scpca_cv <- ggplot(scpca_cv_df, aes(x = -scPC1, y = -scPC2, colour = label)) +
  geom_point(alpha = 0.5) +
  ggtitle("scPCA of Simulated Data") +
  theme_minimal()

## ----plot_cv_cPCA_scPCA, echo=FALSE-------------------------------------------
ggarrange(
  p_cpca_cv, p_scpca_cv,
  nrow = 1,
  common.legend = TRUE,
  legend = "right"
)

## ----microbenchmark_comparison, warning=FALSE, message=FALSE------------------
timing_scPCA <- microbenchmark(
  "Zou et al." = scPCA(target = toy_df[, 1:30],
                       background = background_df,
                       n_centers = 4,
                       alg = "iterative"),
  "Erichson et al. SPCA" = scPCA(target = toy_df[, 1:30],
                                 background = background_df,
                                 n_centers = 4,
                                 alg = "var_proj"),
  "Erichson et al. RSPCA" = scPCA(target = toy_df[, 1:30],
                                  background = background_df,
                                  n_centers = 4,
                                  alg = "rand_var_proj"),
  times = 3
)

autoplot(timing_scPCA, log = TRUE) +
  ggtitle("Running Time Comparison") +
  theme_minimal()

## ----sce_setup, message=FALSE-------------------------------------------------
library(splatter)
library(SingleCellExperiment)

# Simulate the three groups of cells. Mask cell heterogeneity with batch effect
params <- newSplatParams(
  seed = 6757293,
  nGenes = 500,
  batchCells = c(150, 150),
  batch.facLoc = c(0.05, 0.05),
  batch.facScale = c(0.05, 0.05),
  group.prob = c(0.333, 0.333, 0.334),
  de.prob = c(0.1, 0.05, 0.1),
  de.downProb = c(0.1, 0.05, 0.1),
  de.facLoc = rep(0.2, 3),
  de.facScale = rep(0.2, 3)
)
sim_sce <- splatSimulate(params, method = "groups")

## ----make_sce_subs, message=FALSE---------------------------------------------
# rank genes by variance
n_genes <- 250
vars <- assay(sim_sce) %>%
  log1p %>%
  rowVars
names(vars) <- rownames(sim_sce)
vars <- sort(vars, decreasing = TRUE)

# subset SCE to n_genes with highest variance
sce_sub <- sim_sce[names(vars[seq_len(n_genes)]),]
sce_sub

# split the subsetted SCE into target and background SCEs
tg_sce <- sce_sub[, sce_sub$Group %in% c("Group1", "Group3")]
bg_sce <- sce_sub[, sce_sub$Group %in% c("Group2")]

## ----perform_dimred, message=FALSE--------------------------------------------
# for both cPCA and scPCA, we'll set the penalties and contrasts arguments
contrasts <- exp(seq(log(0.1), log(100), length.out = 5))
penalties <- exp(seq(log(0.001), log(0.1), length.out = 3))

# first, PCA
pca_out <- prcomp(t(log1p(counts(tg_sce))), center = TRUE, scale. = TRUE)

# next, cPCA
cpca_out <- scPCA(t(log1p(counts(tg_sce))),
                  t(log1p(counts(bg_sce))),
                  n_centers = 2,
                  n_eigen = 2,
                  contrasts = contrasts,
                  penalties = 0,
                  center = TRUE,
                  scale = TRUE)

# finally, scPCA
scpca_out <- scPCA(t(log1p(counts(tg_sce))),
                   t(log1p(counts(bg_sce))),
                   n_centers = 2,
                   n_eigen = 2,
                   contrasts = contrasts,
                   penalties = penalties,
                   center = TRUE,
                   scale = TRUE,
                   alg = "var_proj")

# store new representations in the SingleCellExperiment object
reducedDims(tg_sce) <- SimpleList(PCA = pca_out$x[, 1:2],
                                  cPCA = cpca_out$x,
                                  scPCA = scpca_out$x)
tg_sce

## ----plot_red_dims, echo=FALSE, fig.asp=.25, out.width="1600px"---------------
# plot the 2D representations

# prepare PCA
pca_df <- data.frame(
  PC1 = pca_out$x[, 1],
  PC2 = pca_out$x[, 2],
  group = tg_sce$Group,
  batch = tg_sce$Batch
)
pca_p <- pca_df %>%
  ggplot(aes(x = PC1, y = PC2, colour = group, shape = batch)) +
  geom_point(alpha = 0.75) +
  ggtitle("PCA") +
  scale_colour_viridis_d(name = "Target Group", labels = c("1", "2"),
                         begin = 0.1, end = 0.9) +
  scale_shape_discrete(name = "Batch") +
  theme_minimal()

# prepare cPCA
cpca_df <- data.frame(
  cPC1 = cpca_out$x[, 1],
  cPC2 = cpca_out$x[, 2],
  group = tg_sce$Group,
  batch = tg_sce$Batch
)
cpca_p <- cpca_df %>%
  ggplot(aes(x = cPC1, y = cPC2, colour = group, shape = batch)) +
  geom_point(alpha = 0.75) +
  ggtitle("cPCA") +
  scale_colour_viridis_d(name = "Target Group", labels = c("1", "2"),
                         begin = 0.1, end = 0.9) +
  scale_shape_discrete(name = "Batch") +
  theme_minimal()

# prepare scPCA
scpca_df <- data.frame(
  scPC1 = scpca_out$x[, 1],
  scPC2 = scpca_out$x[, 2],
  group = tg_sce$Group,
  batch = tg_sce$Batch
)
scpca_p <- scpca_df %>%
  ggplot(aes(x = scPC1, y = scPC2, colour = group, shape = batch)) +
  geom_point(alpha = 0.75) +
  ggtitle("scPCA") +
  scale_colour_viridis_d(name = "Target Group", labels = c("1", "2"),
                         begin = 0.1, end = 0.9) +
  scale_shape_discrete(name = "Batch") +
  theme_minimal()

# combine the plots
ggarrange(
  pca_p, cpca_p, scpca_p,
  nrow = 1,
  common.legend = TRUE,
  legend = "right"
)

## ----bpscpca, eval=FALSE------------------------------------------------------
# # perform the same operations in parallel using BiocParallel
# library(BiocParallel)
# param <- MulticoreParam()
# register(param)
# 
# # perfom cPCA
# cpca_bp <- scPCA(
#   target = toy_df[, 1:30],
#   background = background_df,
#   contrasts = exp(seq(log(0.1), log(100), length.out = 10)),
#   penalties = 0,
#   n_centers = 4,
#   parallel = TRUE
# )
# 
# # perform scPCA
# scpca_bp <- scPCA(
#   target = toy_df[, 1:30],
#   background = background_df,
#   contrasts = exp(seq(log(0.1), log(100), length.out = 10)),
#   penalties = seq(0.1, 1, length.out = 9),
#   n_centers = 4,
#   parallel = TRUE
# )

## ----session_info, echo=FALSE-------------------------------------------------
sessionInfo()

