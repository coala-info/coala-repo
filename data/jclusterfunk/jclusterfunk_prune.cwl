cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jclusterfunk
  - prune
label: jclusterfunk_prune
doc: "Prune out taxa from a list or based on metadata.\n\nTool homepage: https://github.com/snake-flu/jclusterfunk"
inputs:
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
  - id: keep_taxa
    type:
      - 'null'
      - boolean
    doc: keep only the taxa specifed (default false)
    inputBinding:
      position: 101
      prefix: --keep-taxa
  - id: metadata
    type:
      - 'null'
      - File
    doc: input metadata file
    inputBinding:
      position: 101
      prefix: --metadata
  - id: output_metadata
    type:
      - 'null'
      - string
    doc: output a metadata file to match the output tree
    inputBinding:
      position: 101
      prefix: --output-metadata
  - id: taxa
    type:
      - 'null'
      - type: array
        items: string
    doc: a list of taxon ids
    inputBinding:
      position: 101
      prefix: --taxa
  - id: taxon_file
    type:
      - 'null'
      - File
    doc: file of taxa (in a CSV table or tree)
    inputBinding:
      position: 101
      prefix: --taxon-file
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
