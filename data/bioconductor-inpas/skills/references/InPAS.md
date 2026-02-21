# InPAS Vignette

Jianhong Ou, Haibo Liu, Sungmi Park, Michael Green, Lihua Julie Zhu

#### 2025-11-25

#### Abstract

Alternative polyadenylation (APA) is one of the important post-transcriptional regulation mechanisms which occurs in most mammalian genes. InPAS facilitates the discovery of novel APA sites and the differential usage of APA sites from RNA-Seq data. It leverages cleanUpdTSeq[1](#ref-sheppard2013accurate) to fine tune identified APA sites by removing false sites.

#### Package

InPAS 2.18.1

# Contents

* [1 Introduction](#introduction)
* [2 How to run InPAS](#how-to-run-inpas)
  + [2.1 Step 1: set up a SQLite database](#step-1-set-up-a-sqlite-database)
  + [2.2 Step 2: Extracting 3’ UTR annotation](#step-2-extracting-3-utr-annotation)
  + [2.3 Step 3: reformatting coverage data](#step-3-reformatting-coverage-data)
  + [2.4 Step 4: Identifying potential CP sites](#step-4-identifying-potential-cp-sites)
  + [2.5 Step 5: Estimate usage of proximal and distal CP sites](#step-5-estimate-usage-of-proximal-and-distal-cp-sites)
  + [2.6 Step 6. identifying differential PDUI events](#step-6.-identifying-differential-pdui-events)
  + [2.7 Step 7. Visualizing dPDUI events and preparing files for GSEA](#step-7.-visualizing-dpdui-events-and-preparing-files-for-gsea)
* [3 Session Info](#session-info)

# 1 Introduction

Alternative polyadenylation (APA) is one of the most important post-transcriptional regulation mechanisms which is prevalent in Eukaryotes. Like alternative splicing, APA can increase transcriptome diversity. In addition, it defines 3’ UTR and results in altered expression of the gene. It is a tightly controlled process and mis-regulation of APA can affect many biological processed, such as uncontrolled cell cycle and growth. Although several high throughput sequencing methods have been developed, there are still limited data dedicated to identifying APA events.

However, massive RNA-seq datasets, which were originally created to quantify genome-wide gene expression, are available in public databases such as GEO and TCGA. These RNA-seq datasets also contain information of genome-wide APA. Thus, we developed the InPAS package for identifying APA from the conventional RNA-seq data.

The major procedures in InPAS workflow are as follows:

* Extract genome-wide 3’ UTR annotation from known genome annotation
* Set up a SQLite database for storing experimental metadata and tracking intermediate files generated during analysis
* Convert genome-wide read coverage per sample from a BEDGraph file to a run-length encoding (Rle) format
* Identify putative cleavage and polyadenylation (CP) site for each gene based on the read coverage profile along 3’ UTR regions and optionally remove potential false positive CP sites due to technical artifacts by using the Naive Bayes classifier (NBC) model from the cleanUpdTseq package or by using the polyadenylation scores by matching the position-weight matrix (PWM) for the hexamer polyadenylation signal (AAUAAA and the like)
* Estimate usage of proximal and distal CP sites based on read coverage along the short and long 3’ UTRs
* Identify differential usage of proximal and distal CP sites between different conditions leveraging different statistical models according to the experimental design

In addition, the InPAS package also provide functions to perform quality control over RNA-seq data coverage, visualize differential usage of proximal and distal CP sites for genes of interest, and prepare essential files for gene set enrichment analysis (GSEA) to reveal biological insights from genes with alternative CP sites.

# 2 How to run InPAS

First, load the required packages, including InPAS, and species-specific genome and genome annotation database: BSgenome, TxDb and EnsDb.

```
logger <- file(tempfile(), open = "wt")
sink(logger, type="message")
suppressPackageStartupMessages({
library(InPAS)
library(BSgenome.Mmusculus.UCSC.mm10)
library(BSgenome.Hsapiens.UCSC.hg19)
library(TxDb.Mmusculus.UCSC.mm10.knownGene)
library(EnsDb.Hsapiens.v86)
library(EnsDb.Mmusculus.v79)
library(cleanUpdTSeq)
library(RSQLite)
library(future.apply)
})
```

## 2.1 Step 1: set up a SQLite database

Seven tables are created in the database. Table “metadata” stores the metadata, including information for tag (sample name), condition (experimental treatment group), bedgraph\_file (paths to BEDGraph files), and depth (whole genome coverage depth) which is initially set to zeros and later updated during analysis. Tables “sample\_coverage”, “chromosome\_coverage”, “total\_coverage”, “utr3\_total\_coverage”, “CPsites”, and “utr3cds\_coverage” store names of intermediate files and the chromosome and tag (sample name) relevant to the files.

```
plan(sequential)
data_dir <- system.file("extdata", package = "InPAS")
bedgraphs <- c(file.path(data_dir, "Baf3.extract.bedgraph"),
               file.path(data_dir, "UM15.extract.bedgraph"))
hugeData <- FALSE
genome <- BSgenome.Mmusculus.UCSC.mm10

tags <- c("Baf3", "UM15")
metadata <- data.frame(tag = tags,
                      condition = c("Baf3", "UM15"),
                      bedgraph_file = bedgraphs)

## In reality, don't use a temporary directory for your analysis. Instead, use a
## persistent directory to save your analysis output.
outdir = tempdir()
write.table(metadata, file = file.path(outdir =outdir, "metadata.txt"),
            sep = "\t", quote = FALSE, row.names = FALSE)

sqlite_db <- setup_sqlitedb(metadata = file.path(outdir = outdir,
                                                 "metadata.txt"),
                           outdir = outdir)

## check the database
db_conn <- dbConnect(drv = RSQLite::SQLite(), dbname = sqlite_db)
dbListTables(db_conn)
```

```
## [1] "CPsites"             "chromosome_coverage" "genome_anno"
## [4] "metadata"            "sample_coverage"     "total_coverage"
## [7] "utr3_total_coverage" "utr3cds_coverage"
```

```
dbReadTable(db_conn, "metadata")
```

```
##    tag condition
## 1 Baf3      Baf3
## 2 UM15      UM15
##                                                             bedgraph_file depth
## 1 /tmp/Rtmp1458yK/Rinst31a02d7128e02e/InPAS/extdata/Baf3.extract.bedgraph     0
## 2 /tmp/Rtmp1458yK/Rinst31a02d7128e02e/InPAS/extdata/UM15.extract.bedgraph     0
```

```
dbDisconnect(db_conn)
```

## 2.2 Step 2: Extracting 3’ UTR annotation

3’ UTR annotation, including start and end coordinates, and strand information of 3’ UTRs, last CDS and the gaps between 3’ extremities of 3’ UTRs and immediate downstream exons, is extracted using the function `extract_UTR3Anno` from genome annotation databases: a TxDb database and an Ensembldb database for a species of interest. For demonstration, the following snippet of R scripts shows how to extract 3’ UTR annotation from a abridged TxDb for a human reference genome (hg19). In reality, users should use a TxDb for the most reliable genome annotation of the PRIMARY reference genome assembly (NOT including the alternative patches) used for RNA-seq read alignment. If a TxDb is not available for the species of interest, users can build one using the function makeTxDbFromUCSC, makeTxDbFromBiomart, makeTxDbFromEnsembl, or makeTxDbFromGFF from the GenomicFeatures
package, depending on the sources of the genome annotation file.

```
samplefile <- system.file("extdata",
                          "hg19_knownGene_sample.sqlite",
            package="GenomicFeatures")
TxDb <- loadDb(samplefile)
seqnames <- seqnames(BSgenome.Hsapiens.UCSC.hg19)

# exclude mitochondrial genome and alternative haplotypes
chr2exclude <- c("chrM", "chrMT", seqnames[grepl("_(hap\\d+|fix|alt)$", seqnames, perl = TRUE)])

# set up global variables for InPAS analysis
set_globals(genome = BSgenome.Hsapiens.UCSC.hg19,
            TxDb = TxDb,
            EnsDb = EnsDb.Hsapiens.v86,
            outdir = tempdir(),
            chr2exclude = chr2exclude,
            lockfile = tempfile())
```

```
## Setting default genome to hg19.
```

```
## Setting default EnsDb to EnsDb.
```

```
## Setting default TxDb to TxDb.
```

```
utr3_anno <-
  extract_UTR3Anno(sqlite_db = sqlite_db,
                   TxDb = getInPASTxDb(),
                   edb = getInPASEnsDb(),
                   genome = getInPASGenome(),
                   outdir = getInPASOutputDirectory(),
                   chr2exclude = getChr2Exclude())
```

```
## Warning: Unable to map 3 of 42 requested IDs.
```

```
head(utr3_anno$chr1)
```

```
## GRanges object with 6 ranges and 8 metadata columns:
##                                              seqnames              ranges
##                                                 <Rle>           <IRanges>
##         chr1:lastutr3:uc001bum.2_5|IQCC|utr3     chr1   32673684-32674288
##       chr1:lastutr3:uc001fbq.3_3|S100A9|utr3     chr1 153333315-153333503
##   chr1:lastutr3:uc031pqa.1_13|100129405|utr3     chr1 155719929-155720673
##       chr1:lastutr3:uc001gde.2_2|LRRC52|utr3     chr1 165533062-165533185
##      chr1:lastutr3:uc001hfg.3_15|PFKFB2|utr3     chr1 207245717-207251162
##      chr1:lastutr3:uc001hfh.3_15|PFKFB2|utr3     chr1 207252365-207254368
##                                              strand | exon_rank  transcript
##                                               <Rle> | <integer> <character>
##         chr1:lastutr3:uc001bum.2_5|IQCC|utr3      + |         5  uc001bum.2
##       chr1:lastutr3:uc001fbq.3_3|S100A9|utr3      + |         3  uc001fbq.3
##   chr1:lastutr3:uc031pqa.1_13|100129405|utr3      + |        13  uc031pqa.1
##       chr1:lastutr3:uc001gde.2_2|LRRC52|utr3      + |         2  uc001gde.2
##      chr1:lastutr3:uc001hfg.3_15|PFKFB2|utr3      + |        15  uc001hfg.3
##      chr1:lastutr3:uc001hfh.3_15|PFKFB2|utr3      + |        15  uc001hfh.3
##                                                  feature        gene
##                                              <character> <character>
##         chr1:lastutr3:uc001bum.2_5|IQCC|utr3        utr3       55721
##       chr1:lastutr3:uc001fbq.3_3|S100A9|utr3        utr3        6280
##   chr1:lastutr3:uc031pqa.1_13|100129405|utr3        utr3   100129405
##       chr1:lastutr3:uc001gde.2_2|LRRC52|utr3        utr3      440699
##      chr1:lastutr3:uc001hfg.3_15|PFKFB2|utr3        utr3        5208
##      chr1:lastutr3:uc001hfh.3_15|PFKFB2|utr3        utr3        5208
##                                                                exon      symbol
##                                                         <character> <character>
##         chr1:lastutr3:uc001bum.2_5|IQCC|utr3 chr1:lastutr3:uc001b..        IQCC
##       chr1:lastutr3:uc001fbq.3_3|S100A9|utr3 chr1:lastutr3:uc001f..      S100A9
##   chr1:lastutr3:uc031pqa.1_13|100129405|utr3 chr1:lastutr3:uc031p..   100129405
##       chr1:lastutr3:uc001gde.2_2|LRRC52|utr3 chr1:lastutr3:uc001g..      LRRC52
##      chr1:lastutr3:uc001hfg.3_15|PFKFB2|utr3 chr1:lastutr3:uc001h..      PFKFB2
##      chr1:lastutr3:uc001hfh.3_15|PFKFB2|utr3 chr1:lastutr3:uc001h..      PFKFB2
##                                               annotatedProximalCP truncated
##                                                       <character> <logical>
##         chr1:lastutr3:uc001bum.2_5|IQCC|utr3              unknown     FALSE
##       chr1:lastutr3:uc001fbq.3_3|S100A9|utr3              unknown     FALSE
##   chr1:lastutr3:uc031pqa.1_13|100129405|utr3 proximalCP_155720479     FALSE
##       chr1:lastutr3:uc001gde.2_2|LRRC52|utr3              unknown     FALSE
##      chr1:lastutr3:uc001hfg.3_15|PFKFB2|utr3              unknown     FALSE
##      chr1:lastutr3:uc001hfh.3_15|PFKFB2|utr3              unknown     FALSE
##   -------
##   seqinfo: 83 sequences from an unspecified genome
```

This vignette will use the prepared 3’ UTR annotation for the mouse reference genome mm10 for subsequent demonstration

```
## set global variables for mouse InPAS analysis
set_globals(genome = BSgenome.Mmusculus.UCSC.mm10,
            TxDb = TxDb.Mmusculus.UCSC.mm10.knownGene,
            EnsDb = EnsDb.Mmusculus.v79,
            outdir = tempdir(),
            chr2exclude = "chrM",
            lockfile = tempfile())
```

```
## Setting default genome to mm10.
```

```
## Setting default EnsDb to EnsDb.
```

```
## Setting default TxDb to TxDb.
```

```
tx <- parse_TxDb(sqlite_db = sqlite_db,
                 TxDb = getInPASTxDb(),
                 edb = getInPASEnsDb(),
                 genome = getInPASGenome(),
                 outdir = getInPASOutputDirectory(),
                 chr2exclude = getChr2Exclude())
```

```
## Warning: Unable to map 6032 of 24594 requested IDs.
```

```
# load R object: utr3.mm10
data(utr3.mm10)

## convert the GRanges into GRangesList for the 3' UTR annotation
utr3.mm10 <- split(utr3.mm10, seqnames(utr3.mm10),
                   drop = TRUE)
```

## 2.3 Step 3: reformatting coverage data

Before this step, genome coverage in the BEDGraph format should be prepared from BAM files resulted from RNA-seq data alignment using the `genomecov` command in the BEDTools suite. BAM files can be filtered to remove multi-mapping alignments, alignments with low mapping quality and so on. Commands for reference are as follows:

```
## for single end RNA-seq data aligned with STAR
## -q 255, unique mapping
samtools view -bu -h -q 255 /path/to/XXX.SE.bam | \
    bedtools genomecov -ibam  - -bga -split  > XXX.SE.uniq.bedgraph

## for paired-end RNA-seq data aligned with STAR
samtools view -bu -h -q 255 /path/to/XXX.PE.bam | \
    bedtools genomecov -ibam  - -bga -split  > XXX.PE.uniq.bedgraph
```

The genome coverage data in the BEDGraph formatis converted into R objects of Rle-class using the `get_ssRleCov` function for each chromosome of each sample. Rle objects for each individual chromosome are save to `outdir`. The filename, tag (sample name), and chromosome name are save to Table “sample\_coverage”. Subsequently, chromosome-specific Rle objects for all samples are assemble together into a two-level list of Rle objects, with level 1 being the chromosome name and level 2 being Rle for each tag (sample name). Notably, the sample BEDGraph files used here only contain coverage data for “chr6” of the mouse reference genome mm10.

```
coverage <- list()
for (i in seq_along(bedgraphs)){
coverage[[tags[i]]] <- get_ssRleCov(bedgraph = bedgraphs[i],
                                    tag = tags[i],
                                    genome = genome,
                                    sqlite_db = sqlite_db,
                                    outdir = outdir,
                                    chr2exclude = getChr2Exclude())
}
coverage <- assemble_allCov(sqlite_db,
                            seqname = "chr6",
                            outdir,
                            genome = getInPASGenome())
```

At this point, users can check the data quality in terms of coverage for all and expressed genes and 3’ UTRs using `run_coverageQC`. This function output summarized coverage metrics: gene.coverage.rate, expressed.gene.coverage.rate, UTR3.coverage.rate, and UTR3.expressed.gene.subset.coverage.rate. The coverage rate of quality data should be greater than 0.75 for 3’ UTRs of expressed genes.

```
if (.Platform$OS.type == "windows")
{
  plan(multisession)
} else {
  plan(multicore)
}
run_coverageQC(sqlite_db,
               TxDb = getInPASTxDb(),
               edb = getInPASEnsDb(),
               genome = getInPASGenome(),
               chr2exclude = getChr2Exclude(),
               which = GRanges("chr6",
               ranges = IRanges(98013000, 140678000)))
```

```
## strand information will be ignored.
```

```
##      gene.coverage.rate expressed.gene.coverage.rate UTR3.coverage.rate
## Baf3        0.003463505                    0.5778441         0.01419771
## UM15        0.003428528                    0.5719748         0.01405159
##      UTR3.expressed.gene.subset.coverage.rate
## Baf3                                0.8035821
## UM15                                0.7953112
```

```
plan(sequential)
```

## 2.4 Step 4: Identifying potential CP sites

depth weight, Z-score cutoff thresholds, and total coverage along 3’ UTRs merged across biological replicates within each condition (huge data) or individual sample (non-huge data) are returned by the `setup_CPsSearch` function. Potential novel CP sites are identified for each chromosome using the `search_CPs` function. These potential CP sites can be filtered and/or adjusted using the Naive Bayes classifier provided by *cleanUpdTseq* and/or by using the polyadenylation scores by simply matching the position-weight matrix (PWM) for the hexamer polyadenylation signal (AAUAAA and the like).

```
## load the Naive Bayes classifier model for classify CP sites from the
## cleanUpdTseq package
data(classifier)

prepared_data <- setup_CPsSearch(sqlite_db,
                                 genome = getInPASGenome(),
                                 chr.utr3 = utr3.mm10$chr6,
                                 seqname = "chr6",
                                 background = "10K",
                                 TxDb = getInPASTxDb(),
                                 hugeData = TRUE,
                                 outdir = outdir,
                                 silence = TRUE,
                                 coverage_threshold = 5)

CPsites <- search_CPs(seqname = "chr6",
                       sqlite_db = sqlite_db,
                       genome = getInPASGenome(),
                       MINSIZE = 10,
                       window_size = 100,
                       search_point_START = 50,
                       search_point_END = NA,
                       cutEnd = 0,
                       filter.last = TRUE,
                       adjust_distal_polyA_end = TRUE,
                       long_coverage_threshold = 2,
                       PolyA_PWM = NA,
                       classifier = classifier,
                       classifier_cutoff = 0.8,
                       shift_range = 50,
                       step = 5,
                       outdir = outdir,
                       silence = TRUE)
```

```
## No readable configuration file found
```

```
## Created registry in '/tmp/RtmpTMkNDh/006.CPsites.out_chr6' using cluster functions 'Interactive'
```

```
## Adding 1 jobs ...
```

```
## Submitting 1 jobs in 1 chunks using cluster functions 'Interactive' ...
```

## 2.5 Step 5: Estimate usage of proximal and distal CP sites

Estimate usage of proximal and distal CP sites based on read coverage along the short and long 3’ UTRs

```
utr3_cds_cov <- get_regionCov(chr.utr3 = utr3.mm10[["chr6"]],
                              sqlite_db,
                              outdir,
                              phmm = FALSE)

eSet <- get_UTR3eSet(sqlite_db,
                     normalize ="none",
                     singleSample = FALSE)
```

## 2.6 Step 6. identifying differential PDUI events

InPAS provides the function `test_dPDUI` to identify differential usage of proximal and distal CP sites between different conditions leveraging different statistical models according to the experimental design. InPAS offers statistical methods for single sample differential PDUI analysis, and single group analysis. Additionally, InPAS provides Fisher exact test for two-group unreplicated design, and empirical Bayes linear model leveraging the limma package for more complex design. The test results can be further filtered using the `filter_testOut` function based on the fraction samples within each condition with coverage data for the identified differential PDUI events, and/or cutoffs of nominal p-values, adjusted p-values or log2 (fold change).

```
test_out <- test_dPDUI(eset = eSet,
                       method = "fisher.exact",
                       normalize = "none",
                       sqlite_db = sqlite_db)
```

```
filter_out <- filter_testOut(res = test_out,
                             gp1 = "Baf3",
                             gp2 = "UM15",
                             background_coverage_threshold = 2,
                             P.Value_cutoff = 0.05,
                             adj.P.Val_cutoff = 0.05,
                             dPDUI_cutoff = 0.3,
                             PDUI_logFC_cutoff = 0.59)
```

## 2.7 Step 7. Visualizing dPDUI events and preparing files for GSEA

InPAS package also provide functions, `get_usage4plot`, `plot_utr3Usage`, and `setup_GSEA`, to visualize differential usage of proximal and distal CP sites for genes of interest, and prepare essential files for gene set enrichment analysis (GSEA) to reveal biological insights from genes with alternative CP sites.

```
## Visualize dPDUI events
gr <- GRanges("chr6", IRanges(128846245, 128850081), strand = "-")
names(gr) <- "128846245-128850081"
data4plot <- get_usage4plot(gr,
                            proximalSites = 128849130,
                            sqlite_db,
                            hugeData = TRUE)

plot_utr3Usage(usage_data = data4plot,
               vline_color = "purple",
               vline_type = "dashed")
```

![](data:image/png;base64...)

```
## prepare a rank file for GSEA
setup_GSEA(eset = test_out,
           groupList= list(Baf3 = "Baf3", UM15 ="UM15"),
           outdir = outdir,
           preranked = TRUE,
           rankBy = "logFC",
           rnkFilename = "InPAS.rnk")
```

# 3 Session Info

```
sessionInfo()
```

R version 4.5.2 (2025-10-31)
Platform: x86\_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86\_64-linux-gnu/lapack/liblapack.so.3.12.0 LAPACK version 3.12.0

locale:
[1] LC\_CTYPE=en\_US.UTF-8 LC\_NUMERIC=C
[3] LC\_TIME=en\_GB LC\_COLLATE=C
[5] LC\_MONETARY=en\_US.UTF-8 LC\_MESSAGES=en\_US.UTF-8
[7] LC\_PAPER=en\_US.UTF-8 LC\_NAME=C
[9] LC\_ADDRESS=C LC\_TELEPHONE=C
[11] LC\_MEASUREMENT=en\_US.UTF-8 LC\_IDENTIFICATION=C

time zone: America/New\_York
tzcode source: system (glibc)

attached base packages:
[1] stats4 stats graphics grDevices utils datasets methods
[8] base

other attached packages:
[1] future.apply\_1.20.0
[2] future\_1.68.0
[3] RSQLite\_2.4.4
[4] cleanUpdTSeq\_1.48.0
[5] BSgenome.Drerio.UCSC.danRer7\_1.4.0
[6] EnsDb.Mmusculus.v79\_2.99.0
[7] EnsDb.Hsapiens.v86\_2.99.0
[8] ensembldb\_2.34.0
[9] AnnotationFilter\_1.34.0
[10] TxDb.Mmusculus.UCSC.mm10.knownGene\_3.10.0
[11] GenomicFeatures\_1.62.0
[12] AnnotationDbi\_1.72.0
[13] Biobase\_2.70.0
[14] BSgenome.Hsapiens.UCSC.hg19\_1.4.3
[15] BSgenome.Mmusculus.UCSC.mm10\_1.4.3
[16] BSgenome\_1.78.0
[17] rtracklayer\_1.70.0
[18] BiocIO\_1.20.0
[19] Biostrings\_2.78.0
[20] XVector\_0.50.0
[21] GenomicRanges\_1.62.0
[22] Seqinfo\_1.0.0
[23] IRanges\_2.44.0
[24] S4Vectors\_0.48.0
[25] BiocGenerics\_0.56.0
[26] generics\_0.1.4
[27] InPAS\_2.18.1
[28] BiocStyle\_2.38.0

loaded via a namespace (and not attached):
[1] RColorBrewer\_1.1-3 jsonlite\_2.0.0
[3] magrittr\_2.0.4 magick\_2.9.0
[5] farver\_2.1.2 rmarkdown\_2.30
[7] fs\_1.6.6 vctrs\_0.6.5
[9] memoise\_2.0.1 Rsamtools\_2.26.0
[11] RCurl\_1.98-1.17 tinytex\_0.58
[13] htmltools\_0.5.8.1 S4Arrays\_1.10.0
[15] progress\_1.2.3 curl\_7.0.0
[17] truncnorm\_1.0-9 SparseArray\_1.10.3
[19] sass\_0.4.10 parallelly\_1.45.1
[21] bslib\_0.9.0 plyr\_1.8.9
[23] cachem\_1.1.0 GenomicAlignments\_1.46.0
[25] lifecycle\_1.0.4 pkgconfig\_2.0.3
[27] Matrix\_1.7-4 R6\_2.6.1
[29] fastmap\_1.2.0 MatrixGenerics\_1.22.0
[31] digest\_0.6.39 numDeriv\_2016.8-1.1
[33] base64url\_1.4 labeling\_0.4.3
[35] httr\_1.4.7 abind\_1.4-8
[37] compiler\_4.5.2 proxy\_0.4-27
[39] bit64\_4.6.0-1 withr\_3.0.2
[41] brew\_1.0-10 S7\_0.2.1
[43] backports\_1.5.0 BiocParallel\_1.44.0
[45] DBI\_1.2.3 MASS\_7.3-65
[47] depmixS4\_1.5-1 rappdirs\_0.3.3
[49] DelayedArray\_0.36.0 rjson\_0.2.23
[51] tools\_4.5.2 nnet\_7.3-20
[53] glue\_1.8.0 debugme\_1.2.0
[55] restfulr\_0.0.16 nlme\_3.1-168
[57] grid\_4.5.2 checkmate\_2.3.3
[59] reshape2\_1.4.5 ade4\_1.7-23
[61] seqinr\_4.2-36 gtable\_0.3.6
[63] tzdb\_0.5.0 flock\_0.7
[65] class\_7.3-23 preprocessCore\_1.72.0
[67] data.table\_1.17.8 hms\_1.1.4
[69] pillar\_1.11.1 stringr\_1.6.0
[71] vroom\_1.6.6 limma\_3.66.0
[73] batchtools\_0.9.18 dplyr\_1.1.4
[75] lattice\_0.22-7 bit\_4.6.0
[77] tidyselect\_1.2.1 knitr\_1.50
[79] bookdown\_0.45 ProtGenerics\_1.42.0
[81] SummarizedExperiment\_1.40.0 xfun\_0.54
[83] statmod\_1.5.1 matrixStats\_1.5.0
[85] Rsolnp\_2.0.1 stringi\_1.8.7
[87] UCSC.utils\_1.6.0 lazyeval\_0.2.2
[89] yaml\_2.3.10 evaluate\_1.0.5
[91] codetools\_0.2-20 cigarillo\_1.0.0
[93] archive\_1.1.12 tibble\_3.3.0
[95] BiocManager\_1.30.27 cli\_3.6.5
[97] jquerylib\_0.1.4 dichromat\_2.0-0.1
[99] Rcpp\_1.1.0 GenomeInfoDb\_1.46.0
[101] globals\_0.18.0 png\_0.1-8
[103] XML\_3.99-0.20 parallel\_4.5.2
[105] ggplot2\_4.0.1 readr\_2.1.6
[107] blob\_1.2.4 prettyunits\_1.2.0
[109] plyranges\_1.30.1 bitops\_1.0-9
[111] listenv\_0.10.0 scales\_1.4.0
[113] e1071\_1.7-16 crayon\_1.5.3
[115] rlang\_1.1.6 KEGGREST\_1.50.0

```
sink(type="message")
close(logger)
```

1. Sheppard, S., Lawson, N. D. & Zhu, L. J. Accurate identification of polyadenylation sites from 3′ end deep sequencing using a naive bayes classifier. *Bioinformatics* **29,** 2564–2571 (2013).