# Airway smooth muscle cells

Here we provide the code which was used to contruct the
*RangedSummarizedExperiment* object of the *airway* experiment data
package. The experiment citation is:

Himes BE, Jiang X, Wagner P, Hu R, Wang Q, Klanderman B, Whitaker RM,
Duan Q, Lasky-Su J, Nikolos C, Jester W, Johnson M, Panettieri R Jr,
Tantisira KG, Weiss ST, Lu Q. “RNA-Seq Transcriptome Profiling
Identifies CRISPLD2 as a Glucocorticoid Responsive Gene that Modulates
Cytokine Function in Airway Smooth Muscle Cells.” PLoS One. 2014 Jun
13;9(6):e99625.
PMID: [24926665](http://www.ncbi.nlm.nih.gov/pubmed/24926665).
GEO: [GSE52778](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE52778).

From the abstract, a brief description of the RNA-Seq experiment on
airway smooth muscle (ASM) cell lines: “Using RNA-Seq, a
high-throughput sequencing method, we characterized transcriptomic
changes in four primary human ASM cell lines that were treated with
dexamethasone - a potent synthetic glucocorticoid (1 micromolar for 18
hours).”

**Note:** in version 1.6, the package was updated to include two
samples, SRR1039508 and SRR1039509, quantified using Salmon, in order
to demonstrate the tximport/tximeta Bioconductor packages. For details
on the quantification steps for these files, consult the airway2
package: <https://github.com/mikelove/airway2>. Another dataset,
labelled `gse` was added to the *airway* package, which contains the
*SummarizedExperiment* object obtained after loading quantification
data for all 8 samples into R/Bioconductor using the *tximeta*
package, first running `tximeta` and then `summarizeToGene`.

# Obtaining sample information from GEO

The following code chunk obtains the sample information from the
series matrix file downloaded from GEO. The columns are then parsed
and new columns with shorter names and factor levels are added.

```
suppressPackageStartupMessages( library( "GEOquery" ) )
suppressPackageStartupMessages( library( "airway" ) )
dir <- system.file("extdata",package="airway")
geofile <- file.path(dir, "GSE52778_series_matrix.txt")
gse <- getGEO(filename=geofile)
pdata <- pData(gse)[,grepl("ch1",names(pData(gse)))]
names(pdata) <- c("treatment","tissue","ercc_mix","cell","celltype")
pdataclean <- data.frame(treatment=sub("treatment: (.*)","\\1",pdata$treatment),
                         cell=sub("cell line: (.*)","\\1",pdata$cell),
                         row.names=rownames(pdata))
pdataclean$dex <- ifelse(grepl("Dex",pdataclean$treatment),"trt","untrt")
pdataclean$albut <- ifelse(grepl("Albut",pdataclean$treatment),"trt","untrt")
pdataclean$SampleName <- rownames(pdataclean)
pdataclean$treatment <- NULL
```

The information which connects the sample information from GEO with
the SRA run id is downloaded from
[SRA](http://www.ncbi.nlm.nih.gov/sra/?term=SRP033351) using the
**Send to: File** button.

```
srafile <- file.path(dir, "SraRunInfo_SRP033351.csv")
srp <- read.csv(srafile)
srpsmall <- srp[,c("Run","avgLength","Experiment","Sample","BioSample","SampleName")]
```

These two *data.frames* are merged and then we subset to only the
samples not treated with albuterol (these samples were not included in
the analysis of the publication).

```
coldata <- merge(pdataclean, srpsmall, by="SampleName")
rownames(coldata) <- coldata$Run
coldata <- coldata[coldata$albut == "untrt",]
coldata$albut <- NULL
coldata
```

```
##            SampleName                                     cell   dex        Run
## SRR1039508 GSM1275862 tissue: human airway smooth muscle cells untrt SRR1039508
## SRR1039509 GSM1275863 tissue: human airway smooth muscle cells untrt SRR1039509
## SRR1039510 GSM1275864 tissue: human airway smooth muscle cells untrt SRR1039510
## SRR1039511 GSM1275865 tissue: human airway smooth muscle cells untrt SRR1039511
## SRR1039512 GSM1275866 tissue: human airway smooth muscle cells untrt SRR1039512
## SRR1039513 GSM1275867 tissue: human airway smooth muscle cells untrt SRR1039513
## SRR1039514 GSM1275868 tissue: human airway smooth muscle cells untrt SRR1039514
## SRR1039515 GSM1275869 tissue: human airway smooth muscle cells untrt SRR1039515
## SRR1039516 GSM1275870 tissue: human airway smooth muscle cells untrt SRR1039516
## SRR1039517 GSM1275871 tissue: human airway smooth muscle cells untrt SRR1039517
## SRR1039518 GSM1275872 tissue: human airway smooth muscle cells untrt SRR1039518
## SRR1039519 GSM1275873 tissue: human airway smooth muscle cells untrt SRR1039519
## SRR1039520 GSM1275874 tissue: human airway smooth muscle cells untrt SRR1039520
## SRR1039521 GSM1275875 tissue: human airway smooth muscle cells untrt SRR1039521
## SRR1039522 GSM1275876 tissue: human airway smooth muscle cells untrt SRR1039522
## SRR1039523 GSM1275877 tissue: human airway smooth muscle cells untrt SRR1039523
##            avgLength Experiment    Sample    BioSample
## SRR1039508       126  SRX384345 SRS508568 SAMN02422669
## SRR1039509       126  SRX384346 SRS508567 SAMN02422675
## SRR1039510       126  SRX384347 SRS508570 SAMN02422668
## SRR1039511       126  SRX384348 SRS508569 SAMN02422667
## SRR1039512       126  SRX384349 SRS508571 SAMN02422678
## SRR1039513        87  SRX384350 SRS508572 SAMN02422670
## SRR1039514       126  SRX384351 SRS508574 SAMN02422681
## SRR1039515       114  SRX384352 SRS508573 SAMN02422671
## SRR1039516       120  SRX384353 SRS508575 SAMN02422682
## SRR1039517       126  SRX384354 SRS508576 SAMN02422673
## SRR1039518       126  SRX384355 SRS508578 SAMN02422679
## SRR1039519       107  SRX384356 SRS508577 SAMN02422672
## SRR1039520       101  SRX384357 SRS508579 SAMN02422683
## SRR1039521        98  SRX384358 SRS508580 SAMN02422677
## SRR1039522       125  SRX384359 SRS508582 SAMN02422680
## SRR1039523       126  SRX384360 SRS508581 SAMN02422674
```

Finally, the sample table was saved to a CSV file for future
reference. This file is included in the `inst/extdata` directory of
this package.

```
write.csv(coldata, file="sample_table.csv")
```

# Downloading FASTQ files from SRA

A file containing the SRA run numbers was created: `files`. This
file was used to download the sequenced reads from the SRA using
`wget`. The following command was used to extract the FASTQ file from
the `.sra` files, using the
[SRA Toolkit](http://www.ncbi.nlm.nih.gov/books/NBK47540/)

```
cat files | parallel -j 7 fastq-dump --split-files {}.sra
```

# Aligning reads

The reads were aligned using the
[STAR read aligner](https://code.google.com/p/rna-star/)
to GRCh37 using the annotations from Ensembl release 75.

```
for f in `cat files`; do STAR --genomeDir ../STAR/ENSEMBL.homo_sapiens.release-75 \
--readFilesIn fastq/$f\_1.fastq fastq/$f\_2.fastq \
--runThreadN 12 --outFileNamePrefix aligned/$f.; done
```

[SAMtools](http://samtools.sourceforge.net/) was used to generate BAM files.

```
cat files | parallel -j 7 samtools view -bS aligned/{}.Aligned.out.sam -o aligned/{}.bam
```

# Counting reads

A transcript database for the homo sapiens Ensembl genes was obtained
from Biomart.

```
library( "GenomicFeatures" )
txdb <- makeTranscriptDbFromBiomart( biomart="ensembl", dataset="hsapiens_gene_ensembl")
exonsByGene <- exonsBy( txdb, by="gene" )
```

The BAM files were specified using the `SRR` id from the SRA. A yield
size of 2 million reads was used to cap the memory used during
read counting.

```
sampleTable <- read.csv( "sample_table.csv", row.names=1 )
fls <- file.path("aligned",rownames(sampleTable), ".bam")
library( "Rsamtools" )
bamLst <- BamFileList( fls, yieldSize=2000000 )
```

The following `summarizeOverlaps` call distributed the 8 paired-end
BAM files to 8 workers. This used a maximum of 16 Gb per worker and
the time elapsed was 50 minutes.

```
library( "BiocParallel" )
register( MulticoreParam( workers=8 ) )
library( "GenomicAlignments" )
airway <- summarizeOverlaps( features=exonsByGene, reads=bamLst,
                            mode="Union", singleEnd=FALSE,
                            ignore.strand=TRUE, fragments=TRUE )
```

The sample information was then added as column data.

```
colData(airway) <- DataFrame( sampleTable )
```

Finally, we attached the `MIAME` information using the Pubmed ID.

```
library( "annotate" )
miame <- list(pmid2MIAME("24926665"))
miame[[1]]@url <- "http://www.ncbi.nlm.nih.gov/pubmed/24926665"
# because R's CHECK doesn't like non-ASCII characters in data objects
# or in vignettes. the actual char was used in the first argument
miame[[1]]@abstract <- gsub("micro","micro",abstract(miame[[1]]))
miame[[1]]@abstract <- gsub("beta","beta",abstract(miame[[1]]))
metadata(airway) <- miame
save(airway, file="airway.RData")
```

# Information on the RangedSummarizedExperiment

Below we print out some basic summary statistics on the `airway`
object which is provided by this experiment data package.

```
library("airway")
data(airway)
airway
```

```
## class: RangedSummarizedExperiment
## dim: 63677 8
## metadata(1): ''
## assays(1): counts
## rownames(63677): ENSG00000000003 ENSG00000000005 ... ENSG00000273492
##   ENSG00000273493
## rowData names(10): gene_id gene_name ... seq_coord_system symbol
## colnames(8): SRR1039508 SRR1039509 ... SRR1039520 SRR1039521
## colData names(9): SampleName cell ... Sample BioSample
```

```
as.data.frame(colData(airway))
```

```
##            SampleName    cell   dex albut        Run avgLength Experiment
## SRR1039508 GSM1275862  N61311 untrt untrt SRR1039508       126  SRX384345
## SRR1039509 GSM1275863  N61311   trt untrt SRR1039509       126  SRX384346
## SRR1039512 GSM1275866 N052611 untrt untrt SRR1039512       126  SRX384349
## SRR1039513 GSM1275867 N052611   trt untrt SRR1039513        87  SRX384350
## SRR1039516 GSM1275870 N080611 untrt untrt SRR1039516       120  SRX384353
## SRR1039517 GSM1275871 N080611   trt untrt SRR1039517       126  SRX384354
## SRR1039520 GSM1275874 N061011 untrt untrt SRR1039520       101  SRX384357
## SRR1039521 GSM1275875 N061011   trt untrt SRR1039521        98  SRX384358
##               Sample    BioSample
## SRR1039508 SRS508568 SAMN02422669
## SRR1039509 SRS508567 SAMN02422675
## SRR1039512 SRS508571 SAMN02422678
## SRR1039513 SRS508572 SAMN02422670
## SRR1039516 SRS508575 SAMN02422682
## SRR1039517 SRS508576 SAMN02422673
## SRR1039520 SRS508579 SAMN02422683
## SRR1039521 SRS508580 SAMN02422677
```

```
summary(colSums(assay(airway))/1e6)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   15.16   19.05   20.90   21.94   24.67   30.82
```

```
metadata(rowRanges(airway))
```

```
## $genomeInfo
## $genomeInfo$`Db type`
## [1] "TranscriptDb"
##
## $genomeInfo$`Supporting package`
## [1] "GenomicFeatures"
##
## $genomeInfo$`Data source`
## [1] "BioMart"
##
## $genomeInfo$Organism
## [1] "Homo sapiens"
##
## $genomeInfo$`Resource URL`
## [1] "www.biomart.org:80"
##
## $genomeInfo$`BioMart database`
## [1] "ensembl"
##
## $genomeInfo$`BioMart database version`
## [1] "ENSEMBL GENES 75 (SANGER UK)"
##
## $genomeInfo$`BioMart dataset`
## [1] "hsapiens_gene_ensembl"
##
## $genomeInfo$`BioMart dataset description`
## [1] "Homo sapiens genes (GRCh37.p13)"
##
## $genomeInfo$`BioMart dataset version`
## [1] "GRCh37.p13"
##
## $genomeInfo$`Full dataset`
## [1] "yes"
##
## $genomeInfo$`miRBase build ID`
## [1] NA
##
## $genomeInfo$transcript_nrow
## [1] "215647"
##
## $genomeInfo$exon_nrow
## [1] "745593"
##
## $genomeInfo$cds_nrow
## [1] "537555"
##
## $genomeInfo$`Db created by`
## [1] "GenomicFeatures package from Bioconductor"
##
## $genomeInfo$`Creation time`
## [1] "2014-07-10 14:55:55 -0400 (Thu, 10 Jul 2014)"
##
## $genomeInfo$`GenomicFeatures version at creation time`
## [1] "1.17.9"
##
## $genomeInfo$`RSQLite version at creation time`
## [1] "0.11.4"
##
## $genomeInfo$DBSCHEMAVERSION
## [1] "1.0"
```

# Information on the genes

In January 2023, information was added to the `rowData`:

```
rowData(airway)
```

```
## DataFrame with 63677 rows and 10 columns
##                         gene_id     gene_name  entrezid   gene_biotype
##                     <character>   <character> <integer>    <character>
## ENSG00000000003 ENSG00000000003        TSPAN6        NA protein_coding
## ENSG00000000005 ENSG00000000005          TNMD        NA protein_coding
## ENSG00000000419 ENSG00000000419          DPM1        NA protein_coding
## ENSG00000000457 ENSG00000000457         SCYL3        NA protein_coding
## ENSG00000000460 ENSG00000000460      C1orf112        NA protein_coding
## ...                         ...           ...       ...            ...
## ENSG00000273489 ENSG00000273489 RP11-180C16.1        NA      antisense
## ENSG00000273490 ENSG00000273490        TSEN34        NA protein_coding
## ENSG00000273491 ENSG00000273491  RP11-138A9.2        NA        lincRNA
## ENSG00000273492 ENSG00000273492    AP000230.1        NA        lincRNA
## ENSG00000273493 ENSG00000273493  RP11-80H18.4        NA        lincRNA
##                 gene_seq_start gene_seq_end              seq_name seq_strand
##                      <integer>    <integer>           <character>  <integer>
## ENSG00000000003       99883667     99894988                     X         -1
## ENSG00000000005       99839799     99854882                     X          1
## ENSG00000000419       49551404     49575092                    20         -1
## ENSG00000000457      169818772    169863408                     1         -1
## ENSG00000000460      169631245    169823221                     1          1
## ...                        ...          ...                   ...        ...
## ENSG00000273489      131178723    131182453                     7         -1
## ENSG00000273490       54693789     54697585 HSCHR19LRC_LRC_J_CTG1          1
## ENSG00000273491      130600118    130603315          HG1308_PATCH          1
## ENSG00000273492       27543189     27589700                    21          1
## ENSG00000273493       58315692     58315845                     3          1
##                 seq_coord_system        symbol
##                        <integer>   <character>
## ENSG00000000003               NA        TSPAN6
## ENSG00000000005               NA          TNMD
## ENSG00000000419               NA          DPM1
## ENSG00000000457               NA         SCYL3
## ENSG00000000460               NA      C1orf112
## ...                          ...           ...
## ENSG00000273489               NA RP11-180C16.1
## ENSG00000273490               NA        TSEN34
## ENSG00000273491               NA  RP11-138A9.2
## ENSG00000273492               NA    AP000230.1
## ENSG00000273493               NA  RP11-80H18.4
```

This was generated with the following (un-evaluated) code chunk:

```
library(AnnotationHub)
ah <- AnnotationHub()
Gtf <- query(ah, c("Homo sapiens", "release-75"))[1]
library(ensembldb)
DbFile <- ensDbFromAH(Gtf)
edb <- EnsDb(DbFile)
g <- genes(edb, return.type="DataFrame")
rownames(g) <- g$gene_id
rowData(airway) <- g[rownames(airway),]
```

# Session information

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
##  [1] airway_1.30.0               SummarizedExperiment_1.40.0
##  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [5] IRanges_2.44.0              S4Vectors_0.48.0
##  [7] MatrixGenerics_1.22.0       matrixStats_1.5.0
##  [9] GEOquery_2.78.0             Biobase_2.70.0
## [11] BiocGenerics_0.56.0         generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3      tidyr_1.3.1         SparseArray_1.10.0
##  [4] xml2_1.4.1          lattice_0.22-7      hms_1.1.4
##  [7] magrittr_2.0.4      evaluate_1.0.5      grid_4.5.1
## [10] R.oo_1.27.1         jsonlite_2.0.0      Matrix_1.7-4
## [13] R.utils_2.13.0      limma_3.66.0        purrr_1.1.0
## [16] XML_3.99-0.19       httr2_1.2.1         abind_1.4-8
## [19] cli_3.6.5           rlang_1.1.6         XVector_0.50.0
## [22] R.methodsS3_1.8.2   withr_3.0.2         DelayedArray_0.36.0
## [25] S4Arrays_1.10.0     tools_4.5.1         tzdb_0.5.0
## [28] dplyr_1.1.4         curl_7.0.0          vctrs_0.6.5
## [31] R6_2.6.1            lifecycle_1.0.4     pkgconfig_2.0.3
## [34] pillar_1.11.1       rentrez_1.2.4       data.table_1.17.8
## [37] glue_1.8.0          statmod_1.5.1       xfun_0.53
## [40] tibble_3.3.0        tidyselect_1.2.1    knitr_1.50
## [43] readr_2.1.5         compiler_4.5.1
```