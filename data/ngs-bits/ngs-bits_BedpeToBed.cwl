cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedpeToBed
label: ngs-bits_BedpeToBed
doc: "Converts a BEDPE file into BED file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type: File
    doc: "Input BEDPE file."
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: "Output BED file."
    inputBinding:
      position: 102
      prefix: -out
  - id: merge
    type:
      - 'null'
      - boolean
    doc: "Merge the resulting BED file. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -merge
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
    doc: "Output BED file."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
