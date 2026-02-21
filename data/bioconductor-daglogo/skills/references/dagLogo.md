# dagLogo Vignette

Jianhong Ou, Haibo Liu, Lihua Julie Zhu

#### 29 October 2025

#### Abstract

Sequence logo has been widely used as a graphical representation of nucleic acid motifs and conserved amino acid (AA) usage. We have developed a R/Bioconductor package *dagLogo* to facilitate the identification and visualization of significant differential usage of AAs between experimental sets and various background sets, with or without grouping based on AA properties.

#### Package

dagLogo 1.48.0

# Contents

* [1 Introduction](#introduction)
* [2 Step-by-step guide on using *dagLogo*](#step-by-step-guide-on-using-daglogo)
  + [2.1 First load the library *dagLogo*](#first-load-the-library-daglogo)
  + [2.2 Step 1: Fetching peptide sequences from BioMart](#step-1-fetching-peptide-sequences-from-biomart)
    - [2.2.1 Case 1: Fetch sequences using the `fetchSequence` function in *biomaRt* package given a list of gene identifiers and the corresponding positions of the anchoring AA.](#case-1-fetch-sequences-using-the-fetchsequence-function-in-biomart-package-given-a-list-of-gene-identifiers-and-the-corresponding-positions-of-the-anchoring-aa.)
    - [2.2.2 Case 2: Fetch sequences using the `fetchSequence` function in *biomaRt* package given a list of gene identifiers and the corresponding peptide subsequences of interest with the anchoring AA marked such as asterisks or lower case of one or more AA letters.](#case-2-fetch-sequences-using-the-fetchsequence-function-in-biomart-package-given-a-list-of-gene-identifiers-and-the-corresponding-peptide-subsequences-of-interest-with-the-anchoring-aa-marked-such-as-asterisks-or-lower-case-of-one-or-more-aa-letters.)
    - [2.2.3 Case 3: Prepare an object of `dagPeptides` using `prepareProteome` and `formatSequence` functions sequentially given a list of unaligned/aligned ungapped peptide sequences.](#case-3-prepare-an-object-of-dagpeptides-using-prepareproteome-and-formatsequence-functions-sequentially-given-a-list-of-unalignedaligned-ungapped-peptide-sequences.)
  + [2.3 Step 2: Building background models](#step-2-building-background-models)
  + [2.4 Step 3: Statistical significance test for differential usage of amino acids with or without grouping](#step-3-statistical-significance-test-for-differential-usage-of-amino-acids-with-or-without-grouping)
  + [2.5 Step 4: Visualize significance test results](#step-4-visualize-significance-test-results)
* [3 Session Info](#session-info)

# 1 Introduction

A sequence logo has been widely used as a graphical representation of nucleic acid sequence motifs.
There is a R package *seqlogo*(Bembom [2006](#ref-Oliver2006)) for drawing sequence logos for a single DNA motif.
There is another R package *motifStack*(Ou et al. [2018](#ref-ou2018motifstack)) for depicting individual sequence motif as well as multiple motifs for amino acid (AA), DNA and RNA sequences.

*IceLogo*(Colaert et al. [2009](#ref-Colaert2009)) is a tool developed in Java for visualizing significantly conserved sequence
patterns in a list of aligned AA sequences against a set of background sequences. Compared to
*webLogo*(Crooks et al. [2004](#ref-Crooks2004)), which relies on information theory, *IceLogo* builds on probability theory.
It is reported that *IceLogo* has a more dynamic nature and is more appropriate for analysis of
conserved sequence patterns.

However, *IceLogo* can only compare conserved sequences to reference sequences at the individual amino acid level.
As we know, some conserved sequence patterns are not conserved at the individual amino acid level, but conserved at the level of amino acid group characteristic of their physical and chemical properties, such as charge and hydrophobicity.

Here we developed a R/Bioconductor package *dagLogo*, for visualizing significantly conserved sequence patterns relative to a proper background set of sequences, with or without grouping amino acid residuals based on their physical and chemical properties. Figure 1 shows the flowchart of performing analysis using dagLogo. Comparing to existing tools, *dagLogo* allows aligned or not aligned subsequences of different length as input; Provides more options and functions to generate various background sets that can be tailored to fit the experimental design; Both significantly over- and under-represented amino acid residues can be plotted; AA residues can be grouped and statistical significance test can be performed at the group level.

![Figure 1. Flowchart of performing analysis using dagLogo. Two ways to prepare an object of Proteome are colored in greenish and yellowish, while two alternative ways to build an object of dagPeptides are colored in blue and red.](data:image/png;base64...).

Figure 1. Flowchart of performing analysis using *dagLogo*. Two ways to prepare an object of `Proteome` are colored in greenish and yellowish, while two alternative ways to build an object of `dagPeptides` are colored in blue and red.

# 2 Step-by-step guide on using *dagLogo*

## 2.1 First load the library *dagLogo*

```
library(dagLogo)
```

## 2.2 Step 1: Fetching peptide sequences from BioMart

### 2.2.1 Case 1: Fetch sequences using the `fetchSequence` function in *biomaRt* package given a list of gene identifiers and the corresponding positions of the anchoring AA.

```
##just in case biomaRt server does not response
if (interactive())
{
    try({
            mart <- useMart("ensembl")
            fly_mart <-
            useDataset(mart = mart, dataset = "dmelanogaster_gene_ensembl")
            dat <- read.csv(system.file("extdata", "dagLogoTestData.csv",
                                        package = "dagLogo"))
            seq <- fetchSequence(IDs = as.character(dat$entrez_geneid),
                                 anchorPos = as.character(dat$NCBI_site),
                                 mart = fly_mart,
                                 upstreamOffset = 7,
                                 downstreamOffset = 7)
            head(seq@peptides)
   })
}
```

### 2.2.2 Case 2: Fetch sequences using the `fetchSequence` function in *biomaRt* package given a list of gene identifiers and the corresponding peptide subsequences of interest with the anchoring AA marked such as asterisks or lower case of one or more AA letters.

```
if (interactive())
{
    try({
            mart <- useMart("ensembl")
            fly_mart <-
            useDataset(mart = mart, dataset = "dmelanogaster_gene_ensembl")
            dat <- read.csv(system.file("extdata", "dagLogoTestData.csv",
                                        package = "dagLogo"))
            seq <- fetchSequence(IDs = as.character(dat$entrez_geneid),
                                 anchorAA = "*",
                                 anchorPos = as.character(dat$peptide),
                                 mart = fly_mart,
                                 upstreamOffset = 7,
                                 downstreamOffset = 7)
            head(seq@peptides)
    })
}
```

In the following example, the anchoring AA is marked as lower case “s” for amino acid serine.

```
if(interactive()){
    try({
            dat <- read.csv(system.file("extdata", "peptides4dagLogo.csv",
                                package = "dagLogo"))
            ## cleanup the data
            dat <- unique(cleanPeptides(dat, anchors = "s"))

            mart <- useMart("ensembl")
            human_mart <-
            useDataset(mart = mart, dataset = "hsapiens_gene_ensembl")
            seq <- fetchSequence(IDs = toupper(as.character(dat$symbol)),
                                type = "hgnc_symbol",
                                anchorAA = "s",
                                anchorPos = as.character(dat$peptides),
                                mart = human_mart,
                                upstreamOffset = 7,
                                downstreamOffset = 7)
            head(seq@peptides)
    })
}
```

The function `cleanPeptides` can be used to select a subset of data to analyze
when input data contains multiple anchoring AAs, represented as lower case of
AAs.

```
if(interactive()){
    dat <- read.csv(system.file("extdata", "peptides4dagLogo.csv",
                package="dagLogo"))
    dat <- unique(cleanPeptides(dat, anchors = c("s", "t")))
    mart <- useMart("ensembl", "hsapiens_gene_ensembl")
    seq <- fetchSequence(toupper(as.character(dat$symbol)),
                         type="hgnc_symbol",
                         anchorAA=as.character(dat$anchor),
                         anchorPos=as.character(dat$peptides),
                         mart=mart,
                         upstreamOffset=7,
                         downstreamOffset=7)
    head(seq@peptides)
}
```

Similarly, peptide sequences can be fetched from an object of Proteome.

### 2.2.3 Case 3: Prepare an object of `dagPeptides` using `prepareProteome` and `formatSequence` functions sequentially given a list of unaligned/aligned ungapped peptide sequences.

```
dat <- unlist(read.delim(system.file("extdata", "grB.txt", package = "dagLogo"),
                        header = F, as.is = TRUE))
##prepare proteome from a fasta file,
##the fastq file is subset of human proteome for this vignette.
proteome <- prepareProteome(fasta = system.file("extdata",
                                                "HUMAN.fasta",
                                                package = "dagLogo"),
                            species = "Homo sapiens")
##prepare an object of dagPeptides
seq <- formatSequence(seq = dat, proteome = proteome, upstreamOffset = 14,
                      downstreamOffset = 15)
```

## 2.3 Step 2: Building background models

Once you have an object of `dagPeptides` in hand, you can start to build a background model for statistical significance test. The background could be a set of random subsequences of a whole proteome or your inputs. To build a background model from a whole proteome, an object of Proteome is required.
Sequences provided by a fasta file or downloaded from the UniProt database can be used to prepare a `Proteome` object. Case 3 in step 1 shows how to prepare a `Proteome` object from a fasta file. The following code snippet shows how to prepare an object of `Proteome` using the *UniProt.ws* package.

```
if(interactive()){
    proteome <- prepareProteome("UniProt", species = "Homo sapiens")
}
```

The prepared `Proteome` object can be used as a background model for the following statistical significance test using Fisher’s exact test or *Z*-test.

```
bg_fisher <- buildBackgroundModel(seq, background = "wholeProteome",
                                  proteome = proteome, testType = "fisher")
bg_ztest <- buildBackgroundModel(seq, background = "wholeProteome",
                                 proteome = proteome, testType = "ztest")
```

## 2.4 Step 3: Statistical significance test for differential usage of amino acids with or without grouping

Statistical significance test can be performed at the AA level without making any change to the formatted and aligned amino acids. Alternatively, statistical significance test can be performed at the AA group level, where amino acids are grouped based on their physical or chemical properties. To group the AAs, the formatted and aligned AA symbols are replaced by a new set of symbols representing their corresponding groups. For example, if AA charge is of your interest, then group symbols “P”, “N” and “U” are used to replace amino acids with positive charge, negative charge and no charge respectively. A few pre-built grouping schemes have been made available for you to specify as follows.

```
## no grouping
t0 <- testDAU(seq, dagBackground = bg_ztest)

## grouping based on chemical properties of AAs.
t1 <- testDAU(dagPeptides = seq, dagBackground = bg_ztest,
              groupingScheme = "chemistry_property_Mahler_group")

## grouping based on the charge of AAs.
t2 <- testDAU(dagPeptides = seq, dagBackground = bg_ztest,
              groupingScheme = "charge_group")

## grouping based on the consensus similarity.
t3 <- testDAU(dagPeptides = seq, dagBackground = bg_ztest,
              groupingScheme = "consensus_similarity_SF_group")

## grouping based on the hydrophobicity.
t4 <- testDAU(dagPeptides = seq, dagBackground = bg_ztest,
              groupingScheme = "hydrophobicity_KD")

## In addition, dagLogo allows users to use their own grouping
## Scheme. The following example shows how to supply a customized
## scheme. Please note that the user-supplied grouping is named
## as "custom_group" internally.
## Add a grouping scheme based on the level 3 of BLOSUM50
color = c(LVIMC = "#33FF00", AGSTP = "#CCFF00",
          FYW = '#00FF66', EDNQKRH = "#FF0066")
symbol = c(LVIMC = "L", AGSTP = "A", FYW = "F", EDNQKRH = "E")
group = list(
    LVIMC = c("L", "V", "I", "M", "C"),
    AGSTP = c("A", "G", "S", "T", "P"),
    FYW = c("F", "Y", "W"),
    EDNQKRH = c("E", "D", "N", "Q", "K", "R", "H"))
addScheme(color = color, symbol = symbol, group = group)
t5 <- testDAU(dagPeptides = seq, dagBackground = bg_ztest,
              groupingScheme = "custom_group")
```

## 2.5 Step 4: Visualize significance test results

We can use a heatmap or logo to display the statistical significance test results.

```
##Plot a heatmap to show the results
dagHeatmap(t0)
```

![DAG heatmap](data:image/png;base64...)

Figure 1: DAG heatmap

```
## dagLogo showing differentially used AAs without grouping
dagLogo(t0)
```

```
## Loading required namespace: Cairo
```

```
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
```

![ungrouped results](data:image/png;base64...)

Figure 2: ungrouped results

```
## dagLogo showing AA grouped based on properties of individual a amino acid.
dagLogo(t1, groupingSymbol = getGroupingSymbol(t1@group), legend = TRUE)
```

```
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
```

![classic grouping](data:image/png;base64...)

Figure 3: classic grouping

```
## grouped on the basis of charge.
dagLogo(t2, groupingSymbol = getGroupingSymbol(t2@group), legend = TRUE)
```

```
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
```

![grouped on charge](data:image/png;base64...)

Figure 4: grouped on charge

```
## grouped on the basis of consensus similarity.
dagLogo(t3, groupingSymbol = getGroupingSymbol(t3@group), legend = TRUE)
```

```
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
```

![grouped on chemical property](data:image/png;base64...)

Figure 5: grouped on chemical property

```
## grouped on the basis of hydrophobicity.
dagLogo(t4, groupingSymbol = getGroupingSymbol(t4@group), legend = TRUE)
```

```
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been
## generated by Cairo graphics; errors may result
```

![grouped on hydrophobicity](data:image/png;base64...)

Figure 6: grouped on hydrophobicity

# 3 Session Info

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
## [1] stats4    grid      stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] Biostrings_2.78.0   Seqinfo_1.0.0       XVector_0.50.0
##  [4] IRanges_2.44.0      S4Vectors_0.48.0    BiocGenerics_0.56.0
##  [7] generics_0.1.4      motifStack_1.54.0   UniProt.ws_2.50.0
## [10] biomaRt_2.66.0      dagLogo_1.48.0      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   bitops_1.0-9
##   [3] httr2_1.2.1                 rlang_1.1.6
##   [5] magrittr_2.0.4              ade4_1.7-23
##   [7] matrixStats_1.5.0           compiler_4.5.1
##   [9] RSQLite_2.4.3               png_0.1-8
##  [11] vctrs_0.6.5                 stringr_1.5.2
##  [13] pwalign_1.6.0               pkgconfig_2.0.3
##  [15] crayon_1.5.3                fastmap_1.2.0
##  [17] magick_2.9.0                dbplyr_2.5.1
##  [19] caTools_1.18.3              Rsamtools_2.26.0
##  [21] rmarkdown_2.30              DirichletMultinomial_1.52.0
##  [23] tinytex_0.57                bit_4.6.0
##  [25] xfun_0.53                   cachem_1.1.0
##  [27] cigarillo_1.0.0             jsonlite_2.0.0
##  [29] progress_1.2.3              blob_1.2.4
##  [31] DelayedArray_0.36.0         BiocParallel_1.44.0
##  [33] jpeg_0.1-11                 parallel_4.5.1
##  [35] prettyunits_1.2.0           R6_2.6.1
##  [37] bslib_0.9.0                 stringi_1.8.7
##  [39] RColorBrewer_1.1-3          rtracklayer_1.70.0
##  [41] GenomicRanges_1.62.0        jquerylib_0.1.4
##  [43] Rcpp_1.1.0                  bookdown_0.45
##  [45] SummarizedExperiment_1.40.0 knitr_1.50
##  [47] base64enc_0.1-3             BiocBaseUtils_1.12.0
##  [49] Matrix_1.7-4                tidyselect_1.2.1
##  [51] dichromat_2.0-0.1           abind_1.4-8
##  [53] yaml_2.3.10                 codetools_0.2-20
##  [55] curl_7.0.0                  rjsoncons_1.3.2
##  [57] lattice_0.22-7              tibble_3.3.0
##  [59] Biobase_2.70.0              KEGGREST_1.50.0
##  [61] S7_0.2.0                    evaluate_1.0.5
##  [63] BiocFileCache_3.0.0         pillar_1.11.1
##  [65] BiocManager_1.30.26         filelock_1.0.3
##  [67] MatrixGenerics_1.22.0       grImport2_0.3-3
##  [69] RCurl_1.98-1.17             hms_1.1.4
##  [71] ggplot2_4.0.0               scales_1.4.0
##  [73] gtools_3.9.5                glue_1.8.0
##  [75] pheatmap_1.0.13             seqLogo_1.76.0
##  [77] tools_4.5.1                 TFMPvalue_0.0.9
##  [79] BiocIO_1.20.0               BSgenome_1.78.0
##  [81] GenomicAlignments_1.46.0    XML_3.99-0.19
##  [83] Cairo_1.7-0                 TFBSTools_1.48.0
##  [85] AnnotationDbi_1.72.0        restfulr_0.0.16
##  [87] cli_3.6.5                   rappdirs_0.3.3
##  [89] S4Arrays_1.10.0             dplyr_1.1.4
##  [91] gtable_0.3.6                sass_0.4.10
##  [93] digest_0.6.37               SparseArray_1.10.0
##  [95] rjson_0.2.23                htmlwidgets_1.6.4
##  [97] farver_2.1.2                memoise_2.0.1
##  [99] htmltools_0.5.8.1           lifecycle_1.0.4
## [101] httr_1.4.7                  bit64_4.6.0-1
## [103] MASS_7.3-65
```

Bembom, Oliver. 2006. “SeqLogo: Sequence Logos for Dna Sequence Alignments.” *R Package Version 1.5.4*.

Colaert, Niklaas, Kenny Helsens, Lennart Martens, Joel Vandekerckhove, and Kris Gevaert. 2009. “Improved Visualization of Protein Consensus Sequences by iceLogo.” *Nature Methods* 6 (11): 786–87.

Crooks, Gavin E., Gary Hon, John-Marc Chandonia, and Steven E. Brenner. 2004. “WebLogo: A Sequence Logo Generator.” *Genome Research* 14: 1188–90.

Ou, Jianhong, Scot A Wolfe, Michael H Brodsky, and Lihua Julie Zhu. 2018. “MotifStack for the Analysis of Transcription Factor Binding Site Evolution.” *Nature Methods* 15 (1): 8.