# INSPEcT - INference of Synthesis, Processing and dEgradation rates from Transcriptomic data

de Pretis S., Furlan M. and Pelizzola M.

#### 2025-10-30

#### Package

INSPEcT 1.40.0

# Contents

* [1 Introduction](#intro)
* [2 Quantification of Exon and Intron features](#quantif)
  + [2.1 From BAM or SAM files](#from-bam-or-sam-files)
  + [2.2 From read counts](#from-read-counts)
  + [2.3 From transcripts abundances](#from-transcripts-abundances)
* [3 Analysis of RNA dynamics in time-course experiments](#timecourseanalysis)
  + [3.1 Analysis of Total and Nascent RNA (INSPEcT+)](#analysis-of-total-and-nascent-rna-inspect)
    - [3.1.1 First guess estimation of the rates](#first-guess-estimation-of-the-rates)
    - [3.1.2 Modeling with sigmoid and impulse functions](#modeling-with-sigmoid-and-impulse-functions)
    - [3.1.3 Confidence intervals estimation and selection of the regulatory scenario](#confidence-intervals-estimation-and-selection-of-the-regulatory-scenario)
    - [3.1.4 Quality of the model fit](#quality-of-the-model-fit)
    - [3.1.5 Selection of the regulative scenario without assumptions on the functional form](#selection-of-the-regulative-scenario-without-assumptions-on-the-functional-form)
  + [3.2 Analysis of Total RNA without Nascent (INSPEcT-)](#analysis-of-total-rna-without-nascent-inspect-)
    - [3.2.1 First guess estimation of the rates](#first-guess-estimation-of-the-rates-1)
    - [3.2.2 Modeling of the rates with constant, sigmoid and impulse functions](#modeling-of-the-rates-with-constant-sigmoid-and-impulse-functions)
    - [3.2.3 Confidence intervals estimation and model quality](#confidence-intervals-estimation-and-model-quality)
    - [3.2.4 Selection of the regulative scenario without assumptions on the functional form](#selection-of-the-regulative-scenario-without-assumptions-on-the-functional-form-1)
  + [3.3 Performance evaluation with simulated data](#performance-evaluation-with-simulated-data)
    - [3.3.1 Generate simulated data with sigmoid and impulsive rates](#generate-simulated-data-with-sigmoid-and-impulsive-rates)
    - [3.3.2 Generate simulated data with oscillatory rates](#generate-simulated-data-with-oscillatory-rates)
  + [3.4 Non default parameters for modeling and model selection](#non-default-parameters-for-modeling-and-model-selection)
* [4 Analysis of RNA dynamics in steady state RNA-seq data](#steadystateanalysis)
  + [4.1 Analysis of Total and Nascent RNA](#analysis-of-total-and-nascent-rna)
  + [4.2 Analysis of Total without Nascent RNA](#analysis-of-total-without-nascent-rna)
* [5 Wrap-up functions: running INSPEcT with a single command line](#wrappers)
  + [5.1 Pipeline from BAM files](#pipeline-from-bam-files)
  + [5.2 Pipeline from PCR quantifications](#pipeline-from-pcr-quantifications)
* [6 About this document](#about-this-document)
* [References](#references)

# 1 Introduction

*INSPEcT* is an R/Bioconductor compliant solution for the study of RNA transcriptional dynamics from RNA-seq data (De Pretis et al. [2015](#ref-de2015inspect), @Furlan520155). It is based on a system of two ordinary differential equations (ODEs) that describes the synthesis (\(k\_1\)) and processing (\(k\_2\)) of premature RNA (\(P\)) and the degradation (\(k\_3\)) of mature RNA (\(M=T-P\)):

\[\begin{equation}
\left\{
\begin{array}{l l}
\dot{P}=k\_1 - k\_2 \, \cdot \, P \\
\dot{T}=k\_1 - k\_3 \, \cdot \, (T - P)
\end{array}
\right.
\tag{1}
\end{equation}\]

The total RNA (\(T\)) is measured from the exonic quantification of transcripts in RNA-seq experiment, while premature RNA (\(P\)) is measured by the intronic quantification. The model is based on two commonly accepted assumptions: nuclear degradation is deniable, and nuclear export occurs at a rate considerably faster than other rates and can be disregarded.

The package supports the analysis of several experimental designs, such as steady-state conditions or time-course data, and the presence or absence of the nascent RNA library. According to the experimental design, the software returns different outputs. In particular, when the nascent RNA is present (INSPEcT+), the rates of synthesis, processing and degradation can be calculated both in time-course and in steady-state state conditions and tested for differential regulation. Without the information from the nascent RNA (INSPEcT-), the rates of synthesis, processing and degradation, as well as their significant variation, can be calculated only in time-course, while only a variation in the ratio between processing and degradation (post-transcriptional ratio) can be assessed between steady states. A schema of the possible configurations and related outputs is reported in Table [1](#tab:s4Udesign) and [2](#tab:Nos4Udesign).

Table 1: INSPEcT+ experimental design

| Design | Synthesis | Processing | Degradation |
| --- | --- | --- | --- |
| Steady-state | Yes | Yes | Yes |
| Time-course | Yes | Yes | Yes |

Table 2: INSPEcT- experimental design

| Design | Synthesis | Processing | Degradation |
| --- | --- | --- | --- |
| Steady-state | No | Ratio | Ratio |
| Time-course | Yes | Yes | Yes |

Within the next sections, the usage of INSPEcT will be explained in detail. In particular, section [2](#quantif) explains the different method to quantify intronic and exonic features from different input sources (alignments, read counts or direct quantifications) and create the input for the following *INSPEcT* analysis. Section [3](#timecourseanalysis) explains how to perform time-course analyses and visualize results. Section [4](#steadystateanalysis) explains how to perform steady-state analyses and visualize results. Finally, section [5](#wrappers) introduces two wrapper functions, which allow the user running the entire *INSPEcT* pipeline with a single command line.

Please also refer to the *[INSPEcT](https://bioconductor.org/packages/3.22/INSPEcT/vignettes/INSPEcT-GUI)*-GUI vignette. This graphic-user-interface exploits the key *INSPEcT* functionalities and facilitates the understanding of the impact of RNA kinetic rates on the dynamics of premature and mature RNA.

# 2 Quantification of Exon and Intron features

The *INSPEcT* analysis starts with the quantification of exonic and intronic quantifications and the estimation of their variance from the replicates in the different conditions of the analysis. *INSPEcT* can estimate transcripts abundances and associated variances starting from different entry points according to the source of data available: SAM (or BAM) files, read counts or transcripts abundances. The user can choose to estimate the variance by means of two different softwares: *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* or *[plgem](https://bioconductor.org/packages/3.22/plgem)*. By default, *DESeq2* is used when starting from BAM or read counts, while *plgem* is used when starting from transcripts abundances.

```
library(INSPEcT)
```

## 2.1 From BAM or SAM files

*INSPEcT* can quantify transcripts abundnaces and variances directly from SAM or BAM files. In this case, transcripts annotations are retrieved from a *TxDb* object. By default, *INSPEcT* collapses the exons of the transcripts that belong to the same gene (argument *by=“gene”*). Alternatively, it can work also at the transcript level (argument *by=’tx*). When working at the transcript level, *INSPEcT* cannot discriminate between transcript, therefore we suggest assigning reads to all the overlapping features by setting the argument *allowMultiOverlap* to *TRUE*. *INSPEcT* manage strandness of the reads with the argument *strandSpecific*, which can be set to *0* in case of unstranded reads, *1* for stranded and *2* for reverse-stranded experiments. *INSPEcT* prioritizes the exon annotation, meaning that only the reads that do not overlap with any of the annotated exon are eventually accounted for introns. Here we report an example where the data from 4 sample BAM files (2 time points, 2 replicates each, as specified with the argument *experimentalDesign*) is quantified in a non-stranded specific way, at the gene level, not assigning the reads mapping to more than one feature.

```
require(TxDb.Mmusculus.UCSC.mm9.knownGene)
txdb <- TxDb.Mmusculus.UCSC.mm9.knownGene

bamfiles_paths <- system.file('extdata/',
  c('bamRep1.bam','bamRep2.bam','bamRep3.bam','bamRep4.bam'),
  package='INSPEcT')

exprFromBAM <- quantifyExpressionsFromBAMs(txdb=txdb
           , BAMfiles=bamfiles_paths
           , by = 'gene'
           , allowMultiOverlap = FALSE
           , strandSpecific = 0
           , experimentalDesign=c(0,0,1,1))
```

The function returns a list containing exonic/intronic expressions and variances, as well as exonic/intronic feature widths extracted from the annotation, exonic/intronic counts and counts statistics.

```
names(exprFromBAM)
```

```
## [1] "exonsExpressions"   "intronsExpressions" "exonsVariance"
## [4] "intronsVariance"    "exonsWidths"        "intronsWidths"
## [7] "exonsCounts"        "intronsCounts"      "countsStats"
```

```
exprFromBAM$countsStats
```

```
##                       0_rep1 0_rep2 1_rep1 1_rep2
## Unassigned_Ambiguity       5      0      0      0
## Assigned_Exons          2515   2763   2729   2672
## Assigned_Introns         862    609    654    706
## Unassigned_NoFeatures      0      0      0      0
```

## 2.2 From read counts

In case the matrices of intronic and exonic reads have been already calculated, *INSPEcT* estimates the mean expressions and the associated variances using, by default, the software *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*. The package *INSPEcT* contains the read counts associated to the intronic and exonic features of 500 genes profiled both for the nascent and total RNA in 11 time-points and replicated 3 times each following the induction of Myc in 3T9 cells (De Pretis et al. [2017](#ref-de2017integrative)). As a complementary information, the width of the intronic and exonic features for the same set of genes, as well as the sequencing depth of all the samples is provided within the package. The nascent and total quantification evaluated in this section of the vignette will be used later to generate the synthetic dataset for the benchmarking of the method.

```
data('allcounts', package='INSPEcT')
data('featureWidths', package='INSPEcT')
data('libsizes', package='INSPEcT')

nascentCounts<-allcounts$nascent
matureCounts<-allcounts$mature
expDes<-rep(c(0,1/6,1/3,1/2,1,1.5,2,4,8,12,16),3)

nasExp_DESeq2<-quantifyExpressionsFromTrCounts(
        allcounts=nascentCounts
        ,libsize=nascentLS
        ,exonsWidths=exWdths
        ,intronsWidths=intWdths
        ,experimentalDesign=expDes)

matExp_DESeq2<-quantifyExpressionsFromTrCounts(
        allcounts=matureCounts
        ,libsize=totalLS
        ,exonsWidths=exWdths
        ,intronsWidths=intWdths
        ,experimentalDesign=expDes)
```

## 2.3 From transcripts abundances

In order to exemplify the quantification of mean transcripts abundances and variances starting from their replicated quantification, we transform the read counts loaded from the package in the section above into RPKMs using the width of introns and exons and the library sizes.

```
trAbundancesFromCounts <- function(counts, widths, libsize)
        t(t(counts/widths)/libsize*10^9)
nascentTrAbundance <- list(
  exonsAbundances=trAbundancesFromCounts(
        nascentCounts$exonsCounts, exWdths, nascentLS),
  intronsAbundances=trAbundancesFromCounts(
        nascentCounts$intronsCounts, intWdths, nascentLS))
```

Once we have obtained transcripts abundances for introns and exons in the different conditions and replicates of the experimental design, we can calculate the mean expression and variance (using *[plgem](https://bioconductor.org/packages/3.22/plgem)*) by:

```
nasExp_plgem<-quantifyExpressionsFromTrAbundance(
        trAbundaces = nascentTrAbundance
        , experimentalDesign = expDes)
```

# 3 Analysis of RNA dynamics in time-course experiments

## 3.1 Analysis of Total and Nascent RNA (INSPEcT+)

In case of the joint analysis of total and nascent RNA data, for each transcript with at least one intron, the exonic and intronic quantifications are available in the Total and in the Nascent RNA libraries. The system of equations [(1)](#eq:modelsystem) describes the dynamics of the total RNA population, but when integrated between zero and the time of labeling (\(t\_L\)) it can be used to describe nascent RNA. For matter of simplicity *INSPEcT* assumes that, during the labeling time, synthesis and processing rates are constant and nascent transcripts are not degraded. The set of equations to describe Total and Nascent RNA is:

\[\begin{equation}
\left\{
\begin{array}{l l}
\dot{P}\_{R}=k\_1 - k\_2 \, \cdot \, P\_{R} \\
\dot{T}\_{R}=k\_1 - k\_3 \, \cdot \, (T\_{R} - P\_{R}) \\
s\_F \, \cdot \, P\_{L}=\frac{k\_1}{k\_2} - ( 1 - e^{k\_2 \, \cdot \, t\_L} ) \\
s\_F \, \cdot \, T\_{L}=k\_1 \, \cdot \, t\_L
\end{array}
\right.
\tag{2}
\end{equation}\]

where \(P\_{R}\) and \(T\_{R}\) are the premature and total RNA levels, respectively, estimated from the total RNA library, \(P\_{L}\) and \(T\_{L}\) are premature and total RNA levels, respectively, estimated from the nascent RNA library at each condition or time-point. First of all, \(\dot{P}\_{R}\) and \(\dot{T}\_{R}\) are estimated from the interpolation of \(P\_R(t)\) and \(T\_R(t)\) via cubic splines. *INSPEcT* exploits the overdetermination of the system (three unknowns: \(k\_1\), \(k\_2\) and \(k\_3\); and four equations) to calculate a scaling factor (\(s\_F\)) between the Total and Nascent RNA for each condition or time-point (De Pretis et al. [2015](#ref-de2015inspect)).

### 3.1.1 First guess estimation of the rates

The rates of synthesis, processing and degradation are calculated from the Total and Nascent RNA quantifications by the *newINSPEcT* function:

```
  tpts<-c(0,1/6,1/3,1/2,1,1.5,2,4,8,12,16)
  tL<-1/6
  nascentInspObj<-newINSPEcT(tpts=tpts
                            ,labeling_time=tL
                            ,nascentExpressions=nasExp_DESeq2
                            ,matureExpressions=matExp_DESeq2)
```

During this step, *INSPEcT* calculates a scaling factor between each time-point of Total and Nascent expressions (as described in the section above) and integrates the differential equations [(2)](#eq:2) assuming that, between experimental observations, total RNA, premature RNA and synthesis rate, behave linearly (linear piecewise), and that processing and degradation rates are constant (constant piecewise). Rates estimated by this procedure can be accessed from the *INSPEcT* object by the method *ratesFirstGuess*, which allows to access also RNA concentrations and variances associated to the experimental observations:

```
  round(ratesFirstGuess(nascentInspObj,'total')[1:5,1:3],3)
```

```
##           total_0 total_0.166666667 total_0.333333333
## 100503670 605.805           609.366           601.865
## 101206      5.107             5.356             5.196
## 101489     15.629            15.767            15.606
## 102436      1.543             1.107             1.305
## 104458     86.966            93.632            88.837
```

```
  round(ratesFirstGuessVar(nascentInspObj,'total')[1:5,1:3],3)
```

```
##           total_0 total_0.166666667 total_0.333333333
## 100503670 775.569           784.570           764.586
## 101206      0.382             0.417             0.392
## 101489      1.192             1.208             1.179
## 102436      0.281             0.145             0.202
## 104458     24.917            28.736            25.866
```

```
  round(ratesFirstGuess(nascentInspObj,'synthesis')[1:5,1:3],3)
```

```
##           synthesis_0 synthesis_0.166666667 synthesis_0.333333333
## 100503670     231.119               211.859               210.099
## 101206          4.875                 4.412                 3.964
## 101489          7.749                 7.412                 7.421
## 102436         32.087                28.312                28.645
## 104458         47.333                46.424                50.867
```

The *INSPEcT* object can be subset to focus on a specific set of genes, and for the sake of speeding up the downstream analysis, we will focus on the first 10 genes of the *INSPEcT* object.

```
nascentInspObj10<-nascentInspObj[1:10]
```

The complete pattern of total and pre-mRNA concentrations variation together with the synthesis, degradation and processing rates can be visualized using the *inHeatmap* method (Figure [1](#fig:inHeatmapNascentTimeCourse)):

```
inHeatmap(nascentInspObj10, clustering=FALSE)
```

![inHeatmap of the ratesFirstGuess. Heatmap representing the concentrations of total RNA, of premature RNA and the first guess of the rates of the RNA life cycle](data:image/png;base64...)

Figure 1: inHeatmap of the ratesFirstGuess
Heatmap representing the concentrations of total RNA, of premature RNA and the first guess of the rates of the RNA life cycle

In case of a long \(t\_L\) (more than 30 minutes), it can be useful to set the argument *degDuringPulse* equal to *TRUE* to estimate the rates of the RNA life-cycle without assuming that nascent transcripts are not degraded during the labeling time. The longer the labelling time is the weaker this assumption gets, however, taking into account nascent RNA degradation involves the solution of a more complicated system of equations and can originate unrealistic high rates of synthesis, processing and degradation.

```
  nascentInspObjDDP<-newINSPEcT(tpts=tpts
                            ,labeling_time=tL
                            ,nascentExpressions=nasExp_DESeq2
                            ,matureExpressions=matExp_DESeq2
                            ,degDuringPulse=TRUE)
```

For short labeling times, as 10 minutes can be considered, the absence of degradation during the pulse is a good assumption and similar rates are estimated in both cases. In Figure [2](#fig:firstGuessCompareDDP) we compared the degradation rates estimated with or without the assumption that degradation of mature RNA occurs during the labeling time.

```
k3 <- ratesFirstGuess(nascentInspObj, 'degradation')
k3ddp <- ratesFirstGuess(nascentInspObjDDP, 'degradation')
plot(rowMeans(k3), rowMeans(k3ddp), log='xy',
     xlim=c(.2,10), ylim=c(.2,10),
     xlab='no degradation during pulse',
     ylab='degradation during pulse',
     main='first guess degradation rates')
abline(0,1,col='red')
```

![Dotplot of degradation rates calculated with or without the assumption of no degradation during pulse. First guess of the degradation rates was calculated with or without degDuringPulse option. In red is represented the line of equation y = x.](data:image/png;base64...)

Figure 2: Dotplot of degradation rates calculated with or without the assumption of no degradation during pulse
First guess of the degradation rates was calculated with or without degDuringPulse option. In red is represented the line of equation y = x.

### 3.1.2 Modeling with sigmoid and impulse functions

The rates evaluated during the “first guess” are highly exposed to the experimental noise. In particular, processing and degradation rates sum up the noise coming from different experimental data (i.e. the Total and the Nascent libraries), and could be challenging to distinguish real variations from noise. For this reason, the method *modelRates* fits either sigmoid or impulse functions to total RNA, processing and degradation rates, that minimize the error on experimental data. In this approach, premature RNA and synthesis rate functional forms directly result from the system of equations [(1)](#eq:modelsystem).

```
nascentInspObj10<-modelRates(nascentInspObj10, seed=1)
```

The rates computed through this modeling procedure are accessible via the method *viewModelRates* and can visualized via the method *inHeatmap*, setting the argument *type*=‘model’} (Figure [3](#fig:viewModelRatesAndInHeatmapNascentTimeCourse)).

```
round(viewModelRates(nascentInspObj10, 'synthesis')[1:5,1:3],3)
```

```
##           synthesis_0 synthesis_0.17 synthesis_0.33
## 100503670     208.688        208.688        208.688
## 101206          4.640          4.466          4.242
## 101489          7.524          7.454          7.348
## 102436         25.632         25.663         25.712
## 104458         47.738         47.738         47.738
```

```
inHeatmap(nascentInspObj10, type='model', clustering=FALSE)
```

![inHeatmap of the rates after the second step of modeling. Heatmap representing the concentrations of total RNA, of premature RNA and the rates of the RNA life cycle after the second step of modeling.](data:image/png;base64...)

Figure 3: inHeatmap of the rates after the second step of modeling
Heatmap representing the concentrations of total RNA, of premature RNA and the rates of the RNA life cycle after the second step of modeling.

### 3.1.3 Confidence intervals estimation and selection of the regulatory scenario

For each rate and time point, 95% confidence intervals are calculated and used to test the variability of a rate. Specifically, a chi-squared goodness-of-fit test is performed to assess how a constant rate fit within confidence intervals. Confidence intervals can be accessed by the method *viewConfidenceIntervals*, the p-values of the rates variability tests can be accessed by the method *ratePvals* and the regulatory class assigned to each gene by the method *geneClass*. In particular, each gene is assigned to a class named after the set of varying rates: “no-reg” denotes a gene whose rates are constant over time, “s” denotes a gene whose synthesis changes over time, “p” denotes a gene whose processing changes over time, “d” denotes a gene whose degradation changes over time. Genes regualted by a more than one rate have a class composed by more letters, for example, the class “sp” represnents genes regulated at the level of both synthesis and processing rates.

```
head(ratePvals(nascentInspObj10),3)
```

```
##              synthesis processing degradation
## 100503670 8.663546e-01          1   0.9999919
## 101206    7.002705e-08          1   0.9999919
## 101489    1.612946e-03          1   0.0142093
```

```
head(geneClass(nascentInspObj10),3)
```

```
## 100503670    101206    101489
##  "no-reg"       "s"      "sd"
```

The method *plotGene* can be used to fully investigate the profiles of RNA concentrations and rates of a single gene. Estimated synthesis, degradation and processing rates, premature RNA and total RNA concentrations are displayed with solid thin lines, while their standard deviations or confidence intervals are in dashed lines and the modelled rates and concentrations are in thick solid lines. This example shows a gene of class “a”, indicating that its expression levels are controlled just by synthesis rate (Figure [4](#fig:plotGeneNascentTimeCourse)).

```
plotGene(nascentInspObj10, ix="101206")
```

![Plot of a single gene resolved using nascent and total RNA. Plot of concentrations and rates over time for the given gene 101206. Total and nascent RNA were used to resolve the whole set of rates and concentrations.](data:image/png;base64...)

Figure 4: Plot of a single gene resolved using nascent and total RNA
Plot of concentrations and rates over time for the given gene 101206. Total and nascent RNA were used to resolve the whole set of rates and concentrations.

### 3.1.4 Quality of the model fit

The global quality of each model is evaluated through chi-squared goodness-of-fit test, where the number of degrees of freedom equals the difference between the experimental observations and the number of parameters used for the modelling. The results of this test can be accessed via the method *chisqmodel*. Here we visualized them as a histogram (Figure [5](#fig:chi2NascentTimeCourse)) and eventually used to discard badly fitted genes.

```
chisq<-chisqmodel(nascentInspObj10)
hist(log10(chisq), main='', xlab='log10 chi-squared p-value')
```

![Histogram of the p-values from the goodness of fit test for modeled genes.](data:image/png;base64...)

Figure 5: Histogram of the p-values from the goodness of fit test for modeled genes

```
discard<-which(chisq>1e-2)
featureNames(nascentInspObj10)[discard]
```

```
## [1] "104458" "105148" "105348" "107435"
```

```
nascentInspObj_reduced<-nascentInspObj10[-discard]
```

### 3.1.5 Selection of the regulative scenario without assumptions on the functional form

In case the sigmoid or impulse functional forms are not suited to describe the experimental data, such as for oscillatory genes, the method *modelRatesNF* can be used to assess the regulatory scenario. This method estimates confidence intervals on the synthesis, processing and degradation rates calculated in the first step of the analysis, i.e. without assuming any specific functional form.

```
nascentInspObj10NF<-nascentInspObj[1:10]
nascentInspObj10NF<-modelRatesNF(nascentInspObj10NF)
```

Rates estimates with their confidence intervals are then used to assess the regulatory scenarios, like described in for the models where the functional form is fixed.

```
head(ratePvals(nascentInspObj10NF),3)
```

```
##              synthesis processing degradation
## 100503670 3.442920e-03  0.9989537   0.3060441
## 101206    2.746373e-07  0.9989537   0.9999485
## 101489    6.860230e-05  0.9989537   0.8886645
```

```
head(geneClass(nascentInspObj10NF),3)
```

```
## 100503670    101206    101489
##       "s"       "s"       "s"
```

Also the method *plotGene* can be used:

```
plotGene(nascentInspObj10NF, ix="101206")
```

![Plot of a single gene resolved using nascent and total RNA. Plot of concentrations and rates over time for the given gene 101206. No assumptions on the functional form of the rate was done in this case to calculate confidence intervals.](data:image/png;base64...)

Figure 6: Plot of a single gene resolved using nascent and total RNA
Plot of concentrations and rates over time for the given gene 101206. No assumptions on the functional form of the rate was done in this case to calculate confidence intervals.

Without assumptions on the functional form, the quality of each model in describing the data cannot be calculated because the model used has no residual degrees of freedom over the experimental data and no test statistic can apply.

## 3.2 Analysis of Total RNA without Nascent (INSPEcT-)

The absence of the nascent RNA component makes the identification of a unique solution of the system more difficult. Nonetheless, the joint analysis of premature and mature RNA time-course RNA-seq analysis is an important source of information in regards of RNA dynamics. The main idea behind this relies in the fact that genes that are modulated transcriptionally (i.e. by the synthesis rate) respond in their RNA levels following a precise pattern, that is premature RNA and mature RNA are modulated to the same extent (same fold change compared to unperturbed condition) but with different timing. In fact, the mature RNA follows the modulation of the premature RNA by a delay that is indicative to the mature RNA stability (i.e. degradation rate). Deviations from this behavior are signs of post-transcriptional regulation. We developed a computational approach that exploits these concepts and is able to quantify RNA dynamics based on time-course profiling of total RNA-seq data with good approximation. Without nascent RNA, the sole information of total (\(T\), exonic quantification) and premature (\(P\), intronic quantification) from the Total library is available and used to model the RNA dynamics. In particular, we model premature RNA (\(P\)) and mature RNA (\(M=T-P\)), using the equation:

\[\begin{equation}
\begin{array}{l l}
\dot{M}=k\_2 \, P(t) - k\_3 \, M(t)
\end{array}
\tag{3}
\end{equation}\]

We start solving the equations assuming constant processing and degradation rates over the time-course and interpolating \(P\) with a linear piecewise in order to find the \(k2\) and \(k3\) that minimize the error over \(M(t)\), while \(k1(t)\) is obtained as follows:

\[\begin{equation}
\begin{array}{l l}
k\_1(t) = \dot{P(t)} + k\_2 \, P(t) \\
\end{array}
\tag{4}
\end{equation}\]

After that, \(k\_1(t)\) is used in combination with \(P(t)\) and \(T(t)\) to obtain \(k\_2(t)\) and \(k\_3(t)\) using the same procedure implemented for the first guess estimation of the rates in the analysis of nascent and total RNA.

### 3.2.1 First guess estimation of the rates

The procedure described above is implemented in the method *newINSPEcT*, which creates the *INSPEcT* object for the analysis and gives a first estimation of the synthesis, processing and degradation rates along the time-course, for those genes with enough signal for both introns and exons. In comparison to the mature and nascent configuration, from the practical point of view, nothing changes except for the absence of \(t\_L\) and new synthesized expression data.

```
matureInspObj<-newINSPEcT(tpts=tpts
                        ,labeling_time=NULL
                        ,nascentExpressions=NULL
                        ,matureExpressions=matExp_DESeq2)
```

All the methods that apply to the *INSPEcT* object created with the nascent RNA apply also to the object created with the sole total RNA. For example, we can compare the time-averaged rates of synthesis estimated in this first step of modeling with or without the nascent RNA, by extracting them with the *ratesFirstGuess* (Figure [7](#fig:firstGuessCompare)).

```
cg <- intersect(featureNames(nascentInspObj),
                featureNames(matureInspObj))
k1Nascent <- ratesFirstGuess(nascentInspObj[cg,], 'synthesis')
k1Mature <- ratesFirstGuess(matureInspObj[cg,], 'synthesis')
smoothScatter(log10(rowMeans(k1Nascent)),
              log10(rowMeans(k1Mature)),
              main='synthesis rates',
              xlab='nascent + mature RNA',
              ylab='mature RNA')
abline(0,1,col='red')
```

![Dotplot of synthesis rates calculated with or without nascent RNA. First guess of the synthesis rates calculated on the same set of genes with or without the nascent RNA information. In red is represented the line of equation y = x.](data:image/png;base64...)

Figure 7: Dotplot of synthesis rates calculated with or without nascent RNA
First guess of the synthesis rates calculated on the same set of genes with or without the nascent RNA information. In red is represented the line of equation y = x.

### 3.2.2 Modeling of the rates with constant, sigmoid and impulse functions

Similarly to the procedure with the nascent RNA, *INSPEcT* provides an additional step of modeling, where the software assigns to the rates of the RNA cycle a sigmoid or impulse form to describe their behavior over time (see the corresponding section in “Analysis of Total and Nascent RNA”). During this procedure 8 independent models for each gene are tested (all the combinations of constant/non-constant functions for each of the three rates), and the best model is chosen based on the trade-off between the goodness of fit and the simplicity. This modeling procedure refines the estimation of the rates and gives a statistical confidence about the variation of each rate during the time-course.

```
matureInspObj10 <- matureInspObj[1:10, ]
matureInspObj10 <- modelRates(matureInspObj10, seed=1)
```

In figure [8](#fig:plotGeneMatureTimeCourse), the same gene represented in figure [4](#fig:plotGeneNascentTimeCourse) is plotted. Also in this case, estimated synthesis, degradation and processing rates, premature RNA and total RNA concentrations are displayed with solid thin lines, while their standard deviations are in dashed lines and the modelled rates and concentrations are in thick solid lines.

```
plotGene(matureInspObj10, ix="101206")
```

```
## Confidence intervals.
```

![Plot of a single gene resolved using only total RNA. Plot of concentrations and rates over time for the given gene 101206. Only total RNA was used to resolve the whole set of rates and concentrations.](data:image/png;base64...)

Figure 8: Plot of a single gene resolved using only total RNA
Plot of concentrations and rates over time for the given gene 101206. Only total RNA was used to resolve the whole set of rates and concentrations.

### 3.2.3 Confidence intervals estimation and model quality

Analogously to INSPEcT+, also without the Nascent RNA information confidence intervals for each rate and time point are estimated (*viewConfidenceIntervals* method) and the quality of the models are calculated (*chisqmodel* method).

### 3.2.4 Selection of the regulative scenario without assumptions on the functional form

Also in the case of Total RNA analysis, when sigmoid or impulse functional forms are not suited to describe the experimental data the method *modelRatesNF* should be used to assess the regulatory scenario by the estimation of the confidence intervals on the synthesis, processing and degradation rates calculated in the first step of the analysis, i.e. without assuming any specific functional form.

```
matureInspObj10NF<-modelRatesNF(matureInspObj[1:10])
```

Rates estimates with their confidence intervals are then used to assess the regulatory scenarios, like described in for the models where the functional form is fixed.

## 3.3 Performance evaluation with simulated data

*INSPEcT* offers functionalities to build a synthetic dataset that can be used to evaluate the performance of the tool in classifying rates as constant or variable over time, to configure the model selection parameters, and to predict the number of time points and replicates necessary to achieve a given classification performance.

### 3.3.1 Generate simulated data with sigmoid and impulsive rates

The method *makeSimModel* samples from an *INSPEcT* object the absolute values of the rates, their fold changes compared to time zero, the correlations between rates and fold-changes and the variance associated to experimental observations. These distributions estimated from real data are then used to simulate a given number of genes (set with *nGenes* parameter) with specified probability to have each rate as a constant, sigmoid or impulse function; by default these values are 50% constant, 20% sigmoid and 30% impulse.

```
simRates<-makeSimModel(nascentInspObj, 1000, seed=1)
# table(geneClass(simRates))
```

*makeSimModel* produces an object of class *INSPEcT\_model*, to be analyzed it must be transformed in an *INSPEcT* object using the *makeSimDataset* method. It takes as arguments the number of replicates required and the time points at which the data should be virtually collected. Regarding the latter point, the new time-course must be designed as a sampling of the original experimental time window (same initial and final conditions). The object created by this method can be modelled via *modelRates* as any other object of class *INSPEcT*, and in this case the results could be compared with the ground truth and the performance of the procedure with given number of replicates and time points can be estimated. In order to avoid long computation time, the next two chunks of code have been previously evaluated and will be not computed within this vignette.

```
newTpts <- c(0.00, 0.13, 0.35, 0.69, 1.26, 2.16, 3.63,
             5.99, 9.82, 16.00)
nascentSim2replicates<-makeSimDataset(object=simRates
                                   ,tpts=newTpts
                                   ,nRep=2
                                   ,NoNascent=FALSE
                                   ,seed=1)
nascentSim2replicates<-modelRates(nascentSim2replicates[1:100]
                               ,seed=1)

newTpts <- c(0.00, 0.10, 0.26, 0.49, 0.82, 1.32, 2.06,
             3.16, 4.78, 7.18, 10.73, 16.00)
nascentSim3replicates<-makeSimDataset(object=simRates
                                   ,tpts=newTpts
                                   ,nRep=3
                                   ,NoNascent=FALSE
                                   ,seed=1)
nascentSim3replicates<-modelRates(nascentSim3replicates[1:100]
                               ,seed=1)
```

Starting from the very same *simRates*, it is also possible to generate *INSPEcT* objects without information about the nascent RNA (argument *NoNascent* set to TRUE). However, it is not allowed to produce artificial gene sets starting from *INSPEcT* object without nascent RNA because the experimental estimation of the synthesis rate is mandatory to guarantee the good quality of the simulated data.

```
newTpts <- c(0.00, 0.13, 0.35, 0.69, 1.26, 2.16, 3.63,
             5.99, 9.82, 16.00)
matureSim2replicates<-makeSimDataset(object=simRates
                                 ,tpts=newTpts
                                 ,nRep=2
                                 ,NoNascent=TRUE
                                 ,seed=1)
modelSelection(matureSim2replicates)$thresholds$chisquare <- 1
matureSim2replicates<-modelRates(matureSim2replicates[1:100]
                             ,seed=1)

newTpts <- c(0.00, 0.10, 0.26, 0.49, 0.82, 1.32, 2.06,
             3.16, 4.78, 7.18, 10.73, 16.00)
matureSim3replicates<-makeSimDataset(object=simRates
                                 ,tpts=newTpts
                                 ,nRep=3
                                 ,NoNascent=TRUE
                                 ,seed=1)
modelSelection(matureSim3replicates)$thresholds$chisquare <- 1
matureSim3replicates<-modelRates(matureSim3replicates[1:100]
                             ,seed=1)
```

Once the simulated data have been produced and analysed, it is possible to compare the results obtained by the method *modelRates* and the object *simRates*, which contains the ground truth of rates.

The method *rocCurve*, for example, measures the performace of the constant/variable classification individually for the rates of synthesis, processing and degradation, using the receiver operating characteristic (ROC) curve (Figure [9](#fig:ROCs)).

```
data("nascentSim2replicates","nascentSim3replicates",
  "matureSim2replicates","matureSim3replicates",package='INSPEcT')

par(mfrow=c(2,2))
rocCurve(simRates,nascentSim2replicates)
title("2rep. 10t.p. Total and nascent RNA", line=3)

rocCurve(simRates,nascentSim3replicates)
title("3rep. 12t.p. Total and nascent RNA", line=3)

rocCurve(simRates,matureSim2replicates)
title("2rep. 10t.p. Total RNA", line=3)

rocCurve(simRates,matureSim3replicates)
title("3rep. 12t.p. Total RNA", line=3)
```

![ROC analysis of *INSPEcT* classification. For each rate, *INSPEcT* classification performance is measured in terms of sensitivity, TP / (TP + FN), and specificity, TN / (TN + FP), using a ROC curve analysis; false negatives (FN) represent cases where the rate is identified as constant while it was simulated as varying; false positives (FP) represent cases where *INSPEcT* identified a rate as varying while it was simulated as constant; on the contrary, true positives (TP) and negatives (TN) are cases of correct classification of varying and constant rates, respectively; sensitivity and specificity are computed using increasing thresholds for the Brown method used to combine multiple p-values derived from the log-likelihood ratio tests](data:image/png;base64...)

Figure 9: ROC analysis of *INSPEcT* classification
For each rate, *INSPEcT* classification performance is measured in terms of sensitivity, TP / (TP + FN), and specificity, TN / (TN + FP), using a ROC curve analysis; false negatives (FN) represent cases where the rate is identified as constant while it was simulated as varying; false positives (FP) represent cases where *INSPEcT* identified a rate as varying while it was simulated as constant; on the contrary, true positives (TP) and negatives (TN) are cases of correct classification of varying and constant rates, respectively; sensitivity and specificity are computed using increasing thresholds for the Brown method used to combine multiple p-values derived from the log-likelihood ratio tests

Further, the method *rocThresholds* can be used to assess the sensitivity and specificity that is achieved with different thresholds of the chi-squared and Brown tests (Figure [10](#fig:ROCsThresholds)) and returns the thresholds that maximize both sensitivity and specificity.

```
rocThresholds(simRates[1:100],nascentSim2replicates)
```

![Effect of chi-squared and Brown tests thresholds in *INSPEcT* classification. Plot of the sensitivity (black curve) and specificity (red curve) that is achieved after performing the log-likelihood ratio and Brown method for combining p-values with selected thresholds; thresholds that can be set for chi-squared test to accept models that will undergo the log-likelihood ratio test and for Brown p-value to assess variability of rates](data:image/png;base64...)

Figure 10: Effect of chi-squared and Brown tests thresholds in *INSPEcT* classification
Plot of the sensitivity (black curve) and specificity (red curve) that is achieved after performing the log-likelihood ratio and Brown method for combining p-values with selected thresholds; thresholds that can be set for chi-squared test to accept models that will undergo the log-likelihood ratio test and for Brown p-value to assess variability of rates

```
##   synthesis  processing degradation
## 0.005865058 0.894320721 0.571718439
```

### 3.3.2 Generate simulated data with oscillatory rates

*INSPEcT* also offers the possibility to generate a dataset with oscillatory rates. In this case, the method *makeOscillatorySimModel* can generate two types of simulated datasets: one where 50% of the genes have oscillatory synthesis rates (while processing and degradation are always constant), and one where 50% of the genes have both synthesis and degradation oscillatory rates (and processing always constant). In the latter case, the oscillation phase of synthesis and degradation can be coordinated. To resemble circadian rhythms, the oscillation frequencies is about 24 hours, while oscillation intensities are randomly sampled.

```
oscillatorySimRates<-makeOscillatorySimModel(nascentInspObj, 1000
      , oscillatoryk3=FALSE, seed=1)
oscillatorySimRatesK3<-makeOscillatorySimModel(nascentInspObj, 1000
      , oscillatoryk3=TRUE, k3delay=4, seed=1)
```

As in the previous case, after generating the rates pattern, a simulated dataset has to be created with the method *makeSimDataset*, where the number of replicates and the time-points of the experimental observations are set.

```
newTpts <- seq(0,48,length.out=13)
oscillatoryWithNascent<-makeSimDataset(object=oscillatorySimRates
                                   ,tpts=newTpts
                                   ,nRep=3
                                   ,NoNascent=FALSE
                                   ,seed=1)
oscillatoryWithNascentK3<-makeSimDataset(object=oscillatorySimRatesK3
                                   ,tpts=newTpts
                                   ,nRep=3
                                   ,NoNascent=FALSE
                                   ,seed=1)
```

## 3.4 Non default parameters for modeling and model selection

If desired, different parameters can be set for both the modelling and the testing part. Regarding the modeling part, we might want to increase the number of different initializations that are performed for each gene (*nInit* option) or increase the maximum number of steps in the rates optimization process (*nIter* option). All these choices could improve the performance of the method, but also the needed computational time; the impact of these options on the quality of the modelling can be evaluated using simulated datasets.

```
nascentInspObj10<-modelRates(nascentInspObj10, nInit=20, nIter=1000)
```

Alternatively, it is possible to change the thresholds for goodness-of-fit (chi-squared) and variability tests. The goodness-of-fit is used to discard bad models that will not enter in the model selection. By default, the threshold of acceptance is set to 0.1 and in this example we decide to be less stringent and set the threshold to 0.2. In case of low number of time points, few or no models can result in a low chi-square. In these cases, it could be necessary to use larger values for the chi-squared test threshold, or be completely comprehensive and set the threshold to 1. The threshold relative to the variability test is used to call differential regulation and can be set independently for each rate. Low thresholds reflect in a stricter call for differential regulation of the rate. In this example, we are changing the thresholds of both the goodness-of-fit and variability tests, eventually regenerating p-values and modeled rates.

```
matureInspObj10 <- calculateRatePvals(matureInspObj10, p_goodness_of_fit = .2, p_variability = c(.01,.01,.05))
```

In general, to increase reproducibility of the results, the parameters used for the modeling and for the model selection can be accessed also later by using the method *modelingParams* and *modelSelection*:

```
## modeling
str(modelingParams(matureInspObj10))
```

```
## List of 7
##  $ estimateRatesWith: chr "der"
##  $ useSigmoidFun    : logi TRUE
##  $ nInit            : num 10
##  $ nIter            : num 300
##  $ Dmin             : num 1e-06
##  $ Dmax             : num 10
##  $ seed             : num 1
```

```
## model selection and testing framework
str(modelSelection(matureInspObj10))
```

```
## List of 6
##  $ modelSelection      : chr "aic"
##  $ preferPValue        : logi TRUE
##  $ padj                : logi TRUE
##  $ p_goodness_of_fit   : num 0.2
##  $ p_variability       : num [1:3] 0.01 0.01 0.05
##  $ limitModelComplexity: logi FALSE
```

# 4 Analysis of RNA dynamics in steady state RNA-seq data

## 4.1 Analysis of Total and Nascent RNA

*INSPEcT* is also designed to analyze RNA dynamics in steady state conditions and to compare the RNA dynamics of two steady state at time. In order to exemplify the procedure, we treat the data relative to the time-course analyzed above as 11 individual steady states. *INSPEcT* recognizes that the analysis is at steady state when a character vector of conditions is given as time-points.

```
conditions <- letters[1:11]
nasSteadyObj <- newINSPEcT(tpts=conditions
                        ,labeling_time=tL
                        ,nascentExpressions=nasExp_DESeq2
                        ,matureExpressions=matExp_DESeq2)
```

Once created the steady-state *INSPEcT* object, the first guess of the rates can be extracted with the method *ratesFirstGuess*, as usual. If we want to test for differential regulation in the RNA dynamics between two conditions, the method *compareSteady* can be used. The *INSPEcT* object created with 11 conditions can be subset in order to select the ones that we want to compare. In this case, we selected the first and the last conditions, tested for differential regulation and visualized the results relative to individual rates using the methods *synthesis*, *processing* and *degradation*. These methods return the rates computed by the modeling in the two conditions, the log transformed geometric mean of the rate, the log2 fold change between the two conditions and the statistics relative to the test. In case a rate was not assessed as differentially regulated the same value is reported for the two conditions. Also in this case, the p-values thresholds of the chi-squared and Brown test can be modified by the *modelSelection*.

```
diffrates <- compareSteady(nasSteadyObj[,c(1,11)])

head(round(synthesis(diffrates),2))
```

```
##                a      k log2mean log2fc pval padj
## 100503670 231.12 248.14     7.90   0.10 0.19 0.28
## 101206      4.87   3.99     2.14  -0.29 0.01 0.02
## 101489      7.75   6.48     2.83  -0.26 0.18 0.27
## 102436     32.09  24.05     4.80  -0.42 0.59 0.72
## 104458     47.33  49.28     5.59   0.06 0.13 0.20
## 104806      3.50   3.98     1.90   0.18 0.60 0.72
```

```
head(round(processing(diffrates),2))
```

```
##                a      k log2mean log2fc pval padj
## 100503670  20.87  19.87     4.35  -0.07 0.07 0.38
## 101206     15.39  13.33     3.84  -0.21 0.18 0.49
## 101489     10.43   8.52     3.24  -0.29 0.58 0.71
## 102436    265.80 147.00     7.63  -0.85 0.00 0.22
## 104458     29.70  29.40     4.88  -0.01 0.62 0.73
## 104806     16.70  15.30     4.00  -0.13 0.03 0.31
```

```
head(round(degradation(diffrates),2))
```

```
##               a     k log2mean log2fc pval padj
## 100503670  0.39  0.40    -1.33   0.06 0.28 0.63
## 101206     1.02  1.09     0.07   0.09 0.34 0.64
## 101489     0.52  0.46    -1.03  -0.18 0.24 0.61
## 102436    22.56 17.52     4.31  -0.36 0.70 0.79
## 104458     0.55  0.50    -0.93  -0.15 0.04 0.34
## 104806     0.99  1.12     0.08   0.17 0.66 0.79
```

Following this, the method *plotMA* can be used to plot the results of the comparison for each individual rate. In figure (Figure [11](#fig:steadyStateNascent3)), we show the results for the synthesis rate. All the points that do not lie on the line y = 0 corresponds to genes called differentially regulated by the method *compareSteady*. This method select differentially regulated genes based on the p-value of the Brown test previously chosen. Additionally, it is possible to visualize genes that are differentially according to a certain threshold of the Benjamini and Hochberg correction of the p-values (argument *padj*). Those genes will be visualized as orange triangles.

```
plotMA(diffrates, rate='synthesis', padj=1e-3)
```

![Representation of rate geometric mean and variation between conditions. plotMA generated image. Orange triangles correspond to genes whose rates are differentially used between the two conditions, blue cloud correspond to the whole distribution of rates.](data:image/png;base64...)

Figure 11: Representation of rate geometric mean and variation between conditions
plotMA generated image. Orange triangles correspond to genes whose rates are differentially used between the two conditions, blue cloud correspond to the whole distribution of rates.

## 4.2 Analysis of Total without Nascent RNA

It is not possible to estimate the kinetic rates from steady state data without nascent RNA expression data because of the underdetermination of the system (Equations [(1)](#eq:modelsystem)). The only information that can be extracted is the ratio between the premature (\(P\)) and mature (\(M\)) RNA:

\[\begin{equation}\label{eq:PTratio}
\nonumber
\frac{P}{M} = \frac{P\_{T}}{T\_{T} - P\_{T}} = \frac{k\_3}{k\_2} \\
\tag{5}
\end{equation}\]

where \(P\_{R}\) and \(T\_{R}\) are the premature and total RNA levels, respectively, estimated from the total RNA library. However, even from this aggregated quantity, valuable information regarding the differential post transcriptional regulation of genes in different samples can still be obtained.

This analysis is performed by the method *compareSteadyNoNascent* which takes as input an object of class *INSPEcT* created without nascent RNA, an expression threshold for premature and total RNA, to select reliable data to be analyzed (*expressionThreshold*) and the distance, expressed in log2, from the expected behavior beyond which a gene should be considered as post-transcriptionally regulated.

We noticed that the ratio \(P\) over \(M\) decreases along with the expression following a power law, which can be easily fitted in the log-log space by a linear model. This power law is calculated in the first step of the *compareSteadyNoNascent* analysis. Following that, genes that deviates from this trend across conditions are identified as differentially post-transcriptionally regulated.

```
conditions <- letters[1:11]
matureInspObj <- newINSPEcT(tpts=conditions
                           ,matureExpressions=matExp_DESeq2)
matureInspObj<-compareSteadyNoNascent(inspectIds=matureInspObj
                  ,expressionThreshold=0.25
                  ,log2FCThreshold=.5)
regGenes <- PTreg(matureInspObj)
regGenes[1:6,1:5]
```

```
##               a     b     c     d     e
## 100503670 FALSE FALSE FALSE FALSE FALSE
## 101206    FALSE FALSE FALSE FALSE    NA
## 101489    FALSE FALSE FALSE FALSE FALSE
## 102436       NA    NA    NA    NA    NA
## 104458    FALSE FALSE FALSE FALSE FALSE
## 104806       NA    NA    NA    NA    NA
```

```
table(regGenes, useNA='always')
```

```
## regGenes
## FALSE  TRUE  <NA>
##  3689    33  1558
```

The output of the function is a matrix of Booleans, as large as the expression input data, where TRUE means that a specific gene, in a given condition, is post-transcriptionally regulated in a peculiar way.

The entire analysis is based on the estimation of a standard behavior of a set of genes which means that benefits from the size of the dataset under analysis. The example is, obviously, just a proff of concept to explicit arguments and output of *compareSteadyNoNascent*; for this reason, we have decided to use time-course data. A real application does not require data to be temporally related in any way.

# 5 Wrap-up functions: running INSPEcT with a single command line

In order to ease the INSPEcT usage, we implemented two pipelines to run the complete INSPEcT analysis with a single command. These two pipelines, named *inspectFromBAM* and *inspectFromPCR*, take as input BAM files or direct measurements of exonic and intronic abundances, respectively, and the experimental design associated to them (namely, conditions or time-points) and run the analysis. According to the type of input, these routines start the procedure of INSPEcT- or INSPEcT+ and discriminate between steady-state and time-course experimental design. These two pipelines are less flexible than running single *INSPEcT* methods and allow the user to set a limited number of arguments.

Eventually, the output of the complete INSPEcT procedure is saved to an ‘.rds’ file, which can be loaded via command line or imported and visualized via *INSPEcT-GUI*.

## 5.1 Pipeline from BAM files

Here is an example of the pipeline that runs INSPEcT- starting from BAM files:

```
bamfiles_paths <- system.file('extdata/',
  c('bamRep1.bam','bamRep2.bam','bamRep3.bam','bamRep4.bam'),
  package='INSPEcT')
annotation_table_TOT<-data.frame(
    condition = c('ctrl','ctrl','treat','treat')
    , total = bamfiles_paths
    )
inspectFromBAM(txdb, annotation_table_TOT,
                             file=tempfile(fileext = 'rds'))
```

```
## Generating annotation from txdb...
```

```
## ##### - File: /tmp/RtmpA6Uzon/Rinst11b25d6cba2044/INSPEcT/extdata//bamRep1.bam - #####
```

```
## Importing bamfile...
```

```
## Counting reads on exon features...
```

```
## Counting reads on intron features...
```

```
## ##### - File: /tmp/RtmpA6Uzon/Rinst11b25d6cba2044/INSPEcT/extdata//bamRep2.bam - #####
```

```
## Importing bamfile...
```

```
## Counting reads on exon features...
```

```
## Counting reads on intron features...
```

```
## ##### - File: /tmp/RtmpA6Uzon/Rinst11b25d6cba2044/INSPEcT/extdata//bamRep3.bam - #####
```

```
## Importing bamfile...
```

```
## Counting reads on exon features...
```

```
## Counting reads on intron features...
```

```
## ##### - File: /tmp/RtmpA6Uzon/Rinst11b25d6cba2044/INSPEcT/extdata//bamRep4.bam - #####
```

```
## Importing bamfile...
```

```
## Counting reads on exon features...
```

```
## Counting reads on intron features...
```

```
## Estimation of expressions and variances using DESeq2...
```

```
## No nascent RNA mode.
```

```
## Removing 2853 gene(s) without intronic quantifications.
```

```
## Removing 2 gene(s) with intronic quantifications greater than the exonic.
```

```
## Filtering out 18820 gene(s) with more than  67 % of zeros in their exonic or intronic quantifications..
```

```
## Number of genes with introns and exons:  2
```

```
## Created steady state object.
```

```
## total INSPEcT analysis completed. File stored at
```

```
## /tmp/RtmpQdI4PX/file11bc6b3511922frds
```

## 5.2 Pipeline from PCR quantifications

Here is an example of the pipeline that runs INSPEcT+ starting quantification of intronic and exonic abundances in nascent and total RNA:

```
totalAnnTabPCR <- system.file(package = 'INSPEcT', 'totalAnnTabPCR.csv')
nascentAnnTabPCR <- system.file(package = 'INSPEcT', 'nascentAnnTabPCR.csv')
inspectFromPCR(totalAnnTabPCR, nascentAnnTabPCR, labeling_time=1/6,
                             file=tempfile(fileext = 'rds'))
```

```
## Nascent RNA mode, with exon and intron quantifications.
```

```
## Number of genes with introns and exons:  1
```

```
## Calculating scaling factor between total and Nascent libraries...
```

```
## Estimating degradation rates...
```

```
## Estimating processing rates...
```

```
## Nascent RNA data mode.
```

```
## Mature RNA fit.
```

```
## spd modeling.
```

```
## Confidence intervals.
```

```
## Calculating rate p-values...
```

```
## nascent INSPEcT analysis completed. File stored at
```

```
## /tmp/RtmpQdI4PX/file11bc6b6afa5c49rds
```

# 6 About this document

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
##  [1] TxDb.Mmusculus.UCSC.mm9.knownGene_3.2.2
##  [2] GenomicFeatures_1.62.0
##  [3] AnnotationDbi_1.72.0
##  [4] GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0
##  [6] IRanges_2.44.0
##  [7] S4Vectors_0.48.0
##  [8] INSPEcT_1.40.0
##  [9] BiocParallel_1.44.0
## [10] Biobase_2.70.0
## [11] BiocGenerics_0.56.0
## [12] generics_0.1.4
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            rootSolve_1.8.2.4
##  [3] dplyr_1.1.4                 farver_2.1.2
##  [5] blob_1.2.4                  Biostrings_2.78.0
##  [7] S7_0.2.0                    bitops_1.0-9
##  [9] fastmap_1.2.0               RCurl_1.98-1.17
## [11] promises_1.4.0              GenomicAlignments_1.46.0
## [13] pROC_1.19.0.1               XML_3.99-0.19
## [15] digest_0.6.37               mime_0.13
## [17] lifecycle_1.0.4             KEGGREST_1.50.0
## [19] RSQLite_2.4.3               magrittr_2.0.4
## [21] compiler_4.5.1              rlang_1.1.6
## [23] sass_0.4.10                 tools_4.5.1
## [25] yaml_2.3.10                 rtracklayer_1.70.0
## [27] knitr_1.50                  S4Arrays_1.10.0
## [29] bit_4.6.0                   curl_7.0.0
## [31] DelayedArray_0.36.0         RColorBrewer_1.1-3
## [33] KernSmooth_2.23-26          abind_1.4-8
## [35] grid_4.5.1                  xtable_1.8-4
## [37] ggplot2_4.0.0               scales_1.4.0
## [39] MASS_7.3-65                 tinytex_0.57
## [41] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
## [43] cli_3.6.5                   rmarkdown_2.30
## [45] crayon_1.5.3                otel_0.2.0
## [47] httr_1.4.7                  rjson_0.2.23
## [49] readxl_1.4.5                DBI_1.2.3
## [51] cachem_1.1.0                parallel_4.5.1
## [53] cellranger_1.1.0            BiocManager_1.30.26
## [55] XVector_0.50.0              restfulr_0.0.16
## [57] matrixStats_1.5.0           vctrs_0.6.5
## [59] Matrix_1.7-4                jsonlite_2.0.0
## [61] bookdown_0.45               bit64_4.6.0-1
## [63] magick_2.9.0                locfit_1.5-9.12
## [65] plgem_1.82.0                jquerylib_0.1.4
## [67] glue_1.8.0                  codetools_0.2-20
## [69] gtable_0.3.6                later_1.4.4
## [71] BiocIO_1.20.0               tibble_3.3.0
## [73] pillar_1.11.1               htmltools_0.5.8.1
## [75] deSolve_1.40                R6_2.6.1
## [77] shiny_1.11.1                evaluate_1.0.5
## [79] lattice_0.22-7              cigarillo_1.0.0
## [81] png_0.1-8                   Rsamtools_2.26.0
## [83] memoise_2.0.1               httpuv_1.6.16
## [85] bslib_0.9.0                 Rcpp_1.1.0
## [87] SparseArray_1.10.0          DESeq2_1.50.0
## [89] xfun_0.53                   MatrixGenerics_1.22.0
## [91] pkgconfig_2.0.3
```

# References

De Pretis, Stefano, Theresia Kress, Marco J Morelli, Giorgio EM Melloni, Laura Riva, Bruno Amati, and Mattia Pelizzola. 2015. “INSPEcT: A Computational Tool to Infer mRNA Synthesis, Processing and Degradation Dynamics from Rna-and 4sU-Seq Time Course Experiments.” *Bioinformatics* 31 (17): 2829–35. <https://doi.org/10.1093/bioinformatics/btv288>.

De Pretis, Stefano, Theresia R Kress, Marco J Morelli, Arianna Sabò, Chiara Locarno, Alessandro Verrecchia, Mirko Doni, Stefano Campaner, Bruno Amati, and Mattia Pelizzola. 2017. “Integrative Analysis of Rna Polymerase Ii and Transcriptional Dynamics Upon Myc Activation.” *Genome Research* 27 (10): 1658–64. <https://doi.org/10.1101/gr.226035.117>.

Furlan, Mattia, Eugenia Galeota, Nunzio del Gaudio, Erik Dassi, Michele Caselle, Stefano de Pretis, and Mattia Pelizzola. 2019. “Genome-Wide Dynamics of Rna Synthesis, Processing and Degradation Without Rna Metabolic Labeling.” *bioRxiv*. <https://doi.org/10.1101/520155>.