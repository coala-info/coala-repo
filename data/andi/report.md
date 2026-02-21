# andi CWL Generation Report

## andi

### Tool Description
Estimate evolutionary distances between closely related genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/andi:0.14--hfc2f157_2
- **Homepage**: https://github.com/evolbioinf/andi/
- **Package**: https://anaconda.org/channels/bioconda/packages/andi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/andi/overview
- **Total Downloads**: 22.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/evolbioinf/andi
- **Stars**: N/A
### Original Help Text
```text
Usage: andi [OPTIONS...] FILES...
	FILES... can be any sequence of FASTA files.
	Use '-' as file name to read from stdin.
Options:
  -b, --bootstrap=INT  Print additional bootstrap matrices
      --file-of-filenames=FILE  Read additional filenames from FILE; one per line
  -j, --join           Treat all sequences from one file as a single genome
  -l, --low-memory     Use less memory at the cost of speed
  -m, --model=MODEL    Pick an evolutionary model of 'Raw', 'JC', 'Kimura', 'LogDet'; default: JC
  -p FLOAT             Significance of an anchor; default: 0.025
      --progress=WHEN  Print a progress bar 'always', 'never', or 'auto'; default: auto
  -t, --threads=INT    Set the number of threads; by default, all processors are used
      --truncate-names Truncate names to ten characters
  -v, --verbose        Prints additional information
  -h, --help           Display this help and exit
      --version        Output version information and acknowledgments
```


## Metadata
- **Skill**: generated
