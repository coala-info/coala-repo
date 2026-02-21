# consensusDE: DE analysis using multiple algorithms

#### Ashley J. Waardenberg

#### Last modified: 2019-04-25. Compiled: 2025-10-29

# 1 Introduction to consensusDE

consensusDE aims to make differential expression (DE) analysis, with reporting of significance scores from multiple methods, with and without removal of unwanted variation (RUV) ***easy***. It implements voom/limma, DESeq2 and edgeR and reports differential expression results seperately for each algorithm, as well as merging the results into a single table for determining ***consensus***. The results of the merged table, are ordered by the summed ranks of p-values for each algorithm, the intersect at minimum p-value thresholds accross all methods is provided as the p\_intersect, in addition to a number of statistics (see below).

consensusDE is simplified into two functions:

* **`buildSummarized()`** generate a summarized experiment that counts reads mapped (from bam files or htseq count files) against a transcriptome
* **`multi_de_pairs()`** perform DE analysis (all possible pairwise comparisons)

Below the core functionality of consensusDE as well as how to plot results using the `diag_plots` function.

# 2 consensusDE examples

Begin by first installing and loading the `consensusDE` library. To illustrate functionality of `consensusDE`, we will utilise RNA-seq data from the `airway` and annotation libraries as follows. Begin by installing and attaching data from these libraries as follows:

```
# load consensusDE
library(consensusDE)

# load airway and dm3/Hs transcript database for example annotation
library(airway)
library(TxDb.Dmelanogaster.UCSC.dm3.ensGene)
library(EnsDb.Hsapiens.v86)
library(org.Hs.eg.db)

data("airway")
```

# 3 Building a summarized experiment

A summarized experiment is an object that stores all relevant information for performing differential expression analysis. `buildSummarized()` allows users to build a summarized experiment object by simply providing 1) a table of bam/htseq files (more below on format), 2) the directory of where to locate files and 3) a transcript database to map the reads to (either a gtf file or txdb). Below we will use bam files (from GenomicAlignments) as an example for creating a summarized experiment:

```
# build a design table that lists the files and their grouping
file_list <- list.files(system.file("extdata", package="GenomicAlignments"),
                        recursive = TRUE,
                        pattern = "*bam$",
                        full = TRUE)

# Prepare a sample table to be used with buildSummarized()
# must be comprised of a minimum of two columns, named "file" and "group",
# with one additional column: "pairs" if the data is paired

sample_table <- data.frame("file" = basename(file_list),
                           "group" = c("treat", "untreat"))

# extract the path to the bam directory - where to search for files listed in "sample_table"
bam_dir <- as.character(gsub(basename(file_list)[1], "", file_list[1]))
```

The minimum information is now ready to build a summarized experiment:

```
# NB. force_build = TRUE, is set to allow the Summarized Experiment to be built.
# This will report a Warning message that less than two replicates are present
# in the sample_table.

summarized_dm3 <- buildSummarized(sample_table = sample_table,
                                  bam_dir = bam_dir,
                                  tx_db = TxDb.Dmelanogaster.UCSC.dm3.ensGene,
                                  read_format = "paired",
                                  force_build = TRUE)
```

```
## strand_mode is defined as 0 (unstranded). This is appropriate for
##                 unstranded protocols, or if you wish to ignore strandedness when
##                 counting reads. See ?strandMode in GenomicAlignments for more
##                 information.
```

This will output a summarized object that has mapped the reads for the bam files that are listed in `sample_table`, located in `bam_dir`, against the transcript database provided: `TxDb.Dmelanogaster.UCSC.dm3.ensGene`. Bam file format, whether “paired” or “single” end (the type of sequencing technology used) must be specified using the `read_format` parameter.gtf formatted transcript databases can also be used instead of a txdb, by providing the full path to the gtf file using the `gtf` parameter. To save a summarized experiment externally, for future use, specify a path to save the summarized experiment using `output_log`.

