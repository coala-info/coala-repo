### Navigation

* [index](genindex.html "General Index")
* [next](info.html "info") |
* [previous](backtrans_align.html "backtrans-align") |
* [seqmagick documentation](index.html) »

[![Logo](_static/seqmagick_logo_small.png)](index.html)

#### Previous topic

[`backtrans-align`](backtrans_align.html "previous chapter")

#### Next topic

[`info`](info.html "next chapter")

### This Page

* [Show Source](_sources/extract_ids.rst.txt)

### Quick search

# `extract-ids`[¶](#extract-ids "Permalink to this headline")

`seqmagick extract-ids` is extremely simple - all the IDs from a sequence file
are printed to stdout (by default) or the file of your choosing:

```
usage: seqmagick extract-ids [-h] [-o OUTPUT_FILE]
                             [--input-format INPUT_FORMAT] [-d]
                             sequence_file

Extract the sequence IDs from a file

positional arguments:
  sequence_file         Sequence file

options:
  -h, --help            show this help message and exit
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        Destination file
  --input-format INPUT_FORMAT
                        Input format for sequence file
  -d, --include-description
                        Include the sequence description in output [default:
                        False]
```

### Navigation

* [index](genindex.html "General Index")
* [next](info.html "info") |
* [previous](backtrans_align.html "backtrans-align") |
* [seqmagick documentation](index.html) »

© Copyright 2011-2023, The Matsen Group.
Created using [Sphinx](http://sphinx-doc.org/) 1.8.6.