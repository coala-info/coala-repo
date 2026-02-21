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

# TCGAbiolinks: Downloading and preparing files for analysis

#### 30 October 2025

**TCGAbiolinks** has provided a few functions to download and prepare data from GDC for analysis. This section starts by explaining the different downloads methods and the SummarizedExperiment object, which is the default data structure used in TCGAbiolinks, followed by some examples.

---

# Downloading and preparing data for analysis

Data download: Methods differences

There are two methods to download GDC data using TCGAbiolinks:

* `client`: this method creates a MANIFEST file and downloads the data using [GDC Data Transfer Tool](https://gdc.cancer.gov/access-data/gdc-data-transfer-tool) this method is more reliable but it might be slower compared to the api method.
* `api`: this method uses the [GDC Application Programming Interface (API)](https://gdc.cancer.gov/developers/gdc-application-programming-interface-api) to download the data. This will create a MANIFEST file and the data downloaded will be compressed into a tar.gz file. If the size and the number of the files are too big this tar.gz will be too big which might have a high probability of download failure. To solve that we created the `files.per.chunk` argument which will split the files into small chunks, for example, if `chunks.per.download` is equal to 10 we will download only 10 files inside each tar.gz.

Data prepared: SummarizedExperiment object

A [SummarizedExperiment object](http://www.nature.com/nmeth/journal/v12/n2/fig_tab/nmeth.3252_F2.html) has three main matrices that can be accessed using the [SummarizedExperiment package](http://bioconductor.org/packages/SummarizedExperiment/)):

* Sample matrix information is accessed via `colData(data)`: stores sample information. TCGAbiolinks will add indexed clinical data and subtype information from marker TCGA papers.
* Assay matrix information is accessed via `assay(data)`: stores molecular data
* Feature matrix information (gene information) is accessed via `rowRanges(data)`: stores metadata about the features, including their genomic ranges

Summarized Experiment: annotation information

When using the function `GDCprepare` there is an argument called `SummarizedExperiment` which defines the output type a Summarized Experiment (default option) or a data frame. To create a summarized Experiment object we annotate the data with genomic positions with last patch release version of the genome available.

Also, the latest DNA methylation metadata is available at: <http://zwdzwd.github.io/InfiniumAnnotation>

simpleWarning in file.create(to[okay]) error

If you received the warning/error `simpleWarning in file.create(to[okay])` try setting `directory` as described by some users: <https://github.com/BioinformaticsFMRP/TCGAbiolinks/issues/153#issuecomment-856385673>

in `GDCprepare` and `GDCdownload`

```
<simpleWarning in file.create(to[okay]): cannot create file ... reason 'No such file or directory'>
```

## Arguments

### `GDCdownload`

| Argument | Description |
| --- | --- |
| query | A query for GDCquery function |
| token.file | Token file to download controlled data (only for method = “client”) |
| method | Uses the API (POST method) or gdc client tool. Options “api”, “client”. API is faster, but the data might get corrupted in the download, and it might need to be executed again |
| directory | Directory/Folder where the data was downloaded. Default: GDCdata |
| files.per.chunk | This will make the API method only download n (files.per.chunk) files at a time. This may reduce the download problems when the data size is too large. Expected a integer number (example files.per.chunk = 6) |

### `GDCprepare`

| Argument | Description |
| --- | --- |
| query | A query for GDCquery function |
| save | Save result as RData object? |
| save.filename | Name of the file to be save if empty an automatic will be created |
| directory | Directory/Folder where the data was downloaded. Default: GDCdata |
| summarizedExperiment | Create a summarizedExperiment? Default TRUE (if possible) |
| remove.files.prepared | Remove the files read? Default: FALSE This argument will be considered only if save argument is set to true |
| add.gistic2.mut | If a list of genes (gene symbol) is given, columns with gistic2 results from GDAC firehose (hg19) and a column indicating if there is or not mutation in that gene (hg38) (TRUE or FALSE - use the MAF file for more information) will be added to the sample matrix in the summarized Experiment object. |
| mut.pipeline | If add.gistic2.mut is not NULL this field will be taken in consideration. Four separate variant calling pipelines are implemented for GDC data harmonization. Options: muse, varscan2, somaticsniper, MuTect2. For more information: <https://gdc-docs.nci.nih.gov/Data/Bioinformatics_Pipelines/DNA_Seq_Variant_Calling_Pipeline/> |
| mutant\_variant\_classification | List of mutant\_variant\_classification that will be consider a sample mutant or not. Default: “Frame\_Shift\_Del”, “Frame\_Shift\_Ins”, “Missense\_Mutation”, “Nonsense\_Mutation”, “Splice\_Site”, “In\_Frame\_Del”, “In\_Frame\_Ins”, “Translation\_Start\_Site”, “Nonstop\_Mutation” |

## Search and download data for two samples from database

In this example we will download gene expression quantification from harmonized database (data aligned against genome of reference hg38). Also, it shows the object data and metadata.

```
# Gene expression aligned against hg38
query <- GDCquery(
    project = "TCGA-GBM",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts",
    barcode = c("TCGA-14-0736-02A-01R-2005-01", "TCGA-06-0211-02A-02R-2005-01")
)
GDCdownload(query = query)
data <- GDCprepare(query = query)
```

```
datatable(
    as.data.frame(colData(data)),
    options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
    rownames = FALSE
)
```

```
datatable(
    assay(data)[1:20,],
    options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
    rownames = TRUE
)
```

```
rowRanges(data)
```

```
## GRanges object with 100 ranges and 3 metadata columns:
##                   seqnames              ranges strand | ensembl_gene_id
##                      <Rle>           <IRanges>  <Rle> |     <character>
##   ENSG00000000003     chrX 100627109-100639991      - | ENSG00000000003
##   ENSG00000000005     chrX 100584802-100599885      + | ENSG00000000005
##   ENSG00000000419    chr20   50934867-50958555      - | ENSG00000000419
##   ENSG00000000457     chr1 169849631-169894267      - | ENSG00000000457
##   ENSG00000000460     chr1 169662007-169854080      + | ENSG00000000460
##               ...      ...                 ...    ... .             ...
##   ENSG00000005421     chr7   95297676-95324707      - | ENSG00000005421
##   ENSG00000005436     chr2   75652000-75710989      - | ENSG00000005436
##   ENSG00000005448     chr2   74421678-74425755      + | ENSG00000005448
##   ENSG00000005469     chr7   87345681-87399795      + | ENSG00000005469
##   ENSG00000005471     chr7   87401697-87480435      - | ENSG00000005471
##                   external_gene_name original_ensembl_gene_id
##                          <character>              <character>
##   ENSG00000000003             TSPAN6       ENSG00000000003.13
##   ENSG00000000005               TNMD        ENSG00000000005.5
##   ENSG00000000419               DPM1       ENSG00000000419.11
##   ENSG00000000457              SCYL3       ENSG00000000457.12
##   ENSG00000000460           C1orf112       ENSG00000000460.15
##               ...                ...                      ...
##   ENSG00000005421               PON1        ENSG00000005421.7
##   ENSG00000005436              GCFC2       ENSG00000005436.12
##   ENSG00000005448              WDR54       ENSG00000005448.15
##   ENSG00000005469               CROT       ENSG00000005469.10
##   ENSG00000005471              ABCB4       ENSG00000005471.14
##   -------
##   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

# `GDCprepare`: Outputs

This function is still under development, it is not working for all cases. See the tables below with the status. Examples of query, download, prepare can be found in this [gist](https://gist.github.com/tiagochst/a701bad3fa3800ade7063760755e0aad).

## Harmonized data

| Data.category | Data.type | Workflow Type | Output |
| --- | --- | --- | --- |
| Transcriptome Profiling | Gene Expression Quantification | STAR - Counts | Dataframe or SummarizedExperiment |
|  | Isoform Expression Quantification | Not needed |  |
|  | miRNA Expression Quantification | Not needed | Dataframe |
| Copy number variation | Copy Number Segment |  | Dataframe |
|  | Masked Copy Number Segment |  | Dataframe |
|  | Gene Level Copy Number |  | Dataframe |
| DNA Methylation | Methylation Beta Value |  | Dataframe or SummarizedExperiment |
| Simple Nucleotide Variation | Masked Somatic Mutation |  | Dataframe |
| Raw Sequencing Data |  |  |  |
| Biospecimen | Slide Image |  |  |
| Biospecimen | Biospecimen Supplement |  |  |
| Clinical |  |  |  |

# Examples

## Harmonized database: data aligned against hg38

### Copy Number Variation

#### Copy Number Segment

```
query <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Copy Number Variation",
    data.type = "Copy Number Segment",
    barcode = c( "TCGA-OR-A5KU-01A-11D-A29H-01", "TCGA-OR-A5JK-01A-11D-A29H-01")
)
GDCdownload(query)
data <- GDCprepare(query)
```

#### Gene Level Copy Number

```
query <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Copy Number Variation",
    data.type = "Gene Level Copy Number",
    access = "open"
)
GDCdownload(query)
data <- GDCprepare(query)
```

#### Allele-specific Copy Number Segment

```
query <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Copy Number Variation",
    data.type = "Allele-specific Copy Number Segment",
    access = "open"
)
GDCdownload(query)
data <- GDCprepare(query)
```

#### Masked Copy Number Segment

```
query <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Copy Number Variation",
    data.type = "Masked Copy Number Segment",
    access = "open"
)
GDCdownload(query)
data <- GDCprepare(query)
```

### Transcriptome Profiling

#### Gene Expression Quantification

For more examples, please check: <http://rpubs.com/tiagochst/TCGAbiolinks_RNA-seq_new_projects>

```
# mRNA pipeline: https://gdc-docs.nci.nih.gov/Data/Bioinformatics_Pipelines/Expression_mRNA_Pipeline/
query.exp.hg38 <- GDCquery(
    project = "TCGA-GBM",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts",
    barcode =  c("TCGA-14-0736-02A-01R-2005-01", "TCGA-06-0211-02A-02R-2005-01")
)
GDCdownload(query.exp.hg38)
expdat <- GDCprepare(
    query = query.exp.hg38,
    save = TRUE,
    save.filename = "exp.rda"
)
```

#### miRNA Expression Quantification

```
library(TCGAbiolinks)
query.mirna <- GDCquery(
    project = "TARGET-AML",
    experimental.strategy = "miRNA-Seq",
    data.category = "Transcriptome Profiling",
    barcode = c("TARGET-20-PATDNN","TARGET-20-PAPUNR"),
    data.type = "miRNA Expression Quantification"
)
GDCdownload(query.mirna)
mirna <- GDCprepare(
    query = query.mirna,
    save = TRUE,
    save.filename = "mirna.rda"
)
```

#### Isoform Expression Quantification

```
query.isoform <- GDCquery(
    project = "TARGET-AML",
    experimental.strategy = "miRNA-Seq",
    data.category = "Transcriptome Profiling",
    barcode = c("TARGET-20-PATDNN","TARGET-20-PAPUNR"),
    data.type = "Isoform Expression Quantification"
)
GDCdownload(query.isoform)

