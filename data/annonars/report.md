# annonars CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| annonars_clinvar-genes_import | PASS |  |
| annonars_clinvar-genes_query | PASS |  |
| annonars_clinvar-minimal_import | PASS |  |
| annonars_clinvar-minimal_query | PASS |  |
| annonars_clinvar-sv_import | PASS |  |
| annonars_clinvar-sv_query | PASS |  |
| annonars_cons_import | PASS |  |
| annonars_cons_query | PASS |  |
| annonars_db-utils_copy | PASS |  |
| annonars_db-utils_dump-meta | PASS |  |
| annonars_dbsnp_import | PASS |  |
| annonars_dbsnp_query | PASS |  |
| annonars_freqs_import | PASS |  |
| annonars_freqs_query | PASS |  |
| annonars_functional_import | PASS |  |
| annonars_functional_query | PASS |  |
| annonars_gene_import | PASS |  |
| annonars_gene_query | PASS |  |
| annonars_gnomad-mtdna_import | PASS |  |
| annonars_gnomad-mtdna_query | PASS |  |
| annonars_gnomad-nuclear_import | PASS |  |
| annonars_gnomad-nuclear_query | PASS |  |
| annonars_gnomad-sv_import | PASS |  |
| annonars_gnomad-sv_query | PASS |  |
| annonars_helixmtdb_import | PASS |  |
| annonars_helixmtdb_query | PASS |  |
| annonars_regions_import | PASS |  |
| annonars_regions_query | PASS |  |
| annonars_server_schema | PASS |  |
| annonars_tsv_import | PASS |  |
| annonars_tsv_query | PASS |  |

## annonars_clinvar-genes_import

### Tool Description
"import" sub command: Import ClinVar per-gene data (per-impact and per-frequency counts and variants) into a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"import" sub command

Usage: annonars clinvar-genes import [OPTIONS] --path-per-impact-jsonl <PATH_PER_IMPACT_JSONL> --path-per-frequency-jsonl <PATH_PER_FREQUENCY_JSONL> --paths-variant-jsonl <PATHS_VARIANT_JSONL> --path-out-rocksdb <PATH_OUT_ROCKSDB>

Options:
      --path-per-impact-jsonl <PATH_PER_IMPACT_JSONL>
          Path to input per-impact JSONL file(s)
  -v, --verbose...
          Increase logging verbosity
      --path-per-frequency-jsonl <PATH_PER_FREQUENCY_JSONL>
          Path to input per-frequency JSONL file(s)
  -q, --quiet...
          Decrease logging verbosity
      --paths-variant-jsonl <PATHS_VARIANT_JSONL>
          Paths to variant JSONL files
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to output RocksDB directory
      --cf-name <CF_NAME>
          Name of the column family to import into [default: clinvar-genes]
      --path-wal-dir <PATH_WAL_DIR>
          Optional path to RocksDB WAL directory
  -h, --help
          Print help
```

## annonars_clinvar-genes_query

### Tool Description
"query" sub command: Query ClinVar per-gene data (per-impact and per-frequency counts and variants) in a RocksDB database built by import.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"query" sub command

Usage: annonars clinvar-genes query [OPTIONS] --path-rocksdb <PATH_ROCKSDB> --hgnc-id <HGNC_ID>

Options:
      --path-rocksdb <PATH_ROCKSDB>  Path to RocksDB directory with data
  -v, --verbose...                   Increase logging verbosity
      --cf-name <CF_NAME>            Name of the column family to import into [default: clinvar-genes]
  -q, --quiet...                     Decrease logging verbosity
      --out-file <OUT_FILE>          Output file (default is stdout == "-") [default: -]
      --out-format <OUT_FORMAT>      Output format [default: jsonl] [possible values: jsonl]
      --hgnc-id <HGNC_ID>            HGNC gene identifier to query for
  -h, --help                         Print help (see more with '--help')
```

## annonars_clinvar-minimal_import

### Tool Description
"import" sub command: Import minimal ClinVar sequence variant data into a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"import" sub command

Usage: annonars clinvar-minimal import [OPTIONS] --genome-release <GENOME_RELEASE> --path-in-jsonl <PATH_IN_JSONL> --path-out-rocksdb <PATH_OUT_ROCKSDB>

