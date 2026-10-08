cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfba
  - fba
label: pyfba_fba
doc: "Run Flux Balance Analysis and calculate reaction fluxes\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs:
  - id: reactions
    type: File
    doc: "A list of the reactions in this model, one per line"
    inputBinding:
      position: 1
      prefix: --reactions
  - id: media
    type: string
    doc: "media name (a predefined PyFBA media name or a media file path)"
    inputBinding:
      position: 1
      prefix: --media
  - id: type
    type:
      - 'null'
      - string
    doc: "organism type for the model (currently allowed are ['gramnegative', 'grampositive', 'microbial', 'mycobacteria', 'plant']). Default=gramnegative"
    inputBinding:
      position: 1
      prefix: --type
  - id: biomass
    type:
      - 'null'
      - string
    doc: "biomass equation to use. Default is the same as --type option"
    inputBinding:
      position: 1
      prefix: --biomass
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose output"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
stdout: pyfba_fba.out
