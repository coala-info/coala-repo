The coMET User Guide

Tiphaine C. Martin 1, Tom Hardiman, Idil Yet, Pei-Chien
Tsai, Jordana T. Bell

1

tiphaine.martin@mssm.edu

Edited: March 2018; Compiled: October 30, 2018

1

Citation

citation(package='coMET')

##

## To cite 'coMET' in publications use:

##

##

##

##

##

##

##

##

Martin, T., Erte, I, Tsai, P-C, Bell, J.T. coMET: an R plotting package to

visualize regional plots of epigenome-wide association scan results QG14, 2014

Martin, T., Yet, I, Tsai, P-C, Bell, J.T. coMET: visualisation of regional

epigenome-wide association scan results and DNA co-methylation patterns BMC

Bioinformatics, 2015 (accepted)

## To see these entries in BibTeX format, use 'print(<citation>, bibtex=TRUE)',

## 'toBibtex(.)', or set 'options(citation.bibtex.max=999)'.

The coMET User Guide

Contents

1

2

3

4

Citation.

Usage .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Install the development version of coMET from Bioconductor .

Install the version of coMET from gitHub .

Functions in coMET .

File formats .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Format of the info ﬁle (for option: mydata.file, mandatory) .

Format of correlation matrix (for option: cormatrix.file, manda-
tory) .
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Format of extra info ﬁle (for option: mydata.large.file) .

Format of annotation ﬁle (for option biofeat.user.file) .

Option of conﬁg.ﬁle .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

5

Creating a plot like the webservice: comet.web .

coMET plot: usage and plot like in the webservice .

Hidden values of comet.web function .

.

.

.

.

6

Creating a plot with the generic function: comet.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

coMET plot: pvalue plot, annotation tracks, and correlation
matrix .
.
.
.
.
6.1.1
.
.
.
6.1.2

.
.
.
Input from data ﬁles .
.
coMET plot using input from a data frame.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.

.

.

.

.

.

.

.

.

coMET plot: annotation tracks and correlation matrix .

coMET plot: Manhattan plot and anonation track .

.

.

.

.

.

.

2.1

2.2

4.1

4.2

4.3

4.4

4.5

5.1

5.2

6.1

6.2

6.3

7

8

Extract the signiﬁcant correlations between omic features .

Annotation tracks .

.

.

.

.

.

.

.

.

.

.

.

.

.

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

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Ensembl.
.
.
.
.
8.1.1 Genes and transcripts from Ensembl .
.
.
Regulatory elements from Ensembl .
8.1.2
.
8.1.3
.
.
structureBiomart from Ensembl .
.
8.1.4 miRNA Target Regions from Ensembl .
8.1.5
.
.
8.1.6 Other Regulatory Regions Biomart from Ensembl .
.
Regulatory Features Biomart from Ensembl .
8.1.7

Binding Motif Biomart from Ensembl

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.

.

.

.

.
.
.
.
.
.
.
.

.

.
.
.
.
.
.
.
.

.

.

.

.

.

.

.

.

.

.

.

.
.
.

.

.

.

.

.
.
.
.
.
.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

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

5

7

7

8

9

9

11

12

12

12

16

16

17

18

18
18
20

22

24

26

28

28
29
29
31
31
32
33
33

2

The coMET User Guide

8.1.8 Other Regulatory Segments Biomart from Ensembl .
8.1.9

.
Regulatory Evidence Elements Biomart from Ensembl.

8.2

8.3

8.4

8.5

8.6

8.7

8.8

8.9

9.1

9.2

.

.

.

.

.

.

.

UCSC .
.
.
8.2.1
8.2.2
.
8.2.3 Other potential data from UCSC .

.
.
.
.
ChromHMM from UCSC .
ISCA track (obselete database) .

.
.

.
.

.

.

.

.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

NIH Roadmap epigenomics project
Chromatin state .
8.3.1
.
.
DNA Motif Positional Bias in Digital Genomic Footprinting
8.3.2
Sites .
.
.
.
.
DNaseI-accessible regulatory regions .
.
Processed data and Imputed data .

8.3.3
8.3.4

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

ENCODE and GENCODE data .
8.4.1

.
Predicting motifs and active regulators .

.

.

.

.

.

GTEx Portal .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.

.
.

.

.
.

.

.
.

.

.
.

.

.
.

.

.

.

.

.

.

.

Hi-C data .
8.6.1
8.6.2
8.6.3

.
.
Hi-C data at 1kb resolution at Lieberman Aiden lab .
.
.
.
Hi-C Data Browser .
.
.
Hi-C project at Ren Lab.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

FANTOM5 database .

BLUEprint project .

.

.

.

Our data.
.
8.9.1
.
8.9.2 metQTL data .

.
.
eQTL data .

.

.

.
.
.

.

.

.
.
.

.

.

.
.
.

.

.

.

.
.
.

.

.

.

.
.
.

.

.

.

.
.
.

.

.

.

.
.
.

.

.

.

.
.
.

.

.

.

.
.
.

.

How to use the coMET web-service .

How to install the coMET web-service .

9

coMET : Shiny web-service .

10

FAQs .

.

.

.

.

.

.

.

.

11 Acknowledgement .

12 SessionInfo .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.

.

.

.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.

.

.

.

.

.

.

.
.

.
.
.
.

.
.

.

.
.
.
.

.

.

.
.
.

.

.

.

.

.

.

.
.

.

.
.
.
.

.

.

.
.
.

.

.

.

.

.

.

.
.

.
.
.
.

.
.

.
.
.

.
.

.

.
.
.
.

.

.

.
.
.

.

.

.

.

.

.

33
34

38
39
41
41

42
42

46
46
47

49
50

52

57
57
57
58

59

61

61
61
61

63

63

63

67

69

70

3

The coMET User Guide

Abstract

The coMET package is a web-based plotting tool and R-based package to visualize
omic-WAS results in a genomic region of interest, such as EWAS (epigenome-wide
association scan). coMET provides a plot of the EWAS association signal and vi-
sualisation of the methylation correlation between CpG sites (co-methylation). The
coMET package also provides the option to annotate the region using functional
genomic information, including both user-deﬁned features and pre-selected features
based on the Encode project. The plot can be customized with diﬀerent parameters,
such as plot labels, colours, symbols, heatmap colour scheme, signiﬁcance thresholds,
and including reference CpG sites. Finally, the tool can also be applied to display the
correlation patterns of other genomic data in any species, e.g. gene expression array
data.

coMET generates a multi-panel plot to visualize EWAS results, co-methylation pat-
terns, and annotation tracks in a genomic region of interest. A coMET ﬁgure (cf.
Fig. 1) includes three components:

1. the upper plot shows the strength and extent of EWAS association signal;

2. the middle panel provides customized annotation tracks;

3. the lower panel shows the correlation between selected CpG sites in the genomic

region.

The structure of the plots builds on snp.plotter [1], with extensions to incorporate
genomic annotation tracks and customized functions.
coMET produces plots in
PDF and Encapsulated Postscript (EPS) format.

The current version of coMET can visualise EWAS results and annotations from a
genomic region up to an entire chromosome in the upper and middle panels of the
coMET plot. However, the lower panel (co-methylation) is restricted to visualising
a maximum of 120 single-CpG or region-based datapoints. This limitation is due
to limitations in the size of a standard A4 plot, and may be updated in the near
future. However, the user can use the function comet.list to extracts all signiﬁcant
correlations beyond a given threshold in the dataset from either a genomic region or
from an entire chromosome if required.

4

The coMET User Guide

2

Usage

coMET requires the installation of R, the statistical computing software, freely avail-
able for Linux, Windows, or MacOS. coMET can be downloaded from bioconductor.
Packages can be installed using the install.packages command in R. The coMET R
package includes two major functions comet.web and comet to visualise omci-WAS
results.

