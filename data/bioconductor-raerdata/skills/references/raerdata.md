# raerdata: datasets and databases for use with the raer package

Kent Riemondy1

1University of Colorado School of Medicine

#### 2025-11-04

#### Package

raerdata 1.8.0

# Contents

* [0.1 Introduction](#introduction)
* [0.2 Installation](#installation)
* [0.3 RNA editing Atlases](#rna-editing-atlases)
  + [0.3.1 REDIportal](#rediportal)
  + [0.3.2 CDS recoding sites](#cds-recoding-sites)
* [0.4 Datasets](#datasets)
  + [0.4.1 Whole genome and RNA sequencing data from NA12878 cell line](#whole-genome-and-rna-sequencing-data-from-na12878-cell-line)
  + [0.4.2 GSE99249: RNA-Seq of Interferon beta treatment of ADAR1KO cell line](#gse99249-rna-seq-of-interferon-beta-treatment-of-adar1ko-cell-line)
  + [0.4.3 10x Genomics 10k PBMC scRNA-seq](#x-genomics-10k-pbmc-scrna-seq)
* [0.5 ExperimentHub access](#experimenthub-access)

## 0.1 Introduction

The `raerdata` package contains datasets and databases used to illustrate
functionality to characterize RNA editing using the `raer` package. Included in
the package are databases of known human and mouse RNA editing sites. Datasets
have been preprocessed to generate smaller examples suitable for quick
exploration of the data and demonstration of the `raer` package.

## 0.2 Installation

```
if (!require("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

# The following initializes usage of Bioc devel
BiocManager::install(version = "devel")

BiocManager::install("raerdata")
```

```
library(raerdata)
```

## 0.3 RNA editing Atlases

Atlases of known human and mouse A-to-I RNA editing sites formatted into
`GRanges` objects are provided.

### 0.3.1 REDIportal

The `REDIportal` is a collection of RNA editing sites identified from multiple
studies in multiple species (Picardi et al. ([2017](#ref-Picardi2017-gn))). The human (`hg38`) and
mouse (`mm10`) collections are provided in GRanges objects, in either
coordinate only format, or with additional metadata.

```
rediportal_coords_hg38()
```

```
## GRanges object with 15638648 ranges and 0 metadata columns:
##              seqnames    ranges strand
##                 <Rle> <IRanges>  <Rle>
##          [1]     chr1     87158      -
##          [2]     chr1     87168      -
##          [3]     chr1     87171      -
##          [4]     chr1     87189      -
##          [5]     chr1     87218      -
##          ...      ...       ...    ...
##   [15638644]     chrY  56885715      +
##   [15638645]     chrY  56885716      +
##   [15638646]     chrY  56885728      +
##   [15638647]     chrY  56885841      +
##   [15638648]     chrY  56885850      +
##   -------
##   seqinfo: 44 sequences from hg38 genome; no seqlengths
```

### 0.3.2 CDS recoding sites

Human `CDS` recoding RNA editing sites identified by Gabay et al. ([2022](#ref-Gabay2022-gw)) were
formatted into `GRanges` objects. These sites were also lifted over to the
mouse genome (`mm10`).

```
cds_sites <- gabay_sites_hg38()
cds_sites[1:4, 1:4]
```

```
## GRanges object with 4 ranges and 4 metadata columns:
##       seqnames    ranges strand |    GeneName
##          <Rle> <IRanges>  <Rle> | <character>
##   [1]     chr1    999279      - |        HES4
##   [2]     chr1   1014084      + |       ISG15
##   [3]     chr1   1281229      + |      SCNN1D
##   [4]     chr1   1281248      + |      SCNN1D
##       RefseqAccession_1,ExonNum_1,NucleotideSubstitution_1,AminoAcidSubstitution_1;…;RefseqAccession_N,ExonNum_N,NucleotideSubstitution_N,AminoAcidSubstitution_N
##                                                                                                                                                       <character>
##   [1]                                                                                                                                      NM_001142467.1,exon3..
##   [2]                                                                                                                                      NM_005101.3,exon2,c...
##   [3]                                                                                                                                      NM_001130413.3,exon2..
##   [4]                                                                                                                                      NM_001130413.3,exon2..
##          Syn/NonSyn Diversifying/Restorative/Syn
##         <character>                  <character>
##   [1] nonsynonymous                           NA
##   [2] nonsynonymous                           NA
##   [3]    synonymous                           NA
##   [4] nonsynonymous                           NA
##   -------
##   seqinfo: 23 sequences from hg38 genome; no seqlengths
```

## 0.4 Datasets

### 0.4.1 Whole genome and RNA sequencing data from NA12878 cell line

WGS and RNA-seq BAM and associated files generated from a subset of
chromosome 4. Paths to files and related data objects are returned in a list.

```
NA12878()
```

```
## $bams
## BamFileList of length 2
## names(2): NA12878_RNASEQ NA12878_WGS
##
## $fasta
## [1] "/home/biocbuild/.cache/R/ExperimentHub/146dcf1cc8af79_8469"
##
## $snps
## GRanges object with 380175 ranges and 2 metadata columns:
##            seqnames    ranges strand |         name     score
##               <Rle> <IRanges>  <Rle> |  <character> <numeric>
##        [1]     chr4     10001      * | rs1581341342         0
##        [2]     chr4     10002      * | rs1581341346         0
##        [3]     chr4     10004      * | rs1581341351         0
##        [4]     chr4     10005      * | rs1581341354         0
##        [5]     chr4     10006      * | rs1209159313         0
##        ...      ...       ...    ... .          ...       ...
##   [380171]     chr4    999987      * | rs1577536513         0
##   [380172]     chr4    999989      * |  rs948695434         0
##   [380173]     chr4    999991      * | rs1044698628         0
##   [380174]     chr4    999996      * | rs1361920394         0
##   [380175]     chr4    999997      * |   rs59206677         0
##   -------
##   seqinfo: 711 sequences (1 circular) from hg38 genome
```

### 0.4.2 GSE99249: RNA-Seq of Interferon beta treatment of ADAR1KO cell line

RNA-seq BAM files from ADAR1KO and Wild-Type HEK293 cells and associated
reference files from chromosome 18 (Chung et al. ([2018](#ref-Chung2018-gh))).

```
GSE99249()
```

```
## $bams
## BamFileList of length 6
## names(6): SRR5564260 SRR5564261 SRR5564269 SRR5564270 SRR5564271 SRR5564277
##
## $fasta
## [1] "/home/biocbuild/.cache/R/ExperimentHub/146dcf71e6f599_8310"
##
## $sites
## GRanges object with 15638648 ranges and 0 metadata columns:
##              seqnames    ranges strand
##                 <Rle> <IRanges>  <Rle>
##          [1]     chr1     87158      -
##          [2]     chr1     87168      -
##          [3]     chr1     87171      -
##          [4]     chr1     87189      -
##          [5]     chr1     87218      -
##          ...      ...       ...    ...
##   [15638644]     chrY  56885715      +
##   [15638645]     chrY  56885716      +
##   [15638646]     chrY  56885728      +
##   [15638647]     chrY  56885841      +
##   [15638648]     chrY  56885850      +
##   -------
##   seqinfo: 44 sequences from hg38 genome; no seqlengths
```

### 0.4.3 10x Genomics 10k PBMC scRNA-seq

10x Genomics BAM file and RNA editing sites from chromosome 16 of human PBMC
scRNA-seq library. Also included is a SingleCellExperiment object containing
gene expression values, cluster annotations, cell-type annotations, and a UMAP
projection.

```
pbmc_10x()
```

```
## $bam
## class: BamFile
## path: /home/biocbuild/.cache/R/ExperimentHub/146dcf6f8cdd7c_8311
## index: /home/biocbuild/.cache/R/ExperimentHub/146dcf2bf92293_8312
## isOpen: FALSE
## yieldSize: NA
## obeyQname: FALSE
## asMates: FALSE
## qnamePrefixEnd: NA
## qnameSuffixStart: NA
##
## $sites
## GRanges object with 15638648 ranges and 0 metadata columns:
##              seqnames    ranges strand
##                 <Rle> <IRanges>  <Rle>
##          [1]     chr1     87158      -
##          [2]     chr1     87168      -
##          [3]     chr1     87171      -
##          [4]     chr1     87189      -
##          [5]     chr1     87218      -
##          ...      ...       ...    ...
##   [15638644]     chrY  56885715      +
##   [15638645]     chrY  56885716      +
##   [15638646]     chrY  56885728      +
##   [15638647]     chrY  56885841      +
##   [15638648]     chrY  56885850      +
##   -------
##   seqinfo: 44 sequences from hg38 genome; no seqlengths
##
## $sce
## class: SingleCellExperiment
## dim: 36601 500
## metadata(2): Samples mkrs
## assays(2): counts logcounts
## rownames(36601): MIR1302-2HG FAM138A ... AC007325.4 AC007325.2
## rowData names(3): ID Symbol Type
## colnames(500): TGTTTGTCAGTTAGGG-1 ATCTCTACAAGCTACT-1 ...
##   GGGCGTTTCAGGACGA-1 CTATAGGAGATTGTGA-1
## colData names(8): Sample Barcode ... r celltype
## reducedDimNames(2): PCA UMAP
## mainExpName: NULL
## altExpNames(0):
```

## 0.5 ExperimentHub access

Alternatively individual files can be accessed from the ExperimentHub directly

```
library(ExperimentHub)
eh <- ExperimentHub()
raerdata_files <- query(eh, "raerdata")
data.frame(
    id = raerdata_files$ah_id,
    title = raerdata_files$title,
    description = raerdata_files$description
)
```

Session info

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
##  [1] ExperimentHub_3.0.0               AnnotationHub_4.0.0
##  [3] BiocFileCache_3.0.0               dbplyr_2.5.1
##  [5] SingleCellExperiment_1.32.0       SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0                    MatrixGenerics_1.22.0
##  [9] matrixStats_1.5.0                 Rsamtools_2.26.0
## [11] BSgenome.Hsapiens.UCSC.hg38_1.4.5 BSgenome_1.78.0
## [13] BiocIO_1.20.0                     Biostrings_2.78.0
## [15] XVector_0.50.0                    GenomeInfoDb_1.46.0
## [17] rtracklayer_1.70.0                GenomicRanges_1.62.0
## [19] Seqinfo_1.0.0                     IRanges_2.44.0
## [21] S4Vectors_0.48.0                  BiocGenerics_0.56.0
## [23] generics_0.1.4                    raerdata_1.8.0
## [25] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1         dplyr_1.1.4              blob_1.2.4
##  [4] filelock_1.0.3           bitops_1.0-9             fastmap_1.2.0
##  [7] RCurl_1.98-1.17          GenomicAlignments_1.46.0 XML_3.99-0.19
## [10] digest_0.6.37            lifecycle_1.0.4          KEGGREST_1.50.0
## [13] RSQLite_2.4.3            magrittr_2.0.4           compiler_4.5.1
## [16] rlang_1.1.6              sass_0.4.10              tools_4.5.1
## [19] yaml_2.3.10              knitr_1.50               S4Arrays_1.10.0
## [22] bit_4.6.0                curl_7.0.0               DelayedArray_0.36.0
## [25] abind_1.4-8              BiocParallel_1.44.0      withr_3.0.2
## [28] purrr_1.1.0              grid_4.5.1               cli_3.6.5
## [31] rmarkdown_2.30           crayon_1.5.3             httr_1.4.7
## [34] rjson_0.2.23             DBI_1.2.3                cachem_1.1.0
## [37] parallel_4.5.1           AnnotationDbi_1.72.0     BiocManager_1.30.26
## [40] restfulr_0.0.16          vctrs_0.6.5              Matrix_1.7-4
## [43] jsonlite_2.0.0           bookdown_0.45            bit64_4.6.0-1
## [46] jquerylib_0.1.4          glue_1.8.0               codetools_0.2-20
## [49] BiocVersion_3.22.0       UCSC.utils_1.6.0         tibble_3.3.0
## [52] pillar_1.11.1            rappdirs_0.3.3           htmltools_0.5.8.1
## [55] R6_2.6.1                 httr2_1.2.1              evaluate_1.0.5
## [58] lattice_0.22-7           png_0.1-8                cigarillo_1.0.0
## [61] memoise_2.0.1            bslib_0.9.0              SparseArray_1.10.1
## [64] xfun_0.54                pkgconfig_2.0.3
```

Chung, Hachung, Jorg J A Calis, Xianfang Wu, Tony Sun, Yingpu Yu, Stephanie L Sarbanes, Viet Loan Dao Thi, et al. 2018. “Human ADAR1 Prevents Endogenous RNA from Triggering Translational Shutdown.” *Cell* 172 (4): 811–824.e14. <https://doi.org/10.1016/j.cell.2017.12.038>.

Gabay, Orshay, Yoav Shoshan, Eli Kopel, Udi Ben-Zvi, Tomer D Mann, Noam Bressler, Roni Cohen-Fultheim, et al. 2022. “Landscape of Adenosine-to-Inosine RNA Recoding Across Human Tissues.” *Nat. Commun.* 13 (1): 1184. <https://doi.org/10.1038/s41467-022-28841-4>.

Picardi, Ernesto, Anna Maria D’Erchia, Claudio Lo Giudice, and Graziano Pesole. 2017. “REDIportal: A Comprehensive Database of A-to-I RNA Editing Events in Humans.” *Nucleic Acids Res.* 45 (D1): D750–D757. <https://doi.org/10.1093/nar/gkw767>.