cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - augur
  - lbi
label: augur_lbi
doc: "Calculate LBI for a given tree and one or more sets of parameters.\n\nTool homepage:
  https://github.com/nextstrain/augur"
inputs:
  - id: attribute_names
    type:
      type: array
      items: string
    doc: names to store distances associated with the corresponding masks
    inputBinding:
      position: 101
      prefix: --attribute-names
  - id: branch_lengths
    type: File
    doc: JSON with branch lengths and internal node dates estimated by TreeTime
    inputBinding:
      position: 101
      prefix: --branch-lengths
  - id: no_normalization
    type:
      - 'null'
      - boolean
    doc: disable normalization of LBI by the maximum value
    inputBinding:
      position: 101
      prefix: --no-normalization
  - id: tau
    type:
      type: array
      items: float
    doc: tau value(s) defining the neighborhood of each clade
    inputBinding:
      position: 101
      prefix: --tau
  - id: tree
    type: File
    doc: Newick tree
    inputBinding:
      position: 101
      prefix: --tree
  - id: window
    type:
      type: array
      items: float
    doc: time window(s) to calculate LBI across
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output
    type: File
    doc: JSON file with calculated distances stored by node name and attribute 
      name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
