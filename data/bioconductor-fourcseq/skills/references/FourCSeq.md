FourCSeq analysis workﬂow

Felix A. Klein

European Molecular Biology Laboratory (EMBL),
Heidelberg, Germany
felix.klein@embl.de

October 27, 2020

Contents

1

2

3

4

5

6

7

8

Introduction .

.

Preprocessing.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Initialization of the FourC object

Fragment reference .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

4.1

4.2

Adding the viewpoint information .

Adding the viewpoint information manually .

Counting reads at fragment ends .

Detecting interactions .

Detecting differences.

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

1

2

2

5

6

7

7

11

14

18

1

Introduction

This vignette shows an example workﬂow of a 4C sequencing analysis. In an typical setting 4C
sequencing data has been generated for diﬀerent viewpoints in several replicates of multiple
conditions. We focus on the analysis of a subset of the data which was recently published
[1]. The data set comprises one viewpoint in replicates of 3 conditions.

For further information on the underlying method and if you use FourCSeq
in published research please consult and cite:

Felix A. Klein, Simon Anders, Tibor Pakozdi, Yad Ghavi-Helm, Eileen E. M. Furlong, Wolfgang Huber
FourCSeq: Analysis of 4C sequencing data
Bioinformatics (2015). doi:10.1093/bioinformatics/btv335 [2]

FourCSeq analysis workﬂow

2

Preprocessing

The analysis with FourCSeq starts from binary alignment/map (BAM)-ﬁles.
If you already
have seperate bam ﬁles for each viewpoint you can skip this section, which shows a possible
way how to generate these bam ﬁles.

