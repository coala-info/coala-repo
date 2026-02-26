# ucsc-chainprenet CWL Generation Report

## ucsc-chainprenet_chainPreNet

### Tool Description
Remove chains that don't have a chance of being netted

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-chainprenet:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-chainprenet/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-chainprenet/overview
- **Total Downloads**: 29.9K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
chainPreNet - Remove chains that don't have a chance of being netted
usage:
   chainPreNet in.chain target.sizes query.sizes out.chain
options:
   -dots=N - output a dot every so often
   -pad=N - extra to pad around blocks to decrease trash
            (default 1)
   -inclHap - include query sequences name in the form *_hap*|*_alt*.
              Normally these are excluded from nets as being haplotype
              pseudochromosomes
```

