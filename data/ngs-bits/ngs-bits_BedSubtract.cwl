cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedSubtract
label: ngs-bits_BedSubtract
doc: "Subtracts the regions in one BED file from another.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: in2
    type: File
    doc: "Input BED file which is subtracted from 'in'."
    inputBinding:
      position: 101
      prefix: -in2
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input BED file. If unset, reads from STDIN."
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: "Output BED file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    inputBinding:
      position: 102
      prefix: -out
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
    doc: "Output BED file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
