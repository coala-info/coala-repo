maSigPro: Analysis of gene expression Significant Profiles

María J. Nueda1 and Ana Conesa2,3

11 May 2017

1Mathematics Department, University of Alicante, Spain
mj.nueda@ua.es
2 Genomics of Gene Expression Laboratory, Centro de Investigaciones Príncipe Felipe,
Valencia, Spain
aconesa@cipf.es
3 Microbiology and Cell Science Department, Institute for Food and Agricultural Research,
University of Florida, USA

maSigPro is a R package for the analysis of single and multiseries time course microarray
and RNA-Seq experiments.
maSigPro follows a two steps regression strategy to find genes with significant temporal
expression changes and significant differences between experimetal groups. The method firstly
defines a general regression model for the data where the experimental groups are identified
by dummy variables. The procedure adjusts this global model by the least squared technique
to identify differentially expressed genes and selects significant genes aplying false discovery
rate control procedure. Secondly, stepwise regression is applied as a variable selection strategy
to study differences between experimental groups and to find statistically significant different
profiles. The coefficients obtained in the second regression model will be useful to cluster
together significant genes with similar expression patterns and to visualize the results.
maSigPro also includes several tools for the analysis of alternative isoform expression in time
course transcriptomics experiments.
To obtain the User’s Guide you need to install the maSigPro package. Type at the R prompt:

> library(maSigPro)
> maSigProUsersGuide()

1

