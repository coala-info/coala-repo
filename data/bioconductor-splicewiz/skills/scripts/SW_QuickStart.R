# Code example from 'SW_QuickStart' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----include = FALSE----------------------------------------------------------
library(SpliceWiz)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("SpliceWiz")

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install(version = "3.16")

## ----eval = FALSE-------------------------------------------------------------
# # BiocManager::install("SpliceWiz")
# devtools::install_github("alexchwong/SpliceWiz")

## ----eval=FALSE---------------------------------------------------------------
# install.packages("DoubleExpSeq")
# 
# BiocManager::install(c("DESeq2", "limma", "edgeR"))

## -----------------------------------------------------------------------------
library(SpliceWiz)

## -----------------------------------------------------------------------------
if(interactive()) {
    spliceWiz(demo = TRUE)
}

## ----echo=FALSE, out.width='231pt', fig.align = 'center', fig.cap="SpliceWiz GUI - Menu Side Bar"----
knitr::include_graphics("img/MenuBar.jpg")

## ----results='hide', message = FALSE, warning = FALSE-------------------------
ref_path <- file.path(tempdir(), "Reference")
buildRef(
    reference_path = ref_path,
    fasta = chrZ_genome(),
    gtf = chrZ_gtf(),
    ontologySpecies = "Homo sapiens"
)

## ----results='hide', message = FALSE, warning = FALSE-------------------------
df <- viewASE(ref_path)

## ----echo=FALSE, out.width='1000pt', fig.align = 'center', fig.cap="Building the SpliceWiz reference using the GUI"----
knitr::include_graphics("img/buildRef.jpg")

## -----------------------------------------------------------------------------
# Provides the path to the example genome:
chrZ_genome()

# Provides the path to the example gene annotation:
chrZ_gtf()

## -----------------------------------------------------------------------------
getAvailableGO()

## ----eval = FALSE-------------------------------------------------------------
# ## NOT RUN
# 
# ref_path_hg38 <- "./Reference"
# buildRef(
#     reference_path = ref_path_hg38,
#     fasta = "genome.fa",
#     gtf = "transcripts.gtf",
#     genome_type = "hg38"
# )

## -----------------------------------------------------------------------------
bams <- SpliceWiz_example_bams()

## -----------------------------------------------------------------------------
# as BAM file names denote their sample names
bams <- findBAMS(tempdir(), level = 0) 

# In the case where BAM files are labelled using sample names as parent 
# directory names (which oftens happens with the STAR aligner), use level = 1

## ----results='hide', message = FALSE, warning = FALSE-------------------------
pb_path <- file.path(tempdir(), "pb_output")
processBAM(
    bamfiles = bams$path,
    sample_names = bams$sample,
    reference_path = ref_path,
    output_path = pb_path
)

## ----echo=FALSE, out.width='8000pt', fig.align = 'center', fig.cap="The Experiment Panel - GUI"----
knitr::include_graphics("img/Expr_empty.jpg")

## ----echo=FALSE, out.width='360pt', fig.align = 'center', fig.cap="Define Project Folders"----
knitr::include_graphics("img/Expr_drop_2.jpg")

## ----echo=FALSE, out.width='1000pt', fig.align = 'center', fig.cap="Running processBAM"----
knitr::include_graphics("img/Expr_pb.jpg")

## ----results='hide', message = FALSE, warning = FALSE-------------------------
pb_path <- file.path(tempdir(), "pb_output")
processBAM(
    bamfiles = bams$path,
    sample_names = bams$sample,
    reference_path = ref_path,
    output_path = pb_path
)

## ----eval = FALSE-------------------------------------------------------------
# # NOT RUN
# 
# # Re-run IRFinder without overwrite, and run featureCounts
# require(Rsubread)
# 
# processBAM(
#     bamfiles = bams$path,
#     sample_names = bams$sample,
#     reference_path = ref_path,
#     output_path = pb_path,
#     n_threads = 2,
#     overwrite = FALSE,
#     run_featureCounts = TRUE
# )
# 
# # Load gene counts
# gene_counts <- readRDS(file.path(pb_path, "main.FC.Rds"))
# 
# # Access gene counts:
# gene_counts$counts

## -----------------------------------------------------------------------------
expr <- findSpliceWizOutput(pb_path)

## ----results='hide', message = FALSE, warning = FALSE-------------------------
nxtse_path <- file.path(tempdir(), "NxtSE_output")
collateData(
    Experiment = expr,
    reference_path = ref_path,
    output_path = nxtse_path
)

