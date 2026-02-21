# PhIPData: A Container for PhIP-Seq Experiments

Athena Chen, Rob Scharpf, and Ingo Ruczinski

#### October 30, 2025

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
* [3 Components of a `PhIPData` Object](#components-of-a-phipdata-object)
* [4 Creating a `PhIPData` object](#creating-a-phipdata-object)
* [5 Accessing and modifying components of `PhIPData` object](#accessing-and-modifying-components-of-phipdata-object)
  + [5.1 Assays](#assays)
  + [5.2 Peptide metadata](#peptide-metadata)
  + [5.3 Sample metadata](#sample-metadata)
  + [5.4 Experimental metadata](#experimental-metadata)
* [6 Common operations on `PhIPData` objects](#common-operations-on-phipdata-objects)
  + [6.1 Subsetting](#subsetting)
  + [6.2 `PhIPData` summaries](#phipdata-summaries)
  + [6.3 Using template libraries](#using-template-libraries)
  + [6.4 Using aliases](#using-aliases)
  + [6.5 Coercion from `PhIPData` to other containers](#coercion-from-phipdata-to-other-containers)
* [7 `sessionInfo()`](#sessioninfo)

# 1 Installation

We recommend installing the stable release version of `PhIPData` in Bioconductor.
This can be done using `BiocManager`:

```
if (!require("BiocManager"))
    install.packages("BiocManager")

BiocManager::install("PhIPData")
```

To load the package:

```
library(PhIPData)
```

# 2 Introduction

The `PhIPData` class is used to store experimental results from phage-immunoprecipitation sequencing (PhIP-set) experiments in a matrix-like container.

Building on the [`RangedSummarizedExperiment`](https://bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html) class, `PhIPData` contains all of functionality of `SummarizedExperiments` and includes additional operations to facilitate analysis with PhIP-seq data. Like `SummarizedExperiments`, a key feature of `PhIPData` is the coordination of metadata when subsetting `PhIPData` objects. For example, if you wanted to examine experimental data for peptides from one particular virus, you can subset the experimental data and the associated peptide annotation with one command. This ensures all metadata (for samples, peptides, etc.) remain synced with the experimental data throughout analysis.

# 3 Components of a `PhIPData` Object

As reflected in the figure below, the structure of a `PhIPData` object is nearly identical to the structure of a `SummarizedExperiment`/`RangedSummarizedExperiment` object.

Each object contains at least three assays of data. These assays are:

* `counts`: matrix of raw read counts,
* `logfc`: matrix of log2 estimated fold-changes (in comparison to negative control samples),
* `prob`: matrix of probabilities (p-values or posterior probabilities) associated with whether a sample shows an enriched antibody response to the particular peptide.

Though `counts` typically contain integer values for the number of reads aligned to each peptide, `PhIPData` only requires that stored values are non-negative numeric values. Pseudocounts or non-integer count values can also be stored in the `counts` assay.

The rows of a `PhIPData` object represent peptides of interest and the columns represent samples. Sample and peptide metadata are stored in `DataFrame`s. Each row of the metadata `DataFrame` specifies the peptide/sample, and the columns represent different features associated with the peptides/samples.

In addition to sample- and peptide-specific metadata, experimental metadata such as associated papers, experimental parameters, sequencing dates, etc. are stored in a list-like component named `metadata`.

![Schematic of a PhIPData object. Commands used to access each component of the object are listed underneath its visual representation. Code in black indicates functions specific to `PhIPData` objects while functions in red extend `SummarizedExperiment` functions. Here, `pd` is a generic `PhIPData` object.](data:image/png;base64...)

Figure 1: Schematic of a PhIPData object
Commands used to access each component of the object are listed underneath its visual representation. Code in black indicates functions specific to `PhIPData` objects while functions in red extend `SummarizedExperiment` functions. Here, `pd` is a generic `PhIPData` object.

# 4 Creating a `PhIPData` object

```
library(dplyr)
library(readr)
```

To demonstrate the `PhIPData` class and functions, we will use a simulated example data set. Suppose we have PhIP-seq data from 5 individuals for 1288 peptides derived from known human viruses.

```
set.seed(20210120)

# Read in peptide metadata -------------
virscan_file <- system.file("extdata", "virscan.tsv", package = "PhIPData")
virscan_info <- readr::read_tsv(virscan_file,
                                col_types = readr::cols(
                                  pep_id = readr::col_character(),
                                  pro_id = readr::col_character(),
                                  pos_start = readr::col_double(),
                                  pos_end = readr::col_double(),
                                  UniProt_acc = readr::col_character(),
                                  pep_dna = readr::col_character(),
                                  pep_aa = readr::col_character(),
                                  pro_len = readr::col_double(),
                                  taxon_id = readr::col_double(),
                                  species = readr::col_character(),
                                  genus = readr::col_character(),
                                  product = readr::col_character()
                                )) %>%
  as.data.frame()
```

```
## Warning: The following named parsers don't match the column names: pro_id,
## pos_start, pos_end, UniProt_acc, taxon_id, genus
```

```
# Simulate data -------------
n_samples <- 5L
n_peps <- nrow(virscan_info)

counts_dat <- matrix(sample(1:1e6, n_samples*n_peps, replace = TRUE),
                 nrow = n_peps)
logfc_dat <- matrix(rnorm(n_samples*n_peps, mean = 0, sd = 10),
                    nrow = n_peps)
prob_dat <- matrix(rbeta(n_samples*n_peps, shape1 = 1, shape2 = 1),
                   nrow = n_peps)

# Sample metadata -------------
sample_meta <- data.frame(sample_name = paste0("sample", 1:n_samples),
                          gender = sample(c("M", "F"), n_samples, TRUE),
                          group = sample(c("ctrl", "trt", "beads"), n_samples, TRUE))

# Set row/column names -------------
rownames(counts_dat) <- rownames(logfc_dat) <-
  rownames(prob_dat) <- rownames(virscan_info) <-
  paste0("pep_", 1:n_peps)

colnames(counts_dat) <- colnames(logfc_dat) <-
  colnames(prob_dat) <- rownames(sample_meta) <-
  paste0("sample_", 1:n_samples)

# Experimental metadata -------------
exp_meta <- list(date_run = as.Date("2021/01/20"),
                 reads_per_sample = colSums(counts_dat))
```

To create a `PhIPData` object, we will use the homonymous constructor `PhIPData()`.

```
phip_obj <- PhIPData(counts_dat, logfc_dat, prob_dat,
                     virscan_info, sample_meta,
                     exp_meta)
```

```
## ! Missing peptide start and end position information. Replacing missing values with 0.
```

```
phip_obj
```

```
## class: PhIPData
## dim: 1220 5
## metadata(2): date_run reads_per_sample
## assays(3): counts logfc prob
## rownames(1220): pep_1 pep_2 ... pep_1219 pep_1220
## rowData names(17): pep_id pep_dna ... interpro pep_name
## colnames(5): sample_1 sample_2 sample_3 sample_4 sample_5
## colData names(3): sample_name gender group
## beads-only name(1): beads
```

The `PhIPData()` constructor is quite flexible; mismatched dimension names across assays and metadata are automatically corrected, and missing assays are initialized with empty matrices of the same dimensions. For more details on the constructor, type `help(PhIPData)`.

# 5 Accessing and modifying components of `PhIPData` object

## 5.1 Assays

Assays store matrix-like data. For `PhIPData` objects, the assays `counts`, `logfc`, and `prob` are required. If any of these matrices were missing from the constructor, they are initialized with empty matrices of the same dimensions. Experimental data can be accessed via `assays(phip_obj)` or `assay(phip_obj, i)` command. `assays(phip_obj)` returns a list of all assays in the object, and list items can be accessed using the `$` or `[[` operators.

```
assays(phip_obj)
```

```
## List of length 3
## names(3): counts logfc prob
```

```
head(assays(phip_obj)$counts)   # Returns the same as assays(phip_obj)[["counts"]]
```

```
##       sample_1 sample_2 sample_3 sample_4 sample_5
## pep_1   324495   667018   270181   294611   849922
## pep_2   331161   205615   676756   227825   556830
## pep_3    31804   884918   731625   845356   717778
## pep_4   286942   183405   887186   200386   944374
## pep_5   635124    19084   652887   852165   116878
## pep_6    69802   419044   693736   177505   332696
```

While `assays(phip_obj)` returns a list of all assays in the `PhIPData` object, `assay(phip_obj, i)` returns a `matrix` of the specified assay. If `i` is missing, `assay(phip_obj)` defaults to the first assay (`counts`). `i` can be a character specifying the assay name or a numeric index of the assay.

```
head(assay(phip_obj, "logfc"))   # Returns the same as assay(phip_obj, 2)
```

```
##         sample_1   sample_2   sample_3    sample_4  sample_5
## pep_1  0.4612149  1.4808873   8.453510   0.3323388 11.594683
## pep_2 -3.6724663 -6.2495714   5.059587  13.2961251 -9.111073
## pep_3  0.5431797 20.7380494 -12.923548 -15.2766681 11.129857
## pep_4 -0.9168914 -0.1049908   1.765798   0.4424645 21.279677
## pep_5 26.9799217 13.0302587   8.535700  10.7396498  4.032496
## pep_6  7.1479608  7.9733597 -12.267401  -0.7219982 -6.348123
```

Since all `PhIPData` objects must contain the `counts`, `logfc`, and `prob` assays, we have defined three homonyous function to conveniently access and modify these assays.

```
head(counts(phip_obj))
```

```
##       sample_1 sample_2 sample_3 sample_4 sample_5
## pep_1   324495   667018   270181   294611   849922
## pep_2   331161   205615   676756   227825   556830
## pep_3    31804   884918   731625   845356   717778
## pep_4   286942   183405   887186   200386   944374
## pep_5   635124    19084   652887   852165   116878
## pep_6    69802   419044   693736   177505   332696
```

```
head(logfc(phip_obj))
```

```
##         sample_1   sample_2   sample_3    sample_4  sample_5
## pep_1  0.4612149  1.4808873   8.453510   0.3323388 11.594683
## pep_2 -3.6724663 -6.2495714   5.059587  13.2961251 -9.111073
## pep_3  0.5431797 20.7380494 -12.923548 -15.2766681 11.129857
## pep_4 -0.9168914 -0.1049908   1.765798   0.4424645 21.279677
## pep_5 26.9799217 13.0302587   8.535700  10.7396498  4.032496
## pep_6  7.1479608  7.9733597 -12.267401  -0.7219982 -6.348123
```

```
head(prob(phip_obj))
```

```
##        sample_1  sample_2    sample_3   sample_4   sample_5
## pep_1 0.1897952 0.7967117 0.556191953 0.68764287 0.35711378
## pep_2 0.5737116 0.4370929 0.404926804 0.07160597 0.79505023
## pep_3 0.8623420 0.5592806 0.003571328 0.70038398 0.86558768
## pep_4 0.6597397 0.6444327 0.456416743 0.69862702 0.15818377
## pep_5 0.9306944 0.6873269 0.294782634 0.20429868 0.06582967
## pep_6 0.4041099 0.2820968 0.933655137 0.11306558 0.77142544
```

After a `PhIPData` object has been created, data for new and existing assays can be set using `<-`. Dimension names of the replacement assays are automatically corrected to be identical to the object names. As we expect assays to contain homogenous data, replacement assays are coerced into matrices. Replacement assays must also be on the same dimension of the existing object.

```
replacement_dat <- matrix(1, nrow = n_peps, ncol = n_samples)

# Replace the counts matrix -------------
head(counts(phip_obj))
```

```
##       sample_1 sample_2 sample_3 sample_4 sample_5
## pep_1   324495   667018   270181   294611   849922
## pep_2   331161   205615   676756   227825   556830
## pep_3    31804   884918   731625   845356   717778
## pep_4   286942   183405   887186   200386   944374
## pep_5   635124    19084   652887   852165   116878
## pep_6    69802   419044   693736   177505   332696
```

```
counts(phip_obj) <- replacement_dat
head(counts(phip_obj))
```

```
##       sample_1 sample_2 sample_3 sample_4 sample_5
## pep_1        1        1        1        1        1
## pep_2        1        1        1        1        1
## pep_3        1        1        1        1        1
## pep_4        1        1        1        1        1
## pep_5        1        1        1        1        1
## pep_6        1        1        1        1        1
```

```
# Add a new assay -----------
head(assay(phip_obj, "new_assay"))
```

```
## Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'head': 'assay(<PhIPData>, i="character", ...)' invalid subscript 'i'
## 'new_assay' not in names(assays(<PhIPData>))
```

```
assay(phip_obj, "new_assay") <- replacement_dat
head(assay(phip_obj, "new_assay"))
```

```
##       sample_1 sample_2 sample_3 sample_4 sample_5
## pep_1        1        1        1        1        1
## pep_2        1        1        1        1        1
## pep_3        1        1        1        1        1
## pep_4        1        1        1        1        1
## pep_5        1        1        1        1        1
## pep_6        1        1        1        1        1
```

```
# Returns and error because `counts`, `logfc`, and `prob` must be in the
# assays of a PhIPData object
assays(phip_obj) <- list(new_assay1 = replacement_dat,
                         new_assay2 = replacement_dat)
```

```
## Error in `assays<-`(`*tmp*`, value = list(new_assay1 = structure(c(1, : `counts`, `logfc`, and `prob` assays must be included in a PhIPData object. The following assays are missing: counts, logfc, prob.
```

## 5.2 Peptide metadata

Information associated with peptides can be accessed using `peptideInfo(phip_obj)` or the inherited `rowRanges(phip_obj)` function. Both functions return a `GRanges` object. `GRanges` objects behave similar to matrices and can be subsetted using the usual 2-dimensional methods. More information about `GRanges` objects can be found [here](http://bioconductor.org/packages/release/bioc/html/GenomicRanges.html).

Information about peptide positions in the protein sequence are stored as `IRanges` in the `GRanges` object. These are specified by `pos_start` and `pos_end` columns in the peptide metadata in the constructor. If these columns do not exist, the start and end positions are set to 0 by default.

```
# Only showing 2 columns for easier viewing
peptideInfo(phip_obj)[, 8:9]
```

```
## GRanges object with 1220 ranges and 2 metadata columns:
##            seqnames    ranges strand |                species
##               <Rle> <IRanges>  <Rle> |            <character>
##      pep_1    pep_1         0      * | Alphacoronavirus Fel..
##      pep_2    pep_2         0      * | Alphacoronavirus Fel..
##      pep_3    pep_3         0      * | Alphacoronavirus Fel..
##      pep_4    pep_4         0      * | Alphacoronavirus Hum..
##      pep_5    pep_5         0      * | Alphacoronavirus Hum..
##        ...      ...       ...    ... .                    ...
##   pep_1216 pep_1216         0      * | Yellow fever virus g..
##   pep_1217 pep_1217         0      * | Yellow fever virus g..
##   pep_1218 pep_1218         0      * | Yellow fever virus g..
##   pep_1219 pep_1219         0      * | Yellow fever virus g..
##   pep_1220 pep_1220         0      * | Yellow fever virus g..
##             interspecies_specific
##                       <character>
##      pep_1                   none
##      pep_2 Bat_coronavirus_1B;B..
##      pep_3 Human_coronavirus_HK..
##      pep_4                   none
##      pep_5 Human_coronavirus_NL..
##        ...                    ...
##   pep_1216 Japanese_encephaliti..
##   pep_1217                   none
##   pep_1218                   none
##   pep_1219 Murray_Valley_enceph..
##   pep_1220                   none
##   -------
##   seqinfo: 1220 sequences from an unspecified genome; no seqlengths
```

## 5.3 Sample metadata

Sample metadata describing the samples can be extracted from the `PhIPData` object using `sampleInfo(phip_obj)` or the inherited function `colData(phip_obj)`. Both functions return a `DataFrame` where each row corresponds to a sample and each column corresponds to some sample description.

```
sampleInfo(phip_obj)
```

```
## DataFrame with 5 rows and 3 columns
##          sample_name      gender       group
##          <character> <character> <character>
## sample_1     sample1           M        ctrl
## sample_2     sample2           F       beads
## sample_3     sample3           F         trt
## sample_4     sample4           F         trt
## sample_5     sample5           M         trt
```

Like in `SummarizedExperiments`/`RangedSummarizedExperiments`, sample metadata can be accessed using the `$` operator from the object. As demonstrated in the [Subsetting](#subsetting) section, this makes subetting data for a subgroup of samples very easy.

```
phip_obj$group
```

```
## [1] "ctrl"  "beads" "trt"   "trt"   "trt"
```

## 5.4 Experimental metadata

Data associated with the experiment such as papers, date the samples were run, etc. can be accessed via the `metadata(phip_obj)` function. Experimental metadata is stored as a list, so it can be used to store *any* type of data.

```
metadata(phip_obj)
```

```
## $date_run
## [1] "2021-01-20"
##
## $reads_per_sample
##  sample_1  sample_2  sample_3  sample_4  sample_5
## 593423181 605066838 616075341 614115405 613582169
```

# 6 Common operations on `PhIPData` objects

## 6.1 Subsetting

Like subsetting matrices and dataframes, `[` can be used for two-dimensional subsetting of `PhIPData` objects.

```
phip_obj[1:10, 1:2]
```

```
## class: PhIPData
## dim: 10 2
## metadata(2): date_run reads_per_sample
## assays(4): counts logfc prob new_assay
## rownames(10): pep_1 pep_2 ... pep_9 pep_10
## rowData names(17): pep_id pep_dna ... interpro pep_name
## colnames(2): sample_1 sample_2
## colData names(3): sample_name gender group
## beads-only name(1): beads
```

As described in the [Sample metadata](#sample-metadata) section, `$` operates on the sample metadata column names, so we can also use `$` to select samples of a particular subgroups.

```
phip_obj[, phip_obj$group == "beads"]
```

```
## class: PhIPData
## dim: 1220 1
## metadata(2): date_run reads_per_sample
## assays(4): counts logfc prob new_assay
## rownames(1220): pep_1 pep_2 ... pep_1219 pep_1220
## rowData names(17): pep_id pep_dna ... interpro pep_name
## colnames(1): sample_2
## colData names(3): sample_name gender group
## beads-only name(1): beads
```

In addition to subsetting by row indices, `PhIPData` supports subsetting rows using peptide metadata information. `subset(phip_obj, row_condition, column_condition)` returns a `PhIPData` object with rows where the specified condition holds.

```
ebv_sub <- subset(phip_obj, grepl("Epstein-Barr virus", species))

peptideInfo(ebv_sub)[, "species"]
```

```
## GRanges object with 23 ranges and 1 metadata column:
##           seqnames    ranges strand |                species
##              <Rle> <IRanges>  <Rle> |            <character>
##   pep_516  pep_516         0      * | Lymphocryptovirus Ep..
##   pep_517  pep_517         0      * | Lymphocryptovirus Ep..
##   pep_518  pep_518         0      * | Lymphocryptovirus Ep..
##   pep_519  pep_519         0      * | Lymphocryptovirus Ep..
##   pep_520  pep_520         0      * | Lymphocryptovirus Ep..
##       ...      ...       ...    ... .                    ...
##   pep_534  pep_534         0      * | Lymphocryptovirus Ep..
##   pep_535  pep_535         0      * | Lymphocryptovirus Ep..
##   pep_536  pep_536         0      * | Lymphocryptovirus Ep..
##   pep_537  pep_537         0      * | Lymphocryptovirus Ep..
##   pep_538  pep_538         0      * | Lymphocryptovirus Ep..
##   -------
##   seqinfo: 1220 sequences from an unspecified genome; no seqlengths
```

To subset all beads-only samples from a `PhIPData` object, we can use the convenient wrapper function `subsetBeads()`:

```
subsetBeads(phip_obj)
```

```
## class: PhIPData
## dim: 1220 1
## metadata(2): date_run reads_per_sample
## assays(4): counts logfc prob new_assay
## rownames(1220): pep_1 pep_2 ... pep_1219 pep_1220
## rowData names(17): pep_id pep_dna ... interpro pep_name
## colnames(1): sample_2
## colData names(3): sample_name gender group
## beads-only name(1): beads
```

## 6.2 `PhIPData` summaries

To assess the quality of the data, we are often interested in the number of reads per sample. This can be done using the `librarySize()` function. Names can be removed by setting the `withDimnames` parameter to `FALSE`.

```
librarySize(phip_obj)
```

```
## sample_1 sample_2 sample_3 sample_4 sample_5
##     1220     1220     1220     1220     1220
```

The proportion of sample reads pulled by each peptide can also be obtained via `propReads()`. Like `librarySize()`, names can also be removed by setting `withDimnames` to `FALSE`.

```
head(propReads(phip_obj))
```

```
##           sample_1     sample_2     sample_3     sample_4     sample_5
## pep_1 0.0008196721 0.0008196721 0.0008196721 0.0008196721 0.0008196721
## pep_2 0.0008196721 0.0008196721 0.0008196721 0.0008196721 0.0008196721
## pep_3 0.0008196721 0.0008196721 0.0008196721 0.0008196721 0.0008196721
## pep_4 0.0008196721 0.0008196721 0.0008196721 0.0008196721 0.0008196721
## pep_5 0.0008196721 0.0008196721 0.0008196721 0.0008196721 0.0008196721
## pep_6 0.0008196721 0.0008196721 0.0008196721 0.0008196721 0.0008196721
```

## 6.3 Using template libraries

Rather than re-importing peptide annotations, `PhIPData` allows the user to create and reuse existing libraries. To save a library for future use, we can use `makeLibrary(object, name_of_library)`. The peptide metadata should be in a matrix-like form such as a `DataFrame` or `data.frame`.

```
# Save virscan_info as the human_virus library
makeLibrary(virscan_info, "human_virus")
```

The stored library can be accessed using `getLibrary(library_name)`. We can then use the stored library to construct a new `PhIPData` object as follows.

```
PhIPData(counts = counts_dat,
         sampleInfo = sample_meta,
         peptideInfo = getLibrary("human_virus"))
```

```
## ! Missing peptide start and end position information. Replacing missing values with 0.
```

```
## class: PhIPData
## dim: 1220 5
## metadata(0):
## assays(3): counts logfc prob
## rownames(1220): pep_1 pep_2 ... pep_1219 pep_1220
## rowData names(17): pep_id pep_dna ... interpro pep_name
## colnames(5): sample_1 sample_2 sample_3 sample_4 sample_5
## colData names(3): sample_name gender group
## beads-only name(1): beads
```

Libraries can be removed with the `removeLibrary(library_name)` command.

```
removeLibrary("human_virus")
```

## 6.4 Using aliases

Peptides are often derived from species with long virus names. To quickly search up all viruses with “[Hh]uman immunodeficiency virus” in the species, you can create an alias of “HIV” to encode for the corresponding regex of interest. Alias’s can be managed with:

* `getAlias(key)`: return the regex for the alias `key`.
* `setAlias(key, pattern)`: create or modify the alias for `key`. If the key-pattern combination already exists in the database, then no changes are made. Otherwise, the pattern is replaced with `pattern`.
* `deleteAlias(key)`: remove an key-pattern combination from the alias database.

```
# Create alias for HIV ----------
setAlias("hiv", "[Hh]uman immunodeficiency virus")

# Use alias ----------
hiv_sub <- subset(phip_obj, grepl(getAlias("hiv"), species))
peptideInfo(hiv_sub)[, "species"]
```

```
## GRanges object with 42 ranges and 1 metadata column:
##           seqnames    ranges strand |                species
##              <Rle> <IRanges>  <Rle> |            <character>
##   pep_855  pep_855         0      * | Primate lentivirus g..
##   pep_856  pep_856         0      * | Primate lentivirus g..
##   pep_857  pep_857         0      * | Primate lentivirus g..
##   pep_858  pep_858         0      * | Primate lentivirus g..
##   pep_859  pep_859         0      * | Primate lentivirus g..
##       ...      ...       ...    ... .                    ...
##   pep_892  pep_892         0      * | Primate lentivirus g..
##   pep_893  pep_893         0      * | Primate lentivirus g..
##   pep_894  pep_894         0      * | Primate lentivirus g..
##   pep_895  pep_895         0      * | Primate lentivirus g..
##   pep_896  pep_896         0      * | Primate lentivirus g..
##   -------
##   seqinfo: 1220 sequences from an unspecified genome; no seqlengths
```

```
# Remove alias from database -----------
deleteAlias("hiv")

# The following command returns an error that the virus does
# not exist in the alias database.
subset(phip_obj, grepl(getAlias("hiv"), species))
```

```
## class: PhIPData
## dim: 0 5
## metadata(2): date_run reads_per_sample
## assays(4): counts logfc prob new_assay
## rownames(0):
## rowData names(17): pep_id pep_dna ... interpro pep_name
## colnames(5): sample_1 sample_2 sample_3 sample_4 sample_5
## colData names(3): sample_name gender group
## beads-only name(1): beads
```

Alias-pattern combinations are case senstive, so an entry with key “hiv” would differ from an entry with key “HIV.” Like libraries, by default the location of the alias database is in the `extdata` folder of the `PhIPData` package. The location to an .rda file with the key-pattern values in a dataframe called alias can be retreived and specified using the `getAliasPath()` and `setAliasPath()` functions, respectively.

## 6.5 Coercion from `PhIPData` to other containers

As packages for identifying differential experession are also commonly used in analyzing PhIP-seq data, the `PhIPData` package supports coercion from `PhIPData` objects to `Lists`, `lists`, `DataFrame`, and `DGELists`. The function `as(phip_obj, "object_type")` converts a `PhIPData` object to a object of `object type`.

For `DGELists`, the `group` slot is automatically populated with the `group` column in the sample metadata, if such a column exists.

```
# PhIPData to DGEList
as(phip_obj, "DGEList")
```

```
## An object of class "DGEList"
## $counts
##       sample_1 sample_2 sample_3 sample_4 sample_5
## pep_1        1        1        1        1        1
## pep_2        1        1        1        1        1
## pep_3        1        1        1        1        1
## pep_4        1        1        1        1        1
## pep_5        1        1        1        1        1
## 1215 more rows ...
##
## $samples
##          group lib.size norm.factors sample_name gender
## sample_1  ctrl     1220            1     sample1      M
## sample_2 beads     1220            1     sample2      F
## sample_3   trt     1220            1     sample3      F
## sample_4   trt     1220            1     sample4      F
## sample_5   trt     1220            1     sample5      M
##
## $genes
##       seqnames start end width strand    pep_id
## pep_1    pep_1     0   0     1      * pep_88674
## pep_2    pep_2     0   0     1      * pep_88822
## pep_3    pep_3     0   0     1      * pep_88848
## pep_4    pep_4     0   0     1      * pep_38968
## pep_5    pep_5     0   0     1      * pep_39072
##                                                                                                                                                                        pep_dna
## pep_1 GATTCCGGGAAGAAGGGTTTCCTTGACACCTTTAACCATCTGAACGAGCTTGAAGATGTCAAAGACATCAAAATTCAGACCATTAAGAACATTATCTGCCCAGATCTGTTGTTGGAGTTGGACTTCGGCGCTATCTGGTACCGCTGCATGCCTGCCTGCTCAGACAAA
## pep_2 TCCAAATGTTGGGTGGAACCAGACCTCTCTGTGGGTCCTCATGAGTTCTGTTCTCAACATACTCTGCAGATCGTGGGTCCAGATGGGGATTATTACCTTCCATACCCAGACCCATCCCGCATTTTGTCCGCTGGTGTCTTCGTCGATGATATCGTCAAGACTGACAAT
## pep_3 GATAGCAAAATTGGCCTTCAAGCCAAGCCTGAGACATGCGGGCTTTTCAAAGACTGCTCCAAAAGTGAACAGTACATCCCACCTGCCTATGCAACAACTTACATGTCTCTCAGTGATAACTTCAAGACTTCAGACGGGCTGGCTGTCAATATCGGCACAAAGGATGTT
## pep_4 GCCAACGGTGTTAAGGCTAAAGGGTATCCTCAATTCGCAGAACTGGTCCCTAGCACAGCCGCTATGCTGTTCGATAGCCATATCGTTAGCAAGGAGTCCGGGAATACCGTCGTGTTGACATTCACTACACGCGTTACTGTTCCTAAAGATCATCCTCACCTTGGTAAG
## pep_5 CCTGAGGTGAATGCAATTACTGTGACAACAGTTTTGGGCCAAACTTATTATCAGCCTATCCAACAAGCTCCTACAGGCATCACTGTCACATTGCTCTCAGGTGTGTTGTACGTTGACGGGCATCGCCTGGCCTCAGGGGTGCAAGTCCATAACCTGCCTGAGTACATG
##                                                         pep_aa   pep_pos
## pep_1 DSGKKGFLDTFNHLNELEDVKDIKIQTIKNIICPDLLLELDFGAIWYRCMPACSDK   673_728
## pep_2 SKCWVEPDLSVGPHEFCSQHTLQIVGPDGDYYLPYPDPSRILSAGVFVDDIVKTDN 4817_4872
## pep_3 DSKIGLQAKPETCGLFKDCSKSEQYIPPAYATTYMSLSDNFKTSDGLAVNIGTKDV 5545_5600
## pep_4 ANGVKAKGYPQFAELVPSTAAMLFDSHIVSKESGNTVVLTFTTRVTVPKDHPHLGK   281_336
## pep_5 PEVNAITVTTVLGQTYYQPIQQAPTGITVTLLSGVLYVDGHRLASGVQVHNLPEYM   113_168
##       pro_len uniprot_acc      refseq                                 species
## pep_1    6709      Q98VG9        <NA>     Alphacoronavirus Feline coronavirus
## pep_2    6709      Q98VG9        <NA>     Alphacoronavirus Feline coronavirus
## pep_3    6709      Q98VG9        <NA>     Alphacoronavirus Feline coronavirus
## pep_4     389      P15130 NP_073556.1 Alphacoronavirus Human coronavirus 229E
## pep_5     225      P15422 NP_073555.1 Alphacoronavirus Human coronavirus 229E
##                                                                                                                                                                                                                                                                             interspecies_specific
## pep_1                                                                                                                                                                                                                                                                                        none
## pep_2 Bat_coronavirus_1B;B1PHI6;3908;GPHEFCS;Human_coronavirus_HKU1;P0C6X2;28681;GPHEFCS;Severe_acute_respiratory_syndrome-related_coronavirus;P0C6V9;28185;GPHEFCS;Human_coronavirus_229E;P0C6X1;28426;GPHEFCS;Betacoronavirus_1;A8R4C0;2781;GPHEFCS;Human_coronavirus_NL63;P0C6X5;29431;GPHEFCS
## pep_3                                             Human_coronavirus_HKU1;P0C6X2;28707;LFKDCSK;Bat_coronavirus_1B;B1PHI6;3935;CGLFKDC;Severe_acute_respiratory_syndrome-related_coronavirus;P0C6V9;28211;GLFKDCS;Human_coronavirus_229E;P0C6X1;28452;CGLFKDC;Betacoronavirus_1;A8R4C0;2807;LFKDCSK
## pep_4                                                                                                                                                                                                                                                                                        none
## pep_5                                                                                                                                                                                                                                                 Human_coronavirus_NL63;Q6Q1R9;61392;TLLSGVL
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               product
## pep_1 Replicase_polyprotein_1ab_(pp1ab)_(ORF1ab_polyprotein)_[Cleaved_into:_Non-structural_protein_1_(nsp1)__Non-structural_protein_2_(nsp2)__Non-structural_protein_3_(nsp3)_(EC_3.4.19.12)_(EC_3.4.22.-)_(PL1-PRO_PL2-PRO)_(PLP1_PLP2)_(Papain-like_proteinases_1_2)_(p195)__Non-structural_protein_4_(nsp4)_(Peptide_HD2)__3C-like_proteinase_(3CL-PRO)_(3CLp)_(EC_3.4.22.-)_(M-PRO)_(nsp5)__Non-structural_protein_6_(nsp6)__Non-structural_protein_7_(nsp7)__Non-structural_protein_8_(nsp8)__Non-structural_protein_9_(nsp9)__Non-structural_protein_10_(nsp10)__Non-structural_protein_11_(nsp11)__RNA-directed_RNA_polymerase_(Pol)_(RdRp)_(EC_2.7.7.48)_(nsp12)__Helicase_(Hel)_(EC_3.6.4.12)_(EC_3.6.4.13)_(nsp13)__Exoribonuclease_(ExoN)_(EC_3.1.13.-)_(nsp14)__Uridylate-specific_endoribonuclease_(EC_3.1.-.-)_(NendoU)_(nsp15)__Putative_2'-O-methyl_transferase_(EC_2.1.1.-)_(nsp16)]
## pep_2 Replicase_polyprotein_1ab_(pp1ab)_(ORF1ab_polyprotein)_[Cleaved_into:_Non-structural_protein_1_(nsp1)__Non-structural_protein_2_(nsp2)__Non-structural_protein_3_(nsp3)_(EC_3.4.19.12)_(EC_3.4.22.-)_(PL1-PRO_PL2-PRO)_(PLP1_PLP2)_(Papain-like_proteinases_1_2)_(p195)__Non-structural_protein_4_(nsp4)_(Peptide_HD2)__3C-like_proteinase_(3CL-PRO)_(3CLp)_(EC_3.4.22.-)_(M-PRO)_(nsp5)__Non-structural_protein_6_(nsp6)__Non-structural_protein_7_(nsp7)__Non-structural_protein_8_(nsp8)__Non-structural_protein_9_(nsp9)__Non-structural_protein_10_(nsp10)__Non-structural_protein_11_(nsp11)__RNA-directed_RNA_polymerase_(Pol)_(RdRp)_(EC_2.7.7.48)_(nsp12)__Helicase_(Hel)_(EC_3.6.4.12)_(EC_3.6.4.13)_(nsp13)__Exoribonuclease_(ExoN)_(EC_3.1.13.-)_(nsp14)__Uridylate-specific_endoribonuclease_(EC_3.1.-.-)_(NendoU)_(nsp15)__Putative_2'-O-methyl_transferase_(EC_2.1.1.-)_(nsp16)]
## pep_3 Replicase_polyprotein_1ab_(pp1ab)_(ORF1ab_polyprotein)_[Cleaved_into:_Non-structural_protein_1_(nsp1)__Non-structural_protein_2_(nsp2)__Non-structural_protein_3_(nsp3)_(EC_3.4.19.12)_(EC_3.4.22.-)_(PL1-PRO_PL2-PRO)_(PLP1_PLP2)_(Papain-like_proteinases_1_2)_(p195)__Non-structural_protein_4_(nsp4)_(Peptide_HD2)__3C-like_proteinase_(3CL-PRO)_(3CLp)_(EC_3.4.22.-)_(M-PRO)_(nsp5)__Non-structural_protein_6_(nsp6)__Non-structural_protein_7_(nsp7)__Non-structural_protein_8_(nsp8)__Non-structural_protein_9_(nsp9)__Non-structural_protein_10_(nsp10)__Non-structural_protein_11_(nsp11)__RNA-directed_RNA_polymerase_(Pol)_(RdRp)_(EC_2.7.7.48)_(nsp12)__Helicase_(Hel)_(EC_3.6.4.12)_(EC_3.6.4.13)_(nsp13)__Exoribonuclease_(ExoN)_(EC_3.1.13.-)_(nsp14)__Uridylate-specific_endoribonuclease_(EC_3.1.-.-)_(NendoU)_(nsp15)__Putative_2'-O-methyl_transferase_(EC_2.1.1.-)_(nsp16)]
## pep_4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Nucleoprotein_(Nucleocapsid_protein)_(NC)_(Protein_N)
## pep_5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Membrane_protein_(M_protein)_(E1_glycoprotein)_(Matrix_glycoprotein)_(Membrane_glycoprotein)
##         description
## pep_1 RecName: Full
## pep_2 RecName: Full
## pep_3 RecName: Full
## pep_4 RecName: Full
## pep_5 RecName: Full
##                                                                                                                                                                                                                                go
## pep_1 GO:0044172;GO:0033644;GO:0044220;GO:0016021;GO:0005524;GO:0004197;GO:0004519;GO:0016896;GO:0004386;GO:0008168;GO:0008242;GO:0003723;GO:0003968;GO:0008270;GO:0039520;GO:0039648;GO:0039548;GO:0006351;GO:0019079;GO:0019082
## pep_2 GO:0044172;GO:0033644;GO:0044220;GO:0016021;GO:0005524;GO:0004197;GO:0004519;GO:0016896;GO:0004386;GO:0008168;GO:0008242;GO:0003723;GO:0003968;GO:0008270;GO:0039520;GO:0039648;GO:0039548;GO:0006351;GO:0019079;GO:0019082
## pep_3 GO:0044172;GO:0033644;GO:0044220;GO:0016021;GO:0005524;GO:0004197;GO:0004519;GO:0016896;GO:0004386;GO:0008168;GO:0008242;GO:0003723;GO:0003968;GO:0008270;GO:0039520;GO:0039648;GO:0039548;GO:0006351;GO:0019079;GO:0019082
## pep_4                                                                                                                                                GO:0044172;GO:0044177;GO:0044196;GO:0044220;GO:0019013;GO:0042802;GO:0003723
## pep_5                                                                                                                                                           GO:0044178;GO:0016021;GO:0019031;GO:0055036;GO:0039660;GO:0019058
##            kegg
## pep_1      <NA>
## pep_2      <NA>
## pep_3      <NA>
## pep_4 vg:918763
## pep_5 vg:918762
##                                                                                                          pfam
## pep_1 PF16688;PF16348;PF06478;PF01661;PF09401;PF06471;PF06460;PF08716;PF08717;PF08710;PF05409;PF01443;PF08715
## pep_2 PF16688;PF16348;PF06478;PF01661;PF09401;PF06471;PF06460;PF08716;PF08717;PF08710;PF05409;PF01443;PF08715
## pep_3 PF16688;PF16348;PF06478;PF01661;PF09401;PF06471;PF06460;PF08716;PF08717;PF08710;PF05409;PF01443;PF08715
## pep_4                                                                                                 PF00937
## pep_5                                                                                                 PF01635
##                                      embl
## pep_1 DQ010921;DQ010921;AY994055;AF326575
## pep_2 DQ010921;DQ010921;AY994055;AF326575
## pep_3 DQ010921;DQ010921;AY994055;AF326575
## pep_4              J04419;X51325;AF304460
## pep_5              X15498;M33560;AF304460
##                                                                                                                                                                                  interpro
## pep_1 IPR027351;IPR032039;IPR032505;IPR009461;IPR027352;IPR002589;IPR009466;IPR014828;IPR014829;IPR014822;IPR027417;IPR008740;IPR013016;IPR009003;IPR009469;IPR018995;IPR029063;IPR014827
## pep_2 IPR027351;IPR032039;IPR032505;IPR009461;IPR027352;IPR002589;IPR009466;IPR014828;IPR014829;IPR014822;IPR027417;IPR008740;IPR013016;IPR009003;IPR009469;IPR018995;IPR029063;IPR014827
## pep_3 IPR027351;IPR032039;IPR032505;IPR009461;IPR027352;IPR002589;IPR009466;IPR014828;IPR014829;IPR014822;IPR027417;IPR008740;IPR013016;IPR009003;IPR009469;IPR018995;IPR029063;IPR014827
## pep_4                                                                                                                                                                           IPR001218
## pep_5                                                                                                                                                                           IPR002574
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  pep_name
## pep_1 Alphacoronavirus Feline coronavirus|Replicase_polyprotein_1ab_(pp1ab)_(ORF1ab_polyprotein)_[Cleaved_into:_Non-structural_protein_1_(nsp1)__Non-structural_protein_2_(nsp2)__Non-structural_protein_3_(nsp3)_(EC_3.4.19.12)_(EC_3.4.22.-)_(PL1-PRO_PL2-PRO)_(PLP1_PLP2)_(Papain-like_proteinases_1_2)_(p195)__Non-structural_protein_4_(nsp4)_(Peptide_HD2)__3C-like_proteinase_(3CL-PRO)_(3CLp)_(EC_3.4.22.-)_(M-PRO)_(nsp5)__Non-structural_protein_6_(nsp6)__Non-structural_protein_7_(nsp7)__Non-structural_protein_8_(nsp8)__Non-structural_protein_9_(nsp9)__Non-structural_protein_10_(nsp10)__Non-structural_protein_11_(nsp11)__RNA-directed_RNA_polymerase_(Pol)_(RdRp)_(EC_2.7.7.48)_(nsp12)__Helicase_(Hel)_(EC_3.6.4.12)_(EC_3.6.4.13)_(nsp13)__Exoribonuclease_(ExoN)_(EC_3.1.13.-)_(nsp14)__Uridylate-specific_endoribonuclease_(EC_3.1.-.-)_(NendoU)_(nsp15)__Putative_2'-O-methyl_transferase_(EC_2.1.1.-)_(nsp16)]
## pep_2 Alphacoronavirus Feline coronavirus|Replicase_polyprotein_1ab_(pp1ab)_(ORF1ab_polyprotein)_[Cleaved_into:_Non-structural_protein_1_(nsp1)__Non-structural_protein_2_(nsp2)__Non-structural_protein_3_(nsp3)_(EC_3.4.19.12)_(EC_3.4.22.-)_(PL1-PRO_PL2-PRO)_(PLP1_PLP2)_(Papain-like_proteinases_1_2)_(p195)__Non-structural_protein_4_(nsp4)_(Peptide_HD2)__3C-like_proteinase_(3CL-PRO)_(3CLp)_(EC_3.4.22.-)_(M-PRO)_(nsp5)__Non-structural_protein_6_(nsp6)__Non-structural_protein_7_(nsp7)__Non-structural_protein_8_(nsp8)__Non-structural_protein_9_(nsp9)__Non-structural_protein_10_(nsp10)__Non-structural_protein_11_(nsp11)__RNA-directed_RNA_polymerase_(Pol)_(RdRp)_(EC_2.7.7.48)_(nsp12)__Helicase_(Hel)_(EC_3.6.4.12)_(EC_3.6.4.13)_(nsp13)__Exoribonuclease_(ExoN)_(EC_3.1.13.-)_(nsp14)__Uridylate-specific_endoribonuclease_(EC_3.1.-.-)_(NendoU)_(nsp15)__Putative_2'-O-methyl_transferase_(EC_2.1.1.-)_(nsp16)]
## pep_3 Alphacoronavirus Feline coronavirus|Replicase_polyprotein_1ab_(pp1ab)_(ORF1ab_polyprotein)_[Cleaved_into:_Non-structural_protein_1_(nsp1)__Non-structural_protein_2_(nsp2)__Non-structural_protein_3_(nsp3)_(EC_3.4.19.12)_(EC_3.4.22.-)_(PL1-PRO_PL2-PRO)_(PLP1_PLP2)_(Papain-like_proteinases_1_2)_(p195)__Non-structural_protein_4_(nsp4)_(Peptide_HD2)__3C-like_proteinase_(3CL-PRO)_(3CLp)_(EC_3.4.22.-)_(M-PRO)_(nsp5)__Non-structural_protein_6_(nsp6)__Non-structural_protein_7_(nsp7)__Non-structural_protein_8_(nsp8)__Non-structural_protein_9_(nsp9)__Non-structural_protein_10_(nsp10)__Non-structural_protein_11_(nsp11)__RNA-directed_RNA_polymerase_(Pol)_(RdRp)_(EC_2.7.7.48)_(nsp12)__Helicase_(Hel)_(EC_3.6.4.12)_(EC_3.6.4.13)_(nsp13)__Exoribonuclease_(ExoN)_(EC_3.1.13.-)_(nsp14)__Uridylate-specific_endoribonuclease_(EC_3.1.-.-)_(NendoU)_(nsp15)__Putative_2'-O-methyl_transferase_(EC_2.1.1.-)_(nsp16)]
## pep_4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       Alphacoronavirus Human coronavirus 229E|Nucleoprotein_(Nucleocapsid_protein)_(NC)_(Protein_N)
## pep_5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                Alphacoronavirus Human coronavirus 229E|Membrane_protein_(M_protein)_(E1_glycoprotein)_(Matrix_glycoprotein)_(Membrane_glycoprotein)
## 1215 more rows ...
```

```
as(phip_obj, "DataFrame")
```

```
## ! Metadata will be lost during coercion.
```

```
## DataFrame with 6100 rows and 28 columns
##           sample sample_name      gender       group     peptide pos_start
##      <character> <character> <character> <character> <character> <integer>
## 1       sample_1     sample1           M        ctrl       pep_1         0
## 2       sample_1     sample1           M        ctrl       pep_2         0
## 3       sample_1     sample1           M        ctrl       pep_3         0
## 4       sample_1     sample1           M        ctrl       pep_4         0
## 5       sample_1     sample1           M        ctrl       pep_5         0
## ...          ...         ...         ...         ...         ...       ...
## 6096    sample_5     sample5           M         trt    pep_1216         0
## 6097    sample_5     sample5           M         trt    pep_1217         0
## 6098    sample_5     sample5           M         trt    pep_1218         0
## 6099    sample_5     sample5           M         trt    pep_1219         0
## 6100    sample_5     sample5           M         trt    pep_1220         0
##        pos_end      pep_id                pep_dna                 pep_aa
##      <integer> <character>            <character>            <character>
## 1            0   pep_88674 GATTCCGGGAAGAAGGGTTT.. DSGKKGFLDTFNHLNELEDV..
## 2            0   pep_88822 TCCAAATGTTGGGTGGAACC.. SKCWVEPDLSVGPHEFCSQH..
## 3            0   pep_88848 GATAGCAAAATTGGCCTTCA.. DSKIGLQAKPETCGLFKDCS..
## 4            0   pep_38968 GCCAACGGTGTTAAGGCTAA.. ANGVKAKGYPQFAELVPSTA..
## 5            0   pep_39072 CCTGAGGTGAATGCAATTAC.. PEVNAITVTTVLGQTYYQPI..
## ...        ...         ...                    ...                    ...
## 6096         0   pep_63041 GCCTACCTCATTATTGGGAT.. AYLIIGILTLLSVVAANELG..
## 6097         0   pep_59593 TCCCGCATGTCTATGGCTAT.. SRMSMAMGTMAGSGYLMFLG..
## 6098         0   pep_62971 TCTGGCATTGCCCAATCTGC.. SGIAQSASVLSFMDKGVPFM..
## 6099         0   pep_25106 GTCACAGAGGGTGAACGCAC.. VTEGERTVRVLDTVEKWLAC..
## 6100         0   pep_25078 AAGACCTTCGAACGCGAGTA.. KTFEREYPTIKQKKPDFILA..
##          pep_pos   pro_len uniprot_acc      refseq                species
##      <character> <numeric> <character> <character>            <character>
## 1        673_728      6709      Q98VG9          NA Alphacoronavirus Fel..
## 2      4817_4872      6709      Q98VG9          NA Alphacoronavirus Fel..
## 3      5545_5600      6709      Q98VG9          NA Alphacoronavirus Fel..
## 4        281_336       389      P15130 NP_073556.1 Alphacoronavirus Hum..
## 5        113_168       225      P15422 NP_073555.1 Alphacoronavirus Hum..
## ...          ...       ...         ...         ...                    ...
## 6096   2241_2296      3412      Q1X881          NA Yellow fever virus g..
## 6097   2185_2240      3412      Q074N0          NA Yellow fever virus g..
## 6098   2325_2380      3412      Q1X880          NA Yellow fever virus g..
## 6099   2661_2716      3411      P03314 NP_041726.1 Yellow fever virus g..
## 6100   1877_1932      3411      P03314 NP_041726.1 Yellow fever virus g..
##       interspecies_specific                product   description
##                 <character>            <character>   <character>
## 1                      none Replicase_polyprotei.. RecName: Full
## 2    Bat_coronavirus_1B;B.. Replicase_polyprotei.. RecName: Full
## 3    Human_coronavirus_HK.. Replicase_polyprotei.. RecName: Full
## 4                      none Nucleoprotein_(Nucle.. RecName: Full
## 5    Human_coronavirus_NL.. Membrane_protein_(M_.. RecName: Full
## ...                     ...                    ...           ...
## 6096 Japanese_encephaliti.. Genome_polyprotein_[.. RecName: Full
## 6097                   none Genome_polyprotein_[.. RecName: Full
## 6098                   none Genome_polyprotein_[.. RecName: Full
## 6099 Murray_Valley_enceph.. Genome_polyprotein_[.. RecName: Full
## 6100                   none Genome_polyprotein_[.. RecName: Full
##                          go        kegg                   pfam
##                 <character> <character>            <character>
## 1    GO:0044172;GO:003364..          NA PF16688;PF16348;PF06..
## 2    GO:0044172;GO:003364..          NA PF16688;PF16348;PF06..
## 3    GO:0044172;GO:003364..          NA PF16688;PF16348;PF06..
## 4    GO:0044172;GO:004417..   vg:918763                PF00937
## 5    GO:0044178;GO:001602..   vg:918762                PF01635
## ...                     ...         ...                    ...
## 6096 GO:0005576;GO:004416..          NA PF01003;PF07652;PF02..
## 6097 GO:0005576;GO:004416..          NA PF01003;PF07652;PF02..
## 6098 GO:0005576;GO:004416..          NA PF01003;PF07652;PF02..
## 6099 GO:0005576;GO:004416..  vg:1502173 PF01003;PF07652;PF02..
## 6100 GO:0005576;GO:004416..  vg:1502173 PF01003;PF07652;PF02..
##                        embl               interpro               pep_name
##                 <character>            <character>            <character>
## 1    DQ010921;DQ010921;AY.. IPR027351;IPR032039;.. Alphacoronavirus Fel..
## 2    DQ010921;DQ010921;AY.. IPR027351;IPR032039;.. Alphacoronavirus Fel..
## 3    DQ010921;DQ010921;AY.. IPR027351;IPR032039;.. Alphacoronavirus Fel..
## 4    J04419;X51325;AF304460              IPR001218 Alphacoronavirus Hum..
## 5    X15498;M33560;AF304460              IPR002574 Alphacoronavirus Hum..
## ...                     ...                    ...                    ...
## 6096               AY968064 IPR011492;IPR000069;.. Yellow fever virus g..
## 6097               DQ235229 IPR011492;IPR000069;.. Yellow fever virus g..
## 6098               AY968065 IPR011492;IPR000069;.. Yellow fever virus g..
## 6099 X03700;X15062;U17066.. IPR011492;IPR000069;.. Yellow fever virus g..
## 6100 X03700;X15062;U17066.. IPR011492;IPR000069;.. Yellow fever virus g..
##         counts     logfc      prob new_assay
##      <numeric> <numeric> <numeric> <numeric>
## 1            1  0.461215  0.189795         1
## 2            1 -3.672466  0.573712         1
## 3            1  0.543180  0.862342         1
## 4            1 -0.916891  0.659740         1
## 5            1 26.979922  0.930694         1
## ...        ...       ...       ...       ...
## 6096         1  -3.28352 0.5288766         1
## 6097         1  -5.58370 0.7411337         1
## 6098         1   5.09689 0.9852727         1
## 6099         1 -11.33410 0.8072356         1
## 6100         1  13.70907 0.0439523         1
```

While `PhIPData` objects can be roughly constructed from `Lists`, `lists`, and `DGELists`, the coercion functions only construct a bare bones `PhIPData` object (with only `counts`, `logfc`, and `prob` assays and sample and peptide information). Any additional list/object components may be discarded.

# 7 `sessionInfo()`

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
##  [1] readr_2.1.5                 dplyr_1.1.4
##  [3] PhIPData_1.18.0             SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] xfun_0.53           bslib_0.9.0         httr2_1.2.1
##  [4] lattice_0.22-7      tzdb_0.5.0          vctrs_0.6.5
##  [7] tools_4.5.1         parallel_4.5.1      curl_7.0.0
## [10] tibble_3.3.0        RSQLite_2.4.3       blob_1.2.4
## [13] pkgconfig_2.0.3     Matrix_1.7-4        dbplyr_2.5.1
## [16] lifecycle_1.0.4     compiler_4.5.1      statmod_1.5.1
## [19] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
## [22] crayon_1.5.3        pillar_1.11.1       jquerylib_0.1.4
## [25] DelayedArray_0.36.0 cachem_1.1.0        limma_3.66.0
## [28] abind_1.4-8         tidyselect_1.2.1    locfit_1.5-9.12
## [31] digest_0.6.37       purrr_1.1.0         bookdown_0.45
## [34] fastmap_1.2.0       grid_4.5.1          archive_1.1.12
## [37] cli_3.6.5           SparseArray_1.10.0  magrittr_2.0.4
## [40] S4Arrays_1.10.0     edgeR_4.8.0         withr_3.0.2
## [43] filelock_1.0.3      rappdirs_0.3.3      bit64_4.6.0-1
## [46] rmarkdown_2.30      XVector_0.50.0      bit_4.6.0
## [49] hms_1.1.4           memoise_2.0.1       evaluate_1.0.5
## [52] knitr_1.50          BiocFileCache_3.0.0 rlang_1.1.6
## [55] glue_1.8.0          DBI_1.2.3           BiocManager_1.30.26
## [58] vroom_1.6.6         jsonlite_2.0.0      R6_2.6.1
```