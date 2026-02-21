FRASER: Find RAre Splicing Events in RNA-
seq Data

Christian Mertes1, Ines Scheller1, Julien Gagneur1

1 Technical University of Munich, Department of Informatics, Garching, Germany

February 12, 2026

Abstract

Genetic variants affecting splicing are a major cause of rare diseases yet their identi-
fication remains challenging. Recently, detecting splicing defects by RNA sequencing
(RNA-seq) has proven to be an effective complementary avenue to genomic variant
interpretation. However, no specialized method exists for the detection of aberrant
splicing events in RNA-seq data. Here, we addressed this issue by developing the sta-
tistical method FRASER (Find RAre Splicing Events in RNA-seq). FRASER detects
splice sites de novo, assesses both alternative splicing and intron retention, automat-
ically controls for latent confounders using a denoising autoencoder, and provides
significance estimates using an over-dispersed count fraction distribution. FRASER
outperforms state-of-the-art approaches on simulated data and on enrichments for
rare near-splice site variants in 48 tissues of the GTEx dataset. Application to a
previously analysed rare disease dataset led to a new diagnostic by reprioritizing an
aberrant exon truncation in TAZ. Altogether, we foresee FRASER as an important
tool for RNA-seq based diagnostics of rare diseases.

If you use FRASER version >= 1.99.0 in published research, please cite:

Scheller I, Lutz K, Mertes C, et al. Improved detection of aberrant splicing with FRASER 2.0
and the Intron Jaccard Index, Am J Hum Genet, 2023,
https:// doi.org/ 10.1016/ j.ajhg.2023.10.014
For previous versions of FRASER, please cite:

Mertes C, Scheller I, Yepez V, et al. Detection of aberrant splicing events
in RNA-seq data using FRASER, Nat Commun, 2021,
https:// doi.org/ 10.1038/ s41467-020-20573-7

Package

FRASER 2.6.1

FRASER: Find RAre Splicing Events in RNA-seq Data

Contents

1

2

3

Introduction .

.

.

.

.

.

.

.

Quick guide to FRASER .

.

.

.

.

.

.

A detailed FRASER analysis .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

3.1

3.2

3.3

3.4

3.5

4.1

4.2

4.3

Data preparation .
3.1.1
3.1.2

.
.
.
.
Creating a FraserDataSet and Counting reads .
Creating a FraserDataSet from existing count matrices .

.
.

.
.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Data preprocessing and QC .
.
3.2.1
.
3.2.2

Filtering .
.
.
Sample co-variation .

.

.

.

.

.
.
.

.
.
.

.
.
.

.
.
.

Detection of aberrant splicing events .
.
.
Fitting the splicing model .
3.3.1
.
.
.
Calling splicing outliers .
3.3.2
.
Interpreting the results table .
3.3.3

.
.

.
.
.

.
.
.
.

Finding splicing candidates in patients .

Saving and loading a FraserDataSet .

.
.
.

.
.
.
.

.

.

.

.
.
.

.
.
.
.

.

.

.

.
.
.

.
.
.
.

.

.

.

.
.
.

.
.
.
.

.

.

.

.

.

4

More details on FRASER .

.

.

.

.

.

.

.

.

Correction for confounders .
4.1.1

.
Finding the dimension of the latent space .

.

.

.

.

.

.

.

.

.

P-value calculation .

Result visualization .

References .

5

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

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.

.
.
.
.

.

.

.

.
.

.

.

.

.

.
.
.

.
.
.
.

.

.

.

.
.

.

.

.

.

.
.
.

.
.
.
.

.

.

.

.
.

.

.

.

.

.
.
.

.
.
.
.

.

.

.

.
.

.

.

.

.

.
.
.

.
.
.
.

.

.

.

.
.

.

.

.

.

.
.
.

.
.
.
.

.

.

.

.
.

.

.

.

.

.
.
.

.
.
.
.

.

.

.

.
.

.

.

.

.

.

.

.

.
.
.

.
.
.

.
.
.
.

.

.

.

.
.

.

.

.

.

3

5

11

12
12
15

18
18
21

22
22
23
24

28

31

32

32
33

34

36

44

45

2

FRASER: Find RAre Splicing Events in RNA-seq Data

1

Introduction

FRASER (Find RAre Splicing Evens in RNA-seq) is a tool for finding aberrant splicing
events in RNA-seq samples. It works on the splice metrics ψ5, ψ3 and θ to be able to
detect any type of aberrant splicing event from exon skipping over alternative donor
usage to intron retention. To detect these aberrant events, FRASER uses a similar
approach as the OUTRIDER package that aims to find aberrantly expressed genes
and makes use of an autoencoder to automatically control for confounders within the
data. FRASER also uses this autoencoder approach and models the read count ratios
in the ψ values by fitting a beta binomial model to the ψ values obtained from RNA-
seq read counts and correcting for apparent co-variations across samples. Similarly
as in OUTRIDER, read counts that significantly deviate from the distribution are
detected as outliers. A scheme of this approach is given in Figure 1.

Figure 1: The FRASER splicing outlier detection workflow. The workflow starts with RNA-seq
aligned reads and performs splicing outlier detection in three steps. First (left column), a splice
site map is generated in an annotation-free fashion based on RNA-seq split reads. Split reads sup-
porting exon-exon junctions as well as non-split reads overlapping splice sites are counted. Splicing
metrics quantifying alternative acceptors ( ψ5), alternative donors (ψ3) and splicing efficiencies at
donors (θ5) and acceptors (θ3) are computed. Second (middle column), a statistical model is fitted
for each splicing metric that controls for sample covariations (latent space fitting using a denoising
autoencoder) and overdispersed count ratios (beta-binomial distribution). Third (right column),
outliers are detected as data points significantly deviating from the fitted models. Candidates are
then visualized with a genome browser.

FRASER uses the following splicing metrics as described by Pervouchine et al[1]: we
compute for each sample, for donor D (5’ splice site) and acceptor A (3’ splice site)
the ψ5 and ψ3 values, respectively, as:

and

ψ5(D, A) =

n(D, A)
A′ n(D, A′)

(cid:80)

ψ3(D, A) =

n(D, A)
D′ n(D′, A)

(cid:80)

,

1

2

where n(D, A) denotes the number of split reads spanning the intron between donor
D and acceptor A and the summands in the denominators are computed over all
acceptors found to splice with the donor of interest (Equation 1 ), and all donors

3

FRASER: Find RAre Splicing Events in RNA-seq Data

found to splice with the acceptor of interest (Equation 2 ). To not only detect
alternative splicing but also partial or full intron retention, we also consider θ as a
splicing efficiency metric.

and

θ5(D) =

θ3(A) =

A′ n(D, A′)

(cid:80)
n(D) + (cid:80)

A′ n(D, A′)

D′ n(D′, A)

(cid:80)
n(A) + (cid:80)

D′ n(D′, A)

,

3

4

where n(D) is the number of non-split reads spanning exon-intron boundary of donor
D, and n(A) is defined as the number of non-split reads spanning the intron-exon
boundary of acceptor A. While we calculate θ for the 5’ and 3’ splice site separately,
we do not distinguish later in the modeling step between θ5 and θ3 and hence call it
jointly θ in the following.

From FRASER 2.0 on, only a single metric - the Intron Jaccard Index (Figure 2)
- is used by default. The Intron Jaccard Index is more robust and allows to focus
It allows to detect all types
more on functionally relevant aberrant splicing events.
of aberrant splicing previously detected using the three metrics (ψ5, ψ3, θ) within a
single metric.

Figure 2: Overview over the Intron Jaccard Index, the splice metric used in FRASER2. The In-
tron Jaccard Index considers both split and nonsplit reads within a single metric and allows to
detect all different types of aberrant splicing previously captured with either of the metrics ψ5, ψ3,
θ.

The Intron Jaccard Index considers both split and nonsplit reads and is defined as the
Jaccard index of the set of donor reads (reads sharing a donor site with the intron of
interest and nonsplit reads at that donor site) and acceptor reads (reads sharing an
acceptor site with the intron of interest and nonsplit reads at that acceptor site):

4

FRASER: Find RAre Splicing Events in RNA-seq Data

J(D, A) =

(cid:80)

A′ n(D, A′) + (cid:80)

D′ n(D′, A) + n(D) + n(A) − n(D, A)

n(D, A)

5

2

Quick guide to FRASER

Here we show how to do an analysis with FRASER, starting from a sample annotation
table and raw data (RNA-seq BAM files). First, we create a FraserDataSet object
from the sample annotation and count the relevant reads in the BAM files. Then,
we compute the ψ/θ values and filter out introns that are lowly expressed. Secondly,
we run the full pipeline using the command FRASER. In the last step, we extract the
results table from the FraserDataSet using the results function. Additionally, the
user can create several analysis plots directly from the fitted FraserDataSet object.
These plotting functions are described in section 4.3.

# load FRASER library

library(FRASER)

# count raw data

fds <- createTestFraserSettings()

fds <- countRNAData(fds)

##

##

##

##

##

##

##

##

##

==========

