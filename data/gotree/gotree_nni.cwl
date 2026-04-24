cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - nni
label: gotree_nni
doc: "Perform Nearest Neighbor Interchange (NNI) rearrangement on a tree.\n\nTool
  homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: input_tree
    type: File
    doc: Input tree file (e.g., Newick format)
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: Format of the input and output tree files (e.g., newick, nexus)
    inputBinding:
      position: 102
      prefix: --format
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of NNI iterations to perform
    inputBinding:
      position: 102
      prefix: --iterations
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for NNI rearrangements
    inputBinding:
      position: 102
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_tree
    type:
      - 'null'
      - File
    doc: Output tree file (e.g., Newick format)
    outputBinding:
      glob: $(inputs.output_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
