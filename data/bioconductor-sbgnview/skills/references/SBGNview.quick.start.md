# SBGNview Quick Start

#### Kovidh Vegesna, kvegesna (AT) uncc.edu

#### Weijun Luo, luo\_weijun (AT) yahoo.com

#### 30 October, 2025

# 1 Overview

We previously developed an R/BioConductor package called [Pathview](https://www.bioconductor.org/packages/pathview), which maps, integrates and visualizes a wide range of data onto KEGG pathway graphs. Since its publication, Pathview has been widely used in omics studies and data analyses, and has become the leading tool in its category. Here we introduce the SBGNview package, which adopts [Systems Biology Graphical Notation (SBGN)](https://sbgn.github.io/) and greatly extends the Pathview project by supporting multiple major pathway databases beyond KEGG.

Key features:

* Pathway definition by the widely adopted [Systems Biology Graphical Notation (SBGN)](https://sbgn.github.io/);
* Supports multiple major pathway databases beyond KEGG ([Reactome](https://reactome.org/), [MetaCyc](https://metacyc.org/), [SMPDB](https://smpdb.ca/), [PANTHER](http://www.pantherdb.org/pathway/), [METACROP](https://metacrop.ipk-gatersleben.de/) etc) and user defined pathways;
* Covers 5,200 reference pathways and over 3,000 species by default;
* Extensive graphics controls, including glyph and edge attributes, graph layout and sub-pathway highlight;
* SBGN pathway data manipulation, processing, extraction and analysis.

# 2 Citation

Please cite the following papers when using this open-source package. This will help the project and our team:

Luo W, Brouwer C. Pathview: an R/Biocondutor package for pathway-based data integration and visualization. Bioinformatics, 2013, 29(14):1830-1831, [doi: 10.1093/bioinformatics/btt285](https://doi.org/10.1093/bioinformatics/btt285)

# 3 Installation

## 3.1 Prerequisites

*SBGNview* depends or imports from the following R packages:

* xml2: parse SBGN-ML files
* rsvg: convert svg files to other formats (pdf, png, ps). librsvg2 is needed to install rsvg. See this page for more details: <https://github.com/jeroen/rsvg>
* igraph: find shortest paths
* httr: search [SBGNhub](https://github.com/datapplab/SBGNhub/tree/master/data/id.mapping.unique.pair.name) for mapping files
* KEGGREST: generate mapping tables from scratch when needed
* [pathview](https://bioconductor.org/packages/release/bioc/html/pathview.html): map between different ID types for gene and chemical compound
* [gage](https://bioconductor.org/packages/release/bioc/html/gage.html): R package for pathway enrichment analysis.
* [SBGNview.data](https://bioconductor.org/packages/release/data/experiment/html/SBGNview.data.html): demo and supportive datasets for SBGNview package
* [SummarizedExperiment](https://bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html): alternative input user data as SummarizedExperiment objects
* AnnotationDbi: BioConductor annotation data and infrastructure

Note these dependencies will be automatically installed when SBGNview is installed from BioConductor or GitHub. To install them manually within R:

```
if (!requireNamespace("BiocManager", quietly = TRUE)){
     install.packages("BiocManager")
}
BiocManager::install(c("xml2", "rsvg", "igraph", "httr", "KEGGREST", "pathview", "gage", "SBGNview.data", "SummarizedExperiment", "AnnotationDbi"))
```

External dependencies (outside R):
**Windows 10**: none

**Linux (Ubuntu)**: needs additional packages (libxml2-dev, libssl-dev, libcurl4-openssl-dev, librsvg2-dev) to be installed. Run the command below in a terminal to install the necessary packages. The same or similar packages can be found for other distributes of linux.

```
sudo apt install libxml2-dev libssl-dev libcurl4-openssl-dev librsvg2-dev
```

## 3.2 Install SBGNview

Install SBGNview through Bioconductor:

```
BiocManager::install(c("SBGNview"))
```

Install SBGNview through GitHub:

```
install.packages("devtools")
devtools::install_github("datapplab/SBGNview")
```

Clone the Git repository:

```
git clone https://github.com/datapplab/SBGNview.git
```

# 4 Quick example

```
library(SBGNview)
# load demo dataset, SBGN pathway data collection and info, which may take a few seconds
data("gse16873.d","pathways.info", "sbgn.xmls")
input.pathways <- findPathways("Adrenaline and noradrenaline biosynthesis")
SBGNview.obj <- SBGNview(
          gene.data = gse16873.d[,1:3],
          gene.id.type = "entrez",
          input.sbgn = input.pathways$pathway.id,
          output.file = "quick.start",
          output.formats =  c("png")
          )
print(SBGNview.obj)
```

Two image files (a svg file by default and a png file) will be created in the current working directory.

![\label{fig:quickStartFig}Quick start example: Adrenaline and noradrenaline biosynthesis pathway. ](data:image/svg+xml;base64...)

Figure 4.1: Quick start example: Adrenaline and noradrenaline biosynthesis pathway.

As a unique and useful feature of SBGNview package, we can highlight nodes, edges and/or paths using the highlight functions. Please read the function documentation and main vignette for details.{#quickhighlight}

```
outputFile(SBGNview.obj) <- "quick.start.highlights"
SBGNview.obj + highlightArcs(class = "production",color = "red") +
               highlightArcs(class = "consumption",color = "blue") +
               highlightNodes(node.set = c("tyrosine", "(+-)-epinephrine"),
                              stroke.width = 4, stroke.color = "green") +
               highlightPath(from.node = "tyrosine", to.node = "dopamine",
                             from.node.color = "green",
                             to.node.color = "blue",
                             shortest.paths.cols = "purple",
                             input.node.stroke.width = 6,
                             path.node.stroke.width = 5,
                             path.node.color = "purple",
                             path.stroke.width = 5,
                             tip.size = 10 )
```

![\label{fig:quickStartFigHighlight}Quick start example: Highlight arcs, nodes, and path.](data:image/svg+xml;base64...)

Figure 4.2: Quick start example: Highlight arcs, nodes, and path.

# 5 Additional information

This tutorial is just a brief introduction and quick start. For more info, please check the package documentation and main vignettes.

* [SBGNview main tutorial](https://bioconductor.org/packages/devel/bioc/vignettes/SBGNview/inst/doc/SBGNview.Vignette.html)
* [Pathway analysis workflow using SBGNview](https://bioconductor.org/packages/devel/bioc/vignettes/SBGNview/inst/doc/pathway.enrichment.analysis.html)

For more info on SBGN, please check the official [SBGN project website](https://sbgn.github.io/)

For any questions, please contact Kovidh Vegesna (kvegesna [AT] uncc.edu) or Weijun Luo (luo\_weijun [AT] yahoo.com)

# 6 Session Info

```
sessionInfo()
```

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] SBGNview_1.24.0      SBGNview.data_1.23.0 pathview_1.50.0
## [4] knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10                 generics_0.1.4
##  [3] SparseArray_1.10.0          xml2_1.4.1
##  [5] bitops_1.0-9                lattice_0.22-7
##  [7] RSQLite_2.4.3               digest_0.6.37
##  [9] magrittr_2.0.4              evaluate_1.0.5
## [11] grid_4.5.1                  KEGGgraph_1.70.0
## [13] bookdown_0.45               fastmap_1.2.0
## [15] blob_1.2.4                  Matrix_1.7-4
## [17] jsonlite_2.0.0              AnnotationDbi_1.72.0
## [19] graph_1.88.0                DBI_1.2.3
## [21] httr_1.4.7                  XML_3.99-0.19
## [23] Rgraphviz_2.54.0            Biostrings_2.78.0
## [25] jquerylib_0.1.4             abind_1.4-8
## [27] Rdpack_2.6.4                cli_3.6.5
## [29] rlang_1.1.6                 crayon_1.5.3
## [31] rbibutils_2.3               XVector_0.50.0
## [33] Biobase_2.70.0              bit64_4.6.0-1
## [35] DelayedArray_0.36.0         cachem_1.1.0
## [37] yaml_2.3.10                 S4Arrays_1.10.0
## [39] tools_4.5.1                 memoise_2.0.1
## [41] SummarizedExperiment_1.40.0 BiocGenerics_0.56.0
## [43] vctrs_0.6.5                 R6_2.6.1
## [45] org.Hs.eg.db_3.22.0         png_0.1-8
## [47] matrixStats_1.5.0           stats4_4.5.1
## [49] lifecycle_1.0.4             KEGGREST_1.50.0
## [51] Seqinfo_1.0.0               rsvg_2.7.0
## [53] S4Vectors_0.48.0            IRanges_2.44.0
## [55] bit_4.6.0                   pkgconfig_2.0.3
## [57] bslib_0.9.0                 GenomicRanges_1.62.0
## [59] xfun_0.53                   MatrixGenerics_1.22.0
## [61] htmltools_0.5.8.1           igraph_2.2.1
## [63] rmarkdown_2.30              compiler_4.5.1
## [65] RCurl_1.98-1.17
```