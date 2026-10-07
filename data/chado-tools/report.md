# chado-tools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| chado-tools_admin_create | PASS | Tested against a PostgreSQL 11 server in Docker; the database was created. |
| chado-tools_admin_drop | PASS | Tested against a PostgreSQL 11 server in Docker; the CWL answers the y/n prompt with a default file, and the database was dropped. |
| chado-tools_admin_dump | PASS | Tested against a PostgreSQL 11 server in Docker; the archive (3.4 MB) was restored into a new database with all features. |
| chado-tools_admin_grant | PASS | Tested against a PostgreSQL 11 server in Docker; the role got privileges on 240 tables. |
| chado-tools_admin_restore | PASS | Tested against a PostgreSQL 11 server in Docker; the restored database holds the same organisms and 21 features. |
| chado-tools_admin_revoke | PASS | Tested against a PostgreSQL 11 server in Docker; the role has no table privileges left. |
| chado-tools_admin_setup | PASS | Tested against a PostgreSQL 11 server in Docker; the GMOD Chado 1.31 schema was downloaded and set up. |
| chado-tools_delete_organism | Failed | tool bug: deleting an organism that has features stops with a NOT NULL error on feature.organism_id; an organism without features is deleted fine. |
| chado-tools_execute_audit_backup | Not completed | Needs a database with the GeneDB audit schema (audit_backup.backup_proc), which the GMOD schema does not have. |
| chado-tools_export_fasta | PASS | Tested against a PostgreSQL 11 server in Docker; the contig sequence matches the imported FASTA. |
| chado-tools_export_gaf | PASS | Tested against a PostgreSQL 11 server in Docker; the exported GAF line matches the imported one. |
| chado-tools_export_gff | PASS | Tested against a PostgreSQL 11 server in Docker; the GFF3 and FASTA output match the features stored in the database. |
| chado-tools_extract_annotation_updates | Not completed | No GeneDB annotation history is in the test database, so the output was only a header and could not be checked. |
| chado-tools_extract_curator_comments | Not completed | No curator comments are in the test database, so the output was an empty list and could not be checked. |
| chado-tools_extract_cvterms | PASS | Tested against a PostgreSQL 11 server in Docker; the 2 terms of the imported test ontology were listed. |
| chado-tools_extract_gene_products | Not completed | The GFF3 test data has no products in the GeneDB format, so the output was only a header and could not be checked. |
| chado-tools_extract_organisms | PASS | Tested against a PostgreSQL 11 server in Docker; both inserted organisms were listed. |
| chado-tools_import_essentials | PASS | Tested against a PostgreSQL 11 server in Docker; the basic CV terms were loaded. |
| chado-tools_import_fasta | PASS | Tested against a PostgreSQL 11 server in Docker; the repo test FASTA contig was loaded and exported back unchanged. |
| chado-tools_import_gaf | PASS | Tested against a PostgreSQL 11 server in Docker; synthetic data: one GAF line for a real gene from the repo GFF3 was loaded and exported back unchanged. |
| chado-tools_import_gff | Failed | tool bug: on the repo test GFF3, CDS lines listed before their mRNA lose their Parent link (8 of 12 part_of links stored); a parent-first GFF3 loads all 12. |
| chado-tools_import_ontology | PASS | Tested against a PostgreSQL 11 server in Docker; the repo test OBO gave 2 terms, and SOFA 3.1 (with a default-namespace header line added) gave 300 terms; a part_of relationship term was added by SQL first. |
| chado-tools_insert_organism | PASS | Tested against a PostgreSQL 11 server in Docker; the organism and its taxon ID were listed back by extract organisms. |
| chado-tools_query | PASS | Tested against a PostgreSQL 11 server in Docker; feature counts (4 gene, 4 mRNA, 8 CDS, 4 polypeptide, 1 region) match the GFF3. |

## chado-tools_query

### Tool Description
query a CHADO database and export the result to a text file

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado query [-h] [-V] [-c CONFIG | -p] [-H] [-d DELIMITER]
                   [-o OUTPUT_FILE] [-F {csv,json}] (-f INPUT_FILE | -q QUERY)
                   dbname