=====

=====

====

====

==========

_____

__ \|

______
____|

_ ____
| | _ \|
| | |_) | |__) | |__
__|
| |

_____ _
/ ____| |
| (___ | |
\___ \| |
_ /|
| |
____) | |__| | |_) | | \ \| |____ / ____ \| |__| |
\_\_____/
|_____/ \____/|____/|_|

_____
| __ \
| |
| |

\_\______/_/

/ /\ \ | |

_ <|

/\

/

\

Rsubread 2.24.0

## //========================== featureCounts setting ===========================\\

Input files : 1 BAM file

sample1.bam

Paired-end : yes

Count read pairs : yes

Annotation : R data.frame

||

||

||

||

||

||

||

||

Dir for temp files : /tmp/RtmphzhkEC/Rbuild851365d08863e/FRASER/v ... ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

Threads : 1

Level : meta-feature level

Multimapping reads : counted

## || Multi-overlapping reads : counted

## ||

Min overlapping bases : 10

||

||

||

||

||

5

FRASER: Find RAre Splicing Events in RNA-seq Data

## ||

||

## \\============================================================================//

##

## //================================= Running ==================================\\

## ||
## || Load annotation file .Rsubread_UserProvidedAnnotation_pid561963 ...
## ||

Features : 37

## ||

## ||

## ||

Meta-features : 37

Chromosomes/contigs : 2

## || Process BAM file sample1.bam...

## ||

## ||

## ||

## ||

## ||

Paired-end reads are included.

Total alignments : 474

Successfully assigned alignments : 23 (4.9%)

Running time : 0.00 minutes

## || Write the final count table.

## || Write the read assignment summary.

## ||

||

||

||

||

||

||

||

||

||

||

||

||

||

||

||

## \\============================================================================//

##

##

##

##

##

##

##

##

##

==========

=====

=====

====

====

==========

_____

__ \|

______
____|

_ ____
| | _ \|
| | |_) | |__) | |__
__|
| |

_____ _
/ ____| |
| (___ | |
_ /|
\___ \| |
| |
____) | |__| | |_) | | \ \| |____ / ____ \| |__| |
\_\_____/
|_____/ \____/|____/|_|

_____
| __ \
| |
| |

\_\______/_/

/ /\ \ | |

_ <|

/\

/

\

Rsubread 2.24.0

## //========================== featureCounts setting ===========================\\

Input files : 1 BAM file

sample2.bam

Paired-end : yes

Count read pairs : yes

Annotation : R data.frame

||

||

||

||

||

||

||

||

Dir for temp files : /tmp/RtmphzhkEC/Rbuild851365d08863e/FRASER/v ... ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

Threads : 1

Level : meta-feature level

Multimapping reads : counted

## || Multi-overlapping reads : counted

## ||

## ||

Min overlapping bases : 10

||

||

||

||

||

||

6

FRASER: Find RAre Splicing Events in RNA-seq Data

## \\============================================================================//

##

## //================================= Running ==================================\\

## ||
## || Load annotation file .Rsubread_UserProvidedAnnotation_pid561963 ...
## ||

Features : 37

## ||

## ||

## ||

Meta-features : 37

Chromosomes/contigs : 2

## || Process BAM file sample2.bam...

## ||

## ||

## ||

## ||

## ||

Paired-end reads are included.

Total alignments : 2455

Successfully assigned alignments : 39 (1.6%)

Running time : 0.00 minutes

## || Write the final count table.

## || Write the read assignment summary.

## ||

||

||

||

||

||

||

||

||

||

||

||

||

||

||

||

## \\============================================================================//

##

##

##

##

##

##

##

##

##

==========

=====

=====

====

====

==========

_____

__ \|

______
____|

_ ____
| | _ \|
| | |_) | |__) | |__
__|
| |

_____ _
/ ____| |
| (___ | |
\___ \| |
_ /|
| |
____) | |__| | |_) | | \ \| |____ / ____ \| |__| |
\_\_____/
|_____/ \____/|____/|_|

_____
| __ \
| |
| |

\_\______/_/

/ /\ \ | |

_ <|

/\

/

\

Rsubread 2.24.0

## //========================== featureCounts setting ===========================\\

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

## ||

Input files : 1 BAM file

sample3.bam

Paired-end : yes

Count read pairs : yes

Annotation : R data.frame

||

||

||

||

||

||

||

||

Dir for temp files : /tmp/RtmphzhkEC/Rbuild851365d08863e/FRASER/v ... ||

Threads : 1

Level : meta-feature level

Multimapping reads : counted

## || Multi-overlapping reads : counted

## ||

## ||

Min overlapping bases : 10

||

||

||

||

||

||

## \\============================================================================//

7

FRASER: Find RAre Splicing Events in RNA-seq Data

##

## //================================= Running ==================================\\

## ||
## || Load annotation file .Rsubread_UserProvidedAnnotation_pid561963 ...
## ||

Features : 37

## ||

## ||

## ||

Meta-features : 37

Chromosomes/contigs : 2

## || Process BAM file sample3.bam...

## ||

## ||

## ||

## ||

## ||

Paired-end reads are included.

Total alignments : 1918

Successfully assigned alignments : 37 (1.9%)

Running time : 0.00 minutes

## || Write the final count table.

## || Write the read assignment summary.

## ||

||

||

||

||

||

||

||

||

||

||

||

||

||

||

||

## \\============================================================================//

fds

## -------------------- Sample data table -----------------

## # A tibble: 3 x 7

##

##

sampleID bamFile

<chr>

<chr>

condition gene

pairedEnd strand SeqLevelStyle

<int> <chr> <lgl>

<int> <chr>

## 1 sample1

/tmp/RtmphzhkEC/Ri~

## 2 sample2

/tmp/RtmphzhkEC/Ri~

## 3 sample3

/tmp/RtmphzhkEC/Ri~

1 TIMM~ TRUE

3 CLPP

TRUE

2 MCOL~ TRUE

0 UCSC

0 UCSC

0 UCSC

##

## Number of samples:

## Number of junctions:

3

48

## Number of splice sites: 37

## assays(2): rawCountsJ rawCountsSS

##

## ----------------------- Settings -----------------------

## Analysis name:

Data Analysis

## Analysis is strand specific: no

## Working directory:

'FRASER_output'

##

## -------------------- BAM parameters --------------------

## class: ScanBamParam

## bamFlag (NA unless specified):

## bamSimpleCigar: FALSE

## bamReverseComplement: FALSE

## bamTag:

## bamTagFilter:

8

FRASER: Find RAre Splicing Events in RNA-seq Data

## bamWhich: 0 ranges

## bamWhat:

## bamMapqFilter: 0

# compute stats

fds <- calculatePSIValues(fds)

# filter junctions with low expression

fds <- filterExpressionAndVariability(fds, minExpressionInOneSample=20,

minDeltaPsi=0.0, filter=TRUE)

# we provide two ways to annotate introns with the corresponding gene symbols:

# the first way uses TxDb-objects provided by the user as shown here

library(TxDb.Hsapiens.UCSC.hg19.knownGene)

library(org.Hs.eg.db)

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

orgDb <- org.Hs.eg.db

fds <- annotateRangesWithTxDb(fds, txdb=txdb, orgDb=orgDb)

# fit the splicing model for each metric

# with a specific latentspace dimension

fds <- FRASER(fds, q=c(jaccard=2))

# Alternatively, we also provide a way to use BioMart for the annotation:

# fds <- annotateRanges(fds)

# get results: we recommend to use an FDR cutoff of 0.05, but due to the small

# dataset size, we extract all events and their associated values

# eg: res <- results(fds, padjCutoff=0.05, deltaPsiCutoff=0.1)

res <- results(fds, all=TRUE)

res

## GRanges object with 57 ranges and 14 metadata columns:

seqnames

ranges strand |

sampleID

hgncSymbol

<IRanges>

<Rle> | <character> <character>

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

##

##

##

[1]

[2]

[3]

[4]

[5]

...

[53]

[54]

[55]

[56]

[57]

<Rle>

chr19

chr19

chr19

chr19

chr19

...

7590053-7591324

7590053-7591324

7590053-7591324

7591493-7591646

7591493-7591646

...

chr3 119234787-119236051

chr3 119234787-119236051

chr3 119236163-119242452

chr3 119236163-119242452

chr3 119236163-119242452

* |
* |
* |
* |
* |
... .
* |
* |
* |
* |
* |

sample1

sample2

sample3

sample1

sample2

...

sample2

sample3

sample1

sample2

sample3

MCOLN1

MCOLN1

MCOLN1

MCOLN1

MCOLN1

...

TIMMDC1

TIMMDC1

TIMMDC1

TIMMDC1

TIMMDC1

9

FRASER: Find RAre Splicing Events in RNA-seq Data

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

##

type

pValue

padjust

psiValue

deltaPsi

counts

<character> <numeric> <numeric> <numeric> <numeric> <integer>

jaccard

jaccard

jaccard

jaccard

jaccard

1

1

1

1

1

1

1

1

1

1

...

...

...

jaccard

