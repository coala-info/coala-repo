Human Fibroblast IMR90 Hi-C Data (Dixon
et al.)

Nicolas Servant

November 4, 2025

1

Introduction

The Hi-C technic was first introduced by Lieberman-Aiden et al. [2009]. In the con-
tinuity with 3C, 4C and 5C technics, the goal of the Hi-C is to simultaneoulsy detect
all chromosomal contacts in a single experiment. All this technics aim at measuring
the population-averaged frequency at which two genomic loci physically interact in
three-dimensional space.
In Hi-C, after a first crosslink and digestion, all genomic
fragments are labeled with a biotinylated nucleotide before ligation. These junctions
can then be purified efficiently by streptavidin-coated magnetic beads, and finaly se-
quenced using a standard Illumina paired-end protocol.
The data available in this package were published by Dixon et al. [2012] and down-
loaded from the GEO website (GSE35156, sample GSM862724). This publication
i) it was the first time
is one of the key paper in the field for two main reasons:
than Hi-C data were generated at such resolution (up to 20kb), ii) this resolution
highlighted a new short range structure defined as topological domains (TADs), with
high frequencies of intra-domain chromatin interactions but infrequent inter-domain
chromatin interactions (Nora et al. [2012]).

If you use HiCDataHumanIMR90, please cite:

• Servant N (2014). HiCDataHumanIMR90: Human Fibroblast IMR90 HiC data

from Dixon et al. 2012. R package version 1.1.0.

• Dixon JR, Selvaraj S, Yue F, Kim A et al.

(2012) Topological domains in
mammalian genomes identified by analysis of chromatin interactions. Nature
485(7398):376-80.

2

Hi-C Data

The hic_imr90_40 object is a HTClist object (see the HiTC package for more in-
formation (Servant et al. [2012])). It contains the complete genome-wide HiC data,
with all inter and intrachromosomic contact maps at a resolution of 40kb.

> require(HiCDataHumanIMR90)

> require(HiTC)
> data(Dixon2012_IMR90)

Human Fibroblast IMR90 Hi-C Data (Dixon et al.)

> ## Show data
> show(hic_imr90_40)

HTClist object of length 325

25 intra / 300 inter-chromosomal maps

> ## Is my data complete (i.e. composed of intra + inter chromosomal maps)
> isComplete(hic_imr90_40)

[1] TRUE

> ## Note that a complete object is not necessarily pairwise

> ## (is both chr1-chr2 and chr2-chr1 stored ?)
> isPairwise(hic_imr90_40)

[1] FALSE

> ## Which chromosomes ?
> seqlevels(hic_imr90_40)

[1] "chr1" "chr2"

"chr3"

"chr4"

"chr5"

"chr6"

"chr7"

"chr8"

"chr9"

[10] "chr10" "chr11" "chr12" "chr13" "chr14" "chr15" "chr16" "chr17" "chr18"

[19] "chr19" "chr20" "chr21" "chr22" "chrX"

"chrY"

"chrM"

> ## Details about a given map
> detail(hic_imr90_40$chrXchrX)

HTC object

Focus on genomic region [chrX:1-155270560]

CIS Interaction Map

Matrix of Interaction data: [3882-3882]

Binned data - window size = 40000

3882 genome intervals

Total Reads =

15349610

Number of Interactions = 3362484

Median Frequency =

1

Sparsity = 0.112

> ## Descriptive statistics
> head(summary(hic_imr90_40))

seq1 seq2 nbreads nbinteraction averagefreq medfreq sparsity

chr1chr1 chr1 chr1 25914788

4524734

chr1chr2 chr1 chr2

504332

chr1chr3 chr1 chr3

440865

chr1chr4 chr1 chr4

456924

chr1chr5 chr1 chr5

399067

chr1chr6 chr1 chr6

382580

497291

434917

450005

393926

377654

5.7274

1.0142

1.0137

1.0154

1.0131

1.013

1

1

1

1

1

1

0.8835

0.9869

0.9859

0.9849

0.986

0.9858

2

Human Fibroblast IMR90 Hi-C Data (Dixon et al.)

3

Topological Domains

The tads_imr90 object is a GRanges object with a all TADs detected from this Hi-C
data.

> show(tads_imr90)

GRanges object with 2338 ranges and 0 metadata columns:

seqnames

<Rle>

ranges strand

<IRanges>

<Rle>

TAD-1

TAD-2

TAD-3

TAD-4

TAD-5

...

TAD-2334

TAD-2335

TAD-2336

TAD-2337