query a CHADO database and export the result to a text file

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -H, --include_header  include header in CSV output (default: False)
  -d DELIMITER, --delimiter DELIMITER
                        Character delimiting fields in CSV output (default:
                        tab)
  -o OUTPUT_FILE, --output_file OUTPUT_FILE
                        file into which data are exported (default: stdout)
  -F {csv,json}, --format {csv,json}
                        format of the file (default: csv)
  -f INPUT_FILE, --input_file INPUT_FILE
                        file containing an SQL query
  -q QUERY, --query QUERY
                        SQL query
```

## chado-tools_extract_organisms

### Tool Description
list all organisms in the CHADO database

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado extract organisms [-h] [-V] [-c CONFIG | -p] [-H] [-d DELIMITER]
                               [-o OUTPUT_FILE] [-F {csv,json}]
                               [--public_only]
                               dbname

list all organisms in the CHADO database

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -H, --include_header  include header in CSV output (default: False)
  -d DELIMITER, --delimiter DELIMITER
                        Character delimiting fields in CSV output (default:
                        tab)
  -o OUTPUT_FILE, --output_file OUTPUT_FILE
                        file into which data are exported (default: stdout)
  -F {csv,json}, --format {csv,json}
                        format of the file (default: csv)
  --public_only         only extract public genomes (default: extract all)
```

## chado-tools_extract_cvterms

### Tool Description
list all CV terms in the CHADO database

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado extract cvterms [-h] [-V] [-c CONFIG | -p] [-H] [-d DELIMITER]
                             [-o OUTPUT_FILE] [-F {csv,json}]
                             [--vocabulary VOCABULARY] [--database DATABASE]
                             dbname

list all CV terms in the CHADO database

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -H, --include_header  include header in CSV output (default: False)
  -d DELIMITER, --delimiter DELIMITER
                        Character delimiting fields in CSV output (default:
                        tab)
  -o OUTPUT_FILE, --output_file OUTPUT_FILE
                        file into which data are exported (default: stdout)
  -F {csv,json}, --format {csv,json}
                        format of the file (default: csv)
  --vocabulary VOCABULARY
                        restrict to a vocabulary, e.g. 'relationship'
  --database DATABASE   restrict to a database, e.g. 'GO'
```

## chado-tools_extract_gene_products

### Tool Description
list all products of transcripts in the CHADO database

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado extract gene_products [-h] [-V] [-c CONFIG | -p] [-H]
                                   [-d DELIMITER] [-o OUTPUT_FILE]
                                   [-F {csv,json}] [-a ORGANISM]
                                   [--public_only]
                                   dbname

list all products of transcripts in the CHADO database

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -H, --include_header  include header in CSV output (default: False)
  -d DELIMITER, --delimiter DELIMITER
                        Character delimiting fields in CSV output (default:
                        tab)
  -o OUTPUT_FILE, --output_file OUTPUT_FILE
                        file into which data are exported (default: stdout)
  -F {csv,json}, --format {csv,json}
                        format of the file (default: csv)
  -a ORGANISM, --abbreviation ORGANISM
                        restrict to a certain organism, defined by its
                        abbreviation/short name (default: all)
  --public_only         restrict to public genomes (default: all)
```

## chado-tools_extract_annotation_updates

### Tool Description
list annotation updates in a CHADO database

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado extract annotation_updates [-h] [-V] [-c CONFIG | -p] [-H]
                                        [-d DELIMITER] [-o OUTPUT_FILE]
                                        [-F {csv,json}] [-a ORGANISM]
                                        --start_date START_DATE
                                        [--end_date END_DATE] [--public_only]
                                        dbname

list annotation updates in a CHADO database

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -H, --include_header  include header in CSV output (default: False)
  -d DELIMITER, --delimiter DELIMITER
                        Character delimiting fields in CSV output (default:
                        tab)
  -o OUTPUT_FILE, --output_file OUTPUT_FILE
                        file into which data are exported (default: stdout)
  -F {csv,json}, --format {csv,json}
                        format of the file (default: csv)
  -a ORGANISM, --abbreviation ORGANISM
                        restrict to a certain organism, defined by its
                        abbreviation/short name (default: all)
  --start_date START_DATE
                        date for maximum age of updates, format 'YYYYMMDD'
  --end_date END_DATE   date for minimum age of updates, format 'YYYYMMDD'
                        (default: today)
  --public_only         restrict to public genomes (default: all)
