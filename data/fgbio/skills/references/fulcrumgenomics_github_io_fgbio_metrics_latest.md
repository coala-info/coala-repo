# fgbio

Tools for working with genomic and high throughput sequencing data.

[View the Project on GitHub](https://github.com/fulcrumgenomics/fgbio)

* [Download **ZIP File**](https://github.com/fulcrumgenomics/fgbio/zipball/gh-pages)
* [Download **TAR Ball**](https://github.com/fulcrumgenomics/fgbio/tarball/gh-pages)
* [View On **GitHub**](https://github.com/fulcrumgenomics/fgbio)

# fgbio Metrics Descriptions

This page contains descriptions of all metrics produced by all fgbio tools. Within the descriptions
the type of each field/column is given, including two commonly used types:

* `Count` is an integer representing the count of some item
* `Proportion` is a real number with a value between 0 and 1 representing a proportion or fraction

## Table of Contents

| Metric Type | Description |
| --- | --- |
| [Amplicon](#amplicon) | A Locatable Amplicon class |
| [AssessPhasingMetric](#assessphasingmetric) | Metrics produced by `AssessPhasing` describing various statistics assessing the performance of phasing variants relative to a known set of phased variant calls |
| [AssignPrimersMetric](#assignprimersmetric) | Metrics produced by `AssignPrimers` that detail how many reads were assigned to a given primer and/or amplicon |
| [CallOverlappingConsensusBasesMetric](#calloverlappingconsensusbasesmetric) | Collects the the number of reads or bases that were examined, had overlap, and were corrected as part of the CallOverlappingConsensusBases tool |
| [ClippingMetrics](#clippingmetrics) | Metrics produced by ClipBam that detail how many reads and bases are clipped respectively |
| [ConsensusKvMetric](#consensuskvmetric) | Metric class for outputting consensus calling statistics |
| [ConsensusVariantReviewInfo](#consensusvariantreviewinfo) | Detailed information produced by `ReviewConsensusVariants` on variants called in consensus reads |
| [DuplexFamilySizeMetric](#duplexfamilysizemetric) | Metrics produced by `CollectDuplexSeqMetrics` to describe the distribution of double-stranded (duplex) tag families in terms of the number of reads observed on each strand |
| [DuplexUmiMetric](#duplexumimetric) | Metrics produced by `CollectDuplexSeqMetrics` describing the set of observed duplex UMI sequences and the frequency of their observations |
| [DuplexYieldMetric](#duplexyieldmetric) | Metrics produced by `CollectDuplexSeqMetrics` that are sampled at various levels of coverage, via random downsampling, during the construction of duplex metrics |
| [ErccDetailedMetric](#erccdetailedmetric) | Metrics produced by `CollectErccMetrics` describing various per-transcript metrics related to the spike-in of ERCC (External RNA Controls Consortium) into an RNA-Seq experiment |
| [ErccSummaryMetrics](#erccsummarymetrics) | Metrics produced by `CollectErccMetrics` describing various summary metrics related to the spike-in of ERCC (External RNA Controls Consortium) into an RNA-Seq experiment |
| [ErrorRateByReadPositionMetric](#errorratebyreadpositionmetric) | Metrics produced by `ErrorRateByReadPosition` describing the number of base observations and substitution errors at each position within each sequencing read |
| [FamilySizeMetric](#familysizemetric) | Metrics produced by `CollectDuplexSeqMetrics` to quantify the distribution of different kinds of read family sizes |
| [FgBioToolInfo](#fgbiotoolinfo) | Stores meta information about the command line use to invoke a tool |
| [InsertSizeMetric](#insertsizemetric) | Metrics produced by `EstimateRnaSeqInsertSize` to describe the distribution of insert sizes within an RNA-seq experiment |
| [PhaseBlockLengthMetric](#phaseblocklengthmetric) | Metrics produced by `AssessPhasing` describing the number of phased blocks of a given length |
| [PoolingFractionMetric](#poolingfractionmetric) | Metrics produced by `EstimatePoolingFractions` to quantify the estimated proportion of a sample mixture that is attributable to a specific sample with a known set of genotypes |
| [RunInfo](#runinfo) | Stores the result of parsing the run info (RunInfo |
| [SampleBarcodeMetric](#samplebarcodemetric) | Metrics for matching templates to sample barcodes primarily used in com |
| [SwitchMetric](#switchmetric) | Summary metrics regarding switchback reads found |
| [TagFamilySizeMetric](#tagfamilysizemetric) | Metrics produced by `GroupReadsByUmi` to describe the distribution of tag family sizes observed during grouping |
| [UmiCorrectionMetrics](#umicorrectionmetrics) | Metrics produced by `CorrectUmis` regarding the correction of UMI sequences to a fixed set of known UMIs |
| [UmiGroupingMetric](#umigroupingmetric) | Metrics produced by `GroupReadsByUmi` to describe reads passed through UMI grouping |
| [UmiMetric](#umimetric) | Metrics produced by `CollectDuplexSeqMetrics` describing the set of observed UMI sequences and the frequency of their observations |

## Metric File Descriptions

### Amplicon

A Locatable Amplicon class.

| Column | Type | Description |
| --- | --- | --- |
| chrom | String | The chromosome for the amplicon |
| left\_start | Int | The 1-based start position of the left-most primer |
| left\_end | Int | The 1-based end position inclusive of the left-most primer |
| right\_start | Int | The 1-based start position of the right-most primer |
| right\_end | Int | The 1-based end position inclusive of the right-most primer |
| id | Option[String] |  |

### AssessPhasingMetric

Metrics produced by `AssessPhasing` describing various statistics assessing the performance of phasing variants
relative to a known set of phased variant calls. Included are methods for assessing sensitivity and accuracy from
a number of previous papers (ex. http://dx.doi.org/10.1038%2Fng.3119).The N50, N90, and L50 statistics are defined as follows:

* The N50 is the longest block length such that the bases covered by all blocks this length and longer are at least
  50% of the # of bases covered by all blocks.
* The N90 is the longest block length such that the bases covered by all blocks this length and longer are at least
  90% of the # of bases covered by all blocks.
* The L50 is the smallest number of blocks such that the sum of the lengths of the blocks is `>=` 50% of the sum of
  the lengths of all blocks.

| Column | Type | Description |
| --- | --- | --- |
| num\_called | Long | The number of variants called. |
| num\_phased | Long | The number of variants called with phase. |
| num\_truth | Long | The number of variants with known truth genotypes. |
| num\_truth\_phased | Long | The number of variants with known truth genotypes with phase. |
| num\_called\_with\_truth\_phased | Long | The number of variants called that had a known phased genotype. |
| num\_phased\_with\_truth\_phased | Long | The number of variants called with phase that had a known phased genotype. |
| num\_truth\_phased\_in\_called\_block | Long | The number of known phased variants that were in a called phased block. |
| num\_both\_phased\_in\_called\_block | Long | The number of called phase variants that had a known phased genotype in a called phased block. |
| num\_short\_switch\_errors | Long | The number of short switch errors (isolated switch errors). |
| num\_long\_switch\_errors | Long | The number of long switch errors (# of runs of consecutive switch errors). |
| num\_switch\_sites | Long | The number of sites that could be (short or long) switch errors (i.e. the # of sites with both known and called phased variants). |
| num\_illumina\_point\_switch\_errors | Long | The number of point switch errors (defined in http://dx.doi.org/10.1038%2Fng.3119). |
| num\_illumina\_long\_switch\_errors | Long | The number of long switch errors (defined in http://dx.doi.org/10.1038%2Fng.3119). |
| num\_illumina\_switch\_sites | Long | The number of sites that could be (point or long) switch errors (defined in http://dx.doi.org/10.1038%2Fng.3119). |
| frac\_phased | Double | The fraction of called variants with phase. |
| frac\_phased\_with\_truth\_phased | Double | The fraction of known phased variants called with phase. |
| frac\_truth\_phased\_in\_called\_block | Double | The fraction of phased known genotypes in a called phased block. |
| frac\_phased\_with\_truth\_phased\_in\_called\_block | Double | The fraction of called phased variants that had a known phased genotype in a called phased block. |
| short\_accuracy | Double | The fraction of switch sites without short switch errors (`1 - (num_short_switch_errors / num_switch_sites)`). |
| long\_accuracy | Double | The fraction of switch sites without long switch errors (`1 - (num_long_switch_errors / num_switch_sites)`). |
| illumina\_point\_accuracy | Double | The fraction of switch sites without point switch errors according to the Illumina method defining switch sites and errors (`1 - (num_illumina_point_switch_errors / num_illumina_switch_sites )`). |
| illumina\_long\_accuracy | Double | The fraction of switch sites wihtout long switch errors according to the Illumina method defining switch sites and errors (`1 - (num_illumina_long_switch_errors / num_illumina_switch_sites )`). |
| mean\_called\_block\_length | Double | The mean phased block length in the callset. |
| median\_called\_block\_length | Double | The median phased block length in the callset. |
| stddev\_called\_block\_length | Double | The standard deviation of the phased block length in the callset. |
| n50\_called\_block\_length | Double | The N50 of the phased block length in the callset. |
| n90\_called\_block\_length | Double | The N90 of the phased block length in the callset. |
| l50\_called | Double | The L50 of the phased block length in the callset. |
| mean\_truth\_block\_length | Double | The mean phased block length in the truth. |
| median\_truth\_block\_length | Double | The median phased block length in the truth. |
| stddev\_truth\_block\_length | Double | The standard deviation of the phased block length in the truth. |
| n50\_truth\_block\_length | Double | The N50 of the phased block length in the truth. |
| n90\_truth\_block\_length | Double | The N90 of the phased block length in the callset. |
| l50\_truth | Double | The L50 of the phased block length in the callset. |

### AssignPrimersMetric

Metrics produced by `AssignPrimers` that detail how many reads were assigned to a given primer and/or amplicon.

| Column | Type | Description |
| --- | --- | --- |
| identifier | String | The amplicon identifier this metric collects over |
| left | Long | The number of reads assigned to the left primer |
| right | Long | The number of reads assigned to the right primer |
| r1s | Long | The number of R1 reads assigned to this amplicon |
| r2s | Long | The number of R2 reads assigned to this amplicon |
| pairs | Long | The number of read pairs where R1 and R2 are both assigned to the this amplicon and are in FR orientation |
| frac\_left | Double | The fraction of reads assigned to the left primer |
| frac\_right | Double | The fraction of reads assigned to the right primer |
| frac\_r1s | Double | The fraction of R1s reads assigned to this amplicon |
| frac\_r2s | Double | The fraction of R2s reads assigned to this amplicon |
| frac\_pairs | Double | The fraction of read pairs where R1 and R2 are both assigned to the this amplicon and are in FR orientation |

### CallOverlappingConsensusBasesMetric

Collects the the number of reads or bases that were examined, had overlap, and were corrected as part of
the CallOverlappingConsensusBases tool.

| Column | Type | Description |
| --- | --- | --- |
| kind | CountKind | Template if the counts are per template, bases if counts are in units of bases. |
| total | Long | The total number of templates (bases) examined |
| overlapping | Long | The total number of templates (bases) that were overlapping |
| corrected | Long | The total number of templates (bases) that were corrected. |

### ClippingMetrics

Metrics produced by ClipBam that detail how many reads and bases are clipped respectively.

| Column | Type | Description |
| --- | --- | --- |
| read\_type | ReadType | The type of read (i.e. Fragment, ReadOne, ReadTwo). |
| reads | Long | The number of reads examined. |
| reads\_unmapped | Long | The number of reads that became unmapped due to clipping. |
| reads\_clipped\_pre | Long | The number of reads with any type of clipping prior to clipping with ClipBam. |
| reads\_clipped\_post | Long | The number of reads with any type of clipping after clipping with ClipBam, including reads that became unmapped. |
| reads\_clipped\_five\_prime | Long | The number of reads with the 5’ end clipped. |
| reads\_clipped\_three\_prime | Long | The number of reads with the 3’ end clipped. |
| reads\_clipped\_overlapping | Long | The number of reads clipped due to overlapping reads. |
| reads\_clipped\_extending | Long | The number of reads clipped due to a read extending past its mate. |
| bases | Long | The number of aligned bases after clipping. |
| bases\_clipped\_pre | Long | The number of bases clipped prior to clipping with ClipBam. |
| bases\_clipped\_post | Long | The number of bases clipped after clipping with ClipBam, including bases from reads that became unmapped. |
| bases\_clipped\_five\_prime | Long | The number of bases clipped on the 5’ end of the read. |
| bases\_clipped\_three\_prime | Long | The number of bases clipped on the 3 end of the read. |
| bases\_clipped\_overlapping | Long | The number of bases clipped due to overlapping reads. |
| bases\_clipped\_extending | Long | The number of bases clipped due to a read extending past its mate. |

### ConsensusKvMetric

Metric class for outputting consensus calling statistics.

| Column | Type | Description |
| --- | --- | --- |
| key | String |  |
| value | Any |  |
| description | String |  |

### ConsensusVariantReviewInfo

Detailed information produced by `ReviewConsensusVariants` on variants called in consensus reads. Each
row contains information about a consensus *read* that carried a variant or non-reference allele at a
particular variant site.The first 10 columns (up to `N`) contain information about the variant site and are repeated for each
consensus read reported at that site. The remaining fields are specific to the consensus read.

| Column | Type | Description |
| --- | --- | --- |
| chrom | String | The chromosome on which the variant exists. |
| pos | Int | The position of the variant. |
| ref | String | The reference allele at the position. |
| genotype | String | The genotype of the sample in question. |
| filters | String | The set of filters applied to the variant in the VCF. |
| A | Int | The count of A observations at the variant locus across all consensus reads. |
| C | Int | The count of C observations at the variant locus across all consensus reads. |
| G | Int | The count of G observations at the variant locus across all consensus reads. |
| T | Int | The count of T observations at the variant locus across all consensus reads. |
| N | Int | The count of N observations at the variant