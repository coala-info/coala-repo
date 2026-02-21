# The cleanUpdTSeq user’s guide

Sarah Sheppard, Haibo Liu, Jianhong Ou, Nathan Lawson, Lihua J. Zhu

#### 29 October 2025

#### Abstract

This package implements a published Naive Bayes classifier for accurate identification of polyadenylation (pA) sites from oligo(dT)-based 3’ end sequencing such as PAS-Seq, PolyA-Seq and RNA-Seq. The classifer is highly accurate and outperforms other heuristic methods. Even though the classfier has been trained using Zebrafish data, it works well with other species as demonstrated in several organisms including the human, mouse, rat, dog and monkey.

#### Package

cleanUpdTSeq 1.48.0

# Contents

* [1 Introduction](#introduction)
* [2 Citation](#citation)
* [3 step-by-step guide](#step-by-step-guide)
  + [3.1 Step 1. Load the cleanUpdTSeq package, and then use the function BED6WithSeq2GRangesSeq to convert the test dataset in a extended BED6 file to a GRanges object with or without sequence information.](#step-1.-load-the-cleanupdtseq-package-and-then-use-the-function-bed6withseq2grangesseq-to-convert-the-test-dataset-in-a-extended-bed6-file-to-a-granges-object-with-or-without-sequence-information.)
  + [3.2 Step2. Build feature vectors for the classifier using the function buildFeatureVector.](#step2.-build-feature-vectors-for-the-classifier-using-the-function-buildfeaturevector.)
  + [3.3 Step 3. Load the training dataset and classify putative polyadenylation sites.](#step-3.-load-the-training-dataset-and-classify-putative-polyadenylation-sites.)
* [4 References](#references)
* **Appendix**
* [A Session Info](#session-info)

# 1 Introduction

3’ ends of transcripts have generally been poorly annotated. With the advent of deep sequencing, many methods have been developed to identify 3’ ends. The majority of these methods use an oligo-dT primer, which can bind to internal adenine-rich sequences, and lead to artifactual identification of polyadenylation sites. Heuristic filtering methods rely on a certain number of adenines in the genomic sequence downstream of a putative polyadenylation site to remove internal priming events. We introduce a package to provide a robust method to classify putative polyadenylation sites. cleanUpdTSeq uses a naïve Bayes classifier, implemented through the **e1071** [1], and sequence features surrounding the putative polyadenylation sites for classification.

The package includes a training dataset constructed from 6 different Zebrafish sequencing dataset, and functions for fetching surrounding sequences using BSgenome [2], building feature vectors and classifying whether the putative polyadenylations site is a true polyadenylation site or a mis-primed false site.

# 2 Citation

If you use cleanUpdTSeq, please cite:

> Sheppard, S., Lawson, N.D. and Zhu, L.J., 2013. Accurate identification of polyadenylation sites from 3’ end deep sequencing using a naive Bayes classifier. Bioinformatics, 29(20), pp.2564-2571 and 2014, 30(4), pp.596, <https://doi.org/10.1093/bioinformatics/btt714>

# 3 step-by-step guide

Here is a step-by-step guide on how to use the cleanUpdTSeq package to classify a list of putative polyadenylation sites

## 3.1 Step 1. Load the cleanUpdTSeq package, and then use the function BED6WithSeq2GRangesSeq to convert the test dataset in a extended BED6 file to a GRanges object with or without sequence information.

```
suppressPackageStartupMessages(library(cleanUpdTSeq))
testFile <- system.file("extdata", "test.bed",
                        package = "cleanUpdTSeq")
peaks <- BED6WithSeq2GRangesSeq(file = testFile,
                               skip = 1L, withSeq = FALSE)
```

If test dataset contains sequence information already, then use the following command instead.

```
peaks <- BED6WithSeq2GRangesSeq(file = testFile,
                                skip = 1L, withSeq = TRUE)
```

To work with your own test dataset, please set testFile to the file path that contains the putative pA site information.

Here is how the test dataset look like.

```
head(read.delim(testFile, header = TRUE, skip = 0))
```

```
##     chr    start     stop        name score strand
## 1 chr10  2965327  2965328 6hpas-22249     1      -
## 2 chr10  2966558  2966559 6hpas-22250     1      -
## 3 chr10  2974251  2974252 6hpas-22251     2      -
## 4 chr10  2978441  2978442 6hpas-22252     1      -
## 5 chr11 16772291 16772292 6hpas-33204     1      -
## 6 chr11 16777848 16777849 6hpas-33205     1      -
##                                   upstream                     downstream
## 1 TCTTCATCATGGTCATCTCGCACCAGAGAGTGTGCCAGGG CAGGAAGTTTTACCTGTCTGTCATTATCGT
## 2 ACCCTGGTGAGGGTATAGAGCTGGTCCAGTGTGCCACGGC AAAGAGGAAAACAGCATTGTTCCTCCTGGA
## 3 TGATTTGTTTGTAACTGATTTTATCTTTTAATAAAAAAGA AAAAAGAAAGTCAAGCCAAGAGGCAAATAC
## 4 GGAGCGCGACCGCATCAACAAAATCTTGCAGGATTATCAG AAGAAAAAGATGGTGAGTTATTATCATTCA
## 5 AGGGAAATAAATACAAAAGAATAAAAATATGATTCATTGT AAGAAAAACACTTTAGCTACAAAAGTCCTT
## 6 ATTTAGTTGGGTATTATTTCAAATAAAGAGAGAGAGAGAC ACAAAAACTACATCAAATTTGAGGACAAAA
```

## 3.2 Step2. Build feature vectors for the classifier using the function buildFeatureVector.

The zebrafish genome from BSgenome is used in this example for obtaining flanking sequences. For a list of other genomes available through BSgenome, please refer to the BSgenome package documentation [2].

```
suppressPackageStartupMessages(library(BSgenome.Drerio.UCSC.danRer7))
testSet.NaiveBayes <- buildFeatureVector(peaks,
                                         genome = Drerio,
                                         upstream = 40L,
                                         downstream = 30L,
                                         wordSize = 6L,
                                         alphabet = c("ACGT"),
                                         sampleType = "unknown",
                                         replaceNAdistance = 30,
                                         method = "NaiveBayes",
                                         fetchSeq = TRUE,
                                         return_sequences = TRUE)
```

If sequences are present in the test dataset already, then set fetchSeq = FALSE.

## 3.3 Step 3. Load the training dataset and classify putative polyadenylation sites.

The output file is a tab-delimited file containing the name of the putative
polyadenylation sites, the probability that the putative polyadenylation site is false/oligodT internally primed, the probability the putative polyadenylation site is true, the predicted class based on the assignment cutoff and the sequence surrounding the putative polyadenylation site.

```
data(data.NaiveBayes)
if(interactive()){
   out <- predictTestSet(data.NaiveBayes$Negative,
                         data.NaiveBayes$Positive,
                         testSet.NaiveBayes = testSet.NaiveBayes,
                         outputFile = file.path(tempdir(),
                                          "test-predNaiveBayes.tsv"),
                        assignmentCutoff = 0.5)
}
```

Alternatively, instead of passing in a positive and a negative training dataset, set the parameter classifier to a pre-built **PASclassifier** to speed up the process. To built a **PASclassifier** using the training dataset, please use function **buildClassifier**. A **PASclassifier** named as **classifier** is included in the package which is generated using the included training dataset with upstream = 40, downstream = 30, and wordSize = 6. Please note that in order to use this pre-built classier, you need to build feature vector using buildFeatureVector from your test dataset with the same setting, i.e., upstream = 40, downstream = 30, and wordSize = 6.

```
data(classifier)
testResults <- predictTestSet(testSet.NaiveBayes = testSet.NaiveBayes,
                              classifier = classifier,
                              outputFile = NULL,
                              assignmentCutoff = 0.5,
                              return_sequences = TRUE)
head(testResults)
```

```
##     peak_name prob_fake_pA prob_true_pA pred_class
## 1 6hpas-22249   0.99778351 2.216486e-03          0
## 2 6hpas-22250   1.00000000 6.699365e-10          0
## 3 6hpas-22251   0.99444054 5.559459e-03          0
## 4 6hpas-22252   0.99999995 4.729351e-08          0
## 5 6hpas-33204   0.02810869 9.718913e-01          1
## 6 6hpas-33205   0.99997144 2.855673e-05          0
##                               upstream_seq                 downstream_seq
## 1 TCTTCATCATGGTCATCTCGCACCAGAGAGTGTGCCAGGG CAGGAAGTTTTACCTGTCTGTCATTATCGT
## 2 ACCCTGGTGAGGGTATAGAGCTGGTCCAGTGTGCCACGGC AAAGAGGAAAACAGCATTGTTCCTCCTGGA
## 3 TGATTTGTTTGTAACTGATTTTATCTTTTAATAAAAAAGA AAAAAGAAAGTCAAGCCAAGAGGCAAATAC
## 4 GGAGCGCGACCGCATCAACAAAATCTTGCAGGATTATCAG AAGAAAAAGATGGTGAGTTATTATCATTCA
## 5 AGGGAAATAAATACAAAAGAATAAAAATATGATTCATTGT AAGAAAAACACTTTAGCTACAAAAGTCCTT
## 6 ATTTAGTTGGGTATTATTTCAAATAAAGAGAGAGAGAGAC ACAAAAACTACATCAAATTTGAGGACAAAA
```

# 4 References

# Appendix

1. Meyer, D., et al., e1071: Misc Functions of the Department of Statistics (e1071), TU Wien. 2012.
2. Pages, H., BSgenome: Infrastructure for Biostrings-based genome data packages.
3. Sheppard, S., Lawson, N.D. and Zhu, L.J., 2013. Accurate identification of polyadenylation sites from 3’ end deep sequencing using a naive Bayes classifier. Bioinformatics, 29(20), pp.2564-2571.

# A Session Info

```
sessionInfo()
```

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86\_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86\_64-linux-gnu/lapack/liblapack.so.3.12.0 LAPACK version 3.12.0

locale:
[1] LC\_CTYPE=en\_US.UTF-8 LC\_NUMERIC=C
[3] LC\_TIME=en\_GB LC\_COLLATE=C
[5] LC\_MONETARY=en\_US.UTF-8 LC\_MESSAGES=en\_US.UTF-8
[7] LC\_PAPER=en\_US.UTF-8 LC\_NAME=C
[9] LC\_ADDRESS=C LC\_TELEPHONE=C
[11] LC\_MEASUREMENT=en\_US.UTF-8 LC\_IDENTIFICATION=C

time zone: America/New\_York
tzcode source: system (glibc)

attached base packages:
[1] stats4 stats graphics grDevices utils datasets methods
[8] base

other attached packages:
[1] cleanUpdTSeq\_1.48.0 BSgenome.Drerio.UCSC.danRer7\_1.4.0
[3] BSgenome\_1.78.0 rtracklayer\_1.70.0
[5] BiocIO\_1.20.0 Biostrings\_2.78.0
[7] XVector\_0.50.0 GenomicRanges\_1.62.0
[9] Seqinfo\_1.0.0 IRanges\_2.44.0
[11] S4Vectors\_0.48.0 BiocGenerics\_0.56.0
[13] generics\_0.1.4 BiocStyle\_2.38.0

loaded via a namespace (and not attached):
[1] SummarizedExperiment\_1.40.0 rjson\_0.2.23
[3] xfun\_0.53 bslib\_0.9.0
[5] Biobase\_2.70.0 lattice\_0.22-7
[7] vctrs\_0.6.5 tools\_4.5.1
[9] bitops\_1.0-9 curl\_7.0.0
[11] parallel\_4.5.1 proxy\_0.4-27
[13] Matrix\_1.7-4 cigarillo\_1.0.0
[15] lifecycle\_1.0.4 compiler\_4.5.1
[17] stringr\_1.5.2 Rsamtools\_2.26.0
[19] codetools\_0.2-20 htmltools\_0.5.8.1
[21] class\_7.3-23 sass\_0.4.10
[23] RCurl\_1.98-1.17 yaml\_2.3.10
[25] crayon\_1.5.3 jquerylib\_0.1.4
[27] seqinr\_4.2-36 MASS\_7.3-65
[29] BiocParallel\_1.44.0 DelayedArray\_0.36.0
[31] cachem\_1.1.0 abind\_1.4-8
[33] digest\_0.6.37 stringi\_1.8.7
[35] restfulr\_0.0.16 bookdown\_0.45
[37] ade4\_1.7-23 fastmap\_1.2.0
[39] grid\_4.5.1 cli\_3.6.5
[41] SparseArray\_1.10.0 magrittr\_2.0.4
[43] S4Arrays\_1.10.0 XML\_3.99-0.19
[45] e1071\_1.7-16 rmarkdown\_2.30
[47] httr\_1.4.7 matrixStats\_1.5.0
[49] evaluate\_1.0.5 knitr\_1.50
[51] rlang\_1.1.6 Rcpp\_1.1.0
[53] glue\_1.8.0 BiocManager\_1.30.26
[55] jsonlite\_2.0.0 R6\_2.6.1
[57] MatrixGenerics\_1.22.0 GenomicAlignments\_1.46.0