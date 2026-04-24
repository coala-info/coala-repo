cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntm-profiler create_species_db
label: ntm-profiler_create_species_db
doc: "Create a species database for ntm-profiler.\n\nTool homepage: https://github.com/jodyphelan/NTM-Profiler"
inputs:
  - id: accessions
    type: File
    doc: The CSV file containing map from accessions to species
    inputBinding:
      position: 101
      prefix: --accessions
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
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Don't remove temporary files after run
    inputBinding:
      position: 101
      prefix: --no_cleanup
  - id: prefix
    type: string
    doc: The name of the database
    inputBinding:
      position: 101
      prefix: --prefix
  - id: sourmash_db
    type: File
    doc: The file containing species sourmash
    inputBinding:
      position: 101
      prefix: --sourmash_db
  - id: sylph_db
    type:
      - 'null'
      - Directory
    doc: The directory containing sylph sketches
    inputBinding:
      position: 101
      prefix: --sylph_db
  - id: taxonomy_info
    type:
      - 'null'
      - File
    doc: A CSV file containing information and notes about taxa
    inputBinding:
      position: 101
      prefix: --taxonomy_info
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Temp directory to process all files
    inputBinding:
      position: 101
      prefix: --temp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntm-profiler:0.8.1--pyhdfd78af_0
stdout: ntm-profiler_create_species_db.out
