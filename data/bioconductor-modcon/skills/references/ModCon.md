# Designing SD context with ModCon

#### Johannes Ptok

#### 10/30/2025

# Introduction

Splicing describes the process where intronic sequences are excised from a precursor RNA transcript and the remaining exonic sequences are spliced together. Almost every human RNA transcript is spliced, making its proper execution crucial for human health. Splicing is accomplished by a cellular mashinery called the spliceosome. The U1 snRNP subunit of the spliceosome recognizes the upstream end of an intron, called splice donor (SD) or 5’ splice site, whereas the downstream end of an intron, the splice acceptor (SA), or 3’ splice site is recognized via the U2 snRNP. The generall process is mediated by hundreds of proteins which either are part of the spliceosome, or which bind and guide the spliceosome to the RNA transcript. These RNA-binding so-called splice regulatory proteins (SRPs) basically consists of two major protein families, the SR proteins and the hnRNP, which influence splice site activation position-dependently. SR protein binding leads to activation of upstream SAs and downstream SDs, but a silencing of upstream SDs and downstream SAs. hnRNPs behave the other way around. The HEXplorer score uses this position-dependent effect of SRPs and calculates the property of sequences to activate or silence splice sites upstream or downsteam, via SR protein and hnRNP binding approximation. Combining the HEXplorer profile integral of the upstream and the downstream proximal sequence surrounding of a splice site, the splice site HEXplorer weight (SSHW) estimates whether the sequence surrounding potentially either enhances or silences splice site usage. The *ModCon* package, consists of functions which for the first time enable adjustment of the SSHW of a splice donor site via codon selection, while keeping the underlying amino acid sequence encoding intact. One application of ModCon could be during the design of splicing reporter or expression vectors.

# Implementation

ModCon can either be used to increase or decrease the splice site HEXplorer weight of a splice donor by codon selection. The respective SSHW adjustment can be accomplished to 0-100%. For 100% SSHW maximization or minimization, a sliding window approach is used, whereas a genetic algorithm is used for SSHW adjustments to less than 100%. For SSHW maximization, ModCon increases the HEXplorer profile upstream and decreases the HEXplorer profil downstream of the respective splice donor. For SSHW minimization, ModCon decreases the HEXplorer profil upstream and increases the HEXplorer profil downstream of the splice donor. HEXplorer score calculations during the genetic algorithm can be done parallel using the **parallel** package. ModCon additionally enables the degradation of the intrinsic strength of splice sites within the sequence surrounding which is altered for SSHW adjustment. For that purpose, the HBond score or the MaxEntScan score is applied to calculate the intrinsic strength of splice donor or splice acceptor sites. With kind approval of the developers, MaxEntScan score calculations are done using the published perl script. Therefor, **ModCon** relies on prior installation of any version of the programming language **Perl** (e.g. Strawberry Perl).

# Applying ModCon

The main function of the ModCon package is the `ModCon` function, which requires a coding sequence (CDS) and the position of the first nucleotide of the SD within the CDS. Per default, the SSHW of the respective SD is increased as much as possible.

```
library(ModCon)
```

```
## Loading required package: data.table
```

```
## Loading required package: parallel
```

```
#CDS holding the respective donor site
cds <- paste0('ATGGAAGACGCCAAAAACATAAAGAAAGGCCCGGCGCCATTCTATCCGCTG',
              'GAAGATGGAACCGCTGGAGAGCAACTGCATAAGGCTATGAAGAGATACGCC',
              'CTGGTTCCTGGAACAATTGCTTTTACAGATGCACATATCGAGGTGGACATC',
              'ACTTACGCTGAGTACTTCGAA')

## Executing ModCon to increase the splice site HEXplorer weigth of
## the splice donor at position 103
cdsSSHWincreased <- ModCon(cds, 103, nCores=1)
```

```
## Maximizing HZEI integral of upstream sequence...
```

```
## Minimizing HZEI integral of downstream sequence ...
```

```
## Position of first nt of SD seq: 103
```

```
## Length of substituted sequences upstream and dowstream: 48 and 48 nt
```

```
cdsSSHWincreased
```

```
## [1] "ATGGAAGACGCCAAAAACATAAAGAAAGGCCCGGCGCCATTCTATCCGCTGGAAGATGGAACAGCTGGAGAACAGCTGCACAAGGCGATGAAGAGATACGCCCTGGTTCCTGGAACTATTGCTTTTACTGACGCACATATAGAAGTTGACATAACTTATGCTGAGTACTTCGAA"
```

The resulting character string holds the alternative nucleotide sequence with an increased SSHW for the index splice donor site at position 103. The new CDS encodes the same amino acid sequence as before.

