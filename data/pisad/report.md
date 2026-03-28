# pisad CWL Generation Report

## pisad_run.sh

### Tool Description
Runs the PISAD pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/pisad:1.2.0--pl5321h6f0a7f7_0
- **Homepage**: https://github.com/ZhantianXu/PISAD
- **Package**: https://anaconda.org/channels/bioconda/packages/pisad/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pisad/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-05-22
- **GitHub**: https://github.com/ZhantianXu/PISAD
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/run.sh -i <input_files> -m <heterozygosity> [options...]
Required parameters:
  -i: Input files (space-separated *.fastq or *.fastq.gz files, no quotes needed)
  -m: Heterozygosity parameter (0 for <1.2%, 1 otherwise)
Optional parameters:
  -k: kmer-size (default: 21)
  -t: thread (default: 8)
  -o: Output prefix (defaults: first input file's prefix)
  -d1: Directory for dsk files (default: current directory)
  -d2: Directory for output plot (default: current directory)
  -d3: Directory for SNP output (default: current directory)
  -h: Show this help message
Advanced optional parameters:
  -est: est_kmercov (default: Estimated by algorithm)
  -cutoff: cutoff threshold (defaults: 0.95)
  -het: Initial heterozygosity (defaults: 0/0.12)
  -rho: Initial rho value (defaults: 0.2)
  -setleft: Left boundary of the heterozygous region (defaults: Estimated by algorithm)
  -setright: Right boundary of the heterozygous region (defaults: Estimated by algorithm)
```


## pisad_create

### Tool Description
Create a new data structure from an input file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pisad:1.2.0--pl5321h6f0a7f7_0
- **Homepage**: https://github.com/ZhantianXu/PISAD
- **Package**: https://anaconda.org/channels/bioconda/packages/pisad/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Input file (-i) is required
Usage: create -i <inputFile> [-o <outputFile>] [-k <k>] [-l <limit>]
```


## pisad_pisadCount

### Tool Description
Calculate variant sketch statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/pisad:1.2.0--pl5321h6f0a7f7_0
- **Homepage**: https://github.com/ZhantianXu/PISAD
- **Package**: https://anaconda.org/channels/bioconda/packages/pisad/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pisadCount -s [FASTA] [OPTION]... [FILES...]
Required options:
  -s, --snp = STR        variant sketch (one or more) [required]
Optional options:
  -t, --threads = INT    Number of threads to run.[1]
  -m, --maxCov = INT     k-mer coverage threshold for early termination. [inf]
  -i, --information      extra debug information.
  -k, --kmer = INT       k-mer size used. [21]
  -h, --help             Display this dialog.
  -o, --output           Evaluation file path
```


## pisad_pisadEval

### Tool Description
Optional options:

### Metadata
- **Docker Image**: quay.io/biocontainers/pisad:1.2.0--pl5321h6f0a7f7_0
- **Homepage**: https://github.com/ZhantianXu/PISAD
- **Package**: https://anaconda.org/channels/bioconda/packages/pisad/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pisadEval[OPTION]... [FILES...]
Optional options:
  -t, --threads = INT    Number of threads to run.[1]
  -h, --help             Display this dialog.
```


## Metadata
- **Skill**: generated
