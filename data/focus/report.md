# focus CWL Generation Report

## focus

### Tool Description
An Agile Profiler for Metagenomic Data

### Metadata
- **Docker Image**: quay.io/biocontainers/focus:1.8--pyhdfd78af_0
- **Homepage**: https://edwards.sdsu.edu/FOCUS
- **Package**: https://anaconda.org/channels/bioconda/packages/focus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/focus/overview
- **Total Downloads**: 15.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/metageni/FOCUS
- **Stars**: N/A
### Original Help Text
```text
usage: focus [-h] [-v] -q QUERY -o OUTPUT_DIRECTORY [-k KMER_SIZE]
             [-b ALTERNATE_DIRECTORY] [-p OUTPUT_PREFIX] [-t THREADS]
             [--list_output] [-l LOG]

FOCUS: An Agile Profiler for Metagenomic Data

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -q QUERY, --query QUERY
                        Path to FAST(A/Q) file or directory with these files.
  -o OUTPUT_DIRECTORY, --output_directory OUTPUT_DIRECTORY
                        Path to output files
  -k KMER_SIZE, --kmer_size KMER_SIZE
                        K-mer size (6 or 7) (Default: 6)
  -b ALTERNATE_DIRECTORY, --alternate_directory ALTERNATE_DIRECTORY
                        Alternate directory for your databases
  -p OUTPUT_PREFIX, --output_prefix OUTPUT_PREFIX
                        Output prefix (Default: output)
  -t THREADS, --threads THREADS
                        Number Threads used in the k-mer counting (Default: 4)
  --list_output         Output results as a list
  -l LOG, --log LOG     Path to log file (Default: STDOUT).

example > focus -q samples_directory
```

