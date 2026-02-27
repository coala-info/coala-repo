Bioconductor NGScopy: User’s Guide (1.16.1)

A fast and robust algorithm to detect copy number variations by
(cid:16)restriction-imposed windowing(cid:17) in next generation sequencing

Xiaobei Zhao*1

1Lineberger Comprehensive Cancer Center, University of North Carolina at Chapel Hill

Modi(cid:28)ed: 2015-10-07 Compiled: 2019-1-4

You may (cid:28)nd the latest version of NGScopy and this documentation at,
Latest stable release: http://www.bioconductor.org/packages/release/bioc/html/NGScopy.html
Latest devel release: http://www.bioconductor.org/packages/devel/bioc/html/NGScopy.html

Keywords: Sequencing, Copy Number Variation, DNASeq, Targeted Panel Sequencing, Whole Exome Se-
quencing, Whole Genome Sequencing, Parallel Processing

Contents

1 Introduction

1.1 Requirement and scope

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1.2 Package installation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1.3 A quick start . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 Case study I: copy number detection of a case (tumor) sample compared to a control

(normal) sample

2.1 Create an instance of NGScopy class . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2.2 Review the input . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2.3 Process reads in the control (normal) sample (Make windows as well) . . . . . . . . . . . . . . .

2.4 Process reads in the case (tumor) sample

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2.5 Compute/Process the relative copy number ratios and save it . . . . . . . . . . . . . . . . . . .

2.6 Compute/Process the segmentation and save it . . . . . . . . . . . . . . . . . . . . . . . . . . .

2.7 Save the output for later reference . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2.8 Load and review the output . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

3

3

3

5

5

6

7

7

8

8

8

8

2.9 Visualize the output . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

10

*

Lineberger Comprehensive Cancer Center, University of North Carolina at Chapel Hill, 450 West Dr, Chapel Hill, NC 27599,

USA. xiaobei@binf.ku.dk

1

Bioconductor NGScopy

Zhao, Xiaobei

3 Case Study I(b): Analyzing the entire chromosome

4 Case Study I(c): Choosing types of segmentation

5 Case study II: copy number detection of multiple case (tumor) samples compared to a

common control (normal) sample

5.1 Process the common control (normal) sample . . . . . . . . . . . . . . . . . . . . . . . . . . . .

5.2 Process a case (tumor) sample

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

5.3 Process a second case (tumor) sample . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

5.4 Visualize the output . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

6 Case Study II(b): Analyzing the entire chromosome

7 Run NGScopy from command line

7.1 Get the path of the executable R script

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

7.2 Get help . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

7.3 An example . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Acknowledgement

Appendix A The source code

A.1 The source code for the case study I

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

A.2 The source code for the case study II . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

A.3 The command-line executable R script . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

A.4 The command-line example Bash (Unix shell) script and the output

. . . . . . . . . . . . . . .

Appendix B Comparison with full-scale NGS data

1

Introduction

12

13

15

15

16

17

19

20

21

21

21

22

24

25

26

29

31

34

38

Copy number variation (CNV) is a segment of DNA (> 50 basepair, bp) that has unbalanced number of copies
(additions or deletions) with comparison to a control genome [3, 4, 7]. CNVs from 50 bp to 1 kilobase (kb)
are also considered as larger indels. CNVs are widely spread throughout the genome, cumulatively accounting
for more than one tens of the human genomic DNA and encompassing a large number of our genes [10, 11].
Genomic studies have provided insights into the role of CNVs in health and disease (reviewed in [1, 9, 4]),
unveiling the contribution of CNVs in disease pathogenesis.

For over a decade, microarray-based comparative genomic hybridization (arrayCGH or aCGH) and single
nucleotide polymorphism microarrays (SNP array) have been de facto standard technologies to detect genomic
loci subject to CNVs until the emergence of next-generation sequencing (NGS) technologies providing high-
resolution DNA sequence data for CNV analysis.

There are three common modes of DNA sequencing: whole genome sequencing (WGS), whole exome sequencing
(WES) and targeted panel sequencing (TPS). TPS, as a cost-e(cid:27)ective solution, has been widely applied to
simultaneously pro(cid:28)le cancer-related genes, for instance to (cid:28)nd somatic mutations. However, CNV analysis
by TPS data has been progressing slowly due to the sparse and inhomogeneous nature of the targeted capture
reaction in TPS than in WGS or WES. To address these unique properties, NGScopy provides a (cid:16)restriction-
imposed windowing(cid:17) approach to generate balanced number of reads per window [14], enabling a robust CNV
detection in TPS, WES and WGS.

2

Bioconductor NGScopy

Zhao, Xiaobei

1.1 Requirement and scope

This version of User’s Guide introduces the functionality of NGScopy by case studies. NGScopy requires a
pair of samples in BAM (.bam) (cid:28)les to produce relative copy number ratios (CNRs) between a case and a
control samples. In cancer research, the case is typically a tumor sample and the control is usually a matched
or pooled normal sample, preferably under the same target enrichment protocol as the case.

Major functionality includes,

• Making windows by the control sample

• Counting reads per window in the control sample

• Counting reads per window in the case sample

• Computing relative CNRs between the case and the control

• Segmentation

• Visualization

The above functions have been intensively tested, and we plan to develop and incorporate more related
functionality for CNV analysis. Currently, the BAM (cid:28)le parser is integrated by using the R (CRAN ) package
rbamtools [5] and the segmentation is integrated by using the R (CRAN ) package changepoint [6]. Users
can also retrieve and modify the produced CNRs and try one of many other available segmentation algorithms,
such as BioHMM [8].

1.2 Package installation

> ## install NGScopy
> if (!requireNamespace("BiocManager", quietly=TRUE))
+
> BiocManager::install("NGScopy")

install.packages("BiocManager")

> ## install NGScopyData for example data sets used in this guide
> BiocManager::install("NGScopyData")

1.3 A quick start

A typical NGScopy analysis uses a pair of normal/tumor samples to detect the relative CNRs (in log2). It
assumes there are two libraries of DNA sequencing read alignments in BAM format, sorted and with index.
The total size of each library is also known.

We can either perform the NGScopy analysis using a single processor (pcThreads=1 as below) or parallelize
a NGScopy call across chromosomes or regions by setting pcThreads larger than 1 and up to the appropriate
processor/memory limit of the system.

> ## Load R libraries
> require("NGScopy")
> require("NGScopyData")

3

Bioconductor NGScopy

Zhao, Xiaobei

‘

’

class

NGScopy

# specified directory for output

> ## Create an instance of
> obj <- NGScopy$new(
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

outFpre="ngscopy-case1",
inFpathN=tps_N8.chr6()$bamFpath, # normal sample: tps_90.chr6.sort.bam
inFpathT=tps_90.chr6()$bamFpath, # tumor sample:
tps_N8.chr6.sort.bam
libsizeN=5777087,
libsizeT=4624267,
mindepth=20,
minsize=20000,
regions=NULL,
segtype="mean.cusum",
dsN=1,
dsT=1,
pcThreads=1
)

# the library size of the normal sample
# the library size of the tumor sample
# the minimal depth of reads per window
# the minimal size of a window
# the regions, set to NULL for the entire genome
# the type of segmentation
# the downsampling factor of the normal
# the downsampling factor of the tumor
# the number of processors for computing

> ## Compute the relative CNRs and save it
> ## A data.frame will be saved to file
> obj$write_cn()

‘

> ## Compute the segmentation and save it
‘
> ## A data.frame will be saved to file
> obj$write_segm()

’

’

ngscopy_cn.txt

in the output directory

ngscopy_segm.txt

in the output directory

> ## Plot he relative CNRs with the segmentation
> ## Figure(s) will be saved to file
> obj$plot_out()

‘

’

ngscopy_out.pdf

in the output directory

In the above code, we use the data provided in Bioconductor NGScopyData package [13]. We (cid:28)rst create
an instance of NGScopy class, an R reference class [2]. Calling the method write_cn automatically calls the
method proc_normal, proc_tumor, calc_cn, proc_cn and write_cn in a row to perform window making,
read counting in both samples, CNR computing and results processing and saves it in a tab separated (cid:28)le.
Calling the method write_segm automatically calls the method calc_segm, proc_segm and write_segm in a
row to perform segmentation and results processing and saves it in a tab separated (cid:28)le. Finnaly we visualize
the results and save it in a pdf (cid:28)le.

