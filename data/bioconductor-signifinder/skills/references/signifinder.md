# signifinder vignette

Stefania Pirrotta1\* and Enrica Calura1\*\*

1Biology Department, University of Padova, Italy

\*stefania.pirrotta@phd.unipd.it
\*\*enrica.calura@unipd.it

#### 30 October 2025

#### Abstract

signifinder offers a rapid way to apply and explore gene expression tumor signatures from literature. It allows to compute the signature scores on the user dataset. Further, it supports the exploration of the scores proving functions to visualize single or multiple signatures. Currently, signifinder contains more than 60 distinct signatures collected from the literature relating to multiple tumors and multiple cancer processes.

#### Package

signifinder 1.12.0

# 1 Introduction

In cancer studies, many works propose transcriptional signatures as good indicators of cancer processes, for their potential to show cancer ongoing activities and that can be used for patient stratification. For these reasons, they are considered potentially useful to guide therapeutic decisions and monitoring interventions. Moreover, transcriptional signatures of RNA-seq experiments are also used to assess the complex relations between the tumor and its microenvironment. In recent years, the new technologies for transcriptome detection (single-cell RNA-seq and spatial transcriptomics) highlighted the highly heterogeneous behaviour of this disease and, as a result, the need to dissect its complexity.

Each of these signatures has a specific gene set (and eventually a set of coefficients to differently weight the gene contributions) whose expression levels are combined in a single-sample score. And each signature has its own method to define the computation of the score. Despite much evidence that computational implementations are useful to improve data applicability and dissemination, the vast majority of signatures in literature are not published along with a computational code and only few of them have been implemented in a software, virtuous examples are: the R package `consensusOV`, dedicated to the TCGA ovarian cancer signature; and the R package `genefu` which hosts some of the most popular signatures of breast cancer.

`signifinder` provides an easy and fast computation of several published signatures. Firstly, users can see all the signatures collected so far in the package, with all the useful information and a description on how to properly interpret the scores. Then, users can decide which signature they want to compute on their dataset. To be easily integrated in the expression data analysis pipelines, `signifinder` works with the Bioconductor data structures (`SummarizedExperiment`, `SingleCellExperiment` and `SpatialExperiment`).

Also, several visualization functions are implemented to visualize the scores. These can help in the result interpretations: users can not only browse single signatures independently but also compare them with each other.

# 2 Installation

