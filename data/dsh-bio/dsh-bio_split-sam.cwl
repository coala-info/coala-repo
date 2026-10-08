cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-split-sam
label: dsh-bio_split-sam
doc: "Splits a SAM/BAM/CRAM file into smaller files based on record count or byte
  size.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: bytes
    type:
      - 'null'
      - string
    doc: split input path at next record after each n bytes
    inputBinding:
      position: 101
      prefix: --bytes
  - id: input_path
    type: File
    doc: input SAM path
    inputBinding:
      position: 101
      prefix: --input-path
  - id: left_pad
    type:
      - 'null'
      - int
    doc: left pad split index in output file name
    inputBinding:
      position: 101
      prefix: --left-pad
  - id: prefix
    type:
      - 'null'
      - string
    doc: output file prefix
    inputBinding:
      position: 101
      prefix: --prefix
  - id: records
    type:
      - 'null'
      - long
    doc: split input path after each n records
    inputBinding:
      position: 101
      prefix: --records
  - id: suffix
    type:
      - 'null'
      - string
    doc: output file suffix, e.g. .sam.bgz
    inputBinding:
      position: 101
      prefix: --suffix
outputs:
  - id: prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in prefix
    outputBinding:
      glob: "$(inputs.prefix ? inputs.prefix : inputs.input_path.basename.split('.')[0])*"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
