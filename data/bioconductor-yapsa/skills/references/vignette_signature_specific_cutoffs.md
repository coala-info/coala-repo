# 2. Signature-specific cutoffs

Lea Jopp-Saile and Daniel Hübschmann

#### 27/11/2019

# Contents

* [1 Introduction](#introduction)
* [2 Overview of the data](#DataOverview)
  + [2.1 Signatures](#signatures)
  + [2.2 Optimal cutoffs](#OptimalCutoffs)
* [3 Application example](#application-example)
  + [3.1 Comparison: analysis without any cutoffs](#comparisonZeroCutoffs)
  + [3.2 Making use of optimal signature-specific cutoffs](#optimalSpecificCutoffs)
* [Reference](#reference)

# 1 Introduction

The vignette
[1. Usage of YAPSA](YAPSA.html)
describes the general usage of YAPSA as a tool
to perform supervised analyses of mutational signatures. Calling of mutational
signature in YAPSA is performed with a Non-Negative Least Square (NNLS)
algorithm implemented in the function **l**inear **c**ombination
**d**ecomposition (`LCD`) function based on the function `lsei` from the package
*[lsei](https://CRAN.R-project.org/package%3Dlsei)* (Wang, Lawson, and Hanson [2015](#ref-lsei_package2015)). The function `LCD` can take
signature-specific cutoffs as optional arguments. When choosing optimal cutoffs,
this can lead to an increase in sensitivity and specificity as compared to NNLS
alone. In such a context, `LCD` then determines the exposure, i.e., the
contribution of signature to the mutational load of a samples, in a three-step
computational process:

1. Find an NNLS solution with all supplied signatures using LCD
2. Identify those signatures which have a contribution higher than a
   signature-specific cutoff
3. Rerun NNLS based on the selected subset of signatures

Mutational signatures as provided by
<https://cancer.sanger.ac.uk/cosmic/signatures> have been extracted by
Non-negative Matrix Factorization (NMF). Due to the constraint of
non-negativity, these signatures cannot be orthogonal. However, orthogonality
is a prerequisite or at least beneficial for least squares algorithms. This
lack of orthogonality leads to potential overlapping of the signature in a
deconvolution.

Different signatures have different detectability. Those with high detectability
will occur as false positive calls more often. In order to account for the
different detectability, we introduced the concept of signature-specific
cutoffs: a signature which leads to many false positive calls has to cross a
higher threshold than a signature which rarely leads to false positive calls.
For YAPSA, we have computed optimal signature cutoffs by a modfied Reciever
Operating Characteristic (ROC) analysis on the same data as
it had been used for the initial NMF analyses with the extraction of the
published mutational signatures ((Alexandrov et al. [2013](#ref-Alex2013)) and (Alexandrov et al. [2020](#ref-Alex2020))).
Numeric values for these cutoffs are stored in dataframes accessible after
loading the package YAPSA.

In the implementation of the package *[ROCR](https://CRAN.R-project.org/package%3DROCR)* (Sing et al. [2005](#ref-ROCR_package2005)), a
modified ROC analysis is parametrized by defining cost terms for punishing
false-negative (\(cost\_{FN}\)) and false-positive (\(cost\_{FP}\)) findings
separately. In the following, we will call the ratio between the cost for a
false-negative finding divided by the cost for a false positive finding the
\(cost\_{factor}\) (\(cost\_{factor} = cost\_{FN}/cost\_{FP}\)). Separate ROC analyses
were performed for every signature. For every signature, the global minimum
of the cost function defines the optimal value for the signature-specific
cutoff. However, the shape of the cost function and hence the position of its
minimum depend on \(cost\_{factor}\). Therefore there is one set of optimal
signature-specific cutoffs per chosen value of \(cost\_{factor}\)
([cf. below](#OptimalCutoffs)).

After having computed the optimal signature-specific cutoffs for a range of
values for \(cost\_{factor}\), we applied an additional criterion in order to get
an optimal value for \(cost\_{factor}\): minimization of the overall number of
false attributions. Using this criterion, for the Alexandrov COSMIC signatures
(`AC1 - AC30`), the optimal value for \(cost\_{factor}\) was determined to be \(6\).

# 2 Overview of the data

## 2.1 Signatures

In YAPSA, the patterns of nucleotide exchanges in their triplet context
constituting the mutational signatures are stored in data frames which can be
loaded as follows (more information provided by the help function, cf.
([1. Usage of YAPSA](YAPSA.html))
for an overview of how these data frames can be re-created from data available
online):

```
data(sigs)
data(sigs_pcawg)
```

The first command, `data(sigs)`, loads eight dataframes into the workspace.
Among these, four contain the patterns of nucleotide exchanges in their triplet
context, i.e., the mutational signatures themselves, and the remaining
four dataframes contain additional information on the signatures, including a
naming and numbering convention, a description of the asserted underlying
mutational process and a choice of generic colour coding. In particular, these
eight signature dataframes are:

* Two signature and two additonal information dataframes containing SNV
  Alexandrov COSMIC signatures (available at
  <https://cancer.sanger.ac.uk/cosmic/signatures_v2>, downloaded on January
  15th, 2016):
  + `AlexCosmicArtif_sig_df` and `AlexCosmicArtif_sigInd_df`,
  + `AlexCosmicValid_sig_df` and `AlexCosmicValid_sigInd_df`
* Two signature and two additonal information dataframes containing SNV
  Alexadrov Initial signatures (the signatures presented in the initial
  publication (Alexandrov et al. [2013](#ref-Alex2013))):
  + `AlexInitialArtif_sig_df` and `AlexInitialArtif_sigInd_df`,
  + `AlexInitialValid_sig_df` and `AlexInitialValid_sigInd_df`

Of note, all data provided in YAPSA follows a consistent naming convention:

* Names containing `Valid` or `Real` refer to those subsets of signatures which
  have been identified by NMF in the respective discovery analyses and validated
  using orthogonal sequencing technologies.
* Names containing `Artif` refer to extended sets of signatures including also
  those signatures which have later been ascribed to be artifact signatures
  (reflecting, among others, sequencing errors).

The second command in the above code block, `data(sigs_pcawg)`, loads six
additional dataframes into the workspace, three dataframes containing
mutational signatures themselves and three dataframes containing additional
information on the signatures. In particular, these six dataframes are:

* Two signature and two additional information dataframes containing SNV
  Alexandrov PCAWG signatures (available at
  <https://cancer.sanger.ac.uk/cosmic/signatures_v3>, downloaded on August 16th,
  2018):
  + `PCAWG_SP_SBS_sigs_Artif_df` and `PCAWG_SP_SBS_sigInd_Artif_df`,
  + `PCAWG_SP_SBS_sigs_Real_df` and `PCAWG_SP_SBS_sigInd_Real_df`
* One signature and one additional information dataframe containing Indel
  Alexandrov PCAWG signatures (also available at
  <https://cancer.sanger.ac.uk/cosmic/signatures_v3>, downloaded
  on August 16th, 2018):
  + `PCAWG_SP_ID_sigs_df` and `PCAWG_SP_ID_sigInd_df`

As of december 2019 and to our knowledge, it is a unique feature of YAPSA to
include PCAWG mutational signatures. Of note, a
[separate vignette](vignettes_Indel.html) describes the usage of and analysis with Indel signatures.

## 2.2 Optimal cutoffs

For each of the signature dataframes, corresponding dataframes storing
numerical values of the signature-specific cutoffs are available. The cutoff
dataframes can be loaded to the workspace analogously to the signatures
themselves:

```
data(cutoffs)
data(cutoffs_pcawg)
```

The command `data(cutoffs)` loads cutoff dataframes corresponding to the four
Alexandrov COSMIC and Alexandrov initial sets of signatures. In the following,
an additional naming convention is introduced:

* Absolute (abs) signature-specific cutoffs were computed using an ROC analysis
  performed on absolute exposures as provided by the initial NMF analysis
* Relative (rel) signature-specific cutoffs were computed using on ROC analysis
  performed on relative, i.e., normalized exposures as provided by the initial
  NMF analysis.

This double training has proven to be both useful and necessary in order to
account for the heterogeneity of the underlying training data: on one hand, a
training with absolute exposures weighs all mutations equally, however a whole
genome sequenced (WGS) sample gets a much higher weight due to the high number
of mutations detected in it than a whole exome sequenced (WES sample). On the
other hand, a training with relative or normalized signature exposures weighs
all samples equally, but at the cost of having different weights for mutations
originating from samples of different mutation count. Based on these
considerations, cutoffs derived from the training with absolute exposures
should be used for the supervised analysis of WGS data, whereas cutoffs trained
on relative exposures are better suited for the analysis of WES data. The two
different sets of cutoffs thus account for the different maximal feature
occurrence between WGS and WES data. The correspondence between signatures and
cutoffs is as follows:

* For `AlexCosmicValid_sig_df`, the corresponding cutoff dataframes are
  `cutoffCOSMICValid_abs_df` and `cutoffCOSMICValid_rel_df`.
* For `AlexCosmicArtif_sig_df`, the corresponding cutoff dataframes are
  `cutoffCOSMICArtif_abs_df` and `cutoffCOSMICArtif_rel_df`.

With `data(cutoffs_pcawg)` the signature-specific cutoff dataframes for the
PCAWG signatures are loaded. In this case, only one dataframe with cutoffs per
signature dataframe is available. Signature-specific cutoffs are valid for WGS
and WES data analysis as differences in the feature occurrence is taken into
account during the training procedure.

In the provided dataframes with numerical values for optimal signature-specific
cutoffs, the columns correspond to the different signatures of the chosen
signature set, whereas the rows encode different values of \(cost\_{factor}\)
(cf. [introduction](#introduction)). For an actual analysis of mutational signatures, only one
optimal cutoff value per signature is required, i.e., the user has to choose
one row from the chosen cutoff dataframe. As already explained above, optimal
values for \(cost\_{factor}\) have also been determined. These are listed in the
table below. Unless a user has a specific wish to use a different
\(cost\_{factor}\), it is generally recommended to use these default parameter
choices.

(#tab:Table:) Overview of signature specific cutoffs and the cost factor to
obtain the optimal cutoffs.

| cutoff dataframe | optimal cost factor |
| --- | --- |
| cutoffInitialValid\_abs\_df | 6 |
| cutoffInitialValid\_rel\_df | 6 |
| cutoffInitialArtif\_abs\_df | 6 |
| cutoffInitialArtif\_rel\_df | 6 |
| cutoffCosmicValid\_abs\_df | 6 |
| cutoffCosmicValid\_rel\_df | 6 |
| cutoffCosmicArtif\_abs\_df | 6 |
| cutoffCosmicArtif\_rel\_df | 6 |
| cutoffPCAWG\_SBS\_WGSWES\_realPid\_df | 10 |
| cutoffPCAWG\_SBS\_WGSWES\_artiflPid\_df | 16 |
| cutoffPCAWG\_ID\_WGS\_Pid\_df | 3 |

Thus, if a user wants to do an analysis with the Alexandrov COSMIC signatures,
discarding the artifact signatures, on WGS data, he/she would use the following
code snippet:

```
data(cutoffs)
current_cutoff_vector <- cutoffCosmicValid_abs_df[6, ]
current_cutoff_vector
```

```
##   AC1        AC2        AC3        AC4 AC5         AC6        AC7      AC8
## 6   0 0.01045942 0.08194056 0.01753969   0 0.001548535 0.04013304 0.242755
##         AC9       AC10       AC11      AC12        AC13      AC14       AC15
## 6 0.1151714 0.01008376 0.09924884 0.2106201 0.007876626 0.1443059 0.03796027
##        AC16        AC17      AC18      AC19      AC20      AC21       AC22
## 6 0.3674349 0.002647962 0.3325386 0.1156454 0.1235028 0.1640255 0.03102216
##         AC23       AC24       AC25       AC26        AC27       AC28       AC29
## 6 0.03338659 0.03240176 0.01611908 0.09335221 0.009320062 0.05616434 0.05936213
##         AC30
## 6 0.05915355
```

# 3 Application example

The vignette
[1. Usage of YAPSA](YAPSA.html)
shows how to obtain a mutational catalog (\(V\)) from a
vcf file. Here, for the sake of simplicits, we just use an example data set
stored in the software package.

```
data(lymphomaNature2013_mutCat_df)
```

The mutational catalog \(V\) together with the signatures \(V\) and the
corresponding signature-specific cutoffs can be used to determine the signature
exposures (corresponding to the matrix \(H\) in the naming convention influenced
by NMF) per sample or cohort. This is done by the function
`LCD_complex_cutoff_combined`.

In the examples provided in
[1. Usage of YAPSA](YAPSA.html),
signature exposures were determined (i) with a zero cutoff vector, i.e. without
signature-specific cutoffs or (ii) with a manually chosen but not necessarily
optimal cutoff. In contrast, in the following, we will perform an analysis of
mutational signatures using optimal cutoffs and compare the results to an
analysis without any cutoffs.

```
current_sig_df <- AlexCosmicValid_sig_df
current_sigInd_df <- AlexCosmicValid_sigInd_df
```

## 3.1 Comparison: analysis without any cutoffs

For the purpose of comparison, we first create a zero cutoff vector:

```
current_cutoff_vector <- rep(0, dim(AlexCosmicValid_sig_df)[2])
```

Next, we compute the exposures to the mutational signatures using LCD analysis
and this zero cutoff vector:

```
lymphoma_COSMIC_zero_listsList <-
  LCD_complex_cutoff_combined(
    in_mutation_catalogue_df = lymphomaNature2013_mutCat_df,
    in_cutoff_vector = current_cutoff_vector,
    in_signatures_df = current_sig_df,
    in_sig_ind_df = current_sigInd_df)
```

The function returns an object with the results per cohort, per PID and the
consensus between both analyses.

Annotation of a subgroup to each PID allows to group the samples per subgroup
upon visualization:

```
data(lymphoma_PID)
colnames(lymphoma_PID_df) <- "SUBGROUP"
lymphoma_PID_df$PID <- rownames(lymphoma_PID_df)
COSMIC_subgroups_df <-
  make_subgroups_df(lymphoma_PID_df,
                    lymphoma_COSMIC_zero_listsList$cohort$exposures)
```

We select the cohort-wide analysis for visualization and make use of the custom
plotting function `exposures_barplot()` in order to display signature exposures
as stacked barplots. Note the occurrence of multiple signatures with partially
very low exposures.

```
result_cohort <- lymphoma_COSMIC_zero_listsList$cohort
exposures_barplot(
  in_exposures_df = result_cohort$exposures,
  in_signatures_ind_df = result_cohort$out_sig_ind_df,
  in_subgroups_df = COSMIC_subgroups_df)
```

![Absoute exposures of the COSMIC signatures in the lymphoma mutational         catalogs, signature-specific cutoffs with a cost factor of 6 used         for the LCD](data:image/png;base64...)

Figure 1: Absoute exposures of the COSMIC signatures in the lymphoma mutational
catalogs, signature-specific cutoffs with a cost factor of 6 used
for the LCD

## 3.2 Making use of optimal signature-specific cutoffs

The zero-cutoff vector will now be replaced by the signature-specific cutoff
vector. After the initial LCD analysis only signatures that contribute higher
then their signature specific cutoff value will be considered, leading to a
reduction of the overall number of detected signatures.

Based on [**??**](#tab:Table1) we know that for the validated COSMIC Signatures the
optimal cutoffs are the once computed with a cost factor of six.

```
current_cutoff_df <- cutoffCosmicValid_abs_df
current_cost_factor <- 6
current_cutoff_vector <- current_cutoff_df[current_cost_factor,]
```

We again compute signature exposures, but this time using the vector of optimal
signature-specific cutoffs:

```
lymphoma_COSMIC_listsList <-
  LCD_complex_cutoff_combined(
      in_mutation_catalogue_df = lymphomaNature2013_mutCat_df,
      in_cutoff_vector = current_cutoff_vector,
      in_signatures_df = current_sig_df,
      in_sig_ind_df = current_sigInd_df)
```

And again proceeding to a visualization (of note, the sample subgrouping
information can be used as in the previous subsection):

```
result_cohort <- lymphoma_COSMIC_listsList$cohort
exposures_barplot(
  in_exposures_df = result_cohort$exposures,
  in_signatures_ind_df = result_cohort$out_sig_ind_df,
  in_subgroups_df = COSMIC_subgroups_df)
```

![Absolute exposures of the COSMIC signatures in the lymphoma mutational         catalogs, signature-specific cutoffs with a cost factor of 6 used         for the LCD](data:image/png;base64...)

Figure 2: Absolute exposures of the COSMIC signatures in the lymphoma mutational
catalogs, signature-specific cutoffs with a cost factor of 6 used
for the LCD

We note that the number of identified signatures is smaller.
Those signatures which had been identified in
[the analysis without any cutoffs](#comparisonZeroCutoffs) but not in
[the analysis with optimal cutoffs](#optimalSpecificCutoffs) can be considered
false positive calls.

# Reference

Alexandrov, LB, J Kim, NJ Haradhvala, MN Huang, AW Ng, A Boot, KR Covington, et al. 2020. “The Repertoire of Mutational Signatures in Human Cancer.” *Nature*.

Alexandrov, LB, S Nik-Zainal, DC Wedge, SA Aparicio, S Behjati, AV Biankin, GR Bignell, et al. 2013. “Signatures of Mutational Processes in Cancer.” *Nature*. Nature Publishing Group.

Sing, Tobias, Oliver Sander, Niko Beerenwinkel, and Thomas Lengauer. 2005. “ROCR: Visualizing Classifier Performance in R.” *Bioinfomatics*.

Wang, Yong, Charles L. Lawson, and Richard J Hanson. 2015. “Lsei: Solving Least Squares Problems Under Equality/Inequality Constraints.” *R-Package Version 1.1-1*.