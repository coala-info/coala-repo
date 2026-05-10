cwlVersion: v1.2
class: CommandLineTool
baseCommand: cytosnake_makedb
label: cytosnake_makedb
doc: "Builds a database for cytosnake.\n\nTool homepage: https://github.com/WayScience/CytoSnake"
inputs:
  - id: input_dir
    type: Directory
    doc: Directory containing the input files.
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing database if it exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for building the database.
    inputBinding:
      position: 102
      prefix: --threads
  - id: output_db_path
    type: string
    doc: Output or path parameter `output_db_path`
    inputBinding:
      position: 103
      prefix: --output-db
outputs:
  - id: output_db
    type: Directory
    doc: Path to the output database directory.
    outputBinding:
      glob: $(inputs.output_db_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cytosnake:0.0.2--pyhdfd78af_0
