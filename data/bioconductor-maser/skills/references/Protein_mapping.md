# Mapping protein features to splicing events

Diogo Veiga

#### 2025-10-30

#### Package

maser 1.28.0

# 1 Overview of protein annotation

In this vignette, we describe a *maser* workflow for annotation and visualization of protein features affected by splicing.

Integration of protein features to splicing events may reveal the impact of alternative splicing on protein function. We developed *maser* to enable systematic mapping of protein annotation from [UniprotKB](http://www.uniprot.org/) to splicing events.

Protein features can be annotated and visualized along with transcripts affected by the splice event. In this manner, *maser* can identify whether the splicing is affecting regions of interest containing known domains or motifs, mutations, post-translational modification and other described protein structural features.

# 2 Annotation of protein features

## 2.1 Creating the maser object

We illustrate the workflow using the hypoxia dataset from the previous vignette.

```
library(maser)
library(rtracklayer)

# Creating maser object using hypoxia dataset
path <- system.file("extdata", file.path("MATS_output"),
                    package = "maser")
hypoxia <- maser(path, c("Hypoxia 0h", "Hypoxia 24h"))

# Remove low coverage events
hypoxia_filt <- filterByCoverage(hypoxia, avg_reads = 5)
```

## 2.2 Query available protein features at Uniprot

Available UniprotKB protein annotation can be queried using `availableFeaturesUniprotKB()`. Currently there are 30 distinct features grouped into broader categories, including *Domain and Sites, PTM (Post-translational modifications), Molecule Processing, Topology, Mutagenesis and Structural Features*.

| Name | Description | Category |
| --- | --- | --- |
| DNA-bind | UniProtKB DNA binding site sequence annotations | Domain\_and\_Sites |
| Zn-fing | UniProtKB Zinc finger sequence annotations | Domain\_and\_Sites |
| act-site | UniProtKB active site sequence annotations | Domain\_and\_Sites |
| binding | UniProtKB binding site sequence annotations | Domain\_and\_Sites |
| coiled | UniProtKB coiled coil sequence annotations | Domain\_and\_Sites |
| domain | UniProtKB domain sequence annotations | Domain\_and\_Sites |
| motif | UniProtKB motif of interest sequence annotations | Domain\_and\_Sites |
| region | UniProtKB region of interest sequence annotations | Domain\_and\_Sites |
| repeat | UniProtKB repeated motifs or domains sequence annotations | Domain\_and\_Sites |
| site | UniProtKB single amino acid site sequence annotations | Domain\_and\_Sites |

## 2.3 Steps for annotation

Protein feature annotation of splicing events is performed in two steps.

1. Use `mapTranscriptsToEvents()` to add both transcript and protein IDs to all events in the maser object.
2. Use `mapProteinFeaturesToEvents()` for annotation specifying UniprotKB features or categories.

`mapTranscriptsToEvents()` identifies transcripts compatible with the splicing event by overlapping exons involved in splicing to the gene models provided in the Ensembl GTF. Each type of splice event applies a specific overlapping rule (described in the Introduction vignette). The function also maps transcripts to their corresponding protein identifiers in Uniprot when available.

`mapTranscriptsToEvents()` requires an Ensembl or Gencode GTF using the hg38 build of the human genome. Ensembl GTFs can be retrieved using *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* or imported using `import.gff()` from the *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* package. Several GTF releases are available, and *maser* is compatible with any version using the hg38 build.

We are using reduced GTF extracted from Ensembl Release 85 for running examples.

```
## Ensembl GTF annotation
gtf_path <- system.file("extdata", file.path("GTF","Ensembl85_examples.gtf.gz"),
                        package = "maser")
ens_gtf <- rtracklayer::import.gff(gtf_path)
```

In the second step, `mapProteinFeaturesToEvents()` retrieves data from UniprotKB and overlaps splicing events to genomic coordinates of protein features.

## 2.4 SRSF6 example

The splicing factor SRSF6 undergoes splicing during hypoxia by expressing an alternative exon. We will annotate the exon skipping event with domain, sites and topology information. The first step is to obtain a maser object containing SRSF6 splicing information, and then map transcripts to splicing events.

```
# Retrieve gene specific splicing events
srsf6_events <- geneEvents(hypoxia_filt, "SRSF6")
srsf6_events
#> A Maser object with 1 splicing events.
#>
#> Samples description:
#> Label=Hypoxia 0h     n=3 replicates
#> Label=Hypoxia 24h     n=3 replicates
#>
#> Splicing events:
#> A3SS.......... 0 events
#> A5SS.......... 0 events
#> SE.......... 1 events
#> RI.......... 0 events
#> MXE.......... 0 events
```

```
# Map transcripts to splicing events
srsf6_mapped <- mapTranscriptsToEvents(srsf6_events, ens_gtf)
```

If transcript mapping worked correctly, Ensembl and Uniprot identifiers will be added to splicing events. Possible `NA` values indicates non-protein coding transcripts. In this case, the splicing involves two Ensembl transcripts coding for the Q13247 isoform of SRSF6.

```
head(annotation(srsf6_mapped, "SE"))
```

| ID | GeneID | geneSymbol | txn\_3exons | txn\_2exons | list\_ptn\_a | list\_ptn\_b |
| --- | --- | --- | --- | --- | --- | --- |
| 33209 | ENSG00000124193.14 | SRSF6 | ENST00000483871 | ENST00000244020 | Q13247 | Q13247 |

Now we are ready to call `mapProteinFeaturesToEvents()` for annotation. Feature annotation can be interactively displayed in a web browser using `display()` or retrieved as a `data.frame` using `annotation()`.

`mapProteinFeaturesToEvents()` will add extra columns describing the feature name, feature description and protein identifiers for which the annotation has been assigned. Possible `NA` values indicate the particular feature is not annotated for the splice event.

```
# Annotate splicing events with protein features
srsf6_annot <- mapProteinFeaturesToEvents(srsf6_mapped, c("Domain_and_Sites", "Topology"), by="category")
```

```
head(annotation(srsf6_annot, "SE"))
```

| ID | GeneID | geneSymbol | txn\_3exons | txn\_2exons | list\_ptn\_a | list\_ptn\_b | DNA-bind | Zn-fing | act-site | binding | coiled | domain | motif | region | repeat | site | intramem | topo-dom | transmem |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 33209 | ENSG00000124193.14 | SRSF6 | ENST00000483871 | ENST00000244020 | Q13247 | Q13247 | NA | NA | NA | NA | NA | Q13247:M1-G72;RRM1,A0A590UJK4:P2-G72;RRM,A0A590UJP7:P2-G72;RRM,A0A590UK01:P2-G72;RRM,A0A590UK80:X1-G66;RRM,A0A590UJK4:Y110-P183;RRM,A0A590UJP7:Y110-P183;RRM,A0A590UK01:Y110-P183;RRM,Q13247:Y110-P183;RRM2,A0A590UK80:Y104-P177;RRM | NA | A0A590UJK4:R75-G103;Disordered,A0A590UJP7:R75-G103;Disordered,A0A590UK01:R75-G103;Disordered,Q13247:R75-G103;Disordered,A0A590UK80:R69-G97;Disordered | NA | NA | NA | NA | NA |

By inspecting the results, we see that the SRSF6 exon skipping event is annotated with the Uniprot features **domain, chain and mod-res (modidifed residue)**. Visualization of the splice event, transcripts and protein features is performed with `plotUniprotKBFeatures()`. In this example, exons in the splice event overlap the Serine/arginine-rich splicing factor 6 region of the protein, while the upstream exon and downstream exons are overlapping the RRM1 and RRM2 domains of SRSF6, respectively.

```
# Plot splice event, transcripts and protein features
plotUniprotKBFeatures(srsf6_mapped, "SE", event_id = 33209, gtf = ens_gtf,
   features = c("domain", "chain"), show_transcripts = TRUE)
```

![](data:image/png;base64...)

## 2.5 RIPK2 example

RIPK2 has an exon skipping event in the hypoxia dataset. Following the example above, we map transcripts to splicing events and annotate protein features overlapping the splice event. We find out that the alternative exon overlaps the kinase domain of the protein, thus possibly changing the configuration of this domain during hypoxia. The ATP and proton acceptor binding sites are overlapping exons flanking the alternative exon.

```
ripk2_events <- geneEvents(hypoxia_filt, "RIPK2")
ripk2_mapped <- mapTranscriptsToEvents(ripk2_events, ens_gtf)
ripk2_annot <- mapProteinFeaturesToEvents(ripk2_mapped,
                                          tracks = c("Domain_and_Sites"),
                                          by = "category")
```

```
plotUniprotKBFeatures(ripk2_annot, type = "SE", event_id = 14319,
                      features = c("domain", "binding", "act-site"), gtf = ens_gtf,
                      zoom = FALSE, show_transcripts = TRUE)
```

![](data:image/png;base64...)

# 3 Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled:

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] rtracklayer_1.70.0   maser_1.28.0         GenomicRanges_1.62.0
#>  [4] Seqinfo_1.0.0        IRanges_2.44.0       S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0  generics_0.1.4       ggplot2_4.0.0
#> [10] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3                   bitops_1.0-9
#>   [3] deldir_2.0-4                gridExtra_2.3
#>   [5] httr2_1.2.1                 biomaRt_2.66.0
#>   [7] rlang_1.1.6                 magrittr_2.0.4
#>   [9] biovizBase_1.58.0           matrixStats_1.5.0
#>  [11] compiler_4.5.1              RSQLite_2.4.3
#>  [13] GenomicFeatures_1.62.0      reshape2_1.4.4
#>  [15] png_0.1-8                   vctrs_0.6.5
#>  [17] ProtGenerics_1.42.0         stringr_1.5.2
#>  [19] pkgconfig_2.0.3             crayon_1.5.3
#>  [21] fastmap_1.2.0               magick_2.9.0
#>  [23] backports_1.5.0             dbplyr_2.5.1
#>  [25] XVector_0.50.0              labeling_0.4.3
#>  [27] Rsamtools_2.26.0            rmarkdown_2.30
#>  [29] UCSC.utils_1.6.0            tinytex_0.57
#>  [31] bit_4.6.0                   xfun_0.53
#>  [33] cachem_1.1.0                cigarillo_1.0.0
#>  [35] GenomeInfoDb_1.46.0         jsonlite_2.0.0
#>  [37] progress_1.2.3              blob_1.2.4
#>  [39] DelayedArray_0.36.0         BiocParallel_1.44.0
#>  [41] jpeg_0.1-11                 parallel_4.5.1
#>  [43] prettyunits_1.2.0           cluster_2.1.8.1
#>  [45] VariantAnnotation_1.56.0    R6_2.6.1
#>  [47] bslib_0.9.0                 stringi_1.8.7
#>  [49] RColorBrewer_1.1-3          rpart_4.1.24
#>  [51] Gviz_1.54.0                 jquerylib_0.1.4
#>  [53] Rcpp_1.1.0                  bookdown_0.45
#>  [55] SummarizedExperiment_1.40.0 knitr_1.50
#>  [57] base64enc_0.1-3             Matrix_1.7-4
#>  [59] nnet_7.3-20                 tidyselect_1.2.1
#>  [61] rstudioapi_0.17.1           dichromat_2.0-0.1
#>  [63] abind_1.4-8                 yaml_2.3.10
#>  [65] codetools_0.2-20            curl_7.0.0
#>  [67] plyr_1.8.9                  lattice_0.22-7
#>  [69] tibble_3.3.0                Biobase_2.70.0
#>  [71] withr_3.0.2                 KEGGREST_1.50.0
#>  [73] S7_0.2.0                    evaluate_1.0.5
#>  [75] foreign_0.8-90              BiocFileCache_3.0.0
#>  [77] Biostrings_2.78.0           pillar_1.11.1
#>  [79] BiocManager_1.30.26         filelock_1.0.3
#>  [81] MatrixGenerics_1.22.0       DT_0.34.0
#>  [83] checkmate_2.3.3             RCurl_1.98-1.17
#>  [85] ensembldb_2.34.0            hms_1.1.4
#>  [87] scales_1.4.0                glue_1.8.0
#>  [89] lazyeval_0.2.2              Hmisc_5.2-4
#>  [91] tools_4.5.1                 interp_1.1-6
#>  [93] BiocIO_1.20.0               data.table_1.17.8
#>  [95] BSgenome_1.78.0             GenomicAlignments_1.46.0
#>  [97] XML_3.99-0.19               grid_4.5.1
#>  [99] crosstalk_1.2.2             latticeExtra_0.6-31
#> [101] colorspace_2.1-2            AnnotationDbi_1.72.0
#> [103] htmlTable_2.4.3             restfulr_0.0.16
#> [105] Formula_1.2-5               cli_3.6.5
#> [107] rappdirs_0.3.3              S4Arrays_1.10.0
#> [109] dplyr_1.1.4                 AnnotationFilter_1.34.0
#> [111] gtable_0.3.6                sass_0.4.10
#> [113] digest_0.6.37               SparseArray_1.10.0
#> [115] rjson_0.2.23                htmlwidgets_1.6.4
#> [117] farver_2.1.2                memoise_2.0.1
#> [119] htmltools_0.5.8.1           lifecycle_1.0.4
#> [121] httr_1.4.7                  bit64_4.6.0-1
```