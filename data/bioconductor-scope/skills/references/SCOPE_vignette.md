# SCOPE: Single-cell Copy Number Estimation

#### Rujin Wang, Danyu Lin, Yuchao Jiang

#### 2025-10-30

* [1. Overview of analysis pipeline](#overview-of-analysis-pipeline)
  + [1.1 Introduction](#introduction)
  + [1.2 Bioinformatic pre-processing](#bioinformatic-pre-processing)
* [2. Pre-computation and Quality Control](#pre-computation-and-quality-control)
  + [2.1 Pre-preparation](#pre-preparation)
  + [2.2 Getting GC content and mappability](#getting-gc-content-and-mappability)
  + [2.3 Getting coverage](#getting-coverage)
  + [2.4 Quality control](#quality-control)
* [3. Running SCOPE](#running-scope)
  + [3.1 Gini coefficient](#gini-coefficient)
  + [3.2 Running SCOPE with negative control samples](#running-scope-with-negative-control-samples)
  + [3.3 Cross-sample segmentation by SCOPE](#cross-sample-segmentation-by-scope)
  + [3.4 Visualization](#visualization)
  + [Session information](#session-information)

# 1. Overview of analysis pipeline

## 1.1 Introduction

SCOPE is a statistical framework designed for calling copy number variants (CNVs) from whole-genome single-cell DNA sequencing read depths. The distinguishing features of SCOPE include:

1. Utilizes cell-specific Gini coefficients for quality controls and for identification of normal/diploid cells. In most single-cell cancer genomics studies, diploid cells are inevitably picked up from adjacent normal tissues for sequencing and can thus serve as normal controls for read depth normalization. However, not all platforms/experiments allow or adopt flow-sorting based techniques before scDNA-seq and thus cell ploidy and case-control labeling are not always readily available. Gini coefficient is able to index diploid cells out of the entire cell populations and serves as good proxies to identify cell outliers.
2. Employs an EM algorithm to model GC content bias, which accounts for the different copy number states along the genome. SCOPE is based on a Poisson latent factor model for cross-sample normalization, borrowing information both across regions and across samples to estimate the bias terms.
3. Incorporates multi-sample segmentation procedure to identify breakpoints that are shared across cells from the same genetic background

## 1.2 Bioinformatic pre-processing

We demonstrate here how the pre-processing bioinformatic pipeline works. The [Picard toolkit](https://broadinstitute.github.io/picard/) is open-source and free for all uses. The `split_script.py` python script is pre-stored in the package for demultiplexing.

There are two types of scDNA-seq data sources: public data from NCBI Sequence Read Archive and data from 10X Genomics. For the NCBI SRA data, start with the SRA files. Fastq-dump to obtain FASTQ files. Align FASTQ sequences to NCBI hg19 reference genome and convert to BAM files. For the 10X Genomic datasets, process from the original integrated BAM file. Error-corrected chromium cellular barcode information for each read is stored as CB tag fields. Only reads that contain CB tags and are in the list of barcode of interest are demultiplexed via a Python script. Sort, add read group, and dedup on aligned/demultiplexed BAMs. Use deduped BAM files as the input.

```
# public data from NCBI Sequence Read Archive
SRR=SRRXXXXXXX
kim=/pine/scr/r/u/rujin/Kim_Navin_et_al_Cell_2018
fastq_dir=$kim/fastq
align_dir=$kim/align

# Align FASTQ sequences to NCBI hg19 reference genome
# (Single-end sequenced cells have only 1 FASTQ file;
# paired-end sequencing would generate two FASTQ files,
# with suffix "_1" and "_2")
cd $fastq_dir
bwa mem -M -t 16 \
    ucsc.hg19.fasta `ls | grep "$SRR" | tr '\n' ' '` > $align_dir/"$SRR".sam

# Convert .sam to .bam
cd $align_dir
samtools view -bS "$SRR".sam > "$SRR".bam

# Sort
java -Xmx30G -jar /proj/yuchaojlab/bin/picard.jar SortSam \
    INPUT="$SRR".bam OUTPUT="$SRR".sorted.bam \
    SORT_ORDER=coordinate

# Add read group
java -Xmx40G -jar /proj/yuchaojlab/bin/picard.jar AddOrReplaceReadGroups \
    I="$SRR".sorted.bam O="$SRR".sorted.rg.bam RGID="$SRR" \
    RGLB=Chung_Et_Al RGPL=ILLUMINA RGPU=machine RGSM="$SRR"
samtools index "$SRR".sorted.rg.bam

# Dedup
java -Xmx40G -jar /proj/yuchaojlab/bin/picard.jar MarkDuplicates \
    REMOVE_DUPLICATES=true \
    I="$SRR".sorted.rg.bam O="$SRR".sorted.rg.dedup.bam \
    METRICS_FILE="$SRR".sorted.rg.dedup.metrics.txt \
    PROGRAM_RECORD_ID= MarkDuplicates PROGRAM_GROUP_VERSION=null \
    PROGRAM_GROUP_NAME=MarkDuplicates
java -jar /proj/yuchaojlab/bin/picard.jar BuildBamIndex \
    I="$SRR".sorted.rg.dedup.bam

# 10X Genomics
XGenomics=/pine/scr/r/u/rujin/10XGenomics
dataset=breast_tissue_A_2k
output_dir=$XGenomics/$dataset/output
align_dir=$XGenomics/$dataset/align

# Demultiplex
cd $output_dir
samtools view ${dataset}_possorted_bam.bam | python $XGenomics/split_script.py

# Add header to demultiplexed bam files for further processing
cd $XGenomics
samtools view -H $dataset/output/${dataset}_possorted_bam.bam > \
    $dataset/header.txt
barcode=AAAGATGGTGTAAAGT
cat header.txt $align_dir/$barcode/$barcode-1.sam > \
    $align_dir/$barcode/$barcode-1.header.sam

# Convert .sam to .bam
cd $align_dir/$barcode
samtools view -bS "$barcode"-1.header.sam > "$barcode".bam
```

# 2. Pre-computation and Quality Control

## 2.1 Pre-preparation

SCOPE enables reconstruction of user-defined genome-wide consecutive bins with fixed interval length prior to downstream analysis by specifying arguments `genome` and `resolution` in `get_bam_bed()` function. Make sure that all chromosomes are named consistently and be concordant with `.bam` files. SCOPE processes the entire genome altogether. Use function `get_bam_bed()` to finish the pre-preparation step. By default, SCOPE is designed for hg19 with fixed bin-length = 500kb.

```
library(SCOPE)
library(WGSmapp)
library(BSgenome.Hsapiens.UCSC.hg38)
bamfolder <- system.file("extdata", package = "WGSmapp")
bamFile <- list.files(bamfolder, pattern = '*.dedup.bam$')
bamdir <- file.path(bamfolder, bamFile)
sampname_raw <- sapply(strsplit(bamFile, ".", fixed = TRUE), "[", 1)
bambedObj <- get_bam_bed(bamdir = bamdir, sampname = sampname_raw,
                        hgref = "hg38")
ref_raw <- bambedObj$ref
```

## 2.2 Getting GC content and mappability

Compute GC content and mappability for each bin. By default, SCOPE is intended for hg19 reference genome. To compute mappability for hg19, we employed the 100-mers mappability track from the ENCODE Project (`wgEncodeCrgMapabilityAlign100mer.bigwig` from [link](http://rohsdb.cmb.usc.edu/GBshape/cgi-bin/hgFileUi?%20db=hg19&g=wgEncodeMapability)) and computed weighted average of the mappability scores if multiple ENCODE regions overlap with the same bin. For SCOPE, the whole-genome mappability track on human hg19 assembly is stored as part of the package.

The whole-genome mappability track on human hg38 assembly is also stored in SCOPE package. For more details on mappability calculation, please refer to [CODEX2 for hg38](https://github.com/yuchaojiang/CODEX2/blob/master/README.md). Load the hg38 reference package, specify argument `hgref = "hg38"` in `get_mapp()` and `get_gc()`. By default, `hg19` are used.

```
mapp <- get_mapp(ref_raw, hgref = "hg38")
head(mapp)
```

```
## [1] 0.1672858 0.5042187 0.9529839 0.9065575 0.9826570 0.9100177
```

```
gc <- get_gc(ref_raw, hgref = "hg38")
values(ref_raw) <- cbind(values(ref_raw), DataFrame(gc, mapp))
ref_raw
```

```
## GRanges object with 5760 ranges and 2 metadata columns:
##          seqnames            ranges strand |        gc      mapp
##             <Rle>         <IRanges>  <Rle> | <numeric> <numeric>
##      [1]     chr1          1-500000      * |     33.65  0.167286
##      [2]     chr1    500001-1000000      * |     43.05  0.504219
##      [3]     chr1   1000001-1500000      * |     60.50  0.952984
##      [4]     chr1   1500001-2000000      * |     54.07  0.906558
##      [5]     chr1   2000001-2500000      * |     58.55  0.982657
##      ...      ...               ...    ... .       ...       ...
##   [5756]    chr22 48500001-49000000      * |     52.49  0.977008
##   [5757]    chr22 49000001-49500000      * |     49.95  0.989798
##   [5758]    chr22 49500001-50000000      * |     52.93  0.987084
##   [5759]    chr22 50000001-50500000      * |     55.66  0.979818
##   [5760]    chr22 50500001-50818468      * |     50.55  0.856746
##   -------
##   seqinfo: 24 sequences from hg38 genome
```

Note that SCOPE can also be adapted to the mouse genome (mm10) in a similar way (see [CODEX2 for mouse genome](https://github.com/yuchaojiang/CODEX2/blob/master/README.md)). Specify argument `hgref = "mm10"` in `get_bam_bed()`, `get_mapp()`, `get_gc()` and `get_coverage_scDNA()`. Calculation of GC content and mappability needs to be modified from the default (hg19). For mm10, there are two workarounds: 1) set all mappability to 1 to avoid extensive computation; 2) adopt QC procedures based on annotation results, e.g., filter out bins within “blacklist” regions, which generally have low mappability. To be specific, we obtained and pre-stored mouse genome “blacklist” regions from [Amemiya et al., Scientific Reports, 2019](https://github.com/Boyle-Lab/Blacklist/tree/master/lists/mm10-blacklist.v2.bed.gz).

```
library(BSgenome.Mmusculus.UCSC.mm10)
mapp <- get_mapp(ref_raw, hgref = "mm10")
gc <- get_gc(ref_raw, hgref = "mm10")
```

For unknown reference assembly without pre-calculated mappability track, refer to [CODEX2: mappability pre-calculation](https://github.com/yuchaojiang/CODEX2/blob/master/mouse/mapp.R).

## 2.3 Getting coverage

Obtain either single-end or paired-end sequencing read depth matrix. SCOPE, by default, adopts a fixed binning method to compute the depth of coverage while removing reads that are mapped to multiple genomic locations and to “blacklist” regions. This is followed by an additional step of quality control to remove bins with extreme mappability to avoid erroneous detections. Specifically, the “blacklist” bins, including [segmental duplication regions](http://humanparalogy.%20gs.washington.edu/build37/data/GRCh37GenomicSuperDup.tab) and [gaps in reference assembly](https://gist.github.com/leipzig/6123703) from telomere, centromere, and/or heterochromatin regions.

```
# Getting raw read depth
coverageObj <- get_coverage_scDNA(bambedObj, mapqthres = 40,
                                seq = 'paired-end', hgref = "hg38")
```

```
## Getting coverage for sample 1: AAAGCAATCTGACGCG...
```

```
## Getting coverage for sample 2: CTCGTCACAGGTTAAA...
```

```
## Getting coverage for sample 3: GCAGTTACACTGTATG...
```

```
Y_raw <- coverageObj$Y
```

## 2.4 Quality control

`get_samp_QC()` is used to perform QC step on single cells, where total number/proportion of reads, total number/proportion of mapped reads, total number/proportion of mapped non-duplicate reads, and number/proportion of reads with mapping quality greater than 20 will be returned. Use `perform_qc()` to further remove samples/cells with low proportion of mapped reads, bins that have extreme GC content (less than 20% and greater than 80%) and low mappability (less than 0.9) to reduce artifacts.

```
QCmetric_raw <- get_samp_QC(bambedObj)
```

```
## Getting sample QC metric for sample 1
## Getting sample QC metric for sample 2
## Getting sample QC metric for sample 3
```

```
qcObj <- perform_qc(Y_raw = Y_raw,
    sampname_raw = sampname_raw, ref_raw = ref_raw,
    QCmetric_raw = QCmetric_raw)
```

```
## Removed 0 samples due to failed library preparation.
```

```
## Removed 0 samples due to failure to meet min coverage requirement.
```

```
## Removed 0 samples due to low proportion of mapped reads.
```

```
## Excluded 216 bins due to extreme GC content.
```

```
## Excluded 355 bins due to low mappability.
```

```
## Removed 0 samples due to excessive zero read counts in
##             library size calculation.
```

```
## There are 3 samples and 5029 bins after QC step.
```

```
Y <- qcObj$Y
sampname <- qcObj$sampname
ref <- qcObj$ref
QCmetric <- qcObj$QCmetric
```

# 3. Running SCOPE

## 3.1 Gini coefficient

One feature of SCOPE is to identify normal/diploid cells using Gini index. Gini coefficient is calculated for each cell as 2 times the area between the Lorenz curve and the diagonal. The value of the Gini index varies between 0 and 1, where 0 is the most uniform and 1 is the most extreme. Cells with extremely high Gini coefficients(greater than 0.5) are recommended to be excluded. Set up a Gini threshold for identification of diploid/normal cells (for example, Gini less than 0.12). We demonstrate the pre-stored toy dataset as follows.

```
# get gini coefficient for each cell
Gini <- get_gini(Y_sim)
```

## 3.2 Running SCOPE with negative control samples

Normal cell index is determined either by Gini coefficients or prior knowledge. SCOPE utilizes ploidy estimates from a first-pass normalization run to ensure fast convergence and to avoid local optima. Specify `SoS.plot = TRUE` in `initialize_ploidy()` to visualize ploidy pre-estimations. The normalization procedure includes an expectation-maximization algorithm in the Poisson generalized linear model. Note that, by setting `ploidyInt` in the normalization function, SCOPE allows users to exploit prior-knowledge ploidies as the input and to manually tune a few cells that have poor fitting.

```
# first-pass CODEX2 run with no latent factors
normObj.sim <- normalize_codex2_ns_noK(Y_qc = Y_sim,
                                        gc_qc = ref_sim$gc,
                                        norm_index = which(Gini<=0.12))
```

```
## Computing normalization with no latent factors
```

```
## Iteration 1  beta diff =0.00882  f(GC) diff =4.28e-07
```

```
## Iteration 2  beta diff =2.21e-06 f(GC) diff =9.35e-12
```

```
## Stop at Iteration 2.
```

```
# Ploidy initialization
ploidy.sim <- initialize_ploidy(Y = Y_sim, Yhat = normObj.sim$Yhat, ref = ref_sim)
```

```
## Initializing ploidy for cell  1
```

```
# If using high performance clusters, parallel computing is
# easy and improves computational efficiency. Simply use
# normalize_scope_foreach() instead of normalize_scope().
# All parameters are identical.
normObj.scope.sim <- normalize_scope_foreach(Y_qc = Y_sim, gc_qc = ref_sim$gc,
    K = 1, ploidyInt = ploidy.sim,
    norm_index = which(Gini<=0.12), T = 1:5,
    beta0 = normObj.sim$beta.hat, nCores = 2)
```

```
## Initialization ...
```

```
## 1    2   3   4   5
```

```
## Computing normalization with k = 1 latent factors ...
```

```
## k = 1
```

```
## Iteration 1  beta diff =3.43e-05 f(GC) diff =4.05e-07
```

```
##          hhat diff =0.43
```

```
##          hhat diff =9.83e-06
```

```
## Stop at Iteration 1.
```

```
## AIC1 = 50521100.706
```

```
## BIC1 = 50510332.725
```

```
## RSS1 = 2441.606
```

```
# normObj.scope.sim <- normalize_scope(Y_qc = Y_sim, gc_qc = ref_sim$gc,
#     K = 1, ploidyInt = ploidy.sim,
#     norm_index = which(Gini<=0.12), T = 1:5,
#     beta0 = beta.hat.noK.sim)
Yhat.sim <- normObj.scope.sim$Yhat[[which.max(normObj.scope.sim$BIC)]]
fGC.hat.sim <- normObj.scope.sim$fGC.hat[[which.max(normObj.scope.sim$BIC)]]
```

Visualize selection results for each individual cell. By default, BIC is used to choose optimal CNV group.

```
plot_EM_fit(Y_qc = Y_sim, gc_qc = ref_sim$gc, norm_index = which(Gini<=0.12),
            T = 1:5,
            ploidyInt = ploidy.sim, beta0 = normObj.sim$beta.hat,
            filename = "plot_EM_fit_demo.pdf")
```

Upon completion of SCOPE’s default normalization and segmentation, SCOPE includes the option to cluster cells based on the matrix of normalized z-scores, estimated copy numbers, or estimated changepoints. Given the inferred subclones, SCOPE can opt to perform a second round of group-wise ploidy initialization and normalization

```
# Group-wise ploidy initialization
clones <- c("normal", "tumor1", "normal", "tumor1", "tumor1")
ploidy.sim.group <- initialize_ploidy_group(Y = Y_sim, Yhat = Yhat.noK.sim,
                                ref = ref_sim, groups = clones)
ploidy.sim.group

# Group-wise normalization
normObj.scope.sim.group <- normalize_scope_group(Y_qc = Y_sim,
                                    gc_qc = ref_sim$gc,
                                    K = 1, ploidyInt = ploidy.sim.group,
                                    norm_index = which(clones=="normal"),
                                    groups = clones,
                                    T = 1:5,
                                    beta0 = beta.hat.noK.sim)
Yhat.sim.group <- normObj.scope.sim.group$Yhat[[which.max(
                                    normObj.scope.sim.group$BIC)]]
fGC.hat.sim.group <- normObj.scope.sim.group$fGC.hat[[which.max(
                                    normObj.scope.sim.group$BIC)]]
```

## 3.3 Cross-sample segmentation by SCOPE

SCOPE provides the cross-sample segmentation, which outputs shared breakpoints across cells from the same clone. This step processes the entire genome chromosome by chromosome. Shared breakpoints and integer copy-number profiles will be returned.

```
chrs <- unique(as.character(seqnames(ref_sim)))
segment_cs <- vector('list',length = length(chrs))
names(segment_cs) <- chrs
for (chri in chrs) {
    message('\n', chri, '\n')
    segment_cs[[chri]] <- segment_CBScs(Y = Y_sim,
                                    Yhat = Yhat.sim,
                                    sampname = colnames(Y_sim),
                                    ref = ref_sim,
                                    chr = chri,
                                    mode = "integer", max.ns = 1)
}
iCN_sim <- do.call(rbind, lapply(segment_cs, function(z){z[["iCN"]]}))
```

## 3.4 Visualization

SCOPE offers heatmap of inferred integer copy-number profiles with cells clustered by hierarchical clustering.

```
plot_iCN(iCNmat = iCN_sim, ref = ref_sim, Gini = Gini,
        filename = "plot_iCN_demo")
```

## Session information

```
sessionInfo()
```

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
##  [1] BSgenome.Hsapiens.UCSC.hg38_1.4.5 WGSmapp_1.21.0
##  [3] SCOPE_1.22.0                      BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [5] BSgenome_1.78.0                   rtracklayer_1.70.0
##  [7] BiocIO_1.20.0                     GenomeInfoDb_1.46.0
##  [9] Rsamtools_2.26.0                  Biostrings_2.78.0
## [11] XVector_0.50.0                    GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0                     IRanges_2.44.0
## [15] S4Vectors_0.48.0                  BiocGenerics_0.56.0
## [17] generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] Exact_3.3                   rootSolve_1.8.2.4
##  [3] bitops_1.0-9                fastmap_1.2.0
##  [5] RCurl_1.98-1.17             GenomicAlignments_1.46.0
##  [7] XML_3.99-0.19               digest_0.6.37
##  [9] lifecycle_1.0.4             lmom_3.2
## [11] magrittr_2.0.4              compiler_4.5.1
## [13] rlang_1.1.6                 sass_0.4.10
## [15] tools_4.5.1                 yaml_2.3.10
## [17] data.table_1.17.8           knitr_1.50
## [19] S4Arrays_1.10.0             curl_7.0.0
## [21] DelayedArray_0.36.0         RColorBrewer_1.1-3
## [23] KernSmooth_2.23-26          abind_1.4-8
## [25] BiocParallel_1.44.0         expm_1.0-0
## [27] withr_3.0.2                 grid_4.5.1
## [29] caTools_1.18.3              e1071_1.7-16
## [31] gtools_3.9.5                iterators_1.0.14
## [33] MASS_7.3-65                 SummarizedExperiment_1.40.0
## [35] cli_3.6.5                   mvtnorm_1.3-3
## [37] rmarkdown_2.30              crayon_1.5.3
## [39] rstudioapi_0.17.1           httr_1.4.7
## [41] tzdb_0.5.0                  rjson_0.2.23
## [43] readxl_1.4.5                gld_2.6.8
## [45] DNAcopy_1.84.0              cachem_1.1.0
## [47] proxy_0.4-27                parallel_4.5.1
## [49] cellranger_1.1.0            restfulr_0.0.16
## [51] matrixStats_1.5.0           vctrs_0.6.5
## [53] boot_1.3-32                 Matrix_1.7-4
## [55] jsonlite_2.0.0              hms_1.1.4
## [57] foreach_1.5.2               jquerylib_0.1.4
## [59] glue_1.8.0                  codetools_0.2-20
## [61] UCSC.utils_1.6.0            tibble_3.3.0
## [63] pillar_1.11.1               gplots_3.2.0
## [65] htmltools_0.5.8.1           R6_2.6.1
## [67] doParallel_1.0.17           evaluate_1.0.5
## [69] lattice_0.22-7              Biobase_2.70.0
## [71] haven_2.5.5                 readr_2.1.5
## [73] cigarillo_1.0.0             bslib_0.9.0
## [75] DescTools_0.99.60           class_7.3-23
## [77] Rcpp_1.1.0                  SparseArray_1.10.0
## [79] xfun_0.53                   fs_1.6.6
## [81] MatrixGenerics_1.22.0       forcats_1.0.1
## [83] pkgconfig_2.0.3
```