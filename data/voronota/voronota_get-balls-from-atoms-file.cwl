cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_get-balls-from-atoms-file
label: voronota_get-balls-from-atoms-file
doc: "Reads atoms from a PDB or mmCIF file and computes Voronoi tessellation balls.\n\
  \nTool homepage: https://www.voronota.com/"
inputs:
  - id: input_file
    type: File
    doc: file in PDB or mmCIF format
    inputBinding:
      position: 1
  - id: annotated
    type:
      - 'null'
      - boolean
    doc: flag to enable annotated mode
    inputBinding:
      position: 102
      prefix: --annotated
  - id: default_radius
    type:
      - 'null'
      - float
    doc: default atomic radius
    inputBinding:
      position: 102
      prefix: --default-radius
  - id: hull_offset
    type:
      - 'null'
      - float
    doc: positive offset distance enables adding artificial hull balls
    inputBinding:
      position: 102
      prefix: --hull-offset
  - id: include_heteroatoms
    type:
      - 'null'
      - boolean
    doc: flag to include heteroatoms
    inputBinding:
      position: 102
      prefix: --include-heteroatoms
  - id: include_hydrogens
    type:
      - 'null'
      - boolean
    doc: flag to include hydrogen atoms
    inputBinding:
      position: 102
      prefix: --include-hydrogens
  - id: input_format
    type:
      - 'null'
      - string
    doc: "input format, variants are: 'pdb' (default), 'mmcif', 'detect'"
    inputBinding:
      position: 102
      prefix: --input-format
  - id: multimodel_chains
    type:
      - 'null'
      - boolean
    doc: flag to read multiple models in PDB format and rename chains 
      accordingly
    inputBinding:
      position: 102
      prefix: --multimodel-chains
  - id: only_default_radius
    type:
      - 'null'
      - boolean
    doc: flag to make all radii equal to the default radius
    inputBinding:
      position: 102
      prefix: --only-default-radius
  - id: radii_file
    type:
      - 'null'
      - File
    doc: path to radii configuration file
    inputBinding:
      position: 102
      prefix: --radii-file
outputs:
  - id: output_balls
    type:
      - 'null'
      - File
    doc: list of balls
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
