# Code example from 'splatPop' vignette. See references/ for full tutorial.

## ----knitr-options, include = FALSE-------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----setup--------------------------------------------------------------------
suppressPackageStartupMessages({
    library("splatter")
    library("scater")
    library("VariantAnnotation")
    library("ggplot2")
})
set.seed(42)

## ----quick-start--------------------------------------------------------------
vcf <- mockVCF()
gff <- mockGFF()

sim <- splatPopSimulate(vcf = vcf, gff = gff, sparsify = FALSE)
sim <- logNormCounts(sim)
sim <- runPCA(sim, ncomponents = 5)
plotPCA(sim, colour_by = "Sample")

## ----eqtlEstimate-------------------------------------------------------------
bulk.means <- mockBulkMatrix(n.genes = 100, n.samples = 100)
bulk.eqtl <- mockBulkeQTL(n.genes = 100)
counts <- mockSCE()

params.est <- splatPopEstimate(
    means = bulk.means,
    eqtl = bulk.eqtl,
    counts = counts
)
params.est

## ----splatPopSimulateMeans----------------------------------------------------
params <- newSplatPopParams()

sim.means <- splatPopSimulateMeans(
    vcf = vcf,
    gff = gff,
    params = params
)

round(sim.means$means[1:5, 1:3], digits = 2)

print(sim.means$key[1:5, ], digits = 2)

print(sim.means$conditions)

## ----splatPopSimulateMeans-from-key-------------------------------------------
sim.means.rep2 <- splatPopSimulateMeans(
    vcf = vcf,
    key = sim.means$key,
    params = newSplatPopParams()
)

round(sim.means.rep2$means[1:5, 1:5], digits = 2)

## ----quant-normalize-population-data------------------------------------------
bulk.qnorm <- splatPopQuantNorm(newSplatPopParams(), bulk.means)
round(bulk.qnorm[1:5, 1:5], 3)

## ----empirical-mock-data------------------------------------------------------
emp <- mockEmpiricalSet()
head(emp$eqtl[, c("geneID", "snpID", "snpCHR", "snpLOC", "snpMAF", "slope")])

## ----empirical-based-simulation-----------------------------------------------
emp.sim <- splatPopSimulateMeans(
    vcf = emp$vcf,
    gff = emp$gff,
    eqtl = emp$eqtl,
    means = emp$means,
    params = newSplatPopParams()
)
head(emp.sim$key)

## ----eqtl-splatPopSimulateSC-simple-object------------------------------------
sim.sc <- splatPopSimulateSC(
    params = params,
    key = sim.means$key,
    sim.means = sim.means$means,
    batchCells = 50,
    sparsify = FALSE
)
sim.sc

## ----eqtl-splatPopSimulateSC-simple-plots-------------------------------------
sim.sc <- logNormCounts(sim.sc)
sim.sc <- runPCA(sim.sc, ncomponents = 10)
plotPCA(sim.sc, colour_by = "Sample")

## ----splatPop-simulation-nCells-sampled---------------------------------------
params.nCells <- newSplatPopParams(
    nCells.sample = TRUE,
    nCells.shape = 1.5,
    nCells.rate = 0.01
)

sim.sc.nCells <- splatPopSimulate(
    vcf = vcf,
    gff = gff,
    params = params.nCells,
    sparsify = FALSE
)

sim.sc.nCells <- logNormCounts(sim.sc.nCells)
sim.sc.nCells <- runPCA(sim.sc.nCells, ncomponents = 2)
plotPCA(sim.sc.nCells, colour_by = "Sample")

## ----group-specific-eQTL-simulations------------------------------------------
params.group <- newSplatPopParams(
    batchCells = 50,
    group.prob = c(0.5, 0.5)
)

sim.sc.gr2 <- splatPopSimulate(
    vcf = vcf,
    gff = gff,
    params = params.group,
    sparsify = FALSE
)

sim.sc.gr2 <- logNormCounts(sim.sc.gr2)
sim.sc.gr2 <- runPCA(sim.sc.gr2, ncomponents = 10)
plotPCA(sim.sc.gr2, colour_by = "Group", shape_by = "Sample")

## ----group-specific-eQTL-simulations-bigger-----------------------------------
params.group <- newSplatPopParams(
    batchCells = 50,
    similarity.scale = 8,
    eqtl.group.specific = 0.6,
    de.prob = 0.5,
    de.facLoc = 0.5,
    de.facScale = 0.5,
    group.prob = c(0.5, 0.5)
)

