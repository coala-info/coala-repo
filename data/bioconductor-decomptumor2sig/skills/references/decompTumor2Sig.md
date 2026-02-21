# A brief introduction to decompTumor2Sig

Rosario Michael Piro1\*

1Dipartimento di Elettronica, Informazione e Bioingegneria (DEIB), Politecnico di Milano, Italy

\*rmpiro@gmail.com or rosariomichael.piro@polimi.it

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
  + [1.1 Papers / how to cite](#papers-how-to-cite)
* [2 Installing and loading the package](#installation)
  + [2.1 Installation](#installation-1)
    - [2.1.1 Bioconductor](#bioconductor)
    - [2.1.2 Manual installation](#manual-installation)
  + [2.2 Loading the package](#loading-the-package)
* [3 Input data](#input)
  + [3.1 Mutational signatures](#input-sign)
    - [3.1.1 Alexandrov signatures](#input-sign-alexandrov)
    - [3.1.2 Shiraishi signatures](#input-sign-shiraishi)
    - [3.1.3 Get signatures from the package *pmsignature*](#input-pmsig)
    - [3.1.4 Conversion of Alexandrov signatures to Shiraishi signatures](#sign-Alex2Shi)
    - [3.1.5 Adjustment/normalization of mutational signatures for subsets of the genome](#adjustmentnormalization-of-mutational-signatures-for-subsets-of-the-genome)
    - [3.1.6 Verifying the signature format](#verifying-the-signature-format)
  + [3.2 Somatic mutations from individual tumors](#input-mut)
    - [3.2.1 Variant Call Format (VCF)](#input-mut-vcf)
    - [3.2.2 Mutation Position Format (MPF)](#input-mut-mpf)
    - [3.2.3 Get somatic mutations from the package *pmsignature*](#mutpm)
    - [3.2.4 Get somatic mutations from a VRanges object](#input-mut-vranges)
    - [3.2.5 Verifying the mutation data (“genomes”) format](#verifying-the-mutation-data-genomes-format)
* [4 Workflow](#workflow)
  + [4.1 Visualizing genome characteristics and mutational signatures](#visualizing-genome-characteristics-and-mutational-signatures)
  + [4.2 Explained variance as a function of the number of signatures](#explained-variance-as-a-function-of-the-number-of-signatures)
    - [4.2.1 Example: input data](#example-input-data)
    - [4.2.2 Example: plot the explained variance](#example-plot-the-explained-variance)
  + [4.3 Decomposing tumor genomes by signature refitting (contribution prediction)](#decomposing-tumor-genomes-by-signature-refitting-contribution-prediction)
    - [4.3.1 Finding a subset of signatures with a minimum explained variance](#finding-a-subset-of-signatures-with-a-minimum-explained-variance)
    - [4.3.2 Computing the explained variance](#computing-the-explained-variance)
  + [4.4 Re-composing/reconstructing tumor genomes from exposures and signatures](#re-composingreconstructing-tumor-genomes-from-exposures-and-signatures)
  + [4.5 Mapping and comparing sets of signatures](#mapping-and-comparing-sets-of-signatures)
    - [4.5.1 Comparison of signatures of the same format](#comparison-of-signatures-of-the-same-format)
    - [4.5.2 Comparison of signatures of different types or formats](#comparison-of-signatures-of-different-types-or-formats)

# 1 Introduction

The R package **decompTumor2Sig** has been developed to decompose individual
tumor genomes (i.e., the lists of somatic single nucleotide variants identified
in individual tumors) according to a set of given mutational signatures—a
problem termed signature refitting—using a quadratic-programming approach.

Mutational signatures can be either of the form initially proposed by Alexandrov
et al. (Cell Rep. 3:246–259, 2013 and Nature 500:415–421, 2013)—in the
following called “Alexandrov signatures”—or of the simplified form proposed
by Shiraishi et al. (PLoS Genet. 11:e1005657, 2015)—in the following called
“Shiraishi signatures”.

For each of the given mutational signatures, **decompTumor2Sig** determines
their contribution to the load of somatic mutations observed in a tumor.

**Please read the following important notes first**:

*Note*: here and in the following, when referring to “mutations”, we intend
single nucleotide variants (SNVs).

*Note*: given the number of parameters to be estimated, **decompTumor2Sig**
should best be applied only to tumor samples with a sufficient number of somatic
mutations. From our experience, using tumor samples with 100+ somatic mutations
was reasonable when using version 2 of the COSMIC Mutational Signatures
(30 signatures). Tumor samples with fewer somatic mutations should be avoided
unless a tumor-type specific subset of signatures is used.

*Note*: be aware that publicly available signature sets have often been defined
with respect to genome wide mutation frequencies, so they should best be applied
to somatic mutation data from whole genome sequencing. Background frequencies
may be different for subsets of the genome, i.e., current signature sets might
yield incorrect results when applied to, for example, mutation data from
targetted sequencing of only a subset of genes!

*Note*: for all functions provided by **decompTumor2Sig**, please see the
manual or the inline R help page for further details and explanations.

## 1.1 Papers / how to cite

> Krüger S, Piro RM (2019) decompTumor2Sig: Identification of mutational
> signatures active in individual tumors. *BMC Bioinformatics*
> **20**(Suppl 4):152.

> Krüger S, Piro RM (2017) Identification of mutational signatures active in
> individual tumors. *PeerJ Preprints* **5**:e3257v1 (Proceedings of the NETTAB
> 2017 Workshop on Methods, Tools & Platforms for Personalized Medicine in the
> Big Data Era, October 16-18, 2017 in Palermo, Italy).

BibTeX:

```
@UNPUBLISHED(krueger-decompTumor2Sig-paper,
   author = "Kr{\"u}ger, Sandra and Piro, Rosario Michael",
   title = "decompTumor2Sig: Identification of mutational signatures active in individual tumors",
   journal = "BMC Bioinformatics",
   volume = "20",
   number = "Suppl 4",
   pages = "152",
   year = 2019
);

@ARTICLE(krueger-decompTumor2Sig-nettab,
   author = "Kr{\"u}ger, Sandra and Piro, Rosario Michael",
   title = "Identification of mutational signatures active in individual tumors",
   journal = "PeerJ Preprints",
   volume = "5",
   pages = "e3257v1",
   year = 2017
);
```

# 2 Installing and loading the package

## 2.1 Installation

### 2.1.1 Bioconductor

**decompTumor2Sig** requires several CRAN and Bioconductor R packages to be
installed. Dependencies are usually handled automatically, when installing the
package using the following commands:

```
install.packages("BiocManager")
BiocManager::install("decompTumor2Sig")
```

[NOTE: Ignore the first line if you already have installed the
*[BiocManager](https://CRAN.R-project.org/package%3DBiocManager)*.]

### 2.1.2 Manual installation

In the unlikely case that a manual installation is required, e.g., if you do
not install **decompTumor2Sig** via Bioconductor (which is highly recommended),
before installing **decompTumor2Sig** make sure the following packages are
installed:

CRAN packages:

*[Matrix](https://CRAN.R-project.org/package%3DMatrix)*, *[quadprog](https://CRAN.R-project.org/package%3Dquadprog)*,
*[plyr](https://CRAN.R-project.org/package%3Dplyr)*, *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)*, *[ggseqlogo](https://CRAN.R-project.org/package%3Dggseqlogo)*,
*[gridExtra](https://CRAN.R-project.org/package%3DgridExtra)*

Bioconductor packages:

*[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)*, *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)*,
*[Seqinfo](https://bioconductor.org/packages/3.22/Seqinfo)*,
*[Biostrings](https://bioconductor.org/packages/3.22/Biostrings)*, *[BiocGenerics](https://bioconductor.org/packages/3.22/BiocGenerics)*,
*[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)*, *[BSgenome.Hsapiens.UCSC.hg19](https://bioconductor.org/packages/3.22/BSgenome.Hsapiens.UCSC.hg19)*,
*[TxDb.Hsapiens.UCSC.hg19.knownGene](https://bioconductor.org/packages/3.22/TxDb.Hsapiens.UCSC.hg19.knownGene)*,
*[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)*, *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*

If you intend to work with Shiraishi-type signatures, you may also want to
install the R package *pmsignature* which is neither part of
CRAN nor of Bioconductor and must be downloaded and installed manually
(available at: <https://github.com/friend1ws/pmsignature>).

CRAN packages can be installed from R using the following command:

```
install.packages("<package_name>")
```

Bioconductor packages can be installed from R using the following command:

```
BiocManager::install("<package_name>")
```

Sometimes, it may also be useful to update Bioconductor:

```
BiocManager::install()
```

Finally, the manual installation of **decompTumor2Sig** can, for example, be
done from the command line …

```
R CMD INSTALL decompTumor2Sig_<version>.tar.gz
```

… or the newest version can directly be installed from GitHub using the
CRAN package *[devtools](https://CRAN.R-project.org/package%3Ddevtools)*:

```
library(devtools)
install_github("rmpiro/decompTumor2Sig")
```

## 2.2 Loading the package

After installation, loading the package is simple:

```
library(decompTumor2Sig)
```

# 3 Input data

**decompTumor2Sig** works with two kinds of input data:

1. a set of given mutational signatures, and
2. a set of somatic mutations (single nucleotide variants) observed in a tumor
   genome.

Additionally, **decompTumor2Sig** requires the genomic sequence (in form of a
*BSgenome* object) to determine neighboring nucleotides of the
mutated bases. It may also require transcript annotations (in form of a
*TxDb* object) in case the given mutational signatures take
information on the transcription direction into account.

## 3.1 Mutational signatures

Mutational signatures can be read in two different formats: Alexandrov-type
signatures and Shiraishi-type signatures.

### 3.1.1 Alexandrov signatures

Alexandrov signatures are specified either in the format used at the
COSMIC Mutational Signatures website for signatures version 2 (March 2015,
see <http://cancer.sanger.ac.uk/cosmic/signatures_v2> -> “Download signatures”),
in the format used for signatures version 3 (May 2019; see
<https://www.synapse.org/#!Synapse:syn12009743>), or in the format used for
singatures version 3.2 (March 2021; see
<https://cancer.sanger.ac.uk/cosmic/signatures/SBS/>). Also the signatures of
version 3.1 (same as version 3.0 but distributed as an Excel spread sheet
on the COSMIC Mutational Signatures website) can be read. For versions 3, 3.1
and 3.2, only Single Base Substitution (SBS) signatures can be used.

The standard Alexandrov-type signatures report mutation frequencies for
nucleotide triplets where the mutated base is at the center. Also, the basic
Alexandrov signatures do not take transcription direction into account when
computing mutation frequencies.

Example for version 2:

```
Substitution Type  Trinucleotide  Somatic Mutation Type  Signature 1     ...
C>A                ACA            A[C>A]A                0.011098326166  ...
C>A                ACC            A[C>A]C                0.009149340734  ...
C>A                ACG            A[C>A]G                0.001490070468  ...
C>A                ACT            A[C>A]T                0.006233885236  ...
...
T>G                TTG            T[T>G]G                0.002031076880  ...
T>G                TTT            T[T>G]T                0.004030128160  ...
```

Example for version 3:

```
Type,SubType,SBS1,SBS2,SBS3,SBS4,SBS5,SBS6, ...
C>A,ACA,8.86E-04,5.80E-07,2.08E-02,4.22E-02,1.20E-02,4.25E-04, ...
C>A,ACC,2.28E-03,1.48E-04,1.65E-02,3.33E-02,9.44E-03,5.24E-04, ...
C>A,ACG,1.77E-04,5.23E-05,1.75E-03,1.56E-02,1.85E-03,5.20E-05, ...
C>A,ACT,1.28E-03,9.78E-05,1.22E-02,2.95E-02,6.61E-03,1.80E-04, ...
...
T>G,TTG,5.83E-04,9.54E-05,8.05E-03,2.32E-03,6.94E-03,3.24E-04, ...
T>G,TTT,2.23E-16,2.23E-16,1.05E-02,5.68E-04,1.35E-02,1.01E-03, ...
```

(Apart from the change of tab- to comma-separator, the main difference is
the lack of the redundant 3rd annotation column in version 3. Version 3.1 has
the same format as version 3, but is distributed as an Excel spread sheet.)

Example for version 3.2:

```
Type       SBS1                    SBS2                    ...
A[C>A]A    0.000876022860356065    5.79005909129116e-07    ...
A[C>A]C    0.0022201195808427      0.000145504532003707    ...
A[C>A]G    0.000179727205679816    5.36186073164881e-05    ...
A[C>A]T    0.00126505263784183     9.75912243380865e-05    ...
...
T[T>G]G    0.000577613846957072    9.54312693870027e-05    ...
T[T>G]T    2.20126302870092e-16    2.22251767921597e-16    ...
```

To read Alexandrov-type signatures, use the command
**readAlexandrovSignatures()**. By default, the command reads the version 2 (!)
signatures directly from COSMIC and stores them in a list object:

```
signatures <- readAlexandrovSignatures()
length(signatures)
```

```
## [1] 30
```

```
signatures[1]
```

```
## $Signature.1
##      A[C>A]A      A[C>A]C      A[C>A]G      A[C>A]T      C[C>A]A      C[C>A]C
## 1.109833e-02 9.149341e-03 1.490070e-03 6.233885e-03 6.595870e-03 7.342368e-03
##      C[C>A]G      C[C>A]T      G[C>A]A      G[C>A]C      G[C>A]G      G[C>A]T
## 8.928404e-04 7.186582e-03 8.232604e-03 5.758021e-03 6.163352e-04 4.459080e-03
##      T[C>A]A      T[C>A]C      T[C>A]G      T[C>A]T      A[C>G]A      A[C>G]C
## 1.225006e-02 1.116223e-02 2.275496e-03 1.525910e-02 1.801068e-03 2.580909e-03
##      A[C>G]G      A[C>G]T      C[C>G]A      C[C>G]C      C[C>G]G      C[C>G]T
## 5.925480e-04 2.963986e-03 1.284983e-03 7.021348e-04 5.062896e-04 1.381543e-03
##      G[C>G]A      G[C>G]C      G[C>G]G      G[C>G]T      T[C>G]A      T[C>G]C
## 6.021227e-04 2.393352e-03 2.485340e-07 8.900807e-04 1.874853e-03 2.067419e-03
##      T[C>G]G      T[C>G]T      A[C>T]A      A[C>T]C      A[C>T]G      A[C>T]T
## 3.048970e-04 3.151574e-03 2.951453e-02 1.432275e-02 1.716469e-01 1.262376e-02
##      C[C>T]A      C[C>T]C      C[C>T]G      C[C>T]T      G[C>T]A      G[C>T]C
## 2.089645e-02 1.850170e-02 9.557722e-02 1.711331e-02 2.494381e-02 2.716149e-02
##      G[C>T]G      G[C>T]T      T[C>T]A      T[C>T]C      T[C>T]G      T[C>T]T
## 1.035708e-01 1.768985e-02 1.449210e-02 1.768078e-02 7.600222e-02 1.376170e-02
##      A[T>A]A      A[T>A]C      A[T>A]G      A[T>A]T      C[T>A]A      C[T>A]C
## 4.021520e-03 2.371144e-03 2.810910e-03 8.360909e-03 1.182587e-03 1.903167e-03
##      C[T>A]G      C[T>A]T      G[T>A]A      G[T>A]C      G[T>A]G      G[T>A]T
## 1.487961e-03 2.179344e-03 6.892894e-04 5.524095e-04 1.200229e-03 2.107137e-03
##      T[T>A]A      T[T>A]C      T[T>A]G      T[T>A]T      A[T>C]A      A[T>C]C
## 5.600155e-03 1.999079e-03 1.090066e-03 3.981023e-03 1.391577e-02 6.274961e-03
##      A[T>C]G      A[T>C]T      C[T>C]A      C[T>C]C      C[T>C]G      C[T>C]T
## 1.013764e-02 9.256316e-03 4.176675e-03 5.252593e-03 7.013225e-03 6.713813e-03
##      G[T>C]A      G[T>C]C      G[T>C]G      G[T>C]T      T[T>C]A      T[T>C]C
## 1.124784e-02 6.999724e-03 4.977593e-03 1.066741e-02 8.073616e-03 4.857381e-03
##      T[T>C]G      T[T>C]T      A[T>G]A      A[T>G]C      A[T>G]G      A[T>G]T
## 8.325454e-03 6.257106e-03 1.587636e-03 1.784091e-03 1.385831e-03 3.158539e-03
##      C[T>G]A      C[T>G]C      C[T>G]G      C[T>G]T      G[T>G]A      G[T>G]C
## 3.026912e-04 2.098502e-03 1.599549e-03 2.758538e-03 9.904500e-05 2.023656e-04
##      G[T>G]G      G[T>G]T      T[T>G]A      T[T>G]C      T[T>G]G      T[T>G]T
## 1.188353e-03 8.007233e-04 1.397554e-03 1.291737e-03 2.031077e-03 4.030128e-03
```

Alternatively, the signatures can be read from a file of the format shown
above (TSV, CSV or Excel spread sheet):

```
signatures <- readAlexandrovSignatures(file="<signature_file>")
```

### 3.1.2 Shiraishi signatures

Shiraishi signatures are specified as matrices (in flat files without headers
and row names; one file per signature).

Format (see Shiraishi et al. PLoS Genetics 11(12):e1005657, 2015):

* The first row:
  Frequencies of the six possible base changes C>A, C>G, C>T, T>A, T>C, and T>G.
  Please note that due to the complementarity of base pairing these six base
  changes already include A>? and G>?.
* The following *2k* rows (for *k* up- and downstream flanking bases):
  Frequencies of the bases A, C, G, and T, followed by two 0 values.
* The optional last row (only if transcription direction is considered):
  Frequencies of occurrences on the transcription strand, and on the
  opposite strand, followed by four 0 values.

Example:

```
0.05606328   0.07038910   0.39331059   0.13103780   0.20797476   0.14122446
0.27758477   0.21075424   0.23543226   0.27622874   0            0
0.33081021   0.25347427   0.23662536   0.17909016   0            0
0.21472304   2.6656e-09   0.55231053   0.23296643   0            0
0.22640542   0.20024237   0.32113377   0.25221844   0            0
0.50140066   0.49859934   0            0            0            0
```

Among its examples, the **decompTumor2Sig** package provides a small set of
four Shiraishi-type signatures in flat files. These signatures were obtained
from 21 breast cancer genomes (Nik-Zainal et al. Cell 149:979–993, 2012) using
the R package *pmsignature* (Shiraishi et al. PLoS Genet.
11:e1005657, 2015).

To read these flat files as signatures, you can use the following example:

```
# take the example signature flat files provided with decompTumor2Sig
sigfiles <- system.file("extdata",
                 paste0("Nik-Zainal_PMID_22608084-pmsignature-sig",1:4,".tsv"),
                 package="decompTumor2Sig")

# read the signature flat files
signatures <- readShiraishiSignatures(files=sigfiles)
signatures[1]
```

```
## $`Nik-Zainal_PMID_22608084-pmsignature-sig1.tsv`
##          [C>A]        [C>G]     [C>T]     [T>A]     [T>C]     [T>G]
## mut 0.05606328 7.038910e-02 0.3933106 0.1310378 0.2079748 0.1412245
## -2  0.27758477 2.107542e-01 0.2354323 0.2762287 0.0000000 0.0000000
## -1  0.33081021 2.534743e-01 0.2366254 0.1790902 0.0000000 0.0000000
## +1  0.21472304 2.665627e-09 0.5523105 0.2329664 0.0000000 0.0000000
## +2  0.22640542 2.002424e-01 0.3211338 0.2522184 0.0000000 0.0000000
## tr  0.50140066 4.985993e-01 0.0000000 0.0000000 0.0000000 0.0000000
```

### 3.1.3 Get signatures from the package *pmsignature*

The third possibility is to convert Shiraishi-type signatures directly from
the package that computes them (*pmsignature*; Shiraishi et al.
PLoS Genet. 11:e1005657, 2015).

Example workflow:

```
# load example signatures for breast cancer genomes from Nik-Zainal et al
# (PMID: 22608084) in the format produced by pmsignature (PMID: 26630308)
pmsigdata <- system.file("extdata",
          "Nik-Zainal_PMID_22608084-pmsignature-Param.Rdata",
          package="decompTumor2Sig")
load(pmsigdata)

# extract the signatures from the pmsignature 'Param' object
signatures <- getSignaturesFromEstParam(Param)
signatures[1]
```

```
## [[1]]
##          [C>A]        [C>G]     [C>T]     [T>A]     [T>C]     [T>G]
## mut 0.05606328 7.038910e-02 0.3933106 0.1310378 0.2079748 0.1412245
## -2  0.27758477 2.107542e-01 0.2354323 0.2762287 0.0000000 0.0000000
## -1  0.33081021 2.534743e-01 0.2366254 0.1790902 0.0000000 0.0000000
## +1  0.21472304 2.665627e-09 0.5523105 0.2329664 0.0000000 0.0000000
## +2  0.22640542 2.002424e-01 0.3211338 0.2522184 0.0000000 0.0000000
## tr  0.50140066 4.985993e-01 0.0000000 0.0000000 0.0000000 0.0000000
```

Please note that *pmsignature* is neither part of CRAN nor of
Bioconductor and must be downloaded and installed manually (available at:
<https://github.com/friend1ws/pmsignature>). To load mutational signatures
without *pmsignature* being installed, see the previous sections.

### 3.1.4 Conversion of Alexandrov signatures to Shiraishi signatures

An Alexandrov-type signature can be converted into a Shiraishi-type signature
(but not *vice versa* due to the loss of information). Consider the following
example:

```
sign_a <- readAlexandrovSignatures()
sign_s <- convertAlexandrov2Shiraishi(sign_a)
sign_s[1]
```

```
## $Signature.1
##         [C>A]      [C>G]     [C>T]      [T>A]     [T>C]      [T>G]
## mut 0.1100022 0.02309801 0.6754994 0.04153693 0.1241471 0.02571636
## -1  0.3290833 0.21464994 0.2370499 0.21921681 0.0000000 0.00000000
## +1  0.1858812 0.15440965 0.4967238 0.16298544 0.0000000 0.00000000
```

*Note*: since the standard Alexandrov-type signatures regard nucleotide
triplets and do not take transcription direction into account, the obtained
Shiraishi-type signatures will also be limited to triplets without information
about transcription direction.

**Important**: Please be aware that signatures are initially not determined in
isolation but as a set of signatures derived from a commonly large set of tumor
genomes (Alexandrov et al. Cell Rep. 3:246–259, 2013; Alexandrov et al. Nature
500:415–421, 2013; Shiraishi et al. PLoS Genet. 11:e1005657, 2015). Therefore,
the biological meaning of converting signatures is not well defined, and the
approach should be taken with caution! As an example for the possible outcome,
please see our paper (Krüger and Piro, 2019).

### 3.1.5 Adjustment/normalization of mutational signatures for subsets of the genome

The exact numeric features of mutational signatures (e.g., the 96 mutation
probabilities of trinucleotide mutation types within an Alexandrov-type
signature) depend not only on the mutational processes themselves, but also
on the nucleotide frequencies within the reference sequences of the mutation
data from which the signatures were derived.

Consider, for example, a hypothetical biochemical mutational process which can
potentially cause C[C>T]G and A[C>T]A mutations with equal probability.
Even if both mutation types are potentially equiprobable, in CG-rich regions
more C[C>T]G than A[C>T]A mutations will be observed, simply because these
regions likely contain more CCG trinucleotides than ACA trinucleotides which
can be mutated. This illustrates that the observed fractions of mutations do
not only depend on the underlying mutational process alone, but also on the
nucleotide frequencies within the reference sequences from which the mutational
signatures were inferred in the first place (e.g., whole genome, whole exome,
another subset of genomic regions?).

Sometimes, however, it may be useful to apply signature refitting to
mutation data from genomic regions whose nucelotide frequencies differ from
those for which mutational signatures are available. For example, signature
refitting might need to be applied to mutation data from whole exome
sequencing, or targetted sequencing (only a specific set of genes) although
mutational signatures were derived for data from the whole reference genome.

For this purpose, the function **adjustSignaturesForRegionSet()** provides
the possibility to (re-)adjust/normalize mutational signatures for a given
reference sequence (e.g., whole genome) to the nucleotide frequencies present
in another target set of genomic regions (e.g., whole exome) to which
signature refitting has to be applied.

**Adjustment/normalization of Alexandrov-type signatures:**

For Alexandrov-type signatures, the important frequencies are those of
multi-nucleotide sequence patterns (usually trinucleotides) whose central base
can be mutated. Therefore, adjustment factors for individual multi-nucleotide
mutation types (e.g., A[C>T]G) are computed by comparing the corresponding
multi-nucleotide frequencies (e.g., ACG) between the original reference regions
and the target regions.

Mathematical approach: divide the mutation probabilities of individual mutation
features (e.g., trinucleotide mutation types for Alexandrov signatures) by the
original (genome-wide?) multi-nucleotide frequency, then multiply it by
the corresponding frequency in the target region set. That is, if the target
regions, for example, have a doubled frequency of a certain trinucleotide
(e.g., ACG) with respect to the original reference sequence, the mutation
probabilities of the corresponding mutation types (A[C>A]G, A[C>G]G, A[C>T]G)
in an Alexandrov signature will be multiplied by 2. Reasoning: the mutational
process has more opportunities to mutate that trinucleotide in the target
regions than in the original reference sequence for which the signature was
initially derived. After the appropriate adjustment of individual features,
an Alexandrov signature is re-normalized such that overall probability over
all mutation types sum up to 1.

**Adjustment/normalization of Shiraishi-type signatures:**

In the Shiraishi-type signature model, individual bases of the multi-nucleotide
sequence patterns are considered as independent features. Therefore, the
adjustment of such signatures should be applied to individual bases while still
reflecting the presence of absence (hence, the frequencies) of the full sequence
patterns in the genomic regions. Thus, to compute single-nucleotide frequencies
for the adjustment, first the frequencies of the multi-nucleotide sequence
patterns are determined (as for Alexandrov-type signatures) and then broken
down to single-nucleotide frequencies for the individual positions of the
patterns. That is, for each position in the sequence patterns a set of
single-nucleotide frequencies is determined to describe, for example, how
frequent a specific nucleotide occurs at a specific position in the pattern
(very much like in position-frequency matrices used for transcription factor
binding motives).

Mathematical approach: for signature adjustment, the position-specific
nucleotide frequencies are applied to the position-specific mutation
probabilities of a Shiraishi signature much in the same way as described above
for the adjustment of multi-nucleotide frequencies in Alexandrov signatures.
After the appropriate adjustment of individual position-specific features,
a Shirishi signature is re-normalized such that for each individual position
in the pattern the overall base change probability (for the central base) or
nucleotide probabilities (for flanking bases) sum up to 1.

**Usage example:**

Example for adjusting Alexandrov signatures (derived from mutation data from
the whole genome) to the nucleotide frequencies present in promoter regions:

```
# get Alexandrov signatures from COSMIC
signatures <- readAlexandrovSignatures()

signatures$Signature.1[1:5]
```

```
##     A[C>A]A     A[C>A]C     A[C>A]G     A[C>A]T     C[C>A]A
## 0.011098330 0.009149341 0.001490070 0.006233885 0.006595870
```

```
# get gene annotation for the default reference genome (hg19)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene

# get a GRanges object for gene promoters (-2000 to +200 bases from TSS)
library(GenomicRanges)
regionsTarget <- promoters(txdb, upstream=2000, downstream=200)

# adjust signatures according to nucleotide frequencies in this subset of
# the genome
sign_adj <-
   adjustSignaturesForRegionSet(signatures,
            regionsTarget, regionsOriginal=NULL,
            refGenome=BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19)

sign_adj$Signature.1[1:5]
```

```
##     A[C>A]A     A[C>A]C     A[C>A]G     A[C>A]T     C[C>A]A
## 0.005487838 0.005989037 0.001548082 0.003225154 0.004170618
```

**adjustSignaturesForRegionSet()** accepts both types of signatures with the
following arguments:

* *signatures*: The signature set (list) to be adjusted/normalized.
* *regionsTarget*: A **GRanges** object (package *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)*)
  containing the target regions for which to adjust the signatures. This can
  also be NULL if the new target regions correspond to the whole genome.
* *regionsOriginal*: Optional **GRanges** object containing the genomic regions
  for which the signatures were originally derived. By default (NULL) this is the whole genome.
* *refGenome*: Optional **BSgenome** object with the reference genome from
  which to extract sequences for both the original and the target regions. By
  default, the human refernce genome hg19 is taken.

### 3.1.6 Verifying the signature format

For certain applications it may be necessary to construct signatures or
convert them from other kind of data. To do so, each signature must be either
a numeric *vector* of probabilities which sum up to 1 (for Alexandrov-type
signatures) or a *matrix* or *data.frame* with six numeric columns, every row
of which sums up to 1 (for Shiraishi-type signatures).

A set of signatures is then simply a *list* of such signatures.

To verify whether a signature set has a format that can be used with
**decompTumor2Sig** the package provides the following set of functions. Since
the mutation frequencies in genomes are specified in exactly the same way,
these functions can be used for both signatures and genomes:

* **isAlexandrovSet()**: Verify whether a list object (set of signatures or
  genomes) is compatible with the Alexandrov model.
* **isShiraishiSet()**: Verify whether a list object (set of signatures or
  genomes) is compatible with the Shiraishi model.
* **isSignatureSet()**: Verify whether a list object (set of signatures or
  genomes) is compatible with either the Alexandrov or the Shiraishi model.
* **sameSignatureFormat()**: Verify whether two list objects (two sets of
  signatures or genomes) contain signatures/genomes of the same format.

Examples:

```
isAlexandrovSet(sign_a)
```

```
## [1] TRUE
```

```
isSignatureSet(sign_a)
```

```
## [1] TRUE
```

```
isShiraishiSet(sign_s)
```

```
## [1] TRUE
```

```
isSignatureSet(sign_s)
```

```
## [1] TRUE
```

```
sameSignatureFormat(sign_a, sign_s)
```

```
## [1] FALSE
```

## 3.2 Somatic mutations from individual tumors

Information on the somatic mutations found in a tumor can be read from one of
the following formats and converted to mutation frequencies for
**decompTumor2Sig**.

### 3.2.1 Variant Call Format (VCF)

The somatic mutations of a tumor genome can be read from a VCF file. For
detailed information on this format (including an example), see
<https://samtools.github.io/hts-specs/VCFv4.2.pdf>.

Mutations from multiple tumor genomes can also be read from a multi-sample VCF
file.

As an example, the **decompTumor2Sig** package provides the somatic mutations
for a subset of six of the 21 breast cancer genomes originally published by
Nik-Zainal et al (Cell 149:979–993, 2012). The dataset has been converted
from MPF (see below) to VCF.

Example workflow:

```
# load the reference genome and the transcript annotation database
refGenome <- BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
transcriptAnno <-
           TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene

# take the six breast cancer genomes from Nik-Zainal et al (PMID: 22608084)
gfile <- system.file("extdata",
                     "Nik-Zainal_PMID_22608084-VCF-convertedfromMPF.vcf.gz",
                     package="decompTumor2Sig")

# read the cancer genomes in VCF format
genomes <- readGenomesFromVCF(gfile, numBases=5, type="Shiraishi",
                              trDir=TRUE, refGenome=refGenome,
                              transcriptAnno=transcriptAnno, verbose=FALSE)
length(genomes)
```

```
## [1] 6
```

```
genomes[1:2]
```

```
## $PD3851a
##         [C>A]     [C>G]     [C>T]     [T>A]     [T>C]      [T>G]
## mut 0.1975425 0.1001890 0.3355388 0.1257089 0.1540643 0.08695652
## -2  0.2863894 0.2277883 0.1710775 0.3147448 0.0000000 0.00000000
## -1  0.2854442 0.2381853 0.1928166 0.2835539 0.0000000 0.00000000
## +1  0.2674858 0.2022684 0.2551985 0.2750473 0.0000000 0.00000000
## +2  0.2759924 0.2041588 0.2051040 0.3147448 0.0000000 0.00000000
## tr  0.4848771 0.5151229 0.0000000 0.0000000 0.0000000 0.00000000
##
## $PD3890a
##         [C>A]     [C>G]     [C>T]     [T>A]     [T>C]     [T>G]
## mut 0.1593069 0.2322527 0.2367244 0.1232532 0.1352711 0.1131917
## -2  0.2990497 0.2040246 0.1922862 0.3046395 0.0000000 0.0000000
## -1  0.2428731 0.2283399 0.1676914 0.3610956 0.0000000 0.0000000
## +1  0.2912241 0.2135271 0.1467300 0.3485187 0.0000000 0.0000000
## +2  0.2845165 0.1852990 0.1931247 0.3370598 0.0000000 0.0000000
## tr  0.5019564 0.4980436 0.0000000 0.0000000 0.0000000 0.0000000
```

When reading somatic mutations of tumor genomes with **readGenomesFromVCF()**,
they are preprocessed to determine mutation frequencies according to specific
sequence characteristics which can be controlled by the following arguments:

* *type*: Type of signatures that will be used with the genomes, “Shiraishi” or
  “Alexandrov”.
* *numBases*: The odd number of nucleotides/bases of the mutated sequence
  (where the mutated base is at the center).
* *trDir*: Whether the transcription direction should be taken into account
  (default: TRUE). If so, only mutations located within genomic regions for which
  a transcript direction is defined will be considered.
* *refGenome*: The reference genome from which to obtain the flanking bases of
  the mutated base.
* *transcriptAnno*: The transcript annotation database from which to obtain the
  transcription direction (if needed, i.e., if *trDir*=TRUE).
* *enforceUniqueTrDir*: If *trDir* is TRUE, then by default each mutation which
  maps to a region with multiple overlapping genes with opposing transcription
  directions will be excluded from the analysis. This is because from mutation
  data alone it cannot be inferred which of the two genes has the higher
  transcription activity which might potentially be linked to the occurrence of
  the mutation. Until version 1.3.5 of **decompTumor2Sig** the behavior for
  mutations associated with two valid transcription directions was different: the
  transcript direction encountered first in the transcript database (specified
  with *transcriptAnno*) was assigned to the mutation; the latter is also the
  default behavior of the *pmsignature* package. If you need to
  reproduce the old behavior—which basically arbitrarily assigns one of the two
  transcriptions strands—then you can set *enforceUniqueTrDir*=FALSE (this
  option exists mostly for backward compatibility with older versions), but it is
  recommended to entirely exclude mutations without ambiguous transcription
  strands. Note: this option is ignored when *trDir*=FALSE, where all mutations
  can be used.

### 3.2.2 Mutation Position Format (MPF)

Alternatively, somatic mutations can be read from an MPF file.

Example MPF file:

```
patient1   chr1   809687    G   C
patient1   chr1   819245    G   T
patient1   chr2   2818266   A   G
patient1   chr2   3433314   G   A
patient2   chr1   2927666   A   G
patient2   chr1   3359791   C   T
```

The five columns contain

1. the name of the sample (or tumor ID);
2. the chromosome name;
3. the position on the chromosome;
4. the reference base at that position (A, C, G, or T);
5. the alternate or variant base (A, C, G, or T).

Hence, with an MPF file, too, multiple tumors can be described.

As an example, the **decompTumor2Sig** package provides the somatic mutations
for six of the 21 breast cancer genomes originally published by Nik-Zainal et
al (Cell 149:979–993, 2012).

Example workflow:

```
# load the reference genome and the transcript annotation database
refGenome <- BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
transcriptAnno <-
           TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene

# take the six breast cancer genomes from Nik-Zainal et al (PMID: 22608084)
gfile <- system.file("extdata", "Nik-Zainal_PMID_22608084-MPF.txt.gz",
                     package="decompTumor2Sig")

# read the cancer genomes in MPF format
genomes <- readGenomesFromMPF(gfile, numBases=5, type="Shiraishi",
                              trDir=TRUE, refGenome=refGenome,
                              transcriptAnno=transcriptAnno, verbose=FALSE)
```

Note: the preprocessing of the somatic mutations into mutation frequencies can
be controlled with the same function arguments that have been described above
for **readGenomesFromVCF()**.

### 3.2.3 Get somatic mutations from the package *pmsignature*

The third possibility to get the somatic mutations from one or more tumor
genomes is to convert them directly from a tumor data object
(*MutationFeatureData* object) loaded using the *pmsignature*
package (Shiraishi et al. PLoS Genet. 11:e1005657, 2015).

An example of such an object is provided with **decompTumor2Sig**:

```
# get breast cancer genomes from Nik-Zainal et al (PMID: 22608084)
# in the format produced by pmsignature (PMID: 26630308)
pmsigdata <- system.file("extdata",
                         "Nik-Zainal_PMID_22608084-pmsignature-G.Rdata",
                         package="decompTumor2Sig")
load(pmsigdata)

# extract the genomes from the pmsignature 'G' object
genomes <- getGenomesFromMutFeatData(G, normalize=TRUE)
genomes[1]
```

```
## $PD3851a
##         [C>A]     [C>G]     [C>T]     [T>A]    [T>C]      [T>G]
## mut 0.1913161 0.1031208 0.3487110 0.1166893 0.156038 0.08412483
## -2  0.2605156 0.2306649 0.1831750 0.3256445 0.000000 0.00000000
## -1  0.2862958 0.2388060 0.1791045 0.2957938 0.000000 0.00000000
## +1  0.2795115 0.1886024 0.2686567 0.2632293 0.000000 0.00000000
## +2  0.2727273 0.2184532 0.1981004 0.3107191 0.000000 0.00000000
## tr  0.4735414 0.5264586 0.0000000 0.0000000 0.000000 0.00000000
```

Please note that *pmsignature* is neither part of CRAN nor of
Bioconductor and must be downloaded and installed manually (available at:
<https://github.com/friend1ws/pmsignature>). To read tumor genomes without
*pmsignature* being installed, see the previous sections about
VCF and MPF and the following section.

**Important**: the argument *normalize*, that can be specified for
**getGenomesFromMutFeatData()**, controls whether the function should simply
count the number of occurrences or whether it provides (normalized)
fractions/percentages of mutations among the total set. Normalization is the
default and is what **should be used** for determining the contribution of
individual signatures to the mutational load of a tumor. *normalize*=FALSE
should be used only in case you are interested in how many somatic mutations
of the single signature categories can be found in a tumor; it should not be
used for further processing with **decompTumor2Sig**!

**Important**: There is a slight difference on how *pmsignature*
and **decompTumor2Sig** preprocess mutations for counting them when taking the
transcription direction into account: For mutations which map to a region with
multiple overlapping genes with opposing transcription directions,
*pmsignature* assigns the transcript direction of the gene
encountered first in the transcript database (see also Section 3.2.1). This
was also the behavior of **decompTumor2Sig** until version 1.3.5 (used for
our papers; Krüger and Piro, 2017, 2019). In newer versions,
**decompTumor2Sig** excludes these mutations
by default from the count because from mutation data alone it cannot be
inferred which of the two genes has the higher transcriptional activity which
might potentially be linked to the occurrence of the mutation. However, when
converting data from *pmsignature* these mutations have already
been processed and can therefore not be excluded during the conversion.

### 3.2.4 Get somatic mutations from a VRanges object

The Bioconductor package *[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)* provides the class
**VRanges** which can be used to store mutation information. **decompTumor2Sig**
allows to extract single nucleotide variants (SNVs) from such an object and
convert them into the tumor genomes’ mutation frequencies using the function
**convertGenomesFromVRanges()**, as in the following example workflow:

```
# load the reference genome and the transcript annotation database
refGenome <- BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
transcriptAnno <-
           TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene

# take six breast cancer genomes from Nik-Zainal et al (PMID: 22608084)
gfile <- system.file("extdata",
                     "Nik-Zainal_PMID_22608084-VCF-convertedfromMPF.vcf.gz",
                     package="decompTumor2Sig")

# get the corresponding VRanges object (using the VariantAnnotation package)
library(VariantAnnotation)
vr <- readVcfAsVRanges(gfile, genome="hg19")

# convert the VRanges object to the decompTumor2Sig format
genomes <- convertGenomesFromVRanges(vr, numBases=5, type="Shiraishi",
                                     trDir=TRUE, refGenome=refGenome,
                                     transcriptAnno=transcriptAnno,
                                     verbose=FALSE)
```

Note: the preprocessing of the somatic mutations into mutation frequencies can
be controlled with the same function arguments that have been described above
for **readGenomesFromVCF()**.

### 3.2.5 Verifying the mutation data (“genomes”) format

Since the mutation data of genomes is specified as mutation probabilities
and has exactly the same format as signatures, the format can be verified with
the very same functions described in Section 3.1.6 (see above).

# 4 Workflow

(*Note*: The following examples are for illustrative purpose only and need not
be biologically meaningful.)

Once both the tumor genome(s) and the given mutational signatures have been
read (see above), the contribution of the given signatures to the somatic
mutations in individual tumors can be determined using the following workflow.

In the following, we assume to have the signatures in a list object named
*signatures* and the mutation frequencies of the tumor genome(s) in another
list object named *genomes*.

**Important note**: it is imperative that the mutation frequencies represented
by both *signatures* and *genomes* have been computed with the same
characteristics. That is, if the *signatures* refer to sequences of 5
nucleotides/bases (with the mutated base at the center), then also the
*genomes* must have been read for 5 bases. If the *signatures* have been
produced taking the transcription direction into account, then also the
*genomes* must have been read taking the transcription direction into account,
and so on.

## 4.1 Visualizing genome characteristics and mutational signatures

Given that the signatures and the genomes (if read appropriately) have the same
format and contain the same type of information (fractions/percentages of
somatic mutations that have specific features, e.g., specific neighboring
bases), both can essentially be visualized in the same way.

The function **plotMutationDistribution()** takes as an input either a single
signature or the mutation frequencies of an individual tumor genome (either of
Alexandrov- or of Shiraishi-type) and plots the mutation frequency data
according to the signature model.

To plot, for example, Alexandrov/COSMIC signature 1 (obtained as described in
Section 3.1.1):

```
signatures <- readAlexandrovSignatures()
plotMutationDistribution(signatures[[1]])
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the decompTumor2Sig package.
##   Please report the issue at
##   <https://github.com/rmpiro/decompTumor2Sig/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
## of ggplot2 3.3.4.
## ℹ The deprecated feature was likely used in the decompTumor2Sig package.
##   Please report the issue at
##   <https://github.com/rmpiro/decompTumor2Sig/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

To plot one of the Shiraishi signatures provided with this package (see Section
3.1.2):

```
sigfiles <- system.file("extdata",
                 paste0("Nik-Zainal_PMID_22608084-pmsignature-sig",1:4,".tsv"),
                 package="decompTumor2Sig")
signatures <- readShiraishiSignatures(files=sigfiles)

plotMutationDistribution(signatures[[1]])
```

```
## Ignoring unknown labels:
## • size : "4"
## Ignoring unknown labels:
## • size : "4"
## Ignoring unknown labels:
## • size : "4"
## Ignoring unknown labels:
## • size : "4"
```

![](data:image/png;base64...)

**decompTumor2Sig**’s representation of the mutation frequency data of
Shiraishi-type signatures uses sequence logos for the flanking bases and the
variant bases (with the heights of the bases being proportional to their
probability/frequency). The two possibilities for the mutated central base
(**C** or **T**) are represented next to each other and their respective
frequency is indicated below. This side-by-side representation allows to
distinguish the probabilities of variant bases (on top) according to the
mutated base. Transcription strand bias (if information on transcription
direction is used) is shown in the upper right corner (frequency of mutations
on the transcription strand, “+”, and the opposite strand, “-”).

In the plot above, for example, **C** and **T** are nearly equally likely
to be mutated by the represented mutational process, but a mutated **C** most
frequently becomes a **T**, while a mutated **T** becomes one of the other
bases with roughly equal probability. Also, the mutational signature has next
to no strand bias.

This representation is similar to the way the *pmsignature*
package represents such signatures, as shown by the following example:

![](data:image/png;base64...)
(This plot above was generated with *pmsignature* and serves only
for comparison, showing the same signature as above.)

To show that genome mutation frequencies can be represented in the same manner,
the following example reads the tumor genomes provided with this package (see
Section 3.2.1) using the Alexandrov model and plots the mutation frequencies of
the first genome:

```
refGenome <- BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
gfile <- system.file("extdata",
                     "Nik-Zainal_PMID_22608084-VCF-convertedfromMPF.vcf.gz",
                     package="decompTumor2Sig")
genomes <- readGenomesFromVCF(gfile, numBases=3, type="Alexandrov",
         trDir=FALSE, refGenome=refGenome, verbose=FALSE)

plotMutationDistribution(genomes[[1]])
```

![](data:image/png;base64...)

## 4.2 Explained variance as a function of the number of signatures

In many cases already a small subset of the given signatures is sufficient to
explain the major part of the variance of the mutation frequencies observed
in a single tumor genome.

The explained variance can be determined by comparing the true mutation
frequencies \(g\_i\) of the tumor genome—where \(i\) is one of the mutation
features of the signature model (e.g., triplet mutations for Alexandrov
signatures, or base changes or flanking bases for Shiraishi signatures)—to
the mutation frequencies \(\hat{g}\_i\) obtained when re-composing/reconstructing
the mutation frequencies of the tumor genome from the mutational signatures and
their computed exposures/contributions. (See Section 4.3 for computing the
exposures/contributions, and Section 4.4 for reconstructing the mutation
frequencies of a tumor.)

For the Alexandrov model, the explained variance can be estimated as:

\[ \mathrm{evar}=1-\frac{\sum\_i{(g\_i-\hat{g}\_i)^2}}{\sum\_i({g\_i}-\bar{g})^2} \]

where the numerator is the residual sum of squares (RSS) between the predicted
and true mutation frequencies of the tumor genome (i.e., the squared error),
and the denominator can be interpreted as the deviation from a tumor genome
with a uniform mutation frequency of 1/96 for each feature (which is
precisely the average mutation frequency \(\bar{g}\)).

For the Shiraishi model, \(\bar{g}\) does not describe a tumor genome with
uniform mutation frequencies, and hence the explained variance is estimated as:

\[\mathrm{evar}=1-\frac{\sum\_i{(g\_i-\hat{g}\_i)^2}}{\sum\_i({g\_i}-{g}^{\*}\_i)^2}\]

where \(g^{\*}\) is a uniform tumor model that uses mutation frequencies of 1/6
for the six possible base changes, 1/4 for each of the possible flanking bases,
and 1/2 for each of the two possible transcription-strand directions. For more
details, please see Krüger and Piro (2019).

The function **plotExplainedVariance()** allows to visually analyze how many
signatures are necessary to explain certain fractions of the variance of a
tumor genome’s mutational patterns.

For an increasing number *K* of signatures, the highest variance explained by
subsets of *K* signatures will be plotted. This can help to evaluate what
minimum threshold for the explained variance could be used to decompose tumor
genomes with the function **decomposeTumorGenomes()** (see below).

### 4.2.1 Example: input data

As a simple example, load a set of 15 Shiraishi-type signatures (object
*signatures*) provided with this package. These signatures were obtained with
the package *pmsignature* from a set of 435 tumor genomes with at
least 100 somatic mutations from ten different tumor entities (data from
Alexandrov et al. Nature 500:415-421, 2013; for the analysis, see our papers
mentioned in Section 1.1):

```
# load the 15 Shiraishi signatures obtained from
# 435 tumor genomes from Alexandrov et al.
sfile <- system.file("extdata",
              "Alexandrov_PMID_23945592_435_tumors-pmsignature-15sig.Rdata",
              package="decompTumor2Sig")
load(sfile)
length(signatures)
```

```
## [1] 15
```

```
signatures[1]
```

```
## [[1]]
##              [,1]         [,2]         [,3]       [,4]      [,5]      [,6]
## [1,] 6.431522e-13 2.320704e-02 2.293643e-79 0.64050260 0.1876257 0.1486647
## [2,] 2.916982e-01 2.059223e-01 2.043698e-01 0.29800971 0.0000000 0.0000000
## [3,] 2.239856e-01 4.126288e-01 1.982799e-01 0.16510571 0.0000000 0.0000000
## [4,] 9.822384e-02 7.036368e-14 8.147461e-01 0.08703009 0.0000000 0.0000000
## [5,] 2.524624e-01 1.965627e-01 2.681366e-01 0.28283839 0.0000000 0.0000000
## [6,] 4.422814e-01 5.577186e-01 0.000000e+00 0.00000000 0.0000000 0.0000000
```

This loads an object *signatures* with 15 Shiraishi signatures for mutated
subsequences of length 5 (five nucleotides with the mutated base at the center)
and taking transcription direction into account.

Now read the tumor genomes (object *genomes*) provided with this package, as
described in Section 3.2.1:

```
# load the reference genome and the transcript annotation database
refGenome <- BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
transcriptAnno <-
           TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene

# take six breast cancer genomes from Nik-Zainal et al (PMID: 22608084)
gfile <- system.file("extdata",
                     "Nik-Zainal_PMID_22608084-VCF-convertedfromMPF.vcf.gz",
                     package="decompTumor2Sig")

# read the cancer genomes in VCF format
genomes <- readGenomesFromVCF(gfile, numBases=5, type="Shiraishi",
                              trDir=TRUE, refGenome=refGenome,
                              transcriptAnno=transcriptAnno, verbose=FALSE)
```

### 4.2.2 Example: plot the explained variance

The explained variance can be plotted only for a single tumor genome. Plotting
the explained variance of the first tumor genome when using increasing subsets
of the 15 mutational signatures (see above), for example, can be done with the
following command:

```
plotExplainedVariance(genomes[[1]], signatures, minExplainedVariance=0.9,
                                    minNumSignatures=2, maxNumSignatures=NULL,
                                    greedySearch=TRUE)
```

![](data:image/png;base64...)

The function **plotExplainedVariance()** takes the following arguments:

* *genome*: The mutation frequencies of a single tumor genome (according to the
  Alexandrov or Shiraishi model).
* *signatures*: The set of given signatures (must be of the same model as the
  genome).
* *minExplainedVariance* (default is NULL): If specified, the smallest subset of
  signatures necessary to explain at least this fraction of the variance is
  highlighted in red (including the list of the signatures in the subset).
* *minNumSignatures* (default is 2): Take at least this minimum number of
  signatures.
* *maxNumSignatures* (default is NULL, i.e., all): If specified, take at most
  this maximum number of signatures.
* *greedySearch* (default is FALSE): If FALSE, the function will evaluate for
  each number of signatures *K* **all** possible subsets of *K* signatures to
  compute the highest explained variance for *K*. This can take very long if
  the total number of given signatures is too high. If TRUE, first, all possible
  subsets with *K*=*minNumSignatures* are evaluated, taking the subset with the
  highest explained variance, then stepwise one additional signature (highest
  increase in explained variance) is added to the already identified set. This
  approximation is much faster but not guaranteed to plot the maximum explained
  variance for all *K* (a greedy search can get stuck in a local optimum).

## 4.3 Decomposing tumor genomes by signature refitting (contribution prediction)

This is the heart of the functionality of **decompTumor2Sig**, its main purpose.

Given a tumor genome and a set of mutational signatures (that represent
mutational processes like UV light, smoking, etc; see Alexandrov and Stratton,
Curr Opin Genet Dev 24:52-60, 2014), we would like to estimate how strongly the
different signatures (processes) contributed to the overall mutational load
observed in the tumor. To this end **decompTumor2Sig** relies on quadratic
programming. For details, see our paper (Krüger and Piro, 2019).

The result will be a vector of weights/contributions (or “exposures”) which
indicate the fractions or percentages of somatic mutations which can likely be
attributed to the given signatures.

Lets take, for instance, the signature and tumor data used for the example in
Section 4.2 (see there).

To compute the contributions of the 15 given signatures to the first tumor
genome, we can run the following command …

```
exposure <- decomposeTumorGenomes(genomes[1], signatures)
```

… and get the following *exposures* (contributions) for the 15 signatures:

```
exposure
```

```
## $PD3851a
##       sign_1       sign_2       sign_3       sign_4       sign_5       sign_6
## 4.495582e-02 7.426070e-02 7.760594e-02 8.249303e-02 3.531049e-18 1.508181e-01
##       sign_7       sign_8       sign_9      sign_10      sign_11      sign_12
## 5.730916e-02 5.284764e-02 1.180648e-02 1.194834e-01 5.339398e-02 2.019268e-02
##      sign_13      sign_14      sign_15
## 4.052508e-02 1.777675e-01 3.654057e-02
```

The exposures/contributions for a single tumor genome can also be plotted:

```
plotDecomposedContribution(exposure)
```

![](data:image/png;base64...)

In some cases, multiple tumor genomes need to be decomposed (each one, however,
individually). In this case, a set of tumor genomes can be passed to
**decomposeTumorGenomes()**:

```
exposures <- decomposeTumorGenomes(genomes, signatures)
length(exposures)
```

```
## [1] 6
```

```
exposures[1:2]
```

```
## $PD3851a
##       sign_1       sign_2       sign_3       sign_4       sign_5       sign_6
## 4.495582e-02 7.426070e-02 7.760594e-02 8.249303e-02 3.531049e-18 1.508181e-01
##       sign_7       sign_8       sign_9      sign_10      sign_11      sign_12
## 5.730916e-02 5.284764e-02 1.180648e-02 1.194834e-01 5.339398e-02 2.019268e-02
##      sign_13      sign_14      sign_15
## 4.052508e-02 1.777675e-01 3.654057e-02
##
## $PD3890a
##       sign_1       sign_2       sign_3       sign_4       sign_5       sign_6
## 1.434312e-02 1.551043e-02 1.054064e-01 8.534005e-02 1.975746e-02 2.107229e-01
##       sign_7       sign_8       sign_9      sign_10      sign_11      sign_12
## 6.480260e-02 7.096824e-02 1.135356e-01 1.541128e-01 3.890686e-02 1.096395e-21
##      sign_13      sign_14      sign_15
## 3.565470e-02 6.418963e-02 6.749179e-03
```

**decompTumor2Sig** provides an additional function that can be used to verify
whether a list object is of the same format as it is returned by
**decomposeTumorGenomes()**:

```
isExposureSet(exposures)
```

```
## [1] TRUE
```

### 4.3.1 Finding a subset of signatures with a minimum explained variance

Instead of decomposing a tumor genome precisely into the given set of signatures
(15 in the example above), the function **decomposeTumorGenomes()** can
alternatively be used to search for subsets of signatures for which the
decomposition satisfies a minimum threshold of explained variance (here, we
show this only for the first tumor):

```
exposures <- decomposeTumorGenomes(genomes[1], signatures,
                                   minExplainedVariance=0.9,
                                   minNumSignatures=2, maxNumSignatures=NULL,
                                   greedySearch=FALSE, verbose=TRUE)
```

```
## Decomposing genome 1 (PD3851a) with 2 signatures ...
##  with 3 signatures ...
##  with 4 signatures ...
##  with 5 signatures ...
##  with 6 signatures ...
##  with 7 signatures ...
##  explained variance: 0.905904806137512
```

For each tumor genome, the minimum subset of signatures that explain at least
*minExplainedVariance* percent of the variance of the mutation frequencies will
be identified (the exposures of all other signatures will be set to NA):

```
exposures
```

```
## $PD3851a
##     sign_1     sign_2     sign_3     sign_4     sign_5     sign_6     sign_7
## 0.05515517         NA 0.12565887 0.16254156         NA 0.24598593         NA
##     sign_8     sign_9    sign_10    sign_11    sign_12    sign_13    sign_14
##         NA         NA 0.15050904 0.08686977         NA         NA 0.17327967
##    sign_15
##         NA
```

```
plotDecomposedContribution(exposures[[1]])
```

![](data:image/png;base64...)

[If **plotDecomposedContribution()** is run with *removeNA=FALSE*, also
signatures with an NA value as exposure will be included in the x-axis of the
plot. Additionally, the signatures can be passed to the function using the
parameter *signatures*; if so, signature names for the plot will be taken
from this object, otherwise they are inferred from the exposure object or
set sign\_1 to sign\_N.]

**Important note**: although a subset of signatures may explain the somatic
mutations observed in the tumor genomes reasonably well, they need not
necessarily be the signatures with the highest contribution when taking the
entire set of signatures (e.g., due to a greedy search which can get stuck in
a local optimum).

**Important note**: if for a tumor genome no (sub)set of signatures is
sufficient to explain at least *minExplainedVariance* percent of the variance,
no result (NULL) is returned for that tumor.

The search behavior of **decomposeTumorGenomes()** when finding a subset of
signatures to explain the somatic mutations of a tumor can be influenced by the
following arguments:

* *minExplainedVariance* (default is NULL): If not specified, exactly
  *maxNumSignatures* (see below; default: all) will be taken for decomposing
  each genome; if specified (between 0 and 1), the smallest subset of signatures
  which explains at least *minExplainedVariance* of the variance is taken for
  the decomposition.
* *minNumSignatures* (default is 2): If a search for a subset of signatures is
  performed, at least *minNumSignatures* will be taken.
* *maxNumSignatures* (default is NULL, i.e., all): If a search for a subset of
  signatures is performed, at most *maxNumSignatures* will be taken; if NULL, all
  given signatures will be taken as the maximum; if *maxNumSignatures* is
  specified but *minExplainedVariance=NULL* (no search), then exactly the best
  *maxNumSignatures* will be taken.
* *greedySearch* (default is FALSE): If FALSE, a full search will be performed:
  for increasing numbers *K* of signatures, *all* possible subsets of *K*
  signatures will be tested and the subset with the highest explained variance is
  chosen, increasing *K* until the threshold of *minExplainedVariance* is
  satisfied; if TRUE, a much faster, greedy search is performed: first, all
  possible subsets with *K*=*minNumSignatures* are evaluated, taking the subset
  with the highest explained variance. Then, stepwise one additional signature at
  a time (highest increase in explained variance) is added to the already
  identified set until the threshold of *minExplainedVariance* is satisfied.

Performing, for example, a greedy search for the example above is much faster
(shown only for the first tumor):

```
exposures <- decomposeTumorGenomes(genomes[1], signatures,
                                   minExplainedVariance=0.95,
                                   minNumSignatures=2, maxNumSignatures=NULL,
                                   greedySearch=TRUE, verbose=TRUE)
```

```
## Decomposing genome 1 (PD3851a) with 2 signatures ...
##  adding signature 3 ...
##  adding signature 4 ...
##  adding signature 5 ...
##  adding signature 6 ...
##  adding signature 7 ...
##  adding signature 8 ...
##  adding signature 9 ...
##  adding signature 10 ...
##  adding signature 11 ...
##  explained variance: 0.962669699438027
```

```
exposures
```

```
## $PD3851a
##     sign_1     sign_2     sign_3     sign_4     sign_5     sign_6     sign_7
## 0.04283316 0.10069647 0.05982230 0.06266320         NA 0.16420867 0.13212398
##     sign_8     sign_9    sign_10    sign_11    sign_12    sign_13    sign_14
## 0.05201885 0.01760993 0.12385198         NA         NA 0.06274297 0.18142848
##    sign_15
##         NA
```

```
plotDecomposedContribution(exposures[[1]])
```

![](data:image/png;base64...)

**Important note**: of course, a greedy search which starts from the best
combination of *minNumSignatures* need not yield the same result as a full
search because the latter finds the overall best subset while the greedy search
can get stuck in a local optimum depending on the starting point of the search.
The precise behavior depends on different factors, including for example the
similarity between mutational signatures and the minimum required explained
variance (lower thresholds can easily be satisfied by very different
combinations of signatures). We recommend to test different settings (minimum
numbers of signatures, thresholds for explained variance, etc) and learn about
the behavior to ensure a meaningful biological interpretation of the results.

### 4.3.2 Computing the explained variance

Given the mutation frequencies of one or more tumor genomes (*genomes*),
a set of mutational signatures (*signatures*) and their computed
exposures/contributions to the given tumor (*exposures*), the following command
allows to compute—for each individual tumor—the variance of the mutation
frequency data that the exposures explain.

The following is an example taking the full set of tumors and signatures from
Section 4.2.1:

```
exposures <- decomposeTumorGenomes(genomes, signatures)
computeExplainedVariance(exposures, signatures, genomes)
```

```
##   PD3851a   PD3890a   PD3904a   PD3905a   PD3945a   PD4005a
## 0.9798729 0.9733882 0.9890555 0.9742396 0.9875022 0.9945690
```

**Note**: for computing the variance explained for a single tumor by a set of
signatures, the corresponding number of exposure values must be the same as the
number of signatures. Undefined exposure values (NA), which can be present if a
search for a subset of signatures has been performed as described above, will
be set to zero such that the corresponding signature does not contribute. For
genomes for which the *minExplainedVariance* could not be reached, and whose
exposure vectors are NULL, the explained variance will be set to NA.

## 4.4 Re-composing/reconstructing tumor genomes from exposures and signatures

Estimating the explained variance of the decomposition of a tumor genome (see
Sections 4.2 and 4.3.2) and assessing its quality requires the mutation
frequencies \(\hat{g}\_i\) of the tumor genome to be reconstructed, or predicted,
from the mutational signatures \(S\_j\) and their exposures/contributions (or
weights) \(w\_j\):

\[ \hat{g}\_i = \sum\_j{w\_j \* (S\_j)\_i} \]

This can be easily achieved using the function
**composeGenomesFromExposures()**. The following is an example taking the
tumor genomes from Section 3.2, the signatures from Section 4.2.1, and the
exposures as computed in Section 4.3:

```
genomes_predicted <- composeGenomesFromExposures(exposures, signatures)
genomes_predicted[1:2]
```

```
## $PD3851a
##         [C>A]      [C>G]     [C>T]     [T>A]     [T>C]      [T>G]
## mut 0.1893015 0.09949175 0.3389973 0.1315873 0.1556982 0.08492401
## -2  0.2858727 0.21814934 0.1947900 0.3011880 0.0000000 0.00000000
## -1  0.2800391 0.24522933 0.1887900 0.2859416 0.0000000 0.00000000
## +1  0.2695376 0.20268205 0.2479661 0.2798143 0.0000000 0.00000000
## +2  0.2805259 0.21005872 0.2039384 0.3054769 0.0000000 0.00000000
## tr  0.4753554 0.52464458 0.0000000 0.0000000 0.0000000 0.00000000
##
## $PD3890a
##         [C>A]     [C>G]     [C>T]     [T>A]     [T>C]     [T>G]
## mut 0.1642222 0.2128977 0.2388057 0.1306610 0.1388469 0.1145665
## -2  0.2885812 0.2144737 0.1844987 0.3124464 0.0000000 0.0000000
## -1  0.2384285 0.2117097 0.1735473 0.3763144 0.0000000 0.0000000
## +1  0.2840119 0.2143525 0.1464350 0.3552006 0.0000000 0.0000000
## +2  0.2968944 0.1899231 0.1989717 0.3142108 0.0000000 0.0000000
## tr  0.4964684 0.5035316 0.0000000 0.0000000 0.0000000 0.0000000
```

Once genomes have been reconstructed, the function
**evaluateDecompositionQuality()** allows to compare the reconstructed genome
mutation features to the originally observed features in order to assess the
quality of the decomposition. The function is applied to an individual tumor
genome, and can either return numerical quality measurements, or provide a
quality plot which includes said measurements.

Numerical measurements to compare the reconstructed/predicted and the original
tumor mutation patterns are:

* *explainedVariance*: The explained variance (see Section 4.2).
* *pearsonCorr*: The Pearson correlation coefficient (PCC) between the
  predicted/reconstructed and the original mutation frequencies of the tumor
  genome. Although the PCC does usually not consider the amplitudes of two input
  data vectors—only their linear relationship—here, a high PCC also entails
  small absolute differences in the mutation frequencies because the frequencies
  in both the predicted and the original data sum up to 1 (i.e., they are
  normalized at the same level), such that a high correlation automatically means
  very similar values.

Example for obtaining numerical measurements:

```
evaluateDecompositionQuality(exposures[[1]], signatures,
                             genomes[[1]], plot=FALSE)
```

```
## $explainedVariance
## [1] 0.9798729
##
## $pearsonCorr
## [1] 0.99901
```

Example for obtaining a quality plot which compares the reconstructed and the
original data:

```
evaluateDecompositionQuality(exposures[[1]], signatures,
                             genomes[[1]], plot=TRUE)
```

![](data:image/png;base64...)

## 4.5 Mapping and comparing sets of signatures

In some cases it may be of interest to compare or find a mapping between two
sets of signatures, e.g., if they have been inferred from different datasets.
For this purpose, **decompTumor2Sig** provides a set of additional functions.

### 4.5.1 Comparison of signatures of the same format

Let’s first read two distinct sets of Shiraishi signatures of the same format
(5 bases, with transcript-strand direction):

```
# get 4 Shiraishi signatures from 21 breast cancers from
# Nik-Zainal et al (PMID: 22608084)
sigfiles <- system.file("extdata",
                 paste0("Nik-Zainal_PMID_22608084-pmsignature-sig",1:4,".tsv"),
                 package="decompTumor2Sig")
sign_s4 <- readShiraishiSignatures(files=sigfiles)

# get 15 Shiraishi signatures obtained from
# 435 tumor genomes from Alexandrov et al.
sfile <- system.file("extdata",
              "Alexandrov_PMID_23945592_435_tumors-pmsignature-15sig.Rdata",
              package="decompTumor2Sig")
load(sfile)
sign_s15 <- signatures
```

Since these signatures have the same format, we can directly compare them.
Using the function **determineSignatureDistances()**, we can compute the
distances of one given signature to all target signatures from a set:

```
determineSignatureDistances(fromSignature=sign_s4[[1]], toSignatures=sign_s15,
                            method="frobenius")
```

```
##    sign_1    sign_2    sign_3    sign_4    sign_5    sign_6    sign_7    sign_8
## 0.7585028 1.1070702 1.1324959 0.7741531 1.2625974 0.9338330 0.6743049 1.0077730
##    sign_9   sign_10   sign_11   sign_12   sign_13   sign_14   sign_15
## 1.5575345 1.2758753 1.1879876 1.2602450 1.0191394 0.6792248 1.0914233
```

Apart from the Frobenius distance (*method*=“frobenius”), which is suitable to
compare matrices and hence Shiraishi signatures, other distance metrics can be
used: the “rss” (residual sum of squares = squared error) or any distance
measure available for the function *dist* of the package *stats*.

If not the distances of one signature to an entire signature set is needed, but
instead a mapping from one signature set to another, **mapSignatureSets()** can
be used.

```
mapSignatureSets(fromSignatures=sign_s4, toSignatures=sign_s15,
                 method="frobenius", unique=FALSE)
```

```
## Nik-Zainal_PMID_22608084-pmsignature-sig1.tsv
##                                      "sign_7"
## Nik-Zainal_PMID_22608084-pmsignature-sig2.tsv
##                                      "sign_9"
## Nik-Zainal_PMID_22608084-pmsignature-sig3.tsv
##                                      "sign_6"
## Nik-Zainal_PMID_22608084-pmsignature-sig4.tsv
##                                     "sign_12"
```

Like for **determineSignatureDistances()**, with the function
**mapSignatureSets()** a mapping can be built based on different distance
metrics. Additionally, the user can specify whether the mapping should be
unique (one-to-one mapping), or not.

If *unique*=FALSE then for each signature of *fromSignatures* the best match
(minimum distance) of *toSignatures* is selected. The selected signatures
need not be unique, i.e., one signature of *toSignatures* may be the best match
for multiple signatures of *fromSignatures*.

If *unique*=TRUE, i.e., if a unique (one-to-one) mapping is required, an
iterative procedure is performed: in each step, the best matching pair from
*fromSignatures* and *toSignatures* is mapped and then removed from the list of
signatures that remain to be mapped, such that they cannot be selected again.
In this case, of course, *fromSignatures* must not contain more signatures than
*toSignatures*.

### 4.5.2 Comparison of signatures of different types or formats

Sometimes it may also be useful to compare different types or formats of
signatures. For example, since Alexandrov signatures are comparably well
studied, it might be interesting to determine which Alexandrov signature is
closest to a Shiraishi signature of interest.

Since only signatures of the same format can be directly compared or mapped
(see above), **decompTumor2Sig** provides two functions that transform
signatures, such that two signatures, or two sets of signatures, can be
converted to the same format.

One of these functions, **convertAlexandrov2Shiraishi()**, has already been
presented in Section 3.1.4 (see there for details). We can convert Alexandrov
signatures to Shiraishi-type signatures with 3 bases (without
transcription-strand direction):

```
sign_a <- readAlexandrovSignatures()
sign_a2s <- convertAlexandrov2Shiraishi(sign_a)
```

*Note*: Of course, there is some information loss here (better: a loss of
specificity), as we discuss in our paper (Krüger and Piro, 2019).

Additionally, the function **downgradeShiraishiSignatures()** can be used to
reduce the number of flanking bases and/or discard the information on
transcription-strand direction from one or more Shiraishi signatures:

```
sign_sdown <- downgradeShiraishiSignatures(sign_s15, numBases=3,
                                           removeTrDir=TRUE)
sign_s15[1]
```

```
## [[1]]
##              [,1]         [,2]         [,3]       [,4]      [,5]      [,6]
## [1,] 6.431522e-13 2.320704e-02 2.293643e-79 0.64050260 0.1876257 0.1486647
## [2,] 2.916982e-01 2.059223e-01 2.043698e-01 0.29800971 0.0000000 0.0000000
## [3,] 2.239856e-01 4.126288e-01 1.982799e-01 0.16510571 0.0000000 0.0000000
## [4,] 9.822384e-02 7.036368e-14 8.147461e-01 0.08703009 0.0000000 0.0000000
## [5,] 2.524624e-01 1.965627e-01 2.681366e-01 0.28283839 0.0000000 0.0000000
## [6,] 4.422814e-01 5.577186e-01 0.000000e+00 0.00000000 0.0000000 0.0000000
```

```
sign_sdown[1]
```

```
## [[1]]
##            [C>A]        [C>G]        [C>T]      [T>A]     [T>C]     [T>G]
## mut 6.431522e-13 2.320704e-02 2.293643e-79 0.64050260 0.1876257 0.1486647
## -1  2.239856e-01 4.126288e-01 1.982799e-01 0.16510571 0.0000000 0.0000000
## +1  9.822384e-02 7.036368e-14 8.147461e-01 0.08703009 0.0000000 0.0000000
```

Having obtained two signature sets of the same format (sequence triplets, but
no transcription-strand direction), we can now map one set to the other:

```
mapSignatureSets(fromSignatures=sign_sdown, toSignatures=sign_a2s,
                 method="frobenius", unique=TRUE)
```

```
##         sign_1         sign_2         sign_3         sign_4         sign_5
## "Signature.22"  "Signature.4" "Signature.10"  "Signature.5" "Signature.15"
##         sign_6         sign_7         sign_8         sign_9        sign_10
##  "Signature.8" "Signature.26" "Signature.28" "Signature.13" "Signature.30"
##        sign_11        sign_12        sign_13        sign_14        sign_15
## "Signature.24"  "Signature.2" "Signature.18"  "Signature.1" "Signature.12"
```