# phasius CWL Generation Report

## phasius

### Tool Description
Tool to draw a map of phaseblocks across crams/bams

### Metadata
- **Docker Image**: quay.io/biocontainers/phasius:0.7.0--ha6fb395_0
- **Homepage**: https://github.com/wdecoster/phasius
- **Package**: https://anaconda.org/channels/bioconda/packages/phasius/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phasius/overview
- **Total Downloads**: 4.4K
- **Last updated**: 2026-01-18
- **GitHub**: https://github.com/wdecoster/phasius
- **Stars**: N/A
### Original Help Text
```text
Tool to draw a map of phaseblocks across crams/bams

Usage: phasius [OPTIONS] --output <OUTPUT> --region <REGION> <FILE>...

Arguments:
  <FILE>...  cram or bam files to check

Options:
  -b, --bed <BED>                      bed file annotation to use (bgzipped and tabix indexed)
  -t, --threads <THREADS>              Number of crams/bams to parse in parallel [default: 4]
  -d, --decompression <DECOMPRESSION>  Number of decompression threads to use per cram/bam [default: 1]
  -o, --output <OUTPUT>                HTML output file name
  -r, --region <REGION>                region string to plot phase blocks from
  -w, --width <WIDTH>                  line width
      --summary <SUMMARY>              summary file
      --strict                         strictly plot the begin and end of the specified interval, not the whole interval gathered from blocks
  -h, --help                           Print help
  -V, --version                        Print version
```


## Metadata
- **Skill**: generated
