cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biom
  - normalize-table
label: biom-format_normalize_table
doc: "Normalize the values of a BIOM table through various methods.\n\nTool homepage: http://www.biom-format.org"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_fp
    type: File
    doc: The input BIOM table
    inputBinding:
      position: 101
      prefix: --input-fp
  - id: output_fp
    type:
      - 'null'
      - string
    doc: An output file-path
    inputBinding:
      position: 101
      prefix: --output-fp
  - id: relative_abund
    type:
      - 'null'
      - boolean
    doc: convert table to relative abundance
    inputBinding:
      position: 101
      prefix: --relative-abund
  - id: presence_absence
    type:
      - 'null'
      - boolean
    doc: convert table to presence/absence
    inputBinding:
      position: 101
      prefix: --presence-absence
  - id: axis
    type:
      - 'null'
      - string
    doc: The axis to normalize over (sample, observation)
    inputBinding:
      position: 101
      prefix: --axis
outputs:
  - id: output_table
    type:
      - 'null'
      - File
    doc: The normalized BIOM table
    outputBinding:
      glob: '$(inputs.output_fp ? inputs.output_fp : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biom-format:2.1.15
