# `annotatr`: Making sense of genomic regions

Raymond G. Cavalcante

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Annotations](#annotations)
  + [3.1 CpG Annotations](#cpg-annotations)
  + [3.2 Genic Annotations](#genic-annotations)
  + [3.3 FANTOM5 Permissive Enhancers](#fantom5-permissive-enhancers)
  + [3.4 GENCODE lncRNA transcripts](#gencode-lncrna-transcripts)
  + [3.5 Chromatin states from ChromHMM](#chromatin-states-from-chromhmm)
  + [3.6 `AnnotationHub` Annotations](#annotationhub-annotations)
  + [3.7 Custom Annotations](#custom-annotations)
* [4 Usage](#usage)
  + [4.1 Reading Genomic Regions](#reading-genomic-regions)
  + [4.2 Annotating Regions](#annotating-regions)
  + [4.3 Randomizing Regions](#randomizing-regions)
  + [4.4 Summarizing Over Annotations](#summarizing-over-annotations)
  + [4.5 Plotting](#plotting)
    - [4.5.1 Plotting Regions per Annotation](#plotting-regions-per-annotation)
    - [4.5.2 Plotting Regions Occurring in Pairs of Annotations](#plotting-regions-occurring-in-pairs-of-annotations)
    - [4.5.3 Plotting Numerical Data Over Regions](#plotting-numerical-data-over-regions)
    - [4.5.4 Plotting Categorical Data](#plotting-categorical-data)

# 1 Introduction

Genomic regions resulting from next-generation sequencing experiments and bioinformatics pipelines are more meaningful when annotated to genomic features. A SNP occurring in an exon, or an enhancer, is likely of greater interest than one occurring in an inter-genic region. It may be of interest to find that a particular transcription factor overwhelmingly binds in promoters, while another binds mostly in 3’UTRs. Hyper-methylation at promoters containing a CpG island may indicate different regulatory regimes in one condition compared to another.

`annotatr` provides genomic annotations and a set of functions to read, intersect, summarize, and visualize genomic regions in the context of genomic annotations.

# 2 Installation

The release version of `annotatr` is available via [Bioconductor](http://bioconductor.org/packages/annotatr/), and can be installed as follows:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("annotatr")
```

The development version of `annotatr` can be obtained via the [GitHub repository](https://github.com/rcavalcante/annotatr) or [Bioconductor](https://bioconductor.org/packages/devel/bioc/html/annotatr.html). It is easiest to install development versions with the [`devtools`](https://cran.r-project.org/web/packages/devtools/index.html) package as follows:

```
devtools::install_github('rcavalcante/annotatr')
```

Changelogs for development releases will be detailed on [GitHub releases](https://github.com/rcavalcante/annotatr/releases).

# 3 Annotations

There are three types of annotations available to annotatr:

1. Built-in annotations including CpG annotations, genic annotations, enhancers, GENCODE lncRNAs, and chromatin states from chromHMM. Base data for each of these annotations is retrieved and processed in some way. See each below for details on data source and processing.
2. AnnotationHub annotations include any GRanges resource within the Bioconductor AnnotationHub web resource.
3. Custom annotations provided by the user.

## 3.1 CpG Annotations

The CpG islands are the basis for all CpG annotations, and are given by the `AnnotationHub` package for the given organism. CpG shores are defined as 2Kb upstream/downstream from the ends of the CpG islands, less the CpG islands. CpG shelves are defined as another 2Kb upstream/downstream of the farthest upstream/downstream limits of the CpG shores, less the CpG islands and CpG shores. The remaining genomic regions make up the inter-CGI annotation.

CpG annotations are available for hg19, hg38, mm9, mm10, rn4, rn5, rn6.

![](data:image/jpeg;base64...)

Schematic of CpG annotations.

## 3.2 Genic Annotations

The genic annotations are determined by functions from `GenomicFeatures` and data from the `TxDb.*` and `org.*.eg.db` packages. Genic annotations include 1-5Kb upstream of the TSS, the promoter (< 1Kb upstream of the TSS), 5’UTR, first exons, exons, introns, CDS, 3’UTR, and intergenic regions (the intergenic regions exclude the previous list of annotations). The schematic below illustrates the relationship between the different annotations as extracted from the `TxDb.*` packages via `GenomicFeatures` functions.

![](data:image/jpeg;base64...)

Schematic of knownGene annotations.

Also included in genic annotations are intronexon and exonintron boundaries. These annotations are 200bp up/down stream of any boundary between an exon and intron. Important to note, is that the boundaries are with respect to the strand of the gene.

Non-intergenic gene annotations include Entrez ID and gene symbol information where it exists. The `org.*.eg.db` packages for the appropriate organisms are used to provide gene IDs and gene symbols.

The genic annotations have populated `tx_id`, `gene_id`, and `symbol` columns. Respectively they are, the knownGene transcript name, Entrez Gene ID, and gene symbol.

Genic annotations are available for all hg19, hg38, mm9, mm10, rn4, rn5, rn6, dm3, and dm6.

## 3.3 FANTOM5 Permissive Enhancers

FANTOM5 permissive enhancers were determined from bi-directional CAGE transcription as in [Andersson et al. (2014)](http://www.nature.com/nature/journal/v507/n7493/full/nature12787.html), and are downloaded and processed for hg19 and mm9 from the [FANTOM5](http://fantom.gsc.riken.jp/5/datafiles/phase2.0/extra/Enhancers/) resource. Using the `rtracklayer::liftOver()` function, enhancers from hg19 are lifted to hg38, and mm9 to mm10.

## 3.4 GENCODE lncRNA transcripts

The long non-coding RNA (lncRNA) annotations are from [GENCODE](https://www.gencodegenes.org) for hg19, hg38, and mm10. The lncRNA transcripts are used, and we eventually plan to include the lncRNA introns/exons at a later date. The lncRNA annotations have populated `tx_id`, `gene_id`, and `symbol` columns. Respectively they are, the Ensembl transcript name, Entrez Gene ID, and gene symbol. As per the `transcript_type` field in the GENCODE anntotations, the [biotypes](https://www.gencodegenes.org/gencode_biotypes.html) are given in the `id` column.

## 3.5 Chromatin states from ChromHMM

Chromatin states determined by chromHMM ([Ernst and Kellis (2012)](http://www.nature.com/nmeth/journal/v9/n3/full/nmeth.1906.html)) in hg19 are available for nine cell lines (Gm12878, H1hesc, Hepg2, Hmec, Hsmm, Huvec, K562, Nhek, and Nhlf) via the UCSC Genome Browser tracks. Annotations for all states can be built using a shortcut like `hg19_Gm12878-chromatin`, or specific chromatin states can be accessed via codes like `hg19_chromatin_Gm12878-StrongEnhancer` or `hg19_chromatin_Gm12878-Repressed`.

## 3.6 `AnnotationHub` Annotations

The `AnnotationHub` Bioconductor package is a client for the AnnotationHub web resource. From the package description:

> The AnnotationHub web resource provides a central location where genomic files (e.g., VCF, bed, wig) and other resources from standard locations (e.g., UCSC, Ensembl) can be discovered. The resource includes metadata about each resource, e.g., a textual description, tags, and date of modification. The client creates and manages a local cache of files retrieved by the user, helping with quick and reproducible access.

Using the `build_ah_annots()` function, users can turn any resource of class `GRanges` into an annotation for use in `annotatr`. As an example, we create annotations for H3K4me3 ChIP-seq peaks in Gm12878 and H1-hesc cells.

```
# Create a named vector for the AnnotationHub accession codes with desired names
h3k4me3_codes = c('Gm12878' = 'AH23256')
# Fetch ah_codes from AnnotationHub and create annotations annotatr understands
build_ah_annots(genome = 'hg19', ah_codes = h3k4me3_codes, annotation_class = 'H3K4me3')
# The annotations as they appear in annotatr_cache
ah_names = c('hg19_H3K4me3_Gm12878')

print(annotatr_cache$get('hg19_H3K4me3_Gm12878'))
```

```
## GRanges object with 57476 ranges and 5 metadata columns:
##           seqnames              ranges strand |                    id     tx_id
##              <Rle>           <IRanges>  <Rle> |           <character> <logical>
##       [1]     chr1       713208-713477      * |     H3K4me3_Gm12878:1      <NA>
##       [2]     chr1       713874-714056      * |     H3K4me3_Gm12878:2      <NA>
##       [3]     chr1       714474-714750      * |     H3K4me3_Gm12878:3      <NA>
##       [4]     chr1       715069-715388      * |     H3K4me3_Gm12878:4      <NA>
##       [5]     chr1       724097-724311      * |     H3K4me3_Gm12878:5      <NA>
##       ...      ...                 ...    ... .                   ...       ...
##   [57472]     chrX 154996923-154997189      * | H3K4me3_Gm12878:57472      <NA>
##   [57473]     chrX 154997422-154997785      * | H3K4me3_Gm12878:57473      <NA>
##   [57474]     chrX 155100454-155128015      * | H3K4me3_Gm12878:57474      <NA>
##   [57475]     chrX 155148379-155155444      * | H3K4me3_Gm12878:57475      <NA>
##   [57476]     chrX 155227027-155228269      * | H3K4me3_Gm12878:57476      <NA>
##             gene_id    symbol                 type
##           <logical> <logical>          <character>
##       [1]      <NA>      <NA> hg19_H3K4me3_Gm12878
##       [2]      <NA>      <NA> hg19_H3K4me3_Gm12878
##       [3]      <NA>      <NA> hg19_H3K4me3_Gm12878
##       [4]      <NA>      <NA> hg19_H3K4me3_Gm12878
##       [5]      <NA>      <NA> hg19_H3K4me3_Gm12878
##       ...       ...       ...                  ...
##   [57472]      <NA>      <NA> hg19_H3K4me3_Gm12878
##   [57473]      <NA>      <NA> hg19_H3K4me3_Gm12878
##   [57474]      <NA>      <NA> hg19_H3K4me3_Gm12878
##   [57475]      <NA>      <NA> hg19_H3K4me3_Gm12878
##   [57476]      <NA>      <NA> hg19_H3K4me3_Gm12878
##   -------
##   seqinfo: 298 sequences (2 circular) from hg19 genome
```

## 3.7 Custom Annotations

Users may load their own annotations from BED files using the `read_annotations()` function, which uses the `rtracklayer::import()` function. The output is a `GRanges` with `mcols()` for `id`, `tx_id`, `gene_id`, `symbol`, and `type`. If a user wants to include `tx_id`, `gene_id`, and/or `symbol` in their custom annotations they can be included as extra columns on a BED6 input file.

```
## Use ENCODE ChIP-seq peaks for EZH2 in GM12878
## These files contain chr, start, and end columns
ezh2_file = system.file('extdata', 'Gm12878_Ezh2_peak_annotations.txt.gz', package = 'annotatr')

## Custom annotation objects are given names of the form genome_custom_name
read_annotations(con = ezh2_file, genome = 'hg19', name = 'ezh2', format = 'bed')

print(annotatr_cache$get('hg19_custom_ezh2'))
```

```
## GRanges object with 2472 ranges and 5 metadata columns:
##          seqnames              ranges strand |          id     tx_id   gene_id
##             <Rle>           <IRanges>  <Rle> | <character> <logical> <logical>
##      [1]     chr1       860063-860382      * |      ezh2:1      <NA>      <NA>
##      [2]     chr1       934911-935230      * |      ezh2:2      <NA>      <NA>
##      [3]     chr1     3573321-3573640      * |      ezh2:3      <NA>      <NA>
##      [4]     chr1     6301401-6301720      * |      ezh2:4      <NA>      <NA>
##      [5]     chr1     6301996-6302315      * |      ezh2:5      <NA>      <NA>
##      ...      ...                 ...    ... .         ...       ...       ...
##   [2468]     chrX   99880950-99881269      * |   ezh2:2468      <NA>      <NA>
##   [2469]     chrX 108514101-108514420      * |   ezh2:2469      <NA>      <NA>
##   [2470]     chrX 111981673-111981992      * |   ezh2:2470      <NA>      <NA>
##   [2471]     chrX 118109216-118109535      * |   ezh2:2471      <NA>      <NA>
##   [2472]     chrX 136114771-136115090      * |   ezh2:2472      <NA>      <NA>
##             symbol             type
##          <logical>      <character>
##      [1]      <NA> hg19_custom_ezh2
##      [2]      <NA> hg19_custom_ezh2
##      [3]      <NA> hg19_custom_ezh2
##      [4]      <NA> hg19_custom_ezh2
##      [5]      <NA> hg19_custom_ezh2
##      ...       ...              ...
##   [2468]      <NA> hg19_custom_ezh2
##   [2469]      <NA> hg19_custom_ezh2
##   [2470]      <NA> hg19_custom_ezh2
##   [2471]      <NA> hg19_custom_ezh2
##   [2472]      <NA> hg19_custom_ezh2
##   -------
##   seqinfo: 298 sequences (2 circular) from hg19 genome
```

To see what is in the `annotatr_cache` environment, do the following:

```
print(annotatr_cache$list_env())
```

```
## [1] "hg19_H3K4me3_Gm12878" "hg19_custom_ezh2"
```

# 4 Usage

The following example is based on the results of testing for differential methylation of genomic regions between two conditions using [methylSig](https://github.com/sartorlab/methylSig). The file (`inst/extdata/IDH2mut_v_NBM_multi_data_chr9.txt.gz`) contains chromosome locations, as well as categorical and numerical data columns, and provides a good example of the flexibility of `annotatr`.

## 4.1 Reading Genomic Regions

`read_regions()` uses the `rtracklayer::import()` function to read in BED files and convert them to `GRanges` objects. The `name` and `score` columns in a normal BED file can be used for categorical and numeric data, respectively. Additionally, an arbitrary number of categorical and numeric data columns can be appended to a BED6 file. The `extraCols` parameter is used for this purpose, and the `rename_name` and `rename_score` columns allow users to give more descriptive names to these columns.

```
# This file in inst/extdata represents regions tested for differential
# methylation between two conditions. Additionally, there are columns
# reporting the p-value on the test for differential meth., the
# meth. difference between the two groups, and the group meth. rates.
dm_file = system.file('extdata', 'IDH2mut_v_NBM_multi_data_chr9.txt.gz', package = 'annotatr')
extraCols = c(diff_meth = 'numeric', mu0 = 'numeric', mu1 = 'numeric')
dm_regions = read_regions(con = dm_file, genome = 'hg19', extraCols = extraCols, format = 'bed',
    rename_name = 'DM_status', rename_score = 'pval')
# Use less regions to speed things up
dm_regions = dm_regions[1:2000]
print(dm_regions)
```

```
## GRanges object with 2000 ranges and 5 metadata columns:
##          seqnames            ranges strand |   DM_status      pval   diff_meth
##             <Rle>         <IRanges>  <Rle> | <character> <numeric>   <numeric>
##      [1]     chr9       10850-10948      * |        none 0.5045502 -10.7329047
##      [2]     chr9       10950-11048      * |        none 0.2227126   8.7195270
##      [3]     chr9       28950-29048      * |        none 0.5530958   0.0700847
##      [4]     chr9       72850-72948      * |       hyper 0.0116294  44.8753244
##      [5]     chr9       72950-73048      * |        none 0.1752872  17.7606626
##      ...      ...               ...    ... .         ...       ...         ...
##   [1996]     chr9 35605150-35605248      * |        none  0.274255  -0.0539158
##   [1997]     chr9 35605250-35605348      * |        none  0.918064   0.0329283
##   [1998]     chr9 35605350-35605448      * |        none  0.614312  -0.0977500
##   [1999]     chr9 35605450-35605548      * |        none  1.000000   0.0000000
##   [2000]     chr9 35605550-35605648      * |        none  0.814567   0.0349967
##                mu0        mu1
##          <numeric>  <numeric>
##      [1] 79.981920 90.7148252
##      [2] 86.704015 77.9844878
##      [3]  0.124081  0.0539963
##      [4] 72.455413 27.5800883
##      [5] 28.440368 10.6797057
##      ...       ...        ...
##   [1996]  0.000000  0.0539158
##   [1997]  0.328024  0.2950959
##   [1998]  0.130184  0.2279345
##   [1999]  0.000000  0.0000000
##   [2000]  0.118272  0.0832756
##   -------
##   seqinfo: 298 sequences (2 circular) from hg19 genome
```

## 4.2 Annotating Regions

Users may select annotations a la carte via the accessors listed with `builtin_annotations()`, shortcuts, or use custom annotations as described above. The `hg19_cpgs` shortcut annotates regions to CpG islands, CpG shores, CpG shelves, and inter-CGI. The `hg19_basicgenes` shortcut annotates regions to 1-5Kb, promoters, 5’UTRs, exons, introns, and 3’UTRs. Shortcuts for other `builtin_genomes()` are accessed in a similar way.

`annotate_regions()` requires a `GRanges` object (either the result of `read_regions()` or an existing object), a `GRanges` object of the `annotations`, and a logical value indicating whether to `ignore.strand` when calling `GenomicRanges::findOverlaps()`. The positive integer `minoverlap` is also passed to `GenomicRanges::findOverlaps()` and specifies the minimum overlap required for a region to be assigned to an annotation.

Before annotating regions, they must be built with `build_annotations()` which requires a character vector of desired annotation codes.

```
# Select annotations for intersection with regions
# Note inclusion of custom annotation, and use of shortcuts
annots = c('hg19_cpgs', 'hg19_basicgenes', 'hg19_genes_intergenic',
    'hg19_genes_intronexonboundaries',
    'hg19_custom_ezh2', 'hg19_H3K4me3_Gm12878')

# Build the annotations (a single GRanges object)
annotations = build_annotations(genome = 'hg19', annotations = annots)

# Intersect the regions we read in with the annotations
dm_annotated = annotate_regions(
    regions = dm_regions,
    annotations = annotations,
    ignore.strand = TRUE,
    quiet = FALSE)
# A GRanges object is returned
print(dm_annotated)
```

```
## GRanges object with 24517 ranges and 6 metadata columns:
##           seqnames            ranges strand |   DM_status      pval diff_meth
##              <Rle>         <IRanges>  <Rle> | <character> <numeric> <numeric>
##       [1]     chr9       10850-10948      * |        none   0.50455  -10.7329
##       [2]     chr9       10850-10948      * |        none   0.50455  -10.7329
##       [3]     chr9       10850-10948      * |        none   0.50455  -10.7329
##       [4]     chr9       10850-10948      * |        none   0.50455  -10.7329
##       [5]     chr9       10850-10948      * |        none   0.50455  -10.7329
##       ...      ...               ...    ... .         ...       ...       ...
##   [24513]     chr9 35605550-35605648      * |        none  0.814567 0.0349967
##   [24514]     chr9 35605550-35605648      * |        none  0.814567 0.0349967
##   [24515]     chr9 35605550-35605648      * |        none  0.814567 0.0349967
##   [24516]     chr9 35605550-35605648      * |        none  0.814567 0.0349967
##   [24517]     chr9 35605550-35605648      * |        none  0.814567 0.0349967
##                 mu0       mu1                    annot
##           <numeric> <numeric>                <GRanges>
##       [1]   79.9819   90.7148        chr9:9990-10989:+
##       [2]   79.9819   90.7148       chr9:10016-11015:+
##       [3]   79.9819   90.7148       chr9:10019-11018:+
##       [4]   79.9819   90.7148       chr9:10048-11047:+
##       [5]   79.9819   90.7148       chr9:10070-11069:+
##       ...       ...       ...                      ...
##   [24513]  0.118272 0.0832756 chr9:35605048-35609047:-
##   [24514]  0.118272 0.0832756 chr9:35605259-35605616:+
##   [24515]  0.118272 0.0832756 chr9:35605259-35605835:+
##   [24516]  0.118272 0.0832756 chr9:35605488-35605835:+
##   [24517]  0.118272 0.0832756 chr9:35603969-35605991:*
##   -------
##   seqinfo: 298 sequences (2 circular) from hg19 genome
```

The `annotate_regions()` function returns a `GRanges`, but it may be more convenient to manipulate a coerced `data.frame`. For example,

```
# Coerce to a data.frame
df_dm_annotated = data.frame(dm_annotated)

# See the GRanges column of dm_annotaed expanded
print(head(df_dm_annotated))
```

```
##   seqnames start   end width strand DM_status      pval diff_meth      mu0
## 1     chr9 10850 10948    99      *      none 0.5045502  -10.7329 79.98192
## 2     chr9 10850 10948    99      *      none 0.5045502  -10.7329 79.98192
## 3     chr9 10850 10948    99      *      none 0.5045502  -10.7329 79.98192
## 4     chr9 10850 10948    99      *      none 0.5045502  -10.7329 79.98192
## 5     chr9 10850 10948    99      *      none 0.5045502  -10.7329 79.98192
## 6     chr9 10850 10948    99      *      none 0.5045502  -10.7329 79.98192
##        mu1 annot.seqnames annot.start annot.end annot.width annot.strand
## 1 90.71483           chr9        9990     10989        1000            +
## 2 90.71483           chr9       10016     11015        1000            +
## 3 90.71483           chr9       10019     11018        1000            +
## 4 90.71483           chr9       10048     11047        1000            +
## 5 90.71483           chr9       10070     11069        1000            +
## 6 90.71483           chr9       10086     11085        1000            +
##          annot.id         annot.tx_id annot.gene_id annot.symbol
## 1 promoter:179955 ENST00000806475.1_2     100287596      DDX11L5
## 2 promoter:179956 ENST00000806476.1_1     100287596      DDX11L5
## 3 promoter:179957 ENST00000806477.1_1     100287596      DDX11L5
## 4 promoter:179958 ENST00000806478.1_1     100287596      DDX11L5
## 5 promoter:179959 ENST00000806479.1_1     100287596      DDX11L5
## 6 promoter:179960 ENST00000806480.1_1     100287596      DDX11L5
##             annot.type
## 1 hg19_genes_promoters
## 2 hg19_genes_promoters
## 3 hg19_genes_promoters
## 4 hg19_genes_promoters
## 5 hg19_genes_promoters
## 6 hg19_genes_promoters
```

```
# Subset based on a gene symbol, in this case NOTCH1
notch1_subset = subset(df_dm_annotated, annot.symbol == 'NOTCH1')
print(head(notch1_subset))
```

```
##  [1] seqnames       start          end            width          strand
##  [6] DM_status      pval           diff_meth      mu0            mu1
## [11] annot.seqnames annot.start    annot.end      annot.width    annot.strand
## [16] annot.id       annot.tx_id    annot.gene_id  annot.symbol   annot.type
## <0 rows> (or 0-length row.names)
```

## 4.3 Randomizing Regions

Given a set of annotated regions, it is important to know how the annotations compare to those of a randomized set of regions. The `randomize_regions()` function is a wrapper of `regioneR::randomizeRegions()` from the [`regioneR`](http://bioconductor.org/packages/release/bioc/html/regioneR.html) package that creates a set of random regions given a `GRanges` object. After creating the random set, they must be annotated with `annotate_regions()` for later use. Only `builtin_genomes()` can be used in our wrapper function. Downstream functions that support using random region annotations are `summarize_annotations()`, `plot_annotation()`, and `plot_categorical()`.

It is important to note that if the regions to be randomized have a particular property, for example they are CpGs, the `randomize_regions()` wrapper will not preserve that property! Instead, we recommend using `regioneR::resampleRegions()` with `universe` being the superset of the data regions you want to sample from.

```
# Randomize the input regions
dm_random_regions = randomize_regions(
    regions = dm_regions,
    allow.overlaps = TRUE,
    per.chromosome = TRUE)

# Annotate the random regions using the same annotations as above
# These will be used in later functions
dm_random_annotated = annotate_regions(
    regions = dm_random_regions,
    annotations = annotations,
    ignore.strand = TRUE,
    quiet = TRUE)
```

## 4.4 Summarizing Over Annotations

When there is no categorical or numerical information associated with the regions, `summarize_annotations()` is the only possible summarization function to use. It gives the counts of regions in each annotation type (see example below). If there is categorical and/or numerical information, then `summarize_numerical()` and/or `summarize_categorical()` may be used. Using random region annotations is only available for `summarize_annotations()`.

```
# Find the number of regions per annotation type
dm_annsum = summarize_annotations(
    annotated_regions = dm_annotated,
    quiet = TRUE)
print(dm_annsum)
```

```
## # A tibble: 14 × 2
##    annot.type                          n
##    <chr>                           <int>
##  1 hg19_H3K4me3_Gm12878              747
##  2 hg19_cpg_inter                    905
##  3 hg19_cpg_islands                  848
##  4 hg19_cpg_shelves                   46
##  5 hg19_cpg_shores                   341
##  6 hg19_custom_ezh2                    7
##  7 hg19_genes_1to5kb                 595
##  8 hg19_genes_3UTRs                   69
##  9 hg19_genes_5UTRs                  320
## 10 hg19_genes_exons                  790
## 11 hg19_genes_intergenic             181
## 12 hg19_genes_intronexonboundaries   571
## 13 hg19_genes_introns               1452
## 14 hg19_genes_promoters              783
```

```
# Find the number of regions per annotation type
# and the number of random regions per annotation type
dm_annsum_rnd = summarize_annotations(
    annotated_regions = dm_annotated,
    annotated_random = dm_random_annotated,
    quiet = TRUE)
print(dm_annsum_rnd)
```

```
## # A tibble: 27 × 3
## # Groups:   data_type [2]
##    data_type annot.type               n
##    <chr>     <chr>                <int>
##  1 Data      hg19_H3K4me3_Gm12878   747
##  2 Data      hg19_cpg_inter         905
##  3 Data      hg19_cpg_islands       848
##  4 Data      hg19_cpg_shelves        46
##  5 Data      hg19_cpg_shores        341
##  6 Data      hg19_custom_ezh2         7
##  7 Data      hg19_genes_1to5kb      595
##  8 Data      hg19_genes_3UTRs        69
##  9 Data      hg19_genes_5UTRs       320
## 10 Data      hg19_genes_exons       790
## # ℹ 17 more rows
```

```
# Take the mean of the diff_meth column across all regions
# occurring in an annotation.
dm_numsum = summarize_numerical(
    annotated_regions = dm_annotated,
    by = c('annot.type', 'annot.id'),
    over = c('diff_meth'),
    quiet = TRUE)
print(dm_numsum)
```

```
## # A tibble: 8,535 × 5
## # Groups:   annot.type [14]
##    annot.type           annot.id                  n    mean      sd
##    <chr>                <chr>                 <int>   <dbl>   <dbl>
##  1 hg19_H3K4me3_Gm12878 H3K4me3_Gm12878:27530     1  0.0701 NA
##  2 hg19_H3K4me3_Gm12878 H3K4me3_Gm12878:27531     8  1.28    3.78
##  3 hg19_H3K4me3_Gm12878 H3K4me3_Gm12878:27532     2 13.4     5.11
##  4 hg19_H3K4me3_Gm12878 H3K4me3_Gm12878:27534    10  0.526   0.975
##  5 hg19_H3K4me3_Gm12878 H3K4me3_Gm12878:27535     8  0.407   0.923
##  6 hg19_H3K4me3_Gm12878 H3K4me3_Gm12878:27543     2 -0.0530  0.0749
##  7 hg19_H3K4me3_Gm12878 H3K4me3_Gm12878:27544    11  0.192   0.427
##  8 hg19_H3K4me3_Gm12878 H3K4me3_Gm12878:27545     2  2.80   10.1
##  9 hg19_H3K4me3_Gm12878 H3K4me3_Gm12878:27549     2 -0.811   1.75
## 10 hg19_H3K4me3_Gm12878 H3K4me3_Gm12878:27555     1 -1.50   NA
## # ℹ 8,525 more rows
```

```
# Count the occurrences of classifications in the DM_status
# column across the annotation types.
dm_catsum = summarize_categorical(
    annotated_regions = dm_annotated,
    by = c('annot.type', 'DM_status'),
    quiet = TRUE)
print(dm_catsum)
```

```
## # A tibble: 40 × 3
## # Groups:   annot.type [14]
##    annot.type           DM_status     n
##    <chr>                <chr>     <int>
##  1 hg19_H3K4me3_Gm12878 hyper        78
##  2 hg19_H3K4me3_Gm12878 hypo          8
##  3 hg19_H3K4me3_Gm12878 none        661
##  4 hg19_cpg_inter       hyper        32
##  5 hg19_cpg_inter       hypo         90
##  6 hg19_cpg_inter       none        783
##  7 hg19_cpg_islands     hyper       151
##  8 hg19_cpg_islands     hypo          4
##  9 hg19_cpg_islands     none        693
## 10 hg19_cpg_shelves     hyper         2
## # ℹ 30 more rows
```

## 4.5 Plotting

The 5 plot functions described below are to be used on the object returned by `annotate_regions()`. The plot functions return an object of type `ggplot` that can be viewed (`print`), saved (`ggsave`), or modified with additional `ggplot2` code.

### 4.5.1 Plotting Regions per Annotation

```
# View the number of regions per annotation. This function
# is useful when there is no classification or data
# associated with the regions.
annots_order = c(
    'hg19_custom_ezh2',
    'hg19_H3K4me3_Gm12878',
    'hg19_genes_1to5kb',
    'hg19_genes_promoters',
    'hg19_genes_5UTRs',
    'hg19_genes_exons',
    'hg19_genes_intronexonboundaries',
    'hg19_genes_introns',
    'hg19_genes_3UTRs',
    'hg19_genes_intergenic')
dm_vs_kg_annotations = plot_annotation(
    annotated_regions = dm_annotated,
    annotation_order = annots_order,
    plot_title = '# of Sites Tested for DM annotated on chr9',
    x_label = 'knownGene Annotations',
    y_label = 'Count')
print(dm_vs_kg_annotations)
```

![Number of DM regions per annotation.](data:image/png;base64...)

Figure 1: Number of DM regions per annotation

The `plot_annotation()` can also use the annotated random regions in the `annotated_random` argument to plot the number of random regions per annotation type next to the number of input data regions.

```
# View the number of regions per annotation and include the annotation
# of randomized regions
annots_order = c(
    'hg19_custom_ezh2',
    'hg19_H3K4me3_Gm12878',
    'hg19_genes_1to5kb',
    'hg19_genes_promoters',
    'hg19_genes_5UTRs',
    'hg19_genes_exons',
    'hg19_genes_intronexonboundaries',
    'hg19_genes_introns',
    'hg19_genes_3UTRs',
    'hg19_genes_intergenic')
dm_vs_kg_annotations_wrandom = plot_annotation(
    annotated_regions = dm_annotated,
    annotated_random = dm_random_annotated,
    annotation_order = annots_order,
    plot_title = 'Dist. of Sites Tested for DM (with rndm.)',
    x_label = 'Annotations',
    y_label = 'Count')
print(dm_vs_kg_annotations_wrandom)
```

![Number of DM regions per annotation with randomized regions.](data:image/png;base64...)

Figure 2: Number of DM regions per annotation with randomized regions

### 4.5.2 Plotting Regions Occurring in Pairs of Annotations

```
# View a heatmap of regions occurring in pairs of annotations
annots_order = c(
    'hg19_custom_ezh2',
    'hg19_H3K4me3_Gm12878',
    'hg19_genes_promoters',
    'hg19_genes_5UTRs',
    'hg19_genes_exons',
    'hg19_genes_introns',
    'hg19_genes_3UTRs',
    'hg19_genes_intergenic')
dm_vs_coannotations = plot_coannotations(
    annotated_regions = dm_annotated,
    annotation_order = annots_order,
    axes_label = 'Annotations',
    plot_title = 'Regions in Pairs of Annotations')
print(dm_vs_coannotations)
```

![Number of DM regions per pair of annotations.](data:image/png;base64...)

Figure 3: Number of DM regions per pair of annotations

### 4.5.3 Plotting Numerical Data Over Regions

With numerical data, the `plot_numerical()` function plots a single variable (histogram) or two variables (scatterplot) at the region level, faceting over the categorical variable of choice. It is possible to include two categorical variables to facet over (see below). Note, when the plot is a histogram, the distribution over all regions is plotted within each facet.

```
dm_vs_regions_annot = plot_numerical(
    annotated_regions = dm_annotated,
    x = 'mu0',
    facet = 'annot.type',
    facet_order = c('hg19_genes_1to5kb','hg19_genes_promoters',
        'hg19_genes_5UTRs','hg19_genes_3UTRs', 'hg19_custom_ezh2',
        'hg19_genes_intergenic', 'hg19_cpg_islands'),
    bin_width = 5,
    plot_title = 'Group 0 Region Methylation In Genes',
    x_label = 'Group 0')
print(dm_vs_regions_annot)
```

![Methylation Rates in Group 0 for Regions Over DM Status.](data:image/png;base64...)

Figure 4: Methylation Rates in Group 0 for Regions Over DM Status

```
dm_vs_regions_annot2 = plot_numerical(
    annotated_regions = dm_annotated,
    x = 'diff_meth',
    facet = c('annot.type','DM_status'),
    facet_order = list(c('hg19_genes_promoters','hg19_genes_5UTRs','hg19_cpg_islands'), c('hyper','hypo','none')),
    bin_width = 5,
    plot_title = 'Group 0 Region Methylation In Genes',
    x_label = 'Methylation Difference')
print(dm_vs_regions_annot2)
```

![Methylation Differences for Regions Over DM Status and Annotation Type.](data:image/png;base64...)

Figure 5: Methylation Differences for Regions Over DM Status and Annotation Type

```
dm_vs_regions_name = plot_numerical(
    annotated_regions = dm_annotated,
    x = 'mu0',
    y = 'mu1',
    facet = 'annot.type',
    facet_order = c('hg19_genes_1to5kb','hg19_genes_promoters',
        'hg19_genes_5UTRs','hg19_genes_3UTRs', 'hg19_custom_ezh2',
        'hg19_genes_intergenic', 'hg19_cpg_islands', 'hg19_cpg_shores'),
    plot_title = 'Region Methylation: Group 0 vs Group 1',
    x_label = 'Group 0',
    y_label = 'Group 1')
print(dm_vs_regions_name)
```

![Methylation Rates in Regions Over DM Status in Group 0 vs Group 1.](data:image/png;base64...)

Figure 6: Methylation Rates in Regions Over DM Status in Group 0 vs Group 1

The `plot_numerical_coannotations()` shows the distribution of numerical data for regions occurring in any two annotations, as well as in one or the other annotation. For example, the following example shows CpG methylation rates for CpGs occurring in just promoters, just CpG islands, and both promoters and CpG islands.

```
dm_vs_num_co = plot_numerical_coannotations(
    annotated_regions = dm_annotated,
    x = 'mu0',
    annot1 = 'hg19_cpg_islands',
    annot2 = 'hg19_genes_promoters',
    bin_width = 5,
    plot_title = 'Group 0 Perc. Meth. in CpG Islands and Promoters',
    x_label = 'Percent Methylation')
print(dm_vs_num_co)
```

![Group 0 methylation Rates in Regions in promoters, CpG islands, and both.](data:image/png;base64...)

Figure 7: Group 0 methylation Rates in Regions in promoters, CpG islands, and both

### 4.5.4 Plotting Categorical Data

```
# View the counts of CpG annotations in data classes

# The orders for the x-axis labels. This is also a subset
# of the labels (hyper, hypo, none).
x_order = c(
    'hyper',
    'hypo')
# The orders for the fill labels. Can also use this
# parameter to subset annotation types to fill.
fill_order = c(
    'hg19_cpg_islands',
    'hg19_cpg_shores',
    'hg19_cpg_shelves',
    'hg19_cpg_inter')
# Make a barplot of the data class where each bar
# is composed of the counts of CpG annotations.
dm_vs_cpg_cat1 = plot_categorical(
    annotated_regions = dm_annotated, x='DM_status', fill='annot.type',
    x_order = x_order, fill_order = fill_order, position='stack',
    plot_title = 'DM Status by CpG Annotation Counts',
    legend_title = 'Annotations',
    x_label = 'DM status',
    y_label = 'Count')
print(dm_vs_cpg_cat1)
```

![Differential methylation classification with counts of CpG annotations.](data:image/png;base64...)

Figure 8: Differential methylation classification with counts of CpG annotations

```
# Use the same order vectors as the previous code block,
# but use proportional fill instead of counts.

# Make a barplot of the data class where each bar
# is composed of the *proportion* of CpG annotations.
dm_vs_cpg_cat2 = plot_categorical(
    annotated_regions = dm_annotated, x='DM_status', fill='annot.type',
    x_order = x_order, fill_order = fill_order, position='fill',
    plot_title = 'DM Status by CpG Annotation Proportions',
    legend_title = 'Annotations',
    x_label = 'DM status',
    y_label = 'Proportion')
print(dm_vs_cpg_cat2)
```

![Differential methylation classification with proportion of CpG annotations.](data:image/png;base64...)

Figure 9: Differential methylation classification with proportion of CpG annotations

As with `plot_annotation()` one may add annotations for random regions to the `annotated_random` parameter of `plot_categorical()`. The result is a Random Regions bar representing the distribution of random regions for the categorical variable used for `fill`. NOTE: Random regions can only be added when `fill = 'annot.type'`.

```
# Add in the randomized annotations for "Random Regions" bar

# Make a barplot of the data class where each bar
# is composed of the *proportion* of CpG annotations, and
# includes "All" regions tested for DM and "Random Regions"
# regions consisting of randomized regions.
dm_vs_cpg_cat_random = plot_categorical(
    annotated_regions = dm_annotated, annotated_random = dm_random_annotated,
    x='DM_status', fill='annot.type',
    x_order = x_order, fill_order = fill_order, position='fill',
    plot_title = 'DM Status by CpG Annotation Proportions',
    legend_title = 'Annotations',
    x_label = 'DM status',
    y_label = 'Proportion')
print(dm_vs_cpg_cat_random)
```

![Differential methylation classification with proportion of CpG annotations and random regions.](data:image/png;base64...)

Figure 10: Differential methylation classification with proportion of CpG annotations and random regions

```
# View the proportions of data classes in knownGene annotations

# The orders for the x-axis labels.
x_order = c(
    'hg19_custom_ezh2',
    'hg19_genes_1to5kb',
    'hg19_genes_promoters',
    'hg19_genes_5UTRs',
    'hg19_genes_exons',
    'hg19_genes_introns',
    'hg19_genes_3UTRs',
    'hg19_genes_intergenic')
# The orders for the fill labels.
fill_order = c(
    'hyper',
    'hypo',
    'none')
dm_vs_kg_cat = plot_categorical(
    annotated_regions = dm_annotated, x='annot.type', fill='DM_status',
    x_order = x_order, fill_order = fill_order, position='fill',
    legend_title = 'DM Status',
    x_label = 'knownGene Annotations',
    y_label = 'Proportion')
print(dm_vs_kg_cat)
```

![Basic gene annotations with proportions of DM classification.](data:image/png;base64...)

Figure 11: Basic gene annotations with proportions of DM classification