cwlVersion: v1.2
class: CommandLineTool
baseCommand: sap
label: sap
doc: "Statistical Assignment Package (SAP) for phylogenetic assignment of DNA sequences.\n
  \nTool homepage: https://github.com/mathbio-nimr-mrc-ac-uk/SAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sap:1.1.3--h7b50bb2_5
stdout: sap.out