• The function comet.web generates output plot with the same settings of ge-
nomic annotation tracks as that of the webservice (http://epigen.kcl.ac.uk/
comet or direcly http://comet.epigen.kcl.ac.uk:3838/coMET/).

• The function comet generates output plots with the customized annotation

tracks deﬁned by user.

if (!requireNamespace("BiocManager", quietly=TRUE))

install.packages("BiocManager")

BiocManager::install("coMET")

coMET uses the packages called psych, corrplot and colortools, which are not avail-
able from bioconductor. This must be installed before the installation of coMET

install.packages("psych")

install.packages("corrplot")

install.packages("colortools")

coMET has a development version on gitHub, go to the section "Install the develop-
ment version of coMET from Bioconductor ".

You can install also on the version R 3.2.2 via the master version of package on
gitHub. The same steps must be followed as described in the section "Install the
development version of coMET from Bioconductor ".

After downloading from Bioconductor or gitHUB, and installing on your computer,
coMET can be loaded into a R session using this command:

library("coMET")

## Loading required package:

grid

## Loading required package:

biomaRt

## Loading required package:

Gviz

## Loading required package:

S4Vectors

## Loading required package:

stats4

## Loading required package:

BiocGenerics

## Loading required package:

parallel

5

The coMET User Guide

##

## Attaching package: ’BiocGenerics’

## The following objects are masked from ’package:parallel’:

##

##

##

##

clusterApply, clusterApplyLB, clusterCall, clusterEvalQ, clusterExport,

clusterMap, parApply, parCapply, parLapply, parLapplyLB, parRapply,

parSapply, parSapplyLB

## The following objects are masked from ’package:stats’:

##

##

IQR, mad, sd, var, xtabs

## The following objects are masked from ’package:base’:

##

##

##

##

##

rank,

##

##

##

Filter, Find, Map, Position, Reduce, anyDuplicated, append, as.data.frame,

basename, cbind, colMeans, colSums, colnames, dirname, do.call, duplicated,

eval, evalq, get, grep, grepl, intersect, is.unsorted, lapply, lengths,

mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,

rbind, rowMeans, rowSums, rownames, sapply, setdiff, sort, table, tapply,

union, unique, unsplit, which, which.max, which.min

## Attaching package: ’S4Vectors’

## The following object is masked from ’package:base’:

##

##

expand.grid

## Loading required package:

IRanges

## Loading required package:

GenomicRanges

## Loading required package:

GenomeInfoDb

## Loading required package:

psych

##

## Attaching package: ’psych’

## The following object is masked from ’package:IRanges’:

##

##

reflect

The conﬁguration ﬁle speciﬁes the options for the coMET plot. Example conﬁgura-
tion and input ﬁles are also provided on http://epigen.kcl.ac.uk/comet. Information
about the package can viewed from within R using this command:

6

The coMET User Guide

?comet

?comet.web

?comet.list

2.1

Install the development version of coMET from Bioconductor

To install coMET from the development version of Bioconductor, the user must install
the appropriate R version. See http://www.bioconductor.org/developers/how-to/
useDevel/ for more details. Following this installation, use the standard Bioconductor
command:

if (!requireNamespace("BiocManager", quietly=TRUE))

install.packages("BiocManager")

BiocManager::install(version = "devel")

BiocManager::install("coMET")

2.2

Install the version of coMET from gitHub

Another way to install coMET is to download the master package from gitHUB
https://github.com/TiphaineCMartin/coMET or the devel package https://github.
com/TiphaineCMartin/coMET/tree/devel. Once downloaded use command line:

install.packages("YourPath/coMET_YourVersion.tar.gz",repos=NULL,type="source")
##This is an example
install.packages("YourPath/coMET_0.99.9.tar.gz",repos=NULL,type="source")

7

The coMET User Guide

3

Functions in coMET

Currently, there are 3 main functions:

1. comet.web is the pre-customized function that allows us to visualise quickly
EWAS (or other omic-WAS) results, annotation tracks, and correlations be-
tween features. This version is installed in the Shiny web-service. Currently, it
is formated only to visualise human data.

2. comet is the generic function that allows us to visualise quickly EWAS results,
annotation tracks, and correlations between features. Users can visualise more
personalised annotation tracks and give multiple extra EWAS/omic-WAS re-
sults to plot.

3. comet.list is an additional function that allows us to extract the values of cor-
relations, the pvalues, and estimates and conﬁdence intervals for all datapoints
that surpass a particular threshold.

The functions can read the data input ﬁles, but it is also possible to use data frames
within R for all data input except for the conﬁguration ﬁle. The latter can be achieved
with the two functions comet and comet.list. The structure of the data frames
(number of columns, type, format) follows the same rules as for the data input ﬁles
(cf. section "File formats").

8

The coMET User Guide

4

File formats

There are ﬁve types of ﬁles that can be given by the user to produce the plot:

1. Info ﬁle is deﬁned in the option mydata.file. Warning: This is mandatory and

has to be in tabular format with a header.

2. Correlation ﬁle is deﬁned in the option cormatrix.file. Warning: This is

mandatory and has to be in tabular format with a header.

3. Extra info ﬁles are deﬁned in the option mydata.file.large. Warning: This is

optional, and if provided has to be in tabular format with a header.

4. Annotation info ﬁle is deﬁned in the option biofeat.user.file. This op-
tion exists only in the function comet.web and the user should inform also
the format to visualise this data with the options biofeat.user.type and
biofeat.user.type.plot.

5. Conﬁguration ﬁle contains the values of these options instead of deﬁning these
by command line. Warning: Each line in the ﬁle is one option. The name of
the option is in capital letters and is separated by its value by "=". If there are
multiple values such as for the option list.tracks or the options for additional
data, you need to separated them by a "comma".

4.1

Format of the info ﬁle (for option: mydata.file, mandatory)

Warning: This ﬁle is mandatory and has to be in tabular format with a header.
The name of features has to start by a letter.
Info ﬁles can be a list of CpG sites
with/without Beta value (for example DNA methylation level) or direction sign. If it
is a site ﬁle then it is mandatory to have the 4 columns as shown below with headers
in the same order. Beta can be the 5th column(optional) and can be either a numeric
value (positive or negative values) or only direction sign ("+", "-"). The number of
columns and their types are deﬁned by the option mydata.format.

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
infofile <- file.path(extdata, "cyp1b1_infofile.txt")

data_info <-read.csv(infofile, header = TRUE,
sep = "\t", quote = "")

head(data_info)

##

TargetID CHR MAPINFO

Pval

## 1 cg22248750

2 38294160 2.749858e-01

## 2 cg11656478

2 38297759 7.794549e-01

## 3 cg14407177

2 38298023 2.863869e-01

## 4 cg02162897

2 38300537 3.148201e-07

9

The coMET User Guide

## 5 cg20408276

2 38300586 1.467739e-06

## 6 cg00565882

2 38300707 7.563132e-03

Alternatively, the info ﬁle can be region-based and if so, the region-based info ﬁle
must have the 5 columns (see below) with headers in this order. The beta or direction
can be included in the 6th column (optional).

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
infoexp <- file.path(extdata, "cyp1b1_infofile_exprGene_region.txt")

data_infoexp <-read.csv(infoexp, header = TRUE, sep = "\t", quote = "")

head(data_infoexp)

##
## 1 ENSG00000138061.7_38294652_38298453
## 2 ENSG00000138061.7_38301489_38302532
## 3 ENSG00000138061.7_38302919_38303323

TargetID CHR MAPINFO.START MAPINFO.STOP

Pval BETA

2

2

2

38294652

38301489

38302919

38298453 3.064357e-17

38302532 1.145430e-07

38303323 1.014050e-08

+

+

-

In summary, there are 4 possible formats for the info ﬁle:

1. site: 4 columns with a header:

(a) Name of omic feature

(b) Name of chromosome

(c) Position of omic feature

(d) P-value of omic feature

2. region: 5 columns with a header:

(a) Name of omic feature

(b) Name of chromosome

(c) Start position of omic feature

(d) End position of omic feature

(e) P-value of omic feature

3. site_asso: 5 columns with a header:

(a) Name of omic feature

(b) Name of chromosome

(c) Position of omic feature

(d) P-value of omic feature

10

The coMET User Guide

(e) Direction of association related to this omic feature. This can be the sign

or an actual value of association eﬀect size.

4. region_asso: 6 columns with a header:

(a) Name of omic feature

(b) Name of chromosome

(c) Start position of omic feature

(d) End position of omic feature

(e) P-value of omic feature

(f) Direction of association related to this omic feature. This can be the sign

or an actual value of association eﬀect size.

4.2

Format of correlation matrix (for option: cormatrix.file, manda-
tory)

Warning: This ﬁle is mandatory and has to be in tabular format with an header. The
data ﬁle used for the correlation matrix is described in the option cormatrix.file.
This tab-delimited ﬁle can take 3 formats described in the option cormatrix.format:

1. cormatrix: pre-computed correlation matrix provided by the user; Dimension
of matrix : CpG_number X CpG_number. Need to put the CpG sites/regions
in the ascending order of positions and to have a header with the name of CpG
sites/regions;

2. raw: Raw data format. Correlations of these can be computed by one of 3
methods Spearman, Pearson, Kendall (option cormatrix.method). Dimension
of matrix : sample_size X CpG_number. Need to have a header with the name
of CpG sites/regions ;

3. raw_rev: Raw data format. Correlations of these can be computed by one of 3
methods Spearman, Pearson, Kendall (option cormatrix.method). Dimension
of matrix : CpG_number X sample_size. Need to have the row names of CpG
sites/regions and a header with the name of samples ;

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
corfile <- file.path(extdata, "cyp1b1_res37_rawMatrix.txt")

data_cor <-read.csv(corfile, header = TRUE,
sep = "\t", quote = "")

data_cor[1:6,1:6]

##

cg22248750 cg11656478 cg14407177

cg02162897 cg20408276

cg00565882

## 1 -0.08636815 -0.4896557

1.6718967

0.52423342

0.1659252

0.224221521

## 2 -0.00107899 -0.6330666

0.3150612 -0.29820805 -0.4339332 -0.007794883

11

The coMET User Guide

## 3 0.31656883 -0.2610083 -0.4942691

0.04657351

0.1840397

0.313967471

## 4 -0.40914999

0.6816058 -0.3251337 -0.58656175 -0.2069954

0.150719803

## 5 1.29953262

0.3985525 0.1119045

0.81181511

0.1833470

0.194928273

## 6 -1.11948826

0.3035820 -1.2794597 -0.49785237

0.1076348 -0.876011670

4.3

Format of extra info ﬁle (for option: mydata.large.file)

Warning: This ﬁle is optional ﬁle and if provided has to be in tabular format with an
header. The name of features has to start by a letter. The extra info ﬁles can be de-
scribed in the option mydata.large.file and their format in mydata.large.format.
More than one extra info ﬁle can be used, each should be separated by a comma.

This can be another type of info ﬁle (e.g expression or replication data) and should
follow the same rules as the standard info ﬁle.

4.4

Format of annotation ﬁle (for option biofeat.user.file)

The ﬁle is deﬁned in the option biofeat.user.file and the format of ﬁle is the
format accepted by Gviz (BED, GTF, and GFF3).

4.5

Option of conﬁg.ﬁle

Warning: Each line in the ﬁle is one option. The name of the option is in lowercase
letters and is separated by its value by "=" without space. If there are multiple values
such as for the option list.tracks or options for additional data, these need to be
If you would like to make your own
separated them by a "comma" withou space.
changes to the plot you can download the conﬁguration ﬁle, make changes to it, and
upload it into R as shown in the example below.

The important options of a coMET ﬁgure include three components:

1. The upper plot shows the strength and extent of EWAS association signal on

a regional Manhattan plot.

• pval.threshold: Signiﬁcance threshold to be displayed as a red dashed

line

• pval.threshold2: Another Signiﬁcance threshold (optional)

• disp.pvalueplot: Value can be TRUE or FALSE. Used to either display

or hide Manhattan plot.

• disp.beta.association: Value can be TRUE or FALSE. Used to show

the eﬀect size.

12

The coMET User Guide

• disp.association: This logical option works only if mydata.file contains
the eﬀect direction (mydata.format=site_asso or region_asso). The
value can be TRUE or FALSE: if FALSE (default), for each point of data
in the p-value plot, the colour of symbol is the colour of co-methylation
pattern between the point and the reference site; if TRUE, the eﬀect
direction is shown.
If the association is positive, the colour is the one
deﬁned with the option color.list. On the other hand, if the association
is negative, the colour is the inverse to that selected.

• disp.region : This logical option works only if the option mydata.file
contains regions (mydata.format=region or region_asso). The value
If TRUE, the genomic element will
can be TRUE or FALSE (default).
be shown as a continuous line with the colour of the element, in addition
to the symbol at the center of the region. If FALSE, only the symbol is
shown.

2. The middle panel provides customized annotation tracks;

• list.tracks (for comet.web function): List of annotation tracks to be vi-
sualised. Tracks currently available: geneENSEMBL, CGI, ChromHMM,
DNAse, RegENSEMBL, SNP, transcriptENSEMBL, SNPstoma, SNPstru,
SNPstrustoma, GAD, ClinVar, GeneReviews, GWAS, ClinVarCNV, GC-
content, genesUCSC, xenogenesUCSC, metQTL, eQTL, BindingMotifs-
Biomart, chromHMM_RoadMap, miRNATargetRegionsBiomart, Other-
RegulatoryRegionsBiomart, RegulatoryEvidenceBiomart and segmentalDup-
sUCSC. The elements are separated by a comma.

• tracks.gviz (for comet function): For each option, it is possible to give
a list of annotation tracks that is created by the Gviz bioconductor pack-
ages. Warning: It is noted that the new version of coMET does not sup-
port more the visualisation using tracks.ggbio and tracks.trackviewer
from GGBio and TrackViewer because The integration of plots from ggbio
and trackviewer can be sometimes not really perfect. So only now, it is
possible to create plots from Gviz and use tracks.gviz

3. The lower panel shows the correlation between selected CpG sites in the

genomic region (heatmap).

• cormatrix.format : Format of the input ﬁle cormatrix.ﬁle: either raw
data (option RAW if CpG sites are by column and samples by row or option
RAW_REV if CpG site are by row and samples by column) or correlation
matrix (option CORMATRIX)

• cormatrix.method : If raw data are provided it will be necessary to pro-
duce the correlation matrix using one of 3 methods (spearman, pearson
and kendall).

• cormatrix.color.scheme : There are 5 colour schemes (heat, bluewhitered,

cm, topo, gray, bluetored)

13

The coMET User Guide

• disp.cormatrixmap : logical option TRUE or FALSE. TRUE (default), if

FALSE correlation matrix is not shown

• cormatrix.conf.level : Alpha level for the conﬁdence interval. Default

value= 0.05. CI will be the alpha/2 lower and upper values.

• cormatrix.sig.level : Signiﬁcant level to visualise the correlation.

If
the correlation has a pvalue under the signiﬁcant level, the correlation will
be colored in "goshwhite", else the color is related to the correlation level
and the color scheme choosen.Default value =1.

• cormatrix.adjust : Indicates which adjustment for multiple tests should
"holm", "hochberg", "hommel", "bonferroni", "BH", "BY",

be used.
"fdr", "none".Default value="none".

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
configfile <- file.path(extdata, "config_cyp1b1_zoom_4webserver_Grch38.txt")

data_config <-read.csv(configfile, quote = "", sep="\t", header=FALSE)
data_config

##

## 1

## 2

## 3

## 4

## 5

## 6

## 7

## 8

## 9

## 10

## 11

## 12

## 13

## 14

## 15

## 16

## 17

## 18

## 19

## 20

## 21

## 22

## 23

## 24

## 25

## 26

V1

disp.mydata=TRUE

mydata.format=site

sample.labels=CpG

symbols=circle-fill

lab.Y=log

disp.color.ref=TRUE

mydata.ref=cg02162897

pval.threshold=4.720623e-06

disp.association=FALSE

disp.region=FALSE

start=38066017

end=38108036
mydata.large.format=region_asso
disp.association.large=TRUE

disp.region.large=TRUE

sample.labels.large=Gene expression

color.list.large=green

symbols.large=diamond-fill

cormatrix.format=raw

disp.cormatrixmap=TRUE

cormatrix.method=spearman

cormatrix.color.scheme=bluewhitered

cormatrix.conf.level=0.05

cormatrix.sig.level=1

cormatrix.adjust=none

disp.phys.dist=TRUE

14

The coMET User Guide

## 27

## 28

## 29

## 30

## 31

disp.color.bar=TRUE

disp.legend=TRUE

list.tracks=geneENSEMBL,ChromHMM,DNAse,RegENSEMBL

disp.mult.lab.X=FALSE

image.type=pdf

## 33

## 32 image.title="Example a-DMR in CYP1B1 in Adipose tissue"
image.name=cyp1b1_zoom_plus_name_expr
image.size=3.5

## 34

## 35

## 36

genome=hg38
dataset.geneE=hsapiens_gene_ensembl

15

The coMET User Guide

5

Creating a plot like the webservice: comet.web

5.1

coMET plot: usage and plot like in the webservice

The user can create a coMET plot via the coMET website (http://epigen.kcl.ac.
uk/comet). It is possible to reproduce the web service plotting defaults by using the
function comet.web, for example see Figure 1.

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
myinfofile <- file.path(extdata, "cyp1b1_infofile_Grch38.txt")
myexpressfile <- file.path(extdata, "cyp1b1_infofile_exprGene_region_Grch38.txt")
mycorrelation <- file.path(extdata, "cyp1b1_res37_rawMatrix.txt")
configfile <- file.path(extdata, "config_cyp1b1_zoom_4webserver_Grch38.txt")
comet.web(config.file=configfile, mydata.file=myinfofile,

cormatrix.file=mycorrelation ,mydata.large.file=myexpressfile,

print.image=FALSE,verbose=FALSE)

Figure 1: Plot with comet.web function.

16

Example a−DMR in CYP1B1 in Adipose tissueChromosome 2p1238066017 bp38108036 bp38066017 bp38108036 bp01234567891011121314151617−log10(P−value)lllllllllllllllllllllllllllllllllllllcg02162897lCpG lGene expression  cg02486145 cg06202585 cg19753864 cg23838231 cg09440493 cg21715189 cg12802310 cg08620474 cg16248783 cg09456297 cg03648789 cg09130556 cg07301433 cg26036993 cg08761102 cg22488859 cg23549225 cg06861880 cg01936270 cg07380506 cg07057636 cg01834566 cg14957547 cg25856383 cg07078841 cg16439198 cg03890222 cg01410359 cg09799983 cg20254225 cg06264984 cg00565882 cg20408276 cg02162897 cg14407177 cg11656478 cg22248750 cg02486145 cg06202585 cg19753864 cg23838231 cg09440493 cg21715189 cg12802310 cg08620474 cg16248783 cg09456297 cg03648789 cg09130556 cg07301433 cg26036993 cg08761102 cg22488859 cg23549225 cg06861880 cg01936270 cg07380506 cg07057636 cg01834566 cg14957547 cg25856383 cg07078841 cg16439198 cg03890222 cg01410359 cg09799983 cg20254225 cg06264984 cg00565882 cg20408276 cg02162897 cg14407177 cg11656478 cg22248750Correlation Matrix Map Type: SpearmanPhysical Distance: 42 kb10.60.2−0.2−0.6−1LINC00211LINC00211ENSEMBL GenesBroad ChromHMMDNase ClustersRegulation ENSEMBLThe coMET User Guide

5.2

Hidden values of comet.web function

Hidden values of comet.web function are shown in the section. If these values do not
correspond to what you want to visualise, you need to use the function comet, as a
more generic option.

Option
mydata.type
mydata.large.type
cormatrix.type
disp.cormatrixmap
disp.pvalueplot
disp.mydata.names
disp.connecting.lines
disp.mydata
disp.type
biofeat.user.type.plot
tracks.gviz
tracks.ggbio
tracks.trackviewer
biofeat.user.ﬁle
palette.ﬁle
disp.color.bar
disp.phys.dist
disp.legend
disp.marker.lines
disp.mult.lab.X
connecting.lines.factor
connecting.lines.adj
connecting.lines.vert.adj
connecting.lines.ﬂex
color.list
font.factor
dataset.gene
DATASET.SNP
VERSION.DBSNP
DATASET.SNP.STOMA
DATASET.REGULATION
DATASET.STRU

Value
FILE
LISTFILE
LISTFILE
TRUE
TRUE
TRUE
TRUE
TRUE
symbol
histogram
NULL
NULL
NULL
NULL
NULL
TRUE
TRUE
TRUE
TRUE
FALSE
1.5
0.01
-1
0
red
NULL
hsapiens_gene_ensembl
hsapiens_snp
snp142Common
hsapiens_snp_som
hsapiens_feature_set
hsapiens_structvar

DATASET.STRU.STOMA hsapiens_structvar_som

BROWSER.SESSION

UCSC

17

The coMET User Guide

6

Creating a plot with the generic function: comet

It is possible to create the annotation tracks by Gviz, trackviewer or ggbio, for
example see Figure 2. Currently, the Gviz option for annotation tracks, in combination
with the heatmap of correlation values between genomic elements, provides the most
informative and easy approach to visualize graphics.

6.1

coMET plot: pvalue plot, annotation tracks, and correlation
matrix

6.1.1

Input from data ﬁles

In this ﬁgure 2, we create diﬀerent tracks outside to coMET with Gviz. The list of
annotation tracks and diﬀerent ﬁles are given to the function coMET.

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
configfile <- file.path(extdata, "config_cyp1b1_zoom_4comet.txt")
myinfofile <- file.path(extdata, "cyp1b1_infofile.txt")
myexpressfile <- file.path(extdata, "cyp1b1_infofile_exprGene_region.txt")
mycorrelation <- file.path(extdata, "cyp1b1_res37_rawMatrix.txt")

chrom <- "chr2"

start <- 38290160

end <- 38303219

gen <- "hg19"
strand <- "*"

BROWSER.SESSION="UCSC"

mySession <- browserSession(BROWSER.SESSION)

genome(mySession) <- gen

genetrack <-genes_ENSEMBL(gen,chrom,start,end,showId=TRUE)
snptrack <- snpBiomart_ENSEMBL(gen,chrom, start, end,

cpgIstrack <- cpgIslands_UCSC(gen,chrom,start,end)

dataset="hsapiens_snp_som",showId=FALSE)

prombedFilePath <- file.path(extdata, "/RoadMap/regions_prom_E063.bed")
promRMtrackE063<- DNaseI_RoadMap(gen,chrom,start, end, prombedFilePath,

featureDisplay='promotor', type_stacking="squish")

bedFilePath <- file.path(extdata, "RoadMap/E063_15_coreMarks_mnemonics.bed")
chromHMM_RoadMapAllE063 <- chromHMM_RoadMap(gen,chrom,start, end,

bedFilePath, featureDisplay = "all",

18

The coMET User Guide

listgviz <- list(genetrack,snptrack,cpgIstrack,promRMtrackE063,chromHMM_RoadMapAllE063)

colorcase='roadmap15' )

comet(config.file=configfile, mydata.file=myinfofile, mydata.type="file",

cormatrix.file=mycorrelation,

cormatrix.type="listfile",

mydata.large.file=myexpressfile, mydata.large.type="listfile",

tracks.gviz=listgviz, verbose=FALSE, print.image=FALSE)

Figure 2: Plot with comet function from ﬁles.

19

Example a−DMR in CYP1B1 in Adipose tissueChromosome 2p1238290160 bp38303219 bp38290160 bp38303219 bp0246810121416−log10(P−value)llllllllllllllcg02162897lCpG lGene express cg02486145 cg06202585 cg19753864 cg23838231 cg09440493 cg21715189 cg12802310 cg08620474 cg16248783 cg09456297 cg03648789 cg09130556 cg07301433 cg26036993 cg08761102 cg22488859 cg23549225 cg06861880 cg01936270 cg07380506 cg07057636 cg01834566 cg14957547 cg25856383 cg07078841 cg16439198 cg03890222 cg01410359 cg09799983 cg20254225 cg06264984 cg00565882 cg20408276 cg02162897 cg14407177 cg11656478 cg22248750 cg02486145 cg06202585 cg19753864 cg23838231 cg09440493 cg21715189 cg12802310 cg08620474 cg16248783 cg09456297 cg03648789 cg09130556 cg07301433 cg26036993 cg08761102 cg22488859 cg23549225 cg06861880 cg01936270 cg07380506 cg07057636 cg01834566 cg14957547 cg25856383 cg07078841 cg16439198 cg03890222 cg01410359 cg09799983 cg20254225 cg06264984 cg00565882 cg20408276 cg02162897 cg14407177 cg11656478 cg22248750Correlation Matrix Map Type: SpearmanPhysical Distance: 13.1 kb10.60.2−0.2−0.6−1RMDN2CYP1B1CYP1B1−AS1RMDN2−AS11The coMET User Guide

6.1.2

coMET plot using input from a data frame

In this ﬁgure 3, we visualize the same data as in ﬁgure 2, but the data is in data
frame format and not read in from an input ﬁle.

In addition, if the user would like to visualise only the correlations between CpG
sites with P-value less than or equal to 0.05 in the upper plot, this option can be
included. The correlations with a P-value greater than 0.05 can have the colour
"goshwhite" whereas the other correlations will be displayed using a colour related
to the correlation level. Conversely, in the P-value plot (upper plot), the points of
each omic feature have their colours related to their correlations with the reference
omic feature without taking into account the P-value associated with the correlation
matrix.

Eventually, we increase the size of font using the option fontsize.gviz

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
configfile <- file.path(extdata, "config_cyp1b1_zoom_4comet.txt")
myinfofile <- file.path(extdata, "cyp1b1_infofile.txt")
myexpressfile <- file.path(extdata, "cyp1b1_infofile_exprGene_region.txt")
mycorrelation <- file.path(extdata, "cyp1b1_res37_rawMatrix.txt")

chrom <- "chr2"

start <- 38290160

end <- 38303219

gen <- "hg19"
strand <- "*"

BROWSER.SESSION="UCSC"

mySession <- browserSession(BROWSER.SESSION)

genome(mySession) <- gen

genetrack <-genes_ENSEMBL(gen,chrom,start,end,showId=TRUE)
snptrack <- snpBiomart_ENSEMBL(gen,chrom, start, end,

dataset="hsapiens_snp_som",showId=FALSE)

#Data no more available in UCSC (from September 2015)
iscatrack <-ISCA_UCSC(gen,chrom,start,end,mySession, table="iscaPathogenic")

listgviz <- list(genetrack,snptrack,iscatrack)

matrix.dnamethylation <- read.delim(myinfofile, header=TRUE, sep="\t", as.is=TRUE,

matrix.expression <- read.delim(myexpressfile, header=TRUE, sep="\t", as.is=TRUE,

blank.lines.skip = TRUE, fill=TRUE)

cormatrix.data.raw <- read.delim(mycorrelation, sep="\t", header=TRUE, as.is=TRUE,

blank.lines.skip = TRUE, fill=TRUE)

blank.lines.skip = TRUE, fill=TRUE)

20

The coMET User Guide

listmatrix.expression <- list(matrix.expression)

listcormatrix.data.raw <- list(cormatrix.data.raw)

comet(config.file=configfile, mydata.file=matrix.dnamethylation,

mydata.type="dataframe",cormatrix.file=listcormatrix.data.raw,

cormatrix.type="listdataframe",cormatrix.sig.level=0.05,

cormatrix.conf.level=0.05, cormatrix.adjust="BH",

mydata.large.file=listmatrix.expression, mydata.large.type="listdataframe",

fontsize.gviz =12,

tracks.gviz=listgviz,verbose=FALSE, print.image=FALSE)

Figure 3: Plot with comet function from matrix data and with a pvalue threshold for the
correlation between omics features (here CpG sites).

21

Example a−DMR in CYP1B1 in Adipose tissueChromosome 238290160 bp38303219 bp38290160 bp38303219 bp0246810121416−log10(P−value)llllllllllllllcg02162897lCpG lGene express cg02486145 cg06202585 cg19753864 cg23838231 cg09440493 cg21715189 cg12802310 cg08620474 cg16248783 cg09456297 cg03648789 cg09130556 cg07301433 cg26036993 cg08761102 cg22488859 cg23549225 cg06861880 cg01936270 cg07380506 cg07057636 cg01834566 cg14957547 cg25856383 cg07078841 cg16439198 cg03890222 cg01410359 cg09799983 cg20254225 cg06264984 cg00565882 cg20408276 cg02162897 cg14407177 cg11656478 cg22248750 cg02486145 cg06202585 cg19753864 cg23838231 cg09440493 cg21715189 cg12802310 cg08620474 cg16248783 cg09456297 cg03648789 cg09130556 cg07301433 cg26036993 cg08761102 cg22488859 cg23549225 cg06861880 cg01936270 cg07380506 cg07057636 cg01834566 cg14957547 cg25856383 cg07078841 cg16439198 cg03890222 cg01410359 cg09799983 cg20254225 cg06264984 cg00565882 cg20408276 cg02162897 cg14407177 cg11656478 cg22248750Correlation Matrix Map Type: SpearmanPhysical Distance: 13.1 kb10.60.2−0.2−0.6−1RMDN2CYP1B1CYP1B1−AS1RMDN2−AS1The coMET User Guide

6.2

coMET plot: annotation tracks and correlation matrix

It is possible to visualise only annotation tracks and the correlation between genetic
In this case, we need to use the option disp.pvalueplot=FALSE, for ex-
elements.
ample see Figure 4.

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
configfile <- file.path(extdata, "config_cyp1b1_zoom_4cometnopval.txt")
myinfofile <- file.path(extdata, "cyp1b1_infofile.txt")
mycorrelation <- file.path(extdata, "cyp1b1_res37_rawMatrix.txt")

chrom <- "chr2"

start <- 38290160

end <- 38303219

gen <- "hg19"
strand <- "*"

genetrack <-genes_ENSEMBL(gen,chrom,start,end,showId=FALSE)
snptrack <- snpBiomart_ENSEMBL(gen, chrom, start, end,

strutrack <- structureBiomart_ENSEMBL(chrom, start, end,

dataset="hsapiens_snp_som",showId=FALSE)

strand, dataset="hsapiens_structvar_som")

clinVariant<-ClinVarMain_UCSC(gen,chrom,start,end)
clinCNV<-ClinVarCnv_UCSC(gen,chrom,start,end)
gwastrack <-GWAScatalog_UCSC(gen,chrom,start,end)
geneRtrack <-GeneReviews_UCSC(gen,chrom,start,end)

listgviz <- list(genetrack,snptrack,strutrack,clinVariant,

clinCNV,gwastrack,geneRtrack)

comet(config.file=configfile, mydata.file=myinfofile, mydata.type="file",

cormatrix.file=mycorrelation, cormatrix.type="listfile",

fontsize.gviz =12,

tracks.gviz=listgviz, verbose=FALSE, print.image=FALSE,

disp.pvalueplot=FALSE)

22

The coMET User Guide

Figure 4: Plot with comet function without pvalue plot.

23

Example a−DMR in CYP1B1 in Adipose tissueChromosome 238290160 bp38303219 bp cg02486145 cg06202585 cg19753864 cg23838231 cg09440493 cg21715189 cg12802310 cg08620474 cg16248783 cg09456297 cg03648789 cg09130556 cg07301433 cg26036993 cg08761102 cg22488859 cg23549225 cg06861880 cg01936270 cg07380506 cg07057636 cg01834566 cg14957547 cg25856383 cg07078841 cg16439198 cg03890222 cg01410359 cg09799983 cg20254225 cg06264984 cg00565882 cg20408276 cg02162897 cg14407177 cg11656478 cg22248750 cg02486145 cg06202585 cg19753864 cg23838231 cg09440493 cg21715189 cg12802310 cg08620474 cg16248783 cg09456297 cg03648789 cg09130556 cg07301433 cg26036993 cg08761102 cg22488859 cg23549225 cg06861880 cg01936270 cg07380506 cg07057636 cg01834566 cg14957547 cg25856383 cg07078841 cg16439198 cg03890222 cg01410359 cg09799983 cg20254225 cg06264984 cg00565882 cg20408276 cg02162897 cg14407177 cg11656478 cg22248750Correlation Matrix Map Type: SpearmanPhysical Distance: 13.1 kb10.60.2−0.2−0.6−1RMDN2CYP1B1CYP1B1−AS1RMDN2−AS1The coMET User Guide

6.3

coMET plot: Manhattan plot and anonation track

It is possible to visualise only The Manhattan plot and the annotation tracks. In this
case, we need to use the option disp.cormatrixmap = FALSE, for example see Figure
5.

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
configfile <- file.path(extdata, "config_cyp1b1_zoom_4nomatrix.txt")
myinfofile <- file.path(extdata, "cyp1b1_infofile.txt")
mycorrelation <- file.path(extdata, "cyp1b1_res37_rawMatrix.txt")

chrom <- "chr2"

start <- 38290160

end <- 38303219

gen <- "hg19"
strand <- "*"

genetrack <-genes_ENSEMBL(gen,chrom,start,end,showId=FALSE)
snptrack <- snpBiomart_ENSEMBL(gen, chrom, start, end,

strutrack <- structureBiomart_ENSEMBL(chrom, start, end,

dataset="hsapiens_snp_som",showId=FALSE)

strand, dataset="hsapiens_structvar_som")

clinVariant<-ClinVarMain_UCSC(gen,chrom,start,end)
clinCNV<-ClinVarCnv_UCSC(gen,chrom,start,end)
gwastrack <-GWAScatalog_UCSC(gen,chrom,start,end)
geneRtrack <-GeneReviews_UCSC(gen,chrom,start,end)

listgviz <- list(genetrack,snptrack,strutrack,clinVariant,

clinCNV,gwastrack,geneRtrack)

comet(config.file=configfile, mydata.file=myinfofile, mydata.type="file",

cormatrix.file=mycorrelation, cormatrix.type="listfile",

fontsize.gviz =12, font.factor=3,

tracks.gviz=listgviz, verbose=FALSE, print.image=FALSE)

24

The coMET User Guide

Figure 5: Plot with comet function without the correlation matrix.

25

Example a−DMR in CYP1B1 in Adipose tissueChromosome 238290160 bp38303219 bp01234567−log10(P−value)Physical Distance: 13.1 kbllllllllllllllcg02162897lCpGlRMDN2CYP1B1CYP1B1−AS1RMDN2−AS1The coMET User Guide

7

Extract the signiﬁcant correlations between omic
features

coMET can help to visualise the correlations between omic features with EWAS
results and other omic data.
In addition, a function comet.list can extract the
signiﬁcant correlations according the method (options: cormatrix.method) and sig-
niﬁcance level (option: cormatrix.sig.level).

The output ﬁle has 7 columns:

1. the name of the ﬁrst omic feature

2. the name of the second omic feature

3. the correlation between the omic features

4. the alpha/2 lower value (e.g. 0.05 (option cormatrix.conf.level))

5. the alpha/2 upper value (e.g. 0.05 (option cormatrix.conf.level))

6. the pvalue

7. the pvalue adjusted with the method selected (e.g. Benjamin and Hochberg)

(option cormatrix.adjust)

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
mycorrelation <- file.path(extdata, "cyp1b1_res37_rawMatrix.txt")
myoutput <- file.path(extdata, "cyp1b1_res37_cormatrix_list_BH05.txt")

comet.list(cormatrix.file=mycorrelation,cormatrix.method = "spearman",

cormatrix.format= "raw", cormatrix.conf.level=0.05,

cormatrix.sig.level= 0.05, cormatrix.adjust="BH",

cormatrix.type = "listfile", cormatrix.output=myoutput,

verbose=FALSE)

listcorr <- read.csv(myoutput, header = TRUE,

sep = "\t", quote = "")

dim(listcorr)

## [1] 336

7

head(listcorr)

##

omicFeature1 omicFeature2 correlation

lowerCI

upperCI

pvalue

## 1

## 2

## 3

## 4

## 5

cg22248750

cg14407177

0.2153743

0.11294792

0.3132713 4.975020e-05

cg22248750

cg02162897

0.2761912

0.17632357

0.3704308 1.575519e-07

cg22248750

cg20408276

0.2807258

0.18108231

0.3746643 9.649818e-08

cg22248750

cg00565882

0.2345897

0.13288218

0.3314082 9.478992e-06

cg22248750

cg06264984

0.1793832

0.07583111

0.2791072 7.613440e-04

26

The coMET User Guide

## 6

cg22248750

cg09799983

-0.2979454 -0.39070492 -0.1991959 1.382644e-08

##

pvalue.adjusted

## 1

## 2

## 3

## 4

## 5

## 6

2.029592e-04

1.178984e-06

7.472999e-07

4.477311e-05

2.414548e-03

1.261426e-07

27

The coMET User Guide

8

Annotation tracks

Annotation tracks can be created with Gviz using four diﬀerent functions:

1. UcscTrack. Diﬀerent UCSC tracks can be selected for visualisation from the ta-
ble Browser of UCSC http://genome-euro.ucsc.edu/cgi-bin/hgTables?hgsid=
202842745_Dlvit14QO0G6ZPpLoEVABG8aqfrm&clade=mammal&org=Human&
db=hg19&hgta_group=varRep&hgta_track=cpgIslandExt&hgta_table=0&hgta_
regionType=genome&position=chr6%3A32726553\discretionary{-}{}{}32727053&
hgta_outputType=primaryTable&hgta_outFileName=

2. BiomartGeneRegionTrack. A connection should be established to the Biomart

database to visualise the genetic elements.

3. DataTrack. This allows the visualisation of numerical data.

4. AnnotationTrack. This allows the visualisation of any annotation data.

For more information consult the user guide for Gviz.

8.1

Ensembl

The Ensembl project [2] produces genome databases for vertebrates and other eukary-
otic species, and makes this information freely available online http://www.ensembl.
org/index.html. A set of wrap R functions were created to extract data from Ensembl
BioMart for human genome using Ensembl REST [3], but they can be extended to
other genomes. You can ask help to tiphaine.martin@mssm.edu.

This is the list of R functions created in coMET to visualise ENSEMBL data. Below
described the colors of tracks and speciﬁc characteristics of some annotation tracks.

• bindingMotifsBiomart_ENSEBML : Visualise the binding motifs in the genomic

region of interest

• genes_ENSEBML : Visualise the genes from ENCODE in the genomic region of

interest

• genesName_ENSEBML : Visualise the name of genes from ENCODE in the ge-

nomic region of interest

• interestGenes_ENSEBML : Visualise the genes from ENCODE in the genomic

region of interest with a speciﬁc color for genes of interest

• interestTranscript_ENSEBML : Visualise the transcripts from ENCODE in the

genomic region of interest with a speciﬁc color for exons of interest

• miRNATargetRegionsBiomart_ENSEBML : Visualise the miRNA target regions in

the genomic region of interest

• otherRegulatoryRegionsBiomart_ENSEBML : Visualise the other regulatory re-

gions in the genomic region of interest

28

The coMET User Guide

• regulationBiomart_ENSEBML (obselet function): Visualise the other regulatory

regions in the genomic region of interest

• regulatoryEvidenceBiomart_ENSEBML : Visualise the regulatory evidence re-

gions in the genomic region of interest

• regulatoryFeaturesBiomart_ENSEBML : Visualise the regulatory features re-

gions in the genomic region of interest

• regulatorySegmentsBiomart_ENSEBML : Visualise the regulatory segment re-

gions in the genomic region of interest. Warning: no more available

• snpBiomart_ENSEBML : Visualise the SNPs in the genomic region of interest

• structureBiomart_ENSEBML : Visualise the structural variations in the genomic

region of interest

• transcript_ENSEBML : Visualise the transcripts in the genomic region of interest

Below described the colors of tracks and speciﬁc characteristics of some annotation
tracks.

8.1.1 Genes and transcripts from Ensembl

The color of the genetic elements is deﬁned by the R package Gviz.

It is possible to chagne the colour of some exsons by using the function interest
GenesENSEMBL or interestTranscriptENSEMBL. The elements and the colours to be
displayed must be given as list. An example is given below:

gen <- "hg38"

chr <- "chr15"

start <- 75011669

end <- 75019876

interestfeatures <- rbind(c("75011883","75013394","bad"),

c("75013932","75014410","good"))

interestcolor <- list("bad"="red", "good"="green")

interestgenesENSMBLtrack<-interestGenes_ENSEMBL(gen,chr,start,end,interestfeatures,

interestcolor,showId=TRUE)

plotTracks(interestgenesENSMBLtrack, from=start, to=end)

8.1.2 Regulatory elements from Ensembl

This function is now obselet in coMET as Ensembl have restructured their databases
due to the new version of the genome GRCh38. The same data is now available by
using the function RegulatoryFeaturesBiomart.

29

The coMET User Guide

Figure 6: Plot genes with different colors according user’s choice.

The colors were :

30

genes ENSEMBL of interestCYP1A1The coMET User Guide

8.1.3

structureBiomart from Ensembl

Listed below are the colours for somatic structural variation and structural variation.

8.1.4 miRNA Target Regions from Ensembl

The colour of the miRNA target regions is set to Plum4 (hex code: #8B668B)

31

The coMET User Guide

8.1.5 Binding Motif Biomart from Ensembl

Listed on the next page are the colours used for the diﬀerent types of binding mo-
tifs. The frequency shown is that found in GRCh38 (hg38). Motifs with red text are
found only in GRCh37 (hg19), motifs with blue text are found only in GRCh38 (hg38)

32

The coMET User Guide

8.1.6 Other Regulatory Regions Biomart from Ensembl

Listed below are the colours used for the diﬀerent types of regulatory regions. The
frequency shown is that found in GRCh38 (hg38).

8.1.7 Regulatory Features Biomart from Ensembl

Listed below are the colours used for the diﬀerent types of regulatory features The
frequency shown is that found in GRCh38 (hg38).

8.1.8 Other Regulatory Segments Biomart from Ensembl

Warning: (No more available) Listed below are the colours used for the diﬀerent
types of regulatory segments. The frequency shown is that found in GRCh38 (hg38).
Segments with red text are found only in GRCh37 (hg19)

33

The coMET User Guide

8.1.9 Regulatory Evidence Elements Biomart from Ensembl

Listed on the next 3 pages are the colours used for the diﬀerent types of regulatory
evidence elements. The frequency shown is that found in GRCh37 (hg19). At the
current time this track has not been optimised for GRCh38 (hg38) meaning any
elements found exclusively in GRCh38 do not have an assigned colour and will be
displayed in the default track colour of Gviz.

34

The coMET User Guide

35

The coMET User Guide

36

The coMET User Guide

37

The coMET User Guide

8.2

UCSC

the UCSC Genome Browser [4] website http://genome-euro.ucsc.edu/ contains the
reference sequence and working draft assemblies for a large collection of genomes.

This is the list of R wrapping functions of some tracks found in UCSC genome
browser. Below described the colors of tracks and speciﬁc characteristics of some
annotation tracks.

• chromatinHMMAll_UCSC : Visualise the chromHMM Broad found in UCSC

genome browser of all tissues in the genomic region of interest.

• chromatinHMMOne_UCSC : Visualise the chromHMM Broad found in UCSC
genome browser of the tissue of interest in the genomic region of interest.

• ClinVarCnv_UCSC : Visualise clinical CNVs found in ClinVar tracks of UCSC

genome browser in the genomic region of interest.

• ClinVarMain_UCSC : Visualise clinical SNPs found in ClinVar tracks of UCSC

genome browser in the genomic region of interest.

• CoreillCNV_UCSC : Visualise CNV found in Coreil tracks of UCSC genome

browser in the genomic region of interest.

• COSMIC_UCSC : Visualise SNPs found in COSMIC tracks of UCSC genome
browser in the genomic region of interest.Warning: We could not more access
to COSMIC data from UCSC genome browser, people needs to extract data
from COSMIC directly.

• cpgIslands_UCSC : Visualise CpG Island found in CpGIsland tracks of UCSC

genome browser in the genomic region of interest.

• DNAse_UCSC : Visualise clinical CNV found in ClinVar tracks of UCSC genome

browser in the genomic region of interest.

• GAD_UCSC : Visualise genes found in GAD tracks of UCSC genome browser in

the genomic region of interest.

• gcContent_UCSC : Visualise GC content found in UCSC genome browser in the

genomic region of interest.

• GeneReviews_UCSC : Visualise clinical genes found in GeneReviews tracks of

UCSC genome browser in the genomic region of interest.

• GWAScatalog_UCSC : Visualise SNPS found in GWAS catalog tracks of UCSC

genome browser in the genomic region of interest.

• HistoneAll_UCSC : Visualise histone patterns found in UCSC genome browser

of all tissues in the genomic region of interest.

• HistoneOne_UCSC : Visualise histone patterns found in UCSC genome browser

of one tissue of interest in the genomic region of interest.

38

The coMET User Guide

• ISCA_UCSC (obselete) : Visualise clinical CNV found in UCSC genome browser

in the genomic region of interest.

• knownGenes_UCSC : Visualise known genes found in UCSC genome browser in

the genomic region of interest.

• refGenes_UCSC : Visualise reference genes found in UCSC genome browser in

the genomic region of interest.

• repeatMasker_UCSC : Visualise repeat elements found in UCSC genome browser

in the genomic region of interest.

• segmentalDups_UCSC : Visualise segmental duplcations found in UCSC genome

browser in the genomic region of interest.

• snpLocations_UCSC : Visualise SNPs found in UCSC genome browser in the

genomic region of interest.

• xenorefGenes_UCSC : Visualise xeno reference genes found in UCSC genome

browser in the genomic region of interest.

8.2.1 ChromHMM from UCSC

For this function there are two possible colour schemes to choose from. The selection
between schemes is made with the variable colour. The default scheme is coMET ,
the colours chosen have been selected so that diﬀerent elements can be easily distin-
guished. The second scheme is UCSC, these are the set colours used by UCSC, in
certain plots it may be diﬃcult to distinguish elements apart. These UCSC colours
are correct at the time this document was writtern however if these change in the
future and this is not reﬂected here please contact us.

39

The coMET User Guide

the colours used in both schemes are listed below:

40

The coMET User Guide

8.2.2

ISCA track (obselete database)

International Standards of Cytogenomic Arrays Consortium deﬁned a set of pheno-
types for CNVs. Diﬀerent colours are deﬁned to represent them. This database is
not more accessible from UCSC (from September 2015).

8.2.3 Other potential data from UCSC

You can access to other data via UCSC track hub [5] :

• Other tracks and table accessible to UCSC genome browser https://genome.

ucsc.edu/cgi-bin/hgTables?hgsid=444062899_lxuSrw4J9exVt1OafMuY4LDbVs1F&
clade=mammal&org=Human&db=hg19&hgta_group=allTracks&hgta_track=
knownGene&hgta_table=0&hgta_regionType=genome&position=chr21%3A33031597-33041570&
hgta_outputType=primaryTable&hgta_outFileName=

• Track HUB of UCSC genome browser https://genome-euro.ucsc.edu/cgi-bin/

hgHubConnect?hubUrl=http%3A%2F%2Ffantom.gsc.riken.jp%2F5%2Fdatahub%
2Fhub.txt&hgHubConnect.remakeTrackHub=on&redirect=manual&source=genome.
ucsc.edu

and use DataTrack or AnnotationTrack or UCSCTrack of Gviz to visuaslise them.

41

The coMET User Guide

8.3

NIH Roadmap epigenomics project

NIH Roadmap epigenomics projects http://www.roadmapepigenomics.org/ [6] aims
to produce a public resource of human epigenomic data to catalyze basic biology
and disease-oriented research. The project has generated high-quality, genome-wide
maps of several key histone modiﬁcations, chromatin accessibility, DNA methylation
and mRNA expression across 100s of human cell types and tissues (111 consolidated
epigenomes from the NIH Roadmap Epigenomics Project and 16 epigenomes from
The Encyclopedia of DNA Elements (ENCODE) project).

Release 9 of the compendium contains uniformly pre-processed and mapped data
from multiple proﬁling experiments (technical and biological replicates from multiple
individuals and/or datasets from multiple centers) spanning 183 biological samples
and 127 consolidated epigenomes.

More information on each type data are on the site of NIH Roadmap Epigenomics Pro-
gram http://egg2.wustl.edu/roadmap/web_portal/index.html and the meta-data on
diﬀerent tissues (more for correspondance between Epigenome ID (EID) and the stan-
dartized epigenome name), you need to look at this spreadsheet https://docs.google.
com/spreadsheets/d/1yikGx4MsO9Ei36b64yOy9Vb6oPC5IBGlFbYEt-N6gOM/edit#
gid=15

The current data are done on Release 9. The data are mapped on the reference
genome hg19. Below described the colors of tracks and speciﬁc characteristics of
some annotation tracks.

• chromHMM_RoadMap : Visualisation of chromatin states deﬁned in NIH Roadmap

project

• dgfootprints_RoadMap: Visualisation of DNA motif positional bias in digital

genomic Footprinting Sites

• DNaseI_RoadMap : Visualisation of promoter/enhancer regions

8.3.1 Chromatin state

There are 3 chromatin states deﬁned in NIH Roadmap project (15 states, 18 states
and 25 states). For 18 and 25 states, there are the choice beteen 2 set of colors.
First, the colors deﬁned by NIH Roadmap and second, the colors deﬁned by us for a
better diﬀerentiation between states.

you can use chromHMM_RoadMap to visualise chromatin state in :

• 15-states, go to http://egg2.wustl.edu/roadmap/data/byFileType/chromhmmSegmentations/

ChmmModels/coreMarks/jointModel/ﬁnal/ and select the MNEMONICS BED
FILES, where bins with the same state label are merged and a label is assigned
to the entire merged regions, related to your tissue of interest.

42

The coMET User Guide

• 18-states, go to http://egg2.wustl.edu/roadmap/data/byFileType/chromhmmSegmentations/

ChmmModels/core_K27ac/jointModel/ﬁnal/ and select the MNEMONICS BED
FILES, where bins with the same state label are merged and a label is assigned
to the entire merged regions, related to your tissue of interest .

• 25-states, go to http://egg2.wustl.edu/roadmap/data/byFileType/chromhmmSegmentations/

ChmmModels/imputed12marks/jointModel/ﬁnal/ and select your tissue of in-
terest.

You can have more information about these data from NIH Roadmap website http:
//egg2.wustl.edu/roadmap/web_portal/chr_state_learning.html#core_15state.

You can visualise this bed using the function chromHMM_RoadMap and you can choice
the color between roadmap15, roadmap18, comet18, roadmap25 and comet25.

Below you can ﬁnd the color code for each state depending if 15-,18- or 25-state

Listed below are the colours used for the diﬀerent elements contained in NIH Roadmap
data with 15 states.

43

The coMET User Guide

Listed below are the colours used for the diﬀerent elements contained in NIH Roadmap
data with 18 states with NIH Roadmap colors.

Listed below are the colours used for the diﬀerent elements contained in NIH Roadmap
data with 18 states with coMET colors.

44

The coMET User Guide

Listed below are the colours used for the diﬀerent elements contained in NIH Roadmap
data with 25 states with NIH Roadmap colors.

45

The coMET User Guide

Listed below are the colours used for the diﬀerent elements contained in NIH Roadmap
data with 25 states with coMET colors.

8.3.2 DNA Motif Positional Bias in Digital Genomic Footprinting Sites

The Digital Genomic Footprinting (DGF) sites in each cell type can be visualised
using the function dgfootprints_RoadMap using the ﬁle of DNase/DGF Footprint
calls http://egg2.wustl.edu/roadmap/data/byDataType/dgfootprints/

8.3.3 DNaseI-accessible regulatory regions

Using the core 15-state chromatin state model across any of the 111 NIH Roadmap
reference epigenomes, and focusing on states TssA, TssAFlnk, and TssBiv for promot-
ers, and EnhG, Enh, and EnhBiv for enhancers, and state BivFlnk (ﬂanking bivalent
Enh/Tss) for ambiguous regions, 3 set of data were constructed. The data can be
visualised using the function DNaseI_RoadMap with the good name of data (variable
featureDisplay) like in Fig. 2:

46

The coMET User Guide

• for promoter regions the ﬁle of tissue of interest http://egg2.wustl.edu/roadmap/
data/byDataType/dnase/BED_ﬁles_prom/ or RData ﬁles containing matrice
of chromatin state call for promoter. Thus, user can select for diﬀerent tissues.

• for enhancer regions the ﬁle of tissue of interest http://egg2.wustl.edu/roadmap/

data/byDataType/dnase/BED_ﬁles_enh/

• for dyadic promoter/enhancer region the ﬁle of tissue of interest http://egg2.

wustl.edu/roadmap/data/byDataType/dnase/BED_ﬁles_dyadic/

chr<-"chr2"

start <- 38290160

end <- 38303219

gen<-"hg19"

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
prombedFilePath <- file.path(extdata, "/RoadMap/regions_prom_E001.bed")

promRMtrack<- DNaseI_RoadMap(gen,chr,start, end, prombedFilePath,

featureDisplay='promotor', type_stacking="squish")

enhbedFilePath <- file.path(extdata, "/RoadMap/regions_enh_E001.bed")

enhRMtrack<- DNaseI_RoadMap(gen,chr,start, end, enhbedFilePath,

featureDisplay='enhancer', type_stacking="squish")

dyabedFilePath <- file.path(extdata, "/RoadMap/regions_dyadic_E001.bed")

dyaRMtrack<- DNaseI_RoadMap(gen,chr,start, end, dyabedFilePath,

featureDisplay='dyadic', type_stacking="squish")

genetrack <-genes_ENSEMBL(gen,chr,start,end,showId=TRUE)

listRoadMap <- list(genetrack,promRMtrack,enhRMtrack,dyaRMtrack)

plotTracks(listRoadMap, chromosome=chr,from=start,to=end)

8.3.4 Processed data and Imputed data

BED and BigWIG ﬁle can be visualised with DataTrack objects from ﬁles of Gviz pack-
age. The data are in http://www.genboree.org/EdaccData/Release-9/sample-experiment/
and http://www.genboree.org/EdaccData/Release-9/experiment-sample/ or go to
http://egg2.wustl.edu/roadmap/web_portal/processed_data.html for processed data
or to http://egg2.wustl.edu/roadmap/web_portal/imputed.html#imp_sig for im-
puted data.

47

The coMET User Guide

Figure 7: Plot of NIH Roadmap data.

48

genes ENSEMBLRMDN2CYP1B1CYP1B1−AS1RMDN2−AS1promotorRoadMap12enhancerRoadMap12dyadicRoadMap1The coMET User Guide

8.4

ENCODE and GENCODE data

The ENCODE (Encyclopedia of DNA Elements) Consortium is an international col-
laboration of research groups funded by the National Human Genome Research In-
stitute (NHGRI) https://www.encodeproject.org/. The goal of ENCODE is to build
a comprehensive parts list of functional elements in the human genome, including el-
ements that act at the protein and RNA levels, and regulatory elements that control
cells and circumstances in which a gene is active.

Genes and transcripts of GENCODE are accessible from ENSEMBL biomart or can
be visualised wtith GeneRegionTrack of Gviz. Other data are in BED or BAM format
that can be visualised with Gviz tracks.

#Genes from GENCODE

chr<-3

start <- 132239976

end <- 132541303

gen<-"hg19"

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
gtfFilePath <- file.path(extdata, "/GTEX/gencode.v19.genes.patched_contigs.gtf")
options(ucscChromosomeNames=FALSE)

grtrack <- GeneRegionTrack(range=gtfFilePath ,chromosome = chr, start= start,

end= end, name = "Gencode V19",

collapseTranscripts=TRUE, showId=TRUE,shape="arrow")

plotTracks(grtrack, chromosome=chr,from=start,to=end)

Figure 8: Plot of genes deﬁned by GeneCode.

49

Gencode V19UBA5NPHP3ACKR4DNAJC13ACAD11NPHP3−AS1HSPA8P19The coMET User Guide

8.4.1 Predicting motifs and active regulators

You can browse known and discovered motifs for the ENCODE TF ChIP-seq datasets.
The position of motifs can be visualised using the function ChIPTF_ENCODE using one
of ﬁles from http://compbio.mit.edu/encode-motifs/ [7] such as http://compbio.
mit.edu/encode-motifs/matches.txt.gz

#TF Chip-seq data

gen <- "hg19"

chr<-"chr1"

start <- 1000

end <- 329000

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
bedFilePath <- file.path(extdata, "ENCODE/motifs1000_matches_ENCODE.txt")
motif_color <- file.path(extdata, "ENCODE/TFmotifs_colors.csv")

chipTFtrack <- ChIPTF_ENCODE(gen,chr,start, end, bedFilePath,

featureDisplay=c("AHR::ARNT::HIF1A_1",

motif_color,type_stacking="squish",showId=TRUE)

"AIRE_1","AIRE_2","AHR::ARNT_1"),

plotTracks(chipTFtrack, chromosome=chr,from=start,to=end)

50

The coMET User Guide

Figure 9: Plot ENCODE TF ChIP-seq datasets of ENCODE.

51

TF motifs ENCODEAHR::ARNT::HIF1A_1AHR::ARNT_1AIRE_1AIRE_2The coMET User Guide

8.5

GTEx Portal

The Genotype-Tissue Expression (GTEx) [8] project aims to provide to the scientiﬁc
community a resource with which to study human gene expression and regulation
and its relationship to genetic variation. By analyzing global RNA expression within
individual tissues and treating the expression levels of genes as quantitative traits,
variations in gene expression that are highly correlated with genetic variation can be
identiﬁed as expression quantitative trait loci, or eQTLs. The data are accessible
via http://www.gtexportal.org/. A set of data are downloadable from http://www.
gtexportal.org/home/datasets2 (need to have login).

The data were mapped on the reference genome hg19. Below described the colors
of tracks and speciﬁc characteristics of some annotation tracks.

2 functions were created to visualise data from GTEx version 6:

1. eQTL_GTEx visualise eGene and signiﬁcant snp-gene associations based on per-
mutations in a tissue speciﬁc. The name of folder in GTEx version 6 is
GTEx_Analysis_V6_eQTLs.tar.gz.

2. geneExpression_GTEx (need to update) visualise fully processed, normalized
and ﬁltered gene expression data, which was used as input into Matrix eQTL
for eQTL discovery in a tissue speciﬁc. The name of folder in GTEx version 6 is
GTEx_Analysis_V6_eQTLInputFiles_geneLevelNormalizedExpression.tar.gz

One function from Gviz:

1. GeneRegionTrack can visualise gene level model based on the GENCODE tran-
script model (cf. example below. Isoforms have been collapsed to single genes.
The name of ﬁle in GTEx version 6 is gencode.v19.genes.patched_contigs.gtf.

## eQTL data

chr<-"chr3"

start <- 132239976

end <- 132541303

gen<-"hg19"

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
bedFilePath <- file.path(extdata, "/GTEX/eQTL_Uterus_Analysis_extract100.snpgenes")

eGTex<- eQTL_GTEx(gen,chr, start, end, bedFilePath, featureDisplay = 'all',
showId=TRUE, type_stacking="squish", just_group="left" )

eGTex_SNP<- eQTL_GTEx(gen,chr, start, end, bedFilePath,

featureDisplay = 'SNP', showId=FALSE,
type_stacking="dense", just_group="left")

#Genes from

52

The coMET User Guide

gtfFilePath <- file.path(extdata, "/GTEX/gencode.v19.genes.patched_contigs.gtf")
options(ucscChromosomeNames=FALSE)

grtrack <- GeneRegionTrack(genome="hg19",range=gtfFilePath ,chromosome = chr,

start= start, end= end, name = "Gencode V19",

collapseTranscripts=TRUE, showId=TRUE,shape="arrow")

eGTexTracklist <- list(grtrack,eGTexTrackSNP)

plotTracks(eGTexTracklist, chromosome=chr,from=start,to=end)

Figure 10: Plot eQTL from GTex.

2 other functions were created to visualise supplement data from GTEx version 3

1. psiQTL_GTEx visualise results from the protein truncating variants QTL (psiQTL)
analysis for mine main tissues, plus brain, plus multi-tissue that averages the
exons where data for three or more tissues is available. The name of ﬁle in
GTEX version 3 is gtex_psiqtls.zip.

2. imprintedGenes_GTEx visuaslise gene imprinting genes in diﬀerent tissues [9]
via url http://www.gtexportal.org/home/imprintingPage. There are 33 tissues
and 5 classiﬁcation

53

eQTL GTEX3_132424172_C_G_b37_NPHP33_132429522_C_A_b37_NPHP33_132430804_T_C_b37_NPHP33_132431492_C_A_b37_NPHP33_132431713_C_T_b37_NPHP33_132432857_T_C_b37_NPHP33_132433414_AT_A_b37_NPHP33_132435532_C_T_b37_NPHP33_132435823_C_T_b37_NPHP33_132435871_A_G_b37_NPHP33_132436324_G_T_b37_NPHP33_132436513_G_A_b37_NPHP33_132436967_A_G_b37_NPHP33_132437390_C_T_b37_NPHP33_132438099_C_T_b37_NPHP33_132438301_T_C_b37_NPHP33_132438719_T_C_b37_NPHP33_132441268_T_C_b37_NPHP33_132441582_G_C_b37_NPHP33_132441639_G_C_b37_NPHP33_132441781_A_G_b37_NPHP33_132441807_G_A_b37_NPHP33_132442191_G_A_b37_NPHP33_132443661_G_A_b37_NPHP33_132446264_TA_T_b37_NPHP33_132446336_G_T_b37_NPHP33_132447104_G_A_b37_NPHP33_132447257_A_T_b37_NPHP3The coMET User Guide

### psiQTL

chr<-"chr13"

start <- 52713837

end <- 52715894

gen<-"hg19"

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
psiQTLFilePath <- file.path(extdata, "/GTEX/psiQTL_Assoc-total.AdiposeTissue.txt")

psiGTex<- psiQTL_GTEx(gen,chr,start, end, psiQTLFilePath, featureDisplay = 'all',

showId=TRUE, type_stacking="squish",just_group="above" )

genetrack <-genes_ENSEMBL(gen,chr,start,end,showId=TRUE)

psiTrack <- list(genetrack,psiGTex)

plotTracks(psiTrack, chromosome=chr,from=start,to=end)

Figure 11: Plot psiQTL from GTex.

data(imprintedGenesGTEx)

as.character(unique(imprintedGenesGTEx$Tissue.Name))

## [1] "Pancreas"

## [3] "Pituitary"
## [5] "Cells_EBV-transformed_lymphocytes" "Thyroid"
## [7] "Adipose_Subcutaneous"
## [9] "Skin_Sun_Exposed_Lower_leg"

"Artery_Tibial"
"Skin_Not_Sun_Exposed_Suprapubic"

"Whole_Blood"
"Lung"

54

genesENSEMBLNEK3psiQTL GTEXchr13:52715894:I_NEK3rs2408609_NEK3rs2897976_NEK3rs66849828_NEK3rs73184374_NEK3rs79960306_NEK3rs9535883_NEK3The coMET User Guide

## [11] "Brain"
## [13] "Breast_Mammary_Tissue"
## [15] "Adrenal_Gland"
## [17] "Prostate"
## [19] "Heart_Left_Ventricle"
## [21] "Uterus"

## [23] "Vagina"
## [25] "Adipose_Visceral_Omentum"
## [27] "Esophagus_Muscularis"
## [29] "Cells_Transformed_fibroblasts"
## [31] "Kidney_Cortex"
## [33] "Artery_Aorta"

"Muscle_Skeletal"
"Nerve_Tibial"
"Colon_Transverse"
"Artery_Coronary"
"Heart_Atrial_Appendage"
"Liver"

"Testis"
"Fallopian_Tube"
"Ovary"
"Esophagus_Mucosa"
"Stomach"

as.character(unique(imprintedGenesGTEx$Classification))

## [1] "consistent with biallelic"

"imprinted"

"NC"

## [4] "consistent with imprinting" "biallelic"

### inprinted genes

chr<- "chr1"

start <- 7895752

end <- 7914572

gen<-"hg19"

genesTrack <- genes_ENSEMBL(gen,chr,start,end,showId=TRUE)

allIG <- imprintedGenes_GTEx(gen,chr,start, end, tissues="all",

classification="imprinted",showId=TRUE)

allimprintedIG <- imprintedGenes_GTEx(gen, chr,start, end, tissues="all",

classification="imprinted",showId=TRUE)

StomachIG <-imprintedGenes_GTEx(gen,chr,start, end, tissues="Stomach",

classification="all",showId=TRUE)

PancreasIG <- imprintedGenes_GTEx(gen,chr,start, end,
tissues="Pancreas",

PancreasimprintedIG <- imprintedGenes_GTEx(gen,chr,start, end, tissues="Pancreas",
classification="imprinted",showId=TRUE)

classification="all",showId=TRUE)

plotTracks(list(genesTrack, allIG, allimprintedIG,

StomachIG,PancreasIG,PancreasimprintedIG),

chromosome=chr, from=start, to=end)

55

The coMET User Guide

Figure 12: Plot imprinted genes from GTex.

56

genes(ENSEMBL)PER3UTS2ImprintedgenesGTExUTS2ImprintedgenesGTExUTS2ImprintedgenesGTExUTS2The coMET User Guide

8.6

Hi-C data

Below are examples of Hi-C data available for diﬀerent tissues.

8.6.1 Hi-C data at 1kb resolution at Lieberman Aiden lab

They [10] used in situ Hi-C to probe the three-dimensional architecture of genomes,
constructing haploid and diploid maps of nine cell types. The densest, in human
lymphoblastoid cells, contains 4.9 billion contacts, achieving 1-kilobase resolution.The
data were mapped on hg19 reference genome.

You can download intrachromosomal matrice from http://www.ncbi.nlm.nih.gov/
geo/query/acc.cgi?acc=GSE63525 for the cell-type of interest.

library('corrplot')

#Hi-C data

gen <- "hg19"

chr<-"chr1"

start <- 5000000

end <- 9000000

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
bedFilePath <- file.path(extdata, "HiC/chr1_1mb.RAWobserved")

matrix_HiC <- HiCdata2matrix(chr,start, end, bedFilePath)
cor_matrix_HiC <- cor(matrix_HiC)
diag(cor_matrix_HiC)<-1
corrplot(cor_matrix_HiC, method = "circle")

You can quick visualise this data using this HiC-interaction tool http://promoter.bx.
psu.edu/hi-c/view.php?species=human&assembly=hg19&source=inside&tissue=GM12878&
resolution=1&c_url=&gene=CTXN1&sessionID=

8.6.2 Hi-C Data Browser

You can download heatmap of your region of interest from two cell-line GM06690 (im-
mortalized lymphoblast) or K562 (leukemia) using their website http://hic.umassmed.
edu/heatmap/heatmap.php. This data was produced by [11]. The region that you
want to visualise with this data need to large more than either 100Kb or 1Mb as
Heatmaps were generated by dividing the chromosome up into 100 Kb or 1 Mb
windows. The data were mapped on hg19 reference genome.

You need to create info ﬁle to deﬁne the position of each bin composing your inter-
action matrice in using the row name of matrice as the name of bin contain the start
and end of bin.

57

The coMET User Guide

8.6.3 Hi-C project at Ren Lab

Interaction matrices for each of the four cell types analysis (mouse ES cell, mouse cor-
tex, human ES cell (H1), and IMR90 ﬁbroblasts) by Ren Lab (to cite them, you need
to select the publication for this url http://promoter.bx.psu.edu/hi-c/publications.
html) are accessible via url http://chromosome.sdsc.edu/mouse/hi-c/download.html.
The interaction matrices are created using either a 40kb bin size throughout the
genome. So the region that you want to visualise with this data need to large more
than 40Kb. The data were mapped on hg19 reference genome.

You need to :

1. Extract from the BED ﬁle that contains the locations of each of the topological

domains the region of interest

2. Extract in either raw or normalised matrice only the sub-matrice of interest

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)
info_HiC <- file.path(extdata, "Human_IMR90_Fibroblast_topological_domains.txt")
data_info_HiC <-read.csv(info_HiC, header = FALSE, sep = "\t", quote = "")

intrachr_HiC <- file.path(extdata, "Human_IMR90_Fibroblast_Normalized_Matrices.txt")
data_intrachr_HiC <- read.csv(intrachr_HiC, header = TRUE, sep = "\t", quote = "")

chr_interest <- "chr2"
start_interest <- "1"
end_interest <- "160000"
list_bins <- which(data_info_HiC[,1] == chr_interest &

data_info_HiC[,2] >= start_interest &
data_info_HiC[,2] <= end_interest )

subdata_info_Hic <- data_info_HiC[list_bins,]
subdata_intrachr_HiC <- data_intrachr_HiC[list_bins,list_bins]

58

The coMET User Guide

8.7

FANTOM5 database

FANTOM http://fantom.gsc.riken.jp/ established the FANTOM database (transcripts,
transcription factors, promoters and enhancers active,TSS) and the FANTOM full-
length cDNA clone bank, which are available worldwide for about 400 distinct cell
types. Currently, FANTOM is in version FANTOM5 phase 2 where data were mapped
on reference genome hg19 for human or mm9 for mouse [12].

To extract data

• from http://fantom.gsc.riken.jp/5/

• from http://fantom.gsc.riken.jp/data/ or http://fantom.gsc.riken.jp/views/

• from BED ﬁle used by UCSC HUB http://fantom.gsc.riken.jp/5/datahub/,
more information here http://fantom.gsc.riken.jp/5/datahub/description.html

As the data are in classical format such as BED ﬁle, you can use easily Gviz’s Data
Track function to visuaslise them. However, there are some comment lines that you
need to remove in the top of ﬁles.

2 functions were created :

• DNaseI_FANTOM helps to visualise enhancer regions deﬁned by FANTOM5

• TFBS_FANTOM helps to visualise TFBS regions deﬁned by FANTOM5

gen <- "hg19"

chr<- "chr1"

start <- 6000000

end <- 6500000

extdata <- system.file("extdata", package="coMET",mustWork=TRUE)

##Enhancer

enhFantomFile <- file.path(extdata,

enhFANTOMtrack <-DNaseI_FANTOM(gen,chr,start, end, enhFantomFile,

featureDisplay='enhancer')

"/FANTOM/human_permissive_enhancers_phase_1_and_2.bed")

### TFBS motif
AP1FantomFile <- file.path(extdata, "/FANTOM/Fantom_hg19.AP1_MA0099.2.sites.txt")
tfbsFANTOMtrack <- TFBS_FANTOM(gen,chr,start, end, AP1FantomFile)

59

The coMET User Guide

Figure 13: plot FANTOM5 data.

60

enhancer RoadMapAP1;MA0099.2TF motifFANTOM5The coMET User Guide

8.8

BLUEprint project

BLUEprint http://www.blueprint-epigenome.eu/ aims to further the understanding
of how genes are activated or repressed in both healthy and diseased human cells.
BLUEPRINT will focus on distinct types of haematopoietic cells from healthy indi-
viduals and on their malignant leukaemic counterparts.

the data were mapped on reference genome partially on GRCh37 and all on GRCh38.

As the data are in classical format such as BED ﬁle, BigWig of GTF, you can use
easily DataTrack or AnnotationTrack of Gviz to visuaslise them.

8.9

Our data

8.9.1

eQTL data

You can visualise our eQTL using eQTL function. Listed below are the colours used
for the diﬀerent elements contained in eQTL data.

8.9.2 metQTL data

You can visualise our eQTL using metQTL function.

61

The coMET User Guide

Listed below are the colours used for the diﬀerent elements contained in metQTL
data.

62

The coMET User Guide

9

coMET : Shiny web-service

9.1

How to use the coMET web-service

If you want to use coMET via its webservice, please go to http://epigen.kcl.ac.
uk/comet and select one of diﬀerent instances or direcly access one of the instances,
for example http://comet.epigen.kcl.ac.uk:3838/coMET/. We have created diﬀerent
instances of coMET because we did not have access to the pro version of Shiny . All
instances use the same version of coMET .

If you use coMET from a Shiny webservice, you do not need to install the coMET
package on your computer. The web service is user friendly and requires input ﬁles
and conﬁguration of the plot. The creation of the coMET plot can take some time
because it makes a live connection to UCSC or/and ENSEMBL for the annotation
tracks. First, the plot is created on the webpage, and then it can be saved as an
output ﬁle. For better quality plots please use the download option and the plot will
be recreated in a ﬁle in pdf or eps format.

9.2

How to install the coMET web-service

These are diﬀerent steps to install coMET on your Shiny web-service and you need
to be root to install it.

1. You need to install R, Bioconductor and the coMET package under root.

2. You need ﬁrst to install the Shiny and rmarkdown R package before Shiny

Server.

sudo su - -c "R -e \"install.packages('shiny', repos='http://cran.rstudio.com/')\""

sudo su - -c "R -e \"install.packages('rmarkdown', repos='http://cran.rstudio.com/')\""

3. You can install Shiny Server http://shiny.rstudio.com/, go to https://www.

rstudio.com/products/shiny/download-server/.

sudo apt-get install gdebi-core
wget \url{https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.4.2.786-amd64.deb}
sudo gdebi shiny-server-1.4.2.786-amd64.deb

4. Shiny Server should now be installed and running on port 3838. You should
be able to see a default welcome screen at http://your_server_ip:3838/. You
can make sure your Shiny Server is working properly by going to http://your_
server_ip:3838/sample-apps/hello/.

5. You now have a functioning Shiny Server that can host Shiny applications or
interactive documents. The conﬁguration ﬁle for Shiny Server is at /etc/shiny-
server/shiny-server.conf. By default it is conﬁgured to serve applications in the

63

The coMET User Guide

/srv/shiny-server/ directory. This means that any Shiny application that is
placed at /srv/shiny-server/app_name will be available to the public at http:
//your_server_ip:3838/app_name/.

6. In a Shiny ’s folder (e.g. /var/shiny-server/www), you can create a folder called

"COMET".

7. Following this, you can install the two coMET scripts in www of the coMET

package, within this new folder.

8. You need to change owner and permissions to access this folder. Only the user

called Shiny can access it.

mkdir -p /var/shiny-server/www/COMET

chmod -R 755 /var/shiny-server/www/COMET

chown -R shiny:shiny /var/shiny-server/www/COMET

mkdir -p /var/shiny-server/log

chmod -R 755 /var/shiny-server/log

chown -R shiny:shiny /var/shiny-server/log

9. You need now to update the conﬁguration ﬁle of Shiny (e.g. /etc/shiny-

server/shiny-server.conf).

10. You need to change owner and the permission to access this ﬁle

chmod 744 /etc/shiny-server/shiny-server.conf

chown shiny:shiny /etc/shiny-server/shiny-server.conf

11. At the end, you should restart the service Shiny via the command line:

###2.13.0.1 systemd (RedHat 7, Ubuntu 15.04+, SLES 12+)

#File to change:

/etc/systemd/system/shiny-server.service

#How to define the environment variable:

[Service]
Environment="SHINY\_LOG\_LEVEL=TRACE"

#Commands to run for the changes to take effect:

sudo systemctl stop shiny-server

sudo systemctl daemon-reload

sudo systemctl start shiny-server

###2.13.0.2 Upstart (Ubuntu 12.04 through 14.10 and RedHat 6)

#File to change:

/etc/init/shiny-server.conf

64

The coMET User Guide

#How to define the environment variable:
env SHINY\_LOG\_LEVEL=TRACE

#Commands to run for the changes to take effect:

sudo restart shiny-server

65

The coMET User Guide

Your Shiny’s conﬁguration ﬁle:

run_as shiny;
# Define a top-level server which will listen on a port

server {

# Instruct this server to listen on port 3838

listen 3838;

# Define the location available at the base URL

location / {
# Run this location in 'site_dir' mode, which hosts the entire directory
# tree at '/srv/shiny-server'
site_dir /var/shiny-server/www;

# Define where we should put the log files for this location
log_dir /var/shiny-server/log;

# Should we list the contents of a (non-Shiny-App) directory when the user

# visits the corresponding URL?
directory_index off;

app_init_timeout 3600;
app_idle_timeout 3600;

#

#

}

}

66

The coMET User Guide

10

FAQs

• I cannot see my plot after running comet or comet.web. What should I

do?
If the previous time comet or comet.web ran and error was produced it prevents
the plot from being closed. to ﬁx this use the command ’dev.oﬀ()’ as many
times as necessary.

• How do we know if my track has data? and what the data is?

Type the name of your track, visualise the track with plotTrack or read diﬀerent
parameters with str function.
g e n e t r a c k <−genesENSEMBL ( gen , chrom , s t a r t ,

end , s h o w I d=TRUE)

p l o t T r a c k s ( g e n e t r a c k )

s t r ( g e n e t r a c k )

• How do you increase the size of the font of the name of an object?

To enlarge the name of gene, as the object is Gviz object, you can use the
option from Gviz.
You can see the value of diﬀerent parameters via this command line:

g e n e t r a c k <−genesENSEMBL ( gen , chrom , s t a r t ,

end , s h o w I d=TRUE)

d i s p l a y P a r s ( g e n e t r a c k )

So if you want to enlarge the name of gene, you need to do use the option
fontsize.gviz in the comet function, an example is given below:

comet ( c o n f i g . f i l e = c o n f i g f i l e , mydata . f i l e = m y i n f o f i l e ,

mydata . f o r m a t = " f i l e " ,
c o r m a t r i x . f i l e = m y c o r r e l a t i o n ,
c o r m a t r i x . t y p e = " l i s t f i l e " ,
mydata . l a r g e . f i l e = m y l a r g e d a t a ,
mydata . l a r g e . t y p e = " l i s t f i l e " ,
t r a c k s . g v i z = l i s t G v i z , v e r b o s e = TRUE,
p r i n t . image=TRUE, f o n t s i z e . g v i z =10)

67

The coMET User Guide

• Can I make a selection of which genes or transcripts to display?

To make a selection of genes to display ﬁrst create the track like you would
if you were displaying all genes. From this track create another with only the
genes you want to display like in the example below. Please note it is not
possible to select genes based on their names unless the option to display gene
names instead of gene reference is used, in other cases it is possible to make a
selection based on the genes reference number.

g e n e T r a c k <− refGenesUCSC ( gen , chr ,
I d Ty pe ="name " ,

s h o w I d = TRUE)

s t a r t , end ,

geneTrackShow <− g e n e T r a c k [ gene ( g e n e T r a c k ) %i n% c ( "AHRR " ) ]

• How can I better understand where the comet function stopped?
Use option VERBOSE=TRUE in the function coMET or coMET.web
If this does not help resolve the issue, please to send your command line with
VERBOSE=TRUE and its error message to tiphaine.martin@mssm.edu. Do
not forget to give alsoinformation about the session by using sessionInfo().

• How do you visualise coMET plots working within a R Markdown or

knitr framework?
When coMET writes to a PDF, it is writing out to a 7X7 square area. So, it
turns out that one can ’force; the R Markdown block as well as knitr block to
also write to a 7 x 7 square PDF using option for chunck fig.height=7,fig.width=7
, as follows:

f i g . w i d t h =7, dev =' pdf ' }

