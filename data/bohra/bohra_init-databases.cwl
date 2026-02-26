cwlVersion: v1.2
class: CommandLineTool
baseCommand: bohra init-databases
label: bohra_init-databases
doc: "Download and/or setup required databases.\n\nTool homepage: https://github.com/kristyhoran/bohra"
inputs:
  - id: database_path
    type:
      - 'null'
      - string
    doc: If you select to setup databases, specify the path to download them to.
    inputBinding:
      position: 101
      prefix: --database_path
  - id: setup_databases
    type:
      - 'null'
      - boolean
    doc: Download and/or setup required databases.
    inputBinding:
      position: 101
      prefix: --setup_databases
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bohra:3.4.1--pyhdfd78af_0
stdout: bohra_init-databases.out
