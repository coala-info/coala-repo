cwlVersion: v1.2
class: CommandLineTool
baseCommand: BamInfo
label: ngs-bits_BamInfo
doc: "Basic BAM information.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      type: array
      items: File
    doc: "Input BAM/CRAM files."
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
    doc: "Output TSV file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    inputBinding:
      position: 102
      prefix: -out
  - id: name
    type:
      - 'null'
      - boolean
    doc: "Add filename only to output. The default is to add the canonical file path. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -name
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
    doc: "Output TSV file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
