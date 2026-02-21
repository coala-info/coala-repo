Software Manual

Institute of Bioinformatics, Johannes Kepler University Linz

hapFabia: Identification of very short segments of
identity by descent (IBD) characterized by rare
variants in large sequencing data
— Manual for the R package —

Sepp Hochreiter

Institute of Bioinformatics, Johannes Kepler University Linz
Altenberger Str. 69, 4040 Linz, Austria
hochreit@bioinf.jku.at

Version 1.52.0, October 30, 2025

Institute of Bioinformatics
Johannes Kepler University Linz
A-4040 Linz, Austria

Tel. +43 732 2468 8880
Fax +43 732 2468 9511
http://www.bioinf.jku.at

2

Contents

1

Introduction

2 Getting Started

2.1 Typical Analysis Pipeline .
.
2.2 Examples .

.

.

.

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 hapFabia Method

3.1 FABIA for genotype data .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.1.1
FABIA describes genotype data by IBD segments . . . . . . . . . . . . .
3.1.2 Adaptation of FABIA for IBD detection . . . . . . . . . . . . . . . . . .
3.2 Extraction of IBD segments from FABIA models . . . . . . . . . . . . . . . . .
3.3 Further Advantages of HapFABIA . . . . . . . . . . . . . . . . . . . . . . . . .

4 Tools to Analyze fabia Results

Contents

3

7
7
10

23
23
24
26
27
29

30

1 Introduction

1 Introduction

3

This package hapFabia provides software for the method HapFABIA which identifies short iden-
tity by descent (IBD) segments that are tagged by rare variants in large sequencing data.

Two haplotypes are identical by descent (IBD) if they share a segment that both inherited from
a common ancestor. Current IBD methods reliably detect long IBD segments because many minor
alleles in the segment are concordant between the two haplotypes. However, many cohort studies
contain unrelated individuals which share only short IBD segments. Short IBD segments contain
too few minor alleles to distinguish IBD from random allele sharing by recurrent mutations. New
sequencing techniques improve the situation by providing rare variants which convey more infor-
mation on IBD than common variants, because random minor allele sharing of rare variants is less
likely than for common variants.

Short IBD segments are of interest because (i) they resolve the genetic structure on a fine
scale and (ii) they can be assumed to be old. In order to detect short IBD segments, both the
information supplied by rare variants and information from more than two individuals should be
utilized. The probability of a segment being IBD is typically computed via the probabilities of
randomly sharing single alleles within the segment. The probability of randomly sharing a single
allele depends (1) on the allele frequency, where lower frequency means lower probability of
random sharing, and (2) on the number of individuals that share the allele, where more individuals
means lower probability of random sharing. Therefore a segment that contains rare variants and
is shared by more individuals has higher significance of being IBD. These two characteristics are
the basis for detecting short IBD segments by HapFABIA.

We propose biclustering Hochreiter et al. (2010) to detect very short IBD segments that are
shared among multiple individuals. Biclustering simultaneously clusters rows and columns of a
matrix. In particular it clusters row elements that are similar to each other on a subset of column
elements. A genotype matrix has individuals (unphased) or chromosomes (phased) as row ele-
ments and SNVs as column elements. Entries in the genotype matrix usually count how often the
minor allele of a particular SNV is present in a particular individual. Alternatively, minor allele
likelihoods or dosages may be used. Individuals that share an IBD segment are similar to each
other at minor alleles of SNVs (tagSNVs) which tag the IBD segment (see Fig. 2). Therefore an
IBD segment that is shared among individuals corresponds to a bicluster because these individu-
als are similar to one another at this segment. Identifying a bicluster means identifying tagSNVs
(column bicluster elements) that tag an IBD segment and, simultaneously, identifying individuals
(row bicluster elements) that possess the IBD segment.

In contrast to standard IBD detection methods, biclustering considers multiple individuals. In
contrast to standard clustering, biclustering allows for SNVs or individuals that do not belong to
any cluster or to more than one bicluster. Multiple cluster membership suits IBD detection because
diploid individuals can have two IBD segments at one locus and an SNV may tag more than one
IBD segment.

FABIA is able to represent homozygous regions (the same IBD segment in both chromosomes)
by means of its factors. At a locus, overlapping IBD segments in one diploid individual (a different
IBD segment in each of the two chromosomes) are represented through additivity of biclusters in
the FABIA model. Examples of short IBD segments found by hapFabia in chromosome 1 data
from the 1000 Genomes Project are given in Fig. 3 and Fig. 4.

4

1 Introduction

Figure 1: The IBD segment marked in yellow descended from a founder to different individuals.

1 Introduction

5

Figure 2: Biclustering of a genotyping matrix. Left: original genotyping data matrix with indi-
viduals as row elements and SNVs as column elements. Minor alleles are indicated by violet bars
and major alleles by yellow bars for each individual-SNV pair. Right: after sorting the rows, the
detected bicluster can be seen in the top three individuals. They contain the same IBD segment
which is marked in gold. Biclustering simultaneously clusters rows and columns of a matrix so
that row elements (here individuals) are similar to each other on a subset of column elements (here
the tagSNVs).

Figure 3: Example of an IBD segment in chromosome 1 found in the 1000 Genomes Project
data. The y-axis gives chromosomes and the x-axis consecutive SNVs. Yellow indicates major
alleles, violet minor alleles of tagSNVs, and blue minor alleles of other SNVs. “model L” indicates
tagSNVs identified by hapFabia in violet. A probable phasing error can be seen in line 3 and 4 at
individual NA18522. Another phasing error can be seen in the last but four and the last but five
line at individual NA19435.

Id 02Id 16SNVs80Id 01204060individualsId 13Id 14Id 15Id 12Id 11Id 16Original DataId 03Id 04Id 05Id 02Id 01Id 08Id 09Id 10Id 07Id 06Id 08SNVsindividuals20406080BiclusterId 12Id 04Id 13Id 15Id 06Id 10Id 14Id 07Id 11Id 03Id 05Id 09chr: 1  ||  pos: 8,698,269  ||  length: 57kbp  ||  #SNPs: 126  ||  #Samples: 308,669,9118,677,4348,685,0348,692,6348,700,2348,707,8348,715,4348,723,034model LNA19711_ASWNA19474_LWKNA19457_LWKNA19448_LWKNA19435_LWKNA19435_LWKNA19431_LWKNA19399_LWKNA19390_LWKNA19382_LWKNA19381_LWKNA19377_LWKNA19360_LWKNA19311_LWKNA19223_YRINA19200_YRINA19190_YRINA19189_YRINA19175_YRINA19121_YRINA19116_YRINA19107_YRINA19095_YRINA18917_YRINA18916_YRINA18873_YRINA18522_YRINA18522_YRINA18511_YRINA18501_YRI6

1 Introduction

Figure 4: Another example of an IBD segment from chromosome 1 of the 1000 Genomes Project.
See Fig. 3 for a description. Again probable phasing errors at individuals NA18516, NA19310,
and NA19384.

chr: 1  ||  pos: 51,721,665  ||  length: 52kbp  ||  #SNPs: 160  ||  #Samples: 4851,695,89951,702,72951,709,62951,716,52951,723,42951,730,32951,737,22951,744,12951,747,432model LNA20346_ASWNA20344_ASWNA20339_ASWNA20336_ASWNA20127_ASWNA19922_ASWNA19914_ASWNA19900_ASWNA19468_LWKNA19449_LWKNA19444_LWKNA19437_LWKNA19430_LWKNA19397_LWKNA19396_LWKNA19384_LWKNA19384_LWKNA19371_LWKNA19371_LWKNA19355_LWKNA19350_LWKNA19346_LWKNA19328_LWKNA19316_LWKNA19310_LWKNA19310_LWKNA19256_YRINA19236_YRINA19197_YRINA19147_YRINA19147_YRINA19121_YRINA19038_LWKNA18934_YRINA18923_YRINA18907_YRINA18874_YRINA18871_YRINA18861_YRINA18516_YRINA18516_YRINA12843_CEUNA12413_CEUNA12341_CEUHG00337_FINHG00310_FINHG00173_FINHG00159_GBR2 Getting Started