## ----results='hide', message = FALSE, warning = FALSE-------------------------
# Modified pipeline - collateData with novel ASE discovery:

nxtse_path <- file.path(tempdir(), "NxtSE_output_novel")
collateData(
    Experiment = expr,
    reference_path = ref_path,
    output_path = nxtse_path,
    novelSplicing = TRUE     ## NEW ##
)

## ----eval = FALSE-------------------------------------------------------------
# nxtse_path <- file.path(tempdir(), "NxtSE_output_novel")
# collateData(
#     Experiment = expr,
#     reference_path = ref_path,
#     output_path = nxtse_path,
# 
#         ## NEW ##
#     novelSplicing = TRUE,
#         # switches on novel splice detection
# 
#     novelSplicing_requireOneAnnotatedSJ = TRUE,
#         # novel junctions must share one annotated splice site
# 
#     novelSplicing_minSamples = 3,
#         # retain junctions observed in 3+ samples (of any non-zero expression)
# 
#     novelSplicing_minSamplesAboveThreshold = 1,
#         # only 1 sample required if its junction count exceeds a set threshold
#     novelSplicing_countThreshold = 10  ,
#         # threshold for previous parameter
# 
#     novelSplicing_useTJ = TRUE
#         # whether tandem junction reads should be used to identify novel exons
# )

## ----echo=FALSE, out.width='1000pt', fig.align = 'center', fig.cap="Importing annotations"----
knitr::include_graphics("img/Expr_import_anno.jpg")

## ----echo=FALSE, out.width='360pt', fig.align = 'center', fig.cap="Adding annotation columns"----
knitr::include_graphics("img/Expr_anno_columns.jpg")

## ----echo=FALSE, out.width='480pt', fig.align = 'center', fig.cap="Customizing the Experiment Settings"----
knitr::include_graphics("img/Expr_cd_settings.jpg")

## ----results='hide', message = FALSE, warning = FALSE-------------------------
se <- makeSE(nxtse_path)

## ----echo=FALSE, out.width='1000pt', fig.align = 'center', fig.cap="Analysis - Loading the Experiment - GUI"----
knitr::include_graphics("img/Expr_load_empty.jpg")

## ----echo=FALSE, out.width='1000pt', fig.align = 'center', fig.cap="Loading the NxtSE after reviewing the samples and annotations - GUI"----
knitr::include_graphics("img/Expr_load_folder.jpg")

## -----------------------------------------------------------------------------
se <- realize_NxtSE(se)

## ----eval = FALSE-------------------------------------------------------------
# se <- makeSE(nxtse_path, realize = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# subset_samples <- colnames(se)[1:4]
# df <- data.frame(sample = subset_samples)
# se_small <- makeSE(nxtse_path, colData = df, RemoveOverlapping = TRUE)

## -----------------------------------------------------------------------------
colData(se)$condition <- rep(c("A", "B"), each = 3)
colData(se)$batch <- rep(c("K", "L", "M"), 2)

## -----------------------------------------------------------------------------
se

## -----------------------------------------------------------------------------
head(rowData(se))

## -----------------------------------------------------------------------------
# Subset by columns: select the first 2 samples
se_sample_subset <- se[,1:2]

# Subset by rows: select the first 10 ASE events
se_ASE_subset <- se[1:10,]

## -----------------------------------------------------------------------------
se.filtered <- se[applyFilters(se),]

## ----echo=FALSE, out.width='800pt', fig.align = 'center', fig.cap="Analysis - Filters - GUI"----
knitr::include_graphics("img/Filters_empty.jpg")

## ----echo=FALSE, out.width='800pt', fig.align = 'center', fig.cap="SpliceWiz default filters - GUI"----
knitr::include_graphics("img/Filters_applied.jpg")

## ----results='hide', message = FALSE, warning = FALSE-------------------------
# Requires edgeR to be installed:
require("edgeR")
res_edgeR <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A"
)

## ----echo=FALSE, out.width='800pt', fig.align = 'center', fig.cap="Analysis - Differential Expression Analysis - GUI"----
knitr::include_graphics("img/DE_empty.jpg")

## ----echo=FALSE, out.width='800pt', fig.align = 'center', fig.cap="Example Differential Analysis using edgeR - GUI"----
knitr::include_graphics("img/DE_edgeR.jpg")

## ----results='hide', message = FALSE, warning = FALSE-------------------------
# Requires limma to be installed:
require("limma")
res_limma <- ASE_limma(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A"
)

# Requires DoubleExpSeq to be installed:
require("DoubleExpSeq")
res_DES <- ASE_DoubleExpSeq(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A"
)

