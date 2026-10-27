cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - voronota
  - get-balls-from-atoms-file
label: voronota_get-balls-from-atoms-file
doc: "Reads atoms from a PDB or mmCIF file and writes the list of balls.

Tool homepage: https://www.voronota.com/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_atoms
    type: File
    doc: "PDB or mmCIF atoms file (stdin)"
  - id: annotated
    type:
      - 'null'
      - boolean
    doc: "flag to enable annotated mode"
    inputBinding:
      position: 101
      prefix: --annotated
  - id: include_heteroatoms
    type:
      - 'null'
      - boolean
    doc: "flag to include heteroatoms"
    inputBinding:
      position: 101
      prefix: --include-heteroatoms
  - id: include_hydrogens
    type:
      - 'null'
      - boolean
    doc: "flag to include hydrogen atoms"
    inputBinding:
      position: 101
      prefix: --include-hydrogens
  - id: multimodel_chains
    type:
      - 'null'
      - boolean
    doc: "flag to read multiple models in PDB format and rename chains accordingly"
    inputBinding:
      position: 101
      prefix: --multimodel-chains
  - id: input_format
    type:
      - 'null'
      - string
    doc: "input format, variants are: 'pdb' (default), 'mmcif', 'detect'"
    inputBinding:
      position: 101
      prefix: --input-format
  - id: radii_file
    type:
      - 'null'
      - string
    doc: "path to radii configuration file"
    inputBinding:
      position: 101
      prefix: --radii-file
  - id: default_radius
    type:
      - 'null'
      - float
    doc: "default atomic radius"
    inputBinding:
      position: 101
      prefix: --default-radius
  - id: only_default_radius
    type:
      - 'null'
      - boolean
    doc: "flag to make all radii equal to the default radius"
    inputBinding:
      position: 101
      prefix: --only-default-radius
  - id: hull_offset
    type:
      - 'null'
      - float
    doc: "positive offset distance enables adding artificial hull balls"
    inputBinding:
      position: 101
      prefix: --hull-offset
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdin: $(inputs.input_atoms.path)
stdout: voronota_get-balls-from-atoms-file.out
