# n50 CWL Generation Report

## n50

### Tool Description
Calculate sequence statistics (N50, GC%, length stats) for FASTA/FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
- **Homepage**: http://metacpan.org/pod/Proch::N50
- **Package**: https://anaconda.org/channels/bioconda/packages/n50/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/n50/overview
- **Total Downloads**: 108.2K
- **Last updated**: 2025-07-08
- **GitHub**: https://github.com/quadram-institute-bioscience/n50
- **Stars**: N/A
### Original Help Text
```text
Usage: n50 [options] FILES...

Calculate sequence statistics (N50, GC%, length stats) for FASTA/FASTQ files.

Arguments:
  FILES           One or more FASTA/FASTQ files, gzipped or not. '-' for STDIN.

Options:
  -a, --abs       Print file paths as absolute paths
  -b, --basename  Print file paths as basename only (e.g., file.fq.gz)
  -j, --json      Output results in JSON format
  -c, --csv       Output results in CSV format (default is TSV)
  -n, --nice      Output results in a visually aligned ASCII table
  -h, --help      Show this help message and exit
  -v, --version   Show version number and exit

Output Columns (TSV/CSV):
  Filepath, TotSeqs, TotLen, N50, N75, N90, I50, GC, Avg, Min, Max, AuN
```

