# pygcap CWL Generation Report

## pygcap

### Tool Description
Find Gene Cluster

### Metadata
- **Docker Image**: quay.io/biocontainers/pygcap:1.2.6--pyhdfd78af_0
- **Homepage**: https://github.com/jrim42/pyGCAP
- **Package**: https://anaconda.org/channels/bioconda/packages/pygcap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pygcap/overview
- **Total Downloads**: 6.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jrim42/pyGCAP
- **Stars**: N/A
### Original Help Text
```text
usage: pygcap [-h] [-w WORKING_DIR] [-t THREAD] [-i IDENTITY]
              [-m MAX_TARGET_SEQS]
              [-s {ncbi,mmseqs2,parsing,uniprot,blastdb,all}]
              TAXON probe_path

Find Gene Cluster

positional arguments:
  TAXON                 Taxon identifier
  probe_path            Probe file path

options:
  -h, --help            show this help message and exit
  -w WORKING_DIR, --working_dir WORKING_DIR
                        Working directory path
  -t THREAD, --thread THREAD
  -i IDENTITY, --identity IDENTITY
  -m MAX_TARGET_SEQS, --max_target_seqs MAX_TARGET_SEQS
  -s {ncbi,mmseqs2,parsing,uniprot,blastdb,all}, --skip {ncbi,mmseqs2,parsing,uniprot,blastdb,all}
                        Options to skip steps, e.g., ncbi, mmseqs2, parsing,
                        uniprot, blastdb or all
```

