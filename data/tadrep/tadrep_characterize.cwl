cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadrep characterize
label: tadrep_characterize
doc: "Import json file from a given database path into working directory\n\nTool homepage:
  https://github.com/oschwengers/tadrep"
inputs:
  - id: database
    type:
      - 'null'
      - File
    doc: Import json file from a given database path into working directory
    inputBinding:
      position: 101
      prefix: --db
  - id: inc_types
    type:
      - 'null'
      - File
    doc: Import inc-types from given path into working directory
    inputBinding:
      position: 101
      prefix: --inc-types
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
stdout: tadrep_characterize.out