To install this package:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("signifinder")
```

# 3 Criteria for signature inclusion

The criteria for the inclusion of the signatures are: (i) signatures should rely on cancer topics, and be developed and used on cancer samples; (ii) signatures must exclusively use transcriptomic data; (iii) the original paper must state the gene list used for the signature definition, where all genes have an official gene symbol (Hugo consortium) or an unambiguous translation (genes without an official gene symbol are removed); (iv) the method to calculate the score must be unambiguously described.
While it may not ever be possible to include all cancer signatures proposed in the literature, our package makes easy the addition of new signatures (by us or by others via “pull requests”, see [Adding new signatures](#adding-new-signatures)).

# 4 How to use signifinder

## 4.1 Input expression data

The input expression dataset must be normalized RNA-Seq counts (or normalized data matrix from microarrays) of bulk transcriptomics data, single-cell transcriptomics data or spatial transcriptomics data. They should be provided in the form of a matrix, a data frame or a `SummarizedExperiment` (and respectively `SingleCellExperiment`/`SpatialExperiment`) where rows correspond to genes and columns correspond to samples. In the last case, the name of the assay containing the normalized values should be “norm\_expr” (users can also choose another name, but it should be specified in the `whichAssay` argument). Regardless the input type class, the output data is a `SummarizedExperiment` (`SingleCellExperiment`/`SpatialExperiment`) where the scores computed are put in the `colData` section.

Gene IDs in the input data can either be gene symbols, NCBI entrez or ensembl gene IDs. Users must say which of the three identifiers they use (SYMBOL, ENTREZID or ENSEMBL) to let the package convert the signature gene lists (`nametype` argument inside the signature functions).
When a signature is computed a message is shown that says the percentage of genes found in the input data compared to the original list. There is no minimum threshold of genes for signatures to be computed, but a `warning` will be given if there are less than the 30% of signature genes. After a signature has been calculated it is possible to visually inspect signature gene expressions using `geneHeatmapSignPlot` (see [Signature goodness](#signature-goodness)).

Furthermore, the original works also specify the type of expression value (e.g. normalized value, TPM (transcript per million), log(TPM), etc…) that should be used to compute the signature. Therefore, during signature computation, data type should be eventually converted as reported in the original work. When using `signifinder`, users must supply the input data in the form of *normalised counts* (or *normalised arrays*) and, for the signatures which require this, a data transformation step will be automatically performed. The transformed data matrix will be included in the output as an additional assay and the name of the assay will be the name of the conversion (i.e. “TPM”, “CPM” or “FPKM”). Alternatively, if the input data is a `SummarizedExperiment` object that already contains (in addition to the normalized count) also an assay of the transformed data, this will be used directly. Note that in order to be used they must be called “TPM”, “CPM” or “FPKM”. Finally, included signatures have been developed both from array and RNA-seq data, therefore it is crucially important for users to specify the type of input data: “microarray” or “rnaseq” (`inputType` argument inside the signature functions). In `signifinder`, signatures developed with microarray can be applied to RNA-seq data but not vice versa due to input type conversions.

## 4.2 Computation of scores

In the following section, we use an example bulk expression dataset of ovarian cancer to show how to use `signifinder` with a standard workflow.

```
# loading packages
library(SummarizedExperiment)
library(signifinder)
library(dplyr)
data(ovse)
ovse
```

```
## class: SummarizedExperiment
## dim: 3180 40
## metadata(0):
## assays(4): norm_expr TPM CPM FPKM
## rownames(3180): ABL2 ACADM ... TMSB4Y USP9Y
## rowData names(0):
## colnames(40): sample1 sample2 ... sample39 sample40
## colData names(42): OV_subtype os ... APM_Wang ADO_Sidders
```

We can check all the signatures available in the package with the function `availableSignatures`.

```
availSigns <- availableSignatures()
```

The function returns a data frame with all the signatures included in the package and for each signature the following information:

* signature: name of the signature
* scoreLabel: column name(s) of scores added inside `colData`
* functionName: name of the function to use to compute the signature
* topic: general cancer topic
* tumor: tumor type for which the signature was developed
* tissue: tumor tissue for which the signature was developed
* cellType: cell type for which the signature was developed
* requiredInput: tumor data with which the signature was developed
* transformationStep: data transformation step performed inside the function starting from the user’s ‘normArray’ or ‘normCounts’ data
* author: first author of the work in which the signature is described
* reference: reference of the work
* description: brief description of the signature and how to evaluate its score

|  | 1 |
| --- | --- |
| signature | EMT\_Miow |
| scoreLabel | EMT\_Miow\_Epithelial, EMT\_Miow\_Mesenchymal |
| functionName | EMTSign |
| topic | epithelial to mesenchymal |
| tumor | ovarian cancer |
| tissue | ovary |
| cellType | bulk |
| requiredInput | microarray, rnaseq |
| transformationStep | normArray, normCounts |
| author | Miow |
| reference | Miow Q. et al. Oncogene (2015) |
| description | Double score obtained with ssGSEA to establish the epithelial- and the mesenchymal-like status in ovarian cancer patients. |

We can also interrogate the table asking which signatures are available for a specific tissue (e.g. ovary).

```
ovary_signatures <- availableSignatures(tissue = "ovary", description = FALSE)
```

Table 1: Table 2: Signatures developed for ovary collected in signifinder.

|  | signature | scoreLabel | functionName | topic | tumor | tissue | cellType | requiredInput | transformationStep | author | reference |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | EMT\_Miow | EMT\_Miow\_Epithelial, EMT\_Miow\_Mesenchymal | EMTSign | epithelial to mesenchymal | ovarian cancer | ovary | bulk | microarray, rnaseq | normArray, normCounts | Miow | Miow Q. et al. Oncogene (2015) |
| 6 | Pyroptosis\_Ye | Pyroptosis\_Ye | pyroptosisSign | pyroptosis | ovarian cancer | ovary | bulk | rnaseq | FPKM | Ye | Ye Y. et al. Cell Death Discov. (2021) |
| 10 | Ferroptosis\_Ye | Ferroptosis\_Ye | ferroptosisSign | ferroptosis | ovarian cancer | ovary | bulk | microarray, rnaseq | normArray, FPKM | Ye | Ye Y. et al. Front. Mol. Biosci. (2021) |
| 14 | LipidMetabolism\_Zheng | LipidMetabolism\_Zheng | lipidMetabolismSign | metabolism | epithelial ovarian cancer | ovary | bulk | rnaseq | normCounts | Zheng | Zheng M. et al. Int. J. Mol. Sci. (2020) |
| 17 | ImmunoScore\_Hao | ImmunoScore\_Hao | immunoScoreSign | immune system | epithelial ovarian cancer | ovary | bulk | microarray, rnaseq | normArray, log2(FPKM+0.01) | Hao | Hao D. et al. Clin Cancer Res (2018) |
| 19 | ConsensusOV\_Chen | ConsensusOV\_Chen\_IMR, ConsensusOV\_Chen\_DIF, ConsensusOV\_Chen\_PRO, ConsensusOV\_Chen\_MES | consensusOVSign | ovarian subtypes | high-grade serous ovarian carcinoma | ovary | bulk | microarray, rnaseq | normArray, normCounts | Chen | Chen G.M. et al. Clin Cancer Res (2018) |
| 21 | Matrisome\_Yuzhalin | Matrisome\_Yuzhalin | matrisomeSign | extracellular matrix | ovarian cystadenocarcinoma, gastric adenocarcinoma, colorectal adenocarcinoma, lung adenocarcinoma | ovary, lung, stomach, colon | bulk | microarray, rnaseq | normArray, normCounts | Yuzhalin | Yuzhalin A. et al. Br J Cancer (2018) |
| 48 | HRDS\_Lu | HRDS\_Lu | HRDSSign | chromosomal instability | ovarian cancer, breast cancer | ovary, breast | bulk | microarray, rnaseq | normArray, normCounts | Lu | Lu J. et al. J Mol Med (2014) |
| 50 | DNArep\_Kang | DNArep\_Kang | DNArepSign | chromosomal instability | serous ovarian cystadenocarcinoma | ovary | bulk | microarray, rnaseq | normArray, log2(normCount+1) | Kang | Kang J. et al. JNCI (2012) |
| 51 | IPSOV\_Shen | IPSOV\_Shen | IPSOVSign | immune system | ovarian cancer | ovary | bulk | microarray, rnaseq | normArray, log2(normCount+1) | Shen | Shen S. et al. EBiomed (2019) |
| 64 | LRRC15CAF\_Dominguez | LRRC15CAF\_Dominguez | LRRC15CAFSign | cancer associated fibroblasts | pancreatic adenocarcinoma, breast cancer, lung cancer, ovarian cancer, colon cancer, renal cancer, esophageal cancer, stomach adenocarcinoma, bladder cancer, head and neck squamous cell carcinoma | pancreas, breast, lung, ovary, colon, kidney, esophagus, stomach, bladder, head and neck | bulk | rnaseq | log2(normCounts+1) | Dominguez | Dominguez C.X. et al. Cancer Discovery (2020) |
| 66 | COXIS\_Bonavita | COXIS\_Bonavita | COXISSign | immune system | melanoma, bladder cancer, gastric cancer, clear cell renal cancer, ovarian cancer, cervical cancer, breast cancer (TNBC), lung cancer, head and neck squamous cell carcinoma | skin, bladder, stomach, kidney, ovary, cervix, breast, lung, head and neck | bulk | rnaseq | log2(normCounts+1) | Bonavita | Bonavita E. et al. Immunity (2020) |

Once we have found a signature of interest, we can compute it by using the corresponding function (indicated in the `functionName` field of `availableSignatures` table). All the signature functions require the expression data and to indicate the type of input data (`inputType` equal to “rnaseq” or “microarray”). Data are supposed to be the normalized expression values.

```
ovse <- ferroptosisSign(dataset = ovse, inputType = "rnaseq")
```

```
## ferroptosisSignYe is using 100% of signature genes
```

Some signatures are grouped in the same function by cancer topic even if they deal with different cancer types and computation approaches. We can unequivocally choose the one we are interested in by stating the first author of the signature (indicated in the `author` field of `availableSignatures` table). E.g., currently, there are four different epithelial-to-mesenchymal transition (EMT) signatures implemented inside the `EMTSign` function (“Miow”, “Mak”, “Cheng” or “Thompson”). We can choose which one to compute stating the `author` argument:

```
ovse <- EMTSign(dataset = ovse, inputType = "rnaseq", author = "Miow")
```

```
## EMTSignMiow is using 96% of epithelial signature genes
```

```
## EMTSignMiow is using 91% of mesenchymal signature genes
```

```
## ℹ GSVA version 2.4.0
```

```
## ℹ Searching for genes/features with constant values
```

```
## ! 3 genes/features with constant values throughout the samples
```

```
## ℹ Calculating  ssGSEA scores for 2 gene sets
```

```
## ℹ Calculating ranks
```

```
## ℹ Calculating rank weights
```

```
## ℹ Normalizing ssGSEA scores
```

```
## ✔ Calculations finished
```

In this way, “EMT\_Miow” is computed. Regardless the expression input type, the output data of all the signature functions is a `SummarizedExperiment` with the computed signature scores in the `colData`. Thus, the returned object can be resubmitted as input data to another signature function and will be returned as well with the addition of the new signature in the `colData`.

We can also compute multiple signatures at once with the function `multipleSign`. We can specify which signatures we are interested in through the use of the arguments `tissue`, `tumor` and/or `topic` to define the signature list to compute. E.g. here below we compute all the available signature for ovary and pan-tissue:

```
ovse <- multipleSign(dataset = ovse, inputType = "rnaseq",
                     tissue = c("ovary", "pan-tissue"))
