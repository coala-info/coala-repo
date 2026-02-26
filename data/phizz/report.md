# phizz CWL Generation Report

## phizz_build-genes

### Tool Description
Create a gene database.

### Metadata
- **Docker Image**: quay.io/biocontainers/phizz:0.2.3--py_0
- **Homepage**: https://github.com/moonso/phizz
- **Package**: https://anaconda.org/channels/bioconda/packages/phizz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phizz/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/moonso/phizz
- **Stars**: N/A
### Original Help Text
```text
Usage: phizz build-genes [OPTIONS] GENE_FILE

  Create a gene database.

Options:
  --db_name TEXT
  --path TEXT
  --help          Show this message and exit.
```


## phizz_delete

### Tool Description
Deletes the phizz database.

### Metadata
- **Docker Image**: quay.io/biocontainers/phizz:0.2.3--py_0
- **Homepage**: https://github.com/moonso/phizz
- **Package**: https://anaconda.org/channels/bioconda/packages/phizz/overview
- **Validation**: PASS

### Original Help Text
```text
[2026-02-25 01:48:25,249] phizz.cli                 INFO     Deleting database /usr/local/lib/python3.7/site-packages/phizz/resources/phizz.db
[2026-02-25 01:48:25,568] phizz.cli                 INFO     Database /usr/local/lib/python3.7/site-packages/phizz/resources/phizz.db deleted
```


## phizz_init

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/phizz:0.2.3--py_0
- **Homepage**: https://github.com/moonso/phizz
- **Package**: https://anaconda.org/channels/bioconda/packages/phizz/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[2026-02-25 01:48:51,070] phizz.cli                 ERROR    Databse already exists in /usr/local/lib/python3.7/site-packages/phizz/resources/phizz.db
```


## phizz_query

### Tool Description
Query the hpo database.
  Print the result in csv format as default.

### Metadata
- **Docker Image**: quay.io/biocontainers/phizz:0.2.3--py_0
- **Homepage**: https://github.com/moonso/phizz
- **Package**: https://anaconda.org/channels/bioconda/packages/phizz/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phizz query [OPTIONS]

  Query the hpo database.

  Print the result in csv format as default.

Options:
  -c, --config PATH
  -h, --hpo_term TEXT     Specify a hpo term
  -m, --mim_term TEXT     Specify a omim id
  -o, --outfile FILENAME  Specify path to outfile
  -j, --to_json           If output should be in json format
  --chrom TEXT            The chromosome
  --start INTEGER
  --stop INTEGER
  --help                  Show this message and exit.
```

