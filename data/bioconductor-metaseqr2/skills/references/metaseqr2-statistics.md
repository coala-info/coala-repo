# Usage of the metaseqR2 package

Panagiotis Moulos

#### 30 October 2025

# 1 RNA-Seq data analysis using mulitple statistical algorithms with metaseqR2

During the past years, a lot of packages have been developed for the analysis of
RNA-Seq data, introducing several approaches. Many of them live in Bioconductor.
Furthermore, different statistical approaches and heuristics are used in a
continuous effort to improve overall accuracy. Such approaches include packages
using the negative binomial distribution to model the null hypotheses (*DESeq*,
*DESeq2*, *edgeR*, *NBPSeq*, “ABSSeq”), packages using Bayesian statistics
(*baySeq*, *EBSeq*) or more hybrid solutions (*NOISeq*, *voom*). In addition,
packages specialized to RNA-Seq data normalization have also been developed
(*EDASeq*, *RUVSeq*). The first version of the *metaseqR* package (pronounced
meta-seek-er) provided an interface to several algorithms for normalization and
statistical analysis and at the same time provided PANDORA, a novel p-value
combination method. PANDORA successfully combines several statistical algorithms
by weighting their outcomes according to their performance with realistically
simulated data sets generated from real data. Using simulated as well as real
data, it was shown that PANDORA improves the overall detection of differentially
expressed genes by reducing false hits while maintaining true positives. To our
knowledge, PANDORA remains the only fully functional method proposing this
combinatorial approach for the analysis of RNA-Seq data.

