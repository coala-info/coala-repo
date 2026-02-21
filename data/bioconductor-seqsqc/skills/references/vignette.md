# Sample Quality Check for NGS Data using SeqSQC package

Qian Liu, Qianqian Zhu

#### 30 October 2025

#### Abstract

SeqSQC is a bioconductor package for sample-level quality check in next generation sequencing (NGS) study. It is designed to automate and accelerate the sample cleaning of NGS data in any scale, including identifying problematic samples with high missing rate, gender mismatch, contamination, abnormal inbreeding coefficient, cryptic relatedness, and discordant population information. SeqSQC takes Variant Calling Format (VCF) files and sample annotation file containing sample population and gender information as input and report problematic samples to be removed from downstream analysis. Through incorporation a benchmark data assembled from the 1000 Genomes Project, it can accommodate NGS study of small sample size and low number of variants.

# Contents

* [1 Quick start](#quick-start)
* [2 Data preparation](#data-preparation)
  + [2.1 Input data](#input-data)
  + [2.2 SeqSQC class](#seqsqc-class)
  + [2.3 GDS class](#gds-class)
* [3 Standard workflow](#standard-workflow)
  + [3.1 Sample missing rate check](#sample-missing-rate-check)
  + [3.2 Sex check](#sex-check)
  + [3.3 Inbreeding check](#inbreeding-check)
  + [3.4 IBD check](#ibd-check)
  + [3.5 Population outlier check](#population-outlier-check)
* [4 Summary of QC results](#summary-of-qc-results)
  + [4.1 Problematic sample list](#problematic-sample-list)
  + [4.2 reporting of results](#reporting-of-results)
* [5 How to get help for SeqSQC](#how-to-get-help-for-seqsqc)
* [6 Session info](#session-info)

# 1 Quick start

The QC process in SeqSQC included five different steps: missing rate check, sex check, inbreeding coefficient check, Identity-by-descent (IBD) check, and population outlier check. Problematic samples identified in each step could be removed from later steps. The entire sample level QC was wrapped up in one function: `sampleQC`. By executing this function, a problematic sample list with criteria from each QC step as well as a QC report with interactive plots in html format will be generated.

Here we use an exemplar NGS dataset as a study cohort to demonstrate the execution of the wrap-up function `sampleQC`. The example dataset, with four EUR (European) samples and one AFR (African) sample, is assembled from the 1000 Genomes Project. We labeled the one AFR sample as EUR to mimic a population outlier. Samples from the 1000 Genome Project are whole-genome sequencing dataset. To mimic whole exome sequencing (WES) data, we kept in the vcf file only the variants in capture regions of Agilent SureSelect Human Exon v5, one of the most popular WES capture platforms to date.

The code chunk below assumes that you have a vcf file called `infile` with samples from a single population, a sample annotation file called `sample.annot` with sample name, population (e.g., AFR, EUR, EAS (East Asian), SAS (South Asian), or ASN (Asian)) and gender info (male/female), and a bed file called `cr` which contains capture regions. User need to specify the name for output files, incuding the gds file containing genotypes, and the `SeqSQC`(discussed in section below) object with QC results.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("SeqSQC")
```

```
library(SeqSQC)
```

```
## Loading required package: ExperimentHub
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
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
## Loading required package: SNPRelate
```

```
## Loading required package: gdsfmt
```

```
## SNPRelate -- supported by Streaming SIMD Extensions 2 (SSE2)
```

```
## Warning: replacing previous import 'e1071::element' by 'ggplot2::element' when
## loading 'SeqSQC'
```

```
## Warning: replacing previous import 'S4Vectors::rename' by 'plotly::rename' when
## loading 'SeqSQC'
```

```
## Warning: replacing previous import 'IRanges::slice' by 'plotly::slice' when
## loading 'SeqSQC'
```

```
## Warning: replacing previous import 'ggplot2::last_plot' by 'plotly::last_plot'
## when loading 'SeqSQC'
```

The wrap-up function `sampleQC` transforms the vcf file into `SeqSQC` object, or take the `SeqSQC` object generated from `LoadVfile` directly as input, evaluates all sample QC steps (as a convenient all inclusive method), outputs the QC results into your designated directory, and generates a sample QC report in html format. We recommend saving the output `SeqSQC` object into an RData.

This is an example when we have input as vcf file, sample annotation file, and capture region bed file. Note that our example vcf file only include variants in chromosome 1, and the capture region only include the

```
infile <- system.file("extdata", "example_sub.vcf", package="SeqSQC")
sample.annot <- system.file("extdata", "sampleAnnotation.txt", package="SeqSQC")
cr <- system.file("extdata", "CCDS.Hs37.3.reduced_chr1.bed", package="SeqSQC")
outdir <- tempdir()
outfile <- file.path(outdir, "testWrapUp")
```

```
seqfile <- sampleQC(vfile = infile, output = outfile, capture.region = cr, sample.annot = sample.annot, format.data = "NGS", format.file = "vcf", QCreport = FALSE)
save(seqfile, file="seqfile.RData")
```

This is an example when we directly use `SeqSQC` object as input, and evaluate all sample QC steps.

```
load(system.file("extdata", "example.seqfile.Rdata", package="SeqSQC"))
gfile <- system.file("extdata", "example.gds", package="SeqSQC")
seqfile <- SeqSQC(gdsfile = gfile, QCresult = QCresult(seqfile))

seqfile <- sampleQC(vfile = seqfile, output = "testWrapUp", QCreport = TRUE)
save(seqfile, file="seqfile.Rdata")
```

Detailed descriptions of data structure and functionality usage of SeqSQC are provided as below. Users are recommended to use these specific QC functions for each QC step if they want to skip any of them by using `sampleQC()`.

# 2 Data preparation

## 2.1 Input data

SeqSQC takes VCF file as input.

```
seqfile <- LoadVfile(vfile = infile, output = outfile, capture.region = cr, sample.annot = sample.annot)
```

```
## Start file conversion from VCF to SNP GDS ...
## Method: extracting biallelic SNPs
## Number of samples: 5
## Parsing "/tmp/Rtmp4P36Nc/Rinst2f9361291e3d5/SeqSQC/extdata/example_sub.vcf" ...
##  import 1000 variants.
## + genotype   { Bit2 5x1000, 1.2K } *
## SNP genotypes: 5 samples, 1000 SNPs
## Genotype matrix is being transposed ...
## Optimize the access efficiency ...
## Clean up the fragments of GDS file:
##     open the file '/tmp/RtmpwMN7iP/file2f9bd82bd6fb93' (12.4K)
##     # of fragments: 48
##     save to '/tmp/RtmpwMN7iP/file2f9bd82bd6fb93.tmp'
##     rename '/tmp/RtmpwMN7iP/file2f9bd82bd6fb93.tmp' (10.7K, reduced: 1.6K)
##     # of fragments: 20
```

```
## Clean up the fragments of GDS file:
##     open the file '/tmp/RtmpwMN7iP/file2f9bd82f104ab3' (360.6M)
##     # of fragments: 36
##     save to '/tmp/RtmpwMN7iP/file2f9bd82f104ab3.tmp'
##     rename '/tmp/RtmpwMN7iP/file2f9bd82f104ab3.tmp' (279.2K, reduced: 360.4M)
##     # of fragments: 31
```

```
## Clean up the fragments of GDS file:
##     open the file '/tmp/RtmpwMN7iP/file2f9bd82bd6fb93' (14.9K)
##     # of fragments: 44
##     save to '/tmp/RtmpwMN7iP/file2f9bd82bd6fb93.tmp'
##     rename '/tmp/RtmpwMN7iP/file2f9bd82bd6fb93.tmp' (7.8K, reduced: 7.1K)
##     # of fragments: 31
## Clean up the fragments of GDS file:
##     open the file '/tmp/RtmpwMN7iP/file2f9bd82bd6fb93' (7.8K)
##     # of fragments: 31
##     save to '/tmp/RtmpwMN7iP/file2f9bd82bd6fb93.tmp'
##     rename '/tmp/RtmpwMN7iP/file2f9bd82bd6fb93.tmp' (7.8K, reduced: 0B)
##     # of fragments: 31
```

```
## Clean up the fragments of GDS file:
##     open the file '/tmp/RtmpwMN7iP/testWrapUp.gds' (1.4M)
##     # of fragments: 39
##     save to '/tmp/RtmpwMN7iP/testWrapUp.gds.tmp'
##     rename '/tmp/RtmpwMN7iP/testWrapUp.gds.tmp' (858.5K, reduced: 557.1K)
##     # of fragments: 31
```

```
## SNP pruning based on LD:
## Excluding 0 SNP on non-autosomes
## Excluding 2,879 SNPs (monomorphic: TRUE, MAF: 0.005, missing rate: 0.01)
##     # of samples: 92
##     # of SNPs: 11,443
##     using 1 thread/core
##     sliding window: 500,000 basepairs, Inf SNPs
##     |LD| threshold: 0.3
##     method: composite
## Chrom 1: |====================|====================|
##     29.64%, 4,245 / 14,322 (Thu Oct 30 02:28:36 2025)
## 4,245 markers are selected in total.
```

## 2.2 SeqSQC class

We define an object class `SeqSQC` to store the genotype data, variant / sample annotation data, and the sample QC results.

```
load(system.file("extdata", "example.seqfile.Rdata", package="SeqSQC"))
gfile <- system.file("extdata", "example.gds", package="SeqSQC")
seqfile <- SeqSQC(gdsfile = gfile, QCresult = QCresult(seqfile))
slotNames(seqfile)
```

```
## [1] "gdsfile"  "QCresult"
```

A SeqSQC object is a list of two objects. The first object is the filepath of the GDS (discussed in section below) file which stores the genotype information from the original VCF file.

```
gdsfile(seqfile)
```

```
## [1] "/tmp/Rtmp4P36Nc/Rinst2f9361291e3d5/SeqSQC/extdata/example.gds"
```

The second object is a list of sample information and QC results, which include the dimension (# of samples and variants), sample annotation, and QC results for sample missing rate, sex check, inbreeding outlier check, IBD check, and population outlier check.

```
QCresult(seqfile)
```

```
## List of length 7
## names(7): dimension sample.annot MissingRate SexCheck Inbreeding IBD PCA
```

```
head(QCresult(seqfile)$sample.annot)
```

```
##    sample population gender relation group
## 1 HG00119        EUR   male            pop
## 2 HG00133        EUR female            pop
## 3 HG00137        EUR female            pop
## 4 HG00174        EUR female            pop
## 5 HG00271        EUR   male            pop
## 6 HG00311        EUR   male            pop
```

## 2.3 GDS class

The genotype information and variant annotation from the input VCF file will be stored in Genomic Data Structure (GDS) format (*[gdsfmt](https://bioconductor.org/packages/3.22/gdsfmt)*). Compared to VCF format, the GDS format could increase the storage efficiency by 5 fold and data access speed by 2-3 fold. We only include the bi-allelic single nucleotide variants (SNVs) from the VCF input for sample QC analysis. Other information from the VCF file, including the chromosome, position, snp rs id, reference allele, alternative allele, quality score and filter can also be passed into the gds file. The functions `SeqOpen` and `closefn.gds` can be used to open and close the gds file in `SeqSQC` object. It is recommended to close the gds file once it has been opened.

```
showfile.gds(closeall=TRUE)
dat <- SeqOpen(seqfile)
dat
```

```
## File: /tmp/Rtmp4P36Nc/Rinst2f9361291e3d5/SeqSQC/extdata/example.gds (2.8M)
## +    [  ]
## |--+ sample.id   { Str8 92 ZIP(34.9%), 257B }
## |--+ sample.annot   [ data.frame ] *
## |  |--+ sample   { Str8 92 ZIP(34.9%), 257B }
## |  |--+ population   { Str8 92 ZIP(15.5%), 57B }
## |  |--+ gender   { Str8 92 ZIP(10.6%), 58B }
## |  |--+ relation   { Str8 92 ZIP(33.4%), 97B }
## |  \--+ group   { Str8 92 ZIP(7.67%), 29B }
## |--+ snp.id   { Int32 138320 ZIP(51.6%), 278.6K }
## |--+ snp.rs.id   { Str8 138320 ZIP(40.3%), 598.6K }
## |--+ snp.chromosome   { Str8 138320 ZIP(0.12%), 414B }
## |--+ snp.position   { Int32 138320 ZIP(75.3%), 406.6K }
## |--+ snp.allele   { Str8 138320 ZIP(15.1%), 81.5K }
## |--+ genotype   { Bit2 138320x92 ZIP(46.9%), 1.4M }
## \--+ snp.annot   [  ]
##    |--+ qual   { Float64 138320 ZIP(0.23%), 2.5K }
##    |--+ filter   { Str8 138320 ZIP(0.15%), 1.0K }
##    \--+ LDprune   { Int32,logical 138320 ZIP(5.46%), 29.5K } *
```

```
closefn.gds(dat)
```

# 3 Standard workflow

## 3.1 Sample missing rate check

Samples with missing rate > 0.1 are considered problematic. The function `MissingRate` and `plotQC(QCstep = "MissingRate")` calculate and plot the sample missing rate respectively.

The result from sample missing rate check contains three columns: sample name, sample missing rate, and an indicator of whether the sample has a missing rate greater than 0.1. The value of the `outlier` column is set to NA for benchmark samples. When running the QC process through the wrap-up function `sampleQC`, problematic samples identified in each QC step are automatically remove before getting to the next step. However when a QC step is executed separately, users need to specify the list of problematic samples to be removed using the `remove.samples` option.

```
seqfile <- MissingRate(seqfile, remove.samples=NULL)
```

```
res.mr <- QCresult(seqfile)$MissingRate
tail(res.mr)
```

```
##     sample missingRate outlier
## 21 HG00124           0    <NA>
## 22 HG00105           0      No
## 23 HG00115           0      No
## 24 HG01695           0      No
## 25 NA11930           0      No
## 26 HG02585           0      No
```

The function `plotQC(QCstep = "MissingRate")` generates the plot for the sample missing rate, where the problematic samples with missing rate greater than 0.1 are highlighted in the plot. The default plot generated is not interactive. Users can generate the interactive plot in each QC step by specifying the `interactive` argument to be TRUE. The interactive plot allows users to visually inspect the QC result by putting the cursor on samples of interest.

```
plotQC(seqfile, QCstep = "MissingRate")
```

![](data:image/png;base64...)
In this plot, all five samples in the study cohort have missing rate of zero.

## 3.2 Sex check

After filtering out the pseudo-autosomal region in X chromosome, we calculate the sample inbreeding coefficient with variants on X chromosome for all samples in the study cohort and for benchmark samples of the same population as the study cohort. The function `SexCheck` predicts the sample gender and `plotQC(QCstep = "SexCheck")` draws the plot for X chromosome inbreeding coefficients.

The result contains sample name, reported gender, X chromosome inbreeding coefficient, and predicted gender. Samples are predicted to be female or male if the inbreeding coefficient is below 0.2, or greater than 0.8. The samples with discordant reported gender and predicted gender are considered as problematic. When the inbreeding coefficient is within the range of [0.2, 0.8], “0” will be shown in the column of `pred.sex` to indicate ambiguous gender, which won’t be considered as problematic.

```
seqfile <- SexCheck(seqfile, remove.samples=NULL)
```

```
res.sexc <- QCresult(seqfile)$SexCheck
tail(res.sexc)
```

```
##     sample    sex      sexinb pred.sex
## 21 HG00124 female -0.01590996   female
## 22 HG00105   male  1.00442136     male
## 23 HG00115   male  0.91816384     male
## 24 HG01695 female  0.29287884        0
## 25 NA11930   male  0.96900002     male
## 26 HG02585   male  1.87093224     male
```

The function `plotQC(QCstep = "SexCheck")` generates the plot for the inbreeding coefficient on X chromosome where samples are labeled with different color according to their self-reported gender. If there is any sample detected to be gender mismatched by SeqSQC, it will be highlighted with a red circle.

```
plotQC(seqfile, QCstep = "SexCheck")
```

![](data:image/png;base64...)
In this plot, none of the five samples in the study cohort have dis-concordant self-reported and predicted genders.

## 3.3 Inbreeding check

Using LD-pruned autosomal variants, we calculate the inbreeding coefficient for each sample in the study cohort and for benchmark samples of the same population as the study cohort. Samples with inbreeding coefficients that are five standard deviations beyond the mean are considered problematic. The function `Inbreeding` and `plotQC(QCstep = "Inbreeding")` calculates and plots the inbreeding coefficients respectively.

The result contains sample name, inbreeding coefficient, and an indicator of whether the inbreeding coefficient is five standard deviation beyond the mean. For Benchmark samples the indicator column is set to be “NA”.

```
seqfile <- Inbreeding(seqfile, remove.samples=NULL)
```

```
res.inb <- QCresult(seqfile)$Inbreeding
tail(res.inb)
```

```
##     sample  inbreeding outlier.5sd
## 21 HG00124 -0.04297042        <NA>
## 22 HG00105  0.10507886          No
## 23 HG00115  0.11097193          No
## 24 HG01695  0.11478018          No
## 25 NA11930  0.11011020          No
## 26 HG02585  0.32389122          No
```

The function `plotQC(QCstep = "Inbreeding")` generates the plot for the inbreeding coefficient. Problematic samples with extreme inbreeding coefficients will be highlighted in the plot.

```
plotQC(seqfile, QCstep = "Inbreeding")
```

![](data:image/png;base64...)
In this plot, none of the five samples in the study cohort have extreme inbreeding coefficients.

## 3.4 IBD check

Using LD-pruned autosomal variants, we calculate the IBD coefficients for all sample pairs. we then predict related sample pairs in study cohort by using the support vector machine (SVM) method with linear kernel and the known relatedness embedded in benchmark data as training set. All predicted related pairs are also required to have coefficient of kinship ≥ 0.08. The sample with higher missing rate in each related pair is selected for removal from further analysis. The function `IBD` calculates the IBD coefficients for each sample pair and predicts the relatedness for samples in the study cohort. The function `plotQC(QCstep = "IBD")` draws the descent coefficients, K0 and K1, for each pair.

The result contains sample names, the descent coefficients k0, k1 and kinship, self-reported relationship and predicted relationship for each pair of samples. Sample pairs with discordant self-reported and predicted relationship are considered as problematic.

```
seqfile <- IBD(seqfile, remove.samples=NULL)
```

```
res.ibd <- QCresult(seqfile)$IBD
head(res.ibd)
```

```
##         id1     id2        k0 k1        kin label pred.label
## 93  HG00119 HG00133 1.0000000  0 0.00000000    UN         UN
## 185 HG00119 HG00137 0.8775824  0 0.06120879    UN         UN
## 186 HG00133 HG00137 0.8907753  0 0.05461233    UN         UN
## 277 HG00119 HG00174 1.0000000  0 0.00000000    UN         UN
## 278 HG00133 HG00174 1.0000000  0 0.00000000    UN         UN
## 279 HG00137 HG00174 0.8851751  0 0.05741246    UN         UN
```

The function `plotQC(QCstep = "IBD")` draws the descent coefficients k0 and k1 for each sample pair. The relationship for each sample pair are labelled by different colors. If there is any problematic sample pair detected to be cryptically related by SeqSQC, it will be highlighted with a red circle.

```
plotQC(seqfile, QCstep = "IBD")
```

```
## Scale for colour is already present.
## Adding another scale for colour, which will replace the existing scale.
```

![](data:image/png;base64...)
In this plot, none of the five samples in the study cohort have cryptic relationship with each other.

## 3.5 Population outlier check

Using LD-pruned autosomal variants we calculate the eigenvectors and eigenvalues for principle component analysis (PCA). We use the benchmark samples as training dataset, and predict the population group for each sample in the study cohort using the top four principle components. Samples with discordant predicted and self-reported population groups are considered problematic. The function `PCA` performs the PCA analysis and identifies population outliers in study cohort.

The result contains sample name, reported population, data resource (benchmark / study cohort), the first four eigenvectors and predicted population. In the example data, we identified one population outlier. The sample `HG02585` was reported as EUR but predicted to be AFR. `HG02585` is indeed a AFR sample. We put it as an intended population outlier in the example data.

```
seqfile <- PCA(seqfile, remove.samples=NULL)
```

```
res.pca <- QCresult(seqfile)$PCA
tail(res.pca)
```

```
##     sample pop  type         EV1         EV2         EV3         EV4 pred.pop
## 80 NA20895 SAS   pop -0.05707629 -0.05250343 -0.03554849  0.03699505      SAS
## 81 HG00105 EUR study -0.04287047 -0.16439102  0.14085165 -0.15338474      EUR
## 82 HG00115 EUR study -0.04626500 -0.15455063  0.12749117 -0.14449323      EUR
## 83 HG01695 EUR study -0.03515475 -0.14758276  0.14503975 -0.15852459      EUR
## 84 NA11930 EUR study -0.04509767 -0.15497010  0.13152295 -0.15107911      EUR
## 85 HG02585 EUR study  0.17683331 -0.08140563  0.51735383 -0.59243887      AFR
```

The function `plotQC(QCstep = "PCA")` generates the plot of first two principle components for each sample. Samples with different population are labelled by different colors. If there is any population outlier detected by SeqSQC, it will be highlighted with a red circle.

```
plotQC(seqfile, QCstep = "PCA")
```

![](data:image/png;base64...)

In the following interactive plot, the intended population outlier `HG02585` was grouped closer to the AFR benchmark samples, and far from the other four EUR samples. Users could easily pick it out and remove it from downstream analysis.

```
plotQC(seqfile, QCstep = "PCA", interactive=TRUE)
```

# 4 Summary of QC results

## 4.1 Problematic sample list

The SeqSQC function `ProblemList` generates a data frame including all problematic samples, and the reasons for removal recommendation. We recommend users to execute this function after finishing all QC steps in **standard workflow**, so that they can get a full list of problematic samples.

```
problemList(seqfile)
```

```
## $prob.list
##    sample      remove.reason
## 1 HG02585 population outlier
##
## $remove.list
##    sample
## 1 HG02585
```

```
save(seqfile, file="seqfile.Rdata")
```

## 4.2 reporting of results

After finish all or some of the QC steps, the users can use `RenderReport` to generate the report in html format with optional interactive plots.

```
RenderReport(seqfile, output="report.html", interactive=TRUE)
```

# 5 How to get help for SeqSQC

Any SeqSQC question can be posted to the *Bioconductor support site*, which serves as a searchable knowledge base of questions and answers:

<https://support.bioconductor.org>

Posting a question and tagging with “SeqSQC” will automatically send an alert to the package authors to respond on the support site.

# 6 Session info

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
##  [1] SeqSQC_1.32.0       SNPRelate_1.44.0    gdsfmt_1.46.0
##  [4] ExperimentHub_3.0.0 AnnotationHub_4.0.0 BiocFileCache_3.0.0
##  [7] dbplyr_2.5.1        BiocGenerics_0.56.0 generics_0.1.4
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1     viridisLite_0.4.2    dplyr_1.1.4
##  [4] farver_2.1.2         blob_1.2.4           filelock_1.0.3
##  [7] Biostrings_2.78.0    S7_0.2.0             fastmap_1.2.0
## [10] lazyeval_0.2.2       GGally_2.4.0         digest_0.6.37
## [13] lifecycle_1.0.4      KEGGREST_1.50.0      RSQLite_2.4.3
## [16] magrittr_2.0.4       compiler_4.5.1       rlang_1.1.6
## [19] sass_0.4.10          tools_4.5.1          yaml_2.3.10
## [22] data.table_1.17.8    knitr_1.50           labeling_0.4.3
## [25] htmlwidgets_1.6.4    bit_4.6.0            curl_7.0.0
## [28] plyr_1.8.9           RColorBrewer_1.1-3   withr_3.0.2
## [31] purrr_1.1.0          grid_4.5.1           stats4_4.5.1
## [34] e1071_1.7-16         ggplot2_4.0.0        scales_1.4.0
## [37] tinytex_0.57         dichromat_2.0-0.1    cli_3.6.5
## [40] rmarkdown_2.30       crayon_1.5.3         httr_1.4.7
## [43] reshape2_1.4.4       DBI_1.2.3            cachem_1.1.0
## [46] proxy_0.4-27         stringr_1.5.2        AnnotationDbi_1.72.0
## [49] BiocManager_1.30.26  XVector_0.50.0       vctrs_0.6.5
## [52] jsonlite_2.0.0       bookdown_0.45        IRanges_2.44.0
## [55] S4Vectors_0.48.0     bit64_4.6.0-1        crosstalk_1.2.2
## [58] magick_2.9.0         plotly_4.11.0        jquerylib_0.1.4
## [61] tidyr_1.3.1          glue_1.8.0           ggstats_0.11.0
## [64] stringi_1.8.7        gtable_0.3.6         BiocVersion_3.22.0
## [67] GenomicRanges_1.62.0 tibble_3.3.0         pillar_1.11.1
## [70] rappdirs_0.3.3       htmltools_0.5.8.1    Seqinfo_1.0.0
## [73] R6_2.6.1             httr2_1.2.1          evaluate_1.0.5
## [76] Biobase_2.70.0       png_0.1-8            RhpcBLASctl_0.23-42
## [79] memoise_2.0.1        bslib_0.9.0          class_7.3-23
## [82] Rcpp_1.1.0           xfun_0.53            pkgconfig_2.0.3
```