2 Getting Started

2.1 Typical Analysis Pipeline

7

First, we briefly describe a typical analysis pipeline. Assume we have the genotype data of chro-
mosome 1 in the file filename.vcf.gz in compressed vcf format. To prepare the data for
hapFabia we have to perform preprocessing steps. First filename.vcf.gz must be 1. uncom-
pressed, then 2. converted to the sparse matrix format, 3. copy genotype matrix to the matrix that
is processed, and then 4. split into intervals. The following command line commands perform
these steps:

1. gunzip filename.vcf.gz

2. ./vcftoFABIA filename ./

3. cp filename_matG.txt filename_mat.txt

4. ./split_sparse_matrix filename _mat.txt 10000 5000 1

In inst/commandline/arch/ command line tools for steps 2. to 4. are provided by the package
hapFabia. However step 2. to 4. can be performed in R as well (see below). The commandline
parameters for vcftoFABIA are

1. filename without .vcf

2. path to the file, e.g. ./

3. optional: -s snps, where snps gives the number of SNVs in the input data file

4. optional: -o outputFileName, which gives the prefix of the output files.

The commandline parameters for split_sparse_matrix are

1. filename without .vcf

2. extension (default_mat.txt)

3. interval length

4. shift size

5. indicator whether annotation is present (is generated by vcftoFABIA as default).

The data is split into intervals of 10,000 SNVs where the distance between adjacent intervals is
5,000 thus they overlap by 5,000 SNVs.

After providing the file filename.vcf the following steps constitute a typical analysis pipeline

in R :

8

2 Getting Started

paste(fileName,"_mat.txt",sep=""))

shiftSize=shiftSize,annotation=TRUE)

