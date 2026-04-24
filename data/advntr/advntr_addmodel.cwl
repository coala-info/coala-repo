cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - advntr
  - addmodel
label: advntr_addmodel
doc: "Add a new VNTR model to the database\n\nTool homepage: https://github.com/mehrdadbakhtiari/adVNTR"
inputs:
  - id: annotation
    type:
      - 'null'
      - string
    doc: Annotation of VNTR region
    inputBinding:
      position: 101
      prefix: --annotation
  - id: chromosome
    type: string
    doc: Chromosome (e.g. chr1)
    inputBinding:
      position: 101
      prefix: --chromosome
  - id: end
    type: int
    doc: End coordinate of VNTR in forward (5' to 3') direction
    inputBinding:
      position: 101
      prefix: --end
  - id: gene
    type:
      - 'null'
      - string
    doc: Gene name
    inputBinding:
      position: 101
      prefix: --gene
  - id: models
    type:
      - 'null'
      - File
    doc: VNTR models file
    inputBinding:
      position: 101
      prefix: --models
  - id: pattern
    type: string
    doc: First repeating pattern of VNTR in forward (5' to 3') direction
    inputBinding:
      position: 101
      prefix: --pattern
  - id: reference
    type: string
    doc: Reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: start
    type: int
    doc: Start coordinate of VNTR in forward (5' to 3') direction
    inputBinding:
      position: 101
      prefix: --start
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/advntr:1.5.0--py310ha6711e0_1
stdout: advntr_addmodel.out
