# Splice event prediction and quantification from RNA-seq data

Leonard D Goldstein

#### 30 October 2025

#### Abstract

*SGSeq* is a software package for analyzing splice events from RNA-seq data. Input data are RNA-seq reads mapped to a reference genome in BAM format. Genes are represented as a splice graph, which can be obtained from existing annotation or predicted from the mapped sequence reads. Splice events are identified from the graph and are quantified locally using structurally compatible reads at the start or end of each splice variant. The software includes functions for splice event prediction, quantification, visualization and interpretation.

#### Package

SGSeq 1.44.0

# Contents

* [1 Overview](#overview)
* [2 Preliminaries](#preliminaries)
* [3 RNA transcripts and the *TxFeatures* class](#rna-transcripts-and-the-txfeatures-class)
* [4 The splice graph and the *SGFeatures* class](#the-splice-graph-and-the-sgfeatures-class)
* [5 Splice graph analysis based on annotated transcripts](#splice-graph-analysis-based-on-annotated-transcripts)
* [6 Splice graph analysis based on *de novo* prediction](#splice-graph-analysis-based-on-de-novo-prediction)
* [7 Splice variant identification](#splice-variant-identification)
* [8 Splice variant quantification](#splice-variant-quantification)
* [9 Splice variant interpretation](#splice-variant-interpretation)
* [10 Visualization](#visualization)
* [11 Testing for differential splice variant usage](#testing-for-differential-splice-variant-usage)
* [12 Advanced usage](#advanced-usage)
* [13 Multi-core use and memory requirements](#multi-core-use-and-memory-requirements)
* [14 Session information](#session-information)
* [References](#references)

# 1 Overview

*SGSeq* provides functions and data structures for analyzing splice events from RNA-seq data. An overview of *SGSeq* classes and how they are related is shown in Figure 1 and summarized below:

* The *TxFeatures* class stores discrete transcript features (exons and splice junctions) as they are observed in RNA transcripts. These can be extracted from annotation or predicted from aligned RNA-seq reads.
* The *SGFeatures* class stores features defining a splice graph (Heber et al. [2002](#ref-Heber:2002aa)). The splice graph is a directed acyclic graph with edges corresponding to exonic regions and splice junctions, and nodes corresponding to transcript starts, ends and splice sites. It is directed from the 5\(^\prime\) end to the 3\(^\prime\) end of a gene.
* The *SGVariants* class stores splice variants. If two nodes in the splice graph are connected by two or more paths, and there are no intervening nodes with all paths intersecting, the alternative paths are considered splice variants. Splice variants sharing the same start and end node, together form a splice event.

If you use *SGSeq*, please cite:

* Goldstein LD, Cao Y, Pau G, Lawrence M, Wu TD, Seshagiri S, Gentleman R (2016) Prediction and Quantification of Splice Events from RNA-Seq Data. PLoS ONE 11(5): e0156132. [doi:10.1371/journal.pone.0156132](http://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0156132)

![](data:image/png;base64...)

**Figure 1.** Overview of *SGSeq* data structures. (**a**) Schematic illustrating transcripts, discrete transcript features, the splice graph, and splice events consisting of alternative splice variants. Splice events are defined in an augmented graph with a unique source and sink node for each gene, connected to alternative starts and ends, respectively (dashed lines). (**b**) *SGSeq* representation of concepts shown in (a). Classes are shown in bold and outlined, function names are shown in italics. Dashed arrows indicate functions *analyzeFeatures()* and *analyzeVariants()*, which wrap multiple analysis steps. *SGSeq* makes extensive use of *Bioconductor* infrastructure for genomic ranges (Lawrence et al. [2013](#ref-Lawrence:2013hi)): *TxFeatures* and *SGFeatures* extend *GRanges*, *SGVariants* extends *CompressedGRangesList*. *SGFeatureCounts* and *SGVariantCounts* extend *SummarizedExperiment* and are containers for per-sample counts (or other expression values) along with corresponding *SGFeatures* and *SGVariants* objects. \(^\ast\)*SGVariantCounts* assay *countsVariant5pOr3p* can only be obtained from BAM files, for details see section [Testing for differential splice variant usage](#testing-for-differential-splice-variant-usage).

# 2 Preliminaries

```
library(SGSeq)
```

When starting a new project, *SGSeq* requires information about the samples to be analyzed. This information is obtained once initially, and can then be used for all future analyses. Sample information is provided as a data frame with the following columns:

* *sample\_name* Character vector with a unique name for each sample
* *file\_bam* Character vector or *BamFileList* specifying BAM files generated with a splice-aware alignment program
* *paired\_end* Logical vector indicating whether data are paired-end or single-end
* *read\_length* Numeric vector with read lengths
* *frag\_length* Numeric vector with average fragment lengths (for paired-end data)
* *lib\_size* Numeric vector with the total number of aligned reads for single-end data, or the total number of read pairs for paired-end data

Sample information can be stored in a *data.frame* or *DataFrame* object (if BAM files are specified as a *BamFileList*, it must be stored in a *DataFrame*). Sample information can be obtained automatically with function *getBamInfo()*, which takes as input a data frame with columns *sample\_name* and *file\_bam* and extracts all other information from the specified BAM files.

For *SGSeq* to work correctly it is essential that reads were mapped with a splice-aware alignment program, such as GSNAP (Wu and Nacu [2010](#ref-Wu:2010ep)), HISAT (Kim, Langmead, and Salzberg [2015](#ref-Kim:2015be)) or STAR (Dobin et al. [2013](#ref-Dobin:2013fg)), which generates SAM/BAM files with a custom tag ‘XS’ for spliced reads, indicating the direction of transcription. BAM files must be indexed. Note that *lib\_size* should be the total number of aligned fragments, even if BAM files were subset to genomic regions of interest. The total number of fragments is required for accurate calculation of FPKM values (fragments per kilobase and million sequenced fragments). Here, the term ‘fragment’ denotes a sequenced cDNA fragment, which is represented by a single read in single-end data, or a pair of reads in paired-end data.

This vignette illustrates an analysis of paired-end RNA-seq data from four tumor and four normal colorectal samples, which are part of a data set published in (Seshagiri et al. [2012](#ref-Seshagiri:2012gr)). RNA-seq reads were mapped to the human reference genome using GSNAP (Wu and Nacu [2010](#ref-Wu:2010ep)). The analysis is based on BAM files that were subset to reads mapping to a single gene of interest (*FBXO31*). A *data.frame* *si* with sample information was generated from the original BAM files with function *getBamInfo()*. Note that column *lib\_size* reflects the total number of aligned fragments in the original BAM files.

```
si
```

```
##   sample_name file_bam paired_end read_length frag_length lib_size
## 1          N1   N1.bam       TRUE          75         293 12405197
## 2          N2   N2.bam       TRUE          75         197 13090179
## 3          N3   N3.bam       TRUE          75         206 14983084
## 4          N4   N4.bam       TRUE          75         207 15794088
## 5          T1   T1.bam       TRUE          75         284 14345976
## 6          T2   T2.bam       TRUE          75         235 15464168
## 7          T3   T3.bam       TRUE          75         259 15485954
## 8          T4   T4.bam       TRUE          75         247 15808356
```

The following code block sets the correct BAM file paths for the current *SGSeq* installation.

```
path <- system.file("extdata", package = "SGSeq")
si$file_bam <- file.path(path, "bams", si$file_bam)
```

# 3 RNA transcripts and the *TxFeatures* class

Transcript annotation can be obtained from a *TxDb* object or imported from GFF format using function *importTranscripts()*. Alternatively, transcripts can be specified as a *GRangesList* of exons grouped by transcripts. In the following code block, the UCSC knownGene table is loaded as a *TxDb* object. Transcripts on chromosome 16 (where the *FBXO31* gene is located) are retained, and chromosome names are changed to match the naming convention used in the BAM files.

```
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(GenomeInfoDb)  # for keepSeqlevels() and seqlevelsStyle()
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
txdb <- keepSeqlevels(txdb, "chr16")
seqlevelsStyle(txdb) <- "NCBI"
```

To work with the annotation in the *SGSeq* framework, transcript features are extracted from the *TxDb* object using function *convertToTxFeatures()*. Only features overlapping the genomic locus of the *FBXO31* gene are retained. The genomic coordinates of *FBXO31* are stored in a *GRanges* object *gr*.

```
txf_ucsc <- convertToTxFeatures(txdb)
txf_ucsc <- txf_ucsc[txf_ucsc %over% gr]
head(txf_ucsc)
```

```
## TxFeatures object with 6 ranges and 0 metadata columns:
##       seqnames            ranges strand     type
##          <Rle>         <IRanges>  <Rle> <factor>
##   [1]       16 87349429-87367492      -        J
##   [2]       16 87360593-87365116      -        L
##   [3]       16 87362942-87365116      -        L
##   [4]       16 87364417-87365116      -        L
##   [5]       16 87365116-87367492      -        J
##   [6]       16 87367492-87367727      -        I
##                                                                  txName
##                                                         <CharacterList>
##   [1]                                               ENST00000568879.1_7
##   [2]                         ENST00000636077.2_8,ENST00000311635.12_10
##   [3]                                               ENST00000565593.1_4
##   [4]                                               ENST00000618298.6_5
##   [5] ENST00000636077.2_8,ENST00000311635.12_10,ENST00000565593.1_4,...
##   [6]                                               ENST00000565593.1_4
##              geneName
##       <CharacterList>
##   [1]       100506581
##   [2]           79791
##   [3]           79791
##   [4]           79791
##   [5]           79791
##   [6]           79791
##   -------
##   seqinfo: 1 sequence from GRCh37.p13 genome
```

*convertToTxFeatures()* returns a *TxFeatures* object, which is a *GRanges*-like object with additional columns. Column *type* indicates the feature type and can take values

* *J* (splice junction)
* *I* (internal exon)
* *F* (first/5\(^\prime\)-terminal exon)
* *L* (last/5\(^\prime\)-terminal exon)
* *U* (unspliced transcript).

Columns *txName* and *geneName* indicate the transcript and gene each feature belongs to. Note that a feature can belong to more than one transcript, and accordingly these columns can store multiple values for each feature. For *TxFeatures* and other data structures in *SGSeq*, columns can be accessed with accessor functions as shown in the following code block.

```
type(txf_ucsc)
```

```
##  [1] J L L L J I F I J J I J I J I J I L J I J J I J I J J J F L L J J F F F F L
## [39] J I J I F J F F
## Levels: J I F L U
```

```
head(txName(txf_ucsc))
```

```
## CharacterList of length 6
## [[1]] ENST00000568879.1_7
## [[2]] ENST00000636077.2_8 ENST00000311635.12_10
## [[3]] ENST00000565593.1_4
## [[4]] ENST00000618298.6_5
## [[5]] ENST00000636077.2_8 ENST00000311635.12_10 ENST00000565593.1_4 ENST00000618298.6_5
## [[6]] ENST00000565593.1_4
```

```
head(geneName(txf_ucsc))
```

```
## CharacterList of length 6
## [[1]] 100506581
## [[2]] 79791
## [[3]] 79791
## [[4]] 79791
## [[5]] 79791
## [[6]] 79791
```

# 4 The splice graph and the *SGFeatures* class

Exons stored in a *TxFeatures* object represent the exons spliced together in an RNA molecule. In the context of the splice graph, exons are represented by unique non-overlapping exonic regions. Function *convertToSGFeatures()* converts *TxFeatures* to *SGFeatures*. In the process, overlapping exons are disjoined into non-overlapping exon bins.

```
sgf_ucsc <- convertToSGFeatures(txf_ucsc)
head(sgf_ucsc)
```

```
## SGFeatures object with 6 ranges and 0 metadata columns:
##       seqnames            ranges strand     type  splice5p  splice3p featureID
##          <Rle>         <IRanges>  <Rle> <factor> <logical> <logical> <integer>
##   [1]       16          87349429      -        A      <NA>      <NA>         1
##   [2]       16 87349429-87367492      -        J      <NA>      <NA>         2
##   [3]       16 87360593-87365116      -        E      TRUE     FALSE         3
##   [4]       16          87365116      -        A      <NA>      <NA>         4
##   [5]       16 87365116-87367492      -        J      <NA>      <NA>         5
##   [6]       16          87367492      -        D      <NA>      <NA>         6
##          geneID
##       <integer>
##   [1]         1
##   [2]         1
##   [3]         1
##   [4]         1
##   [5]         1
##   [6]         1
##                                                                  txName
##                                                         <CharacterList>
##   [1]                                               ENST00000568879.1_7
##   [2]                                               ENST00000568879.1_7
##   [3] ENST00000636077.2_8,ENST00000311635.12_10,ENST00000565593.1_4,...
##   [4] ENST00000636077.2_8,ENST00000311635.12_10,ENST00000565593.1_4,...
##   [5] ENST00000636077.2_8,ENST00000311635.12_10,ENST00000565593.1_4,...
##   [6] ENST00000568879.1_7,ENST00000636077.2_8,ENST00000311635.12_10,...
##              geneName
##       <CharacterList>
##   [1]       100506581
##   [2]       100506581
##   [3]           79791
##   [4]           79791
##   [5]           79791
##   [6] 100506581,79791
##   -------
##   seqinfo: 1 sequence from GRCh37.p13 genome
```

Similar to *TxFeatures*, *SGFeatures* are *GRanges*-like objects with additional columns. Column *type* for an *SGFeatures* object takes values

* *J* (splice junction)
* *E* (disjoint exon bin)
* *D* (splice donor site)
* *A* (splice acceptor site).

By convention, splice donor and acceptor sites correspond to the exonic positions immediately flanking the intron. *SGFeatures* has additional columns not included in *TxFeatures*: *spliced5p* and *spliced3p* indicate whether exon bins have a mandatory splice at the 5\(^\prime\) and 3\(^\prime\) end, respectively. This information is used to determine whether a read is structurally compatible with an exon bin, and whether an exon bin is consistent with an annotated transcript. *featureID* provides a unique identifier for each feature, *geneID* indicates the unique component of the splice graph a feature belongs to.

# 5 Splice graph analysis based on annotated transcripts

This section illustrates an analysis based on annotated transcripts. Function *analyzeFeatures()* converts transcript features to splice graph features and obtains compatible fragment counts for each feature and each sample.

```
sgfc_ucsc <- analyzeFeatures(si, features = txf_ucsc)
sgfc_ucsc
```

```
## class: SGFeatureCounts
## dim: 67 8
## metadata(0):
## assays(2): counts FPKM
## rownames: NULL
## rowData names(0):
## colnames(8): N1 N2 ... T3 T4
## colData names(6): sample_name file_bam ... frag_length lib_size
```

*analyzeFeatures()* returns an *SGFeatureCounts* object. *SGFeatureCounts* contains the sample information as *colData*, splice graph features as *rowRanges* and assays *counts* and *FPKM*, which store compatible fragment counts and FPKMs, respectively. The different data types can be accessed using accessor functions with the same name.

```
colData(sgfc_ucsc)
rowRanges(sgfc_ucsc)
head(counts(sgfc_ucsc))
head(FPKM(sgfc_ucsc))
```

Counts for exons and splice junctions are based on structurally compatible fragments. In the case of splice donors and acceptors, counts indicate the number of fragments with reads spanning the spliced boundary (overlapping the splice site and the flanking intronic position).

FPKM values are calculated as \(\frac{x}{NL}10^6\), where \(x\) is the number of compatible fragments, \(N\) is the library size (stored in *lib\_size*) and *L* is the effective feature length (the number of possible positions for a compatible fragment). For paired-end data it is assumed that fragment length is equal to *frag\_length*.

FPKMs for splice graph features can be visualized with function *plotFeatures*. *plotFeatures* generates a two-panel figure with a splice graph shown in the top panel and a heatmap of expression levels for individual features in the bottom panel. For customization of *plotFeatures* output, see section [Visualization](#visualization). The plotting function invisibly returns a *data.frame* with details about the splice graph shown in the plot.

```
df <- plotFeatures(sgfc_ucsc, geneID = 1)
```

![](data:image/png;base64...)

Note that the splice graph includes three alternative transcript start sites (TSSs). However, the heatmap indicates that the first TSS is not used in this data set.

# 6 Splice graph analysis based on *de novo* prediction

Instead of relying on existing annotation, annotation can be augmented with predictions from RNA-seq data, or the splice graph can be constructed from RNA-seq data without the use of annotation. The following code block predicts transcript features supported by RNA-seq reads, converts them into splice graph features, and then obtains compatible fragment counts. For details on how predictions are obtained, please see (Goldstein et al. [2016](#ref-Goldstein:2016hc)).

```
sgfc_pred <- analyzeFeatures(si, which = gr)
head(rowRanges(sgfc_pred))
```

```
## SGFeatures object with 6 ranges and 0 metadata columns:
##       seqnames            ranges strand     type  splice5p  splice3p featureID
##          <Rle>         <IRanges>  <Rle> <factor> <logical> <logical> <integer>
##   [1]       16 87362930-87365116      -        E      TRUE     FALSE         1
##   [2]       16          87365116      -        A      <NA>      <NA>         2
##   [3]       16 87365116-87367492      -        J      <NA>      <NA>         3
##   [4]       16          87367492      -        D      <NA>      <NA>         4
##   [5]       16 87367492-87367892      -        E      TRUE      TRUE         5
##   [6]       16          87367892      -        A      <NA>      <NA>         6
##          geneID          txName        geneName
##       <integer> <CharacterList> <CharacterList>
##   [1]         1
##   [2]         1
##   [3]         1
##   [4]         1
##   [5]         1
##   [6]         1
##   -------
##   seqinfo: 84 sequences from an unspecified genome
```

For interpretation, predicted features can be annotated with respect to known transcripts. The *annotate()* function assigns compatible transcripts to each feature and stores the corresponding transcript and gene name in columns *txName* and *geneName*, respectively.

```
sgfc_pred <- annotate(sgfc_pred, txf_ucsc)
head(rowRanges(sgfc_pred))
```

```
## SGFeatures object with 6 ranges and 0 metadata columns:
##       seqnames            ranges strand     type  splice5p  splice3p featureID
##          <Rle>         <IRanges>  <Rle> <factor> <logical> <logical> <integer>
##   [1]       16 87362930-87365116      -        E      TRUE     FALSE         1
##   [2]       16          87365116      -        A      <NA>      <NA>         2
##   [3]       16 87365116-87367492      -        J      <NA>      <NA>         3
##   [4]       16          87367492      -        D      <NA>      <NA>         4
##   [5]       16 87367492-87367892      -        E      TRUE      TRUE         5
##   [6]       16          87367892      -        A      <NA>      <NA>         6
##          geneID
##       <integer>
##   [1]         1
##   [2]         1
##   [3]         1
##   [4]         1
##   [5]         1
##   [6]         1
##                                                                  txName
##                                                         <CharacterList>
##   [1] ENST00000636077.2_8,ENST00000311635.12_10,ENST00000565593.1_4,...
##   [2] ENST00000636077.2_8,ENST00000311635.12_10,ENST00000565593.1_4,...
##   [3] ENST00000636077.2_8,ENST00000311635.12_10,ENST00000565593.1_4,...
##   [4] ENST00000568879.1_7,ENST00000636077.2_8,ENST00000311635.12_10,...
##   [5]     ENST00000636077.2_8,ENST00000311635.12_10,ENST00000618298.6_5
##   [6]     ENST00000636077.2_8,ENST00000311635.12_10,ENST00000618298.6_5
##              geneName
##       <CharacterList>
##   [1]           79791
##   [2]           79791
##   [3]           79791
##   [4] 100506581,79791
##   [5]           79791
##   [6]           79791
##   -------
##   seqinfo: 84 sequences from an unspecified genome
```

The predicted splice graph and FPKMs can be visualized as previously. Splice graph features with missing annotation are highlighted using argument *color\_novel*.

```
df <- plotFeatures(sgfc_pred, geneID = 1, color_novel = "red")
```

![](data:image/png;base64...)

Note that most exons and splice junctions predicted from RNA-seq data are consistent with transcripts in the UCSC knownGene table (shown in gray). However, in contrast to the previous figure, the predicted gene model does not include parts of the splice graph that are not expressed in the data. Also, an unannotated exon (E3, shown in red) was discovered from the RNA-seq data, which is expressed in three of the four normal colorectal samples (N2, N3, N4).

# 7 Splice variant identification

Instead of considering the full splice graph of a gene, the analysis can be focused on individual splice events. Function *analyzeVariants()* recursively identifies splice events from the graph, obtains representative counts for each splice variant, and computes estimates of relative splice variant usage, also referred to as ‘percentage spliced in’ (PSI or \(\Psi\)) (Venables et al. [2008](#ref-Venables:2008aa), @Katz:2010aa).

```
sgvc_pred <- analyzeVariants(sgfc_pred)
sgvc_pred
```

```
## class: SGVariantCounts
## dim: 2 8
## metadata(0):
## assays(5): countsVariant5p countsVariant3p countsEvent5p countsEvent3p
##   variantFreq
## rownames: NULL
## rowData names(20): from to ... variantType variantName
## colnames(8): N1 N2 ... T3 T4
## colData names(6): sample_name file_bam ... frag_length lib_size
```

*analyzeVariants()* returns an *SGVariantCounts* object. Sample information is stored as *colData*, and *SGVariants* as *rowRanges*. Assay *variantFreq* stores estimates of relative usage for each splice variant and sample. As previously, the different data types can be accessed using accessor functions. Information on splice variants is stored in *SGVariants* metadata columns and can be accessed with function *mcols()* as shown below. For a detailed description of columns, see the manual page for *SGVariants*.

```
mcols(sgvc_pred)
```

```
## DataFrame with 2 rows and 20 columns
##              from              to        type   featureID   segmentID  closed5p
##       <character>     <character> <character> <character> <character> <logical>
## 1 D:16:87393901:- A:16:87380856:-           J          28           4      TRUE
## 2 D:16:87393901:- A:16:87380856:-         JEJ    32,30,27           2      TRUE
##    closed3p closed5pEvent closed3pEvent    geneID   eventID variantID
##   <logical>     <logical>     <logical> <integer> <integer> <integer>
## 1      TRUE          TRUE          TRUE         1         1         1
## 2      TRUE          TRUE          TRUE         1         1         2
##     featureID5p   featureID3p featureID5pEvent featureID3pEvent
##   <IntegerList> <IntegerList>    <IntegerList>    <IntegerList>
## 1            28            28            28,32            28,27
## 2            32            27            28,32            28,27
##                                                          txName        geneName
##                                                 <CharacterList> <CharacterList>
## 1 ENST00000311635.12_10,ENST00000618298.6_5,ENST00000561664.1_3           79791
## 2                                           ENST00000636077.2_8           79791
##       variantType    variantName
##   <CharacterList>    <character>
## 1            SE:S 79791_1_1/2_SE
## 2            SE:I 79791_1_2/2_SE
```

# 8 Splice variant quantification

Splice variants are quantified locally, based on structurally compatible fragments that extend across the start or end of each variant. Local estimates of relative usage \(\Psi\_i\) for variant \(i\) are obtained as the number of fragments compatible with \(i\) divided by the number of fragments compatible with any variant belonging to the same event. For variant start \(S\) and variant end \(E\), \(\hat{\Psi}\_i^S = x\_i^S / x\_.^S\) and \(\hat{\Psi}\_i^E = x\_i^E / x\_.^E\), respectively. For variants with valid estimates \(\hat{\Psi}\_i^S\) and \(\hat{\Psi}\_i^E\), a single estimate is calculated as a weighted mean of local estimates \(\hat{\Psi}\_i = x\_.^S/(x\_.^S + x\_.^E) \hat{\Psi}\_i^S + x\_.^E/(x\_.^S + x\_.^E) \hat{\Psi}\_i^E\).

Estimates of relative usage can be unreliable for events with low read count. If argument *min\_denominator* is specified for functions *analyzeVariants()* or *getSGVariantCounts()*, estimates are set to *NA* unless at least one of \(x\_.^S\) or \(x\_.^E\) is equal or greater to the specified value.

Note that *SGVariantCounts* objects also store the raw count data. Count data can be used for statistical modeling, for example as suggested in section [Testing for differential splice variant usage](#testing-for-differential-splice-variant-usage).

```
variantFreq(sgvc_pred)
```

```
##        N1   N2        N3        N4         T1         T2        T3         T4
## [1,] 0.88 0.56 0.6153846 0.5925926 0.93333333 0.90196078 0.8484848 0.95833333
## [2,] 0.12 0.44 0.3846154 0.4074074 0.06666667 0.09803922 0.1515152 0.04166667
```

Splice variants and estimates of relative usage can be visualized with function *plotVariants*.

```
plotVariants(sgvc_pred, eventID = 1, color_novel = "red")
```

```
## updateObject(object="ANY") default for object of class 'matrix'
```

```
## [updateObject] Validating the updated object ... OK
## updateObject(object="ANY") default for object of class 'matrix'
## [updateObject] Validating the updated object ... OK
## updateObject(object="ANY") default for object of class 'matrix'
## [updateObject] Validating the updated object ... OK
## updateObject(object="ANY") default for object of class 'matrix'
## [updateObject] Validating the updated object ... OK
## updateObject(object="ANY") default for object of class 'matrix'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] DFrame object is current.
## [updateObject] Nothing to update.
## updateObject(object="ANY") default for object of class 'NULL'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] DFrame object is current.
## [updateObject] Nothing to update.
## updateObject(object="ANY") default for object of class 'NULL'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] SGVariants object is current.
## [updateObject] Nothing to update.
## [updateObject] Internal representation of SGFeatures object is current.
## [updateObject] Nothing to update.
## [updateObject] Internal representation of IRanges object is current.
## [updateObject] Nothing to update.
## updateObject(object="ANY") default for object of class 'NULL'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] DFrame object is current.
## [updateObject] Nothing to update.
## updateObject(object="ANY") default for object of class 'NULL'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] Internal representation of SGFeatures object is current.
## [updateObject] Nothing to update.
## [updateObject] Internal representation of IRanges object is current.
## [updateObject] Nothing to update.
## updateObject(object="ANY") default for object of class 'NULL'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] DFrame object is current.
## [updateObject] Nothing to update.
## updateObject(object="ANY") default for object of class 'NULL'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] Internal representation of PartitioningByEnd object is current.
## [updateObject] Nothing to update.
## updateObject(object="ANY") default for object of class 'NULL'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] DFrame object is current.
## [updateObject] Nothing to update.
## updateObject(object="ANY") default for object of class 'NULL'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] SGVariants object is current.
## [updateObject] Nothing to update.
## [updateObject] Internal representation of SGFeatures object is current.
## [updateObject] Nothing to update.
## [updateObject] Internal representation of IRanges object is current.
## [updateObject] Nothing to update.
## updateObject(object="ANY") default for object of class 'NULL'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] DFrame object is current.
## [updateObject] Nothing to update.
## updateObject(object="ANY") default for object of class 'NULL'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] Internal representation of SGFeatures object is current.
## [updateObject] Nothing to update.
## [updateObject] Internal representation of IRanges object is current.
## [updateObject] Nothing to update.
## updateObject(object="ANY") default for object of class 'NULL'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] DFrame object is current.
## [updateObject] Nothing to update.
## updateObject(object="ANY") default for object of class 'NULL'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] Internal representation of PartitioningByEnd object is current.
## [updateObject] Nothing to update.
## updateObject(object="ANY") default for object of class 'NULL'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] DFrame object is current.
## [updateObject] Nothing to update.
## updateObject(object="ANY") default for object of class 'NULL'
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
## [updateObject] Validating the updated object ... OK
```

![](data:image/png;base64...)

*plotVariants* generates a two-panel figure similar to *plotFeatures*. The splice graph in the top panel illustrates the selected splice event. In this example, the event consists of two variants, corresponding to a skip or inclusion of the unannotated exon. The heatmap illustrates estimates of relative usage for each splice variant. Samples N2, N3 and N4 show evidence for transcripts that include the exon as well as transcripts that skip the exon. The remaining samples show little evidence for exon inclusion.

# 9 Splice variant interpretation

The functional consequences of a splice variant can be assessed by predicting its effect on protein-coding potential. Function *predictVariantEffects()* takes as input an *SGVariants* object with splice variants of interest, a set of annotated transcripts, and a matching reference genome provided as a *BSgenome* object.

```
library(BSgenome.Hsapiens.UCSC.hg19)
seqlevelsStyle(Hsapiens) <- "NCBI"
```

```
## Warning in (function (seqlevels, genome, new_style) : cannot switch some hg19's
## seqlevels from UCSC to NCBI style
```

```
vep <- predictVariantEffects(sgv_pred, txdb, Hsapiens)
vep
```

```
##   variantID                txName geneName                        RNA_change
## 1         1   ENST00000636077.2_8    79791                      r.413_499del
## 2         2 ENST00000311635.12_10    79791     r.412_413ins412+1798_412+1884
## 3         2   ENST00000618298.6_5    79791 r.-105_-104ins-105+1798_-105+1884
##   RNA_variant_type                              protein_change
## 1         deletion                              p.R138_C166del
## 2        insertion p.K137_L138insRINPRVKSGRFVKILPDYEHMAYRDVYTC
## 3        insertion                                         p.=
##   protein_variant_type
## 1    in-frame_deletion
## 2   in-frame_insertion
## 3            no_change
```

The output is a data frame with each row describing the effect of a particular splice variant on an annotated protein-coding transcript. The effect of the variants is described following [HGVS recommendations](http://varnomen.hgvs.org). In its current implementation, variant effect prediction is relatively slow and it is recommended to run *predictVariantEffects()* on select variants only.

# 10 Visualization

Functions *plotFeatures()* and *plotVariants()* support many options for customizing figures. The splice graph in the top panel is plotted by function *plotSpliceGraph*, which can be called directly.

*plotFeatures()* includes multiple arguments for selecting features to be displayed. The following code block illustrates three different options for plotting the splice graph and expression levels for *FBXO31* (Entrez ID 79791).

```
plotFeatures(sgfc_pred, geneID = 1)
plotFeatures(sgfc_pred, geneName = "79791")
plotFeatures(sgfc_pred, which = gr)
```

By default, the heatmap generated by *plotFeatures()* displays splice junctions. Alternatively, exon bins, or both exon bins and splice junctions can be displayed.

```
plotFeatures(sgfc_pred, geneID = 1, include = "junctions")
plotFeatures(sgfc_pred, geneID = 1, include = "exons")
plotFeatures(sgfc_pred, geneID = 1, include = "both")
```

Argument *toscale* controls which parts of the gene model are drawn to scale.

```
plotFeatures(sgfc_pred, geneID = 1, toscale = "gene")
plotFeatures(sgfc_pred, geneID = 1, toscale = "exon")
plotFeatures(sgfc_pred, geneID = 1, toscale = "none")
```

Heatmaps allow the visualization of expression values summarized for splice junctions and exon bins. Alternatively, per-base read coverages and splice junction counts can be visualized with function *plotCoverage*.

```
par(mfrow = c(5, 1), mar = c(1, 3, 1, 1))
plotSpliceGraph(rowRanges(sgfc_pred), geneID = 1, toscale = "none", color_novel = "red")
for (j in 1:4) {
  plotCoverage(sgfc_pred[, j], geneID = 1, toscale = "none")
}
```

![](data:image/png;base64...)

# 11 Testing for differential splice variant usage

*SGSeq* does not implement statistical tests for differential splice variant usage. However, existing software packages such as *[DEXSeq](https://bioconductor.org/packages/3.22/DEXSeq)* (Anders, Reyes, and Huber [2012](#ref-Anders:2012es)) and *[limma](https://bioconductor.org/packages/3.22/limma)* (Ritchie et al. [2015](#ref-Ritchie:2015fa)) can be used for this purpose. These packages allow infererence of differential exon usage within a gene (between groups of samples). In the *SGSeq* framework, this approach can be used to test for differential splice variant usage within a splice event, treating splice variants and splice events as exons and genes, respectively.

For these methods to be applicable, a single count is required for each splice variant. *SGVariantCounts* objects as described above store two counts for each splice variant, one for the 5\(^\prime\) and one for the 3\(^\prime\) end of the variant. These counts can be readily obtained from *SGFeatureCounts* objects, but are impractical for count-based differential testing. A single count for each variant (based on fragments compatible at either end of the variant) can be obtained from BAM files using function *getSGVariantCounts()*. The output is an *SGVariantCounts* object with additional assay *countsVariant5pOr3p*.

```
sgv <- rowRanges(sgvc_pred)
sgvc <- getSGVariantCounts(sgv, sample_info = si)
sgvc
```

```
## class: SGVariantCounts
## dim: 2 8
## metadata(0):
## assays(6): countsVariant5p countsVariant3p ... countsVariant5pOr3p
##   variantFreq
## rownames: NULL
## rowData names(20): from to ... variantType variantName
## colnames(8): N1 N2 ... T3 T4
## colData names(6): sample_name file_bam ... frag_length lib_size
```

Performing differential tests requires per-variant counts, unique identifiers for each variant, and a variable indicating how variants are grouped by events. All three can be obtained from the *SGVariantCounts* object.

```
x <- counts(sgvc)
vid <- variantID(sgvc)
eid <- eventID(sgvc)
```

Treating these three objects analogously to per-exon counts, exon identifiers and gene identifiers, they can be used to construct a *DEXSeqDataSet* object for use with *[DEXSeq](https://bioconductor.org/packages/3.22/DEXSeq)* or as input for function *diffSplice()* in combination with *voom()* for use with *[limma](https://bioconductor.org/packages/3.22/limma)*.

# 12 Advanced usage

Functions *analyzeFeatures()* and *analyzeVariants()* wrap multiple analysis steps for convenience. Alternatively, the functions performing individual steps can be called directly. For example, the analysis based on *de novo* prediction can be performed as follows.

```
txf <- predictTxFeatures(si, gr)
sgf <- convertToSGFeatures(txf)
sgf <- annotate(sgf, txf_ucsc)
sgfc <- getSGFeatureCounts(si, sgf)
sgv <- findSGVariants(sgf)
sgvc <- getSGVariantCounts(sgv, sgfc)
```

*predictTxFeatures()* predicts features for each sample, merges features across samples, and performs filtering and processing of predicted terminal exons. *predictTxFeatures()* and *getSGFeatureCounts()* can also be run on individual samples (e.g. for distribution across a high-performance computing cluster). When using *predictTxFeatures()* for individual samples, with predictions intended to be merged later, run *predictTxFeatures()* with argument *min\_overhang = NULL* to suppress processing of terminal exons. Then predictions can subsequently be merged and processed with functions *mergeTxFeatures()* and *processTerminalExons()*, respectively.

# 13 Multi-core use and memory requirements

*SGSeq* supports parallelization across multiple cores on the same compute node. For functions that support parallelization, the number of cores can be specified with the *cores* argument. For most genome-wide analyses, memory requirements should not exceed 16 Gb per core. Memory issues encountered during feature prediction or read counting are likely due to individual genomic regions with high read coverage. By default, regions with high split-read complexity are skipped during prediction (controlled with argument *max\_complexity*). For the counting step, memory issues may be resolved by excluding problematic regions (e.g. mitochondrial genes).

# 14 Session information

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
##  [1] BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [2] BSgenome_1.78.0
##  [3] rtracklayer_1.70.0
##  [4] BiocIO_1.20.0
##  [5] GenomeInfoDb_1.46.0
##  [6] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
##  [7] GenomicFeatures_1.62.0
##  [8] AnnotationDbi_1.72.0
##  [9] SGSeq_1.44.0
## [10] SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0
## [12] MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0
## [14] Rsamtools_2.26.0
## [15] Biostrings_2.78.0
## [16] XVector_0.50.0
## [17] GenomicRanges_1.62.0
## [18] Seqinfo_1.0.0
## [19] IRanges_2.44.0
## [20] S4Vectors_0.48.0
## [21] BiocGenerics_0.56.0
## [22] generics_0.1.4
## [23] knitr_1.50
## [24] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0          rjson_0.2.23             xfun_0.53
##  [4] bslib_0.9.0              lattice_0.22-7           vctrs_0.6.5
##  [7] tools_4.5.1              bitops_1.0-9             RUnit_0.4.33.1
## [10] curl_7.0.0               parallel_4.5.1           RSQLite_2.4.3
## [13] blob_1.2.4               pkgconfig_2.0.3          Matrix_1.7-4
## [16] cigarillo_1.0.0          lifecycle_1.0.4          compiler_4.5.1
## [19] tinytex_0.57             codetools_0.2-20         htmltools_0.5.8.1
## [22] sass_0.4.10              RCurl_1.98-1.17          yaml_2.3.10
## [25] crayon_1.5.3             jquerylib_0.1.4          BiocParallel_1.44.0
## [28] DelayedArray_0.36.0      cachem_1.1.0             magick_2.9.0
## [31] abind_1.4-8              digest_0.6.37            restfulr_0.0.16
## [34] bookdown_0.45            fastmap_1.2.0            grid_4.5.1
## [37] cli_3.6.5                SparseArray_1.10.0       magrittr_2.0.4
## [40] S4Arrays_1.10.0          XML_3.99-0.19            UCSC.utils_1.6.0
## [43] bit64_4.6.0-1            rmarkdown_2.30           httr_1.4.7
## [46] igraph_2.2.1             bit_4.6.0                png_0.1-8
## [49] memoise_2.0.1            evaluate_1.0.5           rlang_1.1.6
## [52] Rcpp_1.1.0               glue_1.8.0               DBI_1.2.3
## [55] BiocManager_1.30.26      jsonlite_2.0.0           R6_2.6.1
## [58] GenomicAlignments_1.46.0
```

# References

Anders, S, A Reyes, and W Huber. 2012. “Detecting differential usage of exons from RNA-seq data.” *Genome Research* 22 (10): 2008–17.

Dobin, Alexander, Carrie A Davis, Felix Schlesinger, Jorg Drenkow, Chris Zaleski, Sonali Jha, Philippe Batut, Mark Chaisson, and Thomas R Gingeras. 2013. “STAR: ultrafast universal RNA-seq aligner.” *Bioinformatics* 29 (1): 15–21.

Goldstein, Leonard D, Yi Cao, Gregoire Pau, Michael Lawrence, Thomas D Wu, Somasekar Seshagiri, and Robert Gentleman. 2016. “Prediction and Quantification of Splice Events from RNA-Seq Data.” *PLoS ONE* 11 (5): e0156132.

Heber, Steffen, Max Alekseyev, Sing-Hoi Sze, Haixu Tang, and Pavel A Pevzner. 2002. “Splicing graphs and EST assembly problem.” *Bioinformatics (Oxford, England)* 18 Suppl 1: S181–8.

Katz, Yarden, Eric T Wang, Edoardo M Airoldi, and Christopher B Burge. 2010. “Analysis and design of RNA sequencing experiments for identifying isoform regulation.” *Nature Methods* 7 (12): 1009–15.

Kim, Daehwan, Ben Langmead, and Steven L Salzberg. 2015. “HISAT: a fast spliced aligner with low memory requirements.” *Nature Methods* 12 (4): 357–60.

Lawrence, Michael, Wolfgang Huber, Hervé Pagès, Patrick Aboyoun, Marc Carlson, Robert Gentleman, Martin T Morgan, and Vincent J Carey. 2013. “Software for Computing and Annotating Genomic Ranges.” *PLoS Computational Biology* 9 (8): e1003118.

Ritchie, Matthew E, Belinda Phipson, Di Wu, Yifang Hu, Charity W Law, Wei Shi, and Gordon K Smyth. 2015. “limma powers differential expression analyses for RNA-sequencing and microarray studies.” *Nucleic Acids Research* 43 (7): e47.

Seshagiri, Somasekar, Eric W Stawiski, Steffen Durinck, Zora Modrusan, Elaine E Storm, Caitlin B Conboy, Subhra Chaudhuri, et al. 2012. “Recurrent R-spondin fusions in colon cancer.” *Nature* 488 (7413): 660–64.

Venables, Julian P, Roscoe Klinck, Anne Bramard, Lyna Inkel, Genevieve Dufresne-Martin, ChuShin Koh, Julien Gervais-Bird, et al. 2008. “Identification of alternative splicing markers for breast cancer.” *Cancer Research* 68 (22): 9525–31.

Wu, Thomas D, and Serban Nacu. 2010. “Fast and SNP-tolerant detection of complex variants and splicing in short reads.” *Bioinformatics* 26 (7): 873–81.