# Querying protein features

Johannes Rainer

#### 29 October 2025

#### Package

ensembldb 2.34.0

# 1 Introduction

From Bioconductor release 3.5 on, `EnsDb` databases/packages created by the
`ensembldb` package contain also, for transcripts with a coding regions, mappings
between transcripts and proteins. Thus, in addition to the RNA/DNA-based
features also the following protein related information is available:

* `protein_id`: the Ensembl protein ID. This is the primary ID for the proteins
  defined in Ensembl and each (protein coding) Ensembl transcript has one
  protein ID assigned to it.
* `protein_sequence`: the amino acid sequence of a protein.
* `uniprot_id`: the Uniprot ID for a protein. Note that not every Ensembl
  `protein_id` has an Uniprot ID, and each `protein_id` might be mapped to several
  `uniprot_id`. Also, the same Uniprot ID might be mapped to different `protein_id`.
* `uniprot_db`: the name of the Uniprot database in which the feature is
  annotated. Can be either *SPTREMBL* or *SWISSPROT*.
* `uniprot_mapping_type`: the type of the mapping method that was used to assign
  the Uniprot ID to the Ensembl protein ID.
* `protein_domain_id`: the ID of the protein domain according to the
  source/analysis in/by which is was defined.
* `protein_domain_source`: the source of the protein domain information, one of
  *pfscan*, *scanprosite*, *superfamily*, *pfam*, *prints*, *smart*, *pirsf* or *tigrfam*.
* `interpro_accession`: the Interpro accession ID of the protein domain (if
  available).
* `prot_dom_start`: the start of the protein domain within the sequence of
  the protein.
* `prot_dom_start`: the end position of the protein domain within the
  sequence of the protein.

Thus, for protein coding transcripts, these annotations can be fetched from the
database too, given that protein annotations are available. Note that only `EnsDb`
databases created through the Ensembl Perl API contain protein annotation, while
databases created using `ensDbFromAH`, `ensDbFromGff`, `ensDbFromGRanges` and
`ensDbFromGtf` don’t.

```
library(ensembldb)
library(EnsDb.Hsapiens.v86)
edb <- EnsDb.Hsapiens.v86
## Evaluate whether we have protein annotation available
hasProteinData(edb)
```

```
## [1] TRUE
```

If protein annotation is available, the additional tables and columns are also
listed by the `listTables` and `listColumns` methods.

```
listTables(edb)
```

```
## $gene
## [1] "gene_id"          "gene_name"        "gene_biotype"     "gene_seq_start"
## [5] "gene_seq_end"     "seq_name"         "seq_strand"       "seq_coord_system"
## [9] "symbol"
##
## $tx
## [1] "tx_id"            "tx_biotype"       "tx_seq_start"     "tx_seq_end"
## [5] "tx_cds_seq_start" "tx_cds_seq_end"   "gene_id"          "tx_name"
##
## $tx2exon
## [1] "tx_id"    "exon_id"  "exon_idx"
##
## $exon
## [1] "exon_id"        "exon_seq_start" "exon_seq_end"
##
## $chromosome
## [1] "seq_name"    "seq_length"  "is_circular"
##
## $protein
## [1] "tx_id"            "protein_id"       "protein_sequence"
##
## $uniprot
## [1] "protein_id"           "uniprot_id"           "uniprot_db"
## [4] "uniprot_mapping_type"
##
## $protein_domain
## [1] "protein_id"            "protein_domain_id"     "protein_domain_source"
## [4] "interpro_accession"    "prot_dom_start"        "prot_dom_end"
##
## $entrezgene
## [1] "gene_id"  "entrezid"
##
## $metadata
## [1] "name"  "value"
```

In the following sections we show examples how to 1) fetch protein annotations
as additional columns to gene/transcript annotations, 2) fetch protein
annotation data and 3) map proteins to the genome.

# 2 Fetch protein annotation for genes and transcripts

Protein annotations for (protein coding) transcripts can be retrieved by simply
adding the desired annotation columns to the `columns` parameter of the e.g. `genes`
or `transcripts` methods.

```
## Get also protein information for ZBTB16 transcripts
txs <- transcripts(edb, filter = GeneNameFilter("ZBTB16"),
           columns = c("protein_id", "uniprot_id", "tx_biotype"))
txs
```

