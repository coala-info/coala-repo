# pyhmmsearch CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pyhmmsearch | PASS | matches HMMER 3.4 hmmsearch on 124 BUSCO bacteria models and 4977 proteins (115 hits) |
| pyhmmsearch_reformat_pyhmmsearch | PASS |  |
| pyhmmsearch_serialize_hmm_models | PASS | --hmm_list mode tested; --hmm_database stops with an assertion unless stdin is a terminal (tool bug) |

## pyhmmsearch

### Tool Description
Running: pyhmmsearch v2025.10.23.post1 via Python v3.12.12 | /usr/local/bin/python3.12

### Metadata
- **Docker Image**: quay.io/biocontainers/pyhmmsearch:2025.10.23.post1--pyh7e72e81_0
- **Homepage**: https://github.com/new-atlantis-labs/pyhmmsearch-stable
- **Package**: https://anaconda.org/channels/bioconda/packages/pyhmmsearch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyhmmsearch/overview
- **Total Downloads**: 1.0K
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/new-atlantis-labs/pyhmmsearch-stable
- **Stars**: N/A
### Original Help Text
```text
usage: pyhmmsearch -i <proteins.fasta> -o <output.tsv> -d 

    Running: pyhmmsearch v2025.10.23.post1 via Python v3.12.12 | /usr/local/bin/python3.12

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

I/O arguments:
  -i PROTEINS, --proteins PROTEINS
                        path/to/proteins.fasta. stdin does not stream and loads everything into memory. [Default: stdin]
  -o OUTPUT, --output OUTPUT
                        path/to/output.tsv [Default: stdout]
  --no_header           No header
  --tblout TBLOUT       path/to/output.tblout
  --domtblout DOMTBLOUT
                        path/to/output.domtblout

Utility arguments:
  -p N_JOBS, --n_jobs N_JOBS
                        Number of threads to use [Default: 1]

HMMSearch arguments:
  -s SCORES_CUTOFF, --scores_cutoff SCORES_CUTOFF
                        path/to/scores_cutoff.tsv[.gz] [id_hmm]<tab>[score_threshold], No header.
  -f {accession,name}, --hmm_marker_field {accession,name}
                        HMM reference type (accession, name) [Default: accession]
  -t {full,domain}, --score_type {full,domain}
                        {full, domain} [Default: full]
  -m {e,noise,gathering,trusted}, --threshold_method {e,noise,gathering,trusted}
                        Cutoff threshold method [Default:  e]
  -e EVALUE, --evalue EVALUE
                        E-value threshold [Default: 10.0]

Database arguments:
  -d HMM_DATABASE, --hmm_database HMM_DATABASE
                        path/to/database.hmm cannot be used with -b/-serialized_database.  Expects a (concatenated) HMM file and not a directory. You can build a database from a directory using `serialize_hmm_models.py`
  -b SERIALIZED_DATABASE, --serialized_database SERIALIZED_DATABASE
                        path/to/database.pkl cannot be used with -d/--database_directory.  Database should be pickled dictionary {name:hmm}

https://github.com/jolespin/pyhmmsearch
```

## pyhmmsearch_reformat_pyhmmsearch

### Tool Description
Reformat the hit table written by pyhmmsearch into one row per protein (table) or a pickled dictionary (pickle).

### Metadata
- **Docker Image**: quay.io/biocontainers/pyhmmsearch:2025.10.23.post1--pyh7e72e81_0
- **Homepage**: https://github.com/jolespin/pyhmmsearch
- **Package**: https://anaconda.org/channels/bioconda/packages/pyhmmsearch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reformat_pyhmmsearch -i <input.tsv> -o <output.tsv> -f <format> 

    Running: reformat_pyhmmsearch v2025.10.23.post1 via Python v3.12.12 | /usr/local/bin/python3.12

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -i INPUT, --input INPUT
                        path/to/input.tsv. The results of `pyhmmsearch.py` [Default: stdin]
  -o OUTPUT, --output OUTPUT
                        path/to/output.tsv [Default: stdout]
  -f {pickle,table}, --format {pickle,table}
                        Output format
  --no_header           Input does not have header
  -b, --best_hits_only  Best hits only

PyHMMSearch
```

## pyhmmsearch_serialize_hmm_models

### Tool Description
Serialize HMM models into a pickled dictionary that pyhmmsearch can load with --serialized_database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyhmmsearch:2025.10.23.post1--pyh7e72e81_0
- **Homepage**: https://github.com/jolespin/pyhmmsearch
- **Package**: https://anaconda.org/channels/bioconda/packages/pyhmmsearch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: serialize_hmm_models -d <path/to/hmm_database> -b <hmm_database.pkl.gz> -f name 

    Running: serialize_hmm_models v2025.10.23.post1 via Python v3.12.12 | /usr/local/bin/python3.12

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

Database arguments:
  -l HMM_LIST, --hmm_list HMM_LIST
                        List of filepaths to HMM files. Cannot be used with --hmm_database. [Default: stdin]
  -d HMM_DATABASE, --hmm_database HMM_DATABASE
                        path/to/hmm_database.  If it is a single file then it is interpreted as a multi-HMM database. If it's a directory, then it will be scanned for .hmm[.gz] files (Not case sensitive). Cannot be used with --hmm_list.
  -b SERIALIZED_DATABASE, --serialized_database SERIALIZED_DATABASE
                        path/to/database.pkl[.gz] is dictionary of HMM models
  -f HMM_MARKER_FIELD, --hmm_marker_field HMM_MARKER_FIELD
                        HMM reference type (accession, name) [Default: accession]

PyHMMSearch
```