```

```
## EMTSignMiow is using 96% of epithelial signature genes
```

```
## EMTSignMiow is using 91% of mesenchymal signature genes
```

```
## ℹ GSVA version 2.4.0
```

```
## ℹ Searching for genes/features with constant values
```

```
## ! 3 genes/features with constant values throughout the samples
```

```
## ℹ Calculating  ssGSEA scores for 2 gene sets
```

```
## ℹ Calculating ranks
```

```
## ℹ Calculating rank weights
```

```
## ℹ Normalizing ssGSEA scores
```

```
## ✔ Calculations finished
```

```
## EMTSignMak is using 96% of epithelial signature genes
```

```
## EMTSignMak is using 100% of mesenchymal signature genes
```

```
## pyroptosisSignYe is using 86% of signature genes
```

```
## ferroptosisSignYe is using 100% of signature genes
```

```
## lipidMetabolismSign is using 100% of signature genes
```

```
## hypoxiaSign is using 92% of signature genes
```

```
## immunoScoreSignHao is using 100% of signature genes
```

```
## immunoScoreSignRoh is using 100% of signature genes
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
## Loading training data
```

```
## Training Random Forest...
```

```
## IPSSign is using 98% of signature genes
```

```
## matrisomeSign is using 100% of signature genes
```

```
## mitoticIndexSign is using 100% of signature genes
```

```
## ImmuneCytSignRooney is using 100% of signature genes
```

```
## IFNSign is using 100% of signature genes
```

```
## expandedImmuneSign is using 100% of signature genes
```

```
## TinflamSign is using 100% of signature genes
```

```
## CINSign is using 96% of signature genes
```

```
## CINSign is using 94% of signature genes
```

```
## cellCycleSignLundberg is using 93% of signature genes
```

```
## cellCycleSignDavoli is using 100% of signature genes
```

```
## ASCSign is using 92% of signature genes
```

```
## ImmuneCytSignDavoli is using 100% of signature genes
```

```
## ChemokineSign is using 100% of signature genes
```

```
## ECMSign is using 100% of up signature genes
```

```
## ECMSign is using 93% of down signature genes
```

```
## ℹ GSVA version 2.4.0
```

```
## ℹ Searching for genes/features with constant values
```

```
## ! 3 genes/features with constant values throughout the samples
```

```
## ℹ Calculating  ssGSEA scores for 2 gene sets
```

```
## ℹ Calculating ranks
```

```
## ℹ Calculating rank weights
```

```
## ℹ Normalizing ssGSEA scores
```

```
## ✔ Calculations finished
```

```
## HRDSSign is using 89% of signature genes
```

```
## VEGFSign is using 100% of signature genes
```

```
## DNArepSign is using 87% of signature genes
```

```
## IPSOVSign is using 100% of signature genes
```

```
## ℹ GSVA version 2.4.0
```

```
## ℹ Searching for genes/features with constant values
```

```
## ! 3 genes/features with constant values throughout the samples
```

```
## ! Some gene sets have size one. Consider setting minSize > 1
```

```
## ℹ Calculating  ssGSEA scores for 15 gene sets
```

```
## ℹ Calculating ranks
```

```
## ℹ Calculating rank weights
```

```
## ℹ Normalizing ssGSEA scores
```

```
## ✔ Calculations finished
```

```
## APMSign is using 100% of signature genes
```

```
## ℹ GSVA version 2.4.0
```

```
## ℹ Searching for genes/features with constant values
```

```
## ! 3 genes/features with constant values throughout the samples
```

```
## ! Genes/features with constant values are discarded
```

```
## ℹ Calculating GSVA ranks
```

```
## ℹ kcdf='auto' (default)
```

```
## ℹ GSVA dense (classical) algorithm
```

```
## ℹ Row-wise ECDF estimation with Gaussian kernels
```

```
## ℹ Calculating GSVA column ranks
```

```
## ℹ Calculating GSVA scores
```

```
## ℹ GSVA dense (classical) algorithm
```

```
## ✔ Calculations finished
```

```
## ADOSign is using 100% of signature genes
```

```
## ℹ GSVA version 2.4.0
```

```
## ℹ Searching for genes/features with constant values
```

```
## ! 3 genes/features with constant values throughout the samples
```

```
## ! Genes/features with constant values are discarded
```

```
## ℹ Calculating GSVA ranks
```

```
## ℹ kcdf='auto' (default)
```

```
## ℹ GSVA dense (classical) algorithm
```

```
## ℹ Row-wise ECDF estimation with Gaussian kernels
```

```
## ℹ Calculating GSVA column ranks
```

```
## ℹ Calculating GSVA scores
```

```
## ℹ GSVA dense (classical) algorithm
```

```
## ✔ Calculations finished
```

```
## LRRC15CAFSign is using 100% of signature genes
```

```
## COXISSign is using 83% of signature genes
```

Here below, instead, we compute all the available signature for ovary, pan-tissue and that are related to the immune system activity:

```
ovse <- multipleSign(dataset = ovse, inputType = "rnaseq",
                     tissue = c("ovary", "pan-tissue"),
                     topic = "immune system")
