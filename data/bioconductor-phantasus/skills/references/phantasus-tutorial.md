# Using Phantasus application

#### 2025-10-31

This tutorial describes Phantasus – a web-application for visual and interactive gene expression analysis.
Phantasus is based on
[Morpheus](https://software.broadinstitute.org/morpheus/) – a web-based software
for heatmap visualisation and analysis, which was integrated with an R environment via [OpenCPU API](https://www.opencpu.org/).

The main object in Phantasus is a gene expression matrix.
It can either be uploaded from a local text or Excel file
or loaded from Gene Expression Omnibus (GEO) database by the series identifier
(both microarray and RNA-seq datasets are supported).
Aside from basic visualization and filtering methods as implemented in Morpheus,
R-based methods such as k-means clustering, principal component analysis,
differential expression analysis with limma package are supported.

In this vignette we show example usage of Phantasus for analysis of public gene
expression data from GEO database.
It starts from loading data, normalization and filtering outliers,
to doing differential gene expression analysis and downstream analysis.

# 1 Example workfow for analysing gene expression changes in macrophage activation

To illustrate the usage of Phantasus let us consider public dataset from Gene Expression Omnibus (GEO) database
[GSE53986](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE53986).
This dataset contains data from experiments, where bone marrow derived macrophages were
treated with three stimuli: LPS, IFNg and combined LPS+INFg.

## 1.1 Starting application

The simplest way to try Phantasus application is to go to web-site
<https://alserglab.wustl.edu/phantasus>
where the latest version is deployed.

Alternatively, Phantaus can be start locally using the corresponding R package:

```
library(phantasus)
servePhantasus()
```

This command runs the application with the default parameters,
opens it in the default browser (from `browser` option)
with address <http://0.0.0.0:8000>.
The starting screen should appear:

![](data:image/jpeg;base64...)

## 1.2 Preparing the dataset for analysis

**Opening the dataset**

Let us open the dataset. To do this, select *GEO Datasets* option
in *Choose a file…* dropdown menu. There, a text field will appear
where `GSE53986` should be entered. Clicking the *Load* button
(or pressing *Enter* on the keyboard) will start the loading.
After a few seconds, the corresponding heatmap should appear.

![](data:image/jpeg;base64...)

On the heatmap, the rows correspond to genes (or microarray probes).
The rows are annotated with *Gene symbol* and *Gene ID* annotaions
(as loaded from GEO database).
Columns correspond to samples.
They are annotated with titles, GEO sample accession identifiers and treatment field.
The annotations, such as treatment, are loaded from user-submitted GEO annotations
(they can be seen, for example, in *Charateristics*
secion at <https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1304836>).
We note that not for all of the datasets in GEO such proper annotations are supplied.

**Adjusting expression values**

By hovering at heatmap cell, gene expression values can be viewed.
The large values there indicate that the data is not log-scaled,
which is important for most types of gene expression analysis.

![](data:image/jpeg;base64...)

For the proper further analysis it is recommended to normalize the
matrix. To normalize values go to *Tools/Adjust* menu and
check *Log 2* and *Quantile normalize* adjustments.

![](data:image/jpeg;base64...)

The new tab with adjusted values will appear. All operations that modify gene expression
matrix (such as adjustment, subsetting and several others) create a new tab. This allows
to revert the operation by going back to one of the previous tabs.

**Removing duplicate genes**

Since the dataset is obtained with a mircroarray, a single gene can be represented by
several probes. This can be seen, for example, by sorting rows
by *Gene symbol* column (one click on column header), entering `Actb` in the search
field and going to the first match by clicking down-arrow next to the field.
There are five probes corresponding to Actb gene in the considered microarray.

![](data:image/jpeg;base64...)

To simplify the analysis it is better to have one row per gene
in the gene expression matrix.
One of the easiest ways is to chose only one row that has
the maximal median level of expression
across all samples. Such method removes the noise of lowly-expressed probes.
Go to *Tools/Collapse* and choose *Maximum Median Probe* as the method and
*Gene ID* as the collapse field.

![](data:image/jpeg;base64...)

The result will be shown in a new tab.

**Filtering lowly-expressed genes**

Additionally, lowly-epxressed genes can be filtered explicitly. It helps to reduce noise and increase
power of downstream analysis methods.

First, we calculate mean expression of each gene using
*Tools/Create Calculated Annotation* menu.
Select `Mean` operation, optionally enter a name for the resulting column,
and click *OK*. The result will appear as an additional column in row annotations.

![](data:image/jpeg;base64...)

![](data:image/jpeg;base64...)

Now this annotation can be used to filter genes.
Open *Tools/Filter* menu. Click *Add* to add a new filter. Choose `mean_expression`
as a *Field* for filtering. Then press *Switch to top filter* button
and input the number of genes to keep. A good choice for a typical mammalian dataset
is to keep around 10–12 thousand most expressed genes. Filter is applied automatically,
so after closing the dialog with *Close* button only the genes passing the filter
will be displayed.

![](data:image/jpeg;base64...)

![](data:image/jpeg;base64...)

It is more convenient to extract these genes into a new tab.
For this, select all genes (click on any gene and press *Ctrl+A*) and
use *Tools/New Heat Map* menu (or press *Ctrl+X*).

Now you have the tab with a fully prepared dataset for the further analysis.
To easily distinguish it from other tabs, you can rename it
by right click on the tab and choosing *Rename* option. Let us rename it to `GSE53986_norm`.

It is also useful to save the current result to be able to return to it later.
In order to save it use *File/Save Dataset* menu. Enter an appropriate file name (e.g. `GSE53986_norm`)
and press `OK`. A file in text [GCT format](https://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats#GCT:_Gene_Cluster_Text_file_format_.28.2A.gct.29)
will be downloaded.

## 1.3 Exploring the dataset

**PCA Plot**

One of the ways to asses quality of the dataset is to use
principal component analysis (PCA) method. This can be done
using *Tools/Plots/PCA Plot* menu.

![](data:image/png;base64...)

You can customize color, size and labels of points on the chart
using values from annotation. Here we set color to come from
*treatment* annotation.

![](data:image/png;base64...)

It can be seen that in this dataset the first replicates in each condition
are outliers.

**K-means clustering**

Another useful dataset exploration tool is k-means clustering.
Use *Tools/Clustering/k-means* to cluster genes into 16 clusters.

![](data:image/jpeg;base64...)

Afterwards, rows can be sorted by *clusters* column. By using
menu *View/Fit to window* one can get a “bird’s-eye view” on the dataset.
Here also one can clearly see outlying samples.

![](data:image/jpeg;base64...)

**Hierarchical clustering**

*Tool/Hierarchical clustering* menu can be used to cluster
samples and highlight outliers (and
concordance of other samples) even further.

![](data:image/jpeg;base64...)

**Filtering outliers**

Now, when outliers are confirmed and easily viewed with the dendrogram
from the previous step, you can select the good samples
and extract them into another heatmap (by clicking *Tools/New Heat Map* or pressing *Ctrl+X*).

![](data:image/jpeg;base64...)

## 1.4 Differential gene expression

**Apllying *limma* tool**

Differential gene expression analysis can be carried out
with *Tool/Diffential Expression/limma* menu.
Choose *treatment* as a *Field*, with
*Untreated* and *LPS* as classes. Clicking *OK*
will call differential gene expression analysis method
with [*limma*](https://bioconductor.org/packages/limma) R package.

![](data:image/jpeg;base64...)

The rows can be ordered by decreasing *t*-statistic column to see which genes are the most
up-regulated upon LPS treatment.

![](data:image/png;base64...)

**Pathway analysis with FGSEA**

**Note**: Self-hosted Phantasus requires additional steps to make **FGSEA** work properly:
see section [3](#serving-phantasus).

The results of differential gene expression can be used for pathway enrichment analysis
with *FGSEA* tool.

Open *Tools/Pathway Analysis/Perform FGSEA*, then select Pathway database, which corresponds specimen used in dataset
(Mus Musculus in this example), ranking column and column with ENTREZID or Gene IDs.

![](data:image/png;base64...)

Clicking OK will open new tab with pathways table.

![](data:image/png;base64...)

Clicking on table row will provide additional information on pathway: pathway name, genes in pathway, leading edge.
You can save result of analysis in `TSV` format.

# 2 Advanced usage

## 2.1 Gene identifiers conversion with AnnotationDB

**Note**: Self-hosted Phantasus requires additional steps to make *AnnotationDB* work properly:
see section [3](#serving-phantasus).

AnnotationDB provides an opportunity to convert annotation columns in dataset. Open *Tools/Annotate/Annotate Rows/From Database*. Example: converting `ENTREZID` column in GSE53986 to `ENSEMBL`. Select *org.Mm.hg.sqlite* specimen database with
*Source column* – `Gene ID`,
*Source column type* – `ENTREZID`, and *Result column type* – `ENSEMBL`.

![](data:image/png;base64...)

Clicking *OK* will append a new column with correspoding `ENSEMBL` identifier to the gene annotation.

![](data:image/png;base64...)

## 2.2 Pathway analysis with Enrichr

The results of differential gene expression can be used, for example,
for pathway enrichment analysis with online tools such as
[MSigDB](software.broadinstitute.org/gsea/msigdb/compute_overlaps.jsp)
or [Enrichr](http://amp.pharm.mssm.edu/Enrichr/).

For ease of use Enrichr is integrated into Phantasus.
Open *Tools/Pathway Analysis/Submit to Enrichr* menu and select about top 200 genes up-regulated on LPS.
Also select *Gene symbol* as the column with gene symbols.

![](data:image/png;base64...)

Clicking *OK* will result in a new browser tab with Enrichr being opened with results
of pathway enrichment analysis.

![](data:image/png;base64...)

## 2.3 Metabolic network analysis with Shiny GAM

Another analysis integrated into Phantasus is metabolic network analysis
with [Shiny GAM](https://artyomovlab.wustl.edu/shiny/gam/).
After differential expression you can submit
the table with *limma* results using *Tools/Pathway Analysis/Sumbit to Shiny GAM* menu.

![](data:image/jpeg;base64...)

After successful submission, a new browser tab will be opened with *Shiny GAM* interface
and the submitted data.

![](data:image/jpeg;base64...)

## 2.4 GSEA enrichment plot

The results of pathway analysis with *FGSEA* can be used for generating enrichment plot.
Clicking on table row will provide you a list of *Gene IDs*.
![](data:image/png;base64...)
Copy the list, switch back to dataset tab and paste to search field.
![](data:image/png;base64...)
This will select the corresponding genes in dataset. Then proceed to *Tools/Plots/GSEA plot*
![](data:image/png;base64...)
Then use *Export to SVG* button to save plot in `.svg` format.
Also there are options to control orientation of the plot, the ranking column
and annotation.

## 2.5 Link sharing

Current progress on the dataset can be shared via link.
Go to *File/Get link to a dataset*.
This will provide you a link, to a current dataset.
![](data:image/png;base64...)
**Note**: The following warning about 30 days to live is not applicable to self-hosted Phantasus

## 2.6 Loading dataset options

There are three ways to upload a dataset into application:

* As a file from:
  + computer;
  + URL;
  + Dropbox.
* By GEO identifier:
  + with *Open file* interface;
  + with adding parameter `geo` to the link (*e.g.*, <http://localhost:8000/?geo=GSE27112>).
* By an identifier of a dataset saved on the server (see section [3.2](#preloaded-datasets))
  + with *Saved on server datasets*
  + with adding parameter `preloaded` to the link (*e.g.*, <http://localhost:8000/?preloaded=fileName>)

You can either open the dataset from the main page, or if you are already looking at some datasets and don’t want to lose your progress you can use *File/Open* (*Ctrl+O*), choose *Open dataset in new tab* and then select the open option.

![](data:image/jpeg;base64...)

# 3 Serving Phantasus

Some of Phantasus features require additional set up.

## 3.1 Options for `servePhantasus`

You can customise serving of the application by specifying following parameters:

* `host` and `port` (by default: `"0.0.0.0"` and `8000`);
* `cacheDir` (by default: `tempdir()`) – directory where downloaded datasets will be saved and reused in later sessions;
* `preloadedDir` (by default: `NULL`) – directory with `ExpressionSet` objects encoded in rda-files, that can be quickly loaded to application by name (see section [3.2](#preloaded-datasets));
* `openInBrowser` (by default `TRUE`).

## 3.2 Preloaded datasets

Preloaded datasets is a feature that allows quick access to frequently-accessed datasets
or to share them inside the research group.

To store dataset on a server, on nead to save list `ess` of `ExpressionSet` objects
into an RData file with `.rda` extension into a directory as specified in `servePhantasus`.

Let us preprocess and save `GSE14308` dataset:

```
library(GEOquery)
library(limma)
gse14308 <- getGEO("GSE14308", AnnotGPL = TRUE)[[1]]
gse14308$condition <- sub("-.*$", "", gse14308$title)
pData(gse14308) <- pData(gse14308)[, c("title", "geo_accession", "condition")]
gse14308 <- gse14308[, order(gse14308$condition)]

fData(gse14308) <- fData(gse14308)[, c("Gene ID", "Gene symbol")]
exprs(gse14308) <- normalizeBetweenArrays(log2(exprs(gse14308)+1), method="quantile")

ess <- list(GSE14308_norm=gse14308)

preloadedDir <- tempdir()

save(ess, file=file.path(preloadedDir, "GSE14308_norm.rda"))
```

Next we can serve Phantasus with set `preloadedDir` option:

```
servePhantasus(preloadedDir=preloadedDir)
```

There you can either put `GSE14308_norm` name when using open option *Saved on server datasets* or just
open by specifying the name in URL: <http://localhost:8000/?preloaded=GSE14308_norm>.

![](data:image/png;base64...)

## 3.3 Support for RNA-seq datasets

Phantasus supports loading RNA-seq datasets from GEO using
gene expression counts as computed by [ARCHS4 project](http://amp.pharm.mssm.edu/archs4/index.html).
To make it work one need to download gene level expression from
the [Download](http://amp.pharm.mssm.edu/archs4/download.html) section. The
downloaded files `human_matrix.h5` and `mouse_matrix.h5` should be placed
into Phantasus cache under archs4 folder.
Or you can call

```
updateARCHS4(cacheDir=cacheDir)
```

## 3.4 Pathway database for FGSEA

*FGSEA* requires pathway database in `.rds` files under `<cacheDir>/fgsea` folder.
Pathway database is an `.rds` file containing dataframe with columns: `geneID`, `pathName`, `geneSymbol`. You can see an example dataframe by entering:

```
data("fgseaExample", package="phantasus")
head(fgseaExample)
```

```
##   geneID                                pathName geneSymbol
## 1  11461 5991955_Cell-cell_junction_organization       Actb
## 2  11465 5991955_Cell-cell_junction_organization      Actg1
## 3  12385 5991955_Cell-cell_junction_organization     Ctnna1
## 4  12388 5991955_Cell-cell_junction_organization     Ctnnd1
## 5  12550 5991955_Cell-cell_junction_organization       Cdh1
## 6  12552 5991955_Cell-cell_junction_organization      Cdh11
```

## 3.5 Annotation database for AnnotationDB tool

*AnnotationDB* tool requires annotation databases
under `<cacheDir>/annotationdb` folder. For example you can get
[Mus Musculus](https://bioconductor.org/packages/release/data/annotation/html/org.Mm.eg.db.html) database package from Bioconductor, extract `org.Mm.eg.sqlite`, and put it to `<cacheDir>/annotationdb` folder.

# 4 Feedback

You can see known issues and submit yours at GitHub:
(<https://github.com/ctlab/phantasus/issues>)

# 5 Acknowledgments

The authors are very thankful to Joshua Gould for developing Morpheus.

# 6 Citation

Please cite us as:

Kleverov M., Zenkova D., Kamenev V., Sablina R., Artyomov M., Sergushichev A. Phantasus:
web-application for visual and interactive gene expression analysis.
<https://https://www.biorxiv.org/content/10.1101/2022.12.10.519861> doi:
10.1101/2022.12.10.519861