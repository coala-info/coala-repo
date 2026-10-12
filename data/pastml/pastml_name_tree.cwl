cwlVersion: v1.2
class: CommandLineTool
baseCommand: name_tree
label: pastml_name_tree
doc: "Name internal tree nodes as PastMl would.\n\nTool homepage: https://github.com/evolbioinfo/pastml"
inputs:
  - id: in_tree
    type: File
    doc: input tree(s) in newick or nexus format (must be rooted).
    inputBinding:
      position: 101
      prefix: --in_tree
  - id: root_date
    type:
      - 'null'
      - type: array
        items: float
    doc: date(s) of the root(s) (for dated tree(s) only), if specified, the 
      corresponding dates will be added to the tree node annotations.
    inputBinding:
      position: 101
      prefix: --root_date
  - id: columns
    type:
      - 'null'
      - type: array
        items: string
    doc: names of the annotation columns of the input tree (if any) to be kept 
      in the output tree. If there are LSD2-like date-related columns (date and 
      date_CI) present in the tree, they will be kept in any case, so no need to
      specify them among columns here.
    inputBinding:
      position: 101
      prefix: --columns
  - id: out_tree_path
    type: string
    doc: path where to save the named output tree(s) in newick format.
    inputBinding:
      position: 102
      prefix: --out_tree
outputs:
  - id: out_tree
    type: File
    doc: the named output tree(s) in newick format.
    outputBinding:
      glob: $(inputs.out_tree_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastml:1.9.51--pyhdfd78af_0
