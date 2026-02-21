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

# 4.1 - Scatter plots

# Loading required data for plot

```
# Load results from previous sections
mae <- get(load("mae.rda"))
```

# Scatter plots

## Scatter plot of one probe and its nearby genes

Generate scatter plots for one probes’ nearby 20 gene expression vs DNA methylation at this probe.

Each scatter plot shows the methylation level of an example probe cg19403323 in all LUSC samples plotted against the expression of one of 20 adjacent genes.

```
scatter.plot(data = mae,
             byProbe = list(probe = c("cg19403323"), numFlankingGenes = 20),
             category = "definition",
             lm = TRUE, # Draw linear regression curve
             save = FALSE)
```

![Each scatter plot shows the methylation level of an example  probe cg19403323 in all LUSC samples plotted against the expression of one of  20 adjacent genes.](data:image/png;base64...)

Each scatter plot shows the methylation level of an example probe cg19403323 in all LUSC samples plotted against the expression of one of 20 adjacent genes.

## Scatter plot of one pair

Generate a scatter plot for one probe-gene pair. Figure

Scatter plot shows the methylation level of an example probe cg19403323 in all LUSC samples plotted against the expression of the putative target gene SYT14.

```
scatter.plot(data = mae,
             byPair = list(probe = c("cg19403323"), gene = c("ENSG00000143469")),
             category = "definition", save = TRUE, lm_line = TRUE)
```

![Scatter plot shows the methylation level of an example probe cg19403323 in all LUSC samples plotted against the expression of the putative  target gene SYT14.](data:image/png;base64...)

Scatter plot shows the methylation level of an example probe cg19403323 in all LUSC samples plotted against the expression of the putative target gene SYT14.

## TF expression vs. average DNA methylation

Generate scatter plot for TF expression vs average DNA methylation of the sites with certain motif.

Each scatter plot shows the average methylation level of sites with the TP53 motif in all LUSC samples plotted against the expression of the transcription factor TP53, TP63, TP73 respectively.

```
load("result/getMotif.hypo.enriched.motifs.rda")
names(enriched.motif)[1]
```

```
## [1] "HXA9_HUMAN.H11MO.0.B"
```

```
scatter.plot(data = mae,
             byTF = list(TF = c("TP53","SOX2"),
                         probe = enriched.motif[[names(enriched.motif)[1]]]),
             category = "definition",
             save = TRUE,
             lm_line = TRUE)
```

![Each scatter plot shows the average  methylation level of sites with the first enriched motif in all LUSC samples plotted against the expression of the transcription factor TP53, SOX2 respectively.](data:image/png;base64...)

Each scatter plot shows the average methylation level of sites with the first enriched motif in all LUSC samples plotted against the expression of the transcription factor TP53, SOX2 respectively.