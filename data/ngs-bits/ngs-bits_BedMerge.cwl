cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedMerge
label: ngs-bits_BedMerge
doc: "Merges overlapping regions in a BED file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
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
  - id: keep_b2b
    type:
      - 'null'
      - boolean
    doc: "Do not merge non-overlapping but adjacent (back-to-back) regions. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -keep_b2b
  - id: merge_names
    type:
      - 'null'
      - boolean
    doc: "Merge name columns instead of removing all annotations. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -merge_names
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
