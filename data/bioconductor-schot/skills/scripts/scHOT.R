# Code example from 'scHOT' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  message = FALSE,
  warning = FALSE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(SingleCellExperiment)
library(ggplot2)
library(scHOT)
library(scater)
library(matrixStats)

## -----------------------------------------------------------------------------
data(liver)

liver_pseudotime_hep <- liver$liver_pseudotime_hep
liver_branch_hep <- liver$liver_branch_hep
first_branch_cells <- liver$first_branch_cells

## -----------------------------------------------------------------------------
gene_to_test <- as.matrix(c("Birc5", "H2afz", "Tacc3"))

## -----------------------------------------------------------------------------
scHOT_traj <- scHOT_buildFromMatrix(
  mat = liver_branch_hep[,first_branch_cells],
  cellData = list(pseudotime = liver_pseudotime_hep[first_branch_cells]),
  positionType = "trajectory",
  positionColData = "pseudotime")
scHOT_traj

## -----------------------------------------------------------------------------
scater::plotExpression(scHOT_traj, c("Sall4"),
                       exprs_values = "expression", x = "pseudotime")

## -----------------------------------------------------------------------------
scHOT_traj_wrap = scHOT(scHOT_traj,
                        testingScaffold = gene_to_test,
                        higherOrderFunction = matrixStats::weightedVar,
                        higherOrderFunctionType = "weighted",
                        numberPermutations = 50)

## -----------------------------------------------------------------------------
slot(scHOT_traj_wrap, "scHOT_output")
scHOT_traj_wrap@scHOT_output

slot(scHOT_traj_wrap, "scHOT_output")$higherOrderSequence

plotHigherOrderSequence(scHOT_traj_wrap, gene_to_test)

plotOrderedExpression(scHOT_traj_wrap, gene_to_test) + 
  facet_wrap(~gene, scales = "free_y")

## -----------------------------------------------------------------------------
scHOT_traj@testingScaffold
scHOT_traj <- scHOT_addTestingScaffold(scHOT_traj, gene_to_test)
scHOT_traj@testingScaffold

## -----------------------------------------------------------------------------
scHOT_traj@weightMatrix
scHOT_traj <- scHOT_setWeightMatrix(scHOT_traj,
                                    positionType = "trajectory",
                                    positionColData = c("pseudotime"),
                                    nrow.out = NULL,
                                    span = 0.25)
dim(scHOT_traj@weightMatrix)
class(scHOT_traj@weightMatrix)
plot(scHOT_traj@weightMatrix[50,])

## -----------------------------------------------------------------------------
scHOT_traj <- scHOT_setWeightMatrix(scHOT_traj,
                                    positionType = "trajectory",
                                    positionColData = c("pseudotime"),
                                    nrow.out = 50,
                                    span = 0.25)
dim(scHOT_traj@weightMatrix)
class(scHOT_traj@weightMatrix)
plot(scHOT_traj@weightMatrix[50,])

## -----------------------------------------------------------------------------
scHOT_traj <- scHOT_calculateGlobalHigherOrderFunction(
  scHOT_traj, 
  higherOrderFunction = matrixStats::weightedVar,
  higherOrderFunctionType = "weighted")

slot(scHOT_traj, "scHOT_output")
apply(assay(scHOT_traj, "expression")[c(gene_to_test),],1,var)

## -----------------------------------------------------------------------------
scHOT_traj <- scHOT_setPermutationScaffold(scHOT_traj, 
                                           numberPermutations = c(20,50,20),
                                           storePermutations = c(TRUE, FALSE, TRUE))
slot(scHOT_traj, "scHOT_output")

## -----------------------------------------------------------------------------
scHOT_traj <- scHOT_calculateHigherOrderTestStatistics(
  scHOT_traj,
  higherOrderSummaryFunction = sd)

slot(scHOT_traj, "scHOT_output")

## -----------------------------------------------------------------------------
system.time(scHOT_traj <- scHOT_performPermutationTest(
  scHOT_traj, 
  verbose = TRUE,
  parallel = FALSE))

slot(scHOT_traj, "scHOT_output")

## -----------------------------------------------------------------------------
scHOT_traj <- scHOT_estimatePvalues(scHOT_traj,
                                    nperm_estimate = 10000,
                                    maxDist = 5)
slot(scHOT_traj, "scHOT_output")

## -----------------------------------------------------------------------------
plotHigherOrderSequence(scHOT_traj, gene_to_test)

## -----------------------------------------------------------------------------
data(MOB_subset)
sce_MOB_subset <- MOB_subset$sce_MOB_subset

sce_MOB_subset

## -----------------------------------------------------------------------------
scHOT_spatial <- scHOT_buildFromSCE(sce_MOB_subset,
                                    assayName = "logcounts",
                                    positionType = "spatial",
                                    positionColData = c("x", "y"))

scHOT_spatial

## -----------------------------------------------------------------------------
pairs <- t(combn(rownames(sce_MOB_subset),2))
rownames(pairs) <- apply(pairs,1,paste0,collapse = "_")
head(pairs)

