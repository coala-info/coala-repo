# locidex CWL Generation Report

## locidex_search

### Tool Description
Query set of Loci/Genes against a database to produce a sequence store for downstream processing

### Metadata
- **Docker Image**: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/locidex/
- **Package**: https://anaconda.org/channels/bioconda/packages/locidex/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/locidex/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-08-28
- **GitHub**: https://github.com/phac-nml/locidex
- **Stars**: N/A
### Original Help Text
```text
usage: locidex search [-h] -q QUERY -o OUTDIR (-d DB | --db_group DB_GROUP)
                      [-n NAME] [-c CONFIG] [--db_name DB_NAME]
                      [--db_version DB_VERSION] [--min_evalue MIN_EVALUE]
                      [--min_dna_len MIN_DNA_LEN] [--min_aa_len MIN_AA_LEN]
                      [--max_dna_len MAX_DNA_LEN] [--max_aa_len MAX_AA_LEN]
                      [--min_dna_ident MIN_DNA_IDENT]
                      [--min_aa_ident MIN_AA_IDENT]
                      [--min_dna_match_cov MIN_DNA_MATCH_COV]
                      [--min_aa_match_cov MIN_AA_MATCH_COV]
                      [--max_target_seqs MAX_TARGET_SEQS] [--override]
                      [--n_threads N_THREADS] [--format FORMAT]
                      [--translation_table TRANSLATION_TABLE] [-a] [-V] [-f]

Query set of Loci/Genes against a database to produce a sequence store for
downstream processing

options:
  -h, --help            show this help message and exit
  -q, --query QUERY     Query sequence file
  -o, --outdir OUTDIR   Output directory to put results
  -d, --db DB           Locidex database directory
  --db_group DB_GROUP   A directory of databases containing a manifest file.
                        Requires the db_name option to be set to select the
                        correct db
  -n, --name NAME       Sample name to include default=filename
  -c, --config CONFIG   Locidex parameter config file (json)
  --db_name DB_NAME     Name of database to perform search, used when a
                        manifest is specified as a db
  --db_version DB_VERSION
                        Version of database to perform search, used when a
                        manifest is specified as a db
  --min_evalue MIN_EVALUE
                        Minumum evalue required for match
  --min_dna_len MIN_DNA_LEN
                        Global minumum query length dna
  --min_aa_len MIN_AA_LEN
                        Global minumum query length aa
  --max_dna_len MAX_DNA_LEN
                        Global maximum query length dna
  --max_aa_len MAX_AA_LEN
                        Global maximum query length aa
  --min_dna_ident MIN_DNA_IDENT
                        Global minumum DNA percent identity required for match
  --min_aa_ident MIN_AA_IDENT
                        Global minumum AA percent identity required for match
  --min_dna_match_cov MIN_DNA_MATCH_COV
                        Global minumum DNA percent hit coverage identity
                        required for match
  --min_aa_match_cov MIN_AA_MATCH_COV
                        Global minumum AA percent hit coverage identity
                        required for match
  --max_target_seqs MAX_TARGET_SEQS
                        Maximum number of hit seqs per query
  --override            Overwrite individual loci thresholds for filtering and
                        use the global parameters
  --n_threads, -t N_THREADS
                        CPU Threads to use
  --format FORMAT       Format of query file [genbank,fasta]
  --translation_table TRANSLATION_TABLE
                        Table to use for translation
  -a, --annotate        Perform annotation on unannotated input fasta
  -V, --version         show program's version number and exit
  -f, --force           Overwrite existing directory
```


## locidex_extract

### Tool Description
Extract loci from a genome based on a locidex database

### Metadata
- **Docker Image**: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/locidex/
- **Package**: https://anaconda.org/channels/bioconda/packages/locidex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: locidex extract [-h] -i IN_FASTA -o OUTDIR [-n NAME] (-d DB |
                       --db_group DB_GROUP) [--db_name DB_NAME]
                       [--db_version DB_VERSION] [-c CONFIG]
                       [--min_evalue MIN_EVALUE] [--min_dna_len MIN_DNA_LEN]
                       [--min_aa_len MIN_AA_LEN] [--max_dna_len MAX_DNA_LEN]
                       [--min_dna_ident MIN_DNA_IDENT]
                       [--min_aa_ident MIN_AA_IDENT]
                       [--min_dna_match_cov MIN_DNA_MATCH_COV]
                       [--min_aa_match_cov MIN_AA_MATCH_COV]
                       [--max_target_seqs MAX_TARGET_SEQS] [--keep_truncated]
                       [--mode {snps,trim,raw,extend}] [--n_threads N_THREADS]
                       [--format FORMAT]
                       [--translation_table TRANSLATION_TABLE]
                       [--protein_coding PROTEIN_CODING] [-V] [-f]

