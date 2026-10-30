cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedpeFilter
label: ngs-bits_BedpeFilter
doc: "Filters a BEDPE file by region.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
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
  - id: bed
    type:
      - 'null'
      - File
    doc: "BED file that is used as ROI."
    inputBinding:
      position: 101
      prefix: -bed
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
