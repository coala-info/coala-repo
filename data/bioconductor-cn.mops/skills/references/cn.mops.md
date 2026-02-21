Software Manual

Institute of Bioinformatics, Johannes Kepler University Linz

cn.mops - Mixture of Poissons for CNV detection in
NGS data

Günter Klambauer

Institute of Bioinformatics, Johannes Kepler University Linz
Altenberger Str. 69, 4040 Linz, Austria
cn.mops@bioinf.jku.at

Version 1.56.0, October 29, 2025

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

2 Getting started and quick start

3

Input of cn.mops: BAM files, GRanges objects, or numeric matrices
3.1 Read count matrices as input
3.2 BAM files as input

. . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . .

.

.

.

.

4 Copy number estimation with cn.mops

4.1 Running cn.mops .
.
4.2 The result object

.
.

5 Visualization of the result
.
5.1 Chromosome plots
.
5.2 CNV region plots .

6 Exome sequencing data

.
.

.
.

.
.

.
.

.
.

.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . .

7 Cases vs. Control or Tumor vs. Normal

8 Heterosomes and CNVs of tumor samples

9 cn.mops for haploid genomes

10 Adjusting sensitivity, specificity and resolution for specific applications

11 Overview of study designs and cn.mops functions

12 Exporting cn.MOPS results in tabular format

13 How to cite this package

Contents

3

3

4
4
5

6
6
7

9
9
10

11

14

14

16

16

16

17

18

1 Introduction

1 Introduction

3

