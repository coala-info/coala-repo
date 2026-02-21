# CleanUpRNAseq: detecting and correcting gDNA contamination in RNA-seq data

Haibo Liu1, Kai Hu1, Kevin O'Connor1, Michelle Kelliher1 and Lihua Julie Zhu1

1MCCB, UMass Chan Medical School, Worcester, USA

#### 2025-10-29

#### Abstract

Some RNA-seq data might suffer from genomic DNA (gDNA) contamination due to
carrying over of residual gDNA in RNA preparation into sequencing library.
The R package CleanUpRNAseq provides a set of functionalities to detect and
correct for gDNA contamination, thus facilitate better quantitation of
gene expression and differential expression analysis.

#### Package

CleanUpRNAseq 1.4.0

# 1 Introduction

RNA-seq has become a state-of-art technology for studying gene expression
(Wang, Gerstein, and Snyder [2009](#ref-Wang2009)). However, due to improper RNA preparation and choice of some
library preparation protocols, such as rRNA-depletion based RNA-seq protocol
(O’Neil, Glowatz, and Schlumpberger [2013](#ref-ONeil2013)) and the [SMART-Seq](https://t.ly/sMZho) protocol, RNA-seq data
might suffer from genomic DNA (gDNA) contamination, which skews quantitation
of gene expression and hinders differential gene expression analysis (Li et al. [2022](#ref-Li2022); Verwilt et al. [2020](#ref-Verwilt2020); Markou et al. [2021](#ref-Markou2021)). Some quality control tools have been
developed to check the quality of RNA-seq data at the raw read and
post-alignment levels, including [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/),
RSeQC (Wang, Wang, and Li [2012](#ref-Wang2012)), Qualimap (García-Alcalde et al. [2012](#ref-GarcaAlcalde2012)), RNA-SeQC/RNA-SeQC 2
(DeLuca et al. [2012](#ref-DeLuca2012); Graubert et al. [2021](#ref-Graubert2021)), QoRTs (Hartley and Mullikin [2015](#ref-Hartley2015)), RNA-QC-Chain (Zhou et al. [2018](#ref-Zhou2018)),
and [RNAseqQC](https://cran.r-project.org/web/packages/RNAseqQC/index.html).
Those post-alignment tools can report percentages of reads mapping to different
genomic features, such as genes, exons, introns, intergenic regions, and rRNA
exons. Thus, they can be used to roughly detect gDNA contamination. So far, [SeqMonk](https://www.bioinformatics.babraham.ac.uk/projects/seqmonk/) and the
gDNAx package are the only tool which can be used to both detect and correct
for gDNA contamination in RNA-seq data. However, SeqMonk is a Java-based GUI
tool which makes it not available in most high performance computing cluster.
More importantly, seqMonk assumes a uniform distribution of reads derived from
gDNA contamination and its performance on correcting for gDNA contamination in
RNA-seq data is not fully evaluated and peer reviewed. On the other hand, gDNAx
is an R/Bioconductor package and can be incorporated into automated RNA-seq
data analysis pipeline easily. However, gDNAx only simply removes reads mapping
to intergenic regions and introns, but not those mapping to exons, to mitigate
gDNA contamination. Thus, gDNAx’s algorithm for correcting for gDNA
contamination is not sophisticated. To this end, we developed the R pacakge *[CleanUpRNAseq](https://bioconductor.org/packages/3.22/CleanUpRNAseq)*, which provides a full set of functions for detecting
and correcting for gDNA contamination in RNA-seq data across all computing
platforms.

# 2 Setting up

As for any other sequencing data analysis, users should first check the quality
of raw RNA-seq sequencing data using a tool like [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) followed
by MultiQC (Ewels et al. [2016](#ref-Ewels2016)). Depending on the quality of the raw data, trimming low
quality bases and/or adpator sequences might be necessary to increase mapping
quality and rate. Subsequently, reads are mapped to the reference genome of
interest using tools, such as STAR (Dobin et al. [2012](#ref-Dobin2012)), HISAT2 (Kim et al. [2019](#ref-Kim2019)),
GMAP (Wu et al. [2016](#ref-Wu2016)), and Subread (Liao, Smyth, and Shi [2013](#ref-Liao2013)). The resulting alignment files in the
BAM format are used for post-alignment quality control, including detection of
gDNA contamination. Meanwhile, if the RNA-seq library is *unstranded*, reads
are mapped to the reference transcriptome using Salmon (Patro et al. [2017](#ref-Patro2017)) to get
transcript-level abundance, counts, and effective lengths, since Salmon can
resolve reads mapped to multiple transcripts, which are imported into R using
the *[tximport](https://bioconductor.org/packages/3.22/tximport)* to get gene-level counts, abundance and length
information. However, if the library is *stranded*, reads are mapped to the
reference transcriptome using Salmon twice: one using the designed strandedness
for the ‘–libType’ option, the other using the opposite strandedness. See
Salmon library type discussion
<https://salmon.readthedocs.io/en/latest/library_type.html>. Then gene-level
counts, abundance and length information are imported into R as above.

# 3 How to run CleanUpRNAseq

First, load the required packages, including CleanUpRNAseq. Then users can
perform a step-by-step analysis of the RNA-seq data as below for more
flexibility. For users’ convenience, CleanUpRNAseq also offers two wrapper
functions, create\_diagnostic\_plots and correct\_for\_contamination, for detecting
and correcting for gDNA contamination in RNA-seq data. As for how to use these
wrappers, please refer to their function documentation.

```
suppressPackageStartupMessages({
  library("CleanUpRNAseq")
  #devtools::load_all("../../CleanUpRNAseq")
  library("ggplotify")
  library("patchwork")
  library("ensembldb")
  library("utils")
})
```

## 3.1 Step 1: Load an EnsDb package or prepare an EnsDb database

Users can list all current EnsDb packages from *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* and
load the package of choice, if available, as follows. Here, an EnsDb package
for the human genome is loaded. It is crucial to use an EnsDb pacakge which
represents the genome annotation file (GTF) used for RNA-seq read alignment.

```
suppressPackageStartupMessages({
  library("EnsDb.Hsapiens.v86")
})
hs_ensdb_sqlite <- EnsDb.Hsapiens.v86
```

Otherwise, users can easily prepare an EnsDb database from an Ensembl GTF file.
For all following steps, this option is adopted because the latest version of
human transcriptome has been used for read mapping by STAR and Salmon to
quantify gene expression of the example RNA-seq data.

```
options(timeout = max(3000, getOption("timeout")))
tmp_dir <- tempdir()
gtf <- system.file("extdata", "example.gtf.gz",
                    package = "CleanUpRNAseq")

hs_ensdb_sqlite <-
  ensDbFromGtf(
        gtf = gtf,
        outfile = file.path(tmp_dir, "EnsDb.hs.v110.sqlite"),
        organism = "Homo_Sapiens",
        genomeVersion = "GRCh38",
        version = 110
  )
```

## 3.2 Step 2. Prepare SAF (simplified annotation format) files

Potential DNA contamination exists if a significantly high portion of RNA-seq
reads mapped to intergenic regions. *[CleanUpRNAseq](https://bioconductor.org/packages/3.22/CleanUpRNAseq)* uses the
*featureCounts* function from the *[Rsubread](https://bioconductor.org/packages/3.22/Rsubread)* package to
quantify the percentage of reads mapped to different genomic features: genes,
exons, introns, intergenic regions, rRNA exons, and organelle genome(s). So
users need to prepare SAF files for these genomic features. In addition,
a BAM file is needed to provide the lengths of the chromosomes/scaffolds.

```
bam_file <- system.file("extdata", "K084CD7PCD1N.srt.bam",
    package = "CleanUpRNAseq"
)
saf_list <- get_saf(
    ensdb_sqlite = hs_ensdb_sqlite,
    bamfile = bam_file,
    mitochondrial_genome = "MT"
)
```

## 3.3 Step 3. Summarize reads mapped to different genomic features

Reads mapped to different genomic features is summarized by using the
*featureCounts* function with the SAF files generated above as annotation.
*[CleanUpRNAseq](https://bioconductor.org/packages/3.22/CleanUpRNAseq)* also quantifies the reads spanning exon-exon
junctions and the reads mapped to exons of each gene using the GTF file as
annotation. The junction read count table is used to determine the unexpressed,
multiexonic genes, while the gene-level read count table is used for comparing
samples at the gene level. Here two downsampled BAM files are used for speeding
up the demonstration, while a precomputed R object in the .RData format is
used for actual downstream analysis.

```
 tmp_dir <- tempdir()
 in_dir <- system.file("extdata", package = "CleanUpRNAseq")
 gtf.gz <- dir(in_dir, ".gtf.gz$", full.name = TRUE)
 gtf <- file.path(tmp_dir, gsub("\\.gz", "", basename(gtf.gz)))
 R.utils::gunzip(gtf.gz, destname= gtf,
                 overwrite = TRUE, remove = FALSE)

 in_dir <- system.file("extdata", package = "CleanUpRNAseq")
 BAM_file <- dir(in_dir, ".bam$", full.name = TRUE)
 salmon_quant_file <- dir(in_dir, ".sf$", full.name = TRUE)
 sample_name = gsub(".+/(.+?).srt.bam", "\\1", BAM_file)
 salmon_quant_file_opposite_strand <- salmon_quant_file
 col_data <- data.frame(sample_name = sample_name,
                        BAM_file = BAM_file,
                        salmon_quant_file = salmon_quant_file,
                        salmon_quant_file_opposite_strand =
                            salmon_quant_file_opposite_strand,
                        group = c("CD1N", "CD1P"))

 sc <- create_summarizedcounts(lib_strand = 0, colData = col_data)

## featurecounts
 capture.output({counts_list <- summarize_reads(
     SummarizedCounts = sc,
     saf_list = saf_list,
     gtf = gtf,
     threads = 1,
     verbose = TRUE
 )}, file = tempfile())

## load salmon quant
salmon_counts <- salmon_tximport(
     SummarizedCounts = sc,
     ensdb_sqlite = hs_ensdb_sqlite
)
```

## 3.4 Step 4. Check DNA contamination

Precomputed R object in the .RData format (*feature\_counts\_list.rda*, and
*salmon\_quant.rda*)
containing the *featureCounts* output and *Salmon quantification* output
imported by using the `tximport` function for a RNA-seq dataset of 8 samples
from two treatment groups are used for demo. GC-content for genes and
intergenic regions (*intergenic\_GC.rda*, and *gene\_GC.rda*) were also
precomputed and used for demo.

```
data("feature_counts_list")
data("salmon_quant")
data("intergenic_GC")
data("gene_GC")

lib_strand <- 0
col_data_f <- system.file("extdata", "example.colData.txt",
                          package = "CleanUpRNAseq")
col_data <- read.delim(col_data_f, as.is = TRUE)
## create fake bam files
tmp_dir <- tempdir()
bamfiles <- gsub(".+/", "", col_data$BAM_file)
null <- lapply(file.path(tmp_dir, bamfiles), file.create)
## create fake quant.sf files
quant_sf <- file.path(tmp_dir, gsub(".srt.bam$",
                                     "quant.sf",
                                     bamfiles))
null <- lapply(quant_sf, file.create)
col_data$BAM_file <- file.path(tmp_dir, bamfiles)
col_data$salmon_quant_file <- quant_sf

## pretend this is stranded RA=NA-seq data
col_data$salmon_quant_file_opposite_strand <- quant_sf

sc <- create_summarizedcounts(lib_strand, col_data)
sc$set_feature_counts(feature_counts_list)
sc$set_salmon_quant(salmon_quant)
sc$set_salmon_quant_opposite(salmon_quant)

p_assignment_stat <-plot_assignment_stat(SummarizedCounts = sc)
wrap_plots(p_assignment_stat)
```

![Read mapping status](data:image/png;base64...)

Figure 1: Read mapping status

```
assigned_per_region <- get_region_stat(SummarizedCounts = sc)
p <- plot_read_distr(assigned_per_region)
p
```

![Read distribution over different genomic features](data:image/png;base64...)

Figure 2: Read distribution over different genomic features

```
plot_sample_corr(SummarizedCounts = sc)
```

![Smoothed scatter plot showing pairwise sample correlation](data:image/png;base64...)

Figure 3: Smoothed scatter plot showing pairwise sample correlation

```
p_expr_distr <- plot_expr_distr(
    SummarizedCounts = sc,
    normalization = "DESeq2"
)
wrap_plots(p_expr_distr, ncol = 1, nrow = 3)
```

![Expression distribution](data:image/png;base64...)

Figure 4: Expression distribution

```
plot_gene_content(
    SummarizedCounts = sc,
    min_cpm = 1,
    min_tpm =1
)
```

![Percent of expressed genes](data:image/png;base64...)

Figure 5: Percent of expressed genes

```
## DESeq2 exploratory analysis before correction
p<- plot_pca_heatmap(SummarizedCounts = sc,
                     silent = TRUE)
p$pca + as.ggplot(p$heatmap)
```

![PCA score plot and heatmap showing sample similarity](data:image/png;base64...)

Figure 6: PCA score plot and heatmap showing sample similarity

## 3.5 Step 5. Correct for DNA contamination

If the libraries are unstranded, *[CleanUpRNAseq](https://bioconductor.org/packages/3.22/CleanUpRNAseq)* uses a median
per-base read coverage (median\_PBRC) over non-zero count intergenic
regions to estimate per-base DNA contamination over exons of each gene of each
sample, and corrects for gene-level DNA contamination by subtracting
median\_PBRC \* average\_gene\_length from the Salmon count table of each gene of
each sample.

```
global_correction <- correct_global(SummarizedCounts = sc)
```

Alternatively, for unstranded RNA-seq data, *[CleanUpRNAseq](https://bioconductor.org/packages/3.22/CleanUpRNAseq)* offers
a correction method leveraging GC-content bias on PCR amplification.

```
gc_correction <-
    correct_GC(
        SummarizedCounts = sc,
        gene_gc = gene_GC,
        intergenic_gc = intergenic_GC,
        plot = FALSE
    )
```

However, if the libraries are stranded, *[CleanUpRNAseq](https://bioconductor.org/packages/3.22/CleanUpRNAseq)* considered
as gene-level contamination the count table resulted from quantitation using the
opposite strandedness setting. By subtracting the DNA contamination of each gene
in each sample from the count table resulted from quantitation using the actual
strandedness setting, users can get contamination corrected count table. To this
end, use the `correct_stranded` function.

## 3.6 Step 6. Check correction effect

After correcting for DNA contamination, we expect to see more comparable gene
expression across samples.

Boxplots, density plots and empirical cumulative distribution after correction
revealed gene expression across samples are more comparable.

# 4 Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled running pandoc 2.7.3:

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] ensembldb_2.34.0        AnnotationFilter_1.34.0 GenomicFeatures_1.62.0
##  [4] AnnotationDbi_1.72.0    Biobase_2.70.0          GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0           IRanges_2.44.0          S4Vectors_0.48.0
## [10] BiocGenerics_0.56.0     generics_0.1.4          patchwork_1.3.2
## [13] ggplotify_0.1.3         CleanUpRNAseq_1.4.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              tximport_1.38.0
##   [5] magrittr_2.0.4              magick_2.9.0
##   [7] farver_2.1.2                rmarkdown_2.30
##   [9] fs_1.6.6                    BiocIO_1.20.0
##  [11] vctrs_0.6.5                 memoise_2.0.1
##  [13] Rsamtools_2.26.0            RCurl_1.98-1.17
##  [15] base64enc_0.1-3             tinytex_0.57
##  [17] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [19] curl_7.0.0                  SparseArray_1.10.0
##  [21] Formula_1.2-5               gridGraphics_0.5-1
##  [23] sass_0.4.10                 KernSmooth_2.23-26
##  [25] bslib_0.9.0                 htmlwidgets_1.6.4
##  [27] plyr_1.8.9                  cachem_1.1.0
##  [29] GenomicAlignments_1.46.0    lifecycle_1.0.4
##  [31] pkgconfig_2.0.3             Matrix_1.7-4
##  [33] R6_2.6.1                    fastmap_1.2.0
##  [35] MatrixGenerics_1.22.0       digest_0.6.37
##  [37] colorspace_2.1-2            DESeq2_1.50.0
##  [39] Hmisc_5.2-4                 RSQLite_2.4.3
##  [41] labeling_0.4.3              httr_1.4.7
##  [43] abind_1.4-8                 mgcv_1.9-3
##  [45] compiler_4.5.1              withr_3.0.2
##  [47] bit64_4.6.0-1               htmlTable_2.4.3
##  [49] S7_0.2.0                    backports_1.5.0
##  [51] BiocParallel_1.44.0         DBI_1.2.3
##  [53] R.utils_2.13.0              rappdirs_0.3.3
##  [55] DelayedArray_0.36.0         rjson_0.2.23
##  [57] tools_4.5.1                 foreign_0.8-90
##  [59] nnet_7.3-20                 R.oo_1.27.1
##  [61] glue_1.8.0                  restfulr_0.0.16
##  [63] nlme_3.1-168                grid_4.5.1
##  [65] checkmate_2.3.3             cluster_2.1.8.1
##  [67] reshape2_1.4.4              sva_3.58.0
##  [69] gtable_0.3.6                BSgenome_1.78.0
##  [71] tzdb_0.5.0                  R.methodsS3_1.8.2
##  [73] qsmooth_1.26.0              hms_1.1.4
##  [75] data.table_1.17.8           XVector_0.50.0
##  [77] ggrepel_0.9.6               pillar_1.11.1
##  [79] stringr_1.5.2               vroom_1.6.6
##  [81] yulab.utils_0.2.1           limma_3.66.0
##  [83] genefilter_1.92.0           splines_4.5.1
##  [85] dplyr_1.1.4                 lattice_0.22-7
##  [87] survival_3.8-3              rtracklayer_1.70.0
##  [89] bit_4.6.0                   annotate_1.88.0
##  [91] tidyselect_1.2.1            locfit_1.5-9.12
##  [93] Biostrings_2.78.0           knitr_1.50
##  [95] gridExtra_2.3               bookdown_0.45
##  [97] ProtGenerics_1.42.0         edgeR_4.8.0
##  [99] SummarizedExperiment_1.40.0 xfun_0.53
## [101] statmod_1.5.1               matrixStats_1.5.0
## [103] pheatmap_1.0.13             stringi_1.8.7
## [105] UCSC.utils_1.6.0            lazyeval_0.2.2
## [107] yaml_2.3.10                 evaluate_1.0.5
## [109] codetools_0.2-20            cigarillo_1.0.0
## [111] archive_1.1.12              tibble_3.3.0
## [113] BiocManager_1.30.26         cli_3.6.5
## [115] rpart_4.1.24                xtable_1.8-4
## [117] jquerylib_0.1.4             Rsubread_2.24.0
## [119] dichromat_2.0-0.1           Rcpp_1.1.0
## [121] GenomeInfoDb_1.46.0         png_0.1-8
## [123] XML_3.99-0.19               parallel_4.5.1
## [125] readr_2.1.5                 ggplot2_4.0.0
## [127] blob_1.2.4                  bitops_1.0-9
## [129] scales_1.4.0                crayon_1.5.3
## [131] rlang_1.1.6                 KEGGREST_1.50.0
```

DeLuca, David S., Joshua Z. Levin, Andrey Sivachenko, Timothy Fennell, Marc-Danie Nazaire, Chris Williams, Michael Reich, Wendy Winckler, and Gad Getz. 2012. “RNA-Seqc: RNA-Seq Metrics for Quality Control and Process Optimization.” *Bioinformatics* 28 (11): 1530–2. <https://doi.org/10.1093/bioinformatics/bts196>.

Dobin, Alexander, Carrie A. Davis, Felix Schlesinger, Jorg Drenkow, Chris Zaleski, Sonali Jha, Philippe Batut, Mark Chaisson, and Thomas R. Gingeras. 2012. “STAR: Ultrafast Universal Rna-Seq Aligner.” *Bioinformatics* 29 (1): 15–21. <https://doi.org/10.1093/bioinformatics/bts635>.

Ewels, Philip, Måns Magnusson, Sverker Lundin, and Max Käller. 2016. “MultiQC: Summarize Analysis Results for Multiple Tools and Samples in a Single Report.” *Bioinformatics* 32 (19): 3047–8. <https://doi.org/10.1093/bioinformatics/btw354>.

García-Alcalde, Fernando, Konstantin Okonechnikov, José Carbonell, Luis M. Cruz, Stefan Götz, Sonia Tarazona, Joaquín Dopazo, Thomas F. Meyer, and Ana Conesa. 2012. “Qualimap: Evaluating Next-Generation Sequencing Alignment Data.” *Bioinformatics* 28 (20): 2678–9. <https://doi.org/10.1093/bioinformatics/bts503>.

Graubert, Aaron, François Aguet, Arvind Ravi, Kristin G Ardlie, and Gad Getz. 2021. “RNA-Seqc 2: Efficient Rna-Seq Quality Control and Quantification for Large Cohorts.” Edited by Anthony Mathelier. *Bioinformatics* 37 (18): 3048–50. <https://doi.org/10.1093/bioinformatics/btab135>.

Hartley, Stephen W., and James C. Mullikin. 2015. “QoRTs: A Comprehensive Toolset for Quality Control and Data Processing of Rna-Seq Experiments.” *BMC Bioinformatics* 16 (1). <https://doi.org/10.1186/s12859-015-0670-5>.

Kim, Daehwan, Joseph M. Paggi, Chanhee Park, Christopher Bennett, and Steven L. Salzberg. 2019. “Graph-Based Genome Alignment and Genotyping with Hisat2 and Hisat-Genotype.” *Nature Biotechnology* 37 (8): 907–15. <https://doi.org/10.1038/s41587-019-0201-4>.

Li, Xiangnan, Peipei Zhang, Haijian Wang, and Ying Yu. 2022. “Genes Expressed at Low Levels Raise False Discovery Rates in Rna Samples Contaminated with Genomic Dna.” *BMC Genomics* 23 (1). <https://doi.org/10.1186/s12864-022-08785-1>.

Liao, Yang, Gordon K. Smyth, and Wei Shi. 2013. “The Subread Aligner: Fast, Accurate and Scalable Read Mapping by Seed-and-Vote.” *Nucleic Acids Research* 41 (10): e108–e108. <https://doi.org/10.1093/nar/gkt214>.

Markou, Athina N., Stavroula Smilkou, Emilia Tsaroucha, and Evi Lianidou. 2021. “The Effect of Genomic Dna Contamination on the Detection of Circulating Long Non-Coding Rnas: The Paradigm of Malat1.” *Diagnostics* 11 (7): 1160. <https://doi.org/10.3390/diagnostics11071160>.

O’Neil, Dominic, Heike Glowatz, and Martin Schlumpberger. 2013. “Ribosomal Rna Depletion for Efficient Use of Rna‐Seq Capacity.” *Current Protocols in Molecular Biology* 103 (1): 4.19.1–4.19.8. <https://doi.org/10.1002/0471142727.mb0419s103>.

Patro, Rob, Geet Duggal, Michael I Love, Rafael A Irizarry, and Carl Kingsford. 2017. “Salmon Provides Fast and Bias-Aware Quantification of Transcript Expression.” *Nature Methods* 14 (4): 417–19. <https://doi.org/10.1038/nmeth.4197>.

Verwilt, Jasper, Wim Trypsteen, Ruben Van Paemel, Katleen De Preter, Maria D. Giraldez, Pieter Mestdagh, and Jo Vandesompele. 2020. “When Dna Gets in the Way: A Cautionary Note for Dna Contamination in Extracellular Rna-Seq Studies.” *Proceedings of the National Academy of Sciences* 117 (32): 18934–6. <https://doi.org/10.1073/pnas.2001675117>.

Wang, Liguo, Shengqin Wang, and Wei Li. 2012. “RSeQC: Quality Control of Rna-Seq Experiments.” *Bioinformatics* 28 (16): 2184–5. <https://doi.org/10.1093/bioinformatics/bts356>.

Wang, Zhong, Mark Gerstein, and Michael Snyder. 2009. “RNA-Seq: A Revolutionary Tool for Transcriptomics.” *Nature Reviews Genetics* 10 (1): 57–63. <https://doi.org/10.1038/nrg2484>.

Wu, Thomas D., Jens Reeder, Michael Lawrence, Gabe Becker, and Matthew J. Brauer. 2016. “GMAP and Gsnap for Genomic Sequence Alignment: Enhancements to Speed, Accuracy, and Functionality.” In *Statistical Genomics*, 283–334. Springer New York. <https://doi.org/10.1007/978-1-4939-3578-9_15>.

Zhou, Qian, Xiaoquan Su, Gongchao Jing, Songlin Chen, and Kang Ning. 2018. “RNA-Qc-Chain: Comprehensive and Fast Quality Control for Rna-Seq Data.” *BMC Genomics* 19 (1). <https://doi.org/10.1186/s12864-018-4503-6>.