Extract loci from a genome based on a locidex database

options:
  -h, --help            show this help message and exit
  -i, --in_fasta IN_FASTA
                        Query assembly sequence file (fasta)
  -o, --outdir OUTDIR   Output directory to put results
  -n, --name NAME       Sample name to include default=filename
  -d, --db DB           Locidex database directory
  --db_group DB_GROUP   A directory of databases containing a manifest file.
                        Requires the db_name option to be set to select the
                        correct db
  --db_name DB_NAME     Name of database to perform search, used when a
                        manifest is specified as a db
  --db_version DB_VERSION
                        Version of database to perform search, used when a
                        manifest is specified as a db
  -c, --config CONFIG   Locidex parameter config file (json)
  --min_evalue MIN_EVALUE
                        Minumum evalue required for match
  --min_dna_len MIN_DNA_LEN
                        Global minumum query length dna
  --min_aa_len MIN_AA_LEN
                        Global minumum query length aa
  --max_dna_len MAX_DNA_LEN
                        Global maximum query length dna
  --min_dna_ident MIN_DNA_IDENT
                        Global minumum DNA percent identity required for match
  --min_aa_ident MIN_AA_IDENT
                        Global minumum AA percent identity required for match
  --min_dna_match_cov MIN_DNA_MATCH_COV
                        Global minumum DNA percent hit coverage identity
                        required for match
  --min_aa_match_cov MIN_AA_MATCH_COV
                        Global minumum AA percent hit coverage identity
                        required for match
  --max_target_seqs MAX_TARGET_SEQS
                        Maximum number of hit seqs per query
  --keep_truncated      Keep sequences where match is broken at the end of a
                        sequence
  --mode {snps,trim,raw,extend}
                        Select from the options provided
  --n_threads, -t N_THREADS
                        CPU Threads to use
  --format FORMAT       Format of query file [genbank,fasta]
  --translation_table TRANSLATION_TABLE
                        output directory
  --protein_coding PROTEIN_CODING
                        output directory
  -V, --version         show program's version number and exit
  -f, --force           Overwrite existing directory
```


## locidex_report

### Tool Description
Filter a sequence store and produce and extract of blast results and gene profile

### Metadata
- **Docker Image**: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/locidex/
- **Package**: https://anaconda.org/channels/bioconda/packages/locidex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: locidex report [-h] -i INPUT [--fasta FASTA] [-c CONFIG] -o OUTDIR
                      [-n NAME] [-m MODE] [-p PROP] [-a MAX_AMBIG]
                      [-s MAX_STOP] [-r MATCH_IDENT] [-l MATCH_COV]
                      [-b MIN_LEN] [-x MAX_LEN] [--override]
                      [--translation_table TRANSLATION_TABLE] [-V] [-f]

Filter a sequence store and produce and extract of blast results and gene
profile

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     Input seq_store file to report
  --fasta FASTA         Optional: Query fasta file used to generate search
                        results
  -c, --config CONFIG   Locidex parameter config file (json)
  -o, --outdir OUTDIR   Output file to put results
  -n, --name NAME       Sample name to include default=filename
  -m, --mode MODE       Allele profile assignment [normal,conservative,fuzzy]
  -p, --prop PROP       Metadata label to use for aggregation
  -a, --max_ambig MAX_AMBIG
                        Maximum number of ambiguous characters allowed in a
                        sequence
  -s, --max_stop MAX_STOP
                        Maximum number of internal stop codons allowed in a
                        sequence
  -r, --match_ident MATCH_IDENT
                        Report match if percent identity is >= this value
  -l, --match_cov MATCH_COV
                        Report match if percent coverage is >= this value
  -b, --min_len MIN_LEN
                        Report match if query length is >= this value
  -x, --max_len MAX_LEN
                        Report match allele length is <= this value
  --override            Overwrite individual loci thresholds for filtering and
                        use the global parameters
  --translation_table TRANSLATION_TABLE
                        output directory
  -V, --version         show program's version number and exit
  -f, --force           Overwrite existing directory
```


