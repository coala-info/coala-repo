cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - download
  - itol
label: gotree_download_itol
doc: "Download a tree image/file from iTOL.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: "Itol image config file"
    inputBinding:
      position: 101
      prefix: --config
  - id: output_file_path
    type: string
    doc: "Tree output file"
    inputBinding:
      position: 101
      prefix: --output
  - id: tree_id
    type: string
    doc: "Tree id to download"
    inputBinding:
      position: 101
      prefix: --tree-id
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random Seed: -1 = nano seconds since 1970/01/01 00:00:00"
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (Max=20)"
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: "Output file written to the path in output_file_path"
    outputBinding:
      glob: "$(inputs.output_file_path)"
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
