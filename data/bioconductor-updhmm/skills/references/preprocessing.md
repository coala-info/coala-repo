# VCF Preprocessing User Guide

Marta Sevilla Porras1,2\* and Carlos Ruiz Arenas3\*\*

1Universitat Pompeu Fabra (UPF)
2Centro de Investigación Biomédica en Red (CIBERER)
3Universidad de Navarra (UNAV)

\*marta.sevilla@upf.edu
\*\*cruizarenas@unav.es

#### 30 October 2025

This vignette shows how to preprocess **individual trio VCFs** (proband, father, mother) into a clean **trio VCF** suitable for UPDhmm.

## Inputs

You should have one **VCF** (e.g. oputput from GATK) per family member:

* `proband.vcf.gz`
* `mother.vcf.gz`
* `father.vcf.gz`

Each file should be bgzipped (`.vcf.gz`) and indexed with tabix (`.tbi`).

## 0. Normalize and Left-Align Variants (optional)

For this step you will need a **reference genome FASTA** indexed with `samtools faidx`.

```
bcftools norm -m-any -f reference.fa proband.vcf.gz -Oz -o proband.norm.vcf.gz
bcftools norm -m-any -f reference.fa mother.vcf.gz  -Oz -o mother.norm.vcf.gz
bcftools norm -m-any -f reference.fa father.vcf.gz  -Oz -o father.norm.vcf.gz

tabix -p vcf proband.norm.vcf.gz
tabix -p vcf mother.norm.vcf.gz
tabix -p vcf father.norm.vcf.gz
```

## 1. Remove Extra Annotations

Keep only essential fields (drop INFO/FORMAT annotations not required downstream). The resulting VCFs are lighter.

```
# Keep only GT, AD, DP, and GQ fields (remove all other INFO)
bcftools annotate -x INFO,^FORMAT/GT,FORMAT/AD,FORMAT/DP,FORMAT/GQ \
  proband.norm.vcf.gz -Oz -o proband.clean.vcf.gz

bcftools annotate -x INFO,^FORMAT/GT,FORMAT/AD,FORMAT/DP,FORMAT/GQ \
  mother.norm.vcf.gz  -Oz -o mother.clean.vcf.gz

bcftools annotate -x INFO,^FORMAT/GT,FORMAT/AD,FORMAT/DP,FORMAT/GQ \
  father.norm.vcf.gz  -Oz -o father.clean.vcf.gz

# Index the cleaned VCFs
tabix -p vcf proband.clean.vcf.gz
tabix -p vcf mother.clean.vcf.gz
tabix -p vcf father.clean.vcf.gz
```

## 2. Merge Trio into a Single VCF

**Goal:**

* Combine the proband, mother, and father into a single VCF.
* Retain only biallelic and informative variants.
* Remove positions where all trio members are homozygous for the reference (0/0).

If the input files are **gVCFs**, you can directly merge them, as they already include all genomic positions.

```
#--------------------------------------------------------------
# Option 1: For standard VCFs
#--------------------------------------------------------------

# Merge the three individuals
bcftools merge \
  proband.clean.vcf.gz \
  mother.clean.vcf.gz \
  father.clean.vcf.gz \
 -Oz -o trio_merged_raw.vcf.gz

# Retain only biallelic variants
bcftools view -m2 -M2 trio_merged_raw.vcf.gz -Oz -o trio_merged_biallelic.vcf.gz

# Remove sites where all genotypes are homozygous reference (0/0)
bcftools view \
  -i 'COUNT(FORMAT/GT="0/0") != 3' \
  trio_merged_biallelic.vcf.gz -Oz -o trio_merged_nohom.vcf.gz

# Remove missing genotypes (./.) to keep only fully called variants
bcftools view \
  -e 'GT="./."' \
  trio_merged_nohom.vcf.gz -Oz -o trio_merged_clean.vcf.gz

#--------------------------------------------------------------
# Option 2: For gVCFs
#--------------------------------------------------------------

# gVCFs already include all genomic sites, so intersection is not needed
bcftools merge \
  proband.clean.vcf.gz \
  mother.clean.vcf.gz \
  father.clean.vcf.gz \
  -Oz -o trio_merged_raw.vcf.gz

# Retain only biallelic variants
bcftools view -m2 -M2 trio_merged_raw.vcf.gz -Oz -o trio_merged_biallelic.vcf.gz

# Remove sites where all are 0/0 (non-informative for UPD analysis)
bcftools view \
  -i 'COUNT(FORMAT/GT="0/0") != 3' \
  trio_merged_biallelic.vcf.gz -Oz -o trio_merged_clean.vcf.gz

#--------------------------------------------------------------
# Normalize and index the merged VCF
#--------------------------------------------------------------

# Normalize (split multi-allelics if any remain and remove duplicates)
bcftools norm -m -both -d all -Oz -o trio_merged_norm.vcf.gz trio_merged_clean.vcf.gz

# Index for downstream tools
tabix -p vcf trio_merged_norm.vcf.gz
```

