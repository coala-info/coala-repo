# minced CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| minced | PASS |  |

## minced

### Tool Description
MinCED, a program to find CRISPRs in shotgun DNA sequences or full genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/minced:0.4.2--0
- **Homepage**: https://github.com/ctSkennerton/minced
- **Package**: https://anaconda.org/channels/bioconda/packages/minced/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/minced/overview
- **Total Downloads**: 200.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ctSkennerton/minced
- **Stars**: N/A
### Original Help Text
```text
MinCED, a program to find CRISPRs in shotgun DNA sequences or full genomes

Usage:    minced [options] file.fa [outputFile.txt] [outputFile.gff]

Options:  -searchWL  Length of search window used to discover CRISPRs (range: 6-9). Default: 8
          -minNR     Minimum number of repeats a CRISPR must contain. Default: 3
          -minRL     Minimum length of the CRISPR repeats. Default: 23
          -maxRL     Maximum length of the CRISPR repeats. Default: 47
          -minSL     Minimum length of the CRISPR spacers. Default: 26
          -maxSL     Maximum length of the CRISPR spacers. Default: 50
          -gff       Output summary results in gff format containing
                     only the positions of the CRISPR arrays. Default: false
          -gffFull   Output detailed results in gff format containing
                     positions of CRISPR arrays and all repeat units. Default: false
          -spacers   Output a fasta formatted file containing the spacers. Default: false
          -h --help  Output this handy help message
          --version  Output version information

Examples: minced ecoli.fna
          minced metagenome.fna
          minced metagenome.fna metagenome.crisprs
          minced metagenome.fna metagenome.crisprs metagenome.gff

2026/10/01 20:22:20  warn rootless{dev/console} creating empty file in place of device 5:1
WARNING: Skipping mount /etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
```
