# parallel-fastq-dump CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| parallel-fastq-dump | Failed | image problem: sra-tools 2.10.9 in the image has no CA bundle (TLS error 'certificate is not correctly signed'), so sra-stat and fastq-dump cannot reach NCBI. |

## parallel-fastq-dump

### Tool Description
parallel fastq-dump wrapper, extra args will be passed through

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-fastq-dump:0.6.7--pyhdfd78af_0
- **Homepage**: https://github.com/rvalieris/parallel-fastq-dump
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-fastq-dump/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/parallel-fastq-dump/overview
- **Total Downloads**: 81.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rvalieris/parallel-fastq-dump
- **Stars**: N/A
### Original Help Text
```text
usage: parallel-fastq-dump [-h] [-s SRA_ID] [-t THREADS] [-O OUTDIR]
                           [-T TMPDIR] [-N MINSPOTID] [-X MAXSPOTID] [-V]

parallel fastq-dump wrapper, extra args will be passed through

optional arguments:
  -h, --help            show this help message and exit
  -s SRA_ID, --sra-id SRA_ID
                        SRA id (default: None)
  -t THREADS, --threads THREADS
                        number of threads (default: 1)
  -O OUTDIR, --outdir OUTDIR
                        output directory (default: .)
  -T TMPDIR, --tmpdir TMPDIR
                        temporary directory (default: None)
  -N MINSPOTID, --minSpotId MINSPOTID
                        Minimum spot id (default: 1)
  -X MAXSPOTID, --maxSpotId MAXSPOTID
                        Maximum spot id (default: None)
  -V, --version         shows version (default: False)

DESCRIPTION:
Example: parallel-fastq-dump --sra-id SRR2244401 --threads 4 --outdir out/ --split-files --gzip
```


## Metadata
- **Skill**: generated