This small piece of code provides a compact solution. You may also refer to a functional equivalent step-by-step
approach described below in (cid:16)Case study I(cid:17).

4

Bioconductor NGScopy

Zhao, Xiaobei

2 Case study I: copy number detection of a case (tumor) sample

compared to a control (normal) sample

This section provides a step-by-step guide to using NGScopy for copy number detection of a tumor sample
compared to a pooled normal sample, similar steps for a matched normal. A complete source code of this case
study is in Appendix A.1 on page 26.

We will begin with a case study using the DNA sequencing data, BAM (cid:28)les of TPS reads mapped to the
human chromossome 6 (hg19), provided in Bioconductor NGScopyData package [13]. With limited space in
the data package (NGScopyData), each of these samples is a 10 percent random subsample drawn from the
original sequencing data [14]. A later comparison and discussion of this 10% subsample with the original full
data set reveals an ability of NGScopy to capture similar chromosome-wide CNV patterns (Appendix B on
page 38).

We are presenting the CNV detection of a human lung tumor sample (tps_90,chr6) against a pooled normal
sample (tps_N8,chr6). For fast compiling of this vignette, we limit our analysis to a subset region of each
BAM (cid:28)le: chr6 : 41000001 − 81000000, 20M b upstream/downstream of the centromere. To do this, we assign
an interval to the parameter regions which follows the BED format of zero-based, half-open intervals, i.e.
(start, end].

For normalization purpose, we also need to assign the library sizes (libsizeN and libsizeT). The library size
of one sample is usually the total number reads of all chromosomes throughout the entire genome in the BAM
(cid:28)le. Because our example BAM (cid:28)les only contain reads from chr6, the library sizes are computed according
to the sequecning reads across all chromosomes of each sample in advance.

There are two windowing parameters mindepth and minsize, indicating the minimal depth and size required
to build a window. We can tune these two parameters according to the coverage characteristics of the samples.
Generally, sparser libraries (e.g. TPS) require a larger minsize while denser libraries (e.g. WES and WGS)
can have a smaller minsize.

We can also adjust the downsampling factor (an integer no less than 1). By setting the downsampling factor to
n, we randomly sample 1/n of the reads in the sample. For samples with very high depth of coverage, setting
a larger downsampling factor would help speed up, however, with possible loss of resolution (Appendix B on
page 38).

2.1 Create an instance of NGScopy class

# specified directory for output

outFpre="ngscopy-case1",
inFpathN=tps_N8.chr6()$bamFpath, # normal sample: tps_90.chr6.sort.bam
inFpathT=tps_90.chr6()$bamFpath, # tumor sample:
tps_N8.chr6.sort.bam
libsizeN=5777087,
libsizeT=4624267,
mindepth=20,
minsize=20000,
regions=read_regions("chr6 41000000 81000000"),

# the library size of the normal sample
# the library size of the tumor sample
# the minimal depth of reads per window
# the minimal size of a window

> require(NGScopy)
> require(NGScopyData)
> obj <- NGScopy$new(
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

segtype="mean.norm",
dsN=1,
dsT=1,
pcThreads=1
)

# the regions, set to NULL for the entire genome
# the type of segmentation
# the downsampling factor of the normal
# the downsampling factor of the tumor
# the number of processors for computing

5

Bioconductor NGScopy

Zhao, Xiaobei

> obj$show()

# print the instance

inFpathN: /home/biocbuild/bbs-3.8-bioc/R/library/NGScopyData/extdata/tps_N8.chr6.sort.bam
inFpathT: /home/biocbuild/bbs-3.8-bioc/R/library/NGScopyData/extdata/tps_90.chr6.sort.bam
outFpre: ngscopy-case1
libsizeN: 5777087
libsizeT: 4624267
mindepth: 20
minsize: 20000
regions:
chr6 41000000 81000000
segtype: c("mean.norm")
dsN: 1
dsT: 1
auto.save: FALSE
auto.load: FALSE

2.2 Review the input

> ## Get the input files
> obj$get_inFpathN()

[1] "/home/biocbuild/bbs-3.8-bioc/R/library/NGScopyData/extdata/tps_N8.chr6.sort.bam"

> obj$get_inFpathT()

[1] "/home/biocbuild/bbs-3.8-bioc/R/library/NGScopyData/extdata/tps_90.chr6.sort.bam"

> ## Get the library sizes
> obj$get_libsizeN()

[1] 5777087

> obj$get_libsizeT()

[1] 4624267

> ## Get the windowing parameters
> obj$get_mindepth()

[1] 20

> obj$get_minsize()

[1] 20000

6

Bioconductor NGScopy

Zhao, Xiaobei

> ## Get the regions
> head(obj$get_regions())

chr

end
start
1 chr6 4.1e+07 8.1e+07

> ## Get the segmentation type(s)
> head(obj$get_segmtype())

[1] "mean.norm"

> ## Get the downsampling factors
> obj$get_dsN()

[1] 1

> obj$get_dsT()

[1] 1

> ## Get the number of processors
> obj$get_pcThreads()

[1] 1

> ## Get the chromosome names of the reference genome
> obj$get_refname()

[1] "chr1" "chr2"

"chr3"

"chr4"

"chr5"

"chr6" "chr7"

"chr8"

"chr9"

[10] "chr10" "chr11" "chr12" "chr13" "chr14" "chr15" "chr16" "chr17" "chr18"
[19] "chr19" "chr20" "chr21" "chr22" "chrX"

"chrM"

"chrY"

> ## Get the chromosome lengths of the reference genome
> obj$get_reflength()

chr9

chr1

chr2

chr3

chr8
249250621 243199373 198022430 191154276 180915260 171115067 159138663 146364022
chr16
141213431 135534747 135006516 133851895 115169878 107349540 102531392 90354753
chrY
59373566

chrX
51304566 155270560

chr21
48129895

chr19
59128983

chr20
63025520

chr18
78077248

chr22

chr11

chr10

chr12

chr13

chr14

chr15

chr4

chr5

chr6

chr7

chr17
81195210
chrM
16571

2.3 Process reads in the control (normal) sample (Make windows as well)

> obj$proc_normal()

# this may take a while

2.4 Process reads in the case (tumor) sample

7

Bioconductor NGScopy

Zhao, Xiaobei

> obj$proc_tumor()

# this may take a while

2.5 Compute/Process the relative copy number ratios and save it

> ## A data.frame will be saved to file
> obj$calc_cn()
> obj$proc_cn()
> obj$write_cn()

ngscopy_cn.txt

in the output directory

’

‘

‘

2.6 Compute/Process the segmentation and save it

> ## A data.frame will be saved to file
> obj$calc_segm()
> obj$proc_segm()
> obj$write_segm()

ngscopy_segm.txt

in the output directory

’

2.7 Save the output for later reference

> ## The NGScopy output is saved as a ngscopy_out.RData file in the output directory
> obj$saveme()

2.8 Load and review the output

> ## Load the output
> ## (optional if the previous steps have completed in the same R session)
> obj$loadme()

> ## Get the output directory
> obj$get_outFpre()

[1] "ngscopy-case1"

> ## Get the windows
> head(obj$get_windows())

chr

end
start
1 chr6 41000000 41031350
2 chr6 41031350 41101829
3 chr6 41101829 41144951
4 chr6 41144951 41171264
5 chr6 41171264 41204537
6 chr6 41204537 41238046

8

Bioconductor NGScopy

Zhao, Xiaobei

> ## Get the window sizes
> head(obj$get_size())

[1] 31350 70479 43122 26313 33273 33509

> ## Get the window positions (midpoints of the windows)
> head(obj$get_pos())

[1] 41015675 41066590 41123390 41158108 41187901 41221292

> ## Get the number of reads per window in the normal
> head(obj$get_depthN())

[1] 20 20 20 20 20 20

> ## Get the number of reads per window in the tumor
> head(obj$get_depthT())

[1] 23 22 19 20 17 18

> ## Get the data.frame of copy number calling
> data.cn <- obj$get_data.cn()

MoreArgs.cn: List of 2
$ pseudocount: num 1
$ logr

: logi TRUE

out$cn:List of 3

: num [1:567] 0.5138 0.4524 0.2507 0.3211 0.0987 ...

$ cnr
$ pseudocount: num 1
$ logr

