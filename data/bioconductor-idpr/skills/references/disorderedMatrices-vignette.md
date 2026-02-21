# Disordered Matrices Vignette

#### William McFadden

#### 2025-10-30

# Substitution Matrices for Intrinsically Disordered Proteins

## Quick Intro

Intrinsically Disordered Proteins (IDPs) have many distinct properties compared to structured proteins, such as amino acid composition and rate of evolution. The most commonly used amino acid substitution matrices (PAM and BLOSUM) are derived from or favor structured proteins and therefore are not the most appropriate to use when analyzing IDPs. The following amino acid substitution matrices are derived from sets of IDPs and thus, are more appropriate.

A detailed comparison is available at [Trivedi & Nagarajaram, 2019](https://doi.org/10.1038/s41598-019-52532-8).
Additionally, see the documentation for each matrix for quick information about the derivation and use of each matrix.

The following matrices are available within **idpr**:

* EDSS Matrices ([Trivedi & Nagarajaram, 2019](https://doi.org/10.1038/s41598-019-52532-8))
  + EDSSMat50
  + EDSSMat60
  + **EDSSMat62**
  + EDSSMat70
  + EDSSMat75
  + EDSSMat80
  + EDSSMat90
* “Disorder” Matrices ([Brown et al., 2009](https://doi.org/10.1093/molbev/msp277))
  + **Disorder40**
  + Disorder60
  + **Disorder85**
* DUNMat ([Radivojac et al., 2001](https://doi.org/10.1142/9789812799623_0055))
  + DUNMat

*Bolded Matrices are the best-preforming*

---

## Installation

The idpr package can be installed from Bioconductor with the following line of code. It requires the BiocManager package to be installed

```
#BiocManager::install("idpr")
```

The most recent version of the package can be installed with the following line of code. This requires the devtools package to be installed.

```
#devtools::install_github("wmm27/idpr")
```

To access the matrices, the **idpr** package needs to be loaded

```
library(idpr)
```

## Background and Motivation

It has been shown that solvent-exposed amino acids experience higher levels of evolution compared to the internal residues of a protein ( [Franzosa & Xia, 2009](https://doi.org/10.1093/molbev/msp146)). Intrinsically Disordered Proteins (IDPs) and Intrinsically Disordered Regions (IDRs) are, by definition, more solvent exposed. One can predict that these proteins have accelerated evolution, and this has been observed ( [Brown et al., 2011](https://doi.org/10.1016/j.sbi.2011.02.005)).

Additionally, a study that compared proteins with both ordered and disordered regions showed the IDRs, on average, evolved at faster rates than the ordered regions ( [Brown et al., 2002](https://doi.org/10.1016/j.sbi.2011.02.005)).

The most commonly used amino acid substitution matrices are BLOSUM and PAM. These are currently the only accepted matrices for NCBI BLAST ( [Johnson et al., 2008](https://doi.org/10.1093/nar/gkn201)), as well as EMBOSS Needle and EMBOSS Water web serveries ( [Madeira et al., 2019](http://doi.org/10.1093/nar/gkz268)).

The sequences used to calculate the values for both of these matrices are from highly conserved protein families (Dayhoff et al. 1978; [Henikoff & Henikoff, 1992](https://doi.org/10.1073/pnas.89.22.10915)). While they do not explicitly exclude IDPs, the sequences used for analysis are enriched in highly-ordered proteins. Structured proteins have served as the basis for sequence-level comparisons due to their residue and position conservation. IDPs do not experience the same level of residue-identity conservation that has been observed in proteins with a specific, well-folded structure. IDPs often conserve the overall chemistry and the disordered state of the protein, but are less conserved at the residue and position level. Therefore using BLOSUM or PAM for studies comparing IDP evolution is not the most appropriate method, since these matrices account for the evolutionary observations of ordered proteins ( [Brown et al., 2011](https://doi.org/10.1016/j.sbi.2011.02.005)).

Additionally, the amino acid composition and accepted point mutations for IDPs differ compared to structured proteins. IDPs and IDRs tend to be enriched in hydrophillic and charged residues ( [Uversky, 2019](https://doi.org/10.3389/fphy.2019.00010)). In addition to a distinct composition, IDPs tend to accept indels at higher rates ( [Brown et al., 2011](https://doi.org/10.1016/j.sbi.2011.02.005)).

Therefore, there are multiple reasons as to why BLOSUM and PAM matrices do not accurately assess the evolutionary history of IDPs. The works of [Trivedi & Nagarajaram, 2019](https://doi.org/10.1038/s41598-019-52532-8), [Brown et al., 2009](https://doi.org/10.1093/molbev/msp277), and [Radivojac et al., 2001](https://doi.org/10.1142/9789812799623_0055) can serve as references for IDP-based substitution matrices. Each use experimentally confirmed or computationally predicted IDPs to create the data set of protein sequences and protein families to calculate the accepted point mutations specific to disordered sequences. These are the EDSSMat set of matrices, the “Disorder” set of matrices, and the DUNMat matrix.

Unlike most commonly used web-based tools, many sequence comparison functions within other R packages allow for custom substitution matrices. **idpr** has added 11 disorder-based substitution matrices for IDP sequence conservation studies for user convenience.

[Trivedi & Nagarajaram, 2019](https://doi.org/10.1038/s41598-019-52532-8) provides many details for comparing the EDSSMat matrices to the other disorder matrices and other matrices like BLOSUM and PAM within sequence alignments. The paper also calculated the optimal gap parameters for sequence alignments depending on how disordered the aligned sequences were predicted to be. Protein families were sorted into 3 categories: Proteins containing Less Disorder (LD), defined as [0-20%] disorder, Moderate Disorder (MD), defined as (20-40%] disorder, and High Disorder (HD), defined as (40-100%] disorder.

Additionally, EDSSMat62 was shown to identify both close and distant homologs of a specific IDP while other matrices could only identify some close homologs. Please see [Trivedi & Nagarajaram, 2019](https://doi.org/10.1038/s41598-019-52532-8)
for additional information and for comparisons to other matrices.

## Matrices

### EDSS Matrices

EDSSMat62, like the other EDSS matrices, is derived from alignment blocks of computationally predicted IDPs. [Trivedi & Nagarajaram, 2019](https://doi.org/10.1038/s41598-019-52532-8)
go into detail of methods and comparisons. EDSSMat62 is the best preforming matrix in their study and was shown to identify both close and distant homologs of Secretogranin-1, an IDP, while other matrices could only identify some close homologs. On average, EDSSMat62 attained smaller E-values when aligning Highly Disordered (HD) proteins compared to BLOSUM and PAM matrices, and against some other disorder-based substitution matrices.

EDSS Matrices are symmetric, 24x24 matrices. They contain the 20 standard amino acids and 4 ambiguous residues: B, Asparagine or Aspartic Acid (Asx); Z, Glutamine or Glutamic Acid (Glx); X, Unspecified or unknown amino acid; and \*, Stop.

```
EDSSMat62
#>    A  R  N  D  C  Q  E  G  H  I  L  K  M  F  P  S  T  W  Y  V  B  Z  X  *
#> A  4 -3 -2 -2 -1 -2 -2  0 -2 -1 -2 -2 -1 -2 -1  0  1 -4 -3  1 -2 -2 -1 -4
#> R -3  6 -2 -4 -1  0 -3 -2  0 -3 -3  1 -2 -3 -3 -2 -3  0 -2 -3 -3 -2 -2 -4
#> N -2 -2  6  0 -1 -1 -2 -1  1 -2 -3 -1 -3 -3 -3  0  0 -3 -1 -2  3 -2 -1 -4
#> D -2 -4  0  6 -3 -2  2 -1 -2 -4 -4 -3 -4 -4 -4 -2 -3 -4 -2 -3  3  0 -2 -4
#> C -1 -1 -1 -3 12 -3 -4  0  0 -1 -1 -4 -2  1 -2  0 -2  2  3  0 -2 -4  0 -4
#> Q -2  0 -1 -2 -3  6 -1 -3  2 -2 -1  0 -1 -3 -1 -2 -2 -2 -2 -2 -2  2 -1 -4
#> E -2 -3 -2  2 -4 -1  5 -2 -2 -3 -4 -1 -4 -4 -3 -3 -2 -4 -4 -2  0  2 -2 -4
#> G  0 -2 -1 -1  0 -3 -2  5 -2 -3 -4 -3 -3 -4 -3 -1 -2 -3 -3 -1 -1 -2 -2 -4
#> H -2  0  1 -2  0  2 -2 -2  8 -2 -1 -2 -2  0 -1 -2 -2 -2  2 -3  0  0 -1 -4
#> I -1 -3 -2 -4 -1 -2 -3 -3 -2  8  2 -3  3  1 -3 -2  0 -2 -1  3 -3 -2 -1 -4
#> L -2 -3 -3 -4 -1 -1 -4 -4 -1  2  7 -3  2  2 -1 -2 -2 -1 -1  1 -4 -2 -1 -4
#> K -2  1 -1 -3 -4  0 -1 -3 -2 -3 -3  6 -2 -4 -3 -3 -2 -4 -4 -3 -2  0 -2 -4
#> M -1 -2 -3 -4 -2 -1 -4 -3 -2  3  2 -2  9  0 -3 -2  0 -2 -2  2 -4 -2 -1 -4
#> F -2 -3 -3 -4  1 -3 -4 -4  0  1  2 -4  0 10 -3 -2 -2  1  4  0 -4 -4 -1 -4
#> P -1 -3 -3 -4 -2 -1 -3 -3 -1 -3 -1 -3 -3 -3  4 -1 -1 -4 -3 -2 -4 -2 -2 -4
#> S  0 -2  0 -2  0 -2 -3 -1 -2 -2 -2 -3 -2 -2 -1  4  0 -3 -2 -2 -1 -2 -1 -4
#> T  1 -3  0 -3 -2 -2 -2 -2 -2  0 -2 -2  0 -2 -1  0  5 -4 -3  0 -2 -2 -1 -4
#> W -4  0 -3 -4  2 -2 -4 -3 -2 -2 -1 -4 -2  1 -4 -3 -4 14  2 -2 -4 -3 -1 -4
#> Y -3 -2 -1 -2  3 -2 -4 -3  2 -1 -1 -4 -2  4 -3 -2 -3  2 11 -1 -2 -3 -1 -4
#> V  1 -3 -2 -3  0 -2 -2 -1 -3  3  1 -3  2  0 -2 -2  0 -2 -1  6 -2 -2 -1 -4
#> B -2 -3  3  3 -2 -2  0 -1  0 -3 -4 -2 -4 -4 -4 -1 -2 -4 -2 -2  3  3  0 -4
#> Z -2 -2 -2  0 -4  2  2 -2  0 -2 -2  0 -2 -4 -2 -2 -2 -3 -3 -2  3  2  0 -4
#> X -1 -2 -1 -2  0 -1 -2 -2 -1 -1 -1 -2 -1 -1 -2 -1 -1 -1 -1 -1  0  0 -1 -4
#> * -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4 -4  1
```

### “Disorder” Matrices

In their study, [Trivedi & Nagarajaram, 2019](https://doi.org/10.1038/s41598-019-52532-8) show that the Disorder40 and Disorder85 matrices, on average, score lower E-values for the HD proteins. EDSSMat62 on average attains lower E-values for the Low and Medium disordered proteins. The “Disorder” matrices are from [Brown et al., 2009](https://doi.org/10.1093/molbev/msp277), which identified protein families based on homology to experimentally confirmed IDPs. The “Disorder” matrices were not designed with the goal of improving sequence alignments. The authors note that the purpose of these matrices were to compare evolutionary characteristics of disordered and ordered proteins. Therefore information for using these in sequence alignments, like gap scores and entropy, are not provided by the original authors.
[Trivedi & Nagarajaram, 2019](https://doi.org/10.1038/s41598-019-52532-8) determined the optimal gap parameters for these matrices to compare against EDSSMat62.

Disorder40, Disorder60, and Disorder85 are symmetric, 24x24 matrices. They contain the 20 standard amino acids and 4 ambiguous residues: B, Asparagine or Aspartic Acid (Asx); Z, Glutamine or Glutamic Acid (Glx); X, Unspecified or unknown amino acid; and \*, Stop.

```
Disorder40
#>     A   R   N   D   C   Q   E   G   H   I   L   K   M   F   P   S   T   W   Y
#> A   5  -3  -3  -2   1  -1  -2  -2  -3  -3  -3  -2  -2  -4   0   1   0  -6  -4
#> R  -3   7  -3  -4  -1   0  -3  -4   0  -4  -3   2  -2  -5  -3  -2  -1  -2  -2
#> N  -3  -3   6   0  -2  -2  -4  -3  -1  -2  -5  -2  -3  -4  -6   0  -1  -5  -2
#> D  -2  -4   0   6  -5  -2   2  -4  -2  -6  -6  -2  -5  -6  -4  -2  -2  -9  -5
#> C   1  -1  -2  -5  12  -4  -7  -5  -1  -1  -1  -4  -1  -1  -5   0   0   0   0
#> Q  -1   0  -2  -2  -4   6   0  -4   1  -4  -2   0  -2  -3   0  -2  -1  -4  -2
#> E  -2  -3  -4   2  -7   0   5  -6  -4  -5  -5  -1  -5  -6  -4  -3  -3  -9  -6
#> G  -2  -4  -3  -4  -5  -4  -6   5  -3 -10 -10  -6  -5  -6  -5   0  -4  -1  -2
#> H  -3   0  -1  -2  -1   1  -4  -3   9  -5  -2  -1  -2   1  -3  -2  -2   1   3
#> I  -3  -4  -2  -6  -1  -4  -5 -10  -5   7   3  -3   2   0  -5  -5  -1  -4  -3
#> L  -3  -3  -5  -6  -1  -2  -5 -10  -2   3   7  -3   3   1  -3  -4  -2  -2  -2
#> K  -2   2  -2  -2  -4   0  -1  -6  -1  -3  -3   6  -3  -5  -3  -2  -1  -4  -4
#> M  -2  -2  -3  -5  -1  -2  -5  -5  -2   2   3  -3   9   0  -5  -3  -1  -2  -3
#> F  -4  -5  -4  -6  -1  -3  -6  -6   1   0   1  -5   0   9  -5  -3  -2   2   5
#> P   0  -3  -6  -4  -5   0  -4  -5  -3  -5  -3  -3  -5  -5   6  -1  -1  -8  -4
#> S   1  -2   0  -2   0  -2  -3   0  -2  -5  -4  -2  -3  -3  -1   5   2  -4  -1
#> T   0  -1  -1  -2   0  -1  -3  -4  -2  -1  -2  -1  -1  -2  -1   2   6  -6  -3
#> W  -6  -2  -5  -9   0  -4  -9  -1   1  -4  -2  -4  -2   2  -8  -4  -6  13   3
#> Y  -4  -2  -2  -5   0  -2  -6  -2   3  -3  -2  -4  -3   5  -4  -1  -3   3   9
#> V   0  -3  -5  -5   0  -3  -3  -7  -3   4   1  -3   1  -1  -3  -3   1  -5  -1
#> B  -2  -2   2  -1  -3   2  -2  -4   0  -3  -4  -1  -3  -4  -3  -1  -1  -5  -2
#> Z  -2  -4  -2   4  -6  -1   4  -5  -3  -6  -6  -2  -5  -6  -4  -3  -3  -9  -6
#> X   0  -1  -1  -1  -2  -1  -1  -1  -1  -1  -1  -1   0  -1  -2   0   0  -2  -1
#> * -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10
#>     V   B   Z   X   *
#> A   0  -2  -2   0 -10
#> R  -3  -2  -4  -1 -10
#> N  -5   2  -2  -1 -10
#> D  -5  -1   4  -1 -10
#> C   0  -3  -6  -2 -10
#> Q  -3   2  -1  -1 -10
#> E  -3  -2   4  -1 -10
#> G  -7  -4  -5  -1 -10
#> H  -3   0  -3  -1 -10
#> I   4  -3  -6  -1 -10
#> L   1  -4  -6  -1 -10
#> K  -3  -1  -2  -1 -10
#> M   1  -3  -5   0 -10
#> F  -1  -4  -6  -1 -10
#> P  -3  -3  -4  -2 -10
#> S  -3  -1  -3   0 -10
#> T   1  -1  -3   0 -10
#> W  -5  -5  -9  -2 -10
#> Y  -1  -2  -6  -1 -10
#> V   6  -4  -4  -1 -10
#> B  -4   6  -2  -1 -10
#> Z  -4  -2   5  -1 -10
#> X  -1  -1  -1  -1 -10
#> * -10 -10 -10 -10 -10
```

```
Disorder85
#>     A   R   N   D   C   Q   E   G   H   I   L   K   M   F   P   S   T   W   Y
#> A   7 -12 -10  -8  -8 -11 -10  -7 -14  -8 -11 -12  -8 -16  -7  -4  -3 -28 -15
#> R -12   8 -11 -18  -4  -6 -14  -9  -5 -12 -10  -3 -10 -30 -10 -10 -11  -6 -15
#> N -10 -11   9  -4 -15 -11 -12  -7  -5  -8 -13  -6 -11 -20 -15  -2  -5 -16 -11
#> D  -8 -18  -4   8 -27 -14  -2  -7  -7 -19 -17 -13 -14 -23 -14 -11 -11 -27  -8
#> C  -8  -4 -15 -27  13 -16 -19  -9  -8  -8 -10 -20  -8  -6 -28  -6  -8  -6  -4
#> Q -11  -6 -11 -14 -16   8  -7 -14  -3 -17 -11  -6 -10 -28  -8 -11 -12 -27 -18
#> E -10 -14 -12  -2 -19  -7   7  -7 -15 -14 -16  -8 -15 -22 -14 -14 -14 -28 -14
#> G  -7  -9  -7  -7  -9 -14  -7   7 -15 -17 -19 -13 -15 -15 -13  -5 -10 -12 -19
#> H -14  -5  -5  -7  -8  -3 -15 -15  11 -20 -10 -14  -9 -12 -11 -12 -10  -6  -5
#> I  -8 -12  -8 -19  -8 -17 -14 -17 -20   9  -4 -14  -4  -7 -19 -10  -4 -26 -11
#> L -11 -10 -13 -17 -10 -11 -16 -19 -10  -4   8 -14  -3  -5  -9  -8 -12 -10 -13
#> K -12  -3  -6 -13 -20  -6  -8 -13 -14 -14 -14   7  -9 -16 -16 -10  -8 -28 -31
#> M  -8 -10 -11 -14  -8 -10 -15 -15  -9  -4  -3  -9  11  -6 -16 -12  -6 -11 -11
#> F -16 -30 -20 -23  -6 -28 -22 -15 -12  -7  -5 -16  -6  10 -17  -8 -15 -16  -1
#> P  -7 -10 -15 -14 -28  -8 -14 -13 -11 -19  -9 -16 -16 -17   8  -6  -8 -16 -31
#> S  -4 -10  -2 -11  -6 -11 -14  -5 -12 -10  -8 -10 -12  -8  -6   7  -4 -19 -11
#> T  -3 -11  -5 -11  -8 -12 -14 -10 -10  -4 -12  -8  -6 -15  -8  -4   8 -27 -12
#> W -28  -6 -16 -27  -6 -27 -28 -12  -6 -26 -10 -28 -11 -16 -16 -19 -27  13 -26
#> Y -15 -15 -11  -8  -4 -18 -14 -19  -5 -11 -13 -31 -11  -1 -31 -11 -12 -26  10
#> V  -4 -16 -11 -10  -9 -12 -10 -10 -14  -1  -6 -14  -3 -10 -18 -11  -7 -16 -14
#> B -11  -9  -1  -9 -16  -2 -10 -11  -4 -13 -12  -6 -11 -24 -12  -7  -9 -22 -15
#> Z  -9 -16  -8   3 -23 -11   3  -7 -11 -17 -17 -11 -15 -23 -14 -13 -13 -28 -11
#> X  -1  -2  -2  -2  -3  -1  -1  -2  -2  -2  -2  -1  -1  -2  -2  -1  -1  -3  -2
#> * -31 -31 -31 -31 -31 -31 -31 -31 -31 -31 -31 -31 -31 -31 -31 -31 -31 -31 -31
#>     V   B   Z   X   *
#> A  -4 -11  -9  -1 -31
#> R -16  -9 -16  -2 -31
#> N -11  -1  -8  -2 -31
#> D -10  -9   3  -2 -31
#> C  -9 -16 -23  -3 -31
#> Q -12  -2 -11  -1 -31
#> E -10 -10   3  -1 -31
#> G -10 -11  -7  -2 -31
#> H -14  -4 -11  -2 -31
#> I  -1 -13 -17  -2 -31
#> L  -6 -12 -17  -2 -31
#> K -14  -6 -11  -1 -31
#> M  -3 -11 -15  -1 -31
#> F -10 -24 -23  -2 -31
#> P -18 -12 -14  -2 -31
#> S -11  -7 -13  -1 -31
#> T  -7  -9 -13  -1 -31
#> W -16 -22 -28  -3 -31
#> Y -14 -15 -11  -2 -31
#> V   8 -12 -10  -1 -31
#> B -12   8  -9  -2 -31
#> Z -10  -9   7  -1 -31
#> X  -1  -2  -1  -2 -31
#> * -31 -31 -31 -31 -31
```

### DUNMat

DUNMat was described in [Radivojac et al., 2001](https://doi.org/10.1142/9789812799623_0055). This was an early attempt at improving alignments for IDPs. It is included in **idpr** due to its significance in developing substitution matrices for IDPs. It is a symmetric 20x20 matrix. [Trivedi & Nagarajaram, 2019](https://doi.org/10.1038/s41598-019-52532-8) show that EDSSMat62, on average, attains lower E-values for HD proteins.

```
DUNMat
#>    C  S  T  P  A  G  N  D  E  Q  H  R  K  M  I  L  V  F  Y  W
#> C 10  0  1 -2 -1 -3 -1 -3 -4 -3 -1 -1 -3  0  0 -1  1 -1  0 -5
#> S  0  3  1  0  1  0  1  0 -1  0 -1 -1 -1 -2 -2 -2 -2 -2 -2 -3
#> T  1  1  4 -1  0 -2  0 -1 -1  0  0 -1  0 -1 -1 -2  0 -2 -1 -5
#> P -2  0 -1  6 -1 -1 -1 -2 -1 -1 -2 -2 -1 -2 -2 -1 -1 -3 -3 -1
#> A -1  1  0 -1  3  0 -1 -1 -1 -1 -2 -2 -1 -1 -1 -1  0 -2 -2 -5
#> G -3  0 -2 -1  0  5  0 -1 -2 -2 -1 -2 -2 -4 -5 -4 -4 -4 -3 -4
#> N -1  1  0 -1 -1  0  4  1  0  1  2  0  0 -2 -3 -3 -3 -2 -1 -3
#> D -3  0 -1 -2 -1 -1  1  4  2  0 -1 -2 -1 -4 -4 -4 -4 -4 -4 -4
#> E -4 -1 -1 -1 -1 -2  0  2  4  0 -1 -1  0 -3 -3 -3 -2 -4 -3 -4
#> Q -3  0  0 -1 -1 -2  1  0  0  5  1  1  0 -1 -2 -2 -2 -2  0 -1
#> H -1 -1  0 -2 -2 -1  2 -1 -1  1  8  0 -1 -2 -2 -2 -2  0  2 -2
#> R -1 -1 -1 -2 -2 -2  0 -2 -1  1  0  5  2 -1 -2 -2 -2 -3 -2  0
#> K -3 -1  0 -1 -1 -2  0 -1  0  0 -1  2  4 -2 -2 -2 -2 -3 -2 -3
#> M  0 -2 -1 -2 -1 -4 -2 -4 -3 -1 -2 -1 -2  7  1  2  1  1 -1 -1
#> I  0 -2 -1 -2 -1 -5 -3 -4 -3 -2 -2 -2 -2  1  4  2  3  1  0 -2
#> L -1 -2 -2 -1 -1 -4 -3 -4 -3 -2 -2 -2 -2  2  2  4  1  1  0 -2
#> V  1 -2  0 -1  0 -4 -3 -4 -2 -2 -2 -2 -2  1  3  1  4  0 -1 -4
#> F -1 -2 -2 -3 -2 -4 -2 -4 -4 -2  0 -3 -3  1  1  1  0  7  4 -1
#> Y  0 -2 -1 -3 -2 -3 -1 -4 -3  0  2 -2 -2 -1  0  0 -1  4  8  3
#> W -5 -3 -5 -1 -5 -4 -3 -4 -4 -1 -2  0 -3 -1 -2 -2 -4 -1  3 13
```

## Examples

### Pairwise Sequence Alignments (PSAs)

P53 is a well-known IDP that has been experimentally determined. Information was accessed by DisProt, a database for IDPs ( [Hatos et al., 2019](https://doi.org/10.1093/nar/gkz975)). (<https://www.disprot.org/>)

These examples are to showcase the differences of BLOSUM62, a commonly used matrix that can be loaded into R via the **Biostrings** package, and EDSSMat62, a matrix comes loaded with **idpr** specific for IDPs. EDSSMat62 can be used with any function that accepts custom substitution matrices, and these examples show some uses of it.

**Cellular tumor antigen p53**

* TP53 from *Homo sapiens*
  + UniProt ID: P04637
  + DisProt ID: DP00086
  + Disorder content 48.1%
* Tp53 from *Mus musculus*
  + UniProt ID: P02340
  + DisProt ID: NA
* TP53 from *Gorilla gorilla gorilla*
  + UniProt ID: A0A2I2Y7Z8
  + DisProt ID: NA

The amino acid sequences were acquired from UniProt (UniProt Consortium, 2019) and stored within the **idpr** package for examples.

```
P53_MOUSE <- TP53Sequences[1]
print(P53_MOUSE)
#>                                                                                                                                                                                                                                                                                                                                                                                         P02340|P53_MOUSE
#> "MTAMEESQSDISLELPLSQETFSGLWKLLPPEDILPSPHCMDDLLLPQDVEEFFEGPSEALRVSGAPAAQDPVTETPGPVAPAPATPWPLSSFVPSQKTYQGNYGFHLGFLQSGTAKSVMCTYSPPLNKLFCQLAKTCPVQLWVSATPPAGSRVRAMAIYKKSQHMTEVVRRCPHHERCSDGDGLAPPQHLIRVEGNLYPEYLEDRQTFRHSVVVPYEPPEAGSEYTTIHYKYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRDSFEVRVCACPGRDRRTEEENFRKKEVLCPELPPGSAKRALPTCTSASPPQKKKPLDGEYFTLKIRGRKRFEMFRELNEALELKDAHATEESGDSRAHSSYLKTKKGQSTSRHKKTMVKKVGPDSD"
P53_HUMAN <- TP53Sequences[2]
print(P53_HUMAN)
#>                                                                                                                                                                                                                                                                                                                                                                                            P04637|P53_HUMAN
#> "MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSPLPSQAMDDLMLSPDDIEQWFTEDPGPDEAPRMPEAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQKTYQGSYGFRLGFLHSGTAKSVTCTYSPALNKMFCQLAKTCPVQLWVDSTPPPGTRVRAMAIYKQSQHMTEVVRRCPHHERCSDSDGLAPPQHLIRVEGNLRVEYLDDRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRNSFEVRVCACPGRDRRTEEENLRKKGEPHHELPPGSTKRALPNNTSSSPQPKKKPLDGEYFTLQIRGRERFEMFRELNEALELKDAQAGKEPGGSRAHSSHLKSKKGQSTSRHKKLMFKTEGPDSD"
P53_GORILLA <- GorillaTP53
print(P53_GORILLA)
#>                                                                                                                                                                                                                                                                                                                                                                                           A0A2I2Y7Z8|A0A2I2Y7Z8_GORGO
#> "MDDLMLSPDDIEQWFTEDPGPDEAPRMPEAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQKTYQGSYGFRLGFLHSGTAKSVTCTYSPTLNKMFCQLAKTCPVQLWVDSTPPPGTRVRAMAIYKQSQHMTEVVRRCPHHERCSDSDGLAPPQHLIRVEGNLRVEYLDDRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRNSFEVRVCACPGRDRRTEEENLRKKGEPHHELPPGSTKRALPNNTSSSPQPKKKPLDGEYFTLQIRGRERFEMFRELNEALELKDAQAGKEPGGRNAKHSPGDPDPPLSETFNLNICPYPAGKLELLKLSPCPCLCRQVTLMSFLFFLIFFYFRLYWGIIEPPKLHTFKVCSVMI"
```

PSA of Human TP53 to Gorilla and Mouse P53 BLOSUM62 ( [Henikoff & Henikoff, 1992](https://doi.org/10.1073/pnas.89.22.10915)) with default gap opening/extension from EMBOSS Needle ( [Madeira et al., 2019](http://doi.org/10.1093/nar/gkz268)). pairwiseAlignment function and BLOSUM62 matrix are from **pwalign**

```
library(pwalign)
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
#> Loading required package: Biostrings
#> Loading required package: XVector
#> Loading required package: Seqinfo
#>
#> Attaching package: 'Biostrings'
#> The following object is masked from 'package:base':
#>
#>     strsplit
#>
#> Attaching package: 'pwalign'
#> The following objects are masked from 'package:Biostrings':
#>
#>     PairwiseAlignments, PairwiseAlignmentsSingleSubject, aligned,
#>     alignedPattern, alignedSubject, compareStrings, deletion,
#>     errorSubstitutionMatrices, indel, insertion, mismatchSummary,
#>     mismatchTable, nedit, nindel, nucleotideSubstitutionMatrix,
#>     pairwiseAlignment, pattern, pid, qualitySubstitutionMatrices,
#>     stringDist, unaligned, writePairwiseAlignments
data("BLOSUM62") #loads the matrix from the Biostrings package
HUMAN_MOUSE_BLOSUM_PSA <- pairwiseAlignment(P53_MOUSE, P53_HUMAN,
                                            substitutionMatrix = BLOSUM62,
                                            gapOpening = 10,
                                            gapExtension = 0.5)
print(HUMAN_MOUSE_BLOSUM_PSA)
#> Global PairwiseAlignmentsSingleSubject (1 of 1)
#> pattern: MTAMEESQSDISLELPLSQETFSGLWKLLPPEDI...GDSRAHSSYLKTKKGQSTSRHKKTMVKKVGPDSD
#> subject: M---EEPQSDPSVEPPLSQETFSDLWKLLPENNV...GGSRAHSSHLKSKKGQSTSRHKKLMFKTEGPDSD
#> score: 1544.5

HUMAN_GORILLA_BLOSUM_PSA <- pairwiseAlignment(P53_GORILLA, P53_HUMAN,
                                             substitutionMatrix = BLOSUM62,
                                             gapOpening = 10,
                                             gapExtension = 0.5)
print(HUMAN_GORILLA_BLOSUM_PSA)
#> Global PairwiseAlignmentsSingleSubject (1 of 1)
#> pattern: M---------------------------------...MSFLFFLIFFYFRLYWGIIEPPKLHTFKVCSVMI
#> subject: MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSP...M----------FKT-----EGPDSD---------
#> score: 1678
```

PSA of Human TP53 to Gorilla and Mouse P53 using EDSSMat62 with gap costs recommended for IDPs in ( [Trivedi & Nagarajaram, 2019](https://doi.org/10.1038/s41598-019-52532-8)).

```
HUMAN_MOUSE_EDSS_PSA <- pairwiseAlignment(P53_MOUSE, P53_HUMAN,
                                            substitutionMatrix = EDSSMat62,
                                            gapOpening = 19,
                                            gapExtension = 2)
print(HUMAN_MOUSE_EDSS_PSA)
#> Global PairwiseAlignmentsSingleSubject (1 of 1)
#> pattern: MTAMEESQSDISLELPLSQETFSGLWKLLPPEDI...GDSRAHSSYLKTKKGQSTSRHKKTMVKKVGPDSD
#> subject: M---EEPQSDPSVEPPLSQETFSDLWKLLPENNV...GGSRAHSSHLKSKKGQSTSRHKKLMFKTEGPDSD
#> score: 1723

HUMAN_GORILLA_EDSS_PSA <- pairwiseAlignment(P53_GORILLA, P53_HUMAN,
                                             substitutionMatrix = EDSSMat62,
                                             gapOpening = 19,
                                             gapExtension = 2)
print(HUMAN_GORILLA_EDSS_PSA)
#> Global PairwiseAlignmentsSingleSubject (1 of 1)
#> pattern: M---------------------------------...SFLFFLIFFYFRLYWGIIEPPKLHTFKV-CSVMI
#> subject: MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSP...-------------------------FKTEGPDSD
#> score: 1720
```

Comparing the printed alignment for each matrix comparing Human and Mouse P53, we can see that the alignments differ depending on the matrix used to align. This is also seen in the second alignments for each matrix that compares Human and Gorilla P53.

Using BLOSUM, the scores between each PSA differ greatly by over 100 points. Using EDSSMat62 we can see almost identical scores between the alignment comparing Human p53 to Mouse p53 and in the alignment comparing Human p53 to Gorilla p53. Scores are not directly comparable between matrices, but this shows relative to each other, the scores with EDSSMat62 are similar for this specific case. There will be some instances where BLOSUM62 may appear to have better scores, but as previously stated, [Trivedi & Nagarajaram, 2019](https://doi.org/10.1038/s41598-019-52532-8) show that on average EDSSMat62 attains lower E-values for alignments of IDPs.

### Multiple Sequence Alignments (MSAs)

In addition to PSAs, Multiple Sequence Alignments (MSAs) offer additional analysis for protein families.

First I will load several P53 sequences stored within **idpr**. These sequences were selected due to their highly similar identity on UniProt( [The UniProt Consortium, 2019](https://doi.org/10.1093/nar/gky1049)).

```
TP53_Sequences <- TP53Sequences
print(TP53_Sequences)
#>                                                                                                                                                                                                                                                                                                                                                                                                      P02340|P53_MOUSE
#>              "MTAMEESQSDISLELPLSQETFSGLWKLLPPEDILPSPHCMDDLLLPQDVEEFFEGPSEALRVSGAPAAQDPVTETPGPVAPAPATPWPLSSFVPSQKTYQGNYGFHLGFLQSGTAKSVMCTYSPPLNKLFCQLAKTCPVQLWVSATPPAGSRVRAMAIYKKSQHMTEVVRRCPHHERCSDGDGLAPPQHLIRVEGNLYPEYLEDRQTFRHSVVVPYEPPEAGSEYTTIHYKYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRDSFEVRVCACPGRDRRTEEENFRKKEVLCPELPPGSAKRALPTCTSASPPQKKKPLDGEYFTLKIRGRKRFEMFRELNEALELKDAHATEESGDSRAHSSYLKTKKGQSTSRHKKTMVKKVGPDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                                      P04637|P53_HUMAN
#>           "MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSPLPSQAMDDLMLSPDDIEQWFTEDPGPDEAPRMPEAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQKTYQGSYGFRLGFLHSGTAKSVTCTYSPALNKMFCQLAKTCPVQLWVDSTPPPGTRVRAMAIYKQSQHMTEVVRRCPHHERCSDSDGLAPPQHLIRVEGNLRVEYLDDRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRNSFEVRVCACPGRDRRTEEENLRKKGEPHHELPPGSTKRALPNNTSSSPQPKKKPLDGEYFTLQIRGRERFEMFRELNEALELKDAQAGKEPGGSRAHSSHLKSKKGQSTSRHKKLMFKTEGPDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                                        P10361|P53_RAT
#>             "MEDSQSDMSIELPLSQETFSCLWKLLPPDDILPTTATGSPNSMEDLFLPQDVAELLEGPEEALQVSAPAAQEPGTEAPAPVAPASATPWPLSSSVPSQKTYQGNYGFHLGFLQSGTAKSVMCTYSISLNKLFCQLAKTCPVQLWVTSTPPPGTRVRAMAIYKKSQHMTEVVRRCPHHERCSDGDGLAPPQHLIRVEGNPYAEYLDDRQTFRHSVVVPYEPPEVGSDYTTIHYKYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRDSFEVRVCACPGRDRRTEEENFRKKEEHCPELPPGSAKRALPTSTSSSPQQKKKPLDGEYFTLKIRGRERFEMFRELNEALELKDARAAEESGDSRAHSSYPKTKKGQSTSRHKKPMIKKVGPDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                                      Q29537|P53_CANLF
#>                       "MEESQSELNIDPPLSQETFSELWNLLPENNVLSSELCPAVDELLLPESVVNWLDEDSDDAPRMPATSAPTAPGPAPSWPLSSSVPSPKTYPGTYGFRLGFLHSGTAKSVTWTYSPLLNKLFCQLAKTCPVQLWVSSPPPPNTCVRAMAIYKKSEFVTEVVRRCPHHERCSDSSDGLAPPQHLIRVEGNLRAKYLDDRNTFRHSVVVPYEPPEVGSDYTTIHYNYMCNSSCMGGMNRRPILTIITLEDSSGNVLGRNSFEVRVCACPGRDRRTEEENFHKKGEPCPEPPPGSTKRALPPSTSSSPPQKKKPLDGEYFTLQIRGRERYEMFRNLNEALELKDAQSGKEPGGSRAHSSHLKAKKGQSTSRHKKLMFKREGLDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                                      Q00366|P53_MESAU
#>        "MEEPQSDLSIELPLSQETFSDLWKLLPPNNVLSTLPSSDSIEELFLSENVAGWLEDPGEALQGSAAAAAPAAPAAEDPVAETPAPVASAPATPWPLSSSVPSYKTYQGDYGFRLGFLHSGTAKSVTCTYSPSLNKLFCQLAKTCPVQLWVSSTPPPGTRVRAMAIYKKLQYMTEVVRRCPHHERSSEGDGLAPPQHLIRVEGNMHAEYLDDKQTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDPSGNLLGRNSFEVRICACPGRDRRTEEKNFQKKGEPCPELPPKSAKRALPTNTSSSPQPKRKTLDGEYFTLKIRGQERFKMFQELNEALELKDAQALKASEDSGAHSSYLKSKKGQSASRLKKLMIKREGPDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                                      O09185|P53_CRIGR
#>           "MEEPQSDLSIELPLSQETFSDLWKLLPPNNVLSTLPSSDSIEELFLSENVTGWLEDSGGALQGVAAAAASTAEDPVTETPAPVASAPATPWPLSSSVPSYKTYQGDYGFRLGFLHSGTAKSVTCTYSPSLNKLFCQLAKTCPVQLWVNSTPPPGTRVRAMAIYKKLQYMTEVVRRCPHHERSSEGDSLAPPQHLIRVEGNLHAEYLDDKQTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDPSGNLLGRNSFEVRICACPGRDRRTEEKNFQKKGEPCPELPPKSAKRALPTNTSSSPPPKKKTLDGEYFTLKIRGHERFKMFQELNEALELKDAQASKGSEDNGAHSSYLKSKKGQSASRLKKLMIKREGPDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                                      Q9TTA1|P53_TUPBE
#>           "MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSPLPSQAMDDLMLSPDDIEQWFTEDPGPDEAPRMPEAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQKTYQGSYGFRLGFLHSGTAKSVTCTYSPDLNKLFCQLAKTCPVQLWVDSAPPPGTRVRAMAIYKQSQYVTEVVRRCPHHERCSDSDGLAPPQHLIRVEGNLHAEYSDDRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSSGKLLGRNSFEVRICACPGRDRRTEEENFRKKGESCPKLPTGSIKRALPTGSSSSPQPKKKPLDEEYFTLQIRGRERFEMLREINEALELKDAMAGKESAGSRAHSSHLKSKKGQSTSRHRKLMFKTEGPDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                                      Q95330|P53_RABIT
#>             "MEESQSDLSLEPPLSQETFSDLWKLLPENNLLTTSLNPPVDDLLSAEDVANWLNEDPEEGLRVPAAPAPEAPAPAAPALAAPAPATSWPLSSSVPSQKTYHGNYGFRLGFLHSGTAKSVTCTYSPCLNKLFCQLAKTCPVQLWVDSTPPPGTRVRAMAIYKKSQHMTEVVRRCPHHERCSDSDGLAPPQHLIRVEGNLRAEYLDDRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRNSFEVRVCACPGRDRRTEEENFRKKGEPCPELPPGSSKRALPTTTTDSSPQTKKKPLDGEYFILKIRGRERFEMFRELNEALELKDAQAEKEPGGSRAHSSYLKAKKGQSTSRHKKPMFKREGPDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                           A0A2I2Y7Z8|A0A2I2Y7Z8_GORGO
#> "MDDLMLSPDDIEQWFTEDPGPDEAPRMPEAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQKTYQGSYGFRLGFLHSGTAKSVTCTYSPTLNKMFCQLAKTCPVQLWVDSTPPPGTRVRAMAIYKQSQHMTEVVRRCPHHERCSDSDGLAPPQHLIRVEGNLRVEYLDDRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRNSFEVRVCACPGRDRRTEEENLRKKGEPHHELPPGSTKRALPNNTSSSPQPKKKPLDGEYFTLQIRGRERFEMFRELNEALELKDAQAGKEPGGRNAKHSPGDPDPPLSETFNLNICPYPAGKLELLKLSPCPCLCRQVTLMSFLFFLIFFYFRLYWGIIEPPKLHTFKVCSVMI"
```

MSA of P53 proteins using the **msa** package

```
library(msa)
BLOSUM_MSA <- msa(TP53_Sequences,
                 type = "protein",
                 substitutionMatrix = BLOSUM62,
                 gapOpening = 10,
                 gapExtension = 0.5)
#> use user defined matrix

print(BLOSUM_MSA, show = "complete")
#>
#> MsaAAMultipleAlignment with 9 rows and 452 columns
#>     aln (1..54)                                            names
#> [1] MTAMEESQSDISLELPLSQETFSGLWKLLPPEDILP-----SPHCMDDLLLPQD P02340|P53_MOUSE
#> [2] ---MEDSQSDMSIELPLSQETFSCLWKLLPPDDILPTTATGSPNSMEDLFLPQD P10361|P53_RAT
#> [3] ---MEEPQSDLSIELPLSQETFSDLWKLLPPNNVLSTLP--SSDSIEELFLSEN Q00366|P53_MESAU
#> [4] ---MEEPQSDLSIELPLSQETFSDLWKLLPPNNVLSTLP--SSDSIEELFLSEN O09185|P53_CRIGR
#> [5] ---MEESQSDLSLEPPLSQETFSDLWKLLPENNLLTTSLN---PPVDDLLSAED Q95330|P53_RABIT
#> [6] ---MEESQSELNIDPPLSQETFSELWNLLPENNVLSSELC---PAVDELLLPES Q29537|P53_CANLF
#> [7] ---MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSPLPS--QAMDDLMLSPDD Q9TTA1|P53_TUPBE
#> [8] ---MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSPLPS--QAMDDLMLSPDD P04637|P53_HUMAN
#> [9] --------------------------------------------MDDLMLSPDD A0A2I2Y7Z8|A0A2I2...
#> Con ---MEE?QSD?S?E?PLSQETFSDLWKLLP?NNVLS????--????D?LLLP?D Consensus
#>
#>     aln (55..108)                                          names
#> [1] VEEFFEGPSEALRVSG------APAAQDPVTETPGPVAPAPATPWPLSSFVPSQ P02340|P53_MOUSE
#> [2] VAELLEGPEEALQVS-------APAAQEPGTEAPAPVAPASATPWPLSSSVPSQ P10361|P53_RAT
#> [3] VAGWLEDPGEALQGSAAAAAPAAPAAEDPVAETPAPVASAPATPWPLSSSVPSY Q00366|P53_MESAU
#> [4] VTGWLEDSGGALQG---VAAAAASTAEDPVTETPAPVASAPATPWPLSSSVPSY O09185|P53_CRIGR
#> [5] VANWLNEDPEEGLRVP-----AAPAPEAPAPAAPALAAPAPATSWPLSSSVPSQ Q95330|P53_RABIT
#> [6] VVNWLDEDSDDAPRMP---------------ATSAPTAPGPAPSWPLSSSVPSP Q29537|P53_CANLF
#> [7] IEQWFTEDPGPDEAPR---MPEAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQ Q9TTA1|P53_TUPBE
#> [8] IEQWFTEDPGPDEAPR---MPEAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQ P04637|P53_HUMAN
#> [9] IEQWFTEDPGPDEAPR---MPEAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQ A0A2I2Y7Z8|A0A2I2...
#> Con V??WL?ED????????---???A?????P??AAPAP?APAPATSWPLSSSVPSQ Consensus
#>
#>     aln (109..162)                                         names
#> [1] KTYQGNYGFHLGFLQSGTAKSVMCTYSPPLNKLFCQLAKTCPVQLWVSATPPAG P02340|P53_MOUSE
#> [2] KTYQGNYGFHLGFLQSGTAKSVMCTYSISLNKLFCQLAKTCPVQLWVTSTPPPG P10361|P53_RAT
#> [3] KTYQGDYGFRLGFLHSGTAKSVTCTYSPSLNKLFCQLAKTCPVQLWVSSTPPPG Q00366|P53_MESAU
#> [4] KTYQGDYGFRLGFLHSGTAKSVTCTYSPSLNKLFCQLAKTCPVQLWVNSTPPPG O09185|P53_CRIGR
#> [5] KTYHGNYGFRLGFLHSGTAKSVTCTYSPCLNKLFCQLAKTCPVQLWVDSTPPPG Q95330|P53_RABIT
#> [6] KTYPGTYGFRLGFLHSGTAKSVTWTYSPLLNKLFCQLAKTCPVQLWVSSPPPPN Q29537|P53_CANLF
#> [7] KTYQGSYGFRLGFLHSGTAKSVTCTYSPDLNKLFCQLAKTCPVQLWVDSAPPPG Q9TTA1|P53_TUPBE
#> [8] KTYQGSYGFRLGFLHSGTAKSVTCTYSPALNKMFCQLAKTCPVQLWVDSTPPPG P04637|P53_HUMAN
#> [9] KTYQGSYGFRLGFLHSGTAKSVTCTYSPTLNKMFCQLAKTCPVQLWVDSTPPPG A0A2I2Y7Z8|A0A2I2...
#> Con KTYQG?YGFRLGFLHSGTAKSVTCTYSP?LNKLFCQLAKTCPVQLWV?STPPPG Consensus
#>
#>     aln (163..216)                                         names
#> [1] SRVRAMAIYKKSQHMTEVVRRCPHHERCSDG-DGLAPPQHLIRVEGNLYPEYLE P02340|P53_MOUSE
#> [2] TRVRAMAIYKKSQHMTEVVRRCPHHERCSDG-DGLAPPQHLIRVEGNPYAEYLD P10361|P53_RAT
#> [3] TRVRAMAIYKKLQYMTEVVRRCPHHERSSEG-DGLAPPQHLIRVEGNMHAEYLD Q00366|P53_MESAU
#> [4] TRVRAMAIYKKLQYMTEVVRRCPHHERSSEG-DSLAPPQHLIRVEGNLHAEYLD O09185|P53_CRIGR
#> [5] TRVRAMAIYKKSQHMTEVVRRCPHHERCSDS-DGLAPPQHLIRVEGNLRAEYLD Q95330|P53_RABIT
#> [6] TCVRAMAIYKKSEFVTEVVRRCPHHERCSDSSDGLAPPQHLIRVEGNLRAKYLD Q29537|P53_CANLF
#> [7] TRVRAMAIYKQSQYVTEVVRRCPHHERCSDS-DGLAPPQHLIRVEGNLHAEYSD Q9TTA1|P53_TUPBE
#> [8] TRVRAMAIYKQSQHMTEVVRRCPHHERCSDS-DGLAPPQHLIRVEGNLRVEYLD P04637|P53_HUMAN
#> [9] TRVRAMAIYKQSQHMTEVVRRCPHHERCSDS-DGLAPPQHLIRVEGNLRVEYLD A0A2I2Y7Z8|A0A2I2...
#> Con TRVRAMAIYKKSQHMTEVVRRCPHHERCSDS-DGLAPPQHLIRVEGNL?AEYLD Consensus
#>
#>     aln (217..270)                                         names
#> [1] DRQTFRHSVVVPYEPPEAGSEYTTIHYKYMCNSSCMGGMNRRPILTIITLEDSS P02340|P53_MOUSE
#> [2] DRQTFRHSVVVPYEPPEVGSDYTTIHYKYMCNSSCMGGMNRRPILTIITLEDSS P10361|P53_RAT
#> [3] DKQTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDPS Q00366|P53_MESAU
#> [4] DKQTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDPS O09185|P53_CRIGR
#> [5] DRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSS Q95330|P53_RABIT
#> [6] DRNTFRHSVVVPYEPPEVGSDYTTIHYNYMCNSSCMGGMNRRPILTIITLEDSS Q29537|P53_CANLF
#> [7] DRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSS Q9TTA1|P53_TUPBE
#> [8] DRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSS P04637|P53_HUMAN
#> [9] DRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSS A0A2I2Y7Z8|A0A2I2...
#> Con DRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSS Consensus
#>
#>     aln (271..324)                                         names
#> [1] GNLLGRDSFEVRVCACPGRDRRTEEENFRKKEVLCPELPPGSAKRALPTCTS-A P02340|P53_MOUSE
#> [2] GNLLGRDSFEVRVCACPGRDRRTEEENFRKKEEHCPELPPGSAKRALPTSTS-S P10361|P53_RAT
#> [3] GNLLGRNSFEVRICACPGRDRRTEEKNFQKKGEPCPELPPKSAKRALPTNTS-S Q00366|P53_MESAU
#> [4] GNLLGRNSFEVRICACPGRDRRTEEKNFQKKGEPCPELPPKSAKRALPTNTS-S O09185|P53_CRIGR
#> [5] GNLLGRNSFEVRVCACPGRDRRTEEENFRKKGEPCPELPPGSSKRALPTTTTDS Q95330|P53_RABIT
#> [6] GNVLGRNSFEVRVCACPGRDRRTEEENFHKKGEPCPEPPPGSTKRALPPSTS-S Q29537|P53_CANLF
#> [7] GKLLGRNSFEVRICACPGRDRRTEEENFRKKGESCPKLPTGSIKRALPTGSS-S Q9TTA1|P53_TUPBE
#> [8] GNLLGRNSFEVRVCACPGRDRRTEEENLRKKGEPHHELPPGSTKRALPNNTS-S P04637|P53_HUMAN
#> [9] GNLLGRNSFEVRVCACPGRDRRTEEENLRKKGEPHHELPPGSTKRALPNNTS-S A0A2I2Y7Z8|A0A2I2...
#> Con GNLLGRNSFEVRVCACPGRDRRTEEENFRKKGEPCPELPPGS?KRALPT?TS-S Consensus
#>
#>     aln (325..378)                                         names
#> [1] SPPQKKKPLDGEYFTLKIRGRKRFEMFRELNEALELKDAHATEESGDSRAHSSY P02340|P53_MOUSE
#> [2] SPQQKKKPLDGEYFTLKIRGRERFEMFRELNEALELKDARAAEESGDSRAHSSY P10361|P53_RAT
#> [3] SPQPKRKTLDGEYFTLKIRGQERFKMFQELNEALELKDAQALKASEDSGAHSSY Q00366|P53_MESAU
#> [4] SPPPKKKTLDGEYFTLKIRGHERFKMFQELNEALELKDAQASKGSEDNGAHSSY O09185|P53_CRIGR
#> [5] SPQTKKKPLDGEYFILKIRGRERFEMFRELNEALELKDAQAEKEPGGSRAHSSY Q95330|P53_RABIT
#> [6] SPPQKKKPLDGEYFTLQIRGRERYEMFRNLNEALELKDAQSGKEPGGSRAHSSH Q29537|P53_CANLF
#> [7] SPQPKKKPLDEEYFTLQIRGRERFEMLREINEALELKDAMAGKESAGSRAHSSH Q9TTA1|P53_TUPBE
#> [8] SPQPKKKPLDGEYFTLQIRGRERFEMFRELNEALELKDAQAGKEPGGSRAHSSH P04637|P53_HUMAN
#> [9] SPQPKKKPLDGEYFTLQIRGRERFEMFRELNEALELKDAQAGKEPGGRNAKHSP A0A2I2Y7Z8|A0A2I2...
#> Con SPQPKKKPLDGEYFTLKIRGRERFEMFRELNEALELKDAQA?KESGGSRAHSSY Consensus
#>
#>     aln (379..432)                                         names
#> [1] LKTKKGQSTSRHKKTMVKKVGPDSD----------------------------- P02340|P53_MOUSE
#> [2] PKTKKGQSTSRHKKPMIKKVGPDSD----------------------------- P10361|P53_RAT
#> [3] LKSKKGQSASRLKKLMIKREGPDSD----------------------------- Q00366|P53_MESAU
#> [4] LKSKKGQSASRLKKLMIKREGPDSD----------------------------- O09185|P53_CRIGR
#> [5] LKAKKGQSTSRHKKPMFKREGPDSD----------------------------- Q95330|P53_RABIT
#> [6] LKAKKGQSTSRHKKLMFKREGLDSD----------------------------- Q29537|P53_CANLF
#> [7] LKSKKGQSTSRHRKLMFKTEGPDSD----------------------------- Q9TTA1|P53_TUPBE
#> [8] LKSKKGQSTSRHKKLMFKTEGPDSD----------------------------- P04637|P53_HUMAN
#> [9] GDPDPPLSETFNLNICPYPAGKLELLKLSPCPCLCRQVTLMSFLFFLIFFYFRL A0A2I2Y7Z8|A0A2I2...
#> Con LK?KKGQSTSRHKKLM?K?EGPDSD----------------------------- Consensus
#>
#>     aln (433..452)       names
#> [1] -------------------- P02340|P53_MOUSE
#> [2] -------------------- P10361|P53_RAT
#> [3] -------------------- Q00366|P53_MESAU
#> [4] -------------------- O09185|P53_CRIGR
#> [5] -------------------- Q95330|P53_RABIT
#> [6] -------------------- Q29537|P53_CANLF
#> [7] -------------------- Q9TTA1|P53_TUPBE
#> [8] -------------------- P04637|P53_HUMAN
#> [9] YWGIIEPPKLHTFKVCSVMI A0A2I2Y7Z8|A0A2I2...
#> Con -------------------- Consensus
```

```
EDSS_MSA <- msa(TP53_Sequences,
                type = "protein",
                substitutionMatrix = EDSSMat62,
                gapOpening = 19,
                gapExtension = 2)
#> use user defined matrix

print(EDSS_MSA, show = "complete")
#>
#> MsaAAMultipleAlignment with 9 rows and 452 columns
#>     aln (1..54)                                            names
#> [1] MTAMEESQSDISLELPLSQETFSGLWKLLPPEDILP-----SPHCMDDLLLPQD P02340|P53_MOUSE
#> [2] ---MEDSQSDMSIELPLSQETFSCLWKLLPPDDILPTTATGSPNSMEDLFLPQD P10361|P53_RAT
#> [3] ---MEEPQSDLSIELPLSQETFSDLWKLLPPNNVLSTLP--SSDSIEELFLSEN Q00366|P53_MESAU
#> [4] ---MEEPQSDLSIELPLSQETFSDLWKLLPPNNVLSTLP--SSDSIEELFLSEN O09185|P53_CRIGR
#> [5] ---MEESQSDLSLEPPLSQETFSDLWKLLPENNLLTTSLN---PPVDDLLSAED Q95330|P53_RABIT
#> [6] ---MEESQSELNIDPPLSQETFSELWNLLPENNVLSSELC---PAVDELLLPES Q29537|P53_CANLF
#> [7] ---MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSPLPSQAMDDLMLSPDDIE Q9TTA1|P53_TUPBE
#> [8] ---MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSPLPSQAMDDLMLSPDDIE P04637|P53_HUMAN
#> [9] --------------------------------------------MDDLMLSPDD A0A2I2Y7Z8|A0A2I2...
#> Con ---MEE?QSD?S?E?PLSQETFSDLWKLLP?NNVLS????-???????L?L??? Consensus
#>
#>     aln (55..108)                                          names
#> [1] VEEFFEGPSEALRVSG------APAAQDPVTETPGPVAPAPATPWPLSSFVPSQ P02340|P53_MOUSE
#> [2] VAELLEGPEEALQVS-------APAAQEPGTEAPAPVAPASATPWPLSSSVPSQ P10361|P53_RAT
#> [3] VAGWLEDPGEALQGSAAAAAPAAPAAEDPVAETPAPVASAPATPWPLSSSVPSY Q00366|P53_MESAU
#> [4] VTGWLEDSGGALQG---VAAAAASTAEDPVTETPAPVASAPATPWPLSSSVPSY O09185|P53_CRIGR
#> [5] VANWLNEDPEEGLRVP-----AAPAPEAPAPAAPALAAPAPATSWPLSSSVPSQ Q95330|P53_RABIT
#> [6] VVNWLDEDSDDAPRMP---------------ATSAPTAPGPAPSWPLSSSVPSP Q29537|P53_CANLF
#> [7] QWFTEDPGPDEAPRMP-----EAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQ Q9TTA1|P53_TUPBE
#> [8] QWFTEDPGPDEAPRMP-----EAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQ P04637|P53_HUMAN
#> [9] IEQWFTEDPGPDEAPR---MPEAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQ A0A2I2Y7Z8|A0A2I2...
#> Con V??WL???????????-----?A?????P??AAPAP?APAPATSWPLSSSVPSQ Consensus
#>
#>     aln (109..162)                                         names
#> [1] KTYQGNYGFHLGFLQSGTAKSVMCTYSPPLNKLFCQLAKTCPVQLWVSATPPAG P02340|P53_MOUSE
#> [2] KTYQGNYGFHLGFLQSGTAKSVMCTYSISLNKLFCQLAKTCPVQLWVTSTPPPG P10361|P53_RAT
#> [3] KTYQGDYGFRLGFLHSGTAKSVTCTYSPSLNKLFCQLAKTCPVQLWVSSTPPPG Q00366|P53_MESAU
#> [4] KTYQGDYGFRLGFLHSGTAKSVTCTYSPSLNKLFCQLAKTCPVQLWVNSTPPPG O09185|P53_CRIGR
#> [5] KTYHGNYGFRLGFLHSGTAKSVTCTYSPCLNKLFCQLAKTCPVQLWVDSTPPPG Q95330|P53_RABIT
#> [6] KTYPGTYGFRLGFLHSGTAKSVTWTYSPLLNKLFCQLAKTCPVQLWVSSPPPPN Q29537|P53_CANLF
#> [7] KTYQGSYGFRLGFLHSGTAKSVTCTYSPDLNKLFCQLAKTCPVQLWVDSAPPPG Q9TTA1|P53_TUPBE
#> [8] KTYQGSYGFRLGFLHSGTAKSVTCTYSPALNKMFCQLAKTCPVQLWVDSTPPPG P04637|P53_HUMAN
#> [9] KTYQGSYGFRLGFLHSGTAKSVTCTYSPTLNKMFCQLAKTCPVQLWVDSTPPPG A0A2I2Y7Z8|A0A2I2...
#> Con KTYQG?YGFRLGFLHSGTAKSVTCTYSP?LNKLFCQLAKTCPVQLWV?STPPPG Consensus
#>
#>     aln (163..216)                                         names
#> [1] SRVRAMAIYKKSQHMTEVVRRCPHHERCSDG-DGLAPPQHLIRVEGNLYPEYLE P02340|P53_MOUSE
#> [2] TRVRAMAIYKKSQHMTEVVRRCPHHERCSDG-DGLAPPQHLIRVEGNPYAEYLD P10361|P53_RAT
#> [3] TRVRAMAIYKKLQYMTEVVRRCPHHERSSEG-DGLAPPQHLIRVEGNMHAEYLD Q00366|P53_MESAU
#> [4] TRVRAMAIYKKLQYMTEVVRRCPHHERSSEG-DSLAPPQHLIRVEGNLHAEYLD O09185|P53_CRIGR
#> [5] TRVRAMAIYKKSQHMTEVVRRCPHHERCSDS-DGLAPPQHLIRVEGNLRAEYLD Q95330|P53_RABIT
#> [6] TCVRAMAIYKKSEFVTEVVRRCPHHERCSDSSDGLAPPQHLIRVEGNLRAKYLD Q29537|P53_CANLF
#> [7] TRVRAMAIYKQSQYVTEVVRRCPHHERCSDS-DGLAPPQHLIRVEGNLHAEYSD Q9TTA1|P53_TUPBE
#> [8] TRVRAMAIYKQSQHMTEVVRRCPHHERCSDS-DGLAPPQHLIRVEGNLRVEYLD P04637|P53_HUMAN
#> [9] TRVRAMAIYKQSQHMTEVVRRCPHHERCSDS-DGLAPPQHLIRVEGNLRVEYLD A0A2I2Y7Z8|A0A2I2...
#> Con TRVRAMAIYKKSQHMTEVVRRCPHHERCSDS-DGLAPPQHLIRVEGNL?AEYLD Consensus
#>
#>     aln (217..270)                                         names
#> [1] DRQTFRHSVVVPYEPPEAGSEYTTIHYKYMCNSSCMGGMNRRPILTIITLEDSS P02340|P53_MOUSE
#> [2] DRQTFRHSVVVPYEPPEVGSDYTTIHYKYMCNSSCMGGMNRRPILTIITLEDSS P10361|P53_RAT
#> [3] DKQTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDPS Q00366|P53_MESAU
#> [4] DKQTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDPS O09185|P53_CRIGR
#> [5] DRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSS Q95330|P53_RABIT
#> [6] DRNTFRHSVVVPYEPPEVGSDYTTIHYNYMCNSSCMGGMNRRPILTIITLEDSS Q29537|P53_CANLF
#> [7] DRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSS Q9TTA1|P53_TUPBE
#> [8] DRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSS P04637|P53_HUMAN
#> [9] DRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSS A0A2I2Y7Z8|A0A2I2...
#> Con DRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSS Consensus
#>
#>     aln (271..324)                                         names
#> [1] GNLLGRDSFEVRVCACPGRDRRTEEENFRKKEVLCPELPPGSAKRALPTCTS-A P02340|P53_MOUSE
#> [2] GNLLGRDSFEVRVCACPGRDRRTEEENFRKKEEHCPELPPGSAKRALPTSTS-S P10361|P53_RAT
#> [3] GNLLGRNSFEVRICACPGRDRRTEEKNFQKKGEPCPELPPKSAKRALPTNTS-S Q00366|P53_MESAU
#> [4] GNLLGRNSFEVRICACPGRDRRTEEKNFQKKGEPCPELPPKSAKRALPTNTS-S O09185|P53_CRIGR
#> [5] GNLLGRNSFEVRVCACPGRDRRTEEENFRKKGEPCPELPPGSSKRALPTTTTDS Q95330|P53_RABIT
#> [6] GNVLGRNSFEVRVCACPGRDRRTEEENFHKKGEPCPEPPPGSTKRALPPSTS-S Q29537|P53_CANLF
#> [7] GKLLGRNSFEVRICACPGRDRRTEEENFRKKGESCPKLPTGSIKRALPTGSS-S Q9TTA1|P53_TUPBE
#> [8] GNLLGRNSFEVRVCACPGRDRRTEEENLRKKGEPHHELPPGSTKRALPNNTS-S P04637|P53_HUMAN
#> [9] GNLLGRNSFEVRVCACPGRDRRTEEENLRKKGEPHHELPPGSTKRALPNNTS-S A0A2I2Y7Z8|A0A2I2...
#> Con GNLLGRNSFEVRVCACPGRDRRTEEENFRKKGEPCPELPPGS?KRALPT?TS-S Consensus
#>
#>     aln (325..378)                                         names
#> [1] SPPQKKKPLDGEYFTLKIRGRKRFEMFRELNEALELKDAHATEESGDSRAHSSY P02340|P53_MOUSE
#> [2] SPQQKKKPLDGEYFTLKIRGRERFEMFRELNEALELKDARAAEESGDSRAHSSY P10361|P53_RAT
#> [3] SPQPKRKTLDGEYFTLKIRGQERFKMFQELNEALELKDAQALKASEDSGAHSSY Q00366|P53_MESAU
#> [4] SPPPKKKTLDGEYFTLKIRGHERFKMFQELNEALELKDAQASKGSEDNGAHSSY O09185|P53_CRIGR
#> [5] SPQTKKKPLDGEYFILKIRGRERFEMFRELNEALELKDAQAEKEPGGSRAHSSY Q95330|P53_RABIT
#> [6] SPPQKKKPLDGEYFTLQIRGRERYEMFRNLNEALELKDAQSGKEPGGSRAHSSH Q29537|P53_CANLF
#> [7] SPQPKKKPLDEEYFTLQIRGRERFEMLREINEALELKDAMAGKESAGSRAHSSH Q9TTA1|P53_TUPBE
#> [8] SPQPKKKPLDGEYFTLQIRGRERFEMFRELNEALELKDAQAGKEPGGSRAHSSH P04637|P53_HUMAN
#> [9] SPQPKKKPLDGEYFTLQIRGRERFEMFRELNEALELKDAQAGKEPGGRNAKHSP A0A2I2Y7Z8|A0A2I2...
#> Con SPQPKKKPLDGEYFTLKIRGRERFEMFRELNEALELKDAQA?KESGGSRAHSSY Consensus
#>
#>     aln (379..432)                                         names
#> [1] LKTKKGQSTSRHKKTMVKKVGPDSD----------------------------- P02340|P53_MOUSE
#> [2] PKTKKGQSTSRHKKPMIKKVGPDSD----------------------------- P10361|P53_RAT
#> [3] LKSKKGQSASRLKKLMIKREGPDSD----------------------------- Q00366|P53_MESAU
#> [4] LKSKKGQSASRLKKLMIKREGPDSD----------------------------- O09185|P53_CRIGR
#> [5] LKAKKGQSTSRHKKPMFKREGPDSD----------------------------- Q95330|P53_RABIT
#> [6] LKAKKGQSTSRHKKLMFKREGLDSD----------------------------- Q29537|P53_CANLF
#> [7] LKSKKGQSTSRHRKLMFKTEGPDSD----------------------------- Q9TTA1|P53_TUPBE
#> [8] LKSKKGQSTSRHKKLMFKTEGPDSD----------------------------- P04637|P53_HUMAN
#> [9] GDPDPPLSETFNLNICPYPAGKLELLKLSPCPCLCRQVTLMSFLFFLIFFYFRL A0A2I2Y7Z8|A0A2I2...
#> Con LK?KKGQSTSRHKKLM?K?EGPDSD----------------------------- Consensus
#>
#>     aln (433..452)       names
#> [1] -------------------- P02340|P53_MOUSE
#> [2] -------------------- P10361|P53_RAT
#> [3] -------------------- Q00366|P53_MESAU
#> [4] -------------------- O09185|P53_CRIGR
#> [5] -------------------- Q95330|P53_RABIT
#> [6] -------------------- Q29537|P53_CANLF
#> [7] -------------------- Q9TTA1|P53_TUPBE
#> [8] -------------------- P04637|P53_HUMAN
#> [9] YWGIIEPPKLHTFKVCSVMI A0A2I2Y7Z8|A0A2I2...
#> Con -------------------- Consensus
```

### Distance Trees

The user guide to **msa** shows an example of converting the sequence alignment (like the one generated above) into a phylogenetic tree of sequence distances. Therefore, the IDP-specific matrices can be used for this type of analysis. The conversion uses both the **ape** and **seqinr** packages.

```
EDSS_MSA_Tree <- msa::msaConvert(EDSS_MSA, type = "seqinr::alignment")
d <- seqinr::dist.alignment(EDSS_MSA_Tree, "identity")
p53Tree <- ape::nj(d)
plot(p53Tree,
     main = "Phylogenetic Tree of p53 Sequences\nAligned with EDSSMat62")
```

![](data:image/png;base64...)

## References

### Packages

```
citation("Biostrings")
```

To cite package ‘Biostrings’ in publications use:

Pagès H, Aboyoun P, Gentleman R, DebRoy S (2025). *Biostrings: Efficient manipulation of biological strings*. doi:10.18129/B9.bioc.Biostrings <https://doi.org/10.18129/B9.bioc.Biostrings>, R package version 2.78.0, <https://bioconductor.org/packages/Biostrings>.

A BibTeX entry for LaTeX users is

@Manual{, title = {Biostrings: Efficient manipulation of biological strings}, author = {Hervé Pagès and Patrick Aboyoun and Robert Gentleman and Saikat DebRoy}, year = {2025}, note = {R package version 2.78.0}, url = {<https://bioconductor.org/packages/Biostrings>}, doi = {10.18129/B9.bioc.Biostrings}, }

```
citation("msa")
```

To cite package ‘msa’ in publications use:

U. Bodenhofer, E. Bonatesta, C. Horejs-Kainrath, and S. Hochreiter (2015) msa: an R package for multiple sequence alignment. Bioinformatics 31(24):3997-9999. DOI: 10.1093/bioinformatics/btv176.

A BibTeX entry for LaTeX users is

@Article{, title = {msa: an R package for multiple sequence alignment}, author = {Ulrich Bodenhofer and Enrico Bonatesta and Christoph Horejs-Kainrath and Sepp Hochreiter}, journal = {Bioinformatics}, volume = {31}, number = {24}, pages = {3997–3999}, year = {2015}, doi = {10.1093/bioinformatics/btv494}, }

If you use one of the three alignment algorithms, please cite the corresponding original paper.

To obtain the reference in BibTex format, enter ‘toBibtex(citation(“msa”))’

```
citation("ape")
```

To cite ape in a publication please use:

Paradis E, Schliep K (2019). “ape 5.0: an environment for modern phylogenetics and evolutionary analyses in R.” *Bioinformatics*, *35*, 526-528. doi:10.1093/bioinformatics/bty633 <https://doi.org/10.1093/bioinformatics/bty633>.

A BibTeX entry for LaTeX users is

@Article{, title = {ape 5.0: an environment for modern phylogenetics and evolutionary analyses in {R}}, author = {Emmanuel Paradis and Klaus Schliep}, journal = {Bioinformatics}, year = {2019}, volume = {35}, pages = {526-528}, doi = {10.1093/bioinformatics/bty633}, }

ape is evolving quickly, so you may want to cite its version number (found with ‘library(help = ape)’ or ‘packageVersion(“ape”)’).

```
citation("seqinr")
```

To cite seqinr in publications use:

Charif, D. and Lobry, J.R. (2007)

A BibTeX entry for LaTeX users is

@InCollection{, author = {D. Charif and J.R. Lobry}, title = {Seqin{R} 1.0-2: a contributed package to the {R} project for statistical computing devoted to biological sequences retrieval and analysis.}, booktitle = {Structural approaches to sequence evolution: Molecules, networks, populations}, year = {2007}, editor = {U. Bastolla and M. Porto and H.E. Roman and M. Vendruscolo}, series = {Biological and Medical Physics, Biomedical Engineering}, pages = {207-232}, address = {New York}, publisher = {Springer Verlag}, note = {{ISBN :} 978-3-540-35305-8}, }

### Citations

Brown, C. J., Johnson, A. K., & Daughdrill, G. W. (2009). Comparing Models of Evolution for Ordered and Disordered Proteins. Molecular Biology and Evolution, 27(3), 609-621. doi:10.1093/molbev/msp277

Brown, C. J., Johnson, A. K., Dunker, A. K., & Daughdrill, G. W. (2011). Evolution and disorder. Current Opinion in Structural Biology, 21(3), 441-446. doi:https://doi.org/10.1016/j.sbi.2011.02.005

Brown, C. J., Takayama, S., Campen, A. M., Vise, P., Marshall, T. W., Oldfield, C. J., . . . Dunker, A. K. (2002). Evolutionary rate heterogeneity in proteins with long disordered regions. Journal of molecular evolution, 55(1), 104.

Dayhoff, M., Schwartz, R., & Orcutt, B. (1978). 22 a model of evolutionary change in proteins. In Atlas of protein sequence and structure (Vol. 5, pp. 345-352): National Biomedical Research Foundation Silver Spring MD.

Franzosa, E. A., & Xia, Y. (2009). Structural Determinants of Protein Evolution Are Context-Sensitive at the Residue Level. Molecular Biology and Evolution, 26(10), 2387-2395. doi:10.1093/molbev/msp146

Hatos, A., Hajdu-Soltész, B., Monzon, A. M., Palopoli, N., Álvarez, L., Aykac-Fas, B., . . . Piovesan, D. (2019). DisProt: intrinsic protein disorder annotation in 2020. Nucleic acids research, 48(D1), D269-D276. doi:10.1093/nar/gkz975

Henikoff, S., & Henikoff, J. G. (1992). Amino acid substitution matrices from protein blocks. Proceedings of the National Academy of Sciences of the United States of America, 89(22), 10915-10919. doi:10.1073/pnas.89.22.10915

Johnson, M., Zaretskaya, I., Raytselis, Y., Merezhuk, Y., McGinnis, S., & Madden, T. L. (2008). NCBI BLAST: a better web interface. Nucleic acids research, 36(suppl\_2), W5-W9. doi:10.1093/nar/gkn201

Madeira, F., Park, Y. M., Lee, J., Buso, N., Gur, T., Madhusoodanan, N., . . . Finn, R. D. (2019). The EMBL-EBI search and sequence analysis tools APIs in 2019. Nucleic acids research, 47(W1), W636-W641.

Radivojac, P., Obradovic, Z., Brown, C. J., & Dunker, A. K. (2001). Improving sequence alignments for intrinsically disordered proteins. In Biocomputing 2002 (pp. 589-600): World Scientific.

Trivedi, R., & Nagarajaram, H. A. (2019). Amino acid substitution scoring matrices specific to intrinsically disordered regions in proteins. Scientific Reports, 9(1), 16380. doi:10.1038/s41598-019-52532-8

UniProt Consortium. (2019). UniProt: a worldwide hub of protein knowledge. Nucleic acids research, 47(D1), D506-D515.

Uversky, V. N. (2019). Intrinsically Disordered Proteins and Their “Mysterious” (Meta)Physics. Frontiers in Physics, 7(10). doi:10.3389/fphy.2019.00010

### Additional Information

R Version

```
R.version.string
#> [1] "R version 4.5.1 Patched (2025-08-23 r88802)"
```

System Infomation

```
as.data.frame(Sys.info())
#>                                                                 Sys.info()
#> sysname                                                              Linux
#> release                                                   6.8.0-79-generic
#> version        #79-Ubuntu SMP PREEMPT_DYNAMIC Tue Aug 12 14:42:46 UTC 2025
#> nodename                                                         nebbiolo2
#> machine                                                             x86_64
#> login                                                            biocbuild
#> user                                                             biocbuild
#> effective_user                                                   biocbuild
```

```
citation()
```

To cite R in publications use:

R Core Team (2025). *R: A Language and Environment for Statistical Computing*. R Foundation for Statistical Computing, Vienna, Austria. <https://www.R-project.org/>.

A BibTeX entry for LaTeX users is

@Manual{, title = {R: A Language and Environment for Statistical Computing}, author = {{R Core Team}}, organization = {R Foundation for Statistical Computing}, address = {Vienna, Austria}, year = {2025}, url = {<https://www.R-project.org/>}, }

We have invested a lot of time and effort in creating R, please cite it when using it for data analysis. See also ‘citation(“pkgname”)’ for citing R packages.