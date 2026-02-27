# Introduction to HPiP

Matineh Rahmatbakhsh1\*

1Babu Lab, University of Regina, Regina, Saskatchwan

\*mmr668@uregina.ca

#### 22 February 2026

#### Package

HPiP 1.16.1

# Contents

* [1 Introduction](#introduction)
* [2 Overview of HPiP](#overview-of-hpip)
* [3 An Example of Predicting HP-PPIs](#an-example-of-predicting-hp-ppis)
  + [3.1 Data Set Preparation](#data-set-preparation)
    - [3.1.1 Gold Standard Reference Dataset of Host-Pathogen PPIs](#gold-standard-reference-dataset-of-host-pathogen-ppis)
    - [3.1.2 FASTA Sequence extraction](#fasta-sequence-extraction)
  + [3.2 Sequence-based Features Extraction](#sequence-based-features-extraction)
    - [3.2.1 Amino acid Composition (AAC) Descriptor](#amino-acid-composition-aac-descriptor)
    - [3.2.2 Dipeptide Composition (DC) Descriptor](#dipeptide-composition-dc-descriptor)
    - [3.2.3 Tripeptide Composition (TC) Descriptor](#tripeptide-composition-tc-descriptor)
    - [3.2.4 Tripeptide Composition (TC) from Biochemical Similarity Classes Descriptor](#tripeptide-composition-tc-from-biochemical-similarity-classes-descriptor)
    - [3.2.5 Quadruplets Composition from Biochemical Similarity Classes Descriptor](#quadruplets-composition-from-biochemical-similarity-classes-descriptor)
    - [3.2.6 F1/F2 Composition Descriptor](#f1f2-composition-descriptor)
    - [3.2.7 Composition/Transition/Distribution (CTD) Descriptors](#compositiontransitiondistribution-ctd-descriptors)
    - [3.2.8 Conjoint Triad Descriptor](#conjoint-triad-descriptor)
    - [3.2.9 Autocorrelation (Auto) Descriptors](#autocorrelation-auto-descriptors)
    - [3.2.10 k-Spaced Amino Acid Pairs](#k-spaced-amino-acid-pairs)
    - [3.2.11 Binary encoding](#binary-encoding)
    - [3.2.12 BString Object as Data Input](#bstring-object-as-data-input)
    - [3.2.13 Generate a SummarizedExperiment Objects](#generate-a-summarizedexperiment-objects)
    - [3.2.14 Table of Summary Descriptors](#table-of-summary-descriptors)
  + [3.3 Combine Host-Pathogen Interaction Descriptors](#combine-host-pathogen-interaction-descriptors)
  + [3.4 Data Processing](#data-processing)
  + [3.5 Prediction Algorithm](#prediction-algorithm)
  + [3.6 Nework Visualization](#nework-visualization)
  + [3.7 GO Enrichment Analysis](#go-enrichment-analysis)
  + [3.8 Complex Prediction](#complex-prediction)
* [4 Session info](#session-info)
* [5 References](#references)
* **Appendix**

# 1 Introduction

Infectious disease imposes a significant threat to human health and pose
substantial healthcare costs. Infectious diseases result from the cross-talks
between hosts and pathogens, which are mainly mediated by protein-protein
interactions between hosts and pathogen proteins (HP-PPIs). The potential
(HP-PPIs) represents the crucial elements of the infection mechanism as they
decide the outcome, leading to either pathogen clearance or spread of the
pathogen in the host due to evading the host immune response
(Rahmatbakhsh *et al.*, [2021](#ref-rahmatbakhsh2021bioinformatic)). Therefore, the study of the host-pathogen
interactome is increasingly vital to uncover the molecular attributes of
infectious diseases and potentially discover novel pharmacological targets or
laying a strong foundation for repurposing of existing drugs.

In the past decades, several high throughput experimental approaches have been
developed to chart HP-PPIs on a large scale (e.g., yeast two-hybrid (Y2H)
system (Ito *et al.*, [2001](#ref-ito2001comprehensive)) or affinity purification (AP) coupled to mass
spectrometry (MS) (Puig *et al.*, [2001](#ref-puig2001tandem))). However, such high-throughput experimental
screens are typically laborious, time-consuming, and challenging to capture the
complete interactome, resulting in limited number of experimentally validated
interactome in a database of HP-PPIs (Hart *et al.*, [2006](#ref-hart2006complete)). In-silico prediction
of HP-PPIs can complement wet-lab experiments by suggesting candidate
interaction partners for all the host proteins and excluding partners with low
interacting probability scores to reduce the range of possible PPI candidates
that need to be validated via wet-lab experiments. Specialized computational
approaches to predict HP-PPIs are therefore of significant importance.
While many computational tools have been developed to predict intra-species
PPIs (i.e., PPIs within the same species)
(Wu *et al.*, [2006](#ref-wu2006prediction); Shen *et al.*, [2007](#ref-shen2007predicting); Nourani *et al.*, [2015](#ref-nourani2015computational)),
the availability of computational tools to predict inter-species PPIs
such as HP-PPIs are rare.

For this purpose, we describe HPiP (host-pathogen interaction prediction),
an R package for automated prediction of HP-PPIs using structural and
physicochemical descriptors computed from amino acid-composition of host and
pathogen proteins. Briefly, HPiP extracts gold-standard of experimentally
verified HP-PPIs (i.e., positive interactions) from public repository,
construct negative interactions via negative sampling, retrieve and convert
protein sequences to numerical representation via various descriptors, applies
multivariate feature selection based on correlation and recursive feature
elimination (RFE)-embedded, and finally applies ensemble averaging to predict
interactions. Taken together, we hope that the HPiP package not only
contributes a useful predictor to accelerate the exploration of host-pathogen
PPIs, but also provides some meaningful insights into host-pathogen
relationships.

# 2 Overview of HPiP

Briefly, HPiP downloads the gold-standard data sets of experimentally verified
host-pathogen PPIs from the BioGRID database (Stark *et al.*, [2006](#ref-stark2006biogrid)).
Such interactions serve as a positive set. In the absence of ground truth
negative examples, HPiP uses negative sampling to construct a negative set.
Following the construction of gold-standard data, HPiP retrieves the FASTA
sequences of associated proteins. HPiP then represents protein sequences into
a fixed-length feature vector using a series of structural and physicochemical
descriptors. Host-pathogen feature vectors and the accompanying gold standard
reference set also called the training set, are fed into the hybrid
filter-wrapper feature selection method to select the most relevant features
in inferring the target variable. In the following step, HPiP uses a training
set to train a series of individual machine learning models (base learners)
provided in the caret package (Kuhn *et al.*, [2020](#ref-kuhn2020package)). For each applied model,
hyperparameters are tweaked throughout training via resampling techniques
(e.g., k-fold cross-validation), and the best set of hyperparameters are
selected based on the accuracy performance measure. The optimized models
will then be applied to host-pathogen feature vectors with an unknown class
label to return a classification result for each pair. The HPiP then uses
ensemble averaging to average classification results over an ensemble of
classifiers for each possible interaction. Finally, HPiP compares the
algorithmic performance of the ensemble model with individual base learners
through resampling technique (e.g., k-fold cross-validation) and various
performance metrics (e.g., accuracy).

# 3 An Example of Predicting HP-PPIs

In the following sections, we explain the main components of the HPiP package,
including dataset preparation (i.e., construction of the gold-standard set,
FASTA sequence retrieval), feature extraction, data processing steps (i.e.,
imputation of missing values, feature selection), ensemble model generation
and evaluation, prediction of HP-PPIs, network visualization and external
validation of the predicted network using functional enrichment analysis.
Furthermore, we guide users through each step by applying the HPiP to
sample data derived from public databases.

## 3.1 Data Set Preparation

### 3.1.1 Gold Standard Reference Dataset of Host-Pathogen PPIs

In this tutorial, we use the data provided by Samavarchi-Tehrani *et al.* ([2020](#ref-samavarchi2020sars)) as our
benchmark dataset. In this study, the authors mapped interaction between 27
SARS-CoV-2 and host proteins via the proximity-dependent biotinylation (BioID)
approach. We then randomly selected 500 SARS-CoV-2-host interaction pairs from
all pairs as the positive samples. Since ground truth negatives are not
available, here negative examples are generated from the positive set using
negative sampling (Eid *et al.*, [2016](#ref-eid2016denovo)). In this approach, negative instances are
sampled from all the possible pairwise combinations of host and viral proteins,
as long as the possible pairs do not occur in the positive reference set.
To prevent statistical differences, the same scale is assumed for the negative
and positive instances (i.e., the ratio of positive to negative 1:1)
(Zhou *et al.*, [2018](#ref-zhou2018generalized)). The `gold-reference` data set can be loaded with the
following command:

```
# Loading packages required for data handling & data manipulation
library(dplyr)
library(tibble)
library(stringr)
# Loading HPiP package
library(HPiP)
```

```
##
## Attaching package: 'HPiP'
```

```
## The following object is masked from 'package:generics':
##
##     var_imp
```

```
# Loading data
data(Gold_ReferenceSet)
dim(Gold_ReferenceSet)
```

```
## [1] 1000    6
```

As stated by `dim()` the gold reference set includes 1000 HP-PPIs interaction
between 27 SARS-CoV-2 and 784 host proteins.

In addition, users can use `get_positivePPI` in the HPiP package to construct
`positive set` from the BioGRID database (Stark *et al.*, [2006](#ref-stark2006biogrid)).

This function takes the following parameters:

* `organism.taxID` Taxonomy identifier for the pathogen.
* `access.key` Access key for using BioGRID webpage. To retrieve interactions
  from the BioGRID database, the users are first required to register for
  [access key](https://webservice.thebiogrid.org/).
* `filename` A character string, indicating the output filename as an RData
  object to store the retrieved interactions.
* `path` A character string indicating the path to the project directory
  that contains the interaction data. If the directory is missing, it will
  be stored in the current directory.

```
local = tempdir()
#Get positive interactions from BioGrid
TP <- get_positivePPI(organism.taxID = 2697049,
                      access.key = 'XXXX',
                            filename = "PositiveInt.RData",
                            path = local)
```

Subsequently, we can construct negative set via negative sampling using the
following command:

```
#pathogen proteins
prot1 <- unique(TP$`Official Symbol Interactor A`)
#host proteins
prot2 <- unique(TP$`Official Symbol Interactor B`)
#true positive PPIs
TPset <- TP$PPI
TN <- get_negativePPI(prot1 , prot2, TPset)
dim(TN)
```

```
## [1] 2600    1
```

### 3.1.2 FASTA Sequence extraction

To compute different features from protein sequences, we must first extract
their sequences (in FASTA format). The `getFASTA` function in the HPiP package
can retrieve the sequences for any organism from the UniProt database.

```
local = tempdir()
#retrieve FASTA sequences of SARS-CoV-2 virus
id = unique(Gold_ReferenceSet$Pathogen_Protein)
fasta_list <- getFASTA(id, filename = 'FASTA.RData', path = local)
```

## 3.2 Sequence-based Features Extraction

To apply a learning algorithm on a host or pathogen protein sequence, it is
needed to encode sequence information as numerical features. However, one of
the critical challenges in inferring protein-protein interactions from the
protein sequences is finding an appropriate way to encode protein sequences’
important information fully. Also, the amino-acid sequences of different lengths
should be converted to fixed-length feature vectors, which is crucial in
classifying training data using machine-learning techniques as such techniques
require fixed-length patterns. The HPiP offers multiple functions for
generating various numerical features from protein sequences.

These feature coding schemes listed in HPiP include amino acid composition (AAC)
, dipeptide composition (DC), tripeptide composition (TC),
tripeptide composition (TC) from biochemical similarity classes, quadruplets
composition (QC), F1, F2, CTD (composition/transition/distribution),
conjoint triad, autocorrelation, *k*-spaced amino acid pairs, and binary
encoding.

### 3.2.1 Amino acid Composition (AAC) Descriptor

The amino acid composition (AAC) has low complexity and has been widely
used to predict protein-protein interactions (PPIs)
(Beltran *et al.*, [2019](#ref-beltran2019predicting); Dey *et al.*, [2020](#ref-dey2020machine)).The AAC explains the fraction of a
type of amino acid found within a protein sequence (Dey *et al.*, [2020](#ref-dey2020machine)). This
gives 20-dimensional feature vectors. For example, the fraction of all 20
natural amino acids is computed as follow:

\[
f\_{(i)}=\frac{n\_i}{L} \text{ }\ (i = 1,2,3,....,20)
\]

where *n*i is the number of amino acid type and *L* is the sequence length.
The ACC descriptor from the protein sequences can be loaded
with the following command:

```
# Convert the list of sequences obtained in the previous section to data.frame
fasta_df <- do.call(rbind, fasta_list)
fasta_df <- data.frame(UniprotID = row.names(fasta_df),
                       sequence = as.character(fasta_df))

#calculate AAC
acc_df <- calculateAAC(fasta_df)
#only print out the result for the first row
acc_df[1,-1]
```

```
##           A           C           D           E           F           G
## 0.062058130 0.031421838 0.048703849 0.037706206 0.060487038 0.064414768
##           H           I           K           L           M           N
## 0.013354281 0.059701493 0.047918303 0.084838963 0.010997643 0.069128044
##           P           Q           R           S           T           V
## 0.045561665 0.048703849 0.032992930 0.077769049 0.076197958 0.076197958
##           W           Y
## 0.009426551 0.042419482
```

### 3.2.2 Dipeptide Composition (DC) Descriptor

The dipeptide composition (DC) is simply the fraction of the different adjacent
pairs of amino acids within a protein sequence (Bhasin and Raghava, [2004](#ref-bhasin2004classification)).
Also, this descriptor encapsulates the properties of neighboring amino acids.
Dipeptide composition converts a protein sequence to a vector of 400 dimensions.
The composition of all 400 natural amino acids can be calculated using the
following equation:

\[
f\_{(m,k)}=\frac{n\_{m,k}}{L-1} \text{ }\ (m,k = 1,2,3,....,20)
\]

where *n*m,k corresponds to the number of dipeptide compositions characterized
by amino acid type *m* and type *k*, while *L* is the sequence length.The DC
descriptor from the protein sequences can be loaded with the following command:

```
# using data.frame provided by getFASTA function as data input
dc_df <- calculateDC(fasta_df)
#only print out the first 30 elements for the first row
dc_df[1, c(2:31)]
```

```
##           AA           AC           AD           AE           AF           AG
## 0.0047169811 0.0000000000 0.0047169811 0.0031446541 0.0000000000 0.0062893082
##           AH           AI           AK           AL           AM           AN
## 0.0007861635 0.0055031447 0.0007861635 0.0062893082 0.0007861635 0.0023584906
##           AP           AQ           AR           AS           AT           AV
## 0.0031446541 0.0039308176 0.0015723270 0.0062893082 0.0031446541 0.0031446541
##           AW           AY           CA           CC           CD           CE
## 0.0015723270 0.0039308176 0.0023584906 0.0031446541 0.0015723270 0.0007861635
##           CF           CG           CH           CI           CK           CL
## 0.0007861635 0.0031446541 0.0007861635 0.0000000000 0.0007861635 0.0023584906
```

### 3.2.3 Tripeptide Composition (TC) Descriptor

The tripeptide composition explains the occurrence of adjacent triune residues
in a protein sequence (Liao *et al.*, [2011](#ref-liao2011predicting)). Tripeptide composition converts a
protein sequence to a vector of 8,000 dimensions. The composition of all
8,000-dimensional descriptor can be calculated using the following equation:
\[
f\_{(m,k,j)}=\frac{n\_{m,k,j}}{L-2} \text{ }\ (m,k,j = 1,2,3,....,20)
\]
where *n*m,k,j corresponds to the number of tripeptide compositions
characterized by amino acid type *m*, *k* and *j*, while *L* is the sequence
length.The TC descriptor from the protein sequences can be loaded with
the following command:

```
# using data.frame provided by getFASTA function as data input
tc_df <- calculateTC(fasta_df)
#only print out the first 30 elements for the first row
tc_df[1, c(2:31)]
```

```
##          AAA          AAC          AAD          AAE          AAF          AAG
## 0.0007867821 0.0000000000 0.0000000000 0.0007867821 0.0000000000 0.0000000000
##          AAH          AAI          AAK          AAL          AAM          AAN
## 0.0000000000 0.0000000000 0.0000000000 0.0007867821 0.0000000000 0.0000000000
##          AAP          AAQ          AAR          AAS          AAT          AAV
## 0.0000000000 0.0000000000 0.0007867821 0.0000000000 0.0007867821 0.0000000000
##          AAW          AAY          ACA          ACC          ACD          ACE
## 0.0000000000 0.0007867821 0.0000000000 0.0000000000 0.0000000000 0.0000000000
##          ACF          ACG          ACH          ACI          ACK          ACL
## 0.0000000000 0.0000000000 0.0000000000 0.0000000000 0.0000000000 0.0000000000
```

### 3.2.4 Tripeptide Composition (TC) from Biochemical Similarity Classes Descriptor

In order to reduce the dimension of length-8,000 TC descriptor, the sequence
alphabet is reduced from 20 amino acids to six classes based on biochemical
similarity. The classes are [{IVLM}, {FYW}, {HKR}, {DE}, {QNTP}, and {ACGS}
(Ahmed *et al.*, [2018](#ref-ahmed2018prediction))]. This classification of amino acids converts a protein
sequence to a vector of 216 (i.e., 6 \* 6 \* 6) different combinations of possible
substrings of length 3. The frequency of triplet for each encoded class in the
protein sequence can be calculated as follows:

\[
q\_{(i)}=\frac{f\_i - M\_0}{M\_1-M\_0}
\]
\[
M\_0 = min(f\_1,f\_2,...,f\_{216})\text { and}\ M\_1 = max(f\_1,f\_2,...,f\_{216})
\]

Here *f*i is the frequency of *i*th triplet in the sequence *i*=1,2,…,216.
To get 216-dimensional descriptor from the protein sequences,
the following command can be used:

```
# using data.frame provided by getFASTA function as data input
TC_Sm_df <- calculateTC_Sm(fasta_df)
#only print out the first 30 elements for the first row
TC_Sm_df[1, c(2:31)]
```

```
##         1         2         3         4         5         6         7         8
## 0.7053571 0.2946429 0.4732143 0.4910714 0.8392857 0.8660714 0.2857143 0.1517857
##         9        10        11        12        13        14        15        16
## 0.2142857 0.1875000 0.2946429 0.3482143 0.4107143 0.1964286 0.2053571 0.1160714
##        17        18        19        20        21        22        23        24
## 0.2589286 0.3571429 0.3035714 0.1428571 0.2321429 0.1517857 0.2410714 0.3928571
##        25        26        27        28        29        30
## 0.7321429 0.3035714 0.4285714 0.3303571 0.7500000 0.6250000
```

### 3.2.5 Quadruplets Composition from Biochemical Similarity Classes Descriptor

To compute these features, the sequence alphabet is first reduced to six classes
reported above (section `3.3.2.4`). This reduction converts a protein sequence
to a vector of 1296 (i.e., 6 \* 6 \* 6 \* 6) different combinations of possible
substrings of length 4 (Ahmed *et al.*, [2018](#ref-ahmed2018prediction)). The frequency of quadruplets for
each encoded class in the protein sequence can be calculated similarly to the
equation mentioned above:

\[
q\_{(i)}=\frac{f\_i - M\_0}{M\_1-M\_0}
\]
\[
M\_0 = min(f\_1,f\_2,...,f\_{1296})\text { and}\ M\_1 = max(f\_1,f\_2,...,f\_{1296})
\]
To get 1296-dimensional descriptor from the protein sequences, the following
command can be used:

```
# using data.frame provided by getFASTA function as data input
QD_df <- calculateQD_Sm(fasta_df)
#only print out the first 30 elements for the first row
QD_df[1, c(2:31)]
```

```
##          1          2          3          4          5          6          7
## 0.42424242 0.18181818 0.27272727 0.48484848 0.48484848 0.66666667 0.15151515
##          8          9         10         11         12         13         14
## 0.21212121 0.15151515 0.09090909 0.24242424 0.27272727 0.45454545 0.06060606
##         15         16         17         18         19         20         21
## 0.24242424 0.18181818 0.21212121 0.57575758 0.24242424 0.15151515 0.36363636
##         22         23         24         25         26         27         28
## 0.24242424 0.27272727 0.51515152 0.66666667 0.42424242 0.54545455 0.21212121
##         29         30
## 0.63636364 0.48484848
```

### 3.2.6 F1/F2 Composition Descriptor

F1 composition gives 20-dimensional description, defined as:

\[
F1(SAR)=\sum\_{SAR\text{ }\epsilon\text{ } sequence}length(SAR)^2
\]

Where *SAR* is the sum of squared length of single amino acid repeats (SARs) in
the entire protein sequence. Since F1 includes SAR of length 1, the F1
descriptor reveals global composition of amino acids and amino acid repeats
(Alguwaizani *et al.*, [2018](#ref-alguwaizani2018predicting)).

![](data:image/png;base64...)

**Figure 1: Example of calculating F1 (repeats of S) in the protein sequence.**

While, to calculate feature F2, the sequence alphabet is first split into
substrings of length 6 residues (Alguwaizani *et al.*, [2018](#ref-alguwaizani2018predicting)). There are two main
differences between feature F2 and F1:

* For F2, sum of square length of single amino acid repeats (SARS) is computed
  for every window of 6 residues.
* The maximum of the sum of squared length of SARs is selected for F2.

F2 composition gives 20-dimensional description, defined as:

\[
F1(SAR)=max\_{windows\text{ }\epsilon\text{ }sequence} \
sum\_{SAR\text{ }\epsilon\text{ } sequence}length(SAR)^2
\]

Where SAR is the sum of squared length of single amino acid repeats (SARs)
in the entire protein sequence.

* **Get feature F1 from the protein sequences:**

```
# using data.frame provided by getFASTA function as data input
F1_df <- calculateF(fasta_df, type = "F1")
#only print out the result the first row
F1_df[1,-1]
```

```
##   A   C   D   E   F   G   H   I   K   L   M   N   P   Q   R   S   T   V   W   Y
##  93  48  66  50  79  88  17  82  65 130  14 102  64  66  44 117 109 113  12  60
```

* **Get feature F2 from the protein sequences:**

```
# using data.frame provided by getFASTA function as data input
F2_df <- calculateF(fasta_df, type = "F2")
#only print out the result the first row
F2_df[1,-1]
```

```
## A C D E F G H I K L M N P Q R S T V W Y
## 9 4 4 4 4 4 1 4 4 9 1 4 4 4 4 9 4 9 1 4
```

### 3.2.7 Composition/Transition/Distribution (CTD) Descriptors

To calculate CTD descriptors developed by
(Dubchak *et al.*, [1995](#ref-dubchak1995prediction), [1999](#ref-dubchak1999recognition)), the 20 standard amino acids
is first clustered into three classes according to its attribute.
Then, each amino acid in the protein sequence is encoded by one of the indices
1,2,3 depending on its grouping. The corresponding divisions for each group are
shown in **Table 1**. According to Hydrophobicity grouping mentioned in
**Table 1**, the protein sequence `CLVIMFWGASTPHYRKEDQN` is replaced by
`11111112222222333333`. Next, for a given attribute, three types of descriptors,
composition (C), transition (T), and distribution (D) can be calculated,
which will be explained in the following sections.

Table 1: Amino acid attributes and the division of amino acid into three-group.

| Sl | Property | Group 1 | Group 2 | Group 3 |
| --- | --- | --- | --- | --- |
| 1 | Charge | Neutral | Negatively charged | Positively charged |
|  | Amino acids | A,C,F,G,H,I,L,M,N,P,Q,S, |  |  |
| T,V,W,Y | D,E | K,R |  |  |
| 2 | Hydrophobicity | Hydrophobicity | Neutral | Polar |
|  | Amino acids | C,F,I,L,M,V,W | A,G,H,P,S,T,Y | D,E,K,N,Q,R |
| 3 | Normalized vander Waals | 0-2.78 | 2.95-4.0 | 4.03-8.08 |
|  | Amino acids | A,C,D,G,P,S,T | E,I,L,N,Q,V | F,H,K,M,R,W,Y |
| 4 | Polarity | 4.9-6.2 | 8.0-9.2 | 10.4-13.0 |
|  | Amino acids | C,F,I,L,M,V,W,Y | A,G,P,S,T | D,E,H,K,N,Q,R |
| 5 | Polariizability | 0 - .108 | 0.128-0.186 | 0.219-0.409 |
|  | Amino acids | A,D,G,S,T | C,E,I,L,N,P,Q,V | F,H,K,M,R,W,Y |
| 6 | Secondary Structure | Coil | Helix | Strand |
|  | Amino acids | D,G,N,P,S | A,E,H,K,L,M,Q,R | C,F,I,T,V,W,Y |
| 7 | Solvent Accessibility | Buried | Intermediate | Exposed |
|  | Amino acids | A,C,F,G,I,L,V,W | H,M,P,S,T,Y | D,E,K,N,R,Q |

#### 3.2.7.1 Composition (C) Descriptor

The composition represents the number of amino acids of a particular property
(e.g., hydrophobicity) for each encoded class divided by the protein sequence
length (You *et al.*, [2014](#ref-you2014prediction)). In the above example using the hydrophobicity
attribute, the number for encoded classes `1`, `2`, `3` are 7,7,6 respectively.
Therefore, the compositions for each class are **7/20 =35%**, **7/20 =35%**,
and **6/20 =30%**, respectively. Composition descriptor can be defined as:

\[
C\_{(i)}=\frac{n\_i}{L} \text{ }\ (i = 1,2,3)
\]

where *n*i is the number of amino acid type i and *L* is the sequence length.
The C descriptor from the protein sequences can be loaded with the following
command:

```
# using data.frame provided by getFASTA function as data input
CTDC_df <- calculateCTDC(fasta_df)
CTDC_df[1, c(-1)]
```

```
##          G1.charge  G1.hydrophobicity G1.normwaalsvolume        G1.polarity
##         0.08091123         0.28515318         0.40612726         0.37549097
##  G1.polarizability G1.secondarystruct   G1.solventaccess          G2.charge
##         0.32914375         0.33857031         0.44854674         0.83267871
##  G2.hydrophobicity G2.normwaalsvolume        G2.polarity  G2.polarizability
##         0.38177533         0.37627651         0.32600157         0.45326002
## G2.secondarystruct   G2.solventaccess          G3.charge  G3.hydrophobicity
##         0.35585232         0.28515318         0.08641005         0.33307148
## G3.normwaalsvolume        G3.polarity  G3.polarizability G3.secondarystruct
##         0.21759623         0.29850746         0.21759623         0.30557738
##   G3.solventaccess
##         0.26630008
```

#### 3.2.7.2 Transition (T) Descriptor

Transition (T) characterizes the percent frequency from a type of amino acids
to another type (Wang et al., 2017). For instance, a transition from class `1`
to `2` or `2` to `1` is the percent frequency with which class `1` is followed
by class `2` or vice versa (Xiao *et al.*, [2015](#ref-xiao2015protr)). The frequency of these transitions
can be computed as follow:

\[
T\_{(rs)}=\frac{n\_{rs} + n\_{sr}}{L-1} \text{ }\ (rs = 12,13,23)
\]

where *n*rs,*n*sr are the number of dipeptide encoded as `rs` and `sr` in
the sequence and and *L* is the sequence length.The T descriptor from the

```
# using data.frame provided by getFASTA function as data input
CTDT_df <- calculateCTDT(fasta_df)
#only print out the result for the first row
CTDT_df[1, -1]
```

```
##          charge.Tr1221.prob          charge.Tr1331.prop
##                  0.13207547                  0.01572327
##          charge.Tr2332.prob  hydrophobicity.Tr1221.prob
##                  0.14465409                  0.21462264
##  hydrophobicity.Tr1331.prop  hydrophobicity.Tr2332.prob
##                  0.20047170                  0.26415094
## normwaalsvolume.Tr1221.prob normwaalsvolume.Tr1331.prop
##                  0.31367925                  0.16823899
## normwaalsvolume.Tr2332.prob        polarity.Tr1221.prob
##                  0.16902516                  0.25000000
##        polarity.Tr1331.prop        polarity.Tr2332.prob
##                  0.23977987                  0.19261006
##  polarizability.Tr1221.prob  polarizability.Tr1331.prop
##                  0.30660377                  0.14072327
##  polarizability.Tr2332.prob secondarystruct.Tr1221.prob
##                  0.19654088                  0.24371069
## secondarystruct.Tr1331.prop secondarystruct.Tr2332.prob
##                  0.20676101                  0.23663522
##   solventaccess.Tr1221.prob   solventaccess.Tr1331.prop
##                  0.25943396                  0.23899371
##   solventaccess.Tr2332.prob
##                  0.15566038
```

#### 3.2.7.3 Distribution (D) Descriptor

The distribution measures the chain length within which the first, 25%, 50%,
75%, and 100% of the amino acids of a particular property (e.g., hydrophobicity)
for a certain encoded class are located, respectively (Dubchak *et al.*, [1995](#ref-dubchak1995prediction)).
For example, as shown in **Figure 3**, there are 8 residues as `1`, the
position for the first residue `1` , the 2nd residue `1` (25% \* 8 = 2),
the 5th `1` residue (50% \* 8 = 4), the 7th `1` (75% \* 8= 6) and
the 10th residue `2` (100% \* 8 =8) in the encoded sequence are 1, 2, 13, 17, 22
respectively, so that the distribution descriptors for residue `1` are :
(1/22) ×100% = 4.55%, (2/22)×100% = 9.09%, (13/22) ×100% = 59.09%,
(17/22)×100% = 77.27%, (22/22)×100% = 100%, respectively. Likewise, the
distribution descriptor for `2` and `3` is
(18.18%, 18.18%, 27.27%, 63.64%, 95.45%) and (13.64%, 31.82%, 45.45%, 54.55%,
86.36%), respectively.

![CTD descriptors](data:image/png;base64...)

**Figure 2:The sequence of hypothetical protein showing the construction of CTD
descriptors of a protein**. The index 1, 2 and 3 indicates the position of
amino acid for each encoded class. 1-2 transitions indicated the position
of `12` or `21` pairs in the sequence.
Similarly, 1-3 and 2-3 transitions are defined in the same way.

The D descriptor from the protein sequences can be calculated with the
following command:

```
# using data.frame provided by getFASTA function as data input
CTDD_df <- calculateCTDD(fasta_df)
#only print out the first 30 elements for the first row
CTDD_df[1, c(2:31)]
```

```
##           charge.g1.residue0         charge.g1.residue100
##                    1.6496465                   99.6857816
##          charge.g1.residue25          charge.g1.residue50
##                   23.5663786                   43.7549097
##          charge.g1.residue75           charge.g2.residue0
##                   75.7266300                    0.0785546
##         charge.g2.residue100          charge.g2.residue25
##                  100.0000000                   24.9018068
##          charge.g2.residue50          charge.g2.residue75
##                   49.9607227                   74.1555381
##           charge.g3.residue0         charge.g3.residue100
##                    3.1421838                   99.1358995
##          charge.g3.residue25          charge.g3.residue50
##                   26.7085625                   55.1453260
##          charge.g3.residue75   hydrophobicity.g1.residue0
##                   80.9897879                    1.0997643
## hydrophobicity.g1.residue100  hydrophobicity.g1.residue25
##                   99.6857816                   25.7659073
##  hydrophobicity.g1.residue50  hydrophobicity.g1.residue75
##                   50.3534957                   75.8051846
##   hydrophobicity.g2.residue0 hydrophobicity.g2.residue100
##                    0.7069914                  100.0000000
##  hydrophobicity.g2.residue25  hydrophobicity.g2.residue50
##                   24.7446976                   49.4893951
##  hydrophobicity.g2.residue75   hydrophobicity.g3.residue0
##                   71.4846819                    0.0785546
## hydrophobicity.g3.residue100  hydrophobicity.g3.residue25
##                   99.7643362                   23.8020424
##  hydrophobicity.g3.residue50  hydrophobicity.g3.residue75
##                   50.5106049                   76.9835035
```

### 3.2.8 Conjoint Triad Descriptor

The conjoint triad is one of the popular sequence-based approaches for
protein-protein interactions prediction (Shen *et al.*, [2007](#ref-shen2007predicting)). This method
encodes a protein sequence as a feature vector by calculating the frequency of
amino acid triplets as follows (Figure 2) :

* Similar to section `3.3.2.4`, it encodes 20 amino acids to seven classes
  based on their dipoles and volumes of the side chains. These seven classes are
  [{AGV}, {DE}, {FILP}, {KR}, {MSTY}, and {C} (Shen et al., 2007)]
* A given protein sequence is then represented using three consecutive amino
  acids (i.e., amino acid triple).
* It uses 343-dimensional feature vectors to represent a given protein sequence,
  where then each feature vector *v* is then mapped to frequency
  vector *d*i (i= 1,2,…343), which is defined as follow:

\[
d\_i = \frac{f\_i - \min\{\,f\_1, f\_2 , \ldots, f\_{343}\,\}}{\max\{\,f\_1, f\_2, \
ldots, f\_{343}\,\}}
\]

Where *f*i is the frequency of *i*-th triplet type in the protein sequence.
The numerical value of *d*i of each protein ranges between 0 to 1,
which therefore allows the comparison between proteins.

![CTD descriptors](data:image/png;base64...)

**Figure 3: Schematic diagram for constructing conjoint triad method**. V is the
vector space of feature vectors that includes a fixed number of features; each
feature (vi) includes amino acid triplet; F represents the frequency vector
corresponding to V, and the value of *i*-th dimension of F(*f*i) corresponds
to the frequency of that *v*i-triad observed in the sequence.

The conjoint triad Descriptor descriptor from the protein sequences can be
calculated with the following command:

```
# using data.frame provided by getFASTA function as data input
CTriad_df <- calculateCTriad(fasta_df)
#only print out the first 30 elements for the first row
CTriad_df[1, c(2:31)]
```

```
##          1          2          3          4          5          6          7
## 0.78409091 0.78409091 0.61363636 0.53409091 0.38636364 0.56818182 0.09090909
##          8          9         10         11         12         13         14
## 0.72727273 0.79545455 0.77272727 0.42045455 0.35227273 0.42045455 0.10227273
##         15         16         17         18         19         20         21
## 0.68181818 0.76136364 0.63636364 0.43181818 0.34090909 0.30681818 0.11363636
##         22         23         24         25         26         27         28
## 0.46590909 0.46590909 0.39772727 0.20454545 0.35227273 0.14772727 0.07954545
##         29         30
## 0.29545455 0.44318182
```

### 3.2.9 Autocorrelation (Auto) Descriptors

Autocorrelation descriptors, also known as molecular connectivity indices,
explain the magnitude of the correlation between protein or peptide sequences
based on their particular structural or physiochemical information, which are
defined according to the distribution of amino acid properties along the
protein sequence (Ong *et al.*, [2007](#ref-ong2007efficacy)). Eight default properties (Xiao *et al.*, [2015](#ref-xiao2015protr))
are used here for deriving the autocorrelation descriptors: normalized average
hydrophobicity scales (AccNo. CIDH920105), average flexibility indices
(AccNo. BHAR88010), polarizability parameter (AccNo. CHAM820101), free energy
of solution in water(AccNo. CHAM820102), residue accessible surface area in
tripeptide (AccNo. CHOC760101), residue volume (AccNo. BIGC670101), steric
parameter (AccNo. CHAM810101), and relative mutability (AccNo. DAYM780201).
Autocorrelation descriptors includes three types of descriptors
(Morean-Broto, Moran, and Geary) which are described below. Prior to
integrating any of the physiochemical attributes into the autocorrelation
formula, these attributes need to be normalized by the following equation:

\[
P\_r = \frac{P\_r - \bar{P}}{\sigma}
\]
where \(\bar{P}\) is the mean value of the eight physiochemical attributes,
and sigma represents the standard deviation, in which both can be defined as:

\[
\bar{P} = \frac{\sum\_{r=1}^{20} P\_r}{20} \quad \textrm{and}
\quad \sigma = \sqrt{\frac{1}{2} \sum\_{r=1}^{20} (P\_r - \bar{P})^2}
\]

The first type of autocorrelation is known as Moreau-Broto autocorrelation
(Broto *et al.*, [1984](#ref-broto1984molecular)). Application of Moreau-Broto autocorrelation to
protein sequence is calculated by the following equation:

\[
AC(d) = \sum\_{i=1}^{L-d} P\_i P\_{i + d} \quad d = 1, 2, \ldots, \textrm{nlag}
\]

where \(P\_i\) and \(P\_{i+d}\) represent the amino acid property at
position \(i\) and \(i+d\) and \(d\) is termed the lag of the autocorrelation
along the protein sequence;
\(P\_i\) and \(P\_{i+d}\). While, \(\textrm{nlag}\) is the maximum value of the lag.
This equation can be normalized based on peptide length to get normalized
Moreau-Broto autocorrelation:

\[
ATS(d) = \frac{AC(d)}{L-d} \quad d = 1, 2, \ldots, \textrm{nlag}
\]

The second type of autocorrelation, named the Moran autocorrelation
(Moran, 1950), can be defined as:

\[
I(d) = \frac{\frac{1}{L-d} \sum\_{i=1}^{L-d} (P\_i - \bar{P}')
(P\_{i+d} - \bar{P}')}{\frac{1}{L} \sum\_{i=1}^{L} (P\_i - \bar{P}')^2}
\quad d = 1, 2, \ldots, 30
\]

where \(d\), \(P\_i\), and \(P\_{i+d}\) are described in the same fashion as that
for Moreau-Broto autocorrelation; \(\bar{P}'\) is the mean of the given amino
acid property \(P\) across the protein sequence, i.e.,

\[
\bar{P}' = \frac{\sum\_{i=1}^L P\_i}{L}
\]

\(d\), \(P\), \(P\_i\) and \(P\_{i+d}\), \(\textrm{nlag}\) are defined as above. The main
difference between Moran and Moreau-Broto autocorrelation is that, unlike
Moreau-Broto, the Moran autocorrelation utilizes the mean value of the given
amino acid property instead of the actual value of the property (Al-Barakati *et al.*, [2019](#ref-al2019rf)).

The last type of autocorrelation , known as the Geary autocorrelation,
can be calculated as:
\[
C(d) = \frac{\frac{1}{2(L-d)} \sum\_{i=1}^{L-d} (P\_i - P\_{i+d})^2}{\frac{1}{L-1}
\sum\_{i=1}^{L} (P\_i - \bar{P}')^2} \quad d = 1, 2, \ldots, 30
\]

where \(d\), \(P\), \(P\_i\), \(P\_{i+d}\), and \(\textrm{nlag}\) are defined above.
The key difference between Geary and the other two autocorrelations is that
the Geary autocorrelation utilizes the square difference of the property values
(Al-Barakati *et al.*, [2019](#ref-al2019rf)).

Computing autocorrelation with HPiP is simple as the following commands:

* **Get Moran autocorrelation:**

```
# using data.frame provided by getFASTA function as data input
moran_df <- calculateAutocor(fasta_df,type = "moran", nlag = 10)
#only print out the first 30 elements for the first row
moran_df[1, c(2:31)]
```

```
##  CIDH920105.lag1  CIDH920105.lag2  CIDH920105.lag3  CIDH920105.lag4
##    -2.277533e-02    -6.586333e-02    -6.065475e-03     7.793094e-03
##  CIDH920105.lag5  CIDH920105.lag6  CIDH920105.lag7  CIDH920105.lag8
##    -1.965556e-02    -2.291896e-02     3.609957e-02     2.404702e-02
##  CIDH920105.lag9 CIDH920105.lag10  BHAR880101.lag1  BHAR880101.lag2
##    -7.224129e-03    -1.962279e-02     5.838844e-04    -3.936188e-02
##  BHAR880101.lag3  BHAR880101.lag4  BHAR880101.lag5  BHAR880101.lag6
##    -4.993847e-04     1.610445e-02     7.256299e-03     2.432986e-03
##  BHAR880101.lag7  BHAR880101.lag8  BHAR880101.lag9 BHAR880101.lag10
##     2.951910e-02     1.431268e-02    -9.954176e-03    -6.734817e-03
##  CHAM820101.lag1  CHAM820101.lag2  CHAM820101.lag3  CHAM820101.lag4
##     2.246027e-02     1.045731e-04     1.598308e-02    -2.012865e-02
##  CHAM820101.lag5  CHAM820101.lag6  CHAM820101.lag7  CHAM820101.lag8
##    -3.081543e-05    -2.027915e-02     2.091813e-02     1.198716e-02
##  CHAM820101.lag9 CHAM820101.lag10
##    -3.860567e-03    -2.132450e-02
```

* **Get Normalized Moreau-Broto autocorrelation:**

```
# using data.frame provided by getFASTA function as data input
mb_df <- calculateAutocor(fasta_df,type = "moreaubroto", nlag = 10)
#only print out the first 30 elements for the first row
mb_df[1, c(2:31)]
```

```
##  CIDH920105.lag1  CIDH920105.lag2  CIDH920105.lag3  CIDH920105.lag4
##    -0.0188245843    -0.0605085976    -0.0026823499     0.0107362310
##  CIDH920105.lag5  CIDH920105.lag6  CIDH920105.lag7  CIDH920105.lag8
##    -0.0157906557    -0.0189568440     0.0381003015     0.0264468353
##  CIDH920105.lag9 CIDH920105.lag10  BHAR880101.lag1  BHAR880101.lag2
##    -0.0037862857    -0.0157775749     0.0082438732    -0.0239249619
##  BHAR880101.lag3  BHAR880101.lag4  BHAR880101.lag5  BHAR880101.lag6
##     0.0073538778     0.0207404479     0.0136327763     0.0097268396
##  BHAR880101.lag7  BHAR880101.lag8  BHAR880101.lag9 BHAR880101.lag10
##     0.0315019066     0.0192685645    -0.0002740419     0.0023150775
##  CHAM820101.lag1  CHAM820101.lag2  CHAM820101.lag3  CHAM820101.lag4
##     0.0646786378     0.0473994319     0.0596316658     0.0317531550
##  CHAM820101.lag5  CHAM820101.lag6  CHAM820101.lag7  CHAM820101.lag8
##     0.0472702127     0.0316032556     0.0633505635     0.0564643542
##  CHAM820101.lag9 CHAM820101.lag10
##     0.0442242141     0.0307261016
```

* **Get Geary autocorrelation:**

```
# using data.frame provided by getFASTA function as data input
geary_df <- calculateAutocor(fasta_df,type = "geary", nlag = 10)
#only print out the first 30 elements for the first row
geary_df[1, c(2:31)]
```

```
##  CIDH920105.lag1  CIDH920105.lag2  CIDH920105.lag3  CIDH920105.lag4
##        1.0226568        1.0657160        1.0059053        0.9920253
##  CIDH920105.lag5  CIDH920105.lag6  CIDH920105.lag7  CIDH920105.lag8
##        1.0194498        1.0227587        0.9637505        0.9757426
##  CIDH920105.lag9 CIDH920105.lag10  BHAR880101.lag1  BHAR880101.lag2
##        1.0068772        1.0192243        0.9991465        1.0391630
##  BHAR880101.lag3  BHAR880101.lag4  BHAR880101.lag5  BHAR880101.lag6
##        1.0003447        0.9837570        0.9926833        0.9974919
##  BHAR880101.lag7  BHAR880101.lag8  BHAR880101.lag9 BHAR880101.lag10
##        0.9703168        0.9853979        1.0097805        1.0066186
##  CHAM820101.lag1  CHAM820101.lag2  CHAM820101.lag3  CHAM820101.lag4
##        0.9774946        0.9999835        0.9841586        1.0203869
##  CHAM820101.lag5  CHAM820101.lag6  CHAM820101.lag7  CHAM820101.lag8
##        1.0004284        1.0207839        0.9794036        0.9882033
##  CHAM820101.lag9 CHAM820101.lag10
##        1.0041758        1.0217759
```

### 3.2.10 k-Spaced Amino Acid Pairs

The k-spaced amino acid pairs (KSAAP) feature describes the number of
occurrences of all possible amino acid pairs by a distance of k, which can be
any number of residues up to two less than the protein length (Al-Barakati *et al.*, [2019](#ref-al2019rf)).
For instance, given 400 (20 x 20) amino acid pairs and four values for k
(k = 1-4), there would be 1600 attributes resulted from the KSAAP feature,
and the frequency of each amino acid pair with k spaces is calculated by
sliding through protein sequence one by once. Table 2 illustrates the outputs
of using KSAAP features with various values of k for protein sequence
`ARAQRTAAADARAKAAKAGCAARRAAATANYN`.

Table 2: Composition of k-spaced amino acid pairs
Given 400 (20 × 20) amino acid pairs and four values for k (k=1–4), there are 1600 attributes generated for the KSAAP feature.

|  |  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- | --- |
|  |  |  |  |  |  |  |  |
| K = 1 | Amino Acid pairs | AXA | AXC | AXD | AXE | —- | YXY |
|  | Numbe of occurances | 8 | 1 | 1 | 0 | —- | 1 |
| K =2 | Amino Acid pairs | AXXA | AXXC | AXXD | AXXE | —- | YXXY |
|  | Numbe of occurances | 7 | 0 | 1 | 0 | —- | 0 |
| K = 3 | Amino Acid pairs | AXXXA | AXXXC | AXXXD | AXXXE | —- | YXXXY |
|  | Numbe of occurances | 8 | 1 | 1 | 0 | —- | 0 |
| K = 4 | Amino Acid pairs | AXXXXA | AXXXXC | AXXXXD | AXXXXE | —- | YXXXXY |
|  | Numbe of occurances | 7 | 1 | 0 | 0 | —- | 0 |
|  |  |  |  |  |  |  |  |

The KSAAP descriptor from the protein sequences can be calculated with the
following command:

```
# using data.frame provided by getFASTA function as data input
KSAAP_df <- calculateKSAAP(fasta_df)
#only print out the first 30 elements for the first row
KSAAP_df[1, c(2:31)]
```

```
##        AsssA        RsssA        NsssA        DsssA        CsssA        EsssA
## 0.0067643743 0.0018320180 0.0026775648 0.0028184893 0.0028184893 0.0031003382
##        QsssA        GsssA        HsssA        IsssA        LsssA        KsssA
## 0.0011273957 0.0036640361 0.0047914318 0.0066234498 0.0025366404 0.0040868095
##        MsssA        FsssA        PsssA        SsssA        TsssA        WsssA
## 0.0022547914 0.0016910936 0.0016910936 0.0039458850 0.0059188275 0.0056369786
##        YsssA        VsssA        AsssR        RsssR        NsssR        DsssR
## 0.0009864713 0.0036640361 0.0025366404 0.0012683202 0.0016910936 0.0009864713
##        CsssR        EsssR        QsssR        GsssR        HsssR        IsssR
## 0.0007046223 0.0023957159 0.0015501691 0.0012683202 0.0021138670 0.0029594138
```

### 3.2.11 Binary encoding

Binary encoding (BE) can be used to transform each residue in a protein
sequence into 20 coding values (Al-Barakati *et al.*, [2019](#ref-al2019rf)). For example, ALa is described as
(10000000000000000000) while Cys is defined as (01000000000000000000), etc.
Thus, the total length of this feature is 400(20 \* 20) vectors.

```
# using data.frame provided by getFASTA function as data input
BE_df <- calculateBE(fasta_df)
#only print out the first 30 elements for the first row
BE_df[1, c(2:31)]
```

### 3.2.12 BString Object as Data Input

Alternatively, we can directly read the FASTA sequences into R using
[Biostrings](https://bioconductor.org/packages/Biostrings)

```
#loading the package
library(Biostrings)

#Read fasta sequences provided by HPiP package using Biostrings
fasta <-
  readAAStringSet(system.file("extdata/UP000464024.fasta", package="HPiP"),
                  use.names=TRUE)
#Convert to df
fasta_bios = data.frame(ID=names(fasta),sequences=as.character(fasta))
#Extract the UniProt identifier
fasta_bios$ID <- sub(".*[|]([^.]+)[|].*", "\\1", fasta_bios$ID)
# for example, run ACC
acc_bios <- calculateAAC(fasta_bios)
```

* ***Note that `fasta_bios` can be used as data input for all the descriptors
  listed in section `3.3.2`***.

### 3.2.13 Generate a SummarizedExperiment Objects

[SummerizedExperiment](https://bioconductor.org/packages/SummarizedExperiment)
objects can be used to store and merge rectangular matrices of different
outputs, as long as they have similar `rownames` or `colnames`. As illustrated
in section `3.3.2`, all the computed data.frames have the same `rownames` but
different features; therefore, we can easily use the `cbind` functions to merge
multiple `SummerizedExperiment` objects to one object. The HPiP package
provides two example SummarizedExperiment objects: `viral_se` and `host_se`.
`viral_se` includes pre-computed **(CTD)** numerical features per viral
proteins present in the `Gold_ReferenceSet`.
Similarly,`host_se` includes **(CTD)** pre-computed numerical features per
host proteins in the `Gold_ReferenceSet`.

```
#loading viral_se object
data(viral_se)
viral_se
```

```
## class: SummarizedExperiment
## dim: 13 147
## metadata(0):
## assays(1): counts
## rownames(13): P0DTD1 P0DTC7 ... P0DTC9 P0DTC2
## rowData names(0):
## colnames(147): G1.charge G1.hydrophobicity ...
##   solventaccess.Tr1331.prop solventaccess.Tr2332.prob
## colData names(1): X
```

```
#loading host_se object
data(host_se)
host_se
```

```
## class: SummarizedExperiment
## dim: 785 147
## metadata(0):
## assays(1): counts
## rownames(785): Q9Y2Z0 Q6NUM9 ... Q02880 Q7KZF4
## rowData names(0):
## colnames(147): G1.charge G1.hydrophobicity ...
##   solventaccess.Tr1331.prop solventaccess.Tr2332.prob
## colData names(1): X
```

The numerical features from each SummarizedExperiment object can be easily
retrieved using the `assays()$counts`, where each row represent the viral or
host proteins and each column represents one of the numerical features.

As an example, construction of `SummarizedExperiment` for viral proteins
using **CTD** descriptors is as follows:

```
#generate descriptors
CTDC_df <- calculateCTDC(fasta_df)
CTDC_m <- as.matrix(CTDC_df[, -1])
row.names(CTDC_m) <- CTDC_df$identifier

CTDT_df <- calculateCTDT(fasta_df)
CTDT_m <- as.matrix(CTDT_df[, -1])
row.names(CTDT_m) <- CTDT_df$identifier

CTDD_df <- calculateCTDD(fasta_df)
CTDD_m <- as.matrix(CTDD_df[, -1])
row.names(CTDD_m) <- CTDD_df$identifier
```

```
#convert matrix to se object
ctdc_se <- SummarizedExperiment(assays = list(counts = CTDC_m),
                                colData = paste0(colnames(CTDC_df[,-1]),
                                                 "CTDC"))
ctdt_se <- SummarizedExperiment(assays = list(counts = CTDT_m),
                                colData = paste0(colnames(CTDT_df[,-1]),
                                                 "CTDT"))
ctdd_se <- SummarizedExperiment(assays = list(counts = CTDD_m),
                                colData = paste0(colnames(CTDD_df[,-1]),
                                                 "CTDD"))
#combine all se objects to one
viral_se <- cbind(ctdc_se,ctdd_se,ctdt_se)
```

### 3.2.14 Table of Summary Descriptors

Table 3: List of commonly used descriptors in HPiP.

| Descriptor name | Length vectors | Function |
| --- | --- | --- |
| Amino Acid Composition | 20 | calculateAAC() |
| Dipeptide Composition | 400 | calculateDC() |
| Tripeptide Composition | 8000 | calculateTC() |
| Tripeptide Composition (TC) from BS Classes | 216 | calculateTC\_Sm() |
| Quadruples Composition (QC) | 1296 | calculateQD\_Sm() |
| F1 | 20 | calculateF1() |
| F2 | 20 | calculateF2() |
| Composition | 21 | calculateCTDC() |
| Transition | 21 | calculateCTDT() |
| Distribution | 105 | calculateCTDD() |
| Conjoint Triad | 343 | calculateCTriad() |
| Geary (Default nlag = 30) | 240 | calculateGeary() |
| Moran (Default nlag = 30) | 240 | calculateMoran() |
| Normalized (Default nlag = 30) | 240 | calculateMoreauBroto() |
| k-Spaced Amino Acid Pairs | 400 | calculateKSAAP() |
| Binary encoding | 400 | calculateBE() |

* ***Note that we can calculate protein sequence descriptors for the host
  proteins using the functions described above (i.e., section `3.2.1-3.2.14`)***.

## 3.3 Combine Host-Pathogen Interaction Descriptors

To generate host-pathogen protein-protein interaction descriptors,
sequence-based descriptors can be combined into one vector space
using `getHPI()`, which provides two types of interactions, controlled by
argument `type`. To illustrate the usage of `getHPI`, we will continue our
example from section `3.2.16`

**1.Extraction of numerical features from `viral_se` and `host_se` objects**

```
#extract features from viral_se
counts_v <- assays(viral_se)$counts
#extract row.names from viral_Se
rnames_v <- row.names(counts_v)
```

```
#extract features from host_se
counts_h <- assays(host_se)$counts
#extract row.names from viral_Se
rnames_h <- row.names(counts_h)
```

**2.Map the features to the gold-standard data:**

```
#Loading gold-standard data
gd <- Gold_ReferenceSet

x1_viral <- matrix(NA, nrow = nrow(gd), ncol = ncol(counts_v))
for (i in 1:nrow(gd))
  x1_viral[i, ] <- counts_v[which(gd$Pathogen_Protein[i] == rnames_v), ]

x1_host <- matrix(NA, nrow = nrow(gd), ncol = ncol(counts_h))
for (i in 1:nrow(gd))
  x1_host[i, ] <- counts_h[which(gd$Host_Protein[i] == rnames_h), ]
```

**3.Generate host-pathogen interaction descriptors using `getHPI`:**

```
x <- getHPI(x1_viral,x1_host, type = "combine")
x <- as.data.frame(x)
x <- cbind(gd$PPI, gd$class, x)
colnames(x)[1:2] <- c("PPI", "class")
```

## 3.4 Data Processing

It is crucial to pre-process the data (i.e., remove the noise) before feeding
it into the machine learning model as the quality of data and valuable
information that can be extracted from it directly affect the model’s
performance. The pre-processing steps are as follow:

* ***Handling missing values***: in any real-world data set, there are always
  missing values. The easiest option is to remove rows or columns including
  missing values; however, such an approach results in losing valuable
  information. The alternative method is to impute missing values using
  neighboring information (e.g., average or median) or replace the missing
  values with zeros. HPiP package provides two functions to deal with the
  missing values. The `filter_missing_values` allows the user to drop the
  missing values above a certain threshold, controlled by argument
  `max_miss_rate`, while the `impute_missing_data` function replaces the null
  values with mean/median or zero, controlled by argument `method`.
* ***Feature selection***: some of the sequence-based features are high
  dimensional, including hundreds to thousands of features. Unfortunately,
  such high-dimensional data includes many redundant features that reduce the
  predictive model’s accuracy and increase the training time.
  The `FSmethod`function in the HPiP package combines two feature selection
  (FS) methods, controlled by `type()` argument, to eliminate redundant features.
  The first FS method is based on correlation analysis that computes the
  correlation between features using Pearson correlation measure and removes
  highly correlated features above the user-defined threshold. The second FS
  method uses the Recursive Feature Elimination (RFE) algorithm (wrapped up with
  a random forest (rf) machine learning algorithm) to perform feature selection.
  RFE works by fitting the *rf* algorithm with all features in the training data
  set, ranking features by importance, removing the least important features,
  and re-fitting the model until the desired number of features remains.
  The feature importance can be computed using *rf* model-independent metric
  (e.g., ROC curve analysis or accuracy), which is controlled by
  argument `metric()`.

The complete set of arguments for `FSmethod` function are:

* `x` A data.frame containing protein-protein interactions, class labels and
  features.
* `type` The feature selection type
* `cor.cutoff` Correlation coefficient cutoff used for filtering.
* `resampling.method` The re-sampling method (e.g., *k*-fold cross-validation)
  for RFE.
* `iter` Number of partitions for cross-validation.
* `repeats` For repeated *k*-fold cross validation only.
* `metric` A string that specifies what summary metric will be used to select
  the optimal feature.
* `verbose` Make the output verbose.

Continuing our example from section **3.3**, feature selection using both
correlation analysis and RFE approach can be performed using the following
command:

```
#to use correlation analysis, make sure to drop the columns with sd zero
xx <- Filter(function(x) sd(x) != 0, x[,-c(1,2)])
xx <- cbind(x$PPI, x$class, xx)
colnames(xx)[1:2] <- c("PPI", "class")

#perform feature selection using both correlation analysis and RFE approach
set.seed(101)
x_FS <- FSmethod(xx, type = c("both"),
                 cor.cutoff = 0.8,resampling.method = "cv",
                 iter = 2,repeats =NULL, metric = "Accuracy",
                 verbose = FALSE)
```

We can also visualize the results from the `FSmethod` analysis. For instance,
the correlation matrix of unfiltered data can be visualized using the
`corr_plot`. This will present us with a heatmap showing the correlation between
all the features prior to filtration.

```
#cor plot
corr_plot(x_FS$cor.result$corProfile, method = 'square' , cex = 0.1)
```

![](data:image/png;base64...)

```
#var importance
var_imp(x_FS$rf.result$rfProfile, cex.x = 8, cex.y = 8)
```

![](data:image/png;base64...)

## 3.5 Prediction Algorithm

Sequence features and a list of gold-standard HP-PPIs can be fed into an
ensemble classifier to rank the potential HP-PPIs interaction. This is
accomplished via the `pred_ensmebel` function. This function uses the
ensemble averaging approach, to combine any base classifiers provided in
the `caret` package to predict HP-PPIs. To score interactions, the
`pred_ensmebel` function uses the the training data
(i.e., labelled HP-PPIs with sequence features) as well
as unlabeled HP-PPIs data set to learn features that allow reliable prediction
of HP-PPIs, utilizing multiple ML algorithms. Following training, the trained
models will be used to make predictions on unlabeled data. Then,ensemble
averaging will be applied to average predictions over an ensemble of
classifiers, each with different cross-validation splits. Finally, through
resamplign techniques (e.g., *k*-fold cross-validation), this function also
compares and evaluates the performance of ensemble model with individual
machine learning models via commonly used measurements such as Recall
(Sensitivity), Specificity, Accuracy , Precision, F1-score, and Matthews
correlation coefficient (MCC). The corresponding formulae are as follows:

\[
Recall=Sensitivity=TPR=\frac{TP}{TP+FN}
\]

\[
Specificity=1-FPR=\frac{TN}{TN+FP}
\]

\[
Accuracy=\frac{TP+TN}{TP+TN+FP+FN}
\]

\[
Precision=\frac{TP}{TP+FP}
\]

\[
F1=2 \text{ × } \frac{Precision \text{ × } Recall}{Precision + Recall}
\]

\[
MCC=\frac{TP \text{ × } TN - FP \text{ × } FN}{\sqrt{(TP+FP)\text{ × }
(TP+FN)\text{ × } (TN+FP)\text{ × } (TN+FN)}}
\]

The `pred_ensemble` takes the following parameters:

* `features` A data frame with host-pathogen protein-protein interactions
  (HP-PPIs) in the first column, and features to be passed to the classifier
  in the remaining columns.
* `gold_standard` A data frame with gold\_standard HP-PPIs and class label
  indicating if such PPIs are positive or negative.
* `classifier` The type of classifier to use. See `caret` package for all
  the available classifiers.
* `resampling.method` The re-sampling technique
  (i.e., *k*-fold cross-validation).
* `ncross` Number of partitions for cross-validation.
* `plots` Logical value, indicating whether to plot the performance of ensemble
  learning algorithm as compared to individual classifiers.If the argument set
  to TRUE, plots will be saved in current working directory.
* `verboseIter` Make the output verbose.
* `filename` A character string, indicating the output filename as an pdf
  object.

As an example, we will use three base learners , support vector machine
(`svmRadial`), Fitting Generalized Linear Models (`glm`), and random
forest (`ranger`), controlled by argument `classifier`, to rank potential
interaction. For the sake of time, we use only five-fold cross-validation
(`ncross = 5`). In order to perform prediction, we will use `unlabel_data`,
retrieved from Supplementary Table 1 presented in (Gordon *et al.*, [2020](#ref-gordon2020sars)) , which
includes unlabeled HP-PPIs along with pre-computed `CTD` features, as well as
constructed data containing labeled HP-PPIs from section `3.4`.

```
#load the unlabeled HP-PPIs
data('unlabel_data')
#Constructed labeled HP-PPIs
labeled_dat <- x_FS$rf.result$rfdf
labeled_dat <- labeled_dat[,-1]
#select important features
unlabel_data <-
  unlabel_data[names(unlabel_data) %in% names(x_FS$rf.result$rfdf)]

#merge them
ind_data <- rbind(unlabel_data,labeled_dat)
```

```
# Get class labels
gd <-  x_FS$rf.result$rfdf
gd <-  gd[, c(2,1)]
```

Now we can predict interactions using `pred_ensembel`:

```
set.seed(102)
ppi <- pred_ensembel(ind_data,
                     gd,
                     classifier = c("svmRadial", "glm", "ranger"),
                     resampling.method = "cv",
                     ncross = 5,
                     verboseIter = TRUE,
                     plots = FALSE,
                     filename=file.path(tempdir(), "plots.pdf"))
```

To retrieve predicted interactions from the result generated by `pred_ensembel`
function, we can just type:

```
pred_interactions <- ppi[["predicted_interactions"]]
head(pred_interactions)
```

```
##                  PPI Pathogen_protein Host_protein  ensemble
## 1    M:P0DTC5~Q9UBM1         M:P0DTC5       Q9UBM1 0.7008682
## 2 nsp6:P0DTD1~Q8WVX9      nsp6:P0DTD1       Q8WVX9 0.6857571
## 3 ORF6:P0DTC6~P62861      ORF6:P0DTC6       P62861 0.6921793
## 4 nsp4:P0DTD1~Q6P2Q9      nsp4:P0DTD1       Q6P2Q9 0.6889793
## 5    M:P0DTC5~O75489         M:P0DTC5       O75489 0.6986460
## 6 nsp6:P0DTD1~Q8TEM1      nsp6:P0DTD1       Q8TEM1 0.6923126
```

Finally, users can subset their list of high-confidence interactions for further
analysis, using a stringent classifier confidence ensemble score cutoff of 0.7:

```
pred_interactions <- filter(pred_interactions, ensemble >= 0.7)
dim(pred_interactions)
```

```
## [1] 100   4
```

When the `plots` argument set to TRUE, the `pred_ensembel` function generates
one pdf file indicating the performance of the ensemble classier as compared
to individual base learners

* The first plot shows the Receiver Operating Characteristic (ROC) curve.
  ![](data:image/png;base64...)

  **Figure 4: ROC\_Curve curve.**
* The second plot shows the Precision-Recall (PR) curve
  ![](data:image/png;base64...)

  **Figure 5: Precision-Recall (PR) curve.**
* The third plot shows the accuracy (ACC), F1-score ,positive predictive value
  (PPV),sensitivity (SE),and Matthews correlation coefficient (MCC)
  of ensemble classifier vs selected individual classifiers.
  ![](data:image/png;base64...)

  **Figure 6: Point plot.**

## 3.6 Nework Visualization

Following PPI prediction, users can visualize the predicted PPI network using
`plotPPI` and `FreqInteractors` functions.

* The `plotPPI` function, which is based on the *igraph* plotting function
  (Csardi, [2013](#ref-csardi2013package)), provide visualization on interacting host protein
  partners of pathogen proteins. For instance, to get the PPI network of
  SARS-CoV2-ORF8-human, we can run the following command:

```
S_interc <- filter(pred_interactions,
                           str_detect(Pathogen_protein, "^ORF8:"))
#drop the first column
ppi <- S_interc[,-1]

plotPPI(ppi, edge.name = "ensemble",
            node.color ="red",
            edge.color = "grey",
            cex.node = 10,
            node.label.dist= 2)
```

![](data:image/png;base64...)

* The `FreqInteractors` function, shows the degree distribution of pathogen
  proteins in the HP-PPI network:

```
ppi <- pred_interactions[,-1]
FreqInteractors(ppi,cex.size = 12)
```

```
## Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the HPiP package.
##   Please report the issue at <https://github.com/mrbakhsh/HPiP/issues>.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

## 3.7 GO Enrichment Analysis

To identify significantly enriched annotation terms in predicted interacting
host protein partners of each pathogen protein, we can use the `enrichfindP`
function based on the *g:Profiler* tool (Kolberg *et al.*, [2020](#ref-kolberg2020gprofiler2)). Additionally,
we can use the `erichfind_hp` function to analyze functional characteristics of
all predicted human proteins in the predicted network.

For instance, the following command can be used to performs functional
enrichment analysis of host protein partners of each pathogen protein:

```
enrich_result <-
  enrichfindP(ppi,threshold = 0.05,
            sources = "GO",
            p.corrction.method = "bonferroni",
            org = "hsapiens")
```

## 3.8 Complex Prediction

for this analysis, we utilizes the predicted HP-PPIS network generated in
section `3.5` as input data for complex prediction. For the community detection
analysis, `run_clustering` function provided in the HPiP package includes the
five most popular complex detection algorithms in including fast-greedy,
walktrap, label propagation, multi-level community, and markov clustering. For
example, to detect complexes using fast-greedy algorithm, we can run the
following command:

```
ppi <- pred_interactions[,-1]
set.seed(103)
predcpx <- run_clustering(ppi, method = "FC")
```

Additionally, we can analyze the functional characteristics of
these predicted modules via `enrichfind_cpx` function.

```
enrichcpx <- enrichfind_cpx(predcpx,
             threshold = 0.05,
             sources = "GO",
             p.corrction.method = "bonferroni",
             org = "hsapiens")
```

# 4 Session info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] caret_7.0-1                 lattice_0.22-9
##  [3] ggplot2_4.0.2               HPiP_1.16.1
##  [5] tibble_3.3.1                stringr_1.6.0
##  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [9] GenomicRanges_1.62.1        MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           Biostrings_2.78.0
## [13] Seqinfo_1.0.0               XVector_0.50.0
## [15] IRanges_2.44.0              S4Vectors_0.48.0
## [17] BiocGenerics_0.56.0         generics_0.1.4
## [19] dplyr_1.2.0                 readr_2.2.0
## [21] knitr_1.51                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] bitops_1.0-9         pROC_1.19.0.1        rlang_1.1.7
##   [4] magrittr_2.0.4       otel_0.2.0           e1071_1.7-17
##   [7] compiler_4.5.2       gprofiler2_0.2.4     vctrs_0.7.1
##  [10] reshape2_1.4.5       pkgconfig_2.0.3      crayon_1.5.3
##  [13] fastmap_1.2.0        magick_2.9.0         labeling_0.4.3
##  [16] PRROC_1.4            rmarkdown_2.30       prodlim_2025.04.28
##  [19] tzdb_0.5.0           tinytex_0.58         bit_4.6.0
##  [22] purrr_1.2.1          xfun_0.56            randomForest_4.7-1.2
##  [25] cachem_1.1.0         jsonlite_2.0.0       recipes_1.3.1
##  [28] DelayedArray_0.36.0  parallel_4.5.2       R6_2.6.1
##  [31] bslib_0.10.0         stringi_1.8.7        RColorBrewer_1.1-3
##  [34] ranger_0.18.0        parallelly_1.46.1    rpart_4.1.24
##  [37] lubridate_1.9.5      jquerylib_0.1.4      Rcpp_1.1.1
##  [40] bookdown_0.46        iterators_1.0.14     future.apply_1.20.2
##  [43] Matrix_1.7-4         splines_4.5.2        nnet_7.3-20
##  [46] igraph_2.2.2         timechange_0.4.0     tidyselect_1.2.1
##  [49] dichromat_2.0-0.1    abind_1.4-8          yaml_2.3.12
##  [52] timeDate_4052.112    codetools_0.2-20     curl_7.0.0
##  [55] listenv_0.10.0       plyr_1.8.9           withr_3.0.2
##  [58] S7_0.2.1             evaluate_1.0.5       future_1.69.0
##  [61] survival_3.8-6       proxy_0.4-29         kernlab_0.9-33
##  [64] pillar_1.11.1        BiocManager_1.30.27  corrplot_0.95
##  [67] foreach_1.5.2        plotly_4.12.0        RCurl_1.98-1.17
##  [70] vroom_1.7.0          hms_1.1.4            scales_1.4.0
##  [73] globals_0.19.0       class_7.3-23         glue_1.8.0
##  [76] lazyeval_0.2.2       tools_4.5.2          data.table_1.18.2.1
##  [79] ModelMetrics_1.2.2.2 gower_1.0.2          grid_4.5.2
##  [82] tidyr_1.3.2          ipred_0.9-15         nlme_3.1-168
##  [85] cli_3.6.5            protr_1.7-5          expm_1.0-0
##  [88] viridisLite_0.4.3    ggthemes_5.2.0       S4Arrays_1.10.1
##  [91] lava_1.8.2           gtable_0.3.6         MCL_1.0
##  [94] sass_0.4.10          digest_0.6.39        SparseArray_1.10.8
##  [97] htmlwidgets_1.6.4    farver_2.1.2         htmltools_0.5.9
## [100] lifecycle_1.0.5      httr_1.4.8           hardhat_1.4.2
## [103] bit64_4.6.0-1        MASS_7.3-65
```

# 5 References

Ahmed,I. *et al.* (2018) Prediction of human-bacillus anthracis protein–protein interactions using multi-layer neural network. *Bioinformatics*, **34**, 4159–4164.

Al-Barakati,H.J. *et al.* (2019) RF-glutarysite: A random forest based predictor for glutarylation sites. *Molecular omics*, **15**, 189–204.

Alguwaizani,S. *et al.* (2018) Predicting interactions between virus and host proteins using repeat patterns and composition of amino acids. *Journal of healthcare engineering*, **2018**.

Beltran,J.C. *et al.* (2019) Predicting protein-protein interactions based on biological information using extreme gradient boosting. In, *2019 ieee conference on computational intelligence in bioinformatics and computational biology (cibcb)*. IEEE, pp. 1–6.

Bhasin,M. and Raghava,G.P. (2004) Classification of nuclear receptors based on amino acid composition and dipeptide composition. *Journal of Biological Chemistry*, **279**, 23262–23266.

Broto,P. *et al.* (1984) Molecular structures: Perception, autocorrelation descriptor and sar studies: System of atomic contributions for the calculation of the n-octanol/water partition coefficients. *European journal of medicinal chemistry*, **19**, 71–78.

Csardi,M.G. (2013) Package ‘igraph’. *Last accessed*, **3**, 2013.

Dey,L. *et al.* (2020) Machine learning techniques for sequence-based prediction of viral–host interactions between sars-cov-2 and human proteins. *Biomedical journal*, **43**, 438–450.

Dubchak,I. *et al.* (1995) Prediction of protein folding class using global description of amino acid sequence. *Proceedings of the National Academy of Sciences*, **92**, 8700–8704.

Dubchak,I. *et al.* (1999) Recognition of a protein fold in the context of the scop classification. *Proteins: Structure, Function, and Bioinformatics*, **35**, 401–407.

Eid,F.-E. *et al.* (2016) DeNovo: Virus-host sequence-based protein–protein interaction prediction. *Bioinformatics*, **32**, 1144–1150.

Gordon,D.E. *et al.* (2020) A sars-cov-2 protein interaction map reveals targets for drug repurposing. *Nature*, **583**, 459–468.

Hart,G.T. *et al.* (2006) How complete are current yeast and human protein-interaction networks? *Genome biology*, **7**, 1–9.

Ito,T. *et al.* (2001) A comprehensive two-hybrid analysis to explore the yeast protein interactome. *Proceedings of the National Academy of Sciences*, **98**, 4569–4574.

Kolberg,L. *et al.* (2020) Gprofiler2–an r package for gene list functional enrichment analysis and namespace conversion toolset g: Profiler. *F1000Research*, **9**.

Kuhn,M. *et al.* (2020) Package ‘caret’. *The R Journal*, **223**.

Liao,B. *et al.* (2011) Predicting apoptosis protein subcellular location with pseaac by incorporating tripeptide composition. *Protein and peptide letters*, **18**, 1086–1092.

Nourani,E. *et al.* (2015) Computational approaches for prediction of pathogen-host protein-protein interactions. *Frontiers in microbiology*, **6**, 94.

Ong,S.A. *et al.* (2007) Efficacy of different protein descriptors in predicting protein functional families. *Bmc Bioinformatics*, **8**, 1–14.

Pagès,H. *et al.* (2019) Biostrings: Efficient manipulation of biological strings. *R package version*, **2**, 10–18129.

Puig,O. *et al.* (2001) The tandem affinity purification (tap) method: A general procedure of protein complex purification. *Methods*, **24**, 218–229.

Rahmatbakhsh,M. *et al.* (2021) Bioinformatic analysis of temporal and spatial proteome alternations during infections. *Frontiers in Genetics*, **12**, 1155.

Samavarchi-Tehrani,P. *et al.* (2020) A sars-cov-2-host proximity interactome. *BioRxiv*.

Shen,J. *et al.* (2007) Predicting protein–protein interactions based only on sequences information. *Proceedings of the National Academy of Sciences*, **104**, 4337–4341.

Stark,C. *et al.* (2006) BioGRID: A general repository for interaction datasets. *Nucleic acids research*, **34**, D535–D539.

Wu,X. *et al.* (2006) Prediction of yeast protein–protein interaction network: Insights from the gene ontology and annotations. *Nucleic acids research*, **34**, 2137–2150.

Xiao,N. *et al.* (2015) Protr/protrweb: R package and web server for generating various numerical representation schemes of protein sequences. *Bioinformatics*, **31**, 1857–1859.

You,Z.-H. *et al.* (2014) Prediction of protein-protein interactions from amino acid sequences using a novel multi-scale continuous and discontinuous feature set. In, *BMC bioinformatics*. Springer, pp. 1–9.

Zhou,X. *et al.* (2018) A generalized approach to predicting protein-protein interactions between virus and host. *BMC genomics*, **19**, 69–77.

# Appendix