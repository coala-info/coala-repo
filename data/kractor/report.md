# kractor CWL Generation Report

## kractor

### Tool Description
Extract reads from a FASTQ file based on taxonomic classification via Kraken2.

### Metadata
- **Docker Image**: quay.io/biocontainers/kractor:4.0.0--h4349ce8_0
- **Homepage**: https://github.com/Sam-Sims/kractor
- **Package**: https://anaconda.org/channels/bioconda/packages/kractor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kractor/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/Sam-Sims/kractor
- **Stars**: N/A
### Original Help Text
```text
Extract reads from a FASTQ file based on taxonomic classification via Kraken2.

Usage: kractor [OPTIONS] --input [<INPUT>...] --output [<OUTPUT>...] --kraken <KRAKEN> --taxid <TAXID>...

Options:
  -i, --input [<INPUT>...]
          Input file path(s). Accepts up to 2 files (for paired-end reads)
  -o, --output [<OUTPUT>...]
          Output file path(s). Accepts up to 2 files (for paired-end reads)
  -k, --kraken <KRAKEN>
          Kraken2 stdout file path
  -r, --report <REPORT>
          Kraken2 report file path
  -t, --taxid <TAXID>...
          One or more taxon IDs to extract reads for
  -p, --parents
          Include all parent taxon IDs in the output. Requires a Kraken2 report file
  -c, --children
          Include all child taxon IDs in the output. Requires a Kraken2 report file
      --compression-format <OUTPUT_TYPE>
          Compression format for output files (gz, bz2). Overides the inferred format
      --compression-level <COMPRESSION_LEVEL>
          Compression level (1-9) [default: 2]
      --exclude
          Exclude specified taxon IDs from the output
      --output-fasta
          Output results in FASTA format
      --summary
          Enable a JSON summary output written to stdout
      --no-header-detect
          Disable detection and skipping of any header lines in the Kraken2 report
  -v, --verbose
          Enable verbose output
  -h, --help
          Print help
  -V, --version
          Print version
```