# Requires DESeq2 to be installed:
require("DESeq2")
res_deseq <- ASE_DESeq(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
    n_threads = 1
)

# Requires edgeR to be installed:
require("edgeR")
res_edgeR <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A"
)

## ----results='hide', message = FALSE, warning = FALSE-------------------------
res_edgeR_allIntrons <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
    IRmode = "all"
)

res_edgeR_annotatedIR <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
    IRmode = "annotated"
)

res_edgeR_annotated_binaryIR <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
    IRmode = "annotated_binary"
)

## ----results='hide', message = FALSE, warning = FALSE-------------------------
require("edgeR")
res_edgeR_batchnorm <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
    batch1 = "batch"
)

## ----results='hide', message = FALSE, warning = FALSE-------------------------
colData(se.filtered)$timevar <- rep(c(0,1,2), 2)

require("splines")
require("limma")
res_limma_cont <- ASE_limma_timeseries(
    se = se.filtered,
    test_factor = "timevar"
)

require("splines")
require("edgeR")
res_edgeR_cont <- ASE_edgeR_timeseries(
    se = se.filtered,
    test_factor = "timevar"
)


## ----results='hide', message = FALSE, warning = FALSE-------------------------
colData(se.filtered)$timevar <- rep(c(0,1,2), 2)

require("DESeq2")
res_deseq_cont <- ASE_DESeq(
    se = se.filtered,
    test_factor = "timevar"
)

## ----eval = FALSE-------------------------------------------------------------
# ?`ASE-GLM-edgeR`

## ----fig.width = 7, fig.height = 5, eval = Sys.info()["sysname"] != "Darwin"----
library(ggplot2)

ggplot(res_edgeR,
        aes(x = logFC, y = -log10(FDR))) + 
    geom_point() +
    labs(title = "Differential analysis - B vs A",
         x = "Log2-fold change", y = "FDR (-log10)")

## ----fig.width = 7, fig.height = 5, eval = Sys.info()["sysname"] != "Darwin"----
ggplot(res_edgeR,
        aes(x = logFC, y = -log10(FDR))) + 
    geom_point() + facet_wrap(vars(EventType)) +
    labs(title = "Differential analysis - B vs A",
         x = "Log2-fold change", y = "FDR (-log10)")

## ----echo=FALSE, out.width='800pt', fig.align = 'center', fig.cap="Volcano Plot - GUI"----
knitr::include_graphics("img/Vis_volcano.jpg")

## ----fig.width = 7, fig.height = 5, eval = Sys.info()["sysname"] != "Darwin"----
library(ggplot2)

ggplot(res_edgeR, aes(x = 100 * AvgPSI_B, y = 100 * AvgPSI_A)) + 
    geom_point() + xlim(0, 100) + ylim(0, 100) +
    labs(title = "PSI values across conditions",
         x = "PSI of condition B", y = "PSI of condition A")

## ----echo=FALSE, out.width='800pt', fig.align = 'center', fig.cap="Scatter plot - GUI"----
knitr::include_graphics("img/Vis_scatter.jpg")

## ----echo=FALSE, out.width='800pt', fig.align = 'center', fig.cap="Volcano plot - selecting ASEs of interest via the GUI"----
knitr::include_graphics("img/Vis_volcano_select.jpg")

## ----echo=FALSE, out.width='800pt', fig.align = 'center', fig.cap="Scatter plot - highlighted ASE events"----
knitr::include_graphics("img/Vis_scatter_highlighted.jpg")

## -----------------------------------------------------------------------------
meanPSIs <- makeMeanPSI(
    se = se,
    condition = "batch",
    conditionList = list("K", "L", "M")
)

## ----echo=FALSE, out.width='480pt', fig.align = 'center', fig.cap="Gene ontology analysis"----
knitr::include_graphics("img/Vis_GO.jpg")

## -----------------------------------------------------------------------------
getAvailableGO()

## -----------------------------------------------------------------------------
ref_path <- file.path(tempdir(), "Reference")
ontology <- viewGO(ref_path)
head(ontology)

## -----------------------------------------------------------------------------
allGenes <- sort(unique(ontology$gene_id))
exampleGeneID <- allGenes[1:1000]
exampleBkgdID <- allGenes

go_byGenes <- goGenes(
    enrichedGenes = exampleGeneID, 
    universeGenes = exampleBkgdID, 
    ontologyRef = ontology
)

## -----------------------------------------------------------------------------
plotGO(go_byGenes, filter_n_terms = 12)

