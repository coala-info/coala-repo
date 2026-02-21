An Introduction to zitools

30 October 2025

Contents

1

2

Introduction .

Installation .

.

.

.

.

.

.

.

.

.

.

.

Example Dataset .

Analysis using zitools .

Basic Statistic Quantities .

Boxplots .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Differential Abundance Analysis .

Plot Differential Abundance Result

Missing Value Heatmap .

.

.

.

.

Principal Component Analysis .

.

.

Interaction with the phyloseq package .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2

2

2

3

3

4

8

9

10

11

11

13

2.1

2.2

2.3

2.4

2.5

2.6

2.7

2.8

2.9

3

Session Info .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

An Introduction to zitools

1

Introduction

This vignette provides an introductory example on how to work with the ‘zitools’ package,
which implements a weighting strategy based on a fitted zero inflated mixture model. ‘zitools’
allows for zero inflated count data analysis by either using down-weighting of excess zeros or by
replacing an appropriate proportion of excess zeros with NA. Through overloading frequently
used statistical functions (such as mean, median, standard deviation), plotting functions (such
as boxplots or heatmap) or differential abundance tests, it allows a wide range of downstream
analyses for zero-inflated data in a less biased manner.

2

Installation

if (!requireNamespace("BiocManager", quietly = TRUE))

install.packages("BiocManager")

BiocManager::install("zitools")

Let’s start with loading the ‘zitools’-package:

library(zitools)

and loading additionally required packages.

library(phyloseq)

library(DESeq2)

library(tidyverse)

library(microbiome)

2.1

Example Dataset

An example microbiome dataset from the R package microbiome is used to display the ‘zitools’
workflow. The data used here are described in [Lahti et. al.] {https://pubmed.ncbi.nlm.nih.
gov/23638368/}.

The study, in which this dataset was generated, was conducted to investigate the impact of
probiotic intervention on the human intestinal microbiome. Therefore, the intestinal microbiota
diversity was analysed by performing 16S rRNA sequencing obtained from fecal samples. The
datasetcomprises 22 subjects - 8 from the probiotic group and 14 from the placebo group, all
samples were analysed before and after the intervention (44 samples in total).

In a first step, the dataset is loaded.

data("peerj32")

phyloseq <- peerj32[["phyloseq"]]
sample_data(phyloseq)$time <- factor(sample_data(phyloseq)$time)

#> Formal class 'phyloseq' [package "phyloseq"] with 5 slots

#>

#>

..@ otu_table:Formal class 'otu_table' [package "phyloseq"] with 2 slots
..@ tax_table:Formal class 'taxonomyTable' [package "phyloseq"] with 1 slot
..@ sam_data :'data.frame':

#>
#> Formal class 'sample_data' [package "phyloseq"] with 4 slots

5 variables:

44 obs. of

2

An Introduction to zitools

#>

#>

..@ phy_tree : NULL
: NULL
..@ refseq

2.2

Analysis using zitools

The zero inflation analysis steps are wrapped into a single function, called ziMain. It fits a
zero-inflated mixture model to the data. Per default structural zeros are estimated from counts
using features (=rows) and samples (=columns) as predictor variables when fitting a zero
inflated negative binomial model. Based on the fitted model, probabilities that count values
are structural zeros are calculated. Considering these probabilities, the function generates a
deinflated count matrix by replacing predicted structural zeros with NA and simultaneously
computes weights given that a zero count is a structural zero. Thus, the ziMain function
integrates the fitting process, probability calculation, deinflation, and weight calculation by a
single function call.

Zi <- ziMain(phyloseq)

print(Zi)

#> Formal class 'Zi' [package "zitools"]

#>

#>

#>

features (rows), samples (columns)

5720 data points, 1276(22.308%) zeros, 1219(21.311%)

structual zeros estimated with count ~ sample + feature

#> Formal class 'Zi' [package "zitools"] with 5 slots

#>

#>

#>

#>

#>

#>

#>

#>

..@ inputdata

:Formal class 'phyloseq' [package "phyloseq"] with 5 slots

..@ inputcounts
.. ..- attr(*, "dimnames")=List of 2
..@ model

:List of 1

: int [1:130, 1:44] 0 6 0 224 0 169 0 20 360 10 ...

