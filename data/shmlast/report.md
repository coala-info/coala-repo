# shmlast CWL Generation Report

## shmlast_rbl

### Tool Description
Run Reciprocal Best Hits between the query and database.

### Metadata
- **Docker Image**: quay.io/biocontainers/shmlast:1.6--py_0
- **Homepage**: https://github.com/camillescott/shmlast
- **Package**: https://anaconda.org/channels/bioconda/packages/shmlast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shmlast/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/camillescott/shmlast
- **Stars**: N/A
### Original Help Text
```text
usage: shmlast rbl [-h] -q QUERY -d DATABASE [-o OUTPUT]
                   [--n_threads N_THREADS] [-e EVALUE_CUTOFF]
                   [--action ACTION] [--profile]
                   [--profile-output PROFILE_OUTPUT]

Run Reciprocal Best Hits between the query and database.

optional arguments:
  -h, --help            show this help message and exit
  -q QUERY, --query QUERY
                        FASTA file with query transcriptome.
  -d DATABASE, --database DATABASE
                        FASTA file with database proteins.
  -o OUTPUT, --output OUTPUT
                        File to place the CSV format CRBL hits. By default,
                        QUERY.x.DATABASE.{c}rbl.csv.
  --n_threads N_THREADS
                        Number of threads to use.
  -e EVALUE_CUTOFF, --evalue-cutoff EVALUE_CUTOFF
                        Maximum evalue to accept.
  --action ACTION       pydoit action. A common alternative is "clean."
  --profile             If True, record CPU time.
  --profile-output PROFILE_OUTPUT
                        Filename for profile results.
```


## shmlast_crbl

### Tool Description
Run Conditional Reciprocal Best Hits between the query and database.

### Metadata
- **Docker Image**: quay.io/biocontainers/shmlast:1.6--py_0
- **Homepage**: https://github.com/camillescott/shmlast
- **Package**: https://anaconda.org/channels/bioconda/packages/shmlast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: shmlast crbl [-h] -q QUERY -d DATABASE [-o OUTPUT]
                    [--n_threads N_THREADS] [-e EVALUE_CUTOFF]
                    [--action ACTION] [--profile]
                    [--profile-output PROFILE_OUTPUT]

Run Conditional Reciprocal Best Hits between the query and database.

optional arguments:
  -h, --help            show this help message and exit
  -q QUERY, --query QUERY
                        FASTA file with query transcriptome.
  -d DATABASE, --database DATABASE
                        FASTA file with database proteins.
  -o OUTPUT, --output OUTPUT
                        File to place the CSV format CRBL hits. By default,
                        QUERY.x.DATABASE.{c}rbl.csv.
  --n_threads N_THREADS
                        Number of threads to use.
  -e EVALUE_CUTOFF, --evalue-cutoff EVALUE_CUTOFF
                        Maximum evalue to accept.
  --action ACTION       pydoit action. A common alternative is "clean."
  --profile             If True, record CPU time.
  --profile-output PROFILE_OUTPUT
                        Filename for profile results.
```

