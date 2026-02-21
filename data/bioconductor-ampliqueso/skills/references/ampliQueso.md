ampliQueso: multiple sequencing of amplicons
analyzed RNAseq style

Alicja Szabelska, Marek Wiewiorka, Michal Okoniewski

October 30, 2018

Contents

1 Recent changes and updates

2 Introduction

3 Using ampliQueso non-parametric tests on single genomic regions

4 Classic read counting in amplicon regions

5 Using an external variant caller - samtools mpileup

6 The complete report on AmpliSeq experiment

7 File formats

7.1 BED format

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

8 Troubleshooting

8.1.1
8.1.2

8.1 Mac OS X . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
rgl package
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
foreach package . . . . . . . . . . . . . . . . . . . . . . . . . . . .
8.2 Windows . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
foreach package . . . . . . . . . . . . . . . . . . . . . . . . . . . .

8.2.1

9 References

1

2

2

2

5

5

5

6
6

7
7
7
7
7
7

7

1 Recent changes and updates

2

Introduction

ampliQueso is UNDER CONSTRUCTION :P

but we do our best to make it functional and useful :)
ampliQueso is intended to be a library that can analyze the data from small (and bigger)
multiple- amplicon panels of RNA and DNA, in technologies such as AmpliSeq. In comparison
to eg TaqMan and similar RT-PCR technologies - AmpliSeq is a technique that uses the
sequencing library prepared with multiple primer pairs (eg up to 16000 in Comprehensive
Cancer Panel) that get ampliﬁed in a normal PCR machine.
It can be compared to other
sequencing enrichment techniques (), the diﬀerence is that is purely PCR-based. That’s why
it is expected to perform well eg with the slightly degraded (eg. paraﬃn embedded) samples.
AmpliSeq protocols are in RNA and DNA versions, the RNA one measures expression of the
ampliﬁed region, and when coverage permits - allows to ﬁnd SNPs and small indels too.

The number of amplicons in such kits may be too small to run DESeq or edgeR on count
data in a way described eg in [1], and the amplicons may be designed eg in the critical regions
of splicing, thus the basic analysis is based upon the coverage analysis described in [2] and
implemented in the package rnaSeqMap [3].

ampliQueso adds the functionality of non-parametric tests based upon the coverage
analysis (camel) measures from [2], and uses the external variant call software to add SNP
and indel information.

The analyses are bundled in a wrapper runAQReport that produces pdfs in Beamer or

standard LATEX article format.

The schema of processing in ampliQueso is as follows:

3 Using ampliQueso non-parametric tests on single ge-

nomic regions

Single genomic regions or batches of genomic regions may be compared with the camel/coverage
measures using functions:

> library(ampliQueso)
> data(ampliQueso)
> par(mfrow=c(1,2))
> simplePlot(ndMin,exps=1:2,xlab="genome coordinates \n RGS1:NM_002922",
+
> simplePlot(ndMax,exps=1:2,xlab="genome coordinates \n PLEK:NM_002664",
+

ylab="coverage")

ylab="coverage")

2

Figure 1: AmpliQueso high-level design, dashed arrows depict optional SNPs calling dataﬂow

3

68616000686190000200400600800genome coordinates  RGS1:NM_002922coverage192545000192545400050100150200genome coordinates  PLEK:NM_002664coverageThen, the measures from rnaSeqMap library can be used to generate p-values from non-

paramertic tests that express how the coverage shapes are diﬀerent, eg:

> library(xtable)
> curWd<-getwd()
> setwd(path.package("ampliQueso")) ##only for sample report
> iCovdesc=system.file("extdata","covdesc",package="ampliQueso")
> iBedFile=system.file("extdata","AQ.bed",package="ampliQueso")
> iT1="s"
> iT2="h"
> camelTestTable <- camelTest(iBedFile=iBedFile,iCovdesc=iCovdesc,
+
> #print sample p-values,not all of them
> camelTestTableDen<-camelTestTable[1:5,6:10]
> print(xtable(camelTestTableDen,caption="p-values from camel tests"))

iT1=iT1, iT2=iT2,iParallel=FALSE,iNPerm=5)

DA density QQ density PP density HD1 density HD2 density
0.15
0.15
0.32
0.32
0.82

0.15
0.15
0.32
0.32
0.82

0.15
0.15
0.32
0.32
1.00

0.15
0.15
0.65
0.32
0.49

0.15
0.15
0.65
0.32
1.00

Table 1: p-values from camel tests

MMEL1:NM 033467
DDAH1:NM 012137
EVI5:NM 005665
SLC30A7:NM 133496
EXTL2:NR 048570

> setwd(curWd)

The p-values may be used to ﬁnd the most signiﬁcantly diﬀerential shapes, thus - most
signiﬁcant diﬀerential expression in amplicons. The values of camel measures can be used
too, but normally they are less expressive. Still - can be compared between the regions:

> library(xtable)
> data(ampliQueso)
> print(xtable(camelSampleTable,
+

caption="Camel/coverage measures for two sample regions"))

region

1 PLEK:NM 002664
2 RGS1:NM 002922

DA
0.138
0.0048

QQ
65.4789
1.1178

PP
181890.6704
185.1135

HD1
84.6894
3.7024

HD2
73.5461
3.5341

Table 2: Camel/coverage measures for two sample regions

>

The object loaded from the example data contains the coverages as NucleotideDistr
objects, deﬁned in rnaSeqMap library.

