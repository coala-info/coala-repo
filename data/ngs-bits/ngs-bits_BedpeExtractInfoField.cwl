cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedpeExtractInfoField
label: ngs-bits_BedpeExtractInfoField
doc: "Extract a given INFO field key and annotates it as a separate column.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: info_fields
    type: string
    doc: "Comma separate list of INFO keys (and column header names) which should be extracted: \"INFO_KEY1[:COLUMN_HEADER1],INFO_KEY2[:COLUMN_HEADER2],...\""
    inputBinding:
      position: 101
      prefix: -info_fields
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input BEDPE file. If unset, reads from STDIN."
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: "Output BEDPE file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    inputBinding:
      position: 102
      prefix: -out
  - id: info_column
    type:
      - 'null'
      - string
    doc: "Header name of the INFO column. Default value: 'INFO_A'"
    inputBinding:
      position: 101
      prefix: -info_column
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
    doc: "Output BEDPE file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
