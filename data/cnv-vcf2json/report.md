# cnv-vcf2json CWL Generation Report

## cnv-vcf2json

### Tool Description
Convert CNVkit VCF to Beacon JSON format following the Progenetix pgxVariant schema

### Metadata
- **Docker Image**: quay.io/biocontainers/cnv-vcf2json:2.0.0
- **Homepage**: https://github.com/conda-forge/cnv-vcf2json-feedstock
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/cnv-vcf2json/overview
- **Total Downloads**: 4.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/conda-forge/cnv-vcf2json-feedstock
- **Stars**: N/A
### Original Help Text
```text
usage: cnv-vcf2json [-h] -o OUTPUT [--assembly ASSEMBLY] [--analysis ANALYSIS]
                    [--individual INDIVIDUAL] [--sequence SEQUENCE]
                    [--reference REFERENCE] [--fusion FUSION]
                    input

Convert CNVkit VCF to Beacon JSON format following the Progenetix pgxVariant
schema

positional arguments:
  input                 Input VCF file name

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output JSON file name
  --assembly ASSEMBLY   Assembly identifier (e.g. GRCh38); if omitted,
                        assemblyId will be excluded
  --analysis ANALYSIS   Analysis identifier (analysisId)
  --individual INDIVIDUAL
                        Individual identifier (individualId)
  --sequence SEQUENCE   Variant sequence
  --reference REFERENCE
                        Reference sequence
  --fusion FUSION       Fusion identifier (fusionId)
```


## Metadata
- **Skill**: not generated
