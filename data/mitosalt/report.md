# mitosalt CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mitosalt | Failed | image problem: the image has BusyBox gzip, which cannot read the .tab file that MitoSAlt gzips to .tab.gz, so the deletion step reads nothing and breakpoint and cluster files stay empty (a planted 4977 bp deletion was missed; plot step also needs CONDA_ENV_BIN, set in the CWL) |
| mitosalt_se | Failed | image problem: the image has BusyBox gzip, which cannot read the .tab file that MitoSAlt gzips to .tab.gz, so the deletion step reads nothing and breakpoint and cluster files stay empty (a planted 4977 bp deletion was missed; plot step also needs CONDA_ENV_BIN, set in the CWL) |

## mitosalt

### Tool Description
MitoSAlt is a tool for analyzing mitochondrial DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitosalt:1.1.1--hdfd78af_3
- **Homepage**: https://sourceforge.net/projects/mitosalt/
- **Package**: https://anaconda.org/channels/bioconda/packages/mitosalt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mitosalt/overview
- **Total Downloads**: 598
- **Last updated**: 2026-02-04
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Use of uninitialized value $tag in concatenation (.) or string at /usr/local/bin/MitoSAlt1.1.1.pl line 24.
Configuration file missing, usage: perl mitopoint.pl <config_file> <fastq file 1> <fastq file 2> <study name> at /usr/local/bin/MitoSAlt1.1.1.pl line 27.
```

## mitosalt_se

### Tool Description
Detects mitochondrial DNA deletions and duplications and estimates copy number from single-end reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitosalt:1.1.1--hdfd78af_3
- **Homepage**: https://sourceforge.net/projects/mitosalt/
- **Package**: https://anaconda.org/channels/bioconda/packages/mitosalt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mitosalt_se <config_file> <fastq file> <study name>
```