Options:
      --genome-release <GENOME_RELEASE>
          Genome build to use in the build [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --path-in-jsonl <PATH_IN_JSONL>
          Path to input JSONL file(s)
  -q, --quiet...
          Decrease logging verbosity
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to output RocksDB directory
      --cf-name <CF_NAME>
          Name of the column family to import into [default: clinvar]
      --cf-name-by-accession <CF_NAME_BY_ACCESSION>
          Name of the column family for accession lookup [default: clinvar_by_accession]
      --path-wal-dir <PATH_WAL_DIR>
          Optional path to RocksDB WAL directory
  -h, --help
          Print help (see more with '--help')
```

## annonars_clinvar-minimal_query

### Tool Description
"query" sub command: Query minimal ClinVar sequence variant data in a RocksDB database built by import.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"query" sub command

Usage: annonars clinvar-minimal query [OPTIONS] --path-rocksdb <PATH_ROCKSDB> <--variant <VARIANT>|--position <POSITION>|--range <RANGE>|--accession <ACCESSION>|--all>

Options:
      --path-rocksdb <PATH_ROCKSDB>
          Path to RocksDB directory with data
  -v, --verbose...
          Increase logging verbosity
      --cf-name <CF_NAME>
          Name of the column family to import into [default: clinvar]
  -q, --quiet...
          Decrease logging verbosity
      --cf-name-by-accession <CF_NAME_BY_ACCESSION>
          Name of the column family for accession lookup [default: clinvar_by_accession]
      --out-file <OUT_FILE>
          Output file (default is stdout == "-") [default: -]
      --out-format <OUT_FORMAT>
          Output format [default: jsonl] [possible values: jsonl]
      --variant <VARIANT>
          Specify variant to query for
      --position <POSITION>
          Specify position to query for
      --range <RANGE>
          Specify range to query for
      --accession <ACCESSION>
          Specify accession to query for
      --all
          Query for all variants
  -h, --help
          Print help (see more with '--help')
```

## annonars_clinvar-sv_import

### Tool Description
"import" sub command: Import ClinVar structural variant data into a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"import" sub command

Usage: annonars clinvar-sv import [OPTIONS] --genome-release <GENOME_RELEASE> --path-in-jsonl <PATH_IN_JSONL> --path-out-rocksdb <PATH_OUT_ROCKSDB>

Options:
      --genome-release <GENOME_RELEASE>
          Genome build to use in the build [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --path-in-jsonl <PATH_IN_JSONL>
          Path to input JSONL file(s)
  -q, --quiet...
          Decrease logging verbosity
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to output RocksDB directory
      --min-var-size <MIN_VAR_SIZE>
          Minimal VCF REF/ALT length to consider as SV [default: 50]
      --cf-name <CF_NAME>
          Name of the column family to import into [default: clinvar_sv]
      --cf-name-by-rcv <CF_NAME_BY_RCV>
          Mapping from ClinVar RCV to ClinVar VCV [default: clinvar_sv_by_rcv]
      --path-wal-dir <PATH_WAL_DIR>
          Optional path to RocksDB WAL directory
  -h, --help
          Print help (see more with '--help')
```

## annonars_clinvar-sv_query

### Tool Description
"query" sub command: Query ClinVar structural variant data in a RocksDB database built by import.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"query" sub command

Usage: annonars clinvar-sv query [OPTIONS] --path-rocksdb <PATH_ROCKSDB> <--accession <ACCESSION>|--all|--range <RANGE>>

Options:
      --path-rocksdb <PATH_ROCKSDB>
          Path to RocksDB directory with data
  -v, --verbose...
          Increase logging verbosity
      --cf-name <CF_NAME>
          Name of the column family to import into [default: clinvar_sv]
  -q, --quiet...
          Decrease logging verbosity
      --cf-name-by-rcv <CF_NAME_BY_RCV>
          Mapping from ClinVar RCV to ClinVar VCV [default: clinvar_sv_by_rcv]
      --out-file <OUT_FILE>
          Output file (default is stdout == "-") [default: -]
      --out-format <OUT_FORMAT>
          Output format [default: jsonl] [possible values: jsonl]
      --accession <ACCESSION>
          Specify accession to query for
      --all
          Query for all variants
      --range <RANGE>
          Specify range to query for
  -h, --help
          Print help (see more with '--help')
```

## annonars_cons_import

### Tool Description
"import" sub command: Import UCSC multiz conservation data into a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"import" sub command

Usage: annonars cons import [OPTIONS] --genome-release <GENOME_RELEASE> --path-in-tsv <PATH_IN_TSV> --path-out-rocksdb <PATH_OUT_ROCKSDB>

Options:
      --genome-release <GENOME_RELEASE>
          Genome build to use in the build [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --path-in-tsv <PATH_IN_TSV>
          Path to input TSV file(s)
  -q, --quiet...
          Decrease logging verbosity
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to output RocksDB directory
      --cf-name <CF_NAME>
          Name of the column family to import into [default: ucsc_conservation]
      --path-wal-dir <PATH_WAL_DIR>
          Optional path to RocksDB WAL directory
  -h, --help
          Print help (see more with '--help')
```

## annonars_cons_query

### Tool Description
"query" sub command: Query UCSC multiz conservation data in a RocksDB database built by import.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"query" sub command

Usage: annonars cons query [OPTIONS] --path-rocksdb <PATH_ROCKSDB> <--range <RANGE>|--all>

Options:
      --path-rocksdb <PATH_ROCKSDB>  Path to RocksDB directory with data
  -v, --verbose...                   Increase logging verbosity
      --cf-name <CF_NAME>            Name of the column family to import into [default: ucsc_conservation]
  -q, --quiet...                     Decrease logging verbosity
      --out-file <OUT_FILE>          Output file (default is stdout == "-") [default: -]
      --out-format <OUT_FORMAT>      Output format [default: jsonl] [possible values: jsonl]
      --range <RANGE>                Specify range to query for
      --all                          Query for all variants
      --hgnc-id <HGNC_ID>            Optional HGNC gene identifier to limit query to
  -h, --help                         Print help (see more with '--help')
```

## annonars_db-utils_copy

### Tool Description
"copy" sub command: Copy all data, or the data in a position, range or BED regions, from one RocksDB database to a new one.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"copy" sub command

Usage: annonars db-utils copy [OPTIONS] --path-in <PATH_IN> --path-out <PATH_OUT> <--position <POSITION>|--range <RANGE>|--path-beds <PATH_BEDS>|--all>

Options:
      --path-in <PATH_IN>            Path to input directory
  -v, --verbose...                   Increase logging verbosity
      --path-out <PATH_OUT>          Path to output directory
  -q, --quiet...                     Decrease logging verbosity
      --position <POSITION>          Specify position to query for
      --range <RANGE>                Specify range to query for
      --path-beds <PATH_BEDS>        Specify path(s) to BED files to read from
      --all                          Query for all variants
      --skip-cfs <SKIP_CFS>          Names of column families to skip contents for
      --path-wal-dir <PATH_WAL_DIR>  Optional path to RocksDB WAL directory
  -h, --help                         Print help
```

## annonars_db-utils_dump-meta

### Tool Description
"dump-meta" sub command: Print the metadata of a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"dump-meta" sub command

Usage: annonars db-utils dump-meta [OPTIONS] --path-in <PATH_IN>

Options:
      --path-in <PATH_IN>  Path to input directory
  -v, --verbose...         Increase logging verbosity
  -q, --quiet...           Decrease logging verbosity
  -h, --help               Print help
```

## annonars_dbsnp_import

### Tool Description
"import" sub command: Import dbSNP data into a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"import" sub command

Usage: annonars dbsnp import [OPTIONS] --genome-release <GENOME_RELEASE> --path-in-vcf <PATH_IN_VCF> --path-out-rocksdb <PATH_OUT_ROCKSDB>

Options:
      --genome-release <GENOME_RELEASE>
          Genome build to use in the build [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --path-in-vcf <PATH_IN_VCF>
          Path to input VCF file(s)
  -q, --quiet...
          Decrease logging verbosity
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to output RocksDB directory
      --tbi-window-size <TBI_WINDOW_SIZE>
          Windows size for TBI-based parallel import [default: 100000]
      --cf-name <CF_NAME>
          Name of the column family to import into [default: dbsnp_data]
      --cf-name-by-rsid <CF_NAME_BY_RSID>
          Name of the column family for RSID lookup [default: dbsnp_by_rsid]
      --path-wal-dir <PATH_WAL_DIR>
          Optional path to RocksDB WAL directory
  -h, --help
          Print help (see more with '--help')
```

## annonars_dbsnp_query

### Tool Description
"query" sub command: Query dbSNP data in a RocksDB database built by import.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"query" sub command

Usage: annonars dbsnp query [OPTIONS] --path-rocksdb <PATH_ROCKSDB> <--variant <VARIANT>|--position <POSITION>|--range <RANGE>|--accession <ACCESSION>|--all>

Options:
      --path-rocksdb <PATH_ROCKSDB>
          Path to RocksDB directory with data
  -v, --verbose...
          Increase logging verbosity
      --cf-name <CF_NAME>
          Name of the column family to import into [default: dbsnp_data]
  -q, --quiet...
          Decrease logging verbosity
      --cf-name-by-rsid <CF_NAME_BY_RSID>
          Name of the column family for RSID lookup [default: dbsnp_by_rsid]
      --out-file <OUT_FILE>
          Output file (default is stdout == "-") [default: -]
      --out-format <OUT_FORMAT>
          Output format [default: jsonl] [possible values: jsonl]
      --variant <VARIANT>
          Specify variant to query for
      --position <POSITION>
          Specify position to query for
      --range <RANGE>
          Specify range to query for
      --accession <ACCESSION>
          Specify accession to query for
      --all
          Query for all variants
  -h, --help
          Print help (see more with '--help')
```

## annonars_freqs_import

### Tool Description
"import" sub command: Import merged gnomAD and HelixMtDb frequency data into a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"import" sub command

Usage: annonars freqs import [OPTIONS] --genome-release <GENOME_RELEASE> --path-out-rocksdb <PATH_OUT_ROCKSDB> --gnomad-genomes-version <GNOMAD_GENOMES_VERSION> --gnomad-exomes-version <GNOMAD_EXOMES_VERSION> --gnomad-mtdna-version <GNOMAD_MTDNA_VERSION> --helixmtdb-version <HELIXMTDB_VERSION>

Options:
      --genome-release <GENOME_RELEASE>
          Genome build to use in the build [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to the output database to build
  -q, --quiet...
          Decrease logging verbosity
      --path-gnomad-exomes-auto <PATH_GNOMAD_EXOMES_AUTO>
          Path(s) to the autosomal gnomAD exomes VCF file(s)
      --path-gnomad-genomes-auto <PATH_GNOMAD_GENOMES_AUTO>
          Path(s) to the autosomal gnomAD genomes VCF file(s)
      --path-gnomad-exomes-xy <PATH_GNOMAD_EXOMES_XY>
          Path(s) to the gonosomal gnomAD exomes VCF file(s)
      --path-gnomad-genomes-xy <PATH_GNOMAD_GENOMES_XY>
          Path(s) to the gonosomal gnomAD genomes VCF file(s)
      --path-gnomad-mtdna <PATH_GNOMAD_MTDNA>
          Path(s) to the gnomAD mtDNA VCF file(s)
      --path-helixmtdb <PATH_HELIXMTDB>
          Path(s) to the HelixMtDb TSV file
      --path-wal-dir <PATH_WAL_DIR>
          Optional path to WAL directory
      --tbi-window-size <TBI_WINDOW_SIZE>
          Windows size for TBI-based parallel import [default: 100000]
      --gnomad-genomes-version <GNOMAD_GENOMES_VERSION>
          Version of gnomAD genomes
      --gnomad-exomes-version <GNOMAD_EXOMES_VERSION>
          Version of gnomAD exomes
      --gnomad-mtdna-version <GNOMAD_MTDNA_VERSION>
          Version of gnomAD mtDNA
      --helixmtdb-version <HELIXMTDB_VERSION>
          Version of HelixMtDb
  -h, --help
          Print help (see more with '--help')
```

## annonars_freqs_query

### Tool Description
"query" sub command: Query merged gnomAD and HelixMtDb frequency data in a RocksDB database built by import.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"query" sub command

Usage: annonars freqs query [OPTIONS] --path-rocksdb <PATH_ROCKSDB> --variant <VARIANT>

Options:
      --path-rocksdb <PATH_ROCKSDB>  Path to RocksDB directory with data
  -v, --verbose...                   Increase logging verbosity
      --path-output <PATH_OUTPUT>    Path to output file, use "-" for stdout [default: -]
  -q, --quiet...                     Decrease logging verbosity
      --out-format <OUT_FORMAT>      Output format [default: jsonl] [possible values: jsonl]
      --variant <VARIANT>            Variant to query for
  -h, --help                         Print help (see more with '--help')
```

## annonars_functional_import

### Tool Description
"import" sub command: Import RefSeq functional element data into a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"import" sub command

Usage: annonars functional import [OPTIONS] --genome-release <GENOME_RELEASE> --path-in-gff <PATH_IN_GFF> --path-out-rocksdb <PATH_OUT_ROCKSDB>

Options:
      --genome-release <GENOME_RELEASE>
          Genome build to use in the build [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --path-in-gff <PATH_IN_GFF>
          Path to input GFF file(s)
  -q, --quiet...
          Decrease logging verbosity
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to output RocksDB directory
      --cf-name <CF_NAME>
          Name of the column family to import into [default: functional]
      --path-wal-dir <PATH_WAL_DIR>
          Optional path to RocksDB WAL directory
  -h, --help
          Print help (see more with '--help')
```

## annonars_functional_query

### Tool Description
"query" sub command: Query RefSeq functional element data in a RocksDB database built by import.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"query" sub command

Usage: annonars functional query [OPTIONS] --path-rocksdb <PATH_ROCKSDB> <--accession <ACCESSION>|--all|--range <RANGE>>

Options:
      --path-rocksdb <PATH_ROCKSDB>  Path to RocksDB directory with data
  -v, --verbose...                   Increase logging verbosity
      --cf-name <CF_NAME>            Name of the column family to import into [default: functional]
  -q, --quiet...                     Decrease logging verbosity
      --out-file <OUT_FILE>          Output file (default is stdout == "-") [default: -]
      --out-format <OUT_FORMAT>      Output format [default: jsonl] [possible values: jsonl]
      --accession <ACCESSION>        Specify accession to query for
      --all                          Query for all variants
      --range <RANGE>                Specify range to query for
  -h, --help                         Print help (see more with '--help')
```

## annonars_gene_import

### Tool Description
"import" sub command: Import gene information data (HGNC, ClinGen, OMIM, gnomAD constraints and more) into a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"import" sub command

Usage: annonars gene import [OPTIONS] --path-in-acmg <PATH_IN_ACMG> --path-in-clingen-37 <PATH_IN_CLINGEN_37> --path-in-clingen-38 <PATH_IN_CLINGEN_38> --path-in-gnomad-constraints <PATH_IN_GNOMAD_CONSTRAINTS> --path-in-dbnsfp <PATH_IN_DBNSFP> --path-in-hgnc <PATH_IN_HGNC> --path-in-ncbi <PATH_IN_NCBI> --path-in-omim <PATH_IN_OMIM> --path-in-orpha <PATH_IN_ORPHA> --path-in-panelapp <PATH_IN_PANELAPP> --path-in-rcnv <PATH_IN_RCNV> --path-in-shet <PATH_IN_SHET> --path-in-gtex <PATH_IN_GTEX> --path-in-domino <PATH_IN_DOMINO> --path-in-decipher-hi <PATH_IN_DECIPHER_HI> --path-in-conditions <PATH_IN_CONDITIONS> --path-out-rocksdb <PATH_OUT_ROCKSDB>

Options:
      --path-in-acmg <PATH_IN_ACMG>
          Path to the TSV file with ACMG secondary findings list
  -v, --verbose...
          Increase logging verbosity
      --path-in-clingen-37 <PATH_IN_CLINGEN_37>
          Path to the CSV file with ClinGen curations for GRCh37
  -q, --quiet...
          Decrease logging verbosity
      --path-in-clingen-38 <PATH_IN_CLINGEN_38>
          Path to the CSV file with ClinGen curations for GRCh37
      --path-in-gnomad-constraints <PATH_IN_GNOMAD_CONSTRAINTS>
          Path to the TSV file with gnomAD gene constraints
      --path-in-dbnsfp <PATH_IN_DBNSFP>
          Path to the TSV file with dbNSFP gene information
      --path-in-hgnc <PATH_IN_HGNC>
          Path to the JSONL file with HGNC information
      --path-in-ncbi <PATH_IN_NCBI>
          Path to the JSONL file with NCBI information
      --path-in-omim <PATH_IN_OMIM>
          Path to the TSV file with OMIM disease information
      --path-in-orpha <PATH_IN_ORPHA>
          Path to the TSV file with ORPHA disease information
      --path-in-panelapp <PATH_IN_PANELAPP>
          Path to the JSONL file with PanelApp disease information
      --path-in-rcnv <PATH_IN_RCNV>
          Path to the TSV file with rCNV information
      --path-in-shet <PATH_IN_SHET>
          Path to the TSV file with sHet information
      --path-in-gtex <PATH_IN_GTEX>
          Path to the JSONL file with the GTEx informatino
      --path-in-domino <PATH_IN_DOMINO>
          Path to the DOMINO TSV file
      --path-in-decipher-hi <PATH_IN_DECIPHER_HI>
          Path to the DECIPHER HI file
      --path-in-conditions <PATH_IN_CONDITIONS>
          Path to the conditions HGNC file
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to output RocksDB
  -h, --help
          Print help
  -V, --version
          Print version
```

## annonars_gene_query

### Tool Description
"query" sub command: Query gene information data (HGNC, ClinGen, OMIM, gnomAD constraints and more) in a RocksDB database built by import.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"query" sub command

Usage: annonars gene query [OPTIONS] --path-rocksdb <PATH_ROCKSDB> --hgnc-id <HGNC_ID>

Options:
      --path-rocksdb <PATH_ROCKSDB>  Path to RocksDB directory with data
  -v, --verbose...                   Increase logging verbosity
      --cf-name <CF_NAME>            Name of the column family to import into [default: genes]
  -q, --quiet...                     Decrease logging verbosity
      --out-file <OUT_FILE>          Output file (default is stdout == "-") [default: -]
      --out-format <OUT_FORMAT>      Output format [default: jsonl] [possible values: jsonl]
      --hgnc-id <HGNC_ID>            HGNC gene identifier to query for
  -h, --help                         Print help (see more with '--help')
```

## annonars_gnomad-mtdna_import

### Tool Description
"import" sub command: Import gnomAD mtDNA data into a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"import" sub command

Usage: annonars gnomad-mtdna import [OPTIONS] --genome-release <GENOME_RELEASE> --path-in-vcf <PATH_IN_VCF> --path-out-rocksdb <PATH_OUT_ROCKSDB> --gnomad-version <GNOMAD_VERSION>

Options:
      --genome-release <GENOME_RELEASE>
          Genome build to use in the build [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --path-in-vcf <PATH_IN_VCF>
          Path to input VCF file(s)
  -q, --quiet...
          Decrease logging verbosity
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to output RocksDB directory
      --gnomad-version <GNOMAD_VERSION>
          The gnomAD version to write out
      --tbi-window-size <TBI_WINDOW_SIZE>
          Windows size for TBI-based parallel import [default: 100000]
      --cf-name <CF_NAME>
          Name of the column family to import into [default: gnomad_mtdna_data]
      --path-wal-dir <PATH_WAL_DIR>
          Optional path to RocksDB WAL directory
      --import-fields-json <IMPORT_FIELDS_JSON>
          JSON formatted configuration of which fields to import from gnomAD-mtDNA.  If not specified, the default fields are configured
  -h, --help
          Print help (see more with '--help')
```

## annonars_gnomad-mtdna_query

### Tool Description
"query" sub command: Query gnomAD mtDNA data in a RocksDB database built by import.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"query" sub command

Usage: annonars gnomad-mtdna query [OPTIONS] --path-rocksdb <PATH_ROCKSDB> <--variant <VARIANT>|--position <POSITION>|--range <RANGE>|--accession <ACCESSION>|--all>

Options:
      --path-rocksdb <PATH_ROCKSDB>  Path to RocksDB directory with data
  -v, --verbose...                   Increase logging verbosity
      --cf-name <CF_NAME>            Name of the column family to import into [default: gnomad_mtdna_data]
  -q, --quiet...                     Decrease logging verbosity
      --out-file <OUT_FILE>          Output file (default is stdout == "-") [default: -]
      --out-format <OUT_FORMAT>      Output format [default: jsonl] [possible values: jsonl]
      --variant <VARIANT>            Specify variant to query for
      --position <POSITION>          Specify position to query for
      --range <RANGE>                Specify range to query for
      --accession <ACCESSION>        Specify accession to query for
      --all                          Query for all variants
  -h, --help                         Print help (see more with '--help')
```

## annonars_gnomad-nuclear_import

### Tool Description
"import" sub command: Import gnomAD nuclear exomes or genomes data into a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"import" sub command

Usage: annonars gnomad-nuclear import [OPTIONS] --path-in-vcf <PATH_IN_VCF> --path-out-rocksdb <PATH_OUT_ROCKSDB> --gnomad-kind <GNOMAD_KIND> --gnomad-version <GNOMAD_VERSION> --genome-release <GENOME_RELEASE>

Options:
      --path-in-vcf <PATH_IN_VCF>
          Path to input VCF file(s)
  -v, --verbose...
          Increase logging verbosity
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to output RocksDB directory
  -q, --quiet...
          Decrease logging verbosity
      --gnomad-kind <GNOMAD_KIND>
          Exomes or genomes [possible values: exomes, genomes]
      --gnomad-version <GNOMAD_VERSION>
          The data version to write out
      --genome-release <GENOME_RELEASE>
          Genome build to use in the build [possible values: grch37, grch38]
      --tbi-window-size <TBI_WINDOW_SIZE>
          Windows size for TBI-based parallel import [default: 100000]
      --cf-name <CF_NAME>
          Name of the column family to import into [default: gnomad_nuclear_data]
      --path-wal-dir <PATH_WAL_DIR>
          Optional path to RocksDB WAL directory
      --import-fields-json <IMPORT_FIELDS_JSON>
          JSON formatted configuration of which fields to import from gnomAD-mtDNA.  If not specified, the default fields are configured
  -h, --help
          Print help (see more with '--help')
```

## annonars_gnomad-nuclear_query

### Tool Description
"query" sub command: Query gnomAD nuclear exomes or genomes data in a RocksDB database built by import.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"query" sub command

Usage: annonars gnomad-nuclear query [OPTIONS] --path-rocksdb <PATH_ROCKSDB> <--variant <VARIANT>|--position <POSITION>|--range <RANGE>|--accession <ACCESSION>|--all>

Options:
      --path-rocksdb <PATH_ROCKSDB>  Path to RocksDB directory with data
  -v, --verbose...                   Increase logging verbosity
      --cf-name <CF_NAME>            Name of the column family to import into [default: gnomad_nuclear_data]
  -q, --quiet...                     Decrease logging verbosity
      --out-file <OUT_FILE>          Output file (default is stdout == "-") [default: -]
      --out-format <OUT_FORMAT>      Output format [default: jsonl] [possible values: jsonl]
      --variant <VARIANT>            Specify variant to query for
      --position <POSITION>          Specify position to query for
      --range <RANGE>                Specify range to query for
      --accession <ACCESSION>        Specify accession to query for
      --all                          Query for all variants
  -h, --help                         Print help (see more with '--help')
```

## annonars_gnomad-sv_import

### Tool Description
"import" sub command: Import gnomAD structural variant data into a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"import" sub command

Usage: annonars gnomad-sv import [OPTIONS] --path-in-vcf <PATH_IN_VCF> --path-out-rocksdb <PATH_OUT_ROCKSDB> --gnomad-kind <GNOMAD_KIND> --gnomad-version <GNOMAD_VERSION> --genome-release <GENOME_RELEASE>

Options:
      --path-in-vcf <PATH_IN_VCF>
          Path to input VCF file(s) -- or TSV in case of ExAC
  -v, --verbose...
          Increase logging verbosity
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to output RocksDB directory
  -q, --quiet...
          Decrease logging verbosity
      --gnomad-kind <GNOMAD_KIND>
          Exomes or genomes [possible values: exomes, genomes]
      --gnomad-version <GNOMAD_VERSION>
          The data version to write out
      --genome-release <GENOME_RELEASE>
          Genome build to use in the build [possible values: grch37, grch38]
      --cf-name <CF_NAME>
          Data column family to import into [default: gnomad_sv]
      --path-wal-dir <PATH_WAL_DIR>
          Optional path to RocksDB WAL directory
  -h, --help
          Print help (see more with '--help')
```

## annonars_gnomad-sv_query

### Tool Description
"query" sub command: Query gnomAD structural variant data in a RocksDB database built by import.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"query" sub command

Usage: annonars gnomad-sv query [OPTIONS] --path-rocksdb <PATH_ROCKSDB> <--all|--accession <ACCESSION>|--range <RANGE>>

Options:
      --path-rocksdb <PATH_ROCKSDB>  Path to RocksDB directory with data
  -v, --verbose...                   Increase logging verbosity
      --cf-name <CF_NAME>            Name of the column family to import into [default: gnomad_sv]
  -q, --quiet...                     Decrease logging verbosity
      --out-file <OUT_FILE>          Output file (default is stdout == "-") [default: -]
      --out-format <OUT_FORMAT>      Output format [default: jsonl] [possible values: jsonl]
      --all                          Query for all variants
      --accession <ACCESSION>        Query for variant with a specicic accession
      --range <RANGE>                Specify range to query for
  -h, --help                         Print help (see more with '--help')
```

## annonars_helixmtdb_import

### Tool Description
"import" sub command: Import HelixMtDb data into a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"import" sub command

Usage: annonars helixmtdb import [OPTIONS] --genome-release <GENOME_RELEASE> --path-in-vcf <PATH_IN_VCF> --path-out-rocksdb <PATH_OUT_ROCKSDB>

Options:
      --genome-release <GENOME_RELEASE>
          Genome build to use in the build [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --path-in-vcf <PATH_IN_VCF>
          Path to input VCF file(s)
  -q, --quiet...
          Decrease logging verbosity
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to output RocksDB directory
      --tbi-window-size <TBI_WINDOW_SIZE>
          Windows size for TBI-based parallel import [default: 100000]
      --cf-name <CF_NAME>
          Name of the column family to import into [default: helixmtdb_data]
      --path-wal-dir <PATH_WAL_DIR>
          Optional path to RocksDB WAL directory
  -h, --help
          Print help (see more with '--help')
```

## annonars_helixmtdb_query

### Tool Description
"query" sub command: Query HelixMtDb data in a RocksDB database built by import.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"query" sub command

Usage: annonars helixmtdb query [OPTIONS] --path-rocksdb <PATH_ROCKSDB> <--variant <VARIANT>|--position <POSITION>|--range <RANGE>|--accession <ACCESSION>|--all>

Options:
      --path-rocksdb <PATH_ROCKSDB>  Path to RocksDB directory with data
  -v, --verbose...                   Increase logging verbosity
      --cf-name <CF_NAME>            Name of the column family to import into [default: helixmtdb_data]
  -q, --quiet...                     Decrease logging verbosity
      --out-file <OUT_FILE>          Output file (default is stdout == "-") [default: -]
      --out-format <OUT_FORMAT>      Output format [default: jsonl] [possible values: jsonl]
      --variant <VARIANT>            Specify variant to query for
      --position <POSITION>          Specify position to query for
      --range <RANGE>                Specify range to query for
      --accession <ACCESSION>        Specify accession to query for
      --all                          Query for all variants
  -h, --help                         Print help (see more with '--help')
```

## annonars_regions_import

### Tool Description
"import" sub command: Import ClinGen region curation data into a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"import" sub command

Usage: annonars regions import [OPTIONS] --genome-release <GENOME_RELEASE> --path-in-clingen <PATH_IN_CLINGEN> --path-out-rocksdb <PATH_OUT_ROCKSDB>

Options:
      --genome-release <GENOME_RELEASE>
          Genome build to use in the build [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --path-in-clingen <PATH_IN_CLINGEN>
          Path to ClinGen region annotation file
  -q, --quiet...
          Decrease logging verbosity
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to output RocksDB directory
      --cf-name <CF_NAME>
          Name of the column family to import into [default: regions]
      --path-wal-dir <PATH_WAL_DIR>
          Optional path to RocksDB WAL directory
  -h, --help
          Print help (see more with '--help')
```

## annonars_regions_query

### Tool Description
"query" sub command: Query ClinGen region curation data in a RocksDB database built by import.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"query" sub command

Usage: annonars regions query [OPTIONS] --path-rocksdb <PATH_ROCKSDB> <--all|--accession <ACCESSION>|--range <RANGE>>

Options:
      --path-rocksdb <PATH_ROCKSDB>  Path to RocksDB directory with data
  -v, --verbose...                   Increase logging verbosity
      --cf-name <CF_NAME>            Name of the column family to import into [default: regions]
  -q, --quiet...                     Decrease logging verbosity
      --out-file <OUT_FILE>          Output file (default is stdout == "-") [default: -]
      --out-format <OUT_FORMAT>      Output format [default: jsonl] [possible values: jsonl]
      --all                          Query for all variants
      --accession <ACCESSION>        Query for variant with a specicic accession
      --range <RANGE>                Specify range to query for
  -h, --help                         Print help (see more with '--help')
```

## annonars_server_schema

### Tool Description
Dump the schema of the annonars REST API server (OpenAPI YAML).

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
Dump the schema

Usage: annonars server schema [OPTIONS]

Options:
      --output-file <OUTPUT_FILE>  Path to the output file.  Use stdout if missing
  -v, --verbose...                 Increase logging verbosity
  -q, --quiet...                   Decrease logging verbosity
  -h, --help                       Print help
  -V, --version                    Print version
```

## annonars_tsv_import

### Tool Description
"import" sub command: Import generic variant TSV data into a RocksDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"import" sub command

Usage: annonars tsv import [OPTIONS] --genome-release <GENOME_RELEASE> --path-in-tsv <PATH_IN_TSV> --path-out-rocksdb <PATH_OUT_ROCKSDB> --db-name <DB_NAME> --db-version <DB_VERSION> --col-chrom <COL_CHROM> --col-start <COL_START> --col-ref <COL_REF> --col-alt <COL_ALT>

Options:
      --genome-release <GENOME_RELEASE>
          Genome build to use in the build [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --path-in-tsv <PATH_IN_TSV>
          Path to input TSV file(s)
  -q, --quiet...
          Decrease logging verbosity
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to output RocksDB directory
      --path-schema-json <PATH_SCHEMA_JSON>
          Optional path to schema dump in JSON format to start schema inference with
      --db-name <DB_NAME>
          Name of database to write to metadata
      --db-version <DB_VERSION>
          Version of database to write to metadata
      --inference-row-count <INFERENCE_ROW_COUNT>
          Number of rows for schema inference [default: 1000]
      --skip-row-count <SKIP_ROW_COUNT>
          Number of rows to skip [default: 0]
      --tbi-window-size <TBI_WINDOW_SIZE>
          Windows size for TBI-based parallel import [default: 100000]
      --cf-name <CF_NAME>
          Name of the column family to import into [default: tsv_data]
      --path-wal-dir <PATH_WAL_DIR>
          Optional path to RocksDB WAL directory
      --col-chrom <COL_CHROM>
          Name of colum containing the chromosome
      --col-start <COL_START>
          Name of colum containing the 1-based start position
      --col-ref <COL_REF>
          Name of colum containing the reference allele
      --col-alt <COL_ALT>
          Name of colum containing the alternate allele
      --null-values <NULL_VALUES>
          Values to be interpreted as null
      --add-default-null-values
          Whether to add the default set of NULL values (NA, ., -)
  -h, --help
          Print help (see more with '--help')
```

## annonars_tsv_query

### Tool Description
"query" sub command: Query generic variant TSV data in a RocksDB database built by import.

### Metadata
- **Docker Image**: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
- **Homepage**: https://github.com/bihealth/annona-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annonars/overview
- **Total Downloads**: 78.3K
- **Last updated**: 2025-10-28
- **GitHub**: https://github.com/bihealth/annona-rs
- **Stars**: N/A
### Original Help Text
```text
"query" sub command

Usage: annonars tsv query [OPTIONS] --path-rocksdb <PATH_ROCKSDB> <--variant <VARIANT>|--position <POSITION>|--range <RANGE>|--accession <ACCESSION>|--all>

Options:
      --path-rocksdb <PATH_ROCKSDB>  Path to RocksDB directory with data
  -v, --verbose...                   Increase logging verbosity
      --cf-name <CF_NAME>            Name of the column family to import into [default: tsv_data]
  -q, --quiet...                     Decrease logging verbosity
      --out-file <OUT_FILE>          Output file (default is stdout == "-") [default: -]
      --out-format <OUT_FORMAT>      Output format [default: jsonl] [possible values: jsonl]
      --variant <VARIANT>            Specify variant to query for
      --position <POSITION>          Specify position to query for
      --range <RANGE>                Specify range to query for
      --accession <ACCESSION>        Specify accession to query for
      --all                          Query for all variants
  -h, --help                         Print help (see more with '--help')
```

## Metadata
- **Skill**: generated