```

```
## immunoScoreSignHao is using 100% of signature genes
```

```
## immunoScoreSignRoh is using 100% of signature genes
```

```
## IPSSign is using 98% of signature genes
```

```
## ImmuneCytSignRooney is using 100% of signature genes
```

```
## IFNSign is using 100% of signature genes
```

```
## expandedImmuneSign is using 100% of signature genes
```

```
## TinflamSign is using 100% of signature genes
```

```
## ImmuneCytSignDavoli is using 100% of signature genes
```

```
## ChemokineSign is using 100% of signature genes
```

```
## IPSOVSign is using 100% of signature genes
```

```
## ℹ GSVA version 2.4.0
```

```
## ℹ Searching for genes/features with constant values
```

```
## ! 3 genes/features with constant values throughout the samples
```

```
## ! Some gene sets have size one. Consider setting minSize > 1
```

```
## ℹ Calculating  ssGSEA scores for 15 gene sets
```

```
## ℹ Calculating ranks
```

```
## ℹ Calculating rank weights
```

```
## ℹ Normalizing ssGSEA scores
```

```
## ✔ Calculations finished
```

```
## APMSign is using 100% of signature genes
```

```
## ℹ GSVA version 2.4.0
```

```
## ℹ Searching for genes/features with constant values
```

```
## ! 3 genes/features with constant values throughout the samples
```

```
## ! Genes/features with constant values are discarded
```

```
## ℹ Calculating GSVA ranks
```

```
## ℹ kcdf='auto' (default)
```

```
## ℹ GSVA dense (classical) algorithm
```

```
## ℹ Row-wise ECDF estimation with Gaussian kernels
```

```
## ℹ Calculating GSVA column ranks
```

```
## ℹ Calculating GSVA scores
```

```
## ℹ GSVA dense (classical) algorithm
```

```
## ✔ Calculations finished
```

```
## COXISSign is using 83% of signature genes
```

Alternatively, we can state exactly the signature names using the `whichSign` argument.

```
ovse <- multipleSign(dataset = ovse, inputType = "rnaseq",
                     whichSign = c("EMT_Miow", "IPSOV_Shen"))