`strand_mode` is used to define how the stranded library prep protocol treated the strand. For paired data, this is used to indicate how the strand is inferred from the first and last fragments in the paired reads. If the protocol was unstranded or stranding should be ignored, `strand_mode = 0`. `ConsensusDE` calls `strand_mode = 0` by default. If the protocol was stranded and the strand of the read is the strand of the first fragment (or read in single ended libraries), `strand_mode = 1`. If the protocol was stranded and the strand of the read is the strand of the second fragment (or reverse of the read in single ended libraries) , `strand_mode = 2`. For more information, see ?strandMode in the Genomic Alignments package.

To see details of all parameters see `?buildSummarized`.

Overview of the summarized experiment:

```
summarized_dm3
```

```
## class: RangedSummarizedExperiment
## dim: 15682 2
## metadata(2): gene_coords sample_table
## assays(1): counts
## rownames(15682): FBgn0000003 FBgn0000008 ... FBgn0264726 FBgn0264727
## rowData names(0):
## colnames(2): sm_treated1.bam sm_untreated1.bam
## colData names(2): file group
```

## 3.1 Filtering low count data

`buildSummarized()` also allows users to filter out low read counts. This can be done when building the summarized experiment, or re-running with the summarized experiment output using `buildSummarized()`. See “Performing Differential Expresssion” below with filter example.

## 3.2 Building a tx\_db object first

Sometimes it will be convenient to first build a `txdb` object and then pass this `txdb` object to buildSummarized using the tx\_db parameter. This can be done as follows:

`txdb <- makeTxDbFromGFF("/path/to/my.gtf", format="gtf", circ_seqs=character())`

# 4 Performing Differential Expresssion

For differential expression (DE) analysis we will use the `airway` RNA-seq data for demonstration. See `?airway` for more details about this experiment. NOTE: the summarized meta-data must include the columns “group” and “file” to build the correct models. For illustration, we sample 1000 genes from this dataset.

```
# for compatability for DE analysis, add "group" and "file" columns
colData(airway)$group <- colData(airway)$dex
colData(airway)$file <- rownames(colData(airway))

# filter low count data
airway_filter <- buildSummarized(summarized = airway,
                                 filter = TRUE)

# for illustration, we only use sa random sample of 1000 transcripts
set.seed(1234)
airway_filter <- sample(airway_filter, 1000)

# call multi_de_pairs()
all_pairs_airway <- multi_de_pairs(summarized = airway_filter,
                                   paired = "unpaired",
                                   ruv_correct = FALSE)
```

Running `multi_de_pairs()` will perform DE analysis on all possible pairs of “groups” and save these results as a simple list of “merged” - being the merged results of “deseq”, “voom” and “edger” into one table, as well as the latter three as objects independently. The data frame is sorted by the `rank_sum`. The following columns are included:

* `ID` - Identifier
* `AveExpr` - Average Expression (average of edgeR, DESeq2 and voom)
* `LogFC` - Log2 Fold-Change, also known as a log-ratio (average of edgeR, DESeq2 and voom)
* `LogFC_sd` - Log2 Fold-Change standard deviation of LogFC (average)
* `edger_adj_p` - EdgeR p-value adjusted for multiple hypotheses
* `deseq_adj_p` - DESeq2 p-value adjusted for multiple hypotheses
* `voom_adj_p` - Limma/voom p-value adjusted for multiple hypotheses
* `edger_rank` - rank of the p-value obtained by EdgeR
* `deseq_rank` - rank of the p-value obtained by DESeq2
* `voom_rank` - rank of the p-value obtained by Limma/voom
* `rank_sum` - sum of the ranks from edger\_rank, voom\_rank, rank\_sum
* `p_intersect` - the largest p-value observed from all methods tested.
  + This represents the intersect when a threshold is set on the p\_intersect column
* `p_union` - the smallest p-value observed from all methods tested.
  + This represents the union when a threshold is set on the p\_union column To access the merged results:

```
# To view all the comparisons conducted:
names(all_pairs_airway$merged)
```

```
## [1] "untrt-trt"
```

