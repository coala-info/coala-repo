# Introduction to the PGCA Package

#### David Kepplinger, Mandeep Sasaki, Gabriela Cohen Freue

#### March 31, 2017

* [1 Introduction](#introduction)
* [2 Installation](#installation)
  + [2.1 Example Data](#example-data)
* [3 Algorithm](#algorithm)
* [4 Building the Dictionary](#building-the-dictionary)
* [5 Applying the Dictionary](#applying-the-dictionary)
* [6 A Larger Example](#a-larger-example)
  + [6.1 Saving the Dictionary](#saving-the-dictionary)
* [7 References](#references)

# 1 Introduction

Shotgun proteomic techniques have gained popularity in the last decades allowing a global and relatively high throughput identification and quantitation of proteins in complex samples. In a typical experimental workflow the protein mixture is first digested into peptides, which are then separated by liquid chromatography and sequenced by tandem mass spectrometry (MS/MS). As described in [[1]](#ref-1), one big challenge with shotgun proteomic techinques is that the set of proteins present in the sample before digestion needs to be recovered from the list of identified peptides. Since the same peptide sequences can be present in multiple proteins, the link between proteins originally present in the sample and proteins identified from observed peptides is often lost.

Many software tools have been developed to process MS/MS data addressing the protein identification problem, for instance ProteinPilot™ or Thermo Proteome Discoverer™. These software are used to identify the peptides and proteins original present in the sample as well as their to measuer their abundances (see [Example Data](#example-data) for more information about output data). To address the protein inference problem, most of them combine the set of all plausible protein identifiers matching a common set of peptides into a protein group.

Moderate to large sutdies invovle the analysis of many samples thus requiring multiple batches or experimental runs to quantitate the proteins in all available samples, even when multiplex technologies are used. For example, only eight samples can be processed at a time using multiplex iTRAQ. The protein groups, however, are created for each experimental run separately. This pose a big challenge in comparing protein levels among different experiments.

Protein Group Code Algorithm (PGCA) is a computationally inexpensive algorithm to merge protein summaries from multiple experimental quantitative proteomics data. The algorithm connects two or more groups with overlapping accession numbers. In some cases, pairwise groups are mutually exclusive but they may still be connected by another group (or set of groups) with overlapping accession numbers. Thus, groups created by PGCA from multiple experimental runs (i.e., global groups) are called “connected” groups [[1, 2]](#ref-1). These identified global protein groups enable the analysis of quantitative data available for protein groups instead of unique protein identifiers.

[Back to Top](#TOC)

# 2 Installation

The package can be easily installed from Bioconductor using the commands

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("pgca")
```

The main function provided by the package is `pgcaDict()` which builds a dictionary mapping local protein groups to global protein groups. This dictionary can be applied to experimental runs with `applyDict()` to assign a common protein group code (PGC) to all proteins in the same global protein group. Furthermore, the dictionary can be saved as a text file with `saveDict()`.

In the remainder of this document we will briefly go over the main functions, see the basic operations and have a look at the outputs. Additional options are listed at the end and additional parameters for these functions are available in the help files.

The first step is to load the `pgca` package:

```
library(pgca)
```

## 2.1 Example Data

The package ships MS/MS datasets from four experimental runs: `BET1947_v339`, `BET2007_v339`, `BET2047_v339`, and `BET2067_v339`. In all four runs, the raw MS/MS data was processed using ProteinPilot™ software v3.0 with the integrated Paragon™ Search and ProGroup™ algorithms and searching against the International Protein Index (IPI HUMAN v3.39) database. Within each run, ProteinPilot™ organizes the set of proteins matching the identified peptide list into a group identified by the local group identifier.

The format of each dataset is identical. Each dataset contains the columns *N* (the local group identifier), *Accession* (the accession number), *Gene\_Symbol* (the gene symbol), and *Protein\_Name* (the protein name). As example, we can look at the first few rows of the dataset `BET2007_v339`:

```
head(BET2007_v339)
```

| N | Accession | Gene\_Symbol | Protein\_Name |
| --- | --- | --- | --- |
| 1 | IPI:IPI00643525.1 | C4A | Complement component 4A |
| 2 | IPI:IPI00478003.1 | A2M | Alpha-2-macroglobulin precursor |
| 3 | IPI:IPI00017601.1 | CP | Ceruloplasmin precursor |
| 4 | IPI:IPI00029739.5 | CFH | Isoform 1 of Complement factor H precursor |
| 5 | IPI:IPI00021885.1 | FGA | Isoform 1 of Fibrinogen alpha chain precursor |
| 5 | IPI:IPI00029717.1 | FGA | Isoform 2 of Fibrinogen alpha chain precursor |

[Back to Top](#TOC)

# 3 Algorithm

The algorithm can be decomposed into two stages: (1) creating local groups and (2) updating the dictionary. In the first stage, local groups with overlapping accession numbers are merged. The second stage merges sets of local protein groups from different experimental runs with overlapping accession numbers by creating a set of global protein groups. Each global protein group is built from the union of connected local groups across multiple runs. This corresponds to the algorithm *PGCA-All* in the reference publication [[1]](#ref-1).

[Back to Top](#TOC)

# 4 Building the Dictionary

We build a dictionary for protein groups from 2 of the MS/MS data files. We will use *BET2007\_v339* and *BET2047\_v339* as examples. In these 2 runs, ProteinPilot™ matched the identified peptides to different protein identifiers from gene PRSS2 (IPI HUMAN v3.39). In *BET2007\_v339* the identifier accession ID is ‘IPI00011695.8’ and the local group identifier is 250:

```
subset(BET2007_v339, N %in% N[Gene_Symbol == 'PRSS2'])
```

|  | N | Accession | Gene\_Symbol | Protein\_Name |
| --- | --- | --- | --- | --- |
| 502 | 250 | IPI:IPI00011695.8 | PRSS2 | Protease serine 2 isoform B |

In the other experimental run, *BET2047\_v339*, ProteinPilot™ has chosen a different protein as identifier and a different local group. The group in this run comprises 2 proteins. The other protein identified by accession ID ‘IPI00815665.1’ is not detected in *BET2007\_v339*.

```
subset(BET2047_v339, N %in% N[Gene_Symbol == 'PRSS2'])
```

|  | N | Accession | Gene\_Symbol | Protein\_Name |
| --- | --- | --- | --- | --- |
| 173 | 105 | IPI:IPI00815665.1 | PRSS1 | PRSS1 protein |
| 174 | 105 | IPI:IPI00011695.8 | PRSS2 | Protease serine 2 isoform B |

If we would only use the top-protein selected by the processing software within each run, we would not be able to compare PRSS2 between samples in these two experimental runs. PGCA, on the other hand, will create a new global protein group comprising PRSS1 and PRSS2.

To build the dictionary, the datasets can be used directly as input to `pgcaDict()`. The function does not know about the column name for the gene symbol. If we want to retain that column in the dictionary, we need to specify its name via the `col.mapping` argument.

```
dict <- pgcaDict(
    BET2007_v339,
    BET2047_v339,
    col.mapping=c(gene.symbol="Gene_Symbol")
)
```

In the larger example below we will see how to build the dictionary from files or directories instead of data frames.

When printing the dictionary, it will tell the user how many unique proteins have been identified in the input data and how many global protein groups the algorithm built. The output also lists the input data used to build the dictionary.

```
dict
```

```
## Dictionary mapping 841 proteins to 379 protein groups built from 2 data frames
##  BET2007_v339
##  BET2047_v339
```

We see that the local protein groups have been combined to 379 global protein groups. In the resulting dictionary, PRSS2 has now been assigned to protein group 250 which contains all IPI accession ids from the two files included in the dictionary build and both local groups.

```
subset(dict$dictionary, pg %in% pg[gene == 'PRSS2'])
```

|  | pg | gid | accs | prot | gene |
| --- | --- | --- | --- | --- | --- |
| 572 | 250 | 250 | IPI:IPI00011695.8 | Protease serine 2 isoform B | PRSS2 |
| 573 | 250 | 105 | IPI:IPI00815665.1 | PRSS1 protein | PRSS1 |

[Back to Top](#TOC)

# 5 Applying the Dictionary

Now we have a mapping of protein group codes needed to translate the two MS/MS data sets. We use the `applyDict()` function to apply the protein group codes to our data files. This will translate the data files to ensure they contain comparable group identifiers for use in downstream analyses. In this example we input our pre-loaded data frames and do not specify an output directory to get the results as a list of data frames.

```
translated <- applyDict(BET2007_v339, BET2047_v339, dict=dict)
```

In the translated data files, a protein group code (PGC) column is appended. We see that PGC 250 is used for PRSS2 in both data files.

```
subset(translated$BET2007_v339, Gene_Symbol == "PRSS2")
```

|  | N | Accession | Gene\_Symbol | Protein\_Name | PGC |
| --- | --- | --- | --- | --- | --- |
| 502 | 250 | IPI:IPI00011695.8 | PRSS2 | Protease serine 2 isoform B | 250 |

```
subset(translated$BET2047_v339, Gene_Symbol == "PRSS2")
```

|  | N | Accession | Gene\_Symbol | Protein\_Name | PGC |
| --- | --- | --- | --- | --- | --- |
| 174 | 105 | IPI:IPI00011695.8 | PRSS2 | Protease serine 2 isoform B | 250 |

This allows us to compare the protein levels for the group containing PRSS2 across experiments.

[Back to Top](#TOC)

# 6 A Larger Example

Now we use 4 MS/MS data sets to build our dictionary. We can use the `pgcaDict()` function to read the data directly from the files. The files contain the gene symbol in the column `"Gene_Symbol"` and we want to retain it.

```
dict.from.files <- pgcaDict(
    system.file("extdata", "BET1947_v339.txt", package="pgca"),
    system.file("extdata", "BET2007_v339.txt", package="pgca"),
    system.file("extdata", "BET2047_v339.txt", package="pgca"),
    system.file("extdata", "BET2067_v339.txt", package="pgca"),
    col.mapping=c(gene.symbol="Gene_Symbol")
)

dict.from.files
```

```
## Dictionary mapping 1171 proteins to 510 protein groups built from 4 files
##  /tmp/RtmpMV1QDP/Rinst23276666bffbc1/pgca/extdata/BET1947_v339.txt
##  /tmp/RtmpMV1QDP/Rinst23276666bffbc1/pgca/extdata/BET2007_v339.txt
##  /tmp/RtmpMV1QDP/Rinst23276666bffbc1/pgca/extdata/BET2047_v339.txt
##  /tmp/RtmpMV1QDP/Rinst23276666bffbc1/pgca/extdata/BET2067_v339.txt
```

These four files are all in the same directory. Since they are the only files in this directory, we can use the function `pgcaDict()` to create the same dictionary as above:

```
dict.from.dir <- pgcaDict(
    system.file("extdata", package="pgca"),
    col.mapping=c(gene.symbol="Gene_Symbol")
)
dict.from.dir
```

```
## Dictionary mapping 1171 proteins to 510 protein groups built from 4 files
##  /tmp/RtmpMV1QDP/Rinst23276666bffbc1/pgca/extdata/BET1947_v339.txt
##  /tmp/RtmpMV1QDP/Rinst23276666bffbc1/pgca/extdata/BET2007_v339.txt
##  /tmp/RtmpMV1QDP/Rinst23276666bffbc1/pgca/extdata/BET2047_v339.txt
##  /tmp/RtmpMV1QDP/Rinst23276666bffbc1/pgca/extdata/BET2067_v339.txt
## in the directory
##  /tmp/RtmpMV1QDP/Rinst23276666bffbc1/pgca/extdata
```

The resulting protein group code for PRSS2 is now 103 and we see the protein group is much larger because the local protein group 103 in the dataset `BET1947_v339` contains three other proteins besides PRSS2.

```
subset(dict.from.dir$dictionary, pg %in% pg[gene == "PRSS2"])
```

|  | pg | gid | accs | prot | gene |
| --- | --- | --- | --- | --- | --- |
| 216 | 103 | 250 | IPI:IPI00011695.8 | Protease serine 2 isoform B | PRSS2 |
| 217 | 103 | 187 | IPI:IPI00169276.2 | Trypsinogen C | - |
| 218 | 103 | 105 | IPI:IPI00815665.1 | PRSS1 protein | PRSS1 |
| 219 | 103 | 82 | IPI:IPI00011694.1 | Trypsin-1 precursor | PRSS1 |

With the addition of new files and the resulting new dictionary, all MS/MS files require another translation.

```
translated2 <- applyDict(BET1947_v339, BET2007_v339, BET2047_v339, BET2067_v339,
                         dict=dict.from.dir)
```

Re-translation of the files using the updated dictionary provides updated protein groups for all four MS/MS datasets.

```
subset(translated2$BET1947_v339, Gene_Symbol == 'PRSS2')
```

|  | N | Accession | Gene\_Symbol | Protein\_Name | PGC |
| --- | --- | --- | --- | --- | --- |
| 188 | 103 | IPI:IPI00011695.8 | PRSS2 | Protease serine 2 isoform B | 103 |

```
subset(translated2$BET2007_v339, Gene_Symbol == 'PRSS2')
```

|  | N | Accession | Gene\_Symbol | Protein\_Name | PGC |
| --- | --- | --- | --- | --- | --- |
| 502 | 250 | IPI:IPI00011695.8 | PRSS2 | Protease serine 2 isoform B | 103 |

## 6.1 Saving the Dictionary

We can also save the dictionary we just generated to a tab separated (default) text file

```
dictOutFile <- tempfile()
saveDict(dict.from.dir, file=dictOutFile)
```

# 7 References

[1]Takhar M, Sasaki M, Hollander Z, Kepplinger D, Smith D, McManus B, McMaster W, Ng R, Cohen Freue G (Under revision). “PGCA: An Algorithm to Link Protein Groups Created from MS/MS Data.” *PLOS ONE*.

[2] Cohen Freue GV, Sasaki M, Meredith A, Günther OP, Bergman A, Takhar M et al. (2010) “Proteomic signatures in plasma during early acute renal allograft rejection.” *Molecular & Cellular Proteomics*. 9(9):1954–1967.

[Back to Top](#TOC)