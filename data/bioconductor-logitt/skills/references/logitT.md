Description of Logit-t: Detecting Diﬀerentially
Expressed Genes Using Probe-Level Data

Tobias Guennel

October 30, 2017

Contents

1 Introduction

2 What’s new in this version

3 Preparing data for use with logitT

4 Generate t-statistics and probe set expression summaries

5 Using Logit-t in gene expression analysis

6 Version history

7 Acknowledgements

2

3

3

4

5

5

5

1

1

Introduction

The Logit-t algorithm (Lemon et al., 2003), also called Median t (Hess et al., 2007), was
developed as an alternative to existing statistical methods for identifying diﬀerentially
expressed genes. Unlike other commonly used algorithms for identifying diﬀerentially
expressed genes, for example SAM (Tusher et al., 2001), the Logit-t algorithm does not
require the calculation of an expression summary for each probe set prior to statistical
analysis. Using spike-in datasets, the Logit-t algorithm was compared to statistical
testing of probe set expression summaries MAS5 (Hubbell et al., 2002), RMA (Irizarry
et al.,2003), and dChip (Li et al.,2001) and was found to to have better sensitivity,
speciﬁcity, and positive predicted value (PPV) (Lemon et al., 2003).
The Logit-t algorithm proceeds by ﬁrst normalizing probe intensities i within probe set
j for array k using the logit-log transformation

logit(yijk) = log

(cid:18) yijk − Nk
Ak − yijk

(cid:19)

.

(1)

The parameters Ak and Nk are estimated for each array by

Ak = max

i,j
Nk = min
i,j

(yijk) + 0.001 ∗ (max

i,j
(yijk) − 0.001 ∗ (max

(yijk) − min
i,j
(yijk) − min
i,j

(yijk))

(yijk)),

i,j

representing the maximum probe intensity (saturation) and the minimum probe inten-
sity (background), respectively. Following this transformation, probe level intensities for
each array were then standardized using a Z-transformation. Lemon et al. (2003).
For diﬀerential expression analysis, Student’s t-tests are then performed for each trans-
formed PM probe within a probe set and the Logit-t is deﬁned as the median t-statistic
among all t-statistics for the probe set. The t-value cutoﬀ corresponding to p < 0.01
using the df of the comparison was used as threshold for making detection calls of diﬀer-
ential expression or no diﬀerential expression in the original paper (Lemon et al., 2003).
The Logit-t algorithm was originally coded as a stand-alone application in C++ provided
by Dr William J. Lemon. In order to make it available for a broader spectrum of users,
the algorithm was implemented in the programming environment R, an open source
programming environment (R Development Core Team, 2008) and the most commonly
used software package for gene expression data analysis. There are no diﬀerences in re-
sults between the stand-alone application and its implementation in the R programming
environment as most of the model ﬁtting C++ code has been retained. However, the
implementation into the R programming environment simpliﬁes the use of the algorithm
and the access to its results signiﬁcantly compared to the stand-alone application. In
order to make it available for a broader spectrum of users, the algorithm was imple-
mented in R, an open source programming environment (R Development Core Team,
2008) and the most commonly used software package for gene expression data analysis.

2

There are no diﬀerences in results between the stand-alone application and its imple-
mentation in the R programming environment as most of the model ﬁtting C++ code
has been retained. However, the implementation into the R programming environment
simpliﬁes the use of the algorithm and the access to its results signiﬁcantly compared
to the stand-alone application. The logitT package implements the Logit-t algorithm
in the R programming environment, making it available to users of the Bioconductor1
project.

2 What’s new in this version

This is the ﬁrst release of this package.

3 Preparing data for use with logitT

The logitT package accepts data from Aﬀymetrix CEL ﬁles that have been read into the
R programming environment using the aﬀy (Gautier et al., 2004) library and stored in
an AffyBatch object. A CEL ﬁle contains, among other information, a decimal number
for each probe on the chip that corresponds to its intensity. The Bioconductor packages
aﬀy, Biobase, and tools(Gentleman et al., 2004) are automatically loaded by logitT to
provide functions for reading Aﬀymetrix data ﬁles into R. The following steps create an
AffyBatch object.

1. Create a directory containing all CEL ﬁles relevant to the planned analysis.

2. If using Linux / Unix, start R in that directory.

3. If using the Rgui for Microsoft Windows, make sure your working directory contains

the CEL ﬁles (use “File -> Change Dir” menu item).

4. Load the library.

> library(logitT)

5. Read in the data and create an AffyBatch object.

Additional information regarding the ReadAffy function and detailed description of the
structure of CEL ﬁles can be found in the aﬀy vignette.

1http://www.bioconductor.org/

3

4 Generate t-statistics and probe set expression sum-

maries