```

## chado-tools_extract_curator_comments

### Tool Description
list curator comments to genes and gene products in a CHADO database

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado extract curator_comments [-h] [-V] [-c CONFIG | -p] [-H]
                                      [-d DELIMITER] [-o OUTPUT_FILE]
                                      [-F {csv,json}] [-a ORGANISM]
                                      [--public_only]
                                      dbname

list curator comments to genes and gene products in a CHADO database

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -H, --include_header  include header in CSV output (default: False)
  -d DELIMITER, --delimiter DELIMITER
                        Character delimiting fields in CSV output (default:
                        tab)
  -o OUTPUT_FILE, --output_file OUTPUT_FILE
                        file into which data are exported (default: stdout)
  -F {csv,json}, --format {csv,json}
                        format of the file (default: csv)
  -a ORGANISM, --abbreviation ORGANISM
                        restrict to a certain organism, defined by its
                        abbreviation/short name (default: all)
  --public_only         restrict to public genomes (default: all)
```

## chado-tools_insert_organism

### Tool Description
insert an organism into the CHADO database

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado insert organism [-h] [-V] [-c CONFIG | -p] -g GENUS -s SPECIES
                             [-i INFRASPECIFIC_NAME] -a ABBREVIATION
                             [--common_name COMMON_NAME] [--comment COMMENT]
                             [--genome_version GENOME_VERSION]
                             [--taxon_id TAXON_ID] [--wikidata_id WIKIDATA_ID]
                             dbname

insert an organism into the CHADO database

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -g GENUS, --genus GENUS
                        genus of the organism
  -s SPECIES, --species SPECIES
                        species of the organism
  -i INFRASPECIFIC_NAME, --infraspecific_name INFRASPECIFIC_NAME
                        infraspecific name (strain) of the organism
  -a ABBREVIATION, --abbreviation ABBREVIATION
                        abbreviation/short name of the organism
  --common_name COMMON_NAME
                        common name of the organism (default: use
                        abbreviation, if provided)
  --comment COMMENT     comment
  --genome_version GENOME_VERSION
                        version number of the genome
  --taxon_id TAXON_ID   NCBI taxon ID
  --wikidata_id WIKIDATA_ID
                        ID of the organism on Wikidata
```

## chado-tools_delete_organism

### Tool Description
delete an organism from the CHADO database

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado delete organism [-h] [-V] [-c CONFIG | -p] -a ORGANISM dbname

delete an organism from the CHADO database

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -a ORGANISM, --abbreviation ORGANISM
                        abbreviation/short name of the organism
```

## chado-tools_import_essentials

### Tool Description
import basic terms into the CHADO database (for setup)

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado import essentials [-h] [-V] [-c CONFIG | -p] dbname

import basic terms into the CHADO database (for setup)

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
```

## chado-tools_import_ontology

### Tool Description
import an ontology into the CHADO database

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado import ontology [-h] [-V] [-c CONFIG | -p]
                             (-f INPUT_FILE | -u INPUT_URL) -A
                             DATABASE_AUTHORITY [-F {obo,owl}]
                             dbname

import an ontology into the CHADO database

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -f INPUT_FILE, --input_file INPUT_FILE
                        file containing CV terms
  -u INPUT_URL, --input_url INPUT_URL
                        URL to a file containing CV terms
  -A DATABASE_AUTHORITY, --database_authority DATABASE_AUTHORITY
                        database authority of the terms in the file, e.g. 'GO'
  -F {obo,owl}, --format {obo,owl}
                        format of the file (default: obo)
```

## chado-tools_import_fasta

### Tool Description
import sequences from a FASTA file into the CHADO database

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado import fasta [-h] [-V] [-c CONFIG | -p] -f INPUT_FILE -a ORGANISM
                          [-t {chromosome,supercontig,contig,region}]
                          dbname

