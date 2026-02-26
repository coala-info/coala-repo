# viralverify CWL Generation Report

## viralverify

### Tool Description
HMM-based virus and plasmid verification script

### Metadata
- **Docker Image**: quay.io/biocontainers/viralverify:1.1--hdfd78af_0
- **Homepage**: https://github.com/ablab/viralVerify
- **Package**: https://anaconda.org/channels/bioconda/packages/viralverify/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/viralverify/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ablab/viralVerify
- **Stars**: N/A
### Original Help Text
```text
['/usr/local/bin', '/usr/local/lib/python39.zip', '/usr/local/lib/python3.9', '/usr/local/lib/python3.9/lib-dynload', '/usr/local/lib/python3.9/site-packages', '/usr/local/bin/../scripts', '/usr/local/bin/../db']
usage: viralverify [-h] -f F -o O [--hmm HMM] [--db DB] [-t T] [--thr THR]
                   [-p]

HMM-based virus and plasmid verification script

required arguments:
  -f F       Input fasta file
  -o O       Output directory
  --hmm HMM  Path to HMM database

optional arguments:
  --db DB    Run BLAST on input contigs with provided database
  -t T       Number of threads
  --thr THR  Sensitivity threshold (minimal absolute score to classify
             sequence, default = 7)
  -p         Output predicted plasmids separately
```

