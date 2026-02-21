# Human Protein Atlas in R

Laurent Gatto1

1de Duve Institute, UCLouvain, Belgium

#### 30 October 2025

#### Abstract

The Human Protein Atlas (HPA) is a systematic study oh the human proteome using antibody-based proteomics. Multiple tissues and cell lines are systematically assayed affinity-purified antibodies and confocal microscopy. The *hpar* package is an R interface to the HPA project. It distributes three data sets, provides functionality to query these and to access detailed information pages, including confocal microscopy images available on the HPA web page.

#### Package

hpar 1.52.0

# 1 Introduction

## 1.1 The HPA project

From the [Human Protein Atlas](http://www.proteinatlas.org/)
(Uhlén et al. [2005](#ref-Uhlen2005); Uhlen et al. [2010](#ref-Uhlen2010)) site:

> The Swedish Human Protein Atlas project, funded by the Knut and
> Alice Wallenberg Foundation, has been set up to allow for a
> systematic exploration of the human proteome using Antibody-Based
> Proteomics. This is accomplished by combining high-throughput
> generation of affinity-purified antibodies with protein profiling in
> a multitude of tissues and cells assembled in tissue
> microarrays. Confocal microscopy analysis using human cell lines is
> performed for more detailed protein localisation. The program hosts
> the Human Protein Atlas portal with expression profiles of human
> proteins in tissues and cells.

The *[hpar](https://bioconductor.org/packages/3.22/hpar)* package provides access to HPA data from the R
interface. It also distributes the following data sets:

Several flat files are distributed by the HPA project and available
within the package as data.frames, other datasets are available
through a search query on the HPA website. The description below is
taken from the HPA site:

* hpaNormalTissue: Normal tissue data. Expression profiles for
  proteins in human tissues based on immunohistochemisty using
  tissue micro arrays. The tab-separated file includes Ensembl
  gene identifier (“Gene”), tissue name (“Tissue”), annotated cell
  type (“Cell type”), expression value (“Level”), and the gene
  reliability of the expression value (“Reliability”).
* hpaNormalTissue16.1: Same as above, for version 16.1.
* hpaCancer: Pathology data. Staining profiles for proteins in
  human tumor tissue based on immunohistochemisty using tissue
  micro arrays and log-rank P value for Kaplan-Meier analysis of
  correlation between mRNA expression level and patient survival.
  The tab-separated file includes Ensembl gene identifier
  (“Gene”), gene name (“Gene name”), tumor name (“Cancer”), the
  number of patients annotated for different staining levels
  (“High”, “Medium”, “Low” & “Not detected”) and log-rank p values
  for patient survival and mRNA correlation
  (“prognostic - favourable”, “unprognostic - favourable”,
  “prognostic - unfavourable”, “unprognostic - unfavourable”).
* hpaCancer16.1: Same as above, for version 16.1
* rnaConsensusTissue: RNA consensus tissue gene data. Consensus
  transcript expression levels summarized per gene in 54 tissues
  based on transcriptomics data from HPA and GTEx. The consensus
  normalized expression (“nTPM”) value is calculated as the
  maximum nTPM value for each gene in the two data sources. For
  tissues with multiple sub-tissues (brain regions, lymphoid
  tissues and intestine) the maximum of all sub-tissues is used
  for the tissue type. The tab-separated file includes Ensembl
  gene identifier (“Gene”), analysed sample (“Tissue”) and
  normalized expression (“nTPM”).
* rnaHpaTissue: RNA HPA tissue gene data. Transcript expression
  levels summarized per gene in 256 tissues based on RNA-seq. The
  tab-separated file includes Ensembl gene identifier (“Gene”),
  analysed sample (“Tissue”), transcripts per million (“TPM”),
  protein-transcripts per million (“pTPM”) and normalized
  expression (“nTPM”).
* rnaGtexTissue: RNA GTEx tissue gene data. Transcript expression
  levels summarized per gene in 37 tissues based on RNA-seq. The
  tab-separated file includes Ensembl gene identifier (“Gene”),
  analysed sample (“Tissue”), transcripts per million (“TPM”),
  protein-transcripts per million (“pTPM”) and normalized
  expression (“nTPM”). The data was obtained from GTEx.
* rnaFantomTissue: RNA FANTOM tissue gene data. Transcript
  expression levels summarized per gene in 60 tissues based on
  CAGE data. The tab-separated file includes Ensembl gene
  identifier (“Gene”), analysed sample (“Tissue”), tags per
  million (“Tags per million”), scaled-tags per million
  (“Scaled tags per million”) and normalized expression
  (“nTPM”). The data was obtained from FANTOM5.
* rnaGeneTissue21.0: RNA HPA tissue gene data. Transcript
  expression levels summarized per gene in 37 tissues based on
  RNA-seq, for hpa version 21.0. The tab-separated file includes
  Ensembl gene identifier (“Gene”), analysed sample (“Tissue”),
  transcripts per million (“TPM”), protein-transcripts per million
  (“pTPM”).
* rnaGeneCellLine: RNA HPA cell line gene data. Transcript
  expression levels summarized per gene in 69 cell lines. The
  tab-separated file includes Ensembl gene identifier (“Gene”),
  analysed sample (“Cell line”), transcripts per million (“TPM”),
  protein-coding transcripts per million (“pTPM”) and normalized
  expression (“nTPM”).
* rnaGeneCellLine16.1: Same as above, for version 16.1.
* hpaSubcellularLoc: Subcellular location data. Subcellular
  location of proteins based on immunofluorescently stained
  cells. The tab-separated file includes the following columns:
  Ensembl gene identifier (“Gene”), name of gene (“Gene name”),
  gene reliability score (“Reliability”), enhanced locations
  (“Enhanced”), supported locations (“Supported”), Approved
  locations (“Approved”), uncertain locations (“Uncertain”),
  locations with single-cell variation in intensity
  (“Single-cell variation intensity”), locations with spatial
  single-cell variation (“Single-cell variation spatial”),
  locations with observed cell cycle dependency (type can be one
  or more of biological definition, custom data or correlation)
  (“Cell cycle dependency”), Gene Ontology Cellular Component term
  identifier (“GO id”).
* hpaSubcellularLoc16.1: Same as above, for version 16.1.
* hpaSubcellularLoc14: Same as above, for version 14.
* hpaSecretome: Secretome data. The human secretome is here
  defined as all Ensembl genes with at least one predicted
  secreted transcript according to HPA predictions. The complete
  information about the HPA Secretome data is given on
  <https://www.proteinatlas.org/humanproteome/blood/secretome>. This
  dataset has 315 columns and includes the Ensembl gene identifier
  (“Gene”). Information about the additionnal variables can be
  found [here](https://www.proteinatlas.org/search) by clicking on
  *Show/hide columns*.

The `hpar::allHparData()` returns a list of all datasets (see below).

## 1.2 HPA data usage policy

The use of data and images from the HPA in publications and
presentations is permitted provided that the following conditions are
met:

* The publication and/or presentation are solely for informational and
  non-commercial purposes.
* The source of the data and/or image is referred to the HPA
  site111 www.proteinatlas.org and/or one or more of our publications
  are cited.

## 1.3 Installation

*[hpar](https://bioconductor.org/packages/3.22/hpar)* is available through the Bioconductor
project. Details about the package and the installation procedure can
be found on its
[landing page](http://bioconductor.org/packages/devel/bioc/html/hpar.html). To
install using the dedicated Bioconductor infrastructure, run :

```
## install BiocManager only one
install.packages("BiocManager")
## install hpar
BiocManager::install("hpar")
```

After installation, *[hpar](https://bioconductor.org/packages/3.22/hpar)* will have to be explicitly
loaded with

```
library("hpar")
```

```
## This is hpar version 1.52.0,
## based on the Human Protein Atlas
##   Version: 21.1
##   Release data: 2022.05.31
##   Ensembl build: 103.38
## See '?hpar' or 'vignette('hpar')' for details.
```

so that all the package’s functionality and data is available to the
user.

# 2 The *[hpar](https://bioconductor.org/packages/3.22/hpar)* package

## 2.1 Data sets

A table descibing all dataset available in the package can be accessed
with the `allHparData()` function.

```
hpa_data <- allHparData()
```

The *Title* variable corresponds to names of the data that can be
downloaded localled and cached as part of the ExperimentHub
infrastructure.

```
head(normtissue <- hpaNormalTissue())
```

```
## see ?hpar and browseVignettes('hpar') for documentation
```

```
## loading from cache
```

```
##              Gene Gene.name         Tissue           Cell.type        Level
## 1 ENSG00000000003    TSPAN6 adipose tissue          adipocytes Not detected
## 2 ENSG00000000003    TSPAN6  adrenal gland     glandular cells Not detected
## 3 ENSG00000000003    TSPAN6       appendix     glandular cells       Medium
## 4 ENSG00000000003    TSPAN6       appendix     lymphoid tissue Not detected
## 5 ENSG00000000003    TSPAN6    bone marrow hematopoietic cells Not detected
## 6 ENSG00000000003    TSPAN6         breast          adipocytes Not detected
##   Reliability
## 1    Approved
## 2    Approved
## 3    Approved
## 4    Approved
## 5    Approved
## 6    Approved
```

Note that given that the `hpa` data is distributed as par the
ExperimentHub infrastructure, it is also possible to query it directly
for relevant datasets.

```
library("ExperimentHub")
eh <- ExperimentHub()
query(eh, "hpar")
```

```
## ExperimentHub with 15 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Human Protein Atlas
## # $species: Homo sapiens
## # $rdataclass: data.frame
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH7765"]]'
##
##            title
##   EH7765 | hpaCancer16.1
##   EH7766 | hpaCancer
##   EH7767 | hpaNormalTissue16.1
##   EH7768 | hpaNormalTissue
##   EH7769 | hpaSecretome
##   ...      ...
##   EH7775 | rnaGeneCellLine16.1
##   EH7776 | rnaGeneCellLine
##   EH7777 | rnaGeneTissue21.0
##   EH7778 | rnaGtexTissue
##   EH7779 | rnaHpaTissue
```

## 2.2 HPA interface

Each data described above is a `data.frame` and can be easily
manipulated using standard R or `BiocStyle::CRANpkg("tidyverse")`
tidyverse functionality.

```
names(normtissue)
```

```
## [1] "Gene"        "Gene.name"   "Tissue"      "Cell.type"   "Level"
## [6] "Reliability"
```

```
## Number of genes
length(unique(normtissue$Gene))
```

```
## [1] 15323
```

```
## Number of cell types
length(unique(normtissue$Cell.type))
```

```
## [1] 141
```

```
## Number of tissues
length(unique(normtissue$Tissue))
```

```
## [1] 63
```

```
## Number of genes highlighly and reliably expressed in each cell type
## in each tissue.
library("dplyr")
normtissue |>
    filter(Reliability == "Approved",
           Level == "High") |>
    count(Cell.type, Tissue) |>
    arrange(desc(n)) |>
    head()
```

```
##          Cell.type          Tissue    n
## 1  glandular cells     gallbladder 1578
## 2  glandular cells        duodenum 1551
## 3  glandular cells small intestine 1532
## 4  glandular cells          rectum 1490
## 5  glandular cells           colon 1404
## 6 cells in tubules          kidney 1357
```

We will illustrate additional datasets using the TSPAN6 (tetraspanin
6) gene (ENSG00000000003) as example.

```
id <- "ENSG00000000003"
subcell <- hpaSubcellularLoc()
```

```
## see ?hpar and browseVignettes('hpar') for documentation
```

```
## loading from cache
```

```
rna <- rnaGeneCellLine()
```

```
## see ?hpar and browseVignettes('hpar') for documentation
## loading from cache
```

```
## Compine protein immunohistochemisty data, with the subcellular
## location and RNA expression levels.
filter(normtissue, Gene == id) |>
    full_join(filter(subcell, Gene == id)) |>
    full_join(filter(rna, Gene == id)) |>
    head()
```

```
## Joining with `by = join_by(Gene, Gene.name, Reliability)`
```

```
## Joining with `by = join_by(Gene, Gene.name)`
```

```
## Warning in full_join(full_join(filter(normtissue, Gene == id), filter(subcell, : Detected an unexpected many-to-many relationship between `x` and `y`.
## ℹ Row 1 of `x` matches multiple rows in `y`.
## ℹ Row 1 of `y` matches multiple rows in `x`.
## ℹ If a many-to-many relationship is expected, set `relationship =
##   "many-to-many"` to silence this warning.
```

```
##              Gene Gene.name         Tissue  Cell.type        Level Reliability
## 1 ENSG00000000003    TSPAN6 adipose tissue adipocytes Not detected    Approved
## 2 ENSG00000000003    TSPAN6 adipose tissue adipocytes Not detected    Approved
## 3 ENSG00000000003    TSPAN6 adipose tissue adipocytes Not detected    Approved
## 4 ENSG00000000003    TSPAN6 adipose tissue adipocytes Not detected    Approved
## 5 ENSG00000000003    TSPAN6 adipose tissue adipocytes Not detected    Approved
## 6 ENSG00000000003    TSPAN6 adipose tissue adipocytes Not detected    Approved
##            Main.location       Additional.location Extracellular.location
## 1 Cell Junctions;Cytosol Nucleoli fibrillar center
## 2 Cell Junctions;Cytosol Nucleoli fibrillar center
## 3 Cell Junctions;Cytosol Nucleoli fibrillar center
## 4 Cell Junctions;Cytosol Nucleoli fibrillar center
## 5 Cell Junctions;Cytosol Nucleoli fibrillar center
## 6 Cell Junctions;Cytosol Nucleoli fibrillar center
##   Enhanced Supported                                         Approved Uncertain
## 1                    Cell Junctions;Cytosol;Nucleoli fibrillar center
## 2                    Cell Junctions;Cytosol;Nucleoli fibrillar center
## 3                    Cell Junctions;Cytosol;Nucleoli fibrillar center
## 4                    Cell Junctions;Cytosol;Nucleoli fibrillar center
## 5                    Cell Junctions;Cytosol;Nucleoli fibrillar center
## 6                    Cell Junctions;Cytosol;Nucleoli fibrillar center
##   Single.cell.variation.intensity Single.cell.variation.spatial
## 1                         Cytosol
## 2                         Cytosol
## 3                         Cytosol
## 4                         Cytosol
## 5                         Cytosol
## 6                         Cytosol
##   Cell.cycle.dependency
## 1
## 2
## 3
## 4
## 5
## 6
##                                                                                     GO.id
## 1 Cell Junctions (GO:0030054);Cytosol (GO:0005829);Nucleoli fibrillar center (GO:0001650)
## 2 Cell Junctions (GO:0030054);Cytosol (GO:0005829);Nucleoli fibrillar center (GO:0001650)
## 3 Cell Junctions (GO:0030054);Cytosol (GO:0005829);Nucleoli fibrillar center (GO:0001650)
## 4 Cell Junctions (GO:0030054);Cytosol (GO:0005829);Nucleoli fibrillar center (GO:0001650)
## 5 Cell Junctions (GO:0030054);Cytosol (GO:0005829);Nucleoli fibrillar center (GO:0001650)
## 6 Cell Junctions (GO:0030054);Cytosol (GO:0005829);Nucleoli fibrillar center (GO:0001650)
##   Cell.line  TPM pTPM nTPM
## 1     A-431 21.3 25.6 24.8
## 2      A549 20.5 24.4 23.0
## 3      AF22 78.8 96.9 80.6
## 4    AN3-CA 38.7 47.1 42.2
## 5  ASC diff 19.2 22.1 28.7
## 6 ASC TERT1 11.3 13.1 16.6
```

It is also possible to directly open the HPA page for a specific gene
(see figure below).

```
browseHPA(id)
```

![](data:image/png;base64...)

The HPA web page for the tetraspanin 6 gene (ENSG00000000003).

## 2.3 HPA release information

Information about the HPA release used to build the installed
*[hpar](https://bioconductor.org/packages/3.22/hpar)* package can be accessed with `getHpaVersion`,
`getHpaDate` and `getHpaEnsembl`. Full release details can be found on
the [HPA release history](http://www.proteinatlas.org/about/releases)
page.

```
getHpaVersion()
```

```
## version
##  "21.1"
```

```
getHpaDate()
```

```
##         date
## "2022.05.31"
```

```
getHpaEnsembl()
```

```
##  ensembl
## "103.38"
```

# 3 A small use case

Let’s compare the subcellular localisation annotation obtained from
the HPA subcellular location data set and the information available in
the Bioconductor annotation packages.

```
id <- "ENSG00000001460"
filter(subcell, Gene == id)
```

```
##              Gene Gene.name Reliability Main.location Additional.location
## 1 ENSG00000001460     STPG1    Approved   Nucleoplasm
##   Extracellular.location Enhanced Supported    Approved Uncertain
## 1                                           Nucleoplasm
##   Single.cell.variation.intensity Single.cell.variation.spatial
## 1
##   Cell.cycle.dependency                    GO.id
## 1                       Nucleoplasm (GO:0005654)
```

Below, we first extract all cellular component GO terms available for
`id` from the *[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)* human annotation and
then retrieve their term definitions using the *[GO.db](https://bioconductor.org/packages/3.22/GO.db)*
database.

```
library("org.Hs.eg.db")
library("GO.db")
ans <- AnnotationDbi::select(org.Hs.eg.db, keys = id,
                             columns = c("ENSEMBL", "GO", "ONTOLOGY"),
                             keytype = "ENSEMBL")
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
ans <- ans[ans$ONTOLOGY == "CC", ]
ans
```

```
##           ENSEMBL         GO EVIDENCE ONTOLOGY
## 1 ENSG00000001460 GO:0005634      IEA       CC
## 2 ENSG00000001460 GO:0005737      IEA       CC
## 3 ENSG00000001460 GO:0005739      IEA       CC
```

```
sapply(as.list(GOTERM[ans$GO]), slot, "Term")
```

```
##      GO:0005634      GO:0005737      GO:0005739
##       "nucleus"     "cytoplasm" "mitochondrion"
```

# Session information

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
##  [1] ExperimentHub_3.0.0  AnnotationHub_4.0.0  BiocFileCache_3.0.0
##  [4] dbplyr_2.5.1         hpar_1.52.0          GO.db_3.22.0
##  [7] org.Hs.eg.db_3.22.0  AnnotationDbi_1.72.0 IRanges_2.44.0
## [10] S4Vectors_0.48.0     Biobase_2.70.0       BiocGenerics_0.56.0
## [13] generics_0.1.4       dplyr_1.1.4          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3      sass_0.4.10         BiocVersion_3.22.0
##  [4] RSQLite_2.4.3       digest_0.6.37       magrittr_2.0.4
##  [7] evaluate_1.0.5      bookdown_0.45       fastmap_1.2.0
## [10] blob_1.2.4          jsonlite_2.0.0      DBI_1.2.3
## [13] BiocManager_1.30.26 httr_1.4.7          purrr_1.1.0
## [16] crosstalk_1.2.2     Biostrings_2.78.0   httr2_1.2.1
## [19] jquerylib_0.1.4     cli_3.6.5           rlang_1.1.6
## [22] crayon_1.5.3        XVector_0.50.0      bit64_4.6.0-1
## [25] withr_3.0.2         cachem_1.1.0        yaml_2.3.10
## [28] tools_4.5.1         memoise_2.0.1       DT_0.34.0
## [31] filelock_1.0.3      curl_7.0.0          vctrs_0.6.5
## [34] R6_2.6.1            png_0.1-8           lifecycle_1.0.4
## [37] KEGGREST_1.50.0     Seqinfo_1.0.0       htmlwidgets_1.6.4
## [40] bit_4.6.0           pkgconfig_2.0.3     pillar_1.11.1
## [43] bslib_0.9.0         glue_1.8.0          xfun_0.53
## [46] tibble_3.3.0        tidyselect_1.2.1    knitr_1.50
## [49] htmltools_0.5.8.1   rmarkdown_2.30      compiler_4.5.1
```

Uhlen, Mathias, Per Oksvold, Linn Fagerberg, Emma Lundberg, Kalle Jonasson, Mattias Forsberg, Martin Zwahlen, et al. 2010. “Towards a knowledge-based Human Protein Atlas.” *Nature Biotechnology* 28 (12): 1248–50. <https://doi.org/10.1038/nbt1210-1248>.

Uhlén, Mathias, Erik Björling, Charlotta Agaton, Cristina Al-Khalili A. Szigyarto, Bahram Amini, Elisabet Andersen, Ann-Catrin C. Andersson, et al. 2005. “A human protein atlas for normal and cancer tissues based on antibody proteomics.” *Molecular & Cellular Proteomics : MCP* 4 (12): 1920–32. <https://doi.org/10.1074/mcp.M500279-MCP200>.