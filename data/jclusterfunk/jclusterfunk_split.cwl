cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jclusterfunk
  - split
label: jclusterfunk_split
doc: "Split out subtrees based on tip annotations.\n\nTool homepage: https://github.com/snake-flu/jclusterfunk"
inputs:
  - id: attribute
    type: string
    doc: the attribute name
    inputBinding:
      position: 101
      prefix: --attribute
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
  - id: output_path
    type:
      - 'null'
      - string
    doc: output path (an existing directory, default = current directory)
    inputBinding:
      position: 101
      prefix: --output
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
    doc: subtree files
    outputBinding:
      glob: "$((inputs.output_path ? inputs.output_path + '/' : '') + inputs.file_prefix + '*')"
  - id: output_metadata_file
    type:
      - 'null'
      - File
    doc: metadata file matching the output tree
    outputBinding:
      glob: $(inputs.output_metadata)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.output_path ? [{entryname: inputs.output_path, entry: {class: 'Directory', listing: []}, writable: true}] : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
