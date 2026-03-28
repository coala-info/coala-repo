|  |
| --- |
| Raptor 4.0.0-rc.1  A fast and space-efficient pre-filter |

Loading...

Searching...

No Matches

raptor layout

### Table of Contents

* [Main Parameters](#autotoc_md49)
  + [-​-input](#usage_layout_input)
    - [List of sequence files](#autotoc_md50)
    - [List of preprocessed files](#autotoc_md51)
  + [-​-kmer](#autotoc_md52)
  + [-​-hash](#autotoc_md53)
  + [-​-fpr](#autotoc_md54)
  + [-​-output](#autotoc_md55)
  + [-​-threads](#autotoc_md56)
  + [-​-disable-estimate-union](#autotoc_md57)
  + [-​-disable-rearrangement](#autotoc_md58)
  + [Advanced Parameters](#autotoc_md59)
  + [-​-tmax](#autotoc_md60)
  + [-​-alpha](#autotoc_md61)
  + [-​-max-rearrangement-ratio](#autotoc_md62)
  + [-​-sketch-bits](#autotoc_md63)
  + [-​-determine-best-tmax](#autotoc_md64)
  + [-​-force-all-binnings](#autotoc_md65)
  + [-​-output-sketches-to](#autotoc_md66)

Attention
:   A layout is only needed if you want to build an HIBF ([HIBF vs IBF](usage_quickstart.html#hibf_vs_ibf)).

# Main Parameters

## -​-input

### List of sequence files

The input file contains paths to the sequence data. Each line may contain multiple paths (separated by a whitespace).

/absolute/path/to/file1.fasta /absolute/path/to/file2.fasta

/absolute/path/to/file3.fa.gz

Many file types and compressions are supported. Click to show a list.

Supported file extensions are (possibly followed by bz2, gz, or bgzf):
  • embl
  • fasta
  • fa
  • fna
  • ffn
  • faa
  • frn
  • fas
  • fastq
  • fq
  • genbank
  • gb
  • gbk
  • sam

### List of preprocessed files

See [-​-output](usage_prepare.html#usage_prepare_output).

Note
:   As a convenience, `raptor prepare` creates a `minimiser.list` file in the output directory. This file can be used as input for `raptor layout` and `raptor build`.

## -​-kmer

See [Choosing window and k-mer size](usage_quickstart.html#usage_w_vs_k).

Note
:   This parameter will be used by `raptor build` and hence should be chosen carefully. However, overwriting it in the `raptor build` call is possible but not recommended, and will result in a warning being emitted.

## -​-hash

The number of hash functions to use for Bloom Filters. Influences the index size.
**Recommendation**: default value (`2`)
It should only be changed for experimentation.
See also: [Bloom Filter Calculator](https://hur.st/bloomfilter/).

Note
:   This parameter will be used by `raptor build` and hence should be chosen carefully. However, overwriting it in the `raptor build` call is possible but not recommended, and will result in a warning being emitted.

## -​-fpr

Sets an upper bound for Bloom Filter false positives.
**Recommendation**: default value (`0.05`)
  • A lower `fpr` limits the number of false-positive results, but increases index size.
  • A higher `fpr` can help to reduce memory consumption in cases where false-positive k-mers have little effect.
See also: [Bloom Filter Calculator](https://hur.st/bloomfilter/).

Note
:   This parameter will be used by `raptor build` and hence should be chosen carefully. However, overwriting it in the `raptor build` call is possible but not recommended, and will result in a warning being emitted.

## -​-output

The output filename may be freely chosen. `raptor build` does not rely on the file name or extension. The default is `layout.txt`.

## -​-threads

The number of threads to use. Currently, the layout algorithm is only partly parallelized.

Note
:   This option has no effect if `--disable-rearrangement` is set.

## -​-disable-estimate-union

The layout algorithm estimates the sequence similarity between input data. This improves the quality of the resulting layout at the expense of a higher RAM requirement.

This behaviour can be disabled with this flag.

Note
:   Setting this flag also sets `--disable-rearrangement`.

## -​-disable-rearrangement

Based on the estimated sequence similarity, the order of sequences is changed to improve layout quality. The more input sequences there are, the longer this process takes.

This behaviour can be disabled with this flag.

## Advanced Parameters

## -​-tmax

Limits the number of technical bins on each level of the HIBF. Choosing a good tmax is not trivial. The smaller tmax, the more levels the layout needs to represent the data. This results in a higher space consumption of the index. While querying each individual level is cheap, querying many levels might also lead to an increased runtime. A good tmax is usually the square root of the number of user bins/samples rounded to the next multiple of 64. Note that your tmax will always be rounded to the next multiple of 64. At the expense of a longer runtime, you can enable the statistic mode that determines the best tmax for your data set. See the advanced option –determine-best-tmax Default: ≈sqrt(samples).

## -​-alpha

The layout algorithm optimizes the space consumption of the resulting HIBF but currently has no means of optimizing the runtime for querying such an HIBF. In general, the ratio of merged bins and split bins influences the query time because a merged bin always triggers another search on a lower level. To influence this ratio, alpha can be used. The higher alpha, the less merged bins are chosen in the layout. This improves query times but leads to a bigger index. Default: 1.2.

## -​-max-rearrangement-ratio

When the flag –disable-rearrangement is not set, this option can influence the rearrangement algorithm. The algorithm only rearranges the order of user bins in fixed intervals. The higher –max-rearrangement-ratio, the larger the intervals. This potentially improves the layout, but increases the runtime of the layout algorithm. Default: 0.5. Value must be in range [0.000000,1.000000].

## -​-sketch-bits

The number of bits the HyperLogLog sketch should use to distribute the values into bins. Default: 12. Value must be in range [5,32].

## -​-determine-best-tmax

When this flag is set, the program will compute multiple layouts for tmax in [64 , 128, 256, ... , tmax] as well as tmax=sqrt(samples). The layout algorithm itself only optimizes the space consumption. When determining the best layout, we additionally keep track of the average number of queries needed to traverse each layout. This query cost is taken into account when determining the best tmax for your data. Note that the option –tmax serves as upper bound. Once the layout quality starts dropping, the computation is stopped. To run all layout computations, pass the flag –force-all-binnings.

## -​-force-all-binnings

Forces all layouts up to –tmax to be computed, regardless of the layout quality. If the flag –determine-best-tmax is not set, this flag is ignored and has no effect.

## -​-output-sketches-to

If you supply a directory path with this option, the hyperloglog sketches of your input will be stored in the respective path; one .hll file per input file. Default: None.

[Hide me](doxygen_crawl.html)

* Version:* * Generated on Mon Mar 23 2026 14:04:40 for Raptor by [![doxygen](doxygen.svg)](https://www.doxygen.org/index.html) 1.10.0