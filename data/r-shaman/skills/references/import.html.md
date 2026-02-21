[shaman](../index.html)

* [Home](../index.html)
* [Usage](../articles/shaman-package.html)
* [Import](../articles/import.html)
* [Reference](../reference/index.html)

# Import

#### Netta Medndelson Cohen

#### 2017-09-10

## Create misha database from ucsc

### hg19

In order to create a misha database for *hg19* genome, run the following *misha* commands (assuming *“hg19”* is your new data base path):

```
ftp <- "ftp://hgdownload.soe.ucsc.edu/goldenPath/hg19"
gdb.create("hg19",
           paste(ftp, 'chromosomes', paste0('chr', c(1:22, 'X', 'Y', 'M'), '.fa.gz'), sep='/'),
           paste(ftp, "database/knownGene.txt.gz", sep = "/"),
           paste(ftp, "database/kgXref.txt.gz", sep = "/"),
           c("kgID", "mRNA", "spID", "spDisplayID", "geneSymbol",
             "refseq", "protAcc", "description", "rfamAcc",
             "tRnaName"))
gdb.init('hg19')
```

### hg38

In order to create a misha database for *hg38* genome, run the following *misha* commands (assuming *“hg38”* is your new data base path):

```
ftp <- "ftp://hgdownload.soe.ucsc.edu/goldenPath/hg38"
gdb.create("hg38",
           paste(ftp, 'chromosomes', paste0('chr', c(1:22, 'X', 'Y', 'M'), '.fa.gz'), sep='/'),
           paste(ftp, "database/knownGene.txt.gz", sep = "/"),
           paste(ftp, "database/kgXref.txt.gz", sep = "/"),
           c("kgID", "mRNA", "spID", "spDisplayID", "geneSymbol",
             "refseq", "protAcc", "description", "rfamAcc",
             "tRnaName"))
gdb.init('hg38')
```

### mm9

In order to create a misha database for *mm9* genome, run the following *misha* commands (assuming *“mm9”* is your new data base path):

```
ftp <- "ftp://hgdownload.soe.ucsc.edu/goldenPath/mm9"
gdb.create("mm9",
           paste(ftp, 'chromosomes', paste0('chr', c(1:19, 'X', 'Y', 'M'), '.fa.gz'), sep='/'),
           paste(ftp, "database/knownGene.txt.gz", sep = "/"),
           paste(ftp, "database/kgXref.txt.gz", sep = "/"),
           c("kgID", "mRNA", "spID", "spDisplayID", "geneSymbol",
             "refseq", "protAcc", "description"))
gdb.init('mm9')
```

### mm10

In order to create a misha database for *mm10* genome, run the following *misha* commands (assuming *“mm10”* is your new data base path):

```
ftp <- "ftp://hgdownload.soe.ucsc.edu/goldenPath/mm10"
gdb.create("mm10",
           paste(ftp, 'chromosomes', paste0('chr', c(1:19, 'X', 'Y', 'M'), '.fa.gz'), sep='/'),
           paste(ftp, "database/knownGene.txt.gz", sep = "/"),
           paste(ftp, "database/kgXref.txt.gz", sep = "/"),
           c("kgID", "mRNA", "spID", "spDisplayID", "geneSymbol",
             "refseq", "protAcc", "description", "rfamAcc",
             "tRnaName"))
gdb.init('mm10')
```

## Import HiC observed contacts

In order to import observed HiC contacts to an existing misha database (e.g. “hg19”):

1. create tab delimited text files (e.g. “hic.obs.txt”) with the following columns:

* chrom1 - the first chromosome of the contact (must start with “chr”)
* start1 - the first genomic coordinate
* end1 - should be set to start1+1
* chrom2 - the second chromosome of the contact (must start with “chr”)
* start2 - the second genomic coordinate of the contact
* end2 - should be set to start2+1 NOTE: misha uses 0-based coordinates!

2. run the following *misha* command:

```
gsetroot("hg19")
gtrack.2d.import(track="hic_obs", description="observed hic data", file=c("hic.obs.txt"))
gdb.reload()
```

## Contents

* [Create misha database from ucsc](#create-misha-database-from-ucsc)
* [Import HiC observed contacts](#import-hic-observed-contacts)

Developed by Amos Tanay, Netta Mendelson Cohen.

Site built with [pkgdown](http://hadley.github.io/pkgdown/).