isoform <- GDCprepare(
    query = query.isoform,
    save = TRUE,
    save.filename = "mirna-isoform.rda"
)
```

### DNA methylation

#### Beta-values

```
query_met.hg38 <- GDCquery(
    project = "TCGA-BRCA",
    data.category = "DNA Methylation",
    data.type = "Methylation Beta Value",
    platform = "Illumina Human Methylation 27",
    barcode = c("TCGA-B6-A0IM")
)
GDCdownload(query_met.hg38)
data.hg38 <- GDCprepare(query_met.hg38)

query_met.hg38 <- GDCquery(
    project= "TCGA-LGG",
    data.category = "DNA Methylation",
    data.type = "Methylation Beta Value",
    platform = "Illumina Human Methylation 450",
    barcode = c("TCGA-HT-8111-01A-11D-2399-05","TCGA-HT-A5R5-01A-11D-A28N-05")
)
GDCdownload(query_met.hg38)
data.hg38 <- GDCprepare(query_met.hg38)

query_met.hg38 <- GDCquery(
    project= "HCMI-CMDC",
    data.category = "DNA Methylation",
    data.type = "Methylation Beta Value",
    platform = "Illumina Methylation Epic",
    barcode = c("HCM-BROD-0045")
)
GDCdownload(query_met.hg38)
data.hg38 <- GDCprepare(query_met.hg38)
```

#### IDAT files

```
query <- GDCquery(
    project = "TCGA-BRCA",
    data.category = "DNA Methylation",
    data.type = "Masked Intensities",
    platform = "Illumina Human Methylation 27"
)
GDCdownload(query, files.per.chunk=10)
betas <- GDCprepare(query)

