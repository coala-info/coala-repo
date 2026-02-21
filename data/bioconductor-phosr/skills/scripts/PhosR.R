# Code example from 'PhosR' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# 
# library(devtools)
# devtools::install_github("PYangLab/PhosR")

## ----eval = FALSE-------------------------------------------------------------
# #if (!requireNamespace("BiocManager", quietly = TRUE))
# #    install.packages("BiocManager")
# #
# #BiocManager::install("PhosR")

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
    library(PhosR)
})

## -----------------------------------------------------------------------------
data("phospho_L6_ratio")

ppe <- PhosphoExperiment(assays = list(Quantification = as.matrix(phospho.L6.ratio)))
class(ppe)

## -----------------------------------------------------------------------------
GeneSymbol(ppe) <- sapply(strsplit(rownames(ppe), ";"), "[[", 2)
Residue(ppe) <- gsub("[0-9]","", sapply(strsplit(rownames(ppe), ";"), "[[", 3))
Site(ppe) <- as.numeric(gsub("[A-Z]","", sapply(strsplit(rownames(ppe), ";"), "[[", 3)))
Sequence(ppe) <- sapply(strsplit(rownames(ppe), ";"), "[[", 4)

## -----------------------------------------------------------------------------
ppe <- PhosphoExperiment(assays = list(Quantification = as.matrix(phospho.L6.ratio)), 
                  Site = as.numeric(gsub("[A-Z]","", sapply(strsplit(rownames(ppe), ";"), "[[", 3))),
                  GeneSymbol = sapply(strsplit(rownames(ppe), ";"), "[[", 2),
                  Residue = gsub("[0-9]","", sapply(strsplit(rownames(ppe), ";"), "[[", 3)),
                  Sequence = sapply(strsplit(rownames(ppe), ";"), "[[", 4))

## -----------------------------------------------------------------------------
ppe

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
  library(PhosR)
})

## -----------------------------------------------------------------------------
data("phospho.cells.Ins.pe")

ppe <- phospho.cells.Ins.pe 
class(ppe)

## -----------------------------------------------------------------------------
ppe

## -----------------------------------------------------------------------------
grps = gsub("_[0-9]{1}", "", colnames(ppe))

## -----------------------------------------------------------------------------
# FL38B
gsub("Intensity.", "", grps)[1:12]
# Hepa1
gsub("Intensity.", "", grps)[13:24]

## -----------------------------------------------------------------------------
dim(ppe)

## -----------------------------------------------------------------------------
ppe_filtered <- selectGrps(ppe, grps, 0.5, n=1) 
dim(ppe_filtered)

## -----------------------------------------------------------------------------
# In cases where you have fewer replicates ( e.g.,triplicates), you may want to 
# select phosphosites quantified in 70% of replicates. 
ppe_filtered_v1 <- selectGrps(ppe, grps, 0.7, n=1) 
dim(ppe_filtered_v1)

## -----------------------------------------------------------------------------
set.seed(123)
ppe_imputed_tmp <- scImpute(ppe_filtered, 0.5, grps)[,colnames(ppe_filtered)]

## -----------------------------------------------------------------------------
set.seed(123)
ppe_imputed <- ppe_imputed_tmp
ppe_imputed[,seq(6)] <- ptImpute(ppe_imputed[,seq(7,12)], 
                                 ppe_imputed[,seq(6)], 
                                 percent1 = 0.6, percent2 = 0, paired = FALSE)
ppe_imputed[,seq(13,18)] <- ptImpute(ppe_imputed[,seq(19,24)], 
                                     ppe_imputed[,seq(13,18)], 
                                     percent1 = 0.6, percent2 = 0, 
                                     paired = FALSE)

## -----------------------------------------------------------------------------
ppe_imputed_scaled <- medianScaling(ppe_imputed, scale = FALSE, assay = "imputed")

## -----------------------------------------------------------------------------
p1 = plotQC(SummarizedExperiment::assay(ppe_filtered,"Quantification"), 
    labels=colnames(ppe_filtered), 
    panel = "quantify", grps = grps)
