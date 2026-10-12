cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangbank_db
  - delete-collection
label: pangbank-api_pangbank_db_delete-collection
doc: "Delete a collection, or one release of it, from the pangbank database\n\nThe database is a SQLite file. It is staged as a writable copy named pangbank.db\n  and selected with the PANGBANK_DB_PATH environment variable.\n\nTool homepage: https://github.com/labgem/pangbank-api"
inputs:
  - id: database
    type: File
    doc: Existing pangbank SQLite database (a writable copy is used)
  - id: release_version
    type:
      - 'null'
      - string
    doc: Specific release version to delete. If not provided, the entire collection will be deleted.
    inputBinding:
      position: 1
      prefix: --release-version
  - id: collection_name
    type: string
    doc: Name of the collection to delete.
    inputBinding:
      position: 2
stdout: pangbank_delete_collection.log
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
