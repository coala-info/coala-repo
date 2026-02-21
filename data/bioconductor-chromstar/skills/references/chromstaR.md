The chromstaR user’s guide

Aaron Taudt ∗
∗aaron.taudt@gmail.com

October 30, 2017

Contents

1

2

3

Introduction .

.

.

.

.

Outline of workﬂow .

Univariate analysis .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

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

2

2

3

5

5

5

7

8

3.1

3.2

3.3

4.1

4.2

4.3

4.4

6.1

6.2

6.3

6.4

Task 1: Peak calling for a narrow histone modiﬁcation .

Task 2: Peak calling for a broad histone modiﬁcation .

.

Task 3: Peak calling for ATAC-seq, DNase-seq, FAIRE-seq, ... .

4

Multivariate analysis .

.

.

.

.

.

.

.

.

.

.

Task 1: Integrating multiple replicates .

Task 2: Detecting differentially modiﬁed regions .

Task 3: Finding combinatorial chromatin states .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Task 4: Finding differences between combinatorial chromatin states

12

5

6

Output of function Chromstar() .

FAQ .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

The peak calls are too lenient. Can I adjust the strictness of the
peak calling? .
.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

The combinatorial differences that chromstaR gives me are not con-
vincing. Is there a way to restrict the results to a more convincing
set? .
.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

How do I plot a simple heatmap with the combinations? .

Examples of problematic distributions. .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

7

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

16

17

17

18

18

19

19

The chromstaR user’s guide

1

Introduction

ChIP-seq has become the standard technique for assessing the genome-wide chromatin state
of DNA. chromstaR provides functions for the joint analysis of multiple ChIP-seq samples. It
allows peak calling for transcription factor binding and histone modiﬁcations with a narrow
(e.g. H3K4me3, H3K27ac, ...) or broad (e.g. H3K36me3, H3K27me3, ...) proﬁle. All
analysis can be performed on each sample individually (=univariate), or in a joint analysis
considering all samples simultaneously (=multivariate).

2

Outline of workﬂow

Every analysis with the chromstaR package starts from aligned reads in either BAM or BED
format. In the ﬁrst step, the genome is partitioned into non-overlapping, equally sized bins
and the reads that fall into each bin are counted. These read counts serve as the basis for
both the univariate and the multivariate peak- and broad-region calling. Univariate peak
calling is done by ﬁtting a three-state Hidden Markov Model to the binned read counts.
Multivariate peak calling for S samples is done by ﬁtting a 2S -state Hidden Markov Model
to all binned read counts.

3

Univariate analysis

3.1

Task 1: Peak calling for a narrow histone modiﬁcation

Examples of histone modiﬁcations with a narrow proﬁle are H3K4me3, H3K9ac and H3K27ac
in most human tissues. For such peak-like modiﬁcations, the bin size should be set to a value
between 200bp and 1000bp.

library(chromstaR)

## === Step 1: Binning ===
# Get an example BAM file
file <- system.file("extdata","euratrans","lv-H3K4me3-BN-male-bio2-tech1.bam",

package="chromstaRData")

# Get the chromosome lengths (see ?GenomeInfoDb::fetchExtendedChromInfoFromUCSC)
# This is only necessary for BED files. BAM files are handled automatically.
data(rn4_chrominfo)
head(rn4_chrominfo)

##
## 1
## 2
## 3
## 4
## 5
## 6

chromosome
chrM

length
16300
chr12 46782294
chr20 55268282
chr19 59218465
chr18 87265094
chr11 87759784

# We use bin size 1000bp and chromosome 12 to keep the example quick
binned.data <- binReads(file, assembly=rn4_chrominfo, binsizes=1000,

stepsizes=500, chromosomes='chr12')

print(binned.data)

## GRanges object with 46782 ranges and 1 metadata column:
##
##
##
##
##
##

counts
<Rle> | <matrix>
0:0
0:0
0:0
0:0

<IRanges>
[
1, 1000]
[1001, 2000]
[2001, 3000]
[3001, 4000]

seqnames
<Rle>
chr12
chr12
chr12
chr12

[1]
[2]
[3]
[4]

ranges strand |

* |
* |
* |
* |

2

The chromstaR user’s guide

##
##
##
##
##
##
##
##
##

chr12
...

[4001, 5000]
...
chr12 [46777001, 46778000]
chr12 [46778001, 46779000]
chr12 [46779001, 46780000]
chr12 [46780001, 46781000]
chr12 [46781001, 46782000]

[5]
...
[46778]
[46779]
[46780]
[46781]
[46782]
-------
seqinfo: 22 sequences from an unspecified genome

* |
... .
* |
* |
* |
* |
* |

0:0
...
2:3
1:0
0:0
2:3
1:0

## === Step 2: Peak calling ===
model <- callPeaksUnivariate(binned.data, verbosity=0)

## === Step 3: Checking the fit ===
# For a narrow modification, the fit should look something like this,
# with the 'modified'-component near the bottom of the figure
plotHistogram(model) + ggtitle('H3K4me3')

## === Step 4: Working with peaks ===
# Get the number and average size of peaks
length(model$peaks); mean(width(model$peaks))

## [1] 1245
## [1] 4008.434

# Change the false discovery rate and get number of peaks
model <- changeFDR(model, fdr=1e-4)
length(model$peaks); mean(width(model$peaks))

## [1] 913
## [1] 4861.993

## === Step 5: Export to genome browser ===
# We can export peak calls and binned read counts with
exportPeaks(model, filename=tempfile())
exportCounts(model, filename=tempfile())

!! It is important that the distributions are ﬁtted correctly !! Please check section 6.4
for examples of how this plot should not look like and what can be done to get a correct ﬁt.

3.2

Task 2: Peak calling for a broad histone modiﬁcation

Examples of histone modiﬁcations with a broad proﬁle are H3K9me3, H3K27me3, H3K36me3,
H4K20me1 in most human tissues. These modiﬁcations usually cover broad domains of the
genome, and the enrichment is best captured with a bin size between 500bp and 2000bp.

library(chromstaR)

## === Step 1: Binning ===
# Get an example BAM file
file <- system.file("extdata","euratrans","lv-H3K27me3-BN-male-bio2-tech1.bam",

package="chromstaRData")

# Get the chromosome lengths (see ?GenomeInfoDb::fetchExtendedChromInfoFromUCSC)
# This is only necessary for BED files. BAM files are handled automatically.
data(rn4_chrominfo)

3