jaccard

jaccard

jaccard

jaccard

1

1

1

1

1

1

1

1

1

1

0.82

0.95

0.83

1.00

1.00

...

0.01

0.01

1.00

0.98

1.00

0.01

0.00

0.01

0.01

0.00

...

0

0

0

0

0

9

20

5

12

21

...

3

4

24

256

264

totalCounts meanCounts meanTotalCounts nonsplitCounts

<numeric>

<numeric>

<numeric>

<numeric>

11

21

6

12

21

...

296

329

24

260

265

11.33

11.33

11.33

12.00

12.00

...

12.67

12.67

181.33

181.33

181.33

12.67

12.67

12.67

12.00

12.00

...

219.33

219.33

183.00

183.00

183.00

2

0

1

0

0

...

0

0

0

3

0

nonsplitProportion nonsplitProportion_99quantile
<numeric>

<numeric>

0.18

0.00

0.17

0.00

0.00

...

0.00

0.00

0.00

0.01

0.00

0.18

0.18

0.18

0.00

0.00

...

0.00

0.00

0.01

0.01

0.01

[1]

[2]

[3]

[4]

[5]

...

[53]

[54]

[55]

[56]

[57]

[1]

[2]

[3]

[4]

[5]

...

[53]

[54]

[55]

[56]

[57]

[1]

[2]

[3]

[4]

[5]

...

[53]

[54]

[55]

[56]

[57]

-------

seqinfo: 2 sequences from an unspecified genome; no seqlengths

# result visualization, aggregate=TRUE means that results are aggregated at the gene level

plotVolcano(fds, sampleID="sample1", type="jaccard", aggregate=TRUE)

10

FRASER: Find RAre Splicing Events in RNA-seq Data

3

A detailed FRASER analysis

The analysis workflow of FRASER for detecting rare aberrant splicing events in RNA-
seq data can be divided into the following steps:

1. Data import or counting reads 3.1

2. Data preprocessing and QC 3.2

3. Correcting for confounders 4.1

4. Calculating P-values 4.2

5. Visualizing the results 4.3

Steps 3 and 4 are wrapped up in one function FRASER, but each step can be called
individually and parametrized. Either way, data preprocessing should be done be-
fore starting the analysis, so that samples failing quality measurements or introns
stemming from background noise are discarded.

Detailed explanations of each step are given in the following subsections.

11

FRASER: Find RAre Splicing Events in RNA-seq Data

For this tutorial, we will use the a small example dataset that is contained in the
package.

3.1

Data preparation

3.1.1 Creating a FraserDataSet and Counting reads

To start an RNA-seq data analysis with FRASER some preparation steps are needed.
The first step is the creation of a FraserDataSet which derives from a RangedSum-
marizedExperiment object. To create the FraserDataSet, sample annotation and two
count matrices are needed: one containing counts for the splice junctions, i.e. the
split read counts, and one containing the splice site counts, i.e. the counts of non
split reads overlapping with the splice sites present in the splice junctions.

You can first create the FraserDataSet with only the sample annotation and subse-
quently count the reads as described in 3.1.1. For this, we need a table with basic
informations which then can be transformed into a FraserSettings object. The mini-
mum of information per sample is a unique sample name and the path to the BAM
If a NA is
file. Additionally groups can be specified for the P-value calculations.
assigned, no P-values will be calculated. An example sample table is given within the
package:

library(data.table)

sampleTable <- fread(system.file(

"extdata", "sampleTable.tsv", package="FRASER", mustWork=TRUE))

head(sampleTable)

##

##

sampleID

<char>

bamFile group

gene pairedEnd

<char> <int>

<char>

<lgcl>

## 1: sample1 extdata/bam/sample1.bam

1 TIMMDC1

## 2: sample2 extdata/bam/sample2.bam

## 3: sample3 extdata/bam/sample3.bam

3

2

CLPP

MCOLN1

TRUE

TRUE

TRUE

To create a settings object for FRASER, the constructor FraserSettings should
be called with at least a sampleData table. For an example have a look into the
createTestFraserSettings. In addition to the sampleData you can specify further
parameters.

1. The parallel backend (a BiocParallelParam object)

2. The read filtering (a ScanBamParam object)

3. An output folder for the resulting figures and the cache

4. If the data is strand specific or not

The following shows how to create a example FraserDataSet with only the settings
options from the sample annotation above:

12

FRASER: Find RAre Splicing Events in RNA-seq Data

# convert it to a bamFile list

bamFiles <- system.file(sampleTable[,bamFile], package="FRASER", mustWork=TRUE)

sampleTable[, bamFile := bamFiles]

# create FRASER object
settings <- FraserDataSet(colData=sampleTable, workingDir="FRASER_output")

# show the FraserSettings object

settings

## -------------------- Sample data table -----------------

## # A tibble: 3 x 5

##

##

sampleID bamFile

<chr>

<chr>

group gene

pairedEnd

<int> <chr> <lgl>

## 1 sample1

/tmp/RtmphzhkEC/Rinst85136626189b7/FRASER/e~

1 TIMM~ TRUE

## 2 sample2

/tmp/RtmphzhkEC/Rinst85136626189b7/FRASER/e~

3 CLPP

TRUE

## 3 sample3

/tmp/RtmphzhkEC/Rinst85136626189b7/FRASER/e~

2 MCOL~ TRUE

##

## ----------------------- Settings -----------------------

## Analysis name:

Data Analysis

## Analysis is strand specific: no

## Working directory:

'FRASER_output'

##

## -------------------- BAM parameters --------------------

## class: ScanBamParam

## bamFlag (NA unless specified):

## bamSimpleCigar: FALSE

## bamReverseComplement: FALSE

## bamTag:

## bamTagFilter:

## bamWhich: 0 ranges

## bamWhat:

## bamMapqFilter: 0

The FraserDataSet for this example data can also be generated through the function
createTestFraserSettings:

settings <- createTestFraserSettings()

settings

## -------------------- Sample data table -----------------

## # A tibble: 3 x 6

##

##

sampleID bamFile

<chr>

<chr>

condition gene

pairedEnd strand

<int> <chr> <lgl>

<int>

## 1 sample1 /tmp/RtmphzhkEC/Rinst85136626189~

## 2 sample2 /tmp/RtmphzhkEC/Rinst85136626189~

1 TIMM~ TRUE

3 CLPP

TRUE

0

0

13

FRASER: Find RAre Splicing Events in RNA-seq Data

## 3 sample3 /tmp/RtmphzhkEC/Rinst85136626189~

2 MCOL~ TRUE

0

##

## ----------------------- Settings -----------------------

## Analysis name:

Data Analysis

## Analysis is strand specific: no

## Working directory:

'FRASER_output'

##

## -------------------- BAM parameters --------------------

## class: ScanBamParam

## bamFlag (NA unless specified):

## bamSimpleCigar: FALSE

## bamReverseComplement: FALSE

## bamTag:

## bamTagFilter:

## bamWhich: 0 ranges

## bamWhat:

## bamMapqFilter: 0

Counting the reads is straightforward and is done through the countRNAData function.
The only required parameter is the FraserSettings object. First, all split reads are
extracted from each individual sample and cached if enabled. Then a dataset-wide
junction map is created (all visible junctions over all samples). After that for each
sample the non-spliced reads at each given donor and acceptor site are counted. The
resulting FraserDataSet object contains two SummarizedExperiment objects, one for
the junctions and one for the splice sites.

# example of how to use parallelization: use 10 cores or the maximal number of

# available cores if fewer than 10 are available and use Snow if on Windows

if(.Platform$OS.type == "unix") {

register(MulticoreParam(workers=min(10, multicoreWorkers())))

} else {

register(SnowParam(workers=min(10, multicoreWorkers())))

}

# count reads

fds <- countRNAData(settings)

fds

## -------------------- Sample data table -----------------

## # A tibble: 3 x 6

##

##

sampleID bamFile

<chr>

<chr>

condition gene

pairedEnd strand

<int> <chr> <lgl>

<int>

## 1 sample1 /tmp/RtmphzhkEC/Rinst85136626189~

## 2 sample2 /tmp/RtmphzhkEC/Rinst85136626189~

## 3 sample3 /tmp/RtmphzhkEC/Rinst85136626189~

1 TIMM~ TRUE

3 CLPP

TRUE

2 MCOL~ TRUE

0

0

0

14

FRASER: Find RAre Splicing Events in RNA-seq Data

##

## Number of samples:

## Number of junctions:

3

48

## Number of splice sites: 37

## assays(2): rawCountsJ rawCountsSS

##

## ----------------------- Settings -----------------------

## Analysis name:

Data Analysis

## Analysis is strand specific: no

## Working directory:

'FRASER_output'

##

## -------------------- BAM parameters --------------------

## class: ScanBamParam

## bamFlag (NA unless specified):

## bamSimpleCigar: FALSE

## bamReverseComplement: FALSE

## bamTag:

## bamTagFilter:

## bamWhich: 0 ranges

## bamWhat:

## bamMapqFilter: 0