sim.sc.gr2 <- splatPopSimulate(
    vcf = vcf,
    gff = gff,
    params = params.group,
    sparsify = FALSE
)

sim.sc.gr2 <- logNormCounts(sim.sc.gr2)
sim.sc.gr2 <- runPCA(sim.sc.gr2, ncomponents = 10)
plotPCA(sim.sc.gr2, colour_by = "Group", shape_by = "Sample")

## ----simulate-population-with-condition-effects-------------------------------
params.cond <- newSplatPopParams(
    eqtl.n = 0.5,
    batchCells = 50,
    similarity.scale = 5,
    condition.prob = c(0.5, 0.5),
    eqtl.condition.specific = 0.5,
    cde.facLoc = 1,
    cde.facScale = 1
)

sim.pop.cond <- splatPopSimulate(
    vcf = vcf,
    gff = gff,
    params = params.cond,
    sparsify = FALSE
)

sim.pop.cond <- logNormCounts(sim.pop.cond)
sim.pop.cond <- runPCA(sim.pop.cond, ncomponents = 10)
plotPCA(
    sim.pop.cond,
    colour_by = "Condition",
    shape_by = "Sample",
    point_size = 3
)

## ----simulate-population-with-batch-effects-----------------------------------
params.batches <- newSplatPopParams(
    similarity.scale = 4,
    batchCells = c(20, 20),
    batch.size = 3,
    batch.facLoc = 0.1,
    batch.facScale = 0.2
)

sim.pop.batches <- splatPopSimulate(
    vcf = vcf,
    gff = gff,
    params = params.batches,
    sparsify = FALSE
)
sim.pop.batches <- logNormCounts(sim.pop.batches)
sim.pop.batches <- runPCA(sim.pop.batches, ncomponents = 10)
plotPCA(
    sim.pop.batches,
    colour_by = "Sample",
    shape_by = "Batch",
    point_size = 3
)

## ----simulate-population-with-different-sized-batch-effects-------------------
params.batches <- newSplatPopParams(
    similarity.scale = 8,
    batchCells = c(5, 5, 5),
    batch.size = 3,
    batch.facLoc = c(0.5, 0.1, 0.1),
    batch.facScale = c(0.6, 0.15, 0.15)
)

sim.pop.batches <- splatPopSimulate(
    vcf = vcf,
    gff = gff,
    params = params.batches,
    sparsify = FALSE
)
sim.pop.batches <- logNormCounts(sim.pop.batches)
sim.pop.batches <- runPCA(sim.pop.batches, ncomponents = 10)
plotPCA(
    sim.pop.batches,
    colour_by = "Sample",
    shape_by = "Batch",
    point_size = 3
)

## ----simulate-population-with-coregulation, fig.height=2----------------------
params.coreg <- newSplatPopParams(eqtl.coreg = 0.4, eqtl.ES.rate = 2)
vcf <- mockVCF(n.sample = 20, n.snps = 1200)
gff <- mockGFF(n.genes = 100)
sim.coreg <- splatPopSimulateMeans(vcf = vcf, gff = gff, params = params.coreg)
key <- sim.coreg$key
sim.cor <- cor(t(sim.coreg$means))
coregSNPs <- names(which(table(sim.coreg$key$eSNP.ID) == 2))

coregCorList <- c()
for (snp in coregSNPs) {
    coregGenes <- row.names(sim.coreg$key)[which(sim.coreg$key$eSNP.ID == snp)]
    coregCorList <- c(coregCorList, sim.cor[coregGenes[1], coregGenes[2]])
}

randCorList <- c()
for (n in 1:1000) {
    genes <- sample(row.names(sim.coreg$key), 2)
    randCorList <- c(randCorList, sim.cor[genes[1], genes[2]])
}

cor.df <- as.data.frame(list(
    type = c(
        rep("coregulated pairs", length(coregCorList)),
        rep("random pairs", length(randCorList))
    ),
    correlation = c(coregCorList, randCorList),
    id = "x"
))

ggplot(cor.df, aes(x = correlation, y = id, color = type, alpha = type)) +
    geom_jitter(size = 2, width = 0.1) +
    scale_alpha_discrete(range = c(0.6, 0.1)) +
    stat_summary(fun = mean, geom = "pointrange", size = 1, alpha = 1) +
    theme_minimal() +
    theme(
        axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        legend.position = "top"
    ) +
    xlim(c(-1, 1)) +
    scale_color_manual(values = c("#56B4E9", "#999999"))

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

