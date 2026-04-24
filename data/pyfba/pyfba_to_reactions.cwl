cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfba
label: pyfba_to_reactions
doc: "Convert a set of functions or roles to a list of reactions\n\nTool homepage:
  https://linsalrob.github.io/PyFBA/"
inputs:
  - id: assigned_functions
    type:
      - 'null'
      - File
    doc: "RAST assigned functions role (tab separated\n                        PEG/Functional
      Role)"
    inputBinding:
      position: 101
      prefix: --assigned_functions
  - id: features
    type:
      - 'null'
      - File
    doc: PATRIC features.txt file (with 5 columns)
    inputBinding:
      position: 101
      prefix: --features
  - id: roles
    type:
      - 'null'
      - File
    doc: A list of functional roles in this genome, one per line
    inputBinding:
      position: 101
      prefix: --roles
  - id: type
    type:
      - 'null'
      - string
    doc: "organism type for the model (currently allowed are\n                   \
      \     ['gramnegative', 'grampositive', 'microbial',\n                      \
      \  'mycobacteria', 'plant']). Default=gramnegative"
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
