# Consensus and differential peak calling with epigraHMM

Pedro L. Baldoni, Naim U. Rashid and Joseph G. Ibrahim

#### 10/29/2025

#### Abstract

A fundamental task in the analysis of data resulting from epigenomic sequencing assays is the detection of genomic regions with significant or differential sequencing read enrichment. epigraHMM provides set of tools to flexibly analyze data from a wide range of high-throughput epigenomic assays (ChIP-seq, ATAC-seq, DNase-seq, etc.) in an end-to-end pipeline. It includes functionalities for data pre-processing, normalization, consensus and differential peak detection, as well as data visualization. In differential analyses, epigraHMM can detect differential peaks across either multiple conditions of a single epigenomic mark (differential peak calling) or across multiple epigenomic marks from a single condition (genomic segmentation). The data pre-processing steps are heavily integrated with other Bioconductor packages and allow the user to transform sequencing/alignment files into count matrices that are suitable for the final analysis of the data.
The current implementation is optimized for genome-wide analyses of epigenomic data and is efficient for the analysis under multi-sample multiple-condition settings, as well as consensus peak calling in multi-sample single-condition settings. epigraHMM uses two modified versions of hidden Markov models (HMM) that are robust to the diversity of peak profiles found in epigenomic data and are particularly useful for epigenomic marks that exhibit short and broad peaks. Analyses can be adjusted for possible technical artifacts present in the data and for input control experiments, if available. Results from the peak calling algorithms can be assessed using some of the available tools for visualization that allow the inspection of detected peaks and read counts.
epigraHMM package version: 1.18.0

#### Package

epigraHMM 1.18.0

# 1 Workflow

## 1.1 How to cite epigraHMM

If you use epigraHMM in published research for *consensus* peak calling of epigenomic data, please cite:

> Baldoni, PL, Rashid, NU, Ibrahim, JG. Improved detection of epigenomic marks with mixed‐effects hidden Markov models. Biometrics. 2019; 75: 1401–1413. <https://doi.org/10.1111/biom.13083>

If epigraHMM is used in published research for *differential* peak calling of epigenomic data, please cite:

> Baldoni, PL, Rashid, NU, Ibrahim, JG. Efficient Detection and Classification of Epigenomic Changes Under Multiple Conditions. Biometrics (in press). <https://doi.org/10.1111/biom.13477>

## 1.2 How to get help for epigraHMM

Exported functions from epigraHMM are fully documented. Users looking for help for a particular epigraHMM function can use the standard R help, such as `help(epigraHMM)`. Questions, bug reports, and suggestions can be sent directly to the authors through the Bioconductor support site <https://support.bioconductor.org>. Guidelines for posting on the support site can be found at <http://www.bioconductor.org/help/support/posting-guide>. Users should not request support via direct email to the authors.

## 1.3 Quick start

The code chunk below presents the main steps of the analysis of epigenomic data using epigraHMM. epigraHMM imports functions from `GenomicRanges` and `SummarizedExperiment` for its internal computations. We will use some of these imported functions in this vignette to demonstrate the utilization of epigraHMM. Therefore, we load these two packages explicitly here. In this vignette, we utilize ChIP-seq data from the Bioconductor package `chromstaRData`.

```
library(GenomicRanges)
library(epigraHMM)
library(SummarizedExperiment)

# Creating input for epigraHMM
bamFiles <- system.file(package="chromstaRData","extdata","euratrans",
                        c("lv-H3K27me3-BN-male-bio2-tech1.bam",
                          "lv-H3K27me3-BN-male-bio2-tech2.bam"))

colData <- data.frame(condition = c('BN','BN'),replicate = c(1,2))

# Creating epigraHMM object
object <- epigraHMMDataSetFromBam(bamFiles = bamFiles,
                                  colData = colData,
                                  genome = 'rn4',
                                  windowSize = 1000,
                                  gapTrack = TRUE)

# Creating normalizing offsets
object <- normalizeCounts(object = object,
                          control = controlEM())

# Initializing epigraHMM
object <- initializer(object = object,
                      control = controlEM())

# Running epigraHMM for consensus peak detection
object <- epigraHMM(object = object,
                    control = controlEM(),
                    type = 'consensus')

# Calling peaks with FDR control of 0.05
peaks <- callPeaks(object = object,
                   control = controlEM(),
                   method = 0.05)
```

## 1.4 Data input

epigraHMM takes as data input either a matrix of non-negative counts or binary alignment map (BAM) files. Regardless of the choice of input format, epigraHMM allows the user to input data from both epigenomic experiments (e.g. ChIP-seq, ATAC-seq) and controls (e.g. controls without immunoprecipitation). To input data in the count matrix format, users should use the function `epigraHMMDataSetFromMatrix`. Alternatively, users may use the function `epigraHMMDataSetFromBam` to input data in the BAM format.

