cwlVersion: v1.2
class: CommandLineTool
baseCommand: pdbfixer
label: pdbfixer
doc: "Fix problems in PDB files, such as adding missing atoms or residues, replacing
  nonstandard residues, and removing heterogens.\n\nTool homepage: https://github.com/openmm/pdbfixer"
inputs:
  - id: input_file
    type: File
    doc: The input PDB file to be fixed.
    inputBinding:
      position: 1
  - id: add_atoms
    type:
      - 'null'
      - string
    doc: 'Which missing atoms to add: all, heavy, or none.'
    default: all
    inputBinding:
      position: 102
      prefix: --add-atoms
  - id: add_residues
    type:
      - 'null'
      - boolean
    doc: Add missing residues.
    inputBinding:
      position: 102
      prefix: --add-residues
  - id: keep_heterogens
    type:
      - 'null'
      - string
    doc: 'Which heterogens to keep: all, water, none, or a comma-separated list of
      IDs.'
    default: all
    inputBinding:
      position: 102
      prefix: --keep-heterogens
  - id: ph
    type:
      - 'null'
      - float
    doc: The pH to use for adding hydrogens.
    default: 7.0
    inputBinding:
      position: 102
      prefix: --ph
  - id: replace_nonstandard
    type:
      - 'null'
      - boolean
    doc: Replace nonstandard residues with standard ones.
    inputBinding:
      position: 102
      prefix: --replace-nonstandard
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The name of the file to write the fixed PDB to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pdbfixer:1.8.1
