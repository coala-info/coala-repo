# h5vc – Scalabale nucleotide tallies using HDF5

In this document we will illustrate the use of the *h5vc* package for creating and analysing nucleotide tallies of next generation sequencing experiments.

## Motivation

*h5vc* is a tool that is designed to provide researchers with a more intuitive and effective way of interacting with data from large cohorts of samples that have been sequenced with next generation sequencing technologies.

The challenges researchers face with the advent of massive sequencing efforts aimed at sequencing RNA and DNA of thousands of samples will need to be addressed now, before the flood of data becomes a real problem.

The effects of the infeasibility of handling the sequencing data of large cohorts with the current standards (BAM, VCF, BCF, GTF, etc.) have become apparent in recent publications that performed population level analyses of mutations in many cancer samples and work exclusively on the level of preprocessed variant calls stored in VCF/MAF files simply because there is no way to look at the data itself with reasonable resource usage (e.g. in [Kandoth et. al 2013](http://www.nature.com/nature/journal/v502/n7471/full/nature12634.html "Mutational landscape and significance across 12 major cancer types")).

This challenge can be adressed by augmenting the available legacy formats typically used for sequencing analyses (SAM/BAM files) with an intermediate file format that stores only the most essential information and provides efficient access to the cohort level data whilst reducing the information loss relative to the raw alignments.

This file format will store nucleotide tallies rather than alignments and allow for easy and efficient real-time random access to the data of a whole cohort of samples. The details are described in the following section.

## Nucleotide Tally Definition

The tally data structure proposed here consists of 5 datasets that are stored for each chromosome (or contig). Those datasets are: \* Counts: A table that contains the number of observed mismatches at any combination of base, sample, strand and genomic position, \* Coverages: A table that contains the number of reads overlapping at any combination of sample, strand and genomic position \* Deletions: A Table that contains the number of observed deletions of bases at any combination of sample, strand and genomic position \* Insertions: A Table that contains the number of observed insertions of bases at any combination of sample, strand and genomic position (showing insertions following the position) \* Reference: A Table that contains the reference base against which the calls in the ‘Deletions’ and ‘Counts’ table were made.

We outline the basic layout of this set of tables here:

| Name | Dimensions | Datatype |
| --- | --- | --- |
| Counts | [ #bases, #samples, #strands, #positions ] | int |
| Coverages | [ #samples, #strands, #positions ] | int |
| Deletions | [ #samples, #strands, #positions ] | int |
| Insertions | [ #samples, #strands, #positions ] | int |
| Reference | [ #positions ] | int |

An `HDF5` file has an internal structure that is similar to a file system, where groups are the directories and datasets are the files. The layout of the tally file is as follows:

![](data:image/png;base64...)

The layout of a tally `HDF5` file.

A tally file can contain data from more than one study but each study will reside in a separte tree with a group named with the study-ID at its root and sub-groups for all the chromosomes / contigs that are present in the study. Attached to each of the chromosome groups are the 4 datasets described above.

Additionally each chromsome group stores sample data about the samples involved in the experiment (patientID, type, location in the sample dimension) as `HDF5` attributes. Convenience functions for extracting the metadata are provided, see examples below.

## A practical example

Before we get into the details of how to generate an HDF5 tally file for a set of sequencing experiments we will show some examples of the possible analyses one can perform on such a file. The tally file we will use is provided with the *h5vcData* package and if you have not installed this so far you should do so now.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("h5vcData")
```

The first thing we do is set up the session by loading the *h5vc* and *rhdf5* packages and finding the location of the example tally file.

```
suppressPackageStartupMessages(library(h5vc))
```

```
## Warning: replacing previous import 'Biostrings::pattern' by 'grid::pattern'
## when loading 'h5vc'
```

```
suppressPackageStartupMessages(library(rhdf5))

tallyFile <- system.file( "extdata", "example.tally.hfs5", package = "h5vcData" )
```

We can inspect the data contained in this file with the `h5ls` function provided by *rhdf5*.

```
h5ls(tallyFile)
```

```
##               group         name       otype  dclass                   dim
## 0                 / ExampleStudy   H5I_GROUP
## 1     /ExampleStudy           16   H5I_GROUP
## 2  /ExampleStudy/16       Counts H5I_DATASET INTEGER 12 x 6 x 2 x 90354753
## 3  /ExampleStudy/16    Coverages H5I_DATASET INTEGER      6 x 2 x 90354753
## 4  /ExampleStudy/16    Deletions H5I_DATASET INTEGER      6 x 2 x 90354753
## 5  /ExampleStudy/16    Reference H5I_DATASET INTEGER              90354753
## 6     /ExampleStudy           22   H5I_GROUP
## 7  /ExampleStudy/22       Counts H5I_DATASET INTEGER 12 x 6 x 2 x 51304566
## 8  /ExampleStudy/22    Coverages H5I_DATASET INTEGER      6 x 2 x 51304566
## 9  /ExampleStudy/22    Deletions H5I_DATASET INTEGER      6 x 2 x 51304566
## 10 /ExampleStudy/22    Reference H5I_DATASET INTEGER              51304566
```

In the resulting output we can find the different groups and datasets present in the file and we can extract the relevant sample data attached to those groups in the following way.

```
sampleData <- getSampleData( tallyFile, "/ExampleStudy/16" )
sampleData
```

```
##   ClinicalVariable Column  Patient           Sample
## 1       0.09954954      6 Patient8    PT8PrimaryDNA
## 2       0.48897702      2 Patient5    PT5PrimaryDNA
## 3       0.57572272      3 Patient5    PT5RelapseDNA
## 4       0.81979828      5 Patient8 PT8EarlyStageDNA
## 5      -1.61585662      1 Patient5    PT5ControlDNA
## 6      -0.24627631      4 Patient8    PT8ControlDNA
##                      SampleFiles    Type
## 1     ../Input/PT8PrimaryDNA.bam    Case
## 2     ../Input/PT5PrimaryDNA.bam    Case
## 3     ../Input/PT5RelapseDNA.bam    Case
## 4 ../Input/PT8PreLeukemiaDNA.bam    Case
## 5     ../Input/PT5ControlDNA.bam Control
## 6     ../Input/PT8ControlDNA.bam Control
```

The `sampleData` object is a `data.frame` that contains information about the samples whose nucleotide tallies are present in the file. We can modify this object (e.g. add new columns) and write it back to the file using the `setSampleData` function, but we must be aware that a certain set of columns have to be present (`Sample`, `Patient`, `Column` and `Type`).

```
sampleData$ClinicalVariable <- rnorm(nrow(sampleData))
setSampleData( tallyFile, "/ExampleStudy/16", sampleData )
sampleData
```

```
##   ClinicalVariable Column  Patient           Sample
## 1       0.01438391      6 Patient8    PT8PrimaryDNA
## 2      -1.03816703      2 Patient5    PT5PrimaryDNA
## 3      -0.03423582      3 Patient5    PT5RelapseDNA
## 4      -1.47848332      5 Patient8 PT8EarlyStageDNA
## 5      -1.36616867      1 Patient5    PT5ControlDNA
## 6       1.10177075      4 Patient8    PT8ControlDNA
##                      SampleFiles    Type
## 1     ../Input/PT8PrimaryDNA.bam    Case
## 2     ../Input/PT5PrimaryDNA.bam    Case
## 3     ../Input/PT5RelapseDNA.bam    Case
## 4 ../Input/PT8PreLeukemiaDNA.bam    Case
## 5     ../Input/PT5ControlDNA.bam Control
## 6     ../Input/PT8ControlDNA.bam Control
```

Now that we can find the sample metadata in the file it is time to extract some of the nuclotide tally data stored there. We can use two functions to achieve this, `h5readBlock` can be used to read a specified block of data along a given dimension (e.g. a region along the genomic position) and `h5dapply` can be used to apply a function in a blockwise fashion along a specified dimension (e.g. calculating coverage in bins of a certain size along the genomic position dimension).

We can read out a block of data in the following way:

```
data <- h5readBlock(
  filename = tallyFile,
  group = "/ExampleStudy/16",
  names = c( "Coverages", "Counts" ),
  range = c(29000000,29001000)
  )
str(data)
```

```
## List of 3
##  $ Coverages   : int [1:6, 1:2, 1:1001] 0 0 0 0 0 0 0 0 0 0 ...
##  $ Counts      : int [1:12, 1:6, 1:2, 1:1001] 0 0 0 0 0 0 0 0 0 0 ...
##  $ h5dapplyInfo:List of 4
##   ..$ Blockstart: int 29000000
##   ..$ Blockend  : int 29001000
##   ..$ Datasets  :'data.frame':   2 obs. of  3 variables:
##   .. ..$ Name    : chr [1:2] "Coverages" "Counts"
##   .. ..$ DimCount: int [1:2] 3 4
##   .. ..$ PosDim  : int [1:2] 3 4
##   ..$ Group     : chr "/ExampleStudy/16"
```

When we want to read multiple blocks of data we can use the `h5dapply` function which supports the usage of `IRanges` and `GRanges` to define regions of interest, although a simpler system where the user specifies only a `start`, `end` and `blocksize` parameter exists.

```
suppressPackageStartupMessages(require(GenomicRanges))
data <- h5dapply(
  filename = tallyFile,
  group = "/ExampleStudy",
  names = c( "Coverages" ),
  dims = c(3),
  range = GRanges("16", ranges = IRanges(start = seq(29e6, 30e6, 5e6), width = 1000))
  )
str(data)
```

```
## List of 1
##  $ 16:List of 1
##   ..$ 29000000:29000999:List of 2
##   .. ..$ Coverages   : int [1:6, 1:2, 1:1000] 0 0 0 0 0 0 0 0 0 0 ...
##   .. ..$ h5dapplyInfo:List of 4
##   .. .. ..$ Blockstart: int 29000000
##   .. .. ..$ Blockend  : int 29000999
##   .. .. ..$ Datasets  :'data.frame': 1 obs. of  3 variables:
##   .. .. .. ..$ Name    : chr "Coverages"
##   .. .. .. ..$ DimCount: int 3
##   .. .. .. ..$ PosDim  : num 3
##   .. .. ..$ Group     : chr "/ExampleStudy/16"
```

Usually we do not want to load the data of all those blocks into memory (unless we need it for plotting). A typical workflow will involve some form of processing of the data and as long as this processing can be expressed as an R function that can be applied to each block separately, we can simply provide `h5dapply` with this function and only retrieve the results. In the following example we calculate the coverage of the samples present in the example tally file by applying the `binnedCoverage` function to blocks defined in a GRanges object.

```
#rangeA <- GRanges("16", ranges = IRanges(start = seq(29e6, 29.5e6, 1e5), width = 1000))
#rangeB <- GRanges("22", ranges = IRanges(start = seq(39e6, 39.5e6, 1e5), width = 1000))
range <- GRanges(
  rep(c("16", "22"), each = 6),
  ranges = IRanges(
    start = c(seq(29e6, 29.5e6, 1e5),seq(39e6, 39.5e6, 1e5)),
    width = 1000
  ))
coverages <- h5dapply(
  filename = tallyFile,
  group = "/ExampleStudy",
  names = c( "Coverages" ),
  dims = c(3),
  range = range,
  FUN = binnedCoverage,
  sampledata = sampleData
  )
#options(scipen=10)
coverages <- do.call( rbind, lapply( coverages, function(x) do.call(rbind, x) ))
#rownames(coverages) <- NULL #remove block-ids used as row-names
coverages
```

```
##                      PT5ControlDNA PT5PrimaryDNA PT5RelapseDNA PT8ControlDNA
## 16.29000000:29000999         36113         40117         18158         36377
## 16.29100000:29100999         47081         58134         20670         56402
## 16.29200000:29200999         51110         46735         22911         46598
## 16.29300000:29300999         41432         50366         23395         42309
## 16.29400000:29400999         22083         29795         11629         30813
## 16.29500000:29500999           101           101             0           202
## 22.39000000:39000999         47677         50990         23573         46070
## 22.39100000:39100999         42456         48328         19178         46106
## 22.39200000:39200999         49749         64833         25383         52946
## 22.39300000:39300999         55279         56861         26796         57834
## 22.39400000:39400999         35512         55103         18155         48502
## 22.39500000:39500999         41028         54033         20925         51626
##                      PT8EarlyStageDNA PT8PrimaryDNA Chrom    Start      End
## 16.29000000:29000999            32315         18998    16 29000000 29000999
## 16.29100000:29100999            53987         17228    16 29100000 29100999
## 16.29200000:29200999            50203         20391    16 29200000 29200999
## 16.29300000:29300999            45285         18961    16 29300000 29300999
## 16.29400000:29400999            24986          9293    16 29400000 29400999
## 16.29500000:29500999              101             0    16 29500000 29500999
## 22.39000000:39000999            47232         20825    22 39000000 39000999
## 22.39100000:39100999            45135         18827    22 39100000 39100999
## 22.39200000:39200999            53028         24135    22 39200000 39200999
## 22.39300000:39300999            51304         23554    22 39300000 39300999
## 22.39400000:39400999            39690         21945    22 39400000 39400999
## 22.39500000:39500999            37666         18943    22 39500000 39500999
```

Note that `binnedCoverage` takes an additional parameter `sampleData` which we provide to the function as well. Furthermore we specify the `blocksize` to be 500 bases and we specify the `dims` parameter to tell `h5dapply` along which dimension of the selected datasets (“Coverages” in this case) shall be processed (dimension number 3 is the genomic position in the “Coverages” dataset). The explicit specification of `dims` is only neccessary when we are not extracting the “Counts” dataset, otherwise it defaults to the genomic position.

In the same way we can perform variant calling by using `h5dapply` together with a variant calling function like `callVariantsPaired` or `callVariantsSingle`.

```
variants <- h5dapply(
  filename = tallyFile,
  group = "/ExampleStudy/16",
  names = c( "Coverages", "Counts", "Deletions", "Reference" ),
  range = c(29950000,30000000),
  blocksize = 10000,
  FUN = callVariantsPaired,
  sampledata = sampleData,
  cl = vcConfParams(returnDataPoints = TRUE)
  )
variants <- do.call( rbind, variants )
variants$AF <- (variants$caseCountFwd + variants$caseCountRev) / (variants$caseCoverageFwd + variants$caseCoverageRev)
variants <- variants[variants$AF > 0.2,]
rownames(variants) <- NULL # remove rownames to save some space on output :D
variants
```

```
##   Chrom    Start      End           Sample altAllele refAllele caseCountFwd
## 1    16 29950746 29950746    PT8PrimaryDNA         -         T           10
## 2    16 29983015 29983015    PT5PrimaryDNA         G         C           12
## 3    16 29983015 29983015    PT5RelapseDNA         G         C            3
## 4    16 29983015 29983015 PT8EarlyStageDNA         G         C            8
##   caseCountRev caseCoverageFwd caseCoverageRev controlCountFwd controlCountRev
## 1            3              34              29               0               0
## 2           13              29              27               0               0
## 3            4              10               9               0               0
## 4           14              19              30               0               0
##   controlCoverageFwd controlCoverageRev backgroundFrequencyFwd
## 1                 10                 15                    0.1
## 2                 11                 19                    0.0
## 3                 11                 19                    0.0
## 4                 13                 10                    0.0
##   backgroundFrequencyRev   pValueFwd pValueRev caseCount controlCount
## 1              0.0754717 0.001365664 0.3761485        13            0
## 2              0.0000000 0.000000000 0.0000000        25            0
## 3              0.0000000 0.000000000 0.0000000         7            0
## 4              0.0000000 0.000000000 0.0000000        22            0
##   caseCoverage controlCoverage        AF
## 1           63              25 0.2063492
## 2           56              30 0.4464286
## 3           19              30 0.3684211
## 4           49              23 0.4489796
```

For details about the parameters and behaviour of `callVariantsPaired` have a look at the corresponding manual page ( i.e. `?callVariantsPaired` ).

A function has to have a named parameter `data` as its first argument in order to be compatible with `h5dapply`, in this case data is a list of the same structure as the one returned by `h5readBlock`.

Once we have determined the location of an interesting variant, like `16:29983015-29983015:C/G` in our case, we can create a `mismatchPlot` in the region around it to get a better feeling for the variant. To this end we use the `mismatchPlot` function on the tallies in the region in the following way:

```
windowsize <- 35
position <- variants$Start[2]
data <- h5readBlock(
    filename = tallyFile,
    group = paste( "/ExampleStudy", variants$Chrom[2], sep="/" ),
    names = c("Coverages","Counts","Deletions", "Reference"),
    range = c( position - windowsize, position + windowsize)
  )
patient <- sampleData$Patient[sampleData$Sample == variants$Sample[2]]
samples <- sampleData$Sample[sampleData$Patient == patient]
p <- mismatchPlot(
  data = data,
  sampledata = sampleData,
  samples = samples,
  windowsize = windowsize,
  position = position
  )
```

```
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the h5vc package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
print(p)
```

![](data:image/png;base64...)

This plot shows the region 35 bases up and downstream of the variant. It shows one panel for each sample associated with the patient that carries the variant (selected by the line `sampleData$Sample[sampleData$Patient == patient]`) and each panel is centered on the varian position in the x-axis and the y-axis encodes coverage and mismatches (negative values are on the reverse strand). The grey area is the coverage and the coloured boxes are mismatches. For more details on this plot see `?mismatchPlot`.

The object returned by `mismatchPlot` is a `ggplot` object which can be manipulated in the same way as any other plot generated through a call to `ggplot`. We can for example apply a theme to the plot (see `?ggplot2::theme` for a list of possible options).

```
print(p + theme(strip.text.y = element_text(family="serif", size=16, angle=0)))
```

![](data:image/png;base64...)

## Ranges interface

The `h5dapply` function can also be used with an `IRanges` object that defines the blocks to apply a function to. This can be helpful in cases where simple binning is insufficient, e.g. when we want to get data from a set of SNVs and their immediate environment, do a calculation on a set of overlapping bins or investigate specific regions of interest, e.g. annotated exons.

An example of how to fetch exon annotations from BioMart and calculate coverages on those exons is given here.

```
suppressPackageStartupMessages(require(IRanges))
suppressPackageStartupMessages(require(biomaRt))
mart <- useDataset(dataset = "hsapiens_gene_ensembl", mart = useMart("ENSEMBL_MART_ENSEMBL"))
exons <- getBM(attributes = c("ensembl_exon_id", "exon_chrom_start", "exon_chrom_end"), filters = c("chromosome_name"), values = c("16"), mart)
exons <- subset(exons, exon_chrom_start > 29e6 & exon_chrom_end < 30e6)
ranges <- IRanges(start = exons$exon_chrom_start, end = exons$exon_chrom_end)
coverages <- h5dapply(
  filename = tallyFile,
  group = "/ExampleStudy/16",
  names = c( "Coverages" ),
  dims = c(3),
  range = ranges,
  FUN = binnedCoverage,
  sampledata = sampleData
  )
options(scipen=10)
coverages <- do.call( rbind, coverages )
rownames(coverages) <- NULL #remove block-ids used as row-names
coverages$ExonID <- exons$ensembl_exon_id
head(coverages)
```

```
##   PT5ControlDNA PT5PrimaryDNA PT5RelapseDNA PT8ControlDNA PT8EarlyStageDNA
## 1          6465          6421          1759          5129             5356
## 2           460           608           144           326              689
## 3          2113          2470           671          1571             1343
## 4          3727          4540          1605          4212             3347
## 5          6971          9838          3696          7317             6590
## 6          2384          2814          1966          3028             2655
##   PT8PrimaryDNA Chrom    Start      End          ExonID
## 1          3263    16 29075022 29075121 ENSE00003642185
## 2           116    16 29076656 29076761 ENSE00003812573
## 3           676    16 29077901 29077957 ENSE00003812342
## 4          1502    16 29084443 29084532 ENSE00003814167
## 5          3636    16 29084639 29084768 ENSE00003814007
## 6          1499    16 29085217 29085276 ENSE00003813552
```

Another source of useful annotation data are the `TxDB.*` Bioconductor packages, which provide gene model annotation for a wide range of organisms and reference releases as ranges objects that can be directly plugged into h5dapply to perform calculations on those objects.

We can also use the ranges interface to `h5dapply` in conjunction with the `mismatchPlot` function to create mismatch plots of multiple regions at the same time. Here we plot the same variant in 3 slightly shifted windows to show the usage of ranges for plotting:

```
windowsize <- 35
position <- variants$Start[2]
data <- h5dapply(
    filename = tallyFile,
    group = paste( "/ExampleStudy", variants$Chrom[2], sep="/" ),
    names = c("Coverages","Counts","Deletions", "Reference"),
    range = flank( IRanges(start = c(position - 10, position, position + 10), width = 1), width = 15, both = TRUE )
  )
p <- mismatchPlot(
  data = data,
  sampledata = sampleData,
  samples <- c("PT5ControlDNA", "PT5PrimaryDNA", "PT5RelapseDNA", "PT8ControlDNA", "PT8EarlyStageDNA", "PT8PrimaryDNA")
  )
```

```
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
```

```
print(p)
```

![](data:image/png;base64...)

We end our practical example at this point and move on to sections detailing more involved analysis and, most importantly, the creation of tally files from bam files.

## Creating tally files

Creating tally files is a time-consuming process and requires substantial compute power. It is a preprocessing step that is applied to the BAM files corresponding to the samples we want to tally and should be executed only once. In this way it represents an initial investment of time and resources that yields the HDF5 tally files which then allow for fast analysis and interactive exploration of the data in a much more intuitive way than raw BAM files.

We will demonstrate the creation of a HDF5 tally file by using a set of BAM files provided by the `h5vcData` package. We load some required packages and extract the locations of the BAM files in question.

```
suppressPackageStartupMessages(library("h5vc"))
suppressPackageStartupMessages(library("rhdf5"))
files <- list.files( system.file("extdata", package = "h5vcData"), "Pt.*bam$" )
files
bamFiles <- file.path( system.file("extdata", package = "h5vcData"), files)
```

Now `bamFiles` contains the paths to our BAM files, which are from pairs of cancer and control samples and contain reads overlappign the DNMT3A gene on chromosome 2. We will now create the tally file and create the groups that represent the study and chromosome we want to work on. Before we do this, we need to find out how big our datasets have to be in their genomic-position dimension, to do this we will look into the header of the bam files and extract the sequence length information.

```
suppressPackageStartupMessages(library("Rsamtools"))
chromdim <- sapply( scanBamHeader(bamFiles), function(x) x$targets )
colnames(chromdim) <- files
head(chromdim)
```

```
##   Pt10Cancer.bam Pt10Control.bam Pt17Cancer.bam Pt17Control.bam Pt18Cancer.bam
## 1      248956422       248956422      248956422       248956422      248956422
## 2      242193529       242193529      242193529       242193529      242193529
## 3      198295559       198295559      198295559       198295559      198295559
## 4      190214555       190214555      190214555       190214555      190214555
## 5      181538259       181538259      181538259       181538259      181538259
## 6      170805979       170805979      170805979       170805979      170805979
##   Pt18Control.bam Pt20Cancer.bam Pt20Control.bam Pt23Cancer.bam Pt23Control.bam
## 1       248956422      248956422       248956422      248956422       248956422
## 2       242193529      242193529       242193529      242193529       242193529
## 3       198295559      198295559       198295559      198295559       198295559
## 4       190214555      190214555       190214555      190214555       190214555
## 5       181538259      181538259       181538259      181538259       181538259
## 6       170805979      170805979       170805979      170805979       170805979
##   Pt25Cancer.bam Pt25Control.bam
## 1      248956422       248956422
## 2      242193529       242193529
## 3      198295559       198295559
## 4      190214555       190214555
## 5      181538259       181538259
## 6      170805979       170805979
```

All files have the same header information and are fully compatible, so we can just pick one file and take the chromosome lengths from there. Note that although we will only tally the DNMT3A gene we still instantiate the datasets in the tally file with the full chromosome length so that the index along the genomic position axis corresponds directly to the position in the genome (the internal compression of HDF5 will take care of the large blocks of zeros so that the effective filesize is similar to what it would be if we created the datasets to only hold the DNMT3A gene region).

```
chrom <- "2"
chromlength <- chromdim[chrom,1]
study <- "/DNMT3A"
tallyFile <- file.path( tempdir(), "DNMT3A.tally.hfs5" )
if( file.exists(tallyFile) ){
  file.remove(tallyFile)
}
if( prepareTallyFile( tallyFile, study, chrom, chromlength, nsamples = length(files) ) ){
  h5ls(tallyFile)
}else{
  message( paste( "Preparation of:", tallyFile, "failed" ) )
}
```

```
##       group       name       otype  dclass                     dim
## 0         /     DNMT3A   H5I_GROUP
## 1   /DNMT3A          2   H5I_GROUP
## 2 /DNMT3A/2     Counts H5I_DATASET INTEGER 12 x 12 x 2 x 242193529
## 3 /DNMT3A/2  Coverages H5I_DATASET INTEGER      12 x 2 x 242193529
## 4 /DNMT3A/2  Deletions H5I_DATASET INTEGER      12 x 2 x 242193529
## 5 /DNMT3A/2 Insertions H5I_DATASET INTEGER      12 x 2 x 242193529
## 6 /DNMT3A/2  Reference H5I_DATASET INTEGER               242193529
```

Have a look at `?prepareTallyFile` to find out more about possible parameters to this function and how they can inflence the performance of operations on the HDF5 file.

Since datasets are stored in HDF5 files as matrices without dimension names we need to create a separate object (a `data.frame` in this case) to hold sample metadata that tells us which sample corresponds to which slots in the matrix and also stores additional usefull information about the samples.

```
sampleData <- data.frame(
  File = files,
  Type = "Control",
  stringsAsFactors = FALSE
  )
sampleData$Sample <- gsub(x = sampleData$File, pattern = ".bam", replacement = "")
sampleData$Patient <- substr(sampleData$Sample, start = 1, 4)
sampleData$Column <- seq_along(files)
sampleData$Type[grep(pattern = "Cancer", x = sampleData$Sample)] <- "Case"
group <- paste( study, chrom, sep = "/" )
setSampleData( tallyFile, group, sampleData )
getSampleData( tallyFile, group )
```

```
##    Column            File Patient      Sample    Type
## 1       1  Pt10Cancer.bam    Pt10  Pt10Cancer    Case
## 2       2 Pt10Control.bam    Pt10 Pt10Control Control
## 3       3  Pt17Cancer.bam    Pt17  Pt17Cancer    Case
## 4       4 Pt17Control.bam    Pt17 Pt17Control Control
## 5       5  Pt18Cancer.bam    Pt18  Pt18Cancer    Case
## 6       6 Pt18Control.bam    Pt18 Pt18Control Control
## 7       7  Pt20Cancer.bam    Pt20  Pt20Cancer    Case
## 8       8 Pt20Control.bam    Pt20 Pt20Control Control
## 9       9  Pt23Cancer.bam    Pt23  Pt23Cancer    Case
## 10     10 Pt23Control.bam    Pt23 Pt23Control Control
## 11     11  Pt25Cancer.bam    Pt25  Pt25Cancer    Case
## 12     12 Pt25Control.bam    Pt25 Pt25Control Control
```

We use a set of operations on the conveniently chosen filenames to extract the patient and sample id as well as the type of sample the file corresponds to. The `Column` slot can be populated with an arbitrary order and we simply make it a sequency along the (alphabetically ordered) filenames. Note a little complication that derives from the fact that R indexes arrays in a 1-based manner, while HDF5 internally does it 0-based (like, e.g. C). We set the columns to be `1` and `2`, respectively, while within the tally file the values `0` and `1` are stored. The functions `setSampleData` and `getSampleData` automatically remove / add `1` from the value when needed.

# Extracting tallies from the bam files

Now it is time to extract tally information from the bam file. We use the high-level function `tallyRanges` to do this for us (have a look at the code of that function to see what the separate steps are). This function is called with the names of the bam files, a ranges object describing the regions to tally in and a `BSgenome` reference object corresponding to the refernce that the alignments were made against. You can check out the “How to forge a BSgenome package”-vignette of the `BSgenome` Bioconductor package, in case you used a non-standard refernce. We will simply use the `BSgenome.Hsapiens.NCBI.GRCh38` annotation package provided with Bioconductor. We will load the gene annotation from a GTF formatted file containing annotated exons in trascripts of DNMT3A that was downloaded from Ensembl.org. If a compatible TxDB object is available we could also use that.

We will also make use of multicore parallelisation through the `BiocParallel` package to speed up processing of the exons defined in the annotation file. Note that the data is from whole exome sequencing assays and we can focus on the annotated exons in the tallying.

```
suppressPackageStartupMessages(require(BSgenome.Hsapiens.NCBI.GRCh38))
suppressPackageStartupMessages(require(GenomicRanges))
dnmt3a <- read.table(system.file("extdata", "dnmt3a.txt", package = "h5vcData"), header=TRUE, stringsAsFactors = FALSE)
dnmt3a <- with( dnmt3a, GRanges(seqname, ranges = IRanges(start = start, end = end)))
dnmt3a <- reduce(dnmt3a)
require(BiocParallel)
```

```
## Loading required package: BiocParallel
```

```
register(MulticoreParam())
theData <- tallyRanges( bamFiles, ranges = dnmt3a, reference = Hsapiens )
str(theData[[1]])
```

```
## List of 5
##  $ Counts    : num [1:12, 1:12, 1:2, 1:6566] 0 0 0 0 0 0 0 0 0 0 ...
##   ..- attr(*, "dimnames")=List of 4
##   .. ..$ : chr [1:12] "A.front" "C.front" "G.front" "T.front" ...
##   .. ..$ : chr [1:12] "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt10Cancer.bam" "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt10Control.bam" "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt17Cancer.bam" "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt17Control.bam" ...
##   .. ..$ : chr [1:2] "+" "-"
##   .. ..$ : NULL
##  $ Coverages : num [1:12, 1:2, 1:6566] 0 0 0 0 0 0 0 0 0 0 ...
##   ..- attr(*, "dimnames")=List of 3
##   .. ..$ : chr [1:12] "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt10Cancer.bam" "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt10Control.bam" "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt17Cancer.bam" "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt17Control.bam" ...
##   .. ..$ : chr [1:2] "+" "-"
##   .. ..$ : NULL
##  $ Deletions : num [1:12, 1:2, 1:6566] 0 0 0 0 0 0 0 0 0 0 ...
##   ..- attr(*, "dimnames")=List of 3
##   .. ..$ : chr [1:12] "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt10Cancer.bam" "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt10Control.bam" "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt17Cancer.bam" "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt17Control.bam" ...
##   .. ..$ : chr [1:2] "+" "-"
##   .. ..$ : NULL
##  $ Insertions: num [1:12, 1:2, 1:6566] 0 0 0 0 0 0 0 0 0 0 ...
##   ..- attr(*, "dimnames")=List of 3
##   .. ..$ : chr [1:12] "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt10Cancer.bam" "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt10Control.bam" "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt17Cancer.bam" "/home/biocbuild/bbs-3.22-bioc/R/site-library/h5vcData/extdata/Pt17Control.bam" ...
##   .. ..$ : chr [1:2] "+" "-"
##   .. ..$ : NULL
##  $ Reference : num [1:6566] 3 3 0 3 3 0 1 2 2 3 ...
```

The resulting object is a list of lists with one element per range and within those one slot per dataset using the same layout that you will get from calls to `h5readBlock` or `h5dapply`.

We use the `writeTallyFile` function to write our data to the tally file. (See the function documentation for more information.)

```
writeToTallyFile(theData, tallyFile, study = "/DNMT3A", ranges = dnmt3a)
```

```
## [1] TRUE
```

# Checking if everything worked

We will use the `h5dapply` function provided by `h5vc` to extract the data again and have a look at it.

```
data <- h5dapply(
    filename = tallyFile,
    group = "/DNMT3A",
    range = dnmt3a
  )
str(data[["2"]][[1]])
```

```
## List of 5
##  $ Counts      : int [1:12, 1:12, 1:2, 1:6566] 0 0 0 0 0 0 0 0 0 0 ...
##  $ Coverages   : int [1:12, 1:2, 1:6566] 0 0 0 0 0 0 0 0 0 0 ...
##  $ Deletions   : int [1:12, 1:2, 1:6566] 0 0 0 0 0 0 0 0 0 0 ...
##  $ Reference   : int [1:6566] 3 3 0 3 3 0 1 2 2 3 ...
##  $ h5dapplyInfo:List of 4
##   ..$ Blockstart: int 25227855
##   ..$ Blockend  : int 25234420
##   ..$ Datasets  :'data.frame':   4 obs. of  3 variables:
##   .. ..$ Name    : chr [1:4] "Counts" "Coverages" "Deletions" "Reference"
##   .. ..$ DimCount: int [1:4] 4 3 3 1
##   .. ..$ PosDim  : int [1:4] 4 3 3 1
##   ..$ Group     : chr "/DNMT3A/2"
```

We will call variants within this gene now:

```
vars <- h5dapply(
    filename = tallyFile,
    group = "/DNMT3A",
    FUN = callVariantsPaired,
    sampledata = getSampleData(tallyFile,group),
    cl = vcConfParams(),
    range = dnmt3a
  )
vars <- do.call(rbind, vars[["2"]])
vars
```

```
##                   Chrom    Start      End     Sample altAllele refAllele
## 25227855:25234420     2 25234373 25234373 Pt17Cancer         T         C
##                   caseCountFwd caseCountRev caseCoverageFwd caseCoverageRev
## 25227855:25234420            7           35              17              83
##                   controlCountFwd controlCountRev controlCoverageFwd
## 25227855:25234420               0               0                 22
##                   controlCoverageRev backgroundFrequencyFwd
## 25227855:25234420                 60             0.04545455
##                   backgroundFrequencyRev      pValueFwd    pValueRev caseCount
## 25227855:25234420             0.03548387 0.000005202341 1.017871e-28        42
##                   controlCount caseCoverage controlCoverage
## 25227855:25234420            0          100              82
```

By cleverly selecting the example data we have found exactly one variant that seems ot be interesting and will now plot the region in question to also check if the `mismatchPlot` function will work with the tally data we created.

```
position <- vars$End[1]
windowsize <- 30
data <- h5readBlock(
    filename = tallyFile,
    group = group,
    range = c(position - windowsize, position + windowsize)
  )
sampleData <- getSampleData(tallyFile,group)
p <- mismatchPlot( data, sampleData, samples = c("Pt17Control", "Pt17Cancer"), windowsize=windowsize, position=position )
```

```
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
```

```
print(p)
```

![](data:image/png;base64...)

# Mutation Spectrum Analysis

We can also easily perform mutation spectrum analysis by using the function `mutationSpectrum` which works on a set of variant calls in a `data.frame` form as it would be produced by a call to e.g. `callVariantsPaired` and a tallyFile parameter specifying hte location of a tally file as well as a context parameter. The context parameter specifies how much sequence context should be taken into account for the mutation spectrum. An example with context 1 (i.e. one base up- and one base downstream of the variant) is shown below.

```
tallyFileMS <- system.file( "extdata", "example.tally.hfs5", package = "h5vcData" )
data( "example.variants", package = "h5vcData" ) #example variant calls
head(variantCalls)
```

```
##   Chrom    Start      End        Sample altAllele refAllele caseCountFwd
## 1    16 29008219 29008219 PT5PrimaryDNA         T         G            2
## 2    16 29020181 29020181 PT5PrimaryDNA         A         C            3
## 3    16 29037593 29037593 PT8PrimaryDNA         G         C            2
## 4    16 29040237 29040237 PT8PrimaryDNA         C         A            2
## 5    16 29069931 29069931 PT5PrimaryDNA         G         A            2
## 6    16 29102402 29102402 PT5PrimaryDNA         T         C            2
##   caseCountRev caseCoverageFwd caseCoverageRev controlCountFwd controlCountRev
## 1            2              26              20               0               0
## 2            2              18              20               0               0
## 3            2              22              17               0               0
## 4            2              20              17               0               0
## 5            2              42              39               0               0
## 6            2              25              34               0               0
##   controlCoverageFwd controlCoverageRev
## 1                 21                 22
## 2                 16                 17
## 3                 21                 12
## 4                 19                 11
## 5                 37                 34
## 6                 21                 35
```

```
ms = mutationSpectrum( variantCalls, tallyFileMS, "/ExampleStudy" )
head(ms)
```

```
##   refAllele altAllele        Sample Prefix Suffix MutationType Context
## 1         T         T PT5PrimaryDNA      A      A          C>A     TGT
## 2         C         A PT5PrimaryDNA      A      A          C>A     ACA
## 3         C         G PT8PrimaryDNA      C      C          C>G     CCC
## 4         C         A PT8PrimaryDNA      G      C          T>G     GAC
## 5         C         C PT5PrimaryDNA      C      C          T>C     GAG
## 6         C         T PT5PrimaryDNA      G      C          C>T     GCC
```

We can see the structure of the `variantCalls` object, which is simply a `data.frame`, this is the return value of a call to `callVariantsPaired`. The mutation spectrum is also a `data.frame`. You can find explanations of those data structures by looking at `?mutationSpectrum` and `?callVariantsPaired`.

We can plot the mutation spectrum with the `plotMutationSpectrum` function. This function also returns a `ggplot` object which can be manipulated by adding `theme`s etc.

```
plotMutationSpectrum(ms) + theme(
  strip.text.y = element_text(angle=0, size=10),
  axis.text.x = element_text(size = 7),
  axis.text.y = element_text(size = 10)) + scale_y_continuous(breaks = c(0,5,10,15))
```

```
## Scale for y is already present.
## Adding another scale for y, which will replace the existing scale.
```

![](data:image/png;base64...)

# Parallelisation

In this section we will cover some of the aspects of parallelisation. Most notably we will talk about parallelising the tallying step. Since this step is computationally intenisive there is much to gain from parallelising it.

The simplest way to parallelise is by using multicore processing on the same machine and `h5vc` supports both parallel tallying and parallel reading from a tally file. Let us revisit the code we used to generate the DNMT3A tally:

```
register(MulticoreParam())
multicore.time <- system.time(theData <- tallyRanges( bamFiles, ranges = dnmt3a, reference = Hsapiens ))
register(SerialParam())
serial.time <- system.time(theData <- tallyRanges( bamFiles, ranges = dnmt3a, reference = Hsapiens ))
serial.time["elapsed"]
```

```
## elapsed
##   4.619
```

```
multicore.time["elapsed"]
```

```
## elapsed
##   4.142
```

The `tallyRanges` function used `bplapply` from the `BiocParallel` package. `bplapply` automatically uses the last registered processing method, e.g. the code `register(MulticoreParam())` registers a multicore processiing setup with as many workers as there are cores available on the machine, `register(SerialParam())` should be fairly self-explanatory. Have a look at `?bplapply` for more details.

The `tallyRangesToFile` function uses the same method for parallelisation, the run-time might be influenced by the I/O performance of the machine it is running on.

```
register(MulticoreParam())
multicore.time <- system.time(tallyRangesToFile( tallyFile, study, bamFiles, ranges = dnmt3a, reference = Hsapiens ))
register(SerialParam())
serial.time <- system.time(tallyRangesToFile( tallyFile, study, bamFiles, ranges = dnmt3a, reference = Hsapiens ))
serial.time["elapsed"]
```

```
## elapsed
##  28.244
```

```
multicore.time["elapsed"]
```

```
## elapsed
##  29.032
```

The performance gains (or losses) of parallel tallying and also parallel reading form a tally file are dependent on your system and it makes sense to try some timing first before commiting to a parallel execution set-up. If you are on a cluster with a powerfull file server or raid cluster the gains can be big, whereas with a local single hard-disk you might actually lose time by trying parallel execution. This is an effect you can likely experience when building this vignette on your laptop.

Let’s revisit the coverage example from before, and compare runtimes of the sequential and parallel versions. Note that we can parallelize all calls to `h5dapply` since by definition the results of the separate blocks can not depend on each other.

```
tallyFile <- system.file( "extdata", "example.tally.hfs5", package = "h5vcData" )
sampleData <- getSampleData(tallyFile, "/ExampleStudy/16")
theRanges <- GRanges("16", ranges = IRanges(start = seq(29e6,29.2e6,1000), width = 1000))
register(SerialParam())
system.time(
  coverages_serial <- h5dapply(
    filename = tallyFile,
    group = "/ExampleStudy",
    names = c( "Coverages" ),
    dims = c(3),
    range = theRanges,
    FUN = binnedCoverage,
    sampledata = sampleData
  )
)
```

```
##    user  system elapsed
##   3.699   0.138   3.837
```

```
register(MulticoreParam())
system.time(
  coverages_parallel <- h5dapply(
    filename = tallyFile,
    group = "/ExampleStudy",
    names = c( "Coverages" ),
    dims = c(3),
    range = theRanges,
    FUN = binnedCoverage,
    sampledata = sampleData
  )
)
```

```
##    user  system elapsed
##   3.907   0.109   4.015
```

We can observer some speed-up here, but it is not extremely impressive, on big machines with many cores and powerful I/O systems we might be able to observe larger gains in speed.

# Using Clusters

For large datasets it makes sense to do the tallying on a cluster and parallelise not only by sample but also by genomic position (usually in bins of some megabases). In order to achieve this `h5vc` provides the `tallyRangesBatch` function.

```
tallyRangesBatch( tallyFile, study = "/DNMT3A", bamfiles = bamFiles, ranges = dnmt3a, reference = Hsapiens )
```

This function uses the `BatchJobs` package to set up a number of jobs on a compute cluster, each one corresponding to a range from the `ranges` parameter. It then waits for those tallying jobs to finish and collects the results and writes them to the destination file serially.

Please also note that you will need a correctly configured installation of `BatchJobs` in order to use this functionality which, depending on the type of cluster you are on, might include a `.BatchJobs.R` file in your working directory and a template file defining cluster functions. I will paste my configuration files below but you will have to adapt them in orde to use the `batchTallies` function.

This is the example configuration I use.

```
cluster.functions <- makeClusterFunctionsLSF("/home/pyl/batchjobs/lsf.tmpl")
mail.start <- "first"
mail.done <- "last"
mail.error <- "all"
mail.from <- "<paul.theodor.pyl@embl.de>"
mail.to <- "<pyl@embl.de>"
mail.control <- list(smtpServer="smtp.embl.de")
```

For explanations of how to customize this have a look at the `BatchJobs` documentation [here](http://sfb876.tu-dortmund.de/PublicPublicationFiles/bischl_etal_2012a.pdf).

The important part is the first line in which we specify that `LSF` shall be used. The call to `makeClusterFunctionsLSF` has one parameter specifying a template file for the cluster calls. This template file has the following content.

```
## Default resources can be set in your .BatchJobs.R by defining the variable
## 'default.resources' as a named list.

## remove everthing in [] if your cluster does not support arrayjobs
#BSUB-J <%= job.name %>[1-<%= arrayjobs %>]         # name of the job / array jobs
#BSUB-o <%= log.file %>                             # output is sent to logfile, stdout + stderr by default
#BSUB-n <%= resources$ncpus %>                      # Number of CPUs on the node
#BSUB-q <%= resources$queue %>                      # Job queue
#BSUB-W <%= resources$walltime %>                   # Walltime in minutes
#BSUB-M <%= resources$memory %>                     # Memory requirements in Kbytes

# we merge R output with stdout from LSF, which gets then logged via -o option
R CMD BATCH --no-save --no-restore "<%= rscript %>" /dev/stdout
```

Once this setup is functional we can test it with the following little script (you might have to change your resources, e.g. the queue name etc.).

```
library("BiocParallel")
library("BatchJobs")
cf <- makeClusterFunctionsLSF("/home/pyl/batchjobs/lsf.tmpl")
bjp <- BatchJobsParam( cluster.functions=cf, resources = list("queue" = "medium_priority", "memory"="4000", "ncpus"="4", walltime="00:30") )
bplapply(1:10, sqrt)
bplapply(1:10, sqrt, BPPARAM=bjp)
```

With the fully configured batch system you can then start tallying on the cluster.