[MACS3](../index.html)

* [INSTALL Guide For MACS3](INSTALL.html)
* [Subcommands](subcommands_index.html)
  + callpeak
    - [Overview](#overview)
    - [Examples of Commandline Usage](#examples-of-commandline-usage)
    - [Essential Commandline Options](#essential-commandline-options)
      * [Input and Output](#input-and-output)
      * [Options controling peak calling behaviors](#options-controling-peak-calling-behaviors)
      * [Other options](#other-options)
    - [Output files](#output-files)
    - [Cutoff Analysis](#cutoff-analysis)
  + [callvar](callvar.html)
  + [hmmratac](hmmratac.html)
  + [bdgbroadcall](bdgbroadcall.html)
  + [bdgcmp](bdgcmp.html)
  + [bdgdiff](bdgdiff.html)
  + [bdgopt](bdgopt.html)
  + [bdgpeakcall](bdgpeakcall.html)
  + [cmbreps](cmbreps.html)
  + [filterdup](filterdup.html)
  + [pileup](pileup.html)
  + [predictd](predictd.html)
  + [randsample](randsample.html)
  + [refinepeak](refinepeak.html)
* [File Formats](fileformats_index.html)
* [Tutorial](tutorial.html)
* [Common Q & A](qa.html)
* [Contributor Covenant Code of Conduct](../CODE_OF_CONDUCT.html)
* [Contributing to MACS project](../CONTRIBUTING.html)
* [MACS3 API reference](api/index.html)

[MACS3](../index.html)

* [Subcommands](subcommands_index.html)
* callpeak
* [View page source](../_sources/docs/callpeak.md.txt)

---

# callpeak[](#callpeak "Link to this heading")

## Overview[](#overview "Link to this heading")

This is the main function in MACS3. It will take alignment files in
various format (please check the detail below) and call the
significantly enriched regions in the genome as ‘peaks’. It can be
invoked by `macs3 callpeak` . If you type this command with `-h`, you
will see a full description of command-line options. Here we only list
the essentials.

## Examples of Commandline Usage[](#examples-of-commandline-usage "Link to this heading")

1. Peak calling for regular TF ChIP-seq:
   $ macs3 callpeak -t ChIP.bam -c Control.bam -f BAM -g hs -n test -B -q 0.01
2. Broad peak calling on Histone Mark ChIP-seq:
   $ macs3 callpeak -t ChIP.bam -c Control.bam –broad -g hs –broad-cutoff 0.1
3. Peak calling on ATAC-seq (paired-end mode):
   $ macs3 callpeak -f BAMPE -t ATAC.bam -g hs -n test -B -q 0.01
4. Peak calling on ATAC-seq (focusing on insertion sites, and using single-end mode):
   $ macs3 callpeak -f BAM -t ATAC.bam -g hs -n test -B -q 0.01 –shift -50 –extension 100
5. Peak calling on scATAC-seq (paired-end mode):
   $ macs3 callpeak -f BEDPE -t scATAC.fragments.tsv.gz -g hs -n test -B -q 0.01 -n test
6. Peak calling on scATAC-seq (paired-end mode):
   $ macs3 callpeak -f FRAG -t scATAC.fragments.tsv.gz -g hs -n test -B -q 0.01 -n test
7. Peak calling on scATAC-seq (paired-end mode) and only for given barcodes:
   $ macs3 callpeak -f FRAG -t scATAC.fragments.tsv.gz -g hs -n test -B -q 0.01 -n test –barcodes barcodes.txt

## Essential Commandline Options[](#essential-commandline-options "Link to this heading")

### Input and Output[](#input-and-output "Link to this heading")

* `-t`/`--treatment`

  This is the only REQUIRED parameter for MACS3. The file can be in
  any supported format – see detail in the `--format` option. If you
  have more than one alignment file, you can specify them as `-t A B C`. MACS3 will pool up all these files together.
* `-c`/`--control`

  The control, genomic input or mock IP data file. Please follow the
  same direction as for `-t`/`--treatment`.
* `-n`/`--name`

  The name string of the experiment. MACS3 will use this string NAME
  to create output files like `NAME_peaks.xls`,
  `NAME_negative_peaks.xls`, `NAME_peaks.bed` , `NAME_summits.bed`,
  `NAME_model.r` and so on. So please avoid any confliction between
  these filenames and your existing files.
* `-f`/`--format FORMAT`

  Format of tag file can be `ELAND`, `BED`, `ELANDMULTI`,
  `ELANDEXPORT`, `SAM`, `BAM`, `BOWTIE`, `BAMPE`, `BEDPE`, or
  `FRAG`. Default is `AUTO` which will allow MACS3 to decide the
  format automatically. `AUTO` is also useful when you combine
  different formats of files. Note that MACS3 can’t detect `BAMPE`,
  `BEDPE` or `FRAG` format with `AUTO`, and you have to implicitly
  specify the format for `BAMPE`, `BEDPE` or `FRAG`.

  Nowadays, the most common formats are `BED` or `BAM` (including
  `BEDPE` and `BAMPE`). Our recommendation is to convert your data to
  `BED` or `BAM` first.

  Also, MACS3 can detect and read gzipped file for most of the plain
  text format. For example, `.bed.gz` file can be directly used
  without being uncompressed with `--format BED`.

  Here are detailed explanation of the recommended formats:

  + `BED`

    The BED format can be found at [UCSC genome browser
    website](http://genome.ucsc.edu/FAQ/FAQformat#format1).

    The essential columns in BED format input are the 1st column
    `chromosome name`, the 2nd `start position`, the 3rd `end position`, and the 6th, `strand`.

    Note that, for `BED` format, the 6th column of strand information
    is required by MACS3. And please pay attention that the
    coordinates in BED format are zero-based and half-open. See more
    detail at [UCSC
    site](http://genome.ucsc.edu/FAQ/FAQtracks#tracks1).
  + `BAM`/`SAM`

    If the format is `BAM`/`SAM`, please check the definition in
    [samtools](https://samtools.github.io/hts-specs/SAMv1.pdf). If
    the `BAM` file is generated for paired-end data, MACS3 will only
    keep the left mate(5’ end) tag. However, when format `BAMPE` is
    specified, MACS3 will use the real fragments inferred from
    alignment results for reads pileup.
  + `BEDPE` or `BAMPE`

    A special mode will be triggered while the format is specified as
    `BAMPE` or `BEDPE`. In this way, MACS3 will process the `BAM` or
    `BED` files as paired-end data. Instead of building a bimodal
    distribution of plus and minus strand reads to predict fragment
    size, MACS3 will use actual insert sizes of pairs of reads to
    build fragment pileup.

    The `BAMPE` format is just a `BAM` format containing paired-end
    alignment information, such as those from `BWA` or `BOWTIE`.

    The `BEDPE` format is a simplified and more flexible `BED` format,
    which only contains the first three columns defining the
    chromosome name, left and right position of the fragment from
    Paired-end sequencing. Please note, this is NOT the same format
    used by `bedtools`, and the `bedtools` version of `BEDPE` is
    actually not in a standard `BED` format. You can use MACS3
    subcommand [`randsample`](randsample.html) or
    [`filterdup`](filterdup.html) to convert a `BAMPE` file containing
    paired-end information to a `BEDPE` format file:

    ```
    macs3 randsample -i the_BAMPE_file.bam -f BAMPE -p 100 -o the_BEDPE_file.bed
    ```

    or

    ```
    macs3 filterdup -i the_BAMPE_file.bam -f BAMPE --keep-dup all -o the_BEDPE_file.bed
    ```
  + `FRAG`

    This is an format for the fragment files defined by 10x genomics
    to store the alignments from single-cell ATAC-seq experiment. It
    can be regarded as the `BEDPE` format with two extra columns –
    the barcode information and the counts of the fragments aligned to
    the same location with the same barcode. It is usually generated
    by the `cellranger-atac` or `cellranger-arc` pipeline. But this is
    a fairly straightforward format so one can easily convert other
    alignment results into this format. An example of the fragment
    file is like:

    ```
    chr22   10768839        10769063        AAACGAAAGACTCGGA     2
    chr22   11333072        11333249        AAACGAAAGACTCGGA     1
    chr22   11363891        11364010        AAACGAAAGACTCGGA     1
    ...
    ```

    When `-f FRAG` is used, MACS3 will use the `FragParser` to read
    this file, keeping the barcode and count information. Also, when
    `FRAG` is used, MACS3 will enter Pair-end mode and will NOT remove
    any duplicates. By default, in the above example, the fragment on
    chr22 from 10768839 to 10769063 of barcode `AAACGAAAGACTCGGA` will
    be counted twice – be regarded as two fragments in the same
    location. If this is not what you want, you can specify the
    `--max-count` option, such as 1, to set a maximum count.

    Another feature when `-f FRAG` is used is to call peak on a subset
    of barcodes, such as those representing a particular cluster of
    cells. You can provide a plain text file in which each row
    represents a unique barcode such as:

    ```
    AAACGAAAGACTCGGA
    AAACGAAAGTTTCGGA
    ...
    ```

    Use `--barcodes the_barcode_list.txt` with `-f FRAG`. MACS3 will
    call peaks based on only the fragments for specified barcodes.
* `--max-count` and `--barcodes`

  Only available when `-f FRAG` is used. Please read the description
  above in the `FRAG` format section.
* `--outdir`

  MACS3 will save all output files into the specified folder for this
  option. A new folder will be created if necessary.
* `-B`/`--bdg`

  If this flag is on, MACS3 will store the fragment pileup, control
  lambda in bedGraph files. The bedGraph files will be stored in the
  current directory named `NAME_treat_pileup.bdg` for treatment data,
  `NAME_control_lambda.bdg` for local lambda values from control.
* `--trackline`

  MACS3 will include the trackline in the header of output files,
  including the bedGraph, narrowPeak, gappedPeak, BED format files. To
  include this trackline in the header is necessary while uploading
  them to the UCSC genome browser. You can also mannually add these
  trackline to corresponding output files. For example, in order to
  upload narrowPeak file to UCSC browser, add this to as the first
  line – `track type=narrowPeak name=`”my\_peaks`" description=\"my peaks\"`. Default: Not to include any trackline.

### Options controling peak calling behaviors[](#options-controling-peak-calling-behaviors "Link to this heading")

* `-g`/`--gsize`

  It’s the mappable genome size or effective genome size which is
  defined as the genome size which can be sequenced. Because of the
  repetitive features on the chromosomes, the actual mappable genome
  size will be smaller than the original size, about 90% or 70% of the
  genome size. The default *hs* ~2.9e9 is recommended for human
  genome. Here are all precompiled parameters for effective genome
  size from
  [deeptools](https://deeptools.readthedocs.io/en/develop/content/feature/effectiveGenomeSize.html):

  + hs: 2,913,022,398 for GRCh38
  + mm: 2,652,783,500 for GRCm38
  + ce: 100,286,401 for WBcel235
  + dm: 142,573,017 for dm6

  Please check deeptools webpage to find the appropriate effective
  genome size if you want a more accurate estimation regarding
  specific assembly and read length.

  Users may want to use k-mer tools to simulate mapping of Xbps long
  reads to target genome, and to find the ideal effective genome
  size. However, usually by taking away the simple repeats and Ns from
  the total genome, one can get an approximate number of effective
  genome size. A slight difference in the number won’t cause a big
  difference of peak calls, because this number is used to estimate a
  genome-wide noise level which is usually the least significant one
  compared with the *local biases* modeled by MACS3.
* `-s`/`--tsize`

  The size of sequencing tags. If you don’t specify it, MACS3 will try
  to use the first 10 sequences from your input treatment file to
  determine the tag size. Specifying it will override the
  automatically determined tag size.
* `-q`/`--qvalue`

  The q-value (minimum FDR) cutoff to call significant
  regions. Default is 0.05. For broad marks, you can try 0.01 as the
  cutoff. The q-values are calculated from p-values using the
  [Benjamini-Hochberg
  procedure](https://en.wikipedia.org/wiki/False_discovery_rate#Benjamini%E2%80%93Hochberg_procedure).
* `-p`/`--pvalue`

  The p-value cutoff. If `-p` is specified, MACS3 will use p-value
  instead of q-value.
* `--min-length`, `--max-gap`

  These two options can be used to fine-tune the peak calling behavior
  by specifying the minimum length of a called peak and the maximum
  allowed a gap between two nearby regions to be merged. In other
  words, a called peak has to be longer than `min-length`, and if the
  distance between two nearby peaks is smaller than `max-gap` then
  they will be merged as one. If they are not set, MACS3 will set the
  DEFAULT value for `min-length` as the predicted fragment size `d`,
  and the DEFAULT value for `max-gap` as the detected read
  length. Note, if you set a `min-length` value smaller than the
  fragment size, it may have NO effect on the result. For broad peak
  calling with `--broad` option set, the DEFAULT `max-gap` for merging
  nearby stronger peaks will be the same as narrow peak calling, and 4
  times of the `max-gap` will be used to merge nearby weaker (broad)
  peaks. You can also use `--cutoff-analysis` option with the default
  setting, and check the column `avelpeak` under different cutoff
  values to decide a reasonable `min-length` value.
* `--nolambda`

  With this flag on, MACS3 will use the background lambda as local
  lambda. This means MACS3 will not consider the local bias at peak
  candidate regions. It is particularly recommended while calling
  peaks without control sample.
* `--slocal`, `--llocal`

  These two parameters control which two levels of regions will be
  checked around the peak regions to calculate the maximum lambda as
  local lambda. By default, MACS3 considers 1000bp for small local
  region(`--slocal`), and 10000bps for large local region(`--llocal`)
  which captures the bias from a long-range effect like an open
  chromatin domain. You can tweak these according to your
  project. Remember that if the region is set too small, a sharp spike
  in the input data may kill a significant peak.
* `--nomodel`

  While on, MACS3 will bypass building the shifting model. Please
  combine the usage of `--extsize` and `--shift` to achieve the effect
  you expect.
* `--extsize`

  While `--nomodel` is set, MACS3 uses this parameter to extend reads
  in 5’->3’ direction to fix-sized fragments. For example, if the size
  of the binding region for your transcription factor is 200 bp, and
  you want to bypass the model building by MACS3, this parameter can
  be set as 200. This option is only valid when `--nomodel` is set or
  when MACS3 fails to build model and `--fix-bimodal` is on.
* `--shift`

  Note, this is NOT the legacy `--shiftsize` option which is replaced
  by `--extsize` from MACS version 2! You can set an arbitrary shift
  in bp here to adjust the alignment positions of reads in the whole
  library. Please use discretion while setting it other than the
  default value (0). When `--nomodel` is set, MACS3 will use this
  value to move cutting ends (5’) then apply `--extsize` from 5’ to 3’
  direction to extend them to fragments. When this value is negative,
  the cutting ends (5’) will be moved toward 3’->5’ directio