# spestimator CWL Generation Report

## spestimator

### Tool Description
Predict bacterial TaxIDs from 16S and download genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/spestimator:0.3.0.233--pyhdfd78af_0
- **Homepage**: https://github.com/erinyoung/Spestimator
- **Package**: https://anaconda.org/channels/bioconda/packages/spestimator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/spestimator/overview
- **Total Downloads**: 59
- **Last updated**: 2026-02-04
- **GitHub**: https://github.com/erinyoung/Spestimator
- **Stars**: N/A
### Original Help Text
```text
usage: spestimator [-h] [-v] [-i INPUT [INPUT ...]] [-o OUTPUT] [-t THREADS]
                   [-d [DIR]] [--db-dir DB_DIR] [--db-name DB_NAME] [-u]
                   [--api-key API_KEY] [--max-target-seqs MAX_TARGET_SEQS]
                   [--min-identity MIN_IDENTITY] [--min-coverage MIN_COVERAGE]
                   [--min-hits MIN_HITS]
                   [--min-alignment-len MIN_ALIGNMENT_LEN]
                   [--top-k-taxa TOP_K_TAXA]

Spestimator: Predict bacterial TaxIDs from 16S and download genomes.

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -i, --input INPUT [INPUT ...]
                        Input FASTA files
  -o, --output OUTPUT   Output CSV file
  -t, --threads THREADS
                        BLAST threads
  -d, --download-genomes [DIR]
                        Download found genomes. Defaults to 'genomes/' if flag
                        is used without a path.
  --db-dir DB_DIR       Override path to BLAST database directory
  --db-name DB_NAME     Custom name for the database to appear in results
                        (Default: DB filename)
  -u, --update-db       Download database and generate metadata
  --api-key API_KEY     NCBI API Key (Speeds up metadata generation)

Filtering Options:
  --max-target-seqs MAX_TARGET_SEQS
                        BLAST: Hits to keep per read (Default: 10)
  --min-identity MIN_IDENTITY
                        Filter: Minimum Percent Identity (0-100). Default:
                        90.0
  --min-coverage MIN_COVERAGE
                        Filter: Minimum Query Coverage (0-100). Default: 0.0
  --min-hits MIN_HITS   Filter: Minimum reads required to report an organism.
                        Default: 1/No Filter
  --min-alignment-len MIN_ALIGNMENT_LEN
                        Filter: Minimum Alignment Length in bp (Default: 0/No
                        Filter)
  --top-k-taxa TOP_K_TAXA
                        Report: Only keep the top K unique organisms per file
                        (Default: 10)
```

