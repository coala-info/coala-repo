Package ‘SISPA’

October 18, 2017

Type Package

Title SISPA: Method for Sample Integrated Set Proﬁle Analysis

Version 1.6.0

Date 2016-09-29

Author Bhakti Dwivedi and Jeanne Kowalski

Maintainer Bhakti Dwivedi <bhakti.dwivedi@emory.edu>

Description Sample Integrated Set Proﬁle Analysis (SISPA) is a method designed to deﬁne sam-

ple groups with similar gene set enrichment proﬁles.

Depends R (>= 3.2),geneﬁlter,GSVA,changepoint

Imports data.table, plyr, ggplot2

License GPL-2

LazyData true

Collate 'SISPA.R' 'callZSCORE.R' 'callGSVA.R' 'cptSamples.R'
'waterfallplot.R' 'freqplot.R' 'sortData.R' 'ﬁlterVars.R'
'expression_data.R' 'variant_data.R'

biocViews GeneSetEnrichment,GenomeWideAssociation

Suggests knitr

VignetteBuilder knitr

NeedsCompilation no

R topics documented:

.

.

.
callGSVA .
.
.
callZSCORE .
cptSamples
.
.
expression_data .
.
.
ﬁlterVars .
.
.
.
freqplot
.
.
SISPA .
.
.
sortData .
.
.
variant_data .
.
waterfallplot .

.
.
.
.
.
.

.
.
.
.

.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .

2
3
3
4
5
5
6
7
8
8

10

1

Index

2

callGSVA

callGSVA

GSVA enrichment analysis

Description

Estimates GSVA enrichment zscores.

Usage

callGSVA(x,y)

Arguments

x

y

Details

A data frame or matrix of gene or probe expression values where rows cor-
rospond to genes and columns corrospond to samples

A list of genes as data frame or vector

This function uses "zscore" gene-set enrichment method in the estimation of gene-set enrichment
scores per sample.

Value

A gene-set by sample matrix of GSVA enrichment zscores.

See Also

GSVA

Examples

g <- 10 ## number of genes
s <- 30 ## number of samples
## sample data matrix with values ranging from 1 to 10
rnames <- paste("g", 1:g, sep="")
cnames <- paste("s", 1:s, sep="")
expr <- matrix(sample.int(10, size = g*s, replace = TRUE), nrow=g, ncol=s, dimnames=list(rnames, cnames))
## genes of interest
genes <- paste("g", 1:g, sep="")
## Estimates GSVA enrichment zscores.
callGSVA(expr,genes)

callZSCORE

3

callZSCORE

Row ZSCORES

Description

Estimates the zscores for each row in the data matrix

Usage

callZSCORE(x)

Arguments

x

Details

A data frame or matrix of gene or probe expression values where rows cor-
rospond to genes and columns corrospond to samples

This function compute row zscores per sample when number of genes is less than 3

Value

A gene-set by sample matrix of zscores.

Examples

g <- 2 ## number of genes
s <- 60 ## number of samples
## sample data matrix with values ranging from 1 to 10
rnames <- paste("g", 1:g, sep="")
cnames <- paste("s", 1:s, sep="")
expr <- matrix(sample.int(10, size = g*s, replace = TRUE), nrow=g, ncol=s, dimnames=list(rnames, cnames))
## Estimates zscores
callZSCORE(expr)

cptSamples

Sample proﬁle identiﬁer analysis

Description

Generate sample proﬁle identiﬁers from sample zscores using change point model.

Usage

cptSamples(x, cpt_data, cpt_method, cpt_max)

4

Arguments

x

expression_data

A matrix or data frame of sample GSVA enrichment zscores within which you
wish to ﬁnd a changepoint.

cpt_data

Identify changepoints for data using variance (cpt.var), mean (cpt.mean) or both
(cpt.meanvar). Default is cpt.var.

cpt_method

Choice of single or multiple changepoint model. Default is "BinSeg".

cpt_max

The maximum number of changepoints to search for using "BinSeg" method.
Default is 60.

Details

