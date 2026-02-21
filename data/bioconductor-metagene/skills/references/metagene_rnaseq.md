# metagene: RNA-Seq version (experimental extension)

#### *30 October 2018*

# Contents

* [1 Introduction](#introduction)
* [2 Loading the metagene package](#loading-the-metagene-package)
* [3 Inputs](#inputs)
  + [3.1 Alignment files (BAM files)](#alignment-files-bam-files)
  + [3.2 Genomic regions](#genomic-regions)
    - [3.2.1 BED files](#bed-files)
    - [3.2.2 GRanges or GRangesList objects - Regions](#granges-or-grangeslist-objects---regions)
  + [3.3 Design groups](#design-groups)
* [4 Analysis steps](#analysis-steps)
  + [4.1 Creation of a metagene object for RNA-seq analysis](#creation-of-a-metagene-object-for-rna-seq-analysis)
  + [4.2 Complete analysis](#complete-analysis)
    - [4.2.1 Initialization](#initialization)
    - [4.2.2 Producing the table](#producing-the-table)
    - [4.2.3 Producing the `data.frame`](#producing-the-data.frame)
    - [4.2.4 Plotting](#plotting)
* [5 Managing large datasets](#managing-large-datasets)
* [6 Comparing profiles with permutations](#comparing-profiles-with-permutations)

**Package**: *[metagene](https://bioconductor.org/packages/3.8/metagene)*
**Modified**: 17 october, 2017
**Compiled**: Tue Oct 30 20:18:58 2018
**License**: Artistic-2.0 | file LICENSE

# 1 Introduction

This experimental extension of metagene allows to use metagene to analyse
RNA-Seq data. The quantification at the gene level of RNA-seq experiment is done
directly from the profile of coverages and the differential expression level can
be done via the similaRpeak package in order to compare profile of coverages.
Design experiment can take into account multiple replicates divided into several
groups of samples. As done by metagene in ChIP-Seq analysis, this experimental
extension uses bootstrap to obtain a better estimation of the mean enrichment
and the confidence interval for every group of samples.

This vignette will introduce all the main features of the metagene RNA-seq
extension.

# 2 Loading the metagene package

```
library(metagene)
```

# 3 Inputs

## 3.1 Alignment files (BAM files)

There is no hard limit in the number of BAM files that can be included in an
analysis (but with too many BAM files, memory may become an issue). BAM files
must be indexed. For instance, if you use a file names `file.bam`, a file
named `file.bam.bai` or `file.bai` must be present in the same directory.

The path (relative or absolute) to the BAM files must be in a vector:

```
bam_files <-
c(system.file("extdata/cyto4.bam", package="metagene"),
  system.file("extdata/cyto3.bam", package="metagene"),
  system.file("extdata/nuc4.bam", package="metagene"),
  system.file("extdata/nuc3.bam", package="metagene"))
```

The possibility to use BAM file from single-ended of pair-ended RNA-seq
experiment is available (see below)

## 3.2 Genomic regions

### 3.2.1 BED files

To compare custom regions of interest, it is possible to use a list of one or
more BED files. Here, we use three genes. The name of the files (without the
extension) will be used to name each gene.
CAUTION : one BED files must be provided by gene of interest. Ranges into BED
files must be the ranges of exons for this gene. (See for instance the
‘DPM1.bed’ BED file into ‘metagene/inst/extdata’).

```
regions <-
c(system.file("extdata/DPM1.bed", package="metagene"),
system.file("extdata/NDUFAB1.bed", package="metagene"))
```

### 3.2.2 GRanges or GRangesList objects - Regions

As an alternative to a list of BED files, `GRangesList` objects
can be used. CAUTION : elements of the `GRangesList` must be the genes of
interest and ranges into each elements of the `GRangesList` must be the exons
regions. You get an example of this with the regions `GRangesList` object
above in the BED files section.

## 3.3 Design groups

A design group contains a set of BAM files that, when put together, represent
a logical analysis. Furthermore, a design group contains the relationship
between every BAM files present.

For instance, the design could be created directly from R.

```
Samples <- c("cyto4.bam",
            "cyto3.bam",
            "nuc4.bam",
            "nuc3.bam")
cyto <- c(1,1,0,0)
nucleo <- c(0,0,1,1)
mydesign <- cbind(Samples, cyto, nucleo)
mydesign <- data.frame(mydesign)
#to make cyto and nucleo colums numeric variables
mydesign$cyto <- cyto
mydesign$nucleo <- nucleo
```

# 4 Analysis steps

A typical metagene analysis will consist steps:

* Extraction the read count of every BAM files in selected regions.
* Conversion in coverage.
* Normalization of the coverage values.
* Table production.
* Data frame production.
* Generation of the metagene plot.
* Profile comparison (differential expression)

## 4.1 Creation of a metagene object for RNA-seq analysis

Two new arguments were introduced : paired\_end and assay. Data used here came
from the ENCSR000CPJ and ENCSR000CPK experiments (ENCODE) using paired-end
polyA mRNA RNA-seq.

```
bam_files <-
c(system.file("extdata/nuc4.bam", package="metagene"))
regions <-
c(system.file("extdata/DPM1.bed", package="metagene"))
# Initialization
mg <- metagene$new(regions = regions,
                    bam_files = bam_files,
                    assay = 'rnaseq',
                    paired_end = TRUE)
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   1916 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
mg$produce_table(normalization = 'RPM')
```

```
## Normalization done
```

```
## produce data table : RNA-Seq
```

```
mg$produce_data_frame()
```

```
## produce data frame : RNA-Seq
```

```
mg$plot(title = 'DPM1')
```

```
## Plot : RNA-Seq (One gene)
```

![](data:image/png;base64...)
Dashed lines strand for exon separations.

NOTE : in paired\_end, a warning message could appear to warn you about how many
alignments with ambiguous pairing were dumped.

As you can see, it is not mandatory to explicitly call each step of the
metagene analysis. For instance, in the previous example, the `plot` function
call the other steps automatically with default values (the next section will
describe the steps in more details).

The plot displayed shows the coverage of the gene DPM1 for the bam file
nuc4.bam. Coverage is expressed in raw, because by default
it is not normalized and orientation here is from 3’ to 5’ (to 0 from 1250 on
horizontal axis) because of the strand orientation of the gene in BED files.

However, you can control normalization, flip and other arguments provided in
produce\_table and produce\_data\_frame methods. Let’s see that together.

## 4.2 Complete analysis

In order to fully control every step of a metagene analysis in RNA-Seq version,
it is important to understand how a complete analysis is performed. If we are
satisfied with the default values, it is not mandatory to explicitly call every
step (as was shown in the previous section).

### 4.2.1 Initialization

During this step, the coverages for every regions specified are extracted from
every BAM files. Let’s start with a bigger dataset as introduced in inputs
section. Here, we will use four bam files and three genes.

```
bam_files <-
c(system.file("extdata/cyto4.bam", package="metagene"),
  system.file("extdata/cyto3.bam", package="metagene"),
  system.file("extdata/nuc4.bam", package="metagene"),
  system.file("extdata/nuc3.bam", package="metagene"))
regions <-
c(system.file("extdata/DPM1.bed", package="metagene"),
system.file("extdata/NDUFAB1.bed", package="metagene"))
mg <- metagene$new(regions = regions,
                    bam_files = bam_files,
                    assay = 'rnaseq',
                    paired_end = TRUE)
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   8737 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   7738 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   3394 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   2168 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

### 4.2.2 Producing the table

No new parameters was added to the produce\_table method. However, new colums to
the table were added but is completely transparent for user. Colums names are now :
. Regions was kept and not replaced by gene but
stands for gene names. Data were not binned as for ChIP-Seq analysis and bin
column was replaced by nuc (for nucleotide) column.

```
mg$produce_table(flip_regions = TRUE, normalization = 'RPM')
```

```
## Normalization done
```

```
## produce data table : RNA-Seq
```

```
## RNA-Seq flip/unflip
```

```
tab <- mg$get_table()
```

Here the flip argument is `TRUE`. Thus, all genes will be oriented from 5’ to 3’
on the metagene plot. The ‘Reads Per Millions’ (RPM) normalization was done.

### 4.2.3 Producing the `data.frame`

The metagene plot are produced using the `ggplot2` package, which require a
`data.frame` as input. During this step, the values of the ribbon are
calculated. Metagene RNA-Seq version uses “bootstrap” to obtain a better
estimation of the mean coverage for every positions in each group samples.

```
mg$produce_data_frame()
```

```
## produce data frame : RNA-Seq
```

An additionnal option was implemented into the produce\_data\_frame method. The
possibility to remove values which are under a certain threshold. This option
is used in order to remove, for instance, exon or part of exon for which there
is no data and thereby obtain a profile without gaps. There are the new
arguments to do that : (1) ‘avoid\_gaps’ a logical argument to allow this
removal or not, (2) ‘bam\_name’ a character argument that give the name of the
bam file to take as reference for values to remove also for other samples
(default : the first sample in table) (3) ‘gaps\_threshold’ a numeric threshold
under which value will be removed from data\_frame (default = 0).

```
bam_files <-
c(system.file("extdata/cyto4.bam", package="metagene"))
region <-
c(system.file("extdata/NDUFAB1.bed", package="metagene"))
mg <- metagene$new(regions = region, bam_files = bam_files, assay = 'rnaseq')
mg$produce_table(flip_regions = TRUE, normalization = 'RPM')
```

```
## Normalization done
```

```
## produce data table : RNA-Seq
```

```
## RNA-Seq flip/unflip
```

```
mg$plot(title = 'with all normalized values')
```

```
## produce data frame : RNA-Seq
```

```
## Plot : RNA-Seq (One gene)
```

![](data:image/png;base64...)

```
mg$produce_data_frame(avoid_gaps = TRUE,
                        bam_name = "cyto4",
                        gaps_threshold = 30)
```

```
## produce data frame : RNA-Seq
```

```
mg$plot(title = 'without normalized values under 30')
```

```
## Plot : RNA-Seq (One gene)
```

![](data:image/png;base64...)

### 4.2.4 Plotting

During this step, metagene will use the `data.frame` to plot the calculated
values using `ggplot2`. A subset of the gene and design can be selected by using
the `region_names` and `design_names` arguments. The `region_names` correspond
to the names of the genes used during the initialization. The `design_name`
will vary depending if a design was added. If no design was added, this param
correspond to the BAM name or BAM filenames. Otherwise, we have to use the
names of the columns from the design.

```
bam_files <-
c(system.file("extdata/cyto4.bam", package="metagene"),
  system.file("extdata/cyto3.bam", package="metagene"),
  system.file("extdata/nuc4.bam", package="metagene"),
  system.file("extdata/nuc3.bam", package="metagene"))
regions <-
c(system.file("extdata/DPM1.bed", package="metagene"),
system.file("extdata/NDUFAB1.bed", package="metagene"))
mg <- metagene$new(regions = regions,
                    bam_files = bam_files,
                    assay = 'rnaseq',
                    paired_end = TRUE)
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   8737 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   7738 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   3394 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   2168 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
mg$produce_table(normalization = 'RPM')
```

```
## Normalization done
```

```
## produce data table : RNA-Seq
```

```
mg$produce_data_frame(avoid_gaps = TRUE,
                        bam_name = "cyto4",
                        gaps_threshold = 30)
```

```
## produce data frame : RNA-Seq
```

```
mg$plot(region_names = "DPM1", title = "Demo plot subset RNA-Seq")
```

```
## Plot : RNA-Seq (One gene)
```

![](data:image/png;base64...)

# 5 Managing large datasets

While `metagene` try to reduce it’s memory usage, it’s possible to run into
memory limits when working with multiple large datasets (especially when there
is a lot of genes).

One way to avoid this is to analyse each dataset seperately and then merge just
before producing the metagene plot:

```
regions <-
c(system.file("extdata/DPM1.bed", package="metagene"),
system.file("extdata/NDUFAB1.bed", package="metagene"))
bam_files <-
c(system.file("extdata/cyto4.bam", package="metagene"),
  system.file("extdata/cyto3.bam", package="metagene"),
  system.file("extdata/nuc4.bam", package="metagene"),
  system.file("extdata/nuc3.bam", package="metagene"))
mg1 <- metagene$new(bam_files = bam_files[1:2], regions = regions,
                            assay = 'rnaseq', paired_end = TRUE)
mg1$produce_data_frame()
mg2 <- metagene$new(bam_files = bam_files[3:4], regions = regions,
                            assay = 'rnaseq', paired_end = TRUE)
mg2$produce_data_frame()
```

Then you can extract the `data.frame`s and combine them with `rbind`:

```
df1 <- mg1$get_data_frame()
df2 <- mg2$get_data_frame()
df <- rbind(df1, df2)
```

Finally, you can use the `plot_metagene` function to produce the metagene plot:

```
p <- plot_metagene(df)
p + ggplot2::ggtitle("Managing large datasets")
```

Here three genes are drawn on the same plot. Strong solid lines stand for gene
separations and dashed lines for exon separations.

# 6 Comparing profiles with permutations

It is possible to compare two metagene profiles using the `permutation_test`
function provided with the `metagene` package. Please note that the permutation
tests functionality is still in development and is expected to change in future
releases.

The first step is to decide which profiles we want to compare and extract the
corresponding tables :

It is possible to compare two metagene profiles using the `permutation_test`
function provided with the `metagene` package. Please note that the permutation
tests functionality is still in development and is expected to change in future
releases.

As before in produce\_data\_frame, you get the possibility to remove values under
a certain threshold. In order to be able to statistically compare these profiles
underestimated by the values under the threshold, a compagnon function called
‘avoid\_gaps\_update’ was created to carry out the same treatment underwent at
the data\_frame level.

The first step is to decide which profiles we want to compare and extract the
corresponding tables :

```
mg <- metagene$new(bam_files = bam_files, regions = regions,
                            assay = 'rnaseq', paired_end = TRUE)
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   8737 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   7738 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   3394 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
## Warning in .make_GAlignmentPairs_from_GAlignments(gal, strandMode = strandMode, :   2168 alignments with ambiguous pairing were dumped.
##     Use 'getDumpedAlignments()' to retrieve them from the dump environment.
```

```
mg$produce_table(design = mydesign, normalization = 'RPM')
```

```
## Normalization done
```

```
## produce data table : RNA-Seq
```

```
tab <- mg$get_table()
tab0 <- metagene:::avoid_gaps_update(tab,
       bam_name = 'cyto4', gaps_threshold = 10)
tab0 <- tab0[which(tab0$region == "NDUFAB1"),]
tab1 <- tab0[which(tab0$design == "cyto"),]
tab2 <- tab0[which(tab0$design == "nucleo"),]
```

Then we defined to function to use to compare the two profiles. For this, a
companion package of `metagene` named *[similaRpeak](https://bioconductor.org/packages/3.8/similaRpeak)* provides
multiple metrics.

For this example, we will prepare a function to calculate the
RATIO\_INTERSECT between two profiles:

```
library(similaRpeak)
perm_fun <- function(profile1, profile2) {
    sim <- similarity(profile1, profile2)
    sim[["metrics"]][["RATIO_INTERSECT"]]
}
```

We then compare our two profiles using this metric:

```
ratio_intersect <-
  perm_fun(tab1[, .(moy=mean(value)), by=nuc]$moy,
           tab2[, .(moy=mean(value)), by=nuc]$moy)
ratio_intersect
```

```
## [1] 0.4185373
```

To check if this value is significant, we can permute the two tables that
were used to produce the profile and calculate their
RATIO\_INTERSECT:

```
permutation_results <- permutation_test(tab1, tab2, sample_size = 2,
                                        sample_count = 1000, FUN = perm_fun)
```

NB : sample\_size here is very low to get an accurate permutation test. More
replicates by design are needed to improve the quality of the result.

Finally, we check how often the calculated value is greater than the results of
the permutations:

```
sum(ratio_intersect >= permutation_results) /
                                length(permutation_results)
```

```
## [1] 0.068
```

```
mg$plot(region_names = 'NDUFAB1', title='NDUFAB1')
```

```
## produce data frame : RNA-Seq
```

```
## Plot : RNA-Seq (One gene)
```

![](data:image/png;base64...)