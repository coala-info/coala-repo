Code

* Show All Code
* Hide All Code

# *customCMPdb*: Integrating Community and Custom Compound Collections

Authors: Yuzhu Duan, Dan Evans, Kevin Horan, Austin Leong, Siddharth Sai and Thomas Girke

#### Last update: 29 October, 2025

# 1 Introduction

This package serves as a query interface for important community collections of
small molecules, while also allowing users to include custom compound
collections. Both annotation and structure information is provided. The
annotation data is stored in an SQLite database, while the structure
information is stored in Structure Definition Files (SDF). Both are hosted
on Bioconductor’s `AnnotationHub`. A detailed description of the included
data types is provided under the *Supplemental Material* section of this vignette.
At the time of writing, the following community databases are included:

* [DrugAge](https://genomics.senescence.info/drugs/) (Barardo et al. [2017](#ref-Barardo2017-xk))
* [DrugBank](https://www.drugbank.ca/) (Wishart et al. [2018](#ref-Wishart2018-ap))
* [CMAP02](https://portals.broadinstitute.org/cmap/) (Lamb et al. [2006](#ref-Lamb2006-du))
* [LINCS](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE92742) (Subramanian et al. [2017](#ref-Subramanian2017-fu))

In addition to providing access to the above compound collections, the package
supports the integration of custom collections of compounds, that will be
automatically stored for the user in the same data structure as the
preconfigured databases. Both custom collections and those provided by this
package can be queried in a uniform manner, and then further analyzed with
cheminformatics packages such as `ChemmineR`, where SDFs are imported into
flexible S4 containers (Cao et al. [2008](#ref-Cao2008-np)).

# 2 Installation and Loading

As Bioconductor package `customCMPdb` can be installed with the
`BiocManager::install()` function.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("customCMPdb")
```

To obtain the most recent updates of the package immediately, one can also install it
directly from GitHub as follows.

```
devtools::install_github("yduan004/customCMPdb", build_vignettes=TRUE)
```

Next the package needs to be loaded in a user’s R session.

```
library(customCMPdb)
library(help = "customCMPdb")  # Lists package info
```

Open vignette of this package.

```
browseVignettes("customCMPdb")  # Opens vignette
```

# 3 Overview

The following introduces how to load and query the different datasets.

## 3.1 DrugAge Annotations

The compound annotation tables are stored in an SQLite database. This data can be
loaded into a user’s R session as follows (here for `drugAgeAnnot`).

```
conn <- loadAnnot()
library(RSQLite)
dbListTables(conn)
```

```
## [1] "DrugBankAnnot" "cmapAnnot"     "drugAge4"      "drugAgeAnnot"
## [5] "id_mapping"    "lincs2"        "lincsAnnot"    "myCustom"
## [9] "myCustom2"
```

```
drugAgeAnnot <- dbReadTable(conn, "drugAgeAnnot")
head(drugAgeAnnot)
```

```
##   drugage_id                  compound_name    synonyms                 species
## 1   ida00001                        Vitexin        <NA>  Caenorhabditis elegans
## 2   ida00002                  Cyclosporin A        <NA>  Caenorhabditis elegans
## 3   ida00003                      Histidine L-histidine  Caenorhabditis elegans
## 4   ida00004                        SRT1720        <NA>            Mus musculus
## 5   ida00005 Cordyceps sinensis oral liquid        <NA> Drosophila melanogaster
## 6   ida00006                         Lysine        <NA>  Caenorhabditis elegans
##     strain                dosage avg_lifespan_change max_lifespan_change gender
## 1       N2                 50 µM                   8                 5.3   <NA>
## 2     <NA>                 88 µM                  18                <NA>   <NA>
## 3       N2                  5 mM                  10                <NA>   <NA>
## 4 C57BL/6J 100 mg/kg body weight                 8.8                   0   <NA>
## 5 Oregon-K            0.20 mg/ml                  32                15.4   Male
## 6       N2                  5 mM                   8                <NA>   <NA>
##   significance pubmed_id Comment pref_name     pubchem_cid      DrugBank_id
## 1         <NA>  26535084    <NA>   VITEXIN         5280441             <NA>
## 2         <NA>  24134630    <NA>      <NA>            <NA>          DB00091
## 3         <NA>  25643626    <NA> HISTIDINE   6274, 6971009          DB00117
## 4         <NA>  24582957    <NA>      <NA>            <NA>             <NA>
## 5         <NA>  26239097     Mix      <NA>            <NA>             <NA>
## 6         <NA>  25643626    <NA>    LYSINE 5962, 122198194 DB00123, DB11101
```

```
dbDisconnect(conn)
```

## 3.2 DrugAge SDF

The corresponding structures for the above DrugAge example can be loaded into an `SDFset`
object as follows.

```
da_sdfset <- loadSDFwithName(source="DrugAge")
```

Instructions on how to work with `SDFset` objects are provided in the `ChemmineR` vignette
[here](https://bioconductor.org/packages/ChemmineR/). For instance, one can plot any of
the loaded structures with the `plot` function.

```
ChemmineR::cid(da_sdfset) <- ChemmineR::sdfid(da_sdfset)
ChemmineR::plot(da_sdfset[1])
```

![](data:image/png;base64...)

## 3.3 DrugBank SDF

The SDF from DrugBank can be loaded into R the same way. The
corresponding SDF file was downloaded from
[here](https://www.drugbank.ca/releases/latest#structures). During the import
into R `ChemmineR` checks the validity of the imported compounds.

```
db_sdfset <- loadSDFwithName(source="DrugBank")
```

## 3.4 CMAP SDF

The import of the SDF of the CMAP02 database works the same way.

```
cmap_sdfset <- loadSDFwithName(source="CMAP2")
```

## 3.5 LINCS SDF

The same applies to the SDF of the small molecules included in the LINCS database.

```
lincs_sdfset <- loadSDFwithName(source="LINCS")
```

For reproducibility, the R code for generating the above datasets is included
in the `inst/scripts/make-data.R` file of this package. The file location
on a user’s system can be obtained with `system.file("scripts/make-data.R", package="customCMPdb")`.

# 4 Custom Annotation Database

## 4.1 Load Annotation Database

The SQLite Annotation Database is hosted on Bioconductor’s `AnnotationHub`.
Users can download it to a local `AnnotationHub` cache directory. The path to this
directory can be obtained as follows.

```
library(AnnotationHub)
ah <- AnnotationHub()
annot_path <- ah[["AH79563"]]
```

## 4.2 Add Custom Annotation Tables

The following introduces how users can import to the SQLite database
their own compound annotation tables. In this case, the corresponding
ChEMBL IDs need to be included under the `chembl_id` column.
The name of the custom data set can be specified under the `annot_name`
argument. Note, this name is case insensitive.

```
chembl_id <- c("CHEMBL1000309", "CHEMBL100014", "CHEMBL10",
               "CHEMBL100", "CHEMBL1000", NA)
annot_tb <- data.frame(cmp_name=paste0("name", 1:6),
        chembl_id=chembl_id,
        feature1=paste0("f", 1:6),
        feature2=rnorm(6))
addCustomAnnot(annot_tb, annot_name="myCustom")
```

```
## Warning in addCustomAnnot(annot_tb, annot_name = "myCustom"): The annot_name
## exists in the SQLite database, the old table is not overwritten, set
## 'overwrite=TRUE' to overwrite the existing one
```

## 4.3 Delete Custom Annotation Tables

The following shows how to delete custom annotation tables
by referencing them by their name. To obtain a list of custom
annotation tables present in the database, the `listAnnot` function
can be used.

```
listAnnot()
```

```
## [1] "DrugBankAnnot" "cmapAnnot"     "drugAge4"      "drugAgeAnnot"
## [5] "lincs2"        "lincsAnnot"    "myCustom"      "myCustom2"
```

```
deleteAnnot("myCustom")
listAnnot()
```

```
## [1] "DrugBankAnnot" "cmapAnnot"     "drugAge4"      "drugAgeAnnot"
## [5] "lincs2"        "lincsAnnot"    "myCustom2"
```

## 4.4 Set to Default

The `defaultAnnot` function sets the annotation SQLite database back to the
original version provided by `customCMPdb`. This is achieved by deleting the
existing (e.g. custom) database and re-downloading a fresh instance from
`AnnotationHub`.

```
defaultAnnot()
```

# 5 Query Annotation Database

The `queryAnnotDB` function can be used to query the compound annotations from
the default resources as well as the custom resources stored in the SQLite
annotation database. The query can be a set of ChEMBL IDs. In this case it
returns a `data.frame` containing the annotations of the matching compounds
from the selected annotation resources specified under the
argument. The `listAnnot` function returns the names that can be assigned to
the `annot` argument.

```
query_id <- c("CHEMBL1064", "CHEMBL10", "CHEMBL113", "CHEMBL1004", "CHEMBL31574")
listAnnot()
```

```
## [1] "DrugBankAnnot" "cmapAnnot"     "drugAge4"      "drugAgeAnnot"
## [5] "lincs2"        "lincsAnnot"    "myCustom2"
```

```
qres <- queryAnnotDB(query_id, annot=c("drugAgeAnnot", "lincsAnnot"))
qres
```

```
##     chembl_id                  species        strain     dosage
## 1    CHEMBL10  Drosophila melanogaster      Oregon R     300 µM
## 2  CHEMBL1004                     <NA>          <NA>       <NA>
## 3  CHEMBL1064  Drosophila melanogaster          <NA>     240 µM
## 4   CHEMBL113  Drosophila melanogaster      Oregon R 0.01 mg/ml
## 5 CHEMBL31574 Saccharomyces cerevisiae PSY316AT MAT_      10 µM
##   avg_lifespan_change max_lifespan_change gender significance      lincs_id
## 1                30.3                <NA>   <NA>         <NA> BRD-A37704979
## 2                <NA>                <NA>   <NA>         <NA> BRD-A44008656
## 3                  25                <NA>   <NA>         <NA> BRD-K22134346
## 4               -10.1                <NA>   Male           NS BRD-K02404261
## 5                  55                <NA>   <NA>         <NA>          <NA>
##    pert_iname is_touchstone                   inchi_key pubchem_cid
## 1   SB-203580             0 CDMGBJANTYXAIV-UHFFFAOYSA-N      176155
## 2  doxylamine             1 HCFDWZZGGLSKEP-UHFFFAOYSA-N        -666
## 3 simvastatin             0 RYMZZMVNJRMUDD-HGQWONQESA-N        -666
## 4    caffeine             1 RYYVLZVUVIJVGH-UHFFFAOYSA-N        -666
## 5        <NA>            NA                        <NA>        <NA>
```

```
# query the added custom annotation
addCustomAnnot(annot_tb, annot_name="myCustom")
qres2 <- queryAnnotDB(query_id, annot=c("lincsAnnot", "myCustom"))
qres2
```

```
##     chembl_id      lincs_id  pert_iname is_touchstone
## 1    CHEMBL10 BRD-A37704979   SB-203580             0
## 2  CHEMBL1004 BRD-A44008656  doxylamine             1
## 3  CHEMBL1064 BRD-K22134346 simvastatin             0
## 4   CHEMBL113 BRD-K02404261    caffeine             1
## 5 CHEMBL31574          <NA>        <NA>            NA
##                     inchi_key pubchem_cid cmp_name feature1  feature2
## 1 CDMGBJANTYXAIV-UHFFFAOYSA-N      176155    name3       f3 -1.695041
## 2 HCFDWZZGGLSKEP-UHFFFAOYSA-N        -666     <NA>     <NA>        NA
## 3 RYMZZMVNJRMUDD-HGQWONQESA-N        -666     <NA>     <NA>        NA
## 4 RYYVLZVUVIJVGH-UHFFFAOYSA-N        -666     <NA>     <NA>        NA
## 5                        <NA>        <NA>     <NA>     <NA>        NA
```

Since the supported compound databases use different identifiers, a ChEMBL
ID mapping table is used to connect identical entries across databases as
well as to link out to other resources such as ChEMBL itself or PubChem. For
custom compounds, where ChEMBL IDs are not available yet, one can use
alternative and/or custom identifiers.

```
query_id <- c("BRD-A00474148", "BRD-A00150179", "BRD-A00763758", "BRD-A00267231")
qres3 <- queryAnnotDB(chembl_id=query_id, annot=c("lincsAnnot"))
qres3
```

```
##         lincs_id          pert_iname is_touchstone                   inchi_key
## 2  BRD-A00150179 5-hydroxytryptophan             0 QSHLMQDRPXXYEE-UHFFFAOYSA-N
## 3  BRD-A00267231              hemado             1 KOCIMZNSNPOGOP-UHFFFAOYSA-N
## 5  BRD-A00474148       BRD-A00474148             0 RCGAUPRLRFZAMS-UHFFFAOYSA-N
## 10 BRD-A00763758       BRD-A00763758             0 MASIPYZIHWNUPA-UHFFFAOYSA-N
##    pubchem_cid
## 2       589768
## 3      4043357
## 5     44825297
## 10    43209100
```

# 6 Supplemental Material

## 6.1 Description of Annotation Tables in SQLite Database

The DrugAge database is manually curated by experts. It contains an extensive
compilation of drugs, compounds and supplements (including natural products and
nutraceuticals) with anti-aging properties that extend longevity in model
organisms (Barardo et al. [2017](#ref-Barardo2017-xk)). The DrugAge build2 database was downloaded from
[here](https://genomics.senescence.info/drugs/dataset.zip) as a CSV file. The
downloaded `drugage.csv` file contains `compound_name`, `synonyms`, `species`, `strain`,
`dosage`, `avg_lifespan_change`, `max_lifespan_change`, `gender`, `significance`,
and `pubmed_id` annotation columns. Since the DrugAge database only contains the
drug name as identifiers, it is necessary to map the drug name to other uniform
drug identifiers, such as ChEMBL IDs. In this package,
the drug names have been mapped to [ChEMBL](https://www.ebi.ac.uk/chembl/) (Gaulton et al. [2012](#ref-Gaulton2012-ji)),
[PubChem](https://pubchem.ncbi.nlm.nih.gov/) (Kim et al. [2019](#ref-Kim2019-tg)) and DrugBank IDs semi-manually
and stored under the `inst/extdata` directory named as `drugage_id_mapping.tsv`.
Part of the id mappings in the `drugage_id_mapping.tsv` table is generated
by the function for compound names that have ChEMBL
ids from the ChEMBL database (version 24). The missing IDs were added
manually. A semi-manual approach was to use this
[web service](https://cts.fiehnlab.ucdavis.edu/batch). After the semi-manual process,
the left ones were manually mapped to ChEMBL, PubChem and DrugBank ids. The
entries that are mixture like green tee extract or peptide like Bacitracin were commented.
Then the `drugage_id_mapping` table was built into the annotation SQLite database
named as `compoundCollection_0.1.db` with table name of `drugAgeAnnot` by `buildDrugAgeDB` function.

The DrugBank annotation table (`DrugBankAnnot`) was downloaded from the DrugBank database
in [xml file](https://www.drugbank.ca/releases/latest).
The most recent release version at the time of writing this document is 5.1.5.
The extracted xml file was processed by the function in this package.
`dbxml2df` and `df2SQLite` functions in this package were used to load the xml
file into R and covert to a data.frame R object, then stored in the
`compoundCollection` SQLite annotation database.
There are 55 annotation columns in the DrugBank annotation table, such as
`drugbank_id`, `name`, `description`, `cas-number`, `groups`, `indication`,
`pharmacodynamics`, `mechanism-of-action`, `toxicity`, `metabolism`, `half-life`,
`protein-binding`, `classification`, `synonyms`, `international-brands`, `packagers`,
`manufacturers`, `prices`, `dosages`, `atc-codes`, `fda-label`, `pathways`, `targets`.
The DrugBank id to ChEMBL id mappings were obtained from
UniChem.

The CMAP02 annotation table (`cmapAnnot`) was processed from the downloaded compound
[instance table](http://www.broadinstitute.org/cmap/cmap_instances_02.xls)
using the `buildCMAPdb` function defined by this package. The CMAP02 instance table contains
the following drug annotation columns: `instance_id`, `batch_id`, `cmap_name`, `INN1`,
`concentration (M)`, `duration (h)`, `cell2`, `array3`, `perturbation_scan_id`,
`vehicle_scan_id4`, `scanner`, `vehicle`, `vendor`, `catalog_number`, `catalog_name`.
Drug names are used as drug identifies. The `buildCMAPdb` function maps the drug
names to external drug ids including `UniProt` (The UniProt Consortium [2017](#ref-The_UniProt_Consortium2017-bx)),
`PubChem`, `DrugBank` and `ChemBank` (Seiler et al. [2008](#ref-Seiler2008-dw)) ids. It also adds additional
annotation columns such as `directionality`, `ATC codes` and `SMILES structure`.
The generated `cmap.db` SQLite database from `buildCMAPdb` function contains both
compound annotation table and structure information. The ChEMBL id mappings were
further added to the annotation table via PubChem CID to ChEMBL id mappings from
UniChem.
The CMAP02 annotation table was stored in the `compoundCollection` SQLite annotation
database. Then the CMAP internal IDs to ChEMBL id mappings were added to the ID
mapping table.

The LINCS 2017 compound annotation table (`lincsAnnot`) was downloaded from
GEO
where only compounds were selected. The annotation columns are `lincs_id`, `pert_name`,
`pert_type`, `is_touchstone`, `inchi_key_prefix`, `inchi_key`, `canonical_smiles`, `pubchem_cid`.
The annotation table was stored in the `compoundCollection` SQLite annotation database.
Since the annotation only contains LINCS id to PubChem CID mapping, the LINCS ids
were also mapped to ChEMBL ids via inchi key.

The SQLite annotation database also contains compound annotation tables of
`drugAge4` and `lincs2`. They contain annotations for compounds
in DrugAge build 4 database, and the newest LINCS beta database released in 2020
at [CLUE](https://clue.io/releases/data-dashboard).

# 7 Session Info

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
## [1] AnnotationHub_4.0.0 BiocFileCache_3.0.0 dbplyr_2.5.1
## [4] BiocGenerics_0.56.0 generics_0.1.4      RSQLite_2.4.3
## [7] ChemmineR_3.62.0    customCMPdb_1.20.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      gtable_0.3.6         rjson_0.2.23
##  [4] xfun_0.53            bslib_0.9.0          ggplot2_4.0.0
##  [7] httr2_1.2.1          htmlwidgets_1.6.4    Biobase_2.70.0
## [10] vctrs_0.6.5          tools_4.5.1          bitops_1.0-9
## [13] stats4_4.5.1         curl_7.0.0           tibble_3.3.0
## [16] AnnotationDbi_1.72.0 blob_1.2.4           pkgconfig_2.0.3
## [19] RColorBrewer_1.1-3   S7_0.2.0             S4Vectors_0.48.0
## [22] lifecycle_1.0.4      compiler_4.5.1       farver_2.1.2
## [25] Biostrings_2.78.0    tinytex_0.57         Seqinfo_1.0.0
## [28] htmltools_0.5.8.1    sass_0.4.10          RCurl_1.98-1.17
## [31] yaml_2.3.10          pillar_1.11.1        crayon_1.5.3
## [34] jquerylib_0.1.4      DT_0.34.0            cachem_1.1.0
## [37] magick_2.9.0         tidyselect_1.2.1     digest_0.6.37
## [40] purrr_1.1.0          dplyr_1.1.4          bookdown_0.45
## [43] BiocVersion_3.22.0   rsvg_2.7.0           fastmap_1.2.0
## [46] grid_4.5.1           cli_3.6.5            magrittr_2.0.4
## [49] base64enc_0.1-3      XML_3.99-0.19        dichromat_2.0-0.1
## [52] withr_3.0.2          filelock_1.0.3       scales_1.4.0
## [55] rappdirs_0.3.3       bit64_4.6.0-1        rmarkdown_2.30
## [58] XVector_0.50.0       httr_1.4.7           bit_4.6.0
## [61] gridExtra_2.3        png_0.1-8            memoise_2.0.1
## [64] evaluate_1.0.5       knitr_1.50           IRanges_2.44.0
## [67] rlang_1.1.6          Rcpp_1.1.0           glue_1.8.0
## [70] DBI_1.2.3            BiocManager_1.30.26  jsonlite_2.0.0
## [73] R6_2.6.1
```

# References

Barardo, Diogo, Daniel Thornton, Harikrishnan Thoppil, Michael Walsh, Samim Sharifi, Susana Ferreira, Andreja Anžič, et al. 2017. “The DrugAge Database of Aging-Related Drugs.” *Aging Cell* 16 (3): 594–97. <http://onlinelibrary.wiley.com/doi/10.1111/acel.12585/full>.

Cao, Yiqun, Anna Charisi, Li-Chang Cheng, Tao Jiang, and Thomas Girke. 2008. “ChemmineR: A Compound Mining Framework for R.” *Bioinformatics* 24 (15): 1733–4. <http://dx.doi.org/10.1093/bioinformatics/btn307>.

Gaulton, Anna, Louisa J Bellis, A Patricia Bento, Jon Chambers, Mark Davies, Anne Hersey, Yvonne Light, et al. 2012. “ChEMBL: A Large-Scale Bioactivity Database for Drug Discovery.” *Nucleic Acids Res.* 40 (Database issue): D1100–7. <http://dx.doi.org/10.1093/nar/gkr777>.

Kim, Sunghwan, Jie Chen, Tiejun Cheng, Asta Gindulyte, Jia He, Siqian He, Qingliang Li, et al. 2019. “PubChem 2019 Update: Improved Access to Chemical Data.” *Nucleic Acids Res.* 47 (D1): D1102–D1109. <http://dx.doi.org/10.1093/nar/gky1033>.

Lamb, Justin, Emily D Crawford, David Peck, Joshua W Modell, Irene C Blat, Matthew J Wrobel, Jim Lerner, et al. 2006. “The Connectivity Map: Using Gene-Expression Signatures to Connect Small Molecules, Genes, and Disease.” *Science* 313 (5795): 1929–35. <http://dx.doi.org/10.1126/science.1132939>.

Seiler, Kathleen Petri, Gregory A George, Mary Pat Happ, Nicole E Bodycombe, Hyman A Carrinski, Stephanie Norton, Steve Brudz, et al. 2008. “ChemBank: A Small-Molecule Screening and Cheminformatics Resource Database.” *Nucleic Acids Res.* 36 (Database issue): D351–9. <http://dx.doi.org/10.1093/nar/gkm843>.

Subramanian, Aravind, Rajiv Narayan, Steven M Corsello, David D Peck, Ted E Natoli, Xiaodong Lu, Joshua Gould, et al. 2017. “A Next Generation Connectivity Map: L1000 Platform and the First 1,000,000 Profiles.” *Cell* 171 (6): 1437–1452.e17. <http://dx.doi.org/10.1016/j.cell.2017.10.049>.

The UniProt Consortium. 2017. “UniProt: The Universal Protein Knowledgebase.” *Nucleic Acids Res.* 45 (D1): D158–D169. <http://dx.doi.org/10.1093/nar/gkw1099>.

Wishart, David S, Yannick D Feunang, An C Guo, Elvis J Lo, Ana Marcu, Jason R Grant, Tanvir Sajed, et al. 2018. “DrugBank 5.0: A Major Update to the DrugBank Database for 2018.” *Nucleic Acids Res.* 46 (D1): D1074–D1082. <http://dx.doi.org/10.1093/nar/gkx1037>.