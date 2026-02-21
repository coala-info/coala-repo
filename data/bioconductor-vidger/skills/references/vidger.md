# ViDGER Supplementary Material

Brandon Monier1,2, Adam McDermaid1,3,4, Jing Zhao5,6 and Qin Ma1,3,7,8

1South Dakota State University
2Department of Biology and Microbiology
3Bioinformatics and Mathematical Biosciences Lab
4Department of Mathematics and Statistics
5Population Health Group, Sanford Research
6Department of Internal Medicine, Sanford School of Medicine
7Department of Agronomy, Horticulture, and Plant Science
8BioSNTR

#### 2025-10-30

#### Abstract

Differential gene expression (DGE) is one of the most common applications of RNA-sequencing (RNA-seq) data. This process allows for the elucidation of differentially expressed genes (DEGs) across two or more conditions. Interpretation of the DGE results can be non-intuitive and time consuming due to the variety of formats based on the tool of choice and the numerous pieces of information provided in these results files. Here we present an R package, ViDGER (Visualization of Differential Gene Expression Results using R), which contains nine functions that generate information-rich visualizations for the interpretation of DGE results from three widely-used tools, Cuffdiff, DESeq2, and edgeR.

# Example S1: Installation and data examples

The stable version of this package is available on
[Bioconductor](https://bioconductor.org/packages/release/bioc/html/vidger.html). You can install it by running the following:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("vidger")
```

The latest **developmental** version of `ViDGER` can be installed via GitHub
using the `devtools` package:

```
if (!require("devtools")) install.packages("devtools")
devtools::install_github("btmonier/vidger", ref = "devel")
```

Once installed, you will have access to the following functions:

* `vsBoxplot()`
* `vsScatterPlot()`
* `vsScatterMatrix()`
* `vsDEGMatrix()`
* `vsMAPlot()`
* `vsMAMatrix()`
* `vsVolcano()`
* `vsVolcanoMatrix()`
* `vsFourWay()`

Further explanation will be given to how these functions work later on in the
documentation. For the following examples, three toy data sets will be used:
`df.cuff`, `df.deseq`, and `df.edger`. Each of these data sets reflect the
three RNA-seq analyses this package covers. These can be loaded in the R
workspace by using the following command:

```
data(<data_set>)
```

Where `<data_set>` is one of the previously mentioned data sets. Some of the
recurring elements that are found in each of these functions are the `type`
and `d.factor` arguments. The `type` argument tells the function how to
process the data for each analytical type (i.e. `"cuffdiff"`, `"deseq"`, or
`"edger"`). The `d.factor` argument is used specifically for `DESeq2` objects
which we will discuss in the DESeq2 section. All other arguments are discussed
in further detail by looking at the respective help file for each functions
(i.e. `?vsScatterPlot`).

## An overview of the data used

As mentioned earlier, three toy data sets are included with this package. In
addition to these data sets, 5 “real-world” data sets were also used. All
real-world data used is currently unpublished from ongoing collaborations.
Summaries of this data can be found in the following tables:

Table 1: An overview of the toy data sets included in this package. In this
table, each data set is summarized in terms of what analytical software was
used, organism ID, experimental layout (replicates and treatments), number of
transcripts (IDs), and size of the data object in terms of megabytes (MB).

| Data | Software | Organism | Reps | Treat. | IDs | Size (MB) |
| --- | --- | --- | --- | --- | --- | --- |
| `df.cuff` | CuffDiff | *H* | 2 | 3 | 1200 | 0.2 |
|  |  | *sapiens* |  |  |  |  |
| `df.deseq` | DESeq2 | *D.* | 2 | 3 | 29391 | 2.3 |
|  |  | *melanogaster* |  |  |  |  |
| `df.deseq` | edgeR | *A.* | 2 | 3 | 724 | 0.1 |
|  |  | *thaliana* |  |  |  |  |

Table 2: “Real-world” (RW) data set statistics. To test the reliability of
our package, real data was used from human collections and several plant
samples. Each data set is summarized in terms of organism ID, number of
experimental samples (n), experimental conditions, and number of transcripts (
IDs).

| Data | Organism | n | Exp. Conditions | IDs |
| --- | --- | --- | --- | --- |
| RW-1 | *H.* | 10 | Two treatment dosages taken at two | 198002 |
|  | *sapiens* |  | time points and one control sample |  |
|  |  |  | taken at one time point |  |
| RW-2 | *M.* | 24 | Two phenotypes taken at four time | 63517 |
|  | *domestia* |  | points (three replicates each) |  |
| RW-3 | *V.* | 6 | Two conditions (three replicates | 59262 |
|  | *ripria*: |  | each). |  |
|  | bud |  |  |  |
| RW-4 | *V.* | 6 | Two conditions (three replicates | 17962 |
|  | *ripria*: |  | each). |  |
|  | shoot-tip |  |  |  |
|  | (7 days) |  |  |  |
| RW-5 | *V.* | 6 | Two conditions (three replicates | 19064 |
|  | *ripria*: |  | each). |  |
|  | shoot-tip |  |  |  |
|  | (21 days) |  |  |  |

# Example S2: Creating box plots

Box plots are a useful way to determine the distribution of data. In this case
we can determine the distribution of FPKM or CPM values by using the
`vsBoxPlot()` function. This function allows you to extract necessary
results-based data from analytical objects to create a box plot comparing
\(log\_{10}\) (FPKM or CPM) distributions for experimental treatments.

## With Cuffdiff

```
vsBoxPlot(
    data = df.cuff, d.factor = NULL, type = 'cuffdiff', title = TRUE,
    legend = TRUE, grid = TRUE
)
```

![A box plot example using the `vsBoxPlot()` function with  `cuffdiff` data. In this example, FPKM distributions for each treatment within  an experiment are shown in the form of a box and whisker plot.](data:image/png;base64...)

Figure 1: A box plot example using the `vsBoxPlot()` function with
`cuffdiff` data. In this example, FPKM distributions for each treatment within
an experiment are shown in the form of a box and whisker plot.

## With DESeq2

```
vsBoxPlot(
    data = df.deseq, d.factor = 'condition', type = 'deseq',
    title = TRUE, legend = TRUE, grid = TRUE
)
```

![A box plot example using the `vsBoxPlot()` function with  `DESeq2` data. In this example, FPKM distributions for each treatment within  an experiment are shown in the form of a box and whisker plot.](data:image/png;base64...)

Figure 2: A box plot example using the `vsBoxPlot()` function with
`DESeq2` data. In this example, FPKM distributions for each treatment within
an experiment are shown in the form of a box and whisker plot.

## With edgeR

```
vsBoxPlot(
    data = df.edger, d.factor = NULL, type = 'edger',
    title = TRUE, legend = TRUE, grid = TRUE
)
```

![A box plot example using the `vsBoxPlot()` function with `edgeR`  data. In this example, CPM distributions for each treatment within an  experiment are shown in the form of a box and whisker plot](data:image/png;base64...)

Figure 3: A box plot example using the `vsBoxPlot()` function with `edgeR`
data. In this example, CPM distributions for each treatment within an
experiment are shown in the form of a box and whisker plot

## Aesthetic variants to box plots

`vsBoxPlot()` can allow for different iterations to showcase data
distribution. These changes can be implemented using the `aes` parameter.
Currently, there are 6 different variants:

* `box`: standard box plot
* `violin`: violin plot
* `boxdot`: box plot with dot plot overlay
* `viodot`: violin plot with dot plot overlay
* `viosumm`: violin plot with summary stats overlay
* `notch`: box plot with notch

### `box` variant

```
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "box"
)
```

![A box plot example using the `aes` parameter: `box`.](data:image/png;base64...)

Figure 4: A box plot example using the `aes` parameter: `box`

### `violin` variant

```
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "violin"
)
```

![A box plot example using the `aes` parameter: `violin`.](data:image/png;base64...)

Figure 5: A box plot example using the `aes` parameter: `violin`

### `boxdot` variant

```
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "boxdot"
)
```

![A box plot example using the `aes` parameter: `boxdot`.](data:image/png;base64...)

Figure 6: A box plot example using the `aes` parameter: `boxdot`

### `viodot` variant

```
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "viodot"
)
```

![A box plot example using the `aes` parameter: `viodot`.](data:image/png;base64...)

Figure 7: A box plot example using the `aes` parameter: `viodot`

### `viosumm` variant

```
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "viosumm"
)
```

![A box plot example using the `aes` parameter: `viosumm`.](data:image/png;base64...)

Figure 8: A box plot example using the `aes` parameter: `viosumm`

### `notch` variant

```
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "notch"
)
```

![A box plot example using the `aes` parameter: `notch`.](data:image/png;base64...)

Figure 9: A box plot example using the `aes` parameter: `notch`

## Color palette variants to box plots

In addition to aesthetic changes, the fill color of each variant can
also be changed. This can be implemented by modifiying the `fill.color`
parameter.

The palettes that can be used for this parameter are based off of the
palettes found in the `RColorBrewer`
[package.](https://cran.r-project.org/web/packages/RColorBrewer/RColorBrewer.pdf) A visual list of all the palettes can be found
[here.](http://www.r-graph-gallery.com/38-rcolorbrewers-palettes/)

### Color variant example 1

```
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "box", fill.color = "RdGy"
)
```

![Color variant 1. A box plot example using the `fill.color`  parameter: `RdGy`.](data:image/png;base64...)

Figure 10: Color variant 1
A box plot example using the `fill.color`
parameter: `RdGy`.

### Color variant example 2

```
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "viosumm", fill.color = "Paired"
)
```

![Color variant 2. A violin plot example using the `fill.color`  parameter: `Paired` with the `aes` parameter: `viosumm`.](data:image/png;base64...)

Figure 11: Color variant 2
A violin plot example using the `fill.color`
parameter: `Paired` with the `aes` parameter: `viosumm`.

### Color variant example 3

```
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "notch", fill.color = "Greys"
)
```

![Color variant 3. A notched box plot example using the `fill.color`  parameter: `Greys` with the `aes` parameter: `notch`. Using these parameters, we can also generate grey-scale plots.](data:image/png;base64...)

Figure 12: Color variant 3
A notched box plot example using the `fill.color`
parameter: `Greys` with the `aes` parameter: `notch`. Using these parameters,
we can also generate grey-scale plots.

# Example S3: Creating scatter plots

This example will look at a basic scatter plot function, `vsScatterPlot()`.
This function allows you to visualize comparisons of \(log\_{10}\) values of
either FPKM or CPM measurements of two treatments depending on analytical type.

## With Cuffdiff

```
vsScatterPlot(
    x = 'hESC', y = 'iPS', data = df.cuff, type = 'cuffdiff',
    d.factor = NULL, title = TRUE, grid = TRUE
)
```

![A scatterplot example using the `vsScatterPlot()` function with  `Cuffdiff` data. In this visualization, $log_{10}$ comparisons are made of  fragments per kilobase of transcript per million mapped reads (FPKM)  measurments. The dashed line represents regression line for the comparison.](data:image/png;base64...)

Figure 13: A scatterplot example using the `vsScatterPlot()` function with
`Cuffdiff` data. In this visualization, \(log\_{10}\) comparisons are made of
fragments per kilobase of transcript per million mapped reads (FPKM)
measurments. The dashed line represents regression line for the comparison.

## With DESeq2

```
vsScatterPlot(
    x = 'treated_paired.end', y = 'untreated_paired.end',
    data = df.deseq, type = 'deseq', d.factor = 'condition',
    title = TRUE, grid = TRUE
)
```

![A scatterplot example using the `vsScatterPlot()` function with  `DESeq2` data. In this visualization, $log_{10}$ comparisons are made of  fragments per kilobase of transcript per million mapped reads (FPKM)  measurments. The dashed line represents regression line for the comparison.](data:image/png;base64...)

Figure 14: A scatterplot example using the `vsScatterPlot()` function with
`DESeq2` data. In this visualization, \(log\_{10}\) comparisons are made of
fragments per kilobase of transcript per million mapped reads (FPKM)
measurments. The dashed line represents regression line for the comparison.

## With edgeR

```
vsScatterPlot(
    x = 'WM', y = 'MM', data = df.edger, type = 'edger',
    d.factor = NULL, title = TRUE, grid = TRUE
)
```

![A scatterplot example using the `vsScatterPlot()` function with  `edgeR` data. In this visualization, $log_{10}$ comparisons are made of  fragments per kilobase of transcript per million mapped reads (FPKM)  measurments. The dashed line represents regression line for the comparison.](data:image/png;base64...)

Figure 15: A scatterplot example using the `vsScatterPlot()` function with
`edgeR` data. In this visualization, \(log\_{10}\) comparisons are made of
fragments per kilobase of transcript per million mapped reads (FPKM)
measurments. The dashed line represents regression line for the comparison.

# Example S4: Creating scatter plot matrices

This example will look at an extension of the `vsScatterPlot()` function which
is `vsScatterMatrix()`. This function will create a matrix of all possible
comparisons of treatments within an experiment with additional info.

## With Cuffdiff

```
vsScatterMatrix(
    data = df.cuff, d.factor = NULL, type = 'cuffdiff',
    comp = NULL, title = TRUE, grid = TRUE, man.title = NULL
)
```

![A scatterplot matrix example using the `vsScatterMatrix()`  function with `Cuffdiff` data. Similar to the scatterplot function, this  visualization allows for all comparisons to be made within an experiment. In  addition to the scatterplot visuals, FPKM distributions (histograms) and  correlation (Corr) values are generated.](data:image/png;base64...)

Figure 16: A scatterplot matrix example using the `vsScatterMatrix()`
function with `Cuffdiff` data. Similar to the scatterplot function, this
visualization allows for all comparisons to be made within an experiment. In
addition to the scatterplot visuals, FPKM distributions (histograms) and
correlation (Corr) values are generated.

## With DESeq2

```
vsScatterMatrix(
    data = df.deseq, d.factor = 'condition', type = 'deseq',
    comp = NULL, title = TRUE, grid = TRUE, man.title = NULL
)
```

![A scatterplot matrix example using the `vsScatterMatrix()`  function with `DESeq2` data. Similar to the scatterplot function, this  visualization allows for all comparisons to be made within an experiment. In  addition to the scatterplot visuals, FPKM distributions (histograms) and  correlation (Corr) values are generated.](data:image/png;base64...)

Figure 17: A scatterplot matrix example using the `vsScatterMatrix()`
function with `DESeq2` data. Similar to the scatterplot function, this
visualization allows for all comparisons to be made within an experiment. In
addition to the scatterplot visuals, FPKM distributions (histograms) and
correlation (Corr) values are generated.

## With edgeR

```
vsScatterMatrix(
    data = df.edger, d.factor = NULL, type = 'edger', comp = NULL,
    title = TRUE, grid = TRUE, man.title = NULL
)
```

![A scatterplot matrix example using the `vsScatterMatrix()`  function with `edgeR` data. Similar to the scatterplot function, this  visualization allows for all comparisons to be made within an experiment. In  addition to the scatterplot visuals, FPKM distributions (histograms) and  correlation (Corr) values are generated.](data:image/png;base64...)

Figure 18: A scatterplot matrix example using the `vsScatterMatrix()`
function with `edgeR` data. Similar to the scatterplot function, this
visualization allows for all comparisons to be made within an experiment. In
addition to the scatterplot visuals, FPKM distributions (histograms) and
correlation (Corr) values are generated.

# Example S5: Creating differential gene expression matrices

Using the `vsDEGMatrix()` function allows the user to visualize the number of
differentially expressed genes (DEGs) at a given adjusted *p*-value (`padj =`
) for each experimental treatment level. Higher color intensity correlates to
a higher number of DEGs.

## With Cuffdiff

```
vsDEGMatrix(
    data = df.cuff, padj = 0.05, d.factor = NULL, type = 'cuffdiff',
    title = TRUE, legend = TRUE, grid = TRUE
)
```

![A matrix of differentially expressed genes (DEGs) at a given  *p*-value using the `vsDEGMatrix()` function with `Cuffdiff` data. With this  function, the user is able to visualize the number of DEGs ata given adjusted  *p*-value for each experimental treatment level. Higher color intensity  correlates to a higher number of DEGs.](data:image/png;base64...)

Figure 19: A matrix of differentially expressed genes (DEGs) at a given
*p*-value using the `vsDEGMatrix()` function with `Cuffdiff` data. With this
function, the user is able to visualize the number of DEGs ata given adjusted
*p*-value for each experimental treatment level. Higher color intensity
correlates to a higher number of DEGs.

## With DESeq2

```
vsDEGMatrix(
    data = df.deseq, padj = 0.05, d.factor = 'condition',
    type = 'deseq', title = TRUE, legend = TRUE, grid = TRUE
)
```

![A matrix of differentially expressed genes (DEGs) at a given  *p*-value using the `vsDEGMatrix()` function with `DESeq2` data. With this  function, the user is able to visualize the number of DEGs ata given adjusted  *p*-value for each experimental treatment level. Higher color intensity  correlates to a higher number of DEGs.](data:image/png;base64...)

Figure 20: A matrix of differentially expressed genes (DEGs) at a given
*p*-value using the `vsDEGMatrix()` function with `DESeq2` data. With this
function, the user is able to visualize the number of DEGs ata given adjusted
*p*-value for each experimental treatment level. Higher color intensity
correlates to a higher number of DEGs.

## With edgeR

```
vsDEGMatrix(
    data = df.edger, padj = 0.05, d.factor = NULL, type = 'edger',
    title = TRUE, legend = TRUE, grid = TRUE
)
```

![A matrix of differentially expressed genes (DEGs) at a given  *p*-value using the `vsDEGMatrix()` function with `edgeR` data. With this  function, the user is able to visualize the number of DEGs ata given adjusted  *p*-value for each experimental treatment level. Higher color intensity  correlates to a higher number of DEGs.](data:image/png;base64...)

Figure 21: A matrix of differentially expressed genes (DEGs) at a given
*p*-value using the `vsDEGMatrix()` function with `edgeR` data. With this
function, the user is able to visualize the number of DEGs ata given adjusted
*p*-value for each experimental treatment level. Higher color intensity
correlates to a higher number of DEGs.

## Grey-scale DEG matrices

A grey-scale option is available for this function if you wish to use a
grey-to-white gradient instead of the classic blue-to-white gradient. This
can be invoked by setting the `grey.scale` parameter to `TRUE`.

```
vsDEGMatrix(data = df.deseq, d.factor = "condition", type = "deseq",
    grey.scale = TRUE
)
```

![](data:image/png;base64...)

# Example S6: Creating MA plots

`vsMAPlot()` visualizes the variance between two samples in terms of gene
expression values where logarithmic fold changes of count data are plotted
against mean counts. For more information on how each of the aesthetics are
plotted, please refer to the figure captions and Method S1.

## With Cuffdiff

```
vsMAPlot(
    x = 'iPS', y = 'hESC', data = df.cuff, d.factor = NULL,
    type = 'cuffdiff', padj = 0.05, y.lim = NULL, lfc = NULL,
    title = TRUE, legend = TRUE, grid = TRUE
)
```

![MA plot visualization using the `vsMAPLot()` function with  `Cuffdiff` data. LFCs are plotted mean counts to determine the variance  between two treatments in terms of gene expression. Blue nodes on the graph  represent statistically significant LFCs which are greater than a given value  than a user-defined LFC parameter. Green nodes indicate statistically  significant LFCs which are less than the user-defined LFC parameter. Gray  nodes are data points that are not statistically significant. Numerical values  in parantheses for each legend color indicate the number of transcripts that  meet the prior conditions. Triangular shapes represent values that exceed the  viewing area of the graph. Node size changes represent the magnitude of the  LFC values (i.e. larger shapes reflect larger LFC values). Dashed lines  indicate user-defined LFC values.](data:image/png;base64...)

Figure 22: MA plot visualization using the `vsMAPLot()` function with
`Cuffdiff` data. LFCs are plotted mean counts to determine the variance
between two treatments in terms of gene expression. Blue nodes on the graph
represent statistically significant LFCs which are greater than a given value
than a user-defined LFC parameter. Green nodes indicate statistically
significant LFCs which are less than the user-defined LFC parameter. Gray
nodes are data points that are not statistically significant. Numerical values
in parantheses for each legend color indicate the number of transcripts that
meet the prior conditions. Triangular shapes represent values that exceed the
viewing area of the graph. Node size changes represent the magnitude of the
LFC values (i.e. larger shapes reflect larger LFC values). Dashed lines
indicate user-defined LFC values.

## With DESeq2

```
vsMAPlot(
    x = 'treated_paired.end', y = 'untreated_paired.end',
    data = df.deseq, d.factor = 'condition', type = 'deseq',
    padj = 0.05, y.lim = NULL, lfc = NULL, title = TRUE,
    legend = TRUE, grid = TRUE
)
```

![MA plot visualization using the `vsMAPLot()` function with  `DESeq2` data. LFCs are plotted mean counts to determine the variance between  two treatments in terms of gene expression. Blue nodes on the graph represent  statistically significant LFCs which are greater than a given value than a  user-defined LFC parameter. Green nodes indicate statistically significant LFCs which are less than the user-defined LFC parameter. Gray nodes are data  points that are not statistically significant. Numerical values in parantheses  for each legend color indicate the number of transcripts that meet the prior  conditions. Triangular shapes represent values that exceed the viewing area of  the graph. Node size changes represent the magnitude of the LFC values (i.e.  larger shapes reflect larger LFC values). Dashed lines indicate user-defined  LFC values.](data:image/png;base64...)

Figure 23: MA plot visualization using the `vsMAPLot()` function with
`DESeq2` data. LFCs are plotted mean counts to determine the variance between
two treatments in terms of gene expression. Blue nodes on the graph represent
statistically significant LFCs which are greater than a given value than a
user-defined LFC parameter. Green nodes indicate statistically significant
LFCs which are less than the user-defined LFC parameter. Gray nodes are data
points that are not statistically significant. Numerical values in parantheses
for each legend color indicate the number of transcripts that meet the prior
conditions. Triangular shapes represent values that exceed the viewing area of
the graph. Node size changes represent the magnitude of the LFC values (i.e.
larger shapes reflect larger LFC values). Dashed lines indicate user-defined
LFC values.

## With edgeR

```
vsMAPlot(
    x = 'WW', y = 'MM', data = df.edger, d.factor = NULL,
    type = 'edger', padj = 0.05, y.lim = NULL, lfc = NULL,
    title = TRUE, legend = TRUE, grid = TRUE
)
```

![MA plot visualization using the `vsMAPLot()` function with  `edgeR` data. LFCs are plotted mean counts to determine the variance between  two treatments in terms of gene expression. Blue nodes on the graph represent  statistically significant LFCs which are greater than a given value than a  user-defined LFC parameter. Green nodes indicate statistically significant  LFCs which are less than the user-defined LFC parameter. Gray nodes are data  points that are not statistically significant. Numerical values in parantheses  for each legend color indicate the number of transcripts that meet the prior  conditions. Triangular shapes represent values that exceed the viewing area of  the graph. Node size changes represent the magnitude of the LFC values (i.e.  larger shapes reflect larger LFC values). Dashed lines indicate user-defined  LFC values.](data:image/png;base64...)

Figure 24: MA plot visualization using the `vsMAPLot()` function with
`edgeR` data. LFCs are plotted mean counts to determine the variance between
two treatments in terms of gene expression. Blue nodes on the graph represent
statistically significant LFCs which are greater than a given value than a
user-defined LFC parameter. Green nodes indicate statistically significant
LFCs which are less than the user-defined LFC parameter. Gray nodes are data
points that are not statistically significant. Numerical values in parantheses
for each legend color indicate the number of transcripts that meet the prior
conditions. Triangular shapes represent values that exceed the viewing area of
the graph. Node size changes represent the magnitude of the LFC values (i.e.
larger shapes reflect larger LFC values). Dashed lines indicate user-defined
LFC values.

# Example S7: Creating MA plot matrices

Similar to a scatter plot matrix, `vsMAMatrix()` will produce visualizations
for all comparisons within your data set. For more information on how the
aesthetics are plotted in these visualizations, please refer to the figure
caption and Method S1.

## With Cuffdiff

```
 vsMAMatrix(
    data = df.cuff, d.factor = NULL, type = 'cuffdiff',
    padj = 0.05, y.lim = NULL, lfc = 1, title = TRUE,
    grid = TRUE, counts = TRUE, data.return = FALSE
)
```

![A MA plot matrix using the `vsMAMatrix()` function with `Cuffdiff`  data. Similar to the `vsMAPlot()` function, `vsMAMatrix()` will generate a  matrix of MA plots for all comparisons within an experiment. LFCs are plotted  mean counts to determine the variance between two treatments in terms of gene  expression. Blue nodes on the graph represent statistically significant LFCs  which are greater than a given value than a user-defined LFC parameter. Green  nodes indicate statistically significant LFCs which are less than the  user-defined LFC parameter. Gray nodes are data points that are not  statistically significant. Numerical values in parantheses for each legend  color indicate the number of transcripts that meet the prior conditions.  Triangular shapes represent values that exceed the viewing area of the graph.  Node size changes represent the magnitude of the LFC values (i.e. larger  shapes reflect larger LFC values). Dashed lines indicate user-defined LFC  values.](data:image/png;base64...)

Figure 25: A MA plot matrix using the `vsMAMatrix()` function with `Cuffdiff`
data. Similar to the `vsMAPlot()` function, `vsMAMatrix()` will generate a
matrix of MA plots for all comparisons within an experiment. LFCs are plotted
mean counts to determine the variance between two treatments in terms of gene
expression. Blue nodes on the graph represent statistically significant LFCs
which are greater than a given value than a user-defined LFC parameter. Green
nodes indicate statistically significant LFCs which are less than the
user-defined LFC parameter. Gray nodes are data points that are not
statistically significant. Numerical values in parantheses for each legend
color indicate the number of transcripts that meet the prior conditions.
Triangular shapes represent values that exceed the viewing area of the graph.
Node size changes represent the magnitude of the LFC values (i.e. larger
shapes reflect larger LFC values). Dashed lines indicate user-defined LFC
values.

## With DESeq2

```
vsMAMatrix(
    data = df.deseq, d.factor = 'condition', type = 'deseq',
    padj = 0.05, y.lim = NULL, lfc = 1, title = TRUE,
    grid = TRUE, counts = TRUE, data.return = FALSE
)
```

![A MA plot matrix using the `vsMAMatrix()` function with `DESeq2`  data. Similar to the `vsMAPlot()` function, `vsMAMatrix()` will generate a  matrix of MA plots for all comparisons within an experiment. LFCs are plotted  mean counts to determine the variance between two treatments in terms of gene  expression. Blue nodes on the graph represent statistically significant LFCs  which are greater than a given value than a user-defined LFC parameter. Green  nodes indicate statistically significant LFCs which are less than the  user-defined LFC parameter. Gray nodes are data points that are not  statistically significant. Numerical values in parantheses for each legend  color indicate the number of transcripts that meet the prior conditions.  Triangular shapes represent values that exceed the viewing area of the graph.  Node size changes represent the magnitude of the LFC values (i.e. larger  shapes reflect larger LFC values). Dashed lines indicate user-defined LFC  values.](data:image/png;base64...)

Figure 26: A MA plot matrix using the `vsMAMatrix()` function with `DESeq2`
data. Similar to the `vsMAPlot()` function, `vsMAMatrix()` will generate a
matrix of MA plots for all comparisons within an experiment. LFCs are plotted
mean counts to determine the variance between two treatments in terms of gene
expression. Blue nodes on the graph represent statistically significant LFCs
which are greater than a given value than a user-defined LFC parameter. Green
nodes indicate statistically significant LFCs which are less than the
user-defined LFC parameter. Gray nodes are data points that are not
statistically significant. Numerical values in parantheses for each legend
color indicate the number of transcripts that meet the prior conditions.
Triangular shapes represent values that exceed the viewing area of the graph.
Node size changes represent the magnitude of the LFC values (i.e. larger
shapes reflect larger LFC values). Dashed lines indicate user-defined LFC
values.

## With edgeR

```
vsMAMatrix(
    data = df.edger, d.factor = NULL, type = 'edger',
    padj = 0.05, y.lim = NULL, lfc = 1, title = TRUE,
    grid = TRUE, counts = TRUE, data.return = FALSE
)
```

![A MA plot matrix using the `vsMAMatrix()` function with `edgeR`  data. Similar to the `vsMAPlot()` function, `vsMAMatrix()` will generate a  matrix of MA plots for all comparisons within an experiment. LFCs are plotted  mean counts to determine the variance between two treatments in terms of gene  expression. Blue nodes on the graph represent statistically significant LFCs  which are greater than a given value than a user-defined LFC parameter. Green  nodes indicate statistically significant LFCs which are less than the  user-defined LFC parameter. Gray nodes are data points that are not  statistically significant. Numerical values in parantheses for each legend  color indicate the number of transcripts that meet the prior conditions.  Triangular shapes represent values that exceed the viewing area of the graph.  Node size changes represent the magnitude of the LFC values (i.e. larger  shapes reflect larger LFC values). Dashed lines indicate user-defined LFC  values.](data:image/png;base64...)

Figure 27: A MA plot matrix using the `vsMAMatrix()` function with `edgeR`
data. Similar to the `vsMAPlot()` function, `vsMAMatrix()` will generate a
matrix of MA plots for all comparisons within an experiment. LFCs are plotted
mean counts to determine the variance between two treatments in terms of gene
expression. Blue nodes on the graph represent statistically significant LFCs
which are greater than a given value than a user-defined LFC parameter. Green
nodes indicate statistically significant LFCs which are less than the
user-defined LFC parameter. Gray nodes are data points that are not
statistically significant. Numerical values in parantheses for each legend
color indicate the number of transcripts that meet the prior conditions.
Triangular shapes represent values that exceed the viewing area of the graph.
Node size changes represent the magnitude of the LFC values (i.e. larger
shapes reflect larger LFC values). Dashed lines indicate user-defined LFC
values.

# Example S8: Creating volcano plots

The next few visualizations will focus on ways to display differential gene
expression between two or more treatments. Volcano plots visualize the variance
between two samples in terms of gene expression values where the \(-log\_{10}\) of
calculated *p*-values (y-axis) are a plotted against the \(log\_2\) changes
(x-axis). These plots can be visualized with the `vsVolcano()` function.
For more information on how each of the aesthetics are plotted, please refer
to the figure captions and Method S1.

## With Cuffdiff

```
vsVolcano(
    x = 'iPS', y = 'hESC', data = df.cuff, d.factor = NULL,
    type = 'cuffdiff', padj = 0.05, x.lim = NULL, lfc = NULL,
    title = TRUE, legend = TRUE, grid = TRUE, data.return = FALSE
)
```

![A volcano plot example using the `vsVolcano()` function with  `Cuffdiff` data. In this visualization, comparisons are made between the  $-log_{10}$ *p*-value versus the $log_2$ fold change (LFC) between two  treatments. Blue nodes on the graph represent statistically significant LFCs  which are greater than a given value than a user-defined LFC parameter. Green  nodes indicate statistically significant LFCs which are less than the  user-defined LFC parameter. Gray nodes are data points that are not  statistically significant. Numerical values in parantheses for each legend  color indicate the number of transcripts that meet the prior conditions. Left  and right brackets (< and >) represent values that exceed the viewing area of  the graph. Node size changes represent the magnitude of the LFC values (i.e.  larger shapes reflect larger LFC values). Vertical and horizontal lines  indicate user-defined LFC and adjusted *p*-values, respectively.](data:image/png;base64...)

Figure 28: A volcano plot example using the `vsVolcano()` function with
`Cuffdiff` data. In this visualization, comparisons are made between the
\(-log\_{10}\) *p*-value versus the \(log\_2\) fold change (LFC) between two
treatments. Blue nodes on the graph represent statistically significant LFCs
which are greater than a given value than a user-defined LFC parameter. Green
nodes indicate statistically significant LFCs which are less than the
user-defined LFC parameter. Gray nodes are data points that are not
statistically significant. Numerical values in parantheses for each legend
color indicate the number of transcripts that meet the prior conditions. Left
and right brackets (< and >) represent values that exceed the viewing area of
the graph. Node size changes represent the magnitude of the LFC values (i.e.
larger shapes reflect larger LFC values). Vertical and horizontal lines
indicate user-defined LFC and adjusted *p*-values, respectively.

## With DESeq2

```
vsVolcano(
    x = 'treated_paired.end', y = 'untreated_paired.end',
    data = df.deseq, d.factor = 'condition', type = 'deseq',
    padj = 0.05, x.lim = NULL, lfc = NULL, title = TRUE,
    legend = TRUE, grid = TRUE, data.return = FALSE
)
```

![A volcano plot example using the `vsVolcano()` function with  `DESeq2` data. In this visualization, comparisons are made between the  $-log_{10}$ *p*-value versus the $log_2$ fold change (LFC) between two  treatments. Blue nodes on the graph represent statistically significant LFCs  which are greater than a given value than a user-defined LFC parameter. Green  nodes indicate statistically significant LFCs which are less than the  user-defined LFC parameter. Gray nodes are data points that are not  statistically significant. Numerical values in parantheses for each legend  color indicate the number of transcripts that meet the prior conditions. Left  and right brackets (< and >) represent values that exceed the viewing area of  the graph. Node size changes represent the magnitude of the LFC values (i.e.  larger shapes reflect larger LFC values). Vertical and horizontal lines  indicate user-defined LFC and adjusted *p*-values, respectively.](data:image/png;base64...)

Figure 29: A volcano plot example using the `vsVolcano()` function with
`DESeq2` data. In this visualization, comparisons are made between the
\(-log\_{10}\) *p*-value versus the \(log\_2\) fold change (LFC) between two
treatments. Blue nodes on the graph represent statistically significant LFCs
which are greater than a given value than a user-defined LFC parameter. Green
nodes indicate statistically significant LFCs which are less than the
user-defined LFC parameter. Gray nodes are data points that are not
statistically significant. Numerical values in parantheses for each legend
color indicate the number of transcripts that meet the prior conditions. Left
and right brackets (< and >) represent values that exceed the viewing area of
the graph. Node size changes represent the magnitude of the LFC values (i.e.
larger shapes reflect larger LFC values). Vertical and horizontal lines
indicate user-defined LFC and adjusted *p*-values, respectively.

## With edgeR

```
vsVolcano(
    x = 'WW', y = 'MM', data = df.edger, d.factor = NULL,
    type = 'edger', padj = 0.05, x.lim = NULL, lfc = NULL,
    title = TRUE, legend = TRUE, grid = TRUE, data.return = FALSE
)
```

![A volcano plot example using the `vsVolcano()` function with  `edgeR` data. In this visualization, comparisons are made between the  $-log_{10}$ *p*-value versus the $log_2$ fold change (LFC) between two  treatments. Blue nodes on the graph represent statistically significant LFCs  which are greater than a given value than a user-defined LFC parameter. Green  nodes indicate statistically significant LFCs which are less than the  user-defined LFC parameter. Gray nodes are data points that are not  statistically significant. Numerical values in parantheses for each legend  color indicate the number of transcripts that meet the prior conditions. Left  and right brackets (< and >) represent values that exceed the viewing area of  the graph. Node size changes represent the magnitude of the LFC values (i.e.  larger shapes reflect larger LFC values). Vertical and horizontal lines  indicate user-defined LFC and adjusted *p*-values, respectively.](data:image/png;base64...)

Figure 30: A volcano plot example using the `vsVolcano()` function with
`edgeR` data. In this visualization, comparisons are made between the
\(-log\_{10}\) *p*-value versus the \(log\_2\) fold change (LFC) between two
treatments. Blue nodes on the graph represent statistically significant LFCs
which are greater than a given value than a user-defined LFC parameter. Green
nodes indicate statistically significant LFCs which are less than the
user-defined LFC parameter. Gray nodes are data points that are not
statistically significant. Numerical values in parantheses for each legend
color indicate the number of transcripts that meet the prior conditions. Left
and right brackets (< and >) represent values that exceed the viewing area of
the graph. Node size changes represent the magnitude of the LFC values (i.e.
larger shapes reflect larger LFC values). Vertical and horizontal lines
indicate user-defined LFC and adjusted *p*-values, respectively.

# Example S9: Creating volcano plot matrices

Similar to the prior matrix functions, `vsVolcanoMatrix()` will produce
visualizations for all comparisons within your data set. For more information
on how the aesthetics are plotted in these visualizations, please refer to the
figure caption and Method S1.

## With Cuffdiff

```
vsVolcanoMatrix(
    data = df.cuff, d.factor = NULL, type = 'cuffdiff',
    padj = 0.05, x.lim = NULL, lfc = NULL, title = TRUE,
    legend = TRUE, grid = TRUE, counts = TRUE
)
```

![A volcano plot matrix using the `vsVolcanoMatrix()` function with  `Cuffdiff` data. Similar to the `vsVolcano()` function, `vsVolcanoMatrix()`  will generate a matrix of volcano plots for all comparisons within an  experiment. Comparisons are made between the $-log_{10}$ *p*-value versus the  $log_2$ fold change (LFC) between two treatments. Blue nodes on the graph  represent statistically significant LFCs which are greater than a given value  than a user-defined LFC parameter. Green nodes indicate statistically  significant LFCs which are less than the user-defined LFC parameter. Gray  nodes are data points that are not statistically significant. The blue and  green numbers in each facet represent the number of transcripts that meet the  criteria for blue and green nodes in each comparison. Left and right brackets  (< and >) represent values that exceed the viewing area of the graph. Node  size changes represent the magnitude of the LFC values (i.e. larger shapes  reflect larger LFC values). Vertical and horizontal lines indicate  user-defined LFC and adjusted *p*-values, respectively.](data:image/png;base64...)

Figure 31: A volcano plot matrix using the `vsVolcanoMatrix()` function with
`Cuffdiff` data. Similar to the `vsVolcano()` function, `vsVolcanoMatrix()`
will generate a matrix of volcano plots for all comparisons within an
experiment. Comparisons are made between the \(-log\_{10}\) *p*-value versus the
\(log\_2\) fold change (LFC) between two treatments. Blue nodes on the graph
represent statistically significant LFCs which are greater than a given value
than a user-defined LFC parameter. Green nodes indicate statistically
significant LFCs which are less than the user-defined LFC parameter. Gray
nodes are data points that are not statistically significant. The blue and
green numbers in each facet represent the number of transcripts that meet the
criteria for blue and green nodes in each comparison. Left and right brackets
(< and >) represent values that exceed the viewing area of the graph. Node
size changes represent the magnitude of the LFC values (i.e. larger shapes
reflect larger LFC values). Vertical and horizontal lines indicate
user-defined LFC and adjusted *p*-values, respectively.

## With DESeq2

```
vsVolcanoMatrix(
    data = df.deseq, d.factor = 'condition', type = 'deseq',
    padj = 0.05, x.lim = NULL, lfc = NULL, title = TRUE,
    legend = TRUE, grid = TRUE, counts = TRUE
)
```

![A volcano plot matrix using the `vsVolcanoMatrix()` function with  `DESeq2` data. Similar to the `vsVolcano()` function, `vsVolcanoMatrix()`  will generate a matrix of volcano plots for all comparisons within an  experiment. Comparisons are made between the $-log_{10}$ *p*-value versus the  $log_2$ fold change (LFC) between two treatments. Blue nodes on the graph  represent statistically significant LFCs which are greater than a given value  than a user-defined LFC parameter. Green nodes indicate statistically  significant LFCs which are less than the user-defined LFC parameter. Gray  nodes are data points that are not statistically significant. The blue and  green numbers in each facet represent the number of transcripts that meet the  criteria for blue and green nodes in each comparison. Left and right brackets  (< and >) represent values that exceed the viewing area of the graph. Node  size changes represent the magnitude of the LFC values (i.e. larger shapes  reflect larger LFC values). Vertical and horizontal lines indicate  user-defined LFC and adjusted *p*-values, respectively.](data:image/png;base64...)

Figure 32: A volcano plot matrix using the `vsVolcanoMatrix()` function with
`DESeq2` data. Similar to the `vsVolcano()` function, `vsVolcanoMatrix()`
will generate a matrix of volcano plots for all comparisons within an
experiment. Comparisons are made between the \(-log\_{10}\) *p*-value versus the
\(log\_2\) fold change (LFC) between two treatments. Blue nodes on the graph
represent statistically significant LFCs which are greater than a given value
than a user-defined LFC parameter. Green nodes indicate statistically
significant LFCs which are less than the user-defined LFC parameter. Gray
nodes are data points that are not statistically significant. The blue and
green numbers in each facet represent the number of transcripts that meet the
criteria for blue and green nodes in each comparison. Left and right brackets
(< and >) represent values that exceed the viewing area of the graph. Node
size changes represent the magnitude of the LFC values (i.e. larger shapes
reflect larger LFC values). Vertical and horizontal lines indicate
user-defined LFC and adjusted *p*-values, respectively.

## With edgeR

```
vsVolcanoMatrix(
    data = df.edger, d.factor = NULL, type = 'edger', padj = 0.05,
    x.lim = NULL, lfc = NULL, title = TRUE, legend = TRUE,
    grid = TRUE, counts = TRUE
)
```

![A volcano plot matrix using the `vsVolcanoMatrix()` function with  `edgeR` data. Similar to the `vsVolcano()` function, `vsVolcanoMatrix()`  will generate a matrix of volcano plots for all comparisons within an  experiment. Comparisons are made between the $-log_{10}$ *p*-value versus the  $log_2$ fold change (LFC) between two treatments. Blue nodes on the graph  represent statistically significant LFCs which are greater than a given value  than a user-defined LFC parameter. Green nodes indicate statistically  significant LFCs which are less than the user-defined LFC parameter. Gray  nodes are data points that are not statistically significant. The blue and  green numbers in each facet represent the number of transcripts that meet the  criteria for blue and green nodes in each comparison. Left and right brackets  (< and >) represent values that exceed the viewing area of the graph. Node  size changes represent the magnitude of the LFC values (i.e. larger shapes  reflect larger LFC values). Vertical and horizontal lines indicate  user-defined LFC and adjusted *p*-values, respectively.](data:image/png;base64...)

Figure 33: A volcano plot matrix using the `vsVolcanoMatrix()` function with
`edgeR` data. Similar to the `vsVolcano()` function, `vsVolcanoMatrix()`
will generate a matrix of volcano plots for all comparisons within an
experiment. Comparisons are made between the \(-log\_{10}\) *p*-value versus the
\(log\_2\) fold change (LFC) between two treatments. Blue nodes on the graph
represent statistically significant LFCs which are greater than a given value
than a user-defined LFC parameter. Green nodes indicate statistically
significant LFCs which are less than the user-defined LFC parameter. Gray
nodes are data points that are not statistically significant. The blue and
green numbers in each facet represent the number of transcripts that meet the
criteria for blue and green nodes in each comparison. Left and right brackets
(< and >) represent values that exceed the viewing area of the graph. Node
size changes represent the magnitude of the LFC values (i.e. larger shapes
reflect larger LFC values). Vertical and horizontal lines indicate
user-defined LFC and adjusted *p*-values, respectively.

# Example S10: Creating four way plots

To create four-way plots, the function, `vsFourWay()` is used. This plot
compares the \(log\_2\) fold changes between two samples and a ‘control’. For more
information on how each of the aesthetics are plotted, please refer to the
figure captions and Method S1.

## With Cuffdiff

```
vsFourWay(
    x = 'iPS', y = 'hESC', control = 'Fibroblasts', data = df.cuff,
    d.factor = NULL, type = 'cuffdiff', padj = 0.05, x.lim = NULL,
    y.lim = NULL, lfc = NULL, legend = TRUE, title = TRUE, grid = TRUE
)
```

![A four way plot visualization using the `vsFourWay()` function with  `Cuffdiff` data. In this example, LFCs comparisons between two treatments and a control are made. Blue nodes indicate statistically significant LFCs which  are greater than a given user-defined value for both x and y-axes. Green nodes  reflect statistically significant LFCs which are less than a user-defined  value for treatment y and greater than said value for treatment x. Similar to  green nodes, red nodes reflect statistically significant LFCs which are  greater than a user-defined vlaue treatment y and less than said value for  treatment x. Gray nodes are data points that are not statistically significant  for both x and y-axes. Triangular shapes indicate values which exceed the  viewing are for the graph. Size change reflects the magnitude of LFC values ( i.e. larger shapes reflect larger LFC values). Vertical and horizontal dashed  lines indicate user-defined LFC values.](data:image/png;base64...)

Figure 34: A four way plot visualization using the `vsFourWay()` function with
`Cuffdiff` data. In this example, LFCs comparisons between two treatments and
a control are made. Blue nodes indicate statistically significant LFCs which
are greater than a given user-defined value for both x and y-axes. Green nodes
reflect statistically significant LFCs which are less than a user-defined
value for treatment y and greater than said value for treatment x. Similar to
green nodes, red nodes reflect statistically significant LFCs which are
greater than a user-defined vlaue treatment y and less than said value for
treatment x. Gray nodes are data points that are not statistically significant
for both x and y-axes. Triangular shapes indicate values which exceed the
viewing are for the graph. Size change reflects the magnitude of LFC values (
i.e. larger shapes reflect larger LFC values). Vertical and horizontal dashed
lines indicate user-defined LFC values.

## With DESeq2

```
vsFourWay(
    x = 'treated_paired.end', y = 'untreated_single.read',
    control = 'untreated_paired.end', data = df.deseq,
    d.factor = 'condition', type = 'deseq', padj = 0.05, x.lim = NULL,
    y.lim = NULL, lfc = NULL, legend = TRUE, title = TRUE, grid = TRUE
)
```

![A four way plot visualization using the `vsFourWay()` function with  `DESeq2` data. In this example, LFCs comparisons between two treatments and a  control are made. Blue nodes indicate statistically significant LFCs which are  greater than a given user-defined value for both x and y-axes. Green nodes  reflect statistically significant LFCs which are less than a user-defined  value for treatment y and greater than said value for treatment x. Similar to  green nodes, red nodes reflect statistically significant LFCs which are  greater than a user-defined vlaue treatment y and less than said value for  treatment x. Gray nodes are data points that are not statistically significant  for both x and y-axes. Triangular shapes indicate values which exceed the  viewing are for the graph. Size change reflects the magnitude of LFC values ( i.e. larger shapes reflect larger LFC values). Vertical and horizontal dashed  lines indicate user-defined LFC values.](data:image/png;base64...)

Figure 35: A four way plot visualization using the `vsFourWay()` function with
`DESeq2` data. In this example, LFCs comparisons between two treatments and a
control are made. Blue nodes indicate statistically significant LFCs which are
greater than a given user-defined value for both x and y-axes. Green nodes
reflect statistically significant LFCs which are less than a user-defined
value for treatment y and greater than said value for treatment x. Similar to
green nodes, red nodes reflect statistically significant LFCs which are
greater than a user-defined vlaue treatment y and less than said value for
treatment x. Gray nodes are data points that are not statistically significant
for both x and y-axes. Triangular shapes indicate values which exceed the
viewing are for the graph. Size change reflects the magnitude of LFC values (
i.e. larger shapes reflect larger LFC values). Vertical and horizontal dashed
lines indicate user-defined LFC values.

## With edgeR

```
vsFourWay(
    x = 'WW', y = 'WM', control = 'MM', data = df.edger,
    d.factor = NULL, type = 'edger', padj = 0.05, x.lim = NULL,
    y.lim = NULL, lfc = NULL, legend = TRUE, title = TRUE, grid = TRUE
)
```

![A four way plot visualization using the `vsFourWay()` function with  `DESeq2` data. In this example, LFCs comparisons between two treatments and a  control are made. Blue nodes indicate statistically significant LFCs which are  greater than a given user-defined value for both x and y-axes. Green nodes  reflect statistically significant LFCs which are less than a user-defined  value for treatment y and greater than said value for treatment x. Similar to  green nodes, red nodes reflect statistically significant LFCs which are  greater than a user-defined vlaue treatment y and less than said value for  treatment x. Gray nodes are data points that are not statistically significant  for both x and y-axes. Triangular shapes indicate values which exceed the  viewing are for the graph. Size change reflects the magnitude of LFC values ( i.e. larger shapes reflect larger LFC values). Vertical and horizontal dashed  lines indicate user-defined LFC values.](data:image/png;base64...)

Figure 36: A four way plot visualization using the `vsFourWay()` function with
`DESeq2` data. In this example, LFCs comparisons between two treatments and a
control are made. Blue nodes indicate statistically significant LFCs which are
greater than a given user-defined value for both x and y-axes. Green nodes
reflect statistically significant LFCs which are less than a user-defined
value for treatment y and greater than said value for treatment x. Similar to
green nodes, red nodes reflect statistically significant LFCs which are
greater than a user-defined vlaue treatment y and less than said value for
treatment x. Gray nodes are data points that are not statistically significant
for both x and y-axes. Triangular shapes indicate values which exceed the
viewing are for the graph. Size change reflects the magnitude of LFC values (
i.e. larger shapes reflect larger LFC values). Vertical and horizontal dashed
lines indicate user-defined LFC values.

# Example S11: Highlighting data points

## Overview

For point-based plots, users can highlight IDs of interest (i.e. genes,
transcripts, etc.). Currently, this functionality is implemented in the
following functions:

* `vsScatterPlot()`
* `vsMAPlot()`
* `vsVolcano()`
* `vsFourWay()`

To use this feature, simply provide a vector of specified IDs to the
`highlight` parameter found in the prior functions. An example of a typical
vector would be as follows:

```
important_ids <- c(
  "ID_001",
  "ID_002",
  "ID_003",
  "ID_004",
  "ID_005"
)
important_ids
```

```
## [1] "ID_001" "ID_002" "ID_003" "ID_004" "ID_005"
```

For specific examples using the toy data set, please see the proceeding 4
sub-sections.

## Highlighting with `vsScatterPlot()`

```
data("df.cuff")
hl <- c(
  "XLOC_000033",
  "XLOC_000099",
  "XLOC_001414",
  "XLOC_001409"
)
vsScatterPlot(
    x = "hESC", y = "iPS", data = df.cuff, d.factor = NULL,
    type = "cuffdiff", title = TRUE, grid = TRUE, highlight = hl
)
```

![Highlighting with `vsScatterPlot()`. IDs of interest can be  identified within basic scatter plots. When highlighted, non-important points will turn grey while highlighted points will turn blue. Text tags will *try* to optimize their location within the graph without trying to overlap each other.](data:image/png;base64...)

Figure 37: Highlighting with `vsScatterPlot()`
IDs of interest can be
identified within basic scatter plots. When highlighted, non-important points
will turn grey while highlighted points will turn blue. Text tags will *try*
to optimize their location within the graph without trying to overlap each
other.

## Highlighting with `vsMAPlot()`

```
hl <- c(
  "FBgn0022201",
  "FBgn0003042",
  "FBgn0031957",
  "FBgn0033853",
  "FBgn0003371"
)
vsMAPlot(
    x = "treated_paired.end", y = "untreated_paired.end",
    data = df.deseq, d.factor = "condition", type = "deseq",
    padj = 0.05, y.lim = NULL, lfc = NULL, title = TRUE,
    legend = TRUE, grid = TRUE, data.return = FALSE, highlight = hl
)
```

![Highlighting with `vsMAPlot()`. IDs of interest can be  identified within MA plots. When highlighted, non-important points will decrease in transparency (i.e. lower alpha values) while highlighted  points will turn red. Text tags will *try* to optimize their location within  the graph without trying to overlap each other.](data:image/png;base64...)

Figure 38: Highlighting with `vsMAPlot()`
IDs of interest can be
identified within MA plots. When highlighted, non-important points
will decrease in transparency (i.e. lower alpha values) while highlighted
points will turn red. Text tags will *try* to optimize their location within
the graph without trying to overlap each other.

## Highlighting with `vsVolcano()`

```
hl <- c(
  "FBgn0036248",
  "FBgn0026573",
  "FBgn0259742",
  "FBgn0038961",
  "FBgn0038928"
)
vsVolcano(
    x = "treated_paired.end", y = "untreated_paired.end",
    data = df.deseq, d.factor = "condition",
    type = "deseq", padj = 0.05, x.lim = NULL, lfc = NULL,
    title = TRUE, grid = TRUE, data.return = FALSE, highlight = hl
)
```

![Highlighting with `vsVolcano()`. IDs of interest can be  identified within volcano plots. When highlighted, non-important points will decrease in transparency (i.e. lower alpha values) while highlighted  points will turn red. Text tags will *try* to optimize their location within  the graph without trying to overlap each other.](data:image/png;base64...)

Figure 39: Highlighting with `vsVolcano()`
IDs of interest can be
identified within volcano plots. When highlighted, non-important points
will decrease in transparency (i.e. lower alpha values) while highlighted
points will turn red. Text tags will *try* to optimize their location within
the graph without trying to overlap each other.

## Highlighting with `vsFourWay()`

```
data("df.edger")
hl <- c(
    "ID_639",
    "ID_518",
    "ID_602",
    "ID_449",
    "ID_076"
)
vsFourWay(
    x = "WM", y = "WW", control = "MM", data = df.edger,
    d.factor = NULL, type = "edger", padj = 0.05, x.lim = NULL,
    y.lim = NULL, lfc = 2, title = TRUE, grid = TRUE,
    data.return = FALSE, highlight = hl
)
```

![Highlighting with `vsFourWay()`. IDs of interest can be  identified within four-way plots. When highlighted, non-important points will decrease in transparency (i.e. lower alpha values) while highlighted  points will turn dark grey. Text tags will *try* to optimize their location  within the graph without trying to overlap each other.](data:image/png;base64...)

Figure 40: Highlighting with `vsFourWay()`
IDs of interest can be
identified within four-way plots. When highlighted, non-important points
will decrease in transparency (i.e. lower alpha values) while highlighted
points will turn dark grey. Text tags will *try* to optimize their location
within the graph without trying to overlap each other.

# Example S12: Extracting datasets from plots

## Overview

For **all** plots, users can extract datasets used for the visualizations.
You may want to pursue this option if you want to use a highly customized
plot script or you would like to perform some unmentioned analysis, for
example.

To use this this feature, set the `data.return` parameter in the function
you are using to `TRUE`. You will also need to assign the function to an
object. See the following example for further details.

## The data extraction process

In this example, we will use the toy data set `df.cuff`, a cuffdiff output
on the function `vsScatterPlot()`. Take note that we are assigning the
function to an object `tmp`:

```
# Extract data frame from visualization
data("df.cuff")
tmp <- vsScatterPlot(
   x = "hESC", y = "iPS", data = df.cuff, d.factor = NULL,
   type = "cuffdiff", title = TRUE, grid = TRUE, data.return = TRUE
)
```

The object we have created is a list with two elements: `data` and `plot`.
To extract the data, we can call the first element of the list using the
subset method (`<object>[[1]]`) or by invoking its element name
(`<object>$data`):

```
df_scatter <- tmp[[1]] ## or use tmp$data
head(df_scatter)
```

```
##            id           x         y
## 1 XLOC_000001 3.47386e-01  20.21750
## 2 XLOC_000002 0.00000e+00   0.00000
## 3 XLOC_000003 0.00000e+00   0.00000
## 4 XLOC_000004 6.97259e+05   0.00000
## 5 XLOC_000005 6.96704e+02 355.82300
## 6 XLOC_000006 0.00000e+00   1.51396
```

## Return the plot

By assigning each of these functions to a list, we can also store the plot
as another element. To extract the plot, we can call the second element of
the list using the aformentioned procedures:

```
my_plot <- tmp[[2]] ## or use tmp$plot
my_plot
```

![](data:image/png;base64...)

# Example S13: Changing text sizes

## Overview

For all functions, users can modify the font size of multiple portions of the
plot. These portions primarily revolve around these components:

* Axis text and titles
* Plot title
* Legend text and titles
* Facet titles

To manipulate these components, users can modify the default values of the
following parameters:

* `xaxis.text.size`
* `yaxis.text.size`
* `xaxis.title.size`
* `yaxis.title.size`
* `main.title.size`
* `legend.text.size`
* `legend.title.size`
* `facet.title.size`

## What exactly can you manipulate?

Each of parameters mentioned in the prior section refer to numerical values.
These values correlate to font size in typographic points. To illustrate what
exactly these parameters modify, please refer to the following figure:

![A visual guide to text size parameters. Users can modify these components which are highlighted by their respective parameter.](data:image/png;base64...)

Figure 41: A visual guide to text size parameters
Users can modify these
components which are highlighted by their respective parameter.

The `facet.title.size` parameter refers to the facets which are allocated in
the matrix functions (`vsScatterMatrix()`, `vsMAMatrix()`,
`vsVolcanoMatrix()`). This is illustrated in the following figure:

![Location of facet titles. Facet title sizes can be modified using the `facet.title.size` parameter.](data:image/png;base64...)

Figure 42: Location of facet titles
Facet title sizes can be modified using
the `facet.title.size` parameter.

Since not all functions are equal in their parameters and component layout,
some functions will either have or lack some of the prior parameters. To
get an idea of which have functions have which, please refer to the following
figure:

![An overview of text size parameters for each function. Cells  highlighted in red refer to parameters (columns) which are found in their respective functions (rows). Cells which are grey indicate parameters which are not found in each of the functions.](data:image/png;base64...)

Figure 43: An overview of text size parameters for each function
Cells
highlighted in red refer to parameters (columns) which are found in their
respective functions (rows). Cells which are grey indicate parameters which
are not found in each of the functions.

# Method S1: Determining data point shape and size changes

The shape and size of each data point will also change depending on several
conditions. To maximize the viewing area while retaining high resolution, some
data points will not be present within the viewing area. If they exceed the
viewing area, they will change shape from a circle to a triangular orientation.

The extent (i.e. fold change) to how far these points exceed the viewing area
are based on the following criteria:

* **SUB** - values that fall within the viewing area of the plot.
* **T-1** - values that are greater than the maximum viewing area and are
  less than the 25th percentile of values that exceed the viewing area.
* **T-2** - Similar to **T-1**; values fall between the 25th and 50th
  percentile.
* **T-3** - Similar to **T-2**; values fall between the 50th and 75th
  percentile.
* **T-4** - Similar to **T-3**; values fall between the 75th and 100th
  percentile.

To further clarify theses conditions, please refer to the following figure:

![An illustration detailing the principles behind the node size for  the differntial gene expression functions. In this figure, the data points  increase in size depending on which quartile they reside as the absolute LFC  increases (top bar). Data points that fall within the viewing area classified  as SUB while data points that exceed this area are classified as T-1 through  T-4.](data:image/png;base64...)

Figure 44: An illustration detailing the principles behind the node size for
the differntial gene expression functions. In this figure, the data points
increase in size depending on which quartile they reside as the absolute LFC
increases (top bar). Data points that fall within the viewing area classified
as SUB while data points that exceed this area are classified as T-1 through
T-4.

# Method S2: Determining function performance

Function efficiencies were determined by calculating system times by using the
`microbenchmark` R package. Each function was ran 100 times with the prior code
used in the documentation. All benchmarks were determined on a machine running
a 64-bit Windows 10 operating system, 8 GB of RAM, and an Intel Core i5-6400
processor running at 2.7 GHz.

## Scatterplots

![Benchmarks for the `vsScatterPlot()` function. Time (ms)  distributions were generated for this function using 100 trials for each of the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets  contained 1200, 724, and 29391 transcripts, respectively. ](data:image/png;base64...)

Figure 45: Benchmarks for the `vsScatterPlot()` function
Time (ms)
distributions were generated for this function using 100 trials for each of
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets
contained 1200, 724, and 29391 transcripts, respectively.

## Scatterplot matrices

![Benchmarks for the `vsScatterMatrix()` function. Time (ms)  distributions were generated for this function using 100 trials for each of  the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets  contained 1200, 724, and 29391 transcripts, respectively. ](data:image/png;base64...)

Figure 46: Benchmarks for the `vsScatterMatrix()` function
Time (ms)
distributions were generated for this function using 100 trials for each of
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets
contained 1200, 724, and 29391 transcripts, respectively.

## Box plots

![Benchmarks for the `vsBoxPlot()` function. Time (ms)  distributions were generated for this function using 100 trials for each of  the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets  contained 1200, 724, and 29391 transcripts, respectively. ](data:image/png;base64...)

Figure 47: Benchmarks for the `vsBoxPlot()` function
Time (ms)
distributions were generated for this function using 100 trials for each of
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets
contained 1200, 724, and 29391 transcripts, respectively.

## Differential gene expression matrices

![Benchmarks for the `vsDEGMatrix()` function. Time (ms)  distributions were generated for this function using 100 trials for each of  the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets  contained 1200, 724, and 29391 transcripts, respectively. ](data:image/png;base64...)

Figure 48: Benchmarks for the `vsDEGMatrix()` function
Time (ms)
distributions were generated for this function using 100 trials for each of
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets
contained 1200, 724, and 29391 transcripts, respectively.

## Volcano plots

![Benchmarks for the `vsVolcano()` function. Time (ms)  distributions were generated for this function using 100 trials for each of  the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets  contained 1200, 724, and 29391 transcripts, respectively. ](data:image/png;base64...)

Figure 49: Benchmarks for the `vsVolcano()` function
Time (ms)
distributions were generated for this function using 100 trials for each of
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets
contained 1200, 724, and 29391 transcripts, respectively.

## Volcano plot matrices

![Benchmarks for the `vsVolcanoMatrix()` function. Time (ms)  distributions were generated for this function using 100 trials for each of  the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets  contained 1200, 724, and 29391 transcripts, respectively. ](data:image/png;base64...)

Figure 50: Benchmarks for the `vsVolcanoMatrix()` function
Time (ms)
distributions were generated for this function using 100 trials for each of
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets
contained 1200, 724, and 29391 transcripts, respectively.

## MA plots

![Benchmarks for the `vsMAPlot()` function. Time (ms)  distributions were generated for this function using 100 trials for each of  the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets  contained 1200, 724, and 29391 transcripts, respectively. ](data:image/png;base64...)

Figure 51: Benchmarks for the `vsMAPlot()` function
Time (ms)
distributions were generated for this function using 100 trials for each of
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets
contained 1200, 724, and 29391 transcripts, respectively.

## MA matrices

![Benchmarks for the `vsMAMatrix()` function. Time (s)  distributions were generated for this function using 100 trials for each of  the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets  contained 1200, 724, and 29391 transcripts, respectively. ](data:image/png;base64...)

Figure 52: Benchmarks for the `vsMAMatrix()` function
Time (s)
distributions were generated for this function using 100 trials for each of
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets
contained 1200, 724, and 29391 transcripts, respectively.

## Four way plots

![Benchmarks for the `vsFourWay()` function. Time (ms)  distributions were generated for this function using 100 trials for each of  the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets  contained 1200, 724, and 29391 transcripts, respectively. ](data:image/png;base64...)

Figure 53: Benchmarks for the `vsFourWay()` function
Time (ms)
distributions were generated for this function using 100 trials for each of
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets
contained 1200, 724, and 29391 transcripts, respectively.

# Session info

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] edgeR_4.8.0                 limma_3.66.0
##  [3] DESeq2_1.50.0               SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [7] matrixStats_1.5.0           GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              vidger_1.30.0
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
##  [4] ggplot2_4.0.0       ggrepel_0.9.6       GGally_2.4.0
##  [7] lattice_0.22-7      vctrs_0.6.5         tools_4.5.1
## [10] parallel_4.5.1      tibble_3.3.0        pkgconfig_2.0.3
## [13] Matrix_1.7-4        RColorBrewer_1.1-3  S7_0.2.0
## [16] lifecycle_1.0.4     compiler_4.5.1      farver_2.1.2
## [19] tinytex_0.57        statmod_1.5.1       codetools_0.2-20
## [22] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
## [25] pillar_1.11.1       jquerylib_0.1.4     tidyr_1.3.1
## [28] BiocParallel_1.44.0 DelayedArray_0.36.0 cachem_1.1.0
## [31] magick_2.9.0        abind_1.4-8         ggstats_0.11.0
## [34] tidyselect_1.2.1    locfit_1.5-9.12     digest_0.6.37
## [37] dplyr_1.1.4         purrr_1.1.0         bookdown_0.45
## [40] labeling_0.4.3      fastmap_1.2.0       grid_4.5.1
## [43] cli_3.6.5           SparseArray_1.10.0  magrittr_2.0.4
## [46] S4Arrays_1.10.0     dichromat_2.0-0.1   withr_3.0.2
## [49] scales_1.4.0        rmarkdown_2.30      XVector_0.50.0
## [52] evaluate_1.0.5      knitr_1.50          rlang_1.1.6
## [55] Rcpp_1.1.0          glue_1.8.0          BiocManager_1.30.26
## [58] jsonlite_2.0.0      R6_2.6.1
```