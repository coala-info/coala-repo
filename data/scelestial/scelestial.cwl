cwlVersion: v1.2
class: CommandLineTool
baseCommand: scelestial
label: scelestial
doc: "Scelestial considers all k-subsets of samples for min-k <= k <= max-k.\n\nTool
  homepage: https://github.com/hzi-bifo/scelestial-paper-materials-devel"
inputs:
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: include_root
    type:
      - 'null'
      - string
    doc: Adds a sample with all sites equal to arg as root of the tree.
    inputBinding:
      position: 102
      prefix: -include-root
  - id: max_k
    type:
      - 'null'
      - int
    doc: Sets max-k to arg. Scelestial considers all k-subsets of samples for 
      min-k <= k <= max-k.
    default: 4
    inputBinding:
      position: 102
      prefix: -max-k
  - id: min_k
    type:
      - 'null'
      - int
    doc: Sets min-k to arg. Scelestial considers all k-subsets of samples for 
      min-k <= k <= max-k.
    default: 3
    inputBinding:
      position: 102
      prefix: -min-k
  - id: no_internal_sample
    type:
      - 'null'
      - boolean
    doc: Move all samples to leaf nodes. If -root is also present, a neighbor of
      root-index is chosen as the root.
    inputBinding:
      position: 102
      prefix: -no-internal-sample
  - id: root
    type:
      - 'null'
      - int
    doc: Zero-based index of the new root. After inferring the tree, tree edges 
      are directed toward new root. In the output line "u v w" u is the parent 
      and v is the child node.
    inputBinding:
      position: 102
      prefix: -root
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scelestial:1.2--h9948957_4
