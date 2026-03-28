|  |
| --- |
| Raptor 4.0.0-rc.1  A fast and space-efficient pre-filter |

Loading...

Searching...

No Matches

raptor build

### Table of Contents

* [Main Parameters](#autotoc_md67)
  + [-​-input](#autotoc_md68)
  + [-​-output](#autotoc_md69)
  + [-​-threads](#autotoc_md70)
  + [-​-quiet](#autotoc_md71)
  + [-​-kmer](#autotoc_md72)
  + [-​-window](#autotoc_md73)
  + [-​-fpr](#autotoc_md74)
  + [-​-hash](#autotoc_md75)
  + [-​-parts](#autotoc_md76)

# Main Parameters

## -​-input

* **HIBF** A layout file produced with `raptor layout`.
* **IBF** List of sequence files

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

List of preprocessed files

See [-​-output](usage_prepare.html#usage_prepare_output).

Note
:   As a convenience, `raptor prepare` creates a `minimiser.list` file in the output directory. This file can be used as input for `raptor layout` and `raptor build`.

## -​-output

The output file name.

## -​-threads

The number of threads to use. Both IBF and HIBF construction can heavily benefit from parallelisation.

## -​-quiet

By default, runtime and memory statistics are printed to stderr at the end.

This flag disables this behaviour.

## -​-kmer

* **HIBF** Read from layout file. The read value can be overwritten with this option. However, a warning will be emitted to prevent accidentally overwriting `k`.
* **IBF** See [Choosing window and k-mer size](usage_quickstart.html#usage_w_vs_k).

## -​-window

* **HIBF** Read from layout file. The read value can be overwritten with this option. However, a warning will be emitted to prevent accidentally overwriting `w`.
* **IBF** See [Choosing window and k-mer size](usage_quickstart.html#usage_w_vs_k).

## -​-fpr

* **HIBF** Read from layout file. The read value can be overwritten with this option. However, a warning will be emitted to prevent accidentally overwriting `fpr`.
* **IBF**

Sets an upper bound for Bloom Filter false positives.
**Recommendation**: default value (`0.05`)
  • A lower `fpr` limits the number of false-positive results, but increases index size.
  • A higher `fpr` can help to reduce memory consumption in cases where false-positive k-mers have little effect.
See also: [Bloom Filter Calculator](https://hur.st/bloomfilter/).

[Bloom Filter Calculator](https://hur.st/bloomfilter/)

## -​-hash

* **HIBF** Read from layout file. The read value can be overwritten with this option. However, a warning will be emitted to prevent accidentally overwriting `h`.
* **IBF**

The number of hash functions to use for Bloom Filters. Influences the index size.
**Recommendation**: default value (`2`)
It should only be changed for experimentation.
See also: [Bloom Filter Calculator](https://hur.st/bloomfilter/).

## -​-parts

* **HIBF** Not yet available.
* **IBF** Splits the index. Lower memory consumption, but higher runtime cost when searching. Output files will have a suffix `_x`, where `x` is a number.

[Hide me](doxygen_crawl.html)

* Version:* * Generated on Mon Mar 23 2026 14:04:40 for Raptor by [![doxygen](doxygen.svg)](https://www.doxygen.org/index.html) 1.10.0