p2 = plotQC(SummarizedExperiment::assay(ppe_imputed_scaled,"scaled"), 
    labels=colnames(ppe_imputed_scaled), panel = "quantify", grps = grps)
ggpubr::ggarrange(p1, p2, nrow = 1)

## -----------------------------------------------------------------------------
p1 = plotQC(SummarizedExperiment::assay(ppe_filtered,"Quantification"), 
       labels=colnames(ppe_filtered), panel = "dendrogram", 
       grps = grps)
p2 = plotQC(SummarizedExperiment::assay(ppe_imputed_scaled,"scaled"), 
       labels=colnames(ppe_imputed_scaled), 
       panel = "dendrogram", grps = grps)
ggpubr::ggarrange(p1, p2, nrow = 1)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
  library(PhosR)
  library(stringr)
  library(ggplot2)
})

## -----------------------------------------------------------------------------
data("phospho_L6_ratio_pe")
data("SPSs")

ppe <- phospho.L6.ratio.pe
ppe

## -----------------------------------------------------------------------------
colnames(ppe)[grepl("AICAR_", colnames(ppe))]
colnames(ppe)[grepl("^Ins_", colnames(ppe))]
colnames(ppe)[grepl("AICARIns_", colnames(ppe))]

## -----------------------------------------------------------------------------
dim(ppe)

## -----------------------------------------------------------------------------
sum(is.na(SummarizedExperiment::assay(ppe,"Quantification")))

## -----------------------------------------------------------------------------
sites = paste(sapply(GeneSymbol(ppe), function(x)x),";",
                 sapply(Residue(ppe), function(x)x),
                 sapply(Site(ppe), function(x)x),
                 ";", sep = "")

## -----------------------------------------------------------------------------
# take the grouping information
grps = gsub("_.+", "", colnames(ppe))
grps

## -----------------------------------------------------------------------------
plotQC(SummarizedExperiment::assay(ppe,"Quantification"), panel = "dendrogram", 
    grps=grps, labels = colnames(ppe)) +
    ggplot2::ggtitle("Before batch correction")

## -----------------------------------------------------------------------------
plotQC(SummarizedExperiment::assay(ppe,"Quantification"), grps=grps, 
    labels = colnames(ppe), panel = "pca") +
    ggplot2::ggtitle("Before batch correction")

## -----------------------------------------------------------------------------
design = model.matrix(~ grps - 1)
design

## -----------------------------------------------------------------------------
# phosphoproteomics data normalisation and batch correction using RUV
ctl = which(sites %in% SPSs)
ppe = RUVphospho(ppe, M = design, k = 3, ctl = ctl)

## -----------------------------------------------------------------------------
# plot after batch correction
p1 = plotQC(SummarizedExperiment::assay(ppe, "Quantification"), grps=grps, 
    labels = colnames(ppe), panel = "dendrogram" )
p2 = plotQC(SummarizedExperiment::assay(ppe, "normalised"), grps=grps, 
    labels = colnames(ppe), panel="dendrogram")
ggpubr::ggarrange(p1, p2, nrow = 1)

## -----------------------------------------------------------------------------
# plot after batch correction
p1 = plotQC(SummarizedExperiment::assay(ppe, "Quantification"), panel = "pca", 
    grps=grps, labels = colnames(ppe)) +
    ggplot2::ggtitle("Before Batch correction")
p2 = plotQC(SummarizedExperiment::assay(ppe, "normalised"), grps=grps, 
    labels = colnames(ppe), panel="pca") +
    ggplot2::ggtitle("After Batch correction")
ggpubr::ggarrange(p1, p2, nrow = 2)

## -----------------------------------------------------------------------------
data("phospho_L6_ratio_pe")
data("phospho.liver.Ins.TC.ratio.RUV.pe")
data("phospho.cells.Ins.pe")
ppe1 <- phospho.L6.ratio.pe
ppe2 <- phospho.liver.Ins.TC.ratio.RUV.pe
# ppe2 <- phospho.L1.Ins.ratio.subset.pe
ppe3 <- phospho.cells.Ins.pe

