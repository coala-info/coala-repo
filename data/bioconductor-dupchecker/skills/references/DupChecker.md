DupChecker: a bioconductor package for
checking high-throughput genomic data
redundancy in meta-analysis

Quanhu Sheng∗, Yu Shyr, Xi Chen

Center for Quantitative Sciences, Vanderbilt University, Nashville, USA
∗shengqh (at) gmail.com

October 30, 2017

Abstract

Meta-analysis has become a popular approach for high-throughput
genomic data analysis because it often can signiﬁcantly increase power
to detect biological signals or patterns in datasets. However, when us-
ing public-available databases for meta-analysis, duplication of sam-
ples is an often encountered problem, especially for gene expression
data. Not removing duplicates could lead false positive ﬁnding, mis-
leading clustering pattern or model over-ﬁtting issue, etc in the sub-
sequent data analysis.

We developed a Bioconductor package Dupchecker that eﬃciently
identiﬁes duplicated samples by generating MD5 ﬁngerprints for raw
data. A real data example was demonstrated to show the usage and
output of the package.

Researchers may not pay enough attention to checking and remov-
ing duplicated samples, and then data contamination could make the
results or conclusions from meta-analysis questionable. We suggest
applying DupChecker to examine all gene expression data sets before
any data analysis step.

In this vignette, we demonstrate the application of DupChecker
as a package for checking high-throughput genomic data redundancy
in meta-analysis. DupChecker can download the GEO/ArrayExpress

1

raw data ﬁles from EBI/ncbi ftp server, extract individual data ﬁles,
calculate MD5 ﬁngerprint for each data ﬁle and validate the redun-
dancy of those data ﬁles.

DupChecker version: 1.16.0

If you use DupChecker in published research, please cite:

Quanhu Sheng, Yu Shyr, Xi Chen.: DupChecker: a bioconductor package for checking high-throughput genomic
data redundancy in meta-analysis. BMC bioinformatics 2014, 15:323.

Contents

1 Introduction

2 Standard workﬂow
. . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.1 Quick start
2.2 GEO/ArrayExpress data download . . . . . . . . . . . . . . .
2.3 Build ﬁle table
. . . . . . . . . . . . . . . . . . . . . . . . . .
2.4 Validate ﬁle redundancy . . . . . . . . . . . . . . . . . . . . .
2.5 Real example . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Discussion

4 Session Info

1

Introduction

2

3
3
3
4
4
5

6

6

Meta-analysis has become a popular approach for high-throughput genomic
data analysis because it often can signiﬁcantly increase power to detect bio-
logical signals or patterns in datasets. However, when using public-available
databases for meta-analysis, duplication of samples is an often encountered
problem, especially for gene expression data. Not removing duplicates would
make study results questionable. We developed a package DupChecker that
eﬃciently identiﬁes duplicated samples by generating MD5 ﬁngerprints for
individual data ﬁle.

2

2 Standard workﬂow

2.1 Quick start

Here we show the most basic steps for a validation procedure. You need to
create a target directory used to store the data. In order to illustrate the
procedure, here we used two very small datasets without redundant CEL
ﬁles. You may also try a real example with redundancy at example 2.5.

library(DupChecker)

## Create a "DupChecker" directory under temporary directory
rootDir<-paste0(dirname(tempdir()), "/DupChecker")
dir.create(rootDir, showWarnings = FALSE)
message(paste0("Downloading data to ", rootDir, " ..."))

geoDownload(datasets=c("GSE1478"), targetDir=rootDir)

##
## 1 GSE1478

dataset count
15

arrayExpressDownload(datasets=c("E-MEXP-3872"), targetDir=rootDir)

##
## 1 E-MEXP-3872

dataset count
12

datafile<-buildFileTable(rootDir=rootDir, filePattern="cel$")
result<-validateFile(datafile)
if(result$hasdup){

duptable<-result$duptable
write.csv(duptable, file=paste0(rootDir, "/duptable.csv"))

}

2.2 GEO/ArrayExpress data download

Firstly, function geoDownload/arrayExpressDownload will download raw data
from ncbi/EBI ftp server based on datasets user provided. Once the com-
pressed raw data is downloaded, individual data ﬁles will be extracted from

3

