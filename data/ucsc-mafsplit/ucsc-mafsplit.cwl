cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafSplit
label: ucsc-mafsplit
doc: "A tool to split MAF (Multiple Alignment Format) files. Note: The provided text
  contains container runtime errors and does not include the actual help documentation
  for the tool.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafsplit:482--h0b57e2e_0
stdout: ucsc-mafsplit.out
