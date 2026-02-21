How to use breakpointR

David Porubsky ∗

∗

david.porubsky@gmail.com

October 29, 2025

Contents

1

2

3

Introduction .

Quickstart .

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

2.1

Running breakpointR .

Recommended settings .

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

3

4

4

4

4

4

5

5

5

7

Reading BAM files .

.

Removing certain regions .

Binning strategy .

.

.

.

.

Breakpoint peak detection .

Background reads .

.

.

.

.

Calling breakpoint hotspots .

3.1

3.2

3.3

3.4

3.5

3.6

3.7

Loading results and plotting single cells .

4

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

.

How to use breakpointR

1

Introduction

BreakpointR is a novel algorithm designed to accurately tracks template strand changes
in Strand-seq data using a bi-directional read-based binning. Read-based binning strategy
scales each bin size dynamically to accommodate defined number of reads what accounts for
mappability bias in sparsely covered single-cell Strand-seq data. In such dynamically scaled
bins, read directionality is tracked in order to search for points where template-strand-state
changes. BreakpointR takes as an input reads aligned to the reference genome and stored
in a single BAM file per single cell. BreakpointR outputs locations where directionality of
sequenced template strands changes. Template strands changes are defined by changes in
proportion of reads mapped to positive (’Crick’) and negative (’Watson’) strand of the refer-
ence genome. In a diploid organism such as human we distinguish three possible scenarios of
template strand inheritence. If both parental homologues were inherited as Watson template
(we assign a WW state), if only Crick templates were inherited (we assign CC state), or one
Watson and one Crick template was inherited by each parent (we assign WC state).

2

Quickstart

The main function of this package is called breakpointr() and performs all the necessary
steps to get from aligned reads in BAMs to predicted breakpoints (changes) in strand direc-
tionality. For an unexperienced user we advise to run breakpointR with default parameters
and later based on the obtained results start to tweak certain parameters. For more detailed
guidance on how to tweak certain parameters see section 3.

library(breakpointR)

## Run breakpointR with a default parameters

breakpointr(inputfolder='folder-with-BAMs', outputfolder='output-folder')

Although in most cases the one of the above commands will produce reasonably good results,
it might be worthwhile to adjust the default parameters in order to improve performance and
the quality of the results. You can get a description of all available parameters by typing

?breakpointr

After the function has finished, you will find the folder output-directory containing all
produced files and plots. This folder contains the following files and folders:

• breakpointR.config: This file contains all parameters that are necessary to reproduce
your analysis. You can specify this file as shown below in order to run another analysis
with the same parameter settings.

breakpointr(..., configfile='breakpointR.config')

• breakpoints UCSC browser formatted bedgraphs compile all breakpoints across all
localized breakpoints in all

single-cell
single-cell libraries. Lastly, locations of breakpoint hotspots are reported here if

libraries. This folder also contains list of all

callHotSpots=TRUE

• browserfiles UCSC browser formatted files with exported reads, deltaWs and break-

points for every single-cell library.

2

How to use breakpointR

• data Contains RData files that store complete results of breakpointR analysis for each

single-cell library.

• plots: Genome-wide plots for selected chromosomes, genome-wide heatmap of strand
states as well as chromosome specific read distribution together with localized break-
points. All aforementioned plots are created by default.

2.1

Running breakpointR
The function breakpointr() takes as an input BAM files stored in the inputfolder and pro-
duces an outputfolder with results, plots and browserfiles. The following code is an example
of how to run breakpointR on single-end reads with a ’windowsize’ defined by size of 1Mb
(see subsection 3.3). Results will be stored in outputfolder/data as RData objects. Such
data can be later loaded for further processing and customized plotting.

library(breakpointR)

## Get some example files
datafolder <- system.file("extdata", "example_bams", package="breakpointRdata")
outputfolder <- tempdir()

## Run breakpointR

breakpointr(inputfolder = datafolder, outputfolder = outputfolder,

chromosomes = 'chr22', pairedEndReads = FALSE,

reuse.existing.files = FALSE, windowsize = 1000000,

binMethod = 'size', pair2frgm = FALSE, min.mapq = 10,

filtAlt = TRUE)

## Warning: ‘aes_string()‘ was deprecated in ggplot2 3.0.0.
## i Please use tidy evaluation idioms with ‘aes()‘.

## i See also ‘vignette("ggplot2-in-packages")‘ for more information.

