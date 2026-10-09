cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jclusterfunk
  - sample
label: jclusterfunk_sample
doc: "Sample taxa down using metadata attributes.\n\nTool homepage: https://github.com/snake-flu/jclusterfunk"
inputs:
  - id: clump_by
    type:
      - 'null'
      - string
    doc: an attribute to clump homogenous children by
    inputBinding:
      position: 101
      prefix: --clump-by
  - id: collapse_by
    type:
      - 'null'
      - string
    doc: an attribute to collapse homogenous subtrees by
    inputBinding:
      position: 101
      prefix: --collapse-by
  - id: field_delimiter
    type:
      - 'null'
      - string
    doc: "the delimiter used to specify fields in the tip labels (default = '|')"
    inputBinding:
      position: 101
      prefix: --field-delimiter
  - id: file_prefix
    type: string
    doc: output file prefix
    inputBinding:
      position: 101
      prefix: --prefix
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
  - id: max_soft
    type:
      - 'null'
      - int
    doc: maximum number of tips in a soft collapsed node
    inputBinding:
      position: 101
      prefix: --max-soft
  - id: metadata
    type: File
    doc: input metadata file
    inputBinding:
      position: 101
      prefix: --metadata
  - id: min_clumped
    type:
      - 'null'
      - int
    doc: minimum number of tips in a clump
    inputBinding:
      position: 101
      prefix: --min-clumped
  - id: min_collapsed
    type:
      - 'null'
      - int
    doc: minimum number of tips in a collapsed subtree
    inputBinding:
      position: 101
      prefix: --min-collapsed
  - id: output_path
    type:
      - 'null'
      - string
    doc: output path (an existing directory, default = current directory)
    inputBinding:
      position: 101
      prefix: --output
  - id: taxa
    type:
      - 'null'
      - type: array
        items: string
    doc: a list of taxon ids
    inputBinding:
      position: 101
      prefix: --taxa
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: write analysis details to console
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_files
    type: File[]
    doc: sampled tree and subtree table files
    outputBinding:
      glob: "$((inputs.output_path ? inputs.output_path + '/' : '') + inputs.file_prefix + '*')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.output_path ? [{entryname: inputs.output_path, entry: {class: 'Directory', listing: []}, writable: true}] : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
