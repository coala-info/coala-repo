Code

* Show All Code
* Hide All Code

# The multiMiR user’s guide

Yuanbin Ru1\*, Matt Mulvahill2\*\*, Spencer Mahaffey2 and Katerina Kechris2

1BioMarin Pharmaceutical Inc.
2CU Anschutz

\*ruyuanbin@gmail.com
\*\*matthew.mulvahill@ucdenver.edu

#### 30 October 2025

#### Package

multiMiR 1.32.0

# 1 Introduction

microRNAs (miRNAs) regulate expression by promoting degradation or repressing
translation of target transcripts. miRNA target sites have been cataloged in
databases based on experimental validation and computational prediction using a
variety of algorithms. Several online resources provide collections of multiple
databases but need to be imported into other software, such as R, for
processing, tabulation, graphing and computation. Currently available miRNA
target site packages in R are limited in the number of databases, types of
databases and flexibility.

The R package *multiMiR*, with web server at
<http://multimir.org>, is a comprehensive
collection of predicted and validated miRNA-target interactions and their
associations with diseases and drugs. *multiMiR* includes several novel features
not available in existing R packages:

1. Compilation of 14 different databases, more than any other collection
2. Expansion of databases to those based on disease annotation and drug
   response, in addition to many experimental and computational databases
3. User-defined cutoffs for predicted binding strength to provide the most
   confident selection.

