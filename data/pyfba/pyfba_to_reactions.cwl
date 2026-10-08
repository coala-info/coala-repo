cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfba
  - to_reactions
label: pyfba_to_reactions
doc: "Convert a set of functions or roles to a list of reactions (give exactly one of roles, assigned_functions or features)\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs:
  - id: roles
    type:
      - 'null'
      - File
    doc: "A list of functional roles in this genome, one per line"
    inputBinding:
      position: 1
      prefix: --roles
  - id: assigned_functions
    type:
      - 'null'
      - File
    doc: "RAST assigned functions (tab separated PEG/Functional Role)"
    inputBinding:
      position: 1
      prefix: --assigned_functions
  - id: features
    type:
      - 'null'
      - File
    doc: "PATRIC features.txt file (with 5 columns)"
    inputBinding:
      position: 1
      prefix: --features
  - id: output_path
    type: string
    doc: "file to save new reaction list to"
    inputBinding:
      position: 1
      prefix: --output
  - id: type
    type:
      - 'null'
      - string
    doc: "organism type for the model (currently allowed are ['gramnegative', 'grampositive', 'microbial', 'mycobacteria', 'plant']). Default=gramnegative"
    inputBinding:
      position: 1
      prefix: --type
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
  - id: output
    type: File
    doc: "Reaction list"
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
stdout: pyfba_to_reactions.out
