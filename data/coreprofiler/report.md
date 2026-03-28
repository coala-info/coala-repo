# coreprofiler CWL Generation Report

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


## coreprofiler_db

### Tool Description
Database handling specific arguments.

### Metadata
- **Docker Image**: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/coreprofiler/overview
- **Validation**: PASS

### Original Help Text
```text
usage: coreprofiler db [-h] [-av]
                       {get_request_tokens,download,update,makeblastdb,get_num_alleles} ...

Database handling specific arguments.

positional arguments:
  {get_request_tokens,download,update,makeblastdb,get_num_alleles}
                        Functions of database mode.
    get_request_tokens  Get request tokens from pubMLST/BigsDB.
    download            Database download function.
    update              Locally update a scheme.
    makeblastdb         Run BLAST makeblasdtdb function.
    get_num_alleles     Get number of alleles per locus.

options:
  -h, --help            show this help message and exit
  -av, --available_schemes
                        List available schemes.
```


## Metadata
- **Skill**: not generated
