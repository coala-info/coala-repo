[[![](data:image/png;base64...)](http://bioconductor.org/packages/TCGAbiolinks/)](index.html)

* [Introduction](index.html)
* Data

  + Molecular data
  + [Query](query.html)
  + [Download & Prepare](download_prepare.html)
  + Other data
  + [Clinical data](clinical.html)
  + [Mutation data](mutation.html)
  + [Molecular subtypes](subtypes.html)
  + [ATAC-seq](http://rpubs.com/tiagochst/atac_seq_workshop)
* Analysis

  + [Analysis functions](analysis.html)
  + [Other functions](extension.html)
  + [Importing data to DESeq2](http://rpubs.com/tiagochst/TCGAbiolinks_to_DESEq2)
  + [Glioma classsifier](classifiers.html)
* [Case Study](casestudy.html)

* Workshops
  + TCGA workshop
  + [Workshop - TCGA data analysis](http://rpubs.com/tiagochst/TCGAworkshop)
  + ELMER workshop
  + [Workshop for multi-omics analysis with ELMER](http://rpubs.com/tiagochst/ELMER_workshop)
  + ATAC-Seq workshop
  + [Workshop for ATAC-Seq analysis](http://rpubs.com/tiagochst/atac_seq_workshop)
  + Bioc2017 workshop
  + [Github ELMER/TCGAbiolinks](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER)
* + TCGAbiolinks package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinks)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinks.html)
  + TCGAbiolinksGUI package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinksGUI)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinksGUI.html)
  + ELMER package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
  + ELMER.data package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
* + University of São Paulo (USP)
  + [fmrp.usp.br](http://www.fmrp.usp.br/?lang=en)
  + Fundings
  + [FAPESP (16/10436-9)](http://www.bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28instituicao%3A%22Cedars-Sinai+Medical+Center%22%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+abroad%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)
  + [FAPESP (16/01389-7)](http://bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28id_pesquisador_exact%3A679917%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+in+Brazil%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)

# TCGAbiolinks: Searching, downloading and visualizing mutation files

#### 30 October 2025

# Search and Download

**TCGAbiolinks** has provided a few functions to download mutation data from GDC. There are two options to download the data:

1. Use `GDCquery`, `GDCdownload` and `GDCpreprare` to download MAF aligned against hg38
2. Use `GDCquery`, `GDCdownload` and `GDCpreprare` to download MAF aligned against hg19
3. Use `getMC3MAF()`, to download MC3 MAF from <https://gdc.cancer.gov/about-data/publications/mc3-2017>

## Mutation data (hg38)

This example will download Aggregate GDC MAFs. For more information please access <https://github.com/NCI-GDC/gdc-maf-tool> and [GDC docs](https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipelines/DNA_Seq_Variant_Calling_Pipeline/).

```
query <- GDCquery(
    project = "TCGA-CHOL",
    data.category = "Simple Nucleotide Variation",
    access = "open",
    data.type = "Masked Somatic Mutation",
    workflow.type = "Aliquot Ensemble Somatic Variant Merging and Masking"
)
GDCdownload(query)
maf <- GDCprepare(query)
```

```
# Only first 50 to make render faster
datatable(maf[1:20,],
          filter = 'top',
          options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
          rownames = FALSE)
```

## Mutation data MC3 file

This will download the MC3 MAF file from <https://gdc.cancer.gov/about-data/publications/mc3-2017>, and add project each sample belongs.

```
maf <- getMC3MAF()
```

# Visualize the data

To visualize the data you can use the Bioconductor package [maftools](https://bioconductor.org/packages/release/bioc/html/maftools.html). For more information, please check its [vignette](https://bioconductor.org/packages/release/bioc/vignettes/maftools/inst/doc/maftools.html#rainfall-plots).

```
library(maftools)
library(dplyr)
query <- GDCquery(
    project = "TCGA-CHOL",
    data.category = "Simple Nucleotide Variation",
    access = "open",
    data.type = "Masked Somatic Mutation",
    workflow.type = "Aliquot Ensemble Somatic Variant Merging and Masking"
)
GDCdownload(query)
maf <- GDCprepare(query)

maf <- maf %>% maftools::read.maf
```

```
datatable(getSampleSummary(maf),
          filter = 'top',
          options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
          rownames = FALSE)
plotmafSummary(maf = maf, rmOutlier = TRUE, addStat = 'median', dashboard = TRUE)
```

![](data:image/png;base64...)

```
oncoplot(maf = maf, top = 10, removeNonMutated = TRUE)
titv = titv(maf = maf, plot = FALSE, useSyn = TRUE)
#plot titv summary
plotTiTv(res = titv)
```