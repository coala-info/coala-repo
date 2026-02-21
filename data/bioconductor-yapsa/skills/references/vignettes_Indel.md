# 5. Indel signature analysis

Lea Jopp-Saile and Daniel Huebschmann

#### 28/01/2019

# Contents

* [1 Introduction: PCAWG signatures](#introduction)
* [2 Classification of Indels](#classification-of-indels)
* [3 PCAWG Indel signatures](#pcawg-indel-signatures)
* [4 Example data: Genome of the Netherlands](#example-data-genome-of-the-netherlands)
* [5 Supervised Indel signature analysis](#supervised-indel-signature-analysis)
  + [5.1 Loading example data](#loading-example-data)
  + [5.2 Data Preprocessing](#data-preprocessing)
  + [5.3 LCD Analysis](#lcd-analysis)
  + [5.4 Visualization](#visualization)
* [6 Confidence Intervals](#confidence-intervals)
* [References](#references)

# 1 Introduction: PCAWG signatures

In May 2018 a new and extended set of mutational signatures was published as a
preprint by the Pan-Cancer Analysis of Whole Genomes (PCAWG) consortium
(Alexandrov et al. [2020](#ref-Alex2020)). In the following, we refer to that set of signatures as the PCAWG
signatures. The underlying data is the largest available cohort of sequenced
(Whole Genome Sequencing (WGS) and Whole Exome Sequencing (WES)) cancer
samples to date and represents a substantial increase in statistical power as
compared to (Alexandrov, Nik-Zainal, Wedge, Aparicio, et al. [2013](#ref-Alex2013)) and (Alexandrov, Nik-Zainal, Wedge, Campbell, et al. [2013](#ref-Alex_CellRep2013)). On this data set, de novo
mutational signature discovery analysis was performed with two different
algorithms of the Non-negative Matrix Factorization (NMF) family of algorithms,
*SigPorfiler* and *SignatureAnalyzer* (Bayesian NMF). In total 65 SNV mutational
signatures (abbreciated SBS for single base substitution) were found, 49 of
which were called validated, either because of good consensus between the two
calling algorithms or because of presence in an orthogonal sequencing
technology. In addition to the SNV or SBS mutational signatures, that analysis
for the first time had sufficient statistical power to also extract 17 Indel
(ID) signatures, based on a classification of Indels into 83 features, and
Doublet Base Signatures (DBS) based on somatic di-nucleotide exchanges. In this
vignette, we present an example analysis with the new PCAWG Indel signatures.
The setup and line of arguments is analogous to the
[first vignette](YAPSA.html).
However, YAPSA doesn’t provide functions for DBS signatures as mutation counts
are often not sufficient for a deconvolution analysis.

As for the [COSMIC SNV mutational signatures](YAPSA.html),
the patterns for both the SNV and Indel PCAWG mutational signatures are stored
in the software package and can be loaded into the workspace as follows:

```
data(sigs_pcawg)
```

For a precise description of all the data loaded by the above command, please
refer to [2. Signature-specific cutoffs](vignette_signature_specific_cutoffs.html)

# 2 Classification of Indels

A prerequisite for an analysis of Indel mutational signatures is a consistent
classification system of Indels. This is non-trivial and critically depends on
the choice of features, which have to include whether a given Indel is actually
an insertion or a deletion, the size of the Indel,as well as the motif context
in order to assess whether micro-homologies are present. In the classification
proposed by the PCAWG consortium there are 83 features in total, which form
five major groups:

1. Deletions of 1 bp C/(G) or T/(A) in a repetitive context. Taking into
   account the motif context of the deletion, the mutational event is further
   classified into categories of 1, 2, 3, 4, 5 or larger or equal to 6 identical
   nucleotide(s).
2. Insertions of 1 bp C/(G) or T/(A) in a repetitive context. Taking into
   account the motif context of the deletion, the mutational event is further
   classified into categories of 0, 1, 2, 3, 4, or larger or equal to 5
   identical nucleotide(s).
3. Deletions of 2 bp, 3 bp, 4 bp or more or equal to 5 bp in a repetitive
   context. Each deletion is classified in a context of 1, 2, 3, 4, 5 or larger
   or equal to 6 times the same motif.
4. Insertions of 2 bp, 3 bp, 4 bp or more or equal to 5 bps in a repetitive
   context. Each deletion is classified in a context of 0, 1, 2, 3, 4 or larger
   or equal to 5 times the same motif.
5. Deletions of 2 bp, 3 bp, 4 bp or more or equal to 5 bp in a partially
   repetitive context with microhomology at the breakpoints. This partially
   repetitive context is defined by motif length of minus 1 bp, 2 bp, 3 bp, 4 bps
   or more or equal to 5 bp, located before and after the break-points of the
   deletion.

Indel classifications in the range of 1 - 5 bp are assigned to individual
categories, while all variants larger than 5bp are considered as one category.
Of note, microhomology is defined by partial sequence similarity between the
motif of the respective Indel and the immediate neighbouring sequence context.
In the following, we illustrate the microhomology classification with an
example. We take a deletion of the motif **ATGCGA**, being more than 5 bp in
length with microhomology, i.e., partially repetitive context of 4 bp at the
breakpoint junction with the motifs **ATGC** upstream and **GCGA** downstream
of the deletion. The annotated feature category is then **MH\_5+\_4bp**.

In YAPSA, the function `plotExchangeSpectra_indel()` can be used to plot the
nucleotide exchange spectra of samples and/or signatures. The representation is
analogous to the function `plotExchangeSpectra()` for SNV mutational signatures,
while the colors and feature annotation is taken from (Alexandrov et al. [2020](#ref-Alex2020)).

```
plotExchangeSpectra_indel(PCAWG_SP_ID_sigs_df[,c(3,6)])
```

![: Nucleotide exchange spectra of the Indel signatures ID3, associated          with tobacco smoking, and ID6, related to deficiencies in homologous          recombination repair.](data:image/png;base64...)

Figure 1: : Nucleotide exchange spectra of the Indel signatures ID3, associated
with tobacco smoking, and ID6, related to deficiencies in homologous
recombination repair.

# 3 PCAWG Indel signatures

The publication (Alexandrov et al. [2020](#ref-Alex2020)) reports signatures decomposed with an NMF
approach (*SigProfiler*) and a Bayesian NMF approach (*SignatureAnalyser*). It
is worth noting that YAPSA only has mutational signatures decomposed with
SigProfiler integrated so far, of which the validated signatures are also found
with *SignatureAnalyser*. Signatures only decomposed with SignatureAnalyzer are
not part of YAPSA. Signature ID15 was excluded as none of the samples had a
contribution to this signature. For seven of the Indel signatures, underlying
mutational processes were asserted. Indel Signatures ID1 and ID2 can be found
across all entities, while others such as ID13 is associated with UV light
exposure and is found exclusively in melanoma (cf. Alexandrov et al. ([2020](#ref-Alex2020))).

```
current_caption <- paste0("Information on Indel mutational signatures.")
if(!exists("repress_tables"))
  kable(PCAWG_SP_ID_sigInd_df, row.names=FALSE, caption=current_caption)
```

Table 1: Information on Indel mutational signatures.

| sig | index | colour | process |
| --- | --- | --- | --- |
| ID1 | 1 | chartreuse4 | Replication slippage, sometimes defective DNA mismatch repair |
| ID2 | 2 | orange | Replication slippage, sometimes defective DNA mismatch repair |
| ID3 | 3 | lightblue | Tobacco smoking |
| ID4 | 4 | orchid2 | unknown |
| ID5 | 5 | darkmagenta | unknown |
| ID6 | 6 | goldenrod4 | DBS repair by non-homologous end joining; defective HR repair |
| ID7 | 7 | lawngreen | Defective DNA mismatch repair |
| ID8 | 8 | darkcyan | DBS repair by non-homologous end joining |
| ID9 | 9 | olivedrab3 | unknown |
| ID10 | 10 | darkseagreen3 | unknown |
| ID11 | 11 | darkslategray4 | unknown |
| ID12 | 12 | red3 | unknown |
| ID13 | 13 | yellow2 | Ultraviolet light exposure |
| ID14 | 14 | dodgerblue1 | unknown |
| ID16 | 15 | pink | unknown |
| ID17 | 16 | mediumblue | unknown |

# 4 Example data: Genome of the Netherlands

In order to demonstrate the functionalities of the Indel signature analysis
with YAPSA, a publicly available data set was chosen, the Genome of the
Netherlands
(<https://www.nlgenome.nl/menu/main/app-go-nl/?page_id=9>) [release5](https://molgenis26.gcc.rug.nl/downloads/gonl_public/variants/release5/).
The data set is not related to cancer and instead contains germline variation
in the genomes of the Dutch population. Hence no biological interpretation or
conclusion of this analysis with respect to mutational processes should be
made, it is of sole technical and demonstrative purpose.

# 5 Supervised Indel signature analysis

## 5.1 Loading example data

We first load the example data, which is stored in the software package
YAPSA. The file \(\texttt{GenomeOfNl\_raw.rda}\) has been filtered to only contain
Indel variant calls.

```
data(GenomeOfNl_raw)
GenomeOfNl_raw <- GenomeOfNl_raw[, c(1,2,4,5)]
```

Optional columns are being removed from the loaded data, which results in a
vcf-like (analogous to the variant calling format) dataframe with
591 variants.
The binary file above was created with the following R code:

```
load_data_new <- FALSE
if(load_data_new){
  data <- data.frame(matrix(ncol = 8, nrow = 0))
  for(index in seq_along(1:22)){
              print(index)
              temp <- tempfile()
              file_path <- paste0("https://molgenis26.gcc.rug.nl/
                                  downloads/gonl_public/variants/release5/
                                  gonl.chr",
                                  index, ".snps_indels.r5.vcf.gz")
              download.file(file_path, temp)

              data <- rbind(data, read.table(gzfile(temp, paste0("gonl.chr",
                                                    index,
                                                    ".snps_indels.r5.vcf")),
                                             header=FALSE, sep="\t",
                                             stringsAsFactors = FALSE))
              data <- data[grep("INDEL", data$V8),]
              unlink(temp)

  }
  colnames(data) <- c("CHROM", "POS", "ID", "REF", "ALT", "QUAL",
                      "FILTER","INFO")

  GenomeOfNl_raw <- data[, c(1,2,4,5)]
}
```

The obtained dataframe will later be used it in order to build a mutational
catalog for supervised analysis of mutational signatures with PCAWG Indel
signatures.

Table 2: Head of VCF file
containing the GoNL INDEL data

|  | CHROM | POS | REF | ALT |
| --- | --- | --- | --- | --- |
| 32 | 2 | 12320 | AAT | A |
| 53 | 2 | 13613 | AG | A |
| 92 | 2 | 17012 | TAAAG | T |
| 94 | 2 | 17128 | T | TG |
| 95 | 2 | 17142 | G | GA |
| 96 | 2 | 17151 | TCAC | T |

## 5.2 Data Preprocessing

`GenomeOfNl_raw` does not contain any patient identifier information.
For the purpose of demonstrating the use of YAPSA Indel signature analysis,
such an information on patient identity is necessary. To do so, 15 synthetic
patient identifiers (PIDs) were generated and 50 +/- 20 Indels per PID were
randomly sampled from the data frame `GenomeOfNl_raw`.

```
seed = 2
set.seed(seed)
number_of_indels <- sample(c(30:70), 15,  replace = TRUE)

index=0
seed=3
set.seed(seed)
vcf_like_indel_lists <- lapply(number_of_indels, function(size){
  df_per_PID <- GenomeOfNl_raw[sample(nrow(GenomeOfNl_raw), size,
                                      replace = FALSE), ]
  index <<- index+1
  df_per_PID$PID <- rep(paste0("PID_", index), length(size))
  df_PIDs <- df_per_PID[order(df_per_PID$CHROM),]
  return(df_PIDs)
  })

vcf_like_indel_df <- do.call(rbind.data.frame, vcf_like_indel_lists)
kable(head(vcf_like_indel_df), caption="Head of the vcf_like_df
      containing the subsampled GoNL Indel data")
```

Table 3: Head of the vcf\_like\_df
containing the subsampled GoNL Indel data

|  | CHROM | POS | REF | ALT | PID |
| --- | --- | --- | --- | --- | --- |
| 743 | 2 | 102906 | G | GTA | PID\_1 |
| 234 | 2 | 31995 | ATG | A | PID\_1 |
| 258 | 2 | 35063 | C | CTTTTTG | PID\_1 |
| 634 | 2 | 89249 | CACAA | C | PID\_1 |
| 1574 | 3 | 119388 | CTT | C | PID\_1 |
| 1437 | 3 | 106298 | AT | A | PID\_1 |

Using the artificial `vcf_like_df` created above as input, the function
`create_indel_mutation_catalogue_from_df()` then builds a mutational
catalog \(V^{INDEL}\) containing the absolute feature counts (\(n\)) for each
patient. This functions is equivalent to the function
`create_mutation_catalogue_from_df()` for SNV data. Besides the input of type
`vcf_like_df`, the function `create_indel_mutation_catalogue_from_df()` also
requires the Indel signatures (`PCAWG_SP_ID_sigs_df`) loaded previously into
the workspace.
The function `create_create_indel_mutation_catalogue_from_df()` is a wrapper of
several other functions:

1. `attribute_sequence_contex_indel()` the function annotates to the
   `vcf_like_df` a sequence context of 10 bp down- and 60 bp upstream of every
   Indel variant. Additionally, the information whether the variant is an
   insertion or deletion and the length of the Indel is annotated to every Indel
   mutation.
2. `attribution_of_indels()` attributes each variant to one of the 83 classes of
   features
3. `create_indel_mut_cat_from_df()` carries out the counting in order to obtain
   a mutational catalog with the dimensions \(n \times m\).

Please note that this pre-processing step takes longer than all other functions
in YAPSA and may be time limiting.

```
vcf_like_indel_trans_df <- translate_to_hg19(vcf_like_indel_df,"CHROM")
mutational_cataloge_indel_df <- create_indel_mutation_catalogue_from_df(
  in_dat = vcf_like_indel_trans_df,
  in_signature_df = PCAWG_SP_ID_sigs_df)
```

```
## [1] "Indel sequence context attribution of total  670  indels. This could take a while..."
## [1] "INDEL classification of total  670  INDELs This could take a while..."
```

```
kable(head(mutational_cataloge_indel_df[,1:5]))
```

|  | PID\_1 | PID\_2 | PID\_3 | PID\_4 | PID\_5 |
| --- | --- | --- | --- | --- | --- |
| DEL\_C\_1\_0 | 2 | 3 | 3 | 0 | 1 |
| DEL\_C\_1\_1 | 2 | 0 | 2 | 1 | 1 |
| DEL\_C\_1\_2 | 2 | 1 | 1 | 0 | 1 |
| DEL\_C\_1\_3 | 0 | 0 | 1 | 0 | 1 |
| DEL\_C\_1\_4 | 1 | 1 | 1 | 0 | 0 |
| DEL\_C\_1\_5+ | 1 | 1 | 0 | 1 | 0 |

## 5.3 LCD Analysis

The core function of YAPSA is the function `LCD` and its derived functions,
which perform supervised mutational signature analysis. Here we describe how
this class of functions has been extended in order to make this supervised
signature analysis available to Indel mutational signatures. As previously
described for
[SNV mutational signatures](YAPSA.html),
the deconvolution is based on a non-negative least squares (NNLS) algorithm. In
order to reduce false positive calls,
[signature-specific cutoffs](vignette_signature_specific_cutoffs.html)
were introduced in YAPSA. Signature-specific cutoffs
are applied after a first decomposition with NNLS, and only signatures with
computed contributions higher than their signature-specific cutoff are used in
a second decomposition which then yields the exposure values. Signature-specific
cutoffs take the different detectability of signatures into account, reflected
by a lower signature-specific cutoff for signatures with a distinct pattern and
a higher signature-specific cutoff for signatures with broader patterns.

Of note, mutational processes have been asserted to fractions of both the sets
of SNV and Indel mutational signatures. There are overlaps between the asserted
mutational processes, as some of them can indeed leave imprints on both the SNV
and Indel mutational landscapes. Combining the information extracted with an
analysis of mutational signatures from the different types of mutation may thus
increase discriminatory power.

As described
[here](vignette_signature_specific_cutoffs.html), signature-specific cutoffs were trained in a modified
ROC analysis with the package *[ROCR](https://CRAN.R-project.org/package%3DROCR)* (Sing et al. [2005](#ref-ROCR_package2005)) using the
results of the unsupervised discovery analysis as training data. As for the SNV
mutational signatures, signature-specific cutoffs are stored in dataframes
within the software package and can be loaded into the workspace:

```
data(cutoffs_pcawg)
```

As described in
[2. Signature-specific cutoffs](vignette_signature_specific_cutoffs.html), the modified ROC analyses are parametrized by
defining cost terms for punishing false-negative (\(cost\_{FN}\)) and
false-positive (\(cost\_{FP}\)) findings separately, but the shape and minima of
the cost functions depend only on the ratio between the cost for a
false-negative finding divided by the cost for a false positive finding, the
\(cost\_{factor}\) (\(cost\_{factor} = cost\_{FN}/cost\_{FP}\)). Therefore, there is one
set of optimal signature-specific cutoffs per chosen value of \(cost\_{factor}\).

Optimal signature-specific cutoffs are stored in data frames within the software
package and can be loaded into the workspace as shown above. In these data
frames every row corresponds to a different value of \(cost\_{factor}\). For Indel
signatures the optimal cost factor was identified to be 3, thus the third line
in `cutoffPCAWG_ID_WGS_Pid_df` can be chosen for analysis.

```
current_catalogue_df <- mutational_cataloge_indel_df
current_sig_df <- PCAWG_SP_ID_sigs_df
current_cutoff_pid_vector <- cutoffPCAWG_ID_WGS_Pid_df[3,]
current_sigInd_df <- PCAWG_SP_ID_sigInd_df

current_LCDlistsList <- LCD_complex_cutoff_combined(
  current_catalogue_df,
  current_sig_df,
  in_cutoff_vector = current_cutoff_pid_vector,
  in_filename = NULL,
  in_method = "abs",
  in_sig_ind_df = current_sigInd_df)

current_consensus_LCDlist <- current_LCDlistsList$consensus
if(!exists("repress_tables"))
  as.character(current_consensus_LCDlist$out_sig_ind_df$sig)
```

```
##  [1] "ID1"  "ID2"  "ID3"  "ID4"  "ID5"  "ID6"  "ID8"  "ID9"  "ID12" "ID14"
## [11] "ID17"
```

## 5.4 Visualization

The exposures, i.e., the contributions of the different signatures to the
mutational catalog of every sample, can be visualized with the function
`exposures_barplot()`. All the functionalities which are available for
SNV mutational signatures, such as the annotation of subgroups (cf.
[1. Usage of YAPSA](vignette_confidenceIntervals.html))
are also available for the Indel mutational signatures.

```
exposures_barplot(current_LCDlistsList$perPID$exposures,
                  current_LCDlistsList$perPID$out_sig_ind_df)
```

![:Exposures to Indel mutational signatures in the artificial data created          by sampling GoNL variants. Exposures were obtained from         a decomposition with PCAWG Indel signatures as well as their signature         specific-cutoffs (cutoffPCAWG_ID_WGS_Pid_df).](data:image/png;base64...)

Figure 2: :Exposures to Indel mutational signatures in the artificial data created
by sampling GoNL variants. Exposures were obtained from
a decomposition with PCAWG Indel signatures as well as their signature
specific-cutoffs (cutoffPCAWG\_ID\_WGS\_Pid\_df).

# 6 Confidence Intervals

In order to assess trustworthiness of the computed exposures, YAPSA provides
the calculation of confidence intervals (CIs). Analogously to
[CIs for SNV mutational signatures](YAPSA.html),
the CIs for Indel mutational signatures are computed using the concept of
profile likelihood.

```
confidence_intervals_ID <- confidence_indel_only_calulation(
  in_current_indel_df = current_catalogue_df)
```

```
## [1] "PCAWGValidID_abs"
```

```
plot(confidence_intervals_ID$p_complete_PCAWG_ID)
```

![Confidence interval calculation for exposures to Indel mutational          signatures](data:image/png;base64...)

Figure 3: Confidence interval calculation for exposures to Indel mutational
signatures

Note: With `confidence_indel_only_calulation()` only for INDELs the confidence
intervals are calculated. To calculate the confidence intervals for SNVs and
INDELs please use the function `confidence_indel_calulation()` and supply the
mutational catalogs of both SNV and INDEL counts.

# References

Alexandrov, LB, J Kim, NJ Haradhvala, MN Huang, AW Ng, A Boot, KR Covington, et al. 2020. “The Repertoire of Mutational Signatures in Human Cancer.” *Nature*. Nature.

Alexandrov, LB, S Nik-Zainal, DC Wedge, SA Aparicio, S Behjati, AV Biankin, GR Bignell, et al. 2013. “Signatures of Mutational Processes in Cancer.” *Nature*. Nature Publishing Group.

Alexandrov, LB, S Nik-Zainal, DC Wedge, PJ Campbell, and MR Stratton. 2013. “Deciphering Signatures of Mutational Processes Operative in Human Cancer.” *Cell Reports*.

Sing, Tobias, Oliver Sander, Niko Beerenwinkel, and Thomas Lengauer. 2005. “ROCR: Visualizing Classifier Performance in R.” *Bioinfomatics*.