0.00.10.20.30.40.50510read countdensitycomponentsunmodified, mean=1.23, var=2.15, weight=0.89modified, mean=66.09, var=9976.9, weight=0.11total, mean(data)=8.41, var(data)=1999.65H3K4me3The chromstaR user’s guide

head(rn4_chrominfo)
# We use bin size 1000bp and chromosome 12 to keep the example quick
binned.data <- binReads(file, assembly=rn4_chrominfo, binsizes=1000,

stepsizes=500, chromosomes='chr12')

## === Step 2: Peak calling ===
model <- callPeaksUnivariate(binned.data, verbosity=0)

## === Step 3: Checking the fit ===
# For a broad modification, the fit should look something like this,
# with a 'modified'-component that fits the thick tail of the distribution.
plotHistogram(model) + ggtitle('H3K27me3')

## === Step 4: Working with peaks ===
peaks <- model$peaks
length(peaks); mean(width(peaks))

## [1] 523
## [1] 43522.94

# Change the false discovery rate and get number of peaks
model <- changeFDR(model, fdr=1e-4)
peaks <- model$peaks
length(peaks); mean(width(peaks))

## [1] 416
## [1] 52582.93

## === Step 5: Export to genome browser ===
# We can export peak calls and binned read counts with
exportPeaks(model, filename=tempfile())
exportCounts(model, filename=tempfile())

## === Step 1-3: Another example for mark H4K20me1 ===
file <- system.file("extdata","euratrans","lv-H4K20me1-BN-male-bio1-tech1.bam",

data(rn4_chrominfo)
binned.data <- binReads(file, assembly=rn4_chrominfo, binsizes=1000,

package="chromstaRData")

model <- callPeaksUnivariate(binned.data, max.time=60, verbosity=0)
plotHistogram(model) + ggtitle('H4K20me1')

stepsizes=500, chromosomes='chr12')

4

0.000.050.100.150.2002040read countdensitycomponentsunmodified, mean=2.56, var=6.25, weight=0.51modified, mean=18.27, var=182.05, weight=0.49total, mean(data)=9.86, var(data)=193.69H3K27me30.000.050.100.15020406080read countdensitycomponentsunmodified, mean=7.41, var=31.56, weight=0.67modified, mean=91.95, var=5054.18, weight=0.33total, mean(data)=34.67, var(data)=3562.69H4K20me1The chromstaR user’s guide

!! It is important that the distributions are ﬁtted correctly !! Please check section 6.4
for examples of how this plot should not look like and what can be done to get a correct ﬁt.

3.3

Task 3: Peak calling for ATAC-seq, DNase-seq, FAIRE-seq,
...

Peak calling for ATAC-seq and DNase-seq is similar to the peak calling of a narrow histone
modiﬁcation (section 3.1). FAIRE-seq experiments seem to exhibit a broad proﬁle with our
model, so the procedure is similar to the domain calling of a broad histone modiﬁcation
(section 3.2).

4

Multivariate analysis

4.1

Task 1: Integrating multiple replicates

chromstaR can be used to call peaks with multiple replicates, without the need of prior
merging. The underlying statistical model integrates information from all replicates to identify
common peaks. It is, however, important to note that replicates with poor quality can aﬀect
the joint peak calling negatively.
It is therefore recommended to ﬁrst check the replicate
quality and discard poor-quality replicates. The necessary steps for peak calling for an example
ChIP-seq experiment with 4 replicates are detailed below.

Please note that also the other tasks in this section (Task 4.2, 4.3 and 4.4) can handle mul-
tiple replicates via speciﬁcation of the experiment.table parameter. The following example
demonstrates how to explicitly use multiple replicates for peak calling and their correlation
as a basic quality control.

library(chromstaR)

#=== Step 1: Preparation ===
# Let's get some example data with 3 replicates in spontaneous hypertensive rat (SHR)
file.path <- system.file("extdata","euratrans", package='chromstaRData')
files.good <- list.files(file.path, pattern="H3K27me3.*SHR.*bam$", full.names=TRUE)[1:3]
# We fake a replicate with poor quality by taking a different mark entirely
files.poor <- list.files(file.path, pattern="H4K20me1.*SHR.*bam$", full.names=TRUE)[1]
files <- c(files.good, files.poor)
# Obtain chromosome lengths. This is only necessary for BED files. BAM files are
# handled automatically.
data(rn4_chrominfo)
head(rn4_chrominfo)

##
## 1
## 2
## 3
## 4
## 5
## 6

chromosome
chrM

length
16300
chr12 46782294
chr20 55268282
chr19 59218465
chr18 87265094
chr11 87759784

# Define experiment structure
exp <- data.frame(file=files, mark='H3K27me3', condition='SHR', replicate=1:4,

pairedEndReads=FALSE, controlFiles=NA)

# Peaks could now be called with
# Chromstar(inputfolder=file.path, experiment.table=exp, outputfolder=tempdir(),
#
# However, to get more information on the replicates we will choose
# a more detailed workflow.

mode = 'separate')

5

The chromstaR user’s guide

## === Step 2: Binning ===
# We use bin size 1000bp and chromosome 12 to keep the example quick
binned.data <- list()
for (file in files) {

binned.data[[basename(file)]] <- binReads(file, binsize=1000, stepsizes=500,

assembly=rn4_chrominfo, chromosomes='chr12',
experiment.table=exp)

}

## === Step 3: Univariate peak calling ===
# The univariate fit is obtained for each replicate
models <- list()
for (i1 in 1:length(binned.data)) {

models[[i1]] <- callPeaksUnivariate(binned.data[[i1]], max.time=60)
plotHistogram(models[[i1]])

}

!! It is important that the distributions are ﬁtted correctly !! Please check section 6.4 for examples of how this plot should
not look like and what can be done to get a correct ﬁt.

## === Step 4: Check replicate correlation ===
# We run a multivariate peak calling on all 4 replicates
# A warning is issued because replicate 4 is very different from the others
multi.model <- callPeaksReplicates(models, max.time=60, eps=1)

Iteration
0

## HMM: number of states = 16
## HMM: number of bins = 46782
## HMM: maximum number of iterations = none
## HMM: maximum running time = 60 sec
## HMM: epsilon = 1
## HMM: number of experiments = 4
log(P)
##
##
-inf
## HMM: Precomputing densities ...
##
##
##
##
##
##
##
##
##
## HMM: Convergence reached!
## HMM: Recoding posteriors ...

log(P)
-inf
-542989.146422
-538374.740061
-538271.399633
-538250.213731
-538244.134929
-538241.935145
-538240.963921

