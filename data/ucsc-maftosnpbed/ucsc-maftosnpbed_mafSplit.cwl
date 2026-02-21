cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafSplit
label: ucsc-maftosnpbed_mafSplit
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error messages related to fetching the OCI image.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maftosnpbed:482--h0b57e2e_0
stdout: ucsc-maftosnpbed_mafSplit.out
