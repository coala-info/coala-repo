sRAP: Simpliﬁed RNA-Seq Analysis Pipeline

Charles Warden

October 30, 2017

1

Introduction

This package provides a pipeline for gene expression analysis. The normalization
function is speciﬁc for RNA-Seq analysis, but all other functions will work with
any type of gene expression data. The output from each function is created in
a separate subfolder. Please see the workﬂow below:

Normalization will take RPKM expression values, round the RPKM values
below a given cutoﬀ, and perform a log2 data transformation. Quality control

1

sRAP Workflow Normalization (For RNA-Seq) •Rounding (RPKM Cutoff) •Log2 transformation QC (Any Data Type) •PCA •Dendrogram •Sample Histogram •Box-Plot DEG (Any Data Type) •Linear Regression or ANOVA •Fold-change (against reference group) •Gene lists (in Excel) •Heatmap •Box-Plot for DEG Functional Enrichment (Any Data Type) •BD-Func  •GO (Human, Mouse) + MSigDB (Human) metrics (Principal Component Analysis, Hierarchical Clustering, Sample His-
tograms and Box-Plots, and Descriptive Statistics) can be provided for these
normalized expression values. These approximately normal expression distribu-
tions are then subject to diﬀerential expression. Diﬀerentially expressed gene
lists are provided in Excel ﬁles and data can be visualized using a heatmap for
all diﬀerentially expressed genes or a box-plot for a speciﬁc gene. BD-Func can
then be used to calculate functional enrichment (either for fold-change values
between two groups or using the normalized expression values).

2 Data

RPKM expression value for MiSeq samples were calculated using TopHat and
Cuﬄinks from raw .fastq ﬁles from GSE37703. A template script for this sam-
ple preparation (run RNA Seq v2.pl) is available here. This example dataset
contains two groups, each with 3 replicates. The dataset is truncated for testing
purposes.

> library("sRAP")
> dir <- system.file("extdata", package="sRAP")
> expression.table <- file.path(dir,"MiSeq_cufflinks_genes_truncate.txt")
> sample.table <- file.path(dir,"MiSeq_Sample_Description.txt")
> project.folder <- getwd()
> project.name <- "MiSeq"

The code for this example assumes all ﬁles are in the current working directory.
However, you can specify the input and output ﬁles in any location (using the
complete ﬁle path).

3 Data Normalization

To normalize RNA-Seq RPKM values, run the following function

> expression.mat <- RNA.norm(expression.table, project.name, project.folder)

NULL

RNA-Seq data is normalized by rounding RPKM (Read Per Kilobase per Mil-
lion reads, [1]) values by a speciﬁed value (default=0.1), followed by a log2
transformation. This matches the gene expression strategy described in [2].

The output is standard data frame with samples in rows and genes in

columns.

An Excel ﬁle containing the normalized expression values is created in the

”Raw Data” folder.

If you do not already have a table of RPKM/FPKM expression values, you
can use the RNA.prepare.input() function to create such a ﬁle. Please see
help(RNA.prepare.input) for more details.

2

4 Quality Control Figures

To create quality control ﬁgures, run the following function

> RNA.qc(sample.table, expression.mat, project.name,
+
+

project.folder, plot.legend=F,
color.palette=c("green","orange"))

[1] "SRR493372" "SRR493373" "SRR493374" "SRR493375" "SRR493376" "SRR493377"
[1] "integer"
[1] "Group: HOXA1KD" "Group: scramble"
[1] "Color: green" "Color: orange"
NULL

The input is a matrix of normalized expression values, possibly created from the
RNA.norm function.

This function creates quality control ﬁgures within the ”QC” subfolder. Qual-
ity control ﬁgures / tables include: Principal Components Analysis (ﬁgure for
1st two principal components, table for all principal components), Sample Den-
drogram, Sample Histogram, Box-Plot for Sample Distribution, as well as a
table of descriptive statistics for each sample (median, top/bottom quartile,
maximum, and minimum). Please see the example ﬁgures displayed below:

3

RNA.qc PCA Plot

4

llllll0.4070.4080.4090.410−0.4−0.20.00.20.4PC1 (97.62%)PC2 (1.11%)RNA.qc Dendrogram

5

150100500llSRR493377lSRR493375lSRR493376lSRR493372lSRR493373lSRR493374RNA.qc Sample Histogram

6

05100.000.050.100.150.200.250.30Log2(RPKM)DensityRNA.qc Sample Box-Plot

This step is optional - this function is not needed for downstream analysis.
However, this function is likely to be useful to identifying outliers, overall quality
of the data, etc.

5 Diﬀerential Expression

To deﬁne diﬀerentially expressed genes, run the following function

> stat.table <- RNA.deg(sample.table, expression.mat,
+
+
+

project.name, project.folder, box.plot=FALSE,
ref.group=T, ref="scramble",
method="aov", color.palette=c("green","orange"))

