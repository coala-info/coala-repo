CopywriteR: DNA copy number detection from
oﬀ-target sequence data.

Thomas Kuilman

October 30, 2017

Department of Molecular Oncology
Netherlands Cancer Institute
The Netherlands

t.kuilman@nki.nl or thomaskuilman@yahoo.com

Contents

1

2

3

4

5

3.1

3.2

3.3

3.4

Overview.

.

.

.

.

.

.

.

CopywriteR workﬂow .

Analysis workﬂow.

.

.

preCopywriteR() .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

BiocParallel for parallel computing .

CopywriteR() .

plotCNA() .

Troubleshooting .

Session Information .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1

2

2

2

4

5

7

8

9

1

Overview

To extract copy number information from targeted sequencing data while circumventing
problems related to the use of on-target reads, we developed the CopywriteR package. Unlike
other currently available tools, CopywriteR is based on oﬀ-target reads. We have shown that
this approach has several advantages relative to current approaches [1] and it constitutes a
viable alternative for copy number detection from targeted sequencing data.

CopywriteR: DNA copy number detection from oﬀ-target sequence data.

2

CopywriteR workﬂow

CopywriteR uses .bam ﬁles as an input. These ﬁles are processed in several steps to allow
copy number detection from oﬀ-target reads of targeted sequencing eﬀorts. These steps
include:

• Removing of low-quality and anomalous reads

• Peak calling (in reference when available, otherwise in sample itself)

• Discarding of reads in peak regions

• Counting reads on bins of pre-deﬁned size

• Compensating for the diﬀerence in eﬀective bin size upon discarding peaks in peak

regions

• Correcting for GC-content and mappability; applying a blacklist ﬁlter for CNV regions

3

Analysis workﬂow

The full analysis of copy number data with CopywriteR includes three sequential steps, using
the preCopywriteR(), CopywriteR() and plotCNA() functions respectively.

