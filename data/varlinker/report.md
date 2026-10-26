# varlinker CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| varlinker_variant-linker | Failed | tool bug: it downloads a 1.9 GB GENCODE file and assigns genes from other chromosomes (chr21:6120101 gets CHD5 from chr1), so the annotation is wrong |
| varlinker_variant-taltanno | Not completed | reads the annotation files that variant-linker builds from a 1.9 GB GENCODE download, and that annotation is wrong, so the output cannot be confirmed |
| varlinker_variant-trefanno | Not completed | reads the annotation files that variant-linker builds from a 1.9 GB GENCODE download, and that annotation is wrong, so the output cannot be confirmed |

## varlinker_variant-linker

### Tool Description
Links variants across different datasets.

### Metadata
- **Docker Image**: quay.io/biocontainers/varlinker:0.1.0--h4349ce8_0
- **Homepage**: https://github.com/IBCHgenomic/varlinker
- **Package**: https://anaconda.org/channels/bioconda/packages/varlinker/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/varlinker/overview
- **Total Downloads**: 162
- **Last updated**: 2025-06-18
- **GitHub**: https://github.com/IBCHgenomic/varlinker
- **Stars**: N/A
### Original Help Text
```text
error: unexpected argument '--h' found

  tip: a similar argument exists: '--help'

Usage: varlinker variant-linker --help <VCFILE>

For more information, try '--help'.
```


## varlinker_variant-trefanno

### Tool Description
extract the annotation of the specific ref allele

### Metadata
- **Docker Image**: quay.io/biocontainers/varlinker:0.1.0--h4349ce8_0
- **Homepage**: https://github.com/IBCHgenomic/varlinker
- **Package**: https://anaconda.org/channels/bioconda/packages/varlinker/overview
- **Validation**: PASS

### Original Help Text
```text
extract the annotation of the specific ref allele

Usage: varlinker variant-trefanno <VCFFILE> <REFALLELE>

Arguments:
  <VCFFILE>    variant VCF file
  <REFALLELE>  ref allele

Options:
  -h, --help  Print help
```


## varlinker_variant-taltanno

### Tool Description
extract the annotation of the specific alt allele

### Metadata
- **Docker Image**: quay.io/biocontainers/varlinker:0.1.0--h4349ce8_0
- **Homepage**: https://github.com/IBCHgenomic/varlinker
- **Package**: https://anaconda.org/channels/bioconda/packages/varlinker/overview
- **Validation**: PASS

### Original Help Text
```text
extract the annotation of the specific alt allele

Usage: varlinker variant-taltanno <VCFFILE> <ALTALLEL>

Arguments:
  <VCFFILE>   variant VCF file
  <ALTALLEL>  alt allele

Options:
  -h, --help  Print help
```


## Metadata
- **Skill**: generated
