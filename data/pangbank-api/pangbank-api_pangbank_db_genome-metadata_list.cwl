cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangbank_db
  - genome-metadata
  - list
label: pangbank-api_pangbank_db_genome-metadata_list
doc: "List all genome metadata sources in the pangbank database\n\nThe database is a SQLite file. It is staged as a writable copy named pangbank.db\n  and selected with the PANGBANK_DB_PATH environment variable.\n\nTool homepage: https://github.com/labgem/pangbank-api"
inputs:
  - id: database
    type: File
    doc: Existing pangbank SQLite database (a writable copy is used)
stdout: pangbank_genome_metadata_list.txt
outputs:
  - id: sources
    type: stdout
    doc: Table of the genome metadata sources
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
