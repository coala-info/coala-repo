# cutqc CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cutqc_cutqc | PASS |  |
| cutqc_qc_only | PASS |  |

## cutqc_cutqc

### Tool Description
Performs quality control on sequencing reads, optionally with adapter trimming.

### Metadata
- **Docker Image**: quay.io/biocontainers/cutqc:0.07--hdfd78af_0
- **Homepage**: https://github.com/obenno/cutqc
- **Package**: https://anaconda.org/channels/bioconda/packages/cutqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cutqc/overview
- **Total Downloads**: 5.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/obenno/cutqc
- **Stars**: N/A
### Original Help Text
```text
cutqc.sh <cutqc> in_read1.fq.gz in_read2.fq.gz out_report.html [cutadapt_option]

cutqc.sh <qc_only> in_read.fq.gz [output_report.html]

cutqc has two valid subcommands:
    cutqc:
        Take pair-end inputs (R1.fq.gz and R2.fq.gz) and perform cutadapt in pair-end mode.
        Fastqc will be performed both before and after trimming. The first three arguments
        are mandatory and positional, all the following options will be parsed to cutadapt,
        please refer to cutadapt manual for full option list.

    qc_only:
        Take one single fastq file as input and perfom fastqc only.

Please note only gzipped input file(s) are supported.
```


## cutqc_qc_only

### Tool Description
Take one single fastq file as input and perfom fastqc only.

### Metadata
- **Docker Image**: quay.io/biocontainers/cutqc:0.07--hdfd78af_0
- **Homepage**: https://github.com/obenno/cutqc
- **Package**: https://anaconda.org/channels/bioconda/packages/cutqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cutqc/overview
- **Total Downloads**: 5.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/obenno/cutqc
- **Stars**: N/A
### Original Help Text
```text

cutqc.sh <cutqc> in_read1.fq.gz in_read2.fq.gz out_report.html [cutadapt_option]

cutqc.sh <qc_only> in_read.fq.gz [output_report.html]

cutqc has two valid subcommands:
    cutqc:
        Take pair-end inputs (R1.fq.gz and R2.fq.gz) and perform cutadapt in pair-end mode.
        Fastqc will be performed both before and after trimming. The first three arguments
        are mandatory and positional, all the following options will be parsed to cutadapt,
        please refer to cutadapt manual for full option list.

    qc_only:
        Take one single fastq file as input and perfom fastqc only.

Please note only gzipped input file(s) are supported.
```

## Metadata
- **Skill**: generated