: logi TRUE

> head(data.cn)

chr

start

end size

1 chr6 41000000 41031350 31350 41015675
2 chr6 41031350 41101829 70479 41066590
3 chr6 41101829 41144951 43122 41123390
4 chr6 41144951 41171264 26313 41158108
5 chr6 41171264 41204537 33273 41187901
6 chr6 41204537 41238046 33509 41221292

pos depthN depthT
20
20
20
20
20
20

cnr
23 0.5137626
22 0.4523621
19 0.2507282
20 0.3211175
17 0.0987251
18 0.1767276

9

Bioconductor NGScopy

Zhao, Xiaobei

> data.segm <- obj$get_data.segm()

MoreArgs.segm: list()
out$seg:List of 1

$ mean.norm:List of 1

’

’

cpt

: chr "mean"
: chr "PELT"

..$ chr6:Formal class
[package "changepoint"] with 12 slots
.. .. ..@ data.set : Time-Series [1:567] from 1 to 567: 0.5138 0.4524 0.2507 0.3211 0.0987 ...
.. .. ..@ cpttype
.. .. ..@ method
.. .. ..@ test.stat: chr "Normal"
.. .. ..@ pen.type : chr "SIC"
.. .. ..@ pen.value: num 12.7
.. .. ..@ minseglen: num 1
.. .. ..@ cpts
.. .. ..@ ncpts.max: num Inf
.. .. ..@ param.est:List of 1
.. .. .. ..$ mean: num [1:2] 0.0354 -0.4652
.. .. ..@ date
.. .. ..@ version

: chr "Fri Dec 21 18:36:11 2018"
: chr "2.2.2"

: int [1:2] 303 567

> head(data.segm)

chr win.from win.to

1 chr6
2 chr6

1
304

start

segtype
end
303 41000000 57590917
0.03536811 mean.norm
567 57590917 81000000 -0.46519165 mean.norm

mean

2.9 Visualize the output

> ## A figure will be saved to file
> obj$plot_out(ylim=c(-3,3))

‘

ngscopy_cn.pdf
‘

’

’

in the output directory

# reset

ylim

to NULL to allow full-scale display

10

Bioconductor NGScopy

Zhao, Xiaobei

Figure 1: Graphical output of (cid:16)Case study I(cid:17), showing CNVs of chr6 : 41000001 − 81000000 of sample tps_90
against tps_N8.

11

0.0e+005.0e+071.0e+081.5e+08−3−2−10123chr6 (mean.norm)PositonCNRBioconductor NGScopy

Zhao, Xiaobei

3 Case Study I(b): Analyzing the entire chromosome

So far, we have conducted the copy nunber detection on a subregion of a chromosome (chr6 : 41000001 −
81000000). Now we would like to apply such analysis on the entrie chromosome by setting the regions
accordingly, using the same data as in (cid:16)Case Study I(cid:17).

# specified directory for output

outFpre="ngscopy-case1b",
inFpathN=tps_N8.chr6()$bamFpath, # normal sample: tps_90.chr6.sort.bam
inFpathT=tps_90.chr6()$bamFpath, # tumor sample:
tps_N8.chr6.sort.bam
libsizeN=5777087,
libsizeT=4624267,
mindepth=20,
minsize=20000,
regions=read_regions("chr6 0 171115067"),

# the library size of the normal sample
# the library size of the tumor sample
# the minimal depth of reads per window
# the minimal size of a window

> obj <- NGScopy$new(
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

segtype="mean.norm",
dsN=1,
dsT=1,
pcThreads=1
)

# the regions, set to NULL for the entire genome
# the type of segmentation
# the downsampling factor of the normal
# the downsampling factor of the tumor
# the number of processors for computing

> ## Show the regions
> obj$get_regions()

chr start

end
0 171115067

1 chr6

We keep the rest codes intact and re-run them in the same order as in (cid:16)Case Study I(cid:17).

Figure 2: Graphical output of (cid:16)Case study I(b)(cid:17), showing CNVs of the entire chr6 of the sample tps_90 against the
sample tps_N8.

12

0.0e+005.0e+071.0e+081.5e+08−3−2−10123chr6 (mean.norm)PositonCNRBioconductor NGScopy

Zhao, Xiaobei

4 Case Study I(c): Choosing types of segmentation

The NGScopy package has integrated several external segmentation algorithms ([6]) to facilitate change-point
detection.

Currently there are 4 types of segmentation available, which can be obtained by the following code:

> NGScopy::parse_segmtype()

[1] "mean.norm"

"meanvar.norm" "mean.cusum"

"var.css"

Given a type of segmentation, we can get help of the algorithm by the code below, for instance,

> ## NGScopy::help_segmtype("mean.norm")

We can set the parameter segtype to either one or multiple values (separated by (cid:16)((cid:17),)) from the above.

> require(NGScopy)
> obj <- NGScopy$new()

> ## Set segtype with multiple values
> obj$set_segmtype("mean.norm,meanvar.norm,mean.cusum,var.css")

> ## Get segtype
> obj$get_segmtype()

[1] "mean.norm"

"meanvar.norm" "mean.cusum"

"var.css"

Using the same data and the same rest setting as in (cid:16)Case Study I(b)(cid:17), we have the chromosome segmented
in 4 ways,

13

Bioconductor NGScopy

Zhao, Xiaobei

Figure 3: Graphical output of (cid:16)Case study I(c)(cid:17), showing CNVs of the entire chr6 of the sample tps_90 against the
sample tps_N8 using 4 types of segmentation algorithms.

14

0.0e+005.0e+071.0e+081.5e+08−3−2−10123chr6 (mean.norm)PositonCN (log2)0.0e+005.0e+071.0e+081.5e+08−3−2−10123chr6 (meanvar.norm)PositonCN (log2)0.0e+005.0e+071.0e+081.5e+08−3−2−10123chr6 (mean.cusum)PositonCN (log2)0.0e+005.0e+071.0e+081.5e+08−3−2−10123chr6 (var.css)PositonCN (log2)Bioconductor NGScopy

Zhao, Xiaobei

5 Case study II: copy number detection of multiple case (tumor)

samples compared to a common control (normal) sample

This section provides a step-by-step guide to using NGScopy for copy number detection of multiple tumor
samples compared to a common normal sample, for instance, a pooled normal sample. We are about analyzing
two tumor samples (tps_90,chr6 and tps_27,chr6) against one common pooled normal (tps_N8,chr6),
provided in Bioconductor NGScopyData package [12], as described in (cid:16)Case study I(cid:17). A complete source code
of this case study is in Appendix A.2 on page 29.

5.1 Process the common control (normal) sample

We (cid:28)rst analyze the normal sample, make the windows, count the reads and save the output to use with each
of the tumor samples in Section 5.2 and Section 5.3.

> require(NGScopy)
> require(NGScopyData)

> ## Create an instance of
> obj <- NGScopy$new(pcThreads=1)

NGScopy

‘

’

class

> ## Set the normal sample
> obj$set_normal(tps_N8.chr6()$bamFpath)

> ## Set the regions
> regions <- read_regions("chr6 41000000 81000000")
> obj$set_regions(regions)

> ## Set the library size of the normal
> obj$set_libsizeN(5777087)

> ## Specify a directory for output
> ## It will be saved as "ngscopy_normal.RData" in this directory
> obj$set_outFpre("ngscopy-case2/tps_N8")

> ## Show the input
> obj$show()

inFpathN: /home/biocbuild/bbs-3.8-bioc/R/library/NGScopyData/extdata/tps_N8.chr6.sort.bam
outFpre: ngscopy-case2/tps_N8
libsizeN: 5777087
regions:
chr6 41000000 81000000
auto.save: FALSE
auto.load: FALSE

> ## Make windows and count reads in the normal
> obj$proc_normal()

> ## Save the output of the normal for later usage
> obj$save_normal()

15

Bioconductor NGScopy

Zhao, Xiaobei

5.2 Process a case (tumor) sample

Now we create a new NGScopy instance, load the result of the normal sample previously saved in Section 5.1
and set the parameters for the tumor sample to detect CNVs.

> ## Create an instance of
> obj1 <- NGScopy$new(pcThreads=1)

NGScopy

‘

’

class

> ## Load the previously saved output of the normal
> obj1$load_normal("ngscopy-case2/tps_N8")

