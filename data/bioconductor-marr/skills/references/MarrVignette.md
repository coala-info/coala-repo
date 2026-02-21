Code

* Show All Code
* Hide All Code

# The marr user’s guide

Tusharkanti Ghosh1, Max McGrath1, Daisy Philtron2, Katerina Kechris1 and Debashis Ghosh1

1Colorado School of Public Health
2Penn State University

#### 30 October 2025

#### Abstract

marr (Maximum Rank Reproducibility) is a nonparametric approach that detects reproducible signals using a maximal rank statistic for high-dimensional biological data.

#### Package

marr 1.20.0

---

# 1 Introduction

Reproducibility is an on-going challenge with high-throughput technologies that
have been developed in the last two decades for quantifying a wide range of
biological processes. One of the main difficulties faced by researchers is the
variability of output across replicate experiments (Li et al. ([2011](#ref-li2011measuring))). Several
authors have addressed the issue of reproducibility among high-throughput
experiments (Porazinska et al. ([2010](#ref-porazinska2010reproducibility)), Marioni et al. ([2008](#ref-marioni2008rna)),
AC’t Hoen et al. ([2013](#ref-ac2013reproducibility))). In each high-throughput experiment (e.g., arrays,
sequencing, mass spectrometry), a large number of features are measured
simultaneously, and candidates are often subjected for follow-up statistical
analysis. We use the term features to refer to biological features (e.g.,
metabolites, genes) resulting from a high-throughput experiment in the rest of
this article. When measurements show consistency across replicate experiments,
we define that measurement to be reproducible. Similarly, measurements that are
not consistent across replicates may be problematic and should be identified. In
this vignette, features that show consistency across high-dimensional replicate
experiments are termed reproducible and the ones that are not consistent are
termed irreproducible. The reproducibility of a high-throughput experiment
primarily depends on the technical variables, such as run time, technical
replicates, laboratory operators and biological variables, such as healthy and
diseased subjects. A critical step toward making optimal design choices is to
assess how these biological and technical variables affect reproducibility
across replicate experiments (Talloen et al. ([2010](#ref-talloen2010filtering)),
Arvidsson et al. ([2008](#ref-arvidsson2008quantprime))).

In this vignette, we introduce the marr procedure Philtron et al. ([2018](#ref-Philtron2018)), referred to as
**maximum rank reproducibility** (**marr**) to identify reproducible features in
high-throughput replicate experiments. In this vignette, we demonstrate with an
example data set that the (ma)ximum (r)ank (r)eproducibility (marr) procedure
can be adapted to high-throughput MS-Metabolomics experiments across
(biological or technical) replicate samples
(Ghosh et al, 2020, in preparation).

The marr procedure was originally proposed to assess reproducibility of gene
ranks in replicate experiments. The `marr` R-package contains the `Marr()`
function, which calculates a matrix of signals (\(\text{irreproducible}=0\),
\(\text{reproducible}=1\)) with \(M\) rows (total number of features) and \(J\)
columns (\(J={I \choose 2}\)) (replicate sample pairs \({I \choose 2}\)), where
\(J\) is the total possible number of sample pairs of replicate experiments.
We assign feature \(m\) to be reproducible if a certain percentage signals
(\(100c\_s\%\)) are reproducible for pairwise combinations of replicate
experiments, i.e.,
if \[ \frac{{\sum\_{i<i'}{{{r\_{m,{(i,i')}}}}}}}{J} >c\_s, \]

such that, \(c\_s \in (0,1)\).

Similarly, we assign a sample pair \((i,~i')\) to be reproducible if a certain
percentage signals (\(100c\_m\%\)) are reproducible across all features, i.e.,
if \[ \frac{\sum\_{m}{{r{\_{m,(i,i')}}}}}{M}>c\_m, \]
such that, \(c\_m \in (0,1)\).

The reproducible signal matrix is shown in Figure 1 below.

![Reproducible Signal matrix](data:image/png;base64...)

Figure 1: Reproducible Signal matrix

# 2 Getting Started

Load the package in R

```
library(marr)
```

# 3 msprepCOPD Data

The **marr** package contains a pre-processed data `SummarizedExperiment` assay
object of 645 metabolites (features) measured in plasma and 20 biological
replicates from the multi-center Genetic Epidemiology of COPD (COPDGene) study
which was designed to study the underlying genetic factors of COPD,
(Regan et al. ([2011](#ref-Regan2010))). We only used a subset of the original raw COPD data in this
vignette.

## 3.1 msprepCOPD data pre-processing

The **msprepCOPD** data in the **marr** package was pre-processed using the
MSPrep software (Hughes et al. ([2013](#ref-Hughes2013))). The data pre-processing include \(3\) steps and
they are as follows:
1. `Filtering`: Metabolites are removed if they are missing more
than \(80\%\) of the samples, (Bijlsma et al. ([2006](#ref-Bijlsma2006)), Chong et al. ([2018](#ref-chong2018metaboanalyst))).
Originally, there were 662 metabolites in the raw data. After filtering,
645 metabolites remain.
2. `Missing value imputation technique`: We apply Bayesian Principal Component
Analysis (BPCA) to impute missing values (Hastie et al. ([1999](#ref-hastie1999imputing))).
3. `Normalization`: Median normalization are performed.

```
data("msprepCOPD")
msprepCOPD
```

```
## class: SummarizedExperiment
## dim: 645 20
## metadata(0):
## assays(1): abundance
## rownames: NULL
## rowData names(3): Mass Retention.Time Compound.Name
## colnames(20): 10062C 10071D ... 10473 10544U
## colData names(1): subject_id
```

# 4 Using the `Marr()` function

## 4.1 Input for `Marr()`

The `Marr()` function must have one object as input:
1. `object`: a data frame or a matrix or a SummarizedExperiment object with
abundance measurements of metabolites (features) on the rows and replicates
(samples) as the columns. `Marr()` accepts objects which are a data frame or
matrix with observations (e.g. metabolites) on the rows and replicates as the
columns.
2. `pSamplepairs`: **optional** We assign a metabolite (feature) for a replicate
sample pair to be reproducible using a threshold value of `pSamplepairs`
(\(c\_s=0.75\)).
3. `pFeatures`: **optional** We assign a sample pair for a metabolite (feature)
to be reproducible using a threshold value of `pFeatures` (\(c\_m=0.75\)).
4. `alpha`: **optional** level of significance to control the False Discovery
rate (FDR). Default is \(0.05\) (i.e., \(\alpha=0.05\)).

## 4.2 Running `Marr()`

### 4.2.1 msprepCOPD SummarizedExperiment example - Evaluating reproducibility

We apply the Marr procedure to assess the reproducibility of replicates in the
msprepCOPD data. The distribution of reproducible pairs and metabolites
(features) are illustrated in Figures 2 and 3, respectively.
To run the `Marr()` function, we only input the data object. We obtain 4 outputs
after running the `Marr()` function. They are shown below:

```
library(marr)
Marr_output<- Marr(msprepCOPD, pSamplepairs =
                   0.75, pFeatures = 0.75, alpha=0.05)
Marr_output
```

```
## Marr: Maximum Rank Reproducibility
## MarrSamplepairs (length = 190 ):
##   sampleOne sampleTwo reproducibility
## 1    10062C    10071D          60.000
## 2    10062C    10087S          64.651
## 3    10062C    10097V          60.620
## ...
## MarrFeatures (length = 645 ):
##     Mass Retention.Time              Compound.Name reproducibility
## 1 58.054          0.511          Aminoacetaldehyde             100
## 2 71.074          3.216            3-Buten-1-amine             100
## 3 85.089          2.119 2-Amino-3-methyl-1-butanol             100
## ...
```

```
## Head of reproducible sample pairs per metabolite (feature)
head(MarrFeatures(Marr_output))
```

```
##       Mass Retention.Time              Compound.Name reproducibility
## 1  58.0537      0.5107867          Aminoacetaldehyde       100.00000
## 2  71.0741      3.2161212            3-Buten-1-amine       100.00000
## 3  85.0893      2.1190255 2-Amino-3-methyl-1-butanol       100.00000
## 4  87.0687      0.5137375       4-Aminobutyraldehyde        16.31579
## 5 102.0782      0.6029379      N-Nitrosodiethylamine        20.52632
## 6 103.1000      3.8783060                    Neurine       100.00000
```

```
## Head of reproducible metabolites (features) per sample pair
head(MarrSamplepairs(Marr_output))
```

```
##   sampleOne sampleTwo reproducibility
## 1    10062C    10071D        60.00000
## 2    10062C    10087S        64.65116
## 3    10062C    10097V        60.62016
## 4    10062C    101020        51.78295
## 5    10062C    10104S        53.33333
## 6    10062C    10136F        55.50388
```

```
## Percent of reproducible sample pairs per metabolite (feature)
##greater than 75%
MarrFeaturesfiltered(Marr_output)
```

```
## [1] 49.45736
```

```
## Percent of reproducible metabolites (features) per sample pair
## greater than 75%
MarrSamplepairsfiltered(Marr_output)
```

```
## [1] 7.368421
```

The distribution of reproducible metabolites/features (sample pairs) per sample
pair (metabolite) can be extracted using the`MarrSamplepairs()`
(`MarrFeatures()`) function (see above). The distribution of reproducible
metabolites/features and sample pairs can plotted using the
`MarrPlotSamplepairs()` and `MarrPlotFeatures()` functions, respectively (see
below).

```
MarrPlotSamplepairs(Marr_output)
```

![Distribution of reproducible metabolites](data:image/png;base64...)

Figure 2: Distribution of reproducible metabolites

```
MarrPlotFeatures(Marr_output)
```

![Distribution of reproducible sample pairs](data:image/png;base64...)

Figure 3: Distribution of reproducible sample pairs

Figure 2 illustrates percentage of
reproducible metabolites (features) per sample pair in the
\(x\)-axis. In Figure 2, the higher percentage of reproducible metabolites
(features) per sample pair in the \(x\)-axis would indicate
stronger reproducibility between the sample pairs.

Figure 3 illustrates percentage of reproducible sample pairs
per metabolite (feature) in the \(x\)-axis. In Figure 3, the higher
percentage of reproducible sample pairs per metabolite
(feature) in the \(x\)-axis would indicate stronger reproducibility
of a metabolite (feature) across all sample pairs.

## 4.3 Filtering the data by reproducible features and/or sample pairs

```
## Filtering the data by reproducible features
MarrFilterData(Marr_output, by = "features")
```

```
## class: SummarizedExperiment
## dim: 319 20
## metadata(1): removedFeatures
## assays(1): abundance
## rownames: NULL
## rowData names(3): Mass Retention.Time Compound.Name
## colnames(20): 10062C 10071D ... 10473 10544U
## colData names(1): subject_id
```

```
## Filtering the data by reproducible sample pairs
MarrFilterData(Marr_output, by = "samplePairs")
```

```
## class: SummarizedExperiment
## dim: 645 16
## metadata(1): removedSamples
## assays(1): abundance
## rownames: NULL
## rowData names(3): Mass Retention.Time Compound.Name
## colnames(16): 10062C 10071D ... 10465Y 10473
## colData names(1): subject_id
```

```
## Filtering the data by both features and sample pairs
MarrFilterData(Marr_output, by = "both")
```

```
## class: SummarizedExperiment
## dim: 319 16
## metadata(2): removedSamples removedFeatures
## assays(1): abundance
## rownames: NULL
## rowData names(3): Mass Retention.Time Compound.Name
## colnames(16): 10062C 10071D ... 10465Y 10473
## colData names(1): subject_id
```

# 5 Session Info

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
## [1] marr_1.20.0      knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10                 generics_0.1.4
##  [3] SparseArray_1.10.0          lattice_0.22-7
##  [5] digest_0.6.37               magrittr_2.0.4
##  [7] evaluate_1.0.5              grid_4.5.1
##  [9] RColorBrewer_1.1-3          bookdown_0.45
## [11] fastmap_1.2.0               jsonlite_2.0.0
## [13] Matrix_1.7-4                tinytex_0.57
## [15] BiocManager_1.30.26         scales_1.4.0
## [17] jquerylib_0.1.4             abind_1.4-8
## [19] cli_3.6.5                   rlang_1.1.6
## [21] XVector_0.50.0              Biobase_2.70.0
## [23] withr_3.0.2                 cachem_1.1.0
## [25] DelayedArray_0.36.0         yaml_2.3.10
## [27] S4Arrays_1.10.0             tools_4.5.1
## [29] dplyr_1.1.4                 ggplot2_4.0.0
## [31] SummarizedExperiment_1.40.0 BiocGenerics_0.56.0
## [33] vctrs_0.6.5                 R6_2.6.1
## [35] magick_2.9.0                matrixStats_1.5.0
## [37] stats4_4.5.1                lifecycle_1.0.4
## [39] Seqinfo_1.0.0               S4Vectors_0.48.0
## [41] IRanges_2.44.0              pkgconfig_2.0.3
## [43] bslib_0.9.0                 pillar_1.11.1
## [45] gtable_0.3.6                glue_1.8.0
## [47] Rcpp_1.1.0                  xfun_0.53
## [49] tibble_3.3.0                GenomicRanges_1.62.0
## [51] tidyselect_1.2.1            dichromat_2.0-0.1
## [53] MatrixGenerics_1.22.0       farver_2.1.2
## [55] htmltools_0.5.8.1           labeling_0.4.3
## [57] rmarkdown_2.30              compiler_4.5.1
## [59] S7_0.2.0
```

# References

AC’t Hoen, Peter, Marc R Friedländer, Jonas Almlöf, Michael Sammeth, Irina Pulyakhina, Seyed Yahya Anvar, Jeroen FJ Laros, et al. 2013. “Reproducibility of High-Throughput mRNA and Small Rna Sequencing Across Laboratories.” *Nature Biotechnology* 31 (11): 1015.

Arvidsson, Samuel, Miroslaw Kwasniewski, Diego Mauricio Riaño-Pachón, and Bernd Mueller-Roeber. 2008. “QuantPrime–a Flexible Tool for Reliable High-Throughput Primer Design for Quantitative Pcr.” *BMC Bioinformatics* 9 (1): 465.

Bijlsma, Sabina, Ivana Bobeldijk, Elwin R Verheij, Raymond Ramaker, Sunil Kochhar, Ian A Macdonald, Ben Van Ommen, and Age K Smilde. 2006. “Large-Scale Human Metabolomics Studies: A Strategy for Data (Pre-) Processing and Validation.” *Analytical Chemistry* 78 (2): 567–74.

Chong, Jasmine, Othman Soufan, Carin Li, Iurie Caraus, Shuzhao Li, Guillaume Bourque, David S Wishart, and Jianguo Xia. 2018. “MetaboAnalyst 4.0: Towards More Transparent and Integrative Metabolomics Analysis.” *Nucleic Acids Research* 46 (W1): W486–W494.

Hastie, Trevor, Robert Tibshirani, Gavin Sherlock, Michael Eisen, Patrick Brown, and David Botstein. 1999. “Imputing Missing Data for Gene Expression Arrays.”

Hughes, Grant, Charmion Cruickshank-Quinn, Richard Reisdorph, Sharon Lutz, Irina Petrache, Nichole Reisdorph, Russell Bowler, and Katerina Kechris. 2013. “MSPrep—Summarization, Normalization and Diagnostics for Processing of Mass Spectrometry–Based Metabolomic Data.” *Bioinformatics* 30 (1): 133–34.

Li, Qunhua, James B Brown, Haiyan Huang, Peter J Bickel, and others. 2011. “Measuring Reproducibility of High-Throughput Experiments.” *The Annals of Applied Statistics* 5 (3): 1752–79.

Marioni, John C, Christopher E Mason, Shrikant M Mane, Matthew Stephens, and Yoav Gilad. 2008. “RNA-Seq: An Assessment of Technical Reproducibility and Comparison with Gene Expression Arrays.” *Genome Research* 18 (9): 1509–17.

Philtron, Daisy, Yafei Lyu, Qunhua Li, and Debashis Ghosh. 2018. “Maximum Rank Reproducibility: A Nonparametric Approach to Assessing Reproducibility in Replicate Experiments.” *Journal of the American Statistical Association* 113 (523): 1028–39.

Porazinska, Dorota L, WAY Sung, ROBIN M GIBLIN-DAVIS, and W Kelley Thomas. 2010. “Reproducibility of Read Numbers in High-Throughput Sequencing Analysis of Nematode Community Composition and Structure.” *Molecular Ecology Resources* 10 (4): 666–76.

Regan, Elizabeth A., John E. Hokanson, James R. Murphy, Barry Make, David A. Lynch, Terri H. Beaty, Douglas Curran-Everett, Edwin K. Silverman, and James D. Crapo. 2011. “Genetic Epidemiology of Copd (Copdgene) Study Design.” *COPD: Journal of Chronic Obstructive Pulmonary Disease* 7 (1): 32–43. <https://doi.org/10.3109/15412550903499522>.

Talloen, Willem, Sepp Hochreiter, Luc Bijnens, Adetayo Kasim, Ziv Shkedy, Dhammika Amaratunga, and Hinrich Göhlmann. 2010. “Filtering Data from High-Throughput Experiments Based on Measurement Reliability.” *Proceedings of the National Academy of Sciences* 107 (46): E173–E174.