```
## GRanges object with 11 ranges and 5 metadata columns:
##                   seqnames              ranges strand |      protein_id
##                      <Rle>           <IRanges>  <Rle> |     <character>
##   ENST00000335953       11 114059593-114250676      + | ENSP00000338157
##   ENST00000335953       11 114059593-114250676      + | ENSP00000338157
##   ENST00000541602       11 114059725-114189764      + |            <NA>
##   ENST00000544220       11 114059737-114063646      + | ENSP00000437716
##   ENST00000535700       11 114060257-114063744      + | ENSP00000443013
##   ENST00000392996       11 114060507-114250652      + | ENSP00000376721
##   ENST00000392996       11 114060507-114250652      + | ENSP00000376721
##   ENST00000539918       11 114064412-114247344      + | ENSP00000445047
##   ENST00000545851       11 114180766-114247296      + |            <NA>
##   ENST00000535379       11 114237207-114250557      + |            <NA>
##   ENST00000535509       11 114246790-114250476      + |            <NA>
##                    uniprot_id             tx_biotype           tx_id
##                   <character>            <character>     <character>
##   ENST00000335953      Q05516         protein_coding ENST00000335953
##   ENST00000335953  A0A024R3C6         protein_coding ENST00000335953
##   ENST00000541602        <NA>        retained_intron ENST00000541602
##   ENST00000544220      F5H6C3         protein_coding ENST00000544220
##   ENST00000535700      F5H5Y7         protein_coding ENST00000535700
##   ENST00000392996      Q05516         protein_coding ENST00000392996
##   ENST00000392996  A0A024R3C6         protein_coding ENST00000392996
##   ENST00000539918      H0YGW2 nonsense_mediated_de.. ENST00000539918
##   ENST00000545851        <NA>   processed_transcript ENST00000545851
##   ENST00000535379        <NA>   processed_transcript ENST00000535379
##   ENST00000535509        <NA>        retained_intron ENST00000535509
##                     gene_name
##                   <character>
##   ENST00000335953      ZBTB16
##   ENST00000335953      ZBTB16
##   ENST00000541602      ZBTB16
##   ENST00000544220      ZBTB16
##   ENST00000535700      ZBTB16
##   ENST00000392996      ZBTB16
##   ENST00000392996      ZBTB16
##   ENST00000539918      ZBTB16
##   ENST00000545851      ZBTB16
##   ENST00000535379      ZBTB16
##   ENST00000535509      ZBTB16
##   -------
##   seqinfo: 1 sequence from GRCh38 genome
```

The gene ZBTB16 has protein coding and non-coding transcripts, thus, we get the
protein ID for the coding- and `NA` for the non-coding transcripts. Note also that
we have a transcript targeted for nonsense mediated mRNA-decay with a protein ID
associated with it, but no Uniprot ID.

```
## Subset to transcripts with tx_biotype other than protein_coding.
txs[txs$tx_biotype != "protein_coding", c("uniprot_id", "tx_biotype",
                      "protein_id")]
```

```
## GRanges object with 5 ranges and 3 metadata columns:
##                   seqnames              ranges strand |  uniprot_id
##                      <Rle>           <IRanges>  <Rle> | <character>
##   ENST00000541602       11 114059725-114189764      + |        <NA>
##   ENST00000539918       11 114064412-114247344      + |      H0YGW2
##   ENST00000545851       11 114180766-114247296      + |        <NA>
##   ENST00000535379       11 114237207-114250557      + |        <NA>
##   ENST00000535509       11 114246790-114250476      + |        <NA>
##                               tx_biotype      protein_id
##                              <character>     <character>
##   ENST00000541602        retained_intron            <NA>
##   ENST00000539918 nonsense_mediated_de.. ENSP00000445047
##   ENST00000545851   processed_transcript            <NA>
##   ENST00000535379   processed_transcript            <NA>
##   ENST00000535509        retained_intron            <NA>
##   -------
##   seqinfo: 1 sequence from GRCh38 genome
```