[1] 422
[1] 422
[1] 422
[1] "Group: HOXA1KD" "Group: scramble"

4
4
6

7

llll0510[1] "Color: green" "Color: orange"
NULL

The input is a matrix of normalized expression values, possibly created from the
RNA.norm function.

The function returns a table of diﬀerential expression statistics for all genes.
In all cases, p-values can be calculated via linear regression of ANOVA, and
false-discovery rates (FDR) are calculated by the method of [3]. It is assumed
that expression values are on a log2 scale, as described in [2].

If the primary variable (deﬁned in the second column of the sample descrip-
tion table) is a factor with two groups and a speciﬁed reference, then fold-change
values can also used to select diﬀerentially expressed genes (along with p-value
and FDR values).

The function creates lists of diﬀerentially expressed genes (as well as a table
of statistics for all genes) in Excel ﬁles. A heatmap of diﬀerentially expressed
genes is also displayed . If desired, the user can also create box-plots for all
diﬀerentially expressed genes. Please see the example ﬁgures below:

RNA.deg Heatmap

8

RNA.deg Box-Plot

An Excel ﬁle containing the table of diﬀerential expression statistics for all
genes is created in the ”Raw Data” folder. All other outputﬁles are created in
the ”DEG” folder (DEG stands for ”Diﬀerenitally Expressed Genes”).

6 Functional Enrichment

To identify functional categories subject to diﬀerential expression, run the fol-
lowing function

> #data(bdfunc.enrichment.human)
> #data(bdfunc.enrichment.mouse)
> RNA.bdfunc.fc(stat.table, plot.flag=FALSE,
+

project.name, project.folder, species="human")

NULL

> RNA.bdfunc.signal(expression.mat, sample.table, plot.flag=FALSE,
+

project.name, project.folder, species="human")

9

HOXA1KDscramble6.86.97.07.17.27.37.4NULL

This is an implementation of the Bi-Directional FUNCtional enrichment (BD-
Func [4]) algorithm. Brieﬂy, p-values quantifying the diﬀerence between up- and
down-regulated genes can be calculated via t-test, Mann-Whitney U test, or K-S
test. If desired, false discovery rates (FDR) can be calculated using either the
method of Benjamini and Hochberg [3] or the Storey q-value [5].

The input for the RNA.bdfunc.fc function is a table of diﬀerential expression
statisics (like that created by the RNA.deg function). If desired, the this function
can create density plots for all gene lists (see below).

RNA.bdfunc.fc Density Plot

The input for the RNA.bdfunc.signal function is a table of normalized ex-
pression values (like that created by the RNA.norm function). If desired, the
this function can create box-plots for enrichment scores across all gene lists (see
below).

10

−1.5−1.0−0.50.00.51.01.50.00.51.01.52.02.53.0SignalDensityActivated GenesInhibited GenesRNA.bdfunc.signal Box-Plot

In both cases, the output ﬁles are created with in the ”BD-Func” subfolder.
The goal of BD-Func is to calculate functional enrichment by comparing lists
of activated and inhibited genes for a functional category, pathway, and/or net-
work.

This package includes pre-deﬁned enrichment lists are available for human
and mouse gene symbols. The human enrichment list is based upon Gene On-
tology [6] and MSigDB [7] gene lists. The mouse enrichment list is based upon
Gene Ontology categories. Additional gene lists will need to be imported using
the enrichment.ﬁle parameter.

This step is optional - there are no other functions that depend on the results

of this analysis.

References

[1] Mortazavi A et al. Mapping and quantifying mammalian transcriptomes by

RNA-Seq. Nat Meth, 5:621–628, 2008.

11

HOXA1KDscramble0.650.700.750.800.850.90ANOVA p−value = 0.01Test Statistic[2] Warden CD et al. Optimal Calculation of RNA-Seq Fold-Change Values.

Int J Comput Bioinfo In Silico Model, 2:285–292, 2014.

[3] Benjamini Y and Hochberg Y. Controlling the False Discovery Rate: A
Practical and Powerful Approach to Multiple Testing. Journal of the Royal
Statistical Society Series B, 57:289–300, 1995.

[4] Warden CD et al. BD-Func: A Streamlined Algorithm for Predicting Acti-

vation and Inhibition of Pathways. peerJ, 1:e159, 2013.

[5] Storey JD and Tibshirani R. Statistical signiﬁcance for genomewide studies.
Proceedings of the National Academy of Sciences, 100:9440–9445, 2003.

[6] Ashburner M et al. Gene Ontology: tool for the uniﬁcation of biology. Nat

Genet, 25:25–29, 2000.

[7] Liberzon A et al. Molecular signatures database (MSigDB) 3.0. Bioinfor-

matics, 27:1739–1740, 2011.

12

