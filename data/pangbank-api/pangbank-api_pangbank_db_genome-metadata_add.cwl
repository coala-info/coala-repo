cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangbank_db
  - genome-metadata
  - add
label: pangbank-api_pangbank_db_genome-metadata_add
doc: "Add a genome metadata source and its metadata table to the pangbank database\n\nThe database is a SQLite file. It is staged as a writable copy named pangbank.db\n  and selected with the PANGBANK_DB_PATH environment variable.\n\nTool homepage: https://github.com/labgem/pangbank-api"
inputs:
  - id: database
    type: File
    doc: Existing pangbank SQLite database (a writable copy is used)
  - id: metadata_source_file
    type: File
    doc: Path to a JSON file that describes the metadata source contains file information with genome metadata.
    inputBinding:
      position: 1
  - id: metadata_file
    type: File
    doc: Path to a TSV file that contains genome metadata. A column 'genomes' must be present.
    inputBinding:
      position: 2
stdout: pangbank_genome_metadata_add.log
outputs:
  - id: database_out
    type: File
    doc: The pangbank SQLite database after the command
    outputBinding:
      glob: pangbank.db
  - id: log
    type: stdout
    doc: Log messages of the import
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: PANGBANK_DB_PATH
        envValue: pangbank.db
  - class: InitialWorkDirRequirement
    listing:
      - '$(inputs.database ? {"entryname": "pangbank.db", "entry": inputs.database, "writable": true} : null)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangbank-api:0.1.2--pyhdfd78af_0
