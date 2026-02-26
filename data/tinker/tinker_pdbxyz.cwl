cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinker_pdbxyz
label: tinker_pdbxyz
doc: "Tinker Software Tools for Molecular Design\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: protein_data_bank_file_name
    type: File
    doc: Enter Protein Data Bank File Name
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_pdbxyz.out