While the mapping from a protein coding transcript to a Ensembl protein ID
(column `protein_id`) is 1:1, the mapping between `protein_id` and `uniprot_id` can be
n:m, i.e. each Ensembl protein ID can be mapped to 1 or more Uniprot IDs and
each Uniprot ID can be mapped to more than one `protein_id` (and hence
`tx_id`). This should be kept in mind if querying transcripts from the database
fetching Uniprot related additional columns or even protein ID features, as in
such cases a redundant list of transcripts is returned.

```
## List the protein IDs and uniprot IDs for the coding transcripts
mcols(txs[txs$tx_biotype == "protein_coding",
      c("tx_id", "protein_id", "uniprot_id")])
```

```
## DataFrame with 6 rows and 3 columns
##                           tx_id      protein_id  uniprot_id
##                     <character>     <character> <character>
## ENST00000335953 ENST00000335953 ENSP00000338157      Q05516
## ENST00000335953 ENST00000335953 ENSP00000338157  A0A024R3C6
## ENST00000544220 ENST00000544220 ENSP00000437716      F5H6C3
## ENST00000535700 ENST00000535700 ENSP00000443013      F5H5Y7
## ENST00000392996 ENST00000392996 ENSP00000376721      Q05516
## ENST00000392996 ENST00000392996 ENSP00000376721  A0A024R3C6
```

Some of the n:m mappings for Uniprot IDs can be resolved by restricting either
to entries from one Uniprot database (*SPTREMBL* or *SWISSPROT*) or to mappings of a
certain type of mapping method. The corresponding filters are the
`UniprotDbFilter` and the `UniprotMappingTypeFilter` (using the `uniprot_db` and
`uniprot_mapping_type` columns of the `uniprot` database table). In the example
below we restrict the result to Uniprot IDs with the mapping type *DIRECT*.

```
## List all uniprot mapping types in the database.
listUniprotMappingTypes(edb)
```

```
## [1] "DIRECT"         "SEQUENCE_MATCH"
```

```
## Get all protein_coding transcripts of ZBTB16 along with their protein_id
## and Uniprot IDs, restricting to protein_id to uniprot_id mappings based
## on "DIRECT" mapping methods.
txs <- transcripts(edb, filter = list(GeneNameFilter("ZBTB16"),
                      UniprotMappingTypeFilter("DIRECT")),
           columns = c("protein_id", "uniprot_id", "uniprot_db"))
mcols(txs)
```

```
## DataFrame with 5 rows and 6 columns
##                      protein_id  uniprot_id  uniprot_db           tx_id
##                     <character> <character> <character>     <character>
## ENST00000335953 ENSP00000338157      Q05516   SWISSPROT ENST00000335953
## ENST00000544220 ENSP00000437716      F5H6C3    SPTREMBL ENST00000544220
## ENST00000535700 ENSP00000443013      F5H5Y7    SPTREMBL ENST00000535700
## ENST00000392996 ENSP00000376721      Q05516   SWISSPROT ENST00000392996
## ENST00000539918 ENSP00000445047      H0YGW2    SPTREMBL ENST00000539918
##                   gene_name uniprot_mapping_type
##                 <character>          <character>
## ENST00000335953      ZBTB16               DIRECT
## ENST00000544220      ZBTB16               DIRECT
## ENST00000535700      ZBTB16               DIRECT
## ENST00000392996      ZBTB16               DIRECT
## ENST00000539918      ZBTB16               DIRECT
```

For this example the use of the `UniprotMappingTypeFilter` resolved the multiple
mapping of Uniprot IDs to Ensembl protein IDs, but the Uniprot ID *Q05516* is
still assigned to the two Ensembl protein IDs *ENSP00000338157* and
*ENSP00000376721*.

All protein annotations can also be added as *metadata columns* to the
results of the `genes`, `exons`, `exonsBy`, `transcriptsBy`, `cdsBy`, `fiveUTRsByTranscript`
and `threeUTRsByTranscript` methods by specifying the desired column names with
the `columns` parameter. For non coding transcripts `NA` will be reported in the
protein annotation columns.

In addition to retrieve protein annotations from the database, we can also use
protein data to filter the results. In the example below we fetch for example
all genes from the database that have a certain protein domain in the protein
encoded by any of its transcripts.

