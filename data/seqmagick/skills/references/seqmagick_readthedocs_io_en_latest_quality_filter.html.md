### Navigation

* [index](genindex.html "General Index")
* [previous](info.html "info") |
* [seqmagick documentation](index.html) »

[![Logo](_static/seqmagick_logo_small.png)](index.html)

#### Previous topic

[`info`](info.html "previous chapter")

### This Page

* [Show Source](_sources/quality_filter.rst.txt)

### Quick search

# `quality-filter`[¶](#quality-filter "Permalink to this headline")

`quality-filter` truncates and removes sequences that don’t match a set of
quality criteria. The subcommand takes a FASTA and quality score file, and
writes the results to an output file:

```
usage: seqmagick quality-filter [-h] [--input-qual INPUT_QUAL]
                                [--report-out REPORT_OUT]
                                [--details-out DETAILS_OUT]
                                [--no-details-comment]
                                [--min-mean-quality QUALITY]
                                [--min-length LENGTH] [--max-length LENGTH]
                                [--quality-window-mean-qual QUALITY_WINDOW_MEAN_QUAL]
                                [--quality-window-prop QUALITY_WINDOW_PROP]
                                [--quality-window WINDOW_SIZE]
                                [--ambiguous-action {truncate,drop}]
                                [--max-ambiguous MAX_AMBIGUOUS]
                                [--pct-ambiguous PCT_AMBIGUOUS]
                                [--primer PRIMER | --no-primer]
                                [--barcode-file BARCODE_FILE]
                                [--barcode-header] [--map-out SAMPLE_MAP]
                                [--quoting {QUOTE_ALL,QUOTE_MINIMAL,QUOTE_NONE,QUOTE_NONNUMERIC}]
                                sequence_file output_file

Filter reads based on quality scores

positional arguments:
  sequence_file         Input fastq file. A fasta-format file may also be
                        provided if --input-qual is also specified.
  output_file           Output file. Format determined from extension.

options:
  -h, --help            show this help message and exit
  --input-qual INPUT_QUAL
                        The quality scores associated with the input file.
                        Only used if input file is fasta.
  --min-mean-quality QUALITY
                        Minimum mean quality score for each read [default:
                        25.0]
  --min-length LENGTH   Minimum length to keep sequence [default: 200]
  --max-length LENGTH   Maximum length to keep before truncating [default:
                        1000]. This operation occurs before --max-ambiguous
  --ambiguous-action {truncate,drop}
                        Action to take on ambiguous base in sequence (N's).
                        [default: no action]
  --max-ambiguous MAX_AMBIGUOUS
                        Maximum number of ambiguous bases in a sequence.
                        Sequences exceeding this count will be removed.
  --pct-ambiguous PCT_AMBIGUOUS
                        Maximun percent of ambiguous bases in a sequence.
                        Sequences exceeding this percent will be removed.

Output:
  --report-out REPORT_OUT
                        Output file for report [default: stdout]
  --details-out DETAILS_OUT
                        Output file to report fate of each sequence
  --no-details-comment  Do not write comment lines with version and call to
                        start --details-out

Quality window options:
  --quality-window-mean-qual QUALITY_WINDOW_MEAN_QUAL
                        Minimum quality score within the window defined by
                        --quality-window. [default: same as --min-mean-
                        quality]
  --quality-window-prop QUALITY_WINDOW_PROP
                        Proportion of reads within quality window to that must
                        pass filter. Floats are [default: 1.0]
  --quality-window WINDOW_SIZE
                        Window size for truncating sequences. When set to a
                        non-zero value, sequences are truncated where the mean
                        mean quality within the window drops below --min-mean-
                        quality. [default: 0]

Barcode/Primer:
  --primer PRIMER       IUPAC ambiguous primer to require
  --no-primer           Do not use a primer.
  --barcode-file BARCODE_FILE
                        CSV file containing sample_id,barcode[,primer] in the
                        rows. A single primer for all sequences may be
                        specified with `--primer`, or `--no-primer` may be
                        used to indicate barcodes should be used without a
                        primer check.
  --barcode-header      Barcodes have a header row [default: False]
  --map-out SAMPLE_MAP  Path to write sequence_id,sample_id pairs
  --quoting {QUOTE_ALL,QUOTE_MINIMAL,QUOTE_NONE,QUOTE_NONNUMERIC}
                        A string naming an attribute of the csv module
                        defining the quoting behavior for `SAMPLE_MAP`.
                        [default: QUOTE_MINIMAL]
```

### Navigation

* [index](genindex.html "General Index")
* [previous](info.html "info") |
* [seqmagick documentation](index.html) »

© Copyright 2011-2023, The Matsen Group.
Created using [Sphinx](http://sphinx-doc.org/) 1.8.6.