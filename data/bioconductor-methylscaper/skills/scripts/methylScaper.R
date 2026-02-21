# Code example from 'methylScaper' vignette. See references/ for full tutorial.

## ----eval=F-------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("methylscaper")

## ----message = FALSE, warning=FALSE-------------------------------------------
library(methylscaper)

## ----eval=F-------------------------------------------------------------------
# methylscaper()

## ----eval=FALSE---------------------------------------------------------------
# filepath <- "~/Downloads/GSE109262_RAW/"
# singlecell_subset <- subsetSC(filepath, chromosome = 19, startPos = 8937041, endPos = 8997041)
# # To save for later, save as an rds file and change the folder location as desired:
# saveRDS(singlecell_subset, "~/Downloads/singlecell_subset.rds")

## ----eval=TRUE----------------------------------------------------------------
gse_subset_path <- list(
    c(
        "https://rbacher.rc.ufl.edu/methylscaper/data/GSE109262_SUBSET/GSM2936197_ESC_A08_CpG-met_processed.tsv.gz",
        "https://rbacher.rc.ufl.edu/methylscaper/data/GSE109262_SUBSET/GSM2936196_ESC_A07_CpG-met_processed.tsv.gz",
        "https://rbacher.rc.ufl.edu/methylscaper/data/GSE109262_SUBSET/GSM2936192_ESC_A03_CpG-met_processed.tsv.gz"
    ),
    c(
        "https://rbacher.rc.ufl.edu/methylscaper/data/GSE109262_SUBSET/GSM2936197_ESC_A08_GpC-acc_processed.tsv.gz",
        "https://rbacher.rc.ufl.edu/methylscaper/data/GSE109262_SUBSET/GSM2936196_ESC_A07_GpC-acc_processed.tsv.gz",
        "https://rbacher.rc.ufl.edu/methylscaper/data/GSE109262_SUBSET/GSM2936192_ESC_A03_GpC-acc_processed.tsv.gz"
    ),
    c("GSM2936197_ESC_A08_CpG-met_processed", "GSM2936196_ESC_A07_CpG-met_processed", "GSM2936192_ESC_A03_CpG-met_processed"),
    c("GSM2936197_ESC_A08_GpC-acc_processed", "GSM2936196_ESC_A07_GpC-acc_processed", "GSM2936192_ESC_A03_GpC-acc_processed")
)
# This formatting is a list of 4 objects: the met file urls, the acc file urls, the met file names, and the acc file names.
options(timeout = 1000)
singlecell_subset <- subsetSC(gse_subset_path, chromosome = 19, startPos = 8937041, endPos = 8997041)

# To save for later, save as an rds file and change the folder location as desired:
# saveRDS(singlecell_subset, "~/Downloads/singlecell_subset.rds")

## ----eval=TRUE, fig.width=7, fig.height=3-------------------------------------
data("mouse_bm")
gene.select <- subset(mouse_bm, mgi_symbol == "Eef1g")

startPos <- 8966841
endPos <- 8967541
prepSC.out <- prepSC(singlecell_subset, startPos = startPos, endPos = endPos)

orderObj <- initialOrder(prepSC.out)
plotSequence(orderObj, Title = "Eef1g gene", plotFast = TRUE, drawKey = FALSE)

## ----eval=TRUE, fig.align='left', fig.width=6, fig.height=5-------------------
# If you followed the preprocessing code above, then you can do:
# mydata <- readRDS("~/Downloads/singlecell_subset.rds")
# Otherwise, we have also included this subset in the package directly:
mydata <- system.file("extdata", "singlecell_subset.rds", package = "methylscaper")
mydata <- readRDS(mydata)
gene <- "Eef1g"
data("mouse_bm") # for human use human_bm
gene.select <- subset(mouse_bm, mgi_symbol == gene)
# We will further subset the region to a narrow region of the gene: from 8966841bp to 8967541bp
startPos <- 8966841
endPos <- 8967541

# This subsets the data to a specific region and prepares the data for visualization:
prepSC.out <- prepSC(mydata, startPos = startPos, endPos = endPos)

