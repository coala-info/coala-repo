# crabs CWL Generation Report

## crabs

### Tool Description
CRABS is an open-source software program that enables scientists to build custom local reference databases for improved taxonomy assignment of metabarcoding data.
CRABS is split up into various functions and steps to accomplish this task, including:
(1) download data from online repositories,
(2) import downloaded data into CRABS format,
(3) extract amplicons from imported data,
(4) retrieve amplicons without primer-binding regions,
(5) curate and subset the local database,
(6) export the local database in various taxonomic classifier formats, and
(7) basic visualisations to explore the local reference database.

### Metadata
- **Docker Image**: quay.io/biocontainers/crabs:1.14.0--pyhdfd78af_0
- **Homepage**: https://github.com/gjeunen/reference_database_creator
- **Package**: https://anaconda.org/channels/bioconda/packages/crabs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crabs/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/gjeunen/reference_database_creator
- **Stars**: N/A
### Original Help Text
```text
/// CRABS | v1.14.0                                                            
                                                                                
 Usage: crabs [OPTIONS]                                                         
                                                                                
 CRABS is an open-source software program that enables scientists to build      
 custom local reference databases for improved taxonomy assignment of           
 metabarcoding data.                                                            
 CRABS is split up into various functions and steps to accomplish this task,    
 including:                                                                     
 (1) download data from online repositories,                                    
 (2) import downloaded data into CRABS format,                                  
 (3) extract amplicons from imported data,                                      
 (4) retrieve amplicons without primer-binding regions,                         
 (5) curate and subset the local database,                                      
 (6) export the local database in various taxonomic classifier formats, and     
 (7) basic visualisations to explore the local reference database.              
                                                                                
 A basic example to run CRABS (download NCBI taxonomy information):             
 crabs --download-taxonomy --exclude 'acc2taxid'                                
                                                                                
╭─ Download NCBI Taxonomy ─────────────────────────────────────────────────────╮
│ --download-taxonomy  Function to download NCBI taxonomy                      │
│ --exclude            stop the download of 'acc2taxid' or 'taxdump' (TEXT)    │
│ --output             output directory or filename (TEXT)                     │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Download BOLD Database ─────────────────────────────────────────────────────╮
│ --download-bold  Function to download BOLD database                          │
│ --taxon          taxonomic group to download (TEXT)                          │
│ --marker         genetic marker to download (TEXT)                           │
│ --output         output directory or filename (TEXT)                         │
│ --version-v3     download data from BOLD v3 (legacy)                         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Download EMBL Database ─────────────────────────────────────────────────────╮
│ --download-embl  Function to download EMBL database                          │
│ --taxon          taxonomic group to download (TEXT)                          │
│ --output         output directory or filename (TEXT)                         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Download GreenGenes Database ───────────────────────────────────────────────╮
│ --download-greengenes  Function to download GreenGenes database              │
│ --output               output directory or filename (TEXT)                   │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Download GreenGenes2 Database ──────────────────────────────────────────────╮
│ --download-greengenes2  Function to downlaod GreenGenes2 database            │
│ --output                output directory or filename (TEXT)                  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Download Meta-Fish-Lib ─────────────────────────────────────────────────────╮
│ --download-meta-fish-lib  Function to download the Meta-Fish-Lib database    │
│ --output                  output directory or filename (TEXT)                │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Download MIDORI2 Database ──────────────────────────────────────────────────╮
│ --download-midori  Function to download MIDORI2 database                     │
│ --gene             gene to download (TEXT)                                   │
│ --gb-number        database version to download (TEXT)                       │
│ --gb-type          database type to download (TEXT)                          │
│ --output           output directory or filename (TEXT)                       │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Download MitoFish Database ─────────────────────────────────────────────────╮
│ --download-mitofish  Function to download MitoFish database                  │
│ --output             output directory or filename (TEXT)                     │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Download NCBI Database ─────────────────────────────────────────────────────╮
│ --download-ncbi  Function to download NCBI database                          │
│ --email          email address to connect to NCBI server (TEXT)              │
│ --query          query identifying what to download from NCBI (TEXT)         │
│ --database       the database from which NCBI sequences are downloaded       │
│                  (TEXT)                                                      │
│ --batchsize      sequences to download from NCBI per chunk (default = 5,000) │
│                  (INTEGER)                                                   │
│ --species        species of interest list (TEXT)                             │
│ --output         output directory or filename (TEXT)                         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Download SILVA Database ────────────────────────────────────────────────────╮
│ --download-silva  Function to download SILVA database                        │
│ --gene            gene to download (TEXT)                                    │
│ --db-type         database version to download (TEXT)                        │
│ --db-version      database version to download (TEXT)                        │
│ --output          output directory or filename (TEXT)                        │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Import sequences into CRABS format ─────────────────────────────────────────╮
│ --import         Function to import sequences into CRABS format              │
│ --import-format  format of the sequences to import (TEXT)                    │
│ --names          NCBI taxonomy 'names.dmp' file (TEXT)                       │
│ --nodes          NCBI taxonomy 'nodes.dmp' file (TEXT)                       │
│ --acc2tax        NCBI taxonomy 'nucl_gb.accession2taxid' file (TEXT)         │
│ --input          input filename (TEXT)                                       │
│ --output         output directory or filename (TEXT)                         │
│ --ranks          taxonomic ranks to be included in the taxonomic lineage     │
│                  (TEXT)                                                      │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Merge CRABS databases into one file ────────────────────────────────────────╮
│ --merge   Function to merge CRABS databases into a single file               │
│ --input   input filename (TEXT)                                              │
│ --output  output directory or filename (TEXT)                                │
│ --uniq    keep only unique accession numbers                                 │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Extract amplicons through in silico PCR ────────────────────────────────────╮
│ --in-silico-pcr  Function to extract amplicons through in silico PCR         │
│ --input          input filename (TEXT)                                       │
│ --output         output directory or filename (TEXT)                         │
│ --forward        forward primer sequence in 5' -> 3' direction (TEXT)        │
│ --reverse        reverse primer sequence in 5' -> 3' direction (TEXT)        │
│ --mismatch       number of mismatches allowed in the primer-binding site     │
│                  (default: 4) (FLOAT)                                        │
│ --threads        number of threads used to compute the in silico PCR         │
│                  (default: autodetection) (INTEGER)                          │
│ --untrimmed      file name for untrimmed sequences (TEXT)                    │
│ --relaxed        recover amplicons where only the forward or reverse         │
│                  primer-binding region was found                             │
│ --buffer-size    value 2x the longest sequence in the data, only necessary   │
│                  when observing an 'OverflowError' (INTEGER)                 │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Retrieve amplicons without primer-binding regions ──────────────────────────╮
│ --pairwise-global-alignment  Function to retrieve amplicons without          │
│                              primer-bidning regions                          │
│ --input                      input filename (TEXT)                           │
│ --output                     output directory or filename (TEXT)             │
│ --amplicons                  file name for the amplicons retrieved during in │
│                              silico PCR (TEXT)                               │
│ --forward                    forward primer sequence in 5' -> 3' direction   │
│                              (TEXT)                                          │
│ --reverse                    reverse primer sequence in 5' -> 3' direction   │
│                              (TEXT)                                          │
│ --size-select                exclude reads longer than N from the analysis   │
│                              (TEXT)                                          │
│ --threads                    number of threads used to compute the in silico │
│                              PCR (default: autodetection) (INTEGER)          │
│ --percent-identity           minimum percent identity threshold for the      │
│                              alignment to pass (0.0 - 1.0) (TEXT)            │
│ --coverage                   minimum coverage threshold for the alignment to │
│                              pass (0 - 100) (TEXT)                           │
│ --all-start-positions        do not restrict alignment start and end to be   │
│                              within the primer-binding region length         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Dereplicate CRABS database ─────────────────────────────────────────────────╮
│ --dereplicate           Function to dereplicate a CRABS database             │
│ --input                 input filename (TEXT)                                │
│ --output                output directory or filename (TEXT)                  │
│ --dereplication-method  dereplication method: "strict", "single_species",    │
│                         and "unique_species" (default) (TEXT)                │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Filter CRABS database ──────────────────────────────────────────────────────╮
│ --filter          Function to filter a CRABS database                        │
│ --input           input filename (TEXT)                                      │
│ --output          output directory or filename (TEXT)                        │
│ --minimum-length  minimum sequence length for amplicon to be retained in the │
│                   database (INTEGER)                                         │
│ --maximum-length  maximum sequence length for amplicon to be retained in the │
│                   database (INTEGER)                                         │
│ --maximum-n       discard amplicons with N or more ambiguous bases (INTEGER) │
│ --environmental   discard environmental sequences from the database          │
│ --no-species-id   discard sequences for which no species name is available   │
│ --rank-na         discard sequences with N or more unspecified taxonomic     │
│                   levels (INTEGER)                                           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Subset CRABS database on taxonomic ID ──────────────────────────────────────╮
│ --subset   Function to subset a CRABS database                               │
│ --input    input filename (TEXT)                                             │
│ --output   output directory or filename (TEXT)                               │
│ --include  string or file containing taxa to include (TEXT)                  │
│ --exclude  stop the download of 'acc2taxid' or 'taxdump' (TEXT)              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Figure: diversity contained within database ────────────────────────────────╮
│ --diversity-figure  Function to create a horizontal bar chart with included  │
│                     diversity                                                │
│ --input             input filename (TEXT)                                    │
│ --output            output directory or filename (TEXT)                      │
│ --tax-level         taxonomic level to be used as groups for horizontal bar  │
│                     chart (INTEGER)                                          │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Figure: amplicon length distribution ───────────────────────────────────────╮
│ --amplicon-length-figure  Function to create a line chart depicting amplicon │
│                           distributions                                      │
│ --input                   input filename (TEXT)                              │
│ --output                  output directory or filename (TEXT)                │
│ --tax-level               taxonomic level to be used as groups for           │
│                           horizontal bar chart (INTEGER)                     │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Figure: phylogenetic tree ──────────────────────────────────────────────────╮
│ --phylogenetic-tree  Function to create a phylogenetic tree with barcodes    │
│                      for target species list                                 │
│ --input              input filename (TEXT)                                   │
│ --output             output directory or filename (TEXT)                     │
│ --tax-level          taxonomic level to be used as groups for horizontal bar │
│                      chart (INTEGER)                                         │
│ --species            species of interest list (TEXT)                         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Figure: amplification efficiency ───────────────────────────────────────────╮
│ --amplification-efficiency-figure  Function to create a bar graph displaying │
│                                    mismatches in the primer-binding region   │
│ --input                            input filename (TEXT)                     │
│ --amplicons                        file name for the amplicons retrieved     │
│                                    during in silico PCR (TEXT)               │
│ --forward                          forward primer sequence in 5' -> 3'       │
│                                    direction (TEXT)                          │
│ --reverse                          reverse primer sequence in 5' -> 3'       │
│                                    direction (TEXT)                          │
│ --output                           output directory or filename (TEXT)       │
│ --tax-group                        taxonomic group of interest to be         │
│                                    included in the analysis (TEXT)           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Table: database completeness for target taxonomic group ────────────────────╮
│ --completeness-table  Function creating a spreadsheet containing barcode     │
│                       availability for taxonomic groups                      │
│ --input               input filename (TEXT)                                  │
│ --output              output directory or filename (TEXT)                    │
│ --names               NCBI taxonomy 'names.dmp' file (TEXT)                  │
│ --nodes               NCBI taxonomy 'nodes.dmp' file (TEXT)                  │
│ --species             species of interest list (TEXT)                        │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Export CRABS database to taxonomic classifier format ───────────────────────╮
│ --export         Function to export a CRABS database                         │
│ --input          input filename (TEXT)                                       │
│ --output         output directory or filename (TEXT)                         │
│ --export-format  export format: "sintax", "rdp", "qiime-fasta",              │
│                  "qiime-text", "dada2-species", "dada2-taxonomy",            │
│                  "idt-fasta", "idt-text", "blast-notax", "blast-tax" (TEXT)  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help  -h  Show this message and exit.                                      │
╰──────────────────────────────────────────────────────────────────────────────╯
                                                                                
 See https://github.com/gjeunen/reference_database_creator for more details.
```

