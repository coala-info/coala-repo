# [BEDOPS v2.4.41](../../../index.html%20)

* ←
  [6.2. Statistics](../statistics.html "Previous document")
* [6.3. File management](../file-management.html "Next document")
  →

* [Home](../../../index.html)
* [6. Reference](../../reference.html)
* [6.2. Statistics](../statistics.html)

# 6.2.1. bedmap[¶](#bedmap "Permalink to this headline")

The `bedmap` program is used to retrieve and process signal or other features over regions of interest in BED files (including DNase hypersensitive regions, SNPs, transcription factor binding sites, etc.), performing tasks such as: [smoothing raw tag](../../usage-examples/smoothing-tags.html#smoothing-raw-tags) count signal in preparation for uploading to the UCSC Genome Browser, [finding subsets of elements](../../usage-examples/snps-within-dhses.html#finding-elements-within-elements) within a larger coordinate set, [filtering multiple BED files](../../usage-examples/master-list.html#master-list) by signal, [finding multi-input overlap](../../usage-examples/multiple-inputs.html#multiple-inputs) solutions, and much, much more.

## 6.2.1.1. Inputs and outputs[¶](#inputs-and-outputs "Permalink to this headline")

### 6.2.1.1.1. Input[¶](#input "Permalink to this headline")

The [bedmap](#bedmap) program takes in *reference* and *mapping* files and calculates statistics for each reference element. These calculations—*operations*—are applied to overlapping elements from the mapped file:

[![../../../_images/reference_bedmap_inputs.png](../../../_images/reference_bedmap_inputs.png)](../../../_images/reference_bedmap_inputs.png)

The [bedmap](#bedmap) program requires files in a relaxed variation of the BED format as described by [UCSC’s browser documentation](http://genome.ucsc.edu/FAQ/FAQformat.html#format1). The chromosome field can be any non-empty string, the score field can be any valid numeric value, and information is unconstrained beyond the minimum number of columns required by the chosen options.

Note

Information is unconstrained, with one important exception: Map input (defined below) should not contain spaces in the ID or in subsequent fields. Running [bedmap](#bedmap) with `--ec` will identify problematic input.

An `awk` script can help with translating ID spaces to another non-whitespace delimiter, *e.g.*, `bedmap (--options...) reference.bed <(awk -vOFS="\t" -vFS="\t" '{gsub(" ", "%%", $4); print;}' map.bed)` and then awk -vOFS=”t” -vFS=”t” ‘{gsub(“%%”, ” “); print;}’ result.bed to convert delimiters back to spaces.

Alternatively, [bedmap](#bedmap) can accept [Starch-formatted archives](../file-management/compression/starch.html#starch) of BED data as input—it is no longer necessary to extract Starch archive data to intermediate BED files!

Support for common headers (including UCSC browser track headers) is available with the `--header` option, although headers are stripped from output.

Most importantly, [bedmap](#bedmap) expects [sorted](../file-management/sorting/sort-bed.html#sort-bed) inputs. You can use the BEDOPS [sort-bed](../file-management/sorting/sort-bed.html#sort-bed) program to ensure your inputs are properly sorted.

Note

You only need to sort once, and only if your input data are unsorted, as all BEDOPS tools take in and export sorted BED data.

Operations are applied over map elements that overlap the coordinates of each reference element. You can use the default overlap criterion of one base, or define your own criteria using the [overlap criteria operators](#bedmap-overlap-criteria).

Once you have overlapping elements, you can either perform [numerical calculations](#bedmap-score-operations) on their scores or return identifiers or other [non-score information](#bedmap-non-score-operations). Additional [modifier operators](#bedmap-modifier-operations) allow customization of how output is presented, to assist with downstream processing in a pipeline setting.

### 6.2.1.1.2. Output[¶](#output "Permalink to this headline")

Depending on specified options, the [bedmap](#bedmap) program can send a variety of delimited information about the reference and mapped elements (as well as analytical results) to standard output. If the `--echo` option is used, the output will be at least a three-column BED file. The use of predictable delimiters (which are customizable) and the use of UNIX-like standard streams allows easy downstream analysis or post-processing with other tools and scripts.

## 6.2.1.2. Usage[¶](#usage "Permalink to this headline")

The `--help` option describes the various mapping and analytical operations and other options available to the end user:

```
bedmap
  citation: http://bioinformatics.oxfordjournals.org/content/28/14/1919.abstract
  version:  2.4.41 (typical)
  authors:  Shane Neph & Scott Kuehn

 USAGE: bedmap [process-flags] [overlap-option] <operation(s)...> <ref-file> [map-file]
     Any input file must be sorted per the sort-bed utility.
     The program accepts BED and Starch file formats.
     You may use '-' for a BED file to indicate the input comes from stdin.

     Traverse <ref-file>, while applying <operation(s)> on qualified, overlapping elements from
       <map-file>.  Output is one line for each line in <ref-file>, sent to standard output.  There
       is no limit on the number of operations you can specify to compute in one bedmap call.
     If <map-file> is omitted, the given file is treated as both the <ref-file> and <map-file>.
       This usage is more efficient than specifying the same file twice.
     Arguments may be given in any order before the input file(s).

    Process Flags:
     --------
      --chrom <chromosome>  Jump to and process data for given <chromosome> only.
      --delim <delim>       Change output delimiter from '|' to <delim> between columns (e.g. '\t').
      --ec                  Error check all input files (slower).
      --faster              (advanced) Strong input assumptions are made.  Compatible with:
                              --bp-ovr, --range, --fraction-both, and --exact overlap options only.
      --header              Accept headers (VCF, GFF, SAM, BED, WIG) in any input file.
      --help                Print this message and exit successfully.
      --min-memory          Minimize memory usage (slower).
      --multidelim <delim>  Change delimiter of multi-value output columns from ';' to <delim>.
      --prec <int>          Change the post-decimal precision of scores to <int>.  0 <= <int>.
      --sci                 Use scientific notation for score outputs.
      --skip-unmapped       Print no output for a row with no mapped elements.
      --sweep-all           Ensure <map-file> is read completely (helps to prevent broken pipes).
      --unmapped-val <val>  Print <val> on unmapped --echo-map* and --min/max-element* operations.
                              The default is to print nothing.
      --unmapped-val <val>  Use <val> in place of the empty string on unmapped --echo-map* ops.
      --version             Print program information.

    Overlap Options (At most, one may be selected.  By default, --bp-ovr 1 is used):
     --------
      --bp-ovr <int>           Require <int> bp overlap between elements of input files.
      --exact                  First 3 fields from <map-file> must be identical to <ref-file>'s.
      --fraction-ref <val>     The fraction of the element's size from <ref-file> that must overlap
                                 the element in <map-file>.  Expect 0 < val <= 1.
      --fraction-map <val>     The fraction of the element's size from <map-file> that must overlap
                                 the element in <ref-file>.  Expect 0 < val <= 1.
      --fraction-both <val>    Both --fraction-ref <val> and --fraction-map <val> must be true to
                                 qualify as overlapping.  Expect 0 < val <= 1.
      --fraction-either <val>  Either --fraction-ref <val> or --fraction-map <val> must be true to
                                 qualify as overlapping.  Expect 0 < val <= 1.
      --range <int>            Grab <map-file> elements within <int> bp of <ref-file>'s element,
                                 where 0 <= int.  --range 0 is an alias for --bp-ovr 1.

    Operations:  (Any number of operations may be used any number of times.)
     ----------
      SCORE:
       <ref-file> must have at least 3 columns and <map-file> 5 columns.

      --cv                The result of --stdev divided by the result of --mean.
      --kth <val>         Generalized median. Report the value, x, such that the fraction <val>
                            of overlapping elements' scores from <map-file> is less than x,
                            and the fraction 1-<val> of scores is greater than x.  0 < val <= 1.
      --mad <mult=1>      The median absolute deviation of overlapping elements in <map-file>.
                            Multiply mad score by <mult>.  0 < mult, and mult is 1 by default.
      --max               The highest score from overlapping elements in <map-file>.
      --max-element       A (non-random) highest-scoring and overlapping element in <map-file>.
      --max-element-rand  A random highest-scoring and overlapping element in <map-file>.
      --mean              The average score from overlapping elements in <map-file>.
      --median            The median score from overlapping elements in <map-file>.
      --min               The lowest score from overlapping elements in <map-file>.
      --min-element       A (non-random) lowest-scoring and overlapping element in <map-file>.
      --min-element-rand  A random lowest-scoring and overlapping element in <map-file>.
      --stdev             The square root of the result of --variance.
      --sum               Accumulated scores from overlapping elements in <map-file>.
      --tmean <low> <hi>  The mean score from overlapping elements in <map-file>, after
                            ignoring the bottom <low> and top <hi> fractions of those scores.
                            0 <= low <= 1.  0 <= hi <= 1.  low+hi <= 1.
      --variance          The variance of scores from overlapping elements in <map-file>.
      --wmean             Weighted mean, scaled in proportion to the coverage of the <ref-file>
                            element by each overlapping <map-file> element.

     ----------
      NON-SCORE:
       <ref-file> must have at least 3 columns.
       For --echo-map-id/echo-map-id-uniq, <map-file> must have at least 4 columns.
       For --echo-map-score, <map-file> must have at least 5 columns.
       For all others, <map-file> requires at least 3 columns.

      --bases             The total number of overlapping bases from <map-file>.
      --bases-uniq        The number of distinct bases from <ref-file>'s element covered by
                            overlapping elements in <map-file>.
      --bases-uniq-f      The fraction of distinct bases from <ref-file>'s element covered by
                            overlapping elements in <map-file>.
      --count             The number of overlapping elements in <map-file>.
      --echo              Print each line from <ref-file>.
      --echo-map          List all overlapping elements from <map-file>.
      --echo-map-id       List IDs from all overlapping <map-file> elements.
      --echo-map-id-uniq  List unique IDs from overlapping <map-file> elements.
      --echo-map-range    Print genomic range of overlapping elements from <map-file>.
      --echo-map-score    List scores from overlapping <map-file> elements.
      --echo-map-size     List the full length of every overlapping element.
      --echo-overlap-size List lengths of overlaps.
      --echo-ref-name     Print the first 3 fields of <ref-file> using chrom:start-end format.
      --echo-ref-row-id   Print 'id-' followed by the line number of <ref-file>.
      --echo-ref-size     Print the length of each line from <ref-file>.
      --indicator         Print 1 if there exists an overlapping element in <map-file>, 0 otherwise.
```

## 6.2.1.3. Operations[¶](#operations "Permalink to this headline")

To demonstrate the various operations in [bedmap](#bedmap), we start with two simple, pre-sorted BED files that we label as `Map` and `Reference` (see the [Downloads](#bedmap-downloads) section for files you can use to follow along).

Our `Map` file is a snippet of real-world BED data derived from [ENCODE](http://www.uwencode.org/) experiments conducted by our lab: specifically, raw [DNaseI hypersensitivity](http://en.wikipedia.org/wiki/Hypersensitive_site) signal for the human K562 cell line (region `chr21:33031165-33032485`, assembly `GRCh37/h19` and table `wgEncodeUwDnaseK562RawRep1` from the [UCSC Genome Browser](http://genome.ucsc.edu/)).

This raw signal is the density of sequence tags which map within a 150 bp sliding window, at 20 bp steps across the genome—a smoothed picture of DNaseI hypersensitivity:

```
chr21   33031165        33031185        map-1   1.000000
chr21   33031185        33031205        map-2   3.000000
chr21   33031205        33031225        map-3   3.000000
chr21   33031225        33031245        map-4   3.000000
chr21   33031245        33031265        map-5   3.000000
chr21   33031265        33031285        map-6   5.000000
chr21   33031285        33031305        map-7   7.000000
chr21   33031305        33031325        map-8   7.000000
chr21   33031325        33031345        map-9   8.000000
chr21   33031345        33031365        map-10  14.000000
chr21   33031365        33031385        map-11  15.000000
chr21   33031385        33031405        map-12  17.000000
chr21   33031405        33031425        map-13  17.000000
...
chr21   33032425        33032445        map-64  5.000000
chr21   33032445        33032465        map-65  5.000000
chr21   33032465        33032485        map-66  6.000000
```

When visualized, the signal data has the following appearance:

[![../../../_images/reference_bedmap_mapref_all.png](../../../_images/reference_bedmap_mapref_all.png)](../../../_images/reference_bedmap_mapref_all.png)

Note

Rectangles colored in grey represent each of the sixty-six `map` elements. The x-axis represents the start coordinate of the `map` element, while the y-axis denotes the tag density, or sum of tags over that element’s 20-base window.

Our sample `Reference` file is not as exciting. It is just three BED elements which span portions of this density file:

```
chr21   33031200    33032400    ref-1
chr21   33031400    33031800    ref-2
chr21   33031900    33032000    ref-3
```

These reference elements could be exons, promoter regions, etc. It doesn’t matter for purposes of demonstration here, except to say that we can use [bedmap](#bedmap) to ask some questions about the `Reference` set.

Among them, what are the quantitative and qualitative features of the `map` elements that span over these three reference regions? For example, we might want to know the mean DNase hypersensitivity across each—the ans