3.1.2 Creating a FraserDataSet from existing count matrices

If the count matrices already exist, you can use these matrices directly together with
the sample annotation from above to create the FraserDataSet:

# example sample annotation for precalculated count matrices
sampleTable <- fread(system.file("extdata", "sampleTable_countTable.tsv",

package="FRASER", mustWork=TRUE))

head(sampleTable)

##

##

sampleID

<char>

bamFile group

gene

<char> <int>

<char>

## 1: sample1 extdata/bam/sample1.bam

1 TIMMDC1

## 2: sample2 extdata/bam/sample2.bam

1 TIMMDC1

## 3: sample3 extdata/bam/sample3.bam

## 4: sample4 extdata/bam/sample4.bam

## 5: sample5 extdata/bam/sample5.bam

## 6: sample6 extdata/bam/sample6.bam

2

3

NA

NA

MCOLN1

CLPP

NHDF

NHDF

# get raw counts

junctionCts

<- fread(system.file("extdata", "raw_junction_counts.tsv.gz",

package="FRASER", mustWork=TRUE))

head(junctionCts)

15

FRASER: Find RAre Splicing Events in RNA-seq Data

##

##

seqnames

<char>

start

<int>

end width strand sample1 sample2 sample3 sample4

<int>

<int> <char>

<int>

<int>

<int>

<int>

## 1:

## 2:

## 3:

## 4:

## 5:

## 6:

##

##

## 1:

## 2:

## 3:

## 4:

## 5:

## 6:

chr19 7126380 7690902 564523

chr19 7413458 7615986 202529

chr19 7436801 7703913 267113

chr19 7466307 7607189 140883

chr19 7471938 7607808 135871

chr19 7479042 7625600 146559

*

*

*

*

*

*

0

0

0

0

1

0

1

1

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

sample5 sample6 sample7 sample8 sample9 sample10 sample11 sample12

<int>

<int>

<int>

<int>

<int>

<int>

<int>

<int>

0

0

0

0

0

0

0

0

1

0

0

0

0

0

0

1

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

1

##

##

startID endID

<int> <int>

## 1:

## 2:

## 3:

## 4:

## 5:

## 6:

1

2

3

4

5

6

90

91

92

93

94

95

spliceSiteCts <- fread(system.file("extdata", "raw_site_counts.tsv.gz",

package="FRASER", mustWork=TRUE))

head(spliceSiteCts)

##

##

seqnames

<char>

start

<int>

end width strand spliceSiteID

type sample1 sample2

<int> <int> <char>

<int> <char>

<int>

<int>

## 1:

## 2:

## 3:

## 4:

## 5:

## 6:

##

##

## 1:

## 2:

## 3:

## 4:

## 5:

## 6:

chr19 7126379 7126380

chr19 7413457 7413458

chr19 7436800 7436801

chr19 7466306 7466307

chr19 7471937 7471938

2

2

2

2

2

*

*

*

*

*

1

2

3

4

5

Donor

Donor

Donor

Donor

Donor

0

0

0

0

0

0

0

0

0

0

chr19 7479041 7479042

*
sample3 sample4 sample5 sample6 sample7 sample8 sample9 sample10 sample11

Donor

2

0

0

6

<int>

<int>

<int>

<int>

<int>

<int>

<int>

<int>

<int>

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

0

##

sample12

16

FRASER: Find RAre Splicing Events in RNA-seq Data

##

## 1:

## 2:

## 3:

## 4:

## 5:

## 6:

<int>

0

0

0

0

0

0

# create FRASER object

fds <- FraserDataSet(colData=sampleTable, junctions=junctionCts,

spliceSites=spliceSiteCts, workingDir="FRASER_output")

fds

## -------------------- Sample data table -----------------

## # A tibble: 12 x 4

##

##

sampleID bamFile

<chr>

<chr>

group gene

<int> <chr>

## 1 sample1 extdata/bam/sample1.bam

## 2 sample2 extdata/bam/sample2.bam

1 TIMMDC1

1 TIMMDC1

## 3 sample3 extdata/bam/sample3.bam

2 MCOLN1

## 4 sample4 extdata/bam/sample4.bam

## 5 sample5 extdata/bam/sample5.bam

## 6 sample6 extdata/bam/sample6.bam

## 7 sample7 extdata/bam/sample7.bam

## 8 sample8 extdata/bam/sample8.bam

## 9 sample9 extdata/bam/sample9.bam

## 10 sample10 extdata/bam/sample10.bam

## 11 sample11 extdata/bam/sample11.bam

## 12 sample12 extdata/bam/sample12.bam

3 CLPP

NA NHDF

NA NHDF

NA NHDF

NA NHDF

NA NHDF

NA NHDF

NA NHDF

NA NHDF

##

## Number of samples:

## Number of junctions:

12

123

## Number of splice sites: 165

## assays(2): rawCountsJ rawCountsSS

##

## ----------------------- Settings -----------------------

## Analysis name:

Data Analysis

## Analysis is strand specific: no

## Working directory:

'FRASER_output'

##

## -------------------- BAM parameters --------------------

## class: ScanBamParam

## bamFlag (NA unless specified):

## bamSimpleCigar: FALSE

## bamReverseComplement: FALSE

## bamTag:

17

FRASER: Find RAre Splicing Events in RNA-seq Data

## bamTagFilter:

## bamWhich: 0 ranges

## bamWhat:

## bamMapqFilter: 0

3.2

Data preprocessing and QC
As with gene expression analysis, a good quality control of the raw data is crucial.
For some hints please refere to our workshop slides1.

At the time of writing this vignette, we recommend that the RNA-seq data should be
aligned with a splice-aware aligner like STAR[2] or GEM[3]. To obtain better results,
at least 50 samples should be sequenced and they should be processed with the same
protocol and originated from the same tissue.

3.2.1

Filtering

Before filtering the data, we have to compute the main splicing metrics: the ψ-value
(Percent Spliced In) and the Intron Jaccard Index.

fds <- calculatePSIValues(fds)

fds

## -------------------- Sample data table -----------------

## # A tibble: 12 x 4

##

##

sampleID bamFile

<chr>

<chr>

group gene

<int> <chr>

## 1 sample1 extdata/bam/sample1.bam

## 2 sample2 extdata/bam/sample2.bam

1 TIMMDC1

1 TIMMDC1

## 3 sample3 extdata/bam/sample3.bam

2 MCOLN1

## 4 sample4 extdata/bam/sample4.bam

## 5 sample5 extdata/bam/sample5.bam

## 6 sample6 extdata/bam/sample6.bam

## 7 sample7 extdata/bam/sample7.bam

## 8 sample8 extdata/bam/sample8.bam

## 9 sample9 extdata/bam/sample9.bam

## 10 sample10 extdata/bam/sample10.bam

## 11 sample11 extdata/bam/sample11.bam

## 12 sample12 extdata/bam/sample12.bam

3 CLPP

NA NHDF

NA NHDF

NA NHDF

NA NHDF

NA NHDF

NA NHDF

NA NHDF

NA NHDF

##

## Number of samples:

## Number of junctions:

12

123

## Number of splice sites: 165
## assays(15): rawCountsJ psi5 ... rawOtherCounts_theta delta_theta

1http://tinyurl.com/RNA-ASHG-presentation

18

FRASER: Find RAre Splicing Events in RNA-seq Data

##

## ----------------------- Settings -----------------------

## Analysis name:

Data Analysis

## Analysis is strand specific: no

## Working directory:

'FRASER_output'

##

## -------------------- BAM parameters --------------------

## class: ScanBamParam

## bamFlag (NA unless specified):

## bamSimpleCigar: FALSE

## bamReverseComplement: FALSE

## bamTag:

## bamTagFilter:

## bamWhich: 0 ranges

## bamWhat:

## bamMapqFilter: 0

Now we can filter down the number of junctions we want to test later on.

Currently, we suggest keeping only junctions which support the following:

• At least one sample has 20 (or more) reads

• 25% (or more) of the samples have at least 10 reads

Furthemore one could filter for:

• At least one sample has a |∆ψ| of 0.1

fds <- filterExpressionAndVariability(fds, minDeltaPsi=0, filter=FALSE)

plotFilterExpression(fds, bins=100)

19

FRASER: Find RAre Splicing Events in RNA-seq Data

After looking at the expression distribution between filtered and unfiltered junctions,
we can now subset the dataset:

fds_filtered <- fds[mcols(fds, type="j")[,"passed"]]
fds_filtered

## -------------------- Sample data table -----------------

## # A tibble: 12 x 4

##

##

sampleID bamFile

<chr>

<chr>

group gene

<int> <chr>

## 1 sample1

extdata/bam/sample1.bam

## 2 sample2

extdata/bam/sample2.bam

1 TIMMDC1

1 TIMMDC1

## 3 sample3

extdata/bam/sample3.bam

2 MCOLN1

## 4 sample4

extdata/bam/sample4.bam

## 5 sample5

extdata/bam/sample5.bam

## 6 sample6

extdata/bam/sample6.bam

## 7 sample7

extdata/bam/sample7.bam

