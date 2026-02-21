# Code example from 'vidger' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
    fig.path='figure/graphics-', 
    cache.path='cache/graphics-', 
    fig.align='center',
    external=TRUE,
    echo=TRUE,
    warning=FALSE
    # fig.pos="H"
)

## ----echo=FALSE, message=FALSE------------------------------------------------
library(vidger)
library(DESeq2)
library(edgeR)
data("df.cuff")
data("df.deseq")
data("df.edger")

## ----eval=FALSE, message=FALSE------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("vidger")

## ----eval=FALSE, message=FALSE------------------------------------------------
# if (!require("devtools")) install.packages("devtools")
# devtools::install_github("btmonier/vidger", ref = "devel")

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A box plot example using the `vsBoxPlot()` function with 
`cuffdiff` data. In this example, FPKM distributions for each treatment within 
an experiment are shown in the form of a box and whisker plot."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsBoxPlot(
    data = df.cuff, d.factor = NULL, type = 'cuffdiff', title = TRUE, 
    legend = TRUE, grid = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A box plot example using the `vsBoxPlot()` function with 
`DESeq2` data. In this example, FPKM distributions for each treatment within 
an experiment are shown in the form of a box and whisker plot."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsBoxPlot(
    data = df.deseq, d.factor = 'condition', type = 'deseq', 
    title = TRUE, legend = TRUE, grid = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A box plot example using the `vsBoxPlot()` function with `edgeR` 
