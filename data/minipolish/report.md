# minipolish CWL Generation Report

## minipolish

### Tool Description
Minipolish

### Metadata
- **Docker Image**: quay.io/biocontainers/minipolish:0.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Minipolish
- **Package**: https://anaconda.org/channels/bioconda/packages/minipolish/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/minipolish/overview
- **Total Downloads**: 9.5K
- **Last updated**: 2025-06-13
- **GitHub**: https://github.com/rrwick/Minipolish
- **Stars**: N/A
### Original Help Text
```text
tput: No value for $TERM and no -T specified
usage: minipolish [-t THREADS] [--rounds ROUNDS]
                  [--minimap2-preset {map-ont,lr:hq,map-pb,map-hifi}]
                  [--pacbio] [--skip_initial] [-h] [--version]
                  reads assembly

Minipolish

Positional arguments:
  reads                   Long reads for polishing (FASTA or FASTQ format)
  assembly                Miniasm assembly to be polished (GFA format)

Settings:
  -t THREADS, --threads THREADS
                          Number of threads to use for alignment and polishing
                          (default: 16)
  --rounds ROUNDS         Number of full Racon polishing rounds (default: 2)
  --minimap2-preset {map-ont,lr:hq,map-pb,map-hifi}
                          minimap2 preset to use: "map-ont" for Oxford
                          Nanopore reads with <Q20 accuracy, "lr:hq" for
                          Oxford Nanopore reads with Q20+ accuracy, "map-pb"
                          for PacBio CLR or "map-hifi" for PacBio HiFi/CCS
                          (default: map-ont)
  --pacbio                Deprecated: equivalent to --minimap2-preset map-pb.
                          Retained for backwards compatibility.
  --skip_initial          Skip the initial polishing round - appropriate if
                          the input GFA does not have "a" lines (default: do
                          the initial polishing round)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```

