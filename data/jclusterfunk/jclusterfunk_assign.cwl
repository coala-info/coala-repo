cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jclusterfunk
  - assign
label: jclusterfunk_assign
doc: "Clean and assign lineage annotations.\n\nTool homepage: https://github.com/snake-flu/jclusterfunk"
inputs:
  - id: attribute
    type: string
    doc: the attribute name
    inputBinding:
      position: 101
      prefix: --attribute
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
  - id: out_attribute
    type:
      - 'null'
      - string
    doc: the new attribute name in output
    inputBinding:
      position: 101
      prefix: --out-attribute
  - id: output_metadata
    type:
      - 'null'
      - string
    doc: output a metadata file to match the output tree
    inputBinding:
      position: 101
      prefix: --output-metadata
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
  - id: output_metadata_file
    type:
      - 'null'
      - File
    doc: metadata file matching the output tree
    outputBinding:
      glob: $(inputs.output_metadata)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
