# Getting started with rprimer

Sofia Persson1

1European Union Reference Laboratory for Foodborne Viruses, Swedish Food Agency, Uppsala, Sweden

#### 30 October 2025

#### Package

rprimer 1.14.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Overview](#overview)
* [4 Shiny application](#shiny-application)
* [5 Workflow](#workflow)
  + [5.1 Collection of target sequences and multiple alignment](#collection-of-target-sequences-and-multiple-alignment)
  + [5.2 Data import](#Data)
  + [5.3 Design procedure](#design-procedure)
    - [5.3.1 Step 1: `consensusProfile`](#Step1)
    - [5.3.2 Step 2: `designOligos`](#Step2)
    - [5.3.3 Step 3: `designAssays`](#Step3)
  + [5.4 Further handling of the data](#further-handling-of-the-data)
    - [5.4.1 Oligo and assay binding regions](#oligo-and-assay-binding-regions)
    - [5.4.2 Check match](#check-match)
  + [5.5 Export to file](#export-to-file)
    - [5.5.1 Result tables](#result-tables)
    - [5.5.2 Fasta-format](#fasta-format)
* [6 Summary](#summary)
* [7 Classes and example data](#classes-and-example-data)
* [8 Table values](#table-values)
* [9 Source code](#source-code)
* [10 Citation](#citation)
* [11 Session info](#session-info)
* [References](#references)

# 1 Introduction

rprimer provides tools for designing degenerate oligos (primers and probes) for sequence variable targets, such as RNA viruses. A multiple DNA sequence alignment is used as input data, and the outputs are presented in data frame format and as dashboard-like plots. The aim of the package is to provide a visual and efficient approach to degenerate oligo design, where sequence conservation analysis forms the basis for the design process.

In this vignette, I describe and demonstrate the use of the package by designing broadly reactive primers and probes for reverse transcription (RT) polymerase chain reaction (PCR)-based amplification and detection of hepatitis E virus (HEV), a sequence variable RNA virus and a common foodborne pathogen.

# 2 Installation

To install rprimer, start R (version 4.2.0 or higher), and enter the following code:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rprimer")
```

For best functionality, it is also recommended to install the Biostrings package [[1](#ref-Bios)]:

```
BiocManager::install("Biostrings")
```

# 3 Overview

The oligo and assay design workflow consists of five functions:

* `consensusProfile()`
* `designOligos()`
* `designAssays()`
* `checkMatch()`
* `plotData()`

# 4 Shiny application

The package can be run through a Shiny application (a graphical user interface). To start the application, type `runRprimerApp()` from within R upon installing and attaching the package.

# 5 Workflow

```
library(rprimer)
library(Biostrings)
```

## 5.1 Collection of target sequences and multiple alignment

The first step is to identify and align target sequences of interest. It is important that the alignment does not contain any poorly aligned sequences and accurately represents the generic variation of the target population.

The file “example\_alignment.txt” is provided with the package and contains an alignment of 50 HEV sequences. The file path can be retrieved by:

```
system.file("extdata", "example_alignment.txt", package = "rprimer")
```

## 5.2 Data import

The alignment must be imported to R using the `readDNAMultipleAlignment()` function from Biostrings [[1](#ref-Bios)]. The input file can contain from one to several thousand sequences.

Below, I show how to import the file “example\_alignment.txt”:

```
filepath <- system.file("extdata", "example_alignment.txt", package = "rprimer")

myAlignment <- readDNAMultipleAlignment(filepath, format = "fasta")
```

For some applications, there is often an interest in amplifying a specific region of the genome. In such cases, the alignment can be masked so that only the desired oligo binding regions are available for the subsequent design process. This type of masking can be achieved by using `colmask()` from Biostrings [[1](#ref-Bios)], as illustrated in the example below:

```
## Mask everything but position 3000 to 4000 and 5000 to 6000
myMaskedAlignment <- myAlignment

colmask(myMaskedAlignment, invert = TRUE) <- c(3000:4000, 5000:6000)
```

It is also possible to mask specific sequences by using `rowmask()`. Gap-rich positions can be hidden with `gapmask()` [[1](#ref-Bios)].

## 5.3 Design procedure

### 5.3.1 Step 1: `consensusProfile`

Once the alignment is imported, a consensus profile can be generated. The consensus profile contains all the information needed for the subsequent design process:

* Proportion of the letters A, C, G, T, and other
* Proportion of gaps (-)
* Majority consensus base
* Identity
* IUPAC consensus character
* Coverage

The majority consensus base is the most frequently occurring letter among the letters A, C, G, T and -.

Identity represents the proportion of sequences, among all sequences with a DNA base (A, C, G, T) or gap (-) that has the majority consensus base.

The IUPAC consensus character includes all DNA bases that occur at a relative frequency higher than a user-specified ambiguity threshold. The threshold can range from 0 to 0.2: a value of 0 (default) will catch all the variation, but with the potential downside of generating oligos with high degeneracy. A higher value will capture most of the variation, but with the potential downside of missing less common sequence variants.

Coverage represents the proportion of sequences in the target alignment (among all sequences with a DNA base) that are covered by the IUPAC consensus character.

`consensusProfile()` has two arguments:

* `x`: a `MultipleDNAAlignment` object (see [Data import](#Data))
* `ambiguityThreshold`: position wise “detection level” for ambiguous bases. All DNA bases that occur with a proportion higher than the specified value will be included in the IUPAC consensus character. Defaults to `0`, can range from `0` to `0.2`

Type the following code to generate a consensus profile from the example alignment below:

```
myConsensusProfile <- consensusProfile(myAlignment, ambiguityThreshold = 0.05)
```

Results (row 100-105):

| position | a | c | g | t | other | gaps | majority | identity | iupac | coverage |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 100 | 0.00 | 1.00 | 0.00 | 0.00 | 0.00 | 0 | C | 1.00 | C | 1.00 |
| 101 | 1.00 | 0.00 | 0.00 | 0.00 | 0.00 | 0 | A | 1.00 | A | 1.00 |
| 102 | 0.16 | 0.00 | 0.84 | 0.00 | 0.00 | 0 | G | 0.84 | R | 1.00 |
| 103 | 0.00 | 0.00 | 1.00 | 0.00 | 0.00 | 0 | G | 1.00 | G | 1.00 |
| 104 | 0.00 | 0.98 | 0.00 | 0.00 | 0.02 | 0 | C | 1.00 | C | 1.00 |
| 105 | 0.20 | 0.00 | 0.02 | 0.78 | 0.00 | 0 | T | 0.78 | W | 0.98 |

The results can be visualized by using `plotData()`:

```
plotData(myConsensusProfile)
#> Warning in ggplot2::geom_segment(color = "#93A8AC", ggplot2::aes(x = min(position), : All aesthetics have length 1, but the data has 7597 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
```

![](data:image/png;base64...)

The dots represent the value at each position, and the black lines show centered running averages. High identity values (in combination with low gap values) indicate high sequence conservation.

The data can be explored in more detail by zooming into a specific region of interest:

```
## Select position 5000 to 5800 in the consensus profile
selection <- myConsensusProfile[
  myConsensusProfile$position >= 5000 & myConsensusProfile$position <= 5800,
  ]

plotData(selection)
#> Warning in ggplot2::geom_segment(color = "#93A8AC", ggplot2::aes(x = min(position), : All aesthetics have length 1, but the data has 801 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
```

![](data:image/png;base64...)

### 5.3.2 Step 2: `designOligos`

The next step is to design oligos. Primers must be designed, and probes are optional. Primers can be generated by using two strategies:

* The **ambiguous strategy** (default) generates primers from the IUPAC consensus sequence alone, which means that ambiguous bases can occur at any position in the primer
* The **mixed strategy** generates primers from both the majority and IUPAC consensus sequence. These primers consist of a shorter degenerate part at the 3’ end (~1/3 of the primer, targeting a conserved region) and a longer consensus part at the 5’ end (~2/3 of the primer), which instead of having ambiguous bases, contains the most frequently occuring nucleotide at each position. This strategy resembles the widely used Consensus-Degenerate Hybrid Oligonucleotide Primer (CODEHOP) principle [[2](#ref-Rose2)]. It aims to allow amplification of highly variable targets using primers with low degeneracy. The idea is that the degenerate 3’ end will bind specifically to the target sequence in the initial PCR cycles and promote amplification despite eventual mismatches at the 5’ consensus part (since 5’ end mismatches are generally less detrimental than 3’ end mismatches) [[2](#ref-Rose2)]. In this way, the generated products will perfectly match the 5’ ends of all primers, allowing them to be efficiently amplified in later PCR cycles. To provide a sufficiently high melting temperature (tm) with eventual 5’ end mismatches, it is recommended to design relatively long primers (at least 25 bases) when using this strategy

Probes are always designed using the ambiguous strategy.

`designOligos()` has several arguments (design settings):

* `x`: the consensus profile from [Step 1](#Step1)
* `maxGapFrequency`: maximum gap frequency (in the alignment) for primers and probes, defaults to `0.01`
* `lengthPrimer`: primer length range, defaults to `c(18, 22)`
* `maxDegeneracyPrimer`: maximum degeneracy for primers, defaults to `4`
* `gcClampPrimer`: if primers should have a GC clamp, defaults to `TRUE`. A GC clamp is identified as two to three G or C:s within the last five bases (3’ end) of the primer. The presence of a GC clamp is thought to promote specific binding of the 3’ end
* `avoidThreeEndRunsPrimer`: if primers with more than two runs of the same nucleotide at the terminal 3’ end should be avoided (to reduce the risk of mispriming), defaults to `TRUE`
* `gcPrimer`: GC-content range of primers, defaults to `c(0.40, 0.65)`
* `tmPrimer`: melting temperature range for primers (in Celsius degrees), defaults to `c(55, 65)`. Melting temperatures are calculated for perfectly matching oligo-target duplexes using the nearest neighbor method [[3](#ref-SantaLuciaUnified)], using the formula, salt correction method, and table values as described in [[4](#ref-santalucia2004thermodynamics)]. See the manual (`?oligos`) for more information
* `concPrimer`: primer concentration in nM, defaults to `500` (for tm calculation)
* `designStrategyPrimer`: design strategy for primers, `"ambiguous"` or `"mixed"`, defaults to `"ambiguous"`
* `probe`: if probes should be designed, defaults to `TRUE`
* `lengthProbe`: defaults to `c(18, 22)`
* `maxDegeneracyProbe`: defaults to `4`
* `avoidFiveEndGProbe`: if probes with a G at the terminal 5’ end should be avoided (to prevent quenching of the 5’ flourophore of hydrolysis probes), defaults to `TRUE`
* `gcProbe`: defaults to `c(0.40, 0.65)`
* `tmProbe`: defaults to `c(55, 70)`
* `concProbe`: defaults to `250`
* `concNa`: sodium ion (equivalent) concentration in the PCR reaction (in M), defaults to `0.05` (50 mM) (for calculation of tm and delta G)

All sequence variants of an oligo must fulfill all specified design constraints to be considered.

Oligos with at least one sequence variant containing more than four consecutive runs of the same nucleotide (e.g. “AAAAA”) and/or more than three consecutive runs of the same di-nucleotide (e.g. “TATATATA”) are not considered.

An error message will return if no oligos are found. If so, a good idea could be to re-run the process from [Step 1](#Step1) and increase the `ambiguityThreshold` in `consensusProfile()`, and/or relax the design constraints above.

#### 5.3.2.1 Design with default settings

Enter the following code to design oligos with default settings:

```
myOligos <- designOligos(myConsensusProfile)
```

Results (first five rows):

| type | fwd | rev | start | end | length | iupacSequence | iupacSequenceRc | identity | coverage | degeneracy | gcContentMean | gcContentRange | tmMean | tmRange | deltaGMean | deltaGRange | sequence | sequenceRc | gcContent | tm | deltaG | method | score | roiStart | roiEnd |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| probe | TRUE | TRUE | 124 | 143 | 20 | TCYGCCYTGGCGAATGCTGT | ACAGCATTCGCCARGGCRGA | 0.95 | 0.99 | 4 | 0.60 | 0.10 | 63.17 | 4.33 | -21.61 | 2.08 | TCCGCCCT…. | ACAGCATT…. | 0.65, 0….. | 65.33623…. | -22.6538…. | ambiguous | 2 | 1 | 7597 |
| probe | FALSE | TRUE | 127 | 146 | 20 | GCCYTGGCGAATGCTGTGGT | ACCACAGCATTCGCCARGGC | 0.98 | 0.99 | 2 | 0.62 | 0.05 | 63.18 | 1.84 | -21.73 | 0.83 | GCCCTGGC…. | ACCACAGC…. | 0.65, 0.6 | 64.10586…. | -22.1475…. | ambiguous | 3 | 1 | 7597 |
| primer | TRUE | FALSE | 128 | 146 | 19 | CCYTGGCGAATGCTGTGGT | ACCACAGCATTCGCCARGG | 0.97 | 0.99 | 2 | 0.61 | 0.05 | 61.48 | 1.95 | -19.84 | 0.83 | CCCTGGCG…. | ACCACAGC…. | 0.631578…. | 62.45335…. | -20.2570…. | ambiguous | 3 | 1 | 7597 |
| primer | TRUE | FALSE | 128 | 147 | 20 | CCYTGGCGAATGCTGTGGTR | YACCACAGCATTCGCCARGG | 0.96 | 0.99 | 4 | 0.60 | 0.10 | 61.61 | 3.37 | -20.55 | 1.76 | CCCTGGCG…. | TACCACAG…. | 0.6, 0.5…. | 61.77166…. | -20.5089…. | ambiguous | 2 | 1 | 7597 |
| probe | TRUE | TRUE | 128 | 146 | 19 | CCYTGGCGAATGCTGTGGT | ACCACAGCATTCGCCARGG | 0.97 | 0.99 | 2 | 0.61 | 0.05 | 60.45 | 1.94 | -19.84 | 0.83 | CCCTGGCG…. | ACCACAGC…. | 0.631578…. | 61.41686…. | -20.2570…. | ambiguous | 3 | 1 | 7597 |

The manual (`?designOligos`) contains a detailed description of each variable. However, what may not be completely self-explanatory is that some variables (e.g. `sequence` `gcContent` and `tm`) can hold several values in each entry. For such variables, all values within a specific row can be retrieved by:

```
myOligos$sequence[[1]] ## All sequence variants of the first oligo (i.e., first row)
#> [1] "TCCGCCCTGGCGAATGCTGT" "TCTGCCCTGGCGAATGCTGT" "TCCGCCTTGGCGAATGCTGT"
#> [4] "TCTGCCTTGGCGAATGCTGT"
myOligos$gcContent[[1]] ## GC-content of all variants of the first oligo
#> [1] 0.65 0.60 0.60 0.55
myOligos$tm[[1]] ## Tm of all variants of the first oligo
#> [1] 65.33624 62.86736 63.47792 61.00290
```

The primer and probe candidates can be visualized using `plotData()`:

```
plotData(myOligos)
#> Warning in ggplot2::annotate("label", x = roiStart, y = seq(0.75, length.out =
#> 4, : Ignoring unknown parameters: `label.size`
```

![](data:image/png;base64...)

#### 5.3.2.2 Design with modified settings, and mixed primers

Next, I show how to design mixed primers using the dataset where I [masked](#Data) all positions but 3000 to 4000 and 5000 to 6000. In this case, I select to not design probes. I also select to modify some of the other settings.

```
## I first need to make a consensus profile of the masked alignment
myMaskedConsensusProfile <- consensusProfile(myMaskedAlignment, ambiguityThreshold = 0.05)

myMaskedMixedPrimers <- designOligos(myMaskedConsensusProfile,
                                     maxDegeneracyPrimer = 8,
                                     lengthPrimer = c(24:28),
                                     tmPrimer = c(65,70),
                                     designStrategyPrimer = "mixed",
                                     probe = FALSE)
```

```
plotData(myMaskedMixedPrimers)
#> Warning in ggplot2::annotate("label", x = roiStart, y = seq(0.89, length.out =
#> 2, : Ignoring unknown parameters: `label.size`
```

![](data:image/png;base64...)

Importantly, for mixed primers, identity refers to the average identity within the 5’ consensus part of the primer binding region, and coverage refers to the average coverage of the 3’ degenerate part of the primer. Conversely, for ambiguous primers (and probes), both of these values are calculated for the oligo as a whole. For a detailed explanation of identity and coverage, see [Step 1](#Step1).

#### 5.3.2.3 Scoring system

All valid oligos are scored based on their average identity, coverage, and GC-content. The score can range from 0 to 9, where 0 is considered best. The manual (`?designOligos`) contains more information on the scoring system.

The best scoring oligos can be retrieved as follows:

```
## Get the minimum score from myOligos
bestOligoScore <- min(myOligos$score)
bestOligoScore
#> [1] 0

## Make a subset that only oligos with the best score are included
oligoSelection <- myOligos[myOligos$score == bestOligoScore, ]
```

#### 5.3.2.4 Visualize oligo binding regions

It is possible to select a specific oligo and plot the nucleotide distribution within the binding region, by subsetting the consensus profile from [Step 1](#Step1):

```
## Get the binding region of the first oligo in the selection above (first row):
bindingRegion <- myConsensusProfile[
  myConsensusProfile$position >= oligoSelection[1, ]$start &
    myConsensusProfile$position <= oligoSelection[1, ]$end,
  ]
```

To plot the binding region, we can add `type = "nucleotide"`:

```
plotData(bindingRegion, type = "nucleotide")
```

![](data:image/png;base64...)

The binding region can be plotted in forward direction as above, or as a reverse complement, by specifying `rc = TRUE`.

### 5.3.3 Step 3: `designAssays`

The final step is to find pairs of forward and reverse primers, and eventually, to combine them with probes. If probes are present in the input dataset, only assays with a probe located between the primer pair will be kept.

`designAssays()` has four arguments:

* `x`: the oligo dataset from [Step 2](#Step2)
* `length`: amplicon length range, defaults to `c(65, 120)`
* `tmDifferencePrimers`: maximum allowed difference between the mean tm of the forward and reverse primer (in Celsius degrees). Defaults to `NULL`, which means that primers will be paired regardless of their tm.111 Note that the strategy of matching primer tm is flawed. What in reality is of interest is the amount of primer bound at the annealing temperature (ta). A PCR is most efficient if the two primers hybridize to the target at the same extent at the ta. See [[5](#ref-SL2007)] for details on how to calculate the proportion of hybridized primer at different temperatures.

An error message will return if no assays are found.

Below, I show how to design assays using default settings using the dataset `myOligos` from [Step 2](#Step2):

```
myAssays <- designAssays(myOligos)
```

Output (first five rows):

| start | end | length | totalDegeneracy | score | startFwd | endFwd | lengthFwd | iupacSequenceFwd | identityFwd | coverageFwd | degeneracyFwd | gcContentMeanFwd | gcContentRangeFwd | tmMeanFwd | tmRangeFwd | deltaGMeanFwd | deltaGRangeFwd | sequenceFwd | gcContentFwd | tmFwd | deltaGFwd | methodFwd | startRev | endRev | lengthRev | iupacSequenceRev | identityRev | coverageRev | degeneracyRev | gcContentMeanRev | gcContentRangeRev | tmMeanRev | tmRangeRev | deltaGMeanRev | deltaGRangeRev | sequenceRev | gcContentRev | tmRev | deltaGRev | methodRev | plusPr | minusPr | startPr | endPr | lengthPr | iupacSequencePr | iupacSequenceRcPr | identityPr | coveragePr | degeneracyPr | gcContentMeanPr | gcContentRangePr | tmMeanPr | tmRangePr | deltaGMeanPr | deltaGRangePr | sequencePr | sequenceRcPr | gcContentPr | tmPr | deltaGPr | methodPr | roiStart | roiEnd |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 5605 | 5673 | 69 | 6 | 2.00 | 5605 | 5624 | 20 | GGCRGTGGTTTCTGGGGTGA | 0.98 | 1 | 2 | 0.62 | 0.05 | 62.84 | 2.51 | -20.86 | 1.25 | GGCAGTGG…. | 0.6, 0.65 | 61.57995…. | -20.2350…. | ambiguous | 5654 | 5673 | 20 | GTTGGTTGGATGAASATAGG | 1 | 1 | 2 | 0.4 | 0 | 50.71 | 1.1 | -15.27 | 0.52 | GTTGGTTG…. | 0.4, 0.4 | 50.15469…. | -15.0078…. | ambiguous | TRUE | FALSE | 5625 | 5642 | 18 | CMGGGTTGATTCTCAGCC | GGCTGAGAATCAACCCKG | 0.97 | 0.99 | 2 | 0.58 | 0.06 | 55.14 | 2.79 | -17.06 | 1.25 | CAGGGTTG…. | GGCTGAGA…. | 0.555555…. | 53.74554…. | -16.4324…. | ambiguous | 1 | 7597 |
| 5605 | 5673 | 69 | 6 | 2.33 | 5605 | 5624 | 20 | GGCRGTGGTTTCTGGGGTGA | 0.98 | 1 | 2 | 0.62 | 0.05 | 62.84 | 2.51 | -20.86 | 1.25 | GGCAGTGG…. | 0.6, 0.65 | 61.57995…. | -20.2350…. | ambiguous | 5654 | 5673 | 20 | GTTGGTTGGATGAASATAGG | 1 | 1 | 2 | 0.4 | 0 | 50.71 | 1.1 | -15.27 | 0.52 | GTTGGTTG…. | 0.4, 0.4 | 50.15469…. | -15.0078…. | ambiguous | TRUE | FALSE | 5625 | 5643 | 19 | CMGGGTTGATTCTCAGCCC | GGGCTGAGAATCAACCCKG | 0.97 | 0.99 | 2 | 0.61 | 0.05 | 57.63 | 2.64 | -18.54 | 1.25 | CAGGGTTG…. | GGGCTGAG…. | 0.578947…. | 56.30713…. | -17.9185…. | ambiguous | 1 | 7597 |
| 5605 | 5673 | 69 | 6 | 2.00 | 5605 | 5624 | 20 | GGCRGTGGTTTCTGGGGTGA | 0.98 | 1 | 2 | 0.62 | 0.05 | 62.84 | 2.51 | -20.86 | 1.25 | GGCAGTGG…. | 0.6, 0.65 | 61.57995…. | -20.2350…. | ambiguous | 5654 | 5673 | 20 | GTTGGTTGGATGAASATAGG | 1 | 1 | 2 | 0.4 | 0 | 50.71 | 1.1 | -15.27 | 0.52 | GTTGGTTG…. | 0.4, 0.4 | 50.15469…. | -15.0078…. | ambiguous | TRUE | TRUE | 5625 | 5644 | 20 | CMGGGTTGATTCTCAGCCCT | AGGGCTGAGAATCAACCCKG | 0.97 | 1.00 | 2 | 0.58 | 0.05 | 58.87 | 2.55 | -19.43 | 1.25 | CAGGGTTG…. | AGGGCTGA…. | 0.55, 0.6 | 57.59836…. | -18.8035…. | ambiguous | 1 | 7597 |
| 5605 | 5673 | 69 | 6 | 1.67 | 5605 | 5624 | 20 | GGCRGTGGTTTCTGGGGTGA | 0.98 | 1 | 2 | 0.62 | 0.05 | 62.84 | 2.51 | -20.86 | 1.25 | GGCAGTGG…. | 0.6, 0.65 | 61.57995…. | -20.2350…. | ambiguous | 5654 | 5673 | 20 | GTTGGTTGGATGAASATAGG | 1 | 1 | 2 | 0.4 | 0 | 50.71 | 1.1 | -15.27 | 0.52 | GTTGGTTG…. | 0.4, 0.4 | 50.15469…. | -15.0078…. | ambiguous | TRUE | TRUE | 5625 | 5645 | 21 | CMGGGTTGATTCTCAGCCCTT | AAGGGCTGAGAATCAACCCKG | 0.98 | 1.00 | 2 | 0.55 | 0.05 | 59.21 | 2.43 | -20.08 | 1.25 | CAGGGTTG…. | AAGGGCTG…. | 0.523809…. | 57.99472…. | -19.4553…. | ambiguous | 1 | 7597 |
| 5605 | 5673 | 69 | 6 | 2.00 | 5605 | 5624 | 20 | GGCRGTGGTTTCTGGGGTGA | 0.98 | 1 | 2 | 0.62 | 0.05 | 62.84 | 2.51 | -20.86 | 1.25 | GGCAGTGG…. | 0.6, 0.65 | 61.57995…. | -20.2350…. | ambiguous | 5654 | 5673 | 20 | GTTGGTTGGATGAASATAGG | 1 | 1 | 2 | 0.4 | 0 | 50.71 | 1.1 | -15.27 | 0.52 | GTTGGTTG…. | 0.4, 0.4 | 50.15469…. | -15.0078…. | ambiguous | TRUE | FALSE | 5625 | 5646 | 22 | CMGGGTTGATTCTCAGCCCTTC | GAAGGGCTGAGAATCAACCCKG | 0.98 | 0.99 | 2 | 0.57 | 0.05 | 59.91 | 2.28 | -21.11 | 1.25 | CAGGGTTG…. | GAAGGGCT…. | 0.545454…. | 58.77533…. | -20.4881…. | ambiguous | 1 | 7597 |

The output contains many columns, but you can get an overview by calling `View(as.data.frame(myAssays))` if you are working in RStudio.
Again, the results can be visualized using `plotData()`:

```
plotData(myAssays)
#> Warning in ggplot2::annotate("label", x = start, y = 0.8, label = paste("Assays
#> n =", : Ignoring unknown parameters: `label.size`
```

![](data:image/png;base64...)

There are now over 1000 assays, but we can reduce the number by filtering the dataset. In the example below, I select to subset the assays based on their average oligo score (see the score variable in the table above), and only keep those with the best score.

The best possible average score is 0 and the worst is 9 (see [Step 2](#Step2) for more information).

```
## Get the minimum (best) score from myAssays
bestAssayScore <- min(myAssays$score)
bestAssayScore
#> [1] 0.6666667

## Make a subset that only contains the assays with the best score
myAssaySelection <- myAssays[myAssays$score == bestAssayScore, ]
```

## 5.4 Further handling of the data

### 5.4.1 Oligo and assay binding regions

Oligo and assay binding region(s) can be inspected in more detail by using the consensus profile from [Step 1](#Step1). As an example, I select to take a closer look at the first assay in `myAssaySelection` from [Step 3](#Step3).

The start and end position of an assay can be retrieved as follows:

```
from <- myAssaySelection[1, ]$start
to <- myAssaySelection[1, ]$end
```

It is now possible to indicate the amplicon region, using the `highlight` argument in `plotData()`:

```
plotData(myConsensusProfile, highlight = c(from, to))
#> Warning in ggplot2::geom_segment(color = "#93A8AC", ggplot2::aes(x = min(position), : All aesthetics have length 1, but the data has 7597 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
```

![](data:image/png;base64...)

To get a more detailed view, we can make a subset of the consensus profile to only contain the amplicon region, and plot it:

```
myAssayRegion <- myConsensusProfile[
  myConsensusProfile$position >= from &
    myConsensusProfile$position <= to,
]
```

```
plotData(myAssayRegion, type = "nucleotide")
```

![](data:image/png;base64...)

The consensus amplicon sequence is obtained as follows:

```
paste(myAssayRegion$iupac, collapse = "")
#> [1] "CRGTGGTTTCTGGGGTGACMGGGTTGATTCTCAGCCCTTCGCMMTCCCCTATWTTCATCCAACCAACCC"
```

### 5.4.2 Check match

It is often valuable to investigate how the generated oligos match with their target sequences. `checkMatch()` can be used for this purpose. The function is a wrapper to `vcountPDict()` from Biostrings [[1](#ref-Bios)] and has two arguments:

* `x`: an oligo or assay dataset from [Step 2](#Step2) or [3](#Step3)
* `target`: the target alignment used as input in [Step 1](#Step1)

The output gives information on the proportion and names of target sequences that match perfectly and with one, two, three, or four or more mismatches to the oligo *within* the intended oligo binding region in the alignment (on-target match). It also tells the proportion and names of target sequences that match with a maximum of two mismatches to the oligo *outside* the intended oligo binding region (off-target match). Thus, be cautious that false negatives (or positives) may occur due to poorly aligned sequences. Moreover, the output does not tell which strand (minus or plus) the oligo matches to, which is important to consider when assessing off-target matches to single-stranded targets. See the manual (`?checkMatch`) for more information.

Ambiguous bases and gaps in the target sequences will be identified as mismatches.

`checkMatch()` can be used for both oligo and assay datasets. The function is rather slow, especially if there are many target sequences, so a good idea could be to select only a few oligo or assay candidates to investigate.

Below, I show how to check how the three first candidates of the `oligoSelection` dataset matches to the sequences in `myAlignment`:

```
## Check the first three candidates in the oligoSelection dataset
oligoSelectionMatch <- checkMatch(oligoSelection[1:3, ], target = myAlignment)
```

Output:

| iupacSequence | perfectMatch | idPerfectMatch | oneMismatch | idOneMismatch | twoMismatches | idTwoMismatches | threeMismatches | idThreeMismatches | fourOrMoreMismatches | idFourOrMoreMismatches | offTargetMatch | idOffTargetMatch |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| GGGTTGATTCTCAGCCCTT | 0.9 | AB073912…. | 0.1 | AB481228…. | 0 |  | 0 |  | 0 |  | 0 |  |
| GGGTTGATTCTCAGCCCTT | 0.9 | AB073912…. | 0.1 | AB481228…. | 0 |  | 0 |  | 0 |  | 0 |  |
| GGTTGATTCTCAGCCCTT | 0.9 | AB073912…. | 0.1 | AB481228…. | 0 |  | 0 |  | 0 |  | 0 |  |

Note that the id variables can hold several values in each row. All values can be retrieved by:

```
## Get the id of all sequences that has one mismatch to the first oligo in the input dataset
oligoSelectionMatch$idOneMismatch[[1]]
#> [1] "AB481228.1" "KJ701409.1" "JQ953665.1" "AB521805.1" "LC042232.1"
```

The output can be visualized using `plotData()`:

```
plotData(oligoSelectionMatch)
```

![](data:image/png;base64...)

## 5.5 Export to file

Before proceeding to wet lab evaluation, it is highly recommended to also evaluate the final primer and probe candidates for 1) the potential to form primer-dimers and hairpin structures, and 2) the potential to (not) cross react with non-targets.

These tasks are best performed by other software. Below, I show how to export results to a file so they can be readily analyzed by other tools.

### 5.5.1 Result tables

All result tables can be saved to .txt or .csv-files, for instance:

```
write.csv(myAssays, file = "myAssays.csv", quote = FALSE, row.names = FALSE)
write.table(myAssays, file = "myAssays.txt", quote = FALSE, row.names = FALSE)
```

### 5.5.2 Fasta-format

It is also possible to export oligos and assays in fasta-format. To do this, the object of interest must first be coerced to a `DNAStringSet` object, as follows:

```
## Convert the first two oligos
as(myOligos[1:2, ], "DNAStringSet")
#> DNAStringSet object of length 6:
#>     width seq                                               names
#> [1]    20 TCCGCCCTGGCGAATGCTGT                              oligo_1_variant_1
#> [2]    20 TCTGCCCTGGCGAATGCTGT                              oligo_1_variant_2
#> [3]    20 TCCGCCTTGGCGAATGCTGT                              oligo_1_variant_3
#> [4]    20 TCTGCCTTGGCGAATGCTGT                              oligo_1_variant_4
#> [5]    20 GCCCTGGCGAATGCTGTGGT                              oligo_2_variant_1
#> [6]    20 GCCTTGGCGAATGCTGTGGT                              oligo_2_variant_2
```

```
## Convert the first two assays
as(myAssays[1:2, ], "DNAStringSet")
#> DNAStringSet object of length 12:
#>      width seq                                              names
#>  [1]    20 GGCAGTGGTTTCTGGGGTGA                             assay_1_fwd_varia...
#>  [2]    20 GGCGGTGGTTTCTGGGGTGA                             assay_1_fwd_varia...
#>  [3]    20 GGCAGTGGTTTCTGGGGTGA                             assay_2_fwd_varia...
#>  [4]    20 GGCGGTGGTTTCTGGGGTGA                             assay_2_fwd_varia...
#>  [5]    20 CCTATATTCATCCAACCAAC                             assay_1_rev_varia...
#>  ...   ... ...
#>  [8]    20 CCTATTTTCATCCAACCAAC                             assay_2_rev_varia...
#>  [9]    18 CAGGGTTGATTCTCAGCC                               assay_1_pr_variant_1
#> [10]    18 CCGGGTTGATTCTCAGCC                               assay_1_pr_variant_2
#> [11]    19 CAGGGTTGATTCTCAGCCC                              assay_2_pr_variant_1
#> [12]    19 CCGGGTTGATTCTCAGCCC                              assay_2_pr_variant_2
```

Note that all sequences will be written in the same direction as the input target alignment, and all sequence variants of each oligo will be printed.

The sequences can now be saved in fasta-format by using `writeXStringSet()` from Biostrings [[1](#ref-Bios)].

```
toFile <- as(myOligos[1:2, ], "DNAStringSet")
writeXStringSet(toFile, file = "myOligos.txt")
```

# 6 Summary

The design process as a whole is summarized below.

Using the R console:

```
library(rprimer)

## Enter the filepath to an alignment with target sequences of interest
filepath <- system.file("extdata", "example_alignment.txt", package = "rprimer")

## Import the alignment
myAlignment <- readDNAMultipleAlignment(filepath, format = "fasta")

## Design primers, probes and assays (modify settings if needed)
myConsensusProfile <- consensusProfile(myAlignment, ambiguityThreshold = 0.05)
myOligos <- oligos(myConsensusProfile)
myAssays <- assays(myOligos)

## Visualize the results
plotData(myConsensusProfile)
plotData(myOligos)
plotData(myAssays)

## Show result tables (in RStudio)
View(as.data.frame(myConsensusProfile))
View(as.data.frame(myOligos))
View(as.data.frame(myAssays))
```

Using the Shiny application:

```
library(rprimer)

## Start application
runRprimerApp()
```

# 7 Classes and example data

The “Rprimer” classes (`RprimerProfile`, `RprimerOligo`, `RprimerAssay`, `RprimerMatchOligo` and `RprimerMatchAssay`) extends the `DFrame` class from S4Vectors [[6](#ref-S4)], and behave in a similar way as traditional data frames, with methods for `[`, `$`, `nrow()`, `ncol()`, `head()`, `tail()`, `rbind()`, `cbind()` etc. They can be coerced to traditional data frames by using `as.data.frame()`.

Example datasets of each class are provided with the package, and are loaded by:

```
data("exampleRprimerProfile")
data("exampleRprimerOligo")
data("exampleRprimerAssay")
data("exampleRprimerMatchOligo")
data("exampleRprimerMatchAssay")
```

To provide reproducible examples, I have also included an alignment of class `DNAMultipleAlignment`. It is loaded by `data("exampleRprimerAlignment")`.

# 8 Table values

Tables used for determination of complement bases, IUPAC consensus character codes, degeneracy and nearest neighbors can be found by typing:

* `rprimer:::lookup$complement`
* `rprimer:::lookup$iupac`, `rprimer:::lookup$degenerates`,
* `rprimer:::lookup$degeneracy` and
* `rprimer:::lookup$nn`, respectively.

# 9 Source code

The source code is available at <https://github.com/sofpn/rprimer>.

# 10 Citation

Persson S., Larsson C., Simonsson M., Ellström P. (2022) rprimer: an R/bioconductor package for design of degenerate oligos for sequence variable viruses. [*BMC Bioinformatics* 23:239](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-022-04781-0)

# 11 Session info

This document was generated under the following conditions:

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
#>  [1] Biostrings_2.78.0   Seqinfo_1.0.0       XVector_0.50.0
#>  [4] IRanges_2.44.0      S4Vectors_0.48.0    BiocGenerics_0.56.0
#>  [7] generics_0.1.4      rprimer_1.14.0      kableExtra_1.4.0
#> [10] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10         xml2_1.4.1          stringi_1.8.7
#>  [4] digest_0.6.37       magrittr_2.0.4      grid_4.5.1
#>  [7] evaluate_1.0.5      RColorBrewer_1.1-3  bookdown_0.45
#> [10] fastmap_1.2.0       plyr_1.8.9          jsonlite_2.0.0
#> [13] tinytex_0.57        promises_1.4.0      BiocManager_1.30.26
#> [16] viridisLite_0.4.2   scales_1.4.0        textshaping_1.0.4
#> [19] jquerylib_0.1.4     cli_3.6.5           shiny_1.11.1
#> [22] rlang_1.1.6         crayon_1.5.3        withr_3.0.2
#> [25] cachem_1.1.0        yaml_2.3.10         otel_0.2.0
#> [28] tools_4.5.1         reshape2_1.4.4      dplyr_1.1.4
#> [31] ggplot2_4.0.0       httpuv_1.6.16       mathjaxr_1.8-0
#> [34] vctrs_0.6.5         R6_2.6.1            mime_0.13
#> [37] magick_2.9.0        lifecycle_1.0.4     stringr_1.5.2
#> [40] pkgconfig_2.0.3     pillar_1.11.1       gtable_0.3.6
#> [43] bslib_0.9.0         later_1.4.4         glue_1.8.0
#> [46] Rcpp_1.1.0          systemfonts_1.3.1   tidyselect_1.2.1
#> [49] tibble_3.3.0        xfun_0.53           rstudioapi_0.17.1
#> [52] knitr_1.50          dichromat_2.0-0.1   farver_2.1.2
#> [55] xtable_1.8-4        htmltools_0.5.8.1   patchwork_1.3.2
#> [58] labeling_0.4.3      rmarkdown_2.30      svglite_2.2.2
#> [61] compiler_4.5.1      S7_0.2.0
```

# References

1. H. Pagès and P. Aboyoun and R. Gentleman and S. DebRoy. Biostrings: Efficient manipulation of biological strings. 2021. <https://bioconductor.org/packages/Biostrings>.

2. TM. Rose, ER. Schultz, JG. Henikoff, S. Pietrokovski, CM. McCallum, and S. Henikoff. Consensus-degenerate hybrid oligonucleotide primers for amplification of distantly related sequences. Nucleic acids research. 1998;26:1628–35.

3. J. SantaLucia. A unified view of polymer, dumbbell, and oligonucleotide dna nearest-neighbor thermodynamics. Proceedings of the National Academy of Sciences. 1998;95:1460–5.

4. J. SantaLucia and D. Hicks. The thermodynamics of dna structural motifs. Annu Rev Biophys Biomol Struct. 2004;33:415–40.

5. J. SantaLucia. Physical principles and visual-omp software for optimal pcr design. Springer; 2007.

6. H. Pagès and M. Lawrence and P. Aboyoun. S4Vectors: Foundation of vector-like and list-like containers in bioconductor. 2021. <https://bioconductor.org/packages/S4Vectors>.