set.seed(2020)
pairs <- pairs[sample(nrow(pairs), 20), ]
if (!"Arrb1_Mtor" %in% rownames(pairs)) {
pairs <- rbind(pairs, "Arrb1_Mtor" = c("Arrb1", "Mtor"))
}
if (!"Dnm1l_Fam63b" %in% rownames(pairs)) {
pairs <- rbind(pairs, "Dnm1l_Fam63b" = c("Dnm1l", "Fam63b"))
}

scHOT_spatial <- scHOT_addTestingScaffold(scHOT_spatial, pairs)
scHOT_spatial@testingScaffold

## -----------------------------------------------------------------------------
scHOT_spatial <- scHOT_setWeightMatrix(scHOT_spatial,
                                       positionColData = c("x","y"),
                                       positionType = "spatial",
                                       nrow.out = NULL,
                                       span = 0.05)

dim(slot(scHOT_spatial, "weightMatrix"))

## -----------------------------------------------------------------------------
cellID = 75
ggplot(as.data.frame(colData(scHOT_spatial)), aes(x = -x, y = y)) + 
  geom_point(aes(colour = slot(scHOT_spatial, "weightMatrix")[cellID,],
                 size = slot(scHOT_spatial, "weightMatrix")[cellID,])) + 
  scale_colour_gradient(low = "black", high = "purple") + 
  scale_size_continuous(range = c(1,5)) +
  theme_classic() +
  guides(colour = guide_legend(title = "Spatial Weight"),
         size = guide_legend(title = "Spatial Weight")) + 
    ggtitle(paste0("Central cell: ", cellID))

## -----------------------------------------------------------------------------
scHOT_spatial <- scHOT_calculateGlobalHigherOrderFunction(
  scHOT_spatial, 
  higherOrderFunction = weightedSpearman,
  higherOrderFunctionType = "weighted")

slot(scHOT_spatial, "scHOT_output")

head(diag(cor(t(assay(scHOT_spatial, "expression")[pairs[,1],]),
         t(assay(scHOT_spatial, "expression")[pairs[,2],]),
         method = "spearman")))

## -----------------------------------------------------------------------------
scHOT_spatial <- scHOT_setPermutationScaffold(scHOT_spatial, 
                                              numberPermutations = 50,
                                              numberScaffold = 10)

slot(scHOT_spatial, "scHOT_output")

## -----------------------------------------------------------------------------
scHOT_spatial <- scHOT_calculateHigherOrderTestStatistics(scHOT_spatial)

slot(scHOT_spatial, "scHOT_output")

## -----------------------------------------------------------------------------
system.time(scHOT_spatial <- scHOT_performPermutationTest(
  scHOT_spatial, 
  verbose = TRUE,
  parallel = FALSE))

slot(scHOT_spatial, "scHOT_output")

## -----------------------------------------------------------------------------
scHOT_plotPermutationDistributions(scHOT_spatial)

scHOT_spatial <- scHOT_estimatePvalues(scHOT_spatial,
                                       nperm_estimate = 100,
                                       maxDist = 0.1)
slot(scHOT_spatial, "scHOT_output")

ggplot(as.data.frame(slot(scHOT_spatial, "scHOT_output")),
       aes(x = -log10(pvalPermutations), y = -log10(pvalEstimated))) + 
  geom_point() + 
  theme_classic() + 
  geom_abline(slope = 1, intercept = 0) +
  xlab("Permutation -log10(p-value)") +
  ylab("Estimated -log10(p-value)") +
  NULL

## -----------------------------------------------------------------------------
colData(scHOT_spatial)[, "-x"] <- -colData(scHOT_spatial)[, "x"]
plotHigherOrderSequence(scHOT_spatial, c("Dnm1l_Fam63b"),
                        positionColData = c("-x", "y"))

plotOrderedExpression(scHOT_spatial, c("Dnm1l", "Fam63b"),
                      positionColData = c("-x", "y"),
                      assayName = "expression")

## -----------------------------------------------------------------------------
scHOT_spatial <- scHOT_stripOutput(scHOT_spatial, force = TRUE)

scHOT_spatial
slot(scHOT_spatial, "scHOT_output")

## -----------------------------------------------------------------------------
scHOT_spatial <- scHOT(scHOT_spatial,
                       testingScaffold = pairs,
                       positionType = "spatial",
                       positionColData = c("x", "y"),
                       nrow.out = NULL,
                       higherOrderFunction = weightedSpearman,
                       higherOrderFunctionType = "weighted",
                       numberPermutations = 50,
                       numberScaffold = 10,
                       higherOrderSummaryFunction = sd,
                       parallel = FALSE,
                       verbose = FALSE,
                       span = 0.05)

slot(scHOT_spatial, "scHOT_output")

## -----------------------------------------------------------------------------
plotOrderedExpression(scHOT_spatial, c("Arrb1", "Mtor"),
                      positionColData = c("-x", "y"),
                      assayName = "expression")

plotHigherOrderSequence(scHOT_spatial, "Arrb1_Mtor",
                        positionColData = c("-x", "y"))

## -----------------------------------------------------------------------------
sessionInfo()

