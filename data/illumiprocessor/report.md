# illumiprocessor CWL Generation Report

## illumiprocessor

### Tool Description
Batch trim Illumina reads for adapter contamination and low quality bases using Trimmomatic

### Metadata
- **Docker Image**: quay.io/biocontainers/illumiprocessor:2.10--py_0
- **Homepage**: https://github.com/faircloth-lab/illumiprocessor
- **Package**: https://anaconda.org/channels/bioconda/packages/illumiprocessor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/illumiprocessor/overview
- **Total Downloads**: 10.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/faircloth-lab/illumiprocessor
- **Stars**: N/A
### Original Help Text
```text
usage: illumiprocessor [-h] --input INPUT --output OUTPUT --config CONFIG
                       [--trimmomatic TRIMMOMATIC] [--min-len MIN_LEN]
                       [--no-merge] [--cores CORES] [--r1-pattern R1_PATTERN]
                       [--r2-pattern R2_PATTERN] [--se]
                       [--phred {phred33,phred64}] [--log-path LOG_PATH]
                       [--verbosity {INFO,WARN,CRITICAL}]

Batch trim Illumina reads for adapter contamination and low quality bases
using Trimmomatic

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The input directory of raw reads to trim. (default:
                        None)
  --output OUTPUT       The output directory of clean reads to create.
                        (default: None)
  --config CONFIG       A configuration file containing the tag:sample mapping
                        and renaming options. (default: None)
  --trimmomatic TRIMMOMATIC
                        The path to the trimmomatic-0.XX.jar file. (default:
                        /usr/local/bin/trimmomatic)
  --min-len MIN_LEN     The minimum length of reads to keep. (default: 40)
  --no-merge            When trimming PE reads, do not merge singleton files.
                        (default: False)
  --cores CORES         Number of compute cores to use. (default: 1)
  --r1-pattern R1_PATTERN
                        An optional regex pattern to find R1 reads. (default:
                        None)
  --r2-pattern R2_PATTERN
                        An optional regex pattern to find R2 reads. (default:
                        None)
  --se                  Single-end reads. (default: False)
  --phred {phred33,phred64}
                        The type of fastq encoding used. (default: phred33)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
```

