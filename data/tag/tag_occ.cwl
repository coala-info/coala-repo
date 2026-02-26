cwlVersion: v1.2
class: CommandLineTool
baseCommand: tag occ
label: tag_occ
doc: "Extracts features of a given type from a GFF3 file.\n\nTool homepage: https://github.com/standage/tag/"
inputs:
  - id: gff3
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: type
    type: string
    doc: feature type
    inputBinding:
      position: 2
  - id: relax
    type:
      - 'null'
      - boolean
    doc: relax parsing stringency
    inputBinding:
      position: 103
      prefix: --relax
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tag:0.5.1--py_0
stdout: tag_occ.out