```
# [1] "untrt-trt"

# to access data of a particular comparison
head(all_pairs_airway$merged[["untrt-trt"]])
```

```
##                ID  AveExpr     LogFC  LogFC_sd  edger_adj_p  deseq_adj_p
## 1 ENSG00000120129 11.38754 -2.811114 0.1117915 2.472149e-37 6.013628e-44
## 2 ENSG00000116584 11.02552  1.153054 0.1094854 6.872891e-16 9.643002e-42
## 3 ENSG00000139289 10.83881  1.131073 0.1097700 4.330840e-13 2.233808e-24
## 4 ENSG00000103196 11.26943 -2.540558 0.1368329 4.823634e-16 1.665175e-21
## 5 ENSG00000077684 10.46766 -1.066139 0.1135244 8.530852e-11 1.290408e-26
## 6 ENSG00000211445 13.09005 -3.598231 0.1162162 1.143069e-14 2.170616e-19
##     voom_adj_p edger_rank deseq_rank voom_rank rank_sum  p_intersect
## 1 4.183037e-05          1          1       1.0      3.0 4.183037e-05
## 2 2.130314e-04          3          2       2.0      7.0 2.130314e-04
## 3 5.371290e-04          5          5       3.5     13.5 5.371290e-04
## 4 9.361103e-04          2          6       6.5     14.5 9.361103e-04
## 5 5.371290e-04          9          3       3.5     15.5 5.371290e-04
## 6 9.361103e-04          4          9       6.5     19.5 9.361103e-04
##        p_union
## 1 6.013628e-44
## 2 9.643002e-42
## 3 2.233808e-24
## 4 1.665175e-21
## 5 1.290408e-26
## 6 2.170616e-19
```

## 4.1 Annotating DE results

It is *recommended* to annotate with a GTF file byt providing the full path of a gtf file to the gtf\_annotate parameter, in combination with a tx\_db. If no tx\_db is provided and the gtf path is provided, only gene symbol annotations will be performed.

Currently only ENSEMBL annotations are supported with the tx\_db option.

It is often useful to add additional annotated information to the output tables. This can be achieved by providing a database for annotations via `ensembl_annotate`. Annotations needs to be a Genome Wide Annotation object, e.g. `org.Mm.eg.db` for mouse or `org.Hs.eg.db` for human from BioConductor. For example, to install the database for the mouse annotation, go to <http://bioconductor.org/packages/org.Mm.eg.db> and follow the instructions. Ensure that after installing the database package that the library is loaded using `library(org.Mm.eg.db)`. When running, “‘select()’ returned 1:many mapping between keys and columns” will appear on the command line. This is the result of multiple mapped transcript ID to Annotations. Only the first annotation is reported. See `?multi_de_pairs` for additional documentation.

An example of annotating the above filtered airway data is provided below:

```
# first ensure annotation database in installed
#library(org.Hs.eg.db)
#library(EnsDb.Hsapiens.v86)

# Preloaded summarized file did not contain meta-data of the tx_db. This is important if you want to extract chromosome coordinates. This can be easily updated by rerunning buildSummarized with the tx_db of choice.
airway_filter <- buildSummarized(summarized = airway_filter,
                                 tx_db = EnsDb.Hsapiens.v86,
                                 filter = FALSE)
```

```
## Warning in buildSummarized(summarized = airway_filter, tx_db = EnsDb.Hsapiens.v86, : No output directory provided. The se file and sample_table will not
##           be saved
```

```
# call multi_de_pairs(),
# set ensembl_annotate argument to org.Hs.eg.db
all_pairs_airway <- multi_de_pairs(summarized = airway_filter,
                                   paired = "unpaired",
                                   ruv_correct = FALSE,
                                   ensembl_annotate = org.Hs.eg.db)

# to access data of a particular comparison
head(all_pairs_airway$merged[["untrt-trt"]])
```

