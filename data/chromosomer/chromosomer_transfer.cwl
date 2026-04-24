cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromosomer_transfer
label: chromosomer_transfer
doc: "Transfer annotated genomic features from fragments to their assembly.\n\nTool
  homepage: https://github.com/gtamazian/chromosomer"
inputs:
  - id: map
    type: File
    doc: a fragment map file
    inputBinding:
      position: 1
  - id: annotation
    type: File
    doc: a file of annotated genome features
    inputBinding:
      position: 2
  - id: format
    type:
      - 'null'
      - string
    doc: the format of a file of annotated features (bed, gff3 or vcf)
    inputBinding:
      position: 103
      prefix: --format
outputs:
  - id: output
    type: File
    doc: an output file of the transfered annotation
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
