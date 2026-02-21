# Introduction to coMethDMR

Lissette Gomez, Gabriel Odom, Tiago Chedraoui Silva, Lanyu Zhang, and Lily Wang

#### March 2021

# Contents

* [1 Quick start](#quick-start)
  + [1.1 Installation](#installation)
  + [1.2 Datasets](#datasets)
    - [1.2.1 Example Methylation Data](#example-methylation-data)
    - [1.2.2 Example Response Data](#example-response-data)
  + [1.3 A quick work through of coMethDMR](#a-quick-work-through-of-comethdmr)
* [2 Details of `coMethDMR` workflow](#details-of-comethdmr-workflow)
  + [2.1 Genomic regions tested in gene based pipeline](#genomic-regions-tested-in-gene-based-pipeline)
  + [2.2 When there are co-variate variables in dataset to consider](#when-there-are-co-variate-variables-in-dataset-to-consider)
  + [2.3 Algorithm for identifying co-methylated regions](#algorithm-for-identifying-co-methylated-regions)
  + [2.4 Models for testing genomic regions against a continuous phenotype](#models-for-testing-genomic-regions-against-a-continuous-phenotype)
  + [2.5 Analyzing a specific gene](#analyzing-a-specific-gene)
* [3 Frequently Asked Questions](#frequently-asked-questions)
* [4 Reference](#reference)
* [5 Session Information](#session-information)

`coMethDMR` is an R package that identifies genomic regions that are both co-methylated and differentially
methylated in Illumina array datasets. Instead of testing all CpGs within a genomic region, `coMethDMR` carries out an additional step that selects co-methylated sub-regions first without using any outcome information. Next, `coMethDMR` tests association between methylation within the sub-region and continuous phenotype using a random coefficient mixed effects model, which models both variations between CpG sites within the region and differential methylation simultaneously.

# 1 Quick start

## 1.1 Installation

The latest version can be installed by

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("coMethDMR")
```

After installation, the `coMethDMR` package can be loaded into R using:

```
library(coMethDMR)
```

If you are running the `coMethDMR` package for the first time, you will also need to download supplemental data sets from the `sesameData` package. This happens automatically for the 450k and EPIC arrays when you load `coMethDMR` for the first time. If you experience errors in this process, you may have your cache in an older default location. Please follow these steps to update where these genomic data are stored: <https://bioconductor.org/packages/devel/bioc/vignettes/ExperimentHub/inst/doc/ExperimentHub.html#default-caching-location-update>.

## 1.2 Datasets

### 1.2.1 Example Methylation Data

The input of `coMethDMR` are methylation beta values. We assume quality control and normalization of the methylation dataset have been performed, by R packages such as `minfi` or `RnBeads`. For illustration, we use a subset of prefrontal cortex methylation data (GEO GSE59685) from a recent Alzheimer’s disease epigenome-wide association study which was described in Lunnon et al. (2014). This example dataset contains beta values for 8552 CpGs on chromosome 22 for a random selection of 20 subjects.

```
data(betasChr22_df)
betasChr22_df[1:5, 1:5]
```

```
##            GSM1443279 GSM1443663 GSM1443434 GSM1443547 GSM1443577
## cg00004192  0.9249942  0.8463296  0.8700718  0.9058205  0.9090382
## cg00004775  0.6523025  0.6247554  0.7573476  0.6590817  0.6726261
## cg00012194  0.8676339  0.8679048  0.8484754  0.8754985  0.8484458
## cg00013618  0.9466056  0.9475467  0.9566493  0.9588431  0.9419563
## cg00014104  0.3932388  0.5525716  0.4075900  0.3997278  0.3216956
```

If you have used either the [minfi](https://bioconductor.org/packages/release/bioc/vignettes/minfi/inst/doc/minfi.html) or [RnBeads](https://bioconductor.org/packages/release/bioc/vignettes/RnBeads/inst/doc/RnBeads.pdf) packages to pre-process your methylation data, we now show a quick example of the code necessary to create a methylation data frame similar to `betasChr22_df` above (note that `dataObject_minfi` and `dataObject_RnBeads` are objects containing the pre-processed DNA methylation data as returned by the `minfi::` or `RnBeads::` packages, respectively):

```
###  minfi  ###
betas_df <- as.data.frame(
  minfi::getMethSignal(dataObject_minfi, what = "Beta")
)

###  RnBeads  ###
betas_df <- as.data.frame(
  RnBeads::meth(dataObject_RnBeads, row.names = TRUE)
)
```

### 1.2.2 Example Response Data

The corresponding phenotype dataset included variables `stage` (Braak AD stage), `subject.id`, `slide` (batch effect), `Sex`, `Sample` and `age.brain` (age of the brain donor). Please note the phenotype file needs to have a variable called “Sample” that will be used by coMethDMR to link to the methylation dataset.

```
data(pheno_df)
head(pheno_df)
```

```
##    stage subject.id         sex     Sample age.brain       slide
## 3      0          1 Sex: FEMALE GSM1443251        82  6042316048
## 8      2          2 Sex: FEMALE GSM1443256        82  6042316066
## 10    NA          3   Sex: MALE GSM1443258        89  6042316066
## 15     1          4 Sex: FEMALE GSM1443263        81  7786923107
## 21     2          5 Sex: FEMALE GSM1443269        92  6042316121
## 22     1          6   Sex: MALE GSM1443270        78  6042316099
```

## 1.3 A quick work through of coMethDMR

For illustration, suppose we are interested in identifying co-methylated genomic regions associated with AD stages (`stage` treated as a linear variable). Here we demonstrate analysis of genomic regions mapped to CpG islands on chromosome 22. However the workflow can be similarly conducted for other types of genomic regions. See details in Section 2.1 below for gene based pipeline that tests genic and intergenic regions.

There are several steps: (1) obtain CpGs located closely (see details in Section 2.1 below) in genomic regions mapped to CpG islands, (2) identify co-methylated regions, and (3) test co-methylated regions against the outcome variable AD stage.

For the first step, we use the following commands:

```
CpGisland_ls <- readRDS(
  system.file(
    "extdata",
    "CpGislandsChr22_ex.rds",
    package = 'coMethDMR',
    mustWork = TRUE
    )
)
```

Here, `CpGisland_ls` is a list of 20 items, with each item of the list including a group of CpG probe IDs located closely within a particular CpG island region. Section 2.1 discusses how to import additional types of genomic regions.

Next, we identify co-methylated regions based on Mvalues.

```
system.time(
  coMeth_ls <- CoMethAllRegions(
    dnam = betasChr22_df,
    betaToM = TRUE, # converts beta to m-values
    method = "pearson",
    CpGs_ls = CpGisland_ls,
    arrayType = "450k",
    returnAllCpGs = FALSE,
    output = "CpGs",
    nCores_int = 1
  )
)
```

```
## see ?sesameData and browseVignettes('sesameData') for documentation
```

```
## require("GenomicRanges")
```

```
##    user  system elapsed
##  14.188   0.735  15.258
```

```
# ~15 seconds

coMeth_ls
```

```
## $`chr22:18268062-18268249`
## [1] "cg12460175" "cg14086922" "cg21463605"
##
## $`chr22:18324579-18324769`
## [1] "cg19606103" "cg14031491" "cg03816851"
##
## $`chr22:18531243-18531447`
## [1] "cg25257671" "cg06961233" "cg08819022"
```

`coMeth_ls` is list with that contains groups of CpG probeIDs corresponding to co-methylated regions. Three comethylated regions were identified in this example.

If we want to look at co-methylation within the first co-methylated region:

```
WriteCorrPlot <- function(beta_mat){

  require(corrplot)
  require(coMethDMR)

  CpGs_char <- row.names(beta_mat)

  CpGsOrd_df <- OrderCpGsByLocation(
    CpGs_char, arrayType = c("450k"), output = "dataframe"
  )

  betaOrdered_mat <- t(beta_mat[CpGsOrd_df$cpg ,])

  corr <- cor(
    betaOrdered_mat, method = "spearman", use = "pairwise.complete.obs"
  )

  corrplot(corr, method = "number", number.cex = 1, tl.cex = 0.7)
}

# subsetting beta values to include only co-methylated probes
betas_df <- subset(
  betasChr22_df,
  row.names(betasChr22_df) %in% coMeth_ls[[1]]
)

WriteCorrPlot(betas_df)
```

![](data:image/png;base64...)

Next, we test these co-methylated regions against `stage` using a random coefficient model (more details in section 2.3 below).

Some messages are generated during mixed models fitting, which are saved to the file specified by `outLogFile`. The interpretations of these messages can be found in the FAQs at the end of this document (see Section 3, item (1) and (2)).

```
out_df <- lmmTestAllRegions(
  betas = betasChr22_df,
  region_ls = coMeth_ls,
  pheno_df,
  contPheno_char = "stage",
  covariates_char = NULL,
  modelType = "randCoef",
  arrayType = "450k"
  # generates a log file in the current directory
  # outLogFile = paste0("lmmLog_", Sys.Date(), ".txt")
)
```

```
## see ?sesameData and browseVignettes('sesameData') for documentation
```

```
## Analyzing region chr22:18268062-18268249.
```

```
## Analyzing region chr22:18324579-18324769.
```

```
## Analyzing region chr22:18531243-18531447.
```

```
## For future calls to this function, perhaps specify a log file.
##       Set the file name of the log file with the outLogFile argument.
```

```
out_df
```

```
##   chrom    start      end nCpGs    Estimate     StdErr      Stat     pValue
## 1 chr22 18268062 18268249     3 -0.06678558 0.03884657 -1.719214 0.08557535
## 2 chr22 18324579 18324769     3  0.03549924 0.02885559  1.230238 0.21860815
## 3 chr22 18531243 18531447     3 -0.05181161 0.05082462 -1.019419 0.30800386
##         FDR
## 1 0.2567261
## 2 0.3080039
## 3 0.3080039
```

Here `out_df` is a data frame of genomic regions, with corresponding p-values and false discovery rate (FDRs) from the random coefficient mixed model.

We can annotate these results by adding corresponding genes and probes mapped to the genomic regions.

```
system.time(
  outAnno_df <- AnnotateResults(
    lmmRes_df = out_df,
    arrayType = "450k"
  )
)
```

```
##    user  system elapsed
##   7.713   0.392   8.108
```

```
# ~12 seconds

outAnno_df
```

```
##   chrom    start      end nCpGs    Estimate     StdErr      Stat     pValue
## 1 chr22 18268062 18268249     3 -0.06678558 0.03884657 -1.719214 0.08557535
## 2 chr22 18324579 18324769     3  0.03549924 0.02885559  1.230238 0.21860815
## 3 chr22 18531243 18531447     3 -0.05181161 0.05082462 -1.019419 0.30800386
##         FDR UCSC_RefGene_Group UCSC_RefGene_Accession UCSC_RefGene_Name
## 1 0.2567261
## 2 0.3080039               Body NM_001122731;NM_015241            MICAL3
## 3 0.3080039
##   Relation_to_Island
## 1             Island
## 2             Island
## 3             Island
```

To further examine the significant regions, we can also extract individual CpG p-values within these significant regions. For example, for the most significant region `chr22:18268062-18268249`,

```
outCpGs_df <- CpGsInfoOneRegion(
 regionName_char = "chr22:18268062-18268249",
 betas_df = betasChr22_df,
 pheno_df = pheno_df,
 contPheno_char = "stage",
 covariates_char = NULL,
 arrayType = "450k"
)
```

```
## see ?sesameData and browseVignettes('sesameData') for documentation
## see ?sesameData and browseVignettes('sesameData') for documentation
## see ?sesameData and browseVignettes('sesameData') for documentation
```

```
outCpGs_df
```

```
##                    Region        cpg   chr      pos slopeEstimate slopePval
## 1 chr22:18268062-18268249 cg12460175 chr22 18268062       -0.0329    0.3785
## 2 chr22:18268062-18268249 cg14086922 chr22 18268239       -0.0724    0.0667
## 3 chr22:18268062-18268249 cg21463605 chr22 18268249       -0.0951    0.0255
##   UCSC_RefGene_Name UCSC_RefGene_Accession UCSC_RefGene_Group
## 1
## 2
## 3
```

These CpGs mapped to intergenic regions, so there are no gene names associated with the probes. For genic regions such as `chr22:19709548-19709755`, we would have results such as the following:

```
# library("GenoGAM")
# NOTE 2022-03-28: what are we using this package for again?
```

```
CpGsInfoOneRegion(
  regionName_char = "chr22:19709548-19709755",
  betas_df = betasChr22_df,
  pheno_df = pheno_df,
  contPheno_char = "stage",
  covariates_char = NULL,
  arrayType = "450k"
)
```

```
## see ?sesameData and browseVignettes('sesameData') for documentation
## see ?sesameData and browseVignettes('sesameData') for documentation
## see ?sesameData and browseVignettes('sesameData') for documentation
```

```
##                    Region        cpg   chr      pos slopeEstimate slopePval
## 1 chr22:19709548-19709755 cg04533276 chr22 19709548       -0.0656    0.1529
## 2 chr22:19709548-19709755 cg20193802 chr22 19709696       -0.0346    0.4808
## 3 chr22:19709548-19709755 cg05726109 chr22 19709755        0.0021    0.9585
##   UCSC_RefGene_Name UCSC_RefGene_Accession UCSC_RefGene_Group
## 1             SEPT5              NM_002688               Body
## 2       SEPT5;GP1BB    NM_002688;NM_000407       Body;TSS1500
## 3       SEPT5;GP1BB    NM_002688;NM_000407       Body;TSS1500
```

# 2 Details of `coMethDMR` workflow

## 2.1 Genomic regions tested in gene based pipeline

Genomic regions on the Illumina arrays can be defined based on their relations to genes or CpG Islands. To reduce redundancy in the tested genomic regions, we recommend first testing genic and intergenic regions, then add annotations to each genomic region for their relation to CpG islands.

In `coMethDMR` package, for 450k arrays, the relevant genomic regions to be analyzed are in files `450k_Gene_3_200.RDS` and `450k_InterGene_3_200.rds`. For EPIC arrays, the relevant genomic regions are in files `EPIC_Gene_3_200.rds` and `EPIC_InterGene_3_200.rds`. These additional data sets are available at <https://github.com/TransBioInfoLab/coMethDMR_data>.

These files were created using the function `WriteCloseByAllRegions`, briefly, for genic regions, within each gene, we identified clusters of CpGs located closely (i.e. the maximum separation between any two consecutive probes is 200bp; `maxGap = 200`), and we required each cluster to have at least 3 CpGs (`minCpGs = 3`). For intergenic regions, we identified clusters CpGs similarly for each chromosome. To extract clusters of close-by CpGs from pre-defined genomic regions with different values of `maxGap` and `minCpGs`, the `WriteCloseByAllRegions` function can be used.

The pre-computed genomic regions can be accessed using the following commands. For geneic regions in 450k arrays,

```
gene_ls <- readRDS(
  system.file(
    "extdata",
    "450k_Gene_3_200.rds",
    package = 'coMethDMR',
    mustWork = TRUE
    )
)
```

Here `gene_ls` is a list, with each item containing a character vector of CpGs IDs for a particular region in a gene.

Vignette # 2 illustrates how to leverage parallel computing via `BiocParallel` R package to make gene-based analysis fast.

## 2.2 When there are co-variate variables in dataset to consider

Before identifying co-methylated clusters, we recommend removing uninteresting technical and biological effects, so that the resulting co-methylated clusters are only driven by the biological factors we are interested in. This can be accomplished using the `GetResiduals` function.

For example, the following script computes residuals from linear model
`Mvalues ~ age.brain + sex + slide` (note that we use only a subset of the Chromosome 22 CpG islands for computing time consideration).

```
Cgi_ls <- readRDS(
  system.file(
    "extdata",
    "CpGislandsChr22_ex.rds",
    package = 'coMethDMR',
    mustWork = TRUE
    )
)
betasChr22_df <-
  betasChr22_df[rownames(betasChr22_df) %in% unlist(Cgi_ls)[1:20], ]
```

```
resid_mat <- GetResiduals(
  dnam = betasChr22_df,
  # converts to Mvalues for fitting linear model
  betaToM = TRUE,
  pheno_df = pheno_df,
  covariates_char = c("age.brain", "sex", "slide")
)
```

```
## Phenotype data is not in the same order as methylation data. We used column Sample in phenotype data to put these two files in the same order.
```

## 2.3 Algorithm for identifying co-methylated regions

Within each genomic region, coMethDMR identifies contiguous and co-methylated CpGs sub-regions without using any outcome information. To select these co-methylated sub-regions, we use the `rdrop` statistic, which is the correlation between each CpG with the sum of methylation levels in all other CpGs. The default is `rDropThresh_num = 0.4`. We recommend this setting based on our simulation study. Note that higher `rDropThresh_num` values lead to fewer co-methylated regions.

Again, for illustration, we use CpG islands. For example, if we are interested in identifying co-methylated sub-region within the first genomic region in `Cgi_ls`:

```
Cgi_ls <- readRDS(
  system.file(
    "extdata",
    "CpGislandsChr22_ex.rds",
    package = 'coMethDMR',
    mustWork = TRUE
    )
)

coMeth_ls <- CoMethAllRegions(
  dnam = resid_mat,
  betaToM = FALSE,
  method = "pearson",
  CpGs_ls = Cgi_ls[1],
  arrayType = "450k",
  returnAllCpGs = FALSE,
  output = "CpGs"
)
```

```
## see ?sesameData and browseVignettes('sesameData') for documentation
```

```
coMeth_ls
```

```
## NULL
```

The results (`NULL`) indicate there is no co-methylated sub-region within the first genomic region.

What about the other 19 regions? Next we look at a region (5th region in `Cgi_ls`) where there is a co-methylated sub-region:

```
coMeth_ls <- CoMethAllRegions(
  dnam = resid_mat,
  betaToM = FALSE,
  CpGs_ls = Cgi_ls[5],
  arrayType = "450k",
  returnAllCpGs = FALSE,
  output = "CpGs"
)
```

```
## see ?sesameData and browseVignettes('sesameData') for documentation
```

```
coMeth_ls
```

```
## $`chr22:17565612-17565675`
## [1] "cg21717745" "cg02866761" "cg05444620"
```

`coMeth_ls` is a list, where each item is a list of CpG probe IDs for a co-methylated sub-region.

If we want to see the detailed output of the coMethDMR algorithm, that is, how the co-methylated region was obtained, we can specify `output = "dataframe"`:

```
coMethData_df <- CoMethAllRegions(
  dnam = resid_mat,
  betaToM = FALSE,
  CpGs_ls = Cgi_ls[5],
  arrayType = "450k",
  returnAllCpGs = FALSE,
  output = "dataframe"
) [[1]]
```

```
## see ?sesameData and browseVignettes('sesameData') for documentation
```

```
coMethData_df
```

```
##                    Region        CpG   Chr  MAPINFO    r_drop keep
## 1 chr22:17565612-17565904 cg21717745 chr22 17565612 0.7850186    1
## 2 chr22:17565612-17565904 cg02866761 chr22 17565664 0.5547508    1
## 3 chr22:17565612-17565904 cg05444620 chr22 17565675 0.6494019    1
## 4 chr22:17565612-17565904 cg03304299 chr22 17565742 0.3282093    0
##   keep_contiguous
## 1               1
## 2               1
## 3               1
## 4               0
```

`coMethData_df` provides the details on how the co-methylated region was obtained: Here `keep = 1` if `rDropThresh_num > 0.4` (i.e. a co-methylated CpG), and `keep_contigous` indicates if the probe is in a contiguous co-methylated region. Note that only the last 3 CpGs constitutes the co-methylated cluster.

## 2.4 Models for testing genomic regions against a continuous phenotype

To test association between a continuous phenotype and methylation values in a contiguous co-methylated region, two mixed models have been implemented in the function `lmmTestAllRegions`: a random coefficient mixed model (`modelType = "randCoef"`) and a simple linear mixed model (`modelType = "simple"`).

The random coefficient mixed model includes both a systematic component that models the mean for each group of CpGs, and a random component that models how each CpG varies with respect to the group mean (random probe effects). It also includes random sample effects that model correlations between multiple probes within the same sample.

More specifically, the random coefficient model is
`methylation M value ~ contPheno_char + covariates_char + (1|Sample) + (contPheno_char|CpG).`
The last term `(contPheno_char|CpG)` specifies both random intercepts and slopes for each CpG.

The simple linear mixed model includes all the terms in the random coefficient model except random probe effects.

The simple linear mixed model is

`methylation M value ~ contPheno_char + covariates_char + (1|Sample)`

To test one genomic region against the continuous phenotype `stage`, adjusting for `age.brain`:

```
lmmTestAllRegions(
  betas = betasChr22_df,
  region_ls = coMeth_ls[1],
  pheno_df,
  contPheno_char = "stage",
  covariates_char = "age.brain",
  modelType = "randCoef",
  arrayType = "450k"
)
```

```
##   chrom    start      end nCpGs   Estimate     StdErr     Stat    pValue
## 1 chr22 17565612 17565675     3 0.03324127 0.02058192 1.615071 0.1062953
##         FDR
## 1 0.1062953
```

If we don’t want to adjust for any covariate effect, we can set `covariates_char` to `NULL`.

## 2.5 Analyzing a specific gene

Finally, we demonstrate `coMethDMR` analysis for a particular gene, for example the `ARFGAP3` gene.

```
data(betasChr22_df)
```

We assume that the user knows the set of probes corresponding to the gene of interest. If this is not the case, we provide two data sets which contain mappings from gene symbols to probe IDs for both 450k (“450k\_CpGstoGene\_min3CpGs.rds”) and EPIC (“EPIC\_CpGstoGene\_min3CpGs.rds”) arrays. These two data sets are available at: <https://github.com/TransBioInfoLab/coMethDMR_data/tree/main/data>.

```
# list probes for this gene
ARFGAP3_CpGs_char <- c(
  "cg00079563", "cg01029450", "cg02351223", "cg04527868", "cg09861871",
  "cg26529516", "cg00539564", "cg05288033", "cg09367092", "cg10648908",
  "cg14570855", "cg15656623", "cg23778094", "cg27120833"
)

# list probes located closely on this gene
gene3_200 <- CloseBySingleRegion(
  CpGs_char = ARFGAP3_CpGs_char,
  arrayType = "450k",
  maxGap = 200,
  minCpGs = 3
)
CpGsOrdered_ls <- lapply(
  gene3_200,
  OrderCpGsByLocation,
  arrayType = "450k",
  output = "dataframe"
)
names(gene3_200) <- lapply(CpGsOrdered_ls, NameRegion)

# List of regions
gene3_200
```

```
## $`chr22:43253145-43253208`
## [1] "cg15656623" "cg10648908" "cg02351223"
##
## $`chr22:43253517-43253559`
## [1] "cg09861871" "cg00079563" "cg26529516" "cg04527868" "cg01029450"
##
## $`chr22:43254043-43254168`
## [1] "cg23778094" "cg00539564" "cg09367092"
```

Now that we have a list of regions, we can find the co-methylated regions within the gene and test their statistical significance:

```
# co-methlyated region within the gene
coMeth_ls <- CoMethAllRegions(
  dnam = betasChr22_df,
  betaToM = TRUE,
  method = "pearson",
  CpGs_ls = gene3_200,
  arrayType = "450k",
  returnAllCpGs = FALSE,
  output = "CpGs"
)
```

```
## see ?sesameData and browseVignettes('sesameData') for documentation
```

```
coMeth_ls
```

```
## $`chr22:43253521-43253559`
## [1] "cg00079563" "cg26529516" "cg04527868" "cg01029450"
```

```
# test the co-methylated regions within the gene
results <- lmmTestAllRegions(
  betas = betasChr22_df,
  region_ls = coMeth_ls,
  pheno_df,
  contPheno_char = "stage",
  covariates_char = "age.brain",
  modelType = "randCoef",
  arrayType = "450k"
  # generates a log file in the current directory
  # outLogFile = paste0("lmmLog_", Sys.Date(), ".txt")
)
```

```
## see ?sesameData and browseVignettes('sesameData') for documentation
```

```
## Analyzing region chr22:43253521-43253559.
```

```
## For future calls to this function, perhaps specify a log file.
##       Set the file name of the log file with the outLogFile argument.
```

Before we inspect the results, we will annotate them:

```
AnnotateResults(lmmRes_df = results, arrayType = "450k")
```

```
##   chrom    start      end nCpGs     Estimate     StdErr       Stat    pValue
## 1 chr22 43253521 43253559     4 -0.006608311 0.02820896 -0.2342628 0.8147809
##         FDR UCSC_RefGene_Group UCSC_RefGene_Accession UCSC_RefGene_Name
## 1 0.8147809             TSS200 NM_001142293;NM_014570           ARFGAP3
##   Relation_to_Island
## 1             Island
```

# 3 Frequently Asked Questions

1. What happens when mixed model fails to coverge (i.e. the warning “Model failed to converge with…” is resulted for a particular genomic region)?

* In this case, the p-value for mixed model is set to 1. In our experiences with methylation datasets, genomic regions with strong signals typically converge. Convergence issues typically occurs when the amount of noise in data is high.

2. When fitting mixed models with `lmmTestAllRegions` function, What does the message “boundary (singular) fit” mean?

* When mixed model is singular, at least one of the estimated variance components for intercepts or slopes random effects is 0, because there isn’t enough variabilities in data to estimate the random effects. In this case, mixed model reduces to a fixed effects model. However, as our simulation studies have shown, the p-values obtained for these regions are still valid.

# 4 Reference

Lunnon K, Smith R, Hannon E, De Jager PL, Srivastava G, Volta M, Troakes C, Al-Sarraj S, Burrage J, Macdonald R, et al (2014) Methylomic profiling implicates cortical deregulation of ANK1 in Alzheimer’s disease. Nat Neurosci 17:1164-1170.

# 5 Session Information

```
utils::sessionInfo()
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
##  [1] corrplot_0.95        GenomicRanges_1.62.0 Seqinfo_1.0.0
##  [4] IRanges_2.44.0       S4Vectors_0.48.0     sesameData_1.27.1
##  [7] ExperimentHub_3.0.0  AnnotationHub_4.0.0  BiocFileCache_3.0.0
## [10] dbplyr_2.5.1         BiocGenerics_0.56.0  generics_0.1.4
## [13] coMethDMR_1.14.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3
##   [2] jsonlite_2.0.0
##   [3] magrittr_2.0.4
##   [4] magick_2.9.0
##   [5] GenomicFeatures_1.62.0
##   [6] farver_2.1.2
##   [7] nloptr_2.2.1
##   [8] rmarkdown_2.30
##   [9] BiocIO_1.20.0
##  [10] vctrs_0.6.5
##  [11] multtest_2.66.0
##  [12] memoise_2.0.1
##  [13] minqa_1.2.8
##  [14] Rsamtools_2.26.0
##  [15] DelayedMatrixStats_1.32.0
##  [16] RCurl_1.98-1.17
##  [17] askpass_1.2.1
##  [18] tinytex_0.57
##  [19] htmltools_0.5.8.1
##  [20] S4Arrays_1.10.0
##  [21] curl_7.0.0
##  [22] Rhdf5lib_1.32.0
##  [23] SparseArray_1.10.0
##  [24] rhdf5_2.54.0
##  [25] sass_0.4.10
##  [26] nor1mix_1.3-3
##  [27] bslib_0.9.0
##  [28] plyr_1.8.9
##  [29] httr2_1.2.1
##  [30] cachem_1.1.0
##  [31] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
##  [32] GenomicAlignments_1.46.0
##  [33] lifecycle_1.0.4
##  [34] iterators_1.0.14
##  [35] pkgconfig_2.0.3
##  [36] Matrix_1.7-4
##  [37] R6_2.6.1
##  [38] fastmap_1.2.0
##  [39] rbibutils_2.3
##  [40] MatrixGenerics_1.22.0
##  [41] digest_0.6.37
##  [42] numDeriv_2016.8-1.1
##  [43] siggenes_1.84.0
##  [44] reshape_0.8.10
##  [45] AnnotationDbi_1.72.0
##  [46] RSQLite_2.4.3
##  [47] base64_2.0.2
##  [48] filelock_1.0.3
##  [49] beanplot_1.3.1
##  [50] httr_1.4.7
##  [51] abind_1.4-8
##  [52] compiler_4.5.1
##  [53] rngtools_1.5.2
##  [54] bit64_4.6.0-1
##  [55] withr_3.0.2
##  [56] S7_0.2.0
##  [57] BiocParallel_1.44.0
##  [58] DBI_1.2.3
##  [59] HDF5Array_1.38.0
##  [60] MASS_7.3-65
##  [61] openssl_2.3.4
##  [62] rappdirs_0.3.3
##  [63] DelayedArray_0.36.0
##  [64] rjson_0.2.23
##  [65] tools_4.5.1
##  [66] rentrez_1.2.4
##  [67] quadprog_1.5-8
##  [68] glue_1.8.0
##  [69] h5mread_1.2.0
##  [70] restfulr_0.0.16
##  [71] nlme_3.1-168
##  [72] rhdf5filters_1.22.0
##  [73] grid_4.5.1
##  [74] gtable_0.3.6
##  [75] tzdb_0.5.0
##  [76] preprocessCore_1.72.0
##  [77] tidyr_1.3.1
##  [78] data.table_1.17.8
##  [79] hms_1.1.4
##  [80] xml2_1.4.1
##  [81] XVector_0.50.0
##  [82] BiocVersion_3.22.0
##  [83] foreach_1.5.2
##  [84] pillar_1.11.1
##  [85] stringr_1.5.2
##  [86] limma_3.66.0
##  [87] genefilter_1.92.0
##  [88] splines_4.5.1
##  [89] dplyr_1.1.4
##  [90] lattice_0.22-7
##  [91] survival_3.8-3
##  [92] rtracklayer_1.70.0
##  [93] bit_4.6.0
##  [94] GEOquery_2.78.0
##  [95] annotate_1.88.0
##  [96] tidyselect_1.2.1
##  [97] locfit_1.5-9.12
##  [98] Biostrings_2.78.0
##  [99] knitr_1.50
## [100] reformulas_0.4.2
## [101] bookdown_0.45
## [102] SummarizedExperiment_1.40.0
## [103] xfun_0.53
## [104] scrime_1.3.5
## [105] Biobase_2.70.0
## [106] statmod_1.5.1
## [107] matrixStats_1.5.0
## [108] stringi_1.8.7
## [109] yaml_2.3.10
## [110] boot_1.3-32
## [111] evaluate_1.0.5
## [112] codetools_0.2-20
## [113] cigarillo_1.0.0
## [114] tibble_3.3.0
## [115] minfi_1.56.0
## [116] BiocManager_1.30.26
## [117] cli_3.6.5
## [118] bumphunter_1.52.0
## [119] xtable_1.8-4
## [120] Rdpack_2.6.4
## [121] jquerylib_0.1.4
## [122] dichromat_2.0-0.1
## [123] Rcpp_1.1.0
## [124] png_0.1-8
## [125] XML_3.99-0.19
## [126] parallel_4.5.1
## [127] ggplot2_4.0.0
## [128] readr_2.1.5
## [129] blob_1.2.4
## [130] mclust_6.1.1
## [131] doRNG_1.8.6.2
## [132] sparseMatrixStats_1.22.0
## [133] bitops_1.0-9
## [134] lme4_1.1-37
## [135] lmerTest_3.1-3
## [136] illuminaio_0.52.0
## [137] scales_1.4.0
## [138] purrr_1.1.0
## [139] crayon_1.5.3
## [140] rlang_1.1.6
## [141] KEGGREST_1.50.0
```