## -----------------------------------------------------------------------------
res_edgeR <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A"
)

go_byASE <- goASE(
  enrichedEventNames = res_edgeR$EventName[1:10],
  universeEventNames = NULL,
  se = se
)
head(go_byASE)

## -----------------------------------------------------------------------------
go_byASE <- goASE(
  enrichedEventNames = res_edgeR$EventName[1:10],
  universeEventNames = res_edgeR$EventName,
  se = se
)

## -----------------------------------------------------------------------------
# Create a matrix of values of the top 10 differentially expressed events:
mat <- makeMatrix(
    se.filtered,
    event_list = res_edgeR$EventName[1:10],
    method = "PSI"
)

## ----fig.width = 8, fig.height = 6, eval = Sys.info()["sysname"] != "Darwin"----
library(pheatmap)

anno_col_df <- as.data.frame(colData(se.filtered))
anno_col_df <- anno_col_df[, 1, drop=FALSE]

pheatmap(mat, annotation_col = anno_col_df)

## ----echo=FALSE, out.width='800pt', fig.align = 'center', fig.cap="Heatmap - GUI"----
knitr::include_graphics("img/Vis_heatmap.jpg")

## -----------------------------------------------------------------------------
res_edgeR <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A"
)

res_edgeR.filtered <- res_edgeR[res_edgeR$abs_deltaPSI > 0.05,]
res_edgeR.filtered$EventName[1]

## -----------------------------------------------------------------------------
dataObj <- getCoverageData(se, Gene = "NSUN5", tracks = colnames(se))

## -----------------------------------------------------------------------------
plotObj <- getPlotObject(dataObj, Event = res_edgeR.filtered$EventName[1])

## -----------------------------------------------------------------------------
plotView(
    plotObj,
    centerByEvent = TRUE, # whether the plot should be centered at the `Event`
    trackList = list(1,2,3,4,5,6),
    plotJunctions = TRUE
)

## -----------------------------------------------------------------------------
tracks(plotObj)

## -----------------------------------------------------------------------------
plotView(
    plotObj,
    centerByEvent = TRUE,
    trackList = list(c(1,2,3), c(4,5,6)), 
    # Each list element contains a vector of track id's
    
    normalizeCoverage = TRUE
)

## -----------------------------------------------------------------------------
plotObj_group <- getPlotObject(
    dataObj,
    Event = res_edgeR.filtered$EventName[1],
    condition = "condition",
    tracks = c("A", "B") 
)

# NB:
# when `condition` is not specified, tracks are assumed to be the same samples
# as that of the covDataObject
# when `condition` is specified, tracks must refer to the condition categories
# that are desired for the final plot

## -----------------------------------------------------------------------------
plotView(
    plotObj_group,
    centerByEvent = TRUE,
    trackList = list(c("A", "B"))
)

## -----------------------------------------------------------------------------
dataObj <- getCoverageData(se, Gene = "TRA2B", tracks = colnames(se))

plotObj <- getPlotObject(
    dataObj, 
    Event = "SE:TRA2B-206-exon2;TRA2B-205-int1", 
    condition = "condition", tracks = c("A", "B")
)

plotView(
    plotObj, 
    centerByEvent = TRUE, 
    trackList = list(c(1,2)), 
    filterByEventTranscripts = TRUE
)

## -----------------------------------------------------------------------------
gr <- plotView(
    plotObj, 
    centerByEvent = TRUE, 
    trackList = list(c(1,2)), 
    filterByEventTranscripts = TRUE, 
    showExonRanges = TRUE
)

## -----------------------------------------------------------------------------
names(gr)

## -----------------------------------------------------------------------------
plotView(
    plotObj, 
    centerByEvent = TRUE, 
    trackList = list(c(1,2)), 
    filterByEventTranscripts = TRUE, 
    plotRanges = gr[c("TRA2B-206-E1", "TRA2B-206-E2", "TRA2B-206-E3")]
)

## ----echo=FALSE, out.width='800pt', fig.align = 'center', fig.cap="Coverage Plots Main Panel - GUI"----
knitr::include_graphics("img/Vis_cov1.jpg")

## ----echo=FALSE, out.width='800pt', fig.align = 'center', fig.cap="Group Coverage Plots - GUI"----
knitr::include_graphics("img/Vis_cov2.jpg")

## ----echo=FALSE, out.width='800pt', fig.align = 'center', fig.cap="Generating Exon Coverage (Static) Plots - GUI"----
knitr::include_graphics("img/Vis_cov3.jpg")

## -----------------------------------------------------------------------------
sessionInfo()

