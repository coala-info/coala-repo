# vartovcf CWL Generation Report

## vartovcf

### Tool Description
Convert variants from VarDict/VarDictJava into VCF v4.2 format.

### Metadata
- **Docker Image**: quay.io/biocontainers/vartovcf:1.4.0--h3ab6199_0
- **Homepage**: https://github.com/clintval/vartovcf
- **Package**: https://anaconda.org/channels/bioconda/packages/vartovcf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vartovcf/overview
- **Total Downloads**: 3.5K
- **Last updated**: 2025-12-18
- **GitHub**: https://github.com/clintval/vartovcf
- **Stars**: N/A
### Original Help Text
```text
vartovcf 1.4.0
Convert variants from VarDict/VarDictJava into VCF v4.2 format.

USAGE:
    vartovcf [FLAGS] [OPTIONS] --reference <reference> --sample <sample>

FLAGS:
        --skip-non-variants    Skip non-variant sites (where ref_allele == alt_allele)
    -h, --help                 Prints help information
    -V, --version              Prints version information

OPTIONS:
    -r, --reference <reference>    The indexed FASTA reference sequence file
    -s, --sample <sample>          The input sample name, must match input data stream
    -i, --input <input>            Input VAR file or stream [default: /dev/stdin]
    -o, --output <output>          Output VCF file or stream [default: /dev/stdout]
    -m, --mode <mode>              Variant calling mode [default: TumorOnly]  [possible values: TumorOnly]
```

