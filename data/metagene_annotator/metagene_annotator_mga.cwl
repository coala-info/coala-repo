cwlVersion: v1.2
class: CommandLineTool
baseCommand: mga
label: metagene_annotator_mga
doc: "Metagenome Gene Annotator\n\nTool homepage: http://metagene.cb.k.u-tokyo.ac.jp/"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: Input multi-fasta file
    inputBinding:
      position: 1
  - id: multiple_species
    type:
      - 'null'
      - boolean
    doc: multiple species (sequences are individually treated)
    inputBinding:
      position: 102
      prefix: -m
  - id: single_species
    type:
      - 'null'
      - boolean
    doc: single species (sequences are treated as a unit)
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagene_annotator:1.0--0
stdout: metagene_annotator_mga.out