..@ deinflatedcounts: int [1:130, 1:44] NA 6 NA 224 NA 169 NA 20 360 10 ...
.. ..- attr(*, "dimnames")=List of 2
..@ weights
.. ..- attr(*, "dimnames")=List of 2

: num [1:130, 1:44] 0.0748 1 0.0554 1 0.0084 ...

#> Use str(object) to inspect the whole object structure.

2.3

Basic Statistic Quantities

Following the OOP concept of polymorphism, already implemented functions can be called
with an Zi-object without further arguments as demonstrated in the following examples.
Please note, that the basic functionality was not reimplemented.
Instead only a wrapper
methods for Zi-class objects were written that pass the appropriate information to existing
functions. This ensures that the full functionality coincides.

mean(Zi)

#> [1] 259.3661

sd(Zi)

#> [1] 524.7669

var(Zi)

#> [1] 275380.3

median(Zi)

#> [1] 67

quantile(Zi)

3

An Introduction to zitools

#>

#>

0% 25% 50% 75% 100%

0

13

67 289 9734

2.4

Boxplots

Batch effects within the dataset can be visualized by plotting the data as boxplots over
samples. The boxplot function is overloaded for the Zi-class and can be called without further
arguments.

boxplot(log2p(Zi), xlab = "samples", ylab = "log2(count+1)",

main = "ZI considered")

boxplot(log2p(inputcounts(Zi)), xlab = "samples", ylab = "log2(count+1)",

main = "ZI not considered")

4

sample−1sample−11sample−21sample−31sample−41024681012ZI consideredsampleslog2(count+1)An Introduction to zitools

Considering that the process of generating deinflatedcounts is based on a random drawings,
resample_deinflatedcounts repeating the process of drawing structural zeros can be performed
to evaluate influences of this random drawing process. Visualization based on resampled
deinflatedcounts via boxplots shows only minor differences. Slight differences are highlighted
by red circles. This suggests that the randomness inherent in the drawing process has only a
small influence on the distributions and summary statistics within individual samples.

i <- 1

repeat {

Zi <- resample_deinflatedcounts(Zi)
boxplot(log2p(Zi), xlab = "samples", ylab = "log2(count+1)",

main = paste("Iteration", i))

i = i+1

if(i==6){

break

}

}

5

sample−1sample−11sample−21sample−31sample−41024681012ZI not consideredsampleslog2(count+1)An Introduction to zitools

6

sample−1sample−11sample−21sample−31sample−41024681012Iteration 1sampleslog2(count+1)sample−1sample−11sample−21sample−31sample−41024681012Iteration 2sampleslog2(count+1)An Introduction to zitools

7

sample−1sample−11sample−21sample−31sample−41024681012Iteration 3sampleslog2(count+1)sample−1sample−11sample−21sample−31sample−41024681012Iteration 4sampleslog2(count+1)An Introduction to zitools

2.5

Differential Abundance Analysis

To identify differentially abundant taxa between two groups of the dataset (e.g. patients
vs. controls), differential abundance analysis using the [DESeq2]{https://bioconductor.org/
packages/release/bioc/html/DESeq2.html} package can be performed. As a first step, the
object of a Zi-class has to be transformed in a DESeqDataSet object using zi2deseq2. In
this process, weights for down-weighting structural zeros are included in the DESeqDataSet.
Therefore, when performing the actual differential abundance analysis weights are automatically
incorporated in the calculation of differentially abundant taxa. Log2 fold changes are calculated
by DESeq() and the Wald statistic is used to calculate p-values and to identify differentially
abundant taxa. In this example, only positive counts are used to estimate the size factors
required for normalization within DESeq2, i.e. zeros do not contribute. For simplicity, the
model used for the differential abundance analysis is a simple model with only one factor
(time), with the timepoints being 1, before intervention and 2, after intervention.

DDS <- zi2deseq2(Zi, ~time)

#> converting counts to integer mode

DDS$Subject <- relevel(DDS$time, ref = "1")

DDS <- DESeq(DDS, test = "Wald", fitType = "local", sfType = "poscounts")

#> estimating size factors

#> estimating dispersions

#> gene-wise dispersion estimates

#> mean-dispersion relationship

#> final dispersion estimates

#> fitting model and testing

#> -- replacing outliers and refitting for 18 genes

