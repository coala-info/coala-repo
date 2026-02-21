MAQCsubsetAFX: MAQC reference subset for the
Aﬀymetrix platform

Laurent Gatto

November 1, 2018

Contents

1 The MAQC reference datasets

2 Loading the reference data

1

2

1 The MAQC reference datasets

The MAQC (MicroArray Quality Control) project1 provides a set of reference datasets
for a set of 10 platforms (see Summary of the MAQC Data Sets 2 for more details). This
package provides a subset of the Aﬀymetrix MAQC dataset3.

Regarding the Aﬀymetrix platform (AFX preﬁx), a total of 120 Human Genome
U133 Plus 2.0 GeneChips have been generated. Four diﬀerent reference RNAs have
been used: (A) 100% of Stratagene’s Universal Human Reference RNA, (B) 100% of
Ambion’s Human Brain Reference RNA, (C) 75% of A and 25% of B and (D) 25% of
A and 75% of B. Each reference has been repeated 5 times (noted A1 to A5 ) on six
diﬀerent test sites (noted 1 to 6 ). As an example, the .CEL result ﬁle for the ﬁrst
replicate of test site 2, for the reference ARN C is named AFX_2_C1.CEL.

These datasets are freely available and allow, for example, researchers to compare
the reproducibility of their own Human Genome U133 Plus 2.0 arrays with a set of high

1http://www.fda.gov/nctr/science/centers/toxicoinformatics/maqc
2http://edkb.fda.gov/MAQC/MainStudy/upload/Summary_MAQC_DataSets.pdf
3Packages for the datasets of other platforms will follow and will all be named MAQCsubsetXXX

where XXX is the three-letter code used by the MAQC consortium.

1

quality .CEL ﬁles. Nevertheless, using all the 30 available .CEL ﬁles (per reference RNA)
is memory consuming. As such, we randomly chose 6 .CEL ﬁle for each reference RNA,
one for each test site as reference to compare the user’s data to. These 6 .CEL ﬁles
are distributed with the MAQCsubsetAFX package as 1 data object par reference RNA,
respectively called refA.RData, refB.RData, refC.RData and refD.RData. These sub-
sets are used by the yaqcaﬀy package to estimate the reproducibility of Human Genome
U133 Plus 2.0 with the MAQC subset.

More information concerning the MAQC initiative can be found in the September

2006 special issue of Nature Biotechnology.

2 Loading the reference data

Once the library has been installed and loaded, the reference datasets can be loaded
using the (data()) function as shown below.

> library("MAQCsubsetAFX")
> data(refA)
> refA

AffyBatch object
size of arrays=1164x1164 features (19 kb)
cdf=HG-U133_Plus_2 (54675 affyids)
number of samples=6
number of genes=54675
annotation=hgu133plus2
notes=

2