In this analysis workﬂow, we will use CopywriteR to extract copy number information from
whole-exome sequening data from a murine small-cell lung cancer. The complete dataset can
be downloaded from the European Nucleotide Archive (http://www.ebi.ac.uk/ena/home)
using the accession number PRJEB6954. In this vignette, only the sequence reads on chro-
mosome 4 are used. The .bam ﬁle, which has been pre-ﬁltered to minimize disk usage, is
contained in the SCLCBam package. Before starting the analysis, GC-content and mappa-
bility helper ﬁles need to be created for the desired bin size and reference genome. This is
done using the preCopywriteR() function.

3.1

preCopywriteR()

CopywriteR uses binned read count data as a basis for copy number detection. We have pre-
assembled 1 kb bin GC-content and mappability information for the hg18, hg19, hg38, mm9
and mm10 reference genomes in the CopyhelpeR package. The preCopywriteR() function
allows to create the necessary helper ﬁles. These ﬁles can be created for any custom bin size
that is a multiple of 1000 bp, and for the above-mentioned reference genomes. The helper
ﬁles are saved in a new folder that is names after the relevant reference genome, the bin
size, and the preﬁx (all separated by ’_’). The helper ﬁles are required to run CopywriteR. If
previously created helper ﬁles for a speciﬁc bin size / reference genome / preﬁx combination
are available, the preCopywriteR() step can be omitted.

In this example, CopywriteR will be applied to a bin size of 20 kb. We recommend to use a
bin size of 20 kb when trying to analyze whole-exome sequencing data, while we would start
analyzing at 50 kb resolution for targeted sequencing on smaller gene panels. As the .bam
ﬁle contained in the SCLCBam package is mapped to the mm10 reference genome, we run
preCopywriteR() as follows:

2

CopywriteR: DNA copy number detection from oﬀ-target sequence data.

> library(CopywriteR)

> data.folder <- tools::file_path_as_absolute(file.path(getwd()))

> preCopywriteR(output.folder = file.path(data.folder),

+

+

bin.size = 20000,
ref.genome = "mm10_4")

The output folder â˘AŸ/tmp/RtmpVVIilz/Rbuild418e669d8e17/CopywriteR/

vignettesâ˘A´Z has been detected

Generated GC-content and mappability data at 20000 bp resolution...

Generated blacklist file...

Please not that the "mm10_4" reference genome exclusively contains helper ﬁles for chro-
mosome 4, and therefore should only be used when replicating the analysis in this vignette.
The custom helper ﬁles are placed in a folder that is named after the reference genome and
the bin size (in this example: mm10_4_20kb). This folder, on its turn, is placed inside the
folder speciﬁed by the output.folder argument. The bin.size argument speciﬁes the custom
bin size (in bp), and the ref.genome argument can be either "hg18", "hg19", "hg38", "mm9"
or "mm10". The default chromosome notation is "1", "2", ..., "X", "Y". The preﬁx argument
is optional and can be used to add a preﬁx to these names.

If you are interested in getting helper ﬁles for other genomes, please contact me by the email
addresses supplied at the beginning of this vignette.

> list.dirs(path = file.path(data.folder), full.names = FALSE)[2]

[1] "mm10_4_20kb"

> list.files(path = file.path(data.folder, "mm10_4_20kb"), full.names = FALSE)

[1] "GC_mappability.rda" "blacklist.rda"

The data are contained in two GRanges objects (from the GenomicRanges package) of which
one (blacklist.rda) contains regions of copy number variation:

> load(file = file.path(data.folder, "mm10_4_20kb", "blacklist.rda"))
> blacklist.grange

GRanges object with 200 ranges and 0 metadata columns:

seqnames

<Rle>

ranges strand

<IRanges>

<Rle>

[1]

[2]

[3]

[4]

[5]

...

[196]

[197]

[198]

[199]

[200]

-------

4

4

4

4

4

...

[3078753, 3092353]

[3197053, 3198153]

[3227753, 3229153]

[4641353, 4642553]

[5462253, 5465053]

...

4 [149809791, 149811291]

4 [152477391, 152478591]

4 [153152191, 153154091]

4 [155624191, 155625291]

4 [155769791, 155770891]

*

*

*

*

*
...

*

*

*

*

*

3

CopywriteR: DNA copy number detection from oﬀ-target sequence data.

seqinfo: 1 sequence from an unspecified genome; no seqlengths

The other helper ﬁle (GC_mappability.rda) contains GC-content and mappability information
for a particular bin size:

> load(file = file.path(data.folder, "mm10_4_20kb", "GC_mappability.rda"))
> GC.mappa.grange[1001:1011]

GRanges object with 11 ranges and 3 metadata columns:

seqnames

<Rle>

ranges strand | ATcontent GCcontent mappability

<IRanges>

<Rle> | <numeric> <numeric>

<numeric>

[1]

[2]

[3]

[4]

[5]

[6]

[7]

[8]

[9]

[10]

[11]

-------

4 [20000001, 20020000]

4 [20020001, 20040000]

4 [20040001, 20060000]

4 [20060001, 20080000]

4 [20080001, 20100000]

4 [20100001, 20120000]

4 [20120001, 20140000]

4 [20140001, 20160000]

4 [20160001, 20180000]

4 [20180001, 20200000]

4 [20200001, 20220000]

* |
* |
* |
* |
* |
* |
* |
* |
* |
* |
* |

0.577

0.605

0.596

0.588

0.603

0.602

0.598

0.61

0.6

0.606

0.601

0.423

0.395

0.404

0.412

0.397

0.398

0.402

0.39

0.4

0.394

0.399

0.881

0.96

0.973

0.936

0.814

0.982

0.7

0.949

0.597

0.799

0.629

seqinfo: 1 sequence from an unspecified genome; no seqlengths

3.2

BiocParallel for parallel computing

CopywriteR fully supports paralel computing and is implemented in such a way that every
sample is processed on a single core. CopywriteR uses the BiocParallel for parallel computing.
This package requires the user to specify which parallel environment is used by creating an
instance of BiocParallelParam. In the example case, we are using the snow environment and
specify a SnowParam:

> bp.param <- SnowParam(workers = 1, type = "SOCK")

> bp.param

class: SnowParam

bpisup: FALSE; bpnworkers: 1; bptasks: 0; bpjobname: BPJOB

bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE

bptimeout: 2592000; bpprogressbar: FALSE

bpRNGseed:

bplogdir: NA

bpresultdir: NA

cluster type: SOCK

For using other instances of the BiocParallelParam parameter, please refer to the BiocPar-
allel package vignette. The bp.param parameter can now be passed on to CopywriteR() to
allow parallel computation.

4

CopywriteR: DNA copy number detection from oﬀ-target sequence data.

3.3

CopywriteR()

The CopywriteR() function allows to calculate binned read count data based on the helper
ﬁles created by preCopywriteR(). CopywriteR uses a peak calling algorithm to remove ’on-
target’ reads. For every sample that is to be analyzed by CopywriteR, the user can specify
on which sample the peak regions should be identiﬁed. The argument that controls this is
sample.control. This matrix or data.frame should contain path names to ’samples’ in the
ﬁrst column, and their corresponding ’controls’, in the second column. The peaks called in
a ’control’ are used to remove reads from the corresponding ’sample’. Please note that any
sample that is to be used by the downstream plotCNA function (including those that are only
to be used as a reference) needs to be analyzed by the CopywriteR function.

In the example used here, no matched germline control is available, and peaks are called on
the sample itself. Therefore the paths speciﬁed in the samples and controls columns of the
sample.control data.frame below are identical.

> path <- SCLCBam::getPathBamFolder()

> samples <- list.files(path = path, pattern = ".bam$", full.names = TRUE)

> controls <- samples

> sample.control <- data.frame(samples, controls)

> CopywriteR(sample.control = sample.control,

+

+

+

destination.folder = file.path(data.folder),
reference.folder = file.path(data.folder, "mm10_4_20kb"),
bp.param = bp.param)

The following samples will be analyzed:
sample: T43_4.bam ;
The bin size for this analysis is 20000

matching control: T43_4.bam

The capture region file is not specified

This analysis will be run on 1 cpus
Plotting to file /tmp/RtmpVVIilz/Rbuild418e669d8e17/CopywriteR/vignettes/CNAprofiles/qc/read.counts.compensated.T43_4.bam.png
Total calculation time of CopywriteR was:

52.54659

The destination.folder argument determines in which folder the output folder is going to be
placed, and the reference.folder points to the location of the custom bin size helper ﬁles. The
keep.intermediary.ﬁles is an optional argument that determines whether intermediary .bam,
.bai and peak .bed ﬁles are kept. The default value is FALSE to limit disk space usage; it
can be set to TRUE however for troubleshooting purposes. Finally, the capture.regions.ﬁle
argument is optional, and can be used to deﬁne the location of a capture regions bed ﬁle. If
this ﬁle is speciﬁed, statistics of the overlap of these regions with the called peaks is provided.

CopywriteR will create a new folder named CNAproﬁles in the directory speciﬁed by destina-
tion.folder. This folder contains the following ﬁles:

> cat(list.files(path = file.path(data.folder, "CNAprofiles")), sep = "\n")

CopywriteR.log

input.Rdata
log2_read_counts.igv
qc
read_counts.txt

5

CopywriteR: DNA copy number detection from oﬀ-target sequence data.

The read_counts.txt ﬁle contains both uncompensated and compensated read counts for ev-
ery sample, as well as the corresponding fraction.of.bin values. The ’fraction of bin’ indicates
what fraction of the bin is not on peaks, and therefore eﬀectively contributes to the read
count. In our example, the read_counts.txt has the following content:

> read.table(file = file.path(data.folder, "CNAprofiles", "read_counts.txt"),
+

header = TRUE)[1001:1006, ]

Chromosome

Start

End

Feature

4 20000001 20020000 4:20000001-20020000

4 20020001 20040000 4:20020001-20040000

4 20040001 20060000 4:20040001-20060000

4 20060001 20080000 4:20060001-20080000

4 20080001 20100000 4:20080001-20100000

4 20100001 20120000 4:20100001-20120000
read.counts.compensated.T43_4.bam read.counts.T43_4.bam
52

52

50

41

44

24

50

50

41

44

24

50

fraction.of.bin.T43_4.bam
1

1

1

1

1

1

1001

1002

1003

1004

1005

1006

1001

1002

1003

1004

1005

1006

1001

1002

1003

1004

1005

1006

The log2_read_counts.igv ﬁle can be opened in the IGV browser (http://www.broadinstitute.
org/igv/), and contains log2-transformed, normalized (ratios of) read counts. These data
can be used for further downstream analysis, and are required for plotCNA() to allow plotting
of the copy number proﬁles:

> read.table(file = file.path(data.folder, "CNAprofiles",

+

817

818

819

820

821

822

"log2_read_counts.igv"), header = TRUE)[817:822, ]

Chromosome

Start

End

Feature log2.T43_4.bam
-0.43105895

4 20000001 20020000 4:20000001-20020000

4 20020001 20040000 4:20020001-20040000

0.19585525

4 20040001 20060000 4:20040001-20060000

-0.53023049

4 20060001 20080000 4:20060001-20080000

-0.57540523

4 20080001 20100000 4:20080001-20100000

-0.50525699

4 20100001 20120000 4:20100001-20120000

-0.01782003

The input.Rdata ﬁle contains a number of variables that are required to run the last function
of the CopywriteR package, plotCNA(). The CopywriteR.log ﬁle contains log information of
the R commands that have been used to perform the various subfunctions, and speciﬁcations
of the input material. Finally, the qc folder contains two types of quality control plots.

> cat(list.files(path = file.path(data.folder, "CNAprofiles", "qc")), sep = "\n")

fraction.of.bin.T43_4.bam.pdf

6

CopywriteR: DNA copy number detection from oﬀ-target sequence data.

read.counts.compensated.T43_4.bam.png

The fraction.of.bin ﬁles contain the empirical cumulative distribution function for the ’frac-
tions of bins’. The read.counts.compensated ﬁles contain the plots and the loesses that are
used for GC-content and mappability corrections.

3.4

plotCNA()

The plotCNA() function allows segmentation of the copy number data using DNAcopy [2],
and subsequent plotting. We run the plotting function as follows:

> plotCNA(destination.folder = file.path(data.folder))

Analyzing: log2.T43_4.bam.vs.log2.T43_4.bam
Analyzing: log2.T43_4.bam.vs.none
Total calculation time of CopywriteR was:

2.030465

The plotting function saves the DNAcopy object containing the segmentation values in the
segment.Rdata ﬁle. In addition, it creates the folder ’plots’:

> cat(list.files(path = file.path(data.folder, "CNAprofiles")), sep = "\n")

CopywriteR.log

input.Rdata
log2_read_counts.igv
plots

qc
read_counts.txt
segment.Rdata

For every sample a separate directory is created:

> cat(list.files(path = file.path(data.folder, "CNAprofiles", "plots")), sep = "\n")

log2.T43_4.bam.vs.log2.T43_4.bam
log2.T43_4.bam.vs.none

The samples are plotted per chromosome, as well as in a genome-wide fashion. We provide
here the result for chromosome 4:

7

CopywriteR: DNA copy number detection from oﬀ-target sequence data.

In addition to the plots, the raw segmented values can be obtained from the DNAcopy object
’segment.Rdata’.

We are interested in further improving CopywriteR, so if CopywriteR fails to analyze your
samples, please don’t hesitate to contact me. In this case, please provide the full command
line output and the log-ﬁle.

4

Troubleshooting

We maintain a troubleshooting GitHub page where various issues are discussed that have
been raised by CopywriteR users. Please follow this link: https://github.com/PeeperLab/
CopywriteR#troubleshooting.

8

−2−1012345log2.T43_4.bam.vs.nonelog2 valuemad = 0.45720 kb bins4CopywriteR: DNA copy number detection from oﬀ-target sequence data.

5

Session Information

The version number of R and packages loaded for generating the vignette were:

> toLatex(sessionInfo())

• R version 3.4.2 (2017-09-28), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8,
LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8,
LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Running under: Ubuntu 16.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so

• LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: BiocParallel 1.12.0, CopywriteR 2.10.0

• Loaded via a namespace (and not attached): Biobase 2.38.0, BiocGenerics 0.24.0,

BiocStyle 2.6.0, Biostrings 2.46.0, CopyhelpeR 1.9.0, DNAcopy 1.52.0,
DelayedArray 0.4.0, GenomeInfoDb 1.14.0, GenomeInfoDbData 0.99.1,
GenomicAlignments 1.14.0, GenomicRanges 1.30.0, IRanges 2.12.0, Matrix 1.2-11,
RColorBrewer 1.1-2, RCurl 1.95-4.8, Rcpp 0.12.13, Rsamtools 1.30.0,
S4Vectors 0.16.0, SCLCBam 1.9.0, ShortRead 1.36.0, SummarizedExperiment 1.8.0,
XVector 0.18.0, backports 1.1.1, bitops 1.0-6, chipseq 1.28.0, compiler 3.4.2,
data.table 1.10.4-3, digest 0.6.12, evaluate 0.10.1, futile.logger 1.4.3,
futile.options 1.0.0, grid 3.4.2, gtools 3.5.0, htmltools 0.3.6, hwriter 1.3.2,
knitr 1.17, lambda.r 1.2, lattice 0.20-35, latticeExtra 0.6-28, magrittr 1.5,
matrixStats 0.52.2, parallel 3.4.2, rmarkdown 1.6, rprojroot 1.2, stats4 3.4.2,
stringi 1.1.5, stringr 1.2.0, tools 3.4.2, yaml 2.1.14, zlibbioc 1.24.0

References

[1] Thomas Kuilman, Arno Velds, Kristel Kemper, Marco Ranzani, Lorenzo Bombardelli,
Marlous Hoogstraat, Ekaterina Nevedomskaya, Guotai Xu, Julian de Ruiter, Martijn
Lolkema, Bauke Ylstra, Jos Jonkers, Sven Rottenberg, Lodewyk Wessels, David Adams,
Daniel Peeper, and Oscar Krijgsman. CopywriteR: DNA copy number detection from
oﬀ-target sequence data. Genome Biology, 16(1):49, 2015.

[2] Adam B Olshen, E S Venkatraman, Robert Lucito, and Michael Wigler. Circular binary
segmentation for the analysis of array-based DNA copy number data. Biostatistics,
5(4):557–572, October 2004.

9