#> -- DESeq argument 'minReplicatesForReplace' = 7

#> -- original counts are preserved in counts(dds)

#> estimating dispersions

#> fitting model and testing

8

sample−1sample−11sample−21sample−31sample−41024681012Iteration 5sampleslog2(count+1)An Introduction to zitools

(result <- results(DDS, cooksCutoff = FALSE))

#> log2 fold change (MLE): time 2 vs 1

#> Wald test p-value: time 2 vs 1

#> DataFrame with 130 rows and 6 columns

#>

#>

baseMean log2FoldChange

lfcSE

stat

<numeric>

<numeric> <numeric>

<numeric>

#> Actinomycetaceae

4.188827

-0.00666631

0.472869 -0.0140976

#> Aerococcus

#> Aeromonas

#> Akkermansia

5.641624

6.101542

0.13599050

0.470069

0.2892990

0.31312343

0.495150

0.6323809

507.121152

0.05519229

0.347252

0.1589404

#> Alcaligenes faecalis et rel.

0.764668

-0.97271514

1.048221 -0.9279675

#> ...

#> Weissella et rel.

#> Vibrio

#> Wissella et rel.

#> Xanthomonadaceae

#> Yersinia et rel.

#>

#>

#> Actinomycetaceae

#> Aerococcus

#> Aeromonas

#> Akkermansia

...

13.82174

9.28438

10.25831

11.70166

2.39337

pvalue

...

...

...

-0.381414

0.431929

-0.883049

0.394165

0.330282

1.193422

-1.276348

0.466582

-2.735529

-0.302808

0.384044

-0.788473

-0.500261

0.598083

-0.836440

padj

<numeric> <numeric>

0.988752

0.989108

0.772353

0.989108

0.527138

0.989108

0.873716

0.989108

#> Alcaligenes faecalis et rel.

0.353424

0.989108

#> ...

#> Weissella et rel.

#> Vibrio

#> Wissella et rel.

#> Xanthomonadaceae

#> Yersinia et rel.

...

...

0.37720989

0.989108

0.23270416

0.931082

0.00622802

0.257167

0.43042027

0.989108

0.40290717

0.989108

result <- as.data.frame(result)

2.6

Plot Differential Abundance Result

The most common depiction of the magnitude of the differential abundances and their
significance is a so-called Volcano plot with fold-changes on the horizontal axis and p-values
on the negative log10-scale on the vertical axis. Volcano plot can be generated manually as
demonstrated in the following.

print(ggplot(data=result_df, aes(x=log2FoldChange,

y=-log10(pvalue),

color = Genus)) +
geom_point()+
theme_minimal()+
xlim(-6,6)+

ylim(-0.5,4)+

ylab("-log10(pvalue)\n")+

xlab("\nLog2FoldChange")+
geom_vline(xintercept=c(-1, 1), col="black") +
geom_hline(yintercept=-log10(0.05), col="black")+

9

An Introduction to zitools

theme(text = element_text(size = 20))+
theme(panel.spacing.x = unit(2, "lines")))

2.7 Missing Value Heatmap

Heatmaps allow for discovering patterns of variation in the data by identifying regions of high
or low abundance. By plotting a MissingValueHeatmap the amount of predicted structural
zeros can be visualized as they are represented by NA values of the deinflated count matrix.
For demonstration purposes, all values > 500 are set to 500 for better color coding.

MissingValueHeatmap(Zi2, xlab = "Sample")

10

01234−6−3036Log2FoldChange−log10(pvalue)GenusLactobacillus gasseri et rel.Lactobacillus plantarum et rel.Mitsuokella multiacida et rel.Prevotella melaninogenica et rel.Wissella et rel.NA050100sample−1sample−2sample−3sample−4sample−5sample−6sample−7sample−8sample−9sample−10sample−11sample−12sample−13sample−14sample−15sample−16sample−17sample−18sample−19sample−20sample−21sample−22sample−23sample−24sample−25sample−26sample−27sample−28sample−29sample−30sample−31sample−32sample−33sample−34sample−35sample−36sample−37sample−38sample−39sample−40sample−41sample−42sample−43sample−44Samplevalue0100200300400500An Introduction to zitools

2.8

Principal Component Analysis

