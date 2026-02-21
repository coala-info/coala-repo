# Proteomics Data Import

Constantin Ahlmann-Eltze

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
  + [1.1 MaxQuant File Overview](#maxquant-file-overview)
* [2 Workflow](#workflow)
* [3 Base R](#base-r)
* [4 Tidyverse](#tidyverse)
* [5 DEP](#dep)
* [6 Session Info](#session-info)

# 1 Introduction

After running your samples on a mass spectrometer, you want to find out if
there are interesting patterns in the data. But the first challenge is how
do you get the data from the files that your mass spectrometer produced into R?

In the following, I will describe several ways of importing data from MaxQuant.
The general approaches will also be applicable to data from other tools, you will
just have to adapt the column names.

## 1.1 MaxQuant File Overview

MaxQuant is a popular tool for identifying, integrating, and combining MS peaks
to derive peptide and protein intensities. MaxQuant produces several output
files including **proteinGroups.txt**. It is usually a tab separated table with
a lot of different columns, which can make it difficult to not get overwhelmed
with information.

The most important columns that every proteinGroups.txt file contains are

* *Protein IDs*: a semicolon delimited text listing all protein identifiers
  that match an identified set of peptides. Most of the time this is just a
  single protein, but sometimes proteins are so similar to each other because
  of gene duplication that it was not possible to distinguish them.
* *Majority protein IDs*: a semicolon delimited text that lists all proteins
  from the *Protein IDs* column which had more than half of their peptides
  identified.
* *Identification type [SAMPLENAME]*: For each sample there is one column that
  explains how the peptide peaks where identified. Either they were directly
  sequenced by the MS2 (“By MS/MS”) or by matching the m/z peak and elution timing
  across samples (“By matching”).
* *Intensity [SAMPLENAME]*: The combined intensity of the peptides of the protein.
  Missing or non-identified proteins are simply stored as `0`. In a label-free
  experiment, this is also often called *LFQ Intensity [SAMPLENAME]*.
* *iBAQ [SAMPLENAME]*: iBAQ is short for intensity-based absolute quantification.
  It is an attempt to make intensity values comparable across proteins. Usually
  the intensity values are only relative, which means that they are only
  comparable within one protein. This is because differences in ionization
  and detection efficiency. It is usually better to just
  compare the *Intensity* columns to identify differentially abundant proteins.
* *Only identified by site*: Contains a “+” if the protein was only identified by
  a modification site.
* *Reverse*: Contains a “+” if the protein matches the reversed part of the
  decoy database.
* *Contaminant*: Contains a “+” if the protein is a commonly occurring
  contaminant.

The last three columns are commonly used to filter out false positive hits.

The full information what each column means is provided in the *tables.pdf* file
in the MaxQuant output folder.

# 2 Workflow

Our goal is to turn this complicated table into a useable matrix or a
`SummarizedExperiment` object. There are several ways to achieve this:

1. Use the base R functions (`read.delim()` and `[<-`) to read in the data
2. Use the `tidyverse` packages to load the file and turn it into a useable object
3. Use the [`DEP`](https://bioconductor.org/packages/DEP/) package
   and the `import_MaxQuant()` function

I will demonstrate each approach using an example file that comes with this
package.

The example file contains the LFQ data from a BioID
experiment in *Drosophila melanogaster*. 11 different Palmitoyltransferases
(short DHHC) were tagged with a promiscuous biotin ligase and all biotinylated
proteins were enriched and identified using label-free mass spectrometry. The
conditions are named after the tagged DHHC and the negative control condition
is called S2R for the cell line. Each condition was measured in triplicates,
which means that there are a total of 36 samples To make the file smaller,
I provide a reduced data set which only contains the first 122 rows of the data.

# 3 Base R

The example file is located in

```
system.file("extdata/proteinGroups.txt",
            package = "proDA", mustWork = TRUE)
#> [1] "/tmp/RtmpAQ176l/Rinst265d2273e94fc7/proDA/extdata/proteinGroups.txt"
```

In this specific file, all spaces have been replaced with dots. This is an
example how each output file from MaxQuant slightly differs. This can make it
difficult to write a generic import function. Instead I will first demonstrate
the most general approach which is to simply use the base R tools for loading
the data and turning it into useful objects.

The first step is to load the full table.

```
full_data <- read.delim(
    system.file("extdata/proteinGroups.txt",
                package = "proDA", mustWork = TRUE),
    stringsAsFactors = FALSE
)

head(colnames(full_data))
#> [1] "Protein.IDs"                   "Majority.protein.IDs"          "Peptide.counts..all."
#> [4] "Peptide.counts..razor.unique." "Peptide.counts..unique."       "Protein.names"
```

Next, I create a matrix of the intensity data, where each sample is a column and
each protein group is a row.

```
# I use a regular expression (regex) to select the intensity columns
intensity_colnames <- grep("^LFQ\\.intensity\\.", colnames(full_data), value=TRUE)

# Create matrix which only contains the intensity columns
data <- as.matrix(full_data[, intensity_colnames])
colnames(data) <- sub("^LFQ\\.intensity\\.", "", intensity_colnames)
# Code missing values explicitly as NA
data[data == 0] <- NA
# log transformation to account for mean-variance relation
data <- log2(data)
# Overview of data
data[1:7, 1:6]
#>      CG1407.01 CG1407.02 CG1407.03 CG4676.01 CG4676.02 CG4676.03
#> [1,]        NA        NA        NA        NA        NA        NA
#> [2,]        NA        NA        NA        NA        NA        NA
#> [3,]        NA        NA        NA        NA  20.20120        NA
#> [4,]        NA  18.87622  18.90683        NA  18.77520        NA
#> [5,]  20.98961  20.40302  19.78941        NA  20.22682        NA
#> [6,]        NA        NA        NA        NA  19.25836        NA
#> [7,]        NA        NA        NA        NA        NA        NA
# Set rownames after showing data, because they are so long
rownames(data) <- full_data$Protein.IDs
```

In the next step I will create an annotation `data.frame` that contains information
on the sample name, the condition and the replicate.

```
annotation_df <- data.frame(
    Condition = sub("\\.\\d+", "", sub("^LFQ\\.intensity\\.",
                                       "", intensity_colnames)),
    Replicate = as.numeric(sub("^LFQ\\.intensity\\.[[:alnum:]]+\\.",
                               "", intensity_colnames)),
    stringsAsFactors = FALSE, row.names = colnames(data)
)
head(annotation_df)
#>           Condition Replicate
#> CG1407.01    CG1407         1
#> CG1407.02    CG1407         2
#> CG1407.03    CG1407         3
#> CG4676.01    CG4676         1
#> CG4676.02    CG4676         2
#> CG4676.03    CG4676         3
```

We can use this data to fit the probabilistic dropout model and
test for differentially abundant proteins.

```
# Not Run
library(proDA)
fit <- proDA(data, design= annotation_df$Condition, col_data = annotation_df)
test_diff(fit, contrast = CG1407 - S2R)
# End Not Run
```

Optionally, we can turn the data also into a `SummarizedExperiment`
or `MSnSet` object

```
library(SummarizedExperiment)
se <- SummarizedExperiment(SimpleList(LFQ=data), colData=annotation_df)
rowData(se) <- full_data[, c("Only.identified.by.site",
                             "Reverse", "Potential.contaminant")]
se
#> class: SummarizedExperiment
#> dim: 122 36
#> metadata(0):
#> assays(1): LFQ
#> rownames(122): Q8IP47;Q9VJP8;Q9V435;A0A023GPQ3;Q2PDT6;Q7K540 A0A023GPV6;A8JV04;Q7YU03 ...
#>   A0A0B4KGU4;Q9VHP0;M9PBB5;P09052 A0A0B4KGW0;Q8IMX7-2;A0A0B4J3Z9;Q8IMX7
#> rowData names(3): Only.identified.by.site Reverse Potential.contaminant
#> colnames(36): CG1407.01 CG1407.02 ... S2R.02 S2R.03
#> colData names(2): Condition Replicate
```

```
library(MSnbase)

fData <- AnnotatedDataFrame(full_data[, c("Only.identified.by.site",
                                 "Reverse", "Potential.contaminant")])
rownames(fData) <- rownames(data)
ms <- MSnSet(data, pData=AnnotatedDataFrame(annotation_df), fData=fData)
ms
#> MSnSet (storageMode: lockedEnvironment)
#> assayData: 122 features, 36 samples
#>   element names: exprs
#> protocolData: none
#> phenoData
#>   sampleNames: CG1407.01 CG1407.02 ... S2R.03 (36 total)
#>   varLabels: Condition Replicate
#>   varMetadata: labelDescription
#> featureData
#>   featureNames: Q8IP47;Q9VJP8;Q9V435;A0A023GPQ3;Q2PDT6;Q7K540 A0A023GPV6;A8JV04;Q7YU03
#>     ... A0A0B4KGW0;Q8IMX7-2;A0A0B4J3Z9;Q8IMX7 (122 total)
#>   fvarLabels: Only.identified.by.site Reverse Potential.contaminant
#>   fvarMetadata: labelDescription
#> experimentData: use 'experimentData(object)'
#> Annotation:
#> - - - Processing information - - -
#>  MSnbase version: 2.36.0
```

Both input types are also accepted by `proDA`.

```
# Not Run
library(proDA)
fit <- proDA(se, design = ~ Condition - 1)
test_diff(fit, contrast = ConditionCG1407 - ConditionS2R)
# End Not Run
```

# 4 Tidyverse

The [tidyverse](https://www.tidyverse.org/) is a set of coherent R packages
that provide many useful functions
for common data analysis tasks. It replicates many of the functionalities
already available in base R packages, but learns from its mistakes and avoids
some of the surprising behaviors. For example strings are never automatically
converted to factors. Another popular feature in the tidyverse is the pipe
operator (`%>%`) that makes it easy to chain complex transformations.

```
library(dplyr)
library(stringr)
library(readr)
library(tidyr)
library(tibble)
# Or short
# library(tidyverse)
```

I first load the full data file

```
# The read_tsv function works faster and more reliable than read.delim
# But it sometimes needs help to identify the right type for each column,
# because it looks only at the first 1,000 elements.
# Here, I explicitly define the `Reverse` column as a character column
full_data <- read_tsv(
    system.file("extdata/proteinGroups.txt",
                package = "proDA", mustWork = TRUE),
    col_types = cols(Reverse = col_character())
)

full_data
#> # A tibble: 122 × 359
#>    Protein.IDs                      Majority.protein.IDs Peptide.counts..all. Peptide.counts..razo…¹
#>    <chr>                            <chr>                <chr>                <chr>
#>  1 Q8IP47;Q9VJP8;Q9V435;A0A023GPQ3… Q8IP47;Q9VJP8;Q9V43… 7;7;7;7;3;1          7;7;7;7;3;1
#>  2 A0A023GPV6;A8JV04;Q7YU03         A0A023GPV6;A8JV04;Q… 2;2;2                2;2;2
#>  3 A0A023GQA5;P24156                A0A023GQA5;P24156    13;13                13;13
#>  4 Q1RKY1;A0A0B4LG19;A0A0B4J401;B7… Q1RKY1;A0A0B4LG19;A… 3;3;3;3;3;3;3;3;3;3… 3;3;3;3;3;3;3;3;3;3;3…
#>  5 A0A0B4JD00;A8DY69;I0E2I4;A0A0B4… A0A0B4JD00;A8DY69;I… 6;6;6;6;6;5;5;5;5    6;6;6;6;6;5;5;5;5
#>  6 A0A0B4JCT8;Q9V780                A0A0B4JCT8;Q9V780    2;2                  2;2
#>  7 A0A0B4LHQ4;A0A0B4JD62;A0A0B4JDB… A0A0B4LHQ4;A0A0B4JD… 3;3;3;3;3;3;3;3;3    3;3;3;3;3;3;3;3;3
#>  8 A0A0B4JCW4;Q9VHJ8;Q95U38         A0A0B4JCW4;Q9VHJ8;Q… 10;10;10             10;10;10
#>  9 Q9VDV4;A0A0B4JCY1;Q8IN71;A0A0B4… Q9VDV4;A0A0B4JCY1;Q… 4;4;3;3              4;4;3;3
#> 10 A0A0B4JCY6;Q7KSF4;A0A0B4KHN1;A0… A0A0B4JCY6;Q7KSF4;A… 6;6;6;6;6;3;3;3;3    6;6;6;6;6;3;3;3;3
#> # ℹ 112 more rows
#> # ℹ abbreviated name: ¹​Peptide.counts..razor.unique.
#> # ℹ 355 more variables: Peptide.counts..unique. <chr>, Protein.names <chr>, Gene.names <chr>,
#> #   Fasta.headers <chr>, Number.of.proteins <dbl>, Peptides <dbl>, Razor...unique.peptides <dbl>,
#> #   Unique.peptides <dbl>, Peptides.CG1407.01 <dbl>, Peptides.CG1407.02 <dbl>,
#> #   Peptides.CG1407.03 <dbl>, Peptides.CG4676.01 <dbl>, Peptides.CG4676.02 <dbl>,
#> #   Peptides.CG4676.03 <dbl>, Peptides.CG51963.01 <dbl>, Peptides.CG51963.02 <dbl>, …
```

Next, I create a tidy version of the data set. I pipe (`%>%`) the
results from each transformation to the next transformation, to
first `select` the columns of interest, reshape (`gather`) the dataset from
wide to long format, and lastly create new columns with `mutate`.

```
# I explicitly call `dplyr::select()` because there is a naming conflict
# between the tidyverse and BioConductor packages for `select()` function
tidy_data <- full_data %>%
    dplyr::select(ProteinID=Protein.IDs, starts_with("LFQ.intensity.")) %>%
    gather(Sample, Intensity, starts_with("LFQ.intensity.")) %>%
    mutate(Condition = str_match(Sample,
                 "LFQ\\.intensity\\.([[:alnum:]]+)\\.\\d+")[,2]) %>%
    mutate(Replicate = as.numeric(str_match(Sample,
                 "LFQ\\.intensity\\.[[:alnum:]]+\\.(\\d+)")[,2])) %>%
    mutate(SampleName = paste0(Condition, ".", Replicate))

tidy_data
#> # A tibble: 4,392 × 6
#>    ProteinID                                         Sample Intensity Condition Replicate SampleName
#>    <chr>                                             <chr>      <dbl> <chr>         <dbl> <chr>
#>  1 Q8IP47;Q9VJP8;Q9V435;A0A023GPQ3;Q2PDT6;Q7K540     LFQ.i…         0 CG1407            1 CG1407.1
#>  2 A0A023GPV6;A8JV04;Q7YU03                          LFQ.i…         0 CG1407            1 CG1407.1
#>  3 A0A023GQA5;P24156                                 LFQ.i…         0 CG1407            1 CG1407.1
#>  4 Q1RKY1;A0A0B4LG19;A0A0B4J401;B7YZL2;A1ZBH5;B7YZL… LFQ.i…         0 CG1407            1 CG1407.1
#>  5 A0A0B4JD00;A8DY69;I0E2I4;A0A0B4JCQ5;Q8SXP0;E5DK1… LFQ.i…   2082100 CG1407            1 CG1407.1
#>  6 A0A0B4JCT8;Q9V780                                 LFQ.i…         0 CG1407            1 CG1407.1
#>  7 A0A0B4LHQ4;A0A0B4JD62;A0A0B4JDB5;A0A0B4LGQ5;A0A0… LFQ.i…         0 CG1407            1 CG1407.1
#>  8 A0A0B4JCW4;Q9VHJ8;Q95U38                          LFQ.i…   2858600 CG1407            1 CG1407.1
#>  9 Q9VDV4;A0A0B4JCY1;Q8IN71;A0A0B4KGH4               LFQ.i…   1291400 CG1407            1 CG1407.1
#> 10 A0A0B4JCY6;Q7KSF4;A0A0B4KHN1;A0A0B4KGT8;Q9VEN1;A… LFQ.i…         0 CG1407            1 CG1407.1
#> # ℹ 4,382 more rows
```

Using the tidy data, I create the annotation data frame and the data matrix.

```
data <- tidy_data %>%
    mutate(Intensity = ifelse(Intensity == 0, NA, log2(Intensity))) %>%
    dplyr::select(ProteinID, SampleName, Intensity) %>%
    spread(SampleName, Intensity) %>%
    column_to_rownames("ProteinID") %>%
    as.matrix()

data[1:4, 1:7]
#>                          CG1407.1 CG1407.2 CG1407.3 CG4676.1 CG4676.2 CG4676.3 CG51963.1
#> A0A023GPV6;A8JV04;Q7YU03       NA       NA       NA       NA       NA       NA        NA
#> A0A023GQA5;P24156              NA       NA       NA       NA 20.20120       NA  18.09151
#> A0A0B4JCT8;Q9V780              NA       NA       NA       NA 19.25836       NA        NA
#> A0A0B4JCW4;Q9VHJ8;Q95U38 21.44688 22.29852 21.19821       NA 21.91189       NA  22.14476

annotation_df <- tidy_data %>%
    dplyr::select(SampleName, Condition, Replicate) %>%
    distinct() %>%
    arrange(Condition, Replicate) %>%
    as.data.frame() %>%
    column_to_rownames("SampleName")

annotation_df
#>           Condition Replicate
#> CG1407.1     CG1407         1
#> CG1407.2     CG1407         2
#> CG1407.3     CG1407         3
#> CG4676.1     CG4676         1
#> CG4676.2     CG4676         2
#> CG4676.3     CG4676         3
#> CG51963.1   CG51963         1
#> CG51963.2   CG51963         2
#> CG51963.3   CG51963         3
#> CG5620A.1   CG5620A         1
#> CG5620A.2   CG5620A         2
#> CG5620A.3   CG5620A         3
#> CG5620B.1   CG5620B         1
#> CG5620B.2   CG5620B         2
#> CG5620B.3   CG5620B         3
#> CG5880.1     CG5880         1
#> CG5880.2     CG5880         2
#> CG5880.3     CG5880         3
#> CG6017.1     CG6017         1
#> CG6017.2     CG6017         2
#> CG6017.3     CG6017         3
#> CG6618.1     CG6618         1
#> CG6618.2     CG6618         2
#> CG6618.3     CG6618         3
#> CG6627.1     CG6627         1
#> CG6627.2     CG6627         2
#> CG6627.3     CG6627         3
#> CG8314.1     CG8314         1
#> CG8314.2     CG8314         2
#> CG8314.3     CG8314         3
#> GsbPI.1       GsbPI         1
#> GsbPI.2       GsbPI         2
#> GsbPI.3       GsbPI         3
#> S2R.1           S2R         1
#> S2R.2           S2R         2
#> S2R.3           S2R         3
```

Optionally, we can again turn this into a `SummarizedExperiment` or `MSnSet` object

```
library(SummarizedExperiment)
se <- SummarizedExperiment(SimpleList(LFQ=data), colData=annotation_df)
rowData(se) <- full_data[, c("Only.identified.by.site",
                             "Reverse", "Potential.contaminant")]
se
#> class: SummarizedExperiment
#> dim: 122 36
#> metadata(0):
#> assays(1): LFQ
#> rownames(122): A0A023GPV6;A8JV04;Q7YU03 A0A023GQA5;P24156 ... Q9VHX9;A0A0B4KFA6
#>   Q9VNF8;A0A0B4K6T4;A0A0B4K5Z8
#> rowData names(3): Only.identified.by.site Reverse Potential.contaminant
#> colnames(36): CG1407.1 CG1407.2 ... S2R.2 S2R.3
#> colData names(2): Condition Replicate
```

```
library(MSnbase)

fData <- AnnotatedDataFrame(full_data[, c("Only.identified.by.site",
                                 "Reverse", "Potential.contaminant")])
rownames(fData) <- rownames(data)
#> Warning: Setting row names on a tibble is deprecated.
ms <- MSnSet(data, pData=AnnotatedDataFrame(annotation_df), fData=fData)
ms
#> MSnSet (storageMode: lockedEnvironment)
#> assayData: 122 features, 36 samples
#>   element names: exprs
#> protocolData: none
#> phenoData
#>   sampleNames: CG1407.1 CG1407.2 ... S2R.3 (36 total)
#>   varLabels: Condition Replicate
#>   varMetadata: labelDescription
#> featureData
#>   featureNames: 1 2 ... 3 (122 total)
#>   fvarLabels: Only.identified.by.site Reverse Potential.contaminant
#>   fvarMetadata: labelDescription
#> experimentData: use 'experimentData(object)'
#> Annotation:
#> - - - Processing information - - -
#>  MSnbase version: 2.36.0
```

Both input types are also accepted by `proDA`.

```
# Not Run
library(proDA)
fit <- proDA(se, design = ~ Condition - 1)
test_diff(fit, contrast = ConditionCG1407 - ConditionS2R)
# End Not Run
```

# 5 DEP

DEP is a [BioConductor package](https://bioconductor.org/packages/release/bioc/html/DEP.html)
that is designed for the analysis of
mass spectrometry data. It provides helper functions
to impute missing values and makes it easy to run
[limma](https://bioconductor.org/packages/release/bioc/html/limma.html) on
the completed dataset.

To load the data, we need to provide all the column names of the
intensity values. I then call the `import_MaxQuant()` function that directly
creates a `SummarizedExperiment` object.

```
library(DEP)
#> Warning in fun(libname, pkgname): Package 'DEP' is deprecated and will be removed from Bioconductor
#> version 3.23
#>
#> Attaching package: 'DEP'
#> The following object is masked from 'package:MSnbase':
#>
#>     impute
#> The following object is masked from 'package:ProtGenerics':
#>
#>     impute
#> The following object is masked from 'package:proDA':
#>
#>     test_diff

full_data <- read.delim(
    system.file("extdata/proteinGroups.txt",
                package = "proDA", mustWork = TRUE),
    stringsAsFactors = FALSE
)

exp_design <- data.frame(
   label =c("LFQ.intensity.CG1407.01", "LFQ.intensity.CG1407.02",  "LFQ.intensity.CG1407.03",  "LFQ.intensity.CG4676.01",  "LFQ.intensity.CG4676.02", "LFQ.intensity.CG4676.03", "LFQ.intensity.CG51963.01", "LFQ.intensity.CG51963.02", "LFQ.intensity.CG51963.03","LFQ.intensity.CG5620A.01", "LFQ.intensity.CG5620A.02", "LFQ.intensity.CG5620A.03", "LFQ.intensity.CG5620B.01","LFQ.intensity.CG5620B.02", "LFQ.intensity.CG5620B.03", "LFQ.intensity.CG5880.01", "LFQ.intensity.CG5880.02",  "LFQ.intensity.CG5880.03",  "LFQ.intensity.CG6017.01",  "LFQ.intensity.CG6017.02", "LFQ.intensity.CG6017.03", "LFQ.intensity.CG6618.01",  "LFQ.intensity.CG6618.02",  "LFQ.intensity.CG6618.03",  "LFQ.intensity.CG6627.01", "LFQ.intensity.CG6627.02", "LFQ.intensity.CG6627.03",  "LFQ.intensity.CG8314.01", "LFQ.intensity.CG8314.02",  "LFQ.intensity.CG8314.03", "LFQ.intensity.GsbPI.001", "LFQ.intensity.GsbPI.002",  "LFQ.intensity.GsbPI.003",  "LFQ.intensity.S2R.01", "LFQ.intensity.S2R.02", "LFQ.intensity.S2R.03"),
   condition = c("CG1407", "CG1407", "CG1407", "CG4676", "CG4676", "CG4676", "CG51963", "CG51963", "CG51963", "CG5620A", "CG5620A", "CG5620A", "CG5620B", "CG5620B", "CG5620B", "CG5880", "CG5880", "CG5880", "CG6017", "CG6017", "CG6017", "CG6618", "CG6618", "CG6618", "CG6627", "CG6627", "CG6627", "CG8314", "CG8314", "CG8314", "GsbPI", "GsbPI", "GsbPI", "S2R", "S2R", "S2R" ),
   replicate = rep(1:3, times=12),
   stringsAsFactors = FALSE
)

se <- import_MaxQuant(full_data, exp_design)
#> Filtering based on 'Reverse', 'Potential.contaminant' column(s)
#> Making unique names
#> Obtaining SummarizedExperiment object
se
#> class: SummarizedExperiment
#> dim: 122 36
#> metadata(0):
#> assays(1): ''
#> rownames(122): yuri A0A023GPV6 ... bel Miro
#> rowData names(325): Protein.IDs Majority.protein.IDs ... name ID
#> colnames(36): CG1407_1 CG1407_2 ... S2R_2 S2R_3
#> colData names(4): label ID condition replicate
assay(se)[1:5, 1:5]
#>            CG1407_1 CG1407_2 CG1407_3 CG4676_1 CG4676_2
#> yuri             NA       NA       NA       NA       NA
#> A0A023GPV6       NA       NA       NA       NA       NA
#> l(2)37Cc         NA       NA       NA       NA 20.20120
#> CG10737-RC       NA 18.87622 18.90683       NA 18.77520
#> Lpin       20.98961 20.40302 19.78941       NA 20.22682
```

Again, we can run `proDA` on the result:

```
# Not Run
library(proDA)
fit <- proDA(se, design = ~ condition - 1)
# Here, we need to be specific, because DEP also has a test_diff method
proDA::test_diff(fit, contrast = conditionCG1407 - conditionS2R)
# End Not Run
```

# 6 Session Info

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
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
#>  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
#> [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#>  [1] DEP_1.32.0                  tibble_3.3.0                tidyr_1.3.1
#>  [4] readr_2.1.5                 stringr_1.5.2               dplyr_1.1.4
#>  [7] MSnbase_2.36.0              ProtGenerics_1.42.0         mzR_2.44.0
#> [10] Rcpp_1.1.0                  SummarizedExperiment_1.40.0 Biobase_2.70.0
#> [13] GenomicRanges_1.62.0        Seqinfo_1.0.0               IRanges_2.44.0
#> [16] S4Vectors_0.48.0            BiocGenerics_0.56.0         generics_0.1.4
#> [19] MatrixGenerics_1.22.0       matrixStats_1.5.0           proDA_1.24.0
#> [22] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3          jsonlite_2.0.0              shape_1.4.6.1
#>   [4] MultiAssayExperiment_1.36.0 magrittr_2.0.4              magick_2.9.0
#>   [7] farver_2.1.2                MALDIquant_1.22.3           rmarkdown_2.30
#>  [10] GlobalOptions_0.1.2         fs_1.6.6                    vctrs_0.6.5
#>  [13] tinytex_0.57                htmltools_0.5.8.1           S4Arrays_1.10.0
#>  [16] BiocBaseUtils_1.12.0        SparseArray_1.10.0          mzID_1.48.0
#>  [19] sass_0.4.10                 bslib_0.9.0                 htmlwidgets_1.6.4
#>  [22] extraDistr_1.10.0           plyr_1.8.9                  sandwich_3.1-1
#>  [25] impute_1.84.0               zoo_1.8-14                  cachem_1.1.0
#>  [28] igraph_2.2.1                mime_0.13                   lifecycle_1.0.4
#>  [31] iterators_1.0.14            pkgconfig_2.0.3             Matrix_1.7-4
#>  [34] R6_2.6.1                    fastmap_1.2.0               shiny_1.11.1
#>  [37] clue_0.3-66                 digest_0.6.37               pcaMethods_2.2.0
#>  [40] colorspace_2.1-2            Spectra_1.20.0              abind_1.4-8
#>  [43] compiler_4.5.1              bit64_4.6.0-1               withr_3.0.2
#>  [46] doParallel_1.0.17           S7_0.2.0                    BiocParallel_1.44.0
#>  [49] MASS_7.3-65                 DelayedArray_0.36.0         rjson_0.2.23
#>  [52] tools_4.5.1                 otel_0.2.0                  PSMatch_1.14.0
#>  [55] httpuv_1.6.16               glue_1.8.0                  QFeatures_1.20.0
#>  [58] promises_1.4.0              grid_4.5.1                  cluster_2.1.8.1
#>  [61] reshape2_1.4.4              gtable_0.3.6                tzdb_0.5.0
#>  [64] preprocessCore_1.72.0       hms_1.1.4                   MetaboCoreUtils_1.18.0
#>  [67] utf8_1.2.6                  XVector_0.50.0              foreach_1.5.2
#>  [70] pillar_1.11.1               vroom_1.6.6                 limma_3.66.0
#>  [73] later_1.4.4                 circlize_0.4.16             gmm_1.9-1
#>  [76] lattice_0.22-7              bit_4.6.0                   tidyselect_1.2.1
#>  [79] ComplexHeatmap_2.26.0       knitr_1.50                  bookdown_0.45
#>  [82] imputeLCMD_2.1              xfun_0.53                   shinydashboard_0.7.3
#>  [85] statmod_1.5.1               DT_0.34.0                   pheatmap_1.0.13
#>  [88] stringi_1.8.7               lazyeval_0.2.2              yaml_2.3.10
#>  [91] evaluate_1.0.5              codetools_0.2-20            MsCoreUtils_1.22.0
#>  [94] archive_1.1.12              BiocManager_1.30.26         cli_3.6.5
#>  [97] affyio_1.80.0               xtable_1.8-4                jquerylib_0.1.4
#> [100] dichromat_2.0-0.1           norm_1.0-11.1               png_0.1-8
#> [103] XML_3.99-0.19               parallel_4.5.1              ggplot2_4.0.0
#> [106] assertthat_0.2.1            AnnotationFilter_1.34.0     mvtnorm_1.3-3
#> [109] scales_1.4.0                tmvtnorm_1.7                affy_1.88.0
#> [112] ncdf4_1.24                  purrr_1.1.0                 crayon_1.5.3
#> [115] GetoptLong_1.0.5            rlang_1.1.6                 vsn_3.78.0
```