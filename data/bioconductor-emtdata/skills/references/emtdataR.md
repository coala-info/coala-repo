# emtdata

### Malvika D. Kharbanda

### 6 November 2025

* [1 emtdata](#emtdata)
* [2 Download data from the emtdata R package](#download-data-from-the-emtdata-r-package)
* [3 Accessing SummarizedExperiment object](#accessing-summarizedexperiment-object)
* [4 Exploratory analysis and visualization](#exploratory-analysis-and-visualization)
  + [4.1 cursons2018](#cursons2018)
  + [4.2 cursons2015](#cursons2015)
  + [4.3 foroutan2017](#foroutan2017)
* [5 Session information](#session-information)

# 1 emtdata

The emtdata package is an ExperimentHub package for three data sets with an Epithelial to Mesenchymal Transition (EMT). This package provides pre-processed RNA-seq data where the epithelial to mesenchymal transition was induced on cell lines. These data come from three publications [Cursons et al. (2015)](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA322427), [Cursons etl al. (2018)](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJEB25042) and [Foroutan et al. (2017)](https://doi.org/10.4225/49/5a2a11fa43fe3). In each of these publications, EMT was induces across multiple cell lines following treatment by TGFb among other stimulants. This data will be useful in determining the regulatory programs modified in order to achieve an EMT. Data were processed by the Davis laboratory in the Bioinformatics division at WEHI.

This package can be installed using the code below:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("emtdata")
#> Bioconductor version 3.22 (BiocManager 1.30.26), R 4.5.1 Patched (2025-08-23
#>   r88802)
#> Warning: package(s) not installed when version(s) same as or greater than current; use
#>   `force = TRUE` to re-install: 'emtdata'
#> Old packages: 'ggtangle', 'pkgdown', 'progressr'
```

# 2 Download data from the emtdata R package

Data in this package can be downloaded using the `ExperimentHub` interface as shown below. To download the data, we first need to get a list of the data available in the `emtdata` package and determine the unique identifiers for each data. The `query()` function assists in getting this list.

```
library(emtdata)
library(ExperimentHub)
library(SummarizedExperiment)
```

```
eh = ExperimentHub()
query(eh , 'emtdata')
#> ExperimentHub with 3 records
#> # snapshotDate(): 2025-10-29
#> # $dataprovider: Walter and Eliza Hall Institute of Medical Research, Queens...
#> # $species: Homo sapiens
#> # $rdataclass: GSEABase::SummarizedExperiment
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["EH5439"]]'
#>
#>            title
#>   EH5439 | foroutan2017_se
#>   EH5440 | cursons2018_se
#>   EH5441 | cursons2015_se
```

Data can then be downloaded using the unique identifier.

```
eh[['EH5440']]
#> see ?emtdata and browseVignettes('emtdata') for documentation
#> loading from cache
#> class: SummarizedExperiment
#> dim: 27515 10
#> metadata(0):
#> assays(2): counts logRPKM
#> rownames(27515): ENSG00000223972 ENSG00000227232 ... ENSG00000276345
#>   ENSG00000271254
#> rowData names(7): Chr Start ... gene_name gene_biotype
#> colnames(10): HMLE_polyAplus_rep1 HMLE_polyAplus_rep2 ...
#>   mesHMLE_miR200c_polyAplus_rep1 mesHMLE_miR200c_polyAplus_rep2
#> colData names(14): group lib.size ... Organism SRA.Study
```

Alternatively, data can be downloaded using object name accessors in the `emtdata` package as below:

```
#metadata are displayed
cursons2018_se(metadata = TRUE)
#> ExperimentHub with 1 record
#> # snapshotDate(): 2025-10-29
#> # names(): EH5440
#> # package(): emtdata
#> # $dataprovider: Queensland University of Technology
#> # $species: Homo sapiens
#> # $rdataclass: GSEABase::SummarizedExperiment
#> # $rdatadateadded: 2021-03-30
#> # $title: cursons2018_se
#> # $description: Gene expression data from Cursons et al., Cell Syst 2018. Th...
#> # $taxonomyid: 9606
#> # $genome: NA
#> # $sourcetype: TXT
#> # $sourceurl: https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJEB25042
#> # $sourcesize: NA
#> # $tags: c("HMLE", "Homo_sapiens_Data")
#> # retrieve record with 'object[["EH5440"]]'
#data are loaded
cursons2018_se()
#> see ?emtdata and browseVignettes('emtdata') for documentation
#> loading from cache
#> class: SummarizedExperiment
#> dim: 27515 10
#> metadata(0):
#> assays(2): counts logRPKM
#> rownames(27515): ENSG00000223972 ENSG00000227232 ... ENSG00000276345
#>   ENSG00000271254
#> rowData names(7): Chr Start ... gene_name gene_biotype
#> colnames(10): HMLE_polyAplus_rep1 HMLE_polyAplus_rep2 ...
#>   mesHMLE_miR200c_polyAplus_rep1 mesHMLE_miR200c_polyAplus_rep2
#> colData names(14): group lib.size ... Organism SRA.Study
```

# 3 Accessing SummarizedExperiment object

```
cursons2018_se = eh[['EH5440']]
#> see ?emtdata and browseVignettes('emtdata') for documentation
#> loading from cache

#read counts
assay(cursons2018_se)[1:5, 1:5]
#>                 HMLE_polyAplus_rep1 HMLE_polyAplus_rep2 HMLE_polyAplus_rep3
#> ENSG00000223972                  13                   6                  16
#> ENSG00000227232                 449                 282                 567
#> ENSG00000278267                  14                   5                   2
#> ENSG00000240361                   7                   0                   0
#> ENSG00000186092                  19                   0                   0
#>                 mesHMLE_polyAplus_rep1 mesHMLE_polyAplus_rep2
#> ENSG00000223972                      1                     24
#> ENSG00000227232                    243                    239
#> ENSG00000278267                      8                     13
#> ENSG00000240361                     17                     21
#> ENSG00000186092                      0                     16

#genes
rowData(cursons2018_se)
#> DataFrame with 27515 rows and 7 columns
#>                                    Chr                  Start
#>                            <character>            <character>
#> ENSG00000223972      1;1;1;1;1;1;1;1;1 11869;12010;12179;12..
#> ENSG00000227232  1;1;1;1;1;1;1;1;1;1;1 14404;15005;15796;16..
#> ENSG00000278267                      1                  17369
#> ENSG00000240361                1;1;1;1 57598;58700;62916;62..
#> ENSG00000186092                1;1;1;1 65419;65520;69037;69..
#> ...                                ...                    ...
#> ENSG00000278384             GL000218.1                  51867
#> ENSG00000278633             KI270731.1                  10598
#> ENSG00000278066  KI270731.1;KI270731.1            26533;26671
#> ENSG00000276345 KI270721.1;KI270721... 2585;6094;7322;7977;..
#> ENSG00000271254 KI270711.1;KI270711... 4612;6101;6101;6102;..
#>                                    End                 Strand    Length
#>                            <character>            <character> <integer>
#> ENSG00000223972 12227;12057;12227;12..      +;+;+;+;+;+;+;+;+      1735
#> ENSG00000227232 14501;15038;15947;16..  -;-;-;-;-;-;-;-;-;-;-      1351
#> ENSG00000278267                  17436                      -        68
#> ENSG00000240361 57653;58856;64116;63..                +;+;+;+      1414
#> ENSG00000186092 65433;65573;71585;70..                +;+;+;+      2618
#> ...                                ...                    ...       ...
#> ENSG00000278384                  54893                      -      3027
#> ENSG00000278633                  13001                      -      2404
#> ENSG00000278066            26667;27138                    -;-       603
#> ENSG00000276345 2692;6216;7404;8050;..              +;+;+;+;+       740
#> ENSG00000271254 6370;6370;6370;6370;.. -;-;-;-;-;-;-;-;-;-;..      4520
#>                   gene_name           gene_biotype
#>                 <character>            <character>
#> ENSG00000223972     DDX11L1 transcribed_unproces..
#> ENSG00000227232      WASH7P unprocessed_pseudogene
#> ENSG00000278267   MIR6859-1                  miRNA
#> ENSG00000240361     OR4G11P transcribed_unproces..
#> ENSG00000186092       OR4F5         protein_coding
#> ...                     ...                    ...
#> ENSG00000278384  AL354822.1         protein_coding
#> ENSG00000278633  AC023491.2         protein_coding
#> ENSG00000278066  AC023491.1             pseudogene
#> ENSG00000276345  AC004556.3         protein_coding
#> ENSG00000271254  AC240274.1         protein_coding

#sample information
colData(cursons2018_se)
#> DataFrame with 10 rows and 14 columns
#>                                   group  lib.size norm.factors         Run
#>                                <factor> <numeric>    <numeric> <character>
#> HMLE_polyAplus_rep1                   1  92190427     0.992509  ERR2306893
#> HMLE_polyAplus_rep2                   1  52695983     0.875815  ERR2306894
#> HMLE_polyAplus_rep3                   1 103842038     0.697357  ERR2306895
#> mesHMLE_polyAplus_rep1                1  72789081     1.125205  ERR2306896
#> mesHMLE_polyAplus_rep2                1  59117276     1.176159  ERR2306897
#> mesHMLE_polyAplus_rep3                1  60576244     0.958298  ERR2306898
#> mesHMLE_QKI5kd_polyAplus_rep1         1  63260143     1.074816  ERR2306899
#> mesHMLE_QKI5kd_polyAplus_rep2         1  54287166     1.024172  ERR2306900
#> mesHMLE_miR200c_polyAplus_rep1        1  46864487     1.115876  ERR2306901
#> mesHMLE_miR200c_polyAplus_rep2        1  47131679     1.058954  ERR2306902
#>                                           Sample.Name     Subline   Treatment
#>                                           <character> <character> <character>
#> HMLE_polyAplus_rep1               HMLE_polyAplus_rep1        HMLE     Control
#> HMLE_polyAplus_rep2               HMLE_polyAplus_rep2        HMLE     Control
#> HMLE_polyAplus_rep3               HMLE_polyAplus_rep3        HMLE     Control
#> mesHMLE_polyAplus_rep1         mesHMLE_polyAplus_rep1     mesHMLE     Control
#> mesHMLE_polyAplus_rep2         mesHMLE_polyAplus_rep2     mesHMLE     Control
#> mesHMLE_polyAplus_rep3         mesHMLE_polyAplus_rep3     mesHMLE     Control
#> mesHMLE_QKI5kd_polyAplus_rep1  mesHMLE_QKI5kd_polyA..     mesHMLE      QKI5kd
#> mesHMLE_QKI5kd_polyAplus_rep2  mesHMLE_QKI5kd_polyA..     mesHMLE      QKI5kd
#> mesHMLE_miR200c_polyAplus_rep1 mesHMLE_miR200c_poly..     mesHMLE     miR200c
#> mesHMLE_miR200c_polyAplus_rep2 mesHMLE_miR200c_poly..     mesHMLE     miR200c
#>                                 BioProject      BioSample
#>                                <character>    <character>
#> HMLE_polyAplus_rep1             PRJEB25042 SAMEA104599608
#> HMLE_polyAplus_rep2             PRJEB25042 SAMEA104599609
#> HMLE_polyAplus_rep3             PRJEB25042 SAMEA104599610
#> mesHMLE_polyAplus_rep1          PRJEB25042 SAMEA104599611
#> mesHMLE_polyAplus_rep2          PRJEB25042 SAMEA104599612
#> mesHMLE_polyAplus_rep3          PRJEB25042 SAMEA104599613
#> mesHMLE_QKI5kd_polyAplus_rep1   PRJEB25042 SAMEA104599614
#> mesHMLE_QKI5kd_polyAplus_rep2   PRJEB25042 SAMEA104599615
#> mesHMLE_miR200c_polyAplus_rep1  PRJEB25042 SAMEA104599616
#> mesHMLE_miR200c_polyAplus_rep2  PRJEB25042 SAMEA104599617
#>                                           Center.Name  Experiment   Cell.Line
#>                                           <character> <character> <character>
#> HMLE_polyAplus_rep1            CENTRE FOR CANCER BI..  ERX2358203        HMLE
#> HMLE_polyAplus_rep2            CENTRE FOR CANCER BI..  ERX2358204        HMLE
#> HMLE_polyAplus_rep3            CENTRE FOR CANCER BI..  ERX2358205        HMLE
#> mesHMLE_polyAplus_rep1         CENTRE FOR CANCER BI..  ERX2358206        HMLE
#> mesHMLE_polyAplus_rep2         CENTRE FOR CANCER BI..  ERX2358207        HMLE
#> mesHMLE_polyAplus_rep3         CENTRE FOR CANCER BI..  ERX2358208        HMLE
#> mesHMLE_QKI5kd_polyAplus_rep1  CENTRE FOR CANCER BI..  ERX2358209        HMLE
#> mesHMLE_QKI5kd_polyAplus_rep2  CENTRE FOR CANCER BI..  ERX2358210        HMLE
#> mesHMLE_miR200c_polyAplus_rep1 CENTRE FOR CANCER BI..  ERX2358211        HMLE
#> mesHMLE_miR200c_polyAplus_rep2 CENTRE FOR CANCER BI..  ERX2358212        HMLE
#>                                    Organism   SRA.Study
#>                                 <character> <character>
#> HMLE_polyAplus_rep1            Homo sapiens   ERP106922
#> HMLE_polyAplus_rep2            Homo sapiens   ERP106922
#> HMLE_polyAplus_rep3            Homo sapiens   ERP106922
#> mesHMLE_polyAplus_rep1         Homo sapiens   ERP106922
#> mesHMLE_polyAplus_rep2         Homo sapiens   ERP106922
#> mesHMLE_polyAplus_rep3         Homo sapiens   ERP106922
#> mesHMLE_QKI5kd_polyAplus_rep1  Homo sapiens   ERP106922
#> mesHMLE_QKI5kd_polyAplus_rep2  Homo sapiens   ERP106922
#> mesHMLE_miR200c_polyAplus_rep1 Homo sapiens   ERP106922
#> mesHMLE_miR200c_polyAplus_rep2 Homo sapiens   ERP106922
```

# 4 Exploratory analysis and visualization

Below we demonstrate how the SummarizedExperiment object can be interacted with. A simple MDS analyis is demonstrated for each of the datasets within this package. This transcriptomic data can be used for differential expression (DE) analyis and co-expression analysis to better understand the processes underlying EMT or MET.

## 4.1 cursons2018

This gene expression data comes from the human mammary epithelial (HMLE) cell line. A mesenchymal HMLE (mesHMLE) phenotype was induced following treatment with TGFb. The mesHMLE subline was then treated with mir200c to reinduce an epithelial phenotype.

See help page `?cursons2018_se` for further reference

```
library(edgeR)
#> Loading required package: limma
#>
#> Attaching package: 'limma'
#> The following object is masked from 'package:BiocGenerics':
#>
#>     plotMA
library(RColorBrewer)
cursons2018_dge <- asDGEList(cursons2018_se)
cursons2018_dge <- calcNormFactors(cursons2018_dge)
plotMDS(cursons2018_dge)
```

![](data:image/png;base64...)

## 4.2 cursons2015

This gene expression data comes from the PMC42-ET, PMC42-LA and MDA-MB-468 cell lines. Mesenchymal phenotype was induced in PMC42 cell lines with EGF treatment and in MDA-MB-468 with either EGF treatment or kept under Hypoxia.

See help page `?cursons2015_se` for further reference.

```
cursons2015_se = eh[['EH5441']]
#> see ?emtdata and browseVignettes('emtdata') for documentation
#> loading from cache
cursons2015_dge <- asDGEList(cursons2015_se)
cursons2015_dge <- calcNormFactors(cursons2015_dge)
colours <- brewer.pal(7, name = "Paired")
plotMDS(cursons2015_dge, dim.plot = c(2,3), col=rep(colours, each = 3))
```

![](data:image/png;base64...)

## 4.3 foroutan2017

This gene expression data comes from multiple different studies (microarary and RNA-seq), with cell lines treated using TGFb to induce a mesenchymal shift. Data were combined using SVA and ComBat to remove batch effects.

See help page `?foroutan2017_se` for further reference

```
foroutan2017_se = eh[['EH5439']]
#> see ?emtdata and browseVignettes('emtdata') for documentation
#> loading from cache
foroutan2017_dge <- asDGEList(foroutan2017_se, assay_name = "logExpr")
foroutan2017_dge <- calcNormFactors(foroutan2017_dge)
tgfb_col <- as.numeric(foroutan2017_dge$samples$Treatment %in% 'TGFb') + 1
plotMDS(foroutan2017_dge, labels = foroutan2017_dge$samples$Treatment, col = tgfb_col)
```

![](data:image/png;base64...)

# 5 Session information

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] RColorBrewer_1.1-3          edgeR_4.8.0
#>  [3] limma_3.66.0                SummarizedExperiment_1.40.0
#>  [5] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0               IRanges_2.44.0
#>  [9] S4Vectors_0.48.0            MatrixGenerics_1.22.0
#> [11] matrixStats_1.5.0           ExperimentHub_3.0.0
#> [13] AnnotationHub_4.0.0         BiocFileCache_3.0.0
#> [15] dbplyr_2.5.1                BiocGenerics_0.56.0
#> [17] generics_0.1.4              emtdata_1.18.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0      xfun_0.54            bslib_0.9.0
#>  [4] httr2_1.2.1          lattice_0.22-7       vctrs_0.6.5
#>  [7] tools_4.5.1          curl_7.0.0           tibble_3.3.0
#> [10] AnnotationDbi_1.72.0 RSQLite_2.4.3        blob_1.2.4
#> [13] pkgconfig_2.0.3      Matrix_1.7-4         lifecycle_1.0.4
#> [16] compiler_4.5.1       Biostrings_2.78.0    prettydoc_0.4.1
#> [19] statmod_1.5.1        BiocStyle_2.38.0     htmltools_0.5.8.1
#> [22] sass_0.4.10          yaml_2.3.10          pillar_1.11.1
#> [25] crayon_1.5.3         jquerylib_0.1.4      DelayedArray_0.36.0
#> [28] cachem_1.1.0         abind_1.4-8          locfit_1.5-9.12
#> [31] tidyselect_1.2.1     digest_0.6.37        purrr_1.2.0
#> [34] dplyr_1.1.4          BiocVersion_3.22.0   grid_4.5.1
#> [37] fastmap_1.2.0        SparseArray_1.10.1   cli_3.6.5
#> [40] magrittr_2.0.4       S4Arrays_1.10.0      withr_3.0.2
#> [43] filelock_1.0.3       rappdirs_0.3.3       bit64_4.6.0-1
#> [46] rmarkdown_2.30       XVector_0.50.0       httr_1.4.7
#> [49] bit_4.6.0            png_0.1-8            memoise_2.0.1
#> [52] evaluate_1.0.5       knitr_1.50           rlang_1.1.6
#> [55] glue_1.8.0           DBI_1.2.3            BiocManager_1.30.26
#> [58] jsonlite_2.0.0       R6_2.6.1
```