```
## Get all genes encoded on chromosome 11 which protein contains
## a certain protein domain.
gns <- genes(edb, filter = ~ prot_dom_id == "PS50097" & seq_name == "11")
length(gns)
```

```
## [1] 9
```

```
sort(gns$gene_name)
```

```
## [1] "ABTB2"  "BTBD18" "KBTBD3" "KBTBD4" "KCTD21" "KLHL35" "ZBTB16" "ZBTB3"
## [9] "ZBTB44"
```

So, in total we got 152 genes with that protein domain. In addition to the
`ProtDomIdFilter`, also the `ProteinidFilter` and the `UniprotidFilter` can be used to
query the database for entries matching conditions on their protein ID or
Uniprot ID.

# 3 Use methods from the `AnnotationDbi` package to query protein annotation

The `select`, `keys` and `mapIds` methods from the `AnnotationDbi` package can also be
used to query `EnsDb` objects for protein annotations. Supported columns and
key types are returned by the `columns` and `keytypes` methods.

```
## Show all columns that are provided by the database
columns(edb)
```

```
##  [1] "ENTREZID"            "EXONID"              "EXONIDX"
##  [4] "EXONSEQEND"          "EXONSEQSTART"        "GENEBIOTYPE"
##  [7] "GENEID"              "GENENAME"            "GENESEQEND"
## [10] "GENESEQSTART"        "INTERPROACCESSION"   "ISCIRCULAR"
## [13] "PROTDOMEND"          "PROTDOMSTART"        "PROTEINDOMAINID"
## [16] "PROTEINDOMAINSOURCE" "PROTEINID"           "PROTEINSEQUENCE"
## [19] "SEQCOORDSYSTEM"      "SEQLENGTH"           "SEQNAME"
## [22] "SEQSTRAND"           "SYMBOL"              "TXBIOTYPE"
## [25] "TXCDSSEQEND"         "TXCDSSEQSTART"       "TXID"
## [28] "TXNAME"              "TXSEQEND"            "TXSEQSTART"
## [31] "UNIPROTDB"           "UNIPROTID"           "UNIPROTMAPPINGTYPE"
```

```
## Show all key types/filters that are supported
keytypes(edb)
```

```
##  [1] "ENTREZID"            "EXONID"              "GENEBIOTYPE"
##  [4] "GENEID"              "GENENAME"            "PROTDOMID"
##  [7] "PROTEINDOMAINID"     "PROTEINDOMAINSOURCE" "PROTEINID"
## [10] "SEQNAME"             "SEQSTRAND"           "SYMBOL"
## [13] "TXBIOTYPE"           "TXID"                "TXNAME"
## [16] "UNIPROTID"
```

Below we fetch all Uniprot IDs annotated to the gene *ZBTB16*.

```
select(edb, keys = "ZBTB16", keytype = "GENENAME",
       columns = "UNIPROTID")
```

```
##   GENENAME  UNIPROTID
## 1   ZBTB16     Q05516
## 2   ZBTB16 A0A024R3C6
## 3   ZBTB16       <NA>
## 4   ZBTB16     F5H6C3
## 5   ZBTB16     F5H5Y7
## 6   ZBTB16     H0YGW2
```

This returns us all Uniprot IDs of all proteins encoded by the gene’s
transcripts. One of the transcripts from ZBTB16, while having a CDS and being
annotated to a protein, does not have an Uniprot ID assigned (thus `NA` is
returned by the above call). As we see below, this transcript is targeted for
non sense mediated mRNA decay.

```
## Call select, this time providing a GeneNameFilter.
select(edb, keys = GeneNameFilter("ZBTB16"),
       columns = c("TXBIOTYPE", "UNIPROTID", "PROTEINID"))
```

```
##                 TXBIOTYPE  UNIPROTID       PROTEINID GENENAME
## 1          protein_coding     Q05516 ENSP00000338157   ZBTB16
## 2          protein_coding A0A024R3C6 ENSP00000338157   ZBTB16
## 3         retained_intron       <NA>            <NA>   ZBTB16
## 4          protein_coding     F5H6C3 ENSP00000437716   ZBTB16
## 5          protein_coding     F5H5Y7 ENSP00000443013   ZBTB16
## 6          protein_coding     Q05516 ENSP00000376721   ZBTB16
## 7          protein_coding A0A024R3C6 ENSP00000376721   ZBTB16
## 8 nonsense_mediated_decay     H0YGW2 ENSP00000445047   ZBTB16
## 9    processed_transcript       <NA>            <NA>   ZBTB16
```

