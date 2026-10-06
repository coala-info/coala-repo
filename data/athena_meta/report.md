# athena_meta CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| athena_meta_athena-meta | PASS |  |

## athena_meta_athena-meta

### Tool Description
Athena Meta: A pipeline for assembling metagenomes

### Metadata
- **Docker Image**: quay.io/biocontainers/athena_meta:1.3--py27_0
- **Homepage**: https://github.com/abishara/athena_meta/
- **Package**: https://anaconda.org/channels/bioconda/packages/athena_meta/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/athena_meta/overview
- **Total Downloads**: 10.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/abishara/athena_meta
- **Stars**: N/A
### Original Help Text
```text
usage: athena-meta [-h] [--config CONFIG] [--check_prereqs] [--test]
                   [--force_reads] [--threads THREADS]

optional arguments:
  -h, --help         show this help message and exit
  --config CONFIG    input JSON config file for run, NOTE:
                     dirname(config.json) specifies root output directory
  --check_prereqs    test if external deps visible in environment
  --test             run tiny assembly test to check setup and prereqs
  --force_reads      proceed with subassembly even if input *bam and *fastq do
                     not pass QC
  --threads THREADS  number of multiprocessing threads
```


## Metadata
- **Skill**: generated