> ## Set a tumor sample (ID: tps_90) and specify a directory for output
> obj1$set_tumor(tps_90.chr6()$bamFpath)
> obj1$set_outFpre("ngscopy-case2/tps_90")

> ## Set the library size of the tumor
> obj1$set_libsizeT(4624267)

> ## Show the input
> obj1$show()

inFpathN: /home/biocbuild/bbs-3.8-bioc/R/library/NGScopyData/extdata/tps_N8.chr6.sort.bam
inFpathT: /home/biocbuild/bbs-3.8-bioc/R/library/NGScopyData/extdata/tps_90.chr6.sort.bam
outFpre: ngscopy-case2/tps_90
libsizeN: 5777087
libsizeT: 4624267
mindepth: 20
minsize: 20000
regions:
chr6 41000000 81000000
segtype: c("mean.norm")
dsN: 1
auto.save: FALSE
auto.load: FALSE

> ## Process the tumor
> obj1$proc_tumor()

> ## Process the copy number
> obj1$proc_cn()

MoreArgs.cn: List of 2
$ pseudocount: num 1
$ logr

: logi TRUE

out$cn:List of 3

: num [1:567] 0.5138 0.4524 0.2507 0.3211 0.0987 ...

$ cnr
$ pseudocount: num 1
$ logr

: logi TRUE

16

Bioconductor NGScopy

Zhao, Xiaobei

> ## Process the segmentation
> obj1$proc_segm()

MoreArgs.segm: list()
out$seg:List of 1

$ mean.norm:List of 1

’

’

cpt

: chr "mean"
: chr "PELT"

..$ chr6:Formal class
[package "changepoint"] with 12 slots
.. .. ..@ data.set : Time-Series [1:567] from 1 to 567: 0.5138 0.4524 0.2507 0.3211 0.0987 ...
.. .. ..@ cpttype
.. .. ..@ method
.. .. ..@ test.stat: chr "Normal"
.. .. ..@ pen.type : chr "SIC"
.. .. ..@ pen.value: num 12.7
.. .. ..@ minseglen: num 1
.. .. ..@ cpts
.. .. ..@ ncpts.max: num Inf
.. .. ..@ param.est:List of 1
.. .. .. ..$ mean: num [1:2] 0.0354 -0.4652
.. .. ..@ date
.. .. ..@ version

: chr "Fri Dec 21 18:36:11 2018"
: chr "2.2.2"

: int [1:2] 303 567

> ## Plot
> obj1$plot_out(ylim=c(-3,3))

5.3 Process a second case (tumor) sample

Then we process a second tumor sample via similar steps as in Section 5.2.

> ## Create another instance of
> obj2 <- NGScopy$new(pcThreads=1)

‘

NGScopy

class

’

> ## Load the previously saved output of the normal
> obj2$load_normal("ngscopy-case2/tps_N8")

> ## Set a tumor sample (ID: tps_27) and specify a directory for output
> obj2$set_tumor(tps_27.chr6()$bamFpath)
> obj2$set_outFpre("ngscopy-case2/tps_27")

> ## Set the library size of the tumor
> obj2$set_libsizeT(10220498)

17

Bioconductor NGScopy

> ## Show the input
> obj2$show()

Zhao, Xiaobei

inFpathN: /home/biocbuild/bbs-3.8-bioc/R/library/NGScopyData/extdata/tps_N8.chr6.sort.bam
inFpathT: /home/biocbuild/bbs-3.8-bioc/R/library/NGScopyData/extdata/tps_27.chr6.sort.bam
outFpre: ngscopy-case2/tps_27
libsizeN: 5777087
libsizeT: 10220498
mindepth: 20
minsize: 20000
regions:
chr6 41000000 81000000
segtype: c("mean.norm")
dsN: 1
auto.save: FALSE
auto.load: FALSE

> ## Process the tumor
> obj2$proc_tumor()

> ## Process the copy number
> obj2$proc_cn()

MoreArgs.cn: List of 2
$ pseudocount: num 1
$ logr

: logi TRUE

out$cn:List of 3

: num [1:567] 0.177 0.07 -0.823 0.54 0.37 ...

$ cnr
$ pseudocount: num 1
$ logr

: logi TRUE

> ## Process the segmentation
> obj2$proc_segm()

MoreArgs.segm: list()
out$seg:List of 1

$ mean.norm:List of 1

’

’

cpt

: chr "mean"
: chr "PELT"

[package "changepoint"] with 12 slots

..$ chr6:Formal class
.. .. ..@ data.set : Time-Series [1:567] from 1 to 567: 0.177 0.07 -0.823 0.54 0.37 ...
.. .. ..@ cpttype
.. .. ..@ method
.. .. ..@ test.stat: chr "Normal"
.. .. ..@ pen.type : chr "SIC"
.. .. ..@ pen.value: num 12.7
.. .. ..@ minseglen: num 1
: int 567
.. .. ..@ cpts
.. .. ..@ ncpts.max: num Inf
.. .. ..@ param.est:List of 1
.. .. .. ..$ mean: num -0.0783
.. .. ..@ date
.. .. ..@ version

: chr "Fri Dec 21 18:36:11 2018"
: chr "2.2.2"

> ## Plot
> obj2$plot_out(ylim=c(-3,3))

18

Bioconductor NGScopy

Zhao, Xiaobei

5.4 Visualize the output

(a) ID: tps_90

(b) ID: tps_27

Figure 4: Graphical output of (cid:16)Case Study II(cid:17) on a subregion of chromosome 6, showing CNVs of the sample tps_90
and the sample tps_27 against a common normal sample tps_N8.

19

0.0e+005.0e+071.0e+081.5e+08−3−2−10123chr6 (mean.norm)PositonCNR0.0e+005.0e+071.0e+081.5e+08−3−2−10123chr6 (mean.norm)PositonCNRBioconductor NGScopy

Zhao, Xiaobei

6 Case Study II(b): Analyzing the entire chromosome

Similarly as we did in (cid:16)Case study II(cid:17), we apply the analysis to the entrie chromosome instead of the subregion
(chr6 : 41000001 − 81000000) by setting the parameter regions appropriately, as described in (cid:16)Case study
I(b)(cid:17).

> ## Create a new instance of
> obj <- NGScopy$new(pcThreads=1)

‘

NGScopy

class

’

> ## Set the normal sample
> obj$set_normal(tps_N8.chr6()$bamFpath)

> ## Read the regions from an external file
’
> regions <- Xmisc::get_extdata(

NGScopy

’

’

,

hg19_chr6_0_171115067.txt

’

)

> ## ## Or from a text input as we did before
> ## regions <- read_regions("chr6 0 171115067")

> ## Set the regions
> obj$set_regions(regions)

> ## Show the regions
> obj$get_regions()

chr start

end
0 171115067

1 chr6

We keep the rest codes intact and re-run them in the same order as in (cid:16)Case study II(cid:17) (Section 5.1, 5.2 and
5.3).

(a) ID: tps_90

(b) ID: tps_27

Figure 5: Graphical output of (cid:16)Case Study II(cid:17) on entire chromosome 6, showing CNVs of the sample tps_90 and the
sample tps_27 against a common normal sample tps_N8.

20

0.0e+005.0e+071.0e+081.5e+08−3−2−10123chr6 (mean.norm)PositonCN (log2)0.0e+005.0e+071.0e+081.5e+08−3−2−10123chr6 (mean.norm)PositonCN (log2)Bioconductor NGScopy

Zhao, Xiaobei

7 Run NGScopy from command line

An executable R script, ngscopy, is placed at the bin subdirectory under the top level package directory. A
complete source code of this executable is in Appendix A.3 on page 31.

In this section, we introduce and run this executable R script from a command line on Unix or a Unix-like
operating system.

7.1 Get the path of the executable R script

Given the NGScopy package is installed, we can obtain the path of the executable R script at the R prompt:

> system.file(

bin

,

ngscopy

, package=

NGScopy

, mustWork=TRUE)

’

’

’

’

’

’

[1] "/tmp/RtmpWc3gRE/Rinst674235f19e2a/NGScopy/bin/ngscopy"

> ## Or,
> Xmisc::get_executable(

’

NGScopy

)

’

[1] "/tmp/RtmpWc3gRE/Rinst674235f19e2a/NGScopy/bin/ngscopy"