f i g . h e i g h t =7,

' ' ' { r p l o t _ e x 1 , f i g . k e e p =' l a s t ' ,
comet ( c o n f i g . g i l e =c o n f i g f i l e ,
mydata . f i l e =m y i n f o f i l e , mydata_type=" f i l e " ,
c o r m a t r i x . f i l e −m y c o r r e l a t i o n ,
c o r m a t r i x . t y p e =" l i s t f i l e " ,
mydata . l a r g e . f i l e =m y e x p r e s s f i l e ,
mydata . l a r g e . t y p e =" l i s t f i l e " ,
t r a c k s . g v i z= l i s t g v i z ,
v e r b o s e=FALSE , p r i n t . image=FALSE ,
d i s p . p v a l u e p l o t=FALSE )
' ' '

68

The coMET User Guide

11

Acknowledgement

T.C.M would like to thank Bioconductor team for their help and advice in the devel-
opment of a R Bioconductor package. Moreover, T.C.M would like to thank diﬀerent
users for their feedback that help to improve this present R package.

• Prof Daniel Weeks and Dr Annie Infancia Arockiaraj to share with us how to

visualise correctly coMET plot in R Markdown code.

69

The coMET User Guide

12

SessionInfo

The following is the session info that generated this vignette:

• R version 3.5.1 Patched (2018-07-12 r74967), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8,
LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8,
LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Running under: Ubuntu 16.04.5 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so

• LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

• Base packages: base, datasets, grDevices, graphics, grid, methods, parallel,

stats, stats4, utils

• Other packages: BiocGenerics 0.28.0, GenomeInfoDb 1.18.0,

GenomicRanges 1.34.0, Gviz 1.26.0, IRanges 2.16.0, S4Vectors 0.20.0,
biomaRt 2.38.0, coMET 1.14.0, knitr 1.20, psych 1.8.4

• Loaded via a namespace (and not attached): AnnotationDbi 1.44.0,

AnnotationFilter 1.6.0, BSgenome 1.50.0, Biobase 2.42.0,
BiocManager 1.30.3, BiocParallel 1.16.0, BiocStyle 2.10.0, Biostrings 2.50.0,
DBI 1.0.0, DelayedArray 0.8.0, Formula 1.2-3, GenomeInfoDbData 1.2.0,
GenomicAlignments 1.18.0, GenomicFeatures 1.34.0, Hmisc 4.1-1,
Matrix 1.2-14, ProtGenerics 1.14.0, R6 2.3.0, RColorBrewer 1.1-2,
RCurl 1.95-4.11, RSQLite 2.1.1, Rcpp 0.12.19, Rsamtools 1.34.0,
SummarizedExperiment 1.12.0, VariantAnnotation 1.28.0, XML 3.98-1.16,
XVector 0.22.0, acepack 1.4.1, assertthat 0.2.0, backports 1.1.2,
base64enc 0.1-3, bindr 0.1.1, bindrcpp 0.2.2, biovizBase 1.30.0, bit 1.1-14,
bit64 0.9-7, bitops 1.0-6, blob 1.1.1, checkmate 1.8.5, cluster 2.0.7-1,
colorspace 1.3-2, colortools 0.1.5, compiler 3.5.1, corrplot 0.84, crayon 1.3.4,
curl 3.2, data.table 1.11.8, dichromat 2.0-0, digest 0.6.18, dplyr 0.7.7,
ensembldb 2.6.0, evaluate 0.12, foreign 0.8-71, ggplot2 3.1.0, glue 1.3.0,
gridExtra 2.3, gtable 0.2.0, hash 2.2.6, highr 0.7, hms 0.4.2, htmlTable 1.12,
htmltools 0.3.6, htmlwidgets 1.3, httr 1.3.1, lattice 0.20-35,
latticeExtra 0.6-28, lazyeval 0.2.1, magrittr 1.5, matrixStats 0.54.0,
memoise 1.1.0, mnormt 1.5-5, munsell 0.5.0, nlme 3.1-137, nnet 7.3-12,
pillar 1.3.0, pkgconﬁg 2.0.2, plyr 1.8.4, prettyunits 1.0.2, progress 1.2.0,
purrr 0.2.5, rlang 0.3.0.1, rmarkdown 1.10, rpart 4.1-13, rprojroot 1.3-2,
rstudioapi 0.8, rtracklayer 1.42.0, scales 1.0.0, splines 3.5.1, stringi 1.2.4,
stringr 1.3.1, survival 2.43-1, tibble 1.4.2, tidyselect 0.2.5, tools 3.5.1,
yaml 2.2.0, zlibbioc 1.28.0

