# crussmap CWL Generation Report

## crussmap_view

### Tool Description
View chain file in tsv/csv format

### Metadata
- **Docker Image**: quay.io/biocontainers/crussmap:1.0.1--h5c46d4b_0
- **Homepage**: https://github.com/wjwei-handsome/crussmap
- **Package**: https://anaconda.org/channels/bioconda/packages/crussmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crussmap/overview
- **Total Downloads**: 2.8K
- **Last updated**: 2025-11-25
- **GitHub**: https://github.com/wjwei-handsome/crussmap
- **Stars**: N/A
### Original Help Text
```text
View chain file in tsv/csv format

Usage: crussmap view [OPTIONS]

Options:
  -i, --input <INPUT>    Input chain file: *.chain/*.chain.gz supported; if not set, read from STDIN
  -o, --output <OUTPUT>  Output file path, if not set, output to STDOUT
  -c, --csv              Output in csv format, default is false
  -r, --rewrite          Rewrite output file, default is false
  -h, --help             Print help
```


## crussmap_bed

### Tool Description
Converts BED file. Regions mapped to multiple locations to the new assembly will be split

### Metadata
- **Docker Image**: quay.io/biocontainers/crussmap:1.0.1--h5c46d4b_0
- **Homepage**: https://github.com/wjwei-handsome/crussmap
- **Package**: https://anaconda.org/channels/bioconda/packages/crussmap/overview
- **Validation**: PASS

### Original Help Text
```text
Converts BED file. Regions mapped to multiple locations to the new assembly will be split

Usage: crussmap bed [OPTIONS] --bed <BED>

Options:
  -b, --bed <BED>        bed file path
  -i, --input <INPUT>    input chain file path
  -o, --output <OUTPUT>  output bed file path, if not set, output to STDOUT
  -u, --unmap <UNMAP>    unmapped bed file path, if not set, output to STDOUT
  -r, --rewrite          rewrite output file, default is false
  -h, --help             Print help
```


## Metadata
- **Skill**: generated
