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

# TCGAbiolinks: Searching GDC database

#### 30 October 2025

**TCGAbiolinks** has provided a few functions to search GDC database.

---

# Useful information

Understanding the barcode

A TCGA barcode is composed of a collection of identifiers. Each specifically identifies a TCGA data element. Refer to the following figure for an illustration of how metadata identifiers comprise a barcode. An aliquot barcode contains the highest number of identifiers.

Example:

* Aliquot barcode: TCGA-G4-6317-02A-11D-2064-05
* Participant: TCGA-G4-6317
* Sample: TCGA-G4-6317-02

For more information check [GDC TCGA barcodes](https://docs.gdc.cancer.gov/Encyclopedia/pages/TCGA_Barcode/)

# Searching arguments

You can easily search GDC data using the `GDCquery` function.

Using a summary of filters as used in the TCGA portal, the function works with the following arguments:

| ?project | A list of valid project (see table below)] |  |
| --- | --- | --- |
| data.category | A valid project (see list with TCGAbiolinks:::getProjectSummary(project)) |  |
| data.type | A data type to filter the files to download |  |
| workflow.type | GDC workflow type |  |
| access | Filter by access type. Possible values: controlled, open |  |
| platform | Example: |  |
|  | CGH- 1x1M\_G4447A | IlluminaGA\_RNASeqV2 |
|  | AgilentG4502A\_07 | IlluminaGA\_mRNA\_DGE |
|  | Human1MDuo | HumanMethylation450 |
|  | HG-CGH-415K\_G4124A | IlluminaGA\_miRNASeq |
|  | HumanHap550 | IlluminaHiSeq\_miRNASeq |
|  | ABI | H-miRNA\_8x15K |
|  | HG-CGH-244A | SOLiD\_DNASeq |
|  | IlluminaDNAMethylation\_OMA003\_CPI | IlluminaGA\_DNASeq\_automated |
|  | IlluminaDNAMethylation\_OMA002\_CPI | HG-U133\_Plus\_2 |
|  | HuEx- 1\_0-st-v2 | Mixed\_DNASeq |
|  | H-miRNA\_8x15Kv2 | IlluminaGA\_DNASeq\_curated |
|  | MDA\_RPPA\_Core | IlluminaHiSeq\_TotalRNASeqV2 |
|  | HT\_HG-U133A | IlluminaHiSeq\_DNASeq\_automated |
|  | diagnostic\_images | microsat\_i |
|  | IlluminaHiSeq\_RNASeq | SOLiD\_DNASeq\_curated |
|  | IlluminaHiSeq\_DNASeqC | Mixed\_DNASeq\_curated |
|  | IlluminaGA\_RNASeq | IlluminaGA\_DNASeq\_Cont\_automated |
|  | IlluminaGA\_DNASeq | IlluminaHiSeq\_WGBS |
|  | pathology\_reports | IlluminaHiSeq\_DNASeq\_Cont\_automated |
|  | Genome\_Wide\_SNP\_6 | bio |
|  | tissue\_images | Mixed\_DNASeq\_automated |
|  | HumanMethylation27 | Mixed\_DNASeq\_Cont\_curated |
|  | IlluminaHiSeq\_RNASeqV2 | Mixed\_DNASeq\_Cont |
| file.type | To be used in the legacy database for some platforms, to define which file types to be used. |  |
| barcode | A list of barcodes to filter the files to download |  |
| experimental.strategy | Filter to experimental strategy. Harmonized: WXS, RNA-Seq, miRNA-Seq, Genotyping Array. |  |
| sample.type | A sample type to filter the files to download |  |

## project options

The options for the field `project` are below:

## sample.type options

The options for the field `sample.type` are below:

The other fields (data.category, data.type, workflow.type, platform, file.type) can be found below. Please, note that these tables are still incomplete.

## Harmonized data options

# Harmonized database examples

## DNA methylation data: Recurrent tumor samples

In this example we will access the harmonized database and search for all DNA methylation data for recurrent glioblastoma multiform (GBM) and low grade gliomas (LGG) samples.

```
query <- GDCquery(
    project = c("TCGA-GBM", "TCGA-LGG"),
    data.category = "DNA Methylation",
    platform = c("Illumina Human Methylation 450"),
    sample.type = "Recurrent Tumor"
)
datatable(
    getResults(query),
    filter = 'top',
    options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
    rownames = FALSE
)
```

## Samples with DNA methylation and gene expression data

In this example we will access the harmonized database and search for all patients with DNA methylation (platform HumanMethylation450k) and gene expression data for Colon Adenocarcinoma tumor (TCGA-COAD).