To achive the minimal SSHW, the ModCon function parameter `optimizeContext` has to be set to `FALSE`.

```
## Executing ModCon to decrease the splice site HEXplorer weigth of
## the splice donor at position 103
cdsSSHWdecreased <- ModCon(cds, 103, optimizeContext=FALSE, nCores=1)
```

```
## Maximize HZEI integral of downstream sequence...
```

```
## Minimizing HZEI integral of upstream sequence...
```

```
## Position of first nt of SD seq:103
```

```
## Length of substituted sequences upstream and dowstream:48and48nt
```

```
cdsSSHWdecreased
```

```
## [1] "ATGGAAGACGCCAAAAACATAAAGAAAGGCCCGGCGCCATTCTATCCGCTGGAAGATGGGACGGCTGGGGAACAGTTACATAAGGCTATGAAAAGGTATGCTCTGGTTCCTGGAACCATCGCCTTCACCGACGCGCACATCGAAGTGGACATCACCTACGCCGAGTACTTCGAA"
```

The resulting character string holds the alternative nucleotide sequence with an decreased SSHW for the index splice donor site at position 103. Again, the new CDS encodes the same amino acid sequence as before.

The extent of SSHW minimization and maximization can alternatively be limited to e.g. 60% of the maximum or minimum setting the `optiRate` to 60. The progress is omitted per generation (not shown in this vignette).

```
## Executing ModCon to increase the splice site HEXplorer weigth of
## the splice donor at position 103 to around 60% of the maximum
suppressMessages(cdsSSHWincreased <- ModCon(cds, 103, optiRate=60, nCores=1))
suppressMessages(cdsSSHWdecreased <- ModCon(cds, 103, optiRate=60, optimizeContext=FALSE, nCores=1))
cdsSSHWincreased
```

```
## [1] "ATGGAAGACGCCAAAAACATAAAGAAAGGCCCGGCGCCATTCTATCCGCTGGAAGACGGAACAGCTGGAGAACAGCTGCATAAGGCGATGAAGAGATACGCCCTGGTTCCTGGAACCATAGCTTTTACAGATGCTCATATAGAAGTTGACATAACATATGCGGAGTACTTCGAA"
```

```
cdsSSHWdecreased
```

```
## [1] "ATGGAAGACGCCAAAAACATAAAGAAAGGCCCGGCGCCATTCTATCCGCTGGAAGATGGGACAGCTGGGGAACAACTACATAAAGCTATGAAACGTTATGCCCTGGTTCCTGGAACCATCGCCTTCACCGACGCGCACATCGAAGTCGACATCACGTATGCGGAGTACTTCGAA"
```

The resulting character strings hold the alternative nucleotide sequences with either an increased or decreased SSHW for the index splice donor site at position 103. With setting the parameter `optiRate` to 60, the SSHW increase and SSHW decrease was only performed to reach the around 60% of the highest or lowest SSHW possible. Again, the new coding sequences encode the same amino acid sequence as the original CDS.

Changing the `optiRate` parameter of the `ModCon` function from the default value 100 triggers usage of the genetic algorithm, instead of the sliding window approach. Most parameters of the genetic algorithm and how many cores should be used for the calculations can be additionally adjusted with the respective `ModCon` function parameter.

```
## Executing ModCon to increase the splice site HEXplorer weigth of
## the splice donor at position 103 to around 60% of the maximum
suppressMessages(cdsSSHWincreased <- ModCon(cds, 103,
                                sdMaximalHBS=10, acMaximalMaxent=4, optiRate=60,
                                nGenerations=5, parentSize=200, startParentSize=800,
                                bestRate=50, semiLuckyRate=10, luckyRate=5,
                                mutationRate=1e-03, nCores=1))

cdsSSHWincreased
```

```
## [1] "ATGGAAGACGCCAAAAACATAAAGAAAGGCCCGGCGCCATTCTATCCGCTGGAAGATGGCACTGCTGGAGAACAACTACACAAGGCGATGAAGCGCTACGCACTGGTTCCTGGAACTATTGCTTTTACTGACGCACATATAGAAGTTGACATAACGTATGCGGAGTACTTCGAA"
```

As with the sliding window approach, the resulting character string holds the alternative nucleotide sequence with an increased SSHW for the index splice donor site at position 103. The new CDS encodes the same amino acid sequence as before.

The size of the sequence surroundings can be set using the parameters `upChangeCodonsIn` and `downChangeCodonsIn`, which define the number of codons to be adjusted around the splice site for SSHW adjustment (default=16).

```
## Executing ModCon to decrease the splice site HEXplorer weigth of
## the splice donor at position 103
cdsSSHWdecreased <- ModCon(cds, 103, downChangeCodonsIn=20, upChangeCodonsIn=21, nCores=1)
```

