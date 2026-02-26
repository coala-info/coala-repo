# pmga CWL Generation Report

## pmga

### Tool Description
Serotyping, serotyping and MLST of all Neisseria species and Haemophilus influenzae

### Metadata
- **Docker Image**: quay.io/biocontainers/pmga:3.0.2--hdfd78af_0
- **Homepage**: https://github.com/CDCgov/BMGAP
- **Package**: https://anaconda.org/channels/bioconda/packages/pmga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pmga/overview
- **Total Downloads**: 5.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CDCgov/BMGAP
- **Stars**: N/A
### Original Help Text
```text
usage: pmga [-h] [--prefix STR] [--blastdir STR] [--species STR] [-t INT]
            [-o STR] [--force] [--verbose] [--silent] [--version]
            FASTA

pmga (v3.0.1) - Serotyping, serotyping and MLST of all Neisseria species and Haemophilus influenzae

positional arguments:
  FASTA                 Input FASTA file to analyze

options:
  -h, --help            show this help message and exit
  --prefix STR          Prefix for outputs (Default: Use basename of input
                        FASTA file)
  --blastdir STR        Directory containing BLAST DBs built by pmga-build
                        (Default: ./pubmlst_dbs_all

Additional Options:
  --species STR         Use this as the input species (Default: use Mash
                        distance). Available Choices: neisseria, hinfluenzae
  -t INT, --threads INT
                        Number of cores to use (default=1)
  -o STR, --outdir STR  Directory to output results to (Default: ./pmga)
  --force               Force overwrite existing output file
  --verbose             Print debug related text.
  --silent              Only critical errors will be printed.
  --version             show program's version number and exit
```


## Metadata
- **Skill**: generated
