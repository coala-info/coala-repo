# platon CWL Generation Report

## platon

### Tool Description
Identification and characterization of bacterial plasmid contigs from short-read draft assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/platon:1.7--pyhdfd78af_0
- **Homepage**: https://github.com/oschwengers/platon
- **Package**: https://anaconda.org/channels/bioconda/packages/platon/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/platon/overview
- **Total Downloads**: 30.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/oschwengers/platon
- **Stars**: N/A
### Original Help Text
```text
usage: platon [--db DB] [--prefix PREFIX] [--output OUTPUT]
              [--mode {sensitivity,accuracy,specificity}] [--characterize]
              [--meta] [--help] [--verbose] [--threads THREADS] [--version]
              <genome>

Identification and characterization of bacterial plasmid contigs from short-read draft assemblies.

Input / Output:
  <genome>              draft genome in fasta format
  --db DB, -d DB        database path (default = <platon_path>/db)
  --prefix PREFIX, -p PREFIX
                        Prefix for output files
  --output OUTPUT, -o OUTPUT
                        Output directory (default = current working directory)

Workflow:
  --mode {sensitivity,accuracy,specificity}, -m {sensitivity,accuracy,specificity}
                        applied filter mode: sensitivity: RDS only (>= 95%
                        sensitivity); specificity: RDS only (>=99.9%
                        specificity); accuracy: RDS & characterization
                        heuristics (highest accuracy) (default = accuracy)
  --characterize, -c    deactivate filters; characterize all contigs
  --meta                use metagenome gene prediction mode

General:
  --help, -h            Show this help message and exit
  --verbose, -v         Print verbose information
  --threads THREADS, -t THREADS
                        Number of threads to use (default = number of
                        available CPUs)
  --version             show program's version number and exit

Citation:
Schwengers O., Barth P., Falgenhauer L., Hain T., Chakraborty T., & Goesmann A. (2020).
Platon: identification and characterization of bacterial plasmid contigs in short-read draft assemblies exploiting protein sequence-based replicon distribution scores.
Microbial Genomics, 95, 295. https://doi.org/10.1099/mgen.0.000398

GitHub:
https://github.com/oschwengers/platon
```