```
query_met <- GDCquery(
    project = "TCGA-COAD",
    data.category = "DNA Methylation",
    platform = c("Illumina Human Methylation 450")
)
query_exp <- GDCquery(
    project = "TCGA-COAD",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts"
)

# Get all patients that have DNA methylation and gene expression.
common.patients <- intersect(
    substr(getResults(query_met, cols = "cases"), 1, 12),
    substr(getResults(query_exp, cols = "cases"), 1, 12)
)

# Only select the first 5 patients
query_met <- GDCquery(
    project = "TCGA-COAD",
    data.category = "DNA Methylation",
    platform = c("Illumina Human Methylation 450"),
    barcode = common.patients[1:5]
)

query_exp <- GDCquery(
    project = "TCGA-COAD",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts",
    barcode = common.patients[1:5]
)
```

```
datatable(
    getResults(query_met, cols = c("data_type","cases")),
    filter = 'top',
    options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
    rownames = FALSE
)
datatable(
    getResults(query_exp, cols = c("data_type","cases")),
    filter = 'top',
    options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
    rownames = FALSE
)
```

## Raw Sequencing Data: Finding the match between file names and barcode for Controlled data.

This example shows how the user can search for breast cancer Raw Sequencing Data (“Controlled”) and verify the name of the files and the barcodes associated with it.

```
query <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Sequencing Reads",
    data.type = "Aligned Reads",
    data.format = "bam",
    workflow.type = "STAR 2-Pass Transcriptome"
)
# Only first 10 to make render faster
datatable(
    getResults(query, rows = 1:10,cols = c("file_name","cases")),
    filter = 'top',
    options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
    rownames = FALSE
)
```

```
query <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Sequencing Reads",
    data.type = "Aligned Reads",
    data.format = "bam",
    workflow.type = "STAR 2-Pass Genome"
)
# Only first 10 to make render faster
datatable(
    getResults(query, rows = 1:10,cols = c("file_name","cases")),
    filter = 'top',
    options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
    rownames = FALSE
)
```

```
query <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Sequencing Reads",
    data.type = "Aligned Reads",
    data.format = "bam",
    workflow.type = "STAR 2-Pass Chimeric"
)
# Only first 10 to make render faster
datatable(
    getResults(query, rows = 1:10,cols = c("file_name","cases")),
    filter = 'top',
    options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
    rownames = FALSE
)
```

```
query <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Sequencing Reads",
    data.type = "Aligned Reads",
    data.format = "bam",
    workflow.type = "BWA-aln"
)
# Only first 10 to make render faster
datatable(
    getResults(query, rows = 1:10,cols = c("file_name","cases")),
    filter = 'top',
    options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
    rownames = FALSE
)
```

```
query <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Sequencing Reads",
    data.type = "Aligned Reads",
    data.format = "bam",
    workflow.type = "BWA with Mark Duplicates and BQSR"
)
# Only first 10 to make render faster
datatable(
    getResults(query, rows = 1:10,cols = c("file_name","cases")),
    filter = 'top',
    options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
    rownames = FALSE
)
```

# Get Manifest file

If you want to get the manifest file from the query object you can use the function *getManifest*. If you set save to `TRUE` a txt file that can be used with GDC-client Data transfer tool (DTT) or with its GUI version [ddt-ui](https://github.com/NCI-GDC/dtt-ui) will be created.

```
getManifest(query, save = FALSE)
```

# ATAC-seq data

For the moment, ATAC-seq data is available at the [GDC publication page](https://gdc.cancer.gov/about-data/publications/ATACseq-AWG). Also, for more details, you can check an ATAC-seq workshop at <http://rpubs.com/tiagochst/atac_seq_workshop>

The list of file available is below:

```
datatable(
    getResults(TCGAbiolinks:::GDCquery_ATAC_seq())[,c("file_name","file_size")],
    filter = 'top',
    options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
    rownames = FALSE
)
```

You can use the function `GDCquery_ATAC_seq` filter the manifest table and use `GDCdownload` to save the data locally.

```
query <- TCGAbiolinks:::GDCquery_ATAC_seq(file.type = "rds")
GDCdownload(query, method = "client")

query <- TCGAbiolinks:::GDCquery_ATAC_seq(file.type = "bigWigs")
GDCdownload(query, method = "client")
```

# Summary of available files per patient

Retrieve the numner of files under each data\_category + data\_type + experimental\_strategy + platform. Almost like <https://portal.gdc.cancer.gov/exploration>

```
tab <-  getSampleFilesSummary(project = "TCGA-ACC")
datatable(
    head(tab),
    filter = 'top',
    options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
    rownames = FALSE
)
```