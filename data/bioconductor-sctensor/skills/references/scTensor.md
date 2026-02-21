# Detection and visualization of cell-cell interactions using `LRBase` and `scTensor`

Koki Tsuyuzaki1, Manabu Ishii1 and Itoshi Nikaido1\*

1Laboratory for Bioinformatics Research, RIKEN Center for Biosystems Dynamics Research

\*k.t.the-answer@hotmail.co.jp

#### 30 October 2025

#### Package

scTensor 2.20.0

# Contents

* [1 Specification change of `LRBase` and `scTensor` from BioC 3.14 (Nov. 2021)](#specification-change-of-lrbase-and-sctensor-from-bioc-3.14-nov.-2021)
* [2 Introduction](#introduction)
  + [2.1 About Cell-Cell Interaction (CCI) databases](#about-cell-cell-interaction-cci-databases)
  + [2.2 `LRBase` and `scTensor` framework](#lrbase-and-sctensor-framework)
* [3 Usage](#usage)
  + [3.1 LRBase objects (ligand-receptor database for 134 organisms)](#lrbase-objects-ligand-receptor-database-for-134-organisms)
    - [3.1.1 Data retrieval from `AnnotationHub`](#data-retrieval-from-annotationhub)
    - [3.1.2 columns, keytypes, keys, and select](#columns-keytypes-keys-and-select)
    - [3.1.3 Other functions](#other-functions)
  + [3.2 `scTensor` (CCI-tensor construction, decomposition, and HTML reporting)](#sctensor-cci-tensor-construction-decomposition-and-html-reporting)
    - [3.2.1 Creating a `SingleCellExperiment` object](#creating-a-singlecellexperiment-object)
    - [3.2.2 Parameter setting: `cellCellSetting`](#parameter-setting-cellcellsetting)
    - [3.2.3 CCI-tensor construction and decomposition: `cellCellDecomp`](#cci-tensor-construction-and-decomposition-cellcelldecomp)
    - [3.2.4 HTML Report: `cellCellReport`](#html-report-cellcellreport)
* [Session Information](#session-information)

This vignette has been changed in BioC 3.14, when each data package (LRBase.XXX.eg.db) is deprecated and the way to provide LRBase data has changed to AnnotationHub-style.

# 1 Specification change of `LRBase` and `scTensor` from BioC 3.14 (Nov. 2021)

This section is for the users of previous LRBase.XXX.eg.db-type packages and scTensor. The specifications of the LRBase.XXX.eg.db and scTensor have changed significantly since BioC 3.14. Specifically, the distribution of all LRBase.XXX.eg.db-type packages will be abolished, and the policy has been switched to one where the data is placed on a cloud server called AnnotationHub, and users are allowed to retrieve the data only when they really need it. The following are the advantages of this AnnotationHub-style.

* The installation time of the entire Bioconductor packages will be reduced.
* Old data will be archived.
* Data reproducibility is ensured (e.g. the version of the data can be specified, such as “v002”).

# 2 Introduction

## 2.1 About Cell-Cell Interaction (CCI) databases

Due to the rapid development of single-cell RNA-Seq (scRNA-Seq) technologies, wide variety of cell types such as multiple organs of a healthy person, stem cell niche and cancer stem cell have been found. Such complex systems are composed of communication between cells (cell-cell interaction or CCI).

Many CCI studies are based on the ligand-receptor (L-R)-pair list of FANTOM5 project111 Jordan A. Ramilowski, A draft network of ligand-receptor-mediated multicellular signaling in human, Nature Communications, 2015 as the evidence of CCI (<http://fantom.gsc.riken.jp/5/suppl/Ramilowski_et_al_2015/data/PairsLigRec.txt>). The project proposed the L-R-candidate genes by following two basises.

1. **Subcellular Localization**
   1. Known Annotation (UniProtKB and HPRD) : The term **“Secreted”** for
      candidate ligand genes and **“Plasma Membrane”** for
      candidate receptor genes
   2. Computational Prediction (LocTree3 and PolyPhobius)
2. **Physical Binding of Proteins** : Experimentally validated PPI
   (protein-protein interaction) information of HPRD and STRING

The project also merged the data with previous L-R database such as
IUPHAR/DLRP/HPMR and filter out the list without PMIDs. The recent L-R databases such as CellPhoneDB and SingleCellSignalR also manually curated L-R pairs, which are not listed in IUPHAR/DLRP/HPMR. In Bader Laboratory, many putative L-R databases are predicted by their standards. In our framework, we expanded such L-R databases for **134** organisms based on the ortholog relationships. For the details, check the summary of rikenbit/lrbase-workflow222 <https://github.com/rikenbit/lrbase-workflow#summary>, which is the Snakemake workflow to create LRBase data in each bi-annual update of Bioconductor.

## 2.2 `LRBase` and `scTensor` framework

Our L-R databases (`LRBase`) are provided a cloud server called AnnotationHub, and users are allowed to retrieve the data only when they really need it. Downloaded data is stored as a cache file on our local machines by the *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)* mechanism. Then, the data is converted to LRBase object by *[LRBaseDbi](https://bioconductor.org/packages/3.22/LRBaseDbi)*. We also developed *[scTensor](https://bioconductor.org/packages/3.22/scTensor)*, which is a method to detect CCI and the CCI-related L-R pairs simultaneously. This document provides the way to use *[LRBaseDbi](https://bioconductor.org/packages/3.22/LRBaseDbi)*, LRBase objects, and *[scTensor](https://bioconductor.org/packages/3.22/scTensor)* (Figure 1).

![](data:image/png;base64...)

Figure 1 : Workflow of L-R-related packages

# 3 Usage

## 3.1 LRBase objects (ligand-receptor database for 134 organisms)

To create the LRBase of 134 organisms, we introduced 36 approarches including known/putative L-R pairing.
Please see the evidence code of lrbase-workflow333 <https://github.com/rikenbit/lrbase-workflow>.

### 3.1.1 Data retrieval from `AnnotationHub`

First of all, we download the data of LRBase from AnnotationHub.
`AnnotationHub::AnnotationHub` retrieve the metadata of all the data stored in cloud server.

```
library("AnnotationHub")
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
ah <- AnnotationHub()
mcols(ah)
```

```
## DataFrame with 70862 rows and 15 columns
##                           title dataprovider            species taxonomyid
##                     <character>  <character>        <character>  <integer>
## AH5012          Chromosome Band         UCSC       Homo sapiens       9606
## AH5013              STS Markers         UCSC       Homo sapiens       9606
## AH5014              FISH Clones         UCSC       Homo sapiens       9606
## AH5015              Recomb Rate         UCSC       Homo sapiens       9606
## AH5016             ENCODE Pilot         UCSC       Homo sapiens       9606
## ...                         ...          ...                ...        ...
## AH121939 MeSHDb for Xenopus t..   NCBI,DBCLS Xenopus tropicalis       8364
## AH121940 MeSHDb for Zea mays ..   NCBI,DBCLS           Zea mays       4577
## AH121941 MeSHDb for MeSH.db (..   NCBI,DBCLS                 NA         NA
## AH121942 MeSHDb for MeSH.AOR...   NCBI,DBCLS                 NA         NA
## AH121943 MeSHDb for MeSH.PCR...   NCBI,DBCLS                 NA         NA
##               genome            description coordinate_1_based
##          <character>            <character>          <integer>
## AH5012          hg19 GRanges object from ..                  1
## AH5013          hg19 GRanges object from ..                  1
## AH5014          hg19 GRanges object from ..                  1
## AH5015          hg19 GRanges object from ..                  1
## AH5016          hg19 GRanges object from ..                  1
## ...              ...                    ...                ...
## AH121939          NA Correspondence table..                  1
## AH121940          NA Correspondence table..                  1
## AH121941          NA Correspondence table..                  1
## AH121942          NA MeSH Hierarchical st..                  1
## AH121943          NA MeSH Hierarchical st..                  1
##                      maintainer rdatadateadded          preparerclass
##                     <character>    <character>            <character>
## AH5012   Marc Carlson <mcarls..     2013-03-26 UCSCFullTrackImportP..
## AH5013   Marc Carlson <mcarls..     2013-03-26 UCSCFullTrackImportP..
## AH5014   Marc Carlson <mcarls..     2013-03-26 UCSCFullTrackImportP..
## AH5015   Marc Carlson <mcarls..     2013-03-26 UCSCFullTrackImportP..
## AH5016   Marc Carlson <mcarls..     2013-03-26 UCSCFullTrackImportP..
## ...                         ...            ...                    ...
## AH121939 Koki Tsuyuzaki <k.t...     2025-10-28              AHMeSHDbs
## AH121940 Koki Tsuyuzaki <k.t...     2025-10-28              AHMeSHDbs
## AH121941 Koki Tsuyuzaki <k.t...     2025-10-28              AHMeSHDbs
## AH121942 Koki Tsuyuzaki <k.t...     2025-10-28              AHMeSHDbs
## AH121943 Koki Tsuyuzaki <k.t...     2025-10-28              AHMeSHDbs
##                                               tags  rdataclass
##                                             <AsIs> <character>
## AH5012                     cytoBand,UCSC,track,...     GRanges
## AH5013                       stsMap,UCSC,track,...     GRanges
## AH5014                   fishClones,UCSC,track,...     GRanges
## AH5015                   recombRate,UCSC,track,...     GRanges
## AH5016                encodeRegions,UCSC,track,...     GRanges
## ...                                            ...         ...
## AH121939 Annotation,DBCLS,FunctionalAnnotation,...  SQLiteFile
## AH121940                 Annotation,Corn,DBCLS,...  SQLiteFile
## AH121941 Annotation,DBCLS,FunctionalAnnotation,...  SQLiteFile
## AH121942 Annotation,DBCLS,FunctionalAnnotation,...  SQLiteFile
## AH121943 Annotation,DBCLS,FunctionalAnnotation,...  SQLiteFile
##                       rdatapath              sourceurl  sourcetype
##                     <character>            <character> <character>
## AH5012   goldenpath/hg19/data.. rtracklayer://hgdown..  UCSC track
## AH5013   goldenpath/hg19/data.. rtracklayer://hgdown..  UCSC track
## AH5014   goldenpath/hg19/data.. rtracklayer://hgdown..  UCSC track
## AH5015   goldenpath/hg19/data.. rtracklayer://hgdown..  UCSC track
## AH5016   goldenpath/hg19/data.. rtracklayer://hgdown..  UCSC track
## ...                         ...                    ...         ...
## AH121939 AHMeSHDbs/v010/MeSH... https://github.com/r..         TSV
## AH121940 AHMeSHDbs/v010/MeSH... https://github.com/r..         TSV
## AH121941 AHMeSHDbs/v010/MeSH... https://github.com/r..         TSV
## AH121942 AHMeSHDbs/v010/MeSH... https://github.com/r..         TSV
## AH121943 AHMeSHDbs/v010/MeSH... https://github.com/r..         TSV
```

Specifying some keywords in `query()`, we can find LRBase data in AnnotationHub.

```
dbfile <- query(ah, c("LRBaseDb", "Homo sapiens"))[[1]]
```

```
## loading from cache
```

AnnotationHub also keeps old data as an archive, so please make sure you have the latest version (e.g. “v002” or higher) when you search for LRBaseDb.

Then, we can convert `dbfile` into LRBase object by using `LRBaseDbi`.

```
library("LRBaseDbi")
```

```
## LRBase.XXX.eg.db-type packages are deprecated since Bioconductor 3.14. Use AnnotationHub instead. For details, check the vignette of LRBaseDbi
```

```
LRBase.Hsa.eg.db <- LRBaseDbi::LRBaseDb(dbfile)
```

### 3.1.2 columns, keytypes, keys, and select

Some data access functions are available for LRBase objects.
Any data table are retrieved by 4 functions defined by
*[AnnotationDbi](https://bioconductor.org/packages/3.22/AnnotationDbi)*; `columns`, `keytypes`, `keys`, and `select` and commonly implemented by *[LRBaseDbi](https://bioconductor.org/packages/3.22/LRBaseDbi)* package. `columns` returns the rows which we can retrieve in LRBase objects. `keytypes` returns the rows which can be used as the optional parameter in `keys` and select functions against LRBase objects. `keys` function returns the value of keytype. `select` function returns the rows in particular columns, which are having user-specified keys. This function returns the result as a dataframe. See the vignette of *[AnnotationDbi](https://bioconductor.org/packages/3.22/AnnotationDbi)* for more details.

```
columns(LRBase.Hsa.eg.db)
```

```
## [1] "GENEID_L" "GENEID_R" "SOURCEDB" "SOURCEID"
```

```
keytypes(LRBase.Hsa.eg.db)
```

```
## [1] "GENEID_L" "GENEID_R" "SOURCEDB" "SOURCEID"
```

```
key_HSA <- keys(LRBase.Hsa.eg.db, keytype="GENEID_L")
head(select(LRBase.Hsa.eg.db, keys=key_HSA[1:2],
            columns=c("GENEID_L", "GENEID_R"), keytype="GENEID_L"))
```

```
##   GENEID_L GENEID_R
## 1        1     1398
## 2        1     6622
## 3        1      310
## 4        1    10321
## 5        1    10549
## 6      100     1803
```

### 3.1.3 Other functions

Other additional functions like `species`, `nomenclature`, and `listDatabases` are available. In each LRBase.XXX.eg.db-type package, `species` function returns the common name and `nomenclature` returns the scientific name. `listDatabases` function returns the source of data. `dbInfo` returns the information of the package. `dbfile` returns the directory where sqlite file is stored. `dbschema` returns the schema of the database. `dbconn` returns the connection to the sqlite database.

```
lrNomenclature(LRBase.Hsa.eg.db)
```

```
## [1] "Homo sapiens"
```

```
species(LRBase.Hsa.eg.db)
```

```
## [1] "Human"
```

```
lrListDatabases(LRBase.Hsa.eg.db)
```

```
##             SOURCEDB
## 1           BADERLAB
## 2        CELLPHONEDB
## 3               DLRP
## 4            FANTOM5
## 5               HPMR
## 6             IUPHAR
## 7  SINGLECELLSIGNALR
## 8     SWISSPROT_HPRD
## 9   SWISSPROT_STRING
## 10       TREMBL_HPRD
## 11     TREMBL_STRING
```

```
lrVersion(LRBase.Hsa.eg.db)
```

```
##        NAME VALUE
## 1 LRVERSION  2018
```

```
dbInfo(LRBase.Hsa.eg.db)
```

```
##               NAME
## 1       SOURCEDATE
## 2      SOURCENAME1
## 3      SOURCENAME2
## 4      SOURCENAME3
## 5      SOURCENAME4
## 6      SOURCENAME5
## 7      SOURCENAME6
## 8      SOURCENAME7
## 9      SOURCENAME8
## 10     SOURCENAME9
## 11    SOURCENAME10
## 12    SOURCENAME11
## 13      SOURCEURL1
## 14      SOURCEURL2
## 15      SOURCEURL3
## 16      SOURCEURL4
## 17      SOURCEURL5
## 18      SOURCEURL6
## 19      SOURCEURL7
## 20      SOURCEURL8
## 21      SOURCEURL9
## 22     SOURCEURL10
## 23     SOURCEURL11
## 24        DBSCHEMA
## 25 DBSCHEMAVERSION
## 26        ORGANISM
## 27         SPECIES
## 28         package
## 29         Db type
## 30       LRVERSION
## 31           TAXID
##                                                                            VALUE
## 1                                                                     2025-02-03
## 2                                                                           DLRP
## 3                                                                         IUPHAR
## 4                                                                           HPMR
## 5                                                                    CELLPHONEDB
## 6                                                              SINGLECELLSIGNALR
## 7                                                                        FANTOM5
## 8                                                                       BADERLAB
## 9                                                                      SWISSPROT
## 10                                                                          HPRD
## 11                                                                        TREMBL
## 12                                                                        STRING
## 13                                     https://dip.doe-mbi.ucla.edu/dip/DLRP.cgi
## 14                              https://www.guidetopharmacology.org/download.jsp
## 15
## 16                                                   https://www.cellphonedb.org
## 17 http://www.bioconductor.org/packages/release/bioc/html/SingleCellSignalR.html
## 18                                                    http://fantom.gsc.riken.jp
## 19                                      http://baderlab.org/CellCellInteractions
## 20                            http://www.uniprot.org/uniprot/?query=reviewed:yes
## 21                                                      http://hprd.org/download
## 22                             http://www.uniprot.org/uniprot/?query=reviewed:no
## 23                                         https://string-db.org/cgi/download.pl
## 24                                                              LRBase.Hsa.eg.db
## 25                                                                           1.0
## 26                                                                  Homo sapiens
## 27                                                                         Human
## 28                                                                 AnnotationDbi
## 29                                                                      LRBaseDb
## 30                                                                          2018
## 31                                                                          9606
```

```
dbfile(LRBase.Hsa.eg.db)
```

```
##                                                       AH121554
## "/home/biocbuild/.cache/R/AnnotationHub/17127e5cc08d4f_128300"
```

```
dbschema(LRBase.Hsa.eg.db)
```

```
## [1] "CREATE TABLE DATA (\n  GENEID_L VARCHAR(10) NOT NULL,       -- e.g., 19\n  GENEID_R VARCHAR(10) NOT NULL,       -- e.g., 3763409\n  SOURCEID VARCHAR (10) NOT NULL,      -- e.g., 27535533\n  SOURCEDB VARCHAR (10) NOT NULL       -- e.g., SWISSPROT_STRING\n)"
## [2] "CREATE TABLE METADATA (\n  NAME NOT NULL,\n  VALUE TEXT\n)"
## [3] "CREATE INDEX A ON DATA (GENEID_L)"
## [4] "CREATE INDEX B ON DATA (GENEID_R)"
## [5] "CREATE INDEX C ON DATA (SOURCEDB)"
## [6] "CREATE INDEX D ON DATA (SOURCEID)"
```

```
dbconn(LRBase.Hsa.eg.db)
```

```
## <SQLiteConnection>
##   Path: /home/biocbuild/.cache/R/AnnotationHub/17127e5cc08d4f_128300
##   Extensions: TRUE
```

Combined with `dbGetQuery` function of *[RSQLite](https://CRAN.R-project.org/package%3DRSQLite)* package,
more complicated queries also can be submitted.

```
suppressPackageStartupMessages(library("RSQLite"))
dbGetQuery(dbconn(LRBase.Hsa.eg.db),
  "SELECT * FROM DATA WHERE GENEID_L = '9068' AND GENEID_R = '14' LIMIT 10")
```

```
## [1] GENEID_L GENEID_R SOURCEID SOURCEDB
## <0 rows> (or 0-length row.names)
```

## 3.2 `scTensor` (CCI-tensor construction, decomposition, and HTML reporting)

Combined with LRBase object and user’s gene expression matrix of scRNA-Seq, *[scTensor](https://bioconductor.org/packages/3.22/scTensor)* detects CCIs and generates HTML reports for exploratory data inspection. The algorithm of *[scTensor](https://bioconductor.org/packages/3.22/scTensor)* is as follows.

Firstly, *[scTensor](https://bioconductor.org/packages/3.22/scTensor)* calculates the celltype-level mean vectors, searches the corresponding pair of genes in the row names of the matrix, and extracted as two vectors.

Next, the cell type-level mean vectors of ligand expression and that of receptor expression are multiplied as outer product and converted to cell type \(\times\) cell type matrix. Here, the multiple matrices can be represented as a three-order “tensor” (Ligand-Cell \* Receptor-Cell \* L-R-Pair). *[scTensor](https://bioconductor.org/packages/3.22/scTensor)* decomposes the tensor into a small tensor (core tensor) and two factor matrices. Tensor decomposition is very similar to the matrix decomposition like PCA (principal component analysis). The core tensor is similar to the eigenvalue of PCA; this means that how much the pattern is outstanding. Likewise, three matrices are similar to the PC scores/loadings of PCA; These represent which ligand-cell/receptor-cell/L-R-pair are informative. When the matrices have negative values, interpreting which direction (+/-) is important and which is not, is a difficult and laboring task. That’s why, *[scTensor](https://bioconductor.org/packages/3.22/scTensor)*
performs non-negative Tucker2 decomposition (NTD2), which is non-negative version of tensor decomposition (cf. *[nnTensor](https://CRAN.R-project.org/package%3DnnTensor)*).

Finally, the result of NTD2 is summarized as an HTML report. Because most of the plots are visualized by *[plotly](https://CRAN.R-project.org/package%3Dplotly)* package, the precise information of the plot can be interactively confirmed by user’s on-site web browser. The two factor matrices can be interactively viewed and which cell types and which L-R-pairs are likely to be interacted each other. The mode-3 (LR-pair direction) sum of the core tensor is calculated and visualized as Ligand-Receptor Patterns. Detail of (Ligand-Cell, Receptor-Cell, L-R-pair) Patterns are also visualized.

### 3.2.1 Creating a `SingleCellExperiment` object

Here, we use the scRNA-Seq dataset of male germline cells and somatic cells\(^{3}\)[GSE86146](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE86146) as demo data. For saving the package size, the number of genes is strictly reduced by the standard of highly variable genes with a threshold of the p-value are 1E-150 (cf. [Identifying highly variable genes](http://pklab.med.harvard.edu/scw2014/subpop_tutorial.html)). That’s why we won’t argue about the scientific discussion of the data here.

We assume that user has a scRNA-Seq data matrix containing expression count data summarised at the level of the gene. First, we create a *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* object containing the data. The rows of the object correspond to features, and the columns correspond to cells. The gene identifier is limited as NCBI Gene ID for now.

To improve the interpretability of the following HTML report, we highly recommend that user specifies the two-dimensional data of input data (e.g. PCA, t-SNE, or UMAP). Such information is easily specified by `reducedDims` function of *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* package and is saved to reducedDims slot of `SingleCellExperiment` object (Figure [**??**](#fig:cellCellSetting)).

```
suppressPackageStartupMessages(library("scTensor"))
suppressPackageStartupMessages(library("SingleCellExperiment"))
```

```
data(GermMale)
data(labelGermMale)
data(tsneGermMale)

sce <- SingleCellExperiment(assays=list(counts = GermMale))
reducedDims(sce) <- SimpleList(TSNE=tsneGermMale$Y)
plot(reducedDims(sce)[[1]], col=labelGermMale, pch=16, cex=2,
  xlab="Dim1", ylab="Dim2", main="Germline, Male, GSE86146")
legend("topleft", legend=c(paste0("FGC_", 1:3), paste0("Soma_", 1:4)),
  col=c("#9E0142", "#D53E4F", "#F46D43", "#ABDDA4", "#66C2A5", "#3288BD", "#5E4FA2"),
  pch=16)
```

![Germline, Male, GSE86146](data:image/png;base64...)

Figure 1: Germline, Male, GSE86146

### 3.2.2 Parameter setting: `cellCellSetting`

To perform the tensor decomposition and HTML report, user is supposed to specify

* 1. LRBaseDb object (e.g. LRBase.Hsa.eg.db)
* 2. cell type vector of each cell (e.g. names(labelGermMale))

to `SingleCellExperiment` object.

```
cellCellSetting(sce, LRBase.Hsa.eg.db, names(labelGermMale))
```

The corresponding information is registered to the metadata slot of `SingleCellExperiment` object by `cellCellSetting` function.

### 3.2.3 CCI-tensor construction and decomposition: `cellCellDecomp`

After `cellCellSetting`, we can perform tensor decomposition by `cellCellDecomp`. Here the parameter `ranks` is specified as dimension of core tensor. For example, c(2, 3) means The data tensor is decomposed to 2 ligand-patterns and 3 receptor-patterns.

```
set.seed(1234)
cellCellDecomp(sce, ranks=c(2,3))
```

```
## Input data matrix may contains 7 gene symbols because the name contains some alphabets.
## scTensor uses only NCBI Gene IDs for now.
## Here, the gene symbols are removed and remaining 235 NCBI Gene IDs are used for scTensor next step.
```

```
## 7 * 7 * 4 Tensor is created
```

Although user has to specify the rank to perform cellCellDecomp, we implemented a simple rank estimation function based on the eigenvalues distribution of PCA in the matricised tensor in each mode in `cellCellRank`. `rks$selected` is also specified as rank parameter of `cellCellDecomp`.

```
(rks <- cellCellRanks(sce))
```

```
## Each rank, multiple NMF runs are performed
##
  |
  |                                                                      |   0%
  |
  |==========                                                            |  14%
  |
  |====================                                                  |  29%
  |
  |==============================                                        |  43%
  |
  |========================================                              |  57%
  |
  |==================================================                    |  71%
  |
  |============================================================          |  86%
  |
  |======================================================================| 100%
## Each rank estimation method
##
  |
  |                                                                      |   0%
  |
  |==========                                                            |  14%
  |
  |====================                                                  |  29%
  |
  |==============================                                        |  43%
  |
  |========================================                              |  57%
  |
  |==================================================                    |  71%
  |
  |============================================================          |  86%
  |
  |======================================================================| 100%
## Each rank, multiple NMF runs are performed
##
  |
  |                                                                      |   0%
  |
  |==========                                                            |  14%
  |
  |====================                                                  |  29%
  |
  |==============================                                        |  43%
  |
  |========================================                              |  57%
  |
  |==================================================                    |  71%
  |
  |============================================================          |  86%
  |
  |======================================================================| 100%
## Each rank estimation method
##
  |
  |                                                                      |   0%
  |
  |==========                                                            |  14%
  |
  |====================                                                  |  29%
  |
  |==============================                                        |  43%
  |
  |========================================                              |  57%
  |
  |==================================================                    |  71%
  |
  |============================================================          |  86%
  |
  |======================================================================| 100%
```

```
## $RSS
## $RSS$rss1
## [1] 124587604751  25929822763   2085959976    438461900    312129322
## [6]    277726907    183431820
##
## $RSS$rss2
## [1] 122493907374   6776993503   2568919182   3253818525   1438749444
## [6]    414514697   1111518908
##
##
## $selected
## [1] 3 2
```

```
rks$selected
```

```
## [1] 3 2
```

### 3.2.4 HTML Report: `cellCellReport`

If `cellCellDecomp` is properly finished, we can perform `cellCellReport` function to output the HTML report like below. Please type `example(cellCellReport)` and the report will be generated in the temporary directory (it costs 5 to 10 minutes). After `cellCellReport`, multiple R markdown files, compiled HTML files, figures, and R binary file containing the result of analysis are saved to `out.dir` (Figure 2). For more details, open the `index.html` by your web browser. Combined with cloud storage service such as Amazon Simple Storage Service (S3), it can be a simple web application and multiple people like collaborators can confirm the same report simultaneously.

![](data:image/png;base64...)

Figure2 : cellCellReport function of scTensor

# Session Information

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
##  [1] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            MatrixGenerics_1.22.0
##  [9] matrixStats_1.5.0           scTensor_2.20.0
## [11] RSQLite_2.4.3               LRBaseDbi_2.20.0
## [13] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [15] dbplyr_2.5.1                BiocGenerics_0.56.0
## [17] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] rTensor_1.4.9           splines_4.5.1           bitops_1.0-9
##   [4] ggplotify_0.1.3         filelock_1.0.3          fields_17.1
##   [7] tibble_3.3.0            R.oo_1.27.1             polyclip_1.10-7
##  [10] graph_1.88.0            XML_3.99-0.19           lifecycle_1.0.4
##  [13] httr2_1.2.1             tcltk_4.5.1             lattice_0.22-7
##  [16] MASS_7.3-65             backports_1.5.0         dendextend_1.19.1
##  [19] magrittr_2.0.4          plotly_4.11.0           sass_0.4.10
##  [22] rmarkdown_2.30          plot3D_1.4.2            jquerylib_0.1.4
##  [25] yaml_2.3.10             plotrix_3.8-4           ggtangle_0.0.7
##  [28] spam_2.11-1             cowplot_1.2.0           DBI_1.2.3
##  [31] RColorBrewer_1.1-3      maps_3.4.3              abind_1.4-8
##  [34] purrr_1.1.0             R.utils_2.13.0          ggraph_2.2.2
##  [37] RCurl_1.98-1.17         yulab.utils_0.2.1       tweenr_2.0.3
##  [40] rappdirs_0.3.3          misc3d_0.9-1            gdtools_0.4.4
##  [43] seriation_1.5.8         enrichplot_1.30.0       ggrepel_0.9.6
##  [46] AnnotationForge_1.52.0  tidytree_0.4.6          reactome.db_1.94.0
##  [49] genefilter_1.92.0       schex_1.24.0            ccTensor_1.0.3
##  [52] annotate_1.88.0         codetools_0.2-20        DelayedArray_0.36.0
##  [55] ggforce_0.5.0           DOSE_4.4.0              tidyselect_1.2.1
##  [58] GOstats_2.76.0          outliers_0.15           aplot_0.2.9
##  [61] farver_2.1.2            viridis_0.6.5           TSP_1.2-5
##  [64] webshot_0.5.5           jsonlite_2.0.0          tidygraph_1.3.1
##  [67] survival_3.8-3          iterators_1.0.14        systemfonts_1.3.1
##  [70] foreach_1.5.2           tools_4.5.1             treeio_1.34.0
##  [73] tagcloud_0.7.0          Rcpp_1.1.0              glue_1.8.0
##  [76] gridExtra_2.3           SparseArray_1.10.0      xfun_0.53
##  [79] qvalue_2.42.0           dplyr_1.1.4             ca_0.71.1
##  [82] withr_3.0.2             BiocManager_1.30.26     Category_2.76.0
##  [85] fastmap_1.2.0           entropy_1.3.2           digest_0.6.37
##  [88] R6_2.6.1                gridGraphics_0.5-1      GO.db_3.22.0
##  [91] dichromat_2.0-0.1       R.methodsS3_1.8.2       hexbin_1.28.5
##  [94] tidyr_1.3.1             fontLiberation_0.1.0    data.table_1.17.8
##  [97] meshr_2.16.0            graphlayouts_1.2.2      httr_1.4.7
## [100] htmlwidgets_1.6.4       S4Arrays_1.10.0         graphite_1.56.0
## [103] pkgconfig_2.0.3         gtable_0.3.6            blob_1.2.4
## [106] registry_0.5-1          S7_0.2.0                XVector_0.50.0
## [109] htmltools_0.5.8.1       fontBitstreamVera_0.1.1 dotCall64_1.2
## [112] bookdown_0.45           fgsea_1.36.0            RBGL_1.86.0
## [115] GSEABase_1.72.0         scales_1.4.0            png_0.1-8
## [118] ggfun_0.2.0             knitr_1.50              reshape2_1.4.4
## [121] visNetwork_2.1.4        checkmate_2.3.3         nlme_3.1-168
## [124] curl_7.0.0              cachem_1.1.0            stringr_1.5.2
## [127] BiocVersion_3.22.0      concaveman_1.2.0        parallel_4.5.1
## [130] AnnotationDbi_1.72.0    ReactomePA_1.54.0       pillar_1.11.1
## [133] grid_4.5.1              vctrs_0.6.5             cluster_2.1.8.1
## [136] xtable_1.8-4            Rgraphviz_2.54.0        evaluate_1.0.5
## [139] magick_2.9.0            tinytex_0.57            cli_3.6.5
## [142] compiler_4.5.1          rlang_1.1.6             crayon_1.5.3
## [145] MeSHDbi_1.46.0          heatmaply_1.6.0         fdrtool_1.2.18
## [148] plyr_1.8.9              fs_1.6.6                ggiraph_0.9.2
## [151] stringi_1.8.7           viridisLite_0.4.2       BiocParallel_1.44.0
## [154] assertthat_0.2.1        Biostrings_2.78.0       lazyeval_0.2.2
## [157] fontquiver_0.2.1        GOSemSim_2.36.0         Matrix_1.7-4
## [160] patchwork_1.3.2         nnTensor_1.3.0          bit64_4.6.0-1
## [163] ggplot2_4.0.0           KEGGREST_1.50.0         igraph_2.2.1
## [166] memoise_2.0.1           bslib_0.9.0             ggtree_4.0.0
## [169] fastmatch_1.1-6         bit_4.6.0               gson_0.1.0
## [172] ape_5.8-1
```