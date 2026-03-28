# pgscatalog.core CWL Generation Report

## pgscatalog.core_pgscatalog-download

### Tool Description
Download a set of scoring files from the PGS Catalog using PGS Scoring IDs, traits, or publication accessions.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog.core:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/pygscatalog/
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog.core/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pgscatalog.core/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-12-13
- **GitHub**: https://github.com/PGScatalog/pygscatalog
- **Stars**: N/A
### Original Help Text
```text
usage: pgscatalog-download [-h] [-i PGS [PGS ...]] [-t EFO [EFO ...]] [-e]
                           [-p PGP [PGP ...]] [-b {GRCh37,GRCh38}] -o OUTDIR
                           [-w] [-c USER_AGENT] [-v]

Download a set of scoring files from the PGS Catalog using PGS Scoring
IDs, traits, or publication accessions.

The PGS Catalog API is queried to get a list of scoring file URLs.
Scoring files are downloaded asynchronously via HTTPS to a specified
directory. Downloaded files are automatically validated against an md5
checksum.

PGS Catalog scoring files are staged with the name:

    {PGS_ID}.txt.gz

If a valid build is specified harmonized files are downloaded as:

    {PGS_ID}_hmPOS_{genome_build}.txt.gz

These harmonised scoring files contain genomic coordinates, remapped
from author-submitted information such as rsIDs.

options:
  -h, --help            show this help message and exit
  -i, --pgs PGS [PGS ...]
                        PGS Catalog ID(s) (e.g. PGS000001)
  -t, --efo EFO [EFO ...]
                        Traits described by an EFO term(s) (e.g. EFO_0004611)
  -e, --efo_direct      <Optional> Return only PGS tagged with exact EFO term
                        (e.g. no PGS for child/descendant terms in the
                        ontology)
  -p, --pgp PGP [PGP ...]
                        PGP publication ID(s) (e.g. PGP000007)
  -b, --build {GRCh37,GRCh38}
                        Download harmonized scores with positions in genome
                        build: GRCh37 or GRCh38
  -o, --outdir OUTDIR   <Required> Output directory to store downloaded files
  -w, --overwrite       <Optional> Overwrite existing Scoring File if a new
                        version is available for download on the FTP
  -c, --user_agent USER_AGENT
                        <Optional> Provide custom user agent when querying PGS
                        Catalog API
  -v, --verbose         <Optional> Extra logging information
```


## pgscatalog.core_pgscatalog-format

### Tool Description
Format multiple scoring files in PGS Catalog format (see https://www.pgscatalog.org/downloads/ for details) to a standard column set needed for variant matching and subsequent calculation. During this process Variants are checked to make sure they pass data validation using the PGS Catalog standard data models. Custom scorefiles in PGS Catalog format can be combined with PGS Catalog scoring files, and optionally liftover genomic coordinates to GRCh37 or GRCh38. The script can accept a mix of unharmonised and harmonised PGS Catalog data. By default all variants are output (including positions with duplicated data [often caused by rsID/liftover collions across builds]) and variants with missing positions.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog.core:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/pygscatalog/
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog.core/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgscatalog-format [-h] -s SCOREFILES [SCOREFILES ...] [--liftover]
                         -t {GRCh37,GRCh38} [-c CHAIN_DIR] [-m MIN_LIFT]
                         [--drop_missing] -o OUTFILE [-l LOGFILE] [-v]
                         [--batch_size BATCH_SIZE] [--threads THREADS]

Format multiple scoring files in PGS Catalog format (see 
https://www.pgscatalog.org/downloads/ for details) to a standard column set 
needed for variant matching and subsequent calculation. During this process Variants 
are checked to make sure they pass data validation using the PGS Catalog standard data models. 

Custom scorefiles in PGS Catalog format can be combined with PGS Catalog scoring files, and 
optionally liftover genomic coordinates to GRCh37 or GRCh38. The script can accept a mix of
unharmonised and harmonised PGS Catalog data. By default all variants are output (including 
positions with duplicated data [often caused by rsID/liftover collions across builds]) and 
variants with missing positions. 

options:
  -h, --help            show this help message and exit
  -s, --scorefiles SCOREFILES [SCOREFILES ...]
                        <Required> Scorefile paths
  --liftover            <Optional> Convert scoring file variants to target
                        genome build?
  -t, --target_build {GRCh37,GRCh38}
                        <Required> Build of target genome
  -c, --chain_dir CHAIN_DIR
                        Path to directory containing chain files
  -m, --min_lift MIN_LIFT
                        <Optional> If liftover, minimum proportion of variants
                        lifted over
  --drop_missing        <Optional> Drop variants with missing information
                        (chr/pos) and non-standard alleles (e.g. HLA=P/N) from
                        the output file.
  -o, --outfile OUTFILE
                        <Required> Output path to combined long scorefile [
                        will compress output if filename ends with .gz ]
  -l, --logfile LOGFILE
                        <Required> Name for the log file (score metadata) for
                        combined scores.[ will write to identical directory as
                        combined scorefile]
  -v, --verbose         <Optional> Extra logging information
  --batch_size BATCH_SIZE
                        <Optional> Number of records to process in each batch
  --threads THREADS     <Optional> Number of Python worker processes to use

The standard column set is used by other PGS Catalog applications such as pgscatalog-match.
```


## pgscatalog.core_pgscatalog-relabel

### Tool Description
Relabel the column values in one file based on a pair of columns in another

### Metadata
- **Docker Image**: quay.io/biocontainers/pgscatalog.core:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/pygscatalog/
- **Package**: https://anaconda.org/channels/bioconda/packages/pgscatalog.core/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgscatalog-relabel [-h] -d DATASET -m MAP_FILES [MAP_FILES ...]
                          -o OUTDIR --col_from COL_FROM --col_to COL_TO
                          --target_file TARGET_FILE --target_col TARGET_COL
                          [-v] [--split] [--combined] [-cc COMMENT_CHAR]

Relabel the column values in one file based on a pair of columns in another

options:
  -h, --help            show this help message and exit
  -d, --dataset DATASET
                        <Required> Label for target genomic dataset
  -m, --maps MAP_FILES [MAP_FILES ...]
                        mapping filenames
  -o, --outdir OUTDIR   output directory
  --col_from COL_FROM   column to change FROM
  --col_to COL_TO       column to change TO
  --target_file TARGET_FILE
                        target file
  --target_col TARGET_COL
                        target column to revalue
  -v, --verbose         <Optional> Extra logging information
  --split
  --combined
  -cc, --comment_char COMMENT_CHAR
```


## Metadata
- **Skill**: generated
