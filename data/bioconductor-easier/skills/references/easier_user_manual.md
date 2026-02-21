Code

* Show All Code
* Hide All Code

# easier User Manual ![](data:image/png;base64...)

#### Oscar Lapuente-Santana

Computational Biology group, Department of Biomedical Engineering, Eindhoven University of Technology (BME, TU/e)
o.lapuente.santana@tue.nl

#### Federico Marini

Institute of Medical Biostatistics, Epidemiology and Informatics (IMBEI, Mainz)
marinif@uni-mainz.de

#### Arsenij Ustjanzew

Institute of Medical Biostatistics, Epidemiology and Informatics (IMBEI, Mainz)
arsenij.ustjanzew@uni-mainz.de

#### Francesca Finotello

Institute of Bioinformatics, Biocenter Medical University of Innsbruck
francesca.finotello@i-med.ac.at

#### Federica Eduati

Computational Biology group, Department of Biomedical Engineering, Eindhoven University of Technology (BME, TU/e)
f.eduati@tue.nl

#### 2025-10-29

# 1 Introduction

Identification of biomarkers of immune response in the tumor microenvironment (TME) for prediction of patients’ response to immune checkpoint inhibitors is a major challenge in immuno-oncology. Tumors are complex systems, and understanding immune response in the TME requires holistic strategies.

We introduce Estimate Systems Immune Response (EaSIeR) tool, an approach to derive a high-level representation of anti-tumor immune responses by leveraging widely accessible patients’ tumor RNA-sequencing (RNA-seq) data.

## 1.1 EaSIeR approach

RNA-seq data is integrated with different types of biological prior knowledge to extract quantitative descriptors of the TME, including composition of the immune repertoire, and activity of intra- and extra-cellular communications (see table below). By performing this knowledge-guided dimensionality reduction, there is an improvement in the interpretability of the derived features.

Quantitative descriptors of the TME

| Quantitative descriptor | Descriptor conception | Prior knowledge |
| --- | --- | --- |
| Pathway activity | Holland, Szalai, and Saez-Rodriguez (2020); Schubert et al. (2018) | Holland, Szalai, and Saez-Rodriguez (2020); Schubert et al. (2018) |
| Immune cell quantification | Finotello et al. (2019) | Finotello et al. (2019) |
| TF activity | Garcia-Alonso et al. (2019) | Garcia-Alonso et al. (2019) |
| Ligand-Receptor pairs | Lapuente-Santana et al. (2021) | Ramilowski et al. (2015); Barretina et al. (2012) |
| Cell-cell interaction | Lapuente-Santana et al. (2021) | Ramilowski et al. (2015); Barretina et al. (2012) |

Using the data from The Cancer Genome Atlas (TCGA) (Chang et al. 2013), regularized multi-task linear regression was used to identify how the quantitative descriptors can simultaneously predict multiple hallmarks (i.e. published transcriptome-based predictors) of anti-cancer immune response (see table below). Here, the regularization is applied to select features that are relevant for all tasks.

Hallmarks of anti-cancer immune responses

| Hallmark of the immune response | Original study |
| --- | --- |
| Cytolytic activity (CYT) | Rooney et al. (2015) |
| Roh immune score (Roh\_IS) | Roh et al. (2017) |
| Chemokine signature (chemokines) | Messina et al. (2012) |
| Davoli immune signature (Davoli\_IS) | Davoli et al. (2017) |
| IFNy signature (IFNy) | McClanahan (2017) |
| Expanded immune signature (Ayers\_expIS) | McClanahan (2017) |
| T-cell inflamed signature (Tcell\_inflamed) | McClanahan (2017) |
| Repressed immune resistance (RIR) | Jerby-Arnon et al. (2018) |
| Tertiary lymphoid structures signature (TLS) | Cabrita et al. (2020) |
| Immuno-predictive score (IMPRES) | Auslander et al. (2018) |
| Microsatellite instability status | Fu et al. (2019) |

Cancer-specific models were learned and used to identify interpretable cancer-specific systems biomarkers of immune response. These models are available through `easierData` package and can be accessed using the `get_opt_models()` function. Model biomarkers have been experimentally validated in the literature and the performance of EaSIeR predictions has been validated using independent datasets from four different cancer types with patients treated with anti-PD1 or anti-PD-L1 therapy.

