# mhcgnomes CWL Generation Report

## mhcgnomes

### Tool Description
Parse MHC strings and print a table with parsed properties.

### Metadata
- **Docker Image**: quay.io/biocontainers/mhcgnomes:2.0.2--pyh106432d_0
- **Homepage**: https://github.com/til-unc/mhcgnomes
- **Package**: https://anaconda.org/channels/bioconda/packages/mhcgnomes/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mhcgnomes/overview
- **Total Downloads**: 10.6K
- **Last updated**: 2026-02-16
- **GitHub**: https://github.com/til-unc/mhcgnomes
- **Stars**: N/A
### Original Help Text
```text
usage: mhcgnomes [-h] [--default-species DEFAULT_SPECIES]
                 [--infer-class2-pairing]
                 [--max-allele-fields MAX_ALLELE_FIELDS]
                 [--format {table,tsv,json}] [--no-header] [--strict]
                 [names ...]

Parse MHC strings and print a table with parsed properties.

positional arguments:
  names                 MHC names to parse. If omitted, non-empty lines are
                        read from stdin.

options:
  -h, --help            show this help message and exit
  --default-species DEFAULT_SPECIES
                        Default species prefix used when the input is missing
                        one (default: HLA).
  --infer-class2-pairing
                        Infer canonical Class II alpha chain when only beta
                        chain is given.
  --max-allele-fields MAX_ALLELE_FIELDS
                        If set, restrict parsed alleles to this many fields.
  --format {table,tsv,json}
                        Output format (default: table).
  --no-header           Omit header row in table/tsv output.
  --strict              Exit with code 1 on the first parse error.
```

