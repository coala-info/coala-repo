# Code example from 'GRaNIE_workflow' vignette. See references/ for full tutorial.

## ----<knitr, echo=FALSE, message=FALSE, results="hide", class.output="scroll-300"----
library("knitr")
opts_chunk$set(
  tidy = TRUE,
  cache = FALSE,
  message = FALSE,
  fig.align="center",
  dpi=200,
  fig.height=8,
  results='hold')

options(bitmapType = "cairo")


## ----loadLibaries2, echo=TRUE, message=FALSE, results="hide", warning=FALSE, class.output="scroll-300"----
library(readr)
library(GRaNIE)

## ----importData, echo=TRUE, include=TRUE, class.output="scroll-300"-----------

# We load the example data directly from the web:
file_peaks = "https://www.embl.de/download/zaugg/GRaNIE/countsATAC.filtered.tsv.gz"
file_RNA   = "https://www.embl.de/download/zaugg/GRaNIE/countsRNA.filtered.tsv.gz"
file_sampleMetadata = "https://www.embl.de/download/zaugg/GRaNIE/sampleMetadata.tsv.gz"

countsRNA.df      = read_tsv(file_RNA, col_types = cols())
countsPeaks.df    = read_tsv(file_peaks, col_types = cols()) 
sampleMetadata.df = read_tsv(file_sampleMetadata, col_types = cols())


# Let's check how the data looks like
countsRNA.df
countsPeaks.df
sampleMetadata.df

# Save the name of the respective ID columns
idColumn_peaks = "peakID"
idColumn_RNA = "ENSEMBL"


## ----initializeObject, echo=TRUE, include=TRUE, class.output="scroll-300"-----
genomeAssembly = "hg38" #Either hg19, hg38 or mm10. Both enhancers and RNA data must have the same genome assembly

# Optional and arbitrary list with information and metadata that is stored within the GRaNIE object
objectMetadata.l = list(name                = paste0("Macrophages_infected_primed"),
                        file_peaks          = file_peaks,
                        file_rna            = file_RNA,
                        file_sampleMetadata = file_sampleMetadata,
                        genomeAssembly      = genomeAssembly)

dir_output = "."

GRN = initializeGRN(objectMetadata = objectMetadata.l,
                    outputFolder = dir_output,
                    genomeAssembly = genomeAssembly)

GRN

## ----addData, echo=TRUE, include=TRUE, eval = FALSE, class.output="scroll-300"----
# GRN = addData(GRN,
#               counts_peaks = countsPeaks.df, normalization_peaks = "DESeq2_sizeFactors", idColumn_peaks = idColumn_peaks,
#               counts_rna = countsRNA.df, normalization_rna = "limma_quantile", idColumn_RNA = idColumn_RNA,
#               sampleMetadata = sampleMetadata.df,
#               forceRerun = TRUE)
# 
# GRN

## ----loadObject, echo=FALSE, results = FALSE, eval = TRUE---------------------
GRN = loadExampleObject()

## ----runPCA, echo=TRUE, include=TRUE, eval = FALSE, class.output="scroll-300", collapse=FALSE, results="hold"----
# GRN = plotPCA_all(GRN, data = c("rna"), topn = 500, type = "normalized", plotAsPDF = FALSE, pages = c(2,3,14), forceRerun = TRUE)

## ----addTFBS, echo=TRUE, include=TRUE, eval = FALSE, class.output="scroll-300", results='hold'----
# 
# folder_TFBS_6TFs = "https://www.embl.de/download/zaugg/GRaNIE/TFBS_selected.zip"
# # Download the zip of all TFBS files. Takes too long here, not executed therefore
# 
# download.file(folder_TFBS_6TFs, file.path("TFBS_selected.zip"), quiet = FALSE)
# 
# unzip(file.path("TFBS_selected.zip"), overwrite = TRUE)
# 
# motifFolder = tools::file_path_as_absolute("TFBS_selected")
# 
# GRN = addTFBS(GRN, motifFolder = motifFolder, TFs = "all", filesTFBSPattern = "_TFBS", fileEnding = ".bed.gz", forceRerun = TRUE)
# 
# GRN = overlapPeaksAndTFBS(GRN, nCores = 1, forceRerun = TRUE)

## ----filterData, echo=TRUE, include=TRUE, eval = TRUE, class.output="scroll-300", results='hold'----
# Chromosomes to keep for peaks. This should be a vector of chromosome names
chrToKeep_peaks = c(paste0("chr", 1:22), "chrX")
GRN = filterData(GRN, minNormalizedMean_peaks = 5, minNormalizedMeanRNA = 1, chrToKeep_peaks = chrToKeep_peaks, maxSize_peaks = 10000, forceRerun = TRUE)

