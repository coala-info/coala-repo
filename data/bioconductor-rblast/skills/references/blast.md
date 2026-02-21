# rBLAST: R Interface for the Basic Local Alignment Search Tool

#### Michael Hahsler and Anurag Nagar

```
library("rBLAST")
#> Loading required package: Biostrings
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: S4Vectors
#> Loading required package: stats4
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: XVector
#> Loading required package: Seqinfo
#>
#> Attaching package: 'Biostrings'
#> The following object is masked from 'package:base':
#>
#>     strsplit
```

**Note: BLAST was not installed when this vignette was built. Some output is not available in this vignette!**

# Introduction

This package provides an R interface to use a local installation of the Basic Local Alignment Search Tool (BLAST) executable. This allows the user to download BLAST databases for querying or to create their own database from sets of sequences. The interface integrates BLAST search directly with the Bioconductor infrastructure by using the `XStringSet` (e.g., `RNAStringSet`) from the package `Biostrings`.

This package complements the function in `blastSequences()` in package `annotate` that runs a BLAST query not locally but by connecting to the NCBI server.

# System requirements

The BLAST+ software needs to be installed on your system. Installation instructions are available in this package’s [INSTALL](https://github.com/mhahsler/rBLAST/blob/devel/INSTALL) file and at .

R needs to be able to find the executable. After installing the software, try in R

```
Sys.which("blastn")
```

If the command returns "" instead of the path to the executable, then you need to set the environment variable called PATH. In R

```
Sys.setenv(PATH = paste(Sys.getenv("PATH"),
   "path_to_your_BLAST_installation", sep=.Platform$path.sep))
```

# Examples

## Use an existing database

You can download pretrained databases from NCBI at <https://ftp.ncbi.nlm.nih.gov/blast/db/>. Here we download the 16S rRNA database. To avoid multiple downloads of the same file, we use BiocFileCache in function `blast_db_cache` for download. The database compressed and needs to be expanded.

```
## download the 16S Microbial rRNA data base from NCBI
tgz_file <- blast_db_get("16S_ribosomal_RNA.tar.gz")
untar(tgz_file, exdir = "16S_rRNA_DB")
```

The extracted database consists of a folder with a set of database files.

```
list.files("./16S_rRNA_DB/")
```

Next, we open the database for querying using the `blast()` function which returns a BLAST database object.

```
bl <- blast(db = "./16S_rRNA_DB/16S_ribosomal_RNA")
bl
```

To demonstrate how to query the database, we read one sequence from an example FASTA file that is shipped with the package. Queries are performed using the `predict()` function. The result is a `data.frame` with one row per match. We will show the first 5 matches.

```
seq <- readRNAStringSet(system.file("examples/RNA_example.fasta",
    package = "rBLAST"
))[1]
seq

cl <- predict(bl, seq)
nrow(cl)
cl[1:5, ]
```

Additional arguments for BLAST can be passed on using the `BLAST_args` parameter for `predict()`. The output format can be specified using `custom_format`. In the following, we specify a custom format and that the sequences need to have 99% identity. See the BLAST Command Line Applications User Manual for details (<https://www.ncbi.nlm.nih.gov/books/NBK279690/>).

```
fmt <- paste(
    "qaccver saccver pident length mismatch gapopen qstart qend",
    "sstart send evalue bitscore qseq sseq"
)
cl <- predict(bl, seq,
    BLAST_args = "-perc_identity 99",
    custom_format = fmt
)
cl
```

## Create a custom BLAST database

The `makeblastdb` utility can be used to create a BLAST database from a FASTA file with sequences. The package provides an R interface function of the same name. As an example, we will create a searchable database from a sequence FASTA file shipped with the package.

```
seq <- readRNAStringSet(system.file("examples/RNA_example.fasta",
    package = "rBLAST"
))
seq
#> RNAStringSet object of length 5:
#>     width seq                                               names
#> [1]  1481 AGAGUUUGAUCCUGGCUCAGAAC...GGUGAAGUCGUAACAAGGUAACC 1675 AB015560.1 d...
#> [2]  1404 GCUGGCGGCAGGCCUAACACAUG...CACGGUAAGGUCAGCGACUGGGG 4399 D14432.1 Rho...
#> [3]  1426 GGAAUGCUNAACACAUGCAAGUC...AACAAGGUAGCCGUAGGGGAACC 4403 X72908.1 Ros...
#> [4]  1362 GCUGGCGGAAUGCUUAACACAUG...UACCUUAGGUGUCUAGGCUAACC 4404 AF173825.1 A...
#> [5]  1458 AGAGUUUGAUUAUGGCUCAGAGC...UGAAGUCGUAACAAGGUAACCGU 4411 Y07647.2 Dre...
```

First, we write a FASTA file that will be used by blast to create the database.

```
writeXStringSet(seq, filepath = "seqs.fasta")
```

Next, we create a BLAST database from the file. We need to specify that the sequences contains RNA and thus nucleotides.

```
makeblastdb("seqs.fasta", db_name = "db/small", dbtype = "nucl")
```

Note that it is convenient to specify a folder and a name separated by a `/` to organize all index files in a folder.

We can now open the database and use it for queries.

```
db <- blast("db/small")
db
```

Check if it finds a 100 nucleotide long fragment from the first sequence in the training data.

```
fragment <- subseq(seq[1], start = 101, end = 200)
fragment

predict(db, fragment)
```

We see that the found sequence ID (`ssequid`) matches the query sequence ID (`qsequid`) and that it matches the correct region in the sequence (see `sstart` and `send`).

To permanently remove a database, the folder can be deleted.

```
unlink("seqs.fasta")
unlink("db", recursive = TRUE)
```

# SessionInfo

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
#> [1] rBLAST_1.6.0        Biostrings_2.78.0   Seqinfo_1.0.0
#> [4] XVector_0.50.0      IRanges_2.44.0      S4Vectors_0.48.0
#> [7] BiocGenerics_0.56.0 generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#>  [1] digest_0.6.37     R6_2.6.1          fastmap_1.2.0     xfun_0.53
#>  [5] cachem_1.1.0      knitr_1.50        htmltools_0.5.8.1 rmarkdown_2.30
#>  [9] lifecycle_1.0.4   cli_3.6.5         sass_0.4.10       jquerylib_0.1.4
#> [13] compiler_4.5.1    tools_4.5.1       evaluate_1.0.5    bslib_0.9.0
#> [17] yaml_2.3.10       crayon_1.5.3      rlang_1.1.6       jsonlite_2.0.0
```