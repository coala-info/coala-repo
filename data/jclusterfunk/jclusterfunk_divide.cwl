cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jclusterfunk
  - divide
label: jclusterfunk_divide
doc: "Divide tree into approximately equal sized subtrees.\n\nTool homepage: https://github.com/snake-flu/jclusterfunk"
inputs:
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
  - id: input_file
    type: File
    doc: input tree file
    inputBinding:
      position: 101
      prefix: --input
  - id: max_count
    type:
      - 'null'
      - int
    doc: maximum number of subtrees
    inputBinding:
      position: 101
      prefix: --max-count
  - id: min_size
    type:
      - 'null'
      - int
    doc: minimum number of tips in a subtree
    inputBinding:
      position: 101
      prefix: --min-size
  - id: output_path
    type:
      - 'null'
      - string
    doc: output path (an existing directory, default = current directory)
    inputBinding:
      position: 101
      prefix: --output
  - id: require_outgroup
    type:
      - 'null'
      - boolean
    doc: only divide subtrees where the representative is an outgroup (default false)
    inputBinding:
      position: 101
      prefix: --require-outgroup
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
    doc: subtree files and the subtree table
    outputBinding:
      glob: "$((inputs.output_path ? inputs.output_path + '/' : '') + inputs.file_prefix + '*')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.output_path ? [{entryname: inputs.output_path, entry: {class: 'Directory', listing: []}, writable: true}] : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
