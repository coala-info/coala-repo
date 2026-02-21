# Get barcode from 10X Genomics scRNASeq data

Wenjie Sun

#### 29 October 2025

#### Package

CellBarcode 1.16.0

```
library(data.table)
library(ggplot2)
library(CellBarcode)
```

# 1 Process single cell sequencing data

The **CellBarcode** package is able to extract barcode sequence from single cell sequencing data.

The **Bam**, **Sam** and **Fastq** format files are supported.
The **Bam** and **Sam** files should be the output of the 10X Genomics CellRanger pipeline.
The **Fastq** files are the raw sequencing data.
The vignette will show how to extract barcode from the **Bam/Sam** files.

For more examples, please check the **Supplementary Vignette 2** in following link: [https://static-content.springer.com/esm/art%3A10.1038%2Fs43588-024-00595-7/MediaObjects/43588\_2024\_595\_MOESM1\_ESM.pdf](https://static-content.springer.com/esm/art%3A10.1038/s43588-024-00595-7/MediaObjects/43588_2024_595_MOESM1_ESM.pdf)

# 2 Preprocess of CellRanger output bam file

**The the information in the bam file**. There are RNA sequence, Cell barcode and UMI in the bam file. We need to get the barcode in the RNA sequence together with the Cell barcode
and UMI.

**Where to find the bam file**. Usually, the bam file in in following location of the CellRanger output.

`CellRanger Output fold/outs/possorted_genome_bam.bam`

**Why preprocess**. We need get the sam file as input. And in some cases we can do some filtering to make the input file smaller, for reducing the running time.

**Example 1 get the sam file**

```
samtools view possorted_genome_bam.bam > scRNASeq_10X.sam
```

**Example 2 get the sam file only contain un mapped reads**

In most of the time, the barcodes are designed not overlap with the genome sequence, so those barcodes sequences are not mapped to the reference genome. Add a simple parameter, we can get the un-mapped reads to significantly reduce the running time of the barcode extraction procedure. In the following example, the `scRNASeq_10X.sam` file only contains the un-mapped reads.

```
samtools view -f 4 possorted_genome_bam.bam > scRNASeq_10X.sam
```

# 3 Extract lineage barcode

Extract lineage barcode with cell-barcode, UMI information.

The parameters:

* sam: The location of sam format file derived from CellRanger output bam file.
* pattern: A regular expression, that matchs the lineage barcode. The first capture will be extract as lineage barcode. Please check next section to know more about how to define a pattern.
* cell\_barcode\_tag: The cell barcode field tag in the sam file, the default is “CR” in the Cell Ranger output. You do not need to modify it, unless you know what you are doing.
* umi\_tag: The UMI field tag in the sam file, the default is “UR” in the Cell Ranger output. You do not need to modify it, unless you know what you are doing.

```
sam_file <- system.file("extdata", "scRNASeq_10X.sam", package = "CellBarcode")

d = bc_extract_sc_sam(
   sam = sam_file,
   pattern = "AGATCAG(.*)TGTGGTA",
   cell_barcode_tag = "CR",
   umi_tag = "UR"
)

d
#> Bonjour le monde, This is a BarcodeObj.
#> ----------
#> It contains:
#> ----------
#> @metadata: 2 field(s) available:
#> raw_read_count  barcode_read_count
#> ----------
#> @messyBc: 49 sample(s) for raw barcodes:
#>     In sample $AAACGAAAGTTCATGC there are: 1 Tags
#>     In sample $AAACGCTAGCTGACCC there are: 1 Tags
#>     In sample $AAAGGATAGTGTGTTC there are: 1 Tags
#>     In sample $AAAGGGCAGCCTGAGA there are: 1 Tags
#>     In sample $AAAGGTAAGGCCCACT there are: 1 Tags
#>     In sample $AAAGTCCCACTGCGAC there are: 1 Tags
#>     In sample $AAAGTGATCTGACGCG there are: 1 Tags
#>     In sample $AACACACCAATCCAGT there are: 1 Tags
#>     In sample $AACACACTCACCGACG there are: 1 Tags
#>     In sample $AACCCAAGGTAATTTA there are: 1 Tags
#>     In sample $AACCTTTGTCATTCCC there are: 1 Tags
#>     In sample $AACGAAATCTGGGTCG there are: 1 Tags
#>     In sample $AACTTCTGTGTTCCTC there are: 1 Tags
#>     In sample $AAGACAAAGCTAAATG there are: 1 Tags
#>     In sample $AAGACAAAGGCGCTTC there are: 1 Tags
#>     In sample $AAGCAGTGGTATCAAC there are: 8 Tags
#>     In sample $AAGGAGCTGACAGGTG there are: 1 Tags
#>     In sample $AAGTCGTAGCACGGAT there are: 1 Tags
#>     In sample $AAGTGAAAGTCCCGGT there are: 1 Tags
#>     In sample $AAGTTCGAGAGGTATT there are: 1 Tags
#>     In sample $AATAGAGGTTCTAACG there are: 1 Tags
#>     In sample $AATCGACTCATCGCTC there are: 1 Tags
#>     In sample $ACAAAGAGTAGGTCAG there are: 1 Tags
#>     In sample $ACAACCATCACGGAGA there are: 1 Tags
#>     In sample $ACATGGGGTAAAAGGA there are: 1 Tags
#>     In sample $AGCAGTGGTATCAACG there are: 1 Tags
#>     In sample $AGGCATTAAAGCAGCG there are: 1 Tags
#>     In sample $AGGCCTCACATTCTTC there are: 1 Tags
#>     In sample $AGTCTTTCGTCAAACA there are: 1 Tags
#>     In sample $CAAATTTTGTAATCCA there are: 1 Tags
#>     In sample $CACAAATTTTGTAATC there are: 1 Tags
#>     In sample $CACAACTCCTCATAAA there are: 1 Tags
#>     In sample $CAGTGGTATCAACGCA there are: 1 Tags
#>     In sample $CCTTGTGAGTGTTACC there are: 1 Tags
#>     In sample $CTACGGGAAGCAATAG there are: 1 Tags
#>     In sample $GATACAAAGGCATTAA there are: 1 Tags
#>     In sample $GCAGTGGTATCAACGC there are: 2 Tags
#>     In sample $GGAAGCAATAGCATGA there are: 1 Tags
#>     In sample $GTGGTATCAACGCAGA there are: 2 Tags
#>     In sample $GTTAAGAATACCAGTC there are: 1 Tags
#>     In sample $TAAGCCAAAAGAACAA there are: 1 Tags
#>     In sample $TAAGCCATAAACATAT there are: 1 Tags
#>     In sample $TGAAAGTGACAACTGA there are: 1 Tags
#>     In sample $TTCACCGATTTTGTAA there are: 2 Tags
#>     In sample $TTCCAAATTTTGTAAT there are: 1 Tags
#>     In sample $TTCCTCTCAGAATTGG there are: 1 Tags
#>     In sample $TTCGCTGATTTTGTAA there are: 1 Tags
#>     In sample $TTCTTCACAGAATTGG there are: 1 Tags
#>     In sample $TTGGGCGTCTTTGGGC there are: 1 Tags
```

The output is a `data.frame`. It contains 3 columns:

* cell\_barcode: It is unique identificaiton for each cell. One `cell_barcode` corresponding to a cell.
* umi: It is used to label the molecular before PCR, a unique UMI means one molecular.
* barcode\_seq: Depends on the experiment design, it usually labels the lineage.
* count: The reads number of a specifc cell-barcode, UMI, lineage barcode combination.

# 4 More about the `pattern`

The `pattern` is a regular expression, it tells the function where
to find the barcode. In the pattern, we define the barcode backbone, and label the barcode sequence by bracket `()`.

For example, the pattern `ATCG(.{21})TCGG` tells the barcode is surrounded by constant sequence of `ATCG`, and `TCGG`. Following are some examples to define the constant region and barcode sequence.

**Example 1**

`ATCG(.{21})`

21 bases barcode after a constant sequence of “ATCG”.

**Example 2**

`(.{15})TCGA`

15 bases barcode before a constant sequence of “TCGA”.

**Example 3**

`ATCG(.*)TCGA`

A flexible length barcode between constant regions of “ATCG” and “TCGA”.

**Need more helps**: About more complex barcode pattern, please ask the package author, then the exmaple will be apear here.

# 5 Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] CellBarcode_1.16.0 ggplot2_4.0.0      data.table_1.17.8  BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
#>  [3] xfun_0.53                   bslib_0.9.0
#>  [5] hwriter_1.3.2.1             latticeExtra_0.6-31
#>  [7] Biobase_2.70.0              lattice_0.22-7
#>  [9] Rdpack_2.6.4                vctrs_0.6.5
#> [11] tools_4.5.1                 bitops_1.0-9
#> [13] generics_0.1.4              stats4_4.5.1
#> [15] parallel_4.5.1              tibble_3.3.0
#> [17] pkgconfig_2.0.3             Matrix_1.7-4
#> [19] RColorBrewer_1.1-3          S7_0.2.0
#> [21] S4Vectors_0.48.0            cigarillo_1.0.0
#> [23] lifecycle_1.0.4             stringr_1.5.2
#> [25] compiler_4.5.1              farver_2.1.2
#> [27] deldir_2.0-4                egg_0.4.5
#> [29] Rsamtools_2.26.0            Biostrings_2.78.0
#> [31] Ckmeans.1d.dp_4.3.5         Seqinfo_1.0.0
#> [33] codetools_0.2-20            htmltools_0.5.8.1
#> [35] sass_0.4.10                 yaml_2.3.10
#> [37] pillar_1.11.1               crayon_1.5.3
#> [39] jquerylib_0.1.4             BiocParallel_1.44.0
#> [41] DelayedArray_0.36.0         cachem_1.1.0
#> [43] ShortRead_1.68.0            abind_1.4-8
#> [45] tidyselect_1.2.1            digest_0.6.37
#> [47] stringi_1.8.7               dplyr_1.1.4
#> [49] bookdown_0.45               fastmap_1.2.0
#> [51] grid_4.5.1                  cli_3.6.5
#> [53] SparseArray_1.10.0          magrittr_2.0.4
#> [55] S4Arrays_1.10.0             dichromat_2.0-0.1
#> [57] withr_3.0.2                 scales_1.4.0
#> [59] rmarkdown_2.30              pwalign_1.6.0
#> [61] XVector_0.50.0              matrixStats_1.5.0
#> [63] jpeg_0.1-11                 interp_1.1-6
#> [65] gridExtra_2.3               png_0.1-8
#> [67] evaluate_1.0.5              knitr_1.50
#> [69] rbibutils_2.3               GenomicRanges_1.62.0
#> [71] IRanges_2.44.0              rlang_1.1.6
#> [73] Rcpp_1.1.0                  glue_1.8.0
#> [75] BiocManager_1.30.26         BiocGenerics_0.56.0
#> [77] jsonlite_2.0.0              plyr_1.8.9
#> [79] R6_2.6.1                    MatrixGenerics_1.22.0
#> [81] GenomicAlignments_1.46.0
```