data. In this example, CPM distributions for each treatment within an 
experiment are shown in the form of a box and whisker plot"

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsBoxPlot(
    data = df.edger, d.factor = NULL, type = 'edger', 
    title = TRUE, legend = TRUE, grid = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A box plot example using the `aes` parameter: `box`."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "box"
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A box plot example using the `aes` parameter: `violin`."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "violin"
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A box plot example using the `aes` parameter: `boxdot`."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "boxdot"
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A box plot example using the `aes` parameter: `viodot`."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "viodot"
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A box plot example using the `aes` parameter: `viosumm`."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "viosumm"
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A box plot example using the `aes` parameter: `notch`."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "notch"
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Color variant 1. A box plot example using the `fill.color` 
parameter: `RdGy`."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "box", fill.color = "RdGy"
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Color variant 2. A violin plot example using the `fill.color` 
parameter: `Paired` with the `aes` parameter: `viosumm`."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "viosumm", fill.color = "Paired"
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Color variant 3. A notched box plot example using the `fill.color` 
parameter: `Greys` with the `aes` parameter: `notch`. Using these parameters,
we can also generate grey-scale plots."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
data("df.edger")
vsBoxPlot(
   data = df.edger, d.factor = NULL, type = "edger", title = TRUE,
   legend = TRUE, grid = TRUE, aes = "notch", fill.color = "Greys"
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A scatterplot example using the `vsScatterPlot()` function with 
`Cuffdiff` data. In this visualization, $log_{10}$ comparisons are made of 
fragments per kilobase of transcript per million mapped reads (FPKM) 
measurments. The dashed line represents regression line for the comparison."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsScatterPlot(
    x = 'hESC', y = 'iPS', data = df.cuff, type = 'cuffdiff',
    d.factor = NULL, title = TRUE, grid = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A scatterplot example using the `vsScatterPlot()` function with 
`DESeq2` data. In this visualization, $log_{10}$ comparisons are made of 
fragments per kilobase of transcript per million mapped reads (FPKM) 
measurments. The dashed line represents regression line for the comparison."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsScatterPlot(
    x = 'treated_paired.end', y = 'untreated_paired.end', 
    data = df.deseq, type = 'deseq', d.factor = 'condition', 
    title = TRUE, grid = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A scatterplot example using the `vsScatterPlot()` function with 
`edgeR` data. In this visualization, $log_{10}$ comparisons are made of 
fragments per kilobase of transcript per million mapped reads (FPKM) 
measurments. The dashed line represents regression line for the comparison."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsScatterPlot(
    x = 'WM', y = 'MM', data = df.edger, type = 'edger',
    d.factor = NULL, title = TRUE, grid = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A scatterplot matrix example using the `vsScatterMatrix()` 
function with `Cuffdiff` data. Similar to the scatterplot function, this 
visualization allows for all comparisons to be made within an experiment. In 
addition to the scatterplot visuals, FPKM distributions (histograms) and 
correlation (Corr) values are generated."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsScatterMatrix(
    data = df.cuff, d.factor = NULL, type = 'cuffdiff', 
    comp = NULL, title = TRUE, grid = TRUE, man.title = NULL
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A scatterplot matrix example using the `vsScatterMatrix()` 
function with `DESeq2` data. Similar to the scatterplot function, this 
visualization allows for all comparisons to be made within an experiment. In 
addition to the scatterplot visuals, FPKM distributions (histograms) and 
correlation (Corr) values are generated."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsScatterMatrix(
    data = df.deseq, d.factor = 'condition', type = 'deseq',
    comp = NULL, title = TRUE, grid = TRUE, man.title = NULL
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A scatterplot matrix example using the `vsScatterMatrix()` 
function with `edgeR` data. Similar to the scatterplot function, this 
visualization allows for all comparisons to be made within an experiment. In 
addition to the scatterplot visuals, FPKM distributions (histograms) and 
correlation (Corr) values are generated."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsScatterMatrix(
    data = df.edger, d.factor = NULL, type = 'edger', comp = NULL,
    title = TRUE, grid = TRUE, man.title = NULL
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A matrix of differentially expressed genes (DEGs) at a given 
*p*-value using the `vsDEGMatrix()` function with `Cuffdiff` data. With this 
function, the user is able to visualize the number of DEGs ata given adjusted 
*p*-value for each experimental treatment level. Higher color intensity 
correlates to a higher number of DEGs."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsDEGMatrix(
    data = df.cuff, padj = 0.05, d.factor = NULL, type = 'cuffdiff', 
    title = TRUE, legend = TRUE, grid = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A matrix of differentially expressed genes (DEGs) at a given 
*p*-value using the `vsDEGMatrix()` function with `DESeq2` data. With this 
function, the user is able to visualize the number of DEGs ata given adjusted 
*p*-value for each experimental treatment level. Higher color intensity 
correlates to a higher number of DEGs."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsDEGMatrix(
    data = df.deseq, padj = 0.05, d.factor = 'condition', 
    type = 'deseq', title = TRUE, legend = TRUE, grid = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A matrix of differentially expressed genes (DEGs) at a given 
*p*-value using the `vsDEGMatrix()` function with `edgeR` data. With this 
function, the user is able to visualize the number of DEGs ata given adjusted 
*p*-value for each experimental treatment level. Higher color intensity 
correlates to a higher number of DEGs."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsDEGMatrix(
    data = df.edger, padj = 0.05, d.factor = NULL, type = 'edger', 
    title = TRUE, legend = TRUE, grid = TRUE
)

## -----------------------------------------------------------------------------
vsDEGMatrix(data = df.deseq, d.factor = "condition", type = "deseq",
    grey.scale = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "MA plot visualization using the `vsMAPLot()` function with 
`Cuffdiff` data. LFCs are plotted mean counts to determine the variance 
between two treatments in terms of gene expression. Blue nodes on the graph 
represent statistically significant LFCs which are greater than a given value 
than a user-defined LFC parameter. Green nodes indicate statistically 
significant LFCs which are less than the user-defined LFC parameter. Gray 
nodes are data points that are not statistically significant. Numerical values 
in parantheses for each legend color indicate the number of transcripts that 
meet the prior conditions. Triangular shapes represent values that exceed the 
viewing area of the graph. Node size changes represent the magnitude of the 
LFC values (i.e. larger shapes reflect larger LFC values). Dashed lines 
indicate user-defined LFC values."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsMAPlot(
    x = 'iPS', y = 'hESC', data = df.cuff, d.factor = NULL, 
    type = 'cuffdiff', padj = 0.05, y.lim = NULL, lfc = NULL, 
    title = TRUE, legend = TRUE, grid = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "MA plot visualization using the `vsMAPLot()` function with 
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
LFC values."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsMAPlot(
    x = 'treated_paired.end', y = 'untreated_paired.end', 
    data = df.deseq, d.factor = 'condition', type = 'deseq', 
    padj = 0.05, y.lim = NULL, lfc = NULL, title = TRUE, 
    legend = TRUE, grid = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "MA plot visualization using the `vsMAPLot()` function with 
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
LFC values."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsMAPlot(
    x = 'WW', y = 'MM', data = df.edger, d.factor = NULL, 
    type = 'edger', padj = 0.05, y.lim = NULL, lfc = NULL, 
    title = TRUE, legend = TRUE, grid = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A MA plot matrix using the `vsMAMatrix()` function with `Cuffdiff` 
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
Node size changes represent the magnitude of the LFC values (i.e. larger 
shapes reflect larger LFC values). Dashed lines indicate user-defined LFC 
values."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
 vsMAMatrix(
    data = df.cuff, d.factor = NULL, type = 'cuffdiff', 
    padj = 0.05, y.lim = NULL, lfc = 1, title = TRUE, 
    grid = TRUE, counts = TRUE, data.return = FALSE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A MA plot matrix using the `vsMAMatrix()` function with `DESeq2` 
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
Node size changes represent the magnitude of the LFC values (i.e. larger 
shapes reflect larger LFC values). Dashed lines indicate user-defined LFC 
values."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsMAMatrix(
    data = df.deseq, d.factor = 'condition', type = 'deseq', 
    padj = 0.05, y.lim = NULL, lfc = 1, title = TRUE, 
    grid = TRUE, counts = TRUE, data.return = FALSE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A MA plot matrix using the `vsMAMatrix()` function with `edgeR` 
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
Node size changes represent the magnitude of the LFC values (i.e. larger 
shapes reflect larger LFC values). Dashed lines indicate user-defined LFC 
values."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsMAMatrix(
    data = df.edger, d.factor = NULL, type = 'edger', 
    padj = 0.05, y.lim = NULL, lfc = 1, title = TRUE, 
    grid = TRUE, counts = TRUE, data.return = FALSE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A volcano plot example using the `vsVolcano()` function with 
`Cuffdiff` data. In this visualization, comparisons are made between the 
$-log_{10}$ *p*-value versus the $log_2$ fold change (LFC) between two 
treatments. Blue nodes on the graph represent statistically significant LFCs 
which are greater than a given value than a user-defined LFC parameter. Green 
nodes indicate statistically significant LFCs which are less than the 
user-defined LFC parameter. Gray nodes are data points that are not 
statistically significant. Numerical values in parantheses for each legend 
color indicate the number of transcripts that meet the prior conditions. Left 
and right brackets (< and >) represent values that exceed the viewing area of 
the graph. Node size changes represent the magnitude of the LFC values (i.e. 
larger shapes reflect larger LFC values). Vertical and horizontal lines 
indicate user-defined LFC and adjusted *p*-values, respectively."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsVolcano(
    x = 'iPS', y = 'hESC', data = df.cuff, d.factor = NULL, 
    type = 'cuffdiff', padj = 0.05, x.lim = NULL, lfc = NULL, 
    title = TRUE, legend = TRUE, grid = TRUE, data.return = FALSE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A volcano plot example using the `vsVolcano()` function with 
`DESeq2` data. In this visualization, comparisons are made between the 
$-log_{10}$ *p*-value versus the $log_2$ fold change (LFC) between two 
treatments. Blue nodes on the graph represent statistically significant LFCs 
which are greater than a given value than a user-defined LFC parameter. Green 
nodes indicate statistically significant LFCs which are less than the 
user-defined LFC parameter. Gray nodes are data points that are not 
statistically significant. Numerical values in parantheses for each legend 
color indicate the number of transcripts that meet the prior conditions. Left 
and right brackets (< and >) represent values that exceed the viewing area of 
the graph. Node size changes represent the magnitude of the LFC values (i.e. 
larger shapes reflect larger LFC values). Vertical and horizontal lines 
indicate user-defined LFC and adjusted *p*-values, respectively."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsVolcano(
    x = 'treated_paired.end', y = 'untreated_paired.end', 
    data = df.deseq, d.factor = 'condition', type = 'deseq', 
    padj = 0.05, x.lim = NULL, lfc = NULL, title = TRUE, 
    legend = TRUE, grid = TRUE, data.return = FALSE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A volcano plot example using the `vsVolcano()` function with 
`edgeR` data. In this visualization, comparisons are made between the 
$-log_{10}$ *p*-value versus the $log_2$ fold change (LFC) between two 
treatments. Blue nodes on the graph represent statistically significant LFCs 
which are greater than a given value than a user-defined LFC parameter. Green 
nodes indicate statistically significant LFCs which are less than the 
user-defined LFC parameter. Gray nodes are data points that are not 
statistically significant. Numerical values in parantheses for each legend 
color indicate the number of transcripts that meet the prior conditions. Left 
and right brackets (< and >) represent values that exceed the viewing area of 
the graph. Node size changes represent the magnitude of the LFC values (i.e. 
larger shapes reflect larger LFC values). Vertical and horizontal lines 
indicate user-defined LFC and adjusted *p*-values, respectively."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsVolcano(
    x = 'WW', y = 'MM', data = df.edger, d.factor = NULL, 
    type = 'edger', padj = 0.05, x.lim = NULL, lfc = NULL, 
    title = TRUE, legend = TRUE, grid = TRUE, data.return = FALSE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A volcano plot matrix using the `vsVolcanoMatrix()` function with 
`Cuffdiff` data. Similar to the `vsVolcano()` function, `vsVolcanoMatrix()` 
will generate a matrix of volcano plots for all comparisons within an 
experiment. Comparisons are made between the $-log_{10}$ *p*-value versus the 
$log_2$ fold change (LFC) between two treatments. Blue nodes on the graph 
represent statistically significant LFCs which are greater than a given value 
than a user-defined LFC parameter. Green nodes indicate statistically 
significant LFCs which are less than the user-defined LFC parameter. Gray 
nodes are data points that are not statistically significant. The blue and 
green numbers in each facet represent the number of transcripts that meet the 
criteria for blue and green nodes in each comparison. Left and right brackets 
(< and >) represent values that exceed the viewing area of the graph. Node 
size changes represent the magnitude of the LFC values (i.e. larger shapes 
reflect larger LFC values). Vertical and horizontal lines indicate 
user-defined LFC and adjusted *p*-values, respectively."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsVolcanoMatrix(
    data = df.cuff, d.factor = NULL, type = 'cuffdiff', 
    padj = 0.05, x.lim = NULL, lfc = NULL, title = TRUE, 
    legend = TRUE, grid = TRUE, counts = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A volcano plot matrix using the `vsVolcanoMatrix()` function with 
`DESeq2` data. Similar to the `vsVolcano()` function, `vsVolcanoMatrix()` 
will generate a matrix of volcano plots for all comparisons within an 
experiment. Comparisons are made between the $-log_{10}$ *p*-value versus the 
$log_2$ fold change (LFC) between two treatments. Blue nodes on the graph 
represent statistically significant LFCs which are greater than a given value 
than a user-defined LFC parameter. Green nodes indicate statistically 
significant LFCs which are less than the user-defined LFC parameter. Gray 
nodes are data points that are not statistically significant. The blue and 
green numbers in each facet represent the number of transcripts that meet the 
criteria for blue and green nodes in each comparison. Left and right brackets 
(< and >) represent values that exceed the viewing area of the graph. Node 
size changes represent the magnitude of the LFC values (i.e. larger shapes 
reflect larger LFC values). Vertical and horizontal lines indicate 
user-defined LFC and adjusted *p*-values, respectively."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsVolcanoMatrix(
    data = df.deseq, d.factor = 'condition', type = 'deseq', 
    padj = 0.05, x.lim = NULL, lfc = NULL, title = TRUE, 
    legend = TRUE, grid = TRUE, counts = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A volcano plot matrix using the `vsVolcanoMatrix()` function with 
`edgeR` data. Similar to the `vsVolcano()` function, `vsVolcanoMatrix()` 
will generate a matrix of volcano plots for all comparisons within an 
experiment. Comparisons are made between the $-log_{10}$ *p*-value versus the 
$log_2$ fold change (LFC) between two treatments. Blue nodes on the graph 
represent statistically significant LFCs which are greater than a given value 
than a user-defined LFC parameter. Green nodes indicate statistically 
significant LFCs which are less than the user-defined LFC parameter. Gray 
nodes are data points that are not statistically significant. The blue and 
green numbers in each facet represent the number of transcripts that meet the 
criteria for blue and green nodes in each comparison. Left and right brackets 
(< and >) represent values that exceed the viewing area of the graph. Node 
size changes represent the magnitude of the LFC values (i.e. larger shapes 
reflect larger LFC values). Vertical and horizontal lines indicate 
user-defined LFC and adjusted *p*-values, respectively."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsVolcanoMatrix(
    data = df.edger, d.factor = NULL, type = 'edger', padj = 0.05, 
    x.lim = NULL, lfc = NULL, title = TRUE, legend = TRUE, 
    grid = TRUE, counts = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A four way plot visualization using the `vsFourWay()` function with 
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
i.e. larger shapes reflect larger LFC values). Vertical and horizontal dashed 
lines indicate user-defined LFC values."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsFourWay(
    x = 'iPS', y = 'hESC', control = 'Fibroblasts', data = df.cuff,
    d.factor = NULL, type = 'cuffdiff', padj = 0.05, x.lim = NULL,
    y.lim = NULL, lfc = NULL, legend = TRUE, title = TRUE, grid = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A four way plot visualization using the `vsFourWay()` function with 
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
i.e. larger shapes reflect larger LFC values). Vertical and horizontal dashed 
lines indicate user-defined LFC values."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsFourWay(
    x = 'treated_paired.end', y = 'untreated_single.read', 
    control = 'untreated_paired.end', data = df.deseq, 
    d.factor = 'condition', type = 'deseq', padj = 0.05, x.lim = NULL, 
    y.lim = NULL, lfc = NULL, legend = TRUE, title = TRUE, grid = TRUE
)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A four way plot visualization using the `vsFourWay()` function with 
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
i.e. larger shapes reflect larger LFC values). Vertical and horizontal dashed 
lines indicate user-defined LFC values."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
vsFourWay(
    x = 'WW', y = 'WM', control = 'MM', data = df.edger,
    d.factor = NULL, type = 'edger', padj = 0.05, x.lim = NULL,
    y.lim = NULL, lfc = NULL, legend = TRUE, title = TRUE, grid = TRUE
)