The *multiMiR* package enables retrieval of miRNA-target interactions from 14
external databases in R without the need to visit all these databases.
Advanced users can also submit SQL queries to the web server to retrieve
results. See the [publication on
PubMed](https://www.ncbi.nlm.nih.gov/pubmed/25063298) for additional detail on
the database and its creation. The database is now versioned so it is possible
to use previous versions of databases from the current R package, however the
package defaults to the most recent version.

*Warning* There are issues with merging target IDs from older unmaintained databases. Databases that have been updated more recently (1-2 years) use current versions of annotated IDs. In each update these old target IDs are carried over due to a lack of a reliable method to disambiguate the original ID with current IDs. Please keep this in mind with results from older databases that have not been updated. We continue to look at methods to resolve these ambiguities and improve target agreement between databases. You can use the unique() R function to identify and then remove multiple target genes if needed.

# 2 Getting to know the multiMiR database

The *multiMiR* web server
<http://multimir.org> hosts a database
containing miRNA-target interactions from external databases. The package
*multiMiR* provides functions to communicate with the *multiMiR* web server and
its database. The *multiMiR* database is now versioned. By default *multiMiR*
will use the most recent version each time *multiMiR* is loaded. However it is
now possible to switch between database versions and get information about the
*multiMiR* database versions. `multimir_dbInfoVersions()` returns a dataframe with
the available versions.

```
library(multiMiR)
```

```
## Welcome to multiMiR.
##
## multiMiR database URL has been set to the
## default value: http://multimir.org/
##
## Database Version: 2.4.0  Updated: 2024-08-28
```

```
db.ver = multimir_dbInfoVersions()
db.ver
```

```
##   VERSION    UPDATED                      RDA      DBNAME                 SCHEMA PUBLIC
## 1   2.4.0 2024-08-28 multimir_cutoffs_2.4.rda multimir2_4 multiMiR_DB_schema.sql      1
## 2   2.3.0 2020-04-15 multimir_cutoffs_2.3.rda multimir2_3 multiMiR_DB_schema.sql      1
## 3   2.2.0 2017-08-08 multimir_cutoffs_2.2.rda multimir2_2 multiMiR_DB_schema.sql      1
## 4   2.1.0 2016-12-22 multimir_cutoffs_2.1.rda multimir2_1 multiMiR_DB_schema.sql      1
## 5   2.0.0 2015-05-01     multimir_cutoffs.rda    multimir multiMiR_DB_schema.sql      1
##                  TABLES
## 1 multiMiR_dbTables.txt
## 2 multiMiR_dbTables.txt
## 3 multiMiR_dbTables.txt
## 4 multiMiR_dbTables.txt
## 5 multiMiR_dbTables.txt
```

To switch between versions we can use `multimir_switchDBVersion()`.

```
vers_table <- multimir_dbInfoVersions()
vers_table
```

```
##   VERSION    UPDATED                      RDA      DBNAME                 SCHEMA PUBLIC
## 1   2.4.0 2024-08-28 multimir_cutoffs_2.4.rda multimir2_4 multiMiR_DB_schema.sql      1
## 2   2.3.0 2020-04-15 multimir_cutoffs_2.3.rda multimir2_3 multiMiR_DB_schema.sql      1
## 3   2.2.0 2017-08-08 multimir_cutoffs_2.2.rda multimir2_2 multiMiR_DB_schema.sql      1
## 4   2.1.0 2016-12-22 multimir_cutoffs_2.1.rda multimir2_1 multiMiR_DB_schema.sql      1
## 5   2.0.0 2015-05-01     multimir_cutoffs.rda    multimir multiMiR_DB_schema.sql      1
##                  TABLES
## 1 multiMiR_dbTables.txt
## 2 multiMiR_dbTables.txt
## 3 multiMiR_dbTables.txt
## 4 multiMiR_dbTables.txt
## 5 multiMiR_dbTables.txt
```

```
multimir_switchDBVersion(db_version = "2.0.0")
```

```
## Now using database version: 2.0.0
```

```
curr_vers  <- vers_table[1, "VERSION"]  # current version
multimir_switchDBVersion(db_version = curr_vers)
```

```
## Now using database version: 2.4.0
```

The remaining functions will query the selected version until the package is reloaded
or until we switch to another version.

Information from each external database is stored in a table in the *multiMiR* database.
To see a list of the tables, we can use the `multimir_dbTables()` function.

```
db.tables = multimir_dbTables()
db.tables
```

```
##  [1] "diana_microt" "elmmo"        "map_counts"   "map_metadata" "microcosm"    "mir2disease"
##  [7] "miranda"      "mirdb"        "mirecords"    "mirna"        "mirtarbase"   "pharmaco_mir"
## [13] "phenomir"     "pictar"       "pita"         "tarbase"      "target"       "targetscan"
```

To display the database schema, we can use the `multimir_dbSchema()`
function. Following is only a portion of the full output.

```
## --
## -- Table structure for table `mirna`
## --
##
## DROP TABLE IF EXISTS `mirna`;
## CREATE TABLE `mirna` (
##   mature_mirna_uid INTEGER UNSIGNED AUTO_INCREMENT,  -- mature miRNA unique ID
##   org VARCHAR(4) NOT NULL,                           -- organism abbreviation
##   mature_mirna_acc VARCHAR(20) default NULL,         -- mature miRNA accession
##   mature_mirna_id VARCHAR(20) default NULL,          -- mature miRNA ID/name
##   PRIMARY KEY (mature_mirna_uid),
##   KEY org (org),
##   KEY mature_mirna_acc (mature_mirna_acc),
##   KEY mature_mirna_id (mature_mirna_id)
## );
##
## --
## -- Table structure for table `target`
## --
##
## DROP TABLE IF EXISTS `target`;
## CREATE TABLE `target` (
##   target_uid INTEGER UNSIGNED AUTO_INCREMENT,   -- target gene unique ID
##   org VARCHAR(4) NOT NULL,                      -- organism abbreviation
##   target_symbol VARCHAR(80) default NULL,       -- target gene symbol
##   target_entrez VARCHAR(10) default NULL,       -- target gene Entrez gene ID
##   target_ensembl VARCHAR(20) default NULL,      -- target gene Ensembl gene ID
##   PRIMARY KEY (target_uid),
##   KEY org (org),
##   KEY target_symbol (target_symbol),
##   KEY target_entrez (target_entrez),
##   KEY target_ensembl (target_ensembl)
## );
##
## --
## -- Table structure for table `mirecords`
## --
##
## DROP TABLE IF EXISTS `mirecords`;
## CREATE TABLE `mirecords` (
##   mature_mirna_uid INTEGER UNSIGNED NOT NULL,   -- mature miRNA unique ID
##   target_uid INTEGER UNSIGNED NOT NULL,         -- target gene unique ID
##   target_site_number INT(10) default NULL,      -- target site number
##   target_site_position INT(10) default NULL,    -- target site position
##   experiment VARCHAR(160) default NULL,         -- supporting experiment
##   support_type VARCHAR(40) default NULL,        -- type of supporting experiment
##   pubmed_id VARCHAR(10) default NULL,           -- PubMed ID
##   FOREIGN KEY (mature_mirna_uid)
##     REFERENCES mirna(mature_mirna_uid)
##     ON UPDATE CASCADE ON DELETE RESTRICT,
##   FOREIGN KEY (target_uid)
##     REFERENCES target(target_uid)
##     ON UPDATE CASCADE ON DELETE RESTRICT
## );
##
## ......
##
## (Please note that only three of the 19 tables are shown here for demonstration
## purpose.)
```

The function `multimir_dbInfo()` will display information about the external
miRNA and miRNA-target databases in *multiMiR*, including version, release date,
link to download the data, and the corresponding table in *multiMiR*.

```
db.info = multimir_dbInfo()
db.info
```

```
##        map_name                  source_name source_version  source_date
## 1  diana_microt                 DIANA-microT              5   Sept, 2013
## 2         elmmo                        EIMMo              5    Jan, 2011
## 3     microcosm                    MicroCosm              5   Sept, 2009
## 4   mir2disease                  miR2Disease                Mar 14, 2011
## 5       miranda                      miRanda                   Aug, 2010
## 6         mirdb                        miRDB              6   June, 2019
## 7     mirecords                    miRecords              4 Apr 27, 2013
## 8    mirtarbase                   miRTarBase              9    Sept 2021
## 9  pharmaco_mir Pharmaco-miR (Verified Sets)
## 10     phenomir                     PhenomiR              2 Feb 15, 2011
## 11       pictar                       PicTar              2 Dec 21, 2012
## 12         pita                         PITA              6 Aug 31, 2008
## 13      tarbase                      TarBase              9         2023
## 14   targetscan                   TargetScan              8    Sept 2021
##                                                                        source_url
## 1  http://diana.imis.athena-innovation.gr/DianaTools/index.php?r=microT_CDS/index
## 2                         http://www.mirz.unibas.ch/miRNAtargetPredictionBulk.php
## 3       http://www.ebi.ac.uk/enright-srv/microcosm/cgi-bin/targets/v5/download.pl
## 4                                                      http://www.mir2disease.org
## 5                                http://www.microrna.org/microrna/getDownloads.do
## 6                                                                http://mirdb.org
## 7                                       http://mirecords.biolead.org/download.php
## 8                              http://mirtarbase.mbc.nctu.edu.tw/php/download.php
## 9                              http://www.pharmaco-mir.org/home/download_VERSE_db
## 10                                    http://mips.helmholtz-muenchen.de/phenomir/
## 11                                                    http://dorina.mdc-berlin.de
## 12                         http://genie.weizmann.ac.il/pubs/mir07/mir07_data.html
## 13                                         https://dianalab.e-ce.uth.gr/tarbasev9
## 14         https://www.targetscan.org/cgi-bin/targetscan/data_download.vert80.cgi
```

Among the 14 external databases, eight contain predicted miRNA-target
interactions (DIANA-microT-CDS, ElMMo, MicroCosm, miRanda, miRDB, PicTar, PITA,
and TargetScan), three have experimentally validated miRNA-target interactions
(miRecords, miRTarBase, and TarBase) and the remaining three contain
miRNA-drug/disease associations (miR2Disease, Pharmaco-miR, and PhenomiR). To
check these categories and databases from within R, we have a set of four
helper functions:

```
predicted_tables()
```

```
## [1] "diana_microt" "elmmo"        "microcosm"    "miranda"      "mirdb"        "pictar"
## [7] "pita"         "targetscan"
```

```
validated_tables()
```

```
## [1] "mirecords"  "mirtarbase" "tarbase"
```

```
diseasedrug_tables()
```

```
## [1] "mir2disease"  "pharmaco_mir" "phenomir"
```

```
reverse_table_lookup("targetscan")
```

```
## [1] "predicted"
```

To see how many records are in these 14 external databases we refer to the
`multimir_dbCount` function.

```
db.count = multimir_dbCount()
db.count
```

```
##        map_name human_count mouse_count rat_count total_count
## 1  diana_microt     7664602     3747171         0    11411773
## 2         elmmo     3959112     1449133    547191     5955436
## 3     microcosm      762987      534735    353378     1651100
## 4   mir2disease        2875           0         0        2875
## 5       miranda     5429955     2379881    247368     8057204
## 6         mirdb     1990425     1091263    199250     3280938
## 7     mirecords        2425         449       171        3045
## 8    mirtarbase      957034      116689      1384     1075107
## 9  pharmaco_mir         308           5         0         313
## 10     phenomir       15138         491         0       15629
## 11       pictar      404066      302236         0      706302
## 12         pita     7710936     5163153         0    12874089
## 13      tarbase     1290272      473266      1031     1764713
## 14   targetscan    13964425    10387912         0    24352337
```

```
apply(db.count[,-1], 2, sum)
```

```
## human_count mouse_count   rat_count total_count
##    44154560    25646384     1349773    71150861
```

The current version of *multiMiR* contains nearly 50 million records.

# 3 Changes to `package:multiMiR` - S3 and S4 classes

With the addition of multiMiR to Bioconductor, the return object has changed
from an S3 (`mmquery`) to an S4 class (`mmquery_bioc`). The new S4 object has a
similar structure to the prior version, except all returned datasets (validated,
predicted, disease.drug) are now combined into a single dataset. To get only
one type, filter on the `type` variable using the AnnotationDbi method discussed
later or the base R approach `subset(myqry@data, myqry@data$type == "validated")`).
For backwards compatibility, `get_multimir()` will return the old S3 object if
the argument `legacy.out = TRUE`.

