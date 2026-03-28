|  |
| --- |
| Raptor 4.0.0-rc.1  A fast and space-efficient pre-filter |

Loading...

Searching...

No Matches

raptor search

### Table of Contents

* [Main Parameters](#autotoc_md77)
  + [-​-index](#autotoc_md78)
  + [-​-query](#autotoc_md79)
  + [-​-output](#autotoc_md80)
  + [-​-threads](#autotoc_md81)
  + [-​-quiet](#autotoc_md82)
  + [-​-error](#autotoc_md83)
  + [-​-threshold](#autotoc_md84)
  + [-​-query\_length](#autotoc_md85)
  + [-​-tau](#autotoc_md86)
  + [-​-p\_max](#autotoc_md87)
  + [-​-cache-thresholds](#autotoc_md88)

# Main Parameters

## -​-index

The path to the index. For partitioned indices, the suffix `_x`, where `x` is a number, must be omitted.

## -​-query

File containing query sequences.

Many file types and compressions are supported. Click to show a list.

Supported file extensions are (possibly followed by bz2, gz, or bgzf):

* embl
* fasta
* fa
* fna
* ffn
* faa
* frn
* fas
* fastq
* fq
* genbank
* gb
* gbk
* sam

## -​-output

The output file name.

* **Format**

  ###<text> | Meta-information

  ##<text> | Meta-information

  #<number><tab><filepaths> | Assigns each input file a number. Multiple filepaths are separated by a whitespace

  #QUERY\_NAME<tab>USER\_BINS | Header for the results

  <query\_id><tab>[<number>...] | A line for each query, listing matches in input files, if any. Multiple hits are separated by a comma.
* **Example**

  ### Minimiser parameters

  ## Window size = 19

  ## Shape = 1111111111111111111

  ## Shape size (length) = 19

  ## Shape count (number of 1s) = 19

  ### Search parameters

  ## Query file = "/data/query.fq"

  ## Pattern size = 65

  ## Output file = "search.out"

  ## Threads = 1

  ## tau = 0.9999

  ## p\_max = 0.4

  ## Percentage threshold = nan

  ## Errors = 0

  ## Cache thresholds = false

  ### Index parameters

  ## Index = "/data/index.hibf"

  ## Index hashes = 2

  ## Index parts = 1

  ## False positive rate = 0.05

  ## Index is HIBF = true

  #0 /data/bin1.fa

  #1 /data/bin2.fa

  #2 /data/bin3.fa

  #3 /data/bin4.fa

  #QUERY\_NAME USER\_BINS

  query1

  query2 1

  query3 0,1,2

## -​-threads

The number of threads to use. Sequences in the query file will be processed in parallel. Negligible effect on RAM usage for unpartitioned indices. Moderate effect for partitioned indices.

## -​-quiet

By default, runtime and memory statistics are printed to stderr at the end.

This flag disables this behaviour.

## -​-error

The number of allowed errors.

Note
:   Mutually exclusive with –threshold.

## -​-threshold

Ratio of k-mers that need to be found for a hit to occur.

Note
:   Mutually exclusive with –error.

## -​-query\_length

The sequence length of a query. Used to determine thresholds. The sequence lengths should have little to no variance.

If not provided:

* the median of sequence lengths in the query file is used.
* a warning is emitted if there is a high variance in sequence lengths.
* an error occurs if any sequence is shorter than the window size.

## -​-tau

The higher tau, the lower the threshold.

Note
:   Has no effect when using `--threshold` or `w` == `k`.

## -​-p\_max

The higher p\_max, the higher the threshold.

Note
:   Has no effect when using `--threshold` or `w` == `k`.

## -​-cache-thresholds

Stores the computed thresholds with a unique name next to the index. In the next search call using this option, the stored thresholds are re-used. Two files are stored:

* threshold\_\*.bin: Depends on query\_length, window, kmer/shape, errors, and tau.
* correction\_\*.bin: Depends on query\_length, window, kmer/shape, p\_max, and fpr.

Note
:   Has no effect when using `--threshold` or `w` == `k`.

[Hide me](doxygen_crawl.html)

* Version:* * Generated on Mon Mar 23 2026 14:04:40 for Raptor by [![doxygen](doxygen.svg)](https://www.doxygen.org/index.html) 1.10.0