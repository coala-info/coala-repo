# pysradb CWL Generation Report

## pysradb_metadata

### Tool Description
Retrieve metadata for given SRP IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Total Downloads**: 92.6K
- **Last updated**: 2025-10-20
- **GitHub**: https://github.com/saketkc/pysradb
- **Stars**: N/A
### Original Help Text
```text
usage: pysradb metadata [-h] [--saveto SAVETO] [--assay] [--desc] [--detailed]
                        [--expand]
                        srp_id [srp_id ...]

positional arguments:
  srp_id

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save metadata dataframe to file
  --assay          Include assay type in output
  --desc           Should sample_attribute be included
  --detailed       Display detailed metadata table
  --expand         Should sample_attribute be expanded
```


## pysradb_download

### Tool Description
Download SRA data. Accepts a list of accession IDs from stdin or a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/pysradb", line 10, in <module>
    sys.exit(parse_args())
             ~~~~~~~~~~^^
  File "/usr/local/lib/python3.14/site-packages/pysradb/cli.py", line 1358, in parse_args
    download(
    ~~~~~~~~^
        args.out_dir,
        ^^^^^^^^^^^^^
    ...<6 lines>...
        args.threads,
        ^^^^^^^^^^^^^
    )
    ^
  File "/usr/local/lib/python3.14/site-packages/pysradb/cli.py", line 106, in download
    df = pd.read_csv(sys.stdin, sep="\t")
  File "/usr/local/lib/python3.14/site-packages/pandas/io/parsers/readers.py", line 1026, in read_csv
    return _read(filepath_or_buffer, kwds)
  File "/usr/local/lib/python3.14/site-packages/pandas/io/parsers/readers.py", line 620, in _read
    parser = TextFileReader(filepath_or_buffer, **kwds)
  File "/usr/local/lib/python3.14/site-packages/pandas/io/parsers/readers.py", line 1620, in __init__
    self._engine = self._make_engine(f, self.engine)
                   ~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/pandas/io/parsers/readers.py", line 1898, in _make_engine
    return mapping[engine](f, **self.options)
           ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/pandas/io/parsers/c_parser_wrapper.py", line 93, in __init__
    self._reader = parsers.TextReader(src, **kwds)
                   ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^
  File "pandas/_libs/parsers.pyx", line 581, in pandas._libs.parsers.TextReader.__cinit__
