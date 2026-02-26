cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysradb
label: pysradb_Extract
doc: "Query NGS metadata and data from NCBI Sequence Read Archive.\n\nTool homepage:
  https://github.com/saketkc/pysradb"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to execute
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the selected subcommand
    inputBinding:
      position: 2
  - id: citation
    type:
      - 'null'
      - boolean
    doc: how to cite
    inputBinding:
      position: 103
      prefix: --citation
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
stdout: pysradb_Extract.out