## i The deprecated feature was likely used in the breakpointR package.

##

Please report the issue to the authors.

## This warning is displayed once every 8 hours.
## Call ‘lifecycle::last_lifecycle_warnings()‘ to see where this warning was generated.

## Warning: Using ‘size‘ aesthetic for lines was deprecated in ggplot2 3.4.0.

## i Please use ‘linewidth‘ instead.

## i The deprecated feature was likely used in the breakpointR package.

##

Please report the issue to the authors.

## This warning is displayed once every 8 hours.
## Call ‘lifecycle::last_lifecycle_warnings()‘ to see where this warning was generated.

3

How to use breakpointR

3

3.1

3.2

Recommended settings

Reading BAM files
Currently breakpointR can take as an input only aligned reads stored in BAM files. All BAM
files are expected to be present in a folder specified as breakpointr(..., inputfolder).
We advise to remove reads with low mapping quality and reads with alternative alignments.
Duplicated reads are removed by default.

breakpointr(..., min.mapq = 10, filtAlt = TRUE)

Removing certain regions
breakpointR allows a user to exclude certain genomic regions from the analysis. This comes
handy when one wants to remove reads that falls into low complexity regions such as seg-
mental duplications or centromeres. Such low complexity regions might cause false positive
breakpoints due to the spurious mappings of short reads. To mask certain genomic regions
user has to define path to a bed formatted text file as breakpointr(..., maskRegions). All
reads falling into these regions will be discarded prior to breakpoint detection. User defined
regions to mask can be downloaded from the UCSC Table Browser.

3.3

Binning strategy
breakpointR uses read based binning strategy and offers two approaches to set the bin size:
(1) user defined number of reads in each bin or (2) number of reads in every bin is selected
based on desired genomic size of each bin.

library(breakpointR)

## Binning strategy based on desired bin length

breakpointr(inputfolder='folder-with-BAM', outputfolder='output-folder',

windowsize=1e6, binMethod='size')

## Binning strategy based user-defined number of reads in each bin

breakpointr(inputfolder='folder-with-BAM', outputfolder='output-folder',

windowsize=100, binMethod='reads')

The sensitivity and specificity of breakpoint detection depend on user defined bin size. We
recommend to select rather large bin size (>=1Mb) in order to reliably detect low frequency
sister chromatid exchange (SCE) events.
In order to detect smaller events like inversions
smaller bin size is recommended. Keep in mind that such settings also leads to a higher level
of false positive breakpoints. In this case one might need to tweak other breakpoint detection
parameters (see subsection 3.4).

3.4

Breakpoint peak detection
Breakpoint detection is based on finding significant peaks in deltaW values. Level of peak
significance is measured in the number of standard deviations (SD) from the set threshold
(z-score) breakpointr(..., peakTh). By default the threshold is set to the 1/3 of the highest
detlaW value. For the data with noisy and uneven coverage we recommend to set higher
threshold, for example 1/2 of the highest deltaW value. In addition, we also recommend to
tweak ’trim’ option breakpointr(..., trim) in order to set a fraction of extreme deltaW
values to be excluded from SD calculation.

4

How to use breakpointR

## Example deltaW values
exampleFolder <- system.file("extdata", "example_results",

package="breakpointRdata")

exampleFile <- list.files(exampleFolder, full.names=TRUE)[1]

breakpoint.object <- loadFromFiles(exampleFile)

head(breakpoint.object[[1]]$deltas)

## GRanges object with 6 ranges and 1 metadata column:

##

##

##

##

##

##

##

##

##

##

seqnames

ranges strand |

deltaW

<Rle>

<IRanges> <Rle> | <numeric>

[1]

[2]

[3]

[4]

[5]

[6]

-------

chr1

chr1

7560-7594

8569-8612

chr1 15116-15143

chr1 17235-17240

chr1 19615-19720

chr1 19849-19911

- |

+ |

- |

- |

- |

- |

17

0

57

130

41

38

seqinfo: 23 sequences from an unspecified genome

3.5

3.6

Background reads
Background reads are a common feature of Strand-seq libraries. Strand-seq is based on
removal of newly synthesized strand during DNA replication, however this process is not
perfect. Therefore, we usually expect low abundance reads aligned in a opposite direction
even for purely WW or CC chromosomes. An another reason to see such artifacs is imperfect
read mapping especially in repetitive and complex genomic regions. To remove reads falling
into such regions see subsection 3.2.