query <- GDCquery(
    project = "HCMI-CMDC",
    data.category = "DNA Methylation",
    data.type = "Masked Intensities",
    platform = "Illumina Methylation Epic"
)
GDCdownload(query, files.per.chunk = 10)
betas <- GDCprepare(query)

query <- GDCquery(
    project = "CPTAC-3",
    data.category = "DNA Methylation",
    data.type = "Masked Intensities",
    platform = "Illumina Methylation Epic"
)
GDCdownload(query, files.per.chunk=10)
betas <- GDCprepare(query)

query <- GDCquery(
    project = "TCGA-BRCA",
    data.category = "DNA Methylation",
    data.type = "Masked Intensities",
    platform = "Illumina Methylation Epic"
)
GDCdownload(query, files.per.chunk = 10)
betas <- GDCprepare(query)
```

### Proteome Profiling

#### Protein Expression Quantification

```
query.rppa <- GDCquery(
    project = "TCGA-ESCA",
    data.category = "Proteome Profiling",
    data.type = "Protein Expression Quantification"
)
GDCdownload(query.rppa)
rppa <- GDCprepare(query.rppa)
```

### Clinical

```
query <- GDCquery(
    project = "TCGA-COAD",
    data.category = "Clinical",
    data.type = "Clinical Supplement",
    data.format = "BCR XML",
    barcode = "TCGA-A6-5664"
)
GDCdownload(query)
drug <- GDCprepare_clinic(query,"drug")

