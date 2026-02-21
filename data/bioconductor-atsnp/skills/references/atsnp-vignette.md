# atSNP: affinity tests for regulatory SNP detection

Chandler Zuo1, Sunyoung Shin2\* and Sunduz Keles3

1Facebook
2University of Texas at Dallas
3University of Wisconsin - Madison

\*sunyoung.shin@utdallas.edu

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Example](#example)
  + [3.1 Load the motif library](#load-the-motif-library)
    - [3.1.1 ENCODE derived motif library](#encode-derived-motif-library)
    - [3.1.2 JASPAR database motif library](#jaspar-database-motif-library)
    - [3.1.3 User defined motif library](#user-defined-motif-library)
  + [3.2 Load the SNP Data](#load-the-snp-data)
    - [3.2.1 Load SNP data through a table](#load-snp-data-through-a-table)
    - [3.2.2 Load SNP data through dbSNP’s rsids](#load-snp-data-through-dbsnps-rsids)
    - [3.2.3 Load SNP data through a pair of fasta files](#load-snp-data-through-a-pair-of-fasta-files)
  + [3.3 Affinity score tests](#affinity-score-tests)
    - [3.3.1 Load the example data](#load-the-example-data)
    - [3.3.2 Compute affinity scores](#compute-affinity-scores)
    - [3.3.3 Compute p-values](#compute-p-values)
    - [3.3.4 Multiple testing adjustment](#multiple-testing-adjustment)
  + [3.4 Additional analysis](#additional-analysis)
* [4 Session Information](#session-information)

# 1 Introduction

This document provides an introduction to the affinity test for large sets of SNP-motif interactions using the *atSNP* package(**a**ffinity **t**est for regulatory **SNP** detection) (Zuo, Shin, and Keles [2015](#ref-zuo15)). *atSNP* implements in-silico methods for identifying SNPs that potentially may affect binding affinity of transcription factors. Given a set of SNPs and a library of motif position weight matrices (PWMs), *atSNP* provides two main functions for analyzing SNP effects:

1. Computing the binding affinity score for each allele and each PWM and the p-values for the allele-specific binding affinity scores.
2. Computing the p-values for affinity score changes between the two alleles for each SNP.

*atSNP* implements the importance sampling algorithm in Chan, Zhang, and Chen ([2010](#ref-isample)) to compute the p-values. Compared to other bioinformatics tools, such as FIMO (Grant, Bailey, and Nobel [2011](#ref-fimo)) and is-rSNP (Macintyre et al. [2010](#ref-is-rsnp)) that provide similar functionalities, *atSNP* avoids computing the p-values analytically. In one of our research projects, we have used atSNP to evaluate interactions between 26K SNPs and 2K motifs within 5 hours. We found no other existing tools can finish the analysis of such a scale.

# 2 Installation

*atSNP* depends on the following packages:

1. *[data.table](https://CRAN.R-project.org/package%3Ddata.table)* is used for formatting results that are easy for users to query.
2. *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* is used for parallel computation.
3. *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* is used for operating genomic intervals.
4. *[motifStack](https://bioconductor.org/packages/3.22/motifStack)* is relied upon to draw sequence logo plots.
5. *[Rcpp](https://CRAN.R-project.org/package%3DRcpp)* interfaces the C++ codes that implements the importance sampling algorithm.

In addition, users need to install the annotation package *[BSgenome](https://bioconductor.org/packages/3.22/BSgenome)* from <http://www.bioconductor.org/packages/3.0/data/annotation/> that corresponds to the species type and genome version. Our example SNP data set in the subsequent sections corresponds to the hg38 version of human genome. If users wish to annotate the SNP location and allele information given their rs ids, they also need to install the corresponding *[SNPlocs](https://bioconductor.org/packages/3.22/SNPlocs)* package. Notice that the annotation packages are usually large and this installation step may take a substantial amount of time.

# 3 Example

## 3.1 Load the motif library

*atSNP* includes two motif libraries in the package: the ENCODE derived motif library, and the JASPAR database motif library. In addition, *atSNP* can load user defined motif libraries in a variety of formats.

### 3.1.1 ENCODE derived motif library

*atSNP* provides a default motif library downloaded from <http://compbio.mit.edu/encode-motifs/motifs.txt>. This library contains 2065 known and discovered motifs from ENCODE TF ChIP-seq data sets. The following commands allow to load this motif library:

```
library(atSNP)
```

```
data(encode_library)
length(encode_motif)
```

```
## [1] 2065
```

```
encode_motif[1]
```

```
## $SIX5_disc1
##              [,1]       [,2]     [,3]        [,4]
##  [1,] 8.51100e-03 4.2550e-03 0.987234 1.00000e-10
##  [2,] 9.02127e-01 1.2766e-02 0.038298 4.68090e-02
##  [3,] 4.55319e-01 7.2340e-02 0.344681 1.27660e-01
##  [4,] 2.51064e-01 8.5106e-02 0.085106 5.78724e-01
##  [5,] 1.00000e-10 4.6809e-02 0.012766 9.40425e-01
##  [6,] 1.00000e-10 1.0000e-10 1.000000 1.00000e-10
##  [7,] 3.82980e-02 2.1277e-02 0.029787 9.10638e-01
##  [8,] 9.44681e-01 4.2550e-03 0.051064 1.00000e-10
##  [9,] 1.00000e-10 1.0000e-10 1.000000 1.00000e-10
## [10,] 1.00000e-10 1.0000e-10 0.012766 9.87234e-01
```

Here, the motif library is represented by `encode_motif`,
which is a list of position weight matrices. The codes below show the content of one matrix as well as its IUPAC letters:

```
encode_motif[[1]]
```

```
##              [,1]       [,2]     [,3]        [,4]
##  [1,] 8.51100e-03 4.2550e-03 0.987234 1.00000e-10
##  [2,] 9.02127e-01 1.2766e-02 0.038298 4.68090e-02
##  [3,] 4.55319e-01 7.2340e-02 0.344681 1.27660e-01
##  [4,] 2.51064e-01 8.5106e-02 0.085106 5.78724e-01
##  [5,] 1.00000e-10 4.6809e-02 0.012766 9.40425e-01
##  [6,] 1.00000e-10 1.0000e-10 1.000000 1.00000e-10
##  [7,] 3.82980e-02 2.1277e-02 0.029787 9.10638e-01
##  [8,] 9.44681e-01 4.2550e-03 0.051064 1.00000e-10
##  [9,] 1.00000e-10 1.0000e-10 1.000000 1.00000e-10
## [10,] 1.00000e-10 1.0000e-10 0.012766 9.87234e-01
```

```
GetIUPACSequence(encode_motif[[1]])
```

```
## [1] "GARWTGTAGT"
```

The data object `encode_library` also contains a character vector `encode_motifinfo` that contains detailed information for each motif.

```
length(encode_motifinfo)
```

```
## [1] 2065
```

```
head(encode_motifinfo)
```

```
##                                                 SIX5_disc1
##   "SIX5_GM12878_encode-Myers_seq_hsa_r1:MEME#1#Intergenic"
##                                                  MYC_disc1
##   "USF2_K562_encode-Snyder_seq_hsa_r1:MDscan#1#Intergenic"
##                                                  SRF_disc1
##  "SRF_H1-hESC_encode-Myers_seq_hsa_r1:MDscan#2#Intergenic"
##                                                  AP1_disc1
##     "JUND_K562_encode-Snyder_seq_hsa_r1:MEME#1#Intergenic"
##                                                 SIX5_disc2
## "SIX5_H1-hESC_encode-Myers_seq_hsa_r1:MDscan#1#Intergenic"
##                                                  NFY_disc1
##     "NFYA_K562_encode-Snyder_seq_hsa_r1:MEME#2#Intergenic"
```

Here, the entry names of this vector are the same as the names of the motif library. `encode_motifinfo` allows easy looking up of the motif information for a specific PWM. For example, to look up the motif information for the first PWM in `encode_motifinfo`, use the following chunk of code:

```
encode_motifinfo[names(encode_motif[1])]
```

```
##                                               SIX5_disc1
## "SIX5_GM12878_encode-Myers_seq_hsa_r1:MEME#1#Intergenic"
```

### 3.1.2 JASPAR database motif library

Our package also includes the JASPAR library downloaded from <http://jaspar.genereg.net/html/DOWNLOAD/JASPAR_CORE/pfm/nonredundant/pfm_all.txt>. The data object `jaspar_library` contains a list of 593 PWMs `jaspar_motif` and a character vector `jaspar_motifinfo`.

```
data(jaspar_library)
jaspar_motif[[1]]
```

```
##            [,1]       [,2]       [,3]       [,4]
## [1,] 0.20833333 0.70833333 0.04166667 0.04166667
## [2,] 0.83333333 0.04166667 0.08333333 0.04166667
## [3,] 0.04166667 0.87500000 0.04166667 0.04166667
## [4,] 0.04166667 0.04166667 0.87500000 0.04166667
## [5,] 0.04166667 0.04166667 0.04166667 0.87500000
## [6,] 0.04166667 0.04166667 0.87500000 0.04166667
```

```
jaspar_motifinfo[names(jaspar_motif[1])]
```

```
## MA0004.1
##   "Arnt"
```

### 3.1.3 User defined motif library

Users can also provide a list of PWMs as the motif library via the `LoadMotifLibrary` function. In this function, ‘tag’ specifies the string that marks the start of each block of PWM; ‘skiprows’ is the number of description lines before the PWM; ‘skipcols’ is the number of columns to be skipped in the PWM matrix; ‘transpose’ is TRUE if the PWM has 4 rows representing A, C, G, T or FALSE if otherwise; ‘field’ is the position of the motif name within the description line; ‘sep’ is a vector of separators in the PWM; ‘pseudocount’ is the number added to the raw matrices, recommended to be 1 if the matrices are in fact position frequency matrices. These arguments provide the flexibility of loading a number of varying formatted files. The PWMs are returned as a list object. This function flexibly adapts to a variety of different formats. Some examples using online accessible files from other research groups are shown below.

```
## Source: http://meme.nbcr.net/meme/doc/examples/sample-dna-motif.meme-io
pwms <- LoadMotifLibrary(
 urlname="http://pages.stat.wisc.edu/~keles/atSNP-Data/sample-dna-motif.meme-io.txt")

## Source: http://compbio.mit.edu/encode-motifs/motifs.txt
pwms <- LoadMotifLibrary(
 urlname="http://pages.stat.wisc.edu/~keles/atSNP-Data/motifs.txt",
 tag = ">", transpose = FALSE, field = 1,
 sep = c("\t", " ", ">"), skipcols = 1,
 skiprows = 1, pseudocount = 0)

## Source: http://johnsonlab.ucsf.edu/mochi_files/JASPAR_motifs_H_sapiens.txt
pwms <- LoadMotifLibrary(
 urlname="http://pages.stat.wisc.edu/~keles/atSNP-Data/JASPAR_motifs_H_sapiens.txt",
 tag = "/NAME",skiprows = 1, skipcols = 0, transpose = FALSE,
 field = 2)

## Source: http://jaspar.genereg.net/html/DOWNLOAD/ARCHIVE/JASPAR2010/all_data/matrix_only/matrix.txt
pwms <- LoadMotifLibrary(
 urlname="http://pages.stat.wisc.edu/~keles/atSNP-Data/matrix.txt",
 tag = ">", skiprows = 1, skipcols = 1, transpose = TRUE,
 field = 1, sep = c("\t", " ", "\\[", "\\]", ">"),
 pseudocount = 1)

## Source: http://jaspar.genereg.net/html/DOWNLOAD/JASPAR_CORE/pfm/nonredundant/pfm_vertebrates.txt
pwms <- LoadMotifLibrary(
 urlname="http://pages.stat.wisc.edu/~keles/atSNP-Data/pfm_vertebrates.txt",
 tag = ">", skiprows = 1, skipcols = 0, transpose = TRUE, field = 1,
 sep = c(">", "\t", " "), pseudocount = 1)
```

## 3.2 Load the SNP Data

*atSNP* can load the SNP data in three formats: a table including full SNP information, a list of dbSNP’s rsids, and a pair of fasta files.

### 3.2.1 Load SNP data through a table

In this case, the table that provides the SNP information must include five columns:

1. chr: the chromosome ID;
2. snp: the genome coordinate of the SNP;
3. snpid: the string for the SNP name;
4. a1, a2: nucleotides for the two alleles at the SNP position.

This data set can be loaded using the `LoadSNPData` function. The ‘genome.lib’ argument specifies the annotation package name corresponding to the SNP data set, such as ‘BSgenome.Hsapiens.UCSC.hg38’. Each side of the SNP is extended by a number of base pairs specified by the ‘half.window.size’ argument. `LoadSNPData` extracts the genome sequence within such windows around each SNP using the ‘genome.lib’ package. An example is the following:

The following codes generate a synthetic SNP data and loads it back in :

```
data(example)
write.table(snp_tbl, file = "test_snp_file.txt",
            row.names = FALSE, quote = FALSE)
snp_info <- LoadSNPData("test_snp_file.txt", genome.lib = "BSgenome.Hsapiens.UCSC.hg38", half.window.size = 30, default.par = TRUE, mutation = FALSE)
ncol(snp_info$sequence) == nrow(snp_tbl)
snp_info$rsid.rm
```

There are two important arguments in function `LoadSNPData`. First, the ‘mutation’ argument specifies whether the data set is related to SNP or general single nucleotide mutation. By default, ‘mutation=FALSE’. In this case, `LoadSNPData` get the nucleotides on the reference genome based on the genome coordinates specified by ‘chr’ and ‘snp’ and match them to ‘a1’ and ‘a2’ alleles from the *[BSgenome](https://bioconductor.org/packages/3.22/BSgenome)* package. ‘a1’ and ‘a2’ nucleotides are assigned to the refrence or the SNP allele based on which one matches to the reference nucleotide. If neither allele matches to the reference nucleotide, the corresponding row in the SNP information file is discarded. These discarded SNPs are captured by the ‘rsid.rm’ field in the output. Alternatively, if ‘mutation=TRUE’, no row is discarded. `LoadSNPData` takes the reference sequences around the SNP locations, replaces the reference nucleotides at the SNP locations by ‘a1’ nucleotides to construct the ‘reference’ sequences, and by ‘a2’ nucleotides to construct the ‘SNP’ sequences. Notice that in this case, in the subsequent analysis, whenever we refer to the ‘reference’ or the ‘SNP’ allele, it actually means the ‘a1’ or the ‘a2’ allele.

```
mutation_info <- LoadSNPData("test_snp_file.txt", genome.lib = "BSgenome.Hsapiens.UCSC.hg38", half.window.size = 30, default.par = TRUE, mutation = TRUE)
ncol(mutation_info$sequence) == nrow(snp_tbl)
file.remove("test_snp_file.txt")
```

Second, the ‘default.par’ argument specifies how to estimate the first order Markov model parameters. If ‘default.par = FALSE’, `LoadSNPData` simultaneously estimates the parameters for the first order Markov model in the reference genome using the nucleotides within the SNP windows. Otherwise, it loads a set of parameter values pre-fitted from sequences around all the SNPs in the NHGRI GWAS catalog (Hindorff et al. [2009](#ref-nhgri-gwas)). We recommend setting ‘default.par = TRUE’ when we have fewer than 1000 SNPs. `LoadSNPData` returns a list object with five fields:

1. sequence\_matrix: a matrix with (2\*‘half.window.size’ + 1), with each column corresponding to one SNP. The entries 1-4 represent the A, C, G, T nucleotides.
2. ref\_base: a vector coding the reference allele nucleotides for all SNPs.
3. snp\_base: a vector coding the SNP allele nucleotides for all SNPs.
4. prior: the stationary distribution parameters for the Markov model.
5. transition: the transition matrix for the first order Markov model.

### 3.2.2 Load SNP data through dbSNP’s rsids

`LoadSNPData` also allows users to load a list of rsids for the SNPs. In this case, the function looks up the SNP location and the allele information using the annotation package specified by ‘snp.lib’, such as ‘SNPlocs.Hsapiens.dbSNP144.GRCh38’.

```
snp_info1 <- LoadSNPData(snpids = c("rs5050", "rs616488", "rs11249433", "rs182799", "rs12565013", "rs11208590"), genome.lib ="BSgenome.Hsapiens.UCSC.hg38", snp.lib = "SNPlocs.Hsapiens.dbSNP144.GRCh38", half.window.size = 30, default.par = TRUE, mutation = FALSE)
```

`LoadSNPData` may warn about the SNPs with inconsistent information and returns them in the output. The ‘rsid.missing’ output field captures SNPs that are not included in the *[SNPlocs](https://bioconductor.org/packages/3.22/SNPlocs)* package. The ‘rsid.duplicate’ output field captures SNPs with more than 2 alleles based on *[SNPlocs](https://bioconductor.org/packages/3.22/SNPlocs)* package. The ‘rsid.rm’ output field captures SNPs whose nucleotides in the reference genome do not match to either allele provided by the data source. SNPs in the ‘rsid.missing’ and ‘rsid.rm’ fields are discarded. For SNPs in ‘rsid.duplicate’, we extract all pairs of alleles as reference and SNP pairs. If ‘mutation=TRUE’, we include all of them in the output. If ‘mutation=FALSE’, these pairs are further filtered based on whether one allele matches to the reference genome nucleotide. The remaining alleles are contained in the output.

### 3.2.3 Load SNP data through a pair of fasta files

Users can also provide SNP data through a pair of fasta files, one for the sequences around the SNP location for each allele. An example of such files is at <http://pages.stat.wisc.edu/~keles/atSNP-Data/sample_1.fasta> and <http://pages.stat.wisc.edu/~keles/atSNP-Data/sample_2.fasta>. We require that such a pair of fasta files must satisfy the following conditions:

1. All sequences from both files must be of the same odd number of length.
2. Sequences from the same position in each file are a pair of alleles. Their nucleotides must be the same except for the central nucleotide.

Such a pair of files can be loaded by the function `LoadFastaData`:

```
snp_info2 <- LoadFastaData(ref.urlname="http://pages.stat.wisc.edu/~keles/atSNP-Data/sample_1.fasta", snp.urlname="http://pages.stat.wisc.edu/~keles/atSNP-Data/sample_2.fasta", default.par = TRUE)
```

## 3.3 Affinity score tests

### 3.3.1 Load the example data

We use a toy example data set included in the package to introduce the usage of functions for affinity score tests.

```
data(example)
names(motif_library)
```

```
## [1] "SIX5_disc1" "MYC_disc1"
```

```
str(snpInfo)
```

```
## List of 10
##  $ sequence_matrix: int [1:61, 1:2] 1 1 1 3 3 1 1 1 3 3 ...
##  $ ref_base       : int [1:2] 1 2
##  $ snp_base       : int [1:2] 3 4
##  $ snpids         : chr [1:2] "rs53576" "rs7412"
##  $ transition     : num [1:4, 1:4] 0.323 0.345 0.281 0.215 0.174 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : chr [1:4] "A" "C" "G" "T"
##   .. ..$ : chr [1:4] "A" "C" "G" "T"
##  $ prior          : Named num [1:4] 0.287 0.211 0.213 0.289
##   ..- attr(*, "names")= chr [1:4] "A" "C" "G" "T"
##  $ rsid.na        : NULL
##  $ rsid.rm        : NULL
##  $ rsid.duplicate : NULL
##  $ rsid.missing   : NULL
```

```
## to look at the motif information
data(encode_library)
encode_motifinfo[names(motif_library)]
```

```
##                                               SIX5_disc1
## "SIX5_GM12878_encode-Myers_seq_hsa_r1:MEME#1#Intergenic"
##                                                MYC_disc1
## "USF2_K562_encode-Snyder_seq_hsa_r1:MDscan#1#Intergenic"
```

### 3.3.2 Compute affinity scores

The binding affinity scores for all pairs of SNP and PWM can be computed by the `ComputeMotifScore` function. It returns a list of two fields: ‘snp.tbl’ is a *data.frame* containing the nucleotide sequences for each SNP; ‘motif.scores’ is a *data.frame* containing the binding affinity scores for each SNP-motif pair.

```
atsnp.scores <- ComputeMotifScore(motif_library, snpInfo, ncores = 1)
atsnp.scores$snp.tbl
```

```
##     snpid                                                       ref_seq
## 1 rs53576 AAAGGAAAGGTGTACGGGACATGCCCGAGGATCCTCAGTCCCACAGAAACAGGGAGGGGCT
## 2  rs7412 CTCCTCCGCGATGCCGATGACCTGCAGAAGCGCCTGGCAGTGTACCAGGCCGGGGCCCGCG
##                                                         snp_seq
## 1 AAAGGAAAGGTGTACGGGACATGCCCGAGGGTCCTCAGTCCCACAGAAACAGGGAGGGGCT
## 2 CTCCTCCGCGATGCCGATGACCTGCAGAAGTGCCTGGCAGTGTACCAGGCCGGGGCCCGCG
##                                                     ref_seq_rev
## 1 AGCCCCTCCCTGTTTCTGTGGGACTGAGGATCCTCGGGCATGTCCCGTACACCTTTCCTTT
## 2 CGCGGGCCCCGGCCTGGTACACTGCCAGGCGCTTCTGCAGGTCATCGGCATCGCGGAGGAG
##                                                     snp_seq_rev snpbase
## 1 AGCCCCTCCCTGTTTCTGTGGGACTGAGGACCCTCGGGCATGTCCCGTACACCTTTCCTTT       G
## 2 CGCGGGCCCCGGCCTGGTACACTGCCAGGCACTTCTGCAGGTCATCGGCATCGCGGAGGAG       T
```

```
atsnp.scores$motif.scores
```

```
##        motif motif_len   snpid log_lik_ref log_lik_snp log_lik_ratio
## 1  MYC_disc1        10 rs53576   -97.08772   -95.57417    -1.5135592
## 2  MYC_disc1        10  rs7412   -94.21702   -94.64204     0.4250229
## 3 SIX5_disc1        10 rs53576   -34.64551   -37.80486     3.1593576
## 4 SIX5_disc1        10  rs7412   -42.60672   -38.40830    -4.1984180
##   log_enhance_odds log_reduce_odds ref_start snp_start ref_end snp_end
## 1         1.513559       -1.513559        31        31      40      40
## 2        23.025851       23.025851        29        25      38      34
## 3        -3.159358        3.159358        30        30      39      39
## 4        23.013003       -2.917768        29        22      38      31
##   ref_strand snp_strand snpbase
## 1          -          -       G
## 2          +          -       T
## 3          +          +       G
## 4          -          +       T
```

The affinity scores for the reference and the SNP alleles are represented by the `log_lik_ref` and `log_lik_snp` columns in `motif.scores`. The affinity score change is included in the `log_lik_ratio` column. These three affinity scores are tested in the subsequent steps. `motif.scores` also includes other columns for the position of the best matching subsequence on each allele. For a complete description on all these columns, users can look up the help documentation.

### 3.3.3 Compute p-values

After we have computed the binding affinity scores, they can be tested using the `ComputePValues` function. The result is a *data.frame* extending the affinity score table by six columns:

1. `pval_ref`: p-value for the reference allele affinity score.
2. `pval_snp`: p-value for the SNP allele affinity score.
3. `pval_cond_ref` and `pval_cond_snp`: conditional p-values for the affinity scores of the reference and SNP alleles.
4. `pval_diff`: p-value for the affinity score change between the two alleles.
5. `pval_rank`: p-value for the rank test between the two alleles.

We recommend using `pval_ref`and `pval_snp` for assessing the significance of allele specific affinity; and using `pval_rank` for assessing the significance of the SNP effect on the affinity change.

```
atsnp.result <- ComputePValues(motif.lib = motif_library, snp.info = snpInfo,
                               motif.scores = atsnp.scores$motif.scores, ncores = 1, testing.mc=TRUE)
```

```
## Finished testing motif No. 1
```

```
## Finished testing motif No. 2
```

```
atsnp.result
```

```
##        motif motif_len   snpid log_lik_ref log_lik_snp log_lik_ratio
## 1  MYC_disc1        10 rs53576   -97.08772   -95.57417    -1.5135592
## 2  MYC_disc1        10  rs7412   -94.21702   -94.64204     0.4250229
## 3 SIX5_disc1        10 rs53576   -34.64551   -37.80486     3.1593576
## 4 SIX5_disc1        10  rs7412   -42.60672   -38.40830    -4.1984180
##   log_enhance_odds log_reduce_odds ref_start snp_start ref_end snp_end
## 1         1.513559       -1.513559        31        31      40      40
## 2        23.025851       23.025851        29        25      38      34
## 3        -3.159358        3.159358        30        30      39      39
## 4        23.013003       -2.917768        29        22      38      31
##   ref_strand snp_strand snpbase  pval_ref  pval_snp pval_cond_ref pval_cond_snp
## 1          -          -       G 0.6692964 0.4600707     0.5802939     0.4581673
## 2          +          -       T 0.3856207 0.4465672     0.3040941     0.3074180
## 3          +          +       G 0.4067999 0.5295781     0.4067999     0.5295781
## 4          -          +       T 0.8023086 0.7065076     0.8023086     0.7065076
##   pval_diff pval_rank
## 1 0.6782347 0.4785981
## 2 0.7979355 0.7151016
## 3 0.6542707 0.4051182
## 4 0.3710643 0.7283699
```

First, we can sort this output table according to the `pval_rank` column:

```
head(atsnp.result[order(atsnp.result$pval_rank), c("snpid", "motif", "pval_ref", "pval_snp", "pval_rank")])
```

```
##     snpid      motif  pval_ref  pval_snp pval_rank
## 3 rs53576 SIX5_disc1 0.4067999 0.5295781 0.4051182
## 1 rs53576  MYC_disc1 0.6692964 0.4600707 0.4785981
## 2  rs7412  MYC_disc1 0.3856207 0.4465672 0.7151016
## 4  rs7412 SIX5_disc1 0.8023086 0.7065076 0.7283699
```

### 3.3.4 Multiple testing adjustment

We can apply multiple testing adjustment to the p-values. *atSNP* does not implement any multiple testing adjustment internally. Users have the flexibility of choosing an adjustment method based on their specific application. For example, if we want to adjust `pval_rank` from all pairs of SNP-PWM pairs using the Benjamini-Hochberg’s procedure, we may compute:

```
##     snpid      motif pval_rank pval_rank_bh
## 1 rs53576  MYC_disc1 0.4785981    0.7283699
## 2  rs7412  MYC_disc1 0.7151016    0.7283699
## 3 rs53576 SIX5_disc1 0.4051182    0.7283699
## 4  rs7412 SIX5_disc1 0.7283699    0.7283699
```

Alternatively, if we want to compute Storey’s q-values, we may utilize the *[qvalue](https://bioconductor.org/packages/3.22/qvalue)* package from :

```
library(qvalue)
qval_rank = qvalue(atsnp.result$pval_rank, pi0=0.1)$qvalues
atsnp.result = cbind(atsnp.result, qval_rank)
```

## 3.4 Additional analysis

atSNP provides additional functions to extract the matched nucleotide subsequences that match to the motifs. The function `MatchSubsequence` adds the subsequence matches to the affinity score table by using the motif library and the SNP set. The subsequences matching to the motif in the two alleles are returned in the `ref_match_seq` and `snp_match_seq` columns. The ‘IUPAC’ column returns the IUPAC letters of the motifs. Notice that if you have a large number of SNPs and motifs, the returned table can be very large.

```
match.subseq_result <- MatchSubsequence(snp.tbl = atsnp.scores$snp.tbl, motif.scores = atsnp.result, motif.lib = motif_library, snpids = c("rs53576", "rs7412"), motifs = names(motif_library)[1], ncores = 1)
match.subseq_result[c("snpid", "motif", "IUPAC", "ref_match_seq", "snp_match_seq")]
```

```
##     snpid      motif      IUPAC ref_match_seq snp_match_seq
## 1 rs53576 SIX5_disc1 GARWTGTAGT    GATCCTCAGT    GGTCCTCAGT
## 2  rs7412 SIX5_disc1 GARWTGTAGT    GCCAGGCGCT    CTGCAGAAGT
```

To visualize how each motif is matched to each allele using the `plotMotifMatch` function:

```
match.seq<-dtMotifMatch(atsnp.scores$snp.tbl, atsnp.scores$motif.scores, snpids="rs53576", motifs="SIX5_disc1", motif.lib = motif_library)
plotMotifMatch(match.seq,  motif.lib = motif_library)
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
```

![](data:image/png;base64...)

# 4 Session Information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] atSNP_1.26.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   bitops_1.0-9
##   [3] httr2_1.2.1                 formatR_1.14
##   [5] rlang_1.1.6                 magrittr_2.0.4
##   [7] ade4_1.7-23                 matrixStats_1.5.0
##   [9] compiler_4.5.1              RSQLite_2.4.3
##  [11] png_0.1-8                   vctrs_0.6.5
##  [13] pwalign_1.6.0               pkgconfig_2.0.3
##  [15] crayon_1.5.3                fastmap_1.2.0
##  [17] magick_2.9.0                dbplyr_2.5.1
##  [19] XVector_0.50.0              motifStack_1.54.0
##  [21] caTools_1.18.3              Rsamtools_2.26.0
##  [23] rmarkdown_2.30              DirichletMultinomial_1.52.0
##  [25] tinytex_0.57                purrr_1.1.0
##  [27] bit_4.6.0                   xfun_0.53
##  [29] cachem_1.1.0                cigarillo_1.0.0
##  [31] jsonlite_2.0.0              blob_1.2.4
##  [33] DelayedArray_0.36.0         BiocParallel_1.44.0
##  [35] jpeg_0.1-11                 parallel_4.5.1
##  [37] R6_2.6.1                    bslib_0.9.0
##  [39] RColorBrewer_1.1-3          rtracklayer_1.70.0
##  [41] GenomicRanges_1.62.0        jquerylib_0.1.4
##  [43] Rcpp_1.1.0                  Seqinfo_1.0.0
##  [45] bookdown_0.45               SummarizedExperiment_1.40.0
##  [47] knitr_1.50                  base64enc_0.1-3
##  [49] IRanges_2.44.0              Matrix_1.7-4
##  [51] tidyselect_1.2.1            dichromat_2.0-0.1
##  [53] abind_1.4-8                 yaml_2.3.10
##  [55] codetools_0.2-20            curl_7.0.0
##  [57] lattice_0.22-7              tibble_3.3.0
##  [59] Biobase_2.70.0              withr_3.0.2
##  [61] S7_0.2.0                    evaluate_1.0.5
##  [63] BiocFileCache_3.0.0         Biostrings_2.78.0
##  [65] pillar_1.11.1               BiocManager_1.30.26
##  [67] filelock_1.0.3              MatrixGenerics_1.22.0
##  [69] stats4_4.5.1                generics_0.1.4
##  [71] grImport2_0.3-3             RCurl_1.98-1.17
##  [73] S4Vectors_0.48.0            ggplot2_4.0.0
##  [75] scales_1.4.0                gtools_3.9.5
##  [77] glue_1.8.0                  seqLogo_1.76.0
##  [79] tools_4.5.1                 TFMPvalue_0.0.9
##  [81] BiocIO_1.20.0               data.table_1.17.8
##  [83] BSgenome_1.78.0             GenomicAlignments_1.46.0
##  [85] XML_3.99-0.19               TFBSTools_1.48.0
##  [87] grid_4.5.1                  Cairo_1.7-0
##  [89] restfulr_0.0.16             cli_3.6.5
##  [91] rappdirs_0.3.3              S4Arrays_1.10.0
##  [93] dplyr_1.1.4                 gtable_0.3.6
##  [95] sass_0.4.10                 digest_0.6.37
##  [97] BiocGenerics_0.56.0         SparseArray_1.10.0
##  [99] rjson_0.2.23                htmlwidgets_1.6.4
## [101] farver_2.1.2                memoise_2.0.1
## [103] htmltools_0.5.8.1           lifecycle_1.0.4
## [105] httr_1.4.7                  bit64_4.6.0-1
## [107] MASS_7.3-65
```

Chan, Hock Peng, Nancy Ruonan Zhang, and Louis H. Y. Chen. 2010. “Importance sampling of word patterns in DNA and protein sequences.” *Journal of Computational Biology* 17 (12): 1697–1709. <https://doi.org/10.1089/cmb.2008.0233>.

Grant, Charles E., Timothy L. Bailey, and William Stafford Nobel. 2011. “FIMO: Scanning for occurrences of a given motif.” *Bioinformatics* 7: 1017–8. <https://doi.org/10.1093/bioinformatics/btr064>.

Hindorff, L. A., J. MacArthur J, J. Morales, H. A. Junkins, P. N. Hall, A. K. Klemm, and T. A. Manolio. 2009. “A Catalog of Published Genome-Wide Association Studies.” <http://www.genome.gov/gwastudies>.

Macintyre, Geoff, James Bailey, Izhak Haviv, and Adam Kowalczyk. 2010. “is-rSNP: a novel technique for in silico regulatory SNP detection.” *Bioinformatics* 26 (18): 524–30.

Zuo, Chandler, Sunyoung Shin, and Sunduz Keles. 2015. “AtSNP: Transcription Factor Binding Affinity Testing for Regulatory Snp Detection.” *Bioinformatics* 31 (20): 3353–5.