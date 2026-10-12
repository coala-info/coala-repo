cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangbank_db
  - add-collection-release
label: pangbank-api_pangbank_db_add-collection-release
doc: "Add a collection release (collection, taxonomy, genomes and pangenomes) to the pangbank database\n\nThe database is a SQLite file. It is staged as a writable copy named pangbank.db\n  and selected with the PANGBANK_DB_PATH environment variable.\n\nTool homepage: https://github.com/labgem/pangbank-api"
inputs:
  - id: database
    type:
      - 'null'
      - File
    doc: Existing pangbank SQLite database to extend (a new one is created when absent)
  - id: pangbank_data_dir
    type:
      - 'null'
      - Directory
    doc: 'Path to the pangbank data directory; paths inside the release json are relative to it (default: .)'
    inputBinding:
      position: 1
      prefix: --pangbank-data-dir
  - id: collection_release_json
    type: File
    doc: Path to the collection release input json file.
    inputBinding:
      position: 2
  - id: referenced_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Taxonomy, genome list and genome metadata files named in the release json; the tool looks for them in the working directory, so they are staged there
stdout: pangbank_add_collection_release.log
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
      - $(inputs.referenced_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangbank-api:0.1.2--pyhdfd78af_0
