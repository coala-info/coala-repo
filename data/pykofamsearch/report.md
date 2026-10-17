# pykofamsearch CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pykofamsearch | PASS | 56 real KOfam profiles; hits match HMMER 3.4 with the ko_list thresholds; --database_directory stops with KeyError 'enzyme_commission' (tool bug), the serialized database mode works |
| pykofamsearch_reformat_pykofamsearch | PASS |  |
| pykofamsearch_serialize_kofam_models | PASS |  |
| pykofamsearch_subset_serialized_models | PASS |  |

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

## pykofamsearch_serialize_kofam_models

### Tool Description
Serialize the KOfam HMM profiles and ko_list thresholds into one pickled database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pykofamsearch:2025.9.5--pyhdfd78af_1
- **Homepage**: https://github.com/jolespin/pykofamsearch
- **Package**: https://anaconda.org/channels/bioconda/packages/pykofamsearch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: serialize_kofam_models -d <path/to/kofam_profiles_database_directory/> -k <path/to/ko_list> -b <kofam_hmm_database.pkl.gz> -f name 

    Running: serialize_kofam_models v2025.9.5 via Python v3.12.11 | /usr/local/bin/python3.12

options:
  -h, --help            show this help message and exit
  --verbosity VERBOSITY
                        Verbosity of missing KOfams [Default: 1]
  -v, --version         show program's version number and exit

Offline arguments:
  -b SERIALIZED_DATABASE, --serialized_database SERIALIZED_DATABASE
                        path/to/database.pkl[.gz] will be tuple where first item is threshold dictionary and second item is dictionary of HMM models. Cannot be used with -o/--output_directory
  -d PROFILES, --profiles PROFILES
                        path/to/kofam_profiles_database_directory/ .  [Command: `wget -v -c ftp://ftp.genome.jp/pub/db/kofam/profiles.tar.gz -O - |  tar -xz`]
  -k KO_LIST, --ko_list KO_LIST
                        path/to/ko_list[.gz] . [Command: wget -v -O - ftp://ftp.genome.jp/pub/db/kofam/ko_list.gz | gzip -d > ko_list]

Online arguments:
  -o OUTPUT_DIRECTORY, --output_directory OUTPUT_DIRECTORY
                        path/to/output_directory/.  Cannot be used with -b/--serialized_database
  --ko_list_url KO_LIST_URL
                        FTP URL for ko_list [Default: ftp://ftp.genome.jp/pub/db/kofam/ko_list.gz]
  --profiles_url PROFILES_URL
                        FTP URL for profiles.tar.gz [Default: ftp://ftp.genome.jp/pub/db/kofam/profiles.tar.gz]

PyKOfamSearch
```

## pykofamsearch_subset_serialized_models

### Tool Description
Subset a serialized KOfam database to a list of identifiers.

### Metadata
- **Docker Image**: quay.io/biocontainers/pykofamsearch:2025.9.5--pyhdfd78af_1
- **Homepage**: https://github.com/jolespin/pykofamsearch
- **Package**: https://anaconda.org/channels/bioconda/packages/pykofamsearch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: subset_serialized_models -i <path/to/identifiers.list> -b <kofam_hmm_database.pkl.gz> -s <subset_kofam_hmm_database.pkl.gz>

    Running: subset_serialized_models v2025.9.5 via Python v3.12.11 | /usr/local/bin/python3.12

options:
  -h, --help            show this help message and exit
  --verbosity VERBOSITY
                        Verbosity of missing KOfams [Default: 1]
  -v, --version         show program's version number and exit

Database arguments:
  -i IDENTIFIERS, --identifiers IDENTIFIERS
                        path/to/identifiers.list where HMM identifiers are on a separate line
  -b SERIALIZED_DATABASE, --serialized_database SERIALIZED_DATABASE
                        path/to/database.pkl[.gz] will be tuple where first item is threshold dictionary and second item is dictionary of HMM models
  -s SUBSET_SERIALIZED_DATABASE, --subset_serialized_database SUBSET_SERIALIZED_DATABASE
                        path/to/subset-database.pkl[.gz] will be tuple where first item is threshold dictionary and second item is dictionary of HMM models

PyKOfamSearch
```

## pykofamsearch_reformat_pykofamsearch

### Tool Description
Reformat the pykofamsearch hit table into one row per protein or a pickled dictionary.

### Metadata
- **Docker Image**: quay.io/biocontainers/pykofamsearch:2025.9.5--pyhdfd78af_1
- **Homepage**: https://github.com/jolespin/pykofamsearch
- **Package**: https://anaconda.org/channels/bioconda/packages/pykofamsearch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reformat_pykofamsearch -i <input.tsv> -o <output.tsv> -f <format> 

    Running: reformat_pykofamsearch v2025.9.5 via Python v3.12.11 | /usr/local/bin/python3.12

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -i INPUT, --input INPUT
                        path/to/input.tsv. The results of `pykofamsearch.py` [Default: stdin]
  -o OUTPUT, --output OUTPUT
                        path/to/output.tsv [Default: stdout]
  -f {table,pickle}, --format {table,pickle}
                        Output format
  --no_header           Input does not have header
  -b, --best_hits_only  Best hits only

PyKOfamSearch
```
