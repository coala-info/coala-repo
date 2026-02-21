# Code example from 'raer' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide"-----------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("raer")

## ----message=FALSE------------------------------------------------------------
library(raer)
library(raerdata)

pbmc <- pbmc_10x()

pbmc_bam <- pbmc$bam
editing_sites <- pbmc$sites
sce <- pbmc$sce

## -----------------------------------------------------------------------------
library(scater)
library(SingleCellExperiment)
library(GenomeInfoDb)
plotUMAP(sce, colour_by = "celltype")

## -----------------------------------------------------------------------------
editing_sites

## -----------------------------------------------------------------------------
editing_sites$REF <- Rle("A")
editing_sites$ALT <- Rle("G")
editing_sites

## ----pileup_cells-------------------------------------------------------------
outdir <- file.path(tempdir(), "sc_edits")
cbs <- colnames(sce)

params <- FilterParam(
    min_mapq = 255, # required alignment MAPQ score
    library_type = "fr-second-strand", # library type
    min_variant_reads = 1
)

e_sce <- pileup_cells(
    bamfile = pbmc_bam,
    sites = editing_sites,
    cell_barcodes = cbs,
    output_directory = outdir,
    cb_tag = "CB",
    umi_tag = "UB",
    param = params
)
e_sce

## -----------------------------------------------------------------------------
dir(outdir)
read_sparray(
    file.path(outdir, "counts.mtx.gz"),
    file.path(outdir, "sites.txt.gz"),
    file.path(outdir, "barcodes.txt.gz")
)

## -----------------------------------------------------------------------------
e_sce <- e_sce[rowSums(assays(e_sce)$nAlt > 0) >= 5, ]
e_sce <- calc_edit_frequency(e_sce,
    edit_from = "Ref",
    edit_to = "Alt",
    replace_na = FALSE
)
altExp(sce) <- e_sce[, colnames(sce)]

## -----------------------------------------------------------------------------
to_plot <- rownames(altExp(sce))[order(rowSums(assay(altExp(sce), "nAlt")),
    decreasing = TRUE
)]

lapply(to_plot[1:5], function(x) {
    plotUMAP(sce, colour_by = x, by_exprs_values = "nAlt")
})

## ----fig.height = 7-----------------------------------------------------------
altExp(sce)$celltype <- sce$celltype

plotGroupedHeatmap(altExp(sce),
    features = to_plot[1:25],
    group = "celltype",
    exprs_values = "nAlt"
)

## -----------------------------------------------------------------------------
is_minus <- strand(editing_sites) == "-"
editing_sites[is_minus]$REF <- "T"
editing_sites[is_minus]$ALT <- "C"
strand(editing_sites[is_minus]) <- "+"

fp <- FilterParam(
    library_type = "unstranded",
    min_mapq = 255,
    min_variant_reads = 1
)

ss2_bams <- c(pbmc_bam, pbmc_bam, pbmc_bam)
cell_ids <- c("cell1", "cell2", "cell3")

pileup_cells(
    bamfiles = ss2_bams,
    cell_barcodes = cell_ids,
    sites = editing_sites,
    umi_tag = NULL, # no UMI tag in most Smart-seq2 libraries
    cb_tag = NULL, # no cell barcode tag
    param = fp,
    output_directory = outdir
)

## -----------------------------------------------------------------------------
ifnb <- GSE99249()
names(ifnb)

## -----------------------------------------------------------------------------
bam_files <- ifnb$bams
names(bam_files)

## -----------------------------------------------------------------------------
fafn <- ifnb$fasta

## -----------------------------------------------------------------------------
editing_sites <- ifnb$sites
chr_18_editing_sites <- keepSeqlevels(editing_sites, "chr18",
    pruning.mode = "coarse"
)

## -----------------------------------------------------------------------------
fp <- FilterParam(
    only_keep_variants = TRUE, # only report sites with variants
    trim_5p = 5, # bases to remove from 5' or 3' end
    trim_3p = 5,
    min_base_quality = 30, # minimum base quality score
    min_mapq = 255, # minimum MAPQ read score
    library_type = "fr-first-strand", # library type
    min_splice_overhang = 10 # minimum required splice site overhang
)

rse <- pileup_sites(bam_files,
    fasta = fafn,
    sites = chr_18_editing_sites,
    chroms = "chr18",
    param = fp
)

rse

## -----------------------------------------------------------------------------
assays(rse)
assay(rse, "nA")[1:5, ]
assay(rse, "nG")[1:5, ]

## -----------------------------------------------------------------------------
colData(rse)$treatment <- "Interferon beta"
colData(rse)$genotype <- factor(rep(c("ADAR1KO", "Wildtype"), each = 3))
colData(rse)

## -----------------------------------------------------------------------------
rse <- calc_edit_frequency(rse,
    edit_from = "A",
    edit_to = "G",
    drop = TRUE
)

## -----------------------------------------------------------------------------
has_editing <- rowSums(assay(rse, "edit_freq") > 0) >= 1
has_depth <- rowSums(assay(rse, "depth") >= 5) == ncol(rse)

rse <- rse[has_editing & has_depth, ]
rse

## -----------------------------------------------------------------------------
deobj <- make_de_object(rse, min_prop = 0.05, min_samples = 3)