To demonstrate the use of the logitT R package, the publicly available Aﬀymetrix Latin
Square data set (Aﬀymetrix, 2008) was used. The Latin Square design for this data set
consists of 14 spiked-in gene groups in 14 experimental groups on HG-U95Av2 arrays.
The concentration of the 14 gene groups in the ﬁrst experiment is 0, 0.25, 0.5, 1, 2, 4, 8,
16, 32, 64, 128, 256, 512, and 1024pM. Each subsequent experiment rotates the spike-in
concentrations by one group; i.e. experiment 2 begins with 0.25pM and ends at 0pM, on
up to experiment 14, which begins with 1024pM and ends with 512pM. Each experiment
contains at least 3 replicates.
Two of the 14 experimental groups, i.e. group one and group two with 3 replicates each,
are available in the experimental data package SpikeInSubset as the data set spikein95.
The package and subsequently the data set can be loaded into the R programming
environment using R> library(SpikeInSubSet) and R> data(spikein95). To compare
the two groups of three arrays, where the ﬁrst three arrays correspond to group 1 and
the latter three to group 2, we deﬁne the groupvector as before. To invoke the logitTAﬀy
method, the syntax is:

> library(SpikeInSubset)
> data(spikein95) ## get the example data
> groupvector<-c("A","A","A","B","B","B") ## specify group affiliations
> logitTex<-logitTAffy(spikein95, group=groupvector)

The ﬁrst few t-statistics are:

> logitTex[1:10]

1000_at

1005_at
-0.365796303 0.074983648 0.136804337 0.144461320 -0.021213882 -0.003133944

1002_f_at

1003_s_at

1004_at

1001_at

1006_at

1009_at
0.100833725 0.266406403 0.277591814 0.860347914

1008_f_at

1007_s_at

The input arguments for the function call are:

object – object of type AffyBatch

group – vector describing the group aﬃliation for each array

The vector describing the group aﬃliation for each array must be of the same length as
the number of CEL ﬁles contained in the AﬀyBatch object. For example, suppose six
CEL ﬁles are stored in the AﬀyBatch object where the ﬁrst three arrays are from one
condition and the last three arrays are from a second condition. The object groupvector
in the function call would be

4

> groupvector<-c("A","A","A","B","B","B")

Note that the group labels can be deﬁned as desired provided only one unique label is
used for identifying a speciﬁc group.
After invoking the logitTAﬀy function, the result is a named vector containing the t-
statistics for each probe set.

5 Using Logit-t in gene expression analysis

As described in the introduction, Student’s t-tests are then performed for each trans-
formed PM probe within a probe set and the Logit-t is deﬁned as the median t-statistic
among all t-statistics for the probe set. The t-value cutoﬀ corresponding to p < 0.01
using the df of the comparison was used as threshold for making detection calls of diﬀer-
ential expression or no diﬀerential expression in the original paper (Lemon et al., 2003).
Lemon et al. suggested to use the df of the comparison to obtain p-values for the calcu-
lated t-statistics. In this example, n1 = 3 and n2 = 3 and therefore df= n1 + n2 − 2 = 4.
Two-sided p-values for each probe set can be obtained using:

> pvals <- (1-pt(abs(logitTex),df=4))*2
> signifgenes<-names(logitTex)[pvals<0.01]
> signifgenes

## calculate p-values
## find probe sets with p-values smaller than 0.01

[1] "1024_at" "1708_at" "32660_at" "36202_at" "36311_at" "38734_at"

6 Version history

1.0.0 initial development version

7 Acknowledgements

We thank Sandy Liyanarachchi for providing the original C++ implementation of the
Logit-t algorithm as described by Dr William J. Lemon, Dr Ming You, and Dr Sandya
Liyanarachchi. This work was partially supported by National Institute of Diabetes and
Digestive and Kidney Diseases R01DK069859.

References

Aﬀymetrix (2008) [http://www.aﬀymetrix.com].

Gautier,L. et al. (2004) Aﬀy–analysis of Aﬀymetrix GeneChip data at the probe level,

Bioinformatics, 20(3), 307-315.

5

Gentleman,R.C. et al. (2004) A high performance test of diﬀerential gene expression for

oligonucleotide arrays, Genome Biology,4,R:67.

Hess,A. et al. (2007) Fisher’scombined p-value for detecting diﬀerentially expressed genes

using Aﬀymetrix expression arrays, BMC Genomics,8:96.

Hubbell,E. et al. (2002) Analysis of high density expression microarrays with signed-rank

call algorithms, Bioinformatics,18,1593-1599.

Irizarry,R.A. et al. (2003) Summaries of Aﬀymetrix GeneChip probe level data, Nucleic

Acid Res,31,E:15.

Lemon,W.J. et al. (2003) Bioconductor: open software development for computational

biology and bioinformatics, Genome Biology,5,R:80.

R Development Core Team (2008), R: A Language and Environment for Statistical
Computing Version 2.7.1. R Foundation for Statistical Computing, Vienna, Austria.

6

