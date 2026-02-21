# Bioconductor Package Vignette

#### Tsu-Pei Chiu, Federico Comoglio and Remo Rohs

#### 2025-10-29

## Introduction

DNAshapeR predicts DNA shape features in an ultra-fast, high-throughput manner from genomic sequencing data. The package takes either nucleotide sequence or genomic intervals as input, and generates various graphical representations for further analysis. DNAshapeR further encodes DNA sequence and shape features for statistical learning applications by concatenating feature matrices with user-defined combinations of k-mer and DNA shape features that can be readily used as input for machine learning algorithms.

In this vignette, you will learn:

* how to load/install DNAshapeR
* how to predict DNA shape features
* how to visualize DNA shape predictions
* how to encode sequence and shape features, and apply them

## Load DNAshapeR

```
library(DNAshapeR)
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
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
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

## Predict DNA shape features

The core of DNAshapeR, the DNAshape method (Zhou, et al., 2013), uses a sliding pentamer window where structural features unique to each of the 512 distinct pentamers define a vector of minor groove width (MGW), Roll, propeller twist (ProT), and helix twist (HelT) at each nucleotide position. MGW and ProT define base-pair parameters whereas Roll and HelT represent base pair-step parameters. The values for each DNA shape feature as function of its pentamer sequence were derived from all-atom Monte Carlo simulations where DNA structure is sampled in collective and internal degrees of freedom in combination with explicit sodium counter ions (Zhang, et al., 2014). The Monte Carlo simulations were analyzed with a modified Curves approach (Zhou, et al., 2013). Average values of each shape feature for each pentamer were derived from analyzing the ensemble of Monte Carlo predictions for 2,121 DNA fragments of 12−27 base pairs in length. DNAshapeR predicts the four DNA shape features MGW, HelT, ProT, and Roll, which were observed in various cocrystal structures as playing an important role in specific protein-DNA binding.

In the latest version, we further added additional 9 DNA shape features beyond our previous set of 4 features, and expanded our available repertoire to a total of 13 features, including 6 inter-base pair or base pair-step parameters (HelT, Rise, Roll, Shift, Slide, and Tilt), 6 intra-base pair or base pair-step parameters (Buckle, Opening, ProT, Shear, Stagger, and Stretch), and MGW.

## Predict biophysical feature

Our previous work explained protein-DNA binding specificity based on correlations between MGW and (electrostatic potential) EP observed in experimentally available structures (Joshi, et al., 2007). However, A/T and C/G base pairs carry different partial charge distributions in the minor groove (due primarily to the guanine amino group), which will affect minor-groove EP. We developed a high-throughput method, named DNAphi, to predict minor-groove EP based on data mining of results from solving the nonlinear Poisson-Boltzmann calculations (Honig & Nicholls, 1995) on 2,297 DNA structures derived from Monte Carlo simulations. DNAshapeR includes EP as an additional feature.

## Predict DNA shape feature due to CpG methylation

To achieve a better mechanistic understanding of the effect of CpG methylation on local DNA structure, we developed a high-throughput method, named methyl-DNAshape, for predicting the impact of cytosine methylation on DNA shape features. In analogy to the DNAshape method (Zhou, et al., 2013), the method predicts DNA shape features (ProT, HelT, Roll, and MGW) in the context of CpG methylation based on methyl-DNAshape Pentamer Query Table (mPQT) derived from the results of all-atom Monte Carlo simulations on a total of 3,518 DNA fragments of lengths varying from 13 to 24 bp.

DNAshapeR can predict DNA shape features from custom FASTA files or directly from genomic coordinates in the form of a GRanges object within Bioconductor (see <https://bioconductor.org/packages/release/bioc/html/GenomicRanges.html> for more information).

### From FASTA file

To predict DNA shape features from a FASTA file

```
library(DNAshapeR)
fn <- system.file("extdata", "CGRsample.fa", package = "DNAshapeR")
pred <- getShape(fn)
```

```
## Reading the input sequence......
## Reading the input sequence......
## Reading the input sequence......
## Reading the input sequence......
## Reading the input sequence......
```

```
## Parsing files......
```

```
## Record length: 2000
```

```
## Record length: 1999
```

```
## Record length: 2000
```

```
## Record length: 1999
```

```
## Record length: 2000
```

```
## Done
```

### From genomic intervals (e.g. TFs binding sites, CpG islands, replication origins, …)

To predict DNA shape from genomic intervals stored as GRanges object, a reference genome is required. Several reference genomes are available within BioConductor as BSgenome objects (see <http://bioconductor.org/packages/release/bioc/html/BSgenome.html> for more information). For example, the sacCer3 release of the *S.Cerevisiae* genome can be retrieved. Given a reference genome, the **getFasta** function first extracts the DNA sequences based on the provided genomic coordinates, and then performs shape predictions within a user-defined window (of size equal to width, 100 bp in the example below) computed from the center of each genomic interval:

```
# Install Bioconductor packages
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("BSgenome.Scerevisiae.UCSC.sacCer3")