compressed raw data. Some of the data ﬁles may have been compressed.
Since the ﬁles compressed from same data ﬁle by diﬀerent softwares will
have diﬀerent MD5 ﬁgureprints, we will decompress those compressed data
ﬁles and validate the ﬁle redundancy using decompressed data ﬁles.

datatable<-geoDownload(datasets = c("GSE1478"), targetDir=rootDir)
datatable

##
## 1 GSE1478

dataset count
15

datatable<-arrayExpressDownload(datasets=c("E-MEXP-3872"), targetDir=rootDir)
datatable

##
## 1 E-MEXP-3872

dataset count
12

The datatable is a data frame containing dataset name and how many

ﬁles in that dataset.

There are two possible situations that you may want to download and
decompress the data using external tools. 1) The download or decompress
cost too much time in R environment; 2) The internal tool in R may download
imcomplete or interrupted ﬁle for huge ﬁle which will cause the ”untar” or
”gunzip” command fails.

2.3 Build ﬁle table

Secondly, function buildFileTable will try to ﬁnd all ﬁles (default) or expected
ﬁles matching ﬁlePattern parameter in the subdirectories of root directory.
The result data frame contains two columns, dataset (directory name) and
ﬁlename. Here, rootDir can also be an array of directories.
In following
example, we just focused on AﬀyMetrix CEL ﬁle only.

datafile<-buildFileTable(rootDir=rootDir, filePattern="cel$")

2.4 Validate ﬁle redundancy

The function validateFile will calculate MD5 ﬁngerprint for each ﬁle in table
and then check to see if any two ﬁles have same MD5 ﬁngerprint. The ﬁles

4

with same ﬁngerprint will be treated as duplication. The function will return
a table contains all duplicated ﬁles and datasets.

result<-validateFile(datafile)
if(result$hasdup){

duptable<-result$duptable
write.csv(duptable, file=paste0(rootDir, "/duptable.csv"))

}

2.5 Real example

There are three colon cancer related datasets (GSE14333, GSE13067 and
GSE17538) containing seriously data redundancy problem. User may run
following codes to do the validation. It may cost a few miniutes to a few
hours based on the network bindwidth and the computer performance.

library(DupChecker)

rootDir<-paste0(dirname(tempdir()), "/DupChecker_RealExample")
dir.create(rootDir, showWarnings = FALSE)

geoDownload(datasets = c("GSE14333", "GSE13067",

"GSE17538"), targetDir=rootDir)

datafile<-buildFileTable(rootDir=rootDir, filePattern="cel$")
result<-validateFile(datafile)
if(result$hasdup){

duptable<-result$duptable
write.csv(duptable, file=paste0(rootDir, "/duptable.csv"))

}

Table 1 illustrated the duplication between those three datasets. GSE13067

[64/74] means 64 of 74 CEL ﬁles in GSE13067 dataset were duplicated in
other two datasets.

5

Table 1: Part of duplication table of three datasets
GSE13067[64/74] GSE14333[231/290] GSE17538[167/244]
MD5
GSM437169.CEL
GSM358397.CEL
001ddd757f185561c9ﬀ9b4e95563372
00b2e2290a924fc2d67b40c097687404
GSM437210.CEL
GSM358503.CEL
012ed9083b8f1b2ae828af44dbab29f0 GSM327335.CEL GSM358620.CEL
GSM358441.CEL
023c4e4f9ebfc09b838a22f2a7bdaa59

GSM437117.CEL

3 Discussion

We illustrated the application using gene expression data, but DupChecker
package can also be applied to other types of high-throughput genomic data
including next-generation sequencing data.

4 Session Info

• R version 3.4.2 (2017-09-28), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C,

LC_TIME=en_US.UTF-8, LC_COLLATE=C, LC_MONETARY=en_US.UTF-8,
LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C,
LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

• Running under: Ubuntu 16.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so

• LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

• Base packages: base, datasets, grDevices, graphics, methods, stats,

utils

• Other packages: DupChecker 1.16.0

• Loaded via a namespace (and not attached): R.methodsS3 1.7.1,

R.oo 1.21.0, R.utils 2.5.0, RCurl 1.95-4.8, bitops 1.0-6, compiler 3.4.2,
evaluate 0.10.1, highr 0.6, knitr 1.17, magrittr 1.5, stringi 1.1.5,
stringr 1.2.0, tools 3.4.2

6

