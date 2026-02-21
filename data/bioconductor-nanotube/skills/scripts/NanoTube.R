# Code example from 'NanoTube' vignette. See references/ for full tutorial.

## ----setup, echo = FALSE, results = "hide"------------------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      cache = FALSE,
                      dev = "png",
                      message = FALSE, error = FALSE, warning = TRUE,
                      fig.height = 4, fig.width = 4)

library(kableExtra)

## ----Basic1-------------------------------------------------------------------

library(NanoTube)

example_data <- system.file("extdata", "GSE117751_RAW", package = "NanoTube")
sample_info <- system.file("extdata", 
                           "GSE117751_sample_data.csv", 
                           package = "NanoTube")


## ----Basic2-------------------------------------------------------------------

dat <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info,
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis")


## ----BasicGroups--------------------------------------------------------------

table(dat$groups)


## ----Basic3-------------------------------------------------------------------

limmaResults <- runLimmaAnalysis(dat, base.group = "None")


## ----Basic3b------------------------------------------------------------------

limmaStats <- makeDiffExprFile(limmaResults, filename = NULL, returns = "stats")
limmaStats <- as.data.frame(limmaStats)

# Rounding for clarity
limmaTab <- head(limmaStats[order(limmaStats$`p-val (Autoimmune.retinopathy)`, 
                      decreasing = FALSE), 1:4])
limmaTab[,1] <- format(limmaTab[,1], digits = 2, nsmall = 1)
limmaTab[,3] <- format(limmaTab[,3], digits = 1, scientific = TRUE)
limmaTab[,4] <- format(limmaTab[,4], digits = 1, nsmall = 1)

# Order by lowest to highest p-value for 'Autoimmune Retinopathy' vs. 'None'
knitr::kable(head(limmaTab), 
      row.names = TRUE, format = "html", align = "c")



## ----BasicVol-----------------------------------------------------------------

deVolcano(limmaResults, plotContrast = "Autoimmune.retinopathy")


## ----Basic4-------------------------------------------------------------------

data("ExamplePathways")

fgseaResults <- limmaToFGSEA(limmaResults, gene.sets = ExamplePathways)

# FGSEA was run separately for Autoimmune Retinopathy vs. None and 
# Retinitis Pigmentosa vs. None
names(fgseaResults)


## ----BasicTab-----------------------------------------------------------------

fgseaTab <- head(fgseaResults$Autoimmune.retinopathy[
             order(fgseaResults$Autoimmune.retinopathy$pval, 
                   decreasing = FALSE),])
fgseaTab[,2:6] <- lapply(fgseaTab[,2:6], format, digits = 1, nsmall = 1)

knitr::kable(fgseaTab, 
      row.names = FALSE, format = "html", align = "c")



## ----proc1--------------------------------------------------------------------

# Without supplying idCol, a warning is returned.
# The CSV file contains samples in the proper order, so this is technically ok.
dat <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info, 
                             groupCol = "Sample_Diagnosis",
                             normalization = "nSolver",
                             bgType = "t.test", bgPVal = 0.01,
                             skip.housekeeping = FALSE,
                             output.format = "ExpressionSet")


## ----proc1idCol---------------------------------------------------------------

# With idCol
dat <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info, 
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "nSolver",
                             bgType = "t.test", bgPVal = 0.01,
                             skip.housekeeping = FALSE,
                             output.format = "ExpressionSet")


## ----proc2--------------------------------------------------------------------

csv_data <- system.file("extdata", 
                        "GSE117751_expression_matrix.csv", 
                        package = "NanoTube")

dat2 <- processNanostringData(nsFile = csv_data,
                             sampleTab = sample_info, 
                             idCol = "GEO_Accession", 
                             groupCol = "Sample_Diagnosis",
                             normalization = "none")


## ----norm1--------------------------------------------------------------------

# Set housekeeping genes manually (optional)
hk.genes <- c("TUBB", "TBP", "POLR2A", "GUSB", "SDHA")

dat <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info, 
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "nSolver",
                             bgType = "t.test", bgPVal = 0.01,
                             housekeeping = hk.genes, skip.housekeeping = FALSE)


## ----norm2--------------------------------------------------------------------

# Automatically detect housekeeping genes

dat <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info, 
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "nSolver",
                             bgType = "t.test", bgPVal = 0.01)


## ----normRUVIII---------------------------------------------------------------

# This sample data table contains fake replicate identifiers (for use in example).
sample_info_reps <- system.file("extdata", 
                           "GSE117751_sample_data_replicates.csv", 
                           package = "NanoTube")

datRUVIII <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info_reps, 
                             idCol = "RCC_Name",
                             replicateCol = "Replicate_ID",
                             groupCol = "Sample_Diagnosis",
                             normalization = "RUVIII",
                             bgType = "t.test", bgPVal = 0.01,
                             n.unwanted = 1)


