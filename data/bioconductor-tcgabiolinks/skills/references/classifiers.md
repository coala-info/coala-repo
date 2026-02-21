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

# Classifiers methods

## Classifying gliomas samples with `gliomaClassifier`

---

Classifying glioma samples with DNA methylation array based on:

**Ceccarelli, Michele, et al. “Molecular profiling reveals biologically discrete subsets and pathways of progression in diffuse glioma.” Cell 164.3 (2016): 550-563.** (<https://doi.org/10.1016/j.cell.2015.12.028>)

Possible classifications are:

* Mesenchymal-like
* Classic-like
* G-CIMP-high
* G-CIMP-low
* LGm6-GBM
* Codel

## Data

---

The input data can be either a Summarized Experiment object of a matrix (samples as columns, probes as rows) from the following platforms:

* HM27
* HM450
* EPIC array.

In this example we will retrieve two samples from TCGA and classify them expecting the same result as the paper.

```
query <- GDCquery(
    project = "TCGA-GBM",
    data.category = "DNA Methylation",
    barcode = c("TCGA-06-0122","TCGA-14-1456"),
    platform = "Illumina Human Methylation 27",
    data.type = "Methylation Beta Value"
)
GDCdownload(query)
dnam <- GDCprepare(query)
```

```
assay(dnam)[1:5,1:2]
```

## Function

---

```
classification <- gliomaClassifier(dnam)
```

## Results

---

The classfier will return a list of 3 data frames:

1. Sample final classification
2. Each model final classification
3. Each class probability of classification

```
names(classification)
classification$final.classification
classification$model.classifications
classification$model.probabilities
```

## Comparing results with paper

---

```
TCGAquery_subtype("GBM") %>%
 dplyr::filter(patient %in% c("TCGA-06-0122","TCGA-14-1456")) %>%
 dplyr::select("patient","Supervised.DNA.Methylation.Cluster")
```

```
## gbm subtype information from:doi:10.1016/j.cell.2015.12.028
```