# The RNA Centric Analysis System Report

#### Bora Uyar, Dilmurat Yusuf, Ricardo Wurmus, Altuna Akalin

#### 2025-10-30

```
library(RCAS)
```

**Warning**: In this vignette, due to space limitations, we demonstrate the functions of RCAS using static images. In order to see how an interactive report from RCAS looks see `RCAS::runReport()`.

For the most up-to-date functionality, usage and installation instructions, and example outputs, see our [github repository here](https://github.com/BIMSBbioinfo/RCAS).

# Introduction

RCAS is an automated system that provides dynamic genome annotations for custom input files that contain transcriptomic regions. Such transcriptomic regions could be, for instance, peak regions detected by CLIP-Seq analysis that detect protein-RNA interactions, RNA modifications (alias the epitranscriptome), CAGE-tag locations, or any other collection of target regions at the level of the transcriptome.

RCAS is designed as a reporting tool for the functional analysis of RNA-binding sites detected by high-throughput experiments. It takes as input a BED format file containing the genomic coordinates of the RNA binding sites and a GTF file that contains the genomic annotation features usually provided by publicly available databases such as Ensembl and UCSC. RCAS performs overlap operations between the genomic coordinates of the RNA binding sites and the genomic annotation features and produces in-depth annotation summaries such as the distribution of binding sites with respect to gene features (exons, introns, 5’/3’ UTR regions, exon-intron boundaries, promoter regions, and whole transcripts) along with functionally enriched term for targeted genes. Moreover, RCAS can darry out discriminative motif discovery in the query regions. The final report of RCAS consists of high-quality dynamic figures and tables, which are readily applicable for publications or other academic usage.

# Data input

RCAS minimally requires as input a BED file and a GTF file. The BED file should contain coordinates/intervals of transcriptomic regions which are located via transcriptomics methods such as Clip-Seq. The GTF file should provide reference annotation. The recommended source of GTF files is the [ENSEMBLE](http://www.ensembl.org/info/data/ftp/index.html) database.

For this vignette, in order to demonstrate RCAS functionality, we use sample BED and GTF data that are built-in the RCAS library, which can be imported using a common R function: data(). To import custom BED and GTF files, the user should execute two RCAS functions called importBed() and importGtf().

## Importing sample data

```
library(RCAS)
data(queryRegions) #sample queryRegions in BED format()
data(gff)          #sample GFF file
```

## Importing custom data

To use importBed() and importGtf(), the user should provide file paths to the respective BED file and GTF file. To reduce memory usage and time consumption, we advise the user to set `sampleN=10000` to avoid huge input of intervals.

```
queryRegions <- importBed(filePath = <path to BED file>, sampleN = 10000)
gff <- importGtf(filePath = <path to GTF file>)
```

# Summarizing Overlaps of Query Regions with Genomic Annotation Features

## Querying the annotation file

```
overlaps <- as.data.table(queryGff(queryRegions = queryRegions, gffData = gff))
```

### Finding targeted gene types

To find out the distribution of the query regions across gene types:

```
biotype_col <- grep('gene_biotype', colnames(overlaps), value = T)
df <- overlaps[,length(unique(queryIndex)), by = biotype_col]
colnames(df) <- c("feature", "count")
df$percent <- round(df$count / length(queryRegions) * 100, 1)
df <- df[order(count, decreasing = TRUE)]
ggplot2::ggplot(df, aes(x = reorder(feature, -percent), y = percent)) +
  geom_bar(stat = 'identity', aes(fill = feature)) +
  geom_label(aes(y = percent + 0.5), label = df$count) +
  labs(x = 'transcript feature', y = paste0('percent overlap (n = ', length(queryRegions), ')')) +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 90))
```

![](data:image/png;base64...)

## Extending the annotation feature space

GTF files contain some annotation features (e.g. exons, transcripts) that are usually explicitly defined, however, some transcript features such as introns, exon-intron boundaries, promoter regions are only implicitly defined. Such implicit features can be extracted from a GTF file using makeTxDb family of functions from the txdbmaker library.

First we create a list of GRanges objects, where each list element contains all the available coordinates of transcript features such as transcripts, exons, introns, 5’/3’ UTRs, exon-intron boundaries, and promoter regions.

```
txdbFeatures <- getTxdbFeaturesFromGRanges(gff)
```

### Plotting overlap counts between query regions and transcript features

To have a global overview of the distribution of query regions across gene features, we can use the summarizeQueryRegions function. If a given query region does not overlap with any of the given coordinates of the transcript features, it is categorized under `NoFeatures`.

```
summary <- summarizeQueryRegions(queryRegions = queryRegions,
                                 txdbFeatures = txdbFeatures)

df <- data.frame(summary)
df$percent <- round((df$count / length(queryRegions)), 3) * 100
df$feature <- rownames(df)
ggplot2::ggplot(df, aes(x = reorder(feature, -percent), y = percent)) +
  geom_bar(stat = 'identity', aes(fill = feature)) +
  geom_label(aes(y = percent + 3), label = df$count) +
  labs(x = 'transcript feature', y = paste0('percent overlap (n = ', length(queryRegions), ')')) +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 90))
```

![](data:image/png;base64...)

### Obtaining a table of overlap counts between query regions and genes

To find out which genes overlap with how many queries and categorise overlaps by transcript features; we use `getTargetedGenesTable` function, which returns a data.frame object.

```
dt <- getTargetedGenesTable(queryRegions = queryRegions,
                           txdbFeatures = txdbFeatures)
dt <- dt[order(transcripts, decreasing = TRUE)]

knitr::kable(dt[1:10,])
```

| tx\_name | transcripts | exons | promoters | fiveUTRs | introns | cds | threeUTRs |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ENST00000317713 | 33 | 28 | 0 | 0 | 5 | 24 | 4 |
| ENST00000361689 | 33 | 28 | 0 | 0 | 5 | 24 | 4 |
| ENST00000372915 | 33 | 28 | 0 | 0 | 5 | 24 | 4 |
| ENST00000539005 | 33 | 28 | 0 | 0 | 5 | 24 | 4 |
| ENST00000545844 | 33 | 28 | 0 | 0 | 5 | 24 | 4 |
| ENST00000564288 | 33 | 28 | 0 | 0 | 5 | 24 | 4 |
| ENST00000567887 | 33 | 28 | 0 | 0 | 5 | 24 | 4 |
| ENST00000372925 | 28 | 23 | 0 | 0 | 5 | 19 | 4 |
| ENST00000289893 | 27 | 22 | 0 | 0 | 5 | 18 | 4 |
| ENST00000367142 | 14 | 14 | 0 | 0 | 0 | 3 | 12 |

### Profiling the coverage of query regions across transcript features

#### Coverage profile of query regions at feature boundaries

It may be useful to look at the distribution of query regions at the boundaries of transcript features. For instance, it may be important to see the relative signal at transcript ends (transcription start sites versus transcription end sites). Or, it may be important to see how the signal is distributed at exon boundaries, which may give an idea about the regulation of the transcript. Here we demonstrate how to get such signal distributions at transcription start/end sites. The same approach can be done for any other collection of transcript features (exons, introns, promoters, UTRs etc.)

```
cvgF <- getFeatureBoundaryCoverage(queryRegions = queryRegions,
                                   featureCoords = txdbFeatures$transcripts,
                                   flankSize = 1000,
                                   boundaryType = 'fiveprime',
                                   sampleN = 10000)
cvgT <- getFeatureBoundaryCoverage(queryRegions = queryRegions,
                                   featureCoords = txdbFeatures$transcripts,
                                   flankSize = 1000,
                                   boundaryType = 'threeprime',
                                   sampleN = 10000)

cvgF$boundary <- 'fiveprime'
cvgT$boundary <- 'threeprime'

df <- rbind(cvgF, cvgT)

ggplot2::ggplot(df, aes(x = bases, y = meanCoverage)) +
  geom_ribbon(fill = 'lightgreen',
              aes(ymin = meanCoverage - standardError * 1.96,
                  ymax = meanCoverage + standardError * 1.96)) +
 geom_line(color = 'black') +
 facet_grid( ~ boundary) + theme_bw(base_size = 14)
```

![](data:image/png;base64...)

#### Coverage profile of query regions for all transcript features

Coverage profiles can be obtained for a single type of transcript feature or a list of transcript features. Here we demonstrate how to get coverage profile of query regions across all available transcript features. It might be a good idea to use sampleN parameter to randomly downsample the target regions to speed up the calculations.

```
cvgList <- calculateCoverageProfileList(queryRegions = queryRegions,
                                       targetRegionsList = txdbFeatures,
                                       sampleN = 10000)

ggplot2::ggplot(cvgList, aes(x = bins, y = meanCoverage)) +
  geom_ribbon(fill = 'lightgreen',
              aes(ymin = meanCoverage - standardError * 1.96,
                  ymax = meanCoverage + standardError * 1.96)) +
 geom_line(color = 'black') + theme_bw(base_size = 14) +
 facet_wrap( ~ feature, ncol = 3)
```

![](data:image/png;base64...)

# Discriminative Motif Discovery

## Calculating enriched motifs

We build a classifier based on k-mer frequencies (allowing for mismatches) to find the most informative motifs that help discriminate the query sequences from the background distribution.

```
motifResults <- runMotifDiscovery(queryRegions = queryRegions,
                           resizeN = 15, sampleN = 10000,
                           genomeVersion = 'hg19', motifWidth = 6,
                           motifN = 1, nCores = 1)

seqLogo::seqLogo(getPWM(motifResults$matches_query[[1]]))
```

![](data:image/png;base64...)

## motif analysis: getting motif summary statistics

A summary table from the motif analysis results can be obtained

```
summary <- getMotifSummaryTable(motifResults)
knitr::kable(summary)
```

|  | patterns | queryHits | controlHits | querySeqs | controlSeqs | queryFraction | controlFraction | oddsRatio | pvalue |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| AGGAGA | AGGAGA | 565 | 265 | 412 | 196 | 0.41 | 0.2 | 2.87 | 0 |

# Functional enrichment analysis

RCAS makes use of [gprofiler2](https://cran.r-project.org/web/packages/gprofiler2/index.html) package enriched functions in genes that overlap the query regions.

```
targetedGenes <- unique(overlaps$gene_id)

res <- RCAS::findEnrichedFunctions(targetGenes = targetedGenes, species = 'hsapiens')
res <- res[order(res$p_value),]
resGO <- res[grep('GO:BP', res$source),]
knitr::kable(subset(resGO[1:10,], select = c('p_value', 'term_name', 'source')))
```

| p\_value | term\_name | source |
| --- | --- | --- |
| 0.0002111 | regulation of mRNA metabolic process | GO:BP |
| 0.0006099 | macromolecule localization | GO:BP |
| 0.0006553 | regulation of cytoplasmic translation | GO:BP |
| 0.0009745 | mRNA catabolic process | GO:BP |
| 0.0010450 | RNA catabolic process | GO:BP |
| 0.0031485 | protein localization | GO:BP |
| 0.0034743 | localization | GO:BP |
| 0.0037557 | cellular macromolecule localization | GO:BP |
| 0.0040866 | regulation of catabolic process | GO:BP |
| 0.0040962 | small molecule metabolic process | GO:BP |

# Generating a full report

The users can use the runReport() function to generate full custom reports including all the analysis modules described above. There are four main parts of the analysis report.

* Annotation summaries via overlap operations
* Functional term analysis
* Motif analysis

By default, runReport() function aims to run all three modules, while the user can turn off these individual modules.

Below are example commands to generate reports using these functionalities.

## A test run for human

```
runReport()
```

## A custom run for human

```
runReport( queryFilePath = 'input.BED',
            gffFilePath = 'annotation.gtf')
```

## To turn off certain modules of the report

```
runReport( queryFilePath = 'input.BED',
            gffFilePath = 'annotation.gtf',
            motifAnalysis = FALSE,
            goAnalysis = FALSE )
```

## To run the pipeline for species other than human

You can run RCAS for any of the genome versions available in the BSgenome package.
See `BSgenome::available.genomes`.

```
runReport( queryFilePath = 'input.mm9.BED',
            gffFilePath = 'annotation.mm9.gtf',
            genomeVersion = 'mm9' )
```

## To turn off verbose output and progress bars

```
runReport(quiet = TRUE)
```

## Printing raw data generated by the runReport function

One may be interested in printing the raw data used to make the plots and tables in the HTML report output of runReport function. Such tables could be used for meta-analysis of multiple analysis results. In order to activate this function, printProcessedTables argument must be set to TRUE.

```
runReport(printProcessedTables = TRUE)
```

# Acknowledgements

RCAS is developed in the group of [Altuna Akalin](http://bioinformatics.mdc-berlin.de/team.html#altuna-akalin-phd) (head of the Scientific Bioinformatics Platform) by [Bora Uyar](http://bioinformatics.mdc-berlin.de/team.html#bora-uyar-phd) (Bioinformatics Scientist), [Dilmurat Yusuf](http://bioinformatics.mdc-berlin.de/team.html#dilmurat-yusuf-phd) (Bioinformatics Scientist) and [Ricardo Wurmus](http://bioinformatics.mdc-berlin.de/team.html#ricardo-wurmus) (System Administrator) at the Berlin Institute of Medical Systems Biology ([BIMSB](https://www.mdc-berlin.de/13800178/en/bimsb)) at the Max-Delbrueck-Center for Molecular Medicine ([MDC](https://www.mdc-berlin.de)) in Berlin.

RCAS is developed as a bioinformatics service as part of the [RNA Bioinformatics Center](http://www.denbi.de/index.php/rbc), which is one of the eight centers of the German Network for Bioinformatics Infrastructure ([de.NBI](http://www.denbi.de/)).