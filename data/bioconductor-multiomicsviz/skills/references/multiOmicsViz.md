Manual of multiOmicsViz

Jing Wang

April 24, 2017

1

Introduction

multiOmicsViz package can calculate the spearman correlation between the source omics data and other
target omics data, identify the signiﬁcant correlations and plot the signiﬁcant correlations on the heat map
in which the x-axis and y-axis are ordered by the chromosomal location.

2 Environment

multiOmicsViz requires R version 3.3 or later, which can be downloaded from the website http://www.r-
project.org/. multiOmicsViz package can be installed as follows.

source(”http://bioconductor.org/biocLite.R”) install.package(”multiOmicsViz”,dependencies=TRUE)

3 multiOmicsViz

After building up the basic environment mentioned above, the users can install the multiOmicsViz package
and use it to analyze networks.

> library("multiOmicsViz")
> sourceOmics <- system.file("extdata","sourceOmics.txt",package="multiOmicsViz")
> sourceOmics <- read.table(sourceOmics,header=TRUE,sep="\t",stringsAsFactors=FALSE,check.names=FALSE)
> targetOmics1 <- system.file("extdata","targetOmics.txt",package="multiOmicsViz")
> targetOmics1 <- read.table(targetOmics1,header=TRUE,sep="\t",stringsAsFactors=FALSE,check.names=FALSE)
> targetOmicsList <- list()
> targetOmicsList[[1]] <- targetOmics1
> outputfile <- paste(tempdir(),"/heatmap",sep="")
> multiOmicsViz(sourceOmics,"CNA","20",targetOmicsList,"mRNA","All",0.001,outputfile)

Identify the significant correlations...
Plot figure...
null device
1

3.1 Input

This section describes the arguments of the multiOmicsViz function:

1. sourceOmics: A R matrix, data.frame or SummarizedExperiment object containing the omics data. The
data should contain the row names representing the genes and column names representing the samples.

2. sourceOmicsName: The name of the source omics data (e.g. CNA).

3. chrome sourceOmics: The multiOmicsViz function will extract the genes in the selected chromosome(s)
from genes in the source omics data and then identify and visualize the signiﬁcant correlations based on the

1

selected genes. chrome sourceOmics can be one character containing the chromosome name (e.g. ”1”), a R
vector object containing multiple chromosomes (e.g. c(”1”,”2”,”3”)) or ”All” representing all 24 chromosomes.

4. targetOmicsList: A R list object containing at most 5 target omics data. Each omics data in the list
should be a R matrix, data.frame or SummarizedExperiment object and contain the row names representing
the genes and column names representing the samples. There should have multiple overlapping genes among
all target omics data and at least 6 overlapping sample between source omics data and each target omics
data.

5. targetOmicsName: A R vector object containing the name of all target omics data stored in the targe-
tOmicsList.

6. chrome targetOmics: The multiOmicsViz function will extract the genes in the selected chromosome(s)
from the overlapping genes among all target omics data and then identify and visualize the signiﬁcant corre-
lations based on the selected genes. chrome sourceOmics can be one character containing the chromosome
name (e.g. ”1”), a R vector object containing multiple chromosomes (e.g. c(”1”,”2”,”3”)) or ”All” representing
all 24 chromosomes.

7. fdrThr : The FDR threshold for identifying the signiﬁcant correlations.

8. outputﬁle: The output ﬁle name.

9. nThreads: If targetOmicsList contains 2 or 3 omics data, multiOmicsViz will use the parallel computing
method to calculate the signiﬁcant correlations between the source omics data and each of target omics data.
nThreads is the number of cores used for the parallel computing.

10. legend : If legend is TRUE, the output heat map will contain the legend.

3.2 Output

If the targetOmicsList contains one target omics data, the multiOmicsViz function will plot a heat map in
which x-axis represents the genes in the source omics data, y-axis represents the genes in the target omics
data, x-axis and y-axis are ordered by chromosomal location, each point represents a signiﬁcant correlation,
red color represents the signiﬁcant positive correlation and blue color represents the signiﬁcant negative
correlation. If the targetOmicsList contains multiple target omics data, the multiOmicsViz function will not
only plot multiple heat maps for each target omics data but also plot mutliple bar charts in which blue bars
represent the number of speciﬁc signiﬁcant correlations for the target omics data and black bars represents
the number of common signiﬁcant correlations among all target omics data.

The following ﬁgure is one example to use heat maps to compare the eﬀect of CNA (copy number alteration)
on mRNA and protein abundance.

4 calculateCorForTwoMatrices

The calculateCorForTwoMatrices function can Identify the signiﬁcant correlations between two matrices.

> library("multiOmicsViz")
> matrix1 <- system.file("extdata","sourceOmics.txt",package="multiOmicsViz")
> matrix1 <- read.table(matrix1,header=TRUE,sep="\t",stringsAsFactors=FALSE,check.names=FALSE)
> matrix2 <- system.file("extdata","targetOmics.txt",package="multiOmicsViz")
> matrix2 <- read.table(matrix2,header=TRUE,sep="\t",stringsAsFactors=FALSE,check.names=FALSE)
> sig <- calculateCorForTwoMatrices(matrix1=matrix1,matrix2=matrix2,fdr=0.01)

4.1

Input

1. matrix1 and matrix2 : A R matrix, data.frame or SummarizedExperiment object containing the numeric
values. matrix2 should have at least 6 overlapping samples with matrix1.

2. fdr : The FDR threshold for identifying signiﬁcant correlations.

4.2 Output

This function will return a R matrix object containing signiﬁcant correlations. ”1” represents the signiﬁcant
positive correlation, ”-1” represents the signiﬁcant negative correlation and ”0” represents no signiﬁcant
correlation.

