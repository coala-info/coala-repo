# Prediction of chromatin looping interactions with *sevenC*

Jonas Ibn-Salem1,2\* and Miguel Andrade-Navarro1,2

1Faculty of Biology, Johannes Gutenberg University of Mainz, 55128 Mainz, Germany
2Institute of Molecular Biology, 55128 Mainz, Germany

\*j.ibn-salem@uni-mainz.de

#### 30 October 2025

#### Abstract

Chromatin looping is an essential feature of eukaryotic genomes and
can bring regulatory sequences, such as enhancers or transcription factor
binding sites, in the close physical proximity of regulated target genes.
Here, we provide sevenC, an R package that uses protein binding signals from
ChIP-seq and sequence motif information to predict chromatin looping events.
Cross-linking of proteins that bind close to loop anchors result in ChIP-seq
signals at both anchor loci. These signals are used at CTCF motif pairs
together with their distance and orientation to each other to predict
whether they interact or not.
The resulting chromatin loops might be used to associate enhancers or
transcription factor binding sites (e.g., ChIP-seq peaks) to regulated
target genes.

#### Package

sevenC 1.30.0

# 1 Background and introduction

Gene expression is regulated by binding of transcription factors (TF) to genomic
DNA. However, many binding sites are in distal regulatory regions, such as
enhancers, that are hundreds of kilobases apart from genes. These regulatory
regions can physically interact with promoters of regulated genes by chromatin
looping interactions. These looping interaction can be measured genome-wide by
chromatin conformation capture techniques such as Hi-C or ChIA-PET (Rao et al. [2014](#ref-Rao2014); Tang et al. [2015](#ref-Tang2015)). Despite many exciting insights into the three-dimensional
organization of genomes, these experimental methods are not only elaborate and
expansive but also have limited resolution and are only available for a limited
number of cell types and conditions. In contrast, the binding sites of TFs can
be detected genome-wide by ChIP-seq experiment with high resolution and are
available for hundreds of TFs in many cell type and conditions. However,
classical analysis of ChIP-seq gives only the direct binding sites of targeted
TFs (ChIP-seq peaks) and it is not trivial to associate them to the regulated
gene without chromatin looping information. Therefore, we provide a
computational method to predict chromatin interactions from only genomic
sequence features and ChIP-seq data. The predicted looping interactions can be
used to associate TF binding sites (ChIP-seq peaks) or enhancers to regulated
genes and thereby improve functional downstream analysis on the level of genes.

In this vignette, we show how to use the R package *[sevenC](https://bioconductor.org/packages/3.22/sevenC)* to
predict chromatin looping interactions between CTCF motifs by using only
ChIP-seq data form a single experiment. Furthermore, we show how to train the
prediction model using custom data.

A more detailed explanation of the sevenC method together with prediction
performance analysis is available in the associated preprint (Ibn-Salem and Andrade-Navarro [2018](#ref-Ibn-Salem2018)).

# 2 Installation

To install the *sevenC* package, start R and enter:

```
# install.packages("BiocManager")
BiocManager::install("sevenC")
```

# 3 Predict chromatin looping interactions

## 3.1 Basic usage example

Here we show how to use the *[sevenC](https://bioconductor.org/packages/3.22/sevenC)* package with
default options to predict chromatin looping interactions among CTCF motif
locations on the human chromosome 22. As input, we only use CTCF motif locations
and a single bigWig file from a STAT1 ChIP-seq experiment in human GM12878 cells
(Dunham et al. [2012](#ref-Dunham2012)).

### 3.1.1 Get motif pairs

```
library(sevenC)

# load provided CTCF motifs in human genome
motifs <- motif.hg19.CTCF.chr22

# get motifs pairs
gi <- prepareCisPairs(motifs)
```

### 3.1.2 Add ChIP-seq data and compute correaltion

```
# use example ChIP-seq bigWig file
bigWigFile <- system.file("extdata", "GM12878_Stat1.chr22_1-30000000.bigWig",
  package = "sevenC")

# add ChIP-seq coverage and compute correaltion at motif pairs
gi <- addCor(gi, bigWigFile)
```

### 3.1.3 Predict loops

```
# predict looping interactions among all motif pairs
loops <- predLoops(gi)
```

## 3.2 More detailed usage example

Here we show in more detail each step of the loop prediction process. Again, we
want to predict chromatin looping interactions among CTCF motif locations on
chromosome 22 using a ChIP-seq for STAT1 in human GM12878 cells.

### 3.2.1 Prepare CTCF motif pairs

First, we need to prepare CTCF motif pairs as candidate anchors for chromatin
loop interactions. We use CTCF motif hits in human chromosome 22 as provide by
*[sevenC](https://bioconductor.org/packages/3.22/sevenC)* package. In general, any CTCF motifs can be
used if provided as `GRanges`.
To use the motif similarity score as a predictive feature, the motif data should
contain -log10 transformed p-values describing the significance of each motif
hit.
Here, we use CTCF motif sites as provided from the JASPAR genome browser tracks
(Khan et al. [2018](#ref-Khan2018)). The objedt `motif.hg19.CTCF.chr22` in the `r BiocStyle::Biocpkg("sevenC")` package contains CTCF motif locations on
chromosome 22. For more information on the motif data set, see
`?motif.hg19.CTCF`.

```
library(sevenC)

# load provided CTCF motifs
motifs <- motif.hg19.CTCF.chr22
```

The CTCF motif are represented as `GRanges` object from the `r BiocStyle::Biocpkg("GenomicRanges")` package. There are 917 CTCF
motif locations on chromosome 22. The genome assembly is hg19. one metadata
column named `score` shows motif match similarity as -log10 transformed
p-value.

### 3.2.2 Add ChIP-seq signals at motifs sites

To predict loops, we need the ChIP-seq signals at all motif sites. Therefore, we
read an example bigWig file with ChIP-seq signals.

An example file with only data on a subset of chromosome 22 is provided as part
of the *[sevenC](https://bioconductor.org/packages/3.22/sevenC)* package. The full file can be downloaded
from ENCODE (Dunham et al. [2012](#ref-Dunham2012))
[here](http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeSydhTfbs/wgEncodeSydhTfbsGm12878Stat1StdSig.bigWig).
The file contains for each position in the genome the log-fold-change of
ChIP-seq signals versus input control.

```
# use example ChIP-seq bigWig file
bigWigFile <- system.file("extdata", "GM12878_Stat1.chr22_1-30000000.bigWig",
  package = "sevenC")
```

We add ChIP-seq signals to all motifs in a window of 1000 bp using the function
`addCovToGR()` as follows.

```
# read ChIP-seq coverage
motifs <- addCovToGR(motifs, bigWigFile)
```

This adds a new metadata column to `motifs` holding a `NumericList` with
ChIP-seq signals for each motif location.

```
motifs$chip
```

```
## NumericList of length 917
## [["chr22"]] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ... 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
## [["chr22"]] 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 ... 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2
## [["chr22"]] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ... 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
## [["chr22"]] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ... 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
## [["chr22"]] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ... 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
## [["chr22"]] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ... 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
## [["chr22"]] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ... 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
## [["chr22"]] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ... 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
## [["chr22"]] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ... 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
## [["chr22"]] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ... 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
## ...
## <907 more elements>
```

Please note, on Windows systems, reading of bigWig files is currently not
supported. See `help(rtracklayer::import.bw)` for more information. Users on
Windows need to get ChIP-seq signals around motif sites as a `NumierList`
object. A `NumericList` `l` with ChIP-signal counts around each motif list can
be added by `motifs$chip <- l`.

### 3.2.3 Build pairs of motifs as candidate interactions

Now we build a dataset with all pairs of CTCF motif within 1 Mb and annotate it
with distance, motif orientation, and motif score.

```
gi <- prepareCisPairs(motifs, maxDist = 10^6)

gi
```

```
## StrictGInteractions object with 26076 interactions and 5 metadata columns:
##           seqnames1           ranges1     seqnames2           ranges2 |
##               <Rle>         <IRanges>         <Rle>         <IRanges> |
##       [1]     chr22 16186188-16186206 ---     chr22 16205307-16205325 |
##       [2]     chr22 16186188-16186206 ---     chr22 16238548-16238566 |
##       [3]     chr22 16186188-16186206 ---     chr22 16239188-16239206 |
##       [4]     chr22 16186188-16186206 ---     chr22 16239827-16239845 |
##       [5]     chr22 16186188-16186206 ---     chr22 16247246-16247264 |
##       ...       ...               ... ...       ...               ... .
##   [26072]     chr22 51110780-51110798 ---     chr22 51160028-51160046 |
##   [26073]     chr22 51110780-51110798 ---     chr22 51172084-51172102 |
##   [26074]     chr22 51130130-51130148 ---     chr22 51160028-51160046 |
##   [26075]     chr22 51130130-51130148 ---     chr22 51172084-51172102 |
##   [26076]     chr22 51160028-51160046 ---     chr22 51172084-51172102 |
##                dist strandOrientation   score_1   score_2 score_min
##           <integer>       <character> <numeric> <numeric> <numeric>
##       [1]     19119           forward      6.05      5.72      5.72
##       [2]     52360           forward      6.05      5.92      5.92
##       [3]     53000           forward      6.05      5.90      5.90
##       [4]     53639           forward      6.05      5.92      5.92
##       [5]     61058           forward      6.05      5.92      5.92
##       ...       ...               ...       ...       ...       ...
##   [26072]     49248           reverse      6.21      5.64      5.64
##   [26073]     61304           reverse      6.21      5.90      5.90
##   [26074]     29898           reverse      6.33      5.64      5.64
##   [26075]     41954           reverse      6.33      5.90      5.90
##   [26076]     12056           reverse      5.64      5.90      5.64
##   -------
##   regions: 917 ranges and 2 metadata columns
##   seqinfo: 93 sequences (1 circular) from hg19 genome
```

The function `prepareCisPairs()` returns a `GInteractoin` object from the `r BiocStyle::Biocpkg("InteractonSet")` package, representing all motif pairs
within the defined distance. The metadata columns of the `GInteractoin` object
hold the genomic distance between motifs in bp (`dist`), the orientation of
motifs (`strandOrientation`), and the motif score as -log10 of the motif hit
p-value (`score_1`, `score_2`, and `score_min`). Note, that the function
`prepareCisPairs()` is a wrapper for three individual functions that perform
each step separately and allow more options. First, `getCisPairs()` is used to
builds the `GInteractoin` object. Than `addStrandCombination()` adds the four
possible strand combinations of motifs pairs. Finally, `addMotifScore()` adds
the minimum motif score for each pair. These genomic features are used later as
predictive variables.

## 3.3 Compute ChIP-seq similarity at motif pairs

Now, we compute the similarity of ChIP-seq signals for all motif pairs as the
correlation of signals across positions around motif centers. Thereby, for two
motifs the corresponding ChIP-seq signal vectors that were added to `motifs`
before, are compared by Pearson correlation. A high correlation of ChIP-seq
signals at two motifs indicates a similar ChIP-seq coverage profile at the two
motifs. This, in turn, is characteristic for physical interaction via chromatin
looping, where ChIP signals are found on both sides with a similar distance to
motif centers (Ibn-Salem and Andrade-Navarro [2018](#ref-Ibn-Salem2018)). The correlation coefficient is added as
additional metadata column to `gi`.

```
# add ChIP-seq coverage and compute correaltion at motif pairs
gi <- addCovCor(gi)
```

## 3.4 Predict loops

Now we can predict chromatin loops integrating from the ChIP-seq correlation and
other genomic features in a logistic regression model. This is implemented in
the `predLoops()` function.

```
loops <- predLoops(gi)

loops
```

```
## StrictGInteractions object with 607 interactions and 7 metadata columns:
##         seqnames1           ranges1     seqnames2           ranges2 |      dist
##             <Rle>         <IRanges>         <Rle>         <IRanges> | <integer>
##     [1]     chr22 16186188-16186206 ---     chr22 16239188-16239206 |     53000
##     [2]     chr22 16205307-16205325 ---     chr22 16409786-16409804 |    204479
##     [3]     chr22 16238548-16238566 ---     chr22 16409786-16409804 |    171238
##     [4]     chr22 17398482-17398500 ---     chr22 17539262-17539280 |    140780
##     [5]     chr22 17398482-17398500 ---     chr22 17652850-17652868 |    254368
##     ...       ...               ... ...       ...               ... .       ...
##   [603]     chr22 26756542-26756560 ---     chr22 27041422-27041440 |    284880
##   [604]     chr22 26763796-26763814 ---     chr22 27041422-27041440 |    277626
##   [605]     chr22 28123236-28123254 ---     chr22 28221328-28221346 |     98092
##   [606]     chr22 29225543-29225561 ---     chr22 29436847-29436865 |    211304
##   [607]     chr22 29436847-29436865 ---     chr22 29641698-29641716 |    204851
##         strandOrientation   score_1   score_2 score_min  cor_chip      pred
##               <character> <numeric> <numeric> <numeric> <numeric> <numeric>
##     [1]           forward      6.05      5.90      5.90  0.885073  0.193089
##     [2]        convergent      5.72      5.79      5.72  0.415731  0.162644
##     [3]        convergent      5.92      5.79      5.79  0.675000  0.301512
##     [4]        convergent      6.48      6.89      6.48  0.790284  0.550519
##     [5]        convergent      6.48      8.49      6.48  0.221485  0.172598
##     ...               ...       ...       ...       ...       ...       ...
##   [603]           reverse      8.27      7.93      7.93  0.349559  0.225008
##   [604]           reverse      8.59      7.93      7.93  0.739380  0.423643
##   [605]           reverse      6.29      8.16      6.29  0.601548  0.188785
##   [606]           reverse      6.73      6.33      6.33  0.928965  0.245978
##   [607]           reverse      6.33      7.27      6.33  0.909619  0.242532
##   -------
##   regions: 917 ranges and 2 metadata columns
##   seqinfo: 93 sequences (1 circular) from hg19 genome
```

The `predLoops()` function returns a subset of motif pairs that are predicted to
interact. The interactions are annotated with ChIP-seq correlation in column
`cor_chip`. The column `pred` holds the predicted interaction probability
according to the logistic regression model.

Note, that without specifying further options, the function `predLoops()` uses a
default model that was optimized for several transcription factor ChIP-seq
datasets by using experimental chromatin loops from Hi-C and ChIA-PET for
validations (Ibn-Salem and Andrade-Navarro [2018](#ref-Ibn-Salem2018)). However, users can specify custom features using
the `formula` argument and provide custom parameters using the `betas` argument.
Furthermore, per default the `predLoops()` function report only looping
interactions that reach a minimal prediction score threshold. The fraction of
reported loops can be modified using the `cutoff` argument.

# 4 Downstream analysis with predicted chromatin loops

## 4.1 Linking sets of regions

Predicted loops are represented as `GInteraction` and can, therefore, be used
easily for downstream analysis with functions from the `r BiocStyle::Biocpkg("InteractonSet")` package. For example, linking two sets of
regions (like ChIP-seq peaks and genes) can be done using the `linkOverlaps`
function. See the
[vignette](http://bioconductor.org/packages/release/bioc/vignettes/InteractionSet/inst/doc/interactions.html)
from the *[InteractonSet](https://bioconductor.org/packages/3.22/InteractonSet)* package for more details and
examples on working with `GInteraction` objects.

## 4.2 Write predicted loops to an output file

Since looping interactions are stored as `GInteraction` objects, they can be
exported as
[BEDPE](http://bedtools.readthedocs.io/en/latest/content/general-usage.html#bedpe-format)
files using functions from *[GenomicInteractions](https://bioconductor.org/packages/3.22/GenomicInteractions)*
package. These files can be used for visualization in genome browsers or the
[Juicebox](https://www.aidenlab.org/juicebox/) tool.

```
library(GenomicInteractions)

# export to output file
export.bedpe(loops, "loop_interactions.bedpe", score = "pred")
```

# 5 Train prediction model using custom data

Here, we show how to use *[sevenC](https://bioconductor.org/packages/3.22/sevenC)* to build and train a
logistic regression model for loop prediction.

## 5.1 Prepare motif pairs and add ChIP-seq data

First, we need to build the pairs of motifs as candidates and add the ChIP-seq
data as shown above.

```
# load provided CTCF motifs
motifs <- motif.hg19.CTCF.chr22

# use example ChIP-seq coverage file
bigWigFile <- system.file("extdata", "GM12878_Stat1.chr22_1-30000000.bigWig",
  package = "sevenC")

# add ChIP-seq coverage
motifs <- addCovToGR(motifs, bigWigFile)

# build motif pairs
gi <- prepareCisPairs(motifs, maxDist = 10^6)

# add correaltion of ChIP-signal
gi <- addCovCor(gi)
```

## 5.2 Train predictor with known loops

We need to label true looping interactions by using experimental data of
chromatin interactions. Here, we use loops from high-resolution Hi-C experiments
in human GM12878 cells (Rao et al. [2014](#ref-Rao2014)). An example file with loops on chromosome 22
is provided with the *[sevenC](https://bioconductor.org/packages/3.22/sevenC)* package and the function
`parseLoopsRao()` reads loops in the format provided by Rao et al. and returns a
`GInteraction` object.

```
# parse known loops
knownLoopFile <- system.file("extdata",
  "GM12878_HiCCUPS.chr22_1-30000000.loop.txt", package = "sevenC")

knownLoops <- parseLoopsRao(knownLoopFile)
```

We can add a new metadata column to the motif pairs `gi`, indicating whether the
pair is interacting in the experimental data using the function
`addInteractionSupport()`.

```
# add known loops
gi <- addInteractionSupport(gi, knownLoops)
```

The experimental support is added as factor with levels `"Loop"` and `"No loop"`
as metadata column named `loop`. The column name can be modified using the
`colname` argument.

## 5.3 Train logistic regression model

We can use the R function `glm()` to fit a logistic regression model in which
the `loop` column is the dependent variable and the ChIP-seq correlation,
distance, and strand orientation are the predictors.

```
fit <- glm(
  formula = loop ~ cor_chip + dist + strandOrientation,
  data = mcols(gi),
  family = binomial()
  )
```

## 5.4 Predict loops with a custom model

Now, we can use this model to add predicted looping probabilities.

```
# add predict loops
gi <- predLoops(
  gi,
  formula = loop ~ cor_chip + dist + strandOrientation,
  betas = coef(fit),
  cutoff = NULL
)
```

Here, we have to use the same formula as argument as in the model fitting step
above. The `betas` argument takes the coefficients of the logistic regression
model. Finally, the argument `cutoff = NULL` ensures that no filtering is done
and all input candidates are reported. The prediction score is added as a new
metadata column to `gi`.

```
gi
```

```
## StrictGInteractions object with 26076 interactions and 8 metadata columns:
##           seqnames1           ranges1     seqnames2           ranges2 |
##               <Rle>         <IRanges>         <Rle>         <IRanges> |
##       [1]     chr22 16186188-16186206 ---     chr22 16205307-16205325 |
##       [2]     chr22 16186188-16186206 ---     chr22 16238548-16238566 |
##       [3]     chr22 16186188-16186206 ---     chr22 16239188-16239206 |
##       [4]     chr22 16186188-16186206 ---     chr22 16239827-16239845 |
##       [5]     chr22 16186188-16186206 ---     chr22 16247246-16247264 |
##       ...       ...               ... ...       ...               ... .
##   [26072]     chr22 51110780-51110798 ---     chr22 51160028-51160046 |
##   [26073]     chr22 51110780-51110798 ---     chr22 51172084-51172102 |
##   [26074]     chr22 51130130-51130148 ---     chr22 51160028-51160046 |
##   [26075]     chr22 51130130-51130148 ---     chr22 51172084-51172102 |
##   [26076]     chr22 51160028-51160046 ---     chr22 51172084-51172102 |
##                dist strandOrientation   score_1   score_2 score_min  cor_chip
##           <integer>       <character> <numeric> <numeric> <numeric> <numeric>
##       [1]     19119           forward      6.05      5.72      5.72  0.339540
##       [2]     52360           forward      6.05      5.92      5.92 -0.104692
##       [3]     53000           forward      6.05      5.90      5.90  0.885073
##       [4]     53639           forward      6.05      5.92      5.92 -0.170961
##       [5]     61058           forward      6.05      5.92      5.92 -0.104692
##       ...       ...               ...       ...       ...       ...       ...
##   [26072]     49248           reverse      6.21      5.64      5.64        NA
##   [26073]     61304           reverse      6.21      5.90      5.90        NA
##   [26074]     29898           reverse      6.33      5.64      5.64        NA
##   [26075]     41954           reverse      6.33      5.90      5.90        NA
##   [26076]     12056           reverse      5.64      5.90      5.64        NA
##               loop        pred
##           <factor>   <numeric>
##       [1]  No loop 0.002077368
##       [2]  No loop 0.000422511
##       [3]  No loop 0.012289515
##       [4]  No loop 0.000335909
##       [5]  No loop 0.000414237
##       ...      ...         ...
##   [26072]  No loop          NA
##   [26073]  No loop          NA
##   [26074]  No loop          NA
##   [26075]  No loop          NA
##   [26076]  No loop          NA
##   -------
##   regions: 917 ranges and 2 metadata columns
##   seqinfo: 93 sequences (1 circular) from hg19 genome
```

As a very simple validation, we can now compare the prediction score for looping
and non-looping motif pairs using a boxplot.

```
boxplot(gi$pred ~ gi$loop,
        ylab = "Predicted interaction probability")
```

![](data:image/png;base64...)

The plot shows higher prediction scores for truly looping motif pairs. However,
this is an insufficient evaluation of prediction performance, since the
prediction score is evaluated on the same data as it was trained. A more
detailed evaluation of prediction performance using cross-validation and
different cell types is described in the 7C paper (Ibn-Salem and Andrade-Navarro [2018](#ref-Ibn-Salem2018)).

## 5.5 Session info

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
##  [1] GenomicInteractions_1.44.0  sevenC_1.30.0
##  [3] InteractionSet_1.38.0       SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [7] matrixStats_1.5.0           GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       rstudioapi_0.17.1        jsonlite_2.0.0
##   [4] magrittr_2.0.4           magick_2.9.0             GenomicFeatures_1.62.0
##   [7] farver_2.1.2             rmarkdown_2.30           BiocIO_1.20.0
##  [10] vctrs_0.6.5              memoise_2.0.1            Rsamtools_2.26.0
##  [13] RCurl_1.98-1.17          base64enc_0.1-3          tinytex_0.57
##  [16] htmltools_0.5.8.1        S4Arrays_1.10.0          progress_1.2.3
##  [19] curl_7.0.0               SparseArray_1.10.0       Formula_1.2-5
##  [22] sass_0.4.10              bslib_0.9.0              htmlwidgets_1.6.4
##  [25] Gviz_1.54.0              httr2_1.2.1              cachem_1.1.0
##  [28] GenomicAlignments_1.46.0 igraph_2.2.1             lifecycle_1.0.4
##  [31] pkgconfig_2.0.3          Matrix_1.7-4             R6_2.6.1
##  [34] fastmap_1.2.0            digest_0.6.37            colorspace_2.1-2
##  [37] AnnotationDbi_1.72.0     Hmisc_5.2-4              RSQLite_2.4.3
##  [40] filelock_1.0.3           httr_1.4.7               abind_1.4-8
##  [43] compiler_4.5.1           bit64_4.6.0-1            htmlTable_2.4.3
##  [46] S7_0.2.0                 backports_1.5.0          BiocParallel_1.44.0
##  [49] DBI_1.2.3                biomaRt_2.66.0           rappdirs_0.3.3
##  [52] DelayedArray_0.36.0      rjson_0.2.23             tools_4.5.1
##  [55] foreign_0.8-90           nnet_7.3-20              glue_1.8.0
##  [58] restfulr_0.0.16          grid_4.5.1               checkmate_2.3.3
##  [61] cluster_2.1.8.1          gtable_0.3.6             BSgenome_1.78.0
##  [64] tzdb_0.5.0               ensembldb_2.34.0         data.table_1.17.8
##  [67] hms_1.1.4                XVector_0.50.0           pillar_1.11.1
##  [70] stringr_1.5.2            vroom_1.6.6              dplyr_1.1.4
##  [73] BiocFileCache_3.0.0      lattice_0.22-7           rtracklayer_1.70.0
##  [76] bit_4.6.0                deldir_2.0-4             biovizBase_1.58.0
##  [79] tidyselect_1.2.1         Biostrings_2.78.0        knitr_1.50
##  [82] gridExtra_2.3            bookdown_0.45            ProtGenerics_1.42.0
##  [85] xfun_0.53                stringi_1.8.7            UCSC.utils_1.6.0
##  [88] lazyeval_0.2.2           yaml_2.3.10              boot_1.3-32
##  [91] evaluate_1.0.5           codetools_0.2-20         cigarillo_1.0.0
##  [94] interp_1.1-6             archive_1.1.12           tibble_3.3.0
##  [97] BiocManager_1.30.26      cli_3.6.5                rpart_4.1.24
## [100] jquerylib_0.1.4          dichromat_2.0-0.1        Rcpp_1.1.0
## [103] GenomeInfoDb_1.46.0      dbplyr_2.5.1             png_0.1-8
## [106] XML_3.99-0.19            parallel_4.5.1           ggplot2_4.0.0
## [109] readr_2.1.5              blob_1.2.4               prettyunits_1.2.0
## [112] latticeExtra_0.6-31      jpeg_0.1-11              AnnotationFilter_1.34.0
## [115] bitops_1.0-9             VariantAnnotation_1.56.0 scales_1.4.0
## [118] purrr_1.1.0              crayon_1.5.3             rlang_1.1.6
## [121] KEGGREST_1.50.0
```

# References

Dunham, Ian, Anshul Kundaje, Shelley F Aldred, Patrick J Collins, Carrie a Davis, Francis Doyle, Charles B Epstein, et al. 2012. “An integrated encyclopedia of DNA elements in the human genome.” *Nature* 489 (7414): 57–74. <https://doi.org/10.1038/nature11247>.

Ibn-Salem, Jonas, and Miguel A. Andrade-Navarro. 2018. “Computational Chromosome Conformation Capture by Correlation of ChIP-seq at CTCF motifs.” *bioRxiv*, February, 257584. <https://doi.org/10.1101/257584>.

Khan, Aziz, Oriol Fornes, Arnaud Stigliani, Marius Gheorghe, Jaime A Castro-Mondragon, Robin van der Lee, Adrien Bessy, et al. 2018. “JASPAR 2018: update of the open-access database of transcription factor binding profiles and its web framework.” *Nucleic Acids Research* 46 (D1): D260–D266. <https://doi.org/10.1093/nar/gkx1126>.

Rao, Suhas S P, Miriam H Huntley, Neva C Durand, Elena K Stamenova, Ivan D Bochkov, James T Robinson, Adrian L Sanborn, et al. 2014. “A 3D map of the human genome at kilobase resolution reveals principles of chromatin looping.” *Cell* 159 (7): 1665–80. <https://doi.org/10.1016/j.cell.2014.11.021>.

Tang, Zhonghui, Oscar Junhong Luo, Xingwang Li, Meizhen Zheng, Jacqueline Jufen Zhu, Przemyslaw Szalaj, Pawel Trzaskoma, et al. 2015. “CTCF-Mediated Human 3D Genome Architecture Reveals Chromatin Topology for Transcription.” *Cell*, 1–17. <https://doi.org/10.1016/j.cell.2015.11.024>.