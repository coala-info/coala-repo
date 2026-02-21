# A. Introduction

Original version: 26 September, 2023

# Introduction

The AlphaMissense [publication](https://www.science.org/doi/epdf/10.1126/science.adg7492) outlines how a variant of AlphaFold / DeepMind was used to predict missense variant pathogenicity. Supporting data on [Zenodo](https://zenodo.org//record/8360242) include, for instance 70+M variants across hg19 and hg38 genome builds. The AlphaMissense package allows ready access to the data, downloading individual files to DuckDB databases for ready exploration and integration into *R* and *Bioconductor* workflows.

Install the package from *Bioconductor* or GitHub, ensuring correct *Bioconductor* dependencies.

```
if (!"BiocManager" %in% rownames(installed.packages()))
    install.packages("BiocManager", repos = "https://cran.r-project.org")
```

When the package is available on *Bioconductor*, use

```
if (BiocManager::version() >= "3.19") {
    BiocManager::install("AlphaMissenseR")
} else {
    stop(
        "'AlphaMissenseR' requires Bioconductor version 3.19 or later, ",
        "install from GitHub?"
    )
}
```

Use the pre-release or devel version with

```
remotes::install_github(
    "mtmorgan/AlphaMissenseR",
    repos = BiocManager::repositories()
)
```

Load the library.

```
library(AlphaMissenseR)
```

Learn about available data by visiting the Zenodo record where data will be retrieved from.

```
am_browse()
```

# Discovery, retrieval and use

Use `am_available()` to discover data resources available for representation in DuckDB databases. The `cached` column is initially `FALSE` for all data sets; `TRUE` indicates that a data set has been downloaded by `am_data()`, as described below.

```
am_available()
#> # A tibble: 7 × 6
#>   record   key                             size cached filename            link
#>   <chr>    <chr>                          <dbl> <lgl>  <chr>               <chr>
#> 1 10813168 gene_hg38                     253636 TRUE   AlphaMissense_gene… http…
#> 2 10813168 isoforms_hg38             1177361934 FALSE  AlphaMissense_isof… http…
#> 3 10813168 isoforms_aa_substitutions 2461351945 FALSE  AlphaMissense_isof… http…
#> 4 10813168 hg38                       642961469 TRUE   AlphaMissense_hg38… http…
#> 5 10813168 hg19                       622293310 FALSE  AlphaMissense_hg19… http…
#> 6 10813168 gene_hg19                     243943 FALSE  AlphaMissense_gene… http…
#> 7 10813168 aa_substitutions          1207278510 TRUE   AlphaMissense_aa_s… http…
```

The available data sets use the most recent record as of 25 September, 2023; this can be changed by specifying an alternative as the `record=` argument or changed globally by setting an environment variable `ALPHAMISSENSE_RECORD` *before* loading the package.

Use `am_data()` to download a data resource and store it in a DuckDB database. The `key=` argument is from the column returned by `am_available()`. Files are cached locally (using [BiocFileCache](https://bioconductor.org/packages/BiocFileCache)) so this operation is expensive only the first time. Each `record=` is stored in a different database.

```
tbl <- am_data("hg38")
tbl
#> # Source:   table<hg38> [?? x 10]
#> # Database: DuckDB 1.4.2 [biocbuild@Linux 6.8.0-79-generic:R 4.5.2//home/biocbuild/.cache/R/BiocFileCache/19e9f02faae911_19e9f02faae911]
#>    CHROM   POS REF   ALT   genome uniprot_id transcript_id     protein_variant
#>    <chr> <dbl> <chr> <chr> <chr>  <chr>      <chr>             <chr>
#>  1 chr1  69094 G     T     hg38   Q8NH21     ENST00000335137.4 V2L
#>  2 chr1  69094 G     C     hg38   Q8NH21     ENST00000335137.4 V2L
#>  3 chr1  69094 G     A     hg38   Q8NH21     ENST00000335137.4 V2M
#>  4 chr1  69095 T     C     hg38   Q8NH21     ENST00000335137.4 V2A
#>  5 chr1  69095 T     A     hg38   Q8NH21     ENST00000335137.4 V2E
#>  6 chr1  69095 T     G     hg38   Q8NH21     ENST00000335137.4 V2G
#>  7 chr1  69097 A     G     hg38   Q8NH21     ENST00000335137.4 T3A
#>  8 chr1  69097 A     C     hg38   Q8NH21     ENST00000335137.4 T3P
#>  9 chr1  69097 A     T     hg38   Q8NH21     ENST00000335137.4 T3S
#> 10 chr1  69098 C     A     hg38   Q8NH21     ENST00000335137.4 T3N
#> # ℹ more rows
#> # ℹ 2 more variables: am_pathogenicity <dbl>, am_class <chr>
```

The return value `tbl` is a table from a DuckDB database. A (read-only) connection to the database itself is available with

```
db <- db_connect()
```

This connection remains open throughout the session; call `db_disconnect(db)` or `db_disconnect_all()` to close it at the end of the session.

The database contains tables for each key downloaded. As an alternative to `am_available()` / `am_data()`, view available tables and create a [dplyr](https://cran.r-project.org/package%3Ddplyr) / [dbplyr](https://cran.r-project.org/package%3Ddbplyr) tibble of the table of interest.

```
db_tables(db)
#> [1] "aa_substitutions" "clinvar"          "gene_hg38"        "hg38"

tbl <- tbl(db, "hg38")
tbl
#> # Source:   table<hg38> [?? x 10]
#> # Database: DuckDB 1.4.2 [biocbuild@Linux 6.8.0-79-generic:R 4.5.2//home/biocbuild/.cache/R/BiocFileCache/19e9f02faae911_19e9f02faae911]
#>    CHROM   POS REF   ALT   genome uniprot_id transcript_id     protein_variant
#>    <chr> <dbl> <chr> <chr> <chr>  <chr>      <chr>             <chr>
#>  1 chr1  69094 G     T     hg38   Q8NH21     ENST00000335137.4 V2L
#>  2 chr1  69094 G     C     hg38   Q8NH21     ENST00000335137.4 V2L
#>  3 chr1  69094 G     A     hg38   Q8NH21     ENST00000335137.4 V2M
#>  4 chr1  69095 T     C     hg38   Q8NH21     ENST00000335137.4 V2A
#>  5 chr1  69095 T     A     hg38   Q8NH21     ENST00000335137.4 V2E
#>  6 chr1  69095 T     G     hg38   Q8NH21     ENST00000335137.4 V2G
#>  7 chr1  69097 A     G     hg38   Q8NH21     ENST00000335137.4 T3A
#>  8 chr1  69097 A     C     hg38   Q8NH21     ENST00000335137.4 T3P
#>  9 chr1  69097 A     T     hg38   Q8NH21     ENST00000335137.4 T3S
#> 10 chr1  69098 C     A     hg38   Q8NH21     ENST00000335137.4 T3N
#> # ℹ more rows
#> # ℹ 2 more variables: am_pathogenicity <dbl>, am_class <chr>
```

It is fast and straight-forward to summarize the data, e.g., the number of variants assigned to each pathogenicity class.

```
tbl |>
    count(am_class)
#> # Source:   SQL [?? x 2]
#> # Database: DuckDB 1.4.2 [biocbuild@Linux 6.8.0-79-generic:R 4.5.2//home/biocbuild/.cache/R/BiocFileCache/19e9f02faae911_19e9f02faae911]
#>   am_class                 n
#>   <chr>                <dbl>
#> 1 ambiguous          8009648
#> 2 likely_pathogenic 22770557
#> 3 likely_benign     40917351
```

Or the average pathogenicity score in each class…

```
tbl |>
    group_by(am_class) |>
    summarize(n = n(), pathogenecity = mean(am_pathogenicity, na.rm = TRUE))
#> # Source:   SQL [?? x 3]
#> # Database: DuckDB 1.4.2 [biocbuild@Linux 6.8.0-79-generic:R 4.5.2//home/biocbuild/.cache/R/BiocFileCache/19e9f02faae911_19e9f02faae911]
#>   am_class                 n pathogenecity
#>   <chr>                <dbl>         <dbl>
#> 1 ambiguous          8009648         0.444
#> 2 likely_benign     40917351         0.147
#> 3 likely_pathogenic 22770557         0.863
```

Or the number of transitions between `REF` and `ALT` nucleotides across all variants.

```
tbl |>
    count(REF, ALT) |>
    tidyr::pivot_wider(names_from = "ALT", values_from = "n") |>
    select("REF", "A", "C", "G", "T") |>
    arrange(REF)
#> # Source:     SQL [?? x 5]
#> # Database:   DuckDB 1.4.2 [biocbuild@Linux 6.8.0-79-generic:R 4.5.2//home/biocbuild/.cache/R/BiocFileCache/19e9f02faae911_19e9f02faae911]
#> # Ordered by: REF
#>   REF         A       C       G       T
#>   <chr>   <dbl>   <dbl>   <dbl>   <dbl>
#> 1 A          NA 6420083 5449617 5953590
#> 2 C     6183248      NA 6963298 4909869
#> 3 G     4894493 6937258      NA 6161594
#> 4 T     5955039 5445540 6423927      NA
```

It is straight-forward to select variants in individual regions of interest, e.g., the first 200000 nucleoties of chromosome 4.

```
tbl |>
    filter(CHROM == "chr4", POS > 0, POS <= 200000)
#> # Source:   SQL [?? x 10]
#> # Database: DuckDB 1.4.2 [biocbuild@Linux 6.8.0-79-generic:R 4.5.2//home/biocbuild/.cache/R/BiocFileCache/19e9f02faae911_19e9f02faae911]
#>    CHROM   POS REF   ALT   genome uniprot_id transcript_id     protein_variant
#>    <chr> <dbl> <chr> <chr> <chr>  <chr>      <chr>             <chr>
#>  1 chr4  59430 G     C     hg38   Q8IYB9     ENST00000610261.6 E2Q
#>  2 chr4  59430 G     A     hg38   Q8IYB9     ENST00000610261.6 E2K
#>  3 chr4  59431 A     C     hg38   Q8IYB9     ENST00000610261.6 E2A
#>  4 chr4  59431 A     G     hg38   Q8IYB9     ENST00000610261.6 E2G
#>  5 chr4  59431 A     T     hg38   Q8IYB9     ENST00000610261.6 E2V
#>  6 chr4  59432 A     C     hg38   Q8IYB9     ENST00000610261.6 E2D
#>  7 chr4  59432 A     T     hg38   Q8IYB9     ENST00000610261.6 E2D
#>  8 chr4  59433 C     A     hg38   Q8IYB9     ENST00000610261.6 L3I
#>  9 chr4  59433 C     T     hg38   Q8IYB9     ENST00000610261.6 L3F
#> 10 chr4  59433 C     G     hg38   Q8IYB9     ENST00000610261.6 L3V
#> # ℹ more rows
#> # ℹ 2 more variables: am_pathogenicity <dbl>, am_class <chr>
```

# Working with Bioconductor

This section illustrates how AlphaMissense data can be integrated with other *Bioconductor* workflows, including the [GenomicRanges](https://bioconductor.org/packages/GenomicRanges) infrastructure and the [ensembldb](https://bioconductor.org/packages/ensembldb) package / [AnnotationHub](https://bioconductor.org/packages/AnnotationHub) resources.

## Genomic ranges

The [GenomicRanges](https://bioconductor.org/packages/GenomicRanges) infrastructure provides standard data structures that allow range-based operations across Bioconductor packages. The `GPos` data structure provides a convenient and memory-efficient representation of single-nucleotide variants like those in the `hg19` and `hg38` AlphaMissense resources. Start by installing (if necessary) the [GenomicRanges](https://bioconductor.org/packages/GenomicRanges) package.

```
if (!requireNamespace("GenomicRanges", quietly = TRUE))
    BiocManager::install("GenomicRanges")
```

Select the `hg38` data resource, and filter to a subset of variants; `GPos` is an in-memory data structure and can easily manage 10’s of millions of variants.

```
tbl <-
    am_data("hg38") |>
    filter(CHROM == "chr2", POS < 10000000, REF == "G")
```

Use `to_GPos()` to coerce to a `GPos` object.

```
gpos <-
    tbl |>
    to_GPos()
gpos
#> UnstitchedGPos object with 26751 positions and 7 metadata columns:
#>           seqnames       pos strand |         REF         ALT  uniprot_id
#>              <Rle> <integer>  <Rle> | <character> <character> <character>
#>       [1]     chr2     41613      * |           G           C      Q1W6H9
#>       [2]     chr2     41615      * |           G           C      Q1W6H9
#>       [3]     chr2     41615      * |           G           A      Q1W6H9
#>       [4]     chr2     41615      * |           G           T      Q1W6H9
#>       [5]     chr2     41618      * |           G           C      Q1W6H9
#>       ...      ...       ...    ... .         ...         ...         ...
#>   [26747]     chr2   9999028      * |           G           A      Q9NZI5
#>   [26748]     chr2   9999028      * |           G           T      Q9NZI5
#>   [26749]     chr2   9999029      * |           G           C      Q9NZI5
#>   [26750]     chr2   9999029      * |           G           A      Q9NZI5
#>   [26751]     chr2   9999029      * |           G           T      Q9NZI5
#>                transcript_id protein_variant am_pathogenicity          am_class
#>                  <character>     <character>        <numeric>       <character>
#>       [1]  ENST00000327669.5           R321G           0.0848     likely_benign
#>       [2]  ENST00000327669.5           S320C           0.0946     likely_benign
#>       [3]  ENST00000327669.5           S320F           0.1593     likely_benign
#>       [4]  ENST00000327669.5           S320Y           0.1429     likely_benign
#>       [5]  ENST00000327669.5           P319R           0.0765     likely_benign
#>       ...                ...             ...              ...               ...
#>   [26747] ENST00000324907.14           G581R           0.9997 likely_pathogenic
#>   [26748] ENST00000324907.14           G581W           0.9996 likely_pathogenic
#>   [26749] ENST00000324907.14           G581A           0.9970 likely_pathogenic
#>   [26750] ENST00000324907.14           G581E           0.9995 likely_pathogenic
#>   [26751] ENST00000324907.14           G581V           0.9994 likely_pathogenic
#>   -------
#>   seqinfo: 25 sequences (1 circular) from hg38 genome
```

Vignettes in the [GenomicRanges](https://bioconductor.org/packages/GenomicRanges) package illustrate use of these objects.

```
utils::browseVignettes("GenomicRanges")
```

## GRCh38 annotation resources

Start by identifying the most recent EnsDb resource for *Homo Sapiens*.

```
hub <- AnnotationHub::AnnotationHub()
AnnotationHub::query(hub, c("EnsDb", "Homo sapiens"))
#> AnnotationHub with 28 records
#> # snapshotDate(): 2025-10-29
#> # $dataprovider: Ensembl
#> # $species: Homo sapiens
#> # $rdataclass: EnsDb
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["AH53211"]]'
#>
#>              title
#>   AH53211  | Ensembl 87 EnsDb for Homo Sapiens
#>   AH53715  | Ensembl 88 EnsDb for Homo Sapiens
#>   AH56681  | Ensembl 89 EnsDb for Homo Sapiens
#>   AH57757  | Ensembl 90 EnsDb for Homo Sapiens
#>   AH60773  | Ensembl 91 EnsDb for Homo Sapiens
#>   ...        ...
#>   AH109606 | Ensembl 109 EnsDb for Homo sapiens
#>   AH113665 | Ensembl 110 EnsDb for Homo sapiens
#>   AH116291 | Ensembl 111 EnsDb for Homo sapiens
#>   AH116860 | Ensembl 112 EnsDb for Homo sapiens
#>   AH119325 | Ensembl 113 EnsDb for Homo sapiens

AnnotationHub::AnnotationHub()["AH113665"]
#> AnnotationHub with 1 record
#> # snapshotDate(): 2025-10-29
#> # names(): AH113665
#> # $dataprovider: Ensembl
#> # $species: Homo sapiens
#> # $rdataclass: EnsDb
#> # $rdatadateadded: 2023-04-25
#> # $title: Ensembl 110 EnsDb for Homo sapiens
#> # $description: Gene and protein annotations for Homo sapiens based on Ensem...
#> # $taxonomyid: 9606
#> # $genome: GRCh38
#> # $sourcetype: ensembl
#> # $sourceurl: http://www.ensembl.org
#> # $sourcesize: NA
#> # $tags: c("110", "Annotation", "AnnotationHubSoftware", "Coverage",
#> #   "DataImport", "EnsDb", "Ensembl", "Gene", "Protein", "Sequencing",
#> #   "Transcript")
#> # retrieve record with 'object[["AH113665"]]'
```

Load the [ensembldb](https://bioconductor.org/packages/ensembldb) library and retrieve the record. Unfortunately, there are many conflicts between function names in different packages, so it becomes necessary to fully resolve functions to the package where they are defined.

```
library(ensembldb)
edb <- AnnotationHub::AnnotationHub()[["AH113665"]]
edb
#> EnsDb for Ensembl:
#> |Backend: SQLite
#> |Db type: EnsDb
#> |Type of Gene ID: Ensembl Gene ID
#> |Supporting package: ensembldb
#> |Db created by: ensembldb package from Bioconductor
#> |script_version: 0.3.10
#> |Creation time: Mon Aug  7 09:02:07 2023
#> |ensembl_version: 110
#> |ensembl_host: 127.0.0.1
#> |Organism: Homo sapiens
#> |taxonomy_id: 9606
#> |genome_build: GRCh38
#> |DBSCHEMAVERSION: 2.2
#> |common_name: human
#> |species: homo_sapiens
#> | No. of genes: 71440.
#> | No. of transcripts: 278545.
#> |Protein data available.
```

## From *Bioconductor* to *DuckDB*

In this section we will work more directly with the database, including writing temporary tables. For illustration purposes, we use a connection that can read and write; in practice, read-only permissions are sufficient for creating temporary tables.

```
db_rw <- db_connect(read_only = FALSE)
```

As an illustration, use [ensembldb](https://bioconductor.org/packages/ensembldb) to identify the exons of the canonical transcript of a particular gene.

```
bcl2l11 <-
    edb |>
    ensembldb::filter(
        ~ symbol == "BCL2L11" &
            tx_biotype == "protein_coding" &
            tx_is_canonical == TRUE
    ) |>
    exonsBy("tx")
bcl2l11
#> GRangesList object of length 1:
#> $ENST00000393256
#> GRanges object with 4 ranges and 2 metadata columns:
#>       seqnames              ranges strand |         exon_id exon_rank
#>          <Rle>           <IRanges>  <Rle> |     <character> <integer>
#>   [1]        2 111120914-111121188      + | ENSE00004011574         1
#>   [2]        2 111123733-111124139      + | ENSE00001008808         2
#>   [3]        2 111150044-111150147      + | ENSE00003483971         3
#>   [4]        2 111164133-111168444      + | ENSE00001924953         4
#>   -------
#>   seqinfo: 1 sequence from GRCh38 genome
```

Munge the data to a tibble, updating the `seqnames` to a column `CHROM` with identifiers such as `"chr1"` (as in the AlphaMissense data). Write the tibble to a temporary table (it will be deleted when `db` is disconnected from the database) so that it can be used in ‘lazy’ SQL queries with the AlphaMissense data.

```
bcl2l11_tbl <-
    bcl2l11 |>
    dplyr::as_tibble() |>
    dplyr::mutate(CHROM = paste0("chr", seqnames)) |>
    dplyr::select(CHROM, everything(), -seqnames)

db_temporary_table(db_rw, bcl2l11_tbl, "bcl2l11")
#> # Source:   table<bcl2l11> [?? x 9]
#> # Database: DuckDB 1.4.2 [biocbuild@Linux 6.8.0-79-generic:R 4.5.2//home/biocbuild/.cache/R/BiocFileCache/19e9f02faae911_19e9f02faae911]
#>   CHROM group group_name          start       end width strand exon_id exon_rank
#>   <chr> <int> <chr>               <int>     <int> <int> <fct>  <chr>       <int>
#> 1 chr2      1 ENST00000393256 111120914 111121188   275 +      ENSE00…         1
#> 2 chr2      1 ENST00000393256 111123733 111124139   407 +      ENSE00…         2
#> 3 chr2      1 ENST00000393256 111150044 111150147   104 +      ENSE00…         3
#> 4 chr2      1 ENST00000393256 111164133 111168444  4312 +      ENSE00…         4
```

The temporary table is now available on the `db_rw` connection; the tables will be removed on disconnect, `db_disconnect(db_rw)`.

```
"bcl2l11" %in% db_tables(db_rw)
#> [1] TRUE
```

Use `db_range_join()` to join the AlphaMissense data with the ranges defining the exons in our gene of interest. The arguments are the database connection, the AlphaMissense table of interest (this table must have columns `CHROM` and `POS`), the table containing ranges of interest (with columns `CHROM`, `start`, `end`), and the temporary table to contain the results. A range join is like a standard database join, expect that the constraints can be relations, in our case that `POS >= start` and `POS <= end` for each range of interest; implementation details are in this [DuckDB blog](https://duckdb.org/2022/05/27/iejoin.html). The range join uses closed intervals (the start and end positions are included in the query), following *Bioconductor* convention. Writing to a temporary table avoids bringing potentially large datasets into R memory, and makes the table available for subsequent manipulation in the current session.

```
rng <- db_range_join(db_rw, "hg38", "bcl2l11", "bcl2l11_overlaps")
rng
#> # Source:   table<bcl2l11_overlaps> [?? x 18]
#> # Database: DuckDB 1.4.2 [biocbuild@Linux 6.8.0-79-generic:R 4.5.2//home/biocbuild/.cache/R/BiocFileCache/19e9f02faae911_19e9f02faae911]
#>    CHROM       POS REF   ALT   genome uniprot_id transcript_id   protein_variant
#>    <chr>     <dbl> <chr> <chr> <chr>  <chr>      <chr>           <chr>
#>  1 chr2  111123749 G     C     hg38   O43521     ENST0000039325… A2P
#>  2 chr2  111123749 G     T     hg38   O43521     ENST0000039325… A2S
#>  3 chr2  111123749 G     A     hg38   O43521     ENST0000039325… A2T
#>  4 chr2  111123750 C     A     hg38   O43521     ENST0000039325… A2E
#>  5 chr2  111123750 C     G     hg38   O43521     ENST0000039325… A2G
#>  6 chr2  111123750 C     T     hg38   O43521     ENST0000039325… A2V
#>  7 chr2  111123752 A     C     hg38   O43521     ENST0000039325… K3Q
#>  8 chr2  111123752 A     G     hg38   O43521     ENST0000039325… K3E
#>  9 chr2  111123753 A     G     hg38   O43521     ENST0000039325… K3R
#> 10 chr2  111123753 A     T     hg38   O43521     ENST0000039325… K3M
#> # ℹ more rows
#> # ℹ 10 more variables: am_pathogenicity <dbl>, am_class <chr>, group <int>,
#> #   group_name <chr>, start <int>, end <int>, width <int>, strand <fct>,
#> #   exon_id <chr>, exon_rank <int>
```

This query takes place almost instantly. A larger query of 71M variants against 1000 ranges took about 20 seconds.

The usual database and [dplyr](https://cran.r-project.org/package%3Ddplyr) verbs can be used to summarize the results, e.g., the number of variants in each pathogenecity class in each exon.

```
rng |>
    dplyr::count(exon_id, am_class) |>
    tidyr::pivot_wider(names_from = "am_class", values_from = "n")
#> # Source:   SQL [?? x 4]
#> # Database: DuckDB 1.4.2 [biocbuild@Linux 6.8.0-79-generic:R 4.5.2//home/biocbuild/.cache/R/BiocFileCache/19e9f02faae911_19e9f02faae911]
#>   exon_id         ambiguous likely_pathogenic likely_benign
#>   <chr>               <dbl>             <dbl>         <dbl>
#> 1 ENSE00003483971        33                71           128
#> 2 ENSE00001008808       108               257           494
#> 3 ENSE00001924953        19                16           172
```

It is perhaps instructive to review the range join as a source of inspiration for other computations that might be of interest.

```
-- range join of 'hg38' with 'bcl2l11'; overwrite any existing table
-- 'bcl2l11_overlaps'
DROP TABLE IF EXISTS bcl2l11_overlaps;
CREATE TEMP TABLE bcl2l11_overlaps AS
SELECT
    hg38.*,
    bcl2l11.* EXCLUDE (CHROM)
FROM hg38
JOIN bcl2l11
    ON bcl2l11.CHROM = hg38.CHROM
    AND bcl2l11.start <= hg38.POS
    AND bcl2l11.end >= hg38.POS;
```

As best practice, disconnect from the writable database connection when work is complete.

```
db_disconnect(db_rw)
```

## From *DuckDB* to *Bioconductor*

There are likely more straight-forward ways of performing the query in the previous section, e.g., by filtering `hg38` on the relevant transcript id(s), retrieving to *R*, and working with `edb` to classify variants by exon. The transcript we are interested in is `"ENST00000393256"`.

Select the relevant variants and, because there are not too many, load into *R*.

```
variants_of_interest <-
    am_data("hg38") |>
    dplyr::filter(transcript_id %like% "ENST00000393256%")
```

Coerce the AlphaMissense data to a `GRanges::GPos` object.

```
gpos <-
    variants_of_interest |>
    to_GPos()
## make gpos 'genome' and 'seqlevels' like bcl2l11
Seqinfo::genome(gpos) <- "GRCh38"
GenomeInfoDb::seqlevelsStyle(gpos) <- "Ensembl"
gpos
#> UnstitchedGPos object with 1298 positions and 7 metadata columns:
#>          seqnames       pos strand |         REF         ALT  uniprot_id
#>             <Rle> <integer>  <Rle> | <character> <character> <character>
#>      [1]        2 111123749      * |           G           C      O43521
#>      [2]        2 111123749      * |           G           T      O43521
#>      [3]        2 111123749      * |           G           A      O43521
#>      [4]        2 111123750      * |           C           A      O43521
#>      [5]        2 111123750      * |           C           G      O43521
#>      ...      ...       ...    ... .         ...         ...         ...
#>   [1294]        2 111164227      * |           A           G      O43521
#>   [1295]        2 111164227      * |           A           T      O43521
#>   [1296]        2 111164227      * |           A           C      O43521
#>   [1297]        2 111164228      * |           T           A      O43521
#>   [1298]        2 111164228      * |           T           G      O43521
#>              transcript_id protein_variant am_pathogenicity          am_class
#>                <character>     <character>        <numeric>       <character>
#>      [1] ENST00000393256.8             A2P           0.6610 likely_pathogenic
#>      [2] ENST00000393256.8             A2S           0.3398     likely_benign
#>      [3] ENST00000393256.8             A2T           0.7219 likely_pathogenic
#>      [4] ENST00000393256.8             A2E           0.7283 likely_pathogenic
#>      [5] ENST00000393256.8             A2G           0.3883         ambiguous
#>      ...               ...             ...              ...               ...
#>   [1294] ENST00000393256.8           H198R           0.1226     likely_benign
#>   [1295] ENST00000393256.8           H198L           0.2526     likely_benign
#>   [1296] ENST00000393256.8           H198P           0.1323     likely_benign
#>   [1297] ENST00000393256.8           H198Q           0.1781     likely_benign
#>   [1298] ENST00000393256.8           H198Q           0.1781     likely_benign
#>   -------
#>   seqinfo: 25 sequences (1 circular) from GRCh38 genome
```

One can then use [GenomicRanges](https://bioconductor.org/packages/GenomicRanges) functionality, e.g., to count the number of variants in each exon.

```
countOverlaps(unlist(bcl2l11), gpos)
#> ENST00000393256 ENST00000393256 ENST00000393256 ENST00000393256
#>               0             859             232             207
```

# Finally

Remember to disconnect and shutdown all managed DuckDB connections.

```
db_disconnect_all()
#> * [16:17:56][info] disconnecting all registered connections
```

Database connections that are not closed correctly trigger warning messages.

# Session information

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#>  [1] ensembldb_2.34.0        AnnotationFilter_1.34.0 GenomicFeatures_1.62.0
#>  [4] AnnotationDbi_1.72.0    Biobase_2.70.0          GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0           IRanges_2.44.0          S4Vectors_0.48.0
#> [10] ProteinGymR_1.4.0       ggplot2_4.0.1           ggdist_3.3.3
#> [13] tidyr_1.3.1             ExperimentHub_3.0.0     AnnotationHub_4.0.0
#> [16] BiocFileCache_3.0.0     dbplyr_2.5.1            BiocGenerics_0.56.0
#> [19] generics_0.1.4          AlphaMissenseR_1.6.1    dplyr_1.1.4
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3                   bitops_1.0-9
#>   [3] httr2_1.2.1                 rlang_1.1.6
#>   [5] magrittr_2.0.4              otel_0.2.0
#>   [7] matrixStats_1.5.0           compiler_4.5.2
#>   [9] RSQLite_2.4.4               png_0.1-8
#>  [11] vctrs_0.6.5                 ProtGenerics_1.42.0
#>  [13] stringr_1.6.0               pkgconfig_2.0.3
#>  [15] crayon_1.5.3                fastmap_1.2.0
#>  [17] XVector_0.50.0              labeling_0.4.3
#>  [19] utf8_1.2.6                  Rsamtools_2.26.0
#>  [21] promises_1.5.0              rmarkdown_2.30
#>  [23] UCSC.utils_1.6.0            purrr_1.2.0
#>  [25] bit_4.6.0                   xfun_0.54
#>  [27] cachem_1.1.0                cigarillo_1.0.0
#>  [29] queryup_1.0.5               GenomeInfoDb_1.46.1
#>  [31] jsonlite_2.0.0              blob_1.2.4
#>  [33] later_1.4.4                 DelayedArray_0.36.0
#>  [35] BiocParallel_1.44.0         parallel_4.5.2
#>  [37] spdl_0.0.5                  R6_2.6.1
#>  [39] bslib_0.9.0                 stringi_1.8.7
#>  [41] RColorBrewer_1.1-3          rtracklayer_1.70.0
#>  [43] jquerylib_0.1.4             SummarizedExperiment_1.40.0
#>  [45] Rcpp_1.1.0                  knitr_1.50
#>  [47] BiocBaseUtils_1.12.0        Matrix_1.7-4
#>  [49] httpuv_1.6.16               tidyselect_1.2.1
#>  [51] abind_1.4-8                 dichromat_2.0-0.1
#>  [53] yaml_2.3.10                 codetools_0.2-20
#>  [55] curl_7.0.0                  rjsoncons_1.3.2
#>  [57] lattice_0.22-7              tibble_3.3.0
#>  [59] shiny_1.11.1                bio3d_2.4-5
#>  [61] withr_3.0.2                 KEGGREST_1.50.0
#>  [63] S7_0.2.1                    evaluate_1.0.5
#>  [65] r3dmol_0.1.2                Biostrings_2.78.0
#>  [67] pillar_1.11.1               BiocManager_1.30.27
#>  [69] filelock_1.0.3              MatrixGenerics_1.22.0
#>  [71] whisker_0.4.1               distributional_0.5.0
#>  [73] RCurl_1.98-1.17             BiocVersion_3.22.0
#>  [75] scales_1.4.0                xtable_1.8-4
#>  [77] glue_1.8.0                  lazyeval_0.2.2
#>  [79] tools_4.5.2                 BiocIO_1.20.0
#>  [81] GenomicAlignments_1.46.0    XML_3.99-0.20
#>  [83] grid_4.5.2                  colorspace_2.1-2
#>  [85] RcppSpdlog_0.0.23           duckdb_1.4.2
#>  [87] restfulr_0.0.16             cli_3.6.5
#>  [89] rappdirs_0.3.3              shiny.gosling_1.6.0
#>  [91] S4Arrays_1.10.0             viridisLite_0.4.2
#>  [93] gtable_0.3.6                sass_0.4.10
#>  [95] digest_0.6.39               SparseArray_1.10.3
#>  [97] rjson_0.2.23                htmlwidgets_1.6.4
#>  [99] farver_2.1.2                memoise_2.0.1
#> [101] htmltools_0.5.8.1           lifecycle_1.0.4
#> [103] httr_1.4.7                  mime_0.13
#> [105] bit64_4.6.0-1
```