## locidex_merge

### Tool Description
Merge a set of gene profiles into a standard profile format

### Metadata
- **Docker Image**: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/locidex/
- **Package**: https://anaconda.org/channels/bioconda/packages/locidex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: locidex merge [-h] -i INPUT [INPUT ...] -o OUTDIR [-V] [-s] [-f]
                     [-p PROFILE_REF] [--loci LOCI]

Merge a set of gene profiles into a standard profile format

options:
  -h, --help            show this help message and exit
  -i, --input INPUT [INPUT ...]
                        Input file to report
  -o, --outdir OUTDIR   Output file to put results
  -V, --version         show program's version number and exit
  -s, --strict          Only merge data produces by the same db
  -f, --force           Overwrite existing directory
  -p, --profile_ref PROFILE_REF
                        Provide a TSV file with profile references for
                        overriding MLST profiles. Columns
                        [sample/sample_name,mlst_alleles]
  --loci LOCI           Specifies a file (or command-separated list) of loci
                        to keep from MLST files
```


## locidex_format

### Tool Description
Format fasta files from other MLST databases for use with locidex build

### Metadata
- **Docker Image**: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/locidex/
- **Package**: https://anaconda.org/channels/bioconda/packages/locidex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: locidex format [-h] -i INPUT -o OUTDIR [--min_len_frac MIN_LEN_FRAC]
                      [--max_len_frac MAX_LEN_FRAC] [--min_ident MIN_IDENT]
                      [--min_match_cov MIN_MATCH_COV]
                      [--translation_table TRANSLATION_TABLE] [-n] [-V] [-f]

Format fasta files from other MLST databases for use with locidex build

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     Input directory of fasta files or input fasta
  -o, --outdir OUTDIR   Output directory to put results
  --min_len_frac MIN_LEN_FRAC
                        Used to calculate individual sequence minimum
                        acceptable length (0 - 1)
  --max_len_frac MAX_LEN_FRAC
                        Used to calculate individual sequence maximimum
                        acceptable length (1 - n)
  --min_ident MIN_IDENT
                        Global minumum percent identity required for match
  --min_match_cov MIN_MATCH_COV
                        Global minumum percent hit coverage identity required
                        for match
  --translation_table TRANSLATION_TABLE
                        output directory
  -n, --not_coding      Skip translation
  -V, --version         show program's version number and exit
  -f, --force           Overwrite existing directory
```


## locidex_build

### Tool Description
Build a locidex database

### Metadata
- **Docker Image**: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/locidex/
- **Package**: https://anaconda.org/channels/bioconda/packages/locidex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: locidex build [-h] -i INPUT_FILE -o OUTDIR -n NAME [-a AUTHOR]
                     [-c DB_VER] [-e DB_DESC] [-t TRANSLATION_TABLE] [-V] [-f]

Build a locidex database

options:
  -h, --help            show this help message and exit
  -i, --input_file INPUT_FILE
                        Input tsv formated for locidex
  -o, --outdir OUTDIR   Output directory to put results
  -n, --name NAME       Database name
  -a, --author AUTHOR   Author Name for Locidex Database. Default: root
  -c, --db_ver DB_VER   Version code for locidex db: 1.0.0
  -e, --db_desc DB_DESC
                        Version code for locidex db
  -t, --translation_table TRANSLATION_TABLE
                        Translation table to use: 11
  -V, --version         show program's version number and exit
  -f, --force           Overwrite existing directory
```


## locidex_manifest

### Tool Description
Create a multi-database folder manifest

### Metadata
- **Docker Image**: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/locidex/
- **Package**: https://anaconda.org/channels/bioconda/packages/locidex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: locidex manifest [-h] -i INPUT [-V]

Create a multi-database folder manifest

options:
  -h, --help         show this help message and exit
  -i, --input INPUT  Input directory containing multiple locidex databases
  -V, --version      show program's version number and exit
```


## Metadata
- **Skill**: generated