```

```
## EMTSignMiow is using 96% of epithelial signature genes
```

```
## EMTSignMiow is using 91% of mesenchymal signature genes
```

```
## ℹ GSVA version 2.4.0
```

```
## ℹ Searching for genes/features with constant values
```

```
## ! 3 genes/features with constant values throughout the samples
```

```
## ℹ Calculating  ssGSEA scores for 2 gene sets
```

```
## ℹ Calculating ranks
```

```
## ℹ Calculating rank weights
```

```
## ℹ Normalizing ssGSEA scores
```

```
## ✔ Calculations finished
```

```
## IPSOVSign is using 100% of signature genes
```

```
## ℹ GSVA version 2.4.0
```

```
## ℹ Searching for genes/features with constant values
```

```
## ! 3 genes/features with constant values throughout the samples
```

```
## ! Some gene sets have size one. Consider setting minSize > 1
```

```
## ℹ Calculating  ssGSEA scores for 15 gene sets
```

```
## ℹ Calculating ranks
```

```
## ℹ Calculating rank weights
```

```
## ℹ Normalizing ssGSEA scores
```

```
## ✔ Calculations finished
```

## 4.3 Signature goodness

When computing a signature on a dataset we always have to keep in mind that not all the signature genes may be present in the dataset. Also, these may have many zero values or other issues affecting the goodness of a specific signature for the dataset. We can inspect some signature’s technical parameters to evaluate their reliability for the analysed dataset. First, users can access the complete gene list of a signature with the function `getSignGenes`, that returns a dataframe object with “SYMBOL” in the first column. Some signatures have also additional columns: “coeff” for coefficients that weigh the gene contributions; “class” for a classification that divides the signature in two or more groups. Few signatures have other specific columns.

```
getSignGenes("VEGF_Hu")
```

```
##     SYMBOL
## 1    RRAGD
## 2    FABP5
## 3    UCHL1
## 4      GAL
## 5    PLOD1
## 6    DDIT4
## 7    VEGFA
## 8      ADM
## 9  ANGPTL4
## 10   NDRG1
## 11 SLC16A3
## 12  FLVCR2
```

```
getSignGenes("Pyroptosis_Ye")
```

```
##   SYMBOL  coeff
## 1   AIM2 -0.187
## 2  PLCG1  0.068
## 3  ELANE  0.097
## 4   PJVK -0.143
## 5  CASP3 -0.086
## 6  CASP6 -0.033
## 7  GSDMA  0.130
```

```
getSignGenes("EMT_Thompson")
```

```
##    SYMBOL       class
## 1    CDH1  epithelial
## 2    CDH3  epithelial
## 3   CLDN4  epithelial
## 4   EPCAM  epithelial
## 5    ST14  epithelial
## 6    MAL2  epithelial
## 7     VIM mesenchymal
## 8   SNAI2 mesenchymal
## 9    ZEB2 mesenchymal
## 10    FN1 mesenchymal
## 11   MMP2 mesenchymal
## 12   AGER mesenchymal
```

Second, the `evaluationSignPlot` function returns a multipanel plot that shows for each signature: (i) a value of the goodness of a signature for the user’s dataset. This goes from 0, worst goodness, to 100, best goodness, and is a combination of the parameters shown in the other pannels; (ii) the percentage of genes from the signature gene list that are actually available in the dataset; (iii) the percentage of zero values in the signature genes, for each sample; (iv) the correlation between signature scores and the sample total read counts; (v) the correlation between signature scores and the percentage of the sample total zero values.

```
evaluationSignPlot(data = ovse)
```

![](data:image/png;base64...)

Third, users may be also interested in visually exploring the expression values of the genes involved in a signature. In this case, we can use `geneHeatmapSignPlot` to visualize them. It generates a heatmap of the expression values with genes on the rows and samples on the columns.

```
geneHeatmapSignPlot(data = ovse, whichSign = "LipidMetabolism_Zheng",
                    logCount = TRUE)
