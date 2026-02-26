# clinker-py CWL Generation Report

## clinker-py_clinker

### Tool Description
Automatic creation of publication-ready gene cluster comparison figures.

### Metadata
- **Docker Image**: quay.io/biocontainers/clinker-py:0.0.32--pyhdfd78af_0
- **Homepage**: https://github.com/gamcil/clinker
- **Package**: https://anaconda.org/channels/bioconda/packages/clinker-py/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clinker-py/overview
- **Total Downloads**: 33.1K
- **Last updated**: 2025-12-25
- **GitHub**: https://github.com/gamcil/clinker
- **Stars**: N/A
### Original Help Text
```text
usage: clinker [-h] [--version] [-r RANGES [RANGES ...]] [-gf GENE_FUNCTIONS]
               [-cm COLOUR_MAP] [-dso] [-asc] [-na] [-i IDENTITY] [-j JOBS]
               [-s SESSION] [-ji JSON_INDENT] [-f] [-o OUTPUT] [-p [PLOT]]
               [-dl DELIMITER] [-dc DECIMALS] [-hl] [-ha] [-mo MATRIX_OUT]
               [-ufo]
               [files ...]

clinker: Automatic creation of publication-ready gene cluster comparison figures.

clinker generates gene cluster comparison figures from GenBank files. It performs pairwise local or global alignments between every sequence in every unique pair of clusters and generates interactive, to-scale comparison figures using the clustermap.js library.

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

Input options:
  files                 Gene cluster GenBank files
  -r, --ranges RANGES [RANGES ...]
                        Scaffold extraction ranges. If a range is specified,
                        only features within the range will be extracted from
                        the scaffold. Ranges should be formatted like:
                        scaffold:start-end (e.g. scaffold_1:15000-40000)
  -gf, --gene_functions GENE_FUNCTIONS
                        2-column CSV file containing gene functions, used to
                        build gene groups from same function instead of
                        sequence similarity (e.g. GENE_001,PKS-NRPS).
  -cm, --colour_map COLOUR_MAP
                        2-column CSV file containing gene functions and
                        colours (e.g. GENE_001,#FF0000).
  -dso, --dont_set_origin
                        Don't fix features which cross the origin in circular
                        sequences (GenBank format only)
  -asc, --as_separate_clusters
                        Records will be parsed into separate clusters. Enable
                        this option when the GenBank file you downloaded from
                        NCBI contains multiple sequences.

Alignment options:
  -na, --no_align       Do not align clusters
  -i, --identity IDENTITY
                        Minimum alignment sequence identity [default: 0.3]
  -j, --jobs JOBS       Number of alignments to run in parallel (0 to use the
                        number of CPUs) [default: 0]

Output options:
  -s, --session SESSION
                        Path to clinker session
  -ji, --json_indent JSON_INDENT
                        Number of spaces to indent JSON [default: none]
  -f, --force           Overwrite previous output file
  -o, --output OUTPUT   Save alignments to file
  -p, --plot [PLOT]     Plot cluster alignments using clustermap.js. If a path
                        is given, clinker will generate a portable HTML file
                        at that path. Otherwise, the plot will be served
                        dynamically using Python's HTTP server.
  -dl, --delimiter DELIMITER
                        Character to delimit output by [default: human
                        readable]
  -dc, --decimals DECIMALS
                        Number of decimal places in output [default: 2]
  -hl, --hide_link_headers
                        Hide alignment column headers
  -ha, --hide_aln_headers
                        Hide alignment cluster name headers
  -mo, --matrix_out MATRIX_OUT
                        Save cluster similarity matrix to file

Visualisation options:
  -ufo, --use_file_order
                        Display clusters in order of input files

Example usage
-------------
Align clusters, plot results and print scores to screen:
  $ clinker files/*.gbk

Only save gene-gene links when identity is over 50%:
  $ clinker files/*.gbk -i 0.5

Save an alignment session for later:
  $ clinker files/*.gbk -s session.json

Save alignments to file, in comma-delimited format, with 4 decimal places:
  $ clinker files/*.gbk -o alignments.csv -dl "," -dc 4

Generate visualisation:
  $ clinker files/*.gbk -p

Save visualisation as a static HTML document:
  $ clinker files/*.gbk -p plot.html

Cameron Gilchrist, 2020
```

