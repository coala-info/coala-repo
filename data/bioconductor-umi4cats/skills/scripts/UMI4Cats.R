# Code example from 'UMI4Cats' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval = TRUE,
    warning = FALSE,
    message = FALSE,
    fig.align = "center",
    out.width = "80%"
)

## ----logo, echo=FALSE, eval=TRUE, out.width='10%'-----------------------------
knitr::include_graphics("../man/figures/UMI4Cats.png", dpi = 800)

## ----load---------------------------------------------------------------------
library(UMI4Cats)

## ----umi4cats-scheme, echo=FALSE, eval=TRUE, fig.cap="Overview of the different functions included in the UMI4Cats package to analyze UMI-4C data."----
knitr::include_graphics("figures/scheme.png", dpi = 400)

## ----processing-quick-start, eval=FALSE---------------------------------------
# ## 0) Download example data -------------------------------
# path <- downloadUMI4CexampleData()
# 
# ## 1) Generate Digested genome ----------------------------
# # The selected RE in this case is DpnII (|GATC), so the cut_pos is 0, and the res_enz "GATC".
# hg19_dpnii <- digestGenome(
#     cut_pos = 0,
#     res_enz = "GATC",
#     name_RE = "DpnII",
#     ref_gen = BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19,
#     out_path = file.path(tempdir(), "digested_genome/")
# )
# 
# ## 2) Process UMI-4C fastq files --------------------------
# raw_dir <- file.path(path, "CIITA", "fastq")
# 
# contactsUMI4C(
#     fastq_dir = raw_dir,
#     wk_dir = file.path(path, "CIITA"),
#     bait_seq = "GGACAAGCTCCCTGCAACTCA",
#     bait_pad = "GGACTTGCA",
#     res_enz = "GATC",
#     cut_pos = 0,
#     digested_genome = hg19_dpnii,
#     bowtie_index = file.path(path, "ref_genome", "ucsc.hg19.chr16"),
#     ref_gen = BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19,
#     threads = 5
# )
# 
# ## 3) Get filtering and alignment stats -------------------
# statsUMI4C(wk_dir = file.path(path, "CIITA"))
# 
# ## 4) Analyze the results ---------------------------------
# # Load sample processed file paths
# files <- list.files(file.path(path, "CIITA", "count"),
#                     pattern = "*_counts.tsv.gz",
#                     full.names = TRUE
# )
# 
# # Create colData including all relevant information
# colData <- data.frame(
#     sampleID = gsub("_counts.tsv.gz", "", basename(files)),
#     file = files,
#     stringsAsFactors = FALSE
# )
# 
# library(tidyr)
# colData <- colData |>
#     separate(sampleID,
#         into = c("condition", "replicate", "viewpoint"),
#         remove = FALSE
#     )
# 
# # Make UMI-4C object including grouping by condition
# umi <- makeUMI4C(
#     colData = colData,
#     viewpoint_name = "CIITA",
#     grouping = "condition",
#     bait_expansion = 2e6
# )
# 
# # Plot replicates
# plotUMI4C(umi, grouping=NULL)
# 
# ## 5) Get significant interactions
# # Generate windows
# win_frags <- makeWindowFragments(umi, n_frags=8)
# 
# # Call interactions
# gr <-  callInteractions(umi4c = umi,
#                         design = ~condition,
#                         query_regions = win_frags,
#                         padj_threshold = 0.01,
#                         zscore_threshold=2)
# 
# # Plot interactions
# all <- plotInteractionsUMI4C(umi, gr, grouping = NULL, significant=FALSE, xlim=c(10.75e6, 11.1e6)) # Plot all regions
# sign <- plotInteractionsUMI4C(umi, gr, grouping = NULL, significant=TRUE, xlim=c(10.75e6, 11.1e6)) # Plot only significantly interacting regions
# cowplot::plot_grid(all, sign, ncol=2, labels=c("All", "Significant"))
# 
# # Obtain unique significant interactions
# inter <- getSignInteractions(gr)
# 
# ## 6) Differential testing ----------------------
# # Fisher test
# umi_fisher <- fisherUMI4C(umi, query_regions = iter,
#                           filter_low = 20,
#                           grouping="condition")
# plotUMI4C(umi_fisher, ylim = c(0, 10), grouping="condition")
# 
# # DESeq2 Wald Test
# umi_wald <- waldUMI4C(umi4c=umi,
#                       query_regions = inter,
#                       design=~condition)
# 
# plotUMI4C(umi_wald, ylim = c(0, 10), grouping="condition")

## ----demultiplex, eval=TRUE---------------------------------------------------
## Input files
path <- downloadUMI4CexampleData(reduced=TRUE)
fastq <- file.path(path, "CIITA", "fastq", "ctrl_hi24_CIITA_R1.fastq.gz")

## Barcode info
barcodes <- data.frame(
    sample = c("CIITA"),
    barcode = c("GGACAAGCTCCCTGCAACTCA")
)

## Output path
out_path <- tempdir()

## Demultiplex baits inside FastQ file
demultiplexFastq(
    fastq = fastq,
    barcodes = barcodes,
    out_path = out_path
)

## ----digest-------------------------------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg19)
refgen <- BSgenome.Hsapiens.UCSC.hg19