## ----addTFPeakConnections, echo=TRUE, include=TRUE, eval = TRUE, class.output="scroll-300", results='hold'----
GRN = addConnections_TF_peak(GRN, plotDiagnosticPlots = FALSE,
                                     connectionTypes = c("expression"),
                                     corMethod = "pearson", forceRerun = TRUE)

## ----echo=TRUE, include=TRUE, eval = TRUE, class.output="scroll-300", results='hold', fig.cap="<i>TF-enhancer diagnostic plots connection overview.A</i>", results='hold', fig.height = 10----
GRN = plotDiagnosticPlots_TFPeaks(GRN, dataType = c("real"), plotAsPDF = FALSE, pages = c(1))

## ----echo=TRUE, include=TRUE, eval = TRUE, class.output="scroll-300", results='hold', fig.cap="<i>TF-enhancer diagnostic plots for EGR1.0.A (real)</i>", results='hold', fig.height = 10----
GRN = plotDiagnosticPlots_TFPeaks(GRN, dataType = c("real"), plotAsPDF = FALSE, pages = c(42))

## ----echo=TRUE, include=TRUE, eval = TRUE, class.output="scroll-300", results='hold', fig.cap="<i>TF-enhancer diagnostic plots for EGR1.0.A (background)</i>", results='hold', fig.height = 10----
GRN = plotDiagnosticPlots_TFPeaks(GRN, dataType = c("background"), plotAsPDF = FALSE, pages = c(42))

## ----runARClassification, echo=TRUE, include=TRUE, eval = FALSE, class.output="scroll-300"----
# GRN = AR_classification_wrapper(GRN, significanceThreshold_Wilcoxon = 0.05,
#                                 outputFolder = "plots",
#                                 plot_minNoTFBS_heatmap = 100, plotDiagnosticPlots = TRUE,
#                                 forceRerun = TRUE)

## ----saveObject2, echo=TRUE, include=TRUE, eval=FALSE, class.output="scroll-300"----
# GRN_file_outputRDS = paste0(dir_output, "/GRN.rds")
# saveRDS(GRN, GRN_file_outputRDS)

## ----addPeakGeneConnections, echo=TRUE, include=TRUE, eval = TRUE, class.output="scroll-300"----
GRN = addConnections_peak_gene(GRN,
                               corMethod = "pearson", promoterRange = 10000, TADs = NULL,
                               nCores = 1, plotDiagnosticPlots = FALSE, plotGeneTypes = list(c("all")), forceRerun = TRUE)

## ----echo=TRUE, fig.cap="<i>Enhancer-gene diagnostic plots</i>", fig.height = 7, class.output="scroll-300"----
GRN = plotDiagnosticPlots_peakGene(GRN, gene.types = list(c("protein_coding", "lincRNA")), plotAsPDF = FALSE, pages = 1)

## ----combineAndFilter, echo=TRUE, include=TRUE, eval = TRUE, class.output="scroll-300"----
GRN = filterGRNAndConnectGenes(GRN, TF_peak.fdr.threshold = 0.2,
                               peak_gene.fdr.threshold = 0.2, peak_gene.fdr.method = "BH", 
                               gene.types = c("protein_coding", "lincRNA"),
                               allowMissingTFs = FALSE, allowMissingGenes = FALSE,
                               forceRerun = TRUE
                               )

## ----include=TRUE, eval = TRUE, class.output="scroll-300"---------------------
GRN = add_TF_gene_correlation(GRN, corMethod = "pearson", nCores = 1, forceRerun = TRUE)

## ----saveObject, echo=TRUE, include=TRUE , eval=FALSE, class.output="scroll-300"----
# GRN = deleteIntermediateData(GRN)
# saveRDS(GRN, GRN_file_outputRDS)

## ----include=TRUE, eval = TRUE, class.output="scroll-300"---------------------
GRN_connections.all = getGRNConnections(GRN, type = "all.filtered", include_TF_gene_correlations = TRUE, include_geneMetadata = TRUE)

GRN_connections.all

## ----connectionSummary, echo=TRUE, include=TRUE, eval = TRUE, out.width="50%", class.output="scroll-300"----
GRN = generateStatsSummary(GRN,
                           TF_peak.fdr = c(0.05, 0.1, 0.2), 
                           TF_peak.connectionTypes = "all",
                           peak_gene.fdr = c(0.1, 0.2),
                           peak_gene.r_range = c(0,1),
                           allowMissingGenes = c(FALSE, TRUE),
                           allowMissingTFs = c(FALSE),
                           gene.types = c("protein_coding", "lincRNA"),
                           forceRerun = TRUE)