Note also that we passed this time a `GeneMameFilter` with the `keys` parameter.

# 4 Retrieve proteins from the database

Proteins can be fetched using the dedicated `proteins` method that returns, unlike
DNA/RNA-based methods like `genes` or `transcripts`, not a `GRanges` object by
default, but a `DataFrame` object. Alternatively, results can be returned as a
`data.frame` or as an `AAStringSet` object from the `Biobase` package. Note that this
might change in future releases if a more appropriate object to represent
protein annotations becomes available.

In the code chunk below we fetch all protein annotations for the gene *ZBTB16*.

```
## Get all proteins and return them as an AAStringSet
prts <- proteins(edb, filter = GeneNameFilter("ZBTB16"),
         return.type = "AAStringSet")
prts
```

```
## AAStringSet object of length 5:
##     width seq                                               names
## [1]   673 MDLTKMGMIQLQNPSHPTGLLCK...GHKPEEIPPDWRIEKTYLYLCYV ENSP00000338157
## [2]   115 MDLTKMGMIQLQNPSHPTGLLCK...QAKAEDLDDLLYAAEILEIEYLE ENSP00000437716
## [3]   148 MDLTKMGMIQLQNPSHPTGLLCK...QASDDNDTEATMADGGAEEEEDR ENSP00000443013
## [4]   673 MDLTKMGMIQLQNPSHPTGLLCK...GHKPEEIPPDWRIEKTYLYLCYV ENSP00000376721
## [5]    55 XGGLLPQGFIQRELFSKLGELAV...GEQCSVCGVELPDNEAVEQHRVF ENSP00000445047
```

Besides the amino acid sequence, the `prts` contains also additional annotations
that can be accessed with the `mcols` method (metadata columns). All additional
columns provided with the parameter `columns` are also added to the `mcols`
`DataFrame`.

```
mcols(prts)
```

```
## DataFrame with 5 rows and 3 columns
##                           tx_id      protein_id   gene_name
##                     <character>     <character> <character>
## ENSP00000338157 ENST00000335953 ENSP00000338157      ZBTB16
## ENSP00000437716 ENST00000544220 ENSP00000437716      ZBTB16
## ENSP00000443013 ENST00000535700 ENSP00000443013      ZBTB16
## ENSP00000376721 ENST00000392996 ENSP00000376721      ZBTB16
## ENSP00000445047 ENST00000539918 ENSP00000445047      ZBTB16
```

Note that the `proteins` method will retrieve only gene/transcript annotations of
transcripts encoding a protein. Thus annotations for the non-coding transcripts
of the gene *ZBTB16*, that were returned by calls to `genes` or `transcripts` in the
previous section are not fetched.

Querying in addition Uniprot identifiers or protein domain data will result at
present in a redundant list of proteins as shown in the code block below.

```
## Get also protein domain annotations in addition to the protein annotations.
pd <- proteins(edb, filter = GeneNameFilter("ZBTB16"),
           columns = c("tx_id", listColumns(edb, "protein_domain")),
           return.type = "AAStringSet")
pd
```

```
## AAStringSet object of length 81:
##      width seq                                              names
##  [1]   673 MDLTKMGMIQLQNPSHPTGLLCK...HKPEEIPPDWRIEKTYLYLCYV ENSP00000338157
##  [2]   673 MDLTKMGMIQLQNPSHPTGLLCK...HKPEEIPPDWRIEKTYLYLCYV ENSP00000338157
##  [3]   673 MDLTKMGMIQLQNPSHPTGLLCK...HKPEEIPPDWRIEKTYLYLCYV ENSP00000338157
##  [4]   673 MDLTKMGMIQLQNPSHPTGLLCK...HKPEEIPPDWRIEKTYLYLCYV ENSP00000338157
##  [5]   673 MDLTKMGMIQLQNPSHPTGLLCK...HKPEEIPPDWRIEKTYLYLCYV ENSP00000338157
##  ...   ... ...
## [77]   673 MDLTKMGMIQLQNPSHPTGLLCK...HKPEEIPPDWRIEKTYLYLCYV ENSP00000376721
## [78]   673 MDLTKMGMIQLQNPSHPTGLLCK...HKPEEIPPDWRIEKTYLYLCYV ENSP00000376721
## [79]   673 MDLTKMGMIQLQNPSHPTGLLCK...HKPEEIPPDWRIEKTYLYLCYV ENSP00000376721
## [80]   673 MDLTKMGMIQLQNPSHPTGLLCK...HKPEEIPPDWRIEKTYLYLCYV ENSP00000376721
## [81]    55 XGGLLPQGFIQRELFSKLGELAV...EQCSVCGVELPDNEAVEQHRVF ENSP00000445047
```

