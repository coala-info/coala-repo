contiBAIT: Improving Genome Assemblies Using
Strand-seq Data

Kieran O’Neill, Mark Hills and Mike Gottlieb

October 30, 2017

koneill@bcgsc.ca

Contents

1 Licensing

2 Introduction

3 Input

3.1 Creating a chromosome table instance . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . .
3.2 Splitting a chromosome table instance
3.3 Splitting a chromosome table based on strand state changes
. . .
3.4 Creating a strandFreqMatrix instance . . . . . . . . . . . . . . . .

4 Creating a strand state matrix

5 Clustering contigs into chromosomes

6 Ordering contigs within chromosomes

7 Checking order using BAIT ideograms

8 Writing out to a BED ﬁle

9 Additional plotting functions

10 Flow diagram

1

2

2

2
3
3
4
5

7

8

11

13

16

17

19

1 Licensing

Under the Two-Clause BSD License, you are free to use and redistribute this
software.

2

Introduction

Strand-seq is a method for determining template strand inheritance in single
cells. When strand-seq data are collected for many cells from the same organ-
ism, spatially close genomic regions show similar patterns of template strand
inheritance. ContiBAIT allows users to leverage this property to carry out three
tasks to improve draft genomes. Firstly, in assemblies made up entirely of con-
tigs or scaﬀolds not yet assigned to chromosomes, these contigs can be clustered
into chromosomes. Secondly, in assemblies wherein scaﬀolds have been assigned
to chromosomes, but not yet placed on those chromosomes, those scaﬀolds can
be placed in order relative to each other. Thirdly, for assemblies at the chro-
mosome stage, where scaﬀolds are ordered and separated by many unbridged
sequence gaps, the orientation of these sequence gaps can be found.

All three of these tasks can be run in parallel, taking contig-stage assemblies
and ordering all fragments ﬁrst to chromosomes, then within chromosomes while
simultaneously determining the relative orientation of each fragment. This vi-
gnette will outline some speciﬁc functions of contiBAIT, and is comparible to
the contiBAIT() master function included in this package that will perform the
same sequence of function calls outlined below.

3

Input

ContiBAIT requires input in BAM format. Multiple BAM ﬁles are required for
analysis, so ContiBAIT speciﬁcally calls for users to identify a BAM directory
in which to analyse. Sorted BAM ﬁles will speed up analysis.

> # Read in BAM files. Path denotes location of the BAM files.
> # Returns a vector of file locations
>
> library(contiBAIT)
> bamFileList <- list.files(
+ path=file.path(system.file(package=
+ pattern=".bam$",
+ full.names=TRUE)

contiBAIT

extdata

),

),

’

’

’

’

The example data provided by contiBAIT is from a human blood sample and
has been aligned to GRCh38/hg38. Since this assembly is already complete, we
must ﬁrst split this genome into chunks to simulate a contig-stage assembly. To
do this we need to extract information on the assembly the bam ﬁle is aligned
to by creating a chromosome table instance, then splitting this table.

2

3.1 Creating a chromosome table instance

The example data provided with the contiBAIT package is derived from GRCh38/hg38
data (only aligned to all autosomes and allosomes; no alternative locations or
contigs were included). To subset these data, and for further downstream analy-
sis, a GRanges chromosome table instance can be made, representing the contig
name and length. This is generated with makeChrTable, where the resulting
object is similar to the header portion of a BAM ﬁle. Note a meta column
with a name formed of the contig and start and end locations is generated for
downstream workﬂows.

> # build chr table from BAM file in bamFileList
>
> exampleChrTable <- makeChrTable(bamFileList[1])
> exampleChrTable

ChrTable object with 24 ranges and 1 metadata column:

seqnames
<Rle>

ranges strand |
<IRanges> <Rle> |

chr1 [1, 249250621]
chr2 [1, 243199373]
chr3 [1, 198022430]
chr4 [1, 191154276]
chr5 [1, 180915260]
...
chr20 [1, 63025520]
chr21 [1, 48129895]
chr22 [1, 51304566]
chrX [1, 155270560]
chrY [1, 59373566]

