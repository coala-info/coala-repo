# pyhmmsearch CWL Generation Report

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