## -----------------------------------------------------------------------------
grp3 = gsub('_[0-9]{1}', '', colnames(ppe3))
ppe3 <- selectGrps(ppe3, grps = grp3, 0.5, n=1)
ppe3 <- tImpute(ppe3)
FL83B.ratio <- SummarizedExperiment::assay(ppe3, "imputed")[, 1:12] - 
    rowMeans(SummarizedExperiment::assay(ppe3, "imputed")[,grep("FL83B_Control", 
        colnames(ppe3))])
Hepa.ratio <- SummarizedExperiment::assay(ppe3,"imputed")[, 13:24] - 
    rowMeans(SummarizedExperiment::assay(ppe3,"imputed")[,grep("Hepa1.6_Control", 
        colnames(ppe3))])
SummarizedExperiment::assay(ppe3, "Quantification") <- 
    cbind(FL83B.ratio, Hepa.ratio)

## -----------------------------------------------------------------------------
ppe.list <- list(ppe1, ppe2, ppe3)
# ppe.list <- list(ppe1, ppe3)

cond.list <- list(grp1 = gsub("_.+", "", colnames(ppe1)),
                  grp2 = str_sub(colnames(ppe2), end=-5),
                  grp3 = str_sub(colnames(ppe3), end=-3))

## -----------------------------------------------------------------------------
inhouse_SPSs <- getSPS(ppe.list, conds = cond.list)

head(inhouse_SPSs)

## -----------------------------------------------------------------------------
sites = paste(sapply(GeneSymbol(ppe), function(x)x),";",
              sapply(Residue(ppe), function(x)x),
              sapply(Site(ppe), function(x)x), ";", sep = "")

ctl = which(sites %in% inhouse_SPSs)
ppe = RUVphospho(ppe, M = design, k = 3, ctl = ctl)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
  library(calibrate)
  library(limma)
  library(directPA)
  library(org.Rn.eg.db)
  library(reactome.db)
  library(annotate)
  library(PhosR)
})

## -----------------------------------------------------------------------------
data("PhosphoSitePlus")

## ----include = FALSE----------------------------------------------------------
data("phospho_L6_ratio")
data("SPSs")

##### Run batch correction
ppe <- phospho.L6.ratio.pe
sites = paste(sapply(GeneSymbol(ppe), function(x)x),";",
                 sapply(Residue(ppe), function(x)x),
                 sapply(Site(ppe), function(x)x),
                 ";", sep = "")
grps = gsub("_.+", "", colnames(ppe))
design = model.matrix(~ grps - 1)
ctl = which(sites %in% SPSs)
ppe = RUVphospho(ppe, M = design, k = 3, ctl = ctl)

## -----------------------------------------------------------------------------
sites = paste(sapply(GeneSymbol(ppe), function(x)x),";",
                 sapply(Residue(ppe), function(x)x),
                 sapply(Site(ppe), function(x)x),
                 ";", sep = "")

## -----------------------------------------------------------------------------
f <- gsub("_exp\\d", "", colnames(ppe))
X <- model.matrix(~ f - 1)
fit <- lmFit(SummarizedExperiment::assay(ppe, "normalised"), X)

## -----------------------------------------------------------------------------
table.AICAR <- topTable(eBayes(fit), number=Inf, coef = 1)
table.Ins <- topTable(eBayes(fit), number=Inf, coef = 3)
table.AICARIns <- topTable(eBayes(fit), number=Inf, coef = 2)


DE1.RUV <- c(sum(table.AICAR[,"adj.P.Val"] < 0.05), sum(table.Ins[,"adj.P.Val"] < 0.05), sum(table.AICARIns[,"adj.P.Val"] < 0.05))

