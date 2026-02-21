# Code example from 'qPLEXanalyzer' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      cache = FALSE,
                      dev = "png",
                      message = FALSE, error = FALSE, warning = TRUE)

## ----libs---------------------------------------------------------------------
library(qPLEXanalyzer)
library(patchwork)
data(human_anno)
data(exp2_Xlink)

## ----Import-------------------------------------------------------------------
MSnset_data <- convertToMSnset(exp2_Xlink$intensities,
                               metadata = exp2_Xlink$metadata,
                               indExpData = c(7:16), 
                               Sequences = 2, 
                               Accessions = 6)
exprs(MSnset_data) <- exprs(MSnset_data)+1.1
MSnset_data

## ----Filter, fig.width=6, fig.height=5, fig.cap="Figure 1: Density plots of raw intensities for TMT-10plex experiment."----
intensityPlot(MSnset_data, title = "Peptide intensity distribution")

## ----boxplot, fig.width=6, fig.height=5, fig.cap="Figure 2: Boxplot of raw intensities for TMT-10plex experiment."----
intensityBoxplot(MSnset_data, title = "Peptide intensity distribution")

## ----rliplot, fig.width=6, fig.height=5, fig.cap="Figure 3: RLI of raw intensities for TMT-10plex experiment."----
rliPlot(MSnset_data, title = "Relative Peptide intensity")

## ----Corrplot, fig.width=6, fig.height=6, fig.cap="Figure 4: Correlation plot of peptide intensities"----
corrPlot(MSnset_data)

## ----hierarchicalplot, fig.width=6, fig.height=5, fig.cap="Figure 5: Clustering plot of peptide intensitites"----
exprs(MSnset_data) <- exprs(MSnset_data) + 0.01
hierarchicalPlot(MSnset_data)

## ----pcaplot, fig.width=6, fig.height=5, fig.cap="Figure 6: PCA plot of peptide intensitites"----
pcaPlot(MSnset_data, labelColumn = "BioRep", pointsize = 3)

## ----coverageplot, fig.width=6, fig.height=1.5, fig.cap="Figure 7: Peptide sequence coverage plot"----
mySequenceFile <- system.file("extdata", "P03372.fasta", package = "qPLEXanalyzer")
coveragePlot(MSnset_data,
             ProteinID = "P03372", 
             ProteinName = "ESR1",
             fastaFile = mySequenceFile)

## ----norm, fig.width=7, fig.height=7, fig.cap="Figure 8: Peptide intensity distribution with various normalization methods"----
MSnset_data <- MSnset_data[, -5]
p1 <- intensityPlot(MSnset_data, title = "No normalization")

MSnset_norm_q <- normalizeQuantiles(MSnset_data)
p2 <- intensityPlot(MSnset_norm_q, title = "Quantile")

MSnset_norm_ns <- normalizeScaling(MSnset_data, scalingFunction = median)
p3 <- intensityPlot(MSnset_norm_ns, title = "Scaling")

MSnset_norm_gs <- groupScaling(MSnset_data, 
                               scalingFunction = median, 
                               groupingColumn = "SampleGroup")
p4 <- intensityPlot(MSnset_norm_gs, title = "Within Group Scaling")

(p1 | p2) / (p3 | p4)

## ----annotation, eval=FALSE---------------------------------------------------
# library(UniProt.ws)
# library(dplyr)
# proteins <- unique(fData(MSnset_data)$Accessions)[1:10]
# columns <- c("id", 'gene_primary',"gene_names", "protein_name")
# hs <- UniProt.ws::UniProt.ws(taxId = 9606)
# first_ten_anno <- UniProt.ws::select(hs, proteins, columns, "UniProtKB") %>%
#   as_tibble() %>%
#   select(Accessions = "Entry",
#          Gene = "Entry.Name",
#          Description = "Protein.names",
#          GeneSymbol= "Gene.Names..primary.") %>%
#   arrange(Accessions)
# head(first_ten_anno)

## ----annotationReal, echo=FALSE-----------------------------------------------
library(dplyr)
proteins <- unique(fData(MSnset_data)$Accessions)[1:10]
filter(human_anno, Accessions%in%proteins) %>%
    as_tibble() %>%
    arrange(Accessions) %>%
    head()

## ----summarize----------------------------------------------------------------
MSnset_Pnorm <- summarizeIntensities(MSnset_norm_gs, 
                                     summarizationFunction = sum, 
                                     annotation = human_anno)

## ----pepIntensity, fig.width=6, fig.height=5, fig.cap="Figure 9: Summarized protein intensity"----
peptideIntensityPlot(MSnset_data,
                     combinedIntensities = MSnset_Pnorm,
                     ProteinID = "P03372", 
                     ProteinName = "ESR1")

## ----regress, fig.width=6, fig.height=4, fig.cap="Figure 10: Correlation between bait protein and enriched proteins before and after regression"----
data(exp3_OHT_ESR1)
MSnset_reg <- convertToMSnset(exp3_OHT_ESR1$intensities_qPLEX2,
                              metadata = exp3_OHT_ESR1$metadata_qPLEX2,
                              indExpData = c(7:16), 
                              Sequences = 2, 
                              Accessions = 6)
MSnset_P <- summarizeIntensities(MSnset_reg, 
                                 summarizationFunction = sum, 
                                 annotation = human_anno)
MSnset_P <- rowScaling(MSnset_P, scalingFunction = mean)
IgG_ind <- which(pData(MSnset_P)$SampleGroup == "IgG")
Reg_data <- regressIntensity(MSnset_P, 
                             controlInd = IgG_ind,
                             ProteinId = "P03372")

## ----diffexp------------------------------------------------------------------
contrasts <- c(DSG.FA_vs_FA = "DSG.FA - FA")
diffstats <- computeDiffStats(MSnset_Pnorm, contrasts = contrasts)
diffexp <- getContrastResults(diffstats, 
                              contrast = "DSG.FA_vs_FA",
                              controlGroup = "IgG")

## ----MAplot, fig.width=6,fig.height=4, fig.cap="Figure 11: MA plot of the quantified proteins"----
maVolPlot(diffstats, contrast = "DSG.FA_vs_FA", plotType = "MA", title = contrasts)

## ----volcano, fig.width=6, fig.height=4, fig.cap="Figure 12: Volcano plot of the quantified proteins"----
maVolPlot(diffstats, contrast = "DSG.FA_vs_FA", plotType = "Volcano", title = contrasts)

## ----info,echo=TRUE-----------------------------------------------------------
sessionInfo()

