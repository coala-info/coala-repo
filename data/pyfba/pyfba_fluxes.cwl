cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfba
label: pyfba_fluxes
doc: "Run Flux Balance Analysis and calculate reaction fluxes\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs:
  - id: biomass
    type:
      - 'null'
      - string
    doc: biomass equation to use
    default: the same as --type option
    inputBinding:
      position: 101
      prefix: --biomass
  - id: media
    type: string
    doc: media name
    inputBinding:
      position: 101
      prefix: --media
  - id: reactions
    type: File
    doc: A list of the reactions in this model, one per line
    inputBinding:
      position: 101
      prefix: --reactions
  - id: type
    type:
      - 'null'
      - string
    doc: organism type for the model (currently allowed are ['gramnegative', 
      'grampositive', 'microbial', 'mycobacteria', 'plant'])
    default: gramnegative
    inputBinding:
      position: 101
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: file to save the fluxes list to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
