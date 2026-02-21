# pdivas CWL Generation Report

## pdivas_predict

### Tool Description
Add PDIVAS annotation to a VCF file and predict deep-intronic variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/pdivas:1.2.0--pyh7e72e81_0
- **Homepage**: https://github.com/shiro-kur/PDIVAS
- **Package**: https://anaconda.org/channels/bioconda/packages/pdivas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pdivas/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shiro-kur/PDIVAS
- **Stars**: N/A
### Original Help Text
```text
usage: pdivas predict [-h] -I input.vcf/vcf.gz -O output.vcf/vcf.gz
                      [-F filtering:off/on]

options:
  -h, --help            show this help message and exit
  -I input.vcf/vcf.gz   The path to the vcf(.gz) file to add PDIVAS annotation
  -O output.vcf/vcf.gz  The path to output vcf(.gz) file name and pass
  -F filtering:off/on   Output all variants (-F off; default) or only deep-
                        intronic variants with PDIVAS scores (-F on)
```


## pdivas_vcf2tsv

### Tool Description
Convert PDIVAS annotated VCF files to TSV format

### Metadata
- **Docker Image**: quay.io/biocontainers/pdivas:1.2.0--pyh7e72e81_0
- **Homepage**: https://github.com/shiro-kur/PDIVAS
- **Package**: https://anaconda.org/channels/bioconda/packages/pdivas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pdivas vcf2tsv [-h] -I input.vcf/vcf.gz -O output.tsv

options:
  -h, --help           show this help message and exit
  -I input.vcf/vcf.gz  The path to the vcf(.gz) file with PDIVAS annotation
  -O output.tsv        The path to output tsv file name and pass
```


## Metadata
- **Skill**: generated