The result contains one row/element for each protein domain in each of the
proteins. The number of protein domains per protein and the `mcols` are shown
below.

```
## The number of protein domains per protein:
table(names(pd))
```

```
##
## ENSP00000338157 ENSP00000376721 ENSP00000437716 ENSP00000443013 ENSP00000445047
##              36              36               4               4               1
```

```
## The mcols
mcols(pd)
```

```
## DataFrame with 81 rows and 8 columns
##                           tx_id      protein_id protein_domain_id
##                     <character>     <character>       <character>
## ENSP00000338157 ENST00000335953 ENSP00000338157           PS50157
## ENSP00000338157 ENST00000335953 ENSP00000338157           PS50157
## ENSP00000338157 ENST00000335953 ENSP00000338157           PS50157
## ENSP00000338157 ENST00000335953 ENSP00000338157           PS50157
## ENSP00000338157 ENST00000335953 ENSP00000338157           PS50157
## ...                         ...             ...               ...
## ENSP00000376721 ENST00000392996 ENSP00000376721           SM00355
## ENSP00000376721 ENST00000392996 ENSP00000376721           SM00355
## ENSP00000376721 ENST00000392996 ENSP00000376721           SM00355
## ENSP00000376721 ENST00000392996 ENSP00000376721           SM00355
## ENSP00000445047 ENST00000539918 ENSP00000445047                NA
##                 protein_domain_source interpro_accession prot_dom_start
##                           <character>        <character>      <integer>
## ENSP00000338157                pfscan          IPR007087            602
## ENSP00000338157                pfscan          IPR007087            490
## ENSP00000338157                pfscan          IPR007087            630
## ENSP00000338157                pfscan          IPR007087            432
## ENSP00000338157                pfscan          IPR007087            546
## ...                               ...                ...            ...
## ENSP00000376721                 smart          IPR015880            546
## ENSP00000376721                 smart          IPR015880            574
## ENSP00000376721                 smart          IPR015880            602
## ENSP00000376721                 smart          IPR015880            630
## ENSP00000445047                    NA                 NA             NA
##                 prot_dom_end   gene_name
##                    <integer> <character>
## ENSP00000338157          629      ZBTB16
## ENSP00000338157          517      ZBTB16
## ENSP00000338157          657      ZBTB16
## ENSP00000338157          459      ZBTB16
## ENSP00000338157          573      ZBTB16
## ...                      ...         ...
## ENSP00000376721          568      ZBTB16
## ENSP00000376721          596      ZBTB16
## ENSP00000376721          624      ZBTB16
## ENSP00000376721          652      ZBTB16
## ENSP00000445047           NA      ZBTB16
```

As we can see each protein can have several protein domains with the start and
end coordinates within the amino acid sequence being reported in columns
`prot_dom_start` and `prot_dom_end`. Also, not all Ensembl protein IDs, like
`protein_id` *ENSP00000445047* are mapped to an Uniprot ID or have protein domains.

# 5 Map peptide features within proteins to the genome

The *coordinate-mapping.Rmd* vignette provides a detailed description of all
functions that allow to map between genomic, transcript and protein coordinates.

