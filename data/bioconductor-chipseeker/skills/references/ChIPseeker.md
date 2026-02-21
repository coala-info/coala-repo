# ChIPseeker: an R package for ChIP peak Annotation, Comparison and Visualization

#### Guangchuang Yu School of Basic Medical Sciences, Southern Medical University

#### 2025-11-04

* [Abstract](#abstract)
* [Citation](#citation)
* [Introduction](#introduction)
* [ChIP profiling](#chip-profiling)
  + [ChIP peaks coverage plot](#chip-peaks-coverage-plot)
  + [Profile of ChIP peaks binding to TSS regions](#profile-of-chip-peaks-binding-to-tss-regions)
    - [Heatmap of ChIP binding to TSS regions](#heatmap-of-chip-binding-to-tss-regions)
    - [Average Profile of ChIP peaks binding to TSS region](#average-profile-of-chip-peaks-binding-to-tss-region)
  + [Profile of ChIP peaks binding to different regions](#profile-of-chip-peaks-binding-to-different-regions)
    - [Binning method for profile of ChIP peaks binding to TSS regions](#binning-method-for-profile-of-chip-peaks-binding-to-tss-regions)
    - [Profile of ChIP peaks binding to body regions](#profile-of-chip-peaks-binding-to-body-regions)
    - [Profile of ChIP peaks binding to TTS regions](#profile-of-chip-peaks-binding-to-tts-regions)
* [Peak Annotation](#peak-annotation)
  + [Visualize Genomic Annotation](#visualize-genomic-annotation)
  + [Visualize distribution of TF-binding loci relative to TSS](#visualize-distribution-of-tf-binding-loci-relative-to-tss)
* [Functional enrichment analysis](#functional-enrichment-analysis)
* [ChIP peak data set comparison](#chip-peak-data-set-comparison)
  + [Profile of several ChIP peak data binding to TSS region](#profile-of-several-chip-peak-data-binding-to-tss-region)
    - [Average profiles](#average-profiles)
    - [Peak heatmaps](#peak-heatmaps)
  + [Profile of several ChIP peak data binding to body region](#profile-of-several-chip-peak-data-binding-to-body-region)
  + [ChIP peak annotation comparision](#chip-peak-annotation-comparision)
  + [Functional profiles comparison](#functional-profiles-comparison)
  + [Overlap of peaks and annotated genes](#overlap-of-peaks-and-annotated-genes)
* [Statistical testing of ChIP seq overlap](#statistical-testing-of-chip-seq-overlap)
  + [Shuffle genome coordination](#shuffle-genome-coordination)
  + [Peak overlap enrichment analysis](#peak-overlap-enrichment-analysis)
* [Data Mining with ChIP seq data deposited in GEO](#data-mining-with-chip-seq-data-deposited-in-geo)
  + [GEO data collection](#geo-data-collection)
  + [Download GEO ChIP data sets](#download-geo-chip-data-sets)
  + [Overlap significant testing](#overlap-significant-testing)
* [Need helps?](#need-helps)
* [Session Information](#session-information)
* [References](#references)

# Abstract

ChIPseeker is an R package for annotating ChIP-seq data analysis. It supports annotating ChIP peaks and provides functions to visualize ChIP peaks coverage over chromosomes and profiles of peaks binding to TSS regions. Comparison of ChIP peak profiles and annotation are also supported. Moreover, it supports evaluating significant overlap among ChIP-seq datasets. Currently, ChIPseeker contains 17,000 bed file information from GEO database. These datasets can be downloaded and compare with user’s own data to explore significant overlap datasets for inferring co-regulation or transcription factor complex for further investigation.

# Citation

If you use [ChIPseeker](http://bioconductor.org/packages/ChIPseeker)(Yu, Wang, and He 2015) in published research, please cite:

* Q Wang#, M Li#, T Wu, L Zhan, L Li, M Chen, W Xie, Z Xie, E Hu, S Xu, **G Yu**\*. [Exploring epigenomic datasets by ChIPseeker](https://onlinelibrary.wiley.com/share/author/GYJGUBYCTRMYJFN2JFZZ?target=10.1002/cpz1.585). ***Current Protocols***, 2022, 2(10): e585.
* **G Yu**\*, LG Wang, QY He\*. [ChIPseeker: an R/Bioconductor package for ChIP peak annotation, comparision and visualization](http://bioinformatics.oxfordjournals.org/cgi/content/abstract/btv145). ***Bioinformatics***. 2015, 31(14):2382-2383.

# Introduction

Chromatin immunoprecipitation followed by high-throughput sequencing (ChIP-seq) has become standard technologies for genome wide identification of DNA-binding protein target sites. After read mappings and peak callings, the peak should be annotated to answer the biological questions. Annotation also create the possibility of integrating expression profile data to predict gene expression regulation. [ChIPseeker](http://bioconductor.org/packages/ChIPseeker)(Yu, Wang, and He 2015) was developed for annotating nearest genes and genomic features to peaks.

ChIP peak data set comparison is also very important. We can use it as an index to estimate how well biological replications are. Even more important is applying to infer cooperative regulation. If two ChIP seq data, obtained by two different binding proteins, overlap significantly, these two proteins may form a complex or have interaction in regulation chromosome remodelling or gene expression. [ChIPseeker](http://bioconductor.org/packages/ChIPseeker)(Yu, Wang, and He 2015) support statistical testing of significant overlap among ChIP seq data sets, and incorporate open access database GEO for users to compare their own dataset to those deposited in database. Protein interaction hypothesis can be generated by mining data deposited in database. Converting genome coordinations from one genome version to another is also supported, making this comparison available for different genome version and different species.

Several visualization functions are implemented to visualize the coverage of the ChIP seq data, peak annotation, average profile and heatmap of peaks binding to TSS region.

Functional enrichment analysis of the peaks can be performed by my Bioconductor packages [DOSE](http://bioconductor.org/packages/DOSE)(Yu et al. 2015), [ReactomePA](http://bioconductor.org/packages/ReactomePA)(Yu and He 2016), [clusterProfiler](http://bioconductor.org/packages/clusterProfiler)(Yu et al. 2012).

```
## loading packages
library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
library(clusterProfiler)
```

# ChIP profiling

The datasets *CBX6* and *CBX7* in this vignettes were downloaded from *GEO (GSE40740)*(Pemberton et al. 2014) while *ARmo\_0M*, *ARmo\_1nM* and *ARmo\_100nM* were downloaded from *GEO (GSE48308)*(Urbanucci et al. 2012) . [ChIPseeker](http://bioconductor.org/packages/ChIPseeker) provides `readPeakFile` to load the peak and store in `GRanges` object.

```
files <- getSampleFiles()
print(files)
```

```
## $ARmo_0M
## [1] "/tmp/RtmpfFjEGs/Rinst37108269af0069/ChIPseeker/extdata/GEO_sample_data/GSM1174480_ARmo_0M_peaks.bed.gz"
##
## $ARmo_1nM
## [1] "/tmp/RtmpfFjEGs/Rinst37108269af0069/ChIPseeker/extdata/GEO_sample_data/GSM1174481_ARmo_1nM_peaks.bed.gz"
##
## $ARmo_100nM
## [1] "/tmp/RtmpfFjEGs/Rinst37108269af0069/ChIPseeker/extdata/GEO_sample_data/GSM1174482_ARmo_100nM_peaks.bed.gz"
##
## $CBX6_BF
## [1] "/tmp/RtmpfFjEGs/Rinst37108269af0069/ChIPseeker/extdata/GEO_sample_data/GSM1295076_CBX6_BF_ChipSeq_mergedReps_peaks.bed.gz"
##
## $CBX7_BF
## [1] "/tmp/RtmpfFjEGs/Rinst37108269af0069/ChIPseeker/extdata/GEO_sample_data/GSM1295077_CBX7_BF_ChipSeq_mergedReps_peaks.bed.gz"
```

```
peak <- readPeakFile(files[[4]])
peak
```

```
## GRanges object with 1331 ranges and 2 metadata columns:
##          seqnames              ranges strand |             V4        V5
##             <Rle>           <IRanges>  <Rle> |    <character> <numeric>
##      [1]     chr1       815093-817883      * |    MACS_peak_1    295.76
##      [2]     chr1     1243288-1244338      * |    MACS_peak_2     63.19
##      [3]     chr1     2979977-2981228      * |    MACS_peak_3    100.16
##      [4]     chr1     3566182-3567876      * |    MACS_peak_4    558.89
##      [5]     chr1     3816546-3818111      * |    MACS_peak_5     57.57
##      ...      ...                 ...    ... .            ...       ...
##   [1327]     chrX 135244783-135245821      * | MACS_peak_1327     55.54
##   [1328]     chrX 139171964-139173506      * | MACS_peak_1328    270.19
##   [1329]     chrX 139583954-139586126      * | MACS_peak_1329    918.73
##   [1330]     chrX 139592002-139593238      * | MACS_peak_1330    210.88
##   [1331]     chrY   13845134-13845777      * | MACS_peak_1331     58.39
##   -------
##   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

## ChIP peaks coverage plot

After peak calling, we would like to know the peak locations over the whole genome, `covplot` function calculates the coverage of peak regions over chromosomes and generate a figure to visualize. [GRangesList](https://guangchuangyu.github.io/2016/02/covplot-supports-grangeslist) is also supported and can be used to compare coverage of multiple bed files.

```
covplot(peak, weightCol="V5")
```

![](data:image/png;base64...)

```
covplot(peak, weightCol="V5", chrs=c("chr17", "chr18"), xlim=c(4.5e7, 5e7))
```

![](data:image/png;base64...)

When `peak` is a `GRangsList` object, user can set the colors directly or by passing a palette to `fill_color`.

```
peaks = lapply(files[4:5], readPeakFile)
covplot(peaks, weightCol = "V5", fill_color = c("red","blue")) +
  theme(legend.position = "inside",
        legend.position.inside = c(0.8,0.2))
```

![](data:image/png;base64...)

## Profile of ChIP peaks binding to TSS regions

First of all, for calculating the profile of ChIP peaks binding to TSS regions, we should prepare the TSS regions, which are defined as the flanking sequence of the TSS sites. Then align the peaks that are mapping to these regions, and generate the tagMatrix.

```
## promoter <- getPromoters(TxDb=txdb, upstream=3000, downstream=3000)
## tagMatrix <- getTagMatrix(peak, windows=promoter)
##
## to speed up the compilation of this vignettes, we use a precalculated tagMatrix
data("tagMatrixList")
tagMatrix <- tagMatrixList[[4]]
```

In the above code, you should notice that tagMatrix is not restricted to TSS regions. The regions can be other types that defined by the user. [ChIPseeker](http://bioconductor.org/packages/ChIPseeker) expanded the scope of region. Users can input the `type` and `by` parameters to get the regions they want.

### Heatmap of ChIP binding to TSS regions

```
tagHeatmap(tagMatrix)
```

![Heatmap of ChIP peaks binding to TSS regions](data:image/png;base64...)

Heatmap of ChIP peaks binding to TSS regions

[ChIPseeker](http://bioconductor.org/packages/ChIPseeker) provide a one step function to generate this figure from bed file. The following function will generate the same figure as above.

```
peakHeatmap(files[[4]], TxDb=txdb, upstream=3000, downstream=3000)
```

Users can use `nbin` parameter to speed up.

```
peakHeatmap(files[[4]],TxDb = txdb,nbin = 800,upstream=3000, downstream=3000)
```

Users can also use ggplot method to change the details of the figures.

```
peakHeatmap(files[[4]],TxDb = txdb,nbin = 800,upstream=3000, downstream=3000) +
  scale_fill_distiller(palette = "RdYlGn")
```

Users can also profile genebody regions with `peakHeatmap()`.

```
peakHeatmap(peak = files[[4]],
            TxDb = txdb,
            upstream = rel(0.2),
            downstream = rel(0.2),
            by = "gene",
            type = "body",
            nbin = 800)
```

![Heatmap of genebody regions](data:image/png;base64...)

Heatmap of genebody regions

Sometimes there will be a need to explore the comparison of the peak heatmap over two regions, for example, the following picture is the peak over two gene sets. One possible scenery of using this method is to compare the peak heatmap over up-regulating genes and down-regulating genes. Here `txdb1` and `txdb2` is the simulated gene sets obtain from `TxDb.Hsapiens.UCSC.hg19.knownGene`. Using `peakHeatmap_multiple_Sets()`, accepting `list` object containing different regions information. The length of each part is correlated to the amount of regions.

```
txdb1 <- transcripts(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb2 <- unlist(fiveUTRsByTranscript(TxDb.Hsapiens.UCSC.hg19.knownGene))[1:10000,]

region_list <- list(geneX = txdb1, geneY = txdb2)
peakHeatmap_multiple_Sets(peak = files[[4]],
                          upstream = 1000,downstream = 1000,
                          by = c("geneX","geneY"),
                          type = "start_site",
                          TxDb = region_list,nbin = 800)
```

![Heatmap of over two regions](data:image/png;base64...)

Heatmap of over two regions

We also meet the need of ploting heatmap and peak profiling together.

```
peak_Profile_Heatmap(peak = files[[4]],
                     upstream = 1000,
                     downstream = 1000,
                     by = "gene",
                     type = "start_site",
                     TxDb = txdb,
                     nbin = 800)
```

![Combination of heatmap and peak profiling](data:image/png;base64...)

Combination of heatmap and peak profiling

Exploring several regions with heatmap and peak profiling is also supported.

```
txdb1 <- transcripts(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb2 <- unlist(fiveUTRsByTranscript(TxDb.Hsapiens.UCSC.hg19.knownGene))[1:10000,]

region_list <- list(geneX = txdb1, geneY = txdb2)
peak_Profile_Heatmap(peak = files[[4]],
                     upstream = 1000,
                     downstream = 1000,
                     by = c("geneX","geneY"),
                     type = "start_site",
                     TxDb = region_list,nbin = 800)
```

![Combination of heatmap and peak profiling over several regions](data:image/png;base64...)

Combination of heatmap and peak profiling over several regions

### Average Profile of ChIP peaks binding to TSS region

```
plotAvgProf(tagMatrix, xlim=c(-3000, 3000),
            xlab="Genomic Region (5'->3')", ylab = "Read Count Frequency")
```

```
## >> plotting figure...             2025-11-04 16:52:54
```

![Average Profile of ChIP peaks binding to TSS region](data:image/png;base64...)

Average Profile of ChIP peaks binding to TSS region

The function `plotAvgProf2` provide a one step from bed file to average profile plot. The following command will generate the same figure as shown above.

```
plotAvgProf2(files[[4]], TxDb=txdb, upstream=3000, downstream=3000,
             xlab="Genomic Region (5'->3')", ylab = "Read Count Frequency")
```

Confidence interval estimated by bootstrap method is also supported for characterizing ChIP binding profiles.

```
plotAvgProf(tagMatrix, xlim=c(-3000, 3000), conf = 0.95, resample = 1000)
```

![](data:image/png;base64...)

## Profile of ChIP peaks binding to different regions

Referring to the [issue #16](https://github.com/GuangchuangYu/ChIPseeker/issues/16) , we developed and improved several functions support start site region, end site region and body region of Gene/Transcript/Exon/Intron/3UTR/5UTR. `getBioRegion` can prepare the different regions for ChIP peaks to bind. `getTagMatrix` can accept `type`, `by`, `upstream` and `downstream` parameters to get tagmatrix according to different needs. `plotPeakProf` and `plotPeakProf2` supports the plotting of profiles of peaks binding to different regions.Users can also create heatmap or average profile of ChIP peaks binding to these regions.

In order to plot body regions, a new methond `binning`,was introduced to `getTagMatrix`. The idea of `binning` was derived from [deeptools](https://deeptools.readthedocs.io/en/develop/content/tools/computeMatrix.html)(Ramı́rez et al. 2016). `binning` scaled the regions having different lengths to the equal length by deviding the regions into the same amounts of boxes. Because the amount of boxes is equal, the regions can be thought of scaling to equal length.`binning` method can speed up the `getTagMatrix` by changing the precision from bp to box(several bps).

There are three ways to plot these regions. First, users can use `getBioRegion` to prepare the regions. Then align the peaks that are mapping to these regions, and generate the tagMatrix by `getTagMatrix`. At Last, plot the figures by `plotPeakProf`. Second, users can input `type` and `by` parameters to `getTagMatrix` to get the tagMatrix and plot the figures. Third, users can use `plotPeakProf2` to do everything in one step.

### Binning method for profile of ChIP peaks binding to TSS regions

Here uses the method of inputting `type` and `by` parameters. `type = "start_site"` means the start site region. `by = "gene"` means that it is the start site region of gene(TSS regions). If users want to use binning method, the `nbin` method must be set.

```
## The results of binning method and normal method are nearly the same.
tagMatrix_binning <- getTagMatrix(peak = peak, TxDb = txdb,
                                  upstream = 3000, downstream = 3000,
                                  type = "start_site", by = "gene",
                                  weightCol = "V5", nbin = 800)
```

### Profile of ChIP peaks binding to body regions

We improved and developed several functions to plot body region of Gene/Transcript/Exon/Intron/3UTR/5UTR. If users want to get more information from the body region, we added `upstream` and `downstream` parameters to functions in order to get flank extension of body regions. `upstream` and `downstream` can be NULL(default), rel object and actual numbers. NULL(default) reflects body regions with no flank extension. Rel object reflects the percentage of total length of body regions. Actual numbers reflects the actual length of flank extension.

```
## Here uses `plotPeakProf2` to do all things in one step.
## Gene body regions having lengths smaller than nbin will be filtered
## A message will be given to warning users about that.
## >> 9 peaks(0.872093%), having lengths smaller than 800bp, are filtered...

## the ignore_strand is FALSE in default. We put here to emphasize that.
## We will not show it again in the below example
plotPeakProf2(peak = peak, upstream = rel(0.2), downstream = rel(0.2),
              conf = 0.95, by = "gene", type = "body", nbin = 800,
              TxDb = txdb, weightCol = "V5",ignore_strand = F)
```

![](data:image/png;base64...)

Users can also get the profile ChIP peaks binding to gene body regions with no flank extension or flank extension decided by actual length.

```
## The first method using getBioRegion(), getTagMatrix() and plotPeakProf() to plot in three steps.
genebody <- getBioRegion(TxDb = txdb,
                         by = "gene",
                         type = "body")

matrix_no_flankextension <- getTagMatrix(peak,windows = genebody, nbin = 800)

plotPeakProf(matrix_no_flankextension,conf = 0.95)

## The second method of using getTagMatrix() and plotPeakProf() to plot in two steps
matrix_actual_extension <- getTagMatrix(peak,windows = genebody, nbin = 800,
                                        upstream = 1000,downstream = 1000)
plotPeakProf(matrix_actual_extension,conf = 0.95)
```

Users can also get the body region of 5UTR/3UTR.

```
five_UTR_body <- getTagMatrix(peak = peak,
                              TxDb = txdb,
                              upstream = rel(0.2),
                              downstream = rel(0.2),
                              type = "body",
                              by = "5UTR",
                              weightCol = "V5",
                              nbin = 50)

plotPeakProf(tagMatrix = five_UTR_body, conf = 0.95)
```

### Profile of ChIP peaks binding to TTS regions

```
TTS_matrix <- getTagMatrix(peak = peak,
                           TxDb = txdb,
                           upstream = 3000,
                           downstream = 3000,
                           type = "end_site",
                           by = "gene",
                           weightCol = "V5")

plotPeakProf(tagMatrix = TTS_matrix, conf = 0.95)
```

# Peak Annotation

```
peakAnno <- annotatePeak(files[[4]], tssRegion=c(-3000, 3000),
                         TxDb=txdb, annoDb="org.Hs.eg.db")
```

```
## >> loading peak file...               2025-11-04 16:52:54
## >> preparing features information...      2025-11-04 16:52:54
## >> Using Genome: hg19 ...
## >> identifying nearest features...        2025-11-04 16:52:55
## >> calculating distance from peak to TSS...   2025-11-04 16:52:56
## >> assigning genomic annotation...        2025-11-04 16:52:56
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
## >> adding gene annotation...          2025-11-04 16:53:35
```

```
## >> assigning chromosome lengths           2025-11-04 16:53:36
## >> done...                    2025-11-04 16:53:36
```

Note that it would also be possible to use Ensembl-based `EnsDb` annotation databases created by the [ensembldb](http://bioconductor.org/packages/ensembldb) package for the peak annotations by providing it with the `TxDb` parameter. Since UCSC-style chromosome names are used we have to change the style of the chromosome names from *Ensembl* to *UCSC* in the example below.

```
library(EnsDb.Hsapiens.v75)
edb <- EnsDb.Hsapiens.v75
seqlevelsStyle(edb) <- "UCSC"

peakAnno.edb <- annotatePeak(files[[4]], tssRegion=c(-3000, 3000),
                             TxDb=edb, annoDb="org.Hs.eg.db")
```

Peak Annotation is performed by `annotatePeak`. User can define TSS (transcription start site) region, by default TSS is defined from -3kb to +3kb. The output of `annotatePeak` is `csAnno` instance. [ChIPseeker](http://bioconductor.org/packages/ChIPseeker) provides `as.GRanges` to convert `csAnno` to `GRanges` instance, and `as.data.frame` to convert `csAnno` to `data.frame` which can be exported to file by `write.table`.

`TxDb` object contained transcript-related features of a particular genome. Bioconductor provides several package that containing `TxDb` object of model organisms with multiple commonly used genome version, for instance [TxDb.Hsapiens.UCSC.hg38.knownGene](http://bioconductor.org/packages/TxDb.Hsapiens.UCSC.hg38.knownGene), [TxDb.Hsapiens.UCSC.hg19.knownGene](http://bioconductor.org/packages/TxDb.Hsapiens.UCSC.hg19.knownGene) for human genome hg38 and hg19, [TxDb.Mmusculus.UCSC.mm10.knownGene](http://bioconductor.org/packages/TxDb.Mmusculus.UCSC.mm10.knownGene) and [TxDb.Mmusculus.UCSC.mm9.knownGene](http://bioconductor.org/packages/TxDb.Mmusculus.UCSC.mm9.knownGene) for mouse genome mm10 and mm9, etc. User can also prepare their own `TxDb` object by retrieving information from UCSC Genome Bioinformatics and BioMart data resources by R function `makeTxDbFromBiomart` and `makeTxDbFromUCSC`. `TxDb` object should be passed for peak annotation.

All the peak information contained in peakfile will be retained in the output of `annotatePeak`. The position and strand information of nearest genes are reported. The distance from peak to the TSS of its nearest gene is also reported. The genomic region of the peak is reported in annotation column. Since some annotation may overlap, [ChIPseeker](http://bioconductor.org/packages/ChIPseeker) adopted the following priority in genomic annotation.

* Promoter
* 5’ UTR
* 3’ UTR
* Exon
* Intron
* Downstream
* Intergenic

*Downstream* is defined as the downstream of gene end.

[ChIPseeker](http://bioconductor.org/packages/ChIPseeker) also provides parameter *genomicAnnotationPriority* for user to prioritize this hierachy.

`annotatePeak` report detail information when the annotation is Exon or Intron, for instance “Exon (uc002sbe.3/9736, exon 69 of 80)”, means that the peak is overlap with an Exon of transcript uc002sbe.3, and the corresponding Entrez gene ID is 9736 (Transcripts that belong to the same gene ID may differ in splice events), and this overlaped exon is the 69th exon of the 80 exons that this transcript uc002sbe.3 prossess.

Parameter annoDb is optional, if provided, extra columns including SYMBOL, GENENAME, ENSEMBL/ENTREZID will be added. The geneId column in annotation output will be consistent with the geneID in TxDb. If it is ENTREZID, ENSEMBL will be added if annoDb is provided, while if it is ENSEMBL ID, ENTREZID will be added.

## Visualize Genomic Annotation

To annotate the location of a given peak in terms of genomic features, `annotatePeak` assigns peaks to genomic annotation in “annotation” column of the output, which includes whether a peak is in the TSS, Exon, 5’ UTR, 3’ UTR, Intronic or Intergenic. Many researchers are very interesting in these annotations. TSS region can be defined by user and `annotatePeak` output in details of which exon/intron of which genes as illustrated in previous section.

Pie and Bar plot are supported to visualize the genomic annotation.

```
plotAnnoPie(peakAnno)
```

![Genomic Annotation by pieplot](data:image/png;base64...)

Genomic Annotation by pieplot

```
plotAnnoBar(peakAnno)
```

![Genomic Annotation by barplot](data:image/png;base64...)

Genomic Annotation by barplot

Since some annotation overlap, user may interested to view the full annotation with their overlap, which can be partially resolved by `vennpie` function.

```
vennpie(peakAnno)
```

![Genomic Annotation by vennpie](data:image/png;base64...)

Genomic Annotation by vennpie

We extend [UpSetR](https://CRAN.R-project.org/package%3DUpSetR) to view full annotation overlap. User can user `upsetplot` function.

```
upsetplot(peakAnno)
```

![](data:image/png;base64...)

We can combine `vennpie` with `upsetplot` by setting *vennpie = TRUE*.

```
upsetplot(peakAnno, vennpie=TRUE)
```

![](data:image/png;base64...)

## Visualize distribution of TF-binding loci relative to TSS

The distance from the peak (binding site) to the TSS of the nearest gene is calculated by `annotatePeak` and reported in the output. We provide `plotDistToTSS` to calculate the percentage of binding sites upstream and downstream from the TSS of the nearest genes, and visualize the distribution.

```
plotDistToTSS(peakAnno,
              title="Distribution of transcription factor-binding loci\nrelative to TSS")
```

![Distribution of Binding Sites](data:image/png;base64...)

Distribution of Binding Sites

# Functional enrichment analysis

Once we have obtained the annotated nearest genes, we can perform functional enrichment analysis to identify predominant biological themes among these genes by incorporating biological knowledge provided by biological ontologies. For instance, Gene Ontology (GO)(Ashburner et al. 2000) annotates genes to biological processes, molecular functions, and cellular components in a directed acyclic graph structure, Kyoto Encyclopedia of Genes and Genomes (KEGG)(Kanehisa et al. 2004) annotates genes to pathways, Disease Ontology (DO)(Schriml et al. 2011) annotates genes with human disease association, and Reactome(Croft et al. 2013) annotates gene to pathways and reactions.

[ChIPseeker](http://bioconductor.org/packages/ChIPseeker) also provides a function, ***seq2gene***, for linking genomc regions to genes in a many-to-many mapping. It consider host gene (exon/intron), promoter region and flanking gene from intergenic region that may under control via cis-regulation. This function is designed to link both coding and non-coding genomic regions to coding genes and facilitate functional analysis.

Enrichment analysis is a widely used approach to identify biological themes. I have developed several Bioconductor packages for investigating whether the number of selected genes associated with a particular biological term is larger than expected, including [DOSE](http://bioconductor.org/packages/DOSE)(Yu et al. 2015) for Disease Ontology, [ReactomePA](http://bioconductor.org/packages/ReactomePA) for reactome pathway, [clusterProfiler](http://bioconductor.org/packages/clusterProfiler)(Yu et al. 2012) for Gene Ontology and KEGG enrichment analysis.

```
library(ReactomePA)

pathway1 <- enrichPathway(as.data.frame(peakAnno)$geneId)
head(pathway1, 2)
```

```
##                          ID                   Description GeneRatio  BgRatio
## R-HSA-9830369 R-HSA-9830369            Kidney development    13/377 40/10173
## R-HSA-9830674 R-HSA-9830674 Formation of the ureteric bud     8/377 18/10173
##               RichFactor FoldEnrichment   zScore       pvalue     p.adjust
## R-HSA-9830369  0.3250000       8.769828 9.658770 9.821942e-10 9.075475e-07
## R-HSA-9830674  0.4444444      11.992927 9.157124 1.043978e-07 4.661781e-05
##                     qvalue
## R-HSA-9830369 8.808731e-07
## R-HSA-9830674 4.524764e-05
##                                                                           geneID
## R-HSA-9830369 2625/5076/652/6495/3975/6928/10736/5455/7849/3237/6092/255743/2138
## R-HSA-9830674                          5076/652/6495/10736/3237/6092/255743/2138
##               Count
## R-HSA-9830369    13
## R-HSA-9830674     8
```

```
gene <- seq2gene(peak, tssRegion = c(-1000, 1000), flankDistance = 3000, TxDb=txdb)
```

```
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
```

```
pathway2 <- enrichPathway(gene)
head(pathway2, 2)
```

```
##                          ID
## R-HSA-9758941 R-HSA-9758941
## R-HSA-9937080 R-HSA-9937080
##                                                                    Description
## R-HSA-9758941                                                     Gastrulation
## R-HSA-9937080 Developmental Lineage of Multipotent Pancreatic Progenitor Cells
##               GeneRatio   BgRatio RichFactor FoldEnrichment   zScore
## R-HSA-9758941    19/257 101/10173  0.1881188       7.446431 10.48150
## R-HSA-9937080     8/257  17/10173  0.4705882      18.627604 11.71003
##                     pvalue     p.adjust       qvalue
## R-HSA-9758941 5.854898e-12 4.297495e-09 4.018309e-09
## R-HSA-9937080 2.972279e-09 1.090826e-06 1.019961e-06
##                                                                                                          geneID
## R-HSA-9758941 5692/7546/3169/2303/5717/2627/5714/344022/7849/2637/8320/51176/2296/64321/5453/5076/5080/652/2626
## R-HSA-9937080                                                          3087/3651/6928/6662/2627/4825/64321/2626
##               Count
## R-HSA-9758941    19
## R-HSA-9937080     8
```

```
dotplot(pathway2)
```

![](data:image/png;base64...)

More information can be found in the vignettes of Bioconductor packages [DOSE](http://bioconductor.org/packages/DOSE)(Yu et al. 2015), [ReactomePA](http://bioconductor.org/packages/ReactomePA), [clusterProfiler](http://bioconductor.org/packages/clusterProfiler)(Yu et al. 2012), which also provide several methods to visualize enrichment results. The [clusterProfiler](http://bioconductor.org/packages/clusterProfiler)(Yu et al. 2012) is designed for comparing and visualizing functional profiles among gene clusters, and can directly applied to compare biological themes at GO, DO, KEGG, Reactome perspective.

# ChIP peak data set comparison

## Profile of several ChIP peak data binding to TSS region

Function `plotAvgProf`, `tagHeatmap` and `plotPeakProf` can accept a list of `tagMatrix` and visualize profile or heatmap among several ChIP experiments, while `plotAvgProf2` , `peakHeatmap` and `plotPeakProf2` can accept a list of bed files and perform the same task in one step.

### Average profiles

```
## promoter <- getPromoters(TxDb=txdb, upstream=3000, downstream=3000)
## tagMatrixList <- lapply(files, getTagMatrix, windows=promoter)
##
## to speed up the compilation of this vigenette, we load a precaculated tagMatrixList
data("tagMatrixList")
plotAvgProf(tagMatrixList, xlim=c(-3000, 3000))
```

```
## >> plotting figure...             2025-11-04 16:55:47
```

![Average Profiles of ChIP peaks among different experiments](data:image/png;base64...)

Average Profiles of ChIP peaks among different experiments

```
plotAvgProf(tagMatrixList, xlim=c(-3000, 3000), conf=0.95,resample=500, facet="row")
```

![](data:image/png;base64...)

```
## normal method
plotPeakProf2(files, upstream = 3000, downstream = 3000, conf = 0.95,
              by = "gene", type = "start_site", TxDb = txdb,
              facet = "row")

## binning method
plotPeakProf2(files, upstream = 3000, downstream = 3000, conf = 0.95,
              by = "gene", type = "start_site", TxDb = txdb,
              facet = "row", nbin = 800)
```

### Peak heatmaps

```
tagHeatmap(tagMatrixList)
```

![Heatmap of ChIP peaks among different experiments](data:image/png;base64...)

Heatmap of ChIP peaks among different experiments

## Profile of several ChIP peak data binding to body region

Functions `plotPeakProf` and `plotPeakProf2` also support to plot profile of several ChIP peak data binding to body region.

```
plotPeakProf2(files, upstream = rel(0.2), downstream = rel(0.2),
              conf = 0.95, by = "gene", type = "body",
              TxDb = txdb, facet = "row", nbin = 800)
```

![](data:image/png;base64...)

## ChIP peak annotation comparision

The `plotAnnoBar` and `plotDistToTSS` can also accept input of a named list of annotated peaks (output of `annotatePeak`).

```
peakAnnoList <- lapply(files, annotatePeak, TxDb=txdb,
                       tssRegion=c(-3000, 3000), verbose=FALSE)
```

```
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
## >> Using Genome: hg19 ...
```

We can use `plotAnnoBar` to comparing their genomic annotation.

```
plotAnnoBar(peakAnnoList)
```

![Genomic Annotation among different ChIPseq data](data:image/png;base64...)

Genomic Annotation among different ChIPseq data

R function `plotDistToTSS` can use to comparing distance to TSS profiles among ChIPseq data.

```
plotDistToTSS(peakAnnoList)
```

![Distribution of Binding Sites among different ChIPseq data](data:image/png;base64...)

Distribution of Binding Sites among different ChIPseq data

## Functional profiles comparison

As shown in section 4, the annotated genes can analyzed by `r Biocpkg("clusterProfiler")`(Yu et al. 2012), `r Biocpkg("DOSE")`(Yu et al. 2015), [meshes](http://bioconductor.org/packages/meshes) and `r Biocpkg("ReactomePA")` for Gene Ontology, KEGG, Disease Ontology, MeSH and Reactome Pathway enrichment analysis.

The [clusterProfiler](http://bioconductor.org/packages/clusterProfiler)(Yu et al. 2012) package provides `compareCluster` function for comparing biological themes among gene clusters, and can be easily adopted to compare different ChIP peak experiments.

```
genes = lapply(peakAnnoList, function(i) as.data.frame(i)$geneId)
names(genes) = sub("_", "\n", names(genes))
compKEGG <- compareCluster(geneCluster   = genes,
                         fun           = "enrichKEGG",
                         pvalueCutoff  = 0.05,
                         pAdjustMethod = "BH")
dotplot(compKEGG, showCategory = 15, title = "KEGG Pathway Enrichment Analysis")
```

![](data:image/png;base64...)

## Overlap of peaks and annotated genes

User may want to compare the overlap peaks of replicate experiments or from different experiments. [ChIPseeker](http://bioconductor.org/packages/ChIPseeker) provides `peak2GRanges` that can read peak file and stored in GRanges object. Several files can be read simultaneously using lapply, and then passed to `vennplot` to calculate their overlap and draw venn plot.

`vennplot` accept a list of object, can be a list of GRanges or a list of vector. Here, I will demonstrate using `vennplot` to visualize the overlap of the nearest genes stored in peakAnnoList.

```
genes= lapply(peakAnnoList, function(i) as.data.frame(i)$geneId)
vennplot(genes)
```

![Overlap of annotated genes](data:image/png;base64...)

Overlap of annotated genes

# Statistical testing of ChIP seq overlap

Overlap is very important, if two ChIP experiment by two different proteins overlap in a large fraction of their peaks, they may cooperative in regulation. Calculating the overlap is only touch the surface. [ChIPseeker](http://bioconductor.org/packages/ChIPseeker) implemented statistical methods to measure the significance of the overlap.

## Shuffle genome coordination

```
p <- GRanges(seqnames=c("chr1", "chr3"),
             ranges=IRanges(start=c(1, 100), end=c(50, 130)))
shuffle(p, TxDb=txdb)
```

```
## GRanges object with 2 ranges and 0 metadata columns:
##       seqnames              ranges strand
##          <Rle>           <IRanges>  <Rle>
##   [1]     chr1 124224141-124224190      *
##   [2]     chr3 197731717-197731747      *
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

We implement the `shuffle` function to randomly permute the genomic locations of ChIP peaks defined in a genome which stored in `TxDb` object.

## Peak overlap enrichment analysis

With the ease of this `shuffle` method, we can generate thousands of random ChIP data and calculate the background null distribution of the overlap among ChIP data sets.

```
enrichPeakOverlap(queryPeak     = files[[5]],
                  targetPeak    = unlist(files[1:4]),
                  TxDb          = txdb,
                  pAdjustMethod = "BH",
                  nShuffle      = 50,
                  chainFile     = NULL,
                  verbose       = FALSE)
```

```
##                                                       qSample
## ARmo_0M    GSM1295077_CBX7_BF_ChipSeq_mergedReps_peaks.bed.gz
## ARmo_1nM   GSM1295077_CBX7_BF_ChipSeq_mergedReps_peaks.bed.gz
## ARmo_100nM GSM1295077_CBX7_BF_ChipSeq_mergedReps_peaks.bed.gz
## CBX6_BF    GSM1295077_CBX7_BF_ChipSeq_mergedReps_peaks.bed.gz
##                                                       tSample qLen tLen N_OL
## ARmo_0M                       GSM1174480_ARmo_0M_peaks.bed.gz 1663  812    0
## ARmo_1nM                     GSM1174481_ARmo_1nM_peaks.bed.gz 1663 2296    8
## ARmo_100nM                 GSM1174482_ARmo_100nM_peaks.bed.gz 1663 1359    3
## CBX6_BF    GSM1295076_CBX6_BF_ChipSeq_mergedReps_peaks.bed.gz 1663 1331  968
##                pvalue   p.adjust
## ARmo_0M    0.90196078 0.90196078
## ARmo_1nM   0.11764706 0.23529412
## ARmo_100nM 0.35294118 0.47058824
## CBX6_BF    0.01960784 0.07843137
```

Parameter *queryPeak* is the query ChIP data, while *targetPeak* is bed file name or a vector of bed file names from comparison; *nShuffle* is the number to shuffle the peaks in *targetPeak*. To speed up the compilation of this vignettes, we only set *nShuffle* to 50 as an example for only demonstration. User should set the number to 1000 or above for more robust result. Parameter *chainFile* are chain file name for mapping the *targetPeak* to the genome version consistent with *queryPeak* when their genome version are different. This creat the possibility of comparison among different genome version and cross species.

In the output, *qSample* is the name of *queryPeak* and *qLen* is the the number of peaks in *queryPeak*. *N\_OL* is the number of overlap between *queryPeak* and *targetPeak*.

# Data Mining with ChIP seq data deposited in GEO

There are many ChIP seq data sets that have been published and deposited in GEO database. We can compare our own dataset to those deposited in GEO to search for significant overlap data. Significant overlap of ChIP seq data by different binding proteins may be used to infer cooperative regulation and thus can be used to generate hypotheses.

We collect about **17,000** bed files deposited in GEO, user can use `getGEOspecies` to get a summary based on speices.

## GEO data collection

```
getGEOspecies()
```

```
##                                                                 species  Freq
## 1                                       Actinobacillus pleuropneumoniae     1
## 2                   Actinobacillus pleuropneumoniae serovar 3 str. JL03     1
## 3                                                         Aedes aegypti    11
## 4                                                              Anabaena     6
## 5                                                   Anolis carolinensis     7
## 6                                                     Anopheles gambiae     2
## 7                                                        Apis mellifera    17
## 8                                             Apis mellifera scutellata     1
## 9                                                           Arabidopsis    17
## 10                                                   Arabidopsis lyrata     4
## 11                                                 Arabidopsis thaliana  2473
## 12                                                 Atelerix albiventris     2
## 13                                                    Bombus terrestris     8
## 14                                                           Bos taurus   257
## 15                                              Brachypodium distachyon    10
## 16                                            Branchiostoma lanceolatum    93
## 17                                                        Brassica rapa    12
## 18                                               Caenorhabditis elegans   532
## 19                                                   Callithrix jacchus    48
## 20                                                     Candida albicans    34
## 21                                                 Candida dubliniensis    20
## 22                                                          Canis lupus     1
## 23                                               Canis lupus familiaris    35
## 24                                                Capsaspora owczarzaki    21
## 25                                                        Carica papaya     1
## 26                                        Caulobacter crescentus NA1000     8
## 27                                               Caulobacter vibrioides     2
## 28                                            Chlamydomonas reinhardtii    53
## 29                                                 Chlorocebus aethiops    11
## 30                                                  Chlorocebus sabaeus     6
## 31                                                       Ciona savignyi     4
## 32                                                    Citrullus lanatus     3
## 33                                                   Cleome hassleriana     1
## 34                                                        Columba livia     6
## 35                                           Corynebacterium glutamicum     9
## 36                                                    Crassostrea gigas     4
## 37                                              Cryptococcus neoformans    67
## 38                                                         Cucumis melo     9
## 39                                                      Cucumis sativus     3
## 40                                                      Cyprinus carpio    40
## 41                                                          Danio rerio   532
## 42                                                        Daphnia magna    36
## 43                                                        Daphnia pulex    14
## 44                                             Dictyostelium discoideum    77
## 45                                                    Dimocarpus longan     9
## 46                                             Dromaius novaehollandiae    27
## 47                                                   Drosophila busckii     2
## 48                                              Drosophila melanogaster  1483
## 49                              Drosophila melanogaster;\tSindbis virus     3
## 50                                                   Drosophila miranda     2
## 51                                             Drosophila pseudoobscura     7
## 52                                                  Drosophila simulans    12
## 53                                                   Drosophila virilis    28
## 54                                                Drosophila willistoni     1
## 55                                                    Drosophila yakuba     8
## 56                                                       Equus caballus     1
## 57                                                     Escherichia coli   126
## 58                                             Escherichia coli BW25113     4
## 59                                                Escherichia coli K-12     2
## 60                            Escherichia coli str. K-12 substr. MG1655    16
## 61                                                  Eutrema salsugineum    12
## 62                                                       Fragaria vesca     3
## 63                                                   Fusarium oxysporum     4
## 64                                                        Gallus gallus   292
## 65                                               Gasterosteus aculeatus     1
## 66                                         Geobacter sulfurreducens PCA     3
## 67                                                          Glycine max    31
## 68                                                      Gorilla gorilla     8
## 69                                                   Haloferax volcanii     3
## 70                                                    Helianthus annuus     2
## 71                                                Heterocephalus glaber     4
## 72                                                    Histophilus somni     1
## 73                                                         Homo sapiens 51828
## 74                               Homo sapiens;\tHuman betaherpesvirus 6     2
## 75                              Homo sapiens;\tHuman betaherpesvirus 6A    38
## 76                              Homo sapiens;\tHuman gammaherpesvirus 8    12
## 77                                   Homo sapiens;\tHuman herpesvirus 8     6
## 78                       Homo sapiens;\tHuman poliovirus 1 strain Sabin     5
## 79                  Homo sapiens;\tInfluenza A virus (A/hvPR8/34(H1N1))    12
## 80                                          Homo sapiens;\tMus musculus    13
## 81                                         Homo sapiens;\tSindbis virus     8
## 82                                             Human gammaherpesvirus 4     3
## 83                                                 Human herpesvirus 6B     2
## 84                                                  Human herpesvirus 8     6
## 85                                         Human immunodeficiency virus    11
## 86                                                       Hydra vulgaris     6
## 87                                                 Komagataella phaffii    12
## 88                                                  Larimichthys crocea     7
## 89                                                     Leersia perrieri     1
## 90                                               Legionella pneumophila     5
## 91                                               Leishmania amazonensis     4
## 92                                                     Leishmania major    14
## 93                                     Leishmania major strain Friedlin     4
## 94                                                Leishmania tarentolae    15
## 95                                                       Macaca mulatta   136
## 96                                        Macaca mulatta polyomavirus 1     7
## 97                         Macaca mulatta;\tMacacine gammaherpesvirus 4     3
## 98                                                      Malus domestica    21
## 99                                                Marchantia polymorpha     1
## 100                                                 Medicago truncatula     8
## 101                                                   Mesoplasma florum     1
## 102                                                  Microcebus murinus     6
## 103                                       Moloney murine leukemia virus     9
## 104                                               Monodelphis domestica    31
## 105                                          Moraxella catarrhalis O35E     6
## 106                                                                 Mus     2
## 107                                                        Mus musculus 38038
## 108                             Mus musculus musculus x M. m. castaneus     1
## 109                                          Mus musculus x Mus spretus    11
## 110                       Mus musculus;\tHuman herpesvirus 1 strain KOS     2
## 111                                 Mus musculus;\tMurid herpesvirus 68     2
## 112                                            Musa acuminata AAA Group     3
## 113                                  Mycobacterium abscessus ATCC 19977     4
## 114                                               Mycobacterium marinum     1
## 115                                          Mycobacterium tuberculosis     2
## 116                                    Mycobacterium tuberculosis H37Rv     5
## 117                                         Mycolicibacterium smegmatis     2
## 118                                 Mycolicibacterium smegmatis MC2 155     2
## 119                                                     Myotis brandtii    15
## 120                                               Naumovozyma castellii     1
## 121                                              Nematostella vectensis    31
## 122                                                   Neurospora crassa     3
## 123                                                   Nicotiana tabacum     6
## 124                                            Nicrophorus vespilloides     4
## 125                                        Nippostrongylus brasiliensis     9
## 126                                                 Nomascus leucogenys     1
## 127                                               Oreochromis niloticus     1
## 128                                            Ornithorhynchus anatinus     5
## 129                                                   Oryza brachyantha    11
## 130                                                    Oryza glaberrima     1
## 131                                                      Oryza punctata     1
## 132                                                        Oryza sativa   110
## 133                                         Oryza sativa Japonica Group    17
## 134                                                     Oryzias latipes    26
## 135                                                          Ovis aries     2
## 136                                                     Pan troglodytes   106
## 137                                               Pantherophis guttatus     7
## 138                                                        Papio anubis     3
## 139                                                     Patiria miniata     1
## 140                                             Penicillium chrysogenum     1
## 141                                                   Petunia x hybrida    10
## 142                                              Phascolarctos cinereus     2
## 143                                                 Phaseolus coccineus     2
## 144                                               Plasmodium falciparum   220
## 145                                           Plasmodium falciparum 3D7    43
## 146                                                    Plectus sambesii     1
## 147                                                      Pongo pygmaeus     6
## 148                                                  Procambarus fallax     6
## 149                                              Procambarus virginalis    16
## 150                                         Pseudomonas aeruginosa PAO1     7
## 151                                           Pseudomonas putida KT2440     2
## 152                       Pseudomonas savastanoi pv. phaseolicola 1448A     3
## 153                                                  Pseudozyma aphidis    11
## 154                                                  Pyricularia oryzae    18
## 155                                                 Pyrococcus furiosus     4
## 156                                              Pyrus x bretschneideri     4
## 157                                                   Rattus norvegicus   237
## 158                                             Rhodobacter sphaeroides    12
## 159                                          Rhodopseudomonas palustris     6
## 160                                   Rhodopseudomonas palustris CGA009     3
## 161                                            Romanomermis culicivorax     1
## 162                                            Saccharomyces cerevisiae  3740
## 163                                     Saccharomyces cerevisiae BY4741     8
## 164                                      Saccharomyces cerevisiae S288C    18
## 165                  Saccharomyces cerevisiae x Saccharomyces paradoxus    16
## 166                             Saccharomyces cerevisiae;\tHomo sapiens     2
## 167                             Saccharomyces cerevisiae;\tMus musculus    12
## 168                                          Saccharomyces kudriavzevii     1
## 169                                             Saccharomyces paradoxus     8
## 170                                                Saccharomyces uvarum     1
## 171                                                         Salmo salar    32
## 172 Salmonella enterica subsp. enterica serovar Typhimurium str. SL1344     4
## 173                                                Sarcophilus harrisii     3
## 174                                       Schizosaccharomyces japonicus     2
## 175                                           Schizosaccharomyces pombe   460
## 176                                              Schmidtea mediterranea     7
## 177                                                Solanum lycopersicum    76
## 178                                                   Solanum pennellii    18
## 179                                                     Sorghum bicolor     3
## 180                                               Spodoptera frugiperda    16
## 181                                       Streptomyces coelicolor A3(2)     6
## 182                                       Strongylocentrotus purpuratus    36
## 183                                                          Sus scrofa   334
## 184                                                 Taeniopygia guttata    21
## 185                                             Tetrahymena thermophila    19
## 186                                       Tetrahymena thermophila CU428     6
## 187                                           Thermus thermophilus HB27     4
## 188                                        Torulaspora microellipsoides     6
## 189                                                   Toxoplasma gondii    21
## 190                                                Toxoplasma gondii RH    12
## 191                                                 Tribolium castaneum    14
## 192                                                Trichinella spiralis     1
## 193                                                     Trichuris muris     4
## 194                                                   Triticum aestivum   127
## 195                                                  Trypanosoma brucei    12
## 196                                                    Tupaia chinensis     7
## 197                                                     Vibrio cholerae     8
## 198                                                      Vitis vinifera     2
## 199                                       Xenopus (Silurana) tropicalis    62
## 200                                                      Xenopus laevis    29
## 201                                                  Xenopus tropicalis   133
## 202                                 Xenopus tropicalis x Xenopus laevis     4
## 203                                                            Zea mays   173
## 204                                                 synthetic construct    42
```

The summary can also based on genome version as illustrated below:

```
getGEOgenomeVersion()
```

```
##                         organism genomeVersion  Freq
## 1            Anolis carolinensis       anoCar2     7
## 2                     Bos taurus       bosTau4     2
## 3                     Bos taurus       bosTau6    33
## 4                     Bos taurus       bosTau7     2
## 5         Canis lupus familiaris       canFam3    10
## 6         Caenorhabditis elegans          ce10   328
## 7         Caenorhabditis elegans           ce6    64
## 8                    Danio rerio       danRer6    89
## 9                    Danio rerio       danRer7    89
## 10       Drosophila melanogaster           dm3   767
## 11                 Gallus gallus       galGal3    33
## 12                 Gallus gallus       galGal4    73
## 13        Gasterosteus aculeatus       gasAcu1     1
## 14         Heterocephalus glaber       hetGla2     4
## 15                  Homo sapiens          hg18  3368
## 16                  Homo sapiens          hg19 30326
## 17                  Homo sapiens          hg38  4091
## 18                  Mus musculus          mm10 19089
## 19                  Mus musculus           mm8   556
## 20                  Mus musculus           mm9 17247
## 21         Monodelphis domestica       monDom5    31
## 22                    Ovis aries       oviAri3     2
## 23               Pan troglodytes       panTro3    48
## 24               Pan troglodytes       panTro4    48
## 25                Macaca mulatta       rheMac2    84
## 26                Macaca mulatta       rheMac3    40
## 27             Rattus norvegicus           rn5    66
## 28      Saccharomyces cerevisiae       sacCer2   145
## 29      Saccharomyces cerevisiae       sacCer3  2646
## 30                    Sus scrofa       susScr2    17
## 31                    Sus scrofa       susScr3    18
## 32           Taeniopygia guttata       taeGut2    20
## 33 Xenopus (Silurana) tropicalis       xenTro3     3
```

User can access the detail information by `getGEOInfo`, for each genome version.

```
hg19 <- getGEOInfo(genome="hg19", simplify=TRUE)
head(hg19)
```

```
##     series_id        gsm     organism
## 111  GSE16256  GSM521889 Homo sapiens
## 112  GSE16256  GSM521887 Homo sapiens
## 113  GSE16256  GSM521883 Homo sapiens
## 114  GSE16256 GSM1010966 Homo sapiens
## 115  GSE16256  GSM896166 Homo sapiens
## 116  GSE16256  GSM910577 Homo sapiens
##                                                                                                       title
## 111          Reference Epigenome: ChIP-Seq Analysis of H3K27me3 in IMR90 Cells; renlab.H3K27me3.IMR90-02.01
## 112            Reference Epigenome: ChIP-Seq Analysis of H3K27ac in IMR90 Cells; renlab.H3K27ac.IMR90-03.01
## 113            Reference Epigenome: ChIP-Seq Analysis of H3K14ac in IMR90 Cells; renlab.H3K14ac.IMR90-02.01
## 114                      polyA RNA sequencing of STL003 Pancreas Cultured Cells; polyA-RNA-seq_STL003PA_r1a
## 115          Reference Epigenome: ChIP-Seq Analysis of H4K8ac in hESC H1 Cells; renlab.H4K8ac.hESC.H1.01.01
## 116 Reference Epigenome: ChIP-Seq Analysis of H3K4me1 in Human Spleen Tissue; renlab.H3K4me1.STL003SX.01.01
##                                                                                                     supplementary_file
## 111         ftp://ftp.ncbi.nlm.nih.gov/geo/samples/GSM521nnn/GSM521889/suppl/GSM521889_UCSD.IMR90.H3K27me3.SK05.bed.gz
## 112          ftp://ftp.ncbi.nlm.nih.gov/geo/samples/GSM521nnn/GSM521887/suppl/GSM521887_UCSD.IMR90.H3K27ac.YL58.bed.gz
## 113          ftp://ftp.ncbi.nlm.nih.gov/geo/samples/GSM521nnn/GSM521883/suppl/GSM521883_UCSD.IMR90.H3K14ac.SK17.bed.gz
## 114 ftp://ftp.ncbi.nlm.nih.gov/geo/samples/GSM1010nnn/GSM1010966/suppl/GSM1010966_UCSD.Pancreas.mRNA-Seq.STL003.bed.gz
## 115              ftp://ftp.ncbi.nlm.nih.gov/geo/samples/GSM896nnn/GSM896166/suppl/GSM896166_UCSD.H1.H4K8ac.AY17.bed.gz
## 116       ftp://ftp.ncbi.nlm.nih.gov/geo/samples/GSM910nnn/GSM910577/suppl/GSM910577_UCSD.Spleen.H3K4me1.STL003.bed.gz
##     genomeVersion pubmed_id
## 111          hg19  19829295
## 112          hg19  19829295
## 113          hg19  19829295
## 114          hg19  19829295
## 115          hg19  19829295
## 116          hg19  19829295
```

If *simplify* is set to *FALSE*, extra information including *source\_name*, *extract\_protocol*, *description*, *data\_processing* and *submission\_date* will be incorporated.

## Download GEO ChIP data sets

[ChIPseeker](http://bioconductor.org/packages/ChIPseeker) provide function `downloadGEObedFiles` to download all the bed files of a particular genome.

```
downloadGEObedFiles(genome="hg19", destDir="hg19")
```

Or a vector of GSM accession number by `downloadGSMbedFiles`.

```
gsm <- hg19$gsm[sample(nrow(hg19), 10)]
downloadGSMbedFiles(gsm, destDir="hg19")
```

## Overlap significant testing

After download the bed files from GEO, we can pass them to `enrichPeakOverlap` for testing the significant of overlap. Parameter *targetPeak* can be the folder, *e.g.* hg19, that containing bed files. `enrichPeakOverlap` will parse the folder and compare all the bed files. It is possible to test the overlap with bed files that are mapping to different genome or different genome versions, `enrichPeakOverlap` provide a parameter *chainFile* that can pass a chain file and liftOver the *targetPeak* to the genome version consistent with *queryPeak*. Signifcant overlap can be use to generate hypothesis of cooperative regulation.By mining the data deposited in GEO, we can identify some putative complex or interacted regulators in gene expression regulation or chromsome remodelling for further validation.

# Need helps?

If you have questions/issues, please visit [ChIPseeker homepage](https://guangchuangyu.github.io/software/ChIPseeker/) first. Your problems are mostly documented. If you think you found a bug, please follow [the guide](https://guangchuangyu.github.io/2016/07/how-to-bug-author/) and provide a reproducible example to be posted on [github issue tracker](https://github.com/GuangchuangYu/ChIPseeker/issues). For questions, please post to [Bioconductor support site](https://support.bioconductor.org/) and tag your post with *ChIPseeker*.

For Chinese user, you can follow me on [WeChat (微信)](https://guangchuangyu.github.io/blog_images/biobabble.jpg).

# Session Information

Here is the output of `sessionInfo()` on the system on which this document was compiled:

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
##  [1] ChIPseeker_1.46.1
##  [2] ReactomePA_1.54.0
##  [3] clusterProfiler_4.18.1
##  [4] ggplot2_4.0.0
##  [5] org.Hs.eg.db_3.22.0
##  [6] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
##  [7] GenomicFeatures_1.62.0
##  [8] AnnotationDbi_1.72.0
##  [9] Biobase_2.70.0
## [10] GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0
## [12] IRanges_2.44.0
## [13] S4Vectors_0.48.0
## [14] BiocGenerics_0.56.0
## [15] generics_0.1.4
## [16] yulab.utils_0.2.1
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              ggtangle_0.0.7
##   [5] farver_2.1.2                rmarkdown_2.30
##   [7] fs_1.6.6                    BiocIO_1.20.0
##   [9] vctrs_0.6.5                 memoise_2.0.1
##  [11] Rsamtools_2.26.0            RCurl_1.98-1.17
##  [13] prettydoc_0.4.1             ggtree_4.0.1
##  [15] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [17] plotrix_3.8-4               curl_7.0.0
##  [19] SparseArray_1.10.1          gridGraphics_0.5-1
##  [21] sass_0.4.10                 KernSmooth_2.23-26
##  [23] bslib_0.9.0                 htmlwidgets_1.6.4
##  [25] plyr_1.8.9                  cachem_1.1.0
##  [27] GenomicAlignments_1.46.0    igraph_2.2.1
##  [29] lifecycle_1.0.4             pkgconfig_2.0.3
##  [31] Matrix_1.7-4                R6_2.6.1
##  [33] fastmap_1.2.0               gson_0.1.0
##  [35] MatrixGenerics_1.22.0       digest_0.6.37
##  [37] aplot_0.2.9                 enrichplot_1.30.0
##  [39] patchwork_1.3.2             RSQLite_2.4.3
##  [41] labeling_0.4.3              polyclip_1.10-7
##  [43] httr_1.4.7                  abind_1.4-8
##  [45] compiler_4.5.1              bit64_4.6.0-1
##  [47] fontquiver_0.2.1            withr_3.0.2
##  [49] graphite_1.56.0             S7_0.2.0
##  [51] BiocParallel_1.44.0         viridis_0.6.5
##  [53] DBI_1.2.3                   gplots_3.2.0
##  [55] ggforce_0.5.0               R.utils_2.13.0
##  [57] MASS_7.3-65                 rappdirs_0.3.3
##  [59] DelayedArray_0.36.0         rjson_0.2.23
##  [61] caTools_1.18.3              gtools_3.9.5
##  [63] tools_4.5.1                 ape_5.8-1
##  [65] R.oo_1.27.1                 glue_1.8.0
##  [67] restfulr_0.0.16             nlme_3.1-168
##  [69] GOSemSim_2.36.0             grid_4.5.1
##  [71] reshape2_1.4.4              fgsea_1.36.0
##  [73] gtable_0.3.6                R.methodsS3_1.8.2
##  [75] tidyr_1.3.1                 data.table_1.17.8
##  [77] tidygraph_1.3.1             XVector_0.50.0
##  [79] ggrepel_0.9.6               pillar_1.11.1
##  [81] stringr_1.6.0               splines_4.5.1
##  [83] tweenr_2.0.3                dplyr_1.1.4
##  [85] treeio_1.34.0               lattice_0.22-7
##  [87] rtracklayer_1.70.0          bit_4.6.0
##  [89] tidyselect_1.2.1            fontLiberation_0.1.0
##  [91] GO.db_3.22.0                Biostrings_2.78.0
##  [93] reactome.db_1.94.0          knitr_1.50
##  [95] gridExtra_2.3               fontBitstreamVera_0.1.1
##  [97] SummarizedExperiment_1.40.0 xfun_0.54
##  [99] graphlayouts_1.2.2          matrixStats_1.5.0
## [101] UCSC.utils_1.6.0            stringi_1.8.7
## [103] boot_1.3-32                 lazyeval_0.2.2
## [105] ggfun_0.2.0                 yaml_2.3.10
## [107] evaluate_1.0.5              codetools_0.2-20
## [109] cigarillo_1.0.0             ggraph_2.2.2
## [111] gdtools_0.4.4               tibble_3.3.0
## [113] qvalue_2.42.0               graph_1.88.0
## [115] ggplotify_0.1.3             cli_3.6.5
## [117] systemfonts_1.3.1           jquerylib_0.1.4
## [119] GenomeInfoDb_1.46.0         dichromat_2.0-0.1
## [121] Rcpp_1.1.0                  png_0.1-8
## [123] XML_3.99-0.19               parallel_4.5.1
## [125] blob_1.2.4                  DOSE_4.4.0
## [127] bitops_1.0-9                viridisLite_0.4.2
## [129] tidytree_0.4.6              ggiraph_0.9.2
## [131] scales_1.4.0                purrr_1.2.0
## [133] crayon_1.5.3                rlang_1.1.6
## [135] cowplot_1.2.0               fastmatch_1.1-6
## [137] KEGGREST_1.50.0
```

# References

Ashburner, Michael, Catherine A. Ball, Judith A. Blake, David Botstein, Heather Butler, J. Michael Cherry, Allan P. Davis, et al. 2000. “Gene Ontology: Tool for the Unification of Biology.” *Nat Genet* 25 (1): 25–29. <https://doi.org/10.1038/75556>.

Croft, D., A. F. Mundo, R. Haw, M. Milacic, J. Weiser, G. Wu, M. Caudy, et al. 2013. “The Reactome Pathway Knowledgebase.” *Nucleic Acids Research* 42 (D1): D472–D477. <https://doi.org/10.1093/nar/gkt1102>.

Kanehisa, Minoru, Susumu Goto, Shuichi Kawashima, Yasushi Okuno, and Masahiro Hattori. 2004. “The KEGG Resource for Deciphering the Genome.” *Nucleic Acids Research* 32 (suppl 1): D277–D280. <https://doi.org/10.1093/nar/gkh063>.

Pemberton, Helen, Emma Anderton, Harshil Patel, Sharon Brookes, Hollie Chandler, Richard Palermo, Julie Stock, et al. 2014. “Genome-Wide Co-Localization of Polycomb Orthologs and Their Effects on Gene Expression in Human Fibroblasts.” *Genome Biology* 15 (2): R23. <https://doi.org/10.1186/gb-2014-15-2-r23>.

Ramı́rez, Fidel, Devon P Ryan, Björn Grüning, Vivek Bhardwaj, Fabian Kilpert, Andreas S Richter, Steffen Heyne, Friederike Dündar, and Thomas Manke. 2016. “DeepTools2: A Next Generation Web Server for Deep-Sequencing Data Analysis.” *Nucleic Acids Research* 44 (W1): W160–W165.

Schriml, L. M., C. Arze, S. Nadendla, Y.-W. W. Chang, M. Mazaitis, V. Felix, G. Feng, and W. A. Kibbe. 2011. “Disease Ontology: A Backbone for Disease Semantic Integration.” *Nucleic Acids Research* 40 (D1): D940–D946. <https://doi.org/10.1093/nar/gkr972>.

Urbanucci, A, B Sahu, J Seppälä, A Larjo, L M Latonen, K K Waltering, T L J Tammela, et al. 2012. “Overexpression of Androgen Receptor Enhances the Binding of the Receptor to the Chromatin in Prostate Cancer.” *Oncogene* 31 (17): 2153–63. <https://doi.org/10.1038/onc.2011.401>.

Yu, Guangchuang, and Qing-Yu He. 2016. “ReactomePA: An R/Bioconductor Package for Reactome Pathway Analysis and Visualization.” *Molecular BioSystems* 12 (2): 477–79. <https://doi.org/10.1039/C5MB00663E>.

Yu, Guangchuang, Li-Gen Wang, Yanyan Han, and Qing-Yu He. 2012. “clusterProfiler: an R Package for Comparing Biological Themes Among Gene Clusters.” *OMICS: A Journal of Integrative Biology* 16 (5): 284–87. <https://doi.org/10.1089/omi.2011.0118>.

Yu, Guangchuang, Li-Gen Wang, and Qing-Yu He. 2015. “ChIPseeker: An R/Bioconductor Package for Chip Peak Annotation, Comparison and Visualization.” *Bioinformatics* 31 (14): 2382–3. <https://doi.org/10.1093/bioinformatics/btv145>.

Yu, Guangchuang, Li-Gen Wang, Guang-Rong Yan, and Qing-Yu He. 2015. “DOSE: An R/Bioconductor Package for Disease Ontology Semantic and Enrichment Analysis.” *Bioinformatics* 31 (4): 608–9. <https://doi.org/10.1093/bioinformatics/btu684>.