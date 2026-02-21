# Use cases for coordinate mapping with ensembldb

Johannes Rainer, Laurent Gatto and Christian X. Weichenberger

#### 29 October 2025

#### Package

ensembldb 2.34.0

This documents describes two use cases for the coordinate system mapping
functionality of `ensembldb`: mapping of regions within protein sequences to the
genome and mapping of genomic to protein sequence-relative coordinates. In
addition, it showcases the advanced filtering capabilities implemented in
`ensembldb`.

# 1 Query for *helix-loop-helix* transcription factors on chromosome 21

Down syndrome is a genetic disorder characterized by the presence of all or
parts of a third copy of chromosome 21. It is associated, among other, with
characteristic facial features and mild to moderate intellectual disability. The
phenotypes are most likely the result from a gene dosage-dependent increased
expression of the genes encoded on chromosome 21 (Lana-Elola et al. [2011](#ref-LanaElola:2011fl)). Compared
to other gene classes, transcription factors are more likely to have an
immediate impact, even due to a moderate over-expression (which might be the
result from gene duplication). One of the largest dimerizing transcription
factor families is characterized by a *basic helix-loop-helix* domain
(Massari and Murre [2000](#ref-Massari:2000um)), a protein structural motif facilitating DNA binding.

The example below aims at identifying transcription factors with a basic
helix-loop-helix domain (Pfam ID PF00010) that are encoded on chromosome 21. To
this end we first load an R-library providing human annotations from Ensembl
release 86 and pass the loaded `EnsDb` object along with a filter expression to
the `genes` method that retrieves the corresponding genes. Filter expressions
have to be written in the form `~ <field> <condition> <value>` with `<field>`
representing the database column to be used for the filter. Several such filter
expressions can be concatenated with standard R logical expressions (such as `&`
or `|`). To get a list of all available filters and their corresponding fields,
the `supportedFilters(edb)` function could be used.

```
library(ensembldb)
library(EnsDb.Hsapiens.v86)
edb <- EnsDb.Hsapiens.v86

## Retrieve the genes
gns <- genes(edb, filter = ~ protein_domain_id == "PF00010" & seq_name == "21")
```

The function returned a `GRanges` object with the genomic position of the genes
and additional gene-related annotations stored in *metadata* columns.

```
gns
```

```
## GRanges object with 3 ranges and 7 metadata columns:
##                   seqnames            ranges strand |         gene_id
##                      <Rle>         <IRanges>  <Rle> |     <character>
##   ENSG00000205927       21 33025845-33029196      + | ENSG00000205927
##   ENSG00000184221       21 33070144-33072420      + | ENSG00000184221
##   ENSG00000159263       21 36699133-36749917      + | ENSG00000159263
##                     gene_name   gene_biotype seq_coord_system      symbol
##                   <character>    <character>      <character> <character>
##   ENSG00000205927       OLIG2 protein_coding       chromosome       OLIG2
##   ENSG00000184221       OLIG1 protein_coding       chromosome       OLIG1
##   ENSG00000159263        SIM2 protein_coding       chromosome        SIM2
##                   entrezid protein_domain_id
##                     <list>       <character>
##   ENSG00000205927    10215           PF00010
##   ENSG00000184221   116448           PF00010
##   ENSG00000159263     6493           PF00010
##   -------
##   seqinfo: 1 sequence from GRCh38 genome
```

Three transcription factors with a helix-loop-helix domain are encoded on
chromosome 21: *SIM2*, which is a master regulator of neurogenesis and is
thought to contribute to some specific phenotypes of Down syndrome
(Gardiner and Costa [2006](#ref-Gardiner:2006uj)) and the two genes *OLIG1* and *OLIG2* for which genetic
triplication was shown to cause developmental brain defects
(Chakrabarti et al. [2010](#ref-Chakrabarti:2010dt)). To visualize the exonic regions encoding the
helix-loop-helix domain of these genes we next retrieve their transcript models
and the positions of all Pfam protein domains within the amino acid sequences of
encoded by these transcripts. We process *SIM2* separately from *OLIG1* and
*OLIG2* because the latter are encoded in a narrow region on chromosome 21 and
can thus be visualized easily within the same plot. We extract the transcript
models for *OLIG1* and *OLIG2* that encode the protein domain using the
`getGeneRegionTrackForGviz` function which returns the data in a format that can
be directly passed to functions from the `Gviz` Bioconductor package
(Hahne and Ivanek [2016](#ref-Hahne:2016ha)) for plotting. Since `Gviz` expects UCSC-style chromosome names
instead of the Ensembl chromosome names (e.g. `chr21` instead of `21`), we
change the format in which chromosome names are returned by `ensembldb` with the
`seqlevelsStyle` method. All subsequent queries to the `EnsDb` database will
return chromosome names in UCSC format.

```
## Change chromosome naming style to UCSC
seqlevelsStyle(edb) <- "UCSC"
```

```
## Retrieve the transcript models for OLIG1 and OLIG2 that encode the
## the protein domain
txs <- getGeneRegionTrackForGviz(
    edb, filter = ~ genename %in% c("OLIG1", "OLIG2") &
             protein_domain_id == "PF00010")
```

Next we fetch the coordinates of all Pfam protein domains encoded by these
transcripts with the `proteins` method, asking for columns `"prot_dom_start"`,
`"prot_dom_end"` and `"protein_domain_id"` to be returned by the function. Note
that we restrict the results in addition to protein domains defined in Pfam.

```
pdoms <- proteins(edb, filter = ~ tx_id %in% txs$transcript &
                           protein_domain_source == "pfam",
                  columns = c("protein_domain_id", "prot_dom_start",
                              "prot_dom_end"))
pdoms
```

```
## DataFrame with 3 rows and 6 columns
##   protein_domain_id prot_dom_start prot_dom_end      protein_id           tx_id
##         <character>      <integer>    <integer>     <character>     <character>
## 1           PF00010            107          164 ENSP00000371785 ENST00000382348
## 2           PF00010            110          162 ENSP00000371794 ENST00000382357
## 3           PF00010            110          162 ENSP00000331040 ENST00000333337
##   protein_domain_source
##             <character>
## 1                  pfam
## 2                  pfam
## 3                  pfam
```

We next map these protein-relative positions to the genome. We define first an
`IRanges` object with the coordinates and submit this to the `proteinToGenome`
function for mapping. Besides coordinates, the function requires also the
respective protein identifiers which we supply as names.

```
pdoms_rng <- IRanges(start = pdoms$prot_dom_start, end = pdoms$prot_dom_end,
                     names = pdoms$protein_id)

pdoms_gnm <- proteinToGenome(pdoms_rng, edb)
```

The result is a `list` of `GRanges` objects with the genomic coordinates at
which the protein domains are encoded, one for each of the input protein
domains. Additional information such as the protein ID, the encoding transcript
and the exons of the respective transcript in which the domain is encoded are
provided as metadata columns.

```
pdoms_gnm
```

```
## $ENSP00000371785
## GRanges object with 1 range and 7 metadata columns:
##       seqnames            ranges strand |      protein_id           tx_id
##          <Rle>         <IRanges>  <Rle> |     <character>     <character>
##   [1]    chr21 33070565-33070738      + | ENSP00000371785 ENST00000382348
##               exon_id exon_rank    cds_ok protein_start protein_end
##           <character> <integer> <logical>     <integer>   <integer>
##   [1] ENSE00001491811         1      TRUE           107         164
##   -------
##   seqinfo: 1 sequence from GRCh38 genome
##
## $ENSP00000371794
## GRanges object with 1 range and 7 metadata columns:
##       seqnames            ranges strand |      protein_id           tx_id
##          <Rle>         <IRanges>  <Rle> |     <character>     <character>
##   [1]    chr21 33027190-33027348      + | ENSP00000371794 ENST00000382357
##               exon_id exon_rank    cds_ok protein_start protein_end
##           <character> <integer> <logical>     <integer>   <integer>
##   [1] ENSE00001491833         2      TRUE           110         162
##   -------
##   seqinfo: 1 sequence from GRCh38 genome
##
## $ENSP00000331040
## GRanges object with 1 range and 7 metadata columns:
##       seqnames            ranges strand |      protein_id           tx_id
##          <Rle>         <IRanges>  <Rle> |     <character>     <character>
##   [1]    chr21 33027190-33027348      + | ENSP00000331040 ENST00000333337
##               exon_id exon_rank    cds_ok protein_start protein_end
##           <character> <integer> <logical>     <integer>   <integer>
##   [1] ENSE00001379164         1      TRUE           110         162
##   -------
##   seqinfo: 1 sequence from GRCh38 genome
```

Column `cds_ok` in the result object indicates whether the length of the CDS of
the encoding transcript matches the length of the protein sequence. For
transcripts with unknown 3’ and/or 5’ CDS ends these will differ. The mapping
result has to be re-organized before being plotted: `Gviz` expects a single
`GRanges` object, with specific metadata columns for the grouping of the
individual genomic regions. This is performed in the code block below.

```
## Convert the list to a GRanges with grouping information
pdoms_gnm_grng <- unlist(GRangesList(pdoms_gnm))
pdoms_gnm_grng$id <- rep(pdoms$protein_domain_id, lengths(pdoms_gnm))
pdoms_gnm_grng$grp <- rep(1:nrow(pdoms), lengths(pdoms_gnm))

pdoms_gnm_grng
```

```
## GRanges object with 3 ranges and 9 metadata columns:
##                   seqnames            ranges strand |      protein_id
##                      <Rle>         <IRanges>  <Rle> |     <character>
##   ENSP00000371785    chr21 33070565-33070738      + | ENSP00000371785
##   ENSP00000371794    chr21 33027190-33027348      + | ENSP00000371794
##   ENSP00000331040    chr21 33027190-33027348      + | ENSP00000331040
##                             tx_id         exon_id exon_rank    cds_ok
##                       <character>     <character> <integer> <logical>
##   ENSP00000371785 ENST00000382348 ENSE00001491811         1      TRUE
##   ENSP00000371794 ENST00000382357 ENSE00001491833         2      TRUE
##   ENSP00000331040 ENST00000333337 ENSE00001379164         1      TRUE
##                   protein_start protein_end          id       grp
##                       <integer>   <integer> <character> <integer>
##   ENSP00000371785           107         164     PF00010         1
##   ENSP00000371794           110         162     PF00010         2
##   ENSP00000331040           110         162     PF00010         3
##   -------
##   seqinfo: 1 sequence from GRCh38 genome
```

We next define the individual tracks we want to visualize and plot them with the
`plotTracks` function from the `Gviz` package.

```
library(Gviz)

## Define the individual tracks:
## - Ideogram
## ideo_track <- IdeogramTrack(genome = "hg38", chromosome = "chr21")
## - Genome axis
gaxis_track <- GenomeAxisTrack()
## - Transcripts
gene_track <- GeneRegionTrack(txs, showId = TRUE, just.group = "right",
                              name = "", geneSymbol = TRUE, size = 0.5)
## - Protein domains
pdom_track <- AnnotationTrack(pdoms_gnm_grng, group = pdoms_gnm_grng$grp,
                              id = pdoms_gnm_grng$id, groupAnnotation = "id",
                              just.group = "right", shape = "box",
                              name = "Protein domains", size = 0.5)

## Generate the plot
plotTracks(list(gaxis_track, gene_track, pdom_track))
```

![Transcripts of genes OLIG1 and OLIG2 encoding a helix-loop-helix protein domain. Shown are all transcripts of the genes OLIG1 and OLIG2 that encode a protein with a helix-loop-helix protein domain (PF00010). Genomic positions encoding protein domains defined in Pfam are shown in light blue.](data:image/png;base64...)

Figure 1: Transcripts of genes OLIG1 and OLIG2 encoding a helix-loop-helix protein domain
Shown are all transcripts of the genes OLIG1 and OLIG2 that encode a protein with a helix-loop-helix protein domain (PF00010). Genomic positions encoding protein domains defined in Pfam are shown in light blue.

All transcripts are relatively short with the full coding region being in a
single exon. Also, both transcripts encode a protein with a single protein
domain, the helix-loop-helix domain PF00010.

Next we repeat the analysis for *SIM2* by first fetching all of its transcript
variants encoding the PF00010 Pfam protein domain from the
database. Subsequently we retrieve all Pfam protein domains encoded in these
transcripts.

```
## Fetch all SIM2 transcripts encoding PF00010
txs <- getGeneRegionTrackForGviz(edb, filter = ~ genename == "SIM2" &
                                          protein_domain_id == "PF00010")
## Fetch all Pfam protein domains within these transcripts
pdoms <- proteins(edb, filter = ~ tx_id %in% txs$transcript &
                           protein_domain_source == "pfam",
                  columns = c("protein_domain_id", "prot_dom_start",
                              "prot_dom_end"))
```

At last we have to map the protein domain coordinates to the genome and prepare
the data for the plot. Since the code is essentially identical to the one for
*OLIG1* and *OLIG2* it is not displayed.

![Transcripts of the gene SIM2 encoding a helix-loop-helix domain. Shown are all transcripts of SIM2 encoding a protein with a helix-loop-helix protein domain (PF00010). Genomic positions encoding protein domains defined in Pfam are shown in light blue.](data:image/png;base64...)

Figure 2: Transcripts of the gene SIM2 encoding a helix-loop-helix domain
Shown are all transcripts of SIM2 encoding a protein with a helix-loop-helix protein domain (PF00010). Genomic positions encoding protein domains defined in Pfam are shown in light blue.

The *SIM2* transcript encodes a protein with in total 4 protein domains. The
helix-loop-helix domain PF00010 is encoded in its first exon.

# 2 Mapping of genomic coordinates to protein-relative positions

One of the known mutations for human red hair color is located at position
16:89920138 (dbSNP ID rs1805009) on the human genome (version GRCh38). Below we
map this genomic coordinate to the respective coordinate within the protein
sequence encoded at that location using the `genomeToProtein` function. Note
that we use `"chr16"` as the name of the chromosome, since we changed the
chromosome naming style to UCSC in the previous example.

```
gnm_pos <- GRanges("chr16", IRanges(89920138, width = 1))
prt_pos <- genomeToProtein(gnm_pos, edb)
prt_pos
```

```
## IRangesList object of length 1:
## [[1]]
## IRanges object with 3 ranges and 8 metadata columns:
##                       start       end     width |           tx_id    cds_ok
##                   <integer> <integer> <integer> |     <character> <logical>
##   ENSP00000451605       294       294         1 | ENST00000555147      TRUE
##   ENSP00000451760       294       294         1 | ENST00000555427      TRUE
##   ENSP00000451560       294       294         1 | ENST00000556922      TRUE
##                           exon_id exon_rank seq_start   seq_end    seq_name
##                       <character> <integer> <integer> <integer> <character>
##   ENSP00000451605 ENSE00002458332         1  89920138  89920138       chr16
##   ENSP00000451760 ENSE00002477640         3  89920138  89920138       chr16
##   ENSP00000451560 ENSE00002507842         1  89920138  89920138       chr16
##                    seq_strand
##                   <character>
##   ENSP00000451605           *
##   ENSP00000451760           *
##   ENSP00000451560           *
```

The genomic position could thus be mapped to the amino acid 294 in each of the 3
proteins listed above. Using the `select` function we retrieve the official
symbol of the gene for these 3 proteins.

```
select(edb, keys = ~ protein_id == names(prt_pos[[1]]), columns = "SYMBOL")
```

```
##          SYMBOL       PROTEINID
## 1 RP11-566K11.2 ENSP00000451560
## 2          MC1R ENSP00000451605
## 3          MC1R ENSP00000451760
```

Two proteins are from the *MC1R* gene and one from *RP11-566K11.2*
(ENSG00000198211) a gene which exons overlap exons from *MC1R* as well as exons
of the more downstream located gene *TUBB3*. To visualize this we first fetch
transcripts overlapping the genomic position of interest and subsequently all
additional transcripts within the region defined by the most downstream and
upstream exons of the transcripts.

```
## Get transcripts overlapping the genomic position.
txs <- getGeneRegionTrackForGviz(edb, filter = GRangesFilter(gnm_pos))

## Get all transcripts within the region from the start of the most 5'
## and end of the most 3' exon.
all_txs <- getGeneRegionTrackForGviz(
    edb, filter = GRangesFilter(range(txs), type = "within"))

## Plot the data
## - Ideogram
## ideo_track <- IdeogramTrack(genome = "hg38", chromosome = "chr16")
## - Genome axis
gaxis_track <- GenomeAxisTrack()
## - Transcripts
gene_track <- GeneRegionTrack(all_txs, showId = TRUE, just.group = "right",
                              name = "", geneSymbol = TRUE, size = 0.5)
## - highlight the region.
hl_track <- HighlightTrack(list(gaxis_track, gene_track), range = gnm_pos)

## Generate the plot
plotTracks(list(hl_track))
```

![Transcripts overlapping, or close to, the genomic position of interest. Shown are all transcripts The genomic position of the variant is highlighted in red.](data:image/png;base64...)

Figure 3: Transcripts overlapping, or close to, the genomic position of interest
Shown are all transcripts The genomic position of the variant is highlighted in red.

In the plot above we see 4 transcripts for which one exon overlaps the genomic
position of the variant: two of the gene *MC1R*, one of *RP11-566K11.2* and one
of *RP11-566K11.4*, a non-coding gene encoded on the reverse strand. Using the
`proteins` method we next extract the sequences of the proteins encoded by the 3
transcripts on the forward strand and determine the amino acid at position 294
in these. To retrieve the results in a format most suitable for the
representation of amino acid sequences we specify `return.type = "AAStringSet"`
in the `proteins` call.

```
## Get the amino acid sequences for the 3 transcripts
prt_seq <- proteins(edb, return.type = "AAStringSet",
                    filter = ~ protein_id == names(prt_pos[[1]]))
## Extract the amino acid at position 294
library(Biostrings)
subseq(prt_seq, start = 294, end = 294)
```

```
## AAStringSet object of length 3:
##     width seq                                               names
## [1]     1 D                                                 ENSP00000451560
## [2]     1 D                                                 ENSP00000451760
## [3]     1 D                                                 ENSP00000451605
```

The amino acid at position 294 is for all an aspartic acid (“D”) which is in
agreement with the reference amino acid of mutation Asp294His (Valverde et al. [1995](#ref-Valverde:1995if))
described by the dbSNP ID of this example.

# 3 Session information

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] Biostrings_2.78.0         XVector_0.50.0
##  [3] Gviz_1.54.0               EnsDb.Hsapiens.v86_2.99.0
##  [5] ensembldb_2.34.0          AnnotationFilter_1.34.0
##  [7] GenomicFeatures_1.62.0    AnnotationDbi_1.72.0
##  [9] Biobase_2.70.0            GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0             IRanges_2.44.0
## [13] S4Vectors_0.48.0          BiocGenerics_0.56.0
## [15] generics_0.1.4            BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   bitops_1.0-9
##   [3] deldir_2.0-4                gridExtra_2.3
##   [5] httr2_1.2.1                 biomaRt_2.66.0
##   [7] rlang_1.1.6                 magrittr_2.0.4
##   [9] biovizBase_1.58.0           matrixStats_1.5.0
##  [11] compiler_4.5.1              RSQLite_2.4.3
##  [13] png_0.1-8                   vctrs_0.6.5
##  [15] stringr_1.5.2               ProtGenerics_1.42.0
##  [17] pkgconfig_2.0.3             crayon_1.5.3
##  [19] fastmap_1.2.0               magick_2.9.0
##  [21] backports_1.5.0             dbplyr_2.5.1
##  [23] Rsamtools_2.26.0            rmarkdown_2.30
##  [25] UCSC.utils_1.6.0            tinytex_0.57
##  [27] bit_4.6.0                   xfun_0.53
##  [29] cachem_1.1.0                cigarillo_1.0.0
##  [31] GenomeInfoDb_1.46.0         jsonlite_2.0.0
##  [33] progress_1.2.3              blob_1.2.4
##  [35] DelayedArray_0.36.0         BiocParallel_1.44.0
##  [37] jpeg_0.1-11                 parallel_4.5.1
##  [39] prettyunits_1.2.0           cluster_2.1.8.1
##  [41] VariantAnnotation_1.56.0    R6_2.6.1
##  [43] bslib_0.9.0                 stringi_1.8.7
##  [45] RColorBrewer_1.1-3          rtracklayer_1.70.0
##  [47] rpart_4.1.24                jquerylib_0.1.4
##  [49] Rcpp_1.1.0                  bookdown_0.45
##  [51] SummarizedExperiment_1.40.0 knitr_1.50
##  [53] base64enc_0.1-3             nnet_7.3-20
##  [55] Matrix_1.7-4                tidyselect_1.2.1
##  [57] rstudioapi_0.17.1           dichromat_2.0-0.1
##  [59] abind_1.4-8                 yaml_2.3.10
##  [61] codetools_0.2-20            curl_7.0.0
##  [63] lattice_0.22-7              tibble_3.3.0
##  [65] KEGGREST_1.50.0             S7_0.2.0
##  [67] evaluate_1.0.5              foreign_0.8-90
##  [69] BiocFileCache_3.0.0         pillar_1.11.1
##  [71] BiocManager_1.30.26         filelock_1.0.3
##  [73] MatrixGenerics_1.22.0       checkmate_2.3.3
##  [75] RCurl_1.98-1.17             hms_1.1.4
##  [77] ggplot2_4.0.0               scales_1.4.0
##  [79] glue_1.8.0                  Hmisc_5.2-4
##  [81] lazyeval_0.2.2              tools_4.5.1
##  [83] interp_1.1-6                BiocIO_1.20.0
##  [85] data.table_1.17.8           BSgenome_1.78.0
##  [87] GenomicAlignments_1.46.0    XML_3.99-0.19
##  [89] latticeExtra_0.6-31         colorspace_2.1-2
##  [91] htmlTable_2.4.3             restfulr_0.0.16
##  [93] Formula_1.2-5               cli_3.6.5
##  [95] rappdirs_0.3.3              S4Arrays_1.10.0
##  [97] dplyr_1.1.4                 gtable_0.3.6
##  [99] sass_0.4.10                 digest_0.6.37
## [101] SparseArray_1.10.0          htmlwidgets_1.6.4
## [103] rjson_0.2.23                farver_2.1.2
## [105] memoise_2.0.1               htmltools_0.5.8.1
## [107] lifecycle_1.0.4             httr_1.4.7
## [109] bit64_4.6.0-1
```

# References

Chakrabarti, Lina, Tyler K Best, Nathan P Cramer, Rosalind S E Carney, John T R Isaac, Zygmunt Galdzicki, and Tarik F Haydar. 2010. “Olig1 and Olig2 triplication causes developmental brain defects in Down syndrome.” *Nature Neuroscience* 13 (8): 927–34.

Gardiner, Katheleen, and Alberto C S Costa. 2006. “The proteins of human chromosome 21.” *American Journal of Medical Genetics. Part C, Seminars in Medical Genetics* 142C (3): 196–205.

Hahne, Florian, and Robert Ivanek. 2016. “Visualizing Genomic Data Using Gviz and Bioconductor.” *Methods in Molecular Biology (Clifton, N.J.)* 1418 (Chapter 16): 335–51.

Lana-Elola, Eva, Sheona D Watson-Scales, Elizabeth M C Fisher, and Victor L J Tybulewicz. 2011. “Down syndrome: searching for the genetic culprits.” *Disease Models & Mechanisms* 4 (5): 586–95.

Massari, M E, and C Murre. 2000. “Helix-loop-helix proteins: regulators of transcription in eucaryotic organisms.” *Molecular and Cellular Biology* 20 (2): 429–40.

Valverde, P, E Healy, I Jackson, J L Rees, and A J Thody. 1995. “Variants of the melanocyte-stimulating hormone receptor gene are associated with red hair and fair skin in humans.” *Nature Genetics* 11 (3): 328–30.