Iteration
0
1
2
3
4
5
6
7

dlog(P)
-

Time in sec
0

dlog(P)
-
inf
4614.406361
103.340428
21.185902
6.078802
2.199784
0.971224

Time in sec
0
0
0
0
1
1
1
1

## Warning in callPeaksReplicates(models, max.time = 60, eps = 1):
redoing your analysis with only the group with the highest average coverage:
## H3K27me3-SHR-rep1
## H3K27me3-SHR-rep2
## H3K27me3-SHR-rep3
## Replicates from groups with lower coverage are:
## H3K27me3-SHR-rep4

Your replicates cluster in 2 groups.

Consider

# Checking the correlation confirms that Rep4 is very different from the others
print(multi.model$replicateInfo$correlation)

##
## H3K27me3-SHR-rep1
## H3K27me3-SHR-rep2
## H3K27me3-SHR-rep3
## H3K27me3-SHR-rep4

H3K27me3-SHR-rep1 H3K27me3-SHR-rep2 H3K27me3-SHR-rep3 H3K27me3-SHR-rep4
-0.3718157
-0.3717750
-0.3716530
1.0000000

0.9997432
0.9997217
1.0000000
-0.3716530

0.9999358
1.0000000
0.9997217
-0.3717750

1.0000000
0.9999358
0.9997432
-0.3718157

## === Step 5: Peak calling with replicates ===
# We redo the previous step without the "bad" replicate
# Also, we force all replicates to agree in their peak calls
multi.model <- callPeaksReplicates(models[1:3], force.equal=TRUE, max.time=60)

## === Step 6: Export to genome browser ===
# Finally, we can export the results as BED file
exportPeaks(multi.model, filename=tempfile())
exportCounts(multi.model, filename=tempfile())

6

The chromstaR user’s guide

4.2

Task 2: Detecting differentially modiﬁed regions

chromstaR is extremely powerful in detecting diﬀerentially modiﬁed regions in two or more
samples. The following example illustrates this on ChIP-seq data for H4K20me1 in brown
norway (BN) and spontaneous hypertensive rat (SHR) in left-ventricle (lv) heart tissue. The
mode of analysis is called diﬀerential.

library(chromstaR)

#=== Step 1: Preparation ===
## Prepare the file paths. Exchange this with your input and output directories.
inputfolder <- system.file("extdata","euratrans", package="chromstaRData")
outputfolder <- file.path(tempdir(), 'H4K20me1-example')

## Define experiment structure, put NA if you don't have controls
data(experiment_table_H4K20me1)
print(experiment_table_H4K20me1)

file

##
BN
lv-H4K20me1-BN-male-bio1-tech1.bam H4K20me1
## 1
BN
## 2
lv-H4K20me1-BN-male-bio2-tech1.bam H4K20me1
SHR
## 3 lv-H4K20me1-SHR-male-bio1-tech1.bam H4K20me1
controlFiles
##
## 1 lv-input-BN-male-bio1-tech1.bam|lv-input-BN-male-bio1-tech2.bam
## 2 lv-input-BN-male-bio1-tech1.bam|lv-input-BN-male-bio1-tech2.bam
lv-input-SHR-male-bio1-tech1.bam
## 3

mark condition replicate pairedEndReads
FALSE
FALSE
FALSE

1
2
1

## Define assembly
# This is only necessary if you have BED files, BAM files are handled automatically.
# For common assemblies you can also specify them as 'hg19' for example.
data(rn4_chrominfo)
head(rn4_chrominfo)

##
## 1
## 2
## 3
## 4
## 5
## 6

chromosome
chrM

length
16300
chr12 46782294
chr20 55268282
chr19 59218465
chr18 87265094
chr11 87759784

#=== Step 2: Run Chromstar ===
## Run ChromstaR
Chromstar(inputfolder, experiment.table=experiment_table_H4K20me1,

outputfolder=outputfolder, numCPU=4, binsize=1000, stepsize=500,
assembly=rn4_chrominfo, prefit.on.chr='chr12', chromosomes='chr12',
mode='differential')

## Results are stored in 'outputfolder' and can be loaded for further processing
list.files(outputfolder)

##
##
##

[1] "BROWSERFILES"
[5] "chrominfo.tsv"
[9] "multivariate"

"PLOTS"
"chromstaR.config"
"univariate"

"README.txt"
"combined"

"binned"
"experiment_table.tsv"

model <- get(load(file.path(outputfolder,'multivariate',

'multivariate_mode-differential_mark-H4K20me1.RData')))

It is important that the distributions in folder outputfolder/PLOTS/univariate-distributions are ﬁtted correctly !!

!!
Please check section 6.4 for examples of how this plot should not look like and what can be done to get a correct ﬁt.

## === Step 3: Construct differential and common states ===
diff.states <- stateBrewer(experiment_table_H4K20me1, mode='differential',

differential.states=TRUE)

print(diff.states)

##
## 1
## 2

combination state
1
[SHR]
6
[BN]

common.states <- stateBrewer(experiment_table_H4K20me1, mode='differential',
common.states=TRUE)

print(common.states)

##
## 1

combination state
0

[]

7

The chromstaR user’s guide

## 2

[BN+SHR]

7

## === Step 5: Export to genome browser ===
# Export only differential states
exportPeaks(model, filename=tempfile())
exportCounts(model, filename=tempfile())
exportCombinations(model, filename=tempfile(), include.states=diff.states)

4.3

Task 3: Finding combinatorial chromatin states

Most experimental studies that probe several histone modiﬁcations are interested in combina-
torial chromatin states. An example of a simple combinatorial state would be [H3K4me3+H3K27me3],
which is also frequently called “bivalent promoter”, due to the simultaneous occurrence of
the promoter marking H3K4me3 and the repressive H3K27me3. Finding combinatorial states
with chromstaR is equivalent to a multivariate peak calling. The following code chunks
demonstrate how to ﬁnd bivalent promoters and do some simple analysis. The mode of
analysis is called combinatorial.

library(chromstaR)

#=== Step 1: Preparation ===
## Prepare the file paths. Exchange this with your input and output directories.
inputfolder <- system.file("extdata","euratrans", package="chromstaRData")
outputfolder <- file.path(tempdir(), 'SHR-example')

## Define experiment structure, put NA if you don't have controls
# (SHR = spontaneous hypertensive rat)
data(experiment_table_SHR)
print(experiment_table_SHR)

file

lv-H3K4me3-SHR-male-bio2-tech1.bam
lv-H3K4me3-SHR-male-bio3-tech1.bam

