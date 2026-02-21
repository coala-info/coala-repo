# Demultiplexing oligonucleotide-labeled scRNA-seq data with demuxmix

Hans-Ulrich Klein1

1Center for Translational and Computational Neuroimmunology, Department of Neurology, Columbia University Irving Medical Center, New York, NY

#### 29 October 2025

#### Package

demuxmix 1.12.0

# 1 Introduction

Droplet-based single-cell RNA sequencing (scRNA-seq) facilitates measuring the
transcriptomes of thousands of cells in a single run. Pooling cells from
different samples or conditions before cell partitioning and library
preparation can significantly lower costs and reduce batch effects. The task of
assigning each cell of a pooled sample to its sample of origin is called
demultiplexing. If genetically diverse samples are pooled, single nucleotide
polymorphisms in coding regions can be used for demultiplexing. When working
with genetically similar or identical samples, an additional experimental step
is required to label the cells with a sample-specific barcode oligonucleotide
before pooling. Several techniques have been developed to label cells or nuclei
with oligonucleotides based on antibodies (Stoeckius et al. [2018](#ref-stoeckius); Gaublomme et al. [2019](#ref-gaublomme)) or lipids
(McGinnis et al. [2019](#ref-mcginnis)). These oligonucleotides are termed hashtag oligonucleotides (HTOs)
and are sequenced together with the RNA molecules of the cells resulting in an
(HTOs x droplets) count matrix in addition to the (genes x droplets) matrix
with RNA read counts.

The *demuxmix* package implements a method to demultiplex droplets based on HTO
counts using negative binomial regression mixture models. *demuxmix* can be
applied to the HTO counts only, but better results are often achieved if the
total number of genes detected per droplet (not the complete transcription
profile) is passed to the method along with the HTO counts to leverage the
positive association between genes detected and HTO counts. Further, *demuxmix*
provides estimated error rates based on its probabilistic mixture model
framework, plots for data quality assessment, and multiplet identification, as
outlined in the example workflows in this vignette. Technical details of the
methods are described in the man pages.

# 2 Installation

The *demuxmix* package is available at [Bioconductor](https://bioconductor.org)
and can be installed via *BiocManager::install*:

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("demuxmix")
```

The package only needs to be installed once. Load the package into an R
session with

```
library(demuxmix)
```

# 3 Quick start

A matrix of raw HTO counts (HTO x cells) and a vector with the number of
detected genes per droplet are needed to run *demuxmix* with default settings.
Empty and low-quality droplets should be removed before running *demuxmix*.
A gene with at least one read is usually considered as detected.
Here, we simulate a small example dataset.

```
library(demuxmix)

set.seed(2642)
class <- rbind(
    c(rep(TRUE,  220), rep(FALSE, 200)),
    c(rep(FALSE, 200), rep(TRUE,  220))
)
simdata <- dmmSimulateHto(class)
hto <- simdata$hto
dim(hto)
#> [1]   2 420
rna <- simdata$rna
length(rna) == ncol(hto)
#> [1] TRUE
```

The dataset consists of 420 droplets with cells labeled with two different HTOs.
The first 200 droplets are singlets labeled with the first HTO, followed by
another 200 singlets labeled with the second HTO. The remaining 20 droplets are
doublets, which are positive for both HTOs. Next, we run *demuxmix* to assign
droplets to HTOs.

```
dmm <- demuxmix(hto, rna = rna)
summary(dmm)
#>       Class NumObs     RelFreq   MedProb      ExpFPs          FDR
#> 1     HTO_1    198 0.475961538 0.9999994 0.419487123 0.0021186218
#> 2     HTO_2    197 0.473557692 0.9999985 0.287367473 0.0014587181
#> 3   singlet    395 0.949519231 0.9999992 0.706854596 0.0017895053
#> 4 multiplet     20 0.048076923 0.9999995 0.005837305 0.0002918652
#> 5  negative      1 0.002403846 0.9922442 0.007755814 0.0077558137
#> 6 uncertain      4          NA        NA          NA           NA
classes <- dmmClassify(dmm)
table(classes$HTO)
#>
#>       HTO_1 HTO_1,HTO_2       HTO_2    negative   uncertain
#>         198          20         197           1           4
```

The object *dmm* contains the mixture models used to classify the droplets. The
data frame returned by *summary* shows that 198
droplets were assigned to *HTO\_1* and 197 to
*HTO\_2*, respectively. Since these results meet our expectations and
the estimated error rates are reasonably low, we ran *dmmClassify* to obtain
the classifications for each droplet as a data frame with one row per droplet.
The first column *HTO* of this data frame contains the final classification
results.

A histogram of the HTO values overlayed with the components from the mixture
model can be plotted for quality control. The following command plots a panel
with one histogram per HTO in the dataset.

```
plotDmmHistogram(dmm)
```

![Density histograms overlayed with mixture probability mass function. The density histograms show the distribution of the HTO counts for the first HTO (upper figure) and the 2nd HTO (lower figure). The negative component of the mixture model representing non-tagged cells is shown in blue, and the positive component is in red.](data:image/png;base64...)

Figure 1: Density histograms overlayed with mixture probability mass function
The density histograms show the distribution of the HTO counts for the first HTO (upper figure) and the 2nd HTO (lower figure). The negative component of the mixture model representing non-tagged cells is shown in blue, and the positive component is in red.

# 4 Demultiplexing droplets with demuxmix

## 4.1 Example datasets

Two example datasets are introduced in this vignette to illustrate a typical
*demuxmix* workflow. The first dataset is a small simulated dataset used to
generate the plots when building this vignette. The alternative second dataset
is a real dataset and can be downloaded from the *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)*
via the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package. Both datasets can be used to go
through this vignette by running either the first (simulated data) or the
second code block (real data) below. Since the real dataset is much larger,
some commands may take up to one minute to complete, which is why this vignette
was built with the simulated data.

### 4.1.1 Simulated dataset

Simulated HTO count data are generated for 650 droplets by the method
*dmmSimulateHto*. The logical matrix *class* defines for each droplet (column)
and HTO (row) whether the droplet is positive or negative for that
HTO. Thus, the 3 x 650 matrix *class* below describes a dataset with 3
hashtags and 650 droplets, of which 50 are doublets (with cells tagged
by *HTO\_1* and *HTO\_2*). The remaining 600 droplets consist of 3 blocks of 200
singlets tagged by one of the three HTOs each.

```
library(demuxmix)
library(ggplot2)
library(cowplot)

set.seed(5636)
class <- rbind(
    c(rep( TRUE, 200), rep(FALSE, 200), rep(FALSE, 200), rep( TRUE, 50)),
    c(rep(FALSE, 200), rep( TRUE, 200), rep(FALSE, 200), rep( TRUE, 50)),
    c(rep(FALSE, 200), rep(FALSE, 200), rep( TRUE, 200), rep(FALSE, 50))
)
simdata <- dmmSimulateHto(
    class = class,
    mu = c(600, 400, 200),
    theta = c(25, 15, 25),
    muAmbient = c(30, 30, 60),
    thetaAmbient = c(20, 10, 5),
    muRna = 3000,
    thetaRna = 30
)
hto <- simdata$hto
rna <- simdata$rna

htoDf <- data.frame(t(hto), HTO = colSums(hto), NumGenes = rna)
pa <- ggplot(htoDf, aes(x = HTO_1)) +
    geom_histogram(bins = 25)
pb <- ggplot(htoDf, aes(x = HTO_2)) +
    geom_histogram(bins = 25)
pc <- ggplot(htoDf, aes(x = HTO_3)) +
    geom_histogram(bins = 25)
pd <- ggplot(htoDf, aes(x = NumGenes, y = HTO)) +
    geom_point()
plot_grid(pa, pb, pc, pd, labels = c("A", "B", "C", "D"))
```

![Characteristics of the simulated dataset. A) The histogram of the HTO counts from the first HTO (HTO_1) shows a clear separation between positive and negative droplets. B) The histogram of the second HTO (HTO_2) looks similar, although the positive droplets have a smaller mean count and a larger dispersion. C) The histogram of the third HTO reveals a more extensive overlap between the distributions of the positive and negative droplets. D) The scatter plot shows a positive correlation between the number of detected genes and HTO counts in the simulated data.](data:image/png;base64...)

Figure 2: Characteristics of the simulated dataset
A) The histogram of the HTO counts from the first HTO (HTO\_1) shows a clear separation between positive and negative droplets. B) The histogram of the second HTO (HTO\_2) looks similar, although the positive droplets have a smaller mean count and a larger dispersion. C) The histogram of the third HTO reveals a more extensive overlap between the distributions of the positive and negative droplets. D) The scatter plot shows a positive correlation between the number of detected genes and HTO counts in the simulated data.

*dmmSimulateHto* dmmSimulateHto returns a matrix with the simulated HTO counts
and a vector with the simulated number of detected genes for each droplet.
Figure [2](#fig:simulate) shows that we simulated two HTOs of excellent
quality (HTO\_1 and HTO\_2) and a third HTO (HTO\_3) with more background reads,
complicating the demultiplexing. Further, the simulated data shows a positive
association between the number of detected genes and the number of HTO counts
per droplet, which is often observed in real data.

### 4.1.2 Cell line mixture dataset

The cell line mixture dataset from Stoeckius et al. ([2018](#ref-stoeckius)) consists of cells from 4 different
cell lines. Three samples were taken from each cell line and tagged with a
different HTO resulting in a total of 12 different HTOs. The downloaded dataset
still contains many potentially empty droplets, which are removed using
*emptyDrops*. Subsequently, the numbers of detected genes are calculated and
the HTO matrix is extracted from the *SingleCellExperiment* object. More
information about the preprocessing and data structures for single-cell data in
Bioconductor can be found in this excellent
[online book](http://bioconductor.org/books/release/OSCA/index.html).

```
library(demuxmix)
library(ggplot2)
library(cowplot)
library(scRNAseq)
library(DropletUtils)

set.seed(8514)
htoExp <- StoeckiusHashingData(type = "mixed")
eDrops <- emptyDrops(counts(htoExp))
htoExp <- htoExp[, which(eDrops$FDR <= 0.001)]
rna <- colSums(counts(htoExp) > 0)
hto <- counts(altExp(htoExp))
dim(hto)

htoDf <- data.frame(t(hto[c("HEK_A", "KG1_B", "KG1_C"), ]),
    HTO = colSums(hto), NumGenes = rna
)
pa <- ggplot(htoDf, aes(x = HEK_A)) +
    geom_histogram(binwidth = 10) +
    coord_cartesian(xlim = c(0, 600), ylim = c(0, 500))
pb <- ggplot(htoDf, aes(x = KG1_B)) +
    geom_histogram(binwidth = 10) +
    coord_cartesian(xlim = c(0, 600), ylim = c(0, 500))
pc <- ggplot(htoDf, aes(x = KG1_C)) +
    geom_histogram(binwidth = 10) +
    coord_cartesian(xlim = c(0, 600), ylim = c(0, 500))
pd <- ggplot(htoDf, aes(x = NumGenes, y = HTO)) +
    geom_point(size = 0.1) +
    coord_cartesian(ylim = c(0, 750))
plot_grid(pa, pb, pc, pd, labels = c("A", "B", "C", "D"))
```

The plots generated by the code above reveal that the quality of the different
HTOs varies in the cell line mixture dataset. Most HTOs demonstrate a nicely
separated bimodal distribution, as exemplarily shown for *HEK\_A*, but *HG1\_C*
and, to a lesser extent, *HG1\_B*, demonstrate a larger overlap between the
distributions of the positive and negative droplets. As with the simulated
data, there is a positive association between HTO counts and the detected
number of genes. However, the association appears noisier because four
different cell lines with highly distinct RNA profiles and different cell
surface characteristics (likely influencing HTO labeling) were pooled.
Consequently, the HTO counts and the number of detected genes are very
different between cells from different samples but very similar between cells
from the same sample. This uncommon experimental design makes it difficult to
leverage the association between the number of genes detected and HTO counts
during demultiplexing. With default parameters, *demuxmix* automatically selects
the most appropriate model, and, for this dataset, naive instead of regression
mixture models are used for most HTOs. In addition, the large number of 12
pooled samples further complicates the demultiplexing.

## 4.2 Running demuxmix

*demuxmix* takes a matrix of HTO counts and a vector with the numbers of
detected genes per droplet as input and returns an object of class *Demuxmix*
containing a mixture model for each HTO. Several additional parameters can be
passed to *demuxmix*, but all these parameters have default values that work
well across many datasets. With the default settings, *demuxmix* automatically
selects either naive mixture models or regression mixture models for each HTO,
depending on which model provides the best separation between positive and
negative droplets.

```
dmm <- demuxmix(hto, rna = rna)
dmm
#> Demuxmix object with 3 HTOs and 650 cells.
#>   HTO_1: RegMixModel; converged
#>          mu=(29.012, 604.96)
#>          RNA coef. negative comp: 1.075, p=3.11e-35
#>                    positive comp: 0.9322, p=1.97e-35
#>   HTO_2: RegMixModel; converged
#>          mu=(30.364, 383.49)
#>          RNA coef. negative comp: 0.809, p=2.68e-14
#>                    positive comp: 0.8115, p=3.42e-21
#>   HTO_3: RegMixModel; converged
#>          mu=(62.133, 199.78)
#>          RNA coef. negative comp: 1.143, p=2.07e-21
#>                    positive comp: 1.08, p=8.43e-43
classLabels <- dmmClassify(dmm)
head(classLabels)
#>     HTO      Prob    Type
#> 1 HTO_1 0.9995790 singlet
#> 2 HTO_1 1.0000000 singlet
#> 3 HTO_1 0.9983449 singlet
#> 4 HTO_1 0.9988615 singlet
#> 5 HTO_1 0.9999997 singlet
#> 6 HTO_1 0.9999999 singlet

summary(dmm)
#>       Class NumObs    RelFreq   MedProb    ExpFPs         FDR
#> 1     HTO_1    198 0.31083203 0.9999958 1.3099257 0.006615786
#> 2     HTO_2    197 0.30926217 0.9999975 1.3625168 0.006916329
#> 3     HTO_3    184 0.28885400 0.9923134 5.5638155 0.030238128
#> 4   singlet    579 0.90894819 0.9998231 8.2362580 0.014224971
#> 5 multiplet     51 0.08006279 0.9999863 0.6500497 0.012746072
#> 6  negative      7 0.01098901 0.8841169 0.8390094 0.119858491
#> 7 uncertain     13         NA        NA        NA          NA

# Compare demultiplexing results to ground truth from simulation
table(classLabels$HTO, simdata$groundTruth)
#>
#>                     HTO_1 HTO_1,HTO_2 HTO_2 HTO_3
#>   HTO_1               198           0     0     0
#>   HTO_1,HTO_2           0          48     0     0
#>   HTO_1,HTO_2,HTO_3     0           2     0     0
#>   HTO_2                 0           0   197     0
#>   HTO_2,HTO_3           0           0     1     0
#>   HTO_3                 0           0     0   184
#>   negative              0           0     0     7
#>   uncertain             2           0     2     9
```

For the simulated data, the object *dmm* contains three regression mixture
models. We then apply *dmmClassify* to obtain a data frame with one row for
each droplet. The first column contains the classification result. The second
column contains the posterior probability that the assigned HTO is correct.
The last column contains the type of the assignment, which is either
“singlet”, “multiplet”, “negative” (not tagged by any HTO), or “uncertain”
(posterior probability too small to classify the droplet with confidence). Only
droplets of type singlet should be kept in the dataset. Multiplets of two or
more cells from the same sample cannot be detected at the demultiplexing step.
The comparison with the true labels from the simulation shows that most
droplets were classified correctly.

The parameter *model* can be used to select a specific mixture model. The naive
mixture model selected in the code below does not use any information from the
RNA data. As shown in the following output, the naive mixture model performs
slightly worse than the regression mixture model mainly because more
droplets are assigned to the class “uncertain”.

```
dmmNaive <- demuxmix(hto, model = "naive")
dmmNaive
#> Demuxmix object with 3 HTOs and 650 cells.
#>   HTO_1: NaiveMixModel; converged
#>          mu=(29.707, 614.7)
#>   HTO_2: NaiveMixModel; converged
#>          mu=(30.825, 390.29)
#>   HTO_3: NaiveMixModel; converged
#>          mu=(58.938, 191.29)
classLabelsNaive <- dmmClassify(dmmNaive)
summary(dmmNaive)
#>       Class NumObs     RelFreq   MedProb    ExpFPs        FDR
#> 1     HTO_1    175 0.293132328 0.9960974  5.400830 0.03086188
#> 2     HTO_2    179 0.299832496 0.9969071  4.060804 0.02268606
#> 3     HTO_3    180 0.301507538 0.9949591  4.711928 0.02617738
#> 4   singlet    534 0.894472362 0.9960974 14.173562 0.02654225
#> 5 multiplet     61 0.102177554 0.9811527  4.066596 0.06666551
#> 6  negative      2 0.003350084 0.9421215  0.115757 0.05787849
#> 7 uncertain     53          NA        NA        NA         NA

# Compare results of the naive model to ground truth from simulation
table(classLabelsNaive$HTO, simdata$groundTruth)
#>
#>                     HTO_1 HTO_1,HTO_2 HTO_2 HTO_3
#>   HTO_1               175           0     0     0
#>   HTO_1,HTO_2           0          42     0     0
#>   HTO_1,HTO_2,HTO_3     0           3     0     0
#>   HTO_1,HTO_3           9           0     0     0
#>   HTO_2                 0           0   179     0
#>   HTO_2,HTO_3           0           0     7     0
#>   HTO_3                 0           0     0   180
#>   negative              0           0     0     2
#>   uncertain            16           5    14    18
```

Another useful parameter is the acceptance probability *pAcpt*, which can be
passed to the *demuxmix* method to overwrite the default value, or
directly set in the object *dmm* as shown in the code block below. The parameter
is used at the classification step and specifies the minimum posterior
probability required to classify a droplet. If the posterior probability of the
most likely class is smaller than *pAcpt*, the droplet is classified as
“uncertain”. Setting *pAcpt* to 0 forces the classification of all droplets.
For HTO datasets of moderate quality, the default value can be lowered to
recover more droplet in the dataset, if a larger error rate is acceptable.
The *summary* method estimates the FDR depending on the current setting
of *pAcpt*.

```
pAcpt(dmm)
#> [1] 0.729
pAcpt(dmm) <- 0.95
summary(dmm)
#>       Class NumObs     RelFreq   MedProb     ExpFPs         FDR
#> 1     HTO_1    191 0.327615780 0.9999978 0.39912417 0.002089655
#> 2     HTO_2    190 0.325900515 0.9999986 0.24119804 0.001269463
#> 3     HTO_3    155 0.265866209 0.9943603 1.60287265 0.010341114
#> 4   singlet    536 0.919382504 0.9999483 2.24319486 0.004185065
#> 5 multiplet     45 0.077186964 0.9999972 0.07140102 0.001586689
#> 6  negative      2 0.003430532 0.9732852 0.05342954 0.026714771
#> 7 uncertain     67          NA        NA         NA          NA

pAcpt(dmm) <- 0
summary(dmm)
#>       Class NumObs    RelFreq   MedProb    ExpFPs         FDR
#> 1     HTO_1    200 0.30769231 0.9999952  1.943649 0.009718245
#> 2     HTO_2    198 0.30461538 0.9999974  1.683204 0.008501031
#> 3     HTO_3    191 0.29384615 0.9918053  8.372435 0.043834737
#> 4   singlet    589 0.90615385 0.9997875 11.999288 0.020372305
#> 5 multiplet     52 0.08000000 0.9999849  1.092788 0.021015155
#> 6  negative      9 0.01384615 0.8036236  1.588729 0.176525464
#> 7 uncertain      0         NA        NA        NA          NA
```

## 4.3 Quality control

The *demuxmix* package implements methods for assessing data quality and
model fit. All plotting methods plot a panel with one graph for each HTO in the
dataset as default. Specific HTOs can be selected via the parameter *hto*. The
most informative plot is probably the histogram of the HTO data overlaid with
the mixture probability mass function, as this plot shows both the raw data
and the model fit.

```
plotDmmHistogram(dmm)
```

![Density histograms overlayed with mixture probability mass functions. The density histogram is shown for each HTO in the simulated dataset. The negative component of the respective mixture model representing non-tagged cells (blue) and the positive component (red) are plotted on top of the histogram. The black curve is the mixture pmf.](data:image/png;base64...)

Figure 3: Density histograms overlayed with mixture probability mass functions
The density histogram is shown for each HTO in the simulated dataset. The negative component of the respective mixture model representing non-tagged cells (blue) and the positive component (red) are plotted on top of the histogram. The black curve is the mixture pmf.

```
dmmOverlap(dmm)
#>        HTO_1        HTO_2        HTO_3
#> 6.612645e-10 1.392127e-05 4.829136e-02
```

First, the histograms should be used to verify the model fit. The model
fit is good if the mixture pmf closely follows the shape of the histogram.
The model fit in the simulated data is adequate for all three HTOs. Second,
the histogram should be bimodal, and the blue and red components should show
little overlap, which is the case for the first two HTOs (HTO\_1 and HTO\_2).
The third HTO (HTO\_3) was simulated to harbor more background reads (mean
of 60 reads), and, consequently, the blue component is shifted towards the
right. The method *dmmOverlap* calculates the area intersected by the two
components. The area is close to zero for the first two HTOs but
0.048 for HTO\_3. As a rule of
thumb, an overlap less than 0.03 can be considered excellent. As seen in
this example dataset, a value around 0.05 will lead to some droplets being
classified as “uncertain” but is still sufficient to accurately
demultiplex the majority of droplets.

The histogram plots can look very different across different real datasets
depending on (i) the HTO sequencing depth, (ii) the number of pooled
samples, (iii) the number of droplets, and (iv) the quality of the HTO
experiment (cross-staining, background HTOs, cell debris). Only the last
factor (iv) relates to the actual quality of the data. Specifically,
(i) and (ii) can both lead to a histogram that looks like a vertical blue
line with an x-offset of 0 and a flat horizontal red line with a y-offset
of 0. The reason is that a large sequencing depth results in large
HTO counts in positive droplets so that the probability mass of the red
component spreads over an extensive range of values on the x-axis and
appears flat compared to the sharp location of the blue background component.
Similarly, a large number of pooled samples, e.g., the 12 samples in the
cell line mixture dataset, causes the red component to appear flat as it
only covers an area of about 1/12 compared to 11/12 covered by the blue
component. In such cases, it is helpful to zoom into the critical part of
the histogram where the red and blue components overlap. For the cell line
mixture dataset, the following command generates a suitable histogram for
the first HTO (panel B).

```
pa <- plotDmmHistogram(dmm, hto=1)
pb <- plotDmmHistogram(dmm, hto=1) +
    coord_cartesian(xlim = c(0, 200), ylim = c(0, 0.01))
plot_grid(pa, pb, labels = c("A", "B"))
```

Another useful quality plot is the histogram of the posterior probability that a
droplet is positive for the respective HTO.

```
plotDmmPosteriorP(dmm)
```

![Histograms of posterior probabilities. Each histogram shows the distribution of the posterior probabilities that a droplet contains a tagged cell. Posterior probabilities were obtained from the mixture model fitted to the respective HTO data.](data:image/png;base64...)

Figure 4: Histograms of posterior probabilities
Each histogram shows the distribution of the posterior probabilities that a droplet contains a tagged cell. Posterior probabilities were obtained from the mixture model fitted to the respective HTO data.

As seen in the first two histograms for HTO\_1 and HTO\_2, most droplets should
have a posterior probability close to 0 (negative droplet) or close to 1
(positive droplet). Consistent with the previous quality plots, the third HTO
(HTO\_3) demonstrates some droplets with posterior probabilities between
0 and 1, reflecting droplets with cells of uncertain origin.

Finally, if regression mixture models were used, the decision boundary in
relation to the number of detected genes and the HTO counts can be plotted.

```
plotDmmScatter(dmm)
```

![Decision boundary. The scatter plots show the relation between the number of detected genes and HTO counts for each of the three HTOs. The color indicates the posterior probability. The black dashed line depicts the decision boundary where the posterior probability is 0.5.](data:image/png;base64...)

Figure 5: Decision boundary
The scatter plots show the relation between the number of detected genes and HTO counts for each of the three HTOs. The color indicates the posterior probability. The black dashed line depicts the decision boundary where the posterior probability is 0.5.

These plots are only available if regression mixture models were used. A
droplet with many detected genes is required to have more HTO reads in order
to be classified as positive. If naive mixture models were used, the dashed
decision boundaries between blue (negative) and red (positive) droplets would
be vertical lines.

## 4.4 Comparison to hashedDrops

The method *hashedDrops* in the package *[DropletUtils](https://bioconductor.org/packages/3.22/DropletUtils)* provides
an alternative approach for demultiplexing HTO-labeled single cell data. The
following code block runs *hashedDrops* and compares the results to *demuxmix*.

```
suppressPackageStartupMessages(library(DropletUtils))
suppressPackageStartupMessages(library(reshape2))
hd <- hashedDrops(hto)
hdrops <- rownames(hto)[hd$Best]
hdrops[!hd$Confident] <- "uncertain"
hdrops[hd$Doublet] <- "multiplet"

dmux <- classLabels$HTO
dmux[classLabels$Type == "multiplet"] <- "multiplet"

comp <- melt(as.matrix(table(dmux, hdrops)))
colnames(comp) <- c("demuxmix", "hashedDrops", "Count")
comp$color <- ifelse(comp$Count > 100, "black", "white")
ggplot(comp, aes(x = demuxmix, y = hashedDrops, fill = Count)) +
    geom_tile() +
    scale_fill_viridis_c() +
    geom_text(aes(label = Count), col = comp$color, size = 5)
```

![Comparison between demuxmix and hashedDrops. The heatmap depicts the classification results for the simulated dataset obtained from demuxmix on the x-axis and hashedDrops on the y-axis.](data:image/png;base64...)

Figure 6: Comparison between demuxmix and hashedDrops
The heatmap depicts the classification results for the simulated dataset obtained from demuxmix on the x-axis and hashedDrops on the y-axis.

The classifications of both methods are highly concordant. No droplet has been
assigned to different singlet classes by the two approaches. However,
*hashedDrops* assigned more droplets tagged by HTO\_3 to the category
“uncertain”, which is expected when looking at the lower panel of Figure
[5](#fig:qualityScatterplot). In contrast to *demuxmix*, *hashedDrops* does
not utilize the positive association between the number of genes and HTO counts
explicitly simulated in this dataset.

# 5 Special usecase: pooling non-labeled with labeled cells

If precious rare cells are pooled with highly abundant cells, labeling the
highly abundant cells only but not the rare cells avoids additional losses of
the rare cells during the labeling process. However, such a design results in
a more challenging demultiplexing task. The real dataset used as an example
in this section consists of rare cerebrospinal fluid cells (non-labeled) and
peripheral blood mononuclear cells (PBMCs) stained with
oligonucleotide-conjugated antibodies. In this design, the “negative” cells
identified by demuxmix correspond to the CSF cells. The dataset is included
in the *demuxmix* package as a data frame.

```
data(csf)
head(csf)
#>                      HTO NumGenes freemuxlet freemuxlet.prob
#> AAACCCATCAATCGGT-1 21087     2640        0,0         0.00000
#> AAACCCATCATTTACC-1  3616      414        0,0        -1.47424
#> AAACGAATCGGTCTAA-1  5387     1841        0,0         0.00000
#> AAACGCTAGGGAGTGG-1  3293     1743        0,0         0.00000
#> AAACGCTAGTGATTCC-1  3876     3296        0,0         0.00000
#> AAAGAACCACACTGGC-1  1150     3540        1,1         0.00000

csf <- csf[csf$NumGenes >= 200, ]
nrow(csf)
#> [1] 2510
hto <- t(matrix(csf$HTO, dimnames = list(rownames(csf), "HTO")))
```

The data frame contains the number of HTO reads and the number of detected
genes per droplet in the first two columns. We remove all droplets with less
than 200 detected genes since these droplets are unlikely to contain intact
cells. The HTO counts are then converted into a matrix as required by
*demuxmix*. The matrix has only one row since only the PBMCs were stained.
For this example dataset, CSF cells and PBMCs from two genetically
unrelated donors were pooled so that genetic demultiplexing could be
used to benchmark the HTO-based demultiplexing. The third column contains
the result from the genetic demultiplexing using *freemuxlet* (Kang et al. [2018](#ref-kang)). The
fourth column contains *freemuxlet’s* logarithmized posterior probability.

```
dmm <- demuxmix(hto, rna = csf$NumGenes)
dmm
#> Demuxmix object with 1 HTO and 2510 cells.
#>   HTO: RegMixModel; converged
#>        mu=(897.39, 4977.8)
#>        RNA coef. negative comp: 0.02205, p=0.448
#>                  positive comp: 0.3756, p=1.16e-73

summary(dmm)
#>       Class NumObs   RelFreq   MedProb   ExpFPs         FDR
#> 1       HTO   1099 0.4625421 0.9999986 3.708186 0.003374146
#> 2   singlet   1099 0.4625421 0.9999986 3.708186 0.003374146
#> 3 multiplet      0 0.0000000        NA 0.000000         NaN
#> 4  negative   1277 0.5374579 0.9999490 4.608103 0.003608538
#> 5 uncertain    134        NA        NA       NA          NA

dmmOverlap(dmm)
#>        HTO
#> 0.02682714
```

*demuxmix* selected a regression mixture model with a significant
regression coefficient in the positive component, indicating that the number of
detected genes in the stained PBMCs is predictive of the HTO counts observed
in these cells. Although *demuxmix* selected a regression model for the
negative component as well, the smaller coefficient and the larger p-value
suggest that the association is much weaker in the CSF cells. This is common
since a larger amount of background HTOs is required in order to detect the
association in the negative droplets.

Next, we look at some QC plots.

```
histo <- plotDmmHistogram(dmm)
scatter <- plotDmmScatter(dmm) + coord_cartesian(xlim = c(2, 4))
plot_grid(histo, scatter, labels = c("A", "B"), nrow = 2)
```

![Demultiplexing a pool of labeled PBMCs and non-labeled CSF cells. A) The density histogram overlaid with the mixture pmf shows a good separation between the positive red component (PMBCs) and the negative blue component (CSF cells). B) The scatter plot shows the number of HTO reads (x-axis) versus the number of detected genes (y-axis) on the logarithmic scale. The color indicates the posterior probability of the droplet containing a tagged cell.](data:image/png;base64...)

Figure 7: Demultiplexing a pool of labeled PBMCs and non-labeled CSF cells
A) The density histogram overlaid with the mixture pmf shows a good separation between the positive red component (PMBCs) and the negative blue component (CSF cells). B) The scatter plot shows the number of HTO reads (x-axis) versus the number of detected genes (y-axis) on the logarithmic scale. The color indicates the posterior probability of the droplet containing a tagged cell.

Overall, the histogram reveals a good model fit but also shows some background
staining of the CSF cells. The mean of the negative component is
897.4
reads. Still, the overlap with the positive component (mean of
4977.8)
is reasonably small, and the larger mean of the negative component is probably
driven partly by the large sequencing depth of the HTO library. Moreover,
the scatter plot shows that a smaller set of cells has a lower RNA content
(y-axis) and that those cells require less HTO counts (x-axis) in order
to be classified as positive (red color).

Finally, we use genetic demultiplexing to assess *demuxmix’s* performance.
Multi-sample multiplets detected by freemuxlet are removed since multiplets
cannot be detected when just one of two samples is stained. We also
remove cells that were not classified with high confidence by freemuxlet.

```
class <- dmmClassify(dmm)
highConf <- csf$freemuxlet %in% c("0,0", "1,1") &
    exp(csf$freemuxlet.prob) >= 0.99
table(class$HTO[highConf], csf$freemuxlet[highConf])
#>
#>              0,0  1,1
#>   HTO       1036   22
#>   negative    39 1143
#>   uncertain   52   55

# Sensitivity "P(class=PBMC | PBMC)"
sum(csf$freemuxlet[highConf] == "0,0" & class$HTO[highConf] == "HTO") /
    sum(csf$freemuxlet[highConf] == "0,0" & class$HTO[highConf] != "uncertain")
#> [1] 0.9637209

# Specificity "P(class=CSF | CSF)"
sum(csf$freemuxlet[highConf] == "1,1" & class$HTO[highConf] == "negative") /
    sum(csf$freemuxlet[highConf] == "1,1" & class$HTO[highConf] != "uncertain")
#> [1] 0.9811159
```

With the default acceptance probability of 0.9, *demuxmix* achieved a
sensitivity and specificity above 95%. Only
107 cells were classified as
“uncertain” and have to be discarded.

For comparison, we run *demuxmix* again and, this time, manually select the
naive mixture model.

```
dmmNaive <- demuxmix(hto, model = "naive")
class <- dmmClassify(dmmNaive)
table(class$HTO[highConf], csf$freemuxlet[highConf])
#>
#>              0,0  1,1
#>   HTO       1027   28
#>   negative    45 1120
#>   uncertain   55   72

# Sensitivity "P(class=PBMC | PBMC)"
sum(csf$freemuxlet[highConf] == "0,0" & class$HTO[highConf] == "HTO") /
    sum(csf$freemuxlet[highConf] == "0,0" & class$HTO[highConf] != "uncertain")
#> [1] 0.9580224

# Specificity "P(class=CSF | CSF)"
sum(csf$freemuxlet[highConf] == "1,1" & class$HTO[highConf] == "negative") /
    sum(csf$freemuxlet[highConf] == "1,1" & class$HTO[highConf] != "uncertain")
#> [1] 0.9756098
```

The naive model achieved a slightly lower sensitivity and specificity than the
regression mixture model. In addition, more cells were classified as
“uncertain”, demonstrating the benefit of modeling the relationship between
the number of detected genes and HTO counts.

# 6 Session Info

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] reshape2_1.4.4              DropletUtils_1.30.0
#>  [3] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [5] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0               IRanges_2.44.0
#>  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [11] generics_0.1.4              MatrixGenerics_1.22.0
#> [13] matrixStats_1.5.0           cowplot_1.2.0
#> [15] ggplot2_4.0.0               demuxmix_1.12.0
#> [17] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1          viridisLite_0.4.2
#>  [3] dplyr_1.1.4               farver_2.1.2
#>  [5] R.utils_2.13.0            S7_0.2.0
#>  [7] fastmap_1.2.0             digest_0.6.37
#>  [9] lifecycle_1.0.4           statmod_1.5.1
#> [11] magrittr_2.0.4            compiler_4.5.1
#> [13] rlang_1.1.6               sass_0.4.10
#> [15] tools_4.5.1               yaml_2.3.10
#> [17] knitr_1.50                S4Arrays_1.10.0
#> [19] labeling_0.4.3            dqrng_0.4.1
#> [21] DelayedArray_0.36.0       plyr_1.8.9
#> [23] RColorBrewer_1.1-3        abind_1.4-8
#> [25] BiocParallel_1.44.0       HDF5Array_1.38.0
#> [27] withr_3.0.2               R.oo_1.27.1
#> [29] grid_4.5.1                beachmat_2.26.0
#> [31] Rhdf5lib_1.32.0           edgeR_4.8.0
#> [33] scales_1.4.0              MASS_7.3-65
#> [35] dichromat_2.0-0.1         tinytex_0.57
#> [37] cli_3.6.5                 rmarkdown_2.30
#> [39] DelayedMatrixStats_1.32.0 scuttle_1.20.0
#> [41] cachem_1.1.0              rhdf5_2.54.0
#> [43] stringr_1.5.2             parallel_4.5.1
#> [45] BiocManager_1.30.26       XVector_0.50.0
#> [47] vctrs_0.6.5               Matrix_1.7-4
#> [49] jsonlite_2.0.0            bookdown_0.45
#> [51] magick_2.9.0              h5mread_1.2.0
#> [53] locfit_1.5-9.12           limma_3.66.0
#> [55] jquerylib_0.1.4           glue_1.8.0
#> [57] codetools_0.2-20          stringi_1.8.7
#> [59] gtable_0.3.6              tibble_3.3.0
#> [61] pillar_1.11.1             htmltools_0.5.8.1
#> [63] rhdf5filters_1.22.0       R6_2.6.1
#> [65] sparseMatrixStats_1.22.0  evaluate_1.0.5
#> [67] lattice_0.22-7            R.methodsS3_1.8.2
#> [69] bslib_0.9.0               Rcpp_1.1.0
#> [71] gridExtra_2.3             SparseArray_1.10.0
#> [73] xfun_0.53                 pkgconfig_2.0.3
```

# References

Gaublomme, JT, B Li, C McCabe, A Knecht, Y Yang, E Drokhlyansky, N Van Wittenberghe, et al. 2019. “Nuclei Multiplexing with Barcoded Antibodies for Single-Nucleus Genomics.” *Nature Communications* 10 (1): 2907.

Kang, HM, M Subramaniam, S Targ, M Nguyen, L Maliskova, E McCarthy, E Wan, et al. 2018. “Multiplexed Droplet Single-Cell Rna-Sequencing Using Natural Genetic Variation.” *Nature Biotechnology* 36 (1): 89–94.

McGinnis, CS, DM Patterson, J Winkler, DN Conrad, MY Hein, V Srivastava, JL Hu, et al. 2019. “MULTI-Seq: Sample Multiplexing for Single-Cell Rna Sequencing Using Lipid-Tagged Indices.” *Nature Methods* 16 (7): 619–26.

Stoeckius, M, S Zheng, B Houck-Loomis, S Hao, BZ Yeung, WM Mauck, P Smibert, and R Satija. 2018. “Cell Hashing with Barcoded Antibodies Enables Multiplexing and Doublet Detection for Single Cell Genomics.” *Genome Biology* 19 (1): 224.