## ----normRUVg-----------------------------------------------------------------

hk.genes <- c("TUBB", "TBP", "POLR2A", "GUSB", "SDHA")

datRUVg <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info, 
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "RUVg",
                             bgType = "t.test", bgPVal = 0.01,
                             n.unwanted = 1, RUVg.drop = 0,
                             housekeeping = hk.genes)


## ----normRUVg2----------------------------------------------------------------

# Housekeeping genes are automatically identified
datRUVg <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info, 
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "RUVg",
                             bgType = "t.test", bgPVal = 0.01,
                             n.unwanted = 1, RUVg.drop = 0)


## ----rle, fig.width = 6-------------------------------------------------------

# Here's how to do it with the NanoString ExpressionSet. If your data set is in
# list form, you would use dat$exprs instead of exprs(dat).

ruv::ruv_rle(t(log2(exprs(dat))), ylim = c(-2, 2))


## ----pca, fig.width = 6-------------------------------------------------------

dat <- processNanostringData(example_data, 
                             sampleTab = sample_info, 
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "nSolver", 
                             bgType = "t.test", 
                             bgPVal = 0.01)

library(plotly) 
nanostringPCA(dat, interactive.plot = TRUE)$plt


## ----pca2, fig.width = 6------------------------------------------------------

nanostringPCA(dat, pc1=3, pc2=4, interactive.plot = FALSE)$plt


## ----qc1----------------------------------------------------------------------

dat <- processNanostringData(example_data, 
                             idCol = "RCC_Name",
                             output.format = "list",
                             includeQC = TRUE)


## ----qc2----------------------------------------------------------------------

head(dat$qc)[,1:5]


## ----qcPos1-------------------------------------------------------------------

posQC <- positiveQC(dat)

knitr::kable(head(posQC$tab), 
      row.names = FALSE, format = "html", align = "c", digits = 2)


## ----qcPos2, fig.width = 7----------------------------------------------------

posQC2 <- positiveQC(dat, samples = 1:6)

posQC2$plt


## ----qcNeg1-------------------------------------------------------------------

negQC <- negativeQC(dat, interactive.plot = FALSE)

knitr::kable(head(negQC$tab), 
      row.names = TRUE, format = "html", align = "c")


## ----qcNeg2, fig.height = 7, fig.width = 7------------------------------------

negQC$plt


## ----qcHK1--------------------------------------------------------------------
signif(head(dat$hk.scalefactors), digits = 2)

## ----gps----------------------------------------------------------------------

dat <- processNanostringData(example_data, 
                             sampleTab = sample_info, 
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "nSolver", 
                             bgType = "t.test", 
                             bgPVal = 0.01)

table(dat$groups)


## ----deLimma------------------------------------------------------------------

limmaResults <- runLimmaAnalysis(dat, base.group = "None")

head(signif(limmaResults$coefficients, digits = 2))


## ----deLimma2, fig.height = 3.5-----------------------------------------------

# Generate fake batch labels
batch <- rep(c(0, 1), times = ncol(dat) / 2)

# Reorder groups ("None" first)
group <- factor(dat$groups, 
                levels = c("None", "Autoimmune retinopathy", 
                           "Retinitis pigmentosa"))

# Design matrix including sample group and batch
design <- model.matrix(~group + batch)

# Analyze data
limmaResults2 <- runLimmaAnalysis(dat, design = design)

# We can see there is no batch effect in this data, due to the somewhat uniform
# distribution of p-values. This is good, since the batches are fake.
hist(limmaResults2$p.value[,"batch"], main = "p-values of Batch terms")


## ----desInput-----------------------------------------------------------------

sample_info_design <- system.file("extdata", 
                           "GSE117751_design_matrix.csv", 
                           package = "NanoTube")

datDes <- processNanostringData(example_data, 
                             sampleTab = sample_info_design, 
                             idCol = "RCC_Name",
                             normalization = "nSolver", 
                             bgType = "t.test", 
                             bgPVal = 0.01)

head(pData(datDes))


## ----limma3-------------------------------------------------------------------

# Analyze data
limmaResults3 <- runLimmaAnalysis(datDes, 
                                  design = pData(datDes)[,2:(ncol(pData(datDes))-1)])


hist(limmaResults3$p.value[,"Age"], main = "p-values for Age term")


## ----volcano------------------------------------------------------------------

deVolcano(limmaResults, y.var = "p.value")


## ----volcano2-----------------------------------------------------------------

deVolcano(limmaResults, plotContrast = "Autoimmune.retinopathy", 
          y.var = "p.value") +
  geom_hline(yintercept = 2, linetype = "dashed", colour = "darkred") +
  geom_vline(xintercept = 0.5, linetype = "dashed", colour = "darkred") +
  geom_vline(xintercept = -0.5, linetype = "dashed", colour = "darkred")



## ----deExport-----------------------------------------------------------------

