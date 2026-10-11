cwlVersion: v1.2
class: CommandLineTool
baseCommand: abimetadata
label: nim-abif_abimetadata
doc: "Display and modify metadata in ABIF files.\n\nTool homepage: https://github.com/quadram-institute-bioscience/nim-abif"
inputs:
  - id: input_ab1
    type: File
    doc: Input ABIF file (.ab1)
    inputBinding:
      position: 1
  - id: list
    type:
      - 'null'
      - boolean
    doc: List all metadata fields (default if no other option specified)
    inputBinding:
      position: 2
      prefix: --list
  - id: tag
    type:
      - 'null'
      - string
    doc: Tag name to view or edit (e.g., "SMPL1")
    inputBinding:
      position: 2
      prefix: --tag=
      separate: false
  - id: value
    type:
      - 'null'
      - string
    doc: New value for tag when editing (use empty string to remove)
    inputBinding:
      position: 2
      prefix: --value=
      separate: false
  - id: output
    type:
      - 'null'
      - string
    doc: Output file for modified ABI file (required when editing)
    inputBinding:
      position: 2
      prefix: --output=
      separate: false
  - id: limit
    type:
      - 'null'
      - int
    doc: Limit number of tags displayed (default all)
    inputBinding:
      position: 2
      prefix: --limit=
      separate: false
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Show additional debug information
    inputBinding:
      position: 2
      prefix: --debug
outputs:
  - id: metadata
    type: stdout
    doc: Metadata table written to standard output
  - id: modified_ab1
    type:
      - 'null'
      - File
    doc: Modified ABIF file (when editing a tag)
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nim-abif:0.2.0--h7b50bb2_0
stdout: nim-abif_abimetadata.txt