Calling breakpoint hotspots
In order to find locations where breakpoints occur around the same genomic position in
multiple Strand-seq libraries there is hotspotter(). Function can be invoked by setting
corresponding parameter to ’TRUE’. It make sense to set this parameter only if there is
available a reasonable number (>=50) of Strand-seq libraries.

## To run breakpoint hotspot analysis using the main breakpointR function

breakpointr(..., callHotSpots=TRUE)

## To run breakpoint hotspot analysis using exported data
exampleFolder <- system.file("extdata", "example_results",

package="breakpointRdata")

exampleFiles <- list.files(exampleFolder, full.names=TRUE)

breakpoint.objects <- loadFromFiles(exampleFiles)

## Extract breakpoint coordinates

breaks <- lapply(breakpoint.objects, '[[', 'breaks')

## Get hotspot coordinates

hotspots <- hotspotter(breaks, bw=1e6)

3.7

Loading results and plotting single cells

5

How to use breakpointR

## Plotting a single library
exampleFolder <- system.file("extdata", "example_results",

package="breakpointRdata")

exampleFile <- list.files(exampleFolder, full.names=TRUE)[1]

plotBreakpoints(exampleFile)

## [[1]]

## Plotting a single library
exampleFolder <- system.file("extdata", "example_results",

package="breakpointRdata")

exampleFiles <- list.files(exampleFolder, full.names=TRUE)[1:4]

plotBreakpointsPerChr(exampleFiles, chromosomes = 'chr7')

## $chr7

6

−2500250500Read countsbackground.estimate=0.01566  |  med.reads.per.MB=595  |  perc.coverage=4.78example_lib1.bam||Breaks12345678910111213141516171819202122XChromosomesStatesexample_lib5.bamchr7example_lib4.bamchr7example_lib3.bamchr7example_lib1.bamchr74.0e+078.0e+071.2e+084.0e+078.0e+071.2e+084.0e+078.0e+071.2e+084.0e+078.0e+071.2e+08−1000100200300−80−4004080−1000100200300−200−1000Genomic positionRead countsHow to use breakpointR

4

Session Info

toLatex(sessionInfo())

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,
LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, stats4, utils

• Other packages: BiocGenerics 0.56.0, GenomicRanges 1.62.0, IRanges 2.44.0,
S4Vectors 0.48.0, Seqinfo 1.0.0, breakpointR 1.28.0, breakpointRdata 1.27.0,
cowplot 1.2.0, generics 0.1.4, knitr 1.50

• Loaded via a namespace (and not attached): Biobase 2.70.0, BiocManager 1.30.26,

BiocParallel 1.44.0, BiocStyle 2.38.0, Biostrings 2.78.0, DelayedArray 0.36.0,
GenomeInfoDb 1.46.0, GenomicAlignments 1.46.0, Matrix 1.7-4,
MatrixGenerics 1.22.0, R6 2.6.1, RColorBrewer 1.1-3, Rsamtools 2.26.0,
S4Arrays 1.10.0, S7 0.2.0, SparseArray 1.10.0, SummarizedExperiment 1.40.0,
UCSC.utils 1.6.0, XVector 0.50.0, abind 1.4-8, bitops 1.0-9, cigarillo 1.0.0, cli 3.6.5,
codetools 0.2-20, compiler 4.5.1, crayon 1.5.3, dichromat 2.0-0.1, digest 0.6.37,
doParallel 1.0.17, dplyr 1.1.4, evaluate 1.0.5, farver 2.1.2, fastmap 1.2.0,
foreach 1.5.2, ggplot2 4.0.0, glue 1.8.0, grid 4.5.1, gtable 0.3.6, gtools 3.9.5,
highr 0.11, htmltools 0.5.8.1, httr 1.4.7, iterators 1.0.14, jsonlite 2.0.0, labeling 0.4.3,
lattice 0.22-7, lifecycle 1.0.4, magrittr 2.0.4, matrixStats 1.5.0, parallel 4.5.1,
pillar 1.11.1, pkgconfig 2.0.3, rlang 1.1.6, rmarkdown 2.30, scales 1.4.0, tibble 3.3.0,
tidyselect 1.2.1, tinytex 0.57, tools 4.5.1, vctrs 0.6.5, withr 3.0.2, xfun 0.53,
yaml 2.3.10

7

