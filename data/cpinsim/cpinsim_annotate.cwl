cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpinsim_annotate
label: cpinsim_annotate
doc: "Annotates interaction, competition, and allosteric effect files based on provided
  constraints and network information.\n\nTool homepage: https://github.com/BiancaStoecker/cpinsim"
inputs:
  - id: allosteric_effects
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Files containing the allosteric effects. Four columns: Host | Interactor
      | Activator | Inhibitor'
    inputBinding:
      position: 101
      prefix: --allosteric_effects
  - id: competitions
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Files containing the competitions. Two columns: Host | Competitors (comma
      separated)'
    inputBinding:
      position: 101
      prefix: --competitions
  - id: extended_inference
    type:
      - 'null'
      - boolean
    doc: Extended inference for missing domains in competitions.
    inputBinding:
      position: 101
      prefix: --extended_inference
  - id: interactions_without_constraints
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Files containing the underlying network: pairwise interactions without constraints.
      Two columns InteractorA | InteractorB'
    inputBinding:
      position: 101
      prefix: --interactions_without_constraints
  - id: output_allosterics_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_allosterics_path`
    inputBinding:
      position: 102
      prefix: --output-allosterics
  - id: output_competitions_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_competitions_path`
    inputBinding:
      position: 103
      prefix: --output-competitions
  - id: output_interactions_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_interactions_path`
    inputBinding:
      position: 104
      prefix: --output-interactions
outputs:
  - id: output_interactions
    type:
      - 'null'
      - File
    doc: One output file containing all annotated pairwise interactions.
    outputBinding:
      glob: $(inputs.output_interactions_path)
  - id: output_competitions
    type:
      - 'null'
      - File
    doc: One output file containing all annotated competitions.
    outputBinding:
      glob: $(inputs.output_competitions_path)
  - id: output_allosterics
    type:
      - 'null'
      - File
    doc: One output file containing all annotated allosteric effects.
    outputBinding:
      glob: $(inputs.output_allosterics_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpinsim:0.5.2--py36_1
