cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jclusterfunk
  - merge
label: jclusterfunk_merge
doc: "Merge two metadata tables\n\nTool homepage: https://github.com/snake-flu/jclusterfunk"
inputs:
  - id: add_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: a list of metadata columns to add
    inputBinding:
      position: 101
      prefix: --add-columns
  - id: extract
    type:
      - 'null'
      - boolean
    doc: extract only the matching rows (default false)
    inputBinding:
      position: 101
      prefix: --extract
  - id: id_column
    type:
      - 'null'
      - string
    doc: metadata column to use to match tip labels (default first column)
    inputBinding:
      position: 101
      prefix: --id-column
  - id: input_file
    type: File
    doc: input tree file
    inputBinding:
      position: 101
      prefix: --input
  - id: metadata
    type: File
    doc: input metadata file
    inputBinding:
      position: 101
      prefix: --metadata
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: overwrite existing values (default false)
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: write analysis details to console
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: output file
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_file
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
