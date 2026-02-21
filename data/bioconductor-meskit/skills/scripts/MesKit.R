# Code example from 'MesKit' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----echo=FALSE, paged.print=FALSE, rownames.print=FALSE----------------------
MAFtable <- read.table(system.file("extdata", "CRC_HZ.maf", package = "MesKit"), header=TRUE)
extractLines <- rbind(MAFtable[1, ], MAFtable[6600, ])
extractLines <- rbind(extractLines, MAFtable[15000, ])
data.frame(extractLines, row.names = NULL)

## ----echo=FALSE, paged.print=FALSE, rownames.print=FALSE----------------------
ClinInfo <- read.table(system.file("extdata", "CRC_HZ.clin.txt", package = "MesKit"), header = TRUE)
ClinInfo[1:5, ]

## ----echo=FALSE, paged.print=FALSE, rownames.print=FALSE----------------------
ccfInfo <- read.table(system.file("extdata", "CRC_HZ.ccf.tsv", package = "MesKit"), header = TRUE)
ccfInfo[1:5, ]

## ----echo=FALSE, paged.print=FALSE, rownames.print=FALSE----------------------
segInfo <- read.table(system.file("extdata", "CRC_HZ.seg.txt", package = "MesKit"), header = TRUE)
segInfo[1:5, ]

## ----eval=FALSE---------------------------------------------------------------
# # Installation of MesKit requires Bioconductor version 3.12 or higher
# if (!requireNamespace("BiocManager", quietly = TRUE)){
#   install.packages("BiocManager")
# }
# # The following initializes usage of Bioc 3.12
# BiocManager::install(version = "3.12")
# BiocManager::install("MesKit")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("devtools", quietly = TRUE)) {
#   install.packages("devtools")
# }
# devtools::install_github("Niinleslie/MesKit")

## ----message=FALSE,warning=FALSE----------------------------------------------
library(MesKit)

## -----------------------------------------------------------------------------
maf.File <- system.file("extdata/", "CRC_HZ.maf", package = "MesKit")
ccf.File <- system.file("extdata/", "CRC_HZ.ccf.tsv", package = "MesKit")
clin.File <- system.file("extdata", "CRC_HZ.clin.txt", package = "MesKit")
# Maf object with CCF information
maf <- readMaf(mafFile = maf.File,
               ccfFile = ccf.File,
               clinicalFile  = clin.File,
               refBuild = "hg19")  

## ----message=FALSE, fig.align='left', fig.width=11, fig.height=6.5------------
# Driver genes of CRC collected from [IntOGen] (https://www.intogen.org/search) (v.2020.2)
driverGene.file <- system.file("extdata/", "IntOGen-DriverGenes_COREAD.tsv", package = "MesKit")
driverGene <- as.character(read.table(driverGene.file)$V1)
mut.class <- classifyMut(maf, class =  "SP", patient.id = 'V402')
head(mut.class)

## ----message=FALSE, fig.align='left', fig.width=11, fig.height=6.5------------
plotMutProfile(maf, class =  "SP", geneList = driverGene, use.tumorSampleLabel = TRUE)

## ----message=FALSE------------------------------------------------------------
# Read segment file
segCN <- system.file("extdata", "CRC_HZ.seg.txt", package = "MesKit")
# Read gistic output files
all.lesions <- system.file("extdata", "COREAD_all_lesions.conf_99.txt", package = "MesKit")
amp.genes <- system.file("extdata", "COREAD_amp_genes.conf_99.txt", package = "MesKit")
del.genes <- system.file("extdata", "COREAD_del_genes.conf_99.txt", package = "MesKit")
seg <- readSegment(segFile = segCN, gisticAllLesionsFile = all.lesions,
                   gisticAmpGenesFile = amp.genes, gisticDelGenesFile = del.genes)
seg$V402[1:5, ]

## ----fig.width=10, fig.align='left', fig.height=5-----------------------------
plotCNA(seg, patient.id = c("V402", "V750", "V824"), use.tumorSampleLabel = TRUE)

## ----warning=FALSE, fig.width=8, fig.height=5---------------------------------
# calculate MATH score of each sample
mathScore(maf, patient.id = 'V402')

## ----fig.height=5, fig.width=6, message=FALSE---------------------------------
AUC <- ccfAUC(maf, patient.id = 'V402', use.tumorSampleLabel = TRUE)
names(AUC)

## ----fig.height=4, fig.width=4.5, message=FALSE, fig.align='left'-------------
# show cumulative density plot of CCF
AUC$CCF.density.plot

## ----message=FALSE, fig.height=4.5, fig.width=12------------------------------
mut.cluster <- mutCluster(maf, patient.id = 'V402', 
                          use.ccf = TRUE, use.tumorSampleLabel = TRUE)
clusterPlots <- mut.cluster$cluster.plot
cowplot::plot_grid(plotlist = clusterPlots[1:6])

## ----fig.align='left', fig.width=5, fig.height=4.5, fig.asp=1.0---------------
# calculate the Fst of brain metastasis from V402
calFst(maf, patient.id = 'V402', plot = TRUE, use.tumorSampleLabel = TRUE, 
       withinTumor  = TRUE, number.cex = 10)[["V402_BM"]]

## ----fig.align='left', fig.width=5, fig.height=4.5, fig.asp=1.0---------------
# calculate the Nei's genetic distance of brain metastasis from V402
calNeiDist(maf, patient.id = 'V402', use.tumorSampleLabel = TRUE, 
           withinTumor  = TRUE, number.cex = 10)[["V402_BM"]]

