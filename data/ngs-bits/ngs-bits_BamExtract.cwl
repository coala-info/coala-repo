cwlVersion: v1.2
class: CommandLineTool
baseCommand: BamExtract
label: ngs-bits_BamExtract
doc: "Extract reads from BAM/CRAM by read name.\n\nTool homepage: https://github.com/imgag/ngs-bits"
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
  - id: ids
    type: File
    doc: "Input text file containing read names (one per line)."
    inputBinding:
      position: 101
      prefix: -ids
  - id: output_file_path
    type: string
    doc: "Output BAM/CRAM file with matching reads."
    inputBinding:
      position: 102
      prefix: -out
  - id: out2_path
    type:
      - 'null'
      - string
    doc: "Output BAM/CRAM file with not matching reads."
    inputBinding:
      position: 102
      prefix: -out2
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
    doc: "Output BAM/CRAM file with matching reads."
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: out2
    type:
      - 'null'
      - File
    doc: "Output BAM/CRAM file with not matching reads."
    outputBinding:
      glob: $(inputs.out2_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
