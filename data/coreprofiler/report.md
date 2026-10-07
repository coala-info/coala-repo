# coreprofiler CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| coreprofiler_allele_calling | PASS |  |
| coreprofiler_db_download | PASS |  |
| coreprofiler_db_get_num_alleles | PASS |  |
| coreprofiler_db_get_request_tokens | Not completed | Needs a pubMLST/BIGSdb consumer key and secret (account credentials), which are not available. |
| coreprofiler_db_makeblastdb | PASS |  |
| coreprofiler_db_update | PASS |  |

## coreprofiler_allele_calling

### Tool Description
Allele calling specific arguments.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/coreprofiler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coreprofiler/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-12-12
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: coreprofiler allele_calling [-h] -q QUERY [QUERY ...] -sf SCHEME_DIR
                                   -out OUT [--outfa OUTFA]
                                   [-db BLAST_DB_PATH] [-v] [-n NUM_THREADS]
                                   [--autotag_word_size AUTOTAG_WORD_SIZE]
                                   [-cds] [-d]
                                   [--min_id_new_allele MIN_ID_NEW_ALLELE]
                                   [--min_cov_new_allele MIN_COV_NEW_ALLELE]
                                   [--min_cov_incomplete MIN_COV_INCOMPLETE]
                                   [--profiles_w_tmp_alleles PROFILES_W_TMP_ALLELES]
                                   [--num_alleles_per_locus NUM_ALLELES_PER_LOCUS]

Allele calling specific arguments.

options:
  -h, --help            show this help message and exit
  -q, --query QUERY [QUERY ...]
                        Path(s) to query fasta file(s)
  -sf, --scheme_dir SCHEME_DIR
                        Path to scheme files.
  -out OUT              Path to output file.
  --outfa OUTFA         Path to output fasta file with new alleles sequences
                        if detected.
  -db, --blast_db_path BLAST_DB_PATH
                        Path to the BLAST database.
  -v, --verbose         Verbose mode.
  -n, --num_threads NUM_THREADS
                        Number of threads. Default 4.
  --autotag_word_size AUTOTAG_WORD_SIZE
                        Word size for Autotag BLASTn. Default 31.
  -cds                  Extract new alleles within CDS.
  -d, --detailed        Return further information on incomplete alleles.
  --min_id_new_allele MIN_ID_NEW_ALLELE
                        Minimum identity perc to consider new alleles. Default
                        90.
  --min_cov_new_allele MIN_COV_NEW_ALLELE
                        Minimum coverage perc to consider new alleles. Default
                        90.
  --min_cov_incomplete MIN_COV_INCOMPLETE
                        Minimum coverage perc to consider an allele incomplete
                        (if --detailed option). Default 70.
  --profiles_w_tmp_alleles PROFILES_W_TMP_ALLELES
                        A JSON file containing info about files with temporary
                        alleles.
  --num_alleles_per_locus NUM_ALLELES_PER_LOCUS
                        Tsv file containing the number of alleles per locus of
                        a given scheme.
```


## coreprofiler_db_get_request_tokens

### Tool Description
Get request tokens from pubMLST/BigsDB.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/coreprofiler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coreprofiler/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-12-12
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: coreprofiler db get_request_tokens [-h] [-k CONSUMER_KEY]
                                          [-ks CONSUMER_SECRET] -s SCHEME

options:
  -h, --help            show this help message and exit
  -k, --consumer_key CONSUMER_KEY
                        Consumer key for PUBmlst/BIGSdb API.
  -ks, --consumer_secret CONSUMER_SECRET
                        Consumer secret for PUBmlst/BIGSdb API.
  -s, --scheme SCHEME   Scheme name to consider.
```


## coreprofiler_db_download

### Tool Description
Database download function.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/coreprofiler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coreprofiler/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-12-12
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: coreprofiler db download [-h] -s SCHEME -o OUTPUT_DIR [-k CONSUMER_KEY]
                                [-ks CONSUMER_SECRET] [-a ACCESS_TOKEN]
                                [-as ACCESS_SECRET] [-t]

options:
  -h, --help            show this help message and exit
  -s, --scheme SCHEME   Scheme name.
  -o, --output_dir OUTPUT_DIR
                        Path to store the database.
  -k, --consumer_key CONSUMER_KEY
                        Consumer key for PUBmlst/BIGSdb API.
  -ks, --consumer_secret CONSUMER_SECRET
                        Consumer secret for PUBmlst/BIGSdb API.
  -a, --access_token ACCESS_TOKEN
                        Access token for PUBmlst/BIGSdb API.
  -as, --access_secret ACCESS_SECRET
                        Access token secret for PUBmlst/BIGSdb API.
  -t, --test            Active test mode to limit locus download for schemes
                        to 50.
```


## coreprofiler_db_update

### Tool Description
Locally update a scheme.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/coreprofiler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coreprofiler/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-12-12
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: coreprofiler db update [-h] -s SCHEME [-k CONSUMER_KEY]
                              [-ks CONSUMER_SECRET] [-a ACCESS_TOKEN]
                              [-as ACCESS_SECRET] -d LOCAL_SCHEME_PATH
                              -o UPDATE_LOG_PATH

options:
  -h, --help            show this help message and exit
  -s, --scheme SCHEME   Scheme name to consider.
  -k, --consumer_key CONSUMER_KEY
                        Consumer key for PUBmlst/BIGSdb API.
  -ks, --consumer_secret CONSUMER_SECRET
                        Consumer secret for PUBmlst/BIGSdb API.
  -a, --access_token ACCESS_TOKEN
                        Access token for PUBmlst/BIGSdb API.
  -as, --access_secret ACCESS_SECRET
                        Access token secret for PUBmlst/BIGSdb API.
  -d, --local_scheme_path LOCAL_SCHEME_PATH
                        Local path to scheme directory.
  -o, --update_log_path UPDATE_LOG_PATH
                        Path of the directory to write output logs.
```


## coreprofiler_db_makeblastdb

### Tool Description
Run BLAST makeblasdtdb function.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/coreprofiler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coreprofiler/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-12-12
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: coreprofiler db makeblastdb [-h] -s SCHEME_PATH -n DB_NAME -p DB_PATH

options:
  -h, --help            show this help message and exit
  -s, --scheme_path SCHEME_PATH
                        Path to directory containing allele files.
  -n, --db_name DB_NAME
                        BLAST db name.
  -p, --db_path DB_PATH
                        Path to write the database.
```


## coreprofiler_db_get_num_alleles

### Tool Description
Get number of alleles per locus.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/coreprofiler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coreprofiler/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-12-12
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: coreprofiler db get_num_alleles [-h] -s SCHEME_DIR -o OUTPUT

options:
  -h, --help            show this help message and exit
  -s, --scheme_dir SCHEME_DIR
                        Path to scheme files directory.
  -o, --output OUTPUT   Output TSV file.
```


## Metadata
- **Skill**: not generated
