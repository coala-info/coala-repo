# Generate transcript to gene file for bustools

#### 29 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Downloading a transcriptome](#downloading-a-transcriptome)
* [3 Obtaining transcript to gene information](#obtaining-transcript-to-gene-information)
  + [3.1 From Ensembl](#from-ensembl)
  + [3.2 From FASTA file](#from-fasta-file)
  + [3.3 From GTF and GFF3 files](#from-gtf-and-gff3-files)
  + [3.4 From TxDb](#from-txdb)
  + [3.5 From EnsDb](#from-ensdb)
  + [3.6 Deprecation](#deprecation)

# 1 Introduction

Originally, this package was written when the `kallisto | bustools` concept was still experimental, to test a new and fast way to generate the gene count matrix from fastq files for scRNA-seq. In the past year, `kallisto | bustools` has matured. Now there’s a wrapper [kb-python](https://github.com/pachterlab/kb_python) that can download a prebuilt `kallisto` index for human and mice and call `kallisto bus` and `bustools` to get the gene count matrix. So largely, the old way of calling `kallisto bus` and `bustools`, and some functionalities of `BUSpaRse`, such as getting transcript to gene mapping, are obsolete.

So now the focus of `BUSpaRse` has shifted to finer control of the transcripts that go into the transcriptome and more options. Now all `tr2g_*` functions (except `tr2g_ensembl`) can filter transcripts for gene and transcript biotypes, only keep standard chromosomes (so no scaffolds and haplotypes), and extract the filtered transcripts from the transcriptome. GTF files from Ensembl, Ensembl fasta files, GFF3 files from Ensembl and RefSeq, TxDb, and EnsDb can all be used here.

```
library(BUSpaRse)
library(BSgenome.Hsapiens.UCSC.hg38)
#> Loading required package: GenomeInfoDb
#> Loading required package: BSgenome
#> Loading required package: Biostrings
#> Loading required package: XVector
#>
#> Attaching package: 'Biostrings'
#> The following object is masked from 'package:base':
#>
#>     strsplit
#> Loading required package: BiocIO
#> Loading required package: rtracklayer
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(EnsDb.Hsapiens.v86)
```

# 2 Downloading a transcriptome

The transcriptome can be downloaded from a specified version of Ensembl and filtered for biotypes and standard chromosomes, not only for the vertebrate database (www.ensembl.org and its mirrors), but also other Ensembl sites for plants, fungi, protists, and metazoa. The `gene_biotype_use = "cellranger"` means that the same gene biotypes [Cell Ranger uses for its reference package](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/advanced/references) are used here. By default, only standard chromosomes are kept. The `dl_transcriptome` function not only downloads the transcriptome and filters it, it also output the `tr2g.tsv` file of all transcripts in the filtered transcriptome, without column names, so can be directly used for `bustools`.

Wonder which biotypes are available? The lists of all gene and transcript biotypes from Ensembl are now provided in this package, and can be queried by `data("ensembl_gene_biotypes")` and `data("ensembl_tx_biotypes")`.

Resources for common invertebrate model organisms such as *Drosophila melanogaster* and *C. elegans* are actually available on the vertebrate site (www.ensembl.org).

```
# For Drosophila
dl_transcriptome("Drosophila melanogaster", out_path = "fly",
                 gene_biotype_use = "cellranger", verbose = FALSE)
#> Version is not applicable to IDs not of the form ENS[species prefix][feature type prefix][a unique eleven digit number].
list.files("fly")
#> [1] "Drosophila_melanogaster.BDGP6.54.cdna.all.fa.gz"
#> [2] "tr2g.tsv"
#> [3] "tx_filtered.fa"
```

The first file is the original fasta file. The second is the `tr2g` file without column names. The third is the filtered fasta file.

For *C. elegans*, from an archived version of Ensembl. Note that archives older than version 99 might not work.

```
dl_transcriptome("Caenorhabditis elegans", out_path = "worm", verbose = FALSE,
                 gene_biotype_use = "cellranger", ensembl_version = 100)
#> Version is not applicable to IDs not of the form ENS[species prefix][feature type prefix][a unique eleven digit number].
list.files("worm")
#> [1] "Caenorhabditis_elegans.WBcel235.cdna.all.fa.gz"
#> [2] "tr2g.tsv"
#> [3] "tx_filtered.fa"
```

For *Saccharomyces cerevisiae*. Note that the versioning of Ensembl for the plants, fungi, and etc. sites, that are actually www.ensemblgenomes.org, is different from that of the vertebrate site.

```
dl_transcriptome("Saccharomyces cerevisiae", out_path = "yeast",
                 type = "fungus", gene_biotype_use = "cellranger",
                 verbose = FALSE)
#> Version is not applicable to IDs not of the form ENS[species prefix][feature type prefix][a unique eleven digit number].
list.files("yeast")
#> [1] "Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa.gz"
#> [2] "tr2g.tsv"
#> [3] "tx_filtered.fa"
```

# 3 Obtaining transcript to gene information

## 3.1 From Ensembl

The transcript to gene data frame can be generated by directly querying Ensembl with biomart. This can query not only the vertebrate database (www.ensembl.org), but also the Ensembl databases for other organisms, such as plants (plants.ensembl.org) and fungi (fungi.ensembl.org). By default, this will use the most recent version of Ensembl, but older versions can also be used. By default, Ensembl transcript ID (with version number), gene ID (with version number), and gene symbol are downloaded, but other attributes available on Ensembl can be downloaded as well. Make sure that the Ensembl version matches the Ensembl version of transcriptome used for kallisto index.

```
# Specify other attributes
tr2g_mm <- tr2g_ensembl("Mus musculus", ensembl_version = 105,
                        other_attrs = "description",
                        gene_biotype_use = "cellranger")
#> Querying biomart for transcript and gene IDs of Mus musculus
```

```
head(tr2g_mm)
```

```
# Plants
tr2g_at <- tr2g_ensembl("Arabidopsis thaliana", type = "plant")
#> Version is only available to vertebrates.
#> Querying biomart for transcript and gene IDs of Arabidopsis thaliana
#> File /tmp/RtmpbzTXZG/Rbuild376b757535e33d/BUSpaRse/vignettes/tr2g.tsv already exists.
```

```
head(tr2g_at)
```

## 3.2 From FASTA file

We need a FASTA file for the transcriptome used to build kallisto index. Transcriptome FASTA files from Ensembl contains gene annotation in the sequence name of each transcript. Transcript and gene information can be extracted from the sequence name. At present, only Ensembl FASTA files or FASTA files with sequence names formatted like in Ensembl are accepted.

By default, the `tr2g.tsv` file and filtered fasta file (if filtering for biotypes and chromosomes) are written to disk, but these can be turned off so only the `tr2g` data frame is returned into the R session.

```
# Subset of a real Ensembl FASTA file
toy_fasta <- system.file("testdata/fasta_test.fasta", package = "BUSpaRse")
tr2g_fa <- tr2g_fasta(file = toy_fasta, write_tr2g = FALSE, save_filtered = FALSE)
head(tr2g_fa)
```

## 3.3 From GTF and GFF3 files

If you have GTF or GFF3 files for other purposes, these can also be used to generate the transcript to gene file. Now `tr2g_gtf` and `tr2g_gff3` can extract transcriptome from a genome that is either a `BSgenome` or a `DNAStringSet`.

```
# Subset of a reral GTF file from Ensembl
toy_gtf <- system.file("testdata/gtf_test.gtf", package = "BUSpaRse")
tr2g_tg <- tr2g_gtf(toy_gtf, Genome = BSgenome.Hsapiens.UCSC.hg38,
                    gene_biotype_use = "cellranger",
                    out_path = "gtf")
#> 706 sequences in the genome are absent from the annotation.
head(tr2g_tg)
```

A new GTF or GFF3 file after filtering biotypes and chromosomes is also written, and this can be turned off by setting `save_filtered_gtf = FALSE` or `save_filtered_gff = FALSE`. The transcriptome, with biotypes filtered and only standard chromosomes, is in `transcriptome.fa`. Use `compress_fa = TRUE` to gzip it.

```
list.files("gtf")
#> [1] "gtf_filtered.gtf" "tr2g.tsv"         "transcriptome.fa"
```

## 3.4 From TxDb

`TxDb` is a class for storing transcript annotations from the Bioconductor package `GenomicFeatures`. Unfortunately, `TxDb.Hsapiens.UCSC.hg38.knownGene` does not have biotype information or gene symbols.

```
tr2g_hs <- tr2g_TxDb(TxDb.Hsapiens.UCSC.hg38.knownGene, get_transcriptome = FALSE,
                     write_tr2g = FALSE)
#> 'select()' returned 1:1 mapping between keys and columns
head(tr2g_hs)
```

## 3.5 From EnsDb

`EnsDb` is a class for Ensembl gene annotations, from the Bioconductor package `ensembldb`. Ensembl annotations as `EnsDb` are available on `AnnotationHub` (since version 87), and some older versions are stand alone packages (e.g. `EnsDb.Hsapiens.v86`).

```
tr2g_hs86 <- tr2g_EnsDb(EnsDb.Hsapiens.v86, get_transcriptome = FALSE,
                        write_tr2g = FALSE, gene_biotype_use = "cellranger",
                        use_gene_version = FALSE, use_transcript_version = FALSE)
head(tr2g_hs86)
```

## 3.6 Deprecation

There used to be sections about `sort_tr2g` and `save_tr2g_bustools`, but these functions have been superseded by the new version of `tr2g` functions and `dl_transcriptome`, which sort the transcriptome after extracting it so the `tr2g` and the transcriptome are in the same order. The new version of `tr2g` functions and `dl_transcriptome` also by default writes the `tr2g.tsv` without column names with the first column as transcript and the second as gene to disk.

```
sessionInfo()
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
#>  [1] EnsDb.Hsapiens.v86_2.99.0
#>  [2] TxDb.Hsapiens.UCSC.hg38.knownGene_3.22.0
#>  [3] BSgenome.Hsapiens.UCSC.hg38_1.4.5
#>  [4] BSgenome_1.78.0
#>  [5] rtracklayer_1.70.0
#>  [6] BiocIO_1.20.0
#>  [7] Biostrings_2.78.0
#>  [8] XVector_0.50.0
#>  [9] GenomeInfoDb_1.46.0
#> [10] ensembldb_2.34.0
#> [11] AnnotationFilter_1.34.0
#> [12] GenomicFeatures_1.62.0
#> [13] AnnotationDbi_1.72.0
#> [14] Biobase_2.70.0
#> [15] GenomicRanges_1.62.0
#> [16] Seqinfo_1.0.0
#> [17] IRanges_2.44.0
#> [18] S4Vectors_0.48.0
#> [19] BiocGenerics_0.56.0
#> [20] generics_0.1.4
#> [21] ggplot2_4.0.0
#> [22] zeallot_0.2.0
#> [23] Matrix_1.7-4
#> [24] BUSpaRse_1.24.0
#> [25] TENxBUSData_1.23.0
#> [26] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] DBI_1.2.3                   bitops_1.0-9
#>  [3] httr2_1.2.1                 biomaRt_2.66.0
#>  [5] rlang_1.1.6                 magrittr_2.0.4
#>  [7] matrixStats_1.5.0           compiler_4.5.1
#>  [9] RSQLite_2.4.3               png_0.1-8
#> [11] vctrs_0.6.5                 stringr_1.5.2
#> [13] ProtGenerics_1.42.0         pkgconfig_2.0.3
#> [15] crayon_1.5.3                fastmap_1.2.0
#> [17] magick_2.9.0                dbplyr_2.5.1
#> [19] Rsamtools_2.26.0            rmarkdown_2.30
#> [21] UCSC.utils_1.6.0            tinytex_0.57
#> [23] purrr_1.1.0                 bit_4.6.0
#> [25] xfun_0.53                   cachem_1.1.0
#> [27] cigarillo_1.0.0             jsonlite_2.0.0
#> [29] progress_1.2.3              blob_1.2.4
#> [31] DelayedArray_0.36.0         BiocParallel_1.44.0
#> [33] parallel_4.5.1              prettyunits_1.2.0
#> [35] R6_2.6.1                    plyranges_1.30.0
#> [37] bslib_0.9.0                 stringi_1.8.7
#> [39] RColorBrewer_1.1-3          jquerylib_0.1.4
#> [41] Rcpp_1.1.0                  bookdown_0.45
#> [43] SummarizedExperiment_1.40.0 knitr_1.50
#> [45] tidyselect_1.2.1            dichromat_2.0-0.1
#> [47] abind_1.4-8                 yaml_2.3.10
#> [49] codetools_0.2-20            curl_7.0.0
#> [51] lattice_0.22-7              tibble_3.3.0
#> [53] withr_3.0.2                 KEGGREST_1.50.0
#> [55] S7_0.2.0                    evaluate_1.0.5
#> [57] BiocFileCache_3.0.0         xml2_1.4.1
#> [59] ExperimentHub_3.0.0         pillar_1.11.1
#> [61] BiocManager_1.30.26         filelock_1.0.3
#> [63] MatrixGenerics_1.22.0       RCurl_1.98-1.17
#> [65] BiocVersion_3.22.0          hms_1.1.4
#> [67] scales_1.4.0                glue_1.8.0
#> [69] lazyeval_0.2.2              tools_4.5.1
#> [71] AnnotationHub_4.0.0         GenomicAlignments_1.46.0
#> [73] XML_3.99-0.19               grid_4.5.1
#> [75] tidyr_1.3.1                 restfulr_0.0.16
#> [77] cli_3.6.5                   rappdirs_0.3.3
#> [79] S4Arrays_1.10.0             dplyr_1.1.4
#> [81] gtable_0.3.6                sass_0.4.10
#> [83] digest_0.6.37               SparseArray_1.10.0
#> [85] rjson_0.2.23                farver_2.1.2
#> [87] memoise_2.0.1               htmltools_0.5.8.1
#> [89] lifecycle_1.0.4             httr_1.4.7
#> [91] bit64_4.6.0-1
```