cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpinsim_parse
label: cpinsim_parse
doc: "Parse protein interaction data from various file formats.\n\nTool homepage:
  https://github.com/BiancaStoecker/cpinsim"
inputs:
  - id: allosteric_effects
    type:
      - 'null'
      - type: array
        items: File
    doc: Files containing the annotated allosteric effects.
    inputBinding:
      position: 101
      prefix: --allosteric_effects ALLOSTERIC_EFFECTS
  - id: competitions
    type:
      - 'null'
      - type: array
        items: File
    doc: Files containing the annotated competitions.
    inputBinding:
      position: 101
      prefix: --competitions
  - id: interactions_without_constraints
    type:
      - 'null'
      - type: array
        items: File
    doc: Files containing the annotated pairwise interactions.
    inputBinding:
      position: 101
      prefix: --interactions_without_constraints
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file containing the parsed proteins.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpinsim:0.5.2--py36_1