query <- GDCquery(
    project = "TCGA-COAD",
    data.category = "Clinical",
    data.type = "Clinical Supplement",
    data.format = "BCR OMF XML",
    barcode = "TCGA-AD-6964"
)
GDCdownload(query)

query <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Clinical",
    data.type = "Clinical Supplement",
    data.format = "BCR Biotab"
)
GDCdownload(query)
clinical.BCRtab.all <- GDCprepare(query)
names(clinical.BCRtab.all)

query <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Clinical",
    data.type = "Clinical Supplement",
    data.format = "BCR Biotab",
    file.type = "radiation"
)
GDCdownload(query)
clinical.BCRtab.radiation <- GDCprepare(query)
```

### Simple Nucleotide Variation

#### Masked Somatic Mutation

For more information please check: <https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipelines/DNA_Seq_Variant_Calling_Pipeline/>

```
query <- GDCquery(
    project = "TCGA-HNSC",
    data.category = "Simple Nucleotide Variation",
    data.type = "Masked Somatic Mutation",
    access = "open"
)
GDCdownload(query)
maf <- GDCprepare(query)
```

### Single cell

GDC Single Cell RNA-Seq information: <https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipelines/Expression_mRNA_Pipeline/#scrna-seq-pipeline-single-nuclei>

```
query.sc.analysis <- GDCquery(
    project = "CPTAC-3",
    data.category = "Transcriptome Profiling",
    access = "open",
    data.type = "Single Cell Analysis",
    data.format =  "TSV"
)
GDCdownload(query.sc.analysis)
Single.Cell.Analysis.list <- GDCprepare(query.sc.analysis)
```

```
query.raw.counts <- GDCquery(
    project = "CPTAC-3",
    data.category = "Transcriptome Profiling",
    access = "open",
    data.type = "Gene Expression Quantification",
    barcode = c("CPT0167860015","CPT0206880004"),
    workflow.type = "CellRanger - 10x Raw Counts"
)
GDCdownload(query.raw.counts)
raw.counts.list <- GDCprepare(query.raw.counts)
```

```
query.filtered.counts <- GDCquery(
    project = "CPTAC-3",
    data.category = "Transcriptome Profiling",
    access = "open",
    data.type = "Gene Expression Quantification",
    barcode = c("CPT0167860015","CPT0206880004"),
    workflow.type = "CellRanger - 10x Filtered Counts"
)
GDCdownload(query.filtered.counts)
filtered.counts.list <- GDCprepare(query.filtered.counts)
```

```
query.sc.dea <- GDCquery(
    project = "CPTAC-3",
    data.category = "Transcriptome Profiling",
    access = "open",
    data.type = "Differential Gene Expression",
    barcode = c("CPT0167860015","CPT0206880004"),
    workflow.type = "Seurat - 10x Chromium"
)
GDCdownload(query.sc.dea)
sc.dea.list <- GDCprepare(query.sc.dea)
```