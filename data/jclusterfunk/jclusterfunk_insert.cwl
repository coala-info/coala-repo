cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jclusterfunk
  - insert
label: jclusterfunk_insert
doc: "Insert tips into the tree.\n\nTool homepage: https://github.com/snake-flu/jclusterfunk"
inputs:
  - id: destination_column
    type:
      - 'null'
      - string
    doc: metadata column for destination to insert tips
    inputBinding:
      position: 101
      prefix: --destination-column
  - id: field_delimiter
    type:
      - 'null'
      - string
    doc: "the delimiter used to specify fields in the tip labels (default = '|')"
    inputBinding:
      position: 101
      prefix: --field-delimiter
  - id: format
    type:
      - 'null'
      - string
    doc: output file format (nexus or newick)
    inputBinding:
      position: 101
      prefix: --format
  - id: id_column
    type:
      - 'null'
      - string
    doc: metadata column to use to match tip labels (default first column)
    inputBinding:
      position: 101
      prefix: --id-column
  - id: id_field
    type:
      - 'null'
      - int
    doc: tip label field to use to match metadata (default = whole label)
    inputBinding:
      position: 101
      prefix: --id-field
  - id: ignore_missing
    type:
      - 'null'
      - boolean
    doc: ignore any missing matches in annotations table (default false)
    inputBinding:
      position: 101
      prefix: --ignore-missing
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
  - id: unique_only
    type:
      - 'null'
      - boolean
    doc: only place tips that have an unique position (default false)
    inputBinding:
      position: 101
      prefix: --unique-only
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
