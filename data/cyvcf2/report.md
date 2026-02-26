# cyvcf2 CWL Generation Report

## cyvcf2

### Tool Description
fast vcf parsing with cython + htslib

### Metadata
- **Docker Image**: quay.io/biocontainers/cyvcf2:0.31.4--py310h4de444c_1
- **Homepage**: https://github.com/brentp/cyvcf2
- **Package**: https://anaconda.org/channels/bioconda/packages/cyvcf2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cyvcf2/overview
- **Total Downloads**: 897.0K
- **Last updated**: 2026-02-24
- **GitHub**: https://github.com/brentp/cyvcf2
- **Stars**: N/A
### Original Help Text
```text
Usage: cyvcf2 [OPTIONS] <vcf_file> or -

  fast vcf parsing with cython + htslib

Options:
  -c, --chrom TEXT                Specify what chromosome to include.
  -s, --start INTEGER             Specify the start of region.
  -e, --end INTEGER               Specify the end of the region.
  --include TEXT                  Specify what info field to include.
  --exclude TEXT                  Specify what info field to exclude.
  -i, --individual TEXT           Only print genotype call for individual.
  --no-inds                       Do not print genotypes.
  --loglevel [DEBUG|INFO|WARNING|ERROR|CRITICAL]
                                  Set the level of log output.  [default:
                                  INFO]
  --silent                        Skip printing of vcf.
  --help                          Show this message and exit.
```