[1]
[2]
[3]
[4]
[5]
...
[20]
[21]
[22]
[23]
[24]
-------
seqinfo: 24 sequences from an unspecified genome; no seqlengths

name
<character>
* | chr1:1-249250621
* | chr2:1-243199373
* | chr3:1-198022430
* | chr4:1-191154276
* | chr5:1-180915260
...
* | chr20:1-63025520
* | chr21:1-48129895
* | chr22:1-51304566
* | chrX:1-155270560
* | chrY:1-59373566

... .

...

3.2 Splitting a chromosome table instance

We can also split the above chromosome table instance into 1 Mb fragments.
This subdivision isn’t just for testing purposes. For chromosome- and contig-
stage assemblies with very large fragments, subdividing the data into bins can
help identify chimeric fragments and misorientations. Some assemblies have
a large degree of misorientations or chimerism in the data, and subdividing
them aids in clustering these fragments. For example, if a region is misoriented
within a contig, the strand state will change in this region, skewing this contig
toward a WC call in every library. However, while fragmenting can improve
the overall number of contigs included in analysis and improve clustering, as
the fragments get further subdivided, the number of reads used to make strand
state calls decreases, and the probability of there being insuﬃcient reads to make
an accurate call increases. Note the following divided chromosome table can be

3

used with the ﬁlter argument in strandSeqFreqTable to generate a sub-divided
table.

> exampleDividedChr <- makeChrTable(bamFileList[1], splitBy=1000000)
> exampleDividedChr

ChrTable object with 3089 ranges and 1 metadata column:

seqnames
<Rle>
chr1
chr1
chr1
chr1
chr1
...

ranges strand |
<IRanges> <Rle> |
* |
* |
* |
* |
* |
... .