```

![](data:image/png;base64...)

Further, the function is not restricted to the visualization of only one signature, and we can also plot the expression values of genes from multiple signatures, also evaluating the gene list intersections. Since each signature has its own method to compute the score then to plot several signatures together the scores are transformed into z-score, individually for each signature.

```
set.seed(21)
geneHeatmapSignPlot(data = ovse, whichSign = c("IFN_Ayers", "Tinflam_Ayers"),
                    logCount = TRUE)
```

![](data:image/png;base64...)

## 4.4 Visualization

### 4.4.1 Score distribution plot

Each signature computed can be explored using the `oneSignPlot` function to visualize both the score and the density distribution.

```
oneSignPlot(data = ovse, whichSign = "Hypoxia_Buffa")
```

```
## Warning in annotate("text", label = statistics, x = quantile(signval, 0.1), :
## Ignoring empty aesthetic: `label`.
```

```
## `stat_bin()` using `bins = 30`. Pick better value `binwidth`.
```

![](data:image/png;base64...)

### 4.4.2 Score correlation plot

To easily investigate the relation across multiple signatures, `signifinder` provides a function to easily show the pairwise correlations of the signatures (`correlationSignPlot`). The `whichSign` argument could be set to specify which signatures should be plotted. When it is not stated all signatures are used. Green-blue colors represent anticorrelations while orange-red scale is for positive correlations. Then, signatures are clustered to group together higher related ones.

```
sign_cor <- correlationSignPlot(data = ovse)
```

![](data:image/png;base64...)

```
highest_correlated <- unique(unlist(
    sign_cor$data[(sign_cor$data$cor>0.95 & sign_cor$data$cor<1),c(1,2)]))
```

### 4.4.3 Score heatmap

We can compare scores across different signatures with the `hetmapSignPlot` function. Since each signature has its own method to compute the score then to plot several signatures together the scores are transformed into z-score, individually for each signature. The `whichSign` argument could be set to specify which signatures should be plotted. When it is not stated all signatures are used.

```
heatmapSignPlot(data = ovse)
```

![](data:image/png;base64...)

```
heatmapSignPlot(data = ovse, whichSign = highest_correlated)
```

![](data:image/png;base64...)

Users may also be interested in seeing how signatures are sorted in relation to only one or few of them. In this case, we can pass one or few signatures to the `clusterBySign` argument that will be used to cluster samples.
Furthermore, users can add to the plot external sample annotations or plot the internal signature annotations (“signature”, “topic”, “tumor” or “tissue”).

```
set.seed(21)
heatmapSignPlot(data = ovse, whichSign = highest_correlated,
                clusterBySign = paste0("ConsensusOV_Chen_", c("IMR","DIF","PRO","MES")),
                sampleAnnot = ovse$OV_subtype, signAnnot = "topic")
```

![](data:image/png;base64...)

### 4.4.4 Survival plot

Using the function `survivalSignPlot` we can test the association with survival of a signature. The function needs a data frame with the patient survival time data. `survivalSignPlot` uses a Kaplan-Meier curve to test if patients with high or low values of the signature have differences in survival time. Different cut points of the signature score can be indicated through the argument `cutpoint` to define the two patient groups.

```
mysurvData <- cbind(ovse$os, ovse$status)
rownames(mysurvData) <- rownames(colData(ovse))
head(mysurvData)
```

```
##         [,1] [,2]
## sample1   NA    0
## sample2 1720    1
## sample3  887    1
## sample4  547    1
## sample5  260    0
## sample6 1069    1
```

```
survivalSignPlot(data = ovse, survData = mysurvData,
                 whichSign = "Pyroptosis_Ye", cutpoint = "optimal")
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the ggpubr package.
##   Please report the issue at <https://github.com/kassambara/ggpubr/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

### 4.4.5 Score ridgeline plot

Finally, we can plot ridge lines with one or multiple signatures, also grouping samples by external annotations if needed. Since each signature has its own method to compute the score then to plot several signatures together the scores are transformed into z-score, individually for each signature.

