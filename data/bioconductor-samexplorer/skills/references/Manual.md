Manual for the package samExploreR

Alexey Stupnikov1, Shailesh Tripathi1,2, Ricardo de Matos
Simoes1, Darragh McArt3,

Manuel Salto-Tellez3, Galina Glazko4 and Frank Emmert-Streib1,5,6,*
1Computational Biology and Machine Learning Laboratory,
Center for Cancer Research and Cell Biology,
School of Medicine, Dentistry and Biomedical Sciences,
Faculty of Medicine, Health and Life Sciences,
Queen’s University Belfast, UK
2School of Mathematics and Physics,
Queen’s University Belfast, BT7 1NN Belfast, UK
3Northern Ireland Molecular Pathology Laboratory,
Centre for Cancer Research and Cell Biology,
Queen’s University Belfast, BT9 7AE Belfast, UK
4Division of Biomedical Informatics, University of Arkansas for Medical Sciences,
Little Rock, AR 72205, USA
5Computational Medicine and Statistical Learning Laboratory,
Department of Signal Processing, Tampere University of Technology, Finland
6Institute of Biosciences and Medical Technology,
33520 Tampere, Finland
*Corresponding author

Manual for the package samExploreR

Contents

1

2

3

4

5

6

7

8

Citation.

.

.

.

.

Dependencies.

.

.

.

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

For developers only .

Installation .

Quick start .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

The samExplore function .

exploreRob .

exploreRep .

.

.

.

.

.

.

plotSamExplorer .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

8.1

Plotting data using the function plotSamExplorer .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

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

3

3

6

11

12

13

13

1

Citation

If you use the samExploreR package, please cite [1] and [2].

2

Dependencies

SamExploreR depends on some R package available in Bioconductor that need to be
installed before you can use the package. The symbol ’>’ indicates the R prompt.

> if (!requireNamespace("BiocManager", quietly=TRUE))

+

install.packages("BiocManager")

> BiocManager::install("samExploreR")

Installation command: call the following command from an R prompt.

2.1

For developers only

If a user wants to make changes to the package and rebuild it again, then the following
packages need to be installed additionally. These are necessary for the compilation
and the building the package.

2

Manual for the package samExploreR

> BiocManager::install(c("BiocCheck", "BiocGenerics", "RUnit"))

3

Installation

The samExploreR package is available from Bioconductor. To install the package,
run the following commands:

Remark: To be added after uploaded to Bioconductor.

If you install it from a local download, run the following command in a terminal from
the same directory where you downloaded the package:

4

Quick start

In the following, we demonstrate brieﬂy the usage of the samExploreR package and
the analysis procedures it provides. These examples require a BAM or SAM ﬁle from
some RNA-seq experiment containing aligned reads. For the following examples, we
provide the all necessary ﬁles, namely:

• aligned reads: Test.sam

• annotation ﬁle: Annot.gtf

In order to simulate 5 repeats (N_boot) for a virtual sequencing experiment with
sequencing depth f = 0.7 execute:

>

library(samExploreR)

> ## perform subsampling
> inpf <- RNAseqData.HNRNPC.bam.chr14_BAMFILES
> x <- samExplore(files=inpf,annot.inbuilt="hg19", subsample_d = 0.8)

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