# 6 Session information

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] AnnotationHub_4.0.0
##  [2] BiocFileCache_3.0.0
##  [3] dbplyr_2.5.1
##  [4] BSgenome.Hsapiens.NCBI.GRCh38_1.3.1000
##  [5] BSgenome_1.78.0
##  [6] rtracklayer_1.70.0
##  [7] BiocIO_1.20.0
##  [8] Biostrings_2.78.0
##  [9] XVector_0.50.0
## [10] Gviz_1.54.0
## [11] EnsDb.Hsapiens.v86_2.99.0
## [12] ensembldb_2.34.0
## [13] AnnotationFilter_1.34.0
## [14] GenomicFeatures_1.62.0
## [15] AnnotationDbi_1.72.0
## [16] Biobase_2.70.0
## [17] GenomicRanges_1.62.0
## [18] Seqinfo_1.0.0
## [19] IRanges_2.44.0
## [20] S4Vectors_0.48.0
## [21] BiocGenerics_0.56.0
## [22] generics_0.1.4
## [23] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              magrittr_2.0.4
##   [5] magick_2.9.0                farver_2.1.2
##   [7] rmarkdown_2.30              vctrs_0.6.5
##   [9] memoise_2.0.1               Rsamtools_2.26.0
##  [11] RCurl_1.98-1.17             base64enc_0.1-3
##  [13] tinytex_0.57                htmltools_0.5.8.1
##  [15] S4Arrays_1.10.0             progress_1.2.3
##  [17] curl_7.0.0                  SparseArray_1.10.0
##  [19] Formula_1.2-5               sass_0.4.10
##  [21] bslib_0.9.0                 htmlwidgets_1.6.4
##  [23] httr2_1.2.1                 cachem_1.1.0
##  [25] GenomicAlignments_1.46.0    lifecycle_1.0.4
##  [27] pkgconfig_2.0.3             Matrix_1.7-4
##  [29] R6_2.6.1                    fastmap_1.2.0
##  [31] MatrixGenerics_1.22.0       digest_0.6.37
##  [33] colorspace_2.1-2            Hmisc_5.2-4
##  [35] RSQLite_2.4.3               filelock_1.0.3
##  [37] httr_1.4.7                  abind_1.4-8
##  [39] compiler_4.5.1              withr_3.0.2
##  [41] bit64_4.6.0-1               htmlTable_2.4.3
##  [43] S7_0.2.0                    backports_1.5.0
##  [45] BiocParallel_1.44.0         DBI_1.2.3
##  [47] biomaRt_2.66.0              rappdirs_0.3.3
##  [49] DelayedArray_0.36.0         rjson_0.2.23
##  [51] tools_4.5.1                 foreign_0.8-90
##  [53] nnet_7.3-20                 glue_1.8.0
##  [55] restfulr_0.0.16             checkmate_2.3.3
##  [57] cluster_2.1.8.1             gtable_0.3.6
##  [59] data.table_1.17.8           hms_1.1.4
##  [61] BiocVersion_3.22.0          pillar_1.11.1
##  [63] stringr_1.5.2               dplyr_1.1.4
##  [65] lattice_0.22-7              bit_4.6.0
##  [67] deldir_2.0-4                biovizBase_1.58.0
##  [69] tidyselect_1.2.1            knitr_1.50
##  [71] gridExtra_2.3               bookdown_0.45
##  [73] ProtGenerics_1.42.0         SummarizedExperiment_1.40.0
##  [75] xfun_0.53                   matrixStats_1.5.0
##  [77] stringi_1.8.7               UCSC.utils_1.6.0
##  [79] lazyeval_0.2.2              yaml_2.3.10
##  [81] evaluate_1.0.5              codetools_0.2-20
##  [83] cigarillo_1.0.0             interp_1.1-6
##  [85] tibble_3.3.0                BiocManager_1.30.26
##  [87] cli_3.6.5                   rpart_4.1.24
##  [89] jquerylib_0.1.4             dichromat_2.0-0.1
##  [91] Rcpp_1.1.0                  GenomeInfoDb_1.46.0
##  [93] png_0.1-8                   XML_3.99-0.19
##  [95] parallel_4.5.1              ggplot2_4.0.0
##  [97] blob_1.2.4                  prettyunits_1.2.0
##  [99] latticeExtra_0.6-31         jpeg_0.1-11
## [101] bitops_1.0-9                VariantAnnotation_1.56.0
## [103] scales_1.4.0                purrr_1.1.0
## [105] crayon_1.5.3                rlang_1.1.6
## [107] KEGGREST_1.50.0
```