```
##                  ID  AveExpr     LogFC  LogFC_sd  edger_adj_p  deseq_adj_p
## 275 ENSG00000120129 11.38754 -2.811114 0.1117915 2.472149e-37 6.013628e-44
## 245 ENSG00000116584 11.02552  1.153054 0.1094854 6.872891e-16 9.643002e-42
## 395 ENSG00000139289 10.83881  1.131073 0.1097700 4.330840e-13 2.233808e-24
## 149 ENSG00000103196 11.26943 -2.540558 0.1368329 4.823634e-16 1.665175e-21
## 90  ENSG00000077684 10.46766 -1.066139 0.1135244 8.530852e-11 1.290408e-26
## 807 ENSG00000211445 13.09005 -3.598231 0.1162162 1.143069e-14 2.170616e-19
##       voom_adj_p edger_rank deseq_rank voom_rank rank_sum  p_intersect
## 275 4.183037e-05          1          1       1.0      3.0 4.183037e-05
## 245 2.130314e-04          3          2       2.0      7.0 2.130314e-04
## 395 5.371290e-04          5          5       3.5     13.5 5.371290e-04
## 149 9.361103e-04          2          6       6.5     14.5 9.361103e-04
## 90  5.371290e-04          9          3       3.5     15.5 5.371290e-04
## 807 9.361103e-04          4          9       6.5     19.5 9.361103e-04
##          p_union                                                 genename
## 275 6.013628e-44                           dual specificity phosphatase 1
## 245 9.643002e-42             Rho/Rac guanine nucleotide exchange factor 2
## 395 2.233808e-24        pleckstrin homology like domain family A member 1
## 149 1.665175e-21 cysteine rich secretory protein LCCL domain containing 2
## 90  1.290408e-26                                 jade family PHD finger 1
## 807 2.170616e-19                                 glutathione peroxidase 3
##       symbol  kegg                   coords strand  width
## 275    DUSP1 04010 chr5:172768090-172771195      -   3106
## 245  ARHGEF2 05130 chr1:155946851-156007070      -  60220
## 395   PHLDA1  <NA>  chr12:76025447-76033932      -   8486
## 149 CRISPLD2  <NA>  chr16:84819984-84920768      + 100785
## 90     JADE1  <NA> chr4:128809623-128875224      +  65602
## 807     GPX3 00480 chr5:151020438-151028993      +   8556
```

The following additional columns will now be present:

* `genename` - extend gene names (e.g. alpha-L-fucosidase 2)
* `symbol` - gene symbol (e.g. FUCA2)
* `kegg` - kegg pathway identifier (e.g. 00511)

If metadata for the transcript database used to build the summarized experiment was included, the following annotations will also be included:

* `coords` - chromosomal coordinates (e.g. chr6:143494811-143511690)
* `strand` - strand transcript is on (i.e. + or -)
* `width` - transcript width in base pairs (bp) (transcript start to end) (e.g. 16880 bp)

## 4.2 Writing tables to an output directory

`multi_de_pairs` provides options to automatically write all results to output directories when a full path is provided. Which results are output depends on which directories are provided. Full paths provided to the parameters of `output_voom`, `output_edger`, `output_deseq` and `output_combined` will output Voom, EdgeR, DEseq and the merged results to the directories provided, respectively.

# 5 Removing unwanted variation (RUV)

consensusDE also provides the option to remove batch effects through RUVseq functionality. consensusDE currently implements RUVr which models a first pass generalised linear model (GLM) using EdgeR and obtaining residuals for incorporation into the SummarizedExperiment object for inclusion in the models for DE analysis. The following example, uses RUV to identify these residuals. To view the residuals in the model see the resisuals section below in the plotting functions. Note, that if `ruv_correct = TRUE` and a path to a `plot_dir` is provided, diagnostic plots before and after RUV correction will be produced. The residuals can also be accessed in the summarizedExperiment as below. These are present in the “W\_1” column. At present only one factor of variation is determined.