pandas.errors.EmptyDataError: No columns to parse from file
```


## pysradb_search

### Tool Description
Search for data in SRA, ENA, or GEO databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb search [-h] [-o SAVETO] [-s] [-g [GRAPHS]] [-d {ena,geo,sra}]
                      [-v {0,1,2,3}] [--run-description] [--detailed] [-m MAX]
                      [-q QUERY [QUERY ...]] [-A ACCESSION]
                      [-O ORGANISM [ORGANISM ...]] [-L {SINGLE,PAIRED}]
                      [-M MBASES] [-D PUBLICATION_DATE]
                      [-P PLATFORM [PLATFORM ...]]
                      [-E SELECTION [SELECTION ...]] [-C SOURCE [SOURCE ...]]
                      [-S STRATEGY [STRATEGY ...]] [-T TITLE [TITLE ...]] [-I]
                      [-G GEO_QUERY [GEO_QUERY ...]]
                      [-Y GEO_DATASET_TYPE [GEO_DATASET_TYPE ...]]
                      [-Z GEO_ENTRY_TYPE [GEO_ENTRY_TYPE ...]]

options:
  -h, --help            show this help message and exit
  -o, --saveto SAVETO   Save search result dataframe to file
  -s, --stats           Displays some useful statistics for the search
                        results.
  -g, --graphs [GRAPHS]
                        Generates graphs to illustrate the search result. By
                        default all graphs are generated. Alternatively,
                        select a subset from the options below in a space-
                        separated string: daterange, organism, source,
                        selection, platform, basecount
  -d, --db {ena,geo,sra}
                        Select the db API (sra, ena, or geo) to query, default
                        = sra. Note: pysradb search works slightly differently
                        when db = geo. Please refer to 'pysradb search --geo-
                        info' for more details.
  -v, --verbosity {0,1,2,3}
                        Level of search result details (0, 1, 2 or 3), default
                        = 2 0: run accession only 1: run accession and
                        experiment title 2: accession numbers, titles and
                        sequencing information 3: records in 2 and other
                        information such as download url, sample attributes,
                        etc
  --run-description     Displays run accessions and descriptions only.
                        Equivalent to --verbosity 1
  --detailed            Displays detailed search results. Equivalent to
                        --verbosity 3.
  -m, --max MAX         Maximum number of entries to return, default = 20
  -q, --query QUERY [QUERY ...]
                        Main query string. Note that if no query is supplied,
                        at least one of the following flags must be present:
  -A, --accession ACCESSION
                        Accession number
  -O, --organism ORGANISM [ORGANISM ...]
                        Scientific name of the sample organism
  -L, --layout {SINGLE,PAIRED}
                        Library layout. Accepts either SINGLE or PAIRED
  -M, --mbases MBASES   Size of the sample rounded to the nearest megabase
  -D, --publication-date PUBLICATION_DATE
                        Publication date of the run in the format dd-mm-yyyy.
                        If a date range is desired, enter the start date,
                        followed by end date, separated by a colon ':'.
                        Example: 01-01-2010:31-12-2010
  -P, --platform PLATFORM [PLATFORM ...]
                        Sequencing platform
  -E, --selection SELECTION [SELECTION ...]
                        Library selection
  -C, --source SOURCE [SOURCE ...]
                        Library source
  -S, --strategy STRATEGY [STRATEGY ...]
                        Library preparation strategy
  -T, --title TITLE [TITLE ...]
                        Experiment title
  -I, --geo-info        Displays information on how to query GEO DataSets via
                        'pysradb search --db geo ...', including accepted
                        inputs for -G/--geo-query, -Y/--geo-dataset-type and
                        -Z/--geo-entry-type.
  -G, --geo-query GEO_QUERY [GEO_QUERY ...]
                        Main query string for GEO DataSet. This flag is only
                        used when db is set to be geo.Please refer to 'pysradb
                        search --geo-info' for more details.
  -Y, --geo-dataset-type GEO_DATASET_TYPE [GEO_DATASET_TYPE ...]
                        GEO DataSet Type. This flag is only used when --db is
                        set to be geo.Please refer to 'pysradb search --geo-
                        info' for more details.
  -Z, --geo-entry-type GEO_ENTRY_TYPE [GEO_ENTRY_TYPE ...]
                        GEO Entry Type. This flag is only used when --db is
                        set to be geo.Please refer to 'pysradb search --geo-
                        info' for more details.
```


## pysradb_gse-to-gsm

### Tool Description
Convert GSE accession IDs to GSM accession IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb gse-to-gsm [-h] [--saveto SAVETO] [--detailed] [--desc]
                          [--expand]
                          gse_ids [gse_ids ...]

positional arguments:
  gse_ids

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
  --detailed       Output additional columns: [sample_accession (SRS),
                   run_accession (SRR), sample_alias (GSM), run_alias (GSM_r)]
  --desc           Should sample_attribute be included
  --expand         Should sample_attribute be expanded
```


## pysradb_gse-to-srp

### Tool Description
Convert GSE accession IDs to SRP accession IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb gse-to-srp [-h] [--saveto SAVETO] [--detailed] [--desc]
                          [--expand]
                          gse_ids [gse_ids ...]

positional arguments:
  gse_ids

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
  --detailed       Output additional columns: [experiment_accession (SRX),
                   run_accession (SRR), sample_accession (SRS),
                   experiment_alias (GSM_), run_alias (GSM_r), sample_alias
                   (GSM)]
  --desc           Should sample_attribute be included
  --expand         Should sample_attribute be expanded
```


## pysradb_gsm-to-gse

### Tool Description
Convert GSM IDs to GSE IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb gsm-to-gse [-h] [--saveto SAVETO] [--detailed] [--desc]
                          [--expand]
                          gsm_ids [gsm_ids ...]

positional arguments:
  gsm_ids

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
  --detailed       Output additional columns: [sample_accession (SRS),
                   run_accession (SRR), sample_alias (GSM), run_alias (GSM_r)]
  --desc           Should sample_attribute be included
  --expand         Should sample_attribute be expanded