For more detailed information, please refer to our original work: Lapuente-Santana et al. “Interpretable systems biomarkers predict response to immune-checkpoint inhibitors”. Patterns, 2021 [doi:10.1016/j.patter.2021.100293](https://doi.org/10.1016/j.patter.2021.100293).

## 1.2 EaSIeR tool

This vignette describes how to use the easier package for a pleasant onboarding experience around the EaSIeR approach. By providing just the patients’ bulk RNA-seq data as input, the EaSIeR tool allows you to:

* Predict biomarker-based immune response
* Identify system biomarkers of immune response

![](data:image/png;base64...)

# 2 Getting started

Starting R, this package can be installed as follows:

```
BiocManager::install("easier")
# to install also the dependencies used in the vignettes and in the examples:
BiocManager::install("easier", dependencies = TRUE)
# to download and install the development version from GitHub, you can use
BiocManager::install("olapuentesantana/easier")
```

Once installed, the package can be loaded and attached to your current workspace as follows:

```
library("easier")
```

In order to use `easier` in your workflow, bulk-tumor RNA-seq data is required as input (when available, patients’ response to immunotherapy can be additionally provided):

* `RNA_counts`, a `data.frame` containing raw counts values (with HGNC gene symbols as row names and samples identifiers as column names).
* `RNA_tpm`, a `data.frame` containing TPM values (with HGNC gene symbols as row names and samples identifiers as column names).
* `real_patient_response`, a character `vector` containing clinical patients’ response to immunotherapy (with non-responders labeled as NR and responders as R).

# 3 Use case for `easier`: Bladder cancer patients (Mariathasan et al. 2018)

In this section, we illustrate the main features of `easier` on a publicly available bladder cancer dataset from Mariathasan et al. “TGF-B attenuates tumour response to PD-L1 blockade by contributing to exclusion of T cells”, published in Nature, 2018 [doi:10.1038/nature25501](https://doi.org/10.1038/nature25501). The processed data is available via [`IMvigor210CoreBiologies`](http://research-pub.gene.com/IMvigor210CoreBiologies/) package under the CC-BY license.

We will be using a subset of this data as exemplary dataset, made available via `easierData`. This includes RNA-seq data (count and TPM expression values), information on tumor mutational burden (TMB) and response to ICB therapy from 192 patients. 25 patients with complete response (CR) were classified as responders (R) and 167 patients with progressive disease (PD) as non-responders.

In the following chunk, we load the additional packages that will be required throughout the vignette.

```
suppressPackageStartupMessages({
  library("easierData")
  library("SummarizedExperiment")
})
```

## 3.1 Load data from Mariathasan cohort

For this example we will use gene expression data (counts and tpm values). Other variables include patient best overall response (BOR) to anti-PD-L1 therapy, tumor mutational burden (TMB) and the cancer type the cohort belongs to.

```
dataset_mariathasan <- get_Mariathasan2018_PDL1_treatment()
#> Retrieving Mariathasan2018_PDL1_treatment dataset...
#> see ?easierData and browseVignettes('easierData') for documentation
#> loading from cache

# patient response
patient_ICBresponse <- colData(dataset_mariathasan)[["BOR"]]
names(patient_ICBresponse) <- colData(dataset_mariathasan)[["pat_id"]]

# tumor mutational burden
TMB <- colData(dataset_mariathasan)[["TMB"]]
names(TMB) <- colData(dataset_mariathasan)[["pat_id"]]

# cohort cancer type
cancer_type <- metadata(dataset_mariathasan)[["cancertype"]]

# gene expression data
RNA_counts <- assays(dataset_mariathasan)[["counts"]]
RNA_tpm <- assays(dataset_mariathasan)[["tpm"]]

# Select a subset of patients to reduce vignette building time.
set.seed(1234)
pat_subset <- sample(names(patient_ICBresponse), size = 30)
patient_ICBresponse <- patient_ICBresponse[pat_subset]
TMB <- TMB[pat_subset]
RNA_counts <- RNA_counts[, pat_subset]
RNA_tpm <- RNA_tpm[, pat_subset]

# Some genes are causing issues due to approved symbols matching more than one gene
genes_info <- easier:::reannotate_genes(cur_genes = rownames(RNA_tpm))

## Remove non-approved symbols
non_na <- !is.na(genes_info$new_names)
RNA_tpm <- RNA_tpm[non_na, ]
genes_info <- genes_info[non_na, ]

## Remove entries that are withdrawn
RNA_tpm <- RNA_tpm[-which(genes_info$new_names == "entry withdrawn"), ]
genes_info <- genes_info[-which(genes_info$new_names == "entry withdrawn"), ]

## Identify duplicated new genes
newnames_dup <- unique(genes_info$new_names[duplicated(genes_info$new_names)])
newnames_dup_ind <- do.call(c, lapply(newnames_dup, function(X) which(genes_info$new_names == X)))
newnames_dup <- genes_info$new_names[newnames_dup_ind]

## Retrieve data for duplicated genes
tmp <- RNA_tpm[genes_info$old_names[genes_info$new_names %in% newnames_dup],]

## Remove data for duplicated genes
RNA_tpm <- RNA_tpm[-which(rownames(RNA_tpm) %in% rownames(tmp)),]

## Aggregate data of duplicated genes
dup_genes <- genes_info$new_names[which(genes_info$new_names %in% newnames_dup)]
names(dup_genes) <- rownames(tmp)
if (anyDuplicated(newnames_dup)){
  tmp2 <- stats::aggregate(tmp, by = list(dup_genes), FUN = "mean")
  rownames(tmp2) <- tmp2$Group.1
  tmp2$Group.1 <- NULL
}

# Put data together
RNA_tpm <- rbind(RNA_tpm, tmp2)
```

## 3.2 Compute hallmarks of immune response

Multiple hallmarks (i.e. published transcriptome-based predictors) of the immune response can also be computed using TPM data from RNA-seq. By default, the following scores of the immune response will be computed: cytolytic activity (CYT) (Rooney et al. 2015), Roh immune score (Roh\_IS) (Roh et al. 2017), chemokine signature (chemokines) (Messina et al. 2012), Davoli immune signature (Davoli\_IS) (Davoli et al. 2017), IFNy signature (IFNy) (McClanahan 2017), expanded immune signature (Ayers\_expIS) (McClanahan 2017), T-cell inflamed signature (Tcell\_inflamed) (McClanahan 2017), immune resistance program (RIR: resF\_down, resF\_up, resF) (Jerby-Arnon et al. 2018) and tertiary lymphoid structures signature (TLS) (Cabrita et al. 2020). This selection can be customized by editing the `selected_scores` option.

```
hallmarks_of_immune_response <- c("CYT", "Roh_IS", "chemokines", "Davoli_IS", "IFNy", "Ayers_expIS", "Tcell_inflamed", "RIR", "TLS")
immune_response_scores <- compute_scores_immune_response(RNA_tpm = RNA_tpm,
                                                         selected_scores = hallmarks_of_immune_response)
#> Following scores can be computed:
#> CYT, TLS, IFNy, Ayers_expIS, Tcell_inflamed, Roh_IS, Davoli_IS, chemokines, RIR
#> CYT score:
#> TLS score:
#> IFNy score:
#> Ayers_expIS score:
#> Tcell_inflamed score:
#> Roh_IS score:
#> Davoli_IS score:
#> chemokines score:
#> RIR score:
#> Differenty named or missing signature genes :
#> XAGE1D
#> C17orf76-AS1
#> MKI67IP
#> RPS17L
#> CTSL1
#> LOC100126784
#> LOC100506190
#> NSG1
#> C20orf112
#> FLJ43663
#> TMEM66
#> FLJ39051
#> LOC100506714
#> LOC100507463
#> Perfomed gene re-annotation to match signature genes
head(immune_response_scores)
#>                       CYT        TLS     IFNy Ayers_expIS Tcell_inflamed
#> SAM23095936e611  1.854240   4.167253 3.419660    3.171988     -3.5591198
#> SAM3330c03fdf00 31.782584 265.759171 6.738235    6.979761     -0.2750762
#> SAM8e469834acc1  6.399774  12.206693 4.748116    4.238499     -2.5181318
#> SAMeb29625f76a5  6.977461   8.648444 5.037934    4.113286     -2.6028720
#> SAMd86389d0d768  1.853023   6.504487 3.441488    2.845997     -3.5550647
#> SAMa321770ac31c  7.518455   4.171804 5.708758    4.386140     -2.2920024
#>                    Roh_IS Davoli_IS chemokines    resF_up  resF_down       resF
#> SAM23095936e611  6.186174 0.1822660 -3.7334420  0.7493652 -1.1423416  1.8917067
#> SAM3330c03fdf00 54.319422 0.9359606  3.6555005 -0.1591575  0.4031406 -0.5622982
#> SAM8e469834acc1 12.387979 0.4236453 -1.0975826 -0.5361122 -0.1691564 -0.3669558
#> SAMeb29625f76a5 14.933200 0.4827586 -1.8486582  0.0781382 -0.5099630  0.5881012
#> SAMd86389d0d768  5.534648 0.1083744 -4.1499736  0.4914592 -0.4957330  0.9871922
#> SAMa321770ac31c 15.062774 0.4827586 -0.4492079  0.4909176 -0.1353869  0.6263045
```

## 3.3 Compute quantitative descriptors of the TME

We are going to use the bulk RNA-seq data to derive, for each patient, the five quantitative descriptors of the TME described above.

By applying quanTIseq (Finotello et al. 2019) method to TPM data from RNA-seq, the quantification of different cell fractions can be done as follows:

```
cell_fractions <- compute_cell_fractions(RNA_tpm = RNA_tpm)
#>
#> Running quanTIseq deconvolution module
#> Gene expression normalization and re-annotation (arrays: FALSE)
#> Removing 17 noisy genes
#> Removing 15 genes with high expression in tumors
#> Signature genes found in data set: 137/138 (99.28%)
#> Mixture deconvolution (method: lsei)
#> Deconvolution successful!
#> Cell fractions computed!
head(cell_fractions)
#>                           B          M1         M2     Monocyte Neutrophil
#> SAM23095936e611 0.002622049 0.002697443 0.02809877 0.0000000000 0.07560465
#> SAM3330c03fdf00 0.122762088 0.014371755 0.05558316 0.0008528775 0.03902438
#> SAM8e469834acc1 0.010344721 0.013266287 0.04361726 0.0000000000 0.05951780
#> SAMeb29625f76a5 0.004529419 0.010251534 0.01727304 0.0000000000 0.05126536
#> SAMd86389d0d768 0.011468905 0.001838885 0.03588328 0.0000000000 0.05027106
#> SAMa321770ac31c 0.001914312 0.008785227 0.04209719 0.0000000000 0.02403584
#>                          NK       CD4 T       CD8+ T        Treg DC     Other
#> SAM23095936e611 0.002103237 0.015504570 9.981021e-05 0.015504570  0 0.8732695
#> SAM3330c03fdf00 0.007791196 0.166380844 2.304104e-02 0.040470367  0 0.5701927
#> SAM8e469834acc1 0.004330129 0.019275584 3.347685e-03 0.019275584  0 0.8463005
#> SAMeb29625f76a5 0.003060087 0.015214079 1.611302e-03 0.015214079  0 0.8967952
#> SAMd86389d0d768 0.002514705 0.014637134 3.742196e-04 0.014637134  0 0.8830118
#> SAMa321770ac31c 0.004303525 0.009693118 7.278737e-03 0.007049763  0 0.9018921
```

By applying PROGENy (Holland, Szalai, and Saez-Rodriguez 2020; Schubert et al. 2018) method to count data from RNA-seq, the activity of 14 signaling pathways can be inferred as in the chunk below.

```
pathway_activities <- compute_pathway_activity(RNA_counts = RNA_counts,
                                               remove_sig_genes_immune_response = TRUE)
#> Removing signature genes of hallmarks of immune response
#> Gene counts normalization with DESeq2:
#> gene-wise dispersion estimates
#> mean-dispersion relationship
#> final dispersion estimates
#> Number of genes used per pathway to compute progeny scores:
#> Androgen: 95 (95%)
#> EGFR: 94 (94%)
#> Estrogen: 97 (97%)
#> Hypoxia: 97 (97%)
#> JAK-STAT: 83 (83%)
#> MAPK: 92 (92%)
#> NFkB: 88 (88%)
#> p53: 95 (95%)
#> PI3K: 89 (89%)
#> TGFb: 96 (96%)
#> TNFa: 90 (90%)
#> Trail: 93 (93%)
#> VEGF: 89 (89%)
#> WNT: 97 (97%)
#> Pathway signature genes found in data set: 1207/1301 (92.8%)
#>
#> Pathway activity scores computed!
head(pathway_activities)
#>                 Androgen      EGFR Estrogen  Hypoxia JAK-STAT     MAPK     NFkB
#> SAM23095936e611 3413.109 -138.9127 2382.863 7298.016 5687.325 1277.133 5394.316
#> SAM3330c03fdf00 3491.213 -241.4348 2344.289 6411.686 7166.311 1182.673 5928.623
#> SAM8e469834acc1 3489.019 -193.1898 2438.082 7016.232 6369.837 1160.688 5637.852
#> SAMeb29625f76a5 3432.605 -183.9006 2466.230 7419.429 6175.766 1237.699 5419.877
#> SAMd86389d0d768 3542.806 -265.9723 2259.767 7225.572 5848.535 1041.126 5113.226
#> SAMa321770ac31c 3616.811 -159.3274 2326.090 7141.462 6631.886 1185.325 5724.962
#>                      p53      PI3K     TGFb     TNFa     Trail      VEGF
#> SAM23095936e611 4844.378 -2930.195 2842.307 5874.151  87.59961 -310.9487
#> SAM3330c03fdf00 4348.616 -3011.188 2697.512 5998.852 178.44521 -523.8521
#> SAM8e469834acc1 4839.137 -2969.504 3139.592 6004.593 121.14881 -359.5669
#> SAMeb29625f76a5 4729.233 -2974.656 2868.690 5904.540  97.02514 -414.0791
#> SAMd86389d0d768 5144.473 -2957.193 2717.031 5324.415  88.08302 -317.4356
#> SAMa321770ac31c 4662.701 -2950.958 2735.689 6044.925 101.74421 -375.2041
#>                      WNT
#> SAM23095936e611 705.8786
#> SAM3330c03fdf00 690.0206
#> SAM8e469834acc1 697.3891
#> SAMeb29625f76a5 682.4761
#> SAMd86389d0d768 696.3715
#> SAMa321770ac31c 636.9830
```

The call above infers pathway activity as a linear transformation of gene expression data. Since some pathway signature genes were also used to compute scores of immune response (output variable in EaSIeR model). With `remove_sig_genes_immune_response` set to `TRUE` (default), the overlapping genes are removed from the pathway signature genes used to infer pathway activities.

By applying DoRothEA (Garcia-Alonso et al. 2019) method to TPM data from RNA-seq, the activity of 118 TFs can be inferred as follows:

```
tf_activities <- compute_TF_activity(RNA_tpm = RNA_tpm)
#> Regulated transcripts found in data set: 3084/3254 (94.8%)
#> TF activity computed!
head(tf_activities[,1:5])
#>                         AR       ARNTL       ATF1      ATF2      ATF4
#> SAM23095936e611  1.4802637 -0.94913446 0.39925809 1.0661678 -1.572764
#> SAM3330c03fdf00 -0.9801301 -0.87559912 0.35345722 0.3730774 -1.471752
#> SAM8e469834acc1  0.5658369  0.08005012 0.05349354 1.0466755 -1.449756
#> SAMeb29625f76a5  1.9470542 -0.46419786 0.59377459 1.2236377 -1.104496
#> SAMd86389d0d768  1.4410883 -0.54640228 0.15987529 0.4065935 -1.401964
#> SAMa321770ac31c  0.5863973 -0.31084067 0.32792016 0.1739320 -1.267880
```

Using derived cancer-specific inter-cellular networks, the quantification of 867 ligand-receptor pairs can be done as in the chunk below.

More detailed information on how these networks were obtained can be found in the experimental procedures section from our original work (Lapuente-Santana et al. 2021).

```
lrpair_weights <- compute_LR_pairs(RNA_tpm = RNA_tpm,
                                   cancer_type = "pancan")
#> LR signature genes found in data set: 629/644 (97.7%)
#> Ligand-Receptor pair weights computed
head(lrpair_weights[,1:5])
#>                 A2M_APP_CALR_LRPAP1_PSAP_SERPING1_LRP1 ADAM10_AXL
#> SAM23095936e611                               7.746610   4.402992
#> SAM3330c03fdf00                               6.153378   4.377154
#> SAM8e469834acc1                               7.993705   5.621298
#> SAMeb29625f76a5                               7.134311   4.299523
#> SAMd86389d0d768                               6.579407   3.260435
#> SAMa321770ac31c                               6.740991   3.213153
#>                 ADAM10_EFNA1_EPHA3 ADAM12_ITGA9 ADAM12_ITGB1_SDC4
#> SAM23095936e611           2.612012     3.229963          3.229963
#> SAM3330c03fdf00           4.385768     3.990142          3.990142
#> SAM8e469834acc1           4.721780     4.323715          4.323715
#> SAMeb29625f76a5           2.081069     2.946964          2.946964
#> SAMd86389d0d768           2.252113     2.605315          2.605315
#> SAMa321770ac31c           2.108481     3.442606          4.327418
```

Via `cancer_type`, a cancer-specific ligand-receptor pairs network can be chosen. With `cancer_type` set to `pancan`, a pan-cancer network will be used and this is based on the union of all ligand-receptor pairs present across the 18 cancer-specific networks.

Using the ligand-receptor weights as input, 169 cell-cell interaction scores can be derived as in the chunk below.

```
ccpair_scores <- compute_CC_pairs(lrpairs = lrpair_weights,
                                  cancer_type = "pancan")
#> CC pairs computed
head(ccpair_scores[,1:5])
#>                 Adipocytes_Adipocytes Adipocytes_DendriticCells
#> SAM23095936e611              8.509797                  7.363179
#> SAM3330c03fdf00              8.766845                  8.314185
#> SAM8e469834acc1              9.070111                  7.865462
#> SAMeb29625f76a5              8.589783                  7.867214
#> SAMd86389d0d768              7.997064                  7.161020
#> SAMa321770ac31c              8.233812                  7.553312
#>                 Adipocytes_Endothelialcells Adipocytes_Fibroblasts
#> SAM23095936e611                    8.426370               8.336850
#> SAM3330c03fdf00                    8.424617               8.364922
#> SAM8e469834acc1                    9.115597               8.747848
#> SAMeb29625f76a5                    8.588126               8.396068
#> SAMd86389d0d768                    7.936900               7.705764
#> SAMa321770ac31c                    8.037850               7.800692
#>                 Adipocytes_Macrophages
#> SAM23095936e611               7.917801
#> SAM3330c03fdf00               8.261575
#> SAM8e469834acc1               8.357799
#> SAMeb29625f76a5               8.057757
#> SAMd86389d0d768               7.155412
#> SAMa321770ac31c               7.622727
```

Again, `cancer_type` is set to `pancan` (default). The same `cancer_type` network used to quantify ligand-receptor pairs should be designated here.

## 3.4 Obtain patients’ predictions of immune response

Now we use the quantitative descriptors computed previously as input features to predict anti-tumor immune responses based on the model parameters defined during training. The output of `predict_immune_response` returns predictions of patients’ immune response for each quantitative descriptor. Because models were built in a cancer-type-specific fashion, the user is required to indicate which cancer-specific model should be used for predicting patients’ immune response, which can be done via the `cancer_type` argument.

The `cancer_type` provided should match one of the cancer-specific models available. These are the following: bladder urothelial carcinoma (`BLCA`), brest invasive carcinoma (`BRCA`), cervical and endocervical cancer (`CESC`), colorectal adenocarcinoma (`CRC`), glioblastoma multiforme (`GBM`), head and neck squamous cell carcinoma (`HNSC`), kidney renal clear cell carcinoma (`KIRC`), kidney renal papillary cell carcinoma (`KIRP`), liver hepatocellular carcinoma (`LIHC`), lung adenocarcinoma (`LUAD`), lung squamous cell carcinoma (`LUSC`), non-small-cell lung carcinoma (`NSCLC` [`LUAD` + `LUSC`]), ovarian serous cystadenocarcionma (`OV`), pancreatic adenocarcionma (`PAAD`), prostate adenocarcinoma (`PRAD`), skin cutaneous melanoma (`SKCM`), stomach adenocarcinoma (`STAD`), thyroid carcinoma (`THCA`), uterine corpus endometrial carcinoma (`UCEC`).

The optimized models can be retrieved from `easierData` package using the function `get_opt_models()`.

```
predictions <- predict_immune_response(pathways = pathway_activities,
                                       immunecells = cell_fractions,
                                       tfs = tf_activities,
                                       lrpairs = lrpair_weights,
                                       ccpairs = ccpair_scores,
                                       cancer_type = cancer_type,
                                       verbose = TRUE)
```

Once we obtained patients’ predicted immune response, two different scenarios should be considered in which:

-`patient_response` is **known** and therefore the accuracy of `easier` predictions can be evaluated.

-`patient_response` is **unknown** and no assessments can be carried out.

In this use case, patients’ clinical response to PD-L1 therapy is available from Mariathasan cohort, thus we can move forward to assess the performance of the predictions.

## 3.5 Evaluate easier predictions using patients’ immunotherapy response

Assessment of patients’ response to immunotherapy treatment can be done via `assess_immune_response` function, which informs about the accuracy of easier predictions on patients’ response to ICB therapy.

The option `patient_response` should be provided with a character string containing patients’ clinical response (where non-responders are labeled as NR and responders as R). Importantly, this aspect should be handled by the user.

This function uses patients’ TPM values (`RNA_tpm`) as input for `compute_scores_immune_response` in order to compare easier predictions with those from published scores of immune response. The user can choose the scores to be computed via `select_gold_standard`, by default all scores are computed.

If patients’ tumor mutational burden (TMB) is available, this can also be provided via `TMB_values` and used as surrogate of patients’ immunotherapy response for comparison.

Since both immune response and TMB are essential for an effective immunotherapy response, we decided to conceptualize this in our predictions by either penalizing or weighting differently our scores in high- and low-TMB patients. If `easier_with_TMB` is set to `weighted_average`, a weighted average of both easier and TMB score will be used, if instead `easier_with_TMB` is set to `penalized_score`, patient’s easier scores will penalized depending on their TMB category.

These two strategies to combine immune response and TMB require the definition of a certain weight or penalty beforehand (`weight_penalty`). The default weight or penalty is 0.5.

```
output_eval_with_resp <- assess_immune_response(predictions_immune_response = predictions,
                                                patient_response = patient_ICBresponse,
                                                RNA_tpm = RNA_tpm,
                                                TMB_values = TMB,
                                                easier_with_TMB = "weighted_average",
                                                weight_penalty = 0.5)
#> Warning in assess_immune_response(predictions_immune_response = predictions, :
#> TMB data contains NA values, excluding those patients..
#> Following scores can be computed:
#> CYT, TLS, IFNy, Ayers_expIS, Tcell_inflamed, Roh_IS, Davoli_IS, chemokines, RIR
#> CYT score:
#> TLS score:
#> IFNy score:
#> Ayers_expIS score:
#> Tcell_inflamed score:
#> Roh_IS score:
#> Davoli_IS score:
#> chemokines score:
#> RIR score:
#> Differenty named or missing signature genes :
#> XAGE1D
#> C17orf76-AS1
#> MKI67IP
#> RPS17L
#> CTSL1
#> LOC100126784
#> LOC100506190
#> NSG1
#> C20orf112
#> FLJ43663
#> TMEM66
#> FLJ39051
#> LOC100506714
#> LOC100507463
#> Perfomed gene re-annotation to match signature genes
#> Scores of immune response computed!
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

Top figure. Area under the curve (AUC) values of patients’ predictions based on quantitative descriptors of the TME, an ensemble descriptor based on average of individual descriptors, and the computed scores of immune response (gold standard). Bar plot represent the average AUC across tasks and error bars describe the corresponding standard deviation.

Bottom figure. ROC curves were computed as the average of the ROC curves obtained for each score of immune response.

`output_evaluation_with_resp` stores the plots from above, and they can be inspected in R as follows:

```
# inspect output
output_eval_with_resp[[1]]
output_eval_with_resp[[2]]
output_eval_with_resp[[3]]
```

## 3.6 What if I have an immunotherapy dataset where patients’ response is not available?

This is a usual case where we might have a cancer dataset with bulk RNA-seq data but lack information about patients’ response to immunotherapy.

In this likely scenario, an score of likelihood of immune response can be assigned to each patient by omitting the argument `patient_response` within the function `assess_immune_response`.

```
output_eval_no_resp <- assess_immune_response(predictions_immune_response = predictions,
                                              TMB_values = TMB,
                                              easier_with_TMB = "weighted_average",
                                              weight_penalty = 0.5)
#> Warning in assess_immune_response(predictions_immune_response = predictions, :
#> Gene expression (TPM) data is missing, skipping computation of scores of immune
#> response..
#> Warning in assess_immune_response(predictions_immune_response = predictions, :
#> TMB data contains NA values, excluding those patients..
#> Scoring patients' as real response is not provided
```

![](data:image/png;base64...)

```
#> Using patient as id variables
```

![](data:image/png;base64...)

Top figure. Boxplot of patients’ easier score showing its distribution across the 10 different tasks.

Bottom figure. Scatterplot of patients’ prediction when combining easier score with tumor mutational burden showing its distribution across the 10 different tasks.

`output_evaluation_no_resp` stores the plots from above, and they can be inspected in R as follows:

```
# inspect output
output_eval_no_resp[[1]]
output_eval_no_resp[[2]]
```

### 3.6.1 Retrieve easier scores of immune response

We can further retrieve the easier score and also, the refined scores obtained by integrating easier score and TMB via `retrieve_easier_score`.

```
easier_derived_scores <- retrieve_easier_score(predictions_immune_response = predictions,
                                               TMB_values = TMB,
                                               easier_with_TMB = c("weighted_average",
                                                                   "penalized_score"),
                                               weight_penalty = 0.5)
#> Warning in retrieve_easier_score(predictions_immune_response = predictions, :
#> TMB data contains NA values, excluding those patients..

head(easier_derived_scores)
#>                 easier_score w_avg_score  pen_score
#> SAM23095936e611   -0.5169043  0.01743203 -1.0169043
#> SAM3330c03fdf00    1.6495030  0.25000000  1.1495030
#> SAM8e469834acc1   -0.1426452  0.18260946 -0.1426452
#> SAMeb29625f76a5   -0.2457890  0.04653677 -0.7457890
#> SAMa321770ac31c   -0.1535489  0.30643892  0.3464511
#> SAM2624229effe8    0.1206929  0.21087931  0.1206929
```

## 3.7 Interpret response to immunotherapy through systems biomarkers

Identifying mechanisms used by patients’ tumors to resist or succumb to ICB treatment is of paramount importance. Via `explore_biomarkers`, we can visualize stunning biomarkers of immune response and shed light into possible mechanisms responsible for the patients’ response to treatment.

The option `patient_label` allows to make a two-level comparison by providing a character string containing the label of each patient, for instance, patients’ clinical response (where non-responders are labeled as NR and responders as R).

In order to leverage the cancer-specific biomarker weights inferred from model training, you need to specify again which `cancer_type` the bulk RNA-seq data belongs to. As before, the selected `cancer_type` should be included in the list described above.

```
output_biomarkers <- explore_biomarkers(pathways = pathway_activities,
                                        immunecells = cell_fractions,
                                        tfs = tf_activities,
                                        lrpairs = lrpair_weights,
                                        ccpairs = ccpair_scores,
                                        cancer_type = cancer_type,
                                        patient_label = patient_ICBresponse)
#> Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the easier package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the easier package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: Removed 2 rows containing non-finite outside the scale range
#> (`stat_boxplot()`).
#> Warning: Removed 2 rows containing missing values or values outside the scale range
#> (`geom_point()`).
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

The output of `explore_biomarkers` returns, for each quantitative descriptor, feature’s z-score values comparing responders (R) and non-responders (NR) patients with the corresponding feature’s model weights (only top 15 biomarkers are shown for tfs, lrpairs and ccpairs descriptors).

Additionally, a volcano plot integrating systems biomarkers from all quantitative descriptors comparing NR and R patients (two-sided Wilcoxon rank-sum test). Significant biomarkers (p < 0.05) are shown in blue. Biomarkers are drawn according to their corresponding sign (shape) and weight (size) obtained during model training. Labels are reported for the top 15 biomarkers (based on the association with the tasks) that are significantly different between R and NR.

`output_biomarkers` stores the plots from above, and they can be inspected in R as follows:

```
# inspect output
output_biomarkers[[1]]
output_biomarkers[[2]]
output_biomarkers[[3]]
output_biomarkers[[4]]
output_biomarkers[[5]]
output_biomarkers[[6]]
```

# Session info

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
#>  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [5] IRanges_2.44.0              S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0         generics_0.1.4
#>  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [11] easierData_1.15.0           easier_1.16.0
#> [13] knitr_1.50
#>
#> loaded via a namespace (and not attached):
#>   [1] libcoin_1.0-10        RColorBrewer_1.1-3    limSolve_2.0.1
#>   [4] jsonlite_2.0.0        magrittr_2.0.4        TH.data_1.1-4
#>   [7] modeltools_0.2-24     farver_2.1.2          rmarkdown_2.30
#>  [10] vctrs_0.6.5           ROCR_1.0-11           memoise_2.0.1
#>  [13] rstatix_0.7.3         htmltools_0.5.8.1     S4Arrays_1.10.0
#>  [16] AnnotationHub_4.0.0   curl_7.0.0            decoupleR_2.16.0
#>  [19] broom_1.0.10          SparseArray_1.10.0    Formula_1.2-5
#>  [22] sass_0.4.10           parallelly_1.45.1     KernSmooth_2.23-26
#>  [25] quantiseqr_1.18.0     bslib_0.9.0           htmlwidgets_1.6.4
#>  [28] plyr_1.8.9            sandwich_3.1-1        httr2_1.2.1
#>  [31] plotly_4.11.0         zoo_1.8-14            cachem_1.1.0
#>  [34] lifecycle_1.0.4       pkgconfig_2.0.3       Matrix_1.7-4
#>  [37] R6_2.6.1              fastmap_1.2.0         digest_0.6.37
#>  [40] AnnotationDbi_1.72.0  DESeq2_1.50.0         viper_1.44.0
#>  [43] ExperimentHub_3.0.0   RSQLite_2.4.3         ggpubr_0.6.2
#>  [46] labeling_0.4.3        filelock_1.0.3        httr_1.4.7
#>  [49] abind_1.4-8           compiler_4.5.1        proxy_0.4-27
#>  [52] bit64_4.6.0-1         withr_3.0.2           S7_0.2.0
#>  [55] backports_1.5.0       BiocParallel_1.44.0   carData_3.0-5
#>  [58] DBI_1.2.3             ggsignif_0.6.4        MASS_7.3-65
#>  [61] rappdirs_0.3.3        DelayedArray_0.36.0   tools_4.5.1
#>  [64] progeny_1.32.0        glue_1.8.0            quadprog_1.5-8
#>  [67] nlme_3.1-168          grid_4.5.1            reshape2_1.4.4
#>  [70] lpSolve_5.6.23        gtable_0.3.6          bcellViper_1.45.0
#>  [73] class_7.3-23          preprocessCore_1.72.0 tidyr_1.3.1
#>  [76] data.table_1.17.8     car_3.1-3             coin_1.4-3
#>  [79] XVector_0.50.0        ggrepel_0.9.6         BiocVersion_3.22.0
#>  [82] pillar_1.11.1         stringr_1.5.2         splines_4.5.1
#>  [85] dplyr_1.1.4           BiocFileCache_3.0.0   lattice_0.22-7
#>  [88] survival_3.8-3        bit_4.6.0             tidyselect_1.2.1
#>  [91] locfit_1.5-9.12       Biostrings_2.78.0     gridExtra_2.3
#>  [94] xfun_0.53             mixtools_2.0.0.1      stringi_1.8.7
#>  [97] lazyeval_0.2.2        yaml_2.3.10           evaluate_1.0.5
#> [100] codetools_0.2-20      kernlab_0.9-33        dorothea_1.21.0
#> [103] tibble_3.3.0          BiocManager_1.30.26   cli_3.6.5
#> [106] segmented_2.1-4       jquerylib_0.1.4       dichromat_2.0-0.1
#> [109] Rcpp_1.1.0            dbplyr_2.5.1          png_0.1-8
#> [112] parallel_4.5.1        ggplot2_4.0.0         blob_1.2.4
#> [115] viridisLite_0.4.2     mvtnorm_1.3-3         scales_1.4.0
#> [118] e1071_1.7-16          purrr_1.1.0           crayon_1.5.3
#> [121] rlang_1.1.6           cowplot_1.2.0         KEGGREST_1.50.0
#> [124] multcomp_1.4-29
```

# References

Auslander, Noam, Gao Zhang, Joo Sang Lee, Dennie T. Frederick, Benchun Miao, Tabea Moll, Tian Tian, et al. 2018. “Robust Prediction of Response to Immune Checkpoint Blockade Therapy in Metastatic Melanoma.” *Nature Medicine* 24 (10): 1545–9. <https://doi.org/10.1038/s41591-018-0157-9>.

Barretina, Jordi, Giordano Caponigro, Nicolas Stransky, Kavitha Venkatesan, Adam A. Margolin, Sungjoon Kim, Christopher J. Wilson, et al. 2012. “The Cancer Cell Line Encyclopedia Enables Predictive Modelling of Anticancer Drug Sensitivity.” *Nature* 483 (7391): 603–7. <https://doi.org/10.1038/nature11003>.

Cabrita, Rita, Martin Lauss, Adriana Sanna, Marco Donia, Mathilde Skaarup Larsen, Shamik Mitra, Iva Johansson, et al. 2020. “Tertiary Lymphoid Structures Improve Immunotherapy and Survival in Melanoma.” *Nature* 577 (7791): 561–65. <https://doi.org/10.1038/s41586-019-1914-8>.

Chang, Kyle, Chad J. Creighton, Caleb Davis, Lawrence Donehower, Jennifer Drummond, David Wheeler, Adrian Ally, et al. 2013. “The Cancer Genome Atlas Pan-Cancer Analysis Project.” *Nature Genetics* 45 (10): 1113–20. <https://doi.org/10.1038/ng.2764>.

Davoli, Teresa, Hajime Uno, Eric C. Wooten, and Stephen J. Elledge. 2017. “Tumor Aneuploidy Correlates with Markers of Immune Evasion and with Reduced Response to Immunotherapy.” *Science* 355 (6322). <https://doi.org/10.1126/science.aaf8399>.

Finotello, Francesca, Clemens Mayer, Christina Plattner, Gerhard Laschober, Dietmar Rieder, Hubert Hackl, Anne Krogsdam, et al. 2019. “Molecular and Pharmacological Modulators of the Tumor Immune Contexture Revealed by Deconvolution of Rna-Seq Data.” *Genome Medicine* 11 (1): 34. <https://doi.org/10.1186/s13073-019-0638-6>.

Fu, Yelin, Lishuang Qi, Wenbing Guo, Liangliang Jin, Kai Song, Tianyi You, Shuobo Zhang, Yunyan Gu, Wenyuan Zhao, and Zheng Guo. 2019. “A Qualitative Transcriptional Signature for Predicting Microsatellite Instability Status of Right-Sided Colon Cancer.” *BMC Genomics* 20 (1): 769. <https://doi.org/10.1186/s12864-019-6129-8>.

Garcia-Alonso, Luz, Christian H. Holland, Mahmoud M. Ibrahim, Denes Turei, and Julio Saez-Rodriguez. 2019. “Benchmark and Integration of Resources for the Estimation of Human Transcription Factor Activities.” *Genome Research* 29 (8): 1363–75. <https://doi.org/10.1101/gr.240663.118>.

Holland, Christian H., Bence Szalai, and Julio Saez-Rodriguez. 2020. “Transfer of Regulatory Knowledge from Human to Mouse for Functional Genomics Analysis.” *Biochimica et Biophysica Acta (BBA) - Gene Regulatory Mechanisms* 1863 (6): 194431. <https://doi.org/10.1016/j.bbagrm.2019.194431>.

Jerby-Arnon, Livnat, Parin Shah, Michael S. Cuoco, Christopher Rodman, Mei-Ju Su, Johannes C. Melms, Rachel Leeson, et al. 2018. “A Cancer Cell Program Promotes T Cell Exclusion and Resistance to Checkpoint Blockade.” *Cell* 175 (4): 984–997.e24. <https://doi.org/10.1016/j.cell.2018.09.006>.

Lapuente-Santana, Oscar, Maisa van Genderen, Peter A. J. Hilbers, Francesca Finotello, and Federica Eduati. 2021. “Interpretable Systems Biomarkers Predict Response to Immune-Checkpoint Inhibitors.” *Patterns*, 100293. <https://doi.org/10.1016/j.patter.2021.100293>.

Mariathasan, Sanjeev, Shannon J. Turley, Dorothee Nickles, Alessandra Castiglioni, Kobe Yuen, Yulei Wang, Edward E. Kadel III, et al. 2018. “TGFB Attenuates Tumour Response to Pd-L1 Blockade by Contributing to Exclusion of T Cells.” *Nature* 554 (7693): 544–48. <https://doi.org/10.1038/nature25501>.

McClanahan, Mark Ayers AND Jared Lunceford AND Michael Nebozhyn AND Erin Murphy AND Andrey Loboda AND David R. Kaufman AND Andrew Albright AND Jonathan D. Cheng AND S. Peter Kang AND Veena Shankaran AND Sarina A. Piha-Paul AND Jennifer Yearley AND Tanguy Y. Seiwert AND Antoni Ribas AND Terrill K. 2017. “IFN-Y–Related mRNA Profile Predicts Clinical Response to Pd-1 Blockade.” *The Journal of Clinical Investigation* 127 (8): 2930–40. <https://doi.org/10.1172/JCI91190>.

Messina, Jane L., David A. Fenstermacher, Steven Eschrich, Xiaotao Qu, Anders E. Berglund, Mark C. Lloyd, Michael J. Schell, Vernon K. Sondak, Jeffrey S. Weber, and James J. Mule. 2012. “12-Chemokine Gene Signature Identifies Lymph Node-Like Structures in Melanoma: Potential for Patient Selection for Immunotherapy?” *Scientific Reports* 2 (1): 765. <https://doi.org/10.1038/srep00765>.

Ramilowski, Jordan A., Tatyana Goldberg, Jayson Harshbarger, Edda Kloppmann, Marina Lizio, Venkata P. Satagopam, Masayoshi Itoh, et al. 2015. “A Draft Network of Ligand–Receptor-Mediated Multicellular Signalling in Human.” *Nature Communications* 6 (1): 7866. <https://doi.org/10.1038/ncomms8866>.

Roh, Whijae, Pei-Ling Chen, Alexandre Reuben, Christine N. Spencer, Peter A. Prieto, John P. Miller, Vancheswaran Gopalakrishnan, et al. 2017. “Integrated Molecular Analysis of Tumor Biopsies on Sequential Ctla-4 and Pd-1 Blockade Reveals Markers of Response and Resistance.” *Science Translational Medicine* 9 (379). <https://doi.org/10.1126/scitranslmed.aah3560>.

Rooney, Michael S., Sachet A. Shukla, Catherine J. Wu, Gad Getz, and Nir Hacohen. 2015. “Molecular and Genetic Properties of Tumors Associated with Local Immune Cytolytic Activity.” *Cell* 160 (1): 48–61. <https://doi.org/10.1016/j.cell.2014.12.033>.

Schubert, Michael, Bertram Klinger, Martina Klunemann, Anja Sieber, Florian Uhlitz, Sascha Sauer, Mathew J. Garnett, Nils Bluthgen, and Julio Saez-Rodriguez. 2018. “Perturbation-Response Genes Reveal Signaling Footprints in Cancer Gene Expression.” *Nature Communications* 9 (1): 20. <https://doi.org/10.1038/s41467-017-02391-6>.