cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clair.py
  - CombineBins
label: clair_CombineBins
doc: "Combine small bins into a large bin.\n\nTool homepage: https://github.com/HKU-BAL/Clair"
inputs:
  - id: src
    type: Directory
    doc: "Path to directory that stores small bins. (default: ./all_bins)"
    inputBinding:
      position: 101
      prefix: --src
  - id: dst
    type:
      - 'null'
      - string
    doc: "Path of the output folder; it must exist (default: .)"
    inputBinding:
      position: 101
      prefix: --dst
  - id: bin_name
    type:
      - 'null'
      - string
    doc: "Name of the large bin. (default: tensor.bin)"
    default: tensor.bin
    inputBinding:
      position: 101
      prefix: --bin_name
  - id: shuffle_data
    type:
      - 'null'
      - boolean
    doc: "Shuffle data after loaded all data. (default: False)"
    inputBinding:
      position: 101
      prefix: --shuffle_data
      valueFrom: "$(self ? 'True' : null)"
outputs:
  - id: combined_bin
    type: File
    doc: "Combined binary tensor file"
    outputBinding:
      glob: "$(inputs.dst ? inputs.dst + '/' : '')$(inputs.bin_name)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1
