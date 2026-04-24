cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ntm-profiler
  - create_resistance_db
label: ntm-profiler_create_resistance_db
doc: "Create a resistance database for ntm-profiler.\n\nTool homepage: https://github.com/jodyphelan/NTM-Profiler"
inputs:
  - id: barcode
    type:
      - 'null'
      - File
    doc: A bed file containing lineage barcode SNPs
    inputBinding:
      position: 101
      prefix: --barcode
  - id: csv
    type:
      - 'null'
      - File
    doc: The CSV file containing mutations
    inputBinding:
      position: 101
      prefix: --csv
  - id: custom
    type:
      - 'null'
      - boolean
    doc: Tells the script this is a custom database, this is used to alter the 
      generation of the version file
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
    doc: Storage directory
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
      prefix: --db-name
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug logging
    inputBinding:
      position: 101
      prefix: --debug
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
    doc: Tells the script to force the creation of the database, even if it 
      already exists
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
      prefix: --include_original_mutation
  - id: load
    type:
      - 'null'
      - boolean
    doc: Load the library after creating it
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
      - string
    doc: The prefix for all output files
    inputBinding:
      position: 101
      prefix: --match_ref
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Don't remove temporary files after run
    inputBinding:
      position: 101
      prefix: --no_cleanup
  - id: other_annotations
    type:
      - 'null'
      - string
    doc: The prefix for all output files
    inputBinding:
      position: 101
      prefix: --other_annotations
  - id: prefix
    type: string
    doc: The name of the database (match species name for automated 
      speciation+resistance detection)
    inputBinding:
      position: 101
      prefix: --prefix
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Temp directory to process all files
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
    dockerPull: quay.io/biocontainers/ntm-profiler:0.8.1--pyhdfd78af_0
stdout: ntm-profiler_create_resistance_db.out