Either way, the output will be an *epigraHMMDataSet* object that is used to store the input data, the model offsets, and the results from the peak calling algorithms. Specifically, *epigraHMMDataSet* is a [RangedSummarizedExperiment](https://bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html) from which one can access the information about genomic coordinates and samples with the functions `rowRanges` and `colData`. Counts from epigenomic experiments are stored in the *epigraHMMDataSet*’s assay ‘counts’.

### 1.4.1 Count matrix input

For input matrices, counts should be organized in a ‘features by samples’ format, i.e., rows represent genomic coordinates and columns represent samples. One can use the function `epigraHMMDataSetFromMatrix` to create an *epigraHMMDataSet* from matrices of read counts, which takes as input a matrix (or list of matrices) of non-negative integers (argument `countData`), a *data.frame* with the information about the samples (argument `colData`), and an optional *GRanges* object with the genomic coordinates associated with the matrix of counts (argument `rowRanges`).

If `countData` is a list of matrices, `countData` must be a named list and contain (at least) a matrix `counts` of read counts pertaining to the epigenomic experiment of interest (ChIP-seq, ATAC-seq, etc.). If additional matrices are included in the `countData` list, they can have any desired name such as `gc` and `controls`, for example111 Users interested in accounting for input control samples when calling consensus peaks should include a named matrix of reads counts `controls` in the list `countData`. epigraHMM will search for a `controls` matrix in the input data and include input control counts in the linear model, if present..

The input `colData` must contain variables named as **condition** and **replicate**. The variable condition refers to the experimental condition identifier (e.g. cell line name). The variable replicate refers to the replicate identification number (unique for each condition). Additional columns included in the `colData` input will be passed to the resulting epigraHMMDataSet object and can be accessed via `colData` function.

```
countData <- list('counts' = matrix(rpois(4e5,10),ncol = 4),
                  'controls' = matrix(rpois(4e5,5),ncol = 4))

colData <- data.frame(condition = c('A','A','B','B'),
                      replicate = c(1,2,1,2))

rowRanges <- GRanges('chrA',IRanges(start = seq(1,by = 500, length.out = 1e5),
                                    width = 500))

object_matrix <- epigraHMMDataSetFromMatrix(countData = countData,
                                            colData = colData,
                                            rowRanges = rowRanges)

object_matrix
```

```
## class: RangedSummarizedExperiment
## dim: 100000 4
## metadata(0):
## assays(3): counts offsets controls
## rownames: NULL
## rowData names(0):
## colnames(4): A.1 A.2 B.1 B.2
## colData names(2): condition replicate
```

### 1.4.2 Alignment file input

One can use the function `epigraHMMDataSetFromBam` to create an *epigraHMMDataSet* from a set of alignment files in BAM format (argument `bamFiles`). Additional inputs include a *data.frame* with the information about the samples (argument `colData`), the reference genome of interest (argument `genome`), the size of the genomic windows where read counts will be computed (argument `windowSize`), and optional logicals indicating whether to exclude genomic coordinates associated with either gap or blacklisted regions (arguments `gapTrack` and `blackList`; Amemiya, Kundaje, and Boyle ([2019](#ref-amemiya2019encode)))222 These arguments can also be *GRanges* objects (see below for details).

The input argument `bamFiles` specifies the path to the experimental files in BAM format. `bamFiles` can be either a character vector or a named list of character vectors with the path for BAM files. If `bamFiles` is a list of character vectors, it must be a named list and contain (at least) a character vector `counts` pertaining to the path of the epigenomic experiment of interest (ChIP-seq, ATAC-seq, etc.). If additional character vectors are included in the `bamFiles` list, they can have any desired name such as `controls`, for example333 Users interested in accounting for input control samples when calling consensus peaks should include a named character vector `controls` in the list `bamFiles` indicating the path to the input control BAM files. epigraHMM will search for a `controls` character vector in the input data and include input control counts in the linear model, if present.. The alignment index ‘.bai’ files must be stored in the same directory of their respective BAM files and must be named after their respective BAM files with the additional ‘.bai’ suffix. When computing read counts, the fragment length will be estimated using [csaw](https://bioconductor.org/packages/release/bioc/html/csaw.html) cross-correlation analysis with default parameters after discarding any gap or black listed regions.

The input `colData` must contain variables named as **condition** and **replicate**. The variable condition refers to the experimental condition identifier (e.g. cell line name). The variable replicate refers to the replicate identification number (unique for each condition). Additional columns included in the `colData` input will be passed to the resulting *epigraHMMDataSet* object and can be accessed via `colData` function.

The input `genome` can be either a single string with the name of the reference genome (e.g. ‘hg19’) or a *GRanges* object with the chromosome lengths of the reference genome. By default, the function `epigraHMMDataSetFromBam` calls [Seqinfo::Seqinfo](https://bioconductor.org/packages/release/bioc/html/Seqinfo.html) to fetch the chromosome lengths of the specified genome. See `?Seqinfo::fetchExtendedChromInfoFromUCSC` for the list of UCSC genomes that are currently supported. The input `windowSize` must be an integer value specifying the size of genomic windows where read counts will be computed.

#### 1.4.2.1 About gap and blacklisted regions

By default, epigraHMM will exclude regions that overlap any genomic position intersecting gap and blacklisted regions as follows.

If the optional `gapTrack = TRUE` (default) and the name of a reference genome is passed as input through `genome` (e.g. ‘hg19’), `epigraHMMDataSetFromBam` will discard any genomic coordinate overlapping regions specified by the respective [UCSC gap table](https://genome.ucsc.edu/cgi-bin/hgTables). If `gapTrack` is a *GRanges* object, the function will discard any genomic coordinate overlapping regions of `gapTrack`.

If the optional `blackList = TRUE` (default) and the name of a reference genome is passed as input through `genome` (e.g. ‘hg19’), `epigraHMMDataSetFromBam` will fetch the curated [ENCODE blacklist tracks](https://sites.google.com/site/anshulkundaje/projects/blacklists) from the Bioconductor package [GreyListChIP](https://bioconductor.org/packages/release/bioc/html/GreyListChIP.html). Current available genomes are those supported by GreyListChIP and include worm (‘ce10’ and ‘ce11’), fly (‘dm3’ and ‘dm6’), human (‘hg19’ and ‘hg38’), and mouse (‘mm9’ and ‘mm10’). If `blackList` is a *GRanges* object, the function will discard any genomic coordinate overlapping regions from `blackList`.

```
# Creating input for epigraHMM
bamFiles <- system.file(package="chromstaRData","extdata","euratrans",
                        c("lv-H3K4me3-SHR-male-bio2-tech1.bam",
                          "lv-H3K4me3-SHR-male-bio3-tech1.bam"))

colData <- data.frame(condition = c('SHR','SHR'),
                      replicate = c(1,2))

# Creating epigraHMM object
object_bam <- epigraHMMDataSetFromBam(bamFiles = bamFiles,
                                      colData = colData,
                                      genome = 'rn4',
                                      windowSize = 250,
                                      gapTrack = TRUE)

object_bam
```

```
## class: RangedSummarizedExperiment
## dim: 162657 2
## metadata(0):
## assays(2): counts offsets
## rownames: NULL
## rowData names(0):
## colnames(2): SHR.1 SHR.2
## colData names(3): condition replicate fragLength
```

## 1.5 Data normalization

The function `normalizeCounts` implements a non-linear normalization via model offsets. It takes as input either an *epigraHMMDataSet* object or a matrix of non-negative read counts (input `object`). Specifically, the normalization method is based on a loess smoothing fit comparing the difference (M from MA plot) and average (A from MA plot) of each sample (log-transformed counts + 1) with a reference sample created as the row-wise log-transformed geometric mean. Here, the resulting loess smoothing fit is used as an offset term in the epigraHMM model. We strongly recommend users to utilize `normalizeCounts` in their analyses as epigenomic data sets are often subject to non-linear biases. That is, local differences in read count distribution between samples vary with the overall local read abundance (Lun and Smyth [2015](#ref-lun2015csaw)).

The current implementation in epigraHMM uses the function `loessFit` from [limma](https://www.bioconductor.org/packages/release/bioc/html/limma.html) in a similar fashion to `csaw::normOffsets`. Users might pass further arguments to *loessFit* through the three dot ellipsis `...`. For instance, users might find useful to try different proportions of the data to be used in the local regression window (argument `span`, a positive value between 0 and 1, with larger numbers giving smoother fits). We find that `span=1` (default) in *normalizeCounts* gives the best results in both broad and short epigenomic marks (Baldoni, Rashid, and Ibrahim [2021](#ref-baldoni2019efficient)).

```
# Normalizing counts
object_normExample <- object_bam
object_normExample <- normalizeCounts(object_normExample,control = controlEM())

normCts <- as.matrix(assay(object_normExample)/
                       exp(assay(object_normExample,'offsets')))

# Summary of raw counts
summary(assay(object_normExample))
```

```
##      SHR.1             SHR.2
##  Min.   :  0.000   Min.   :  0.000
##  1st Qu.:  0.000   1st Qu.:  0.000
##  Median :  0.000   Median :  1.000
##  Mean   :  2.056   Mean   :  4.751
##  3rd Qu.:  1.000   3rd Qu.:  2.000
##  Max.   :208.000   Max.   :247.000
```

```
colSums(assay(object_normExample))/1e5
```

```
##   SHR.1   SHR.2
## 3.34471 7.72821
```

```
# Summary of normalized counts
summary(normCts)
```

```
##      SHR.1             SHR.2
##  Min.   :  0.000   Min.   :  0.0000
##  1st Qu.:  0.000   1st Qu.:  0.0000
##  Median :  0.000   Median :  0.8041
##  Mean   :  2.899   Mean   :  3.1285
##  3rd Qu.:  1.289   3rd Qu.:  1.4816
##  Max.   :276.867   Max.   :173.1898
```

```
colSums(normCts)/1e5
```

```
##    SHR.1    SHR.2
## 4.715501 5.088707
```

### 1.5.1 Other types of normalization (e.g. GC-content and control assays)

epigraHMM allows users to input their own normalization offsets via `addOffsets`, which simply adds an input matrix of normalizing offsets to a given *epigraHMMDataSet*. For users interested in adjusting their analyses with both `addOffsets` *and* `normalizeCounts`, we recommend `normalizeCounts` to be used as the **last** normalization step just prior to peak calling. This is because `normalizeCounts` will normalize counts while considering any already existing offsets (such as those from GC-content normalizing offsets, see below) in the *epigraHMMDataSet* object.

The function `addOffsets` can be useful for users that may want to adjust their analyses for GC-content bias, for example. GC-content normalizing offsets could be obtained from Bioconductor packages such as [gcapc](https://doi.org/doi%3A10.18129/B9.bioc.gcapc).

Note that, in the example below, `gcapc::refineSites` will fetch data from the Bioconductor package [BSgenome.Rnorvegicus.UCSC.rn4](https://doi.org/doi%3A10.18129/B9.bioc.BSgenome.Rnorvegicus.UCSC.rn4), which must be installed locally. For users interested in utilizing `gcapc` for GC-content normalization, we strongly recommend them to follow the suggested analysis steps from the authors’ [vignette](https://bioconductor.org/packages/release/bioc/vignettes/gcapc/inst/doc/gcapc.html).

```
library(gcapc)
library(BSgenome.Rnorvegicus.UCSC.rn4)

# Toy example of utilization of gcapc for GC-content normalization with model offsets
# See ?gcapc::refineSites for best practices

# Below, subset object_bam simply to illustrate the use of `gcapc::refineSites`
# with epigraHMM
object_gcExample <- object_bam[2e4:5e4,]

gcnorm <- gcapc::refineSites(counts = assay(object_gcExample),
                             sites = rowRanges(object_gcExample),
                             gcrange = c(0,1),
                             genome = 'rn4')
```

```
# gcapc::refineSites outputs counts/2^gce
gcnorm_offsets <- log2((assay(object_gcExample) + 1) / (gcnorm + 1))

# Adding offsets to epigraHMM object
object_gcExample <- addOffsets(object = object_gcExample,
                               offsets = gcnorm_offsets)
```

We note that `addOffsets` will add offsets to any existing offset assay contained in *epigraHMMDataSet*. That is, in the example above, the resulting offsets from the output of `addOffsets(object_gcExample,offsets = gcnorm_offsets)` will be equal to `assay(object_gcExample,'offsets') + gcnorm_offsets`.

Alternatively, epigraHMM may account for input control experiments when calling significant regions of enrichment of a given condition. To this end, epigraHMM directly models the effect of input control read counts in its HMM-embedded generalized linear model. Users interested in utilizing input control experiments in their analyses should pass either matrices of read counts or the paths to the control BAM files in the ‘controls’ entry of the input list *bamFiles* as below. To speed up the computing time, I utilize a window size of 1000 base pairs.

```
# Creating input for epigraHMM
bamFiles <- list('counts' = system.file(package="chromstaRData",
                                        "extdata","euratrans",
                                        "lv-H4K20me1-BN-male-bio1-tech1.bam"),
                 'controls' = system.file(package="chromstaRData",
                                          "extdata","euratrans",
                                          "lv-input-BN-male-bio1-tech1.bam"))

colData <- data.frame(condition = 'BN',replicate = 1)

# Creating epigraHMM object
object_bam <- epigraHMMDataSetFromBam(bamFiles = bamFiles,
                                      colData = colData,
                                      genome = 'rn4',
                                      windowSize = 1000,
                                      gapTrack = TRUE)

object_bam
```

```
## class: RangedSummarizedExperiment
## dim: 38778 1
## metadata(0):
## assays(3): counts offsets controls
## rownames: NULL
## rowData names(0):
## colnames(1): BN.1
## colData names(3): condition replicate fragLength
```

## 1.6 Peak calling

Peak calling, either consensus or differential, is performed in epigraHMM through the function `epigraHMM`. It takes as input an *epigraHMMDataSet* (argument `object`), a list of control parameters (argument `control`), the type of peak calling (argument `type`), and the distributional assumption for the data (argument `dist`).

The argument `object` passes the *epigraHMMDataSet* to the peak calling algorithms. If either controls experiments or normalization offsets are included in the input `object`, they will be used in the analysis. Specifically, `epigraHMM` directly models controls as a covariate in the count mean model in consensus peak calling.

Users can specify the type of peak calling, either consensus or differential, via the argument `type`. If `type='consensus'`, `epigraHMM` will detect enrichment regions in consensus across technical or biological replicates. It assumes that all available data stored in the *epigraHMMDataSet* is generated under the same experimental conditions (e.g. unique cell line) and the genome can be segmented into either consensus background or consensus enrichment regions. If `type='differential'`, `epigraHMM` will detect differential enrichment regions across technical or biological replicates from multiple conditions (e.g. several cell lines or knockout versus wild-type). In this case, it will assume that the genome can be segmented into regions of either consensus background, differential, or consensus enrichment.

The argument `dist` specifies the probabilistic distribution for the experimental counts. The distribution can be either zero-inflated negative binomial (ZINB; `dist='zinb'`) or a negative binomial model (NB; `dist='nb'`). If `dist='zinb'`, counts from the consensus background (enrichment) hidden Markov model (HMM) state will be modeled with a ZINB (NB). If `dist='nb'`, both consensus enrichment and background will be modeled with a NB distribution. For specific details of the model, we refer users to our publications (Baldoni, Rashid, and Ibrahim [2019](#ref-baldoni2019improved)) and (Baldoni, Rashid, and Ibrahim [2021](#ref-baldoni2019efficient)). We recommend users to specify `dist='zinb'` if consensus peak calling is of interest, as we found the ZINB to give better results in this setting. Minor differences between ZINB and NB models were observed in differential peak calling. No significant differences in computing time were observed between the ZINB and NB model specifications.

The `control` argument should be a list of parameter specifications generated from the function `controlEM`. Possible tuning parameters from `controlEM` include the maximum number of EM algorithm iterations, the convergence criteria, the option to print log messages during the EM algorithm, etc. We recommend users to read the manual via `?controlEM` for all parameter specifications. For any standard analysis, either consensus or differential peak calling, we recommend users to simply pass `control=controlEM()` to *epigraHMM*.

### 1.6.1 Multi-sample single-condition analysis

If one is interested in detecting consensus peaks across multiple samples (or simply detecting peaks from a single-sample) of the same condition, epigraHMM can be used with the option `type = 'consensus'` as below. To speed up the computing time, I utilize a window size of 1000 base pairs.

```
# Creating input for epigraHMM
bamFiles <- system.file(package="chromstaRData","extdata","euratrans",
                        c("lv-H3K27me3-BN-male-bio2-tech1.bam",
                          "lv-H3K27me3-BN-male-bio2-tech2.bam"))

colData <- data.frame(condition = c('BN','BN'),
                      replicate = c(1,2))

# Creating epigraHMM object
object_consensus <- epigraHMMDataSetFromBam(bamFiles = bamFiles,
                                            colData = colData,
                                            genome = 'rn4',
                                            windowSize = 1000,
                                            gapTrack = TRUE)

# Normalizing counts
object_consensus <- normalizeCounts(object_consensus,
                                    control = controlEM())

# Initializing epigraHMM
object_consensus <- initializer(object_consensus,controlEM())

# Differential peak calling
object_consensus <- epigraHMM(object = object_consensus,
                              control = controlEM(),
                              type = 'consensus',
                              dist = 'zinb')
```

### 1.6.2 Multi-sample, multiple-condition analysis

If one is interested in detecting differential peaks across multiple samples collected under different conditions, epigraHMM can be used with the option `type = 'differential'` as below. Note that it is not mandatory for experimental conditions to have more than one technical or biological replicates. In principle, epigraHMM is able to call differential peaks under single-sample multi-condition designs. However, users are strongly encouraged to utilized as many technical/biological replicates per condition as possible in their analyses. epigraHMM provides better performance regarding sensitivity and false discovery rate (FDR) control when more replicates are utilized (see Web Figures 13-15 in (Baldoni, Rashid, and Ibrahim [2021](#ref-baldoni2019efficient))). To speed up the computing time, I utilize a window size of 1000 base pairs.

```
# Creating input for epigraHMM
bamFiles <- system.file(package="chromstaRData","extdata","euratrans",
                        c("lv-H3K27me3-BN-male-bio2-tech1.bam",
                          "lv-H3K27me3-BN-male-bio2-tech2.bam",
                          "lv-H3K27me3-SHR-male-bio2-tech1.bam",
                          "lv-H3K27me3-SHR-male-bio2-tech2.bam"))

colData <- data.frame(condition = c('BN','BN','SHR','SHR'),
                      replicate = c(1,2,1,2))

# Creating epigraHMM object
object_differential <- epigraHMMDataSetFromBam(bamFiles = bamFiles,
                                               colData = colData,
                                               genome = 'rn4',
                                               windowSize = 1000,
                                               gapTrack = TRUE)

# Normalizing counts
object_differential <- normalizeCounts(object_differential,
                                       control = controlEM())

# Initializing epigraHMM
object_differential <- initializer(object_differential,controlEM())

# Differential peak calling
object_differential <- epigraHMM(object = object_differential,
                                 control = controlEM(),
                                 type = 'differential')
```

### 1.6.3 Calling peaks

Consensus or differential peaks can be called with epigraHMM’s `callPeaks` function, which takes as input the *epigraHMM* object output (argument `object`). By default, the most likely (consensus or differential) peak regions are presented by `callPeaks`, which utilizes the Viterbi algorithm to this end. Alternatively, users may want to specify a particular FDR control thresholding level through the argument `method`. For example `method = 0.05` requests `callPeaks` to define peak regions while controlling for the FDR of 0.05 on the window level. Neighboring significant windows that pass a given FDR threshold level are merged to form consensus or differential regions of enrichment.

```
peaks_consensus <- callPeaks(object = object_consensus)
peaks_consensus
```

```
## GRanges object with 7 ranges and 1 metadata column:
##       seqnames            ranges strand |        name
##          <Rle>         <IRanges>  <Rle> | <character>
##   [1]    chr12   1756001-1774000      * |       peak1
##   [2]    chr12 19888001-19892000      * |       peak2
##   [3]    chr12 19899001-19909000      * |       peak3
##   [4]    chr12 19976001-19991000      * |       peak4
##   [5]    chr12 20041001-20050000      * |       peak5
##   [6]    chr12 20057001-20061000      * |       peak6
##   [7]    chr12 20571001-20576000      * |       peak7
##   -------
##   seqinfo: 45 sequences (1 circular) from rn4 genome
```

```
peaks_differential <- callPeaks(object = object_differential)
peaks_differential
```

```
## GRanges object with 7 ranges and 1 metadata column:
##       seqnames            ranges strand |        name
##          <Rle>         <IRanges>  <Rle> | <character>
##   [1]    chr12   1756001-1774000      * |       peak1
##   [2]    chr12 19888001-19892000      * |       peak2
##   [3]    chr12 19899001-19909000      * |       peak3
##   [4]    chr12 19976001-19991000      * |       peak4
##   [5]    chr12 20041001-20050000      * |       peak5
##   [6]    chr12 20057001-20061000      * |       peak6
##   [7]    chr12 20571001-20576000      * |       peak7
##   -------
##   seqinfo: 45 sequences (1 circular) from rn4 genome
```

## 1.7 Data visualization

### 1.7.1 Plotting peak tracks

Peaks can be visualized with the epigraHMM function `plotCounts`, which accepts annotation tracks to be included in the output plot. Below, we show an example on how to visualize peaks calls.

First, we will fetch the UCSC gene bodies from the rn4 genome. They will be then transformed into a GRanges object to be used by epigraHMM as an annotation track.

```
library(GenomicRanges)
library(rtracklayer)
library(Seqinfo)

session <- browserSession()
genome(session) <- 'rn4'
refSeq <- getTable(ucscTableQuery(session, table = "refGene"))

annotation <- makeGRangesFromDataFrame(refSeq,
                                       starts.in.df.are.0based = TRUE,
                                       seqnames.field = 'chrom',
                                       start.field = 'txStart',
                                       end.field = 'txEnd',
                                       strand.field = 'strand',
                                       keep.extra.columns = TRUE)
```

To visualize the consensus or differential peak calls, one needs to provide the output of `epigraHMM` (argument `object`), the genomic coordinates to be visualized (argument `ranges`), the set of peak calls (argument `peaks`, optional), and the annotation track (argument `annotation`, optional). The resulting plot will display the peak track, the annotation track, the normalized read counts, and the posterior probabilities associated with either consensus enrichment (for consensus peaks) or differential enrichment (for differential peaks). Read counts are normalized with the normalizing offsets contained in the `epigraHMM` output object.

```
plotCounts(object = object_consensus,
           ranges = GRanges('chr12',IRanges(19500000,20000000)),
           peaks = peaks_consensus,
           annotation = annotation)
```

![](data:image/png;base64...)
Below, we have an example of differential peak calls between conditions BN and SHR for the histone modification mark H3K27me3.

```
plotCounts(object = object_differential,
           ranges = GRanges('chr12',IRanges(19500000,20100000)),
           peaks = peaks_differential,
           annotation = annotation)
```

![](data:image/png;base64...)

### 1.7.2 Heatmap with posterior probabilities of differential enrichment

epigraHMM uses a mixture model embedded into one of its hidden Markov model states to encode all possible combinatorial patterns of enrichment across multiple conditions. It is often of interest to determine not only whether a peak is differential or not, but also to classify its association with enrichment to a particular treatment condition or any combination of them. For example, in the example above, one may want to determine whether a differential peak is actually representing an enrichment of read counts in the SHR condition alone. In a more general example with three conditions, one may want to determine which combinatorial pattern out of all six possible patterns of differential enrichment (\(2^3 -2\)) is the one associated with a differential peak.

epigraHMM provides the function `plotPatterns`, which plots a heatmap with the posterior probabilities associated with each mixture model component from the HMM-embedded epigraHMM’s mixture model. In the example below, we are interested in determining the direction of enrichment between the BN and SHR conditions of the third differential peak (from left to right) illustrated in the figure of the previous section.

```
# Selecting target differential peak
pattern_peak <- peaks_differential[peaks_differential$name == 'peak4']

pattern_peak
```

```
## GRanges object with 1 range and 1 metadata column:
##       seqnames            ranges strand |        name
##          <Rle>         <IRanges>  <Rle> | <character>
##   [1]    chr12 19976001-19991000      * |       peak4
##   -------
##   seqinfo: 45 sequences (1 circular) from rn4 genome
```

```
plotPatterns(object = object_differential,
             ranges = pattern_peak,
             peaks = peaks_differential)
```

![](data:image/png;base64...)
In the heatmap plot above, the row-wise sum of posterior probabilities (cells of the heatmap) is always equal to 1. For this particular example, genomic windows from the third differential peak (from left to right) of the output from `plotCounts` are all associated with differential enrichment of read counts in condition SHR alone. In a more general scenario, with three or more conditions (\(G>2\)), for example, the heatmap would exhibit up to \(2^3 -2\) differential combinatorial patterns.

Alternatively, one could also be interested in the second differential peak from the figure of the previous section (from left to right). In this case, the differential peak is formed by genomic windows mostly associated with read count enrichment in condition BN only.

```
# Selecting target differential peak
pattern_peak <- peaks_differential[peaks_differential$name == 'peak3']

pattern_peak
```

```
## GRanges object with 1 range and 1 metadata column:
##       seqnames            ranges strand |        name
##          <Rle>         <IRanges>  <Rle> | <character>
##   [1]    chr12 19899001-19909000      * |       peak3
##   -------
##   seqinfo: 45 sequences (1 circular) from rn4 genome
```

```
plotPatterns(object = object_differential,
             ranges = pattern_peak,
             peaks = peaks_differential)
```

![](data:image/png;base64...)

## 1.8 Miscellaneous

### 1.8.1 Posterior probabilities and associated differential enrichment

The combinatorial patterns associated with each of the mixture components can be accessed from the output object itself as below with the function `info`.

```
# Getting object information
info(object_differential)
```

```
## $BIC
## [1] 939300.1
##
## $logLikelihood
## [1] -470798.8
##
## $Components
## DataFrame with 2 rows and 3 columns
##   Component  Enrichment PosteriorProportion
##   <integer> <character>           <numeric>
## 1         1          BN             0.72761
## 2         2         SHR             0.27239
```

Because we are assessing the enrichment of reads between only two conditions in this particular example, the only possible differential combinatorial patterns are either enrichment in BN condition only (mixture component 1) or enrichment in SHR condition only (mixture component 2).

To extract the differential combinatorial patterns (or posterior probabilities) associated with differential regions, one can use the function `callPatterns` as below.

```
# Getting posterior probabilties
callPatterns(object = object_differential,peaks = peaks_differential,type = 'all')
```

```
## GRanges object with 65 ranges and 2 metadata columns:
##        seqnames            ranges strand |          BN         SHR
##           <Rle>         <IRanges>  <Rle> |   <numeric>   <numeric>
##    [1]    chr12   1756001-1757000      * |    1.000000 1.01225e-07
##    [2]    chr12   1757001-1758000      * |    1.000000 1.72848e-14
##    [3]    chr12   1758001-1759000      * |    0.999907 9.33697e-05
##    [4]    chr12   1759001-1760000      * |    0.999996 3.74708e-06
##    [5]    chr12   1760001-1761000      * |    1.000000 3.10946e-09
##    ...      ...               ...    ... .         ...         ...
##   [61]    chr12 20571001-20572000      * | 8.10935e-06    0.999992
##   [62]    chr12 20572001-20573000      * | 9.61913e-10    1.000000
##   [63]    chr12 20573001-20574000      * | 3.71032e-05    0.999963
##   [64]    chr12 20574001-20575000      * | 1.51645e-08    1.000000
##   [65]    chr12 20575001-20576000      * | 1.03830e-07    1.000000
##   -------
##   seqinfo: 45 sequences (1 circular) from rn4 genome
```

Instead, one can directly obtain the most likely specific differential pattern associated with the differential regions.

```
# Getting most likely differential enrichment
callPatterns(object = object_differential,peaks = peaks_differential,type = 'max')
```

```
## GRanges object with 65 ranges and 1 metadata column:
##        seqnames            ranges strand |  Enrichment
##           <Rle>         <IRanges>  <Rle> | <character>
##    [1]    chr12   1756001-1757000      * |          BN
##    [2]    chr12   1757001-1758000      * |          BN
##    [3]    chr12   1758001-1759000      * |          BN
##    [4]    chr12   1759001-1760000      * |          BN
##    [5]    chr12   1760001-1761000      * |          BN
##    ...      ...               ...    ... .         ...
##   [61]    chr12 20571001-20572000      * |         SHR
##   [62]    chr12 20572001-20573000      * |         SHR
##   [63]    chr12 20573001-20574000      * |         SHR
##   [64]    chr12 20574001-20575000      * |         SHR
##   [65]    chr12 20575001-20576000      * |         SHR
##   -------
##   seqinfo: 45 sequences (1 circular) from rn4 genome
```

### 1.8.2 Selecting the optimal number of differential combinatorial patterns of enrichment

A central question when performing a genomic segmentation analysis is: how are the epigenomic marks being analyzed co-occurring across the genome? Answering this question not only allows one to make better sense of the biology behind the statistical analysis, but also provides a way to simplify the interpretation of the final results. With epigraHMM, this question can be rephrased as: what are the most common differential combinatorial patterns of local read enrichment observed in the data?

By default, epigraHMM will model every possible differential combinatorial pattern of enrichment for a given set of epigenomic marks. However, it is possible to request epigraHMM to ‘prune’ combinatorial patterns of enrichment that are not often observed across the genome. For instance, when analyzing a repressive mark (e.g. H3K27me3) and a activating mark (e.g. H3K36me3) together, it is expected that the local co-occurrence of read enrichment for these marks will be rare. epigraHMM can remove such rare patterns automatically and, as a result, gives a more concise set of results.

In the example below, we perform a genomic segmentation using the epigenomic marks EZH2, H3K27me3, and H3K36me3. epigraHMM comes with an internal dataset `helas3` with read counts from ChIP-seq experiments from these marks (with two replicates each), for a particular subset of chromosome 19 (genome hg19). By setting `pruningThreshold = 0.05` in `controlEM()`, epigraHMM will sequentially prune any differential combinatorial pattern of enrichment with a mixture posterior proportion smaller than 0.05, starting from the full model. Optionally, we can set `quietPruning = FALSE` to allow epigraHMM to print out messages with statistics about the iterative pruning.

```
data('helas3')

control <- controlEM(pruningThreshold = 0.05,quietPruning = FALSE)

object <- normalizeCounts(object = helas3,control)

object <- initializer(object = object,control)
```

```
## The output file /tmp/RtmpIJd2VA/epigraHMM.h5 already exists and epigraHMM will overwrite it.
```

```
object <- epigraHMM(object = object,control = control,type = 'differential')
```

```
## ################################################################################
```

```
## Full model (BIC = 294976.36)
```

```
## DataFrame with 6 rows and 3 columns
##   Component        Enrichment PosteriorProportion
##   <integer>       <character>           <numeric>
## 1         1              EZH2         4.11739e-02
## 2         2          H3K27me3         3.00168e-02
## 3         3          H3K36me3         5.13540e-01
## 4         4     EZH2-H3K27me3         4.13901e-01
## 5         5     EZH2-H3K36me3         1.36877e-03
## 6         6 H3K27me3-H3K36me3         1.35773e-30
```

```
## ################################################################################
```

```
## Prunning enrichment patterns
```

```
## - H3K27me3-H3K36me3 (p = 1.36e-30) ... % BIC rel. change = -0.02.
## - EZH2-H3K36me3 (p = 1.39e-03) ... % BIC rel. change = -0.02.
## - H3K27me3 (p = 3.03e-02) ... % BIC rel. change = -0.00.
## - EZH2 (p = 3.93e-02) ... % BIC rel. change = 0.03.
## ################################################################################
## Reduced model (BIC = 295075.52)
##
## DataFrame with 2 rows and 3 columns
##   Component    Enrichment PosteriorProportion
##   <integer>   <character>           <numeric>
## 1         1      H3K36me3            0.530868
## 2         2 EZH2-H3K27me3            0.469132
## ################################################################################
```

The resulting combinatorial patterns are: enrichment of H3K36me3 alone, and co-enrichment of EZH2-H3K27me3. This makes sense, given the activating and silencing nature of H3K36me3 and EZH2-H3K27me3, respectively.

Because only rare combinatorial patterns of enrichment were removed, the percentage change in BIC (in comparison to the full model) is minimal. epigraHMM starts with mixture components associated with all possible patterns, and only those that exhibit a small posterior mixture proportion are removed. These should not contribute to the model likelihood after all.

# 2 Theory

## 2.1 Model overview

epigraHMM implements the statistical models presented in Baldoni, Rashid, and Ibrahim ([2019](#ref-baldoni2019improved)) (consensus peak calling) and Baldoni, Rashid, and Ibrahim ([2021](#ref-baldoni2019efficient)) (differential peak calling).

For consensus peak detection, epigraHMM utilizes a 2-state HMM with state-specific parametrization of the form:

\[ Y\_{ij} \sim \textrm{ZINB}(\rho\_{ij},\mu\_{2ij}, \phi\_1) \quad (background~state) \]
\[ Y\_{ij} \sim \textrm{NB}(\mu\_{2ij}, \phi\_2) \quad (enrichment~state) \]
\[ \log(\rho\_{ij}/(1-\rho\_{ij})) = \alpha + u\_{ij}\]
\[ \log(\mu\_{hij}) = \beta\_{h}+u\_{ij},\quad h\in\{1,2\}\]
\[ \log(\phi\_h) = \gamma\_{h},\quad h\in\{1,2\}\]
where the read counts \(Y\_{ij}\) for replicate \(i\) and genomic window \(j\) are modeled either using a zero-inflated negative binomial (ZINB, background state, \(h=1\)) or negative binomial distribution (NB, enrichment state, \(h=2\)) with zero-inflation probability \(\rho\_{ij}\), mean \(\mu\_{hij}\), and dispersions \(\phi\_{h}\), \(h\in\{1,2\}\). The coefficient \(\beta\_{h}\) gives the log average count of windows associated with the HMM state \(h\). If input controls experiments are available, they will be included in both HMM state mean models. The parametrization utilized by epigraHMM is such that larger values of \(\phi\_{h}\) are associated with lower overdispersion level in the data (i.e. \(Var\_{h}(Y\_{ij})=\mu\_{hij}(1+\mu\_{hij}/\phi\_{h})\)).

For differential peak detection across a number of \(G\) conditions, epigraHMM utilizes a 3-state HMM to model consensus background (\(h=1\)), differential (\(h=2\)), and consensus enrichment (\(h=3\)) windows. In this case, the parametrization of consensus background/enrichment states is equal to the parametrization used in the HMM background and enrichment states presented for consensus peak calling model above. For differential windows, however, a mixture model with \(2^G-2\) components is used to model all possible differential combinatorial patterns of enrichment across \(G\) conditions. Parameters from the mixture model differential state (\(h=2\)) are shared with those from the consensus background and enrichment states (\(h\in\{1,3\}\)). See Baldoni, Rashid, and Ibrahim ([2021](#ref-baldoni2019efficient)) for more details about the differential peak calling model.

Upon convergence of the rejection controlled EM algorithm, posterior probabilities associated with HMM states are used to call either consensus peaks or differential peaks. For differential peak calling, mixture model posterior proportions can be used to classify differential windows according to their most likely associated differential combinatorial pattern.

# 3 Session info

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
##  [1] BSgenome.Rnorvegicus.UCSC.rn4_1.4.0 BSgenome_1.78.0
##  [3] rtracklayer_1.70.0                  BiocIO_1.20.0
##  [5] Biostrings_2.78.0                   XVector_0.50.0
##  [7] gcapc_1.34.0                        SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0                      MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0                   epigraHMM_1.18.0
## [13] GenomicRanges_1.62.0                Seqinfo_1.0.0
## [15] IRanges_2.44.0                      S4Vectors_0.48.0
## [17] BiocGenerics_0.56.0                 generics_0.1.4
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] bitops_1.0-9             gridExtra_2.3            rlang_1.1.6
##  [4] magrittr_2.0.4           compiler_4.5.1           vctrs_0.6.5
##  [7] pkgconfig_2.0.3          crayon_1.5.3             fastmap_1.2.0
## [10] magick_2.9.0             backports_1.5.0          labeling_0.4.3
## [13] Rsamtools_2.26.0         rmarkdown_2.30           UCSC.utils_1.6.0
## [16] tinytex_0.57             purrr_1.1.0              xfun_0.53
## [19] cachem_1.1.0             cigarillo_1.0.0          GenomeInfoDb_1.46.0
## [22] jsonlite_2.0.0           rhdf5filters_1.22.0      DelayedArray_0.36.0
## [25] Rhdf5lib_1.32.0          BiocParallel_1.44.0      broom_1.0.10
## [28] parallel_4.5.1           R6_2.6.1                 bslib_0.9.0
## [31] RColorBrewer_1.1-3       limma_3.66.0             car_3.1-3
## [34] jquerylib_0.1.4          Rcpp_1.1.0               bookdown_0.45
## [37] knitr_1.50               Matrix_1.7-4             splines_4.5.1
## [40] tidyselect_1.2.1         dichromat_2.0-0.1        abind_1.4-8
## [43] yaml_2.3.10              codetools_0.2-20         curl_7.0.0
## [46] lattice_0.22-7           tibble_3.3.0             withr_3.0.2
## [49] S7_0.2.0                 csaw_1.44.0              evaluate_1.0.5
## [52] pillar_1.11.1            BiocManager_1.30.26      ggpubr_0.6.2
## [55] carData_3.0-5            RCurl_1.98-1.17          ggplot2_4.0.0
## [58] scales_1.4.0             glue_1.8.0               metapod_1.18.0
## [61] pheatmap_1.0.13          tools_4.5.1              data.table_1.17.8
## [64] locfit_1.5-9.12          ggsignif_0.6.4           GenomicAlignments_1.46.0
## [67] XML_3.99-0.19            cowplot_1.2.0            rhdf5_2.54.0
## [70] grid_4.5.1               tidyr_1.3.1              edgeR_4.8.0
## [73] restfulr_0.0.16          Formula_1.2-5            cli_3.6.5
## [76] GreyListChIP_1.42.0      S4Arrays_1.10.0          dplyr_1.1.4
## [79] gtable_0.3.6             rstatix_0.7.3            sass_0.4.10
## [82] digest_0.6.37            SparseArray_1.10.0       rjson_0.2.23
## [85] farver_2.1.2             htmltools_0.5.8.1        lifecycle_1.0.4
## [88] httr_1.4.7               statmod_1.5.1            MASS_7.3-65
## [91] bamsignals_1.42.0
```

# References

Amemiya, Haley M, Anshul Kundaje, and Alan P Boyle. 2019. “The Encode Blacklist: Identification of Problematic Regions of the Genome.” *Scientific Reports* 9 (1): 1–5.

Baldoni, Pedro L, Naim U Rashid, and Joseph G Ibrahim. 2019. “Improved Detection of Epigenomic Marks with Mixed-Effects Hidden Markov Models.” *Biometrics* 75 (4): 1401–13.

———. 2021. “Efficient Detection and Classification of Epigenomic Changes Under Multiple Conditions.” *Biometrics*, (in press).

Lun, Aaron TL, and Gordon K Smyth. 2015. “Csaw: A Bioconductor Package for Differential Binding Analysis of Chip-Seq Data Using Sliding Windows.” *Nucleic Acids Research* 44 (5): e45–e45.