R> ##### define intervals, overlap, filename #######
R> shiftSize <- 5000
R> intervalSize <- 10000
R> fileName="filename" # without type
R>
R> ##### load library #######
R> library(hapFabia)
R>
R> ##### convert from .vcf to _mat.txt: step 2. above #######
R> vcftoFABIA(fileName=fileName)
R>
##### copy genotype matrix to matrix: step 3. above #######
R> file.copy(paste(fileName,"_matG.txt",sep=""),
+
R>
R> ##### split/ generate intervals: step 4. above #######
R> split_sparse_matrix(fileName=fileName,intervalSize=intervalSize,
+
R>
R> ##### compute how many intervals we have #######
R> ina <- as.numeric(readLines(paste(fileName,"_mat.txt",sep=""),n=2))
R> noSNVs <- ina[2]
R> over <- intervalSize%/%shiftSize
R> N1 <- noSNVs%/%shiftSize
R> endRunA <- (N1-over+2)
R>
R> ##### analyze each interval #######
R> ##### may be done by parallel runs #######
R> iterateIntervals(startRun=1,endRun=endRunA,shift=shiftSize,
+
+
+
+
+
R>
R> ##### identify duplicates #######
R> identifyDuplicates(fileName=fileName,startRun=1,endRun=endRunA,
+
R>
R> ##### analyze results; parallel #######
R> anaRes <- analyzeIBDsegments(fileName=fileName,startRun=1,endRun=endRunA,
+
R> print("Number IBD segments:")
R> print(anaRes$noIBDsegments)
R> print("Statistics on IBD segment lengths in SNVs (all SNVs in the
IBD segment):")

intervalSize=intervalSize,fileName=fileName,individuals=0,
upperBP=0.05,p=10,iter=40,alpha=0.03,cyc=50,IBDsegmentLength=50,
Lt = 0.1,Zt = 0.2,thresCount=1e-5,mintagSNVsFactor=3/4,
pMAF=0.035,haplotypes=FALSE,cut=0.8,procMinIndivids=0.1,thresPrune=1e-3,
simv="minD",minTagSNVs=6,minIndivid=2,avSNVsDist=100,SNVclusterLength=100)

shift=shiftSize,intervalSize=intervalSize)

shift=shiftSize,intervalSize=intervalSize)

2 Getting Started

9

R> print(anaRes$avIBDsegmentLengthSNVS)
R> print("Statistics on IBD segment lengths in bp:")
R> print(anaRes$avIBDsegmentLengthS)
R> print("Statistics on number of individuals that share an IBD segment:")
R> print(anaRes$avnoIndividS)
R> print("Statistics on number of IBD segment tagSNVs:")
R> print(anaRes$avnoTagSNVsS)
R> print("Statistics on MAF of IBD segment tagSNVs:")
R> print(anaRes$avnoFreqS)
R> print("Statistics on MAF within the group of IBD segment tagSNVs:")
R> print(anaRes$avnoGroupFreqS)
R> print("Statistics on number of changes between major and minor allele frequency:")
R> print(anaRes$avnotagSNVChangeS)
R> print("Statistics on tagSNVs per individual that shares an IBD segment:")
R> print(anaRes$avnotagSNVsPerIndividualS)
R> print("Statistics on number of individuals that have the minor allele of tagSNVs:")
R> print(anaRes$avnoindividualPerTagSNVS)
R>
R> ##### load result for interval 50 #######
R> posAll <- 50 # (50-1)*5000 = 245000: segment 245000 to 255000
R> start <- (posAll-1)*shiftSize
R> end <- start + intervalSize
R> pRange <- paste("_",format(start,scientific=FALSE),"_",
+
R> load(file=paste(fileName,pRange,"_resAnno",".Rda",sep=""))
R> IBDsegmentList <- resHapFabia$mergedIBDsegmentList # $
R>
R> summary(IBDsegmentList)
R> ##### plot IBD segments in interval 50 #######
R> plot(IBDsegmentList,filename=paste(fileName,pRange,"_mat",sep=""))
R>
R>
R> ##### plot the first IBD segment in interval 50 #######
R>
R> IBDsegment <- IBDsegmentList[[1]]
R> plot(IBDsegment,filename=paste(fileName,pRange,"_mat",sep=""))
R>

##attention: filename without type ".txt"

##attention: filename without type ".txt"

format(end,scientific=FALSE),sep="")

First the packages hapFabia and fabia are loaded. Then vcftoFABIA converts filename.vcf
to sparse matrix format giving:

filename_matH.txt (haplotype data),

filename_matG.txt (genotype data),

filename_matD.txt (dosage data),

together with the SNV annotation file and individual’s label file:

10

2 Getting Started

filename_annot.txt and

filename_individuals.txt.

The function split_sparse_matrix splits the data into intervals. The function iterateIntervals
identifies IBD segments in these intervals and stores the results in an EXCEL like .csv format and
as an R data object. The function identifyDuplicates marks and memorizes duplicates of IBD
segments which occur because the intervals overlap. Next the function analyzeIBDsegments
analyzes the results where duplicates as marked in previous step are not considered. Results are
listed by anaRes.

The next example shows how to view all IBD segments of a segment, for which we chose
interval 50 which corresponds to chromosome 1 range from 245,000 to 255,000 ((50−1)∗5000 =
245000). Then we plot a specific IBD segment, in this case the first (IBDsegmentList[[1]]),
which can also be used to store a .pdf or a .fig for editing with Xfig. Examples of this plot
function are given in Fig. 3 and Fig. 4.

An R source file pipeline.R of above pipeline can be created and executed as follows:

intervalSize=10000,haplotypes=FALSE)

R> makePipelineFile("filename",shiftSize=5000,
+
R>
R> source("pipeline.R")

NOTE: sourcing may take a while for large datasets.

The next example shows how to use the pipeline.

2.2 Examples

Next we show an example how to use hapFabia. This example shows how to run the whole
pipeline if the genotype data is given as .vcf file. The data is first converted to a sparse matrix
format by vcftoFABIA and then divided into overlapping intervals by split_sparse_matrix.
Then the IBD segments are extracted by iterateIntervals and duplicates due to overlapping
intervals marked by identifyDuplicates. Subsequently the IBD segments are analyzed by
analyzeIBDsegments, where only simple statistics are computed.

Work in a temporary directory.

> old_dir <- getwd()
> setwd(tempdir())

First the package is loaded.

> library(hapFabia)

Load data and write to vcf file. In a real application the data is already given, therefore this

chunk of code would not be necessary.

2 Getting Started

11

> data(chr1ASW1000G)
> write(chr1ASW1000G,file="chr1ASW1000G.vcf")

Create the analysis pipeline, where intervals contain only 1,000 SNVs (that is a length of about

100 kbps), while default is 10,000 SNVs (that is about a length of 1 Mbp).

> makePipelineFile(fileName="chr1ASW1000G",shiftSize=500,
+

intervalSize=1000,haplotypes=TRUE)

Now the pipeline can be executed by sourcing it.

> source("pipeline.R")

Next we list the files that were generated, where _N1_N2_ indicates that the file contains infor-
mation concerning the interval that starts at N1 and ends at N2, _ALL.Rda stores just the number
of individuals and the number of SNVs, _individuals.txt contains annotation for the individu-
als (in particular their names), _matG.txt denotes phased genotype data in sparse matrix format,
_matD.txt contains the genotype data as dosage in sparse matrix format, _matG.txt contains
unphased genotype data in sparse matrix format, _annot.txt supplies information on the SNVs,
_resAnno.Rda is the result from hapFabia, the result is also available as csv file with extension
_csv.txt.

Following files have been generated:

> list.files(pattern="chr1")

[1] "chr1ASW1000G.vcf"
[2] "chr1ASW1000G_0_1000.csv"
[3] "chr1ASW1000G_0_1000_annot.txt"
[4] "chr1ASW1000G_0_1000_mat.txt"
[5] "chr1ASW1000G_0_1000_resAnno.Rda"
[6] "chr1ASW1000G_1000_2000.csv"
[7] "chr1ASW1000G_1000_2000_annot.txt"
[8] "chr1ASW1000G_1000_2000_mat.txt"
[9] "chr1ASW1000G_1000_2000_resAnno.Rda"

[10] "chr1ASW1000G_1500_2500.csv"
[11] "chr1ASW1000G_1500_2500_annot.txt"
[12] "chr1ASW1000G_1500_2500_mat.txt"
[13] "chr1ASW1000G_1500_2500_resAnno.Rda"
[14] "chr1ASW1000G_2000_3000.csv"
[15] "chr1ASW1000G_2000_3000_annot.txt"
[16] "chr1ASW1000G_2000_3000_mat.txt"
[17] "chr1ASW1000G_2000_3000_resAnno.Rda"
[18] "chr1ASW1000G_2500_3022.csv"
[19] "chr1ASW1000G_2500_3022_annot.txt"
[20] "chr1ASW1000G_2500_3022_mat.txt"

12

2 Getting Started

[21] "chr1ASW1000G_2500_3022_resAnno.Rda"
[22] "chr1ASW1000G_500_1500.csv"
[23] "chr1ASW1000G_500_1500_annot.txt"
[24] "chr1ASW1000G_500_1500_mat.txt"
[25] "chr1ASW1000G_500_1500_resAnno.Rda"
[26] "chr1ASW1000G_All.Rda"
[27] "chr1ASW1000G_annot.txt"
[28] "chr1ASW1000G_individuals.txt"
[29] "chr1ASW1000G_mat.txt"
[30] "chr1ASW1000G_matD.txt"
[31] "chr1ASW1000G_matG.txt"
[32] "chr1ASW1000G_matH.txt"

In the following we show the results of calling the function analyzeIBDsegments in above

pipeline:

> print("Number IBD segments:")

[1] "Number IBD segments:"

> print(anaRes$noIBDsegments)

[1] 43

> print("Statistics on IBD segment length in SNVs (all SNVs in the IBD segment):")

[1] "Statistics on IBD segment length in SNVs (all SNVs in the IBD segment):"

> print(anaRes$avIBDsegmentLengthSNVS)

Min. 1st Qu. Median
37035
28648
9181

Mean 3rd Qu.
44221

36387

Max.
73991

> print("Statistics on IBD segment length in bp:")

[1] "Statistics on IBD segment length in bp:"

> print(anaRes$avIBDsegmentLengthS)

Min. 1st Qu. Median
37035
28648
9181

Mean 3rd Qu.
44221

36387

Max.
73991

> print("Statistics on number of individuals belonging to IBD segments:")

2 Getting Started

13

[1] "Statistics on number of individuals belonging to IBD segments:"

> print(anaRes$avnoIndividS)

Min. 1st Qu. Median
2.000
2.000

2.000

Mean 3rd Qu.
3.000

2.767

Max.
8.000

> print("Statistics on number of tagSNVs of IBD segments:")

[1] "Statistics on number of tagSNVs of IBD segments:"

> print(anaRes$avnoTagSNVsS)

Min. 1st Qu. Median
12.00
8.00
7.00

Mean 3rd Qu.
18.00

14.95

Max.
54.00

> print("Statistics on MAF of tagSNVs of IBD segments:")

[1] "Statistics on MAF of tagSNVs of IBD segments:"

> print(anaRes$avnoFreqS)

Min. 1st Qu. Median

Max.
0.01639 0.01639 0.02459 0.03673 0.04098 0.97541

Mean 3rd Qu.

> print("Statistics on MAF within the group of tagSNVs of IBD segments:")

[1] "Statistics on MAF within the group of tagSNVs of IBD segments:"

> print(anaRes$avnoGroupFreqS)

Min. 1st Qu. Median

Max.
0.01639 0.01639 0.02459 0.02964 0.04098 0.04918

Mean 3rd Qu.

> print("Statistics on number of changes between major and minor allele frequency:")

[1] "Statistics on number of changes between major and minor allele frequency:"

> print(anaRes$avnotagSNVChangeS)

Min.

Max.
0.000000 0.000000 0.000000 0.007776 0.000000 1.000000

1st Qu.

3rd Qu.

Median

Mean

14

2 Getting Started

> print("Statistics on number of tagSNVs per individual of an IBD segment:")

[1] "Statistics on number of tagSNVs per individual of an IBD segment:"

> print(anaRes$avnotagSNVsPerIndividualS)

Min. 1st Qu. Median
12.00
8.00
7.00

Mean 3rd Qu.
17.00

14.33

Max.
44.00

> print("Statistics on number of individuals that have the minor allele of tagSNVs:")

[1] "Statistics on number of individuals that have the minor allele of tagSNVs:"

> print(anaRes$avnoindividualPerTagSNVS)

Min. 1st Qu. Median
2.000
2.000

2.000

Mean 3rd Qu.
3.000

2.689

Max.
6.000

Next we load interval 5 and there the first and second IBD segment

> posAll <- 5
> start <- (posAll-1)*shiftSize
> end <- start + intervalSize
> pRange <- paste("_",format(start,scientific=FALSE),"_",
+
> load(file=paste(fileName,pRange,"_resAnno",".Rda",sep=""))
> IBDsegmentList <- resHapFabia$mergedIBDsegmentList
> summary(IBDsegmentList)

format(end,scientific=FALSE),sep="")

An object of class IBDsegmentList
Number of IBD segments:
Statistics:
$avIBDsegmentPosS

8

Min. 1st Qu. Median

928942

949608 966450 971968

Mean 3rd Qu.

Max.
993216 1018950

$avIBDsegmentLengthSNVS
Min. 1st Qu. Median
33425
15037
9181

Mean 3rd Qu.
43918

30687

Max.
51353

$avIBDsegmentLengthS

Min. 1st Qu. Median
33425
15037
9181

Mean 3rd Qu.
43918

30687

Max.
51353

$avnoIndividS

2 Getting Started

15

Min. 1st Qu. Median
2.00
2.00
2.00

Mean 3rd Qu.
2.25
2.25

Max.
3.00

$avnoTagSNVsS

Min. 1st Qu. Median
10.5
8.5

7.0

Mean 3rd Qu.
16.5
14.0

Max.
30.0

$avnoFreqS

Min. 1st Qu. Median

Max.
0.01639 0.01639 0.02459 0.02496 0.03279 0.04918

Mean 3rd Qu.

$avnoGroupFreqS

Min. 1st Qu. Median

Max.
0.01639 0.01639 0.02459 0.02496 0.03279 0.04918

Mean 3rd Qu.

$avnotagSNVChangeS

Min. 1st Qu. Median
0

0

0

Mean 3rd Qu.
0

0

Max.
0

$avnotagSNVsPerIndividualS
Min. 1st Qu. Median
10.5
7.5

7.0

Mean 3rd Qu.
14.0
13.5

Max.
29.0

$avnoindividualPerTagSNVS
Min. 1st Qu. Median
2.000
2.000

2.000

Mean 3rd Qu.
2.000

2.188

Max.
3.000

> IBDsegment1 <- IBDsegmentList[[1]]
> summary(IBDsegment1)

1

1
2

An object of class IBDsegment
IBD segment ID:
From bicluster:
Chromosome:
Position:
Length SNVs:
Length:
Number of individuals/chromosomes: 2
Number of tagSNVs:

953,404

12 kbp

12399

10

> IBDsegment2 <- IBDsegmentList[[2]]
> summary(IBDsegment2)

An object of class IBDsegment
IBD segment ID:
From bicluster:

2
2

16

2 Getting Started

1

953,918

Chromosome:
Position:
Length SNVs:
Length:
Number of individuals/chromosomes: 2
Number of tagSNVs:

47 kbp

46863

30

Finally go back to old directory.

> new_dir <- getwd()
> setwd(old_dir)

Plot the first IBD segment in interval 5. In the plot the y-axis gives the individuals or the
chromosomes and the x-axis consecutive SNVs. The default color coding uses yellow for major
alleles, violet for minor alleles of tagSNVs, and blue for minor alleles of other SNVs. “model L”
indicates tagSNVs identified by hapFabia in violet.

> plot(IBDsegment1,filename=paste(new_dir,"/",fileName,pRange,"_mat",sep=""))

Using 2 samples!

Plot the second IBD segment in interval 5.

chr: 1  ||  pos: 952,036  ||  length: 12kbp  ||  #tagSNVs: 10  ||  #Individuals: 2945,837947,888950,048952,208954,368956,528model LNA20340_NA20340NA19916_NA199162 Getting Started

17

> plot(IBDsegment2,filename=paste(new_dir,"/",fileName,pRange,"_mat",sep=""))

Using 2 samples!

Here an example with simulated data.

Work in temporary directory.

> old_dir <- getwd()
> setwd(tempdir())

The data simu is loaded and written into three files:

dataSim1fabia_individuals.txt (sample names),

dataSim1fabia_annot.txt (SNV annotation information), and

dataSim1fabia_mat.txt (the data in sparse matrix format).

These files are generated by the standard pipeline by vcftoFABIA and by split_sparse_matrix.

chr: 1  ||  pos: 956,458  ||  length: 47kbp  ||  #tagSNVs: 30  ||  #Individuals: 2933,027944,906956,906968,906979,890model LNA19985_NA19985NA19713_NA1971318

2 Getting Started

ncolumns=100)

append=TRUE,ncolumns=100)

