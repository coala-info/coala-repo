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
outputs:
  - id: output_db
    type: Directory
    doc: Path to the output database directory.
    outputBinding:
      glob: $(inputs.output_db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cytosnake:0.0.2--pyhdfd78af_0
