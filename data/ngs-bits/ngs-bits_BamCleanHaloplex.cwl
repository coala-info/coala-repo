cwlVersion: v1.2
class: CommandLineTool
baseCommand: BamCleanHaloplex
label: ngs-bits_BamCleanHaloplex
doc: "BAM cleaning for Haloplex.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type: File
    doc: "Input BAM/CRAM file."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: "Output BAM/CRAM file."
    inputBinding:
      position: 102
      prefix: -out
  - id: min_match
    type:
      - 'null'
      - int
    doc: "Minimum number of CIGAR matches (M). Default value: '30'"
    inputBinding:
      position: 101
      prefix: -min_match
  - id: ref
    type:
      - 'null'
      - File
    doc: "Reference genome for CRAM support (mandatory if CRAM is used)."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 101
      prefix: -ref
  - id: settings
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 101
      prefix: --settings
outputs:
  - id: output_file
    type: File
    doc: "Output BAM/CRAM file."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
