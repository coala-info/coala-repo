# ebolaseq CWL Generation Report

## ebolaseq

### Tool Description
Download and analyze Ebola virus sequences (v0.1.5)

### Metadata
- **Docker Image**: quay.io/biocontainers/ebolaseq:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/DaanJansen94/ebolaseq
- **Package**: https://anaconda.org/channels/bioconda/packages/ebolaseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ebolaseq/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2026-02-24
- **GitHub**: https://github.com/DaanJansen94/ebolaseq
- **Stars**: N/A
### Original Help Text
```text
usage: ebolaseq [-h] [--version] -o OUTPUT_DIR [-c CONSENSUS_FILE]
                [--remove REMOVE] [--phylogeny | --alignment]
                [--virus {1,2,3,4,5}] [--genome {1,2,3}]
                [--completeness COMPLETENESS] [--host {1,2,3}]
                [--metadata {1,2,3,4}] [--beast {1,2}]

Download and analyze Ebola virus sequences (v0.1.5)

options:
  -h, --help            show this help message and exit
  --version             show program's version number
  -o, --output-dir OUTPUT_DIR
                        Output directory for results
  -c, --consensus-file CONSENSUS_FILE
                        Path to consensus FASTA file to include
  --remove REMOVE       Path to text file containing headers/accession IDs to
                        remove
  --phylogeny, -p       Create phylogenetic tree using IQTree2
  --alignment, -a       Create multiple sequence alignment and trimming
                        (without phylogenetic tree)
  --virus {1,2,3,4,5}   Virus choice: 1=Zaire, 2=Sudan, 3=Bundibugyo, 4=Tai
                        Forest, 5=Reston
  --genome {1,2,3}      Genome type: 1=Complete, 2=Partial, 3=All
  --completeness COMPLETENESS
                        Minimum completeness percentage (1-100) when using
                        --genome 2
  --host {1,2,3}        Host: 1=Human, 2=Non-human, 3=All
  --metadata {1,2,3,4}  Metadata filter: 1=Location, 2=Date, 3=Both, 4=None
  --beast {1,2}         BEAST format: 1=No, 2=Yes
```

