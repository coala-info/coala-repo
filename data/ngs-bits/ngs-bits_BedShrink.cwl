cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedShrink
label: ngs-bits_BedShrink
doc: "Shrinks the regions in a BED file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: n
    type: int
    doc: "The number of bases to shrink (on both sides of each region)."
    inputBinding:
      position: 101
      prefix: -n
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