70

The coMET User Guide

References

[1] A. Luna and K.K. Nicodemus. snp.plotter: an R-based SNP/haplotype
association and linkage disequilibrium plotting package. Bioinformatics,
23:774–6, 2007.

[2] Fiona Cunningham, M. Ridwan Amode, Daniel Barrell, Kathryn Beal, Simon
Billis, Konstantinos ad Brent, Denise Carvalho-Silva, Peter Clapham, Guy
Coates, Stephen Fitzgerald, Laurent Gil, Carlos Garcín Girón, Leo Gordon,
Thibaut Hourlier, Sarah E. Hunt, Sophie H. Janacek, Nathan Johnson,
Thomas Juettemann, Andreas K. Kähäri, Stephen Keenan, Fergal J. Martin,
Thomas Maurel, William McLaren, Daniel N. Murphy, Rishi Nag, Bert
Overduin, Anne Parker, Mateus Patricio, Emily Perry, Miguel Pignatelli,
Harpreet Singh Riat, Daniel Sheppard, Kieron Taylor, Anja Thormann,
Alessandro Vullo, Steven P. Wilder, Amonida Zadissa, Bronwen L. Aken, Ewan
Birney, Jennifer Harrow, Rhoda Kinsella, Matthieu Muﬀato, Magali Ruﬃer,
Stephen M.J. Searle, Giulietta Spudich, Stephen J. Trevanion, Andy Yates,
Daniel R. Zerbino, and Paul Flicek. Ensembl 2015. Nucleic Acids Research,
43:D662–D669, 2015. doi:10.1093/nar/gku1010.

