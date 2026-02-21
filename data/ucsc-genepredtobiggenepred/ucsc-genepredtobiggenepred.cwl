cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToBigGenePred
label: ucsc-genepredtobiggenepred
doc: "Convert genePred format files to bigGenePred format. Note: The provided input
  text appears to be a container runtime error log rather than the tool's help output.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtobiggenepred:482--h0b57e2e_0
stdout: ucsc-genepredtobiggenepred.out
