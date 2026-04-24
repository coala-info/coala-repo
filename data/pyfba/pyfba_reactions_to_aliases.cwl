cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfba
label: pyfba_reactions_to_aliases
doc: "Get the roles associated with a file of reactions\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs:
  - id: reactions
    type:
      - 'null'
      - File
    doc: A list of the reactions you have, one per line
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
