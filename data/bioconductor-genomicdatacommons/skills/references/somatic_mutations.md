# Working with simple somatic mutations

Sean Davis

#### Sunday, November 09, 2025

# 1 Background

# 2 Workflow

```
library(GenomicDataCommons)
library(tibble)
```

## 2.1 Genes and gene details

```
grep_fields('genes', 'symbol')
```

```
## [1] "symbol"
```

```
head(available_values('genes','symbol'))
```

```
## [1] "y_rna"  "actl10" "matr3"  "a1bg"   "a1cf"   "a2m"
```

```
tp53 = genes() |>
  GenomicDataCommons::filter(symbol=='TP53') |>
  results(size=10000) |>
  as_tibble()
```

## 2.2 ssms

```
ssms() |>
    GenomicDataCommons::filter(
      chromosome==paste0('chr',tp53$gene_chromosome[1]) &
        start_position > tp53$gene_start[1] &
        end_position < tp53$gene_end[1]) |>
    GenomicDataCommons::count()
```

```
## [1] 1388
```

```
ssms() |>
    GenomicDataCommons::filter(
      consequence.transcript.gene.symbol %in% c('TP53')) |>
    GenomicDataCommons::count()
```

```
## [1] 1385
```

## 2.3 convert to VRanges

```
library(VariantAnnotation)
vars = ssms() |>
    GenomicDataCommons::filter(
      consequence.transcript.gene.symbol %in% c('TP53')) |>
    GenomicDataCommons::results_all() |>
    as_tibble()
```

```
vr = VRanges(seqnames = vars$chromosome,
             ranges = IRanges(start=vars$start_position, width=1),
             ref = vars$reference_allele,
             alt = vars$tumor_allele)
```

```
ssm_occurrences() |>
    GenomicDataCommons::filter(
      ssm.consequence.transcript.gene.symbol %in% c('TP53')) |>
    GenomicDataCommons::count()
```

```
## [1] 5645
```

```
var_samples = ssm_occurrences() |>
    GenomicDataCommons::filter(
      ssm.consequence.transcript.gene.symbol %in% c('TP53')) |>
    GenomicDataCommons::expand(c('case', 'ssm', 'case.project')) |>
    GenomicDataCommons::results_all() |>
    as_tibble()
```

```
table(var_samples$case$disease_type)
```

```
##
##                       Acinar Cell Neoplasms
##                                          27
##                Acute Lymphoblastic Leukemia
##                                          22
##                Adenomas and Adenocarcinomas
##                                        1803
##        Adnexal and Skin Appendage Neoplasms
##                                           1
##                        Basal Cell Neoplasms
##                                           1
##                Complex Epithelial Neoplasms
##                                          16
##         Complex Mixed and Stromal Neoplasms
##                                          72
##       Cystic, Mucinous and Serous Neoplasms
##                                         624
##                Ductal and Lobular Neoplasms
##                                         666
##                   Epithelial Neoplasms, NOS
##                                          22
##                       Fibromatous Neoplasms
##                                          12
##                         Germ Cell Neoplasms
##                                           1
##                                     Gliomas
##                                         543
##                        Lipomatous Neoplasms
##                                           7
##                          Lymphoid Leukemias
##                                          23
##                     Mature B-Cell Lymphomas
##                                          26
##                       Mesothelial Neoplasms
##                                          11
##                   Miscellaneous Bone Tumors
##                                           1
##                   Myelodysplastic Syndromes
##                                           3
##                           Myeloid Leukemias
##                                          32
##                         Myomatous Neoplasms
##                                          59
##                              Neoplasms, NOS
##                                           9
##                         Nerve Sheath Tumors
##                                           1
##                          Nevi and Melanomas
##                                          98
##                                Not Reported
##                                           6
##         Osseous and Chondromatous Neoplasms
##                                          21
##                          Plasma Cell Tumors
##                                          53
##        Soft Tissue Tumors and Sarcomas, NOS
##                                          33
##                     Squamous Cell Neoplasms
##                                        1217
##                 Thymic Epithelial Neoplasms
##                                           4
## Transitional Cell Papillomas and Carcinomas
##                                         231
```

## 2.4 OncoPrint

```
fnames <- files() |>
  GenomicDataCommons::filter(
    cases.project.project_id=='TCGA-SKCM' &
      data_format=='maf' &
      data_type=='Masked Somatic Mutation' &
      analysis.workflow_type ==
        'Aliquot Ensemble Somatic Variant Merging and Masking'
  ) |>
  results(size = 1) |>
    ids() |>
      gdcdata()
```

```
library(maftools)
melanoma = read.maf(maf = fnames)
```

```
## -Reading
## -Validating
## -Silent variants: 36
## -Summarizing
## -Processing clinical data
## --Missing clinical data
## -Finished in 0.360s elapsed (0.337s cpu)
```

```
maftools::oncoplot(melanoma)
```

```
## Warning in min(x): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x): no non-missing arguments to max; returning -Inf
```

![](data:image/png;base64...)