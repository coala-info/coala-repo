cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - upload
  - itol
label: gotree_upload_itol
doc: "Upload a tree to iTOL and display the access url.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: name
    type:
      - 'null'
      - string
    doc: "iTOL tree name prefix"
    inputBinding:
      position: 101
      prefix: --name
  - id: project
    type:
      - 'null'
      - string
    doc: "iTOL project to upload the tree"
    inputBinding:
      position: 101
      prefix: --project
  - id: user_id
    type:
      - 'null'
      - string
    doc: "iTOL User upload id"
    inputBinding:
      position: 101
      prefix: --user-id
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: input_tree
    type: File
    doc: "Input tree"
    inputBinding:
      position: 101
      prefix: --input
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
  - id: annotation_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "iTOL annotation files"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree_upload_itol.out
