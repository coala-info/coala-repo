# array-as-vcf CWL Generation Report

## array-as-vcf

### Tool Description
Convert an array file to VCF format

### Metadata
- **Docker Image**: quay.io/biocontainers/array-as-vcf:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/LUMC/array-as-vcf
- **Package**: https://anaconda.org/channels/bioconda/packages/array-as-vcf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/array-as-vcf/overview
- **Total Downloads**: 8.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LUMC/array-as-vcf
- **Stars**: N/A
### Original Help Text
```text
usage: array-as-vcf [-h] --path PATH [--build {GRCh37,GRCh38}] --sample-name
                    SAMPLE_NAME [--chr-prefix CHR_PREFIX]
                    [--lookup-table LOOKUP_TABLE] [--dump DUMP]
                    [--encoding ENCODING]
                    [--exclude-assays EXCLUDE_ASSAYS [EXCLUDE_ASSAYS ...]]
                    [--no-ensembl-lookup]
                    [--log-level {DEBUG,INFO,WARNING,ERROR}]

Convert an array file to VCF format

options:
  -h, --help            show this help message and exit
  --path PATH, -p PATH  Path to array file (default: None)
  --build {GRCh37,GRCh38}, -b {GRCh37,GRCh38}
                        Genome build (default: GRCh37)
  --sample-name SAMPLE_NAME, -s SAMPLE_NAME
                        Name of sample in VCF file (default: None)
  --chr-prefix CHR_PREFIX, -c CHR_PREFIX
                        Prefix to chromosome names (default: None)
  --lookup-table LOOKUP_TABLE, -l LOOKUP_TABLE
                        Path to existing lookup table for rsIDs (default:
                        None)
  --dump DUMP, -d DUMP  Path to write generated lookup table (default: None)
  --encoding ENCODING   Encoding of the array file (default: UTF-8)
  --exclude-assays EXCLUDE_ASSAYS [EXCLUDE_ASSAYS ...]
                        Assay IDs for OpenArray to ignore (default: None)
  --no-ensembl-lookup   Lookup missing rsIDs on Ensembl (default: False)
  --log-level {DEBUG,INFO,WARNING,ERROR}
                        Set the verbosity of the logger (default: INFO)
```


## Metadata
- **Skill**: generated
