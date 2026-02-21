# Generating reference files for spliced and unspliced abundance estimation with alignment-free methods

Charlotte Soneson

#### 2025-11-03

# 1 Introduction

In this vignette, we show how to prepare reference files for estimating
abundances of spliced and unspliced abundances with alignment-free methods
(e.g., [Salmon](https://salmon.readthedocs.io/en/latest/salmon.html),
[alevin](https://salmon.readthedocs.io/en/latest/alevin.html) or
[kallisto](https://pachterlab.github.io/kallisto/)).
Such abundances are used as input, e.g., for estimation of RNA velocity in
single-cell data.

```
library(eisaR)
```

# 2 Generate feature ranges

The first step is to generate a `GRangesList` object containing the genomic
ranges for the features of interest (spliced transcripts, and either unspliced
transcripts or intron sequences).
This is done using the `getFeatureRanges()` function, based on a reference GTF
file.
Here, we exemplify this with a small subset of a GTF file from
[Gencode release 28](https://www.gencodegenes.org/human/release_28.html).
We extract genomic ranges for spliced transcript and introns, where the latter
are defined for each transcript separately (using the same terminology as in
the *[BUSpaRse](https://bioconductor.org/packages/3.22/BUSpaRse)* package).
For each intron, a flanking sequence of 50 nt is added on each side to
accommodate reads mapping across an exon/intron boundary.

```
gtf <- system.file("extdata", "gencode.v28.annotation.sub.gtf",
                   package = "eisaR")
grl <- getFeatureRanges(
    gtf = gtf,
    featureType = c("spliced", "intron"),
    intronType = "separate",
    flankLength = 50L,
    joinOverlappingIntrons = FALSE,
    verbose = TRUE
)
#> Import genomic features from the file as a GRanges object ... OK
#> Prepare the 'metadata' data frame ... OK
#> Make the TxDb object ... OK
#> 'select()' returned 1:1 mapping between keys and columns
#> Extracting spliced transcript features
#> Extracting introns using the separate approach
```

The output from `getFeatureRanges()` is a `GRangesList` object, with all
the features of interest (both spliced transcripts and introns):

```
grl
#> GRangesList object of length 895:
#> $ENST00000456328.2
#> GRanges object with 3 ranges and 5 metadata columns:
#>       seqnames      ranges strand |           exon_id exon_rank
#>          <Rle>   <IRanges>  <Rle> |       <character> <integer>
#>   [1]     chr1 11869-12227      + | ENSE00002234944.1         1
#>   [2]     chr1 12613-12721      + | ENSE00003582793.1         2
#>   [3]     chr1 13221-14409      + | ENSE00002312635.1         3
#>           transcript_id           gene_id        type
#>             <character>       <character> <character>
#>   [1] ENST00000456328.2 ENSG00000223972.5        exon
#>   [2] ENST00000456328.2 ENSG00000223972.5        exon
#>   [3] ENST00000456328.2 ENSG00000223972.5        exon
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
#>
#> $ENST00000450305.2
#> GRanges object with 6 ranges and 5 metadata columns:
#>       seqnames      ranges strand |           exon_id exon_rank
#>          <Rle>   <IRanges>  <Rle> |       <character> <integer>
#>   [1]     chr1 12010-12057      + | ENSE00001948541.1         1
#>   [2]     chr1 12179-12227      + | ENSE00001671638.2         2
#>   [3]     chr1 12613-12697      + | ENSE00001758273.2         3
#>   [4]     chr1 12975-13052      + | ENSE00001799933.2         4
#>   [5]     chr1 13221-13374      + | ENSE00001746346.2         5
#>   [6]     chr1 13453-13670      + | ENSE00001863096.1         6
#>           transcript_id           gene_id        type
#>             <character>       <character> <character>
#>   [1] ENST00000450305.2 ENSG00000223972.5        exon
#>   [2] ENST00000450305.2 ENSG00000223972.5        exon
#>   [3] ENST00000450305.2 ENSG00000223972.5        exon
#>   [4] ENST00000450305.2 ENSG00000223972.5        exon
#>   [5] ENST00000450305.2 ENSG00000223972.5        exon
#>   [6] ENST00000450305.2 ENSG00000223972.5        exon
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
#>
#> $ENST00000473358.1
#> GRanges object with 3 ranges and 5 metadata columns:
#>       seqnames      ranges strand |           exon_id exon_rank
#>          <Rle>   <IRanges>  <Rle> |       <character> <integer>
#>   [1]     chr1 29554-30039      + | ENSE00001947070.1         1
#>   [2]     chr1 30564-30667      + | ENSE00001922571.1         2
#>   [3]     chr1 30976-31097      + | ENSE00001827679.1         3
#>           transcript_id           gene_id        type
#>             <character>       <character> <character>
#>   [1] ENST00000473358.1 ENSG00000243485.5        exon
#>   [2] ENST00000473358.1 ENSG00000243485.5        exon
#>   [3] ENST00000473358.1 ENSG00000243485.5        exon
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
#>
#> ...
#> <892 more elements>
```

The `metadata` slot of the `GRangesList` object contains a list of the feature
IDs for each type of feature:

```
lapply(S4Vectors::metadata(grl)$featurelist, head)
#> $spliced
#> [1] "ENST00000456328.2" "ENST00000450305.2" "ENST00000473358.1"
#> [4] "ENST00000469289.1" "ENST00000607096.1" "ENST00000606857.1"
#>
#> $intron
#> [1] "ENST00000456328.2-I"  "ENST00000456328.2-I1"
#> [3] "ENST00000450305.2-I"  "ENST00000450305.2-I1"
#> [5] "ENST00000450305.2-I2" "ENST00000450305.2-I3"
```

As we can see, the intron IDs are identified by a `-I` suffix.
Each feature is further annotated to a gene ID.
For the intronic features, the corresponding gene ID also bears the `-I`
suffix appended to the original gene ID.
Having separate gene IDs for spliced transcripts and introns allows, for
example, joint quantification of spliced and unspliced versions of a gene
with alevin.
Adding a suffix rather than defining a completely new gene ID allows us to
easily match corresponding spliced and unspliced feature IDs.
To further simplify the latter, the metadata of the `GRangesList` object
returned by `getFeatureRanges()` contains `data.frame`s matching the
corresponding gene IDs (as well as transcript IDs, if unspliced transcripts
are extracted):

```
head(S4Vectors::metadata(grl)$corrgene)
#>             spliced              intron
#> 1 ENSG00000223972.5 ENSG00000223972.5-I
#> 2 ENSG00000243485.5 ENSG00000243485.5-I
#> 3 ENSG00000284332.1 ENSG00000284332.1-I
#> 4 ENSG00000268020.3 ENSG00000268020.3-I
#> 5 ENSG00000240361.2 ENSG00000240361.2-I
#> 6 ENSG00000186092.6 ENSG00000186092.6-I
```

# 3 Extract feature sequences

Once the genomic ranges of the features of interest are extracted, we can
obtain the nucleotide sequences using the `extractTranscriptSeqs()` function
from the *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)* package.
In addition to the ranges, this requires the genome sequence.
This can be obtained, for example, from the corresponding BSgenome package,
or from an external FASTA file.

```
suppressPackageStartupMessages({
    library(BSgenome.Hsapiens.UCSC.hg38)
})
seqs <- GenomicFeatures::extractTranscriptSeqs(
    x = BSgenome.Hsapiens.UCSC.hg38,
    transcripts = grl
)
seqs
#> DNAStringSet object of length 895:
#>        width seq                                  names
#>   [1]   1657 GTTAACTTGCCGTCAGC...ACACTGTTGGTTTCTG ENST00000456328.2
#>   [2]    632 GTGTCTGACTTCCAGCA...ACAGGGGAATCCCGAA ENST00000450305.2
#>   [3]    712 GTGCACACGGCTCCCAT...TGAGGGATAAATGTAT ENST00000473358.1
#>   [4]    535 TCATCAGTCCAAAGTCC...GTATGATTTTAAAGTC ENST00000469289.1
#>   [5]    138 GGATGCCCAGCTAGTTT...AGAATTAAGCATTTTA ENST00000607096.1
#>   ...    ... ...
#> [891]    178 GCGCCAGCCGGACCCCA...CGCGTATTAACGAGAG ENST00000304952.1...
#> [892]    193 GGAGATGACCGTGAGAC...GTACCGCGCCGGCTTC ENST00000481869.1-I
#> [893]    193 GGAGATGACCGTGAGAC...GTACCGCGCCGGCTTC ENST00000484667.2-I
#> [894]    352 GCGCCAGCCGGACCCCA...TCCTGGAGATGACCGT ENST00000484667.2-I1
#> [895]    826 ACCTCCGCCTGCCAGGC...AGAGATTGTGGTGAGC ENST00000458555.1-I
```

The resulting `DNAStringSet` can be written to a FASTA file and used to
generate an index for alignment-free methods such as *Salmon* and *kallisto*.

# 4 Generate an expanded GTF file

In addition to extracting feature sequences, we can also export a GTF file
with the full set of features.
This is useful, for example, in order to generate a linked transcriptome for
later import of estimated abundances with *[tximeta](https://bioconductor.org/packages/3.22/tximeta)*.

```
exportToGtf(
    grl,
    filepath = file.path(tempdir(), "exported.gtf")
)
```

In the exported GTF file, each entry of `grl` will correspond to a “transcript”
feature, and each individual range corresponds to an “exon” feature.
In addition, each gene is represented as a “gene” feature.

# 5 Generate a transcript-to-gene mapping

Finally, we can export a `data.frame` (or a tab-separated test file) providing
a conversion table between “transcript” and “gene” identifiers.
This is needed to aggregate the transcript-level abundance estimates from
alignment-free methods such as *Salmon* and *kallisto* to the gene level.

```
df <- getTx2Gene(grl)
head(df)
#>                       transcript_id           gene_id
#> ENST00000456328.2 ENST00000456328.2 ENSG00000223972.5
#> ENST00000450305.2 ENST00000450305.2 ENSG00000223972.5
#> ENST00000473358.1 ENST00000473358.1 ENSG00000243485.5
#> ENST00000469289.1 ENST00000469289.1 ENSG00000243485.5
#> ENST00000607096.1 ENST00000607096.1 ENSG00000284332.1
#> ENST00000606857.1 ENST00000606857.1 ENSG00000268020.3
tail(df)
#>                               transcript_id              gene_id
#> ENST00000304952.10-I1 ENST00000304952.10-I1 ENSG00000188290.10-I
#> ENST00000304952.10-I2 ENST00000304952.10-I2 ENSG00000188290.10-I
#> ENST00000481869.1-I     ENST00000481869.1-I ENSG00000188290.10-I
#> ENST00000484667.2-I     ENST00000484667.2-I ENSG00000188290.10-I
#> ENST00000484667.2-I1   ENST00000484667.2-I1 ENSG00000188290.10-I
#> ENST00000458555.1-I     ENST00000458555.1-I  ENSG00000224969.1-I
```

# 6 Session info

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
#> [1] parallel  stats4    stats     graphics  grDevices utils
#> [7] datasets  methods   base
#>
#> other attached packages:
#>  [1] BSgenome.Hsapiens.UCSC.hg38_1.4.5
#>  [2] BSgenome_1.78.0
#>  [3] BiocIO_1.20.0
#>  [4] Biostrings_2.78.0
#>  [5] XVector_0.50.0
#>  [6] GenomeInfoDb_1.46.0
#>  [7] edgeR_4.8.0
#>  [8] limma_3.66.0
#>  [9] QuasR_1.50.0
#> [10] Rbowtie_1.50.0
#> [11] rtracklayer_1.70.0
#> [12] GenomicFeatures_1.62.0
#> [13] AnnotationDbi_1.72.0
#> [14] Biobase_2.70.0
#> [15] GenomicRanges_1.62.0
#> [16] Seqinfo_1.0.0
#> [17] IRanges_2.44.0
#> [18] S4Vectors_0.48.0
#> [19] BiocGenerics_0.56.0
#> [20] generics_0.1.4
#> [21] eisaR_1.22.1
#> [22] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] DBI_1.2.3                   bitops_1.0-9
#>  [3] deldir_2.0-4                httr2_1.2.1
#>  [5] biomaRt_2.66.0              rlang_1.1.6
#>  [7] magrittr_2.0.4              Rhisat2_1.26.0
#>  [9] matrixStats_1.5.0           compiler_4.5.1
#> [11] RSQLite_2.4.3               png_0.1-8
#> [13] vctrs_0.6.5                 txdbmaker_1.6.0
#> [15] stringr_1.5.2               pwalign_1.6.0
#> [17] pkgconfig_2.0.3             crayon_1.5.3
#> [19] fastmap_1.2.0               magick_2.9.0
#> [21] dbplyr_2.5.1                Rsamtools_2.26.0
#> [23] rmarkdown_2.30              UCSC.utils_1.6.0
#> [25] tinytex_0.57                bit_4.6.0
#> [27] xfun_0.54                   cachem_1.1.0
#> [29] cigarillo_1.0.0             jsonlite_2.0.0
#> [31] progress_1.2.3              blob_1.2.4
#> [33] DelayedArray_0.36.0         BiocParallel_1.44.0
#> [35] jpeg_0.1-11                 prettyunits_1.2.0
#> [37] R6_2.6.1                    VariantAnnotation_1.56.0
#> [39] stringi_1.8.7               bslib_0.9.0
#> [41] RColorBrewer_1.1-3          jquerylib_0.1.4
#> [43] Rcpp_1.1.0                  bookdown_0.45
#> [45] SummarizedExperiment_1.40.0 knitr_1.50
#> [47] SGSeq_1.44.0                igraph_2.2.1
#> [49] Matrix_1.7-4                tidyselect_1.2.1
#> [51] abind_1.4-8                 yaml_2.3.10
#> [53] codetools_0.2-20            RUnit_0.4.33.1
#> [55] hwriter_1.3.2.1             curl_7.0.0
#> [57] lattice_0.22-7              tibble_3.3.0
#> [59] ShortRead_1.68.0            KEGGREST_1.50.0
#> [61] evaluate_1.0.5              BiocFileCache_3.0.0
#> [63] pillar_1.11.1               BiocManager_1.30.26
#> [65] filelock_1.0.3              MatrixGenerics_1.22.0
#> [67] RCurl_1.98-1.17             hms_1.1.4
#> [69] GenomicFiles_1.46.0         glue_1.8.0
#> [71] tools_4.5.1                 interp_1.1-6
#> [73] locfit_1.5-9.12             GenomicAlignments_1.46.0
#> [75] XML_3.99-0.19               grid_4.5.1
#> [77] latticeExtra_0.6-31         restfulr_0.0.16
#> [79] cli_3.6.5                   rappdirs_0.3.3
#> [81] S4Arrays_1.10.0             dplyr_1.1.4
#> [83] sass_0.4.10                 digest_0.6.37
#> [85] SparseArray_1.10.1          rjson_0.2.23
#> [87] memoise_2.0.1               htmltools_0.5.8.1
#> [89] lifecycle_1.0.4             httr_1.4.7
#> [91] statmod_1.5.1               bit64_4.6.0-1
```