COHCAP: City of Hope CpG Island Analysis
Pipeline

Charles Warden

October 30, 2017

1

Introduction

COHCAP (City of Hope CpG Island Analysis Pipeline) is an algorithm to an-
alyze single-nucleotide resolution methylation data (Illumina 450k methylation
array, targeted BS-Seq, etc.). It provides QC metrics, diﬀerential methylation
for CpG Sites, diﬀerential methylation for CpG Islands, integration with gene
expression data, and visualization of methylation values.

COHCAP is currently available as a standalone program (click here). Here
are potential advantages and disadvantages to using the standalone versus Bio-
condcutor COHCAP packages

Potential Advantages:

(cid:136) The Bioconductor package no longer uses separate functions for Il-
lumina array vs. Targeted BS-Seq data. This simpliﬁes the number
of parameters you need to understand in order to run COHCAP and
simpliﬁes software maintenance.

(cid:136) For 450k and 27k array data, you do not need to provide an annota-
tion ﬁle to COHCAP (but you can always specify custom annotations
with the Bioconductor package, which is useful for EPIC array and
BS-Seq data).

(cid:136) COHCAP output ﬁles are now better organized into subfolders for

easier interpretation.

(cid:136) Additional functions (such as ﬁlter for delta-beta values, clustering
of sites within regions, etc.) has been added in the Bioconductor
package.

(cid:136) The Bioconductor package doesn’t require users to install Java
(cid:136) The Bioconductor package doesn’t require users to point Perl to their

Rscript executable ﬁle

1

(cid:136) The Bioconductor package provides a feature to automatically create
a targeted BS-Seq annotation ﬁle (and creates necessary Bioconduc-
tor input ﬁle with Illumina array formatting)

Potential Disadvantages:

(cid:136) The Bioconductor version uses a greater percentage of R code for

functions, so it is slower than the standalone version.

(cid:136) The Bioconductor pacakge doesn’t contain a GUI.
(cid:136) There are formatting diﬀerences between the two COHCAP pack-
ages, so standalone documentation does not completely apply to the
Bioconductor package.

So, if you are comfortable with writing code in R, then you may prefer
using the COHCAP Biocondcutor package. If you are not confortable with any
programming (and you have a relatively small sample), you may prefer using
the standalone version of COHCAP. Large patient cohorts will most likely need
to be run on a powerful computer (such as a Linux cluster).

Most of the information on the COHCAP FAQ page will apply to both
versions. Questions for both versions should be directed to the COHCAP Dis-
cussion Group, with bioconductor users posting questions under ”Bioconductor:
[Problem Description]”.

EPIC Array Users: EPIC array data can be analyzed using the ”cus-
tom” CpG island mapping in the Bioconductor package. Click here for a tem-
plate using the Average-by-Island workﬂow. Click here for a template using the
Average-by-Site workﬂow.

In both cases, users should cite the following article when using COHCAP:

Charles D. Warden, Heehyoung Lee, Joshua D. Tompkins, Xiaojin Li,
Charles Wang, Arthur D. Riggs, Hua Yu, Richard Jove, Yate-Ching Yuan.
(2013) COHCAP: An Integrative Genomic Pipeline for Single-Nucleotide
Resolution DNA Methylation Analysis. Nucleic Acids Research. 41 (11):
e117

2 Data

Beta values from the Human Methylation 450k array and expression values from
the Aﬀymetrix Human Gene 1.0 ST Array. The DNA methylation data corre-
sponds to GSE42308, the gene expression data corresponds to GSE42307. This
example dataset contains two groups, each with 3 replicates. Fold-change, p-
values, and FDR values for gene expression data were calculated as described
in the Warden et al. 2013 NAR publication listed above. The dataset is signif-
icantly truncated for testing purposes.

2

> library("COHCAP")
> dir = system.file("extdata", package="COHCAP")
> beta.file = file.path(dir,"GSE42308_truncated.txt")
> sample.file = file.path(dir,"sample_GSE42308.txt")
> expression.file = file.path(dir,"expression-Average_by_Island_truncated.txt")
> project.folder = getwd()
> project.name = "450k_avg_by_island_test"

The code for this example assumes all ﬁles should be created in the current
working directory. However, you can specify the input and output ﬁles in any
location (using the complete ﬁle path).

3 Data Annotation

To normalize DNA Methylation beta or percentage methylation values, run the
following function

> beta.table = COHCAP.annotate(beta.file, project.name, project.folder,
+

platform="450k-UCSC")

7
[1] 173
5
[1] 172
[1] 172 11

The output is standard data frame with samples in rows and genes in columns,
which is also saved as an Excel ﬁle in the ”Raw Data” folder.

4 CpG Site Statistics

To display calculate CpG site statistics, ﬁlter for diﬀerentially methylated sites,
and/or create .wig ﬁles, run the following function

