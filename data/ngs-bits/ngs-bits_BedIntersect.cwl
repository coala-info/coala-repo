cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedIntersect
label: ngs-bits_BedIntersect
doc: "Intersects the regions in two BED files.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: in2
    type: File
    doc: "Second input BED file."
    inputBinding:
      position: 101
      prefix: -in2
  - id: mode
    type:
      - 'null'
      - type: enum
        symbols:
          - intersect
          - in
          - in2
    doc: "Output mode: intersect of both files (intersect), original entry of file 1 (in) or original entry of file 2 (in2). Default value: 'intersect' Valid: intersect, in, in2"
    inputBinding:
      position: 101
      prefix: -mode
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
