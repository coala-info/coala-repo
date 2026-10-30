cwlVersion: v1.2
class: CommandLineTool
baseCommand: TsvInfo
label: ngs-bits_TsvInfo
doc: "Prints general information about a TSV file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input TSV file. If unset, reads from STDIN."
    inputBinding:
      position: 1
      prefix: -in
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output file. If unset, writes to STDOUT."
    inputBinding:
      position: 2
      prefix: -out
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 3
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output file. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
