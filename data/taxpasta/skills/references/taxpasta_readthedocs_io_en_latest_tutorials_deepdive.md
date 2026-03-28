[ ]
[ ]

[Skip to content](#deep-dive)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

Deep Dive

Initializing search

[taxprofiler/taxpasta](https://github.com/taxprofiler/taxpasta "Go to repository")

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")
TAXPASTA

[taxprofiler/taxpasta](https://github.com/taxprofiler/taxpasta "Go to repository")

* [Home](../..)
* [x]

  Tutorials

  Tutorials
  + [Getting Started](../getting-started/)
  + [ ]

    Deep Dive

    [Deep Dive](./)

    Table of contents
    - [Introduction](#introduction)
    - [Preparation](#preparation)

      * [Software](#software)
      * [Data](#data)
    - [Profiles](#profiles)

      * [Raw Output](#raw-output)

        + [mOTUs](#motus)
        + [Kraken2](#kraken2)
      * [Comparing Output of Different Profilers](#comparing-output-of-different-profilers)
    - [Standardisation and Merging](#standardisation-and-merging)

      * [taxpasta standardise](#taxpasta-standardise)
      * [taxpasta merge](#taxpasta-merge)
    - [Important caveat](#important-caveat)
    - [Clean Up](#clean-up)
* [ ]

  How-tos

  How-tos
  + [How-to Add Taxa Names to Output](../../how-tos/how-to-add-names/)
  + [How-to Customise Sample Names](../../how-tos/how-to-customise-sample-names/)
  + [How-to Merge Across Profilers](../../how-tos/how-to-merge-across-profilers/)
* [ ]

  [Commands](../../commands/)

  Commands
  + [standardise](../../commands/standardise/)
  + [merge](../../commands/merge/)
* [ ]

  [Quick reference](../../quick_reference/)

  Quick reference
  + [standardise](../../quick_reference/standardise/)
  + [merge](../../quick_reference/merge/)
* [ ]

  [Supported profilers](../../supported_profilers/)

  Supported profilers
  + [Terminology](../../supported_profilers/terminology/)
  + [Bracken](../../supported_profilers/bracken/)
  + [Centrifuge](../../supported_profilers/centrifuge/)
  + [DIAMOND](../../supported_profilers/diamond/)
  + [ganon](../../supported_profilers/ganon/)
  + [Kaiju](../../supported_profilers/kaiju/)
  + [KMCP](../../supported_profilers/kmcp/)
  + [Kraken2](../../supported_profilers/kraken2/)
  + [KrakenUniq](../../supported_profilers/krakenuniq/)
  + [MEGAN6/MALT](../../supported_profilers/megan6/)
  + [MetaPhlAn](../../supported_profilers/metaphlan/)
  + [mOTUs](../../supported_profilers/motus/)
* [FAQ](../../faq/)
* [ ]

  Design Decisions

  Design Decisions
  + [1. Record architecture decisions](../../adr/0001-record-architecture-decisions/)
  + [2. Use Integer Taxonomy Identifiers](../../adr/0002-use-integer-taxonomy-identifiers/)
* [ ]

  API Reference

  API Reference
  + [Application](../../api/application/)
  + [Domain](../../api/domain/)
  + [Infrastructure](../../api/infrastructure/)
* [ ]

  [Contributing](../../contributing/)

  Contributing
  + [Supporting New Taxonomic Profilers](../../contributing/supporting_new_profiler/)

Table of contents

* [Introduction](#introduction)
* [Preparation](#preparation)

  + [Software](#software)
  + [Data](#data)
* [Profiles](#profiles)

  + [Raw Output](#raw-output)

    - [mOTUs](#motus)
    - [Kraken2](#kraken2)
  + [Comparing Output of Different Profilers](#comparing-output-of-different-profilers)
* [Standardisation and Merging](#standardisation-and-merging)

  + [taxpasta standardise](#taxpasta-standardise)
  + [taxpasta merge](#taxpasta-merge)
* [Important caveat](#important-caveat)
* [Clean Up](#clean-up)

# Deep Dive[¶](#deep-dive "Permanent link")

## Introduction[¶](#introduction "Permanent link")

Following from our basic '[Getting Started](../getting-started/)' tutorial,
we will once again show you how to generate standardised taxonomic profiles from the
diverse outputs of two popular taxonomic profilers:
[Kraken2](https://ccb.jhu.edu/software/kraken2/) and
[mOTUs](https://motu-tool.org/) with `taxpasta`.

However, in this particular we will also demonstrate some benefits of this
standardisation when running downstream analyses on such tables in either the
popular statistical programming language [R](https://www.r-project.org/) or
[Python](https://www.python.org/).

## Preparation[¶](#preparation "Permanent link")

### Software[¶](#software "Permanent link")

For this tutorial you will need an internet connection, an [installation of
taxpasta](../../#install), and, if you want to follow the R parts, an [installation
of
R](https://rstudio-education.github.io/hopr/starting.html#how-to-download-and-install-r)
itself with the [readr](https://readr.tidyverse.org/) and
[dplyr](https://dplyr.tidyverse.org/) packages from the
[Tidyverse](https://tidyverse.org). Furthermore, we assume a UNIX based
operating system, such as Linux, macOS, or Windows Subsystem for Linux.

To summarise, you will need:

* Unix terminal (e.g., `bash`)
* [Python environment with taxpasta](../../#install)
* [R](https://rstudio-education.github.io/hopr/starting.html#how-to-download-and-install-r)
* Package dependencies

  ```
  install.packages(c("readr", "dplyr"), dependencies = TRUE)
  ```

* Unix terminal (e.g., `bash`)
* [Python environment with taxpasta](../../#install)
* No additional requirements, since we will make use of
  [pandas](https://pandas.pydata.org/) which is already part of the
  taxpasta installation.

### Data[¶](#data "Permanent link")

First we will make a ‘scratch’ directory where we can run the tutorial and
delete again afterwards.

```
mkdir taxpasta-tutorial
cd taxpasta-tutorial
```

We will also need to download some example taxonomic profiles from Kraken2 and
mOTUs. We can download test data from the `taxpasta` repository using, for
example, `curl` or `wget`.

```
## mOTUs
curl -O https://raw.githubusercontent.com/taxprofiler/taxpasta/main/tests/data/motus/2612_pe-ERR5766176-db_mOTU.out
curl -O https://raw.githubusercontent.com/taxprofiler/taxpasta/main/tests/data/motus/2612_se-ERR5766180-db_mOTU.out

## Kraken2
curl -O https://raw.githubusercontent.com/taxprofiler/taxpasta/main/tests/data/kraken2/2612_pe-ERR5766176-db1.kraken2.report.txt
```

```
## mOTUs
wget https://raw.githubusercontent.com/taxprofiler/taxpasta/main/tests/data/motus/2612_pe-ERR5766176-db_mOTU.out
wget https://raw.githubusercontent.com/taxprofiler/taxpasta/main/tests/data/motus/2612_se-ERR5766180-db_mOTU.out

## Kraken2
wget https://raw.githubusercontent.com/taxprofiler/taxpasta/main/tests/data/kraken2/2612_pe-ERR5766176-db1.kraken2.report.txt
```

We should now see three files with contents in the `taxpasta-tutorial` directory

```
ls
```

```
2612_pe-ERR5766176-db1.kraken2.report.txt  2612_se-ERR5766180-db_mOTU.out
2612_pe-ERR5766176-db_mOTU.out
```

## Profiles[¶](#profiles "Permanent link")

### Raw Output[¶](#raw-output "Permanent link")

To begin, let’s look at the contents of the output from each profiler.

```
head 2612_pe-ERR5766176-db_mOTU.out
```

```
# git tag version 3.0.3 |  motus version 3.0.3 | map_tax 3.0.3 | gene database: nr3.0.3 | calc_mgc 3.0.3 -y insert.scaled_counts -l 75 | calc_motu 3.0.3 -k mOTU -C no_CAMI -g 3 -c -p | taxonomy: ref_mOTU_3.0.3 meta_mOTU_3.0.3
# call: python /usr/local/bin/../share/motus-3.0.1//motus profile -p -c -f ERX5474932_ERR5766176_1.fastq.gz -r ERX5474932_ERR5766176_2.fastq.gz -db db_mOTU -t 2 -n 2612_pe-ERR5766176-db_mOTU -o 2612_pe-ERR5766176-db_mOTU.out
#consensus_taxonomy NCBI_tax_id 2612_pe-ERR5766176-db_mOTU
Leptospira alexanderi [ref_mOTU_v3_00001]   100053  0
Leptospira weilii [ref_mOTU_v3_00002]   28184   0
Chryseobacterium sp. [ref_mOTU_v3_00004]    NA  0
Chryseobacterium gallinarum [ref_mOTU_v3_00005] 1324352 0
Chryseobacterium indologenes [ref_mOTU_v3_00006]    253 0
Chryseobacterium artocarpi/ureilyticum [ref_mOTU_v3_00007]  NA  0
Chryseobacterium jejuense [ref_mOTU_v3_00008]   445960  0
```

```
head 2612_pe-ERR5766176-db1.kraken2.report.txt
```

```
 99.97  627680  627680  U   0   unclassified
  0.03  168 0   R   1   root
  0.03  168 0   R1  131567    cellular organisms
  0.03  168 0   D   2759        Eukaryota
  0.03  168 0   D1  33154         Opisthokonta
  0.02  152 0   K   33208           Metazoa
  0.02  152 0   K1  6072              Eumetazoa
  0.02  152 0   K2  33213               Bilateria
  0.02  152 0   K3  33511                 Deuterostomia
  0.02  152 0   P   7711                    Chordata
```

These look quite different. Neither of them is in a nice "pure" tabular
format that is convenient for analysis software or spreadsheet tools such
as Microsoft Excel or LibreOffice Calc to load. They also have different
types columns and, in the case of Kraken2, it has an interesting
"indentation" way of showing the taxonomic rank of each taxon.

#### mOTUs[¶](#motus "Permanent link")

> The following section uses R/Python.

We can try loading a mOTUs profile into R using the common table reading
function `read_tsv()` from the `readr` package with default arguments.

```
requireNamespace("readr")
```

```
Loading required namespace: readr
```

```
profile_motus <- readr::read_tsv("2612_pe-ERR5766176-db_mOTU.out")
```

```
Warning: One or more parsing issues, call `problems()` on your data frame for details,
e.g.:
  dat <- vroom(...)
  problems(dat)

Rows: 33573 Columns: 1

── Column specification ────────────────────────────────────────────────────────
Delimiter: "\t"
chr (1): # git tag version 3.0.3 |  motus version 3.0.3 | map_tax 3.0.3 | ge...

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

You can see we immediately hit an error, as as we saw above, there is a
‘comment’ line at the top of the mOTUs profile with information on how
the profile was generated.

While such a comment is very useful for reproducibility, to load this
into software expecting ‘true’ tabular data, we have to instead add
extra options to the function, which makes loading the table less than
smooth for downstream analyses.

```
profile_motus <- readr::read_tsv("2612_pe-ERR5766176-db_mOTU.out", comment = "#")
```

```
Warning: One or more parsing issues, call `problems()` on your data frame for details,
e.g.:
  dat <- vroom(...)
  problems(dat)

Rows: 33570 Columns: 3
── Column specification ────────────────────────────────────────────────────────
Delimiter: "\t"
chr (1): Leptospira alexanderi [ref_mOTU_v3_00001]
dbl (2): 100053, 0

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

However, once again we hit another error: the column headers are *also*
specified as a comment line… Instead we can try to skip the first two
lines entirely.

```
profile_motus <- readr::read_tsv("2612_pe-ERR5766176-db_mOTU.out", skip = 2)
```

```
Rows: 33571 Columns: 3
── Column specification ────────────────────────────────────────────────────────
Delimiter: "\t"
chr (1): #consensus_taxonomy
dbl (2): NCBI_tax_id, 2612_pe-ERR5766176-db_mOTU

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```
profile_motus
```

```
# A tibble: 33,571 × 3
   `#consensus_taxonomy`                                      NCBI_tax…¹ 2612_…²
   <chr>                                                           <dbl>   <dbl>
 1 Leptospira alexanderi [ref_mOTU_v3_00001]                      100053       0
 2 Leptospira weilii [ref_mOTU_v3_00002]                           28184       0
 3 Chryseobacterium sp. [ref_mOTU_v3_00004]                           NA       0
 4 Chryseobacterium gallinarum [ref_mOTU_v3_00005]               1324352       0
 5 Chryseobacterium indologenes [ref_mOTU_v3_00006]                  253       0
 6 Chryseobacterium artocarpi/ureilyticum [ref_mOTU_v3_00007]         NA       0
 7 Chryseobacterium jejuense [ref_mOTU_v3_00008]                  445960       0
 8 Chryseobacterium sp. G972 [ref_mOTU_v3_00009]                 1805473       0
 9 Chryseobacterium contaminans [ref_mOTU_v3_00010]              1423959       0
10 Chryseobacterium indologenes [ref_mOTU_v3_00011]                  253       0
# … with 33,561 more rows, and abbreviated variable names ¹​NCBI_tax_id,
#   ²​`2612_pe-ERR5766176-db_mOTU`
```

We can try loading a mOTUs profile into Python using the common table
reading function `read_table()` from the `pandas` package with default
arguments.

```
import pandas as pd

profile_motus_2612_pe_raw = pd.read_table("2612_pe-ERR5766176-db_mOTU.out")
```

```
ParserError: Error tokenizing data. C error: Expected 1 fields in line 3, saw 3
```

You can see we immediately hit a `ParserError`, as there is a ‘comment’
line at the top of the mOTUs profile with information on how the profile
was generated.

While such a comment is very useful for reproducibility, to load this we
have to instead add extra options to the function, which makes loading
the table less than smooth for downstream analyses.

```
profile_motus = pd.read_table(
    "2612_pe-ERR5766176-db_mOTU.out",
    comment="#",
)
profile_motus.head()
```

|  | Leptospira alexanderi [ref\_mOTU\_v3\_00001] | 100053 | 0 |
| --- | --- | --- | --- |
| 0 | Leptospira weilii [ref\_mOTU\_v3\_00002] | 28184 | 0 |
| 1 | Chryseobacterium sp. [ref\_mOTU\_v3\_00004] | nan | 0 |
| 2 | Chryseobacterium gallinarum [ref\_mOTU\_v3\_00005] | 1.32435e+06 | 0 |
| 3 | Chryseobacterium indologenes [ref\_mOTU\_v3\_00006] | 253 | 0 |
| 4 | Chryseobacterium artocarpi/ureilyticum [ref\_mOTU\_v3\_00007] | nan | 0 |

However, once again we encounter another problem: the column headers are
*also* specified as a comment line and our first line of data is instead
read as the column headers. We can try to skip the first two lines
entirely to remedy this.

```
profile_motus = pd.read_table(
    "2612_pe-ERR5766176-db_mOTU.out",
    skiprows=2,
)
profile_motus.head()
```

|  | #consensus\_taxonomy | NCBI\_tax\_id | 2612\_pe-ERR5766176-db\_mOTU |
| --- | --- | --- | --- |
| 0 | Leptospira alexanderi [ref\_mOTU\_v3\_00001] | 100053 | 0 |
| 1 | Leptospira weilii [ref\_mOTU\_v3\_00002] | 28184 | 0 |
| 2 | Chryseobacterium sp. [ref\_mOTU\_v3\_00004] | nan | 0 |
| 3 | Chryseobacterium gallinarum [ref\_mOTU\_v3\_00005] | 1.32435e+06 | 0 |
| 4 | Chryseobacterium indologenes [ref\_mOTU\_v3\_00006] | 253 | 0 |

That works! At least in terms of reasonable table headers. However, we can see
that there are missing NCBI taxonomy identifiers so there is probably more data
cleaning ahead of us. Getting to this point took too much effort already to
load what is essentially a simple table. Furthermore, if we are interested in
loading all mOTUs profiles, we would have to load each profile one by one for
each sample, requiring more complicated loops and table join code.

#### Kraken2[¶](#kraken2 "Permanent link")

And what about the Kraken2 output?

```
profile_kraken2 <- readr::read_tsv("2612_pe-ERR5766176-db1.kraken2.report.txt")
```

```
New names:
Rows: 43 Columns: 6
── 