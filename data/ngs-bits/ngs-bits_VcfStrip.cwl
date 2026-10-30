cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfStrip
label: ngs-bits_VcfStrip
doc: "Removes unwanted information from a VCF file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: clear_info
    type:
      - 'null'
      - boolean
    doc: "Remove all INFO fields"
    inputBinding:
      position: 1
      prefix: -clear_info
  - id: format
    type:
      - 'null'
      - string
    doc: "Comma-separated list of FORMAT entries to keep. If unset, all FORMAT entries are kept"
    inputBinding:
      position: 2
      prefix: -format
  - id: info
    type:
      - 'null'
      - string
    doc: "Comma-separated list of INFO entries to keep. If unset, all INFO entries are kept."
    inputBinding:
      position: 3
      prefix: -info
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input VCF file. If unset, reads from STDIN."
    inputBinding:
      position: 4
      prefix: -in
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output VCF file. If unset, writes to STDOUT."
    inputBinding:
      position: 5
      prefix: -out
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 6
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output VCF file. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