```
## Maximizing HZEI integral of upstream sequence...
```

```
## Minimizing HZEI integral of downstream sequence ...
```

```
## Position of first nt of SD seq: 103
```

```
## Length of substituted sequences upstream and dowstream: 63 and 60 nt
```

```
cdsSSHWdecreased
```

```
## [1] "ATGGAAGACGCCAAAAACATAAAGAAAGGCCCGGCGCCATTCTACCCGCTGGAAGATGGAACAGCTGGAGAGCAGCTGCACAAAGCGATGAAGCGCTACGCCCTGGTTCCTGGAACTATTGCTTTTACTGACGCACATATAGAAGTTGACATAACTTATGCTGAGTATTTTGAG"
```

As with the sliding window approach, the resulting character string holds the alternative nucleotide sequence with an decreased SSHW for the index splice donor site at position 103. The new CDS encodes the same amino acid sequence as before.

The **ModCon** package additionally holds functions to increase or decrease the intrinsic strength (Hbond score) of a secific splice donor site while keeping the underlying encoded amino acid sequences the same.

```
## Decreaser HBond score of the splice donor at position 103
## by codon selection
cdsHBondDown <- decreaseGTsiteStrength(cds, 103)
cdsHBondUp <- increaseGTsiteStrength(cds, 103)
cdsHBondDown
```

```
## [1] "ATGGAAGACGCCAAAAACATAAAGAAAGGCCCGGCGCCATTCTATCCGCTGGAAGATGGAACCGCTGGAGAGCAACTGCATAAGGCTATGAAGAGATACGCCTTAGTTCCAGGGACAATTGCTTTTACAGATGCACATATCGAGGTGGACATCACTTACGCTGAGTACTTCGAA"
```

`cdsHBondDown` states a coding sequence, encoding the same amino acid as the input CDS. However, a splice donor sequence at the stated index position within the CDS will be aimed to be decrased in its intrinsic strength. `cdsHBondUp` states a coding sequence, encoding the same amino acid as the input CDS. However, a splice donor sequence at the stated index position within the CDS will be aimed to be decrased in its intrinsic strength.

Integrated functions also include functions to decrease the intrinisc strength of every splice donor or acceptor within a coding sequence, while considering whether the overall HEXplorer profile should be increased or decreased of the respective entered sequence.

```
library(data.table)
## Initiaing the Codons matrix plus corresponding amino acids
ntSequence <- 'TTTTCGATCGGGATTAGCCTCCAGGTAAGTATCTATCGATCTATGCGATAG'
## Create Codon Matrix by splitting up the sequence by 3nt
fanFunc <- createCodonMatrix(ntSequence)
cdsSDlow <- degradeSDs(fanFunc, maxhbs=10, increaseHZEI=TRUE)
cdsSAlow <- degradeSAs(fanFunc, maxhbs=10, maxME=4, increaseHZEI=TRUE)
cdsSDlow
```

```
## [1] "TTTTCGATCGGGATTAGCCTCCAAGTTTCGATCTATCGATCTATGCGATAG"
```

```
cdsSAlow
```

```
## [1] "TTTTCGATCGGGATTAGCCTCCAGGTAAGTATCTATCGATCTATGCGATAG"
```

`cdsSDlow` states a coding sequence, encoding the same amino acid as the input CDS. However, every potential splice donor sequence within the CDS, which exceeds a Hbond score treshold (`maxhbs`) will be aimed to be degraded in its intrinsic strength as much as possible. If, additionally, potential splice acceptor sites should be degraded in their intrinsic strengt, the following function `degradeSAs` will reduce the number of potential relevant splice acceptor sites within the CDS. `cdsSAlow` states a coding sequence, encoding the same amino acid as the input CDS. However, every potential splice donor sequence within the CDS, which exceeds a Hbond score treshold (`maxhbs`) and every potential splice acceptor site, which exceeds a certain MaxEntScan score treshold, will be aimed to be degraded in its intrinsic strength as much as possible.

A graphic user interface based on shiny can be opened with the function `startModConApp.Rd`.

# Session info

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
## [1] parallel  stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] ModCon_1.18.0     data.table_1.17.8
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37     R6_2.6.1          fastmap_1.2.0     xfun_0.53
##  [5] cachem_1.1.0      knitr_1.50        htmltools_0.5.8.1 rmarkdown_2.30
##  [9] lifecycle_1.0.4   cli_3.6.5         sass_0.4.10       jquerylib_0.1.4
## [13] compiler_4.5.1    tools_4.5.1       evaluate_1.0.5    bslib_0.9.0
## [17] yaml_2.3.10       rlang_1.1.6       jsonlite_2.0.0
```