# extract top-ranked phosphosites for each group comparison
contrast.matrix1 <- makeContrasts(fAICARIns-fIns, levels=X)  # defining group comparisons
contrast.matrix2 <- makeContrasts(fAICARIns-fAICAR, levels=X)  # defining group comparisons
fit1 <- contrasts.fit(fit, contrast.matrix1)
fit2 <- contrasts.fit(fit, contrast.matrix2)
table.AICARInsVSIns <- topTable(eBayes(fit1), number=Inf)
table.AICARInsVSAICAR <- topTable(eBayes(fit2), number=Inf)


DE2.RUV <- c(sum(table.AICARInsVSIns[,"adj.P.Val"] < 0.05), sum(table.AICARInsVSAICAR[,"adj.P.Val"] < 0.05))

o <- rownames(table.AICARInsVSIns)
Tc <- cbind(table.Ins[o,"logFC"], table.AICAR[o,"logFC"], table.AICARIns[o,"logFC"])

rownames(Tc) <- sites[match(o, rownames(ppe))]
rownames(Tc) <- gsub("(.*)(;[A-Z])([0-9]+)(;)", "\\1;\\3;", rownames(Tc))

colnames(Tc) <- c("Ins", "AICAR", "AICAR+Ins")

## -----------------------------------------------------------------------------
Tc.gene <- phosCollapse(Tc, id=gsub(";.+", "", rownames(Tc)), 
                        stat=apply(abs(Tc), 1, max), by = "max")
geneSet <- names(sort(Tc.gene[,1], 
                        decreasing = TRUE))[seq(round(nrow(Tc.gene) * 0.1))]

head(geneSet)

## -----------------------------------------------------------------------------
pathways = as.list(reactomePATHID2EXTID)

path_names = as.list(reactomePATHID2NAME)
name_id = match(names(pathways), names(path_names))
names(pathways) = unlist(path_names)[name_id]

pathways = pathways[which(grepl("Rattus norvegicus", names(pathways), ignore.case = TRUE))]

pathways = lapply(pathways, function(path) {
    gene_name = unname(getSYMBOL(path, data = "org.Rn.eg"))
    toupper(unique(gene_name))
})

## -----------------------------------------------------------------------------
path1 <- pathwayOverrepresent(geneSet, annotation=pathways, 
                                universe = rownames(Tc.gene), alter = "greater")
path2 <- pathwayRankBasedEnrichment(Tc.gene[,1], 
                                    annotation=pathways, 
                                    alter = "greater")

## -----------------------------------------------------------------------------
lp1 <- -log10(as.numeric(path2[names(pathways),1]))
lp2 <- -log10(as.numeric(path1[names(pathways),1]))
plot(lp1, lp2, ylab="Overrepresentation (-log10 pvalue)", xlab="Rank-based enrichment (-log10 pvalue)", main="Comparison of 1D pathway analyses", xlim = c(0, 10))

# select highly enriched pathways
sel <- which(lp1 > 1.5 & lp2 > 0.9)
textxy(lp1[sel], lp2[sel], gsub("_", " ", gsub("REACTOME_", "", names(pathways)))[sel])

## -----------------------------------------------------------------------------
# 2D direction site-centric kinase activity analyses
par(mfrow=c(1,2))
dpa1 <- directPA(Tc[,c(1,3)], direction=0, 
                 annotation=lapply(PhosphoSite.rat, function(x){gsub(";[STY]", ";", x)}), 
                 main="Direction pathway analysis")
dpa2 <- directPA(Tc[,c(1,3)], direction=pi*7/4, 
                 annotation=lapply(PhosphoSite.rat, function(x){gsub(";[STY]", ";", x)}), 
                 main="Direction pathway analysis")

# top activated kinases
dpa1$pathways[1:5,]
dpa2$pathways[1:5,]

## -----------------------------------------------------------------------------
z1 <- perturbPlot2d(Tc=Tc[,c(1,2)], 
                    annotation=lapply(PhosphoSite.rat, function(x){gsub(";[STY]", ";", x)}),
                    cex=1, xlim=c(-2, 4), ylim=c(-2, 4), 
                    main="Kinase perturbation analysis")
