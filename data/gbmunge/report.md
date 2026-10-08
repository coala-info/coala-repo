# gbmunge CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gbmunge | Failed | tool bug: country columns are NA for current GenBank records because they use geo_loc_name instead of country; other columns match the expected table |

## gbmunge

### Tool Description
Extract from a GenBank flat file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gbmunge:2018.07.06--h7b50bb2_7
- **Homepage**: https://github.com/sdwfrost/gbmunge
- **Package**: https://anaconda.org/channels/bioconda/packages/gbmunge/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gbmunge/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sdwfrost/gbmunge
- **Stars**: N/A
### Original Help Text
```text
Error: No input filename specified.

Extract from a GenBank flat file.

Usage: gbmunge [-h] -i <Genbank_file> -f <sequence_output> -o <metadata_output> [-t] [-s]
```