```
# call multi_de_pairs()
all_pairs_airway_ruv <- multi_de_pairs(summarized = airway_filter,
                                       paired = "unpaired",
                                       ruv_correct = TRUE)

# access the summarized experiment (now including the residuals under the "W_1" column)
all_pairs_airway_ruv$summarized@phenoData@data
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
##               Sample    BioSample group       file         W_1
## SRR1039508 SRS508568 SAMN02422669 untrt SRR1039508 -0.08312388
## SRR1039509 SRS508567 SAMN02422675   trt SRR1039509  0.01853551
## SRR1039512 SRS508571 SAMN02422678 untrt SRR1039512 -0.16047843
## SRR1039513 SRS508572 SAMN02422670   trt SRR1039513 -0.26699805
## SRR1039516 SRS508575 SAMN02422682 untrt SRR1039516  0.55688461
## SRR1039517 SRS508576 SAMN02422673   trt SRR1039517  0.60106294
## SRR1039520 SRS508579 SAMN02422683 untrt SRR1039520 -0.29682660
## SRR1039521 SRS508580 SAMN02422677   trt SRR1039521 -0.36905611
```

```
# view the results, now with RUV correction applied
head(all_pairs_airway_ruv$merged[["untrt-trt"]])
```

```
##                ID  AveExpr     LogFC   LogFC_sd  edger_adj_p  deseq_adj_p
## 1 ENSG00000120129 11.38755 -2.796032 0.10419584 2.049961e-52 2.374464e-75
## 2 ENSG00000103196 11.26944 -2.498649 0.10837590 1.138046e-20 7.070362e-35
## 3 ENSG00000116584 11.02551  1.153318 0.10944798 5.594811e-19 1.343923e-30
## 4 ENSG00000211445 13.09006 -3.532402 0.09503128 1.138046e-20 1.113829e-31
## 5 ENSG00000077684 10.46767 -1.061495 0.10967681 1.238507e-12 7.017735e-35
## 6 ENSG00000139289 10.83879  1.130903 0.10933812 1.975032e-15 3.319269e-20
##     voom_adj_p edger_rank deseq_rank voom_rank rank_sum  p_intersect
## 1 2.000827e-05        1.0          1       1.0      3.0 2.000827e-05
## 2 4.018114e-04        2.5          3       4.5     10.0 4.018114e-04
## 3 2.163187e-04        4.0          5       2.0     11.0 2.163187e-04
## 4 4.660045e-04        2.5          4       8.0     14.5 4.660045e-04
## 5 4.018114e-04       10.5          2       4.5     17.0 4.018114e-04
## 6 4.018114e-04        6.0          8       4.5     18.5 4.018114e-04
##        p_union
## 1 2.374464e-75
## 2 7.070362e-35
## 3 1.343923e-30
## 4 1.113829e-31
## 5 7.017735e-35
## 6 3.319269e-20
```

# 6 DE analysis with *paired* samples

`multi_de_pairs` supports DE with paired samples. Paired samples may include, for example, the same patient observed before and after a treatment. For demonstration purposes, we assume that each untreated and treated sample is a pair.

*NB. paired* analysis with more than two groups is not currently supported. If there are more than two groups, consider testing each of the groups and their pairs seperately, or see the edgeR, limma/voom or DESeq2 vignettes for establishing a multi-variate model with blocking factors.

First we will update the summarized experiment object to include a “pairs” column and set `paired = "paired"` in `multi_de_pairs`.

```
# add "pairs" column to airway_filter summarized object
colData(airway_filter)$pairs <- as.factor(c("pair1", "pair1", "pair2", "pair2", "pair3", "pair3", "pair4", "pair4"))

# run multi_de_pairs in "paired" mode
all_pairs_airway_paired <- multi_de_pairs(summarized = airway_filter,
                                          paired = "paired",
                                          ruv_correct = TRUE)

head(all_pairs_airway_paired$merged[["untrt-trt"]])
```

