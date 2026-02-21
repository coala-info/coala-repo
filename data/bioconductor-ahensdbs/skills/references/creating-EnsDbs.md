# Provide EnsDb databases for AnnotationHub

Johannes Rainer

#### 13 November 2024

#### Package

AHEnsDbs 1.7.0

**Authors**: Johannes Rainer
**Last modified:** 2024-11-13 06:00:21.281566
**Compiled**: Wed Nov 13 06:32:02 2024

# 1 Fetch `EnsDb` databases from `AnnotationHub`

The `AHEnsDbs` package provides the metadata for all `EnsDb` SQLite databases in
*[AnnotationHub](https://bioconductor.org/packages/3.21/AnnotationHub)*. First we load/update the `AnnotationHub` resource.

```
library(AnnotationHub)
ah <- AnnotationHub()
```

Next we list all `EnsDb` entries from `AnnotationHub`.

```
query(ah, "EnsDb")
```

```
## AnnotationHub with 4960 records
## # snapshotDate(): 2024-10-24
## # $dataprovider: Ensembl
## # $species: Sus scrofa, Mus musculus, Rattus norvegicus, Gallus gallus, Oryz...
## # $rdataclass: EnsDb
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH53185"]]'
##
##              title
##   AH53185  | Ensembl 87 EnsDb for Anolis Carolinensis
##   AH53186  | Ensembl 87 EnsDb for Ailuropoda Melanoleuca
##   AH53187  | Ensembl 87 EnsDb for Astyanax Mexicanus
##   AH53188  | Ensembl 87 EnsDb for Anas Platyrhynchos
##   AH53189  | Ensembl 87 EnsDb for Bos Taurus
##   ...        ...
##   AH117051 | Ensembl 112 EnsDb for Xiphophorus maculatus
##   AH117052 | Ensembl 112 EnsDb for Xenopus tropicalis
##   AH117053 | Ensembl 112 EnsDb for Zonotrichia albicollis
##   AH117054 | Ensembl 112 EnsDb for Zalophus californianus
##   AH117055 | Ensembl 112 EnsDb for Zosterops lateralis melanops
```

We fetch the `EnsDb` for species *Ciona Intestinalis* and ensembl release 87.

```
qr <- query(ah, c("EnsDb", "intestinalis", "87"))
edb <- qr[[1]]
```

```
## downloading 1 resources
```

```
## retrieving 1 resource
```

```
## loading from cache
```

```
## require("ensembldb")
```

To get the genes defined for this species we can simply call.

```
genes(edb)
```

```
## GRanges object with 17153 ranges and 7 metadata columns:
##                      seqnames      ranges strand |            gene_id
##                         <Rle>   <IRanges>  <Rle> |        <character>
##   ENSCING00000017842        1   1636-1902      + | ENSCING00000017842
##   ENSCING00000016550        1  4219-20394      - | ENSCING00000016550
##   ENSCING00000016539        1 23518-34155      + | ENSCING00000016539
##   ENSCING00000002700        1 37108-60412      - | ENSCING00000002700
##   ENSCING00000002712        1 62406-66903      - | ENSCING00000002712
##                  ...      ...         ...    ... .                ...
##   ENSCING00000025225       MT 11275-11335      + | ENSCING00000025225
##   ENSCING00000025226       MT 11337-12899      + | ENSCING00000025226
##   ENSCING00000025227       MT 12910-12973      + | ENSCING00000025227
##   ENSCING00000025228       MT 12990-14724      + | ENSCING00000025228
##   ENSCING00000025229       MT 14725-14790      + | ENSCING00000025229
##                        gene_name   gene_biotype seq_coord_system
##                      <character>    <character>      <character>
##   ENSCING00000017842                   misc_RNA       chromosome
##   ENSCING00000016550             protein_coding       chromosome
##   ENSCING00000016539             protein_coding       chromosome
##   ENSCING00000002700             protein_coding       chromosome
##   ENSCING00000002712             protein_coding       chromosome
##                  ...         ...            ...              ...
##   ENSCING00000025225                    Mt_tRNA       chromosome
##   ENSCING00000025226         COI protein_coding       chromosome
##   ENSCING00000025227                    Mt_tRNA       chromosome
##   ENSCING00000025228       NADH5 protein_coding       chromosome
##   ENSCING00000025229                    Mt_tRNA       chromosome
##                                 description      symbol  entrezid
##                                 <character> <character>    <list>
##   ENSCING00000017842                   NULL                  <NA>
##   ENSCING00000016550                   NULL                  <NA>
##   ENSCING00000016539                   NULL                  <NA>
##   ENSCING00000002700                   NULL                  <NA>
##   ENSCING00000002712                   NULL             100181294
##                  ...                    ...         ...       ...
##   ENSCING00000025225                   NULL                  <NA>
##   ENSCING00000025226 cytochrome oxidase s..         COI    806118
##   ENSCING00000025227                   NULL                  <NA>
##   ENSCING00000025228 NADH dehydrogenase s..       NADH5    806127
##   ENSCING00000025229                   NULL                  <NA>
##   -------
##   seqinfo: 763 sequences (1 circular) from KH genome
```

# 2 Creating EnsDbs for a given Ensembl release

This section describes the (semi)-automated way to create `ensembldb` `EnsDb`
SQLite annotation databases using the Ensembl Perl API and the MySQL database
dumps from Ensembl.

## 2.1 Requirements

* Perl.
* Ensembl Perl API corresponding to the version for which the databases should
  be created. See <http://www.ensembl.org/info/docs/api/api_installation.html> for
  more details.
* BioPerl.
* MySQL server with access credentials allowing to create databases and insert
  data.

## 2.2 Creating `EnsDb` SQLite databases

To create the databases we are sequentially downloading and installing the MySQL
database dumps from Ensembl locally and query these local databases to extract
the annotations that will be inserted into the final SQLite databases. While it
would be possible to directly query the Ensembl databases using the Perl API,
this has proven to be slower and frequently fails due to access shortages or
time outs.

Below we load the `ensembldb` package and the *generate-EnsDbs.R* script in its
*scripts* folder.

```
library(ensembldb)

scr <- system.file("scripts/generate-EnsDBs.R", package = "ensembldb")
source(scr)
```

We next use the `createEnsDbForSpecies` function. This function queries first
the Ensembl ftp server to list all species for a certain Ensembl release. By
default it will then process all species, by first downloading the MySQL
database dumps, installing it into a local MySQL server and subsequently, using
functionality from the `ensembldb` package and the Ensembl Perl API, exctracting
all annotations from it and storing it to a SQLite datababse. The local MySQL
database will then by default deleted (setting the parameter `dropDb = FALSE`
does not delete the databases).

Important parameter to set in the function are:
+ `ftp_folder`: by default the main Ensembl ftp server will be queried
(ftp://ftp.ensembl.org/pub), alternatively, also the Ensemblgenomes database
can be queried. To build e.g. `EnsDb`s for all plants use
ftp://ftp.ensemblgenomes.org/pub/release-34/plants/mysql. If this parameter
is defined it has to point to the directory in which all MySQL database dumps
can be found.
+ `ens_version`: the Ensembl version (e.g. `87`).
+ `user`: the user name for the **local** MySQL database.
+ `host`: the hostname of the local MySQL database (e.g. `"localhost"`).
+ `pass`: the password for the local MySQL database.

Below we create all `EnsDb` databases for Ensembl release 87. Note that we have
to have installed the Ensembl Perl API matching this release.

```
createEnsDbForSpecies(ens_version = 87, user = "someuser", host = "localhost",
                      pass = "somepass")
```

All SQLite database, one per species, will be stored in the current working
directory.