## -----------------------------------------------------------------------------
important_ids <- c(
  "ID_001",
  "ID_002",
  "ID_003",
  "ID_004",
  "ID_005"
)
important_ids

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Highlighting with `vsScatterPlot()`. IDs of interest can be 
identified within basic scatter plots. When highlighted, non-important points
will turn grey while highlighted points will turn blue. Text tags will *try*
to optimize their location within the graph without trying to overlap each
other."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
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

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Highlighting with `vsMAPlot()`. IDs of interest can be 
identified within MA plots. When highlighted, non-important points
will decrease in transparency (i.e. lower alpha values) while highlighted 
points will turn red. Text tags will *try* to optimize their location within 
the graph without trying to overlap each other."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
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

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Highlighting with `vsVolcano()`. IDs of interest can be 
identified within volcano plots. When highlighted, non-important points
will decrease in transparency (i.e. lower alpha values) while highlighted 
points will turn red. Text tags will *try* to optimize their location within 
the graph without trying to overlap each other."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
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

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Highlighting with `vsFourWay()`. IDs of interest can be 
identified within four-way plots. When highlighted, non-important points
will decrease in transparency (i.e. lower alpha values) while highlighted 
points will turn dark grey. Text tags will *try* to optimize their location 
within the graph without trying to overlap each other."