[3] Andrew Yates, Kathryn Beal, Stephen Keenan, William McLaren, Miguel

Pignatelli, Graham R. S. Ritchie, Magali Ruﬃer, Kieron Taylor, Alessandro
Vullo, and Paul Flicek. The Ensembl REST API: Ensembl Data for Any
Language. Bioinformatics, 31:143–45, 2014.
doi:10.1093/bioinformatics/btu613.

[4] W.J. Kent, C.W. Sugnet, T.S. Furey, K.M. Roskin, T.H. Pringle, A.M. Zahler,
and D. Haussler. The human genome browser at UCSC. Genome Res.,
12:996–1006, 2002.

[5] B.J. Raney, T.R. Dreszer, G.P. Barber, H. Clawson, P.A. Fujita, T. Wang,

N. Nguyen, B. Paten, A.S. Zweig, D. Karolchik, and W.J. Kent. Track Data
Hubs enable visualization of user-deﬁned genome-wide annotations on the
UCSC Genome Browser. Genome Res., 30:1003–5, 2013.

[6] Roadmap Epigenomics Consortium, Anshul Kundaje, Wouter Meuleman, Jason

Ernst, Misha Bilenky, Angela Yen, Alireza Heravi-Moussavi, Pouya
Kheradpour, Zhizhuo Zhang, Jianrong Wang, Michael J. Ziller, Viren Amin,
John W. Whitaker, Matthew D. Schultz, Lucas D. Ward, Abhishek Sarkar,
Gerald Quon, Richard S. Sandstrom, Matthew L. Eaton, Yi-Chieh Wu,
Andreas R. Pfenning, Xinchen Wang, Melina Claussnitzer, Yaping Liu, Cristian
Coarfa, R. Alan Harris, Noam Shoresh, Charles B. Epstein, Elizabeta Gjoneska,
Danny Leung, Wei Xie, R. David Hawkins, Ryan Lister, Chibo Hong, Philippe
Gascard, Andrew J. Mungall, Richard Moore, Eric Chuah, Angela Tam,
Theresa K. Canﬁeld, R. Scott Hansen, Rajinder Kaul, Peter J. Sabo, Mukul S.
Bansal, Annaick Carles, Jesse R. Dixon, Kai-How Farh, Soheil Feizi, Rosa
Karlic, Ah-Ram Kim, Ashwinikumar Kulkarni, Daofeng Li, Rebecca Lowdon,

