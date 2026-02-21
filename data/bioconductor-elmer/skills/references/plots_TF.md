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

# 4.4 - Regulatory TF plots

# TF ranking plot

For a given enriched motif, all human TF are ranked by the statistical  − *l**o**g*10(*P* − *v**a**l**u**e*) assessing the anti-correlation level of candidate Master Regulator TF expression with average DNA methylation level for sites with the given motif. As a result, the most anti-correlated TFs will be ranked in the first positions. By default, the top 3 most anti-correlated TFs and all TF classified by TFClass database in the same (sub)family are highlighted with colors blue, red and orange, respectively.

## TF ranking plot: family classification

Shown are TF ranking plots based on the score ( − *l**o**g*10(*P**v**a**l**u**e*)) of association between TF expression and DNA methylation of an enriched motif in the LUSC cancer type. The dashed line indicates the boundary of the top 5% association score. The top 3 associated TFs and the TF family members=(dots in red) that are associated with that specific motif are labeled in the plot

```
load("result/getTF.hypo.TFs.with.motif.pvalue.rda")
motif <- colnames(TF.meth.cor)[1]
TF.rank.plot(
  motif.pvalue = TF.meth.cor,
  motif = motif,
  save = FALSE
)
```

```
## Retrieving TFClass family classification from ELMER.data.
```

```
## Retrieving TFClass subfamily classification from ELMER.data.
```

```
## |                                                    |  0%                      |====================================================|100% ~0 s remaining       |====================================================|100%                      Completed after 0 s
```

```
## $HXA9_HUMAN.H11MO.0.B
```

```
## Warning: ggrepel: 66 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

![ TF ranking plot: For a given enriched motif, all human TF are ranked by the statistical $-log_{10}(P-value)$ assessing the anti-correlation level of candidate Master Regulator TF expression with average DNA methylation level for sites with the given motif. As a result, the most anti-correlated TFs will be ranked in the first positions. By default, the top 3 most anti-correlated TFs, and all TF classified by TFClass database in the same family and subfamily are highlighted with colors blue, red and orange, respectively.](data:image/png;base64...)

TF ranking plot: For a given enriched motif, all human TF are ranked by the statistical  − *l**o**g*10(*P* − *v**a**l**u**e*) assessing the anti-correlation level of candidate Master Regulator TF expression with average DNA methylation level for sites with the given motif. As a result, the most anti-correlated TFs will be ranked in the first positions. By default, the top 3 most anti-correlated TFs, and all TF classified by TFClass database in the same family and subfamily are highlighted with colors blue, red and orange, respectively.

```
##
## attr(,"split_type")
## [1] "array"
## attr(,"split_labels")
##   X1
## 1  1
```