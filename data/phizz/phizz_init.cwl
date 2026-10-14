cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phizz
  - init
label: phizz_init
doc: "Create a config file for phizz.\n\nTool homepage: https://github.com/moonso/phizz"
inputs:
  - id: db_name
    type: string
    doc: Database name
    default: phizz.db
    inputBinding:
      position: 101
      prefix: --db_name
  - id: db_path
    type:
      - 'null'
      - string
    doc: Path to store the database
    inputBinding:
      position: 101
      prefix: --path
outputs:
  - id: database
    type: File
    doc: The empty phizz database created from the schema
    outputBinding:
      glob: $(inputs.db_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phizz:0.2.3--py_0
