cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - add_nodes
label: taxtastic_taxit_add_nodes
doc: "Add nodes and names to a database\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: schema
    type:
      - 'null'
      - string
    doc: "Name of SQL schema in database to query (if database flavor supports this)."
    inputBinding:
      position: 1
      prefix: "--schema"
  - id: source_name
    type:
      - 'null'
      - string
    doc: "Provides the default source name for new nodes. The value is overridden by \"source_name\" in the input file. If not provided, \"source_name\" is required in each node or name definition. This source name is created if it does not exist."
    inputBinding:
      position: 1
      prefix: "--source-name"
  - id: database
    type: File
    doc: "Taxonomy database (SQLite file made by new_database). Database string URI or filename; if no scheme is given sqlite:/// is prepended. The file is changed in place."
    inputBinding:
      position: 101
  - id: new_nodes
    type: File
    doc: "yaml file specifying new nodes"
    inputBinding:
      position: 102
outputs:
  - id: database_out
    type: File
    doc: "The database after the nodes and names were added"
    outputBinding:
      glob: "$(inputs.database.basename)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_add_nodes.out
