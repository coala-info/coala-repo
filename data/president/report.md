# president CWL Generation Report

## president

### Tool Description
Calculate pairwise nucleotide identity.

### Metadata
- **Docker Image**: quay.io/biocontainers/president:0.6.8--pyhdfd78af_0
- **Homepage**: https://gitlab.com/RKIBioinformaticsPipelines/president
- **Package**: https://anaconda.org/channels/bioconda/packages/president/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/president/overview
- **Total Downloads**: 35.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: president [-h] -r REFERENCE -q QUERY [QUERY ...] [-x ID_THRESHOLD]
                 [-n N_THRESHOLD] [-t THREADS] -p PATH [-f PREFIX] [-a] [-v]
                 [-e]

Calculate pairwise nucleotide identity.

options:
  -h, --help            show this help message and exit
  -r REFERENCE, --reference REFERENCE
                        Reference genome.
  -q QUERY [QUERY ...], --query QUERY [QUERY ...]
                        Query genome(s).
  -x ID_THRESHOLD, --id_threshold ID_THRESHOLD
                        ACGT nucleotide identity threshold after alignment
                        (percentage). A query sequence is reported as valid
                        based on this threshold (def: 0.9)
  -n N_THRESHOLD, --n_threshold N_THRESHOLD
                        A query sequence is reported as valid, if the
                        percentage of Ns is smaller or equal the threshold
                        (def: 0.05)
  -t THREADS, --threads THREADS
                        Number of threads to use for pblat.
  -p PATH, --path PATH  Path to be used to store results and FASTA files.
  -f PREFIX, --prefix PREFIX
                        Prefix to be used t store results in the path
  -a, --store_alignment
                        add query alignment columns (PSL format)
  -v, --version         show program's version number and exit
  -e, --quite           Print log messages also to the screen (False)
```


## Metadata
- **Skill**: generated
