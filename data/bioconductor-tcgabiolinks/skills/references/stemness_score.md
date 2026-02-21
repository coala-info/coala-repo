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

# Stemness score

## Calculate stemness score with `TCGAanalyze_Stemness`

---

If you use this function please also cite:

**Malta TM, Sokolov A, Gentles AJ, et al. Machine Learning Identifies Stemness Features Associated with Oncogenic Dedifferentiation. Cell. 2018;173(2):338-354.e15.** (doi:10.1016/j.cell.2018.03.034)

## Data

---

The input data are: - a matrix (samples as columns, Gene names as rows) - the signature to calculate the correlation score.

Possible scores are:

* SC\_PCBC\_stemSig - Stemness Score
* DE\_PCBC\_stemSig - endoderm score
* EB\_PCBC\_stemSig - embryoid bodies score
* ECTO\_PCBC\_stemSig - ectoderm score
* MESO\_PCBC\_stemSig - mesoderm score

# Function

```
# Selecting TCGA breast cancer (10 samples) for example stored in dataBRCA
dataNorm <- TCGAanalyze_Normalization(
    tabDF = dataBRCA,
    geneInfo =  geneInfo
)

# quantile filter of genes
dataFilt <- TCGAanalyze_Filtering(
  tabDF = dataNorm,
  method = "quantile",
  qnt.cut =  0.25
)

data(SC_PCBC_stemSig)
Stemness_score <- TCGAanalyze_Stemness(
  stemSig = SC_PCBC_stemSig,
  dataGE = dataFilt
)
data(ECTO_PCBC_stemSig)
ECTO_score <- TCGAanalyze_Stemness(
  stemSig = ECTO_PCBC_stemSig,
  dataGE = dataFilt,
  colname.score = "ECTO_PCBC_stem_score"
)

data(MESO_PCBC_stemSig)
MESO_score <- TCGAanalyze_Stemness(
  stemSig = MESO_PCBC_stemSig,
  dataGE = dataFilt,
  colname.score = "MESO_PCBC_stem_score"
)
```

# Output

```
head(Stemness_score)
```

```
head(ECTO_score)
```

```
head(MESO_score)
```