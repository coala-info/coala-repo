# Organism.dplyr

#### 7 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Constructing a *src\_organism*](#constructing-a-src_organism)
  + [2.1 Make sqlite datebase from ‘TxDb’ package](#make-sqlite-datebase-from-txdb-package)
  + [2.2 Make sqlite datebase from organism name](#make-sqlite-datebase-from-organism-name)
  + [2.3 Access existing sqlite file](#access-existing-sqlite-file)
* [3 The “dplyr” interface](#the-dplyr-interface)
* [4 The “select” interface](#the-select-interface)
* [5 Genomic Coordinates Extractor Interfaces](#genomic-coordinates-extractor-interfaces)

# 1 Introduction

The *[Organism.dplyr](https://bioconductor.org/packages/3.22/Organism.dplyr)* creates an on disk sqlite database to hold
data of an organism combined from an ‘org’ package (e.g.,
*[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)*) and a genome coordinate functionality of the
‘TxDb’ package (e.g., *[TxDb.Hsapiens.UCSC.hg38.knownGene](https://bioconductor.org/packages/3.22/TxDb.Hsapiens.UCSC.hg38.knownGene)*). It
aims to provide an integrated presentation of identifiers and genomic
coordinates. And a *src\_organism* object is created to point to the database.

The *src\_organism* object is created as an extension of *src\_sql* and
*src\_sqlite* from [dplyr](https://CRAN.R-project.org/package%3Ddplyr), which inherited all [dplyr](https://CRAN.R-project.org/package%3Ddplyr) methods. It also
implements the `select()` interface from *[AnnotationDbi](https://bioconductor.org/packages/3.22/AnnotationDbi)* and
genomic coordinates extractors from *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)*.

# 2 Constructing a *src\_organism*

## 2.1 Make sqlite datebase from ‘TxDb’ package

The `src_organism()` constructor creates an on disk sqlite database file with
data from a given ‘TxDb’ package and corresponding ‘org’ package. When dbpath
is given, file is created at the given path, otherwise temporary file is
created.

```
library(Organism.dplyr)
```

Running `src_organism()` without a given path will save the sqlite file to a
`tempdir()`:

```
src <- src_organism("TxDb.Hsapiens.UCSC.hg38.knownGene")
```

Alternatively you can provide explicit path to where the sqlite file should
be saved, and re-use the data base at a later date.

```
path <- "path/to/my.sqlite"
src <- src_organism("TxDb.Hsapiens.UCSC.hg38.knownGene", path)
```

`supportedOrganisms()` provides a list of organisms with corresponding ‘org’
and ‘TxDb’ packages being supported.

```
supportedOrganisms()
```

```
## # A tibble: 21 × 3
##    organism                OrgDb        TxDb
##    <chr>                   <chr>        <chr>
##  1 Bos taurus              org.Bt.eg.db TxDb.Btaurus.UCSC.bosTau8.refGene
##  2 Caenorhabditis elegans  org.Ce.eg.db TxDb.Celegans.UCSC.ce11.refGene
##  3 Caenorhabditis elegans  org.Ce.eg.db TxDb.Celegans.UCSC.ce6.ensGene
##  4 Canis familiaris        org.Cf.eg.db TxDb.Cfamiliaris.UCSC.canFam3.refGene
##  5 Drosophila melanogaster org.Dm.eg.db TxDb.Dmelanogaster.UCSC.dm3.ensGene
##  6 Drosophila melanogaster org.Dm.eg.db TxDb.Dmelanogaster.UCSC.dm6.ensGene
##  7 Danio rerio             org.Dr.eg.db TxDb.Drerio.UCSC.danRer10.refGene
##  8 Gallus gallus           org.Gg.eg.db TxDb.Ggallus.UCSC.galGal4.refGene
##  9 Homo sapiens            org.Hs.eg.db TxDb.Hsapiens.UCSC.hg18.knownGene
## 10 Homo sapiens            org.Hs.eg.db TxDb.Hsapiens.UCSC.hg19.knownGene
## # ℹ 11 more rows
```

## 2.2 Make sqlite datebase from organism name

Organism name, genome and id could be specified to create sqlite database.
Organism name (either Organism or common name) must be provided to create the
database, if genome and/or id are not provided, most recent ‘TxDb’ package is
used.

```
src <- src_ucsc("human", path)
```

## 2.3 Access existing sqlite file

An existing on-disk sqlite file can be accessed without recreating the
database. A version of the database created with
[TxDb.Hsapiens.UCSC.hg38.knownGene](https://bioconductor.org/packages/TxDb.Hsapiens.UCSC.hg38.knownGene), with just 50 Entrez gene
identifiers, is distributed with the Organism.dplyr package

```
src <- src_organism(dbpath = hg38light())
src
```

```
## src:  sqlite 3.50.4 [/tmp/RtmpZYdDfq/Rinst2402d378de123f/Organism.dplyr/extdata/light.hg38.knownGene.sqlite]
## tbls: id, id_accession, id_go, id_go_all, id_omim_pm, id_protein,
##   id_transcript, ranges_cds, ranges_exon, ranges_gene, ranges_tx
```

# 3 The “dplyr” interface

All methods from package [dplyr](https://CRAN.R-project.org/package%3Ddplyr) can be used for a *src\_organism* object.

Look at all available tables.

```
src_tbls(src)
```

```
##  [1] "id_accession"  "id_transcript" "id"            "id_omim_pm"
##  [5] "id_protein"    "id_go"         "id_go_all"     "ranges_gene"
##  [9] "ranges_tx"     "ranges_exon"   "ranges_cds"
```

Look at data from one specific table.

```
tbl(src, "id")
```

```
## # Source:   table<`id`> [?? x 6]
## # Database: sqlite 3.50.4 []
##    entrez map      ensembl         symbol genename               alias
##    <chr>  <chr>    <chr>           <chr>  <chr>                  <chr>
##  1 1      19q13.43 ENSG00000121410 A1BG   alpha-1-B glycoprotein A1B
##  2 1      19q13.43 ENSG00000121410 A1BG   alpha-1-B glycoprotein ABG
##  3 1      19q13.43 ENSG00000121410 A1BG   alpha-1-B glycoprotein GAB
##  4 1      19q13.43 ENSG00000121410 A1BG   alpha-1-B glycoprotein HYST2477
##  5 1      19q13.43 ENSG00000121410 A1BG   alpha-1-B glycoprotein A1BG
##  6 10     8p22     ENSG00000156006 NAT2   N-acetyltransferase 2  AAC2
##  7 10     8p22     ENSG00000156006 NAT2   N-acetyltransferase 2  NAT-2
##  8 10     8p22     ENSG00000156006 NAT2   N-acetyltransferase 2  PNAT
##  9 10     8p22     ENSG00000156006 NAT2   N-acetyltransferase 2  NAT2
## 10 100    20q13.12 ENSG00000196839 ADA    adenosine deaminase    ADA1
## # ℹ more rows
```

Look at fields of one table.

```
colnames(tbl(src, "id"))
```

```
## [1] "entrez"   "map"      "ensembl"  "symbol"   "genename" "alias"
```

Below are some examples of querying tables using dplyr.

1. Gene symbol starting with “SNORD” (the notation `SNORD%` is from
   SQL, with `%` representing a wild-card match to any string)

```
tbl(src, "id") %>%
    filter(symbol %like% "SNORD%") %>%
    dplyr::select(entrez, map, ensembl, symbol) %>%
    distinct() %>% arrange(symbol) %>% collect()
```

```
## # A tibble: 8 × 4
##   entrez    map     ensembl         symbol
##   <chr>     <chr>   <chr>           <chr>
## 1 100033413 15q11.2 ENSG00000207063 SNORD116-1
## 2 100033414 15q11.2 ENSG00000207001 SNORD116-2
## 3 100033415 15q11.2 ENSG00000207014 SNORD116-3
## 4 100033416 15q11.2 ENSG00000275529 SNORD116-4
## 5 100033417 15q11.2 ENSG00000207191 SNORD116-5
## 6 100033418 15q11.2 ENSG00000207442 SNORD116-6
## 7 100033419 15q11.2 ENSG00000207133 SNORD116-7
## 8 100033420 15q11.2 ENSG00000207093 SNORD116-8
```

2. Gene ontology (GO) info for gene symbol “ADA”

```
inner_join(tbl(src, "id"), tbl(src, "id_go")) %>%
    filter(symbol == "ADA") %>%
    dplyr::select(entrez, ensembl, symbol, go, evidence, ontology)
```

```
## Joining with `by = join_by(entrez)`
```

```
## # Source:   SQL [?? x 6]
## # Database: sqlite 3.50.4 []
##    entrez ensembl         symbol go         evidence ontology
##    <chr>  <chr>           <chr>  <chr>      <chr>    <chr>
##  1 100    ENSG00000196839 ADA    GO:0000255 IEA      BP
##  2 100    ENSG00000196839 ADA    GO:0001666 IDA      BP
##  3 100    ENSG00000196839 ADA    GO:0001829 IEA      BP
##  4 100    ENSG00000196839 ADA    GO:0001889 IEA      BP
##  5 100    ENSG00000196839 ADA    GO:0001890 IEA      BP
##  6 100    ENSG00000196839 ADA    GO:0002314 IEA      BP
##  7 100    ENSG00000196839 ADA    GO:0002467 IEA      BP
##  8 100    ENSG00000196839 ADA    GO:0002636 IEA      BP
##  9 100    ENSG00000196839 ADA    GO:0002686 IEA      BP
## 10 100    ENSG00000196839 ADA    GO:0002901 IEA      BP
## # ℹ more rows
```

3. Gene transcript counts per gene symbol

```
txcount <- inner_join(tbl(src, "id"), tbl(src, "ranges_tx")) %>%
    dplyr::select(symbol, tx_id) %>%
    group_by(symbol) %>%
    summarize(count = n()) %>%
    dplyr::select(symbol, count) %>%
    arrange(desc(count)) %>%
    collect(n=Inf)
```

```
## Joining with `by = join_by(entrez)`
```

```
txcount
```

```
## # A tibble: 23 × 2
##    symbol    count
##    <chr>     <int>
##  1 AKT3        540
##  2 NAALAD2     160
##  3 ADA         122
##  4 CDH2         88
##  5 A1BG         40
##  6 MED6         39
##  7 LINC02584    32
##  8 NAT2         24
##  9 NR2E3        18
## 10 GAGE12F      16
## # ℹ 13 more rows
```

```
library(ggplot2)
ggplot(txcount, aes(x = symbol, y = count)) +
    geom_bar(stat="identity") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    ggtitle("Transcript count") +
    labs(x = "Symbol") +
    labs(y = "Count")
```

![](data:image/png;base64...)

4. Gene coordinates of symbol “ADA” and “NAT2” as *GRanges*

```
inner_join(tbl(src, "id"), tbl(src, "ranges_gene")) %>%
    filter(symbol %in% c("ADA", "NAT2")) %>%
    dplyr::select(gene_chrom, gene_start, gene_end, gene_strand,
                  symbol, map) %>%
    collect() %>% GenomicRanges::GRanges()
```

```
## Joining with `by = join_by(entrez)`
```

```
## GRanges object with 6 ranges and 2 metadata columns:
##       seqnames            ranges strand |      symbol         map
##          <Rle>         <IRanges>  <Rle> | <character> <character>
##   [1]     chr8 18386273-18401218      + |        NAT2        8p22
##   [2]     chr8 18386273-18401218      + |        NAT2        8p22
##   [3]     chr8 18386273-18401218      + |        NAT2        8p22
##   [4]     chr8 18386273-18401218      + |        NAT2        8p22
##   [5]    chr20 44584896-44652252      - |         ADA    20q13.12
##   [6]    chr20 44584896-44652252      - |         ADA    20q13.12
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

# 4 The “select” interface

Methods `select()`, `keytypes()`, `keys()`, `columns()` and `mapIds` from
*[AnnotationDbi](https://bioconductor.org/packages/3.22/AnnotationDbi)* are implemented for *src\_organism* objects.

Use `keytypes()` to discover which keytypes can be passed to keytype argument
of methods `select()` or `keys()`.

```
keytypes(src)
```

```
##  [1] "accnum"       "alias"        "cds_chrom"    "cds_end"      "cds_id"
##  [6] "cds_name"     "cds_start"    "cds_strand"   "ensembl"      "ensemblprot"
## [11] "ensembltrans" "entrez"       "enzyme"       "evidence"     "evidenceall"
## [16] "exon_chrom"   "exon_end"     "exon_id"      "exon_name"    "exon_rank"
## [21] "exon_start"   "exon_strand"  "gene_chrom"   "gene_end"     "gene_start"
## [26] "gene_strand"  "genename"     "go"           "goall"        "ipi"
## [31] "map"          "omim"         "ontology"     "ontologyall"  "pfam"
## [36] "pmid"         "prosite"      "refseq"       "symbol"       "tx_chrom"
## [41] "tx_end"       "tx_id"        "tx_name"      "tx_start"     "tx_strand"
## [46] "tx_type"      "uniprot"
```

Use `columns()` to discover which kinds of data can be returned for the
*src\_organism* object.

```
columns(src)
```

```
##  [1] "accnum"       "alias"        "cds_chrom"    "cds_end"      "cds_id"
##  [6] "cds_name"     "cds_start"    "cds_strand"   "ensembl"      "ensemblprot"
## [11] "ensembltrans" "entrez"       "enzyme"       "evidence"     "evidenceall"
## [16] "exon_chrom"   "exon_end"     "exon_id"      "exon_name"    "exon_rank"
## [21] "exon_start"   "exon_strand"  "gene_chrom"   "gene_end"     "gene_start"
## [26] "gene_strand"  "genename"     "go"           "goall"        "ipi"
## [31] "map"          "omim"         "ontology"     "ontologyall"  "pfam"
## [36] "pmid"         "prosite"      "refseq"       "symbol"       "tx_chrom"
## [41] "tx_end"       "tx_id"        "tx_name"      "tx_start"     "tx_strand"
## [46] "tx_type"      "uniprot"
```

`keys()` returns keys for the *src\_organism* object. By default it returns the
primary keys for the database, and returns the keys from that keytype when the
keytype argument is used.

Keys of entrez

```
head(keys(src))
```

```
## [1] "1"         "10"        "100"       "1000"      "10000"     "100008586"
```

Keys of symbol

```
head(keys(src, "symbol"))
```

```
## [1] "A1BG"    "NAT2"    "ADA"     "CDH2"    "AKT3"    "GAGE12F"
```

`select()` retrieves the data as a *tibble* based on parameters for selected
keys columns and keytype arguments. If requested columns that have multiple
matches for the keys, `select_tbl()` will return a *tibble* with one row for
each possible match, and `select()` will return a data frame.

```
keytype <- "symbol"
keys <- c("ADA", "NAT2")
columns <- c("entrez", "tx_id", "tx_name","exon_id")
select_tbl(src, keys, columns, keytype)
```

```
## Joining with `by = join_by(entrez)`
```

```
## # Source:   SQL [?? x 5]
## # Database: sqlite 3.50.4 []
##    symbol entrez  tx_id tx_name           exon_id
##    <chr>  <chr>   <int> <chr>               <int>
##  1 NAT2   10     166643 ENST00000660285.2  381744
##  2 NAT2   10     166643 ENST00000660285.2  381751
##  3 NAT2   10     166643 ENST00000660285.2  381754
##  4 NAT2   10     166644 ENST00000739947.1  381745
##  5 NAT2   10     166644 ENST00000739947.1  381750
##  6 NAT2   10     166644 ENST00000739947.1  381753
##  7 NAT2   10     166645 ENST00000739948.1  381746
##  8 NAT2   10     166645 ENST00000739948.1  381751
##  9 NAT2   10     166645 ENST00000739948.1  381754
## 10 NAT2   10     166648 ENST00000739951.1  381749
## # ℹ more rows
```

`mapIds()` gets the mapped ids (column) for a set of keys that are of a
particular keytype. Usually returned as a named character vector.

```
mapIds(src, keys, column = "tx_name", keytype)
```

```
## Joining with `by = join_by(entrez)`
```

```
##                 ADA                NAT2
## "ENST00000372874.9" "ENST00000286479.4"
```

```
mapIds(src, keys, column = "tx_name", keytype, multiVals="CharacterList")
```

```
## Joining with `by = join_by(entrez)`
```

```
## CharacterList of length 2
## [["ADA"]] ENST00000372874.9 ENST00000464097.5 ... ENST00000696105.1
## [["NAT2"]] ENST00000286479.4 ENST00000520116.1 ... ENST00000739951.1
```

# 5 Genomic Coordinates Extractor Interfaces

Eleven genomic coordinates extractor methods are available in this
package: `transcripts()`, `exons()`, `cds()`, `genes()`,
`promoters()`, `transcriptsBy()`, `exonsBy()`, `cdsBy()`,
`intronsByTranscript()`, `fiveUTRsByTranscript()`,
`threeUTRsByTranscript()`. Data can be returned in two versions, for
instance *tibble* (`transcripts_tbl()`) and *GRanges* or *GRangesList*
(`transcripts()`).

Filters can be applied to all extractor functions. The output can be resctricted
by an `AnnotationFilter`, an `AnnotationFilterList`, or an expression that can
be tranlated into an `AnnotationFilterList`. Valid filters can be retrieved by
`supportedFilters(src)`.

```
supportedFilters(src)
```

```
##                filter        field
## 1        AccnumFilter       accnum
## 2         AliasFilter        alias
## 3      CdsChromFilter    cds_chrom
## 44       CdsEndFilter      cds_end
## 42        CdsIdFilter       cds_id
## 4       CdsNameFilter     cds_name
## 43     CdsStartFilter    cds_start
## 5     CdsStrandFilter   cds_strand
## 6       EnsemblFilter      ensembl
## 7   EnsemblprotFilter  ensemblprot
## 8  EnsembltransFilter ensembltrans
## 9        EntrezFilter       entrez
## 10       EnzymeFilter       enzyme
## 11     EvidenceFilter     evidence
## 12  EvidenceallFilter  evidenceall
## 13    ExonChromFilter   exon_chrom
## 47      ExonEndFilter     exon_end
## 45       ExonIdFilter      exon_id
## 14     ExonNameFilter    exon_name
## 48     ExonRankFilter    exon_rank
## 46    ExonStartFilter   exon_start
## 15   ExonStrandFilter  exon_strand
## 17    FlybaseCgFilter   flybase_cg
## 16      FlybaseFilter      flybase
## 18  FlybaseProtFilter flybase_prot
## 54      GRangesFilter      granges
## 19    GeneChromFilter   gene_chrom
## 50      GeneEndFilter     gene_end
## 49    GeneStartFilter   gene_start
## 20   GeneStrandFilter  gene_strand
## 21     GenenameFilter     genename
## 22           GoFilter           go
## 23        GoallFilter        goall
## 24          IpiFilter          ipi
## 25          MapFilter          map
## 26          MgiFilter          mgi
## 27         OmimFilter         omim
## 28     OntologyFilter     ontology
## 29  OntologyallFilter  ontologyall
## 30         PfamFilter         pfam
## 31         PmidFilter         pmid
## 32      PrositeFilter      prosite
## 33       RefseqFilter       refseq
## 34       SymbolFilter       symbol
## 35      TxChromFilter     tx_chrom
## 53        TxEndFilter       tx_end
## 51         TxIdFilter        tx_id
## 36       TxNameFilter      tx_name
## 52      TxStartFilter     tx_start
## 37     TxStrandFilter    tx_strand
## 38       TxTypeFilter      tx_type
## 39      UniprotFilter      uniprot
## 40     WormbaseFilter     wormbase
## 41         ZfinFilter         zfin
```

All filters take two parameters: value and condition, condition could
be one of “==”, “!=”, “startsWith”, “endsWith”, “>”, “<”, “>=” and
“<=”, default condition is “==”.

```
EnsemblFilter("ENSG00000196839")
```

```
## class: EnsemblFilter
## condition: ==
## value: ENSG00000196839
```

```
SymbolFilter("SNORD", "startsWith")
```

```
## class: SymbolFilter
## condition: startsWith
## value: SNORD
```

The following illustrates several ways of inputting filters to an extractor
function.

```
smbl <- SymbolFilter("SNORD", "startsWith")
transcripts_tbl(src, filter=smbl)
```

```
## # A tibble: 8 × 7
##   tx_chrom tx_start   tx_end tx_strand  tx_id tx_name           symbol
##   <chr>       <int>    <int> <chr>      <int> <chr>             <chr>
## 1 chr15    25051477 25051571 +         274740 ENST00000384335.1 SNORD116-1
## 2 chr15    25054210 25054304 +         274744 ENST00000384274.1 SNORD116-2
## 3 chr15    25056860 25056954 +         274745 ENST00000384287.1 SNORD116-3
## 4 chr15    25059538 25059633 +         274746 ENST00000384733.1 SNORD116-4
## 5 chr15    25062333 25062427 +         274748 ENST00000384462.1 SNORD116-5
## 6 chr15    25065026 25065121 +         274751 ENST00000384711.1 SNORD116-6
## 7 chr15    25067788 25067882 +         274760 ENST00000384404.1 SNORD116-7
## 8 chr15    25070432 25070526 +         274763 ENST00000384365.1 SNORD116-8
```

```
filter <- AnnotationFilterList(smbl)
transcripts_tbl(src, filter=filter)
```

```
## # A tibble: 8 × 7
##   tx_chrom tx_start   tx_end tx_strand  tx_id tx_name           symbol
##   <chr>       <int>    <int> <chr>      <int> <chr>             <chr>
## 1 chr15    25051477 25051571 +         274740 ENST00000384335.1 SNORD116-1
## 2 chr15    25054210 25054304 +         274744 ENST00000384274.1 SNORD116-2
## 3 chr15    25056860 25056954 +         274745 ENST00000384287.1 SNORD116-3
## 4 chr15    25059538 25059633 +         274746 ENST00000384733.1 SNORD116-4
## 5 chr15    25062333 25062427 +         274748 ENST00000384462.1 SNORD116-5
## 6 chr15    25065026 25065121 +         274751 ENST00000384711.1 SNORD116-6
## 7 chr15    25067788 25067882 +         274760 ENST00000384404.1 SNORD116-7
## 8 chr15    25070432 25070526 +         274763 ENST00000384365.1 SNORD116-8
```

```
transcripts_tbl(src, filter=~smbl)
```

```
## # A tibble: 8 × 7
##   tx_chrom tx_start   tx_end tx_strand  tx_id tx_name           symbol
##   <chr>       <int>    <int> <chr>      <int> <chr>             <chr>
## 1 chr15    25051477 25051571 +         274740 ENST00000384335.1 SNORD116-1
## 2 chr15    25054210 25054304 +         274744 ENST00000384274.1 SNORD116-2
## 3 chr15    25056860 25056954 +         274745 ENST00000384287.1 SNORD116-3
## 4 chr15    25059538 25059633 +         274746 ENST00000384733.1 SNORD116-4
## 5 chr15    25062333 25062427 +         274748 ENST00000384462.1 SNORD116-5
## 6 chr15    25065026 25065121 +         274751 ENST00000384711.1 SNORD116-6
## 7 chr15    25067788 25067882 +         274760 ENST00000384404.1 SNORD116-7
## 8 chr15    25070432 25070526 +         274763 ENST00000384365.1 SNORD116-8
```

A `GRangesFilter()` can also be used as a filter for the methods with
result displaying as *GRanges* or *GRangesList*.

```
gr <- GRangesFilter(GenomicRanges::GRanges("chr15:25062333-25065121"))
transcripts(src, filter=~smbl & gr)
```

```
## GRanges object with 2 ranges and 3 metadata columns:
##       seqnames            ranges strand |     tx_id           tx_name
##          <Rle>         <IRanges>  <Rle> | <integer>       <character>
##   [1]    chr15 25062333-25062427      + |    274748 ENST00000384462.1
##   [2]    chr15 25065026-25065121      + |    274751 ENST00000384711.1
##            symbol
##       <character>
##   [1]  SNORD116-5
##   [2]  SNORD116-6
##   -------
##   seqinfo: 711 sequences (1 circular) from hg38 genome
```

Filters in extractor functions support `&`, `|`, `!`(negation), and
`()`(grouping). Transcript coordinates of gene symbol equal to “ADA” and
transcript start position less than 44619810.

```
transcripts_tbl(src, filter = AnnotationFilterList(
    SymbolFilter("ADA"),
    TxStartFilter(44619810,"<"),
    logicOp="&")
)
```

```
## # A tibble: 53 × 7
##    tx_chrom tx_start   tx_end tx_strand  tx_id tx_name           symbol
##    <chr>       <int>    <int> <chr>      <int> <chr>             <chr>
##  1 chr20    44584896 44651702 -         357154 ENST00000696034.1 ADA
##  2 chr20    44618605 44651745 -         357155 ENST00000537820.2 ADA
##  3 chr20    44618618 44651699 -         357156 ENST00000696003.1 ADA
##  4 chr20    44618625 44651699 -         357157 ENST00000696004.1 ADA
##  5 chr20    44619521 44651678 -         357158 ENST00000695991.1 ADA
##  6 chr20    44619522 44621147 -         357159 ENST00000695956.1 ADA
##  7 chr20    44619522 44621347 -         357160 ENST00000696072.1 ADA
##  8 chr20    44619522 44623919 -         357161 ENST00000696073.1 ADA
##  9 chr20    44619522 44624329 -         357162 ENST00000696005.1 ADA
## 10 chr20    44619522 44624423 -         357163 ENST00000696074.1 ADA
## # ℹ 43 more rows
```

```
## Equivalent to
transcripts_tbl(src, filter = ~symbol == "ADA" & tx_start < 44619810)
```

```
## # A tibble: 53 × 7
##    tx_chrom tx_start   tx_end tx_strand  tx_id tx_name           symbol
##    <chr>       <int>    <int> <chr>      <int> <chr>             <chr>
##  1 chr20    44584896 44651702 -         357154 ENST00000696034.1 ADA
##  2 chr20    44618605 44651745 -         357155 ENST00000537820.2 ADA
##  3 chr20    44618618 44651699 -         357156 ENST00000696003.1 ADA
##  4 chr20    44618625 44651699 -         357157 ENST00000696004.1 ADA
##  5 chr20    44619521 44651678 -         357158 ENST00000695991.1 ADA
##  6 chr20    44619522 44621147 -         357159 ENST00000695956.1 ADA
##  7 chr20    44619522 44621347 -         357160 ENST00000696072.1 ADA
##  8 chr20    44619522 44623919 -         357161 ENST00000696073.1 ADA
##  9 chr20    44619522 44624329 -         357162 ENST00000696005.1 ADA
## 10 chr20    44619522 44624423 -         357163 ENST00000696074.1 ADA
## # ℹ 43 more rows
```

Transcripts coordinates of gene symbol equal to “ADA” or transcript end
position equal to 243843236.

```
txend <- TxEndFilter(243843236, '==')
transcripts_tbl(src, filter = ~symbol == "ADA" | txend)
```

```
## # A tibble: 62 × 7
##    tx_chrom  tx_start    tx_end tx_strand  tx_id tx_name           symbol
##    <chr>        <int>     <int> <chr>      <int> <chr>             <chr>
##  1 chr1     243488233 243843236 -          34766 ENST00000336199.9 AKT3
##  2 chr20     44584896  44651702 -         357154 ENST00000696034.1 ADA
##  3 chr20     44618605  44651745 -         357155 ENST00000537820.2 ADA
##  4 chr20     44618618  44651699 -         357156 ENST00000696003.1 ADA
##  5 chr20     44618625  44651699 -         357157 ENST00000696004.1 ADA
##  6 chr20     44619521  44651678 -         357158 ENST00000695991.1 ADA
##  7 chr20     44619522  44621147 -         357159 ENST00000695956.1 ADA
##  8 chr20     44619522  44621347 -         357160 ENST00000696072.1 ADA
##  9 chr20     44619522  44623919 -         357161 ENST00000696073.1 ADA
## 10 chr20     44619522  44624329 -         357162 ENST00000696005.1 ADA
## # ℹ 52 more rows
```

Using negation to find transcript coordinates of gene symbol equal to “ADA” and
transcript start positions NOT less than 44619810.

```
transcripts_tbl(src, filter = ~symbol == "ADA" & !tx_start < 44618910)
```

```
## # A tibble: 57 × 7
##    tx_chrom tx_start   tx_end tx_strand  tx_id tx_name           symbol
##    <chr>       <int>    <int> <chr>      <int> <chr>             <chr>
##  1 chr20    44619521 44651678 -         357158 ENST00000695991.1 ADA
##  2 chr20    44619522 44621147 -         357159 ENST00000695956.1 ADA
##  3 chr20    44619522 44621347 -         357160 ENST00000696072.1 ADA
##  4 chr20    44619522 44623919 -         357161 ENST00000696073.1 ADA
##  5 chr20    44619522 44624329 -         357162 ENST00000696005.1 ADA
##  6 chr20    44619522 44624423 -         357163 ENST00000696074.1 ADA
##  7 chr20    44619522 44626491 -         357164 ENST00000464097.5 ADA
##  8 chr20    44619522 44626927 -         357165 ENST00000696035.1 ADA
##  9 chr20    44619522 44627507 -         357166 ENST00000696036.1 ADA
## 10 chr20    44619522 44628494 -         357167 ENST00000696037.1 ADA
## # ℹ 47 more rows
```

Using grouping to find transcript coordinates of a long filter statement.

```
transcripts_tbl(src,
    filter = ~(symbol == 'ADA' & !(tx_start >= 44619810 | tx_end < 44651742)) |
              (smbl & !tx_end > 25056954)
)
```

```
## # A tibble: 10 × 7
##    tx_chrom tx_start   tx_end tx_strand  tx_id tx_name           symbol
##    <chr>       <int>    <int> <chr>      <int> <chr>             <chr>
##  1 chr15    25051477 25051571 +         274740 ENST00000384335.1 SNORD116-1
##  2 chr15    25054210 25054304 +         274744 ENST00000384274.1 SNORD116-2
##  3 chr15    25056860 25056954 +         274745 ENST00000384287.1 SNORD116-3
##  4 chr20    44618605 44651745 -         357155 ENST00000537820.2 ADA
##  5 chr20    44619522 44651743 -         357185 ENST00000696078.1 ADA
##  6 chr20    44619522 44652215 -         357186 ENST00000696062.1 ADA
##  7 chr20    44619522 44652220 -         357187 ENST00000536076.2 ADA
##  8 chr20    44619596 44652252 -         357204 ENST00000696064.1 ADA
##  9 chr20    44619606 44652222 -         357205 ENST00000696039.1 ADA
## 10 chr20    44619656 44651915 -         357206 ENST00000696065.1 ADA
```

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] ggplot2_4.0.0           GenomicRanges_1.61.5    Seqinfo_0.99.2
##  [4] IRanges_2.43.5          S4Vectors_0.47.4        BiocGenerics_0.55.1
##  [7] generics_0.1.4          Organism.dplyr_1.37.1   AnnotationFilter_1.33.0
## [10] dplyr_1.1.4             BiocStyle_2.37.1
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            farver_2.1.2
##  [3] blob_1.2.4                  filelock_1.0.3
##  [5] Biostrings_2.77.2           S7_0.2.0
##  [7] bitops_1.0-9                fastmap_1.2.0
##  [9] lazyeval_0.2.2              RCurl_1.98-1.17
## [11] BiocFileCache_2.99.6        GenomicAlignments_1.45.4
## [13] XML_3.99-0.19               digest_0.6.37
## [15] lifecycle_1.0.4             KEGGREST_1.49.1
## [17] RSQLite_2.4.3               magrittr_2.0.4
## [19] compiler_4.5.1              rlang_1.1.6
## [21] sass_0.4.10                 tools_4.5.1
## [23] utf8_1.2.6                  yaml_2.3.10
## [25] rtracklayer_1.69.1          knitr_1.50
## [27] labeling_0.4.3              S4Arrays_1.9.1
## [29] bit_4.6.0                   curl_7.0.0
## [31] DelayedArray_0.35.3         RColorBrewer_1.1-3
## [33] abind_1.4-8                 BiocParallel_1.43.4
## [35] purrr_1.1.0                 withr_3.0.2
## [37] grid_4.5.1                  scales_1.4.0
## [39] tinytex_0.57                dichromat_2.0-0.1
## [41] SummarizedExperiment_1.39.2 cli_3.6.5
## [43] rmarkdown_2.30              crayon_1.5.3
## [45] httr_1.4.7                  rjson_0.2.23
## [47] DBI_1.2.3                   cachem_1.1.0
## [49] parallel_4.5.1              AnnotationDbi_1.71.1
## [51] BiocManager_1.30.26         XVector_0.49.1
## [53] restfulr_0.0.16             matrixStats_1.5.0
## [55] vctrs_0.6.5                 Matrix_1.7-4
## [57] jsonlite_2.0.0              bookdown_0.45
## [59] bit64_4.6.0-1               magick_2.9.0
## [61] GenomicFeatures_1.61.6      jquerylib_0.1.4
## [63] glue_1.8.0                  codetools_0.2-20
## [65] gtable_0.3.6                BiocIO_1.19.0
## [67] tibble_3.3.0                pillar_1.11.1
## [69] rappdirs_0.3.3              htmltools_0.5.8.1
## [71] R6_2.6.1                    dbplyr_2.5.1
## [73] httr2_1.2.1                 evaluate_1.0.5
## [75] Biobase_2.69.1              lattice_0.22-7
## [77] png_0.1-8                   Rsamtools_2.25.3
## [79] memoise_2.0.1               bslib_0.9.0
## [81] Rcpp_1.1.0                  SparseArray_1.9.1
## [83] xfun_0.53                   MatrixGenerics_1.21.0
## [85] pkgconfig_2.0.3
```