hg19_dpnii <- digestGenome(
    res_enz = "GATC",
    cut_pos = 0,
    name_RE = "dpnII",
    ref_gen = refgen,
    sel_chr = "chr16", # Select bait's chr (chr16) to make example faster
    out_path = file.path(tempdir(), "digested_genome/")
)

hg19_dpnii

## ----read-scheme, echo=FALSE, eval=TRUE, fig.cap="Schematic of a UMI-4C read detailing the different elements that need to be used as input for processing the data."----
knitr::include_graphics("figures/read_scheme.png", dpi = 500)

## ----processing, message=TRUE-------------------------------------------------
## Use reduced example to make vignette faster
## If you want to download the full dataset, set reduced = FALSE or remove
## the reduce argument.
## The reduced example is already downloaded in the demultiplexFastq chunk.

# path <- downloadUMI4CexampleData(reduced=TRUE)
raw_dir <- file.path(path, "CIITA", "fastq")
index_path <- file.path(path, "ref_genome", "ucsc.hg19.chr16")

## Run main function to process UMI-4C contacts
contactsUMI4C(
    fastq_dir = raw_dir,
    wk_dir = file.path(path, "CIITA"),
    file_pattern = "ctrl_hi24_CIITA", # Select only one sample to reduce running time
    bait_seq = "GGACAAGCTCCCTGCAACTCA",
    bait_pad = "GGACTTGCA",
    res_enz = "GATC",
    cut_pos = 0,
    digested_genome = hg19_dpnii,
    bowtie_index = index_path,
    ref_gen = BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19,
    sel_seqname = "chr16", # Input bait chr to reduce running time
    threads = 2,
    numb_reads = 1e6 # Reduce memory usage
)

## ----stats--------------------------------------------------------------------
# Using the full dataset included in the package
statsUMI4C(wk_dir = system.file("extdata", "CIITA",
    package = "UMI4Cats"
))

# Read stats table
stats <- read.delim(system.file("extdata", "CIITA", "logs", "stats_summary.txt",
    package = "UMI4Cats"
))

knitr::kable(stats)

## ----make-umi4c---------------------------------------------------------------
# Load sample processed file paths
files <- list.files(system.file("extdata", "CIITA", "count", package="UMI4Cats"),
                    pattern = "*_counts.tsv.gz",
                    full.names = TRUE
)

# Create colData including all relevant information
colData <- data.frame(
    sampleID = gsub("_counts.tsv.gz", "", basename(files)),
    file = files,
    stringsAsFactors = FALSE
)

library(tidyr)
colData <- colData |>
    separate(sampleID,
        into = c("condition", "replicate", "viewpoint"),
        remove = FALSE
    )

# Load UMI-4C data and generate UMI4C object
umi <- makeUMI4C(
    colData = colData,
    viewpoint_name = "CIITA",
    grouping = "condition",
    ref_umi4c = c("condition"="ctrl"),
    bait_expansion = 2e6
)

umi
groupsUMI4C(umi)

## ----methods-umi4c------------------------------------------------------------
groupsUMI4C(umi) # Available grouped UMI-4C objects

head(assay(umi)) # Retrieve raw UMIs
head(assay(groupsUMI4C(umi)$condition)) # Retrieve UMIs grouped by condition

colData(umi) # Retrieve column information

rowRanges(umi) # Retrieve fragment coordinates

dgram(umi) # Retrieve domainograms
dgram(groupsUMI4C(umi)$condition) # Retrieve domainograms

bait(umi) # Retrieve bait coordinates

head(trend(umi)) # Retrieve adaptive smoothing trend

## ----interactions-win, fig.width=12, fig.height=7, results="hold"-------------
# Generate windows
win_frags <- makeWindowFragments(umi, n_frags=8)

# Call interactions
gr <-  callInteractions(umi4c = umi, 
                        design = ~condition, 
                        query_regions = win_frags, 
                        padj_threshold = 0.01, 
                        zscore_threshold=2)

# Plot interactions
all <- plotInteractionsUMI4C(umi, gr, grouping = NULL, significant=FALSE, xlim=c(10.75e6, 11.1e6)) # Plot all regions
sign <- plotInteractionsUMI4C(umi, gr, grouping = NULL, significant=TRUE, xlim=c(10.75e6, 11.1e6)) # Plot only significantly interacting regions
cowplot::plot_grid(all, sign, ncol=2, labels=c("All", "Significant"))

# Obtain unique significant interactions
inter <- getSignInteractions(gr)

## ----dif-deseq, message=TRUE, eval=TRUE---------------------------------------
umi_wald <- waldUMI4C(umi,
                      query_regions = inter,
                      design = ~condition)

## ----dif-query----------------------------------------------------------------
# Perform differential test
umi_fisher <- fisherUMI4C(umi,
                          grouping = "condition",
                          query_regions = inter,
                          filter_low = 20)

## ----show-results-umi4c-------------------------------------------------------
resultsUMI4C(umi_fisher, ordered = TRUE, counts = TRUE, format = "data.frame")

## ----plot-umi4c---------------------------------------------------------------
plotUMI4C(umi,
    grouping = NULL,
    TxDb = TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene,
    OrgDb = "org.Hs.eg.db",
    dgram_plot = FALSE
)

## ----plot-dif-----------------------------------------------------------------
plotUMI4C(umi_fisher, grouping = "condition", xlim=c(10.75e6, 11.25e6), ylim=c(0,10))

## -----------------------------------------------------------------------------
sessionInfo()

