# Data preprocessing and creation of the data objects pasillaGenes and pasillaExons

Alejandro Reyes

#### 4 November 2025

#### Abstract

This vignette describes the steps that were followed for the generation of the data objects contained in the package *[pasilla](https://bioconductor.org/packages/3.22/pasilla)*.

#### Package

pasilla 1.38.0

# Contents

* [1 Downloading the files](#downloading-the-files)
* [2 Read alignment and filtering](#read-alignment-and-filtering)
* [3 Exon count files](#exon-count-files)
* [4 Creation of the DEXSeqDataSet dxd](#creation-of-the-dexseqdataset-dxd)
* [5 SessionInfo](#sessioninfo)
* [References](#references)

# 1 Downloading the files

We used the RNA-Seq data from the publication by Brooks et al. (Brooks et al. [2010](#ref-Brooks2010)).
The experiment investigated the effect of siRNA knock-down of pasilla, a gene
that is known to bind to mRNA in the spliceosome, and which is thought to be involved
in the regulation of splicing. The data set contains 3 biological replicates of the
knockdown as well as 4 biological replicates for the untreated control.
The data files are available from the NCBI Gene Expression Omnibus under the
[accession GSE18508](http://www.ncbi.nlm.nih.gov/projects/geo/query/acc.cgi?acc=GSE18508).
The read sequences in FASTQ format were extracted from the NCBI short read archive file
(.sra files) using the SRA toolkit.

# 2 Read alignment and filtering

The reads in the FASTQ files were aligned using `tophat` version 1.2.0
with default parameters against the reference Drosophila melanogaster
genome. The following table summarizes the read number and
alignment statistics.
The column `exon.counts` refers to the number of reads that could be uniquely aligned to an exon.

```
dataFilesDir = system.file("extdata", package = "pasilla", mustWork=TRUE)
pasillaSampleAnno = read.csv(file.path(dataFilesDir, "pasilla_sample_annotation.csv"))
pasillaSampleAnno
```

```
##           file condition        type number.of.lanes total.number.of.reads
## 1   treated1fb   treated single-read               5              35158667
## 2   treated2fb   treated  paired-end               2         12242535 (x2)
## 3   treated3fb   treated  paired-end               2         12443664 (x2)
## 4 untreated1fb untreated single-read               2              17812866
## 5 untreated2fb untreated single-read               6              34284521
## 6 untreated3fb untreated  paired-end               2         10542625 (x2)
## 7 untreated4fb untreated  paired-end               2         12214974 (x2)
##   exon.counts
## 1    15679615
## 2    15620018
## 3    12733865
## 4    14924838
## 5    20764558
## 6    10283129
## 7    11653031
```

The reference genome fasta files were obtained from the
[Ensembl ftp server](http://www.ensembl.org/info/data/ftp/index.html).
We ran `bowtie-build` to index the
fasta file. For more information on this procedure see
the [`bowtie` webpage](http://bowtie-bio.sourceforge.net/index.shtml).
The indexed form is required by `bowtie`, and thus `tophat`.

```
wget ftp://ftp.ensembl.org/pub/release-62/fasta/drosophila_melanogaster/ \
dna/Drosophila_melanogaster.BDGP5.25.62.dna_rm.toplevel.fa.gz

gunzip Drosophila_melanogaster.BDGP5.25.62.dna_rm.toplevel.fa.gz
bowtie-build Drosophila_melanogaster.BDGP5.25.62.dna_rm.toplevel.fa \
    d_melanogaster_BDGP5.25.62
```

We generated the alignment BAM file using `tophat`. For the single-reads data:

```
tophat bowtie_index <filename>1.fastq,<filename>2.fastq,...,<filename>N.fastq
```

For the paired-end data:

```
tophat -r inner-fragment-size bowtie_index \
    <filename>1_1.fastq,<filename>2_1.fastq,...,<filename>N_1.fastq \
    <filename>1_2.fastq,<filename>2_2.fastq,...,<filename>N_2.fastq
```

The SAM alignment files from which *[pasilla](https://bioconductor.org/packages/3.22/pasilla)* was generated
[are available at this URL](http://www-huber.embl.de/pub/DEXSeq/analysis/brooksetal/bam).

# 3 Exon count files

To generate the per-exon read counts, we first needed to define the exonic regions.
To this end, we downloaded the file `Drosophila_melanogaster.BDGP5.25.62.gtf.gz` from
Ensembl.
The script `dexseq_prepare_annotation.py` contained in the *[DEXSeq](https://bioconductor.org/packages/3.22/DEXSeq)*
package was used to extract the exons of the transcripts from the file, define new
non-overlapping exonic regions and reformat it to create the file `Dmel.BDGP5.25.62.DEXSeq.chr.gff`
contained in `pasilla/extdata`. For example, for this file we ran:

```
wget ftp://ftp.ensembl.org/pub/release-62/gtf/ \
drosophila_melanogaster/Drosophila_melanogaster.BDGP5.25.62.gtf.gz

gunzip Drosophila_melanogaster.BDGP5.25.62.gtf.gz
python dexseq_prepare_annotation.py Drosophila_melanogaster.BDGP5.25.62.gtf \
    Dmel.BDGP5.25.62.DEXSeq.chr.gff
```

To count the reads that fell into each non-overlapping exonic part, the script
`dexseq_count.py`, which is also contained in the *[DEXSeq](https://bioconductor.org/packages/3.22/DEXSeq)* package, was used.
It took the alignment results in the form of a SAM file
(sorted by position in the case of a paired end data) and the `gtf` file
`Dmel.BDGP5.25.62.DEXSeq.chr.gff` and returned one file for each biological replicate
with the exon counts. For example, for the file treated1.bam, which contained single-end
alignments, we ran:

```
samtools index treated1.bam
samtools view treated1.bam > treated1.sam
python dexseq_count.py Dmel.BDGP5.25.62.DEXSeq.chr.gff \
    treated1.sam treated1fb.txt
```

For the file `treated2.bam`, which contained paired-end alignments:

```
samtools index treated2.bam
samtools view treated2.bam > treated2.sam
sort -k1,1 -k2,2n treated2.sam > treated2_sorted.sam
python dexseq_count.py -p yes Dmel.BDGP5.25.62.DEXSeq.chr.gff \
    treated2_sorted.sam treated2fb.txt
```

The output of the two HTSeq python scripts is provided in the
*[pasilla](https://bioconductor.org/packages/3.22/pasilla)* package:

```
dir(system.file("extdata", package = "pasilla", mustWork=TRUE), pattern = ".txt$")
```

```
## [1] "geneIDsinsubset.txt" "treated1fb.txt"      "treated2fb.txt"
## [4] "treated3fb.txt"      "untreated1fb.txt"    "untreated2fb.txt"
## [7] "untreated3fb.txt"    "untreated4fb.txt"
```

The Python scripts are built upon the
[HTSeq library](http://www-huber.embl.de/users/anders/HTSeq/doc/overview.html).

# 4 Creation of the DEXSeqDataSet dxd

To create a DEXSeqDataSet object, we need the count files, the sample annotations,
and the GFF file with the per exon annotation.

```
gffFile = file.path(dataFilesDir, "Dmel.BDGP5.25.62.DEXSeq.chr.gff")
```

With these, we could call the function `DEXSeqDataSet` to construct the object `dxd`.

```
library("DEXSeq")
dxd = DEXSeqDataSetFromHTSeq(
  countfiles = file.path(dataFilesDir, paste(pasillaSampleAnno$file, "txt", sep=".")),
  sampleData = pasillaSampleAnno,
  design= ~ sample + exon + condition:exon,
  flattenedfile = gffFile)
dxd
```

```
## class: DEXSeqDataSet
## dim: 70463 14
## metadata(1): version
## assays(1): counts
## rownames(70463): FBgn0000003:E001 FBgn0000008:E001 ... FBgn0261575:E001
##   FBgn0261575:E002
## rowData names(5): featureID groupID exonBaseMean exonBaseVar
##   transcripts
## colnames: NULL
## colData names(8): sample file ... exon.counts exon
```

We only wanted to work with data from a subset of genes, which was defined in the following file.

```
genesforsubset = readLines(file.path(dataFilesDir, "geneIDsinsubset.txt"))
dxd = dxd[geneIDs( dxd ) %in% genesforsubset,]
```

We saved the R objects in the data directory of the package:

```
save(dxd, file = file.path("..", "data", "pasillaDEXSeqDataSet.RData"))
```

# 5 SessionInfo

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] DEXSeq_1.56.0               RColorBrewer_1.1-3
##  [3] AnnotationDbi_1.72.0        DESeq2_1.50.0
##  [5] SummarizedExperiment_1.40.0 GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           Biobase_2.70.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] BiocParallel_1.44.0         BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1    dplyr_1.1.4         farver_2.1.2
##  [4] blob_1.2.4          filelock_1.0.3      Biostrings_2.78.0
##  [7] S7_0.2.0            bitops_1.0-9        fastmap_1.2.0
## [10] BiocFileCache_3.0.0 XML_3.99-0.19       digest_0.6.37
## [13] lifecycle_1.0.4     statmod_1.5.1       survival_3.8-3
## [16] KEGGREST_1.50.0     RSQLite_2.4.3       genefilter_1.92.0
## [19] magrittr_2.0.4      compiler_4.5.1      rlang_1.1.6
## [22] sass_0.4.10         progress_1.2.3      tools_4.5.1
## [25] yaml_2.3.10         knitr_1.50          prettyunits_1.2.0
## [28] S4Arrays_1.10.0     bit_4.6.0           curl_7.0.0
## [31] DelayedArray_0.36.0 abind_1.4-8         hwriter_1.3.2.1
## [34] grid_4.5.1          xtable_1.8-4        ggplot2_4.0.0
## [37] scales_1.4.0        dichromat_2.0-0.1   biomaRt_2.66.0
## [40] cli_3.6.5           rmarkdown_2.30      crayon_1.5.3
## [43] httr_1.4.7          DBI_1.2.3           cachem_1.1.0
## [46] stringr_1.5.2       splines_4.5.1       parallel_4.5.1
## [49] BiocManager_1.30.26 XVector_0.50.0      vctrs_0.6.5
## [52] Matrix_1.7-4        jsonlite_2.0.0      geneplotter_1.88.0
## [55] bookdown_0.45       hms_1.1.4           bit64_4.6.0-1
## [58] locfit_1.5-9.12     jquerylib_0.1.4     annotate_1.88.0
## [61] glue_1.8.0          codetools_0.2-20    stringi_1.8.7
## [64] gtable_0.3.6        tibble_3.3.0        pillar_1.11.1
## [67] rappdirs_0.3.3      htmltools_0.5.8.1   R6_2.6.1
## [70] dbplyr_2.5.1        httr2_1.2.1         evaluate_1.0.5
## [73] lattice_0.22-7      png_0.1-8           Rsamtools_2.26.0
## [76] memoise_2.0.1       bslib_0.9.0         Rcpp_1.1.0
## [79] SparseArray_1.10.1  xfun_0.54           pkgconfig_2.0.3
```

# References

Brooks, A. N., L. Yang, M. O. Duff, K. D. Hansen, J. W. Park, S. Dudoit, S. E. Brenner, and B. R. Graveley. 2010. “Conservation of an RNA regulatory map between Drosophila and mammals.” *Genome Research*, October, 193–202. <https://doi.org/10.1101/gr.108662.110>.