limmaStats <- makeDiffExprFile(limmaResults, filename = NULL, returns = "stats")
limmaStats <- as.data.frame(limmaStats)

# Order by lowest to highest p-value for 'Autoimmune Retinopathy' vs. 'None'
knitr::kable(head(limmaStats[order(limmaStats$`p-val (Autoimmune.retinopathy)`, 
                                   decreasing = FALSE),]), 
      row.names = TRUE, format = "html", align = "c")



## ----nsDiffConvert------------------------------------------------------------

# Remember to set normalization = "none"
datNoNorm <- processNanostringData(nsFiles = example_data,
                             sampleTab = sample_info, 
                             idCol = "RCC_Name",
                             groupCol = "Sample_Diagnosis",
                             normalization = "none")

nsDiffSet <- makeNanoStringSetFromEset(datNoNorm)

colnames(pData(nsDiffSet))


## ----nsDiffRun, eval = FALSE--------------------------------------------------
# 
# ### This block is not run! ###
# 
# # This step is fast
# nsDiffSet <- NanoStringDiff::estNormalizationFactors(nsDiffSet)
# 
# # This step likely to take multiple hours on standard desktop computers.
# result <- NanoStringDiff::glm.LRT(nsDiffSet,
#                                   design.full = as.matrix(pData(nsDiffSet)),
#                                   contrast = c(1, -1, 0))
#                                   #Contrast: Autoimmune retinopathy vs. None
# 

## ----gsea1--------------------------------------------------------------------
data("ExamplePathways")

fgseaResults <- limmaToFGSEA(limmaResults, gene.sets = ExamplePathways, 
                            min.set = 5, rank.by = "t",
                            skip.first = TRUE)


names(fgseaResults)


## ----gsea2--------------------------------------------------------------------

fgseaTab <- head(fgseaResults$Autoimmune.retinopathy[
             order(fgseaResults$Autoimmune.retinopathy$pval, 
                   decreasing = FALSE),])
fgseaTab[,2:6] <- lapply(fgseaTab[,2:6], format, digits = 1, nsmall = 1)

knitr::kable(fgseaTab, 
      row.names = FALSE, format = "html", align = "c")



## ----gsea3--------------------------------------------------------------------

# Leading edge for pathways with adjusted p < 0.2
leading.edge <- fgseaToLEdge(fgsea.res = fgseaResults,
                             cutoff.type = "padj", cutoff = 0.2) 


## ----gsea4--------------------------------------------------------------------

# Leading edge for pathways with abs(NES) > 1
leading.edge.nes <- fgseaToLEdge(fgsea.res = fgseaResults,
                                cutoff.type = "NES", cutoff = 1,
                                nes.abs.cutoff = TRUE) 

# Leading edge for pathways with NES > 1.5
leading.edge.nes <- fgseaToLEdge(fgsea.res = fgseaResults,
                                cutoff.type = "NES", cutoff = 1.5,
                                nes.abs.cutoff = FALSE) 

# Leading edge for pathways with NES < -0.5
leading.edge.nes <- fgseaToLEdge(fgsea.res = fgseaResults,
                                cutoff.type = "NES", cutoff = -0.5,
                                nes.abs.cutoff = FALSE) 



## ----gsea5, fig.width = 8, fig.height = 3-------------------------------------

pheatmap::pheatmap(t(leading.edge$Autoimmune.retinopathy),
                   legend = FALSE,
                   color = c("white", "black"))


## ----gsea6--------------------------------------------------------------------

# Group pathways with a binary distance below 0.5
fgsea.grouped <- groupFGSEA(fgseaResults$Autoimmune.retinopathy, 
                                   leading.edge$Autoimmune.retinopathy,
                                   join.threshold = 0.5,
                                   dist.method = "binary")

fgseaTab <- head(fgsea.grouped)
fgseaTab[,2:6] <- lapply(fgseaTab[,2:6], format, digits = 1, nsmall = 1)

knitr::kable(fgseaTab, 
      row.names = FALSE, format = "html", align = "c")


## ----exportGSEA---------------------------------------------------------------

fgseaPostprocessingXLSX(genesetResults = fgseaResults,
                        leadingEdge = leading.edge,
                        limmaResults = limmaResults,
                        join.threshold = 0.5,
                        filename = "analysis.xlsx")


## ----exportGSEA2--------------------------------------------------------------

results.AR <- groupedGSEAtoStackedReport( 
    fgsea.grouped,
    leadingEdge = leading.edge$Autoimmune.retinopathy,
    de.fit = limmaResults)

# View Cluster 1 gene statistics
resultsTab <- results.AR[results.AR$Cluster == 1, 1:6]
resultsTab[,2:6] <- lapply(resultsTab[,2:6], format, digits = 1, nsmall = 1)

knitr::kable(resultsTab, 
      row.names = FALSE, format = "html", align = "c")