```


## pysradb_gsm-to-srp

### Tool Description
Convert GSM IDs to SRP IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb gsm-to-srp [-h] [--desc] [--detailed] [--expand]
                          [--saveto SAVETO]
                          gsm_ids [gsm_ids ...]

positional arguments:
  gsm_ids

options:
  -h, --help       show this help message and exit
  --desc           Should sample_attribute be included
  --detailed       Output additional columns: [experiment_accession (SRX),
                   sample_accession (SRS), run_accession (SRR),
                   experiment_alias (GSM), sample_alias (GSM), run_alias
                   (GSM_r), study_alias (GSE)]
  --expand         Should sample_attribute be expanded
  --saveto SAVETO  Save output to file
```


## pysradb_gsm-to-srr

### Tool Description
Convert GSM IDs to SRR IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb gsm-to-srr [-h] [--desc] [--detailed] [--expand]
                          [--saveto SAVETO]
                          gsm_ids [gsm_ids ...]

positional arguments:
  gsm_ids

options:
  -h, --help       show this help message and exit
  --desc           Should sample_attribute be included
  --detailed       Output additional columns: [experiment_accession (SRX),
                   sample_accession (SRS), study_accession (SRP), run_alias
                   (GSM_r), sample_alias (GSM), study_alias (GSE)]
  --expand         Should sample_attribute be expanded
  --saveto SAVETO  Save output to file
```


## pysradb_gsm-to-srs

### Tool Description
Convert GSM IDs to SRS IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb gsm-to-srs [-h] [--desc] [--detailed] [--expand]
                          [--saveto SAVETO]
                          gsm_ids [gsm_ids ...]

positional arguments:
  gsm_ids

options:
  -h, --help       show this help message and exit
  --desc           Should sample_attribute be included
  --detailed       Output additional columns: [experiment_accession (SRX),
                   run_accession (SRR), study_accession (SRP), run_alias
                   (GSM_r), experiment_alias (GSM), study_alias (GSE)]
  --expand         Should sample_attribute be expanded
  --saveto SAVETO  Save output to file
```


## pysradb_gsm-to-srx

### Tool Description
Convert GSM IDs to SRX IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb gsm-to-srx [-h] [--desc] [--detailed] [--expand]
                          [--saveto SAVETO]
                          gsm_ids [gsm_ids ...]

positional arguments:
  gsm_ids

options:
  -h, --help       show this help message and exit
  --desc           Should sample_attribute be included
  --detailed       Output additional columns: [experiment_accession (SRX),
                   sample_accession (SRS), run_accession (SRR),
                   experiment_alias (GSM), sample_alias (GSM), run_alias
                   (GSM_r), study_alias (GSE)]
  --expand         Should sample_attribute be expanded
  --saveto SAVETO  Save output to file
```


## pysradb_srp-to-gse

### Tool Description
Convert SRP accession to GSE accession

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb srp-to-gse [-h] [--saveto SAVETO] [--detailed] [--desc]
                          [--expand]
                          srp_id

positional arguments:
  srp_id

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
  --detailed       Output additional columns: [sample_accession,
                   run_accession]
  --desc           Should sample_attribute be included
  --expand         Should sample_attribute be expanded
```


## pysradb_srp-to-srr

### Tool Description
Convert SRP accession to SRR accessions

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb srp-to-srr [-h] [--saveto SAVETO] [--detailed] [--desc]
                          [--expand]
                          srp_id

positional arguments:
  srp_id

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
  --detailed       Output additional columns: [experiment_accession (SRX),
                   sample_accession (SRS), study_alias (GSE), experiment_alias
                   (GSM), sample_alias (GSM_), run_alias (GSM_r)]
  --desc           Should sample_attribute be included
  --expand         Should sample_attribute be expanded
```


## pysradb_srp-to-srs

### Tool Description
Convert SRP accession to SRS accession

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb srp-to-srs [-h] [--saveto SAVETO] [--detailed] [--desc]
                          [--expand]
                          srp_id

positional arguments:
  srp_id

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
  --detailed       Output additional columns: [run_accession (SRR),
                   study_accession (SRP), experiment_alias (GSM), sample_alias
                   (GSM_), run_alias (GSM_r), study_alias (GSE)]
  --desc           Should sample_attribute be included
  --expand         Should sample_attribute be expanded
```


