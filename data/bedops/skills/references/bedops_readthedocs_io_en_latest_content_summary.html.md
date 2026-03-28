# [BEDOPS v2.4.41](../index.html%20)

* ←
  [6.3.3.12. wig2bed](reference/file-management/conversion/wig2bed.html "Previous document")
* [8. Release](release.html "Next document")
  →

* [Home](../index.html)

# 7. Summary[¶](#summary "Permalink to this headline")

These tables summarize BEDOPS utilities by option, file inputs and BED column requirements.

## 7.1. Set operation and statistical utilities[¶](#set-operation-and-statistical-utilities "Permalink to this headline")

### 7.1.1. `bedextract`[¶](#bedextract "Permalink to this headline")

* Efficiently extracts features from BED input.
* BEDOPS [bedextract](reference/set-operations/bedextract.html#bedextract) documentation.

| option | description | min. file inputs | max. file inputs | min. BED columns |
| --- | --- | --- | --- | --- |
| `--list-chr` | Print every chromosome found in `input.bed` | 1 | 1 | 3 |
| `<chromosome>` | Retrieve all rows for specified chromosome, *e.g.* `bedextract chr8 input.bed` | 1 | 1 | 3 |
| `<query> <reference>` | Grab elements of `query` that overlap elements in reference. Same as `bedops -e -1 query reference`, except that this option fails when `query` contains fully-nested BED elements. May use `-` to indicate `stdin` for `reference` only. | 2 | 2 | 3 |

### 7.1.2. `bedmap`[¶](#bedmap "Permalink to this headline")

* Maps source signals from `map-file` onto qualified target regions from `ref-file`. Calculates an output for every `ref-file` element.
* BEDOPS [bedmap](reference/statistics/bedmap.html#bedmap) documentation.

| option | description | min. file inputs | max. file inputs | min. BED columns |
| --- | --- | --- | --- | --- |
| `--bases` | Reports the total number of bases from `map-file` that overlap the `ref-file` ‘s element. | 1 | 2 | 3 |
| `--bases-uniq` | Reports the number of distinct bases from `ref-file` ‘s element overlapped by elements in `map-file`. | 1 | 2 | 3 |
| `--bases-uniq-f` | Reports the fraction of distinct bases from `ref-file` ‘s element elements in `map-file`. | 1 | 2 | 3 |
| `--bp-ovr <int>` | Require `<int>` bases of overlap between elements of input files. | 1 | 2 | 3 |
| `--chrom <chromosome>` | Process data for given `<chromosome>` only. | 1 | 2 | 3 |
| `--count` | Reports the number of overlapping elements in `map-file`. | 1 | 2 | 3 |
| `--cv` | Reports the Coefficient of Variation: the result of `--stdev` divided by the result of `--mean`. | 1 | 2 | 5 |
| `--ec` | Error-check all input files (slower). | 1 | 2 | 3 |
| `--echo` | Echo each line from `ref-file`. | 1 | 2 | 3 |
| `--echo-map` | Reports the overlapping elements found in `map-file`. | 1 | 2 | 3 |
| `--echo-map-id` | Reports the IDs (4th column) from overlapping `map-file` elements. | 1 | 2 | 4 |
| `--echo-map-id-uniq` | List unique IDs from overlapping `map-file` elements. | 1 | 2 | 4 |
| `--echo-map-range` | Reports the genomic range of overlapping elements from `map-file`. | 1 | 2 | 3 |
| `--echo-map-score` | Reports the scores (5th column) from overlapping `map-file` elements. | 1 | 2 | 5 |
| `--echo-map-size` | Calculates difference between start and stop coordinates (or size) of each mapped element. | 1 | 2 | 3 |
| `--echo-overlap-size` | Calculates size of overlap between each mapped element and its reference element. | 1 | 2 | 3 |
| `--echo-ref-name` | Reports the first 3 fields of `ref-file` element in chrom:start-end format. | 1 | 2 | 3 |
| `--echo-ref-size` | Reports the length of the `ref-file` element. | 1 | 2 | 3 |
| `--faster` | **(Advanced)** Strong input assumptions are made. Review documents before use. Compatible with `--bp-ovr` and `--range` overlap options only. | 1 | 2 | 5 |
| `--fraction-ref <val>` | The fraction of the element’s size from `ref-file` that must overlap the element in `map-file`. Expects `0 < val <= 1`. | 1 | 2 | 5 |
| `--fraction-map <val>` | The fraction of the element’s size from `map-file` that must overlap the element in `ref-file`. Expects `0 < val <= 1`. | 1 | 2 | 5 |
| `--fraction-both <val>` | Both `--fraction-ref <val>` and `--fraction-map <val>` must be true to qualify as overlapping. Expects `0 < val <= 1`. | 1 | 2 | 5 |
| `--fraction-either <val>` | Both `--fraction-ref <val>` and `--fraction-map <val>` must be true to qualify as overlapping. Expects `0 < val <= 1`. | 1 | 2 | 5 |
| `--exact` | Shorthand for `--fraction-both 1`. First three fields from `map-file` must be identical to `ref-file` element. | 1 | 2 | 5 |
| `--indicator` | Reports the presence of one or more overlapping elements in `map-file` as a binary value (`0` or `1`). | 1 | 2 | 3 |
| `--kth <val>` | Reports the value at the *k* th fraction. A generalized median-like calculation, where `--kth 0.5` is the median. (`0 < val <= 1`) | 1 | 2 | 5 |
| `--mad <mult=1>` | Reports the ‘median absolute deviation’ of overlapping elements in `map-file`, multiplied by `<mult>`. | 1 | 2 | 5 |
| `--max` | Reports the highest score from overlapping elements in `map-file`. | 1 | 2 | 5 |
| `--max-element` | The lexicographically “smallest” element with the highest score from overlapping elements in `map-file`. If no overlapping element exists, `NAN` is reported (unless `--skip-unmapped` is used). | 1 | 2 | 5 |
| `--max-element-rand` | A randomly-chosed element with the highest score from overlapping elements in `map-file`. If no overlapping element exists, `NAN` is reported (unless `--skip-unmapped` is used). | 1 | 2 | 5 |
| `--mean` | Reports the average score from overlapping elements in `map-file`. | 1 | 2 | 5 |
| `--median` | Reports the median score from overlapping elements in `map-file`. | 1 | 2 | 5 |
| `--min` | Reports the lowest score from overlapping elements in `map-file`. | 1 | 2 | 5 |
| `--min-element` | The lexicographically “smallest” element with the lowest score from overlapping elements in `map-file`. If no overlapping element exists, `NAN` is reported (unless `--skip-unmapped` is used). | 1 | 2 | 5 |
| `--min-element-rand` | A randomly-chosed element with the lowest score from overlapping elements in `map-file`. If no overlapping element exists, `NAN` is reported (unless `--skip-unmapped` is used). | 1 | 2 | 5 |
| `--skip-unmapped` | Omits printing reference elements which do not associate with any mapped elements. | 1 | 2 | 3 |
| `--stdev` | Reports the square root of the result of `--variance`. | 1 | 2 | 5 |
| `--sum` | Reports the accumulated value from scores of overlapping elements in `map-file`. | 1 | 2 | 5 |
| `--sweep-all` | Reads through entire `map-file` dataset to avoid early termination that may cause SIGPIPE or other I/O errors. | 1 | 2 | 3 |
| `--tmean <low> <hi>` | Reports the mean score from overlapping elements in `map-file`, after ignoring the bottom `<low>` and top `<hi>` fractions of those scores. (`0 <= low <= 1`, `0 <= hi <= 1`, `low + hi <= 1`). | 1 | 2 | 5 |
| `--variance` | Reports the variance of scores from overlapping elements in `map-file`. | 1 | 2 | 5 |

### 7.1.3. `bedops`[¶](#bedops "Permalink to this headline")

* Offers set and multiset operations for files in BED format.
* BEDOPS [bedops](reference/set-operations/bedops.html#bedops) documentation.

| option | description | min. file inputs | max. file inputs | min. BED columns |
| --- | --- | --- | --- | --- |
| `--chrom <chromosome>` | Process data for given `chromosome` only. | 1 | No imposed limit | 3 |
| `--complement`, `-c` | Reports the intervening intervals between the input coordinate segments. | 1 | No imposed limit | 3 |
| `--chop`, `-w` | Breaks up merged regions into fixed-size chunks, optionally anchored on start coordinates a fixed distance apart. | 1 | No imposed limit | 3 |
| `--difference`, `-d` | Reports the intervals found in the first file that are not present in any other input file. | 2 | No imposed limit | 3 |
| `--ec` | Error-check input files (slower). | 1 | No imposed limit | 3 |
| `--element-of`, `-e` | Reports rows from the first file that overlap, by a specified percentage or number of base pairs, the merged segments from all other input files. | 2 | No imposed limit | 3 |
| `--header` | Accept headers (VCF, GFF, SAM, BED, WIG) in any input file. | 1 | No imposed limit | 3 |
| `--intersect`, `-i` | Reports the intervals common to all input files. | 2 | No imposed limit | 3 |
| `--merge`, `-m` | Reports intervals from all input files, after merging overlapping and adjoining segments. | 1 | No imposed limit | 3 |
| `--not-element-of`, `-n` | Reports exactly everything that `--element-of` does not, given the same overlap criterion. | 2 | No imposed limit | 3 |
| `--partition`, `-p` | Reports all disjoint intervals from all input files. Overlapping segments are cut up into pieces at all segment boundaries. | 1 | No imposed limit | 3 |
| `--range L:R` | Add `L` bases to all start coordinates and `R` base to end coordinates. Either value may be positive or negative to grow or shrink regions, respectively. With the `-e` or `-n` operation, the first (reference) file is not padded, unlike all other files. | 1 | No imposed limit | 3 |
| `--range S` | Pad input file(s) coordinates symmetrically by `S` bases. This is shorthand for `--range -S:S`. | 1 | No imposed limit | 3 |
| `--symmdiff`, `-s` | Reports the intervals found in exactly one input file. | 2 | No imposed limit | 3 |
| `--everything`, `-u` | Reports the intervals from all input files in sorted order. Duplicates are retained in the output. | 1 | No imposed limit | 3 |

### 7.1.4. `closest-features`[¶](#closest-features "Permalink to this headline")

* For every element in `input-file`, find those elements in `query-file` nearest to its left and right edges.
* BEDOPS [closest-features](reference/set-operations/closest-features.html#closest-features) documentation.

| option | description | min. file inputs | max. file inputs | min. BED columns |
| --- | --- | --- | --- | --- |
| (no option) | NA | 2 | 2 | 3 |
| `--chrom <chromosome>` | Process data for given `<chromosome>` only. | 2 | 2 | 3 |
| `--dist` | Output includes the signed distances between the `input-file` element and the closest elements in `query-file`. | 2 | 2 | 3 |
| `--ec` | Error-check all input files (slower). | 2 | 2 | 3 |
| `--no-overlaps` | Do not consider elements that overlap. Overlapping elements, otherwise, have highest precedence. | 2 | 2 | 3 |
| `--no-ref` | Do not echo elements from `input-file`. | 2 | 2 | 3 |
| `--closest` | Choose the nearest element from `query-file` only. Ties go to the leftmost closest element. | 2 | 2 | 3 |

## 7.2. Sorting[¶](#sorting "Permalink to this headline")

### 7.2.1. `sort-bed`[¶](#sort-bed "Permalink to this headline")

* Sorts input BED file(s) into the order required by other utilities. Loads all input data into memory.
* BEDOPS [sort-bed](reference/file-management/sorting/sort-bed.html#sort-bed) documentation.

| option | description | min. file inputs | max. file inputs | min. BED columns |
| --- | --- | --- | --- | --- |
| (no option) | NA | 1 | 1000 | 3 |
| `--max-mem <val>` | `<val>` specifies the maximum memory usage for the [sort-bed](reference/file-management/sorting/sort-bed.html#sort-bed) process, which is useful for very large BED inputs. For example, `--max-mem` may be `8G`, `8000M`, or `8000000000` to specify 8 GB of memory. | 1 | 1000 | 3 |
| `--unique` | Report unique elements (those which only occur once) in output. | 1 | 1000 | 3 |
| `--duplicates` | Report duplicate elements (those which occur 2+ times) in output. | 1 | 1000 | 3 |

## 7.3. Compression and extraction[¶](#compression-and-extraction "Permalink to this headline")

### 7.3.1. `starch`[¶](#starch "Permalink to this headline")

* Lossless compression of any BED file.
* BEDOPS [starch](reference/file-management/compression/starch.html#starch) documentation.

| option | description | min. file inputs | max. file inputs | min. BED columns |
| --- | --- | --- | --- | --- |
| (no option) | NA | 1 | 1 | 3 |
| `--bzip2` or `--gzip` | The internal compression method. The default `--bzip2` method favors storage efficiency, while `--gzip` favors compression and extraction time performance. | 1 | 1 | 3 |
| `--note="foo bar..."` | Append note to output archive metadata (optional). | 1 | 1 | 3 |
| `--report-progress=N` | Write progress to standard error stream for every N input elements. | 1 | 1 | 3 |

### 7.3.2. `unstarch`[¶](#unstarch "Permalink to this headline")

* Extraction of a `starch` archive or attributes.
* BEDOPS [unstarch](reference/file-management/compression/unstarch.html#unstarch) documentation.

| option | description | min. file inputs | max. file inputs | min. BED columns |
| --- | --- | --- | --- | --- |
| (no option) | NA | 1 | 1 | NA |
| `--archive-type` | Show archive’s compression type (either `bzip2` or `gzip`). | 1 | 1 | NA |
| `--archive-version` | Show archive version (at this time, either 1.x or 2.x). | 1 | 1 | NA |
| `--archive-timestamp` | Show archive creation timestamp (ISO 8601 format). | 1 | 1 | NA |
| `--bases <chromosome>` | Show total, non-unique base counts for optional `<chromosome>` (omitting `<chromosome>` shows total non-unique base count). | 1 | 1 | NA |
| `--bases-uniq <chromosome>` | Show unique base counts for optional `<chromosome>` (omitting `<chromosome>` shows total, unique base count). | 1 | 1 | NA |
| `<chromosome>` | Decompress information for a single `<chromosome>` only. | 1 | 1 | NA |
| `--duplicatesExist` or `--duplicatesExistAsString` with `<chromosome>` | Report if optional `<chromosome>` or chromosomes contain duplicate elements as 0/1 numbers or false/true strings | 1 | 1 | NA |
| `--elements <chromosome>` | Show element count for optional `<chromosome>` (omitting `<chromosome>` shows total element count). | 1 | 1 | NA |
| `--elements-max-string-length` | Show element maximum string length for optional `<chromosome>` (omitting `<chromosome>` shows maximum string length over all chromosomes). | 1 | 1 | NA |
| `--is-starch` | Test if the <starch-file> is a valid starch archive, returning 0/1 for a false/true result | 1 | 1 | NA |
| `--list` or `--list-json` | Print the metadata for a `starch` file, either in tabular form or with JSON formatting. | 1 | 1 | NA |
| `--list-chr` or `--list-chromosomes` | List all chromosomes in `starch` archive (similar to `bedextract --list-chr`). | 1 | 1 | NA |
| `--nestedsExist` or `--nestedsExistAsString` with `<chromosome>` | Report if optional `<chromosome>` or chromosomes contain nested elements as 0/1 numbers or false/true strings | 1 | 1 | NA |
| `--note` | Show descriptive note (if originally added to archive). | 1 | 1 | NA |
| `--signature` with `<chromosome>` | Show SHA-1 signature of specified chromosome (Base64-encoded) or all signatures if chromosome is not specified. | 1 | 1 | NA |
| `--verify-signature` with `<chromosome>` | Compare SHA-1 signature of specified chromosome with signature that is stored in the archive metadata, reporting error is mismatched. | 1 | 1 | NA |

### 7.3.3. `starchcat`[¶](#starchcat "Permalink to this headline")

* Merge multiple `starch