z2 <- perturbPlot2d(Tc=Tc[,c(1,3)], annotation=lapply(PhosphoSite.rat, function(x){gsub(";[STY]", ";", x)}),
                    cex=1, xlim=c(-2, 4), ylim=c(-2, 4), 
                    main="Kinase perturbation analysis")
z3 <- perturbPlot2d(Tc=Tc[,c(2,3)], annotation=lapply(PhosphoSite.rat, function(x){gsub(";[STY]", ";", x)}),
                    cex=1, xlim=c(-2, 4), ylim=c(-2, 4), 
                    main="Kinase perturbation analysis")

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
  library(parallel)
  library(ggplot2)
  library(ClueR)
  library(reactome.db)
  library(org.Mm.eg.db)
  library(annotate)
  library(PhosR)
})

## -----------------------------------------------------------------------------
# data("phospho_liverInsTC_RUV_pe")
data("phospho.liver.Ins.TC.ratio.RUV.pe")
ppe <- phospho.liver.Ins.TC.ratio.RUV.pe
ppe

## -----------------------------------------------------------------------------
# take grouping information

grps <- sapply(strsplit(colnames(ppe), "_"), 
            function(x)x[3])

# select differentially phosphorylated sites
sites.p <- matANOVA(SummarizedExperiment::assay(ppe, "Quantification"), 
                    grps)
ppm <- meanAbundance(SummarizedExperiment::assay(ppe, "Quantification"), grps)
sel <- which((sites.p < 0.05) & (rowSums(abs(ppm) > 1) != 0))
ppm_filtered <- ppm[sel,]

# summarise phosphosites information into gene level
ppm_gene <- phosCollapse(ppm_filtered, 
            gsub(";.+", "", rownames(ppm_filtered)), 
                stat = apply(abs(ppm_filtered), 1, max), by = "max")

# perform ClueR to identify optimal number of clusters
pathways = as.list(reactomePATHID2EXTID)

pathways = pathways[which(grepl("R-MMU", names(pathways), ignore.case = TRUE))]

pathways = lapply(pathways, function(path) {
    gene_name = unname(getSYMBOL(path, data = "org.Mm.eg"))
    toupper(unique(gene_name))
})

RNGkind("L'Ecuyer-CMRG")
set.seed(123)
c1 <- runClue(ppm_gene, annotation=pathways, 
            kRange = seq(2,10), rep = 5, effectiveSize = c(5, 100), 
            pvalueCutoff = 0.05, alpha = 0.5)

# Visualise the evaluation results
data <- data.frame(Success=as.numeric(c1$evlMat), Freq=rep(seq(2,10), each=5))
myplot <- ggplot(data, aes(x=Freq, y=Success)) + 
    geom_boxplot(aes(x = factor(Freq), fill="gray")) +
    stat_smooth(method="loess", colour="red", size=3, span = 0.5) +
    xlab("# of cluster") + 
    ylab("Enrichment score") + 
    theme_classic()
myplot

set.seed(123)
best <- clustOptimal(c1, rep=5, mfrow=c(2, 3), visualize = TRUE)

## -----------------------------------------------------------------------------
RNGkind("L'Ecuyer-CMRG")
set.seed(1)
PhosphoSite.mouse2 = mapply(function(kinase) {
  gsub("(.*)(;[A-Z])([0-9]+;)", "\\1;\\3", kinase)
}, PhosphoSite.mouse)

# perform ClueR to identify optimal number of clusters
c3 <- runClue(ppm_filtered, annotation=PhosphoSite.mouse2, kRange = 2:10, rep = 5, effectiveSize = c(5, 100), pvalueCutoff = 0.05, alpha = 0.5)

# Visualise the evaluation results
data <- data.frame(Success=as.numeric(c3$evlMat), Freq=rep(2:10, each=5))

myplot <- ggplot(data, aes(x=Freq, y=Success)) + geom_boxplot(aes(x = factor(Freq), fill="gray"))+
  stat_smooth(method="loess", colour="red", size=3, span = 0.5) + xlab("# of cluster")+ ylab("Enrichment score")+theme_classic()
myplot

