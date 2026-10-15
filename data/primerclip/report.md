# primerclip CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| primerclip | PASS | ARTIC v3 SARS-CoV-2 paired reads trimmed correctly; a read with an unmapped mate stops the run early (tool limit), so only properly paired reads were used. |

## primerclip

### Tool Description
Trim PCR primer sequences from aligned reads

### Metadata
- **Docker Image**: quay.io/biocontainers/primerclip:0.3.8--0
- **Homepage**: https://github.com/swiftbiosciences/primerclip
- **Package**: https://anaconda.org/channels/bioconda/packages/primerclip/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/primerclip/overview
- **Total Downloads**: 4.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/swiftbiosciences/primerclip
- **Stars**: N/A
### Original Help Text
```text
primerclip -- Swift Biosciences Accel-Amplicon targeted panel primer trimming
tool v0.3.8

Usage: primerclip [-b|--bedpe] [-s|--single-end] PRIMER_COORDS_INFILE SAM_INFILE
                  OUTPUT_SAM_FILENAME
  Trim PCR primer sequences from aligned reads

Available options:
  -h,--help                Show this help text
  -b,--bedpe               add this switch to use BEDPE coordinate input format
                           (default format is master file)
  -s,--single-end          add this switch to trim primers from single-end
                           alignments
```