```
ridgelineSignPlot(data = ovse, whichSign = highest_correlated)
```

```
## Picking joint bandwidth of 0.405
```

![](data:image/png;base64...)

```
ridgelineSignPlot(data = ovse, whichSign = highest_correlated,
                  groupByAnnot = ovse$OV_subtype)
```

```
## Picking joint bandwidth of 0.24
```

```
## Warning: Removed 1 row containing non-finite outside the scale range
## (`stat_density_ridges()`).
```

![](data:image/png;base64...)

## 4.5 Other examples

Here, we present the results obtained with other two example datasets; one for single-cell transcriptomics and one for spatial transcriptomics.

### 4.5.1 Single-cell transcriptomics

We report here the results obtained using the single-cell transcriptomics dataset coming from a glioblastoma tissue of Darmanis et al. (GEO ID: GSE84465, Darmanis, S. et al. Single-Cell RNA-Seq Analysis of Infiltrating Neoplastic Cells at the Migrating Front of Human Glioblastoma. Cell Rep 21, 1399–1410 (2017)). We focused on the cells coming from the BT\_S2 patient, that were labeled as immune cells, neoplastic or oligodendrocyte precursor cells (OPC) and that come from both the core and the periphery of the tumor.

We computed all the signatures for “brain” and “pan-tissue” that are available in signifinder running the command `multipleSign` setting `inputType = "rnaseq"` and `tissue = c("brain", "pan-tissue")`. Then, we performed a t-SNE and plotted the signature scores. Here, we can see the ridge plot and the t-SNE colored by some of the signatures computed, all cells or separately for different cell types.

![](data:image/png;base64...)

### 4.5.2 Spatial transcriptomics

