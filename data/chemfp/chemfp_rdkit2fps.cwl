cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdkit2fps
label: chemfp_rdkit2fps
doc: "Generate FPS fingerprints from a structure file using RDKit\n\nTool homepage:
  https://chemfp.com"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input structure file (default is stdin)
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Delimiter for SMILES files
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: errors
    type:
      - 'null'
      - string
    doc: How to report errors (ignore, report, strict)
    inputBinding:
      position: 102
      prefix: --errors
  - id: format
    type:
      - 'null'
      - string
    doc: Input format (e.g. smi, sdf)
    inputBinding:
      position: 102
      prefix: --format
  - id: has_header
    type:
      - 'null'
      - boolean
    doc: Skip the first line of a SMILES file
    inputBinding:
      position: 102
      prefix: --has-header
  - id: id_column
    type:
      - 'null'
      - int
    doc: Column index for the molecule ID
    inputBinding:
      position: 102
      prefix: --id-column
  - id: maccs
    type:
      - 'null'
      - boolean
    doc: Generate MACCS fingerprints
    inputBinding:
      position: 102
      prefix: --maccs
  - id: morgan
    type:
      - 'null'
      - boolean
    doc: Generate Morgan fingerprints
    inputBinding:
      position: 102
      prefix: --morgan
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: Generate Atom Pair fingerprints
    inputBinding:
      position: 102
      prefix: --pairs
  - id: radius
    type:
      - 'null'
      - int
    doc: Radius for Morgan fingerprints
    inputBinding:
      position: 102
      prefix: --radius
  - id: rdkit
    type:
      - 'null'
      - boolean
    doc: Generate RDKit fingerprints
    inputBinding:
      position: 102
      prefix: --rdkit
  - id: size
    type:
      - 'null'
      - int
    doc: Number of bits in the fingerprint
    inputBinding:
      position: 102
      prefix: --size
  - id: substructure
    type:
      - 'null'
      - boolean
    doc: Generate RDKit substructure fingerprints
    inputBinding:
      position: 102
      prefix: --substructure
  - id: torsions
    type:
      - 'null'
      - boolean
    doc: Generate Topological Torsion fingerprints
    inputBinding:
      position: 102
      prefix: --torsions
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Save the fingerprints to filename (default is stdout)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