## pysradb_srp-to-srx

### Tool Description
Convert SRP accession to SRX accession

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb srp-to-srx [-h] [--saveto SAVETO] [--detailed] [--desc]
                          [--expand]
                          srp_id

positional arguments:
  srp_id

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
  --detailed       Output additional columns: [sample_accession (SRS),
                   run_accession (SRR), experiment_alias (GSM), sample_alias
                   (GSM_), run_alias (GSM_r)', study_alias (GSE)]
  --desc           Should sample_attribute be included
  --expand         Should sample_attribute be expanded
```


## pysradb_srr-to-gsm

### Tool Description
Convert SRR IDs to GSM IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb srr-to-gsm [-h] [--detailed] [--desc] [--expand]
                          [--saveto SAVETO]
                          srr_ids [srr_ids ...]

positional arguments:
  srr_ids

options:
  -h, --help       show this help message and exit
  --detailed       'Output additional columns: [experiment_accession (SRX),
                   study_accession (SRP), run_alias (GSM_r), sample_alias
                   (GSM_), experiment_alias (GSM), study_alias (GSE)]
  --desc           Should sample_attribute be included
  --expand         Should sample_attribute be expanded
  --saveto SAVETO  Save output to file
```


## pysradb_srr-to-srp

### Tool Description
Convert SRR IDs to SRP IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb srr-to-srp [-h] [--detailed] [--desc] [--expand]
                          [--saveto SAVETO]
                          srr_ids [srr_ids ...]

positional arguments:
  srr_ids

options:
  -h, --help       show this help message and exit
  --detailed       'Output additional columns: [experiment_accession (SRX),
                   sample_accession (SRS), run_alias (GSM_r), experiment_alias
                   (GSM), sample_alias (GSM_), study_alias (GSE)]
  --desc           Should sample_attribute be included
  --expand         Should sample_attribute be expanded
  --saveto SAVETO  Save output to file
```


## pysradb_srr-to-srs

### Tool Description
Convert SRR IDs to SRS IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb srr-to-srs [-h] [--detailed] [--desc] [--expand]
                          [--saveto SAVETO]
                          srr_ids [srr_ids ...]

positional arguments:
  srr_ids

options:
  -h, --help       show this help message and exit
  --detailed       'Output additional columns: [experiment_accession (SRX),
                   study_accession (SRP), run_alias (GSM_r), sample_alias
                   (GSM_), experiment_alias (GSM), study_alias (GSE)]
  --desc           Should sample_attribute be included
  --expand         Should sample_attribute be expanded
  --saveto SAVETO  Save output to file
```


## pysradb_srr-to-srx

### Tool Description
Convert SRR IDs to SRX IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb srr-to-srx [-h] [--detailed] [--desc] [--expand]
                          [--saveto SAVETO]
                          srr_ids [srr_ids ...]

positional arguments:
  srr_ids

options:
  -h, --help       show this help message and exit
  --detailed       Output additional columns: [sample_accession (SRS),
                   study_accession (SRP), run_alias (GSM_r), experiment_alias
                   (GSM), sample_alias (GSM_), study_alias (GSE)]
  --desc           Should sample_attribute be included
  --expand         Should sample_attribute be expanded
  --saveto SAVETO  Save output to file
```


## pysradb_srs-to-gsm

### Tool Description
Convert SRS IDs to GSM IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb srs-to-gsm [-h] [--saveto SAVETO] [--detailed] [--desc]
                          [--expand]
                          srs_ids [srs_ids ...]

positional arguments:
  srs_ids

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
  --detailed       Output additional columns: [run_accession, study_accession]
  --desc           Should sample_attribute be included
  --expand         Should sample_attribute be expanded
```


## pysradb_srs-to-srx

### Tool Description
Convert SRS IDs to SRX IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb srs-to-srx [-h] [--saveto SAVETO] [--detailed] [--desc]
                          [--expand]
                          srs_ids [srs_ids ...]

positional arguments:
  srs_ids

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
  --detailed       Output additional columns: [run_accession, study_accession]
  --desc           Should sample_attribute be included
  --expand         Should sample_attribute be expanded
