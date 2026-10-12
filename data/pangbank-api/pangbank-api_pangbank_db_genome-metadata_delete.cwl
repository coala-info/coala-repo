cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangbank_db
  - genome-metadata
  - delete
label: pangbank-api_pangbank_db_genome-metadata_delete
doc: "Delete a genome metadata source from the pangbank database\n\nThe database is a SQLite file. It is staged as a writable copy named pangbank.db\n  and selected with the PANGBANK_DB_PATH environment variable.\n\nTool homepage: https://github.com/labgem/pangbank-api"
inputs:
  - id: database
    type: File
    doc: Existing pangbank SQLite database (a writable copy is used)
  - id: metadata_source_version
    type:
      - 'null'
      - string
    doc: Specific metadata source version to delete. If not provided, the entire source will be deleted.
    inputBinding:
      position: 1
      prefix: --metadata-source-version
  - id: metadata_source_name
    type: string
    doc: Name of the metadata source to delete from the database.
    inputBinding:
      position: 2
stdout: pangbank_genome_metadata_delete.log
outputs:
  - id: database_out
    type: File
    doc: The pangbank SQLite database after the command
    outputBinding:
      glob: pangbank.db
  - id: log
    type: stdout
    doc: Log messages of the deletion
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
