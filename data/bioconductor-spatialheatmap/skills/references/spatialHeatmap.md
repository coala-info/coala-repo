Code

* Show All Code
* Hide All Code

# *spatialHeatmap*: Visualizing Spatial Assays in Anatomical Images and Large-Scale Data Extensions

Authors: Jianhai Zhang and Thomas Girke

#### Last update: 22 January, 2026

#### Package

spatialHeatmap 2.16.3

# 1 Introduction

This vignette showcases key functionalities of the `spatialHeatmap` package, with a detailed description of the project available [here](https://spatialheatmap.org/).

## 1.1 Motivation

The *spatialHeatmap* package provides functionalities for visualizing cell-,
tissue- and organ-specific data of biological assays by coloring the
corresponding spatial features defined in anatomical images according to
quantitative abundance levels of measured biomolecules, such as transcripts, proteins
or metabolites (Zhang et al. [2024](#ref-shm)). A color key is used to represent the quantitative assay values
and can be customized by the user. This core functionality of the package is called
a *spatial heatmap* (SHM) plot. Additional important functionalities include
*Spatial Enrichment* (SE), *Spatial Co-Expression* (SCE), and *Single Cell to
SHM Co-Visualization* (SC2SHM-CoViz). These extra utilities are useful for
identifying biomolecules with spatially selective abundance patterns (SE), groups of
biomolecules with related abundance profiles using hierarchical clustering, K-means clustering, or network analysis (SCE), and to co-visualize
single cell embedding results with SHMs (SCSHM-CoViz). The latter co-visualization
functionality (Figure [1](#fig:illus)E) is described in a separate vignette called
[SCSHM-CoViz](https://bioconductor.org/packages/release/bioc/vignettes/spatialHeatmap/inst/doc/covisualize.html).

The functionalities of *spatialHeatmap* can be used either in a command-driven mode
from within R or a graphical user interface (GUI) provided by a Shiny App that
is part of this project. While the R-based mode provides flexibility to
customize and automate analysis routines, the Shiny App includes a variety of
convenience features that will appeal to experimentalists and users less
familiar with R. The Shiny App can be used on both local computers as
well as centralized server-based deployments (*e.g.* cloud-based or custom
servers). This way it can be used for both hosting community data on a
public server or running on a private system. The core functionalities of the
`spatialHeatmap` package are illustrated in Figure [1](#fig:illus).

![Overview of spatialHeatmap functionality. (A) The _spatialHeatmap_ package plots numeric assay data onto spatially annotated images. The assay data can be provided as numeric vectors, tabular data, _SummarizedExperiment_, or _SingleCellExperiment_ objects. The latter two are widely used data containers for organizing both assays as well as associated annotation data and experimental designs. (B) Anatomical and other spatial images need to be provided as annotated SVG (aSVG) files where the spatial features and the corresponding components of the assay data have matching labels (_e.g._ tissue labels). To work with SVG data efficiently, the _SVG_ S4 class container has been developed. The assay data are used to color the matching spatial features in aSVG images according to a color key. (C)-(D) The result is called a spatial heatmap (SHM). (E) Large-scale data mining such as hierarchical clustering and network analysis can be integrated to facilitate the identification of biomolecules with similar abundance profiles. Moreover, (E) Single cell embedding results can be co-visualized with SHMs.](data:image/jpeg;base64...)

Figure 1: Overview of spatialHeatmap functionality
(A) The *spatialHeatmap* package plots numeric assay data onto spatially annotated images. The assay data can be provided as numeric vectors, tabular data, *SummarizedExperiment*, or *SingleCellExperiment* objects. The latter two are widely used data containers for organizing both assays as well as associated annotation data and experimental designs. (B) Anatomical and other spatial images need to be provided as annotated SVG (aSVG) files where the spatial features and the corresponding components of the assay data have matching labels (*e.g.* tissue labels). To work with SVG data efficiently, the *SVG* S4 class container has been developed. The assay data are used to color the matching spatial features in aSVG images according to a color key. (C)-(D) The result is called a spatial heatmap (SHM). (E) Large-scale data mining such as hierarchical clustering and network analysis can be integrated to facilitate the identification of biomolecules with similar abundance profiles. Moreover, (E) Single cell embedding results can be co-visualized with SHMs.

The package supports anatomical images from public
repositories or those provided by users. In general any type of
image can be used as long as it can be provided in SVG (Scalable Vector
Graphics) format and the corresponding spatial features, such as organs, tissues, cellular compartments, are annotated (see [aSVG](#term) below). The numeric values
plotted onto an SHM
are usually quantitative measurements from a wide range of profiling
technologies, such as microarrays, next generation sequencing (*e.g.* RNA-Seq
and scRNA-Seq), proteomics, metabolomics, or many other small- or large-scale
experiments. For convenience, several preprocessing and normalization methods
for the most common use cases are included that support raw and/or preprocessed
data. Currently, the main application domains of the *spatialHeatmap* package
are numeric data sets and spatially mapped images from biological, agricultural
and biomedical areas. Moreover, the package has been designed to also work with
many other spatial data types, such as population data plotted onto geographic
maps. This high level of flexibility is one of the unique features of
*spatialHeatmap*. Related software tools for biological applications in this
field are largely based on pure web applications (Maag [2018](#ref-Maag2018-gi); Lekschas et al. [2015](#ref-Lekschas2015-gd); Papatheodorou et al. [2018](#ref-Papatheodorou2018-jy); Winter et al. [2007](#ref-Winter2007-bq); Waese et al. [2017](#ref-Waese2017-fx)) or local tools (Muschelli, Sweeney, and Crainiceanu [2014](#ref-Muschelli2014-av)) that typically
lack customization functionalities. These restrictions limit users to utilizing
pre-existing expression data and/or fixed sets of anatomical image collections.
To close this gap for biological use cases, we have developed *spatialHeatmap*
as a generic R/Bioconductor package for plotting quantitative values onto any
type of spatially mapped images in a programmable environment and/or in an
intuitive to use GUI application.

## 1.2 Design

The core feature of [`spatialHeatmap`](#shm) is to map assay values (*e.g.*
gene expression data) of one or many biomolecules (*e.g.* genes) measured under
different conditions in form of numerically graded colors onto the
corresponding cell types or tissues represented in a chosen SVG image. In the
gene profiling field, this feature supports comparisons of the expression
values among multiple genes by plotting their SHMs next to each
other. Similarly, one can display the expression values of a single or multiple
genes across multiple conditions in the same plot (Figure [3](#fig:mul)). This level of flexibility is
very efficient for visualizing complicated expression patterns across genes,
cell types and conditions. In case of more complex anatomical images with
overlapping multiple layer tissues, it is important to visually expose the
tissue layer of interest in the plots. To address this, several default and
customizable layer viewing options are provided. They allow to hide features in
the top layers by making them transparent in order to expose features below
them. This transparency viewing feature is highlighted below in the mouse
example (Figure [4](#fig:musshm)). Moreover, one can plot multiple distinct
aSVGs in a single SHM plot as shown in Figure [10](#fig:arabshm). This is
particularly useful for displaying abundance trends across multiple development
stages, where each is represented by its own aSVG image. In addition to
static SHM representations, one can visualize them in form of interactive HTML files or videos.

To maximize reusability and extensibility, the package organizes large-scale
omics assay data along with the associated experimental design information in a
`SummarizedExperiment` object (Figure [1](#fig:illus)A; Morgan et al. [2018](#ref-se)). The latter is one of the core S4 classes within
the Bioconductor ecosystem that has been widely adapted by many other software
packages dealing with gene-, protein- and metabolite-level profiling data.
In case of gene expression data, the `assays` slot of
the `SummarizedExperiment` container is populated with a gene expression
matrix, where the rows and columns represent the genes and tissue/conditions,
respectively. The `colData` slot contains experimental design definitions including
replicate and treatment information. The tissues and/or cell type information in the object maps via
`colData` to the corresponding features in the SVG images using unique
identifiers for the spatial features (*e.g.* tissues or cell types). This
allows to color the features of interest in an SVG image according to the
numeric data stored in a `SummarizedExperiment` object. For simplicity the
numeric data can also be provided as numeric `vectors` or `data.frames`. This
can be useful for testing purposes and/or the usage of simple data sets that
may not require the more advanced features of the `SummarizedExperiment` class,
such as measurements with only one or a few data points. The details about how to
access the SVG images and properly format the associated expression data are
provided in the [Supplementary Section](#data_form) of this vignette.

## 1.3 Image Format: SVG

SHMs are images where colors encode numeric values in features of
any shape. For plotting SHMs, Scalable Vector Graphics (SVG) has
been chosen as image format since it is a flexible and widely adapted vector
graphics format that provides many advantages for computationally embedding
numerical and other information in images. SVG is based on XML formatted text
describing all components present in images, including lines, shapes and
colors. In case of biological images suitable for SHMs, the shapes
often represent anatomical or cell structures. To assign colors to specific
features in SHMs, *annotated SVG* (aSVG) files are used where the
shapes of interest are labeled according to certain conventions so that they
can be addressed and colored programmatically. One or multiple aSVG files can be parsed and stored in the `SVG` S4 container with utilities provided by the *spatialHeatmap* package (Figure [1](#fig:illus)B). The main slots of `SVG` include `coordinate`,
`attribute`, `dimension`, `svg`, and `raster`. They correspond to feature coordinates, styling attributes (color, line width, etc.), width and heigth, original aSVG instances,
and raster image paths, respectively. Raster images are required only when including photographic image components in SHMs (Figure [7](#fig:overCol)), which is optional. Detailed instruction for creating custom aSVGs is provied in a separate [tutorial](https://jianhaizhang.github.io/SHM_SVG).

SVGs and aSVGs of anatomical structures can
be downloaded from many sources including the repositories described [below](#data_repo).
Alternatively, users can generate them themselves with vector graphics software
such as [Inkscape](https://inkscape.org/). Typically, in aSVGs one or more
shapes of a feature of interest, such as the cell shapes of an organ, are
grouped together by a common feature identifier. Via these group identifiers
one or many feature types can be colored simultaneously in an aSVG according to
biological experiments assaying the corresponding feature types with the
required spatial resolution. To color spatial features according to numeric assay values, common identifiers are required for spatial features between the assay data and aSVGs. The color
gradient used to visually represent the numeric assay values is controlled by a
color gradient parameter. To visually interpret the meaning of the colors, the
corresponding color key is included in the SHM plots. Additional
details for properly formatting and annotating both aSVG images and assay data
are provided in the [Supplementary Section](#sup) section of this vignette.

## 1.4 Data Repositories

If not generated by the user, SHMs can be generated with data downloaded from
various public repositories. This includes gene, protein and metabolic
profiling data from databases, such as [GEO](https://www.ncbi.nlm.nih.gov/gds),
[BAR](http://bar.utoronto.ca/) and [Expression
Atlas](https://www.ebi.ac.uk/gxa/home) from EMBL-EBI (Papatheodorou et al. [2018](#ref-Papatheodorou2018-jy)). A
particularly useful resource, when working with `spatialHeatmap`, is the EBI
Expression Atlas. This online service contains both assay and anatomical
images. Its assay data include mRNA and protein profiling experiments for
different species, tissues and conditions. The corresponding anatomical image
collections are also provided for a wide range of species including animals and
plants. In `spatialHeatmap` several import functions are provided to work with
the expression and [aSVG repository](#svg_repo) from the Expression Atlas
directly. The aSVG images developed by the `spatialHeatmap` project are
available in its own repository called [spatialHeatmap aSVG
Repository](https://github.com/jianhaizhang/SHM_SVG),
where users can contribute their aSVG images that are formatted according to
our guidlines.

## 1.5 Tutorial Overview

The following sections of this vignette showcase the most important
functionalities of the `spatialHeatmap` package using as initial example a simple
to understand testing data set, and then more complex mRNA profiling data from the
Expression Atlas and GEO databases. The co-visualization functionality is explained in a separate vignette (see [SCSHM-CoViz](https://www.bioconductor.org/packages/release/bioc/vignettes/spatialHeatmap/inst/doc/covisualize.html)).
First, SHM plots are generated for both the testing
and mRNA expression data. The latter include gene expression data sets from
RNA-Seq and microarray experiments of [Human Brain](#hum), [Mouse
Organs](#mus), [Chicken Organs](#chk), and [Arabidopsis Shoots](#shoot). The
first three are RNA-Seq data from the [Expression
Atlas](https://www.ebi.ac.uk/gxa/home), while the last one is a microarray data
set from [GEO](https://www.ncbi.nlm.nih.gov/geo/). Second, gene context
analysis tools are introduced, which facilitate the visualization of
gene modules sharing similar expression patterns. This includes the
visualization of hierarchical clustering results with traditional matrix
heatmaps ([Matrix Heatmap](#mhm)) as well as co-expression network plots
([Network](#net)). Third, the [Spatial Enrichment](#se) functionality is illustrated
with mouse RNA-seq data. Lastly, an overview of the corresponding [Shiny App](#shiny)
is presented that provides access to the same functionalities as the R
functions, but executes them in an interactive GUI environment (Chang et al. [2021](#ref-shiny); Chang and Borges Ribeiro [2018](#ref-shinydashboard)).

# 2 Getting Started

## 2.1 Installation

The `spatialHeatmap` package should be installed from an R (version \(\ge\) 3.6)
session with the `BiocManager::install` command.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("spatialHeatmap")
```

## 2.2 Packages and Documentation

Next, the packages required for running the sample code in this vignette need to be loaded.

```
library(spatialHeatmap); library(SummarizedExperiment); library(ExpressionAtlas); library(GEOquery); library(igraph); library(BiocParallel); library(kableExtra); library(org.Hs.eg.db); library(org.Mm.eg.db); library(ggplot2)
```

The following lists the vignette(s) of this package in an HTML browser. Clicking the corresponding name will open this vignette.

```
browseVignettes('spatialHeatmap')
```

To reduce runtime, intermediate results can be cached under `~/.cache/shm`.

```
cache.pa <- '~/.cache/shm' # Path of the cache directory.
```

A temporary directory is created to save output files.

```
tmp.dir <- normalizePath(tempdir(check=TRUE), winslash="/", mustWork=FALSE)
```

# 3 Spatial Heatmaps

## 3.1 Quick Start

Spatial Heatmaps (SHMs) are plotted with the `shm` function. To provide a quick
and intuitive overview how these plots are generated, the following uses a
generalized tesing example where a small vector of random numeric values is
generated that are used to color features in an aSVG image. The image chosen
for this example is an aSVG depicting the human brain. The corresponding image
file `homo_sapiens.brain.svg` is included in this package for testing purposes.

### 3.1.1 aSVG Image

After the full path to the chosen target aSVG image on a user’s system is
obtained with the `system.file` function, the function `read_svg` is used to import the aSVG information relevant for creating SHMs, which is stored in an `SVG` object
`svg.hum`.

```
svg.hum.pa <- system.file("extdata/shinyApp/data", 'homo_sapiens.brain.svg', package="spatialHeatmap")
svg.hum <- read_svg(svg.hum.pa)
```

All features and their attributes can be accessed with the `attribute`
function, where `fill` and `stroke` are the two most important ones providing
color and line width information, respectively. The `feature` column includes group labels for sub-features in the `sub.feature` column. SHM plots are created by mapping assay data to labels in `feature`.

```
feature.hum <- attribute(svg.hum)[[1]]
tail(feature.hum[, 1:6], 3) # Partial features and respective attributes
## # A tibble: 3 × 6
##   feature                 id             fill  stroke sub.feature          index
##   <chr>                   <chr>          <chr>  <dbl> <chr>                <int>
## 1 cerebellar.hemisphere   UBERON_0002245 none   0.016 cerebellar.hemisphe…   247
## 2 nucleus.accumbens       UBERON_0001882 none   0.016 nucleus.accumbens      248
## 3 telencephalic.ventricle UBERON_0002285 none   0.016 telencephalic.ventr…   249
```

Feature coordinates can be accessed with the `coordinate` function.

```
coord.df <- coordinate(svg.hum)[[1]]
tail(coord.df, 3) # Partial features and respective coordinates
## # A tibble: 3 × 4
##       x     y feature                 index
##   <dbl> <dbl> <chr>                   <int>
## 1  194.  326. telencephalic.ventricle   249
## 2  194.  326. telencephalic.ventricle   249
## 3  194.  326. telencephalic.ventricle   249
```

### 3.1.2 Numeric Data

The following generates a small named vector for testing,
where the data slot contains four numbers, and the name slot is populated with
three feature names and one missing one (here ’notMapped"). The numbers
are mapped to features (`feature.hum`) via matching names among the numeric vector and the aSVG,
respectively. Accordingly, only numbers and features with matching name
counterparts can be colored in the aSVG image. In addition, a summary of the numeric assay to feature mappings is stored
in a `data.frame` returned by the `shm` function (see below).

```
set.seed(20) # To obtain reproducible results, a fixed seed is set.
unique(feature.hum$feature)[1:10]
##  [1] "g4320"                 "locus.ceruleus"        "diencephalon"
##  [4] "medulla.oblongata"     "middle.temporal.gyrus" "caudate.nucleus"
##  [7] "middle.frontal.gyrus"  "occipital.lobe"        "parietal.lobe"
## [10] "pineal.gland"
my_vec <- setNames(sample(1:100, 4), c('substantia.nigra', 'putamen', 'prefrontal.cortex', 'notMapped'))
my_vec
##  substantia.nigra           putamen prefrontal.cortex         notMapped
##                38                63                 2                29
```

### 3.1.3 Plot SHM

Before plotting SHMs, the aSVG instance and numeric data are stored in an `SPHM` object for the sake of efficient data management and reusability.

```
dat.quick <- SPHM(svg=svg.hum, bulk=my_vec)
```

Next, the SHM is plotted with the `shm` function (Figure
[2](#fig:testshm)). Internally, the numbers in `my_vec` are translated into
colors based on the color key and then
painted onto the corresponding features in the aSVG. In the given example
(Figure [2](#fig:testshm)) only three features (‘substantia.nigra’, ‘putamen’, and ‘prefrontal.cortex’) in the aSVG have matching entries in the data `my_vec`.

```
shm.res <- shm(data=dat.quick, ID='testing', ncol=1, sub.title.size=20, legend.nrow=3)
```

![SHM of human brain with testing data. The plots from the left to the right represent the color key for the numeric data, followed by four SHM plots and the legend of the spatial features. The numeric values provided in `my_vec` are used to color the corresponding features in the SHM plots according to the color key while the legend plot identifies the spatial regions.](data:image/png;base64...)

Figure 2: SHM of human brain with testing data
The plots from the left to the right represent the color key for the numeric data, followed by four SHM plots and the legend of the spatial features. The numeric values provided in `my_vec` are used to color the corresponding features in the SHM plots according to the color key while the legend plot identifies the spatial regions.

The named numeric values in `my_vec`, that have name matches with the features in the
chosen aSVG, are stored in the `mapped_feature` slot.

```
# Mapped features
spatialHeatmap::output(shm.res)$mapped_feature
##        ID           feature value    fill                    SVG
## 1 testing  substantia.nigra    38 #FF8700 homo_sapiens.brain.svg
## 2 testing           putamen    63 #FF0000 homo_sapiens.brain.svg
## 3 testing prefrontal.cortex     2 #FFFF00 homo_sapiens.brain.svg
```

## 3.2 Human Brain

This subsection introduces how to query and download cell- and tissue-specific assay data in
the Expression Atlas database using the `ExpressionAtlas` package (Keays [2019](#ref-ebi)). After the choosen data is downloaded directly into a user's R session, the
expression values for selected genes can be plotted onto a chosen aSVG image with
or without prior preprocessing steps (*e.g.* normalization).

### 3.2.1 Gene Expression Data

The following example searches the Expression Atlas for expression data derived from
specific tissues and species of interest, here *‘cerebellum’* and *‘Homo sapiens’*,
respectively.

```
all.hum <- read_cache(cache.pa, 'all.hum') # Retrieve data from cache.
if (is.null(all.hum)) { # Save downloaded data to cache if it is not cached.
  all.hum <- searchAtlasExperiments(properties="cerebellum", species="Homo sapiens")
  save_cache(dir=cache.pa, overwrite=TRUE, all.hum)
}
```

The search result contains 15
accessions. In the following code, the
accession
‘[E-GEOD-67196](https://www.ebi.ac.uk/arrayexpress/experiments/E-GEOD-67196/)’
from Prudencio *et al.* ([2015](#ref-Prudencio2015-wd)) has been chosen, which corresponds
to an RNA-Seq profiling experiment of *‘cerebellum’* and *‘frontal cortex’* brain
tissue from patients with amyotrophic lateral sclerosis (ALS).

```
all.hum[2, ]
```

```
## DataFrame with 1 row and 4 columns
##      Accession      Species                  Type                  Title
##    <character>  <character>           <character>            <character>
## 1 E-GEOD-75852 Homo sapiens RNA-seq of coding RNA Human iPSC-Derived C..
```

The `getAtlasData` function allows to download the chosen RNA-Seq experiment
from the Expression Atlas and import it into a `RangedSummarizedExperiment`
object.

```
rse.hum <- read_cache(cache.pa, 'rse.hum') # Read data from cache.
if (is.null(rse.hum)) { # Save downloaded data to cache if it is not cached.
  rse.hum <- getAtlasData('E-GEOD-67196')[[1]][[1]]
  save_cache(dir=cache.pa, overwrite=TRUE, rse.hum)
}
```

The design of the downloaded RNA-Seq experiment is described in the `colData` slot of
`rse.hum`. The following returns only its first four rows and columns.

```
colData(rse.hum)[1:2, c(2, 4)]
## DataFrame with 2 rows and 2 columns
##                organism  organism_part
##             <character>    <character>
## SRR1927019 Homo sapiens     cerebellum
## SRR1927020 Homo sapiens frontal cortex
```

### 3.2.2 aSVG Image

The following example shows how to download from the above described [SVG
repositories](#data_repo) an aSVG image that matches the tissues and species
assayed in the gene expression data set downloaded above.
The `return_feature` function queries the repository for feature- and
species-related keywords, here `c('frontal cortex', 'cerebellum')` and `c('homo sapiens', 'brain')`, respectively.

The remote data are downloaded before calling `return_feature`.

```
# Remote aSVG repos.
data(aSVG.remote.repo)
tmp.dir.ebi <- file.path(tmp.dir, 'ebi.zip')
tmp.dir.shm <- file.path(tmp.dir, 'shm.zip')
# Download the remote aSVG repos as zip files.
download.file(aSVG.remote.repo$ebi, tmp.dir.ebi)
download.file(aSVG.remote.repo$shm, tmp.dir.shm)
remote <- list(tmp.dir.ebi, tmp.dir.shm)
```

The downloaded aSVG repos are queried and returned aSVG files are saved in an empty directory (`tmp.dir`) to avoid overwriting of existing SVG files.

```
tmp.dir <- file.path(tempdir(check=TRUE), 'shm') # Empty directory.
```

```
feature.df.hum <- return_feature(feature=c('frontal cortex', 'cerebellum'), species=c('homo sapiens', 'brain'), dir=tmp.dir, remote=remote) # Query aSVGs
feature.df.hum[1:8, ] # Return first 8 rows for checking
unique(feature.df.hum$SVG) # Return all matching aSVGs
```

To build this vignettes according to Bioconductor’s package requirements, the
following code section uses aSVG file instances included in the
`spatialHeatmap` package rather than the downloaded instances above.

```
svg.dir <- system.file("extdata/shinyApp/data", package="spatialHeatmap") # Directory of the aSVG collection in spatialHeatmap
feature.df.hum <- return_feature(feature=c('frontal cortex', 'cerebellum'), species=c('homo sapiens', 'brain'), keywords.any=TRUE, return.all=FALSE, dir=svg.dir, remote=NULL)
```

Note, the target tissues `frontal cortex` and `cerebellum` are included in both
the experimental design slot of the downloaded expression data as well as the
annotations of the aSVG. This way these features can be colored in the downstream
SHM plots. If necessary users can also change from within R the feature identifiers in an aSVG (see [Supplementary Section](#update)).

```
tail(feature.df.hum[, c('feature', 'stroke', 'SVG')], 3)
## # A tibble: 3 × 3
##   feature             stroke SVG
##   <chr>                <dbl> <chr>
## 1 cerebral.cortex      0.1   mus_musculus.brain_sp.svg
## 2 cerebellum           0.1   mus_musculus.brain_sp.svg
## 3 somatosensor.cortex  0.100 mus_musculus.brain_sp.svg
```

Among the returned aSVG files, `homo_sapiens.brain.svg` is chosen for creating SHMs. Since it is the same as the [Quick Start](#test), the aSVG stored in `svg.hum` is used in the downstream steps.

### 3.2.3 Experimental Design

To display ‘pretty’ sample names in columns and legends of downstream tables and plots respectively, the following example imports a ‘targets’ file that can be customized by users in a text program. The targets file content is used to replace the text in the
`colData` slot of the `RangedSummarizedExperiment` object with a version containing
shorter sample names for plotting purposes.

The custom targets file is imported and then loaded into `colData` slot of `rse.hum`. A slice of the simplified `colData` object is shown below.

```
hum.tar <- system.file('extdata/shinyApp/data/target_human.txt', package='spatialHeatmap')
target.hum <- read.table(hum.tar, header=TRUE, row.names=1, sep='\t') # Importing
colData(rse.hum) <- DataFrame(target.hum) # Loading to "colData"
colData(rse.hum)[c(1:2, 41:42), 4:5]
## DataFrame with 4 rows and 2 columns
##             organism_part     disease
##               <character> <character>
## SRR1927019     cerebellum         ALS
## SRR1927020 frontal cortex         ALS
## SRR1927059     cerebellum      normal
## SRR1927060 frontal cortex      normal
```

### 3.2.4 Preprocess Assay Data

The raw count gene expression data is stored
in the `assay` slot of `rse.hum`. The following shows how to apply basic preprocessing routines on the count data, such as normalizing, aggregating replicates, and removing genes with unreliable expression responses, which are optional for plotting SHMs.

The `norm_data` function is developed to normalize RNA-seq raw count data. The following example uses the `ESF` normalization option due to its good time performance, which is `estimateSizeFactors` from DESeq2 (Love, Huber, and Anders [2014](#ref-deseq2)).

```
se.nor.hum <- norm_data(data=rse.hum, norm.fun='ESF', log2.trans=TRUE)
```

Replicates are aggregated with the summary
statistics chosen under the `aggr` argument (*e.g.* `aggr='mean'`). The
columns specifying replicates can be assigned to the `sam.factor` and
`con.factor` arguments corresponding to samples and conditions, respectively.
For tracking, the corresponding sample/condition labels are used as column
titles in the aggregated `assay` instance, where they are concatenated with a
double underscore as separator (Table [1](#tab:humtab)).

```
se.aggr.hum <- aggr_rep(data=se.nor.hum, sam.factor='organism_part', con.factor='disease', aggr='mean')
assay(se.aggr.hum)[c(120, 49939, 49977), ]
```

Table 1: Table 2: Slice of aggregated expression matrix.

|  | cerebellum\_\_ALS | frontal.cortex\_\_ALS | cerebellum\_\_normal | frontal.cortex\_\_normal |
| --- | --- | --- | --- | --- |
| ENSG00000006047 | 1.134172 | 5.2629629 | 0.5377534 | 5.3588310 |
| ENSG00000268433 | 5.324064 | 0.3419665 | 3.4780744 | 0.1340332 |
| ENSG00000268555 | 5.954572 | 2.6148548 | 4.9349736 | 2.0351776 |

The filtering example below retains genes with expression values
larger than 5 (log2 space) in at least 1% of all samples (`pOA=c(0.01, 5)`), and
a coefficient of variance (CV) between 0.30 and 100 (`CV=c(0.30, 100)`). After that, the Ensembl gene ids are converted to UniProt ids with the function `cvt_id`.

```
se.fil.hum <- filter_data(data=se.aggr.hum, sam.factor='organism_part', con.factor='disease', pOA=c(0.01, 5), CV=c(0.3, 100))
se.fil.hum <- cvt_id(db='org.Hs.eg.db', data=se.fil.hum, from.id='ENSEMBL', to.id='SYMBOL')
```

### 3.2.5 SHM: Multiple Genes

Spatial features of interest can be subsetted with the function `sub_sf` by assigning their indexes (see below) to the argument `show`. In the following, ‘brain outline’, ‘prefrontal.cortex’, ‘frontal.cortex’, and ‘cerebellum’ are subsetted.

Next, for efficient data management and reusability the subset aSVG and assay data are stored in an `SPHM` object.

```
# Subsetting aSVG features.
svg.hum.sub <- sub_sf(svg.hum, show=c(64:132, 162:163, 164, 190:218))
tail(attribute(svg.hum.sub)[[1]][, 1:6], 3)
## # A tibble: 3 × 6
##   feature    id             fill  stroke sub.feature    index
##   <chr>      <chr>          <chr>  <dbl> <chr>          <int>
## 1 cerebellum UBERON_0002037 none   0.016 cerebellum_2_4   216
## 2 cerebellum UBERON_0002037 none   0.016 cerebellum_2_3   217
## 3 cerebellum UBERON_0002037 none   0.016 cerebellum_2_2   218
# Storing assay data and subsetted aSVG in an 'SPHM' object.
dat.hum <- SPHM(svg=svg.hum.sub, bulk=se.fil.hum)
```

SHMs for multiple genes can be plotted by providing the
corresponding gene IDs under the `ID` argument as a character vector. The
`shm` function will then sequentially arrange the SHMs for
each gene in a single composite plot. To facilitate comparisons among expression
values across genes and/or conditions, the `lay.shm` parameter can be assigned
`gene` or `con`, respectively. For instance, in Figure [3](#fig:mul) the
SHMs of the genes `OLFM4` and `PRSS22` are organized
by condition in a horizontal view. This functionality is particularly useful when comparing associated genes such as gene families.

```
res.hum <- shm(data=dat.hum, ID=c('OLFM4', 'PRSS22'), lay.shm='con', legend.r=1.5, legend.nrow=3, h=0.6)
```

![SHMs of two genes. The subplots are organized by 'condition'. Only cerebellum and frontal cortex are colored, because they are present in both the aSVG and the expression data.](data:image/png;base64...)

Figure 3: SHMs of two genes
The subplots are organized by ‘condition’. Only cerebellum and frontal cortex are colored, because they are present in both the aSVG and the expression data.

In the above example, the normalized expression values of chosen genes
are used to color the frontal cortex and cerebellum, where the different conditions,
here normal and ALS, are given in separate SHMs. The color and feature mappings are defined
by the corresponding color key and legend plot on the left and right, respectively.

By default, spatial features in assay data are mapped to their counterparts in aSVG according to the same identifiers on a one-to-one basis. However, the mapping can be customized, such as mapping a spatial feature in the data to a different or multiple counterparts in the aSVG. This advanced functionality is demonstrated in the [Supplementary Section](#remat).

### 3.2.6 SHM: Other Selected Features

SHMs can be saved to interactive HTML files as well as video files. Each HTML file
contains an interactive SHM with zooming in and out functionality. Hovering over
graphics features will display data, gene, condition and other information. The
video will play the SHM subplots in the order specified under the `lay.shm`
argument.

The following example saves the interactive HTML and video files under the directory `tmp.dir`.

```
shm(data=dat.hum, ID=c('OLFM4', 'PRSS22'), lay.shm='con', legend.r=1.5, legend.nrow=3, h=0.6, aspr=2.3, animation.scale=0.7, bar.width=0.1, bar.value.size=4, out.dir=tmp.dir)
```

The following code saves individual SHMs into the same SVG file `shm_hum.svg` with the color scale and legend plot included.

```
res <- shm(data=dat.hum, ID=c('OLFM4', 'PRSS22'), lay.shm='con', legend.r=1.5, legend.nrow=3, h=0.5, aspr=2.3, animation.scale=0.7, bar.width=0.08, bar.value.size=12)
ggsave(file="./shm_hum.svg", plot=output(res)$spatial_heatmap, width=10, height=8)
```

The following code exports each SHM (associated with a specific gene and condition) as separate SVG files in `tmp.dir`. In contrast to the original aSVG file, spatial features in the output SVG files are assigned heat colors.

```
write_svg(input=res, out.dir=tmp.dir)
```

A meta function `plot_meta` is developed as a wraper of individual steps necessary for plotting SHMs. The benefit of this function is creating SHMs with the Linux command line as shown below.

```
Rscript -e "spatialHeatmap::plot_meta(svg.path=system.file('extdata/shinyApp/data', 'mus_musculus.brain.svg', package='spatialHeatmap'), bulk=system.file('extdata/shinyApp/data', 'bulk_mouse_cocluster.rds', package='spatialHeatmap'), sam.factor='tissue', aggr='mean', ID=c('AI593442', 'Adora1'), ncol=1, bar.width=0.1, legend.nrow=5, h=0.6)"
```

### 3.2.7 SHM: Customization

To provide a high level of flexibility, many arguments are developed for `shm`.
An overview of important arguments and their utility is provided in Table [3](#tab:arg).

Table 3: Table 4: List of important argumnets of ‘shm’.

|  | argument | description |
| --- | --- | --- |
| 1 | data | An SPHM object containing assay data and aSVG (s). |
| 2 | sam.factor | Applies to SummarizedExperiment (SE). Column name of sample replicates in colData slot. Default is NULL |
| 3 | con.factor | Applies to SE. Column name of condition replicates in colData slot. Default is NULL |
| 4 | ID | A character vector of row items for plotting spatial heatmaps |
| 5 | col.com | A character vector of color components for building colour scale. Default is c(‘yellow’, ‘orange’,‘red’) |
| 6 | col.bar | ‘selected’ or ‘all’, the former means use values of ID to build the colour scale while the latter use all values in data. Default is ‘selected’. |
| 7 | bar.width | A numeric of colour bar width. Default is 0.7 |
| 8 | trans.scale | One of ‘log2’, ‘exp2’, ‘row’, ‘column’, or NULL, which means transform the data by ‘log2’ or ‘2-base expoent’, scale by ‘row’ or ‘column’, or no manipuation respectively. |
| 9 | ft.trans | A vector of aSVG features to be transparent. Default is NULL. |
| 10 | legend.r | A numeric to adjust the dimension of the legend plot. Default is 1. The larger, the higher ratio of width to height. |
| 11 | sub.title.size | The title size of each spatial heatmap subplot. Default is 11. |
| 12 | lay.shm | ‘gen’ or ‘con’, applies to multiple genes or conditions respectively. ‘gen’ means spatial heatmaps are organised by genes while ‘con’ organised by conditions. Default is ‘gen’ |
| 13 | ncol | The total column number of spatial heatmaps, not including legend plot. Default is 2. |
| 14 | ft.legend | ‘identical’, ‘all’, or a vector of samples/features in aSVG to show in legend plot. ‘identical’ only shows matching features while ‘all’ shows all features. |
| 15 | legend.ncol, legend.nrow | Two numbers of columns and rows of legend keys respectively. Default is NULL, NULL, since they are automatically set. |
| 16 | legend.position | the position of legend keys (‘none’, ‘left’, ‘right’,‘bottom’, ‘top’), or two-element numeric vector. Default is ‘bottom’. |
| 17 | legend.key.size, legend.text.size | The size of legend keys and labels respectively. Default is 0.5 and 8 respectively. |
| 18 | line.size, line.color | The size and colour of all plogyon outlines respectively. Default is 0.2 and ‘grey70’ respectively. |
| 19 | verbose | TRUE or FALSE. Default is TRUE and the aSVG features not mapped are printed to R console. |
| 20 | out.dir | The directory to save HTML and video files of spatial heatmaps. Default is NULL. |

## 3.3 Mouse Organs

This section generates an SHM plot for mouse data from the Expression Atlas.
The code components are very similar to the previous [Human Brain](#hum)
example. For brevity, the corresponding text explaining the code has
been reduced to a minimum.

### 3.3.1 Gene Expression Data

The chosen mouse RNA-Seq data compares tissue level gene expression across
mammalian species (Merkin et al. [2012](#ref-Merkin2012-ak)). The following searches the Expression
Atlas for expression data from *‘kidney’* and *‘Mus musculus’*.

```
all.mus <- read_cache(cache.pa, 'all.mus') # Retrieve data from cache.
if (is.null(all.mus)) { # Save downloaded data to cache if it is not cached.
  all.mus <- searchAtlasExperiments(properties="kidney", species="Mus musculus")
  save_cache(dir=cache.pa, overwrite=TRUE, all.mus)
}
```

Among the many matching entries, accession ‘E-MTAB-2801’ will be downloaded.

```
all.mus[7, ]
rse.mus <- read_cache(cache.pa, 'rse.mus') # Read data from cache.
if (is.null(rse.mus)) { # Save downloaded data to cache if it is not cached.
  rse.mus <- getAtlasData('E-MTAB-2801')[[1]][[1]]
  save_cache(dir=cache.pa, overwrite=TRUE, rse.mus)
}
```

The design of the downloaded RNA-Seq experiment is described in the `colData` slot of
`rse.mus`. The following returns only its first three rows.

```
colData(rse.mus)[1:3, ]
## DataFrame with 3 rows and 4 columns
##           AtlasAssayGroup     organism organism_part      strain
##               <character>  <character>   <character> <character>
## SRR594393              g7 Mus musculus         brain      DBA/2J
## SRR594394             g21 Mus musculus         colon      DBA/2J
## SRR594395             g13 Mus musculus         heart      DBA/2J
```

### 3.3.2 aSVG Image

The following example shows how to retrieve from the [remote SVG
repositories](#data_repo) an aSVG image that matches the tissues and species
assayed in the downloaded data above. The sample data from [Human Brain](#humSVG) are used such as `remote`.

```
feature.df.mus <- return_feature(feature=c('heart', 'kidney'), species=c('Mus musculus'), dir=tmp.dir, remote=remote)
```

To meet the R/Bioconductor package requirements, the following uses aSVG file instances included in the
`spatialHeatmap` package rather than the downloaded instances.

```
feature.df.mus <- return_feature(feature=c('heart', 'kidney'), species=NULL, dir=svg.dir, remote=NULL)
```

Return the names of the matching aSVG files.

```
unique(feature.df.mus$SVG)
## [1] "gallus_gallus.svg"     "mus_musculus.male.svg"
```

The `mus_musculus.male.svg` instance is selected and imported.

```
svg.mus.pa <- system.file("extdata/shinyApp/data", "mus_musculus.male.svg", package="spatialHeatmap")
svg.mus <- read_svg(svg.mus.pa)
```

### 3.3.3 Experimental Design

A sample target file that is included in this package is imported and then loaded to the `colData` slot of `rse.mus`. To inspect its content, the first three rows are shown.

```
mus.tar <- system.file('extdata/shinyApp/data/target_mouse.txt', package='spatialHeatmap')
target.mus <- read.table(mus.tar, header=TRUE, row.names=1, sep='\t') # Importing
colData(rse.mus) <- DataFrame(target.mus) # Loading
target.mus[1:3, ]
##           AtlasAssayGroup     organism organism_part strain
## SRR594393              g7 Mus musculus         brain DBA.2J
## SRR594394             g21 Mus musculus         colon DBA.2J
## SRR594395             g13 Mus musculus         heart DBA.2J
```

### 3.3.4 Preprocess Assay Data

The raw RNA-Seq counts are preprocessed with the following steps: (1)
normalization, (2) aggregation of replicates, and (3) filtering of un-reliable
expression data. The details of these steps are explained in the sub-section of the [Human Brain](#humSVG) example.

```
rse.mus <- cvt_id(db='org.Mm.eg.db', data=rse.mus, from.id='ENSEMBL', to.id='SYMBOL', desc=TRUE) # Convert Ensembl ids to UniProt ids.
se.nor.mus <- norm_data(data=rse.mus, norm.fun='CNF', log2.trans=TRUE) # Normalization
se.aggr.mus <- aggr_rep(data=se.nor.mus, sam.factor='organism_part', con.factor='strain', aggr='mean') # Aggregation of replicates
se.fil.mus <- filter_data(data=se.aggr.mus, sam.factor='organism_part', con.factor='strain', pOA=c(0.01, 5), CV=c(0.6, 100)) # Filtering of genes with low counts and variance
```

### 3.3.5 SHM: Transparency

The pre-processed expression data for gene `Scml2` is plotted in form
of an SHM. In this case the plot includes expression data for 8 tissues across 3
mouse strains.

```
dat.mus <- SPHM(svg=svg.mus, bulk=se.fil.mus)
shm(data=dat.mus, ID=c('H19'), legend.width=0.7, legend.text.size=10, sub.title.size=9, ncol=3, ft.trans=c('skeletal muscle'), legend.ncol=2, line.size=0.2, line.color='grey70')
```

![SHM of mouse organs. This is a multiple-layer image where the shapes of the 'skeletal muscle' is set transparent to expose 'lung' and 'heart'.](data:image/png;base64...)

Figure 4: SHM of mouse organs
This is a multiple-layer image where the shapes of the ‘skeletal muscle’ is set transparent to expose ‘lung’ and ‘heart’.

The SHM plots in Figures [4](#fig:musshm) and below demonstrate
the usage of the transparency feature via the `ft.trans` parameter. The
corresponding mouse organ aSVG image includes overlapping tissue layers. In
this case the skelectal muscle layer partially overlaps with lung and heart
tissues. To view lung and heart in Figure [4](#fig:musshm), the skelectal
muscle tissue is set transparent with `ft.trans=c('skeletal muscle')`.

To fine control the visual effects in feature rich aSVGs, the `line.size` and
`line.color` parameters are useful. This way one can adjust the thickness and
color of complex structures.

```
gg <- shm(data=dat.mus, ID=c('H19'), legend.text.size=10, sub.title.size=9, ncol=3, legend.ncol=2, line.size=0.1, line.color='grey70')
```

![SHM of mouse organs. This is a multiple-layer image where the view onto 'lung' and 'heart' is obstructed by displaying the 'skeletal muscle' tissue.](data:image/png;base64...)

Figure 5: SHM of mouse organs
This is a multiple-layer image where the view onto ‘lung’ and ‘heart’ is obstructed by displaying the ‘skeletal muscle’ tissue.

A third example on real data from Expression Atlas is SHMs of time series across chicken organs. Since the procedures are the same with the examples above, this example is illustrated in the [Supplementary Section](#chk).

## 3.4 Arabidopsis Shoot

This section generates an SHM for *Arabidopsis thaliana* tissues with gene expression
data from the Affymetrix microarray technology. The chosen experiment used
ribosome-associated mRNAs from several cell populations of shoots and roots that were
exposed to hypoxia stress (Mustroph et al. [2009](#ref-Mustroph2009-nu)). In this case the expression data
will be downloaded from [GEO](https://www.ncbi.nlm.nih.gov/geo/) with utilites
from the `GEOquery` package (Davis and Meltzer [2007](#ref-geo)). The data preprocessing routines are
specific to the Affymetrix technology. The remaining code components for
generating SHMs are very similar to the previous examples. For brevity, the
text in this section explains mainly the steps that are specific to this data
set.

### 3.4.1 Gene Expression Data

The GSE14502 data set is downloaded with the `getGEO` function from the `GEOquery` package. Intermediately, the expression data is stored in an
`ExpressionSet` container (Huber et al. [2015](#ref-biobase)), and then converted to a
`SummarizedExperiment` object.

```
gset <- read_cache(cache.pa, 'gset') # Retrieve data from cache.
if (is.null(gset)) { # Save downloaded data to cache if it is not cached.
  gset <- getGEO("GSE14502", GSEMatrix=TRUE, getGPL=TRUE)[[1]]
  save_cache(dir=cache.pa, overwrite=TRUE, gset)
}
se.sh <- as(gset, "SummarizedExperiment")
```

The gene symbol identifiers are extracted from the `rowData` component to be used
as row names. Similarly, one can work with AGI identifiers by providing below `AGI`
under `Gene.Symbol`.

```
rownames(se.sh) <- make.names(rowData(se.sh)[, 'Gene.Symbol'])
```

A slice of the experimental design stored in the
`colData` slot is returned. Both the samples and treatments are contained in the `title` column.
The samples are indicated by corresponding promoters (pGL2, pCO2, pSCR, pWOL, p35S) and treatments include control and hypoxia.

```
colData(se.sh)[60:63, 1:2]
## DataFrame with 4 rows and 2 columns
##                            title geo_accession
##                      <character>   <character>
## GSM362227 shoot_hypoxia_pGL2_r..     GSM362227
## GSM362228 shoot_hypoxia_pGL2_r..     GSM362228
## GSM362229 shoot_control_pRBCS_..     GSM362229
## GSM362230 shoot_control_pRBCS_..     GSM362230
```

### 3.4.2 aSVG Image

In this example, the aSVG image has been generated in Inkscape from
the corresponding figure in Mustroph et al. ([2009](#ref-Mustroph2009-nu)). Detailed instructions for generating custom aSVG images are provided in the
[SVG tutorial](https://jianhaizhang.github.io/SHM_SVG). The resulting custom aSVG file ‘arabidopsis.thaliana\_shoot\_shm.svg’ is included in the `spatialHeatmap` package and imported as below.

```
svg.sh.pa <- system.file("extdata/shinyApp/data", "arabidopsis.thaliana_shoot_shm.svg", package="spatialHeatmap")
svg.sh <- read_svg(svg.sh.pa)
```

### 3.4.3 Experimental Design

A sample target file that is included in this package is imported and then loaded to the `colData` slot of `se.sh`. To inspect its content, four selected rows are returned.

```
sh.tar <- system.file('extdata/shinyApp/data/target_arab.txt', package='spatialHeatmap')
target.sh <- read.table(sh.tar, header=TRUE, row.names=1, sep='\t') # Importing
colData(se.sh) <- DataFrame(target.sh) # Loading
target.sh[60:63, ]
##                           col.name     samples conditions
## shoot_hypoxia_pGL2_rep1  GSM362227  shoot_pGL2    hypoxia
## shoot_hypoxia_pGL2_rep2  GSM362228  shoot_pGL2    hypoxia
## shoot_control_pRBCS_rep1 GSM362229 shoot_pRBCS    control
## shoot_control_pRBCS_rep2 GSM362230 shoot_pRBCS    control
```

### 3.4.4 Preprocess Assay Data

The downloaded GSE14502 data set has already been normalized with the RMA
algorithm (Gautier et al. [2004](#ref-affy)). Thus, the pre-processing steps can be restricted to replicate aggregation and filtering.

```
se.aggr.sh <- aggr_rep(data=se.sh, sam.factor='samples', con.factor='conditions', aggr='mean') # Replicate agggregation using mean
se.fil.arab <- filter_data(data=se.aggr.sh, sam.factor='samples', con.factor='conditions', pOA=c(0.03, 6), CV=c(0.30, 100)) # Filtering of genes with low intensities and variance
```

### 3.4.5 SHM: Microarray

The expression profile for the HRE2 gene is plotted for the control and the hypoxia treatment
across six cell types (Figure [6](#fig:shshm)).

```
dat.sh <- SPHM(svg=svg.sh, bulk=se.fil.arab)
shm(data=dat.sh, ID=c("HRE2"), legend.ncol=2, legend.text.size=10, legend.key.size=0.02)
```

![SHM of Arabidopsis shoots. The expression profile of the HRE2 gene is plotted for control and hypoxia treatment across six cell types.](data:image/png;base64...)

Figure 6: SHM of Arabidopsis shoots
The expression profile of the HRE2 gene is plotted for control and hypoxia treatment across six cell types.

## 3.5 Superimposing raster and vector graphics

`spatialHeatmap` allows to superimpose raster images with vector-based SHMs. This
way one can generate SHMs that resemble photographic representations
of tissues, organs or entire organisms. For this to work the shapes represented in the
vector-graphics need to be an aligned carbon copy of the raster image.
Supported file formats for the raster image are JPG/JPEG and PNG, and for the
vector image it is SVG. Matching raster and vector graphics are indicated by
identical base names in their file names (*e.g.* imageA.png and imageA.svg).
The layout order in SHMs composed of multiple independent images can be
controlled by numbering the corresponding file pairs accordingly such as
imageA\_1.png and imageA\_1.svg, imageA\_2.png and imageA\_2.svg, *etc*.

In the following example, the required image pairs have been pre-generated from
a study on abaxial bundle sheath (ABS) cells in maize leaves
(Bezrutczyk et al. [2021](#ref-Bezrutczyk2021-fq)). Their file names are labeled 1 and 2 to indicate two
developmental stages.

Import paths of first png/svg image pair:

```
raster.pa1 <- system.file('extdata/shinyApp/data/maize_leaf_shm1.png', package='spatialHeatmap')
svg.pa1 <- system.file('extdata/shinyApp/data/maize_leaf_shm1.svg', package='spatialHeatmap')
```

Import paths of second png/svg image pair:

```
raster.pa2 <- system.file('extdata/shinyApp/data/maize_leaf_shm2.png', package='spatialHeatmap')
svg.pa2 <- system.file('extdata/shinyApp/data/maize_leaf_shm2.svg', package='spatialHeatmap')
```

The two pairs of png/svg images are imported in the `SVG` container `svg.overlay`.

```
svg.overlay <- read_svg(svg.path=c(svg.pa1, svg.pa2), raster.path=c(raster.pa1, raster.pa2))
```

A slice of attributes in the first aSVG instance is shown.

```
attribute(svg.overlay)[[1]][1:3, ]
## # A tibble: 3 × 10
##   feature id      fill    stroke sub.feature index element parent    index.all
##   <chr>   <chr>   <chr>    <dbl> <chr>       <int> <chr>   <chr>         <int>
## 1 rect817 rect817 none    0.0843 rect817         1 rect    container         1
## 2 cell1   cell1   #98f0aa 0      path819         2 g       container         2
## 3 cell1   cell1   #98f0aa 0      path821         3 g       container         2
## # ℹ 1 more variable: index.sub <int>
```

Create random quantitative assay data.

```
df.ovl <- data.frame(matrix(runif(6, min=0, max=5), nrow=3))
colnames(df.ovl) <- c('cell1', 'cell2') # Assign column names.
rownames(df.ovl) <- paste0('gene', seq_len(3)) # Assign row names
df.ovl[1:2, ]
##          cell1       cell2
## gene1 1.637970 3.788981771
## gene2 1.850373 0.009639693
```

To minimize masking of the features in the SHMs by dense regions in the raster images,
the `alpha.overlay` argument allows to adjust the transparency level. In Figure [7](#fig:overCol),
the spatial features of interest are superimposed onto the raster image.

```
dat.over <- SPHM(svg=svg.overlay, bulk=df.ovl)
shm(data=dat.over, charcoal=FALSE, ID=c('gene1'), alpha.overlay=0.5, bar.width=0.09, sub.title.vjust=4, legend.r=0.2)
```

![Superimposing raster images with SHMs (colorful backaground). The expression profiles of gene1 are plotted on ABS cells.](data:image/png;base64...)

Figure 7: Superimposing raster images with SHMs (colorful backaground)
The expression profiles of gene1 are plotted on ABS cells.

Another option for reducing masking effects is to display the raster image in black and white by setting `charcoal=TRUE` (Figure [8](#fig:overChar)).

```
shm(data=dat.over, charcoal=TRUE, ID=c('gene1'), alpha.overlay=0.5, bar.width=0.09, sub.title.vjust=4, legend.r=0.2)
```

![Superimposing raster images with SHMs (black and white background). The expression profiles of gene1 are plotted on ABS cells.](data:image/png;base64...)

Figure 8: Superimposing raster images with SHMs (black and white background)
The expression profiles of gene1 are plotted on ABS cells.

## 3.6 SHMs of Multiple Variables

The SHM plots shown so far are restricted to two variables, here spatial features
(*e.g.* tissues) and treatments. In theory, the complexity of experimental designs scales
to any number of variables in `spatialHeatmap`. This section
extends to experiments with three or more variables, such as experiments with spatiotemporal resolution and geographical locations, genotypes, treatments, *etc*.

To visualize multi-variable assay data, the variables are reduced to two by keeping the spatial feature unchanged and combining all other variables into a composite one. For instance, the following example contains four variables including spatial features, time points, drug treatments and injury conditions. The latter three are combined to produce a composite variable.

### 3.6.1 Gene Expression Data

The following uses RNA-seq data assayed from hippocampus and hypothalamus in mouse brain, and the experimental variables include traumatic brain injury (TBI), 3 or 29 days post injury (DPI), candesartan or vehicle treatment (Attilio et al. [2021](#ref-Attilio2021-pp)). The original data are modified for demonstration purpose and included in `spatialHeatmap` as a `SummarizedExperiment` object, which is imported below.

```
se.mus.vars <- readRDS(system.file('extdata/shinyApp/data/mus_brain_vars_se.rds', package='spatialHeatmap'))
```

The experiment design is stored in `colData` slot, where ‘Veh’, ‘Drug’, ‘TBI’, and ‘NoTBI’ refer to ‘vehicle’, ‘candesartan’, ‘traumatic brain injury’, and ‘sham injury’ respectively. The `time`, `treatment` and `injury` variables are combined into a composite one `comVar`.

```
colData(se.mus.vars)[1:3, ]
## DataFrame with 3 rows and 5 columns
##                                  tissue        time   treatment      injury
##                             <character> <character> <character> <character>
## hippocampus__3DPI.Veh.NoTBI hippocampus        3DPI         Veh       NoTBI
## hippocampus__3DPI.Veh.NoTBI hippocampus        3DPI         Veh       NoTBI
## hippocampus__3DPI.Veh.TBI   hippocampus        3DPI         Veh         TBI
##                                     comVar
##                                <character>
## hippocampus__3DPI.Veh.NoTBI 3DPI.Veh.NoTBI
## hippocampus__3DPI.Veh.NoTBI 3DPI.Veh.NoTBI
## hippocampus__3DPI.Veh.TBI     3DPI.Veh.TBI
unique(colData(se.mus.vars)$comVar)
## [1] "3DPI.Veh.NoTBI"   "3DPI.Veh.TBI"     "3DPI.Drug.NoTBI"  "3DPI.Drug.TBI"
## [5] "29DPI.Veh.NoTBI"  "29DPI.Veh.TBI"    "29DPI.Drug.NoTBI" "29DPI.Drug.TBI"
```

Since this example data are small, the pre-processing only involves normalization without the filtering step. The expression values are aggregated across replicates in tissues (`tissue`) and replicates in the composite variable (`comVar`) with the summary statistic of mean, which is similar with the [Human Brain](#hum) exmple.

```
se.mus.vars.nor <- norm_data(data=se.mus.vars, norm.fun='ESF', log2.trans=TRUE) # Normalization.
## Normalising: ESF
##    type
## "ratio"
se.mus.vars.aggr <- aggr_rep(data=se.mus.vars.nor, sam.factor='tissue', con.factor='comVar', aggr='mean') # Aggregate replicates.
assay(se.mus.vars.aggr)[1:3, 1:3]
##         hippocampus__3DPI.Veh.NoTBI hippocampus__3DPI.Veh.TBI
## Zscan10                    2.815413                0.09246384
## Zbp1                       1.757163                1.87394752
## Xlr4a                      1.412010                0.98498887
##         hippocampus__3DPI.Drug.NoTBI
## Zscan10                     1.089357
## Zbp1                        1.434792
## Xlr4a                       1.460883
```

### 3.6.2 aSVG Image

The aSVG image of mouse brain is downloaded from the [EBI anatomogram] repository (<https://github.com/ebi-gene-expression-group/anatomogram/tree/master/src/svg>){target="\_blank"} and included in `spatialHeatmap`, which is imported as below.

```
svg.mus.brain.pa <- system.file("extdata/shinyApp/data", "mus_musculus.brain.svg", package="spatialHeatmap")
svg.mus.brain <- read_svg(svg.mus.brain.pa)
```

The aSVG features and attributes are partially shown.

```
tail(attribute(svg.mus.brain)[[1]], 3)
## # A tibble: 3 × 10
##   feature          id    fill  stroke sub.feature index element parent index.all
##   <chr>            <chr> <chr>  <dbl> <chr>       <int> <chr>   <chr>      <int>
## 1 hypothalamus     UBER… none    0.05 hypothalam…    22 path    LAYER…        15
## 2 nose             UBER… none    0.05 nose           23 path    LAYER…        16
## 3 corpora.quadrig… UBER… none    0.05 corpora.qu…    24 path    LAYER…        17
## # ℹ 1 more variable: index.sub <int>
```

### 3.6.3 SHM: Multiple Variables

The expression values of gene `Acnat1` in hippocampus and hypothalamus across the composite variable are mapped to matching aSVG features. The output SHM plots of each composite variable are organized in a composite plot in Figure [9](#fig:dimshm).

```
dat.mul.dim <- SPHM(svg=svg.mus.brain, bulk=se.mus.vars.aggr)
shm(data=dat.mul.dim, ID=c('Acnat1'), legend.r=1.5, legend.key.size=0.02, legend.text.size=12, legend.nrow=3)
```

![SHM plots of multiple variable. Gene expression values of `Acnat1` in hippocampus and hypothalamus under composite variables are mapped to corresponding aSVG features. ](data:image/png;base64...)

Figure 9: SHM plots of multiple variable
Gene expression values of `Acnat1` in hippocampus and hypothalamus under composite variables are mapped to corresponding aSVG features.

## 3.7 Multiple aSVGs

In a spatiotemporal application, different development stages may need to be represented
in separate aSVG images. In such a case, the `shm` function is able to arrange
multiple aSVGs in a single SHM plot. To organize the subplots, the names
of the separate aSVG files are expected to include the following suffixes: `*_shm1.svg`,
`*_shm2.svg`, *etc*.

```
df.random <- data.frame(matrix(runif(50, min=0, max=10), nrow=10))
colnames(df.random) <- c('shoot_totalA__treatment1', 'shoot_totalA__treatment2', 'shoot_totalB__treatment1', 'shoot_totalB__treatment2', 'notMapped') # Assign column names
rownames(df.random) <- paste0('gene', 1:10) # Assign row names
df.random[1:2, ]
##       shoot_totalA__treatment1 shoot_totalA__treatment2
## gene1                 1.924185                2.6496046
## gene2                 4.520996                0.6959067
##       shoot_totalB__treatment1 shoot_totalB__treatment2 notMapped
## gene1                 5.112577                 7.649234  1.257528
## gene2                 4.749874                 4.356737  5.105836
```

The paths to the aSVG files are obtained, here for younger and older plants
using `*_shm1` and `*_shm1`, respectively, which are generated from
Mustroph et al. ([2009](#ref-Mustroph2009-nu)). Subsequently, the two aSVG files are loaded with the `read_svg`
function.

```
svg.sh1 <- system.file("extdata/shinyApp/data", "arabidopsis.thaliana_organ_shm1.svg", package="spatialHeatmap")
svg.sh2 <- system.file("extdata/shinyApp/data", "arabidopsis.thaliana_organ_shm2.svg", package="spatialHeatmap")
svg.sh.mul <- read_svg(c(svg.sh1, svg.sh2))
```

The following generates the corresponding SHMs plot for `gene2`. The orginal
image dimensions can be preserved by assigning `TRUE` to the `preserve.scale` argument.

```
dat.mul.svg <- SPHM(svg=svg.sh.mul, bulk=df.random)
shm(data=dat.mul.svg, ID=c('gene2'), width=0.7, legend.r=0.2, legend.width=1, preserve.scale=TRUE, bar.width=0.09, line.color='grey50')
```

![Spatial heatmap of Arabidopsis at two growth stages. The expression profile of 'gene2' under condition1 and condition2 is plotted for two growth stages (top and bottom row).](data:image/png;base64...)

Figure 10: Spatial heatmap of Arabidopsis at two growth stages
The expression profile of ‘gene2’ under condition1 and condition2 is plotted for two growth stages (top and bottom row).

Note in Figure [10](#fig:arabshm) shoots are drawn with thicker outlines than roots.
This is another useful feature of `shm`, *i.e.* preserving the outline
thicknesses defined in aSVG files. This feature is particularly useful in cellular SHMs
where different cell types may have different cell-wall thicknesses. The outline
widths can be updated with `update_feature` programatically, or within Inkscape
manually. The former is illustrated in the Supplementary Section.

# 4 Extended functionalities

## 4.1 Spatial Enrichment

The Spatial Enrichment (SpEn) functionality is an extension of SHMs for identifying groups of biomolecules (*e.g.* RNAs, proteins, metabolites) that are particularly abundant or
enriched in certain spatial regions, such as tissue-specific transcripts. Given a group of spatial features, SpEn identifies biomolecules significantly up- or down-regulated in each spatial feature relative to all other features (references). These biomolecules are classified as spatially enriched or depleted respectively. Then by querying a feature in the enrichment results, the corresponding enriched and depleted biomolecules will be returned, and their abundance values are subsequently visualized as enrichment SHMs. Similarly, biomolecules enriched or depleted in one experimental variable relative to reference variables can be detected and visualized as well. SpEn utilizes differential expression (DE) analysis methods to detect enriched or depleted biomolecules, including edgeR (McCarthy et al. [2012](#ref-edgeR)), limma (Ritchie et al. [2015](#ref-limma)), DESeq2 (Love, Huber, and Anders [2014](#ref-deseq2)).

The application of SpEn is illustrated with the
above [mouse organ data](#mus). The function `sf_var` is used to subset spatial features and experiment variables of interest in the assay data. In the following, five features (‘brain’, ‘liver’, ‘lung’, ‘colon’, and ‘kidney’) and three experiment variables (mouse strains ‘DBA.2J’, ‘C57BL.6’, and ‘CD1’) are subsetted. The `com.by` argument specifies whether the enrichment will be performed on spatial features (`ft`) or variables (`var`). In the following, `com.by` is set `ft`, so SpEn is performed for spatial features and the variables under each spatial feature are treated as replicates.

```
sub.mus <- sf_var(data=rse.mus, feature='organism_part', ft.sel=c('brain', 'lung', 'colon', 'kidney', 'liver'), variable='strain', var.sel=c('DBA.2J', 'C57BL.6', 'CD1'), com.by='ft')
colData(sub.mus)[1:3, c('organism_part', 'strain')]
## DataFrame with 3 rows and 2 columns
##                organism_part      strain
##                  <character> <character>
## brain__DBA.2J          brain      DBA.2J
## colon__DBA.2J          colon      DBA.2J
## kidney__DBA.2J        kidney      DBA.2J
```

The subsetted data are filtered. Details about this step are given under the [human brain](#hum) section.

```
sub.mus.fil <- filter_data(data=sub.mus, pOA=c(0.5, 15), CV=c(0.8, 100), verbose=FALSE)
```

The SpEn is implemented in the function `spatial_enrich`. In the following, the method `edgeR` is chosen and the count data are internally normalized by the `TMM` method from `edgeR`. The enrichment results are selected by log2 fold change (`log2.fc`) and FDR (`fdr`). The `outliers` argument specifies a number of outliers allowed in references.

```
enr.res <- spatial_enrich(sub.mus.fil, method=c('edgeR'), norm='TMM', log2.fc=1, fdr=0.05, outliers=1)
```

The overlap of enriched biomolecules (`type='up'`) across spatial features are presented in an UpSet plot (`plot='upset'`). Assigning `matrix` or `venn` to the `plot` argument will present the overlaps in form of a matrix plot or Venn diagram respectively.

```
ovl_enrich(enr.res, type='up', plot='upset')
```

![Overlap of enriched biomolecules across spatial features.](data:image/png;base64...)

Figure 11: Overlap of enriched biomolecules across spatial features

The enriched and depleted genes in brain are queried with the function `query_enrich`. In the `type` column, ‘up’ and ‘down’ refer to ‘enriched’ and ‘depleted’ respectively, while the `total` column shows the total reference features excluding outliers.

```
en.brain <- query_enrich(enr.res, 'brain')
## Done!
up.brain <- subset(rowData(en.brain), type=='up' & total==4)
up.brain[1:2, 1:3] # Enriched.
## DataFrame with 2 rows and 3 columns
##               type     total      method
##        <character> <numeric> <character>
## Kif5c           up         4       edgeR
## Mapk10          up         4       edgeR
dn.brain <- subset(rowData(en.brain), type=='down' & total==4)
dn.brain[1:2, 1:3] # Depleted.
## DataFrame with 2 rows and 3 columns
##                 type     total      method
##          <character> <numeric> <character>
## Cdhr5           down         4       edgeR
## Slc22a18        down         4       edgeR
```

One enriched (`Kif5c`) and one depleted
(`Cdhr5`) gene in mouse brain are chosen to plot SHMs. The resulting SHMs are termed as SHMs of spatially-enriched/depleted biomolecules (enrichment SHMs) respectively.

```
dat.enrich <- SPHM(svg=svg.mus, bulk=en.brain)
shm(data=dat.enrich, ID=c('Kif5c', 'Cdhr5'), legend.r=1, legend.nrow=7, sub.title.size=15, ncol=3, bar.width=0.09, lay.shm='gene')
```

```
## ggplots/grobs: mus_musculus.male.svg ...
## ggplot: Kif5c, DBA.2J  C57BL.6  CD1
## ggplot: Cdhr5, DBA.2J  C57BL.6  CD1
## Legend plot ...
## CPU cores: 1
## Converting "ggplot" to "grob" ...
## Kif5c_DBA.2J_1  Kif5c_C57BL.6_1  Kif5c_CD1_1  Cdhr5_DBA.2J_1  Cdhr5_C57BL.6_1  Cdhr5_CD1_1
## Converting "ggplot" to "grob" ...
##
```

![Enrichment SHMs. Top row: SHMs of spatially-enriched gene. Bottom row: SHMs of spatially-depleted gene.](data:image/png;base64...)

Figure 12: Enrichment SHMs
Top row: SHMs of spatially-enriched gene. Bottom row: SHMs of spatially-depleted gene.

The expression profiles of the two chosen genes (Figure [12](#fig:enr)) are also presented in line graphs.

```
graph_line(assay(en.brain)[c('Kif5c', 'Cdhr5'), ], lgd.pos='right')
```

![Line graph of gene expression profiles.](data:image/png;base64...)

Figure 13: Line graph of gene expression profiles

## 4.2 Hierarchical Clustering

SHMs are suitable for comparing assay profiles among small number of biomolecules
(*e.g.* few genes or proteins) across cell types and conditions. To also
support analysis routines of larger number of biomolecules, `spatialHeatmap` integrates
functionalities for identifying groups of biomolecules with similar and/or dissimilar
assay profiles, and subsequently analyzing the results with data mining
methods that scale to larger numbers of biomolecules than SHMs, such as hierarchical
clustering and network analysis methods.

To identify similar biomolecules, the `submatrix` function can be used. It identifies biomolecules sharing similar profiles with one or more query biomolecules of
interest. The given example uses correlation coefficients as similarity metric.
The `p` argument allows to restrict the number of
similar biomolecules to return based on a percentage cutoff relative to the number of
biomolecules in the assay data set (*e.g.* 1% of the top most similar biomolecules). If several
query biomolecules are provided then the function returns the similar genes for each
query, while assuring uniqueness among biomolecules in the result.

In a typical scenario, a spatial feature of interest is chosen in the first place, then a query biomolecule is chosen for the chosen feature, such as a tissue-specific gene. The following introduces the large-scale data mining using as sample data the preprocessed gene expression data (`se.fil.mus`) from the [Mouse Organs](#mus) section. The brain is selected as the query feature and ‘Kif5c’ is selected as the query gene, which is spatially enriched in brain and known to play important roles in motor neurons (Kanai et al. [2000](#ref-Kanai2000-tc)).

```
sub.mat <- submatrix(data=se.fil.mus, ID='Kif5c', p=0.15)
```

The result from the previous step is the assay matrix subsetted to the genes sharing similar assay profiles
with the query gene ‘Kif5c’.

```
assay(sub.mat)[1:2, 1:3] # Subsetted assay matrix
```

```
##           brain__DBA.2J colon__DBA.2J heart__DBA.2J
## Akap6          8.551867      2.331506      7.042128
## Adcyap1r1      7.962620      1.204208      3.775402
```

Subsequently, hierarchical clustering is applied to the subsetted assay matrix
containing only the genes that share profile similarities with the query gene ‘Kif5c’. The clustering result is displayed as a matrix heatmap where
the rows and columns are sorted by the corresponding hierarchical clustering
dendrograms (Figure [14](#fig:static)). The position of the query gene (‘Kif5c’) is indicated in the heatmap by black lines. Setting `static=FALSE`
will launch the interactive mode, where users can zoom into the heatmap by
selecting subsections in the image or zoom out by double clicking.

```
res.hc <- matrix_hm(ID=c('Kif5c'), data=sub.mat, angleCol=60, angleRow=60, cexRow=0.8, cexCol=0.8, margin=c(10, 6), static=TRUE, arg.lis1=list(offsetRow=0.01, offsetCol=0.01))
```

![Matrix Heatmap. Rows are genes and columns are samples. The query gene is tagged by black lines.](data:image/png;base64...)

Figure 14: Matrix Heatmap
Rows are genes and columns are samples. The query gene is tagged by black lines.

The most important information of Figure [14](#fig:static) is returned in `res.hc`. The row dendrogram is saved in `res.hc$rowDendrogram`. By using the function `cut_dendro`, it can be cut at a certain height (here `h=15`) to obtain the cluster containing the query gene.

```
cut_dendro(res.hc$rowDendrogram, h=15, 'Kif5c')
```

```
## [1] "Aplp1"  "Fbxl16" "Kif1a"  "Kif5a"  "Kif5c"  "Nptxr"  "Nrxn1"  "Ntm"
## [9] "Stx1b"
```

## 4.3 Network Graphs

### 4.3.1 Module Identification

Network analysis is performed with the WGCNA algorithm (Langfelder and Horvath [2008](#ref-Langfelder2008-sg); Ravasz et al. [2002](#ref-Ravasz2002-db)) using as input the subsetted assay matrix generated in the
previous section. The objective is to identify network modules that can be
visualized in the following step in form of network graphs. Applied to the gene
expression sample data used here, these network modules represent groups of
genes sharing highly similar expression profiles. Internally, the network
module identification includes five major steps. First, a correlation matrix
(Pearson or Spearman) is computed for each pair of biomolecules. Second, the
obtained correlation matrix is transformed into an adjacency matrix that
approximates the underlying global network to scale-free topology (Ravasz et al. [2002](#ref-Ravasz2002-db)).
Third, the adjacency matrix is used to calculate a topological overlap matrix (TOM)
where shared neighborhood information among biomolecules is used to preserve robust
connections, while removing spurious connections. Fourth, the distance transformed
TOM is used for hierarchical clustering. To maximize time performance, the
hierarchical clustering is performed with the `flashClust` package (Langfelder and Horvath [2012](#ref-Langfelder2012-nv)).
Fifth, network modules are identified with the `dynamicTreeCut` package (Langfelder, Zhang, and Steve Horvath [2016](#ref-dynamicTreeCut)). Its `ds`
(`deepSplit`) argument can be assigned integer values from `0` to `3`, where
higher values increase the stringency of the module identification process. To
simplify the network module identification process with WGCNA, the individual
steps can be executed with a single function called `adj_mod`. The result is a
list containing the adjacency matrix and the final module assignments stored in
a `data.frame`. Since the [interactive network](#inter_net) feature used in the
visualization step below performs best on smaller modules, only modules are
returned that were obtained with stringent `ds` settings (here `ds=2` and `ds=3`).

```
adj.mod <- adj_mod(data=sub.mat)
```

A slice of the adjacency matrix is shown below.

```
adj.mod[['adj']][1:3, 1:3]
```

```
##               Akap6  Adcyap1r1     Erich6
## Akap6     1.0000000 0.49348330 0.10614679
## Adcyap1r1 0.4934833 1.00000000 0.06216853
## Erich6    0.1061468 0.06216853 1.00000000
```

The module assignments are stored in a `data frame`. Its columns contain the results
for the `ds=2` and `ds=3` settings. Integer values \(>0\) are the module labels, while \(0\)
indicates unassigned biomolecules. The following returns the first three rows of the module
assignment result.

```
adj.mod[['mod']][1:3, ]
```

```
##           0  1  2  3
## Akap6     0 30 30 23
## Adcyap1r1 0  0  0 44
## Erich6    7  5  4 30
```

### 4.3.2 Module Visualization

Network modules can be visualized with the `network` function. To plot a module
containing a biomolecule (gene) of interest, its ID needs to be
provided under the corresponding argument. Typically, this could be one of the
biomolecules chosen for the above SHM plots. There are two modes to visualize the
selected module: static or interactive. Figure [15](#fig:inter) was generated
with `static=TRUE`. Setting `static=FALSE` will generate the interactive
version. In the network plot shown below the nodes and edges represent genes
and their interactions, respectively. The thickness of the edges denotes the
adjacency levels, while the size of the nodes indicates the degree of
connectivity of each biomolecule in the network. The adjacency and connectivity levels
are also indicated by colors (Figure [15](#fig:inter)). The gene of interest assigned
under `ID` is labeled in the plot with the suffix tag: `*_target`.

```
network(ID="Kif5c", data=sub.mat, adj.mod=adj.mod, adj.min=0, vertex.label.cex=1.2, vertex.cex=3, edge.cex=3, mar.key=c(3, 10, 1, 10), static=TRUE)
```

![Static network. Node size denotes gene connectivity while edge thickness stands for co-expression similarity.](data:image/png;base64...)

Figure 15: Static network
Node size denotes gene connectivity while edge thickness stands for co-expression similarity.

Setting `static=FALSE` launches the interactive network. In this mode there
is an interactive color bar that denotes the gene connectivity. To modify it,
the color labels need to be provided in a comma separated format, *e.g.*:
`yellow, orange, red`. The latter would indicate that the gene connectivity
increases from yellow to red.

If the expression matrix contains gene/protein annotation information in the `rowData` slot and specified through `desc`, then it will be shown when moving the cursor over a network
node.

```
network(ID="Kif5c", data=sub.mat, adj.mod=adj.mod, desc='desc', static=FALSE)
```

# 5 Shiny App

In additon to running `spatialHeatmap` from R, the package includes a [Shiny
App](https://shiny.rstudio.com/) that provides access to the same
functionalities from an intuitive-to-use web browser interface. Apart from
being very user-friendly, this App conveniently organizes the results of the
entire visualization workflow in a single browser window with options to adjust
the parameters of the individual components interactively. For instance, genes
can be selected and replotted in SHMs simply by clicking the corresponding
rows in the expression table included in the same window.
This representation is very efficient in guiding the interpretation of the results
in a visual and user-friendly manner. For testing purposes, the `spatialHeatmap`
Shiny App also includes ready-to-use sample expression data and aSVG images
along with embedded user instructions.

## 5.1 Local System

The Shiny App of `spatialHeatmap` can be launched from an R session with the following function call.

```
shiny_shm()
```

The main dashboard panels of the Shiny App are organized as follows:

1. Datasets: options for uploading custom datasets, selecting default datsets, or downloading example datasets.
2. Spatial Heatmap: interactive tables of assay data/metadata, plotting SHMs with single or multiple genes, settings to customize the SHMs.
3. Spatial Enrichment: overlap plots of enrichment results across spatial features, data table of enriched and depleted biomolecules.
4. Data Mining: hierarchical clustering, K-means clustering, network analysis.
5. Co-visualization: co-visualizing single-cell and bulk data in embedding plots (PCA, UMAP, or TSNE) and SHMs repectively. This functionality is described in a separate [vignette](#https://bioconductor.org/packages/devel/bioc/vignettes/spatialHeatmap/inst/doc/covisualize.html).

A screenshot is shown below depicting SHM plots generated with the `spatialHeatmap` Shiny App (Figure [16](#fig:shiny)).

![Screenshot of spatialHeatmap's Shiny App.](data:image/jpeg;base64...)

Figure 16: Screenshot of spatialHeatmap’s Shiny App

The assay data along with metatdata are uploaded to the Shiny App as tabular (*e.g.* in CSV or TSV format) or ‘.rds’ files. The latter is a `SummarizedExperiment` object saved with the `saveRDS` function. In addition, the images are uploaded as aSVG files. The `filter_data` function can be used to export assay data from `SummarizedExperiment` to tabular files (TSV format). In the following example, the `file` argument specifies the the output file name, while the `sam.factor` and `con.factor` specifies spatial features and experiment variables in the `colData` slot respectively, which will be retained in the column names of the output tabular file. An example of the output format is shown in Table [1](#tab:humtab). In addition, the `desc` argument can be optionally used to specify gene annotations in the `rowData` slot, which will be appended to the output tabular file. More details of assay data formats are provided in the [Supplement](#df).

```
se.fil.arab <- filter_data(data=se.aggr.sh, desc="Target.Description", sam.factor='samples', con.factor='conditions', pOA=c(0.03, 6), CV=c(0.30, 100), file='./filtered_data.txt')
```

## 5.2 Server Deployment

As most Shiny Apps, `spatialHeatmap` can be deployed as a centralized web
service. A major advantage of a web server deployment is that the
functionalities can be accessed remotely by anyone on the internet without the
need to use R on the user system. For deployment one can use custom web
servers or cloud services, such as AWS, GCP or
[shinysapps.io](https://www.shinyapps.io/). An example web instance for testing
`spatialHeatmap` online is available
[here](https://tgirke.shinyapps.io/spatialHeatmap/).

## 5.3 Custom Shiny App

The `spatialHeatmap` package also allows users to create custom Shiny App
instances using the `custom_shiny` function. This function provides options to include
custom assay and image data, and define default settings (*e.g.* color schemes). For details users want
to consult the help file. To maximize flexibility, the default settings are stored in a yaml file in the App. This makes it easy to refine and optimize default settings simply by changing this yaml file.

## 5.4 Database Backend

To maintain scalability, the Shiny App is designed to work with backend databases that comprise assay datasets, aSVG files, and the pairing between assay data and aSVGs. This allows users to manage large amounts of assay data and aSVGs in a batch. Both `SummarizedExperiment` and `SinleCellExperiment` formats are supported data structures to create the backend database. Assay datasets are saved in the same HDF5 database (Fischer, Smith, and Pau [2020](#ref-rhdf5)). Then the assay data, aSVG files, and the pairing information (stored as a nested `list`) between assay data and aSVGs are compressed into a ‘.tar’ file as the final database. More details are referred to the help file of `write_hdf5`.

# 6 Supplementary Section

The advantages of integrating the features of *spatialHeatmap* are showcased in a [discovery workflow](https://jianhaizhang.github.io/spatialHeatmap_supplement/manuscript_examples.html#4_Use_Case).

## 6.1 Numeric Data

The numceric data used to color the features in aSVG images can be provided as
three different object types including `vector`, `data.frame` and
`SummerizedExperiment`. When working with complex omics-based assay data then
the latter provides the most flexibility, and thus should be the preferred
container class for managing numeric data in `spatialHeatmap`. Both
`data.frame` and `SummarizedExperiment` can hold data from many measured biomolecules,
such as many genes or proteins. In contrast to this, the
`vector` class is only suitable for data from single biomolecules. Due to its
simplicity this less complex container is often useful for testing or when
dealing with simple data sets.

### 6.1.1 Object Types

#### 6.1.1.1 `vector`

When using numeric vectors as input to `shm`, then their name slot needs
to be populated with strings matching the feature names in the corresponding aSVG.
To also specify experiment variables, their labels need to be appended to the feature names
with double underscores as separator, *i.e.* ’spFfeature\_\_variable’.

The following example replots the [testing example](#test) for two spatial features
(‘putamen’ and ‘prefrontal.cortex’) and two experiment variables (‘1’ and ‘2’).

```
vec <- sample(x=1:100, size=5) # Random numeric values
names(vec) <- c('putamen__variable1', 'putamen__variable2', 'prefrontal.cortex__variable1', 'prefrontal.cortex__variable2', 'notMapped') # Assign unique names to random values
vec
```

```
##           putamen__variable1           putamen__variable2
##                           47                           38
## prefrontal.cortex__variable1 prefrontal.cortex__variable2
##                           62                           70
##                    notMapped
##                           10
```

With this configuration the resulting plot contains two SHMs
for the human brain, corresponding to ‘variable1’ and ‘variable2’ respectively. To keep the build time of this package to a minimum, the `shm` function call in the code block below is not evaluated, and thus the corresponding SHMs are not shown.

```
dat.vec <- SPHM(svg=svg.hum, bulk=vec)
shm(data=dat.vec, ID='testing', ncol=1, legend.r=1.2, sub.title.size=14, ft.trans='g4320', legend.nrow=3)
```

#### 6.1.1.2 `data.frame`

The `data.frame` stores assay data in a table, where columns and rows are spatial features/variables and biomolecules respectively. The naming of spatial features and variables in the column names follows the same convention as the above vector example. The following illustrates the `data.frame` container with random numbers.

```
df.test <- data.frame(matrix(sample(x=1:1000, size=100), nrow=20)) # Create numeric data.frame
colnames(df.test) <- names(vec) # Assign column names
rownames(df.test) <- paste0('gene', 1:20) # Assign row names
df.test[1:3, ]
```

```
##       putamen__variable1 putamen__variable2 prefrontal.cortex__variable1
## gene1                902                924                          816
## gene2                564                931                          123
## gene3                602                143                          883
##       prefrontal.cortex__variable2 notMapped
## gene1                          116        58
## gene2                          673       571
## gene3                          380       331
```

With the resulting `data.frame`, SHMs can be plotted for one or multiple genes (`ID=c('gene1')`).

```
dat.df <- SPHM(svg=svg.hum, bulk=df.test)
shm(data=dat.df, ID=c('gene1'), ncol=1, legend.r=1.2, sub.title.size=14, legend.nrow=3)
```

Additional gene annotation information can be appended to the `data.frame`. This information can then be displayed
interactively in the network plots of the Shiny App by placing the cursor over network nodes.

```
df.test$ann <- paste0('ann', 1:20)
df.test[1:3, ]
```

```
##       putamen__variable1 putamen__variable2 prefrontal.cortex__variable1
## gene1                902                924                          816
## gene2                564                931                          123
## gene3                602                143                          883
##       prefrontal.cortex__variable2 notMapped  ann
## gene1                          116        58 ann1
## gene2                          673       571 ann2
## gene3                          380       331 ann3
```

#### 6.1.1.3 `SummarizedExperiment`

The `SummarizedExperiment` class is a much more extensible and flexible container for providing metadata for both rows and columns of numeric data.

To import experimental design information (e.g. replicates, treatments) from tabular files, users can provide
a target file that will be stored in the `colData` slot of the
`SummarizedExperiment` (SE) object. Usually,
the target file contains at least two columns: one for spatial features and
one for experimental variables, where replicates are indicated by identical entries. The actual numeric matrix representing the assay data is stored in
the `assay` slot, where the rows correspond to biomolecules (e.g. genes). Optionally, additional annotation information for the rows (*e.g.* gene
descriptions) can be stored in the `rowData` slot.

For constructing a valid `SummarizedExperiment` object that can be used by
the `shm` function, the target file should meet the following requirements.

1. It should contain at least two columns. One column represents spatial features (`spFeature`)
   and the other one experimental variables (`variable`) such as treatments. The rows in the target file
   correspond to the columns of the numeric data stored in the `assay` slot.
2. To be colored in SHMs, the spatial features must have common identifiers between the assay data and aSVG. Note, the double underscore is a special string reserved for specific purposes in *spatialHeatmap*, and thus should be avoided for naming spatial features and variables.

The following example illustrates the design of a valid `SummarizedExperiment` object for generating SHMs. In this example, the ‘putamen’ tissue has 2 variables and each has 2 replicates. Thus, there are 4 assays for `putamen`. The same design applies to the `prefrontal.cortex` tissue.

```
spft <- c(rep('putamen', 4), rep('prefrontal.cortex', 4))
vars <- rep(c('variable1', 'variable1', 'variable2', 'variable2'), 2)
target.test <- data.frame(spFeature=spft, variable=vars, row.names=paste0('assay', 1:8))
target.test
```

```
##                spFeature  variable
## assay1           putamen variable1
## assay2           putamen variable1
## assay3           putamen variable2
## assay4           putamen variable2
## assay5 prefrontal.cortex variable1
## assay6 prefrontal.cortex variable1
## assay7 prefrontal.cortex variable2
## assay8 prefrontal.cortex variable2
```

The `assay` slot is populated with a `data.frame` containing random
numbers. Each column corresponds to an assay in the target file (here imported
into `colData`), while each row corresponds to a gene.

```
df.se <- data.frame(matrix(sample(x=1:1000, size=160), nrow=20))
rownames(df.se) <- paste0('gene', 1:20)
colnames(df.se) <- row.names(target.test)
df.se[1:3, ]
```

```
##       assay1 assay2 assay3 assay4 assay5 assay6 assay7 assay8
## gene1    213    794    297    129    269    149    521    617
## gene2    961    331    673    636    598    980    839     84
## gene3    133    559    290    317    372    177    844    916
```

Next, the final `SummarizedExperiment` object is constructed by providing the
numeric and target data under the `assays` and `colData` arguments,
respectively.

```
se <- SummarizedExperiment(assays=df.se, colData=target.test)
se
```

```
## class: SummarizedExperiment
## dim: 20 8
## metadata(0):
## assays(1): ''
## rownames(20): gene1 gene2 ... gene19 gene20
## rowData names(0):
## colnames(8): assay1 assay2 ... assay7 assay8
## colData names(2): spFeature variable
```

In addition, row-wise annotation information (*e.g.* for genes) can be included in the `rowData` slot.

```
rowData(se) <- df.test['ann']
```

The replicates are aggregated by means.

```
se.aggr <- aggr_rep(data=se, sam.factor='spFeature', con.factor='variable', aggr='mean')
assay(se.aggr)[1:2, ]
```

```
##       putamen__variable1 putamen__variable2 prefrontal.cortex__variable1
## gene1              503.5              213.0                          209
## gene2              646.0              654.5                          789
##       prefrontal.cortex__variable2
## gene1                        569.0
## gene2                        461.5
```

With the fully configured `SummarizedExperiment` object, a similar SHM is plotted as in the previous examples.

```
dat.se <- SPHM(svg=svg.hum, bulk=se.aggr)
shm(data=dat.se, ID=c('gene1'), ncol=1, legend.r=1.2, sub.title.size=14, ft.trans=c('g4320'), legend.nrow=3)
```

## 6.2 aSVGs files

### 6.2.1 aSVG repositories

The aSVG files can be created by following our step-by-step [tutorial](https://jianhaizhang.github.io/SHM_SVG) or downloaded from public repositories. A public aSVG repository, that can be used by `spatialHeatmap` directly, is the [EBI anatomogram](https://github.com/ebi-gene-expression-group/anatomogram/tree/master/src/svg).
It contains annatomical aSVG images from different species. The same aSVG
images are also used by the web service of the Expression Atlas project. Furthermore, the
`spatialHeatmap` has its own repository called [spatialHeatmap aSVG
Repository](https://github.com/jianhaizhang/SHM_SVG),
which stores custom aSVG files developed for this project (*e.g.* Figure
[6](#fig:shshm)). In the future, we will expand our repository with more aSVGs, and users are encouraged to contribute their own aSVGs to this repository, allowing them to share their creations with the community.

### 6.2.2 Update aSVG features

To edit spatial feature identifiers in aSVGs, the `update_feature` function can be used. The demonstration below first creates an empty folder `tmp.dir1` and copies
into it the aSVG `homo_sapiens.brain.svg`.

```
tmp.dir1 <- file.path(tempdir(check=TRUE), 'shm1')
if (!dir.exists(tmp.dir1)) dir.create(tmp.dir1)
svg.hum.pa <- system.file("extdata/shinyApp/data", 'homo_sapiens.brain.svg', package="spatialHeatmap")
file.copy(from=svg.hum.pa, to=tmp.dir1, overwrite=TRUE) # Copy "homo_sapiens.brain.svg" file into 'tmp.dir1'
```

The folder `tmp.dir1` is queried with feature and species keywords, and matches are returned in a `data.frame`.

```
feature.df <- return_feature(feature=c('frontal cortex', 'prefrontal cortex'), species=c('homo sapiens', 'brain'), dir=tmp.dir1, remote=NULL, keywords.any=FALSE)
feature.df
```

New feature identifiers are stored in a vector, corresponding to
each of the returned features (here ‘prefrontal.cortex’ and ‘frontal.cortex’).

```
f.new <- c('prefrontalCortex', 'frontalCortex')
```

To also update strokes (thickness of spatial feature outlines) and colors, store new strokes and colors in separate vectors in a similar way as above.

```
s.new <- c('0.05', '0.1') # New strokes.
c.new <- c('red', 'green') # New colors.
```

Next, new features, strokes, and colors are stored as three respective columns in a `data.frame`. The column names `featureNew`, `strokeNew`, and `colorNew` are internally recognized by the `update_feature` function when updating the aSVG.

```
feature.df.new <- cbind(featureNew=f.new, strokeNew=s.new, colorNew=c.new, feature.df)
feature.df.new
```

Finally, `update_feature` is used to update spatial features, strokes, and colors in the aSVG stored in the `tmp.dir1` folder.

```
update_feature(df.new=feature.df.new, dir=tmp.dir1)
```

## 6.3 Advanced Functionalities

### 6.3.1 SHM: Re-matching

*spatialHeatmap* supports re-matching one spatial feature in the assay data to one or multiple counterparts in the aSVG. The re-matching is defined in a named `list`. In the `list`, a name slot refers to a spatial feature in assay data and the corresponding `list` elements represent aSVG features for re-matching.

The example below takes assay data from the [Human Brain](#hum) section, such as `svg.hum.sub` and `se.fil.hum`. The spatial feature `frontal.cortex` in assay data is re-matched to `frontal.cortex` and `prefrontal.cortex` in the aSVG through a `list` (`remat.hum`). Figure [17](#fig:shmNoMatch) is the SHM before re-matching while Figure [18](#fig:remat) is the SHM after re-matching.

```
remat.hum <- list(frontal.cortex=c('frontal.cortex', 'prefrontal.cortex'))
```

```
dat.no.match <- SPHM(svg=svg.hum.sub, bulk=se.fil.hum)
shm(data=dat.no.match, ID=c('OLFM4'), lay.shm='con', ncol=1, legend.r=0.8, legend.nrow=2, h=0.6)
```

![SHMs before re-matching.](data:image/png;base64...)

Figure 17: SHMs before re-matching

```
dat.rematch <- SPHM(svg=svg.hum.sub, bulk=se.fil.hum, match=remat.hum)
shm(data=dat.rematch, ID=c('OLFM4'), lay.shm='con', ncol=1, legend.r=0.8, legend.nrow=2, h=0.6)
```

![SHMs after re-matching. The spatial feature `frontal.cortex` in assay data is re-matched to aSVG features `frontal.cortex` and `prefrontal.cortex`.](data:image/png;base64...)

Figure 18: SHMs after re-matching
The spatial feature `frontal.cortex` in assay data is re-matched to aSVG features `frontal.cortex` and `prefrontal.cortex`.

Re-matching has various applications, such as mapping gene expression profiles from one species to a closely related species in the same anatomical region. It enables leveraging existing data when direct measurements are challenging. Additionally, re-matching can be used to map gene assay profiles of a sub-tissue to the whole tissue, when assaying the entire tissue is difficult. It allows extrapolating and analyzing gene expression patterns of the entire tissue based on data from the sub-tissues.

## 6.4 SHMs of Time Series

This section generates a SHM plot for chicken data from the Expression Atlas.
The code components are very similar to the [Human Brain](#hum) example. For
brevity, the corresponding text explaining the code has been reduced to a
minimum.

### 6.4.1 Gene Expression Data

The following searches the Expression Atlas for expression data from *‘heart’* and *‘gallus’*.

```
all.chk <- read_cache(cache.pa, 'all.chk') # Retrieve data from cache.
if (is.null(all.chk)) { # Save downloaded data to cache if it is not cached.
  all.chk <- searchAtlasExperiments(properties="heart", species="gallus")
  save_cache(dir=cache.pa, overwrite=TRUE, all.chk)
}
```

Among the matching entries, accession ‘E-MTAB-6769’ will be downloaded, which is an RNA-Seq experiment comparing the developmental changes across
nine time points of seven organs (Cardoso-Moreira et al. [2019](#ref-Cardoso-Moreira2019-yq)).

```
all.chk[3, ]
rse.chk <- read_cache(cache.pa, 'rse.chk') # Read data from cache.
if (is.null(rse.chk)) { # Save downloaded data to cache if it is not cached.
  rse.chk <- getAtlasData('E-MTAB-6769')[[1]][[1]]
  save_cache(dir=cache.pa, overwrite=TRUE, rse.chk)
}
```

The first three rows of the design in the downloaded experiment are shown.

```
colData(rse.chk)[1:3, ]
```

```
## DataFrame with 3 rows and 8 columns
##            AtlasAssayGroup      organism         strain           genotype
##                <character>   <character>    <character>        <character>
## ERR2576379              g1 Gallus gallus Red Junglefowl wild type genotype
## ERR2576380              g1 Gallus gallus Red Junglefowl wild type genotype
## ERR2576381              g2 Gallus gallus Red Junglefowl wild type genotype
##            developmental_stage         age         sex organism_part
##                    <character> <character> <character>   <character>
## ERR2576379              embryo      10 day      female         brain
## ERR2576380              embryo      10 day      female         brain
## ERR2576381              embryo      10 day      female    cerebellum
```

### 6.4.2 aSVG Image

The following example shows how to download from the above [SVG
repositories](#data_repo) an aSVG image that matches the tissues and species
assayed in the downloaded data. As before downloaded images are saved to the directory `tmp.dir`.

```
tmp.dir <- file.path(tempdir(check=TRUE), 'shm')
# Query aSVGs.
feature.df <- return_feature(feature=c('heart', 'kidney'), species=c('gallus'), dir=tmp.dir, remote=remote)
```

To meet the R/Bioconductor package requirements, the following uses aSVG file instances included in the `spatialHeatmap` package rather than the downloaded instances.

```
feature.df <- return_feature(feature=c('heart', 'kidney'), species=c('gallus'), dir=svg.dir, remote=NULL)
feature.df[1:2, c('feature', 'stroke', 'SVG')] # A slice of the search result.
```

The target aSVG instance `gallus_gallus.svg` is imported.

```
svg.chk.pa <- system.file("extdata/shinyApp/data", "gallus_gallus.svg", package="spatialHeatmap")
svg.chk <- read_svg(svg.chk.pa)
```

### 6.4.3 Experimental Design

A sample target file that is included in this package is imported and then loaded to the `colData` slot of `rse.chk`, the first three rows of which are displayed.

```
chk.tar <- system.file('extdata/shinyApp/data/target_chicken.txt', package='spatialHeatmap')
target.chk <- read.table(chk.tar, header=TRUE, row.names=1, sep='\t') # Importing
colData(rse.chk) <- DataFrame(target.chk) # Loading
target.chk[1:3, ]
##            AtlasAssayGroup      organism         strain           genotype
## ERR2576379              g1 Gallus gallus Red Junglefowl wild type genotype
## ERR2576380              g1 Gallus gallus Red Junglefowl wild type genotype
## ERR2576381              g2 Gallus gallus Red Junglefowl wild type genotype
##            developmental_stage   age    sex organism_part
## ERR2576379              embryo day10 female         brain
## ERR2576380              embryo day10 female         brain
## ERR2576381              embryo day10 female    cerebellum
```

### 6.4.4 Preprocess Assay Data

The raw RNA-Seq count are preprocessed with the following steps: (1)
normalization, (2) aggregation of replicates, and (3) filtering of reliable
expression data, details of which are seen in the [Human Brain](#hum) example.

```
se.nor.chk <- norm_data(data=rse.chk, norm.fun='ESF', log2.trans=TRUE) # Normalization
se.aggr.chk <- aggr_rep(data=se.nor.chk, sam.factor='organism_part', con.factor='age', aggr='mean') # Replicate agggregation using mean
se.fil.chk <- filter_data(data=se.aggr.chk, sam.factor='organism_part', con.factor='age', pOA=c(0.01, 5), CV=c(0.6, 100)) # Filtering of genes with low counts and varince
```

### 6.4.5 SHM: Time Series

The expression profile for gene `ENSGALG00000006346` is plotted across nine time
points in four organs in form of a composite SHM with 9 panels. Their layout in
three columns is controlled with the argument setting `ncol=3`. In the legend plot, spatial features are labeled by `label=TRUE`.

```
dat.chk <- SPHM(svg=svg.chk, bulk=se.fil.chk)
shm(data=dat.chk, ID='ENSGALG00000006346', width=0.9, legend.width=0.9, legend.r=1.5, sub.title.size=9, ncol=3, legend.nrow=3, label=TRUE, verbose=FALSE)
```

![Time course of chicken organs. The SHM shows the expression profile of a single gene across nine time points and four organs.](data:image/png;base64...)

Figure 19: Time course of chicken organs
The SHM shows the expression profile of a single gene across nine time points and four organs.

# 7 Version Informaion

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] org.Mm.eg.db_3.22.0         org.Hs.eg.db_3.22.0
##  [3] AnnotationDbi_1.72.0        BiocParallel_1.44.0
##  [5] igraph_2.2.1                GEOquery_2.78.0
##  [7] ExpressionAtlas_2.2.0       jsonlite_2.0.0
##  [9] RCurl_1.98-1.17             xml2_1.5.2
## [11] limma_3.66.0                Seurat_5.4.0
## [13] SeuratObject_5.3.0          sp_2.2-0
## [15] kableExtra_1.4.0            SingleCellExperiment_1.32.0
## [17] ggplot2_4.0.1               SummarizedExperiment_1.40.0
## [19] Biobase_2.70.0              GenomicRanges_1.62.1
## [21] Seqinfo_1.0.0               IRanges_2.44.0
## [23] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [25] generics_0.1.4              MatrixGenerics_1.22.0
## [27] matrixStats_1.5.0           spatialHeatmap_2.16.3
## [29] knitr_1.51                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] dichromat_2.0-0.1      nnet_7.3-20            goftest_1.2-3
##   [4] Biostrings_2.78.0      vctrs_0.7.0            spatstat.random_3.4-4
##   [7] digest_0.6.39          png_0.1-8              ggrepel_0.9.6
##  [10] deldir_2.0-4           parallelly_1.46.1      magick_2.9.0
##  [13] MASS_7.3-65            reshape2_1.4.5         httpuv_1.6.16
##  [16] foreach_1.5.2          withr_3.0.2            xfun_0.56
##  [19] survival_3.8-6         memoise_2.0.1          ggbeeswarm_0.7.3
##  [22] systemfonts_1.3.1      zoo_1.8-15             gtools_3.9.5
##  [25] pbapply_1.7-4          Formula_1.2-5          KEGGREST_1.50.0
##  [28] promises_1.5.0         otel_0.2.0             httr_1.4.7
##  [31] grImport_0.9-7         globals_0.18.0         fitdistrplus_1.2-5
##  [34] rstudioapi_0.18.0      shinyAce_0.4.4         miniUI_0.1.2
##  [37] base64enc_0.1-3        spsComps_0.3.4.0       curl_7.0.0
##  [40] ScaledMatrix_1.18.0    polyclip_1.10-7        SparseArray_1.10.8
##  [43] xtable_1.8-4           stringr_1.6.0          doParallel_1.0.17
##  [46] evaluate_1.0.5         S4Arrays_1.10.1        BiocFileCache_3.0.0
##  [49] preprocessCore_1.72.0  hms_1.1.4              bookdown_0.46
##  [52] irlba_2.3.5.1          colorspace_2.1-2       filelock_1.0.3
##  [55] ROCR_1.0-11            reticulate_1.44.1      spatstat.data_3.1-9
##  [58] magrittr_2.0.4         lmtest_0.9-40          readr_2.1.6
##  [61] later_1.4.5            viridis_0.6.5          lattice_0.22-7
##  [64] spatstat.geom_3.7-0    future.apply_1.20.1    genefilter_1.92.0
##  [67] scattermore_1.2        XML_3.99-0.20          scuttle_1.20.0
##  [70] cowplot_1.2.0          RcppAnnoy_0.0.23       Hmisc_5.2-5
##  [73] pillar_1.11.1          nlme_3.1-168           iterators_1.0.14
##  [76] caTools_1.18.3         compiler_4.5.2         beachmat_2.26.0
##  [79] RSpectra_0.16-2        stringi_1.8.7          tensor_1.5.1
##  [82] dendextend_1.19.1      plyr_1.8.9             crayon_1.5.3
##  [85] abind_1.4-8            scater_1.38.0          gridGraphics_0.5-1
##  [88] locfit_1.5-9.12        bit_4.6.0              UpSetR_1.4.0
##  [91] dplyr_1.1.4            fastcluster_1.3.0      codetools_0.2-20
##  [94] textshaping_1.0.4      BiocSingular_1.26.1    bslib_0.9.0
##  [97] plotly_4.11.0          mime_0.13              splines_4.5.2
## [100] Rcpp_1.1.1             fastDummies_1.7.5      dbplyr_2.5.1
## [103] blob_1.3.0             utf8_1.2.6             fs_1.6.6
## [106] listenv_0.10.0         checkmate_2.3.3        ggplotify_0.1.3
## [109] tibble_3.3.1           Matrix_1.7-4           statmod_1.5.1
## [112] tzdb_0.5.0             svglite_2.2.2          pkgconfig_2.0.3
## [115] tools_4.5.2            cachem_1.1.0           RSQLite_2.4.5
## [118] viridisLite_0.4.2      DBI_1.2.3              impute_1.84.0
## [121] fastmap_1.2.0          rmarkdown_2.30         scales_1.4.0
## [124] grid_4.5.2             ica_1.0-3              shinydashboard_0.7.3
## [127] sass_0.4.10            patchwork_1.3.2        FNN_1.1.4.1
## [130] BiocManager_1.30.27    dotCall64_1.2          RANN_2.6.2
## [133] rpart_4.1.24           farver_2.1.2           yaml_2.3.12
## [136] foreign_0.8-90         cli_3.6.5              purrr_1.2.1
## [139] lifecycle_1.0.5        uwot_0.2.4             bluster_1.20.0
## [142] backports_1.5.0        annotate_1.88.0        gtable_0.3.6
## [145] ggridges_0.5.7         progressr_0.18.0       parallel_4.5.2
## [148] edgeR_4.8.2            RcppHNSW_0.6.0         bitops_1.0-9
## [151] bit64_4.6.0-1          assertthat_0.2.1       Rtsne_0.17
## [154] yulab.utils_0.2.3      spatstat.utils_3.2-1   BiocNeighbors_2.4.0
## [157] jquerylib_0.1.4        metapod_1.18.0         shinytoastr_2.2.0
## [160] dqrng_0.4.1            spatstat.univar_3.1-6  lazyeval_0.2.2
## [163] shiny_1.12.1           dynamicTreeCut_1.63-1  htmltools_0.5.9
## [166] GO.db_3.22.0           sctransform_0.4.3      rappdirs_0.3.4
## [169] tinytex_0.58           glue_1.8.0             spam_2.11-3
## [172] httr2_1.2.2            XVector_0.50.0         scran_1.38.0
## [175] gridExtra_2.3          flashClust_1.01-2      R6_2.6.1
## [178] tidyr_1.3.2            DESeq2_1.50.2          gplots_3.3.0
## [181] labeling_0.4.3         cluster_2.1.8.1        DelayedArray_0.36.0
## [184] tidyselect_1.2.1       vipor_0.4.7            WGCNA_1.73
## [187] htmlTable_2.4.3        future_1.69.0          rsvd_1.0.5
## [190] KernSmooth_2.23-26     S7_0.2.1               rsvg_2.7.0
## [193] data.table_1.18.0      htmlwidgets_1.6.4      RColorBrewer_1.1-3
## [196] rlang_1.1.7            spatstat.sparse_3.1-0  spatstat.explore_3.7-0
## [199] rentrez_1.2.4          beeswarm_0.4.0
```

# 8 Funding

This project has been funded by NSF awards: [PGRP-1546879](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1546879&HistoricalAwards=false), [PGRP-1810468](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1810468), [PGRP-1936492](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1936492&HistoricalAwards=false).

# 9 References

Attilio, Peter J, Dustin M Snapper, Milan Rusnak, Akira Isaac, Anthony R Soltis, Matthew D Wilkerson, Clifton L Dalgard, and Aviva J Symes. 2021. “Transcriptomic Analysis of Mouse Brain After Traumatic Brain Injury Reveals That the Angiotensin Receptor Blocker Candesartan Acts Through Novel Pathways.” *Front. Neurosci.* 15 (March): 636259.

Bezrutczyk, Margaret, Nora R Zöllner, Colin P S Kruse, Thomas Hartwig, Tobias Lautwein, Karl Köhrer, Wolf B Frommer, and Ji-Yun Kim. 2021. “Evidence for Phloem Loading via the Abaxial Bundle Sheath Cells in Maize Leaves.” *Plant Cell* 33 (3): 531–47.

Cardoso-Moreira, Margarida, Jean Halbert, Delphine Valloton, Britta Velten, Chunyan Chen, Yi Shao, Angélica Liechti, et al. 2019. “Gene Expression Across Mammalian Organ Development.” *Nature* 571 (7766): 505–9.

Chang, Winston, and Barbara Borges Ribeiro. 2018. *Shinydashboard: Create Dashboards with ’Shiny’*. [https://CRAN.R-project.org/package=shinydashboard](https://CRAN.R-project.org/package%3Dshinydashboard).

Chang, Winston, Joe Cheng, JJ Allaire, Cars on Sievert, Barret Schloerke, Yihui Xie, Jeff Allen, Jonathan McPherson, Alan Dipert, and Barbara Borges. 2021. *Shiny: Web Application Framework for R*. [https://CRAN.R-project.org/package=shiny](https://CRAN.R-project.org/package%3Dshiny).

Davis, Sean, and Paul Meltzer. 2007. “GEOquery: A Bridge Between the Gene Expression Omnibus (Geo) and Bioconductor.” *Bioinformatics* 14: 1846–7.

Fischer, Bernd, Mike Smith, and Gregoire Pau. 2020. *Rhdf5: R Interface to Hdf5*. <https://github.com/grimbough/rhdf5>.

Gautier, Laurent, Leslie Cope, Benjamin M. Bolstad, and Rafael A. Irizarry. 2004. “Affy—Analysis of Affymetrix Genechip Data at the Probe Level.” *Bioinformatics* 20 (3): 307–15. <https://doi.org/10.1093/bioinformatics/btg405>.

Huber, W., V. J. Carey, R. Gentleman, S. An ders, M. Carlson, B. S. Carvalho, H. C. Bravo, et al. 2015. “Orchestrating High-Throughput Genomic Analysis Wit H Bioconductor.” *Nature Methods* 12 (2): 115–21. <http://www.nature.com/nmeth/journal/v12/n2/full/nmeth.3252.html>.

Kanai, Y, Y Okada, Y Tanaka, A Harada, S Terada, and N Hirokawa. 2000. “KIF5C, a Novel Neuronal Kinesin Enriched in Motor Neurons.” *J. Neurosci.* 20 (17): 6374–84.

Keays, Maria. 2019. *ExpressionAtlas: Download Datasets from Embl-Ebi Expression Atlas*.

Langfelder, Peter, and Steve Horvath. 2008. “WGCNA: An R Package for Weighted Correlation Network Analysis.” *BMC Bioinformatics* 9 (1): 559. <https://doi.org/10.1186/1471-2105-9-559>.

Langfelder, Peter, Bin Zhang, and with contributions from Steve Horvath. 2016. *DynamicTreeCut: Methods for Detection of Clusters in Hierarchical Clustering Dendrograms*. [https://CRAN.R-project.org/package=dynamicTreeCut](https://CRAN.R-project.org/package%3DdynamicTreeCut).

Langfelder, P., and S. Horvath. 2012. “Fast R Functions for Robust Correlations and Hierarchical Clustering.” *J. Stat. Softw.* 46 (11). <https://www.ncbi.nlm.nih.gov/pubmed/23050260>.

Lekschas, Fritz, Harald Stachelscheid, Stefanie Seltmann, and Andreas Kurtz. 2015. “Semantic Body Browser: Graphical Exploration of an Organism and Spatially Resolved Expression Data Visualization.” *Bioinformatics* 31 (5): 794–96.

Love, Michael I., Wolfgang Huber, and Simon Anders. 2014. “Moderated Estimation of Fold Change and Dispersion for Rna-Seq Data with Deseq2.” *Genome Biology* 15 (12): 550. <https://doi.org/10.1186/s13059-014-0550-8>.

Maag, Jesper L V. 2018. “Gganatogram: An R Package for Modular Visualisation of Anatograms and Tissues Based on Ggplot2.” *F1000Res.* 7 (September): 1576.

McCarthy, Davis J., Chen, Yunshun, Smyth, and Gordon K. 2012. “Differential Expression Analysis of Multifactor Rna-Seq Experiments with Respect to Biological Variation.” *Nucleic Acids Research* 40 (10): 4288–97.

Merkin, Jason, Caitlin Russell, Ping Chen, and Christopher B Burge. 2012. “Evolutionary Dynamics of Gene and Isoform Regulation in Mammalian Tissues.” *Science* 338 (6114): 1593–9.

Morgan, Martin, Valerie Obenchain, Jim Hester, and Hervé Pagès. 2018. *SummarizedExperiment: SummarizedExperiment Container*.

Muschelli, John, Elizabeth Sweeney, and Ciprian Crainiceanu. 2014. “BrainR: Interactive 3 and 4D Images of High Resolution Neuroimage Data.” *R J.* 6 (1): 41–48.

Mustroph, Angelika, M Eugenia Zanetti, Charles J H Jang, Hans E Holtan, Peter P Repetti, David W Galbraith, Thomas Girke, and Julia Bailey-Serres. 2009. “Profiling Translatomes of Discrete Cell Populations Resolves Altered Cellular Priorities During Hypoxia in Arabidopsis.” *Proc Natl Acad Sci U S A* 106 (44): 18843–8.

Papatheodorou, Irene, Nuno A Fonseca, Maria Keays, Y Amy Tang, Elisabet Barrera, Wojciech Bazant, Melissa Burke, et al. 2018. “Expression Atlas: gene and protein expression across multiple studies and organisms.” *Nucleic Acids Res.* 46 (D1): D246–D251. <https://doi.org/10.1093/nar/gkx1158>.

Prudencio, Mercedes, Veronique V Belzil, Ranjan Batra, Christian A Ross, Tania F Gendron, Luc J Pregent, Melissa E Murray, et al. 2015. “Distinct Brain Transcriptome Profiles in C9orf72-Associated and Sporadic ALS.” *Nat. Neurosci.* 18 (8): 1175–82.

Ravasz, E, A L Somera, D A Mongru, Z N Oltvai, and A L Barabási. 2002. “Hierarchical Organization of Modularity in Metabolic Networks.” *Science* 297 (5586): 1551–5.

Ritchie, Matthew E, Belinda Phipson, Di Wu, Yifang Hu, Charity W Law, Wei Shi, and Gordon K Smyth. 2015. “limma Powers Differential Expression Analyses for RNA-Sequencing and Microarray Studies.” *Nucleic Acids Research* 43 (7): e47. <https://doi.org/10.1093/nar/gkv007>.

Waese, Jamie, Jim Fan, Asher Pasha, Hans Yu, Geoffrey Fucile, Ruian Shi, Matthew Cumming, et al. 2017. “EPlant: Visualizing and Exploring Multiple Levels of Data for Hypothesis Generation in Plant Biology.” *Plant Cell* 29 (8): 1806–21.

Winter, Debbie, Ben Vinegar, Hardeep Nahal, Ron Ammar, Greg V Wilson, and Nicholas J Provart. 2007. “An ‘Electronic Fluorescent Pictograph’ Browser for Exploring and Analyzing Large-Scale Biological Data Sets.” *PLoS One* 2 (8): e718.

Zhang, Jianhai, Le Zhang, Brendan Gongol, Jordan Hayes, Alexander T Borowsky, Julia Bailey-Serres, and Thomas Girke. 2024. “SpatialHeatmap: Visualizing Spatial Bulk and Single-Cell Assays in Anatomical Images.” *NAR Genomics and Bioinformatics* 6 (1): lqae006. <https://doi.org/10.1093/nargab/lqae006>.

# Appendix