```


## pysradb_srx-to-srp

### Tool Description
Convert SRX IDs to SRP IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb srx-to-srp [-h] [--desc] [--detailed] [--expand]
                          [--saveto SAVETO]
                          srx_ids [srx_ids ...]

positional arguments:
  srx_ids

options:
  -h, --help       show this help message and exit
  --desc           Should sample_attribute be included
  --detailed       Output additional columns: [run_accession (SRR),
                   sample_accession (SRS), experiment_alias (GSM), run_alias
                   (GSM_r), sample_alias (GSM), study_alias (GSE)]
  --expand         Should sample_attribute be expanded
  --saveto SAVETO  Save output to file
```


## pysradb_srx-to-srr

### Tool Description
Convert SRX IDs to SRR IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb srx-to-srr [-h] [--desc] [--detailed] [--expand]
                          [--saveto SAVETO]
                          srx_ids [srx_ids ...]

positional arguments:
  srx_ids

options:
  -h, --help       show this help message and exit
  --desc           Should sample_attribute be included
  --detailed       Output additional columns: [sample_accession,
                   study_accession]
  --expand         Should sample_attribute be expanded
  --saveto SAVETO  Save output to file
```


## pysradb_srx-to-srs

### Tool Description
Convert SRX IDs to SRS IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb srx-to-srs [-h] [--saveto SAVETO] [--detailed] [--desc]
                          [--expand]
                          srx_ids [srx_ids ...]

positional arguments:
  srx_ids

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
  --detailed       Output additional columns: [run_accession, study_accession]
  --desc           Should sample_attribute be included
  --expand         Should sample_attribute be expanded
```


## pysradb_geo-matrix

### Tool Description
Generates a matrix from GEO accession data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb geo-matrix [-h] --accession ACCESSION [--to-tsv]
                          [--output-dir OUTPUT_DIR]

options:
  -h, --help            show this help message and exit
  --accession ACCESSION
                        GEO accession (e.g., GSE234190)
  --to-tsv              Convert the matrix file to TSV format
  --output-dir OUTPUT_DIR
                        Output directory (default: current directory)
```


## pysradb_srp-to-pmid

### Tool Description
Convert SRP accession(s) to PMID(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb srp-to-pmid [-h] [--saveto SAVETO] srp_ids [srp_ids ...]

positional arguments:
  srp_ids          SRP accession(s)

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
```


## pysradb_gse-to-pmid

