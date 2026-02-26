# duphold CWL Generation Report

## duphold

### Tool Description
duphold is a tool for calling structural variants (SVs) from long-read sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/duphold:0.2.1--hfb13731_0
- **Homepage**: https://github.com/brentp/duphold
- **Package**: https://anaconda.org/channels/bioconda/packages/duphold/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/duphold/overview
- **Total Downloads**: 61.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brentp/duphold
- **Stars**: N/A
### Original Help Text
```text
version: 0.2.1

  Usage: duphold [options]

Options:
  -v --vcf <path>           path to sorted SV VCF/BCF
  -b --bam <path>           path to indexed BAM/CRAM
  -f --fasta <path>         indexed fasta reference.
  -s --snp <path>           optional path to snp/indel VCF/BCF with which to annotate SVs. BCF is highly recommended as it's much faster to parse.
  -t --threads <int>        number of decompression threads. [default: 4]
  -o --output <string>      output VCF/BCF (default is VCF to stdout) [default: -]
  -d --drop                 drop all samples from a multi-sample --vcf *except* the sample in --bam. useful for parallelization by sample followed by merge.
  -h --help                 show help
```

