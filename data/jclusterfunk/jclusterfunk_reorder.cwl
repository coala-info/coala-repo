cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jclusterfunk
  - reorder
label: jclusterfunk_reorder
doc: "Re-order nodes in ascending or descending clade size.\n\nTool homepage: https://github.com/snake-flu/jclusterfunk"
inputs:
  - id: decreasing
    type:
      - 'null'
      - boolean
    doc: order nodes by decreasing clade size
    inputBinding:
      position: 101
      prefix: --decreasing
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
  - id: increasing
    type:
      - 'null'
      - boolean
    doc: order nodes by increasing clade size
    inputBinding:
      position: 101
      prefix: --increasing
  - id: input_file
    type: File
    doc: input tree file
    inputBinding:
      position: 101
      prefix: --input
  - id: metadata
    type:
      - 'null'
      - File
    doc: input metadata file
    inputBinding:
      position: 101
      prefix: --metadata
  - id: sort_by
    type:
      - 'null'
      - type: array
        items: string
    doc: a list of metadata columns to sort by (prefix by ^ to reverse order)
    inputBinding:
      position: 101
      prefix: --sort-by
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