The cn.mops package is part of the Bioconductor (http://www.bioconductor.org) project.
The package allows to detect copy number variations (CNVs) from next generation sequenc-
ing (NGS) data sets based on a generative model. Please visit http://www.bioinf.jku.at/
software/cnmops/cnmops.html for additional information.

To avoid the false discoveries induced by read count variations along the chromosome or
across samples, we propose a “Mixture Of PoissonS model for CNV detection” (cn.MOPS). The
cn.MOPS model is not affected by read count variations along the chromosome, because at each
DNA position a local model is constructed. Read count variations across samples are decom-
posed by the cn.MOPS model into integer copy numbers and noise by its mixture components
and Poisson distributions, respectively. In contrast to existing methods, cn.MOPS model’s poste-
rior provides integer copy numbers together with their uncertainty. Model selection in a Bayesian
framework is based on maximizing the posterior given the samples by an expectation maximiza-
tion (EM) algorithm. The model incorporates the linear dependency between average read counts
in a DNA segment and its copy number. Most importantly, a Dirichlet prior on the mixture com-
ponents prefers constant copy number 2 for all samples. The more the data drives the posterior
away from the Dirichlet prior corresponding to copy number two, the more likely the data is
caused by a CNV, and, the higher is the informative/non-informative (I/NI) call. cn.MOPS de-
tects a CNV in the DNA of an individual as a segment with high I/NI calls. I/NI call based CNV
detection guarantees a low false discovery rate (FDR) because wrong detections are less likely
for high I/NI calls. We assume that the genome is partitioned into segments in which reads are
counted but which need not be of constant length throughout the genome. For each of such an
segment we build a model. We consider the read counts x at a certain segment of the genome, for
which we construct a model across samples. The model incorporates both read count variations
due to technical or biological noise and variations stemming from copy number variations. For
further information regarding the algorithm and its assessment see the cn.MOPS homepage at
http://www.bioinf.jku.at/software/cnmops/cnmops.html.

2 Getting started and quick start

To load the package, enter the following in your R session:

> library(cn.mops)

The whole pipeline will only take a few steps, if BAM files are available (for read count

matrices directly go to step 2):

1. Getting the input data from BAM files (also see Section 3.2 and Section 3).

> BAMFiles <- list.files(pattern=".bam$")
> bamDataRanges <- getReadCountsFromBAM(BAMFiles)

2. Running the algorithm (also see Section 4.2).

> res <- cn.mops(bamDataRanges)

4

3 Input of cn.mops: BAM files, GRanges objects, or numeric matrices

3. Visualization of the detected CNV regions. For more information about the result objects

and visualization see Section 4.2.

> plot(res,which=1)

3 Input of cn.mops: BAM files, GRanges objects, or numeric matri-

ces

3.1 Read count matrices as input

cn.mops does not require the data samples to be of any specific kind or structure. cn.mops only
requires a read count matrix, i.e., given N data samples and m genomic segments, this is an m×N
real- or integer-valued matrix X, in which an entry xij corresponds to the read count of sample
j in the i-th segment. E.g. in the following read count matrix sample three has 17 reads in the
second segment: x23 = 71.

050100150Normalized Read CountschrA: 48325001 − 48900000Read Count−5−4−3−2−10Local AssessmentschrA: 48325001 − 48900000Local Assessment Score0.00.40.81.2Read Count RatioschrA: 48325001 − 48900000Ratio−5−4−3−2−10CNV CallchrA: 48325001 − 48900000CNV Call Value3 Input of cn.mops: BAM files, GRanges objects, or numeric matrices

5

Sample 1 Sample 2 Sample 3 Sample 4



X =

Segment 1
Segment 2
Segment 3
Segment 4
Segment 5
Segment 6









88
83
43
47
73
92

82
78
50
58
86
90

79
71
55
48
95
80

101
99
37
42
91
71









cn.mops can handle numeric and integer matrices or GRanges objects, in which the read

counts are stored as values of the object.

3.2 BAM files as input

The most widely used file format for aligned short reads is the Sequence Alignment Map (SAM)
format or in the compressed form the Binary Alignment Map (BAM). We provide a simple func-
tion that makes use of the Rsamtools package to obtain the alignment positions of reads. The
result object of the function can directly be used as input for cn.mops. The author can provide
functions for input formats other than BAM upon request: cn.mops@bioinf.jku.at .

> BAMFiles <- list.files(system.file("extdata", package="cn.mops"),pattern=".bam$",
+
> bamDataRanges <- getReadCountsFromBAM(BAMFiles,
+

sampleNames=paste("Sample",1:3))

full.names=TRUE)

In bamDataRanges you have now stored the genomic segments (left of the |’s) and the read

counts (right of the |’s):

> (bamDataRanges)

GRanges object with 2522 ranges and 3 metadata columns:

Sample 1

ranges strand |

seqnames
<Rle>
20
20
20
20
20
...

<IRanges>
1-25000
25001-50000
50001-75000
75001-100000
100001-125000
...
20 62925001-62950000
20 62950001-62975000
20 62975001-63000000
20 63000001-63025000
20 63025001-63025520

[1]
[2]
[3]
[4]
[5]
...
[2518]
[2519]
[2520]
[2521]
[2522]
-------
seqinfo: 1 sequence from an unspecified genome

Sample 2 Sample 3
<Rle> | <integer> <integer> <integer>
0
0
784
0
0
...
0
0
0
0
0

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

0
0
762
0
0
...
0
0
0
0
0

0
0
848
0
0
...
0
0
0
0
0

6

4 Copy number estimation with cn.mops

4 Copy number estimation with cn.mops

To get a first impression, we use a data set, in which CNVs have been artificially implanted.
The simulated data set was generated using distributions of read counts as they appear in real
sequencing experiments. CNVs were implanted under the assumption that the expected read count
is linear dependent on the copy number. For example in a certain genomic we expect λ reads for
copy number 2, then we expect 2λ reads for copy number 4. The linear relationship was confirmed
in different studies, like Alkan et al. (2009), Chiang et al. (2008) and Sathirapongsasuti et al.
(2011).

4.1 Running cn.mops

The read counts are stored in the objects X and XRanges, which are the two basic input types that
cn.mops allows:

> data(cn.mops)
> ls()

[1] "BAMFiles"
[5] "bamDataRanges" "cn.mopsVersion" "exomeCounts"

"CNVRanges"

"X"

"XRanges"
"resCNMOPS"

The same data is stored in a GRanges object, in which we see the genomic coordinates, as well

as the read counts (values):

> head(XRanges[,1:3])

GRanges object with 6 ranges and 3 metadata columns:

S_1

S_2

ranges strand |

seqnames
<IRanges>
<Rle>
1-25000
chrA
25001-50000
chrA
50001-75000
chrA
75001-100000
chrA
chrA 100001-125000
chrA 125001-150000

S_3
<Rle> | <integer> <integer> <integer>
109
100
82
106
89
91

[1]
[2]
[3]
[4]
[5]
[6]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

102
118
85
87
87
87

* |
* |
* |
* |
* |
* |

93
99
81
116
68
91

We are now ready to run cn.mops on the GRanges object:

> resCNMOPS <- cn.mops(XRanges)

To calculate integer copy number use the command calcIntegerCopyNumbers:

> resCNMOPS <- calcIntegerCopyNumbers(resCNMOPS)

4 Copy number estimation with cn.mops

7

Alternatively, it is possible to use an integer matrix, in which the genomic coordinates can
be stored as rownames and the entries are the read counts. For example the data from above
represented by an integer matrix X:

> head(X[,1:3])

Chr_A_1_25000
Chr_A_25001_50000
Chr_A_50001_75000
Chr_A_75001_100000
Chr_A_100001_125000 87
Chr_A_125001_150000 87

S_1 S_2 S_3
102 93 109
99 100
118
85 81
82
87 116 106
89
68
91
91

We are now ready to run cn.mops on the integer matrix:

> resCNMOPSX <- cn.mops(X)

To calculate integer copy number use the command calcIntegerCopyNumbers:

> resCNMOPSX <- calcIntegerCopyNumbers(resCNMOPSX)

Note that the two results resCNMOPS and resCNMOPSRanges identify the same CNVs:

> all(individualCall(resCNMOPSX)==individualCall(resCNMOPS))

4.2 The result object

To get a summary of the CNV detection result, just enter the name of the object (which implicitly
calls show):

> (resCNMOPS)

The CNVs per individual are stored in the slot cnvs:

> cnvs(resCNMOPS)[1:5]

GRanges object with 5 ranges and 4 metadata columns:

ranges strand | sampleName

seqnames
<Rle>
chrA
1775001-1850000
53300001-53400000
chrA
chrA 113175001-113325000
48575001-48650000
chrA
70625001-70750000
chrA
CN

median
<IRanges> <Rle> | <character> <numeric>
S_1 -1.00000
-5.32193
S_1
S_1 -0.99991
-5.32193
S_2
-5.32193
S_2

* |
* |
* |
* |
* |

mean

[1]
[2]
[3]
[4]
[5]

8

4 Copy number estimation with cn.mops

<numeric> <character>
CN1
CN0
CN1
CN0
CN0

[1] -0.999999
[2] -5.321928
[3] -0.999682
[4] -5.321928
[5] -5.321928
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

Segments, in which individual CNVs accumulate, are called CNV regions and can be accessed

by cnvr:

> cnvr(resCNMOPS)[1,1:5]

GRanges object with 1 range and 5 metadata columns:
S_1

seqnames
<Rle>

ranges strand |

S_2
<IRanges> <Rle> | <character> <character>
CN2

* |

CN1

[1]

chrA 1775001-1850000

S_3

S_5
<character> <character> <character>
CN2

S_4

CN2

[1]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

CN2

We now want to check, whether cn.mops found the implanted CNVs. We have stored the

implanted CNVs (see beginning of Section ) in the object CNVRanges.

> (CNVRanges[15,1:5])

GRanges object with 1 range and 5 metadata columns:

seqnames
<Rle>

ranges strand |

S_3
<IRanges> <Rle> | <integer> <integer> <integer>
2

S_2

* |

S_1

1

2

[1]

chrA 1751017-1850656

S_4

S_5
<integer> <integer>
2

2

[1]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

Next we identify overlaps between CNVs that were detected by cn.mops and CNVs that were

implanted. Towards this end we use the functions of the GenomicRanges package.

> ranges(cnvr(resCNMOPS))[1:2]

5 Visualization of the result

9

IRanges object with 2 ranges and 0 metadata columns:

end

start

width
<integer> <integer> <integer>
75000
75000

1775001
5525001

1850000
5600000

[1]
[2]

> ranges(cnvr(resCNMOPS)) %over% ranges(CNVRanges)

[1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE

[15] TRUE TRUE TRUE TRUE TRUE

The detected CNV regions all overlap with the known CNV regions contained in CNVRanges.

The function cn.mops creates an instance of the S4 class CNVDetectionResult that is de-
fined by the present package. To get detailed information on which data are stored in such objects,
enter

> help(CNVDetectionResult)

5 Visualization of the result

5.1 Chromosome plots

cn.mops allows for plotting the detected segments of an individual at one chromosome by a plot
similar to the ones produced by DNAcopy:

> segplot(resCNMOPS,sampleIdx=13)

10

5 Visualization of the result

Figure 1: The x-axis represents the genomic position and on the y-axis we see the log ratio of the
read counts (green) and the copy number call of each segment (red).

5.2 CNV region plots

cn.mops allows for plotting the detected CNV regions:

> plot(resCNMOPS,which=1)

0.0e+002.0e+074.0e+076.0e+078.0e+071.0e+081.2e+08−1.0−0.50.00.51.0Chromosome chrAmaplocS_136 Exome sequencing data

11

Figure 2: The x-axis represents the genomic position and on the y-axis we see the read counts
(left), the call of the local model (middle) and the CNV call produced by the segmentation algo-
rithm. Blue lines mark samples having a copy number loss.

6 Exome sequencing data

To apply cn.mops to exome sequencing data requires a different preprocessing, since constant
windows spanning the whole genome are not appropiate. The initial segments in which the reads
are counted should be chosen as the regions of the baits, targets or exons. The read count matrix
can now be generated by using the function getSegmentReadCountsFromBAM that requires the
genomic coordinates of the predefined segments as GRanges object. The resulting read count

050100150Normalized Read CountschrA: 1525001 − 2100000Read Count−5−4−3−2−10Local AssessmentschrA: 1525001 − 2100000Local Assessment Score0.00.40.81.2Read Count RatioschrA: 1525001 − 2100000Ratio−5−4−3−2−10CNV CallchrA: 1525001 − 2100000CNV Call Value12

6 Exome sequencing data

matrix can directly be used as input for cn.mops. A possible processing script could look like the
following:

> library(cn.mops)
> BAMFiles <- list.files(pattern=".bam$")
> segments <- read.table("targetRegions.bed",sep="\t",as.is=TRUE)
> gr <- GRanges(segments[,1],IRanges(segments[,2],segments[,3]))
> X <- getSegmentReadCountsFromBAM(BAMFiles,GR=gr)
> resCNMOPS <- exomecn.mops(X)
> resCNMOPS <- calcIntegerCopyNumbers(resCNMOPS)

We included an exome sequencing data set in this package. It is stored in exomeCounts.

> resultExomeData <- exomecn.mops(exomeCounts)
> resultExomeData

<- calcIntegerCopyNumbers(resultExomeData )

> plot(resultExomeData,which=5)

6 Exome sequencing data

13

Figure 3: ExomeSeq data results.

Possible issues and notes A problem can occur, if the names of the reference sequences, e.s.
chromosomes, are inconsistent between the bed file and the bam file. For example "chr1", "chr2",...,"chrX","chrY"
and "1","2",...,"X","Y".This can easily be solved by replacing the seqlevels of the GRanges object:

> #the following removes the "chr" from reference sequence names
> library(Seqinfo)
> seqlevels(gr) <- gsub("chr","",seqlevels(gr))

Results can also be improved if you extend your target regions by a small amount of bases to

the left and to the right (in the following case it is 30bp):

050100150200Normalized Read Counts22: 38895374 − 39084036Read Count−1.0−0.50.00.51.0Local Assessments22: 38895374 − 39084036Local Assessment Score0.51.01.52.0Read Count Ratios22: 38895374 − 39084036Ratio0.00.20.40.60.8CNV Call22: 38895374 − 39084036CNV Call Value14

8 Heterosomes and CNVs of tumor samples

> gr <- GRanges(segments[,1],IRanges(segments[,2]-30,segments[,3]+30))
> gr <- reduce(gr)

7 Cases vs. Control or Tumor vs. Normal

For detection of CNVs in a setting in which the normal state is known, the function referencecn.mops
can be applied. It implements the cn.MOPS algorithm adjusted to this setting. For tumor samples
very high copy numbers can be present – the maximum copy number with the default setting is 8
– and cn.mops has to be adjusted to allow higher copy numbers.

> resRef <- referencecn.mops(cases=X[,1],controls=rowMeans(X),
+
+
+
+

classes=c("CN0", "CN1", "CN2", "CN3", "CN4", "CN5", "CN6",
"CN7","CN8","CN16","CN32","CN64","CN128"),

I = c(0.025, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 8, 16, 32, 64),
segAlgorithm="DNAcopy")

Analyzing: Sample.1

> resRef <- calcIntegerCopyNumbers(resRef)
> (cnvs(resRef))

GRanges object with 4 ranges and 4 metadata columns:
ranges strand |

sampleName

seqnames

median

mean
<Rle> | <character> <numeric> <numeric>
0.5850
-5.3219
-2.6610
-1.0000

Case_1 0.584963
Case_1 -5.321928
Case_1 -2.660964
Case_1 -1.000000

* |
* |
* |
* |

[1]
[2]
[3]
[4]

<Rle> <IRanges>
undef 2029-2032
undef 2133-2136
undef 4051-4054
undef 4528-4533
CN
<character>
CN3
CN0
CN1
CN1

[1]
[2]
[3]
[4]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

8 Heterosomes and CNVs of tumor samples

With the default settings the normalization procedure assumes that the ploidy of each sample is the
same. However, it is possible to account for different karyotypes. When analyzing CNVs on the
X or Y chromosome one possibility is to treat males and females separately. The second option
is to provide the normalization function with the information about the gender, that is different

8 Heterosomes and CNVs of tumor samples

15

ploidy states of the X and Y chromosome. This can be handled by the ploidy parameter of the
normalization function. In the following we show the normalization for the X chromosome, if the
first 10 individuals are males (ploidy set to 1) and the next 30 individuals are females (ploidy
set to 2):

> XchrX <- normalizeChromosomes(X[1:500, ],ploidy=c(rep(1,10),rep(2,30)))
> cnvr(calcIntegerCopyNumbers(cn.mops(XchrX,norm=FALSE)))

GRanges object with 1 range and 40 metadata columns:
ranges strand |

seqnames

S_1

<Rle> <IRanges>
1-500
undef

S_3
<Rle> | <character> <character> <character>
CN1

* |

S_2

CN1

CN1

[1]

[1]

[1]

[1]

[1]

[1]

[1]

[1]

S_5

S_4

S_7

S_6

CN1
S_9

CN1
S_14

CN2
S_19

CN1
S_10

CN1
S_15

CN1
S_20

CN1
S_11

CN2
S_16

CN1
S_12

CN1
S_17

S_8
<character> <character> <character> <character> <character>
CN1
S_13
<character> <character> <character> <character> <character>
CN2
S_18
<character> <character> <character> <character> <character>
CN2
S_23
<character> <character> <character> <character> <character>
CN2
S_28
<character> <character> <character> <character> <character>
CN1
S_33
<character> <character> <character> <character> <character>
CN2
S_38
<character> <character> <character> <character> <character>
CN0

CN1
S_22

CN1
S_32

CN2
S_27

CN2
S_37

CN2
S_21

CN2
S_31

CN2
S_26

CN2
S_36

CN2
S_30

CN2
S_25

CN2
S_35

CN2
S_29

CN2
S_24

CN2
S_34

CN2

CN2

CN2
S_39

CN2
S_40
<character> <character>
CN1

CN2

[1]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

Karyotype information can also improve results of CNV detection in tumor samples. The best
results can be reached, if for each chromosome the number of appearances in the cell is known. In
this case normalization should be applied to each chromosome separately.

16

11 Overview of study designs and cn.mops functions

9 cn.mops for haploid genomes

For haploid genomes the prior assumption is that all samples have copy number 1. The function
haplocn.mops implements the cn.MOPS algorithm adjusted to haploid genomes.

> resHaplo <- haplocn.mops(X)
> resHaplo <- calcIntegerCopyNumbers(resHaplo)

10 Adjusting sensitivity, specificity and resolution for specific appli-

cations

The default parameters of both the local models of cn.mops and the segmentation algorithm were
optimized on a wide ranged of different data sets. However, you might want to adjust sensitivity
and specificity or resolution to your specific needs.

upperThreshold The calling threshold for copy number gains, a positive value. Lowering the threshold will

increase the detections, raising will decrease the detections.

lowerThreshold The calling threshold for copy number losses, a negative value. Raising the threshold will

increase the detections, lowering will decrease the detections.

priorImpact This parameter should be optimized for each data set, since it is influenced by number of
samples as well as noise level. The higher the value, the more samples will have copy
number 2, and consequently less CNVs will be detected.

minWidth The minimum length of CNVs measured in number of segments. The more adjacent seg-
ments with a high or low copy number call are joined, the higher the confidence in the
detections. A lower value will lead to more shorter segments, and a higher value will yield
to less, but longer segments.

The length of the initial segments is also crucial. They should be chosen such that on average
50 to 100 reads lie in one segment. The WL parameter of getReadCountsFromBAM determines this
resolution.

11 Overview of study designs and cn.mops functions

In Table1 we give an overview of the functions implemented in this package and present settings
for which they are appropriate. All these functions work for multiple, at least two, samples.CNV
detection for single samples usually yields many false detections, because of characteristics of
genomic segments that lead to a higher or lower read count (and coverage). These biases can
usually not be corrected for (except for the GC content and the mappability bias). Being aware
of all these problems we have implemented the function singlecn.mops for cases in which only
one sample is available.

12 Exporting cn.MOPS results in tabular format

17

Seq. Type Ploidy Study

WGS
WGS
ES
ES
WGS
WGS
ES
ES

2n
2n
2n
2n
1n
1n
1n
1n

cohort/non-tumor/GWAS
tumor vs. normal
cohort/non-tumor/GWAS
tumor vs. normal
cohort/non-tumor/GWAS
tumor vs. normal
cohort/non-tumor/GWAS
tumor vs. normal

Samples Function
cn.mops
referencecn.mops
exomecn.mops
referencecn.mops
haplocn.mops
not implemented
haplocn.mops
not implemented

≥5
≥2
≥5
≥2
≥5
≥2
≥5
≥2

Table 1: Seq. Type reports the sequencing technology that was used: whole genome sequencing
(WGS) or targeted/exome sequencing (ES). Ploidy gives the usual ploidy of the samples.
In
case of a tumor vs. control study the control sample is meant. Study: The type of study to
be analyzed for CNVs: either a cohort study, such the HapMap or the 1000Genomes Project,
or studies including a number of non-tumor samples or studies with both healthy and diseased
individuals, i.e. genome wide association studies (GWAS). Samples reports the minimum number
of samples needed for the analysis. Function gives the function of the cn.mops package that is
appropriate for this setting.

12 Exporting cn.MOPS results in tabular format

Users can extract the segmentation, the CNVs and the CNV regions with the following:

> library(cn.mops); data(cn.mops)
> result <- calcIntegerCopyNumbers(cn.mops(XRanges))
> segm <- as.data.frame(segmentation(result))
> CNVs <- as.data.frame(cnvs(result))
> CNVRegions <- as.data.frame(cnvr(result))

The results can be exported with write.csv for Excel, LibreOffice Calc, etc. These files will

include the genomic position, copy number and other information.

> write.csv(segm,file="segmentation.csv")
> write.csv(CNVs,file="cnvs.csv")
> write.csv(CNVRegions,file="cnvr.csv")

18

REFERENCES

13 How to cite this package

If you use this package for research that is published later, you are kindly asked to cite it as follows:
(Klambauer et al., 2012).

To obtain BibTEX entries of the reference, you can enter the following into your R session:

> toBibtex(citation("cn.mops"))

References

Alkan, C., Kidd, J. M., Marques-Bonet, T., Aksay, G., Antonacci, F., Hormozdiari, F., Kitzman, J. O., Baker, C., Malig, M., Mutlu, O., Sahinalp, S. C.,
Gibbs, R. A., and Eichler, E. E. (2009). Personalized copy number and segmental duplication maps using next-generation sequencing. Nat. Genet.,
41(10), 1061–1067.

Chiang, D. Y., Getz, G., Jaffe, D. B., Zhao, X., Carter, S. L., Russ, C., Nusbaum, C., Meyerson, M., and Lander, E. S. (2008). High-resolution mapping

of copy-number alterations with massively parallel sequencing. Nat. Methods, 6, 99–103.

Klambauer, G., Schwarzbauer, K., Mitterecker, A., Mayr, A., Clevert, D.-A., Bodenhofer, U., and Hochreiter, S. (2012). cn.MOPS: Mixture of Poissons
for Discovering Copy Number Variations in Next Generation Sequencing Data with a Low False Discovery Rate. Nucleic Acids Research, 40(9), e69.

Sathirapongsasuti, F. J., Lee, H., Horst, B. A., Brunner, G., Cochran, A. J., Binder, S., Quackenbush, J., and Nelson, S. F. (2011). Exome Sequencing-

Based Copy-Number Variation and Loss of Heterozygosity Detection: ExomeCNV. Bioinformatics, 27(19), 2648–2654.

