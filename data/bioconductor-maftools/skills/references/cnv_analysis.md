# Copy number analysis

#### Anand Mayakonda

#### 2025-10-30

```
library(maftools)
```

Note: This vignette was not evaluated.

# 1 Introduction

`maftools` provides a set of functions to facilitate copy number analysis using [ASCAT](https://github.com/VanLoo-lab/ascat) for tumor-normal or tumor-only WGS datasets. Although there exists [ascatNgs](https://github.com/cancerit/ascatNgs), it requires the installation of Perl and C modules to fetch the read counts across the markers. `maftools` bypass these requirements entirely within R with the C code baked in. However, `maftools` only generates the required read counts, BAF, and logR files. Downstream analyses have to be done with [ASCAT](https://github.com/VanLoo-lab/ascat).

ASCAT is not available on CRAN or Bioconductor and needs to be installed from [GitHub](https://github.com/VanLoo-lab/ascat)

```
remotes::install_github(repo = 'VanLoo-lab/ascat/ASCAT')
```

If you use `maftools` functions for CNV analysis, please cite the ASCAT publication

|  |
| --- |
| ***Van Loo P, Nordgard SH, Lingjærde OC, et al. Allele-specific copy number analysis of tumors. Proc Natl Acad Sci U S A. 2010;107(39):16910-16915. doi:10.1073/pnas.1009843107*** |

# 2 Step-1: Get nucleotide counts for genetic markers

Below command will generate two tsv files `tumor_nucleotide_counts.tsv` and `normal_nucleotide_counts.tsv` that can be used for downstream analysis. Note that the function will process ~900K SNPs from [Affymetrix Genome-Wide Human SNP 6.0 Array](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GPL6801). The process can be sped up linearly by increasing `nthreads` which will launch each chromosome on a separate thread. Currently `hg19` and `hg38` are supported.

```
#Matched normal BAM files are strongly recommended
counts = maftools::gtMarkers(t_bam = "tumor.bam",
                             n_bam = "normal.bam",
                             build = "hg19")
```

# 3 Step-2: Prepare input files for ASCAT with `prepAscat()`

## 3.1 Tumor-Normal pair

Below command takes `tumor_nucleotide_counts.tsv` and `normal_nucleotide_counts.tsv` files, filter SNPs with low coverage (default <15), estimate BAF, logR, and generates the input files for ASCAT.

```
library(ASCAT)
ascat.bc = maftools::prepAscat(t_counts = "tumor_nucleotide_counts.tsv",
                               n_counts = "normal_nucleotide_counts.tsv",
                               sample_name = "tumor")

# Library sizes:
# Tumor:  1830168947
# Normal: 1321201848
# Library size difference: 1.385
# ------
# Counts file: tumor_nucleotide_counts.tsv
# Markers: 932148
# Removed 2982 duplicated loci
# Markers > 15: 928607
# ------
# Counts file: normal_nucleotide_counts.tsv
# Markers: 932148
# Removed 2982 duplicated loci
# Markers > 15: 928311
# ------
# Final number SNPs: 928107
# Generated following files:
# tumor_nucleotide_counts.tumour.BAF.txt
# tumor_nucleotide_counts.tumour.logR.txt
# tumor_nucleotide_counts.normal.BAF.txt
# tumor_nucleotide_counts.normal.logR.txt
# ------
```

Generated BAF and logR files can be processed with [ASCAT functions](https://www.crick.ac.uk/research/labs/peter-van-loo/software). The below code chunk shows minimal usage with ASCAT. See [here](https://github.com/VanLoo-lab/ascat/tree/master/ExampleData) for further workflow examples.

```
ascat.bc = ASCAT::ascat.loadData(
  Tumor_LogR_file = "tumor_nucleotide_counts.tumour.logR.txt",
  Tumor_BAF_file = "tumor_nucleotide_counts.tumour.BAF.txt",
  Germline_LogR_file = "tumor_nucleotide_counts.normal.logR.txt",
  Germline_BAF_file = "tumor_nucleotide_counts.normal.BAF.txt",
  chrs = c(1:22, "X", "Y"),
  sexchromosomes = c("X", "Y")
)

ASCAT::ascat.plotRawData(ASCATobj = ascat.bc, img.prefix = "tumor")
ascat.bc = ASCAT::ascat.aspcf(ascat.bc)
ASCAT::ascat.plotSegmentedData(ascat.bc)
ascat.output = ASCAT::ascat.runAscat(ascat.bc)
```

## 3.2 Tumor only

In tumor-only mode, read counts are normalized for median depth of coverage across autosomes.

```
ascat.bc = maftools::prepAscat_t(t_counts = "tumor_nucleotide_counts.tsv", sample_name = "tumor_only")

# Library sizes:
# Tumor: 1830168947
# Counts file: tumor_nucleotide_counts.tsv
# Markers: 932148
# Removed 2982 duplicated loci
# Markers > 15: 928607
# Median depth of coverage (autosomes): 76
# ------
# Generated following files:
# tumor_only.tumour.BAF.txt
# tumor_only.tumour.logR.txt
# ------
```

The output logR and BAF files can be processed with *ASCAT without matched normal data protocol*:

```
ascat.bc = ASCAT::ascat.loadData(
  Tumor_LogR_file = "tumor_only.tumour.logR.txt",
  Tumor_BAF_file = "tumor_only.tumour.BAF.txt",
  chrs = c(1:22, "X", "Y"),
  sexchromosomes = c("X", "Y")
)

ASCAT::ascat.plotRawData(ASCATobj = ascat.bc, img.prefix = "tumor_only")
ascat.gg = ASCAT::ascat.predictGermlineGenotypes(ascat.bc)
ascat.bc = ASCAT::ascat.aspcf(ascat.bc, ascat.gg=ascat.gg)
ASCAT::ascat.plotSegmentedData(ascat.bc)
ascat.output = ASCAT::ascat.runAscat(ascat.bc)
```

## 3.3 CBS segmentation

Alternatively, tumor logR files generated by `prepAscat()`/`prepAscat_t()` can be processed with `segmentLogR()` function that performs circular binary segmentation and returns the [DNAcopy](https://bioconductor.org/packages/release/bioc/html/DNAcopy.html) object.

```
maftools::segmentLogR(tumor_logR = "tumor.tumour.logR.txt", sample_name = "tumor")

# Analyzing: tumor
#   current chromosome: 1
#   current chromosome: 2
#   current chromosome: 3
#   current chromosome: 4
#   current chromosome: 5
#   current chromosome: 6
#   current chromosome: 7
#   current chromosome: 8
#   current chromosome: 9
#   current chromosome: 10
#   current chromosome: 11
#   current chromosome: 12
#   current chromosome: 13
#   current chromosome: 14
#   current chromosome: 15
#   current chromosome: 16
#   current chromosome: 17
#   current chromosome: 18
#   current chromosome: 19
#   current chromosome: 20
#   current chromosome: 21
#   current chromosome: 22
#   current chromosome: MT
#   current chromosome: X
#   current chromosome: Y
# Segments are written to: tumor_only.tumour_cbs.seg
# Segments are plotted to: tumor_only.tumour_cbs.png
```

# 4 Processing Mosdepth output

[Mosdepth](https://github.com/brentp/mosdepth) offers the fastest way to estimate coverage metrics from WGS bam files. Output generated by mosdepth can be processed with maftools function `plotMosdepth` and `plotMosdepth_t` for CNV analysis by performing segmentation and plotting.

Below `mosdepth` command generates `tumor.regions.bed.gz` and `normal.regions.bed.gz` that contains depth of coverage across the genome in fixed windows.

```
mosdepth -n -b 5000 tumor tumor.bam
mosdepth -n -b 5000 normal normal.bam
```

The output `{prefix}.regions.bed.gz` can be imported and analyzed with `maftools` in tumor/normal or tumor only mode.

If you use the functions for CNV analysis, please cite the mosdepth publication

|  |
| --- |
| ***Pedersen BS, Quinlan AR. Mosdepth: quick coverage calculation for genomes and exomes. Bioinformatics. 2018;34(5):867-868. doi:10.1093/bioinformatics/btx699*** |

## 4.1 Tumor normal pair

```
plotMosdepth(
  t_bed = "tumor.regions.bed.gz",
  n_bed = "normal.regions.bed.gz",
  segment = TRUE,
  sample_name = "tumor"
)

# Coverage ratio T/N: 1.821
# Running CBS segmentation:
# Analyzing: tumor01
#   current chromosome: 1
#   current chromosome: 2
#   current chromosome: 3
#   current chromosome: 4
#   current chromosome: 5
#   current chromosome: 6
#   current chromosome: 7
#   current chromosome: 8
#   current chromosome: 9
#   current chromosome: 10
#   current chromosome: 11
#   current chromosome: 12
#   current chromosome: 13
#   current chromosome: 14
#   current chromosome: 15
#   current chromosome: 16
#   current chromosome: 17
#   current chromosome: 18
#   current chromosome: 19
#   current chromosome: 20
#   current chromosome: 21
#   current chromosome: 22
#   current chromosome: X
#   current chromosome: Y
# Segments are written to: tumor01_cbs.seg
# Plotting
```

![](data:image/png;base64...)

## 4.2 Tumor only

Above tumor sample without the germline control, normalized for median depth of coverage

```
plotMosdepth_t(bed = "tumor.regions.bed.gz")
```

![](data:image/png;base64...)

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
#> [1] maftools_2.26.0
#>
#> loaded via a namespace (and not attached):
#>  [1] digest_0.6.37      RColorBrewer_1.1-3 R6_2.6.1           fastmap_1.2.0
#>  [5] Matrix_1.7-4       xfun_0.53          lattice_0.22-7     splines_4.5.1
#>  [9] cachem_1.1.0       knitr_1.50         htmltools_0.5.8.1  rmarkdown_2.30
#> [13] lifecycle_1.0.4    cli_3.6.5          grid_4.5.1         sass_0.4.10
#> [17] data.table_1.17.8  jquerylib_0.1.4    compiler_4.5.1     tools_4.5.1
#> [21] evaluate_1.0.5     bslib_0.9.0        survival_3.8-3     yaml_2.3.10
#> [25] DNAcopy_1.84.0     rlang_1.1.6        jsonlite_2.0.0
```