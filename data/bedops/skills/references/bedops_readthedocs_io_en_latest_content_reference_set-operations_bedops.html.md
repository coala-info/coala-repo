# [BEDOPS v2.4.41](../../../index.html%20)

* ←
  [6.1. Set operations](../set-operations.html "Previous document")
* [6.1.2. bedextract](bedextract.html "Next document")
  →

* [Home](../../../index.html)
* [6. Reference](../../reference.html)
* [6.1. Set operations](../set-operations.html)

# 6.1.1. bedops[¶](#bedops "Permalink to this headline")

`bedops` is a core tool for finding relationships between two or more genomic datasets.

This is an important category of problems to solve. As examples, one might want to:

* Know how much overlap exists between the elements of two datasets, to quantitatively establish the degree to which they are similar.
* Merge or filter elements. For example, retrieving non-overlapping, “unique” elements from multiple BED files.
* Split elements from multiple BED files into disjoint subsets.

The [bedops](#bedops) program offers several Boolean set and multiset operations, including union, subset, and difference, to assist investigators with answering these types of questions.

Importantly, [bedops](#bedops) handles any number of any-size inputs at once when computing results in order to maximize efficiency. This use case has [serious practical consequences](../../usage-examples/multiple-inputs.html#multiple-inputs) for many genomic studies.

One can also use [bedops](#bedops) to symmetrically or asymmetrically pad coordinates.

## 6.1.1.1. Inputs and outputs[¶](#inputs-and-outputs "Permalink to this headline")

### 6.1.1.1.1. Input[¶](#input "Permalink to this headline")

The [bedops](#bedops) program reads [sorted](../file-management/sorting/sort-bed.html#sort-bed) BED data and BEDOPS [Starch-formatted](../file-management/compression/starch.html#starch) archives as input.

Finally, [bedops](#bedops) requires specification of a set operation (and, optionally, may include modifier options).

Support for common headers (including UCSC track headers) is offered through the `--header` option. Headers are stripped from output.

### 6.1.1.1.2. Output[¶](#output "Permalink to this headline")

The [bedops](#bedops) program returns [sorted](../file-management/sorting/sort-bed.html#sort-bed) BED results to standard output. This output can be redirected to a file or piped to other utilities.

## 6.1.1.2. Usage[¶](#usage "Permalink to this headline")

The [bedops](#bedops) program takes sorted BED-formatted data as input, either from a file or streamed from standard input. It will process any number of input files in parallel.

If your data are unsorted, use BEDOPS [sort-bed](../file-management/sorting/sort-bed.html#sort-bed) to prepare data for [bedops](#bedops). You only need to sort once, as all BEDOPS tools read and write sorted BED data.

Because memory usage is very low, one can use sorted inputs of any size. Processing times generally follow a simple linear relationship with input sizes (*e.g.*, as the input size doubles, the processing time doubles accordingly).

The `--help` option describes the set operation and other options available to the end user:

```
bedops
  citation: http://bioinformatics.oxfordjournals.org/content/28/14/1919.abstract
  version:  2.4.41 (typical)
  authors:  Shane Neph & Scott Kuehn

      USAGE: bedops [process-flags] <operation> <File(s)>*

          Every input file must be sorted per the sort-bed utility.
          Each operation requires a minimum number of files as shown below.
            There is no fixed maximum number of files that may be used.
          Input files must have at least the first 3 columns of the BED specification.
          The program accepts BED and Starch file formats.
          May use '-' for a file to indicate reading from standard input (BED format only).

      Process Flags:
          --chrom <chromosome> Process data for given <chromosome> only.
          --ec                 Error check input files (slower).
          --header             Accept headers (VCF, GFF, SAM, BED, WIG) in any input file.
          --help               Print this message and exit successfully.
          --help-<operation>   Detailed help on <operation>.
                                 An example is --help-c or --help-complement
          --range L:R          Add 'L' bp to all start coordinates and 'R' bp to end
                                 coordinates. Either value may be + or - to grow or
                                 shrink regions.  With the -e/-n operations, the first
                                 (reference) file is not padded, unlike all other files.
          --range S            Pad or shink input file(s) coordinates symmetrically by S.
                                 This is shorthand for: --range -S:S.
          --version            Print program information.

      Operations: (choose one of)
          -c, --complement [-L] File1 [File]*
          -d, --difference ReferenceFile File2 [File]*
          -e, --element-of [number% | number] ReferenceFile File2 [File]*
                 by default, -e 100% is used.  'bedops -e 1' is also popular.
          -i, --intersect File1 File2 [File]*
          -m, --merge File1 [File]*
          -n, --not-element-of [number% | number] ReferenceFile File2 [File]*
                 by default, -n 100% is used.  'bedops -n 1' is also popular.
          -p, --partition File1 [File]*
          -s, --symmdiff File1 File2 [File]*
          -u, --everything File1 [File]*
          -w, --chop [bp] [--stagger [bp]] [-x] File1 [File]*
                 by default, -w 1 is used with no staggering.

      Example: bedops --range 10 -u file1.bed
      NOTE: Only operations -e|n|u preserve all columns (no flattening)
```

Note

Extended help is available for all operations in [bedops](#bedops). For example, the `--help-symmdiff` option in [bedops](#bedops) gives detailed information on the `--symmdiff` operation.

## 6.1.1.3. Operations[¶](#operations "Permalink to this headline")

To demonstrate the various operations in [bedops](#bedops), we start with two simple datasets `A` and `B`, containing genomic elements on generic chromsome `chrN`:

[![../../../_images/reference_setops_bedops_inputs@2x.png](../../../_images/reference_setops_bedops_inputs@2x.png)](../../../_images/reference_setops_bedops_inputs%402x.png)

These datasets can be [sorted](../file-management/sorting/sort-bed.html#sort-bed) BED or [Starch-formatted](../file-management/compression/starch.html#starch) files or streams.

Note

The [bedops](#bedops) tool can operate on two or more multiple inputs, but we show here the results of operations acting on just two or three sets, in order to help demonstrate the basic principles of applying set operations.

### 6.1.1.3.1. Everything (-u, –everything)[¶](#everything-u-everything "Permalink to this headline")

The `--everything` option is equivalent to concatenating and sorting BED elements from multiple files, but works much faster:

[![../../../_images/reference_setops_bedops_everything@2x.png](../../../_images/reference_setops_bedops_everything@2x.png)](../../../_images/reference_setops_bedops_everything%402x.png)

As with all BEDOPS tools and operations, the output of this operation is [sorted](../file-management/sorting/sort-bed.html#sort-bed).

Note

The `--everything` option preserves all columns from all inputs. This is useful for multiset unions of datasets with additional ID, score or other metadata.

Example

To demonstrate the use of `--everything` in performing a multiset union, we show three sorted sets `First.bed`, `Second.bed` and `Third.bed` and the result of their union with `bedops`:

```
$ more First.bed
chr1      100     200
chr2      150     300
chr2      200     250
chr3      100     150
```

```
$ more Second.bed
chr2      50      150
chr2      400     600
```

```
$ more Third.bed
chr3      150     350
```

```
$ bedops --everything First.bed Second.bed Third.bed > Result.bed
```

```
$ more Result.bed
chr1      100     200
chr2      50      150
chr2      150     300
chr2      200     250
chr2      400     600
chr3      100     150
chr3      150     350
```

This example uses three input sets, but you can specify two, four or even more sets with `--everything` to take their union.

### 6.1.1.3.2. Element-of (-e, –element-of)[¶](#element-of-e-element-of "Permalink to this headline")

The `--element-of` operation shows the elements of the first (”*reference*”) file that overlap elements in the second and subsequent “*query*” files by the specified length (in bases) or by percentage of length.

In the following example, we search for elements in the reference set `A` which overlap elements in query set `B` by at least one base:

[![../../../_images/reference_setops_bedops_elementof_ab@2x.png](../../../_images/reference_setops_bedops_elementof_ab@2x.png)](../../../_images/reference_setops_bedops_elementof_ab%402x.png)

Elements that are returned are always from the reference set (in this case, set `A`).

Note

The `--element-of` option preserves all columns from the first (reference) input.

Example

The argument to `--element-of` is a value that species to degree of overlap for elements. The value is either integral for per-base overlap, or fractional for overlap measured by length.

Here is a demonstration of the use of `--element-of 1` on two sorted sets `First.bed` and `Second.bed`, which looks for elements in the `First` set that overlap elements in the `Second` set by one or more bases:

```
$ more First.bed
chr1      100     200
chr1      150     160
chr1      200     300
chr1      400     475
chr1      500     550
```

```
$ more Second.bed
chr1      120     125
chr1      150     155
chr1      150     160
chr1      460     470
chr1      490     500
```

```
$ bedops --element-of 1 First.bed Second.bed > Result.bed
```

```
$ more Result.bed
chr1      100     200
chr1      150     160
chr1      400     475
```

One base is the least stringent (default) integral criterion. We can be more restrictive about our overlap requirement by increasing this value, say to 15 bases:

```
$ bedops --element-of 15 First.bed Second.bed > Result.bed
```

```
$ more Result.bed
chr1      100     200
```

Only this element from the `First` set overlaps one or more elements in the `Second` set by a total of fifteen or more bases.

We can also use percentage of overlap as our argument. Let’s say that we only want elements from the `First` set, which overlap half their length or more of a qualifying element in the `Second` set:

```
$ bedops --element-of 50% First.bed Second.bed > Result.bed
```

```
$ more Result.bed
chr1      150     160
```

Note that –element-of is *not* a symmetric operation, as demonstrated by reversing the order of the reference and query set:

[![../../../_images/reference_setops_bedops_elementof_ba@2x.png](../../../_images/reference_setops_bedops_elementof_ba@2x.png)](../../../_images/reference_setops_bedops_elementof_ba%402x.png)

Example

As we show here, by inverting the usual order of our sample sets `First` and `Second`, we retrieve elements from the `Second` set:

```
$ bedops --element-of 1 Second.bed First.bed > Result.bed
```

```
$ more Result.bed
chr1      120     125
chr1      150     155
chr1      150     160
chr1      460     470
```

While this operation is not symmetric with respect to ordering of input sets, `--element-of` (`-e`) does produce exactly everything that `--not-element-of` (`-n`) does not, given the same overlap criterion and ordered input sets.

Note

We show usage examples with two files, but `--element-of` supports three or more input sets. For a more in-depth discussion of `--element-of` and how overlaps are determined with three or more input files, please review the [BEDOPS forum discussion](http://bedops.uwencode.org/forum/index.php?topic=20.0) on this subject.

### 6.1.1.3.3. Not-element-of (-n, –not-element-of)[¶](#not-element-of-n-not-element-of "Permalink to this headline")

The `--not-element-of` operation shows elements in the reference file which do not overlap elements in all other sets. For example:

[![../../../_images/reference_setops_bedops_notelementof_ab@2x.png](../../../_images/reference_setops_bedops_notelementof_ab@2x.png)](../../../_images/reference_setops_bedops_notelementof_ab%402x.png)

Example

We again use sorted sets `First.bed` and `Second.bed` to demonstrate `--not-element-of`, in order to look for elements in the `First` set that *do not* overlap elements in the `Second` set by one or more bases:

```
$ more First.bed
chr1      100     200
chr1      150     160
chr1      200     300
chr1      400     475
chr1      500     550
```

```
$ more Second.bed
chr1      120     125
chr1      150     155
chr1      150     160
chr1      460     470
chr1      490     500
```

```
$ bedops --not-element-of 1 First.bed Second.bed > Result.bed
```

```
$ more Result.bed
chr1      200     300
chr1      500     550
```

As with the `--element-of` (`-e`) operator, the overlap criterion for `--not-element-of` (`-n`) can be specified either by length in bases, or by percentage of length.

Similarly, this operation is not symmetric – the order of inputs will specify the reference set, and thus the elements in the result (if any).

Note

The `--not-element-of` operatior preserves columns from the first (reference) dataset.

Note

The same caveat applies to use of `--not-element-of` (`-n`) as with `--element-of` (`-e`), namely that the second and all subsequent input files are merged before the set operation is applied. Please review the BEDOPS [forum discussion thread](http://bedops.uwencode.org/forum/index.php?topic=20.0) on this topic for more details.

### 6.1.1.3.4. Complement (-c, –complement)[¶](#complement-c-complement "Permalink to this headline")

The `--complement` operation calculates the genomic regions in the gaps between the contiguous per-chromosome ranges defined by one or more inputs. The following example shows the use of two inputs:

[![../../../_images/reference_setops_bedops_complement_ab@2x.png](../../../_images/reference_setops_bedops_complement_ab@2x.png)](../../../_images/reference_setops_bedops_complement_ab%402x.png)

Note this **computed result** will lack ID, score and other columnar data other than the first three columns that contain positional data. That is, computed elements will not come from any of the input sets, but are new elements created from the input set space.

Example

To demonstrate `--complement`, we again use sorted sets `First.bed` and `Second.bed`, in order to compute the “gaps” between their inputs:

```
$ more First.bed
chr1      100     200
chr1      150     160
chr1      200     300
chr1      400     475
chr1      500     550
```

```
$ more Second.bed
chr1      120     125
chr1      150     155
chr1      150     160
chr1      460     470
chr1      490     500
```

```
$ bedops --complement First.bed Second.bed > Result.bed
```

```
$ more Result.bed
chr1      300     400
chr1      475     490
```

As we see here, for a given chromosome, gaps are computed between the 