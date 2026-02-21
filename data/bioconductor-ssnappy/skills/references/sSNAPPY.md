# sSNAPPY: Singel Sample directioNAl Pathway Perturbation analYsis

Wenjun Nora Liu1\* and Stephen Pederson\*\*

1Dame Roma Mitchell Cancer Research Laboratories, Adelaide Medical School, University of Adelaide

\*wenjun.liu@adelaide.edu.au
\*\*stephen.pederson.au@gmail.com

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 To get ready](#to-get-ready)
  + [2.1 Installation](#installation)
  + [2.2 Load packages](#load-packages)
  + [2.3 Load data](#load-data)
* [3 `sSNAPPY` workflow](#ssnappy-workflow)
  + [3.1 Compute weighted single-sample logFCs (ssLogFCs)](#compute-weighted-single-sample-logfcs-sslogfcs)
  + [3.2 Retrieve pathway topologies in the required format](#retrieve-pathway-topologies-in-the-required-format)
  + [3.3 Score single sample pathway perturbation](#score-single-sample-pathway-perturbation)
  + [3.4 Generate null distributions of perturbation scores](#generate-null-distributions-of-perturbation-scores)
  + [3.5 Test significant perturbation on](#test-significant-perturbation-on)
    - [3.5.1 single-sample level](#single-sample-level)
    - [3.5.2 treatment-level](#treatment-level)
* [4 References](#references)
* **Appendix**
* [A Session Info](#session-info)

# 1 Introduction

This vignette demonstrates how to use the package `sSNAPPY` to compute directional single sample pathway perturbation scores by incorporating pathway topologies and changes in gene expression, utilizing sample permutation to test the significance of individual scores and comparing average pathway activities across treatments.

The package also provides many powerful and easy-to-use visualisation functions that helps visualising significantly perturbed pathways as networks, detecting community structures in pathway networks, and revealing pathway genes’ involvement in the perturbation.

# 2 To get ready

## 2.1 Installation

The package `sSNAPPY` can be installed using the package `BiocManager`

```
if (!"BiocManager" %in% rownames(installed.packages()))
  install.packages("BiocManager")
# Other packages required in this vignette
pkg <- c("tidyverse", "magrittr", "ggplot2", "cowplot", "DT")
BiocManager::install(pkg)
BiocManager::install("sSNAPPY")
install.packages("htmltools")
```

## 2.2 Load packages

```
library(sSNAPPY)
library(tidyverse)
library(magrittr)
library(ggplot2)
library(cowplot)
library(DT)
library(htmltools)
library(patchwork)
```

## 2.3 Load data

The example dataset used for this tutorial can be loaded with `data()` as shown below. It’s a subset of data retrieved from [Singhal H et al. 2016](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4928895/), where ER-positive primary breast cancer tumour tissues collected from 12 patients were split into tissue fragments of equal sizes for different treatments.

For this tutorial, we are only looking at the RNA-seq data from samples that were treated with vehicle, R5020(progesterone) OR E2(estrogen) + R5020 for 48 hrs. Tumour specimens were collected from 5 patients, giving rise to a total of 15 samples. To cut down the computation time, only half the expressed genes were randomly sampled to derive the example logCPM matrix. A more detailed description of the dataset can be assessed through the help page (`?logCPM_example` and `?metadata_example`).

```
data(logCPM_example)
data(metadata_example)
# check if samples included in the logCPM matrix and metadata dataframe are identical
setequal(colnames(logCPM_example), metadata_example$sample)
```

```
## [1] TRUE
```

```
# View sample metadata
datatable(metadata_example,  filter = "top")
```

# 3 `sSNAPPY` workflow

## 3.1 Compute weighted single-sample logFCs (ssLogFCs)

It is expected that the logCPM matrix will be filtered to remove undetectable genes and normalised to correct for library sizes or other systematic artefacts, such as gene length or GC contents, prior to applying the `sSNAPPY` workflow. Filtration and normalisation have been performed on the example dataset.

Before single-sample logFC (ssFC) can be computed, row names of the logCPM matrix need to be converted to `entrez ID`. This is because all the pathway topology information retrieved will be in `entrez ID`. The conversion can be achieved through bioconductor packages `AnnotationHub` and `ensembldb`.

```
head(logCPM_example)
```

To compute the ssFC, samples must be in matching pairs. In our example data, treated samples were matched to the corresponding control samples derived from the same patients. Therefore the `groupBy` parameter of the `weight_ss_fc()` functions will be set to be “patient”.

`weight_ss_fc()` requires both the logCPM matrix and sample metadata as input. The column names of the logCPM matrix should be sample names, matching a column in the metadata. Name of the sample name column will be provided as the `sampleColumn` parameter. The function also requires the name of the metadata column that contains treatment information to be specified. The column with treatment information must be a factor with the control treatment set to be the reference level.

```
# Check that the baseline level of the treatment column is the control
levels(metadata_example$treatment)[1]
```

```
## [1] "Vehicle"
```

```
#compute weighted single sample logFCs
weightedFC <- weight_ss_fc(logCPM_example, metadata = metadata_example,
                           groupBy  = "patient", sampleColumn = "sample",
                           treatColumn = "treatment")
```

The `weight_ss_fc()` function firstly computes raw ssFC for each gene by subtracting logCPM values of the control sample from the logCPM values of treated samples within each patient.

It has been demonstrated previously that in RNA-seq data, lowly expressed genes turn to have a larger variance (Law et al. 2014), which is also demonstrated by the plots below. To reduce the impact of this artefact, `weight_ss_fc` also weights each ssFCs by estimating the relationship between the gene-level variance and mean logCPM, and defining the gene-wise weight to be the inverse of the predicted variance of that gene’s mean logCPM value.

```
logCPM_example %>%
    as.data.frame() %>%
    mutate(
        sd = apply(., 1, sd),
        mean = apply(., 1, mean)
        ) %>%
    ggplot(
        aes(mean, sd)
    ) +
    geom_point() +
    geom_smooth(
        method = "loess") +
    labs(
        x = expression(Gene-wise~average~expression~(bar(mu[g]))),
        y = expression(Gene-wise~standard~deviation~(sigma[g]))
    ) +
    theme_bw() +
    theme(
        panel.grid = element_blank(),
        axis.title = element_text(size = 14)
    )
```

![*Gene-wise standard deviations are plotted against the mean logCPM values with mean-variance trend modelled by a loess fit. Genes with low expression values tend to have a larger variance.*](data:image/png;base64...)

Figure 1: *Gene-wise standard deviations are plotted against the mean logCPM values with mean-variance trend modelled by a loess fit*
Genes with low expression values tend to have a larger variance.

The output of the `weight_ss_fc()` function is a list with two element, where one is the weighted ssFC matrix (`weighted_logFC`) and the other is a vector of gene-wise weights (`weight`).

## 3.2 Retrieve pathway topologies in the required format

*sSNAPPY* adopts the pathway perturbation scoring algorithm proposed in *[SPIA](https://bioconductor.org/packages/3.22/SPIA)*, which makes use of gene-set topologies and gene-gene interaction to propagate pathway genes’ logFCs down the topologies to compute pathway perturbation scores, where signs of scores reflect pathways’ potential directions of changes.

Therefore, pathway topology information needs to be firstly retrieved from a chosen database and converted to weight adjacency matrices, the format required to apply the scoring algorithm.

This step is achieved through a chain of functions that are part of the *[grapghite](https://bioconductor.org/packages/3.22/grapghite)*, which have been nested into one simple function in *sSNAPPY* called `retrieve_topology()`. The `retrieve_topology` function now supports various species and databases. Databases that are currently supported for human are the Kyoto Encyclopaedia of Genes and Genomes (KEGG) database(Ogata et al. 1999), the Reactome(Gillespie et al. 2021) database, and WikiPathways(Martens et al. 2021).

The retrieved topology information will be a list where each element corresponds a pathway. It’s recommended to save the list as a file so this step only needs to be performed once for each database.

This vignette uses *KEGG* pathways in human as an example.

```
gsTopology <- retrieve_topology(database = "kegg", species = "hsapiens")
head(names(gsTopology))
```

```
## [1] "kegg.Glycolysis / Gluconeogenesis"
## [2] "kegg.Citrate cycle (TCA cycle)"
## [3] "kegg.Pentose phosphate pathway"
## [4] "kegg.Pentose and glucuronate interconversions"
## [5] "kegg.Fructose and mannose metabolism"
## [6] "kegg.Galactose metabolism"
```

If only selected biological processes are of interest to your research, it’s possible to only retrieve the topologies of those pathways by specifying keywords. For example, to retrieve all metabolism-related *KEGG* pathways:

```
gsTopology_sub <- retrieve_topology(
  database = "kegg",
  species = "hsapiens",
  keyword = "metabolism")
head(names(gsTopology_sub))
```

```
## [1] "kegg.Fructose and mannose metabolism"
## [2] "kegg.Galactose metabolism"
## [3] "kegg.Ascorbate and aldarate metabolism"
## [4] "kegg.Purine metabolism"
## [5] "kegg.Caffeine metabolism"
## [6] "kegg.Pyrimidine metabolism"
```

It is also possible to provide multiple databases’ names and/or multiple keywords for a focused analysis.

```
##   [1] "kegg.Fructose and mannose metabolism"
##   [2] "kegg.Galactose metabolism"
##   [3] "kegg.Ascorbate and aldarate metabolism"
##   [4] "kegg.Purine metabolism"
##   [5] "kegg.Caffeine metabolism"
##   [6] "kegg.Pyrimidine metabolism"
##   [7] "kegg.Alanine, aspartate and glutamate metabolism"
##   [8] "kegg.Glycine, serine and threonine metabolism"
##   [9] "kegg.Cysteine and methionine metabolism"
##  [10] "kegg.Arginine and proline metabolism"
##  [11] "kegg.Histidine metabolism"
##  [12] "kegg.Tyrosine metabolism"
##  [13] "kegg.Phenylalanine metabolism"
##  [14] "kegg.Tryptophan metabolism"
##  [15] "kegg.beta-Alanine metabolism"
##  [16] "kegg.Taurine and hypotaurine metabolism"
##  [17] "kegg.Phosphonate and phosphinate metabolism"
##  [18] "kegg.Selenocompound metabolism"
##  [19] "kegg.Glutathione metabolism"
##  [20] "kegg.Starch and sucrose metabolism"
##  [21] "kegg.Amino sugar and nucleotide sugar metabolism"
##  [22] "kegg.Glycerolipid metabolism"
##  [23] "kegg.Inositol phosphate metabolism"
##  [24] "kegg.Glycerophospholipid metabolism"
##  [25] "kegg.Ether lipid metabolism"
##  [26] "kegg.Arachidonic acid metabolism"
##  [27] "kegg.Linoleic acid metabolism"
##  [28] "kegg.alpha-Linolenic acid metabolism"
##  [29] "kegg.Sphingolipid metabolism"
##  [30] "kegg.Pyruvate metabolism"
##  [31] "kegg.Glyoxylate and dicarboxylate metabolism"
##  [32] "kegg.Propanoate metabolism"
##  [33] "kegg.Butanoate metabolism"
##  [34] "kegg.Thiamine metabolism"
##  [35] "kegg.Riboflavin metabolism"
##  [36] "kegg.Vitamin B6 metabolism"
##  [37] "kegg.Nicotinate and nicotinamide metabolism"
##  [38] "kegg.Lipoic acid metabolism"
##  [39] "kegg.Retinol metabolism"
##  [40] "kegg.Porphyrin metabolism"
##  [41] "kegg.Nitrogen metabolism"
##  [42] "kegg.Sulfur metabolism"
##  [43] "kegg.Metabolism of xenobiotics by cytochrome P450"
##  [44] "kegg.Drug metabolism - cytochrome P450"
##  [45] "kegg.Drug metabolism - other enzymes"
##  [46] "kegg.Carbon metabolism"
##  [47] "kegg.2-Oxocarboxylic acid metabolism"
##  [48] "kegg.Fatty acid metabolism"
##  [49] "kegg.Nucleotide metabolism"
##  [50] "kegg.Estrogen signaling pathway"
##  [51] "kegg.Cholesterol metabolism"
##  [52] "kegg.Cobalamin transport and metabolism"
##  [53] "kegg.Central carbon metabolism in cancer"
##  [54] "kegg.Choline metabolism in cancer"
##  [55] "reactome.Metabolism"
##  [56] "reactome.Inositol phosphate metabolism"
##  [57] "reactome.PI Metabolism"
##  [58] "reactome.Phospholipid metabolism"
##  [59] "reactome.Nucleotide metabolism"
##  [60] "reactome.Sulfur amino acid metabolism"
##  [61] "reactome.Glycosaminoglycan metabolism"
##  [62] "reactome.Integration of energy metabolism"
##  [63] "reactome.Keratan sulfate/keratin metabolism"
##  [64] "reactome.Heparan sulfate/heparin (HS-GAG) metabolism"
##  [65] "reactome.Glycosphingolipid metabolism"
##  [66] "reactome.Transport and metabolism of PAPS"
##  [67] "reactome.Lipoprotein metabolism"
##  [68] "reactome.Chondroitin sulfate/dermatan sulfate metabolism"
##  [69] "reactome.Porphyrin metabolism"
##  [70] "reactome.Estrogen biosynthesis"
##  [71] "reactome.Bile acid and bile salt metabolism"
##  [72] "reactome.Non-coding RNA Metabolism"
##  [73] "reactome.Metabolism of steroid hormones"
##  [74] "reactome.Cobalamin (Cbl, vitamin B12) transport and metabolism"
##  [75] "reactome.Metabolism of folate and pterines"
##  [76] "reactome.Biotin transport and metabolism"
##  [77] "reactome.Vitamin D (calciferol) metabolism"
##  [78] "reactome.Nicotinate metabolism"
##  [79] "reactome.Vitamin C (ascorbate) metabolism"
##  [80] "reactome.Vitamin B2 (riboflavin) metabolism"
##  [81] "reactome.Metabolism of water-soluble vitamins and cofactors"
##  [82] "reactome.Metabolism of vitamins and cofactors"
##  [83] "reactome.Vitamin B5 (pantothenate) metabolism"
##  [84] "reactome.Metabolism of nitric oxide: NOS3 activation and regulation"
##  [85] "reactome.Metabolism of Angiotensinogen to Angiotensins"
##  [86] "reactome.alpha-linolenic (omega3) and linoleic (omega6) acid metabolism"
##  [87] "reactome.Linoleic acid (LA) metabolism"
##  [88] "reactome.alpha-linolenic acid (ALA) metabolism"
##  [89] "reactome.Metabolism of amine-derived hormones"
##  [90] "reactome.Arachidonate metabolism"
##  [91] "reactome.Hyaluronan metabolism"
##  [92] "reactome.Metabolism of ingested SeMet, Sec, MeSec into H2Se"
##  [93] "reactome.Selenoamino acid metabolism"
##  [94] "reactome.Peptide hormone metabolism"
##  [95] "reactome.Defects in vitamin and cofactor metabolism"
##  [96] "reactome.Defects in biotin (Btn) metabolism"
##  [97] "reactome.Metabolism of polyamines"
##  [98] "reactome.Diseases associated with glycosaminoglycan metabolism"
##  [99] "reactome.Glyoxylate metabolism and glycine degradation"
## [100] "reactome.Peroxisomal lipid metabolism"
## [101] "reactome.Metabolism of proteins"
## [102] "reactome.Regulation of lipid metabolism by PPARalpha"
## [103] "reactome.Sialic acid metabolism"
## [104] "reactome.Sphingolipid metabolism"
## [105] "reactome.Metabolism of lipids"
## [106] "reactome.Fructose metabolism"
## [107] "reactome.Diseases of carbohydrate metabolism"
## [108] "reactome.Diseases of metabolism"
## [109] "reactome.Surfactant metabolism"
## [110] "reactome.Metabolism of fat-soluble vitamins"
## [111] "reactome.Pyruvate metabolism"
## [112] "reactome.Glucose metabolism"
## [113] "reactome.Creatine metabolism"
## [114] "reactome.Amino acid and derivative metabolism"
## [115] "reactome.Carbohydrate metabolism"
## [116] "reactome.Ketone body metabolism"
## [117] "reactome.RUNX1 regulates estrogen receptor mediated transcription"
## [118] "reactome.Metabolism of RNA"
## [119] "reactome.Metabolism of steroids"
## [120] "reactome.Phenylalanine and tyrosine metabolism"
## [121] "reactome.Aspartate and asparagine metabolism"
## [122] "reactome.Phenylalanine metabolism"
## [123] "reactome.Glutamate and glutamine metabolism"
## [124] "reactome.Fatty acid metabolism"
## [125] "reactome.Metabolism of cofactors"
## [126] "reactome.Triglyceride metabolism"
## [127] "reactome.Glycogen metabolism"
## [128] "reactome.Extra-nuclear estrogen signaling"
## [129] "reactome.Estrogen-dependent gene expression"
## [130] "reactome.Regulation of glycolysis by fructose 2,6-bisphosphate metabolism"
## [131] "reactome.Estrogen-stimulated signaling through PRKCZ"
## [132] "reactome.Estrogen-dependent nuclear events downstream of ESR-membrane signaling"
## [133] "reactome.Retinoid metabolism and transport"
## [134] "reactome.Cobalamin (Cbl) metabolism"
## [135] "reactome.Serine metabolism"
## [136] "reactome.Regulation of pyruvate metabolism"
```

## 3.3 Score single sample pathway perturbation

Once the expression matrix, sample metadata and pathway topologies are all ready, gene-wise single-sample perturbation scores can be computed within each sample:

```
genePertScore <- raw_gene_pert(weightedFC$weighted_logFC, gsTopology)
```

and summed to derive pathway perturbation scores for each pathway in each treated samples.

```
pathwayPertScore <- pathway_pert(genePertScore, weightedFC$weighted_logFC)
head(pathwayPertScore)
```

```
##           sample       score                                        gs_name
## 1 E2+R5020_N2_48 0.009678626 kegg.EGFR tyrosine kinase inhibitor resistance
## 2    R5020_N2_48 0.010188371 kegg.EGFR tyrosine kinase inhibitor resistance
## 3 E2+R5020_N3_48 0.001849412 kegg.EGFR tyrosine kinase inhibitor resistance
## 4    R5020_N3_48 0.001623191 kegg.EGFR tyrosine kinase inhibitor resistance
## 5 E2+R5020_P4_48 0.004541758 kegg.EGFR tyrosine kinase inhibitor resistance
## 6    R5020_P4_48 0.005429066 kegg.EGFR tyrosine kinase inhibitor resistance
```

## 3.4 Generate null distributions of perturbation scores

To derive the empirical p-values for each single-sample perturbation scores and normalize the raw scores for comparing overall treatment effects, null distributions of scores for each pathway are generated through a sample-label permutation approach.

In the permutation, all sample labels will be randomly shuffled and put into permuted pairs. Permuted single-sample logFCs will be calculated for each permuted pair of samples, while the reminding pathway perturbation scoring algorithm remains unchanged. Unless otherwise specified through the `NB` parameter, all possible permuted pairs will be used to construct the null distributions of perturbation scores.

The output of the `generate_permuted_scores()` function is a list where each element is a vector of permuted perturbation scores for a specific pathway.

```
set.seed(123)
permutedScore <- generate_permuted_scores(
  expreMatrix  = logCPM_example,
  gsTopology = gsTopology,
  weight = weightedFC$weight
)
```

## 3.5 Test significant perturbation on

### 3.5.1 single-sample level

After the empirical null distributions are generated, the median and mad of each distribution will be calculated for each pathway to convert the test single-sample perturbation scores derived from the `compute_perturbation_score()` function to robust z-scores: \((Score - Median)/MAD\).

Two-sided p-values associated with each perturbation scores are also computed by the proportion of permuted scores that are as or more extreme than the test perturbation score within each pathway. Raw p-values will be corrected for multiple-testing using a user-defined approach. The default is `fdr`.

In a data with N samples, the total number of possible permuted pairs of samples is \(N \times (N-1)\). When the sample size is small, small p-values cannot be accurately estimated so the p-values returned by the `normalise_by_permu()` function should be interpreted with caution.

The `normalise_by_permu()` function requires the test perturbation scores and permuted perturbation scores as input. Users can choose to sort the output by p-values, gene-set names or sample names.

```
normalisedScores <- normalise_by_permu(permutedScore, pathwayPertScore, sortBy = "pvalue")
```

In this example dataset, none of the pathway was considered to be significantly perturbed within individual samples using a FDR cut-off of 0.05.

```
normalisedScores %>%
    dplyr::filter(adjPvalue < 0.05)
```

```
## [1] MAD       MEDIAN    gs_name   sample    score     robustZ   pvalue
## [8] adjPvalue
## <0 rows> (or 0-length row.names)
```

### 3.5.2 treatment-level

In addition to testing pathway perturbations at single-sample level, normalised perturbation scores can also be used to model mean treatment effects within a group, such as within each treatment group. An advantage of this method is that it has a high level of flexibility that allows us to incorporate confounding factors as co-factors or co-variates to offset their effects.

In the example data-set, the key question is how tumour tissues responded to the activation of PR alone or both ER and AR. We can test for the treatment-level pathway perturbation using a linear regression model of the form `~ 0 + treatment`.

```
fit <- normalisedScores %>%
    left_join(metadata_example) %>%
    split(f = .$gs_name) %>%
    lapply(function(x)lm(robustZ ~ 0 + treatment, data = x)) %>%
    lapply(summary)
treat_sig <- lapply(
  names(fit),
  function(x){
    fit[[x]]$coefficients %>%
      as.data.frame() %>%
      .[seq_len(2),] %>%
      dplyr::select(Estimate, pvalue = `Pr(>|t|)` ) %>%
      rownames_to_column("Treatment") %>%
      mutate(
        gs_name = x,
        FDR = p.adjust(pvalue, "fdr"),
        Treatment = str_remove_all(Treatment, "treatment")
      )
  }) %>%
  bind_rows()
```

Results from the linear modelling revealed pathways that were on average perturbed due to each treatment:

```
treat_sig %>%
    dplyr::filter(FDR < 0.05) %>%
    mutate_at(vars(c("Treatment", "gs_name")), as.factor) %>%
    mutate_if(is.numeric, sprintf, fmt = '%#.4f') %>%
    mutate(Direction = ifelse(Estimate < 0, "Inhibited", "Activation")) %>%
    dplyr::select(
        Treatment, `Perturbation Score` = Estimate, Direction,
        `Gene-set name` = gs_name,
        `P-value` = pvalue,
        FDR
    ) %>%
    datatable(
        filter = "top",
        options = list(
            columnDefs = list(list(targets = "Direction", visible = FALSE))
        ),
        caption = htmltools::tags$caption(
                  htmltools::em(
                      "Pathways that were significant perturbed within each treatment group.")
              )
    ) %>%
    formatStyle(
        'Perturbation Score', 'Direction',
        color = styleEqual(c("Inhibited", "Activation"), c("blue", "red"))
    )
```

#### 3.5.2.1 Visualise genes’ contributions to pathway perturbation

If there’s a specific pathway that we would like to dig deeper into and explore which pathway genes potentially played a key role in its perturbation, for example, activation of the “Proteoglycans in cancer” in progesterone-treated samples, we can plot the gene-level perturbation scores of genes that are constantly highly perturbed or highly variable in that pathway as a heatmap using the `plot_gene_contribution()` function.

From the heatmap below that we can see that the activation of this pathway was consistently driven by two genes: ENTREZID:1277 and ENTREZID:3688 in all R5020-treated samples while the other genes show some inter-patient heterogeneity.

```
plot_gene_contribution(
    genePertMatr  = genePertScore$`kegg.Proteoglycans in cancer` %>%
        .[, str_detect(colnames(.), "E2", negate = TRUE)],
    filterBy = "mean",
    topGene = 10,
    color = rev(colorspace::divergex_hcl(100, palette = "RdBu")),
    breaks = seq(-0.001, 0.001, length.out = 100)
)
```

![*Gene-level perturbation scores of genes with top 10 highest absolute mean gene-wise perturbation scores in the kegg.Proteoglycans in cancer gene-set. Only samples treated with R52020 are included.*](data:image/png;base64...)

Figure 2: *Gene-level perturbation scores of genes with top 10 highest absolute mean gene-wise perturbation scores in the kegg.Proteoglycans in cancer gene-set*
Only samples treated with R52020 are included.

By default, genes’ entrez IDs are used and plotted as row names, which may not be very informative. So the row names could be overwritten by providing a `data.frame` mapping entrez IDs to other identifiers through the `mapRownameTo` parameter.

Mapping between different gene identifiers could be achieved through the `mapIDs()` function from the Bioconductor package [`AnnotationDbi`](https://bioconductor.org/packages/release/bioc/html/AnnotationDbi.html). But to reduce the compiling time of this vignette, mappings between entrez IDs and gene names as available in Ensembl Release 101 have been provided as a `data.frame` called `entrez2name`.

Note that if the mapping information was provided and the mapping was only successful for some genes but not the others, only genes that have been mapped successfully will be plotted.

Since `plot_gene_contribution()` is built on `pheatmap`, which provides a practical column annotation feature, the `plot_gene_contribution()` function also allow a `data.frame` storing annotation information to be provided to utilise that feature. We can annotate each column (ie. each sample) by the pathway-level perturbation score or any other sample metadata, such as progesterone receptor (PR) status.

In this example, we first create a `data.frame` storing the pathway-level perturbation scores of the “Proteoglycans in cancer” pathway in each sample and their PR status.

```
annotation_df <- normalisedScores %>%
    dplyr::filter(gs_name == "kegg.Proteoglycans in cancer") %>%
    mutate(
        `Z Range` = cut(
            robustZ, breaks = seq(-2, 2, length.out = 6), include.lowest = TRUE
        )
    ) %>%
    dplyr::select(sample, `Z Range`) %>%
    left_join(
        .,  metadata_example %>%
            dplyr::select(sample, `PR Status` = PR),
        unmatched = "drop"
    )
```

The annotation `data.frame` was provided to the `plot_gene_contribution()` function through the `annotation_df` parameter. Colors of the annotation could be customised through `pheatmap::pheatmap()`’s `annotation_colors` parameter.

From the heatmap below, we can see that gene EIF3B and MTOR played a strong role in promoting the activation of this pathway in the two PR-negative samples, but those two genes were not as highly involved in the PR-positive samples. The genes consistently promoting the activation of this pathway among all R5020-treated samples are MMP2, COL1A1 and ITGB1.

```
load(system.file("extdata", "entrez2name.rda", package = "sSNAPPY"))
z_levels <- levels(annotation_df$`Z Range`)
sample_order <- metadata_example %>%
    dplyr::filter(treatment == "R5020") %>%
    .[order(.$treatment),] %>%
    pull(sample)
plot_gene_contribution(
    genePertMatr  = genePertScore$`kegg.Proteoglycans in cancer` %>%
        .[, match(sample_order, colnames(.))],
    annotation_df = annotation_df,
    filterBy = "mean",
    topGene = 10,
    mapEntrezID = entrez2name,
    cluster_cols = FALSE,
    color = rev(colorspace::divergex_hcl(100, palette = "RdBu")),
    breaks = seq(-0.001, 0.001, length.out = 100),
    annotation_colors = list(
        `PR Status` = c(Positive = "darkgreen", Negative = "orange"),
        `Z Range` = setNames(
            colorRampPalette(c("navyblue", "white", "darkred"))(length(z_levels)),
            z_levels
        ))
    )
```

![*Gene-level perturbation scores of genes with top 10 absolute mean gene-wise perturbation scores in the Proteoglycans in cancer gene-set among R502-treated samples.*](data:image/png;base64...)

Figure 3: *Gene-level perturbation scores of genes with top 10 absolute mean gene-wise perturbation scores in the Proteoglycans in cancer gene-set among R502-treated samples.*

#### 3.5.2.2 Visualise overlap between gene-sets as networks

Visualising significantly perturbed biological pathways as a network, where edges between gene-sets reflect how much overlap they share, is an useful approach for demonstrating the connections between biological processes. The `plot_gs_network()` function in this package allows an easy construction of such network by taking the `normalise_by_permu()` function’s output as direct input and allowing flexible customisation.

Nodes in the network plots could be colored by the predicted direction of perturbation (i.e. sign of robust z-score) or p-values.
Results of group-level perturbation can also be visualised using the `plot_gs_network()` function.

The function allows you to customize the layout, colour, edge transparency and other aesthetics of the graph. More information can be found on the help page (`?plot_gs_network`). The output of the graph is a `ggplot` object and the theme of it can be changed just as any other `ggplot` figures.

Taking the pathways that were among the top 20 ranked in the R5020 group as an example:

```
pathway2plot <- treat_sig %>%
    dplyr::filter(Treatment == "R5020") %>%
    arrange(FDR) %>%
    .[1:20,] %>%
    mutate(
        status = ifelse(Estimate > 0, "Activated", "Inhibited"),
        status = ifelse(FDR < 0.05, status, "Unchanged"))
```

```
set.seed(123)
p1 <- pathway2plot %>%
    plot_gs_network(
        gsTopology = gsTopology,
        colorBy = "status"
    ) +
    scale_color_manual(
        values = c(
            "Activated" = "red",
            "Unchanged" = "gray"
        )
    ) +
    theme(
        panel.grid = element_blank(),
        panel.background = element_blank()
    )
set.seed(123)
p2 <- pathway2plot %>%
    mutate(`-log10(p)` = -log10(pvalue)) %>%
    plot_gs_network(
        gsTopology = gsTopology,
        colorBy = "-log10(p)"
    ) +
    theme(
        panel.grid = element_blank(),
        panel.background = element_blank()
    )
(p1 | p2) +
    plot_annotation(tag_levels = "A")
```

![*Networks of pathways that were perturbed by the R5020 treatment, where colors of nodes reflect (A) pathways' predicted directions of changes. and (B) -log10(p-values). In panel A, pathways that were significantly perturbed were predicted to be either inhibited or activated while pathways that did not pass the significance threshold were deemed unchanged.*](data:image/png;base64...)

Figure 4: *Networks of pathways that were perturbed by the R5020 treatment, where colors of nodes reflect (A) pathways’ predicted directions of changes*
and (B) -log10(p-values). In panel A, pathways that were significantly perturbed were predicted to be either inhibited or activated while pathways that did not pass the significance threshold were deemed unchanged.

#### 3.5.2.3 Visualise community structure in the gene-set network

When a large number of pathways were perturbed, it is hard to answer the question “What key biological processes were perturbed?” solely by looking at all the pathway names. To solve that, we can use the `plot_community()` function to apply a community detection algorithm to the network structure we constructed above, and annotate each community by the biological process that most pathways assigned to that community belong to.

Using the default Louvain community detection algorithm, two main communities were formed and annotated to be related to cancer and endocrine and sensory system, aligning with the expected changes in hormone-treated cancer samples.

```
set.seed(123)
pathway2plot %>%
    plot_community(
        gsTopology = gsTopology,
        colorBy = "status",
        color_lg_title = "Community"
    ) +
    scale_color_manual(
        values = c(
            "Activated" = "red",
            "Unchanged" = "gray"
        )
    ) +
    theme(panel.background = element_blank())
```

![*The top 20 ranked pathways in the R5020 treatment group, annotated by the main biological processes each pathways belong to and coloured by pathways' predicted change in direction. The status of pathways that did not pass the significance threshold to be considered as significantly perturbed were deemed as unchanged.*](data:image/png;base64...)

Figure 5: *The top 20 ranked pathways in the R5020 treatment group, annotated by the main biological processes each pathways belong to and coloured by pathways’ predicted change in direction*
The status of pathways that did not pass the significance threshold to be considered as significantly perturbed were deemed as unchanged.

The `plot_community` function was built in with categorizations of *KEGG* pathways so annotation of *KEGG* communities can be automatically completed without the need to specify the `gsAnnotation` parameter. We also retrieved and curated the categorisation of *Reactome* pathways, which can be loaded using the following code:

```
load(system.file("extdata", "gsAnnotation_df_reactome.rda", package = "sSNAPPY"))
```

Analyses involving other pathway databases may require user-provided pathway categories.

#### 3.5.2.4 Visualise genes included in perturbed pathways networks

If we want to not only know if two pathways are connected but also the genes connecting those pathways, we can use the `plot_gs2gene()` function instead:

```
treat_sig %>%
    dplyr::filter(FDR < 0.05,) %>%
    plot_gs2gene(
        gsTopology = gsTopology,
        colorGsBy = "Estimate",
        labelGene = FALSE,
        geneNodeSize  = 1,
        edgeAlpha = 0.1,
        gsNameSize = 2,
        filterGeneBy = 3
    ) +
    scale_fill_gradient2() +
    theme(panel.background = element_blank())
```

![*Pathways significantly perturbed by the R5020 treatment and genes implicated in at least 3 of those pathways.*](data:image/png;base64...)

Figure 6: *Pathways significantly perturbed by the R5020 treatment and genes implicated in at least 3 of those pathways.*

However, since there are a large number of genes in each pathway, the plot above was quite messy and it was unrealistic to plot all genes’ names. So it is recommend to filter genes by their perturbation scores or logFC.

For example, we can rank genes by the absolute values of their mean single-sample logFCs and only focus on genes that were ranked in the top 500 of the list.

```
meanFC <- weightedFC$weighted_logFC %>%
    .[, str_detect(colnames(.), "E2", negate = TRUE)] %>%
    apply(1, mean )
top500_gene <- meanFC %>%
    abs() %>%
    sort(decreasing = TRUE, ) %>%
    .[1:500] %>%
    names()
top500_FC <- meanFC %>%
    .[names(.) %in% top500_gene]
top500_FC  <- ifelse(top500_FC > 0, "Up-Regulated", "Down-Regulated")
```

When we provide genes’ logFC as a named vector through the `geneFC` parameter, only pathway genes with logFC provided will be plotted and gene nodes will be colored by genes’ directions of changes. The names of the logFC vector must be entrez IDs in the format of “ENTREZID:XXXX”, as pathway topology matrices retrieved through `retrieve_topology()` always use entrez IDs as identifiers.

However, it is not going to be informative to label genes with their entrez IDs. So just as in the `plot_gene_contribution()` function, we can provide a `data.frame` to match genes’ entrez IDs to our chosen identifiers through the `mapEntrezID` parameter in the `plot_gs2gene()` function too.

```
treat_sig %>%
    dplyr::filter(FDR < 0.05, Treatment == "R5020") %>%
    mutate(status = ifelse(Estimate > 0, "Activated", "Inhibited")) %>%
    plot_gs2gene(
        gsTopology = gsTopology,
        colorGsBy = "status",
        geneFC = top500_FC,
        mapEntrezID = entrez2name,
        gsNameSize = 3,
        filterGeneBy = 0
    ) +
    scale_fill_manual(values = c("darkred", "lightskyblue")) +
    scale_colour_manual(values = c("red", "blue")) +
    theme(panel.background = element_blank())
```

![*Pathways significantly perturbed by the R5020 treatment, and pathway genes with top 500 magnitudes of changes among all R5020-treated samples. Both pathways and genes were colored by their predicted directions of changes.*](data:image/png;base64...)

Figure 7: *Pathways significantly perturbed by the R5020 treatment, and pathway genes with top 500 magnitudes of changes among all R5020-treated samples*
Both pathways and genes were colored by their predicted directions of changes.

# 4 References

# Appendix

* Charity W Law, Yunshun Chen, Wei Shi, and Gordon K Smyth. voom: precision weights unlock linear model analysis tools for RNA-seq read counts. Genome Biol, 15(2):R29, 2014. doi: 10.1186/gb-2014-15-2-r29.
* Gabriele Sales, Enrica Calura, Duccio Cavalieri, and Chiara Romualdi. graphite - a Bioconductor package to convert pathway topology to gene network. BMC Bioinformatics, 13(1):20, December 2012. doi: 10.1186/1471-2105-13-20.
* Adi Laurentiu Tarca, Sorin Draghici, Purvesh Khatri, Sonia S. Hassan, Pooja Mittal, Jung-sun Kim, Chong Jai Kim, Juan Pedro Kusanovic, and Roberto Romero. A novel signaling pathway impact analysis. Bioinformatics, 25(1):75–82, January 2009. doi: 10.1093/bioinformatics/btn577.
* Minoru Kanehisa and Susumu Goto. KEGG: Kyoto Encyclopedia of Genes and Genomes. Nucleic Acids Research 28.1 (2000), pp. 27–30.
* Marc Gillespie, Bijay Jassal, Ralf Stephan, Marija Milacic, Karen Rothfels, Andrea Senff-Ribeiro, Johannes Griss, Cristoffer Sevilla, Lisa Matthews, Chuqiao Gong, Chuan Deng, Thawfeek Varusai, Eliot Ragueneau, Yusra Haider, Bruce May, Veronica Shamovsky, Joel Weiser, Timothy Brunson, Nasim Sanati, Liam Beckman, Xiang Shao, Antonio Fabregat, Konstantinos Sidiropoulos, Julieth Murillo, Guilherme Viteri, Justin Cook, Solomon Shorser, Gary Bader, Emek Demir, Chris Sander, Robin Haw, Guanming Wu, Lincoln Stein, Henning Hermjakob, and Peter D’Eustachio. The reactome pathway knowledgebase 2022. Nucleic Acids Research, 50(D1):D687–D692, November 2021. doi: 10.1093/nar/gkab1028.
* Marvin Martens et al. WikiPathways: connecting communities. Nucleic Acids Research 49.D1 (2021), pp. D613–D621. doi: 10.1093/nar/gkaa1024.

# A Session Info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] patchwork_1.3.2   htmltools_0.5.8.1 DT_0.34.0         cowplot_1.2.0
##  [5] magrittr_2.0.4    lubridate_1.9.4   forcats_1.0.1     stringr_1.5.2
##  [9] dplyr_1.1.4       purrr_1.1.0       readr_2.1.5       tidyr_1.3.1
## [13] tibble_3.3.0      tidyverse_2.0.0   sSNAPPY_1.14.0    ggplot2_4.0.0
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   gridExtra_2.3
##   [3] rlang_1.1.6                 matrixStats_1.5.0
##   [5] compiler_4.5.1              RSQLite_2.4.3
##   [7] dir.expiry_1.18.0           mgcv_1.9-3
##   [9] systemfonts_1.3.1           png_0.1-8
##  [11] vctrs_0.6.5                 reshape2_1.4.4
##  [13] pkgconfig_2.0.3             crayon_1.5.3
##  [15] fastmap_1.2.0               XVector_0.50.0
##  [17] labeling_0.4.3              ggraph_2.2.2
##  [19] rmarkdown_2.30              tzdb_0.5.0
##  [21] graph_1.88.0                bit_4.6.0
##  [23] xfun_0.53                   cachem_1.1.0
##  [25] graphite_1.56.0             jsonlite_2.0.0
##  [27] blob_1.2.4                  DelayedArray_0.36.0
##  [29] tweenr_2.0.3                R6_2.6.1
##  [31] bslib_0.9.0                 stringi_1.8.7
##  [33] RColorBrewer_1.1-3          limma_3.66.0
##  [35] GenomicRanges_1.62.0        jquerylib_0.1.4
##  [37] Rcpp_1.1.0                  Seqinfo_1.0.0
##  [39] bookdown_0.45               SummarizedExperiment_1.40.0
##  [41] knitr_1.50                  IRanges_2.44.0
##  [43] splines_4.5.1               Matrix_1.7-4
##  [45] igraph_2.2.1                timechange_0.3.0
##  [47] tidyselect_1.2.1            dichromat_2.0-0.1
##  [49] abind_1.4-8                 yaml_2.3.10
##  [51] viridis_0.6.5               lattice_0.22-7
##  [53] plyr_1.8.9                  Biobase_2.70.0
##  [55] withr_3.0.2                 KEGGREST_1.50.0
##  [57] S7_0.2.0                    evaluate_1.0.5
##  [59] polyclip_1.10-7             Biostrings_2.78.0
##  [61] filelock_1.0.3              pillar_1.11.1
##  [63] BiocManager_1.30.26         MatrixGenerics_1.22.0
##  [65] stats4_4.5.1                generics_0.1.4
##  [67] S4Vectors_0.48.0            hms_1.1.4
##  [69] scales_1.4.0                gtools_3.9.5
##  [71] glue_1.8.0                  pheatmap_1.0.13
##  [73] tools_4.5.1                 locfit_1.5-9.12
##  [75] graphlayouts_1.2.2          tidygraph_1.3.1
##  [77] grid_4.5.1                  crosstalk_1.2.2
##  [79] colorspace_2.1-2            AnnotationDbi_1.72.0
##  [81] edgeR_4.8.0                 nlme_3.1-168
##  [83] ggforce_0.5.0               cli_3.6.5
##  [85] rappdirs_0.3.3              S4Arrays_1.10.0
##  [87] viridisLite_0.4.2           gtable_0.3.6
##  [89] sass_0.4.10                 digest_0.6.37
##  [91] BiocGenerics_0.56.0         SparseArray_1.10.0
##  [93] ggrepel_0.9.6               htmlwidgets_1.6.4
##  [95] org.Hs.eg.db_3.22.0         farver_2.1.2
##  [97] memoise_2.0.1               lifecycle_1.0.4
##  [99] httr_1.4.7                  statmod_1.5.1
## [101] bit64_4.6.0-1               MASS_7.3-65
```