cwlVersion: v1.2
class: CommandLineTool
baseCommand: tb-profiler create_db
label: tb-profiler_create_db
doc: "Create a database for tb-profiler\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: amplicon_primers
    type:
      - 'null'
      - File
    doc: A file containing a list of amplicon primers
    inputBinding:
      position: 101
      prefix: --amplicon-primers
  - id: barcode
    type:
      - 'null'
      - File
    doc: A bed file containing lineage barcode SNPs
    inputBinding:
      position: 101
      prefix: --barcode
  - id: bedmask
    type:
      - 'null'
      - File
    doc: A bed file containing a list of low-complexity regions
    inputBinding:
      position: 101
      prefix: --bedmask
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: Create a samtools, gatk and bwa index for the reference genome
    inputBinding:
      position: 101
      prefix: --create-index
  - id: csv_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The input CSV file containing the mutations
      - mutations.csv
    inputBinding:
      position: 101
      prefix: --csv
  - id: custom
    type:
      - 'null'
      - boolean
    doc: Tells the script this is a custom database, this is used to alter the 
      generation of the version definition
    inputBinding:
      position: 101
      prefix: --custom
  - id: db_author
    type:
      - 'null'
      - string
    doc: Overrides the author of the database in the version file
    inputBinding:
      position: 101
      prefix: --db-author
  - id: db_commit
    type:
      - 'null'
      - string
    doc: Overrides the commit string of the database in the version file
    inputBinding:
      position: 101
      prefix: --db-commit
  - id: db_date
    type:
      - 'null'
      - string
    doc: Overrides the date of the database in the version file
    inputBinding:
      position: 101
      prefix: --db-date
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Database directory
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: db_name
    type:
      - 'null'
      - string
    doc: Overrides the name of the database in the version file
    inputBinding:
      position: 101
      prefix: --db_name
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Storage directory
    inputBinding:
      position: 101
      prefix: --dir
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite existing database with the same name
    inputBinding:
      position: 101
      prefix: --force
  - id: include_original_mutation
    type:
      - 'null'
      - boolean
    doc: Include the original mutation (before reformatting) as part of the 
      variant annotaion
    inputBinding:
      position: 101
      prefix: --include-original-mutation
  - id: load
    type:
      - 'null'
      - boolean
    doc: Automaticaly load database
    inputBinding:
      position: 101
      prefix: --load
  - id: logging
    type:
      - 'null'
      - string
    doc: Logging level
    inputBinding:
      position: 101
      prefix: --logging
  - id: match_ref
    type:
      - 'null'
      - File
    doc: Match the chromosome name to the given fasta file
    inputBinding:
      position: 101
      prefix: --match-ref
  - id: no_overwrite
    type:
      - 'null'
      - boolean
    doc: Don't load if existing database with prefix exists
    inputBinding:
      position: 101
      prefix: --no-overwrite
  - id: prefix
    type: string
    doc: The prefix for all output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: rules
    type:
      - 'null'
      - File
    doc: A yaml file containing rules for the resistance library
    inputBinding:
      position: 101
      prefix: --rules
  - id: spoligotype_annotations
    type:
      - 'null'
      - File
    doc: A file containing spoligotype annotations
    inputBinding:
      position: 101
      prefix: --spoligotype-annotations
  - id: spoligotypes
    type:
      - 'null'
      - File
    doc: A file containing a list of spoligotype spacers
    inputBinding:
      position: 101
      prefix: --spoligotypes
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Temp firectory to process all files
    inputBinding:
      position: 101
      prefix: --temp
  - id: watchlist
    type:
      - 'null'
      - File
    doc: A csv file containing genes to profile but without any specific 
      associated mutations
    inputBinding:
      position: 101
      prefix: --watchlist
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_create_db.out