71

The coMET User Guide

GiNell Elliott, Tim R. Mercer, Shane J. Neph, Vitor Onuchic, Paz Polak, Nisha
Rajagopal, Pradipta Ray, Richard C. Sallari, Kyle T. Siebenthall, Nicholas A.
Sinnott-Armstrong, Michael Stevens, Robert E. Thurman, Jie Wu, Bo Zhang,
Xin Zhou, Arthur E. Beaudet, Laurie A. Boyer, Philip L. De Jager, Peggy J.
Farnham, Susan J. Fisher, David Haussler, Steven J. M. Jones, Wei Li,
Marco A. Marra, Michael T. McManus, Shamil Sunyaev, James A. Thomson,
Thea D. Tlsty, Li-Huei Tsai, Wei Wang, Robert A. Waterland, Michael Q.
Zhang, Lisa H. Chadwick, Bradley E. Bernstein, Joseph F. Costello, Joseph R.
Ecker, Martin Hirst, Alexander Meissner, Aleksandar Milosavljevic, Bing Ren,
John A. Stamatoyannopoulos, Ting Wang, Manolis Kellis, Andreas Pfenning,
Melina ClaussnitzerYaping Liu, R. Alan Harris, R. David Hawkins, R. Scott
Hansen, Nezar Abdennur, Mazhar Adli, Martin Akerman, Luis Barrera, Jessica
Antosiewicz-Bourget, Tracy Ballinger, Michael J. Barnes, Daniel Bates, Robert
J. A. Bell, David A. Bennett, Katherine Bianco, Christoph Bock, Patrick
Boyle, Jan Brinchmann, Pedro Caballero-Campo, Raymond Camahort,
Marlene J. Carrasco-Alfonso, Timothy Charnecki, Huaming Chen, Zhao Chen,
Jeﬀrey B. Cheng, Stephanie Cho, Andy Chu, Wen-Yu Chung, Chad Cowan,
Qixia Athena Deng, Vikram Deshpande, Morgan Diegel, Bo Ding, Timothy
Durham, Lorigail Echipare, Lee Edsall, David Flowers, Olga Genbacev-Krtolica,
Casey Giﬀord, Shawn Gillespie, Erika Giste, Ian A. Glass, Andreas Gnirke,
Matthew Gormley, Hongcang Gu, Junchen Gu, David A. Haﬂer, Matthew J.
Hangauer, Manoj Hariharan, Meital Hatan, Eric Haugen, Yupeng He, Shelly
Heimfeld, Sarah Herlofsen, Zhonggang Hou, Richard Humbert, Robbyn Issner,
Andrew R. Jackson, Haiyang Jia, Peng Jiang, Audra K. Johnson, Theresa
Kadlecek, Baljit Kamoh, Mirhan Kapidzic, Jim Kent, Audrey Kim, Markus
Kleinewietfeld, Sarit Klugman, Jayanth Krishnan, Samantha Kuan, Tanya
Kutyavin, Ah-Young Lee, Kristen Lee, Jian Li, Nan Li, Yan Li, Keith L. Ligon,
Shin Lin, Yiing Lin, Jie Liu, Yuxuan Liu, C. John Luckey, Yussanne P. Ma,
Cecile Maire, Alexander Marson, John S. Mattick, Michael Mayo, Michael
McMaster, Hayden Metsky, Tarjei Mikkelsen, Diane Miller, Mohammad Miri,
Eran Mukame, Raman P. Nagarajan, Fidencio Neri, Joseph Nery, Tung
Nguyen, Henriette O’Geen, Sameer Paithankar, Thalia Papayannopoulou,
Mattia Pelizzola, Patrick Plettner, Nicholas E. Propson, Sriram Raghuraman,
Brian J. Raney, Anthony Raubitschek, Alex P. Reynolds, Hunter Richards,
Kevin Riehle, Paolo Rinaudo, Joshua F. Robinson, Nicole B. Rockweiler, Evan
Rosen, Eric Rynes, Jacqueline Schein, Renee Sears, Terrence Sejnowski,
Anthony Shafer, Li Shen, Robert Shoemaker, Mahvash Sigaroudinia, Igor
Slukvin, Sandra Stehling-Sun, Ron Stewart, Sai Lakshmi Subramanian, Kran
Suknuntha, Scott Swanson, Shulan Tian, Hannah Tilden, Linus Tsai, Mark
Urich, Ian Vaughn, Jeﬀ Vierstra, Shinny Vong, Ulrich Wagner, Hao Wang, Tao
Wang, Yunfei Wang, Arthur Weiss, Holly Whitton, Andre Wildberg, Heather
Witt, Kyoung-Jae Won, Mingchao Xie, Xiaoyun Xing, Iris Xu, Zhenyu Xuan,
Zhen Ye, Chia-an Yen, Pengzhi Yu, Xian Zhang, Xiaolan Zhang, Jianxin Zhao,
Yan Zhou, Jiang Zhu, Yun Zhu, and Steven Ziegler. Integrative analysis of 111
reference human epigenomes. Nature, 518(7539):317–330, February 2015.
URL: http://dx.doi.org/10.1038/nature14248, doi:10.1038/nature14248.