1, 1001007]
[
[1001008, 2002013]
[2002014, 3003020]
[3003021, 4004026]
[4004027, 5005033]
...
chrY [54341909, 55348239]
chrY [55348240, 56354571]
chrY [56354572, 57360903]
chrY [57360904, 58367234]
chrY [58367235, 59373566]

[1]
[2]
[3]
[4]
[5]
...
[3085]
[3086]
[3087]
[3088]
[3089]
-------
seqinfo: 24 sequences from an unspecified genome; no seqlengths

name
<character>
chr1:1-1001007
chr1:1001008-2002013
chr1:2002014-3003020
chr1:3003021-4004026
chr1:4004027-5005033
...
* | chrY:54341909-55348239
* | chrY:55348240-56354571
* | chrY:56354572-57360903
* | chrY:57360904-58367234
* | chrY:58367235-59373566

3.3 Splitting a chromosome table based on strand state

changes

A change in strand state within a contig can represent a number of things.
At it’s simplest, it could represent a sister chromatid exchange switching the
templates in that particular cell. In cases where the same location is a site of
recurrent strand state changes, the more likely explanation is that the fragment
is chimeric or has a misorientation within it. contiBAIT allows users to cut
contigs at these locations to allow for better clustering. The most likely site of
incorrectly oriented or placed fragments is at unbridged or bridged gap regions.
A function is included that allows us to look for overlaps between recurrent
strand state changes and gap regions.

> library(rtracklayer)
> # Download GRCh38/hg38 gap track from UCSC
> gapFile <- import.bed("http://genome.ucsc.edu/cgi-bin/hgTables?hgsid=465319523_SLOtFPExny48YZFaXBh4sSTzuMcA&boolshad.hgta_printCustomTrackHeaders=0&hgta_ctName=tb_gap&hgta_ctDesc=table+browser+query+on+gap&hgta_ctVis=pack&hgta_ctUrl=&fbQual=whole&fbUpBases=200&fbDownBases=200&hgta_doGetBed=get+BED")
> # Create fake SCE file with four regions that overlap a gap
’
> sceFile <- GRanges(rep(
+ IRanges(c(1410000, 1415000, 1420000, 1425000),
+ c(1430000, 1435000, 1430000, 1435000)))
> overlappingFragments <- mapGapFromOverlap(sceFile,
+ gapFile,
+ exampleChrTable,

chr4

,4),

’

4

+ overlapNum=4)
> show(overlappingFragments)

ChrTable object with 26 ranges and 1 metadata column:

seqnames
<Rle>

ranges strand |
name
<IRanges> <Rle> |
<character>
* |
chr1:1-249250621
* |
chr2:1-243199373
* |
chr3:1-198022430
chr4:1-1429358
* |
* | chr4:1429359-1434206
...
chr20:1-63025520
chr21:1-48129895
chr22:1-51304566
chrX:1-155270560
chrY:1-59373566

[1]
[2]
[3]
[4]
[5]
...
[22]
[23]
[24]
[25]
[26]
-------
seqinfo: 64 sequences from an unspecified genome; no seqlengths

chr1 [
1, 249250621]
chr2 [
1, 243199373]
1, 198022430]
chr3 [
1429358]
1,
chr4 [
1434206]
chr4 [1429359,
...
[1, 63025520]
[1, 48129895]
[1, 51304566]
[1, 155270560]
[1, 59373566]

...
chr20
chr21
chr22
chrX
chrY

... .
* |
* |
* |
* |
* |

What is returned is a GRanges chromosome table instance where the gap
that is coincident with the recurrent strand state change has split that contig
into two smaller fragments. Note the example table now has 25 fragments as
chr4 has been split.

3.4 Creating a strandFreqMatrix instance

To read in BAM ﬁles into ContiBAIT, create a strandFreMatrix instance by
calling strandSeqFreqTable(). This program will read each BAM ﬁle, calculate
the ratio of W and C reads, and return this value along with the total number of
reads used to make the call. Note, we will use the GRanges divided chromosome
table to simultaneously cut the assembly into 1 Mb fragments. By default
duplicate reads are removed, a minimal mapping quality of 0 is used and the
function expects to see paired end data. Because of the way BAM ﬁles store
strand information, it is important to ensure that the pairedEnd parameter
is correctly set. A warning will be issued if single-end data is run as if it is
paired-end.

> # Create a strandFreqTable instance
>
> strandFrequencyList <- strandSeqFreqTable(bamFileList,
+ filter=exampleDividedChr,
+ qual=10,
+ pairedEnd=FALSE,
+ BAITtables=TRUE)

This returns a list of two data.frames if the BAITtables argument is set to
FALSE, or four if it is set to TRUE. The ﬁrst data.frame consists of a strand

5

state frequency, calculated by taking the number of Watson (- strand) reads,
subtracting the number of Crick (+ strand) reads, and dividing by the total
number of reads. These values range from -1 (entirely Watson reads) through
to 1 (entirely Crick reads). The second data.frame consists of the absolute
number of reads covering the contig. This is used in thresholding the data, and
in weighting the accuracy of calls in subsequent orderings. Note that the fewer
reads used to make a strand call, the less accurate that call will be.
In the
absence of background reads, WC regions will follow a binomial distribution.
If we assume any contigs with <-0.8 are WW, and >0.8 are CC (this is the
default strandTableThreshold parameter used in preprocessStrandTable), then
there is a probability of 0.044 that the strand state call is incorrect. As such we
exclude calls that are made with fewer than 10 reads. Increasing this number
will make calls more accurate, but will reduce the number of contigs included in
analysis. Since the contigs are weighted based on read density during clustering,
a minimum of 10 reads to support a strand call provides a good balance between
accuracy and inclusion.

> # Returned list consisting of two data.frames
> strandFrequencyList

$strandTable
A matrix of strand frequencies for 145 contigs over 35 libraries.

$countTable
A matrix of read counts for 145 contigs over 35 libraries.

$WatsonReads
A matrix of read counts for 3089 contigs over 35 libraries.

$CrickReads
A matrix of read counts for 3089 contigs over 35 libraries.

> # Exclude frequencies calculated from
> # contigs with less than 10 reads
>
> exampleStrandFreq <- strandFrequencyList[[1]]
> exampleReadCounts <- strandFrequencyList[[2]]
> exampleStrandFreq[which(exampleReadCounts < 10)] <- NA

Additional information can be found on the help page for strandSeqFre-

qTable including all parameters.

The quality of the libraries, speciﬁcally whether the ﬁles being analysed ap-
pear to show the expected distributions of directional reads, can be assessed
with plotWCdistributions. In a diploid organism, there is an expectation that
chromosomes will be derived from either two Watson homologues, one Watson

6

and one Crick homologue, or two Crick homologues in a Mendelian 1:2:1 ra-
tio. In Strand-seq data, this will mean about 1/4 of the contigs will only have
Watson reads mapping to them, and have a strand state frequency of -1, 1/4
of the contigs will only have Crick reads mapping to them, and have a strand
state frequency of +1, and 1/2 of the contigs will have an approximately even
mix of Watson and Crick reads (based on a binomial distribution of sampling).
plotWCDistribution generates boxplots for diﬀerent strand state frequencies and
models the expected distribution (blue line). The average called WW or CC
contigs are shown in green, and should match closely with the expected distri-
bution line.

> # Assess the quality of the libraries being analysed
> plotWCdistribution(exampleStrandFreq)

4 Creating a strand state matrix

The returned list of strandSeqFreqTable can be converted to a strand state
matrix that makes a contig-wide call on the overall strand state based on the
frequencies of Watson and Crick reads. The function removes BAM ﬁles that
either contain too few reads to make accurate strand calls or are not strand-
seq libraries (i.e. every contig contains approximately equal numbers of + and
- reads). Conversely the function removes contigs that either contain too few
reads, or always contain roughly equal numbers of + and - reads. More details

7

lllllllllllllllllllllllllllllllllllllllllllllllllllll−1−0.8−0.55−0.300.20.40.60.81010203040WC distributions from 35 librarieswith an average of 72 fragmentsWC frequency per contig (W−C)/(W+C)Number of contigsAv. CC contigsAv. WW contigson the parameters can be found in the function documentation. The function
returns a similar data.frame to strandSeqFreqTable, but with the frequencies
converted to strand calls: 1 is a homozygous Watson call (by default, a frequency
less than -0.8, but this can be changed with the ﬁlterThreshold argument), 2
is a heterozygous call (a frequency between -0.8 and 0.8 by default) and 3 is a
homozygous Crick call (by default, a frequency above 0.8). These factors can
then be used to cluster similar contigs together.

> # Convert strand frequencies to strand calls.
>
> exampleStrandStateMatrix <- preprocessStrandTable(
+ exampleStrandFreq,
+ lowQualThreshold=0.8)
> exampleStrandStateMatrix[[1]]

A strand state matrix for 76 contigs over 35 libraries.

5 Clustering contigs into chromosomes

clusterContigs utilizes a custom algorithm to cluster all fragments together that
share a similar strand state across multiple cells. For example, if two contigs are
adjacent on the same chromosome, then they will inherit the same strand state
in every cell that is analyzed. It is important to note however that the relative
directionality of any two fragments within an assembly is unknown. Contigs
which belong on the same chromosome but are in diﬀerent orientations will
display as complete opposites; every library where one contig is homozygous
Watson will have the other contig as homozygous Crick. However, heterozy-
gous contigs (where chromosomes inherited one Watson template and one Crick
template), will not be mirrored, with one contig being ”WC”, while the other
will be ”CW”. As such, by default the function performs clustering between
homozygous calls (WW or CC treated the same) and heterozygous calls (WC)
to identify contigs that belong together despite their misorientation status with
respect to each other. Using the clusterBy=’homo’ option will perform the
clustering just between WW and CC calls (ignoring WC calls) and misoriented
fragments from the same chromosome will cluster into diﬀerent linkage groups.
Once clustered, the misorientated fragments are identiﬁed in each linkage group
using reorientAndMergeLGs. Since chromosome orientation cannot be deter-
mined by sequence alone, the largest sub-group is arbitrarily considered ”+”,
while the smaller group is considered ”-”. The product of this function is a list
where the ﬁrst element is a StrandStateMatrix instance that has been correctly
oriented, the second element is a data.frame of contigs and orientations, and the
third element is a recomputed LinkageGroupList that merges groups that were
previously discordant based on misorientation status. This merger occurs by
computing a consensus strand state across libraries within each linkage group
and comparing them. Note for the purposes of this example, we are using the

8

argument randomise=FALSE to ensure conformity of the vignette when run-
ning sweave. Randomisation is recommended for most applications and is set
to TRUE by default.

> exampleWCMatrix <- exampleStrandStateMatrix[[1]]
> clusteredContigs <- clusterContigs(exampleWCMatrix, randomise=FALSE)
> reorientedMatrix <- reorientAndMergeLGs(clusteredContigs,
+ exampleWCMatrix)
> exampleLGList <- reorientedMatrix[[3]]
> exampleLGList

A linkage group list containing 5 linkage groups.

NumberOfContigs
19
19
19
18
1

1
2
3
4
5

> exampleLGList[[1]]

"chr3:30003399-31003512"
[1] "chr3:3000341-4000453"
[3] "chr3:6000681-7000793"
"chr3:190021525-191021637"
[5] "chr3:160018126-161018239" "chr3:130014728-131014840"
[7] "chr3:150016993-151017106" "chr3:50005665-51005777"
"chr3:10001134-11001246"
[9] "chr3:1000114-2000227"
[11] "chr3:110012462-111012574" "chr3:40004532-41004645"
[13] "chr3:20002267-21002379"
[15] "chr3:170019259-171019371" "chr3:70007931-71008043"
[17] "chr3:120013595-121013707" "chr3:60006798-61006910"
[19] "chr3:80009064-81009176"

"chr3:100011329-101011442"

The clusterContigs function generates a list of linkage groups consisting of
all the clustered contigs. After reorientation and merging, all contigs within the
linkage groups are highly similar, while the contigs between linkage groups are
highly dissimilar. The similarity between linkage groups can be visualized using
plotLGDistances.

> plotLGDistances(exampleLGList, exampleWCMatrix)

9

While the similarity within linkage groups can be visualized using plotLink-
ageGroup (here, the ﬁrst linkage group is used for creating this heatmap). Note,
side by side comparisons of linkage group members can be performs with mul-
tiple lg options (e.g. lg=1:2 will plot the ﬁrst two linkage groups, lg=c(1,4) will
plot the ﬁrst and forth etc.).

> plotLGDistances(exampleLGList, exampleWCMatrix, lg=1)

10

LG4 (18)LG5 (1)LG1 (19)LG3 (19)LG2 (19)LG4 (18)LG5 (1)LG1 (19)LG3 (19)LG2 (19)Distances of 5 linkage groups00.40.8Value024Color Keyand HistogramCount6 Ordering contigs within chromosomes

With contigs clustered to chromosomes, we can then order them within chro-
mosomes. Just as meiotic recombination shuﬄes loci and allows genetic dis-
tances between them to be determined, sister chromatid exchanges (SCE) events
reshuﬄe templates, and similarly allow us to infer a linkage distance. We have
employed a greedy algorithm to do this, but have an argument allowing a TSP
solution as an alternative. Contigs are ordered by similarity across libraries,
then by contig name. Contigs that are zero distance apart (ie have no SCE
events between them and are therefore unordered) are returned in contig name
order. The output is split into sub-linkage groups, so Linkage group 1 will be
split into a number of groups depending on the number of SCE events that occur
within the chromosome. The output will be an S4 object of type contigOrdering.

> contigOrder <- orderAllLinkageGroups(exampleLGList,
+ exampleWCMatrix,
+ exampleStrandFreq,
+ exampleReadCounts,
+ whichLG=1,
+ saveOrdered=TRUE)
> contigOrder[[1]]

11

chr3_4chr3_15chr3_7chr3_5chr3_19chr3_11chr3_14chr3_6chr3_17chr3_10chr3_1chr3_18chr3_16chr3_13chr3_9chr3_3chr3_12chr3_2chr3_8chr3_4chr3_15chr3_7chr3_5chr3_19chr3_11chr3_14chr3_6chr3_17chr3_10chr3_1chr3_18chr3_16chr3_13chr3_9chr3_3chr3_12chr3_2chr3_8Distances of 19 linkage groups00.40.8Value02050Color Keyand HistogramCountA matrix of 1 LGs split into 12 sub-groups from 19 ordered fragments.

LG1.1 LG1.10 LG1.11 LG1.12 LG1.2 LG1.3
3

2

1

1

1

2

...
LG1.4 LG1.5 LG1.6 LG1.7 LG1.8 LG1.9
1

1

1

2

3

1

If the assembly is mostly complete and you wish to compare the actual
location of the fragments in the assembly you’re working with against the output
of orderAllLinkageGroups, contiBAIT has the built in plotContigOrder function.
This assumes that the contig name from the contigOrdering object is in a format
of chr:start-end.

> plotContigOrder(contigOrder[[1]])

12

LG1.3LG1.8LG1.1LG1.10LG1.2LG1.11LG1.12LG1.9LG1.6LG1.7LG1.5LG1.4LG1.3LG1.8LG1.1LG1.10LG1.2LG1.11LG1.12LG1.9LG1.6LG1.7LG1.5LG1.4greedy−ordered LG1 main fragment: chr3 (100%)00.40.8Value01020Color Keyand HistogramCountAlternatively, all contigs can be ordered simultaneously by omitting the
whichLG argument.
If saveOrdered is set to TRUE, plots will be generated
for every linkage group. By ordering all of the linkage groups we can proceed to
create BED ﬁles of these data for the new assemblies.

> contigOrderAll <- orderAllLinkageGroups(exampleLGList,
+ exampleWCMatrix,
+ exampleStrandFreq,
+ exampleReadCounts)
> contigOrderAll[[1]]

A matrix of 5 LGs split into 14 sub-groups from 76 ordered fragments.

LG1.1 LG1.10 LG1.11 LG1.12 LG1.2 LG1.3
3

1

1

1

2

2

...
LG4.5 LG4.6 LG4.7 LG4.8 LG4.9 LG5.1
1

1

3

2

1

1

7 Checking order using BAIT ideograms

It is possible to visually validate the ordering by creating ideogram plots of
the data. The supplied test data comprises of reads from the ﬁrst four chro-
mosomes. Below is example code that will plot the second library from the

13

lllllllllllllllllll0501001502002.55.07.510.012.5contiBAIT predicted location of contigsAssembly ordered location of contigs (Mb)chrlchr3LG1 plot of 19 fragments (12 sub−linkage groups)R−squared = 0.99output of strandSeqFreqTable. Note the third and forth elements of the strand-
FrequencyList are only generated if BAITtables is set to TRUE when running
strandSeqFreqTable. The plot below shows the location of the reads and high-
lights an SCE on chromosome 3. Note to only display the ﬁrst library, we need
to subset the strandReadMatrix and retain these as strandReadMatrix objects.

> # extract elements from strandSeqFreqTable list
> WatsonFreqList <- strandFrequencyList[[3]]
> CrickFreqList <- strandFrequencyList[[4]]
> # subset elements to only analyze one library
> singleWatsonLibrary <- StrandReadMatrix(WatsonFreqList[,2, drop=FALSE])
> singleCrickLibrary <- StrandReadMatrix(CrickFreqList[,2, drop=FALSE])
> # Run ideogram plotter
> ideogramPlot(singleWatsonLibrary,
+ singleCrickLibrary,
+ exampleDividedChr)

If chromosome builds are not complete (and so each contig has not been
assigned a chromosome in the chrTable instance), these ideograms can be plotted
using only the represented fragments in the order given to the function from the
orderedContig object generated from orderAllLinkageGroups. Here we will use
the orderedContig object representing all 4 linkage groups.

> ideogramPlot(singleWatsonLibrary,
+ singleCrickLibrary,

14

llchr13chr14chr15chr16chr17chr18chr19chr20chr21chr22chrXchrYchr1chr2chr3chr4chr5chr6chr7chr8chr9chr10chr11chr12Library StrandSeqTestData_10+ exampleDividedChr,
+ orderFrame=contigOrderAll[[1]])

Alternatively, all libraries can be compared side by side for a single chro-
mosome. Because this will print to multiple pages, the showPage option can
be used to limit the output to a user=speciﬁed page. Here we will use the
orderedContig object representing just one linkage group.

> ideogramPlot(WatsonFreqList,
+ CrickFreqList,
+ exampleDividedChr,
+ orderFrame=contigOrder[[1]],
,
chr
+ plotBy=
+ showPage=1)

’

’

15

llllLG4LG5LG1LG2LG3Library StrandSeqTestData_108 Writing out to a BED ﬁle

This ﬁle can be passed to bedtools along with the original (draft) reference
genome to create a new FASTA ﬁle containing the assembled genome.
the
writeBed function requires a chrTable of class ChrTable with which to extract
the contig names and locations, the orientation information derived from reori-
entLinkageGroups to populate the strand column, the library weight to populate
the score column, and an object of type ContigOrdering to invoke the actual
order of fragments. A ﬁleName can be supplied, or the default is used. BED
ﬁles will be written to the working directory

> writeBed(exampleDividedChr,
+ reorientedMatrix[[2]],
+ contigOrder[[1]])

16

lllllllllllllllllllllllllllllllllllllStrandSeqTestData_21StrandSeqTestData_22StrandSeqTestData_23StrandSeqTestData_24StrandSeqTestData_25StrandSeqTestData_26StrandSeqTestData_27StrandSeqTestData_28StrandSeqTestData_29StrandSeqTestData_3StrandSeqTestData_30StrandSeqTestData_31StrandSeqTestData_32StrandSeqTestData_1StrandSeqTestData_10StrandSeqTestData_11StrandSeqTestData_12StrandSeqTestData_13StrandSeqTestData_14StrandSeqTestData_15StrandSeqTestData_16StrandSeqTestData_17StrandSeqTestData_18StrandSeqTestData_19StrandSeqTestData_2StrandSeqTestData_20Chromosome LG1  (Page1)9 Additional plotting functions

Using a chromosome table instance, comparisons can be made between the por-
tion of contigs that are included in the analysis verses those that are excluded
based on either poor coverage or non-Strand-seq patterning. The code below
generates a box plot of contig sizes that are included in the analysis. Note,
since sample data are uniform 1 Mb framgents, the box plot does not deviate
from the median. The example bam ﬁles contain reads from 76 separate 1 Mb
fragments from chromsomes 1, 2, 3, and 4. Since the assembly is >3 Gb in size,
only a few percent of the assembly will be included in our analysis.

> makeBoxPlot(exampleDividedChr, exampleLGList)

17

76.1 Mb included (2.5%)3019.6 Mb excluded (97.5%)1.0001.0011.0021.0031.0041.0051.006Length of contigs included in assembly vs excludedContig length (MB)Furthermore we can determine the proportion of assembly fragments in each
linkage group in a barplot. If data are in the format chr:start-end, then each
unique chromosome name will have a unique color. If data are not in this format,
then each fragment will have a unique color. Here, all fragments from chr1 will
be colored diﬀerently to fragments from chr2, etc.

> barplotLinkageGroupCalls(exampleLGList, exampleDividedChr)

Note that if clustering did not occur correctly, some bars would be a mixture
of colors. While the above displays the proportion of fragments from one chro-
mosome that has clustered into each linkage group, but omitting the by=’chr’
parameter, the plot changes to the proportion of linkage groups within each
chromosome.

18

051015LG1LG2LG3LG4LG5Linkage GroupDNA Represented in Linkage Groups (Mb)chrchr1chr2chr3chr4Barplot of 4 contigs clustered into 5 linkage groups10 Flow diagram

Here is the basic functionality of the contiBAIT package. The input BAM ﬁle(s)
and output BED ﬁle are displayed in the grey ovals. All plotting functions are
shown in blue hexagons and all analysis functions are in white boxes.

19

BAMFILEmakeChrTablestrandSeqFreqTablepreprocessStrandTableclusterContigsreorientLinkageGroupsmergeLinkageGrouporderAllLinkageGroupswriteBedideogramPlotmakeBoxPlotplotWCdistributionplotLGdistancesbarplotLGCallsplotContigOrder