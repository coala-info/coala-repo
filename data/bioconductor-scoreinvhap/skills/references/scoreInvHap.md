# Inversion genotyping with scoreInvHap

Carlos Ruiz-Arenas1,2, Alejandro Caceres1,2 and Juan R. Gonzalez1,2\*

1ISGlobal, Centre for Research in Environmental Epidemiology (CREAL)
2Bioinformatics Research Group in Epidemiolgy (BRGE)

\*juanr.gonzalez@isglobal.org

#### 2025-10-30

#### Package

scoreInvHap 1.32.0

# 1 Introduction

*scoreInvHap* genotypes inversions using SNP data. This method computes a similarity score between the available SNPs of an individual and experimental references for the three inversion-genotypes; NN: non-inverted homozygous, NI: inverted heterozygous and II: inverted homozygous. Individuals are classified into the inversion-genotypes with the highest score. There are other approaches to genotype inversions from SNP data: [inveRsion](https://bioconductor.org/packages/release/bioc/html/inveRsion.html), [invClust](http://nar.oxfordjournals.org/content/early/2015/02/05/nar.gkv073.full) or [PFIDO](https://github.com/MaxSalm/pfido). However, these approaches have limitations including:

* **they are based in population sample inferences**. When a new individual is included in the study the whole population sample needs to be reanalyzed. As they depend on dimensionality reduction methods, they are slow in the analysis of several individuals.
* **they can only handle limited number of samples**. They need large samples sizes for accurate inferences.
* **They are highly sensitive to SNP array densities**. Their accuracy depends on how clear the population sample can be partitioned, which depends on the amount and quality of informative SNPs.
* **They need external information to label the inversion-genotype clusters**. External validation of the clustering is performed at the end of the inference. If there are more than three clusters, it is not clear how which inversion genotype should be assigned to the clusters.

*scoreInvHap* overcomes these difficulties by using a set of reference genotypes from the inversion of interest. The methods is a supervised classifier that genotypes each individual according to their SNP similarities to the reference genotypes across the inverted segment. The classifier in particular uses the linkage desequillibrium (R2) between the SNPs and the inversion genoptypes, and the SNPs of each reference inversion-genotypes.

# 2 Inversion characterization

The package is loaded as usual

```
library(scoreInvHap)
```

*scoreInvHap* takes as input SNP data formated in either `SNPMatrix` or `VCF` Bioconductor’s objects. In the case of having data in `SNPMatrix` format, a list with two elements is required:

* genotypes: a SNPMatrix with individuals in rows and SNPs in columns
* map: a data.frame with the SNPs annotation. It *must* contain the columns *allele.1* and *allele.2* with the alleles of the SNPs.

If data is originally available in PLINK files (.bed, .bim), we can use the functions of *[snpStats](https://bioconductor.org/packages/3.22/snpStats)* to load the data as `SNPMatrix` object

```
library(snpStats)

## From a bed
snps <- read.plink("example.bed")

## From a pedfile
snps <- read.pedfile("example.ped", snps = "example.map")
```

In both cases, data is readily formatted for *scoreInvHap*.

If data is available in a variant call format (.vcf) file, we can load it in R into a `VCF` object, using the *[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)* package. *scoreInvHap* includes a small vcf in *scoreInvHap* as a demo. This file contains genotyped and imputed SNPs within inversion 7p11.2 for 30 European individuals from the 1000 Genomes project. We can load the vcf as follows

```
library(VariantAnnotation)
vcf_file <- system.file("extdata", "example.vcf", package = "scoreInvHap")
vcf <- readVcf(vcf_file, "hg19")
vcf
```

```
## class: CollapsedVCF
## dim: 380 30
## rowRanges(vcf):
##   GRanges with 5 metadata columns: paramRangeID, REF, ALT, QUAL, FILTER
## info(vcf):
##   DataFrame with 4 columns: AF, MAF, R2, ER2
## info(header(vcf)):
##        Number Type  Description
##    AF  1      Float Estimated Alternate Allele Frequency
##    MAF 1      Float Estimated Minor Allele Frequency
##    R2  1      Float Estimated Imputation Accuracy
##    ER2 1      Float Empirical (Leave-One-Out) R-square (available only for g...
## geno(vcf):
##   List of length 3: GT, DS, GP
## geno(header(vcf)):
##       Number Type   Description
##    GT 1      String Genotype
##    DS 1      Float  Estimated Alternate Allele Dosage : [P(0/1)+2*P(1/1)]
##    GP 3      Float  Estimated Posterior Probabilities for Genotypes 0/0, 0/1...
```

The object `vcf` contains 380 SNPs and 30 individuals.

*scoreInvHap* references were created using 1000 Genomes data. Thus, SNPs are annotated to the hg19 build in the plus strand. We have included a function that checks if input SNPs correspond to *scoreInvHap* references:

```
check <- checkSNPs(vcf)
check
```

```
## $genos
## class: CollapsedVCF
## dim: 307 30
## rowRanges(vcf):
##   GRanges with 5 metadata columns: paramRangeID, REF, ALT, QUAL, FILTER
## info(vcf):
##   DataFrame with 4 columns: AF, MAF, R2, ER2
## info(header(vcf)):
##        Number Type  Description
##    AF  1      Float Estimated Alternate Allele Frequency
##    MAF 1      Float Estimated Minor Allele Frequency
##    R2  1      Float Estimated Imputation Accuracy
##    ER2 1      Float Empirical (Leave-One-Out) R-square (available only for g...
## geno(vcf):
##   List of length 3: GT, DS, GP
## geno(header(vcf)):
##       Number Type   Description
##    GT 1      String Genotype
##    DS 1      Float  Estimated Alternate Allele Dosage : [P(0/1)+2*P(1/1)]
##    GP 3      Float  Estimated Posterior Probabilities for Genotypes 0/0, 0/1...
##
## $wrongAlleles
## NULL
##
## $wrongFreqs
## NULL
```

```
vcf <- check$genos
```

The function `checkSNPs` checks if the alleles in the SNP object are equal to those in *scoreInvHap* references. The function also tests if the frequencies are similar in the input data and in the references. `checkSNPs` returns a list with three elements. wrongAlleles are the SNPs with different alleles, wrongFreqs are the SNPs with different allele frequencies and `genos` is an object with the genotype data without SNPs failing any of the checks.

Now, we illustrate how to perform the inversion genotyping of inv7p11.2 for these data. The inversion calling requires two pieces of information:

* sample genotypes and their annotation (argument `SNPlist`),
* name of the inversion

Currently, there are 20 inversion references included in *scoreInvHap*. We included a table with their coordinates and scoreInvHap labels at the end of this document.

inv7p11.2 is labeled as `inv7_005` in *scoreInvHap*. We then obtain the inversion genotypes for the 30 individuals in our dataset as follows

```
res <- scoreInvHap(SNPlist = vcf, inv = "inv7_005")
res
```

```
## scoreInvHapRes
## Samples:  30
## Genotypes' table:
##  II   NI  NN
##  6    17  7
## - Inversion genotypes' table:
##  NN   NI  II
##  7    17  6
## - Inversion frequency: 48.33%
```

This function has a parameter called `BPPARAM` that allows paralell computing using `BiocParallel` infrastructure. For example, parallel computation using 8 cores would be run by executing

```
res <- scoreInvHap(SNPlist = vcf, inv = "inv7_005",
                   BPPARAM = BiocParallel::MulticoreParam(8))
```

The results of `scoreInvHap` are encapsulated in a object of class `scoreInvHapRes`. This object contains the classification of the individuals into the inversion-genotypes, as well as the similarity scores. We can retrieve results with the `classification` and the `scores` functions

```
# Get classification
head(classification(res))
```

```
## HG00096 HG00097 HG00099 HG00100 HG00101 HG00102
##      II      II      NI      NI      II      NN
## Levels: II NI NN
```

```
# Get scores
head(scores(res))
```

```
##              IaIa      IaIb      IbIb      NaIa      NaIb      NaNa      NaNb
## HG00096 0.7636176 0.7659578 0.9945596 0.6346131 0.7729563 0.7725742 0.4156252
## HG00097 0.7636176 0.7659578 0.9945596 0.6346131 0.7729563 0.7725742 0.4156252
## HG00099 0.6438462 0.7267291 0.7685422 0.7768338 0.9758600 0.7703418 0.5317241
## HG00100 0.3431981 0.4263283 0.4892990 0.2604141 0.4764038 0.3691768 0.6083141
## HG00101 0.9841178 0.7603894 0.7584714 0.7188997 0.6280646 0.7182172 0.3558992
## HG00102 0.2518848 0.1732271 0.3167020 0.1441663 0.1994766 0.3004813 0.5812806
##              NbIa      NbIb      NbNb
## HG00096 0.3784514 0.5670885 0.3911247
## HG00097 0.3784514 0.5670885 0.3911247
## HG00099 0.3025523 0.5345369 0.2689791
## HG00100 0.6376241 0.6834476 0.5605652
## HG00101 0.4545927 0.4165003 0.3266407
## HG00102 0.5527802 0.5480628 0.7223922
```

Inversion genotypes is returned as a factor, which includes the individual names present in the `snpMatrix` or `VCF`. Thus, inversion classification can be readily used in down-stream association tests.

## 2.1 Quality control

We can retrieve other values that are useful to evaluate the quality of the inference. For each individual, we can obtain the highest similarity score and the difference between the highest similarity score and the second highest:

```
# Get max score
head(maxscores(res))
```

```
##   HG00096   HG00097   HG00099   HG00100   HG00101   HG00102
## 0.9945596 0.9945596 0.9758600 0.6834476 0.9841178 0.7223922
```

```
# Get difference score
head(diffscores(res))
```

```
##   HG00096   HG00097   HG00099   HG00100   HG00101   HG00102
## 0.2216032 0.2216032 0.1990263 0.0458235 0.2237283 0.1411116
```

Classification is good when the highest score is close to 1 and the other scores are small. This means that the SNPs in the individual are almost identical to one of the reference genotypes and different from the rest. We can use the difference between the highest score and the second highest score as a quality measure. We can have a visual evaluation of the quality parameters with the function `plotScores`:

```
plotScores(res, pch = 16, main = "QC based on scores")
```

![](data:image/png;base64...)

The horizontal line is a threshold for quality, set to 0.1 but can be changed in the parameter `minDiff` in the function `scoreInvHap`. This default value considers that the SNPs of the individual are at least 10% more similar to the selected reference than to second one. `plotScores` can be customized.

Another quality measure is based on the number of SNPs used in the computation. *scoreInvHap* allows individuals having different SNP coverages within the inverted regions. SNPs with no information are excluded from the computation of the scores. To reflect this we report a SNP call rate:

```
# Get Number of scores used
head(numSNPs(res))
```

```
## HG00096 HG00097 HG00099 HG00100 HG00101 HG00102
##     307     307     307     307     307     307
```

```
# Get call rate
head(propSNPs(res))
```

```
## HG00096 HG00097 HG00099 HG00100 HG00101 HG00102
##       1       1       1       1       1       1
```

The number of SNPs must always be taken into account to evaluate the performance of the computation. It is highly recommended to use, at least, 15 SNPs in any inversion-calling. `plotCallRate` can be used to visualize the call rate

```
plotCallRate(res, main = "Call Rate QC")
```

![](data:image/png;base64...)

The vertical line is the minimum recommended call rate to consider a sample. By default, it is set to 0.9 but can be changed with the parameter `callRate`.

The function `classification` have two parameters that selects samples based on these two QC parameters. The argument `minDiff` sets the minimum difference between the highest and the second highest score. The argument `callRate` sets the minimum call rate of a sample to pass the QC. By default, both arguments are set to 0 so all the samples are included:

```
## No filtering
length(classification(res))
```

```
## [1] 30
```

```
## QC filtering
length(classification(res, minDiff = 0.1, callRate = 0.9))
```

```
## [1] 27
```

Finally, the function `classification` has the argument `inversion` that, when it is set to FALSE, haplotype-genotypes are called instead of inversion-genotuypes. This is useful for inversions that have more than one haplotype per inversion status:

```
## Inversion classification
table(classification(res))
```

```
##
## II NI NN
##  6 17  7
```

```
## Haplotype classification
table(classification(res, inversion = FALSE))
```

```
##
## IaIa IaIb IbIb NaIa NaIb NaNa NaNb NbIa NbIb NbNb
##    2    0    4    5    5    0    4    3    4    3
```

## 2.2 Imputed data

When SNPs data are imputed, we obtain three different types of results: the best-guess, the dosage and the posterior probabilities. By default, `scoreInvHap` uses the best-guess when computing the similarity scores. However, we can also use posterior probabilities setting the argument `probs` to TRUE:

```
res_imp <- scoreInvHap(SNPlist = vcf, inv = "inv7_005", probs = TRUE)
res_imp
```

```
## scoreInvHapRes
## Samples:  30
## Genotypes' table:
##  II   NI  NN
##  6    17  7
## - Inversion genotypes' table:
##  NN   NI  II
##  7    17  6
## - Inversion frequency: 48.33%
```

In this case, the samples were identically classified in both cases:

```
table(PostProbs = classification(res_imp),
      BestGuess = classification(res))
```

```
##          BestGuess
## PostProbs II NI NN
##        II  6  0  0
##        NI  0 17  0
##        NN  0  0  7
```

# 3 Other features

There are two additional parameters of `scoreInvHap` than can reduce computing time: `R2` and `BPPARAM`. `R2` indicates the minimum R2 that a SNP should have with the inversion to be included in the score. The less number of SNPs the less time it takes. By default, all SNPs are included in the computation. On the other hand, `BPPARAM` requires an instance of `BiocParallelParam`, which allows to parallelize the computation of the score. You can find more information about this class in its help page (`?bpparam`) and in the *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* vignette.

# 4 Inversions included in scoreInvHap

The following table describes the inversion includes in `scoreInvHap`:

Table 1: Inversions included in scoreInvHap
Length: inversion length in Kb in hg19. Num. Haplos: Number of haplotypes supported by the inversion. In parenthesis, number of standard and inverted haplotypes for inversions with more than two haplotypes.

| scoreInvHap Label | Locus | Length (Kb) | Num. Haplos |
| --- | --- | --- | --- |
| inv1\_004 | 1p22.1 | 0.77 | 2 |
| inv1\_008 | 1q31.1 | 1.2 | 2 |
| inv2\_002 | 2p22.3 | 0.72 | 2 |
| inv2\_013 | 2q22.1 | 4.25 | 2 |
| inv3\_003 | 3q26.1 | 2.28 | 4 (3/1) |
| inv6\_002 | 6p21.33 | 0.87 | 2 |
| inv6\_006 | 6q23.1 | 4.13 | 2 |
| inv7\_003 | 7p14.3 | 5.25 | 2 |
| inv7\_005 | 7p11.2 | 73.9 | 4 (2/2) |
| inv7\_011 | 7q11.22 | 12.7 | 2 |
| inv7\_014 | 7q36.1 | 2.08 | 2 |
| inv8\_001 | 8p23.1 | 3925 | 2 |
| inv11\_001 | 11p12 | 4.75 | 2 |
| inv11\_004 | 11q13.2 | 1.38 | 3 (2/1) |
| inv12\_004 | 12q21.2 | 19.3 | 2 |
| inv12\_006 | 12q21.2 | 1.03 | 3 (2/1) |
| inv14\_005 | 14q23.3 | 0.86 | 2 |
| inv16\_009 | 16p11.2 | 364.2 | 2 |
| inv17\_007 | 17q21.31 | 711 | 2 |
| inv21\_005 | 21q21.3 | 1.06 | 4 (3/1) |
| invX\_006 | Xq13.2 | 90.8 | 4 (3/1) |

This information is also available in `inversionGR`:

```
data(inversionGR)
inversionGR
```

```
## GRanges object with 22 ranges and 5 metadata columns:
##             seqnames              ranges strand | scoreInvHap.name
##                <Rle>           <IRanges>  <Rle> |      <character>
##    inv1_004     chr1   92131841-92132615      * |         inv1_004
##    inv1_008     chr1 197756784-197757982      * |         inv1_008
##    inv2_002     chr2   33764554-33765272      * |         inv2_002
##    inv2_013     chr2 139004949-139009203      * |         inv2_013
##    inv3_003     chr3 162545362-162547641      * |         inv3_003
##         ...      ...                 ...    ... .              ...
##   inv17_007    chr17   43661775-44372665      * |        inv17_007
##   inv21_005    chr21   28020653-28021711      * |        inv21_005
##    invX_006     chrX   72215927-72306774      * |         invX_006
##   inv16_009    chr16   28424774-28788943      * |        inv16_009
##   inv10_005    chr10   27220925-27656433      * |        inv10_005
##             Cytogenetic.location  Inv.freq Haplotypes  Num.SNPs
##                      <character> <numeric>  <numeric> <numeric>
##    inv1_004               1p22.1     11.23          2         6
##    inv1_008               1q31.3     19.68          2         5
##    inv2_002               2p22.3     15.11          2         6
##    inv2_013               2q22.1     71.47          2        13
##    inv3_003               3q26.1     56.16          4         6
##         ...                  ...       ...        ...       ...
##   inv17_007             17q21.31     23.96          2      3637
##   inv21_005              21q21.3     51.29          4        11
##    invX_006               Xq13.2     13.30          4       135
##   inv16_009              16p11.2     34.49          2       361
##   inv10_005                 <NA>        NA         NA        NA
##   -------
##   seqinfo: 14 sequences from an unspecified genome; no seqlengths
```

# 5 sessionInfo

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
##  [1] snpStats_1.60.0             Matrix_1.7-4
##  [3] survival_3.8-3              VariantAnnotation_1.56.0
##  [5] Rsamtools_2.26.0            Biostrings_2.78.0
##  [7] XVector_0.50.0              SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              GenomicRanges_1.62.0
## [11] IRanges_2.44.0              S4Vectors_0.48.0
## [13] Seqinfo_1.0.0               MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           BiocGenerics_0.56.0
## [17] generics_0.1.4              scoreInvHap_1.32.0
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0          rjson_0.2.23             xfun_0.53
##  [4] bslib_0.9.0              lattice_0.22-7           vctrs_0.6.5
##  [7] tools_4.5.1              bitops_1.0-9             curl_7.0.0
## [10] parallel_4.5.1           AnnotationDbi_1.72.0     RSQLite_2.4.3
## [13] blob_1.2.4               BSgenome_1.78.0          cigarillo_1.0.0
## [16] lifecycle_1.0.4          compiler_4.5.1           tinytex_0.57
## [19] codetools_0.2-20         htmltools_0.5.8.1        sass_0.4.10
## [22] RCurl_1.98-1.17          yaml_2.3.10              crayon_1.5.3
## [25] jquerylib_0.1.4          BiocParallel_1.44.0      DelayedArray_0.36.0
## [28] cachem_1.1.0             magick_2.9.0             abind_1.4-8
## [31] digest_0.6.37            restfulr_0.0.16          bookdown_0.45
## [34] splines_4.5.1            fastmap_1.2.0            grid_4.5.1
## [37] cli_3.6.5                SparseArray_1.10.0       magrittr_2.0.4
## [40] S4Arrays_1.10.0          GenomicFeatures_1.62.0   XML_3.99-0.19
## [43] bit64_4.6.0-1            rmarkdown_2.30           httr_1.4.7
## [46] bit_4.6.0                png_0.1-8                memoise_2.0.1
## [49] evaluate_1.0.5           knitr_1.50               BiocIO_1.20.0
## [52] rtracklayer_1.70.0       rlang_1.1.6              Rcpp_1.1.0
## [55] DBI_1.2.3                BiocManager_1.30.26      jsonlite_2.0.0
## [58] R6_2.6.1                 GenomicAlignments_1.46.0
```