cwlVersion: v1.2
class: CommandLineTool
baseCommand: pdbfixer
label: pdbfixer
doc: "Fix problems in PDB files, such as adding missing atoms or residues, replacing
  nonstandard residues, and removing heterogens.\n\nTool homepage: https://github.com/openmm/pdbfixer"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: The input PDB file to be fixed (leave out when --pdbid or --url is used).
    inputBinding:
      position: 1
  - id: add_atoms
    type:
      - 'null'
      - string
    doc: 'Which missing atoms to add: all, heavy, hydrogen, or none.'
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
    inputBinding:
      position: 102
      prefix: --keep-heterogens
  - id: ph
    type:
      - 'null'
      - float
    doc: The pH to use for adding hydrogens.
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
  - id: ionic_strength
    type:
      - 'null'
      - float
    doc: Molar concentration of ions to add to the water box.
    inputBinding:
      position: 102
      prefix: --ionic-strength
  - id: negative_ion
    type:
      - 'null'
      - string
    doc: 'Negative ion to include in the water box: Cl-, Br-, F-, or I-.'
    inputBinding:
      position: 102
      prefix: --negative-ion
  - id: pdbid
    type:
      - 'null'
      - string
    doc: PDB id to retrieve from RCSB (needs network access; give instead of an input file).
    inputBinding:
      position: 102
      prefix: --pdbid
  - id: positive_ion
    type:
      - 'null'
      - string
    doc: 'Positive ion to include in the water box: Cs+, K+, Li+, Na+, or Rb+.'
    inputBinding:
      position: 102
      prefix: --positive-ion
  - id: url
    type:
      - 'null'
      - string
    doc: URL to retrieve a PDB file from (needs network access).
    inputBinding:
      position: 102
      prefix: --url
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: water_box
    type:
      - 'null'
      - type: array
        items: float
    doc: Add a water box. The value is the box dimensions in nm (X Y Z).
    inputBinding:
      position: 102
      prefix: --water-box
  - id: output_path
    type: string
    doc: Output pdb file name.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The name of the file to write the fixed PDB to.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pdbfixer:1.8.1
