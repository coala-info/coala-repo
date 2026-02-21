# metagene: a package to produce metagene plots

#### *30 October 2018*

# Contents

* [1 Introduction](#introduction)
* [2 Loading the metagene package](#loading-the-metagene-package)
* [3 Inputs](#inputs)
  + [3.1 Alignment files (BAM files)](#alignment-files-bam-files)
  + [3.2 Genomic regions](#genomic-regions)
    - [3.2.1 BED files](#bed-files)
    - [3.2.2 GRanges or GRangesList objects - Regions](#granges-or-grangeslist-objects---regions)
    - [3.2.3 Available datasets](#available-datasets)
  + [3.3 Design groups](#design-groups)
    - [3.3.1 Design groups from a file](#design-groups-from-a-file)
    - [3.3.2 Design groups from R](#design-groups-from-r)
* [4 Analysis steps](#analysis-steps)
  + [4.1 Minimal analysis](#minimal-analysis)
  + [4.2 Complete analysis](#complete-analysis)
    - [4.2.1 Initialization](#initialization)
    - [4.2.2 Producing the table](#producing-the-table)
    - [4.2.3 Producing the `data.frame`](#producing-the-data.frame)
    - [4.2.4 Plotting](#plotting)
* [5 Manipulating the `metagene` objects](#manipulating-the-metagene-objects)
  + [5.1 Getters](#getters)
    - [5.1.1 `get_table`](#get_table)
    - [5.1.2 `get_matrices`](#get_matrices)
    - [5.1.3 `get_data_frame`](#get_data_frame)
    - [5.1.4 `get_params`](#get_params)
    - [5.1.5 `get_design`](#get_design)
    - [5.1.6 `get_bam_count`](#get_bam_count)
    - [5.1.7 `get_regions`](#get_regions)
    - [5.1.8 `get_raw_coverages`](#get_raw_coverages)
    - [5.1.9 `get_normalized_coverages`](#get_normalized_coverages)
  + [5.2 Chaining functions](#chaining-functions)
  + [5.3 Copying a metagene object](#copying-a-metagene-object)
* [6 Managing large datasets](#managing-large-datasets)
* [7 Comparing profiles with permutations](#comparing-profiles-with-permutations)

**Package**: *[metagene](https://bioconductor.org/packages/3.8/metagene)*
**Modified**: 18 september, 2015
**Compiled**: Tue Oct 30 20:18:10 2018
**License**: Artistic-2.0 | file LICENSE

# 1 Introduction

This package produces metagene-like plots to compare the behavior of
DNA-interacting proteins at selected groups of features. A typical analysis
can be done in viscinity of transcription start sites (TSS) of genes or at any
regions of interest (such as enhancers). Multiple combinations of group of
features and/or group of bam files can be compared in a single analysis.
Bootstraping analysis is used to compare the groups and locate regions with
statistically different enrichment profiles. In order to increase the
sensitivity of the analysis, alignment data is used instead of peaks produced
with peak callers (i.e.: MACS2 or PICS). The metagene package uses bootstrap
to obtain a better estimation of the mean enrichment and the confidence
interval for every group of samples.

This vignette will introduce all the main features of the metagene package.

# 2 Loading the metagene package

```
library(metagene)
```

# 3 Inputs

## 3.1 Alignment files (BAM files)

There is no hard limit in the number of BAM files that can be included in an
analysis (but with too many BAM files, memory may become an issue). BAM files
must be indexed. For instance, if you use a file names `file.bam`, a file
named `file.bam.bai` or `file.bai`must be present in the same directory.

The path (relative or absolute) to the BAM files must be in a vector:

```
bam_files <- get_demo_bam_files()
bam_files
```

```
## [1] "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align1_rep1.bam"
## [2] "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align1_rep2.bam"
## [3] "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align2_rep1.bam"
## [4] "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align2_rep2.bam"
## [5] "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/ctrl.bam"
```

For this demo, we have 2 samples (each with 2 replicates). It is also possible
to use a named vector to add your own names to each BAM files:

```
named_bam_files <- bam_files
names(named_bam_files) <- letters[seq_along(bam_files)]
named_bam_files
```

```
##                                                                    a
## "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align1_rep1.bam"
##                                                                    b
## "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align1_rep2.bam"
##                                                                    c
## "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align2_rep1.bam"
##                                                                    d
## "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align2_rep2.bam"
##                                                                    e
##        "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/ctrl.bam"
```

Using named BAM files can simplify the use of the metagene helper functions and
the creation of the design.

## 3.2 Genomic regions

### 3.2.1 BED files

To compare custom regions of interest, it is possible to use a list of one or
more BED files.

```
regions <- get_demo_regions()
regions
```

```
## [1] "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/list1.bed"
## [2] "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/list2.bed"
```

The name of the files (without the extension) will be used to name each groups.

`metagene` also support the
[narrowPeak](https://genome.ucsc.edu/FAQ/FAQformat.html#format12)
and the [broadPeak](https://genome.ucsc.edu/FAQ/FAQformat.html#format13).

### 3.2.2 GRanges or GRangesList objects - Regions

As an alternative to a list of BED files, `GRanges` or `GRangesList` objects
can be used.

### 3.2.3 Available datasets

Some common datasets are already available with the `metagene` package:

* `promoters_hg19`
* `promoters_hg18`
* `promoters_mm10`
* `promoters_mm9`

```
data(promoters_hg19)
promoters_hg19
```

```
## GRanges object with 23056 ranges and 1 metadata column:
##         seqnames              ranges strand |     gene_id
##            <Rle>           <IRanges>  <Rle> | <character>
##       1    chr19   58873215-58875214      - |           1
##      10     chr8   18247755-18249754      + |          10
##     100    chr20   43279377-43281376      - |         100
##    1000    chr18   25756446-25758445      - |        1000
##   10000     chr1 244005887-244007886      - |       10000
##     ...      ...                 ...    ... .         ...
##    9991     chr9 115094945-115096944      - |        9991
##    9992    chr21   35735323-35737322      + |        9992
##    9993    chr22   19108968-19110967      - |        9993
##    9994     chr6   90538619-90540618      + |        9994
##    9997    chr22   50963906-50965905      - |        9997
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
```

For more details about each datasets, please refer to their documentation
(i.e.:`?promoters_hg19`).

## 3.3 Design groups

A design group contains a set of BAM files that, when put together, represent
a logical analysis. Furthermore, a design group contains the relationship
between every BAM files present. Samples (with or without replicates) and
controls can be assigned to a same design group. There can be as many groups
as necessary. A BAM file can be assigned to more than one group.

To represent the relationship between every BAM files, design groups must have
the following columns:

* The list of paths to every BAM files related to an analysis.
* One column per group of files (replicates and/or controls).

There is two possible way to create design groups, by reading a file or by
directly creating a design object in R.

### 3.3.1 Design groups from a file

Design groups can be loaded into the metagene package by using a text file. As
the relationship between BAM files as to be specified, the following columns
are mandatory:

* First column: The list of paths (absolute or relative) to every BAM files
  for all the design groups, the BAM filenames or the BAM names (if a named BAM.
  file was used).
* Following columns: One column per design group (replicates and/or controls).
  The column can take only three values:
  + 0: ignore file
  + 1: input
  + 2: control

The file must also contain a header. It is recommanded to use `Samples` for the
name of the first column, but the value is not checked. The other columns in
the design file will be used for naming design groups, and must be unique.

```
fileDesign <- system.file("extdata/design.txt", package="metagene")
design <- read.table(fileDesign, header=TRUE, stringsAsFactors=FALSE)
design$Samples <- paste(system.file("extdata", package="metagene"),
                        design$Samples, sep="/")
kable(design)
```

| Samples | align1 | align2 |
| --- | --- | --- |
| /tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align1\_rep1.bam | 1 | 0 |
| /tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align1\_rep2.bam | 1 | 0 |
| /tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align2\_rep1.bam | 0 | 1 |
| /tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align2\_rep2.bam | 0 | 1 |
| /tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/ctrl.bam | 2 | 2 |

### 3.3.2 Design groups from R

It is not obligatory to use a design file, you can create the design
`data.frame` using your prefered method (as long as the restrictions on the
values mentioned previously are respected).

For instance, the previous design data.frame could have been create directly
in R:

```
design <- data.frame(Samples = c("align1_rep1.bam", "align1_rep2.bam",
                    "align2_rep1.bam", "align2_rep2.bam", "ctrl.bam"),
                    align1 = c(1,1,0,0,2), align2 = c(0,0,1,1,2))
design$Samples <- paste0(system.file("extdata", package="metagene"), "/",
                        design$Samples)
kable(design)
```

| Samples | align1 | align2 |
| --- | --- | --- |
| /tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align1\_rep1.bam | 1 | 0 |
| /tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align1\_rep2.bam | 1 | 0 |
| /tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align2\_rep1.bam | 0 | 1 |
| /tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align2\_rep2.bam | 0 | 1 |
| /tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/ctrl.bam | 2 | 2 |

# 4 Analysis steps

A typical metagene analysis will consist steps:

* Extraction the read count of every BAM files in selected regions.
* Conversion in coverage.
* Noise removal
* Normalization of the coverage values.
* Table production.
* Data frame production.
* Generation of the metagene plot.

## 4.1 Minimal analysis

A minimal metagene analysis can be performed in 2 steps:

1. Initialization (the `new` function).
2. `plot`

```
regions <- get_demo_regions()
bam_files <- get_demo_bam_files()
# Initialization
mg <- metagene$new(regions = regions, bam_files = bam_files)
# Plotting
mg$plot(title = "Demo metagene plot")
```

```
## produce data table : ChIP-Seq
```

```
## produce data frame : ChIP-Seq
```

```
## Plot : ChIP-Seq
```

![](data:image/png;base64...)
As you can see, it is not mandatory to explicitly call each step of the
metagene analysis. For instance, in the previous example, the `plot` function
call the other steps automatically with default values (the next section will
describe the steps in more details).

In this specific case, the plot is messy since by default
*[metagene](https://bioconductor.org/packages/3.8/metagene)* will produce a curve for each possible combinations of
BAM file and regions. Since we have 5 BAM files and
2 regions, this gives us
10 curves.

If we want more control on how every step of the analysis are performed, we
have to call each functions directly.

## 4.2 Complete analysis

In order to fully control every step of a metagene analysis, it is important to
understand how a complete analysis is performed. If we are satisfied with the
default values, it is not mandatory to explicitly call every step (as was shown
in the previous section).

### 4.2.1 Initialization

During this step, the coverages for every regions specified are extracted from
every BAM files. More specifically, a new `GRanges` is created by combining
all the regions specified with the `regions` param of the `new` function.

```
regions <- get_demo_regions()
bam_files <- get_demo_bam_files()
mg <- metagene$new(regions = regions, bam_files = bam_files)
```

### 4.2.2 Producing the table

To produce the table, coverages (produced from Genomics regions (.BED),
Alignment Files (.BAM) and Design Sheet) was treated for noise removal
and normalized. Furthermore, to reduce the computation time during the
following steps, the positions are also binned. Regions, designs, bins,
associated values and orientation of strands are pulled into a data.table
called ‘table’ and accessible thanks to the getter `get_table`.

We can control the size of the bins with the `bin_count` argument. By
default, a `bin_count` of 100 will be used during this step.

```
mg$produce_table()
```

```
## produce data table : ChIP-Seq
```

We can also use the design we produced earlier to remove background signal and
combine replicates:

```
mg$produce_table(design = design)
```

```
## produce data table : ChIP-Seq
```

### 4.2.3 Producing the `data.frame`

The metagene plot are produced using the `ggplot2` package, which require a
`data.frame` as input. During this step, the values of the ribbon are
calculated. Metagene uses “bootstrap” to obtain a better estimation of the
mean of enrichment for every positions in each groups.

```
mg$produce_data_frame()
```

```
## produce data frame : ChIP-Seq
```

### 4.2.4 Plotting

During this step, metagene will use the `data.frame` to plot the calculated
values using `ggplot2`. We show a subset of the regions by using the
`region_names` and `design_names` parameter. The `region_names` correspond to
the names of the regions used during the initialization. The `design_name`
will vary depending if a design was added. If no design was added, this param
correspond to the BAM name or BAM filenames. Otherwise, we have to use the
names of the columns from the design.

```
mg$plot(region_names = "list1", title = "Demo plot subset")
```

```
## Plot : ChIP-Seq
```

![](data:image/png;base64...)

# 5 Manipulating the `metagene` objects

## 5.1 Getters

Multiple getters functions are available to access the data that is stored in a
`metagene` object.

### 5.1.1 `get_table`

To get the data.table containing regions, designs, bins, values at bins and
orientation of strands.

```
mg <- get_demo_metagene()
mg$produce_table()
```

```
## produce data table : ChIP-Seq
```

```
mg$get_table()
```

```
##        region      design bin value strand
##     1:  list1 align1_rep1   1  0.00      *
##     2:  list1 align1_rep1   2  0.75      *
##     3:  list1 align1_rep1   3  1.55      *
##     4:  list1 align1_rep1   4  1.15      *
##     5:  list1 align1_rep1   5  1.25      *
##    ---
## 49996:  list2        ctrl  96  0.00      *
## 49997:  list2        ctrl  97  0.00      *
## 49998:  list2        ctrl  98  0.00      *
## 49999:  list2        ctrl  99  0.00      *
## 50000:  list2        ctrl 100  0.00      *
```

### 5.1.2 `get_matrices`

To get the data.table as matrices (the former data structure)

```
mg <- get_demo_metagene()
mg$produce_table()
```

```
## produce data table : ChIP-Seq
```

```
m <- mg$get_matrices()
# m$list1$ctrl$input to access to region 'list1' and 'ctrl' design
```

### 5.1.3 `get_data_frame`

get\_data\_frame = function(region\_names = NULL, design\_names = NULL)
To get the data.frame containing regions and design

```
mg <- get_demo_metagene()
mg$produce_table()
```

```
## produce data table : ChIP-Seq
```

```
mg$produce_data_frame()
```

```
## produce data frame : ChIP-Seq
```

```
mg$get_data_frame()
```

```
##      region      design bin value strand       qinf       qsup
## 1     list1 align1_rep1   1 0.449      * 0.40872875 0.50073875
## 2     list1 align1_rep1   2 0.552      * 0.49505000 0.62738000
## 3     list1 align1_rep1   3 0.609      * 0.56043250 0.65749875
## 4     list1 align1_rep1   4 0.534      * 0.48038750 0.57134875
## 5     list1 align1_rep1   5 0.522      * 0.47618875 0.55479000
## 6     list1 align1_rep1   6 0.589      * 0.53418500 0.63912125
## 7     list1 align1_rep1   7 0.704      * 0.62376250 0.78122625
## 8     list1 align1_rep1   8 0.591      * 0.53952625 0.63576500
## 9     list1 align1_rep1   9 0.562      * 0.52068250 0.62936750
## 10    list1 align1_rep1  10 0.488      * 0.43947375 0.55578000
## 11    list1 align1_rep1  11 0.614      * 0.56539250 0.67144250
## 12    list1 align1_rep1  12 0.745      * 0.65669625 0.82533500
## 13    list1 align1_rep1  13 0.772      * 0.67461625 0.90073250
## 14    list1 align1_rep1  14 0.659      * 0.58110000 0.76018000
## 15    list1 align1_rep1  15 0.481      * 0.42740625 0.51900750
## 16    list1 align1_rep1  16 0.558      * 0.50717125 0.60522375
## 17    list1 align1_rep1  17 0.614      * 0.55349125 0.66033250
## 18    list1 align1_rep1  18 0.708      * 0.65450750 0.77218875
## 19    list1 align1_rep1  19 0.847      * 0.78544750 0.88899750
## 20    list1 align1_rep1  20 0.745      * 0.70396750 0.79160250
## 21    list1 align1_rep1  21 0.731      * 0.68566000 0.78408125
## 22    list1 align1_rep1  22 0.795      * 0.73268125 0.83454500
## 23    list1 align1_rep1  23 0.772      * 0.71076750 0.83156000
## 24    list1 align1_rep1  24 0.866      * 0.81130000 0.92697125
## 25    list1 align1_rep1  25 0.872      * 0.81824875 0.92806125
## 26    list1 align1_rep1  26 0.841      * 0.76030125 0.88411625
## 27    list1 align1_rep1  27 0.808      * 0.74182000 0.88867000
## 28    list1 align1_rep1  28 0.835      * 0.76221875 0.94416125
## 29    list1 align1_rep1  29 0.915      * 0.83168500 1.01568875
## 30    list1 align1_rep1  30 1.123      * 0.99473750 1.21575250
## 31    list1 align1_rep1  31 1.161      * 1.02608375 1.42322375
## 32    list1 align1_rep1  32 1.122      * 0.94225750 1.26984000
## 33    list1 align1_rep1  33 1.301      * 1.19188875 1.38691625
## 34    list1 align1_rep1  34 1.235      * 1.15759750 1.32317875
## 35    list1 align1_rep1  35 1.285      * 1.22006125 1.35937000
## 36    list1 align1_rep1  36 1.497      * 1.42678625 1.56522625
## 37    list1 align1_rep1  37 1.480      * 1.35001750 1.62179000
## 38    list1 align1_rep1  38 1.433      * 1.32769750 1.59105625
## 39    list1 align1_rep1  39 1.234      * 1.11188250 1.34589625
## 40    list1 align1_rep1  40 1.227      * 1.13510500 1.27424750
## 41    list1 align1_rep1  41 1.302      * 1.20304375 1.41935375
## 42    list1 align1_rep1  42 1.267      * 1.17485750 1.33138875
## 43    list1 align1_rep1  43 1.584      * 1.48206500 1.65898375
## 44    list1 align1_rep1  44 1.602      * 1.50812500 1.68836375
## 45    list1 align1_rep1  45 1.727      * 1.64279875 1.80783875
## 46    list1 align1_rep1  46 2.020      * 1.91587250 2.09126875
## 47    list1 align1_rep1  47 2.120      * 2.05118250 2.20857625
## 48    list1 align1_rep1  48 2.044      * 1.96935250 2.14411375
## 49    list1 align1_rep1  49 2.196      * 2.11625375 2.28966250
## 50    list1 align1_rep1  50 2.340      * 2.20789375 2.42242125
## 51    list1 align1_rep1  51 2.367      * 2.22444500 2.46349500
## 52    list1 align1_rep1  52 2.374      * 2.26863625 2.48797750
## 53    list1 align1_rep1  53 2.086      * 1.98790625 2.21186750
## 54    list1 align1_rep1  54 2.053      * 1.93602500 2.17749125
## 55    list1 align1_rep1  55 2.126      * 2.02675125 2.24485000
## 56    list1 align1_rep1  56 1.710      * 1.64771375 1.79860625
## 57    list1 align1_rep1  57 1.429      * 1.34939750 1.51084500
## 58    list1 align1_rep1  58 1.425      * 1.36145500 1.50492250
## 59    list1 align1_rep1  59 1.618      * 1.52570750 1.72049875
## 60    list1 align1_rep1  60 1.707      * 1.61424750 1.77237750
## 61    list1 align1_rep1  61 1.716      * 1.63331125 1.78481375
## 62    list1 align1_rep1  62 1.699      * 1.56718375 1.85162750
## 63    list1 align1_rep1  63 1.383      * 1.28419125 1.48638750
## 64    list1 align1_rep1  64 1.316      * 1.22450875 1.42886250
## 65    list1 align1_rep1  65 1.293      * 1.22058250 1.39940375
## 66    list1 align1_rep1  66 1.136      * 1.07323375 1.17782375
## 67    list1 align1_rep1  67 1.095      * 1.02925250 1.14510750
## 68    list1 align1_rep1  68 1.028      * 0.94595250 1.07261500
## 69    list1 align1_rep1  69 0.895      * 0.81590625 0.95672750
## 70    list1 align1_rep1  70 0.825      * 0.77589750 0.86943375
## 71    list1 align1_rep1  71 0.898      * 0.84383750 0.96200375
## 72    list1 align1_rep1  72 0.856      * 0.79723000 0.91687500
## 73    list1 align1_rep1  73 0.879      * 0.81078250 0.95637125
## 74    list1 align1_rep1  74 0.899      * 0.85124750 0.93768500
## 75    list1 align1_rep1  75 0.958      * 0.90262000 1.02106625
## 76    list1 align1_rep1  76 1.048      * 1.00095125 1.11151000
## 77    list1 align1_rep1  77 0.963      * 0.89503000 1.04467625
## 78    list1 align1_rep1  78 0.941      * 0.88129250 1.00743125
## 79    list1 align1_rep1  79 0.823      * 0.78696750 0.89157000
## 80    list1 align1_rep1  80 0.564      * 0.52920125 0.60570500
## 81    list1 align1_rep1  81 0.486      * 0.43988125 0.54254875
## 82    list1 align1_rep1  82 0.730      * 0.66717625 0.79809500
## 83    list1 align1_rep1  83 0.820      * 0.76711750 0.87610750
## 84    list1 align1_rep1  84 0.711      * 0.67422500 0.75421875
## 85    list1 align1_rep1  85 0.702      * 0.64469500 0.75591125
## 86    list1 align1_rep1  86 0.664      * 0.59035750 0.74523375
## 87    list1 align1_rep1  87 0.508      * 0.46475375 0.56669125
## 88    list1 align1_rep1  88 0.538      * 0.51456250 0.57898125
## 89    list1 align1_rep1  89 0.582      * 0.54582250 0.60946750
## 90    list1 align1_rep1  90 0.701      * 0.65328625 0.76251250
## 91    list1 align1_rep1  91 0.628      * 0.56710375 0.66454375
## 92    list1 align1_rep1  92 0.649      * 0.61327000 0.68793750
## 93    list1 align1_rep1  93 0.900      * 0.85639125 0.96779500
## 94    list1 align1_rep1  94 0.830      * 0.76252250 0.91090875
## 95    list1 align1_rep1  95 0.590      * 0.53941750 0.63888125
## 96    list1 align1_rep1  96 0.557      * 0.50412125 0.60784125
## 97    list1 align1_rep1  97 0.575      * 0.53305000 0.61700000
## 98    list1 align1_rep1  98 0.525      * 0.47214750 0.58070125
## 99    list1 align1_rep1  99 0.404      * 0.36924625 0.44327375
## 100   list1 align1_rep1 100 0.537      * 0.50340750 0.56867750
## 101   list1 align1_rep2   1 0.092      * 0.05491250 0.11868500
## 102   list1 align1_rep2   2 0.161      * 0.11131875 0.23112875
## 103   list1 align1_rep2   3 0.201      * 0.15970125 0.23407625
## 104   list1 align1_rep2   4 0.147      * 0.12628000 0.17157125
## 105   list1 align1_rep2   5 0.077      * 0.06362000 0.09167375
## 106   list1 align1_rep2   6 0.180      * 0.16496125 0.20248375
## 107   list1 align1_rep2   7 0.267      * 0.23270625 0.30294125
## 108   list1 align1_rep2   8 0.233      * 0.20327125 0.26758375
## 109   list1 align1_rep2   9 0.172      * 0.14458500 0.20141500
## 110   list1 align1_rep2  10 0.253      * 0.23208875 0.27586125
## 111   list1 align1_rep2  11 0.258      * 0.23165125 0.29386375
## 112   list1 align1_rep2  12 0.176      * 0.15160875 0.20529375
## 113   list1 align1_rep2  13 0.193      * 0.16904125 0.22461125
## 114   list1 align1_rep2  14 0.216      * 0.17898750 0.25711375
## 115   list1 align1_rep2  15 0.164      * 0.14300625 0.18697125
## 116   list1 align1_rep2  16 0.123      * 0.10162625 0.14688375
## 117   list1 align1_rep2  17 0.110      * 0.09100500 0.12496250
## 118   list1 align1_rep2  18 0.133      * 0.11696250 0.15189250
## 119   list1 align1_rep2  19 0.169      * 0.15289625 0.19576375
## 120   list1 align1_rep2  20 0.265      * 0.22796125 0.30062250
## 121   list1 align1_rep2  21 0.306      * 0.26444250 0.33975875
## 122   list1 align1_rep2  22 0.399      * 0.35908000 0.43999750
## 123   list1 align1_rep2  23 0.326      * 0.29293500 0.36412000
## 124   list1 align1_rep2  24 0.179      * 0.15595375 0.20180875
## 125   list1 align1_rep2  25 0.251      * 0.21442375 0.28230000
## 126   list1 align1_rep2  26 0.369      * 0.30893625 0.41315875
## 127   list1 align1_rep2  27 0.372      * 0.33178500 0.40891875
## 128   list1 align1_rep2  28 0.320      * 0.29094875 0.35800375
## 129   list1 align1_rep2  29 0.254      * 0.22848250 0.28876250
## 130   list1 align1_rep2  30 0.270      * 0.23171375 0.30539750
## 131   list1 align1_rep2  31 0.382      * 0.33122875 0.43553500
## 132   list1 align1_rep2  32 0.402      * 0.33259000 0.46467500
## 133   list1 align1_rep2  33 0.354      * 0.31349500 0.39423125
## 134   list1 align1_rep2  34 0.499      * 0.46303000 0.53431500
## 135   list1 align1_rep2  35 0.635      * 0.57249375 0.69820250
## 136   list1 align1_rep2  36 0.915      * 0.85981375 0.99111875
## 137   list1 align1_rep2  37 1.010      * 0.92057000 1.11050625
## 138   list1 align1_rep2  38 0.811      * 0.76223500 0.90566375
## 139   list1 align1_rep2  39 0.678      * 0.63013750 0.72793250
## 140   list1 align1_rep2  40 0.727      * 0.66024750 0.79195125
## 141   list1 align1_rep2  41 0.769      * 0.70935500 0.85524625
## 142   list1 align1_rep2  42 0.760      * 0.68729250 0.81661250
## 143   list1 align1_rep2  43 0.647      * 0.60316250 0.69384875
## 144   list1 align1_rep2  44 0.849      * 0.79391125 0.89243625
## 145   list1 align1_rep2  45 1.043      * 0.99871250 1.11124500
## 146   list1 align1_rep2  46 1.037      * 0.97386375 1.09605750
## 147   list1 align1_rep2  47 1.105      * 1.03048375 1.15961250
## 148   list1 align1_rep2  48 1.042      * 0.98026250 1.11244375
## 149   list1 align1_rep2  49 0.911      * 0.87674750 0.98169250
## 150   list1 align1_rep2  50 0.962      * 0.86231750 1.01987750
## 151   list1 align1_rep2  51 1.255      * 1.12713375 1.34496375
## 152   list1 align1_rep2  52 1.254      * 1.15263250 1.32216125
## 153   list1 align1_rep2  53 1.109      * 1.05654000 1.17098500
## 154   list1 align1_rep2  54 1.160      * 1.10477625 1.20633000
## 155   list1 align1_rep2  55 1.112      * 1.05892125 1.18363625
## 156   list1 align1_rep2  56 0.912      * 0.86818125 0.97943500
## 157   list1 align1_rep2  57 0.804      * 0.75412125 0.84965375
## 158   list1 align1_rep2  58 0.721      * 0.66669125 0.76683250
## 159   list1 align1_rep2  59 0.542      * 0.50701125 0.56847500
## 160   list1 align1_rep2  60 0.425      * 0.35079375 0.48720375
## 161   list1 align1_rep2  61 0.479      * 0.42651250 0.53564750
## 162   list1 align1_rep2  62 0.729      * 0.67096875 0.78296375
## 163   list1 align1_rep2  63 0.796      * 0.72905375 0.85641500
## 164   list1 align1_rep2  64 0.647      * 0.60808125 0.70377750
## 165   list1 align1_rep2  65 0.603      * 0.54838125 0.66513375
## 166   list1 align1_rep2  66 0.399      * 0.35335375 0.45600625
## 167   list1 align1_rep2  67 0.430      * 0.39541000 0.46016000
## 168   list1 align1_rep2  68 0.498      * 0.46251375 0.52851750
## 169   list1 align1_rep2  69 0.338      * 0.30762250 0.36306500
## 170   list1 align1_rep2  70 0.440      * 0.39198875 0.49716250
## 171   list1 align1_rep2  71 0.454      * 0.39618500 0.48781500
## 172   list1 align1_rep2  72 0.445      * 0.41222000 0.48106500
## 173   list1 align1_rep2  73 0.386      * 0.35819125 0.41719250
## 174   list1 align1_rep2  74 0.373      * 0.34219125 0.40671000
## 175   list1 align1_rep2  75 0.352      * 0.31970125 0.37894000
## 176   list1 align1_rep2  76 0.182      * 0.16363000 0.20041125
## 177   list1 align1_rep2  77 0.200      * 0.17210875 0.22116125
## 178   list1 align1_rep2  78 0.282      * 0.24887500 0.31548250
## 179   list1 align1_rep2  79 0.196      * 0.17307500 0.21258250
## 180   list1 align1_rep2  80 0.184      * 0.15937625 0.20611500
## 181   list1 align1_rep2  81 0.271      * 0.23999875 0.29784375
## 182   list1 align1_rep2  82 0.261      * 0.24065500 0.28123750
## 183   list1 align1_rep2  83 0.308      * 0.27030875 0.34201625
## 184   list1 align1_rep2  84 0.314      * 0.28798875 0.34160500
## 185   list1 align1_rep2  85 0.225      * 0.19680250 0.24825250
## 186   list1 align1_rep2  86 0.190      * 0.16439875 0.21169125
## 187   list1 align1_rep2  87 0.290      * 0.25650875 0.32377875
## 188   list1 align1_rep2  88 0.375      * 0.32769625 0.40397625
## 189   list1 align1_rep2  89 0.263      * 0.23653125 0.28937625
## 190   list1 align1_rep2  90 0.148      * 0.12825125 0.17301875
## 191   list1 align1_rep2  91 0.258      * 0.23159375 0.28591000
## 192   list1 align1_rep2  92 0.267      * 0.24459500 0.30731500
## 193   list1 align1_rep2  93 0.164      * 0.14431500 0.18251250
## 194   list1 align1_rep2  94 0.162      * 0.14811125 0.18258375
## 195   list1 align1_rep2  95 0.133      * 0.11167750 0.15198625
## 196   list1 align1_rep2  96 0.098      * 0.08573250 0.11738625
## 197   list1 align1_rep2  97 0.117      * 0.09379500 0.14467750
## 198   list1 align1_rep2  98 0.179      * 0.14935625 0.20006000
## 199   list1 align1_rep2  99 0.190      * 0.16132875 0.21641875
## 200   list1 align1_rep2 100 0.185      * 0.15762250 0.20264625
## 201   list1 align2_rep1   1 0.087      * 0.07194500 0.10207125
## 202   list1 align2_rep1   2 0.148      * 0.13015375 0.16760500
## 203   list1 align2_rep1   3 0.175      * 0.14601875 0.19834500
## 204   list1 align2_rep1   4 0.125      * 0.09901750 0.13959375
## 205   list1 align2_rep1   5 0.097      * 0.07230375 0.11619750
## 206   list1 align2_rep1   6 0.060      * 0.05023750 0.07180000
## 207   list1 align2_rep1   7 0.130      * 0.11299125 0.16177250
## 208   list1 align2_rep1   8 0.199      * 0.17058125 0.21849250
## 209   list1 align2_rep1   9 0.166      * 0.14368750 0.17954375
## 210   list1 align2_rep1  10 0.104      * 0.08831375 0.12035500
## 211   list1 align2_rep1  11 0.049      * 0.03621000 0.06109125
## 212   list1 align2_rep1  12 0.031      * 0.02517625 0.03588875
## 213   list1 align2_rep1  13 0.117      * 0.09776500 0.13376000
## 214   list1 align2_rep1  14 0.170      * 0.15059625 0.19182250
## 215   list1 align2_rep1  15 0.163      * 0.14372000 0.18471875
## 216   list1 align2_rep1  16 0.127      * 0.10823500 0.14692375
## 217   list1 align2_rep1  17 0.123      * 0.09955250 0.14667500
## 218   list1 align2_rep1  18 0.183      * 0.16028125 0.19978250
## 219   list1 align2_rep1  19 0.201      * 0.17808000 0.22155250
## 220   list1 align2_rep1  20 0.146      * 0.12120875 0.16390750
## 221   list1 align2_rep1  21 0.153      * 0.13782375 0.16882875
## 222   list1 align2_rep1  22 0.169      * 0.14424750 0.19420250
## 223   list1 align2_rep1  23 0.163      * 0.12500000 0.19193875
## 224   list1 align2_rep1  24 0.151      * 0.12008500 0.16830000
## 225   list1 align2_rep1  25 0.222      * 0.19667125 0.24595750
## 226   list1 align2_rep1  26 0.241      * 0.22046000 0.26336500
## 227   list1 align2_rep1  27 0.230      * 0.20246750 0.25530250
## 228   list1 align2_rep1  28 0.249      * 0.22820750 0.28042250
## 229   list1 align2_rep1  29 0.280      * 0.25211125 0.31085250
## 230   list1 align2_rep1  30 0.255      * 0.22936125 0.28720500
## 231   list1 align2_rep1  31 0.173      * 0.14572875 0.19518375
## 232   list1 align2_rep1  32 0.164      * 0.14686125 0.18585500
## 233   list1 align2_rep1  33 0.275      * 0.24358875 0.30261375
## 234   list1 align2_rep1  34 0.247      * 0.22764125 0.27673125
## 235   list1 align2_rep1  35 0.245      * 0.22177500 0.26970000
## 236   list1 align2_rep1  36 0.299      * 0.27290500 0.32096250
## 237   list1 align2_rep1  37 0.337      * 0.30471250 0.36413250
## 238   list1 align2_rep1  38 0.313      * 0.28604250 0.33552000
## 239   list1 align2_rep1  39 0.257      * 0.23675250 0.29299375
## 240   list1 align2_rep1  40 0.252      * 0.22891250 0.27677125
## 241   list1 align2_rep1  41 0.305      * 0.27406500 0.33376750
## 242   list1 align2_rep1  42 0.371      * 0.32708500 0.42391875
## 243   list1 align2_rep1  43 0.332      * 0.30279000 0.36604875
## 244   list1 align2_rep1  44 0.345      * 0.32050375 0.37527125
## 245   list1 align2_rep1  45 0.318      * 0.29384625 0.34457375
## 246   list1 align2_rep1  46 0.282      * 0.25973500 0.30413125
## 247   list1 align2_rep1  47 0.302      * 0.27604000 0.33930125
## 248   list1 align2_rep1  48 0.374      * 0.35081125 0.40849375
## 249   list1 align2_rep1  49 0.306      * 0.28033875 0.33736875
## 250   list1 align2_rep1  50 0.411      * 0.36903875 0.43592250
## 251   list1 align2_rep1  51 0.649      * 0.60163375 0.70153500
## 252   list1 align2_rep1  52 0.614      * 0.54982375 0.65109125
## 253   list1 align2_rep1  53 0.476      * 0.43050750 0.51115000
## 254   list1 align2_rep1  54 0.430      * 0.39254125 0.46077250
## 255   list1 align2_rep1  55 0.436      * 0.40943375 0.47856000
## 256   list1 align2_rep1  56 0.426      * 0.39185000 0.46445875
## 257   list1 align2_rep1  57 0.396      * 0.36976125 0.42146625
## 258   list1 align2_rep1  58 0.395      * 0.36073125 0.42235000
## 259   list1 align2_rep1  59 0.379      * 0.33826875 0.42300750
## 260   list1 align2_rep1  60 0.304      * 0.27471000 0.32923500
## 261   list1 align2_rep1  61 0.283      * 0.25912000 0.30769000
## 262   list1 align2_rep1  62 0.371      * 0.34100125 0.39923875
## 263   list1 align2_rep1  63 0.286      * 0.26099375 0.31325250
## 264   list1 align2_rep1  64 0.211      * 0.18923000 0.22843125
## 265   list1 align2_rep1  65 0.259      * 0.22860375 0.28949125
## 266   list1 align2_rep1  66 0.258      * 0.23524500 0.27818750
## 267   list1 align2_rep1  67 0.252      * 0.22673750 0.27995750
## 268   list1 align2_rep1  68 0.200      * 0.17816375 0.22304125
## 269   list1 align2_rep1  69 0.140      * 0.12143625 0.15565375
## 270   list1 align2_rep1  70 0.092      * 0.07841125 0.10791500
## 271   list1 align2_rep1  71 0.140      * 0.12977875 0.15800875
## 272   list1 align2_rep1  72 0.238      * 0.20101375 0.26950250
## 273   list1 align2_rep1  73 0.255      * 0.21233375 0.29064625
## 274   list1 align2_rep1  74 0.266      * 0.24283875 0.30442000
## 275   list1 align2_rep1  75 0.256      * 0.23352500 0.27760375
## 276   list1 align2_rep1  76 0.222      * 0.19573750 0.24893875
## 277   list1 align2_rep1  77 0.157      * 0.13859625 0.17627750
## 278   list1 align2_rep1  78 0.199      * 0.17626000 0.22196375
## 279   list1 align2_rep1  79 0.294      * 0.26419875 0.31760625
## 280   list1 align2_rep1  80 0.232      * 0.20256500 0.26862500
## 281   list1 align2_rep1  81 0.177      * 0.15501750 0.20257500
## 282   list1 align2_rep1  82 0.158      * 0.13145250 0.17586875
## 283   list1 align2_rep1  83 0.166      * 0.14229875 0.18973125
## 284   list1 align2_rep1  84 0.168      * 0.14902000 0.18532000
## 285   list1 align2_rep1  85 0.247      * 0.21856375 0.28346125
## 286   list1 align2_rep1  86 0.276      * 0.24509125 0.30079625
## 287   list1 align2_rep1  87 0.162      * 0.14858875 0.17557500
## 288   list1 align2_rep1  88 0.064      * 0.05137750 0.07607125
## 289   list1 align2_rep1  89 0.056      * 0.04426250 0.07066500
## 290   list1 align2_rep1  90 0.129      * 0.10336250 0.14909625
## 291   list1 align2_rep1  91 0.191      * 0.16770125 0.21820000
## 292   list1 align2_rep1  92 0.199      * 0.17305000 0.22272000
## 293   list1 align2_rep1  93 0.167      * 0.15003875 0.18117375
## 294   list1 align2_rep1  94 0.150      * 0.13029625 0.17160750
## 295   list1 align2_rep1  95 0.127      * 0.10841250 0.14764625
## 296   list1 align2_rep1  96 0.143      * 0.12819375 0.16632750
## 297   list1 align2_rep1  97 0.130      * 0.11298500 0.14636750
## 298   list1 align2_rep1  98 0.118      * 0.10044875 0.13741625
## 299   list1 align2_rep1  99 0.116      * 0.09736500 0.13683250
## 300   list1 align2_rep1 100 0.191      * 0.16822250 0.21230750
## 301   list1 align2_rep2   1 0.150      * 0.11187375 0.19337375
## 302   list1 align2_rep2   2 0.132      * 0.09611000 0.17004000
## 303   list1 align2_rep2   3 0.139      * 0.11043875 0.17683625
## 304   list1 align2_rep2   4 0.320      * 0.25472500 0.39537000
## 305   list1 align2_rep2   5 0.677      * 0.54079375 0.79712625
## 306   list1 align2_rep2   6 0.463      * 0.37402500 0.59105875
## 307   list1 align2_rep2   7 0.033      * 0.02523375 0.04036500
## 308   list1 align2_rep2   8 0.080      * 0.05412500 0.11097500
## 309   list1 align2_rep2   9 0.048      * 0.03407375 0.06263125
## 310   list1 align2_rep2  10 0.020      * 0.01245000 0.03077500
## 311   list1 align2_rep2  11 0.015      * 0.00987250 0.02093750
## 312   list1 align2_rep2  12 0.021      * 0.01239000 0.02964875
## 313   list1 align2_rep2  13 0.029      * 0.02005250 0.03857750
## 314   list1 align2_rep2  14 0.153      * 0.12937500 0.18661750
## 315   list1 align2_rep2  15 0.220      * 0.17412500 0.26932500
## 316   list1 align2_rep2  16 0.177      * 0.14938500 0.21568875
## 317   list1 align2_rep2  17 0.342      * 0.28128500 0.43368750
## 318   list1 align2_rep2  18 0.435      * 0.33193750 0.57394000
## 319   list1 align2_rep2  19 0.603      * 0.46988500 0.74894375
## 320   list1 align2_rep2  20 0.400      * 0.31470250 0.51627000
## 321   list1 align2_rep2  21 0.277      * 0.22986500 0.34218375
## 322   list1 align2_rep2  22 0.287      * 0.21073750 0.36136250
## 323   list1 align2_rep2  23 0.277      * 0.23557750 0.32898625
## 324   list1 align2_rep2  24 0.480      * 0.41507000 0.55814000
## 325   list1 align2_rep2  25 0.477      * 0.41900000 0.56858750
## 326   list1 align2_rep2  26 0.364      * 0.29080500 0.45174375
## 327   list1 align2_rep2  27 0.373      * 0.28745375 0.48274125
## 328   list1 align2_rep2  28 0.558      * 0.42267250 0.68399250
## 329   list1 align2_rep2  29 0.397      * 0.29791625 0.45703750
## 330   list1 align2_rep2  30 0.266      * 0.21028500 0.33110625
## 331   list1 align2_rep2  31 0.259      * 0.20137750 0.30202375
## 332   list1 align2_rep2  32 0.555      * 0.48437750 0.70246750
## 333   list1 align2_rep2  33 0.247      * 0.19957375 0.30155375
## 334   list1 align2_rep2  34 0.163      * 0.12839375 0.19574500
## 335   list1 align2_rep2  35 0.275      * 0.20666125 0.33634000
## 336   list1 align2_rep2  36 0.155      * 0.13305750 0.17688375
## 337   list1 align2_rep2  37 0.412      * 0.35780125 0.48169875
## 338   list1 align2_rep2  38 0.509      * 0.43470750 0.58222625
## 339   list1 align2_rep2  39 0.128      * 0.10462125 0.15845500
## 340   list1 align2_rep2  40 0.261      * 0.23551000 0.28581125
## 341   list1 align2_rep2  41 0.901      * 0.78551750 1.00629875
## 342   list1 align2_rep2  42 0.811      * 0.70967625 0.92151750
## 343   list1 align2_rep2  43 0.915      * 0.82014625 1.03967500
## 344   list1 align2_rep2  44 1.259      * 1.12527750 1.38459750
## 345   list1 align2_rep2  45 1.376      * 1.20519250 1.51842250
## 346   list1 align2_rep2  46 1.493      * 1.37320875 1.65471625
## 347   list1 align2_rep2  47 1.185      * 1.08223875 1.36380375
## 348   list1 align2_rep2  48 1.324      * 1.19077875 1.49088875
## 349   list1 align2_rep2  49 2.221      * 2.01099250 2.45751750
## 350   list1 align2_rep2  50 2.301      * 2.12082875 2.49417000
## 351   list1 align2_rep2  51 1.610      * 1.43579625 1.72959000
## 352   list1 align2_rep2  52 1.464      * 1.31542875 1.62759125
## 353   list1 align2_rep2  53 1.342      * 1.20336375 1.48653375
## 354   list1 align2_rep2  54 1.217      * 1.11929500 1.33511000
## 355   list1 align2_rep2  55 1.312      * 1.20616375 1.42150375
## 356   list1 align2_rep2  56 1.316      * 1.12635500 1.50595750
## 357   list1 align2_rep2  57 1.322      * 1.14587125 1.48358125
## 358   list1 align2_rep2  58 0.944      * 0.81591750 1.01765875
## 359   list1 align2_rep2  59 0.709      * 0.60281500 0.79372125
## 360   list1 align2_rep2  60 0.642      * 0.52269750 0.74043375
## 361   list1 align2_rep2  61 0.807      * 0.71144500 0.93107625
## 362   list1 align2_rep2  62 0.846      * 0.72067375 0.99374125
## 363   list1 align2_rep2  63 0.693      * 0.61255375 0.79048250
## 364   list1 align2_rep2  64 1.135      * 1.02035500 1.26483875
## 365   list1 align2_rep2  65 0.830      * 0.75702000 0.95411875
## 366   list1 align2_rep2  66 0.297      * 0.25563875 0.34152250
## 367   list1 align2_rep2  67 0.370      * 0.29220000 0.41289750
## 368   list1 align2_rep2  68 0.341      * 0.29647625 0.40569750
## 369   list1 align2_rep2  69 0.306      * 0.25351500 0.37718250
## 370   list1 align2_rep2  70 0.371      * 0.30479000 0.44110500
## 371   list1 align2_rep2  71 0.412      * 0.34024375 0.48094375
## 372   list1 align2_rep2  72 0.378      * 0.33003625 0.46002500
## 373   list1 align2_rep2  73 0.346      * 0.27897750 0.40366750
## 374   list1 align2_rep2  74 0.292      * 0.21037000 0.34068375
## 375   list1 align2_rep2  75 0.140      * 0.10851875 0.16095500
## 376   list1 align2_rep2  76 0.069      * 0.04907625 0.09927375
## 377   list1 align2_rep2  77 0.105      * 0.06825000 0.14422500
## 378   list1 align2_rep2  78 0.137      * 0.09538375 0.17565000
## 379   list1 align2_rep2  79 0.137      * 0.11233000 0.16324875
## 380   list1 align2_rep2  80 0.472      * 0.39745750 0.54468875
## 381   list1 align2_rep2  81 0.456      * 0.37390375 0.54596500
## 382   list1 align2_rep2  82 0.157      * 0.12580625 0.19212750
## 383   list1 align2_rep2  83 0.046      * 0.03196750 0.05754250
## 384   list1 align2_rep2  84 0.151      * 0.11135000 0.19917625
## 385   list1 align2_rep2  85 0.193      * 0.14939000 0.24795125
## 386   list1 align2_rep2  86 0.220      * 0.17550750 0.28367750
## 387   list1 align2_rep2  87 0.499      * 0.41077500 0.62540750
## 388   list1 align2_rep2  88 0.337      * 0.23213250 0.46873375
## 389   list1 align2_rep2  89 0.140      * 0.10267750 0.18303000
## 390   list1 align2_rep2  90 0.203      * 0.17166125 0.24970625
## 391   list1 align2_rep2  91 0.378      * 0.31093500 0.44409000
## 392   list1 align2_rep2  92 0.556      * 0.45876000 0.68990625
## 393   list1 align2_rep2  93 0.284      * 0.23910750 0.34165125
## 394   list1 align2_rep2  94 0.081      * 0.05632500 0.10365375
## 395   list1 align2_rep2  95 0.138      * 0.10290000 0.18923250
## 396   list1 align2_rep2  96 0.361      * 0.28621125 0.44606875
## 397   list1 align2_rep2  97 0.298      * 0.23972000 0.34270750
## 398   list1 align2_rep2  98 0.606      * 0.46098250 0.72121750
## 399   list1 align2_rep2  99 0.536      * 0.41611250 0.60500250
## 400   list1 align2_rep2 100 0.174      * 0.12488750 0.21468500
## 401   list1        ctrl   1 0.584      * 0.53827000 0.62462875
## 402   list1        ctrl   2 0.515      * 0.47024000 0.57858125
## 403   list1        ctrl   3 0.592      * 0.54662000 0.64714500
## 404   list1        ctrl   4 0.654      * 0.59787625 0.71049375
## 405   list1        ctrl   5 0.651      * 0.61063125 0.70318875
## 406   list1        ctrl   6 0.660      * 0.60377500 0.71398750
## 407   list1        ctrl   7 0.614      * 0.57909125 0.64415375
## 408   list1        ctrl   8 0.574      * 0.53432375 0.60915000
## 409   list1        ctrl   9 0.567      * 0.51813875 0.60537375
## 410   list1        ctrl  10 0.568      * 0.53583125 0.61341500
## 411   list1        ctrl  11 0.644      * 0.59614750 0.70036500
## 412   list1        ctrl  12 0.504      * 0.46689875 0.53730125
## 413   list1        ctrl  13 0.487      * 0.43571125 0.52940625
## 414   list1        ctrl  14 0.530      * 0.48786875 0.56877375
## 415   list1        ctrl  15 0.620      * 0.58336500 0.66146500
## 416   list1        ctrl  16 0.708      * 0.64349750 0.76967750
## 417   list1        ctrl  17 0.798      * 0.75273250 0.84532250
## 418   list1        ctrl  18 0.796      * 0.73783125 0.85189625
## 419   list1        ctrl  19 0.855      * 0.78286125 0.92013500
## 420   list1        ctrl  20 0.790      * 0.75257000 0.85299125
## 421   list1        ctrl  21 0.792      * 0.72703500 0.84244000
## 422   list1        ctrl  22 0.854      * 0.75987250 0.96802875
## 423   list1        ctrl  23 0.786      * 0.72166250 0.82988000
## 424   list1        ctrl  24 0.984      * 0.92407000 1.08360750
## 425   list1        ctrl  25 1.143      * 1.04551625 1.21902250
## 426   list1        ctrl  26 0.919      * 0.84699500 1.00314125
## 427   list1        ctrl  27 0.940      * 0.84195125 1.07031375
## 428   list1        ctrl  28 1.023      * 0.93829000 1.11939500
## 429   list1        ctrl  29 1.112      * 1.05384875 1.18710250
## 430   list1        ctrl  30 1.076      * 0.99999000 1.15903875
## 431   list1        ctrl  31 1.020      * 0.96957500 1.08102750
## 432   list1        ctrl  32 1.217      * 1.16020125 1.27554625
## 433   list1        ctrl  33 1.373      * 1.31502625 1.45015500
## 434   list1        ctrl  34 1.663      * 1.57794125 1.71905250
## 435   list1        ctrl  35 1.750      * 1.67117000 1.82926125
## 436   list1        ctrl  36 1.727      * 1.61092500 1.81863000
## 437   list1        ctrl  37 1.786      * 1.71237500 1.87774375
## 438   list1        ctrl  38 2.013      * 1.93871375 2.13700250
## 439   list1        ctrl  39 2.331      * 2.18363250 2.48914500
## 440   list1        ctrl  40 2.336      * 2.22293125 2.47167875
## 441   list1        ctrl  41 2.092      * 1.98055000 2.20046250
## 442   list1        ctrl  42 2.298      * 2.17876500 2.43267625
## 443   list1        ctrl  43 2.821      * 2.64085000 2.98896625
## 444   list1        ctrl  44 3.097      * 2.95484750 3.29920125
## 445   list1        ctrl  45 3.621      * 3.47668000 3.79581375
## 446   list1        ctrl  46 4.533      * 4.36679500 4.75367125
## 447   list1        ctrl  47 4.631      * 4.44362750 4.80413250
## 448   list1        ctrl  48 4.739      * 4.59685000 4.96456375
## 449   list1        ctrl  49 4.906      * 4.74009875 5.14575625
## 450   list1        ctrl  50 5.254      * 5.03693000 5.40211250
## 451   list1        ctrl  51 5.477      * 5.25156000 5.72775000
## 452   list1        ctrl  52 4.813      * 4.58296250 5.02887500
## 453   list1        ctrl  53 4.509      * 4.23466375 4.65887250
## 454   list1        ctrl  54 3.935      * 3.76571000 4.12246375
## 455   list1        ctrl  55 3.140      * 3.00866250 3.29593375
## 456   list1        ctrl  56 2.912      * 2.73962875 3.06229125
## 457   list1        ctrl  57 2.945      * 2.80266250 3.08984250
## 458   list1        ctrl  58 2.748      * 2.65157875 2.87382875
## 459   list1        ctrl  59 2.555      * 2.43334625 2.72409500
## 460   list1        ctrl  60 2.708      * 2.56139125 2.86577750
## 461   list1        ctrl  61 2.500      * 2.33303000 2.67924125
## 462   list1        ctrl  62 2.279      * 2.16887750 2.37876750
## 463   list1        ctrl  63 2.672      * 2.56094250 2.79679250
## 464   list1        ctrl  64 2.878      * 2.68895500 3.06611625
## 465   list1        ctrl  65 2.269      * 2.14697750 2.40590000
## 466   list1        ctrl  66 1.775      * 1.70114250 1.91360375
## 467   list1        ctrl  67 1.684      * 1.58784000 1.86440875
## 468   list1        ctrl  68 1.558      * 1.49106750 1.67652250
## 469   list1        ctrl  69 1.326      * 1.23056375 1.42896375
## 470   list1        ctrl  70 1.319      * 1.20512250 1.41924625
## 471   list1        ctrl  71 1.376      * 1.26494250 1.46687250
## 472   list1        ctrl  72 1.121      * 1.04713375 1.18407625
## 473   list1        ctrl  73 1.067      * 1.00818375 1.11912000
## 474   list1        ctrl  74 1.111      * 1.04219875 1.18993500
## 475   list1        ctrl  75 1.069      * 1.01875875 1.13336500
## 476   list1        ctrl  76 1.086      * 1.00712875 1.17634875
## 477   list1        ctrl  77 0.938      * 0.86172125 0.98139625
## 478   list1        ctrl  78 0.836      * 0.76509875 0.89024500
## 479   list1        ctrl  79 0.831      * 0.75750125 0.87615875
## 480   list1        ctrl  80 0.868      * 0.79186500 0.92621750
## 481   list1        ctrl  81 0.918      * 0.84423375 1.00919875
## 482   list1        ctrl  82 0.690      * 0.62190875 0.73725250
## 483   list1        ctrl  83 0.764      * 0.69873000 0.80752375
## 484   list1        ctrl  84 0.957      * 0.89961625 1.02949000
## 485   list1        ctrl  85 0.839      * 0.78332375 0.90046250
## 486   list1        ctrl  86 0.984      * 0.90958875 1.05799750
## 487   list1        ctrl  87 1.081      * 1.01292625 1.15818750
## 488   list1        ctrl  88 0.868      * 0.80022500 0.90612125
## 489   list1        ctrl  89 0.779      * 0.73254000 0.83012250
## 490   list1        ctrl  90 1.013      * 0.97120625 1.05140000
## 491   list1        ctrl  91 0.984      * 0.93558000 1.03890250
## 492   list1        ctrl  92 0.995      * 0.92534750 1.06967750
## 493   list1        ctrl  93 1.035      * 0.94425875 1.12489625
## 494   list1        ctrl  94 0.810      * 0.75825875 0.85978250
## 495   list1        ctrl  95 0.902      * 0.86890000 0.97357875
## 496   list1        ctrl  96 1.034      * 0.94746375 1.12394000
## 497   list1        ctrl  97 0.903      * 0.82820250 0.97460750
## 498   list1        ctrl  98 0.808      * 0.72373500 0.85548000
## 499   list1        ctrl  99 0.876      * 0.79469500 0.95691125
## 500   list1        ctrl 100 0.655      * 0.59446125 0.73128375
## 501   list2 align1_rep1   1 0.525      * 0.46569750 0.58865125
## 502   list2 align1_rep1   2 0.495      * 0.43025625 0.56778875
## 503   list2 align1_rep1   3 0.469      * 0.42102500 0.51389000
## 504   list2 align1_rep1   4 0.442      * 0.38401875 0.48889375
## 505   list2 align1_rep1   5 0.482      * 0.37084500 0.59090125
## 506   list2 align1_rep1   6 0.627      * 0.56533375 0.80663500
## 507   list2 align1_rep1   7 0.719      * 0.56677625 0.89890750
## 508   list2 align1_rep1   8 0.704      * 0.49245125 0.83514625
## 509   list2 align1_rep1   9 0.777      * 0.62980875 0.93340000
## 510   list2 align1_rep1  10 0.825      * 0.67421625 0.95221000
## 511   list2 align1_rep1  11 0.668      * 0.55756250 0.78986000
## 512   list2 align1_rep1  12 0.564      * 0.46804750 0.65199250
## 513   list2 align1_rep1  13 0.497      * 0.42929875 0.54846125
## 514   list2 align1_rep1  14 0.580      * 0.51020375 0.66534250
## 515   list2 align1_rep1  15 0.652      * 0.53561000 0.80505000
## 516   list2 align1_rep1  16 0.419      * 0.35840000 0.46866375
## 517   list2 align1_rep1  17 0.443      * 0.37514500 0.48793000
## 518   list2 align1_rep1  18 0.517      * 0.44427750 0.60360625
## 519   list2 align1_rep1  19 0.437      * 0.38332500 0.48681500
## 520   list2 align1_rep1  20 0.500      * 0.45274750 0.55185125
## 521   list2 align1_rep1  21 0.702      * 0.64650000 0.75954875
## 522   list2 align1_rep1  22 0.666      * 0.62274000 0.71293250
## 523   list2 align1_rep1  23 0.572      * 0.52416875 0.64232000
## 524   list2 align1_rep1  24 0.594      * 0.54949125 0.64243125
## 525   list2 align1_rep1  25 0.507      * 0.46501000 0.55547875
## 526   list2 align1_rep1  26 0.497      * 0.45522125 0.54499625
## 527   list2 align1_rep1  27 0.602      * 0.55852375 0.65390500
## 528   list2 align1_rep1  28 0.518      * 0.48233500 0.55180625
## 529   list2 align1_rep1  29 0.353      * 0.32434250 0.39029000
## 530   list2 align1_rep1  30 0.329      * 0.29755625 0.35950250
## 531   list2 align1_rep1  31 0.398      * 0.36681500 0.43234875
## 532   list2 align1_rep1  32 0.426      * 0.37936250 0.45732500
## 533   list2 align1_rep1  33 0.404      * 0.37319000 0.43429375
## 534   list2 align1_rep1  34 0.448      * 0.41774500 0.48790125
## 535   list2 align1_rep1  35 0.622      * 0.54072375 0.69390875
## 536   list2 align1_rep1  36 0.621      * 0.55005625 0.71520125
## 537   list2 align1_rep1  37 0.686      * 0.62866750 0.76312000
## 538   list2 align1_rep1  38 0.706      * 0.65362250 0.75431625
## 539   list2 align1_rep1  39 0.596      * 0.52920500 0.66410500
## 540   list2 align1_rep1  40 0.655      * 0.60443875 0.71897250
## 541   list2 align1_rep1  41 0.687      * 0.62421750 0.75382250
## 542   list2 align1_rep1  42 0.784      * 0.71908625 0.85663375
## 543   list2 align1_rep1  43 0.687      * 0.63872250 0.73570875
## 544   list2 align1_rep1  44 0.623      * 0.55619125 0.67585875
## 545   list2 align1_rep1  45 0.844      * 0.77672625 0.90770125
## 546   list2 align1_rep1  46 0.989      * 0.90266500 1.07377125
## 547   list2 align1_rep1  47 1.054      * 0.92166750 1.13348125
## 548   list2 align1_rep1  48 1.022      * 0.94106250 1.10864125
## 549   list2 align1_rep1  49 1.129      * 1.03048500 1.26166250
## 550   list2 align1_rep1  50 1.097      * 0.99224375 1.21687375
## 551   list2 align1_rep1  51 0.865      * 0.81098250 0.91732125
## 552   list2 align1_rep1  52 0.872      * 0.81996500 0.92734125
## 553   list2 align1_rep1  53 0.926      * 0.87398250 0.98963625
## 554   list2 align1_rep1  54 0.811      * 0.75689250 0.85958625
## 555   list2 align1_rep1  55 0.660      * 0.58763625 0.70028000
## 556   list2 align1_rep1  56 0.695      * 0.66088375 0.75374250
## 557   list2 align1_rep1  57 0.696      * 0.64488125 0.73544250
## 558   list2 align1_rep1  58 0.737      * 0.67967875 0.80114250
## 559   list2 align1_rep1  59 0.593      * 0.55085000 0.64038500
## 560   list2 align1_rep1  60 0.756      * 0.68096875 0.83883750
## 561   list2 align1_rep1  61 0.943      * 0.85573250 1.06121000
## 562   list2 align1_rep1  62 0.850      * 0.80197875 0.90806375
## 563   list2 align1_rep1  63 0.826      * 0.75391875 0.90552750
## 564   list2 align1_rep1  64 0.568      * 0.51254250 0.61843125
## 565   list2 align1_rep1  65 0.590      * 0.53458625 0.63877125
## 566   list2 align1_rep1  66 0.691      * 0.61928500 0.74464875
## 567   list2 align1_rep1  67 0.668      * 0.61250250 0.72096625
## 568   list2 align1_rep1  68 0.566      * 0.51080000 0.63768000
## 569   list2 align1_rep1  69 0.512      * 0.47123375 0.56339125
## 570   list2 align1_rep1  70 0.630      * 0.58351000 0.71480250
## 571   list2 align1_rep1  71 0.720      * 0.66324875 0.77265000
## 572   list2 align1_rep1  72 0.652      * 0.60082500 0.69786625
## 573   list2 align1_rep1  73 0.460      * 0.41932250 0.50250000
## 574   list2 align1_rep1  74 0.388      * 0.34899125 0.42875375
## 575   list2 align1_rep1  75 0.589      * 0.54660000 0.64281750
## 576   list2 align1_rep1  76 0.691      * 0.62302875 0.74934750
## 577   list2 align1_rep1  77 0.645      * 0.59012125 0.70485375
## 578   list2 align1_rep1  78 0.520      * 0.48239000 0.56761375
## 579   list2 align1_rep1  79 0.590      * 0.53772375 0.65242750
## 580   list2 align1_rep1  80 0.609      * 0.55259625 0.64901750
## 581   list2 align1_rep1  81 0.530      * 0.48579750 0.57134625
## 582   list2 align1_rep1  82 0.513      * 0.46661250 0.56458750
## 583   list2 align1_rep1  83 0.491      * 0.42631000 0.54168750
## 584   list2 align1_rep1  84 0.433      * 0.39484500 0.48106875
## 585   list2 align1_rep1  85 0.399      * 0.36595250 0.45035000
## 586   list2 align1_rep1  86 0.394      * 0.35515375 0.44349500
## 587   list2 align1_rep1  87 0.454      * 0.41044625 0.49718750
## 588   list2 align1_rep1  88 0.499      * 0.44815875 0.53432750
## 589   list2 align1_rep1  89 0.541      * 0.46940125 0.60441375
## 590   list2 align1_rep1  90 0.465      * 0.42718125 0.50943625
## 591   list2 align1_rep1  91 0.518      * 0.47824250 0.56219625
## 592   list2 align1_rep1  92 0.433      * 0.40235250 0.47958750
## 593   list2 align1_rep1  93 0.477      * 0.44457250 0.52403125
## 594   list2 align1_rep1  94 0.479      * 0.43306125 0.54094250
## 595   list2 align1_rep1  95 0.598      * 0.53221375 0.68830625
## 596   list2 align1_rep1  96 0.736      * 0.64843875 0.81729500
## 597   list2 align1_rep1  97 0.519      * 0.44409250 0.60652000
## 598   list2 align1_rep1  98 0.637      * 0.55308375 0.70783625
## 599   list2 align1_rep1  99 0.771      * 0.68897625 0.86370250
## 600   list2 align1_rep1 100 0.677      * 0.62196875 0.75347750
## 601   list2 align1_rep2   1 0.062      * 0.04627875 0.07905250
## 602   list2 align1_rep2   2 0.112      * 0.09388000 0.13120500
## 603   list2 align1_rep2   3 0.141      * 0.11905000 0.16291125
## 604   list2 align1_rep2   4 0.112      * 0.08577750 0.13581000
## 605   list2 align1_rep2   5 0.155      * 0.12259375 0.18285375
## 606   list2 align1_rep2   6 0.228      * 0.18908500 0.29224500
## 607   list2 align1_rep2   7 0.219      * 0.15833750 0.27196000
## 608   list2 align1_rep2   8 0.207      * 0.15732625 0.27781875
## 609   list2 align1_rep2   9 0.264      * 0.18162375 0.36006125
## 610   list2 align1_rep2  10 0.245      * 0.18603250 0.31741375
## 611   list2 align1_rep2  11 0.309      * 0.25724000 0.35757750
## 612   list2 align1_rep2  12 0.279      * 0.23993125 0.31329625
## 613   list2 align1_rep2  13 0.206      * 0.17639375 0.23207000
## 614   list2 align1_rep2  14 0.243      * 0.19934000 0.28324750
## 615   list2 align1_rep2  15 0.231      * 0.20255250 0.26964625
## 616   list2 align1_rep2  16 0.106      * 0.08648125 0.12740500
## 617   list2 align1_rep2  17 0.087      * 0.07128375 0.10605000
## 618   list2 align1_rep2  18 0.218      * 0.19094500 0.24280500
## 619   list2 align1_rep2  19 0.296      * 0.25028000 0.32861500
## 620   list2 align1_rep2  20 0.250      * 0.22045375 0.27849250
## 621   list2 align1_rep2  21 0.196      * 0.17128875 0.22773000
## 622   list2 align1_rep2  22 0.180      * 0.15113250 0.21384125
## 623   list2 align1_rep2  23 0.182      * 0.16564000 0.20487500
## 624   list2 align1_rep2  24 0.202      * 0.17800625 0.23063875
## 625   list2 align1_rep2  25 0.164      * 0.13835625 0.18662250
## 626   list2 align1_rep2  26 0.178      * 0.15254750 0.20880750
## 627   list2 align1_rep2  27 0.176      * 0.13697750 0.21451875
## 628   list2 align1_rep2  28 0.150      * 0.13275750 0.18294000
## 629   list2 align1_rep2  29 0.146      * 0.12931125 0.16181625
## 630   list2 align1_rep2  30 0.195      * 0.16546625 0.22690500
## 631   list2 align1_rep2  31 0.171      * 0.14485500 0.19084375
## 632   list2 align1_rep2  32 0.155      * 0.13141625 0.17525750
## 633   list2 align1_rep2  33 0.212      * 0.18622750 0.24385125
## 634   list2 align1_rep2  34 0.218      * 0.19189875 0.24233750
## 635   list2 align1_rep2  35 0.198      * 0.17610625 0.22219875
## 636   list2 align1_rep2  36 0.211      * 0.18633875 0.22667000
## 637   list2 align1_rep2  37 0.282      * 0.24575375 0.32995875
## 638   list2 align1_rep2  38 0.289      * 0.25652250 0.31404250
## 639   list2 align1_rep2  39 0.306      * 0.24870125 0.33821750
## 640   list2 align1_rep2  40 0.261      * 0.21805375 0.29607000
## 641   list2 align1_rep2  41 0.223      * 0.18275750 0.26667500
## 642   list2 align1_rep2  42 0.426      * 0.37005250 0.45719375
## 643   list2 align1_rep2  43 0.374      * 0.34848000 0.41404000
## 644   list2 align1_rep2  44 0.340      * 0.30005750 0.37950250
## 645   list2 align1_rep2  45 0.486      * 0.44197625 0.52620250
## 646   list2 align1_rep2  46 0.428      * 0.37495125 0.46895000
## 647   list2 align1_rep2  47 0.386      * 0.34937375 0.44791625
## 648   list2 align1_rep2  48 0.398      * 0.36101250 0.44427000
## 649   list2 align1_rep2  49 0.386      * 0.34748625 0.42873500
## 650   list2 align1_rep2  50 0.447      * 0.38890625 0.49261125
## 651   list2 align1_rep2  51 0.417      * 0.37845375 0.45993375
## 652   list2 align1_rep2  52 0.378      * 0.34125000 0.41443375
## 653   list2 align1_rep2  53 0.299      * 0.27345125 0.33039250
## 654   list2 align1_rep2  54 0.310      * 0.27969125 0.34168250
## 655   list2 align1_rep2  55 0.356      * 0.32625625 0.38558000
## 656   list2 align1_rep2  56 0.444      * 0.39399250 0.48536250
## 657   list2 align1_rep2  57 0.367      * 0.34117750 0.40312375
## 658   list2 align1_rep2  58 0.285      * 0.26219625 0.31297375
## 659   list2 align1_rep2  59 0.271      * 0.23362250 0.29892625
## 660   list2 align1_rep2  60 0.234      * 0.19813500 0.27083625
## 661   list2 align1_rep2  61 0.317      * 0.27679250 0.36597250
## 662   list2 align1_rep2  62 0.388      * 0.35439375 0.44394250
## 663   list2 align1_rep2  63 0.314      * 0.27638625 0.33735375
## 664   list2 align1_rep2  64 0.289      * 0.24191875 0.33612875
## 665   list2 align1_rep2  65 0.316      * 0.28986750 0.34961125
## 666   list2 align1_rep2  66 0.388      * 0.34028000 0.44598000
## 667   list2 align1_rep2  67 0.361      * 0.32897375 0.38770875
## 668   list2 align1_rep2  68 0.252      * 0.23055250 0.28310500
## 669   list2 align1_rep2  69 0.217      * 0.19233375 0.24556875
## 670   list2 align1_rep2  70 0.246      * 0.22204625 0.27385375
## 671   list2 align1_rep2  71 0.227      * 0.20273875 0.25008625
## 672   list2 align1_rep2  72 0.179      * 0.15514000 0.20759500
## 673   list2 align1_rep2  73 0.162      * 0.14271250 0.17763125
## 674   list2 align1_rep2  74 0.189      * 0.15817500 0.21308250
## 675   list2 align1_rep2  75 0.216      * 0.18523750 0.23890875
## 676   list2 align1_rep2  76 0.279      * 0.23097500 0.31983625
## 677   list2 align1_rep2  77 0.346      * 0.29733750 0.38784750
## 678   list2 align1_rep2  78 0.188      * 0.15857000 0.21854625
## 679   list2 align1_rep2  79 0.148      * 0.13060125 0.17847625
## 680   list2 align1_rep2  80 0.350      * 0.31217625 0.38748000
## 681   list2 align1_rep2  81 0.290      * 0.25650125 0.31043125
## 682   list2 align1_rep2  82 0.131      * 0.11803375 0.14879500
## 683   list2 align1_rep2  83 0.080      * 0.06398625 0.09738000
## 684   list2 align1_rep2  84 0.094      * 0.07449750 0.11560500
## 685   list2 align1_rep2  85 0.133      * 0.10228750 0.16291500
## 686   list2 align1_rep2  86 0.128      * 0.11271875 0.16015375
## 687   list2 align1_rep2  87 0.166      * 0.13752250 0.19885625
## 688   list2 align1_rep2  88 0.199      * 0.16581875 0.22481500
## 689   list2 align1_rep2  89 0.148      * 0.12242250 0.18125875
## 690   list2 align1_rep2  90 0.108      * 0.08602625 0.12402000
## 691   list2 align1_rep2  91 0.168      * 0.14260500 0.18222750
## 692   list2 align1_rep2  92 0.220      * 0.19009500 0.25229875
## 693   list2 align1_rep2  93 0.260      * 0.23492875 0.28654750
## 694   list2 align1_rep2  94 0.311      * 0.27797250 0.34580000
## 695   list2 align1_rep2  95 0.221      * 0.18952500 0.26664875
## 696   list2 align1_rep2  96 0.179      * 0.14652375 0.21196500
## 697   list2 align1_rep2  97 0.296      * 0.26021625 0.33023375
## 698   list2 align1_rep2  98 0.323      * 0.26062250 0.37902750
## 699   list2 align1_rep2  99 0.251      * 0.19602625 0.30264875
## 700   list2 align1_rep2 100 0.332      * 0.30385250 0.38564125
## 701   list2 align2_rep1   1 0.055      * 0.04119125 0.06701625
## 702   list2 align2_rep1   2 0.052      * 0.03956125 0.06517750
## 703   list2 align2_rep1   3 0.068      * 0.05185000 0.08843000
## 704   list2 align2_rep1   4 0.063      * 0.05209500 0.07469875
## 705   list2 align2_rep1   5 0.082      * 0.06808000 0.09579250
## 706   list2 align2_rep1   6 0.111      * 0.09661250 0.13021125
## 707   list2 align2_rep1   7 0.152      * 0.13461875 0.16593125
## 708   list2 align2_rep1   8 0.153      * 0.12890625 0.17405375
## 709   list2 align2_rep1   9 0.156      * 0.12036625 0.17558000
## 710   list2 align2_rep1  10 0.105      * 0.09316750 0.11856750
## 711   list2 align2_rep1  11 0.063      * 0.04999750 0.07482500
## 712   list2 align2_rep1  12 0.123      * 0.10510625 0.13759750
## 713   list2 align2_rep1  13 0.144      * 0.11517250 0.16184125
## 714   list2 align2_rep1  14 0.140      * 0.12576250 0.16046500
## 715   list2 align2_rep1  15 0.167      * 0.14951750 0.19214500
## 716   list2 align2_rep1  16 0.159      * 0.14546250 0.17851500
## 717   list2 align2_rep1  17 0.150      * 0.12619125 0.17510000
## 718   list2 align2_rep1  18 0.137      * 0.11110125 0.16284375
## 719   list2 align2_rep1  19 0.080      * 0.06598500 0.09184000
## 720   list2 align2_rep1  20 0.072      * 0.06288000 0.08666625
## 721   list2 align2_rep1  21 0.131      * 0.10474250 0.16858125
## 722   list2 align2_rep1  22 0.160      * 0.12624500 0.18412875
## 723   list2 align2_rep1  23 0.084      * 0.07025875 0.10065000
## 724   list2 align2_rep1  24 0.063      * 0.05266875 0.07823750
## 725   list2 align2_rep1  25 0.093      * 0.08136375 0.11257625
## 726   list2 align2_rep1  26 0.071      * 0.05881250 0.08457500
## 727   list2 align2_rep1  27 0.075      * 0.06307875 0.08307625
## 728   list2 align2_rep1  28 0.121      * 0.10155000 0.14004000
## 729   list2 align2_rep1  29 0.106      * 0.09155000 0.11557125
## 730   list2 align2_rep1  30 0.112      * 0.09626125 0.12463875
## 731   list2 align2_rep1  31 0.127      * 0.09555875 0.14281625
## 732   list2 align2_rep1  32 0.054      * 0.04466750 0.06251625
## 733   list2 align2_rep1  33 0.020      * 0.01405375 0.02688250
## 734   list2 align2_rep1  34 0.057      * 0.04083375 0.06692500
## 735   list2 align2_rep1  35 0.114      * 0.09782875 0.13462750
## 736   list2 align2_rep1  36 0.168      * 0.14619000 0.19120375
## 737   list2 align2_rep1  37 0.175      * 0.15620750 0.19767125
## 738   list2 align2_rep1  38 0.105      * 0.09167875 0.11499750
## 739   list2 align2_rep1  39 0.123      * 0.10137750 0.13826875
## 740   list2 align2_rep1  40 0.130      * 0.11399375 0.14279750
## 741   list2 align2_rep1  41 0.099      * 0.08605625 0.11496000
## 742   list2 align2_rep1  42 0.125      * 0.10572625 0.14911125
## 743   list2 align2_rep1  43 0.106      * 0.08238375 0.12329125
## 744   list2 align2_rep1  44 0.173      * 0.15253125 0.19666500
## 745   list2 align2_rep1  45 0.226      * 0.19935375 0.25191750
## 746   list2 align2_rep1  46 0.169      * 0.15047750 0.19226250
## 747   list2 align2_rep1  47 0.251      * 0.22524875 0.27559375
## 748   list2 align2_rep1  48 0.241      * 0.21253375 0.26866625
## 749   list2 align2_rep1  49 0.240      * 0.22070125 0.26633125
## 750   list2 align2_rep1  50 0.183      * 0.16520875 0.20576750
## 751   list2 align2_rep1  51 0.181      * 0.15782750 0.20292500
## 752   list2 align2_rep1  52 0.240      * 0.20784875 0.26624375
## 753   list2 align2_rep1  53 0.149      * 0.12541125 0.16915000
## 754   list2 align2_rep1  54 0.148      * 0.12917750 0.16607500
## 755   list2 align2_rep1  55 0.223      * 0.19591875 0.24686500
## 756   list2 align2_rep1  56 0.170      * 0.15265000 0.19365250
## 757   list2 align2_rep1  57 0.127      * 0.10864000 0.14385875
## 758   list2 align2_rep1  58 0.107      * 0.08912500 0.12645625
## 759   list2 align2_rep1  59 0.113      * 0.09165500 0.13038875
## 760   list2 align2_rep1  60 0.133      * 0.10137750 0.16191625
## 761   list2 align2_rep1  61 0.102      * 0.08918375 0.11813500
## 762   list2 align2_rep1  62 0.186      * 0.16884125 0.21038875
## 763   list2 align2_rep1  63 0.205      * 0.18494500 0.22411500
## 764   list2 align2_rep1  64 0.162      * 0.13131125 0.19076125
## 765   list2 align2_rep1  65 0.134      * 0.10993750 0.15400750
## 766   list2 align2_rep1  66 0.102      * 0.08502375 0.11894875
## 767   list2 align2_rep1  67 0.032      * 0.02278750 0.04140375
## 768   list2 align2_rep1  68 0.081      * 0.07174125 0.09476500
## 769   list2 align2_rep1  69 0.158      * 0.13544125 0.18109875
## 770   list2 align2_rep1  70 0.151      * 0.13010875 0.16677250
## 771   list2 align2_rep1  71 0.097      * 0.07863875 0.11339875
## 772   list2 align2_rep1  72 0.080      * 0.06849000 0.09277250
## 773   list2 align2_rep1  73 0.132      * 0.10676750 0.15625375
## 774   list2 align2_rep1  74 0.121      * 0.10341875 0.14731000
## 775   list2 align2_rep1  75 0.121      * 0.09943375 0.13679000
## 776   list2 align2_rep1  76 0.181      * 0.15488375 0.20093125
## 777   list2 align2_rep1  77 0.144      * 0.12836250 0.15780625
## 778   list2 align2_rep1  78 0.105      * 0.09189000 0.11829375
## 779   list2 align2_rep1  79 0.104      * 0.08684000 0.12205375
## 780   list2 align2_rep1  80 0.190      * 0.16193875 0.21121500
## 781   list2 align2_rep1  81 0.237      * 0.21282500 0.26803875
## 782   list2 align2_rep1  82 0.188      * 0.16252250 0.20933000
## 783   list2 align2_rep1  83 0.129      * 0.11574500 0.14461000
## 784   list2 align2_rep1  84 0.099      * 0.08502500 0.11483875
## 785   list2 align2_rep1  85 0.136      * 0.11040875 0.15951875
## 786   list2 align2_rep1  86 0.130      * 0.11198000 0.15238875
## 787   list2 align2_rep1  87 0.093      * 0.07802625 0.10578750
## 788   list2 align2_rep1  88 0.098      * 0.07340000 0.12048500
## 789   list2 align2_rep1  89 0.073      * 0.05231750 0.09326000
## 790   list2 align2_rep1  90 0.046      * 0.03495750 0.05677750
## 791   list2 align2_rep1  91 0.049      * 0.03817750 0.06022625
## 792   list2 align2_rep1  92 0.046      * 0.03741125 0.05315000
## 793   list2 align2_rep1  93 0.052      * 0.04029750 0.06246000
## 794   list2 align2_rep1  94 0.081      * 0.06396625 0.09681000
## 795   list2 align2_rep1  95 0.070      * 0.06061125 0.08509500
## 796   list2 align2_rep1  96 0.074      * 0.06643250 0.09207375
## 797   list2 align2_rep1  97 0.097      * 0.08115875 0.11356250
## 798   list2 align2_rep1  98 0.078      * 0.06593375 0.09343250
## 799   list2 align2_rep1  99 0.063      * 0.04968375 0.07783125
## 800   list2 align2_rep1 100 0.049      * 0.03951125 0.06049375
## 801   list2 align2_rep2   1 0.170      * 0.13428500 0.20343000
## 802   list2 align2_rep2   2 0.202      * 0.17156250 0.25765000
## 803   list2 align2_rep2   3 0.173      * 0.13793125 0.21573375
## 804   list2 align2_rep2   4 0.187      * 0.16055375 0.22446750
## 805   list2 align2_rep2   5 0.366      * 0.28117625 0.42534250
## 806   list2 align2_rep2   6 0.241      * 0.18627875 0.31310250
## 807   list2 align2_rep2   7 0.146      * 0.08744000 0.17944375
## 808   list2 align2_rep2   8 0.207      * 0.14798750 0.26427000
## 809   list2 align2_rep2   9 0.172      * 0.13559500 0.20538625
## 810   list2 align2_rep2  10 0.279      * 0.18866625 0.39550875
## 811   list2 align2_rep2  11 0.266      * 0.19330250 0.35036500
## 812   list2 align2_rep2  12 0.169      * 0.13866875 0.21700500
## 813   list2 align2_rep2  13 0.180      * 0.14067500 0.24455000
## 814   list2 align2_rep2  14 0.031      * 0.02371125 0.04069000
## 815   list2 align2_rep2  15 0.040      * 0.02245000 0.05755000
## 816   list2 align2_rep2  16 0.014      * 0.00925750 0.02014250
## 817   list2 align2_rep2  17 0.000      * 0.00000000 0.00000000
## 818   list2 align2_rep2  18 0.000      * 0.00000000 0.00000000
## 819   list2 align2_rep2  19 0.000      * 0.00000000 0.00000000
## 820   list2 align2_rep2  20 0.000      * 0.00000000 0.00000000
## 821   list2 align2_rep2  21 0.051      * 0.03372375 0.06572625
## 822   list2 align2_rep2  22 0.142      * 0.11278000 0.20010000
## 823   list2 align2_rep2  23 0.095      * 0.05331875 0.13822500
## 824   list2 align2_rep2  24 0.015      * 0.00975000 0.02233125
## 825   list2 align2_rep2  25 0.060      * 0.03600000 0.07800000
## 826   list2 align2_rep2  26 0.139      * 0.09591375 0.19860625
## 827   list2 align2_rep2  27 0.172      * 0.12919000 0.21806000
## 828   list2 align2_rep2  28 0.025      * 0.01528125 0.03250000
## 829   list2 align2_rep2  29 0.000      * 0.00000000 0.00000000
## 830   list2 align2_rep2  30 0.038      * 0.02660000 0.05087250
## 831   list2 align2_rep2  31 0.082      * 0.05889250 0.10978250
## 832   list2 align2_rep2  32 0.250      * 0.17445000 0.32010000
## 833   list2 align2_rep2  33 0.283      * 0.22669125 0.34968375
## 834   list2 align2_rep2  34 0.235      * 0.18432875 0.29931375
## 835   list2 align2_rep2  35 0.216      * 0.15006000 0.27753000
## 836   list2 align2_rep2  36 0.050      * 0.03256750 0.06693250
## 837   list2 align2_rep2  37 0.099      * 0.07149875 0.13033750
## 838   list2 align2_rep2  38 0.294      * 0.21621250 0.38153000
## 839   list2 align2_rep2  39 0.161      * 0.11987875 0.19606750
## 840   list2 align2_rep2  40 0.227      * 0.17139250 0.29575250
## 841   list2 align2_rep2  41 0.128      * 0.09989500 0.16279500
## 842   list2 align2_rep2  42 0.073      * 0.05564125 0.10452250
## 843   list2 align2_rep2  43 0.179      * 0.13805000 0.24033750
## 844   list2 align2_rep2  44 0.115      * 0.08580375 0.15941500
## 845   list2 align2_rep2  45 0.313      * 0.23278625 0.38337125
## 846   list2 align2_rep2  46 0.186      * 0.13390125 0.24300500
## 847   list2 align2_rep2  47 0.110      * 0.08961500 0.13735000
## 848   list2 align2_rep2  48 0.391      * 0.30469375 0.45912000
## 849   list2 align2_rep2  49 0.303      * 0.25118500 0.37982000
## 850   list2 align2_rep2  50 0.190      * 0.14115000 0.22700625
## 851   list2 align2_rep2  51 0.344      * 0.29446000 0.40240000
## 852   list2 align2_rep2  52 0.372      * 0.27513125 0.45410250
## 853   list2 align2_rep2  53 0.188      * 0.12719000 0.23907125
## 854   list2 align2_rep2  54 0.229      * 0.19291500 0.28069875
## 855   list2 align2_rep2  55 0.290      * 0.23214750 0.36636500
## 856   list2 align2_rep2  56 0.189      * 0.13929625 0.21213750
## 857   list2 align2_rep2  57 0.196      * 0.14140000 0.26455000
## 858   list2 align2_rep2  58 0.323      * 0.21880750 0.47544250
## 859   list2 align2_rep2  59 0.205      * 0.13171250 0.34058125
## 860   list2 align2_rep2  60 0.137      * 0.10601125 0.16778000
## 861   list2 align2_rep2  61 0.275      * 0.21462625 0.34605125
## 862   list2 align2_rep2  62 0.384      * 0.31891500 0.47700000
## 863   list2 align2_rep2  63 0.273      * 0.20971750 0.31849625
## 864   list2 align2_rep2  64 0.159      * 0.11772000 0.20494500
## 865   list2 align2_rep2  65 0.312      * 0.23365625 0.37518500
## 866   list2 align2_rep2  66 0.418      * 0.33206500 0.47802250
## 867   list2 align2_rep2  67 0.248      * 0.18621250 0.31351000
## 868   list2 align2_rep2  68 0.083      * 0.06576125 0.10369875
## 869   list2 align2_rep2  69 0.156      * 0.10672250 0.19921000
## 870   list2 align2_rep2  70 0.151      * 0.12660875 0.17276625
## 871   list2 align2_rep2  71 0.169      * 0.12831875 0.21289375
## 872   list2 align2_rep2  72 0.152      * 0.10653500 0.22261000
## 873   list2 align2_rep2  73 0.025      * 0.01801125 0.03565000
## 874   list2 align2_rep2  74 0.032      * 0.02318000 0.03815500
## 875   list2 align2_rep2  75 0.128      * 0.09517500 0.16097500
## 876   list2 align2_rep2  76 0.296      * 0.22130375 0.37980375
## 877   list2 align2_rep2  77 0.259      * 0.19384750 0.32759125
## 878   list2 align2_rep2  78 0.175      * 0.13468000 0.21196500
## 879   list2 align2_rep2  79 0.394      * 0.30110000 0.49124500
## 880   list2 align2_rep2  80 0.385      * 0.30948125 0.45845000
## 881   list2 align2_rep2  81 0.295      * 0.22678375 0.34801000
## 882   list2 align2_rep2  82 0.478      * 0.40655500 0.59306500
## 883   list2 align2_rep2  83 0.252      * 0.20126750 0.29757000
## 884   list2 align2_rep2  84 0.018      * 0.01190250 0.02499750
## 885   list2 align2_rep2  85 0.130      * 0.09300000 0.17087500
## 886   list2 align2_rep2  86 0.243      * 0.19291625 0.28788250
## 887   list2 align2_rep2  87 0.214      * 0.15904500 0.27486250
## 888   list2 align2_rep2  88 0.030      * 0.02172250 0.03896500
## 889   list2 align2_rep2  89 0.147      * 0.09577000 0.19858750
## 890   list2 align2_rep2  90 0.281      * 0.22971750 0.34124125
## 891   list2 align2_rep2  91 0.251      * 0.17810750 0.31546500
## 892   list2 align2_rep2  92 0.145      * 0.10255375 0.18551375
## 893   list2 align2_rep2  93 0.080      * 0.04890000 0.11510000
## 894   list2 align2_rep2  94 0.024      * 0.01800000 0.03280000
## 895   list2 align2_rep2  95 0.088      * 0.06525000 0.10688000
## 896   list2 align2_rep2  96 0.361      * 0.30035125 0.45672000
## 897   list2 align2_rep2  97 0.586      * 0.46262375 0.71627750
## 898   list2 align2_rep2  98 0.313      * 0.21895125 0.41832250
## 899   list2 align2_rep2  99 0.466      * 0.33156125 0.62485750
## 900   list2 align2_rep2 100 0.415      * 0.29250875 0.55462500
## 901   list2        ctrl   1 0.365      * 0.32877000 0.40664750
## 902   list2        ctrl   2 0.296      * 0.26670750 0.31958875
## 903   list2        ctrl   3 0.311      * 0.27322375 0.35717375
## 904   list2        ctrl   4 0.416      * 0.36696125 0.45904125
## 905   list2        ctrl   5 0.536      * 0.48412750 0.58951875
## 906   list2        ctrl   6 0.357      * 0.32039875 0.41281000
## 907   list2        ctrl   7 0.278      * 0.23985750 0.31343750
## 908   list2        ctrl   8 0.340      * 0.28286875 0.37666125
## 909   list2        ctrl   9 0.403      * 0.35325125 0.45557500
## 910   list2        ctrl  10 0.584      * 0.51644125 0.64511625
## 911   list2        ctrl  11 0.500      * 0.46575625 0.56132000
## 912   list2        ctrl  12 0.448      * 0.39265750 0.50148750
## 913   list2        ctrl  13 0.461      * 0.43454500 0.49900375
## 914   list2        ctrl  14 0.493      * 0.45040000 0.53286250
## 915   list2        ctrl  15 0.430      * 0.39360500 0.48472625
## 916   list2        ctrl  16 0.388      * 0.35363125 0.41536875
## 917   list2        ctrl  17 0.466      * 0.41525625 0.52192250
## 918   list2        ctrl  18 0.387      * 0.33066375 0.45375250
## 919   list2        ctrl  19 0.341      * 0.27172750 0.38782000
## 920   list2        ctrl  20 0.379      * 0.33656000 0.43037625
## 921   list2        ctrl  21 0.340      * 0.30185750 0.37161750
## 922   list2        ctrl  22 0.265      * 0.24005875 0.29615125
## 923   list2        ctrl  23 0.323      * 0.29365250 0.36429750
## 924   list2        ctrl  24 0.492      * 0.43185000 0.55017250
## 925   list2        ctrl  25 0.459      * 0.41442000 0.49879375
## 926   list2        ctrl  26 0.288      * 0.25058625 0.32222625
## 927   list2        ctrl  27 0.358      * 0.31389875 0.40301500
## 928   list2        ctrl  28 0.389      * 0.34819125 0.45403250
## 929   list2        ctrl  29 0.373      * 0.33926125 0.40936625
## 930   list2        ctrl  30 0.374      * 0.34980125 0.40729875
## 931   list2        ctrl  31 0.444      * 0.39008000 0.49931500
## 932   list2        ctrl  32 0.381      * 0.33161125 0.41133750
## 933   list2        ctrl  33 0.481      * 0.42790125 0.53330125
## 934   list2        ctrl  34 0.519      * 0.45716625 0.59033000
## 935   list2        ctrl  35 0.576      * 0.52178250 0.64010000
## 936   list2        ctrl  36 0.589      * 0.50836875 0.64279625
## 937   list2        ctrl  37 0.744      * 0.64134000 0.83813375
## 938   list2        ctrl  38 0.742      * 0.67727250 0.81838375
## 939   list2        ctrl  39 0.729      * 0.67517875 0.80095875
## 940   list2        ctrl  40 0.870      * 0.78606000 0.94400500
## 941   list2        ctrl  41 0.719      * 0.64614125 0.79573875
## 942   list2        ctrl  42 0.616      * 0.54627750 0.67727500
## 943   list2        ctrl  43 0.791      * 0.72593125 0.85909000
## 944   list2        ctrl  44 0.907      * 0.82451500 0.99919500
## 945   list2        ctrl  45 0.984      * 0.88961750 1.08868375
## 946   list2        ctrl  46 1.127      * 1.04624125 1.22202375
## 947   list2        ctrl  47 1.295      * 1.17115625 1.40782375
## 948   list2        ctrl  48 1.275      * 1.18336125 1.37148750
## 949   list2        ctrl  49 1.160      * 1.04800750 1.28268625
## 950   list2        ctrl  50 1.024      * 0.95550250 1.10122125
## 951   list2        ctrl  51 0.964      * 0.86938250 1.03118250
## 952   list2        ctrl  52 0.858      * 0.75663500 0.92629750
## 953   list2        ctrl  53 0.808      * 0.74681125 0.87230500
## 954   list2        ctrl  54 0.888      * 0.80620625 0.95009875
## 955   list2        ctrl  55 0.897      * 0.83192125 0.98134625
## 956   list2        ctrl  56 0.697      * 0.61696875 0.74636375
## 957   list2        ctrl  57 0.753      * 0.67188625 0.83243500
## 958   list2        ctrl  58 0.737      * 0.65075000 0.81115500
## 959   list2        ctrl  59 0.552      * 0.51504500 0.64529875
## 960   list2        ctrl  60 0.520      * 0.47383250 0.56330125
## 961   list2        ctrl  61 0.798      * 0.73171250 0.85357875
## 962   list2        ctrl  62 1.014      * 0.94460250 1.11257250
## 963   list2        ctrl  63 0.752      * 0.69132375 0.82659250
## 964   list2        ctrl  64 0.589      * 0.53832250 0.63284500
## 965   list2        ctrl  65 0.544      * 0.49738375 0.58803125
## 966   list2        ctrl  66 0.483      * 0.44239125 0.51901625
## 967   list2        ctrl  67 0.566      * 0.52793250 0.60805000
## 968   list2        ctrl  68 0.663      * 0.59695875 0.70811500
## 969   list2        ctrl  69 0.521      * 0.47369125 0.55257750
## 970   list2        ctrl  70 0.484      * 0.42490625 0.54388125
## 971   list2        ctrl  71 0.412      * 0.35544375 0.47341750
## 972   list2        ctrl  72 0.385      * 0.35475250 0.42942875
## 973   list2        ctrl  73 0.407      * 0.37405500 0.45423125
## 974   list2        ctrl  74 0.540      * 0.49367750 0.58474625
## 975   list2        ctrl  75 0.574      * 0.51889250 0.62353875
## 976   list2        ctrl  76 0.625      * 0.54818250 0.69143750
## 977   list2        ctrl  77 0.655      * 0.57271500 0.73295750
## 978   list2        ctrl  78 0.558      * 0.50590125 0.60503375
## 979   list2        ctrl  79 0.557      * 0.49606750 0.60475000
## 980   list2        ctrl  80 0.529      * 0.47204625 0.58176375
## 981   list2        ctrl  81 0.586      * 0.53514125 0.64587375
## 982   list2        ctrl  82 0.664      * 0.61102000 0.73759250
## 983   list2        ctrl  83 0.529      * 0.47953000 0.57465000
## 984   list2        ctrl  84 0.324      * 0.29378125 0.35741625
## 985   list2        ctrl  85 0.433      * 0.39869750 0.47231250
## 986   list2        ctrl  86 0.504      * 0.46664625 0.56182000
## 987   list2        ctrl  87 0.347      * 0.31063625 0.37179125
## 988   list2        ctrl  88 0.383      * 0.35598375 0.40851875
## 989   list2        ctrl  89 0.415      * 0.38007875 0.45311750
## 990   list2        ctrl  90 0.349      * 0.31384250 0.38748250
## 991   list2        ctrl  91 0.478      * 0.44268500 0.52484875
## 992   list2        ctrl  92 0.593      * 0.54712125 0.65119250
## 993   list2        ctrl  93 0.384      * 0.33584750 0.43622500
## 994   list2        ctrl  94 0.390      * 0.34843125 0.41600875
## 995   list2        ctrl  95 0.544      * 0.47424125 0.60991375
## 996   list2        ctrl  96 0.513      * 0.43765625 0.62507250
## 997   list2        ctrl  97 0.615      * 0.51798500 0.74257625
## 998   list2        ctrl  98 0.705      * 0.57226625 0.86502625
## 999   list2        ctrl  99 0.708      * 0.61080750 0.88833250
## 1000  list2        ctrl 100 0.652      * 0.56955625 0.74425875
##                  group
## 1    align1_rep1_list1
## 2    align1_rep1_list1
## 3    align1_rep1_list1
## 4    align1_rep1_list1
## 5    align1_rep1_list1
## 6    align1_rep1_list1
## 7    align1_rep1_list1
## 8    align1_rep1_list1
## 9    align1_rep1_list1
## 10   align1_rep1_list1
## 11   align1_rep1_list1
## 12   align1_rep1_list1
## 13   align1_rep1_list1
## 14   align1_rep1_list1
## 15   align1_rep1_list1
## 16   align1_rep1_list1
## 17   align1_rep1_list1
## 18   align1_rep1_list1
## 19   align1_rep1_list1
## 20   align1_rep1_list1
## 21   align1_rep1_list1
## 22   align1_rep1_list1
## 23   align1_rep1_list1
## 24   align1_rep1_list1
## 25   align1_rep1_list1
## 26   align1_rep1_list1
## 27   align1_rep1_list1
## 28   align1_rep1_list1
## 29   align1_rep1_list1
## 30   align1_rep1_list1
## 31   align1_rep1_list1
## 32   align1_rep1_list1
## 33   align1_rep1_list1
## 34   align1_rep1_list1
## 35   align1_rep1_list1
## 36   align1_rep1_list1
## 37   align1_rep1_list1
## 38   align1_rep1_list1
## 39   align1_rep1_list1
## 40   align1_rep1_list1
## 41   align1_rep1_list1
## 42   align1_rep1_list1
## 43   align1_rep1_list1
## 44   align1_rep1_list1
## 45   align1_rep1_list1
## 46   align1_rep1_list1
## 47   align1_rep1_list1
## 48   align1_rep1_list1
## 49   align1_rep1_list1
## 50   align1_rep1_list1
## 51   align1_rep1_list1
## 52   align1_rep1_list1
## 53   align1_rep1_list1
## 54   align1_rep1_list1
## 55   align1_rep1_list1
## 56   align1_rep1_list1
## 57   align1_rep1_list1
## 58   align1_rep1_list1
## 59   align1_rep1_list1
## 60   align1_rep1_list1
## 61   align1_rep1_list1
## 62   align1_rep1_list1
## 63   align1_rep1_list1
## 64   align1_rep1_list1
## 65   align1_rep1_list1
## 66   align1_rep1_list1
## 67   align1_rep1_list1
## 68   align1_rep1_list1
## 69   align1_rep1_list1
## 70   align1_rep1_list1
## 71   align1_rep1_list1
## 72   align1_rep1_list1
## 73   align1_rep1_list1
## 74   align1_rep1_list1
## 75   align1_rep1_list1
## 76   align1_rep1_list1
## 77   align1_rep1_list1
## 78   align1_rep1_list1
## 79   align1_rep1_list1
## 80   align1_rep1_list1
## 81   align1_rep1_list1
## 82   align1_rep1_list1
## 83   align1_rep1_list1
## 84   align1_rep1_list1
## 85   align1_rep1_list1
## 86   align1_rep1_list1
## 87   align1_rep1_list1
## 88   align1_rep1_list1
## 89   align1_rep1_list1
## 90   align1_rep1_list1
## 91   align1_rep1_list1
## 92   align1_rep1_list1
## 93   align1_rep1_list1
## 94   align1_rep1_list1
## 95   align1_rep1_list1
## 96   align1_rep1_list1
## 97   align1_rep1_list1
## 98   align1_rep1_list1
## 99   align1_rep1_list1
## 100  align1_rep1_list1
## 101  align1_rep2_list1
## 102  align1_rep2_list1
## 103  align1_rep2_list1
## 104  align1_rep2_list1
## 105  align1_rep2_list1
## 106  align1_rep2_list1
## 107  align1_rep2_list1
## 108  align1_rep2_list1
## 109  align1_rep2_list1
## 110  align1_rep2_list1
## 111  align1_rep2_list1
## 112  align1_rep2_list1
## 113  align1_rep2_list1
## 114  align1_rep2_list1
## 115  align1_rep2_list1
## 116  align1_rep2_list1
## 117  align1_rep2_list1
## 118  align1_rep2_list1
## 119  align1_rep2_list1
## 120  align1_rep2_list1
## 121  align1_rep2_list1
## 122  align1_rep2_list1
## 123  align1_rep2_list1
## 124  align1_rep2_list1
## 125  align1_rep2_list1
## 126  align1_rep2_list1
## 127  align1_rep2_list1
## 128  align1_rep2_list1
## 129  align1_rep2_list1
## 130  align1_rep2_list1
## 131  align1_rep2_list1
## 132  align1_rep2_list1
## 133  align1_rep2_list1
## 134  align1_rep2_list1
## 135  align1_rep2_list1
## 136  align1_rep2_list1
## 137  align1_rep2_list1
## 138  align1_rep2_list1
## 139  align1_rep2_list1
## 140  align1_rep2_list1
## 141  align1_rep2_list1
## 142  align1_rep2_list1
## 143  align1_rep2_list1
## 144  align1_rep2_list1
## 145  align1_rep2_list1
## 146  align1_rep2_list1
## 147  align1_rep2_list1
## 148  align1_rep2_list1
## 149  align1_rep2_list1
## 150  align1_rep2_list1
## 151  align1_rep2_list1
## 152  align1_rep2_list1
## 153  align1_rep2_list1
## 154  align1_rep2_list1
## 155  align1_rep2_list1
## 156  align1_rep2_list1
## 157  align1_rep2_list1
## 158  align1_rep2_list1
## 159  align1_rep2_list1
## 160  align1_rep2_list1
## 161  align1_rep2_list1
## 162  align1_rep2_list1
## 163  align1_rep2_list1
## 164  align1_rep2_list1
## 165  align1_rep2_list1
## 166  align1_rep2_list1
## 167  align1_rep2_list1
## 168  align1_rep2_list1
## 169  align1_rep2_list1
## 170  align1_rep2_list1
## 171  align1_rep2_list1
## 172  align1_rep2_list1
## 173  align1_rep2_list1
## 174  align1_rep2_list1
## 175  align1_rep2_list1
## 176  align1_rep2_list1
## 177  align1_rep2_list1
## 178  align1_rep2_list1
## 179  align1_rep2_list1
## 180  align1_rep2_list1
## 181  align1_rep2_list1
## 182  align1_rep2_list1
## 183  align1_rep2_list1
## 184  align1_rep2_list1
## 185  align1_rep2_list1
## 186  align1_rep2_list1
## 187  align1_rep2_list1
## 188  align1_rep2_list1
## 189  align1_rep2_list1
## 190  align1_rep2_list1
## 191  align1_rep2_list1
## 192  align1_rep2_list1
## 193  align1_rep2_list1
## 194  align1_rep2_list1
## 195  align1_rep2_list1
## 196  align1_rep2_list1
## 197  align1_rep2_list1
## 198  align1_rep2_list1
## 199  align1_rep2_list1
## 200  align1_rep2_list1
## 201  align2_rep1_list1
## 202  align2_rep1_list1
## 203  align2_rep1_list1
## 204  align2_rep1_list1
## 205  align2_rep1_list1
## 206  align2_rep1_list1
## 207  align2_rep1_list1
## 208  align2_rep1_list1
## 209  align2_rep1_list1
## 210  align2_rep1_list1
## 211  align2_rep1_list1
## 212  align2_rep1_list1
## 213  align2_rep1_list1
## 214  align2_rep1_list1
## 215  align2_rep1_list1
## 216  align2_rep1_list1
## 217  align2_rep1_list1
## 218  align2_rep1_list1
## 219  align2_rep1_list1
## 220  align2_rep1_list1
## 221  align2_rep1_list1
## 222  align2_rep1_list1
## 223  align2_rep1_list1
## 224  align2_rep1_list1
## 225  align2_rep1_list1
## 226  align2_rep1_list1
## 227  align2_rep1_list1
## 228  align2_rep1_list1
## 229  align2_rep1_list1
## 230  align2_rep1_list1
## 231  align2_rep1_list1
## 232  align2_rep1_list1
## 233  align2_rep1_list1
## 234  align2_rep1_list1
## 235  align2_rep1_list1
## 236  align2_rep1_list1
## 237  align2_rep1_list1
## 238  align2_rep1_list1
## 239  align2_rep1_list1
## 240  align2_rep1_list1
## 241  align2_rep1_list1
## 242  align2_rep1_list1
## 243  align2_rep1_list1
## 244  align2_rep1_list1
## 245  align2_rep1_list1
## 246  align2_rep1_list1
## 247  align2_rep1_list1
## 248  align2_rep1_list1
## 249  align2_rep1_list1
## 250  align2_rep1_list1
## 251  align2_rep1_list1
## 252  align2_rep1_list1
## 253  align2_rep1_list1
## 254  align2_rep1_list1
## 255  align2_rep1_list1
## 256  align2_rep1_list1
## 257  align2_rep1_list1
## 258  align2_rep1_list1
## 259  align2_rep1_list1
## 260  align2_rep1_list1
## 261  align2_rep1_list1
## 262  align2_rep1_list1
## 263  align2_rep1_list1
## 264  align2_rep1_list1
## 265  align2_rep1_list1
## 266  align2_rep1_list1
## 267  align2_rep1_list1
## 268  align2_rep1_list1
## 269  align2_rep1_list1
## 270  align2_rep1_list1
## 271  align2_rep1_list1
## 272  align2_rep1_list1
## 273  align2_rep1_list1
## 274  align2_rep1_list1
## 275  align2_rep1_list1
## 276  align2_rep1_list1
## 277  align2_rep1_list1
## 278  align2_rep1_list1
## 279  align2_rep1_list1
## 280  align2_rep1_list1
## 281  align2_rep1_list1
## 282  align2_rep1_list1
## 283  align2_rep1_list1
## 284  align2_rep1_list1
## 285  align2_rep1_list1
## 286  align2_rep1_list1
## 287  align2_rep1_list1
## 288  align2_rep1_list1
## 289  align2_rep1_list1
## 290  align2_rep1_list1
## 291  align2_rep1_list1
## 292  align2_rep1_list1
## 293  align2_rep1_list1
## 294  align2_rep1_list1
## 295  align2_rep1_list1
## 296  align2_rep1_list1
## 297  align2_rep1_list1
## 298  align2_rep1_list1
## 299  align2_rep1_list1
## 300  align2_rep1_list1
## 301  align2_rep2_list1
## 302  align2_rep2_list1
## 303  align2_rep2_list1
## 304  align2_rep2_list1
## 305  align2_rep2_list1
## 306  align2_rep2_list1
## 307  align2_rep2_list1
## 308  align2_rep2_list1
## 309  align2_rep2_list1
## 310  align2_rep2_list1
## 311  align2_rep2_list1
## 312  align2_rep2_list1
## 313  align2_rep2_list1
## 314  align2_rep2_list1
## 315  align2_rep2_list1
## 316  align2_rep2_list1
## 317  align2_rep2_list1
## 318  align2_rep2_list1
## 319  align2_rep2_list1
## 320  align2_rep2_list1
## 321  align2_rep2_list1
## 322  align2_rep2_list1
## 323  align2_rep2_list1
## 324  align2_rep2_list1
## 325  align2_rep2_list1
## 326  align2_rep2_list1
## 327  align2_rep2_list1
## 328  align2_rep2_list1
## 329  align2_rep2_list1
## 330  align2_rep2_list1
## 331  align2_rep2_list1
## 332  align2_rep2_list1
## 333  align2_rep2_list1
## 334  align2_rep2_list1
## 335  align2_rep2_list1
## 336  align2_rep2_list1
## 337  align2_rep2_list1
## 338  align2_rep2_list1
## 339  align2_rep2_list1
## 340  align2_rep2_list1
## 341  align2_rep2_list1
## 342  align2_rep2_list1
## 343  align2_rep2_list1
## 344  align2_rep2_list1
## 345  align2_rep2_list1
## 346  align2_rep2_list1
## 347  align2_rep2_list1
## 348  align2_rep2_list1
## 349  align2_rep2_list1
## 350  align2_rep2_list1
## 351  align2_rep2_list1
## 352  align2_rep2_list1
## 353  align2_rep2_list1
## 354  align2_rep2_list1
## 355  align2_rep2_list1
## 356  align2_rep2_list1
## 357  align2_rep2_list1
## 358  align2_rep2_list1
## 359  align2_rep2_list1
## 360  align2_rep2_list1
## 361  align2_rep2_list1
## 362  align2_rep2_list1
## 363  align2_rep2_list1
## 364  align2_rep2_list1
## 365  align2_rep2_list1
## 366  align2_rep2_list1
## 367  align2_rep2_list1
## 368  align2_rep2_list1
## 369  align2_rep2_list1
## 370  align2_rep2_list1
## 371  align2_rep2_list1
## 372  align2_rep2_list1
## 373  align2_rep2_list1
## 374  align2_rep2_list1
## 375  align2_rep2_list1
## 376  align2_rep2_list1
## 377  align2_rep2_list1
## 378  align2_rep2_list1
## 379  align2_rep2_list1
## 380  align2_rep2_list1
## 381  align2_rep2_list1
## 382  align2_rep2_list1
## 383  align2_rep2_list1
## 384  align2_rep2_list1
## 385  align2_rep2_list1
## 386  align2_rep2_list1
## 387  align2_rep2_list1
## 388  align2_rep2_list1
## 389  align2_rep2_list1
## 390  align2_rep2_list1
## 391  align2_rep2_list1
## 392  align2_rep2_list1
## 393  align2_rep2_list1
## 394  align2_rep2_list1
## 395  align2_rep2_list1
## 396  align2_rep2_list1
## 397  align2_rep2_list1
## 398  align2_rep2_list1
## 399  align2_rep2_list1
## 400  align2_rep2_list1
## 401         ctrl_list1
## 402         ctrl_list1
## 403         ctrl_list1
## 404         ctrl_list1
## 405         ctrl_list1
## 406         ctrl_list1
## 407         ctrl_list1
## 408         ctrl_list1
## 409         ctrl_list1
## 410         ctrl_list1
## 411         ctrl_list1
## 412         ctrl_list1
## 413         ctrl_list1
## 414         ctrl_list1
## 415         ctrl_list1
## 416         ctrl_list1
## 417         ctrl_list1
## 418         ctrl_list1
## 419         ctrl_list1
## 420         ctrl_list1
## 421         ctrl_list1
## 422         ctrl_list1
## 423         ctrl_list1
## 424         ctrl_list1
## 425         ctrl_list1
## 426         ctrl_list1
## 427         ctrl_list1
## 428         ctrl_list1
## 429         ctrl_list1
## 430         ctrl_list1
## 431         ctrl_list1
## 432         ctrl_list1
## 433         ctrl_list1
## 434         ctrl_list1
## 435         ctrl_list1
## 436         ctrl_list1
## 437         ctrl_list1
## 438         ctrl_list1
## 439         ctrl_list1
## 440         ctrl_list1
## 441         ctrl_list1
## 442         ctrl_list1
## 443         ctrl_list1
## 444         ctrl_list1
## 445         ctrl_list1
## 446         ctrl_list1
## 447         ctrl_list1
## 448         ctrl_list1
## 449         ctrl_list1
## 450         ctrl_list1
## 451         ctrl_list1
## 452         ctrl_list1
## 453         ctrl_list1
## 454         ctrl_list1
## 455         ctrl_list1
## 456         ctrl_list1
## 457         ctrl_list1
## 458         ctrl_list1
## 459         ctrl_list1
## 460         ctrl_list1
## 461         ctrl_list1
## 462         ctrl_list1
## 463         ctrl_list1
## 464         ctrl_list1
## 465         ctrl_list1
## 466         ctrl_list1
## 467         ctrl_list1
## 468         ctrl_list1
## 469         ctrl_list1
## 470         ctrl_list1
## 471         ctrl_list1
## 472         ctrl_list1
## 473         ctrl_list1
## 474         ctrl_list1
## 475         ctrl_list1
## 476         ctrl_list1
## 477         ctrl_list1
## 478         ctrl_list1
## 479         ctrl_list1
## 480         ctrl_list1
## 481         ctrl_list1
## 482         ctrl_list1
## 483         ctrl_list1
## 484         ctrl_list1
## 485         ctrl_list1
## 486         ctrl_list1
## 487         ctrl_list1
## 488         ctrl_list1
## 489         ctrl_list1
## 490         ctrl_list1
## 491         ctrl_list1
## 492         ctrl_list1
## 493         ctrl_list1
## 494         ctrl_list1
## 495         ctrl_list1
## 496         ctrl_list1
## 497         ctrl_list1
## 498         ctrl_list1
## 499         ctrl_list1
## 500         ctrl_list1
## 501  align1_rep1_list2
## 502  align1_rep1_list2
## 503  align1_rep1_list2
## 504  align1_rep1_list2
## 505  align1_rep1_list2
## 506  align1_rep1_list2
## 507  align1_rep1_list2
## 508  align1_rep1_list2
## 509  align1_rep1_list2
## 510  align1_rep1_list2
## 511  align1_rep1_list2
## 512  align1_rep1_list2
## 513  align1_rep1_list2
## 514  align1_rep1_list2
## 515  align1_rep1_list2
## 516  align1_rep1_list2
## 517  align1_rep1_list2
## 518  align1_rep1_list2
## 519  align1_rep1_list2
## 520  align1_rep1_list2
## 521  align1_rep1_list2
## 522  align1_rep1_list2
## 523  align1_rep1_list2
## 524  align1_rep1_list2
## 525  align1_rep1_list2
## 526  align1_rep1_list2
## 527  align1_rep1_list2
## 528  align1_rep1_list2
## 529  align1_rep1_list2
## 530  align1_rep1_list2
## 531  align1_rep1_list2
## 532  align1_rep1_list2
## 533  align1_rep1_list2
## 534  align1_rep1_list2
## 535  align1_rep1_list2
## 536  align1_rep1_list2
## 537  align1_rep1_list2
## 538  align1_rep1_list2
## 539  align1_rep1_list2
## 540  align1_rep1_list2
## 541  align1_rep1_list2
## 542  align1_rep1_list2
## 543  align1_rep1_list2
## 544  align1_rep1_list2
## 545  align1_rep1_list2
## 546  align1_rep1_list2
## 547  align1_rep1_list2
## 548  align1_rep1_list2
## 549  align1_rep1_list2
## 550  align1_rep1_list2
## 551  align1_rep1_list2
## 552  align1_rep1_list2
## 553  align1_rep1_list2
## 554  align1_rep1_list2
## 555  align1_rep1_list2
## 556  align1_rep1_list2
## 557  align1_rep1_list2
## 558  align1_rep1_list2
## 559  align1_rep1_list2
## 560  align1_rep1_list2
## 561  align1_rep1_list2
## 562  align1_rep1_list2
## 563  align1_rep1_list2
## 564  align1_rep1_list2
## 565  align1_rep1_list2
## 566  align1_rep1_list2
## 567  align1_rep1_list2
## 568  align1_rep1_list2
## 569  align1_rep1_list2
## 570  align1_rep1_list2
## 571  align1_rep1_list2
## 572  align1_rep1_list2
## 573  align1_rep1_list2
## 574  align1_rep1_list2
## 575  align1_rep1_list2
## 576  align1_rep1_list2
## 577  align1_rep1_list2
## 578  align1_rep1_list2
## 579  align1_rep1_list2
## 580  align1_rep1_list2
## 581  align1_rep1_list2
## 582  align1_rep1_list2
## 583  align1_rep1_list2
## 584  align1_rep1_list2
## 585  align1_rep1_list2
## 586  align1_rep1_list2
## 587  align1_rep1_list2
## 588  align1_rep1_list2
## 589  align1_rep1_list2
## 590  align1_rep1_list2
## 591  align1_rep1_list2
## 592  align1_rep1_list2
## 593  align1_rep1_list2
## 594  align1_rep1_list2
## 595  align1_rep1_list2
## 596  align1_rep1_list2
## 597  align1_rep1_list2
## 598  align1_rep1_list2
## 599  align1_rep1_list2
## 600  align1_rep1_list2
## 601  align1_rep2_list2
## 602  align1_rep2_list2
## 603  align1_rep2_list2
## 604  align1_rep2_list2
## 605  align1_rep2_list2
## 606  align1_rep2_list2
## 607  align1_rep2_list2
## 608  align1_rep2_list2
## 609  align1_rep2_list2
## 610  align1_rep2_list2
## 611  align1_rep2_list2
## 612  align1_rep2_list2
## 613  align1_rep2_list2
## 614  align1_rep2_list2
## 615  align1_rep2_list2
## 616  align1_rep2_list2
## 617  align1_rep2_list2
## 618  align1_rep2_list2
## 619  align1_rep2_list2
## 620  align1_rep2_list2
## 621  align1_rep2_list2
## 622  align1_rep2_list2
## 623  align1_rep2_list2
## 624  align1_rep2_list2
## 625  align1_rep2_list2
## 626  align1_rep2_list2
## 627  align1_rep2_list2
## 628  align1_rep2_list2
## 629  align1_rep2_list2
## 630  align1_rep2_list2
## 631  align1_rep2_list2
## 632  align1_rep2_list2
## 633  align1_rep2_list2
## 634  align1_rep2_list2
## 635  align1_rep2_list2
## 636  align1_rep2_list2
## 637  align1_rep2_list2
## 638  align1_rep2_list2
## 639  align1_rep2_list2
## 640  align1_rep2_list2
## 641  align1_rep2_list2
## 642  align1_rep2_list2
## 643  align1_rep2_list2
## 644  align1_rep2_list2
## 645  align1_rep2_list2
## 646  align1_rep2_list2
## 647  align1_rep2_list2
## 648  align1_rep2_list2
## 649  align1_rep2_list2
## 650  align1_rep2_list2
## 651  align1_rep2_list2
## 652  align1_rep2_list2
## 653  align1_rep2_list2
## 654  align1_rep2_list2
## 655  align1_rep2_list2
## 656  align1_rep2_list2
## 657  align1_rep2_list2
## 658  align1_rep2_list2
## 659  align1_rep2_list2
## 660  align1_rep2_list2
## 661  align1_rep2_list2
## 662  align1_rep2_list2
## 663  align1_rep2_list2
## 664  align1_rep2_list2
## 665  align1_rep2_list2
## 666  align1_rep2_list2
## 667  align1_rep2_list2
## 668  align1_rep2_list2
## 669  align1_rep2_list2
## 670  align1_rep2_list2
## 671  align1_rep2_list2
## 672  align1_rep2_list2
## 673  align1_rep2_list2
## 674  align1_rep2_list2
## 675  align1_rep2_list2
## 676  align1_rep2_list2
## 677  align1_rep2_list2
## 678  align1_rep2_list2
## 679  align1_rep2_list2
## 680  align1_rep2_list2
## 681  align1_rep2_list2
## 682  align1_rep2_list2
## 683  align1_rep2_list2
## 684  align1_rep2_list2
## 685  align1_rep2_list2
## 686  align1_rep2_list2
## 687  align1_rep2_list2
## 688  align1_rep2_list2
## 689  align1_rep2_list2
## 690  align1_rep2_list2
## 691  align1_rep2_list2
## 692  align1_rep2_list2
## 693  align1_rep2_list2
## 694  align1_rep2_list2
## 695  align1_rep2_list2
## 696  align1_rep2_list2
## 697  align1_rep2_list2
## 698  align1_rep2_list2
## 699  align1_rep2_list2
## 700  align1_rep2_list2
## 701  align2_rep1_list2
## 702  align2_rep1_list2
## 703  align2_rep1_list2
## 704  align2_rep1_list2
## 705  align2_rep1_list2
## 706  align2_rep1_list2
## 707  align2_rep1_list2
## 708  align2_rep1_list2
## 709  align2_rep1_list2
## 710  align2_rep1_list2
## 711  align2_rep1_list2
## 712  align2_rep1_list2
## 713  align2_rep1_list2
## 714  align2_rep1_list2
## 715  align2_rep1_list2
## 716  align2_rep1_list2
## 717  align2_rep1_list2
## 718  align2_rep1_list2
## 719  align2_rep1_list2
## 720  align2_rep1_list2
## 721  align2_rep1_list2
## 722  align2_rep1_list2
## 723  align2_rep1_list2
## 724  align2_rep1_list2
## 725  align2_rep1_list2
## 726  align2_rep1_list2
## 727  align2_rep1_list2
## 728  align2_rep1_list2
## 729  align2_rep1_list2
## 730  align2_rep1_list2
## 731  align2_rep1_list2
## 732  align2_rep1_list2
## 733  align2_rep1_list2
## 734  align2_rep1_list2
## 735  align2_rep1_list2
## 736  align2_rep1_list2
## 737  align2_rep1_list2
## 738  align2_rep1_list2
## 739  align2_rep1_list2
## 740  align2_rep1_list2
## 741  align2_rep1_list2
## 742  align2_rep1_list2
## 743  align2_rep1_list2
## 744  align2_rep1_list2
## 745  align2_rep1_list2
## 746  align2_rep1_list2
## 747  align2_rep1_list2
## 748  align2_rep1_list2
## 749  align2_rep1_list2
## 750  align2_rep1_list2
## 751  align2_rep1_list2
## 752  align2_rep1_list2
## 753  align2_rep1_list2
## 754  align2_rep1_list2
## 755  align2_rep1_list2
## 756  align2_rep1_list2
## 757  align2_rep1_list2
## 758  align2_rep1_list2
## 759  align2_rep1_list2
## 760  align2_rep1_list2
## 761  align2_rep1_list2
## 762  align2_rep1_list2
## 763  align2_rep1_list2
## 764  align2_rep1_list2
## 765  align2_rep1_list2
## 766  align2_rep1_list2
## 767  align2_rep1_list2
## 768  align2_rep1_list2
## 769  align2_rep1_list2
## 770  align2_rep1_list2
## 771  align2_rep1_list2
## 772  align2_rep1_list2
## 773  align2_rep1_list2
## 774  align2_rep1_list2
## 775  align2_rep1_list2
## 776  align2_rep1_list2
## 777  align2_rep1_list2
## 778  align2_rep1_list2
## 779  align2_rep1_list2
## 780  align2_rep1_list2
## 781  align2_rep1_list2
## 782  align2_rep1_list2
## 783  align2_rep1_list2
## 784  align2_rep1_list2
## 785  align2_rep1_list2
## 786  align2_rep1_list2
## 787  align2_rep1_list2
## 788  align2_rep1_list2
## 789  align2_rep1_list2
## 790  align2_rep1_list2
## 791  align2_rep1_list2
## 792  align2_rep1_list2
## 793  align2_rep1_list2
## 794  align2_rep1_list2
## 795  align2_rep1_list2
## 796  align2_rep1_list2
## 797  align2_rep1_list2
## 798  align2_rep1_list2
## 799  align2_rep1_list2
## 800  align2_rep1_list2
## 801  align2_rep2_list2
## 802  align2_rep2_list2
## 803  align2_rep2_list2
## 804  align2_rep2_list2
## 805  align2_rep2_list2
## 806  align2_rep2_list2
## 807  align2_rep2_list2
## 808  align2_rep2_list2
## 809  align2_rep2_list2
## 810  align2_rep2_list2
## 811  align2_rep2_list2
## 812  align2_rep2_list2
## 813  align2_rep2_list2
## 814  align2_rep2_list2
## 815  align2_rep2_list2
## 816  align2_rep2_list2
## 817  align2_rep2_list2
## 818  align2_rep2_list2
## 819  align2_rep2_list2
## 820  align2_rep2_list2
## 821  align2_rep2_list2
## 822  align2_rep2_list2
## 823  align2_rep2_list2
## 824  align2_rep2_list2
## 825  align2_rep2_list2
## 826  align2_rep2_list2
## 827  align2_rep2_list2
## 828  align2_rep2_list2
## 829  align2_rep2_list2
## 830  align2_rep2_list2
## 831  align2_rep2_list2
## 832  align2_rep2_list2
## 833  align2_rep2_list2
## 834  align2_rep2_list2
## 835  align2_rep2_list2
## 836  align2_rep2_list2
## 837  align2_rep2_list2
## 838  align2_rep2_list2
## 839  align2_rep2_list2
## 840  align2_rep2_list2
## 841  align2_rep2_list2
## 842  align2_rep2_list2
## 843  align2_rep2_list2
## 844  align2_rep2_list2
## 845  align2_rep2_list2
## 846  align2_rep2_list2
## 847  align2_rep2_list2
## 848  align2_rep2_list2
## 849  align2_rep2_list2
## 850  align2_rep2_list2
## 851  align2_rep2_list2
## 852  align2_rep2_list2
## 853  align2_rep2_list2
## 854  align2_rep2_list2
## 855  align2_rep2_list2
## 856  align2_rep2_list2
## 857  align2_rep2_list2
## 858  align2_rep2_list2
## 859  align2_rep2_list2
## 860  align2_rep2_list2
## 861  align2_rep2_list2
## 862  align2_rep2_list2
## 863  align2_rep2_list2
## 864  align2_rep2_list2
## 865  align2_rep2_list2
## 866  align2_rep2_list2
## 867  align2_rep2_list2
## 868  align2_rep2_list2
## 869  align2_rep2_list2
## 870  align2_rep2_list2
## 871  align2_rep2_list2
## 872  align2_rep2_list2
## 873  align2_rep2_list2
## 874  align2_rep2_list2
## 875  align2_rep2_list2
## 876  align2_rep2_list2
## 877  align2_rep2_list2
## 878  align2_rep2_list2
## 879  align2_rep2_list2
## 880  align2_rep2_list2
## 881  align2_rep2_list2
## 882  align2_rep2_list2
## 883  align2_rep2_list2
## 884  align2_rep2_list2
## 885  align2_rep2_list2
## 886  align2_rep2_list2
## 887  align2_rep2_list2
## 888  align2_rep2_list2
## 889  align2_rep2_list2
## 890  align2_rep2_list2
## 891  align2_rep2_list2
## 892  align2_rep2_list2
## 893  align2_rep2_list2
## 894  align2_rep2_list2
## 895  align2_rep2_list2
## 896  align2_rep2_list2
## 897  align2_rep2_list2
## 898  align2_rep2_list2
## 899  align2_rep2_list2
## 900  align2_rep2_list2
## 901         ctrl_list2
## 902         ctrl_list2
## 903         ctrl_list2
## 904         ctrl_list2
## 905         ctrl_list2
## 906         ctrl_list2
## 907         ctrl_list2
## 908         ctrl_list2
## 909         ctrl_list2
## 910         ctrl_list2
## 911         ctrl_list2
## 912         ctrl_list2
## 913         ctrl_list2
## 914         ctrl_list2
## 915         ctrl_list2
## 916         ctrl_list2
## 917         ctrl_list2
## 918         ctrl_list2
## 919         ctrl_list2
## 920         ctrl_list2
## 921         ctrl_list2
## 922         ctrl_list2
## 923         ctrl_list2
## 924         ctrl_list2
## 925         ctrl_list2
## 926         ctrl_list2
## 927         ctrl_list2
## 928         ctrl_list2
## 929         ctrl_list2
## 930         ctrl_list2
## 931         ctrl_list2
## 932         ctrl_list2
## 933         ctrl_list2
## 934         ctrl_list2
## 935         ctrl_list2
## 936         ctrl_list2
## 937         ctrl_list2
## 938         ctrl_list2
## 939         ctrl_list2
## 940         ctrl_list2
## 941         ctrl_list2
## 942         ctrl_list2
## 943         ctrl_list2
## 944         ctrl_list2
## 945         ctrl_list2
## 946         ctrl_list2
## 947         ctrl_list2
## 948         ctrl_list2
## 949         ctrl_list2
## 950         ctrl_list2
## 951         ctrl_list2
## 952         ctrl_list2
## 953         ctrl_list2
## 954         ctrl_list2
## 955         ctrl_list2
## 956         ctrl_list2
## 957         ctrl_list2
## 958         ctrl_list2
## 959         ctrl_list2
## 960         ctrl_list2
## 961         ctrl_list2
## 962         ctrl_list2
## 963         ctrl_list2
## 964         ctrl_list2
## 965         ctrl_list2
## 966         ctrl_list2
## 967         ctrl_list2
## 968         ctrl_list2
## 969         ctrl_list2
## 970         ctrl_list2
## 971         ctrl_list2
## 972         ctrl_list2
## 973         ctrl_list2
## 974         ctrl_list2
## 975         ctrl_list2
## 976         ctrl_list2
## 977         ctrl_list2
## 978         ctrl_list2
## 979         ctrl_list2
## 980         ctrl_list2
## 981         ctrl_list2
## 982         ctrl_list2
## 983         ctrl_list2
## 984         ctrl_list2
## 985         ctrl_list2
## 986         ctrl_list2
## 987         ctrl_list2
## 988         ctrl_list2
## 989         ctrl_list2
## 990         ctrl_list2
## 991         ctrl_list2
## 992         ctrl_list2
## 993         ctrl_list2
## 994         ctrl_list2
## 995         ctrl_list2
## 996         ctrl_list2
## 997         ctrl_list2
## 998         ctrl_list2
## 999         ctrl_list2
## 1000        ctrl_list2
```

### 5.1.4 `get_params`

The various parameters used during the initialization of the `metagene` object,
the production of the table and the production of the plot are saved and can
be accessed with the `get_params` function:

```
mg <- get_demo_metagene()
mg$get_params()
```

```
## $padding_size
## [1] 0
##
## $verbose
## [1] FALSE
##
## $bam_files
##                                                          align1_rep1
## "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align1_rep1.bam"
##                                                          align1_rep2
## "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align1_rep2.bam"
##                                                          align2_rep1
## "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align2_rep1.bam"
##                                                          align2_rep2
## "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/align2_rep2.bam"
##                                                                 ctrl
##        "/tmp/RtmpvWKaCd/Rinst25f770be35de/metagene/extdata/ctrl.bam"
##
## $force_seqlevels
## [1] FALSE
##
## $flip_regions
## [1] FALSE
##
## $assay
## [1] "chipseq"
##
## $df_needs_update
## [1] TRUE
##
## $df_arguments
## [1] ""
##
## $table_needs_update
## [1] TRUE
```

### 5.1.5 `get_design`

To get the design that was used to produce the last version of the table,
you can use the `get_design` function:

```
mg$produce_table(design = get_demo_design())
```

```
## produce data table : ChIP-Seq
```

```
## Alternatively, it is also possible to add a design without producing the
## table:
mg$add_design(get_demo_design())
mg$get_design()
```

```
##           Samples align1 align2
## 1 align1_rep1.bam      1      0
## 2 align1_rep2.bam      1      0
## 3 align2_rep1.bam      0      1
## 4 align2_rep2.bam      0      1
## 5        ctrl.bam      2      2
```

### 5.1.6 `get_bam_count`

To get the number of aligned read in a BAM file, you can use the
`get_bam_count`
function:

```
mg$get_bam_count(bam_files[1])
```

```
## [1] 4635
```

### 5.1.7 `get_regions`

To get all the regions, you can use the `get_regions` function:

```
mg$get_regions()
```

```
## GRangesList object of length 2:
## $list1
## GRanges object with 50 ranges and 0 metadata columns:
##        seqnames              ranges strand
##           <Rle>           <IRanges>  <Rle>
##    [1]     chr1   16103663-16105662      *
##    [2]     chr1   23921318-23923317      *
##    [3]     chr1   34848977-34850976      *
##    [4]     chr1   36368182-36370181      *
##    [5]     chr1   36690488-36692487      *
##    ...      ...                 ...    ...
##   [46]     chr1 172081530-172083529      *
##   [47]     chr1 172081796-172083795      *
##   [48]     chr1 172147016-172149015      *
##   [49]     chr1 172205805-172207804      *
##   [50]     chr1 172260642-172262641      *
##
## ...
## <1 more element>
## -------
## seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

It is also possible to extract a subset of the regions with the `get_regions`
function:

```
mg$get_regions(region_names = c(regions[1]))
```

```
## GRangesList object of length 1:
## $list1
## GRanges object with 50 ranges and 0 metadata columns:
##        seqnames              ranges strand
##           <Rle>           <IRanges>  <Rle>
##    [1]     chr1   16103663-16105662      *
##    [2]     chr1   23921318-23923317      *
##    [3]     chr1   34848977-34850976      *
##    [4]     chr1   36368182-36370181      *
##    [5]     chr1   36690488-36692487      *
##    ...      ...                 ...    ...
##   [46]     chr1 172081530-172083529      *
##   [47]     chr1 172081796-172083795      *
##   [48]     chr1 172147016-172149015      *
##   [49]     chr1 172205805-172207804      *
##   [50]     chr1 172260642-172262641      *
##
## -------
## seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

### 5.1.8 `get_raw_coverages`

To get the coverages produced during the initialization of the `metagene`
object, you can use the `get_raw_coverages` function. Please note that to save
space, metagene will only extract the coverages in the regions provided.

```
coverages <- mg$get_raw_coverages()
coverages[[1]]
```

```
## RleList of length 22
## $chr10
## integer-Rle of length 130694993 with 1 run
##   Lengths: 130694993
##   Values :         0
##
## $chr11
## integer-Rle of length 122082543 with 1 run
##   Lengths: 122082543
##   Values :         0
##
## $chr12
## integer-Rle of length 120129022 with 1 run
##   Lengths: 120129022
##   Values :         0
##
## $chr13
## integer-Rle of length 120421639 with 1 run
##   Lengths: 120421639
##   Values :         0
##
## $chr14
## integer-Rle of length 124902244 with 1 run
##   Lengths: 124902244
##   Values :         0
##
## ...
## <17 more elements>
```

```
length(coverages)
```

```
## [1] 5
```

It is also possible to extract a subset of all the coverages by providing the
filenames:

```
coverages <- mg$get_raw_coverages(filenames = bam_files[1:2])
length(coverages)
```

```
## [1] 2
```

### 5.1.9 `get_normalized_coverages`

The `get_normalized_coverages` function works exactly like the
`get_raw_coverages` function except that it returns the coverages in read per
million aligned (RPM).

## 5.2 Chaining functions

Every function of metagene (except for the getters) invisibly return a pointer
to itself. This means that the functions can be chained:

```
rg <- get_demo_regions()
bam <- get_demo_bam_files()
d <- get_demo_design()
title <- "Show chain"
mg <- metagene$new(rg, bam)$produce_table(design = d)$plot(title = title)
```

```
## produce data table : ChIP-Seq
```

```
## produce data frame : ChIP-Seq
```

```
## Plot : ChIP-Seq
```

![](data:image/png;base64...)

## 5.3 Copying a metagene object

To copy a metagene object, you have to use the `clone` function:

```
mg_copy <- mg$clone()
```

# 6 Managing large datasets

While `metagene` try to reduce it’s memory usage, it’s possible to run into
memory limits when working with multiple large datasets (especially when there
is a lot of regions with a large width).

One way to avoid this is to analyse each dataset seperately and then merge just
before producing the metagene plot:

```
mg1 <- metagene$new(bam_files = bam_files, regions = regions[1])
mg1$produce_data_frame()
## produce data table : ChIP-Seq
## produce data frame : ChIP-Seq
mg2 <- metagene$new(bam_files = bam_files, regions = regions[2])
mg2$produce_data_frame()
## produce data table : ChIP-Seq
## produce data frame : ChIP-Seq
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
```

```
## Plot : ChIP-Seq
```

```
p + ggplot2::ggtitle("Managing large datasets")
```

![](data:image/png;base64...)

# 7 Comparing profiles with permutations

It is possible to compare two metagene profiles using the `permutation_test`
function provided with the `metagene` package. Please note that the permutation
tests functionality is still in development and is expected to change in future
releases.

The first step is to decide which profiles we want to compare and extract the
corresponding tables :

```
tab <- mg$get_table()
tab0 <- tab[which(tab$region == "list1"),]
tab1 <- tab0[which(tab0$design == "align1"),]
tab2 <- tab0[which(tab0$design == "align2"),]
```

Then we defined to function to use to compare the two profiles. For this, a
companion package of `metagene` named *[similaRpeak](https://bioconductor.org/packages/3.8/similaRpeak)* provides
multiple metrics.

For this example, we will prepare a function to calculate the
RATIO\_NORMALIZED\_INTERSECT between two profiles:

```
library(similaRpeak)
perm_fun <- function(profile1, profile2) {
    sim <- similarity(profile1, profile2)
    sim[["metrics"]][["RATIO_NORMALIZED_INTERSECT"]]
}
```

We then compare our two profiles using this metric:

```
ratio_normalized_intersect <-
 perm_fun(tab1[, .(moy=mean(value)), by=bin]$moy,
        tab2[, .(moy=mean(value)), by=bin]$moy)
ratio_normalized_intersect
```

```
## [1] 0.7387951
```

To check if this value is significant, we can permute the two tables that
were used to produce the profile and calculate their
RATIO\_NORMALIZED\_INTERSECT:

```
permutation_results <- permutation_test(tab1, tab2, sample_size = 50,
                                        sample_count = 1000, FUN = perm_fun)
```

Finally, we check how often the calculated value is greater than the results of
the permutations:

```
sum(ratio_normalized_intersect >= permutation_results) /
                                length(permutation_results)
```

```
## [1] 0.025
```