## ----message=FALSE, fig.cap=my.cap--------------------------------------------
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

## -----------------------------------------------------------------------------
# Extract data frame from visualization
data("df.cuff")
tmp <- vsScatterPlot(
   x = "hESC", y = "iPS", data = df.cuff, d.factor = NULL,
   type = "cuffdiff", title = TRUE, grid = TRUE, data.return = TRUE
)

## -----------------------------------------------------------------------------
df_scatter <- tmp[[1]] ## or use tmp$data
head(df_scatter)

## -----------------------------------------------------------------------------
my_plot <- tmp[[2]] ## or use tmp$plot
my_plot

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "A visual guide to text size parameters. Users can modify these
components which are highlighted by their respective parameter."

## ----echo=FALSE, fig.cap=my.cap-----------------------------------------------
knitr::include_graphics("img/text-size-parameters-01.png", auto_pdf = TRUE)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Location of facet titles. Facet title sizes can be modified using
the `facet.title.size` parameter."

## ----echo=FALSE, fig.cap=my.cap-----------------------------------------------
knitr::include_graphics("img/text-size-parameters-02.png", auto_pdf = TRUE)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "An overview of text size parameters for each function. Cells 
highlighted in red refer to parameters (columns) which are found in their
respective functions (rows). Cells which are grey indicate parameters which
are not found in each of the functions."

