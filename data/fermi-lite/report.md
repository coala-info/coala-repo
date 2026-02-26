# fermi-lite CWL Generation Report

## fermi-lite_fml-asm

### Tool Description
Assembly of short reads using the Fermi-lite algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi-lite:0.1--h577a1d6_8
- **Homepage**: https://github.com/lh3/fermi-lite
- **Package**: https://anaconda.org/channels/bioconda/packages/fermi-lite/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fermi-lite/overview
- **Total Downloads**: 10.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lh3/fermi-lite
- **Stars**: N/A
### Original Help Text
```text
Usage: fml-asm [options] <in.fq>
Options:
  -e INT          k-mer length for error correction (0 for auto; -1 to disable) [0]
  -c INT1[,INT2]  range of k-mer & read count thresholds for ec and graph cleaning [4,8]
  -l INT          min overlap length during initial assembly [33]
  -r FLOAT        drop an overlap if its length is below maxOvlpLen*FLOAT [0.7]
  -t INT          number of threads (don't use multi-threading for small data sets) [1]
  -A              discard heterozygotes (apply this to assemble bacterial genomes)
```

