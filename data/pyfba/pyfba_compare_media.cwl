cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfba
label: pyfba_compare_media
doc: "Import a list of reactions and then compare growth on two media conditions to
  identify essential/non-essential media\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs:
  - id: negative
    type: string
    doc: media name where we should not grow
    inputBinding:
      position: 101
      prefix: --negative
  - id: positive
    type: string
    doc: media name where we should grow
    inputBinding:
      position: 101
      prefix: --positive
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
