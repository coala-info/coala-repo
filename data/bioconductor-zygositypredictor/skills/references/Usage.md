# Usage of ZygosityPredictor

Marco Rheinnecker

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Important](#important)
* [3 Installation](#installation)
* [4 load example data](#load-example-data)
* [5 Calculation of affected copies of a variant](#calculation-of-affected-copies-of-a-variant)
  + [5.1 Germline variants](#germline-variants)
  + [5.2 Somatic variants](#somatic-variants)
  + [5.3 Calculate affected copies of a set of variants](#calculate-affected-copies-of-a-set-of-variants)
* [6 Predict Zygosity](#predict-zygosity)
  + [6.1 Format of input data](#format-of-input-data)
  + [6.2 Predict zygosity for a set of genes in a sample](#predict-zygosity-for-a-set-of-genes-in-a-sample)
  + [6.3 Interpretation of results](#interpretation-of-results)
* [7 References](#references)
* **Appendix**

# 1 Introduction

The software package ZygosityPredictor allows to predict how many copies of a
gene are affected by mutations, in particular small variants (single nucleotide
variants, SNVs, and small insertions and deletions, Indels). In addition to the
basic calculations of the affected copy number of a variant, ZygosityPredictor
can phase multiple variants in a gene and ultimately make a prediction if and
how many wild-type copies of the gene are left. This information proves to be
of particular use in the context of translational medicine. For example, in
cancer genomes, ZygosityPredictor can address whether unmutated copies of
tumor-suppressor genes are present. ZygosityPredictor was developed to handle
somatic and germline small variants. In addition to the small variant context,
it can assess larger deletions, which may cause losses of exons or whole genes.

# 2 Important

To use ZygosityPredictor, the input data has to meet some requirements. The
most important one is that all input variants, SNVs, Indels and sCNAs must
originate from a fully clonal tumor. If indications are present that a sample
consists of several sub clones (e.g. in tumor samples), the results must be seen
with caution as the implementation is founded on the assumption of clonality.
The second important requirement applies mainly to the second part of the tool
and will thereofre be explained in section “Predict Zygosity”

# 3 Installation

The following code can be used to install ZygosityPredictor. The installation
needs to be done once.

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ZygosityPredictor")
```

# 4 load example data

To demonstrate the use of ZygosityPredictor, NGS data from the Seq-C2 project
were used [1]. In the following chunk, all required datalayer of the WGS\_LL\_T\_1
sample are loaded. The variants are loaded as GRanges objects, one for somatic
copy number alterations (GR\_SCNA), one for germline- and one for somatic small
variants (GR\_GERM\_SMALL\_VARS and GR\_SOM\_SMALL\_VARS). The input formats will be
discussed in more detail in section 4.

```
library(ZygosityPredictor)
library(dplyr)
```

```
##
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
##
##     filter, lag
```

```
## The following objects are masked from 'package:base':
##
##     intersect, setdiff, setequal, union
```

```
library(stringr)
library(GenomicRanges)
```

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
## The following object is masked from 'package:dplyr':
##
##     explain
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
## The following object is masked from 'package:dplyr':
##
##     combine
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
## The following objects are masked from 'package:dplyr':
##
##     first, rename
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
##
## Attaching package: 'IRanges'
```

```
## The following objects are masked from 'package:dplyr':
##
##     collapse, desc, slice
```

```
## Loading required package: Seqinfo
```

```
# file to sequence alignment
FILE_BAM <- system.file("extdata", "ZP_example.bam",
                        package = "ZygosityPredictor")
VCF <- system.file("extdata", "ZP_example_chr7.vcf.gz",
                        package = "ZygosityPredictor")
# meta information of the sample
PURITY <- 0.98
PLOIDY <- 1.57
SEX <- "female"
# variants
data("GR_SCNA")
data("GR_GERM_SMALL_VARS")
data("GR_SOM_SMALL_VARS")
# used gene model
data("GR_GENE_MODEL")
data("GR_HAPLOBLOCKS")
```

# 5 Calculation of affected copies of a variant

Two functions are provided to calculate how many copies are affected by single
small variants, based on two formulas, one for germline variants and one for
somatic variants.

## 5.1 Germline variants

To calculate the affected copies for a germline variant by using
`aff_germ_copies()`, the following inputs are required:

* **af**: numeric; between 0 and 1; calculated allele frequency of the variant
  in the tumor sample
* **tcn**: numeric; total copy number at the position of the variant
* **purity**: numeric; between 0 and 1; purity or tumor cell content of the
  tumor sample
* **c\_normal**: numeric; expected copy number at the position of the variant
  in normal tissue, 1 for gonosomes in male samples, and 2 for male autosomes and
  all chromosomes in female samples. (The function can also assess the c\_normal
  parameter by itself, but then the following two inputs must be provided:
  chr and sex)
* **chr**: (only if c\_normal is not provided) character; can be either a single
  number or in the “chr1” format; chromosome of the variant
* **sex**: (only if c\_normal is not provided) character; either “male” or
  “female” / “m” or “f”; sex of the sample
* **af\_normal**: (default 0.5) numeric; allele-frequency of germline variant in
  normal tissue. 0.5 represents heterozygous variants in diploid genome, 1 would
  be homozygous. Could be relevant if germline CNVs are present at the position.
  Then also the c\_normal parameter would have to be adjusted.

the output is a numeric value that indicates the affected copies.

```
## as an example we take the first variant of our prepared input data and
## extract the required information from different input data layer
## the allele frequency and the chromosome can be taken from the GRanges object

AF = elementMetadata(GR_GERM_SMALL_VARS[1])[["af"]]
CHR = seqnames(GR_GERM_SMALL_VARS[1]) %>%
  as.character()

## the total copy number (tcn) can be extracted from the CNV object by selecting
## the CNV from the position of the variant

TCN = elementMetadata(
  subsetByOverlaps(GR_SCNA, GR_GERM_SMALL_VARS[1])
  )[["tcn"]]

## purity and sex can be taken from the global variables of the sample
## with this function call the affected copies are calculated for the variant
aff_germ_copies(af=AF,
                tcn=TCN,
                purity=PURITY,
                chr=CHR,
                sex=SEX)
```

```
## [1] 1.50733
```

## 5.2 Somatic variants

To calculate how many copies are affected by a somatic variant by
`aff_som_copies()`, the same inputs are required, but a different formula
is evaluated:

```
## the function for somatic variants works the same way as the germline function

AF = elementMetadata(GR_SOM_SMALL_VARS[1])[["af"]]
CHR = seqnames(GR_SOM_SMALL_VARS[1]) %>%
  as.character()
TCN = elementMetadata(
  subsetByOverlaps(GR_SCNA, GR_SOM_SMALL_VARS[1])
  )[["tcn"]]

aff_som_copies(af=AF,
               chr=CHR,
               tcn=TCN,
               purity=PURITY,
               sex=SEX)
```

```
## [1] 1.471406
```

## 5.3 Calculate affected copies of a set of variants

In order to apply the previously mentioned functions to a whole set of variants
and calculate the affected copies, the following code can be used.

```
## as an example we calculate the affected copies for the somatic variants:
GR_SOM_SMALL_VARS %>%
  ## cnv information for every variant is required.. merge with cnv object
  IRanges::mergeByOverlaps(GR_SCNA) %>%
  as_tibble() %>%
  ## select relevant columns
  select(chr=1, pos=2, gene, af, tcn) %>%
  mutate_at(.vars=c("tcn", "af"), .funs=as.numeric) %>%
  rowwise() %>%
  mutate(
    aff_copies = aff_som_copies(chr, af, tcn, PURITY, SEX),
    wt_copies = tcn-aff_copies
  )
```

```
## # A tibble: 10 × 7
## # Rowwise:
##    chr         pos gene        af   tcn aff_copies wt_copies
##    <fct>     <int> <chr>    <dbl> <dbl>      <dbl>     <dbl>
##  1 chr6   29100982 OR2J1   0.358   4.06     1.47       2.59
##  2 chr6   29101487 OR2J1   0.328   4.06     1.35       2.72
##  3 chr6   29101522 OR2J1   0.328   4.06     1.35       2.72
##  4 chr7  107767595 SLC26A3 0.0263  2.49     0.0665     2.42
##  5 chr7  107774037 SLC26A3 0.0476  2.49     0.120      2.37
##  6 chr16  48216115 ABCC11  0.352   3.07     1.10       1.97
##  7 chr16  48231866 ABCC11  0.347   3.07     1.08       1.99
##  8 chrX   88753422 CPXCR1  0.5     1.12     0.579      0.539
##  9 chrX   88753806 CPXCR1  0.491   1.12     0.569      0.549
## 10 chr17  41771694 JUP     0.857   1.06     0.947      0.117
```

There s also the function `predict_per_variant` that basically does the same
with slightly adjusted inputs.

```
predict_per_variant(purity=PURITY,
                    sex=SEX,
                    somCna=GR_SCNA,
                    somSmallVars=GR_SOM_SMALL_VARS)
```

```
## Warning in FUN(X[[i]], ...): column gt_cna contains annotations of balanced
## segments. They are removed from imbalance phasing if enabled
## Warning in FUN(X[[i]], ...): column gt_cna contains annotations of balanced
## segments. They are removed from imbalance phasing if enabled
## Warning in FUN(X[[i]], ...): column gt_cna contains annotations of balanced
## segments. They are removed from imbalance phasing if enabled
```

```
## Warning in check_gr_small_vars(germSmallVars, "germline", ZP_env): Input
## germSmallVars empty/does not contain variants. Assuming there are no germline
## small variants
```

```
## Warning in check_opt_incdel(includeIncompleteDel, ploidy): Large scale
## deletions cannot be included without ploidyPlease provide input ploidy. Provide
## ploidy=2to assume diploid case
```

```
## Warning in check_opt_incdel(includeHomoDel, ploidy): Large scale deletions
## cannot be included without ploidyPlease provide input ploidy. Provide
## ploidy=2to assume diploid case
```

```
## $evaluation_per_variant
## # A tibble: 10 × 19
##    gene    mut_id    pos ref   alt       af   tcn cna_type all_imb gt_cna seg_id
##    <chr>   <chr>   <int> <chr> <chr>  <dbl> <dbl> <chr>    <lgl>   <chr>   <int>
##  1 OR2J1   m1     2.91e7 C     A     0.358   4.06 HZ       FALSE   <NA>        5
##  2 OR2J1   m2     2.91e7 T     C     0.328   4.06 HZ       FALSE   <NA>        5
##  3 OR2J1   m3     2.91e7 C     T     0.328   4.06 HZ       FALSE   <NA>        5
##  4 SLC26A3 m1     1.08e8 C     T     0.0263  2.49 LOH      FALSE   2:sub       7
##  5 SLC26A3 m2     1.08e8 G     C     0.0476  2.49 LOH      FALSE   2:sub       7
##  6 ABCC11  m1     4.82e7 G     T     0.352   3.07 HZ       TRUE    1:2         1
##  7 ABCC11  m2     4.82e7 C     T     0.347   3.07 HZ       TRUE    1:2         1
##  8 CPXCR1  m1     8.88e7 A     C     0.5     1.12 HZ       FALSE   <NA>        8
##  9 CPXCR1  m2     8.88e7 G     A     0.491   1.12 HZ       FALSE   <NA>        8
## 10 JUP     m1     4.18e7 GTGT… G     0.857   1.06 LOH      FALSE   1:0         2
## # ℹ 8 more variables: tcn_assumed <lgl>, origin <chr>, chr <fct>, class <chr>,
## #   aff_cp <dbl>, wt_cp <dbl>, vn_status <dbl>, pre_info <chr>
##
## $combined_uncovered
## NULL
```

# 6 Predict Zygosity

In this section, we will use the WGS\_LL\_T\_1 dataset from the Seq-C2 project as
an example to investigate whether mutations in the following genes result in
total absence of wildtype copies. The genes which were selected as an example
for the analysis are shown below. The example data set was reduced to these
genes.

* TP53
* BRCA1
* TRANK1
* TRIM3
* JUP
* CDYL
* SCRIB
* ELP2

## 6.1 Format of input data

Some inputs are optional, while others are compulsory. The latter are labeled
with “\*\*”. Of note, ZygosityPredictor is applied downstream of variant calling,
therefore the variant calls, including information on identified somatic copy
number aberrations (sCNAs), have to be provided. The inputs can be divided into
five classes:

* File paths:
  + **bamDna\*\*** : character; path to indexed alignment (.bam format)
  + **bamRna**: character; path to rna-sequencing data (.bam format).
  + **vcf**: character, or character vector containing several vcf file paths;
    path to variant call file (.vcf.gz format) or .vcf.
    for extended SNP phasing if variants on the same gene are too far away from
    each other for direct phasing
* Sample meta information:
  + **purity\*\*** : numeric; between 0 and 1; indicates purity or tumor cell
    content of the sample
  + **ploidy**: numeric; ground ploidy of the sample
  + **sex\*\*** : character; “male” or “female” / “m” or “f”; sex of the
    patient the sample was taken from
* Variants
  + **somCna\*\*** : GRanges object; containing all genomic segments (sCNA)
    with annotated total copy number (default metadata column name *“tcn”*,
    custom name can be provided by COLNAME\_TCN) and information about LOH
    (default column name *“cna\_type”*, custom name can be provided by
    COLNAME\_CNA\_TYPE). The cna\_type column should contain the string “LOH” if
    loss-of heterozygosity is present at the segment. If large deletions should
    be included to the analysis the total copy number has to be decreased
    accordingly. If the total copy number is smaller than 0.5, the tool will
    assume a homozygous deletion. An incomplete deletion is assumed if at least
    one copy is lost compared to the ploidy of the sample (works only if the
    ploidy is provided as an input)
  + **somSmallVars**: GRanges object; containing all somatic small variants.
    Required metadata columns are: reference base (*“REF”/”ref”*), alternative
    base (*“ALT”/”alt”*), allele frequency in the tumor sample (raw allele
    frequency, i.e. as measured in the tumor sample; not the corrected allele
    frequency in the supposedly pure tumor) (*“AF”/”af”*), gene (*“gene”/”GENE”*,
    according to the used gene model (GENCODE39 in the example data) and the
    annotation provided below). If no relevant somatic small variants are
    present, can also be NULL or not provided.
  + **germSmallVars**: GRanges object; Analogous to GR\_SOM\_SMALL\_VARS. If no
    relevant germline small variants are present, can also be NULL or not
    provided.
* Used Gene model
  + **geneModel\*\*** : GRanges object; containing the gene model for the used
    reference genome. Required metadata columns are: *“gene”*. Artificially
    restricting the gene model can be used to tell the tool which genes to
    analyze. In the case of this vignette, the object contains only the genes we
    selected.
* Haploblocks
  + **haploBlocks**: GRanges object; containing predefined haplock region, i.e.
    genomic regions in which SNPs could be phased to one specific haplotype. By
    providing this haploblock together with the SNPs and its genotype annotation
    (1|0 or 0|1) via input **vcf**, haploblock phasing will be enabled.
* Options
  + **logDir**: character; If provided, detailed output will be stored in it
  + **includeIncompleteDel**: logical, default=TRUE; Should incomplete
    deletions (monoallelic deletions in a diploid sample) be included in the
    evaluation? Since these often span large parts of the chromosomes and will
    lead to many affected genes, it can be advisable to include or exclude them,
    depending on the research question.
  + **includeHomoDel**: logical, default=TRUE; Should homozygous deletions be
    included in the evaluation?
  + **AllelicImbalancePhasing**: logical, default=FALSE; If TRUE, performs (if
    read-level phasing fails) allelic imbalance phasing. Results must be seen
    with caution as for somatic variants incorrect constellations might be
    determined.
  + **showReadDetail**: logical, default=FALSE; If this option is TRUE, another
    table is added to the output that contains more detailed information about
    the classification of the read pairs. More detailed information is provided
    in section 4.3.4.
  + **assumeSomCnaGaps**: logical, default=FALSE; Only required if the somCna
    object lacks copy number information for genomic segments on which small
    variants are detected. By default, variants in such regions will be excluded
    from the analysis as required information about the copy number is missing.
    These variants will be attached to the final output list in a separate
    tibble. To include them, this flag must be set TRUE and the ground ploidy
    must be given as an input. This ground ploidy will then be taken as *tcn*
    in the missing regions.
  + **byTcn**: logical, default=TRUE; optional if includeHomoDel or
    includeIncompleteDel is TRUE. If FALSE the tool will not use tcn as a
    criterion to assign large deletions. It will use the cna\_type column and
    check for indicating strings like HOMDEL/HomoDel/DEL. Some commonly used
    strings are covered. It is recommended to leave this flag TRUE.
  + **printLog**: logical, default=TRUE; If TRUE, the tool will print detailed
    information how the assessment is done for each gene.
  + **verbose**: logical, default=FALSE; prints debugging information
  + **colnameTcn**: character; indicating the name of the metadata column
    containing the tcn information in the somCna object. If not provided
    the tool tries to detect the column according to default names.
  + **colnameCnaType**: character; The same as for colnameTcn, but for
    cna-type information.
  + **distCutOff**: numeric, default=5000; if input vcf is provided and SNP
    phasing is performed, this will limt the distance at which the SNP phasing
    should not be tried anymore. As the probability of finding overlapping reads
    at such a long distance is very low and the runtime will increase
    exponentially.
  + **snpQualityCutOff**
  + **refGen**: character, default=“hg38”; Required if vcf files is provided.
    Either “hg38” or “hg19”. Relevant for VariantAnnotation vcf loading

## 6.2 Predict zygosity for a set of genes in a sample

The prediction of zygosity for a set of genes in a sample can be assessed by
the `predict_zygosity()` function.

**Important note**: The runtime of the analysis depends strongly on the number
of genes to be assessed and on the number of input variants. It is therefore
recommended to reduce the number of genes to the necessary ones. Also,
depending on the research question to be addressed, the variants should be
filtered to the most relevant ones, not only because of runtime considerations,
but also to sharpen the final result. A large number of mutations in a gene,
some of which are of little biological relevance or even SNPs, will inevitably
reduce the validity of the results.

```
fp <- predict_zygosity(
  purity = PURITY,
  ploidy = PLOIDY,
  sex = SEX,
  somCna = GR_SCNA,
  somSmallVars = GR_SOM_SMALL_VARS,
  germSmallVars = GR_GERM_SMALL_VARS,
  geneModel = GR_GENE_MODEL,
  bamDna = FILE_BAM,
  vcf=VCF,
  haploBlocks = GR_HAPLOBLOCKS
)
```

```
## Warning in check_gr_gene_model(geneModel, ZP_env):
```

```
## Warning in FUN(X[[i]], ...): column gt_cna contains annotations of balanced
## segments. They are removed from imbalance phasing if enabled
## Warning in FUN(X[[i]], ...): column gt_cna contains annotations of balanced
## segments. They are removed from imbalance phasing if enabled
## Warning in FUN(X[[i]], ...): column gt_cna contains annotations of balanced
## segments. They are removed from imbalance phasing if enabled
```

```
## no RNA file provided: Analysis will be done without RNA reads
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongQuerySpace", "cigars_as_ranges_along_query", : cigarRangesAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigars_as_ranges_along_query() function from the
##   new cigarillo package
```

```
## Warning in call_new_fun_in_cigarillo("cigarRangesAlongReferenceSpace", "cigars_as_ranges_along_ref", : cigarRangesAlongReferenceSpace() is formally deprecated in GenomicAlignments
##   >= 1.45.5 and replaced with the cigars_as_ranges_along_ref() function from
##   the new cigarillo package
```

## 6.3 Interpretation of results

Of note, the results displayed here were chosen to explain and exemplify the
functionality of the tool; biological and medical impact of the specific
variants has not been a selection criterion.
The result which is returned by the function consists of a list of tibbles:

* Evaluation per variant
* Evaluation per gene
* Main Phasing info
* detailed read-level phasing (RLP) info
* detailed alleleic imbalance phasing (AIP) info, if enabled
* Read pair info (only if showReadDetail=TRUE and logDir is provided)
* Variants not covered by somCna (only if present and no sCNA gap assumption
  was done)

One way of accessing the results is a simple extraction of the tibbles from the
list. In addition, two accessor function are implemented: `ZP_ov()` shows an
overview of the full resultand and `gene_ov()` shows more detailed
information about a selected gene.

```
ZP_ov(fp)
```

```
## Zygosity Prediction of 12 input variants
```

```
## 0 are uncovered by sCNA input and were not evaluated
```

```
## 7 genes analyzed:
```

```
## |status              |eval_by        |  n|
## |:-------------------|:--------------|--:|
## |all_copies_affected |aff_cp         |  2|
## |wt_copies_left      |aff_cp         |  2|
## |wt_copies_left      |direct-phasing |  1|
## |wt_copies_left      |insufficient   |  2|
## |undefined           |NA             |  0|
```

```
## phased genes:
## CPXCR1, OR2J1
```

The function provides an overview about the evaluations done by
ZygosityPredictor. One can see that in our case 12 input small variants were
used to predict gene status. Of those, two got the status all\_copies\_affected.

### 6.3.1 Evaluation per variant

The first result of the function is the evaluation per variant. In this step
all information required for subsequent steps is annotated and the affected
copies per variant are calculated. For every variant, the function checks
whether it already affects all copies of the gene. The format of the output is
a tibble; the number of rows corresponds to the total
number of input variants. The tool annotates a few self-explanatory columns
such as the origin of the respective variant (germline/somatic) or the class
(snv/ins/del). It also appends information from the sCNA results: the total
copy number at the position of the variant and the information if a loss of
heterozygosity is present (cna\_type). Also, an ID is assigned to every small
variant. Then, the genes are numbered consecutively in order to unambiguously
assign variants to genes in the following analysis. The most important results
of this step are the calculation of the affected and wildtype copies, as well
as, depending on the data, an initial check of whether a variant already affects
all copies.

Of note, there can be situations in which left wildtype copies are below 0.5,
but still this information is not sufficient to predict *“all\_copies\_affected”*
without doubt. Depending on the origin of the variant, further criteria must
be met (e.g., LOH). The procedure for this first check is shown in the pre\_info
column.

### 6.3.2 Evaluation per gene + phasing info

By using `gene_ov()`, more detailed information can be viewed about how the
tool came to a gene status. What the accessor function does is basically
filtering the output tibbles to the gene of relevance. Detailed explanation about all columns can be found below the next chunk.

```
gene_ov(fp, OR2J1)
```

```
## Top level: Gene status
```

```
## |gene  | n_mut|status         | conf|eval_by |    wt_cp|warning |wt_cp_range |info                                     |phasing        | eval_time_s|
## |:-----|-----:|:--------------|----:|:-------|--------:|:-------|:-----------|:----------------------------------------|:--------------|-----------:|
## |OR2J1 |     3|wt_copies_left |    1|aff_cp  | 2.592225|none    |1.24 - 2.72 |most relevant phasing combination: m1-m2 |direct-phasing |       3.379|
```

```
##
##
## Sub level: Evaluation per variant
```

```
## |gene  |origin  |class |chr  |      pos|ref |alt |   af|  tcn|tcn_assumed |cna_type |all_imb |gt_cna | seg_id| aff_cp| wt_cp|mut_id |
## |:-----|:-------|:-----|:----|--------:|:---|:---|----:|----:|:-----------|:--------|:-------|:------|------:|------:|-----:|:------|
## |OR2J1 |somatic |snv   |chr6 | 29100982|C   |A   | 0.36| 4.06|FALSE       |HZ       |FALSE   |NA     |      5|   1.47|  2.59|m1     |
## |OR2J1 |somatic |snv   |chr6 | 29101487|T   |C   | 0.33| 4.06|FALSE       |HZ       |FALSE   |NA     |      5|   1.35|  2.72|m2     |
## |OR2J1 |somatic |snv   |chr6 | 29101522|C   |T   | 0.33| 4.06|FALSE       |HZ       |FALSE   |NA     |      5|   1.35|  2.72|m3     |
```

```
##
##
## Sub level: Main phasing combinations
```

```
## |comb  | nconst|const |phasing        |via | conf|unplausible |subclonal | wt_cp| min_poss_wt_cp| max_poss_wt_cp| score|gene  |
## |:-----|------:|:-----|:--------------|:---|----:|:-----------|:---------|-----:|--------------:|--------------:|-----:|:-----|
## |m2-m3 |      1|same  |direct-phasing |8   | 1.00|0           |0         |  2.72|           1.37|           2.72|     1|OR2J1 |
## |m1-m2 |      1|same  |direct-phasing |4   | 0.86|0           |0         |  2.59|           1.25|           2.59|     1|OR2J1 |
## |m1-m3 |      1|same  |direct-phasing |7   | 0.86|0           |0         |  2.59|           1.24|           2.59|     1|OR2J1 |
```

```
##
##
## Sub level: All read-level-phasing combinations, including SNPs
## Showing 3 of 3 phasing attempts
##
## |  both| mut1| mut2| dev_var| skipped|const | nconst| p_same| p_diff| none_raw| DNA_rds| RNA_rds|subclonal |unplausible | dist|class_comb |comb  | ncomb|gene  | conf|
## |-----:|----:|----:|-------:|-------:|:-----|------:|------:|------:|--------:|-------:|-------:|:---------|:-----------|----:|:----------|:-----|-----:|:-----|----:|
## |  2.00|    0|    0|       0|       0|same  |      1|      1|   0.14|        0|       2|       0|FALSE     |FALSE       |  505|snv-snv    |m1-m2 |     4|OR2J1 |   NA|
## |  2.00|    0|    0|       0|       0|same  |      1|      1|   0.14|        0|       2|       0|FALSE     |FALSE       |  540|snv-snv    |m1-m3 |     7|OR2J1 |   NA|
## | 39.99|    0|    0|       0|       0|same  |      1|      1|   0.00|       22|      62|       0|FALSE     |FALSE       |   35|snv-snv    |m2-m3 |     8|OR2J1 |   NA|
```

```
##
```

The first prompted tibble originates from the eval\_per\_gene tibble of the output.
The tibble shown
below originates from eval\_per\_variant and shows all input small variants of the
gene. The next tibble originates from main\_phasing\_info and shows the main
phasing combinations. Finally, the last tibble comes from detailed\_RLP\_info
and contains every phasing combination including the ones with and between SNPs.

What can be seen is that the final gene status of OR2J1 is wt\_copies\_left. The
tool predicted around 2.6 remaining wt copies with maximum confidence level of
1. Below it can be seen that 3 small variants inside the gene were in the input
leading to 3 main phasing combinations. All of them were phased via direct read level phasing.
As all main combinations could
be solved, the left wt copies could be accurately defined and the gene status
assigned. In this particular case, the gene status could have been solved even
without phasing all main combinations by the case we refer to as insufficient.
As the final gene status is defnied via the so called `integrated_affected_copies`,
which are defnied for diff constellation via: `aff_cp(m1)+aff_cp(m2)` and for the same constellation:
`max(aff_cp(m1), aff_cp(m2))`, we can pre-calculate the maximum affected
copies in case of a diff constellation. If the difference of the total copy number
and the integrated affected copies leaves more than 0.5 wt copies, the status wt\_cp\_left can be concluded.
As can be seen in the main phasing combinations in column: min\_poss\_wt\_cp, none
of the main phasing combinations could lead to less than 0.5 wt copies even if
the variants were found on different reads.

The outputs contain columns providing more detailed information about gene status definition
which will be explained in the following.

#### 6.3.2.1 All read-level phasing combinations

(either visible via `gene_ov()` or accessable via `fp$detailed_RLP_info`):

* **both**: number of reads classified as both (both variants present), adjusted with basecall and maping quality
* **mut1**: number of reads classified as mut1 (only the first variant of combination pßresent), adjusted with basecall and maping quality
* **mut2**: number of reads classified as mut2 (only the second variant of combination pßresent), adjusted with basecall and maping quality
* **dev\_var**: number of reads having another variant at one of the positions of the expected variants
* **skipped**: number of reads not mapping to the position of the variant (only expected with RNA reads)
* **nstatus**: variant constellation in numeric representation (2 = all copies affected, 1 = wt copies left, 0 = undefined)
* **status**: variant constellation in character representation
* **nstatus**: numeric representation of constellation
* **xsq\_same/xsq\_diff**: X-squared values of chi-squared tests. \_same is the one against expected same result
* **p\_same/p\_diff**: p-value of chi-squared tests
* **v\_same/v\_diff**: Cramers V value of chi-squared tests (5)
* **none**: number of reads classified as none (none of both variants found)
* **DNA\_rds/RNA\_rds**: number of DNA/RNA reads used
* **dist**: Distance between variants
* **class\_comb**: mutational classes corresponding to character combination identifier
* **comb**: combination identifier in character representation (mX-mY).
* **ncomb**: combination identifier in numeric representation. Derived from position in phasing matrix
* **subclonal**: TRUE if reads with classification both and either mut1 or mut2 were found. There are two explanantions why soimething like this could happen in a
  cancer sample: First that the tumor is not fully clonal and a subclone is present carrying only the variant that happened earlier during tumor development. The second variant is only carried by a subclone that emerged later. The second explanation could be that the reads are actually from the same cells but a duplication of one allel happend between their occurence. We could imagine a scenario were the genotype of a gene is 1:2 and both variants are on the duplicated allele. If one of them happend before the duplication, we would expect reads carrying only the earlier variant but also reads carrying both of them.
* **unplausible** TRUE if reads with classification both, mut1 and mut2 are found for the same variant combination. Compared to the “subclonal” case this is more difficult to explain and might also be an artifact. The only way this could happen in a cancer sample is that the same mutational event happens independently on both alleles and or in different subclones. This case is generally very unlikely and is therefore annotated as unplasuible. Such a setting is also reflected in the p-valkue and thereofre the confidence, as similary with both expected results is found.

#### 6.3.2.2 Main phasing combinations (either visible via `gene_ov()` or accessable via `fp$phasing_info`):

* **phasing**: Info which phasing approach was used (direct, indirect, haploblock, imbalance, flagged)
* **via**: combinations which were used to solve this combination. For direct phasing the number is the numeric representation of the combi9nation identifier.
  For indirect phasing it will look like this: 4-7-8 which measn thta the combinations 4, 7 and 8 were used to solve.
* **conf**: aggregated confidence for the combination
* **wt\_cp**: exact left wt copies. If phasing of combination was not succesful, wt copies can not be calculated acurately which leads to NA
* **min\_poss\_wt\_cp**: Minimal possible wt copies if variants are on different copies according to affected copynumber of the two variants in the combination. If greater than 0.5, the constellation is unable to contributre to a status of all copies affrected for the gene.
* **max\_poss\_wt\_cp**: maximum possible wt copies if the two variants are on the same copy
* **score**: contribution to gene status. (2 is a contribution of all copies affected by the combination, 1 has more than 0.5 wt copies left)
* **gene**: Gene that w2as tried to solve with the combination

# 7 References

# Appendix

1. Fang LT, Zhu B, Zhao Y, Chen W, Yang Z, Kerrigan L, Langenbach K, de Mars M,
   Lu C, Idler K, et al. Establishing community reference samples, data and call
   sets for benchmarking cancer mutation detection using whole-genome sequencing.
   Nature Biotechnology. 2021;39(9):1151-1160 / PMID:34504347
2. Lawrence M, Huber W, Pages H, Aboyoun P, Carlson M, et al. (2013) Software
   for Computing and Annotating Genomic Ranges. PLoS Comput Biol 9(8): e1003118.
   doi:10.1371/journal.pcbi.1003118\*
3. Wickham H, François R, Henry L, Müller K (2022). *dplyr: A Grammar of Data
   Manipulation*. R package version 1.0.10,
   [https://CRAN.R-project.org/package=dplyr](https://CRAN.R-project.org/package%3Ddplyr).
4. Wickham H (2022). *stringr: Simple, Consistent Wrappers for Common String
   Operations*.
   <https://stringr.tidyverse.org>, <https://github.com/tidyverse/stringr>.
5. Cramér, Harald. 1946. Mathematical Methods of Statistics. Princeton:
   Princeton University Press, page 282 (Chapter 21. The two-dimensional case)

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
##  [1] GenomicRanges_1.62.0     Seqinfo_1.0.0            IRanges_2.44.0
##  [4] S4Vectors_0.48.0         BiocGenerics_0.56.0      generics_0.1.4
##  [7] stringr_1.5.2            dplyr_1.1.4              ZygosityPredictor_1.10.0
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0             SummarizedExperiment_1.40.0
##  [3] rjson_0.2.23                xfun_0.53
##  [5] bslib_0.9.0                 Biobase_2.70.0
##  [7] lattice_0.22-7              tzdb_0.5.0
##  [9] vctrs_0.6.5                 tools_4.5.1
## [11] bitops_1.0-9                curl_7.0.0
## [13] parallel_4.5.1              tibble_3.3.0
## [15] AnnotationDbi_1.72.0        RSQLite_2.4.3
## [17] blob_1.2.4                  pkgconfig_2.0.3
## [19] Matrix_1.7-4                BSgenome_1.78.0
## [21] cigarillo_1.0.0             lifecycle_1.0.4
## [23] compiler_4.5.1              Rsamtools_2.26.0
## [25] Biostrings_2.78.0           codetools_0.2-20
## [27] htmltools_0.5.8.1           sass_0.4.10
## [29] RCurl_1.98-1.17             yaml_2.3.10
## [31] pillar_1.11.1               crayon_1.5.3
## [33] jquerylib_0.1.4             BiocParallel_1.44.0
## [35] DelayedArray_0.36.0         cachem_1.1.0
## [37] abind_1.4-8                 tidyselect_1.2.1
## [39] digest_0.6.37               stringi_1.8.7
## [41] purrr_1.1.0                 restfulr_0.0.16
## [43] bookdown_0.45               VariantAnnotation_1.56.0
## [45] fastmap_1.2.0               grid_4.5.1
## [47] cli_3.6.5                   SparseArray_1.10.0
## [49] magrittr_2.0.4              S4Arrays_1.10.0
## [51] GenomicFeatures_1.62.0      utf8_1.2.6
## [53] XML_3.99-0.19               withr_3.0.2
## [55] readr_2.1.5                 bit64_4.6.0-1
## [57] rmarkdown_2.30              XVector_0.50.0
## [59] httr_1.4.7                  matrixStats_1.5.0
## [61] igraph_2.2.1                bit_4.6.0
## [63] hms_1.1.4                   png_0.1-8
## [65] memoise_2.0.1               evaluate_1.0.5
## [67] knitr_1.50                  BiocIO_1.20.0
## [69] rtracklayer_1.70.0          rlang_1.1.6
## [71] glue_1.8.0                  DBI_1.2.3
## [73] BiocManager_1.30.26         jsonlite_2.0.0
## [75] R6_2.6.1                    MatrixGenerics_1.22.0
## [77] GenomicAlignments_1.46.0
```