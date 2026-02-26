# metacherchant CWL Generation Report

## metacherchant_metacherchant.sh

### Tool Description
genomic environment analysis tool

### Metadata
- **Docker Image**: quay.io/biocontainers/metacherchant:0.1.0--1
- **Homepage**: https://github.com/ctlab/metacherchant
- **Package**: https://anaconda.org/channels/bioconda/packages/metacherchant/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metacherchant/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ctlab/metacherchant
- **Stars**: N/A
### Original Help Text
```text
MetaCherchant: genomic environment analysis tool, version 0.1.0 (revision 329e235)

Usage:     metacherchant [<Launch options>] [<Input parameters>]
Tool:           environment-finder
Description:    Finds graphic environment for many genomic sequences in given metagenomic reads
Input parameters (only important):
	-k, --k <arg>                           k-mer size (MANDATORY)
	--seq <arg>                             FASTA file with sequences (MANDATORY)
	-o, --output <arg>                      output directory (MANDATORY)

Launch options (only important):
	-m, --memory <arg>                      memory to use (for example: 1500M, 4G, etc.) (optional, default: 2 Gb)
	-w, --work-dir <arg>                    working directory (optional, default: workDir)
	-c, --continue                          continue the previous run from last succeed stage, saved in working directory (optional)
	--force                                 force run with rewriting old results (optional)
	-h, --help                              print short help message (optional)

To see all parameters and options add --help-all.
```

