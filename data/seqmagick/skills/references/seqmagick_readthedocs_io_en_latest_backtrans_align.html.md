### Navigation

* [index](genindex.html "General Index")
* [next](extract_ids.html "extract-ids") |
* [previous](convert_mogrify.html "convert and mogrify") |
* [seqmagick documentation](index.html) »

[![Logo](_static/seqmagick_logo_small.png)](index.html)

#### Previous topic

[`convert` and `mogrify`](convert_mogrify.html "previous chapter")

#### Next topic

[`extract-ids`](extract_ids.html "next chapter")

### This Page

* [Show Source](_sources/backtrans_align.rst.txt)

### Quick search

# `backtrans-align`[¶](#backtrans-align "Permalink to this headline")

Given a protein alignment and unaligned nucleotides, align the nucleotides
using the protein alignment. Protein and nucleotide sequence files must
contain the same number of sequences, in the same order, with the same IDs.

```
usage: seqmagick backtrans-align [-h] [-o destination_file]
                                 [-t {standard,standard-ambiguous,vertebrate-mito}]
                                 [-a {fail,warn,none}]
                                 protein_align nucl_align

Given a protein alignment and unaligned nucleotides, align the nucleotides
using the protein alignment. Protein and nucleotide sequence files must
contain the same number of sequences, in the same order, with the same IDs.

positional arguments:
  protein_align         Protein Alignment
  nucl_align            FASTA Alignment

options:
  -h, --help            show this help message and exit
  -o destination_file, --out-file destination_file
                        Output destination. Default: STDOUT
  -t {standard,standard-ambiguous,vertebrate-mito}, --translation-table {standard,standard-ambiguous,vertebrate-mito}
                        Translation table to use. [Default: standard-
                        ambiguous]
  -a {fail,warn,none}, --fail-action {fail,warn,none}
                        Action to take on an ambiguous codon [default: fail]
```

### Navigation

* [index](genindex.html "General Index")
* [next](extract_ids.html "extract-ids") |
* [previous](convert_mogrify.html "convert and mogrify") |
* [seqmagick documentation](index.html) »

© Copyright 2011-2023, The Matsen Group.
Created using [Sphinx](http://sphinx-doc.org/) 1.8.6.