Usually many viewpoints are multiplexed in one sequencing lane. To demultiplex or just trim
oﬀ the primer sequence the FourCSeq contains the python script "demultiplex.py" in the
folder "extdata/python". To run the python script you have to install the HTSeq python
package (http://www-huber.embl.de/users/anders/HTSeq/doc/install.html).

Then you can run the command:

python pathToScriptFile/demultiplex.py --fastq YourFASTQFile --barcode YourBarcodeFile

The barcode ﬁle is a FASTA ﬁle containing the primer sequences that have been used to
generate the 4C library. The read starts are matched against these sequences and if a unique
match is found the primer sequence is trimmed and the remaining read is saved in a FASTQ
ﬁle with the viewpoint name attached to the original ﬁle name, e.g.
for the FASTQ input
4c_library.fastq and a primer sequence named "viewpoint1" in the primer FASTA ﬁle, the
script will generate the output ﬁle 4c_library_viewpoint1.fastq for reads matching to the
"viewpoint1" primer sequence.

Here is an example content of a primer FASTA ﬁle, containing one sequence for the "testdata"
viewpoint:

>testdata

ATTTTCTCATCCATATAAATACTA

For additional parameters that can be passed to demulitiplex.py have a look at the help
documentation of the python script by running:

python pathToScriptFile/demultiplex.py --help

If you don’t know where the python script in the package is installed use the following
command in R.

system.file("extdata/python/demultiplex.py", package="FourCSeq")

After demultiplexing the ﬁles can be aligned with standard alignment software generating
bam output.

3

Initialization of the FourC object

As ﬁrst step we need to load the required libraries.

library(FourCSeq)

## Warning: Package ’FourCSeq’ is deprecated and will be removed from

##

Bioconductor version 3.13

To start the analysis we need to make a FourC object. The FourC object is created from a list
metadata containing information about the experiment and a DataFrame colData containing
information about the samples. We now look at this in more detail.

2

FourCSeq analysis workﬂow

For metadata the following information is required:

1. projectPath, directory where the project will be saved.

2. fragmentDir, subdirectory of the project directory where to save the information about

restriction fragments.

3. referenceGenomePath, path to the FASTA ﬁle of the reference genome or a BSgenome

object.

4. reSequence1 and reSequence2, restriction enzyme recognition sequence of the ﬁrst and

second restriction enzyme used in the 4C protocol, respectively.

5. primerFile, path to a FASTA ﬁle containing the primer sequences of the viewpoints
used for preparing the 4C libraries (names of the primer have to match the names of
the viewpoints provided in colData).

6. bamFilePath, path to a directory where the bam ﬁles are stored.

For demonstration purposes example ﬁles of the ap viewpoint, containing only a small region
of the ﬁrst 6900 bases on chromosome chr2L of the dm3 Drosophila genome, are saved in
the FourCSeq package. Later on we load a processed (FourC) object that contains the whole
data for chr2L and chr2R (chr2R is the viewpoint chromosome of the ap example viewpoint).
We get the path to these ﬁles using the system.file function. For your own data you have
to adjust the ﬁle path to the directory where your ﬁles are stored.

referenceGenomeFile = system.file("extdata/dm3_chr2L_1-6900.fa",

package="FourCSeq")

referenceGenomeFile

## [1] "/tmp/Rtmpa3mJXe/Rinst17582345e030/FourCSeq/extdata/dm3_chr2L_1-6900.fa"

bamFilePath = system.file("extdata/bam",

package="FourCSeq")

bamFilePath

## [1] "/tmp/Rtmpa3mJXe/Rinst17582345e030/FourCSeq/extdata/bam"

primerFile = system.file("extdata/primer.fa",

package="FourCSeq")

primerFile

## [1] "/tmp/Rtmpa3mJXe/Rinst17582345e030/FourCSeq/extdata/primer.fa"

We also take a look at the content of the primer ﬁle.

writeLines(readLines(primerFile))

>testdata

ATTTTCTCATCCATATAAATACTA

The primer ﬁle contains one sequence, namely for the "ap" viewpoint.

Next we create metadata using "exampleData" as directory for the projectPath and the two
restriction enzyme cutting sequences of DpnII (GATC) and NlaIII (CATG) that were used in
the experiment.

3

FourCSeq analysis workﬂow

metadata <- list(projectPath = "exampleData",
fragmentDir = "re_fragments",
referenceGenomeFile = referenceGenomeFile,

reSequence1 = "GATC",

reSequence2 = "CATG",

primerFile = primerFile,

bamFilePath = bamFilePath)

metadata

## $projectPath

## [1] "exampleData"

##

## $fragmentDir
## [1] "re_fragments"
##

## $referenceGenomeFile
## [1] "/tmp/Rtmpa3mJXe/Rinst17582345e030/FourCSeq/extdata/dm3_chr2L_1-6900.fa"
##

## $reSequence1

## [1] "GATC"

##

## $reSequence2

## [1] "CATG"

##

## $primerFile

## [1] "/tmp/Rtmpa3mJXe/Rinst17582345e030/FourCSeq/extdata/primer.fa"

##

## $bamFilePath

## [1] "/tmp/Rtmpa3mJXe/Rinst17582345e030/FourCSeq/extdata/bam"

After creating metadata we now look at colData

For each library the following information has to be provided to colData:

1. viewpoint, name of the viewpoint (has to match the viewpoint names in the provided

primer ﬁle in metadata).

2. condition, experimental condition.

3. replicate, replicate number.

4. bamFile, ﬁle name of the bam ﬁle.

5. sequencingPrimer, was the 4C library sequenced from the side of the ﬁrst restriction

enzyme cutting site or the second. The allowed values are "ﬁrst" or "second"

colData <- DataFrame(viewpoint = "testdata",

condition = factor(rep(c("WE_68h", "MESO_68h", "WE_34h"),

each=2),

levels = c("WE_68h", "MESO_68h", "WE_34h")),

replicate = rep(c(1, 2),

3),

bamFile = c("CRM_ap_ApME680_WE_6-8h_1_testdata.bam",
"CRM_ap_ApME680_WE_6-8h_2_testdata.bam",
"CRM_ap_ApME680_MESO_6-8h_1_testdata.bam",

4

FourCSeq analysis workﬂow

"CRM_ap_ApME680_MESO_6-8h_2_testdata.bam",
"CRM_ap_ApME680_WE_3-4h_1_testdata.bam",
"CRM_ap_ApME680_WE_3-4h_2_testdata.bam"),

sequencingPrimer="first")

colData

## DataFrame with 6 rows and 5 columns

viewpoint condition replicate

bamFile sequencingPrimer

<character> <factor> <numeric>

##

##

## 1

## 2

## 3

## 4

## 5

## 6

testdata WE_68h
testdata WE_68h
testdata MESO_68h
testdata MESO_68h
testdata WE_34h
testdata WE_34h

<character>
1 CRM_ap_ApME680_WE_6-..
2 CRM_ap_ApME680_WE_6-..
1 CRM_ap_ApME680_MESO_..
2 CRM_ap_ApME680_MESO_..
1 CRM_ap_ApME680_WE_3-..
2 CRM_ap_ApME680_WE_3-..

<character>

first

first

first

first

first

first

After having the necessary information in the required form, we create the FourC object.

fc <- FourC(colData, metadata)

fc

## class: FourC

## dim: 0 6

## metadata(8): projectPath fragmentDir ... bamFilePath version

## assays(0):

## rownames: NULL

## rowData names(0):
## colnames(6): testdata_WE_68h_1 testdata_WE_68h_2 ...
##

testdata_WE_34h_1 testdata_WE_34h_2

## colData names(5): viewpoint condition replicate bamFile

##

sequencingPrimer

We now have an FourC object that contains all the required metadata.

4

Fragment reference

As the next step the provided reference genome is in-silico digested using the provided restric-
tion enzyme recognition sequences. The resulting fragment reference is stored as rowRanges
of the FourC object.

fc <- addFragments(fc)

fc

## class: FourC

## dim: 2 6

## metadata(8): projectPath fragmentDir ... bamFilePath version

## assays(0):

## rownames: NULL

## rowData names(4): leftSize rightSize leftValid rightValid
## colnames(6): testdata_WE_68h_1 testdata_WE_68h_2 ...

5

FourCSeq analysis workﬂow

##

testdata_WE_34h_1 testdata_WE_34h_2

## colData names(5): viewpoint condition replicate bamFile

##

sequencingPrimer

rowRanges(fc)

## GRanges object with 2 ranges and 4 metadata columns:

##

##

##

##

##

##

seqnames

ranges strand |

leftSize rightSize leftValid rightValid

<Rle> <IRanges> <Rle> | <numeric> <numeric> <logical>

<logical>

[1]

[2]

chr2L 5305-6022

chr2L 6027-6878

* |
* |

160

251

554

597

TRUE

TRUE

TRUE

TRUE

-------

seqinfo: 1 sequence from an unspecified genome

Now the FourC object contains a GRanges object in the rowRanges slot with the information
on the fragments.

By setting save to TRUE in addFragments, the results of the in-silico digestion can be saved
in the provided fragmentDir folder in the project directory, which are both deﬁned in meta
data. The ﬁrst ﬁle (valid_fragments.txt) contains the information for all fragments of the
ﬁrst restriction enzyme in the following columns:

1. Chromosome

2. Fragment start

3. Fragment end

4. Size of the left fragment end

5. Size of the right fragment end

6. Information whether the left fragment end is valid

7. Information whether the right fragment end is valid

The second ﬁle contains the locations of all cutting sites of the second restriction enzyme in
the following columns:

1. Chromosome

2. Cutting site start

3. Cutting site end

Additionally, bedgraph ﬁles (re_sites_Seqeunce1/Sequence2.bed) are produced in the same
folder for displaying the cutting sites in a genome viewer of choice (e.g. IGV or UCSC).

4.1

Adding the viewpoint information

To ﬁnd the viewpoint fragment and extract the genomic position of the viewpoint, the
primers are mapped to the reference genome and fragment reference. Because this can be
time consuming for many sequences the results of findViewpointFragments is saved in the
project directory provided in metadata. In a second step this data is loaded by addViewpoint
Frags and the colData of the FourC object is updated with the corresponding information
of each viewpoint.

6

FourCSeq analysis workﬂow

findViewpointFragments(fc)

fc <- addViewpointFrags(fc)

The mapped primer fragments are also saved in the ﬁle "primerFragments.txt" in the provided
In contains one row per
fragmentDir folder in project directory both deﬁned in metadata.
primer and the following columns:

1. Viewpoint

2. Chromosome

3. Fragment start position

4. Fragment end position

5. Width of the whole fragment

6. Size of the left fragment end

7. Size of the right fragment end

8. Information whether the left fragment end is valid

9. Information whether the right fragment end is valid

10. Primer start position

11. Primer end position

12. Fragment side on which the primer matches

4.2

Adding the viewpoint information manually

If the primer ﬁle is missing, this information can also be added manually. The information has
to contain the viewpoint chromosome name chr, the start position of the viewpoint fragment
start, and its end position end

colData(fc)$chr = "chr2L"

colData(fc)$start = 6027

colData(fc)$end = 6878

5

Counting reads at fragment ends

To ﬁlter out non-informative reads, we use several criteria motivated by the 4C sequencing
In the function countFragmentOverlaps, only reads mapping exactly to the end
protocol.
of a fragment with the correct orientation are counted and assigned to the corresponding
fragment in this step (Figure 1). The counting is strand speciﬁc, taking the orientation of
the reads into account (Figure 1). The count values are stored as matrices in the assays slot
of the FourC object. They are named countsLeftFragEnd and countsRightFragEnd.

If the sequence of the restriction enzyme has not been trimmed in the demultiplexing step
(for viewpoints using a primer of the ﬁrst cutting site) this can be done during the following
step to make sure that reads start at the fragment’s end. In this example case we trim the

7

FourCSeq analysis workﬂow

Figure 1: If the sequencing primer starts at the ﬁrst restriction enzyme cutting site, reads that start
at the fragment ends and are oriented towards the fragment middle are kept for analysis (green ar-
rows)
If the sequencing primer starts at the second restriction enzyme cutting site, reads that start directly next
to the cutting site of the second restriction enzyme and are directed towards the ends of the fragment are
kept for analysis (green arrows).

ﬁrst 4 bases of each read by setting trim to 4 to remove the GATC sequence of the ﬁrst
restriction enzyme. (For the viewpoint primer starting from the second cutting site the reads
can be extended to overlap the cutting site, if the cutting site has been trimmed. In this case
reads are counted with the countFragmentOverlapsSecondCutter function.)

Additionally we ﬁlter out read that have a mapping quality below 30 by setting minMapq to
30.

fc <- countFragmentOverlaps(fc, trim=4, minMapq=30)

## reading bam files

## calculating overlaps

The counts from both fragment end are added by using the function combineFragEnds.

fc <- combineFragEnds(fc)

We take a look at the FourC object and see that it now contains 3 data matrices (called
"assays"): counts, countsLeftFragEnd and countsRightFragEnd These matrices can be ac-
cessed by the assay or assays functions.

library(SummarizedExperiment)

fc

## class: FourC

## dim: 2 6

## metadata(8): projectPath fragmentDir ... bamFilePath version

## assays(3): counts countsLeftFragmentEnd countsRightFragmentEnd

## rownames: NULL

## rowData names(4): leftSize rightSize leftValid rightValid
## colnames(6): testdata_WE_68h_1 testdata_WE_68h_2 ...
##

testdata_WE_34h_1 testdata_WE_34h_2

## colData names(21): viewpoint condition ... mappedReads mappingRatio

assays(fc)

## List of length 3

## names(3): counts countsLeftFragmentEnd countsRightFragmentEnd

8

Assigning aligned sequencing reads to restriction fragmentsviewpointprimerstartingat:ﬁrstcuttersecondcutterFourCSeq analysis workﬂow

head(assay(fc, "counts"))

##

## [1,]

## [2,]

##

## [1,]

## [2,]

testdata_WE_68h_1 testdata_WE_68h_2 testdata_MESO_68h_1
4

13

0

0
testdata_MESO_68h_2 testdata_WE_34h_1 testdata_WE_34h_2
0

0

6

0

0

2

8

0

For the rest of the vignette we now load the dataset of the "ap" viewpoint that was created
for the whole chromosmes 2L and 2R of the dm3 reference genome. We adjust the project
path and look at the FourC object.

data(fc)

metadata(fc)$projectPath

## [1] "pathToProjectFolder"

metadata(fc)$projectPath <- "exampleData"

fc

## class: FourC

## dim: 57253 6

## metadata(7): projectPath fragmentDir ... primerFile bamFilePath

## assays(3): counts countsLeftFragmentEnd countsRightFragmentEnd

## rownames: NULL

## rowData names(4): leftSize rightSize leftValid rightValid
## colnames(6): ap_WE_68h_1 ap_WE_68h_2 ... ap_WE_34h_1 ap_WE_34h_2
## colData names(21): viewpoint condition ... mappedReads mappingRatio

assays(fc)

## List of length 3

## names(3): counts countsLeftFragmentEnd countsRightFragmentEnd

head(assay(fc, "counts"))

##

## [1,]

## [2,]

## [3,]

## [4,]

## [5,]

## [6,]

##

## [1,]

## [2,]

## [3,]

## [4,]

## [5,]

## [6,]

ap_WE_68h_1 ap_WE_68h_2 ap_MESO_68h_1 ap_MESO_68h_2 ap_WE_34h_1
0

13

0

0

4

0

0

3

4

0

0

0

0

0

0

2

0

7

0

3

8

0

19

0

8

6

7

0

0

35
ap_WE_34h_2
0

0

0

23

0

39

We can see, that the dimensions of the object now represent all fragments on chromosmes
2L and 2R of the dm3 reference genome.

9

FourCSeq analysis workﬂow

The content of each assay can be saved as bigWig or bedGraph ﬁles. By default the counts
assay is exported.

writeTrackFiles(fc)

## [1] "Successfully created bw files of the counts data."

writeTrackFiles(fc, format='bedGraph')

## [1] "Successfully created bedGraph files of the counts data."

Because 4C data sometimes contains many spikes due to possible PCR artifacts, the data
can be smoothed for visualization.

fc <- smoothCounts(fc)

## 5 chr2L

## 5 chr2R

fc

## class: FourC

## dim: 57253 6

## metadata(7): projectPath fragmentDir ... primerFile bamFilePath

## assays(4): counts countsLeftFragmentEnd countsRightFragmentEnd

##

counts_5
## rownames: NULL

## rowData names(4): leftSize rightSize leftValid rightValid
## colnames(6): ap_WE_68h_1 ap_WE_68h_2 ... ap_WE_34h_1 ap_WE_34h_2
## colData names(21): viewpoint condition ... mappedReads mappingRatio

We see that after the smoothing step there is a new assay, counts_5, of smoothed values.

Reproducibility between replicates can be assessed using a scatter plot of the count values.
We therefore generate such a scatter plot for two columns of the FourC object.

plotScatter(fc[,c("ap_WE_68h_1", "ap_WE_68h_2")],

xlab="Replicate1", ylab="Replicate2", asp=1)

They show good agreement for higher count values.

10

Replicate1Replicate2heatscatter01101001031041051061070110100103104105106FourCSeq analysis workﬂow

6

Detecting interactions

In the following step the count values are ﬁrst transformed with a variance stabilizing trans-
formation. After this step the variance between replicates no longer depends strongly on the
average count value, thereby allowing a consistent statistical treatment over a wide range of
count values. On these transformed counts, the general decay of the 4C signal with genomic
distance from the viewpoint is ﬁtted using a symmetric monotone ﬁt. The residuals of the
ﬁt are used to calculate z-scores: the z-scores are the ﬁt residuals divided by the median
absolute deviation (MAD) of all the sample’s residuals.

This is done the getZScores function. The data is ﬁltered so that only fragments with a
median count of at least 40 count are kept for the analysis. Also fragments that are close
to the viewpoint, and hence show an extremely high count value are ﬁltered out.
If no
minimum distance from the viewpoint is deﬁned this distance is automatically estimated by
choosing the borders of the initial signal decrease around the viewpoint. For more details and
information about additional parameters that may be speciﬁed for the getZScores function
type ?getZScores.

fcf <- getZScores(fc)

fcf

After calling getZScores, a new FourC object is returned that has been ﬁltered to contain
It also contains
only fragments that were kept for analysis according to the above criteria.
additional information added by the getZScores function (see ?getZScores for details).

We take a look at the distribution of z-scores, which are stored in the assay "zScores" of the
FourC object.

zScore <- SummarizedExperiment::assay(fcf, "zScore")

hist(zScore[,"ap_MESO_68h_1"], breaks=100)
hist(zScore[,"ap_MESO_68h_2"], breaks=100)

11

Histogram of zScore[, "ap_MESO_68h_1"]zScore[, "ap_MESO_68h_1"]Frequency−8−6−4−2024050100150Histogram of zScore[, "ap_MESO_68h_2"]zScore[, "ap_MESO_68h_2"]Frequency−4−2024020406080FourCSeq analysis workﬂow

For the second replicate two peaks are observed in the histogram. The peak close to -2 is
due to fragments with 0 counts in the second library, which has a lower coverage. Since we
are interested in ﬁnding strong interactions on the positive side of the distribution, we can
continue and capture the strongest contacts. However, if the inﬂuence of low values would
further shift the distribution to negative values this might lead to errors in the calculation
of z-scores. It is therefore important to check the distribution of values after calculating the
z-scores.

In the next plots we check, whether normal assumption for calculating the p-values is justiﬁed.

qqnorm(zScore[,"ap_MESO_68h_1"],

main="Normal Q-Q Plot - ap_MESO_68h_1")

abline(a=0, b=1)
qqnorm(zScore[,"ap_MESO_68h_2"],

main="Normal Q-Q Plot - ap_MESO_68h_2")

abline(a=0, b=1)

As we see the approximation is satisfactory in general, even for the second replicate for which
alredy observed deviations in the histogram.

Using a conservative approach, we deﬁne interacting regions with the following thresholds:
a fragment must have z-scores larger than 3 for both replicates and an adjusted p-value of
0.01 for at least one replicate. The call to addPeaks adds a new assay to the FourC object
that contains booleans indicating whether an interaction has been called for a fragment or
not.

fcf <- addPeaks(fcf, zScoreThresh=3, fdrThresh=0.01)

head(SummarizedExperiment::assay(fcf, "peaks"))

##

## [1,]

## [2,]

## [3,]

## [4,]

## [5,]

ap_WE_68h_1 ap_WE_68h_2 ap_MESO_68h_1 ap_MESO_68h_2 ap_WE_34h_1
FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

12

−3−2−10123−8−6−4−2024Normal Q−Q Plot − ap_MESO_68h_1Theoretical QuantilesSample Quantiles−3−2−10123−4−2024Normal Q−Q Plot − ap_MESO_68h_2Theoretical QuantilesSample QuantilesFourCSeq analysis workﬂow

## [6,]

##

## [1,]

## [2,]

## [3,]

## [4,]

## [5,]

## [6,]

FALSE
ap_WE_34h_2
FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

Next we take a look at the ﬁt for the ﬁrst sample.

plotFits(fcf[,1], main="")

The points show the count values for the individual fragments. The red line is the ﬁt and
the blue dashed line is the ﬁt plus (z-score threshold)*MAD for the given library, where the
z-score threshold has been deﬁned by the call to addPeaks. If addPeaks has not been called
yet, a default z-score threshold of 2 is used. The ﬁrst plot show the data left of the viewpoint,
the second plot right of the viewpoint and for the last plot both sides have been combined
by using the absolute distance from the viewpoint.

The plotZScores function produces plots to display the results. To include gene annotation,
we load the TxDb.Dmelanogaster.UCSC.dm3.ensGene package that contains transcript infor-
mation for the dm3 genome. It can be passed as an argument to the plotZScores function.

13

Distance from viewpoint [nt]Counts10610510410311010010310478910111213Variance stabilized countsDistance from viewpoint [nt]Counts10310410510610711010010310478910111213Variance stabilized countsDistance from viewpoint [nt]Counts10310410510610711010010310478910111213Variance stabilized countsFourCSeq analysis workﬂow

library(TxDb.Dmelanogaster.UCSC.dm3.ensGene)

plotZScores(fcf[,c("ap_WE_68h_1", "ap_WE_68h_2")],

txdb=TxDb.Dmelanogaster.UCSC.dm3.ensGene)

## [1] "ap"

## Successfully plotted results.

The plot shows the results for two diﬀerent window sizes around the viewpoint. The ﬁt is
shown as green line and the dashed blue lines span the interval of ± (z-score threshold)*MAD,
where the z-score threshold has been deﬁned by the call to addPeaks.
If addPeaks has not
been called yet, a default z-score threshold of 2 is used. Red points represent fragments that
have been called as interactions.

7

Detecting differences

In addition to detecting interactions within a sample, one might be interested in ﬁnding
diﬀerences of interaction frequencies between samples from diﬀerent experimental conditions.

Here we show how to detect diﬀerences between conditions.
In our case the conditions
are whole embryo tissue at 3-4 h and 6-8 h and mesoderm speciﬁc tissue at 6-8 h. The
distance dependence, which varies between viewpoints is taken into account by calculating
normalizationFactors.

fcf <- getDifferences(fcf,

referenceCondition="WE_68h")

## [1] "ap"

fcf

## class: FourC

## dim: 1872 6

14

ap_WE_68h_1681012Count (vst)ap_WE_68h_2681012Count (vst)genes15000001550000160000016500001700000Genomic positionap_WE_68h_1681012Count (vst)ap_WE_68h_2681012Count (vst)genes5000001000000150000020000002500000Genomic positionFourCSeq analysis workﬂow

## metadata(9): projectPath fragmentDir ... parameter peakParameter

## assays(14): counts countsLeftFragmentEnd ... H cooks

## rownames: NULL

## rowData names(39): leftSize rightSize ... deviance maxCooks
## colnames(6): ap_WE_68h_1 ap_WE_68h_2 ... ap_WE_34h_1 ap_WE_34h_2
## colData names(22): viewpoint condition ... mappingRatio sd

After calling getDiﬀerences, the FourC object contains additional
diﬀerential test (see ?getDiﬀerences for details.)

information about the

First we take a look at the dispersion ﬁt calculated in the analysis to check if the ﬁt worked,
especially since a warning was thrown. As we can see the red ﬁt nicely captures the trend
of the black dots. The blue dots are the shrunken dispersion estimates for each fragment
that are used in the diﬀerential test as measure for the variability of the data (see DESeq2
vignette and [3] for details).

plotDispEsts(fcf)

We also take a look at the estimated values of the normalization factors plotted against the
distance from the viewpoint. The horizontal lines represent the size factors of the diﬀerent
libraries.

plotNormalizationFactors(fcf)

Compared to single size factors for the library size correction these values are shifted, especially
in the region close to the viewpoint, where they span a range from approximately 0.3 to 3.

Next we generate an MA plot using the method from the DESeq2 package (for details see
?plotMA and choose DESeq2). The MA plot shows the log fold changes between conditions
plotted over the base mean values across samples. Red dots represent fragments with an
adjusted p-value below the signiﬁcance level of 0.01.

plotMA(results(fcf, contrast=c("condition", "WE_68h", "MESO_68h")),

alpha=0.01,

xlab="Mean 4C signal",

ylab="log2 fold change",

ylim=c(-3.1,3.1))

15

5010020050020005000200001e−081e−041e+00mean of normalized countsdispersiongene−estfittedfinal0.0e+005.0e+061.0e+071.5e+072.0e+070.20.51.02.0Distance from viewpointNormalization Factorap_WE_68h_1ap_WE_68h_2ap_MESO_68h_1ap_MESO_68h_2ap_WE_34h_1ap_WE_34h_2FourCSeq analysis workﬂow

To take a look at the results of the diﬀerential test we use the getAllResults function.

results <- getAllResults(fcf)

dim(results)

## [1] 1872

16

head(results)[,1:6]

## DataFrame with 6 rows and 6 columns

##

##

baseMean log2FoldChange_WE_68h_MESO_68h lfcSE_WE_68h_MESO_68h
<numeric>
<numeric>

<numeric>

## 1

48.2813

## 2

101.0248

## 3

130.6783

## 4

128.7054

56.2178

52.9574

## 5

## 6

##

##

## 1

## 2

## 3

## 4

## 5

## 6

0.400694

1.119898

0.306873

1.074442

1.663595

-1.895854

0.996679

1.139566

0.839177

0.797962

1.207804

1.768157

stat_WE_68h_MESO_68h pvalue_WE_68h_MESO_68h padj_WE_68h_MESO_68h
<numeric>

<numeric>

<numeric>

0.402029

0.982742

0.365684

1.346482

1.377372

-1.072220

0.687663

0.325735

0.714601

0.178147

0.168397

0.283621

0.995040

0.960445

0.995040

0.857785

0.855978

0.948925

The table shows the base mean for the given fragment in the ﬁrst column. Then, for every
combination of conditions, 5 columns are shown. We only look at the results of the ﬁrst
combination by selecting the ﬁrst 6 columns. The second column shows the estimated log2
fold change between the two conditions, the third the estimated standard error of the log2
fold change, the fourth the Wald test statistic, the ﬁfth the corresponding p-value and the
sixth the adjusted p-value.

The results can be visualized by creating plots with the plotDifferences function.

plotDifferences(fcf,

txdb=TxDb.Dmelanogaster.UCSC.dm3.ensGene,

plotWindows = 1e+05,

textsize=16)

## [1] "ap"

16

501002005002000500020000−3−10123Mean 4C signallog2 fold changeFourCSeq analysis workﬂow

## Successfully plotted results.

The plot shows the results for the comparison of the two conditions. The upper two tracks
show the variance stabilized counts of the ﬁrst condition. The ﬁt is shown as green line and
the dashed blue lines span the interval of ± (z-score threshold)*MAD, where the z-score
If addPeaks has not been called yet,
threshold has been deﬁned by the call to addPeaks.
a default z-score threshold of 2 is used. Red points represent fragments that have been
called as interactions, blue points represent points that show signiﬁcant changes between
conditions and orange points fulﬁll both criteria. The ﬁfth track shows a color representation
of diﬀerential interactions. A green bar means that the interaction is stronger in the ﬁrst
condition compared to the second and a red bar represents the opposite case. The log2 fold
changes are shown also on top of a gene model track (lower panel).

We now integrate the results with known gene annotation for the apterous (ap) gene, which is
the closest gene contacted by the viewpoint. We extract the log2 fold change of the signal at
the ap promoter. The ﬂybase gene id of the ap gene is "FBgn0000099". The genes function
return a GRanges object with the genomic coordinates of the gene.

apId <- "FBgn0000099"

apGene <- genes(TxDb.Dmelanogaster.UCSC.dm3.ensGene,

filter=list(gene_id=apId))

apGene

## GRanges object with 1 range and 1 metadata column:

##

##

##

##

##

seqnames

<Rle>

<IRanges>

ranges strand |

gene_id
<Rle> | <character>

FBgn0000099

chr2R 1593707-1614335

- | FBgn0000099

-------

seqinfo: 15 sequences (1 circular) from dm3 genome

The promoters function extends the transcription start site (TSS) in both directions and
returns a GRanges object with the resulting genomic coordinates.

17

ap_WE_68h_181012Count (vst)ap_WE_68h_281012Count (vst)ap_MESO_68h_1810121416Count (vst)ap_MESO_68h_268101214Count (vst)−50510log2 fold changegenes15000001550000160000016500001700000Genomic positionFourCSeq analysis workﬂow

apPromotor <- promoters(apGene, upstream = 500, downstream=100)

apPromotor

## GRanges object with 1 range and 1 metadata column:

##

##

##

##

##

seqnames

<Rle>

<IRanges>

ranges strand |

gene_id
<Rle> | <character>

FBgn0000099

chr2R 1614236-1614835

- | FBgn0000099

-------

seqinfo: 15 sequences (1 circular) from dm3 genome

We now want to ﬁnd the results for the fragment that overlaps with the ap promoter.
Therefore we get the genomic coordinates of the fragments stored in the FourC object with
rowRanges and ﬁnd the overlap with findOverlaps.

frags <- rowRanges(fcf)

if(length(frags) != nrow(results))

stop("Number of rows is not the same for the fragment data and results table.")

ov <- findOverlaps(apPromotor, frags)

ov

## Hits object with 1 hit and 0 metadata columns:

##

##

##

##

##

queryHits subjectHits

<integer>

<integer>

[1]

-------

1

743

queryLength: 1 / subjectLength: 1872

The overlap shows which fragments (subjectHits) overlaps the ap promoter (queryHits).

Finally we look at the results of the fragment overlapping the ap promoter by subsetting
results using the subjectHits function and look only at the ﬁrst comparison of 6-8h whole
embryo and mesoderm speciﬁc tissue.

results[subjectHits(ov),1:6]

## DataFrame with 1 row and 6 columns

##

##

baseMean log2FoldChange_WE_68h_MESO_68h lfcSE_WE_68h_MESO_68h
<numeric>
<numeric>

<numeric>

## 1

13899.7

-1.177

0.111986

##

##

## 1

stat_WE_68h_MESO_68h pvalue_WE_68h_MESO_68h padj_WE_68h_MESO_68h
<numeric>

<numeric>

<numeric>

-10.5103

7.7463e-26

1.45011e-22

We can see that from comparison of these conditions that there is a signiﬁcant log2 fold
change of -1.1769997.

8

Session Info

18

FourCSeq analysis workﬂow

sessionInfo()

## R version 4.0.3 (2020-10-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.5 LTS

##

## Matrix products: default

## BLAS:

/home/biocbuild/bbs-3.12-bioc/R/lib/libRblas.so

## LAPACK: /home/biocbuild/bbs-3.12-bioc/R/lib/libRlapack.so

##

## locale:

##

##

##

##

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##

## attached base packages:

[1] parallel stats4

splines

stats

graphics

grDevices utils

[8] datasets methods

base

##

##

##

## other attached packages:

##

##

##

##

##

##

##

##

[1] TxDb.Dmelanogaster.UCSC.dm3.ensGene_3.2.2
[2] GenomicFeatures_1.42.0
[3] AnnotationDbi_1.52.0
[4] FourCSeq_1.24.0
[5] ggplot2_3.3.2
[6] DESeq2_1.30.0
[7] SummarizedExperiment_1.20.0
[8] Biobase_2.50.0
[9] MatrixGenerics_1.2.0

##
## [10] matrixStats_0.57.0
## [11] GenomicRanges_1.42.0
## [12] GenomeInfoDb_1.26.0
## [13] IRanges_2.24.0
## [14] S4Vectors_0.28.0
## [15] BiocGenerics_0.36.0
## [16] LSD_4.1-0
##

## loaded via a namespace (and not attached):

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

[1] colorspace_1.4-1
[3] biovizBase_1.38.0
[5] XVector_0.30.0
[7] dichromat_2.0-0
[9] farver_2.0.3
[11] xml2_1.3.2
[13] ggbio_1.38.0
[15] knitr_1.30
[17] Rsamtools_2.6.0
[19] dbplyr_1.4.4

ellipsis_0.3.1
htmlTable_2.1.0
base64enc_0.1-3
rstudioapi_0.11
bit64_4.0.5
codetools_0.2-16
geneplotter_1.68.0
Formula_1.2-4
annotate_1.68.0
cluster_2.1.0

19

FourCSeq analysis workﬂow

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

RBGL_1.66.0

graph_1.68.0
compiler_4.0.3
backports_1.1.10
Matrix_1.2-18
htmltools_0.5.0
tools_4.0.3
glue_1.4.2
reshape2_1.4.4
rappdirs_0.3.1
vctrs_0.3.4
rtracklayer_1.50.0
stringr_1.4.0
ensembldb_2.14.0
XML_3.99-0.5
scales_1.1.1
BiocStyle_2.18.0

[21] png_0.1-7
[23] BiocManager_1.30.10
[25] httr_1.4.2
[27] assertthat_0.2.1
[29] lazyeval_0.2.2
[31] prettyunits_1.1.1
[33] gtable_0.3.0
[35] GenomeInfoDbData_1.2.4
[37] dplyr_1.0.2
[39] Rcpp_1.0.5
[41] Biostrings_2.58.0
[43] xfun_0.18
[45] lifecycle_0.2.0
[47] gtools_3.8.2
[49] zlibbioc_1.36.0
[51] BSgenome_1.58.0
[53] VariantAnnotation_1.36.0 ProtGenerics_1.22.0
[55] hms_0.5.3
[57] AnnotationFilter_1.14.0 RColorBrewer_1.1-2
[59] curl_4.3
[61] memoise_1.1.0
[63] biomaRt_2.46.0
[65] reshape_0.8.8
[67] stringi_1.5.3
[69] highr_0.8
[71] checkmate_2.0.0
[73] rlang_0.4.8
[75] bitops_1.0-6
[77] fda_5.1.5.1
[79] purrr_0.3.4
[81] GenomicAlignments_1.26.0 htmlwidgets_1.5.2
tidyselect_1.1.0
[83] bit_4.0.4
plyr_1.8.6
[85] GGally_2.0.0
R6_2.4.1
[87] magrittr_1.5
Hmisc_4.4-1
[89] generics_0.0.2
DBI_1.1.0
[91] DelayedArray_0.16.0
foreign_0.8-80
[93] pillar_1.4.6
survival_3.2-7
[95] withr_2.3.0
nnet_7.3-14
[97] RCurl_1.98-1.2
crayon_1.3.4
[99] tibble_3.0.4
##
BiocFileCache_1.14.0
## [101] OrganismDbi_1.32.0
jpeg_0.1-8.1
## [103] rmarkdown_2.5
locfit_1.5-9.4
## [105] progress_1.2.2
data.table_1.13.2
## [107] grid_4.0.3
digest_0.6.27
## [109] blob_1.2.1
openssl_1.4.3
## [111] xtable_1.8-4
askpass_1.1
## [113] munsell_0.5.0

yaml_2.2.1
gridExtra_2.3
rpart_4.1-15
latticeExtra_0.6-29
RSQLite_2.2.1
genefilter_1.72.0
BiocParallel_1.24.0
pkgconfig_2.0.3
evaluate_0.14
lattice_0.20-41
labeling_0.4.2

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

20

FourCSeq analysis workﬂow

References

[1] Yad Ghavi-Helm, Felix a. Klein, Tibor Pakozdi, Lucia Ciglar, Daan Noordermeer,
Wolfgang Huber, and Eileen E. M. Furlong. Enhancer loops appear stable during
development and are associated with paused polymerase. Nature, 512(7512):96–100,
July 2014. URL: http://www.nature.com/doiﬁnder/10.1038/nature13417,
doi:10.1038/nature13417.

[2] Felix A. Klein, Tibor Pakozdi, Simon Anders, Yad Ghavi-Helm, Eileen E. M. Furlong,

and Wolfgang Huber. Fourcseq: Analysis of 4c sequencing data. Bioinformatics, 2015.
URL: http://bioinformatics.oxfordjournals.org/content/early/2015/05/30/
bioinformatics.btv335.abstract, arXiv:http://bioinformatics.oxfordjournals.org/
content/early/2015/05/30/bioinformatics.btv335.full.pdf+html,
doi:10.1093/bioinformatics/btv335.

[3] Mike I. Love, Wolfgang Huber, and Simon Anders. Moderated estimation of fold change

and dispersion for RNA-Seq data with DESeq2. bioRxiv preprint, 2014.
doi:10.1101/002832.

21