library(BSgenome.Scerevisiae.UCSC.sacCer3)

# Create a query GRanges object
gr <- GRanges(seqnames = c("chrI"),
            strand = c("+", "-", "+"),
            ranges = IRanges(start = c(100, 200, 300), width = 100))
getFasta(gr, Scerevisiae, width = 100, filename = "tmp.fa")
fn <- "tmp.fa"
pred <- getShape(fn)
```

### From public domain projects

The genomic intervals can also be obtained from public domain projects, including ENCODE, NCBI, Ensembl, etc. The AnnotationHub package (see <http://bioconductor.org/packages/release/bioc/html/AnnotationHub.html> for more information) provides an interface to retrieve genomic intervals from these multiple online project resources.The genomic intervals of interest can be selected progressively through the functions of **sebset** and **query** with keywords, and can be subjected as an input of GRanges object to **getFasta** function.

```
# Install Bioconductor packages
library(BSgenome.Hsapiens.UCSC.hg19)
library(AnnotationHub)

ah <- AnnotationHub()
ah <- subset(ah, species=="Homo sapiens")
ah <- query(ah, c("H3K4me3", "Gm12878", "Roadmap"))
getFasta(ah[[1]], Hsapiens, width = 150, filename = "tmp.fa")
fn <- "tmp.fa"
pred <- getShape(fn)
```

### From FASTA file with methylated DNA sequence

To predict DNA shape features in the context of CpG methylation, one can prepare a FASTA file of sequence with symbol ‘Mg’: ‘M’ referring to cytosine of methylated CpG on the leading strand and ‘g’ referring the cytosine of methylated CpG on lagging strand. For example,

>seq1

GTGTCACMgCGTCTATACG

notifying the cytosine at position 8th on the leading strand and the one at position 9th on the lagging strand are methylated.

```
library(DNAshapeR)
fn_methy <- system.file("extdata", "MethylSample.fa", package = "DNAshapeR")
pred_methy <- getShape(fn_methy, methylate = TRUE)
```

```
## Reading the input sequence......
## Reading the input sequence......
## Reading the input sequence......
## Reading the input sequence......
```

```
## Parsing files......
```

```
## Record length: 19
```

```
## Record length: 18
```

```
## Record length: 19
```

```
## Record length: 18
```

```
## Done
```

```
pred_methy$MGW
```

```
##   [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14]
## 1   NA   NA 5.49 5.43 6.01  5.4 4.92 5.08 5.51   5.2  5.09  4.83  5.32  5.69
##   [,15] [,16] [,17] [,18] [,19]
## 1  5.79  6.01  5.53    NA    NA
```

### From FASTA and methylated position files

To predict DNA shape features in the context of CpG methylation, in addition to providing regular FASTA file (without symbolizing ‘Mg’) one can provide an additional input file identifying methylated positions. For example,

>seq1

4,16

notifying the cytosine at position 4th and 16th on leading strand, and 5th and 17th on lagging strand are methylated.

```
library(DNAshapeR)
fn_methy <- system.file("extdata", "SingleSeqsample.fa", package = "DNAshapeR")
fn_methy_pos <- system.file("extdata", "MethylSamplePos.fa", package = "DNAshapeR")
pred_methy <- getShape(fn_methy, methylate = TRUE, methylatedPosFile = fn_methy_pos)
```

```
## Reading the input sequence......
## Reading the input sequence......
## Reading the input sequence......
## Reading the input sequence......
```

```
## Parsing files......
```

```
## Record length: 24
```

```
## Record length: 23
```

```
## Record length: 24
```

```
## Record length: 23
```

```
## Done
```

```
pred_methy$MGW
```

```
##   [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14]
## 1   NA   NA 4.67 4.72 5.24 5.99 5.75 4.93  3.9  4.36  4.77  5.52   5.4  5.09
##   [,15] [,16] [,17] [,18] [,19] [,20] [,21] [,22] [,23] [,24]
## 1  4.67  4.72  5.24  5.99  5.75  4.93   3.9  4.36    NA    NA
```

## Visualize DNA shape prediction

DNAshapeR can be used to generate various graphical representations for further analyses. The prediction result can be visualized in the form of scatter plots (Comoglio, et al., 2015), heat maps (Yang, et al., 2014), or genome browser tracks (Chiu, et al., 2015).

### Ensemble representation: metashape plot

The prediction result can be visualized in the metaprofiles of DNA shape features.

```
plotShape(pred$MGW)
```

![](data:image/png;base64...)

```
#plotShape(pred$ProT)
#plotShape(pred$Roll)
#plotShape(pred$HelT)
```

### Ensemble representation: heat map

The prediction result can be visualized in the heatmap of DNA shape features.

```
library(fields)
```

```
## Loading required package: spam
```

```
## Spam version 2.11-1 (2025-01-20) is loaded.
## Type 'help( Spam)' or 'demo( spam)' for a short introduction
## and overview of this package.
## Help for individual functions is also obtained by adding the
## suffix '.spam' to the function name, e.g. 'help( chol.spam)'.
```

```
##
## Attaching package: 'spam'
```

```
## The following object is masked from 'package:stats4':
##
##     mle
```

```
## The following objects are masked from 'package:base':
##
##     backsolve, forwardsolve
```

```
## Loading required package: viridisLite
```

```
## Loading required package: RColorBrewer
```

```
##
## Try help(fields) to get started.
```

```
heatShape(pred$ProT, 20)
```

![](data:image/png;base64...)

```
#heatShape(pred$MGW, 20)
#heatShape(pred$Roll[1:500, 1:1980], 20)
#heatShape(pred$HelT[1:500, 1:1980], 20)
```

### Individual representation: genome browser-like tracks

The prediction result can be visualized in the form of genome browser tracks.

\*Note that the input data should only contain one sequence.

```
fn2 <- system.file("extdata", "SingleSeqsample.fa", package = "DNAshapeR")
pred2 <- getShape(fn2)
```

```
## Reading the input sequence......
## Reading the input sequence......
## Reading the input sequence......
## Reading the input sequence......
## Reading the input sequence......
```

```
## Parsing files......
```

```
## Record length: 24
```

```
## Record length: 23
```

```
## Record length: 24
```

```
## Record length: 23
```

```
## Record length: 24
```

```
## Done
```

```
trackShape(fn2, pred2) # Only for single sequence file
```

![](data:image/png;base64...)

## Encode sequence and shape features

DNAshapeR can be used to generate feature vectors for a user-defined model. These models can consist of either sequence features (1-mer, 2-mer, 3-mer), shape features (MGW, Roll, ProT, HelT), or any combination of those two. For 1-mer features, sequence is encoded in form of four binary numbers (i.e., in terms of 1-mers, 1000 for adenine, 0100 for cytosine, 0010 for guanine, and 0001 for thymine) at each nucleotide position (Zhou, et al., 2015). The encoding function of the DNAshapeR package enables the determination of higher order sequence features, for example, 2-mers and 3-mers (16 and 64 binary features at each position, respectively). The user can also choose to include second order shape features in the generated feature vector. The second order shape features are product terms of values for the same category of shape features (MGW, Roll, ProT or HelT) at adjacent positions. The feature encoding function of DNAshapeR enables the generation of any subset of these features, either only a selected shape category or first order shape features, and any combination with shape or sequence features. The result of feature encoding for each sequence is a chimera feature vector.

### Encoding process

A feature type vector should be defined before encoding. The vector can be any combination of characters of “k-mer”, “n-shape”, “n-MGW”, “n-ProT”, “n-Roll”, “n-HelT” (k, n are integers) where “1-shape” refers to first order and “2-shape” to second order shape features.

```
library(Biostrings)
```

```
## Loading required package: XVector
```

```
##
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
##
##     strsplit
```

```
fn3 <- system.file("extdata", "PBMsample_short.fa", package = "DNAshapeR")
pred3 <- getShape(fn3)
```

```
## Reading the input sequence......
## Reading the input sequence......
## Reading the input sequence......
## Reading the input sequence......
## Reading the input sequence......
```

```
## Parsing files......
```

```
## Record length: 36
```

```
## Record length: 35
```

```
## Record length: 36
```

```
## Record length: 35
```

```
## Record length: 36
```

```
## Done
```

```
featureType <- c("1-mer", "1-shape")
featureVector <- encodeSeqShape(fn3, pred3, featureType)
head(featureVector)
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14]
## seq1    0    0    1    0    0    0    1    0    0     0     1     0     0     1
## seq2    0    1    0    0    0    0    1    0    0     0     1     0     0     0
## seq3    0    0    1    0    0    0    1    0    0     1     0     0     0     0
## seq4    0    0    0    1    0    0    1    0    0     1     0     0     0     0
## seq5    0    0    0    1    0    0    1    0    0     1     0     0     0     0
## seq6    0    0    1    0    0    1    0    0    1     0     0     0     0     0
##      [,15] [,16] [,17] [,18] [,19] [,20] [,21] [,22] [,23] [,24] [,25] [,26]
## seq1     0     0     1     0     0     0     0     0     0     1     0     0
## seq2     1     0     0     0     1     0     1     0     0     0     0     0
## seq3     1     0     0     0     1     0     0     1     0     0     0     1
## seq4     1     0     0     0     1     0     0     1     0     0     0     0
## seq5     0     1     0     1     0     0     0     0     1     0     0     1
## seq6     1     0     0     1     0     0     0     0     1     0     0     0
##      [,27] [,28] [,29] [,30] [,31] [,32] [,33] [,34] [,35] [,36] [,37] [,38]
## seq1     1     0     1     0     0     0     1     0     0     0     1     0
## seq2     1     0     0     0     1     0     1     0     0     0     0     0
## seq3     0     0     0     1     0     0     0     0     1     0     0     0
## seq4     0     1     0     0     0     1     0     1     0     0     0     0
## seq5     0     0     0     1     0     0     0     0     0     1     0     0
## seq6     1     0     0     1     0     0     0     1     0     0     0     1
##      [,39] [,40] [,41] [,42] [,43] [,44] [,45] [,46] [,47] [,48] [,49] [,50]
## seq1     0     0     0     0     1     0     0     1     0     0     0     1
## seq2     1     0     0     1     0     0     0     1     0     0     1     0
## seq3     1     0     0     0     1     0     0     1     0     0     1     0
## seq4     1     0     0     0     1     0     0     1     0     0     0     0
## seq5     1     0     0     1     0     0     0     1     0     0     0     0
## seq6     0     0     0     1     0     0     1     0     0     0     0     0
##      [,51] [,52] [,53] [,54] [,55] [,56] [,57] [,58] [,59] [,60] [,61] [,62]
## seq1     0     0     1     0     0     0     0     1     0     0     0     1
## seq2     0     0     0     1     0     0     0     1     0     0     0     1
## seq3     0     0     0     0     0     1     0     1     0     0     0     1
## seq4     0     1     0     0     0     1     0     1     0     0     0     1
## seq5     0     1     0     0     1     0     0     1     0     0     0     1
## seq6     0     1     0     1     0     0     0     1     0     0     0     1
##      [,63] [,64] [,65] [,66] [,67] [,68] [,69] [,70] [,71] [,72] [,73] [,74]
## seq1     0     0     0     0     0     1     0     1     0     0     0     0
## seq2     0     0     1     0     0     0     0     1     0     0     0     0
## seq3     0     0     1     0     0     0     0     1     0     0     0     0
## seq4     0     0     1     0     0     0     0     1     0     0     0     0
## seq5     0     0     1     0     0     0     0     0     0     1     0     0
## seq6     0     0     1     0     0     0     0     1     0     0     0     0
##      [,75] [,76] [,77] [,78] [,79] [,80] [,81] [,82] [,83] [,84] [,85] [,86]
## seq1     1     0     0     0     0     1     0     0     1     0     0     0
## seq2     1     0     0     1     0     0     0     0     1     0     0     1
## seq3     1     0     0     0     0     1     0     0     1     0     0     0
## seq4     1     0     0     1     0     0     0     0     1     0     0     0
## seq5     1     0     0     0     0     1     0     0     1     0     0     1
## seq6     1     0     0     0     0     1     0     0     1     0     0     0
##      [,87] [,88] [,89] [,90] [,91] [,92] [,93] [,94] [,95] [,96] [,97] [,98]
## seq1     1     0     0     0     0     1     0     0     0     1     0     0
## seq2     0     0     0     1     0     0     1     0     0     0     0     1
## seq3     1     0     0     0     1     0     0     0     0     1     0     1
## seq4     1     0     0     1     0     0     1     0     0     0     0     0
## seq5     0     0     1     0     0     0     0     0     1     0     0     1
## seq6     1     0     0     0     0     1     0     0     0     1     1     0
##      [,99] [,100] [,101] [,102] [,103] [,104] [,105] [,106] [,107] [,108]
## seq1     0      1      0      0      0      1      0      0      1      0
## seq2     0      0      1      0      0      0      0      0      1      0
## seq3     0      0      0      0      1      0      0      0      1      0
## seq4     0      1      0      1      0      0      0      1      0      0
## seq5     0      0      0      0      1      0      0      0      1      0
## seq6     0      0      1      0      0      0      0      0      1      0
##      [,109] [,110] [,111] [,112] [,113] [,114] [,115] [,116] [,117] [,118]
## seq1      0      1      0      0      1      0      0      0      0      0
## seq2      0      1      0      0      1      0      0      0      1      0
## seq3      0      0      1      0      0      1      0      0      0      0
## seq4      0      0      0      1      1      0      0      0      0      0
## seq5      0      1      0      0      0      1      0      0      0      1
## seq6      0      0      0      1      0      0      1      0      0      0
##      [,119] [,120] [,121] [,122] [,123] [,124] [,125] [,126] [,127] [,128]
## seq1      1      0      0      1      0      0      1      0      0      0
## seq2      0      0      0      0      1      0      0      0      0      1
## seq3      0      1      0      1      0      0      0      1      0      0
## seq4      1      0      0      0      1      0      0      0      0      1
## seq5      0      0      0      1      0      0      0      0      0      1
## seq6      1      0      0      0      1      0      0      0      0      1
##      [,129] [,130] [,131] [,132] [,133] [,134] [,135] [,136] [,137] [,138]
## seq1      1      0      0      0      0      0      1      0      0      0
## seq2      0      1      0      0      0      1      0      0      0      0
## seq3      0      0      0      1      0      0      1      0      0      0
## seq4      1      0      0      0      1      0      0      0      0      0
## seq5      0      0      0      1      0      0      0      1      0      0
## seq6      0      0      1      0      0      0      1      0      0      1
##      [,139] [,140] [,141] [,142] [,143] [,144]    [,145]    [,146]    [,147]
## seq1      0      1      0      0      1      0 0.6477612 0.7402985 0.7910448
## seq2      0      1      0      0      1      0 0.6238806 0.5701493 0.5970149
## seq3      1      0      0      0      0      1 0.7283582 0.7522388 0.6298507
## seq4      1      0      0      1      0      0 0.8179104 0.7522388 0.5910448
## seq5      1      0      0      0      0      1 0.6716418 0.7014925 0.7791045
## seq6      0      0      0      1      0      0 0.8417910 0.6805970 0.6865672
##         [,148]    [,149]    [,150]    [,151]    [,152]    [,153]    [,154]
## seq1 0.7223881 0.7910448 0.7611940 0.4507463 0.3522388 0.3940299 0.5014925
## seq2 0.6208955 0.5820896 0.5313433 0.6567164 0.5432836 0.5014925 0.7791045
## seq3 0.5731343 0.6268657 0.6985075 0.6985075 0.6268657 0.6477612 0.7402985
## seq4 0.3940299 0.5880597 0.6179104 0.7552239 0.7701493 0.5910448 0.3940299
## seq5 0.7611940 0.5731343 0.6238806 0.7970149 0.7641791 0.5880597 0.6238806
## seq6 0.7522388 0.6298507 0.5731343 0.5880597 0.6089552 0.6985075 0.8000000
##         [,155]    [,156]    [,157]    [,158]    [,159]    [,160]    [,161]
## seq1 0.7791045 0.8089552 0.4686567 0.4537313 0.6955224 0.6805970 0.7283582
## seq2 0.8089552 0.5731343 0.5402985 0.7641791 0.8328358 0.7164179 0.7014925
## seq3 0.7552239 0.5940299 0.6238806 0.8149254 0.8328358 0.5970149 0.5970149
## seq4 0.5880597 0.5313433 0.6328358 0.8149254 0.8328358 0.7164179 0.7014925
## seq5 0.7970149 0.7641791 0.7134328 0.7104478 0.7432836 0.6388060 0.6865672
## seq6 0.5940299 0.5850746 0.6208955 0.7641791 0.8328358 0.5970149 0.5970149
##         [,162]    [,163]    [,164]    [,165]    [,166]    [,167]    [,168]
## seq1 0.8328358 0.7552239 0.4417910 0.3611940 0.3582090 0.5701493 0.7641791
## seq2 0.8029851 0.7641791 0.6597015 0.7791045 0.8805970 0.7373134 0.7343284
## seq3 0.8328358 0.7641791 0.5402985 0.4776119 0.5880597 0.8029851 0.7074627
## seq4 0.7940299 0.7522388 0.6925373 0.7402985 0.7552239 0.5940299 0.4955224
## seq5 0.9223881 0.9223881 0.8776119 0.8417910 0.6805970 0.6865672 0.7522388
## seq6 0.8328358 0.7552239 0.4417910 0.6029851 0.8955224 0.8149254 0.4865672
##         [,169]    [,170]    [,171]    [,172]    [,173]    [,174]    [,175]
## seq1 0.8746269 0.8776119 0.8417910 0.7223881 0.6656716 0.7761194 0.4985075
## seq2 0.7223881 0.6656716 0.7761194 0.4985075 0.2656716 0.4955224 0.5850746
## seq3 0.6268657 0.5253731 0.5432836 0.6567164 0.5313433 0.6179104 0.7611940
## seq4 0.6358209 0.8477612 0.8477612 0.5462687 0.4417910 0.7701493 0.8268657
## seq5 0.6298507 0.5731343 0.5880597 0.5283582 0.4686567 0.3582090 0.4985075
## seq6 0.3850746 0.7343284 0.7641791 0.5402985 0.5731343 0.8089552 0.7791045
##         [,176]    [,177]    [,178]    [,179]    [,180]    [,181]    [,182]
## seq1 0.3850746 0.8489078 0.8125000 0.4296117 0.4399272 0.6334951 0.3458738
## seq2 0.6179104 0.8834951 0.9144417 0.7226942 0.6529126 0.9751214 0.7099515
## seq3 0.6985075 0.8118932 0.7754854 0.8367718 0.8847087 0.8361650 0.8040049
## seq4 0.6447761 0.7512136 0.7754854 0.8173544 0.9077670 0.5157767 0.4071602
## seq5 0.7044776 0.9447816 0.5904126 0.6189320 0.8203883 0.8307039 0.9241505
## seq6 0.6208955 0.5916262 0.8974515 0.7724515 0.7754854 0.8367718 0.8847087
##         [,183]    [,184]    [,185]    [,186]    [,187]    [,188]    [,189]
## seq1 0.2779126 0.3598301 0.9077670 0.8343447 0.7572816 0.5703883 0.5989078
## seq2 0.6334951 0.9696602 0.8343447 0.7572816 0.5703883 0.6444175 0.7967233
## seq3 0.8040049 0.8361650 0.8489078 0.8125000 0.5406553 0.5376214 0.6559466
## seq4 0.6328883 0.7955097 0.8173544 0.9077670 0.5157767 0.4290049 0.6862864
## seq5 0.6425971 0.8076456 0.8574029 0.9241505 0.6425971 0.8076456 0.8209951
## seq6 0.8725728 0.8792476 0.8580097 0.5479369 0.5376214 0.7038835 0.8549757
##         [,190]    [,191]    [,192]    [,193]    [,194]    [,195]    [,196]
## seq1 0.9484223 0.6183252 0.6074029 0.5194175 0.5242718 0.6984223 0.4641990
## seq2 0.8234223 0.5242718 0.5175971 0.7148058 0.7457524 0.7961165 0.8209951
## seq3 0.7906553 0.5242718 0.4690534 0.4690534 0.5242718 0.8234223 0.7967233
## seq4 0.7906553 0.5242718 0.5175971 0.7148058 0.7439320 0.7754854 0.8131068
## seq5 0.8125000 0.4550971 0.3859223 0.4660194 0.4981796 0.7748786 0.7785194
## seq6 0.8234223 0.5242718 0.4690534 0.4690534 0.5242718 0.6984223 0.4641990
##         [,197]    [,198]    [,199]    [,200]    [,201]    [,202]    [,203]
## seq1 0.2487864 0.1237864 0.1650485 0.3416262 0.7712379 0.7785194 0.5916262
## seq2 0.7572816 0.5570388 0.5091019 0.5564320 0.8974515 0.7979369 0.4010922
## seq3 0.6783981 0.5109223 0.5928398 0.8246359 0.8361650 0.8513350 0.9696602
## seq4 0.8125000 0.5406553 0.5376214 0.6808252 0.9174757 0.6067961 0.6067961
## seq5 0.5916262 0.8974515 0.7724515 0.7754854 0.8367718 0.8847087 0.8725728
## seq6 0.3446602 0.3683252 0.4211165 0.3974515 0.7299757 0.5527913 0.8234223
##         [,204]    [,205]    [,206]    [,207]    [,208]    [,209]    [,210]
## seq1 0.8974515 0.7979369 0.4010922 0.3822816 0.7299757 0.3945381 0.3893085
## seq2 0.3822816 0.7548544 0.5564320 0.6747573 0.9472087 0.3951191 0.3794306
## seq3 0.6334951 0.7099515 0.9472087 0.6656553 0.7324029 0.3805927 0.6310285
## seq4 0.9083738 0.6723301 0.5643204 0.3762136 0.4605583 0.4468332 0.6583382
## seq5 0.9217233 0.9933252 0.4429612 0.2220874 0.2718447 0.3649041 0.3625799
## seq6 0.7967233 0.6444175 0.5703883 0.7572816 0.8476942 0.7042417 0.3811737
##         [,211]    [,212]    [,213]    [,214]    [,215]    [,216]    [,217]
## seq1 0.7576990 0.2562464 0.8361418 0.5136549 0.3631610 0.2068565 0.2754213
## seq2 0.4334689 0.3881464 0.3201627 0.4195235 0.3759442 0.3381755 0.2969204
## seq3 0.4218478 0.3701336 0.3794306 0.4020918 0.6101104 0.4020918 0.3962812
## seq4 0.4177804 0.3097037 0.3091226 0.2928530 0.4776293 0.6914585 0.4276583
## seq5 0.4288205 0.7205113 0.3869843 0.3904707 0.3404997 0.6821615 0.3887275
## seq6 0.3939570 0.6496223 0.4218478 0.3701336 0.3724579 0.3782684 0.3747821
##         [,218]    [,219]    [,220]    [,221]    [,222]    [,223]    [,224]
## seq1 0.2597327 0.3829169 0.6589192 0.3294596 0.3817548 0.3160953 0.4032539
## seq2 0.3829169 0.6589192 0.3370134 0.4253341 0.3858222 0.6653109 0.3649041
## seq3 0.3893085 0.7280651 0.2382336 0.4369553 0.4677513 0.6717025 0.3393376
## seq4 0.3097037 0.3091226 0.2899477 0.4601976 0.4584544 0.6717025 0.3649041
## seq5 0.3916328 0.3404997 0.6821615 0.4061592 0.3957002 0.7199303 0.2452063
## seq6 0.7158629 0.2620569 0.4218478 0.4398605 0.3991865 0.6653109 0.3393376
##         [,225]    [,226]    [,227]    [,228]    [,229]    [,230]    [,231]
## seq1 0.7960488 0.3666473 0.6891342 0.4665892 0.2667054 0.2492737 0.3126089
## seq2 0.7658338 0.4241720 0.6717025 0.3933759 0.4055782 0.6629866 0.3829169
## seq3 0.8256827 0.3393376 0.6653109 0.3858222 0.4049971 0.2963393 0.3910517
## seq4 0.7658338 0.4270773 0.6565950 0.4230099 0.4020918 0.7280651 0.2382336
## seq5 0.8553167 0.3794306 0.6769320 0.4555491 0.7007554 0.3811737 0.3939570
## seq6 0.8256827 0.3393376 0.6891342 0.4665892 0.3073794 0.3271354 0.8977339
##         [,232]    [,233]    [,234]    [,235]    [,236]    [,237]    [,238]
## seq1 0.3271354 0.7466589 0.4416037 0.7007554 0.3829169 0.3660662 0.7373620
## seq2 0.7902382 0.3829169 0.3660662 0.7373620 0.2951772 0.3131900 0.2277745
## seq3 0.6943637 0.3974433 0.3910517 0.3230680 0.3381755 0.3759442 0.4288205
## seq4 0.4288205 0.4288205 0.3602557 0.7838466 0.3474724 0.3649041 0.2597327
## seq5 0.6496223 0.4218478 0.3701336 0.3724579 0.3695526 0.3213248 0.2533411
## seq6 0.2858803 0.3335270 0.2812318 0.6484602 0.3858222 0.4253341 0.3370134
##         [,239]    [,240]    [,241]    [,242]     [,243]    [,244]     [,245]
## seq1 0.2951772 0.3486345 0.2359094 0.4050633 0.75105485 0.5344585 0.09845288
## seq2 0.3625799 0.4398605 0.3358512 0.3206751 0.37130802 0.3699015 0.65260197
## seq3 0.3335270 0.6583382 0.4607786 0.7552743 0.20393812 0.3361463 0.81434599
## seq4 0.8152237 0.3201627 0.3492156 0.6596343 0.26160338 0.3403657 0.91983122
## seq5 0.2178966 0.3422429 0.8518303 0.7974684 0.07032349 0.6019691 0.23206751
## seq6 0.6589192 0.4026729 0.3573504 0.4992968 0.04219409 0.8101266 0.20534459
##          [,246]    [,247]     [,248]     [,249]    [,250]    [,251]     [,252]
## seq1 0.57383966 0.5907173 0.69901547 0.75808720 0.2405063 0.9479606 0.32208158
## seq2 0.07594937 0.4514768 0.71026723 0.06188467 0.9029536 0.3220816 0.46272855
## seq3 0.38396624 0.3375527 0.22362869 0.33755274 0.4022504 0.7510549 0.51758087
## seq4 0.18846695 0.5752461 0.63009845 0.22925457 0.3052039 0.9198312 0.18846695
## seq5 0.74824191 0.4542897 0.03094233 0.40787623 0.7454290 0.4317862 0.03094233
## seq6 0.33614627 0.8143460 0.37693390 0.36427567 0.3403657 0.5077356 0.12658228
##         [,253]    [,254]    [,255]     [,256]    [,257]    [,258]    [,259]
## seq1 0.4627286 0.4472574 0.5836850 0.07735584 0.6343179 0.4078762 0.3811533
## seq2 0.4345992 0.5035162 0.3656821 0.45007032 0.3783404 0.3277075 0.6835443
## seq3 0.1490858 0.7398031 0.3909986 0.46694796 0.4008439 0.4978903 0.4008439
## seq4 0.5696203 0.6722925 0.3980309 0.46694796 0.3783404 0.3277075 0.6722925
## seq5 0.4078762 0.7580872 0.3417722 0.54289733 0.1209564 0.6807314 0.3656821
## seq6 0.7285513 0.3839662 0.3445851 0.45007032 0.4008439 0.4978903 0.4008439
##         [,260]    [,261]    [,262]     [,263]    [,264]    [,265]     [,266]
## seq1 0.4556962 0.5189873 0.6736990 0.80309423 0.8565401 0.6272855 0.49789030
## seq2 0.2025316 0.7524613 0.3220816 0.50070323 0.3473980 0.5879044 0.04922644
## seq3 0.4500703 0.3656821 0.5007032 0.54008439 0.6526020 0.2672293 0.36146273
## seq4 0.2067511 0.3614627 0.7454290 0.51758087 0.1490858 0.7341772 0.50070323
## seq5 0.5471167 0.6483826 0.5007032 0.04219409 0.8101266 0.2053446 0.33614627
## seq6 0.4556962 0.5189873 0.6104079 0.57946554 0.5133615 0.5597750 0.30098453
##          [,267]    [,268]     [,269]    [,270]    [,271]     [,272]    [,273]
## seq1 0.64978903 0.5007032 0.04500703 0.8241913 0.4852321 0.55836850 0.3066104
## seq2 0.82419128 0.4852321 0.55836850 0.3094233 0.5991561 0.69901547 0.4810127
## seq3 0.37974684 0.8804501 0.06188467 0.7102672 0.4542897 0.03516174 0.4486639
## seq4 0.08720113 0.4571027 0.07313643 0.5879044 0.5175809 0.49929677 0.5513361
## seq5 0.81434599 0.3769339 0.37271449 0.4303797 0.2011252 0.72433193 0.6540084
## seq6 0.52039381 0.4444444 0.36568214 0.5035162 0.4345992 0.46272855 0.3136428
##          [,274]
## seq1 0.55836850
## seq2 0.03797468
## seq3 0.48523207
## seq4 0.17299578
## seq5 0.62869198
## seq6 0.85794655
```

### Showcase of statistical machine learning application

Feature encoding of multiple sequences thus results in a feature matrix, which can be used as input for variety of statistical machine learning methods. For example, an application is the quantitative modeling of PBM derived protein-DNA binding by linear regression as demonstrated below.

First, pre-computed binding affinity values are combined with experimental information in a data frame structure.

```
fn4 <- system.file("extdata", "PBMsample_short.s", package = "DNAshapeR")
experimentalData <- read.table(fn4)
df <- data.frame(affinity=experimentalData$V1, featureVector)
```

Then, a machine learning package (which can be any learning tools) is used to train a multiple linear regression (MLR) model based on 3-fold cross-validation. In this example, we used the caret package (see <http://caret.r-forge.r-project.org/> for more information).

```
library(caret)
```

```
## Loading required package: ggplot2
```

```
## Loading required package: lattice
```

```
##
## Attaching package: 'caret'
```

```
## The following object is masked from 'package:generics':
##
##     train
```

```
trainControl <- trainControl(method = "cv", number = 3,
                savePredictions = TRUE)
