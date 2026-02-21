---
name: impute2
description: This skill provides a workflow for imputing whole-genome SNPs from 23andMe raw data files.
homepage: https://github.com/johnlees/23andme-impute
---

# impute2

## Overview
This skill provides a workflow for imputing whole-genome SNPs from 23andMe raw data files. It leverages a specialized Perl wrapper to automate the conversion of raw data into the `.gen` format, phase typed sites, and execute IMPUTE2 commands. This process is computationally intensive and typically requires parallel execution to be efficient.

## CLI Usage Patterns

### Basic Imputation
To run the full imputation pipeline on a 23andMe raw data file:
```bash
./impute_genome.pl -i 23andme_rawdata.txt -o output_prefix -s m -r 4
```

### Command Options
- `-i, --input`: Path to the 23andMe raw data file (tab-separated: rsid, chromosome, position, genotype).
- `-o, --output`: Prefix for the resulting `.gen` files.
- `-s, --sex`: Specify `m` (male) or `f` (female). If omitted, the tool guesses based on Y chromosome presence.
- `-r, --run [threads]`: Directly executes the imputation using the specified number of simultaneous jobs.
- `-p, --print`: (Default) Prints the generated IMPUTE2 commands to STDOUT without executing them.
- `-w, --write`: Writes the commands to shell scripts, ideal for submission to job scheduling systems (e.g., SLURM, SGE).

## Best Practices and Expert Tips

### Resource Management
Imputation is a high-memory and high-CPU task. 
- When using the `-r` flag, ensure the number of threads is less than or equal to the available physical CPU cores.
- For large-scale processing, use the `-w` flag to generate scripts and submit them to a high-performance computing (HPC) cluster rather than running them locally.

### Data Preparation
- Ensure the input file follows the standard 23andMe format. The tool expects exactly four tab-separated columns.
- If the subject's sex is known, always provide the `-s` flag to ensure correct handling of the X chromosome and avoid errors in the guessing logic.

### Troubleshooting
- **Abnormal Termination**: If the process terminates without combining results per chromosome, check the intermediate `.gen` files for naming inconsistencies or memory exhaustion.
- **Dry Runs**: Always run with `-p` first to verify that the generated IMPUTE2 commands are correctly formatted for your environment before committing significant CPU time.

## Reference documentation
- [23andme-impute README](./references/github_com_johnlees_23andme-impute.md)