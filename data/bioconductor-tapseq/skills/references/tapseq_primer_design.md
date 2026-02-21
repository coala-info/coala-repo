# TAP-seq primer design workflow

Andreas Gschwind

Department of Genetics, Stanford University

#### 2026-01-19

#### Package

TAPseq 1.22.1

# Contents

* [1 Installation](#installation)
* [2 Transcript sequences](#transcript-sequences)
* [3 Design outer primers](#design-outer-primers)
* [4 BLAST primers](#blast-primers)
* [5 Design inner primers](#design-inner-primers)
* [6 Multiplex compatibility](#multiplex-compatibility)
* [7 Export primers](#export-primers)
* [8 Session information](#session-information)

# 1 Installation

This package requires local installations of Primer3 and BLASTn. TAPseq was developed and tested
using Primer3 v.2.5.0 and blastn v.2.6.0. It’s strongly suggested to use Primer3 >= 2.5.0! Earlier
versions require a primer3\_config directory, which needs to be specified whenever calling functions
interacting with Primer3. Source code and installation instructions can be found under:

Primer3: <https://github.com/primer3-org/primer3/releases>
BLASTn: <https://www.ncbi.nlm.nih.gov/books/NBK279690>

Please install these tools first and add them to your PATH. If you don’t want to add the tools to
your “global” PATH, you can add the following code to your .Rprofile file. This should add the tools
to your PATH in R whenever you start a new session.

```
Sys.setenv(PATH = paste(Sys.getenv("PATH"), "/full/path/to/primer3-x.x.x/src", sep = ":"))

Sys.setenv(PATH = paste(Sys.getenv("PATH"), "/full/path/to/blast+/ncbi-blast-x.x.x+/bin",
                        sep = ":"))
```

Alternatively you can specify the paths to 3rd party software as arguments when calling TAPseq
functions (TAPseqInput(), designPrimers(), checkPrimers()).

# 2 Transcript sequences

Let’s start by creating transcript sequences for primer design for a target gene panel. First we try
to infer likely polyadenylation (polyA) sites for the selected target genes.

```
library(TAPseq)
library(GenomicRanges)
library(BiocParallel)

# gene annotations for chromosome 11 genomic region
data("chr11_genes")

# convert to GRangesList containing annotated exons per gene. for the sake of time we only use
# a small subset of the chr11 genes. use the full set for a more realistic example
target_genes <- split(chr11_genes, f = chr11_genes$gene_name)
target_genes <- target_genes[18:27]

# K562 Drop-seq read data (this is just a small example file within the R package)
dropseq_bam <- system.file("extdata", "chr11_k562_dropseq.bam", package = "TAPseq")

# register backend for parallelization
register(MulticoreParam(workers = 2))

# infer polyA sites from Drop-seq data
polyA_sites <- inferPolyASites(target_genes, bam = dropseq_bam, polyA_downstream = 50,
                               wdsize = 100, min_cvrg = 1, parallel = TRUE)
```

Here we assume all inferred polyA sites to be correct. In a real-world application it’s adviced to
manually inspect the polyA site predictions and remove any obvious false positives. This is easiest
done by exporting the polyA sites into a .bed. This file can then be loaded into a genome browser
(e.g. IGV) together with the target gene annotations and the .bam file to visually inspect the polyA
site predictions.

```
library(rtracklayer)
export(polyA_sites, con = "path/to/polyA_sites.bed", format = "bed")
export(unlist(target_genes), con = "path/to/target_genes.gtf", format = "gtf")
```

Once we are happy with our polyA predictions, we then use them to truncate the target gene
transcripts. All target gene transcripts overlapping any polyA sites are truncated at the polyA
sites, as we assume that they mark the transcripts 3’ ends. By default the most downstream polyA
site is taken to truncate a transcript. If multiple transcripts per gene overlap polyA sites, a
merged truncated transcript model is generated from all overlapping transcripts. If no transcript
of a given gene overlap with any polyA sites a consensus transcript model is created from all
transcripts for that gene.

```
# truncate transcripts at inferred polyA sites
truncated_txs <- truncateTxsPolyA(target_genes, polyA_sites = polyA_sites, parallel = TRUE)
```

To finalize this part, we need to extract the sequences of the truncated transcripts. Here we use
Bioconductor’s BSgenome to export transcript sequences, but the genome sequence could also be
imported from a fasta file into a DNAStringSet object.

```
library(BSgenome)

# human genome BSgenome object (needs to be istalled from Bioconductor)
hg38 <- getBSgenome("BSgenome.Hsapiens.UCSC.hg38")

# get sequence for all truncated transcripts
txs_seqs <- getTxsSeq(truncated_txs, genome = hg38)
```

# 3 Design outer primers

Primer3 uses boulder-IO records for input and output (see: <http://primer3.org/manual.html>). TAPseq
implements TsIO and TsIOList objects, which store Primer3 input and output for TAP-seq primer
design in R’s S4 class system. They serve as the users interface to Primer3 during primer design.

First we create Primer3 input for outer forward primer design based on the obtained transcript
sequences. The reverse primer used in all PCR reactions is used, so that Primer3 can pick forward
primers suitable to work with it. By default this function uses the 10x Beads-oligo-dT and right
primer, and chooses optimal, minimum and maximum melting temperatures based on that. If another
protocol (e.g. Drop-seq) is used, these parameters can be adapted (`?TAPseqInput`).

```
# create TAPseq IO for outer forward primers from truncated transcript sequences
outer_primers <- TAPseqInput(txs_seqs, target_annot = truncated_txs,
                             product_size_range = c(350, 500), primer_num_return = 5)
```

We can now use Primer3 to design Primers and add them to the objects.

```
# design 5 outer primers for each target gene
outer_primers <- designPrimers(outer_primers)
```

The output TsIO objects contain the designed primers and expected amplicons:

```
# get primers and pcr products for specific genes
tapseq_primers(outer_primers$HBE1)
pcr_products(outer_primers$HBE1)

# these can also be accessed for all genes
tapseq_primers(outer_primers)
pcr_products(outer_primers)
```

We have now successfully designed 5 outer primers per target gene. To select the best primer per
gene we could just pick the primer with the lowest penalty score. However, we will now use BLAST to
try to estimate potential off-target priming for every primer. We will use this to then select the
best primer per gene, i.e. the primer with the fewest off-targets.

# 4 BLAST primers

Creating a BLAST database containing all annotated transcripts and chromosome sequences takes a
couple of minutes (and ~2Gb of free storage). For this example, we can generate a limited BLAST
database, containing only transcripts of all target genes and the sequence of chromosome 11.

```
# chromosome 11 sequence
chr11_genome <- DNAStringSet(getSeq(hg38, "chr11"))
names(chr11_genome) <- "chr11"

# create blast database
blastdb <- file.path(tempdir(), "blastdb")
createBLASTDb(genome = chr11_genome, annot = unlist(target_genes), blastdb = blastdb)
```

In a real-world application one would generate a database containing the entire genome and
transcriptome. The database can be saved in a location and used for multiple primer designs whithout
having to rebuild it everytime.

```
library(BSgenome)

# human genome BSgenome object (needs to be istalled from Bioconductor)
hg38 <- getBSgenome("BSgenome.Hsapiens.UCSC.hg38")

# download and import gencode hg38 annotations
url <- "ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_32/gencode.v32.annotation.gtf.gz"
annot <- import(url, format = "gtf")

# extract exon annotations for protein-coding genes to build transcripts
tx_exons <- annot[annot$type == "exon" & annot$gene_type == "protein_coding"]

# create blast database
blastdb <- file.path(tempdir(), "blastdb")
createBLASTDb(genome = hg38, annot = tx_exons, blastdb = blastdb)
```

Once we have our BLAST database, we can use it to estimate the number of exonic, intronic and
intergenic off-targets for all primers. Note, that the number of exonic and intronic off-targets is
provided on the level of genes, i.e. one exonic off-target means that a given primer might bind in
exonic region(s) of one other gene. If the off-target binding site overlaps with exons of two genes,
it will be counted twice, as it could bind to transcripts of two genes.

```
# now we can blast our outer primers against the create database
outer_primers <- blastPrimers(outer_primers, blastdb = blastdb, max_mismatch = 0,
                              min_aligned = 0.75)

# the primers now contain the number of estimated off-targets
tapseq_primers(outer_primers$IFITM1)
```

To finalize our set of outer primers, we want to choose the best primer per target gene, i.e. the
one with the fewest exonic, intronic and intergenic off-target hits (in that order).

```
# select best primer per target gene based on the number of potential off-targets
best_outer_primers <- pickPrimers(outer_primers, n = 1, by = "off_targets")

# each object now only contains the best primer
tapseq_primers(best_outer_primers$IFITM1)
```

# 5 Design inner primers

To design nested inner primers we simply need to repeat the same procedure with a smaller product
size range.

```
# create new TsIO objects for inner primers, note the different product size
inner_primers <- TAPseqInput(txs_seqs, target_annot = truncated_txs,
                             product_size_range = c(150, 300), primer_num_return = 5)

# design inner primers
inner_primers <- designPrimers(inner_primers)

# blast inner primers
inner_primers <- blastPrimers(inner_primers, blastdb = blastdb, max_mismatch = 0,
                              min_aligned = 0.75)

# pick best primer per target gene
best_inner_primers <- pickPrimers(inner_primers, n = 1, by = "off_targets")
```

Done! We succesfully designed TAP-seq outer and inner primer sets for our target gene panel.

# 6 Multiplex compatibility

As an additional step, we can verify if the designed primer sets are compatible for PCR
multiplexing. For that we use Primer3’s “check\_primers” functionality:

```
# use checkPrimers to run Primer3's "check_primers" functionality for every possible primer pair
outer_comp <- checkPrimers(best_outer_primers)
inner_comp <- checkPrimers(best_inner_primers)
```

We can now for instance plot the estimated complementarity scores for every pair. We highlight
pairs with a score higher than 47, which is considered “critical” by Primer3 during primer design
(see Primer3 for more information).

```
library(dplyr)
library(ggplot2)

# merge outer and inner complementarity scores into one data.frame
comp <- bind_rows(outer = outer_comp, inner = inner_comp, .id = "set")

# add variable for pairs with any complemetarity score higher than 47
comp <- comp %>%
  mutate(high_compl = if_else(primer_pair_compl_any_th > 47 | primer_pair_compl_end_th > 47,
                              true = "high", false = "ok")) %>%
  mutate(high_compl = factor(high_compl, levels = c("ok", "high")))

# plot complementarity scores
ggplot(comp, aes(x = primer_pair_compl_any_th, y = primer_pair_compl_end_th)) +
  facet_wrap(~set, ncol = 2) +
  geom_point(aes(color = high_compl), alpha = 0.25) +
  scale_color_manual(values = c("black", "red"), drop = FALSE) +
  geom_hline(aes(yintercept = 47), colour = "darkgray", linetype = "dashed") +
  geom_vline(aes(xintercept = 47), colour = "darkgray", linetype = "dashed") +
  labs(title = "Complementarity scores TAP-seq primer combinations",
       color = "Complementarity") +
  theme_bw()
```

![](data:image/png;base64...)

No primer pairs with complementarity scores above 47 were found, so they should be ok to use in
multiplex PCRs.

# 7 Export primers

To finish the workflow, we can export the designed primers to data.frames, which can be written to
.csv files for easy storage of primer sets.

```
# create data.frames for outer and inner primers
outer_primers_df <- primerDataFrame(best_outer_primers)
inner_primers_df <- primerDataFrame(best_inner_primers)

# the resulting data.frames contain all relevant primer data
head(outer_primers_df)
```

Furthermore we can create BED tracks with the genomic coordinates of the primer binding sites for
viewing in a genome browser.

```
# create BED tracks for outer and inner primers with custom colors
outer_primers_track <- createPrimerTrack(best_outer_primers, color = "steelblue3")
inner_primers_track <- createPrimerTrack(best_inner_primers, color = "goldenrod1")

# the output data.frames contain lines in BED format for every primer
head(outer_primers_track)
head(inner_primers_track)

# export tracks to .bed files ("" writes to the standard output, replace by a file name)
exportPrimerTrack(outer_primers_track, con = "")
exportPrimerTrack(inner_primers_track, con = "")
```

Alternatively, primer tracks can be easily created for outer and inner primers and written to one
.bed file, so that both primer sets can be viewed in the same track, but with different colors.

```
exportPrimerTrack(createPrimerTrack(best_outer_primers, color = "steelblue3"),
                  createPrimerTrack(best_inner_primers, color = "goldenrod1"),
                  con = "path/to/primers.bed")
```

# 8 Session information

All of the output in this vignette was produced under the following conditions:

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#>  [1] ggplot2_4.0.1                     dplyr_1.1.4
#>  [3] BSgenome.Hsapiens.UCSC.hg38_1.4.5 GenomeInfoDb_1.46.2
#>  [5] BSgenome_1.78.0                   rtracklayer_1.70.1
#>  [7] BiocIO_1.20.0                     Biostrings_2.78.0
#>  [9] XVector_0.50.0                    BiocParallel_1.44.0
#> [11] GenomicRanges_1.62.1              Seqinfo_1.0.0
#> [13] IRanges_2.44.0                    S4Vectors_0.48.0
#> [15] BiocGenerics_0.56.0               generics_0.1.4
#> [17] TAPseq_1.22.1                     BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1            farver_2.1.2
#>  [3] blob_1.3.0                  S7_0.2.1
#>  [5] bitops_1.0-9                fastmap_1.2.0
#>  [7] RCurl_1.98-1.17             GenomicAlignments_1.46.0
#>  [9] XML_3.99-0.20               digest_0.6.39
#> [11] lifecycle_1.0.5             KEGGREST_1.50.0
#> [13] RSQLite_2.4.5               magrittr_2.0.4
#> [15] compiler_4.5.2              rlang_1.1.7
#> [17] sass_0.4.10                 tools_4.5.2
#> [19] yaml_2.3.12                 knitr_1.51
#> [21] labeling_0.4.3              S4Arrays_1.10.1
#> [23] bit_4.6.0                   curl_7.0.0
#> [25] DelayedArray_0.36.0         RColorBrewer_1.1-3
#> [27] abind_1.4-8                 withr_3.0.2
#> [29] purrr_1.2.1                 grid_4.5.2
#> [31] scales_1.4.0                tinytex_0.58
#> [33] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
#> [35] cli_3.6.5                   rmarkdown_2.30
#> [37] crayon_1.5.3                otel_0.2.0
#> [39] httr_1.4.7                  rjson_0.2.23
#> [41] DBI_1.2.3                   cachem_1.1.0
#> [43] parallel_4.5.2              AnnotationDbi_1.72.0
#> [45] BiocManager_1.30.27         restfulr_0.0.16
#> [47] matrixStats_1.5.0           vctrs_0.7.0
#> [49] Matrix_1.7-4                jsonlite_2.0.0
#> [51] bookdown_0.46               bit64_4.6.0-1
#> [53] magick_2.9.0                GenomicFeatures_1.62.0
#> [55] jquerylib_0.1.4             tidyr_1.3.2
#> [57] glue_1.8.0                  codetools_0.2-20
#> [59] gtable_0.3.6                UCSC.utils_1.6.1
#> [61] tibble_3.3.1                pillar_1.11.1
#> [63] htmltools_0.5.9             R6_2.6.1
#> [65] evaluate_1.0.5              lattice_0.22-7
#> [67] Biobase_2.70.0              png_0.1-8
#> [69] Rsamtools_2.26.0            cigarillo_1.0.0
#> [71] memoise_2.0.1               bslib_0.9.0
#> [73] Rcpp_1.1.1                  SparseArray_1.10.8
#> [75] xfun_0.56                   MatrixGenerics_1.22.0
#> [77] pkgconfig_2.0.3
```