append=TRUE,ncolumns=100)

quote = FALSE,row.names = FALSE,col.names = FALSE)

quote = FALSE,row.names = FALSE,col.names = FALSE,append=TRUE)

> data(simu)
> namesL <- simu[["namesL"]]
> haploN <- simu[["haploN"]]
> snvs <- simu[["snvs"]]
> annot <- simu[["annot"]]
> alleleIimp <- simu[["alleleIimp"]]
> write.table(namesL,file="dataSim1fabia_individuals.txt",
+
> write(as.integer(haploN),file="dataSim1fabia_annot.txt",
+
> write(as.integer(snvs),file="dataSim1fabia_annot.txt",
+
> write.table(annot,file="dataSim1fabia_annot.txt", sep = " ",
+
> write(as.integer(haploN),file="dataSim1fabia_mat.txt",ncolumns=100)
> write(as.integer(snvs),file="dataSim1fabia_mat.txt",
+
> for (i in 1:haploN) {
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+ }

a1 <- a1 - 1
dim(a1) <- c(1,al)
b1 <- format(as.double(b1),nsmall=1)
dim(b1) <- c(1,al)

quote = FALSE,row.names = FALSE,col.names = FALSE,append=TRUE)

quote = FALSE,row.names = FALSE,col.names = FALSE,append=TRUE)

quote = FALSE,row.names = FALSE,col.names = FALSE,append=TRUE)

write.table(a1,file="dataSim1fabia_mat.txt", sep = " ",

write.table(al,file="dataSim1fabia_mat.txt", sep = " ",

write.table(b1,file="dataSim1fabia_mat.txt", sep = " ",

al <- length(a1)
b1 <- alleleIimp[i,a1]

a1 <- which(alleleIimp[i,]>0.01)

Now the IBD segments can be extracted from the data:

> hapRes <- hapFabia(fileName="dataSim1fabia",prefixPath="",
+
+
+
+
+

sparseMatrixPostfix="_mat",
annotPostfix="_annot.txt",individualsPostfix="_individuals.txt",
labelsA=NULL,pRange="",individuals=0,lowerBP=0,upperBP=0.15,
p=10,iter=1,quant=0.01,eps=1e-5,alpha=0.03,cyc=50,non_negative=1,
write_file=0,norm=0,lap=100.0,IBDsegmentLength=10,Lt = 0.1,

2 Getting Started

19

+
+
+

Zt = 0.2,thresCount=1e-5,mintagSNVsFactor=3/4,pMAF=0.1,
haplotypes=FALSE,cut=0.8,procMinIndivids=0.1,thresPrune=1e-3,
simv="minD",minTagSNVs=6,minIndivid=2,avSNVsDist=100,SNVclusterLength=100)

> summary(hapRes$mergedIBDsegmentList)

An object of class IBDsegmentList
Number of IBD segments:
Statistics:
$avIBDsegmentPosS

1

Min. 1st Qu. Median
79427
79427

79427

Mean 3rd Qu.
79427

79427

Max.
79427

$avIBDsegmentLengthSNVS
Min. 1st Qu. Median
3853
3853
3853

$avIBDsegmentLengthS

Mean 3rd Qu.
3853
3853

Max.
3853

Min. 1st Qu. Median
3853
3853
3853

Mean 3rd Qu.
3853
3853

Max.
3853

$avnoIndividS

Min. 1st Qu. Median
10

10

10

$avnoTagSNVsS

Min. 1st Qu. Median
15

15

15

Mean 3rd Qu.
10

10

Max.
10

Mean 3rd Qu.
15

15

Max.
15

$avnoFreqS

Min. 1st Qu. Median

Max.
0.04500 0.07750 0.08500 0.08267 0.09250 0.11000

Mean 3rd Qu.

$avnoGroupFreqS

Min. 1st Qu. Median

0.0950

0.1175 0.1300 0.1267

Mean 3rd Qu.
0.1400

Max.
0.1450

$avnotagSNVChangeS

Min. 1st Qu. Median
0

0

0

Mean 3rd Qu.
0

0

Max.
0

$avnotagSNVsPerIndividualS
Min. 1st Qu. Median
14.0
14.0
14.0

Mean 3rd Qu.
15.0
14.4

Max.
15.0

$avnoindividualPerTagSNVS

20

2 Getting Started

Min. 1st Qu. Median
10.0
10.0

4.0

Mean 3rd Qu.
10.0

9.6

Max.
10.0

To view the results the first IBD segment is plotted:

> mergedIBDsegmentList <- hapRes$mergedIBDsegmentList # $
> IBDsegment <- mergedIBDsegmentList[[1]]

> new_dir <- getwd()
> setwd(old_dir)

Again, in the plot the y-axis gives the individuals or the chromosomes and the x-axis consec-
utive SNVs. The default color coding uses yellow for major alleles, violet for minor alleles of
tagSNVs, and blue for minor alleles of other SNVs. “model L” indicates tagSNVs identified by
hapFabia in violet.

> plot(IBDsegment,filename=paste(new_dir,"/dataSim1fabia_mat",sep=""))

Using 10 samples!

Here another example with random data:

chr: 1  ||  pos: 79,928  ||  length: 4kbp  ||  #tagSNVs: 15  ||  #Individuals: 1078,00278,86579,82580,78581,745model L192_192160_160130_13089_8988_8884_8481_8178_7840_407_72 Getting Started

> old_dir <- getwd()
> setwd(tempdir())

21

> simulateIBDsegmentsFabia(minruns=2,maxruns=2)

> hapRes <- hapFabia(fileName="dataSim2fabia",prefixPath="",
+
+
+
+
+
+
+
+

sparseMatrixPostfix="_mat",
annotPostfix="_annot.txt",individualsPostfix="_individuals.txt",
labelsA=NULL,pRange="",individuals=0,lowerBP=0,upperBP=0.15,
p=10,iter=1,quant=0.01,eps=1e-5,alpha=0.03,cyc=50,non_negative=1,
write_file=0,norm=0,lap=100.0,IBDsegmentLength=10,Lt = 0.1,
Zt = 0.2,thresCount=1e-5,mintagSNVsFactor=3/4,pMAF=0.1,
haplotypes=FALSE,cut=0.8,procMinIndivids=0.1,thresPrune=1e-3,
simv="minD",minTagSNVs=6,minIndivid=2,avSNVsDist=100,SNVclusterLength=100)

> summary(hapRes$mergedIBDsegmentList)

An object of class IBDsegmentList
Number of IBD segments:
Statistics:
$avIBDsegmentPosS

1

Min. 1st Qu. Median
1220
1220
1220

Mean 3rd Qu.
1220
1220

Max.
1220

$avIBDsegmentLengthSNVS
Min. 1st Qu. Median
3607
3607
3607

$avIBDsegmentLengthS

Mean 3rd Qu.
3607
3607

Max.
3607

Min. 1st Qu. Median
3607
3607
3607

Mean 3rd Qu.
3607
3607

Max.
3607

$avnoIndividS

Min. 1st Qu. Median
10

10

10

$avnoTagSNVsS

Min. 1st Qu. Median
15

15

15

Mean 3rd Qu.
10

10

Max.
10

Mean 3rd Qu.
15

15

Max.
15

$avnoFreqS

Min. 1st Qu. Median

Max.
0.05500 0.07000 0.08000 0.08367 0.09500 0.11000

Mean 3rd Qu.

$avnoGroupFreqS

Min. 1st Qu. Median

Mean 3rd Qu.

Max.

22

2 Getting Started

0.0800

0.1150

0.1300 0.1257

0.1425

0.1450

$avnotagSNVChangeS

Min. 1st Qu. Median
0

0

0

Mean 3rd Qu.
0

0

Max.
0

$avnotagSNVsPerIndividualS
Min. 1st Qu. Median
14.0
14.0
14.0

Mean 3rd Qu.
14.0
14.2

Max.
15.0

$avnoindividualPerTagSNVS
Min. 1st Qu. Median
10.000 10.000

2.000

Mean 3rd Qu.

Max.
10.000 10.000

9.467

> mergedIBDsegmentList <- hapRes$mergedIBDsegmentList # $
> IBDsegment <- mergedIBDsegmentList[[1]]

> new_dir <- getwd()
> setwd(old_dir)

> plot(IBDsegment,filename=paste(new_dir,"/dataSim2fabia_mat",sep=""))

Using 10 samples!

3 hapFabia Method

23

3 hapFabia Method

Our novel method HapFABIA extracts short IBD segments that are tagged by rare variants from
large sequencing data. In the first stage, HapFABIA applies FABIA biclustering to phased or un-
phased genotype data. Biclustering extracts similarities between individuals based on a subset of
SNVs, but does not consider that IBD segments consist of contiguous nucleotides. In the second
stage, HapFABIA extracts IBD segments from FABIA models by considering local tagSNV ac-
cumulations. SNVs that tag an IBD segment are within this segment and, therefore, accumulate
locally. It is important for the second stage that the SNVs which are extracted in the first step are
independent of their DNA location. This justifies to use statistical methods for identifying local
SNV accumulations in FABIA models which would not be expected randomly. Finally, Hap-
FABIA prunes spurious correlated SNVs from the extracted IBD segments and joins segments.
The two HapFABIA steps (biclustering and IBD segment extraction) are described in the next two
subsections.

3.1 FABIA for genotype data

In the following, we describe the first step of HapFABIA. We propose identifying similarities
between individuals by biclustering. Biclustering simultaneously clusters rows and columns of a

chr: 1  ||  pos: 1,974  ||  length: 4kbp  ||  #tagSNVs: 15  ||  #Individuals: 101718901,6902,4903,2903,778model L188_188185_185184_184161_161123_123121_121113_11393_9368_685_524

3 hapFabia Method

matrix. More specifically, it clusters row elements that are similar to each other on a subset of
column elements. An IBD segment corresponds to a bicluster because individuals that possess the
IBD segment are similar to each other at this segment. The similarity is given by identical minor
alleles of tagSNVs. Fig. 2 depicts a bicluster identified in genotype data.

We employ the “Factor Analysis for Bicluster Acquisition” (FABIA) biclustering model Hochre-

iter et al. (2010). In contrast to other biclustering methods such as BIMAX Prelic et al. (2006)
and QUBIC Li et al. (2009), FABIA can represent homozygous regions (two times the same IBD
segment in one diploid individual) by its multiplicative bicluster model. Furthermore, FABIA can
represent overlapping IBD segments (a different IBD segment on each chromosome) by its addi-
tive biclusters. FABIA can be applied to discrete phased or unphased genotype data but also to
real values that correspond to minor allele likelihoods or the minor allele dosages. We use FABIA
not only because it is well suited for genotyping data, but also because it outperformed other
biclustering methods in extensive comparisons on different data sets Hochreiter et al. (2010).

3.1.1 FABIA describes genotype data by IBD segments

FABIA describes an IBD segment in genotype data X by an outer product z λT of two vectors
λ and z, where the vector λ indicates tagSNVs by non-zero values and the vector z indicates
individuals that possess the IBD segment. FABIA can represent a homozygous region of an IBD
segment by z = 2, that is, two occurrences of an IBD segment in one diploid individual. Fig. ??
visualizes this description of a genotype matrix by one IBD segment as an outer product.

A diploid individual may possess two IBD segments at a particular locus where genotyping
sums up the occurrences of minor alleles. This fact is reflected by the additive FABIA model
which sums up bicluster contributions. If we assume genotyping errors which are accounted for
by Υ, the FABIA model for genotype data X is

X =

p
(cid:88)

i=1

zi λT

i + Υ = Z Λ + Υ ,

(1)

where X ∈ Rl×n is the genotyping data; Z ∈ Rl×p is the matrix that indicates which individuals
possess an IBD segment; Λ ∈ Rp×n indicates IBD segment tagSNVs; Υ ∈ Rl×n is an additive
noise term; n is the number of SNVs; l is the number of individuals (or chromosomes for phased
genotypes); p is the number of IBD segments; λi ∈ Rn is tagSNV indicator vector for the i-th
IBD segment (the i-th row of Λ); and zi ∈ Rl corresponds to the number of times each of the l
individuals contains the i-th IBD segment (the i-th column of Z). The additive noise Υ not only
covers genotyping errors but also genotypes which cannot be explained by IBD segments. Such
unexplained genotypes may arise from recently acquired SNVs, segments contained in only one
individual, and IBD segments that are too short, or segments that are shared by too few individuals
to be called.

According to Eq. (1), the j-th genotype xj, i.e., the j-th column of X, is

xj =

p
(cid:88)

i=1

λi zij + ϵj = Λ ˜zj + ϵj ,

(2)

where ϵj is the j-th column of the noise matrix Υ and ˜zj = (z1j, . . . , zpj)T indicates which IBD
segments are present in genotype xj (j-th column of the matrix Z with length equal to the number

3 hapFabia Method

25

of IBD segments p). Recall that zi = (zi1, . . . , zil)T in Eq. (1) corresponds to the number of times
each of the l individuals contains the i-th IBD segment.

If we drop the index j which indicates the individual, the formulation in Eq. (2) facilitates a

generative interpretation by a factor analysis model with p factors:

x =

p
(cid:88)

i=1

λi ˜zi + ϵ = Λ ˜z + ϵ ,

(3)

where x ∈ Rn is the observed genotype. The vector of factors ˜z = (˜z1, . . . , ˜zp)T indicates which
IBD segments are present in genotype x, where component ˜zi indicates how often the individual
with genotype x possesses the i-th IBD segment. ϵ ∈ Rn is the additive noise.

As illustrated in Fig. ??, both the vector zi and the vector λi should be sparse to describe
an IBD segment. Sparse zi means that only few individuals possess the IBD segment, which
implies rare tagSNVs. Sparse λi means that only few SNVs are tagSNVs, which implies short IBD
segments. Sparse zi can be achieved if components zij are sparse, that is, if the vector of factors
˜zj in Eq. (2) is sparse or, equivalently, the vector ˜z in Eq. (3) is sparse. In contrast to standard
factor analysis, FABIA’s model selection is tailored to sparse factors and sparse loadings, which
are essential for IBD detection. Sparseness in the FABIA model is obtained by a component-wise
independent Laplace distribution both for the prior on the parameters λi and for the distribution
of the factors ˜z Hyvärinen and Oja (1999):

p( ˜z) =

(cid:16) 1√

2

(cid:17)p

p
(cid:89)

√

2 |˜zi|

e−

i=1

p(λi) =

(cid:17)n

n
(cid:89)

√

e−

2 |λki| .

(cid:16) 1√

2

k=1

The Laplace distribution of the factors leads to an analytically intractable likelihood:

p(x | Λ, Ψ) =

(cid:90)

p(x | ˜z, Λ, Ψ) p( ˜z) d ˜z .

(4)

(5)

(6)

Therefore, the model selection of FABIA is performed by means of variational expectation maxi-
mization, which is a variational optimization in the expectation maximization (EM) framework to
maximize the posterior of the parameters Girolami (2001); Palmer et al. (2006); Hochreiter et al.
(2010); Clevert et al. (2011); Klambauer et al. (2012). The idea of the variational approach is to
express the prior p( ˜z) by the maximum

p( ˜z) = max

ξ

p( ˜z | ξ)

(7)

over a model family p( ˜z | ξ) that is parametrized by the variational parameter ξ or by scale
mixtures

(cid:90)

p( ˜z) =

p( ˜z | ξ) dµ(ξ) .

(8)

26

3 hapFabia Method

A Laplace distribution can be expressed exactly by the maximum of a Gaussian family or by Gaus-
sian scale mixtures Girolami (2001); Palmer et al. (2006). Therefore, for each x, the maximum ˆξ
of the variational parameter ξ allows for representing the Laplacian prior by a Gaussian:

ˆξ = arg max

p(ξ | x) .

ξ

(9)

The maximum ˆξ can be computed analytically (see Eq. (12) below) because for each Gaussian the
likelihood Eq. (6) can be computed analytically.

If we denote the j-th genotype by xj ∈ Rn with corresponding factors zj ∈ Rp, then we

obtain the following variational E-step Hochreiter et al. (2010):

E(cid:0)zj | xj
j | xj

E(cid:0)zj zT

(cid:1) = (cid:0)ΛT Ψ−1 Λ + Ξ−1
j
(cid:1) = (cid:0)ΛT Ψ−1 Λ + Ξ−1
j

(cid:1)−1 ΛT Ψ−1 xj ,
(cid:1)−1 + E(cid:0)zj | xj

(cid:1) E(zj | xj)T ,

where Ξj means diag (ξj). The update for the variational parameter ξj is

ξj = diag

(cid:16)(cid:113)

E(zj zT

(cid:17)
j | xj)

.

The variational M-step is Hochreiter et al. (2010)

Λnew =

1
l

(cid:80)l

j=1 xj E(zj | xj)T − α

l Ψ sign(Λ)

(cid:80)l

1
l

j=1 E(zj zT
(cid:16) α
l

j | xj)
Ψ sign(Λ)(Λnew)T (cid:17)

,

diag (Ψnew) = ΨEM + diag

ΨEM = diag

(cid:18) 1
l

l
(cid:88)

j=1

xj xT

j − Λnew 1
l

l
(cid:88)

j=1

E (zj | xj) xT
j

(cid:19)

.

(10)

(11)

(12)

(13)

(14)

(15)

The parameter α controls the degree of sparseness (an expectation of how rare the SNVs that tag
the IBD segment are) and can be introduced as a parameter of the Laplacian prior of the factors
Hochreiter et al. (2010).

Note that the number of bicluster need not be determined a priori if p is chosen large enough.
The sparseness constraint will remove spurious biclusters by setting λ to the zero vector. In this
way, FABIA automatically determines the number of biclusters.

3.1.2 Adaptation of FABIA for IBD detection

Since an entry in the genotype matrix X reports how often the minor allele is present, FABIA must
explain occurrences of minor alleles by IBD segments. The genotype matrix X is non-negative as
are both the indicator matrix of tagSNVs Λ and indicator matrix of IBD segments in individuals
Z. Regarding these constraints, we modified FABIA to enforce non-negative loadings Λ. If, for
individual j, both genotype data xj and Λ are non-negative, the posterior mean E(cid:0)zj | xj
(cid:1) of
zj is non-negative, too. Consequently, the new loading matrix Λnew is non-negative according
to Eq. (13). Note that the prior term α
l Ψ sign(Λ) in the update rule Eq. (13) is not allowed to
change the signs of the loadings Λ in one update step. Therefore, it is sufficient to initialize Λ by

3 hapFabia Method

27

positive values to enforce non-negative factors and loadings. Z is estimated by the posterior mean
E(cid:0)zj | xj

(cid:1) and is used to identify individuals that possess an IBD segment.

To allow IBD segment detection in large sequencing data, we developed a specialized sparse
matrix algebra. This sparse matrix algebra only considers non-zero values with their indices for
In Eqs. (10)-(15) the values of the genotype vectors xj and
vector and matrix computations.
the values of the loading matrix Λ are sparse. Our sparse matrix algebra not only allows for
multiplying a sparse vector by a dense vector (as usual in sparse matrix computations), but also
for multiplying two sparse vectors.

To further speed up the computation, we extended FABIA to an iterative version, where, in
each iteration, p biclusters are detected. These p biclusters are removed from the genotype matrix
X before starting the next iteration.

The vectors λi and zi acquire a new interpretation when detecting short IBD segments. Com-
ponents of λi indicate to which degree tagSNVs tag the i-th IBD segment. In particular, these
components measure how many individuals possess the IBD segment (more precisely the corre-
sponding tagSNV). Components of zi indicate how often a specific IBD segment is present in
one multiploid individual. Additionally components of zi also indicate how well an individual
segment matches an IBD segment as individual segments may contain genotyping errors or may
be broken up during meiosis.

3.2 Extraction of IBD segments from FABIA models

FABIA biclustering does not consider that an IBD segment consists of contiguous nucleotides.
This essential information is incorporated into HapFABIA in the second stage. SNVs that tag
an IBD segment are locally accumulated. FABIA may have accidentally merged separated IBD
segments that are shared by the same individuals or IBD segments that are located on different
chromosomes. The second stage, therefore disentangles falsely merged IBD segments, prunes
IBD segments from spurious SNVs, and finally joins parts of single long IBD segments.

As mentioned above, FABIA biclustering does not regard the order of SNVs or individuals,
thus random shuffling of SNVs does not change its result. Therefore, randomly correlated SNVs
that are found by FABIA would be uniformly distributed along the chromosome. However, SNVs
that are correlated because they tag an IBD segment agglomerate locally in this segment. Devia-
tions from the null hypothesis of uniformly distributed SNVs can be detected by a binomial test for
the number of expected SNVs within an interval if the minor allele frequency of SNVs is known.
A low p-value hints at local agglomerations of bicluster SNVs stemming from an IBD segment.

We propose a four-step procedure to extract IBD segments from FABIA models:

1. Identify local agglomerations of correlated SNVs based on a binomial test;

2. Disentangle IBD segments and re-assigning individuals or chromosomes to IBD segments;

3. Prune IBD segments off SNVs with spuriously correlations based on an exponential test for

a long genomic distance;

4. Join similar IBD segments stemming from long IBD segments that were divided by the bins

at the first step.

28

3 hapFabia Method

Step 1: FABIA model selection is independent of the order of the SNVs. Therefore, spuri-
ously correlated SNVs are unlikely to agglomerate at a DNA locus, whereas tagSNVs do, as they
are within an IBD segment. To detect agglomerations, we compute histogram counts of FABIA
model SNVs within bins where bins with large counts are assumed to contain IBD segments. For
computing the histogram of counts of FABIA model SNVs, we consider those SNVs for which the
FABIA model parameter λi is largest (threshold “Lt” with 10% being the default value). Large λ
values ensure IBD segments that are shared by multiple individuals. These segments are therefore
more reliable. The HapFABIA parameter “IBDlength” determines the maximal length of IBD
segments. The histogram bin size in number of SNVs (all SNVs and not only model SNVs) is
computed from “IBDlength” using the average genomic distance between adjacent SNVs. To ac-
count for IBD segments that exceed the borders of the bins, the histogram is computed a second
time with bins shifted by half the bin size.

The histogram bins with more model SNVs than expected by chance are assumed to contain
IBD segments. We select bins for which the model SNV count exceeds the expected value by a
binomial test for random counts. We need to compute how many model SNVs are expected in
a bin if they are random and not in an IBD segment. Thus, we have to compute the probability
of observing k or more bin counts by chance. Let p be the probability of a random minor allele
match between t individuals. If n SNVs are in a bin, the probability of observing k model SNVs
by chance is given by one minus the binomial distribution F (k; n, p):

1 − F (k − 1; n, p) = Pr(K ≥ k) =

n
(cid:88)

i=k

(cid:19)

(cid:18)n
i

pi (1 − p)n−i .

(16)

If q is the minor allele frequency (MAF) for one SNV, the probability p of observing the minor
allele of this SNV in all t individuals is p = qt. We assumed that all SNVs have the same MAF
q — in the experiments we used the average MAF. For b bins, the probability of observing k or
more counts of model SNVs by chance in at least one bin is

(cid:19) n
(cid:88)

(cid:18)l
t

b

i=k

(cid:19)

(cid:18)n
i

qit (cid:0)1 − qt(cid:1)n−i ,

(17)

where l is the number of individuals and (cid:0)l
(cid:1) is the number of possibilities to chose t individuals
t
from the l individuals.
If the probability in Eq. (17) is below the threshold “thresCount”, the
according bin is selected for IBD segment extraction because more FABIA model SNVs are in this
bin than expected by chance. If kmin is the minimum k for which Eq. (17) is below the threshold
“thresCount”, then all bins with model SNV counts k ≥ kmin are selected. In our experiments, we
allow IBD segments of only two individuals (standard IBD), and therefore set t = 2.

If a bin is selected, SNVs and individuals must be assigned to it. Note that bicluster mem-
berships of FABIA biclusters cannot be used directly because they include all bins and therefore
different IBD segments. First, those model SNVs that contributed to the count of the selected bin
are assigned to it. Then, individuals or chromosomes are assigned to the selected bin if they pos-
sess a minor allele at one or more SNVs that have been assigned to the bin. Individuals are only
chosen from the top z-values of the FABIA model to ensure that assigned individuals are indeed
similar to each other. The parameter “Zt” (default 0.2) gives the percentage of top z-scores that
are considered.

3 hapFabia Method

29

Step 2: In this step, IBD segments in a selected bin are disentangled, where only SNVs and
individuals are considered that have been assigned to the bin. An IBD segment is initialized by
two core individuals that are identical at m or more minor alleles. The number m is computed as
m = mintagSNVsFactor × kmin. All individuals that are identical in at least m minor alleles to
one of the two IBD core individuals are classified as possessing the IBD segment. The tagSNVs of
this IBD segment are model SNVs that have their minor allele in at least 2 individuals that possess
the IBD segment.

Step 2 is repeated after removing the current IBD segment by deleting the segment’s tagSNVs

until no more core individuals are found.

Step 3: This step prunes IBD segment borders of SNVs that have spurious correlations to
the IBD segment. Spurious correlations may still be present in a bin leading to an overestimation
of the segment length. Such SNVs can be identified by deviations of their MAFs from those
of other tagSNVs. However, this criterion is not reliable for rare SNVs. Therefore, we identify
SNVs with spurious correlations to an IBD segment on the basis of unusually large distances to
other tagSNVs. The deviation from an expected distance is quantified by means of an exponential
distribution with the median distance between tagSNVs as parameter. SNVs with distances leading
to p-values below 1e-3 are removed. The two furthest upstream and the two furthest downstream
tagSNVs are tested for their distances to other tagSNVs. If the second-furthest up- or downstream
tagSNV is removed, then the furthest up- or downstream tagSNV is removed, too.

Step 4: IBD segments which are very similar to each other are merged. In this way, long
IBD segments that were divided by the bins into smaller parts are reconstructed. Note that IBD
segments longer than given by “IBDlength” can be detected. In order to compute similarities, we
assess how many tagSNVs and individuals of the smaller IBD segment are explained by the larger
IBD segment. This criterion is expressed by the “overlap coefficient”

O(A, B) =

|A ∩ B|
min{|A|, |B|}

.

(18)

Using the overlap coefficient for both tagSNVs and individuals, we define a distance-like measure
between IBD segments IBD1 and IBD2 by

D(IBD1, IBD2) = 1 − O(SIBD1, SIBD2) O(IIBD1, IIBD2) ,

(19)

where SIBDi and IIBDi are the tagSNVs that tag IBD segment IBDi and individuals possessing
IBD segment IBDi, respectively. Using the measure D, IBD segments are clustered by hierarchi-
cal clustering using complete linkage. IBD segments are merged if their segments are clustered
together below a cutting height of 0.8.

3.3 Further Advantages of HapFABIA

HapFABIA further has the following two advantages over existing IBD detection methods:

1. If an IBD segment is known, but its tagSNVs are unknown, existing IBD detections methods
have still difficulties to identify IBD sharing among individuals. Most tagSNVs are sepa-
rated by common, private, or random SNVs, but also by tagSNVs of other IBD segments.
Moreover, the distances between tagSNVs of an IBD segment vary much, both in terms of

30

4 Tools to Analyze fabia Results

genomic distance and the number of tagSNVs between them. These complex data char-
acteristics impair the detecting abilities of existing IBD detection methods. HapFABIA’s
biclustering approach, however, does not consider the order of SNVs in first place, there-
fore, it is well suited for detecting non-consecutive tagSNVs with varying distances between
them.

2. HapFABIA is well suited both for phased and unphased genotype data. It represents ho-
mozygous regions (i.e. two occurrences of an IBD segment in one diploid individual) by
means of its factor. Overlapping IBD segments in a diploid individual (i.e. different IBD seg-
ments on each chromosome) can be represented by the additive FABIA model. The results
of HapFABIA for phased and unphased genotypes hardly differ for short IBD segments be-
cause homozygous regions are rarely observed. Another important aspect is that HapFABIA
can also be applied to minor allele likelihoods or minor allele dosages. We applied Hap-
FABIA to data from the Korean Personal Genome Project (KPGP, http://opengenome.
net), which was merged with the 1000 Genomes Project data. In this analysis we only used
unphased genotype data and re-discovered the IBD segments which were already found
in the 1000 Genomes Project data. Additionally, we discovered more Asian specific IBD
segments. Results can be found at http://www.bioinf.jku.at/research/short-IBD.

4 Tools to Analyze fabia Results

To analyze the fabia results we provide some functions. This might be convenient if parameters
are optimized for a specific data set.

Accumulations of fabia loadings can be given as histogram counts to see locations of accu-

mulations:

> data(res)
> h1 <- histL(res,n=1,p=0.9,w=NULL,intervv=50,off=0)
> print(h1$counts)

[1]
[19]

9 5
5 11

7 7

5 4

4 4

5 4

3

6 1

5 6

4 1

4

> h1 <- histL(res,n=1,p=NULL,w=0.5,intervv=50,off=0)
> print(h1$counts)

[1] 4 2 6 5 4 3 3 4 3 3 1 4 0 4 3 3 1 3 3 7

fabia loadings can be plotted to identify locations of accumulations:

> data(res)
> plotL(res,n=1,p=0.95,w=NULL,type="histogram",intervv=50,off=0,t="p",cex=1)

4 Tools to Analyze fabia Results

31

> data(res)
> plotL(res,n=1,p=0.95,w=NULL,type="points",intervv=50,off=0,t="p",cex=1)

bicluster 1SNV numbercounts020040060080010000123432

4 Tools to Analyze fabia Results

> data(res)
> plotL(res,n=1,p=NULL,w=0.5,type="histogram",intervv=50,off=0,t="p",cex=1)

020040060080010000.60.70.80.91.01.11.2bicluster 1SNV numbercounts4 Tools to Analyze fabia Results

33

> data(res)
> plotL(res,n=1,p=0.95,w=NULL,type="smooth",intervv=50,off=0,t="p",cex=1)

bicluster 1SNV numbercounts020040060080010000123456734

4 Tools to Analyze fabia Results

> data(res)
> plotL(res,n=1,p=NULL,w=0.5,type="smooth",intervv=50,off=0,t="p",cex=1)

020040060080010000.60.70.80.91.01.11.2bicluster 1SNV numbercounts4 Tools to Analyze fabia Results

35

Finally the largest fabia loadings L and factors Z can be listed. The largest values must

exceed a threshold either given by quantile p or a value w:

> data(res)
> topLZ(res,n=1,LZ="L",indices=TRUE,p=0.95,w=NULL)

[1]

49 88

27 45

95 125 139 143 162 164 186 205 211 212
[15] 229 259 264 266 323 332 337 358 394 401 414 417 419 468
[29] 487 492 534 565 567 574 656 666 688 705 746 756 775 777
[43] 877 898 900 911 958 959 968 989

> topLZ(res,n=1,LZ="L",indices=TRUE,p=NULL,w=0.95)

[1] 125 164 212 417 419 877

> topLZ(res,n=1,LZ="Z",indices=TRUE,p=0.95,w=NULL)

[1]

6

20 35 58

91 94 102 105 108 114

> topLZ(res,n=1,LZ="Z",indices=TRUE,p=NULL,w=0.4)

020040060080010000.50.60.70.80.91.01.11.2bicluster 1SNV numbercounts36

[1]

6 102

REFERENCES

> topLZ(res,n=1,LZ="L",indices=FALSE,p=0.95,w=NULL)

[1] 0.6383142 0.6927502 0.9015600 0.8025189 0.7258389
[6] 0.9553665 0.8696658 0.9197025 0.5771737 1.1055338
[11] 0.6178381 0.7516020 0.7300434 1.2052466 0.5862968
[16] 0.6237540 0.6692794 0.5709860 0.5960892 0.8277471
[21] 0.5512068 0.8329555 0.6040622 0.6709233 0.8271526
[26] 0.9685284 1.0129973 0.6424376 0.7400939 0.8140626
[31] 0.7644123 0.6474202 0.6518362 0.8894892 0.7627514
[36] 0.5580086 0.6072268 0.6685370 0.7733036 0.5666094
[41] 0.6699066 0.6692214 0.9845007 0.6107024 0.6556427
[46] 0.8261591 0.6278021 0.5662607 0.5792704 0.8157592

> topLZ(res,n=1,LZ="L",indices=FALSE,p=NULL,w=0.95)

[1] 0.9553665 1.1055338 1.2052466 0.9685284 1.0129973
[6] 0.9845007

> topLZ(res,1,LZ="Z",indices=FALSE,p=0.95,w=NULL)

[1] 0.4015947 0.3433146 0.3677638 0.3482399 0.3199918
[6] 0.2772825 0.7713440 0.3260151 0.2891986 0.3086591

> topLZ(res,1,LZ="Z",indices=FALSE,p=NULL,w=0.4)

[1] 0.4015947 0.7713440

References

Clevert, D.-A., Mitterecker, A., Mayr, A., Klambauer, G., Tuefferd, M., DeBondt, A., Talloen, W., Göhlmann, H. W. H., and Hochreiter, S. (2011).
cn.FARMS: a latent variable model to detect copy number variations in microarray data with a low false discovery rate. Nucl, Acids Res., 39(12), e79.

Girolami, M. (2001). A variational method for learning sparse and overcomplete representations. Neural Comput., 13(11), 2517–2532.

Hochreiter, S., Bodenhofer, U., Heusel, M., Mayr, A., Mitterecker, A., Kasim, A., VanSanden, S., Lin, D., Talloen, W., Bijnens, L., Göhlmann, H. W. H.,

Shkedy, Z., and Clevert, D.-A. (2010). FABIA: factor analysis for bicluster acquisition. Bioinformatics, 26(12), 1520–1527.

Hyvärinen, A. and Oja, E. (1999). A fast fixed-point algorithm for independent component analysis. Neural Comput., 9(7), 1483–1492.

Klambauer, G., Schwarzbauer, K., Mayr, A., Clevert, D.-A., Mitterecker, A., Bodenhofer, U., and Hochreiter, S. (2012). cn.MOPS: mixture of poissons

for discovering copy number variations in next generation sequencing data with a low false discovery rate. Nucl. Acids Res., 40(9), e69.

Li, G., Ma, Q., Tang, H., Paterson, A. H., and Xu, Y. (2009). QUBIC: a qualitative biclustering algorithm for analyses of gene expression data. Nucl.

Acids Res., 37(15), e101.

Palmer, J., Wipf, D., Kreutz-Delgado, K., and Rao, B. (2006). Variational EM algorithms for non-Gaussian latent variable models. Advances in Neural

Information Processing Systems 18, pages 1059–1066.

Prelic, A., Bleuler, S., Zimmermann, P., Wille, A., Bühlmann, P., Gruissem, W., Hennig, L., Thiele, L., and Zitzler, E. (2006). A systematic comparison

and evaluation of biclustering methods for gene expression data. Bioinformatics, 22(9), 1122–1129.

