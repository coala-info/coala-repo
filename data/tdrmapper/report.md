# tdrmapper CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tdrmapper_TdrMappingScripts.pl | Failed | image problem: Rscript is missing in the image, so the documented top-50 coverage PDF plots are never made (mapping and tRF tables are correct on real human small RNA-seq) |

## tdrmapper_TdrMappingScripts.pl

### Tool Description
Map tRNA sequences to a reference tRNA database.

### Metadata
- **Docker Image**: quay.io/biocontainers/tdrmapper:1.1--pl526_3
- **Homepage**: https://github.com/sararselitsky/tDRmapper
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tdrmapper/overview
- **Total Downloads**: 21.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sararselitsky/tDRmapper
- **Stars**: N/A
### Original Help Text
```text
Usage:
     TdrMappingScripts.pl reference_trna.fa sample.fa
```