## 3. Mask Structural Variant Regions

Before detecting UPD events, it is recommended to **exclude genomic regions** prone to alignment artifacts or abnormal variant density — such as centromeres, segmental duplications, and immune complex regions (e.g., HLA and KIR).

To simplify this step, a curated set of BED masks is available in the following Zenodo repository:

The repository provides BED files for both reference genome builds:

* `hg19_excluded_regions.bed`
* `hg38_excluded_regions.bed`

These files include merged genomic intervals covering:

* Centromeric and telomeric regions
* Segmental duplications
* HLA and KIR loci
* Low-mappability or highly repetitive regions

Download the appropriate BED file for your genome build and use it to mask excluded regions from the merged trio VCF:

```
# Mask problematic regions
bcftools view -T ^merged_mask.bed \
  trio_merged_norm.vcf.gz -Oz -o trio_masked.vcf.gz

# Index the masked VCF
tabix -p vcf trio_masked.vcf.gz
```

# Session Info

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
##  [1] karyoploteR_1.36.0          regioneR_1.42.0
##  [3] VariantAnnotation_1.56.0    Rsamtools_2.26.0
##  [5] Biostrings_2.78.0           XVector_0.50.0
##  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [9] GenomicRanges_1.62.0        IRanges_2.44.0
## [11] S4Vectors_0.48.0            Seqinfo_1.0.0
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] dplyr_1.1.4                 UPDhmm_1.6.0
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                bitops_1.0-9             gridExtra_2.3
##  [4] rlang_1.1.6              magrittr_2.0.4           biovizBase_1.58.0
##  [7] compiler_4.5.1           RSQLite_2.4.3            GenomicFeatures_1.62.0
## [10] png_0.1-8                vctrs_0.6.5              ProtGenerics_1.42.0
## [13] stringr_1.5.2            pkgconfig_2.0.3          crayon_1.5.3
## [16] fastmap_1.2.0            magick_2.9.0             backports_1.5.0
## [19] rmarkdown_2.30           UCSC.utils_1.6.0         tinytex_0.57
## [22] bit_4.6.0                xfun_0.53                cachem_1.1.0
## [25] cigarillo_1.0.0          GenomeInfoDb_1.46.0      jsonlite_2.0.0
## [28] blob_1.2.4               DelayedArray_0.36.0      BiocParallel_1.44.0
## [31] parallel_4.5.1           cluster_2.1.8.1          R6_2.6.1
## [34] bslib_0.9.0              stringi_1.8.7            RColorBrewer_1.1-3
## [37] bezier_1.1.2             rtracklayer_1.70.0       rpart_4.1.24
## [40] jquerylib_0.1.4          Rcpp_1.1.0               bookdown_0.45
## [43] knitr_1.50               base64enc_0.1-3          Matrix_1.7-4
## [46] nnet_7.3-20              tidyselect_1.2.1         rstudioapi_0.17.1
## [49] dichromat_2.0-0.1        abind_1.4-8              yaml_2.3.10
## [52] codetools_0.2-20         curl_7.0.0               lattice_0.22-7
## [55] tibble_3.3.0             KEGGREST_1.50.0          S7_0.2.0
## [58] evaluate_1.0.5           foreign_0.8-90           pillar_1.11.1
## [61] BiocManager_1.30.26      checkmate_2.3.3          RCurl_1.98-1.17
## [64] ensembldb_2.34.0         ggplot2_4.0.0            scales_1.4.0
## [67] glue_1.8.0               lazyeval_0.2.2           Hmisc_5.2-4
## [70] tools_4.5.1              BiocIO_1.20.0            data.table_1.17.8
## [73] BSgenome_1.78.0          GenomicAlignments_1.46.0 XML_3.99-0.19
## [76] grid_4.5.1               AnnotationDbi_1.72.0     colorspace_2.1-2
## [79] htmlTable_2.4.3          restfulr_0.0.16          Formula_1.2-5
## [82] cli_3.6.5                HMM_1.0.2                S4Arrays_1.10.0
## [85] AnnotationFilter_1.34.0  gtable_0.3.6             sass_0.4.10
## [88] digest_0.6.37            SparseArray_1.10.0       rjson_0.2.23
## [91] htmlwidgets_1.6.4        farver_2.1.2             memoise_2.0.1
## [94] htmltools_0.5.8.1        lifecycle_1.0.4          httr_1.4.7
## [97] bit64_4.6.0-1            bamsignals_1.42.0
```