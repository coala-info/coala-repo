# pedesigner CWL Generation Report

## pedesigner

### Tool Description
A tool for designing prime editing guide RNAs (pegRNAs).

### Metadata
- **Docker Image**: quay.io/biocontainers/pedesigner:0.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/VeredKunik/pedesigner
- **Package**: https://anaconda.org/channels/bioconda/packages/pedesigner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pedesigner/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/VeredKunik/pedesigner
- **Stars**: N/A
### Original Help Text
```text
usage: pedesigner [-h] [-l L] [-m M] [--pbs_min PBS_MIN] [--pbs_max PBS_MAX]
                  [--rtt_min RTT_MIN] [--rtt_max RTT_MAX]
                  [--nick_min NICK_MIN] [--nick_max NICK_MAX] [--use_cpus]
                  ref_directory ind_directory pam ref_dir

positional arguments:
  ref_directory        Path of reference sequence file in FASTA format
  ind_directory        Path of reference sequence file in FASTA format
  pam                  PAM sequence
  ref_dir              Directory of reference genome file, in FASTA or 2bit
                       format

options:
  -h, --help           show this help message and exit
  -l L                 length of target without PAM
  -m M                 Mismatch number
  --pbs_min PBS_MIN    Minimum of PBS length
  --pbs_max PBS_MAX    Maximum of PBS length
  --rtt_min RTT_MIN    Minimum of RTT length
  --rtt_max RTT_MAX    Maximum of RTT length
  --nick_min NICK_MIN  Minimum of nicking distance
  --nick_max NICK_MAX  Maximum of nicking distance
  --use_cpus           Use cpu instead of gpu (cas-offinder)
```


## Metadata
- **Skill**: generated