```
##                ID   AveExpr     LogFC   LogFC_sd   edger_adj_p   deseq_adj_p
## 1 ENSG00000211445 13.090146 -3.591305 0.11165861 1.072632e-193 2.107187e-261
## 2 ENSG00000120129 11.387754 -2.810698 0.11100766 3.228065e-132 7.801298e-140
## 3 ENSG00000103196 11.269573 -2.492433 0.11072356 5.421641e-110 6.650710e-116
## 4 ENSG00000253368  9.790702 -1.849491 0.11339702  3.170643e-65  9.160743e-57
## 5 ENSG00000137672  9.129518 -1.807670 0.11320682  2.218815e-56  4.560821e-44
## 6 ENSG00000180914  8.691937 -1.747697 0.09135971  1.738551e-41  2.155192e-29
##     voom_adj_p edger_rank deseq_rank voom_rank rank_sum  p_intersect
## 1 1.363900e-11          1        1.0       1.0        3 1.363900e-11
## 2 1.739871e-10          2        2.0       2.0        6 1.739871e-10
## 3 4.137972e-10          3        3.0       3.0        9 4.137972e-10
## 4 1.213722e-08          4        4.0       4.0       12 1.213722e-08
## 5 2.571407e-08          5        5.0       5.0       15 2.571407e-08
## 6 7.942591e-08          6       10.5       7.5       24 7.942591e-08
##         p_union
## 1 2.107187e-261
## 2 7.801298e-140
## 3 6.650710e-116
## 4  3.170643e-65
## 5  2.218815e-56
## 6  1.738551e-41
```

The design matrix can be retrieved as follows (from e.g. the voom model fit)

```
all_pairs_airway_paired$voom$fitted[[1]]$design
```

```
##            Intercept         W_1 pair2 pair3 pair4 untrt
## SRR1039508         1 -0.25062331     0     0     0     1
## SRR1039509         1  0.24948639     0     0     0     0
## SRR1039512         1 -0.26981902     1     0     0     1
## SRR1039513         1  0.27385504     1     0     0     0
## SRR1039516         1  0.59944990     0     1     0     1
## SRR1039517         1 -0.59899109     0     1     0     0
## SRR1039520         1 -0.06879627     0     0     1     1
## SRR1039521         1  0.06543835     0     0     1     0
## attr(,"assign")
## [1] 0 1 2 2 2 3
## attr(,"contrasts")
## attr(,"contrasts")$pairs
## [1] "contr.treatment"
##
## attr(,"contrasts")$group
## [1] "contr.treatment"
```

# 7 Normalisation options

consensusDE currently implements two main normalisation approaches in `multi_de_pairs()`. These are specified with the `norm_method` parameter, where options are: `EDASeq` or `all_defaults`. As per the parameter description, when `all_defaults` is selected, this will use default normalisation methods for DE, EDASeq for QC (with control via `EDASeq_method`), and edgeR “upperquantile” for determining RUV residuals (as per RUVSeq vignette). However, when `EDASeq` is selected, this will use EDASeq normalisation and the specified `EDASeq_method` throughout, for RUV, edgeR, DESeq2 and voom/limma. Using the `EDASeq` allows for a standard normalisation approach to be used throughout, whereas `all_defaults`, allows for variation of normalisation approach to also be modelled into the final merged results table.

# 8 Plotting functions

When performing DE analysis, a series of plots (currently 10) can be generated and saved as .pdf files in a plot directory provided to `multi_de_pairs()` with the parameter: `plot_dir = "/path/to/save/pdfs/`. See `?multi_de_pairs` for description.

In addition, each of the 10 plots can be plotted individually using the `diag_plots` function. See `?diag_plots` for description, which provides wrappers for 10 different plots. Next we will plot each of these using the example data.

## 8.1 Mapped reads

Plot the number of reads that mapped to the transcriptome of each sample. The sample numbers on the x-axis correspond to the sample row number in the summarizedExperiment built, accessible using `colData(airway)`. Samples are coloured by their “group”.

```
diag_plots(se_in = airway_filter,
           name = "airway example data",
           mapped_reads = TRUE)
```

![](data:image/png;base64...)

## 8.2 Relative Log Expression

```
diag_plots(se_in = airway_filter,
           name = "airway example data",
           rle = TRUE)
```

![](data:image/png;base64...)

## 8.3 Principle Component Analysis

