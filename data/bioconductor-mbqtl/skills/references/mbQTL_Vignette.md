# mbQTL\_Vignette

Mercedeh Movassagh

#### 2023-02-05

#### Package

mbQTL 1.10.0

# Contents

* [1 Introduction](#introduction)
* [2 Data upload.](#data-upload.)
  + [2.1 Import data](#import-data)
* [3 Part A. Linear regression](#part-a.-linear-regression)
* [4 Part B. Correlation analysis (rho estimation)](#part-b.-correlation-analysis-rho-estimation)
* [5 Part C. Logistic Regression analysis](#part-c.-logistic-regression-analysis)

```
knitr::opts_chunk$set(
  dpi = 300,
  warning = FALSE,
  collapse = TRUE,
  error = FALSE,
  comment = "#>",
  echo = TRUE
)
library(mbQTL)
library(tidyr)

data("SnpFile")
data("microbeAbund")
data("CovFile")
data("metagenomeSeqObj")

doctype <- knitr::opts_knit$get("rmarkdown.pandoc.to")
```

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
#> [1] tidyr_1.3.1      mbQTL_1.10.0     BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6         shape_1.4.6.1        xfun_0.53
#>  [4] bslib_0.9.0          ggplot2_4.0.0        caTools_1.18.3
#>  [7] Biobase_2.70.0       lattice_0.22-7       vctrs_0.6.5
#> [10] tools_4.5.1          bitops_1.0-9         generics_0.1.4
#> [13] parallel_4.5.1       tibble_3.3.0         pkgconfig_2.0.3
#> [16] pheatmap_1.0.13      Matrix_1.7-4         KernSmooth_2.23-26
#> [19] RColorBrewer_1.1-3   S7_0.2.0             readxl_1.4.5
#> [22] lifecycle_1.0.4      stringr_1.5.2        compiler_4.5.1
#> [25] farver_2.1.2         gplots_3.2.0         statmod_1.5.1
#> [28] codetools_0.2-20     htmltools_0.5.8.1    sass_0.4.10
#> [31] yaml_2.3.10          glmnet_4.1-10        pillar_1.11.1
#> [34] jquerylib_0.1.4      MatrixEQTL_2.3       metagenomeSeq_1.52.0
#> [37] cachem_1.1.0         limma_3.66.0         iterators_1.0.14
#> [40] foreach_1.5.2        gtools_3.9.5         tidyselect_1.2.1
#> [43] locfit_1.5-9.12      digest_0.6.37        stringi_1.8.7
#> [46] dplyr_1.1.4          purrr_1.1.0          bookdown_0.45
#> [49] splines_4.5.1        fastmap_1.2.0        grid_4.5.1
#> [52] cli_3.6.5            magrittr_2.0.4       dichromat_2.0-0.1
#> [55] survival_3.8-3       broom_1.0.10         scales_1.4.0
#> [58] backports_1.5.0      Wrench_1.28.0        rmarkdown_2.30
#> [61] matrixStats_1.5.0    cellranger_1.1.0     evaluate_1.0.5
#> [64] knitr_1.50           rlang_1.1.6          Rcpp_1.1.0
#> [67] glue_1.8.0           BiocManager_1.30.26  BiocGenerics_0.56.0
#> [70] jsonlite_2.0.0       R6_2.6.1
```

# 1 Introduction

`mbQTL` is a statistical package for identifying significant taxa (microbial),
snp (genotype) relationships across large sample sets. The package measures
this relationship using three different approaches. A) linear regression analysis
which uses core `MatrixeQTL` model. B) rho estimation for correlation of taxa and SNP,
which is a novel method of estimating rho values after R value of taxa-taxa is
estimated then adjusted for association of taxa-SNP. Using this method various
taxa-SNP associations can be estimated simultaneously, and linkage disequilibrium (LD)
snps and regions can be identified in terms of presence and their associations with
snps (see section for more details). C) Utilizing Logistic regression analysis, we
estimate the relationship of one snp and one taxa across the sample cohort but
simultaneously this could be estimated for all samples and proper statistics is
produced from these regressions. Appropriate plots are generated for all three
methods utilized in this vignette and are part of the package to simplify
visualization.

# 2 Data upload.

The datasets used for this vignette are all simulated and are not factual. The “Taxa\_table\_MVP\_cor.txt”
and “SNP\_table\_MVP\_cor.txt” are used in all three sections mentioned above and the “covariates.txt”
file is used for section A)linear regression. The input file format for “SNP\_table\_MVP\_cor.txt”
should be colnames with SNP names/locations/rs\_numbers and rownames needs to be sample number.
For the “Taxa\_table\_MVP\_cor.txt” the colnames is the microbe name and the row name is the sample
number and finally for the “covariates.txt” file the colnames need to be samplenames and the
rownames need to be the covariates. Please ensure all 3 files are matching in terms of sample
number and are appropriately formatted to avoid errors in your analysis.

## 2.1 Import data

mbQTL accepts data in dataframe, `MRexperiment` objects or table formats. The files
are accessible when the `mbQTL` library is loaded. We have also created a larger simulated
data set of 500 SNPs and 500 pathogens for 500 patients which can be accessed and
downloaded from <https://doi.org/10.18129/B9.bioc.mbQTL>.
The whole data set can be run with an average memory of 90MB in less than 2
minutes for all models.
The input files are microbial abundance file (rownames taxa, colnames sample
names) and SnpFile (rownames snps and colnames sample names) with optional
“CovFile”(rownames covariates and colnames sample names) ( note all samples should
be concordant in the three data sets). Note, the data can be imported as
an R object using either upload() or if RDS file, readRDS(). If the the
the data is a data frame in text format it can be uploaded using read.table(),
in a tab separated manner, if excel, the user can use the read\_excel()
function from readxl package. Alternatively, read.csv() can be used for
import of a csv file.

```
# microbial count file
# microbeAbund
# SNP file
# SnpFile
# Covariance file
# CovFile

#Check out file formats compatible with mbQTL files.

#head(microbeAbund)
#head(SnpFile)
#head(CovFile)

metagenomeSeqObj
#> MRexperiment (storageMode: environment)
#> assayData: 1313 features, 93 samples
#>   element names: counts
#> protocolData: none
#> phenoData
#>   sampleNames: 2001 2002 ... 2091 (93 total)
#>   varLabels: ID Sample_Type ... Spike_in (15 total)
#>   varMetadata: labelDescription
#> featureData
#>   featureNames: 1595f09bb28c3e40d9779b2ed6e0c1eb
#>     cf3950eea7fd94bf5f51936de1c6bd5d ...
#>     fabc9190fc0e035265780a5c5a589b62 (1313 total)
#>   fvarLabels: OTUname Kingdom ... Species (8 total)
#>   fvarMetadata: labelDescription
#> experimentData: use 'experimentData(object)'
#> Annotation:
```

If the user has an MRexperiment microbiome file (`metagenomeSeq` formatted), one can
use the following function to normalize their `metagenomeSeq` object or aggregate based
on various taxonomic levels before normalization.
The output will be formatted in compatible data frame format for `mbQTL`. If one has
a `phyloseq` S4 object, they can use the `phyloseq_to_metagenomeSeq()` option of the
`phyloseq` package and start from there.

```
compatible_metagenome_seq <- metagenomeSeqToMbqtl(metagenomeSeqObj,
  norm = TRUE, log = TRUE,
  aggregate_taxa = "Genus"
)
#> Default value being used.

# Check for the class of compatible_metagenome_seq

class(compatible_metagenome_seq)
#> [1] "data.frame"
```

# 3 Part A. Linear regression

Linear regression analysis to identify significant association between taxa and
SNPs across large sample sized. P values FDRs, Pvalue histogram plots and QQ-plots
are provided for various taxa and SNP regression analysis performed. microbeAbund
is the taxa abundance file, SnpFile us file across samples (0,1,2 (reference,
heterozygous and alternate genotype). `MatrixeQTL` makes its estimations assuming
three different models of which we employ two, a) assumption of simple linear
regression for each gene and SNV pair The first approach is a very similar approach
to that of the expression quantitative trait loci association (eQTL). b) regression
model with covariates (Shabalin, 2012).

Note: The main assumption behind this model is, Abundance of taxa association with
presence of SNV/SNP across cohorts of samples.

```
# perform linear regression analysis between taxa and snps across
# samples and produce a data frame of results.(covariate file is
# optional but highly recommended to avoid results which might be
# prone to batch effects and obtaining optimal biological relevance
# for finding snp - taxa relationships.)

LinearAnalysisTaxaSNP <- linearTaxaSnp(microbeAbund,
  SnpFile,
  Covariate = CovFile
)
#> Processing covariates
#> Task finished in 0.002 seconds
#> Processing gene expression data (imputation, residualization)
#> Task finished in 0.005 seconds
#> Creating output file(s)
#> Task finished in 0.01 seconds
#> Performing eQTL analysis
#> 100.00% done, 169 eQTLs
#> Task finished in 0.015 seconds
#>
```

```
# Create a histogram of P values across all snp - taxa
# linear regression estimations

histPvalueLm(LinearAnalysisTaxaSNP)
```

![](data:image/png;base64...)

```
# Create a QQPlot of expected versus estimated P value for all all
# snp - taxa linear regression estimations

qqPlotLm(microbeAbund, SnpFile, Covariate = CovFile)
#> Processing covariates
#> Task finished in 0.001 seconds
#> Processing gene expression data (imputation, residualization)
#> Task finished in 0.004 seconds
#> Creating output file(s)
#> Task finished in 0.01 seconds
#> Performing eQTL analysis
#> 100.00% done, 0 eQTLs
#> No significant associations were found.
#> 4
#> Task finished in 0.005 seconds
#>
```

![](data:image/png;base64...)

# 4 Part B. Correlation analysis (rho estimation)

Estimate taxa-taxa correlation (microbeAbund (taxa abundance file)) and estimate R
(Strength of the relationship between taxa `x` and `y`). In other words we estimate
Goodness of fits, as a measure of a feature’s association with host genetics
(Significant SNPs) association with taxa (matching 16S results). In details we
measure the strength of relationship between taxa `x` and taxa `y` (R correlation value),
next we measure goodness of fits R2 and ask to what extent the variance in one taxa
explains the variance in a SNP, and finally we find clusters of taxa associated with
various SNPs across the dataset by evaluating and controlling for both these measures
together and finally estimating rho value.

Note: The main idea behind this approach estimating strength of a correlation
between SNP-Taxa and Taxa-Taxa ( communities of bacteria/organisms).

```
# Estimate taxa SNP - taxa correlation R and estimate R2
# (To what extent variance in one taxa explains the
# variance in snp)

# First estimate R value for all SNP-Taxa relationships

correlationMicrobes <- coringTaxa(microbeAbund)

# Estimate the correlation value (R2) between a specific snp and all taxa.

one_rs_id <- allToAllProduct(SnpFile, microbeAbund, "chr1.171282963_T")

# Estimate the correlation value (R2) between all snps and all taxa.

for_all_rsids <- allToAllProduct(SnpFile, microbeAbund)

# Estimate rho value for all snps and all taxa present in the dataset.

taxa_SNP_Cor <- taxaSnpCor(for_all_rsids, correlationMicrobes)

# Estimate rho value for all snps and all taxa present in the
# dataset and pick the highest and lowest p values in the
# dataset to identify improtant SNP-Taxa relationships.

taxa_SNP_Cor_lim <- taxaSnpCor(for_all_rsids,
  correlationMicrobes,
  probs = c(0.0001, 0.9999)
)
```

```
## Draw heatmap of rho estimates "taxa_SNP_Cor_lim" is the
# output of taxaSnpCor().
# One can use other pheatmap() settings for extra annotation

mbQtlCorHeatmap(taxa_SNP_Cor_lim,
  fontsize_col = 5,
  fontsize_row = 7
)
```

![](data:image/png;base64...)

# 5 Part C. Logistic Regression analysis

SNPs and then Genus/species (categorical(presence/absence)) as expression.
For this we need to binarize out taxa abundance file based on a cutoff to a
zero or one or presence or absence format. We assume a presence and absence
binary/categorical relationship between every taxa and SNP pair and use a
logistic regression model to identify significance taxa-SNP relationships.

Note: The main hypothesis behind this approach is there an association between
presence of taxa (present/absent) and SNV/SNP.

```
# perform Logistic regression analysis between taxa and snps
# across samples microbeAbund is the microbe abundance file
# (a dateframe with rownames as taxa and colnames and sample
# names) and SnpFile is the snp file (0,1,2) values
# (rownames as snps and colnames as samples)

log_link_resA <- logRegSnpsTaxa(microbeAbund, SnpFile)

# Perform Logistic regression for specific microbe

log_link_resB <- logRegSnpsTaxa(microbeAbund, SnpFile,
  selectmicrobe = c("Haemophilus")
)
```

```
# Create a barplot with the specific rsID, and microbe of interest,
# including the genotype information for the reference versus
# alternate versus hetrozygous alleles and and presence absence
# of microbe of interest. Note your reference, alternative and
# heterozygous genotype values need to match the genotype of
# your SNP of interest this information can be obtained
# from snpdb data base or GATK/plink files.

Logit_plot <- logitPlotSnpTaxa(microbeAbund, SnpFile,
  selectmicrobe = "Neisseria",
  rsID = "chr2.241072116_A", ref = "GG", alt = "AA", het = "AG"
)

Logit_plot
```

![](data:image/png;base64...)