# Next the cells are ordered using the PCA approach and plot
orderObj <- initialOrder(prepSC.out)
plotSequence(orderObj, Title = "Eef1g gene", plotFast = TRUE)
# We plot the nucleosome size key by default, however this can be turned off via drawKey = FALSE:
# plotSequence(orderObj, Title = "Eef1g gene", plotFast=TRUE, drawKey = FALSE)

## ----eval=TRUE----------------------------------------------------------------
orderObj <- initialOrder(prepSC.out,
    weightStart = 47, weightEnd = 358, weightFeature = "acc"
)

## ----eval=TRUE, fig.width=7, fig.height=6-------------------------------------
plotSequence(orderObj, Title = "Eef1g gene", plotFast = TRUE)

## ----eval=TRUE, fig.width=7, fig.height=6-------------------------------------
orderObj$order1 <- refineFunction(orderObj, refineStart = 1, refineEnd = 20)
plotSequence(orderObj, Title = "Eef1g gene", plotFast = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# png("~/save_my_plot.png", width = 4, height = 6, units = "in", res = 300)
# plotSequence(orderObj, Title = "Eef1g gene", plotFast = FASLE)
# dev.off()

## ----eval=FALSE---------------------------------------------------------------
# # if (!requireNamespace("biomaRt", quietly = TRUE)) {
# #     BiocManager::install("biomaRt")
# # }
# library(biomaRt)
# ensembl <- useMart("ensembl")
# # Demonstrating how to get the human annotations.
# ensembl <- useDataset("hsapiens_gene_ensembl", mart = ensembl)
# my_chr <- c(1:22, "M", "X", "Y") # You can choose to omit this or include additional chromosome
# # We only need the start, end, and symbol:
# human_bm <- getBM(
#     attributes = c("chromosome_name", "start_position", "end_position", "hgnc_symbol"),
#     filters = "chromosome_name",
#     values = my_chr,
#     mart = ensembl
# )
# 
# ## Now that we have the biomart object, we can extract start and ends for methylscaper:
# gene_select <- subset(human_bm, human_bm$hgnc_symbol == "GeneX")
# 
# # These can then be passed into the prepSC function:
# prepSC.out <- prepSC(mydata, startPos = gene_select$startPos, endPos = gene_select$endPos)
# 
# # To continue the analysis:
# # Next the cells are ordered using the PCA approach and then plot:
# orderObj <- initialOrder(prepSC.out)
# plotSequence(orderObj, Title = "Gene X", plotFast = TRUE)

## ----eval = TRUE--------------------------------------------------------------
# This provides the path to the raw datasets located in the methylscaper package
seq_file <- system.file("extdata", "seq_file.fasta", package = "methylscaper")
ref_file <- system.file("extdata", "reference.fa", package = "methylscaper")

# Next we read the data into R using the read.fasta function from the seqinr package:
fasta <- seqinr::read.fasta(seq_file)
ref <- seqinr::read.fasta(ref_file)[[1]]

# For the vignette we will only run a subset of the molecules
singlemolecule_example <- runAlign(fasta = fasta, ref = ref, fasta_subset = 1:150)

# Once complete, we can save the output as an RDS object
# saveRDS(singlemolecule_example, file="~/methylscaper_singlemolecule_preprocessed.rds")

## ----eval=TRUE, fig.width=7, fig.height=6-------------------------------------
# If skipping the preprocessing steps above, use our pre-aligned data:
# data(singlemolecule_example)
orderObj <- initialOrder(singlemolecule_example,
    Method = "PCA",
    weightStart = 308, weightEnd = 475, weightFeature = "red"
)
plotSequence(orderObj, Title = "Ordered by PCA", plotFast = TRUE)

## ----eval=TRUE, fig.align='left', fig.height=8, fig.width=8-------------------
par(mfrow = c(2, 2))
props <- methyl_proportion(orderObj, type = "met", makePlot = TRUE, main = "")
props <- methyl_proportion(orderObj, type = "acc", makePlot = TRUE, main = "")

pcnts <- methyl_percent_sites(orderObj, makePlot = TRUE)
avgs <- methyl_average_status(orderObj, makePlot = TRUE, window_length = 25)

## ----sessionInfo, results='markup'--------------------------------------------
sessionInfo()

