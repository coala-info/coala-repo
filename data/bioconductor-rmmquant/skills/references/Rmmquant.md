# The Rmmquant package

#### Matthias Zytnicki

#### 30 October 2025

The aim of Rmmquant is to quantify the expression of the genes. It is similar to [featureCounts](http://bioinf.wehi.edu.au/featureCounts/) (Liao, Smyth, and Shi 2014) and *[Rsubread](https://bioconductor.org/packages/3.22/Rsubread)*, or [HTSeq-counts](https://htseq.readthedocs.io) (Anders, Pyl, and Huber 2015) and the `countOverlaps` of *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)*.

The main difference with other approaches is that Rmmquant explicitely handles multi-mapping reads, in a way described by (Robert and Watson 2015).

Rmmquant is the R port of the C++ [mmquant](https://bitbucket.org/mzytnicki/multi-mapping-counter), which has been published previously (Zytnicki 2017).

## Rmmquant in a nutshell

The easiest method to get the expression of the genes stored in a GTF file, using RNA-Seq data stored in a BAM file is:

```
dir <- system.file("extdata", package="Rmmquant", mustWork = TRUE)
gtfFile <- file.path(dir, "test.gtf")
bamFile <- file.path(dir, "test.bam")
output <- RmmquantRun(gtfFile, bamFile)
```

In this example, the output is a *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*.

The matrix of counts can be accessed through:

```
assays(output)$counts
```

```
##       test
## geneA    1
```

Rmmquant expects at least two kinds of data:

* annotation
* reads

Many aspects of Rmmquant can be controlled with parameters.

All these notions are detailed hereafter.

## Package

The Rmmquant package mainly consists in one function, `RmmquantRun` function, that supports the options described hereafter,

Rmmquant also internally implements an S4 class, `RmmquantClass`, that stores all the inputs and the outputs of the `RmmquantRun` function, as well as a validator (that checks the consistency of the inputs).

## Inputs

### Annotation

#### Annotation file

The annotation file should be in GTF. GFF might work too. The tool only uses the gene/transcript/exon types.

#### Annotation structure

Alternatively, the structure can be given using *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)*, or *[GenomicRangesList](https://bioconductor.org/packages/3.22/GenomicRangesList)*.

When a *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* is provided, the quantification will be performed on each element of the *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)*.

When a *[GenomicRangesList](https://bioconductor.org/packages/3.22/GenomicRangesList)* is provided, the quantification will be performed on each element too, i.e. on each *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)*. Implicitely, each *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* of a *[GenomicRangesList](https://bioconductor.org/packages/3.22/GenomicRangesList)* is interpreted as a series of exons, and only the transcript (or the gene) will be quantified.

### Reads files

One or several reads files can be given.

The reads should be given in SAM or BAM format, and preferably be sorted by position, but it is not compulsory. The reads can be single end or paired-end (or a mixture thereof).

You can use the [samtools](http://www.htslib.org/) (Li et al. 2009) or the *[Rsamtools](https://bioconductor.org/packages/3.22/Rsamtools)* to sort them. Rmmquant uses the `NH` flag (that provides the number of hits for each read, see the [SAM format specification](https://samtools.github.io/hts-specs/SAMv1.pdf)), so be sure that your mapping tool sets it adequately (yes, [TopHat2](http://ccb.jhu.edu/software/tophat/index.shtml) (Kim et al. 2013) and [STAR](https://github.com/alexdobin/STAR) (Dobin et al. 2013) do it fine). You should also check how your mapping tool handles multi-mapping reads (this can usually be tuned using the appropriate parameters).

## Outputs

### Counts

The output *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* contains:

The count table can be accessed through the `assays` method of *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*. This methods returns a list, with only one element: `counts`.

```
assays(output)$counts
```

```
##       test
## geneA    1
```

The columns are the samples (here, only `test.bam`), and the rows the gene counts (here, only `gene_A`).

The count table can be used by *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* (Love, Huber, and Anders 2014), for instance, using the `DESeqDataSetFromMatrix` function.

If the user provided \(n\) reads files, the output will contain \(n\) columns:

| Gene | sample\_1 | sample\_2 | … |
| --- | --- | --- | --- |
| gene\_A | … | … | … |
| gene\_B | … | … | … |
| gene\_B–gene\_C | … | … | … |

The row names are the ID of the genes/features. The column names are the sample names. If a read maps several genes (say, `gene_B` and `gene_C`), a new feature is added to the matrix, `gene_B--gene_C`. The reads that can be mapped to these genes will be counted there (but not in the `gene_B` nor `gene_C` lines).

### Statistics

The statistics can be accessed using the `colData` method of *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*:

```
colData(output)
```

```
## DataFrame with 1 row and 5 columns
##         n.hits n.uniquely.mapped.reads n.ambiguously.mapped.hits
##      <numeric>               <numeric>                 <numeric>
## test         2                       1                         0
##      n.non.uniquely.mapped.hits n.unassigned.hits
##                       <numeric>         <numeric>
## test                          0                 1
```

This is a `DataFrame` (defined in *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)*), with one column per sample. The content of each column is:

* `n.hits`: the number of hits
* `n.uniquely.mapped.reads`: the number of uniquely mapped reads
* `n.non.uniquely.mapped.hits`: the number of non-uniquely mapped hits
* `n.ambiguously.mapped.hits`: the number of hits with several corresponding features
* `n.unassigned.hits`: the number of hits with no corresponding feature

Here, a hit is a possible mapping for a read. When a read maps several times, it means that several hits correspond to a read. A read may have zero, one, or several hits, which correspond to unmapped, uniquely mapped, and non-uniquely mapped reads.

## Options

### Count matrix options

#### Row names

If `printGeneName` is set to `TRUE`, the row names of the count table are the gene names, instead of the gene IDs. If two different genes have the same name, the systematic name is added, like: `Mat2a (ENSMUSG00000053907)`.

The gene IDs and gene names should be given in the GTF file after the `gene_id` and `gene_name` tags respectively.

#### Column names

The column names of the count matrix should be given in the `sampleNames`. If not given, the column names are inferred from the file names of the SAM/BAM files.

### Input options

#### Library type

The library types can be specified using the `strands` parameter. This parameter can be:

* `F`: the reads are single-end, and the forward strand is sequenced,
* `R`: the reads are single-end, and the reverse strand is sequenced,
* `FR`: the reads are paired-end, the forward strand is sequenced first, then the reverse strand,
* `RF`, `FF`, `FF`: other similar cases,
* `U`: the reads are single- or pair-ends, and the strand is unknown.

The `strands` parameters expect one value per SAM/BAM file. If only one value is given, it is recycled.

#### Reads file format.

The format is usually inferred from the file name, but you can mention it using the `formats` option.

This parameters expect one value per SAM/BAM file. If only one value is given, it is recycled.

### Read assignement options

#### Overlap options

The way a read \(R\) is mapped to a gene \(A\) depends on the `overlap=`\(n\) value:

| if \(n\) is | then \(R\) is mapped to \(A\) iff |
| --- | --- |
| a negative value | \(R\) is included in \(A\) |
| a positive integer | they have at least \(n\) nucleotides in common |
| a float value (0, 1) | \(n\)% of the nucleotides of \(R\) are shared with \(A\) |

#### Read mapping to several features.

We will suppose here that the `overlap=1` strategy is used (i.e. a read is attributed to a gene as soon as at least 1 nucleotide overlap). The example can be extended to other strategies as well.

If a read (say, of size 100), maps unambiguously and overlaps with gene A and B, it will be counted as 1 for the new “gene” `gene_A--gene_B`. However, suppose that only 1 nucleotide overlaps with gene A, whereas 100 nucleotides overlap with gene B (yes, genes A and B overlap). You probably would like to attribute the read to gene B.

The options `nOverlapDiff` and `pcOverlapDiff` control this. We compute the number of overlapping nucleotides between a read and the overlapping genes. If a read overlaps “significantly” more with one gene than with all the other genes, they will attribute the read to the former gene only.

The option `nOverlapDiff=`\(n\) computes the differences of overlapping nucleotides. Let us name \(N\_A\) and \(N\_B\) the number of overlapping nucleotides with genes A and B respectively. If \(N\_A \geq N\_B + n\), then the read will be attributed to gene A only.

The option `pcOverlapDiff=`\(m\) compares the ratio of overlapping nucleotides. If \(N\_A / N\_B \geq m\%\), then the read will be attributed to gene A only.

If both option `nOverlapDiff=`\(n\) and `pcOverlapDiff=`\(m\) are used, then the read will be attributed to gene A only iff both \(N\_A \geq N\_B + n\) and \(N\_A / N\_B \geq m\%\).

### Row count options

#### Count threshold

If the maximum number of reads for a gene is less than `countThreshold` (a non-negative integer), then the corresponding line is discarded.

#### Merge threshold

Sometimes, there are very few reads that can be mapped unambiguously to a gene A, because it is very similar to gene B.

| Gene | sample\_1 |
| --- | --- |
| gene\_A | \(x\) |
| gene\_B | \(y\) |
| gene\_A–gene\_B | \(z\) |

In the previous example, suppose that \(x \ll z\). In this case, you can move all the reads from `gene_A` to `gene_A--gene_B`, using the `mergeThreshold=`\(t\), a float in (0, 1). If \(x < t \cdot y\), then the reads are transferred.

## Use cases

The next examples uses data generated in *[TBX20BamSubset](https://bioconductor.org/packages/3.22/TBX20BamSubset)*, where the expression of the genes is compared between the wild type and the TXB20 knock-out mice. The data have been mapped to the mm9 reference, and restricted to chromosome 19.

```
bamFiles    <- getBamFileList()
sampleNames <- names(bamFiles)
```

### Extracting GenomicRanges from Annotation Database

You can extract the annotation a BioConductor package, such as *[TxDb.Mmusculus.UCSC.mm9.knownGene](https://bioconductor.org/packages/3.22/TxDb.Mmusculus.UCSC.mm9.knownGene)*.

```
gr <- genes(TxDb.Mmusculus.UCSC.mm9.knownGene, filter=list(tx_chrom="chr19"))
```

The default gene IDs are Entrez ID (Maglott et al. 2015). If you prefer Ensembl IDs (Zerbino et al. 2018), you can modify the *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* accordingly. Notice that Entrez IDs may have zero, one, or more Ensembl counterparts.

```
ensemblIds <- sapply(as.list(org.Mm.egENSEMBL[mappedkeys(org.Mm.egENSEMBL)])
                     [mcols(gr)$gene_id], `[[`, 1)
gr         <- gr[! is.na(names(ensemblIds)), ]
names(gr)  <- unlist(ensemblIds)
```

### Using DESeq2

DESeq2 can be executed right after Rmmquant.

```
output   <- RmmquantRun(genomicRanges=gr, readsFiles=bamFiles,
                        sampleNames=sampleNames, sorts=FALSE)
coldata <- data.frame(condition=factor(c(rep("control", 3), rep("KO", 3)),
                                       levels=c("control", "KO")),
                      row.names=sampleNames)
dds      <- DESeqDataSetFromMatrix(countData=assays(output)$counts,
                                   colData  =coldata,
                                   design   =~ condition)
dds      <- DESeq(dds)
res      <- lfcShrink(dds, coef=2)
res$padj <- ifelse(is.na(res$padj), 1, res$padj)
res[res$padj < 0.05, ]
```

```
## log2 fold change (MAP): condition KO vs control
## Wald test p-value: condition KO vs control
## DataFrame with 2 rows and 5 columns
##                     baseMean log2FoldChange     lfcSE      pvalue        padj
##                    <numeric>      <numeric> <numeric>   <numeric>   <numeric>
## ENSMUSG00000024997  1107.956      -2.256187  0.145713 6.07030e-55 4.24921e-54
## ENSMUSG00000059326   302.673       0.557033  0.204875 5.23719e-03 1.83302e-02
```

### Troubleshooting

While installing the package, if the compiler complains and says

```
#error This file requires compiler and library support for the ISO C++ 2011 standard.
This support is currently experimental, and must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
```

Add this line

```
Sys.setenv("PKG_CXXFLAGS"="-std=c++11")
```

before installing the package.

## Session information

```
devtools::session_info()
```

```
## ─ Session info ───────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 4.5.1 Patched (2025-08-23 r88802)
##  os       Ubuntu 24.04.3 LTS
##  system   x86_64, linux-gnu
##  ui       X11
##  language (EN)
##  collate  C
##  ctype    en_US.UTF-8
##  tz       America/New_York
##  date     2025-10-30
##  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
##  quarto   1.7.32 @ /usr/local/bin/quarto
##
## ─ Packages ───────────────────────────────────────────────────────────────────
##  package                           * version    date (UTC) lib source
##  abind                               1.4-8      2024-09-12 [2] CRAN (R 4.5.1)
##  AnnotationDbi                     * 1.72.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  apeglm                              1.32.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  bbmle                               1.0.25.1   2023-12-09 [2] CRAN (R 4.5.1)
##  bdsmatrix                           1.3-7      2024-03-02 [2] CRAN (R 4.5.1)
##  Biobase                           * 2.70.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocGenerics                      * 0.56.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocIO                              1.20.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocManager                         1.30.26    2025-06-05 [2] CRAN (R 4.5.1)
##  BiocParallel                        1.44.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocStyle                         * 2.38.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  Biostrings                        * 2.78.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  bit                                 4.6.0      2025-03-06 [2] CRAN (R 4.5.1)
##  bit64                               4.6.0-1    2025-01-16 [2] CRAN (R 4.5.1)
##  bitops                              1.0-9      2024-10-03 [2] CRAN (R 4.5.1)
##  blob                                1.2.4      2023-03-17 [2] CRAN (R 4.5.1)
##  bslib                               0.9.0      2025-01-30 [2] CRAN (R 4.5.1)
##  cachem                              1.1.0      2024-05-16 [2] CRAN (R 4.5.1)
##  cigarillo                           1.0.0      2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  cli                                 3.6.5      2025-04-23 [2] CRAN (R 4.5.1)
##  coda                                0.19-4.1   2024-01-31 [2] CRAN (R 4.5.1)
##  codetools                           0.2-20     2024-03-31 [3] CRAN (R 4.5.1)
##  crayon                              1.5.3      2024-06-20 [2] CRAN (R 4.5.1)
##  curl                                7.0.0      2025-08-19 [2] CRAN (R 4.5.1)
##  DBI                                 1.2.3      2024-06-02 [2] CRAN (R 4.5.1)
##  DelayedArray                        0.36.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  DESeq2                            * 1.50.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  devtools                            2.4.6      2025-10-03 [2] CRAN (R 4.5.1)
##  dichromat                           2.0-0.1    2022-05-02 [2] CRAN (R 4.5.1)
##  digest                              0.6.37     2024-08-19 [2] CRAN (R 4.5.1)
##  dplyr                               1.1.4      2023-11-17 [2] CRAN (R 4.5.1)
##  ellipsis                            0.3.2      2021-04-29 [2] CRAN (R 4.5.1)
##  emdbook                             1.3.14     2025-07-23 [2] CRAN (R 4.5.1)
##  evaluate                            1.0.5      2025-08-27 [2] CRAN (R 4.5.1)
##  farver                              2.1.2      2024-05-13 [2] CRAN (R 4.5.1)
##  fastmap                             1.2.0      2024-05-15 [2] CRAN (R 4.5.1)
##  fs                                  1.6.6      2025-04-12 [2] CRAN (R 4.5.1)
##  generics                          * 0.1.4      2025-05-09 [2] CRAN (R 4.5.1)
##  GenomicAlignments                   1.46.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicFeatures                   * 1.62.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicRanges                     * 1.62.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  ggplot2                             4.0.0      2025-09-11 [2] CRAN (R 4.5.1)
##  glue                                1.8.0      2024-09-30 [2] CRAN (R 4.5.1)
##  gtable                              0.3.6      2024-10-25 [2] CRAN (R 4.5.1)
##  htmltools                           0.5.8.1    2024-04-04 [2] CRAN (R 4.5.1)
##  httr                                1.4.7      2023-08-15 [2] CRAN (R 4.5.1)
##  IRanges                           * 2.44.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  jquerylib                           0.1.4      2021-04-26 [2] CRAN (R 4.5.1)
##  jsonlite                            2.0.0      2025-03-27 [2] CRAN (R 4.5.1)
##  KEGGREST                            1.50.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  knitr                             * 1.50       2025-03-16 [2] CRAN (R 4.5.1)
##  lattice                             0.22-7     2025-04-02 [3] CRAN (R 4.5.1)
##  lifecycle                           1.0.4      2023-11-07 [2] CRAN (R 4.5.1)
##  locfit                              1.5-9.12   2025-03-05 [2] CRAN (R 4.5.1)
##  magrittr                            2.0.4      2025-09-12 [2] CRAN (R 4.5.1)
##  MASS                                7.3-65     2025-02-28 [3] CRAN (R 4.5.1)
##  Matrix                              1.7-4      2025-08-28 [3] CRAN (R 4.5.1)
##  MatrixGenerics                    * 1.22.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  matrixStats                       * 1.5.0      2025-01-07 [2] CRAN (R 4.5.1)
##  memoise                             2.0.1      2021-11-26 [2] CRAN (R 4.5.1)
##  mvtnorm                             1.3-3      2025-01-10 [2] CRAN (R 4.5.1)
##  numDeriv                            2016.8-1.1 2019-06-06 [2] CRAN (R 4.5.1)
##  org.Mm.eg.db                      * 3.22.0     2025-10-08 [2] Bioconductor
##  pillar                              1.11.1     2025-09-17 [2] CRAN (R 4.5.1)
##  pkgbuild                            1.4.8      2025-05-26 [2] CRAN (R 4.5.1)
##  pkgconfig                           2.0.3      2019-09-22 [2] CRAN (R 4.5.1)
##  pkgload                             1.4.1      2025-09-23 [2] CRAN (R 4.5.1)
##  plyr                                1.8.9      2023-10-02 [2] CRAN (R 4.5.1)
##  png                                 0.1-8      2022-11-29 [2] CRAN (R 4.5.1)
##  purrr                               1.1.0      2025-07-10 [2] CRAN (R 4.5.1)
##  R6                                  2.6.1      2025-02-15 [2] CRAN (R 4.5.1)
##  RColorBrewer                        1.1-3      2022-04-03 [2] CRAN (R 4.5.1)
##  Rcpp                                1.1.0      2025-07-02 [2] CRAN (R 4.5.1)
##  RCurl                               1.98-1.17  2025-03-22 [2] CRAN (R 4.5.1)
##  remotes                             2.5.0      2024-03-17 [2] CRAN (R 4.5.1)
##  restfulr                            0.0.16     2025-06-27 [2] CRAN (R 4.5.1)
##  rjson                               0.2.23     2024-09-16 [2] CRAN (R 4.5.1)
##  rlang                               1.1.6      2025-04-11 [2] CRAN (R 4.5.1)
##  rmarkdown                         * 2.30       2025-09-28 [2] CRAN (R 4.5.1)
##  Rmmquant                          * 1.28.0     2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
##  Rsamtools                         * 2.26.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  RSQLite                             2.4.3      2025-08-20 [2] CRAN (R 4.5.1)
##  rtracklayer                         1.70.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S4Arrays                            1.10.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S4Vectors                         * 0.48.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S7                                  0.2.0      2024-11-07 [2] CRAN (R 4.5.1)
##  sass                                0.4.10     2025-04-11 [2] CRAN (R 4.5.1)
##  scales                              1.4.0      2025-04-24 [2] CRAN (R 4.5.1)
##  Seqinfo                           * 1.0.0      2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  sessioninfo                         1.2.3      2025-02-05 [2] CRAN (R 4.5.1)
##  SparseArray                         1.10.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  SummarizedExperiment              * 1.40.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  TBX20BamSubset                    * 1.45.0     2025-10-28 [2] Bioconductor 3.22 (R 4.5.1)
##  tibble                              3.3.0      2025-06-08 [2] CRAN (R 4.5.1)
##  tidyselect                          1.2.1      2024-03-11 [2] CRAN (R 4.5.1)
##  TxDb.Mmusculus.UCSC.mm9.knownGene * 3.2.2      2025-09-10 [2] Bioconductor
##  usethis                             3.2.1      2025-09-06 [2] CRAN (R 4.5.1)
##  vctrs                               0.6.5      2023-12-01 [2] CRAN (R 4.5.1)
##  xfun                                0.53       2025-08-19 [2] CRAN (R 4.5.1)
##  XML                                 3.99-0.19  2025-08-22 [2] CRAN (R 4.5.1)
##  XVector                           * 0.50.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  yaml                                2.3.10     2024-07-26 [2] CRAN (R 4.5.1)
##
##  [1] /tmp/RtmpEltTpU/Rinst2b706512fa1a87
##  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
##  [3] /home/biocbuild/bbs-3.22-bioc/R/library
##  * ── Packages attached to the search path.
##
## ──────────────────────────────────────────────────────────────────────────────
```

## References

Anders, Simon, Paul Theodor Pyl, and Wolfgang Huber. 2015. “HTSeq—a Python Framework to Work with High-Throughput Sequencing Data.” *Bioinformatics* 31 (2): 166–69.

Dobin, Alexander, Carrie A. Davis, Felix Schlesinger, Jorg Drenkow, Chris Zaleski, Sonali Jha, Philippe Batut, Mark Chaisson, and Thomas R. Gingeras. 2013. “STAR: Ultrafast Universal Rna-Seq Aligner.” *Bioinformatics* 29 (1): 15–21.

Kim, Daehwan, Geo Pertea, Cole Trapnell, Harold Pimentel, Ryan Kelley, and Steven L. Salzberg. 2013. “TopHat2: Accurate Alignment of Transcriptomes in the Presence of Insertions, Deletions and Gene Fusions.” *Genome Biology* 14 (4): R36.

Li, Heng, Bob Handsaker, Alec Wysoker, Tim Fennell, Jue Ruan, Nils Homer, Gabor Marth, Goncalo Abecasis, Richard Durbin, and 1000 Genome Project Data Processing Subgroup. 2009. “The Sequence Alignment/Map Format and Samtools.” *Bioinformatics* 25 (16): 2078–9.

Liao, Yang, Gordon K. Smyth, and Wei Shi. 2014. “FeatureCounts: An Efficient General Purpose Program for Assigning Sequence Reads to Genomic Features.” *Bioinformatics* 30 (7): 923–30.

Love, Michael I., Wolfgang Huber, and Simon Anders. 2014. “Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2.” *Genome Biology* 15 (12): 550.

Maglott, Donna, Jim Ostell, Kim D Pruitt, and Tatiana Tatusova. 2015. “Entrez Gene: gene-centered information at NCBI.” *Nucleic Acids Research* 33: D54–D58.

Robert, Christelle, and Mick Watson. 2015. “Errors in Rna-Seq Quantification Affect Genes of Relevance to Human Disease.” *Genome Biology* 16 (1): 177.

Zerbino, Daniel R, Premanand Achuthan, Wasiu Akanni, M Ridwan Amode, Daniel Barrell, Jyothish Bhai, Konstantinos Billis, et al. 2018. “Ensembl 2018.” *Nucleic Acids Research* 46 (D1): D754–D761.

Zytnicki, Matthias. 2017. “Mmquant: How to Count Multi-Mapping Reads?” *BMC Bioinformatics* 18 (1): 411.