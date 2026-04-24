cwlVersion: v1.2
class: CommandLineTool
baseCommand: qiskit-xyz2pdb
label: qiskit-xyz2pdb
doc: "Convert a XYZ file from Qiskit output into a PDB file\n\nTool homepage: https://github.com/thepineapplepirate/qiskit-xyz2pdb"
inputs:
  - id: alpha_c_traces
    type:
      - 'null'
      - boolean
    doc: Add C(alpha) traces
    inputBinding:
      position: 101
      prefix: --alpha-c-traces
  - id: hetero_atoms
    type:
      - 'null'
      - boolean
    doc: Add hetero atoms
    inputBinding:
      position: 101
      prefix: --hetero-atoms
  - id: in_xyz
    type: File
    doc: Path to the XYZ input file from Qiskit output
    inputBinding:
      position: 101
      prefix: --in-xyz
  - id: out_folder
    type:
      - 'null'
      - Directory
    doc: Path to the output folder
    inputBinding:
      position: 101
      prefix: --out-folder
  - id: out_name
    type:
      - 'null'
      - string
    doc: Name of the output PDB file
    inputBinding:
      position: 101
      prefix: --out-name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qiskit-xyz2pdb:0.1.2--pyhca03a8a_0
stdout: qiskit-xyz2pdb.out
