cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafToBigMaf
label: ucsc-maftobigmaf
doc: "Convert MAF (Multiple Alignment Format) files to bigMaf format. Note: The provided
  help text contains a container execution error and does not list command-line arguments.\n
  \nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maftobigmaf:482--h0b57e2e_0
stdout: ucsc-maftobigmaf.out
