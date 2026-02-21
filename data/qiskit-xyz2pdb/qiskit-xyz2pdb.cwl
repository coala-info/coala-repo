cwlVersion: v1.2
class: CommandLineTool
baseCommand: qiskit-xyz2pdb
label: qiskit-xyz2pdb
doc: "A tool to convert XYZ molecular files to PDB format.\n\nTool homepage: https://github.com/thepineapplepirate/qiskit-xyz2pdb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qiskit-xyz2pdb:0.1.2--pyhca03a8a_0
stdout: qiskit-xyz2pdb.out