Alternatively, we can extract this path at Unix-like command-line interface (CLI):

ngscopyCmd=$(Rscript -e "cat(system.file(
echo ${ngscopyCmd}

’

’

’

’

’

’

bin

,

ngscopy

,package=

NGScopy

, mustWork=TRUE))")

## Or,
ngscopyCmd=$(Rscript -e "cat(Xmisc::get_executable(
echo ${ngscopyCmd}

’

NGScopy

))")

’

7.2 Get help

${ngscopyCmd} -h

## Or,
${ngscopyCmd} --help

This will print the help page at the console,

21

Bioconductor NGScopy

Zhao, Xiaobei

Usage:

ngscopy [options]

Description:

ngscopy scans a pair of input BAM files to detect relative copy numb-

er variants.

Options:
h

logical

Print the help page. NULL

help

logical

Print the help page. NULL

inFpathN

character The file path to the control (normal) sample. NULL

inFpathT

character The file path to the case (tumor) sample. NULL

outFpre

character The file path of the directory for output. NULL

libsizeN

numeric

The library size of the control (normal) sample. NULL

libsizeT

numeric

The library size of the case (tumor) sample. NULL

mindepth

numeric

The minimal depth of reads per window. [ 20 ]

minsize

numeric

The minimal size of a window. [ 20000 ]

regions

character The regions, a text string or a file path indica-
ting the regions with three columns (chr/start/e-
nd) and without column names. [ NULL ]

segtype

character The type of segmentation. One of c("mean.norm","

meanvar.norm","mean.cusum","var.css"). Multiple
values are allowed and separated by ",". [ mean.norm ]

dsN

integer

The downsampling factor of the control (normal)
sample. [ 1 ]

dsT

integer

The downsampling factor of the test (tumor) samp-
le. [ 1 ]

pcThreads integer

The number of processors performing the parallel

computing. [ 1 ]

auto.save logical

Whether to save (any completed results) automati-
cally. [ FALSE ]

auto.load logical

Whether to load (any previously completed result-
s) automatically. [ FALSE ]

7.3 An example

Let’s run the command line version of the Case Study I(b).

22

Bioconductor NGScopy

Zhao, Xiaobei

ngscopyCmd=$(Rscript -e "cat(Xmisc::get_executable(

NGScopy

))")

’

’

## a normal sample, given the NGScopyData package is installed
inFpathN=$(Rscript -e "cat(Xmisc::get_extdata(

NGScopyData

,

’

’

’

tps_N8.chr6.sort.bam

))")

## a tumor sample, given the NGScopyData pack is installed
NGScopyData
inFpathT=$(Rscript -e "cat(Xmisc::get_extdata(

’

’

’

,

tps_90.chr6.sort.bam

))")

’

’

## set the regions, given the NGScopy package is installed
regions=$(Rscript -e "cat(Xmisc::get_extdata(

NGScopy

,

’

’

’

hg19_chr6_0_171115067.txt

’

))")

time ${ngscopyCmd} --inFpathN=${inFpathN} --inFpathT=${inFpathT} --outFpre="ngscopy-case1b-cmdline" \
--libsizeN=5777087 --libsizeT=4624267 --regions=${regions} --dsN=1 --dsT=1 --pcThreads=1

A complete source code and the output of this example is in Appendix A.4 on page 34.

23

Bioconductor NGScopy

Zhao, Xiaobei

Acknowledgement

I appreciate Dr. Stergios J Moschos and Dr. D Neil Hayes for giving me advice and full support on developing
the Bioconductor NGScopy package. I would also like to thank Vonn Walter for valuable discussion, Michele
C Hayward and Ashley H Salazar for help in annotation of clinical samples and sample related data, and
Xiaoying Yin for conducting DNA sequencing experiments.

I thank the Bioconductor team, particularly Martin T. Morgan for reviewing the package and providing helpful
comments.

This project is supported by the University Cancer Research Fund.

24

Bioconductor NGScopy

Zhao, Xiaobei

A The source code

25

Bioconductor NGScopy

Zhao, Xiaobei

A.1 The source code for the case study I

ngscopy-case1.R

#!/usr/bin/env Rscript

’

.

‘

’

‘

in

Case Study I

## ************************************************************************
Bioconductor NGScopy
## This is the R script for running
##
##
##
## (c) Xiaobei Zhao
##
## Mon Aug 11 13:44:26 EDT 2014 -0400 (Week 32)
##
## Reference:
## Bioconductor NGScopy
## http://www.bioconductor.org/packages/release/bioc/html/NGScopy.html
## Case study I: copy number detection of a tumor sample compared to
##
##
## Runme:
## Rscript ngscopy-case1.R &> ngscopy-case1.out
##
## ************************************************************************

a pooled normal sample

require(methods)
require(NGScopy)
require(NGScopyData)

## ------------------------------------------------------------------------
## Create an instance of NGScopy class
## ------------------------------------------------------------------------
obj <- NGScopy$new(

# specified directory for output

outFpre="ngscopy-case1",
inFpathN=tps_N8.chr6()$bamFpath, # normal sample: tps_90.chr6.sort.bam
inFpathT=tps_90.chr6()$bamFpath, # tumor sample:
tps_N8.chr6.sort.bam
libsizeN=5777087,
libsizeT=4624267,
mindepth=20,
minsize=20000,
regions=read_regions("chr6 41000000 81000000"),

# the library size of the normal sample
# the library size of the tumor sample
# the minimal depth of reads per window
# the minimal size of a window

segtype="mean.norm",
dsN=1,
dsT=1,
pcThreads=1
)

# the regions, set to NULL for the entire genome
# the type of segmentation
# the downsampling factor of the normal
# the downsampling factor of the tumor
# the number of processors for computing

obj$show()

# print the instance

## ------------------------------------------------------------------------
## Review the input
## ------------------------------------------------------------------------

## Get the input files
obj$get_inFpathN()
obj$get_inFpathT()

## Get the library sizes
obj$get_libsizeN()
obj$get_libsizeT()

## Get the windowing parameters
obj$get_mindepth()
obj$get_minsize()

## Get the regions

26

1

2

3

4

5

6

7

8

9

10

11

12

13

14

15

16

17

18

19

20

21

22

23

24

25

26

27

28

29

30

31

32

33

34

35

36

37

38

39

40

41

42

43

44

45

46

47

48

49

50

51

52

53

54

55

56

57

58

59

60

61

62

63

64

Bioconductor NGScopy

Zhao, Xiaobei

65

66

67

68

69

70

71

72

73

74

75

76

77

78

79

80

81

82

83

84

85

86

87

88

89

90

91

92

93

94

95

96

97

98

99

100

101

102

103

104

105

106

107

108

109

110

111

112

113

114

115

116

117

118

119

120

121

122

123

124

125

126

127

128

129

130

131

head(obj$get_regions())

## Get the segmentation type(s)
head(obj$get_segmtype())

## Get the down sampling factors
obj$get_dsN()
obj$get_dsT()

## Get the number of processors
obj$get_pcThreads()

## Get the chromosome names of the reference genome
obj$get_refname()

## Get the chromosome lengths of the reference genome
obj$get_reflength()

## ------------------------------------------------------------------------
## Process reads in the control (normal) sample (Make windows as well)
## ------------------------------------------------------------------------
obj$proc_normal()

# this may take a while

## ------------------------------------------------------------------------
## Process reads in the case (tumor) sample
## ------------------------------------------------------------------------
obj$proc_tumor()

# this may take a while

## ------------------------------------------------------------------------
## Compute/Process the relative copy number ratios and save it
## ------------------------------------------------------------------------

## A data.frame will be saved to file
obj$calc_cn()
obj$proc_cn()
obj$write_cn()

‘

ngscopy_cn.txt

’

in the output directory

## ------------------------------------------------------------------------
## Compute/Process the segmentation and save it
## ------------------------------------------------------------------------

## A data.frame will be saved to file
obj$calc_segm()
obj$proc_segm()
obj$write_segm()

‘

ngscopy_segm.txt

’

in the output directory

## ------------------------------------------------------------------------
## Save the output for later reference
## ------------------------------------------------------------------------
## The NGScopy output is saved as a ngscopy_out.RData file in the output directory
obj$saveme()

## ------------------------------------------------------------------------
## Load and review the output
## ------------------------------------------------------------------------

