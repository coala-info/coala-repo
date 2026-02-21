cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedCoverage
label: ucsc-bedcoverage
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a failed container build (no space left on device).\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedcoverage:482--h0b57e2e_0
stdout: ucsc-bedcoverage.out