This function assigns samples identiﬁed in the ﬁrst changepoint with the active proﬁle ("1") while
the remaining samples are grouped under inactive proﬁle ("0").

Value

The input data frame with added sample identiﬁers and estimated changepoints. A plot showing the
changepoint locations estimated on the data

See Also

changepoint

Examples

g <- 10 ## number of genes
s <- 60 ## number of samples
## sample data matrix with values ranging from 1 to 10
rnames <- paste("g", 1:g, sep="")
cnames <- paste("s", 1:s, sep="")
expr <- matrix(sample.int(10, size = g*s, replace = TRUE), nrow=g, ncol=s, dimnames=list(rnames, cnames))
## genes of interest
genes <- paste("g", 1:g, sep="")
## Estimates GSVA enrichment zscores.
gsva_results <- callGSVA(expr,genes)
cptSamples(gsva_results,cpt_data="var",cpt_method="BinSeg",cpt_max=60)

expression_data

An example of RNAseq derived gene expression data

Description

This dataset contains the expression values of 8 probes (rows) in 125 samples (columns), as com-
piled by the CoMMpass study.

Usage

data(expression_data)

Details

This is data to be included in my package

ﬁlterVars

Value

numeric expression dataset of 8 probes (rows) on 125 samples (column)

filterVars

A ﬁlter function for the data

5

Description

Filter rows with zero values

Usage

filterVars(x,y)

Arguments

x

y

Details

: A data frame or matrix where rows represent gene and columns represent
samples

: A vector of a sample column values to apply the ﬁltering on.

This function ﬁlter out rows with zero data value for a given sample. Both input arguments (x and
y) must be of the same length

Value

The returned value is a list containing an entry for each row ﬁltered out by zero data value

Examples

x = matrix(runif(3*10, 0, 1), ncol=3)
y <- x[,1]
filterVars(x,y)

freqplot

A plotting function for SISPA sample identiﬁers

Description

Given a sample changepoint data frame, will plot number of samples with and without proﬁle
activity

Usage

freqplot(x)

Arguments

x

A data frame containing samples as rows followed by zscores and estimated
changepoints to be plotted.

6

Details

SISPA

This function expects the output from cptSamples function of SISPA package, and shows the num-
ber of samples with (orange ﬁlled bars) and without proﬁle activity (grey ﬁlled bars).

Value

Bar plot pdf illustrating distribution of samples

Examples

samples <- c("s1","s2","s3","s4","s5","s6","s7","s8","s9","s10")
zscores <- c(3.83,2.70,2.67,2.31,1.70,1.25,-0.42,-1.01,-2.43,-3.37)
changepoints <- c(1,1,1,2,2,3,3,NA,NA,NA)
sample_groups <- c(1,1,1,0,0,0,0,0,0,0)
my.data = data.frame(samples,zscores,changepoints,sample_groups)
freqplot(my.data)

SISPA

SISPA

Description

SISPA: Method for Sample Integrated Gene Set Analysis

Usage

SISPA(feature=1,f1.df,f1.profile,f2.df,f2.profile,cpt_data="var",cpt_method="BinSeg",cpt_max=60)

Arguments

feature

f1.df

f1.profile

f2.df

f2.profile

cpt_data

cpt_method

cpt_max

Number of input feature or data types

A data matrix of ﬁrst feature (e.g., gene or probe expression values) where rows
corrospond to genes and columns corrospond to samples

A ﬂag to specify gene proﬁle. If gene.proﬁle="up" then samples with increased
zscores are identiﬁed. If gene.proﬁle="down" then samples with decreased zs-
cores are identiﬁed. Default is "up".

A data matrix of second feature (e.g., gene variant change) where rows cor-
rospond to genes and columns corrospond to samples

A ﬂag to specify gene proﬁle. If gene.proﬁle="up" then samples with increased
zscores are identiﬁed. If gene.proﬁle="down" then samples with decreased zs-
cores are identiﬁed. Default is "up".

Identify changepoints for data using variance (cpt.var), mean (cpt.mean), or both
(cpt.meanvar). Default is cpt.var.