## Load the output
## (optional if the previous steps have completed in the same R session)
obj$loadme()

## Get the output directory
obj$get_outFpre()

## Get the windows
head(obj$get_windows())

27

Bioconductor NGScopy

Zhao, Xiaobei

## Get the window sizes
head(obj$get_size())

## Get the window positions (midpoints of the windows)
head(obj$get_pos())

## Get the number of reads per window in the normal
head(obj$get_depthN())

## Get the number of reads per window in the tumor
head(obj$get_depthT())

## Get the copy number
str(obj$get_cn())

## Get the segmentation
str(obj$get_segm())

## Get the data.frame of copy number calling
data.cn <- obj$get_data.cn()
head(data.cn)

## Get the data.frame of segmentation calling
data.segm <- obj$get_data.segm()
head(data.segm)

## ------------------------------------------------------------------------
## Visualize the output
## ------------------------------------------------------------------------
## A figure will be saved to file
obj$plot_out(ylim=c(-3,3))

to allow full-scale display

in the output directory

ngscopy_cn.pdf
‘

# reset

ylim

‘

’

’

132

133

134

135

136

137

138

139

140

141

142

143

144

145

146

147

148

149

150

151

152

153

154

155

156

157

158

159

160

161

162

163

28

Bioconductor NGScopy

Zhao, Xiaobei

A.2 The source code for the case study II

ngscopy-case2.R

#!/usr/bin/env Rscript

.

’

‘

’

‘

in

Case Study II

Bioconductor NGScopy

## ************************************************************************
## This is the R script for running
##
##
##
## (c) Xiaobei Zhao
##
## Mon Aug 11 13:45:24 EDT 2014 -0400 (Week 32)
##
## Reference:
## Bioconductor NGScopy
## http://www.bioconductor.org/packages/release/bioc/html/NGScopy.html
## Case study II: copy number detection of multiple tumor samples compared to
##
##
## Runme:
## Rscript ngscopy-case2.R &> ngscopy-case2.out
##
## ************************************************************************

a common pooled normal sample

require(methods)
require(NGScopy)
require(NGScopyData)

## ------------------------------------------------------------------------
## Process the normal
## ------------------------------------------------------------------------

## Create an instance of
obj <- NGScopy$new(pcThreads=1)

NGScopy

‘

’

class

## Set the normal sample
obj$set_normal(tps_N8.chr6()$bamFpath)

## Set the regions
regions <- read_regions("chr6 41000000 81000000")
obj$set_regions(regions)

## Set the library size of the normal
obj$set_libsizeN(5777087)

## Specify a directory for output
## It will be saved as "ngscopy_normal.RData" in this directory
obj$set_outFpre("ngscopy-case2/tps_N8")

## Show the input
obj$show()

## Make windows and count reads in the normal
obj$proc_normal()

## Save the output of the normal for later usage
obj$save_normal()

## ------------------------------------------------------------------------
## Process a tumor
## ------------------------------------------------------------------------

## Create an instance of
obj1 <- NGScopy$new(pcThreads=1)

NGScopy

‘

’

class

## Load the previously saved output of the normal

29

1

2

3

4

5

6

7

8

9

10

11

12

13

14

15

16

17

18

19

20

21

22

23

24

25

26

27

28

29

30

31

32

33

34

35

36

37

38

39

40

41

42

43

44

45

46

47

48

49

50

51

52

53

54

55

56

57

58

59

60

61

62

63

64

65

66

67

68

69

70

71

72

73

74

75

76

77

78

79

80

81

82

83

84

85

86

87

88

89

90

91

92

93

94

95

96

97

98

99

100

101

102

103

104

105

106

107

108

109

110

111

112

113

114

115

116

117

118

119

Bioconductor NGScopy

Zhao, Xiaobei

obj1$load_normal("ngscopy-case2/tps_N8")

## Set a tumor sample (ID: tps_90) and specify a directory for output
obj1$set_tumor(tps_90.chr6()$bamFpath)
obj1$set_outFpre("ngscopy-case2/tps_90")

## Set the library size of the tumor
obj1$set_libsizeT(4624267)

## Show the input
obj1$show()

## Process the tumor
obj1$proc_tumor()

## Process the copy number
obj1$proc_cn()

## Process the segmentation
obj1$proc_segm()

## Plot
obj1$plot_out(ylim=c(-3,3))

## ------------------------------------------------------------------------
## Process a second tumor
## ------------------------------------------------------------------------

## Create another instance of
obj2 <- NGScopy$new(pcThreads=1)

‘

’

NGScopy

class

## Load the previously saved output of the normal
obj2$load_normal("ngscopy-case2/tps_N8")

## Set a tumor sample (ID: tps_27) and specify a directory for output
obj2$set_tumor(tps_27.chr6()$bamFpath)
obj2$set_outFpre("ngscopy-case2/tps_27")

## Set the library size of the tumor
obj2$set_libsizeT(10220498)

## Show the input
obj2$show()

## Process the tumor
obj2$proc_tumor()

## Process the copy number
obj2$proc_cn()

## Process the segmentation
obj2$proc_segm()

## Plot
obj2$plot_out(ylim=c(-3,3))

30

Bioconductor NGScopy

Zhao, Xiaobei

A.3 The command-line executable R script

ngscopy

#!/usr/bin/env Rscript

‘

’

Bioconductor NGScopy

## ************************************************************************
## This is an executable R script for running
## at commond line.
##
##
##
## (c) Xiaobei Zhao
##
## Sat Jun 28 21:19:32 EDT 2014 -0400 (Week 25)
##
##
## Reference:
## Bioconductor NGScopy
## http://www.bioconductor.org/packages/release/bioc/html/NGScopy.html
##
## Get help
## ./ngscopy -h
## $(Rscript -e "cat(Xmisc::get_executable(
## ************************************************************************

NGScopy

))") -h

’

’

require(methods)
require(Xmisc)

PARSEME <- function(){

parser <- ArgumentParser$new()

parser$add_usage(
parser$add_description(

ngscopy [options]

’

’

)

’

ngscopy scans a pair of input BAM files to detect relative copy number variants.

)

’

’

parser$add_argument(
,type=
’

logical
’

--h

’

’

store_true

,

’

,

action=
help=

’

Print the help page

’

)

’

parser$add_argument(
’
’

,type=
store_true

’

--help
action=
help=

’

logical
’

,

Print the help page

’

,

’

)

’

’

’

parser$add_argument(
,type=

--inFpathN
’

’

’

character

,

help=

The file path to the control (normal) sample

’

)

’

’

’

parser$add_argument(
,type=

--inFpathT
’

’

’

character

,

help=

The file path to the case (tumor) sample

)
parser$add_argument(
’

’

’

--outFpre
’

,type=

character

,

’

help=

The file path of the directory for output

help=

The library size of the control (normal) sample

’

numeric

,

)
parser$add_argument(
,type=

--libsizeN
’

’

’

’

)
parser$add_argument(
,type=

--libsizeT

’

’

’

’

’

numeric

,

31

1

2

3

4

5

6

7

8

9

10

11

12

13

14

15

16

17

18

19

20

21

22

23

24

25

26

27

28

29

30

31

32

33

34

35

36

37

38

39

40

41

42

43

44

45

46

47

48

49

50

51

52

53

54

55

56

57

58

59

60

61

62

63

64

Bioconductor NGScopy

Zhao, Xiaobei

’

help=

The library size of the case (tumor) sample

’

)
parser$add_argument(
,type=

’

’

’

--mindepth
default=20,
’
help=

numeric

,

’

The minimal depth of reads per window

’

)
parser$add_argument(
’

’

’

--minsize

,type=

numeric

,

’

default=20000,
help=

’

The minimal size of a window

’

)

parser$add_argument(
’

’

’

--regions

,type=

character

,

’

default=NULL,
help=

’

The regions, a text string or a file path indicating the regions

with three columns (chr/start/end) and without column names.

)

parser$add_argument(
’

’

’

--segtype

,type=

character

,

’

default="mean.norm",
help=

’

The type of segmentation. One of c(

"mean.norm","meanvar.norm","mean.cusum","var.css"
). Multiple values are allowed and separated by ",".

’

)

parser$add_argument(

’

’

’

--dsN

,type=

integer

,

’

default=1,
’
help=

The downsampling factor of the control (normal) sample

’

)

parser$add_argument(

’

’

’

--dsT

,type=

integer

,

’

default=1,
’
help=

The downsampling factor of the test (tumor) sample

’

’

)

)

)