set.seed(1)
best <- clustOptimal(c3, rep=10, mfrow=c(2, 3), visualize = TRUE)

# Finding enriched pathways from each cluster
best$enrichList

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({

  library(PhosR)
  library(dplyr)
  library(ggplot2)
  library(GGally)
  library(ggpubr)
  library(calibrate)
  library(network)
})

## -----------------------------------------------------------------------------
data("KinaseMotifs")
data("KinaseFamily")
data("phospho_L6_ratio_pe")
data("SPSs")

ppe = phospho.L6.ratio.pe
sites = paste(sapply(GeneSymbol(ppe), function(x)x),";",
                 sapply(Residue(ppe), function(x)x),
                 sapply(Site(ppe), function(x)x),
                 ";", sep = "")
grps = gsub("_.+", "", colnames(ppe))
design = model.matrix(~ grps - 1)
ctl = which(sites %in% SPSs)
ppe = RUVphospho(ppe, M = design, k = 3, ctl = ctl)

## -----------------------------------------------------------------------------
data("phospho_L6_ratio")
data("SPSs")

##### Run batch correction
ppe <- phospho.L6.ratio.pe
sites = paste(sapply(GeneSymbol(ppe), function(x)x),";",
                 sapply(Residue(ppe), function(x)x),
                 sapply(Site(ppe), function(x)x),
                 ";", sep = "")
grps = gsub("_.+", "", colnames(ppe))
design = model.matrix(~ grps - 1)
ctl = which(sites %in% SPSs)
ppe = RUVphospho(ppe, M = design, k = 3, ctl = ctl)


phosphoL6 = SummarizedExperiment::assay(ppe, "normalised")

## -----------------------------------------------------------------------------
# filter for up-regulated phosphosites

phosphoL6.mean <- meanAbundance(phosphoL6, grps = gsub("_.+", "", colnames(phosphoL6)))
aov <- matANOVA(mat=phosphoL6, grps=gsub("_.+", "", colnames(phosphoL6)))
idx <- (aov < 0.05) & (rowSums(phosphoL6.mean > 0.5) > 0)
phosphoL6.reg <- phosphoL6[idx, ,drop = FALSE]

L6.phos.std <- standardise(phosphoL6.reg)
rownames(L6.phos.std) <- paste0(GeneSymbol(ppe), ";", Residue(ppe), Site(ppe), ";")[idx]

## -----------------------------------------------------------------------------
L6.phos.seq <- Sequence(ppe)[idx]

## ----fig.height=15, fig.width=5-----------------------------------------------
L6.matrices <- kinaseSubstrateScore(substrate.list = PhosphoSite.mouse, 
                                    mat = L6.phos.std, seqs = L6.phos.seq, 
                                    numMotif = 5, numSub = 1, verbose = FALSE)
set.seed(1)
L6.predMat <- kinaseSubstratePred(L6.matrices, top=30, verbose = FALSE) 

## ----fig.height=10, fig.width=10----------------------------------------------
kinaseOI = c("PRKAA1", "AKT1")

Signalomes_results <- Signalomes(KSR=L6.matrices, 
                                predMatrix=L6.predMat, 
                                exprsMat=L6.phos.std, 
                                KOI=kinaseOI)

## ----fig.height=6, fig.width=15-----------------------------------------------
### generate palette
my_color_palette <- grDevices::colorRampPalette(RColorBrewer::brewer.pal(8, "Accent"))
kinase_all_color <- my_color_palette(ncol(L6.matrices$combinedScoreMatrix))
names(kinase_all_color) <- colnames(L6.matrices$combinedScoreMatrix)
kinase_signalome_color <- kinase_all_color[colnames(L6.predMat)]

plotSignalomeMap(signalomes = Signalomes_results, color = kinase_signalome_color)

## ----fig.height=5, fig.width=5------------------------------------------------
plotKinaseNetwork(KSR = L6.matrices, predMatrix = L6.predMat, threshold = 0.9, color = kinase_all_color)

## -----------------------------------------------------------------------------
sessionInfo()

