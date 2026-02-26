# vcfbub CWL Generation Report

## vcfbub

### Tool Description
Filter vg deconstruct output using variant nesting information.
This uses the snarl tree decomposition to describe the nesting of variant bubbles.
Nesting information must be given in LV (level) and PS (parent snarl) tags.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfbub:0.1.2--hc1c3326_1
- **Homepage**: https://github.com/pangenome/vcfbub
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfbub/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcfbub/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-07-22
- **GitHub**: https://github.com/pangenome/vcfbub
- **Stars**: N/A
### Original Help Text
```text
vcfbub 0.1.0
Erik Garrison <erik.garrison@gmail.com>

Filter vg deconstruct output using variant nesting information.
This uses the snarl tree decomposition to describe the nesting of variant bubbles.
Nesting information must be given in LV (level) and PS (parent snarl) tags.

USAGE:
    vcfbub [FLAGS] [OPTIONS] --input <FILE>

FLAGS:
    -d, --debug      Print debugging information about which sites are removed.
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -i, --input <FILE>                  Filter this input VCF file.
    -a, --max-allele-length <LENGTH>    Filter sites whose max allele length is greater than LENGTH.
    -l, --max-level <LEVEL>             Filter sites with LV > LEVEL.
    -r, --max-ref-length <LENGTH>       Filter sites whose reference allele is longer than LENGTH.
```

