# porfast CWL Generation Report

## porfast

### Tool Description
Extract ORFs from Paired-End reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/porfast:0.8.0--hbeb723e_0
- **Homepage**: https://github.com/telatin/porfast
- **Package**: https://anaconda.org/channels/bioconda/packages/porfast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/porfast/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/telatin/porfast
- **Stars**: N/A
### Original Help Text
```text
porfast

Extract ORFs from Paired-End reads.

Usage:
  porfast [options] 

Options:
  -1, --R1=R1                FASTQ file, first pair
  -2, --R2=R2                FASTQ file, second pair
  -m, --min-size=MIN_SIZE    Minimum ORF size (aa) (default: 26)
  -p, --prefix=PREFIX        Rename reads using this prefix
  --pool-size=POOL_SIZE      Size of the batch of reads to process per thread (default: 250)
  -v, --verbose              Print verbose info
  -j, --join                 Try joining paired ends
  --min-overlap=MIN_OVERLAP  Minimum PE overlap (default: 12)
  --max-overlap=MAX_OVERLAP  Maximum PE overlap (default: 200)
  --min-identity=MIN_IDENTITY
                             Minimum sequence identity in overlap (default: 0.85)
  -h, --help                 Show this help
```


## Metadata
- **Skill**: generated