## 8 sample8

extdata/bam/sample8.bam

## 9 sample9

extdata/bam/sample9.bam

## 10 sample10 extdata/bam/sample10.bam

3 CLPP

NA NHDF

NA NHDF

NA NHDF

NA NHDF

NA NHDF

NA NHDF

20

FRASER: Find RAre Splicing Events in RNA-seq Data

## 11 sample11 extdata/bam/sample11.bam

## 12 sample12 extdata/bam/sample12.bam

NA NHDF

NA NHDF

##

## Number of samples:

## Number of junctions:

12

20

## Number of splice sites: 38
## assays(15): rawCountsJ psi5 ... rawOtherCounts_theta delta_theta
##

## ----------------------- Settings -----------------------

## Analysis name:

Data Analysis

## Analysis is strand specific: no

## Working directory:

'FRASER_output'

##

## -------------------- BAM parameters --------------------

## class: ScanBamParam

## bamFlag (NA unless specified):

## bamSimpleCigar: FALSE

## bamReverseComplement: FALSE

## bamTag:

## bamTagFilter:

## bamWhich: 0 ranges

## bamWhat:

## bamMapqFilter: 0

# filtered_fds not further used for this tutorial because the example dataset
# is otherwise too small

3.2.2 Sample co-variation

Since ψ values are ratios within a sample, one might think that there should not be
as much correlation structure as observed in gene expression data within the splicing
data.

However, we do see strong sample co-variation across different tissues and cohorts.
Let’s have a look into our demo data to see if we it has correlation structure or not.
To have a better estimate, we use the logit transformed ψ values to compute the
correlation.

# Heatmap of the sample correlation

plotCountCorHeatmap(fds, type="jaccard", logit=TRUE, normalized=FALSE)

21

FRASER: Find RAre Splicing Events in RNA-seq Data

It is also possible to visualize the correlation structure of the logit transformed ψ
values of the topJ most variable introns for all samples:

# Heatmap of the intron/sample expression

plotCountCorHeatmap(fds, type="jaccard", logit=TRUE, normalized=FALSE,

plotType="junctionSample", topJ=100, minDeltaPsi = 0.01)

3.3

Detection of aberrant splicing events
After preprocessing the raw data and visualizing it, we can start with our analysis.
Let’s start with the first step in the aberrant splicing detection: the model fitting.

3.3.1

Fitting the splicing model

During the fitting procedure, we will normalize the data and correct for confounding
effects by using a denoising autoencoder. Here we use a predefined latent space
with a dimension q = 10 . Using the correct dimension is crucial to have the best

22

FRASER: Find RAre Splicing Events in RNA-seq Data

performance (see 4.1.1). Alternatively, one can also use a PCA to correct the data.
The wrapper function FRASER both fits the model and calculates the p-values for all
ψ types. For more details see section 4.

# This is computational heavy on real datasets and can take some hours

fds <- FRASER(fds, q=c(jaccard=3))

To check whether the correction worked, we can have a look at the correlation
heatmap using the normalized ψ values from the fit.

plotCountCorHeatmap(fds, type="jaccard", normalized=TRUE, logit=TRUE)

3.3.2 Calling splicing outliers

Before we extract the results, we should add HGNC symbols to the junctions. FRASER
comes already with an annotation function. The function uses biomaRt in the back-
ground to overlap the genomic ranges with the known HGNC symbols. To have more
flexibilty on the annotation, one can also provide a custom ‘txdb‘ object to annotate
the HGNC symbols.

23

FRASER: Find RAre Splicing Events in RNA-seq Data

Here we assume a beta binomial distribution and call outliers based on the significance
level. The user can choose between a p value cutoff, a cutoff on the ∆ψ values
between the observed and expected ψ values or both.

# annotate introns with the HGNC symbols of the corresponding gene

library(TxDb.Hsapiens.UCSC.hg19.knownGene)

library(org.Hs.eg.db)

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

orgDb <- org.Hs.eg.db

fds <- annotateRangesWithTxDb(fds, txdb=txdb, orgDb=orgDb)

# fds <- annotateRanges(fds) # alternative way using biomaRt

# retrieve results with default and recommended cutoffs (padj <= 0.05 and

# |deltaPsi| >= 0.3)

res <- results(fds)

3.3.3

Interpreting the results table

The function results retrieves significant events based on the specified cutoffs as a
GRanges object which contains the genomic location of the splice junction or splice
site that was found as aberrant and the following additional information:

• sampleID: the sampleID in which this aberrant event occurred

• hgncSymbol: the gene symbol of the gene that contains the splice junction or

site, if available

• type: the metric for which the aberrant event was detected (either jaccard for

Intron Jaccard Index or psi5 for ψ5, psi3 for ψ3 or theta for θ)

• pValue, padjust: the p-value and adjusted p-value (FDR) of this event (at

intron or splice site level depending on metric)

• pValueGene, padjustGene: only present in the gene-level results table, gives

the p-value and FDR adjusted p-value at gene-level

• psiValue: the value of the splice metric (see ’type’ column for the name of the
metric) of this junction or splice site for the sample in which it is detected as
aberrant

• deltaPsi: the ∆ψ-value of the event in this sample, which is the difference

between the actual observed ψ and the expected ψ

• counts, totalCounts: the count (k) and total count (n) of the splice junction

or site for the sample where it is detected as aberrant

• meanCounts: the mean count (k) of reads mapping to this splice junction or

site over all samples

24

FRASER: Find RAre Splicing Events in RNA-seq Data

• meanTotalCounts: the mean total count (n) of reads mapping to the same

donor or acceptor site as this junction or site over all samples

• nonsplitCounts, nonsplitProportion: only present for the Intron Jaccard Index.
States the sum of nonsplit counts overlapping either the donor or acceptor site
of the outlier intron for the sample where it is detected as aberrant; and their
proportion out of the total counts (N). A high nonsplitProportion indicates
possible (partial) intron retention.

• FDR_set The set of genes on which FDR correction is applied. If not otherwise

specified, FDR correction is transcriptome-wide.

Please refer to section 1 for more information about the Intron Jaccard Index metric
(or the previous metrics ψ5, ψ3 and θ) and their definition. In general, an aberrant
ψ5 value might indicate aberrant acceptor site usage of the junction where the event
is detected; an aberrant ψ3 value might indicate aberrant donor site usage of the
junction where the event is detected; and an aberrant θ value might indicate partial
or full intron retention, or exon truncation or elongation. As the Intron Jaccard Index
combines the three metrics, an aberrant Intron Jaccard value can indicate any of the
above described cases. We recommend inspecting the outliers using IGV. FRASER2
also provides the function plotBamCoverageFromResultTable to create a sashimi plot
for an outlier in the results table directly in R (if paths to bam files are available in
the FraserDataSet object).

# for visualization purposes for this tutorial, no cutoffs were used

res <- results(fds, all=TRUE)

res

## GRanges object with 1476 ranges and 14 metadata columns:

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

<Rle>

chr19

ranges strand |

sampleID

hgncSymbol

<IRanges>

<Rle> | <character> <character>

[1]

[2]

[3]

[4]

[5]

...

[1472]

[1473]

[1474]

[1475]

[1476]

7592515-7592749

chr3 119217436-119219541

chr3 119236163-119242452

chr3 119217567-119217621

chr3 119222869-119236051

...

chr19

chr19

chr19

chr19

chr19

...

7703987-7704616

7703987-7704616

7703987-7704616

7703987-7704616

7703987-7704616

* |
* |
* |
* |
* |
... .
* |
* |
* |
* |
* |

sample3

sample9

sample11

sample7

sample7

...

sample5

sample6

sample7

sample8

sample9

type

pValue

padjust

psiValue

deltaPsi

MCOLN1

TIMMDC1

TIMMDC1

TIMMDC1

TIMMDC1

...

STXBP2

STXBP2

STXBP2

STXBP2

STXBP2

counts

<character> <numeric> <numeric> <numeric> <numeric> <integer>

[1]

[2]

[3]

[4]

jaccard 0.010087

jaccard 0.012551

jaccard 0.015124

jaccard 0.022096

1

1

1

1

0.14

0.04

0.98

0.01

-0.45

0.03

-0.02

0.01

3

12

570

4

25

FRASER: Find RAre Splicing Events in RNA-seq Data

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

##

##

##

##

##

jaccard 0.026414

...

...

jaccard

jaccard

jaccard

jaccard

jaccard

1

1

1

1

1

1

...

1

1

1

1

1

0.01

...

NaN

1

NaN

NaN

NaN

0.01

...

NaN

0.26

NaN

NaN

NaN

4

...

0

1

0

0

0

totalCounts meanCounts meanTotalCounts nonsplitCounts

<numeric>

<numeric>

<numeric>

<numeric>

22

303

581

337

533

...

0

1

0

0

0

92.50

4.83

363.00

0.33

1.00

...

0.08

0.08

0.08

0.08

0.08

103.08

364.92

366.42

421.08

591.75

...

0.08

0.08

0.08

0.08

0.08

19

64

8

333

1

...

0

0

0