Features are now accessible using the S4 accessor operator `@`. Additionally,
the `AnnotationDbi` accessor methods `column`, `keys`, `keytypes`, and `select`
all work for `mmquery_bioc` objects. See Section [7.6](#annodbi).

# 4 List miRNAs, genes, drugs and diseases in the multiMiR database

In addition to functions displaying database and table information, the
*multiMiR* package also provides the `list_multimir()` function to list all the
unique miRNAs, target genes, drugs, and diseases in the *multiMiR* database. An
option for limiting the number of returned records has been added to help with
testing and exploration.

```
miRNAs   = list_multimir("mirna", limit = 10)
genes    = list_multimir("gene", limit = 10)
drugs    = list_multimir("drug", limit = 10)
diseases = list_multimir("disease", limit = 10)
# executes 2 separate queries, giving 20 results
head(miRNAs)
```

```
##   mature_mirna_uid org mature_mirna_acc mature_mirna_id
## 1             8532
## 2              936 hsa
## 3             1284 hsa                        hsa-let-7
## 4              202 hsa                     hsa-let-71f1
## 5              815 hsa                     hsa-let-7a-1
## 6              817 hsa                     hsa-let-7a-3
```

```
head(genes)
```

```
##   target_uid org target_symbol target_entrez  target_ensembl
## 1     127721
## 2     127722 hsa
## 3      60954 hsa                             ENSG00000011177
## 4      60956 hsa                             ENSG00000032514
## 5      60957 hsa                             ENSG00000051415
## 6      60958 hsa                             ENSG00000083622
```

```
head(drugs)
```

```
##                    drug
## 1 3,3'-diindolylmethane
## 2          5-fluoroucil
## 3               abt-737
## 4          alitretinoin
## 5       arabinocytosine
## 6      arsenic trioxide
```

```
head(diseases)
```

```
##                                                    disease
## 1 ACTH-INDEPENDENT MACRONODULAR ADRENAL HYPERPLASIA; AIMAH
## 2                       ACUTE LYMPHOBLASTIC LEUKEMIA (ALL)
## 3                        ACUTE MYELOGENEOUS LEUKEMIA (AML)
## 4                             ACUTE MYELOID LEUKEMIA (AML)
## 5                       ACUTE PROMYELOCYTIC LEUKEMIA (APL)
## 6                                                  ADENOMA
```

The current version of *multiMiR* has 5830 miRNAs and 97186 target genes from
human, mouse, and rat, as well as 64 drugs and 223 disease terms. Depending on
the speed of your Internet connection, it may take a few minutes to retrieve the
large number of target genes.

# 5 Use `get_multimir()` to query the multiMiR database

`get_multimir()` is the main function in the package to retrieve predicted and
validated miRNA-target interactions and their disease and drug associations from
the *multiMiR* database.

To get familiar with the parameters in `get_multimir()`, you can type
`?get_multimir` or `help(get_multimir)` in R. In the next section, many examples
illustrate the use of the parameters.

# 6 Example of multiMiR in a Bioconductor workflow

This example shows the use of `multiMiR` alongside the `edgeR` Bioconductor
package. Here we take microRNA data from ISS and ILS mouse strains and conduct
a differential expression analysis. The top differentially expresssed
microRNA’s are then used to search the multiMiR database for validated
target genes.

```
library(edgeR)
```

```
## Loading required package: limma
```

```
library(multiMiR)

# Load data
counts_file  <- system.file("extdata", "counts_table.Rds", package = "multiMiR")
strains_file <- system.file("extdata", "strains_factor.Rds", package = "multiMiR")
counts_table   <- readRDS(counts_file)
strains_factor <- readRDS(strains_file)

# Standard edgeR differential expression analysis
design <- model.matrix(~ strains_factor)

# Using trended dispersions
dge <- DGEList(counts = counts_table)
dge <- calcNormFactors(dge)
dge$samples$strains <- strains_factor
dge <- estimateGLMCommonDisp(dge, design)
dge <- estimateGLMTrendedDisp(dge, design)
dge <- estimateGLMTagwiseDisp(dge, design)

# Fit GLM model for strain effect
fit <- glmFit(dge, design)
lrt <- glmLRT(fit)

# Table of unadjusted p-values (PValue) and FDR values
p_val_DE_edgeR <- topTags(lrt, adjust.method = 'BH', n = Inf)

# Getting top differentially expressed miRNA's
top_miRNAs <- rownames(p_val_DE_edgeR$table)[1:10]

# Plug miRNA's into multiMiR and getting validated targets
multimir_results <- get_multimir(org     = 'mmu',
                                 mirna   = top_miRNAs,
                                 table   = 'validated',
                                 summary = TRUE)
```

```
## Searching mirecords ...
## Searching mirtarbase ...
## Searching tarbase ...
```

```
head(multimir_results@data)
```

```
##    database mature_mirna_acc mature_mirna_id target_symbol target_entrez     target_ensembl
## 1 mirecords     MIMAT0000233 mmu-miR-200b-3p          Zeb2         24136 ENSMUSG00000026872
## 2 mirecords     MIMAT0000233 mmu-miR-200b-3p          Flt1         14254 ENSMUSG00000029648
## 3 mirecords     MIMAT0000153  mmu-miR-141-3p          Dlx5         13395 ENSMUSG00000029755
## 4 mirecords     MIMAT0000519 mmu-miR-200a-3p          Dlx5         13395 ENSMUSG00000029755
## 5 mirecords     MIMAT0000541   mmu-miR-96-5p          Aqp5         11830 ENSMUSG00000044217
## 6 mirecords     MIMAT0000541   mmu-miR-96-5p        Celsr2         53883 ENSMUSG00000068740
##                                experiment support_type pubmed_id      type
## 1                            Western blot               17585049 validated
## 2                                                       21115742 validated
## 3 Western blot//Luciferase activity assay               19454767 validated
## 4 Western blot//Luciferase activity assay               19454767 validated
## 5                                                       19363478 validated
## 6                                                       19363478 validated
```

# 7 Examples of multiMiR queries

In this section a variety of examples are described on how to query the multiMiR
database.

## 7.1 Example 1: Retrieve all validated target genes of a given miRNA

In the first example, we ask what genes are validated targets of hsa-miR-18a-3p.

```
# The default is to search validated interactions in human
example1 <- get_multimir(mirna = 'hsa-miR-18a-3p', summary = TRUE)
```

```
## Searching mirecords ...
## Searching mirtarbase ...
## Searching tarbase ...
```

```
names(example1)
```

```
## NULL
```

```
# Check which types of associations were returned
table(example1@data$type)
```

```
##
## validated
##      1699
```

```
# Detailed information of the validated miRNA-target interaction
head(example1@data)
```

```
##     database mature_mirna_acc mature_mirna_id target_symbol target_entrez  target_ensembl
## 1  mirecords     MIMAT0002891  hsa-miR-18a-3p          KRAS          3845 ENSG00000133703
## 2 mirtarbase     MIMAT0002891  hsa-miR-18a-3p          KRAS          3845 ENSG00000133703
## 3 mirtarbase     MIMAT0002891  hsa-miR-18a-3p          KRAS          3845 ENSG00000133703
## 4 mirtarbase     MIMAT0002891  hsa-miR-18a-3p         G3BP1         10146 ENSG00000145907
## 5 mirtarbase     MIMAT0002891  hsa-miR-18a-3p         G3BP1         10146 ENSG00000145907
## 6 mirtarbase     MIMAT0002891  hsa-miR-18a-3p        DHCR24          1718 ENSG00000116133
##                                                experiment          support_type pubmed_id      type
## 1                 Western blot//Luciferase activity assay                        19372139 validated
## 2 Luciferase reporter assay//qRT-PCR//Western blot//Other                        19372139 validated
## 3        Luciferase reporter assay//qRT-PCR//Western blot        Functional MTI  19372139 validated
## 4                                                   CLASH                        23622248 validated
## 5                                                   CLASH Functional MTI (Weak)  23622248 validated
## 6                                                   CLASH                        23622248 validated
```

```
# Which interactions are supported by Luciferase assay?
example1@data[grep("Luciferase", example1@data[, "experiment"]), ]
```

```
##       database mature_mirna_acc mature_mirna_id target_symbol target_entrez  target_ensembl
## 1    mirecords     MIMAT0002891  hsa-miR-18a-3p          KRAS          3845 ENSG00000133703
## 2   mirtarbase     MIMAT0002891  hsa-miR-18a-3p          KRAS          3845 ENSG00000133703
## 3   mirtarbase     MIMAT0002891  hsa-miR-18a-3p          KRAS          3845 ENSG00000133703
## 35  mirtarbase     MIMAT0002891  hsa-miR-18a-3p          CBX7         23492 ENSG00000100307
## 36  mirtarbase     MIMAT0002891  hsa-miR-18a-3p          CBX7         23492 ENSG00000100307
## 48  mirtarbase     MIMAT0002891  hsa-miR-18a-3p          MMP3          4314 ENSG00000149968
## 57  mirtarbase     MIMAT0002891  hsa-miR-18a-3p           ATM           472 ENSG00000149311
## 569 mirtarbase     MIMAT0002891  hsa-miR-18a-3p         SPRY3         10251 ENSG00000168939
##                                                                                  experiment
## 1                                                   Western blot//Luciferase activity assay
## 2                                   Luciferase reporter assay//qRT-PCR//Western blot//Other
## 3                                          Luciferase reporter assay//qRT-PCR//Western blot
## 35                                                  Luciferase reporter assay//Western blot
## 36                                                  Luciferase reporter assay//Western blot
## 48                                     Luciferase reporter assay//qRT-PCR//Western blotting
## 57                     Immunofluorescence//Luciferase reporter assay//qRT-PCR//Western blot
## 569 Luciferase reporter assay//Western blotting//Immunohistochemistry (IHC)//qRT-PCR//ELISA
##       support_type pubmed_id      type
## 1                   19372139 validated
## 2                   19372139 validated
## 3   Functional MTI  19372139 validated
## 35                  28123848 validated
## 36  Functional MTI  28123848 validated
## 48                  33392094 validated
## 57  Functional MTI  25963391 validated
## 569                 32927364 validated
```

```
example1@summary[example1@summary[,"target_symbol"] == "KRAS",]
```

```
## # A tibble: 1 × 10
##   mature_mirna_acc mature_mirna_id target_symbol target_entrez target_ensembl  mirecords mirtarbase
##   <chr>            <chr>           <chr>         <chr>         <chr>               <dbl>      <dbl>
## 1 MIMAT0002891     hsa-miR-18a-3p  KRAS          3845          ENSG00000133703         1          2
## # ℹ 3 more variables: tarbase <dbl>, validated.sum <dbl>, all.sum <dbl>
```

It turns out that *KRAS* is the only target validated by Luciferase assay. The
interaction was recorded in miRecords and miRTarBase and supported by the same
literature, whose PubMed ID is in column `pubmed_id`. The summary (by setting
`summary = TRUE` when calling `get_multimir()`) shows the number of records in
each of the external databases and the total number of databases supporting the
interaction.

## 7.2 Example 2: Retrieve miRNA-target interactions associated with a given drug or disease

In this example we would like to know which miRNAs and their target genes are
associated with Cisplatin, a chemotherapy drug used in several cancers.

```
example2 <- get_multimir(disease.drug = 'cisplatin', table = 'disease.drug')
```

```
## Searching mir2disease ...
## Searching pharmaco_mir ...
## Searching phenomir ...
```

```
names(example2)
```

```
## NULL
```

```
nrow(example2@data)
```

```
## [1] 45
```

```
table(example2@data$type)
```

```
##
## disease.drug
##           45
```

```
head(example2@data)
```

```
##       database mature_mirna_acc mature_mirna_id target_symbol target_entrez  target_ensembl
## 1 pharmaco_mir     MIMAT0000772  hsa-miR-345-5p         ABCC1          4363 ENSG00000103222
## 2 pharmaco_mir     MIMAT0000720 hsa-miR-376c-3p          ALK7
## 3 pharmaco_mir     MIMAT0000423 hsa-miR-125b-5p          BAK1           578 ENSG00000030110
## 4 pharmaco_mir                       hsa-miR-34          BCL2           596 ENSG00000171791
## 5 pharmaco_mir     MIMAT0000318 hsa-miR-200b-3p          BCL2           596 ENSG00000171791
## 6 pharmaco_mir     MIMAT0000617 hsa-miR-200c-3p          BCL2           596 ENSG00000171791
##   disease_drug paper_pubmedID         type
## 1    cisplatin       20099276 disease.drug
## 2    cisplatin       21224400 disease.drug
## 3    cisplatin       21823019 disease.drug
## 4    cisplatin       18803879 disease.drug
## 5    cisplatin       21993663 disease.drug
## 6    cisplatin       21993663 disease.drug
```

`get_multimir()` returns 53 miRNA-target pairs. For more information, we can
always refer to the published papers with PubMed IDs in column `paper_pubmedID`.

## 7.3 Example 3: Select miRNAs predicted to target a gene

`get_multimir()` also takes target gene(s) as input. In this example we retrieve
miRNAs predicted to target *Gnb1* in mouse. For predicted interactions, the
default is to query the top 20% predictions within each external database,
which is equivalent to setting parameters `predicted.cutoff = 20` and
`predicted.cutoff.type = 'p'` (for percentage cutoff). Here we search the top
35% among all conserved and nonconserved target sites.

```
example3 <- get_multimir(org     = "mmu",
                         target  = "Gnb1",
                         table   = "predicted",
                         summary = TRUE,
                         predicted.cutoff      = 35,
                         predicted.cutoff.type = "p",
                         predicted.site        = "all")
```

```
## Searching diana_microt ...
## Searching elmmo ...
## Searching microcosm ...
## Searching miranda ...
## Searching mirdb ...
## Searching pictar ...
## Searching pita ...
## Searching targetscan ...
```

```
names(example3)
```

```
## NULL
```

```
table(example3@data$type)
```

```
##
## predicted
##       715
```

```
head(example3@data)
```

```
##       database mature_mirna_acc   mature_mirna_id target_symbol target_entrez     target_ensembl
## 1 diana_microt     MIMAT0000663    mmu-miR-218-5p          Gnb1         14688 ENSMUSG00000029064
## 2 diana_microt     MIMAT0017276    mmu-miR-493-5p          Gnb1         14688 ENSMUSG00000029064
## 3 diana_microt     MIMAT0000656    mmu-miR-139-5p          Gnb1         14688 ENSMUSG00000029064
## 4 diana_microt     MIMAT0014946 mmu-miR-3074-2-3p          Gnb1         14688 ENSMUSG00000029064
## 5 diana_microt     MIMAT0000144    mmu-miR-132-3p          Gnb1         14688 ENSMUSG00000029064
## 6 diana_microt     MIMAT0020608      mmu-miR-5101          Gnb1         14688 ENSMUSG00000029064
##   score      type
## 1 0.975 predicted
## 2 0.964 predicted
## 3  0.96 predicted
## 4 0.921 predicted
## 5  0.92 predicted
## 6 0.918 predicted
```

```
head(example3@summary)
```

```
## # A tibble: 6 × 15
##   mature_mirna_acc mature_mirna_id target_symbol target_entrez target_ensembl     diana_microt elmmo
##   <chr>            <chr>           <chr>         <chr>         <chr>                     <dbl> <dbl>
## 1 MIMAT0000133     mmu-miR-101a-3p Gnb1          14688         ENSMUSG00000029064            1     2
## 2 MIMAT0000616     mmu-miR-101b-3p Gnb1          14688         ENSMUSG00000029064            1     2
## 3 MIMAT0000663     mmu-miR-218-5p  Gnb1          14688         ENSMUSG00000029064            1     4
## 4 MIMAT0003476     mmu-miR-669b-5p Gnb1          14688         ENSMUSG00000029064            1     0
## 5 MIMAT0017276     mmu-miR-493-5p  Gnb1          14688         ENSMUSG00000029064            1     4
## 6 MIMAT0000144     mmu-miR-132-3p  Gnb1          14688         ENSMUSG00000029064            1     2
## # ℹ 8 more variables: microcosm <dbl>, miranda <dbl>, mirdb <dbl>, pictar <dbl>, pita <dbl>,
## #   targetscan <dbl>, predicted.sum <dbl>, all.sum <dbl>
```

The records in `example3@predicted` are ordered by scores from best to
worst within each external database. Once again, the summary option allows us to
examine the number of target sites predicted by each external database and the
total number of databases predicting the interaction.

Finally we examine how many predictions each of the databases has.

```
apply(example3@summary[, 6:13], 2, function(x) sum(x > 0))
```

```
## diana_microt        elmmo    microcosm      miranda        mirdb       pictar         pita
##          105           51            5           43           37            9          132
##   targetscan
##          176
```

## 7.4 Example 4: Select miRNA(s) predicted to target most, if not all, of the genes of interest

You may have a list of genes involved in a common biological process. It is
interesting to check whether some, or all, of these genes are targeted by the
same miRNA(s). Here we have four genes involved in chronic obstructive pulmonary
disease (COPD) in human and want to know what miRNAs target these genes by
searching the top 500,000 predictions in each external database.

```
example4 <- get_multimir(org     = 'hsa',
                         target  = c('AKT2', 'CERS6', 'S1PR3', 'SULF2'),
                         table   = 'predicted',
                         summary = TRUE,
                         predicted.cutoff.type = 'n',
                         predicted.cutoff      = 500000)
```

```
## Number predicted cutoff (predicted.cutoff) 500000 is larger than the total number of records in table pictar. All records will be queried.
```

```
## Number predicted cutoff (predicted.cutoff) 500000 is larger than the total number of records in table targetscan. All records will be queried.
```

```
## Searching diana_microt ...
## Searching elmmo ...
## Searching microcosm ...
## Searching miranda ...
## Searching mirdb ...
## Searching pictar ...
## Searching pita ...
## Searching targetscan ...
```

Then we count the number of target genes for each miRNA.

```
example4.counts <- addmargins(table(example4@summary[, 2:3]))
example4.counts <- example4.counts[-nrow(example4.counts), ]
example4.counts <- example4.counts[order(example4.counts[, 5], decreasing = TRUE), ]
head(example4.counts)
```

```
##                  target_symbol
## mature_mirna_id   AKT2 CERS6 S1PR3 SULF2 Sum
##   hsa-miR-129-5p     0     1     2     1   4
##   hsa-miR-144-3p     0     1     2     0   3
##   hsa-miR-3180-5p    0     1     2     0   3
##   hsa-miR-325-3p     1     1     0     1   3
##   hsa-miR-330-3p     0     1     1     1   3
##   hsa-miR-34a-5p     0     1     2     0   3
```

## 7.5 Example 5: Retrieve interactions between a set of miRNAs and a set of genes

In this example, we profiled miRNA and mRNA expression in poorly metastatic
bladder cancer cell lines T24 and Luc, and their metastatic derivatives FL4 and
Lul2, respectively. We identified differentially expressed miRNAs and genes
between the metastatic and poorly metastatic cells. Let’s load the data.

```
load(url("http://multimir.org/bladder.rda"))
```

Variable `DE.miRNA.up` contains 9 up-regulated miRNAs and variable
`DE.entrez.dn` has 47 down-regulated genes in the two metastatic cell
lines. The hypothesis is that interactions between these miRNAs and genes whose
expression changed at opposite directions may play a role in cancer metastasis.
So we use `multiMiR` to check whether any of the nine miRNAs could
target any of the 47 genes.

```
# search all tables & top 10% predictions
example5 <- get_multimir(org     = "hsa",
                         mirna   = DE.miRNA.up,
                         target  = DE.entrez.dn,
                         table   = "all",
                         summary = TRUE,
                         predicted.cutoff.type = "p",
                         predicted.cutoff      = 10,
                         use.tibble = TRUE)
```

```
## Searching mirecords ...
## Searching mirtarbase ...
## Searching tarbase ...
## Searching diana_microt ...
## Searching elmmo ...
## Searching microcosm ...
## Searching miranda ...
## Searching mirdb ...
## Searching pictar ...
## Searching pita ...
## Searching targetscan ...
## Searching mir2disease ...
## Searching pharmaco_mir ...
## Searching phenomir ...
```

```
## Warning in matrix(info[, !is.na(p.m)], ncol = sum(!is.na(p.m))): data length [1463] is not a
## sub-multiple or multiple of the number of rows [244]
```

```
## Warning in cbind(info, predicted.sum = p.sum): number of rows of result is not a multiple of vector
## length (arg 2)
```

```
## Joining with `by = join_by(database, mature_mirna_acc, mature_mirna_id, target_symbol,
## target_entrez, target_ensembl, type)`
## Joining with `by = join_by(database, mature_mirna_acc, mature_mirna_id, target_symbol,
## target_entrez, target_ensembl, type)`
```

```
table(example5@data$type)
```

```
##
## disease.drug    predicted    validated
##          442          160          198
```

```
result <- select(example5, keytype = "type", keys = "validated", columns = columns(example5))
unique_pairs <-
    result[!duplicated(result[, c("mature_mirna_id", "target_entrez")]), ]

result
```

```
## # A tibble: 198 × 13
##    database   mature_mirna_acc mature_mirna_id target_symbol target_entrez target_ensembl experiment
##    <chr>      <chr>            <chr>           <chr>         <chr>         <chr>          <chr>
##  1 mirtarbase MIMAT0000418     hsa-miR-23b-3p  RRAS2         22800         ENSG000001338… Luciferas…
##  2 mirtarbase MIMAT0000418     hsa-miR-23b-3p  RRAS2         22800         ENSG000001338… Luciferas…
##  3 mirtarbase MIMAT0000418     hsa-miR-23b-3p  SWAP70        23075         ENSG000001337… PAR-CLIP
##  4 mirtarbase MIMAT0000418     hsa-miR-23b-3p  SWAP70        23075         ENSG000001337… PAR-CLIP
##  5 mirtarbase MIMAT0000087     hsa-miR-30a-5p  PEG10         23089         ENSG000002422… PAR-CLIP
##  6 mirtarbase MIMAT0000087     hsa-miR-30a-5p  PEG10         23089         ENSG000002422… PAR-CLIP
##  7 mirtarbase MIMAT0000087     hsa-miR-30a-5p  LIMCH1        22998         ENSG000000640… pSILAC//P…
##  8 mirtarbase MIMAT0000087     hsa-miR-30a-5p  LIMCH1        22998         ENSG000000640… pSILAC//P…
##  9 mirtarbase MIMAT0000087     hsa-miR-30a-5p  FDX1          2230          ENSG000001377… Proteomics
## 10 mirtarbase MIMAT0000087     hsa-miR-30a-5p  FDX1          2230          ENSG000001377… Proteomics
## # ℹ 188 more rows
## # ℹ 6 more variables: support_type <chr>, pubmed_id <chr>, type <chr>, score <chr>,
## #   disease_drug <chr>, paper_pubmedID <chr>
```

In the result, there are 184 unique miRNA-gene pairs that have been validated.

```
mykeytype <- "disease_drug"

mykeys <- keys(example5, keytype = mykeytype)
mykeys <- mykeys[grep("bladder", mykeys, ignore.case = TRUE)]

result <- select(example5, keytype = "disease_drug", keys = mykeys,
                 columns = columns(example5))
result
```

```
## # A tibble: 3 × 13
##   database    mature_mirna_acc mature_mirna_id target_symbol target_entrez target_ensembl experiment
##   <chr>       <chr>            <chr>           <chr>         <chr>         <chr>          <chr>
## 1 mir2disease MIMAT0000418     hsa-miR-23b-3p  NA            NA            NA             <NA>
## 2 phenomir    MIMAT0000418     hsa-miR-23b-3p  NA            NA            NA             <NA>
## 3 phenomir    MIMAT0000449     hsa-miR-146a-5p NA            NA            NA             <NA>
## # ℹ 6 more variables: support_type <chr>, pubmed_id <chr>, type <chr>, score <chr>,
## #   disease_drug <chr>, paper_pubmedID <chr>
```

2 miRNAs are associated with bladder cancer in miR2Disease and PhenomiR.

The predicted databases predict 65 miRNA-gene pairs between the 9 miRNAs and 28
of the 47 genes.

```
predicted <- select(example5, keytype = "type", keys = "predicted",
                    columns = columns(example5))
length(unique(predicted$mature_mirna_id))
```

```
## [1] 8
```

```
length(unique(predicted$target_entrez))
```

```
## [1] 26
```

```
unique.pairs <-
    unique(data.frame(miRNA.ID = as.character(predicted$mature_mirna_id),
                      target.Entrez = as.character(predicted$target_entrez)))
nrow(unique.pairs)
```

```
## [1] 58
```

```
head(unique.pairs)
```

```
##          miRNA.ID target.Entrez
## 1  hsa-miR-182-5p          1112
## 3  hsa-miR-182-5p          2017
## 5  hsa-miR-30a-5p         22998
## 7  hsa-miR-30b-5p         22998
## 9  hsa-miR-30d-5p         22998
## 11 hsa-miR-182-5p          5962
```

Results from each of the predicted databases are already ordered by their scores
from best to worst.

```
example5.split <- split(predicted, predicted$database)
```

## 7.6 Use of AnnotationDbi accessor methods

AnnotationDbi accessor methods can be used to select and filter the data
returned by `get_multimir()`.

```
# On example4's result
columns(example4)
```

```
## [1] "database"         "mature_mirna_acc" "mature_mirna_id"  "score"            "target_ensembl"
## [6] "target_entrez"    "target_symbol"    "type"
```

```
head(keys(example4))
```

```
## [1] "hsa-miR-4795-3p" "hsa-miR-126-5p"  "hsa-miR-545-3p"  "hsa-miR-3944-5p" "hsa-miR-5688"
## [6] "hsa-miR-137-3p"
```

```
keytypes(example4)
```

```
## [1] "database"         "mature_mirna_acc" "mature_mirna_id"  "score"            "target_ensembl"
## [6] "target_entrez"    "target_symbol"    "type"
```

```
mykeys <- keys(example4)[1:4]
head(select(example4, keys = mykeys,
            columns = c("database", "target_entrez")))
```

```
##         database mature_mirna_id target_entrez
## 1   diana_microt hsa-miR-4795-3p          1903
## 2   diana_microt  hsa-miR-126-5p          1903
## 3   diana_microt  hsa-miR-545-3p        253782
## 4   diana_microt hsa-miR-3944-5p         55959
## 63  diana_microt hsa-miR-4795-3p        253782
## 344        mirdb hsa-miR-4795-3p          1903
```

```
# On example3's result
columns(example3)
```

```
## [1] "database"         "mature_mirna_acc" "mature_mirna_id"  "score"            "target_ensembl"
## [6] "target_entrez"    "target_symbol"    "type"
```

```
head(keys(example3))
```

```
## [1] "mmu-miR-218-5p"    "mmu-miR-493-5p"    "mmu-miR-139-5p"    "mmu-miR-3074-2-3p"
## [5] "mmu-miR-132-3p"    "mmu-miR-5101"
```

```
keytypes(example3)
```

```
## [1] "database"         "mature_mirna_acc" "mature_mirna_id"  "score"            "target_ensembl"
## [6] "target_entrez"    "target_symbol"    "type"
```

```
mykeys <- keys(example3)[1:4]
head(select(example3, keys = mykeys,
            columns = c("database", "target_entrez", "score")))
```

```
##         database   mature_mirna_id target_entrez score
## 1   diana_microt    mmu-miR-218-5p         14688 0.975
## 2   diana_microt    mmu-miR-493-5p         14688 0.964
## 3   diana_microt    mmu-miR-139-5p         14688  0.96
## 4   diana_microt mmu-miR-3074-2-3p         14688 0.921
## 106        elmmo    mmu-miR-218-5p         14688 0.849
## 107        elmmo    mmu-miR-218-5p         14688 0.849
```

```
# Search by gene on example4's result
columns(example4)
```

```
## [1] "database"         "mature_mirna_acc" "mature_mirna_id"  "score"            "target_ensembl"
## [6] "target_entrez"    "target_symbol"    "type"
```

```
keytypes(example4)
```

```
## [1] "database"         "mature_mirna_acc" "mature_mirna_id"  "score"            "target_ensembl"
## [6] "target_entrez"    "target_symbol"    "type"
```

```
head(keys(example4, keytype = "target_entrez"))
```

```
## [1] "1903"   "253782" "55959"  "208"    "286223"
```

```
mykeys <- keys(example4, keytype = "target_entrez")[1]
head(select(example4, keys = mykeys, keytype = "target_entrez",
            columns = c("database", "target_entrez", "score")))
```

```
##        database target_entrez score
## 1  diana_microt          1903     1
## 2  diana_microt          1903 0.998
## 5  diana_microt          1903 0.994
## 19 diana_microt          1903  0.98
## 32 diana_microt          1903 0.964
## 56 diana_microt          1903 0.934
```

# 8 Direct query to the database on the multiMiR web server

As shown previously, *get\_multimir* is the main function to retrieve
information from the *multiMiR* database, which is hosted at
<http://multimir.org>. The function builds one SQL query for every
external database that the user is going to search, submits the query to the web
server, and parses, combines, and summarizes results from the web server. For
advanced users, there are a couple ways to query the *multiMiR*
database without using the *multiMiR* package; but they have to be
familiar with SQL queries. In general, users are still advised to use the
`get_multimir()` function when querying multiple external databases in
*multiMiR*.

## 8.1 Direct query on the web server

The *multiMiR* package communicates with the *multiMiR* database via the script
<http://multimir.org/cgi-bin/multimir_univ.pl>
on the web server. Once again, data from each of the external databases is
stored in a table in *multiMiR*. There are also tables for miRNAs (table
*mirna*) and target genes (table *target*).

NOTE: While it is possible to complete short queries from a browser, the limits of
submitting a query through typing in the address bar of a browser are quickly reached
(8192 characters total). If you are a developer you should use your preferred method
to submit a HTTP POST which will allow for longer queries. The fields to include are
`query` and `dbName`. `query` is the SQL query to submit. `dbName` is the
DBNAME column from a call to `multimir_dbInfoVersions()`, however if this is
excluded the current version is the default.

To learn about the structure of a table (e.g. DIANA-microT data in table
*diana\_microt*), users can use URL

[http://multimir.org/cgi-bin/multimir\_univ.pl?query=describe diana\_microt](http://multimir.org/cgi-bin/multimir_univ.pl?query=describe%20diana_microt)

Similar with Example 1, the following URL searches for validated target genes of
hsa-miR-18a-3p in miRecords.

[http://multimir.org/cgi-bin/multimir.pl?query=SELECT m.mature\_mirna\_acc, m.mature\_mirna\_id, t.target\_symbol, t.target\_entrez, t.target\_ensembl, i.experiment, i.support\_type, i.pubmed\_id FROM mirna AS m INNER JOIN mirecords AS i INNER JOIN target AS t ON (m.mature\_mirna\_uid=i.mature\_mirna\_uid and i.target\_uid=t.target\_uid) WHERE m.mature\_mirna\_id=‘hsa-miR-18a-3p’](http://multimir.org/cgi-bin/multimir.pl?query=SELECT%20m.mature_mirna_acc,%20m.mature_mirna_id,%20t.target_symbol,%20t.target_entrez,%20t.target_ensembl,%20i.experiment,%20i.support_type,%20i.pubmed_id%20FROM%20mirna%20AS%20m%20INNER%20JOIN%20mirecords%20AS%20i%20INNER%20JOIN%20target%20AS%20t%20ON%20(m.mature_mirna_uid=i.mature_mirna_uid%20and%20i.target_uid=t.target_uid)%20WHERE%20m.mature_mirna_id='hsa-miR-18a-3p')

As you can see, the query is long and searches just one of the three validated
tables in *multiMiR*. While in Example 1, one line of R command using the
`get_multimir()` function searches, combines and summarizes results from all
three validated external databases (miRecords, miRTarBase and TarBase).

## 8.2 Direct query in R

The same direct queries we did above on the web server can be done in R as well.
This is the preferred method if you are unfamiliar with HTTP POST. Be sure to
set the correct database version, if you wish to change versions, before calling
`search_multimir()` it uses the currently set version.

To show the structure of table *diana\_microt*:

```
direct2 <- search_multimir(query = "describe diana_microt")
direct2
```

```
## NULL
```

To search for validated target genes of hsa-miR-18a-3p in miRecords:

```
qry <- "SELECT m.mature_mirna_acc, m.mature_mirna_id, t.target_symbol,
               t.target_entrez, t.target_ensembl, i.experiment, i.support_type,
               i.pubmed_id
        FROM mirna AS m INNER JOIN mirecords AS i INNER JOIN target AS t
        ON (m.mature_mirna_uid=i.mature_mirna_uid and
            i.target_uid=t.target_uid)
        WHERE m.mature_mirna_id='hsa-miR-18a-3p'"
direct3 <- search_multimir(query = qry)
direct3
```

```
## NULL
```

# 9 Session Info

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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] edgeR_4.8.0      limma_3.66.0     multiMiR_1.32.0  knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] utf8_1.2.6           sass_0.4.10          generics_0.1.4       bitops_1.0-9
##  [5] lattice_0.22-7       RSQLite_2.4.3        digest_0.6.37        magrittr_2.0.4
##  [9] grid_4.5.1           evaluate_1.0.5       bookdown_0.45        fastmap_1.2.0
## [13] blob_1.2.4           jsonlite_2.0.0       AnnotationDbi_1.72.0 DBI_1.2.3
## [17] BiocManager_1.30.26  httr_1.4.7           purrr_1.1.0          XML_3.99-0.19
## [21] Biostrings_2.78.0    jquerylib_0.1.4      cli_3.6.5            rlang_1.1.6
## [25] crayon_1.5.3         XVector_0.50.0       Biobase_2.70.0       splines_4.5.1
## [29] bit64_4.6.0-1        cachem_1.1.0         yaml_2.3.10          tools_4.5.1
## [33] memoise_2.0.1        dplyr_1.1.4          locfit_1.5-9.12      BiocGenerics_0.56.0
## [37] vctrs_0.6.5          R6_2.6.1             png_0.1-8            stats4_4.5.1
## [41] lifecycle_1.0.4      KEGGREST_1.50.0      Seqinfo_1.0.0        S4Vectors_0.48.0
## [45] IRanges_2.44.0       bit_4.6.0            pkgconfig_2.0.3      bslib_0.9.0
## [49] pillar_1.11.1        glue_1.8.0           statmod_1.5.1        xfun_0.53
## [53] tibble_3.3.0         tidyselect_1.2.1     htmltools_0.5.8.1    rmarkdown_2.30
## [57] compiler_4.5.1       RCurl_1.98-1.17
```

```
warnings()
```