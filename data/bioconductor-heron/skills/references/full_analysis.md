# Analyzing High Density Peptide Array Data using HERON

* [1 HERON](#heron)
  + [1.1 Installation](#installation)
  + [1.2 Example](#example)
    - [1.2.1 The *HERONSequenceData* object](#the-heronsequencedata-object)
    - [1.2.2 Creating the *HERONSequenceData* object](#creating-the-heronsequencedata-object)
    - [1.2.3 Pre-process data](#pre-process-data)
    - [1.2.4 Calculate probe-level p-values](#calculate-probe-level-p-values)
    - [1.2.5 Obtain probe-level calls](#obtain-probe-level-calls)
    - [1.2.6 Find Epitope Segments using the unique method](#find-epitope-segments-using-the-unique-method)
    - [1.2.7 Calculate Epitope-level p-values](#calculate-epitope-level-p-values)
    - [1.2.8 Obtain Epitope-level calls](#obtain-epitope-level-calls)
    - [1.2.9 Calculate Protein-level p-values](#calculate-protein-level-p-values)
    - [1.2.10 Obtain Protein-level calls](#obtain-protein-level-calls)
  + [1.3 Other](#other)
    - [1.3.1 Find Epitope Segments using the hclust method](#find-epitope-segments-using-the-hclust-method)
    - [1.3.2 Find Epitope Segments using the skater method](#find-epitope-segments-using-the-skater-method)
    - [1.3.3 Other meta p-value methods](#other-meta-p-value-methods)
    - [1.3.4 Making z-score cutoff calls](#making-z-score-cutoff-calls)
    - [1.3.5 Smoothing across probes](#smoothing-across-probes)
    - [1.3.6 Calculate paired t-tests](#calculate-paired-t-tests)
    - [1.3.7 Use the wilcox test for probe-level p-values](#use-the-wilcox-test-for-probe-level-p-values)
    - [1.3.8 Use of the condition column](#use-of-the-condition-column)
  + [1.4 Funding](#funding)
  + [1.5 Acknowledgments](#acknowledgments)
  + [1.6 Session Info](#session-info)

# 1 HERON

The goal of HERON (**H**ierarchical **E**pitope p**RO**tein bi**N**ding) is to analyze peptide binding array data measured from nimblegen or any high density peptide binding array data.

## 1.1 Installation

You can install the released version of HERON from [bioconductor](https://www.bioconductor.org/) with:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# The following initializes usage of Bioc devel
BiocManager::install(version='devel')

BiocManager::install("HERON")
```

And the development version from [GitHub](https://github.com/Ong-Research/HERON) with:

```
# install.packages("devtools")
devtools::install_github("Ong-Research/HERON")
```

```
options(warn=2)
suppressPackageStartupMessages(library(HERON))
```

## 1.2 Example

These are examples which shows you how to interact with the code. We will be using a subset of the COVID-19 peptide binding array dataset from the <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8245122/> publication.

### 1.2.1 The *HERONSequenceData* object

The *HERONSequenceDataSet* object is the first object needed for running HERON. The *HERONSequenceDataSet* is a subclass of *SummarizedExperiment* from base Bioconductor. The components are a sequence *data.frame* or *matrix* where rows are amino acid sequences of the peptide binding probe and the columns are samples, a colData *DFrame*, and a metadata *data.frame* that maps sequences to probes.

#### 1.2.1.1 Sequence matrix

```
data(heffron2021_wuhan)
knitr::kable(assay(heffron2021_wuhan)[1:5,1:5])
```

|  | Sample\_9 | Sample\_1 | Sample\_39 | Sample\_23 | Sample\_56 |
| --- | --- | --- | --- | --- | --- |
| AAAYYVGYLQPRTFLL | 0.3746667 | 0.5423724 | 0.7329991 | 0.1225761 | 0.9727648 |
| AADLDDFSKQLQQSMS | 2.8056786 | 3.1205293 | 9.2330091 | 4.2324981 | 9.8410852 |
| AAEASKKPRQKRTATK | 0.2704410 | 0.7198765 | 2.6648164 | 1.7079940 | 4.5664978 |
| AAEIRASANLAATKMS | 0.7120529 | 1.3820778 | 1.5463912 | 3.2038894 | 7.3400386 |
| AAIVLQLPQGTTLPKG | 2.9876932 | 0.1259101 | 4.6971758 | 5.6496847 | 2.2246734 |

#### 1.2.1.2 colData

The *colData* data frame describes the experimental setup of the samples.
For the *colData* data frame, the important columns are *ptid*, *visit*, and *SampleName*. The *SampleName* is the column name of the sequence table, *ptid* is the name of the sample, and *visit* is either pre or post.
The *ptid* can the same value for one pre and post sample, which would indicate a paired design. A *condition* column can also be provided which can indicate multiple conditions for the post samples.

```
knitr::kable(head(colData(heffron2021_wuhan)))
```

|  | SampleName | ptid | visit | condition |
| --- | --- | --- | --- | --- |
| Sample\_9 | Sample\_9 | Sample\_9 | pre | Control |
| Sample\_1 | Sample\_1 | Sample\_1 | pre | Control |
| Sample\_39 | Sample\_39 | Sample\_39 | post | COVID |
| Sample\_23 | Sample\_23 | Sample\_23 | post | COVID |
| Sample\_56 | Sample\_56 | Sample\_56 | post | COVID |
| Sample\_53 | Sample\_53 | Sample\_53 | post | COVID |

#### 1.2.1.3 Probe metadata

The probe\_meta data frame describes the mapping the amino acid sequence (*PROBE\_SEQUENCE*) of the probes to the probe identifier (*PROBE\_ID*). The PROBE\_ID contains the name of the protein and the position within the protein of the first acid of the probe sequence separated by a semicolon.

```
probe_meta <- metadata(heffron2021_wuhan)$probe_meta
knitr::kable(head(probe_meta[,c("PROBE_SEQUENCE", "PROBE_ID")]))
```

|  | PROBE\_SEQUENCE | PROBE\_ID |
| --- | --- | --- |
| 76322 | MYSFVSEETGTLIVNS | NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;1 |
| 76323 | YSFVSEETGTLIVNSV | NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;2 |
| 76324 | SFVSEETGTLIVNSVL | NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;3 |
| 76325 | FVSEETGTLIVNSVLL | NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;4 |
| 76326 | VSEETGTLIVNSVLLF | NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;5 |
| 76327 | SEETGTLIVNSVLLFL | NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;6 |

### 1.2.2 Creating the *HERONSequenceData* object

The *heffron2021\_wuhan* data object is already a *HERONSequenceDataSet* object. We can create the same object using the *HERONSequenceDataSet* constructor as an example.

```
seq_mat <- assay(heffron2021_wuhan)
sds <- HERONSequenceDataSet(seq_mat)
colData(sds) <- colData(heffron2021_wuhan)
metadata(sds)$probe_meta <- probe_meta
```

### 1.2.3 Pre-process data

The data is pre-processed by first quantile normalizing on sequence-level data.

```
seq_ds_qn <- quantileNormalize(sds)
knitr::kable(head(assay(seq_ds_qn)[,1:5]))
```

|  | Sample\_9 | Sample\_1 | Sample\_39 | Sample\_23 | Sample\_56 |
| --- | --- | --- | --- | --- | --- |
| AAAYYVGYLQPRTFLL | 0.3569421 | 0.8802587 | 0.5174103 | 0.1539593 | 0.8632584 |
| AADLDDFSKQLQQSMS | 2.4975483 | 4.4552679 | 6.6610043 | 4.8175685 | 7.2030291 |
| AAEASKKPRQKRTATK | 0.2706685 | 1.1883782 | 2.0845928 | 1.6878615 | 3.4542907 |
| AAEIRASANLAATKMS | 0.6506443 | 2.1632309 | 1.1600102 | 3.6584394 | 5.0898633 |
| AAIVLQLPQGTTLPKG | 2.8027363 | 0.2307280 | 3.2037424 | 6.1906585 | 1.8298191 |
| AALALLLLDRLNQLES | 0.5432972 | 0.4990815 | 2.2830699 | 0.0681958 | 2.9236376 |

### 1.2.4 Calculate probe-level p-values

The quantile normalized data is then used with the *colData* and *probe\_meta* data frames to calculate probe-level p-values.

The *calcCombPValues* call will first calculate the probe level p-values using the colData, adjust the probe p-values on a column-by-column basis frame.

The combined p-values can be calculated on the sequence data set, then converted to a probe data set through *convertSequenceDSToProbeDS*, or calculated on the probe data set. If the data was smoothed prior using consecutive probes on the same protein, then the p-values should calculated on the smoothed probe data set.

```
seq_pval_res <- calcCombPValues(seq_ds_qn)
probe_pval_res <- convertSequenceDSToProbeDS(seq_pval_res)
knitr::kable(head(assay(probe_pval_res, "padj")[,1:5]))
```

|  | Sample\_39 | Sample\_23 | Sample\_56 | Sample\_53 | Sample\_43 |
| --- | --- | --- | --- | --- | --- |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;1 | 1 | 1.0000000 | 1.0000000 | 0.7009991 | 1 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;2 | 1 | 1.0000000 | 1.0000000 | 1.0000000 | 1 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;3 | 1 | 0.1693163 | 0.7731021 | 1.0000000 | 1 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;4 | 1 | 1.0000000 | 1.0000000 | 1.0000000 | 1 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;5 | 1 | 1.0000000 | 1.0000000 | 1.0000000 | 1 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;6 | 1 | 1.0000000 | 1.0000000 | 1.0000000 | 1 |

### 1.2.5 Obtain probe-level calls

Once the p-values have been calculated, the *makeProbeCalls* will make the calls using the adjusted p-values calculated. *makeProbeCalls* also includes a filter to remove one-hit probes, which are probes that were called only in one sample and do not have a consecutive probe called in a single sample. The return value is *HERONProbeDataSet* with the calls included as an additional assay.

```
probe_calls_res <- makeProbeCalls(probe_pval_res)
knitr::kable(head(assay(probe_calls_res, "calls")[,1:5]))
```

|  | Sample\_39 | Sample\_23 | Sample\_56 | Sample\_53 | Sample\_43 |
| --- | --- | --- | --- | --- | --- |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;1 | FALSE | FALSE | FALSE | FALSE | FALSE |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;2 | FALSE | FALSE | FALSE | FALSE | FALSE |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;3 | FALSE | FALSE | FALSE | FALSE | FALSE |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;4 | FALSE | FALSE | FALSE | FALSE | FALSE |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;5 | FALSE | FALSE | FALSE | FALSE | FALSE |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;6 | FALSE | FALSE | FALSE | FALSE | FALSE |

K of N, Fraction, and Percent of calls made per sequence, probe, epitope, or protein can be determined using the *getKofN* function.

```
probe_calls_k_of_n <- getKofN(probe_calls_res)
knitr::kable(head(probe_calls_k_of_n))
```

|  | K | F | P |
| --- | --- | --- | --- |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;1 | 1 | 0.025 | 2.5 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;2 | 1 | 0.025 | 2.5 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;3 | 0 | 0.000 | 0.0 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;4 | 0 | 0.000 | 0.0 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;5 | 0 | 0.000 | 0.0 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;6 | 0 | 0.000 | 0.0 |

### 1.2.6 Find Epitope Segments using the unique method

After calculating probe p-values and calls, the HERON can find epitope segments, i.e. blocks of consecutive probes that have been called within a sample or cluster of samples. The unique method finds all consecutive probes for each sample, then returns the unique set of all epitopic regions.

```
epi_segments_uniq_res <- findEpitopeSegments(
    probe_calls_res,
    segment_method = "unique"
)

knitr::kable(head(epi_segments_uniq_res))
```

| x |
| --- |
| NC\_045512.2;YP\_009724390.1;Wu1-SARS2\_surface\_140\_141 |
| NC\_045512.2;YP\_009724390.1;Wu1-SARS2\_surface\_172\_173 |
| NC\_045512.2;YP\_009724390.1;Wu1-SARS2\_surface\_247\_247 |
| NC\_045512.2;YP\_009724390.1;Wu1-SARS2\_surface\_542\_546 |
| NC\_045512.2;YP\_009724390.1;Wu1-SARS2\_surface\_553\_560 |
| NC\_045512.2;YP\_009724390.1;Wu1-SARS2\_surface\_568\_577 |

The format of the epitope segments are SEQID\_Begin\_End, where the *SEQID* is the protein name, *Begin* is the starting position of the first probe within the consecutive block, and the *End* is the starting position of the last probe within the consecutive block.

### 1.2.7 Calculate Epitope-level p-values

With the epitope segments and the probe p-values, HERON can calculate a significance value for the segments using a meta p-value method. Here, we are calculating epitope p-values using Wilkinson’s max meta p-value method.

```
epi_padj_uniq <- calcEpitopePValues(
    probe_calls_res,
    epitope_ids = epi_segments_uniq_res,
    metap_method = "wmax1"
)
```

You can add sequence annotations to the row data of the HERONEpitopeDataSet object.

```
epi_padj_uniq <- addSequenceAnnotations(epi_padj_uniq)
```

### 1.2.8 Obtain Epitope-level calls

The *makeEpitopeCalls* method will work on the epitope adjusted p-values to make epitope-level sample. *getKofN* can also get the K of N results.

```
epi_calls_uniq <- makeEpitopeCalls(epi_padj_uniq, one_hit_filter = TRUE)
epi_calls_k_of_n_uniq <- getKofN(epi_calls_uniq)
knitr::kable(head(epi_calls_k_of_n_uniq))
```

|  | K | F | P |
| --- | --- | --- | --- |
| NC\_045512.2;YP\_009724390.1;Wu1-SARS2\_surface\_140\_141 | 4 | 0.100 | 10.0 |
| NC\_045512.2;YP\_009724390.1;Wu1-SARS2\_surface\_172\_173 | 9 | 0.225 | 22.5 |
| NC\_045512.2;YP\_009724390.1;Wu1-SARS2\_surface\_247\_247 | 11 | 0.275 | 27.5 |
| NC\_045512.2;YP\_009724390.1;Wu1-SARS2\_surface\_542\_546 | 12 | 0.300 | 30.0 |
| NC\_045512.2;YP\_009724390.1;Wu1-SARS2\_surface\_553\_560 | 34 | 0.850 | 85.0 |
| NC\_045512.2;YP\_009724390.1;Wu1-SARS2\_surface\_568\_577 | 37 | 0.925 | 92.5 |

### 1.2.9 Calculate Protein-level p-values

Calculate protein p-values using Tippett’s (Wilkinson’s Min) method.

```
prot_padj_uniq <- calcProteinPValues(
    epi_padj_uniq,
    metap_method = "tippetts"
)
```

### 1.2.10 Obtain Protein-level calls

```
prot_calls_uniq <- makeProteinCalls(prot_padj_uniq)
prot_calls_k_of_n_uniq <- getKofN(prot_calls_uniq)
knitr::kable(head(prot_calls_k_of_n_uniq))
```

|  | K | F | P |
| --- | --- | --- | --- |
| NC\_045512.2;YP\_009724390.1;Wu1-SARS2\_surface | 40 | 1.0 | 100 |
| NC\_045512.2;YP\_009724393.1;Wu1-SARS2\_membrane | 40 | 1.0 | 100 |
| NC\_045512.2;YP\_009724397.2;Wu1-SARS2\_nucleoca | 40 | 1.0 | 100 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope | 12 | 0.3 | 30 |

## 1.3 Other

The are other functions to utilize depending upon what you would like to do. For example, there are different methods for finding the epitope segments that involve clustering across samples. There are two main methods, one using hierarchical clustering and another using the *skater* method from the *spdep* package. In addition to the two methods, how the distance matrix is calculated can be modified. The following subsections demonstrate how to find epitope segment blocks using *hclust* or *skater* and using a binary hamming distance or a numeric euclidean distance for making calls. After the segments are found, you can then use the *calcEpitopePValuesMat* and *makeEpitopeCalls* functions as before to find the epitope p-values, protein p-values, and the respective calls.

### 1.3.1 Find Epitope Segments using the hclust method

#### 1.3.1.1 binary calls with hamming distance

```
epi_segments_hclust_res <- findEpitopeSegments(
    probe_calls_res,
    segment_method = "hclust",
    segment_score_type = "binary",
    segment_dist_method = "hamming",
    segment_cutoff = "silhouette"
)
```

#### 1.3.1.2 z-scores with euclidean distance

```
epi_segments_hclust_res2 <- findEpitopeSegments(
    probe_calls_res,
    segment_method = "hclust",
    segment_score_type = "zscore",
    segment_dist_method = "euclidean",
    segment_cutoff = "silhouette"
)
```

### 1.3.2 Find Epitope Segments using the skater method

#### 1.3.2.1 binary calls with hamming distance

```
epi_segments_skater_res <- findEpitopeSegments(
    probe_calls_res,
    segment_method = "skater",
    segment_score_type = "binary",
    segment_dist_method = "hamming",
    segment_cutoff = "silhouette"
)
```

#### 1.3.2.2 z-scores with euclidean distance

```
epi_segments_skater_res <- findEpitopeSegments(
    probe_calls_res,
    segment_method = "skater",
    segment_score_type = "zscore",
    segment_dist_method = "euclidean",
    segment_cutoff = "silhouette"
)
```

### 1.3.3 Other meta p-value methods

HERON also allows a choice for a number of meta p-value methods for combining p-values for epitopes (*calcEpitopePValuesPDS*) and proteins (*calcProteinPValuesEDS*). The methods supported by HERON are : *min\_bonf*, *min*, *max*, *fischer*/*sumlog*, *hmp/harmonicmeanp*, *wilkinsons\_min1/tippets*, *wilkinsons\_min2/wmin2*, *wilkinsons\_min3*, *wilkinsons\_min4*, *wilkinsons\_min5*, *wilkinsons\_max1/wmax1*, *wilkinsons\_max2/wmax2*, and *cct*.

When choosing a p-value method, keep in mind that the epitope p-value should be one that requires most of the probe p-values to be small (e.g. *wmax1*) and the protein should be one that requires at least one of the epitope p-values to be small (e.g. *wmax1*). Other p-value methods such as the *cct* and the *hmp* have been shown to be more accurate with p-value that have dependencies.

### 1.3.4 Making z-score cutoff calls

Some investigators would like to make z-score global level calls rather than using adjusted p-values. HERON is flexible to allow for such a setup. For example, the user wanted to make probe-level calls using a z-score cutoff > 2.

```
seq_pval_res_z <- calcCombPValues(
    obj = seq_ds_qn,
    use = "z",
    p_adjust_method = "none"
)

p_cutoff <- pnorm(2, lower.tail = FALSE)

probe_pval_res_z <- convertSequenceDSToProbeDS(seq_pval_res_z, probe_meta)

probe_calls_z2 <- makeProbeCalls(probe_pval_res_z, padj_cutoff = p_cutoff)
probe_k_of_n_z2 <- getKofN(probe_calls_z2)

knitr::kable(head(assay(probe_calls_z2,"calls")[,1:5]))
```

|  | Sample\_39 | Sample\_23 | Sample\_56 | Sample\_53 | Sample\_43 |
| --- | --- | --- | --- | --- | --- |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;1 | FALSE | FALSE | FALSE | FALSE | FALSE |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;2 | FALSE | FALSE | FALSE | FALSE | FALSE |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;3 | FALSE | FALSE | FALSE | FALSE | FALSE |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;4 | FALSE | FALSE | FALSE | FALSE | FALSE |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;5 | FALSE | FALSE | FALSE | FALSE | FALSE |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;6 | FALSE | FALSE | FALSE | FALSE | FALSE |

```
knitr::kable(head(probe_k_of_n_z2[probe_k_of_n_z2$K > 0,]))
```

|  | K | F | P |
| --- | --- | --- | --- |
| NC\_045512.2;YP\_009724393.1;Wu1-SARS2\_membrane;4 | 1 | 0.025 | 2.5 |
| NC\_045512.2;YP\_009724393.1;Wu1-SARS2\_membrane;5 | 3 | 0.075 | 7.5 |
| NC\_045512.2;YP\_009724393.1;Wu1-SARS2\_membrane;6 | 1 | 0.025 | 2.5 |
| NC\_045512.2;YP\_009724393.1;Wu1-SARS2\_membrane;7 | 4 | 0.100 | 10.0 |
| NC\_045512.2;YP\_009724393.1;Wu1-SARS2\_membrane;8 | 10 | 0.250 | 25.0 |
| NC\_045512.2;YP\_009724393.1;Wu1-SARS2\_membrane;156 | 2 | 0.050 | 5.0 |

The calls can also be used to find epitopes segments, p-values, and calls. Also, can be used to make protein level calls.

```
epi_segments_uniq_z2_res <- findEpitopeSegments(
    probe_calls_z2,
    segment_method = "unique"
)
```

If we want to find regions where the z > 2 for all of the consecutive probes, using the *max* meta p-value method will ensure that.

```
epi_pval_uniq_z2 <- calcEpitopePValues(
    probe_pds = probe_pval_res_z,
    epitope_ids = epi_segments_uniq_z2_res,
    metap_method = "max",
    p_adjust_method = "none"
)
```

Again, *makeEpitopeCalls* will be used in order to find significant regions.

```
epi_calls_uniq_z2 <- makeEpitopeCalls(
    epi_ds = epi_pval_uniq_z2,
    padj_cutoff = p_cutoff
)
```

Other segmentation methods can be used with the called regions through the binary score clustering methods.

```
epi_segments_skater_z2_res <- findEpitopeSegments(
    probe_calls_z2,
    segment_method = "skater",
    segment_score_type = "binary",
    segment_dist_method = "hamming",
    segment_cutoff = "silhouette")
```

### 1.3.5 Smoothing across probes

The pepStat paper (<https://pubmed.ncbi.nlm.nih.gov/23770318/>) mentions that smoothing can sometimes help reduce the high-variability of the peptide array data. HERON has implemented a running average smoothing algorithm across protein probes that can handle missing values. The function *smoothProbeMat* will take as input a probe matrix and will return a matrix that has been smoothed. The smoothed matrix can then be processed through the workflow using the *calcProbePValuesProbeMat* call instead of the *calcProbePValuesSeqMat* call since now the probe signal is no longer a direct copy from the sequence.

```
probe_ds_qn <- convertSequenceDSToProbeDS(seq_ds_qn, probe_meta )

smooth_ds <- smoothProbeDS(probe_ds_qn)
```

After you smoothed the data using the probes, the probe p-value will be calculated on the probe-level rather than the sequence-level.

```
probe_sm_pval <- calcCombPValues(smooth_ds)
```

The probe calls can then be made as before.

```
probe_sm_calls <- makeProbeCalls(probe_sm_pval)
probe_sm_k_of_n <- getKofN(probe_sm_calls)
knitr::kable(assay(probe_sm_calls,"calls")[1:3,1:3])
```

|  | Sample\_39 | Sample\_23 | Sample\_56 |
| --- | --- | --- | --- |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;1 | FALSE | FALSE | FALSE |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;2 | FALSE | FALSE | FALSE |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;3 | FALSE | FALSE | FALSE |

```
knitr::kable(head(probe_sm_k_of_n[probe_sm_k_of_n$K > 0,]))
```

|  | K | F | P |
| --- | --- | --- | --- |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;1 | 1 | 0.025 | 2.5 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;2 | 1 | 0.025 | 2.5 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;57 | 1 | 0.025 | 2.5 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;58 | 1 | 0.025 | 2.5 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;59 | 1 | 0.025 | 2.5 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;60 | 2 | 0.050 | 5.0 |

### 1.3.6 Calculate paired t-tests

Paired t-tests can be utilized and combined with the z-tests as well. Here is an example where we pair the five COVID- samples to the COVID+ samples and run *calcProbePValuesSeqMat* with the *d\_paired* parameter set.

```
data(heffron2021_wuhan)
probe_meta <- attr(heffron2021_wuhan, "probe_meta")
colData_paired <- colData(heffron2021_wuhan)

## Make some samples paired by setting the sample ids
pre_idx <- which(colData_paired$visit == "pre")
colData_post <- colData_paired[colData_paired$visit == "post",]
new_ids <- colData_post$SampleName[seq_len(5)]
colData_paired$ptid[pre_idx[seq_len(5)]] = new_ids

paired_ds <- heffron2021_wuhan
colData(paired_ds) <- colData_paired

## calculate p-values
pval_res <- calcCombPValues(
    obj = paired_ds,
    d_paired = TRUE
)

knitr::kable(assay(pval_res[1:3,],"pvalue"))
```

|  | Sample\_39 | Sample\_23 | Sample\_56 | Sample\_53 | Sample\_43 |
| --- | --- | --- | --- | --- | --- |
| AAAYYVGYLQPRTFLL | 0.4192558 | 0.8596157 | 0.3643977 | 0.5703188 | 0.5695711 |
| AADLDDFSKQLQQSMS | 0.0001467 | 0.0913935 | 0.0000501 | 0.7835355 | 0.0000709 |
| AAEASKKPRQKRTATK | 0.0839504 | 0.2146309 | 0.0049659 | 0.2129732 | 0.1286111 |

### 1.3.7 Use the wilcox test for probe-level p-values

To account for non-normality, HERON implements the two sample wilcox test in placed of the t-test used for the differential p-values. Below is an example of how to use it.

```
seq_pval_res_w <- calcCombPValues(
    obj = seq_ds_qn,
    use = "w", d_abs_shift = 1
)
#> exact:
probe_pval_res_w <- convertSequenceDSToProbeDS(seq_pval_res_w)
knitr::kable(assay(probe_pval_res_w[1:3, 1:5], "padj"))
```

|  | Sample\_39 | Sample\_23 | Sample\_56 | Sample\_53 | Sample\_43 |
| --- | --- | --- | --- | --- | --- |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;1 | 1 | 1.00e+00 | 1.0000000 | 0.0332971 | 1 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;2 | 1 | 1.00e+00 | 1.0000000 | 0.0800597 | 1 |
| NC\_045512.2;YP\_009724392.1;Wu1-SARS2\_envelope;3 | 1 | 8.83e-05 | 0.0009847 | 1.0000000 | 1 |

### 1.3.8 Use of the condition column

You can use the *condition* column in the *colData* dataframe. It is used in the *getKofN* function. The data type of the column can be either a character or factor. When the condition column exists in the *colData*, three columns (number of samples (K), frequency (F), and percent (P)) are provided for each unique factor/character value.

```
col_data <- colData(heffron2021_wuhan)
covid <- which(col_data$visit == "post")

col_data$condition[covid[1:10]] <- "COVID2"

seq_ds <- heffron2021_wuhan
colData(seq_ds) <- col_data

seq_ds_qn <- quantileNormalize(seq_ds)
seq_pval_res <- calcCombPValues(seq_ds_qn)
probe_pval_res <- convertSequenceDSToProbeDS(seq_pval_res)
probe_calls_res <- makeProbeCalls(probe_pval_res)
probe_calls_k_of_n <- getKofN(probe_calls_res)
probe_calls_k_of_n <-
    probe_calls_k_of_n[
        order(probe_calls_k_of_n$K, decreasing = TRUE),]
knitr::kable(head(probe_calls_k_of_n))
```

|  | K | F | P | K\_COVID2 | F\_COVID2 | P\_COVID2 | K\_COVID | F\_COVID | P\_COVID |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| NC\_045512.2;YP\_009724393.1;Wu1-SARS2\_membrane;7 | 38 | 0.950 | 95.0 | 10 | 1.0 | 100 | 28 | 0.9333333 | 93.33333 |
| NC\_045512.2;YP\_009724393.1;Wu1-SARS2\_membrane;8 | 38 | 0.950 | 95.0 | 10 | 1.0 | 100 | 28 | 0.9333333 | 93.33333 |
| NC\_045512.2;YP\_009724390.1;Wu1-SARS2\_surface;554 | 37 | 0.925 | 92.5 | 9 | 0.9 | 90 | 28 | 0.9333333 | 93.33333 |
| NC\_045512.2;YP\_009724393.1;Wu1-SARS2\_membrane;5 | 36 | 0.900 | 90.0 | 10 | 1.0 | 100 | 26 | 0.8666667 | 86.66667 |
| NC\_045512.2;YP\_009724393.1;Wu1-SARS2\_membrane;6 | 36 | 0.900 | 90.0 | 9 | 0.9 | 90 | 27 | 0.9000000 | 90.00000 |
| NC\_045512.2;YP\_009724397.2;Wu1-SARS2\_nucleoca;394 | 36 | 0.900 | 90.0 | 9 | 0.9 | 90 | 27 | 0.9000000 | 90.00000 |

## 1.4 Funding

HERON and its developers have been partially supported by funding from the Clinical and Translational Science Award (CTSA) program (ncats.nih.gov/ctsa), through the National Institutes of Health National Center for Advancing Translational Sciences (NCATS), grants UL1TR002373 and KL2TR002374, NIH National Institute of Allergy and Infectious Diseases, 2U19AI104317-06, NIH National Cancer Institute (P30CA14520, P50CA278595, and P01CA250972), startup funds through the University of Wisconsin Department of Obstetrics and Gynecology and the University of Wisconsin-Madison Office of the Chancellor and the Vice Chancellor for Research and Graduate Education with funding from the Wisconsin Alumni Research Foundation through the Data Science Initiative award.

## 1.5 Acknowledgments

We have benefited in the development of *HERON* from the help and feedback of many individuals, including but not limited to:

The Bioconductor Core Team, Paul Sondel, Anna Hoefges, Amy Erbe Gurel, Jessica Vera, Rene Welch, Ken Lo (Nimble Therapeutics), Brad Garcia (Nimble Therapeutics), Jigar Patel (Nimble Therapeutics), John Tan, Nicholas Mathers, Richard Pinapatti.

## 1.6 Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] HERON_1.8.0                 SummarizedExperiment_1.40.0
#>  [3] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [5] Seqinfo_1.0.0               IRanges_2.44.0
#>  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
#>  [9] generics_0.1.4              MatrixGenerics_1.22.0
#> [11] matrixStats_1.5.0
#>
#> loaded via a namespace (and not attached):
#>  [1] xfun_0.53           bslib_0.9.0         lattice_0.22-7
#>  [4] mathjaxr_1.8-0      numDeriv_2016.8-1.1 mutoss_0.1-13
#>  [7] tools_4.5.1         Rdpack_2.6.4        spdep_1.4-1
#> [10] sandwich_3.1-1      proxy_0.4-27        cluster_2.1.8.1
#> [13] KernSmooth_2.23-26  Matrix_1.7-4        data.table_1.17.8
#> [16] lifecycle_1.0.4     deldir_2.0-4        compiler_4.5.1
#> [19] statmod_1.5.1       mnormt_2.1.1        codetools_0.2-20
#> [22] class_7.3-23        htmltools_0.5.8.1   sass_0.4.10
#> [25] yaml_2.3.10         jquerylib_0.1.4     MASS_7.3-65
#> [28] classInt_0.4-11     metap_1.12          DelayedArray_0.36.0
#> [31] cachem_1.1.0        limma_3.66.0        wk_0.9.4
#> [34] boot_1.3-32         abind_1.4-8         multcomp_1.4-29
#> [37] digest_0.6.37       mvtnorm_1.3-3       sf_1.0-21
#> [40] TFisher_0.2.0       splines_4.5.1       fastmap_1.2.0
#> [43] grid_4.5.1          cli_3.6.5           SparseArray_1.10.0
#> [46] magrittr_2.0.4      qqconf_1.3.2        S4Arrays_1.10.0
#> [49] survival_3.8-3      e1071_1.7-16        TH.data_1.1-4
#> [52] sn_2.1.1            sp_2.2-0            plotrix_3.8-4
#> [55] spData_2.3.4        rmarkdown_2.30      XVector_0.50.0
#> [58] multtest_2.66.0     zoo_1.8-14          evaluate_1.0.5
#> [61] knitr_1.50          rbibutils_2.3       s2_1.1.9
#> [64] rlang_1.1.6         Rcpp_1.1.0          DBI_1.2.3
#> [67] jsonlite_2.0.0      R6_2.6.1            units_1.0-0
```