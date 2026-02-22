# cramino CWL Generation Report

## cramino

### Tool Description
Tool to extract QC metrics from cram or bam

### Metadata
- **Docker Image**: quay.io/biocontainers/cramino:1.3.0--h3dc2dae_0
- **Homepage**: https://github.com/wdecoster/cramino
- **Package**: https://anaconda.org/channels/bioconda/packages/cramino/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cramino/overview
- **Total Downloads**: 15.6K
- **Last updated**: 2025-12-27
- **GitHub**: https://github.com/wdecoster/cramino
- **Stars**: N/A
### Original Help Text
```text
Tool to extract QC metrics from cram or bam

Usage: cramino [OPTIONS] [INPUT]

Arguments:
  [INPUT]  cram or bam file to check [default: -]

Options:
  -t, --threads <THREADS>            Number of parallel decompression threads to use [default: 4]
      --reference <REFERENCE>        reference for decompressing cram
  -m, --min-read-len <MIN_READ_LEN>  Minimal length of read to be considered [default: 0]
      --hist [<FILE>]                If histograms have to be generated (optionally specify output file)
      --arrow <ARROW>                Write data to an arrow format file
      --karyotype                    Provide normalized number of reads per chromosome
      --phased                       Calculate metrics for phased reads
      --spliced                      Provide metrics for spliced data
      --ubam                         Provide metrics for unaligned reads
      --format <FORMAT>              Output format (text, json, or tsv) [default: text]
      --scaled                       Scale histogram bins by total basepairs in each bin (not just read count)
      --hist-count [<FILE>]          Output histogram bin counts in TSV format (optionally specify output file)
  -h, --help                         Print help
  -V, --version                      Print version
```


## Metadata
- **Skill**: generated