##
## 1 lv-H3K27me3-SHR-male-bio2-tech1.bam H3K27me3
## 2 lv-H3K27me3-SHR-male-bio2-tech2.bam H3K27me3
H3K4me3
## 3
## 4
H3K4me3
##
controlFiles
## 1 lv-input-SHR-male-bio1-tech1.bam
## 2 lv-input-SHR-male-bio1-tech1.bam
## 3 lv-input-SHR-male-bio1-tech1.bam
## 4 lv-input-SHR-male-bio1-tech1.bam

mark condition replicate pairedEndReads
FALSE
FALSE
FALSE
FALSE

SHR
SHR
SHR
SHR

1
2
1
2

## Define assembly
# This is only necessary if you have BED files, BAM files are handled automatically.
# For common assemblies you can also specify them as 'hg19' for example.
data(rn4_chrominfo)
head(rn4_chrominfo)

##
## 1
## 2
## 3
## 4
## 5
## 6

chromosome
chrM

length
16300
chr12 46782294
chr20 55268282
chr19 59218465
chr18 87265094
chr11 87759784

#=== Step 2: Run Chromstar ===
## Run ChromstaR
Chromstar(inputfolder, experiment.table=experiment_table_SHR,

outputfolder=outputfolder, numCPU=4, binsize=1000, stepsize=500,
assembly=rn4_chrominfo, prefit.on.chr='chr12', chromosomes='chr12',
mode='combinatorial')

It is important that the distributions in folder outputfolder/PLOTS/univariate-distributions are ﬁtted correctly !!

!!
Please check section 6.4 for examples of how this plot should not look like and what can be done to get a correct ﬁt.

## Results are stored in 'outputfolder' and can be loaded for further processing
list.files(outputfolder)

##
##
##

[1] "BROWSERFILES"
[5] "chrominfo.tsv"
[9] "multivariate"

"PLOTS"
"chromstaR.config"
"univariate"

"README.txt"
"combined"

"binned"
"experiment_table.tsv"

8

The chromstaR user’s guide

model <- get(load(file.path(outputfolder,'multivariate',

'multivariate_mode-combinatorial_condition-SHR.RData')))

# Obtain genomic frequencies for combinatorial states
genomicFrequencies(model)

## $frequency
##
##
##
##
## $domains
##
##
##

[]
0.41193194

[H3K4me3]
0.09392501

[H3K27me3] [H3K27me3+H3K4me3]
0.06280193
0.43134111

[]
1188

[H3K4me3]
683

[H3K27me3] [H3K27me3+H3K4me3]
893

1166

# Plot transition probabilities and read count correlation
heatmapTransitionProbs(model) + ggtitle('Transition probabilities')

heatmapCountCorrelation(model) + ggtitle('Read count correlation')

## === Step 3: Enrichment analysis ===
# Annotations can easily be obtained with the biomaRt package. Of course, you can
# also load them from file if you already have annotation files available.
library(biomaRt)
ensembl <- useMart('ENSEMBL_MART_ENSEMBL', host='may2012.archive.ensembl.org',

dataset='rnorvegicus_gene_ensembl')

genes <- getBM(attributes=c('ensembl_gene_id', 'chromosome_name', 'start_position',

'end_position', 'strand', 'external_gene_id',
'gene_biotype'),

mart=ensembl)
# Transform to GRanges for easier handling
genes <- GRanges(seqnames=paste0('chr',genes$chromosome_name),

ranges=IRanges(start=genes$start, end=genes$end),
strand=genes$strand,
name=genes$external_gene_id, biotype=genes$gene_biotype)

seqlevels(genes)[seqlevels(genes)=='chrMT'] <- 'chrM'
print(genes)

## GRanges object with 29516 ranges and 2 metadata columns:
##

ranges strand |

seqnames

name

biotype

9

[H3K27me3+H3K4me3][H3K27me3][][H3K4me3][H3K27me3+H3K4me3][H3K27me3][][H3K4me3]tofrom0.250.500.75probTransition probabilitiesH3K4me3−SHR−rep1H3K4me3−SHR−rep2H3K27me3−SHR−rep1H3K27me3−SHR−rep2H3K4me3−SHR−rep1H3K4me3−SHR−rep2H3K27me3−SHR−rep1H3K27me3−SHR−rep20.000.250.500.751.00correlationRead count correlationThe chromstaR user’s guide

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

<Rle> | <character>

<Rle>
chr13
chr13
chr13
chr13
chr13
...

