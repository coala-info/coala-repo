# kcalign CWL Generation Report

## kcalign_kc-align

### Tool Description
Align a sequence against multiple others in a codon-aware fashion.

### Metadata
- **Docker Image**: quay.io/biocontainers/kcalign:1.0.2--py_0
- **Homepage**: https://github.com/davebx/kc-align
- **Package**: https://anaconda.org/channels/bioconda/packages/kcalign/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kcalign/overview
- **Total Downloads**: 62.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/davebx/kc-align
- **Stars**: N/A
### Original Help Text
```text
usage: kc-align [-h] --reference REFERENCE --sequences SEQS [--start START]
                [--end END] --mode {genome,gene,mixed} [--compress]
                [--table TABLE] [--keep]
                [--dist {very-close,close,semi-close,less-close,none}]
                [--threads THREADS]

Align a sequence against multiple others in a codon-aware fashion.

optional arguments:
  -h, --help            show this help message and exit
  --reference REFERENCE, -r REFERENCE
                        Reference sequence
  --sequences SEQS, -S SEQS
                        Other sequences to align
  --start START, -s START
                        1-based start position (required in genome mode)
  --end END, -e END     1-based end position (required in genome mode)
  --mode {genome,gene,mixed}, -m {genome,gene,mixed}
                        Alignment mode (genome, gene, or mixed) (required)
  --compress, -c        Compress identical sequences
  --table TABLE, -t TABLE
                        Choose alternative translation table (See https://www.
                        ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi for
                        values)
  --keep, -k            Keep translated pre-alignment sequences file named
                        pre_align.fasta, otherwise will delete
  --dist {very-close,close,semi-close,less-close,none}, -d {very-close,close,semi-close,less-close,none}
                        For genome/mixed mode, determines the max distance a
                        homologous sequence can be before it is discarded from
                        the alignment (default = none). Distance limits: none
                        < very-close < close < semi-close < less-close
  --threads THREADS, -th THREADS
                        Number of simultaneous threads to use (must be a
                        multiple of 3)

Performs a codon-aware (aka translation) multiple sequence alignment. Can be
run in 3 different modes depending on the input. See the documentation for
more information: https://github.com/galaxyproject/kc-align
```

