# phizz CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phizz_build-genes | Failed | tool bug: Python 3 crash comparing gzip bytes with a str (startswith), so no gene database is written |
| phizz_delete | PASS |  |
| phizz_init | Failed | image problem: the tool writes its config file into the read-only package folder inside the image |
| phizz_query | PASS |  |

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
Delete the database.

### Metadata
- **Docker Image**: quay.io/biocontainers/phizz:0.2.3--py_0
- **Homepage**: https://github.com/moonso/phizz
- **Package**: https://anaconda.org/channels/bioconda/packages/phizz/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phizz delete [OPTIONS]

  Delete the database.

Options:
  --db_name PATH
  --path TEXT
  --help          Show this message and exit.
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

## phizz_init

### Tool Description
Create a config file for phizz.

### Metadata
- **Docker Image**: quay.io/biocontainers/phizz:0.2.3--py_0
- **Homepage**: https://github.com/moonso/phizz
- **Package**: https://anaconda.org/channels/bioconda/packages/phizz/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phizz init [OPTIONS]

  Create a config file for phizz.

Options:
  --db_name TEXT
  --path TEXT
  --help          Show this message and exit.
```

## Metadata
- **Skill**: generated
