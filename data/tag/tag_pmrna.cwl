cwlVersion: v1.2
class: CommandLineTool
baseCommand: tag pmrna
label: tag_pmrna
doc: "Parses and processes a GFF3 file for pmRNA analysis.\n\nTool homepage: https://github.com/standage/tag/"
inputs:
  - id: gff3
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: relax
    type:
      - 'null'
      - boolean
    doc: relax parsing stringency
    inputBinding:
      position: 102
      prefix: --relax
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tag:0.5.1--py_0
stdout: tag_pmrna.out
