# hivtrace CWL Generation Report

## hivtrace

### Tool Description
HIV TRACE

### Metadata
- **Docker Image**: quay.io/biocontainers/hivtrace:1.5.0--py_0
- **Homepage**: https://github.com/veg/hivtrace
- **Package**: https://anaconda.org/channels/bioconda/packages/hivtrace/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hivtrace/overview
- **Total Downloads**: 16.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/veg/hivtrace
- **Stars**: N/A
### Original Help Text
```text
usage: hivtrace [-h] -i INPUT -a AMBIGUITIES -r REFERENCE -t THRESHOLD -m
                MINOVERLAP -g FRACTION [-u CURATE] [-f FILTER]
                [-s STRIP_DRAMS] [-c] [--do-not-store-intermediate]
                [--skip-alignment] [--attributes-file ATTRIBUTES_FILE]
                [--log LOG] [-o OUTPUT] [-p PRIOR]

HIV TRACE

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        FASTA file
  -a AMBIGUITIES, --ambiguities AMBIGUITIES
                        handle ambiguous nucleotides using the specified
                        strategy
  -r REFERENCE, --reference REFERENCE
                        reference to align to
  -t THRESHOLD, --threshold THRESHOLD
                        Only count edges where the distance is less than this
                        threshold
  -m MINOVERLAP, --minoverlap MINOVERLAP
                        Minimum Overlap
  -g FRACTION, --fraction FRACTION
                        Fraction
  -u CURATE, --curate CURATE
                        Filter contaminants
  -f FILTER, --filter FILTER
                        Edge filtering option
  -s STRIP_DRAMS, --strip_drams STRIP_DRAMS
                        Read in an aligned Fasta file (HIV prot/rt sequences)
                        and remove DRAM (drug resistance associated mutation)
                        codon sites. It will output a new alignment with these
                        sites removed. It requires input/output file names
                        along with the list of DRAM sites to remove: 'lewis'
                        or 'wheeler'.
  -c, --compare         Compare to supplied FASTA file
  --do-not-store-intermediate
                        Store intermediate files
  --skip-alignment      Skip alignment
  --attributes-file ATTRIBUTES_FILE
                        Annotate with attributes
  --log LOG             Write logs to specified directory
  -o OUTPUT, --output OUTPUT
                        Specify output filename
  -p PRIOR, --prior PRIOR
                        Prior network configuration
```

