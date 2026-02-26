cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clusterfunk
  - graft
label: clusterfunk_graft
doc: "Graft incoming trees onto an input guide tree.\n\nTool homepage: https://github.com/cov-ert/clusterfunk"
inputs:
  - id: annotate_scions
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of annotation values to add to the scion trees in the same order
      the trees are listed.
    inputBinding:
      position: 101
      prefix: --annotate_scions
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
  - id: full_graft
    type:
      - 'null'
      - boolean
    doc: A boolean flag to remove any remaining original tips from the guide 
      tree that were not found in anyscion tree. i.e. all tips in the output 
      tree come from the scions
    inputBinding:
      position: 101
      prefix: --full_graft
  - id: input
    type: File
    doc: The input tree file. Format can be specified with the format flag.
    inputBinding:
      position: 101
      prefix: --input
  - id: scion
    type:
      - 'null'
      - type: array
        items: File
    doc: The incoming trees that will be grafted onto the input tree
    inputBinding:
      position: 101
      prefix: --scion
  - id: scion_annotation_name
    type:
      - 'null'
      - string
    doc: 'the annotation name to be used in annotation each scion. default: scion_id'
    default: scion_id
    inputBinding:
      position: 101
      prefix: --scion_annotation_name
outputs:
  - id: output
    type: File
    doc: The output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
