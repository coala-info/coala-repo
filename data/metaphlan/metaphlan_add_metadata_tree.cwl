cwlVersion: v1.2
class: CommandLineTool
baseCommand: add_metadata_tree.py
label: metaphlan_add_metadata_tree
doc: "Add sample metadata to the nodes of a tree (writes <tree>.metadata).\n\nTool homepage: https://github.com/biobakery/metaphlan"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.ifn_trees)
inputs:
  - id: ifn_trees
    type:
      type: array
      items: File
    doc: "The input trees (staged writable: the output <tree>.metadata is written beside each tree)"
    inputBinding:
      position: 101
      prefix: "--ifn_trees"
  - id: ifn_metadatas
    type:
      type: array
      items: File
    doc: "The input metadata files"
    inputBinding:
      position: 101
      prefix: "--ifn_metadatas"
  - id: string_to_remove
    type:
      - 'null'
      - string
    doc: "string to be removed in the tree node names"
    inputBinding:
      position: 101
      prefix: "--string_to_remove"
  - id: metadatas
    type:
      - 'null'
      - type: array
        items: string
    doc: "The metadata fields that you want to add. Default: add all metadata from the first line."
    inputBinding:
      position: 101
      prefix: "--metadatas"
outputs:
  - id: tree_metadata
    type:
      type: array
      items: File
    doc: "Tree metadata files"
    outputBinding:
      glob: "*.metadata"
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphlan:4.2.4--pyhdfd78af_0
stdout: metaphlan_add_metadata_tree.out
