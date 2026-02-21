# Swish: differential expression accounting for inferential uncertainty

#### 10/29/2025

# The Swish method

The *Swish* method for differential expression analysis of bulk or single-cell RNA-seq data using inferential replicate counts is described in the following reference: Zhu et al. (2019) [doi: 10.1093/nar/gkz622](https://doi.org/10.1093/nar/gkz622).

We note that *Swish* extends and builds on another method, *SAMseq* (Li and Tibshirani 2011), implemented in the *samr* package, by taking into account inferential uncertainty, and allowing to control for batch effects and matched samples. Additionally, *Swish* has methods for testing changes in effect size across secondary covariates, which we refer to as “interactions”. *Swish* also implements correlation tests as in the original *SAMseq* package. `swish` calls functions from the *qvalue* (Storey and Tibshirani 2003) or *samr* package for calculation of local FDR and q-value. This vignette gives an example of differential analysis of matched samples, and an interaction test for matched samples, to see if a condition effect changes in magnitude across two groups of samples.

# Quick start

The following lines of code will perform a basic transcript-level `swish` two group analysis of bulk RNA-seq. For more details, read on. There is a special section below for two-group analysis of [scRNA-seq](#alevin_scrna-seq).

```
# 'coldata.csv': sample information table
coldata <- read.csv("coldata.csv")
library(tximeta)
y <- tximeta(coldata) # reads in counts and inf reps
library(fishpond)
y <- scaleInfReps(y) # scales counts
y <- labelKeep(y) # labels features to keep
set.seed(1)
y <- swish(y, x="condition") # simplest Swish case
```

**Note:** Inferential replicates, either from Gibbs sampling or bootstrapping of reads, are required for the *swish* method. When running Salmon, you can set `--numGibbsSamples 30` to generate Gibbs samples, or `--numBootstraps 30` to generate bootstrap samples (we typically recommend 20-30 inferential replicates).

The results can be found in `mcols(y)`. For example, one can calculate the number of genes passing a 5% FDR threshold:

```
table(mcols(y)$qvalue < .05)
```

One can at any point remove the genes that didn’t pass the expression filter with the following line of code (can be run before or after `swish`). These genes are ignored by `swish`, and so will have `NA` in the results columns in `mcols(y)`.

```
y <- y[mcols(y)$keep,]
```

A gene-level analysis looks identical to a transcript-level analysis, only the input data changes. Examples follow.

Lastly, what is the structure of the output of `tximeta` (Love et al. 2020), which is used in `swish`? See the section below, *Structure of tximeta output / swish input*.

## Macrophage stimulation experiment

We begin the *fishpond* vignette by loading data from a Bioconductor Experiment Data package, *macrophage*. The package contains RNA-seq quantification from 24 RNA-seq samples, which are a subset of the RNA-seq samples generated and analyzed by Alasoo et al. (2018) - [doi: 10.1038/s41588-018-0046-7](https://doi.org/10.1038/s41588-018-0046-7).

The experiment involved treatment of macrophage cell lines from a number of human donors with IFN gamma, *Salmonella* infection, or both treatments combined. In the beginning of this vignette, we will focus on comparing the IFN gamma stimulated cell lines with the control cell lines, accounting for the paired nature of the data (cells from the same donor). Later in the vignette we will analyze differences in the *Salmonella* infection response by IFN gamma treatment status – whether the cells are primed for immune response.

We load the package, and point to the `extdata` directory. For a typical analysis, the user would just point `dir` to the location on the machine or cluster where the transcript quantifications are stored (e.g. the `quant.sf` files).

```
library(macrophage)
dir <- system.file("extdata", package="macrophage")
```

The data was quantified using *Salmon* (Patro et al. 2017) 0.12.0 against the Gencode v29 human reference transcripts (Frankish, GENCODE-consoritum, and Flicek 2018). For more details and all code used for quantification, refer to the [macrophage](https://bioconductor.org/packages/macrophage) package vignette.

Importantly, `--numGibbsSamples 20` was used to generate 20 inferential replicates with *Salmon*’s Gibbs sampling procedure. We also recommend to use `--gcBias` when running *Salmon* to protect against common sample-specific biases present in RNA-seq data.

# Data import

## Read in the column data from CSV

We start by reading in a CSV with the *column data*, that is, information about the samples, which are represented as columns of the *SummarizedExperiment* object we will construct containing the counts of reads per gene or transcript.

```
coldata <- read.csv(file.path(dir, "coldata.csv"))
head(coldata)
```

```
##            names sample_id line_id replicate condition_name macrophage_harvest
## 1 SAMEA103885102    diku_A  diku_1         1          naive          11/6/2015
## 2 SAMEA103885347    diku_B  diku_1         1           IFNg          11/6/2015
## 3 SAMEA103885043    diku_C  diku_1         1         SL1344          11/6/2015
## 4 SAMEA103885392    diku_D  diku_1         1    IFNg_SL1344          11/6/2015
## 5 SAMEA103885182    eiwy_A  eiwy_1         1          naive         11/25/2015
## 6 SAMEA103885136    eiwy_B  eiwy_1         1           IFNg         11/25/2015
##   salmonella_date ng_ul_mean rna_extraction rna_submit        library_pool
## 1      11/13/2015   293.9625     11/30/2015  12/9/2015 3226_RNAauto-091215
## 2      11/13/2015   293.9625     11/30/2015  12/9/2015 3226_RNAauto-091215
## 3      11/13/2015   293.9625     11/30/2015  12/9/2015 3226_RNAauto-091215
## 4      11/13/2015   293.9625     11/30/2015  12/9/2015 3226_RNAauto-091215
## 5       12/2/2015   193.5450      12/3/2015  12/9/2015 3226_RNAauto-091215
## 6       12/2/2015   193.5450      12/3/2015  12/9/2015 3226_RNAauto-091215
##   chemistry rna_auto
## 1   V4_auto        1
## 2   V4_auto        1
## 3   V4_auto        1
## 4   V4_auto        1
## 5   V4_auto        1
## 6   V4_auto        1
```

We will subset to certain columns of interest, and re-name them for later.

```
coldata <- coldata[,c(1,2,3,5)]
names(coldata) <- c("names","id","line","condition")
```

## Add a column pointing to your files

`coldata` needs to have a column `files` which specifies the path to the quantification files. In this case, we’ve gzipped the quantification files, so we point to the `quant.sf.gz` file. We make sure that all the files exist in the location we specified.

```
coldata$files <- file.path(dir, "quants", coldata$names, "quant.sf.gz")
all(file.exists(coldata$files))
```

```
## [1] TRUE
```

## Read in quants with tximeta

We will read in quantification data for some of the samples. First we load the *SummarizedExperiment* package. We will store out data and the output of the statistical method in a *SummarizedExperiment* object. We use the *tximeta* (Love et al. 2020) package to read in the data:

```
suppressPackageStartupMessages(library(SummarizedExperiment))
```

The *macrophage* package contains a number of samples under different conditions. In this vignette, we will demonstrate a two group comparison, and so we first subset our `coldata` to the `"naive"` and `"IFNg"` groups. Log fold changes will be made comparing `IFNg` to `naive` (the reference level).

```
coldata <- coldata[coldata$condition %in% c("naive","IFNg"),]
coldata$condition <- factor(coldata$condition,
                            levels=c("naive","IFNg"))
```

We load in the quantification data with `tximeta`:

```
library(tximeta)
se <- tximeta(coldata)
```

We can see that all the assays have been loaded:

```
assayNames(se)
```

```
##  [1] "counts"    "abundance" "length"    "infRep1"   "infRep2"   "infRep3"
##  [7] "infRep4"   "infRep5"   "infRep6"   "infRep7"   "infRep8"   "infRep9"
## [13] "infRep10"  "infRep11"  "infRep12"  "infRep13"  "infRep14"  "infRep15"
## [19] "infRep16"  "infRep17"  "infRep18"  "infRep19"  "infRep20"
```

`tximeta` loads transcript-level data, although it can later be summarized to the gene levels:

```
head(rownames(se))
```

```
## [1] "ENST00000456328.2" "ENST00000450305.2" "ENST00000488147.1"
## [4] "ENST00000619216.1" "ENST00000473358.1" "ENST00000469289.1"
```

We will rename our *SummarizedExperiment* `y` for the statistical analysis. For speed of the vignette, we subset to the transcripts on chromosome 4.

```
y <- se
y <- y[seqnames(y) == "chr4",]
```

**Note on factor levels**: The `swish` function compares expression level across factors such that log2 fold changes are reported as the non-reference level over the reference level. By default, R will choose a *reference level* for factors based on alphabetical order, unless `levels` are explicitly set. It is recommended to set the factors levels, as in the above code chunk, with the reference level coming first in the character vector, so that log2 fold changes correspond to the comparison of interest.

# Differential transcript expression

## Running Swish at the transcript level

Running `swish` has three steps: scaling the inferential replicates, labeling the rows with sufficient counts for running differential expression, and then calculating the statistics. As `swish` makes use of pseudo-random number generation in breaking ties and in calculating permutations, to obtain identical results, one needs to set a random seed before running `swish()`, as we do below.

```
library(fishpond)
y <- scaleInfReps(y)
y <- labelKeep(y)
y <- y[mcols(y)$keep,]
set.seed(1)
y <- swish(y, x="condition", pair="line")
```

**Note:** the simple paired test is the slowest of all the other designs provided for Swish (see [further details](#further-details)), because it requires recomputing the signed ranks at each permutation. Other designs avoid recomputing ranks per permutation, or don’t use ranks for the test statistic. You can set `fast=1` for simple paired designs, which implements a one-sample z-score as the test statistic, and permutations to provide p-values and q-values. These permutations are much faster than those that use the signed rank test, for example with one core, the signed rank test is 12x slower than the one-sample z-score method when run across all transcripts, and they nevertheless detect nearly the same sets.

```
y_fast <- swish(y, x="condition", pair="line", fast=1)
table(original=mcols(y)$qvalue < .1,
      fast=mcols(y_fast)$qvalue < .1)
```

```
##         fast
## original FALSE TRUE
##    FALSE  1615   40
##    TRUE     41  553
```

The default number of permutations for computing p-values is `nperms=100`. However, for paired datasets as this one, you may have fewer maximum permutations. In this case, there are 64 possible ways to switch the condition labels for six pairs of samples. We can set the `nperms` manually to 64, or if we had just used the default value, `swish` would set `nperms` to the maximum value possible and notify the user that it had done so.

A note about `labelKeep`: by default we keep features with `minN=3` samples with a minimal count of 10. For scRNA-seq data with de-duplicated UMI counts, we recommend to lower the count, e.g. a count of 3, across a higher number of `minN` cells, depending on the number of cells being compared. You can also set `x="condition"` when running `labelKeep` which will use the condition variable to set `minN`.

The results are stored in `mcols(y)`. We will show below how to pull out the top up- and down-regulated transcripts.

We can see how many transcripts are in a 5% FDR set:

```
table(mcols(y)$qvalue < .05)
```

```
##
## FALSE  TRUE
##  1845   404
```

A number of features may have the same `pvalue` and `qvalue` due to the procedure for assessing significance. We can additionally rank features by their effect size, to break ties in the `qvalue`:

```
most.sig <- with(mcols(y),
                 order(qvalue, -abs(log2FC)))
mcols(y)[head(most.sig),c("log2FC","qvalue")]
```

```
## DataFrame with 6 rows and 2 columns
##                      log2FC     qvalue
##                   <numeric>  <numeric>
## ENST00000264888.5  10.69374 7.2338e-05
## ENST00000306602.2   9.34219 7.2338e-05
## ENST00000306621.7   9.00874 7.2338e-05
## ENST00000435136.6   8.11050 7.2338e-05
## ENST00000307128.5  -6.96429 7.2338e-05
## ENST00000382114.8  -5.92382 7.2338e-05
```

The top 6 genes by `qvalue` and effect size in this case all have positive LFC, although we have ranked by the largest in absolute value, so large negative values will also appear in this list.

## Plotting results

We can check the distribution of p-values. This looks as expected for a comparison where we expect many transcripts will be affected by the treatment (IFNg stimulation of macrophage cells). There is a flat component and then an enrichment of transcripts with p-values near 0.

```
hist(mcols(y)$pvalue, col="grey")
```

![](data:image/png;base64...)

Of the transcripts in this set, which have the most extreme log2 fold change? Note that often many transcripts will share the same q-value, so it’s valuable to look at the log2 fold change as well (see further note below on q-value computation). The log2 fold change computed by `swish` is the median over inferential replicates, and uses a pseudo-count of 5 on the scaled counts, to stabilize the variance on the fold change from division by small counts. See the note above for interpretation of log2 fold changes with respect to the levels of `x`.

With the following code chunk, we construct two vectors that give the significant genes with the lowest (most negative) and highest (most positive) log2 fold changes.

```
with(mcols(y),
     table(sig=qvalue < .05, sign.lfc=sign(log2FC))
     )
```

```
##        sign.lfc
## sig      -1   1
##   FALSE 998 847
##   TRUE  184 220
```

```
sig <- mcols(y)$qvalue < .05
lo <- order(mcols(y)$log2FC * sig)
hi <- order(-mcols(y)$log2FC * sig)
```

Here we print a small table with just the calculated statistics for the large positive log fold change transcripts (up-regulation):

```
top_up <- mcols(y)[head(hi),]
names(top_up)
```

```
##  [1] "tx_id"     "gene_id"   "tx_name"   "log10mean" "keep"      "stat"
##  [7] "log2FC"    "pvalue"    "locfdr"    "qvalue"
```

```
cols <- c("log10mean","log2FC","pvalue","qvalue")
print(as.data.frame(top_up)[,cols], digits=3)
```

```
##                   log10mean log2FC   pvalue   qvalue
## ENST00000264888.5      5.34  10.69 6.95e-06 7.23e-05
## ENST00000306602.2      5.08   9.34 6.95e-06 7.23e-05
## ENST00000306621.7      4.26   9.01 6.95e-06 7.23e-05
## ENST00000435136.6      2.96   8.11 6.95e-06 7.23e-05
## ENST00000502843.5      2.88   5.55 6.95e-06 7.23e-05
## ENST00000500655.2      3.18   5.19 6.95e-06 7.23e-05
```

Likewise for the largest negative log fold change transcripts (down-regulation):

```
top_down <- mcols(y)[head(lo),]
print(as.data.frame(top_down)[,cols], digits=3)
```

```
##                   log10mean log2FC   pvalue   qvalue
## ENST00000307128.5      3.10  -6.96 6.95e-06 7.23e-05
## ENST00000382114.8      2.97  -5.92 6.95e-06 7.23e-05
## ENST00000381753.8      2.08  -3.49 4.04e-03 3.34e-02
## ENST00000237612.7      2.79  -3.35 6.95e-06 7.23e-05
## ENST00000407365.5      1.67  -3.00 5.70e-03 3.86e-02
## ENST00000395002.6      2.67  -2.70 6.95e-06 7.23e-05
```

We can plot the scaled counts for the inferential replicates, and also group the samples by a covariate, in this case the cell line. The analysis was paired, so the statistic assessed if the change within pairs was consistent. Here we plot the 100th top up-regulated transcript. `plotInfReps` also has functionality for plotting uncertainty in single cell data, as will be covered in a later section.

```
plotInfReps(y, idx=hi[100], x="condition", cov="line")
```

![](data:image/png;base64...)

We can make an [MA plot](https://en.wikipedia.org/wiki/MA_plot), where the transcripts in our FDR set are colored:

```
plotMASwish(y, alpha=.05)
```

![](data:image/png;base64...)

Using the `addIds` function from *tximeta*, we can easily add gene symbols. By specifying `gene=TRUE`, this will use the gene ID to match to gene symbols for all of the transcripts.

```
library(org.Hs.eg.db)
y <- addIds(y, "SYMBOL", gene=TRUE)
```

We can then add gene symbols to our MA plot:

```
plotMASwish(y, alpha=.05, xlim=c(.5,5.5))
with(
  subset(mcols(y), qvalue < .05 & abs(log2FC) > 4),
     text(log10mean, log2FC, SYMBOL,
          col="blue", pos=4, cex=.7)
)
```

![](data:image/png;base64...)

# Differential gene expression

## Running Swish at the gene level

We can also run swish at the gene level. First we summarize all of the data to the gene level, using the `summarizeToGene` function from *tximeta*. Again, we rename the object for statistical analysis, and then we subset to the genes on chromosome 4 for the demonstration.

```
gse <- summarizeToGene(se)
gy <- gse
gy <- gy[seqnames(gy) == "chr4",]
```

Next we can run the same steps as before. Again we set a random seed in order to be able to reproduce exact results in the future:

```
gy <- scaleInfReps(gy)
gy <- labelKeep(gy)
gy <- gy[mcols(gy)$keep,]
set.seed(1)
gy <- swish(gy, x="condition", pair="line")
```

As before, the number of genes in a 1% FDR set:

```
table(mcols(gy)$qvalue < .05)
```

```
##
## FALSE  TRUE
##   403   226
```

## Plotting gene results

The histogram of p-values:

```
hist(mcols(y)$pvalue, col="grey")
```

![](data:image/png;base64...)

As before, finding the genes with the most extreme log2 fold change:

```
with(mcols(gy),
     table(sig=qvalue < .05, sign.lfc=sign(log2FC))
     )
```

```
##        sign.lfc
## sig      -1   1
##   FALSE 251 152
##   TRUE  110 116
```

```
sig <- mcols(gy)$qvalue < .05
glo <- order(mcols(gy)$log2FC * sig)
ghi <- order(-mcols(gy)$log2FC * sig)
```

```
gtop_up <- mcols(gy)[head(ghi),]
print(as.data.frame(gtop_up)[,cols], digits=3)
```

```
##                    log10mean log2FC   pvalue   qvalue
## ENSG00000138755.5       5.36  10.73 2.48e-05 9.89e-05
## ENSG00000169245.5       5.10   9.37 2.48e-05 9.89e-05
## ENSG00000169248.12      4.28   8.95 2.48e-05 9.89e-05
## ENSG00000004468.12      3.61   5.55 2.48e-05 9.89e-05
## ENSG00000145365.10      3.87   5.16 2.48e-05 9.89e-05
## ENSG00000171509.15      2.42   4.68 2.48e-05 9.89e-05
```

```
gtop_down <- mcols(gy)[head(glo),]
print(as.data.frame(gtop_down)[,cols], digits=3)
```

```
##                    log10mean log2FC   pvalue   qvalue
## ENSG00000172399.5       3.12  -6.96 2.48e-05 9.89e-05
## ENSG00000153012.11      3.00  -5.87 2.48e-05 9.89e-05
## ENSG00000118777.11      2.80  -3.19 2.48e-05 9.89e-05
## ENSG00000151725.11      2.83  -2.48 2.48e-05 9.89e-05
## ENSG00000248187.1       2.27  -2.41 2.48e-05 9.89e-05
## ENSG00000145390.11      3.59  -2.36 2.48e-05 9.89e-05
```

We can plot a particular one of these genes:

```
plotInfReps(gy, idx=ghi[100], x="condition", cov="line")
```

![](data:image/png;base64...)

As expected, the highly up-regulated genes are involved in immune response. Many genes encoding guanylate-binding proteins (GBP) are up-regulated, and these proteins are induced by interferon, produced in response to infection by pathogenic microbes.

We can make an MA plot, where the genes in our FDR set are colored:

```
plotMASwish(gy, alpha=.05)
```

![](data:image/png;base64...)

Again, using the `addIds` function from *tximeta*, we can easily add gene symbols to our gene-level expression analysis:

```
library(org.Hs.eg.db)
gy <- addIds(gy, "SYMBOL", gene=TRUE)
```

We can then add gene symbols to our MA plot:

```
plotMASwish(gy, alpha=.05, xlim=c(.5,5.5))
with(
  subset(mcols(gy), qvalue < .05 & abs(log2FC) > 3),
     text(log10mean, log2FC, SYMBOL,
          col="blue", pos=4, cex=.7)
)
```

![](data:image/png;base64...)

# Differential transcript usage

We have added a new function `isoformProportions` which can be run after `scaleInfReps` (and optionally after removing genes via `labelKeep` and subsetting the SummarizedExperiment). This function, `isoformProportions` will create a new assay `isoProp` from the scaledTPM counts, containing isoform proportions per gene. The same procedure will also be applied to all the inferential replicates. Note that after `isoformProportions` the transcripts from single isoform genes will be removed, and the transcripts will be re-ordered by gene (alphabetically by gene).

Following this function, running `swish` will be equivalent to a test of differential transcript usage, taking account of the uncertainty in transcript abundances, as it will look for transcripts where the isoform proportions change across condition.

```
# run on the transcript-level dataset
iso <- isoformProportions(y)
iso <- swish(iso, x="condition", pair="line")
```

# Interaction designs

We also provide in `swish` methods for testing if a condition effect varies *across a secondary covariate*, using matched samples for condition, or un-matched samples, which we refer to as “interactions” in the software.

If matched samples are available, we compute the log2 fold change for each pair of samples across condition in the same covariate group, and then we use a Wilcoxon rank sum statistic for comparing the log2 fold changes across the secondary covariate. For permutation significance, the secondary covariate labels of the pairs are permuted. For un-matched samples, multiple random “pseudo-pairs” of samples across condition within the two covariate groups are chosen, and the statistic computed as above, averaging over the random pseudo-pairings. The motivation for the above permutation schemes is to ensure the following condition, that “under the null hypothesis, the likelihood of the data is invariant under these permutations” (Anderson and Ter Braak 2003), where our null hypothesis specifically involves the interaction between condition and the secondary covariate.

For the macrophage dataset we have been working with (Alasoo et al. 2018), we have a 2x2 experimental design, with IFN gamma stimulation, *Salmonella* infection, and both treatments, as well as control samples. We have these four conditions across 6 cell lines from 6 donors (a subset of all the RNA-seq samples available). So we can use the first method described above, where the cell line is used to match samples across condition.

## Condition and secondary covariates

We begin the interaction analysis by now loading in the full set of samples, as before we only loaded the samples for the two group analysis. We then define two new factors indicating IFNg status and *Salmonella* status.

```
coldata <- read.csv(file.path(dir, "coldata.csv"))
coldata <- coldata[,c(1,2,3,5)]
names(coldata) <- c("names","id","line","condition")
coldata$files <- file.path(dir, "quants", coldata$names, "quant.sf.gz")
se <- tximeta(coldata)
```

```
se$ifng <- factor(ifelse(
  grepl("IFNg",se$condition),
  "treated","control"))
se$salmonella <- factor(ifelse(
  grepl("SL1344",se$condition),
  "infected","control"))
with(colData(se),
     table(ifng, salmonella))
```

```
##          salmonella
## ifng      control infected
##   control       6        6
##   treated       6        6
```

We will work with the chromosome 1 transcripts for demonstration:

```
y2 <- se
y2 <- y2[seqnames(y2) == "chr1",]
```

## Create and check paired samples

Our implementation of the interaction design for matched samples takes into account matched samples within the `x` condition, which we will specify to be the *Salmonella* infection status. We will specify the secondary covariate `cov` to be the IFN gamma treatment. We will look for transcripts where the infection response changes based on IFN gamma treatment.

To perform the analysis, we create a new variable `pair` which will record which samples are related within groups defined by IFN gamma treatment status.

```
y2$pair <- factor(y2$line)
levels(y2$pair) <- LETTERS[1:6] # simplify names
y2$pair <- as.character(y2$pair)
y2$pair[y2$ifng == "control"]
```

```
##  [1] "A" "A" "B" "B" "C" "C" "D" "D" "E" "E" "F" "F"
```

```
y2$pair[y2$ifng == "treated"]
```

```
##  [1] "A" "A" "B" "B" "C" "C" "D" "D" "E" "E" "F" "F"
```

```
y2$pair[y2$ifng == "treated"] <- rep(LETTERS[7:12], each=2)
y2$pair <- factor(y2$pair)
head(table(y2$pair, y2$salmonella))
```

```
##
##     control infected
##   A       1        1
##   B       1        1
##   C       1        1
##   D       1        1
##   E       1        1
##   F       1        1
```

## Swish for interaction effects

We now perform `swish` analysis, specifying the *Salmonella* infection as our main condition, the IFN gamma treatment as the secondary covariate, and providing the pairing within IFN gamma treatment groups. We specify `interaction=TRUE` to test for differences in infection response across IFN gamma treatment group.

```
y2 <- scaleInfReps(y2)
y2 <- labelKeep(y2)
y2 <- y2[mcols(y2)$keep,]
set.seed(1)
y2 <- swish(y2, x="salmonella", cov="ifng", pair="pair", interaction=TRUE)
```

## Plotting interaction results

In this case, we appear to have fewer non-null p-values from first impression of the p-value histogram:

```
hist(mcols(y2)$pvalue, col="grey")
```

![](data:image/png;base64...)

The MA plot shows significant transcripts on either side of `log2FC=0`. Note that the log2 fold change reported is the *difference* between the log2 fold change in the IFN gamma treated and IFN gamma control group. So positive `log2FC` in this plot indicates that the effect is higher with IGN gamma treatment than in absence of the treatment.

```
plotMASwish(y2, alpha=.05)
```

![](data:image/png;base64...)

We can plot some of the transcripts with high log fold change *difference* across IFN gamma treatment group, and which belong to the less than 5% nominal FDR group:

```
idx <- with(mcols(y2), which(qvalue < .05 & log2FC > 5))
plotInfReps(y2, idx[1], x="ifng", cov="salmonella")
```

![](data:image/png;base64...)

```
plotInfReps(y2, idx[2], x="ifng", cov="salmonella")
```

![](data:image/png;base64...)

# Allelic expression analysis

We have a separate vignette for allelic expression analysis, either navigate to the [allelic vignette](https://thelovelab.github.io/fishpond/articles/allelic.html) on the *fishpond* website, or the following from the R prompt:

```
vignette(topic="allelic", package="fishpond")
```

The allelic analysis methods are described in Wu et al. (2022) [doi: 10.1101/2022.08.12.503785](https://doi.org/10.1101/2022.08.12.503785).

# Correlation test

*Swish* now has methods to compute correlations (`"spearman"` or `"pearson"`) of a continuous variable `x` with the log counts, and then assess the significance of those correlations using inferential replicates and permutation tests. Additionally, one can compute correlations of a covariate `cov` with log fold changes across a pairing variable (where `x` labels the condition for the log fold change and `pair` labels the pairs). The Spearman-based test statistic follows the procedure from the original method *SAMseq* that *Swish* is based upon (Li and Tibshirani 2011), e.g. the methods used in that package with a quantitative response type. See `?swish` and the `cor` argument for more details on the use of correlations within *Swish*.

For examples of the correlation tests, see the dynamic AI examples in the `"allelic"` fishpond vignette, or there are also some simulated examples in the `test_correlation.R` testing script located in fishpond’s `tests/testthat` directory.

# alevin scRNA-seq

The *alevin* (Srivastava et al. 2019) and *tximport* / *tximeta* maintainers have created an efficient format for storing and importing the sparse scRNA-seq estimated gene counts, inferential mean and variance data, and optionally the inferential replicate counts. `tximeta` will automatically import these matrices if *alevin* was run using `--numCellBootstraps` (in order to generate inferential variance) and additionally `--dumpFeatures` (in order to dump the inferential replicates themselves, see below on thoughts on avoiding this step though).

The storage format for counts, mean, variance, and inferential replicates, involves writing one cell at a time, storing the locations of the non-zero counts, and then the non-zero counts. The matrices are loaded into R sparely using the *Matrix* package. The storage format is efficient, for example, the estimated counts for the 900 mouse neuron dataset from 10x Genomics takes up 4.2 Mb, the mean/variance matrices take up 8.6 Mb each, and the inferential replicates takes up 72 Mb (20 bootstrap inferential replicates). Hence avoiding writing and importing the inferential replicates themselves, and only using the mean and variance, is desirable.

The `swish` and *alevin* authors have developed a workflow that uses inferential mean and variance to generate pseudo-inferential replicates in place of the actual inferential replicates. Storing and importing only the inferential mean and variance is much more efficient (dramatically faster load time and less space on disk and in memory). The faster workflow would then skip `--dumpFeatures` when running *alevin*, or subsequently use `dropInfReps=TRUE` to not load the inferential replicates into R.

**Plotting:** To demonstrate how the inferential mean and variance look across real scRNA-seq data, we load the neurons dataset and plot the inferential replicate data across cells. First we read in the counts, in this case using `dropInfReps=TRUE` because the directory includes the actual inferential replicates, not only the mean and variance. We set `skipMeta=TRUE`, although in general you would want `tximeta` to add the gene range information and other metadata if working with human, mouse, or fruit fly.

```
dir <- system.file("extdata", package="tximportData")
files <- file.path(dir,"alevin/neurons_900_v014/alevin/quants_mat.gz")
neurons <- tximeta(files, type="alevin",
                   skipMeta=TRUE, # just for vignette
                   dropInfReps=TRUE,
                   alevinArgs=list(filterBarcodes=TRUE))
```

We can easily make a *SingleCellExperiment* object (Amezquita et al. 2020), and plot counts across cluster (here a randomly assigned cluster label). For more details on working with *SingleCellExperiment* objects, consult the following online book: [Orchestrating Single-Cell Analysis with Bioconductor](https://osca.bioconductor.org/) (Amezquita et al. 2020).

```
library(SingleCellExperiment)
sce <- as(neurons, "SingleCellExperiment")
sce$cluster <- factor(paste0("cl",sample(1:6,ncol(sce),TRUE)))
par(mfrow=c(2,1), mar=c(2,4,2,1))
plotInfReps(sce, "ENSMUSG00000072235.6", x="cluster",
            legend=TRUE)
plotInfReps(sce, "ENSMUSG00000072235.6", x="cluster",
            reorder=FALSE)
```

`plotInfReps` has a number of options and convenience arguments for visualizing single cell data. One can:

* add a `legend`,
* `reorder` the cells by expression value within cluster,
* apply size factors to the counts (`applySF`) (size factor scaling will use the values in `sizeFactors(sce)` or equivalently `mcols(sce)$sizeFactor`),
* use a column of `mcols(sce)` to set the `main` title, e.g. `mainCol="SYMBOL"`,
* specify `x` as a numeric covariate (e.g. pseudotime), and use `cov` to distinguish groups (e.g. lineage). Points will then be colored by `cov` instead of by discrete `x`.

See `?plotInfReps` for more description of arguments.

Note that the figures scale to some degree by the number of cells; for example with \(n \in [1,150)\) or \([150,400)\), more visual elements per cell will be included:

**Advice on Swish testing:** `swish` can be run on *alevin* counts imported with `tximeta`, but there are a few extra steps suggested. The following does not use evaluated code chunks, but provides suggestions for how to tailor `swish` to single-cell datasets.

**Filter genes:** we recommend to filter genes as the first step, to reduce the size of the data before losing sparsity on the count matrices (conversion of data to ranks loses data sparsity inside the `swish()` function). One can run `labelKeep` therefore before `scaleInfReps`. E.g., to remove genes for which there are not 10 cells with a count of 3 or more:

```
y <- labelKeep(y, minCount=3, minN=10)
y <- y[mcols(y)$keep,] # subset genes
```

**Subset cells:** One should also subset to the groups of cells of interest for differential testing, in order to take up the least amount of memory when the sparse matrices are converted to dense matrices. Note that `swish` only allows for differential testing of two groups (although it allows for blocking factors and interaction tests).

**(Slower) With inferential replicates:** After one has filtered both genes and cells down to the set that are of interest for differential testing, one can run the following commands, to make the sparse matrices into dense ones, scale the cells, and perform *Swish* differential expression, however read on for faster suggestions.

```
assays(y) <- lapply(assays(y), as.matrix) # make dense matrices
y <- scaleInfReps(y, lengthCorrect=FALSE, sfFun=sfFun)
y <- swish(y, x="condition")
```

**Size factor function:** Note that `scaleInfReps` has an argument `sfFun` which allows the user to provide their own size factor calculation function. We have found that `calculateSumFactors` (Lun, Bach, and Marioni 2016) in the *scran* package (A. T. L. Lun, McCarthy, and Marioni 2016) works well for computing size factors. `sfFun` should be specified as a function that returns a vector of size factors, or a numeric vector of the size factors themselves.

**(Faster) Without inferential replicates:** The following workflow can be used in the case that `assayNames(y)` only contains counts, mean, and variance, which is much faster by avoiding writing/importing inferential replicates. We first generate pseudo-inferential replicates from inferential mean and variance matrices before running `scaleInfReps` from the code chunk above. The generation of pseudo-inferential replicates is described in Van Buren et al. (2020).

The following function can be used just before `scaleInfReps`:

```
y <- makeInfReps(y, 20)
```

There is alternatively a scheme for splitting the operation of generating (dense) inferential replicate matrices across multiple jobs, and running `swish` across batches of genes at a time. This job-splitting procedure is also described and benchmarked in Van Buren et al. (2020). This helps to reduce the total memory used, in the case that the counts, mean, and variance matrices are too large to be made dense altogether. This scheme involves 1) splitting the object into smaller pieces, written out to `.rds` files, 2) running `swish` as a distributed job, 3) reading the `.csv` output back into R. The following code chunk would start with a ‘y’ with sparse matrix assays, and without ever running `scaleInfReps` (it is run within the distributed job, and with `lengthCorrect=FALSE` by default).

```
library(SingleCellExperiment)
y <- as(y, "SingleCellExperiment")
# then, after filtering genes and cells...
# compute and store sizeFactors calculated over all genes
y <- scran::computeSumFactors(y)
# split swish objects into 8 RDS files:
splitSwish(y, nsplits=8, prefix="swish", snakefile="Snakefile")
# now, run snakemake from command line
# after finished, results back into R:
y <- addStatsFromCSV(y, "summary.csv")
```

The `splitSwish` function will write out a `Snakefile` that can be used with [snakemake](https://snakemake.readthedocs.io/en/stable/) in order to run distributed `swish` jobs in an easily customized workflow. Then the `addStatsFromCSV` will read in and attach the results to the original object. This final alternative avoids generating dense matrices until they have been split into `nsplits` pieces, and so can be used to reduce the memory requirements for the individual jobs. If one is new to running `snakemake`, it is recommended to first run with the flags `-np` as a “dry-run” to see the operations that will be performed. The `swish` command can be customized in the `swish` rule in the `Snakefile`, e.g. to control for batches or test for interactions.

# Further details

## Analysis types supported by Swish

There are currently seven types of analysis supported by `swish`:

* Two group analysis
* Two groups with two or more batches
* Two group paired or matched samples
* Two condition x two group paired samples, interaction test
* Two condition x two group samples, not paired, interaction test
* Correlation test of expression with continuous x
* Correlation test of LFC for paired samples with continuous covariate

This vignette demonstrated the third in this list, but the others can be run by either not specifying any additional covariates, or by specifying a batch variable with the argument `cov` instead of `pair`. The two interaction tests can be run by specifying `interaction=TRUE` and providing `x`, `cov`, and optionally `pair`. The last two tests can be run using the `cor` argument (see [Correlation test](#correlation-test) section in this vignette).

## Accounting for continuous variables

We have two recommended approaches for using `swish` in combination with estimated batch effects, e.g. factors of unwanted variation estimated by *RUVSeq* or surrogate variables estimated by *SVA* (without loss of generality, we will call these batch factors). First, examine a plot of the estimated batch factors, e.g. a stripplot (1 factor) or scatterplot of pairs (2 or more factors).

1. If the samples seem to fall into discrete clusters, one can run `kmeans` to assign a discrete estimated batch to each cluster. If the number of samples per condition group per batch is 2 or more, then one can use the `cluster` output of the `kmeans` function as input to the `cov` argument of `swish`. This will then perform a stratified Mann-Whitney Wilcoxon test.
2. If the samples do not fall into discrete clusters, one can use the same approach that we use to correct the samples for sequencing depth variation: direct scaling of the estimated counts across the inferential replicates. Why this works: usually we do not scale counts in statistical inference pipelines because we lose the information about precision of counts across the dynamic range. However, because we keep the set of inferential replicate matrices, and these contain both sampling and additional inferential variance, we are able to track how scaling the counts affects the variance, and this informs the test statistic.

For the second approach, one can directly scale the inferential counts using *limma* and `removeBatchEffect`.

Here a demonstration using simulated data:

```
set.seed(1)
y <- makeSimSwishData()
```

First we perform standard scaling for sequencing depth and labeling of feautures with too few counts. We save the mean of scaled inferential replicates using `saveMeanScaled=TRUE` as we will use this to estimate the batch factors.

```
y <- scaleInfReps(y, saveMeanScaled=TRUE)
tail(assayNames(y),4) # 'meanScaled' assay
```

```
## [1] "infRep18"   "infRep19"   "infRep20"   "meanScaled"
```

```
y <- labelKeep(y)
y <- y[mcols(y)$keep,]
```

Next estimate the batch factors on the mean of scaled inferential count matrices.

```
norm_cts_for_batch <- assay(y, "meanScaled")
# use batch factor estimation method of your choosing
# ...
```

Suppose we estimate two batch factors, `w1` and `w2`, now we remove the variation from each inferential replicate associated with these, using limma’s `removeBatchEffect`.

```
w1 <- runif(ncol(y)) # here simulated w1, use real instead
w2 <- runif(ncol(y)) # here simulated w2, use real instead
W <- data.frame(w1, w2)
infRepIdx <- grep("infRep",assayNames(y),value=TRUE)
nreps <- length(infRepIdx)
```

The following loads *limma* and removes batch associated variation on the log2 scale (a pseudocount is added to avoid `-Inf` values).

```
suppressPackageStartupMessages(library(limma))
mm <- model.matrix(~condition, colData(y))
pc <- .1
for (k in seq_len(nreps)) {
  logInfRep <- log(assay(y, infRepIdx[k]) + pc)
  logInfRep <- limma::removeBatchEffect(
                        logInfRep,
                        covariates=W,
                        design=mm)
  assay(y, infRepIdx[k]) <- exp(logInfRep)
}
```

Now we run `swish` as usual:

```
y <- swish(y, x="condition")
```

While we have assessed this approach with a small number of estimated nuisance covariates, note that with many covariates this approach may lead to inflation of test statistics.

## Structure of tximeta output

While `tximeta` is the safest way to provide the correct input to `swish`, all that `swish` requires for running is a *SummarizedExperiment* object with the following assays: `counts`, `length`, and `infRep1`, `infRep2`, …, `infRepN`, where `N` is simply the number of Gibbs samples or boostraps samples, e.g. 20 in the examples above. The counts and inferential replicates are estimated counts from a quantification method, either at the transcript level or summed to the gene level (simple sum). These counts sum up to the (mapped) library size for each sample. It is assumed that the `length` matrix gives the effective lengths for each transcript, or average transcript length for each gene as summarized by the functions in `tximeta`/`tximport`. If the counts should not be corrected for effective length (e.g. 3’ tagged RNA-seq), then `lengthCorrect=FALSE` should be specified when running `scaleInfReps`.

Note on simulation: it is difficult to simulate inferential uncertainty in a realistic manner without construction of reads from transcripts, using a method like *polyester*. Constructing reads from the reference transcriptome or a sample-specific transcriptome naturally produces the structure of read-assignment inferential uncertainty that `swish` and other methods control for in real RNA-seq data.

## Plotting q-values over statistics

As with *SAMseq* and *SAM*, `swish` makes use of the permutation plug-in approach for q-value calculation. `swish` calls the `empPvals` and `qvalue` functions from the *qvalue* package to calculate the q-values (or optionally similar functions from the *samr* package). If we plot the q-values against the statistic, or against the log2 fold change, one can see clusters of genes with the same q-value (because they have the same or similar statistic). One consequence of this is that, in order to rank the genes, rather than ranking directly by q-value, it makes more sense to pick a q-value threshold and then within that set of genes, to rank by the log fold change, as shown above when the code chunk has `log2FC * sig`.

```
gres <- mcols(gy)[mcols(gy)$keep,]
min(gres$qvalue, na.rm=TRUE) # min nominal FDR is not 0
```

```
## [1] 9.889241e-05
```

```
with(gres, plot(stat, -log10(qvalue)))
```

![](data:image/png;base64...)

```
with(gres, plot(log2FC, -log10(qvalue)))
abline(v=0, col="red")
```

![](data:image/png;base64...)

```
with(gres, plot(log2FC, -log10(qvalue),
                xlim=c(-1.5,1.5), ylim=c(0,1.5)))
abline(v=0, col="red")
```

![](data:image/png;base64...)

## Plotting InfRV

In the Swish paper, we describe a statistic, InfRV, which is useful for categorizing groups of features by their inferential uncertainty. Note that InfRV is not used in the `swish` method, but only for visualization in the paper. Here we show how to compute and plot the InfRV:

```
y3 <- se
y3 <- y3[seqnames(y3) == "chr4",]
y3 <- y3[,y3$condition %in% c("naive","IFNg")]
y3 <- labelKeep(y3)
y3 <- y3[mcols(y3)$keep,]
y3 <- computeInfRV(y3)
mcols(y3)$meanCts <- rowMeans(assays(y3)[["counts"]])
with(mcols(y3), plot(meanCts, meanInfRV, log="xy"))
```

![](data:image/png;base64...)

```
hist(log10(mcols(y3)$meanInfRV),
     col="grey50", border="white", breaks=20,
     xlab="mean InfRV", main="Txp-level inferential uncertainty")
```

![](data:image/png;base64...)

## Salmon in alignment mode, how to use tximeta

If you ran Salmon in alignment mode, then a Salmon index was not used. Without a Salmon index, there is not a checksum that tximeta uses to identify the transcriptome. You can specify `skipMeta=TRUE` to avoid tximeta attempting to match on the transcriptome in this case.

If you want to combine transcripts to gene level (or some other level of aggregation), you can set `txOut=FALSE, tx2gene=tx2gene` when calling `tximeta` and it will pass these arguments to tximport when importing the counts and inferential replicates.

## Permutation schemes for interactions

The following diagrams describe the permutation schemes used for the interaction designs implemented in `swish`. The case with matched samples (pair indicated by number, primary condition indicated by color, the vertical line separating the pairs by secondary covariate):

![](data:image/png;base64...)

The case without matched samples (sample indicated by letter, primary condition indicated by color, the vertical line separating the samples by secondary covariate). Here multiple random pseudo-pairs are chosen across condition. The permutation scheme ensures that LFCs are always calculated between samples from the same covariate group.

![](data:image/png;base64...)

## Session information

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
##  [1] limma_3.66.0                org.Hs.eg.db_3.22.0
##  [3] tximeta_1.28.0              macrophage_1.25.0
##  [5] SummarizedExperiment_1.40.0 MatrixGenerics_1.22.0
##  [7] matrixStats_1.5.0           fishpond_2.16.0
##  [9] EnsDb.Hsapiens.v86_2.99.0   ensembldb_2.34.0
## [11] AnnotationFilter_1.34.0     GenomicFeatures_1.62.0
## [13] AnnotationDbi_1.72.0        Biobase_2.70.0
## [15] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [17] IRanges_2.44.0              S4Vectors_0.48.0
## [19] BiocGenerics_0.56.0         generics_0.1.4
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              tximport_1.38.0
##   [5] magrittr_2.0.4              farver_2.1.2
##   [7] rmarkdown_2.30              BiocIO_1.20.0
##   [9] vctrs_0.6.5                 memoise_2.0.1
##  [11] Rsamtools_2.26.0            RCurl_1.98-1.17
##  [13] base64enc_0.1-3             htmltools_0.5.8.1
##  [15] S4Arrays_1.10.0             progress_1.2.3
##  [17] AnnotationHub_4.0.0         curl_7.0.0
##  [19] SparseArray_1.10.0          Formula_1.2-5
##  [21] sass_0.4.10                 bslib_0.9.0
##  [23] htmlwidgets_1.6.4           plyr_1.8.9
##  [25] Gviz_1.54.0                 httr2_1.2.1
##  [27] cachem_1.1.0                GenomicAlignments_1.46.0
##  [29] lifecycle_1.0.4             pkgconfig_2.0.3
##  [31] Matrix_1.7-4                R6_2.6.1
##  [33] fastmap_1.2.0               digest_0.6.37
##  [35] colorspace_2.1-2            Hmisc_5.2-4
##  [37] RSQLite_2.4.3               filelock_1.0.3
##  [39] httr_1.4.7                  abind_1.4-8
##  [41] compiler_4.5.1              withr_3.0.2
##  [43] bit64_4.6.0-1               htmlTable_2.4.3
##  [45] S7_0.2.0                    backports_1.5.0
##  [47] BiocParallel_1.44.0         DBI_1.2.3
##  [49] biomaRt_2.66.0              rappdirs_0.3.3
##  [51] DelayedArray_0.36.0         rjson_0.2.23
##  [53] gtools_3.9.5                tools_4.5.1
##  [55] foreign_0.8-90              nnet_7.3-20
##  [57] glue_1.8.0                  restfulr_0.0.16
##  [59] grid_4.5.1                  checkmate_2.3.3
##  [61] cluster_2.1.8.1             reshape2_1.4.4
##  [63] gtable_0.3.6                BSgenome_1.78.0
##  [65] tzdb_0.5.0                  data.table_1.17.8
##  [67] hms_1.1.4                   XVector_0.50.0
##  [69] BiocVersion_3.22.0          pillar_1.11.1
##  [71] stringr_1.5.2               vroom_1.6.6
##  [73] splines_4.5.1               dplyr_1.1.4
##  [75] BiocFileCache_3.0.0         lattice_0.22-7
##  [77] rtracklayer_1.70.0          bit_4.6.0
##  [79] deldir_2.0-4                biovizBase_1.58.0
##  [81] tidyselect_1.2.1            SingleCellExperiment_1.32.0
##  [83] Biostrings_2.78.0           knitr_1.50
##  [85] gridExtra_2.3               ProtGenerics_1.42.0
##  [87] xfun_0.53                   statmod_1.5.1
##  [89] pheatmap_1.0.13             stringi_1.8.7
##  [91] UCSC.utils_1.6.0            lazyeval_0.2.2
##  [93] yaml_2.3.10                 evaluate_1.0.5
##  [95] codetools_0.2-20            cigarillo_1.0.0
##  [97] interp_1.1-6                archive_1.1.12
##  [99] tibble_3.3.0                qvalue_2.42.0
## [101] BiocManager_1.30.26         cli_3.6.5
## [103] rpart_4.1.24                jquerylib_0.1.4
## [105] dichromat_2.0-0.1           Rcpp_1.1.0
## [107] GenomeInfoDb_1.46.0         svMisc_1.4.3
## [109] dbplyr_2.5.1                png_0.1-8
## [111] XML_3.99-0.19               parallel_4.5.1
## [113] readr_2.1.5                 ggplot2_4.0.0
## [115] blob_1.2.4                  prettyunits_1.2.0
## [117] latticeExtra_0.6-31         jpeg_0.1-11
## [119] bitops_1.0-9                txdbmaker_1.6.0
## [121] VariantAnnotation_1.56.0    scales_1.4.0
## [123] purrr_1.1.0                 crayon_1.5.3
## [125] rlang_1.1.6                 KEGGREST_1.50.0
```

# References

Alasoo, K, J Rodrigues, S Mukhopadhyay, AJ Knights, AL Mann, K Kundu, HIPSCI-Consortium, C Hale, Dougan G, and DJ Gaffney. 2018. “Shared genetic effects on chromatin and gene expression indicate a role for enhancer priming in immune response.” *Nature Genetics* 50: 424–31. <https://doi.org/10.1038/s41588-018-0046-7>.

Amezquita, Robert A., Aaron T. L. Lun, Etienne Becht, Vince J. Carey, Lindsay N. Carpp, Ludwig Geistlinger, Federico Marini, et al. 2020. “Orchestrating Single-Cell Analysis with Bioconductor.” *Nature Methods* 17 (2): 137–45. <https://doi.org/10.1038/s41592-019-0654-x>.

Anderson, MJ, and CJF Ter Braak. 2003. “Permutation Tests for Multi-Factorial Analysis of Variance.” *Journal of Statistical Computation and Simulation* 73 (2): 85–113.

Frankish, A, GENCODE-consoritum, and P Flicek. 2018. “GENCODE reference annotation for the human and mouse genomes.” *Nucleic Acids Research*. <https://doi.org/10.1093/nar/gky955>.

Li, J, and R Tibshirani. 2011. “Finding consistent patterns: A nonparametric approach for identifying differential expression in RNA-Seq data.” *Statistical Methods in Medical Research* 22 (5): 519–36. <https://doi.org/10.1177/0962280211428386>.

Love, Michael I., Charlotte Soneson, Peter F. Hickey, Lisa K. Johnson, N. Tessa Pierce, Lori Shepherd, Martin Morgan, and Rob Patro. 2020. “Tximeta: Reference sequence checksums for provenance identification in RNA-seq.” *PLOS Computational Biology*. <https://doi.org/10.1371/journal.pcbi.1007664>.

Lun, Aaron T. L., Karsten Bach, and John C. Marioni. 2016. “Pooling across cells to normalize single-cell RNA sequencing data with many zero counts.” *Genome Biology* 17 (1): 75. <https://doi.org/10.1186/s13059-016-0947-7>.

Lun, A. T. L., D. J. McCarthy, and J. C. Marioni. 2016. “A Step-by-Step Workflow for Low-Level Analysis of Single-Cell Rna-Seq Data with Bioconductor.” *F1000Research* 5: 2122. <https://doi.org/10.12688/f1000research.9501.2>.

Patro, R, G Duggal, MI Love, RA Irizarry, and C Kingsford. 2017. “Salmon Provides Fast and Bias-Aware Quantification of Transcript Expression.” *Nature Methods* 14: 417–19. <https://doi.org/10.1038/nmeth.4197>.

Srivastava, Avi, Laraib Malik, Tom Sean Smith, Ian Sudbery, and Rob Patro. 2019. “Alevin efficiently estimates accurate gene abundances from dscRNA-seq data.” *Genome Biology* 20 (65). <https://doi.org/10.1186/s13059-019-1670-y>.

Storey, JD, and R Tibshirani. 2003. “ Statistical significance for genome-wide experiments.” *Proceedings of the National Academy of Sciences* 100 (16): 9440–5. <https://doi.org/10.1073/pnas.1530509100>.

Van Buren, S, H Sarkar, A Srivastava, NU Rashid, R Patro, and MI Love. 2020. “Compression of quantification uncertainty for scRNA-seq counts.” *bioRxiv*. <https://doi.org/10.1101/2020.07.06.189639>.

Wu, Euphy, Noor P. Singh, Kwangbom Choi, Mohsen Zakeri, Matthew Vincent, Gary A. Churchill, Cheryl L. Ackert-Bicknell, Rob Patro, and Michael I. Love. 2022. “Detecting Isoform-Level Allelic Imbalance Accounting for Inferential Uncertainty.” *bioRxiv*. <https://doi.org/10.1101/2022.08.12.503785>.

Zhu, A, A Srivastava, JG Ibrahim, R Patro, and MI Love. 2019. “Nonparametric expression analysis using inferential replicate counts.” *Nucleic Acids Research* 47 (18): e105. <https://doi.org/10.1093/nar/gkz622>.