Choice of single or multiple changepoint model. Default is "BinSeg". See
changepoint R package for details

The maximum number of changepoints to search for using "BinSeg" method.
Default is 60.

sortData

Details

7

Sample Integrated Gene Set Analysis (SISPA) is a method designed to deﬁne sample groups with
similar gene set enrichment proﬁles. The user speciﬁes a gene list of interest and sample by gene
molecular data (expression, methylation, variant, or copy change data) to obtain gene set enrichment
scores by each sample. The score statistics is rank ordered by the desired proﬁle (e.g., upregulated
or downregulated) for samples. A change point model is then applied to the sample scores to
identify groups of samples that show similar gene set proﬁle patterns. Samples are ranked by
desired proﬁle activity score and grouped by samples with and without proﬁle activity. Figure 1
shows the schematic representation of the SISPA method overview.

Value

The input molecular data frame with added sample identiﬁers and estimated changepoints. A plot
showing the changepoint locations estimated on the data. Bar plots pdf illustrating distinct distribu-
tion of samples with and without proﬁle activity

Examples

g <- 10 ## number of genes
s <- 60 ## number of samples
## sample data matrix with values ranging from 1 to 10
rnames <- paste("g", 1:g, sep="")
cnames <- paste("s", 1:s, sep="")
expr <- matrix(sample.int(10, size = g*s, replace = TRUE), nrow=g, ncol=s, dimnames=list(rnames, cnames))
SISPA(feature=1,f1.df=expr,f1.profile="up")

sortData

Sorts the data by a column

Description

Sorts the data frame by a column index in the given order

Usage

sortData(x,i,b)

Arguments

x

i

b

Details

A data frame

A numeric column index of the data frame to sort it by

User speciﬁed sorting order, ascending (FALSE) or descending (TRUE)

defaults are used: i = 1, b = FALSE, if not speciﬁed

Value

sorted data by the input column index

waterfallplot

8

Author(s)

Bhakti Dwivedi & Jeanne Kowalski

Examples

samples <- c("s1","s2","s3","s4","s5","s6","s7","s8","s9","s10")
zscores <- c(3.83,2.70,2.67,2.31,1.70,1.25,-0.42,-1.01,-2.43,-3.37)
my.data = data.frame(samples,zscores)
sortData(my.data,2,TRUE)

variant_data

An example of RNAseq derived gene variant change data

Description

This dataset contains the variant proportion values of variants (n=380) associated with 8 genes
(rows) in 125 samples (columns), as compiled by the CoMMpass study.

Usage

data(variant_data)

Details

This is data to be included in my package

Value

numeric variant dataset of 380 variants (rows) on 125 samples (column)

waterfallplot

A plotting function for SISPA sample identiﬁers

Description

Given a sample changepoint data frame, will plot all samples zscores from that data.

Usage

waterfallplot(x)

Arguments

x

Details

A data frame containing samples as rows followed by zscores and estimated
sample_groups to be plotted.

This function expects the output from cptSamples function of SISPA package, and highlights the
sample proﬁle of interest in the changepoint 1 with orange ﬁlled bars.

9

waterfallplot

Value

Bar plot pdf illustrating distinct SISPA sample proﬁles.

Examples

samples <- c("s1","s2","s3","s4","s5","s6","s7","s8","s9","s10")
zscores <- c(3.83,2.70,2.67,2.31,1.70,1.25,-0.42,-1.01,-2.43,-3.37)
changepoints <- c(1,1,1,2,2,3,3,NA,NA,NA)
sample_groups <- c(1,1,1,0,0,0,0,0,0,0)
my.data = data.frame(samples,zscores,changepoints,sample_groups)
waterfallplot(my.data)

Index

∗Topic datasets

expression_data, 4
variant_data, 8

callGSVA, 2
callZSCORE, 3
cptSamples, 3

expression_data, 4

filterVars, 5
freqplot, 5

SISPA, 6
sortData, 7

variant_data, 8

waterfallplot, 8

10