0

0

nonsplitProportion nonsplitProportion_99quantile
<numeric>

<numeric>

0.86

0.21

0.01

0.99

0.00

...

NaN

0

NaN

NaN

NaN

0.79

0.33

0.02

1.00

0.01

...

NA

NA

NA

NA

NA

[5]

...

[1472]

[1473]

[1474]

[1475]

[1476]

[1]

[2]

[3]

[4]

[5]

...

[1472]

[1473]

[1474]

[1475]

[1476]

[1]

[2]

[3]

[4]

[5]

...

[1472]

[1473]

[1474]

[1475]

[1476]

-------

seqinfo: 2 sequences from an unspecified genome; no seqlengths

# for the gene level pvalues, gene symbols need to be added to the fds object

# before calling the calculatePadjValues function (part of FRASER() function)

# as we previously called FRASER() before annotating genes, we run it again here

fds <- calculatePadjValues(fds, type="jaccard", geneLevel=TRUE)

# generate gene-level results table (if gene symbols have been annotated)
res_gene <- results(fds, aggregate=TRUE, all=TRUE)
res_gene

## GRanges object with 540 ranges and 16 metadata columns:

##

seqnames

ranges strand |

sampleID

hgncSymbol

26

FRASER: Find RAre Splicing Events in RNA-seq Data

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

##

##

##

##

##

[1]

[2]

[3]

[4]

[5]

...

[536]

[537]

[538]

[539]

[540]

[1]

[2]

[3]

[4]

[5]

...

[536]

[537]

[538]

[539]

[540]

[1]

[2]

[3]

[4]

[5]

...

[536]

[537]

[538]

[539]

[540]

[1]

[2]

[3]

[4]

[5]

<IRanges>

<Rle> | <character> <character>

<Rle>

chr19

7592515-7592749

chr3 119217436-119219541

chr3 119236163-119242452

chr3 119217567-119217621

chr19

...

chr19

chr19

chr19

chr19

chr19

7590053-7591324

...

7585706-7855730

7585706-7855730

7585706-7855730

7598540-7598644

7598540-7598644

* |
* |
* |
* |
* |
... .
* |
* |
* |
* |
* |

sample3

sample9

sample11

sample7

sample4

...

sample12

sample12

sample12

sample5

sample7

MCOLN1

TIMMDC1

TIMMDC1

TIMMDC1

MCOLN1

...

TRAPPC5

XAB2

ZNF358

PNPLA6

PNPLA6

counts

type

pValue

padjust

psiValue

deltaPsi

<character> <numeric> <numeric> <numeric> <numeric> <integer>

jaccard

0.010087

jaccard

0.012551

jaccard

0.015124

jaccard

0.022096

jaccard

0.029790

1

1

1

1

1

...

...

...

jaccard

jaccard

jaccard

jaccard

jaccard

1

1

1

1

1

1

1

1

1

1

0.14

0.04

0.98

0.01

0.95

...

1

1

1

1

1

-0.45

0.03

-0.02

0.01

0.13

...

0.45

0.45

0.45

0.01

0.01

3

12

570

4

63

...

1

1

1

7

22

totalCounts meanCounts meanTotalCounts nonsplitCounts

<numeric>

<numeric>

<numeric>

<numeric>

22

303

581

337

66

...

1

1

1

7

22

92.50

4.83

363.00

0.33

96.75

...

0.08

0.08

0.08

41.33

41.33

103.08

364.92

366.42

421.08

99.58

...

0.25

0.25

0.25

42.42

42.42

19

64

8

333

0

...

0

0

0

0

0

nonsplitProportion nonsplitProportion_99quantile pValueGene
<numeric>

<numeric>

<numeric>

0.86

0.21

0.01

0.99

0.00

0.79

0.33

0.02

1.00

0.07

0.55480

0.71538

0.86207

1.00000

1.00000

27

FRASER: Find RAre Splicing Events in RNA-seq Data

...

0

0

0

0

0

padjustGene

<numeric>

...

NA

NA

NA

0.08

0.08

...

1

1

1

1

1

...

[536]

[537]

[538]

[539]

[540]

[1]

[2]

[3]

[4]

[5]

...

[536]

[537]

[538]

[539]

[540]

-------

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

##

1

1

1

1

1

...

1

1

1

1

1

seqinfo: 2 sequences from an unspecified genome; no seqlengths

3.4

Finding splicing candidates in patients
Let’s have a look at sample 10 and check if we got some splicing candidates for this
sample.

plotVolcano(fds, type="jaccard", "sample10")

28

FRASER: Find RAre Splicing Events in RNA-seq Data

Which are the splicing events in detail?

sampleRes <- res[res$sampleID == "sample10"]

sampleRes

## GRanges object with 123 ranges and 14 metadata columns:

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

##

##

##

##

##

seqnames

<Rle>

ranges strand |

sampleID

hgncSymbol

<IRanges>

<Rle> | <character> <character>

[1]

[2]

[3]

[4]

[5]

...

[119]

[120]

[121]

[122]

[123]

chr3 119217438-119219541

chr3 119234787-119236051

chr19

chr19

chr19

...

chr19

chr19

chr19

chr19

chr19

7594599-7595320

7593590-7593706

7593144-7593482

...

7615994-7616247

7616324-7618757

7625651-7625899

7690931-7691021

7703987-7704616

* |
* |
* |
* |
* |
... .
* |
* |
* |
* |
* |

sample10

sample10

sample10

sample10

sample10

...

sample10

sample10

sample10

sample10

sample10

type

pValue

padjust

psiValue

deltaPsi

TIMMDC1

TIMMDC1

MCOLN1

MCOLN1

MCOLN1

...

PNPLA6

PNPLA6

PNPLA6

XAB2

STXBP2

counts

<character> <numeric> <numeric> <numeric> <numeric> <integer>

29

FRASER: Find RAre Splicing Events in RNA-seq Data

jaccard

0.039124

jaccard

0.113040

jaccard

0.198770

jaccard

0.208480

jaccard

0.261590

1

1

1

1

1

...

...

...

jaccard

jaccard

jaccard

jaccard

jaccard

1

1

1

1

1

1

1

1

1

1

0.02

0.01

0.06

0.92

0.98

...

NaN

NaN

NaN

NaN

NaN

-0.03

0.01

0.02

-0.04

-0.01

...

NaN

NaN

NaN

NaN

NaN

9

4

14

101

145

...

0

0

0

0

0

totalCounts meanCounts meanTotalCounts nonsplitCounts

<numeric> <numeric>

<numeric>

<numeric>

478

420

250

110

148

...

0

0

0

0

0

3.67

10.50

4.92

70.58

93.58

...

0.08

0.08

0.25

0.08

0.08

367.67

306.17

146.75

78.83

97.25

...

0.08

0.08

0.25

0.08

0.08

135

0

112

8

2

...

0

0

0

0

0

nonsplitProportion nonsplitProportion_99quantile
<numeric>

<numeric>

0.28

0.00

0.45

0.07

0.01

...

NaN

NaN

NaN

NaN

NaN

0.33

0.01

0.52

0.16

0.17

...

NA

NA

NA

NA

NA

[1]

[2]

[3]

[4]

[5]

...

[119]

[120]

[121]

[122]

[123]

[1]

[2]

[3]

[4]

[5]

...

[119]

[120]

[121]

[122]

[123]

[1]

[2]

[3]

[4]

[5]

...

[119]

[120]

[121]

[122]

[123]

-------

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

##

##

##

##

##

##

##

##

##

seqinfo: 2 sequences from an unspecified genome; no seqlengths

To have a closer look at the junction level, use the following functions:

plotExpression(fds, type="jaccard", result=sampleRes[9]) # plots the 9th row

plotSpliceMetricRank(fds, type="jaccard", result=sampleRes[9])

plotExpectedVsObservedPsi(fds, result=sampleRes[9])

30

FRASER: Find RAre Splicing Events in RNA-seq Data

3.5

Saving and loading a FraserDataSet
A FraserDataSet object can be easily saved and reloaded as follows:

# saving a fds
workingDir(fds) <- "FRASER_output"
name(fds) <- "ExampleAnalysis"

saveFraserDataSet(fds, dir=workingDir(fds), name=name(fds))

## -------------------- Sample data table -----------------

## # A tibble: 12 x 4

##

##

sampleID bamFile

<chr>

<chr>

group gene

<int> <chr>

## 1 sample1 extdata/bam/sample1.bam

## 2 sample2 extdata/bam/sample2.bam

1 TIMMDC1

1 TIMMDC1

## 3 sample3 extdata/bam/sample3.bam

2 MCOLN1

## 4 sample4 extdata/bam/sample4.bam

## 5 sample5 extdata/bam/sample5.bam

## 6 sample6 extdata/bam/sample6.bam

## 7 sample7 extdata/bam/sample7.bam

## 8 sample8 extdata/bam/sample8.bam

## 9 sample9 extdata/bam/sample9.bam

## 10 sample10 extdata/bam/sample10.bam

## 11 sample11 extdata/bam/sample11.bam

