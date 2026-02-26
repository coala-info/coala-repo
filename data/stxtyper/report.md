# stxtyper CWL Generation Report

## stxtyper

### Tool Description
Determine stx type(s) of a genome, print .tsv-file

### Metadata
- **Docker Image**: quay.io/biocontainers/stxtyper:1.0.25--hdcf5f25_0
- **Homepage**: https://github.com/ncbi/stxtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/stxtyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/stxtyper/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ncbi/stxtyper
- **Stars**: N/A
### Original Help Text
```text
Determine stx type(s) of a genome, print .tsv-file

USAGE:   stxtyper [--nucleotide NUC_FASTA] [--name NAME] [--output OUTPUT_FILE] [--blast_bin BLAST_DIR] [--amrfinder] [--print_node] [--nucleotide_output NUC_FASTA_OUT] [--debug] [--log LOG] [--quiet]
HELP:    stxtyper --help or stxtyper -h
VERSION: stxtyper --version or stxtyper -v

NAMED PARAMETERS
-n NUC_FASTA, --nucleotide NUC_FASTA
    Input nucleotide FASTA file (can be gzipped)
--name NAME
    Text to be added as the first column "name" to all rows of the report, for example it can be an assembly name
-o OUTPUT_FILE, --output OUTPUT_FILE
    Write output to OUTPUT_FILE instead of STDOUT
--blast_bin BLAST_DIR
    Directory for BLAST. Deafult: $BLAST_BIN
--amrfinder
    Print output in the nucleotide AMRFinderPlus format
--print_node
    Print AMRFinderPlus hierarchy node
--nucleotide_output NUC_FASTA_OUT
    Output nucleotide FASTA file of reported nucleotide sequences
--debug
    Integrity checks
--log LOG
    Error log file, appended, opened on application start
-q, --quiet
    Suppress messages to STDERR

Temporary directory used is $TMPDIR or "/tmp"
```