’

’

’

parser$add_argument(

--pcThreads

,type=

integer

,

’

’

’

default=1,
’
help=

The number of processors performing the parallel computing

’

parser$add_argument(

’

’

,type=

logical

,

’

--auto.save
default=FALSE,
help=

’

Whether to save (any completed results) automatically

’

parser$add_argument(

’

’

,type=

logical

,

’

--auto.load
default=FALSE,
help=

’

Whether to load (any previously completed results) automatically

’

)
return(parser)

}

main <- function(){

parser <- PARSEME()
parser$helpme()

require(NGScopy)

32

65

66

67

68

69

70

71

72

73

74

75

76

77

78

79

80

81

82

83

84

85

86

87

88

89

90

91

92

93

94

95

96

97

98

99

100

101

102

103

104

105

106

107

108

109

110

111

112

113

114

115

116

117

118

119

120

121

122

123

124

125

126

127

128

129

130

131

Bioconductor NGScopy

Zhao, Xiaobei

132

133

134

135

136

137

138

139

140

141

142

143

144

145

146

147

148

149

150

151

152

153

154

155

156

157

158

159

160

161

162

if (length(regions)){

regions <- read_regions(regions)

}

obj <- NGScopy$new(
outFpre=outFpre,
inFpathN=inFpathN,
inFpathT=inFpathT,
libsizeN=libsizeN,
libsizeT=libsizeT,
mindepth=mindepth,
minsize=minsize,
regions=regions,
segtype=segtype,
dsN=dsN,
dsT=dsT,
pcThreads=pcThreads,
auto.save=auto.save,
auto.load=auto.load

)

obj$write_cn()
obj$write_segm()
## obj$plot_out()
obj$plot_out(ylim=c(-3,3))

invisible()

}

main()

33

Bioconductor NGScopy

Zhao, Xiaobei

A.4 The command-line example Bash (Unix shell) script and the output

#!/usr/bin/env bash

ngscopy-case1b-cmdline.sh

’

.

Bioconductor NGScopy

‘

## ************************************************************************
## This is a commond line example to run bin/ngscopy in
##
##
## (c) Xiaobei Zhao
##
## v0.99.1
## Mon Aug 11 09:57:53 EDT 2014 -0400 (Week 32)
## [2014-08-11 09:59:52 EDT] add regions, dsN, dsT
##
## v0.99.0
## Sat Jun 28 21:19:32 EDT 2014 -0400 (Week 25)
##
##
## Reference:
## Bioconductor NGScopy
## http://www.bioconductor.org/packages/release/bioc/html/NGScopy.html
##
## Runme:
## bash ngscopy-case1b-cmdline.sh &> ngscopy-case1b-cmdline.out
##
## ************************************************************************

## ------------------------------------------------------------------------
## The path of the executable, for instance, ${R_LIBS}/NGScopy/bin/ngscopy
## A portable solution is to extract this path by
## We call such funciton from the command line below.
## ------------------------------------------------------------------------

system.file

in R

’

‘

’

## ngscopyCmd=$(Rscript -e "cat(system.file(
## package=
ngscopyCmd=$(Rscript -e "cat(Xmisc::get_executable(
echo ${ngscopyCmd}

, mustWork=TRUE))")

NGScopy

bin

,

’

’

’

’

’

ngscopy

’

,

’

NGScopy

))")

## ------------------------------------------------------------------------
## Get help
## ------------------------------------------------------------------------

## ${ngscopyCmd} -h
## ${ngscopyCmd} --help

## ------------------------------------------------------------------------
## An example
## This is a command line version of Case Study I from NGScopy User
## See http://www.bioconductor.org/packages/release/bioc/html/NGScopy.html
## ------------------------------------------------------------------------

s Guide.

’

## a normal sample, given the NGScopyData package is installed
## inFpathN=$(Rscript -e "cat(system.file(
## package=
inFpathN=$(Rscript -e "cat(Xmisc::get_extdata(

, mustWork=TRUE))")

NGScopyData

NGScopyData

extdata

’

’

’

’

,

’

’

,

’

’

tps_N8.chr6.sort.bam

’

,

tps_N8.chr6.sort.bam

’

))")

## echo ${inFpathN}
## ls -l ${inFpathN}

## a tumor sample, given the NGScopyData package is installed
## inFpathT=$(Rscript -e "cat(system.file(
## package=

, mustWork=TRUE))")

NGScopyData

extdata

’

’

’

,

’

’

tps_90.chr6.sort.bam

’

,

34

1

2

3

4

5

6

7

8

9

10

11

12

13

14

15

16

17

18

19

20

21

22

23

24

25

26

27

28

29

30

31

32

33

34

35

36

37

38

39

40

41

42

43

44

45

46

47

48

49

50

51

52

53

54

55

56

57

58

59

60

61

62

63

64

Bioconductor NGScopy

Zhao, Xiaobei

inFpathT=$(Rscript -e "cat(Xmisc::get_extdata(
## echo ${inFpathT}
## ls -l ${inFpathT}

’

’

’

NGScopyData

,

tps_90.chr6.sort.bam

’

))")

## set pre-computed libsizes based on the original bam files of all chromosomes
libsizeN=5777087
libsizeT=4624267

## set the regions, given the NGScopy package is installed
## regions=$(Rscript -e "cat(system.file(
## package=
regions=$(Rscript -e "cat(Xmisc::get_extdata(
## echo ${regions}

, mustWork=TRUE))")

NGScopy

extdata

NGScopy

,

’

’

’

’

,

’

’

’

’

hg19_chr6_0_171115067.txt

,

’

hg19_chr6_0_171115067.txt

))")

’

## set downsampling factor; we do not downsample here by setting them to 1.
dsN=1
dsT=1

## set a directory for output
outFpre="ngscopy-case1b-cmdline"

## Run NGScopy given arguments and time it
time ${ngscopyCmd} --inFpathN=${inFpathN} --inFpathT=${inFpathT} --outFpre="${outFpre}" \
--libsizeN=${libsizeN} --libsizeT=${libsizeT} --regions=${regions} \
--dsN=${dsN} --dsT=${dsT} --pcThreads=1

The output,

ngscopy-case1b-cmdline.out

/home/xiaobei/supplemental2/usr/local/lib64/R/library/NGScopy/bin/ngscopy
Loading required package: methods
Loading required package: Xmisc
Loading required package: NGScopy
auto.save: FALSE
auto.load: FALSE
20140815 10:02:42 EDT | set_normal | inFpathN
inFpathN: /home/xiaobei/supplemental2/usr/local/lib64/R/library/NGScopyData/extdata/tps_N8.chr6.sort.bam

20140815 10:02:42 EDT | set_tumor | inFpathT
inFpathT: /home/xiaobei/supplemental2/usr/local/lib64/R/library/NGScopyData/extdata/tps_90.chr6.sort.bam

20140815 10:02:42 EDT | set_outFpre
outFpre: ngscopy-case1b-cmdline

20140815 10:02:42 EDT | set_libsize | libsizeN
libsizeN: 5777087

20140815 10:02:42 EDT | set_libsize | libsizeT
libsizeT: 4624267

20140815 10:02:42 EDT | set_normal | mindepth
mindepth: 20

20140815 10:02:42 EDT | set_normal | minsize
minsize: 20000

20140815 10:02:42 EDT | set_regions
20140815 10:02:42 EDT | .proc_ref | process reference genome (in bam header of the normal sample)
20140815 10:02:42 EDT | .trim_regions | trim regsions if exceeding the reference
20140815 10:02:42 EDT | .sort_regions | sort regions by reference
regions:
chr6 0 171115067

20140815 10:02:42 EDT | set_segmtype
segtype: c("mean.norm")

35

65

66

67

68

69

70

71

72

73

74

75

76

77

78

79

80

81

82

83

84

85

86

87

88

89

1

2

3

4

5

6

7

8

9

10

11

12

13

14

15

16

17

18

19

20

21

22

23

24

25

26

27

28

29

30

31

32

33

34

35

36

Bioconductor NGScopy

Zhao, Xiaobei

20140815 10:02:42 EDT | set_ds | dsN
dsN: 1

20140815 10:02:42 EDT | set_ds | dsT
dsT: 1

