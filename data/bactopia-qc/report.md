# bactopia-qc CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bactopia-qc | Failed | tool bug: the bactopia-qc script keeps unrendered Nextflow placeholders (bbduk.sh -Xmx!{xmx}, ain=!{params.ain}), so Java fails to start and every real read set ends as error FASTQs. |

## bactopia-qc

### Tool Description
Quality control of Illumina or Oxford Nanopore reads for Bactopia (read-pair repair, adapter and PhiX removal, coverage reduction, read statistics).

### Metadata
- **Docker Image**: quay.io/biocontainers/bactopia-qc:1.0.3--hdfd78af_0
- **Homepage**: https://bactopia.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bactopia-qc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bactopia-qc/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bactopia/bactopia-qc
- **Stars**: N/A
### Original Help Text
```text
bactopia-qc - v1.0.3

bactopia-qc <PREFIX> <RUNTYPE> <R1> <R2> <GENOME_SIZE_FILE> <OPT1> ... <OPTN>
```


