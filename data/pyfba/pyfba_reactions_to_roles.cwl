cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfba
  - reactions_to_roles
label: pyfba_reactions_to_roles
doc: "Given a file with a set of reactions, write the roles that implement those reactions\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs:
  - id: reactions
    type: File
    doc: "A list of the reactions you have, one per line"
    inputBinding:
      position: 1
      prefix: --reactions
  - id: output_path
    type: string
    doc: "file to save the reaction/role table to"
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
    doc: "Tab-separated reaction id and role"
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
stdout: pyfba_reactions_to_roles.out