assay(deobj, "counts")[1:3, c(1, 7, 2, 8)]

## -----------------------------------------------------------------------------
deobj$sample <- factor(deobj$sample)
de_results <- find_de_sites(deobj,
    test = "DESeq2",
    sample_col = "sample",
    condition_col = "genotype",
    condition_control = "Wildtype",
    condition_treatment = "ADAR1KO"
)

## -----------------------------------------------------------------------------
de_results$sig_results[1:5, ]

## ----fig.height=7, fig.width=5------------------------------------------------
library(ComplexHeatmap)
top_sites <- rownames(de_results$sig_results)[1:20]

Heatmap(assay(rse, "edit_freq")[top_sites, ],
    name = "editing frequency",
    column_labels = paste0(rse$genotype, "-", rse$treatment)
)

## -----------------------------------------------------------------------------
library(AnnotationHub)
library(SNPlocs.Hsapiens.dbSNP144.GRCh38)

ah <- AnnotationHub()
rmsk_hg38 <- ah[["AH99003"]]

alus <- rmsk_hg38[rmsk_hg38$repFamily == "Alu", ]
alus <- alus[seqnames(alus) == "chr18", ]
alus <- keepStandardChromosomes(alus)
alus <- alus[1:1000, ]

seqlevelsStyle(alus) <- "NCBI"
genome(alus) <- "GRCh38.p2"

alu_snps <- get_overlapping_snps(alus, SNPlocs.Hsapiens.dbSNP144.GRCh38)

seqlevelsStyle(alu_snps) <- "UCSC"
alu_snps[1:3, ]

seqlevelsStyle(alus) <- "UCSC"
alus[1:3, ]

## -----------------------------------------------------------------------------
alu_index <- calc_AEI(bam_files,
    fasta = fafn,
    snp_db = alu_snps,
    alu_ranges = alus,
    param = fp
)
names(alu_index)

## -----------------------------------------------------------------------------
Heatmap(alu_index$AEI,
    name = "AEI",
    row_labels = rse$genotype[match(rownames(alu_index$AEI), rse$sample)]
)

## -----------------------------------------------------------------------------
rna_wgs <- NA12878()
names(rna_wgs)

## -----------------------------------------------------------------------------
library(TxDb.Hsapiens.UCSC.hg38.knownGene)

txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene
chr4snps <- rna_wgs$snps

## -----------------------------------------------------------------------------
bams <- rna_wgs$bams
names(bams) <- c("rna", "dna")
fp <- FilterParam(
    min_depth = 1, # minimum read depth across all samples
    min_base_quality = 30, # minimum base quality
    min_mapq = c(255, 30), # minimum MAPQ for each BAM file
    library_type = c("fr-first-strand", "unstranded"), # sample library-types
    trim_5p = 5, # bases to trim from 5' end of alignment
    trim_3p = 5, # bases to trim from 3' end of alignment
    indel_dist = 4, # ignore read if contains an indel within distance from site
    min_splice_overhang = 10, # required spliced alignment overhang
    read_bqual = c(0.25, 20), # fraction of the read with base quality
    only_keep_variants = c(TRUE, FALSE), # report site if rnaseq BAM has variant
    report_multiallelic = FALSE, # exclude sites with multiple variant alleles
)

rse <- pileup_sites(bams,
    fasta = rna_wgs$fasta,
    chroms = "chr4",
    param = fp
)

rse

## -----------------------------------------------------------------------------
to_keep <- (assay(rse, "nRef")[, "dna"] >= 5 &
    assay(rse, "ALT")[, "dna"] == "-")

rse <- subsetByOverlaps(rse, rse[to_keep, ], ignore.strand = TRUE)
nrow(rse)

## -----------------------------------------------------------------------------
rse <- filter_multiallelic(rse)
rse <- calc_edit_frequency(rse)
rowData(rse)

## -----------------------------------------------------------------------------
# subset both to chromosome 4 to avoid warning about different seqlevels
seqlevels(rse, pruning.mode = "coarse") <- "chr4"
seqlevels(rmsk_hg38, pruning.mode = "coarse") <- "chr4"

rse <- annot_from_gr(rse,
    rmsk_hg38,
    cols_to_map = c("repName", "repClass", "repFamily")
)

rowData(rse)[c("repName", "repFamily")]

## -----------------------------------------------------------------------------
rse <- rse[!rowData(rse)$repFamily %in% c("Simple_repeat", "Low_complexity")]

## -----------------------------------------------------------------------------
seqlevels(txdb, pruning.mode = "coarse") <- "chr4"
rse <- filter_clustered_variants(rse, txdb, variant_dist = 100)
rse

## -----------------------------------------------------------------------------
rse <- annot_from_gr(rse, chr4snps, "name")
rowData(rse)[c("name")]

rse <- rse[is.na(rowData(rse)$name), ]
rse

## -----------------------------------------------------------------------------
to_keep <- assay(rse, "edit_freq")[, 1] > 0.05
rse <- rse[to_keep, ]

rse <- rse[assay(rse, "nAlt")[, 1] >= 2]

## -----------------------------------------------------------------------------
rowRanges(rse)

## -----------------------------------------------------------------------------
sessionInfo()

