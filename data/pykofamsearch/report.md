# pykofamsearch CWL Generation Report

## pykofamsearch

### Tool Description
PyKOfamSearch

### Metadata
- **Docker Image**: quay.io/biocontainers/pykofamsearch:2025.9.5--pyhdfd78af_1
- **Homepage**: https://github.com/jolespin/pykofamsearch
- **Package**: https://anaconda.org/channels/bioconda/packages/pykofamsearch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pykofamsearch/overview
- **Total Downloads**: 852
- **Last updated**: 2025-09-08
- **GitHub**: https://github.com/jolespin/pykofamsearch
- **Stars**: N/A
### Original Help Text
```text
usage: pykofamsearch -i <proteins.fasta> -o <output.tsv> -d 

    Running: pykofamsearch v2025.9.5 via Python v3.12.11 | /usr/local/bin/python3.12

options:
  -h, --help            show this help message and exit
  --verbosity VERBOSITY
                        Verbosity of missing KOfams [Default: 1]
  -v, --version         show program's version number and exit

I/O arguments:
  -i PROTEINS, --proteins PROTEINS
                        path/to/proteins.fasta. stdin does not stream and loads everything into memory. [Default: stdin]
  -o OUTPUT, --output OUTPUT
                        path/to/output.tsv [Default: stdout]
  -s SUBSET, --subset SUBSET
                        path/to/identifiers.list where HMM identifiers are on a separate line used to subset the database. Only HMMs in the subset will be used.
  --no_header           No header

Utility arguments:
  -p N_JOBS, --n_jobs N_JOBS
                        Number of threads to use [Default: 1]

HMMSearch arguments:
  -e EVALUE, --evalue EVALUE
                        E-value threshold [Default: 0.1]
  -a, --all_hits        Return all hits and do not use curated threshold. Not recommended for large queries.
  -t THRESHOLD_SCALE, --threshold_scale THRESHOLD_SCALE
                        Multiplier for the curated thresholds. Higher values will make the annotation more strict [Default: 1.0]

Database arguments:
  -d DATABASE_DIRECTORY, --database_directory DATABASE_DIRECTORY
                        path/to/kofam_database_directory/ cannot be used with -b/-serialized_database
  -b SERIALIZED_DATABASE, --serialized_database SERIALIZED_DATABASE
                        path/to/database.pkl cannot be used with -d/--database_directory

PyKOfamSearch
```