4

4 Classic read counting in amplicon regions

The simple analysis may include generating counts from BAM ﬁles, according to the amplicon
description in the BED design ﬁle of the kit:

> library(ampliQueso)
> setwd(path.package("ampliQueso"))
> cc <- getCountTable(covdesc=system.file("extdata","covdesc",package="ampliQueso"),
+

bedFile=system.file("extdata","AQ.bed",package="ampliQueso"))

....................

> cc[1:4,1:2]

MMEL1:NM_033467
DDAH1:NM_012137
EVI5:NM_005665
SLC30A7:NM_133496

./extdata/sample_033_sort.bam ./extdata/sample_034_sort.bam
0
0
99
147

0
0
158
120

5 Using an external variant caller - samtools mpileup

In DNA amplicon kits and when the coverage in RNA ones is suﬃcient, the genomic variants
can be found. The funcrtion getSNP encapsulates a system call to samtools mpileup with
a reference genome:

> #in order to run this example you need provide reference sequence
> #in FASTA format and set refSeqFile parameter
> curWd<-getwd()
> setwd(path.package("ampliQueso")) ##only for sample report
> iCovdesc=system.file("extdata","covdesc",package="ampliQueso")
> iBedFile=system.file("extdata","AQ.bed",package="ampliQueso")
> snpList <- getSNP(covdesc=iCovdesc, minQual=10,
+
> setwd(curWd)

refSeqFile="hg19.fa", bedFile = iBedFile)

6 The complete report on AmpliSeq experiment

The complete report of a two-group comparison on a given set of BAM ﬁles and given BED
design desctiption includes all the parts of analysis described in the sections above and can
be called as follows:

> #########Example##########################
> library(ampliQueso)
> curWd<-getwd()
> setwd(path.package("ampliQueso")) ##only for sample report
> iCovdesc=system.file("extdata","covdesc",package="ampliQueso")

5

> iBedFile=system.file("extdata","AQ.bed",package="ampliQueso")
> iRefSeqFile=NULL
> iGroup="group"
> iT1="s"
> iT2="h"
> iTopN=5
> iMinQual=NULL
> iReportFormat="pdf"
> iReportType="article"
> iReportPath=curWd
> iVerbose=FALSE
> iParallel=FALSE
> runAQReport(iCovdesc=iCovdesc,iBedFile=iBedFile,iRefSeqFile=iRefSeqFile,
+ iGroup=iGroup,iT1=iT1,iT2=iT2,iTopN=iTopN,iMinQual=iMinQual,
+ iReportFormat=iReportFormat,iReportType=iReportType,
+
> setwd(curWd)

iReportPath,iVerbose=iVerbose,iParallel=iParallel)

it produces the pdf output.

The report can be used also for the DNA kits, but then the fold change should be
interpreted as a possible copy number diﬀerence. We are planning to diﬀerentiate the reports
for RNA and DNA.

7 File formats

7.1 BED format

AmpliQueso supports BED ﬁles in the following format (see also 2):

1. chromName

2. chromStart

3. chromEnd

4. strand

5. unspeciﬁed

6. name

chr1
chr1
chr1
chr1
chr1

2488068
2489144
2489772
2491241
2491314

2488201
2489273
2489907
2491331
2491444

.
.
.
.
.

TNFRSF14
TNFRSF14
TNFRSF14
TNFRSF14
TNFRSF14

AMPL242431688
AMPL262048751
AMPL241330530
AMPL242158034
AMPL242161604

Figure 2: Example BED ﬁle in the format supported by AmpliQueso

6

If a BED intened for use in AmpliQueso has a wrong column order one can easily rearrange

them using for example awk tool:

awk

{print($1,"\t",$2,"\t",$3,"\t",$5,"\t",$6,"\t",$4)}

input.bed > output.bed

’

’

In the example above columns 4,5,6 positions are swapped.

8 Troubleshooting

8.1 Mac OS X

8.1.1

rgl package

Please make sure that DISPLAY environemt variable is not set prior to runnin R in terminal.
Otherwise loading rgl package may hang without any obvious reason.

8.1.2

foreach package

It is not safe to use foreach package from R.app on Mac OS X. This is why, it is recommended
to use ampliQueso from a terminal session, starting R from the command line.

8.2 Windows

8.2.1

foreach package

Depending on Windows ﬁrewall settings, it might be necessary to conﬁrm ﬁrewall exceptions
allowing launching R slave servers which necessary for using foreach package.

9 References

References

[1] Anders S, McCarthy DJ, Chen Y, Okoniewski M, Smyth GK, Huber W, Robinson MD,
Count-based diﬀerential expression analysis of RNA sequencing data using R and Biocon-
ductor, pre-print: http://arxiv.org/abs/1302.3685, Nature Protocols, 2013 - accepted for
publication

[2] Okoniewski, M. J., Lesniewska, A., Szabelska, A., Zyprych-Walczak, J., Ryan, M.,
Wachtel, M., et al. (2011). Preferred analysis methods for single genomic regions in
RNA sequencing revealed by processing the shape of coverage. Nucleic acids research.
doi:10.1093/nar/gkr1249

[3] Lesniewska, A., & Okoniewski, M. J. (2011). rnaSeqMap: a Bioconductor package for
RNA sequencing data exploration. BMC bioinformatics, 12, 200. doi:10.1186/1471-2105-
12-200

7