```
diag_plots(se_in = airway_filter,
           name = "airway example data",
           pca = TRUE)
```

![](data:image/png;base64...)

## 8.4 RUV residuals

Residuals for the RUV model can be plotted as follows:

```
diag_plots(se_in = all_pairs_airway$summarized,
           name = "airway example data",
           residuals = TRUE)
```

## 8.5 Hierarchical Clustering

```
diag_plots(se_in = airway_filter,
           name = "airway example data",
           hclust = TRUE)
```

![](data:image/png;base64...)

## 8.6 Density distribution

```
diag_plots(se_in = airway_filter,
           name = "airway example data",
           density = TRUE)
```

![](data:image/png;base64...)

## 8.7 Boxplot

```
diag_plots(se_in = airway_filter,
           name = "airway example data",
           boxplot = TRUE)
```

![](data:image/png;base64...)

## 8.8 MA plot

This will perform an MA plot given a dataset of the appropriate structure. This will plot the Log-fold change (M) versus the average expression level (A). To use independently of `multi_de_pairs()` and plot to only one comparison, constructing a list with one data.frame with the columns labelled “ID”, “AveExpr”, and “Adj\_PVal” is required. The following illustrates an example for using the merged data, which needs to be put into a list and labelled appropriately. Note that this is done automatically with `multi_de_pairs()`.

```
# 1. View all the comparisons conducted
names(all_pairs_airway$merged)
```

```
## [1] "untrt-trt"
```

```
# 2. Extract the data.frame of interest of a particular comparison
comparison <- all_pairs_airway$merged[["untrt-trt"]]
```

```
# this will not work unless in a list and will stop, producing an error. E.g.
diag_plots(merged_in = comparison,
           name = "untrt-trt",
           ma = TRUE)

# Error message:
merged_in is not a list. If you want to plot with one comparison only,
put the single dataframe into a list as follows. my_list <- list("name"=
merged_in)
```

```
# 3. Put into a new list as instructed by the error
comparison_list <- list("untrt-trt" = comparison)

# this will not work unless the appropriate columns are labelled
# "ID", "AveExpr", and "Adj_PVal"

# 4. Relabel the columns for plotting
# inspecting the column names reveals that the "Adj_PVal" column needs to be specified.
colnames(comparison_list[["untrt-trt"]])
```

```
##  [1] "ID"          "AveExpr"     "LogFC"       "LogFC_sd"    "edger_adj_p"
##  [6] "deseq_adj_p" "voom_adj_p"  "edger_rank"  "deseq_rank"  "voom_rank"
## [11] "rank_sum"    "p_intersect" "p_union"     "genename"    "symbol"
## [16] "kegg"        "coords"      "strand"      "width"
```

```
# Here, we will relabel "edger_adj_p" with "Adj_PVal" to use this p-value, using
# the "gsub" command as follows (however, we could also use one of the others or
# the p_max column)

colnames(comparison_list[["untrt-trt"]]) <- gsub("edger_adj_p", "Adj_PVal",
                                                 colnames(comparison_list[["untrt-trt"]]))

# after label
colnames(comparison_list[["untrt-trt"]])
```

```
##  [1] "ID"          "AveExpr"     "LogFC"       "LogFC_sd"    "Adj_PVal"
##  [6] "deseq_adj_p" "voom_adj_p"  "edger_rank"  "deseq_rank"  "voom_rank"
## [11] "rank_sum"    "p_intersect" "p_union"     "genename"    "symbol"
## [16] "kegg"        "coords"      "strand"      "width"
```

```
# 5. Plot MA
diag_plots(merged_in = comparison_list,
           name = "untrt-trt",
           ma = TRUE)
```

![](data:image/png;base64...)

## 8.9 Volcano

This plot a volcano plot, which compares the Log-fold change versus significance of change -log transformed score. As above and described in the MA plot section, to use independently of `multi_de_pairs()` and plot to only one comparison, constructing a list with one data.frame with the columns labelled “ID”, “AveExpr”, and “Adj\_PVal” is required.

