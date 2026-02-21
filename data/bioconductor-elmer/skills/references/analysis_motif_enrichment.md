[ELMER](index.html)

* [Introduction](index.html)
* [Data input](input.html)
* Analysis
  + Analysis steps
  + [1 - Creating MAE with distal probes (data input)](analysis_data_input.html)
  + [2 - Identifying differentially methylated probes](analysis_diff_meth.html)
  + [3 - Identifying putative probe-gene pairs](analysis_get_pair.html)
  + [4 - Motif enrichment analysis on the selected probes](analysis_motif_enrichment.html)
  + [5 - Identifying regulatory TFs](analysis_regulatory_tf.html)
  + Compact version with TCGA data
  + [TCGA pipe](pipe.html)
* Plots
  + Plot functions
  + [1 - Scatter plots](plots_scatter.html)
  + [2 - Schematic plots](plots_schematic.html)
  + [3 - Motif enrichment plots](plots_motif_enrichment.html)
  + [4 - Regulatory TF plots](plots_TF.html)
  + [5 - Heatmap plots](plots_heatmap.html)
* [Graphical User interface](analysis_gui.html)
* [Use case](usecase.html)

* + ELMER package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
  + ELMER.data package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
  + Bioc2017 workshop
  + [Github ELMER/TCGAbiolinks](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER)
  + TCGAbiolinks package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinks)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinks.html)
* + Cedars-sinai
  + [center4bfg](https://twitter.com/center4bfg)
  + [center4bfg.org](https://center4bfg.org)
  + University of São Paulo (USP)
  + [fmrp.usp.br](http://www.fmrp.usp.br/?lang=en)
  + Fundings
  + [FAPESP (16/10436-9)](http://www.bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28instituicao%3A%22Cedars-Sinai+Medical+Center%22%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+abroad%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)
  + [NCI ITCR program (1U01CA184826)](https://itcr.nci.nih.gov/)
  + [Genomic Data Analysis Network NIH/NCI (1U24CA210969)](https://projectreporter.nih.gov/project_info_description.cfm?aid=9210719&icde=31197242&ddparam=&ddvalue=&ddsub=&cr=1&csb=default&cs=ASC)

# 3.4 - Motif enrichment analysis on the selected probes

# Motif enrichment analysis on the selected probes

## Introduction

This step is to identify enriched motif in a set of probes which is carried out by function `get.enriched.motif`.

## Description

In order to identify enriched motifs and potential upstream regulatory TFs, all probes with occurring in significant probe-gene pairs are combined for motif enrichment analysis. HOMER (Hypergeometric Optimization of Motif EnRichment) (Heinz and others 2010) is used to find motif occurrences in a \(\pm 250bp\) region around each probe, using HOCOMOCO (HOmo sapiens COmprehensive MOdel COllection) v11 (Kulakovskiy and others 2016). Transcription factor (TF) binding models are available at <https://hocomoco.autosome.org/downloads>. HOCOMOCO is the most comprehensive TFBS database and is consistently updated, marking an improvement over ELMER version 1.

For each probe set tested (i.e. the set of all probes occurring in significant probe-gene pairs), we quantify enrichments using Fisher’s exact test (where \(a\) is the number of probes within the selected probe set that contains one or more motif occurrences; \(b\) is the number of probes within the selected probe set that do not contain a motif occurrence; \(c\) and \(d\) are the same counts within the entire array probe set drawn from the same set of distal-only probes using the same definition as the primary analysis) and multiple testing correction with the Benjamini-Hochberg procedure (Fisher 1922).

A probe set was considered significantly enriched for a particular motif if the 95% confidence interval of the Odds Ratio was greater than \(1.1\) (specified by option `lower.OR`, \(1.1\) is default), the motif occurred at least 10 times (specified by option `min.incidence`, \(10\) is default) in the probe set and \(FDR < 0.05\).

# Function arguments

Main get.pair arguments

| Argument | Description |
| --- | --- |
| data | A multi Assay Experiment from createMAE function. If set and probes.motif/background probes are missing this will be used to get this other two arguments correctly. This argument is not require, you can set probes.motif and the backaground.probes manually. |
| probes | A vector lists the name of probes to define the set of probes in which motif enrichment OR and confidence interval will be calculated. |
| lower.OR | A number specifies the smallest lower boundary of 95% confidence interval for Odds Ratio. The motif with higher lower boudnary of 95% confidence interval for Odds Ratio than the number are the significantly enriched motifs (detail see reference). |
| min.incidence | A non-negative integer specifies the minimum incidence of motif in the given probes set. 10 is default. |

# Example of use

```
# Load results from previous sections
mae <- get(load("mae.rda"))
sig.diff <- read.csv("result/getMethdiff.hypo.probes.significant.csv")
pair <- read.csv("result/getPair.hypo.pairs.significant.csv")
head(pair) # significantly hypomethylated probes with putative target genes

# Identify enriched motif for significantly hypomethylated probes which
# have putative target genes.

enriched.motif <- get.enriched.motif(
  data = mae,
  probes = pair$Probe,
  dir.out = "result",
  label = "hypo",
  min.incidence = 10,
  lower.OR = 1.1
)
```

```
names(enriched.motif) # enriched motifs
```

```
## [1] "HXA9_HUMAN.H11MO.0.B"  "FOXH1_HUMAN.H11MO.0.A" "PO5F1_HUMAN.H11MO.1.A"
## [4] "HXB13_HUMAN.H11MO.0.A" "IRF9_HUMAN.H11MO.0.C"  "SOX10_HUMAN.H11MO.1.A"
```

```
head(enriched.motif[names(enriched.motif)[1]]) ## probes in the given set that have the first motif.
```

```
## $HXA9_HUMAN.H11MO.0.B
##  [1] "cg13067635" "cg24873093" "cg25210796" "cg18345456" "cg14094320"
##  [6] "cg17901924" "cg22736624" "cg12213388" "cg13305336" "cg26607897"
## [11] "cg11718886" "cg24593832" "cg25729466" "cg24446417"
```

```
# get.enriched.motif automatically save output files.
# getMotif.hypo.enriched.motifs.rda contains enriched motifs and the probes with the motif.
# getMotif.hypo.motif.enrichment.csv contains summary of enriched motifs.
dir(path = "result", pattern = "getMotif")
```

```
## [1] "getMotif.hypo.enriched.motifs.rda"  "getMotif.hypo.motif.enrichment.csv"
```

```
# motif enrichment figure will be automatically generated.
dir(path = "result", pattern = "motif.enrichment.pdf")
```

```
## [1] "hypo.quality.A-DS.motif.enrichment.pdf"
## [2] "hypo.quality.A-DS_with_summary.motif.enrichment.pdf"
```

# Bibliography

Fisher, Ronald A. 1922. “On the Interpretation of \(\chi\) 2 from Contingency Tables, and the Calculation of P.” *Journal of the Royal Statistical Society* 85 (1): 87–94.

Heinz, Sven, and others. 2010. “Simple Combinations of Lineage-Determining Transcription Factors Prime Cis-Regulatory Elements Required for Macrophage and B Cell Identities.” *Molecular Cell* 38 (4): 576–89.

Kulakovskiy, Ivan V, and others. 2016. “HOCOMOCO: Expansion and Enhancement of the Collection of Transcription Factor Binding Sites Models.” *Nucleic Acids Research* 44 (D1): D116–D125.