TAD-2338

-------

chr1

chr1

chr1

chr1

chr1

...

770138-1290137

1290138-1850140

1850141-2330140

2330141-3610140

3770141-6077413

...

chrX 146992309-148552096

chrX 148592096-149929342

chrX 149929343-151969344

chrX 152089345-152746806

chrX 152786807-154946806

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

seqinfo: 23 sequences from an unspecified genome; no seqlengths

> ## Extract region
> regx <- extractRegion(hic_imr90_40$chrXchrX,
+

chr="chrX", from=95000000, to=105000000)

> ## Plot Hi-C data with TADs
> plot(regx, tracks=list(tads_imr90), maxrange=20)

3

Human Fibroblast IMR90 Hi-C Data (Dixon et al.)

Package versions

This vignette was generated using the following package versions:

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, stats4, utils

• Other packages: BiocGenerics 0.56.0, GenomicRanges 1.62.0,

HiCDataHumanIMR90 1.30.0, HiTC 1.54.0, IRanges 2.44.0, S4Vectors 0.48.0,
Seqinfo 1.0.0, generics 0.1.4

• Loaded via a namespace (and not attached): Biobase 2.70.0, BiocIO 1.20.0,

BiocManager 1.30.26, BiocParallel 1.44.0, BiocStyle 2.38.0, Biostrings 2.78.0,
DelayedArray 0.36.0, GenomicAlignments 1.46.0, Matrix 1.7-4,
MatrixGenerics 1.22.0, R6 2.6.1, RColorBrewer 1.1-3, RCurl 1.98-1.17,
Rsamtools 2.26.0, S4Arrays 1.10.0, SparseArray 1.10.1,

4

Human Fibroblast IMR90 Hi-C Data (Dixon et al.)

SummarizedExperiment 1.40.0, XML 3.99-0.19, XVector 0.50.0, abind 1.4-8,
bitops 1.0-9, cigarillo 1.0.0, cli 3.6.5, codetools 0.2-20, compiler 4.5.1, crayon 1.5.3,
curl 7.0.0, digest 0.6.37, evaluate 1.0.5, fastmap 1.2.0, grid 4.5.1, htmltools 0.5.8.1,
httr 1.4.7, knitr 1.50, lattice 0.22-7, matrixStats 1.5.0, parallel 4.5.1, restfulr 0.0.16,
rjson 0.2.23, rlang 1.1.6, rmarkdown 2.30, rtracklayer 1.70.0, tools 4.5.1, xfun 0.54,
yaml 2.3.10

5

Human Fibroblast IMR90 Hi-C Data (Dixon et al.)

References

J. R. Dixon, S. Selvaraj, F. Yue, A. Kim, Y. Li, Y. Shen, M. Hu, J. S. Liu, and B. Ren. Topo-
logical domains in mammalian genomes identified by analysis of chromatin interactions. Na-
ture, Apr 2012. doi: 10.1038/nature11082. URL http://dx.doi.org/10.1038/nature11082.

E. Lieberman-Aiden, N. L. van Berkum, L. Williams, M. Imakaev, T. Ragoczy, A. Telling,
I. Amit, B. R. Lajoie, P. J. Sabo, M. O. Dorschner, R. Sandstrom, B. Bernstein, M. A.
Bender, M. Groudine, A. Gnirke, J. Stamatoyannopoulos, L. A. Mirny, E. S. Lander, and
J. Dekker. Comprehensive mapping of long-range interactions reveals folding principles
of the human genome. Science, 326(5950):289–293, Oct 2009. doi: 10.1126/science.
1181369. URL http://dx.doi.org/10.1126/science.1181369.

E. P. Nora, B. R. Lajoie, E. G. Schulz, L. Giorgetti, I. Okamoto, N. Servant, T. Piolot, N. L.
van Berkum, J. Meisig, J. Sedat, J. Gribnau, E. Barillot, N. Bluthgen, J. Dekker, and
E. Heard. Spatial partitioning of the regulatory landscape of the x-inactivation centre. Na-
ture, Apr 2012. doi: 10.1038/nature11049. URL http://dx.doi.org/10.1038/nature11049.

N. Servant, B. R. Lajoie, E. P. Nora, L. Giorgetti, C. Chen, E. Heard, J. Dekker, and E. Baril-
lot. Hitc : Exploration of high-throughput ’c’ experiments. Bioinformatics, Aug 2012. doi:
10.1093/bioinformatics/bts521. URL http://dx.doi.org/10.1093/bioinformatics/bts521.

6

