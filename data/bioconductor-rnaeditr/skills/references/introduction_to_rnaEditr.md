# Introduction to rnaEditr

#### Lanyu Zhang, Gabriel Odom, Lily Wang

#### 2025-10-30

* [1 Installation](#installation)
* [2 Datasets](#datasets)
* [3 Site-specific analysis](#site-specific-analysis)
  + [3.1 Testing all edited sites](#testing-all-edited-sites)
  + [3.2 Annotate results](#annotate-results)
* [4 Region-based analysis](#region-based-analysis)
  + [4.1 Input regions](#input-regions)
  + [4.2 Find close-by regions](#find-close-by-regions)
  + [4.3 Find co-edited regions](#find-co-edited-regions)
  + [4.4 Summarize all regions](#summarize-all-regions)
  + [4.5 Test all regions](#test-all-regions)
  + [4.6 Annotate results](#annotate-results-1)
* [5 Further examples of function `TestAssociations` in `rnaEditr`](#further-examples-of-function-testassociations-in-rnaeditr)
* [6 Session information](#session-information)

`rnaEditr` is an R package that identifies genomic sites and genomic regions that are differentially edited in RNA-seq datasets. `rnaEditr` can analyze studies with continuous, binary, or survival phenotypes, along with multiple covariates and/or interaction effects. To identify hyper-edited regions, `rnaEditr` first determines co-edited sub-regions without using any phenotype information. Next, `rnaEditr` tests association between RNA editing levels within the co-edited regions with binary, continuous or survival phenotypes.

# 1 Installation

The latest version can be installed by:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rnaEditr")
```

After installation, the `rnaEditr` package can be loaded into R using:

```
library(rnaEditr)
```

# 2 Datasets

The input of `rnaEditr` are: (1) an RNA editing dataset, with rows corresponding to the edited sites and columns corresponding to the samples; (2) a phenotype dataset, with rows corresponding to different samples, ordered in the same way as columns of dataset (1); (3) a character string of genomic regions that users are interested in. This is only required for region-based analysis and will be explained in section 4.1.

The first dataset includes RNA editing levels for each sample at each edited site. RNA editing levels are typically defined as the total number of edited reads (i.e. reads with G nucleotides) divided by the total number of reads covering the site (i.e. reads with A and G nucleotides) (Breen et al. 2019 PMID: 31455887). They range from 0 (un-edited site) to 1 (completely edited site).

We assume quality control and normalization of the RNA editing dataset have been performed, and that each site is edited in at least 5% of the samples. For illustration, we use a subset of the TCGA breast cancer RNA editing dataset (syn 2374375). This example dataset includes RNA editing levels for 272 edited sites mapped to genes *PHACTR4*, *CCR5*, *METTL7A* (using hg19 reference), along with a few randomly sampled sites, for 221 subjects.

```
data(rnaedit_df)
```

```
rnaedit_df[1:3, 1:3]
```

```
##               BRCA-Tumor-TCGA-AC-A2FF BRCA-Normal-TCGA-AC-A2FF
## chr1:28661572              0.00000000                0.0000000
## chr1:28661576              0.64285714                0.6307692
## chr1:28661578              0.01923077                0.0000000
##               BRCA-Normal-TCGA-BH-A0AU
## chr1:28661572                0.0000000
## chr1:28661576                0.5333333
## chr1:28661578                0.0000000
```

In order to link the RNA editing dataset with phenotype data, the phenotype dataset needs to have a column called `sample`, whose values must be a exact match to the column names in the above RNA editing dataset.

```
pheno_df <- readRDS(
  system.file(
    "extdata",
    "pheno_df.RDS",
    package = 'rnaEditr',
    mustWork = TRUE
  )
)
```

```
pheno_df[1:3, 1:3]
```

```
##   submitter_id                   sample         sample_type
## 1 TCGA-AC-A2FF  BRCA-Tumor-TCGA-AC-A2FF       Primary Tumor
## 2 TCGA-AC-A2FF BRCA-Normal-TCGA-AC-A2FF Solid Tissue Normal
## 3 TCGA-BH-A0AU BRCA-Normal-TCGA-BH-A0AU Solid Tissue Normal
```

Here we are using the command below to make sure `sample` variable in phenotype dataset has a exact match to the column names in the RNA editing dataset.

```
identical(pheno_df$sample, colnames(rnaedit_df))
```

```
## [1] TRUE
```

`rnaEditr` can perform both site-specific and region-based analysis. In Section 3, we illustrate testing associations between cancer status and RNA editing levels at individual sites. In Section 4, we illustrate identifying cancer associated co-edited regions.

# 3 Site-specific analysis

![](data:image/png;base64...)

A quick workflow for site-specific analysis

## 3.1 Testing all edited sites

Before testing the associations, we use function `CreateEditingTable()` to turn RNA editing matrix into a dataframe with special class `rnaEdit_df`, which is a required format of input dataset for function `TestAssociations()`.

```
rnaedit2_df <- CreateEditingTable(
  rnaEditMatrix = rnaedit_df
)
```

In this example, we will test the association between cancer status ( `sample_type` variable from `pheno_df` dataset) and all edited sites. Because the outcome variable “cancer status” is a binary variable, `rnaEditr` will apply a logistic regression model for each site: \[logit(Pr(cancer\;status = “yes”)) \sim RNA\;editing\;level\]

First, we use the command below to check the distribution of variable `sample_type`. Please note that `rnaEditr` will fit firth corrected logistic regression instead of regular logistic regression models for binary outcomes, when the minimum sample size per group is less than 5.

```
table(pheno_df$sample_type)
```

```
##
##       Primary Tumor Solid Tissue Normal
##                 182                  39
```

```
tumor_single_df <- TestAssociations(
  # an RNA editing dataframe with special class "rnaEdit_df" from function
  #   CreateEditingTable() if site-specific analysis, from function
  #   SummarizeAllRegions() if region-based analysis.
  rnaEdit_df = rnaedit2_df,
  # a phenotype dataset that must have variable "sample" whose values are a
  #   exact match to the colnames of "rnaEdit_df".
  pheno_df = pheno_df,
  # name of outcome variable in phenotype dataset "pheno_df" that you want to
  #   test.
  responses_char = "sample_type",
  # names of covariate variables in phenotype dataset "pheno_df" that you want
  #   to add into the model.
  covariates_char = NULL,
  # type of outcome variable that you input in argument "responses_char".
  respType = "binary",
  # order the final results by p-values or not.
  orderByPval = TRUE
)
```

```
tumor_single_df[1:3, ]
```

```
##     seqnames    start      end width  estimate   stdErr       pValue
## 225    chr12 51324639 51324639     1 -19.66360 3.158016 4.767627e-10
## 42      chr1 28662199 28662199     1 -14.83609 2.399372 6.276575e-10
## 178    chr12 51324163 51324163     1 -42.69833 7.221196 3.361021e-09
##              fdr
## 225 8.536142e-08
## 42  8.536142e-08
## 178 2.978449e-07
```

Here `tumor_single_df` is a data frame of all edited sites, with corresponding p-values and false discovery rate (FDRs) from the logistic regression model.

## 3.2 Annotate results

We next annotate these results by adding gene names mapped to the RNA editing sites.

```
tumor_annot_df <- AnnotateResults(
  # the output dataset from function TestAssociations().
  results_df = tumor_single_df,
  # close-by regions, since this is site-specific analysis, set to NULL.
  closeByRegions_gr = NULL,
  # input regions, since this is site-specific analysis, set to NULL.
  inputRegions_gr = NULL,
  genome = "hg19",
  # the type of analysis result from function TestAssociations(), since we are
  #   running site-specific analysis, set to "site-specific".
  analysis = "site-specific"
)
```

```
tumor_annot_df[1:3, ]
```

```
##   seqnames    start      end width  symbol  estimate   stdErr       pValue
## 1    chr12 51324639 51324639     1 METTL7A -19.66360 3.158016 4.767627e-10
## 2     chr1 28662199 28662199     1   MED18 -14.83609 2.399372 6.276575e-10
## 3    chr12 51324163 51324163     1 METTL7A -42.69833 7.221196 3.361021e-09
##            fdr
## 1 8.536142e-08
## 2 8.536142e-08
## 3 2.978449e-07
```

# 4 Region-based analysis

![](data:image/png;base64...)

A quick workflow for region-based analysis

The region-based analysis consists of several steps: (1) make GRanges object for the genomic regions, (2) determine RNA editing sites that are located closely within the genomic regions, (3) identify co-edited regions, and (4) test the association between cancer status and co-edited regions.

## 4.1 Input regions

First, we make GRanges object for the genomic regions that we are interested in . We saved both hg19 and hg38 gene references in the package. The following command retrieves regions associated with 20,314 pre-processed hg19 genes. To retrieve hg38 gene reference, easily change “hg19\_annoGene\_gr.RDS” into “hg38\_annoGene\_gr.RDS” in the command below.

```
allGenes_gr <- readRDS(
  system.file(
    "extdata",
    "hg19_annoGene_gr.RDS",
    package = 'rnaEditr',
    mustWork = TRUE
  )
)
```

```
allGenes_gr[1:3]
```

```
## GRanges object with 3 ranges and 2 metadata columns:
##       seqnames              ranges strand | ensembl_gene_id      symbol
##          <Rle>           <IRanges>  <Rle> |     <character> <character>
##   [1]     chr1   45959538-45965751      * | ENSG00000236624    CCDC163P
##   [2]     chr1   44457031-44462200      * | ENSG00000159214      CCDC24
##   [3]     chr1 148555979-148596267      * | ENSG00000243452      NBPF15
##   -------
##   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

For candidate gene studies, we are often only interested in a few specific genes. We can use the following commands to extract GRanges associated with the specific genes:

```
# If input is gene symbol
inputGenes_gr <- TransformToGR(
  # input a character vector of gene symbols
  genes_char = c("PHACTR4", "CCR5", "METTL7A"),
  # the type of "gene_char". As we input gene symbols above, set to "symbol"
  type = "symbol",
  genome = "hg19"
)
```

```
inputGenes_gr
```

```
## GRanges object with 3 ranges and 1 metadata column:
##       seqnames            ranges strand |     symbols
##          <Rle>         <IRanges>  <Rle> | <character>
##   [1]     chr1 28696114-28826881      * |     PHACTR4
##   [2]     chr3 46411633-46417697      * |        CCR5
##   [3]    chr12 51317255-51326300      * |     METTL7A
##   -------
##   seqinfo: 3 sequences from an unspecified genome; no seqlengths
```

If we’re interested in particular regions, we can use the following commands to make GRanges.

```
# If input is region ranges
inputRegions_gr <- TransformToGR(
  # input a character vector of region ranges.
  genes_char = c("chr22:18555686-18573797", "chr22:36883233-36908148"),
  # the type of "gene_char". As we input region ranges above, set to "region".
  type = "region",
  genome = "hg19"
)

# Here we use AddMetaData() to find the gene symbols for inputRegions_gr.
AddMetaData(target_gr = inputRegions_gr, genome = "hg19")
```

```
## GRanges object with 2 ranges and 1 metadata column:
##       seqnames            ranges strand |        symbol
##          <Rle>         <IRanges>  <Rle> |   <character>
##   [1]    chr22 18555686-18573797      * |         PEX26
##   [2]    chr22 36883233-36908148      * | FOXRED2;EIF3D
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 4.2 Find close-by regions

Next, within each input candidate region, we identify the sub-regions that contain closely located RNA editing sites. At default, we identify sub-regions with at least 3 edited sites, for which maximum distance between two neighboring sites is 50 bp.

```
closeByRegions_gr <- AllCloseByRegions(
  # a GRanges object of genomic regions retrieved or created in section 4.1.
  regions_gr = inputGenes_gr,
  # an RNA editing matrix.
  rnaEditMatrix = rnaedit_df,
  maxGap = 50,
  minSites = 3
)
```

```
closeByRegions_gr
```

```
## GRanges object with 8 ranges and 0 metadata columns:
##       seqnames            ranges strand
##          <Rle>         <IRanges>  <Rle>
##   [1]     chr1 28823903-28823966      *
##   [2]     chr1 28824256-28824490      *
##   [3]     chr1 28825317-28825530      *
##   [4]     chr1 28825670-28825927      *
##   [5]     chr1 28826015-28826284      *
##   [6]     chr3 46417171-46417221      *
##   [7]    chr12 51324081-51324639      *
##   [8]    chr12 51325229-51325622      *
##   -------
##   seqinfo: 3 sequences from an unspecified genome; no seqlengths
```

`closeByRegions_gr` is a GRanges object that includes sub-regions that contain closely located RNA editing sites (close-by regions). In this example, within the three input candidate regions, 8 close-by regions were found.

## 4.3 Find co-edited regions

Next, within each close-by region, we identify co-edited regions based on RNA editing levels. At default, a co-edited region needs to satisfy the following requirements: (1) with at least 3 edited sites; (2) the minimum correlation between RNA editing levels of one site and the mean RNA editing levels of the rest of the sites is at least 0.4; (3) the minimum pairwise correlation of sites within the selected cluster is at least 0.1.

```
closeByCoeditedRegions_gr <- AllCoeditedRegions(
  # a GRanges object of close-by regions created by AllCloseByRegions().
  regions_gr = closeByRegions_gr,
  # an RNA editing matrix.
  rnaEditMatrix = rnaedit_df,
  # type of output data.
  output = "GRanges",
  rDropThresh_num = 0.4,
  minPairCorr = 0.1,
  minSites = 3,
  # the method for computing correlations.
  method = "spearman",
  # When no co-edited regions are found in an input genomic region, you want to
  #   output the whole region (when set to TRUE) or NULL (when set to FALSE).
  returnAllSites = FALSE
)
```

```
closeByCoeditedRegions_gr
```

```
## GRanges object with 14 ranges and 0 metadata columns:
##        seqnames            ranges strand
##           <Rle>         <IRanges>  <Rle>
##    [1]     chr1 28825317-28825370      *
##    [2]     chr1 28825394-28825403      *
##    [3]     chr1 28825670-28825717      *
##    [4]     chr1 28825899-28825927      *
##    [5]     chr1 28826150-28826173      *
##    ...      ...               ...    ...
##   [10]    chr12 51324308-51324436      *
##   [11]    chr12 51324447-51324467      *
##   [12]    chr12 51324545-51324585      *
##   [13]    chr12 51324604-51324627      *
##   [14]    chr12 51325324-51325383      *
##   -------
##   seqinfo: 3 sequences from an unspecified genome; no seqlengths
```

`closeByCoeditedRegions_gr` is a GRanges that contains co-edited regions within the close-by regions we found from last step. We identified 14 co-edited regions from the 8 close-by regions.

Let’s take a look at correlations of RNA editing levels within the first co-edited region:

```
PlotEditingCorrelations(
  region_gr = closeByCoeditedRegions_gr[1],
  rnaEditMatrix = rnaedit_df
)
```

![](data:image/png;base64...)

## 4.4 Summarize all regions

Next, we summarize RNA editing levels from multiple edited sites within each co-edited region using medians.

```
summarizedRegions_df <- SummarizeAllRegions(
  # a GRanges object of close-by regions created by AllCoeditedRegions().
  regions_gr = closeByCoeditedRegions_gr,
  # an RNA editing matrix.
  rnaEditMatrix = rnaedit_df,
  # available methods: "MaxSites", "MeanSites", "MedianSites", and "PC1Sites".
  selectMethod = MedianSites
)
```

```
summarizedRegions_df[1:3, 1:5]
```

```
##   seqnames    start      end width BRCA-Tumor-TCGA-AC-A2FF
## 1     chr1 28825317 28825370    54              0.10618417
## 2     chr1 28825394 28825403    10              0.00000000
## 3     chr1 28825670 28825717    48              0.08602151
```

`summarizedRegions_df` is a data frame with each row corresponding to one co-edited region identified from function `AllCoeditedRegions()`. Since there are 14 co-edited regions, this data frame has 14 rows. In column 5 to the end, each column includes median editing levels (over all sites within each co-edited region) for one sample.

## 4.5 Test all regions

Next, we test the association between cancer status and co-edited regions using logistic regression model: \[logit (Pr(sample\;type = “cancer”)) \sim median\;RNA\;editing\;levels\]

```
tumor_region_df <- TestAssociations(
  # an RNA editing dataframe with special class "rnaEdit_df" from function
  #   CreateEditingTable() if site-specific analysis, from function
  #   SummarizeAllRegions() if region-based analysis.
  rnaEdit_df = summarizedRegions_df,
  # a phenotype dataset that must have variable "sample" whose values are a
  #   exact match to the colnames of "rnaEdit_df".
  pheno_df = pheno_df,
  # name of outcome variable in phenotype dataset "pheno_df" that you want to
  #   test.
  responses_char = "sample_type",
  # names of covariate variables in phenotype dataset "pheno_df" that you want
  #   to add into the model.
  covariates_char = NULL,
  # type of outcome variable that you input in argument "responses_char".
  respType = "binary",
  # order the final results by p-values or not.
  orderByPval = TRUE
)
```

```
tumor_region_df[1:3, ]
```

```
##    seqnames    start      end width   estimate    stdErr       pValue
## 8     chr12 51324085 51324127    43  -51.23815  8.736146 4.489288e-09
## 14    chr12 51325324 51325383    60  -94.78676 16.738315 1.488692e-08
## 11    chr12 51324447 51324467    21 -102.71801 18.271132 1.888967e-08
##             fdr
## 8  6.285003e-08
## 14 8.815177e-08
## 11 8.815177e-08
```

Here `tumor_region_df` contains results for testing each co-edited region using logistic regression model.

## 4.6 Annotate results

We next annotate results by adding the corresponding input regions, close-by regions and genes mapped to these genomic regions.

```
tumor_annot_df <- AnnotateResults(
  # the output dataset from function TestAssociations().
  results_df = tumor_region_df,
  # close-by regions which is a output of AllCloseByRegions().
  closeByRegions_gr = closeByRegions_gr,
  # input regions, which are created in section 4.1.
  inputRegions_gr = inputGenes_gr,
  genome = "hg19",
  # the type of analysis result from function TestAssociations(), since we are
  #   doing region-based analysis, use default here.
  analysis = "region-based"
)
```

```
tumor_annot_df[1:3, ]
```

```
##   seqnames    start      end width             inputRegion
## 1    chr12 51324085 51324127    43 chr12:51317255-51326300
## 2    chr12 51325324 51325383    60 chr12:51317255-51326300
## 3    chr12 51324447 51324467    21 chr12:51317255-51326300
##             closeByRegion  symbol   estimate    stdErr       pValue
## 1 chr12:51324081-51324639 METTL7A  -51.23815  8.736146 4.489288e-09
## 2 chr12:51325229-51325622 METTL7A  -94.78676 16.738315 1.488692e-08
## 3 chr12:51324081-51324639 METTL7A -102.71801 18.271132 1.888967e-08
##            fdr
## 1 6.285003e-08
## 2 8.815177e-08
## 3 8.815177e-08
```

To summarize this final dataset, values of column `inputRegion` are the user-specified candidate genomic regions, values of column `closeByRegion` are the regions that contain closely located RNA editing sites, and columns `seqnames`, `start`, `end` are the co-edited regions.

# 5 Further examples of function `TestAssociations` in `rnaEditr`

`rnaEditr` can analyze different types of phenotypes, including binary, continuous and survival outcomes. In the last section, we analyzed a binary phenotype `sample_type`. We next illustrate analysis for continuous and survival phenotypes.

For continuous outcome, as an example, to identify co-edited regions associated age, we use the following commands:

```
tumor_region_df <- TestAssociations(
  # an RNA editing dataframe with special class "rnaEdit_df" from function
  #   CreateEditingTable() if site-specific analysis, from function
  #   SummarizeAllRegions() if region-based analysis.
  rnaEdit_df = summarizedRegions_df,
  # a phenotype dataset that must have variable "sample" whose values are a
  #   exact match to the colnames of "rnaEdit_df".
  pheno_df = pheno_df,
  # name of outcome variable in phenotype dataset "pheno_df" that you want to
  #   test.
  responses_char = "age_at_diagnosis",
  # names of covariate variables in phenotype dataset "pheno_df" that you want
  #   to add into the model.
  covariates_char = NULL,
  # type of outcome variable that you input in argument "responses_char".
  respType = "continuous",
  # order the final results by p-values or not.
  orderByPval = TRUE
)
```

```
tumor_region_df[1:3, ]
```

```
##    seqnames    start      end width  estimate   stdErr     pValue       fdr
## 7      chr3 46417171 46417221    51 -29.56179 12.64776 0.02032533 0.2845546
## 2      chr1 28825394 28825403    10 -72.25518 35.67815 0.04406090 0.3084263
## 11    chr12 51324447 51324467    21  54.28664 29.48137 0.06691720 0.3122803
```

For survival outcome, for example, we use the following commands:

```
tumor_region_df <- TestAssociations(
  # an RNA editing dataframe with special class "rnaEdit_df" from function
  #   CreateEditingTable() if site-specific analysis, from function
  #   SummarizeAllRegions() if region-based analysis.
  rnaEdit_df = summarizedRegions_df,
  # a phenotype dataset that must have variable "sample" whose values are a
  #   exact match to the colnames of "rnaEdit_df".
  pheno_df = pheno_df,
  # name of outcome variable in phenotype dataset "pheno_df" that you want to
  #   test.
  responses_char = c("OS.time", "OS"),
  # names of covariate variables in phenotype dataset "pheno_df" that you want
  #   to add into the model.
  covariates_char = NULL,
  # type of outcome variable that you input in argument "responses_char".
  respType = "survival",
  # order the final results by p-values or not.
  orderByPval = TRUE
)
```

```
tumor_region_df[1:3, ]
```

```
##    seqnames    start      end width      coef     exp_coef  se_coef
## 3      chr1 28825670 28825717    48 -13.64262 1.188740e-06 3.485844
## 14    chr12 51325324 51325383    60 -21.61839 4.085568e-10 5.753652
## 4      chr1 28825899 28825927    29 -24.57176 2.131191e-11 7.063456
##          pValue         fdr
## 3  9.088515e-05 0.001202134
## 14 1.717334e-04 0.001202134
## 4  5.038231e-04 0.002111975
```

# 6 Session information

Here is the R session information for this vignette:

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] rnaEditr_1.20.0
##
## loaded via a namespace (and not attached):
##   [1] Rdpack_2.6.4                DBI_1.2.3
##   [3] bitops_1.0-9                sandwich_3.1-1
##   [5] rlang_1.1.6                 magrittr_2.0.4
##   [7] multcomp_1.4-29             matrixStats_1.5.0
##   [9] compiler_4.5.1              RSQLite_2.4.3
##  [11] mgcv_1.9-3                  GenomicFeatures_1.62.0
##  [13] png_0.1-8                   vctrs_0.6.5
##  [15] pkgconfig_2.0.3             shape_1.4.6.1
##  [17] crayon_1.5.3                fastmap_1.2.0
##  [19] backports_1.5.0             XVector_0.50.0
##  [21] Rsamtools_2.26.0            rmarkdown_2.30
##  [23] nloptr_2.2.1                purrr_1.1.0
##  [25] bit_4.6.0                   xfun_0.53
##  [27] glmnet_4.1-10               jomo_2.7-6
##  [29] logistf_1.26.1              cachem_1.1.0
##  [31] cigarillo_1.0.0             jsonlite_2.0.0
##  [33] blob_1.2.4                  DelayedArray_0.36.0
##  [35] pan_1.9                     BiocParallel_1.44.0
##  [37] broom_1.0.10                parallel_4.5.1
##  [39] R6_2.6.1                    bslib_0.9.0
##  [41] rtracklayer_1.70.0          boot_1.3-32
##  [43] rpart_4.1.24                GenomicRanges_1.62.0
##  [45] jquerylib_0.1.4             estimability_1.5.1
##  [47] Rcpp_1.1.0                  Seqinfo_1.0.0
##  [49] SummarizedExperiment_1.40.0 iterators_1.0.14
##  [51] knitr_1.50                  zoo_1.8-14
##  [53] IRanges_2.44.0              Matrix_1.7-4
##  [55] splines_4.5.1               nnet_7.3-20
##  [57] tidyselect_1.2.1            abind_1.4-8
##  [59] yaml_2.3.10                 codetools_0.2-20
##  [61] curl_7.0.0                  doRNG_1.8.6.2
##  [63] plyr_1.8.9                  lattice_0.22-7
##  [65] tibble_3.3.0                Biobase_2.70.0
##  [67] KEGGREST_1.50.0             coda_0.19-4.1
##  [69] evaluate_1.0.5              survival_3.8-3
##  [71] Biostrings_2.78.0           pillar_1.11.1
##  [73] MatrixGenerics_1.22.0       mice_3.18.0
##  [75] rngtools_1.5.2              corrplot_0.95
##  [77] foreach_1.5.2               stats4_4.5.1
##  [79] reformulas_0.4.2            generics_0.1.4
##  [81] RCurl_1.98-1.17             S4Vectors_0.48.0
##  [83] bumphunter_1.52.0           minqa_1.2.8
##  [85] xtable_1.8-4                glue_1.8.0
##  [87] emmeans_2.0.0               tools_4.5.1
##  [89] BiocIO_1.20.0               lme4_1.1-37
##  [91] locfit_1.5-9.12             GenomicAlignments_1.46.0
##  [93] mvtnorm_1.3-3               XML_3.99-0.19
##  [95] grid_4.5.1                  tidyr_1.3.1
##  [97] rbibutils_2.3               AnnotationDbi_1.72.0
##  [99] nlme_3.1-168                formula.tools_1.7.1
## [101] restfulr_0.0.16             cli_3.6.5
## [103] S4Arrays_1.10.0             dplyr_1.1.4
## [105] sass_0.4.10                 digest_0.6.37
## [107] operator.tools_1.6.3        BiocGenerics_0.56.0
## [109] TH.data_1.1-4               SparseArray_1.10.0
## [111] rjson_0.2.23                memoise_2.0.1
## [113] htmltools_0.5.8.1           lifecycle_1.0.4
## [115] httr_1.4.7                  mitml_0.4-5
## [117] bit64_4.6.0-1               MASS_7.3-65
```