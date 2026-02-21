# Code example from 'ANF' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy=FALSE, cache=TRUE,
dev="png",
message=FALSE, error=FALSE, warning=TRUE)

## -----------------------------------------------------------------------------
library(MASS)
true.class = rep(c(1,2),each=100)
feature.mat1 = mvrnorm(100, rep(0, 20), diag(runif(20,0.2,2)))
feature.mat2 = mvrnorm(100, rep(0.5, 20), diag(runif(20,0.2,2)))
feature1 = rbind(feature.mat1, feature.mat2)

## -----------------------------------------------------------------------------
library(igraph)
set.seed(1)
km = kmeans(feature1, 2)
compare(km$cluster, true.class, method='nmi')

## -----------------------------------------------------------------------------
library(ANF)
d = dist(feature1)
d = as.matrix(d)
A1 = affinity_matrix(d, 10)
labels = spectral_clustering(A1, 2)
compare(labels, true.class, method='nmi')

## -----------------------------------------------------------------------------
feature.mat1 = mvrnorm(100, rep(10, 30), diag(runif(30,0.2,3)))
feature.mat2 = mvrnorm(100, rep(9.5, 30), diag(runif(30,0.2,3)))
feature2 = rbind(feature.mat1, feature.mat2)

## -----------------------------------------------------------------------------
set.seed(123)
km = kmeans(feature2, 2)
compare(km$cluster, true.class, method='nmi')

d = dist(feature2)
d = as.matrix(d)
A2 = affinity_matrix(d, 10)
labels = spectral_clustering(A2, 2)
compare(labels, true.class, method='nmi')

## -----------------------------------------------------------------------------
feature.cat = cbind(feature1, feature2)
set.seed(1)
km = kmeans(feature.cat, 2)
compare(km$cluster, true.class, method='nmi')

## -----------------------------------------------------------------------------
W = ANF(list(A1, A2), K=30)
labels = spectral_clustering(W,2)
compare(labels, true.class, method='nmi')

## -----------------------------------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()
myfiles <- query(eh, "HarmonizedTCGAData")
Wall <- myfiles[[1]]
project_ids <- myfiles[[2]]
surv.plot <- myfiles[[3]]

## -----------------------------------------------------------------------------
affinity.mat <- Wall[["adrenal_gland"]][["log.sel"]][["fpkm"]]
labels <- spectral_clustering(affinity.mat, k = 2)

## -----------------------------------------------------------------------------
true.disease.types <- as.factor(project_ids[rownames(affinity.mat)])
table(labels, true.disease.types)

nmi <- igraph::compare(true.disease.types, labels, method = "nmi")

adjusted.rand = igraph::compare(true.disease.types, labels, method = "adjusted.rand")

# we can also calculate p-value using `surv.plot` data
surv.plot <- surv.plot[rownames(affinity.mat), ]
f <- survival::Surv(surv.plot$time, !surv.plot$censored)
fit <- survival::survdiff(f ~ labels)
pval <- stats::pchisq(fit$chisq, df = length(fit$n) - 1, lower.tail = FALSE)

message(paste("NMI =", nmi, ", ARI =", adjusted.rand, ", p-val =", pval))

## -----------------------------------------------------------------------------
res <- eval_clu(project_ids, w = affinity.mat, surv = surv.plot)

## -----------------------------------------------------------------------------
res <- eval_clu(project_ids, w = Wall$uterus$raw.all$fpkm)

## -----------------------------------------------------------------------------
# fuse three matrices: "fpkm" (gene expression), "mirnas" (miRNA expression) and "methy450" (DNA methylation)
fused.mat <- ANF(Wall = Wall$uterus$raw.all)
# Spectral clustering on fused patient affinity matrix
labels <- spectral_clustering(A = fused.mat, k = 2)
# Or we can directly evaluate clustering results using function `eval_clu`, which calls `spectral_clustering` and calculate NMI and ARI (and p-value if patient survival data is available. `surv.plot` does not contain information for uterus cancer patients)
res <- eval_clu(true_class = project_ids[rownames(fused.mat)], w = fused.mat)

