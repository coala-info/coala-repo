### Navigation

* [index](genindex.html "General Index")
* [next](quality_filter.html "quality-filter") |
* [previous](extract_ids.html "extract-ids") |
* [seqmagick documentation](index.html) »

[![Logo](_static/seqmagick_logo_small.png)](index.html)

### [Table of Contents](index.html)

* `info`
  + [Example](#example)

#### Previous topic

[`extract-ids`](extract_ids.html "previous chapter")

#### Next topic

[`quality-filter`](quality_filter.html "next chapter")

### This Page

* [Show Source](_sources/info.rst.txt)

### Quick search

# `info`[¶](#info "Permalink to this headline")

`seqmagick info` describes one or more sequence files

## Example[¶](#example "Permalink to this headline")

```
seqmagick info examples/*.fasta

name                      alignment  min_len  max_len  avg_len  num_seqs
examples/aligned.fasta    TRUE       9797     9797     9797.00  15
examples/dewrapped.fasta  TRUE       240      240      240.00   148
examples/range.fasta      TRUE       119      119      119.00   2
examples/test.fasta       FALSE      972      9719     1573.67  15
examples/wrapped.fasta    FALSE      120      237      178.50   2
```

Output can be in comma-separated, tab-separated, or aligned formats. See
`seqmagick info -h` for details.

Usage:

```
usage: seqmagick info [-h] [--input-format INPUT_FORMAT]
                      [--out-file destination_file] [--format {tab,csv,align}]
                      [--threads THREADS]
                      sequence_files [sequence_files ...]

Info action

positional arguments:
  sequence_files

options:
  -h, --help            show this help message and exit
  --input-format INPUT_FORMAT
                        Input format. Overrides extension for all input files
  --out-file destination_file
                        Output destination. Default: STDOUT
  --format {tab,csv,align}
                        Specify output format as tab-delimited, CSV or aligned
                        in a borderless table. Default is tab-delimited if the
                        output is directed to a file, aligned if output to the
                        console.
  --threads THREADS     Number of threads (CPUs). [1]
```

### Navigation

* [index](genindex.html "General Index")
* [next](quality_filter.html "quality-filter") |
* [previous](extract_ids.html "extract-ids") |
* [seqmagick documentation](index.html) »

© Copyright 2011-2023, The Matsen Group.
Created using [Sphinx](http://sphinx-doc.org/) 1.8.6.