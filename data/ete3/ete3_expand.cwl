cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ete3
  - expand
label: ete3_expand
doc: "Expand a tree with new sequences\n\nTool homepage: http://etetoolkit.org/"
inputs:
  - id: tree_file
    type: File
    doc: Input tree file
    inputBinding:
      position: 1
  - id: sequences
    type:
      type: array
      items: File
    doc: Input sequence files (e.g., FASTA)
    inputBinding:
      position: 2
  - id: align
    type:
      - 'null'
      - boolean
    doc: Align sequences before expanding
    inputBinding:
      position: 103
      prefix: --align
  - id: format
    type:
      - 'null'
      - string
    doc: Output tree format (e.g., newick, nexus)
    default: newick
    inputBinding:
      position: 103
      prefix: --format
  - id: method
    type:
      - 'null'
      - string
    doc: Tree building method (e.g., nj, upgma)
    default: nj
    inputBinding:
      position: 103
      prefix: --method
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress verbose output
    inputBinding:
      position: 103
      prefix: --quiet
outputs:
  - id: output_tree
    type:
      - 'null'
      - File
    doc: Output tree file
    outputBinding:
      glob: $(inputs.output_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ete3:3.1.2
