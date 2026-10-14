cwlVersion: v1.2
class: CommandLineTool
baseCommand: piler
label: piler
doc: "PILER identifies and classifies genomic repeats. This file wraps the -trs mode: it reads a hit file from a whole-genome local self-alignment (for example from PALS) and writes the transposable repeat structures (TRS).\n\nTool homepage: https://www.drive5.com/piler/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: trs
    type: File
    doc: 'Hit file from a whole-genome self-alignment'
    inputBinding:
      position: 101
      prefix: -trs
  - id: mincover
    type:
      - 'null'
      - int
    doc: 'Minimum coverage of a pile'
    inputBinding:
      position: 101
      prefix: -mincover
  - id: maxlengthdiffpct
    type:
      - 'null'
      - float
    doc: 'Maximum length difference in percent'
    inputBinding:
      position: 101
      prefix: -maxlengthdiffpct
  - id: piles_name
    type:
      - 'null'
      - string
    doc: 'Name of the pile file to write'
    inputBinding:
      position: 101
      prefix: -piles
  - id: images_name
    type:
      - 'null'
      - string
    doc: 'Name of the image file to write'
    inputBinding:
      position: 101
      prefix: -images
  - id: multihit
    type:
      - 'null'
      - boolean
    doc: 'Allow multiple hits'
    inputBinding:
      position: 101
      prefix: -multihit
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Suppress progress messages'
    inputBinding:
      position: 101
      prefix: -quiet
  - id: out_name
    type: string
    doc: 'Name of the TRS output file'
    inputBinding:
      position: 102
      prefix: -out
outputs:
  - id: trsfile
    type: File
    doc: 'TRS output file'
    outputBinding:
      glob: $(inputs.out_name)
  - id: piles
    type:
      - 'null'
      - File
    doc: 'Pile file'
    outputBinding:
      glob: $(inputs.piles_name)
  - id: images
    type:
      - 'null'
      - File
    doc: 'Image file'
    outputBinding:
      glob: $(inputs.images_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piler:0.1--0