_____ _
/ ____| |
| (___ | |
_ /|
\___ \| | | |
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

\

/

Rsubread 1.32.2

//========================== featureCounts setting ===========================\\

||

||

||

Input files : 8 BAM files

P ERR127306_chr14.bam

||

||

||

3

Manual for the package samExploreR

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

P ERR127307_chr14.bam
P ERR127308_chr14.bam
P ERR127309_chr14.bam
P ERR127302_chr14.bam
P ERR127303_chr14.bam
P ERR127304_chr14.bam
P ERR127305_chr14.bam

Annotation : inbuilt (hg19)

Dir for temp files : .

Threads : 1

Level : meta-feature level

Paired-end : no

Multimapping reads : counted

|| Multi-overlapping reads : not counted

Min overlapping bases : 1

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

||

||

||

||

\\===================== http://subread.sourceforge.net/ ======================//

//================================= Running ==================================\\

||
|| Load annotation file hg19_RefSeq_exon.txt ...
||

Features : 225074

||

||

Meta-features : 25702

Chromosomes/contigs : 52

||
|| Process BAM file ERR127306_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 800484

Successfully assigned alignments : 680516 (85.0%)

Running time : 0.03 minutes

||
|| Process BAM file ERR127307_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 875302

Successfully assigned alignments : 744592 (85.1%)

Running time : 0.03 minutes

||
|| Process BAM file ERR127308_chr14.bam...
Paired-end reads are included.
||

||

||

||

Assign alignments to features...

Total alignments : 875608

Successfully assigned alignments : 741944 (84.7%)

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

4

Manual for the package samExploreR

||

Running time : 0.03 minutes

||
|| Process BAM file ERR127309_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 778464

Successfully assigned alignments : 661631 (85.0%)

Running time : 0.03 minutes

||
|| Process BAM file ERR127302_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 742754

Successfully assigned alignments : 626250 (84.3%)

Running time : 0.04 minutes

||
|| Process BAM file ERR127303_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 786196

Successfully assigned alignments : 659952 (83.9%)

Running time : 0.03 minutes

||
|| Process BAM file ERR127304_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 810724

Successfully assigned alignments : 660986 (81.5%)

Running time : 0.03 minutes

||
|| Process BAM file ERR127305_chr14.bam...
Paired-end reads are included.
||

Assign alignments to features...

Total alignments : 798376

Successfully assigned alignments : 658094 (82.4%)

Running time : 0.03 minutes

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

\\===================== http://subread.sourceforge.net/ ======================//

This results in a 5-dimensional list, whereas each component corresponds to a sub-
sampled count vectors.

5

Manual for the package samExploreR

5

The samExplore function

The function samExplore, which is our modiﬁcation of the featureCounts function of
[2], performs a summerization of reads to genomic features of annotation.

The procedure of read subsampling works as follows: One of the input parameters
is f , which is a fraction of reads that will be subsampled from the original SAM or
BAM ﬁle,

f =

#subssampled reads
#total reads

.

1

During the counts computing process every read, or a pair of reads for paired-end
sequencing, is taken into account with probability f . This results in a reduction of
the amount of reads and, therefore, the overall expression of the genes.

Further input arguments of the function are:

• ﬁles: names of SAM/BAM ﬁles to process

• annot_ext: annotation ﬁle

• isGTFAnnotationFile:

• GTF.featureType:

• N_boot: number of repeated experiments

As an output the function produces a vector of objects - results of featureCounts
running.

> # Loading library

> library(samExploreR)

> # Performing subsampling

>
> inpf <- RNAseqData.HNRNPC.bam.chr14_BAMFILES
> # Performing robustness analysis for f = 0.7, number of replicates 5,

> #annotation entries 'gene', non-paired reads

> x <- samExplore(files=inpf,annot.inbuilt="hg19",GTF.featureType="exon",
+ GTF.attrType="gene_id", subsample_d = 0.8, N_boot=5)

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

_____ _
/ ____| |
| (___ | |
_ /|
\___ \| | | |
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

\

/

Rsubread 1.32.2

//========================== featureCounts setting ===========================\\

6

Manual for the package samExploreR

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

||

||

Input files : 8 BAM files

P ERR127306_chr14.bam
P ERR127307_chr14.bam
P ERR127308_chr14.bam
P ERR127309_chr14.bam
P ERR127302_chr14.bam
P ERR127303_chr14.bam
P ERR127304_chr14.bam
P ERR127305_chr14.bam

Annotation : inbuilt (hg19)

Dir for temp files : .

Threads : 1

Level : meta-feature level

Paired-end : no

Multimapping reads : counted

|| Multi-overlapping reads : not counted

Min overlapping bases : 1

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

||

||

||

||

||

||

||

\\===================== http://subread.sourceforge.net/ ======================//

//================================= Running ==================================\\

||
|| Load annotation file hg19_RefSeq_exon.txt ...
||

Features : 225074

||

||

Meta-features : 25702

Chromosomes/contigs : 52

||
|| Process BAM file ERR127306_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 800484

Successfully assigned alignments : 680516 (85.0%)

Running time : 0.02 minutes

||
|| Process BAM file ERR127307_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 875302

Successfully assigned alignments : 744592 (85.1%)

Running time : 0.03 minutes

||
|| Process BAM file ERR127308_chr14.bam...
Paired-end reads are included.
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

||

||

||

||

||

||

||

||

7

Manual for the package samExploreR

||

||

||

||

Assign alignments to features...

Total alignments : 875608

Successfully assigned alignments : 741944 (84.7%)

Running time : 0.03 minutes

||
|| Process BAM file ERR127309_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 778464

Successfully assigned alignments : 661631 (85.0%)

Running time : 0.02 minutes

||
|| Process BAM file ERR127302_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 742754

Successfully assigned alignments : 626250 (84.3%)

Running time : 0.03 minutes

||
|| Process BAM file ERR127303_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 786196

Successfully assigned alignments : 659952 (83.9%)

Running time : 0.03 minutes

||
|| Process BAM file ERR127304_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 810724

Successfully assigned alignments : 660986 (81.5%)

Running time : 0.03 minutes

||
|| Process BAM file ERR127305_chr14.bam...
Paired-end reads are included.
||

Assign alignments to features...

Total alignments : 798376

Successfully assigned alignments : 658094 (82.4%)

Running time : 0.03 minutes

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

||

||

\\===================== http://subread.sourceforge.net/ ======================//

> # Performing robustness analysis for f = 0.1, number of replicates 10,

> #annotation entries 'exon', paired reads

8

Manual for the package samExploreR

> x <- samExplore(files=inpf,annot.inbuilt="hg19",GTF.featureType="gene",
+ GTF.attrType="gene_id", subsample_d = 0.8, N_boot=5)

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

_____ _
/ ____| |
| (___ | |
_ /|
\___ \| | | |
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

Rsubread 1.32.2

//========================== featureCounts setting ===========================\\

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

||

||

Input files : 8 BAM files

P ERR127306_chr14.bam
P ERR127307_chr14.bam
P ERR127308_chr14.bam
P ERR127309_chr14.bam
P ERR127302_chr14.bam
P ERR127303_chr14.bam
P ERR127304_chr14.bam
P ERR127305_chr14.bam

Annotation : inbuilt (hg19)

Dir for temp files : .

Threads : 1

Level : meta-feature level

Paired-end : no

Multimapping reads : counted

|| Multi-overlapping reads : not counted

Min overlapping bases : 1

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

||

||

||

||

||

||

||

\\===================== http://subread.sourceforge.net/ ======================//

//================================= Running ==================================\\

||
|| Load annotation file hg19_RefSeq_exon.txt ...
||

Features : 225074

||

||

Meta-features : 25702

Chromosomes/contigs : 52

||
|| Process BAM file ERR127306_chr14.bam...
Paired-end reads are included.
||

||

||

Assign alignments to features...

Total alignments : 800484

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

9

Manual for the package samExploreR

||

||

Successfully assigned alignments : 680516 (85.0%)

Running time : 0.03 minutes

||
|| Process BAM file ERR127307_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 875302

Successfully assigned alignments : 744592 (85.1%)

Running time : 0.03 minutes

||
|| Process BAM file ERR127308_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 875608

Successfully assigned alignments : 741944 (84.7%)

Running time : 0.02 minutes

||
|| Process BAM file ERR127309_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 778464

Successfully assigned alignments : 661631 (85.0%)

Running time : 0.03 minutes

||
|| Process BAM file ERR127302_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 742754

Successfully assigned alignments : 626250 (84.3%)

Running time : 0.03 minutes

||
|| Process BAM file ERR127303_chr14.bam...
Paired-end reads are included.
||

||

||

||

||

Assign alignments to features...

Total alignments : 786196

Successfully assigned alignments : 659952 (83.9%)

Running time : 0.02 minutes

||
|| Process BAM file ERR127304_chr14.bam...
Paired-end reads are included.
||

Assign alignments to features...

Total alignments : 810724

Successfully assigned alignments : 660986 (81.5%)

Running time : 0.03 minutes

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

||

||

||

||

||

10

Manual for the package samExploreR

|| Process BAM file ERR127305_chr14.bam...
Paired-end reads are included.
||

Assign alignments to features...

Total alignments : 798376

Successfully assigned alignments : 658094 (82.4%)

Running time : 0.03 minutes

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

\\===================== http://subread.sourceforge.net/ ======================//

6

exploreRob

A cornerstone of any scientiﬁc study is the question regarding the reproducibility
and robustness of obtained results. The function exploreRob allows the exploration
of the robustness of results.
It runs a standard one-way ANOVA test for groups of
replicates, corresponding to diﬀerent f values, for one ﬁxed annotation. In this way,
one can measure if the result of the analysis changes signiﬁcantly with a change in
the parameter sequencing depth, f.

The function exploreRob takes as input argument a data frame with the format
shown in Table below. ??.

> data(df_sole)
> head(df_sole)

Label Variable Value

1 New, Gene

2 New, Exon

3 Old, Gene

4 New, Gene

5 New, Exon

6 Old, Gene

0.05

0.05

0.05

0.05

0.05

0.05

3

1

1

1

2

0

In this table, the ﬁrst column provides the labels for the annotation (lbl) used for
the analysis, the second column gives the f value and the third column provides the
value of the metric to be explored, e.g., the number of diﬀerentially expressed genes.

The function exploreRob splits this data frame up by considering only entries for one
speciﬁc type of annotation. Then an ANOVA test is run for the groups of replicates
that correspond to a given list of f values, see Fig. 1.

For instance, to explore the robustness of the annotation type AnnotB cross the f
values 0.8, 0.9, 0.95 for the data frame df run:

11

Manual for the package samExploreR

> #Loading library

> library(samExploreR)
> data("df_sole")
> #Performing robustness analysis
> exploreRob(df_sole, lbl = 'New, Gene', f_vect = c(0.85, 0.9, 0.95))

7

exploreRep

Similar to exploreRob, the function exploreRep allows the exploration of the re-
producibility of results. This function runs a one-way ANOVA test for groups of
replicates, corresponding to one f value, across various annotation types. Thus, the
inﬂuence of the annotation or the summarisation method can be explored.

exploreRep takes as input a data frame of form shown in Tab. 1. Here the ﬁrst

Label
.
.
.
.
New, Gene
1
New, Exon
2
Old, Gene
3
New, Gene
4
New, Exon
5
Old, Gene
6
New, Gene
7
New, Exon
8
9
Old, Gene
10 New, Gene
.
.

.
.

Variable Value

.
.
0.05
0.05
0.05
0.05
0.05
0.05
0.05
0.05
0.05
0.05
.
.

.
.
3
1
1
1
2
0
2
3
0
2
.
.

Table 1: Input argument for the function exploreRep

column provides the labels for the annotation used for the analysis, the second column
gives the f value and the third column provides the value of the metric to be explored,
e.g., the number of diﬀerentially expressed genes.

exploreRep splits this data frame up to consider only results for one f value. ANOVA
test is run for groups of replicates with corresponding to given list of annotation labels
, Fig 1.

For instance, to explore the reproducibility for a f value of 0.7 cross the annotation
types AnnotA, AnnotB, AnnotC for data frame df run:

12

Manual for the package samExploreR

> #Loading library

> library(samExploreR)
> data("df_sole")
> #Performing robustness analysis
> t = exploreRep(df_sole, lbl_vect = c('New, Gene', 'Old, Gene', 'New, Exon'), f = 0.9)
>

8

plotSamExplorer

This function generates boxplots of the metric under investigation, in our case for
the number of diﬀerentially expressed genes, for diﬀerent values of f.

The input argument of this function should be a data.frame object containing three
columns with the names - Label, Variable, Value.
The data should look like in the following example:

> require(samExploreR)

> ########## Loading the example data
> data("df_sole")
> data("df_intersect")
> head(df_sole)

Label Variable Value

1 New, Gene

2 New, Exon

3 Old, Gene

4 New, Gene

5 New, Exon

6 Old, Gene

0.05

0.05

0.05

0.05

0.05

0.05

3

1

1

1

2

0

> #head(df_intersect)

8.1

Plotting data using the function plotSamExplorer

13

Manual for the package samExploreR

> ### Generation of the plot:

> require(samExploreR)
> data("df_sole")
> plotsamExplorer(df_sole,p.depth=.9,font.size=4, anova=FALSE,save=FALSE)

Figure 1: Boxplot of the number of differentially expressed genes for different sequence-
depths f

> sessionInfo()

R version 3.5.2 (2018-12-20)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default

BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so

LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:
[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8

LC_NUMERIC=C
LC_COLLATE=C

14

lllllllllllllllllllllllllll0501001502000.050.10.150.20.250.30.40.50.60.70.850.90.950.991fAnnotationNew, ExonNew, GeneOld, GeneManual for the package samExploreR

Figure 2: Boxplot of the number of differentially expressed genes for different sequence-
depths f

[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

attached base packages:

[1] stats

graphics grDevices utils

datasets

methods

base

other attached packages:
[1] samExploreR_1.6.1
[3] limma_3.38.3
[5] Rsubread_1.32.2

edgeR_3.24.3
RNAseqData.HNRNPC.bam.chr14_0.20.0
ggplot2_3.1.0

loaded via a namespace (and not attached):
[1] Rcpp_1.0.0
[5] plyr_1.8.4
[9] lattice_0.20-38
[13] pkgconfig_2.0.2

pillar_1.3.1
bindr_0.1.1
evaluate_0.12
rlang_0.3.0.1

compiler_3.5.2
tools_3.5.2
tibble_2.0.0
yaml_2.2.0

BiocManager_1.30.4
digest_0.6.18
gtable_0.2.0
xfun_0.4

15

lllllllllllllllllllllll03060901200.050.10.150.20.250.30.40.50.60.70.850.90.950.991fAnnotationNew, Gene  And New, ExonNew, Gene  And Old, GeneOld, Gene  And New, Gene  And New, ExonManual for the package samExploreR

[17] bindrcpp_0.2.2
[21] locfit_1.5-9.1
[25] R6_2.3.0
[29] scales_1.0.0
[33] colorspace_1.3-2
[37] crayon_1.3.4

withr_2.1.2
grid_3.5.2
rmarkdown_1.11
htmltools_0.3.6
labeling_0.3

dplyr_0.7.8
tidyselect_0.2.5
purrr_0.2.5
assertthat_0.2.0
lazyeval_0.2.1

knitr_1.21
glue_1.3.0
magrittr_1.5
BiocStyle_2.10.0
munsell_0.5.0

References

[1] Alexey Stupnikov, Shailesh Tripathi, Ricardo de Matos Simoes, Darragh McArt, Manuel
Salto-Tellez, Galina Glazko, Matthias Dehmer, and Frank Emmert-Streib. samExploreR:
exploring reproducibility and robustness of RNA-seq results based on SAM ﬁles.
Bioinformatics, 32(21):3345–3347, November 2016. URL:
http://dx.doi.org/10.1093/bioinformatics/btw475,
doi:10.1093/bioinformatics/btw475.

[2] Y Liao, GK Smyth, and W Shi. featurecounts: an eﬃcient general-purpose read

summarization program. arXiv, 1305:16, 2013.

16

