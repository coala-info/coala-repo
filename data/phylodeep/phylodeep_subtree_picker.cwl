cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - subtree_picker
label: phylodeep_subtree_picker
doc: "Cuts the given tree into subtrees within a given size (s) range: min_size <= s <= max_size.\n\nTool homepage: https://github.com/evolbioinfo/phylodeep"
inputs:
  - id: in_nwk
    type: File
    doc: "input tree in newick format (must be rooted, without polytomies and containing at least --min_size tips)."
    inputBinding:
      position: 1
      prefix: "--in_nwk"
  - id: out_nwk_path
    type: string
    doc: "output newick file to store the generated subtrees."
    inputBinding:
      position: 2
      prefix: "--out_nwk"
  - id: min_size
    type:
      - 'null'
      - int
    doc: "minimal number of tips for a subtree (inclusive)."
    inputBinding:
      position: 3
      prefix: "--min_size"
  - id: max_size
    type:
      - 'null'
      - int
    doc: "maximal number of tips for a subtree (inclusive)."
    inputBinding:
      position: 4
      prefix: "--max_size"
outputs:
  - id: out_nwk
    type:
      - 'null'
      - File
    doc: "Subtrees in newick format"
    outputBinding:
      glob: "$(inputs.out_nwk_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylodeep:0.9--pyhdfd78af_0
