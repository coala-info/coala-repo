# wavClusteR: a workflow for PAR-CLIP data analysis

Federico Comoglio and Cem Sievers

#### 2025-10-30

#### Package

wavClusteR 2.44.0

#Abstract

A number of recently developed next-generation sequencing based methods (e.g. PAR-CLIP, Bisulphite sequencing, RRBS) specifically induce nucleotide substitutions within the short reads with respect to the reference genome. **wavClusteR** provides functions for the analysis of the data obtained by such methods with a major focus on PAR-CLIP. The package leverages on experimentally induced substitutions to identify high confidence signals (e.g. RNA-binding sites) in the data. A **wavClusteR** workflow consists of two steps:

1. The estimation of a non-parametric two-component mixture model to identify substitution frequencies that are likely to be affected by the experimental procedure
2. The identification of binding sites (clusters).

The package supports multicore computing. For a detailed description of the method please refer to [Sievers et al., 2012](http://www.ncbi.nlm.nih.gov/pubmed/22844102); [Comoglio et al., 2015](http://www.ncbi.nlm.nih.gov/pubmed/25638391).

#Preparing the input

**wavClusteR** expects a sorted and indexed BAM file as input. A streamlined workflow to generate the required input from a fastq file is outlined below (line 1 is pseudo code, replace it with the aligner specific syntax).

```
    #ALIGN:
        sample.fastq -> sample.sam
    #CONVERT:
        samtools view -b -S sample.sam -o sample.bam
    #SORT:
        samtools sort sample.bam sample_sorted
    #INDEXING:
        samtools index sample_sorted.bam
```

1. Short read alignment to the reference genome using relaxed alignment parameters. Experimentally-induced transitions will otherwise impede alignment of informative reads. Currently, **wavClusteR** has been tested with bowtie/Bowtie2 [Langmead et al., 2009](http://www.ncbi.nlm.nih.gov/pubmed/19261174); [Langmead and Salzberg, 2012](http://www.ncbi.nlm.nih.gov/pubmed/22388286)
2. Conversion of the alignment file from SAM to BAM format, e.g. using `samtools view` from [SAMtools](http://samtools.sourceforge.net)
3. Sorting of the BAM file, e.g. using `samtools sort`
4. Indexing of the sorted BAM file, e.g. with `samtools index`.

##Example dataset

**wavClusteR** provides a chunk of a human Argonaute 2 (AGO2) PAR-CLIP data set from [Kishore et al., 2011](http://www.ncbi.nlm.nih.gov/pubmed/?term=kishore+2011+argonaute). Reads in the chunk map to the genomic interval chrX:23996166-24023263. This data set is used below to illustrate a workflow for PAR-CLIP data analysis.

#A workflow for PAR-CLIP data analysis

##Reading sorted BAM files

A sorted and indexed BAM file can be loaded into the R session with **readSortedBam**. This function extracts aligned reads, sequences and the mismatch MD field, and returns a GRanges object.

```
library(wavClusteR)
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: Rsamtools
```

```
## Loading required package: Biostrings
```

```
## Loading required package: XVector
```

```
##
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
##
##     strsplit
```

```
filename <- system.file( "extdata", "example.bam", package = "wavClusteR" )
Bam <- readSortedBam(filename = filename)
Bam
```

```
## GRanges object with 5358 ranges and 2 metadata columns:
##          seqnames            ranges strand |                    qseq
##             <Rle>         <IRanges>  <Rle> |          <DNAStringSet>
##      [1]     chrX 24001819-24001844      - | CAGAGATAAA...TATTTTAAAG
##      [2]     chrX 24001819-24001843      - | CAGAGATAAA...ATATTTTAAG
##      [3]     chrX 24001834-24001863      - | ATATTTTAGA...ATTTTATTTA
##      [4]     chrX 24001836-24001865      - | TTTTTAAAGA...TTTATTTAAA
##      [5]     chrX 24001841-24001876      - | AAAGATTAAA...TTTTCTTCAT
##      ...      ...               ...    ... .                     ...
##   [5354]     chrX 24023018-24023051      - | GTTTCACAGC...AAAAATATGT
##   [5355]     chrX 24023018-24023051      - | GTTTCACAGC...AAAAATATGT
##   [5356]     chrX 24023019-24023051      - | TTTCACAGCG...AAAAATATGT
##   [5357]     chrX 24023019-24023051      - | TTTCACAGCG...AAAAATATGT
##   [5358]     chrX 24023067-24023090      - | CAAAGGCGCG...GGTTTATTTT
##               tag.MD
##          <character>
##      [1]          26
##      [2]        24A0
##      [3]        8A21
##      [4]     0A13A15
##      [5]       24A11
##      ...         ...
##   [5354]       10A23
##   [5355]       10A23
##   [5356]        9A23
##   [5357]        9A23
##   [5358]        9A14
##   -------
##   seqinfo: 25 sequences from an unspecified genome; no seqlengths
```

##Extracting informative genomic positions

Prior to model fitting, genome-wide substitutions need to be identified and filtered based on a coverage threshold. The **getAllSub** function identifies all genomic positions exhibiting at least one substitution and coverage above this threshold.

```
countTable <- getAllSub( Bam, minCov = 10 )
```

```
## Loading required package: doMC
```

```
## Loading required package: foreach
```

```
## Loading required package: iterators
```

```
## Loading required package: parallel
```

```
## Considering substitutions, n = 497, processing in 1 chunks
```

```
##    chunk #: 1
```

```
##    considering the + strand
```

```
## Computing local coverage at substitutions...
```

```
##    considering the - strand
```

```
## Computing local coverage at substitutions...
```

```
head( countTable )
```

```
## GRanges object with 6 ranges and 3 metadata columns:
##       seqnames    ranges strand | substitutions  coverage     count
##          <Rle> <IRanges>  <Rle> |   <character> <numeric> <integer>
##   [1]     chrX  24001959      - |            TC        17         2
##   [2]     chrX  24001973      - |            TC        17        12
##   [3]     chrX  24001977      - |            TC        13         1
##   [4]     chrX  24002046      - |            TC        10         1
##   [5]     chrX  24002057      - |            TC        10         6
##   [6]     chrX  24002147      - |            TC        22         3
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

The function returns a GRanges object specifying genomic position, strand, substitution type (e.g. “TC”: T in the reference genome; C in the read), strand-specific coverage and number of observed substitutions at the position.

###How to choose the coverage threshold?

The coverage threshold `minCov` defines the genomic positions to be used for parameter estimation, thus providing a means to tune the stringency of the analysis. Currently, **wavClusteR** does not allow to learn this threshold from the data. However, since the model is based on relative substitution frequencies, the value of `minCov` will influence the variance of the estimated parameters. Therefore, values smaller than default (`minCov=10`) are not recommended.

##Inspecting the substitutions profile (diagnostic I)

Once all substitutions are computed, a diagnostic substitution profile can be plotted with **plotSubstitutions**.

```
plotSubstitutions( countTable, highlight = "TC" )
```

![](data:image/png;base64...)

The function returns a barplot showing the total number of genomic positions that exhibit a given type of substitution and highlights the substitution type that is expected to be generated by the experimental procedure. The percentage of substitution of this type is also shown. This plot can be readily used to assess the quality of the sequenced libraries and can be used to compare different data sets generated under the same experimental condition.

##Estimating the model

**wavClusteR** uses the identified genomic positions to learn a non-parametric mixture model discriminating PAR-CLIP-specific from extrinsic transitions. Model parameters are estimated by **fitMixtureModel**.

```
model <- fitMixtureModel(countTable, substitution = "TC")
```

The function returns a list of:

* the two mixing coefficients (**l1** and **l2**)
* the two model components (**p1** and **p2**)
* the full density (**p**)

As the small size of our example data set does not to estimate the model reliably, the mixture model for the entire AGO2 dataset has been precomputed and is provided by the package.

```
data(model)
str(model)
```

```
## List of 5
##  $ l1: Named num 0.181
##   ..- attr(*, "names")= chr "TC"
##  $ l2: Named num 0.819
##   ..- attr(*, "names")= chr "TC"
##  $ p : num [1:999] 7.52 9.44 10.05 10.38 10.48 ...
##  $ p1: num [1:999] 89.6 64.4 50.4 41.5 35.3 ...
##  $ p2: num [1:999] 0 0 1.14 3.51 5 ...
```

##Inspecting the model fit (diagnostic II)

The model fit can be inspected using **getExpInterval**.

```
(support <- getExpInterval( model, bayes = TRUE ) )
```

![](data:image/png;base64...)

```
## $supportStart
## [1] 0.007
##
## $supportEnd
## [1] 0.98
```

The function returns two diagnostic plots. The first plot illustrates the estimated densities \(p\), \(p\_1\) and \(p\_2\), and log odds

\[
o=

The second plot shows the resulting posterior class probability, i.e. the probability that a given relative substitution frequency (RSF, horizontal axis) has been induced by PAR-CLIP. The area under the curve corresponding to the returned RSF interval is colored, and the RSF interval indicated. By default, **getExpInterval** returns the RSF interval according to the Bayes classifier, i.e. a posterior probability cutoff of 0.5. However, the user can specify a custom RSF interval:

1. By means of the **rightProb** and **leftProb** parameters, e.g.

   ```
   (support <- getExpInterval( model, bayes = FALSE, leftProb = 0.9, rightProb =   0.9 ) )
   ```

   ![](data:image/png;base64...)

   ```
   ## $supportStart
   ## [1] 0.076
   ##
   ## $supportEnd
   ## [1] 0.905
   ```
2. By inspecting the posterior class probability density and passing the RSF interval boundaries when calling high-confidence substitutions (see point 6).

Finally, the model can be used to produce further diagnostic plots. Particularly, the total number of reads exhibitng a given substitution and an RSF-based partitioning of genomic positions with substitutions can be obtained by

```
plotSubstitutions( countTable, highlight = "TC", model )
```

![](data:image/png;base64...)

##Selecting high-confidence PAR-CLIP induced transitions

The RSF support is used to filter all observed transitions to define a set of high-confidence, PAR-CLIP induced transitions. These are identified by **getHighConfSub**. The function returns a GRanges object with genomic position, strand, strand-specific coverage, occurence (count), and relative substitution frequency (rsf) for each high-confidence substitution. In a call to **getHighConfSub**, the RSF interval returned by **getExpInterval** can be supplied as `support` argument directly

```
highConfSub <- getHighConfSub( countTable,
                               support = support,
                               substitution = "TC" )
head( highConfSub )
```

```
## GRanges object with 6 ranges and 3 metadata columns:
##       seqnames    ranges strand |  coverage     count       rsf
##          <Rle> <IRanges>  <Rle> | <numeric> <integer> <numeric>
##   [1]     chrX  24001959      - |        17         2 0.1176471
##   [2]     chrX  24001973      - |        17        12 0.7058824
##   [3]     chrX  24001977      - |        13         1 0.0769231
##   [4]     chrX  24002046      - |        10         1 0.1000000
##   [5]     chrX  24002057      - |        10         6 0.6000000
##   [6]     chrX  24002147      - |        22         3 0.1363636
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

or, alternatively, by specifying `supportStart` and `supportEnd`, which define the range of RSF of interest.

```
highConfSub <- getHighConfSub( countTable,
                               supportStart = 0.2,
                               supportEnd = 0.7,
                               substitution = "TC" )
head( highConfSub )
```

##Identifying protein binding sites (clusters)

Binding sites (clusters) are identified by **getClusters**. The function takes high-confidence substitution sites and the coverage function

```
coverage <- coverage( Bam )
coverage$chrX
```

```
## integer-Rle of length 24023090 with 914 runs
##   Lengths: 24001818       15        2        5 ...        1       15       24
##   Values :        0        2        3        4 ...       21        0        1
```

as an input. From package version 2.0, cluster boundaries are resolved using the Mini-Rank Norm (MRN) [Comoglio et al., 2015](http://www.ncbi.nlm.nih.gov/pubmed/25638391), which is up to 10x faster and more sensitive than the previously adopted algorithm based on continuous wavelet transform of the coverage function [Sievers et al., 2012](http://www.ncbi.nlm.nih.gov/pubmed/22844102). Briefly, the MRN algorithm finds an optimal cluster boundary for each high-confidence substitution by solving an optimization problem that integrates prior knowledge on the geometry of PAR-CLIP clusters. Two options are available:

1. Hard thresholding, i.e. the coverage function is denoised using a global threshold. Empirically, `minCov=1` worked well on all tested datasets for which `minCov = 10`. Alternatively, 10% of the mode of the coverage distribution at high-confidence substitutions represents a possible choice.

   ```
   clusters <- getClusters( highConfSub = highConfSub,
                                   coverage = coverage,
                                   sortedBam = Bam,
                                   threshold = 1,
                                   cores = 1 )
   ```

   ```
   ## Computing start/end read positions
   ```

   ```
   ## Number of chromosomes exhibiting high confidence transitions: 1
   ```

   ```
   ## ...Processing = chrX
   ```

   ```
   clusters
   ```

   ```
   ## GRanges object with 184 ranges and 0 metadata columns:
   ##         seqnames            ranges strand
   ##            <Rle>         <IRanges>  <Rle>
   ##     [1]     chrX 24001953-24001975      -
   ##     [2]     chrX 24001953-24001976      -
   ##     [3]     chrX 24001953-24001977      -
   ##     [4]     chrX 24002044-24002057      -
   ##     [5]     chrX 24002044-24002057      -
   ##     ...      ...               ...    ...
   ##   [180]     chrX 24006559-24006573      -
   ##   [181]     chrX 24006560-24006565      -
   ##   [182]     chrX 24007061-24007068      -
   ##   [183]     chrX 24007061-24007083      -
   ##   [184]     chrX 24007061-24007083      -
   ##   -------
   ##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
   ```
2. Local thresholding, based on a global estimation of background levels via a Gaussian mixture model. Omitting the threshold parameter in the call to getClusters enables local thresholding

   ```
   clusters <- getClusters( highConfSub = highConfSub,
                                   coverage = coverage,
                                   sortedBam = Bam,
                                   cores = 1 )
   ```

   ```
   ## Computing start/end read positions
   ```

   ```
   ## Learning background threshold by fitting a GMM
   ```

   ```
   ##    Estimated threshold (% of maximum local coverage differences) from 184 sampled transitions: 5.26
   ```

   ```
   ## Number of chromosomes exhibiting high confidence transitions: 1
   ```

   ```
   ## ...Processing = chrX
   ```

   ```
   clusters
   ```

   ```
   ## GRanges object with 184 ranges and 0 metadata columns:
   ##         seqnames            ranges strand
   ##            <Rle>         <IRanges>  <Rle>
   ##     [1]     chrX 24001953-24001959      -
   ##     [2]     chrX 24001963-24001973      -
   ##     [3]     chrX 24001972-24001977      -
   ##     [4]     chrX 24002044-24002057      -
   ##     [5]     chrX 24002046-24002057      -
   ##     ...      ...               ...    ...
   ##   [180]     chrX 24006569-24006574      -
   ##   [181]     chrX 24006569-24006574      -
   ##   [182]     chrX 24007062-24007068      -
   ##   [183]     chrX 24007073-24007076      -
   ##   [184]     chrX 24007074-24007077      -
   ##   -------
   ##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
   ```

##Merging clusters

Once the clusters are identified, the corresponding genomic regions can be merged in a strand-specific manner. Statistics for each merged cluster (a wavCluster), can be computed using **filterClusters**.

```
require(BSgenome.Hsapiens.UCSC.hg19)
```

```
## Loading required package: BSgenome.Hsapiens.UCSC.hg19
```

```
## Loading required package: BSgenome
```

```
## Loading required package: BiocIO
```

```
## Loading required package: rtracklayer
```

```
wavclusters <- filterClusters( clusters = clusters,
                   highConfSub = highConfSub,
                   coverage = coverage,
                   model = model,
                   genome = Hsapiens,
                   refBase = "T",
                   minWidth = 12)
```

```
## Computing log odds...
```

```
## Refining cluster sizes...
```

```
## Combining clusters...
```

```
## Quantifying transitions within clusters...
```

```
## Computing statistics...
```

```
##
  |
  |==                                                                    |   2%
  |
  |===                                                                   |   5%
  |
  |=====                                                                 |   7%
  |
  |======                                                                |   9%
  |
  |========                                                              |  11%
  |
  |==========                                                            |  14%
  |
  |===========                                                           |  16%
  |
  |=============                                                         |  18%
  |
  |==============                                                        |  20%
  |
  |================                                                      |  23%
  |
  |==================                                                    |  25%
  |
  |===================                                                   |  27%
  |
  |=====================                                                 |  30%
  |
  |======================                                                |  32%
  |
  |========================                                              |  34%
  |
  |=========================                                             |  36%
  |
  |===========================                                           |  39%
  |
  |=============================                                         |  41%
  |
  |==============================                                        |  43%
  |
  |================================                                      |  45%
  |
  |=================================                                     |  48%
  |
  |===================================                                   |  50%
  |
  |=====================================                                 |  52%
  |
  |======================================                                |  55%
  |
  |========================================                              |  57%
  |
  |=========================================                             |  59%
  |
  |===========================================                           |  61%
  |
  |=============================================                         |  64%
  |
  |==============================================                        |  66%
  |
  |================================================                      |  68%
  |
  |=================================================                     |  70%
  |
  |===================================================                   |  73%
  |
  |====================================================                  |  75%
  |
  |======================================================                |  77%
  |
  |========================================================              |  80%
  |
  |=========================================================             |  82%
  |
  |===========================================================           |  84%
  |
  |============================================================          |  86%
  |
  |==============================================================        |  89%
  |
  |================================================================      |  91%
  |
  |=================================================================     |  93%
  |
  |===================================================================   |  95%
  |
  |====================================================================  |  98%
  |
  |======================================================================| 100%
```

```
## Consolidating results...
```

```
wavclusters
```

```
## GRanges object with 44 ranges and 7 metadata columns:
##        seqnames            ranges strand | Ntransitions   MeanCov NbasesInRef
##           <Rle>         <IRanges>  <Rle> |    <integer> <numeric>   <integer>
##    [1]     chrX 24001950-24001980      - |            3  14.87097          12
##    [2]     chrX 24002044-24002057      - |            2   9.64286           4
##    [3]     chrX 24002139-24002161      - |            3  21.95652           8
##    [4]     chrX 24002323-24002352      - |            4   9.76667          11
##    [5]     chrX 24002670-24002687      - |            3  14.33333           7
##    ...      ...               ...    ... .          ...       ...         ...
##   [40]     chrX 24005918-24005971      - |            5   15.1481          15
##   [41]     chrX 24006171-24006191      - |            3   11.1905           7
##   [42]     chrX 24006537-24006554      - |            3   32.0000           5
##   [43]     chrX 24006557-24006577      - |            3   26.8095           7
##   [44]     chrX 24007059-24007081      - |            3   16.3043           7
##        CrossLinkEff               Sequence SumLogOdds RelLogOdds
##           <numeric>            <character>  <numeric>  <numeric>
##    [1]         0.25 CGGCTTGGGAAAAATTACCT..    7.14200   0.595167
##    [2]         0.50         CTAGGATTATTTGA    4.97271   1.243178
##    [3]         0.38 TTAGGTAGAAAATAACCTCT..    7.45739   0.932174
##    [4]         0.36 AATATTGAAGTTATACGGTG..   10.53464   0.957695
##    [5]         0.43     TTAAATTATGAATTCTCA    7.79538   1.113626
##    ...          ...                    ...        ...        ...
##   [40]         0.33 CAATGTTAGACCAATGGCTT..   12.92271   0.861514
##   [41]         0.43  AGGATGGAATCGCTGTAATGA    7.46896   1.066995
##   [42]         0.60     GTGGAAGATGAGGTGATT    7.63260   1.526520
##   [43]         0.43  ACCGGTGATAAACAATTTGTT    7.45765   1.065378
##   [44]         0.43 TGCTGGTGAACATTCTGAAA..    8.29820   1.185456
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

The function takes as input the following elements:

* clusters
* high-confidence substitution sites
* genome-wide coverage
* mixture model
* a BSgenome object containing the correct reference sequence
* reference base expected to be converted by the experimental procedure
* minimum required width of a wavCluster

and it returns a GRanges object with the following metadata:

* number of high-confidence transitions (**Ntransitions**)
* mean coverage (**MeanCov**)
* number of bases in the reference genome of the same type as the specified `refBase` (**NbasesInRef**)
* the estimated cross-linking efficiency (**CrossLinkEff**), i.e. the ratio between **Ntransitions** and **NbasesInRef**
* the genomic sequence (**Sequence**)
* the sum of the log odds (**SumLogOdds**), contributed by each high-confidence transition within the cluster
* the relative log odds (**RelLogOdds**), i.e. the ratio between **SumLogOdds** and **Ntransitions**

The relative log odds can be used to rank clusters according to statistical confidence.

##Post-processing of the binding sites

**wavClusteR** provides a number of functions (summarized in the table below) for post-processing of the identified binding sites.

| Task | Function | Output format |
| --- | --- | --- |
| Export all identified substitutions or high-confidence substitutions | exportHighConfSub | BED |
| Export clusters | exportClusters | BED |
| Export coverage function | exportCoverage | BigWig |
| Visualize the size distribution of wavClusters | plotSizeDistribution | histogram |
| Annotate clusters with respect to genomic features (e.g. CDS, introns, 3’-UTRs, 5’-UTRs) in a strand-specific manner | annotateClusters | dot chart, vector |
| Compute metagene profiles of wavClusters, where the density of wavClusters is represented as a function of a reference genomic coordinates | getMetaGene | line plot, vector |
| Compute metaTSS profiles based on all aligned reads in the input BAM file |  | line plot, vector |
| Visualize wavClusteR statistics and meta data to learn pairwise relationships between variables | plotStatistics | pairs plot |

###Exporting substitutions, wavClusters and coverage function

High-confidence substitutions can be exported with

```
exportHighConfSub( highConfSub = highConfSub,
                   filename = "hcTC.bed",
                   trackname = "hcTC",
                   description = "hcTC" )
```

where `trackname` and `description` set the corresponding attributes in the UCSC BED file. By replacing `highConfSub` with another set of substitutions (e.g. all identified substitutions of a given type), those can be exported likewise.

wavClusters can be exported with

```
exportClusters( clusters = wavclusters,
                filename = "wavClusters.bed",
                trackname = "wavClusters",
                description = "wavClusters" )
```

and the coverage function can be exported with

```
exportCoverage( coverage = coverage, filename = "coverage.bigWig" )
```

###Annotating binding sites

wavClusters can be annotated with respect to genomic features using **annotateClusters**. This function generates a strand-specific dot chart representing wavClusters annotation. **annotateClusters** takes as an input the wavClusters and a transcriptDB object containing transcript annotations. The latter can be generated using **makeTxDbFromUCSC** (GenomicFeatures package)

```
txDB <- makeTxDbFromUCSC(genome = "hg19", tablename = "ensGene")
```

and is automatically downloaded by **annotateClusters** if missing.

Then, the annotateClusters can be called as follows

```
annotateClusters( clusters = wavclusters,
              txDB = txDB,
              plot = TRUE,
              verbose = TRUE)
```

Four dot charts are returned by the function showing the percentage of clusters mapping to different transcript features localized on the same (sense) or on the opposite (antisense) strand, the relative sequence length of different compartments relative to the total transcriptome length and the normalized enrichment of clusters across functional compartments.

Note: multiple hits, i.e. wavClusters that overlap with more than one genomic feature, are reported as “multiple”, whereas wavClusters that map outside of the considered features are labeled as “other”. The latter are then annotated with respect to features on the antisense strand.

###Computing cluster metagene profiles

A graphical representation of the density of wavClusters as a function of a binning of genomic coordinates across all annotated genes can be obtained using the **getMetaGene** function.

```
getMetaGene( clusters = wavclusters,
             txDB = txDB,
             upstream = 1e3,
             downstream = 1e3,
             nBins = 40,
             nBinsUD = 10,
             minLength = 1,
             plot = TRUE,
             verbose = TRUE )
```

In this example, genes were divided in 40 bins (`nBins`) and an `upstream`/`downstream` region spanning 1kb was considered. This region was subdivided in 10 bins (`nBinsUD`). No restriction on gene length was applied (`minLength`). **getMetaGene** returns a numeric vector of length `nBins` + 2\*`nBinsUD` with normalized counts, which can be used, for instance, to compare the distribution of wavClusters across several PAR-CLIP samples.

In addition to metagene profiles, meta transcription start site (TSS) profiles based on all mapped reads can be generated using **getMetaTSS**.

```
getMetaTSS( sortedBam = Bam,
            txDB = txDB,
            upstream = 1e3,
            downstream = 1e3,
            nBins = 40,
            unique = FALSE,
            plot = TRUE,
            verbose = TRUE )
```

Here, the `upstream` and `downstream` parameters control the width of the window to be considered, and `nBins` controls the resolution of the profile. If `unique=TRUE`, then overlapping windows are discarded. **getMetaTSS** returns a numeric vector of length `nBins` with normalized read counts.

###Computing the size distribution of wavClusters

The size distribution of wavClusters can be visualized by

```
plotSizeDistribution( clusters = wavclusters, showCov = TRUE, col = "skyblue2" )
```

```
## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

![](data:image/png;base64...)

###Visualizing wavCluster statistics and meta data

Cluster statistics can be plotted as pairs plot using

```
plotStatistics( clusters = wavclusters,
                corMethod = "spearman",
                lower = panel.smooth )
```

#Session Info

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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] BSgenome.Hsapiens.UCSC.hg19_1.4.3 BSgenome_1.78.0
##  [3] rtracklayer_1.70.0                BiocIO_1.20.0
##  [5] doMC_1.3.8                        iterators_1.0.14
##  [7] foreach_1.5.2                     wavClusteR_2.44.0
##  [9] Rsamtools_2.26.0                  Biostrings_2.78.0
## [11] XVector_0.50.0                    GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0                     IRanges_2.44.0
## [15] S4Vectors_0.48.0                  BiocGenerics_0.56.0
## [17] generics_0.1.4                    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                   bitops_1.0-9
##  [3] gridExtra_2.3               rlang_1.1.6
##  [5] magrittr_2.0.4              ade4_1.7-23
##  [7] matrixStats_1.5.0           compiler_4.5.1
##  [9] RSQLite_2.4.3               mgcv_1.9-3
## [11] GenomicFeatures_1.62.0      png_0.1-8
## [13] vctrs_0.6.5                 stringr_1.5.2
## [15] pkgconfig_2.0.3             crayon_1.5.3
## [17] fastmap_1.2.0               magick_2.9.0
## [19] backports_1.5.0             labeling_0.4.3
## [21] rmarkdown_2.30              tinytex_0.57
## [23] bit_4.6.0                   xfun_0.53
## [25] cachem_1.1.0                cigarillo_1.0.0
## [27] seqinr_4.2-36               jsonlite_2.0.0
## [29] blob_1.2.4                  DelayedArray_0.36.0
## [31] BiocParallel_1.44.0         cluster_2.1.8.1
## [33] R6_2.6.1                    bslib_0.9.0
## [35] stringi_1.8.7               RColorBrewer_1.1-3
## [37] rpart_4.1.24                jquerylib_0.1.4
## [39] Rcpp_1.1.0                  bookdown_0.45
## [41] SummarizedExperiment_1.40.0 knitr_1.50
## [43] base64enc_0.1-3             splines_4.5.1
## [45] Matrix_1.7-4                nnet_7.3-20
## [47] tidyselect_1.2.1            rstudioapi_0.17.1
## [49] dichromat_2.0-0.1           abind_1.4-8
## [51] yaml_2.3.10                 codetools_0.2-20
## [53] curl_7.0.0                  lattice_0.22-7
## [55] tibble_3.3.0                withr_3.0.2
## [57] Biobase_2.70.0              KEGGREST_1.50.0
## [59] S7_0.2.0                    evaluate_1.0.5
## [61] foreign_0.8-90              mclust_6.1.1
## [63] pillar_1.11.1               BiocManager_1.30.26
## [65] MatrixGenerics_1.22.0       checkmate_2.3.3
## [67] RCurl_1.98-1.17             ggplot2_4.0.0
## [69] scales_1.4.0                glue_1.8.0
## [71] Hmisc_5.2-4                 tools_4.5.1
## [73] data.table_1.17.8           GenomicAlignments_1.46.0
## [75] XML_3.99-0.19               grid_4.5.1
## [77] AnnotationDbi_1.72.0        colorspace_2.1-2
## [79] nlme_3.1-168                htmlTable_2.4.3
## [81] restfulr_0.0.16             Formula_1.2-5
## [83] cli_3.6.5                   S4Arrays_1.10.0
## [85] dplyr_1.1.4                 gtable_0.3.6
## [87] sass_0.4.10                 digest_0.6.37
## [89] SparseArray_1.10.0          rjson_0.2.23
## [91] htmlwidgets_1.6.4           farver_2.1.2
## [93] memoise_2.0.1               htmltools_0.5.8.1
## [95] lifecycle_1.0.4             httr_1.4.7
## [97] bit64_4.6.0-1               MASS_7.3-65
```

#References

Comoglio, F., Sievers, C. & Paro, R. (2015) Sensitive and highly resolved inidentification of RNA-protein interaction sites in PAR-CLIP data. BMC Bioinformatics, 16, 32

Langmead,B., Trapnell,C., Pop,M. & Salzberg,S.L. (2009)
Ultrafast and memory-efficient alignment of short DNA sequences to the human genome. Genome Biol 10, R25

Kishore, S. et al. (2011)
A quantitative analysis of CLIP methods for identifying binding sites of RNA-binding proteins. Nature Methods 8(7), 559-564

Sievers, C., Schlumpf, T., Sawarkar, R., Comoglio, F. & Paro, R. (2012) Mixture models and wavelet transforms reveal high confidence RNA-protein interaction sites in MOV10 PAR-CLIP data. Nucleic Acids Res 40(2), e160