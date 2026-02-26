# vcf-reformatter CWL Generation Report

## vcf-reformatter

### Tool Description
A Rust command-line tool for parsing and reformatting VCF (Variant Call Format) files, with support for VEP (Variant Effect Predictor) and SnpEff annotations. This tool flattens complex VCF files into tab-separated values (TSV) or Mutation Annotation Format (MAF) for easier downstream analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf-reformatter:0.3.0--h4349ce8_0
- **Homepage**: https://github.com/flalom/vcf-reformatter
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf-reformatter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcf-reformatter/overview
- **Total Downloads**: 603
- **Last updated**: 2025-08-15
- **GitHub**: https://github.com/flalom/vcf-reformatter
- **Stars**: N/A
### Original Help Text
```text
A Rust command-line tool for parsing and reformatting VCF (Variant Call Format) files, with support for VEP (Variant Effect Predictor) and SnpEff annotations. This tool flattens complex VCF files into tab-separated values (TSV) or Mutation Annotation Format (MAF) for easier downstream analysis.

Usage: vcf-reformatter [OPTIONS] <INPUT_FILE>

Arguments:
  <INPUT_FILE>
          Input VCF file (supports .vcf.gz compressed files)

Options:
  -a, --annotation-type <ANNOTATION_TYPE>
          Annotation type to parse
          
          [default: auto]

          Possible values:
          - vep:    VEP annotations (CSQ field)
          - snpeff: SnpEff annotations (ANN field)
          - auto:   Auto-detect from header

  -t, --transcript-handling <TRANSCRIPT_HANDLING>
          Transcript handling mode
          
          [default: first]

          Possible values:
          - most-severe: Extract only the most severe consequence for each variant
          - first:       Keep first transcript only (fastest)
          - split:       Split every transcript into separate rows

  -j, --threads <THREADS>
          Number of threads to use for parallel processing (0 = auto-detect)
          
          [default: 1]

  -o, --output-dir <OUTPUT_DIR>
          Output directory (default: current directory)

  -p, --prefix <PREFIX>
          Prefix for output files (default: input filename)

  -v, --verbose
          Verbose output

  -c, --compress
          Compress output files with gzip

      --output-format <OUTPUT_FORMAT>
          Output format: tsv or maf
          
          [default: tsv]

          Possible values:
          - tsv: Tab-separated values (default)
          - maf: Mutation Annotation Format

      --center <CENTER>
          Center name for MAF output (auto-detected from header if not provided)

      --ncbi-build <NCBI_BUILD>
          NCBI build for MAF output (auto-detected from header, defaults to GRCh38)
          
          [default: GRCh38]

      --sample-barcode <SAMPLE_BARCODE>
          Sample barcode for MAF output (auto-detected from header if not provided)

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version

EXAMPLES:
    Basic usage (auto-detect annotation type):
      vcf-reformatter sample.vcf.gz

    Generate MAF output (auto-detects metadata from header):
      vcf-reformatter sample.vcf.gz --output-format maf

    Generate MAF output with manual parameters:
      vcf-reformatter sample.vcf.gz --output-format maf --center TCGA --sample-barcode TCGA-01

    Use VEP annotations with most severe consequence:
      vcf-reformatter sample.vcf.gz -a vep -t most-severe -j 4

    Use SnpEff annotations with all transcripts:
      vcf-reformatter sample.vcf.gz -a snpeff -t split -o results/ -p analysis

    Auto-detect annotation type with parallel processing:
      vcf-reformatter sample.vcf.gz -a auto -j 0 -v

    Complete example with SnpEff and compression:
      vcf-reformatter sample.vcf.gz -a snpeff -t most-severe -j 4 -o results/ -p my_analysis -v --compress
```