```
diag_plots(merged_in = comparison_list,
           name = "untrt-trt",
           volcano = TRUE)
```

![](data:image/png;base64...)

## 8.10 P-value distribution

This plot the distribution of p-values for diagnostic analyses. As above and described in the MA plot section, to use independently of `multi_de_pairs()` and plot to only one comparison, constructing a list with one data.frame with the columns labelled “ID”, “AveExpr”, and “Adj\_PVal” is required.

```
diag_plots(merged_in = comparison_list,
           name = "untrt-trt",
           p_dist = TRUE)
```

![](data:image/png;base64...)

### 8.10.1 General notes about plotting

The legend and labels can be turned off using `legend = FALSE` and `label = TRUE` for `diag_plots()`. See `?diag_plots` for more details of these parameters.

# 9 Accessing additional data for each comparison

When performing DE analysis, data is stored in simple list object that can be accessed. Below are the levels of data available from the output of a DE analysis. We use the `all_pairs_airway` results from the above analysis to demonstrate how to locate these tables.

* `all_pairs_airway$merged`
  + list of the comparisons performed

In addition to the list with the combined results of DESeq2, Voom and EdgeR, the full results can be accessed for each method, as well as fit tables and the contrasts performed.

* `all_pairs_airway$deseq` (list of the DEseq2 results)
* `all_pairs_airway$voom` (list of the Voom results)
* `all_pairs_airway$edger` (list of the edgeR results)

Within each list the following data is accessible. Each object is list of all the comparisons performed.

* `all_pairs_airway$deseq$short_results`
  + Formatted results. To access the first table, for examples, use `all_pairs_airway$deseq$short_results[[1]]`
* `all_pairs_airway$deseq$full_results`
  + Full results that normally ouput by a pairwise comparison
* `all_pairs_airway$deseq$fitted`
  + Fit table to access coeffients etc.
* `all_pairs_airway$deseq$contrasts`
  + Contrasts performed

# 10 Citing results that use `consensusDE`

When using this package, please cite consensusDE as follows and all methods used in your analysis.

For consensus DE:

```
citation("consensusDE")
```

```
## To cite package 'consensusDE' in publications use:
##
##   Waardenberg A (2025). _consensusDE: RNA-seq analysis using multiple
##   algorithms_. doi:10.18129/B9.bioc.consensusDE
##   <https://doi.org/10.18129/B9.bioc.consensusDE>, R package version
##   1.28.0, <https://bioconductor.org/packages/consensusDE>.
##
## A BibTeX entry for LaTeX users is
##
##   @Manual{,
##     title = {consensusDE: RNA-seq analysis using multiple algorithms},
##     author = {Ashley J. Waardenberg},
##     year = {2025},
##     note = {R package version 1.28.0},
##     url = {https://bioconductor.org/packages/consensusDE},
##     doi = {10.18129/B9.bioc.consensusDE},
##   }
```

* When using RUVseq (also check package reference suggestions)
  + D. Risso, J. Ngai, T. P. Speed and S. Dudoit (2014). Normalization of RNA-seq data using factor analysis of control genes or samples Nature Biotechnology, 32(9), 896-902
* When using DESeq2 (also check package reference suggestions)
  + Love, M.I., Huber, W., Anders, S. Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2 Genome Biology 15(12):550 (2014)
* When using edgeR (also check package reference suggestions)
  + Robinson MD, McCarthy DJ and Smyth GK (2010). edgeR: a Bioconductor package for differential expression analysis of digital gene expression data. Bioinformatics 26, 139-140
  + McCarthy DJ, Chen Y and Smyth GK (2012). Differential expression analysis of multifactor RNA-Seq experiments with respect to biological variation. Nucleic Acids Research 40, 4288-4297
* When using limma/voom (also check package reference suggestions)
  + Ritchie, M.E., Phipson, B., Wu, D., Hu, Y., Law, C.W., Shi, W., and Smyth, G.K. (2015). limma powers differential expression analyses for RNA-sequencing and microarray studies. Nucleic Acids Research 43(7), e47.