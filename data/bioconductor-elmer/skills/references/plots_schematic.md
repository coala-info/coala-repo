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

# 4.2 - Schematic plots

# Loading required data for plot

```
# Load results from previous sections
mae <- get(load("mae.rda"))
pair <- readr::read_csv("result/getPair.hypo.pairs.significant.csv")
```

# Schematic plot

Schematic plot shows a brief view of linkages between genes and probes.

## Nearby Genes

Generate schematic plot for one probe with 20 nearby genes and label the gene significantly linked with the probe in red.

```
schematic.plot(
  pair = pair,
  data = mae,
  group.col = "definition",
  byProbe = pair$Probe[1],
  save = FALSE
)
```

![The schematic plot shows probe colored in blue and the location of nearby 20 genes. The genes significantly linked to the probe  were shown in red.](data:image/png;base64...)

The schematic plot shows probe colored in blue and the location of nearby 20 genes. The genes significantly linked to the probe were shown in red.

## Nearby Probes

Generate schematic plot for one gene with the probes which the gene is significantly linked to.

```
schematic.plot(
  pair = pair,
  data = mae,
  group.col = "definition",
  byGene = pair$GeneID[1],
  save = FALSE
)
```

![The schematic plot shows the gene colored in red and all blue colored probes, which are significantly linked to the  expression of this gene.](data:image/png;base64...)

The schematic plot shows the gene colored in red and all blue colored probes, which are significantly linked to the expression of this gene.