metaseqR2, is the continuation of
[metaseqR](https://pubmed.ncbi.nlm.nih.gov/25452340/). While it has been
(at times) heavily refactored, it still offers the same functionalities with as
much backwards compatibility as possible. Like metaseqR, metaseqR2, incoporates
several algorithms for normalization and statistical analysis. In particular, we
extended the offered algorithms with *DESeq2*, *ABSSeq* and *DSS*. metaseqR2,
like metaseqR also builds a full report with several interactive and
non-interactive diagnostic plots so that the users can easily explore the
results and have whatever they need for this part of their research in one
place. The report has been modernized and remains one of its strongest points as
it provides an automatically generated summary, based on the pipeline inputs and
the results, which can be used directly as a draft in methods paragraph in
scientific publications. It also provides a lot of diagnostic figures and each
figure is accompanied by a small explanatory text, and a list of references
according to the algorithms used in the pipeline. metaseqR2 continues to provide
an interface for RNA-Seq data meta-analysis by providing the ability to use
different algorithms for the statistical testing part and combining the p-values
using popular published methods (e.g. Fisher’s method, Whitlock’s method),
two package-specific methods (intersection, union of statistically significant
results) and of course PANDORA.

Another major difference as compared to the older metaseqR package is the
annotation system that is adopted by metaseqR2. More specifically, metaseqR2
introduces the `buildAnnotationDatabase` function which builds a local SQLite
database with the supported by metaseqR annotations as well as additional
versions added in the current package. This function, given a short and
comprehensive number of arguments, automatically downloads, processes and
imports to a portable database, all annotation types required by the
main analysis pipeline. Therefore, the user neither has to embed nor download
the required annotation each time. But most importantly, with the current
package, the user is able also to provide an own GTF file with custom annotation
elements that are the imported to the metaseqR2 database and annotation system
and can be used for the respective analyses.

Apart from local database building, there also other major additions (such) as
improved analysis for 3’UTR mRNA sequencing (Lexogen Quant-Seq protocol) which
can be found towards the end of this page.

Throughout the rest of this document, `metaseqr2` refers to the name of the
analysis pipeline while *metaseqR2* refers to the name of the package.

# 2 Getting started

## 2.1 Installation

To install the metaseqR2 package, start R and enter:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("metaseqR2")
```

## 2.2 Introduction

```
library(metaseqR2)
```

Detailed instructions on how to run the metaseqr2 pipeline can be found under
the main documentation of the metaseqR2 package.

Briefly, to run metaseqr2 you need:

1. Input RNA-Seq data. These can come in three forms:

* A text tab delimited file in a spreadsheet-like format containing at least
  unique gene identifiers (corresponding to one of metaseqR2 supported
  annotation sources, that is Ensembl, UCSC, RefSeq) *or* if you are using
  a custom annotation (with a GTF file), unique gene identifiers corresponding
  to this GTF file. This case is applicable in case of receiving a ready-made
  counts table from an external source, such as a sequencing facility or a
  public dataset.
* A text tab delimited file in a spreadsheet-like format containing all the
  required annotation elements and additional columns with read counts. This
  solution is applicable only for gene analysis (`transLevel = "gene"` and
  `countType = "gene"`). Generally, it is not recommended to embed the
  annotation and this case is supported only for backwards compatibility.
* A set of BAM files, aligned according to the mRNA sequencing protocol,
  usually a spliced aligner like HiSat or STAR. This is the recommended
  analysis procedure and the BAM files are declared in a targets text file.

2. A local annotation database. This is not required as all required annotation
   can be downloaded on the fly, but it is recommended for speed, if you have a
   lot of analyses to perform.
3. A list of statistical contrasts for which you wish to check differential
   expression
4. An internet connection so that the interactive report can be properly
   rendered, as the required JavaScript libraries are not embedded to the
   package. This is required only once as the report is then self-contained.

For demonstration purposes, a very small dataset (with embedded annotation) is
included with the package.

## 2.3 Types of analyses performed with metaseqR2

Several types of differential analysis of gene expression can be performed and
reported with metaseqR2 depending on the biological question asked and the type
of data generated. For example, an investigator may be interested in gene- or
transcript-level differential expression analysis when a 3’UTR sequencing kit
has been used or interested for differential exon usage when a classical
polyA RNA-Seq protocol has been applied.

These analysis types are being defined essentially by two arguments:
\* `countType` which can be `gene`, `exon`, `utr` corresponding to total RNA
sequencing, polyA RNA sequencing or 3’ UTR sequencing respectively.
\* `transLevel` which can be `gene`, `transcript`, `exon` corresponding to
differetial expression analysis using gene models (or essentially the dominant
transcripts), individual transcripts or exons respectively.

Therefore, the selection of `countType="exon"` and `transLevel="gene"` assumes
that we have a dataset where polyA RNA sequencing has been applied followed by
splicing-aware alignment while `countType="utr"` and `transLevel="transcript"`
assumes that we have a dataset where 3’UTR sequencing (e.g. Lexogen Quant-Seq)
has been applied to look for differential expression based on read occupancy on
the 3’ UTR regions.

The following combinations are available:
\* `countType="gene"`, `transLevel="gene"` for differential expression analysis
using a pre-calculated counts table or BAM files from total RNA sequencing.
\* `countType="gene"`, `transLevel="transcript"` for differential expression
analysis using a pre-calculated counts table or BAM files from total RNA
sequencing and for each transcript.
\* `countType="gene"`, `transLevel="exon"` for differential expression analysis
of exons using BAM files from polyA RNA sequencing.
\* `countType="exon"`, `transLevel="gene"` for differential expression analysis
using BAM files from polyA RNA sequencing.
\* `countType="exon"`, `transLevel="transcript"` for differential expression
analysis of transcripts using BAM files from total RNA sequencing.
\* `countType="utr"`, `transLevel="gene"` for differential expression analysis
of genes using BAM files from 3’ UTR RNA sequencing.
\* `countType="utr"`, `transLevel="transcript"` for differential expression
analysis of transcripts using BAM files from 3’ UTR RNA sequencing.

## 2.4 Data filtering

The metaseqR2 pipeline has several options for gene filtering at the gene and
exon levels. These filters span various areas including:
\* The presence of a minimum number of reads in a fraction of the samples per
condition or experiment-wise.
\* The exclusion of specific biotypes (e.g. exluding pseudogenes)
\* The filtering based on several expression attributes such as average read
presence over *n* kbs or the exclusion of genes whose expression is below the
expression of a set of genes known *not* to be expressed in the biological
mechanism under investigation
\* Filters based on exon expression such as the minimum fraction of exons that
should contain reads over a gene.

In addition, the metaseqR2 pipeline offers several analysis “presets” with
respect to the filtering layers applied, the statistical analysis stringency and
the amount of data exported.

All the aforementioned parameters are well-documented in the main manual of the
package and the respective man pages.

# 3 Running the `metaseqr2` pipeline

**Note**: When conducting an analysis with metaseqR2, it is advised that you
set a seed for random number generation using `set.seed()`. This should be set
because some quality control charts in the metaseqR2 report are created by
downsampling the initial dataset analyzed. Therefore, to guarantee the
reproducibility of these plots, a seed must be provided.

```
set.seed(42)
```

Running a metaseqr2 pipeline instance is quite straightforward. Again, see the
examples in the main help page. Below, an example and the command window output
follow:

```
data("mm9GeneData",package="metaseqR2")
```

```
head(mm9GeneCounts)
```

```
##                    chromosome   start     end            gene_id gc_content
## ENSMUSG00000090699      chr12 3023883 3025753 ENSMUSG00000090699     0.4441
## ENSMUSG00000092168      chr12 3082667 3087041 ENSMUSG00000092168     0.4649
## ENSMUSG00000079179      chr12 3236611 3249999 ENSMUSG00000079179     0.4178
## ENSMUSG00000020671      chr12 3247430 3309969 ENSMUSG00000020671     0.4023
## ENSMUSG00000069181      chr12 3343816 3357153 ENSMUSG00000069181     0.4508
## ENSMUSG00000020668      chr12 3365132 3406494 ENSMUSG00000020668     0.4756
##                    strand        biotype     gene_name e14.5_1 e14.5_2 a8w_1
## ENSMUSG00000090699      +     pseudogene        Gm9071       2       5    11
## ENSMUSG00000092168      +     pseudogene        Gm9075       0       0     1
## ENSMUSG00000079179      + protein_coding 1700012B15Rik     838     718   366
## ENSMUSG00000020671      - protein_coding         Rab10    1868    2004   977
## ENSMUSG00000069181      -        lincRNA       Gm17681      15      18    14
## ENSMUSG00000020668      + protein_coding         Kif3c     162     155   126
##                    a8w_2
## ENSMUSG00000090699    25
## ENSMUSG00000092168     0
## ENSMUSG00000079179   261
## ENSMUSG00000020671   807
## ENSMUSG00000069181    28
## ENSMUSG00000020668   122
```

```
sampleListMm9
```

```
## $e14.5
## [1] "e14.5_1" "e14.5_2"
##
## $adult_8_weeks
## [1] "a8w_1" "a8w_2"
```

```
libsizeListMm9
```

```
## $e14.5_1
## [1] 3102907
##
## $e14.5_2
## [1] 2067905
##
## $a8w_1
## [1] 3742059
##
## $a8w_2
## [1] 4403954
```

## 3.1 Analysis at the gene level with gene counts

Following, a full example with the informative messages that are printed in the
command window:

```
library(metaseqR2)

data("mm9GeneData",package="metaseqR2")

# You can explore the results in the session's temporary directory
print(tempdir())
```

```
## [1] "/tmp/RtmpiHhLZD"
```

```
result <- metaseqr2(
    counts=mm9GeneCounts,
    sampleList=sampleListMm9,
    contrast=c("adult_8_weeks_vs_e14.5"),
    libsizeList=libsizeListMm9,
    annotation="embedded",
    embedCols=list(
        idCol=4,
        gcCol=5,
        nameCol=8,
        btCol=7
    ),
    org="mm9",
    countType="gene",
    normalization="edger",
    statistics="edger",
    pcut=0.05,
    qcPlots=c(
        "mds","filtered","correl","pairwise","boxplot","gcbias",
        "lengthbias","meandiff","meanvar","deheatmap","volcano",
        "mastat"
    ),
    figFormat=c("png","pdf"),
    exportWhat=c("annotation","p_value","adj_p_value","fold_change"),
    exportScale=c("natural","log2"),
    exportValues="normalized",
    exportStats=c("mean","sd","cv"),
    exportWhere=file.path(tempdir(),"test1"),
    restrictCores=0.01,
    geneFilters=list(
         length=list(
                length=500
         ),
         avgReads=list(
                averagePerBp=100,
                quantile=0.25
         ),
         expression=list(
                median=TRUE,
                mean=FALSE,
                quantile=NA,
                known=NA,
                custom=NA
         ),
         biotype=getDefaults("biotypeFilter","mm9")
    ),
    outList=TRUE
)
```

```
##
## 2025-10-30 00:59:23: Data processing started...
```

```
##
## Read counts file: imported custom data frame
## Conditions: e14.5, adult_8_weeks
## Samples to include: e14.5_1, e14.5_2, a8w_1, a8w_2
## Samples to exclude: none
## Requested contrasts: adult_8_weeks_vs_e14.5
## Library sizes:
##   e14.5_1: 3102907
##   e14.5_2: 2067905
##   a8w_1: 3742059
##   a8w_2: 4403954
## Annotation: embedded
## Organism: mm9
## Reference source: ensembl
## Count type: gene
## Transcriptional level: gene
## Exon filters: minActiveExons
##   minActiveExons:
##     exonsPerGene: 5
##     minExons: 2
##     frac: 0.2
## Gene filters: length, avgReads, expression, biotype
##   length:
##     length: 500
##   avgReads:
##     averagePerBp: 100
##     quantile: 0.25
##   expression:
##     median: TRUE
##     mean: FALSE
##     quantile: NA
##     known: NA
##     custom: NA
##   biotype:
##     pseudogene: FALSE
##     snRNA: FALSE
##     protein_coding: FALSE
##     antisense: FALSE
##     miRNA: FALSE
##     lincRNA: FALSE
##     snoRNA: FALSE
##     processed_transcript: FALSE
##     misc_RNA: FALSE
##     rRNA: TRUE
##     sense_overlapping: FALSE
##     sense_intronic: FALSE
##     polymorphic_pseudogene: FALSE
##     non_coding: FALSE
##     three_prime_overlapping_ncrna: FALSE
##     IG_C_gene: FALSE
##     IG_J_gene: FALSE
##     IG_D_gene: FALSE
##     IG_V_gene: FALSE
##     ncrna_host: FALSE
## Filter application: postnorm
## Normalization algorithm: edger
## Normalization arguments:
##   method: TMM
##   logratioTrim: 0.3
##   sumTrim: 0.05
##   doWeighting: TRUE
##   Acutoff: -1e+10
##   p: 0.75
## Statistical algorithm(s): edger
## Statistical arguments:
##   edger: classic, 5, 10, movingave, NULL, grid, 11, c(-6, 6), NULL, CoxReid, 10000, NULL, auto, NULL, NULL, NULL, NULL, 0.125, NULL, auto, chisq, TRUE, FALSE, c(0.05, 0.1)
## Meta-analysis method: none
## Multiple testing correction: BH
## p-value threshold: 0.05
## Logarithmic transformation offset: 1
## Quality control plots: mds, filtered, correl, pairwise, boxplot, gcbias, lengthbias, meandiff, meanvar, deheatmap, volcano, mastat
## Figure format: png, pdf
## Output directory: /tmp/RtmpiHhLZD/test1
## Output data: annotation, p_value, adj_p_value, fold_change
## Output scale(s): natural, log2
## Output values: normalized
## Loading gene annotation...
## Saving gene model to /tmp/RtmpiHhLZD/test1/data/gene_model.RData
## Removing genes with zero counts in all samples...
## Normalizing with: edger
## Applying gene filter length...
##   Threshold below which ignored: 500
## Applying gene filter avgReads...
##   Threshold below which ignored: 0.0659629215631332
## Applying gene filter expression...
##   Threshold below which ignored: 68
## Applying gene filter biotype...
##   Biotypes ignored: rRNA
## 2106 genes filtered out
## 1681 genes remain after filtering
## Running statistical tests with: edger
##   Contrast: adult_8_weeks_vs_e14.5
##   Contrast adult_8_weeks_vs_e14.5: found 906 genes
## Building output files...
##   Contrast: adult_8_weeks_vs_e14.5
##     Adding non-filtered data...
##       binding annotation...
##       binding p-values...
##       binding FDRs...
##       binding natural normalized fold changes...
##       binding log2 normalized fold changes...
##     Writing output...
##     Adding filtered data...
##       binding annotation...
##       binding p-values...
##       binding FDRs...
##       binding natural normalized fold changes...
##       binding log2 normalized fold changes...
##     Writing output...
##     Adding report data...
##       binding annotation...
##       binding p-values...
##       binding FDRs...
##       binding log2 normalized fold changes...
##       binding normalized mean counts...
##       binding normalized mean counts...
## Creating quality control graphs...
## Plotting in png format...
##   Plotting mds...
##   Plotting correl...
##   Plotting pairwise...
##   Plotting boxplot...
##   Plotting gcbias...
##   Plotting lengthbias...
##   Plotting meandiff...
##   Plotting meanvar...
##   Plotting boxplot...
##   Plotting gcbias...
##   Plotting lengthbias...
##   Plotting meandiff...
##   Plotting meanvar...
##   Plotting deheatmap...
##   Contrast: adult_8_weeks_vs_e14.5
##   Plotting volcano...
##   Contrast: adult_8_weeks_vs_e14.5
##   Plotting mastat...
##   Contrast: adult_8_weeks_vs_e14.5
##   Plotting filtered...
## Plotting in pdf format...
##   Plotting mds...
##   Plotting correl...
##   Plotting pairwise...
##   Plotting boxplot...
##   Plotting gcbias...
##   Plotting lengthbias...
##   Plotting meandiff...
##   Plotting meanvar...
##   Plotting boxplot...
##   Plotting gcbias...
##   Plotting lengthbias...
##   Plotting meandiff...
##   Plotting meanvar...
##   Plotting deheatmap...
##   Contrast: adult_8_weeks_vs_e14.5
##   Plotting volcano...
##   Contrast: adult_8_weeks_vs_e14.5
##   Plotting mastat...
##   Contrast: adult_8_weeks_vs_e14.5
##   Plotting filtered...
##   Importing mds...
##   Importing pairwise...
##   Importing filtered...
##   Importing boxplot...
##   Importing gcbias...
##   Importing lengthbias...
##   Importing meandif...
##   Importing meanvar...
##   Importing volcano
##     adult_8_weeks_vs_e14.5 adult_8_weeks_vs_e14.5
##   Importing mastat
##     adult_8_weeks_vs_e14.5 adult_8_weeks_vs_e14.5
## Writing plot database in /tmp/RtmpiHhLZD/test1/data/reportdb.js
## Creating HTML report...
## Compressing figures...
## Downloading required JavaScript libraries...processing file: metaseqr2_report.Rmd
## output file: metaseqr2_report.knit.md
```

```
## /usr/bin/pandoc +RTS -K512m -RTS metaseqr2_report.knit.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output /tmp/RtmpiHhLZD/test1/index.html --lua-filter /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmarkdown/lua/pagebreak.lua --lua-filter /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmarkdown/lua/latex-div.lua +RTS -K2048m -RTS --variable 'material:true' --variable 'lightbox:true' --variable 'thumbnails:true' --variable 'gallery:true' --variable 'cards:true' --variable bs3=TRUE --standalone --section-divs --table-of-contents --toc-depth 1 --template /home/biocbuild/bbs-3.22-bioc/R/site-library/rmdformats/templates/material/material.html --highlight-style kate --variable theme=bootstrap --include-in-header /tmp/RtmpiHhLZD/rmarkdown-str16f06167a4bb57.html
```

```
##
## Output created: /tmp/RtmpiHhLZD/test1/index.html
##
##
## 2025-10-30 01:00:07: Data processing finished!
##
##
## Total processing time: 44 seconds
```

To get a glimpse on the results, run:

```
head(result[["data"]][["adult_8_weeks_vs_e14.5"]])
```

```
##                    chromosome     start       end            gene_id gc_content
## ENSMUSG00000000001       chr3 107910198 107949064 ENSMUSG00000000001      41.65
## ENSMUSG00000000339       chr3 116191881 116211126 ENSMUSG00000000339      43.09
## ENSMUSG00000000340       chr3 116215988 116252894 ENSMUSG00000000340      44.05
## ENSMUSG00000000420      chr18  24363845  24445319 ENSMUSG00000000420      40.82
## ENSMUSG00000000561       chr3 105762287 105787518 ENSMUSG00000000561      44.40
## ENSMUSG00000000562       chr3 105673776 105711846 ENSMUSG00000000562      45.35
##                    strand gene_name        biotype p-value_edger  FDR_edger
## ENSMUSG00000000001      -     Gnai3 protein_coding    0.09854676 0.16005517
## ENSMUSG00000000339      -     Rtcd1 protein_coding    0.20006583 0.28670985
## ENSMUSG00000000340      +       Dbt protein_coding    0.84076060 0.88674525
## ENSMUSG00000000420      +    Galnt1 protein_coding    0.01060295 0.02434911
## ENSMUSG00000000561      +     Wdr77 protein_coding    0.07624657 0.13145690
## ENSMUSG00000000562      +    Adora3 protein_coding    0.31863741 0.41944361
##                    natural_normalized_fold_change_adult_8_weeks_vs_e14.5
## ENSMUSG00000000001                                             0.5882636
## ENSMUSG00000000339                                             0.6194690
## ENSMUSG00000000340                                             1.0623330
## ENSMUSG00000000420                                             0.4348900
## ENSMUSG00000000561                                             0.5509965
## ENSMUSG00000000562                                             1.7258065
##                    log2_normalized_fold_change_adult_8_weeks_vs_e14.5
## ENSMUSG00000000001                                        -0.76546535
## ENSMUSG00000000339                                        -0.69089595
## ENSMUSG00000000340                                         0.08723612
## ENSMUSG00000000420                                        -1.20127760
## ENSMUSG00000000561                                        -0.85988498
## ENSMUSG00000000562                                         0.78727068
```

You may also want to check the interactive HTML report generated in the output
directory defined by the `exportWhere` argument above.

Now, the same example but with more than one statistical selection algorithms, a
different normalization, an analysis preset and filtering applied prior to
normalization:

```
library(metaseqR2)

data("mm9GeneData",package="metaseqR2")

result <- metaseqr2(
    counts=mm9GeneCounts,
    sampleList=sampleListMm9,
    contrast=c("adult_8_weeks_vs_e14.5"),
    libsizeList=libsizeListMm9,
    annotation="embedded",
    embedCols=list(
        idCol=4,
        gcCol=5,
        nameCol=8,
        btCol=7
    ),
    org="mm9",
    countType="gene",
    whenApplyFilter="prenorm",
    normalization="edaseq",
    statistics=c("deseq","edger"),
    metaP="fisher",
    #qcPlots=c(
    #    "mds","biodetection","countsbio","saturation","readnoise","filtered",
    #    "correl","pairwise","boxplot","gcbias","lengthbias","meandiff",
    #    "meanvar","rnacomp","deheatmap","volcano","mastat","biodist","statvenn"
    #),
    qcPlots=c(
        "mds","filtered","correl","pairwise","boxplot","gcbias",
        "lengthbias","meandiff","meanvar","deheatmap","volcano",
        "mastat"
    ),
    restrictCores=0.01,
    figFormat=c("png","pdf"),
    preset="medium_normal",
    exportWhere=file.path(tempdir(),"test2"),
    outList=TRUE
)
```

```
## /usr/bin/pandoc +RTS -K512m -RTS metaseqr2_report.knit.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output /tmp/RtmpiHhLZD/test2/index.html --lua-filter /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmarkdown/lua/pagebreak.lua --lua-filter /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmarkdown/lua/latex-div.lua +RTS -K2048m -RTS --variable 'material:true' --variable 'lightbox:true' --variable 'thumbnails:true' --variable 'gallery:true' --variable 'cards:true' --variable bs3=TRUE --standalone --section-divs --table-of-contents --toc-depth 1 --template /home/biocbuild/bbs-3.22-bioc/R/site-library/rmdformats/templates/material/material.html --highlight-style kate --variable theme=bootstrap --include-in-header /tmp/RtmpiHhLZD/rmarkdown-str16f06174f3556e.html
```

A similar example with no filtering applied and no Venn diagram generation:

```
library(metaseqR2)

data("mm9GeneData",package="metaseqR2")

result <- metaseqr2(
    counts=mm9GeneCounts,
    sampleList=sampleListMm9,
    contrast=c("adult_8_weeks_vs_e14.5"),
    libsizeList=libsizeListMm9,
    annotation="embedded",
    embedCols=list(
        idCol=4,
        gcCol=5,
        nameCol=8,
        btCol=7
    ),
    org="mm9",
    countType="gene",
    normalization="edaseq",
    statistics=c("deseq","edger"),
    metaP="fisher",
    qcPlots=c(
        "mds","filtered","correl","pairwise","boxplot","gcbias",
        "lengthbias","meandiff","meanvar","deheatmap","volcano",
        "mastat"
    ),
    restrictCores=0.01,
    figFormat=c("png","pdf"),
    preset="medium_normal",
    outList=TRUE,
    exportWhere=file.path(tempdir(),"test3")
)
```

```
## /usr/bin/pandoc +RTS -K512m -RTS metaseqr2_report.knit.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output /tmp/RtmpiHhLZD/test3/index.html --lua-filter /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmarkdown/lua/pagebreak.lua --lua-filter /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmarkdown/lua/latex-div.lua +RTS -K2048m -RTS --variable 'material:true' --variable 'lightbox:true' --variable 'thumbnails:true' --variable 'gallery:true' --variable 'cards:true' --variable bs3=TRUE --standalone --section-divs --table-of-contents --toc-depth 1 --template /home/biocbuild/bbs-3.22-bioc/R/site-library/rmdformats/templates/material/material.html --highlight-style kate --variable theme=bootstrap --include-in-header /tmp/RtmpiHhLZD/rmarkdown-str16f061386e6421.html
```

Another example with the full PANDORA algorithm (not evaluated here):

```
library(metaseqR2)

data("mm9GeneData",package="metaseqR2")

result <- metaseqr2(
    counts=mm9GeneCounts,
    sampleList=sampleListMm9,
    contrast=c("adult_8_weeks_vs_e14.5"),
    libsizeList=libsizeListMm9,
    annotation="embedded",
    embedCols=list(
        idCol=4,
        gcCol=5,
        nameCol=8,
        btCol=7
    ),
    org="mm9",
    countType="gene",
    normalization="edaseq",
    statistics=c("edger","limma"),
    metaP="fisher",
    figFormat="png",
    preset="medium_basic",
    qcPlots=c(
        "mds","filtered","correl","pairwise","boxplot","gcbias",
        "lengthbias","meandiff","meanvar","deheatmap","volcano",
        "mastat"
    ),
    restrictCores=0.01,
    outList=TRUE,
    exportWhere=file.path(tempdir(),"test4")
)
```

## 3.2 Analysis at the gene level with exon counts

**Note**: Be sure to have constructed a metaseqR2 annotation database prior to
continuing with the following examples!

As example BAM files from a realistic dataset that can demonstrate the full
availabilities of metaseqR2 do not fit within the Bioconductor package, you can
find additional examples in our GitHub
[page](https://github.com/pmoulos/metaseqR2) where issues can be reported too.

## 3.3 Estimating p-value weights

In metaseqR2, the PANDORA algorithm is expaned with additional 3 algorithms.
Briefly, PANDORA use of the area under False Discovery Curves to assess the
performance of each statistical test with simulated datasets created from true
datasets (e.g. your own dataset, as long as it has a sufficient number of
replicates). Then, the performance assessment can be used to construct p-value
weights for each test and use these weights to supply the p-value weights
parameter of metaseqr2 when `metaP` is `"weight"`, `"pandora"` or `"whitlock"`
(see the next sections for p-value combination methods). The following example
shows how to create such weights (depending on the size of the dataset, it might
take some time to run):

```
data("mm9GeneData",package="metaseqR2")
weights <- estimateAufcWeights(
    counts=as.matrix(mm9GeneCounts[,9:12]),
    normalization="edaseq",
    statistics=c("edger","limma"),
    nsim=1,N=10,ndeg=c(2,2),top=4,modelOrg="mm10",
    rc=0.01,libsizeGt=1e+5
)
```

…and the weights…

```
weights
```

```
##     edger     limma
## 0.5263158 0.4736842
```

## 3.4 Combining p-values from multiple tests

Although the main `metaseqr2` function takes care of p-value combination,
sometimes there is the need of simply importing externally calculated p-values
and using the respective metaseqR2 functions to produce combined p-values. We
demonstrate this capability using p-values from all metaseqR2 supported
algorithms, applied to data from
[Giakountis et al., 2016](https://doi.org/10.1016/j.celrep.2016.05.038).

```
data("hg19pvalues",package="metaseqR2")

# Examine the data
head(hg19pvalues)
```

```
##                     deseq      deseq2       edger     noiseq    bayseq
## ENSG00000004139 0.9376229 0.707127451 0.655534521 0.66858917 1.0000000
## ENSG00000004660 0.3059280 0.000032200 0.000020200 0.01750464 1.0000000
## ENSG00000004948 0.8752557 0.766905137 0.829416355 0.53040389 1.0000000
## ENSG00000007312 0.0277213 0.000384155 0.000000209 0.01558416 0.2147213
## ENSG00000007944 0.8995102 0.749182654 0.753981205 0.74932097 1.0000000
## ENSG00000008710 0.5847093 0.046782500 0.064277452 0.05570155 1.0000000
##                       limma       nbpseq      absseq          dss
## ENSG00000004139 0.634320805 0.7547977540 1.000000000 7.514558e-01
## ENSG00000004660 0.000727350 0.0011373140 0.221430162 1.747937e-03
## ENSG00000004948 0.736621379 0.7162818590 0.998049792 5.767438e-01
## ENSG00000007312 0.000219521 0.0000000487 0.000954742 1.570000e-09
## ENSG00000007944 0.784978571 0.7709520610 1.000000000 7.789785e-01
## ENSG00000008710 0.088718133 0.0644784670 0.989265394 1.191493e-01
```

```
# Now combine the p-values using the Simes method
pSimes <- apply(hg19pvalues,1,combineSimes)

# The harmonic mean method with PANDORA weights
w <- getWeights("human")
pHarm <- apply(hg19pvalues,1,combineHarmonic,w)

# The PANDORA method
pPandora <- apply(hg19pvalues,1,combineWeight,w)
```

# 4 metaseqR2 components

## 4.1 Brief description

The metaseqR2 package includes several functions which are responsible for
running each part of the pipeline (data reading and summarization, filtering,
normalization, statistical analysis and meta-analysis and reporting). Although
metaseqR2 is designed to run as a pipeline, where all the parameters for each
individual part can be passed in the main function, several of the individual
functions can be run separately so that the more experienced user can build
custom pipelines. All the HTML help pages contain analytical documentation on
how to run these functions, their inputs and outputs and contain basic examples.
For example, runnning

```
help(statEdger)
```

will open the help page of the wrapper function over the edgeR statistical
testing algorithm which contains an example of data generation, processing, up
to statistical selection.

Most of the diagnostic plots, work with simple matrices as inputs, so they can
be easily used outside the main pipeline, as long as all the necessary arguments
are given. In metaseqR2, most of the individual diagnostic plot creation
functions are not exported, mostly for documentation simplicity and avoidance of
confusion for non-experts. They can still be used by calling them as
non-exported objects (e.g. `metaseqR2:::diagplotMds`). Finally, it should be
noted that a report can be generated only when running the whole metaseqr2
pipeline and in the current version there is no support for generating custom
reports. The final reports contains full interactive graphs and the required
JavaScript libraries to generate them are automatically downloaded.

## 4.2 Backwards compatibility

If you have older pipelines based on metaseqR and the `metaseqr` function where
the argument coding style is different (e.g. `sample.list` instead of
`sampleList`) then `metaseqr2` will do its best to convert old arguments to new
arguments so that old commands do not break and the only that should be changed
is `metaseqr` to `metaseqr2`. Note however that you *should not* mix old and new
arguments. In this case, the new pipeline will fail.

# 5 The report

In the end of each metaseqr2 pipeline run, a detailed HTML report of the
procedure and the findings is produced. Apart from description of the process,
all the input parameters and other data related to the differential expression
analysis, the report contains a lot of interactive graphs. Specifically, all the
quality control and result inspection plots are interactive. This is achieved
by making extensive use of the JavaScript libraries
[Highcharts](https://www.highcharts.com/), [Plotly](https://plot.ly/) and
[jvenn](http://jvenn.toulouse.inra.fr/app/index.html) to create more
user-friendly and directly explorable plots. By default metaseqr2 produces all
available diagnostic plots, according always to input. For example, if the
*biotype* feature is not available in a case where `annotation="embedded"`,
plots like `biodetection` and `countsbio` will not be available. If not all
diagnostic plots are not required, a selection can be made with the `qcPlots`
argument, possibly making the report “lighter” and less browser-demanding.

The HTML report creation mechanism is through the packages rmarkdown and knitr.
This means that the [Pandoc](https://pandoc.org/) libraries must be installed.
A lot of details on this can be found in Pandoc’s website as well as knitr and
rmarkdown websites and guides. Although the generic mechanism is more
computationally demanding than standard HTML (e.g. using *brew* as in the
previous metaseqR), the results are more standardized, cross-platform and fully
reproducible.

During development, we found out that knitr faces certain difficulties in our
settings, that is embedding a lot of predefined graphs in JSON format and all
required libraries and data in a single HTML page. This situation led to crashes
because of memory usage and of course, very large HTML files. We resolved this
by using (according to usage scenario and where the report is intended to be
seen):

1. A flavor of [IndexedDB](https://javascript.info/indexeddb) called
   [Dexie](https://dexie.org/)
2. A JavaScript port of SQLite called
   [sql.js](https://github.com/kripken/sql.js/)

Regarding case (1), IndexedDB is a modern technology to create simple,
in-browser object databases which has several usages, but mostly to avoid the
burden of synchronously loading big-sized objects at the same time of simple
HTML rendering. IndexedDB is supported by all modern browser and is essentially
a replacement for `localStorage` which had space limitations. Dexie is a simple
interface to IndexedDB. Thus, all the plot data are created and stored in Dexie
for rendering when needed. This rendering method can be used both when the
report is seen as a stand-alone document, locally, without the presence of a web
server or internet connection, and is the default method.

Regarding case (2), all the predefined plot data are stored in a report-specific
SQLite database which is then queried using sql.js. This way can be chosen
when it is known that the report will be presented through a web server (e.g.
Apache) as in any other case, modern web browser (except MS Edge) do not allow
by default opening local files from an HTML page for security reasons. Also,
sql.js is quite large as a library (altough downloaded once for recurring
reports). This method produces slightly smaller files but is slightly slower.
Using Dexie is the preferred and safest method for both scenarios.

In both cases, the serialized JSON used for Highcharts and jvenn plots is placed
in `data/reportdb.js` when using Dexie or `data/reportdb.sqlite` when using
sql.js. Experienced users can then open these files and tweak the plots as
desired. The above paths are relative to the report’s location `exportWhere`
arguments.

metaseqR2 report has the following sections, depending also on which diagnostic
and exploration plots have been asked from the run command. As plots are
categorized, if no plot from a specific category is asked, then this category
will not appear. Below, the categories:

## 5.1 Summary

The Summary section is further categorized in several subsections. Specifically:

* Analysis summary: This section contains an auto-generated text that
  analytically describes the computational process followed and summarized the
  results of each step. This text can be used as is or with slight modifications
  in a *Methods* section of an article.
* Input options: This section provides a list of the input arguments to the
  pipeline in a more human-readable format.
* Filtering: This section reports in detail the number of filtered genes
  decomposed according to the number of genes removed by each applied filter.
* Differential expression: This section reports in detail the number of
  differentially expressed genes for each contrast, both when using only a p-value
  cutoff as well as an FDR cutoff (numbers in parentheses), that is, genes passing
  the multiple testing correction procedure selected. These numbers also are
  calculated based on a simple fold change cutoff in log2 scale.
  Finally, when multiple algorithms are used with p-value combination, this
  section reports all the findings analytically per algorithm.
* Command: This section contains the command used to run the metaseqr2 pipeline
  for users that want to experiment.
* Run log: This section contains critical messages displayed within the R
  session running `metaseqr2` displayed as a log.

## 5.2 Quality control

The Quality control section contains several interactive plots concerning the
overall quality control of each sample provided as well as overall assessments.
The quality control plots are the Multidimensional Scaling (MDS) plot, the
Biotypes detection (Biodetection) plot, the Biotype abundance (Countsbio) plot,
the Read saturation (Saturation) plot, the Read noise (ReadNoise) plot, the
Correlation heatmap (Correlation), the Pairwise sample scatterplots (Pairwise)
and the Filtered entities (Filtered) plot. Each plot is accompanied by a
detailed description of what it depicts. Where multiple plot are available (e.g.
one for each sample), a selection list on the top of the respective section
allows the selection of the sample to be displayed.

## 5.3 Normalization

The Normalization section contains several interactive plots that can be used to
inspect and assess the normalization procedure. Therefore, normalization plots
are usually paired, showing the same data instance normalized and not
normalized. The normalization plots are the Expression boxplots (Boxplots)
plots, the GC content bias (GC bias) plots, the Gene length bias (Length bias)
plots, the Within condition mean-difference (Mean-Difference) plots, the
Mean-variance relationship (Mean-Variance) plot and the RNA composition (Rna
composition) plot. Each plot is accompanied by a detailed description of what it
depicts. Where multiple plot are available (e.g. one for each sample), a
selection list on the top of the respective section allows the selection of the
sample to be displayed.

## 5.4 Statistics

The Statistics section contains several interactive plots that can be used to
inspect and explore the outcome of statistical testing procedures. The
statistics plots are the Volcano plot (Volcano), the MA or Mean-Difference
across conditions (MA) plot, the Expression heatmap (Heatmap) plot, the
Chromosome and biotype distributions (Biodist) plot, the Venn diagram across
statistical tests (StatVenn), the Venn diagram across contrasts (FoldVenn) and
the Deregulogram. Each plot is accompanied by a detailed description of what it
depicts. Please note that the heatmap plots show only the top percentage of
differentially expressed genes as this is controlled by the `reportTop`
parameter of the pipeline. When multiple plots are available (e.g. one for each
contrast), a selection list on the top of the respective section allows the
selection of the sample to be displayed.

## 5.5 Results

The Results section contains a snapshot of the differentially expressed genes in
table format with basic information about each gene and some links to external
resources. Certain columns of the table are colored according to significance.
Larger bars and more intense colors indicate higher significance. For example,
bar in the *p\_value* column is larger if the genes has higher statistical
significance and the fold change cell background is bright red if the gene is
highly up-regulated. From the **Results** section, full gene lists can be
downloaded in text tab-delimited format and viewed with a spreadsheet
application like MS Excel. A selector on the top of the section above the table
allows the display of different contrasts.

## 5.6 References

The References section contains bibliographical references regading the
algorihtms used by the metaseqr2 pipeline and is adjusted according to the
algorithms selected.

# 6 Genome browser tracks

metaseqR2 utilizes Bioconductor facilities to create normalized bigWig files.
It also creates a link to open single stranded tracks in the genome browser and
a track hub to display stranded tracks, in case where a stranded RNA-Seq
protocol has been applied. Just make sure that their output directory is served
by a web server like Apache. See main documentation for more details.

Please note that if requested, metaseqR2 will try to create tracks even with a
custom organism. This is somewhat risky as

* the track generation may fail
* for heavily customized cases, you will manually have to crate aso .2bit files
  for visualization in e.g. the UCSC Genome Browser

Nevertheless, we have chosen to allow the track generation as, many times a user
just uses slight modifications of e.g. the human genome annotation, where some
elements may be manually curated, of elements are added (e.g. non-annotated
non-coding RNAs). Therefore, in case of custom organisms, a warning is thrown
but the functionality is not turned off. Please turn off manually if you are
sure you do not want tracks. You may also use the `createSignalTracks` function
directly.

# 7 List of required packages

Although this is not usually the content of a vignette, the complex nature of
the package requires this list to be populated also here. Therefore, metaseqR2
would benefit from the existence of all the following packages:

* ABSSeq
* Biobase
* BiocGenerics
* BiocManager
* BiocParallel
* BiocStyle
* biomaRt
* Biostrings
* BSgenome
* corrplot
* DESeq
* DESeq2
* DSS
* DT
* EDASeq
* edgeR
* GenomeInfoDb
* GenomicAlignments
* GenomicFeatures
* GenomicRanges
* gplots
* graphics
* grDevices
* heatmaply
* htmltools
* httr
* IRanges
* jsonlite
* knitr
* limma
* log4r
* magrittr
* methods
* NBPSeq
* NOISeq
* pander
* parallel
* qvalue
* rmarkdown
* rmdformats
* RMySQL
* Rsamtools
* RSQLite
* rtracklayer
* RUnit
* S4Vectors
* Seqinfo
* stats
* stringr
* SummarizedExperiment
* survcomp
* TCC
* utils
* VennDiagram
* vsn
* zoo

A recent version of [Pandoc](https://pandoc.org/) is also required, ideally
above 2.0.

# 8 Session Info

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
## [1] splines   stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] pander_0.6.6                magrittr_2.0.4
##  [3] htmltools_0.5.8.1           heatmaply_1.6.0
##  [5] viridis_0.6.5               viridisLite_0.4.2
##  [7] plotly_4.11.0               ggplot2_4.0.0
##  [9] gplots_3.2.0                DT_0.34.0
## [11] rmdformats_1.0.4            knitr_1.50
## [13] metaseqR2_1.22.0            locfit_1.5-9.12
## [15] limma_3.66.0                DESeq2_1.50.0
## [17] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [19] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [21] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [23] IRanges_2.44.0              S4Vectors_0.48.0
## [25] BiocGenerics_0.56.0         generics_0.1.4
## [27] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] BiocIO_1.20.0             survcomp_1.60.0
##  [3] bitops_1.0-9              filelock_1.0.3
##  [5] tibble_3.3.0              R.oo_1.27.1
##  [7] preprocessCore_1.72.0     XML_3.99-0.19
##  [9] lifecycle_1.0.4           httr2_1.2.1
## [11] pwalign_1.6.0             edgeR_4.8.0
## [13] globals_0.18.0            MASS_7.3-65
## [15] lattice_0.22-7            crosstalk_1.2.2
## [17] dendextend_1.19.1         sass_0.4.10
## [19] rmarkdown_2.30            jquerylib_0.1.4
## [21] yaml_2.3.10               DBI_1.2.3
## [23] RColorBrewer_1.1-3        ABSSeq_1.64.0
## [25] harmonicmeanp_3.0.1       abind_1.4-8
## [27] ShortRead_1.68.0          purrr_1.1.0
## [29] R.utils_2.13.0            rmeta_3.0
## [31] RCurl_1.98-1.17           rappdirs_0.3.3
## [33] lava_1.8.1                seriation_1.5.8
## [35] survivalROC_1.0.3.1       listenv_0.9.1
## [37] genefilter_1.92.0         parallelly_1.45.1
## [39] annotate_1.88.0           permute_0.9-8
## [41] DelayedMatrixStats_1.32.0 codetools_0.2-20
## [43] DelayedArray_0.36.0       xml2_1.4.1
## [45] SuppDists_1.1-9.9         tidyselect_1.2.1
## [47] futile.logger_1.4.3       UCSC.utils_1.6.0
## [49] farver_2.1.2              TSP_1.2-5
## [51] BiocFileCache_3.0.0       webshot_0.5.5
## [53] GenomicAlignments_1.46.0  jsonlite_2.0.0
## [55] iterators_1.0.14          survival_3.8-3
## [57] foreach_1.5.2             tools_4.5.1
## [59] progress_1.2.3            Rcpp_1.1.0
## [61] glue_1.8.0                prodlim_2025.04.28
## [63] gridExtra_2.3             SparseArray_1.10.0
## [65] xfun_0.53                 qvalue_2.42.0
## [67] GenomeInfoDb_1.46.0       ca_0.71.1
## [69] dplyr_1.1.4               HDF5Array_1.38.0
## [71] withr_3.0.2               NBPSeq_0.3.1
## [73] formatR_1.14              BiocManager_1.30.26
## [75] fastmap_1.2.0
##  [ reached 'max' / getOption("max.print") -- omitted 92 entries ]
```