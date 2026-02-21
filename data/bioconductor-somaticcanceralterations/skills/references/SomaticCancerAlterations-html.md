# SomaticCancerAlterations

## Table of Contents

* [1. Motivation](#sec-1)
* [2. Data Sets](#sec-2)
* [3. Exploring Mutational Data](#sec-3)
* [4. Exploring Multiple Studies](#sec-4)
* [5. Data Provenance](#sec-5)
  + [5.1. TCGA Data](#sec-5-1)
    - [5.1.1. Processing](#sec-5-1-1)
    - [5.1.2. Selection Criteria of Data Sets](#sec-5-1-2)
    - [5.1.3. Consistency Check](#sec-5-1-3)
* [6. Alternatives](#sec-6)
* [7. Session Info](#sec-7)

## 1 Motivation

Over the last years, large efforts have been taken to characterize the somatic
landscape of cancers. Many of the conducted studies make their results publicly
available, providing a valuable resource for investigating beyond the level of
individual cohorts. The SomaticCancerAlterations package collects
mutational data of several tumor types, currently focusing on the TCGA calls
sets, and aims for a tight integration with and
workflows. In the following, we will illustrate how to access this data and give
examples for use cases.

```
## Loading required package: stats4
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: ggplot2
```

```
## Need specific help about ggbio? try mailing
##  the maintainer or visit https://lawremi.github.io/ggbio/
```

```
##
## Attaching package: 'ggbio'
```

```
## The following objects are masked from 'package:ggplot2':
##
##     geom_bar, geom_rect, geom_segment, ggsave, stat_bin, stat_identity,
##     xlim
```

## 2 Data Sets

The Cancer Genome Atlas (TCGA)[1](#fn.1) is a consortium effort
to analyze a variety of tumor types, including gene expression, methylation,
copy number changes, and somatic
mutations[2](#fn.2). With the
SomaticCancerAlterations package, we provide the callsets of somatic
mutations for all publically available TCGA studies. Over time, more studies
will be added, as they become available and unrestriced in their usage.

To get started, we get a list of all available data sets and access the metadata
associated with each study.

```
all_datasets = scaListDatasets()
print(all_datasets)
```

```
## [1] "gbm_tcga"  "hnsc_tcga" "kirc_tcga" "luad_tcga" "lusc_tcga" "ov_tcga"
## [7] "skcm_tcga" "thca_tcga"
```

```
meta_data = scaMetadata()
print(meta_data)
```

```
##           Cancer_Type       Center NCBI_Build Sequence_Source Sequencing_Phase
## gbm_tcga          GBM broad.mi....         37             WXS          Phase_I
## hnsc_tcga        HNSC broad.mi....         37         Capture          Phase_I
## kirc_tcga        KIRC broad.mi....         37         Capture          Phase_I
## luad_tcga        LUAD broad.mi....         37             WXS          Phase_I
## lusc_tcga        LUSC broad.mi....         37             WXS          Phase_I
## ov_tcga            OV broad.mi....         37             WXS          Phase_I
## skcm_tcga        SKCM broad.mi....         37         Capture          Phase_I
## thca_tcga        THCA broad.mi....         37             WXS          Phase_I
##              Sequencer Number_Samples Number_Patients
## gbm_tcga  Illumina....            291             291
## hnsc_tcga Illumina....            319             319
## kirc_tcga Illumina....            297             293
## luad_tcga Illumina....            538             519
## lusc_tcga Illumina....            178             178
## ov_tcga   Illumina....            142             142
## skcm_tcga Illumina....            266             264
## thca_tcga Illumina....            406             403
##                                     Cancer_Name
## gbm_tcga                Glioblastoma multiforme
## hnsc_tcga Head and Neck squamous cell carcinoma
## kirc_tcga                    Kidney Chromophobe
## luad_tcga                   Lung adenocarcinoma
## lusc_tcga          Lung squamous cell carcinoma
## ov_tcga       Ovarian serous cystadenocarcinoma
## skcm_tcga               Skin Cutaneous Melanoma
## thca_tcga                    Thyroid carcinoma
```

Next, we load a single dataset with the scaLoadDataset function.

```
ov = scaLoadDatasets("ov_tcga", merge = TRUE)
```

## 3 Exploring Mutational Data

The somatic variants of each study are represented as a object,
ordered by genomic positions. Additional columns describe properties of the
variant and relate it the the affected gene, sample, and patient.

```
head(ov, 3)
```

```
## GRanges object with 3 ranges and 14 metadata columns:
##           seqnames    ranges strand | Hugo_Symbol Entrez_Gene_Id
##              <Rle> <IRanges>  <Rle> |    <factor>      <integer>
##   ov_tcga        1   1334552      * |       CCNL2          81669
##   ov_tcga        1   1961652      * |       GABRD           2563
##   ov_tcga        1   2420688      * |       PLCH2           9651
##           Variant_Classification Variant_Type Reference_Allele
##                         <factor>     <factor>         <factor>
##   ov_tcga      Silent                     SNP                C
##   ov_tcga      Silent                     SNP                C
##   ov_tcga      Missense_Mutation          SNP                C
##           Tumor_Seq_Allele1 Tumor_Seq_Allele2 Verification_Status
##                    <factor>          <factor>            <factor>
##   ov_tcga                 C                 T             Unknown
##   ov_tcga                 C                 T             Unknown
##   ov_tcga                 C                 G             Unknown
##           Validation_Status Mutation_Status   Patient_ID
##                    <factor>        <factor>     <factor>
##   ov_tcga             Valid         Somatic TCGA-24-2262
##   ov_tcga             Valid         Somatic TCGA-24-1552
##   ov_tcga             Valid         Somatic TCGA-13-1484
##                              Sample_ID     index  Dataset
##                               <factor> <integer> <factor>
##   ov_tcga TCGA-24-2262-01A-01W-0799-08      3901  ov_tcga
##   ov_tcga TCGA-24-1552-01A-01W-0551-08      3414  ov_tcga
##   ov_tcga TCGA-13-1484-01A-01W-0545-08      1567  ov_tcga
##   -------
##   seqinfo: 86 sequences from an unspecified genome
```

```
with(mcols(ov), table(Variant_Classification, Variant_Type))
```

```
##                         Variant_Type
## Variant_Classification    DEL  INS  SNP
##   3'UTR                     0    0    3
##   5'Flank                   0    0    1
##   5'UTR                     0    0    1
##   Frame_Shift_Del          79    0    0
##   Frame_Shift_Ins           0   16    0
##   IGR                       0    0    5
##   In_Frame_Del             26    0    0
##   In_Frame_Ins              0    1    0
##   Intron                    0    0   34
##   Missense_Mutation         0    0 4299
##   Nonsense_Mutation         0    0  285
##   Nonstop_Mutation          0    0    6
##   RNA                       0    0    1
##   Silent                    0    0 1417
##   Splice_Site               9    2  121
##   Translation_Start_Site    1    0    1
```

With such data at hand, we can identify the samples and genes haboring the most
mutations.

```
head(sort(table(ov$Sample_ID), decreasing = TRUE))
```

```
##
## TCGA-09-2049-01D-01W-0799-08 TCGA-13-0923-01A-01W-0420-08
##                          119                          118
## TCGA-09-2050-01A-01W-0799-08 TCGA-25-1326-01A-01W-0492-08
##                          111                          110
## TCGA-25-1313-01A-01W-0492-08 TCGA-23-1110-01A-01D-0428-08
##                          104                          102
```

```
head(sort(table(ov$Hugo_Symbol), decreasing = TRUE), 10)
```

```
##
##    TP53     TTN PCDHAC2   MUC16   MUC17 PCDHGC5   USH2A   CSMD3 CD163L1 DYNC1H1
##     118      30      14      12       9       9       9       8       7       7
```

## 4 Exploring Multiple Studies

Instead of focusing on an individual study, we can also import several at
once. The results are stored as a GRangesList in which each
element corresponds to a single study. This can be merged into a single GRanges
object with `merge = TRUE`.

```
three_studies = scaLoadDatasets(all_datasets[1:3])

print(elementNROWS(three_studies))
```

```
##  gbm_tcga hnsc_tcga kirc_tcga
##     22166     73766     26265
```

```
class(three_studies)
```

```
## [1] "SimpleGRangesList"
## attr(,"package")
## [1] "GenomicRanges"
```

```
merged_studies = scaLoadDatasets(all_datasets[1:3], merge = TRUE)

class(merged_studies)
```

```
## [1] "GRanges"
## attr(,"package")
## [1] "GenomicRanges"
```

We then compute the number of mutations per gene and study:

```
gene_study_count = with(mcols(merged_studies), table(Hugo_Symbol, Dataset))

gene_study_count = gene_study_count[order(apply(gene_study_count, 1, sum), decreasing = TRUE), ]

gene_study_count = addmargins(gene_study_count)

head(gene_study_count)
```

```
##            Dataset
## Hugo_Symbol gbm_tcga hnsc_tcga kirc_tcga  Sum
##     Unknown       29       899       630 1558
##     TTN          121       401       125  647
##     TP53         101       323         8  432
##     MUC16         68       155        46  269
##     ADAM6          0       173        63  236
##     MUC4          17        32       130  179
```

Further, we can subset the data by regions of interests, and compute descriptive
statistics only on the subset.

```
tp53_region = GRanges("17", IRanges(7571720, 7590863))

tp53_studies = subsetByOverlaps(merged_studies, tp53_region)
```

For example, we can investigate which type of somatic variants can be found in
TP53 throughout the studies.

```
addmargins(table(tp53_studies$Variant_Classification, tp53_studies$Dataset))
```

```
##
##                          gbm_tcga hnsc_tcga kirc_tcga Sum
##   Frame_Shift_Del               6        41         0  47
##   Frame_Shift_Ins               1        11         0  12
##   In_Frame_Del                  2         7         0   9
##   In_Frame_Ins                  0         2         0   2
##   Missense_Mutation            81       183         6 270
##   Nonsense_Mutation             4        54         0  58
##   Nonstop_Mutation              0         0         0   0
##   Silent                        1         6         1   8
##   Splice_Site                   6        19         1  26
##   Translation_Start_Site        0         0         0   0
##   RNA                           0         0         0   0
##   Sum                         101       323         8 432
```

To go further, how many patients have mutations in TP53 for each cancer type?

```
fraction_mutated_region = function(y, region) {
    s = subsetByOverlaps(y, region)
    m = length(unique(s$Patient_ID)) / metadata(s)$Number_Patients
    return(m)
}

mutated_fraction = sapply(three_studies, fraction_mutated_region, tp53_region)

mutated_fraction = data.frame(name = names(three_studies), fraction =
mutated_fraction)
```

```
library(ggplot2)

p = ggplot(mutated_fraction) + ggplot2::geom_bar(aes(x = name, y = fraction,
fill = name), stat = "identity") + ylim(0, 1) + xlab("Study") + ylab("Ratio") +
theme_bw()

print(p)
```

![plot of chunk plot_mutated_genes](figure/plot_mutated_genes-1.png)

## 5 Data Provenance

### 5.1 TCGA Data

When importing the mutation data from the TCGA servers, we checked the data for
consistency and fix common ambiguities in the annotation.

#### 5.1.1 Processing

1. Selection of the most recent somatic variant calls for each study. These were
   stored as `*.maf` files in the TCGA data
   directory[3](#fn.3). If
   both manually curated and automatically generated variant calls were
   available, the curated version was chosen.
2. Importing of the `*.maf` files into and checking for consistency with the
   TCGA MAF
   specifications[4](#fn.4). Please
   note that these guidelines are currently only suggestions and most TCGA files
   violate some of these.
3. Transformation of the imported variants into a GRanges object, with one row
   for each reported variant. Only columns related to the genomic origin of the
   somatic variant were stored, additional columns describing higher-level
   effects, such as mutational consequences and alterations at the protein
   level, were dropped. The seqlevels information defining the
   chromosomal ranges were taken from the 1000genomes phase 2 reference assembly[5](#fn.5).
4. The patient barcode was extracted from the sample barcode.
5. Metadata describing the design and analysis of the study was extracted.
6. The processed variants were written to disk, with one file for each
   study. The metadata for all studies were stored as a single, separate object.

#### 5.1.2 Selection Criteria of Data Sets

We included data sets in the package that were

* conducted by the Broad Institute.
* cleared for unrestricted access and usage[6](#fn.6).
* sequenced with Illumina platforms.

#### 5.1.3 Consistency Check

According to the TCGA specifications for the `MAF` files, we screened and
corrected for common artifacts in the data regarding annotation. This included:

* Transfering of all genomic coordinates to the NCBI 37 reference notation (with
  the chromosome always depicted as 'MT')
* Checking of the entries against all allowed values for this field (currently
  for the columns `Hugo_Symbol`, `Chromosome`, `Strand`, `Variant_Classification`,
  `Variant_Type`, `Reference_Allele`, `Tumor_Seq_Allele1`, `Tumor_Seq_Allele2`,
  `Verification_Status`, `Validation_Status`, `Sequencer`).

## 6 Alternatives

The TCGA data sets can be accessed in different ways. First, the TCGA itself
offers access to certain types of its collected
data[7](#fn.7). Another approach
has been taken by the cBioPortal for Cancer
Genomics[8](#fn.8) which has performed
high-level analyses of several TCGA data sources, such as gene expression and
copy number changes. This summarized data can be queried through an
interface[9](#fn.9).

## 7 Session Info

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
## [1] ggbio_1.58.0                    ggplot2_4.0.0
## [3] GenomicRanges_1.62.0            Seqinfo_1.0.0
## [5] IRanges_2.44.0                  S4Vectors_0.48.0
## [7] BiocGenerics_0.56.0             generics_0.1.4
## [9] SomaticCancerAlterations_1.46.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   bitops_1.0-9
##   [3] RBGL_1.86.0                 gridExtra_2.3
##   [5] rlang_1.1.6                 magrittr_2.0.4
##   [7] biovizBase_1.58.0           matrixStats_1.5.0
##   [9] compiler_4.5.1              RSQLite_2.4.3
##  [11] GenomicFeatures_1.62.0      png_0.1-8
##  [13] vctrs_0.6.5                 reshape2_1.4.4
##  [15] ProtGenerics_1.42.0         stringr_1.5.2
##  [17] pkgconfig_2.0.3             crayon_1.5.3
##  [19] fastmap_1.2.0               backports_1.5.0
##  [21] XVector_0.50.0              labeling_0.4.3
##  [23] Rsamtools_2.26.0            rmarkdown_2.30
##  [25] graph_1.88.0                UCSC.utils_1.6.0
##  [27] bit_4.6.0                   xfun_0.54
##  [29] cachem_1.1.0                cigarillo_1.0.0
##  [31] GenomeInfoDb_1.46.0         jsonlite_2.0.0
##  [33] blob_1.2.4                  highr_0.11
##  [35] DelayedArray_0.36.0         BiocParallel_1.44.0
##  [37] parallel_4.5.1              cluster_2.1.8.1
##  [39] R6_2.6.1                    VariantAnnotation_1.56.0
##  [41] stringi_1.8.7               RColorBrewer_1.1-3
##  [43] rtracklayer_1.70.0          rpart_4.1.24
##  [45] Rcpp_1.1.0                  SummarizedExperiment_1.40.0
##  [47] knitr_1.50                  base64enc_0.1-3
##  [49] Matrix_1.7-4                nnet_7.3-20
##  [51] tidyselect_1.2.1            rstudioapi_0.17.1
##  [53] dichromat_2.0-0.1           abind_1.4-8
##  [55] yaml_2.3.10                 codetools_0.2-20
##  [57] curl_7.0.0                  lattice_0.22-7
##  [59] tibble_3.3.0                plyr_1.8.9
##  [61] Biobase_2.70.0              withr_3.0.2
##  [63] KEGGREST_1.50.0             S7_0.2.0
##  [65] evaluate_1.0.5              foreign_0.8-90
##  [67] Biostrings_2.78.0           BiocManager_1.30.26
##  [69] pillar_1.11.1               MatrixGenerics_1.22.0
##  [71] checkmate_2.3.3             OrganismDbi_1.52.0
##  [73] RCurl_1.98-1.17             ensembldb_2.34.0
##  [75] scales_1.4.0                glue_1.8.0
##  [77] Hmisc_5.2-4                 lazyeval_0.2.2
##  [79] tools_4.5.1                 BiocIO_1.20.0
##  [81] data.table_1.17.8           BSgenome_1.78.0
##  [83] GenomicAlignments_1.46.0    XML_3.99-0.19
##  [85] grid_4.5.1                  AnnotationDbi_1.72.0
##  [87] colorspace_2.1-2            htmlTable_2.4.3
##  [89] restfulr_0.0.16             Formula_1.2-5
##  [91] cli_3.6.5                   S4Arrays_1.10.0
##  [93] dplyr_1.1.4                 AnnotationFilter_1.34.0
##  [95] gtable_0.3.6                digest_0.6.37
##  [97] SparseArray_1.10.1          rjson_0.2.23
##  [99] htmlwidgets_1.6.4           farver_2.1.2
## [101] memoise_2.0.1               htmltools_0.5.8.1
## [103] lifecycle_1.0.4             httr_1.4.7
## [105] bit64_4.6.0-1
```

## Footnotes:

[1](#fnr.1)

<http://cancergenome.nih.gov>

[2](#fnr.2)

[https://wiki.nci.nih.gov/display/TCGA/TCGA+Home](https://wiki.nci.nih.gov/display/TCGA/TCGA%2BHome)

[3](#fnr.3)

<https://tcga-data.nci.nih.gov/tcgafiles/ftp_auth/distro_ftpusers/anonymous/tumor/>

[4](#fnr.4)

[https://wiki.nci.nih.gov/display/TCGA/Mutation+Annotation+Format+(MAF)](https://wiki.nci.nih.gov/display/TCGA/Mutation%2BAnnotation%2BFormat%2B%28MAF%29)+Specification

[5](#fnr.5)

ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/phase2\_reference\_assembly\_sequence/

[6](#fnr.6)

<http://cancergenome.nih.gov/abouttcga/policies/publicationguidelines>

[7](#fnr.7)

<https://tcga-data.nci.nih.gov/tcga/tcgaDownload.jsp>

[8](#fnr.8)

<http://www.cbioportal.org/public-portal>

[9](#fnr.9)

<http://www.cbioportal.org/public-portal/cgds_r.jsp>

Author: Julian Gehring, EMBL Heidelberg

Created: 2013-10-20 Sun 18:22

[Emacs](http://www.gnu.org/software/emacs/) 24.1.1 ([Org](http://orgmode.org) mode 8.2.1)

[Validate](http://validator.w3.org/check?uri=referer)