## ----fig.align='left', fig.width=4, fig.height=4.5, message=FALSE, warning=FALSE----
ccf.list <- compareCCF(maf, pairByTumor = TRUE, min.ccf = 0.02,
                       use.adjVAF = TRUE, use.indel = FALSE)
V402_P_BM <- ccf.list$V402$`P-BM`
# visualize via smoothScatter R package
graphics::smoothScatter(matrix(c(V402_P_BM[, 3], V402_P_BM[, 4]),ncol = 2),
                xlim = c(0, 1), ylim = c(0, 1),
                colramp = colorRampPalette(c("white", RColorBrewer::brewer.pal(9, "BuPu"))),
                xlab = "P", ylab = "BM")
  
## show driver genes
gene.idx <- which(V402_P_BM$Hugo_Symbol %in% driverGene) 
points(V402_P_BM[gene.idx, 3:4], cex = 0.6, col = 2, pch = 2)
text(V402_P_BM[gene.idx, 3:4], cex = 0.7, pos = 1,
       V402_P_BM$Hugo_Symbol[gene.idx])
title("V402 JSI = 0.341", cex.main = 1.5)

## ----fig.align='left', fig.width=7, fig.height=7, fig.asp=1.0-----------------
JSI.res <- calJSI(maf, patient.id = 'V402', pairByTumor = TRUE, min.ccf = 0.02, 
                  use.adjVAF = TRUE, use.indel = FALSE, use.tumorSampleLabel = TRUE)
names(JSI.res)

## ----fig.align='left', fig.width=7, fig.height=7, fig.asp=1.0-----------------
# show the JSI result
JSI.res$JSI.multi
JSI.res$JSI.pair

## ----message=FALSE, warning=FALSE, fig.height=4, fig.width=4------------------
neutralResult <- testNeutral(maf, min.mut.count = 10, patient.id = 'V402', use.tumorSampleLabel = TRUE)
neutralResult$neutrality.metrics
neutralResult$model.fitting.plot$P_1

## -----------------------------------------------------------------------------
phyloTree <- getPhyloTree(maf, patient.id = "V402", method = "NJ", min.vaf = 0.06)

## ----message=FALSE, warning=FALSE, fig.height=4, fig.width=10-----------------
tree.NJ <- getPhyloTree(maf, patient.id = 'V402', method = "NJ")
tree.MP <- getPhyloTree(maf, patient.id = 'V402', method = "MP")
# compare phylogenetic trees constructed by two approaches
compareTree(tree.NJ, tree.MP, plot = TRUE, use.tumorSampleLabel = TRUE)

## ----message=FALSE, warning=FALSE, fig.width=4.5, fig.height=4.5--------------
library(org.Hs.eg.db)
library(clusterProfiler)
# Pathway enrichment analysis
V402.branches <- getMutBranches(phyloTree)
# pathway enrichment for private mutated genes of the primary tumor in patient V402
V402_Public <- V402.branches[V402.branches$Mutation_Type == "Private_P", ]
geneIDs = suppressMessages(bitr(V402_Public$Hugo_Symbol, fromType="SYMBOL", 
                              toType=c("ENTREZID"), OrgDb="org.Hs.eg.db"))
KEGG_V402_Private_P  = enrichKEGG(
  gene = geneIDs$ENTREZID,
  organism = 'hsa',
  keyType = 'kegg',
  pvalueCutoff = 0.05,
)
dotplot(KEGG_V402_Private_P)

## ----message=FALSE, warning = FALSE-------------------------------------------
# load the genome reference
library(BSgenome.Hsapiens.UCSC.hg19)

## ----warning = FALSE, message=FALSE-------------------------------------------
mutClass <- mutTrunkBranch(phyloTree, CT = TRUE, plot = TRUE)
names(mutClass)

## ----warning = FALSE, message=FALSE, fig.height=4.5, fig.width=4.5------------
mutClass$mutTrunkBranch.res
mutClass$mutTrunkBranch.plot

## ----warning = FALSE, message=FALSE, fig.height=2.5, fig.width=8--------------
trimatrix_V402 <- triMatrix(phyloTree, level = 5)
# Visualize the 96 trinucleodide mutational profile
plotMutSigProfile(trimatrix_V402)[[1]]


## ----fig.height=5.2, fig.width=8----------------------------------------------
# reconstruct mutational profile of V402 using COSMIC V2 signatures
fit_V402 <- fitSignatures(trimatrix_V402, signaturesRef = "cosmic_v2")
# Compare the reconstructed mutational profile with the original mutational profile
plotMutSigProfile(fit_V402)[[1]]

## ----warning = FALSE, message=FALSE, fig.height=4,5, fig.width=7.5------------
# Below plot shows cosine similarities between the mutational profile of each group and COSMIC signatures
library(ComplexHeatmap)
ComplexHeatmap::Heatmap(fit_V402$V402$cosine.similarity, name = "Cosine similarity")

## ----fig.align='left', fig.width=12, fig.height=6, message=FALSE, warning=FALSE----
# A phylogenetic tree along with binary and CCF heatmap of mutations 
phylotree_V402 <- plotPhyloTree(phyloTree, use.tumorSampleLabel = TRUE)
binary_heatmap_V402 <- mutHeatmap(maf, min.ccf = 0.04, use.ccf = FALSE, patient.id = "V402", use.tumorSampleLabel = TRUE)
CCF_heatmap_V402 <- mutHeatmap(maf, use.ccf = TRUE, patient.id = "V402", 
                                 min.ccf = 0.04, use.tumorSampleLabel = TRUE)
cowplot::plot_grid(phylotree_V402, binary_heatmap_V402,
                   CCF_heatmap_V402, nrow = 1, rel_widths = c(1.5, 1, 1))

## -----------------------------------------------------------------------------
sessionInfo()