We used the spatial transcriptomic dataset “Human Breast Cancer: Ductal Carcinoma In Situ, Invasive Carcinoma (FFPE)”, included in the 10x Genomics Visium Spatial Gene Expression data, from the 10x website (<https://www.10xgenomics.com>). A manual annotation of the tissue area was performed and used to annotate the spots. We computed all the signatures for “breast” and “pan-tissue” cancers available in signifinder running the command `multipleSign` setting `inputType = "rnaseq"` and `tissue = c("breast", "pan-tissue")`. Here, we show the ridge plot and the spatial distribution of scores obtained for the Hipoxia\_Buffa signature.

![](data:image/png;base64...)

# 5 Adding new signatures

Please contact us if you have a gene expression signature that you would like to see added to the `signifinder` package. You can write us an email (stefania.pirrotta@phd.unipd.it) or open an issue in <https://github.com/CaluraLab/signifinder/issues>. The more difficult/custom the implementation, the better, as its inclusion in this package will provide more value for other users in the R/Bioconductor community.

# 6 Session info

Here is the output of sessionInfo() on the system on which this document was compiled.

```
sessionInfo()
```

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] dplyr_1.1.4                 signifinder_1.12.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1
##   [2] BiocIO_1.20.0
##   [3] bitops_1.0-9
##   [4] tibble_3.3.0
##   [5] graph_1.88.0
##   [6] XML_3.99-0.19
##   [7] lifecycle_1.0.4
##   [8] rstatix_0.7.3
##   [9] DGEobj.utils_1.0.6
##  [10] doParallel_1.0.17
##  [11] lattice_0.22-7
##  [12] ensembldb_2.34.0
##  [13] backports_1.5.0
##  [14] magrittr_2.0.4
##  [15] limma_3.66.0
##  [16] sass_0.4.10
##  [17] openair_2.19.0
##  [18] rmarkdown_2.30
##  [19] jquerylib_0.1.4
##  [20] yaml_2.3.10
##  [21] DGEobj_1.1.2
##  [22] cowplot_1.2.0
##  [23] mapproj_1.2.12
##  [24] DBI_1.2.3
##  [25] RColorBrewer_1.1-3
##  [26] lubridate_1.9.4
##  [27] maps_3.4.3
##  [28] abind_1.4-8
##  [29] purrr_1.1.0
##  [30] AnnotationFilter_1.34.0
##  [31] RCurl_1.98-1.17
##  [32] circlize_0.4.16
##  [33] KMsurv_0.1-6
##  [34] irlba_2.3.5.1
##  [35] GSVA_2.4.0
##  [36] annotate_1.88.0
##  [37] commonmark_2.0.0
##  [38] svglite_2.2.2
##  [39] codetools_0.2-20
##  [40] DelayedArray_0.36.0
##  [41] ggtext_0.1.2
##  [42] xml2_1.4.1
##  [43] tidyselect_1.2.1
##  [44] shape_1.4.6.1
##  [45] UCSC.utils_1.6.0
##  [46] farver_2.1.2
##  [47] viridis_0.6.5
##  [48] ScaledMatrix_1.18.0
##  [49] GenomicAlignments_1.46.0
##  [50] jsonlite_2.0.0
##  [51] GetoptLong_1.0.5
##  [52] Formula_1.2-5
##  [53] ggridges_0.5.7
##  [54] survival_3.8-3
##  [55] iterators_1.0.14
##  [56] systemfonts_1.3.1
##  [57] foreach_1.5.2
##  [58] tools_4.5.1
##  [59] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
##  [60] Rcpp_1.1.0
##  [61] glue_1.8.0
##  [62] gridExtra_2.3
##  [63] SparseArray_1.10.0
##  [64] xfun_0.53
##  [65] mgcv_1.9-3
##  [66] GenomeInfoDb_1.46.0
##  [67] HDF5Array_1.38.0
##  [68] withr_3.0.2
##  [69] BiocManager_1.30.26
##  [70] fastmap_1.2.0
##  [71] latticeExtra_0.6-31
##  [72] rhdf5filters_1.22.0
##  [73] litedown_0.7
##  [74] digest_0.6.37
##  [75] rsvd_1.0.5
##  [76] timechange_0.3.0
##  [77] R6_2.6.1
##  [78] textshaping_1.0.4
##  [79] colorspace_2.1-2
##  [80] Cairo_1.7-0
##  [81] markdown_2.0
##  [82] jpeg_0.1-11
##  [83] dichromat_2.0-0.1
##  [84] RSQLite_2.4.3
##  [85] cigarillo_1.0.0
##  [86] h5mread_1.2.0
##  [87] tidyr_1.3.1
##  [88] hexbin_1.28.5
##  [89] data.table_1.17.8
##  [90] rtracklayer_1.70.0
##  [91] httr_1.4.7
##  [92] S4Arrays_1.10.0
##  [93] pkgconfig_2.0.3
##  [94] gtable_0.3.6
##  [95] blob_1.2.4
##  [96] ComplexHeatmap_2.26.0
##  [97] S7_0.2.0
##  [98] SingleCellExperiment_1.32.0
##  [99] XVector_0.50.0
## [100] survMisc_0.5.6
## [101] htmltools_0.5.8.1
## [102] carData_3.0-5
## [103] bookdown_0.45
## [104] GSEABase_1.72.0
## [105] ProtGenerics_1.42.0
## [106] clue_0.3-66
## [107] kableExtra_1.4.0
## [108] scales_1.4.0
## [109] TxDb.Hsapiens.UCSC.hg38.knownGene_3.22.0
## [110] png_0.1-8
## [111] SpatialExperiment_1.20.0
## [112] rstudioapi_0.17.1
## [113] km.ci_0.5-6
## [114] knitr_1.50
## [115] tzdb_0.5.0
## [116] rjson_0.2.23
## [117] nlme_3.1-168
## [118] curl_7.0.0
## [119] org.Hs.eg.db_3.22.0
## [120] zoo_1.8-14
## [121] cachem_1.1.0
## [122] rhdf5_2.54.0
## [123] GlobalOptions_0.1.2
## [124] stringr_1.5.2
## [125] parallel_4.5.1
## [126] AnnotationDbi_1.72.0
## [127] restfulr_0.0.16
## [128] pillar_1.11.1
## [129] grid_4.5.1
## [130] vctrs_0.6.5
## [131] maxstat_0.7-26
## [132] ggpubr_0.6.2
## [133] randomForest_4.7-1.2
## [134] car_3.1-3
## [135] BiocSingular_1.26.0
## [136] beachmat_2.26.0
## [137] xtable_1.8-4
## [138] cluster_2.1.8.1
## [139] evaluate_1.0.5
## [140] tinytex_0.57
## [141] readr_2.1.5
## [142] GenomicFeatures_1.62.0
## [143] magick_2.9.0
## [144] mvtnorm_1.3-3
## [145] cli_3.6.5
## [146] compiler_4.5.1
## [147] Rsamtools_2.26.0
## [148] rlang_1.1.6
## [149] crayon_1.5.3
## [150] ggsignif_0.6.4
## [151] labeling_0.4.3
## [152] survminer_0.5.1
## [153] interp_1.1-6
## [154] stringi_1.8.7
## [155] viridisLite_0.4.2
## [156] deldir_2.0-4
## [157] BiocParallel_1.44.0
## [158] assertthat_0.2.1
## [159] Biostrings_2.78.0
## [160] lazyeval_0.2.2
## [161] Matrix_1.7-4
## [162] hms_1.1.4
## [163] patchwork_1.3.2
## [164] sparseMatrixStats_1.22.0
## [165] consensusOV_1.32.0
## [166] bit64_4.6.0-1
## [167] ggplot2_4.0.0
## [168] Rhdf5lib_1.32.0
## [169] KEGGREST_1.50.0
## [170] statmod_1.5.1
## [171] gridtext_0.1.5
## [172] broom_1.0.10
## [173] exactRankTests_0.8-35
## [174] memoise_2.0.1
## [175] bslib_0.9.0
## [176] bit_4.6.0
```