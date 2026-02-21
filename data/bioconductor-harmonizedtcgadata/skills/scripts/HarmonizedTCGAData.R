# Code example from 'HarmonizedTCGAData' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()
myfiles <- query(eh, "HarmonizedTCGAData")
Wall <- myfiles[[1]]
project_ids <- myfiles[[2]]
surv.plot <- myfiles[[3]]

## -----------------------------------------------------------------------------
names(Wall)

## -----------------------------------------------------------------------------
names(Wall[[1]][[1]]) #Note: "fpkm" refers to gene expression measurement, which can be HTSeq-Counts, transformed HTSeq-Counts (log2 transformation or variance-stabilizing transformation), and FPKM values. Sorry for the confusing name.

## -----------------------------------------------------------------------------
names(Wall[[1]])

## -----------------------------------------------------------------------------
library(ANF)
affinity.mat <- Wall[["adrenal_gland"]][["log.sel"]][["fpkm"]]
labels <- spectral_clustering(affinity.mat, k = 2)

## -----------------------------------------------------------------------------
true.disease.types <- as.factor(project_ids[rownames(affinity.mat)])
print(table(labels, true.disease.types))

nmi <- igraph::compare(true.disease.types, labels, method = "nmi")

adjusted.rand = igraph::compare(true.disease.types, labels, method = "adjusted.rand")

# we can also calculate p-value using `surv.plot` data
surv.plot <- surv.plot[rownames(affinity.mat), ]
f <- survival::Surv(surv.plot$time, !surv.plot$censored)
fit <- survival::survdiff(f ~ labels)
pval <- stats::pchisq(fit$chisq, df = length(fit$n) - 1, lower.tail = FALSE)

print(paste("NMI =", nmi, ", ARI =", adjusted.rand, ", p-val =", pval))

## -----------------------------------------------------------------------------
res <- eval_clu(project_ids, w = affinity.mat, surv = surv.plot)
res$labels

## -----------------------------------------------------------------------------
res <- eval_clu(project_ids, w = Wall$uterus$raw.all$fpkm)

## -----------------------------------------------------------------------------
# fuse three matrices: "fpkm" (gene expression), "mirnas" (miRNA expression) and "methy450" (DNA methylation)
fused.mat <- ANF(Wall = Wall$uterus$raw.all)
# Spectral clustering on fused patient affinity matrix
labels <- spectral_clustering(A = fused.mat, k = 2)
# Or we can directly evaluate clustering results using function `eval_clu`, which calls `spectral_clustering` and calculate NMI and ARI (and p-value if patient survival data is available. `surv.plot` does not contain information for uterus cancer patients)
res <- eval_clu(true_class = project_ids[rownames(fused.mat)], w = fused.mat)