### Tool Description
Convert GSE accession(s) to PMID(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb gse-to-pmid [-h] [--saveto SAVETO] gse_ids [gse_ids ...]

positional arguments:
  gse_ids          GSE accession(s)

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
```


## pysradb_pmid-to-gse

### Tool Description
Convert PMID(s) to GSE accession(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb pmid-to-gse [-h] [--saveto SAVETO] pmid_ids [pmid_ids ...]

positional arguments:
  pmid_ids         PMID(s)

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
```


## pysradb_pmid-to-srp

### Tool Description
Convert PMID(s) to SRP accession(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb pmid-to-srp [-h] [--saveto SAVETO] pmid_ids [pmid_ids ...]

positional arguments:
  pmid_ids         PMID(s)

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
```


## pysradb_pmc-to-identifiers

### Tool Description
Convert PMC IDs to accession identifiers.

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb pmc-to-identifiers [-h] [--saveto SAVETO] pmc_ids [pmc_ids ...]

positional arguments:
  pmc_ids          PMC ID(s)

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
```


## pysradb_pmid-to-identifiers

### Tool Description
Convert PMID(s) to SRA accession(s) and Experiment accession(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb pmid-to-identifiers [-h] [--saveto SAVETO]
                                   pmid_ids [pmid_ids ...]

positional arguments:
  pmid_ids         PMID(s)

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
```


## pysradb_Extract

### Tool Description
Query NGS metadata and data from NCBI Sequence Read Archive.

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb [-h] [--version] [--citation]
               {metadata,download,search,gse-to-gsm,gse-to-srp,gsm-to-gse,gsm-to-srp,gsm-to-srr,gsm-to-srs,gsm-to-srx,srp-to-gse,srp-to-srr,srp-to-srs,srp-to-srx,srr-to-gsm,srr-to-srp,srr-to-srs,srr-to-srx,srs-to-gsm,srs-to-srx,srx-to-srp,srx-to-srr,srx-to-srs,geo-matrix,srp-to-pmid,gse-to-pmid,pmid-to-gse,pmid-to-srp,pmc-to-identifiers,pmid-to-identifiers,doi-to-gse,doi-to-srp,doi-to-identifiers} ...

pysradb: Query NGS metadata and data from NCBI Sequence Read Archive.
version: 2.5.1.
Citation: 10.12688/f1000research.18676.1

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --citation            how to cite

subcommands:
  {metadata,download,search,gse-to-gsm,gse-to-srp,gsm-to-gse,gsm-to-srp,gsm-to-srr,gsm-to-srs,gsm-to-srx,srp-to-gse,srp-to-srr,srp-to-srs,srp-to-srx,srr-to-gsm,srr-to-srp,srr-to-srs,srr-to-srx,srs-to-gsm,srs-to-srx,srx-to-srp,srx-to-srr,srx-to-srs,geo-matrix,srp-to-pmid,gse-to-pmid,pmid-to-gse,pmid-to-srp,pmc-to-identifiers,pmid-to-identifiers,doi-to-gse,doi-to-srp,doi-to-identifiers}
    metadata            Fetch metadata for SRA project (SRPnnnn)
    download            Download SRA project (SRPnnnn)
    search              Search SRA/ENA for matching text
    gse-to-gsm          Get GSM for a GSE
    gse-to-srp          Get SRP for a GSE
    gsm-to-gse          Get GSE for a GSM
    gsm-to-srp          Get SRP for a GSM
    gsm-to-srr          Get SRR for a GSM
    gsm-to-srs          Get SRS for a GSM
    gsm-to-srx          Get SRX for a GSM
    srp-to-gse          Get GSE for a SRP
    srp-to-srr          Get SRR for a SRP
    srp-to-srs          Get SRS for a SRP
    srp-to-srx          Get SRX for a SRP
    srr-to-gsm          Get GSM for a SRR
    srr-to-srp          Get SRP for a SRR
    srr-to-srs          Get SRS for a SRR
    srr-to-srx          Get SRX for a SRR
    srs-to-gsm          Get GSM for a SRS
    srs-to-srx          Get SRX for a SRS
    srx-to-srp          Get SRP for a SRX
    srx-to-srr          Get SRR for a SRX
    srx-to-srs          Get SRS for a SRX
    geo-matrix          Download and parse GEO Matrix files
    srp-to-pmid         Get PMIDs for SRP accessions
    gse-to-pmid         Get PMIDs for GSE accessions
    pmid-to-gse         Get GSE accessions from PMIDs
    pmid-to-srp         Get SRP accessions from PMIDs
    pmc-to-identifiers  Extract database identifiers from PMC articles
    pmid-to-identifiers
                        Extract database identifiers from PubMed articles
    doi-to-gse          Get GSE accessions from DOIs
    doi-to-srp          Get SRP accessions from DOIs
    doi-to-identifiers  Extract database identifiers from articles via DOI
```


## pysradb_doi-to-gse

### Tool Description
Convert DOI(s) to GSE accession(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb doi-to-gse [-h] [--saveto SAVETO] doi_ids [doi_ids ...]

positional arguments:
  doi_ids          DOI(s)

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
```


## pysradb_doi-to-srp

### Tool Description
Convert DOI(s) to SRP accession(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb doi-to-srp [-h] [--saveto SAVETO] doi_ids [doi_ids ...]

positional arguments:
  doi_ids          DOI(s)

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
```


## pysradb_doi-to-identifiers

### Tool Description
Convert DOI(s) to SRA/GEO identifiers.

### Metadata
- **Docker Image**: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/saketkc/pysradb
- **Package**: https://anaconda.org/channels/bioconda/packages/pysradb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pysradb doi-to-identifiers [-h] [--saveto SAVETO] doi_ids [doi_ids ...]

positional arguments:
  doi_ids          DOI(s)

options:
  -h, --help       show this help message and exit
  --saveto SAVETO  Save output to file
```


## Metadata
- **Skill**: generated
