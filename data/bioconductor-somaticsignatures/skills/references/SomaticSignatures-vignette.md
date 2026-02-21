# Inferring Somatic Signatures from Single Nucleotide Variant Calls

## Table of Contents

* [1. Motivation: The Concept Behind Mutational Signatures](#orgheadline1)
* [2. Methodology: From Mutations to Somatic Signatures](#orgheadline2)
* [3. Workflow: Analysis with the SomaticSignatures Package](#orgheadline3)
* [4. Use case: Estimating Somatic Signatures from TCGA WES Studies](#orgheadline14)
  + [4.1. Data: Preproccessing of the TCGA WES Studies](#orgheadline4)
  + [4.2. Motifs: Extracting the Sequence Context of Somatic Variants](#orgheadline5)
  + [4.3. Decomposition: Inferring Somatic Signatures](#orgheadline6)
  + [4.4. Assessment: Number of Signatures](#orgheadline7)
  + [4.5. Visualization: Exploration of Signatures and Samples](#orgheadline9)
    - [4.5.1. Customization: Changing Plot Properties](#orgheadline8)
  + [4.6. Clustering: Grouping by Motifs or Samples](#orgheadline10)
  + [4.7. Extension: Correction for Batch Effects and Confounding Variables](#orgheadline11)
  + [4.8. Extension: Normalization of Sequence Motif Frequencies](#orgheadline12)
  + [4.9. Extension: Motifs from Non-Reference Genomes](#orgheadline13)
* [5. Alternatives: Inferring Somatic Signatures with Different Approaches](#orgheadline15)
* [6. Frequently Asked Questions](#orgheadline20)
  + [6.1. Citing SomaticSignatures](#orgheadline16)
  + [6.2. Getting Help](#orgheadline17)
  + [6.3. Installing and Upgrading](#orgheadline18)
  + [6.4. Working with VRanges](#orgheadline19)
* [7. References](#orgheadline21)
* [8. Session Information](#orgheadline22)

Julian Gehring, EMBL Heidelberg

## 1 Motivation: The Concept Behind Mutational Signatures

Recent publications introduced the concept of identifying mutational signatures
from cancer sequencing studies and linked them to potential mutation generation
processes [[11](#nik-zainal_mutational_2012),[2](#alexandrov_signatures_2013),[3](#alexandrov_deciphering_2013)]. Conceptually, this relates somatically
occurring *single nucleotide variants* (SNVs) to the surrounding sequence which
will be referred to as *mutational* or *somatic motifs* in the following. Based
on the frequency of the motifs occurring in multiple samples, these can be
decomposed mathematically into so called *mutational signatures*. In case of
the investigation of tumors, the term *somatic signatures* will be used here to
distinguish them from germline mutations and their generating processes.

The `SomaticSignatures` package provides an efficient and user-friendly
implementation for the extraction of somatic motifs based on a list of
somatically mutated genomic sites and the estimation of somatic signatures with
different matrix decomposition algorithms. Methodologically, this is based on
the work of Nik-Zainal and colleagues [[11](#nik-zainal_mutational_2012)]. If you
use `SomaticSignatures` in your research, please cite it as:

> Gehring, Julian S., Bernd Fischer, Michael Lawrence, and Wolfgang Huber.
> *SomaticSignatures: Inferring Mutational Signatures from Single Nucleotide
> Variants.*
> Bioinformatics, 2015, btv408. <http://dx.doi.org/10.1093/bioinformatics/btv408>

## 2 Methodology: From Mutations to Somatic Signatures

The basic idea of somatic signatures is composed of two parts:

Firstly, each somatic mutation is described in relation of the sequence context
in which it occurs. As an example, consider a SNV, resulting in the alteration
from `A` in the normal to `G` in the tumor sample, that is embedded in the
sequence context `TAC`. Thus, the somatic motif can be written as `TAC>TGC` or
`T.C A>G`. The frequency of these motifs across multiple samples is then
represented as a matrix \(M\_{ij}\), where \(i\) counts over the motifs and \(j\) over
the samples.

In a second step, the matrix \(M\) is numerically decomposed into two matrices \(W\)
and \(H\)

\(M\_{ij} \approx \sum\_{k=1}^{r} W\_{ik} H\_{kj}\)

for a fixed number \(r\) of signatures. While \(W\) describes the composition of
each signature in term of somatic motifs, \(H\) shows the contribution of the
signature to the alterations present in each sample.

## 3 Workflow: Analysis with the SomaticSignatures Package

The `SomaticSignatures` package offers a framework for inferring signatures of
SNVs in a user-friendly and efficient manner for large-scale data sets. A tight
integration with standard data representations of the `Bioconductor` project
[[8](#gentleman_bioconductor:_2004)] was a major design goal. Further, it extends
the selection of multivariate statistical methods for the matrix decomposition
and allows a simple visualization of the results.

For a typical workflow, a set of variant calls and the reference sequence are
needed. Ideally, the SNVs are represented as a `VRanges` object with the
genomic location as well as reference and alternative allele defined. The
reference sequence can be, for example, a `FaFile` object, representing an
indexed FASTA file, a `BSgenome` object, or a `GmapGenome` object.
Alternatively, we provide functions to extract the relevant information from
other sources of inputs. At the moment, this covers the *MuTect*
[[4](#cibulskis_sensitive_2013)] variant caller.

Generally, the individual steps of the analysis can be summarized as:

1. The somatic motifs for each variant are retrieved from the reference sequence
   with the `mutationContext` function and converted to a matrix representation
   with the `motifMatrix` function.
2. Somatic signatures are estimated with a method of choice (the package
   provides with `nmfDecomposition` and `pcaDecomposition` two approaches for
   the NMF and PCA).
3. The somatic signatures and their representation in the samples are assessed
   with a set of accessor and plotting functions.

To decompose \(M\), the `SomaticSignatures` package implements two methods:

Non-negative matrix factorization (NMF)
:   The NMF decomposes \(M\) with the
    constraint of positive components in \(W\) and \(H\)
    [[7](#gaujoux_flexible_2010)]. The method was used
    [[11](#nik-zainal_mutational_2012)] for the identification of mutational
    signatures, and can be computationally expensive for large data sets.

Principal component analysis (PCA)
:   The PCA employs the eigenvalue
    decomposition and is therefore suitable for large data sets
    [[13](#stacklies_pcamethodsbioconductor_2007)]. While this is related to the
    NMF, no constraint on the sign of the elements of \(W\) and \(H\) exists.

Other methods can be supplied through the `decomposition` argument of the
`identifySignatures` function.

## 4 Use case: Estimating Somatic Signatures from TCGA WES Studies

In the following, the concept of somatic signatures and the steps for inferring
these from an actual biological data set are shown. For the example, somatic
variant calls from whole exome sequencing (WES) studies from The Cancer Genome
Atlas (TCGA) project will be used, which are part of the
`SomaticCancerAlterations` package.

```
library(SomaticSignatures)
```

```
library(SomaticCancerAlterations)
library(BSgenome.Hsapiens.1000genomes.hs37d5)
```

### 4.1 Data: Preproccessing of the TCGA WES Studies

The `SomaticCancerAlterations` package provides the somatic SNV calls for eight
WES studies, each investigating a different cancer type. The metadata
summarizes the biological and experimental settings of each study.

```
sca_metadata = scaMetadata()

sca_metadata
```

```
             Cancer_Type       Center NCBI_Build Sequence_Source
   gbm_tcga          GBM broad.mi....         37             WXS
   hnsc_tcga        HNSC broad.mi....         37         Capture
   kirc_tcga        KIRC broad.mi....         37         Capture
   luad_tcga        LUAD broad.mi....         37             WXS
   lusc_tcga        LUSC broad.mi....         37             WXS
   ov_tcga            OV broad.mi....         37             WXS
   skcm_tcga        SKCM broad.mi....         37         Capture
   thca_tcga        THCA broad.mi....         37             WXS
             Sequencing_Phase    Sequencer Number_Samples
   gbm_tcga           Phase_I Illumina....            291
   hnsc_tcga          Phase_I Illumina....            319
   kirc_tcga          Phase_I Illumina....            297
   luad_tcga          Phase_I Illumina....            538
   lusc_tcga          Phase_I Illumina....            178
   ov_tcga            Phase_I Illumina....            142
   skcm_tcga          Phase_I Illumina....            266
   thca_tcga          Phase_I Illumina....            406
             Number_Patients                           Cancer_Name
   gbm_tcga              291               Glioblastoma multiforme
   hnsc_tcga             319 Head and Neck squamous cell carcinoma
   kirc_tcga             293                    Kidney Chromophobe
   luad_tcga             519                   Lung adenocarcinoma
   lusc_tcga             178          Lung squamous cell carcinoma
   ov_tcga               142     Ovarian serous cystadenocarcinoma
   skcm_tcga             264               Skin Cutaneous Melanoma
   thca_tcga             403                    Thyroid carcinoma
```

The starting point of the analysis is a `VRanges` object which describes the
somatic variants in terms of their genomic locations as well as reference and
alternative alleles. For more details about this class and how to construct it,
please see the documentation of the `VariantAnnotation` package
[[12](#obenchain_variantannotation:_2011)]. In this example, all mutational calls
of a study will be pooled together, in order to find signatures related to a
specific cancer type.

```
sca_data = unlist(scaLoadDatasets())

sca_data$study = factor(gsub("(.*)_(.*)", "\\1", toupper(names(sca_data))))
sca_data = unname(subset(sca_data, Variant_Type %in% "SNP"))
library(GenomeInfoDb)  # for keepSeqlevels()
sca_data = keepSeqlevels(sca_data, hsAutosomes(), pruning.mode = "coarse")

sca_vr = VRanges(
    seqnames = seqnames(sca_data),
    ranges = ranges(sca_data),
    ref = sca_data$Reference_Allele,
    alt = sca_data$Tumor_Seq_Allele2,
    sampleNames = sca_data$Patient_ID,
    seqinfo = seqinfo(sca_data),
    study = sca_data$study)

sca_vr
```

```
   VRanges object with 594607 ranges and 1 metadata column:
              seqnames    ranges strand         ref              alt
                 <Rle> <IRanges>  <Rle> <character> <characterOrRle>
          [1]        1    887446      *           G                A
          [2]        1    909247      *           C                T
          [3]        1    978952      *           C                T
          [4]        1    981607      *           G                A
          [5]        1    985841      *           C                T
          ...      ...       ...    ...         ...              ...
     [594603]       22  50961303      *           G                T
     [594604]       22  50967746      *           C                A
     [594605]       22  50967746      *           C                A
     [594606]       22  51044090      *           C                T
     [594607]       22  51044095      *           G                A
                  totalDepth       refDepth       altDepth   sampleNames
              <integerOrRle> <integerOrRle> <integerOrRle> <factorOrRle>
          [1]           <NA>           <NA>           <NA>  TCGA-06-5858
          [2]           <NA>           <NA>           <NA>  TCGA-32-1977
          [3]           <NA>           <NA>           <NA>  TCGA-06-0237
          [4]           <NA>           <NA>           <NA>  TCGA-06-0875
          [5]           <NA>           <NA>           <NA>  TCGA-06-6693
          ...            ...            ...            ...           ...
     [594603]           <NA>           <NA>           <NA>  TCGA-BJ-A0Z0
     [594604]           <NA>           <NA>           <NA>  TCGA-BJ-A2NA
     [594605]           <NA>           <NA>           <NA>  TCGA-BJ-A2NA
     [594606]           <NA>           <NA>           <NA>  TCGA-EM-A3FK
     [594607]           <NA>           <NA>           <NA>  TCGA-EL-A3T0
              softFilterMatrix |    study
                      <matrix> | <factor>
          [1]                  |      GBM
          [2]                  |      GBM
          [3]                  |      GBM
          [4]                  |      GBM
          [5]                  |      GBM
          ...              ... .      ...
     [594603]                  |     THCA
     [594604]                  |     THCA
     [594605]                  |     THCA
     [594606]                  |     THCA
     [594607]                  |     THCA
     -------
     seqinfo: 22 sequences from an unspecified genome
     hardFilters: NULL
```

To get a first impression of the data, we count the number of somatic variants
per study.

```
sort(table(sca_vr$study), decreasing = TRUE)
```

```
     LUAD   SKCM   HNSC   LUSC   KIRC    GBM   THCA     OV
   208724 200589  67125  61485  24158  19938   6716   5872
```

### 4.2 Motifs: Extracting the Sequence Context of Somatic Variants

In a first step, the sequence motif for each variant is extracted based on the
genomic sequence. Here, the `BSgenomes` object of the human hg19 reference is
used for all samples. However, [personalized genomes or other sources for
sequences](#orgtarget1), for example an indexed FASTA file, can be used naturally.
Additionally, we transform all motifs to have a pyrimidine base (`C` or `T`) as
a reference base [[2](#alexandrov_signatures_2013)]. The resulting `VRanges` object
then contains the new columns `context` and `alteration` which specify the
sequence content and the base substitution.

```
sca_motifs = mutationContext(sca_vr, BSgenome.Hsapiens.1000genomes.hs37d5)
head(sca_motifs)
```

```
   VRanges object with 6 ranges and 3 metadata columns:
         seqnames    ranges strand         ref              alt
            <Rle> <IRanges>  <Rle> <character> <characterOrRle>
     [1]        1    887446      *           G                A
     [2]        1    909247      *           C                T
     [3]        1    978952      *           C                T
     [4]        1    981607      *           G                A
     [5]        1    985841      *           C                T
     [6]        1   1120451      *           C                T
             totalDepth       refDepth       altDepth   sampleNames
         <integerOrRle> <integerOrRle> <integerOrRle> <factorOrRle>
     [1]           <NA>           <NA>           <NA>  TCGA-06-5858
     [2]           <NA>           <NA>           <NA>  TCGA-32-1977
     [3]           <NA>           <NA>           <NA>  TCGA-06-0237
     [4]           <NA>           <NA>           <NA>  TCGA-06-0875
     [5]           <NA>           <NA>           <NA>  TCGA-06-6693
     [6]           <NA>           <NA>           <NA>  TCGA-26-1439
         softFilterMatrix |    study     alteration        context
                 <matrix> | <factor> <DNAStringSet> <DNAStringSet>
     [1]                  |      GBM             CT            G.G
     [2]                  |      GBM             CT            A.G
     [3]                  |      GBM             CT            G.G
     [4]                  |      GBM             CT            G.C
     [5]                  |      GBM             CT            A.G
     [6]                  |      GBM             CT            C.G
     -------
     seqinfo: 22 sequences from an unspecified genome
     hardFilters: NULL
```

To continue with the estimation of the somatic signatures, the matrix \(M\) of the
form {motifs × studies} is constructed. The `normalize` argument specifies
that frequencies rather than the actual counts are returned.

```
sca_mm = motifMatrix(sca_motifs, group = "study", normalize = TRUE)

head(round(sca_mm, 4))
```

```
             GBM   HNSC   KIRC   LUAD   LUSC     OV   SKCM   THCA
   CA A.A 0.0083 0.0098 0.0126 0.0200 0.0165 0.0126 0.0014 0.0077
   CA A.C 0.0093 0.0082 0.0121 0.0217 0.0156 0.0192 0.0009 0.0068
   CA A.G 0.0026 0.0061 0.0046 0.0144 0.0121 0.0060 0.0004 0.0048
   CA A.T 0.0057 0.0051 0.0070 0.0134 0.0100 0.0092 0.0007 0.0067
   CA C.A 0.0075 0.0143 0.0215 0.0414 0.0390 0.0128 0.0060 0.0112
   CA C.C 0.0075 0.0111 0.0138 0.0415 0.0275 0.0143 0.0018 0.0063
```

The observed occurrence of the motifs, also termed *somatic spectrum*, can be
visualized across studies, which gives a first impression of the data. The
distribution of the motifs clearly varies between the studies.

```
plotMutationSpectrum(sca_motifs, "study")
```

```
   Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
   ℹ Please use tidy evaluation idioms with `aes()`.
   ℹ See also `vignette("ggplot2-in-packages")` for more information.
   ℹ The deprecated feature was likely used in the SomaticSignatures
     package.
     Please report the issue at <https://support.bioconductor.org>.
   This warning is displayed once every 8 hours.
   Call `lifecycle::last_lifecycle_warnings()` to see where this warning
   was generated.
```

![Mutation spectrum over studies](data:image/png;base64...)

Mutation spectrum over studies

### 4.3 Decomposition: Inferring Somatic Signatures

The somatic signatures can be estimated with each of the statistical methods
implemented in the package. Here, we will use the `NMF` and `PCA`, and compare
the results. Prior to the estimation, the number \(r\) of signatures to obtain
has to be fixed; in this example, the data will be decomposed into 5 signatures.

```
n_sigs = 5

sigs_nmf = identifySignatures(sca_mm, n_sigs, nmfDecomposition)

sigs_pca = identifySignatures(sca_mm, n_sigs, pcaDecomposition)
```

```
sigs_nmf
```

```
   MutationalSignatures:
     Samples (8): GBM, HNSC, ..., SKCM, THCA
     Signatures (5): S1, S2, S3, S4, S5
     Motifs (96): CA A.A, CA A.C, ..., TG T.G, TG T.T
```

```
sigs_pca
```

```
   MutationalSignatures:
     Samples (8): GBM, HNSC, ..., SKCM, THCA
     Signatures (5): S1, S2, S3, S4, S5
     Motifs (96): CA A.A, CA A.C, ..., TG T.G, TG T.T
```

The individual matrices can be further inspected through the accessors
`signatures`, `samples`, `observed` and `fitted`.

### 4.4 Assessment: Number of Signatures

Up to now, we have performed the decomposition based on a known number \(r\) of
signatures. In many settings, prior biological knowledge or complementing
experiments may allow to determine \(r\) independently. If this is not the case,
we can try to infer suitable values for \(r\) from the data.

Using the `assessNumberSignatures` function, we can compute the residuals sum of
squares (RSS) and the explained variance between the observed \(M\) and fitted
\(WH\) mutational spectrum for different numbers of signatures. These measures
are generally applicable to all kinds of decomposition methods, and can aid in
choosing a likely number of signatures. The usage and arguments are analogous
to the `identifySignatures` function.

```
n_sigs = 2:8

gof_nmf = assessNumberSignatures(sca_mm, n_sigs, nReplicates = 5)

gof_pca = assessNumberSignatures(sca_mm, n_sigs, pcaDecomposition)
```

The obtained statistics can further be visualized with the
`plotNumberSignatures`. For each tested number of signatures, black crosses
indicate the results of individual runs, while the red dot represents the
average over all respective runs. Please note that having multiple runs is only
relevant for randomly seeded decomposition methods, as the NMF in our example.

```
plotNumberSignatures(gof_nmf)
```

```
   Warning: The `fun.y` argument of `stat_summary()` is deprecated as of ggplot2
   3.3.0.
   ℹ Please use the `fun` argument instead.
   ℹ The deprecated feature was likely used in the SomaticSignatures
     package.
     Please report the issue at <https://support.bioconductor.org>.
   This warning is displayed once every 8 hours.
   Call `lifecycle::last_lifecycle_warnings()` to see where this warning
   was generated.
```

![Summary statistics for selecting the number of signatures in the NMF decomposition.](data:image/png;base64...)

Summary statistics for selecting the number of signatures in the NMF decomposition.

```
plotNumberSignatures(gof_pca)
```

![Summary statistics for selecting the number of signatures in the PCA decomposition.](data:image/png;base64...)

Summary statistics for selecting the number of signatures in the PCA decomposition.

\(r\) can then be chosen such that increasing the number of signatures does not
yield a significantly better approximation of the data, i.e. that the RSS and
the explained variance do not change sufficiently for more complex models. The
first inflection point of the RSS curve has also been proposed as a measure for
the number of features in this context [[9](#hutchins_position-dependent_2008)].
Judging from both statistics for our dataset, a total of 5 signatures seems to
explain the characteristics of the observed mutational spectrum well. In
practice, a combination of a statistical assessment paired with biological
knowledge about the nature of the data will allow for the most reliable
interpretation of the results.

### 4.5 Visualization: Exploration of Signatures and Samples

To explore the results for the TCGA data set, we will use the plotting
functions. All figures are generated with the `ggplot2` package, and thus,
their properties and appearances can directly be modified, even at a later
stage.

```
library(ggplot2)
```

Focusing on the results of the NMF first, the five somatic signatures (named S1
to S5) can be visualized either as a heatmap or as a barchart.

```
plotSignatureMap(sigs_nmf) + ggtitle("Somatic Signatures: NMF - Heatmap")
```

![Composition of somatic signatures estimated with the NMF, represented as a heatmap.](data:image/png;base64...)

Composition of somatic signatures estimated with the NMF, represented as a heatmap.

```
plotSignatures(sigs_nmf) + ggtitle("Somatic Signatures: NMF - Barchart")
```

![Composition of somatic signatures estimated with the NMF, represented as a barchart.](data:image/png;base64...)

Composition of somatic signatures estimated with the NMF, represented as a barchart.

```
plotObservedSpectrum(sigs_nmf)
```

![plot of chunk unnamed-chunk-5](data:image/png;base64...)

```
plotFittedSpectrum(sigs_nmf)
```

![plot of chunk unnamed-chunk-6](data:image/png;base64...)

Each signature represents different properties of the somatic spectrum observed
in the data. While signature S1 is mainly characterized by selective `C>T`
alterations, others as S4 and S5 show a broad distribution across the motifs.

In addition, the contribution of the signatures in each study can be represented
with the same sets of plots. Signature S1 and S3 are strongly represented in
the GBM and SKCM study, respectively. Other signatures show a weaker
association with a single cancer type.

```
plotSampleMap(sigs_nmf)
```

![Occurrence of signatures estimated with the NMF, represented as a heatmap.](data:image/png;base64...)

Occurrence of signatures estimated with the NMF, represented as a heatmap.

```
plotSamples(sigs_nmf)
```

```
   Warning in geom_bar(aes_string(x = "sample", y = "value", fill =
   "signature"), : Ignoring unknown parameters: `size`
```

![Occurrence of signatures estimated with the NMF, represented as a barchart.](data:image/png;base64...)

Occurrence of signatures estimated with the NMF, represented as a barchart.

In the same way as before, the results of the PCA can be visualized. In
contrast to the NMF, the signatures also contain negative values, indicating the
depletion of a somatic motif.

Comparing the results of the two methods, we can see similar characteristics
between the sets of signatures, for example S1 of the NMF and S2 of the PCA.

```
plotSignatureMap(sigs_pca) + ggtitle("Somatic Signatures: PCA - Heatmap")
```

![Composition of somatic signatures estimated with the PCA, represented as a heatmap.](data:image/png;base64...)

Composition of somatic signatures estimated with the PCA, represented as a heatmap.

```
plotSignatures(sigs_pca) + ggtitle("Somatic Signatures: PCA - Barchart")
```

![Composition of somatic signatures estimated with the PCA, represented as a barchart.](data:image/png;base64...)

Composition of somatic signatures estimated with the PCA, represented as a barchart.

```
plotFittedSpectrum(sigs_pca)
```

![plot of chunk unnamed-chunk-7](data:image/png;base64...)

Since the observed mutational spectrum is defined by the data alone, it is
identical for both all decomposition methods.

```
plotObservedSpectrum(sigs_pca)
```

![plot of chunk unnamed-chunk-8](data:image/png;base64...)

#### 4.5.1 Customization: Changing Plot Properties

As elaborated before, since all plots are generated with the `ggplot2` framework
[[15](#wickham_ggplot2:_2010)], we can change all their properties. To continue the
example from before, we will visualize the relative contribution of the
mutational signatures in the studies, and change the plot to fit our needs
better.

```
library(ggplot2)
```

```
p = plotSamples(sigs_nmf)
```

```
   Warning in geom_bar(aes_string(x = "sample", y = "value", fill =
   "signature"), : Ignoring unknown parameters: `size`
```

```
## (re)move the legend
p = p + theme(legend.position = "none")
## (re)label the axis
p = p + xlab("Studies")
## add a title
p = p + ggtitle("Somatic Signatures in TGCA WES Data")
## change the color scale
p = p + scale_fill_brewer(palette = "Blues")
## decrease the size of x-axis labels
p = p + theme(axis.text.x = element_text(size = 9))
```

```
p
```

![Occurrence of signatures estimated with the NMF, customized plot. See the original plot above for comparisons.](data:image/png;base64...)

Occurrence of signatures estimated with the NMF, customized plot. See the original plot above for comparisons.

If you want to visualize a large number of samples or signatures, the default
color palette may not provide a sufficient number of distinct colors. You can
add a well-suited palette to your plot, as we have shown before with the
`scale_fill` functions. For example, `scale_fill_discrete` will get you the
default `ggplot2` color scheme; while this supports many more colors, the
individual levels may be hard to distinguish.

### 4.6 Clustering: Grouping by Motifs or Samples

An alternative approach to interpreting the mutational spectrum by decomposition
is clustering. With the `clusterSpectrum` function, the clustering is computed,
by grouping either by the `sample` or `motif` dimension of the spectrum. By
default, the Euclidean distance is used; other distance measures, as for example
cosine similarity, are implemented is the `proxy` package and can be passed as
an optional argument.

```
clu_motif = clusterSpectrum(sca_mm, "motif")
```

```
library(ggdendro)

p = ggdendrogram(clu_motif, rotate = TRUE)
p
```

![Hierachical clustering of the mutational spectrum, according to motif.](data:image/png;base64...)

Hierachical clustering of the mutational spectrum, according to motif.

### 4.7 Extension: Correction for Batch Effects and Confounding Variables

When investigating somatic signatures between samples from different studies,
corrections for technical confounding factors should be considered. In our use
case of the TCGA WES studies, this is of minor influence due to similar
sequencing technology and variant calling methods across the studies.
Approaches for the identification of so termed batch effects have been proposed
[[10](#leek_capturing_2007),[14](#sun_multiple_2012)] and existing implementations can
be used in identifying confounding variables as well as correcting for them.
The best strategy in addressing technical effects depends strongly on the
experimental design; we recommend reading the respective literature and software
documentation for finding an optimal solution in complex settings.

From the metadata of the TCGA studies, we have noticed that two different
sequencing approaches have been employed, constituting a potential technical
batch effect. The `ComBat` function of the `sva` package allows us to adjust
for this covariate, which yields a mutational spectrum corrected for
contributions related to sequencing technology. We can then continue with the
identification of somatic signatures as we have seen before.

```
library(sva)
```

```
sca_anno = as.data.frame(lapply(sca_metadata, unlist))

model_null = model.matrix(~ 1, sca_anno)

sca_mm_batch = ComBat(sca_mm, batch = sca_anno$Sequence_Source, mod = model_null)
```

```
   Found2batches
```

```
   Adjusting for0covariate(s) or covariate level(s)
```

```
   Standardizing Data across genes
```

```
   Fitting L/S model and finding priors
```

```
   Finding parametric adjustments
```

```
   Adjusting the Data
```

### 4.8 Extension: Normalization of Sequence Motif Frequencies

If comparisons are performed across samples or studies with different capture
targets, for example by comparing whole exome with whole genome sequencing,
further corrections for the frequency of sequence motifs can be taken into
account [[11](#nik-zainal_mutational_2012)]. The `kmerFrequency` function provides
the basis for calculating the occurrence of k-mers over a set of ranges of a
reference sequence.

As an example, we compute the frequency of 3-mers for the human toplevel
chromosomes, based on a sample of 10'000 locations.

```
k = 3
n = 1e4

hs_chrs = as(seqinfo(BSgenome.Hsapiens.1000genomes.hs37d5), "GRanges")
hs_chrs = keepSeqlevels(hs_chrs, c(1:22, "X", "Y"), pruning.mode = "coarse")

k3_hs_chrs = kmerFrequency(BSgenome.Hsapiens.1000genomes.hs37d5, n, k, hs_chrs)
k3_hs_chrs
```

Analogously, the k-mer occurrence across a set of enriched regions, such as in
exome or targeted sequencing, can be obtained easily. The following outlines
how to apply the approach to the human exome.

```
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

k = 3
n = 1e4

hs_exons = reduce(exons(TxDb.Hsapiens.UCSC.hg19.knownGene))
hs_exons = ncbi(keepStandardChromosomes(hs_exons))

k3_exons = kmerFrequency(BSgenome.Hsapiens.1000genomes.hs37d5, n, k, hs_exons)
```

With the `normalizeMotifs` function, the frequency of motifs can be adjusted.
Here, we will transform our results of the TCGA WES studies to have the same
motif distribution as of a whole-genome analysis. The `kmers` dataset contains
the estimated frequency of 3-mers across the human genome and exome.

```
data(kmers)
norms = k3wg / k3we
head(norms)
```

```
   seq
         AAA       AAC       AAG       AAT       ACA       ACC
   1.4519030 1.1022862 1.0248394 1.5075775 1.1089220 0.8910534
```

```
sca_mm_norm = normalizeMotifs(sca_mm, norms)
```

### 4.9 Extension: Motifs from Non-Reference Genomes

When we [determine the sequence context](#orgtarget2) for each alteration, we typically use one
of the reference BSgenome packages in Bioconductor. But we are not restricted
to those, and derive the somatic motifs from different types of sequence
sources, for example 2bit and FASTA files. More precisely, the
`mutationContext` function will work on any object for which a `getSeq` method
is defined. You can get the full list available on your system, the results may
vary depending on which packages you have loaded.

```
showMethods("getSeq")
```

```
   Function: getSeq (package Biostrings)
   x="BSgenome"
   x="FaFile"
   x="FaFileList"
   x="TwoBitFile"
   x="XStringSet"
```

This allows us to perform our analysis also on non-standard organisms and
genomes, for which a BSgenome package is not available, for example the
1000genomes human reference sequence. Or we can generate genomic references for
specific populations, by updating the standard genomes with a set of known
variants; see the documentation of the `BSgenome` package and the `injectSNPs`
function in particular for this.

Taking further, we can base our analysis on the personalized genomic sequence
for each individual, in case it is available. If we imagined that we had a set
of somatic variant calls as `VCF` files and the personalized genomic sequence as
`FASTA` files for two individuals `A` and `B` at hand, here a simple outline on
how our analysis could work.

```
## Somatic variant calls
vr_A = readVcfAsVRanges(vcf_A_path, "GenomeA")
vr_B = readVcfAsVRanges(vcf_B_path, "GenomeB")

## Genomic sequences
fa_A = FaFile(fasta_A_path)
fa_B = FaFile(fasta_B_path)

## Somatic motifs
vr_A = mutationContext(vr_A, fa_A)
vr_B = mutationContext(vr_B, fa_B)

## Combine for further analysis
vr = c(vr_A, vr_B)
```

## 5 Alternatives: Inferring Somatic Signatures with Different Approaches

For the identification of somatic signatures, other methods and implementations
exist. The original framework [[11](#nik-zainal_mutational_2012),[3](#alexandrov_deciphering_2013)] proposed for this is based on the NMF and
available for the Matlab programming language [[1](#alexandrov_wtsi_2012)]. In
extension, a probabilistic approach based on Poisson processes has been proposed
[[6](#fischer_emu:_2013-1)] and implemented [[5](#fischer_emu:_2013)].

## 6 Frequently Asked Questions

### 6.1 Citing SomaticSignatures

If you use the `SomaticSignatures` package in your work, please cite it:

```
citation("SomaticSignatures")
```

```
   To cite package 'SomaticSignatures' in publications use:

     Julian S. Gehring, Bernd Fischer, Michael Lawrence, Wolfgang
     Huber (2015): SomaticSignatures: Inferring Mutational
     Signatures from Single Nucleotide Variants. Bioinformatics
     July 10, 2015, btv408. doi:10.1093/bioinformatics/btv408

   A BibTeX entry for LaTeX users is

     @Article{,
       title = {SomaticSignatures: Inferring Mutational Signatures from Single Nucleotide Variants.},
       author = {Julian S. Gehring and Bernd Fischer and Michael Lawrence and Wolfgang Huber},
       year = {2015},
       journal = {Bioinformatics},
       doi = {10.1093/bioinformatics/btv408},
     }
```

### 6.2 Getting Help

We welcome questions or suggestions about our software, and want to ensure that
we eliminate issues if and when they appear. We have a few requests to optimize
the process:

* All questions and follow-ups should take place over the [Bioconductor support
  site](http://support.bioconductor.org/), which serves as a repository of information. First search the site for
  past threads which might have answered your question.
* The subject line should contain *SomaticSignatures* and a few words describing
  the problem.
* If you have a question about the behavior of a function, read the sections of
  the manual page for this function by typing a question mark and the function
  name, e.g. `?mutationContext`. Additionally, read through the vignette to
  understand the interplay between different functions of the package. We spend
  a lot of time documenting individual functions and the exact steps that the
  software is performing.
* Include all of your R code and its output related to the question you are
  asking.
* Include complete warning or error messages, and conclude your message with the
  full output of `sessionInfo()`.

### 6.3 Installing and Upgrading

Before you want to install the `SomaticSignatures` package, please ensure that
you have the latest version of `R` and `Bioconductor` installed. For details on
this, please have a look at the help packages for [R](http://cran.r-project.org/) and [Bioconductor](http://bioconductor.org/install/). Then you
can open `R` and run the following commands which will install the latest
release version of `SomaticSignatures`:

```
source("http://bioconductor.org/biocLite.R")
biocLite("SomaticSignatures")
```

Over time, the packages may also receive updates with bug fixes. These
installed packages can be updated with:

```
source("http://bioconductor.org/biocLite.R")
biocLite()
```

### 6.4 Working with VRanges

A central object in the workflow of `SomaticSignatures` is the `VRanges` class
which is part of the `VariantAnnotation` package. It builds upon the commonly
used `GRanges` class of the `GenomicRanges` package. Essentially, each row
represents a variant in terms of its genomic location as well as its reference
and alternative allele.

```
library(VariantAnnotation)
```

There are multiple ways of converting its own variant calls into a `VRanges`
object. One can for example import them from a `VCF` file with the `readVcf`
function or employ the `readMutect` function for importing variant calls from
the `MuTect` caller directly. Further, one can also construct it from any other
format in the form of:

```
vr = VRanges(
    seqnames = "chr1",
    ranges = IRanges(start = 1000, width = 1),
    ref = "A",
    alt = "C")

vr
```

```
   VRanges object with 1 range and 0 metadata columns:
         seqnames    ranges strand         ref              alt
            <Rle> <IRanges>  <Rle> <character> <characterOrRle>
     [1]     chr1      1000      *           A                C
             totalDepth       refDepth       altDepth   sampleNames
         <integerOrRle> <integerOrRle> <integerOrRle> <factorOrRle>
     [1]           <NA>           <NA>           <NA>          <NA>
         softFilterMatrix
                 <matrix>
     [1]
     -------
     seqinfo: 1 sequence from an unspecified genome; no seqlengths
     hardFilters: NULL
```

## 7 References

## References

|  |  |
| --- | --- |
| [1] | L. Alexandrov. WTSI Mutational Signature Framework, Oct. 2012. [ [http](http://www.mathworks.de/matlabcentral/fileexchange/38724-wtsi-mutational-signature-framework) ] |
| [2] | L. B. Alexandrov, S. Nik-Zainal, D. C. Wedge, S. A. J. R. Aparicio, S. Behjati, A. V. Biankin, G. R. Bignell, N. Bolli, A. Borg, A.-L. Børresen-Dale, S. Boyault, B. Burkhardt, A. P. Butler, C. Caldas, H. R. Davies, C. Desmedt, R. Eils, J. E. Eyfjörd, J. A. Foekens, M. Greaves, F. Hosoda, B. Hutter, T. Ilicic, S. Imbeaud, M. Imielinsk, N. Jäger, D. T. W. Jones, D. Jones, S. Knappskog, M. Kool, S. R. Lakhani, C. López-Otín, S. Martin, N. C. Munshi, H. Nakamura, P. A. Northcott, M. Pajic, E. Papaemmanuil, A. Paradiso, J. V. Pearson, X. S. Puente, K. Raine, M. Ramakrishna, A. L. Richardson, J. Richter, P. Rosenstiel, M. Schlesner, T. N. Schumacher, P. N. Span, J. W. Teague, Y. Totoki, A. N. J. Tutt, R. Valdés-Mas, M. M. van Buuren, L. v. . Veer, A. Vincent-Salomon, N. Waddell, L. R. Yates, Australian Pancreatic Cancer Genome Initiative, ICGC Breast Cancer Consortium, ICGC MMML-Seq Consortium, Icgc PedBrain, J. Zucman-Rossi, P. Andrew Futreal, U. McDermott, P. Lichter, M. Meyerson, S. M. Grimmond, R. Siebert, E. Campo, T. Shibata, S. M. Pfister, P. J. Campbell, and M. R. Stratton. Signatures of mutational processes in human cancer. *Nature*, 500(7463):415-421, Aug. 2013. [ [DOI](http://dx.doi.org/10.1038/nature12477) | [.html](http://www.nature.com/nature/journal/v500/n7463/full/nature12477.html) ] |
| [3] | L. B. Alexandrov, S. Nik-Zainal, D. C. Wedge, P. J. Campbell, and M. R. Stratton. Deciphering Signatures of Mutational Processes Operative in Human Cancer. *Cell Reports*, 3(1):246-259, Jan. 2013. [ [DOI](http://dx.doi.org/10.1016/j.celrep.2012.12.008) | [http](http://www.sciencedirect.com/science/article/pii/S2211124712004330) ] |
| [4] | K. Cibulskis, M. S. Lawrence, S. L. Carter, A. Sivachenko, D. Jaffe, C. Sougnez, S. Gabriel, M. Meyerson, E. S. Lander, and G. Getz. Sensitive detection of somatic point mutations in impure and heterogeneous cancer samples. *Nature Biotechnology*, advance online publication, Feb. 2013. [ [DOI](http://dx.doi.org/10.1038/nbt.2514) | [.html](http://www.nature.com/nbt/journal/vaop/ncurrent/full/nbt.2514.html) ] |
| [5] | A. Fischer, C. J. Illingworth, P. J. Campbell, and V. Mustonen. EMu: probabilistic inference of mutational processes and their localization in the cancer genome. *Genome biology*, 14(4):R39, Apr. 2013. [ [DOI](http://dx.doi.org/10.1186/gb-2013-14-4-r39) ] |
| [6] | A. Fischer. EMu: Expectation-Maximisation inference of mutational signatures, 2013. [ [http](http://www.sanger.ac.uk/resources/software/emu/) ] |
| [7] | R. Gaujoux and C. Seoighe. A flexible R package for nonnegative matrix factorization. *BMC Bioinformatics*, 11(1):367, July 2010. [ [DOI](http://dx.doi.org/10.1186/1471-2105-11-367) | [http](http://www.biomedcentral.com/1471-2105/11/367/abstract) ] |
| [8] | R. C. Gentleman, V. J. Carey, D. M. Bates, B. Bolstad, M. Dettling, S. Dudoit, B. Ellis, L. Gautier, Y. Ge, J. Gentry, K. Hornik, T. Hothorn, W. Huber, S. Iacus, R. Irizarry, F. Leisch, C. Li, M. Maechler, A. J. Rossini, G. Sawitzki, C. Smith, G. Smyth, L. Tierney, J. Y. Yang, and J. Zhang. Bioconductor: open software development for computational biology and bioinformatics. *Genome Biology*, 5(10):R80, Sept. 2004. [ [DOI](http://dx.doi.org/10.1186/gb-2004-5-10-r80) | [http](http://genomebiology.com/2004/5/10/R80/abstract) ] |
| [9] | L. N. Hutchins, S. M. Murphy, P. Singh, and J. H. Graber. Position-dependent motif characterization using non-negative matrix factorization. *Bioinformatics*, 24(23):2684-2690, Dec. 2008. [ [DOI](http://dx.doi.org/10.1093/bioinformatics/btn526) | [http](http://bioinformatics.oxfordjournals.org/content/24/23/2684) ] |
| [10] | J. T. Leek and J. D. Storey. Capturing Heterogeneity in Gene Expression Studies by Surrogate Variable Analysis. *PLoS Genet*, 3(9):e161, Sept. 2007. [ [DOI](http://dx.doi.org/10.1371/journal.pgen.0030161) | [http](http://dx.plos.org/10.1371/journal.pgen.0030161) ] |
| [11] | S. Nik-Zainal, L. B. Alexandrov, D. C. Wedge, P. Van Loo, C. D. Greenman, K. Raine, D. Jones, J. Hinton, J. Marshall, L. A. Stebbings, A. Menzies, S. Martin, K. Leung, L. Chen, C. Leroy, M. Ramakrishna, R. Rance, K. W. Lau, L. J. Mudie, I. Varela, D. J. McBride, G. R. Bignell, S. L. Cooke, A. Shlien, J. Gamble, I. Whitmore, M. Maddison, P. S. Tarpey, H. R. Davies, E. Papaemmanuil, P. J. Stephens, S. McLaren, A. P. Butler, J. W. Teague, G. Jönsson, J. E. Garber, D. Silver, P. Miron, A. Fatima, S. Boyault, A. Langerød, A. Tutt, J. W. Martens, S. A. Aparicio, A. Borg, A. V. Salomon, G. Thomas, A.-L. Børresen-Dale, A. L. Richardson, M. S. Neuberger, P. A. Futreal, P. J. Campbell, and M. R. Stratton. Mutational Processes Molding the Genomes of 21 Breast Cancers. *Cell*, 149(5):979-993, May 2012. [ [DOI](http://dx.doi.org/10.1016/j.cell.2012.04.024) | [http](http://www.sciencedirect.com/science/article/pii/S0092867412005284) ] |
| [12] | V. Obenchain, M. Morgan, and M. Lawrence. VariantAnnotation: Annotation of Genetic Variants, 2011. [ [.html](http://bioconductor.org/packages/release/bioc/html/VariantAnnotation.html) ] |
| [13] | W. Stacklies, H. Redestig, M. Scholz, D. Walther, and J. Selbig. pcaMethodsa bioconductor package providing PCA methods for incomplete data. *Bioinformatics*, 23(9):1164-1167, May 2007. [ [DOI](http://dx.doi.org/10.1093/bioinformatics/btm069) | [http](http://bioinformatics.oxfordjournals.org/content/23/9/1164) ] |
| [14] | Y. Sun, N. R. Zhang, and A. B. Owen. Multiple hypothesis testing adjusted for latent variables, with an application to the AGEMAP gene expression data. *The Annals of Applied Statistics*, 6(4):1664-1688, Dec. 2012. Zentralblatt MATH identifier: 06141543; Mathematical Reviews number (MathSciNet): MR3058679. [ [DOI](http://dx.doi.org/10.1214/12-AOAS561) | [http](http://projecteuclid.org/euclid.aoas/1356629055) ] |
| [15] | H. Wickham. *ggplot2: Elegant Graphics for Data Analysis*. Springer, New York, 1st ed. 2009. corr. 3rd printing 2010 edition edition, Feb. 2010. [ [http](http://ggplot2.org) ] |

## 8 Session Information

```
   R version 4.5.1 Patched (2025-08-23 r88802)
   Platform: x86_64-pc-linux-gnu
   Running under: Ubuntu 24.04.3 LTS

   Matrix products: default
   BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
   LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

   locale:
    [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
    [3] LC_TIME=en_GB              LC_COLLATE=C
    [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
    [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
    [9] LC_ADDRESS=C               LC_TELEPHONE=C
   [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

   time zone: America/New_York
   tzcode source: system (glibc)

   attached base packages:
   [1] stats4    stats     graphics  grDevices utils     datasets
   [7] methods   base

   other attached packages:
    [1] sva_3.58.0
    [2] BiocParallel_1.44.0
    [3] genefilter_1.92.0
    [4] mgcv_1.9-3
    [5] nlme_3.1-168
    [6] ggdendro_0.2.0
    [7] ggplot2_4.0.0
    [8] GenomeInfoDb_1.46.0
    [9] BSgenome.Hsapiens.1000genomes.hs37d5_0.99.1
   [10] BSgenome_1.78.0
   [11] rtracklayer_1.70.0
   [12] BiocIO_1.20.0
   [13] SomaticCancerAlterations_1.45.0
   [14] SomaticSignatures_2.46.0
   [15] NMF_0.28
   [16] bigmemory_4.6.4
   [17] cluster_2.1.8.1
   [18] rngtools_1.5.2
   [19] registry_0.5-1
   [20] VariantAnnotation_1.56.0
   [21] Rsamtools_2.26.0
   [22] Biostrings_2.78.0
   [23] XVector_0.50.0
   [24] SummarizedExperiment_1.40.0
   [25] Biobase_2.70.0
   [26] GenomicRanges_1.62.0
   [27] IRanges_2.44.0
   [28] S4Vectors_0.48.0
   [29] Seqinfo_1.0.0
   [30] MatrixGenerics_1.22.0
   [31] matrixStats_1.5.0
   [32] BiocGenerics_0.56.0
   [33] generics_0.1.4
   [34] knitr_1.50

   loaded via a namespace (and not attached):
     [1] RColorBrewer_1.1-3       rstudioapi_0.17.1
     [3] jsonlite_2.0.0           magrittr_2.0.4
     [5] GenomicFeatures_1.62.0   farver_2.1.2
     [7] rmarkdown_2.30           vctrs_0.6.5
     [9] memoise_2.0.1            RCurl_1.98-1.17
    [11] base64enc_0.1-3          htmltools_0.5.8.1
    [13] S4Arrays_1.10.0          curl_7.0.0
    [15] SparseArray_1.10.0       Formula_1.2-5
    [17] htmlwidgets_1.6.4        plyr_1.8.9
    [19] cachem_1.1.0             uuid_1.2-1
    [21] GenomicAlignments_1.46.0 mime_0.13
    [23] lifecycle_1.0.4          iterators_1.0.14
    [25] pkgconfig_2.0.3          Matrix_1.7-4
    [27] R6_2.6.1                 fastmap_1.2.0
    [29] digest_0.6.37            pcaMethods_2.2.0
    [31] colorspace_2.1-2         AnnotationDbi_1.72.0
    [33] OrganismDbi_1.52.0       Hmisc_5.2-4
    [35] RSQLite_2.4.3            labeling_0.4.3
    [37] httr_1.4.7               abind_1.4-8
    [39] compiler_4.5.1           proxy_0.4-27
    [41] bit64_4.6.0-1            withr_3.0.2
    [43] doParallel_1.0.17        htmlTable_2.4.3
    [45] S7_0.2.0                 backports_1.5.0
    [47] DBI_1.2.3                highr_0.11
    [49] MASS_7.3-65              DelayedArray_0.36.0
    [51] rjson_0.2.23             tools_4.5.1
    [53] foreign_0.8-90           nnet_7.3-20
    [55] glue_1.8.0               restfulr_0.0.16
    [57] grid_4.5.1               checkmate_2.3.3
    [59] gridBase_0.4-7           reshape2_1.4.4
    [61] gtable_0.3.6             ensembldb_2.34.0
    [63] data.table_1.17.8        foreach_1.5.2
    [65] pillar_1.11.1            stringr_1.5.2
    [67] limma_3.66.0             splines_4.5.1
    [69] dplyr_1.1.4              lattice_0.22-7
    [71] survival_3.8-3           bit_4.6.0
    [73] annotate_1.88.0          biovizBase_1.58.0
    [75] tidyselect_1.2.1         RBGL_1.86.0
    [77] locfit_1.5-9.12          bigmemory.sri_0.1.8
    [79] gridExtra_2.3            ggbio_1.58.0
    [81] ProtGenerics_1.42.0      edgeR_4.8.0
    [83] xfun_0.53                statmod_1.5.1
    [85] stringi_1.8.7            UCSC.utils_1.6.0
    [87] lazyeval_0.2.2           yaml_2.3.10
    [89] evaluate_1.0.5           codetools_0.2-20
    [91] cigarillo_1.0.0          tibble_3.3.0
    [93] BiocManager_1.30.26      graph_1.88.0
    [95] cli_3.6.5                rpart_4.1.24
    [97] xtable_1.8-4             dichromat_2.0-0.1
    [99] Rcpp_1.1.0               png_0.1-8
   [101] XML_3.99-0.19            parallel_4.5.1
   [103] blob_1.2.4               AnnotationFilter_1.34.0
   [105] bitops_1.0-9             scales_1.4.0
   [107] crayon_1.5.3             rlang_1.1.6
   [109] KEGGREST_1.50.0
```