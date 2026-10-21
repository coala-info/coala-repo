# rust-ncbitaxonomy CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rust-ncbitaxonomy_taxonomy_filter_fastq | Failed | tool bug: the ancestor check always returns true (ancestor 9606 keeps all classified reads, bacterial included), so the filter does not filter |
| rust-ncbitaxonomy_taxonomy_filter_refseq | Failed | tool bug: the ancestor check always returns true (an unrelated ancestor keeps all records), so the filter does not filter |
| rust-ncbitaxonomy_taxonomy_util_common_ancestor_distance | PASS |  |
| rust-ncbitaxonomy_taxonomy_util_get_id | PASS |  |
| rust-ncbitaxonomy_taxonomy_util_get_lineage | PASS |  |
| rust-ncbitaxonomy_taxonomy_util_get_name | PASS |  |
| rust-ncbitaxonomy_taxonomy_util_to_sqlite | PASS |  |

## rust-ncbitaxonomy_taxonomy_filter_refseq

### Tool Description
Filter NCBI RefSeq FASTA files by taxonomic lineage

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
- **Homepage**: https://github.com/pvanheus/ncbitaxonomy
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-ncbitaxonomy/overview
- **Validation**: PASS

### Original Help Text
```text
taxonomy_filter_refseq 1.0.7
Peter van Heusden <pvh@sanbi.axc.za>
Filter NCBI RefSeq FASTA files by taxonomic lineage

USAGE:
    taxonomy_filter_refseq [FLAGS] [OPTIONS] <INPUT_FASTA> <ANCESTOR_NAME> [OUTPUT_FASTA]

FLAGS:
        --no_curated      Don't accept curated RNAs and proteins (NM_, NR_ and NP_ accessions)
        --no_predicted    Don't accept computationally predicted RNAs and proteins (XM_, XR_ and XP_ accessions)
    -h, --help            Prints help information
    -V, --version         Prints version information

OPTIONS:
    -d, --db <TAXDB_URL>    URL for SQLite taxonomy database

ARGS:
    <INPUT_FASTA>      FASTA file with RefSeq sequences
    <ANCESTOR_NAME>    Name of ancestor to use as ancestor filter
    <OUTPUT_FASTA>     Output FASTA filename (or stdout if omitted)
```


## rust-ncbitaxonomy_taxonomy_filter_fastq

### Tool Description
Filter FASTQ files whose reads have been classified by Centrifuge or Kraken2, only retaining reads in taxa descending from given ancestor

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
- **Homepage**: https://github.com/pvanheus/ncbitaxonomy
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-ncbitaxonomy/overview
- **Validation**: PASS

### Original Help Text
```text
taxonomy_filter_fastq 1.0.7
Peter van Heusden <pvh@sanbi.axc.za>
Filter FASTQ files whose reads have been classified by Centrifuge or Kraken2, only retaining reads in taxa descending
from given ancestor

USAGE:
    taxonomy_filter_fastq [FLAGS] [OPTIONS] <INPUT_FASTQ>... --ancestor_taxid <ANCESTOR_ID> --tax_report_filename <TAXONOMY_REPORT_FILENAME> <--centrifuge|--kraken2>

FLAGS:
    -d, --output_dir    Directory to deposited filtered output files in
    -C, --centrifuge    Filter using report from Centrifuge
    -h, --help          Prints help information
    -K, --kraken2       Filter using report from Kraken2
    -V, --version       Prints version information

OPTIONS:
    -A, --ancestor_taxid <ANCESTOR_ID>                      Name of ancestor to use as ancestor filter
    -d, --db <TAXDB_URL>                                    URL for SQLite taxonomy database
    -F, --tax_report_filename <TAXONOMY_REPORT_FILENAME>    Output from Kraken2 (default) or Centrifuge

ARGS:
    <INPUT_FASTQ>...    FASTA file with RefSeq sequences
```


## rust-ncbitaxonomy_taxonomy_util_get_id

### Tool Description
find taxonomy ID for name

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
- **Homepage**: https://github.com/pvanheus/ncbitaxonomy
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-ncbitaxonomy/overview
- **Validation**: PASS

### Original Help Text
```text
taxonomy_util-get_id 
find taxonomy ID for name

USAGE:
    taxonomy_util --db <TAXDB_URL> get_id <NAME>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

ARGS:
    <NAME>    Name of taxon
```

## rust-ncbitaxonomy_taxonomy_util_get_name

### Tool Description
find name for taxonomy ID

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
- **Homepage**: https://github.com/pvanheus/ncbitaxonomy
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-ncbitaxonomy/overview
- **Validation**: PASS

### Original Help Text
```text
taxonomy_util-get_name 
find name for taxonomy ID

USAGE:
    taxonomy_util --db <TAXDB_URL> get_name <ID>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

ARGS:
    <ID>    Taxonomy ID to look up
```

## rust-ncbitaxonomy_taxonomy_util_get_lineage

### Tool Description
get lineage for name

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
- **Homepage**: https://github.com/pvanheus/ncbitaxonomy
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-ncbitaxonomy/overview
- **Validation**: PASS

### Original Help Text
```text
taxonomy_util-get_lineage 
get lineage for name

USAGE:
    taxonomy_util --db <TAXDB_URL> get_lineage [FLAGS] [OPTIONS] <NAME>

FLAGS:
    -S, --show_names    Show taxon names, not just IDs
    -h, --help          Prints help information
    -V, --version       Prints version information

OPTIONS:
    -D, --delimiter <DELIMITER>    Delimiter for lineage string

ARGS:
    <NAME>    Name of taxon
```

## rust-ncbitaxonomy_taxonomy_util_common_ancestor_distance

### Tool Description
find the tree distance to the common ancestor between two taxa

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
- **Homepage**: https://github.com/pvanheus/ncbitaxonomy
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-ncbitaxonomy/overview
- **Validation**: PASS

### Original Help Text
```text
taxonomy_util-common_ancestor_distance 
find the tree distance to te common ancestor between two taxa

USAGE:
    taxonomy_util --db <TAXDB_URL> common_ancestor_distance [FLAGS] <NAME1> <NAME2>

FLAGS:
        --only_canonical    Only consider canonical taxonomic ranks
    -h, --help              Prints help information
    -V, --version           Prints version information

ARGS:
    <NAME1>    Name of first taxon
    <NAME2>    Name of second taxon
```

## rust-ncbitaxonomy_taxonomy_util_to_sqlite

### Tool Description
save taxonomy database loaded from files to SQLite database file

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
- **Homepage**: https://github.com/pvanheus/ncbitaxonomy
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-ncbitaxonomy/overview
- **Validation**: PASS

### Original Help Text
```text
taxonomy_util-to_sqlite 
save taxonomy database loaded from files to SQLite database file

USAGE:
    taxonomy_util --db <TAXDB_URL> to_sqlite [OPTIONS] <TAXONOMY_DIR>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -t, --tax_prefix <TAXONOMY_FILENAME_PREFIX>    String to prepend to names of nodes.dmp and names.dmp

ARGS:
    <TAXONOMY_DIR>    Directory containing the NCBI taxonomy nodes.dmp and names.dmp files
```

## Metadata
- **Skill**: generated
