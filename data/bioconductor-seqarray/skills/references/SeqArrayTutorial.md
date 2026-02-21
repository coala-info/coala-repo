# SeqArray Data Format and Access

#### Xiuwen Zheng (Department of Biostatistics, University of Washington, Seattle)

#### Sep 15, 2016

* [1 Overview](#overview)
  + [1.1 Parallel Computing](#parallel-computing)
  + [1.2 Application Program Interface (API)](#application-program-interface-api)
* [2 Preparing Data](#preparing-data)
  + [2.1 Data Format used in SeqArray](#data-format-used-in-seqarray)
  + [2.2 Format Conversion from VCF Files](#format-conversion-from-vcf-files)
  + [2.3 Export to VCF Files](#export-to-vcf-files)
  + [2.4 Modification](#modification)
* [3 Data Processing](#data-processing)
  + [3.1 Functions for Data Analysis](#functions-for-data-analysis)
  + [3.2 Get Data](#get-data)
  + [3.3 Apply Functions Over Array Margins](#apply-functions-over-array-margins)
  + [3.4 Apply Functions in Parallel](#apply-functions-in-parallel)
* [4 Examples](#examples)
  + [4.1 The performance of seqApply](#the-performance-of-seqapply)
  + [4.2 Missing Rates for Variants](#missing-rates-for-variants)
    - [4.2.1 seqApply](#seqapply)
    - [4.2.2 C++ Integration](#c-integration)
    - [4.2.3 seqBlockApply](#seqblockapply)
    - [4.2.4 seqBlockApply + Parallel](#seqblockapply-parallel)
    - [4.2.5 seqMissing](#seqmissing)
  + [4.3 Missing Rates for Samples](#missing-rates-for-samples)
    - [4.3.1 seqApply](#seqapply-1)
    - [4.3.2 C++ Integration](#c-integration-1)
    - [4.3.3 seqBlockApply](#seqblockapply-1)
    - [4.3.4 seqBlockApply + Parallel](#seqblockapply-parallel-1)
    - [4.3.5 seqMissing](#seqmissing-1)
  + [4.4 Allele Frequency](#allele-frequency)
    - [4.4.1 seqApply](#seqapply-2)
    - [4.4.2 C++ Integration](#c-integration-2)
    - [4.4.3 seqBlockApply](#seqblockapply-2)
    - [4.4.4 seqBlockApply + Parallel](#seqblockapply-parallel-2)
    - [4.4.5 seqAlleleFreq](#seqallelefreq)
  + [4.5 Principal Component Analysis](#principal-component-analysis)
    - [4.5.1 seqApply](#seqapply-3)
    - [4.5.2 seqBlockApply](#seqblockapply-3)
    - [4.5.3 Multi-process Implementation](#multi-process-implementation)
  + [4.6 Individual Inbreeding Coefficient](#individual-inbreeding-coefficient)
    - [4.6.1 seqApply](#seqapply-4)
    - [4.6.2 seqBlockApply](#seqblockapply-4)
    - [4.6.3 Multi-process Implementation](#multi-process-implementation-1)
* [5 Resources](#resources)
* [6 Session Information](#session-information)
* [References](#references)

.

.

.

# 1 Overview

The SeqArray file format is built on top of the Genomic Data Structure (GDS) format (Zheng et al. 2012). GDS is a flexible and scalable data container with a hierarchical structure that can store multiple array-oriented data sets. It is intended for use with large-scale genomic datasets, especially for those which are much larger than the available main memory. GDS provides memory and performance efficient operations specifically designed for integers of less than 8 bits, since a diploid genotype usually occupies fewer bits than a byte. Data compression and decompression are available with relatively efficient random access. Data compression and decompression are available with relatively efficient random access. GDS is implemented using an optimized C++ library (CoreArray, <http://corearray.sourceforge.net>) and a high-level R interface is provided by the platform-independent R package gdsfmt (<http://bioconductor.org/packages/gdsfmt>). Figure 1 shows the relationship between a SeqArray file and the underlying infrastructure upon which it is built. The minimum data fields required in a SeqArray file are sample and variant identifiers, variant chromosome, position and allele values and the value of the variant itself. SeqArray is a Bioconductor package (Gentleman et al. 2004; R Core Team 2016) available at <http://www.bioconductor.org/packages/SeqArray> under the GNU General Public License v3.

.

![](data:image/svg+xml;base64...)

**Figure 1**: SeqArray framework and flowchart. The SeqArray format is built on top of the Genomic Data Structure (GDS) format, and GDS is a generic data container with hierarchical structure for storing multiple array-oriented data sets. A high-level R interface to GDS files is provided in the gdsfmt package with a C++ library, and the SeqArray package offers functionalities specific to sequencing data. At a minimum a SeqArray file contains sample and variant identifiers, position, chromosome, reference and alternate alleles for each variant. Parallel computing environments, like multi-core computer clusters, are enabled with SeqArray. The functionality of SeqArray is extended by SeqVarTools, SNPRelate, GENESIS and other R/Bioconductor packages for WGS analyses.

.

SeqArray stores genotypes in a 2-bit array with ploidy, sample and variant dimensions. If two bits cannot represent all alleles at a site, a 2-bit matrix is appended to store additional bits according to the variant coordinate, hence any number of alleles can be stored including missing value. An indexing vector, associated with genotypes, is used to indicate how many bits for each variant. The INFO and FORMAT annotations in a SeqArray file can be integers, floating point numbers and characters. For a variant, variable-length vectors in an annotation are padded with missing values, and all vectors are packed together in an array. If each variant has different length, an extra vector is used to store the length information.

Multiple lossless compression methods are available in the SeqArray format, and users can select the Lempel-Ziv Markov chain (LZMA) algorithm to compress data instead of the zlib algorithm. LZMA has a higher compression ratio than zlib and is implemented in a command-line tool `xz` (<https://tukaani.org/xz/>) with a C library `liblzma`. Internally, the C++ kernel links to `liblzma` and calls the deflate and inflate functions. A new compression algorithm could be incorporated to the SeqArray format without changing the application program interface.

To enable efficient random access of compressed data, a storage strategy using independent compression data blocks is employed and an indexing strategy is maintained internally. A fast performance for data filtering could be obtained since not all data have to be decompressed.

## 1.1 Parallel Computing

SeqArray utilizes the framework implemented in the R core package `parallel` (Rossini, Tierney, and Li 2007; R Core Team 2016) to support multiple forms of parallelism. First, multi-core parallelism on symmetric multiprocessing (SMP) computer architectures is supported via lightweight forking on Unix-like systems. Second, job-level parallelism on loosely coupled computer clusters is supported with communicating over sockets or Message Passing Interface (MPI). Most importantly, all of these forms of parallelism can be combined together allowing high-speed access and operations on hundreds of different parts of the genome simultaneously.

For data writing with multiple processes, SeqArray stores data in separate local files according to each process and merges all files together when the processes finish. Since data are stored in independent blocks, merging files could be as easy as copying data directly without re-compression.

## 1.2 Application Program Interface (API)

.

**Table 1**: The key functions in the SeqArray package.

| Function | Description |
| --- | --- |
| seqVCF2GDS | Reformat VCF files. [»](https://rdrr.io/bioc/SeqArray/man/seqVCF2GDS.html) |
| seqSetFilter | Define a data subset of samples or variants. [»](https://rdrr.io/bioc/SeqArray/man/seqSetFilter.html) |
| seqGetData | Get data from a SeqArray file with a defined filter. [»](https://rdrr.io/bioc/SeqArray/man/seqGetData.html) |
| seqApply | Apply a user-defined function over array margins. [»](https://rdrr.io/bioc/SeqArray/man/seqApply.html) |
| seqParallel | Apply functions in parallel. [»](https://rdrr.io/bioc/SeqArray/man/seqParallel.html) |

.

Genotypic data and annotations are stored in an array-oriented manner, providing efficient data access using the R programming language. There are five key functions in SeqArray as shown in Table 1, and many of data analyses can be done using just these functions.

`seqVCF2GDS()` converts VCF format files to SeqArray. Multiple cores within one or more compute nodes in a compute cluster can be used to simultaneously to reformat data. Since `seqVCF2GDS()` utilizes R’s connection interface to read VCF files incrementally, it is able to import data from http/ftp texts and any other data source from a pipe with a command-line tool.

`seqSetFilter()` and `seqGetData()` can be used together to retrieve data for a selected set of samples from a defined genomic region. `GRange` and `GRangesList` objects defined in the Bioconductor core packages are supported via `seqSetFilter()` (Gentleman et al. 2004; Lawrence et al. 2013).

`seqApply()` applies a user-defined function to margins of genotypes and annotations. The function that is applied can be defined in R as is typical, or via C/C++ code using the Rcpp package (Eddelbuettel et al. 2011).

`seqParallel()` utilizes the facilities offered by the parallel package (Rossini, Tierney, and Li 2007; R Core Team 2016) to perform calculations on a SeqArray file in parallel. The examples using these key functions are shown in the section of R integration.

.

.

.

.

.

.

.

# 2 Preparing Data

```
# load the R package SeqArray
library(SeqArray)

library(Rcpp)
```

## 2.1 Data Format used in SeqArray

Let us use the GDS file in the SeqArray package:

```
gds.fn <- seqExampleFileName("gds")
# or gds.fn <- "C:/YourFolder/Your_GDS_File.gds"
gds.fn
```

```
## [1] "/tmp/RtmpXPTVOy/Rinst2e71e94b082247/SeqArray/extdata/CEU_Exon.gds"
```

```
seqSummary(gds.fn)
```

```
## Open 'CEU_Exon.gds'
## File: /tmp/RtmpXPTVOy/Rinst2e71e94b082247/SeqArray/extdata/CEU_Exon.gds
## Format Version: v1.0
## Reference: human_b36_both.fasta
## Ploidy: 2
## Number of samples: 90
## Number of variants: 1,348
## Chromosomes:
##     chr1 : 142, chr2 : 59 , chr3 : 81 , chr4 : 48 , chr5 : 61 , chr6 : 99
##     chr7 : 58 , chr8 : 51 , chr9 : 29 , chr10: 70 , chr11: 16 , chr12: 62
##     chr13: 11 , chr14: 61 , chr15: 46 , chr16: 84 , chr17: 100, chr18: 54
##     chr19: 111, chr20: 59 , chr21: 23 , chr22: 23
## Alleles:
##     ALT: <None>
##     tabulation: 2, 1346(99.9%); 3, 2(0.1%)
## Annotation, Quality:
##     Min: NA, 1st Qu: NA, Median: NA, Mean: NaN, 3rd Qu: NA, Max: NA, NA's: 1348
## Annotation, FILTER:
##     PASS, All filters passed, 1348(100.0%)
##     q10, Quality below 10, 0(0.0%)
## Annotation, INFO variable(s):
##     AA, ., String, Ancestral Allele
##     AC, 1, Integer, Total number of alternate alleles in called genotypes
##     AN, 1, Integer, Total number of alleles in called genotypes
##     DP, 1, Integer, Total Depth
##     HM2, 0, Flag, HapMap2 membership
##     HM3, 0, Flag, HapMap3 membership
##     OR, 1, String, Previous rs number
##     GP, 1, String, GRCh37 position(s)
##     BN, ., Integer, First dbSNP build #
## Annotation, FORMAT variable(s):
##     GT, 1, String, Genotype
##     DP, ., Integer, Read Depth from MOSAIK BAM
## Annotation, sample variable(s):
##     family, String, <NA>
```

`seqExampleFileName()` returns the file name of a GDS file of SeqArray format used as an example in [SeqArray](http://www.bioconductor.org/packages/release/bioc/html/SeqArray.html), and it is a subset of data from the 1000 Genomes Project. `seqSummary()` summarizes the genotypes and annotations.

```
# open a GDS file
genofile <- seqOpen(gds.fn)

# display the contents of the SeqArray file in a hierarchical structure
genofile
```

```
## Object of class "SeqVarGDSClass"
## File: /tmp/RtmpXPTVOy/Rinst2e71e94b082247/SeqArray/extdata/CEU_Exon.gds (287.6K)
## +    [  ] *
## |--+ description   [  ] *
## |--+ sample.id   { Str8 90 LZMA_ra(34.7%), 257B } *
## |--+ variant.id   { Int32 1348 LZMA_ra(16.7%), 905B } *
## |--+ position   { Int32 1348 LZMA_ra(64.4%), 3.4K } *
## |--+ chromosome   { Str8 1348 LZMA_ra(4.39%), 157B } *
## |--+ allele   { Str8 1348 LZMA_ra(16.6%), 901B } *
## |--+ genotype   [  ] *
## |  |--+ data   { Bit2 2x90x1348 LZMA_ra(26.3%), 15.6K } *
## |  |--+ ~data   { Bit2 2x1348x90 LZMA_ra(29.2%), 17.3K } *
## |  |--+ extra.index   { Int32 3x0 LZMA_ra, 18B } *
## |  \--+ extra   { Int16 0 LZMA_ra, 18B }
## |--+ phase   [  ]
## |  |--+ data   { Bit1 90x1348 LZMA_ra(0.86%), 137B } *
## |  |--+ ~data   { Bit1 1348x90 LZMA_ra(0.86%), 137B } *
## |  |--+ extra.index   { Int32 3x0 LZMA_ra, 18B } *
## |  \--+ extra   { Bit1 0 LZMA_ra, 18B }
## |--+ annotation   [  ]
## |  |--+ id   { Str8 1348 LZMA_ra(38.3%), 5.5K } *
## |  |--+ qual   { Float32 1348 LZMA_ra(2.11%), 121B } *
## |  |--+ filter   { Int32,factor 1348 LZMA_ra(2.11%), 121B } *
## |  |--+ info   [  ]
## |  |  |--+ AA   { Str8 1328 LZMA_ra(22.1%), 593B } *
## |  |  |--+ AC   { Int32 1348 LZMA_ra(24.1%), 1.3K } *
## |  |  |--+ AN   { Int32 1348 LZMA_ra(19.6%), 1.0K } *
## |  |  |--+ DP   { Int32 1348 LZMA_ra(47.7%), 2.5K } *
## |  |  |--+ HM2   { Bit1 1348 LZMA_ra(145.6%), 253B } *
## |  |  |--+ HM3   { Bit1 1348 LZMA_ra(145.6%), 253B } *
## |  |  |--+ OR   { Str8 1348 LZMA_ra(19.6%), 341B } *
## |  |  |--+ GP   { Str8 1348 LZMA_ra(24.3%), 3.8K } *
## |  |  \--+ BN   { Int32 1348 LZMA_ra(20.7%), 1.1K } *
## |  \--+ format   [  ]
## |     \--+ DP   [  ] *
## |        |--+ data   { VL_Int 90x1348 LZMA_ra(70.8%), 115.2K } *
## |        \--+ ~data   { VL_Int 1348x90 LZMA_ra(65.1%), 105.9K } *
## \--+ sample.annotation   [  ]
##    \--+ family   { Str8 90 LZMA_ra(55.0%), 221B } *
```

For those who would like to know how variable-length genotypic data and annotations are stored in an array-oriented manner, `print(..., all=TRUE)` displays all contents including hidden structures:

```
# display all contents of the GDS file
print(genofile, all=TRUE, attribute=TRUE)
```

```
## File: /tmp/RtmpXPTVOy/Rinst2e71e94b082247/SeqArray/extdata/CEU_Exon.gds (287.6K)
## +    [  ] *< FileFormat: SEQ_ARRAY; FileVersion:      v1.0
## |--+ description   [  ] *< vcf.fileformat: VCFv4.0
## |  \--+ reference   { Str8 1 LZMA_RA.def:256K(447.6%), 101B } *< R.invisible:
## |--+ sample.id   { Str8 90 LZMA_RA.def:256K(34.7%), 257B } *< md5: ac460b05....
## |--+ variant.id   { Int32 1348 LZMA_RA.def:256K(16.7%), 905B } *< md5: c9602a54....
## |--+ position   { Int32 1348 LZMA_RA.def:256K(64.4%), 3.4K } *< md5: a23801be....
## |--+ chromosome   { Str8 1348 LZMA_RA.def:256K(4.39%), 157B } *< md5: a46ad552....
## |--+ @chrom_rle_val   { Str8 22, 57B } *< R.invisible:
## |--+ @chrom_rle_len   { Int32 22, 88B } *< R.invisible:
## |--+ allele   { Str8 1348 LZMA_RA.def:256K(16.6%), 901B } *< md5: e65988a3....
## |--+ genotype   [  ] *< VariableName:       GT; Description: Genotype
## |  |--+ data   { Bit2 2x90x1348 LZMA_RA.def:256K(26.3%), 15.6K } *< md5: 318c71bd....
## |  |--+ ~data   { Bit2 2x1348x90 LZMA_RA.def:256K(29.2%), 17.3K } *< md5: beec95b3....
## |  |--+ @data   { UInt8 1348 LZMA_RA.def:256K(6.97%), 101B } *< R.invisible:             ; md5: e4bff5c5....
## |  |--+ extra.index   { Int32 3x0 LZMA_RA.def:256K, 18B } *< R.colnames: sample.i....
## |  \--+ extra   { Int16 0 LZMA_RA.def:256K, 18B }
## |--+ phase   [  ]
## |  |--+ data   { Bit1 90x1348 LZMA_RA.def:256K(0.86%), 137B } *< md5: 48731073....
## |  |--+ ~data   { Bit1 1348x90 LZMA_RA.def:256K(0.86%), 137B } *< md5: 48731073....
## |  |--+ extra.index   { Int32 3x0 LZMA_RA.def:256K, 18B } *< R.colnames: sample.i....
## |  \--+ extra   { Bit1 0 LZMA_RA.def:256K, 18B }
## |--+ annotation   [  ]
## |  |--+ id   { Str8 1348 LZMA_RA.def:256K(38.3%), 5.5K } *< md5: 164df6a9....
## |  |--+ qual   { Float32 1348 LZMA_RA.def:256K(2.11%), 121B } *< md5: ff3b3c51....
## |  |--+ filter   { Int32,factor 1348 LZMA_RA.def:256K(2.11%), 121B } *< R.class:       factor; R.levels:    PASS, q10; Description: All filt....; md5: 5b09a6e5....
## |  |--+ info   [  ]
## |  |  |--+ AA   { Str8 1328 LZMA_RA.def:256K(22.1%), 593B } *< Number:            .; Type:       String; Description: Ancestra....; md5: 06536fe9....
## |  |  |--+ @AA   { Int32 1348 LZMA_RA.def:256K(2.49%), 141B } *< R.invisible:             ; md5: 0ed7325a....
## |  |  |--+ AC   { Int32 1348 LZMA_RA.def:256K(24.1%), 1.3K } *< Number:            1; Type:      Integer; Description: Total nu....; md5: 79076139....
## |  |  |--+ AN   { Int32 1348 LZMA_RA.def:256K(19.6%), 1.0K } *< Number:            1; Type:      Integer; Description: Total nu....; md5: b4c30546....
## |  |  |--+ DP   { Int32 1348 LZMA_RA.def:256K(47.7%), 2.5K } *< Number:            1; Type:      Integer; Description:  Total Depth; md5: 9f358649....
## |  |  |--+ HM2   { Bit1 1348 LZMA_RA.def:256K(145.6%), 253B } *< Number:            0; Type:         Flag; Description: HapMap2 ....; md5: 9b792cdd....
## |  |  |--+ HM3   { Bit1 1348 LZMA_RA.def:256K(145.6%), 253B } *< Number:            0; Type:         Flag; Description: HapMap3 ....; md5: b936dc73....
## |  |  |--+ OR   { Str8 1348 LZMA_RA.def:256K(19.6%), 341B } *< Number:            1; Type:       String; Description: Previous....; md5: 6f6f800d....
## |  |  |--+ GP   { Str8 1348 LZMA_RA.def:256K(24.3%), 3.8K } *< Number:            1; Type:       String; Description: GRCh37 p....; md5: a1ccfb37....
## |  |  |--+ BN   { Int32 1348 LZMA_RA.def:256K(20.7%), 1.1K } *< Number:            .; Type:      Integer; Description: First db....; md5: 0ac62828....
## |  |  \--+ @BN   { Int32 1348 LZMA_RA.def:256K(2.11%), 121B } *< R.invisible:             ; md5: 5b09a6e5....
## |  \--+ format   [  ]
## |     \--+ DP   [  ] *< Number:            .; Type:      Integer; Description: Read Dep....
## |        |--+ data   { VL_Int 90x1348 LZMA_RA.def:1M(70.8%), 115.2K } *< md5: d967efdf....
## |        |--+ ~data   { VL_Int 1348x90 LZMA_RA.def:1M(65.1%), 105.9K } *< md5: bf438d2b....
## |        \--+ @data   { Int32 1348 LZMA_RA.def:256K(2.11%), 121B } *< R.invisible:             ; md5: 5b09a6e5....
## \--+ sample.annotation   [  ]
##    \--+ family   { Str8 90 LZMA_RA.def:256K(55.0%), 221B } *< md5: 3d1db5be....
```

```
# close the GDS file
seqClose(genofile)
```

The output lists all variables stored in the GDS file. At the first level, it stores variables `sample.id`, `variant.id`, etc. The additional information are displayed in the braces indicating data type, size, compressed or not and compression ratio, where `Bit2` indicates that each byte encodes up to four alleles since one byte consists of eight bits, and `Str8` indicates variable-length character. The annotations are stored in the directory `annotation`, which includes the fields of ID, QUAL, FILTER, INFO and FORMAT corresponding to the original VCF file(s). All of the functions in [SeqArray](http://www.bioconductor.org/packages/release/bioc/html/SeqArray.html) require a minimum set of variables in the annotation data:

1. `sample.id`, a unique identifier for each sample.
2. `variant.id`, a unique identifier for each variant.
3. `position`, integer, the base position of each variant on the chromosome, and 0 or NA for unknown position.
4. `chromosome`, character, the chromosome code, e.g., 1-22 for autosomes, X, Y, XY (the pseudoautosomal region), M (the mitochondrial probes), and `""` (a blank string) for probes with unknown chromosome. The optional nodes `@chrom_rle_val` and `@chrom_rle_len` store the run-length encoding (RLE) representation of `chromosome` for faster indexing (requiring SeqArray>=v1.20.0).
5. `allele`, character, reference and alternative alleles using comma as a separator.
6. `genotype`, a folder:
   1. `data`, a 3-dimensional array for genotypic data, the first dimension refers to the number of ploidy, the second is sample and the third is variant.
   2. `~data`, an optional variable, the transposed array according to `data`, the second dimension is variant and the third is sample.
   3. `@data`, the index for the variable `data`, and the prefix `@` is used to indicate the index. It should be equal-size as `variant.id`, which is used to specify the data size of each variant.
   4. `extra.index`, an index (3-by-\(\*\)) matrix for triploid call (look like `0/0/1` in the VCF file). E.g., for `0/0/1`, the first two alleles are stored in `data`, and the last allele is saved in the variable `extra`. For each column of `extra.index`, the first value is the index of sample (starting from 1), the second value is the index of variant (starting from 1), and the last value is how many alleles remain (usually it is 1 since the first two alleles are stored in `data`) that indicates how many alleles stored in `extra` contiguously.
   5. `extra`, one-dimensional array, the additional data for triploid call, each allele block corresponds to each column in `extra.index`.

The optional folders include `phase` (phasing information), `annotation`, and `sample.annotation`.

* The folder `phase` includes:

1. `data`, a matrix or 3-dimensional array for phasing information. `0` for unphased status and `1` for phased status. If it is a matrix, the first dimension is sample and the second is variant, corresponding to diploid genotypic data. If it is a 3-dimensional array, the first dimension refers to the number of ploidy minus one. More details about `/` and `|` in a VCF file can be founded: [VCF format](https://www.internationalgenome.org/wiki/analysis/variant-call-format).
2. `~data`, an optional variable, the transposed array according to `data`, the second dimension is variant and the third is sample.
3. `extra.index`, an index (3-by-\(\*\)) matrix for triploid call (look like `0/0/1` in the VCF file). E.g., for `0/0/1`, the first separator (`/` here) is stored in `data`, and the last separator is saved in the variable `extra`. For each column of `extra.index`, the first value is the index of sample (starting from 1), the second value is the index of variant (starting from 1), and the last value is how many separators remain (usually it is 1 since the first separator is stored in `data`) that indicates how many separator stored in `extra` contiguously.
4. `extra`, one-dimensional array, the additional data of separator indicator for triploid call, each separator block corresponds to each column in `extra.index`.

* The folder `annotation` includes:

1. `id`, ID semi-colon separated list of unique identifiers where available. If this is a dbSNP variant it is encouraged to use the rs number(s). No identifier should be present in more than one data record. If there is no identifier available, then a blank string is used.
2. `qual`, phred-scaled quality score for the assertion made in ALT.
3. `filter`, PASS if this position has passed all filters, i.e. a call is made at this position.
4. `info`, a vector or a matrix, additional information for each variant, according to the INFO field in a VCF file,
   1. `VARIABLE_NAME`, variable. If it is fixed-length, missing value indicates that there is no entry for that variant in the VCF file.
   2. `@VARIABLE_NAME` (*optional*). If `VARIABLE_NAME` is variable-length, one-dimensional array. The prefix `@` is used to indicate the index data. It should be equal-size as `variant.id`, which is used to specify the data size of each variant.
   3. `OTHER_VARIABLES`, …
5. `format`, additional information for each variant and sample, according to the FORMAT field in a VCF file,
   1. `VARIABLE_NAME`, a folder,
      1. `data`, a \(n\_{samp}\)-by-\(\*\) matrix.
      2. `~data`, an optional variable, the transposed array according to `data`.
      3. `@data`, one-dimensional array, the index data for the variable `data`, and the prefix `@` is used to indicate the index data. It should be equal-size as `variant.id`, which is used to specify the data size of each variant.
   2. `OTHER_VARIABLES`, …
   3. typical variables include `AD` (allelic depth), `DS` (dosage of alternative alleles, and multiple columns if more than one alt. allele)

* The folder `sample.annotation` contains variables of vector or matrix according to `sample.id`.

## 2.2 Format Conversion from VCF Files

The [SeqArray](http://www.bioconductor.org/packages/release/bioc/html/SeqArray.html) package provides a function `seqVCF2GDS()` to reformat a VCF file, and it allows merging multiple VCF files during format conversion. The genotypic and annotation data are stored in a compressed manner.

```
# the VCF file, using the example in the SeqArray package
vcf.fn <- seqExampleFileName("vcf")
# or vcf.fn <- "C:/YourFolder/Your_VCF_File.vcf"
vcf.fn
```

```
## [1] "/tmp/RtmpXPTVOy/Rinst2e71e94b082247/SeqArray/extdata/CEU_Exon.vcf.gz"
```

```
# parse the header
seqVCF_Header(vcf.fn)
```

```
## List of 12
##  $ fileformat: chr "VCFv4.0"
##  $ info      :'data.frame':  9 obs. of  6 variables:
##   ..$ ID         : chr [1:9] "AA" "AC" "AN" "DP" ...
##   ..$ Number     : chr [1:9] "." "1" "1" "1" ...
##   ..$ Type       : chr [1:9] "String" "Integer" "Integer" "Integer" ...
##   ..$ Description: chr [1:9] "Ancestral Allele" "Total number of alternate alleles in called genotypes" "Total number of alleles in called genotypes" "Total Depth" ...
##   ..$ Source     : chr [1:9] NA NA NA NA ...
##   ..$ Version    : chr [1:9] NA NA NA NA ...
##  $ filter    :'data.frame':  2 obs. of  2 variables:
##   ..$ ID         : chr [1:2] "PASS" "q10"
##   ..$ Description: chr [1:2] "All filters passed" "Quality below 10"
##  $ format    :'data.frame':  2 obs. of  4 variables:
##   ..$ ID         : chr [1:2] "GT" "DP"
##   ..$ Number     : chr [1:2] "1" "."
##   ..$ Type       : chr [1:2] "String" "Integer"
##   ..$ Description: chr [1:2] "Genotype" "Read Depth from MOSAIK BAM"
##  $ alt       : NULL
##  $ contig    : NULL
##  $ assembly  : NULL
##  $ reference : chr "human_b36_both.fasta"
##  $ header    :'data.frame':  0 obs. of  2 variables:
##   ..$ id   : chr(0)
##   ..$ value: chr(0)
##  $ ploidy    : int 2
##  $ num.sample: int 90
##  $ sample.id : chr [1:90] "NA06984" "NA06985" "NA06986" "NA06989" ...
##  - attr(*, "class")= chr "SeqVCFHeaderClass"
```

The columns `Number`, `Type` and `Description` are defined by the 1000 Genomes Project: [VCF format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-41). Briefly, the Number entry is an Integer that describes the number of values that can be included with the INFO field. For example, if the INFO field contains a single number, then this value should be 1; if the INFO field describes a pair of numbers, then this value should be 2 and so on. If the field has one value per alternate allele then this value should be `A`; if the field has one value for each possible genotype then this value should be `G`. If the number of possible values varies, is unknown, or is unbounded, then this value should be `.`. The `Flag` type indicates that the INFO field does not contain an entry, and hence the Number should be 0 in this case. Possible Types for FORMAT fields are: Integer, Float, Character, and String (this field is otherwise defined precisely as the INFO field).

```
# convert, save in "tmp.gds" with the default lzma compression algorithm
seqVCF2GDS(vcf.fn, "tmp.gds", verbose=FALSE)
```

```
# compress data with the zlib compression algorithm when random-access memory is limited
seqVCF2GDS(vcf.fn, "tmp.gds", storage.option="ZIP_RA")
```

```
## ##< 2026-01-29 21:06:49
## Variant Call Format (VCF) Import:
##     file:
##         CEU_Exon.vcf.gz (243.2K)
##     file format: VCFv4.0
##     genome reference: human_b36_both.fasta
##     # of sets of chromosomes (ploidy): 2
##     # of samples: 90
##     genotype field: GT
##     genotype storage: bit2
##     compression method: ZIP_RA
##     INFO: AA,AC,AN,DP,HM2,HM3,OR,GP,BN
##     FORMAT: DP
## Output:
##     tmp.gds
##     [Progress Info: tmp.gds.progress.txt]
## Parsing 'CEU_Exon.vcf.gz':
## + genotype/data   { Bit2 2x90x1348 ZIP_ra, 16B }
## Digests:
##     sample.id  [md5: d4d5be5fd4dc15775186933a968eeb86]
##     variant.id  [md5: ae004cdebf8eab2e7883a2182caa3967]
##     position  [md5: f3c7091eb406b90b71be6234c1b996f2]
##     chromosome  [md5: b65ee00d30fd4019558a228e14144303]
##     allele  [md5: 9217bde736ad7a49d70b5788074a2f33]
##     genotype  [md5: 55b7b3cb53dde7d9549ec1a9adb5eada]
##     phase  [md5: f272efd2132d769ded473e188c68a710]
##     annotation/id  [md5: ad224facbbf907a362af31fa4d9f8cf1]
##     annotation/qual  [md5: 61fe29d41ab53d2a877966fca27ae725]
##     annotation/filter  [md5: 87214e07213369b019511967d315e61b]
##     annotation/info/AA  [md5: 3ddc680927415ef29a663d91765318df]
##     annotation/info/AC  [md5: 32e0060f853f014a2f0500092eb41a93]
##     annotation/info/AN  [md5: 520c98d2b93738bf522425c1bab724d4]
##     annotation/info/DP  [md5: a304721e223a79637ccedb5b5a6f2f8f]
##     annotation/info/HM2  [md5: 38b58906766fb24600273356a0db9c50]
##     annotation/info/HM3  [md5: 2125043130d80f3773acf690705b85e2]
##     annotation/info/OR  [md5: e1829aa0fc0a84250f873500c0174857]
##     annotation/info/GP  [md5: 7b29009823b6f3d1beb4afac91ce11a5]
##     annotation/info/BN  [md5: 05f5e42981b9671fa0f931cd19d61339]
##     annotation/format/DP  [md5: 8e8a671fdd4c090f34f6c5451cf417fc]
## Done.  # 2026-01-29 21:06:49
## Optimize the access efficiency ...
## Clean up the fragments of GDS file:
##     open the file 'tmp.gds' (185.8K)
##     # of fragments: 164
##     save to 'tmp.gds.tmp'
##     rename 'tmp.gds.tmp' (184.7K, reduced: 1.1K)
##     # of fragments: 72
## ##> 2026-01-29 21:06:49
```

```
seqSummary("tmp.gds")
```

```
## Open 'tmp.gds'
## File: /tmp/RtmpXPTVOy/Rbuild2e71e956cd6f18/SeqArray/vignettes/tmp.gds
## Format Version: v1.0
## Reference: human_b36_both.fasta
## Ploidy: 2
## Number of samples: 90
## Number of variants: 1,348
## Chromosomes:
##     chr1 : 142, chr2 : 59 , chr3 : 81 , chr4 : 48 , chr5 : 61 , chr6 : 99
##     chr7 : 58 , chr8 : 51 , chr9 : 29 , chr10: 70 , chr11: 16 , chr12: 62
##     chr13: 11 , chr14: 61 , chr15: 46 , chr16: 84 , chr17: 100, chr18: 54
##     chr19: 111, chr20: 59 , chr21: 23 , chr22: 23
## Alleles:
##     ALT: <None>
##     tabulation: 2, 1346(99.9%); 3, 2(0.1%)
## Annotation, Quality:
##     Min: NA, 1st Qu: NA, Median: NA, Mean: NaN, 3rd Qu: NA, Max: NA, NA's: 1348
## Annotation, FILTER:
##     PASS, All filters passed, 1348(100.0%)
##     q10, Quality below 10, 0(0.0%)
## Annotation, INFO variable(s):
##     AA, ., String, Ancestral Allele
##     AC, 1, Integer, Total number of alternate alleles in called genotypes
##     AN, 1, Integer, Total number of alleles in called genotypes
##     DP, 1, Integer, Total Depth
##     HM2, 0, Flag, HapMap2 membership
##     HM3, 0, Flag, HapMap3 membership
##     OR, 1, String, Previous rs number
##     GP, 1, String, GRCh37 position(s)
##     BN, ., Integer, First dbSNP build #
## Annotation, FORMAT variable(s):
##     GT, 1, String, Genotype
##     DP, ., Integer, Read Depth from MOSAIK BAM
## Annotation, sample variable(s):
##     <None>
```

## 2.3 Export to VCF Files

The [SeqArray](http://www.bioconductor.org/packages/release/bioc/html/SeqArray.html) package provides a function `seqGDS2VCF()` to export data to a VCF file. The arguments `info.var` and `fmt.var` in `seqGDS2VCF` allow users to specify the variables listed in the INFO and FORMAT fields of VCF format, or remove the INFO and FORMAT information. `seqSetFilter()` can be used to define a subset of data for the export.

```
# the file of GDS
gds.fn <- seqExampleFileName("gds")
# or gds.fn <- "C:/YourFolder/Your_GDS_File.gds"

# open a GDS file
genofile <- seqOpen(gds.fn)

# convert
seqGDS2VCF(genofile, "tmp.vcf.gz")
```

```
## ##< 2026-01-29 21:06:50
## VCF Export: tmp.vcf.gz
##     90 samples, 1,348 variants
##     INFO Field: AA, AC, AN, DP, HM2, HM3, OR, GP, BN
##     FORMAT Field: DP
##     output to a BGZF-format gzip file
## [..................................................]  0%, ETC: ---    [==================================================] 100%, used 0s
## VCF indexing ...
## Done.
## ##> 2026-01-29 21:06:50
```

```
# read
s <- readLines("tmp.vcf.gz", n=22)
s[nchar(s) > 80] <- paste(substr(s[nchar(s) > 80], 1, 80), "...")
cat(s, sep="\n")
```

```
## ##fileformat=VCFv4.0
## ##fileDate=20260129
## ##source=SeqArray_Format_v1.0
## ##reference=human_b36_both.fasta
## ##INFO=<ID=AA,Number=.,Type=String,Description="Ancestral Allele">
## ##INFO=<ID=AC,Number=1,Type=Integer,Description="Total number of alternate allel ...
## ##INFO=<ID=AN,Number=1,Type=Integer,Description="Total number of alleles in call ...
## ##INFO=<ID=DP,Number=1,Type=Integer,Description="Total Depth">
## ##INFO=<ID=HM2,Number=0,Type=Flag,Description="HapMap2 membership">
## ##INFO=<ID=HM3,Number=0,Type=Flag,Description="HapMap3 membership">
## ##INFO=<ID=OR,Number=1,Type=String,Description="Previous rs number">
## ##INFO=<ID=GP,Number=1,Type=String,Description="GRCh37 position(s)">
## ##INFO=<ID=BN,Number=.,Type=Integer,Description="First dbSNP build #">
## ##FILTER=<ID=PASS,Description="All filters passed">
## ##FILTER=<ID=q10,Description="Quality below 10">
## ##FORMAT=<ID=GT,Number=1,Type=String,Description=Genotype>
## ##FORMAT=<ID=DP,Number=.,Type=Integer,Description="Read Depth from MOSAIK BAM">
## #CHROM   POS ID  REF ALT QUAL    FILTER  INFO    FORMAT  NA06984 NA06985 NA06986 NA06989 NA ...
## 1    1105366 rs111751804 T   C   .   PASS    AA=T;AC=4;AN=114;DP=3251;GP=1:1115503;BN=132    GT ...
## 1    1105411 rs114390380 G   A   .   PASS    AA=G;AC=1;AN=106;DP=2676;GP=1:1115548;BN=132    GT ...
## 1    1110294 rs1320571   G   A   .   PASS    AA=A;AC=6;AN=154;DP=7610;HM2;HM3;GP=1:1120431;BN= ...
## 1    3537996 rs2760321   T   C   .   PASS    AA=C;AC=128;AN=146;DP=3383;HM2;HM3;GP=1:3548136;B ...
```

```
# output BN,GP,AA,HM2 in INFO (the variables are in this order), no FORMAT
seqGDS2VCF(genofile, "tmp2.vcf.gz", info.var=c("BN","GP","AA","HM2"),
    fmt.var=character())
```

```
## ##< 2026-01-29 21:06:50
## VCF Export: tmp2.vcf.gz
##     90 samples, 1,348 variants
##     INFO Field: BN, GP, AA, HM2
##     FORMAT Field: <none>
##     output to a BGZF-format gzip file
## [..................................................]  0%, ETC: ---    [==================================================] 100%, used 0s
## VCF indexing ...
## Done.
## ##> 2026-01-29 21:06:50
```

```
# read
s <- readLines("tmp2.vcf.gz", n=16)
s[nchar(s) > 80] <- paste(substr(s[nchar(s) > 80], 1, 80), "...")
cat(s, sep="\n")
```

```
## ##fileformat=VCFv4.0
## ##fileDate=20260129
## ##source=SeqArray_Format_v1.0
## ##reference=human_b36_both.fasta
## ##INFO=<ID=BN,Number=.,Type=Integer,Description="First dbSNP build #">
## ##INFO=<ID=GP,Number=1,Type=String,Description="GRCh37 position(s)">
## ##INFO=<ID=AA,Number=.,Type=String,Description="Ancestral Allele">
## ##INFO=<ID=HM2,Number=0,Type=Flag,Description="HapMap2 membership">
## ##FILTER=<ID=PASS,Description="All filters passed">
## ##FILTER=<ID=q10,Description="Quality below 10">
## ##FORMAT=<ID=GT,Number=1,Type=String,Description=Genotype>
## #CHROM   POS ID  REF ALT QUAL    FILTER  INFO    FORMAT  NA06984 NA06985 NA06986 NA06989 NA ...
## 1    1105366 rs111751804 T   C   .   PASS    BN=132;GP=1:1115503;AA=T    GT  ./. ./. 0/0 ./. ./. ...
## 1    1105411 rs114390380 G   A   .   PASS    BN=132;GP=1:1115548;AA=G    GT  ./. ./. 0/0 ./. ./. ...
## 1    1110294 rs1320571   G   A   .   PASS    BN=88;GP=1:1120431;AA=A;HM2 GT  0/0 0/0 0/0 0/0 0/ ...
## 1    3537996 rs2760321   T   C   .   PASS    BN=100;GP=1:3548136;AA=C;HM2    GT  1/0 1/1 1/1 ./. . ...
```

```
# close the GDS file
seqClose(genofile)
```

Users can use `diff`, a command line tool in Unix-like systems, to compare files line by line, in order to confirm data consistency.

```
# assuming the original VCF file is old.vcf.gz,
# call "seqVCF2GDS" for the import and "seqGDS2VCF" for the export to create a new VCF file tmp.vcf.gz
$ diff <(zcat old.vcf.gz) <(zcat tmp.vcf.gz)
# OR
$ diff <(gunzip -c old.vcf.gz) <(gunzip -c tmp.vcf.gz)
```

```
1a2,3
> ##fileDate=20130309
> ##source=SeqArray_RPackage_v1.0

# LOOK GOOD! There are only two lines different, and both are in the header.
```

```
# delete temporary files
unlink(c("tmp.vcf.gz", "tmp1.vcf.gz", "tmp2.vcf.gz"))
```

## 2.4 Modification

The [SeqArray](http://www.bioconductor.org/packages/release/bioc/html/SeqArray.html) package provides a function `seqDelete()` to remove data annotations in the INFO and FORMAT fields. It is suggested to use `cleanup.gds()` in the [gdsfmt](http://www.bioconductor.org/packages/release/bioc/html/gdsfmt.html) package after calling `seqDelete()` to reduce the file size. For example,

```
# the file of VCF
vcf.fn <- seqExampleFileName("vcf")
# or vcf.fn <- "C:/YourFolder/Your_VCF_File.vcf"

# convert
seqVCF2GDS(vcf.fn, "tmp.gds", storage.option="ZIP_RA", verbose=FALSE)

# make sure that open with "readonly=FALSE"
genofile <- seqOpen("tmp.gds", readonly=FALSE)

# display the original structure
genofile
```

```
## Object of class "SeqVarGDSClass"
## File: /tmp/RtmpXPTVOy/Rbuild2e71e956cd6f18/SeqArray/vignettes/tmp.gds (184.7K)
## +    [  ] *
## |--+ description   [  ] *
## |--+ sample.id   { Str8 90 ZIP_ra(29.7%), 221B } *
## |--+ variant.id   { Int32 1348 ZIP_ra(35.5%), 1.9K } *
## |--+ chromosome   { Str8 1348 ZIP_ra(2.49%), 92B } *
## |--+ position   { Int32 1348 ZIP_ra(86.3%), 4.6K } *
## |--+ allele   { Str8 1348 ZIP_ra(17.2%), 936B } *
## |--+ genotype   [  ] *
## |  |--+ data   { Bit2 2x90x1348 ZIP_ra(29.6%), 17.5K } *
## |  |--+ extra.index   { Int32 3x0 ZIP_ra, 16B } *
## |  \--+ extra   { Int16 0 ZIP_ra, 16B }
## |--+ phase   [  ]
## |  |--+ data   { Bit1 90x1348 ZIP_ra(0.31%), 54B } *
## |  |--+ extra.index   { Int32 3x0 ZIP_ra, 16B } *
## |  \--+ extra   { Bit1 0 ZIP_ra, 16B }
## |--+ annotation   [  ]
## |  |--+ id   { Str8 1348 ZIP_ra(42.2%), 6.0K } *
## |  |--+ qual   { Float32 1348 ZIP_ra(0.76%), 48B } *
## |  |--+ filter   { Int32,factor 1348 ZIP_ra(0.74%), 47B } *
## |  |--+ info   [  ]
## |  |  |--+ AA   { Str8 1328 ZIP_ra(20.4%), 550B } *
## |  |  |--+ AC   { Int32 1348 ZIP_ra(29.0%), 1.5K } *
## |  |  |--+ AN   { Int32 1348 ZIP_ra(22.0%), 1.2K } *
## |  |  |--+ DP   { Int32 1348 ZIP_ra(62.4%), 3.3K } *
## |  |  |--+ HM2   { Bit1 1348 ZIP_ra(112.4%), 197B } *
## |  |  |--+ HM3   { Bit1 1348 ZIP_ra(112.4%), 197B } *
## |  |  |--+ OR   { Str8 1348 ZIP_ra(14.8%), 259B } *
## |  |  |--+ GP   { Str8 1348 ZIP_ra(34.2%), 5.3K } *
## |  |  \--+ BN   { Int32 1348 ZIP_ra(22.4%), 1.2K } *
## |  \--+ format   [  ]
## |     \--+ DP   [  ] *
## |        \--+ data   { VL_Int 90x1348 ZIP_ra(80.1%), 130.3K } *
## \--+ sample.annotation   [  ]
```

```
# delete "HM2", "HM3", "AA", "OR" and "DP"
seqDelete(genofile, info.var=c("HM2", "HM3", "AA", "OR"), fmt.var="DP")
```

```
## Delete INFO variable(s): HM2, HM3, AA, OR
## Delete FORMAT variable(s): DP
## Delete Sample Annotation variable(s): <None>
```

```
# display
genofile
```

```
## Object of class "SeqVarGDSClass"
## File: /tmp/RtmpXPTVOy/Rbuild2e71e956cd6f18/SeqArray/vignettes/tmp.gds (184.7K)
## +    [  ] *
## |--+ description   [  ] *
## |--+ sample.id   { Str8 90 ZIP_ra(29.7%), 221B } *
## |--+ variant.id   { Int32 1348 ZIP_ra(35.5%), 1.9K } *
## |--+ chromosome   { Str8 1348 ZIP_ra(2.49%), 92B } *
## |--+ position   { Int32 1348 ZIP_ra(86.3%), 4.6K } *
## |--+ allele   { Str8 1348 ZIP_ra(17.2%), 936B } *
## |--+ genotype   [  ] *
## |  |--+ data   { Bit2 2x90x1348 ZIP_ra(29.6%), 17.5K } *
## |  |--+ extra.index   { Int32 3x0 ZIP_ra, 16B } *
## |  \--+ extra   { Int16 0 ZIP_ra, 16B }
## |--+ phase   [  ]
## |  |--+ data   { Bit1 90x1348 ZIP_ra(0.31%), 54B } *
## |  |--+ extra.index   { Int32 3x0 ZIP_ra, 16B } *
## |  \--+ extra   { Bit1 0 ZIP_ra, 16B }
## |--+ annotation   [  ]
## |  |--+ id   { Str8 1348 ZIP_ra(42.2%), 6.0K } *
## |  |--+ qual   { Float32 1348 ZIP_ra(0.76%), 48B } *
## |  |--+ filter   { Int32,factor 1348 ZIP_ra(0.74%), 47B } *
## |  |--+ info   [  ]
## |  |  |--+ AC   { Int32 1348 ZIP_ra(29.0%), 1.5K } *
## |  |  |--+ AN   { Int32 1348 ZIP_ra(22.0%), 1.2K } *
## |  |  |--+ DP   { Int32 1348 ZIP_ra(62.4%), 3.3K } *
## |  |  |--+ GP   { Str8 1348 ZIP_ra(34.2%), 5.3K } *
## |  |  \--+ BN   { Int32 1348 ZIP_ra(22.4%), 1.2K } *
## |  \--+ format   [  ]
## \--+ sample.annotation   [  ]
```

```
# close the GDS file
seqClose(genofile)

# clean up the fragments to reduce the file size
cleanup.gds("tmp.gds")
```

```
## Clean up the fragments of GDS file:
##     open the file 'tmp.gds' (184.7K)
##     # of fragments: 72
##     save to 'tmp.gds.tmp'
##     rename 'tmp.gds.tmp' (51.3K, reduced: 133.5K)
##     # of fragments: 56
```

.

.

.

.

.

.

.

# 3 Data Processing

## 3.1 Functions for Data Analysis

**Table 2**: A list of functions for data analysis.

| Function | Description |
| --- | --- |
| seqGetData | Gets data from a sequence GDS file (from a subset of data). [»](https://rdrr.io/bioc/SeqArray/man/seqGetData.html) |
| seqApply | Applies a user-defined function over array margins. [»](https://rdrr.io/bioc/SeqArray/man/seqApply.html) |
| seqNumAllele | Numbers of alleles per site. [»](https://rdrr.io/bioc/SeqArray/man/seqNumAllele.html) |
| seqMissing | Missing genotype percentages. [»](https://rdrr.io/bioc/SeqArray/man/seqMissing.html) |
| seqAlleleFreq | Allele frequencies. [»](https://rdrr.io/bioc/SeqArray/man/seqAlleleFreq.html) |
| seqAlleleCount | Allele counts. [»](https://rdrr.io/bioc/SeqArray/man/seqAlleleFreq.html) |
| … | [»](https://rdrr.io/bioc/SeqArray/man/) |

.

## 3.2 Get Data

```
# open a GDS file
gds.fn <- seqExampleFileName("gds")
genofile <- seqOpen(gds.fn)
```

It is suggested to use `seqGetData()` to take out data from the GDS file since this function can take care of variable-length data and multi-allelic genotypes, although users could also use `read.gdsn()` in the [gdsfmt](http://www.bioconductor.org/packages/release/bioc/html/gdsfmt.html) package to read data.

```
# take out sample id
head(samp.id <- seqGetData(genofile, "sample.id"))
```

```
## [1] "NA06984" "NA06985" "NA06986" "NA06989" "NA06994" "NA07000"
```

```
# take out variant id
head(variant.id <- seqGetData(genofile, "variant.id"))
```

```
## [1] 1 2 3 4 5 6
```

```
# get "chromosome"
table(seqGetData(genofile, "chromosome"))
```

```
##
##   1  10  11  12  13  14  15  16  17  18  19   2  20  21  22   3   4   5   6   7   8   9
## 142  70  16  62  11  61  46  84 100  54 111  59  59  23  23  81  48  61  99  58  51  29
```

```
# get "allele"
head(seqGetData(genofile, "allele"))
```

```
## [1] "T,C" "G,A" "G,A" "T,C" "G,C" "C,T"
```

```
# get "annotation/info/GP"
head(seqGetData(genofile, "annotation/info/GP"))
```

```
## [1] "1:1115503" "1:1115548" "1:1120431" "1:3548136" "1:3548832" "1:3551737"
```

```
# get "sample.annotation/family"
head(seqGetData(genofile, "sample.annotation/family"))
```

```
## [1] "1328"  ""      "13291" "1328"  "1340"  "1340"
```

Users can set a filter to samples and/or variants by `seqSetFilter()`. For example, a subset consisting of three samples and four variants:

```
# set sample and variant filters
seqSetFilter(genofile, sample.id=samp.id[c(2,4,6)])
```

```
## # of selected samples: 3
```

```
# or, seqSetFilter(genofile, sample.sel=c(2,4,6))
set.seed(100)
seqSetFilter(genofile, variant.id=sample(variant.id, 4))
```

```
## # of selected variants: 4
```

```
# get "allele"
seqGetData(genofile, "allele")
```

```
## [1] "A,C" "C,T" "C,A" "G,A"
```

Get genotypic data, it is a 3-dimensional array with respect to allele, sample and variant. `0` refers to the reference allele (or the first allele in the variable `allele`), `1` for the second allele, and so on, while NA is missing allele.

```
# get genotypic data
seqGetData(genofile, "genotype")
```

```
## , , 1
##
##       sample
## allele [,1] [,2] [,3]
##   [1,]    0    0    0
##   [2,]    0    0    0
##
## , , 2
##
##       sample
## allele [,1] [,2] [,3]
##   [1,]    0    0    0
##   [2,]    0    0    0
##
## , , 3
##
##       sample
## allele [,1] [,2] [,3]
##   [1,]    0    0    0
##   [2,]    0    0    0
##
## , , 4
##
##       sample
## allele [,1] [,2] [,3]
##   [1,]    0    0    0
##   [2,]    0    0    0
```

Get regular genotypes (i.e., genotype dosage, or the number of copies of reference allele), it is an integer matrix.

```
# get the dosage of reference allele
seqGetData(genofile, "$dosage")
```

```
##       variant
## sample [,1] [,2] [,3] [,4]
##   [1,]    2    2    2    2
##   [2,]    2    2    2    2
##   [3,]    2    2    2    2
```

Now let us take a look at a variable-length dataset `annotation/info/AA`, which corresponds to the INFO column in the original VCF file. There are four variants, each variant has data with size ONE (`$length`), and data are saved in `$data` contiguously. `$length` could be ZERO indicating no data for that variant.

```
# get "annotation/info/AA", a variable-length dataset
seqGetData(genofile, "annotation/info/AA")
```

```
## [1] "A" "C" "C" "G"
```

Another variable-length dataset is `annotation/format/DP` corresponding to the FORMAT column in the original VCF file. Again, `$length` refers to the size of each variant, and data are saved in `$data` contiguously with respect to the dimension `variant`. `$length` could be ZERO indicating no data for that variant.

```
# get "annotation/format/DP", a variable-length dataset
seqGetData(genofile, "annotation/format/DP")
```

```
##       variant
## sample [,1] [,2] [,3] [,4]
##   [1,]    4   13    2   13
##   [2,]    2    7   15  105
##   [3,]    9   11   38   45
```

## 3.3 Apply Functions Over Array Margins

[SeqArray](http://www.bioconductor.org/packages/release/bioc/html/SeqArray.html) provides `seqApply()` to apply a user-defined function over array margins, which is coded in C++. It is suggested to use `seqApply()` instead of `apply.gdsn()` in the [gdsfmt](http://www.bioconductor.org/packages/release/bioc/html/gdsfmt.html) package, since this function can take care of variable-length data and multi-allelic genotypes. For example, reading the two variables `genotype` and `annotation/id` variant by variant:

```
# set sample and variant filters
set.seed(100)
seqSetFilter(genofile, sample.id=samp.id[c(2,4,6)], variant.id=sample(variant.id, 4))
```

```
## # of selected samples: 3
## # of selected variants: 4
```

```
# read multiple variables variant by variant
seqApply(genofile, c(geno="genotype", id="annotation/id"), FUN=print, margin="by.variant", as.is="none")
```

```
## $geno
##       sample
## allele [,1] [,2] [,3]
##   [1,]    0    0    0
##   [2,]    0    0    0
##
## $id
## [1] "rs73134914"
##
## $geno
##       sample
## allele [,1] [,2] [,3]
##   [1,]    0    0    0
##   [2,]    0    0    0
##
## $id
## [1] "rs114467444"
##
## $geno
##       sample
## allele [,1] [,2] [,3]
##   [1,]    0    0    0
##   [2,]    0    0    0
##
## $id
## [1] "rs75372730"
##
## $geno
##       sample
## allele [,1] [,2] [,3]
##   [1,]    0    0    0
##   [2,]    0    0    0
##
## $id
## [1] "rs72483216"
```

```
# read genotypes sample by sample
seqApply(genofile, "genotype", FUN=print, margin="by.sample", as.is="none")
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0    0
## [2,]    0    0    0    0
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0    0
## [2,]    0    0    0    0
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0    0
## [2,]    0    0    0    0
```

```
seqApply(genofile, c(sample.id="sample.id", genotype="genotype"), FUN=print, margin="by.sample", as.is="none")
```

```
## $sample.id
## [1] "NA06985"
##
## $genotype
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0    0
## [2,]    0    0    0    0
##
## $sample.id
## [1] "NA06989"
##
## $genotype
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0    0
## [2,]    0    0    0    0
##
## $sample.id
## [1] "NA07000"
##
## $genotype
##      [,1] [,2] [,3] [,4]
## [1,]    0    0    0    0
## [2,]    0    0    0    0
```

```
# remove the sample and variant filters
seqResetFilter(genofile)
```

```
## # of selected samples: 90
## # of selected variants: 1,348
```

```
# get the numbers of alleles per variant
z <- seqApply(genofile, "allele",
    FUN=function(x) length(unlist(strsplit(x,","))), as.is="integer")
table(z)
```

```
## z
##    2    3
## 1346    2
```

Another example is to use the argument `var.index` in the function `seqApply()` to include external information in the analysis, where the variable `index` in the user-defined `FUN` is an index of the specified dimension starting from 1 (e.g., variant).

```
HM3 <- seqGetData(genofile, "annotation/info/HM3")

# Now HM3 is a global variable
# print out RS id if the frequency of reference allele is less than 0.5% and it is HM3
seqApply(genofile, c(geno="genotype", id="annotation/id"),
    FUN = function(index, x) {
        p <- mean(x$geno == 0, na.rm=TRUE)  # the frequency of reference allele
        if ((p < 0.005) & HM3[index]) print(x$id)
    }, as.is="none", var.index="relative", margin="by.variant")
```

```
## [1] "rs10908722"
## [1] "rs939777"
## [1] "rs698673"
## [1] "rs943542"
## [1] "rs2062163"
## [1] "rs7142228"
## [1] "rs322965"
## [1] "rs2507733"
```

## 3.4 Apply Functions in Parallel

Now, let us consider an example of calculating the frequency of reference allele, and this calculation can be done using `seqApply()` and `seqParallel()`. Let’s try the uniprocessor implementation first.

```
# calculate the frequency of reference allele,
afreq <- seqApply(genofile, "genotype", FUN=function(x) mean(x==0L, na.rm=TRUE),
    as.is="double", margin="by.variant")
length(afreq)
```

```
## [1] 1348
```

```
summary(afreq)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.0000  0.8114  0.9719  0.8488  0.9942  1.0000
```

A multi-process implementation:

```
# load the "parallel" package
library(parallel)

# choose an appropriate cluster size (or # of cores)
seqParallelSetup(2)
```

```
## Enable the computing cluster with 2 forked R processes.
```

```
# run in parallel
afreq <- seqParallel(, genofile, FUN = function(f) {
        seqApply(f, "genotype", as.is="double", FUN=function(x) mean(x==0L, na.rm=TRUE))
    }, split = "by.variant")

length(afreq)
```

```
## [1] 1348
```

```
summary(afreq)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.0000  0.8114  0.9719  0.8488  0.9942  1.0000
```

```
# Close the GDS file
seqClose(genofile)
```

.

.

.

.

.

.

.

# 4 Examples

In this section, a GDS file shipped with the package is used as an example:

```
# open a GDS file
gds.fn <- seqExampleFileName("gds")
genofile <- seqOpen(gds.fn)
```

## 4.1 The performance of seqApply

Let us try three approaches to export unphased genotypes: 1) the for loop in R; 2) vectorize the function in R; 3) the for loop in `seqApply()`. The function `seqApply()` has been highly optimized by blocking the computations to exploit the high-speed memory instead of disk. The results of running times (listed as follows) indicate that `seqApply()` works well and is comparable with vectorization in R (the benchmark in R\_v3.0).

1. the for loop in R:

```
system.time({
    geno <- seqGetData(genofile, "genotype")
    gc <- matrix("", nrow=dim(geno)[2], ncol=dim(geno)[3])
    for (i in 1:dim(geno)[3])
    {
        for (j in 1:dim(geno)[2])
        gc[j,i] <- paste(geno[1,j,i], geno[2,j,i], sep="/")
    }
    gc[gc == "NA/NA"] <- NA
    gc
})

   user  system elapsed
  2.185   0.019   2.386       <- the function takes 2.4 seconds

dim(gc)
[1]   90 1348

table(c(gc))
  0/0   0/1   1/0   1/1  <NA>
88350  7783  8258  8321  8608
```

2. Vectorize the function in R:

```
system.time({
    geno <- seqGetData(genofile, "genotype")
    gc <- matrix(paste(geno[1,,], geno[2,,], sep="/"),
        nrow=dim(geno)[2], ncol=dim(geno)[3])
    gc[gc == "NA/NA"] <- NA
    gc
})

   user  system elapsed
  0.134   0.002   0.147       <- the function takes 0.15 seconds
```

3. the for loop in `seqApply()`:

```
system.time({
    gc <- seqApply(genofile, "genotype",
        function(x) { paste(x[1,], x[2,], sep="/") },
        margin="by.variant", as.is="list")
    gc2 <- matrix(unlist(gc), ncol=length(gc))
    gc2[gc2 == "NA/NA"] <- NA
    gc2
})

   user  system elapsed
  0.157   0.002   0.168       <- the function takes 0.17 seconds
```

.

.

## 4.2 Missing Rates for Variants

### 4.2.1 seqApply

```
# apply the function marginally
m.variant <- seqApply(genofile, "genotype", function(x) mean(is.na(x)),
    margin="by.variant", as.is="double", .progress=TRUE)
```

```
## [..................................................]  0%, ETC: ---    [==================================================] 100%, used 0s
```

```
# output
length(m.variant); summary(m.variant)
```

```
## [1] 1348
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
## 0.00000 0.00000 0.01111 0.07095 0.07778 0.96667
```

### 4.2.2 C++ Integration

```
cppFunction("
    double mean_na(IntegerVector x)
    {
        int len=x.size(), n=0;
        for (int i=0; i < len; i++)
        {
            if (x[i] == NA_INTEGER) n++;
        }
        return double(n) / len;
    }")

summary(seqApply(genofile, "genotype", mean_na, margin="by.variant", as.is="double"))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
## 0.00000 0.00000 0.01111 0.07095 0.07778 0.96667
```

### 4.2.3 seqBlockApply

```
# apply the function marginally
m.variant <- seqBlockApply(genofile, "genotype", function(x) {
        colMeans(is.na(x), dims=2L)
    }, margin="by.variant", as.is="unlist")
# output
summary(m.variant)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
## 0.00000 0.00000 0.01111 0.07095 0.07778 0.96667
```

### 4.2.4 seqBlockApply + Parallel

```
# apply the function marginally with two cores
m.variant <- seqBlockApply(genofile, "genotype", function(x) colMeans(is.na(x), dims=2L),
    margin="by.variant", as.is="unlist", parallel=2)
# output
summary(m.variant)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
## 0.00000 0.00000 0.01111 0.07095 0.07778 0.96667
```

### 4.2.5 seqMissing

```
# Or call the function in SeqArray
summary(seqMissing(genofile))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
## 0.00000 0.00000 0.01111 0.07095 0.07778 0.96667
```

.

.

## 4.3 Missing Rates for Samples

### 4.3.1 seqApply

```
# get ploidy, the number of samples and variants
# dm[1] -- ploidy, dm[2] -- # of selected samples, dm[3] -- # of selected variants
dm <- seqSummary(genofile, "genotype", verbose=FALSE)$seldim

# an initial value
n <- 0L

# apply the function marginally
seqApply(genofile, "genotype", function(x) {
        n <<- n + is.na(x)    # use "<<-" operator to update 'n' in the parent environment
    }, margin="by.variant", .progress=TRUE)
```

```
## [..................................................]  0%, ETC: ---    [==================================================] 100%, used 0s
```

```
# output
m.samp <- colMeans(n) / dm[3L]
length(m.samp); summary(m.samp)
```

```
## [1] 90
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
## 0.001484 0.014095 0.054154 0.070953 0.117025 0.264095
```

### 4.3.2 C++ Integration

```
cppFunction("
    void add_na_num(IntegerVector x, IntegerVector num)
    {
        int len=x.size();
        for (int i=0; i < len; i++)
        {
            if (x[i] == NA_INTEGER) num[i]++;
        }
    }")

n <- matrix(0L, nrow=dm[1L], ncol=dm[2L])
seqApply(genofile, "genotype", add_na_num, margin="by.variant", num=n)

summary(colMeans(n) / dm[3L])
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
## 0.001484 0.014095 0.054154 0.070953 0.117025 0.264095
```

### 4.3.3 seqBlockApply

```
# an initial value
n <- 0L

# apply the function marginally
seqBlockApply(genofile, "genotype", function(x) {
        n <<- n + rowSums(is.na(x), dims=2L)    # use "<<-" operator to update 'n' in the parent environment
    }, margin="by.variant")

# output
m.samp <- colMeans(n) / dm[3L]
summary(m.samp)
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
## 0.001484 0.014095 0.054154 0.070953 0.117025 0.264095
```

### 4.3.4 seqBlockApply + Parallel

```
# the datasets are automatically split into two non-overlapping parts
n <- seqParallel(2, genofile, FUN = function(f)
    {
        n <- 0L    # an initial value
        seqBlockApply(f, "genotype", function(x) {
            n <<- n + rowSums(is.na(x), dims=2L)    # use "<<-" operator to update 'n' in the parent environment
        }, margin="by.variant")
        n    #output
    }, .combine = "+",     # sum "n" of different processes together
    split = "by.variant")

# output
m.samp <- colMeans(n) / dm[3L]
summary(m.samp)
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
## 0.001484 0.014095 0.054154 0.070953 0.117025 0.264095
```

### 4.3.5 seqMissing

```
# Call the function in SeqArray
summary(seqMissing(genofile, per.variant=FALSE))
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
## 0.001484 0.014095 0.054154 0.070953 0.117025 0.264095
```

.

.

## 4.4 Allele Frequency

### 4.4.1 seqApply

```
# apply the function variant by variant
afreq <- seqApply(genofile, "genotype", FUN=function(x) mean(x==0L, na.rm=TRUE),
    as.is="double", margin="by.variant", .progress=TRUE)
```

```
## [..................................................]  0%, ETC: ---    [==================================================] 100%, used 0s
```

```
length(afreq); summary(afreq)
```

```
## [1] 1348
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.0000  0.8114  0.9719  0.8488  0.9942  1.0000
```

### 4.4.2 C++ Integration

```
cppFunction("
    double calc_freq(IntegerVector x)
    {
        int len=x.size(), n=0, n0=0;
        for (int i=0; i < len; i++)
        {
            int g = x[i];
            if (g != NA_INTEGER)
            {
                n++;
                if (g == 0) n0++;
            }
        }
        return double(n0) / n;
    }")

summary(seqApply(genofile, "genotype", FUN=calc_freq, as.is="double", margin="by.variant"))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.0000  0.8114  0.9719  0.8488  0.9942  1.0000
```

### 4.4.3 seqBlockApply

```
# apply the function variant by variant
afreq <- seqBlockApply(genofile, "genotype", FUN=function(x) {
        colMeans(x==0L, na.rm=TRUE, dims=2L)
    }, as.is="unlist", margin="by.variant")

summary(afreq)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.0000  0.8114  0.9719  0.8488  0.9942  1.0000
```

### 4.4.4 seqBlockApply + Parallel

```
# apply the function over variants with two cores
afreq <- seqBlockApply(genofile, "genotype", FUN=function(x) {
        colMeans(x==0L, na.rm=TRUE, dims=2L)
    }, as.is="unlist", margin="by.variant", parallel=2)

summary(afreq)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.0000  0.8114  0.9719  0.8488  0.9942  1.0000
```

### 4.4.5 seqAlleleFreq

```
# Call the function in SeqArray
summary(seqAlleleFreq(genofile))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.0000  0.8114  0.9719  0.8488  0.9942  1.0000
```

.

.

## 4.5 Principal Component Analysis

In the principal component analysis (Patterson, Price, and Reich 2006), we employ the dosage of reference alleles to avoid confusion of multiple alleles. The genetic covariance matrix is defined as \(M = [ m\_{j,j'} ]\): \[
m\_{j,j'} = \frac{1}{L} \sum\_{l=1}^L
\frac{(g\_{j,l} - 2p\_l)(g\_{j',l} - 2p\_l)}{p\_l (1 - p\_l)}
\] where \(g\_{j,l}\) is a genotype of individual \(j\) at locus \(l\) (\(\in \{0,1,2\}\), Num. of reference allele), \(p\_l\) is the frequency of reference allele and there are \(L\) loci in total.

### 4.5.1 seqApply

```
# covariance variable with an initial value
s <- 0

seqApply(genofile, "$dosage", function(x)
    {
        p <- 0.5 * mean(x, na.rm=TRUE)    # allele frequency
        g <- (x - 2*p) / sqrt(p*(1-p))    # normalization
        g[is.na(g)] <- 0                  # missing values
        s <<- s + (g %o% g)               # update the cov matrix 's' in the parent environment
    }, margin="by.variant", .progress=TRUE)
```

```
## [..................................................]  0%, ETC: ---    [==================================================] 100%, used 0s
```

```
# scaled by the number of samples over the trace
s <- s * (nrow(s) / sum(diag(s)))
# eigen-decomposition
eig <- eigen(s)

# eigenvalues
head(eig$value)
```

```
## [1] 1.984696 1.867190 1.821147 1.759780 1.729839 1.678466
```

```
# eigenvectors
plot(eig$vectors[,1], eig$vectors[,2], xlab="PC 1", ylab="PC 2")
```

![](data:image/png;base64...)

### 4.5.2 seqBlockApply

```
# covariance variable with an initial value
s <- 0

seqBlockApply(genofile, "$dosage", function(x)
    {
        p <- 0.5 * colMeans(x, na.rm=TRUE)     # allele frequencies (a vector)
        g <- (t(x) - 2*p) / sqrt(p*(1-p))      # normalized by allele frequencies
        g[is.na(g)] <- 0                       # correct missing values
        s <<- s + crossprod(g)                 # update the cov matrix 's' in the parent environment
    }, margin="by.variant", .progress=TRUE)
```

```
## [..................................................]  0%, ETC: ---    [==================================================] 100%, used 0s
```

```
# scaled by the number of samples over the trace
s <- s * (nrow(s) / sum(diag(s)))
# eigen-decomposition
eig <- eigen(s)

# eigenvalues
head(eig$value)
```

```
## [1] 1.984696 1.867190 1.821147 1.759780 1.729839 1.678466
```

### 4.5.3 Multi-process Implementation

```
# the datasets are automatically split into two non-overlapping parts
genmat <- seqParallel(2, genofile, FUN = function(f)
    {
        s <- 0  # covariance variable with an initial value
        seqBlockApply(f, "$dosage", function(x)
            {
                p <- 0.5 * colMeans(x, na.rm=TRUE)     # allele frequencies (a vector)
                g <- (t(x) - 2*p) / sqrt(p*(1-p))      # normalized by allele frequency
                g[is.na(g)] <- 0                       # correct missing values
                s <<- s + crossprod(g)                 # update the cov matrix 's' in the parent environment
            }, margin="by.variant")
        s  # output
    }, .combine = "+",     # sum "s" of different processes together
    split = "by.variant")

# scaled by the number of samples over the trace
genmat <- genmat * (nrow(genmat) / sum(diag(genmat)))
# eigen-decomposition
eig <- eigen(genmat)

# eigenvalues
head(eig$value)
```

```
## [1] 1.984696 1.867190 1.821147 1.759780 1.729839 1.678466
```

.

.

## 4.6 Individual Inbreeding Coefficient

To calculate an individual inbreeding coefficient using SNP genotype data, I demonstrate how to use `seqApply()` to calculate Visscher’s estimator described in (Yang et al. 2010). The estimator of individual inbreeding coefficient is defined as \[
\hat{\theta} = \frac{1}{L} \sum\_{l=1}^L
\frac{g\_l^2 - g\_l (1 + 2p\_l) + 2p\_l^2}{2 p\_l (1 - p\_l)}
\] where \(g\_l\) is a SNP genotype at locus \(l\) \(\in \{0,1,2\}\) (# of reference alleles), \(p\_l\) is the frequency of reference allele and there are \(L\) loci in total.

### 4.6.1 seqApply

```
# initial values
n <- 0; s <- 0

seqApply(genofile, "$dosage", function(g)
    {
        p <- 0.5 * mean(g, na.rm=TRUE)    # allele frequency
        d <- (g*g - g*(1 + 2*p) + 2*p*p) / (2*p*(1-p))
        n <<- n + is.finite(d)            # output to the global variable 'n'
        d[!is.finite(d)] <- 0
        s <<- s + d                       # output to the global variable 's'
    }, margin="by.variant", as.is="none", .progress=TRUE)
```

```
## [..................................................]  0%, ETC: ---    [==================================================] 100%, used 0s
```

```
# output
coeff <- s / n
summary(coeff)
```

```
##       Min.    1st Qu.     Median       Mean    3rd Qu.       Max.
## -1.004e-01 -3.662e-02 -1.981e-02 -2.002e-02  5.280e-07  4.181e-02
```

### 4.6.2 seqBlockApply

```
# initial values
n <- 0; s <- 0

seqBlockApply(genofile, "$dosage", function(g)
    {
        p <- 0.5 * colMeans(g, na.rm=TRUE)     # allele frequencies (a vector)
        g <- t(g)
        d <- (g*g - g*(1 + 2*p) + 2*p*p) / (2*p*(1-p))
        n <<- n + colSums(is.finite(d))        # output to the global variable 'n'
        s <<- s + colSums(d, na.rm=TRUE)       # output to the global variable 's'
    }, margin="by.variant", as.is="none", .progress=TRUE)
```

```
## [..................................................]  0%, ETC: ---    [==================================================] 100%, used 0s
```

```
# output
summary(coeff <- s / n)
```

```
##       Min.    1st Qu.     Median       Mean    3rd Qu.       Max.
## -1.004e-01 -3.662e-02 -1.981e-02 -2.002e-02  5.280e-07  4.181e-02
```

### 4.6.3 Multi-process Implementation

```
# the datasets are automatically split into two non-overlapping parts
coeff <- seqParallel(2, genofile, FUN = function(f)
    {
        # initial values
        n <- 0; s <- 0
        seqApply(f, "$dosage", function(g)
            {
                p <- 0.5 * mean(g, na.rm=TRUE)    # allele frequency
                d <- (g*g - g*(1 + 2*p) + 2*p*p) / (2*p*(1-p))
                n <<- n + is.finite(d)            # output to the global variable 'n'
                d[!is.finite(d)] <- 0
                s <<- s + d                       # output to the global variable 's'
            }, margin="by.variant")
        # output
        list(s=s, n=n)
    }, # sum all variables 's' and 'n' of different processes
    .combine = function(x1, x2) { list(s = x1$s + x2$s, n = x1$n + x2$n) },
    split = "by.variant")

# finally, average!
coeff <- coeff$s / coeff$n

summary(coeff)
```

```
##       Min.    1st Qu.     Median       Mean    3rd Qu.       Max.
## -1.004e-01 -3.662e-02 -1.981e-02 -2.002e-02  5.280e-07  4.181e-02
```

```
# close the GDS file
seqClose(genofile)
```

.

.

.

.

.

.

.

# 5 Resources

1. gdsfmt R package: <https://github.com/zhengxwen/gdsfmt>, <http://bioconductor.org/packages/gdsfmt>
2. SeqArray R package: <https://github.com/zhengxwen/SeqArray>, <http://bioconductor.org/packages/SeqArray>

# 6 Session Information

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] SNPRelate_1.44.0            VariantAnnotation_1.56.0    Rsamtools_2.26.0
##  [4] Biostrings_2.78.0           XVector_0.50.0              SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.1        IRanges_2.44.0
## [10] S4Vectors_0.48.0            Seqinfo_1.0.0               MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocGenerics_0.56.0         generics_0.1.4
## [16] Rcpp_1.1.1                  SeqArray_1.50.1             gdsfmt_1.46.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0          rjson_0.2.23             xfun_0.56                bslib_0.10.0
##  [5] lattice_0.22-7           vctrs_0.7.1              tools_4.5.2              bitops_1.0-9
##  [9] curl_7.0.0               AnnotationDbi_1.72.0     RSQLite_2.4.5            blob_1.3.0
## [13] Matrix_1.7-4             BSgenome_1.78.0          cigarillo_1.0.0          lifecycle_1.0.5
## [17] compiler_4.5.2           RhpcBLASctl_0.23-42      codetools_0.2-20         htmltools_0.5.9
## [21] sass_0.4.10              RCurl_1.98-1.17          yaml_2.3.12              crayon_1.5.3
## [25] jquerylib_0.1.4          BiocParallel_1.44.0      DelayedArray_0.36.0      cachem_1.1.0
## [29] abind_1.4-8              digest_0.6.39            restfulr_0.0.16          fastmap_1.2.0
## [33] grid_4.5.2               cli_3.6.5                SparseArray_1.10.8       S4Arrays_1.10.1
## [37] GenomicFeatures_1.62.0   XML_3.99-0.20            bit64_4.6.0-1            rmarkdown_2.30
## [41] httr_1.4.7               bit_4.6.0                otel_0.2.0               png_0.1-8
## [45] memoise_2.0.1            evaluate_1.0.5           knitr_1.51               BiocIO_1.20.0
## [49] rtracklayer_1.70.1       rlang_1.1.7              DBI_1.2.3                jsonlite_2.0.0
## [53] R6_2.6.1                 GenomicAlignments_1.46.0
```

# References

Eddelbuettel, Dirk, Romain François, J Allaire, John Chambers, Douglas Bates, and Kevin Ushey. 2011. “Rcpp: Seamless R and C++ Integration.” *Journal of Statistical Software* 40 (8): 1–18.

Gentleman, Robert C., Vincent J. Carey, Douglas M. Bates, Ben Bolstad, Marcel Dettling, Sandrine Dudoit, Byron Ellis, et al. 2004. “Bioconductor: Open Software Development for Computational Biology and Bioinformatics.” *Genome Biology* 5 (10): 1–16. <https://doi.org/10.1186/gb-2004-5-10-r80>.

Lawrence, Michael, Wolfgang Huber, Hervé Pagès, Patrick Aboyoun, Marc Carlson, Robert Gentleman, Martin T. Morgan, and Vincent J. Carey. 2013. “Software for Computing and Annotating Genomic Ranges.” *PLoS Computational Biology* 9 (8): e1003118. <https://doi.org/10.1371/journal.pcbi.1003118>.

Patterson, N, A L Price, and D Reich. 2006. “Population Structure and Eigenanalysis.” *PLoS Genet* 2 (12). <https://doi.org/10.1371/journal.pgen.0020190>.

R Core Team. 2016. “R: A Language and Environment for Statistical Computing.”

Rossini, A. J, Luke Tierney, and Na Li. 2007. “Simple Parallel Statistical Computing in R.” *Journal of Computational and Graphical Statistics* 16 (2): 399–420. <https://doi.org/10.1198/106186007X178979>.

Yang, Jian, Beben Benyamin, Brian P. McEvoy, Scott Gordon, Anjali K. Henders, Dale R. Nyholt, Pamela A. Madden, et al. 2010. “Common SNPs Explain a Large Proportion of the Heritability for Human Height.” *Nature Genetics* 42 (7): 565–69. <https://doi.org/10.1038/ng.608>.

Zheng, Xiuwen, David Levine, Jess Shen, Stephanie M. Gogarten, Cathy Laurie, and Bruce S. Weir. 2012. “A High-Performance Computing Toolset for Relatedness and Principal Component Analysis of Snp Data.” *Bioinformatics (Oxford, England)* 28 (24): 3326–8. <https://doi.org/10.1093/bioinformatics/bts606>.