<IRanges>
[1120899, 1121213]
[1192186, 2293551]
[3174383, 3175216]
[4377731, 4379174]
[4866302, 4866586]
...
chr6 [134310258, 134310338]
6921049]
chr9 [
40073816]
chr2 [233090372, 233090478]
92917541]
chr6 [ 92917449,

[1]
[2]
[3]
[4]
[5]
...
[29512]
[29513]
[29514]
[29515]
[29516]
-------
seqinfo: 22 sequences from an unspecified genome; no seqlengths

<character>
LOC682397 protein_coding
- |
LOC304725 protein_coding
- |
+ |
pseudogene
- | D3ZPH4_RAT protein_coding
- | F1LZC7_RAT protein_coding
...
snoRNA
snRNA
snoRNA
snRNA
miRNA

...
SNORD113
U1
SNORD19B
U6

6920889,
chr11 [ 40073746,

... .
+ |
- |
- |
- |
+ |

# We expect promoter [H3K4me3] and bivalent-promoter signatures [H3K4me3+H3K27me3]
# to be enriched at transcription start sites.
plotEnrichment(hmm = model, annotation = genes, bp.around.annotation = 15000) +

ggtitle('Fold enrichment around genes') +
xlab('distance from gene body')

# Plot enrichment only at TSS. We make use of the fact that TSS is the start of a gene.
plotEnrichment(model, genes, region = 'start') +

ggtitle('Fold enrichment around TSS') +
xlab('distance from TSS in [bp]')

# Note: If you want to facet the plot because you have many combinatorial states you
# can do that with
plotEnrichment(model, genes, region = 'start') +

facet_wrap(~ combination) + ggtitle('Fold enrichment around TSS')

10

−0.50.00.51.01.5−15000−75000%50%100%750015000distance from gene bodylog(observed/expected)combination[][H3K4me3][H3K27me3][H3K27me3+H3K4me3]Fold enrichment around genes−0.50.00.51.01.5−10000−50000500010000distance from TSS in [bp]log(observed/expected)combination[][H3K4me3][H3K27me3][H3K27me3+H3K4me3]Fold enrichment around TSSThe chromstaR user’s guide

# Another form of visualization that shows every TSS in a heatmap
tss <- resize(genes, width = 3, fix = 'start')
plotEnrichCountHeatmap(model, tss, bp.around.annotation = 15000) +

theme(strip.text.x = element_text(size=6)) +
scale_x_continuous(breaks=c(-10000,0,10000)) +
ggtitle('Read count around TSS')

# Fold enrichment with different biotypes, showing that protein coding genes are
# enriched with (bivalent) promoter combinations [H3K4me3] and [H3K4me3+H3K27me3],
# while rRNA is enriched with the empty [] combination.
biotypes <- split(tss, tss$biotype)
plotFoldEnrichHeatmap(model, annotations=biotypes) + coord_flip() +

ggtitle('Fold enrichment with different biotypes')

# === Step 4: Expression analysis ===
# Suppose you have expression data as well for your experiment. The following code
# shows you how to get the expression values for each combinatorial state.

11

[H3K27me3][H3K27me3+H3K4me3][][H3K4me3]−10000−50000500010000−10000−50000500010000−0.50.00.51.01.5−0.50.00.51.01.5distance from annotation in [bp]log(observed/expected)combination[][H3K4me3][H3K27me3][H3K27me3+H3K4me3]Fold enrichment around TSSH3K27me3−SHR−rep1H3K27me3−SHR−rep2H3K4me3−SHR−rep1H3K4me3−SHR−rep2−10000010000−10000010000−10000010000−10000010000distance from annotation in [bp]0500100015002000RPKMcombination[H3K4me3][H3K27me3][][H3K27me3+H3K4me3]Read count around TSS[][H3K4me3][H3K27me3][H3K27me3+H3K4me3]Mt_rRNAMt_tRNAmiRNAmisc_RNAprotein_codingpseudogenerRNAretrotransposedsnRNAsnoRNAannotationcombination−6−3036log(observed/expected)Fold enrichment with different biotypesThe chromstaR user’s guide

data(expression_lv)
head(expression_lv)

##
## 1 ENSRNOG00000000001
## 2 ENSRNOG00000000007
## 3 ENSRNOG00000000008
## 4 ENSRNOG00000000010
## 5 ENSRNOG00000000012
## 6 ENSRNOG00000000014

ensembl_gene_id expression_BN expression_SHR
7.4
13.0
3.4
506.8
36.4
15.2

8.8
20.0
1.8
6.2
48.0
18.2

# We need to get coordinates for each of the genes
library(biomaRt)
ensembl <- useMart('ENSEMBL_MART_ENSEMBL', host='may2012.archive.ensembl.org',

dataset='rnorvegicus_gene_ensembl')

genes <- getBM(attributes=c('ensembl_gene_id', 'chromosome_name', 'start_position',

'end_position', 'strand', 'external_gene_id',
'gene_biotype'),

mart=ensembl)

expr <- merge(genes, expression_lv, by='ensembl_gene_id')
# Transform to GRanges
expression.SHR <- GRanges(seqnames=paste0('chr',expr$chromosome_name),

ranges=IRanges(start=expr$start, end=expr$end),
strand=expr$strand, name=expr$external_gene_id,
biotype=expr$gene_biotype,
expression=expr$expression_SHR)

seqlevels(expression.SHR)[seqlevels(expression.SHR)=='chrMT'] <- 'chrM'
# We apply an asinh transformation to reduce the effect of outliers
expression.SHR$expression <- asinh(expression.SHR$expression)

## Plot
plotExpression(model, expression.SHR) +

theme(axis.text.x=element_text(angle=0, hjust=0.5)) +
ggtitle('Expression of genes overlapping combinatorial states')

plotExpression(model, expression.SHR, return.marks=TRUE) +

ggtitle('Expression of marks overlapping combinatorial states')

4.4

Task 4: Finding differences between combinatorial chromatin
states

Consider bivalent promoters deﬁned by [H3K4me3+H3K27me3] at two diﬀerent developmen-
tal stages, or in two diﬀerent strains or tissues. This is an example where one is interested in
diﬀerences between combinatorial states. The following example demonstrates how such an

12

llllllllllllllllllllllllllllllllllllll0510[H3K27me3+H3K4me3][H3K27me3][H3K4me3][]combinationexpressionExpression of genes overlapping combinatorial statesllllllllllllllllllllllll0510H3K27me3H3K4me3markexpressionExpression of marks overlapping combinatorial statesThe chromstaR user’s guide

analysis can be done with chromstaR. We use a data set from the Euratrans project (down-
sampled to chr12) to ﬁnd diﬀerences in bivalent promoters between brown norway (BN) and
spontaneous hypertensive rat (SHR) in left-ventricle (lv) heart tissue.

Chromstar can be run in 4 diﬀerent modes:

• full: Recommended mode if your (number of marks) * (number of conditions) is less
or equal to 8. With 8 ChIP-seq experiments there are already 28 = 256 combinatorial
states which is the maximum that most computers can handle computationally for a
human-sized genome at bin size 1000bp.

• DEFAULT diﬀerential: Choose this mode if you are interested in highly signiﬁcant
diﬀerences between conditions. The computational limit for the number of conditions
is ∼ 8 for a human-sized genome. Combinatorial states are not as accurate as in mode
combinatorial or full.

• combinatorial: This mode will yield good combinatorial chromatin state calls for any
number of marks and conditions. However, diﬀerences between conditions have more
false positives than in mode diﬀerential or full.

• separate: Only replicates are processed in a multivariate manner. Combinatorial states

are constructed by a simple post-hoc combination of peak calls.

library(chromstaR)

#=== Step 1: Preparation ===
## Prepare the file paths. Exchange this with your input and output directories.
inputfolder <- system.file("extdata","euratrans", package="chromstaRData")
outputfolder <- file.path(tempdir(), 'SHR-BN-example')

## Define experiment structure, put NA if you don't have controls
data(experiment_table)
print(experiment_table)

file

mark condition replicate pairedEndReads
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE

##
BN
lv-H3K27me3-BN-male-bio2-tech1.bam H3K27me3
## 1
BN
## 2
lv-H3K27me3-BN-male-bio2-tech2.bam H3K27me3
SHR
## 3 lv-H3K27me3-SHR-male-bio2-tech1.bam H3K27me3
SHR
## 4 lv-H3K27me3-SHR-male-bio2-tech2.bam H3K27me3
BN
H3K4me3
## 5 lv-H3K4me3-BN-female-bio1-tech1.bam
BN
H3K4me3
lv-H3K4me3-BN-male-bio2-tech1.bam
## 6
SHR
H3K4me3
lv-H3K4me3-SHR-male-bio2-tech1.bam
## 7
SHR
## 8
H3K4me3
lv-H3K4me3-SHR-male-bio3-tech1.bam
controlFiles
##
## 1 lv-input-BN-male-bio1-tech1.bam|lv-input-BN-male-bio1-tech2.bam
## 2 lv-input-BN-male-bio1-tech1.bam|lv-input-BN-male-bio1-tech2.bam
lv-input-SHR-male-bio1-tech1.bam
## 3
lv-input-SHR-male-bio1-tech1.bam
## 4
<NA>
## 5
<NA>
## 6
<NA>
## 7
<NA>
## 8

1
2
1
2
1
2
1
2

## Define assembly
# This is only necessary if you have BED files, BAM files are handled automatically.
# For common assemblies you can also specify them as 'hg19' for example.
data(rn4_chrominfo)
head(rn4_chrominfo)

##
## 1
## 2
## 3
## 4
## 5
## 6

chromosome
chrM

length
16300
chr12 46782294
chr20 55268282
chr19 59218465
chr18 87265094
chr11 87759784

#=== Step 2: Run Chromstar ===
## Run ChromstaR
Chromstar(inputfolder, experiment.table=experiment_table,

outputfolder=outputfolder, numCPU=4, binsize=1000, stepsize=500,
assembly=rn4_chrominfo, prefit.on.chr='chr12', chromosomes='chr12',

13

The chromstaR user’s guide

mode='differential')

## Results are stored in 'outputfolder' and can be loaded for further processing
list.files(outputfolder)

##
##
##

[1] "BROWSERFILES"
[5] "chrominfo.tsv"
[9] "multivariate"

"PLOTS"
"chromstaR.config"
"univariate"

"README.txt"
"combined"

"binned"
"experiment_table.tsv"

model <- get(load(file.path(outputfolder,'combined',

'combined_mode-differential.RData')))

It is important that the distributions in folder outputfolder/PLOTS/univariate-distributions are ﬁtted correctly !!

!!
Please check section 6.4 for examples of how this plot should not look like and what can be done to get a correct ﬁt.

#=== Step 3: Analysis and export ===
## Obtain all genomic regions where the two tissues have different states
segments <- model$segments
diff.segments <- segments[segments$combination.SHR != segments$combination.BN]
# Let's be strict with the differences and get only those where both marks are different
diff.segments <- diff.segments[diff.segments$differential.score >= 1.9]
exportGRangesAsBedFile(diff.segments, trackname='differential_chromatin_states',
filename=tempfile(), scorecol='differential.score')

## Warning in exportGRangesAsBedFile(diff.segments, trackname = "differential_chromatin_states", :
should contain integer values between 0 and 1000 for compatibility with the UCSC convention.

Column ’differential.score’

## Obtain all genomic regions where we find a bivalent promoter in BN but not in SHR
bivalent.BN <- segments[segments$combination.BN == '[H3K27me3+H3K4me3]' &
segments$combination.SHR != '[H3K27me3+H3K4me3]']

## Obtain all genomic regions where BN and SHR have promoter signatures
promoter.BN <- segments[segments$transition.group == 'constant [H3K4me3]']

## Get transition frequencies
print(model$frequencies)

1326 4.367492e-01
1324 4.197982e-01
849 8.564191e-02
848 5.275533e-02
19 1.934505e-03
17 1.752811e-03
16 4.702663e-04
12 2.992604e-04
5 2.030696e-04
5 1.603181e-04
3 7.481510e-05
1 6.412723e-05
1 6.412723e-05
1 3.206361e-05

frequency cumulative.frequency
0.4367492
0.8565474
0.9421893
0.9949446
0.9968791
0.9986320
0.9991022
0.9994015
0.9996045
0.9997649
0.9998397
0.9999038
0.9999679
1.0000000

combination.SHR domains

[H3K27me3]
[]

[]
[H3K27me3+H3K4me3]

combination.BN
[H3K27me3]
[]
[H3K4me3]

##
[H3K27me3]
## 1
[]
## 2
[H3K4me3]
## 3
[H3K27me3+H3K4me3] [H3K27me3+H3K4me3]
## 4
[]
## 5
[H3K27me3]
## 6
[H3K27me3] [H3K27me3+H3K4me3]
## 7
[H3K4me3]
## 8
[H3K27me3]
## 9
[H3K4me3] [H3K27me3+H3K4me3]
## 10
[]
## 11
[H3K4me3]
## 12 [H3K27me3+H3K4me3]
[]
[] [H3K27me3+H3K4me3]
## 13
[H3K4me3]
## 14
##
group
constant [H3K27me3]
## 1
zero transition
## 2
## 3
constant [H3K4me3]
constant [H3K27me3+H3K4me3]
## 4
stage-specific [H3K27me3]
## 5
stage-specific [H3K27me3]
## 6
## 7
other
stage-specific [H3K4me3]
## 8
other
## 9
## 10
other
stage-specific [H3K4me3]
## 11
## 12 stage-specific [H3K27me3+H3K4me3]
## 13 stage-specific [H3K27me3+H3K4me3]
other
## 14

[H3K27me3]

## === Step 4: Enrichment analysis ===
# Annotations can easily be obtained with the biomaRt package. Of course, you can
# also load them from file if you already have annotation files available.
library(biomaRt)
ensembl <- useMart('ENSEMBL_MART_ENSEMBL', host='may2012.archive.ensembl.org',

dataset='rnorvegicus_gene_ensembl')

genes <- getBM(attributes=c('ensembl_gene_id', 'chromosome_name', 'start_position',

'end_position', 'strand', 'external_gene_id',
'gene_biotype'),

mart=ensembl)

14

The chromstaR user’s guide

# Transform to GRanges for easier handling
genes <- GRanges(seqnames=paste0('chr',genes$chromosome_name),

ranges=IRanges(start=genes$start, end=genes$end),
strand=genes$strand,
name=genes$external_gene_id, biotype=genes$gene_biotype)

seqlevels(genes)[seqlevels(genes)=='chrMT'] <- 'chrM'
print(genes)

ranges strand |

name
<Rle> | <character>

seqnames
<Rle>
chr13
chr13
chr13
chr13
chr13
...

## GRanges object with 29516 ranges and 2 metadata columns:
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
[29512]
[29513]
[29514]
[29515]
[29516]
-------
seqinfo: 22 sequences from an unspecified genome; no seqlengths

<IRanges>
[1120899, 1121213]
[1192186, 2293551]
[3174383, 3175216]
[4377731, 4379174]
[4866302, 4866586]
...
chr6 [134310258, 134310338]
6921049]
chr9 [
40073816]
chr2 [233090372, 233090478]
92917541]
chr6 [ 92917449,

biotype
<character>
LOC682397 protein_coding
- |
LOC304725 protein_coding
- |
+ |
pseudogene
- | D3ZPH4_RAT protein_coding
- | F1LZC7_RAT protein_coding
...
snoRNA
snRNA
snoRNA
snRNA
miRNA

...
SNORD113
U1
SNORD19B
U6

6920889,
chr11 [ 40073746,

... .
+ |
- |
- |
- |
+ |

# We expect promoter [H3K4me3] and bivalent-promoter signatures [H3K4me3+H3K27me3]
# to be enriched at transcription start sites.
plots <- plotEnrichment(hmm=model, annotation=genes, region='start')
plots[['BN']] + facet_wrap(~ combination) +
ggtitle('Fold enrichment around TSS') +
xlab('distance from TSS')

plots <- plotEnrichment(hmm=model, annotation=genes, region='start', what='peaks')
plots[['BN']] + facet_wrap(~ mark) +

ggtitle('Fold enrichment around TSS') +
xlab('distance from TSS')

15

[H3K4me3][][H3K27me3+H3K4me3][H3K27me3]−10000−50000500010000−10000−500005000100000101distance from TSSlog(observed/expected)combination[H3K27me3+H3K4me3][H3K27me3][H3K4me3][]Fold enrichment around TSSH3K27me3H3K4me3−10000−50000500010000−10000−500005000100000.00.51.01.5distance from TSSlog(observed/expected)markH3K27me3H3K4me3Fold enrichment around TSSThe chromstaR user’s guide

# Fold enrichment with different biotypes, showing that protein coding genes are
# enriched with (bivalent) promoter combinations [H3K4me3] and [H3K4me3+H3K27me3],
# while rRNA is enriched with the empty [] combination.
tss <- resize(genes, width = 3, fix = 'start')
biotypes <- split(tss, tss$biotype)
plots <- plotFoldEnrichHeatmap(model, annotations=biotypes)
plots[['BN']] + coord_flip() +

ggtitle('Fold enrichment with different biotypes')

5

Output of function Chromstar()

Chromstar() is the workhorse of the chromstaR package and produces all the ﬁles that are
necessary for downstream analyses. Here is an explanation of the ﬁles and folders you will
ﬁnd in your outputfolder:

• chrominfo.tsv :

A tab-separated ﬁle with chromosome lengths.

• chromstaR.conﬁg:

A text ﬁle with all the parameters that were used to run function Chromstar().

• experiment_table.tsv :

A tab-separated ﬁle of your experiment setup.

• binned:

RData ﬁles with the results of the binnig step. Contains GRanges objects with binned
genomic coordinates and read counts.

• BROWSERFILES:

Bed ﬁles for upload to the UCSC genome browser. It contains ﬁles with combinatorial
!!Al-
states (“_combinations.bed.gz”) and underlying peak calls (“_peaks.bed.gz”).
ways check the “_peaks.bed.gz” ﬁles if you are satisﬁed with the peak calls.
If not,
there are ways to make the calls stricter (see section 6.1).

• →combined←:

RData ﬁles with the combined results of the uni- and multivariate peak calling steps.
This is what you want to use for downstream analyses. Contains combinedMultiHMM
objects.

• combined_mode-separate.RData Simple combination of peak calls (replicates con-

sidered) without multivariate analysis.

16

[H3K27me3+H3K4me3][H3K27me3][H3K4me3][]Mt_rRNAMt_tRNAmiRNAmisc_RNAprotein_codingpseudogenerRNAretrotransposedsnRNAsnoRNAannotationcombination−6−3036log(observed/expected)Fold enrichment with different biotypesThe chromstaR user’s guide

• combined_mode-combinatorial.RData Combination of multivariate results for mode=’combinatorial’.

• combined_mode-diﬀerential.RData Combination of multivariate results for mode=’diﬀerential’.

• combined_mode-full.RData Combination of multivariate results for mode=’full’.

• multivariate:

RData ﬁles with the results of the multivariate peak calling step. Contains multiHMM
objects.

• PLOTS:

Several plots that are produced by default. Please check the plots in subfolder univariate-
distributions for irregularities (see section 3).

• replicates:

RData ﬁles with the result of the replicate peak calling step. Contains multiHMM
objects.

• univariate:

RData ﬁles with the result of the univariate peak calling step. Contains uniHMM
objects.

6

6.1

FAQ

The peak calls are too lenient. Can I adjust the strictness of
the peak calling?

The strictness of the peak calling can be controlled with a false discovery rate. The Hidden
Markov Model gives posterior probabilities for each peak, and based on these probabilites the
model decides if a peak is present or not by picking the state with the highest probability.
This way of peak calling leads to very lenient peak calls, and for some applications it may be
desirable to obtain only very clear peaks. This can be achieved by setting a false discovery
rate (which is a cutoﬀ on the maximum posterior probability within each peak). To follow
the below example, please ﬁrst run step 1 and 2 from section 4.4.

model <- get(load(file.path(outputfolder,'combined',

'combined_mode-differential.RData')))

# Set a strict cutoff close to 1
model2 <- changeFDR(model, fdr=1e-4)
## Compare the number and width of peaks before and after cutoff adjustment
length(model$segments); mean(width(model$segments))

## [1] 4427
## [1] 10567.43

length(model2$segments); mean(width(model2$segments))

## [1] 3426
## [1] 13654.99

It is even possible to adjust the false discovery rate diﬀerently for the diﬀerent marks or
conditions.

# Set a stricter cutoff for H3K4me3 than for H3K27me3
fdrs <- c(0.1, 0.1, 0.1, 0.1, 0.01, 0.01, 0.01, 0.01)
names(fdrs) <- model$info$ID
print(fdrs)

##
##
##

H3K27me3-BN-rep1
0.10
H3K4me3-SHR-rep1

H3K27me3-BN-rep2
0.10
H3K4me3-SHR-rep2

H3K4me3-BN-rep1
0.10

H3K4me3-BN-rep2 H3K27me3-SHR-rep1 H3K27me3-SHR-rep2
0.01

0.10

0.01

17

The chromstaR user’s guide

##

0.01

0.01

model2 <- changeFDR(model, fdr=fdrs)
## Compare the number and width of peaks before and after cutoff adjustment
length(model$segments); mean(width(model$segments))

## [1] 4427
## [1] 10567.43

length(model2$segments); mean(width(model2$segments))

## [1] 4133
## [1] 11319.14

6.2

The combinatorial differences that chromstaR gives me are
not convincing. Is there a way to restrict the results to a more
convincing set?

You were interested in combinatorial state diﬀerences as in section 4.4 and checked the results
in a genome browser. You found that some diﬀerences are convincing by eye and some are
not. There are several possibilities to explore:

1. Run Chromstar in mode=’diﬀerential’ (instead of mode=’combinatorial’) and see if the

results improve.

2. You can play with the “diﬀerential.score” (see section 4.4, step 3) and export only
diﬀerences with a high score. A diﬀerential score around 1 means that one modiﬁcation
is diﬀerent, a score close to 2 means that two modiﬁcations are diﬀerent etc. The score
is calculated as the sum of diﬀerences in posterior probabilities between marks.

3. Set a strict false discovery rate (previous example) to obtain only high conﬁdence peaks.

4. Check for bad replicates that are very diﬀerent from the rest and exclude them prior to

the analysis.

6.3

How do I plot a simple heatmap with the combinations?

heatmapCombinations(marks=c('H3K4me3', 'H3K27me3', 'H3K36me3', 'H3K27Ac'))

18

H3K4me3H3K27me3H3K36me3H3K27Ac[H3K27Ac][H3K27me3+H3K27Ac][H3K27me3+H3K36me3+H3K27Ac][H3K27me3+H3K36me3][H3K27me3][H3K36me3+H3K27Ac][H3K36me3][H3K4me3+H3K27Ac][H3K4me3+H3K27me3+H3K27Ac][H3K4me3+H3K27me3+H3K36me3+H3K27Ac][H3K4me3+H3K27me3+H3K36me3][H3K4me3+H3K27me3][H3K4me3+H3K36me3+H3K27Ac][H3K4me3+H3K36me3][H3K4me3][]combinationmarkThe chromstaR user’s guide

6.4

Examples of problematic distributions.

For the chromstaR peak calling to work correctly it is essential that the Baum-Welch algo-
rithm correctly identiﬁes unmodiﬁed (background) and modiﬁed (signal/peak) components
in the data. Therefore, you should always check the plots in folder PLOTS/univariate-
distributions for correct convergence. Here are some plots that indicate failed and succesful
ﬁtting procedures:

The plot shows data for H3K27me3 at binsize 1000bp. (a) Incorrectly converged ﬁt, where the
modiﬁed component (red) has lower read counts than the unmodiﬁed component (gray).
(b) Correctly converged ﬁt. Even here, the ﬁt could be improved by reducing the average
number of reads per bin, either by selecting a smaller binsize or by downsampling the data
before using chromstaR.

The plot shows data for H3K27me3 at binsize 150bp. (a) Incorrectly converged ﬁt, where
the modiﬁed component (red) has a higher density at zero reads than the unmodiﬁed
component (gray). (b) Correctly converged ﬁt.

7

Session Info

toLatex(sessionInfo())

• R version 3.4.2 (2017-09-28), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8, LC_COLLATE=C, LC_MONETARY=en_US.UTF-8,

LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Running under: Ubuntu 16.04.3 LTS

• Matrix products: default

19

0.0000.0050.0100.0150.0200100200300read countdensitycomponentsunmodified, mean=136.56, var=1876.47, weight=0.75modified, mean=67.46, var=2529.8, weight=0.25total, mean(data)=113.05, var(data)=3466.91WRONGa0.0000.0050.0100.0150.0200100200300read countdensitycomponentsunmodified, mean=71.23, var=3221.61, weight=0.28modified, mean=134.18, var=1789.86, weight=0.72total, mean(data)=113.05, var(data)=3466.91CORRECTb0.00.20.405101520read countdensitycomponentsunmodified, mean=3.28, var=6.24, weight=0.53modified, mean=0.66, var=2.57, weight=0.47total, mean(data)=1.53, var(data)=5.45WRONGa0.00.20.405101520read countdensitycomponentsunmodified, mean=0.65, var=2.6, weight=0.61modified, mean=3.3, var=6.4, weight=0.39total, mean(data)=1.53, var(data)=5.45CORRECTbThe chromstaR user’s guide

• BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so

• LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

• Base packages: base, datasets, grDevices, graphics, methods, parallel, stats, stats4, utils

• Other packages: BiocGenerics 0.24.0, GenomeInfoDb 1.14.0, GenomicRanges 1.30.0, IRanges 2.12.0,

S4Vectors 0.16.0, biomaRt 2.34.0, chromstaR 1.4.0, chromstaRData 1.3.0, ggplot2 2.2.1

• Loaded via a namespace (and not attached): AnnotationDbi 1.40.0, Biobase 2.38.0, BiocParallel 1.12.0,

BiocStyle 2.6.0, Biostrings 2.46.0, DBI 0.7, DelayedArray 0.4.0, GenomeInfoDbData 0.99.1,
GenomicAlignments 1.14.0, Matrix 1.2-11, R6 2.2.2, RCurl 1.95-4.8, RSQLite 2.0, Rcpp 0.12.13, Rsamtools 1.30.0,
SummarizedExperiment 1.8.0, XML 3.98-1.9, XVector 0.18.0, assertthat 0.2.0, backports 1.1.1, bamsignals 1.10.0,
bit 1.1-12, bit64 0.9-7, bitops 1.0-6, blob 1.1.0, codetools 0.2-15, colorspace 1.3-2, compiler 3.4.2, digest 0.6.12,
doParallel 1.0.11, evaluate 0.10.1, foreach 1.4.3, grid 3.4.2, gtable 0.2.0, highr 0.6, htmltools 0.3.6, iterators 1.0.8,
knitr 1.17, labeling 0.3, lattice 0.20-35, lazyeval 0.2.1, magrittr 1.5, matrixStats 0.52.2, memoise 1.1.0,
munsell 0.4.3, mvtnorm 1.0-6, plyr 1.8.4, prettyunits 1.0.2, progress 1.1.2, reshape2 1.4.2, rlang 0.1.2,
rmarkdown 1.6, rprojroot 1.2, scales 0.5.0, stringi 1.1.5, stringr 1.2.0, tibble 1.3.4, tools 3.4.2, yaml 2.1.14,
zlibbioc 1.24.0

20