## 12 sample12 extdata/bam/sample12.bam

3 CLPP

NA NHDF

NA NHDF

NA NHDF

NA NHDF

NA NHDF

NA NHDF

NA NHDF

NA NHDF

##

## Number of samples:

## Number of junctions:

12

123

## Number of splice sites: 165
## assays(19): rawCountsJ psi5 ... rawOtherCounts_theta delta_theta
##

## ----------------------- Settings -----------------------

## Analysis name:

ExampleAnalysis

## Analysis is strand specific: no

## Working directory:

'FRASER_output'

##

## -------------------- BAM parameters --------------------

## class: ScanBamParam

## bamFlag (NA unless specified):

## bamSimpleCigar: FALSE

## bamReverseComplement: FALSE

## bamTag:

## bamTagFilter:

## bamWhich: 0 ranges

## bamWhat:

## bamMapqFilter: 0

31

FRASER: Find RAre Splicing Events in RNA-seq Data

# two ways of loading a fds by either specifying the directory and anaysis name

# or directly giving the path the to fds-object.RDS file

fds <- loadFraserDataSet(dir=workingDir(fds), name=name(fds))

fds <- loadFraserDataSet(file=file.path(workingDir(fds),

"savedObjects", "ExampleAnalysis", "fds-object.RDS"))

4

More details on FRASER

The function FRASER is a convenient wrapper function that takes care of correcting
for confounders, fitting the beta binomial distribution and calculating p-values for all
ψ types. To have more control over the individual steps, the different functions can
also be called separately. The following sections give a short explanation of these
steps.

4.1

Correction for confounders
The wrapper function FRASER and the underlying function fit method offer different
methods to automatically control for confounders in the data. Currently the following
methods are implemented:

• AE: uses a beta-binomial AE

• PCA-BB-Decoder: uses a beta-binomial AE where PCA is used to find the

latent space (encoder) due to speed reasons

• PCA: uses PCA for both the encoder and the decoder

• BB: no correction for confounders, fits a beta binomial distribution directly on

the raw counts

# Using an alternative way to correct splicing ratios

# here: only 2 iterations to speed the calculation up for the vignette

# the default is 15 iterations

fds <- fit(fds, q=3, type="jaccard", implementation="PCA-BB-Decoder",

iterations=2)

##

## TRUE

## 123

## [1] "Finished with fitting the E matrix. Starting now with the D fit. ..."
## [1] "Thu Feb 12 18:13:42 2026: Iteration: final_1 loss: 0.76303431721815 (mean); 4.89911773621943 (max)"
## [1] "Thu Feb 12 18:13:43 2026: Iteration: final_2 loss: 0.861892159605605 (mean); 4.01355366698777 (max)"
## [1] "2 Final betabin-AE loss: 0.861892159605605"

32

FRASER: Find RAre Splicing Events in RNA-seq Data

4.1.1

Finding the dimension of the latent space

For the previous call, the dimension q of the latent space has been fixed. Since
working with the correct q is very important, the FRASER package also provides the
function estimateBestQ that can be used to estimate the dimension q of the latent
space of the data. Per default, it uses the deterministic Optimal Hard Thresholding
(OHT) method established by Gavish and Donoho[4]. Alternatively, a hyperparameter
optimization can be performed that works by artificially injecting outliers into the data
and then comparing the AUC of recalling these outliers for different values of q. Since
this hyperparameter optimization step is quite CPU-intensive, we only show it here
for a subset of the dataset and recommend to use the faster OHT approach. The
results from the estimation of the optimal latent space dimension can be visualized
with the function plotEncDimSearch.

set.seed(42)

# Optimal Hard Thresholding (default method)

fds <- estimateBestQ(fds, type="jaccard", plot=FALSE)

## Optimal encoding dimension: 1

plotEncDimSearch(fds, type="jaccard", plotType="sv")

33

FRASER: Find RAre Splicing Events in RNA-seq Data

# Hyperparameter optimization (grid-search)

fds <- estimateBestQ(fds, type="jaccard", useOHT=FALSE, plot=FALSE)

plotEncDimSearch(fds, type="jaccard", plotType="auc")

# retrieve the estimated optimal dimension of the latent space

bestQ(fds, type="jaccard")

## [1] 2

4.2

P-value calculation
After determining the fit parameters, two-sided beta binomial P-values are computed
using the following equation:

pij = 2 · min






1
2

,

kij
(cid:88)

0

BB(kij, nij, µij, ρi), 1 −

kij−1
(cid:88)

0

BB(kij, nij, µij, ρi)






,

6

34

FRASER: Find RAre Splicing Events in RNA-seq Data

where the 1
term handles the case of both terms exceeding 0.5, which can happen
2
due to the discrete nature of counts. Here µij are computed as the product of the
fitted correction values from the autoencoder and the fitted mean adjustements.

fds <- calculatePvalues(fds, type="jaccard")

head(pVals(fds, type="jaccard"))

##

sample1 sample2 sample3 sample4 sample5 sample6 sample7 sample8 sample9

## 1

## 2

## 3

## 4

## 5

## 6

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

##

sample10 sample11 sample12

## 1

## 2

## 3

## 4

## 5

## 6

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

Afterwards, adjusted p-values can be calculated. Multiple testing correction is done
across all junctions in a per-sample fashion using Benjamini-Yekutieli’s false discovery
rate method[5]. Alternatively, all adjustment methods supported by p.adjust can be
used via the method argument.

fds <- calculatePadjValues(fds, type="jaccard", method="BY")

head(padjVals(fds,type="jaccard"))

##

sample1 sample2 sample3 sample4 sample5 sample6 sample7 sample8 sample9

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

## 1

## 2

## 3

## 4

## 5

## 6

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

##

sample10 sample11 sample12

## 1

## 2

## 3

## 4

## 5

## 6

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

1

35

FRASER: Find RAre Splicing Events in RNA-seq Data

With FRASER 2.0 we introduce the option to limit FDR correction to a subset of
genes based on prior knowledge, e.g. genes that contain a rare variant per sample.
To use this option, provide a list of genes per sample during FDR computation:

genesOfInterest <- list("sample1"=c("XAB2", "PNPLA6", "STXBP2", "ARHGEF18"),

"sample2"=c("ARHGEF18", "TRAPPC5"))

fds <- calculatePadjValues(fds, type="jaccard",

subsets=list("exampleSubset"=genesOfInterest))

head(padjVals(fds, type="jaccard", subsetName="exampleSubset"))

##

sample1 sample2 sample3 sample4 sample5 sample6 sample7 sample8 sample9

## 1

## 2

## 3

## 4

## 5

## 6

1

1

1

1

1

1

1

1

1

1

1

1

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

##

sample10 sample11 sample12

## 1

## 2

## 3

## 4

## 5

## 6

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

4.3

Result visualization
Besides the plotting methods plotVolcano, plotExpression, plotExpectedVsObservedPsi,
plotSpliceMetricRank, plotFilterExpression and plotEncDimSearch used above,
the FRASER package provides additional functions to visualize the results:

plotAberrantPerSample displays the number of aberrant events per sample of the
whole cohort based on the given cutoff values and plotQQ gives a quantile-quantile
plot either for a single junction/splice site or globally.

plotAberrantPerSample(fds)

36

FRASER: Find RAre Splicing Events in RNA-seq Data

# qq-plot for single junction

plotQQ(fds, result=res[1])

37

FRASER: Find RAre Splicing Events in RNA-seq Data

# global qq-plot (on gene level since aggregate=TRUE)

plotQQ(fds, aggregate=TRUE, global=TRUE)

38

FRASER: Find RAre Splicing Events in RNA-seq Data

The plotManhattan function can be used to visualize the p-values along with the
genomic coordinates of the introns:

plotManhattan(fds, sampleID="sample10")

39

FRASER: Find RAre Splicing Events in RNA-seq Data

plotManhattan(fds, sampleID="sample10", chr="chr19")

40

FRASER: Find RAre Splicing Events in RNA-seq Data

Finally, when one has access to the bam files from which the split and unsplit counts
of FRASER were created, the plotBamCoverage and plotBamCoverageFromResult
Table functions use the SGSeq package to allow visualizing the read coverage in the
bam file a certain intron from the results table or within a given genomic region as a
sashimi plot:

### plot coverage from bam file for a certain genomic region

fds <- createTestFraserSettings()

vizRange <- GRanges(seqnames="chr19",

IRanges(start=7587496, end=7598895),

strand="+")

plotBamCoverage(fds, gr=vizRange, sampleID="sample3",

control_samples="sample2", min_junction_count=5,
curvature_splicegraph=1, curvature_coverage=1,
mar=c(1, 7, 0.1, 3))

41

FRASER: Find RAre Splicing Events in RNA-seq Data

### plot coverage from bam file for a row in the result table

fds <- createTestFraserDataSet()

# load gene annotation

require(TxDb.Hsapiens.UCSC.hg19.knownGene)

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

require(org.Hs.eg.db)

orgDb <- org.Hs.eg.db

# get results table