import sequences from a FASTA file into the CHADO database

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -f INPUT_FILE, --input_file INPUT_FILE
                        FASTA input file
  -a ORGANISM, --abbreviation ORGANISM
                        abbreviation/short name of the organism
  -t {chromosome,supercontig,contig,region}, --sequence_type {chromosome,supercontig,contig,region}
                        type of the sequences (default: region)
```

## chado-tools_import_gff

### Tool Description
import genomic data from a GFF3 file into the CHADO database

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado import gff [-h] [-V] [-c CONFIG | -p] -f INPUT_FILE -a ORGANISM
                        [--fasta FASTA]
                        [-t {chromosome,supercontig,contig,region}]
                        [--fresh_load] [--force] [--full_genome]
                        [--full_attributes]
                        dbname

import genomic data from a GFF3 file into the CHADO database

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -f INPUT_FILE, --input_file INPUT_FILE
                        GFF3 input file
  -a ORGANISM, --abbreviation ORGANISM
                        abbreviation/short name of the organism
  --fasta FASTA         FASTA input file with sequences
  -t {chromosome,supercontig,contig,region}, --sequence_type {chromosome,supercontig,contig,region}
                        type of the FASTA sequences, if present (default:
                        region)
  --fresh_load          load a genome from scratch (default: load an update to
                        an existing genome)
  --force               in case of a fresh load, purge all existing features
                        of the organism
  --full_genome         in case of an update, mark features not present in the
                        input file as obsolete
  --full_attributes     in case of an update, delete feature attributes not
                        present in the input file
```

## chado-tools_import_gaf

### Tool Description
import gene annotation data from a GAF file into the CHADO database

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado import gaf [-h] [-V] [-c CONFIG | -p] -f INPUT_FILE -a ORGANISM
                        [-L {default,gene,transcript,protein}]
                        dbname

import gene annotation data from a GAF file into the CHADO database

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -f INPUT_FILE, --input_file INPUT_FILE
                        GFF3 input file
  -a ORGANISM, --abbreviation ORGANISM
                        abbreviation/short name of the organism
  -L {default,gene,transcript,protein}, --annotation_level {default,gene,transcript,protein}
                        level to which GO terms are related in the database
                        (default: same level as in the input file)
```

## chado-tools_export_fasta

### Tool Description
export genome/protein sequences from the CHADO database to a FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado export fasta [-h] [-V] [-c CONFIG | -p] -f OUTPUT_FILE -a
                          ORGANISM -t {contigs,genes,proteins} [-r RELEASE]
                          [--include_obsolete]
                          dbname

export genome/protein sequences from the CHADO database to a FASTA file

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -f OUTPUT_FILE, --output_file OUTPUT_FILE
                        FASTA output file
  -a ORGANISM, --abbreviation ORGANISM
                        abbreviation/short name of the organism
  -t {contigs,genes,proteins}, --sequence_type {contigs,genes,proteins}
                        type of the sequences to be exported
  -r RELEASE, --release RELEASE
                        name of the FASTA release
  --include_obsolete    export all features, including obsoletes
```

## chado-tools_export_gff

### Tool Description
export genomic data from the CHADO database to a GFF3 file

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado export gff [-h] [-V] [-c CONFIG | -p] -f OUTPUT_FILE -a ORGANISM
                        [--export_fasta] [--fasta_file FASTA_FILE]
                        [--include_obsolete]
                        dbname

export genomic data from the CHADO database to a GFF3 file

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -f OUTPUT_FILE, --output_file OUTPUT_FILE
                        GFF output file
  -a ORGANISM, --abbreviation ORGANISM
                        abbreviation/short name of the organism
  --export_fasta        export FASTA sequences along with annotations
  --fasta_file FASTA_FILE
                        FASTA output file with sequences (default: paste to
                        end of GFF file)
  --include_obsolete    export all features, including obsoletes