## ----echo=FALSE, fig.cap=my.cap-----------------------------------------------
knitr::include_graphics("img/text-size-parameters-03.png", auto_pdf = TRUE)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "An illustration detailing the principles behind the node size for 
the differntial gene expression functions. In this figure, the data points 
increase in size depending on which quartile they reside as the absolute LFC 
increases (top bar). Data points that fall within the viewing area classified 
as SUB while data points that exceed this area are classified as T-1 through 
T-4."

## ----echo=FALSE, fig.cap=my.cap, out.width = "75%"----------------------------
knitr::include_graphics("img/lfc-shape.png")

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Benchmarks for the `vsScatterPlot()` function. Time (ms) 
distributions were generated for this function using 100 trials for each of
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets 
contained 1200, 724, and 29391 transcripts, respectively. "

## ----echo=FALSE, fig.cap=my.cap, out.width = "75%"----------------------------
knitr::include_graphics("img/eff-scatter.png", auto_pdf = TRUE)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Benchmarks for the `vsScatterMatrix()` function. Time (ms) 
distributions were generated for this function using 100 trials for each of 
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets 
contained 1200, 724, and 29391 transcripts, respectively. "

## ----echo=FALSE, fig.cap=my.cap, out.width = "75%"----------------------------
knitr::include_graphics("img/eff-smatrix.png", auto_pdf = TRUE)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Benchmarks for the `vsBoxPlot()` function. Time (ms) 
distributions were generated for this function using 100 trials for each of 
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets 
contained 1200, 724, and 29391 transcripts, respectively. "