There is no principal component analysis method that enables the direct consideration of
individual weights for each data point. However, by splitting the calculations, visualization is
feasible. First, weighted correlations are computed by taking into account the weights assigned
to each data point. Then, principal components are calculated from these correlations and
the weighted scaled data is projected to these principal components.

PCA <- princomp(covmat = cor(t(Zi)), cor = FALSE)
centered_data <- (inputcounts(t(Zi))-colMeans2(t(Zi)))/sqrt(colVars(t(Zi)))
loadings <- PCA$loadings
scores <- centered_data %*% loadings
PCA$scores <- scores

df_PCA <- data.frame("PC1" = PCA[["scores"]][,1], "PC2" = PCA[["scores"]][,2],

"group" = sample_data(Zi)$group)

#> Warning: Removed 9 rows containing missing values or values outside the scale range
#> (`geom_point()`).

2.9

Interaction with the phyloseq package

To allow for an even wider range of analysis methods, the function zi2phyloseq() creates a
phyloseq object where the otu_table is replaced with deinflatedcounts. Therefore, functions
of the phyloseq package can be used while also accounting for the zero inflation weights
calculated via our zitools package.

new_phyloseq <- zi2phyloseq(Zi)

11

−200−1000100200−200−1000100PC1 14.6%PC2 9.9%groupLGGPlaceboAn Introduction to zitools

str(otu_table(new_phyloseq), max.level = 3)
#> Formal class 'otu_table' [package "phyloseq"] with 2 slots
#>

: int [1:130, 1:44] NA 6 NA 224 NA 169 NA 20 360 10 ...

..@ .Data
.. ..- attr(*, "dimnames")=List of 2
..@ taxa_are_rows: logi TRUE
..$ dim

: int [1:2] 130 44

..$ dimnames:List of 2

.. ..$ : chr [1:130] "Actinomycetaceae" "Aerococcus" "Aeromonas" "Akkermansia" ...

.. ..$ : chr [1:44] "sample-1" "sample-2" "sample-3" "sample-4" ...

#>

#>

#>

#>

#>

#>

subset <- subset_taxa(new_phyloseq, Phylum=="Firmicutes")
subset <- prune_taxa(names(sort(taxa_sums(subset),TRUE)[1:300]), subset)
(plot_heatmap(subset, ))

One option to estimate the alpha diversity is calculating the Chao1 index using plot_richness
of the phyloseq package

plot_richness(new_phyloseq, measures = c("Chao1"),
color = sample_data(new_phyloseq)$group)+
theme(axis.text.x = element_blank())

#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> i Please use tidy evaluation idioms with `aes()`.
#> i See also `vignette("ggplot2-in-packages")` for more information.
#> i The deprecated feature was likely used in the phyloseq package.

#>

Please report the issue at <https://github.com/joey711/phyloseq/issues>.

#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.

12

Clostridium colinum et rel.Outgrouping clostridium cluster XIVaBryantella formatexigens et rel.Clostridium sphenoides et rel.Eubacterium ventriosum et rel.Coprococcus eutactus et rel.Ruminococcus lactaris et rel.Papillibacter cinnamivorans et rel.Eubacterium rectale et rel.Lachnospira pectinoschiza et rel.Roseburia intestinalis et rel.Butyrivibrio crossotus et rel.Faecalibacterium prausnitzii et rel.Lachnobacillus bovis et rel.Eubacterium biforme et rel.Clostridium difficile et rel.Clostridium cellulosi et rel.Ruminococcus callidus et rel.Sporobacter termitidis et rel.Uncultured Clostridiales IIOscillospira guillermondii et rel.Ruminococcus bromii et rel.Subdoligranulum variable at rel.Eubacterium siraeum et rel.Anaerotruncus colihominis et rel.Clostridium leptum et rel.Peptococcus niger et rel.Clostridium orbiscindens et rel.Anaerovorax odorimutans et rel.Eubacterium limosum et rel.Eubacterium hallii et rel.AneurinibacillusClostridium stercorarium et rel.AnaerofustisDorea formicigenerans et rel.Ruminococcus gnavus et rel.Clostridium nexile et rel.Anaerostipes caccae et rel.Ruminococcus obeum et rel.Clostridium symbiosum et rel.Streptococcus intermedius et rel.Streptococcus mitis et rel.Streptococcus bovis et rel.sample−36sample−10sample−35sample−23sample−25sample−26sample−24sample−5sample−2sample−1sample−37sample−29sample−30sample−34sample−43sample−44sample−4sample−3sample−33sample−15sample−21sample−7sample−16sample−8sample−39sample−22sample−27sample−31sample−40sample−28sample−12sample−11sample−38sample−17sample−18sample−41sample−20sample−42sample−9sample−19sample−14sample−32sample−13sample−6SampleOTUAbundance1162564096An Introduction to zitools