```

## chado-tools_export_gaf

### Tool Description
export gene annotation data from the CHADO database to a GAF file

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado export gaf [-h] [-V] [-c CONFIG | -p] -f OUTPUT_FILE -a ORGANISM
                        -A DATABASE_AUTHORITY
                        [-L {default,gene,transcript,protein}]
                        [--include_obsolete]
                        dbname

export gene annotation data from the CHADO database to a GAF file

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -f OUTPUT_FILE, --output_file OUTPUT_FILE
                        GAF output file
  -a ORGANISM, --abbreviation ORGANISM
                        abbreviation/short name of the organism
  -A DATABASE_AUTHORITY, --database_authority DATABASE_AUTHORITY
                        database from which the file is created, e.g.
                        'UniProtKB'
  -L {default,gene,transcript,protein}, --annotation_level {default,gene,transcript,protein}
                        level to which GO terms are related in the output file
                        (default: same level as in the database)
  --include_obsolete    export all features, including obsoletes
```

## chado-tools_execute_audit_backup

### Tool Description
backs up the audit tables to a separate schema

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado execute audit_backup [-h] [-V] [-c CONFIG | -p] --date DATE
                                  dbname

backs up the audit tables to a separate schema

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  --date DATE           date for maximum age of logs to remain in main audit
                        tables, format 'YYYYMMDD'
```

## chado-tools_admin_create

### Tool Description
create a new CHADO database

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado admin create [-h] [-V] [-c CONFIG | -p] dbname

create a new CHADO database

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
```

## chado-tools_admin_drop

### Tool Description
drop a CHADO database

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado admin drop [-h] [-V] [-c CONFIG | -p] dbname

drop a CHADO database

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
```

## chado-tools_admin_dump

### Tool Description
dump a CHADO database into an archive file

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado admin dump [-h] [-V] [-c CONFIG | -p] dbname archive

dump a CHADO database into an archive file

positional arguments:
  dbname                name of the database
  archive               archive file to be created

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
```

## chado-tools_admin_restore

### Tool Description
restore a CHADO database from an archive file

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado admin restore [-h] [-V] [-c CONFIG | -p] dbname archive

restore a CHADO database from an archive file

positional arguments:
  dbname                name of the database
  archive               archive file

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
```

## chado-tools_admin_setup

### Tool Description
set up a blank CHADO database according to a given schema

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado admin setup [-h] [-V] [-c CONFIG | -p]
                         [-s {gmod,basic,audit,audit_backup} | -f SCHEMA_FILE]
                         dbname

set up a blank CHADO database according to a given schema

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -s {gmod,basic,audit,audit_backup}, --schema {gmod,basic,audit,audit_backup}
                        Database schema (default: GMOD schema 1.31)
  -f SCHEMA_FILE, --schema_file SCHEMA_FILE
                        File with database schema
```

## chado-tools_admin_grant

### Tool Description
grant privileges for a CHADO database to a user/role

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado admin grant [-h] [-V] [-c CONFIG | -p] -r ROLE [-s SCHEMA] [-w]
                         dbname

grant privileges for a CHADO database to a user/role

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -r ROLE, --role ROLE  Name of the role/user
  -s SCHEMA, --schema SCHEMA
                        Database schema (default: all)
  -w, --write           Grant read-write access (default: read-only)
```

## chado-tools_admin_revoke

### Tool Description
revoke privileges for a CHADO database from a user/role

### Metadata
- **Docker Image**: quay.io/biocontainers/chado-tools:0.2.15--py_0
- **Homepage**: https://github.com/sanger-pathogens/chado-tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chado-tools/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/chado-tools
- **Stars**: N/A
### Original Help Text
```text
usage: chado admin revoke [-h] [-V] [-c CONFIG | -p] -r ROLE [-s SCHEMA]
                          dbname

revoke privileges for a CHADO database from a user/role

positional arguments:
  dbname                name of the database

optional arguments:
  -h, --help            show this help message and exit
  -V, --verbose         verbose mode
  -c CONFIG, --config CONFIG
                        YAML file containing connection details
  -p, --use_password    connect with password (default: no password)
  -r ROLE, --role ROLE  Name of the role/user
  -s SCHEMA, --schema SCHEMA
                        Database schema (default: all)
```

