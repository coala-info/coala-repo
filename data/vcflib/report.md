# vcflib CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| vcflib_vcfhethomratio | Failed | tool bug: vcfhethomratio counts missing genotypes (./.) as homozygous non-reference, so the ratio is too low (tested with a 4-site file: gives 0.33, expected 0.5) |

## Metadata
- **Skill**: generated

## vcflib_vcfhethomratio

### Tool Description
Calculate the heterozygosity/homozygosity ratio for each sample in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcflib:1.0.14--h34261f4_0
- **Homepage**: https://github.com/vcflib/vcflib
- **Package**: https://anaconda.org/channels/bioconda/packages/vcflib/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/vcflib:1.0.14--h34261f4_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

