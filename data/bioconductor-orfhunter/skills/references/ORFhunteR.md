# The ORFhunteR package: User’s manual

Vasily V. Grinev, Mikalai M. Yatskou, Victor V. Skakun, Maryna K. Chepeleva, Petr V. Nazarov

#### 2025-10-30

#### Abstract

The ORFhunteR package is R and C++ library for an automatic determination and annotation of open reading frames (ORFs) in a large set of RNA molecules. It efficiently implements the machine learning model based on vectorization of nucleotide sequences and the random forest classification algorithm. The ORFhunteR package consists of a set of functions written in the R language in conjunction with C++. The efficiency of the package was confirmed by the examples of the analysis of RNA molecules from the NCBI RefSeq and Ensembl databases. The package can be used in basic and applied biomedical research related to the study of the transcriptome of normal as well as pathological (for example, cancerous) human cells.

#### Package

ORFhunteR 1.18.0

# Contents

* [1 Installing and loading the package](#installing-and-loading-the-package)
* [2 Data availability](#data-availability)
* [3 Data loading](#data-loading)
* [4 Inferring of ORF candidates](#inferring-of-orf-candidates)
* [5 Automatic identification of true ORFs](#automatic-identification-of-true-orfs)
* [6 Extraction the sequences of identified ORFs](#extraction-the-sequences-of-identified-orfs)
* [7 Annotation of identified ORFs](#annotation-of-identified-orfs)
  + [7.1 Detection of premature termination codons (PTCs)](#detection-of-premature-termination-codons-ptcs)
  + [7.2 In silico translation of identified ORFs](#in-silico-translation-of-identified-orfs)
  + [7.3 Basic annotation of identified ORFs](#basic-annotation-of-identified-orfs)
* [8 Citation](#citation)
* [9 References](#references)
* **Appendix**

This document describes the usage of the functions integrated in the package and is meant to be a reference document for the end user.

The ORFhunteR package is considered stable and will undergo few changes from now on. Please, report potential bugs and incompatibilities to bioinformatics.rfct.bio.bsu@gmail.com.

The usage of the package functions for an automatic determination and annotation of open reading frames (ORFs) is shown for an example set of 50 mRNA molecules loaded from the Ensembl. The path to the data set `trans_sequences.fasta` is available as

```
trans  <- system.file("extdata", "Set.trans_sequences.fasta",
                      package = "ORFhunteR")
```

# 1 Installing and loading the package

Load the package with the following command:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("ORFhunteR")
```

```
library('ORFhunteR')
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
#> Loading required package: rtracklayer
#> Loading required package: GenomicRanges
#> Loading required package: Peptides
#> Warning: replacing previous import 'stringr::str_wrap' by 'xfun::str_wrap' when
#> loading 'ORFhunteR'
```

# 2 Data availability

The most important data sets are available with package as an external data. Furthermore, a number of additional data used in this vignette can be downloaded from our SST Center server.

# 3 Data loading

You can load the data file of the mRNA molecules with the following command:

```
seq.set <- loadTrExper(tr = trans)
```

where the function argument `tr` is a character string giving the name of file with transcripts of interest. Allowed file formats are `fasta` or `fa`. Alternative formats are `gtf` or `gff`. With `gtf` or `gff` formats, additional argument genome should be specified. This argument gives the name of pre-installed BSgenome data package with full genome sequences. Default value is `BSgenome.Hsapiens.UCSC.hg38`.
Irrespective used format of input file, the function `loadTrExper` returns a list of loaded transcript sequences. Each element of this list is character string of nucleotides sequence.

# 4 Inferring of ORF candidates

All possible in-frame ORF candidates in a sequence of interest can be determined by function `findORFs`:

```
x <- "AAAATGGCTGCGTAATGCAAAATGGCTGCGAATGCAAAATGGCTGCGAATGCCGGCACGTTGCTACGT"
orf <- findORFs(x, codStart="ATG")
```

where the function argument `x` is a character string giving the nucleotide sequence of interest. In current implementation, the function `findORFs` scans the sequence for all sub-sequences that start with ATG start codon and end in-frame with a stop codon.
The function findORFs returns a matrix with start and stop positions in RNA molecule, length and sequence of identified variants of ORFs. In fact, the predominant amount of identified ORF candidates are short pseudo-ORFs (see below), as demonstrated in Figure 1.
![](data:image/jpeg;base64...)
Figure 1. Distribution of the length of ORF candidates from lncRNAs and mRNAs and length of true ORFs derived from NCBI RefSeq annotations of human genes. This figure is based on NCBI RefSeq release 109 (GRCh38.p12 human genome assembly).

#Vectorization of the sequence features of ORFs
The function `vectorizeORFs` extracts and vectorizes the sequences features of ORFs:

```
feats <- vectorizeORFs(x=DNAStringSet(x="ATGGGCCTCA"))
```

where the function argument `x` is a DNAStringSet object with ORF sequence.
For each ORF, the function `vectorizeORFs` calculates 104 sequence features: frequency of mono-, di- and trinucleotides (84 features in total), parameters of the Bao model representing the local frequency entropy values of sequences (12 features in total) (Bao J. et al., 2014), correlation factors of nucleotides and length of ORF (8 features in total). As was shown in numerous studies, these features are informative for classification of coding and non-coding RNA molecules. This function returns the object of class data.frame with ORF vectorized into sequence features.

#Calculation of the classification model

The function `classifyORFsCandidates` builds a randomForest classifier for the ORF candidates:

```
## The files with sequences can be downloaded from SST Center server at www.sstcenter.com/download/ORFhunteR

fileORFLncRNAs <- "http://www.sstcenter.com/download/ORFhunteR/NCBI_RefSeq_release_109_GRCh38.p12_ORF_candidates_sequences_lncRNAs.fasta.gz"
ORFLncRNAs <- loadTrExper(tr = fileORFLncRNAs)
fileORFmRNAs <- "http://www.sstcenter.com/download/ORFhunteR/NCBI_RefSeq_release_109_GRCh38.p12_ORFs_true_sequences_mRNAs.fasta.gz"
ORFmRNAs <- loadTrExper(tr = fileORFmRNAs)
## Make the train dataset from N pseudo- and N real ORFs.
N <- 1000
ORFLncRNAs <- ORFLncRNAs[1:N]
ORFmRNAs <- ORFmRNAs[1:N]
## Calculate the classification model for the open reading frame.
clt <- classifyORFsCandidates(ORFLncRNAs = ORFLncRNAs,
                              ORFmRNAs = ORFmRNAs,
                              pLearn = 0.75,
                              nTrees = 500,
                              modelRF = NULL,
                              workDir = NULL,
                              showAccuracy = TRUE)
```

where the function argument `ORFLncRNAs` is the object of the class list of pseudo-ORFs, `ORFmRNAs` is the object of the class list of coding true ORFs, `pLearn` is a threshold, in fractions of one, for random selecting the train set of ORFs (the rest amount, or 1-pLearn, is thus left for the test set of ORFs; default value is 0.75), `nTrees` is a number of trees to grow (this should not be set to too small a number, to ensure that every input row gets predicted at least a few times; default value is 500), `modelRF` is character string, giving the name of RDS-file to store the classification model (NULL is by default), and `workDir` is character string giving the path to and the name of the work directory (NULL is by default that means the current working directory). Here and below, pseudo-ORFs are nucleotide sequences of long non-coding RNA molecules that beginning with ATG start codon and ending in-frame with one of the stop codons, but these sequences are not translated into proteins. We also use this term for non-coding mRNA-derived nucleotide sequences (usually short) with features of ORFs.

The function `classifyORFsCandidates` returns an object of class randomForest (Liaw A. et al., 2002) that can be used for subsequent automatic determination of ORFs in experimental RNA molecules of interest. In addition, the function automatically saves the RDS file of the classification model `modelRF` into the directory `workDir` and generates:
i) the randomForest type plots: the sorted variable importance, the error rates, and the dotchart of variable importance as measured by a classification model;
ii) the evaluation estimates of the classification model on the train and test datasets: the confusion matrix and the measures of Accuracy, Precision, Recall, and the Score F1, calculated as

Accuracy \[Accuracy = \frac{TP + TN}{TP + TN + FP + FN}\]
Precision \[Precision = \frac{TP}{TP + FP}\]
Recall \[Recall = \frac{TP}{TP + FN}\]
The Score F1 \[The Score F1 = \frac{2 \* TP}{2 \* TP + FP + FN}\]

where TP – true positive (the positive class is predicted as the positive class number); FN – false negative (the positive class is predicted as the negative class number); FP – false positive (the negative class is predicted as the positive class number); TN – true negative (the negative class is predicted as the negative class number).

# 5 Automatic identification of true ORFs

With calculated classification model, identification of the true ORFs among ORF candidates extracted from RNA molecules of interest can be done using function `predictORF`:

```
model <- "http://www.sstcenter.com/download/ORFhunteR/classRFmodel_1.rds"
ORFs <- predictORF(tr = trans,
                   model= model,
                   prThr = 0)
```

where the function argument `tr` is a character string giving the name of file with transcripts of interest, `model` is a character string giving the connection or full path to the file from which the classification model is read, and argument `prThr` is probability threshold for the “winning” class of ORFs (default value is 0). Allowed file formats for transcripts of interest are `fasta` or `fa`. Alternative formats are `gtf` or `gff`. With `gtf` or `gff` formats, additional argument `genome` should be specified. This argument gives the name of pre-installed BSgenome data package with full genome sequences. Default value is “BSgenome.Hsapiens.UCSC.hg38”.
The function `predictORF` returns an object of class data.frame with five fields:

```
head(ORFs)
#>     transcript_id start  end length  prob
#> 1 ENST00000235453   279 1469   1191 1.000
#> 2 ENST00000246505    36 1397   1362 1.000
#> 3 ENST00000258105    21  359    339 0.948
#> 4 ENST00000278833   542 1597   1056 1.000
#> 5 ENST00000285021   216 3038   2823 1.000
#> 6 ENST00000302797   219 1187    969 1.000
```

The function `predictORF`selects only one ORF candidate per RNA molecule that was assigned with maximal value of `prob` field. In fact, 91.9% of ORFs that were identified in mRNA molecules (Ensembl release 97, GRCh38.p12 human reference genome assembly) demonstrates probability 0.9 (Figure 2).
![](data:image/jpeg;base64...)
Figure 2. Empirical cumulative distribution (a) and frequency (b) of probability values for ORFs that were identified in Ensembl human mRNA molecules.
At the same time, distribution of probability values for ORF candidates from long non-coding RNA molecules is completely differ (Figure 3). This difference between two classes of RNA molecules makes it possible to set a probability threshold prThr that discriminates pseudo- and true ORFs.
![](data:image/jpeg;base64...)
Figure 3. Boxplot demonstrating the distribution of probability values for ORFs that were identified in human mRNAs and lncRNAs (Ensembl release 97, GRCh38.p12 human reference genome assembly).

# 6 Extraction the sequences of identified ORFs

The sequences of identified can be extracted with function `getSeqORFs`:

```
orfs_path <- system.file("extdata",
                         "Set.trans_ORFs.coordinates.txt",
                         package="ORFhunteR")
tr_path <- system.file("extdata",
                       "Set.trans_sequences.fasta",
                       package="ORFhunteR")
seq_orfs <- getSeqORFs(orfs = orfs_path,
                       tr = tr_path,
                      genome="BSgenome.Hsapiens.UCSC.hg38",
                       workDir=NULL)
```

This function needs the name of tab-delimited TXT file with coordinates of ORFs (as generated by function `predictORF`) and the name of file with transcripts of interest. The last file must include the transcripts for which the ORFs were identified and listed in above file with coordinates of ORFs. Allowed file formats for transcripts of interest are `fasta` or `fa`. Alternative formats are `gtf` or `gff`. With `gtf` or `gff` formats, additional argument `genome` should be specified. This argument gives the name of pre-installed BSgenome data package with full genome sequences. Default value is `BSgenome.Hsapiens.UCSC.hg38`.
The output of function `getSeqORFs` is a DNAStringSet object with sequences of ORFs:

```
head(seq_orfs)
#> DNAStringSet object of length 6:
#>     width seq                                               names
#> [1]  1191 ATGGCGGCAGCTCCACGGGAGGA...ATGATTATCCATTTTCTCAATAA ENST00000235453
#> [2]  1362 ATGGCGCACATTACCATTAACCA...CTCCCCTGTCCACGGTGTGTTGA ENST00000246505
#> [3]   339 ATGGCAGCTGCCTTGGCTCGGCT...CGGGCGCTGATACTGGTCGCTGA ENST00000258105
#> [4]  1056 ATGGCGCCGGTGTTGCCCCTGGT...AGGAGGATCTATCTGAGGCCTAG ENST00000278833
#> [5]  2823 ATGGCTCGGAAACGCGCGGCCGG...TGTTCCCATTTGAGCAGCTGTGA ENST00000285021
#> [6]   969 ATGGATCCAACCATCTCAACCTT...CGGGAAGCAGATTGGAGCAGTGA ENST00000302797
```

# 7 Annotation of identified ORFs

## 7.1 Detection of premature termination codons (PTCs)

With identified ORFs, the PTCs can be inferred using function `findPTCs`:

```
orfs_path <- system.file("extdata",
                         "Set.trans_ORFs.coordinates.txt",
                         package="ORFhunteR")
gtf_path <- system.file("extdata",
                        "Set.trans_sequences.gtf",
                        package="ORFhunteR")
ptcs <- findPTCs(orfs = orfs_path,
                 gtf = gtf_path,
                 workDir = NULL)
```

This function needs the name of tab-delimited TXT file with coordinates of ORFs (as generated by function `predictORF`) and the name of file with structure of transcripts in format `gtf` or `gff`. The output of function `findPTCs` is an object of class data.frame with field `stop.status`:

```
head(ptcs)
#>     transcript_id start  end length  prob stop.status
#> 1 ENST00000235453   279 1469   1191 1.000      mature
#> 2 ENST00000246505    36 1397   1362 1.000      mature
#> 3 ENST00000258105    21  359    339 0.904   premature
#> 4 ENST00000278833   542 1597   1056 1.000      mature
#> 5 ENST00000285021   216 3038   2823 1.000      mature
#> 6 ENST00000302797   219 1187    969 1.000      mature
```

## 7.2 In silico translation of identified ORFs

In silico translation of identified ORFs can be done with function `translateORFs`:

```
seq_orf_path <- system.file("extdata",
                            "Set.trans_ORFs.sequences.fasta",
                            package="ORFhunteR")
prot_seqs <- translateORFs(seqORFs=seq_orf_path)
```

This function accepts `fasta` (or `fa`) file with sequences of identified ORFs (as generated by function `getSeqORFs`) and translates these sequences into strings of amino acids according to standard genetic code. The output of function `translateORFs` is an AAStringSet object with amino acid sequences:

```
head(prot_seqs)
#> AAStringSet object of length 6:
#>     width seq                                               names
#> [1]   396 MAAAPREEKRWPQPVFSNPVVLW...EEITSGGFCGGKDKLQYDYPFSQ ENST00000235453
#> [2]   453 MAHITINQYLQQVYEAIDSRDGA...ISHQHQKLVVSKQNPFPPLSTVC ENST00000246505
#> [3]   112 MAAALARLGLRPVKQVRVQFCPF...FASHIRARDAAGSGDKPGADTGR ENST00000258105
#> [4]   351 MAPVLPLVLPLQPRIRLAQGLWL...ACRPAPEEAPPGEAPPKEDLSEA ENST00000278833
#> [5]   940 MARKRAAGGEPRGRELRSQKSKA...GGPKKTKREKKAAASHLFPFEQL ENST00000285021
#> [6]   322 MDPTISTLDTELTPINGTEETLC...EVDEGGGQLPEEILELSGSRLEQ ENST00000302797
```

If necessary, the coding of amino acid symbols can be switched from one-letter to three-letter using argument `aaSymbol` of function.

## 7.3 Basic annotation of identified ORFs

The package ORFhunteR includes function `annotateORFs` for basic annotation of identified ORFs. This function works according to following syntax:

```
orfs_path <- system.file("extdata",
                         "Set.trans_ORFs.coordinates.txt",
                         package="ORFhunteR")
tr_path <- system.file("extdata",
                       "Set.trans_sequences.fasta",
                       package="ORFhunteR")
gtf_path <- system.file("extdata",
                        "Set.trans_sequences.gtf",
                        package="ORFhunteR")
prts_path <- system.file("extdata",
                         "Set.trans_proteins.sequences.fasta",
                         package="ORFhunteR")
anno_orfs <- annotateORFs(orfs = orfs_path,
                          tr = tr_path,
                          gtf = gtf_path,
                          prts = prts_path,
                          workDir = NULL)
```

The function `annotateORFs` needs five arguments. The argument `orfs` is the name of tab-delimited TXT file with coordinates of ORFs (as generated by function predictORF). The argument `tr` is a character string giving the name of file with transcripts of interest. This file must include the transcripts for which the ORFs were identified and listed in above file with coordinates of ORFs. Allowed file formats for transcripts of interest are `fasta` or `fa`. The argument `gtf` is the name of file with structure of transcripts in format `gtf` or `gff.` The argument `prts` is a character string giving the name of `fasta` file with sequences of in silico translated proteins encoded by identified ORFs (as generated by function `translateORFs`). The last argument `workDir` is a character string giving the path to and name of work directory (NULL by default that mean the current working directory).
The function `annotateORFs` returns an object of class data.frame. This object includes information on each analysed transcript: transcript ID, length of 5’UTRs, type of start codon, start coordinate of ORF, stop coordinate of ORF, type of stop codon, PTC status of stop codon, length of ORF, length of 3’UTRs, molecular weight of in silico translated protein, isoelectic point of a protein sequence and potential protein interaction index.

```
head(anno_orfs)
#>     transcript_id f_utr.length start.codon orf.start orf.stop stop.codon
#> 1 ENST00000235453          278         ATG       279     1469        TAA
#> 2 ENST00000246505           35         ATG        36     1397        TGA
#> 3 ENST00000258105           20         ATG        21      359        TGA
#> 4 ENST00000278833          541         ATG       542     1597        TAG
#> 5 ENST00000285021          215         ATG       216     3038        TGA
#> 6 ENST00000302797          218         ATG       219     1187        TGA
#>   stop.status orf.length t_utr.length     MW   pI indexPPI
#> 1      mature       1191          726  44.90 6.59     1.25
#> 2      mature       1362          389  52.10 8.61     1.19
#> 3   premature        339          137  12.11 8.98     1.96
#> 4      mature       1056          281  37.21 5.97     0.46
#> 5      mature       2823          794 105.95 9.30     2.60
#> 6      mature        969            3  36.25 7.57     0.13
```

# 8 Citation

If you use the ORFhunteR package for a scientific work, then please cite (Yatskou M. M. et al., 2019) and (Skakun V. V. et al., 2020).

# 9 References

# Appendix

Bao J., Yuan R., Bao Z. An improved alignment-free model for DNA sequence similarity metric. // BMC Bioinformatics. – 2014. – Vol. 15. – P. 321. doi: 10.1186/1471-2105-15-321

Liaw A., Wiener M. Classification and regression by randomForest. // R News. – 2002. – Vol. 2. – P. 18-22.

ORFhunteR: an accurate approach for the automatic identification and annotation of open reading frames in human mRNA molecules. Vasily V. Grinev, Mikalai M. Yatskou, Victor V. Skakun, Maryna K. Chepeleva, Petr V. Nazarov. bioRxiv 2021.02.05.429963; doi: <https://doi.org/10.1101/2021.02.05.429963>

Skakun V. V., Yatskou M. M., Nazarov P. V., Grinev V. V. ORFhunteR software package for automatic detection of open reading frames in human RNA molecules. // Computer Technology and Data Analysis (CTDA’2020): materials of the II International Scientific and Practical Conference, Minsk, 23-24 April 2020 / Editorial board: Skakun V. V. (editor-in-chief) [and others]. – Minsk: BSU, 2020. pp. 20-24.

Yatskou M. M., Skakun V. V., Grinev V. V. Development of a computational approach for automatic determination of open reading frames in human RNA molecules. // Quantum electronics: materials of the XII International Scientific and Technical Conference, Minsk, 18-22 November 2019 / Editorial board: Kugeiko M. M. [and others]. – Minsk: RIVSH, 2019. pp. 279-281.