cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clusterfunk
  - phylotype
label: clusterfunk_phylotype
doc: "Assign phylotypes to a tree based on branch length thresholds.\n\nTool homepage:
  https://github.com/cov-ert/clusterfunk"
inputs:
  - id: collapse_to_polytomies
    type:
      - 'null'
      - float
    doc: A optional flag to collapse branches with length <= the input before 
      running the rule.
    inputBinding:
      position: 101
      prefix: --collapse_to_polytomies
  - id: format
    type:
      - 'null'
      - string
    doc: what format is the tree file. This is passed to dendropy. default is 
      'nexus'
    default: nexus
    inputBinding:
      position: 101
      prefix: --format
  - id: input_tree
    type: File
    doc: The input tree file. Format can be specified with the format flag.
    inputBinding:
      position: 101
      prefix: --input
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for each phylotype.
    default: p
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threshold
    type:
      - 'null'
      - float
    doc: branch threshold used to distinguish new phylotype
    default: '5E-6'
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: output_tree
    type: File
    doc: The output file
    outputBinding:
      glob: $(inputs.output_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