> filtered.sites = COHCAP.site(sample.file, beta.table, project.name,
+

project.folder, ref="parental")

6
6

[1] "Reading Sample Description File...."
[1] 172
[1] 172
[1] "Differential Methylation Stats for 2 Groups with Reference"
[1] 172
5
[1] 172 10
[1] 172 10
[1] 34 10
[1] 34 10

3

The ﬁltered list of CpG sites are created in the ”CpG Site” folder, which is also
the data frame returned by the function. Statistics for all CpG sites are located
in the ”Raw Data” folder. If .wig ﬁles are created (default setting), they can be
found within the ”CpG Site/wig” folder (in the subfolder with the corresponding
project name).

5 CpG Island Analysis

To display calculate CpG island statistics, ﬁlter for diﬀerentially methylated
islands, and/or create box-plots for diﬀerentially methylated islands, run the
following function

> island.list = COHCAP.avg.by.island(sample.file, filtered.sites, beta.table,
+

project.name, project.folder, ref="parental")

6
6

"Group: parental"

[1] "Reading Sample Description File...."
[1] 172
[1] 172
[1] "Group: mutant"
[1] "Checking CpG Site Stats Table"
[1] 34 10
[1] 29 10
[1] 5
[1] "Average CpG Sites per CpG Island"
[1] "Differential Methylation Stats for 2 Groups with Reference"
[1] 4 8
[1] 4 8
[1] "There are 4 differentially methylated islands"
[1] 4 8
[1] 4 8
[1] "Plotting Significant Islands Box-Plots.."

The ﬁltered list of CpG islands (with box-plots, if applicable) are created in
the ”CpG Island” folder. Box-plots can only be created using the ”Average by
Island” workﬂow (shown above) Statistics for all CpG islands (meeting the cutoﬀ
for minimum number of CpG sites) are located in the ”Raw Data” folder.

The function returns a data frame that can be used for integration with
gene expression data. The format of data frame depends upon the workﬂow
used for analysis. CpG island statistics will be provided by the ”Average by
Site” workﬂow (COHCAP.avg.by.site) whereas a table of beta values for diﬀer-
entially methylated islands will be provided by the ”Average by Island” workﬂow
(COHCAP.avg.by.island, shown above)

4

6

Integration with Gene Expression

To identify genes inverse expression changes (with scatterplots for visualization),
please run the following function:

> COHCAP.integrate.avg.by.island(island.list, project.name, project.folder,
+

expression.file, sample.file)

[1] 4 8
[1] 4 8
[1] 4
[1] 1.777472e-06 1.706586e-06 2.418011e-06 2.014309e-07
[1] 4
[1] 4
[1] "4 significant correlations"
[1] "Plotting Correlated Genes...."
[1] 4 14

The function doesn’t return any value and represents the last possible step in
the COHCAP pipeline.

Integration can only be performed in the ”Average by Site” workﬂow with
a 2-group comparison. This results in two tables (Methylation Up, Expression
Down and Methylation Down, Expression Up) in the ”Integrate” folder. The
gene expression ﬁle for the ”Average by Site” workﬂow includes population-level
fold-change, p-values, and FDR values (which must be calculated outside of
COHCAP).

Integration can be performed using the ”Average by Island” workﬂow with
any number of groups. This results in a single list of genes with negative expres-
sion correlations in the ”Integrate” as well as a folder for all correlation statistics
in the ”Raw Data” folder. If desired, scatter plots will also be produced for genes
with signiﬁcant negative correlations between methylation and gene expression
data. The gene expression ﬁle for the ”Average by Island” workﬂow is a table
of normalized intensity / expression values (can be from either microarray or
RNA-Seq data).

7 Targeted BS-Seq Analysis

The method of reading BS-Seq data is notably diﬀerent than the standalone
version of COHCAP.

In the standalone version, users directly read .bed ﬁles created from the
extended Bismark pipeline. Because the input ﬁle is standardized in the Bio-
conductor version of COHCAP, users must ﬁrst produce a ﬁle meeting this new
standard requirement.

Accordingly, a function unique to targeted BS-Seq analysis (COHCAP.BSSeq.preprocess)

has been added to the Bioconductor package to faciliate this step.

Additionally, this function also creates a custom annotation ﬁle that is

uniquely optimized for the user’s own targeted sequencing data.

5

The old UCSC CpG Island ﬁle is still available on sourceforge (click here to
download). This should technically work with any BS-Seq dataset. However, we
strongly encourage users to use the ﬁle created from COHCAP.BSSeq.preprocess,
especially since this step will likely be required to create the COHCAP input
ﬁle.

Users should be warned that this step will likely take several hours to run.

However, it luckily only has to be run once.

Detailed usage instructions can be found in the help description, called via

help(COHCAP.BSSeq.preprocess).

6

