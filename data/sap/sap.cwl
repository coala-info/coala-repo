cwlVersion: v1.2
class: CommandLineTool
baseCommand: sap
label: sap
doc: "Aligns two protein sequences and outputs the alignment in PDB format.\n\nTool
  homepage: https://github.com/mathbio-nimr-mrc-ac-uk/SAP"
inputs:
  - id: file1
    type: File
    doc: First PDB file
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: Second PDB file
    inputBinding:
      position: 2
  - id: one2one
    type: int
    doc: Integer value added to the diagonal. Any negative value selects the 
      default value of 1000.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sap:1.1.3--h7b50bb2_5
stdout: sap.out
