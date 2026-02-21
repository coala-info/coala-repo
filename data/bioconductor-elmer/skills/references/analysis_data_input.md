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

# 3.1 - Data input - Creating MAE object

# Illustration of ELMER analysis steps

The example data set (`GeneExp`,`Meth`) is a subset of chromosome 1 data from TCGA LUSC and it is available with the ELMER package.

ELMER analysis have 5 main steps which are shown in the next sections individually. And later the function `TCGA.pipe`, which is a pipeline combining all 5 steps and producing all results and figures, is presented.

# Preparing data input

## Selection of probes within biofeatures

This step is to select HM450K/EPIC probes, which locate far from TSS (at least 2Kb away) These probes are called distal probes.

Be default, this comprehensive list of TSS annotated by ENSEMBL database, which is programatically accessed using *[biomaRt](https://bioconductor.org/packages/3.22/biomaRt)* to get its last version, will be used to select distal probes. But user can use their own TSS annotation or add features such as H3K27ac ChIP-seq in a certain cell line, to select probes overlapping thoses features regions.

```
# get distal probes that are 2kb away from TSS on chromosome 1
distal.probes <- get.feature.probe(
  genome = "hg19",
  met.platform = "450K",
  rm.chr = paste0("chr",c(2:22,"X","Y"))
)
```

## Creation of a MAE object

```
library(MultiAssayExperiment)
library(ELMER.data)
data(LUSC_RNA_refined,package = "ELMER.data")
data(LUSC_meth_refined,package = "ELMER.data")
GeneExp[1:5,1:5]
```

```
##                 TCGA-22-5472-01A-01R-1635-07 TCGA-22-5489-01A-01R-1635-07
## ENSG00000188984                    0.0000000                     0.000000
## ENSG00000204518                    0.4303923                     0.000000
## ENSG00000108270                   10.0817831                    10.717673
## ENSG00000198691                    6.4462711                     6.386644
## ENSG00000135776                    8.5929182                     9.333097
##                 TCGA-22-5491-11A-01R-1858-07 TCGA-56-5898-01A-11R-1635-07
## ENSG00000188984                     0.000000                    0.5233612
## ENSG00000204518                     0.000000                    0.0000000
## ENSG00000108270                    10.180863                   10.1595162
## ENSG00000198691                     5.755627                    4.8354795
## ENSG00000135776                     8.558358                    8.7772810
##                 TCGA-90-6837-01A-11R-1949-07
## ENSG00000188984                     0.000000
## ENSG00000204518                     1.167294
## ENSG00000108270                     9.975092
## ENSG00000198691                     3.152329
## ENSG00000135776                     8.604804
```

```
Meth[1:5,1:5]
```

```
##            TCGA-43-3394-11A-01D-1551-05 TCGA-43-3920-11B-01D-1551-05
## cg00045114                    0.8190894                    0.8073763
## cg00050294                    0.8423084                    0.8241138
## cg00066722                    0.9101127                    0.9162212
## cg00093522                    0.8751903                    0.8864599
## cg00107046                    0.3326016                    0.3445508
##            TCGA-56-8305-01A-11D-2294-05 TCGA-56-8307-01A-11D-2294-05
## cg00045114                    0.8907009                    0.8483227
## cg00050294                    0.5597787                    0.3488952
## cg00066722                    0.7228874                    0.6238963
## cg00093522                    0.8050060                    0.8194921
## cg00107046                    0.4312738                    0.4328108
##            TCGA-56-8308-01A-11D-2294-05
## cg00045114                    0.7612094
## cg00050294                    0.3908054
## cg00066722                    0.7727631
## cg00093522                    0.7507631
## cg00107046                    0.4260053
```

```
mae <- createMAE(
  exp = GeneExp,
  met = Meth,
  save = TRUE,
  linearize.exp = TRUE,
  save.filename = "mae.rda",
  filter.probes = distal.probes,
  met.platform = "450K",
  genome = "hg19",
  TCGA = TRUE
)
```

```
## Warning: sampleMap[['assay']] coerced with as.factor()
```

```
as.data.frame(colData(mae)[1:5,])  %>% datatable(options = list(scrollX = TRUE))
```

```
as.data.frame(sampleMap(mae)[1:5,])  %>% datatable(options = list(scrollX = TRUE))
```

```
as.data.frame(assay(getMet(mae)[1:5,1:5]))  %>% datatable(options = list(scrollX = TRUE))
```

```
as.data.frame(assay(getMet(mae)[1:5,1:5])) %>% datatable(options = list(scrollX = TRUE))
```

## Using non-TCGA data

In case you are using non-TCGA data there are two matrices to be inputed, colData with the samples metadata and sampleMap, mapping for each column of the gene expression and DNA methylation matrices to samples. An simple example is below if the columns of the matrices have the same name.

```
library(ELMER)
# example input
met <- matrix(rep(0,15),ncol = 5)
colnames(met) <- c(
  "Sample1",
  "Sample2",
  "Sample3",
  "Sample4",
  "Sample5"
)
rownames(met) <- c("cg26928153","cg16269199","cg13869341")

exp <- matrix(rep(0,15),ncol = 5)
colnames(exp) <- c(
  "Sample1",
  "Sample2",
  "Sample3",
  "Sample4",
  "Sample5"
)
rownames(exp) <- c("ENSG00000073282","ENSG00000078900","ENSG00000141510")

assay <- c(
  rep("DNA methylation", ncol(met)),
  rep("Gene expression", ncol(exp))
)
primary <- c(colnames(met),colnames(exp))
colname <- c(colnames(met),colnames(exp))
sampleMap <- data.frame(assay,primary,colname)

distal.probes <- get.feature.probe(
  genome = "hg19",
  met.platform = "EPIC"
)

colData <- data.frame(sample = colnames(met))
rownames(colData) <- colnames(met)

mae <- createMAE(
  exp = exp,
  met = met,
  save = TRUE,
  filter.probes = distal.probes,
  colData = colData,
  sampleMap = sampleMap,
  linearize.exp = TRUE,
  save.filename = "mae.rda",
  met.platform = "EPIC",
  genome = "hg19",
  TCGA = FALSE
)
```

# Bibliography