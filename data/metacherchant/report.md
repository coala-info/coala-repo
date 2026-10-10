# metacherchant CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metacherchant_environment-finder-multi | PASS | difference of the environments built from the two read files of the nf-core sarscov2 test set |
| metacherchant_metacherchant.sh | PASS | nf-core sarscov2 reads and an 80 bp genome region as the seed; the graph contains the seed node and its neighbours |

## metacherchant_metacherchant.sh

### Tool Description
genomic environment analysis tool

#

## metacherchant_environment-finder-multi

### Tool Description
Displays the difference between multiple genomic environments.

### Metadata
- **Docker Image**: quay.io/biocontainers/metacherchant:0.1.0--1
- **Homepage**: https://github.com/ctlab/metacherchant
- **Package**: https://anaconda.org/channels/bioconda/packages/metacherchant/overview
- **Validation**: PASS

### Original Help Text
```text
Tool:           environment-finder-multi
Description:    Displays difference between multiple genomic environments
Input parameters (all):
	-e, --env <args>                        environment files to build difference for (MANDATORY)
	--seq <arg>                             .fasta file with nucleotide sequence[s] (MANDATORY)
	-o, --output <arg>                      output directory to write results to (MANDATORY)
	-g, --geneid <arg>                      gene id from .fasta file (optional, default: 1)

Launch options (all):
	-ts, --tools                            print available tools (optional)
	-t, --tool <arg>                        set certain tool to run (optional, default: environment-finder)
	-m, --memory <arg>                      memory to use (for example: 1500M, 4G, etc.) (optional, default: 2 Gb)
	-p, --available-processors <arg>        available processors (optional, default: all (20))
	-w, --work-dir <arg>                    working directory (optional, default: workDir)
	-c, --continue                          continue the previous run from last succeed stage, saved in working directory (optional)
	--force                                 force run with rewriting old results (optional)
	-s, --start <arg>                       first force run stage (with rewriting old results) (optional)
	-f, --finish <arg>                      stop after running this stage (optional)
	-ea, --enable-assertions                enable assertions (optional, default: assertions disabled)
	-v, --verbose                           enable debug output (optional)
	-h, --help                              print short help message (optional)
	-ha, --help-all                         print full help message (optional)
```

## Metadata
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

