cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pairtools
  - header
label: pairtools_header
doc: "Manipulate the .pairs/.pairsam header\n\nTool homepage: https://github.com/mirnylab/pairtools"
inputs:
  - id: generate
    type:
      - 'null'
      - boolean
    doc: Generate the header
    inputBinding:
      position: 101
  - id: set_columns
    type:
      - 'null'
      - boolean
    doc: Add the columns to the .pairs/pairsam file
    inputBinding:
      position: 101
  - id: transfer
    type:
      - 'null'
      - boolean
    doc: Transfer the header from one pairs file to another
    inputBinding:
      position: 101
  - id: validate_columns
    type:
      - 'null'
      - boolean
    doc: Validate the columns of the .pairs/pairsam file...
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
stdout: pairtools_header.out