72

The coMET User Guide

[7] Pouya Kheradpour and Manolis Kellis. Systematic discovery and

characterization of regulatory motifs in ENCODE TF binding experiments.
Nucleic acids research, 42(5):2976–87, 2014. URL:
http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=3950668&tool=
pmcentrez&rendertype=abstract, doi:10.1093/nar/gkt1249.

[8] The GTEx Consortium. The Genotype-Tissue Expression (GTEx) project. Nat

Genet., 45:580–5, 2013. doi:10.1038/ng.2653.

[9] Y Baran, M Subramaniam, A Biton, T Tukiainen, E.K. Tsang, M.A. Rivas,

M. Pirinen, M. Gutierrez-Arcelus, K.S. Smith, K.R. Kukurba, R Zhang, C Eng,
D.G. Torgerson, C Urbanek, GTEx Consortium, J.B. Li, J.R.
Rodriguez-Santana, E.G. Burchard, M.A. Seibold, D.G. MacArthur, S.B.
Montgomery, N.A. Zaitlen, and T Lappalainen. The landscape of genomic
imprinting across diverse adult human tissues. Genome Res., 25:927–36, 2015.
doi:10.1101/gr.192278.115.

[10] Suhas S.P. Rao, Miriam H. Huntley, Neva C. Durand, Elena K. Stamenova,
Ivan D. Bochkov, James T. Robinson, Adrian L. Sanborn, Ido Machol,
Arina D. Omer, Eric S. Lander, and Erez Lieberman Aiden. A 3D Map of the
Human Genome at Kilobase Resolution Reveals Principles of Chromatin
Looping. Cell, 159(7):1665–1680, December 2014. URL:
http://www.sciencedirect.com/science/article/pii/S0092867414014974,
doi:10.1016/j.cell.2014.11.021.

[11] Erez Lieberman-Aiden, Nynke L van Berkum, Louise Williams, Maxim

Imakaev, Tobias Ragoczy, Agnes Telling, Ido Amit, Bryan R Lajoie, Peter J
Sabo, Michael O Dorschner, Richard Sandstrom, Bradley Bernstein, M A
Bender, Mark Groudine, Andreas Gnirke, John Stamatoyannopoulos, Leonid A
Mirny, Eric S Lander, and Job Dekker. Comprehensive mapping of long-range
interactions reveals folding principles of the human genome. Science (New
York, N.Y.), 326(5950):289–93, October 2009. URL:
http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=2858594&tool=
pmcentrez&rendertype=abstract, doi:10.1126/science.1181369.

[12] Marina Lizio, Jayson Harshbarger, Hisashi Shimoji, Jessica Severin, Takeya

Kasukawa, Serkan Sahin, Imad Abugessaisa, Shiro Fukuda, Fumi Hori, Sachi
Ishikawa-Kato, Christopher J Mungall, Erik Arner, J Kenneth Baillie, Nicolas
Bertin, Hidemasa Bono, Michiel de Hoon, Alexander D Diehl, Emmanuel
Dimont, Tom C Freeman, Kaori Fujieda, Winston Hide, Rajaram
Kaliyaperumal, Toshiaki Katayama, Timo Lassmann, Terrence F Meehan, Koro
Nishikata, Hiromasa Ono, Michael Rehli, Albin Sandelin, Erik A. Schultes,
Peter A.C. Hoen, Zuotian Tatum, Mark Thompson, Tetsuro Toyoda, Derek W
Wright, Carsten O. Daub, Masayoshi Itoh, Piero Carninci, Yoshihide
Hayashizaki, Alistair R R Forrest, and Hideya Kawaji. Gateways to the
FANTOM5 promoter level mammalian expression atlas. Genome biology,
16(1):22, January 2015. URL: http://genomebiology.com/2015/16/1/22,
doi:10.1186/s13059-014-0560-6.

73

