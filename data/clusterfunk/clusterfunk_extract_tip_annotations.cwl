cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clusterfunk
  - extract_annotations
label: clusterfunk_extract_tip_annotations
doc: "Extract tip annotations from a phylogenetic tree file into a CSV.\n\nTool homepage:
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
  - id: input
    type: File
    doc: The input tree file. Format can be specified with the format flag.
    inputBinding:
      position: 101
      prefix: --input
  - id: traits
    type:
      - 'null'
      - type: array
        items: string
    doc: Space separated list of traits to extract from tips
    inputBinding:
      position: 101
      prefix: --traits
outputs:
  - id: output
    type: File
    doc: The output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
