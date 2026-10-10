cwlVersion: v1.2
class: CommandLineTool
baseCommand: mp3treesim
label: mp3treesim
doc: "MP3 tree similarity measure. Computes the similarity of two trees (in DOT/GV
  format) and prints it to standard output.\n\nTool homepage: https://algolab.github.io/mp3treesim/"
inputs:
  - id: tree1
    type: File
    doc: Path to the first tree
    inputBinding:
      position: 1
  - id: tree2
    type: File
    doc: Path to the second tree
    inputBinding:
      position: 2
  - id: intersection_mode
    type:
      - 'null'
      - boolean
    doc: Run MP3-treesim in Intersection mode.
    inputBinding:
      position: 101
      prefix: -i
  - id: union_mode
    type:
      - 'null'
      - boolean
    doc: Run MP3-treesim in Union mode.
    inputBinding:
      position: 101
      prefix: -u
  - id: geometric_mode
    type:
      - 'null'
      - boolean
    doc: Run MP3-treesim in Geometric mode.
    inputBinding:
      position: 101
      prefix: -g
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to be used in computation.
    inputBinding:
      position: 101
      prefix: --cores
  - id: labeled_only
    type:
      - 'null'
      - boolean
    doc: Ingore nodes without "label" attribute. The trees will be interpred as
      partially-label trees.
    inputBinding:
      position: 101
      prefix: --labeled-only
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: String(s) of comma separated labels to exclude from computation. If
      only one string is provided the labels will be excluded from both trees.
      If two strings are provided they will be excluded from the respective
      tree.
    inputBinding:
      position: 102
      prefix: --exclude
outputs:
  - id: stdout
    type: stdout
    doc: Similarity value printed by the tool
stdout: mp3treesim.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mp3treesim:1.0.6--py_0
