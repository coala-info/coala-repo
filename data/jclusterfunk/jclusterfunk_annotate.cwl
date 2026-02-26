cwlVersion: v1.2
class: CommandLineTool
baseCommand: jclusterfunk annotate
label: jclusterfunk_annotate
doc: "Annotate tips and nodes from a metadata table.\n\nTool homepage: https://github.com/snake-flu/jclusterfunk"
inputs:
  - id: field_delimiter
    type:
      - 'null'
      - string
    doc: the delimiter used to specify fields in the tip labels
    default: '|'
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
    doc: metadata column to use to match tip labels
    default: first column
    inputBinding:
      position: 101
      prefix: --id-column
  - id: id_field
    type:
      - 'null'
      - int
    doc: tip label field to use to match metadata
    default: whole label
    inputBinding:
      position: 101
      prefix: --id-field
  - id: ignore_missing
    type:
      - 'null'
      - boolean
    doc: ignore any missing matches in annotations table
    default: false
    inputBinding:
      position: 101
      prefix: --ignore-missing
  - id: input_file
    type: File
    doc: input tree file
    inputBinding:
      position: 101
      prefix: --input
  - id: label_fields
    type:
      - 'null'
      - type: array
        items: string
    doc: a list of metadata columns to add as tip label fields
    inputBinding:
      position: 101
      prefix: --label-fields
  - id: metadata
    type: File
    doc: input metadata file
    inputBinding:
      position: 101
      prefix: --metadata
  - id: replace
    type:
      - 'null'
      - boolean
    doc: replace the annotations or tip label headers rather than appending
    default: false
    inputBinding:
      position: 101
      prefix: --replace
  - id: tip_attributes
    type:
      - 'null'
      - type: array
        items: string
    doc: a list of metadata columns to add as tip attributes
    inputBinding:
      position: 101
      prefix: --tip-attributes
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: write analysis details to console
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