3

Session Info

sessionInfo()

#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS

#>

#> Matrix products: default

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

#> BLAS:
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
#>

LAPACK version 3.12.0

#> locale:

#>

#>

#>

#>

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

#>
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)

#>

#> attached base packages:

#> [1] stats4

stats

graphics

grDevices utils

datasets

methods

#> [8] base

#>

#> other attached packages:

13

Chao1130140150160samplesAlpha Diversity MeasurecolourLGGPlaceboAn Introduction to zitools

#>

#>

#>

#>

lubridate_1.9.4
[1] microbiome_1.32.0
stringr_1.5.2
[3] forcats_1.0.1
purrr_1.1.0
[5] dplyr_1.1.4
tidyr_1.3.1
[7] readr_2.1.5
ggplot2_4.0.0
[9] tibble_3.3.0
#>
#> [11] tidyverse_2.0.0
DESeq2_1.50.0
#> [13] SummarizedExperiment_1.40.0 Biobase_2.70.0
#> [15] MatrixGenerics_1.22.0
#> [17] GenomicRanges_1.62.0
#> [19] IRanges_2.44.0
#> [21] BiocGenerics_0.56.0
#> [23] phyloseq_1.54.0
#> [25] BiocStyle_2.38.0
#>

matrixStats_1.5.0
Seqinfo_1.0.0
S4Vectors_0.48.0
generics_0.1.4
zitools_1.4.0

#>

#>

farver_2.1.2
fastmap_1.2.0
lifecycle_1.0.4
magrittr_2.0.4
tools_4.5.1
data.table_1.17.8
S4Arrays_1.10.0
RColorBrewer_1.1-3

#> loaded via a namespace (and not attached):
tidyselect_1.2.1
S7_0.2.0
timechange_0.3.0
survival_3.8-3
rlang_1.1.6
yaml_2.3.10
labeling_0.4.3

[1] ade4_1.7-23
[4] Biostrings_2.78.0
[7] digest_0.6.37
#>
#> [10] cluster_2.1.8.1
#> [13] compiler_4.5.1
#> [16] igraph_2.2.1
#> [19] knitr_1.50
#> [22] DelayedArray_0.36.0 plyr_1.8.9
#> [25] abind_1.4-8
#> [28] withr_3.0.2
#> [31] biomformat_1.38.0
#> [34] iterators_1.0.14
#> [37] dichromat_2.0-0.1
#> [40] vegan_2.7-2
#> [43] reshape2_1.4.4
#> [46] splines_4.5.1
#> [49] XVector_0.50.0
#> [52] jsonlite_2.0.0
#> [55] hms_1.1.4
#> [58] glue_1.8.0
#> [61] gtable_0.3.6
#> [64] rhdf5filters_1.22.0 pscl_1.5.9
#> [67] evaluate_1.0.5
#> [70] SparseArray_1.10.0 nlme_3.1-168
#> [73] mgcv_1.9-3

BiocParallel_1.44.0 Rtsne_0.17
grid_4.5.1
Rhdf5lib_1.32.0
MASS_7.3-65
cli_3.6.5
crayon_1.5.3
ape_5.8-1
parallel_4.5.1
vctrs_0.6.5
VGAM_1.1-13
locfit_1.5-9.12
codetools_0.2-20
pillar_1.11.1

multtest_2.66.0
scales_1.4.0
tinytex_0.57
rmarkdown_2.30
tzdb_0.5.0
rhdf5_2.54.0
BiocManager_1.30.26
Matrix_1.7-4
bookdown_0.45
foreach_1.5.2
stringi_1.8.7
htmltools_0.5.8.1
R6_2.6.1
Rcpp_1.1.0
permute_0.9-8
pkgconfig_2.0.3

lattice_0.22-7

xfun_0.53

14