model <- train (affinity~ ., data = df,
                trControl=trainControl, method="lm", preProcess=NULL)
```

```
## Warning in predict.lm(modelFit, newdata): prediction from rank-deficient fit;
## attr(*, "non-estim") has doubtful cases
```

```
model
```

```
## Linear Regression
##
## 500 samples
## 274 predictors
##
## No pre-processing
## Resampling: Cross-Validated (3 fold)
## Summary of sample sizes: 332, 334, 334
## Resampling results:
##
##   RMSE       Rsquared   MAE
##   0.2906898  0.8786293  0.2228234
##
## Tuning parameter 'intercept' was held constant at a value of TRUE
```

## Session Info

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
##  [1] caret_7.0-1          lattice_0.22-7       ggplot2_4.0.0
##  [4] Biostrings_2.78.0    XVector_0.50.0       fields_17.1
##  [7] RColorBrewer_1.1-3   viridisLite_0.4.2    spam_2.11-1
## [10] DNAshapeR_1.38.0     GenomicRanges_1.62.0 Seqinfo_1.0.0
## [13] IRanges_2.44.0       S4Vectors_0.48.0     BiocGenerics_0.56.0
## [16] generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1     timeDate_4051.111    dplyr_1.1.4
##  [4] farver_2.1.2         S7_0.2.0             fastmap_1.2.0
##  [7] pROC_1.19.0.1        digest_0.6.37        rpart_4.1.24
## [10] dotCall64_1.2        timechange_0.3.0     lifecycle_1.0.4
## [13] survival_3.8-3       magrittr_2.0.4       compiler_4.5.1
## [16] rlang_1.1.6          sass_0.4.10          tools_4.5.1
## [19] yaml_2.3.10          data.table_1.17.8    knitr_1.50
## [22] plyr_1.8.9           withr_3.0.2          purrr_1.1.0
## [25] nnet_7.3-20          grid_4.5.1           future_1.67.0
## [28] globals_0.18.0       scales_1.4.0         iterators_1.0.14
## [31] MASS_7.3-65          dichromat_2.0-0.1    cli_3.6.5
## [34] rmarkdown_2.30       crayon_1.5.3         future.apply_1.20.0
## [37] reshape2_1.4.4       cachem_1.1.0         stringr_1.5.2
## [40] splines_4.5.1        maps_3.4.3           parallel_4.5.1
## [43] vctrs_0.6.5          hardhat_1.4.2        Matrix_1.7-4
## [46] jsonlite_2.0.0       listenv_0.9.1        foreach_1.5.2
## [49] gower_1.0.2          jquerylib_0.1.4      recipes_1.3.1
## [52] glue_1.8.0           parallelly_1.45.1    codetools_0.2-20
## [55] lubridate_1.9.4      stringi_1.8.7        gtable_0.3.6
## [58] tibble_3.3.0         pillar_1.11.1        htmltools_0.5.8.1
## [61] ipred_0.9-15         lava_1.8.1           R6_2.6.1
## [64] evaluate_1.0.5       bslib_0.9.0          class_7.3-23
## [67] Rcpp_1.1.0           nlme_3.1-168         prodlim_2025.04.28
## [70] xfun_0.53            ModelMetrics_1.2.2.2 pkgconfig_2.0.3
```

## References

Chiu, T.P., et al. GBshape: a genome browser database for DNA shape annotations. Nucleic Acids Res 2015.

Comoglio, F., et al. High-resolution profiling of Drosophila replication start sites reveals a DNA shape and chromatin signature of metazoan origins. Cell reports 2015;11(5):821-834.

Yang, L., et al. TFBSshape: a motif database for DNA shape features of transcription factor binding sites. Nucleic Acids Res 2014;42 (Database issue):D148-155.

Zhou, T., et al. DNAshape: a method for the high-throughput prediction of DNA structural features on a genomic scale. Nucleic Acids Res 2013;41 (Web Server issue):W56-62.

If you use DNAshapeR for your work, please cite the following publication:

Chiu, T-P., et al. DNAshapeR: an R/Bioconductor package for DNA shape prediction and feature encoding (2016).