20140815 10:02:42 EDT | set_pcThreads
pcThreads: 1

20140815 10:02:42 EDT | write_cn
20140815 10:02:42 EDT | proc_cn
20140815 10:02:42 EDT | proc_normal | this may take a while depending on the size of your library.
20140815 10:02:42 EDT | (PID: 54971) Processing coords (refid, start, end): 5, 0, 171115067
20140815 10:04:02 EDT | Processed all 1 regions.
20140815 10:04:02 EDT | proc_tumor | this may take a while depending on the size of your library.
20140815 10:05:12 EDT | Processed all 2808 windows.
20140815 10:05:12 EDT | calc_cn
20140815 10:05:12 EDT | set_MoreArgs.cn
MoreArgs.cn not specified, assuming list(pseudocount=1,logr=TRUE).
MoreArgs.cn:
List of 2

$ pseudocount: num 1
$ logr

: logi TRUE

20140815 10:05:12 EDT | calc_cn | done
out$cn:
List of 3

: num [1:2808] 0.0163 -0.3708 -0.2638 -0.1643 -0.2232 ...

$ cnr
$ pseudocount: num 1
$ logr

: logi TRUE

File saved:
outFpath="ngscopy-case1b-cmdline/ngscopy_cn.txt"

20140815 10:05:12 EDT | write_segm
20140815 10:05:12 EDT | proc_segm
20140815 10:05:12 EDT | calc_segm
20140815 10:05:12 EDT | set_MoreArgs.segm
MoreArgs.segm not specified, assuming list().
MoreArgs.segm:

list()

20140815 10:05:12 EDT | calc_segm | done
out$seg:
List of 1

$ mean.norm:List of 1

’

’

cpt

[package "changepoint"] with 10 slots

..$ chr6:Formal class
.. .. ..@ data.set : Time-Series [1:2808] from 1 to 2808: 0.0163 -0.3708 -0.2638 -0.1643 -0.2232 ...
.. .. ..@ cpttype : chr "mean"
.. .. ..@ method
: chr "PELT"
.. .. ..@ test.stat: chr "Normal"
.. .. ..@ pen.type : chr "SIC"
.. .. ..@ pen.value: num 7.94
.. .. ..@ cpts
.. .. ..@ ncpts.max: num Inf
.. .. ..@ param.est:List of 1
.. .. .. ..$ mean: num [1:6] 0.0801 -4.0712 -0.0345 -0.418 -3.3285 ...
: chr "Wed Jul 23 19:59:37 2014"
.. .. ..@ date

: int [1:6] 550 551 1141 1951 1953 2808

37

38

39

40

41

42

43

44

45

46

47

48

49

50

51

52

53

54

55

56

57

58

59

60

61

62

63

64

65

66

67

68

69

70

71

72

73

74

75

76

77

78

79

80

81

82

83

84

85

86

87

88

89

90

91

92

93

94

95

96

97

98

99

100

101

102

103

File saved:

36

Bioconductor NGScopy

Zhao, Xiaobei

104

105

106

107

108

109

110

111

112

113

114

115

outFpath="ngscopy-case1b-cmdline/ngscopy_segm.txt"

20140815 10:05:12 EDT | plot_out
chr=chr6, segtype=mean.norm

File saved:
pdfFpath="ngscopy-case1b-cmdline/ngscopy_out.pdf"

real
user
sys

2m48.398s
2m47.147s

0m0.298s

37

Bioconductor NGScopy

Zhao, Xiaobei

B Comparison with full-scale NGS data

Here we compared the copy number calling in the follow two scenarios:

1. Using the 10% subsample (Figure 6 (a) and (b)).
2. Using the original data without any downsampling (Figure 6 (c) and (d)).

The (cid:28)rst scenario identi(cid:28)ed CNVs with 10% of the original data. It also captured highly similar characteristics
in the chromosome-wide view compared with the other scenario. Obviously, downsampling can reduce the
computation time though may entail some loss of detail and precision. Whether to down-sample the data
depends on the sequencing coverage properties (depth, broadness and distributions of reads) as well as the
purpose of the analysis. It is always a good practice to make prelimilary tests with downsampled data.

38

Bioconductor NGScopy

Zhao, Xiaobei

(a) ID: tps_90(10%subsample)

(b) ID: tps_27(10%subsample)

(c) ID: tps_90(originalsample)

(d) ID: tps_27(originalsample)

Figure 6: Graphical output for comparison of NGScopy calling between the 10% subsample [(a) and (b)] and the
original sample without downsampling [(c) and (d)].

39

0.0e+005.0e+071.0e+081.5e+08−3−2−10123chr6 (mean.norm)PositonCN (log2)0.0e+005.0e+071.0e+081.5e+08−3−2−10123chr6 (mean.norm)PositonCN (log2)0.0e+005.0e+071.0e+081.5e+08−3−2−10123chr6 (mean.norm)PositonCN (log2)0.0e+005.0e+071.0e+081.5e+08−3−2−10123chr6 (mean.norm)PositonCN (log2)Bioconductor NGScopy

References

Zhao, Xiaobei

[1] Jacques S. Beckmann, Xavier Estivill, and Stylianos E. Antonarakis. Copy number variants and genetic
traits: closer to the resolution of phenotypic to genotypic variability. Nat Rev Genet, 8(8):639(cid:21)646, Aug
2007.

[2] John Chambers. ReferenceClasses: Objects With Fields Treated by Reference (OOP-style). CRAN, 2014.

http://stat.ethz.ch/R-manual/R-devel/library/methods/html/refClass.html.

[3] Lars Feuk, Andrew R Carson, and Stephen W Scherer. Structural variation in the human genome. Nat

Rev Genet, 7(2):85(cid:21)97, Feb 2006.

[4] Santhosh Girirajan, Catarina D. Campbell, and Evan E. Eichler. Human copy number variation and

complex genetic disease. Annu Rev Genet, 45:203(cid:21)226, 2011.

[5] Wolfgang Kaisers. rbamtools: Reading, manipulation and writing BAM (Binary alignment) (cid:28)les, 2014. R

package version 2.6.0.

[6] Rebecca Killick, Idris Eckley, and Kaylea Haynes. changepoint: An R package for changepoint analysis,

2014. R package version 1.1.5.

[7] Je(cid:27)rey R. MacDonald, Robert Ziman, Ryan K C. Yuen, Lars Feuk, and Stephen W. Scherer. The database
of genomic variants: a curated collection of structural variation in the human genome. Nucleic Acids Res,
42(Database issue):D986(cid:21)D992, Jan 2014.

[8] J. C. Marioni, N. P. Thorne, and S. TavarØ. Biohmm: a heterogeneous hidden markov model for segment-

ing array cgh data. Bioinformatics, 22(9):1144(cid:21)1146, May 2006.

[9] Steven A. McCarroll and David M. Altshuler. Copy-number variation and association studies of human

disease. Nat Genet, 39(7 Suppl):S37(cid:21)S42, Jul 2007.

[10] Richard Redon, Shumpei Ishikawa, Karen R Fitch, Lars Feuk, George H Perry, T Daniel Andrews, Heike
Fiegler, Michael H Shapero, Andrew R Carson, Wenwei Chen, et al. Global variation in copy number in
the human genome. nature, 444(7118):444(cid:21)454, 2006.

[11] Travis I Zack, Steven E Schumacher, Scott L Carter, Andrew D Cherniack, Gordon Saksena, Barbara
Tabak, Michael S Lawrence, Cheng-Zhong Zhang, Jeremiah Wala, Craig H Mermel, et al. Pan-cancer
patterns of somatic copy number alteration. Nature genetics, 45(10):1134(cid:21)1140, 2013.

[12] Xiaobei Zhao. NGScopy: Detection of copy number variations in next generation sequencing, 2014. Bio-

conductor/R package.

[13] Xiaobei Zhao. NGScopyData: Subset of BAM (cid:28)les of human tumor and pooled normal sequencing data

(Zhao et al. 2014) for the NGScopy package, 2014. Bioconductor/R package.

[14] Xiaobei Zhao, Anyou Wang, ..., D Neil Hayes, and Stergios J Moschos. Targeted sequencing in non-
small cell lung cancer (nsclc) using the university of north carolina (unc) sequencing assay captures most
previously described genetic aberrations in nsclc. In preparation, 2014.

40