GRN = plot_stats_connectionSummary(GRN, type = "heatmap", plotAsPDF = FALSE, pages = 3)
GRN = plot_stats_connectionSummary(GRN, type = "boxplot", plotAsPDF = FALSE, pages = 1)

## ----buildGraph, echo=TRUE, include=TRUE, eval = TRUE, class.output="scroll-300"----

GRN = build_eGRN_graph(GRN, forceRerun = TRUE) 


## ----visualizeGRN, echo=TRUE, include=TRUE, eval = TRUE, fig.cap="<i>eGRN example visualization</i>", fig.height = 6, class.output="scroll-300"----
GRN = visualizeGRN(GRN, plotAsPDF = FALSE, maxEdgesToPlot = 1000)


## ----filterAndVisualizeGRN, echo=TRUE, include=TRUE, eval = TRUE, fig.cap="<i>eGRN example visualization with extra filtering</i>", fig.height = 6, class.output="scroll-300"----
GRN = filterConnectionsForPlotting(GRN, plotAll = FALSE, TF.ID == "E2F7.0.B" | stringr::str_starts(TF.ID, "ETV"))
GRN = visualizeGRN(GRN, plotAsPDF = FALSE)


## ----allNetworkAnalyses, echo=TRUE, include=TRUE, eval = FALSE, class.output="scroll-300"----
# GRN = performAllNetworkAnalyses(GRN, ontology = c("GO_BP"), outputFolder = ".", forceRerun = TRUE)

## ----plotGraphStats, echo=FALSE, fig.cap="<i>General network statistics for the filtered network</i>", fig.width = 12, class.output="scroll-300"----

GRN = plotGeneralGraphStats(GRN, plotAsPDF = FALSE, pages = c(1,6))


## ----generalEnrichment, echo=FALSE, eval = FALSE, class.output="scroll-300"----
# 
# GRN = calculateGeneralEnrichment(GRN, ontology = "GO_BP")
# 

## ----plotGeneralEnrichment, echo=TRUE, fig.cap="<i>General network enrichment for the filtered network</i>", fig.height=5, class.output="scroll-300"----

GRN = plotGeneralEnrichment(GRN, plotAsPDF = FALSE, pages = 1)


## ----communityEnrichment, echo=FALSE, class.output="scroll-300"---------------

GRN = calculateCommunitiesStats(GRN)
GRN = calculateCommunitiesEnrichment(GRN, ontology = "GO_BP")


## ----plotCommunityStats, echo=FALSE, fig.height=9, fig.width = 10, fig.cap="<i>General statistics for the communities from the filtered network</i>", class.output="scroll-300"----

GRN = plotCommunitiesStats(GRN, plotAsPDF = FALSE, pages = c(1,3))


## ----plotCommunityEnrichment, echo=FALSE, fig.height=7, fig.width = 9, fig.cap="<i>Community enrichment for 3 different communities</i>", class.output="scroll-300"----

GRN = plotCommunitiesEnrichment(GRN, plotAsPDF = FALSE, pages = c(1,2,3))


## ----plotCommunityEnrichment2, echo=TRUE, fig.height=7, fig.width = 10,fig.cap="<i>Summary of the community enrichment</i>", class.output="scroll-300"----
GRN = plotCommunitiesEnrichment(GRN, plotAsPDF = FALSE, pages = c(5))



## ----TFEnrichmentCal, echo=FALSE, eval = FALSE, class.output="scroll-300"-----
# GRN = calculateTFEnrichment(GRN, ontology = "GO_BP")

## ----TFEnrichment, echo=TRUE, fig.cap="<i>Enrichment summary for EGR1.0.A</i>", fig.height=7, fig.width = 12, class.output="scroll-300"----
GRN = plotTFEnrichment(GRN, plotAsPDF = FALSE, n = 3, pages = c(1))

## ----TFEnrichment2, echo=TRUE, fig.cap="<i>Enrichment summary for selected TFs and the whole eGRN network</i>", fig.height=7, fig.width = 15, class.output="scroll-300"----
GRN = plotTFEnrichment(GRN, plotAsPDF = FALSE, n = 3, pages = c(5))

## ----saveObject3, echo=TRUE, include=TRUE, eval=FALSE, class.output="scroll-300"----
# GRN = deleteIntermediateData(GRN)
# saveRDS(GRN, GRN_file_outputRDS)

## ----class.output="scroll-300"------------------------------------------------
 sessionInfo()

