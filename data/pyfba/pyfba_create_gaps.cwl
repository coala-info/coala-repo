cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfba
label: pyfba_create_gaps
doc: "Import a list of reactions and then iterate through testing eachreaction to
  see if the model can still grow\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs:
  - id: flux_fraction
    type:
      - 'null'
      - float
    doc: Flux fraction to consider grwoth. By default we use any flux but you 
      can set it to e.g. 0.75 of the initial flux
    inputBinding:
      position: 101
      prefix: --flux_fraction
  - id: log
    type:
      - 'null'
      - File
    doc: log file to write the detailed output (optional)
    inputBinding:
      position: 101
      prefix: --log
  - id: media
    type: string
    doc: media name
    inputBinding:
      position: 101
      prefix: --media
  - id: reactions
    type: File
    doc: reactions file
    inputBinding:
      position: 101
      prefix: --reactions
  - id: type
    type:
      - 'null'
      - string
    doc: organism type for the model (currently allowed are ['gramnegative', 
      'grampositive', 'microbial', 'mycobacteria', 'plant'])
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
    doc: file to save new reaction list to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