## ----echo=FALSE, fig.cap=my.cap, out.width = "75%"----------------------------
knitr::include_graphics("img/eff-box.png", auto_pdf = TRUE)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Benchmarks for the `vsDEGMatrix()` function. Time (ms) 
distributions were generated for this function using 100 trials for each of 
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets 
contained 1200, 724, and 29391 transcripts, respectively. "

## ----echo=FALSE, fig.cap=my.cap, out.width = "75%"----------------------------
knitr::include_graphics("img/eff-deg.png", auto_pdf = TRUE)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Benchmarks for the `vsVolcano()` function. Time (ms) 
distributions were generated for this function using 100 trials for each of 
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets 
contained 1200, 724, and 29391 transcripts, respectively. "

## ----echo=FALSE, fig.cap=my.cap, out.width = "75%"----------------------------
knitr::include_graphics("img/eff-volcano.png", auto_pdf = TRUE)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Benchmarks for the `vsVolcanoMatrix()` function. Time (ms) 
distributions were generated for this function using 100 trials for each of 
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets 
contained 1200, 724, and 29391 transcripts, respectively. "

## ----echo=FALSE, fig.cap=my.cap, out.width = "75%"----------------------------
knitr::include_graphics("img/eff-vmatrix.png", auto_pdf = TRUE)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Benchmarks for the `vsMAPlot()` function. Time (ms) 
distributions were generated for this function using 100 trials for each of 
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets 
contained 1200, 724, and 29391 transcripts, respectively. "

## ----echo=FALSE, fig.cap=my.cap, out.width = "75%"----------------------------
knitr::include_graphics("img/eff-maplot.png", auto_pdf = TRUE)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Benchmarks for the `vsMAMatrix()` function. Time (s) 
distributions were generated for this function using 100 trials for each of 
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets 
contained 1200, 724, and 29391 transcripts, respectively. "

## ----echo=FALSE, fig.cap=my.cap, out.width = "75%"----------------------------
knitr::include_graphics("img/eff-mamatrix.png", auto_pdf = TRUE)

## ----echo=FALSE---------------------------------------------------------------
my.cap <- "Benchmarks for the `vsFourWay()` function. Time (ms) 
distributions were generated for this function using 100 trials for each of 
the three RNAseq data objects. Cuffdiff, DESeq2, and edgeR example data sets 
contained 1200, 724, and 29391 transcripts, respectively. "

## ----echo=FALSE, fig.cap=my.cap, out.width = "75%"----------------------------
knitr::include_graphics("img/eff-four.png", auto_pdf = TRUE)

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

