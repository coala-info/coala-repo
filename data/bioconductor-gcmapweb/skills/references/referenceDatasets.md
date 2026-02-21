Creating reference datasets:
The Broad Connectivity Map (v1)

Thomas Sandmann

October 30, 2018

Contents

1 Introduction

2 Analyzing the Broad Connectivity map (v.1) data

2

2

1

1 Introduction

Public repositories, such as ArrayExpress or GEO provide access to many published expression proﬁling
datasets, featuring perturbations in many diﬀerent organisms, model systems and conditions.

The Atlas search engine oﬀers a simple way to identify perturbation experiments of interest in the

ArrayExpress repository.

This vignette shows how to obtain and process raw microarray data from a large-scale drug pertur-
bation study performed in human cells, the Connectivity Map dataset (version 1), released by Lamb
and co-workers in 2006. Similar workﬂows can be used to download an process many other publically
available datasets.

In this study, the researchers treated multiple human cell lines with 164 distinct small molecules or
matched controls. In total, 564 samples were generated, RNA extracted, labeled and hybridized either
to A-AFFY-113 Aﬀymetrix (HT HG-U133A) or A-AFFY-33 Aﬀymetrix (HG-U133A) microarrays.

The raw data for this study is available from ArrayExpress under accession E-GEOD-5258 . The
raw .cel ﬁles and the array annotations can be downloaded and compiled into a suitable eSet objects
using the ArrayExpress Bioconductor package. Alternatively, the ﬁnal RData object can be downloaded
directly from ArrayExpress.

Please note that this is a large dataset and executing the following code will download more than

700 MB of data.

2 Analyzing the Broad Connectivity map (v.1) data

Data download and normalization

A call to the ArrayExpress function will retrieve the raw data for study E-GEOD-6907 from Array-
Express. (As this is a large dataset, this might take while...)

> library(ArrayExpress)
> GEOD5258.batch <- ArrayExpress("E-GEOD-6907")

As this experiment was performed on two diﬀerent array platforms, a list with two aﬀyBatch objects

is returned, one for each array platform.

We normalize each object separately using the rma function from the aﬀy package.

> library( affy )
> length( GEOD5258.batch )
> GEOD5258.eSets <- lapply( GEOD5258.batch, rma )

The mapNmerge function from the gCMAP package averages the expression values diﬀerent probes
for the same gene by mapping them to Entrez ids. Alternatively, the nsFilter function from the
geneﬁlter package could be used.

> GEOD5258.eSets <- lapply( GEOD5258.eSets, mapNmerge)

Now that we have mapped the expression values to Entrez Ids, we can combine the two Expression-

Sets into one

> GEOD5258.eSet <- mergeCMAPs( GEOD5258.eSets[[1]], GEOD5258.eSets[[2]] )

2

Deﬁning perturbation experiments and performing diﬀerential expression
analysis

The ArrayExpress dataset is associated with extensive sample annotation information, available in the
phenoData slot of the ExpressionSet. Experimental factors are marked with the Factor preﬁx in the
column name.

> head( pData(GEOD5258.eSet ))
> conditions <- grep("^Factor", varLabels( GEOD5258.eSet ), value=TRUE)
> conditions

In this case, we are interested in studying the eﬀect of the diﬀerent compounds, which are speciﬁed

in the column of the phenoData slot. Controls are annotated with the Compound level none .

> unique( pData( GEOD5258.eSet )$Factor.Value..Compound.)

To associate drug perturbation with their matched controls, we require that control experiments
must have been performed in the same CellLine and with the same Vehicle . With this information,
the splitPerturbations function from the gCMAP package can group treatment and perurbation
samples into individual experiments of interest. Each of these experimental instances is returned in a
separate ExpressionSet, grouped in the GEOD5258.list list.

> GEOD5258.list <- splitPerturbations( GEOD5258.eSet,

factor.of.interest="Compound",
control="none",
controlled.factors=c("CellLine", "Vehicle", "Time")

)

To track the experimental conditions assayed in each perturbation experiment, the ﬁrst line (con-
taining the perturbation) is extracted from each phenoData slot and deposited in a data.frame with one
row for each perturbation / ExpressionSet in GEOD5258.list.

> anno <- t(sapply( GEOD5258.list, function(x) pData(x)[1,conditions]))
> anno <- apply( anno, 2, unlist)
> anno <- data.frame( anno )
> colnames( anno ) <- c("CellLine", "Vehicle", "Compound", "Time", "Dose")

The generate_gCMAP_NChannelSet function performs diﬀerential expression analysis (using limma)
separately for each ExpressionSet in the list. It returns an NChannelSet object containing the log2
fold change, raw p-values and z-scores for all experiments.

> GEOD5258.ref <- generate_gCMAP_NChannelSet( GEOD5258.list,

uids=1:length( GEOD5258.list ),
sample.annotation=anno)

> pData( GEOD5258.ref)[10:15,]

This object, containing the diﬀerential expression results for 12701 genes from 214 diﬀerent pertur-
bation experiments and sample-level annotations in its phenoData slot, is now ready to be used as a
reference dataset by gCMAPWeb.

3

Inducing gene sets

If required, we can apply a threshold to one channel of the NChannelSet and deﬁne sets of diﬀerentially
up- and down-regulated genes. For example, the following command applies a z-score cutoﬀ of >3 or
<-3 to each experiment and stores the results in a sparse-matrix within a CMAPCollection.

> GEOD5258.sets <- induceCMAPCollection( GEOD5258.ref, element="z", higher=3, lower=-3 )
> head( setSizes( GEOD5258.sets ) )

4

> sessionInfo()

R version 3.5.1 Patched (2018-07-12 r74967)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats4
[8] methods

parallel stats
base

graphics grDevices utils

datasets

other attached packages:

[1] gCMAPWeb_1.22.0
[4] limma_3.38.0
[7] annotate_1.60.0

[10] IRanges_2.16.0
[13] BiocGenerics_0.28.0

Rook_1.1-1
GSEABase_1.44.0
XML_3.98-1.16
S4Vectors_0.20.0

gCMAP_1.26.0
graph_1.60.0
AnnotationDbi_1.44.0
Biobase_2.42.0

loaded via a namespace (and not attached):

[1] Rcpp_0.12.19
[5] tools_3.5.1
[9] memoise_1.1.0
[13] Category_2.48.0
[17] hwriter_1.3.2
[21] RBGL_1.58.0
[25] splines_3.5.1

compiler_3.5.1
digest_0.6.18
lattice_0.20-35
yaml_2.2.0
genefilter_1.64.0 bit64_0.9-7
survival_2.43-1
xtable_1.8-3

RColorBrewer_1.1-2 bitops_1.0-6
bit_1.1-14
Matrix_1.2-14
GSEAlm_1.42.0

RSQLite_2.1.1
DBI_1.0.0
DESeq_1.34.0
grid_3.5.1
geneplotter_1.60.0 blob_1.1.1
brew_1.0-6

RCurl_1.95-4.11

5

