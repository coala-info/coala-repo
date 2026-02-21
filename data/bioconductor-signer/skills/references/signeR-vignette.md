#### Table of contents

* [1: Introduction](#toc1)
* [2: Installation](#toc2)
* [3: Preparing the input](#toc3)
  + [3.1: Input from VCF](#toc3.1)
  + [3.2: Input from MAF](#toc3.2)
  + [3.3: Input from tab-delimited file](#toc3.3)
  + [3.4: Known signatures](#toc3.4)
* [4: Estimating the number of mutational processes and their
  signatures](#toc4)
* [5: Estimating exposures to known signatures](#toc5)* [6: Results and plots](#toc6)
    + [6.1: Plot the MCMC paths for the NMF parameters](#toc6.1)
    + [6.2: Plot the signatures](#toc6.2)
      - [Signature barplot](#toc6.2.1)
      - [Signature heatmap](#toc6.2.2)
    + [6.3: Plot the exposures](#toc6.3)
      - [Exposure boxplot](#toc6.3.1)
      - [Exposure barplot](#toc6.3.2)
      - [Exposure heatmap](#toc6.3.3)
  * [7: Supervised approaches to exposure analysis](#toc7)
    + [7.1: Differential Exposure Analysis](#toc7.1)
    + [7.2: Sample Classification](#toc7.2)
    + [7.3: Correlation Analysis](#toc7.3)
    + [7.4: Linear Regression](#toc7.4)
    + [7.5: Survival Analysis](#toc7.5)
    + [7.6: Cox Regression](#toc7.6)
  * [8: Unsupervised approaches to exposure analysis](#toc8)
    + [8.1: Hierarquical Clustering](#toc8.1)
    + [8.2: Fuzzy Clustering](#toc8.2)
  * [9: Frequently Asked Questions](#toc9)
    + [9.1: Citing signeR](#toc9.1)
    + [9.2: Compilation errors on OS X](#toc9.2)
    + [9.3: Missing library headers](#toc9.3)
  * [10: References](#toc10)

# signeR

#### *Rodrigo Drummond, Renan Valieris, Rafael Rosales and Israel Tojal da Silva*

## 1: Introduction

Motivation: Cancer is an evolutionary process driven by continuous
acquisition of genetic variations in individual cells. The diversity and
the complexity of somatic mutational processes is a conspicuous feature
orchestrated by DNA damage agents and repair processes, including exogenous or
endogenous mutagen exposures, defects in DNA mismatch repair and enzymatic
modification of DNA. The identification of the underlying mutational processes
are central to the understanding of cancer origin and evolution.

The **signeR** package focuses on the estimation and further analysis of
mutational signatures. The functionalities of this package can be divided into
three categories. First, it provides tools to process VCF files and generate
matrices of SNV mutation counts and mutational opportunities, both defined
according to a 3bp context (mutation site and its neighboring 3' and 5' bases).
Second, these count matrices are considered as input for the estimation of the
underlying mutational signatures and the number of active mutational processes.
Third, the package provides tools to correlate the activities of those
signatures with other relevant information such as clinical data, in order to
draw conclusions about the analyzed genome samples, which can be useful for
clinical applications. These include the Differential Exposure Score and the a
posteriori sample classification.

Although signeR is intended for the estimation of mutational signatures, it
actually provides a full Bayesian treatment to the non-negative matrix
factorisation (NMF) model. Further details about the method can be found in
Rosales & Drummond *et al.*, 2016 (see [section 9.1](#toc9.1)
below).

This vignette briefly explains the use of **signeR** through examples.

## 2: Installation

Before installing, please make sure you have the latest version of R and
[Bioconductor](http://bioconductor.org/) installed.

To install **signeR**, start R and enter:

```
install.packages("BiocManager")
BiocManager::install("signeR")
```

For more information, see
[this page](http://bioconductor.org/packages/signeR).

Once installed the library can be loaded as

```
library(signeR)
```

OS X users might experience compilation errors due to
missing gfortran libraries. Please read [this section](#toc9.2).

## 3: Preparing the input

**signeR** takes as input a count matrix of samples x features.
Each feature is usually an SNV mutation within a 3bp context (96 features, 6
types of SNV mutations and 4 possibilities for the bases at each side of the
SNV change). Optionally, an opportunity matrix can also be provided containing
the count frequency of the features in the whole analyzed region for each
sample. Although not required, this argument is highly recommended because it
allows **signeR** to normalize the feature frequency over the analyzed
region.

Input matrices can be read both from a VCF, MAF or a tab-delimited file, as
described next.

### 3.1: Input from VCF

The [VCF](http://www.1000genomes.org/wiki/Analysis/vcf4.0) file format is
the most common format for storing genetic variations, the **signeR**
package includes a utility function for generating a count matrix from the VCF:

```
library(VariantAnnotation)

# BSgenome, equivalent to the one used on the variant call
library(BSgenome.Hsapiens.UCSC.hg19)

vcfobj <- readVcf("/path/to/a/file.vcf", "hg19")
mut <- genCountMatrixFromVcf(BSgenome.Hsapiens.UCSC.hg19, vcfobj)
```

This function will generate a matrix of mutation counts for each sample in
the provided VCF.

If you have one VCF per sample you can combine the results into a single
matrix like this:

```
mut = matrix(ncol=96,nrow=0)
for(i in vcf_files) {
    vo = readVcf(i, "hg19")
    # sample name (should pick up from the vcf automatically if available)
    # colnames(vo) = i
    m0 = genCountMatrixFromVcf(mygenome, vo)
    mut = rbind(mut, m0)
}
dim(mut) # matrix with all samples
```

The opportunity matrix can also be generated from the
reference genome (hg19 in the following case):

```
library(rtracklayer)

target_regions <- import(con="/path/to/a/target.bed", format="bed")
opp <- genOpportunityFromGenome(BSgenome.Hsapiens.UCSC.hg19,
    target_regions, nsamples=nrow(mut))
```

Where `target.bed` is a [bed file](https://genome.ucsc.edu/FAQ/FAQformat.html#format1)
containing the genomic regions analyzed by the variant caller.

If a BSgenome is not available for your genome, you can use a fasta file:

```
library(Rsamtools)

# make sure /path/to/genome.fasta.fai exists !
# you can use "samtools faidx" command to create it
mygenome <- FaFile("/path/to/genome.fasta")

mut <- genCountMatrixFromVcf(mygenome, vcfobj)
opp <- genOpportunityFromGenome(mygenome, target_regions)
```

### 3.2: Input from MAF

The [MAF](https://docs.gdc.cancer.gov/Encyclopedia/pages/Mutation_Annotation_Format/)
file format is another popular format for storing somatic genetic variants,
the signeR package also includes a function for generating a count matrix from the MAF:

```
mut <- genCountMatrixFromMAF(mygenome, "my_file.maf")
```

### 3.3: Input from tab-delimited file

By convention, the input file should be tab-delimited with sample names as
row names and features as column names. Features should be referred to in the
format "base change:triplet", e.g. "C>A:TCG", as can be seen in the example
below. Similarly, the opportunity matrix can be provided in a tab-delimited
file with the same structure as the mutation counts file. An example of the
required matrix format can be seen
[here](https://github.com/TojalLab/signeR/blob/devel/inst/extdata/21_breast_cancers.mutations.txt).

This tutorial uses as input the 21 breast cancer dataset described in
[Nik-Zainal et al 2012](http://dx.doi.org/10.1016/j.cell.2012.04.023). For the sake of convenience, this dataset is
included with the package and can be accessed by using the
`system.file` function:

```
mut <- read.table(system.file("extdata","21_breast_cancers.mutations.txt",
    package="signeR"), header=TRUE, check.names=FALSE)
opp <- read.table(system.file("extdata","21_breast_cancers.opportunity.txt",
    package="signeR"))
```

### 3.4: Known signatures

signeR analysis can incorporate any previous knowledge about the signatures present in the dataset. If signatures are known in advance, they can be provided as a matrix, which may be used by signeR in two different ways: a starting value that will be updated according to mutation patterns found on present data or a fixed set of parameters, kept unchanged during the estimation of exposures.

The signatures matrix shall contain each signature in one column. An example of the required matrix format can be seen
[here](https://github.com/TojalLab/signeR/blob/devel/inst/extdata/Cosmic_signatures_BRC.txt).

Along this tutorial a matrix of signatures found in breast cancer, as described in
[Cosmic database](https://cancer.sanger.ac.uk/cosmic/signatures_v2). For the sake of convenience this matrix is included with the
package and can be accessed by the
`system.file` function:

```
Pmatrix <- as.matrix(read.table(system.file("extdata","Cosmic_signatures_BRC.txt",
    package="signeR"), sep="\t", check.names=FALSE))
```

## 4: Estimating the number of mutational processes and their signatures

**signeR** takes a count matrix as its only required parameter, but the
user can provide an opportunity matrix as well. The algorithm allows the
assessment of the number of signatures by three options, as follows.

1. signeR detects the number of signatures at run time by considering the best
   NMF factorization rank between 1 and min(G, K)-1, with G = number of genomes and
   K = number of features (i.e. 96):

   ```
   signatures <- signeR(M=mut, Opport=opp)
   ```
2. The user can give an interval of the possible numbers of signatures as the
   parameter nlim. **signeR** will calculate the optimal number of signatures
   within this range, for example:

   ```
   signatures <- signeR(M=mut, Opport=opp, nlim=c(3,7))
   ```
3. **signeR** can also be run by passing the number of signatures
   as the parameter nsig. In this setting, the algorithm is faster. For example,
   the following command will make **signeR** consider only the rank N=5 to
   estimate the signatures and their exposures:

   ```
   signatures <- signeR(M=mut, Opport=opp, nsig=3, main_eval=100, EM_eval=50, EMit_lim=20)
   ```
4. Finally, when signatures are known in advance, **signeR** can use them as
   a starting point for the estimation of signatures in the present dataset. To this end, signatures must be provided in a matrix, as described in item 3.4 above. For example,
   the following command will make **signeR** use six Cosmic signatures found on breast cancer as a starting point:

   ```
   signatures.Pstart <- signeR(M=mut, Opport=opp, P=Pmatrix, fixedP=FALSE, main_eval=100, EM_eval=50, EMit_lim=20)
   ```

The parameters `testing_burn` and `testing_eval`
control the number of iterations used to estimate the number of signatures
(default value is 1000 for both parameters). There are other
arguments that may be passed on to signeR. Please have a look at signeR's
manual, issued by typing `help(signeR)`.

Whenever **signeR** is left to decide which number of signatures is
optimal, it will search for the rank Nsig that maximizes the median Bayesian
Information Criterion (BIC). After the processing is done, this information can
be plotted by the following command:

```
BICboxplot(signatures)
```

![](data:image/png;base64...)

Boxplot of BIC values, showing that the optimal number of signatures for this dataset is 5.

## 5: Estimating exposures to known signatures.

**signeR** also offers the possibility to estimate exposures to known signatures as, for example, the ones described on  [Cosmic database](https://cancer.sanger.ac.uk/cosmic/signatures_v2). In this case, signatures should be provided in a matrix, as described in item 3.4 above, and should be kept constant during analysis:

```
Pmatrix <- as.matrix(read.table(system.file("extdata","Cosmic_signatures_BRC.txt",
    package="signeR"), sep="\t", check.names=FALSE))
```

The following command will make **signeR** estimate the exposures to the Cosmic signatures found on breast cancer:

```
exposures.known.sigs <- signeR(M=mut, Opport=opp, P=Pmatrix, fixedP=TRUE, main_eval=100, EM_eval=50, EMit_lim=20)
```

Exposures can then be recovered from the signeR output by the following command (as in any signeR analysis):

```
exposures <- Median_exp(exposures.known.sigs$SignExposures)
```

## 6: Results and plots

**signeR** offers several plots to visualize estimated signatures and their exposures, as well as the convergence of the MCMC used to estimate them.

### 6.1: Plot the MCMC paths for the NMF parameters (P and E matrices)

The following instruction plots the MCMC sample paths for each entry of the
signature matrix P and their exposures, i.e. the E matrix. Only post-burnin
paths are available for plotting. Those plots are useful for checking if
entries have leveled off, reflecting the sampler convergence.

```
Paths(signatures$SignExposures)
```

![plot of chunk unnamed-chunk-20](data:image/png;base64...)

Each plot shows the entries and exposures of
one signature along sampler iterations.

### 6.2: Plot the signatures

Once the processing is done, the estimated signatures can be displayed in two
charts, described below.

#### Signature barplot

Signatures can be visualized in a barplot by issuing the following command:

```
SignPlot(signatures$SignExposures)
```

![plot of chunk unnamed-chunk-21](data:image/png;base64...)

Signatures barplot with error bars reflecting
the sample percentiles 0.05, 0.25, 0.75, and 0.95 for each entry.

#### Signature heatmap

Estimated signatures can also be visualized in a heatmap, generated by the
following command:

```
SignHeat(signatures$SignExposures)
```

![plot of chunk unnamed-chunk-22](data:image/png;base64...)

Heatmap showing the entries of each signature.

### 6.3: Plot the exposures

The relative contribution of each signature to the inspected genomes can be
displayed in several ways. **signeR** currently provides three alternatives.

#### Exposure boxplot

The levels of exposure to each signature in all genome samples can also be
plotted:

```
ExposureBoxplot(signatures$SignExposures)
```

![plot of chunk unnamed-chunk-23](data:image/png;base64...)

#### Exposure barplot

The contribution of the signatures to the mutations found on each
genome sample can also be visualized in a barplot, plotted by the following command:

```
ExposureBarplot(signatures$SignExposures)
```

![plot of chunk unnamed-chunk-24](data:image/png;base64...)

Barplot showing the contributions of the signatures to genome samples
mutation counts.

The **relative** contribution of signatures on each
genome sample can also be visualized in a barplot, setting the
**relative** parameter to TRUE:

```
ExposureBarplot(signatures$SignExposures, relative=TRUE)
```

![plot of chunk unnamed-chunk-25](data:image/png;base64...)

Barplot showing the relative contributions of signatures to genome samples.

#### Exposure heatmap

The levels of exposure to each signature can also be plotted in a heatmap:

```
ExposureHeat(signatures$SignExposures)
```

![plot of chunk unnamed-chunk-26](data:image/png;base64...)

Heatmap showing the exposures for each genome
sample. Samples are grouped according to their levels of exposure to the
signatures, as can be seen in the dendrogram on the left.

## 7: Supervised approaches to exposure analysis

If additional information is available for the samples analyzed **signeR**
is able to evaluate how those relate to the estimated exposures to mutational
signatures. When additional data is categorical, differences in exposures among
groups can be analyzed and if some of the samples are unlabeled they can be
labeled based on the similarity of their exposure profiles to those of labeled
samples. In the case of a continuous additional feature, its correlation to
estimated exposures can be evaluated. Survival data can also be analyzed and
the relation of signatures to survival can be accessed. In every case, analyses
are repeated for all samples of the exposure matrix generated by **signeR**
sampler and results are considered significant if they are consistently found
on most of them.

### 7.1: Differential Exposure Analysis

**signeR** can highlight signatures that are differentially active among
previously defined groups of samples. To perform this task **signeR** needs
a vector of group labels. In this example the samples were divided according to
germline mutations at BRCA genes: groups `wt`,
`BRCA1+` and `BRCA2+`, taken from the description of the
21 breast cancer data set.

```
# group labels, respective to each row of the mutation count matrix
BRCA_labels <- c("wt","BRCA1+","BRCA2+","BRCA1+","BRCA2+","BRCA1+","BRCA1+",
    "wt","wt","wt","wt","BRCA1+","wt","BRCA2+","BRCA2+","wt","wt","wt",
    "wt","wt","wt")

diff_exposure <- DiffExp(signatures$SignExposures, labels=BRCA_labels)
```

![plot of chunk unnamed-chunk-27](data:image/png;base64...)

![plot of chunk unnamed-chunk-27](data:image/png;base64...)

**Top chart:** DES plot showing that the
BRCA+ samples were significantly more exposed to signatures S3, S4 and S5.
**Bottom chart:** plots showing the significant differences found when groups
are compared against each other. These last plots are generated only when there
are more than two groups in the analysis and any signature is found to be
differentially active. Groups marked by the same letter are not significantly
different from the corresponding signature.

The `Pvquant` vector holds the pvalues quantile of the test for
each signature (by default, the 0.5 quantile, i.e. the median). The logarithms
of those are considered the Differential Exposure Scores (DES). Signatures with
`Pvquant` values below the cutoff, 0.05 by default, are considered
differentially exposed.

```
# pvalues
diff_exposure$Pvquant
```

```
## [1] 0.7732577405 0.0008188777 0.3970037614
```

The `MostExposed` vector contains the name of the group where each
differentially exposed signature showed the highest levels of activity.

```
# most exposed group
diff_exposure$MostExposed
```

```
## [1] NA       "BRCA1+" NA
```

### 7.2: Sample Classification

**signeR** can also classify samples based on their exposures to mutational
processes. In order to do this, a vector of target labels must be provided to the
function ExposureClassify. Samples corresponding to NA values in this vector will
be classified according to the similarity of their mutational profiles to the ones
of labeled samples. Several classification algorithms are available: k-nearest
neighbor (knn), linear vector quantization (lvq), Logistic regression (logreg),
linear discriminant analysis (lda), least absolute shrinkage and selection operator
(lasso), naive bayes(nb), support vector machines (svm), random forests (rf) and
adaboost (ab). The following example uses the sample labels defined in the DES
analysis performed previously.

```
# note that BRCA_labels [15],[20] and [21] are set to NA
BRCA_labels <- c("wt","BRCA+","BRCA+","BRCA+","BRCA+","BRCA+","BRCA+","wt","wt",
    "wt","wt","BRCA+","wt","BRCA+",NA,"wt","wt","wt","wt",NA,NA)

Class <- ExposureClassify(signatures$SignExposures, labels=BRCA_labels, method="knn")
```

![plot of chunk unnamed-chunk-30](data:image/png;base64...)

Barplot showing the relative frequencies of
assignment of each unlabeled sample to the selected group.

```
# Final assignments
Class$class
```

```
## PD4116a PD4199a PD4248a
## "BRCA+"    "wt"    "wt"
```

```
# Relative frequencies of assignment to selected groups
Class$freq
```

```
## PD4116a PD4199a PD4248a
##       1       1       1
```

```
# All assigment frequencies
Class$allfreqs
```

```
##       PD4116a PD4199a PD4248a
## BRCA+     100       0       0
## wt          0     100     100
```

### 7.3: Correlation Analysis

When a continuous feature is available for the samples being analyzed, **signeR** can evaluate its correlation to exposures to mutational signatures. The following command applies the `cor.test` function to evaluate the correlation between the provided feature and the levels of exposure of each signature:

```
# feature values, respective to each row of the mutation count matrix.
# The feature simulated below will be correlated with exposures to signature 2.
myFeature <- (10^6)*Median_exp(signatures$SignExposures)[2,] + rnorm(21,0,1)

ExpCorr <- ExposureCorrelation(signatures$SignExposures, feature=myFeature)
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![plot of chunk unnamed-chunk-32](data:image/png;base64...)

P-values boxplot and scatterplots showing the correlations of exposures and
the provided feature.

The output `ExpCorr` will contain a list with two vectors: the estimated correlations of the signatures to the feature and their estimated pvalues.

### 7.4: Linear Regression

A continuous feature may also be modeled by its exposure to mutational signatures. The following command applies the `glm` function to fit a linear model with the provided feature as output of the levels of exposures to mutational signatures:

```
ExpLM <- ExposureGLM(signatures$SignExposures, feature=myFeature)
```

![plot of chunk unnamed-chunk-33](data:image/png;base64...)

P-values boxplot showing the relevance of exposures in final model of provided feature.

### 7.5: Survival Analysis

If survival data is available for the samples being analyzed, **signeR** can evaluate the effect of exposure on survival. The following function performs an independent test for the exposure levels of each mutational signature, as opposed to the `Cox regression` described in next item. If `method = logrank` samples are separated according to their exposure and top and bottom groups are compared by the log-rank test. Otherwise, `method = cox` and a Cox's proportional hazards model are fitted to exposure levels and evaluate their effects upon survival.

```
# survival times and censoring, respective to each row of the mutation count matrix.
#Time is simulated so that it is correlated to exposures to signature 3.
critical_sig<-Median_exp(signatures$SignExposures)[2,]
probs<-(critical_sig-min(critical_sig))/(max(critical_sig)-min(critical_sig))
su<-as.matrix(data.frame(time=sample(80:150,21,replace=T),
                         status=sapply(probs,function(p){sample(c(0,1),1,prob=c(p,1-p))})))

ExpSurv <- ExposureSurvival(Exposures=signatures$SignExposures,
                            surv=su, method="logrank")
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the ggpubr package.
##   Please report the issue at <https://github.com/kassambara/ggpubr/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![plot of chunk unnamed-chunk-34](data:image/png;base64...)

P.values boxplots and plots of survival data comparing, for each signature, sample groups showing top or bottom exposure levels.

```
ExpSurv.cox <- ExposureSurvival(Exposures=signatures$SignExposures,
                                surv=su, method="cox")
```

```
## Warning: Removed 1 row containing missing values or values outside the scale range
## (`geom_segment()`).
```

![plot of chunk unnamed-chunk-35](data:image/png;base64...)

P.values boxplots and forest plot showing the effect of each signature upon survival according to univariate Cox's proportional hazards model.

### 7.6: Cox regression

signeR can also evaluate the combined effect on survival of exposure levels to different signatures. The following command fits Cox's proportional hazards model on exposures. It generates a p-values boxplot and a forest plot (from package **forestplot**) to show the relevance of each mutational signature to survival.

```
BRCA_labels <- c("wt","BRCA+","BRCA+","BRCA+","BRCA+","BRCA+","BRCA+",
    "wt","wt","wt","wt","BRCA+","wt","BRCA+","BRCA+","wt","wt","wt",
    "wt","wt","wt")

ExpSurvMd <- ExposureSurvModel(Exposures=signatures$SignExposures, surv=su, addata=data.frame(as.factor(BRCA_labels)))
```

```
## Warning in coxph.fit(X, Y, istrat, offset, init, control, weights = weights, :
## Loglik converged before variable 1 ; coefficient may be infinite.
```

```
## Warning: Removed 1 row containing missing values or values outside the scale range
## (`geom_pointrange()`).
```

```
## Warning: Removed 1 row containing missing values or values outside the scale range
## (`geom_segment()`).
```

```
## Warning: Removed 2 rows containing missing values or values outside the scale range
## (`geom_segment()`).
```

![plot of chunk unnamed-chunk-36](data:image/png;base64...)

Forestplot: Cox proportional model p-values and hazard ratios for each signature.

## 8: Unsupervised approaches to exposure analysis

When no additional information is available for the samples analyzed,
**signeR** can search patterns on estimated exposures. Unsupervised analysis
can be performed on all generated samples of the exposure matrix and consistent
results are reported as significant.

### 8.1: Hierarchical Clustering

Samples can be hierarchically clustered according to their exposures to mutational signatures. The function `HClustExp` applies the R function `hclust` to each sampled exposure matrix. Dendogram branches consistently found in most of the analyses are reported:

```
# feature values, respective to each row of the mutation count matrix
HCE <- HClustExp(signatures$SignExposures,method.dist="euclidean", method.hclust="average")
```

![plot of chunk unnamed-chunk-37](data:image/png;base64...)

Hierarchical structure found on data, each branch showing the frequency of its occurrence in the analysis of sampled exposure matrices.

### 8.2: Fuzzy Clustering

**signeR** can also perform a Fuzzy clustering of the samples according to their exposures to mutational signatures. The function `FuzzyClustExp` applies a clustering algorithm (hard or fuzzy) to each sampled exposure matrix and averages the fuzzy membership degrees of samples to clusters. The number of clusters can be defined by the user (Clim parameter), otherwise different numbers of clusters are tested and the one that maximizes the PBMF index is used (the search algorithm used is similar to the one applied to estimate the number of signatures present in a dataset):

```
FCE <- FuzzyClustExp(signatures$SignExposures, Clim=c(3,7))
```

```
## Evaluating models with the number of groups ranging from 3 to 7, please be patient.
## Testing 3 groups.
## Testing 4 groups.
## Testing 5 groups.
## Testing 6 groups.
## Testing 7 groups.
## Optimum number of groups is 7. Performing final clustering.
```

![plot of chunk unnamed-chunk-38](data:image/png;base64...)

![plot of chunk unnamed-chunk-38](data:image/png;base64...)

![plot of chunk unnamed-chunk-38](data:image/png;base64...)

![plot of chunk unnamed-chunk-38](data:image/png;base64...)

![plot of chunk unnamed-chunk-38](data:image/png;base64...)

Heatmap showing the mean fuzzy membership degrees of
samples to clusters.

The function's output is a list of three elements: the mean matrix of fuzzy membership degrees of samples to clusters, the full array of all fuzzy membership degrees found by the analysis of sampled exposure matrices and the matrix of membership degrees found by the analysis of median exposures of samples to signatures.

## 9: Frequently Asked Questions

### 9.1: Citing signeR

If you use the **signeR** package in your work, please cite it:

```
citation("signeR")
```

```
## To cite package 'signeR' in publications use:
##
##   Rafael A. Rosales, Rodrigo D. Drummond, Renan Valieris, Emmanuel
##   Dias-Neto, and Israel T. da Silva (2016): signeR: An empirical
##   Bayesian approach to mutational signature discovery. Bioinformatics
##   September 1, 2016 doi:10.1093/bioinformatics/btw572
##
## A BibTeX entry for LaTeX users is
##
##   @Article{,
##     title = {signeR: An empirical Bayesian approach to mutational signature discovery.},
##     author = {Rafael A. Rosales and Rodrigo D. Drummond and Renan Valieris and Emmanuel Dias-Neto and Israel T. da Silva},
##     year = {2016},
##     journal = {Bioinformatics},
##     doi = {10.1093/bioinformatics/btw572},
##   }
```

### 9.2: Compilation errors on OS X

OS X users might get compilation errors similar to these:

```
ld: warning: directory not found for option '-L/usr/local/lib/x86_64'
ld: library not found for -lgfortran
ld: library not found for -lquadmath
```

This problem arises when the machine is missing gfortran libraries
necessary to compile RcppArmadillo and signeR.
To install the missing libraries, execute these lines on a terminal:

```
curl -O http://r.research.att.com/libs/gfortran-4.8.2-darwin13.tar.bz2
sudo tar fvxz gfortran-4.8.2-darwin13.tar.bz2 -C /
```

For more information [see this post](http://thecoatlessprofessor.com/programming/rcpp-rcpparmadillo-and-os-x-mavericks-lgfortran-and-lquadmath-error/) and the
[Rcpp FAQ, section 2.16](http://dirk.eddelbuettel.com/code/rcpp/Rcpp-FAQ.pdf).

### 9.3: Missing library headers

Some packages that signeR depends on require that 3rd party library headers be installed. If you see errors like:

```
Error: checking for curl-config... no
         Cannot find curl-config
```

or

```
libopenblas.so.0 not found
```

It means you need to install these headers with your package manager. For example on Ubuntu:

```
$ sudo apt-get install libcurl4-openssl-dev libopenblas-dev
```

## 10: References

L. B. Alexandrov, S. Nik-Zainal, D. C. Wedge, P. J. Campbell, and M. R.
Stratton. Deciphering Signatures of Mutational Processes Operative in Human
Cancer. Cell Reports, 3(1):246-259, Jan. 2013. [
[DOI](http://dx.doi.org/10.1016/j.celrep.2012.12.008) ]

A. Fischer, C. J. Illingworth, P. J. Campbell, and V. Mustonen. EMu:
probabilistic inference of mutational processes and their localization in the
cancer genome. Genome biology, 14(4):R39, Apr. 2013. [
[DOI](http://dx.doi.org/10.1186/gb-2013-14-4-r39) ]

## Debug Info

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
##  [1] future_1.67.0       signeR_2.12.0       NMF_0.28
##  [4] bigmemory_4.6.4     Biobase_2.70.0      BiocGenerics_0.56.0
##  [7] generics_0.1.4      cluster_2.1.8.1     rngtools_1.5.2
## [10] registry_0.5-1      knitr_1.50
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1               later_1.4.4
##   [3] BiocIO_1.20.0               bitops_1.0-9
##   [5] filelock_1.0.3              tibble_3.3.0
##   [7] pROC_1.19.0.1               XML_3.99-0.19
##   [9] rpart_4.1.24                lifecycle_1.0.4
##  [11] httr2_1.2.1                 rstatix_0.7.3
##  [13] doParallel_1.0.17           globals_0.18.0
##  [15] lattice_0.22-7              MASS_7.3-65
##  [17] kpeaks_1.1.0                backports_1.5.0
##  [19] magrittr_2.0.4              sass_0.4.10
##  [21] rmarkdown_2.30              jquerylib_0.1.4
##  [23] yaml_2.3.10                 httpuv_1.6.16
##  [25] otel_0.2.0                  cowplot_1.2.0
##  [27] DBI_1.2.3                   RColorBrewer_1.1-3
##  [29] lubridate_1.9.4             abind_1.4-8
##  [31] GenomicRanges_1.62.0        purrr_1.1.0
##  [33] RCurl_1.98-1.17             VariantAnnotation_1.56.0
##  [35] rappdirs_0.3.3              pvclust_2.2-0
##  [37] KMsurv_0.1-6                IRanges_2.44.0
##  [39] S4Vectors_0.48.0            listenv_0.9.1
##  [41] pheatmap_1.0.13             parallelly_1.45.1
##  [43] codetools_0.2-20            DelayedArray_0.36.0
##  [45] tidyselect_1.2.1            SuppDists_1.1-9.9
##  [47] shape_1.4.6.1               UCSC.utils_1.6.0
##  [49] farver_2.1.2                gmp_0.7-5
##  [51] shinyWidgets_0.9.0          matrixStats_1.5.0
##  [53] stats4_4.5.1                BiocFileCache_3.0.0
##  [55] Seqinfo_1.0.0               GenomicAlignments_1.46.0
##  [57] jsonlite_2.0.0              e1071_1.7-16
##  [59] Formula_1.2-5               survival_3.8-3
##  [61] iterators_1.0.14            foreach_1.5.2
##  [63] BWStest_0.2.3               tools_4.5.1
##  [65] PMCMRplus_1.9.12            Rcpp_1.1.0
##  [67] glue_1.8.0                  gridExtra_2.3
##  [69] SparseArray_1.10.0          mgcv_1.9-3
##  [71] xfun_0.53                   kSamples_1.2-12
##  [73] MatrixGenerics_1.22.0       GenomeInfoDb_1.46.0
##  [75] dplyr_1.1.4                 withr_3.0.2
##  [77] shinydashboard_0.7.3        BiocManager_1.30.26
##  [79] fastmap_1.2.0               digest_0.6.37
##  [81] timechange_0.3.0            R6_2.6.1
##  [83] mime_0.13                   colorspace_2.1-2
##  [85] dichromat_2.0-0.1           RSQLite_2.4.3
##  [87] cigarillo_1.0.0             tidyr_1.3.1
##  [89] data.table_1.17.8           rtracklayer_1.70.0
##  [91] class_7.3-23                bsplus_0.1.5
##  [93] httr_1.4.7                  S4Arrays_1.10.0
##  [95] pkgconfig_2.0.3             gtable_0.3.6
##  [97] Rmpfr_1.1-2                 blob_1.2.4
##  [99] S7_0.2.0                    XVector_0.50.0
## [101] survMisc_0.5.6              htmltools_0.5.8.1
## [103] carData_3.0-5               clue_0.3-66
## [105] multcompView_0.1-10         scales_1.4.0
## [107] png_0.1-8                   km.ci_0.5-6
## [109] bigmemory.sri_0.1.8         tzdb_0.5.0
## [111] reshape2_1.4.4              rjson_0.2.23
## [113] uuid_1.2-1                  nlme_3.1-168
## [115] curl_7.0.0                  nloptr_2.2.1
## [117] zoo_1.8-14                  proxy_0.4-27
## [119] cachem_1.1.0                stringr_1.5.2
## [121] parallel_4.5.1              shinycssloaders_1.1.0
## [123] AnnotationDbi_1.72.0        restfulr_0.0.16
## [125] pillar_1.11.1               grid_4.5.1
## [127] vctrs_0.6.5                 maxstat_0.7-26
## [129] ggpubr_0.6.2                VGAM_1.1-13
## [131] promises_1.4.0              randomForest_4.7-1.2
## [133] car_3.1-3                   dbplyr_2.5.1
## [135] lhs_1.2.0                   ada_2.0-5
## [137] xtable_1.8-4                evaluate_1.0.5
## [139] readr_2.1.5                 GenomicFeatures_1.62.0
## [141] mvtnorm_1.3-3               cli_3.6.5
## [143] compiler_4.5.1              Rsamtools_2.26.0
## [145] rlang_1.1.6                 crayon_1.5.3
## [147] ppclust_1.1.0.1             ggsignif_0.6.4
## [149] future.apply_1.20.0         labeling_0.4.3
## [151] survminer_0.5.1             plyr_1.8.9
## [153] stringi_1.8.7               gridBase_0.4-7
## [155] BiocParallel_1.44.0         Biostrings_2.78.0
## [157] glmnet_4.1-10               Matrix_1.7-4
## [159] inaparc_1.2.1               BSgenome_1.78.0
## [161] hms_1.1.4                   bit64_4.6.0-1
## [163] ggplot2_4.0.0               KEGGREST_1.50.0
## [165] shiny_1.11.1                SummarizedExperiment_1.40.0
## [167] highr_0.11                  kknn_1.4.1
## [169] exactRankTests_0.8-35       broom_1.0.10
## [171] igraph_2.2.1                memoise_2.0.1
## [173] bslib_0.9.0                 bit_4.6.0
```

```
print(names(dev.cur()))
```

```
## [1] "png"
```