res <- results(fds, padjCutoff=NA, deltaPsiCutoff=NA)
res_dt <- as.data.table(res)
res_dt <- res_dt[sampleID == "sample2",]

# plot full range of gene highlighting the outlier intron
plotBamCoverageFromResultTable(fds, result=res_dt[1,], show_full_gene=TRUE,

txdb=txdb, orgDb=orgDb, control_samples="sample3")

42

FRASER: Find RAre Splicing Events in RNA-seq Data

# plot only certain range around the outlier intron
plotBamCoverageFromResultTable(fds, result=res_dt[1,], show_full_gene=FALSE,
control_samples="sample3", curvature_splicegraph=0.5, txdb=txdb,
curvature_coverage=0.5, right_extension=5000, left_extension=5000,
splicegraph_labels="id")

43

FRASER: Find RAre Splicing Events in RNA-seq Data

References

[1] D. D. Pervouchine, D. G. Knowles, and R. Guigo.

Intron-centric estima-
tion of alternative splicing from RNA-seq data. Bioinformatics, 29(2):273–
274, November 2012. URL: https://doi.org/10.1093/bioinformatics/bts678,
doi:10.1093/bioinformatics/bts678.

[2] Alexander Dobin, Carrie A. Davis, Felix Schlesinger, Jorg Drenkow, Chris Za-
leski, Sonali Jha, Philippe Batut, Mark Chaisson, and Thomas R. Gingeras.
STAR: ultrafast universal RNA-seq aligner. Bioinformatics, 29(1):15–21, Jan-
uary 2013. URL: https://doi.org/10.1093/bioinformatics/bts635, doi:10.1093/
bioinformatics/bts635.

[3] Santiago Marco-Sola, Michael Sammeth, Roderic Guigó, and Paolo Ribeca. The
GEM mapper: fast, accurate and versatile alignment by filtration. Nature Meth-
ods, 9(12):1185–1188, October 2012. URL: https://doi.org/10.1038/nmeth.
2221, doi:10.1038/nmeth.2221.

44

FRASER: Find RAre Splicing Events in RNA-seq Data

[4] Matan Gavish and David L. Donoho. The Optimal Hard Threshold for Singular

Values is 4/sqrt(3). URL: http://arxiv.org/pdf/1305.5870.

[5] Yoav Benjamini and Daniel Yekutieli. The control of the false discovery rate
in multiple testing under dependency. Annals of Statistics, 29(4):1165–1188,
2001. URL: https://projecteuclid.org/euclid.aos/1013699998, arXiv:0801.1095,
doi:10.1214/aos/1013699998.

5

Session Info

Here is the output of sessionInfo() on the system on which this document was
compiled:

## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS

##

## Matrix products: default

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##

LAPACK version 3.12.0

## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_GB
## [5] LC_MONETARY=en_US.UTF-8
## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##

## attached base packages:

## [1] stats4

stats

graphics

grDevices utils

datasets

methods

## [8] base

##

## other attached packages:
## [1] data.table_1.18.2.1
## [2] org.Hs.eg.db_3.22.0
## [3] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
## [4] GenomicFeatures_1.62.0
## [5] AnnotationDbi_1.72.0
## [6] FRASER_2.6.1
## [7] SummarizedExperiment_1.40.0
## [8] Biobase_2.70.0

45

FRASER: Find RAre Splicing Events in RNA-seq Data

## [9] MatrixGenerics_1.22.0
## [10] matrixStats_1.5.0
## [11] Rsamtools_2.26.0
## [12] Biostrings_2.78.0
## [13] XVector_0.50.0
## [14] GenomicRanges_1.62.1
## [15] IRanges_2.44.0
## [16] S4Vectors_0.48.0
## [17] Seqinfo_1.0.0
## [18] BiocGenerics_0.56.0
## [19] generics_0.1.4
## [20] knitr_1.51
## [21] BiocParallel_1.44.0
##

## loaded via a namespace (and not attached):

##

##

##

##

[1] splines_4.5.2
[3] bitops_1.0-9
[5] tibble_3.3.1
[7] graph_1.88.1
[9] XML_3.99-0.22

BiocIO_1.20.0
filelock_1.0.3
R.oo_1.27.1
rpart_4.1.24
lifecycle_1.0.5
##
OrganismDbi_1.52.0
## [11] httr2_1.2.2
lattice_0.22-9
## [13] ensembldb_2.34.0
backports_1.5.0
## [15] dendextend_1.19.1
Hmisc_5.2-5
## [17] magrittr_2.0.4
rmarkdown_2.30
## [19] plotly_4.12.0
otel_0.2.0
## [21] yaml_2.3.12
ggbio_1.58.0
## [23] RUnit_0.4.33.1
DBI_1.2.3
## [25] cowplot_1.2.0
abind_1.4-8
## [27] RColorBrewer_1.1-3
R.utils_2.13.0
## [29] purrr_1.2.1
biovizBase_1.58.0
## [31] AnnotationFilter_1.34.0
nnet_7.3-20
## [33] RCurl_1.98-1.17
VariantAnnotation_1.56.0
## [35] pracma_2.4.6
seriation_1.5.8
## [37] rappdirs_0.3.4
RMTstat_0.3.1
## [39] ggrepel_0.9.6
BiocStyle_2.38.0
## [41] pheatmap_1.0.13
## [43] DelayedMatrixStats_1.32.0 codetools_0.2-20
tidyselect_1.2.1
## [45] DelayedArray_0.36.0
UCSC.utils_1.6.1
## [47] PRROC_1.4
farver_2.1.2
## [49] OUTRIDER_1.28.1
TSP_1.2.6
## [51] viridis_0.6.5
BiocFileCache_3.0.0
## [53] base64enc_0.1-6
GenomicAlignments_1.46.0
## [55] webshot_0.5.5
Formula_1.2-5
## [57] jsonlite_2.0.0
foreach_1.5.2
## [59] iterators_1.0.14

46

FRASER: Find RAre Splicing Events in RNA-seq Data

## [61] tools_4.5.2
## [63] Rcpp_1.1.1
## [65] gridExtra_2.3
## [67] xfun_0.56
## [69] DESeq2_1.50.2
## [71] dplyr_1.2.0
## [73] HDF5Array_1.38.0
## [75] BiocManager_1.30.27
## [77] rhdf5filters_1.22.0
## [79] R6_2.6.1
## [81] dichromat_2.0-0.1
## [83] RSQLite_2.4.6
## [85] R.methodsS3_1.8.2
## [87] utf8_1.2.6
## [89] rtracklayer_1.70.1
## [91] httr_1.4.7
## [93] S4Arrays_1.10.1
## [95] gtable_0.3.6
## [97] registry_0.5-1
## [99] htmltools_0.5.9
## [101] ProtGenerics_1.42.0
## [103] Rsubread_2.24.0
## [105] SGSeq_1.44.0
## [107] reshape2_1.4.5
## [109] nlme_3.1-168
## [111] curl_7.0.0
## [113] rhdf5_2.54.1
## [115] parallel_4.5.2
## [117] restfulr_0.0.16
## [119] grid_4.5.2
## [121] pcaMethods_2.2.0
## [123] dbplyr_2.5.1
## [125] htmlTable_2.4.3
## [127] BBmisc_1.13.1
## [129] magick_2.9.0
## [131] locfit_1.5-9.12
## [133] rlang_1.1.7
## [135] heatmaply_1.6.0
## [137] plyr_1.8.9
## [139] viridisLite_0.4.3
## [141] txdbmaker_1.6.2
## [143] Matrix_1.7-4
## [145] hms_1.1.4
## [147] bit64_4.6.0-1
## [149] Rhdf5lib_1.32.0

progress_1.2.3
glue_1.8.0
SparseArray_1.10.8
mgcv_1.9-4
GenomeInfoDb_1.46.2
ca_0.71.1
withr_3.0.2
fastmap_1.2.0
digest_0.6.39
colorspace_2.1-2
biomaRt_2.66.1
cigarillo_1.0.0
h5mread_1.2.1
tidyr_1.3.2
prettyunits_1.2.0
htmlwidgets_1.6.4
pkgconfig_2.0.3
blob_1.3.0
S7_0.2.1
RBGL_1.86.0
scales_1.4.0
png_0.1-8
rstudioapi_0.18.0
rjson_0.2.23
checkmate_2.3.4
cachem_1.1.0
stringr_1.6.0
foreign_0.8-91
pillar_1.11.1
vctrs_0.7.1
VGAM_1.1-14
cluster_2.1.8.2
evaluate_1.0.5
tinytex_0.58
cli_3.6.5
compiler_4.5.2
crayon_1.5.3
labeling_0.4.3
stringi_1.8.7
assertthat_0.2.1
lazyeval_0.2.2
BSgenome_1.78.0
sparseMatrixStats_1.22.0
ggplot2_4.0.2
KEGGREST_1.50.0

47

FRASER: Find RAre Splicing Events in RNA-seq Data

## [151] highr_0.11
## [153] igraph_2.2.2
## [155] bit_4.6.0

extraDistr_1.10.0.2
memoise_2.0.1

48

